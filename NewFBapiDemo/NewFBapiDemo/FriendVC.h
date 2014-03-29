//
//  FriendVC.h
//  NewFBapiDemo
//
//  Created by BMAC Info Tech on 13/09/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrFriend;
}
@property(nonatomic,retain)NSMutableArray *arrFriend;
@property(nonatomic,strong)IBOutlet UITableView *tbl;


@end
