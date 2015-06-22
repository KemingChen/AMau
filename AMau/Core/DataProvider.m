//
//  DataProvider.m
//  AMau
//
//  Created by Keming on 2015/6/22.
//  Copyright (c) 2015年 NTUT-IOS. All rights reserved.
//

#import "DataProvider.h"
#import <AFNetworking.h>
#import "Amau.h"

@implementation DataProvider

typedef void (^FinishCallback)(bool success);

static DataProvider* dataProvider = nil;
static NSString* dataUrl = @"http://140.124.181.190/Test/data.json";

int postCheckInIdentity = 1000;

NSMutableArray* items = nil;
FinishCallback callback = nil;

+ (DataProvider*)sharedProvider
{
    if (dataProvider == nil) {
        dataProvider = [[DataProvider alloc] init];
    }
    return dataProvider;
}

- (DataProvider*)init
{
    [self loadLocalAMaus];

    return self;
}

- (void)loadLocalAMaus
{
    NSArray* array = [NSMutableArray arrayWithArray:[Amau MR_findAllSortedBy:@"identity" ascending:false inContext:[NSManagedObjectContext MR_defaultContext]]];

    items = [[NSMutableArray alloc] initWithArray:array];
}

- (NSMutableArray*)items
{
    return items;
}

- (void)updateItems:(NSArray*)itemJSONArray
{
    NSLog(@"%@", itemJSONArray);
    for (NSDictionary* item in itemJSONArray) {
        Amau* aMau = [Amau aMauWithIdentity:[item[@"sn"] integerValue]];
        aMau.title = item[@"title"];
        aMau.name = item[@"name"];
        aMau.location = item[@"location"];
        aMau.live = item[@"live"];
        aMau.desc = item[@"description"];
        aMau.photoUrl = item[@"photo"];
        aMau.contact = item[@"contact"];
    }
    [Amau save];

    [self loadLocalAMaus];
    if (callback != nil) {
        callback(YES);
    }
}

- (void)syncFromServer:(FinishCallback)complete
{
    callback = complete;

    complete(YES);

    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager GET:dataUrl
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            [self updateItems:responseObject];

        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            NSLog(@"Error: %@", error);
            complete(NO);
        }];
}

@end