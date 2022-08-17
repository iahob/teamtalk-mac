//
//  DDReceiveGroupMemberChangedAPI.m
//  Duoduo
//
//  Created by 独嘉 on 15/2/2.
//  Copyright (c) 2015年 mogujie. All rights reserved.
//

#import "DDReceiveGroupMemberChangedAPI.h"
#import "IMBaseDefine.pbobjc.h"
#import "IMGroup.pbobjc.h"
#import "MTGroupModule.h"
#import "IMBaseDefine.pbobjc.h"

@implementation DDReceiveGroupMemberChangedAPI
/**
 *  数据包中的serviceID
 *
 *  @return serviceID
 */
- (int)responseServiceID
{
    return ServiceID_SidGroup;
}

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID
{
    return GroupCmdID_CidGroupChangeMemberNotify;
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
        IMGroupChangeMemberNotify *rsp = [IMGroupChangeMemberNotify parseFromData:data error:nil];
        
        NSString *groupId = [NSString stringWithFormat:@"%d", rsp.groupId];
        
        NSArray* currentUserIDs = rsp.curUserIdListArray;
        NSMutableArray* userIDs = [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < [currentUserIDs count]; index ++)
        {
            NSUInteger userIDint = [currentUserIDs[index] integerValue];
            NSString* userID = [NSString stringWithFormat:@"%li",userIDint];
            [userIDs addObject:userID];
        }
        NSDictionary* dic = @{@"groupID":groupId,@"userIDs":userIDs};
        
        return dic;

    };
    return analysis;
}
@end
