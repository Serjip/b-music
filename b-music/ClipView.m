//
//  ClipView.m
//  b-music
//
//  Created by Sergey P on 27.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "ClipView.h"

@implementation ClipView

//- (id)initWithFrame:(NSRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code here.
//        
//    }
//    return self;
//}
//
//- (void)drawRect:(NSRect)dirtyRect
//{
//	[super drawRect:dirtyRect];
//	// Drawing code here.
//    
//    
//}
-(BOOL)wantsLayer{
    return YES;
}
-(BOOL)wantsUpdateLayer{
    return YES;
}
-(void)updateLayer{
    [self.layer setCornerRadius:10.f];
}

@end
