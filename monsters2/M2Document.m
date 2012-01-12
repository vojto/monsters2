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
//    M2Object *object1 = [[M2Object alloc] init];
//    NSBezierPath *path = [NSBezierPath bezierPath];
//    [path moveToPoint:NSMakePoint(183.977, 65.9917)];
//    [path curveToPoint:NSMakePoint(334.9581, 260.9674) controlPoint1:NSMakePoint(238.9159, 68.4335) controlPoint2:NSMakePoint(341.9572, 228.9714)];
//    [path curveToPoint:NSMakePoint(254.9681, 279.965) controlPoint1:NSMakePoint(327.959, 292.9634) controlPoint2:NSMakePoint(270.9661, 261.9672)];
//    [path curveToPoint:NSMakePoint(202.9746, 354.9556) controlPoint1:NSMakePoint(238.9701, 297.9627) controlPoint2:NSMakePoint(239.97, 355.9555)];
//    [path curveToPoint:NSMakePoint(170.9786, 266.9666) controlPoint1:NSMakePoint(165.9792, 353.9557) controlPoint2:NSMakePoint(184.9769, 283.9645)];
//    [path curveToPoint:NSMakePoint(89.9887, 266.9666) controlPoint1:NSMakePoint(156.9804, 249.9687) controlPoint2:NSMakePoint(102.9871, 299.9625)];
//    [path curveToPoint:NSMakePoint(183.977, 65.9917) controlPoint1:NSMakePoint(76.9904, 233.9707) controlPoint2:NSMakePoint(138.9826, 63.992)];
//    [object1 addPath:path];
//    object1.bounds = NSMakeSize(340, 360);
    
    M2Object *object2 = [[M2Object alloc] init];
    object2.bounds = NSMakeSize(295.0, 161.0);
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(10.4987, 60.9924)];
    [path curveToPoint:NSMakePoint(278.4652, 74.4907) controlPoint1:NSMakePoint(34.4957, 112.9859) controlPoint2:NSMakePoint(138.9826, 227.9715)];
    [path curveToPoint:NSMakePoint(10.4987, 60.9924) controlPoint1:NSMakePoint(185.9767, -35.4956) controlPoint2:NSMakePoint(31.996, 34.4957)];
    [object2 addPath:path];
    
    path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(192.4759, 105.9867)];
    [path curveToPoint:NSMakePoint(234.4707, 72.7409) controlPoint1:NSMakePoint(215.669, 105.9867) controlPoint2:NSMakePoint(234.4707, 91.1021)];
    [path curveToPoint:NSMakePoint(192.4759, 39.4951) controlPoint1:NSMakePoint(234.4707, 54.3797) controlPoint2:NSMakePoint(215.669, 39.4951)];
    [path curveToPoint:NSMakePoint(150.4812, 72.7409) controlPoint1:NSMakePoint(169.2829, 39.4951) controlPoint2:NSMakePoint(150.4812, 54.3797)];
    [path curveToPoint:NSMakePoint(192.4759, 105.9867) controlPoint1:NSMakePoint(150.4812, 91.1021) controlPoint2:NSMakePoint(169.2829, 105.9867)];
    [object2 addPath:path withBackground:[NSColor blackColor] stroke:[NSColor blackColor]];
    
//    M2LibObject *lib2 = [NSEntityDescription insertNewObjectForEntityForName:@"LibObject" inManagedObjectContext:self.sharedContext];
//    lib2.object = [NSKeyedArchiver archivedDataWithRootObject:object2];
//    lib2.name = @"Colorful Eye";
//    [self.sharedContext save:nil];
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
    [self.sharedContext save:nil];
}

- (IBAction)instantiateAction:(id)sender {
    NSArray *selected = self.libObjectsController.selectedObjects;
    M2LibObject *libObject = [selected lastObject];
    M2CanvasObject *canvasObject = [NSEntityDescription insertNewObjectForEntityForName:@"CanvasObject" inManagedObjectContext:self.managedObjectContext];
    canvasObject.object = [libObject.object copy];
    canvasObject.frame = NSStringFromRect(NSMakeRect(30, 30, 500, 500));
    NSLog(@"Adding new object to canvasObjectsController: %@", canvasObject);
    [self.canvasObjectsController addObject:canvasObject];
}

#pragma mark - Removing Objects

- (void)removeAction:(id)sender {
    M2CanvasObject *selected = [[self.canvasObjectsController selectedObjects] lastObject];
    if (selected) [self.canvasObjectsController removeObject:selected];
}

@end
