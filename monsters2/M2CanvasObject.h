//
//  M2CanvasObject.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


/**
 Represents object on canvas. Contains properties describing applied transformations.
 */
@interface M2CanvasObject : NSManagedObject

/****************************************************************************
 @name Working with object
 ****************************************************************************/

/**
 Serialized object.
 
 @see M2Object
 */
@property (nonatomic, retain) NSData * object;

/****************************************************************************
 @name Managing position & transformation
 ****************************************************************************/

/**
 Frame of object on canvas. 
 */
@property (nonatomic, retain) NSString * frame;

/**
 Rotation in degrees.
 */
@property (nonatomic, retain) NSNumber * rotation;

/**
 Boolean value indicating whether the object is flipped horizontally.
 */
@property (nonatomic, retain) NSNumber * isFlippedHorizontally;

/**
 Boolean value indicating whether the object is flipped vertically.
 */
@property (nonatomic, retain) NSNumber * isFlippedVertically;

@end
