//
//  FavoriteListViewController.m
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FavoriteTableViewCell.h"
#import "DataProvider.h"
#import "Amau.h"
#import "CardModalView.h"

@interface FavoriteTableViewController () {
    NSMutableArray* likeItems;
    CardModalView* modelView;
}

@end

@implementation FavoriteTableViewController

static NSString* CellIdentitier = @"FavoriteTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    likeItems = [[DataProvider sharedProvider] likeItems];

    UINib* nib = [UINib nibWithNibName:CellIdentitier bundle:nil];
    [self.favoriteTable registerNib:nib forCellReuseIdentifier:CellIdentitier];
    [self setupModalView];
}

- (void)setupModalView
{
    modelView = [[CardModalView alloc] initWithFrame:self.view.frame];
    [modelView setHidden:YES];
    [self.view addSubview:modelView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickDeleteAllButton:(id)sender
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"刪除所有已存喜愛列表" message:@"您確定要刪除嗎？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        for (Amau* item in likeItems) {
            item.isLikeValue = FALSE;
        }
        [Amau save];
        [likeItems removeAllObjects];
        [self clickBackButton:nil];
    }
}

- (IBAction)clickBackButton:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                             }];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return likeItems.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    FavoriteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentitier forIndexPath:indexPath];
    [cell assignAMau:likeItems[indexPath.row]];

    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 100;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    Amau* aMau = likeItems[indexPath.row];
    aMau.isLikeValue = FALSE;
    [likeItems removeObject:aMau];
    [Amau save];
    [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    Amau* aMau = likeItems[indexPath.row];
    [modelView assignItem:aMau];
    [modelView setHidden:NO];
}

@end
