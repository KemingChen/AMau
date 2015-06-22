// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Amau.h instead.

#import <CoreData/CoreData.h>

extern const struct AmauAttributes {
	__unsafe_unretained NSString *contact;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *identity;
	__unsafe_unretained NSString *isLike;
	__unsafe_unretained NSString *live;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *photoUrl;
	__unsafe_unretained NSString *title;
} AmauAttributes;

@interface AmauID : NSManagedObjectID {}
@end

@interface _Amau : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AmauID* objectID;

@property (nonatomic, strong) NSString* contact;

//- (BOOL)validateContact:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* desc;

//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* identity;

@property (atomic) int64_t identityValue;
- (int64_t)identityValue;
- (void)setIdentityValue:(int64_t)value_;

//- (BOOL)validateIdentity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isLike;

@property (atomic) BOOL isLikeValue;
- (BOOL)isLikeValue;
- (void)setIsLikeValue:(BOOL)value_;

//- (BOOL)validateIsLike:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* live;

//- (BOOL)validateLive:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* photoUrl;

//- (BOOL)validatePhotoUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@end

@interface _Amau (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveContact;
- (void)setPrimitiveContact:(NSString*)value;

- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;

- (NSNumber*)primitiveIdentity;
- (void)setPrimitiveIdentity:(NSNumber*)value;

- (int64_t)primitiveIdentityValue;
- (void)setPrimitiveIdentityValue:(int64_t)value_;

- (NSNumber*)primitiveIsLike;
- (void)setPrimitiveIsLike:(NSNumber*)value;

- (BOOL)primitiveIsLikeValue;
- (void)setPrimitiveIsLikeValue:(BOOL)value_;

- (NSString*)primitiveLive;
- (void)setPrimitiveLive:(NSString*)value;

- (NSString*)primitiveLocation;
- (void)setPrimitiveLocation:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitivePhotoUrl;
- (void)setPrimitivePhotoUrl:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

@end
