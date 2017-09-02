//
//  userdataclass.h
//  CoreData
//
//  Created by Femina Rajesh Brahmbhatt on 09/07/17.
//  Copyright © 2017 Femina Rajesh Brahmbhatt. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "Datamanager.h"

@interface userdataclass : NSManagedObject

@property (nonatomic,strong,readwrite)NSString *username;
@property (nonatomic,assign)NSInteger contactno;

//declare the attributes over here

+ (NSArray *)allInMOC:(NSManagedObjectContext *)inMOC;
+ (NSArray *)allInMOC:(NSManagedObjectContext *)inMOC withName:(NSString *)name;
+ (userdataclass *)insertInMOC:(NSManagedObjectContext *)inMOC usernamename:(NSString*)name contactno:(NSInteger)number;
+ (BOOL)existsInMOC:(NSManagedObjectContext *)inMOC name:(NSString *)string;


@end
