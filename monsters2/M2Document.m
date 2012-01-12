//
//  M2Document.m
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2Document.h"
#import "M2DocumentController.h"
#import "M2Object.h"
#import "M2LibObject.h"
#import "M2ObjectView.h"
#import "M2CanvasObject.h"

@implementation M2Document
@synthesize libObjectsController;
@synthesize canvasView;
@synthesize canvasObjectsController;

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)windowNibName {
    return @"M2Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return NO;
}

/*
- (void)saveToFile:(NSString *)fileName saveOperation:(NSSaveOperationType)saveOperation delegate:(id)delegate didSaveSelector:(SEL)didSaveSelector contextInfo:(void *)contextInfo {
    [super saveToFile:fileName saveOperation:saveOperation delegate:delegate didSaveSelector:didSaveSelector contextInfo:contextInfo];
    [self.documentController saveShared];
}
 */

- (BOOL)writeToURL:(NSURL *)absoluteURL ofType:(NSString *)typeName forSaveOperation:(NSSaveOperationType)saveOperation originalContentsURL:(NSURL *)absoluteOriginalContentsURL error:(NSError **)error {
    return [super writeToURL:absoluteURL ofType:typeName forSaveOperation:saveOperation originalContentsURL:absoluteOriginalContentsURL error:error];
}

- (M2DocumentController *)documentController {
    return [NSDocumentController sharedDocumentController];;
}

- (NSManagedObjectContext *)sharedContext {
    return self.documentController.managedObjectContext;
}

- (void)awakeFromNib {
    NSLog(@"Awaken from nib");
    
    // Load some test objects
    M2Object *object1 = [[M2Object alloc] init];
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(183.977, 65.9917)];
    [path curveToPoint:NSMakePoint(334.9581, 260.9674) controlPoint1:NSMakePoint(238.9159, 68.4335) controlPoint2:NSMakePoint(341.9572, 228.9714)];
    [path curveToPoint:NSMakePoint(254.9681, 279.965) controlPoint1:NSMakePoint(327.959, 292.9634) controlPoint2:NSMakePoint(270.9661, 261.9672)];
    [path curveToPoint:NSMakePoint(202.9746, 354.9556) controlPoint1:NSMakePoint(238.9701, 297.9627) controlPoint2:NSMakePoint(239.97, 355.9555)];
    [path curveToPoint:NSMakePoint(170.9786, 266.9666) controlPoint1:NSMakePoint(165.9792, 353.9557) controlPoint2:NSMakePoint(184.9769, 283.9645)];
    [path curveToPoint:NSMakePoint(89.9887, 266.9666) controlPoint1:NSMakePoint(156.9804, 249.9687) controlPoint2:NSMakePoint(102.9871, 299.9625)];
    [path curveToPoint:NSMakePoint(183.977, 65.9917) controlPoint1:NSMakePoint(76.9904, 233.9707) controlPoint2:NSMakePoint(138.9826, 63.992)];
    [object1 addPath:path];
    object1.bounds = NSMakeSize(340, 360);
    
    /*

    M2LibObject *lib1 = [NSEntityDescription insertNewObjectForEntityForName:@"LibObject" inManagedObjectContext:self.sharedContext];
    lib1.object = [NSKeyedArchiver archivedDataWithRootObject:object1];
    lib1.name = @"Ghost";
    [self.sharedContext save:nil];
    */
    
    
    
//    M2ObjectView *view = [[M2ObjectView alloc] initWithFrame:NSMakeRect(30, 30, 500, 500)];
//    view.object = object1;
    
//    [self.canvasView addSubview:view];

}

- (IBAction)testAction:(id)sender {
    NSLog(@"Running tests...");
    NSLog(@"Document Context: %@", self.managedObjectContext);
    NSLog(@"Shared Context: %@", [self sharedContext]);
    [self.canvasView setNeedsDisplay:YES];
}

- (IBAction)instantiateAction:(id)sender {
    NSArray *selected = self.libObjectsController.selectedObjects;
    M2LibObject *libObject = [selected lastObject];
    M2CanvasObject *canvasObject = [NSEntityDescription insertNewObjectForEntityForName:@"CanvasObject" inManagedObjectContext:self.managedObjectContext];
    canvasObject.object = [libObject.object copy];
    canvasObject.frame = NSStringFromRect(NSMakeRect(30, 30, 500, 500));
    NSLog(@"Adding new object to canvasObjectsController: %@", canvasObject);
    [self.canvasObjectsController addObject:canvasObject];
    
//    M2Object *object = [NSKeyedUnarchiver unarchiveObjectWithData:libObject.object];
    
//    M2ObjectView *view = [[M2ObjectView alloc] initWithFrame:];
//    view.object = object;
    //    view.object = object1;
    // TODO: Create CanvasObject and shit
//    [self.canvasView addSubview:view];
    
}

@end
