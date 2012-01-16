//
//  M2GalleryController.h
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2GalleryEntry.h"

/**
 Spravuje okno galérie.
 
 - Používa triedu typu `NSArrayController` pre správu položiek v galérii
 - Implementuje akciu `openAction:` pre otvorenie položky z galérie po
 kliknutí na tlačítko.

 @see M2GalleryEntry
*/
@interface M2GalleryController : NSWindowController

/**
 Ovládač poľa zodpovedný za správu položiek v galérii
*/
@property (assign) IBOutlet NSArrayController *arrayController;

/****************************************************************************
 @name Otváranie položiek v galérii
 ****************************************************************************/

/**
 Akcia pre otváranie položky v galérii. Nájde objekt položky na základe 
 parametra `sender`. Tento parameter musí byť v hierarchií zobrazení priamo
 pod zobrazením položky kolekcie.
*/
- (IBAction)openAction:(id)sender;

/**
 Otvorí dokument pre danú položku. V prípade chyby neurobí nič.
*/
- (void)openEntry:(M2GalleryEntry *)entry;

@end

