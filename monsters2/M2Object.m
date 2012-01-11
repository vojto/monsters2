//
//  M2Object.m
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2Object.h"

@implementation M2Object

@synthesize bounds, paths;

- (id)init {
    if ((self = [super init])) {
        self.paths = [NSMutableArray array];
    }
    return self;
}

- (void)addPath:(NSBezierPath *)path {
    NSDictionary *wrapper = [NSDictionary dictionaryWithObject:[path copy] forKey:@"path"];
    [self.paths addObject:wrapper];
}

#pragma mark - Coding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.paths forKey:@"paths"];
    [coder encodeSize:self.bounds forKey:@"bounds"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.paths = [decoder decodeObjectForKey:@"paths"];
        self.bounds = [decoder decodeSizeForKey:@"bounds"];
    }
    
    return self;
}




@end
