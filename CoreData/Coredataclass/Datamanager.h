//
//  Datamanager.h
//  Running
//
//  Created by Femina Rajesh Brahmbhatt on 22/03/17.
//  Copyright © 2017 Femina Rajesh Brahmbhatt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Datamanager : NSObject
{
    NSManagedObjectModel *mainManagedObjectModel;
    
    NSPersistentStoreCoordinator *mainPersistentStoreCoordinator;
    
    NSManagedObjectContext *mainManagedObjectContext;
}

+ (Datamanager *)sharedInstance;
+ (NSURL *)applicationSupportDirectory;
+ (NSURL *)applicationCoreDataStoreFileURL;
- (NSManagedObjectModel *)mainManagedObjectModel;
- (NSPersistentStoreCoordinator *)mainPersistentStoreCoordinator;
- (NSManagedObjectContext *)mainManagedObjectContext;
- (NSManagedObjectContext *)newManagedObjectContext;
- (void)saveMainManagedObjectContext;

@end
