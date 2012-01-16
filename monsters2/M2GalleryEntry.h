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
 Reprezentuje položku v galérii
 */
@interface M2GalleryEntry : NSManagedObject

/****************************************************************************
 @name Základné vlastnosti
 ****************************************************************************/

/**
 Názov položky v galérií. Zadané používateľom. 
 */
@property (nonatomic, retain) NSString * name;

/**
 Cesta k položke v galérii. Je automatický vybratá ovládačom, ktorý je
 zodpovedný za vytvorenie položky v galérii.
 */
@property (nonatomic, retain) NSString * path;

/****************************************************************************
 @name Práca s ukážkou
 ****************************************************************************/

/**
 Serializovaný obrázok ukážky pre položku v galérii.
 */
@property (nonatomic, retain) NSData * thumbnail;

@end
