//
//  ViewController1.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "ChangeMethodVC.h"
#import "AddNewVC.h"

@interface ChangeMethodVC ()

@end

@implementation ChangeMethodVC

- (void)setUI {
    self.view.backgroundColor = UIColor.lightGrayColor;
    //移除viewDidLoad的所有subview，然后添加新view
    //[self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 220) / 2, 180, 220, 60);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"替换setUI方法成功" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.redColor;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"通过热更，改动原有的VC的setUI方法！";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.centerY.equalTo(self.view);
       make.height.equalTo(@60);
       make.width.equalTo(self.view);
    }];
}

@end
