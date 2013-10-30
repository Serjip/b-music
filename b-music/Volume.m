//
//  Volume.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Volume.h"

@implementation Volume{
    double _progress;
}

-(void)setProgress:(double)progress{
    [self setDoubleValue:progress];
    [self.selectedCell setProgress:progress/2];
    [self setNeedsDisplay:YES];
}
@end
