//
//  Preferences.m
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Preferences.h"

@interface Preferences ()

@end

@implementation Preferences

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithWindowNibName:@"Preferences"];
    if (self) {
        
        //INIT SOMTING
    }
    return self;
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    /*
     *  Generl Preferences
     *************************/
    //Set checkbox
    if (Settings.sharedInstance.settings.showArtworkDock){
        [self.showDockIconArtworkGeneralBtn setState:1];
    }
    
    //Set checkbox
    if (Settings.sharedInstance.settings.showIconMenubar){
        [self.showMenubarIconGeneralBtn setState:1];
    }
    //Set checkbox
    if (Settings.sharedInstance.settings.searchArtwork) {
        [self.searchArtworkGeneralBtn setState:1];
    }
    
    //Set checkbox
    if (Settings.sharedInstance.settings.showNotafications){
        [self.showNotaficationGeneralBtn setState:1];
    }
    
    /*
     * Lastfm
     ************************/
    
    //Set checkbox
    if (Settings.sharedInstance.settings.scrobbleTrackLastfm){
        [self.scrobbleTracksLastfmBtn setState:1];
    }
    
    //Set checkbox
    if (Settings.sharedInstance.settings.nowPlayingTrackLastfm){
        [self.nowPlayingLastfmBtn setState:1];
    }
    
    //Set username
    [self updateProfileLastfm];
    
    /*
     * Toolbar
     *************************/
    
    [self.toolbar setSelectedItemIdentifier:@"GeneralPreferences"];
    [self.window setContentSize:self.generalPreferencesView.frame.size];
    [self.window.contentView addSubview:self.generalPreferencesView];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar{
    return [NSArray arrayWithObjects:@"GeneralPreferences",@"VkPreferences",@"LastfmPreferences",nil];
}

- (IBAction)switchView:(id)sender { NSLog(@"switchView");
    NSInteger tag= [sender tag];
    NSView * view;
    NSView *previousView=[[self.window.contentView subviews] objectAtIndex:0];
    
    if (tag==1) {
        view=self.generalPreferencesView;
        [self.window setTitle:@"General"];
    }else if (tag==2) {
        view=self.vkPreferencesView;
        [self.window setTitle:@"vk.com"];
    }else if (tag==3) {
        view=self.lastfmPreferencesView;
        [self.window setTitle:@"Last.fm"];
    }
    
    [NSAnimationContext beginGrouping];
    if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask){
        [[NSAnimationContext currentContext] setDuration:1.0];
    }
    
    NSRect newFrame = [self newFrameForNewContentView:view];
    [[self.window animator] setFrame:newFrame display:YES];
    [[self.window.contentView animator] replaceSubview:previousView with:view];
    [NSAnimationContext endGrouping];
}

- (NSRect)newFrameForNewContentView:(NSView*)view {
    NSWindow *window = [self window];
    NSRect newFrameRect = [window frameRectForContentRect:[view frame]];
    NSRect oldFrameRect = [window frame];
    NSSize newSize = newFrameRect.size;
    NSSize oldSize = oldFrameRect.size;
    
    NSRect frame = [window frame];
    frame.size = newSize;
    frame.origin.y -= (newSize.height - oldSize.height);
    return frame;
}

/*
 *  Generl Preferences
 *************************/

#pragma mark Genetal Preferences

- (IBAction)showMenubarIconGeneral:(id)sender{ NSLog(@"showMenubarIconGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.showIconMenubar=YES;
    }else{
        Settings.sharedInstance.settings.showIconMenubar=NO;
    }
    [Settings.sharedInstance saveSettings];
    
    [self.delegate updateMenuBarIcon];
}


- (IBAction)showDockIconArtworkGeneral:(id)sender{ NSLog(@"showDockIconArtworkGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.showArtworkDock=YES;
    }else{
        Settings.sharedInstance.settings.showArtworkDock=NO;
    }
    [Settings.sharedInstance saveSettings];
    
    [self.delegate updateDockIcon];
}


- (IBAction)searchArtworkGeneral:(id)sender{ NSLog(@"searchArtworkGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.searchArtwork=YES;
    }else{
        Settings.sharedInstance.settings.searchArtwork=NO;
    }
    [Settings.sharedInstance saveSettings];
}


- (IBAction)showNotaficationGeneral:(id)sender{ NSLog(@"showNotaficationGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.showNotafications=YES;
    }else{
        Settings.sharedInstance.settings.showNotafications=NO;
    }
    [Settings.sharedInstance saveSettings];
}

/*
 *  VK Preferences
 *************************/
#pragma mark VK Preferences

- (IBAction)authorizationVk:(id)sender{ NSLog(@"authorizationVk");
    
}
// NOT USED BECAUSE PERMISSION DININED
//- (IBAction)offlineVk:(id)sender{ NSLog(@"offlineVK");
//    
//    if (!_vkAPI) {
//        _vkAPI= [[vkAPI alloc] init];
//    }
//    
//    if ([sender state]) {
//        [self.vkAPI account_setOffline];
//        Settings.sharedInstance.settings.userOffline=YES;
//    }else{
//        Settings.sharedInstance.settings.userOffline=NO;
//    }
//    [Settings.sharedInstance saveSettings];
//}

/*
 *  Lastfm Preferences
 *************************/
#pragma mark Lastfm Preferences
- (IBAction)authorizeLastfm:(id)sender{ NSLog(@"AuthorizeLastfm");
    
    if (!_lastfmAPI) {
        _lastfmAPI= [[LastfmAPI alloc] init];
    }
    
    if (Settings.sharedInstance.settings.sessionLastfm) {
        [self.lastfmAPI unAuthorize];
        [self updateProfileLastfm];
    }else{
        [self.lastfmAPI authorize];
    }
}
- (IBAction)nowPlayingLastfm:(id)sender{ NSLog(@"nowPlayngLastfm");
    if ([sender state]) {
        Settings.sharedInstance.settings.nowPlayingTrackLastfm=YES;
    }else{
        Settings.sharedInstance.settings.nowPlayingTrackLastfm=NO;
    }
    [Settings.sharedInstance saveSettings];
}
- (IBAction)scrobbleTracksLastfm:(id)sender{ NSLog(@"scrobbleTracksLastfm");
    if ([sender state]) {
        Settings.sharedInstance.settings.scrobbleTrackLastfm=YES;
    }else{
        Settings.sharedInstance.settings.scrobbleTrackLastfm=NO;
    }
    [Settings.sharedInstance saveSettings];
}

- (IBAction)visitProfileLastfm:(id)sender { NSLog(@"VisitProfileLastfm");
    NSString * strURL= [NSString stringWithFormat:@"http://last.fm/user/%@",[sender title]];
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:strURL]];
}

-(void) updateProfileLastfm{
    //Set checkbox
    if (Settings.sharedInstance.settings.sessionLastfm){
        [self.authorizeLastfmBtn setTitle:@"Unauthorize"];
    }else{
        [self.authorizeLastfmBtn setTitle:@"Authorize"];
    }
    
    if (Settings.sharedInstance.settings.nameLastfm){
        [self.visitProfileLastfmBtn setTitle:Settings.sharedInstance.settings.nameLastfm];
        [self.visitProfileLastfmBtn setHidden:NO];
    }else{
        [self.visitProfileLastfmBtn setHidden:YES];
    }
}

@end
