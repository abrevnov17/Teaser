//
//  Teaser.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/11/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import "Teaser.h"

@class Teaser;

@implementation Teaser

/* CONNECTING TO REST API */

//users
+(void)getUsername:(NSString*)uid withCompletion:(completionString)username{
    //call our login php function in our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Users/getUsername.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           username(newStr);
           
    }];

}

//groups
+(void)getGroupTimestamp:(NSString*)groupUID withCompletion:(completionString)timestamp{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:groupUID forKey:@"group_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupTimestamp.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           timestamp(newStr);
           
       }];
}

+(void)getGroupNumMembers:(NSString*)groupUID withCompletion:(completionString)num{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:groupUID forKey:@"group_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupNumMembers.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           num(newStr);
           
       }];
}

+(void)getGroupName:(NSString*)groupUID withCompletion:(completionString)name{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:groupUID forKey:@"group_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupName.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           name(newStr);
           
       }];
}

+(void)getGroupDescription:(NSString*)groupUID withCompletion:(completionString)description{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:groupUID forKey:@"group_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupDescription.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           description(newStr);
           
       }];
}

+(void)getGroupAdminUID:(NSString*)groupUID withCompletion:(completionString)adminUID{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:groupUID forKey:@"group_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupAdminUid.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           adminUID(newStr);
           
       }];
}

+(void)aggregateGroups:(NSString *)uid withCompletion:(completionNSMutableArray)groupUIDS{
    //the mutable array we return inside the completion block
    
    NSMutableArray *returnValues = [[NSMutableArray alloc] init];
    
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"member_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/aggregateGroups.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSArray *components = [newStr componentsSeparatedByString: @":"];
           
           for (NSString *string in components){
               if (![string isEqualToString:@""]){
                   [returnValues addObject:string];
               }
           }
           
           groupUIDS(returnValues);
           
       }];
    
}

+(void)aggregateGroupMembers:(NSString*)groupUID withCompletion:(completionNSMutableArray)members{
    //the mutable array we return inside the completion block
    
    NSMutableArray *returnValues = [[NSMutableArray alloc] init];
    
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:groupUID forKey:@"group_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/aggregateGroupMembers.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSArray *components = [newStr componentsSeparatedByString: @":"];
           
           for (NSString *string in components){
               if (![string isEqualToString:@""]){
                   [returnValues addObject:string];
               }
           }
           
           members(returnValues);
           
       }];
}

+(void)createGroup:(NSString*)groupName withNumberOfMembers:(NSString *)num withDescription:(NSString *)description withAdminUID:(NSString *)adminUID withMembers:(NSMutableArray *)members withCompletion:(completionString)success{
    
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupName forKey:@"group_name"];
    [data setObject:num forKey:@"number_of_members"];
    [data setObject:description forKey:@"description"];
    [data setObject:adminUID forKey:@"admin_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/createGroup.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           if ([newStr containsString:@"success"]){
               //successfully
               NSArray *components = [newStr componentsSeparatedByString: @":"];

               NSString *groupUID = [components objectAtIndex:1];

               
               for (NSString *member in members){
                   
                   [self createGroupMember:groupUID withMemberUID:member withCompletion:^(NSString *success){
                       //added (hopefully...we verify below) a member to a group
                       if (![success containsString:@"success"]){
                           NSLog(@"There was a problem adding %@ to the group",member);
                       }
                   }];
                   
               }
               //now we need to add the admin (not included in the list of friends so must be done separately)
               
               [self createGroupMember:groupUID withMemberUID:adminUID withCompletion:^(NSString *success){
                   if (![success containsString:@"success"]){
                       NSLog(@"There was a problem adding the admin to the group");
                   }
               }];
               
               //now we need to set an initial problem for the group
               
               [self updateGroupCurrentProblem:groupUID withCompletion:^(NSString *success){
                   //we have set an initial problem for the group
               }];


               
               
           }
           
           success(newStr);
           
       }];
    
}

+(void)createGroupMember:(NSString*)groupUID withMemberUID:(NSString *)memberUID withCompletion:(completionString)success{
    
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupUID forKey:@"group_uid"];
    [data setObject:memberUID forKey:@"member_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/createGroupMember.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           success(newStr);
           
       }];

}

+(void)getGroupMemberLastAnsweredTimestamp:(NSString *)membershipUID withCompletion:(completionString)timestamp{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:membershipUID forKey:@"membership_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupMemberLastAnsweredTimestamp.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           timestamp(newStr);
           
       }];
    
}

+(void)getGroupMembershipIDFromGroupUIDAndMemberUID:(NSString *)uid withGroupUID:(NSString *)groupUID withCompletion:(completionString)membershipUID{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:uid forKey:@"uid"];
    [data setObject:groupUID forKey:@"group_uid"];

    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupMembershipIDFromGroupUIDAndMemberUID.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
           membershipUID(newStr);
           
       }];
}

+(void)getGroupCurrentProblemUID:(NSString*)groupUID withCompletion:(completionString)problemUID{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupUID forKey:@"group_uid"];
    
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupCurrentProblemUID.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           problemUID(newStr);
           
       }];
}

+(void)getGroupCurrentProblemTimestamp:(NSString*)groupUID withCompletion:(completionString)groupProblemTimestamp{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupUID forKey:@"group_uid"];
    
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupCurrentProblemTimestamp.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           groupProblemTimestamp(newStr);
           
       }];
}

+(void)updateGroupCurrentProblem:(NSString*)groupUID withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupUID forKey:@"group_uid"];
    
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/generateRandomCurrentProblemForGroup.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           success(newStr);
           
       }];

}

+(void)updateGroupCurrentProblemTimestamp:(NSString*)groupUID withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupUID forKey:@"group_uid"];
    
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/updateGroupTimestamp.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           success(newStr);
           
       }];
    

}

+(void)updateGroupMemberLastAnsweredTimestamp:(NSString*)uid withGroupUID:(NSString*)groupUID withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupUID forKey:@"group_uid"];
    [data setObject:uid forKey:@"uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/updateGroupMemberLastAnsweredTimestamp.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           success(newStr);
           
       }];
}

+(void)addToGroupMemberScore:(NSString*)uid withGroupUID:(NSString*)groupUID withScoreToAdd:(NSString *)scoreToAdd withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:groupUID forKey:@"group_uid"];
    [data setObject:uid forKey:@"uid"];
    [data setObject:scoreToAdd forKey:@"score_to_add"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/addToGroupMemberScore.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           success(newStr);
           
       }];
    
}

+(void)getGroupMemberScore:(NSString*)membershipUID withCompletion:(completionString)memberScore{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setObject:membershipUID forKey:@"membership_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Groups/getGroupMemberScore.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           memberScore(newStr);
           
       }];

}

//group requests
+(void)getRequestingGroupUserUID:(NSString*)requestUID withCompletion:(completionString)uid{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:requestUID forKey:@"request_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Group%20Requests/getRequestingGroupUserUID.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           uid(newStr);
           
       }];

}

+(void)getRequestingGroupUID:(NSString*)requestUID withCompletion:(completionString)uid{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:requestUID forKey:@"request_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Group%20Requests/getRequestingGroupUID.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           uid(newStr);
           
       }];
}

+(void)aggregateGroupRequests:(NSString*)uid withCompletion:(completionNSMutableArray)requests{
    //the mutable array we return inside the completion block
    
    NSMutableArray *returnValues = [[NSMutableArray alloc] init];
    
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Group%20Requests/aggregateGroupRequests.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSArray *components = [newStr componentsSeparatedByString: @":"];
           for (NSString *string in components){
               if (![string isEqualToString:@""]){
                   [returnValues addObject:string];
               }
           }
           
           requests(returnValues);
           
       }];
}

+(void)declineGroupRequest:(NSString*)requestUID withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:requestUID forKey:@"request_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Group%20Requests/declineGroupRequest.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           success(newStr);
           
       }];
}
+(void)acceptGroupRequest:(NSString*)uid withRequestUID:(NSString*)requestUID withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:requestUID forKey:@"request_uid"];
    [data setObject:uid forKey:@"uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Group%20Requests/acceptGroupRequest.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           success(newStr);
           
       }];
}

//friends
+(void)aggregateFriends:(NSString*)uid withCompletion:(completionNSMutableArray)friends{
    //the mutable array we return inside the completion block
    
    NSMutableArray *returnValues = [[NSMutableArray alloc] init];
    
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Friends/aggregateFriends.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSArray *components = [newStr componentsSeparatedByString: @":"];
           
           for (NSString *string in components){
               if (![string  isEqual: @""]){
                   [returnValues addObject:string];
               }
           }
           
           friends(returnValues);
           
       }];
}

//friend requests
+(void)aggregateFriendRequests:(NSString*)uid withCompletion:(completionNSMutableArray)requests{
    //the mutable array we return inside the completion block
    
    NSMutableArray *returnValues = [[NSMutableArray alloc] init];
    
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Friend%20Requests/aggregateFriendRequests.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSArray *components = [newStr componentsSeparatedByString: @":"];
           
           for (NSString *string in components){
               if (![string isEqualToString:@""]){
                   [returnValues addObject:string];
               }
           }
           
           requests(returnValues);
           
       }];
}

+(void)getRequestingFriendUserUID:(NSString*)requestUID withCompletion:(completionString)uid{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:requestUID forKey:@"request_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Friend%20Requests/getRequestingFriendUserUID.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           uid(newStr);
           
       }];
}

+(void)sendFriendRequest:(NSString*)uid withFriendUsername:(NSString*)username withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"uid"];
    [data setObject:username forKey:@"username"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Friend%20Requests/sendFriendRequest.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           success(newStr);
           
       }];

}

+(void)declineFriendRequest:(NSString*)requestUID withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:requestUID forKey:@"request_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Friend%20Requests/declineFriendRequest.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           success(newStr);
           
       }];

}
+(void)acceptFriendRequest:(NSString*)uid withRequestUID:(NSString*)requestUID withCompletion:(completionString)success{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:requestUID forKey:@"request_uid"];
    [data setObject:uid forKey:@"uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Friend%20Requests/acceptFriendRequest.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           success(newStr);
           
       }];
}

//authentication
+(void)login:(NSString*)username withPassword:(NSString *)password withCompletion:(completionString)success{
    //call our login php function in our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:username forKey:@"username"];
    [data setObject:password forKey:@"password"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Authentication/login.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           success(newStr);
       }];
}

+(void)createAccount:(NSString*)username withEmail:(NSString *)email withPassword:(NSString *)password withCompletion:(completionString)success{
    //call our createAccount function in our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:username forKey:@"username"];
    [data setObject:email forKey:@"email"];
    [data setObject:password forKey:@"password"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Authentication/createAccount.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           success(newStr);
           
       }];
    
}

+(void)getLastUID:(completionString)uid{
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];

    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/General%20Functions/getLastUID.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           uid(newStr);
           
       }];

}

//problems

+(void)getProblemIDForDifficulty:(NSString*)uid withDifficulty:(NSString*)difficulty withCompletion:(completionString)problemID{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:difficulty forKey:@"difficulty"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getProblemIDForDifficulty.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           problemID(newStr);
           
       }];

}

+(void)getProblemDifficultyRating:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)problemDifficulty{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getProblemDifficultyRating.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           problemDifficulty(newStr);
           
       }];

}

+(void)getProblemType:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)problemType{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getProblemType.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           problemType(newStr);
           
       }];
}

+(void)getProblemHeaderText:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)headerText{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getProblemHeaderText.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           headerText(newStr);
           
       }];
}

+(void)getProblemQuestionText:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)questionText{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getProblemQuestionText.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           questionText(newStr);
           
       }];
}

+(void)getProblemCorrectAnswer:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)correctAnswer{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getProblemCorrectAnswer.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           correctAnswer(newStr);
           
       }];
}

+(void)getProblemOptionA:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)optionA{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getOptionA.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           optionA(newStr);
           
       }];
}

+(void)getProblemOptionB:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)optionB{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getOptionB.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           optionB(newStr);
           
       }];
    
}

+(void)getProblemOptionC:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)optionC{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getOptionc.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           optionC(newStr);
           
       }];
}

+(void)getProblemOptionD:(NSString*)uid withProblemID:(NSString*)problemID withCompletion:(completionString)optionD{
    //interacting with our REST API
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:uid forKey:@"user_uid"];
    [data setObject:problemID forKey:@"problem_uid"];
    
    SVHTTPClient *request = [SVHTTPClient sharedClient];
    
    [request setBasicAuthWithUsername:nil password:nil];
    [request setSendParametersAsJSON:NO];
    
    [request POST:@"https://csweb.sidwell.edu/~student/abrevnov17/Teaser/Problems/getOptionD.php"
       parameters:data
       completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
           NSData *data = response;
           NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           optionD(newStr);
           
       }];
}

/* USER FUNCTIONS */

+(BOOL)isUserLoggedIn{
    
    //loading keychain values (if they exist) to determine whether the user is already logged in
    NSError *error = nil;
    
    [FDKeychain itemForKey: @"uid" forService: @"Teaser" error: &error];
    
    if (error){
        return NO;
    }
    
    return YES;
}

+(NSString *)getCurrentUserUID{
    //accessing keychain value
    NSError *error = nil;
    
    NSString *uid = [FDKeychain itemForKey: @"uid" forService: @"Teaser" error: &error];
    
    return uid;
}


@end
