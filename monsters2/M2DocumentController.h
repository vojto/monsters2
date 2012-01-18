//
//  M2DocumentController.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

/**
 Adds shared context management functionality to document controller. 
*/

@interface M2DocumentController : NSDocumentController

/****************************************************************************
 @name Core Data stack
 ****************************************************************************/

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**
 Saves shared context
*/
- (void)saveShared;

/****************************************************************************
 @name Helpers
 ****************************************************************************/

- (NSURL *)applicationFilesDirectory;

@end
