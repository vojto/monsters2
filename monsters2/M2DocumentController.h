//
//  M2DocumentController.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

/**
 Pridáva podporu spravovania zdieľaného modelu objektov k ovládaču dokumentov.
*/

@interface M2DocumentController : NSDocumentController

/****************************************************************************
 @name Správa objektov vyžadovaných knižnicou Core Data
 ****************************************************************************/

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**
 Ukladanie zdieľaného kontextu
*/
- (void)saveShared;

/****************************************************************************
 @name Pomocné metódy
 ****************************************************************************/

- (NSURL *)applicationFilesDirectory;

@end
