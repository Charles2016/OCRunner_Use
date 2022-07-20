//
//  ViewController3.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "ViewController3.h"
#import "Masonry.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self changeUI];
}

- (void)setUI {
    //若显示这个页面的代码布局则热更失败，已经在ViewController1中替换了此类的viewDidLoad，因此不会加载到本VC的viewDidLoad方法
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"开始热更测试页面";
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 120) / 2, 120, 120, 60);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"第三页点击" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.redColor;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"这个页面点击按钮后，开始测试热更，若页面无变化则热更失败";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(self.view).offset(-100);
        make.height.equalTo(@100);
    }];
}

- (void)changeUI {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"这个页面点击按钮后，开始changeUI";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(80);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
}

#pragma mark - buttonActions
- (void)buttonAction:(UIButton *)button {
    
}

@end
