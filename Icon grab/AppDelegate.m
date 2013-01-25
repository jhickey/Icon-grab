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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *storedPath = [defaults stringForKey:@"Path"];
    [_pathLabel setStringValue:storedPath];
}

- (IBAction)saveButton:(id)sender {
    NSOpenPanel *opanel = [NSOpenPanel openPanel];

    [opanel setCanChooseDirectories:YES];
    [opanel setCanChooseFiles:NO];
    [opanel beginSheetModalForWindow:_window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *pathUrl = [opanel URL];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *thePath = [pathUrl path];
            [defaults setObject:thePath forKey:@"Path"];
            [_pathLabel setStringValue:thePath];
        }
    }];
}
- (IBAction)jumpToFolder:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *storedPath = [defaults stringForKey:@"Path"];
    [[NSWorkspace sharedWorkspace] openFile:storedPath];
}
@end
