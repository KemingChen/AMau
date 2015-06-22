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

@interface FavoriteTableViewController () {
    NSMutableArray* likeItems;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
