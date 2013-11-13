//
//  TableView.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "TableView.h"

#define kRed 19
#define kGreen 19
#define kBlue 19
#define kAlpha 1

@implementation TableView

- (NSColor *)backgroundColor{
    return [NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha];
}
//- (NSColor *)gridColor{
//    return [NSColor colorWithCGColor:CGColorCreateGenericRGB(40/255.0, 40/255.0, 40/255.0, 1.0)];
//}
-(BOOL)acceptsFirstResponder{ //Block key event
    return NO;
}

@end
