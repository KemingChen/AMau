//
//  CardView.m
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "CardView.h"

@implementation CardView

-(void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) {
        return;
    }
    
    _mode = mode;
    
    if(mode == GGOverlayViewModeLeft) {
        self.dislikeImageView.hidden = FALSE;
        self.likeImageView.hidden = TRUE;
    } else {
        self.dislikeImageView.hidden = TRUE;
        self.likeImageView.hidden = FALSE;
    }
}

@end
