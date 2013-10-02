//
//  VolumeCell.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VolumeCell : NSSliderCell{
    double _progress;
    BOOL _isShowKnob;
}
-(void)setProgress:(double)progress;
-(void)setShowKnob:(BOOL)isShowKnob;

@end
