//
//  CardView.m
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#define ACTION_MARGIN 120
#define SCALE_STRENGTH 4
#define SCALE_MAX .93
#define ROTATION_MAX 1
#define ROTATION_STRENGTH 320
#define ROTATION_ANGLE M_PI / 8

#import "CardView.h"

@implementation CardView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(beingDragged:)];
    [self addGestureRecognizer:panGesture];
}

- (void)beingDragged:(UIPanGestureRecognizer*)gestureRecognizer
{
    xFromCenter = [gestureRecognizer translationInView:self].x;
    yFromCenter = [gestureRecognizer translationInView:self].y;

    switch (gestureRecognizer.state) {
    case UIGestureRecognizerStateBegan: {
        self.originalPoint = self.center;
        break;
    };

    case UIGestureRecognizerStateChanged: {
        CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);

        CGFloat rotationAngel = (CGFloat)(ROTATION_ANGLE * rotationStrength);

        CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);

        self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);

        CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);

        CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);

        self.transform = scaleTransform;
        [self updateOverlay:xFromCenter];

        break;
    };
    case UIGestureRecognizerStateEnded: {
        [self afterSwipeAction];
        break;
    };
    case UIGestureRecognizerStatePossible:
        break;
    case UIGestureRecognizerStateCancelled:
        break;
    case UIGestureRecognizerStateFailed:
        break;
    }
}

- (void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        self.mode = GGOverlayViewModeRight;
    }
    else {
        self.mode = GGOverlayViewModeLeft;
    }

    self.alpha = MIN(fabs(distance) / 100, 0.4);
}

- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    }
    else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    }
    else { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             self.alpha = 0;
                         }];
    }
}

- (void)rightAction
{
    CGPoint finishPoint = CGPointMake(500, 2 * yFromCenter + self.originalPoint.y);
    [UIView animateWithDuration:0.3
        animations:^{
            self.center = finishPoint;
        }
        completion:^(BOOL complete) {
            [self removeFromSuperview];
        }];

    [delegate cardSwipedRight:self];

    NSLog(@"YES");
}

- (void)leftAction
{
    CGPoint finishPoint = CGPointMake(-500, 2 * yFromCenter + self.originalPoint.y);
    [UIView animateWithDuration:0.3
        animations:^{
            self.center = finishPoint;
        }
        completion:^(BOOL complete) {
            [self removeFromSuperview];
        }];

    [delegate cardSwipedLeft:self];

    NSLog(@"NO");
}

- (void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) {
        return;
    }

    _mode = mode;

    if (mode == GGOverlayViewModeLeft) {
        self.dislikeImageView.hidden = FALSE;
        self.likeImageView.hidden = TRUE;
    }
    else {
        self.dislikeImageView.hidden = TRUE;
        self.likeImageView.hidden = FALSE;
    }
}

- (void)rightClickAction
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
        animations:^{
            self.center = finishPoint;
            self.transform = CGAffineTransformMakeRotation(1);
        }
        completion:^(BOOL complete) {
            [self removeFromSuperview];
        }];

    [delegate cardSwipedRight:self];

    NSLog(@"YES");
}

- (void)leftClickAction
{
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
        animations:^{
            self.center = finishPoint;
            self.transform = CGAffineTransformMakeRotation(-1);
        }
        completion:^(BOOL complete) {
            [self removeFromSuperview];
        }];

    [delegate cardSwipedLeft:self];

    NSLog(@"NO");
}

@end
