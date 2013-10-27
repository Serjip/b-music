//
//  TableView.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "TableView.h"

@implementation TableView

- (NSColor *)backgroundColor{
    return [NSColor colorWithCGColor:CGColorCreateGenericRGB(19/255.0, 19/255.0, 19/255.0, 1.0)];
}
//- (NSColor *)gridColor{
//    return [NSColor colorWithCGColor:CGColorCreateGenericRGB(40/255.0, 40/255.0, 40/255.0, 1.0)];
//}
-(BOOL)acceptsFirstResponder{ //Block key event
    return NO;
}

@end
