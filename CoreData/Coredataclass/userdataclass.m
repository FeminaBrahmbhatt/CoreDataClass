//
//  userdataclass.m
//  CoreData
//
//  Created by Femina Rajesh Brahmbhatt on 09/07/17.
//  Copyright © 2017 Femina Rajesh Brahmbhatt. All rights reserved.
//

#import "userdataclass.h"

#define kentityname @"User"

@implementation userdataclass
@synthesize username,contactno;
#pragma mark  Core Data class methods

+ (NSArray *)allInMOC:(NSManagedObjectContext *)inMOC
{
    
    NSFetchRequest *request = [NSFetchRequest new]; // Fetch request instance
    
    [request setEntity:[NSEntityDescription entityForName:kentityname inManagedObjectContext:inMOC]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]]; // Sort order
    
    NSError *error = nil; // Error information object
    
    NSArray *objectList = [inMOC executeFetchRequest:request error:&error];
    
    if (objectList == nil) { NSLog(@"%s %@", __FUNCTION__, error);}
    
    return objectList;
}

+ (NSArray *)allInMOC:(NSManagedObjectContext *)inMOC withName:(NSString *)name
{
    
    NSFetchRequest *request = [NSFetchRequest new]; // Fetch request instance
    
    [request setEntity:[NSEntityDescription entityForName:kentityname inManagedObjectContext:inMOC]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"username == %@", name]]; // Matching file name
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]]; // Sort order
    
    [request setReturnsObjectsAsFaults:YES];
    
    [request setFetchBatchSize:32]; // Optimize fetch
    
    NSError *error = nil; // Error information object
    
    NSArray *objectList = [inMOC executeFetchRequest:request error:&error];
    
    if (objectList == nil) { NSLog(@"%s %@", __FUNCTION__, error);
    
    }
    
    return objectList;
}

+ (userdataclass *)insertInMOC:(NSManagedObjectContext *)inMOC usernamename:(NSString*)name contactno:(NSInteger)number
{
   
    userdataclass *object = [NSEntityDescription insertNewObjectForEntityForName:kentityname inManagedObjectContext:inMOC];
    
    if ((object != nil) && ([object isMemberOfClass:[userdataclass class]])) // We have a valid ReaderDocument object
    {
        object.username = name;
        object.contactno = number;
    }
    
    return object;
}



+ (BOOL)existsInMOC:(NSManagedObjectContext *)inMOC name:(NSString *)string
{
    
    NSFetchRequest *request = [NSFetchRequest new]; // Fetch request instance
    
    [request setEntity:[NSEntityDescription entityForName:kentityname inManagedObjectContext:inMOC]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"fileName == %@", string]]; // Name predicate
    
    NSError *error = nil; // Error information object
    
    NSUInteger count = [inMOC countForFetchRequest:request error:&error];
    
    if (error != nil) { NSLog(@"%s %@", __FUNCTION__, error); }
    
    return ((count > 0) ? YES : NO);
}

@end
