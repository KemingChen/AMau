#import "Amau.h"

@interface Amau ()
@end

@implementation Amau

+ (Amau*)aMauWithIdentity:(NSInteger)identity
{
    Amau* aMau = nil;

    NSArray* aMaus = [Amau MR_findByAttribute:@"identity" withValue:@(identity) inContext:[NSManagedObjectContext MR_defaultContext]];

    if (aMaus.count > 0) {
        aMau = [aMaus firstObject];
    }
    else {
        aMau = [Amau MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    }

    aMau.identityValue = identity;

    return aMau;
}

+ (void)save
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}



@end
