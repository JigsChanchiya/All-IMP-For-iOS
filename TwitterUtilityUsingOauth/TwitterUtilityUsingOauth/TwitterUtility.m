//
//  OAuthTwitterDemoViewController.m
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import "TwitterUtility.h"
#import "SA_OAuthTwitterEngine.h"

#import <Twitter/Twitter.h>

#import "OAConsumer.h"
#import "OAToken.h"
#import "OAPlaintextSignatureProvider.h"


@implementation TwitterUtility

//https://api.twitter.com/1/statuses/followers/TWITTER_USERNAME.json

#pragma mark -
#pragma mark - Init And Shared Object

-(id) init
{
    if((self = [super init]))
    {
        //appDelegate=[CAppDelegate sharedDelegate];
    }
    return self;
}

+ (TwitterUtility *)sharedObject
{
    //appDelegate=[CAppDelegate sharedDelegate];
    static TwitterUtility *objTwitterUtility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objTwitterUtility = [[TwitterUtility alloc] init];
    });
    return objTwitterUtility;
}

//=============================================================================================================================
#pragma mark -
#pragma mark - SA_OAuthTwitterEngineDelegate

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username
{
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username
{
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

//=============================================================================================================================
#pragma mark -
#pragma mark - SA_OAuthTwitterControllerDelegate

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username
{
	//NSLog(@"Authenicated for %@", username);
    login(TRUE,nil);
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller
{
	//NSLog(@"Authentication Failed!");
    login(FALSE,[NSError errorWithDomain:@"TwitterLogin" code:69001 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Authentication Failed!",@"Info", nil]]);
    _engine=nil;
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller
{
	//NSLog(@"Authentication Canceled.");
    login(FALSE,[NSError errorWithDomain:@"TwitterLogin" code:69001 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Authentication Canceled.",@"Info", nil]]);
    _engine=nil;
}


#pragma mark -
#pragma mark - TwitterMethods

-(BOOL)isLogin
{
    BOOL isLogin=FALSE;
    UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
    if (!controller) {
        isLogin=TRUE;
    }
    return isLogin;
}

-(NSString *)getTwitterUserName
{
    if (!_engine)
    {
        return nil;
    }
    else{
        return _engine.username;
    }
}

- (void) LoginInTwitter:(UIViewController *)vcLogin withLoginBlock:(CompletionBlock)isLogin
{
	//if (_engine) return;
    login=[isLogin copy];
    
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller)
        [vcLogin presentViewController:controller animated:YES completion:^{
            
        }];
		//[vcLogin presentModalViewController: controller animated: YES];
    /*
	else {
		[_engine sendUpdate: [NSString stringWithFormat: @"Already Updated. %@", [NSDate date]]];
	}
     */
}

- (void)logoutOfTwitter
{
    [_engine release];
    _engine = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey: @"authData"];
}

-(void)tweetWithText:(NSString *)strTweet withCompletionBlock:(CompletionBlock)sendTweet
{
    login=[sendTweet copy];
    [_engine sendUpdate: strTweet];
    
}

-(void)sendDirectMsg:(NSString *)strMsg toUser:(NSString *)strUserName withCompletionBlock:(CompletionBlock)sendTweet
{
    login=[sendTweet copy];
    [_engine sendDirectMessage:strMsg to:strUserName];
}

//=============================================================================================================================
#pragma mark -
#pragma mark - TwitterEngineDelegate

- (void) requestSucceeded: (NSString *) requestIdentifier
{
	//NSLog(@"Request %@ succeeded", requestIdentifier);
    login(TRUE,nil);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error
{
	//NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
    login(FALSE,error);
}


//=============================================================================================================================

-(void)sendMessage
{
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:kOAuthConsumerKey
                                                    secret:kOAuthConsumerSecret];

    OAToken *accessToken = [[OAToken alloc]initWithKey:kOAuthConsumerKey secret:kOAuthConsumerSecret];
   
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/direct_messages/new.json"];
    
   //OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url];
    
   OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url
                                                                   consumer:consumer
                                                                      token:accessToken
                                                                      realm:nil
                                                          signatureProvider:[[OAPlaintextSignatureProvider alloc] init]];
   
    OARequestParameter *nameParam = [[OARequestParameter alloc] initWithName:@"text"
                                                                       value:@"Hi Dhaval"];
    OARequestParameter *descParam = [[OARequestParameter alloc] initWithName:@"screen_name" value:@"JigsChanchiya"];
    NSArray *params = [NSArray arrayWithObjects:nameParam, descParam, nil];
    [request setParameters:params];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(apiTicket:didFinishWithData:)
                  didFailSelector:@selector(apiTicket:didFailWithError:)];
}

- (void)apiTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
    
}



#pragma mark -
#pragma mark - Memory Mgmt

- (void)dealloc
{
	[_engine release];
    [super dealloc];
}

/*
 
 if(![_engine isAuthorized]){
 UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
 
 if (controller){
 [self presentModalViewController: controller animated: YES];
 }
 
 }
 
 
 if(_engine){
 [_engine sendUpdate:tweetContent];
 }
 */


/*
 
 0 down vote
 
 
 I use this tutorial for integreate twitter to iOS app link
 
 For logout I use next:
 
 [_engine clearAccessToken];
 
 _engine - this is instance of SA_OAuthTwitterEngine class.
 
 You can call this method on your IBAction method.
 
 Also need this method
 
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 [defaults removeObjectForKey:@"authData"];
 [defaults synchronize];
 
 
 */



@end
