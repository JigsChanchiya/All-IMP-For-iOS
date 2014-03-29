//
//  OAuthTwitterDemoViewController.h
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterUtility.h"
#import "SA_OAuthTwitterController.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"

#define kOAuthConsumerKey				@"aMFYOywRs9TRF4EYNyx1pg"		//REPLACE ME
#define kOAuthConsumerSecret			@"5yDR66imhlQdsBcfeNkb6itqMgxQLZRUCIUqj9JAIs"		//REPLACE ME

@class SA_OAuthTwitterEngine;

typedef void (^CompletionBlock)(BOOL success, NSError *error);


@interface TwitterUtility : NSObject <SA_OAuthTwitterControllerDelegate>
{
	SA_OAuthTwitterEngine				*_engine;
    CompletionBlock login;
}

-(id) init;
+ (TwitterUtility *)sharedObject;

-(BOOL)isLogin;
-(NSString *)getTwitterUserName;
- (void) LoginInTwitter:(UIViewController *)vcLogin withLoginBlock:(CompletionBlock)isLogin;
- (void)logoutOfTwitter;

-(void)tweetWithText:(NSString *)strTweet withCompletionBlock:(CompletionBlock)sendTweet;
-(void)sendDirectMsg:(NSString *)strMsg toUser:(NSString *)strUserName withCompletionBlock:(CompletionBlock)sendTweet;

-(void)sendMessage;

@end

