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

- (void)setupCardView
{
    CGFloat topPadding = 150;
    CGFloat bottomPadding = 100;
    CGFloat padding = 50;
    CGFloat cardWidth = self.frame.size.width - padding * 2;
    CGFloat cardHeight = self.frame.size.height - topPadding - bottomPadding;
    cardView = [[CardView alloc] initWithFrame:CGRectMake((self.frame.size.width - cardWidth) / 2.0f, (self.frame.size.height - cardHeight) / 2.0f, cardWidth, cardHeight)];
    [self addSubview:cardView];
}

- (IBAction)clickCloseButton:(id)sender
{
    self.hidden = YES;
}

- (void)assignItem:(Amau*)aMau
{
    [cardView setAMauItem:aMau];
}

@end
