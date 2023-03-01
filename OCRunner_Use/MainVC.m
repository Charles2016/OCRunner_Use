//
//  ViewController.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "MainVC.h"
#import "ChangeMethodVC.h"
#import "ChangeObjectVC.h"
#import "AddNewPageVC.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"热更菜单页面";
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    NSArray *titles = @[@"替换某个类的方法", @"修改某个类的方法中的某个对象的属性", @"添加新页面"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((self.view.frame.size.width - 280) / 2, 120 + i * 80, 280, 60);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = UIColor.redColor;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }    
}


#pragma mark - buttonActions
- (void)buttonAction:(UIButton *)button {
    if ([@"替换某个类的方法" isEqual:button.titleLabel.text]) {
        ChangeMethodVC *VC = [[ChangeMethodVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    
    if ([@"修改某个类的方法中的某个对象的属性" isEqual:button.titleLabel.text]) {
        ChangeObjectVC *VC = [[ChangeObjectVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    
    if ([@"添加新页面" isEqual:button.titleLabel.text]) {
        AddNewPageVC *VC = [[AddNewPageVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
}

@end
