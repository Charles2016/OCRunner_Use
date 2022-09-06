//
//  AppDelegate+OCRunner.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/9/2.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "AppDelegate+OCRunner.h"
#import "ORInterpreter.h"
#import "AFNetworking.h"
#import <SSZipArchive.h>
#import "ORSystemFunctionPointerTable.h"

@implementation AppDelegate (OCRunner)

- (void)loadOCRunner {
    [ORSystemFunctionPointerTable reg:@"CGPointEqualToPoint" pointer:&CGPointEqualToPoint];
    [ORSystemFunctionPointerTable reg:@"CGSizeEqualToSize" pointer:&CGSizeEqualToSize];
#if 1
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
    NSURL *URL = [NSURL URLWithString:@"https://github.com/Charles2016/OCRunner_Use/raw/master/OCRunner_Use/binarypatch_Use.zip"];
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

@end
