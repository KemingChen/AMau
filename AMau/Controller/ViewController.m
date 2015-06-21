//
//  ViewController.m
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "ViewController.h"
#import "DraggableViewBackground.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view layoutIfNeeded];
    CGRect frame = self.mainContainer.frame;
    NSLog(@"%f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    DraggableViewBackground* draggableBackground = [[DraggableViewBackground alloc] initWithFrame:frame];
    [self.mainContainer addSubview:draggableBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
