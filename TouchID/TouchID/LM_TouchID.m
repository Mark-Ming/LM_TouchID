//
//  LM_TouchID.m
//  TouchID
//
//  Created by CoderDoctorLee on 16/6/16.
//  Copyright © 2016年 CoderDoctorLee. All rights reserved.
//

#import "LM_TouchID.h"

@implementation LM_TouchID
- (void)startLM_TouchID_WithMessage:(NSString *)message FallBackTitle:(NSString *)fallBackTitle Delegate:(id<LM_TouchID_Delegate>)delegate
{
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = fallBackTitle;
    
    NSError *error = nil;
    self.delegate = delegate;
    //判断代理人是否为空
    if (self.delegate != nil) {
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //使用context对象对识别的情况进行评估
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message reply:^(BOOL success, NSError * _Nullable error) {
                //识别成功:
                if (success) {
                    if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeSuccess)]) {
                        //必须回到主线程执行,否则在更新UI时会出错！以下相同
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [self.delegate LM_TouchID_AuthorizeSuccess];
                        }];
                    }
                }
                //识别失败（对应代理方法的每种情况,不实现对应方法就没有反应）
                else if (error)
                {
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeFailure)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LM_TouchID_AuthorizeFailure];
                                }];
                            }
                            break;
                        }
                        case LAErrorUserCancel:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeUserCancel)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LM_TouchID_AuthorizeUserCancel];
                                }];
                            }
                            break;
                        }
                        case LAErrorUserFallback:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeUserFallBack)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LM_TouchID_AuthorizeUserFallBack];
                                }];
                            }
                            break;
                        }
                        case LAErrorSystemCancel:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeSystemCancel)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LM_TouchID_AuthorizeSystemCancel];
                                }];
                            }
                            break;
                        }
                        case LAErrorTouchIDNotEnrolled:
                        {
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeTouchIDNotSet)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LM_TouchID_AuthorizeTouchIDNotSet];
                                }];
                            }
                            break;
                        }
                        case LAErrorPasscodeNotSet:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizePasswordNotSet)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate LM_TouchID_AuthorizePasswordNotSet];
                                }];
                            }
                            break;
                        }
                        case LAErrorTouchIDNotAvailable:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeTouchIDNotAvailable)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    [self.delegate LM_TouchID_AuthorizeTouchIDNotAvailable];
                                }];
                            }
                            break;
                        }
                        case LAErrorTouchIDLockout:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeTouchIDNotLockOut)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    [self.delegate LM_TouchID_AuthorizeTouchIDNotLockOut];
                                }];
                            }
                            break;
                        }
                        case LAErrorAppCancel:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeTouchIDAppCancel)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    [self.delegate LM_TouchID_AuthorizeTouchIDAppCancel];
                                }];
                            }
                            break;
                        }
                        case LAErrorInvalidContext:{
                            if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeTouchIDInvalidContext)]) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    [self.delegate LM_TouchID_AuthorizeTouchIDInvalidContext];
                                }];
                            }
                            break;
                        }
                        default:
                            break;
                    }
                }
            }];
        }
    }
    //设备不支持指纹识别
    else
    {
        if ([self.delegate respondsToSelector:@selector(LM_TouchID_AuthorizeNotSupport)]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate LM_TouchID_AuthorizeNotSupport];
            }];
        }
    }
}
@end
