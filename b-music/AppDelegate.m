//
//  AppDelegate.m
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
//    NSUbiquitousKeyValueStore *storage = [NSUbiquitousKeyValueStore defaultStore];
    
//    [storage setString:@"HELLO" forKey:@"test"];
//    NSLog(@"iclod %@",[storage objectForKey:@"test"]);
    
}
- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag{
    [self.window orderFront:nil];
    [self.window makeMainWindow];
    return NO;
}

@end
