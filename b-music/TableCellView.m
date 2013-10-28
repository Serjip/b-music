//
//  TableCellView.m
//  b-music
//
//  Created by Sergey P on 26.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
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
    
    if (self.select) {
        [[NSColor brownColor]set];
        self.select=NO;
    }else{
        [[NSColor colorWithRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];
    }
    
    
    NSRectFill(self.bounds);
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
