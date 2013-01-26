//
//  AppDelegate.h
//  Icon grab
//
//  Created by Hickey, Jimmy on 1/25/13.
//  Copyright (c) 2013 Hickey, Jimmy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSString *storedPath;
    NSUserDefaults *defaults;
}

@property (assign) IBOutlet NSWindow *window;
- (IBAction)saveButton:(id)sender;
@property (weak) IBOutlet NSTextField *pathLabel;
- (IBAction)jumpToFolder:(id)sender;
-(void)openWindow;

@end
