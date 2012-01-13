//
//  M2GalleryEntry.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Represents a gallery entry.
 */
@interface M2GalleryEntry : NSManagedObject

/****************************************************************************
 @name Basic properties
 ****************************************************************************/

/**
 Gallery entry name. Entered by user.
 */
@property (nonatomic, retain) NSString * name;

/**
 Path to gallery entry. Selected automatically by controller that is
 responsible for create a gallery entry.
 */
@property (nonatomic, retain) NSString * path;

/****************************************************************************
 @name Working with thumbnail
 ****************************************************************************/

/**
 Serialized image of thumbnail for gallery entry.
 */
@property (nonatomic, retain) NSData * thumbnail;

@end
