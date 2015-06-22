// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Amau.m instead.

#import "_Amau.h"

const struct AmauAttributes AmauAttributes = {
	.contact = @"contact",
	.desc = @"desc",
	.identity = @"identity",
	.isLike = @"isLike",
	.live = @"live",
	.location = @"location",
	.name = @"name",
	.photoUrl = @"photoUrl",
	.title = @"title",
};

@implementation AmauID
@end

@implementation _Amau

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Amau" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Amau";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Amau" inManagedObjectContext:moc_];
}

- (AmauID*)objectID {
	return (AmauID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"identityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isLikeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isLike"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic contact;

@dynamic desc;

@dynamic identity;

- (int64_t)identityValue {
	NSNumber *result = [self identity];
	return [result longLongValue];
}

- (void)setIdentityValue:(int64_t)value_ {
	[self setIdentity:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdentityValue {
	NSNumber *result = [self primitiveIdentity];
	return [result longLongValue];
}

- (void)setPrimitiveIdentityValue:(int64_t)value_ {
	[self setPrimitiveIdentity:[NSNumber numberWithLongLong:value_]];
}

@dynamic isLike;

- (BOOL)isLikeValue {
	NSNumber *result = [self isLike];
	return [result boolValue];
}

- (void)setIsLikeValue:(BOOL)value_ {
	[self setIsLike:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsLikeValue {
	NSNumber *result = [self primitiveIsLike];
	return [result boolValue];
}

- (void)setPrimitiveIsLikeValue:(BOOL)value_ {
	[self setPrimitiveIsLike:[NSNumber numberWithBool:value_]];
}

@dynamic live;

@dynamic location;

@dynamic name;

@dynamic photoUrl;

@dynamic title;

@end

