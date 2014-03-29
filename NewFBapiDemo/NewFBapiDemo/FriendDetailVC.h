//
//  FriendDetailVC.h
//  NewFBapiDemo
//
//  Created by BMAC Info Tech on 13/09/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *arrComments;
    NSMutableDictionary *friendData;
    NSString *strPostID;
}
@property(nonatomic,retain)NSMutableArray *arrComments;
@property(nonatomic,retain)NSMutableDictionary *friendData;
@property(nonatomic,strong)IBOutlet UITableView *tbl;
@property(nonatomic,strong)IBOutlet UIImageView *img;

@property(nonatomic,strong)IBOutlet UIView *viewFooter;
@property(nonatomic,strong)IBOutlet UITextField *txtComment;


-(IBAction)onClickSend:(id)sender;

@end
