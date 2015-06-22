//
//  CardModalView.h
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Amau.h"

@interface CardModalView : UIView

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
- (void)assignItem:(Amau*)aMau;

@end
