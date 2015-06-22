//
//  FavoriteTableViewCell.h
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Amau.h"

@interface FavoriteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* photoImageView;
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* contactLabel;

- (void)assignAMau:(Amau*)aMau;

@end
