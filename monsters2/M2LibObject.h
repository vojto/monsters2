//
//  M2LibObject.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface M2LibObject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * object;

@end
