//
//  MTGroupChangeMember.m
//  Duoduo
//
//  Created by zuoye on 15/2/1.
//  Copyright (c) 2015年 mogujie. All rights reserved.
//

#import "MTGroupChangeMemberAPI.h"
#import "IMBaseDefine.pbobjc.h"
#import "IMGroup.pbobjc.h"
#import "MTGroupModule.h"
#import "IMBaseDefine.pbobjc.h"

@implementation MTGroupChangeMemberAPI

-(int) requestTimeOutTimeInterval{
    return 10;
}

-(int)requestServiceID{
    return ServiceID_SidGroup;
}

-(int)responseServiceID{
    return ServiceID_SidGroup;
}

-(int) requestCommendID{
    return GroupCmdID_CidGroupChangeMemberRequest;
}

-(int)responseCommendID{
    return GroupCmdID_CidGroupChangeMemberResponse;
}

-(Analysis) analysisReturnData{
    Analysis analysis = (id)^(NSData *data){
        /*
         required uint32 user_id = 1;
         required IM.BaseDefine.GroupModifyType change_type = 2;
         required uint32 result_code = 3;
         required uint32 group_id = 4;
         repeated uint32 cur_user_id_list = 5;			//现有的成员id
         repeated uint32 chg_user_id_list = 6;			//变动的成员id,add: 表示添加成功的id,   del: 表示删除的id
         optional bytes attach_data = 20;
         */
        IMGroupChangeMemberRsp *rsp = [IMGroupChangeMemberRsp parseFromData:data error:nil];
        
         uint32_t result = rsp.resultCode;
        if (result != 0)
        {
            return [NSDictionary dictionary];
        }
        
        NSString *groupId = [NSString stringWithFormat:@"%d", rsp.groupId];
        
        NSInteger userCnt =[rsp.curUserIdListArray count];
         NSMutableArray *newUserIds = [NSMutableArray new];
        for (uint32_t i = 0; i < userCnt; i++) {
            NSInteger userIdFromServer = [rsp.curUserIdListArray valueAtIndex:i];//[rsp.curUserIdList[i] integerValue];
            NSString* userId = [NSString stringWithFormat:@"%ld", userIdFromServer];
            [newUserIds addObject:userId];
        }
        NSDictionary* dic = @{@"groupID":groupId,@"userIDs":newUserIds};
        
        return dic;
    };
    
    return analysis;
}

-(Package)packageRequestObject{
    Package package = (id)^(id object,uint16_t seqNo){
        
        NSArray* array = (NSArray*)object;
        NSString* groupId = array[0];
        NSArray* userList = array[1];
        GroupModifyType type = [array[2] intValue]; //add 1,del 2.
        NSString *userId = array[3];
         DataOutputStream *dataout = [[DataOutputStream alloc] init];
        IMGroupChangeMemberReq *req = [IMGroupChangeMemberReq init];
        [req setUserId:[userId intValue]];
        [req setGroupId:[groupId intValue]];
        [req setChangeType:type];
        NSMutableArray *originalID = [NSMutableArray new];
        for (NSString *localID in userList) {
            int groupId = [localID intValue];
            [originalID addObject: @(groupId)];
        }
        
        [req setMemberIdListArray:originalID];
        
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
