//
//  M2Object.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Táto trieda je modelom, ktorý reprezentuje jeden "objekt", teda jednu časť príšerky.
 Je použitý v objektoch typu M2LibObject a M2CanvasObject pre skladovanie objektov
 v knižnici a pre pridávanie objektov na plátno.
 
 @see M2LibObject
 @see M2CanvasObject
*/
@interface M2Object : NSObject <NSCoding>

@property (assign) NSSize bounds;
@property (retain) NSMutableArray *paths;

- (void)addPath:(NSBezierPath *)path;
- (void)addPath:(NSBezierPath *)path withBackground:(NSColor *)background stroke:(NSColor *)stroke;

@end
