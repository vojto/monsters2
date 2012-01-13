//
//  M2Object.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Represents data in one object. This class is used in M2LibObject to store
 objects in library and in M2CanvasObjects to compose objects on the canvas.
 
 @see M2LibObject
 @see M2CanvasObject
 */
@interface M2Object : NSObject <NSCoding>

/****************************************************************************
 @name Managing bounds
 ****************************************************************************/

/**
 Size of objects. Bezier paths must be inside this bounds.
 */
@property (assign) NSSize bounds;

/****************************************************************************
 @name Managing paths
 ****************************************************************************/

/**
 Array of paths. Each entry is a NSDictionary with the following keys:
 
 - **path**: NSBezierPath with path of object element
 - **background**: Background color of path
 - **stroke**: Stroke color of path
 */
@property (retain) NSMutableArray *paths;

/**
 Adds path to object with default colors
 */
- (void)addPath:(NSBezierPath *)path;

/**
 Adds path to object, with specified colors for background and stroke.
 */
- (void)addPath:(NSBezierPath *)path withBackground:(NSColor *)background stroke:(NSColor *)stroke;

@end
