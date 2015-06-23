//
//  ViewController.h
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "DraggableViewBackground.h"
#import "DataProvider.h"

@implementation DraggableViewBackground {
    NSInteger cardsLoadedIndex;
    NSMutableArray* loadedCards;
    CGRect mainFrame;
}

static const int MAX_BUFFER_SIZE = 2;

@synthesize items;
@synthesize allCards;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    mainFrame = frame;
    if (self) {
        [super layoutSubviews];

        [[DataProvider sharedProvider] syncFromServer:^(bool success) {
            [self syncDataComplete:success];
        }];
    }
    return self;
}

- (void)syncDataComplete:(bool)success
{
    if (success) {
        items = [[DataProvider sharedProvider] items];
        [self loadCards];
    }
}

- (void)loadCards
{
    loadedCards = [[NSMutableArray alloc] init];
    allCards = [[NSMutableArray alloc] init];
    cardsLoadedIndex = 0;

    if ([items count] > 0) {
        NSInteger numLoadedCardsCap = (([items count] > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : [items count]);

        for (int i = 0; i < [items count]; i++) {
            CardView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];

            if (i < numLoadedCardsCap) {
                [loadedCards addObject:newCard];
            }
        }

        for (UIView* subview in self.subviews) {
            [subview removeFromSuperview];
        }

        for (int i = 0; i < [loadedCards count]; i++) {
            if (i > 0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i - 1]];
            }
            else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++;
        }
    }
}

- (CardView*)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    CGFloat padding = 20;
    CGFloat cardWidth = mainFrame.size.width - padding * 2;
    CGFloat cardHeight = mainFrame.size.height - padding - 130;
    CardView* cardView = [[CardView alloc] initWithFrame:CGRectMake((mainFrame.size.width - cardWidth) / 2.0f, padding - mainFrame.origin.y, cardWidth, cardHeight)];
    cardView.delegate = self;
    [cardView setAMauItem:items[index]];
    return cardView;
}

- (void)cardSwipedLeft:(NSNumber*)identity;
{
    [self removeLoadedCardWithItemIdentity:identity];

    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 2)]];
    }
}

- (void)cardSwipedRight:(NSNumber*)identity
{
    [self removeLoadedCardWithItemIdentity:identity];
    [[DataProvider sharedProvider] moveToLikeItems:identity];

    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 2)]];
    }
}

- (void)removeLoadedCardWithItemIdentity:(NSNumber*)identity
{
    for (CardView* cardView in loadedCards) {
        if ([cardView.getAMauItem.identity isEqualToNumber:identity]) {
            [loadedCards removeObject:cardView];
            break;
        }
    }
}

- (void)swipeRight
{
    CardView* cardView = [loadedCards firstObject];
    cardView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2
                     animations:^{
                         cardView.alpha = 1;
                     }];
    [cardView rightClickAction];
}

- (void)swipeLeft
{
    CardView* cardView = [loadedCards firstObject];
    cardView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2
                     animations:^{
                         cardView.alpha = 1;
                     }];
    [cardView leftClickAction];
}

@end
