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
#import "M2GalleryEntry.h"
#import "XMLReader.h"
#import "NSColor+HexParsing.h"

@interface M2Document (PrivateMethods)

- (void)_saveFileToGallery;
- (NSData *)_thumbnailData;

@end

@implementation M2Document
@synthesize exportFormatButton;
@synthesize libObjectsController;
@synthesize canvasView;
@synthesize canvasObjectsController;
//@synthesize galleryAddButton;
@synthesize exportView;

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
    


}

- (IBAction)testAction:(id)sender {
    NSLog(@"Saving shared context %@", self.sharedContext);
    [self.canvasView setNeedsDisplay:YES];
    
    [self.libObjectsController.arrangedObjects makeObjectsPerformSelector:@selector(generateThumbnail)];
    
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

#pragma mark - Adding to gallery

- (BOOL)isSaved {
    return !![self fileURL];
}


- (IBAction)galleryAddAction:(id)sender {
    [[self window] makeFirstResponder:nil];

    [self _saveFileToGallery];

    // Create a gallery entry for that path
    // Generate a thumbnail
}

- (void)_saveFileToGallery {
    // Save file to Library/Gallery if it's not saved
    NSString *name = [self displayName];
    NSError *error = nil;
    
    NSURL *gallery = [[self.documentController applicationFilesDirectory] URLByAppendingPathComponent:@"Gallery"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createDirectoryAtURL:gallery withIntermediateDirectories:YES attributes:nil error:nil];
    NSURL *url = [gallery URLByAppendingPathComponent:name];
    if (![[url pathExtension] isEqualToString:@"xml"]) {
        url = [url URLByAppendingPathExtension:@"xml"];
    }
    [self saveToURL:url ofType:@"XML" forSaveOperation:NSSaveOperation error:&error];
    if (error) NSLog(@"Couldn't save file to gallery: %@", error);

    M2GalleryEntry *entry = [M2GalleryEntry MR_findFirstByAttribute:@"path" withValue:[url path] inContext:self.sharedContext];
    if (!entry) {
        NSLog(@"Creating new gallery entry for %@", [url path]);
        entry = [NSEntityDescription insertNewObjectForEntityForName:@"GalleryEntry" inManagedObjectContext:self.sharedContext];
    }
    
    entry.name = [name stringByReplacingOccurrencesOfString:@".xml" withString:@""];
    entry.path = [url path];
    entry.thumbnail = [self _thumbnailData];
    [self.sharedContext save:nil];
}

- (NSData *)_thumbnailData {
    return [NSArchiver archivedDataWithRootObject:[self.canvasView thumbnailImage]];
}

- (IBAction)exportAction:(id)sender {
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setAccessoryView:self.exportView];
//    [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"jpg", @"bmp", nil]];
    [panel setAllowsOtherFileTypes:NO];
    [panel setExtensionHidden:NO];
    [panel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result) {
        NSURL *url = [panel URL];
        NSString *format = [self.exportFormatButton titleOfSelectedItem];
        [self exportToURL:url withFormat:format];
    }];
}

- (void)exportToURL:(NSURL *)url withFormat:(NSString *)format {
    url = [url URLByAppendingPathExtension:[format lowercaseString]];
    NSImage *image = [self.canvasView contentsImage];
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    if ([format isEqualToString:@"JPG"]) {
        NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.7] forKey:NSImageCompressionFactor];
        imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    } else if ([format isEqualToString:@"BMP"]) {
        imageData = [imageRep representationUsingType:NSBMPFileType properties:nil];
    } else {
        NSLog(@"Error: Unknown format %@", format);
    }
    
    [imageData writeToFile:[url path] atomically:NO];
}


#pragma mark - General helpers

- (NSWindow *)window {
    return [[[self windowControllers] lastObject] window];
}

#pragma mark - Exporting

- (NSArray *)exportFormats {
    return [NSArray arrayWithObjects:@"JPG", @"BMP", nil];
}

#pragma mark - Printing

- (NSPrintOperation *)printOperationWithSettings:(NSDictionary *)printSettings error:(NSError **)outError {
    NSPrintInfo *info = [self printInfo];
    [info setScalingFactor:0.5];
    NSPrintOperation *op = [NSPrintOperation
                            printOperationWithView:self.canvasView
                            printInfo:info];
    return op;
}

- (IBAction)importAction:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.allowedFileTypes = [NSArray arrayWithObject:@"svg"];
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result != NSFileHandlingPanelOKButton) return;
//        [self performSelectorInBackground:@selector(importSVGByURL:) withObject:panel.URL];
        [self importSVGByURL:panel.URL];
    }];
}

typedef enum _M2PointType {
    M2PointMove,
    M2PointLine,
    M2PointCurve
} M2PointType;

typedef struct _M2Point {
    float x, y;
    float c1x, c1y, c2x, c2y;
    M2PointType type;
} M2Point;

- (void)_extractPointsFromData:(NSString *)data toCArray:(M2Point *)points count:(int *)count {
    int i = 0;
    data = [data stringByReplacingOccurrencesOfString:@"M " withString:@"$M "];
    data = [data stringByReplacingOccurrencesOfString:@"L " withString:@"$L "];
    data = [data stringByReplacingOccurrencesOfString:@"C " withString:@"$C "];
    NSArray *comps = [data componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"$"]];
    for (NSString *comp in comps) {
        M2Point point;
        if ([comp length] == 0) continue;
        if ([comp characterAtIndex:0] == 'M') {
            sscanf([comp cStringUsingEncoding:NSUTF8StringEncoding], "M %f %f", &point.x, &point.y);
            point.type = M2PointMove;
        } else if ([comp characterAtIndex:0] == 'L') {
            sscanf([comp cStringUsingEncoding:NSUTF8StringEncoding], "L %f %f", &point.x, &point.y);
            point.type = M2PointLine;
        } else if ([comp characterAtIndex:0] == 'C') {
            sscanf([comp cStringUsingEncoding:NSUTF8StringEncoding], "C %f %f %f %f %f %f", &point.c1x, &point.c1y, &point.c2x, &point.c2y, &point.x, &point.y);
            point.type = M2PointCurve;
        }
        points[i++] = point;
        *count = i;
    }

    // Add zero to the end of array maybe?
}

//- (void)_cropPoints:(M2Point *)points count:(int)count {
//    float minX = -1, maxX = -1, minY = -1, maxY = -1;
//    
//    for (int i = 0; i < count; i++) {
//        if (points[i].x < minX || minX == -1) minX = points[i].x;
//        if (points[i].x > maxX || maxX == -1) maxX = points[i].x;
//        if (points[i].y < minY || minY == -1) minY = points[i].y;
//        if (points[i].y > maxY || maxY == -1) maxY = points[i].x;
//    }
//    
//    NSLog(@"Here are the maxims: %f %f %f %f", minX, maxX, minY, maxY);
//}

- (void)importSVGByURL:(NSURL *)url {
    NSError *error = nil;
    NSString *contents = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (error) [NSApp presentError:error];
    NSDictionary *data = [XMLReader dictionaryForXMLString:contents error:&error];
    if (error) [NSApp presentError:error];
    
    // Fugly parsing code. Don't look. Don't. Look.
    NSDictionary *svg = [data objectForKey:@"svg"];
    int width = [[svg objectForKey:@"@width"] intValue];
    int height = [[svg objectForKey:@"@height"] intValue];
    NSArray *groups = [[svg objectForKey:@"g"] objectForKey:@"g"];
    for (NSDictionary *group in groups) {
        NSArray *paths = [group objectForKey:@"path"];
        M2Object *object = [[M2Object alloc] init];
        object.bounds = NSMakeSize(width, height);
        for (NSDictionary *path in paths) {
            M2Point points[200];
            int count;
            NSBezierPath *path2 = [NSBezierPath bezierPath];
            NSString *data = [path objectForKey:@"@d"];
            NSString *fill = [[path objectForKey:@"@fill"] stringByReplacingOccurrencesOfString:@"#" withString:@""];
            NSColor *color;
            if (fill) {
                color = [NSColor colorWithHexColorString:fill];
            } else {
                color = [NSColor clearColor];
            }
            [self _extractPointsFromData:data toCArray:points count:&count];
//            [self _cropPoints:points count:count];
            for (int i = 0; i < count; i++) {
                points[i].y = height - points[i].y;
                points[i].c1y = height - points[i].c1y;
                points[i].c2y = height - points[i].c2y;
                switch (points[i].type) {
                    case M2PointMove:
                        [path2 moveToPoint:NSMakePoint(points[i].x, points[i].y)];
                        break;
                    case M2PointLine:
                        [path2 lineToPoint:NSMakePoint(points[i].x, points[i].y)];
                        break;
                    case M2PointCurve:
                        [path2 curveToPoint:NSMakePoint(points[i].x, points[i].y) controlPoint1:NSMakePoint(points[i].c1x, points[i].c1y) controlPoint2:NSMakePoint(points[i].c2x, points[i].c2y)];
                        break;
                    default:
                        break;
                }
            }

            NSLog(@"Color: %@ %@", fill, color);
            [object addPath:path2 withBackground:color stroke:[NSColor blackColor]];
        }
        M2LibObject *lib2 = [NSEntityDescription insertNewObjectForEntityForName:@"LibObject" inManagedObjectContext:self.sharedContext];
        lib2.object = [NSKeyedArchiver archivedDataWithRootObject:object];
        lib2.name = [group objectForKey:@"title"];
        [lib2 generateThumbnail];
        [self.sharedContext save:nil];
    }
//    NSLog(@"%@", paths);
    
}



@end
