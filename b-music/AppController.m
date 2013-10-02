//
//  AppController.m
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AppController.h"

@implementation AppController
-(void)awakeFromNib{
    [self activateSeet];
}

-(void)activateSeet{
    self.sheet=[[SheetWindowController alloc] initWithWindowNibName:@"SheetWindowController"];
    [self.sheet setDelegate:self];
    [NSApp beginSheet:self.sheet.window
       modalForWindow:[[NSApp delegate]window]
        modalDelegate:self
       didEndSelector:nil
          contextInfo:nil];
}
-(void)cancelSheet{
    
}
@end
