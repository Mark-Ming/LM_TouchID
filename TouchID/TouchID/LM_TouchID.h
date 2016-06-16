//
//  LM_TouchID.h
//  TouchID
//
//  Created by CoderDoctorLee on 16/6/16.
//  Copyright © 2016年 CoderDoctorLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

@protocol LM_TouchID_Delegate <NSObject>
//必须实现的两个代理方法:
@required
/**
 *  @author CoderDoctorLee, 16-06-16 22:06:06
 *
 *  验证成功
 */
- (void)LM_TouchID_AuthorizeSuccess;
/**
 *  @author CoderDoctorLee, 16-06-16 22:06:41
 *
 *  验证失败
 */
- (void)LM_TouchID_AuthorizeFailure;

//选择实现的代理方法:
@optional

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:12
 *
 *  取消了验证（点击了取消）
 */
- (void)LM_TouchID_AuthorizeUserCancel;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:58
 *
 *  在TouchID对话框点击输入密码按钮
 */
- (void)LM_TouchID_AuthorizeUserFallBack;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:58
 *
 *   在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 */
- (void)LM_TouchID_AuthorizeSystemCancel;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:18
 *
 *  无法使用TouchID,设备没有设置密码
 */
- (void)LM_TouchID_AuthorizePasswordNotSet;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:15
 *
 *  没有录入TouchID,无法使用
 */
- (void)LM_TouchID_AuthorizeTouchIDNotSet;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:19
 *
 *  该设备的TouchID无效
 */
- (void)LM_TouchID_AuthorizeTouchIDNotAvailable;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:17
 *
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 */
- (void)LM_TouchID_AuthorizeTouchIDNotLockOut;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:47
 *
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 */
- (void)LM_TouchID_AuthorizeTouchIDAppCancel;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:45
 *
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 */
- (void)LM_TouchID_AuthorizeTouchIDInvalidContext;

/**
 *  @author CoderDoctorLee, 16-06-16 22:06:29
 *
 *  当前设备不支持指纹识别
 */
- (void)LM_TouchID_AuthorizeNotSupport;
@end

@interface LM_TouchID : LAContext
@property (nonatomic, assign) id<LM_TouchID_Delegate> delegate;
/**
 *  @author CoderDoctorLee, 16-06-16 22:06:51
 *
 *  发起指纹验证：
 */
- (void)startLM_TouchID_WithMessage:(NSString *)message FallBackTitle:(NSString *)fallBackTitle Delegate:(id<LM_TouchID_Delegate>)delegate;
@end
