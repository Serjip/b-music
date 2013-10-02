//
//  RuntimeSliderCell.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RuntimeSliderCell : NSSliderCell{
    double _buffering;
    double _progress;
    BOOL _isShowKnob;
}
-(void)setBuffering:(double)buffering;
-(void)setProgress:(double)progress;
-(void)setShowKnob:(BOOL)isShowKnob;

@end
