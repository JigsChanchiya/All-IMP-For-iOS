//
//  ViewController.m
//  TwitterUtilityUsingOauth
//
//  Created by Jignesh on 18/05/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize txtTweet=_txtTweet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)onClickLogin:(id)sender
{
    if ([[TwitterUtility sharedObject]isLogin])
    {
        NSLog(@"Already Login With User :- %@",[[TwitterUtility sharedObject]getTwitterUserName]);
        //[[TwitterUtility sharedObject]sendMessage];
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Already Login With User :- %@",[[TwitterUtility sharedObject]getTwitterUserName]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        [alt release];
    }
    else{
        [[TwitterUtility sharedObject]LoginInTwitter:self withLoginBlock:^(BOOL success, NSError *error)
        {
            if (!error)
            {
                NSLog(@"Login Success with user :- %@",[[TwitterUtility sharedObject]getTwitterUserName]);
                UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Login Success with user :- %@",[[TwitterUtility sharedObject]getTwitterUserName]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alt show];
                [alt release];
            }
            else{
                NSLog(@"Error :- %@",error);
            }
        }];
    }
}

-(IBAction)onClickLogOut:(id)sender
{
    [[TwitterUtility sharedObject]logoutOfTwitter];
}

-(IBAction)onClickTweet:(id)sender
{
    if (self.txtTweet.text.length>0)
    {
        [[TwitterUtility sharedObject]tweetWithText:self.txtTweet.text withCompletionBlock:^(BOOL success, NSError *error) {
            if (!error) {
                NSLog(@"Tweet Succsess");
            }else{
                NSLog(@"Tweet Fail Error :- %@",error);
            }
        }];
    }
    else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter Text" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        [alt release];
    }
}

-(IBAction)onClickMsg2Friend:(id)sender
{
    if (self.txtTweet.text.length>0)
    {
        [[TwitterUtility sharedObject]sendDirectMsg:self.txtTweet.text toUser:@"JigsChanchiya" withCompletionBlock:^(BOOL success, NSError *error) {
            if (!error) {
                NSLog(@"Msg Succsess");
            }else{
                NSLog(@"Msg Fail Error :- %@",error);
            }
        }];
    }
    else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter Text" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        [alt release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
