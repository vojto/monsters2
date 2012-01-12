//
//  M2GalleryController.m
//  monsters2
//
//  Created by Rinik Vojto on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2GalleryController.h"
#import "M2DocumentController.h"

@implementation M2GalleryController
@synthesize arrayController;

- (void)openEntry:(M2GalleryEntry *)entry {
    M2DocumentController *doc = [M2DocumentController sharedDocumentController];
    if (!entry.path) {
        NSLog(@"Error: No path in entry %@", entry);
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:entry.path];
    NSError *error = nil;
    [doc openDocumentWithContentsOfURL:url display:YES error:&error];
    if (error) NSLog(@"Error opening gallery document: %@", error);
}

- (IBAction)openAction:(id)sender {
    NSView *view = [sender superview];
    NSCollectionView *collectionView = (NSCollectionView *)[view superview];
    NSInteger index = [collectionView.subviews indexOfObject:view];
    
    if (index != -1) {
        M2GalleryEntry *entry = [[self.arrayController arrangedObjects] objectAtIndex:index];
        if (entry) [self openEntry:entry];
    }
}

@end
