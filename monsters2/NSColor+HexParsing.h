//
//  NSColor+HexParsing.h
//  monsters2
//
//  Created by Rinik Vojto on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSColor (HexParsing)

+ (NSColor*)colorWithHexColorString:(NSString*)inColorString;

@end
