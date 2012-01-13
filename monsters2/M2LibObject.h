//
//  M2LibObject.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Used for managing objects in library.
*/
@interface M2LibObject : NSManagedObject

/****************************************************************************
 @name Properties for user interface
 ****************************************************************************/

/**
 Human object name. Displayed in library table view.
*/
@property (nonatomic, retain) NSString * name;

/**
 Serialized representation of thumbnail for library object. 
*/
@property (nonatomic, retain) NSData * thumbnail;

/****************************************************************************
 @name Working with object
 ****************************************************************************/

/**
 Serialized representation of M2Object in form of NSData.
 
 @see M2Object
 */
@property (nonatomic, retain) NSData * object;

/****************************************************************************
 @name Generating thumbnails
 ****************************************************************************/

/**
 Generates small thumbnail for current library object.
*/
- (void)generateThumbnail;

@end
