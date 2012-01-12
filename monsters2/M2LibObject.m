//
//  M2LibObject.m
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2LibObject.h"
#import "M2ObjectView.h"

const CGFloat M2LibObjectThumbWidth = 50.0;
const CGFloat M2LibObjectThumbHeight = 50.0;

@implementation M2LibObject

@dynamic name;
@dynamic object;
@dynamic thumbnail;

- (void)generateThumbnail {
    NSLog(@"Lib object is about to be saved, generating thumbnail...");
    
    M2ObjectView *objectView = [[M2ObjectView alloc] initWithFrame:NSMakeRect(0, 0, M2LibObjectThumbWidth, M2LibObjectThumbHeight)];
    objectView.object = [NSKeyedUnarchiver unarchiveObjectWithData:self.object];
    
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(M2LibObjectThumbWidth, M2LibObjectThumbHeight)];
    [image lockFocus];
    
    [objectView drawRect:objectView.bounds];
    
    [image unlockFocus];
    
    self.thumbnail = [NSArchiver archivedDataWithRootObject:image];
}

@end
