//
//  Datamanager.m
//  Running
//
//  Created by Femina Rajesh Brahmbhatt on 22/03/17.
//  Copyright © 2017 Femina Rajesh Brahmbhatt. All rights reserved.
//

#import "Datamanager.h"
#define modelname @"CoreData"

@implementation Datamanager

#pragma mark CoreDataManager class methods

+ (Datamanager *)sharedInstance
{
    static dispatch_once_t predicate = 0;
    
    static Datamanager *object = nil; // Object
    
    dispatch_once(&predicate, ^{ object = [self new]; });
    
    return object; // CoreDataManager singleton
}

+ (NSURL *)applicationSupportDirectory
{
    NSFileManager *fileManager = [NSFileManager new]; // File manager instance
    
    return [fileManager URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
}

+ (NSURL *)applicationCoreDataStoreFileURL
{
    return [[Datamanager applicationSupportDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",modelname]]; // Data store file URL
}

#pragma mark CoreDataManager instance methods

- (NSManagedObjectModel *)mainManagedObjectModel
{
    if (mainManagedObjectModel == nil) // Create ManagedObjectModel
    {
        assert([NSThread isMainThread] == YES); // Create it only on the main thread
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelname withExtension:@"momd"];
        
        mainManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    
    return mainManagedObjectModel;
}

- (NSPersistentStoreCoordinator *)mainPersistentStoreCoordinator
{
    if (mainPersistentStoreCoordinator == nil) // Create PersistentStoreCoordinator
    {
        
        NSURL *storeURL = [Datamanager applicationCoreDataStoreFileURL]; // DB
        
        NSError *error = nil; // Error information object
        
        NSDictionary *migrate = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        mainPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self mainManagedObjectModel]];
        
        if ([mainPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:migrate error:&error] == nil)
        {
            NSLog(@"%s %@", __FUNCTION__, error);
        }
    }
    
    return mainPersistentStoreCoordinator;
}

- (NSManagedObjectContext *)mainManagedObjectContext
{
    if (mainManagedObjectContext == nil) // Create ManagedObjectContext
    {
        assert([NSThread isMainThread] == YES); // Create it only on the main thread
        
        NSPersistentStoreCoordinator *coordinator = [self mainPersistentStoreCoordinator];
        
        if (coordinator != nil) // Check for valid PersistentStoreCoordinator
        {
            mainManagedObjectContext = [NSManagedObjectContext new]; // New MOC
            
            [mainManagedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    
    return mainManagedObjectContext;
}

- (NSManagedObjectContext *)newManagedObjectContext
{
    NSManagedObjectContext *someManagedObjectContext = nil;
    
    NSPersistentStoreCoordinator *coordinator = [self mainPersistentStoreCoordinator];
    
    if (coordinator != nil) // Check for valid PersistentStoreCoordinator
    {
        someManagedObjectContext = [NSManagedObjectContext new]; // New MOC
        
        [someManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return someManagedObjectContext;
}

- (void)saveMainManagedObjectContext
{
    
    if (mainManagedObjectContext != nil) // Save ManagedObjectContext
    {
        NSError *error = nil; // Error information object
        
        if ([mainManagedObjectContext hasChanges] == YES) // Save changes
        {
            if ([mainManagedObjectContext save:&error] == NO) // Log any errors
            {
                NSLog(@"%s %@", __FUNCTION__, error);
            }
        }
    }
}

@end
