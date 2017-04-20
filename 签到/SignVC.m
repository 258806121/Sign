//
//  SignVC.m
//  签到
//
//  Created by HXM on 2017/4/19.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "SignVC.h"
#import "SigninView.h"

@interface SignVC ()

// 积分规则
@property (weak, nonatomic) IBOutlet UIButton *btnScoreRule;

// 点击签到按钮
@property (weak, nonatomic) IBOutlet UIButton *btnSign;

// 我的积分 50 
@property (weak, nonatomic) IBOutlet UILabel *lblMyScroe;

// 弹出视图
@property (strong, nonnull) SigninView *signView;

@end

@implementation SignVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"签到";
    self.navigationController.navigationBar.translucent = NO;
    
    // 积分规则按钮样式
    _btnScoreRule.layer.borderWidth = 0.5;
    _btnScoreRule.layer.borderColor = [UIColor colorWithRed:216/255.0 green:72/255.0 blue:0 alpha:1].CGColor;
    _btnScoreRule.layer.cornerRadius = 5;
    
    // 积分
    if (k_UD_score != nil) {
        _lblMyScroe.text = [[NSUserDefaults standardUserDefaults] objectForKey:k_UD_score];
    } else {
        _lblMyScroe.text = @"0";
    }
    
    // 判断用户是否签过到
    if (ApplicationDelegate.isSign) {
        [_btnSign setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        [_btnSign setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateDisabled];
        _btnSign.enabled = NO;
    } else {
        [_btnSign setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [_btnSign setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateDisabled];
        _btnSign.enabled = YES;
    }
}

// 积分规则按钮方法
- (IBAction)btnScoreRule:(id)
    sender
{
    NSLog(@"你点击了积分规则");
}

// 签到按钮的点击方法
- (IBAction)btnSign:(id)sender
{
    // 初始化
    self.signView = [SigninView signView];
    
    // 显示
    [_signView showInView:self.view];
    
    // 防止循环引用
    __weak typeof(self) ws = self;
    
    // block
    _signView.onClickBackgroundBlock = ^{
        [ws.navigationController popViewControllerAnimated:YES];
    };
    
    // 积分增加
    int score = [_lblMyScroe.text intValue];
    _lblMyScroe.text = [NSString stringWithFormat:@"%d",score+=5];
    
    // 改变按钮 背景  变为不可以点击
    [_btnSign setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [_btnSign setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateDisabled];
    _btnSign.enabled = NO;
    
    // 记录已经签过到
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:k_UD_isSign];
    
    // 积分
    [[NSUserDefaults standardUserDefaults] setObject:_lblMyScroe.text forKey:k_UD_score];
    
    // 同步
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
