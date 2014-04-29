//
//  HSLocationManager.m
//  Hot Spot
//
//  Created by Patrick Reynolds on 3/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "HSLocationManager.h"
#import "HSLocation.h"
#import "HSAppDelegate.h"

@import CoreData;

@interface HSLocationManager()

@property (nonatomic) NSMutableArray *privateLocations;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectModel *model;

@end

@implementation HSLocationManager

+ (instancetype)locationStore
{
    static HSLocationManager *locationStore = nil;
    
    if ( !locationStore ) {
        locationStore = [[self alloc] initPrivate];
    }
    return locationStore;
}

- (NSMutableArray *)privateLocations
{
    if ( !_privateLocations ) _privateLocations = [[NSMutableArray alloc] init];
    return _privateLocations;
}

- (NSString *)locationArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    NSLog(@"Document Directory: %@", documentDirectory);
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if ( !successful ) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[HSLocationManager locationStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if ( self ) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *persistantStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        NSString *path = [self locationArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        
        if ( ![persistantStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:storeURL
                                                             options:nil
                                                               error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
        
        
        // Create the managed object context
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = persistantStoreCoordinator;
        
        [self loadAllLocations];
    }
    return self;
}

- (void)loadAllLocations
{
    if ( !self.privateLocations ) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"orderingValue"
                                                             inManagedObjectContext:self.context];
        request.entity = entityDescription;
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sortDescriptor];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if ( !result ) {
            [NSException raise:@"Fetch failed" format:@"reason: %@", [error localizedDescription]];
        }
        
        self.privateLocations = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSArray *)allLocations
{
    return self.privateLocations;
}

- (HSLocation *)createLocation
{
    double order;
    if ( [self.allLocations count] == 0) {
        order = 1.0;
    } else {
        order = [[[self.privateLocations lastObject] orderingValue] doubleValue] + 1.0;
    }
    
    HSLocation *location = [NSEntityDescription insertNewObjectForEntityForName:@"HSLocation" inManagedObjectContext:self.context];
    location.orderingValue = [NSNumber numberWithDouble:order];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    location.name = [defaults objectForKey:@"HSLocationNamePrefsKey"];
    location.latitude = [defaults objectForKey:@"HSLocationLatitudePrefsKey"];
    location.longitude = [defaults objectForKey:@"HSLocationLongitudePrefsKey"];
    
    NSLog(@"defaults = %@", [defaults dictionaryRepresentation]);
    
    [self.privateLocations addObject:location];
    return location;
}

- (void)removeLocation:(HSLocation *)location
{
    [self.context deleteObject:location];
    [self.privateLocations removeObjectIdenticalTo:location];
}

- (void)moveLocationAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    if ( fromIndex == toIndex ) {
        return;
    }
    
    HSLocation *location = self.privateLocations[fromIndex];
    [self.privateLocations removeObjectAtIndex:fromIndex];
    [self.privateLocations insertObject:location atIndex:toIndex];
    
    double lowerBound = 0.0;
    
    if ( toIndex > 0) {
        lowerBound = [[self.privateLocations[( toIndex - 1 )] orderingValue] doubleValue];
    } else {
        lowerBound = [[self.privateLocations[1] orderingValue] doubleValue] - 2.0;
    }
    
    double upperBound = 0.0;
    
    if ( toIndex < [self.privateLocations count] - 1 ) {
        upperBound = [[self.privateLocations[( toIndex + 1 )] orderingValue] doubleValue];
    } else {
        upperBound = [[self.privateLocations[( toIndex - 1 )] orderingValue] doubleValue] + 2.0;
    }
    
    double newOrderValue = ( lowerBound + upperBound ) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    location.orderingValue = [NSNumber numberWithDouble:newOrderValue];
}

@end