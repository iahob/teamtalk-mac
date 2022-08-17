//
//  DDReceiveOnlineUserListAPI.m
//  Duoduo
//
//  Created by 独嘉 on 14-5-8.
//  Copyright (c) 2014年 zuoye. All rights reserved.
//

#import "DDOnlineUserListAPI.h"
#import "IMBuddy.pbobjc.h"


@implementation DDOnlineUserListAPI

- (int)requestServiceID
{
    return ServiceID_SidBuddyList;
}

- (int)responseServiceID
{
    return ServiceID_SidBuddyList;
}

- (int)requestCommendID
{
    return BuddyListCmdID_CidBuddyListUsersStatusRequest;
}

- (int)responseCommendID
{
    return BuddyListCmdID_CidBuddyListUsersStatusResponse;
}

- (int)requestTimeOutTimeInterval
{
    return 10;
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
        IMUsersStatRsp *allUserStateRsp = [IMUsersStatRsp parseFromData:data error:nil];
        
        NSArray *usersStatList = allUserStateRsp.userStatListArray;
        
        return usersStatList;
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
    Package package = (id)^(id object,uint32_t seqNo)
    {
        IMUsersStatReq *reqBuilder =[IMUsersStatReq init];
        
        [reqBuilder setUserId:0];
        [reqBuilder setUserIdListArray:(NSArray *)object];
        
        DataOutputStream *dataout = [[DataOutputStream alloc] init];
        [dataout writeInt:0];
        [dataout writeTcpProtocolHeader:[self requestServiceID]
                                    cId:[self requestCommendID]
                                  seqNo:seqNo];
        [dataout directWriteBytes:reqBuilder.data];
        [dataout writeDataCount];
        return [dataout toByteArray];
    };
    return package;
}

@end
