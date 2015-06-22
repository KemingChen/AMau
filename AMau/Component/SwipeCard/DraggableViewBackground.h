//
//  ViewController.h
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface DraggableViewBackground : UIView <DraggableViewDelegate>

@property (retain,nonatomic)NSMutableArray* items;
@property (retain,nonatomic)NSMutableArray* allCards;

- (void)swipeRight;
- (void)swipeLeft;

@end
