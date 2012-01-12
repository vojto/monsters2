//
//  M2GalleryEntry.m
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2GalleryEntry.h"


@implementation M2GalleryEntry

@dynamic name;
@dynamic path;
@dynamic thumbnail;

+ (NSString *)MR_entityName {
    return @"GalleryEntry";
}

@end
