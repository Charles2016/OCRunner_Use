//
//  AppDelegate.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ORInterpreter.h"
#import "AFNetworking.h"
#import <SSZipArchive.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if 0
    NSString *patchFilePath = [[NSBundle mainBundle] pathForResource:@"binarypatch" ofType:nil];
    [ORInterpreter excuteBinaryPatchFile:patchFilePath];
    [self showVC];
#else
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:@"https://github.com/Charles2016/OCRunner_Use/raw/master/OCRunner_Use/binarypatch_Use.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
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
           [self showVC];
        }];
    }];
    [downloadTask resume];
#endif
    return YES;
}

- (void)showVC {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}


@end
