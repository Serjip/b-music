//
//  TableCellView.m
//  b-music
//
//  Created by Sergey P on 26.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the
//     purpose of any concept relating to diary/journal keeping.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "TableCellView.h"

#define kRed 45
#define kGreen 45
#define kBlue 45
#define kAlpha 1.0

@implementation TableCellView{
    NSRect _startFrame;
    NSRect _endFrame;
    BOOL _isEnd;
    BOOL _start;
    
    double _slideValue;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
    
    if ([self inLiveResize]) {
        CGFloat width=NSWidth(self.frame);
        CGFloat height=NSHeight(self.frame);
        _startFrame = NSMakeRect(0.0, 0.0, width, height);
        _endFrame= NSMakeRect(-_slideValue, 0, width, height);
        _isEnd=NO;
    }
    
    [[NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];
    NSRectFill(self.bounds);
    
    if (self.select) {
        [[NSColor colorWithSRGBRed:48/255.0 green:98/255.0 blue:144/255.0 alpha:1] setFill];
        NSRectFill(NSMakeRect(0, 0, 53, 50));
        self.select=NO;
    }
}

-(void) slideCell:(double)slideValue{
    
    _slideValue=slideValue;
    
    if (!_start) {
        CGFloat width=NSWidth(self.frame);
        CGFloat height=NSHeight(self.frame);
        
        _startFrame = NSMakeRect(0.0, 0.0, width, height);
        _endFrame= NSMakeRect(-_slideValue, 0, width, height);
        
        NSLog(@"widht %f height %f",width , height);
        _start=YES;
        _isEnd=NO;
    }
    
    if (_isEnd) {
        [[self animator] setFrame:_startFrame];
    }else{
        [[self animator] setFrame:_endFrame];
    }
    _isEnd=!_isEnd;
}

@end
