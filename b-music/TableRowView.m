//
//  TableRowView.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "TableRowView.h"

@implementation TableRowView

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        [[NSColor colorWithSRGBRed:48/255.0 green:98/255.0 blue:144/255.0 alpha:1] setFill];
        NSRectFill(dirtyRect);
    }
}
@end
