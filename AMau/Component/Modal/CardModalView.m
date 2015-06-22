//
//  CardModalView.m
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "CardModalView.h"
#import "CardView.h"

@implementation CardModalView {
    CardView* cardView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CardModalView" owner:self options:nil] firstObject];
        self.frame = frame;

        [self setupCardView];
    }
    return self;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSArray* touchesArray = [touches allObjects];
    for (int i = 0; i < [touchesArray count]; i++) {
        UITouch* touch = [[event allTouches] anyObject];
        if (CGRectEqualToRect(self.frame, touch.view.frame)) {
            self.hidden = YES;
        }
    }
}

- (void)setupCardView
{
    CGFloat topPadding = 100;
    CGFloat bottomPadding = 100;
    CGFloat padding = 30;
    CGFloat cardWidth = self.frame.size.width - padding * 2;
    CGFloat cardHeight = self.frame.size.height - topPadding - bottomPadding;
    cardView = [[CardView alloc] initWithFrame:CGRectMake((self.frame.size.width - cardWidth) / 2.0f, (self.frame.size.height - cardHeight) / 2.0f, cardWidth, cardHeight)];
    [cardView disableSwipeCardEvent];
    cardView.layer.shadowOffset = CGSizeMake(5, 5);
    [self addSubview:cardView];
}

- (void)assignItem:(Amau*)aMau
{
    [cardView setAMauItem:aMau];
}

@end
