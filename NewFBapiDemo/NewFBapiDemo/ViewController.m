//
//  ViewController.m
//  NewFBapiDemo
//
//  Created by Jignesh on 15/05/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import "ViewController.h"
#import "SBJSON.h"

#import "FriendVC.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[FacebookUtility sharedObject]isLogin]) {
        self.btnFriend.enabled=TRUE;
        
        [self.btnLogin setTitle:@"Logout" forState:UIControlStateNormal];
    }
    else{
        [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        self.btnFriend.enabled=FALSE;
    }
}

-(IBAction)onClickLogin:(id)sender
{
    if ([[FacebookUtility sharedObject]isLogin]) {
        
        [self onClickLogout:nil];
    }
    else{
        
        [[FacebookUtility sharedObject]getFBToken];
        [[FacebookUtility sharedObject]loginInFacebook:^(BOOL success, NSError *error) {
            if (!error) {
                NSLog(@"Login Succsess");
                [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
                self.btnFriend.enabled=TRUE;
            }
            else{
                NSLog(@"Error := %@",error);
            }
        }];
        
        
    }
    
    
}

-(IBAction)onClickLogout:(id)sender
{
    [[FacebookUtility sharedObject]logOutFromFacebook];
    
    self.btnFriend.enabled=FALSE;
    
    [self.btnLogin setTitle:@"Logout" forState:UIControlStateNormal];
    
}

-(IBAction)onClickWhoAmI:(id)sender
{
    [[FacebookUtility sharedObject]fetchMeWithFBCompletionBlock:^(id response, NSError *error) {
        if (!error) {
            NSLog(@"ME := %@",response);
        }
        else{
            NSLog(@"Error := %@",error);
        }
    }];
}

-(IBAction)onClickGetFriendList:(id)sender
{
    [[AppDelegate sharedAppDelegate]showHUDLoadingView:@"Getting Friends..."];
    
    [[FacebookUtility sharedObject]fetchFriendsWithFBFriendCompletionBlock:^(NSArray *friends, NSError *error) {
        [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
        if (!error) {
            NSLog(@"My Friends := %@",friends);
            
            FriendVC *vcFriend=[[FriendVC alloc]initWithNibName:@"FriendVC" bundle:nil];
            vcFriend.arrFriend=[[NSMutableArray alloc]initWithArray:friends];
            [self.navigationController pushViewController:vcFriend animated:YES];
            
        }
        else{
            NSLog(@"Error := %@",error);
        }
    }];
}

-(IBAction)onClickMePost:(id)sender
{
    [[FacebookUtility sharedObject]postOnMyFacebookWall:[self postWall] WithFBCompletionBlock:^(id response, NSError *error) {
        if (!error) {
            NSLog(@"Post on ME := %@",response);
        }
        else{
            NSLog(@"Error := %@",error);
        }
    }];
}

-(IBAction)onClickFriendPost:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"FRIEND_ID", @"to",
                                   @"",  @"message",
                                   @"Connect with me on SnipStamp to find out what you really want to know: What's Happening Tonight?", @"description",
                                   @"http://www.snipstamp.com", @"link",
                                   @"http://www.snipstamp.com", @"picture",
                                   nil];
    [[FacebookUtility sharedObject]postOnFriendFacebookWallWithDialog:params WithFBCompletionBlock:^(id response, NSError *error) {
        if (!error) {
            NSLog(@"Post on Friend := %@",response);
        }
        else{
             NSLog(@"Error := %@",error);
        }
    }];
}


-(NSMutableDictionary *)postWall
{
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Get Started",@"name",@"http://www.snipstamp.com",@"link", nil], nil];
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    NSString *strMessage=@"Testing snipstamp";
    NSString *venueImage=@"http://www.logisticinfotech.com/images/404web001.jpg";
    NSMutableDictionary* photosParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         venueImage,@"picture",
                                         strMessage,@"name",
                                         actionLinksStr, @"actions",
                                         @"http://www.snipstamp.com", @"link",
                                         actionLinksStr, @"actions",
                                         nil];
    return photosParams;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
