//
//  AppDelegate.m
//  Icon grab
//
//  Created by Hickey, Jimmy on 1/25/13.
//  Copyright (c) 2013 Hickey, Jimmy. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_pathLabel setStringValue:@""];
    defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Path"])
    {
        storedPath = [defaults stringForKey:@"Path"];
        [_pathLabel setStringValue:storedPath];
    }
    else{
        [self openWindow];
    }
}

- (IBAction)saveButton:(id)sender {
    [self openWindow];
   }
- (IBAction)jumpToFolder:(id)sender {
    [[NSWorkspace sharedWorkspace] openFile:storedPath];
}
-(void)openWindow
{
    NSOpenPanel *opanel = [NSOpenPanel openPanel];
    
    [opanel setCanChooseDirectories:YES];
    [opanel setCanChooseFiles:NO];
    [opanel setTitle:@"Choose where to save files"];
    [opanel beginSheetModalForWindow:_window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *pathUrl = [opanel URL];
            NSString *thePath = [pathUrl path];
            [defaults setObject:thePath forKey:@"Path"];
            [_pathLabel setStringValue:thePath];
        }
        else if (result ==NSFileHandlingPanelCancelButton && !([defaults objectForKey:@"Path"]))
        {
            NSString *defaultFolder = [NSHomeDirectory() stringByAppendingString:@"/Desktop/"];
            [defaults setObject:defaultFolder forKey:@"Path"];
            [_pathLabel setStringValue:defaultFolder];
            
        }
        storedPath = [defaults stringForKey:@"Path"];
    }];

}
@end
