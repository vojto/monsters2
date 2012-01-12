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

@implementation M2CanvasView

@synthesize objectsController, objectViews;

- (void)awakeFromNib {
    self.objectViews = [NSMutableArray array];
    NSLog(@"observing this array controller -> %@", self.objectsController);
    [self.objectsController addObserver:self forKeyPath:@"arrangedObjects" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self.objectsController addObserver:self forKeyPath:@"selectedObjects" options:0 context:nil];
}

- (void)_updateObjects {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.objectViews removeAllObjects];
    
    for (M2CanvasObject *canvasObject in self.objectsController.arrangedObjects) {
        M2Object *object = [NSKeyedUnarchiver unarchiveObjectWithData:canvasObject.object];
        NSRect rect = NSRectFromString(canvasObject.frame);
        M2ObjectView *view = [[M2ObjectView alloc] initWithFrame:rect];
        view.canvasView = self;
        view.object = object;
        [self addSubview:view];
        [self.objectViews addObject:view];
    }
}

- (void)_updateSelection {
    NSIndexSet *indexes = [self.objectsController selectionIndexes];
    if ([indexes count] == 0) return;
    NSInteger index = [indexes lastIndex];
    NSLog(@"Updating selection according to index %d", (int)index);
    M2ObjectView *objectView = [self.objectViews objectAtIndex:index];
    [objectView makeSelected];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"arrangedObjects"]) {
        [self _updateObjects];
    } else if ([keyPath isEqualToString:@"selectedObjects"]) {
        [self _updateSelection];
    }
}

- (M2CanvasObject *)_canvasObjetForView:(M2ObjectView *)view {
    NSInteger index = [self.objectViews indexOfObject:view];
    return [[self.objectsController arrangedObjects] objectAtIndex:index];
}

- (void)objectViewDidChange:(M2ObjectView *)objectView {
    M2CanvasObject *canvasObject = [self _canvasObjetForView:objectView];
    canvasObject.frame = NSStringFromRect(objectView.frame);
}

- (void)objectViewDidSelect:(M2ObjectView *)objectView {
    M2CanvasObject *canvasObject = [self _canvasObjetForView:objectView];
    [self.objectsController setSelectedObjects:[NSArray arrayWithObject:canvasObject]];
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor colorWithPatternImage:[NSImage imageNamed:@"canvas-pattern.png"]] set];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
