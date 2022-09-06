//
//  ViewController3.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "ChangeMethodVC.h"
#import "Masonry.h"

@interface ChangeMethodVC ()

@end

@implementation ChangeMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    //若点击“替换某个类的方法测试”按钮进来显示这个页面的代码布局则热更失败
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"开始热更测试页面";
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 280) / 2, 120, 280, 60);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"替换某个类的方法测试" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.redColor;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"这个按钮的方法在这个页面是没有内容，点击不会有任何反映，若页面无变化则热更失败";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(self.view).offset(-100);
        make.height.equalTo(@100);
    }];
    
}

#pragma mark - buttonActions
- (void)buttonAction:(UIButton *)button {
    
}

@end
