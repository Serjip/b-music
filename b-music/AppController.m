//
//  AppController.m
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AppController.h"

@implementation AppController
-(void)awakeFromNib{
    
    self.S=[[Settings alloc] init];
    NSLog(@"%@",self.S);
    if (!self.S.settings.token) {
        [self activateSeet];
    }
    
    [self.Controls0 addSubview:self.Controls2];
    [self.BottomControls0 addSubview:self.BottomControls1];
}
-(void)windowDidBecomeMain:(NSNotification *)notification
{NSLog(@"DidBecomeMain");
    
}

-(void)activateSeet{
    if (!self.sheet) {
        self.sheet=[[SheetWindowController alloc] initWithWindowNibName:@"SheetWindowController"];
        [self.sheet setDelegate:self];
    }
    [NSApp beginSheet:self.sheet.window
       modalForWindow:[[NSApp delegate]window]
        modalDelegate:self
       didEndSelector:nil
          contextInfo:nil];
}
-(void) cancelSheet:(NSString*)token user_id:(NSInteger)user_id{
    NSLog(@"DELEGATION METHOD token %@ user_id %li",token,user_id);
    
    if(token && user_id){
        self.S.settings.token=token;
        self.S.settings.user_id=user_id;
        [self.S saveSettings];
    }
    
    [NSApp endSheet:self.sheet.window];
    [self.sheet.window close];
    //self.sheet.window = nil;
}

-(IBAction)play:(id)sender{ NSLog(@"Play");

}
-(IBAction)next:(id)sender{ NSLog(@"Next");
    
}
-(IBAction)previous:(id)sender{ NSLog(@"Previous");
    
}
-(IBAction)decreaseVolume:(id)sender{ NSLog(@"Decrease volume");
    
}
-(IBAction)increaseVolume:(id)sender{ NSLog(@"IncreaseVolume");
    
}
-(IBAction)mute:(id)sender{NSLog(@"Mute");
    
}
-(IBAction)shuffle:(id)sender{NSLog(@"Shuffle");
    
}
-(IBAction)repeat:(id)sender{NSLog(@"Repeat");
    
}
-(IBAction)alwaysOnTop:(id)sender{NSLog(@"Always On top");
    
}
-(IBAction)visitWebsite:(id)sender{ NSLog(@"visitwebsite");
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://ttitt.ru/"]];
}
-(IBAction)addTrack:(id)sender{NSLog(@"AddtTrack");

}
-(IBAction)removeTrack:(id)sender{NSLog(@"RemoveTrack");
    
}
-(IBAction)volume:(id)sender{NSLog(@"Volume");
    
}
-(IBAction)runtime:(id)sender{NSLog(@"Runtime");
    
}
-(IBAction)switchRuntime:(id)sender{ NSLog(@"Switch Runtime");
    
}
-(IBAction)showSearch:(id)sender{NSLog(@"ShowSearch");
    [self.Controls2 removeFromSuperview];
    [self.Controls0 addSubview:self.Controls3];
}
-(IBAction)hideSearch:(id)sender{NSLog(@"HideSearch");
    [self.Controls3 removeFromSuperview];
    [self.Controls0 addSubview:self.Controls2];
}
-(IBAction)search:(id)sender{NSLog(@"Search");
    
}
-(IBAction)showPlaylist:(id)sender{ NSLog(@"ShowPlaylist");
    
}
-(IBAction)logout:(id)sender{ NSLog(@"Logout");
    [self activateSeet];
}
@end
