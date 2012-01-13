//
//  M2CanvasView.m
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2CanvasView.h"
#import "M2Document.h"
#import "M2Object.h"
#import "M2ObjectView.h"
#import "M2CanvasView+PrivateMethods.h"

@implementation M2CanvasView

@synthesize objectsController, objectViews;

- (void)awakeFromNib {
    self.objectViews = [NSMutableArray array];
    NSLog(@"observing this array controller -> %@", self.objectsController);
    [self.objectsController addObserver:self forKeyPath:@"arrangedObjects" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self.objectsController addObserver:self forKeyPath:@"selectedObjects" options:0 context:nil];
    [self.objectsController addObserver:self forKeyPath:@"selection.rotation" options:0 context:nil];
    [self.objectsController addObserver:self forKeyPath:@"selection.isFlippedVertically" options:0 context:nil];
    [self.objectsController addObserver:self forKeyPath:@"selection.isFlippedHorizontally" options:0 context:nil];
}

#pragma mark - Observing objects

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"arrangedObjects"]) {
        [self _updateObjects];
    } else if ([keyPath isEqualToString:@"selectedObjects"]) {
        [self _updateSelection];
    } else if ([keyPath rangeOfString:@"selection."].location != NSNotFound) {
        [self _updateSelectionFromSelectedObject];
    }
}

#pragma mark - Updating objects

- (void)_updateObjects {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.objectViews removeAllObjects];
    
    for (M2CanvasObject *canvasObject in self.objectsController.arrangedObjects) {
        NSRect rect = NSRectFromString(canvasObject.frame);
        M2ObjectView *view = [[M2ObjectView alloc] initWithFrame:rect];
        [self _updateView:view fromObject:canvasObject];
    }
}

- (void)_updateView:(M2ObjectView *)view fromObject:(M2CanvasObject *)canvasObject {
    M2Object *object = [NSKeyedUnarchiver unarchiveObjectWithData:canvasObject.object];
    view.canvasView = self;
    view.object = object;
    view.rotation = [canvasObject.rotation floatValue];
    view.isFlippedVertically = [canvasObject.isFlippedVertically boolValue];
    view.isFlippedHorizontally = [canvasObject.isFlippedHorizontally boolValue];
    [self addSubview:view];
    [self.objectViews addObject:view];
}

#pragma mark - Updating object selection

- (void)_updateSelection {
    for (M2ObjectView *view in self.objectViews) {
        [view deselect];
    }
    M2ObjectView *objectView = [self _viewForSelection];
    if (objectView) [objectView makeSelected];
}

- (M2ObjectView *)_viewForSelection {
    NSIndexSet *indexes = [self.objectsController selectionIndexes];
    if ([indexes count] == 0) return nil;
    NSInteger index = [indexes lastIndex];
    return [self.objectViews objectAtIndex:index];
}

#pragma mark - Updating properties of selected object

- (void)_updateSelectionFromSelectedObject {
    M2ObjectView *view = [self _viewForSelection];
    M2CanvasObject *object = [[self.objectsController selectedObjects] lastObject];
    if (!object) return;
    [self _updateView:view fromObject:object];
    [view setNeedsDisplay:YES];
}

#pragma mark - Updating models according to changes on canvas

- (void)objectViewDidChange:(M2ObjectView *)objectView {
    M2CanvasObject *canvasObject = [self _canvasObjetForView:objectView];
    canvasObject.frame = NSStringFromRect(objectView.frame);
}

- (void)objectViewDidSelect:(M2ObjectView *)objectView {
    M2CanvasObject *canvasObject = [self _canvasObjetForView:objectView];
    [self.objectsController setSelectedObjects:[NSArray arrayWithObject:canvasObject]];
}

- (M2CanvasObject *)_canvasObjetForView:(M2ObjectView *)view {
    NSInteger index = [self.objectViews indexOfObject:view];
    return [[self.objectsController arrangedObjects] objectAtIndex:index];
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect {
    if ([NSGraphicsContext currentContextDrawingToScreen]) {
        [[NSColor colorWithPatternImage:[NSImage imageNamed:@"canvas-pattern.png"]] set];
        NSRectFill(dirtyRect);
    }
    [super drawRect:dirtyRect];
}

#pragma mark - Generating contents image

- (NSImage *)contentsImage {
    [self.objectsController setSelectionIndexes:[NSIndexSet indexSet]];
    NSImage *image = [[NSImage alloc] initWithSize:self.bounds.size];
    [image lockFocus];
    for (M2ObjectView *subview in self.subviews) {
        NSAffineTransform *transform = [NSAffineTransform transform];
        [transform translateXBy:subview.frame.origin.x yBy:subview.frame.origin.y];
        [transform concat];
        
        [subview drawRect:[subview bounds]];
        
        [transform invert];
        [transform concat];
    }
    [image unlockFocus];
    return image;
}

- (NSImage *)thumbnailImage {
    NSImage *image = [self contentsImage];
    NSSize originalSize = [image size];
    NSImage *resizedImage = [[NSImage alloc] initWithSize:NSMakeSize(200, 200)];

    [resizedImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, 200, 200) fromRect:NSMakeRect(0, 0, originalSize.width, originalSize.height) operation:NSCompositeSourceOver fraction:1.0];
    [resizedImage unlockFocus];

    return resizedImage;
}

#pragma mark - Moving order of objects

- (void)moveObjectViewToFront:(M2ObjectView *)objectView {
    [self addSubview:objectView];
}

@end
