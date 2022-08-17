//
//  DDSendP2PCmdAPI.m
//  Duoduo
//
//  Created by jianqing.du on 14-5-12.
//  Copyright (c) 2014年 zuoye. All rights reserved.
//

#import "DDSendP2PCmdAPI.h"
#import "IMBaseDefine.pbobjc.h"
#import "IMSwitchService.pbobjc.h"

@implementation DDSendP2PCmdAPI

#pragma public
+ (NSString*)contentFor:(int)serverID commandID:(int)commandID content:(NSString*)content
{
    //@"{\"CmdID\":\"5308417\",\"Content\":\"shakewindow\",\"ServiceID\":\"1\"}"
    NSString* theContent = [NSString stringWithFormat:@"{\"cmd_id\":%i,\"content\":\"%@\",\"service_id\":%i}",commandID,content,serverID];
    return theContent;
}

#pragma APIScheduleProtocol
/**
 *  请求超时时间
 *
 *  @return 超时时间
 */
- (int)requestTimeOutTimeInterval
{
    return 0;
}

/**
 *  请求的serviceID
 *
 *  @return 对应的serviceID
 */
- (int)requestServiceID
{
    return ServiceID_SidSwitchService;
}

/**
 *  请求返回的serviceID
 *
 *  @return 对应的serviceID
 */
- (int)responseServiceID
{
    return 0;
}

/**
 *  请求的commendID
 *
 *  @return 对应的commendID
 */
- (int)requestCommendID
{
    return SwitchServiceCmdID_CidSwitchP2PCmd;
}

/**
 *  请求返回的commendID
 *
 *  @return 对应的commendID
 */
- (int)responseCommendID
{
    return 0;
}

/**
 *  解析数据的block
 *
 *  @return 解析数据的block
 */
- (Analysis)analysisReturnData
{
    return nil;
}

/**
 *  打包数据的block
 *
 *  @return 打包数据的block
 */
- (Package)packageRequestObject
{
    Package package = (id)^(id object,uint16_t seqNo)
    {   
        IMP2PCmdMsg *req = [IMP2PCmdMsg init];
        NSArray* array = (NSArray*)object;
        NSString* fromId = array[0];
        NSString* toId = array[1];
        NSString* content = array[2];
        
        
        [req setFromUserId:[fromId intValue]];
        [req setToUserId:[toId intValue]];
        [req setCmdMsgData:content];
        
        
        DataOutputStream *dataout = [[DataOutputStream alloc] init];

        
        [dataout writeInt:0];
        [dataout writeTcpProtocolHeader:[self requestServiceID] cId:[self requestCommendID] seqNo:seqNo];
        [dataout directWriteBytes:req.data];
        [dataout writeDataCount];
        return [dataout toByteArray];
    };
    return package;
}

@end
