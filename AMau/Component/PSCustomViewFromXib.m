//
//  PSCustomViewFromXib.m
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "PSCustomViewFromXib.h"

@implementation PSCustomViewFromXib

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. Load the .xib file .xib file must match classname
        NSString* className = NSStringFromClass([self class]);
        
        self = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        self.frame = frame;
    }
    return self;
}

//- (id)initWithCoder:(NSCoder*)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//
//        // 1. Load .xib file
//        NSString* className = NSStringFromClass([self class]);
//        _customView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
//
//        // 2. Add as a subview
//        [self addSubview:_customView];
//    }
//    return self;
//}

@end
