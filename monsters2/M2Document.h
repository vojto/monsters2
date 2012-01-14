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

/**
 Controls one open document. Part of Cocoa document-application hierarchy.
 
 Since this class is subclass of NSPersistentDocument, the managed object
 context is managed for us. This context is then used to persist document
 data.
*/
 
@interface M2Document : NSPersistentDocument

/****************************************************************************
 @name General helpers
****************************************************************************/

/**
 Property for quick access to document controller
*/
@property (readonly) M2DocumentController *documentController;

/**
 Property for quick access to shared data context
*/
@property (readonly) NSManagedObjectContext *sharedContext;

/**
 Shortcut for retrieving window of document
 */
- (NSWindow *)window;

/****************************************************************************
 @name Array controllers
 ****************************************************************************/

/**
 Controller for managing lib objects
*/
@property (assign) IBOutlet NSArrayController *libObjectsController;

/**
 Controller for managing canvas objects
*/
@property (assign) IBOutlet NSArrayController *canvasObjectsController;

/****************************************************************************
 @name Views
 ****************************************************************************/

/**
 Canvas view
*/
@property (assign) IBOutlet M2CanvasView *canvasView;

/****************************************************************************
 @name Exporting
 ****************************************************************************/

/**
 Accessory view for export panel. Contains format choice combo box.
*/
@property (assign) IBOutlet NSView *exportView;

/**
 Button for export format choice. Used when saving to determine 
 selected format.
*/
@property (assign) IBOutlet NSPopUpButton *exportFormatButton;

/**
 Action for exporting current document
 */
- (IBAction)exportAction:(id)sender;

/**
 Returns list of available export formats. Used for interface binding.
 */
- (NSArray *)exportFormats;

/**
 Exports current document to URL with specified format.
 */
- (void)exportToURL:(NSURL *)url withFormat:(NSString *)format;

/****************************************************************************
 @name General actions
 ****************************************************************************/

/**
 Action for creating new view on canvas from library objects
*/
- (IBAction)instantiateAction:(id)sender;

/**
 Action for removing objects from canvas. Triggered by backspace
 key.
*/
- (IBAction)removeAction:(id)sender;

/**
 Action for printing current document
*/
- (IBAction)printAction:(id)sender;

/****************************************************************************
 @name Saving and gallery
 ****************************************************************************/

/**
 Returns true if current document is saved
*/
- (BOOL)isSaved;

/**
 Action for adding document to gallery
*/
- (IBAction)galleryAddAction:(id)sender;

/****************************************************************************
 @name Importing objects to library
 ****************************************************************************/

/**
 Opens import dialog to select file to be imported.
 */
- (IBAction)importAction:(id)sender;

/**
 Imports SVG specified by URL
 */
- (void)importSVGByURL:(NSURL *)url;

@end
