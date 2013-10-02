//
//  Volume.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VolumeCell.h"
@interface Volume : NSSlider{
    double _progress;
}
-(void)setProgress:(double)progress;

@end