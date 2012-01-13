//
//  M2GalleryController.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2GalleryEntry.h"

/**
 Manages gallery window.
 
 - Uses NSArrayController to manage gallery entries
 - Implements openAction: to open gallery entry when its button is clicked
 
 @see M2GalleryEntry
*/
@interface M2GalleryController : NSWindowController

/**
 Array controller responsible for managing gallery entries
*/
@property (assign) IBOutlet NSArrayController *arrayController;

/****************************************************************************
 @name Opening gallery entries
 ****************************************************************************/

/**
 Action for opening gallery entry. Figures out the entry form passed sender.
 Sender has to be direct subview of collection view item.
*/
- (IBAction)openAction:(id)sender;

/**
 Opens document for passed in entry. Silently fails if there's an error.
*/
- (void)openEntry:(M2GalleryEntry *)entry;

@end

