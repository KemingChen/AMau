//
//  FavoriteTableViewCell.m
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "FavoriteTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@implementation FavoriteTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:FALSE animated:animated];
}

- (void)assignAMau:(Amau*)aMau
{
    [self.photoImageView setImageWithURL:[NSURL URLWithString:aMau.photoUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
    [self.nameLabel setText:aMau.name];
    [self.contactLabel setText:aMau.contact];
}

@end
