//
//  DDReceiveMsgDataReadNotify.m
//  Duoduo
//
//  Created by zuoye on 15/2/4.
//  Copyright (c) 2015年 mogujie. All rights reserved.
//

#import "DDReceiveMsgDataReadNotifyAPI.h"
#import "IMBaseDefine.pbobjc.h"
#import "IMMessage.pbobjc.h"

@implementation DDReceiveMsgDataReadNotifyAPI

/**
 *  数据包中的serviceID
 *
 *  @return serviceID
 */
- (int)responseServiceID
{
    return ServiceID_SidMsg;
}

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID
{
    return MessageCmdID_CidMsgReadNotify;
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
        IMMsgDataReadNotify *msgRsp = [IMMsgDataReadNotify parseFromData:data error:nil];
        NSString *userId = [NSString stringWithFormat:@"%i",msgRsp.userId];
        NSString *sessionId = [NSString stringWithFormat:@"%i",msgRsp.sessionId];
        
        return @{
                 @"userId":userId,
                 @"sessionId":sessionId,
                 @"msgId":@(msgRsp.msgId),
                 @"sessionType":@(msgRsp.sessionType)};
    };
    return analysis;
}
@end
