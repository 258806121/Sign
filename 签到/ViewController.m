//
//  ViewController.m
//  签到
//
//  Created by HXM on 2017/4/19.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "ViewController.h"
#import "SignVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)push:(id)sender
{
    SignVC *vc = [[SignVC alloc] initWithNibName:NSStringFromClass([SignVC class]) bundle:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

// 重置 帮助测试
- (IBAction)reset:(id)sender
{
    // 记录已经签过到
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:k_UD_isSign];
    
    // 积分
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:k_UD_score];
    
    // 同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
