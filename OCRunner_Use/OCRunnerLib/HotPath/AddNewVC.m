//
//  ViewController2.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "AddNewVC.h"
#import "Masonry.h"

@interface AddNewVC ()

@end

@implementation AddNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"这是通过热更新增的页面";
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"通过热更，添加了AddNewVC这个页面！";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.height.equalTo(@60);
        make.width.equalTo(self.view).offset(-100);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"222.png"]];
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(50);
        make.width.height.equalTo(@88);
    }];
}

@end
