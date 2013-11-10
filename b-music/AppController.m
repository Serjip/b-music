//
//  AppController.m
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AppController.h"

@implementation AppController{
    
    NSDictionary * _currentTrack;
    
    NSMutableArray * _viewPlaylist;//Playlist for table
    NSMutableArray * _soundPlaylist;//Playlist for playing
    NSMutableArray * _shufflePlaylist;
    NSMutableDictionary * _imageList;
    
    NSString * _currentTableRow;//For table whitch one cell is shown
    BOOL _isInitialLoadingFinish;//Indicator starting app
    BOOL _userHoldKey;//global key event holding indicator
    
    CGSize _windowSize;//size player
    BOOL _scrobbleIndicator;//Shows send track has been sent or not
}
- (id)init
{
    self = [super init];
    if (self) {
        _S=[[Settings alloc] init];
        _api=[[Api alloc] init];
        [_api setDelegate:self];
        
        _lastfmAPI=[[LastfmAPI alloc] init];
        [_lastfmAPI setDelegate:self];
        
        _PC=[[PlayerController alloc] init];
        [_PC setDelegate:self];
        _currentTableRow=@"MainRow";
    }
    return self;
}

/*
 *  Api VK Delegate
 *****************************/
#pragma mark APIvk
-(void) finishAuth:(NSString*)token
           user_id:(NSInteger)user_id{
    
    NSLog(@"TOKEN vk");
    self.S.settings.token=token;
    self.S.settings.user_id=user_id;
    [self.S saveSettings];
    
    [self loadMainPlaylist];
}

/*
 *  LastfmApi VK Delegate
 *****************************/
#pragma mark Lastfm Delegate
-(void) finishAuthorizeWithSession:(NSString *)session
                          username:(NSString*)username{
    NSLog(@"TOKEN Lastfm");
    self.S.settings.sessionLastfm=session;
    self.S.settings.nameLastfm=username;
    [self.S saveSettings];
}
/*
 *                                  Window Methods
 *
 *****************************************************************************************/
#pragma mark Window
-(void)windowDidResize:(NSNotification *)notification{
    
    NSEvent *event = [[NSApplication sharedApplication] currentEvent];
    if ([event type]==6) {
         id window=[[NSApp delegate] window];
        _windowSize=[window frame].size;
    }
}


-(void)windowDidBecomeMain:(NSNotification *)notification{ NSLog(@"DidBecomeMain");
    if (!self.S.settings.token){
        [self.api auth];
    }
    
    if (!_isInitialLoadingFinish) {
        
        [self registerHandlerLinks];//Handler tokens /lastfm/vk
        
        statusItem=[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [statusItem setMenu:self.statusMenu];
        [statusItem setHighlightMode:YES];
        [statusItem setImage:[NSImage imageNamed:@"NSGoRightTemplate"]];
        
        NSLog(@"%@",self.S);
        
        [_Controls0 setDelegate:self];//Set delegation method
        [self addSubviewHelper:self.Controls0 slerve:self.Controls1];//Add view to superview (Controls1)
        [self addSubviewHelper:self.BottomControls0 slerve:self.BottomControls1];//Add view to superview (Bottom)
        
        [self.volume setProgress:self.S.settings.volume];//Set volume on view
        
        if (self.S.settings.alwaysOnTop) { //Set Always on top
            [[[NSApp delegate] window] setLevel:1000];
            [[self.windowMenu itemWithTag:4] setState:1];
            [[[NSApp delegate] window] setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
        }
        
        [[self.Controls2 viewWithTag:8] setFlag:self.S.settings.shuffle];//Set shuffle on view
        [[self.controlsMenu itemWithTag:5] setState:self.S.settings.shuffle];//Set shuffle on top in menu
        
        [[self.Controls2 viewWithTag:7] setFlag:self.S.settings.repeat];//Set repeat on view
        [[self.controlsMenu itemWithTag:6] setState:self.S.settings.repeat];//Set repeat on top in menu
        
        //Set search
        [[self.searchField cell]setFocusRingType:NSFocusRingTypeNone];
        
        //Setting size window
        _windowSize=[[NSApp delegate] window].frame.size;
        
        
        for (NSMenuItem * item in  [self.controlsMenu itemArray]) {
            [item setEnabled:YES];
        }
        
        for (NSMenuItem * item in  [self.viewMenu itemArray]) {
            [item setEnabled:YES];
        }
        
        for (NSMenuItem * item in [self.editMenu itemArray]) {
            [item setEnabled:YES];
        }
        
        for (NSMenuItem * item in [self.dockMenu itemArray]) {
            [item setEnabled:YES];
        }
        
        
        //Local Monitor hotkeys
        [NSEvent addLocalMonitorForEventsMatchingMask: NSKeyDownMask
                                              handler:^(NSEvent *event) { return [self localMonitorKeydownEvents:event];}];
        //GLobal Monitor hotkeys
        [NSEvent addGlobalMonitorForEventsMatchingMask: (NSKeyDownMask | NSSystemDefinedMask)
                                               handler: ^(NSEvent *event) {[self globalMonitorKeydownEvents:event];}];
        
        _isInitialLoadingFinish=YES;
        
        [self loadMainPlaylist];
    }
}
/*
 *                                  ControlsView Methods Delegate
 *****************************************************************************************/
-(void)isHovered:(BOOL)flag{
    if (![_popoverVolume isShown]) {
        [self removeSubviews];
        if (flag) {
            [self addSubviewHelper:self.Controls0 slerve:self.Controls2];
        }else{
            [self addSubviewHelper:self.Controls0 slerve:self.Controls1];
        }
    }
}

/*
 * TEMP Methods
 ****************************************/
#pragma mark Temp

- (void)registerHandlerLinks{
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                       andSelector:@selector(getUrl:withReplyEvent:)
                                                     forEventClass:kInternetEventClass
                                                        andEventID:kAEGetURL];
}

- (void)getUrl:( NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    NSString * str=[[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSString * prefix=@"com.ttitt.b-music://";
    if (![str hasPrefix:prefix]) return;
    
    NSString * tokenString=[str substringFromIndex:prefix.length];
    
    if ([tokenString characterAtIndex:0]==63) {
        //LASTFM
        [self.lastfmAPI parseTokenUsernameFormString:tokenString];
    }else{
        //VK
        [self.api parseAccessTokenAndUserIdFormString:tokenString];
    }
}

-(NSEvent*) localMonitorKeydownEvents:(NSEvent*)event{
//    NSLog(@"%hu %@",event.keyCode, [[[NSApp keyWindow] firstResponder] className]);
//    return event;
    
    if (event.modifierFlags& NSCommandKeyMask) return event;
    
    if ([[[NSApp keyWindow] firstResponder] isKindOfClass:[NSTextView class]]){
        
        if (event.keyCode==125) {
            [_tableview keyDown:event];
        }else if (event.keyCode==126){
            [_tableview keyDown:event];
        }else if (event.keyCode==36 && _tableview.selectedRow>-1) {
            [[[_tableview viewAtColumn:0 row:_tableview.selectedRow makeIfNecessary:NO] viewWithTag:1] performClick:nil];
            return nil;
        }
        return event;
    }
    
    
    if (event.keyCode==36 && _tableview.selectedRow>-1) {
        [[[_tableview viewAtColumn:0 row:_tableview.selectedRow makeIfNecessary:NO] viewWithTag:1] performClick:nil];
        return nil;
    }
    [_tableview keyDown:event];
    return nil;
}


-(void) globalMonitorKeydownEvents:(NSEvent*)event{
    if (!(event.modifierFlags&NSCommandKeyMask)) return;
//    NSLog(@"%li",event.data1);
    switch (event.data1) {
        case 1051136://Play
            [self play:nil];
            break;
        case 1247745://ffwd
            _userHoldKey=YES;
            double change1=[[self.BottomControls1 viewWithTag:2] doubleValue]+[[self.BottomControls1 viewWithTag:2] maxValue]*2/100;
            if (change1>[[self.BottomControls1 viewWithTag:2] maxValue]){
                [self next:nil];
                [[self.BottomControls1 viewWithTag:2] setProgress:0];
                [self.PC setRuntime:0];
            }else{
                [[self.BottomControls1 viewWithTag:2] setProgress:change1];
                [self.PC setRuntime:change1];
            }
            
            break;
        case 1248000://End ffwd
            if (!_userHoldKey) [self next:nil];
            _userHoldKey=NO;
            break;
        case 1313281://Rewind
            _userHoldKey=YES;
            double change=[[self.BottomControls1 viewWithTag:2] doubleValue]-[[self.BottomControls1 viewWithTag:2] maxValue]*2/100;
            if (change<0){
                [self previous:nil];
                
                [[self.BottomControls1 viewWithTag:2] setProgress:[[self.BottomControls1 viewWithTag:2] maxValue]];
                [self.PC setRuntime:[[self.BottomControls1 viewWithTag:2] maxValue]];
            }else{
                [[self.BottomControls1 viewWithTag:2] setProgress:change];
                [self.PC setRuntime:change];
            }
            break;
        case 1313536://End Rewind
            if (!_userHoldKey) [self previous:nil];
            _userHoldKey=NO;
            break;
    }
}

-(void) removeSubviews{
    [self.Controls1 removeFromSuperview];
    [self.Controls2 removeFromSuperview];
}

-(void) addSubviewHelper:(NSView*)master slerve:(NSView*)slerve{
    [master addSubview:slerve];
    [slerve setFrame:[master bounds]];
    [slerve setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
}

//Switcher to pause state in table view
-(void) setPauseStateForButton:(id)object state:(BOOL)flag{
    NSInteger num=(int)[_viewPlaylist indexOfObject:object];
    if (num>-1) [[[_tableview viewAtColumn:0 row:num makeIfNecessary:NO] viewWithTag:1] setPauseState:flag];
}


-(void) loadMainPlaylist{
    
    id response =[self.api requestAPIVkLoadMainplaylist:self.S.settings.token];
    
    if (![self.api checkForErrorResponse:response]) return;//Some error happend
    
    _viewPlaylist=[[NSMutableArray alloc] initWithArray:[[response objectForKey:@"response"] objectForKey:@"items"]];
    _soundPlaylist=[_viewPlaylist mutableCopy];
    
    if (self.S.settings.shuffle) { _shufflePlaylist=[self.PC generateShufflePlaylist:_soundPlaylist]; }
    
    [self.tableview performSelectorOnMainThread:@selector(reloadData)
                                     withObject:nil
                                  waitUntilDone:NO];
}

/*
 *  Player Methods
 *******************************/
#pragma mark Player
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
    [self setPauseStateForButton:_currentTrack state:flag];
    
    NSString * state;
    if (flag) {
        state=@"Pause";
        [statusItem setImage:[NSImage imageNamed:@"pauseTemplate"]];
    }else{
        state=@"Play";
        [statusItem setImage:[NSImage imageNamed:@"NSGoRightTemplate"]];
    }
    
    [[self.controlsMenu itemWithTag:1] setTitle:state];
    [[self.statusMenu itemWithTag:1] setTitle:state];
    [[self.dockMenu itemWithTag:1] setTitle:state];
    
}

-(void) durationTrack:(double)duration{
    NSString * title=[_currentTrack objectForKey:@"title"];
    NSString * artist=[_currentTrack objectForKey:@"artist"];
    NSString * durationString=[_currentTrack objectForKey:@"duration"];
    
    [[self.Controls1 viewWithTag:1] setStringValue:title];//Set title for player
    [[self.Controls1 viewWithTag:2] setStringValue:artist];//Set artist for player
    [[self.BottomControls1 viewWithTag:2] setMaxValue:duration];//Set duration for slider
    
    NSInteger num=(int)[_viewPlaylist indexOfObject:_currentTrack];
    
    _scrobbleIndicator=NO;//Reset inicator
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.ttitt.b-music.lastfm", NULL);
    dispatch_async(downloadQueue, ^{
        if (num>-1){
            NSButton * btnPlayTableCell=[[_tableview viewAtColumn:0 row:num makeIfNecessary:NO] viewWithTag:1];
            
            NSImage * image =[self.lastfmAPI getImageWithArtist:artist track:title size:3];
            
            //Set updateNowPlayng lastfm
            [self.lastfmAPI track_updateNowPlaying:self.S.settings.sessionLastfm
                                            artist:artist
                                             track:title
                                          duration:durationString];
            
            //set dock icon
            [NSApp setApplicationIconImage: image];
            
            if (!_imageList) {
                _imageList = [[NSMutableDictionary alloc]init];
            }
            if (image) {
                [_imageList setObject:image forKey:_currentTrack];
                [btnPlayTableCell setImage:image];
            }
        }
    });
}


-(void) bufferingTrack:(double)seconds{
//    NSLog(@"BUffering %f",seconds);
    [[self.BottomControls1 viewWithTag:2] setBuffering:seconds];
}
-(void) runtimeTrack:(double)seconds
       secondsString:(NSString *)str
            scrobble:(BOOL)scrobble{
    
    [[self.BottomControls1 viewWithTag:2] setProgress:seconds];
    [[self.BottomControls1 viewWithTag:1] setTitle:str];

    if (!_scrobbleIndicator && scrobble) {
        NSLog(@"SCROBBLE REUQUEST");
        NSString * title=[_currentTrack objectForKey:@"title"];
        NSString * artist=[_currentTrack objectForKey:@"artist"];
        
        //Scrobbing request
        [self.lastfmAPI track_scrobble:self.S.settings.sessionLastfm
                                artist:artist
                                 track:title];
        _scrobbleIndicator=YES;
    }
}

/*
 *                                  TableView Methods
 *
 *****************************************************************************************/
#pragma mark Table

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{ // count of table view items
    return [_viewPlaylist count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    TableCellView * cellview=[tableView makeViewWithIdentifier:@"MainCell" owner:self];
    id obj=[_viewPlaylist objectAtIndex:row];
    [[cellview viewWithTag:2] setStringValue:[obj objectForKey:@"title"]];
    [[cellview viewWithTag:3] setStringValue:[obj objectForKey:@"artist"]];
    [[cellview viewWithTag:4] setTitle:[self.PC convertTime:[[obj objectForKey:@"duration"] doubleValue]]];
    
    [[cellview viewWithTag:1] setPauseState:([obj isEqualTo:_currentTrack])? YES : NO];
    
    
    if (_imageList) {
        
        NSImage * image = [_imageList objectForKey:obj];
        [[cellview viewWithTag:1] setImage:image];
    }
    
    return cellview;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    return [tableView makeViewWithIdentifier:_currentTableRow owner:self];
}

#pragma mark -
#pragma mark IBAcrions
/*
 *@ IBActions
 */

-(IBAction)preferences:(id)sender{ NSLog(@"Preferences");
    if (!preferences) {
        preferences=[[Preferences alloc] initWithWindowNibName:@"Preferences"];
    }
    [preferences showWindow:self];
}

-(IBAction)play:(id)sender{ NSLog(@"Play");
    [self setPauseStateForButton:_currentTrack state:NO];
    
    if ([sender isKindOfClass:[PlayButtonCell class]]) {
        NSInteger row=[_tableview rowForView:sender];
        
        if (![_soundPlaylist isEqualTo:_viewPlaylist]){ //Chech to play new playlist
            _soundPlaylist=[_viewPlaylist mutableCopy];
            _shufflePlaylist=[self.PC generateShufflePlaylist:_soundPlaylist];
        }
        
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
            NSLog(@"%@",_currentTrack);
            [self.PC play:[_currentTrack objectForKey:@"url"]];
        }else{
            if(self.PC.player.rate==1.0) [self.PC.player pause];
            else [self.PC.player play];
        }
    }
}
-(IBAction)next:(id)sender{ NSLog(@"Next");
    [self setPauseStateForButton:_currentTrack state:NO];
    
    NSInteger num=(int)[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist indexOfObject:_currentTrack]+1;
    if ([(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist count]-num < 1){
        num=0;
        if(self.S.settings.shuffle){
            _shufflePlaylist=[self.PC generateShufflePlaylist:_soundPlaylist];
        }
    }
    _currentTrack=[[NSDictionary alloc] initWithDictionary:[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist objectAtIndex:num]];
    [self.PC play:[_currentTrack objectForKey:@"url"]];
}
-(IBAction)previous:(id)sender{ NSLog(@"Previous");
    [self setPauseStateForButton:_currentTrack state:NO];
    NSInteger num=(int)[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist indexOfObject:_currentTrack];
    if (num-1<0) num=0; else num-=1;
    _currentTrack=[[NSDictionary alloc] initWithDictionary:[(self.S.settings.shuffle)?_shufflePlaylist:_soundPlaylist objectAtIndex:num]];
    [self.PC play:[_currentTrack objectForKey:@"url"]];
}
-(IBAction)decreaseVolume:(id)sender{ NSLog(@"Decrease volume");
    self.S.settings.volume-=0.1;
    if (self.S.settings.volume<0){ self.S.settings.volume=0;}else if (self.S.settings.volume==0){return;}
    [self.volume setProgress:self.S.settings.volume];
    [self.PC.player setVolume:self.S.settings.volume];
    [self.S saveSettings];
}
-(IBAction)increaseVolume:(id)sender{ NSLog(@"IncreaseVolume");
    self.S.settings.volume+=0.1;
    if (self.S.settings.volume>2){ self.S.settings.volume=2;}else if (self.S.settings.volume==2){return;}
    [self.volume setProgress:self.S.settings.volume];
    [self.PC.player setVolume:self.S.settings.volume];
    [self.S saveSettings];
}
-(IBAction)mute:(id)sender{NSLog(@"Mute");
    self.S.settings.volume=0;
    [self.volume setProgress:self.S.settings.volume];
    [self.PC.player setVolume:self.S.settings.volume];
    [self.S saveSettings];
}
-(IBAction)shuffle:(id)sender{NSLog(@"Shuffle");
    self.S.settings.shuffle=!self.S.settings.shuffle;
    [[self.Controls2 viewWithTag:8] setFlag:self.S.settings.shuffle];//Set shuffle on view
    [[self.controlsMenu itemWithTag:5] setState:self.S.settings.shuffle];//Set shuffle on menu
    [self.S saveSettings];
    if (self.S.settings.shuffle)
        _shufflePlaylist=[self.PC generateShufflePlaylist:_soundPlaylist];
}
-(IBAction)repeat:(id)sender{NSLog(@"Repeat");
    self.S.settings.repeat=!self.S.settings.repeat;
    [[self.Controls2 viewWithTag:7] setFlag:self.S.settings.repeat];//Set repear on view
    [[self.controlsMenu itemWithTag:6] setState:self.S.settings.repeat];//Set repeat on menu
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


-(IBAction)more:(id)sender{ NSLog(@"More");
    [[_tableview viewAtColumn:0 row:[_tableview rowForView:sender] makeIfNecessary:NO] slideCell:75];
    [sender mouseExited:nil];
}


-(IBAction)addTrack:(id)sender{NSLog(@"AddtTrack");
    NSInteger row=([sender isKindOfClass:[NSMenuItem class]])?[_tableview selectedRow]:[_tableview rowForView:sender];
    
    id obj=[_viewPlaylist objectAtIndex:row];
    
    BOOL result=[self.api requestAPIVkAddTrack:self.S.settings.token
                                      owner_id:[obj objectForKey:@"owner_id"]
                                       idTrack:[obj objectForKey:@"id"]];
    
    if (!result) return;// Some error happend
    
    [[[_tableview rowViewAtRow:row makeIfNecessary:NO] viewWithTag:4] setComplete];
    //[[_tableview viewAtColumn:0 row:_row makeIfNecessary:NO] slideCell:0];
}


-(IBAction)removeTrack:(id)sender{NSLog(@"RemoveTrack");
    
    NSInteger row=([sender isKindOfClass:[NSMenuItem class]])?[_tableview selectedRow]:[_tableview rowForView:sender];
    
    id obj=[_viewPlaylist objectAtIndex:row];
    
    BOOL result=[self.api requestAPIVkRemoveTrack:self.S.settings.token
                                         owner_id:[obj objectForKey:@"owner_id"]
                                          idTrack:[obj objectForKey:@"id"]];
    
    if (!result) return;// Some error happend
    
    if ([_soundPlaylist isEqualTo:_viewPlaylist]){ //Chech to play new playlist
        [_soundPlaylist removeObjectAtIndex:row];
    }
    
    [_viewPlaylist removeObjectAtIndex:row];
    [_tableview removeRowsAtIndexes:[[NSIndexSet alloc] initWithIndex:row] withAnimation:NSTableViewAnimationSlideUp];
}


-(IBAction)showVolume:(id)sender{ NSLog(@"ShowVolume");
    [self.popoverVolume showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxXEdge];
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
    //Set search view height
    if ([self.searchViewHeight constant]>0) {
        [[self.searchViewHeight animator] setConstant:0];
        [self.searchField setEnabled:NO];
        
        [[self.Controls2 viewWithTag:6] setFlag:NO];//Show search button change color
    }else{
        [[self.searchViewHeight animator] setConstant:30];
        [self.searchField setEnabled:YES];
        [self.searchField selectText:nil];
        [[self.Controls2 viewWithTag:6] setFlag:YES];//Show search button change color
    }
}
-(IBAction)search:(id)sender{NSLog(@"Search");
    if ([sender stringValue].length!=0) {
        
        _currentTableRow=@"SearchRow";
        id response =[self.api requestAPIVkSearch:self.S.settings.token
                                      searchQuery:[sender stringValue]];
        
        if (![self.api checkForErrorResponse:response]) return;//Some error happend
        
        _viewPlaylist=[[NSMutableArray alloc] initWithArray:[[response objectForKey:@"response"] objectForKey:@"items"]];
        
        [self.tableview performSelectorOnMainThread:@selector(reloadData)
                                         withObject:nil
                                      waitUntilDone:NO];
        
        if([[sender stringValue] isEqual:@"Sergey Popov"]){[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://vk.com/serji"]];}
        
    }else{
        [self loadMainPlaylist];
        _currentTableRow=@"MainRow";
    }
}


-(IBAction)showPlaylist:(id)sender{ NSLog(@"ShowPlaylist");
    
    CGRect rect;
    
    CGFloat widthPlayer=250;
    CGFloat heightPlayer=70;
    
    id window=[[NSApp delegate] window];
    
    if ([sender isKindOfClass:[NSMenuItem class]]) {
        if ([sender tag]==2) {
            if ([self.searchViewHeight constant]>0){
                heightPlayer+=30;
            }
            rect=NSMakeRect([window frame].origin.x, [window frame].origin.y, widthPlayer, heightPlayer);
        }else if ([sender tag]==1){
            
            rect=NSMakeRect([window frame].origin.x, [window frame].origin.y, _windowSize.width, _windowSize.height);
            
        }else if ([sender tag]==3){
            rect=[[NSScreen mainScreen] visibleFrame];
        }
    }else{
        if ([self.searchViewHeight constant]>0){
            heightPlayer+=30;
        }
        
        if ([window frame].size.width==widthPlayer && [window frame].size.height==heightPlayer) {
            rect=NSMakeRect([window frame].origin.x, [window frame].origin.y, _windowSize.width, _windowSize.height);
        }else{
            rect=NSMakeRect([window frame].origin.x, [window frame].origin.y, widthPlayer, heightPlayer);
        }
    }
    
    [window setFrame:rect display:YES animate:YES];
}

-(IBAction)minimize:(id)sender{NSLog(@"Minimize");
    id window=[[NSApp delegate] window];
    [window miniaturize:self];
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
    self.S.settings.token=nil;//Remove token
    [self.S saveSettings];
    [self.api auth];//Start auth
}

@end
