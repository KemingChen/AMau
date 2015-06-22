//
//  DataProvider.h
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Amau.h"

@interface DataProvider : NSObject

+ (DataProvider*)sharedProvider;

- (NSMutableArray*)items;
- (NSMutableArray*)likeItems;

- (void)syncFromServer:(void (^)(bool success))complete;
- (void)moveToLikeItems:(NSNumber*)identity;

@end
