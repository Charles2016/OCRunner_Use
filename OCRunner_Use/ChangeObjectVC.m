//
//  ChangeObjectVC.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/9/6.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "ChangeObjectVC.h"
#import "Masonry.h"

@interface ChangeObjectVC ()

@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation ChangeObjectVC

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
    [button setTitle:@"替换某个类的对象测试" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.redColor;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blueColor;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"这个label在这个页面显示则热更失败，替换类对象的测试显示其他内容，则说明热更成功！";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(self.view).offset(-100);
        make.height.equalTo(@200);
    }];
    self.tipLabel = label;
}

#pragma mark - buttonActions
- (void)buttonAction:(UIButton *)button {
    
}

@end
