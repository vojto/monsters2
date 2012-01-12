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
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
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

- (void)objectViewDidChange:(M2ObjectView *)objectView {
    NSInteger index = [self.objectViews indexOfObject:objectView];
    M2CanvasObject *canvasObject = [[self.objectsController arrangedObjects] objectAtIndex:index];
    canvasObject.frame = NSStringFromRect(objectView.frame);
}

@end
