//
//  CardView.h
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Amau.h"

@protocol DraggableViewDelegate <NSObject>

- (void)cardSwipedLeft:(UIView*)card;
- (void)cardSwipedRight:(UIView*)card;

@end

typedef NS_ENUM(NSUInteger, GGOverlayViewMode) {
    GGOverlayViewModeLeft,
    CGOverlayViewModeCenter,
    GGOverlayViewModeRight
};

@interface CardView : UIView

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView* photoImageView;
@property (weak, nonatomic) IBOutlet UILabel* locationLabel;
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* liveLabel;
@property (weak, nonatomic) IBOutlet UILabel* descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView* likeImageView;
@property (weak, nonatomic) IBOutlet UIImageView* dislikeImageView;

@property (weak) id<DraggableViewDelegate> delegate;
@property (nonatomic) GGOverlayViewMode mode;
@property (nonatomic) CGPoint originalPoint;

- (void)leftClickAction;
- (void)rightClickAction;
- (void)setAMauItem:(Amau*)aMau;
- (Amau*)getAMauItem;

@end
