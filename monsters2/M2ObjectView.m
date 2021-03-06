//
//  M2ObjectView.m
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2ObjectView.h"
#import "M2CanvasView.h"

NSString * const M2ObjectViewSelectedNotification = @"M2ObjectViewSelected";

@implementation M2ObjectView

@synthesize object, isDragging, isResizing, isSelected, mouseDownLocation, mouseDownFrame, resizeHandle, canvasView;
@synthesize rotation, isFlippedHorizontally, isFlippedVertically;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isDragging = NO;
        self.isResizing = NO;
        self.rotation = 0.0;
        self.isFlippedVertically = NO;
        self.isFlippedHorizontally = NO;
        self.resizeHandle = [[M2ResizeHandleView alloc] initWithFrame:NSMakeRect(frame.size.width-10, 0, 10, 10)];
        [self.resizeHandle setAutoresizingMask:NSViewMinXMargin];
        [self addSubview:self.resizeHandle];
    }
    
    return self;
}

- (BOOL)isFlipped {
    return NO;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor whiteColor] set];
//    NSRectFill([self bounds]);
    
    if (self.isSelected && [NSGraphicsContext currentContextDrawingToScreen]) {
        [[NSColor grayColor] set];
        NSBezierPath *outline = [NSBezierPath bezierPathWithRect:[self bounds]];
        [outline setLineWidth:2.0];
        [outline stroke];
    }
    
    if (!object) {
        NSLog(@"Error: No object associated with the view");
        return;
    }
    

    NSArray *paths = object.paths;
    for (NSDictionary *wrapper in paths) {
        NSBezierPath *path = [[wrapper objectForKey:@"path"] copy];
        NSColor *background = [wrapper objectForKey:@"background"];
        NSColor *stroke = [wrapper objectForKey:@"stroke"];
        // TODO: Frame, stroke, background, etc.
        NSAffineTransform *transform = [NSAffineTransform transform];
        NSSize size = [self bounds].size;
        float x = size.width / object.bounds.width;
        float y = size.height / object.bounds.height;
        [transform translateXBy:size.width/2 yBy:size.height/2];
        [transform rotateByDegrees:-self.rotation];
        if (self.isFlippedHorizontally) [transform scaleXBy:-1 yBy:1];
        if (self.isFlippedVertically) [transform scaleXBy:1 yBy:-1];
        [transform translateXBy:-size.width/2 yBy:-size.height/2];
        [transform scaleXBy:x yBy:y];
        
        [path transformUsingAffineTransform:transform];
        [background set];
        [path fill];
        [stroke set];
        [path setLineWidth:3.0];
        [path stroke];
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    if ([self hitTest:[theEvent locationInWindow]] == self.resizeHandle) {
        self.isResizing = YES;
    } else {
        self.isDragging = YES;
    }
    self.mouseDownLocation = [theEvent locationInWindow];
    self.mouseDownFrame = self.frame;
    [self makeSelected];
}

- (void)mouseUp:(NSEvent *)theEvent {
    self.isDragging = NO;
    self.isResizing = NO;
    [self.canvasView objectViewDidChange:self];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    NSPoint location = [theEvent locationInWindow];
    float deltaX = location.x - self.mouseDownLocation.x;
    float deltaY = location.y - self.mouseDownLocation.y;
    NSRect frame = NSMakeRect(self.mouseDownFrame.origin.x, self.mouseDownFrame.origin.y, self.mouseDownFrame.size.width, self.mouseDownFrame.size.height); // TODO: Copy the struct (how?)
    
    if (self.isDragging) {
        frame.origin.x += deltaX;
        frame.origin.y += deltaY;
    }
    
    if (self.isResizing) {
        frame.size.width += deltaX;
        frame.size.height -= deltaY;
        frame.origin.y += deltaY;
    }
    
    self.frame = frame;
    [self setNeedsDisplay:YES];
}

#pragma mark - Selecting

- (void)deselect {
    self.isSelected = NO;
    [self setNeedsDisplay:YES];
}

- (void)makeSelected {
    if (!self.isSelected) {
        [self.canvasView objectViewDidSelect:self];
        self.isSelected = YES;
        [self.canvasView moveObjectViewToFront:self];
        [self setNeedsDisplay:YES];
    }
}



@end
