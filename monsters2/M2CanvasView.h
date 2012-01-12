//
//  M2CanvasView.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2ObjectView.h"

@interface M2CanvasView : NSView

@property (assign) IBOutlet NSArrayController *objectsController;
@property (retain) NSMutableArray *objectViews;

- (void)objectViewDidChange:(M2ObjectView *)objectView;
- (void)objectViewDidSelect:(M2ObjectView *)objectView;

#pragma mark - Generating image with contents
- (NSImage *)contentsImage;
- (NSImage *)thumbnailImage;

#pragma mark - Moving order of objects
- (void)moveObjectViewToFront:(M2ObjectView *)objectView;

@end
