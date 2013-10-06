//
//  AppController.m
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AppController.h"
#define kAuthURL @"https://oauth.vk.com/authorize?client_id=3796579&scope=audio,offline&redirect_uri=https://oauth.vk.com/blank.html&display=wap&v=5.2&response_type=token"
#define kMainCell @"MainCell"
#define kSearchCell @"SearchCell"

@implementation AppController{
    
    NSDictionary * _currentTrack;
    NSMutableArray * _viewPlaylist;//Playlist for table
    NSMutableArray * _soundPlaylist;//Playlist for playing
    NSMutableArray * _shufflePlaylist;
    NSString * _currentTableCell;//For table whitch one cell is shown
    
    BOOL _isSearchShown;
    BOOL _isInitialLoadingFinish;
}
- (id)init
{
    self = [super init];
    if (self) {
        _S=[[Settings alloc] init];
        _helper=[[Helper alloc] init];
        _PC=[[PlayerController alloc] init];
        [_PC setDelegate:self];
        _currentTableCell=kMainCell;
    }
    return self;
}
-(void)windowDidBecomeMain:(NSNotification *)notification{ NSLog(@"DidBecomeMain");
 
    if (!_isInitialLoadingFinish) {
        NSLog(@"%@",self.S);
        if (!self.S.settings.token) {
            [self activateSeet:YES clearCookiers:NO withURLstring:nil];
        }
    
        _viewPlaylist=[[NSMutableArray alloc] initWithArray:[[[self.helper requestAPI:@"audio.get" parametesForMethod:@"&v=5.2&" token:self.S.settings.token] objectForKey:@"response"] objectForKey:@"items"]];
        _soundPlaylist=[_viewPlaylist mutableCopy];
    
        [self.tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
        [_Controls0 setDelegate:self];//Set delegation method
        [self addSubviewHelper:self.Controls0 slerve:self.Controls1];//Add view to superview (Controls1)
        [self addSubviewHelper:self.BottomControls0 slerve:self.BottomControls1];//Add view to superview (Bottom)
        [[[self.Controls3 viewWithTag:2] cell] setFocusRingType:NSFocusRingTypeNone];//Hide focus ring for Search
    
        [[self.Controls2 viewWithTag:9] setProgress:self.S.settings.volume];//Set volume on view
    
        if (self.S.settings.alwaysOnTop) { //Set Always on top
            [[[NSApp delegate] window] setLevel:1000];
            [[self.windowMenu itemWithTag:4] setState:1];
            [[[NSApp delegate] window] setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
        }
    
        if (self.S.settings.shuffle) {
            _shufflePlaylist=[self.PC generateShufflePlaylist:_soundPlaylist];
            [[self.Controls2 viewWithTag:8] setFlag:self.S.settings.shuffle];//Set shuffle on view
            [[self.controlsMenu itemWithTag:5] setState:self.S.settings.shuffle];//Set shuffle on top in menu
        }
        
        [[self.controlsMenu itemWithTag:6] setState:self.S.settings.repeat];//Set repeat on top in menu
        [[self.Controls2 viewWithTag:7] setFlag:self.S.settings.repeat];//Set repeat on view
    
        
        
        
        for (NSMenuItem * item in  [self.controlsMenu itemArray]) {
            [item setEnabled:YES];
        }
        
        for (NSMenuItem * item in  [self.viewMenu itemArray]) {
            [item setEnabled:YES];
        }
        
        for (NSMenuItem * item in [self.editMenu itemArray]) {
            [item setEnabled:YES];
        }
        
        //Monitor hotkeys
//        [NSEvent addLocalMonitorForEventsMatchingMask: NSKeyDownMask
//                                              handler:^(NSEvent *event) { return [self monitorKeydownEvents:event];}];
        
        _isInitialLoadingFinish=YES;
    }
}
/*
 *                                  ControlsView Methods
 *
 *****************************************************************************************/
-(void)isHovered:(BOOL)flag{
    if (![self.Controls3 superview]) {
        [self removeSubviews];
        if (flag) {
            [self addSubviewHelper:self.Controls0 slerve:self.Controls2];
        }else{
            [self addSubviewHelper:self.Controls0 slerve:self.Controls1];
        }
    }
}
/*
 *                                  TEMP Methods
 *
 *****************************************************************************************/

-(NSEvent*) monitorKeydownEvents:(NSEvent*)event{
    
    NSLog(@"%hu",event.keyCode);
    
    
    NSUInteger flags = [event modifierFlags]& NSCommandKeyMask;
    
    
    NSResponder *firstResponder = [[NSApp keyWindow] firstResponder];
    
    NSLog(@"firstresponfer %@",[firstResponder class] );
    
    
    
    if ([firstResponder isKindOfClass:[NSTextView class]]){
        
        return event;
    }
    
    NSLog( @"Monitor events %i" ,event.keyCode);
    switch (event.keyCode) {
        case 01:
            
            break;
        default:
            if (!flags) [_tableview keyDown:event];
            break;
    }
    return event;
}

-(void) removeSubviews{
    [self.Controls1 removeFromSuperview];
    [self.Controls2 removeFromSuperview];
    [self.Controls3 removeFromSuperview];
}

-(void) addSubviewHelper:(NSView*)master slerve:(NSView*)slerve{
    [master addSubview:slerve];
    [slerve setFrame:[master bounds]];
    [slerve setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
}

/*
 *                                  Player Methods
 *
 *****************************************************************************************/

-(float) getVolume{
    return self.S.settings.volume;
}
-(BOOL) getRuntime{
    return self.S.settings.runTime;
}
-(BOOL) getRepeat{
    return self.S.settings.repeat;
}

-(void)nextTrack{
    [self next:self];
}
-(void) isPlayerPlaying:(BOOL)flag{
    [[self.Controls2 viewWithTag:3] setPauseState:flag];
    NSInteger row=(int)[_viewPlaylist indexOfObject:_currentTrack];
    NSLog(@" isPlayPlaying %li",row);
    [[[_tableview viewAtColumn:0 row:row makeIfNecessary:NO] viewWithTag:1] setPauseState:flag];
}

-(void) durationTrack:(double)duration{
    [[self.Controls1 viewWithTag:1] setStringValue:[_currentTrack objectForKey:@"title"]];//Set title for player
    [[self.Controls1 viewWithTag:2] setStringValue:[_currentTrack objectForKey:@"artist"]];//Set artist for player
    [[self.BottomControls1 viewWithTag:2] setMaxValue:duration];//Set duration for slider
}
-(void) bufferingTrack:(double)seconds{
//    NSLog(@"BUffering %f",seconds);
    [[self.BottomControls1 viewWithTag:2] setBuffering:seconds];
}
-(void) runtimeTrack:(double)seconds secondsString:(NSString *)str{
    [[self.BottomControls1 viewWithTag:2] setProgress:seconds];
    [[self.BottomControls1 viewWithTag:1] setTitle:str];
}

/*
 *                                  Auth Methods
 *
 *****************************************************************************************/

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
 *                                  TableView Methodds
 *
 *****************************************************************************************/

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [_viewPlaylist count];
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView * cellview=[tableView makeViewWithIdentifier:_currentTableCell owner:self];
    id obj=[_viewPlaylist objectAtIndex:row];
    [[cellview viewWithTag:2] setStringValue:[obj objectForKey:@"title"]];
    [[cellview viewWithTag:3] setStringValue:[obj objectForKey:@"artist"]];
    [[cellview viewWithTag:4] setTitle:[self.PC convertTime:[[obj objectForKey:@"duration"] doubleValue]]];
    [[cellview viewWithTag:1] setPauseState:([obj isEqualTo:_currentTrack])? YES : NO];
    return cellview;
}
- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    return [tableView makeViewWithIdentifier:@"MainRow" owner:self];
}
/*
 *                                      IBActions
 *
 *****************************************************************************************/
-(IBAction)play:(id)sender{ NSLog(@"Play");
    NSInteger num=(int)[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist indexOfObject:_currentTrack];
    if (num>-1) [[[_tableview viewAtColumn:0 row:num makeIfNecessary:NO] viewWithTag:1] setPauseState:NO];
    
    if ([sender isKindOfClass:[PlayButtonCell class]]) {
        NSInteger row=[_tableview rowForView:sender];
        
        if (![_soundPlaylist isEqualTo:_viewPlaylist]) _soundPlaylist=[_viewPlaylist mutableCopy]; //Chech to play new playlist
        
        id obj=[_soundPlaylist objectAtIndex:row];
        
        if ([obj isEqualTo:_currentTrack]) {
            if(self.PC.player.rate==1.0) [self.PC.player pause];
            else [self.PC.player play];
        }else{
            _currentTrack=[[NSDictionary alloc] initWithDictionary:obj];
            [self.PC play:[_currentTrack objectForKey:@"url"]];
        }
    }else{
        if (_currentTrack==nil) {
            _currentTrack=[[NSDictionary alloc] initWithDictionary:[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist objectAtIndex:0]];
            [self.PC play:[_currentTrack objectForKey:@"url"]];
        }else{
            if(self.PC.player.rate==1.0) [self.PC.player pause];
            else [self.PC.player play];
        }
    }
}
-(IBAction)next:(id)sender{ NSLog(@"Next");
    NSInteger num=(int)[_soundPlaylist indexOfObject:_currentTrack]+1;
    
    if (num>0) [[[_tableview viewAtColumn:0 row:num-1 makeIfNecessary:NO] viewWithTag:1] setPauseState:NO];
    
    if ([_soundPlaylist count]-num < 1){
        num=0;
        if(self.S.settings.shuffle){
            _shufflePlaylist=[self.PC generateShufflePlaylist:_soundPlaylist];
        }
    }
    
    _currentTrack=[[NSDictionary alloc] initWithDictionary:[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist objectAtIndex:num]];
    [self.PC play:[_currentTrack objectForKey:@"url"]];
}
-(IBAction)previous:(id)sender{ NSLog(@"Previous");
    NSInteger num=(int)[_soundPlaylist indexOfObject:_currentTrack];
    if (num>-1) [[[_tableview viewAtColumn:0 row:num makeIfNecessary:NO] viewWithTag:1] setPauseState:NO];
    if (num-1<0) num=0; else num-=1;
    _currentTrack=[[NSDictionary alloc] initWithDictionary:[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist objectAtIndex:num]];
    [self.PC play:[_currentTrack objectForKey:@"url"]];
}
-(IBAction)decreaseVolume:(id)sender{ NSLog(@"Decrease volume");
    self.S.settings.volume-=0.1;
    if (self.S.settings.volume<0){ self.S.settings.volume=0;}else if (self.S.settings.volume==0){return;}
    [[self.Controls2 viewWithTag:9] setProgress:self.S.settings.volume];
    [self.PC.player setVolume:self.S.settings.volume];
    [self.S saveSettings];
}
-(IBAction)increaseVolume:(id)sender{ NSLog(@"IncreaseVolume");
    self.S.settings.volume+=0.1;
    if (self.S.settings.volume>2){ self.S.settings.volume=2;}else if (self.S.settings.volume==2){return;}
    [[self.Controls2 viewWithTag:9] setProgress:self.S.settings.volume];
    [self.PC.player setVolume:self.S.settings.volume];
    [self.S saveSettings];
}
-(IBAction)mute:(id)sender{NSLog(@"Mute");
    self.S.settings.volume=0;
    [[self.Controls2 viewWithTag:9] setProgress:self.S.settings.volume];
    [self.PC.player setVolume:self.S.settings.volume];
    [self.S saveSettings];
}
-(IBAction)shuffle:(id)sender{NSLog(@"Shuffle");
    if (self.S.settings.shuffle) {
        [sender setFlag:NO];
        [[self.controlsMenu itemWithTag:5] setState:0];
    }else{
        _shufflePlaylist=[self.PC generateShufflePlaylist:_soundPlaylist];//Set Shuffle Playlist
        [sender setFlag:YES];
        [[self.controlsMenu itemWithTag:5] setState:1];
    }
    self.S.settings.shuffle=!self.S.settings.shuffle;
    [self.S saveSettings];
}
-(IBAction)repeat:(id)sender{NSLog(@"Repeat");
    if (self.S.settings.repeat) {
        [sender setFlag:NO];
        [[self.controlsMenu itemWithTag:6] setState:0];
    }else{
        [sender setFlag:YES];
        [[self.controlsMenu itemWithTag:6] setState:1];
    }
    self.S.settings.repeat=!self.S.settings.repeat;
    [self.S saveSettings];
}
-(IBAction)alwaysOnTop:(id)sender{NSLog(@"Always On top");
    if (!self.S.settings.alwaysOnTop) {
        [[[NSApp delegate] window] setLevel:1000];
        [[self.windowMenu itemWithTag:4] setState:1];
        [[[NSApp delegate] window] setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
    }else{
        [[[NSApp delegate] window] setLevel:0];
        [[self.windowMenu itemWithTag:4] setState:0];
        [[[NSApp delegate] window] setCollectionBehavior: NSWindowCollectionBehaviorDefault];
    }
    self.S.settings.alwaysOnTop=!self.S.settings.alwaysOnTop;
    [self.S saveSettings];
}
-(IBAction)visitWebsite:(id)sender{ NSLog(@"visitwebsite");
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://ttitt.ru/"]];
}
-(IBAction)addTrack:(id)sender{NSLog(@"AddtTrack");
    
    NSInteger row=([sender isKindOfClass:[NSMenuItem class]])?[_tableview selectedRow]:[_tableview rowForView:sender];
//    id obj=[_viewPlaylist objectAtIndex:row];
//    NSString * q = [NSString stringWithFormat:@"&owner_id=%@&audio_id=%@&v=5.0&",[obj objectForKey:@"owner_id"],[obj objectForKey:@"id"]];
//    [self.helper requestAPI:@"audio.add" parametesForMethod:q token:self.S.settings.token];

    if ([sender isKindOfClass:[AddButtonCell class]]) {
        [sender setComplete];
    }
}
-(IBAction)removeTrack:(id)sender{NSLog(@"RemoveTrack");
    NSInteger row=([sender isKindOfClass:[NSMenuItem class]])?[_tableview selectedRow]:[_tableview rowForView:sender];
//    id obj=[_viewPlaylist objectAtIndex:row];
//    NSString * q = [NSString stringWithFormat:@"&owner_id=%@&album_id=%@&v=5.0&",[obj objectForKey:@"owner_id"],[obj objectForKey:@"id"]];
//    [self.helper requestAPI:@"audio.delete" parametesForMethod:q token:self.S.settings.token];
    
    if ([_soundPlaylist isEqualTo:_viewPlaylist]){ //Chech to play new playlist
        [_soundPlaylist removeObjectAtIndex:row];
    }

    [_viewPlaylist removeObjectAtIndex:row];
    [_tableview removeRowsAtIndexes:[[NSIndexSet alloc] initWithIndex:row] withAnimation:NSTableViewAnimationSlideUp];
}
-(IBAction)volume:(id)sender{NSLog(@"Volume");
    NSEvent *event = [[NSApplication sharedApplication] currentEvent];
    BOOL endingDrag = event.type == NSLeftMouseUp;
    [sender setProgress:[sender floatValue]];
    self.S.settings.volume=[sender floatValue];
    [self.PC.player setVolume:[sender floatValue]];
    if(endingDrag) [self.S saveSettings];
}
-(IBAction)runtime:(id)sender{NSLog(@"Runtime");
    NSEvent *event = [[NSApplication sharedApplication] currentEvent];
    BOOL endingDrag = event.type == NSLeftMouseUp;
    [sender setProgress:[sender doubleValue]];
    if(endingDrag) [self.PC setRuntime:[sender doubleValue]];
}
-(IBAction)switchRuntime:(id)sender{ NSLog(@"Switch Runtime");
    self.S.settings.runTime=!self.S.settings.runTime;
    [self.S saveSettings];
}
-(IBAction)showSearch:(id)sender{NSLog(@"ShowSearch");
    [self removeSubviews];
    [self addSubviewHelper:self.Controls0 slerve:self.Controls3];
    [[self.Controls3 viewWithTag:2] selectText:nil];//Set cursor and select text in search field
}
-(IBAction)hideSearch:(id)sender{NSLog(@"HideSearch");
    [self removeSubviews];
    [self addSubviewHelper:self.Controls0 slerve:self.Controls2];
}
-(IBAction)search:(id)sender{NSLog(@"Search");
    if ([sender stringValue].length!=0) {
        NSString * q = [NSString stringWithFormat:@"&q=%@&auto_complete=1&sort=2&count=50&v=5.2&",[sender stringValue]];
        _viewPlaylist=[[NSMutableArray alloc] initWithArray:[[[self.helper requestAPI:@"audio.search" parametesForMethod:q token:self.S.settings.token] objectForKey:@"response"] objectForKey:@"items"]];
        _currentTableCell=kSearchCell;
        
        if([[sender stringValue] isEqual:@"Sergei Popov"]){[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://vk.com/serji"]];}
    }else{
        
        if (![_soundPlaylist isEqualTo:_viewPlaylist]){ //Chech to play new playlist
            _viewPlaylist=[_soundPlaylist mutableCopy];
        }else{
            _viewPlaylist=[[NSMutableArray alloc] initWithArray:[[[self.helper requestAPI:@"audio.get" parametesForMethod:@"&v=5.2&" token:self.S.settings.token] objectForKey:@"response"] objectForKey:@"items"]];
        }
        _currentTableCell=kMainCell;
    }
    [self.tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}
-(IBAction)showPlaylist:(id)sender{ NSLog(@"ShowPlaylist");
    id window=[[NSApp delegate] window];
    [window setFrame:NSMakeRect([window frame].origin.x, [window frame].origin.y, 313, 80) display:YES animate:YES];
}
-(IBAction)gotoCurrentTrack:(id)sender{ NSLog(@"Go to Current Track");
    int selectTrack=(int)[_viewPlaylist indexOfObject:_currentTrack];
    [_tableview scrollRowToVisible:selectTrack];
    [_tableview selectRowIndexes:[NSIndexSet indexSetWithIndex:selectTrack] byExtendingSelection:NO];
}
-(IBAction)close:(id)sender{ NSLog(@"Close");
    [[[NSApp delegate] window] close];
}
-(IBAction)logout:(id)sender{ NSLog(@"Logout");
    [self activateSeet:YES clearCookiers:YES withURLstring:nil];
}
@end
