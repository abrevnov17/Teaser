//
//  Teaser.h
//  Teaser
//
//  Created by Anatoly Brevnov on 5/11/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVHTTPRequest.h"
#import "FDKeychain.h"

static @interface Teaser : NSObject

/* CONNECTING TO REST API */

//creating our completion blocks
typedef void(^completionString)(NSString *);
typedef void(^completionNSMutableArray)(NSMutableArray *);


//users
+(void)getUsername:(NSString*)uid withCompletion:(completionString)username;


//groups
+(void)getGroupTimestamp:(NSString*)groupUID withCompletion:(completionString)timestamp;
+(void)getGroupNumMembers:(NSString*)groupUID withCompletion:(completionString)num;
+(void)getGroupName:(NSString*)groupUID withCompletion:(completionString)name;
+(void)getGroupDescription:(NSString*)groupUID withCompletion:(completionString)description;
+(void)getGroupAdminUID:(NSString*)groupUID withCompletion:(completionString)adminUID;
+(void)aggregateGroups:(NSString*)uid withCompletion:(completionNSMutableArray)groupUIDS;
+(void)aggregateGroupMembers:(NSString*)groupUID withCompletion:(completionNSMutableArray)members;
+(void)createGroup:(NSString*)groupName withNumberOfMembers:(NSString *)num withDescription:(NSString *)description withAdminUID:(NSString *)adminUID withMembers:(NSMutableArray *)members withCompletion:(completionString)success;
+(void)createGroupMember:(NSString*)groupUID withMemberUID:(NSString *)memberUID withCompletion:(completionString)success;

//group requests
+(void)getRequestingGroupUserUID:(NSString*)requestUID withCompletion:(completionString)uid;
+(void)getRequestingGroupUID:(NSString*)requestUID withCompletion:(completionString)uid;
+(void)aggregateGroupRequests:(NSString*)uid withCompletion:(completionNSMutableArray)requests;

//friends
+(void)aggregateFriends:(NSString*)uid withCompletion:(completionNSMutableArray)friends;
+(void)sendFriendRequest:(NSString*)uid withFriendUsername:(NSString*)username withCompletion:(completionString)success;

//friend requests
+(void)aggregateFriendRequests:(NSString*)uid withCompletion:(completionNSMutableArray)requests;
+(void)getRequestingFriendUserUID:(NSString*)requestUID withCompletion:(completionString)uid;

//authentication
+(void)login:(NSString*)username withPassword:(NSString *)password withCompletion:(completionString)success;
+(void)createAccount:(NSString*)username withEmail:(NSString *)email withPassword:(NSString *)password withCompletion:(completionString)success;

//general functions

+(void)getLastUID:(completionString)uid;

/* USER FUNCTIONS */

+(BOOL)isUserLoggedIn;
+(NSString *)getCurrentUserUID;

@end
