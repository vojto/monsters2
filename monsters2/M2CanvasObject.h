//
//  M2CanvasObject.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface M2CanvasObject : NSManagedObject

@property (nonatomic, retain) NSData * object;
@property (nonatomic, retain) NSString * frame;
@property (nonatomic, retain) NSNumber * rotation;
@property (nonatomic, retain) NSNumber * isFlippedHorizontally;
@property (nonatomic, retain) NSNumber * isFlippedVertically;

@end
