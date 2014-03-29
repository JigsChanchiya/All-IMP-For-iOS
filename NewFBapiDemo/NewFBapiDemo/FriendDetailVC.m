//
//  FriendDetailVC.m
//  NewFBapiDemo
//
//  Created by BMAC Info Tech on 13/09/13.
//  Copyright (c) 2013 Jignesh. All rights reserved.
//

#import "FriendDetailVC.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

@interface FriendDetailVC ()

@end

@implementation FriendDetailVC

@synthesize arrComments,friendData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tbl.tableFooterView=self.viewFooter;
    
    arrComments=[[NSMutableArray alloc]init];
    
    self.title=[friendData objectForKey:@"name"];
    NSString *strID=[friendData objectForKey:@"id"];
    
    //http://graph.facebook.com/friendid/picture?type=large
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",strID]];
    [self.img setImageWithURL:url];
    
    [[AppDelegate sharedAppDelegate]showHUDLoadingView:@"Featching Comments"];
    
    [[FacebookUtility sharedObject]getFriendProfilePicID:strID WithCompltionBlock:^(id response, NSError *error) {
        if (response) {
            NSString *strUrl=[response objectForKey:@"url"];
            
            NSString *strLast=[[strUrl componentsSeparatedByString:@"/"] lastObject];
            NSArray *arr=[strLast componentsSeparatedByString:@"_"];
            if ([arr count]>1) {
                strPostID=[arr objectAtIndex:1];
                [strPostID retain];
                NSLog(@"Object ID = %@",strPostID);
                
                [[FacebookUtility sharedObject] getCommentsOfPost:strPostID WithCompletionBlock:^(NSArray *friends, NSError *error) {
                    [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
                    if (!error) {
                        NSLog(@"Comments : %@",friends);
                        [arrComments removeAllObjects];
                        [arrComments addObjectsFromArray:friends];
                        [self.tbl reloadData];
                    }
                    else{
                        NSLog(@"Error : %@",error);
                    };
                }];
            }
            else{
                [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
            }
        }
        else{
            [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
        }
    }];
}

-(void)ReloadTableView
{
    NSString *strID=[friendData objectForKey:@"id"];
    [[FacebookUtility sharedObject]getFriendProfilePicID:strID WithCompltionBlock:^(id response, NSError *error) {
        if (response) {
            NSString *strUrl=[response objectForKey:@"url"];
            
            NSString *strLast=[[strUrl componentsSeparatedByString:@"/"] lastObject];
            NSArray *arr=[strLast componentsSeparatedByString:@"_"];
            if ([arr count]>1) {
                strPostID=[arr objectAtIndex:1];
                [strPostID retain];
                NSLog(@"Object ID = %@",strPostID);
                
                [[FacebookUtility sharedObject] getCommentsOfPost:strPostID WithCompletionBlock:^(NSArray *friends, NSError *error) {
                    [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
                    if (!error) {
                        NSLog(@"Comments : %@",friends);
                        [arrComments removeAllObjects];
                        [arrComments addObjectsFromArray:friends];
                        [self.tbl reloadData];
                    }
                    else{
                        NSLog(@"Error : %@",error);
                    };
                }];
            }
            else{
                [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
            }
        }
        else{
            [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
        }
    }];
}

#pragma mark -
#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrComments count];
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]autorelease];
        
	}
    
    /*
     {
     "from": {
     "name": "Sagar Sojitra",
     "id": "100000579867330"
     },
     "message": "hmmmmmmm..........",
     "id": "579358758758191_1931701"
     },
     
     */

    NSMutableDictionary *dict=[arrComments objectAtIndex:indexPath.row];
    NSMutableDictionary *dictFrom=[dict objectForKey:@"from"];
    cell.textLabel.text=[dictFrom objectForKey:@"name"];
    cell.detailTextLabel.text=[dict objectForKey:@"message"];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tbl deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)onClickSend:(id)sender
{
    [self.txtComment resignFirstResponder];
    if (self.txtComment.text.length>0) {
        [[AppDelegate sharedAppDelegate]showHUDLoadingView:@"Sending Comments"];
        [[FacebookUtility sharedObject] sendCommentsOfPost:strPostID andMsg:self.txtComment.text WithCompletionBlock:^(id response, NSError *error) {
            if (!error) {
                NSLog(@"response :- %@",response);
                [self ReloadTableView];
            }
            else{
                NSLog(@"Error :- %@",error);
                [[AppDelegate sharedAppDelegate]hideHUDLoadingView];
            }
        }];
    }
    else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter comment" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alt show];
        [alt release];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat calculatedPosY = self.tbl.contentSize.height-200; // do you own calculation of where you'd like it.
    [UIView animateWithDuration:0.2
                     animations:^{self.tbl.contentOffset = CGPointMake(0.0, calculatedPosY);}
                     completion:^(BOOL finished){ }];
}

/*
 CGFloat calculatedPosY = 50 * rowHeight // do you own calculation of where you'd like it.
 [UIView animateWithDuration:0.2
 animations:^{theTableview.contentOffset = CGPointMake(0.0, calculatedPosY);}
 completion:^(BOOL finished){ }];
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
