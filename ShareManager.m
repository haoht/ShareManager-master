//
//  ShareManager.m
//  213123
//
//  Created by liman on 15-1-7.
//  Copyright (c) 2015年 liman. All rights reserved.
//

#import "ShareManager.h"

@implementation ShareManager

#pragma mark - public methods
// GCD单例
+ (ShareManager *)sharedInstance
{
    static ShareManager *__singletion = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        __singletion = [[self alloc] init];
        
    });
    
    return __singletion;
}


- (void)shareWithType:(ShareType)shareType content:(NSString *)content container:(UIViewController *)controller authViewStyle:(SSAuthViewStyle)authViewStyle result:(void (^)(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end))block
{
    // 1. 开启网页授权开关, 打开网页登陆 (仅用于QQ空间)
    if (shareType == ShareTypeQQSpace) {
        //        id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
        //        [app setIsAllowWebAuthorize:YES];
    }
    
    // 2. 创建分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:nil
                                                image:nil
                                                title:nil
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    // 3. 创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPhoneContainerWithViewController:controller];
    
    // 4. 自定义第三方登录界面的弹出样式, 并隐藏"Powered by ShareSDK"
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:authViewStyle
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    [authOptions setPowerByHidden:YES];
    
    // 5. 显示分享菜单
    [ShareSDK showShareViewWithType:shareType
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:authOptions
                       shareOptions:nil
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
                                 // 处理最后的结果
                                 block(type, state, statusInfo, error, end);
                             }];
}

@end
