//
//  ViewController.h
//  TwitterUtilityUsingOauth
//
//  Created by Jignesh on 18/05/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
}
@property(nonatomic,strong)IBOutlet UITextField *txtTweet;

-(IBAction)onClickLogin:(id)sender;
-(IBAction)onClickLogOut:(id)sender;
-(IBAction)onClickTweet:(id)sender;
-(IBAction)onClickMsg2Friend:(id)sender;

@end
