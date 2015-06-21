//
//  ViewController.h
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "DraggableViewBackground.h"

@implementation DraggableViewBackground {
    NSInteger cardsLoadedIndex;
    NSMutableArray* loadedCards;
}

static const int MAX_BUFFER_SIZE = 2;
static const float CARD_HEIGHT = 386;
static const float CARD_WIDTH = 290;

@synthesize exampleCardLabels;
@synthesize allCards;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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

- (DraggableView*)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    DraggableView* draggableView = [[DraggableView alloc] initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH) / 2, (self.frame.size.height - CARD_HEIGHT) / 2, CARD_WIDTH, CARD_HEIGHT)];
    draggableView.information.text = [exampleCardLabels objectAtIndex:index];
    draggableView.delegate = self;
    return draggableView;
}

- (void)loadCards
{
    if ([exampleCardLabels count] > 0) {
        NSInteger numLoadedCardsCap = (([exampleCardLabels count] > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : [exampleCardLabels count]);

        for (int i = 0; i < [exampleCardLabels count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
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
    DraggableView* dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2
                     animations:^{
                         dragView.overlayView.alpha = 1;
                     }];
    [dragView rightClickAction];
}

- (void)swipeLeft
{
    DraggableView* dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2
                     animations:^{
                         dragView.overlayView.alpha = 1;
                     }];
    [dragView leftClickAction];
}

@end
