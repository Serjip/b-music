//
//  AppController.m
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AppController.h"
#define kAuthURL @"https://oauth.vk.com/authorize?client_id=3796579&scope=audio,offline&redirect_uri=https://oauth.vk.com/blank.html&display=wap&v=5.2&response_type=token"

@implementation AppController{
    NSMutableArray * _mainPlaylist;
    NSMutableArray * _supportPlaylist;
}

-(void)awakeFromNib{
    
    self.S=[[Settings alloc] init];
    NSLog(@"%@",self.S);
    if (!self.S.settings.token) {
        [self activateSeet:YES clearCookiers:NO withURLstring:nil];
    }
    
    self.helper=[[Helper alloc] init];
    
    _mainPlaylist=[[NSMutableArray alloc] initWithArray:[[[self.helper requestAPI:@"audio.get" parametesForMethod:@"&v=5.2&" token:self.S.settings.token] objectForKey:@"response"] objectForKey:@"items"]];
    NSLog(@"%@",_mainPlaylist);
    
    [self.Controls0 addSubview:self.Controls2];
    [self.BottomControls0 addSubview:self.BottomControls1];
}

-(void)activateSeet:(BOOL)auth clearCookiers:(BOOL)cookies withURLstring:(NSString*)URLstring{
    
    if (!self.sheet) {
        self.sheet=[[SheetWindowController alloc] initWithWindowNibName:@"SheetWindowController"];
        [self.sheet setDelegate:self];
    }
    
    [NSApp beginSheet:self.sheet.window
       modalForWindow:[[NSApp delegate]window]
        modalDelegate:self
       didEndSelector:nil
          contextInfo:nil];
    
    if (cookies) [self.sheet clearCookie];
    if (auth) {
        [self.sheet loadURL:kAuthURL];
    }else{
        [self.sheet loadURL:URLstring];
    }
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
    
    if (!self.helper) {
        self.helper=[[Helper alloc] init];
    }
    NSLog(@"%@",[self.helper requestAPI:@"audio.get" parametesForMethod:@"&v=5.2&" token:self.S.settings.token]);
}
/*
 * TableView Methodds
 *****************************************************************************************/
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [_mainPlaylist count];
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView * cellview=[tableView makeViewWithIdentifier:@"MainCell" owner:self];
    id obj=[_mainPlaylist objectAtIndex:row];
    [[cellview viewWithTag:1] setStringValue:[obj objectForKey:@"title"]];
    [[cellview viewWithTag:2] setStringValue:[obj objectForKey:@"artist"]];
    return cellview;
}
/*
 * IBActions
 *****************************************************************************************/
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
-(IBAction)close:(id)sender{ NSLog(@"Close");
    [[[NSApp delegate] window] close];
}
-(IBAction)logout:(id)sender{ NSLog(@"Logout");
    [self activateSeet:YES clearCookiers:YES withURLstring:nil];
}
@end
