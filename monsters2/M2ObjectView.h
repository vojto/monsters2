//
//  M2ObjectView.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2Object.h"
#import "M2ResizeHandleView.h"

@class M2CanvasView;

/**
 Responsible for drawing one object
 */
@interface M2ObjectView : NSView

/****************************************************************************
 @name Hierarchy
 ****************************************************************************/

/**
 Reference back to parent canvas view
 */
@property (assign) M2CanvasView *canvasView;

/****************************************************************************
 @name Model
 ****************************************************************************/

/**
 Represented model
 */
@property (retain) M2Object *object;

/****************************************************************************
 @name Dragging & Resizing
 ****************************************************************************/

/**
 Reference to resize handle object
 
 @see M2ResizeHandle
 */
@property (retain) NSView *resizeHandle;

/**
 Boolean indicating whether object is currently being dragged
 */

@property (assign) BOOL isDragging;
/**
 Boolean indicating whether object is currently being resized
 */
@property (assign) BOOL isResizing;

/**
 Point of last location in the window, where mouse down event
 was received. Used for computing new position/size when dragging
 or resizing.
 */
@property (assign) NSPoint mouseDownLocation;

/**
 Frame of view when last mouse down event was received. Used for
 computing new frame when dragging or resizing.
 */
@property (assign) NSRect mouseDownFrame;

/****************************************************************************
 @name Selection
 ****************************************************************************/

/**
 Boolean value indicating whether receiver is currentl selected.
 */
@property (assign) BOOL isSelected;

/**
 Deselects receiver.
 */
- (void)deselect;
/**
 Selects receiver.
 */
- (void)makeSelected;

/****************************************************************************
 @name Rotation
 ****************************************************************************/

/**
 Rotation of receiver in degrees.
 */
@property (assign) CGFloat rotation;

/****************************************************************************
 @name Flipping
 ****************************************************************************/

/**
 Boolean value indicating whether receiver is currently flipped
 vertically.
 */
@property (assign) BOOL isFlippedVertically;

/**
 Boolean value indicating whether receiver is currently flipped
 horizontally.
 */
@property (assign) BOOL isFlippedHorizontally;

@end
