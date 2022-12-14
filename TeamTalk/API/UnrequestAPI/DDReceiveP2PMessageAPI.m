//
//  DDReceiveP2PMessageAPI.m
//  Duoduo
//
//  Created by 独嘉 on 14-5-12.
//  Copyright (c) 2014年 zuoye. All rights reserved.
//

#import "DDReceiveP2PMessageAPI.h"
#import "IMBaseDefine.pbobjc.h"
#import "IMSwitchService.pbobjc.h"

@implementation DDReceiveP2PMessageAPI
/**
 *  数据包中的serviceID
 *
 *  @return serviceID
 */
- (int)responseServiceID
{
    return ServiceID_SidSwitchService;
}

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID
{
    return SwitchServiceCmdID_CidSwitchP2PCmd;
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
        IMP2PCmdMsg *msgRsp = [IMP2PCmdMsg parseFromData:data error:nil];

        NSString *fromUserId = [NSString stringWithFormat:@"%i",msgRsp.fromUserId];
        NSString *toId = [NSString stringWithFormat:@"%i",msgRsp.toUserId];
        NSString *content = [msgRsp cmdMsgData];
        
        return @{
                 @"fromUserID":fromUserId,
                 @"toUserId":toId,
                 @"content":content};
    };
    return analysis;
}

@end
