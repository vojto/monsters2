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

@interface M2ObjectView : NSView

#pragma mark - Hierarchy
@property (assign) M2CanvasView *canvasView;

#pragma mark - Model
@property (retain) M2Object *object;

#pragma mark - Dragging & Resizing
@property (retain) NSView *resizeHandle;
@property (assign) BOOL isDragging;
@property (assign) BOOL isResizing;
@property (assign) NSPoint mouseDownLocation;
@property (assign) NSRect mouseDownFrame;

#pragma mark - Selection
@property (assign) BOOL isSelected;

- (void)didSelectObjectView:(NSNotification *)notif;

@end
