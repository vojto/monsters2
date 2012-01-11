//
//  M2Document.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2DocumentController.h"

@interface M2Document : NSPersistentDocument

@property (readonly) M2DocumentController *documentController;
@property (readonly) NSManagedObjectContext *sharedContext;
@property (assign) IBOutlet NSArrayController *libObjectsController;

@property (assign) IBOutlet NSView *canvasView;

- (IBAction)testAction:(id)sender;
- (IBAction)instantiateAction:(id)sender;


@end
