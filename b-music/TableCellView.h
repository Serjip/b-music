//
//  TableCellView.h
//  b-music
//
//  Created by Sergey P on 26.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TableCellView : NSTableCellView

@property BOOL select;
-(void) slideCell:(double)slideValue;

@end
