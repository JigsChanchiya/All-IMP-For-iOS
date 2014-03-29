//
//  ViewController.h
//  NewFBapiDemo
//
//  Created by Jignesh on 15/05/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
}
@property(nonatomic,strong)IBOutlet UIButton *btnLogin;
@property(nonatomic,strong)IBOutlet UIButton *btnFriend;


-(IBAction)onClickLogin:(id)sender;
-(IBAction)onClickLogout:(id)sender;

-(IBAction)onClickGetFriendList:(id)sender;

-(IBAction)onClickWhoAmI:(id)sender;



-(IBAction)onClickFriendPost:(id)sender;
-(IBAction)onClickMePost:(id)sender;
@end
