//
//  M2Document.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2DocumentController.h"
#import "M2CanvasObject.h"
#import "M2CanvasView.h"

@interface M2Document : NSPersistentDocument

@property (readonly) M2DocumentController *documentController;
@property (readonly) NSManagedObjectContext *sharedContext;
@property (assign) IBOutlet NSArrayController *libObjectsController;

@property (assign) IBOutlet M2CanvasView *canvasView;
@property (assign) IBOutlet NSArrayController *canvasObjectsController;

@property (assign) IBOutlet NSButton *galleryAddButton;
@property (assign) IBOutlet NSView *exportView;
@property (assign) IBOutlet NSPopUpButton *exportFormatButton;

- (IBAction)testAction:(id)sender;
- (IBAction)instantiateAction:(id)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)exportAction:(id)sender;
- (IBAction)printAction:(id)sender;

#pragma mark - Saving & gallery
- (BOOL)isSaved;
- (IBAction)galleryAddAction:(id)sender;
- (void)_saveFileToGallery;
- (NSData *)_thumbnailData;

//- (void)removeCanvasObject:(M2CanvasObject *)canvasObject;

#pragma mark - General helpers
- (NSWindow *)window;

#pragma mark - Exporting
- (NSArray *)exportFormats;
- (void)exportToURL:(NSURL *)url withFormat:(NSString *)format;

@end
