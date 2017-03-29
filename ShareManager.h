//
//  ShareManager.h
//  213123
//
//  Created by liman on 15-1-7.
//  Copyright (c) 2015年 liman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface ShareManager : NSObject

// GCD单例
+ (ShareManager *)sharedInstance;

- (void)shareWithType:(ShareType)shareType content:(NSString *)content container:(UIViewController *)controller authViewStyle:(SSAuthViewStyle)authViewStyle result:(void (^)(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end))block;

@end
