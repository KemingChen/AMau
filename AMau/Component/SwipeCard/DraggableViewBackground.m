//
//  ViewController.h
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#define CARD_WIDTH 270
#define CARD_HEIGHT 350

#import "DraggableViewBackground.h"

@implementation DraggableViewBackground {
    NSInteger cardsLoadedIndex;
    NSMutableArray* loadedCards;
    CGRect mainFrame;
}

static const int MAX_BUFFER_SIZE = 2;

@synthesize exampleCardLabels;
@synthesize allCards;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    mainFrame = frame;
    if (self) {
        [super layoutSubviews];
        exampleCardLabels = [[NSArray alloc] initWithObjects:@"first", @"second", @"third", @"fourth", @"last", nil];
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;

        [self loadCards];
    }
    return self;
}

- (void)loadCards
{
    if ([exampleCardLabels count] > 0) {
        NSInteger numLoadedCardsCap = (([exampleCardLabels count] > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : [exampleCardLabels count]);

        for (int i = 0; i < [exampleCardLabels count]; i++) {
            CardView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];

            if (i < numLoadedCardsCap) {
                [loadedCards addObject:newCard];
            }
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
    CardView* cardView = [[CardView alloc] initWithFrame:CGRectMake((mainFrame.size.width - CARD_WIDTH) / 2.0f, 20 - mainFrame.origin.y, CARD_WIDTH, CARD_HEIGHT)];
    cardView.delegate = self;
    [cardView assignData];
    return cardView;
}

- (void)cardSwipedLeft:(UIView*)card;
{
    [loadedCards removeObjectAtIndex:0];

    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 2)]];
    }
}

- (void)cardSwipedRight:(UIView*)card
{
    [loadedCards removeObjectAtIndex:0];

    if (cardsLoadedIndex < [allCards count]) {
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 2)]];
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
