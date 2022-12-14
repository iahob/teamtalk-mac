//
//  DDReceiveStateChangedAPI.m
//  Duoduo
//
//  Created by 独嘉 on 14-5-8.
//  Copyright (c) 2014年 zuoye. All rights reserved.
//

#import "DDReceiveStateChangedAPI.h"
#import "IMBuddy.pbobjc.h"
@implementation DDReceiveStateChangedAPI
/**
 *  数据包中的serviceID
 *
 *  @return serviceID
 */
- (int)responseServiceID
{
    return ServiceID_SidBuddyList;
}

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID
{
    return BuddyListCmdID_CidBuddyListStatusNotify;
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
        
        IMUserStatNotify *userstatNotify = [IMUserStatNotify parseFromData:data error:nil];
        return  userstatNotify.userStat;
    };
    return analysis;
}
@end
