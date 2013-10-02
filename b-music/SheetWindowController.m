//
//  SheetWindowController.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "SheetWindowController.h"

@interface SheetWindowController ()

@end

@implementation SheetWindowController

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
    [self loadURL:@"http://google.com/"];
}
-(void) loadURL:(NSString *) URLsring{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLsring]];
    [self.webview.mainFrame loadRequest:request];
}
-(IBAction)cancel:(id)sender{NSLog(@"CancelSheet");
    [_delegate cancelSheet];
}
@end
