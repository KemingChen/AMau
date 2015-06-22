//
//  FavoriteListViewController.m
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FavoriteTableViewCell.h"

@interface FavoriteTableViewController () {
    NSMutableArray* checkIns;
}

@end

@implementation FavoriteTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return checkIns.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* days = checkIns[section];
    return days.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentitier = @"FavoriteCell";
    FavoriteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentitier forIndexPath:indexPath];

    assert([cell isKindOfClass:[FavoriteTableViewCell class]]);

    //    NSArray* day = checkIns[indexPath.section];
    //    CheckIn* checkIn = day[indexPath.row];
    //    [cell setCheckIn:checkIn];

    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static FavoriteTableViewCell* cell = nil;

    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell"];
    }

    [cell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];

    //    NSArray* day = checkIns[indexPath.section];
    //    CheckIn* checkIn = day[indexPath.row];
    //    [cell setCheckIn:checkIn];

    [cell layoutIfNeeded];
    [tableView layoutIfNeeded];
    //    return cell.checkInImageView.frame.origin.y + cell.checkInImageView.frame.size.height;
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
    NSMutableArray* day = checkIns[indexPath.section];

    if (day.count > 1) {
        [day removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else {
        [checkIns removeObjectAtIndex:indexPath.section];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end