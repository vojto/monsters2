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

@interface M2ObjectView : NSView

#pragma mark - Model
@property (retain) M2Object *object;

#pragma mark - Resizing
@property (retain) NSView *resizeHandle;

#pragma mark - Dragging
@property (assign) BOOL isDragging;
@property (assign) BOOL isResizing;
@property (assign) NSPoint mouseDownLocation;
@property (assign) NSRect mouseDownFrame;

@end
