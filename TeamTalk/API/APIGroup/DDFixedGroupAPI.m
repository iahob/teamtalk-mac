//
//  DDFixedGroupAPI.m
//  Duoduo
//
//  Created by 独嘉 on 14-5-6.
//  Copyright (c) 2014年 zuoye. All rights reserved.
//

#import "DDFixedGroupAPI.h"
#import "MTGroupEntity.h"
#import "IMGroup.pbobjc.h"
#import "DataOutputStream+Addition.h"
@implementation DDFixedGroupAPI
/**
 *  请求超时时间
 *
 *  @return 超时时间
 */
- (int)requestTimeOutTimeInterval
{
    return 10;
}

/**
 *  请求的serviceID
 *
 *  @return 对应的serviceID
 */
- (int)requestServiceID
{
    return ServiceID_SidGroup;
}

/**
 *  请求返回的serviceID
 *
 *  @return 对应的serviceID
 */
- (int)responseServiceID
{
    return ServiceID_SidGroup;
}

/**
 *  请求的commendID
 *
 *  @return 对应的commendID
 */
- (int)requestCommendID
{
    return GroupCmdID_CidGroupNormalListRequest;
}

/**
 *  请求返回的commendID
 *
 *  @return 对应的commendID
 */
- (int)responseCommendID
{
    return GroupCmdID_CidGroupNormalListResponse;
}

/**
 *  解析数据的block
 *
 *  @return 解析数据的block
 */
- (Analysis)analysisReturnData
{
    Analysis analysis = (id)^(NSData* data)
    {
        IMNormalGroupListRsp *allGroupRsp = [IMNormalGroupListRsp parseFromData:data error:nil];
        NSMutableDictionary *groupIdAndVersion = [NSMutableDictionary new];
        NSMutableArray* groupList = [[NSMutableArray alloc] init];
        for (GroupVersionInfo *groupVersionInfo in allGroupRsp.groupVersionListArray) {
            NSString* groupId = [[NSNumber numberWithInt:groupVersionInfo.groupId] stringValue];
            NSString* version = [[NSNumber numberWithInt:groupVersionInfo.version] stringValue];
            NSMutableDictionary* groupVersion = [NSMutableDictionary dictionaryWithObjectsAndKeys:groupId,@"groupId",version,@"version",nil];
            [groupList addObject:groupVersion];
        }
        [groupIdAndVersion setObject:groupList forKey:@"groupVersionList"];
        return groupIdAndVersion;
    };
    return analysis;
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
        IMNormalGroupListReq *req = [IMNormalGroupListReq init];

        UInt32 reqUserId = [[(NSDictionary*)object objectForKey:@"reqUserId"] intValue];
        [req setUserId:reqUserId];
        DataOutputStream *dataout = [[DataOutputStream alloc] init];
        [dataout writeInt:0];
        [dataout writeTcpProtocolHeader:[self requestServiceID]
                                    cId:[self requestCommendID]
                                  seqNo:seqNo];
        [dataout directWriteBytes:req.data];
        [dataout writeDataCount];
        return [dataout toByteArray];
    };
    return package;
}
@end
