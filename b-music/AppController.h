//
//  AppController.h
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SheetWindowController.h"
@interface AppController : NSObject<SheetDelegate>
@property SheetWindowController * sheet;

@property (weak) IBOutlet NSView *Controls0;
@property (weak) IBOutlet NSView *Controls1;

-(IBAction)logout:(id)sender;

@end
