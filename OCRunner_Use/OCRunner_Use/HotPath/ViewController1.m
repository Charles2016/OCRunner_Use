//
//  ViewController1.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)setUI {
    self.view.backgroundColor = UIColor.lightGrayColor;
   //移除viewDidLoad的所有subview，然后添加新view
   [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
   UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
   button.frame = CGRectMake((self.view.frame.size.width - 120) / 2, 220, 120, 60);
   button.titleLabel.font = [UIFont systemFontOfSize:15];
   [button setTitle:@"第三页替换测试" forState:UIControlStateNormal];
   button.backgroundColor = UIColor.redColor;
   [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:button];
   
   
   UILabel *label = [[UILabel alloc]init];
   label.textColor = UIColor.blueColor;
   label.font = [UIFont systemFontOfSize:15];
   label.textAlignment = NSTextAlignmentCenter;
   label.text = @"这个页面是通过二进制热更改动原有的VC的setUI方法";
   label.numberOfLines = 0;
   [self.view addSubview:label];
   [label mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.centerY.equalTo(self.view);
       make.height.equalTo(@60);
       make.width.equalTo(self.view);
   }];
}

- (void)changeUI {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"此处测试ViewController3页面的changeUI热更效果";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.view);
       make.centerY.equalTo(self.view).offset(80);
       make.height.equalTo(@60);
       make.width.equalTo(self.view);
    }];
}

#pragma mark - buttonActions
- (void)buttonAction:(UIButton *)button {
    [button setTitle:@"测试成功" forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1), dispatch_get_main_queue(), ^{
        ViewController2 *vc = [[ViewController2 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

@end
