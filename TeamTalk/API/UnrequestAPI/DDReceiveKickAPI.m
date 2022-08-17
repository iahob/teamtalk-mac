//
//  DDReceiveKickAPI.m
//  Duoduo
//
//  Created by 独嘉 on 14-5-8.
//  Copyright (c) 2014年 zuoye. All rights reserved.
//

#import "DDReceiveKickAPI.h"
#import "IMLogin.pbobjc.h"
@implementation DDReceiveKickAPI
/**
 *  数据包中的serviceID
 *
 *  @return serviceID
 */
- (int)responseServiceID
{
    return ServiceID_SidLogin;
}

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID
{
    return LoginCmdID_CidLoginKickUser;
}

/**
 *  解析数据包
 *
 *  @return 解析数据包的block
 */
- (UnrequestAPIAnalysis)unrequestAnalysis
{
    UnrequestAPIAnalysis analysis = (id)^(NSData* data)
    {
        IMKickUser* kickUserNotify = [IMKickUser parseFromData:data error:nil];
        NSString* userID = [NSString stringWithFormat:@"%i",kickUserNotify.userId];
        if ([userID isEqualToString:[DDClientState shareInstance].userID])
        {
            KickReasonType reason = kickUserNotify.kickReason;
            return @(reason);
        }
        else
        {
            return @(100);
        }
    };
    return analysis;
}
@end
