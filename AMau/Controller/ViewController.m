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

    CGRect frame = self.baseCard.frame;
    DraggableViewBackground* draggableBackground = [[DraggableViewBackground alloc] initWithFrame:frame];
    [self.mainContainer addSubview:draggableBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
