>之前公司项目使用的是JSPatch老的版本做的热更(最新的要收费)，每次发布补丁的时候都要做改动方法或者类的OC代码转成JS代码的修正，头有点大，改个小bug调试起来也比较麻烦。于是想着能不能不通过JSCore下发的方式做热更呢，去github上面搜了一波，无意中找到了基于二进制热更的方案，配置好后不用再做代码的转换和翻译，直接生成二进制文件，当补丁用就把bug给修复了。

####先放下二进制热更的原理图
![二进制热更原理图.png](https://upload-images.jianshu.io/upload_images/1984312-c9225f34cecf273b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#####经过实践，我在本地和github下载的zip包都实现了代码更新的效果，新手接入的时候有几个注意的地方：
1.将OCRunner Pod下来
```
pod 'OCRunner'      #支持所有架构，包含libffi.a
# 或者
pod 'OCRunnerArm64' #仅支持 arm64和arm64e，没有libffi.a
```
2.在项目中添加需要热更的文件夹HotPath，把热更的资源放到这个文件夹下。在demo中我将这个库弄成一个模块OCRunnerLib，以AppDelegate+OCRunner分类的形式引入了，方便管理。

![添加脚本.png](https://upload-images.jianshu.io/upload_images/1984312-2714d2814fbcb6f2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

3.添加HotPath目录下资源生成binarypatch二进制文件和jsonpatch的脚本，对应改下项目名，并添加存放内联函数、预编译函数、C函数的转义，否则会出现不支持OC的一些属性设置和系统函数方法的Scripts.bundle，具体可以看下GCDRefrences和UIKitRefrences，对应自己项目用到的少哪个加哪个就行。
###PatchGeneratorBinary
```
$SRCROOT/OCRunner_Use/PatchGenerator -files $SRCROOT/OCRunner_Use/HotPath -refs  $SRCROOT/OCRunner_Use/Scripts.bundle -output $SRCROOT/OCRunner_Use/binarypatch
```
###PatchGeneratorJson
```
$SRCROOT/OCRunner_Use/PatchGenerator -files $SRCROOT/OCRunner_Use/HotPath -refs  $SRCROOT/OCRunner_Use/Scripts.bundle -output $SRCROOT/OCRunner_Use/jsonpatch -type json
```
![添加脚本.png](https://upload-images.jianshu.io/upload_images/1984312-31815f98c059bf5d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



4.对项目热更的VC做改动，想改哪个类就把类名设置一样即可，这里作者没有说明，我也是自己摸索好长时间才知道规律的。想改哪个方法重写就可以了，可新增类，也可修改原有类。```注意，新增类要把这个.m文件加到build phases->compile sources中，否则识别不到类中的方法出现闪退的情况，而修改的类不用，否则编译器会报错。```

![新增的类.png](https://upload-images.jianshu.io/upload_images/1984312-299cd426992ffa91.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5.build成功后把binarypatch二进制上传服务器，app加载二进制热更。以下是我在demo中做的本地和服务器(我没有服务器就用上传github的zip下载做了)。测试一波完成了HotPath改动的更新，不用再做代码的转换，对coder更友好了。
```
- (void)loadOCRunner {
    [ORSystemFunctionPointerTable reg:@"CGPointEqualToPoint" pointer:&CGPointEqualToPoint];
    [ORSystemFunctionPointerTable reg:@"CGSizeEqualToSize" pointer:&CGSizeEqualToSize];
#if 0
    NSString *finalPath = [[NSBundle mainBundle] pathForResource:@"binarypatch" ofType:nil];
    [ORInterpreter excuteBinaryPatchFile:finalPath];
#else
    //若补丁已经下载好并解压了，就读取本地的补丁，避免每次都去下载新的补丁
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSString *finalPath = [[documentsDirectoryURL.absoluteString stringByAppendingPathComponent:@"binarypatch"] stringByReplacingOccurrencesOfString:@"file:" withString:@""];
    if ([[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        [ORInterpreter excuteBinaryPatchFile:finalPath];
        return;
    }
    //创建信号量，保证先把补丁包下载下来再进入主页面，若补丁包大的话，可以考虑不阻塞主线程，给予等待loding显示
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSURL *URL = [NSURL URLWithString:@"https://github.com/Charles2016/OCRunner_Use/raw/master/OCRunner_Use/OCRunnerLib/ConfigPath/binarypatch_Use.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        NSString *filePathStr = filePath.relativePath;
        NSString *toPath = [filePathStr stringByDeletingLastPathComponent];
        NSString *finalPath = [NSString stringWithFormat:@"%@/binarypatch", toPath];
        //先移除已存在的解压包，以防解压过后的文件干扰到，取不到最新的二进制文件
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:finalPath]) {
            [fileManager removeItemAtPath:finalPath error:nil];
        }
        [SSZipArchive unzipFileAtPath:filePathStr toDestination:toPath progressHandler:nil completionHandler:^(NSString *path, BOOL succeeded, NSError *error) {
           NSLog(@"File unzip to: %@", finalPath);
            [ORInterpreter excuteBinaryPatchFile:finalPath];
            dispatch_semaphore_signal(semaphore);
        }];
    }];
    [downloadTask resume];
    //信号量等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
#endif
}
```

以上就是二进制热更的实践了，测试起来感觉还不错。服务器下载zip的话可以与后台协商，觉得可以弄个灰度下发之类的操作，版本号相关配置判断，想让哪台手机哪个版本更新都可以了，看作者说明是可以过App Store的审核，没有具体上传过，需要进一步验证，希望能帮到你。[本篇GitHubDemo](https://github.com/Charles2016/OCRunner_Use)传送阵在此。
感谢作者[@SilverFruity/OCRunner](https://github.com/SilverFruity/OCRunner)的开源封装。


