//
//  AddNewPageVC.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/9/6.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "AddNewPageVC.h"
#import "Masonry.h"

@interface AddNewPageVC ()

@end

@implementation AddNewPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    //若点击“添加新页面测试”按钮页面没有发生跳转则热更失败
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"热更添加新页面测试";
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 180) / 2, 120, 180, 60);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"添加新页面测试" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.redColor;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"点击按钮这个页面没有发生跳转则热更失败，若跳转到新页面，则说明热更成功！";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(self.view).offset(-100);
        make.height.equalTo(@200);
    }];
}

#pragma mark - buttonActions
- (void)buttonAction:(UIButton *)button {
    
}

@end
