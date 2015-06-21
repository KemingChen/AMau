//
//  ViewController.m
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "ViewController.h"
#import "DraggableViewBackground.h"

@interface ViewController () {
    DraggableViewBackground* draggableBackground;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view layoutIfNeeded];
    CGRect frame = self.mainContainer.frame;
    draggableBackground = [[DraggableViewBackground alloc] initWithFrame:frame];
    [self.mainContainer addSubview:draggableBackground];
    [self.mainContainer bringSubviewToFront:self.likeButton];
    [self.mainContainer bringSubviewToFront:self.dislikeButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickFavoriteListButton:(id)sender
{
    NSLog(@"Favorite");
}

- (IBAction)clickLikeButton:(id)sender
{
    [draggableBackground swipeRight];
}

- (IBAction)clickDislikeButton:(id)sender
{
    [draggableBackground swipeLeft];
}

@end
