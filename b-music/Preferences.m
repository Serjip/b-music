//
//  Preferences.m
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Preferences.h"

@interface Preferences ()

@end

@implementation Preferences

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    [self.toolbar setSelectedItemIdentifier:@"GeneralPreferences"];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar{
    NSLog(@"HELLO toolbar");
    
    return [NSArray arrayWithObjects:@"GeneralPreferences",
//            AccountPreferences,
//            AppearancePreferences,
//            FontsAndColorsPreferences,
//            AdvancedPreferences,
            nil];
}


@end
