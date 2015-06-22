//
//  CardView.m
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#define ACTION_MARGIN 120
#define SCALE_STRENGTH 4
#define SCALE_MAX 1
#define ROTATION_MAX 1
#define ROTATION_STRENGTH 320
#define ROTATION_ANGLE M_PI / 8

#import "CardView.h"
#import <UIImageView+AFNetworking.h>

@implementation CardView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;

    Amau* aMauItem;
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil] firstObject];
        self.frame = frame;

        [self setup];
        self.mode = CGOverlayViewModeCenter;
    }
    return self;
}

- (void)setup
{
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(beingDragged:)];
    [self addGestureRecognizer:panGesture];

    self.layer.cornerRadius = 8;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);

    self.likeImageView.hidden = YES;
    self.dislikeImageView.hidden = YES;
}

- (void)setAMauItem:(Amau*)aMau
{
    [self.titleLabel setText:aMau.title];
    [self.photoImageView setImageWithURL:[NSURL URLWithString:aMau.photoUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
    [self.locationLabel setText:aMau.location];
    [self.nameLabel setText:aMau.name];
    [self.liveLabel setText:aMau.live];
    [self.descriptionLabel setText:aMau.desc];

    aMauItem = aMau;
}

- (Amau*)getAMauItem
{
    return aMauItem;
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
        //        CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
        //
        //        CGFloat rotationAngel = (CGFloat)(ROTATION_ANGLE * rotationStrength);
        //
        //        CGFloat scale = MAX(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);

        self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);

        //        CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
        //
        //        CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
        //
        //        self.transform = scaleTransform;
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
    if (distance > 20) {
        self.mode = GGOverlayViewModeRight;
    }
    else if (distance < -20) {
        self.mode = GGOverlayViewModeLeft;
    }
    else {
        self.mode = CGOverlayViewModeCenter;
    }
}

- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    }
    else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    }
    else {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             [self setMode:CGOverlayViewModeCenter];
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

    [delegate cardSwipedRight:aMauItem.identity];

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

    [delegate cardSwipedLeft:aMauItem.identity];

    NSLog(@"NO");
}

- (void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) {
        return;
    }

    _mode = mode;

    if (mode == GGOverlayViewModeLeft) {
        self.dislikeImageView.hidden = NO;
        self.likeImageView.hidden = YES;
    }
    else {
        self.dislikeImageView.hidden = YES;
        self.likeImageView.hidden = NO;
    }
    if (mode == CGOverlayViewModeCenter) {
        self.dislikeImageView.hidden = YES;
        self.likeImageView.hidden = YES;
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

    [delegate cardSwipedRight:aMauItem.identity];

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

    [delegate cardSwipedLeft:aMauItem.identity];

    NSLog(@"NO");
}

@end
