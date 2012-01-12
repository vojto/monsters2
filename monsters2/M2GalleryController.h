//
//  M2GalleryController.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2GalleryEntry.h"

@interface M2GalleryController : NSWindowController

@property (assign) IBOutlet NSArrayController *arrayController;

- (void)openEntry:(M2GalleryEntry *)entry;
- (IBAction)openAction:(id)sender;

@end
