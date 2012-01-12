//
//  M2ResizeHandleView.m
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2ResizeHandleView.h"
#import "M2ObjectView.h"

@implementation M2ResizeHandleView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    if ([NSGraphicsContext currentContextDrawingToScreen] && [(M2ObjectView *)self.superview isSelected]) {
        [[NSColor grayColor] set];
        NSRectFill([self bounds]);
    }
}

@end
