//
//  ImageView.m
//  Icon grab
//
//  Created by Hickey, Jimmy on 1/25/13.
//  Copyright (c) 2013 Hickey, Jimmy. All rights reserved.
//

#import "ImageView.h"
@implementation ImageView

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask])
		== NSDragOperationGeneric)
    {
        return NSDragOperationGeneric;
    }
    else
    {
        return NSDragOperationNone;
    }
}



- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *paste = [sender draggingPasteboard];
	
    NSArray *types = [NSArray arrayWithObjects:NSFilenamesPboardType, nil];
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
	
    if (nil == carriedData)
    {

        NSRunAlertPanel(@"Paste Error", @"Operation failed",
						nil, nil, nil);
        return NO;
    }
    else
    {
        if ([desiredType isEqualToString:NSFilenamesPboardType])
        {

            NSArray *fileArray =
			[paste propertyListForType:@"NSFilenamesPboardType"];

            NSString *path = [fileArray objectAtIndex:0];
			NSImage *newImage = [[NSWorkspace sharedWorkspace] iconForFile:path];
            NSString *theFileName = [[path lastPathComponent] stringByAppendingString:@".png"];
            NSImage *smallImage = [[NSImage alloc] initWithSize: NSMakeSize(128,128)];
            [smallImage lockFocus];
            [newImage setSize:NSMakeSize(128,128)];
            [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
            [newImage compositeToPoint:NSZeroPoint operation:NSCompositeCopy];
            [smallImage unlockFocus];
            
            
            if (nil == newImage)
            {
                NSRunAlertPanel(@"File Reading Error",
								[NSString stringWithFormat:
								 @"Failed to open the file at \"%@\"",
								 path], nil, nil, nil);
                return NO;
            }
            else
            {
				[self setImage:smallImage];
                
                
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *storedPath = [[defaults stringForKey:@"Path"] stringByAppendingString:@"/"];
                
            
                
                
                NSString *pathWithFile = [storedPath stringByAppendingString:theFileName];
                
                
                
               
                NSData *imageData = [smallImage TIFFRepresentation];
                NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
                NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0]    forKey:NSImageCompressionFactor];
                imageData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
                [imageData writeToFile:pathWithFile atomically:NO];
      
            }
  
        }
        else
        {
            NSAssert(NO, @"This can't happen");
            return NO;
        }
    }
    [self setNeedsDisplay:YES];
    return YES;
}

@end
