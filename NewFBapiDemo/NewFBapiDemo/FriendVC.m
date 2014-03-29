//
//  FriendVC.m
//  NewFBapiDemo
//
//  Created by BMAC Info Tech on 13/09/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import "FriendVC.h"
#import "UIImageView+WebCache.h"
#import "FriendDetailVC.h"

@interface FriendVC ()

@end

@implementation FriendVC

@synthesize arrFriend;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Friend List";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark -
#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrFriend count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        
	}
    /*
     {
     id = 100005838221389;
     name = "Hardik Patel";
     picture =         {
     data =             {
     "is_silhouette" = 1;
     url = "https://fbcdn-profile-a.akamaihd.net/static-ak/rsrc.php/v2/yo/r/UlIqmHJn-SK.gif";
     };
     };
     */
    NSMutableDictionary *dict=[arrFriend objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[dict objectForKey:@"name"];
    
    NSMutableDictionary *dictPic=[dict objectForKey:@"picture"];
    NSMutableDictionary *dictdata=[dictPic objectForKey:@"data"];
    
    NSURL *url=[NSURL URLWithString:[dictdata objectForKey:@"url"]];
    [cell.imageView setImageWithURL:url];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tbl deselectRowAtIndexPath:indexPath animated:YES];
    
    FriendDetailVC *vcFriendDetail=[[FriendDetailVC alloc]initWithNibName:@"FriendDetailVC" bundle:nil];
    vcFriendDetail.friendData=[[NSMutableDictionary alloc]initWithDictionary:[arrFriend objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vcFriendDetail animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
