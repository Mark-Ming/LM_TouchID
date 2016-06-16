//
//  ViewController.m
//  TouchID
//
//  Created by CoderDoctorLee on 16/6/16.
//  Copyright © 2016年 CoderDoctorLee. All rights reserved.
//

#import "ViewController.h"
#import "LM_TouchID.h"
@interface ViewController ()<LM_TouchID_Delegate>
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property(nonatomic, strong)LM_TouchID *touchID;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.touchID = [[LM_TouchID alloc] init];
    [_touchID startLM_TouchID_WithMessage:@"CoderLee请你验证指纹" FallBackTitle:@"" Delegate:self];
}
- (void)LM_TouchID_AuthorizeSuccess
{
    self.msgLabel.text = @"验证成功";
}
- (void)LM_TouchID_AuthorizeFailure
{
    self.msgLabel.text = @"验证失败";
}
- (void)LM_TouchID_AuthorizeNotSupport
{
    self.msgLabel.text = @"设备不支持";
}
-(void)LM_TouchID_AuthorizeUserCancel
{
    self.msgLabel.text = @"用户点击了取消";
}
//其他代理方法均为可选则实现，希望大家试验一下
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
