//
//  M2CanvasView.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2ObjectView.h"

/**
 Responsible for drawing canvas itself and objects on it.
 */
@interface M2CanvasView : NSView

/**
 Objects controller used for key-value observing on changes to objects and
 requesting objects.
 */
@property (assign) IBOutlet NSArrayController *objectsController;

/**
 Ordered array of views used for matching between array of objects and views.
 */
@property (retain) NSMutableArray *objectViews;

/****************************************************************************
 @name Updating models according to changes on canvas
 ****************************************************************************/

/**
 This message is sent by object view when its properties are changed.
 */
- (void)objectViewDidChange:(M2ObjectView *)objectView;
/**
 This message is sent by object when it is selected.
 */
- (void)objectViewDidSelect:(M2ObjectView *)objectView;

/****************************************************************************
 @name Generating images of canvas
 ****************************************************************************/

/**
 Generates image containing everything on canvas, but not any control views.
 Used for export or printing.
 */
- (NSImage *)contentsImage;
/**
 Generates thumnail image from contentsImage, but in smaller size.
 */
- (NSImage *)thumbnailImage;

/****************************************************************************
 @name Managing Z-index of objects on canvas
 ****************************************************************************/

- (void)moveObjectViewToFront:(M2ObjectView *)objectView;

@end
