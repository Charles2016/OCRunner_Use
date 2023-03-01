//
//  AddNewPageVC.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/9/6.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "AddNewPageVC.h"
#import "AddNewVC.h"

@interface AddNewPageVC ()

@end

@implementation AddNewPageVC


#pragma mark - buttonActions
- (void)buttonAction:(UIButton *)button {
    AddNewVC *VC = [[AddNewVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

+ (void)showTip:(UIViewController *)VC {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = UIColor.blackColor;
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"ggggggggggggg热更改变";
    [VC.view addSubview:label];
    label.frame = CGRectMake((VC.view.frame.size.width - 280) / 2, 220, 280, 60);
}

@end
