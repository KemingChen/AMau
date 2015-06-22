//
//  MainController.h
//  AMau
//
//  Created by Keming on 2015/6/21.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UIViewController

@property (weak, nonatomic) IBOutlet UIView* mainContainer;
@property (weak, nonatomic) IBOutlet UIButton* favoriteListButton;
- (IBAction)clickDislikeButton:(id)sender;
- (IBAction)clickLikeButton:(id)sender;
- (IBAction)clickFavoriteListButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton* dislikeButton;
@property (weak, nonatomic) IBOutlet UIButton* likeButton;

@end
