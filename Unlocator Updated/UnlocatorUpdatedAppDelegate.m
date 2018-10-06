//
//  UnlocatorUpdatedAppDelegate.m
//  Unlocator Updater
//
//  Created by Marco Dalprato on 02/06/14.
//  Copyright (c) 2015 Marco Dalprato. All rights reserved.
//

#import "UnlocatorUpdatedAppDelegate.h"
#import "WebKit/WebKit.h"

// defining some stuff for the colors of the windows
#define RGB(r, g, b) [NSColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [NSColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

// VARIABLES *******************************************************************************************************************************************************************************************

NSString * private_key_saved; // The Url for the private key
NSString * second_timing_saved; // The seconds for the interval timer
NSString * auto_update_check_saved; // The check for the timer (if checked the timer is active)
NSString * notify_if_changed_saved; // The check for the notification (if checked the app could sends notification)
NSString * notify_if_something_wrong_saved;
NSString * notify_connection_problems_saved;
NSString * check_for_updates_saved;
NSString * previus_time_saved; // time at the moment of start (or every matching time)
NSString * logged_saved;
NSString * username_saved;
NSString * first_update_on_load_saved;
NSString * matched_time; // time to reach and start the update
NSString * last_update;
NSString * marcodalprato_button_link;
NSString * marcodalprato_home_link;
NSString * unlocator_member_link;
NSString * international_service_url ;
NSString * url_update;
NSString * pre_url_string ;
NSString * unlocator_register_link;
NSString * app_version; // current version of the app
NSString * url_for_the_index_page;
NSDictionary * timer_interval_list;
NSDictionary * macro_list;
NSDictionary * settings;
NSDictionary *  macro_settings;

NSTimer *timer;
NSString * newversion_link;
NSString * free_update;

NSString* macro_filepath;
NSString* settings_filepath;

int international_index = 0;
int n = 0; //general variabile
int need_update = 0 ;// if 0 -> no, if 1 -> yes



// DECLARATIONS ***********************************************************************************************************************************

@implementation UnlocatorUpdatedAppDelegate

@synthesize private_key_text;
@synthesize respose_label;
@synthesize window;
@synthesize lastupdate_label_menu;
@synthesize respose_label_menu;
@synthesize keep_update_check;
@synthesize notify_only_if_changed;
@synthesize notify_connection_problems;
@synthesize notify_if_something_wrong;
@synthesize timer_on_status_menu;
@synthesize timer_off_status_menu;
@synthesize status_image;
@synthesize international_service_lang_list;
@synthesize unlocator_services_array;
@synthesize international_service_name_list;
@synthesize unlocator_services_lang_array;
@synthesize unlocator_services_index_array;
@synthesize select_international_service_title;
@synthesize username_login;
@synthesize password_login;
@synthesize api_key_wizard_window;
@synthesize settings_tab;
@synthesize update_button;
@synthesize logout_btn;
@synthesize menu_bar_logged_info;
@synthesize home_link_btn;
@synthesize check_update_on_load;
@synthesize help_window;
@synthesize settings_window;
@synthesize International_menu_settings;
@synthesize login_progressbar;
@synthesize Internationa_response_label;
@synthesize update_spinner;
@synthesize timer_interval_combobox;
@synthesize timer_interval_menu;
@synthesize prefereces_menu;
@synthesize international_pre_menu;
@synthesize updates_pre_menu;
@synthesize update_now_menu_button;
@synthesize preferecens_button;
@synthesize timer_menu;
@synthesize check_updates_menuitem;
@synthesize check_for_updates;
@synthesize newversion_popup_window;
@synthesize relesenotes_text;
@synthesize newversion_infolabel;
@synthesize download_version_progressbar;
@synthesize download_new_version_btn;
@synthesize macro_menubar;
@synthesize macro_pre_menu;

// FUCTIONS *********************************************************************************************************************************************

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [macro_pre_menu setHidden:TRUE];

    // set the configuration for every plist file
    
     settings_filepath = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
    
    
    NSLog(@"Unlocator Updater has been opened");
    

    [self disable_stuff_because_not_logged];
    
    // disable the tabs
    [settings_tab setTabViewType:NSNoTabsBezelBorder];
 
    // reading files from settings.plist
    
    settings = [NSDictionary dictionaryWithContentsOfFile:settings_filepath];

    marcodalprato_button_link = [settings valueForKeyPath:@"marcodalprato_button_link"];
    marcodalprato_home_link = [settings valueForKeyPath:@"marcodalprato_home_link"];
    unlocator_member_link = [settings valueForKeyPath:@"unlocator_member_link"];
    international_service_url = [settings valueForKeyPath:@"international_service_url"];
    url_update = @"http://www.marcodalprato.com/app_update_files/unlocatorupdater/mac_update.xml";
    pre_url_string = [settings valueForKeyPath:@"pre_url_string"];
    unlocator_register_link = @"https://unlocator.com/account/aff/go/G4ryH3xMrfqkFM2e";
    url_for_the_index_page= [settings valueForKeyPath:@"url_for_the_index_page"];
    timer_interval_list = [settings valueForKeyPath:@"timer_interval_list"];
    
     lastupdate_label_menu.title = [NSString stringWithFormat:NSLocalizedString(@"No update required",nil)];
   
    // reset settings

    /*
    
     NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
     [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
     */

    // popolating the timer inverval combobox
    
    NSArray *keys = [timer_interval_list allKeys];
    NSArray *values = [timer_interval_list allValues];
    
    // check if an update interval is less then 800 seconds
    
    for (int i = 0 ; i < [values count]; i++) {
      
        // NSLog(@"values =%@", values[i]);
        if([values[i] intValue] < 800){
            
            //NSLog(@"Configuration Error ! You cannot configure an interval less then 800 seconds. /n Check the configuration file for more information");
    
            NSLocalizedString(@"No Internet connection",nil);
         
            NSAlert* msgBox = [[NSAlert alloc] init];
            [msgBox setMessageText:NSLocalizedString(@"Configuration Error ! You cannot configure an interval less then 800 seconds. /n Check the configuration file for more information",nil)];
            [msgBox addButtonWithTitle: @"OK"];
            [msgBox runModal];
            
            
            exit(0);
            
        }
     
    }
    
    [timer_interval_combobox removeAllItems];
    [timer_interval_combobox addItemsWithObjectValues:keys];

    
    // Setting the default saved data *******
    
    private_key_saved           = [[NSUserDefaults standardUserDefaults] objectForKey:@"private_key_saved"];
    second_timing_saved         = [[NSUserDefaults standardUserDefaults] objectForKey:@"seconds_timing_saved"];
    auto_update_check_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"auto_update_check_saved"];
    notify_if_changed_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"notify_if_changed_saved"];
    notify_if_something_wrong_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"notify_if_something_wrong_saved"];
    notify_connection_problems_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"notify_connection_problems_saved"];
    logged_saved                = [[NSUserDefaults standardUserDefaults] objectForKey:@"logged_saved"];
    username_saved              = [[NSUserDefaults standardUserDefaults] objectForKey:@"username_saved"];
    first_update_on_load_saved  = [[NSUserDefaults standardUserDefaults] objectForKey:@"first_update_on_load_saved"];
    check_for_updates_saved = [[NSUserDefaults standardUserDefaults] objectForKey:@"check_for_updates_saved"];
  
    // check internet connection
    
    if (![self connected]) {
        
        respose_label.stringValue = NSLocalizedString(@"No Internet connection",nil);
        respose_label_menu.title =  NSLocalizedString(@"No Internet connection",nil);
        
        // no internet -> disable suff
        
        [self disable_stuff_because_not_logged];
        
        // Do something, we are without internet connection
        // NSLog(@"There's no internet connection available");
  
       
        if([notify_connection_problems_saved isEqualToString:@"1"]){
            
            NSUserNotification *notification = [[NSUserNotification alloc] init];
            notification.title =  NSLocalizedString(@"Unlocator Updater",nil);
            notification.informativeText =  NSLocalizedString(@"No Internet connection, cannot proceed.",nil);
            notification.soundName = NSUserNotificationDefaultSoundName;
            
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
            
        }
        
        return;
        
    }
    

    
    unlocator_services_array = [[NSMutableArray alloc] init];
    unlocator_services_lang_array = [[NSMutableArray alloc] init];
    unlocator_services_index_array = [[NSMutableArray alloc] init];
    
    NSURL *theURL = [NSURL URLWithString:international_service_url];
    
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:theURL];
    [xmlParser setDelegate:self];
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
    
    
    // clear the situation (width & height)
    
    app_version =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    window.title = [NSString stringWithFormat:@"Unlocator Updater %@",app_version];
    
    // // // NSLog(@"logged_saved = %@",logged_saved);
  

    
    if([logged_saved isEqualToString:@"yes"]){ // already logged
        
        // if you are logged you should see only the settings page so ..
        // settings page -> not hidden
        // login page --> hidden
        // logout button --> not hidden
        
        [settings_tab selectTabViewItemAtIndex:1];
       
        
        [self enable_stuff_because_logged];
        
        if(username_saved == nil){
            
            logout_btn.title =  NSLocalizedString(@"Go back to Login",nil);
            [menu_bar_logged_info setHidden:TRUE];
        
        }else{
            
            logout_btn.title = [NSString stringWithFormat:@"Logout %@", username_saved];
            menu_bar_logged_info.title = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Signed in as",nil), username_saved];
          
        }
        
    }else{
        
        [help_window makeKeyAndOrderFront:nil]; // to show it
        [settings_tab selectTabViewItemAtIndex:0];
        
        menu_bar_logged_info.title =  NSLocalizedString(@"Not Logged",nil);
        respose_label.stringValue =   NSLocalizedString(@"Not logged",nil);
        respose_label_menu.title =  NSLocalizedString(@"Not logged",nil);
        status_image.image = [NSImage imageNamed:@"red_icon.png"];
        
        [self disable_stuff_because_not_logged];
        
        return;
        
    }
    
    
    if (private_key_saved != nil) { // if private key is saved I'll show the saved key , otherwise I'll show a general message.
        
        private_key_text.stringValue = [[NSString alloc] initWithFormat:@"%@", private_key_saved];
       
         if([first_update_on_load_saved  isEqual: @"1"]){[NSThread detachNewThreadSelector:@selector(update_fuction) toTarget:self withObject:nil];}
       
    }
   
    
    // force the first item as selected one
    // all cheked buttons
    
    if ([auto_update_check_saved isEqualToString:@"0"]) {
        
        [keep_update_check setState:0];

        [timer_on_status_menu setState:0];
        [timer_off_status_menu setState:1];
        
    } else {
        
        [keep_update_check setState:1];
        
        [timer_on_status_menu setState:1];
        [timer_off_status_menu setState:0];
    }
    
    
    if ([notify_if_changed_saved isEqualToString:@"0"]) {[notify_only_if_changed setState:0];} else {[notify_only_if_changed setState:1];}
    if ([first_update_on_load_saved isEqualToString:@"0"]) {[check_update_on_load setState:0];} else {[check_update_on_load setState:1];}
    // set the combobox with the value of the saved settings
    if (second_timing_saved == 0) {[timer_interval_combobox selectItemAtIndex:0];}else {timer_interval_combobox.stringValue = [[timer_interval_list allKeysForObject:second_timing_saved]lastObject];}
    
    if ([notify_if_something_wrong_saved isEqualToString:@"0"]) {[notify_if_something_wrong setState:0];} else {[notify_if_something_wrong setState:1];}
    if ([notify_connection_problems_saved isEqualToString:@"0"]) {[notify_connection_problems setState:0];} else {[notify_connection_problems setState:1];}
    if ([check_for_updates_saved isEqualToString:@"0"]) {[check_for_updates setState:0];} else {[check_for_updates setState:1];}
    
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];

    [self calculate_match_time];
    
    if([auto_update_check_saved isEqualToString:@"1"]){ timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer_action) userInfo:nil repeats:YES]; }else{ [timer invalidate];}
    
    // update the last update label
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    

    // check new versions if allowed by the customer
    if ([check_for_updates_saved isEqualToString:@"0"]) {} else { [NSThread detachNewThreadSelector:@selector(check_new_versions_function) toTarget:self withObject:nil];}

    
    [NSThread detachNewThreadSelector:@selector(macro_settings_loading_function) toTarget:self withObject:nil];
    
} // Inizializating all the components

- (BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (void)save_function{
    
   
     // NSLog(@"SAVE CALLED");
    
    if ([private_key_text.stringValue rangeOfString:pre_url_string].location == NSNotFound) {
        // // // NSLog(@"string does not contain http://unlo.it/");
         private_key_text.stringValue = [NSString stringWithFormat:@"%@%@",pre_url_string,private_key_text.stringValue];
        // // // NSLog(@"New string with add = %@",private_key_text.stringValue);
        
        
    } else {
        // // // NSLog(@"string contains http://unlo.it/!");
       
        // do nothing
    }
	
        // if url is correct I save it
	
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:private_key_text.stringValue forKey:@"private_key_saved"]; // saving the private key
        [defaults setObject:keep_update_check.stringValue forKey:@"auto_update_check_saved"]; // saving the auto-update settings
        [defaults setObject:notify_only_if_changed.stringValue forKey:@"notify_if_changed_saved"]; // saving the auto-update settings
        [defaults setObject:notify_if_something_wrong.stringValue forKey:@"notify_if_something_wrong_saved"]; // saving the auto-update settings
        [defaults setObject:notify_connection_problems.stringValue forKey:@"notify_connection_problems_saved"]; // saving the auto-update settings
        [defaults setObject:check_update_on_load.stringValue forKey:@"first_update_on_load_saved"]; // saving the auto-update settings
        [defaults setObject:[timer_interval_list objectForKey:timer_interval_combobox.stringValue] forKey:@"seconds_timing_saved"]; // saving the timing option
        [defaults setObject:check_for_updates.stringValue forKey:@"check_for_updates_saved"]; // saving the private key
        [defaults synchronize];
    
        // Setting the default saved data *******
        
        private_key_saved           = [[NSUserDefaults standardUserDefaults] objectForKey:@"private_key_saved"];
        second_timing_saved         = [[NSUserDefaults standardUserDefaults] objectForKey:@"seconds_timing_saved"];
        auto_update_check_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"auto_update_check_saved"];
        notify_if_changed_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"notify_if_changed_saved"];
        notify_if_something_wrong_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"notify_if_something_wrong_saved"];
        notify_connection_problems_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"notify_connection_problems_saved"];
        first_update_on_load_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"first_update_on_load_saved"];
        check_for_updates_saved     = [[NSUserDefaults standardUserDefaults] objectForKey:@"check_for_updates_saved"];

        // setting the timer after that someone saved the settings
        
        [self calculate_match_time];
    
        if([auto_update_check_saved isEqualToString:@"1"]){
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer_action) userInfo:nil repeats:YES];
        
            [timer_on_status_menu setState:1];
            [timer_off_status_menu setState:0];
            
        }else{
            
            [timer invalidate];
            [timer_on_status_menu setState:0];
            [timer_off_status_menu setState:1];
        }
        

    [self update_intervalmenu];

  
}

- (void)awakeFromNib {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  
    NSImage *menuIcon = [NSImage imageNamed:@"Menu Icon"];
    NSImage *highlightIcon = [NSImage imageNamed:@"Menu Icon"]; // Yes, we're using the exact same image asset.

    
    
   [highlightIcon setTemplate:YES]; // Allows the correct highlighting of the icon when the menu is clicked.
    
    [[self statusItem] setImage:menuIcon];
    [[self statusItem] setAlternateImage:highlightIcon];
    [[self statusItem] setMenu:[self menu]];
    [[self statusItem] setHighlightMode:YES];
}

- (void)timer_action { // check the current time to the set matched time
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString * time_now = [dateFormatter stringFromDate: currentTime];
    
    n= n +1;
    

    
  
    // Increment the progress bar value by 1

    
    if([auto_update_check_saved isEqualToString:@"1"]){
        
        if([time_now isEqualToString:matched_time]){
            
            [status_image setHidden:TRUE];
            [update_spinner setHidden:FALSE];
            [update_spinner startAnimation:0];
            

            [NSThread detachNewThreadSelector:@selector(update_fuction) toTarget:self withObject:nil];
        }
   
    }
}

- (void)update_fuction{
	
	 NSLog(@"Request for an Update of the IP recived");
	
    if (![self connected]) {
        
        if([notify_connection_problems_saved isEqualToString:@"1"]){
            
            NSUserNotification *notification = [[NSUserNotification alloc] init];
            notification.title =  NSLocalizedString(@"Unlocator Updater",nil);
            notification.informativeText =  NSLocalizedString(@"No Internet connection, cannot proceed.",nil);
            notification.soundName = NSUserNotificationDefaultSoundName;
            
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
            
        }

        [status_image setHidden:FALSE];
        [update_spinner setHidden:TRUE];
        [update_spinner stopAnimation:0];
        
        return;
        
        
    }
    
    
    
    // // // NSLog(@"logged_saved = %@",logged_saved);
    
    if([logged_saved isNotEqualTo:@"yes"]){ // already logged
 
         // NSLog(@"Update function not ALLOWED");

        return;
    }else{
    
    
    [self calculate_match_time];
        
    

    // Get response from ulocator webpage

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:private_key_saved]];
    NSError *err;
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *   respose_from_unlocator = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];

    // check if the response contains the string "IP", if yes that mean that the url is correct


    // update the last update label
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
		NSInteger response_lenght = [respose_from_unlocator length];

        NSLog(@"Response from Unlocator Website = %@", respose_from_unlocator);
		
		/*
		 Possibile answers
		 
		 IP 79.25.6.114 exists
		 
		 or
		 
		 IP 79.18.93.53 added
		 
		 ove 25 words should be stopped
		 
		 */
    
        
        if (response_lenght >2 && response_lenght < 25) { // response ok
            
            
            NSString *replaced;
            
            
            replaced  = [respose_from_unlocator stringByReplacingOccurrencesOfString:@"added" withString:NSLocalizedString(@"added",nil)];
            replaced = [replaced stringByReplacingOccurrencesOfString:@"exists" withString:NSLocalizedString(@"exists",nil)];
           

            respose_label_menu.title = replaced;
            respose_label.stringValue = replaced;
            
         
            status_image.image = [NSImage imageNamed:@"green_icon.png"];
            
        } else { // no response
            
            respose_label.stringValue = NSLocalizedString(@"Unexpected response from the network",nil);
            respose_label_menu.title =   NSLocalizedString(@"Unexpected response from the network",nil);
            status_image.image = [NSImage imageNamed:@"red_icon.png"];
         	
	          
        }
		
		
    //respose_from_unlocator = yout ip addes
    // result string = last time
    
    // update menu bar
    
    lastupdate_label_menu.title = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Latest update:",nil), resultString];
    
    
    // // // NSLog(@" %@",respose_from_unlocator);
    
    NSString * temp_text;
    
        
        
        NSRange range_unlocator_response = [respose_from_unlocator rangeOfString:@"IP"];
        
        if ( range_unlocator_response.location != NSNotFound ) {
            
            // // // NSLog(@"everything ok");
            temp_text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Unlocator said that",nil), respose_from_unlocator];

            
        }else{
             temp_text =  NSLocalizedString(@"An unexpected error has occurred",nil);
            
            
            // error notification is update goes wrong
            
            if([notify_if_something_wrong_saved isEqualToString:@"1"]){
                
                NSUserNotification *notification = [[NSUserNotification alloc] init];
                notification.title =  NSLocalizedString(@"Unlocator Updater",nil);
                notification.informativeText =  NSLocalizedString(@"An unexpected error has occurred",nil);
                notification.soundName = NSUserNotificationDefaultSoundName;
                
                [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
                
            }
        
            
        }

        
    
    if([notify_if_changed_saved isEqualToString:@"1"]){ // notification center check box
        
        
        NSUserNotification *notification = [[NSUserNotification alloc] init];
        notification.title = @"Unlocator Updater";
        notification.informativeText = temp_text;
        notification.soundName = NSUserNotificationDefaultSoundName;
        
        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
        
        
    }
    }
    
    [status_image setHidden:FALSE];

    [update_spinner setHidden:TRUE];
    [update_spinner stopAnimation:0];
    
    
} // the core of the app

- (void)calculate_match_time{
    
    // get the current time and save it, also add the timing in seconds to the current time saved
    
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    previus_time_saved = [dateFormatter stringFromDate: currentTime];
    
    NSDate *summed_time = [currentTime dateByAddingTimeInterval:[second_timing_saved intValue]];
    
    matched_time = [dateFormatter stringFromDate: summed_time];
    
    NSLog(@"Next update at %@",matched_time);
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}

- (void)check_new_versions_function{

    NSURL *configUrl = [NSURL URLWithString:url_update];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:configUrl];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    
   
    // Check no error, then parse data
    if (error == nil)
    {
        // Parse response into a dictionary
        NSPropertyListFormat format;
        NSString *errorStr = nil;
        NSDictionary *dictionary = [NSPropertyListSerialization propertyListFromData:data
                                                                    mutabilityOption:NSPropertyListImmutable
                                                                              format:&format
                                                                    errorDescription:&errorStr];
       
          if (errorStr == nil)
        {
            @try {
                
                // Try to retrieve the config values from the xml
                NSString *application_version = [dictionary objectForKey:@"application_version"];
                NSString *application_relesenotes = [dictionary objectForKey:@"application_relesenotes"];
                
                free_update = [dictionary objectForKey:@"free_update"];
                
             
                if([free_update isEqualToString:@"NO"]){
                    
                   [ download_new_version_btn setTitle:@"Buy New Version"];
                    
                }
                
                newversion_link = [dictionary objectForKey:@"newversion_link"];
                
                // NSLog(@"application_relesenotes =%@ ",application_relesenotes);
             
                float curent_version  = [app_version floatValue];
                float remote_version = [application_version floatValue];
                
          
                [relesenotes_text setString:application_relesenotes];
                
                 NSLog(@"curent_version = %f --- remote_version = %f",curent_version,remote_version);
                
              
                if(curent_version < remote_version){
                    
                    // NSLog(@"New Version Available");
                    
                    [check_updates_menuitem setTitle:NSLocalizedString(@"New Version Available",nil)];
                
                    newversion_infolabel.stringValue = [NSString stringWithFormat:@"%@ %@ %@",NSLocalizedString(@"Version",nil),application_version,NSLocalizedString(@"is now available",nil)];
                    
                    
                    NSDictionary *attributes = @{
                                                 NSFontAttributeName: [NSFont menuBarFontOfSize:0],
                                                 NSForegroundColorAttributeName: [NSColor redColor]
                                                };
                    
                    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:[check_updates_menuitem title] attributes:attributes];
                    [check_updates_menuitem setAttributedTitle:attributedTitle];
                    
                    need_update = 1;
                    
                  
                    [newversion_popup_window makeKeyAndOrderFront:self];
                    [NSApp activateIgnoringOtherApps:YES];
                    
                }else{
                    // NSLog(@"Nothing New Here");
                    need_update = 0;
                    /*
                    NSAlert* msgBox = [[NSAlert alloc] init];
                    [msgBox setMessageText:NSLocalizedString(@"This is the latest version of the Application. \nIf a new update is available, you'll be notified by a pop-up alert.",nil)];
                    [msgBox addButtonWithTitle: @"OK"];
                    [msgBox runModal];
                     
                     */
                    
                }
                
            } @catch (NSException *e) {
                // Error with retrieving the key
            }
        }
        else {
            // Error with parsing data into dictionary
        }
    }
    
    
} // function for check new versions

- (void)change_regions{
    
    Internationa_response_label.stringValue = @"Working ...";
    
    // example http://unlo.it/79f7a5b712bac07?country=us&channel=netflix
    
    NSString * country = international_service_lang_list.stringValue; // us, it ecc...
    NSString * channel = international_service_name_list.stringValue; // netflix, hulu ecc...
    
    
    [self function_change_international:country :channel];
    
}

- (void)logout{
    // reset all settings
    
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    
    [settings_tab selectTabViewItemAtIndex:0];
    
    
    
    menu_bar_logged_info.title =  NSLocalizedString(@"Not Logged",nil);
    respose_label.stringValue = NSLocalizedString(@"Not Logged",nil);
    respose_label_menu.title =  NSLocalizedString(@"Not Logged",nil);
    
    status_image.image = [NSImage imageNamed:@"red_icon.png"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"no" forKey:@"logged_saved"]; // saving the private key
    logged_saved           = [[NSUserDefaults standardUserDefaults] objectForKey:@"logged_saved"];
    
    [self disable_stuff_because_not_logged];
   
    
}

- (void)international_menu_changed{
    
    NSString * index_first_temp= [unlocator_services_index_array objectAtIndex:select_international_service_title.indexOfSelectedItem];
    NSString * index_last_temp= [unlocator_services_index_array objectAtIndex:select_international_service_title.indexOfSelectedItem+1];
    
    NSInteger index_first = [index_first_temp integerValue];
    NSInteger index_last = [index_last_temp integerValue];
    
    if(index_first == 0){
        index_first = 1;
    }
    
    
    NSInteger index_lenght = index_last - index_first;
    
    NSArray* slicedArray;
    
    if(index_first == 1){
        
        slicedArray = [unlocator_services_lang_array subarrayWithRange:NSMakeRange(0, index_lenght+1)];
        
    }else{
        slicedArray = [unlocator_services_lang_array subarrayWithRange:NSMakeRange(index_first, index_lenght)];
    }
    [international_service_lang_list removeAllItems];
    
    [international_service_lang_list addItemsWithObjectValues:slicedArray];
    
    [international_service_lang_list selectItemAtIndex:0];
    }

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    // // // NSLog(@"Document started", nil);
    depth = 0;
    currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // // // NSLog(@"Error: %@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    currentElement = [elementName copy];
    
    if ([currentElement isEqualToString:@"channels"])
    {
        ++depth;
        
    }
    else if ([currentElement isEqualToString:@"country"])
    {
        
        currentName = [[NSMutableString alloc] init];
        international_index++; // add index at every new nodes of country that inludes every new sub-nodes
    }
    
    else{
        
        if ([currentElement isNotEqualTo:@"channels"])
        {
            
            [unlocator_services_array addObject:currentElement];
            [unlocator_services_index_array addObject:[NSString stringWithFormat:@"%i",international_index]];
            
            //// // // NSLog(@"Service name = %@ Index = %d ",currentElement,international_index);
            
        }
        
    }
    
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"channels"])
    {
        --depth;
    }
    else if ([elementName isEqualToString:@"country"])
    {
        if (depth == 1)
        {
            
            NSString *shortString = [currentName substringToIndex:2]; // reduce to 2 words wvery country settings for avoid any "\n" characters
            [unlocator_services_lang_array addObject:shortString];
            
            // // // // NSLog(@"--%@ ", currentName);
            
        }
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([currentElement isEqualToString:@"country"])
    {
        [currentName appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    // // // NSLog(@"Document finished", nil);
    
    NSInteger total_items = [unlocator_services_lang_array count];
    
    [unlocator_services_index_array addObject:[NSString stringWithFormat:@"%ld",(long)total_items]];
    
    [international_service_name_list addItemsWithObjectValues:unlocator_services_array];
    
    [select_international_service_title selectItemAtIndex:0];
    [self international_menu_changed];
    [international_service_lang_list selectItemAtIndex:0];
    
    [self function_popolate_menubar];
    
}

- (void)login_function{
    
    [login_progressbar startAnimation:0];
    
    //Here YOUR URL
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url_for_the_index_page]];
    
    
    //create the Method "GET" or "POST"
    [request setHTTPMethod:@"POST"];
    
    //Pass The String to server(YOU SHOULD GIVE YOUR PARAMETERS INSTEAD OF MY PARAMETERS)
    NSString *userUpdate =[NSString stringWithFormat:@"amember_login=%@&amember_pass=%@",username_login.stringValue,password_login.stringValue];
    
    
    //Convert the String to Data
    NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
    
    //Apply the data to the body
    [request setHTTPBody:data1];
    
    
    //Create the response and Error
    NSError *err;
    NSURLResponse *response;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *resSrt = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
    
    //This is for Response
    
    if(resSrt)
    {
        // // // NSLog(@"got response");
        /* ViewController *view =[[ViewController alloc]initWithNibName:@"ViewController" bundle:NULL];
         [self presentViewController:view animated:YES completion:nil];*/
    }
    else
    {
        // // // NSLog(@"faield to connect");
    }
    
    // Please allow up to
    
    // convert the string into a array of lines
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *lines = [resSrt componentsSeparatedByString:@"\n"];
    NSString *substring;
    
    // check every single line for the one with the private key .. o yhea !
    for (NSString *line in lines) {
        
        NSRange range = [line rangeOfString:@"http://unlo.it"];
        
        
        
        if ( range.location != NSNotFound ) {
            // // // // NSLog(@"trovato = %@",line);
            // get the line with the private key
            // response ex <input type="text"  onClick="this.setSelectionRange(0, this.value.length)" value="http://unlo.it/privatekey" style="width:98%; font-size:13px; margin-bottom:0px;"/>
            
            
            NSRange searchFromRange = [line rangeOfString:@"value="];
            NSRange searchToRange = [line rangeOfString:@" style="];
            substring = [line substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
            
            substring = [substring stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            // After a lot of work I found the private key !!!!!! YEHA !!!!!
            
            private_key_text.stringValue = substring;
            
            [settings_tab selectTabViewItemAtIndex:1];
            
            [defaults setObject:@"yes" forKey:@"logged_saved"]; // saving the private key
            logged_saved           = [[NSUserDefaults standardUserDefaults] objectForKey:@"logged_saved"];
            [defaults setObject:username_login.stringValue forKey:@"username_saved"]; // saving the private key
            username_saved           = [[NSUserDefaults standardUserDefaults] objectForKey:@"username_saved"];
            
            logout_btn.title = [NSString stringWithFormat:@"Logout (%@)", username_login.stringValue];
            menu_bar_logged_info.title = [NSString stringWithFormat:@"Signed in as %@", username_login.stringValue];
            
        
            
            [self save_function];
            
            [login_progressbar stopAnimation:0];
            [login_progressbar setHidden:true];
            
            [self enable_stuff_because_logged];
            
        }
        
        
    }
    
    if(substring == nil ){
        [login_progressbar stopAnimation:0];
        [login_progressbar setHidden:TRUE];
        NSString * private_key_msg = [NSString stringWithFormat:@"Ops ... Looks like that your credentials are incorrect .. check it twice."];
        
        NSAlert* msgBox = [[NSAlert alloc] init];
        [msgBox setMessageText:private_key_msg];
        [msgBox addButtonWithTitle: @"OK"];
        [msgBox runModal];
        
        [defaults setObject:@"no" forKey:@"logged_saved"]; // saving the private key
        logged_saved           = [[NSUserDefaults standardUserDefaults] objectForKey:@"logged_saved"];
      
        [self disable_stuff_because_not_logged];
        return;
    }
    
    
    [defaults synchronize];
    
    
}

- (void)function_popolate_menubar{
    
    
    //Remove old Status Scan Menu:
    [International_menu_settings removeAllItems];

    if([unlocator_services_array count] > 0){
        
        
        // *** Initialization of the menu bar
    
        int i;
        int i_sub;
        
 
        for (i = 0 ; i < [unlocator_services_array count]; i++) {
            
            
            NSString * service = unlocator_services_array[i];
            
            NSMenuItem *mainItem = [[NSMenuItem alloc] init];
            
            
            NSString *capitalizedString = [service capitalizedString];
            [mainItem setTitle:capitalizedString];
            
            /*
             NSImage *newImage = [NSImage imageNamed:@"netflix.png"];
             
             [newImage setSize: NSMakeSize(30,30)];
             
             [mainItem setImage:newImage];
             
             */
            [International_menu_settings addItem:mainItem];
            
            
            NSString * index_first_temp= [unlocator_services_index_array objectAtIndex:i];
            NSString * index_last_temp= [unlocator_services_index_array objectAtIndex:i+1];
            
            NSInteger index_first = [index_first_temp integerValue];
            NSInteger index_last = [index_last_temp integerValue];
            
            if(index_first == 0){
                index_first = 1;
            }
            
            
            NSInteger index_lenght = index_last - index_first;
            
            NSArray* slicedArray;
            
            if(index_first == 1){
                
                slicedArray = [unlocator_services_lang_array subarrayWithRange:NSMakeRange(0, index_lenght+1)];
                
            }else{
                slicedArray = [unlocator_services_lang_array subarrayWithRange:NSMakeRange(index_first, index_lenght)];
            }
            
            NSMenu *submenu = [[NSMenu alloc] init];
            
            
            for (i_sub = 0 ; i_sub < [slicedArray count]; i_sub++) {
                //     // NSLog(@"sliced = %@", slicedArray[i_sub]);
                
                NSString  * submenu_string =  [NSString stringWithFormat:@"%@ - %@",service, slicedArray[i_sub]];
                
                
                
                [submenu addItemWithTitle:submenu_string action:@selector(international_menulink:)  keyEquivalent:@""];
                
                [mainItem setSubmenu:submenu];
            }
            
            
        }
        
        
    }
    
    
    // Timer Interval creations
    // Get of all the keys and valued from the array that is creaded with the settings.plist file.
    // Numerical order for the keys and the values.

    NSArray *timer_interval_list_values =  [[timer_interval_list allValues] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    NSArray *timer_interval_list_keys =  [[timer_interval_list allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];

    
    
    for (int a = 0 ; a < [timer_interval_list_keys count]; a++) {
     
        // adding a new menu item for each key of the array
        
        [timer_interval_menu addItemWithTitle:timer_interval_list_keys[a] action:@selector(timer_updates_menulink:)  keyEquivalent:@""];
        
        [[timer_interval_menu itemAtIndex:a] setState:0];
        
        if([second_timing_saved intValue]  == [timer_interval_list_values[a] intValue]){
            // NSLog(@"second_timing_saved = %@",second_timing_saved);
            // NSLog(@"timer_interval_list_values[a] = %@",timer_interval_list_values[a]);
            
            [timer_interval_menu.itemArray[a] setState:1];
            
        }
        
    }
     
    
    
    
 
   
}

- (void)update_intervalmenu{
    
    // NSLog(@"Reset menu selections");
    // Timer Interval creations
    
 
    for (int a = 0 ; a < [timer_interval_menu.itemArray count]; a++) {
        
        
        [timer_interval_menu.itemArray[a] setState:0];

        
        if( [timer_interval_combobox.stringValue isEqualToString:[timer_interval_menu.itemArray[a] title]]){
         
            [timer_interval_menu.itemArray[a] setState:1];

            
        }
        
    }
    
    
    
}

- (void)timer_updates_menulink:(id)sender {
    
    [sender setState:1];
    timer_interval_combobox.stringValue = [sender title];
    [self save_function];
    
}

- (void)international_menulink:(id)sender {
    
    
    // load window with live from the menu bar
    
    // something link "netflix - us"
    
    // NSLog(@"%@",[sender title]);
    
    
    // [NSThread detachNewThreadSelector:@selector(change_region:) toTarget:self withObject:nil];
    
    
    [NSThread detachNewThreadSelector:@selector(change_region:)
                             toTarget:self
                           withObject:[sender title]];
    
    
}

-(void)function_change_international:(NSString *) country :(NSString *) channel{
    
    // takes country and region and set the right internalization option on unlocator.com
    
    NSString * set_language_url = [NSString stringWithFormat:@"%@?country=%@&channel=%@", private_key_saved, country ,channel];
    NSLog(@"%@", set_language_url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:set_language_url]];
    NSError *err;
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *   respose_from_unlocator = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
    
    
    
    NSString *what_said = [respose_from_unlocator stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    NSInteger what_said_lenght = [what_said length];
    
    if (what_said_lenght == 0 ) {
        
        what_said =  NSLocalizedString(@"An unexpected error has occurred",nil);
        
    }
    
    Internationa_response_label.stringValue =what_said;
    respose_label_menu.title=what_said;
    NSLog(@"what_said_lenght = %li",(long)what_said_lenght);
}

- (void)change_region:(NSString *) string__from_menu{
    
    
    Internationa_response_label.stringValue =@"Working ...";
    
    NSArray * splittedmenu = [string__from_menu componentsSeparatedByString:@" - "];
    
    
    NSString * country = splittedmenu[1]; // us, it ecc...
    NSString * channel = splittedmenu[0]; // netflix, hulu ecc...
    
    [self function_change_international:country :channel];

}

- (void)disable_stuff_because_not_logged{
    
    
    // disable all the menu items
    // NSLog(@"DISABLE STUFF");
    
    [international_pre_menu setHidden:TRUE];

    [updates_pre_menu  setHidden:TRUE];
    [update_now_menu_button setHidden:TRUE]; // works only with hidden, not enable
    [update_button setEnabled:FALSE];
    [timer_menu setHidden:TRUE];
    [menu_bar_logged_info setHidden:TRUE];
    [lastupdate_label_menu setHidden:TRUE];
    status_image.image = [NSImage imageNamed:@"red_icon.png"];
    private_key_text.stringValue = @""; // clean the private key text input
    
    [timer invalidate];
    timer = nil;
    
    [keep_update_check setState:0];
    [timer_on_status_menu setState:0];
    [timer_off_status_menu setState:1];
    lastupdate_label_menu.title = [NSString stringWithFormat:NSLocalizedString(@"No update required",nil)];
    
  }

- (void)enable_stuff_because_logged{
    // disable all the menu items
    // NSLog(@"ENABLE STUFF");
    [international_pre_menu setHidden:FALSE];
    [updates_pre_menu  setHidden:FALSE];
    [update_now_menu_button setHidden:FALSE]; // works only with hidden, not enable
    [update_button setEnabled:TRUE];
    [timer_menu setHidden:FALSE];
    [menu_bar_logged_info setHidden:FALSE];
    [lastupdate_label_menu setHidden:FALSE];
    status_image.image = [NSImage imageNamed:@"green_icon.png"];
    respose_label.stringValue = NSLocalizedString(@"Ready",nil);
   lastupdate_label_menu.title = [NSString stringWithFormat:NSLocalizedString(@"No update required",nil)];
}

-(void)download_newversion_process{
    
    if([free_update isEqualToString:@"YES"]) // free update
    {
        
        // the URL to save
        NSURL *yourURL = [NSURL URLWithString:newversion_link];
        // turn it into a request and use NSData to load its content
        NSURLRequest *request = [NSURLRequest requestWithURL:yourURL];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        // find Downloads directory and append your local filename
        NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDownloadsDirectory inDomains:NSUserDomainMask] lastObject];
        documentsURL = [documentsURL URLByAppendingPathComponent:@"unlo.zip"];
        
        
        // and finally save the file
        [data writeToURL:documentsURL atomically:YES];
        
        NSAlert* msgBox = [[NSAlert alloc] init];
        [msgBox setMessageText:NSLocalizedString(@"Download completed. You will find the new version in your 'Downloads' folder.",nil)];
        [msgBox addButtonWithTitle: @"OK"];
        [msgBox runModal];
        
        [download_version_progressbar setHidden:false];
        [download_version_progressbar stopAnimation:0];
        
        [newversion_popup_window  makeKeyAndOrderFront:nil];
        [newversion_popup_window orderOut:nil];
        
    }
    else{
        
        NSURL*url=[NSURL URLWithString:marcodalprato_button_link];
        [[NSWorkspace sharedWorkspace] openURL:url];
        
        [newversion_popup_window  makeKeyAndOrderFront:nil];
        [newversion_popup_window orderOut:nil];
        
    }
    
}

-(void)macro_settings_loading_function{
    
    // creation of the menu with the macro list
    
    [macro_pre_menu setHidden:FALSE];
    
    macro_filepath = [[NSBundle mainBundle] pathForResource:@"macro" ofType:@"plist"];
    
    macro_settings = [NSMutableDictionary dictionaryWithContentsOfFile:macro_filepath];
    macro_list = [macro_settings valueForKeyPath:@"medialist"];
 
    NSArray * list = [macro_list allKeys];
    
  
    for (int a = 0 ; a < [list count]; a++) {
        
        NSView * backview =[[NSView alloc] initWithFrame:CGRectMake(0,0 ,200, 100)];
        
        NSString * Name = list[a];
        NSString * International = [macro_list valueForKeyPath:[NSString stringWithFormat:@"%@.International",Name]];
        //  NSString * Kind  = [macro_list valueForKeyPath:[NSString stringWithFormat:@"%@.Kind",Name]];
        NSString * Logo  = [macro_list valueForKeyPath:[NSString stringWithFormat:@"%@.Logo",Name]];
        NSString * Service  = [macro_list valueForKeyPath:[NSString stringWithFormat:@"%@.Service",Name]];
       
        
        NSMenuItem *menuitem = [[NSMenuItem alloc] init];
        NSImageView *subview = [[NSImageView alloc] initWithFrame:CGRectMake(15,0 ,60, 90)];
 
        NSImage* newImage;
        NSData *imageData;
     
        
        // if the logo string contais http the app tries to load the image, otherwise, if the logo string doesn't contais http it tries to load the local image
        
        if ([Logo rangeOfString:@"http://"].location == NSNotFound) {
           // local resource
            
            newImage = [[NSImage alloc]initWithContentsOfFile:Logo];

          
        }else{
        
        // remote resource
        
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Logo]];
            newImage = [[NSImage alloc] initWithData:imageData];
          
            // check integrity of the file
            
            if (imageData != nil) {
                newImage = [[NSImage alloc] initWithData:imageData];
                // thumb size
                [newImage setSize: NSMakeSize(100,140)];
            }else{
                newImage = [NSImage imageNamed:@"app-icon.png"];
                // thumb size
                [newImage setSize:NSMakeSize(100,140)];
                
            }
        }
        
        [newImage setSize: NSMakeSize(100,140)];
        [subview setImage:newImage];
        [subview setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
        [subview setTag:a];
  
        // Write the text for the curret media
        
        NSTextField * textField = [[NSTextField alloc] initWithFrame:NSMakeRect(80, 60,95, 30)];
       
        [textField setStringValue:[NSString stringWithFormat:@"%@\n(%@ - %@)",Name,Service, International]];
        [textField setFont:[NSFont fontWithName:@"HelveticaNeue-Light" size:10]];
        [textField setTextColor:[NSColor whiteColor]];
        [textField setBezeled:NO];
        [textField setDrawsBackground:NO];
        [textField setBackgroundColor:RGB(192, 192, 192)];
        [textField setEditable:NO];
        [textField setSelectable:NO];
        [textField setTag:a];
        
        // Set the region for the current media
        
        NSButton * set_region = [[NSButton alloc] initWithFrame:NSMakeRect(80,30,95, 30)];
        
        [set_region setTitle: NSLocalizedString(@"Set language",nil)];
        [set_region setFont:[NSFont fontWithName:@"HelveticaNeue-Light" size:10]];
        [set_region setButtonType: NSMomentaryPushInButton];
        [set_region setBezelStyle: NSRoundedBezelStyle];
        [set_region setBordered: YES];
        [set_region setTarget: self];
        [set_region setTag:a];
        [set_region setAction: @selector(set_region_from_macro:)];
        [set_region setEnabled:TRUE];
        
        // Open the link for the current media
        
        NSButton * open_link = [[NSButton alloc] initWithFrame:NSMakeRect(80,5,95, 30)];
        
        [open_link setTitle: NSLocalizedString(@"Play",nil)];
        [open_link setFont:[NSFont fontWithName:@"HelveticaNeue-Light" size:10]];
        [open_link setButtonType: NSMomentaryPushInButton];
        [open_link setBezelStyle: NSRoundedBezelStyle];
        [open_link setBordered: YES];
        [open_link setTarget: self];
        [open_link setTag:a];
        [open_link setAction: @selector(open_link_from_macro:)];
        [open_link setEnabled:TRUE];

        
        [backview addSubview:open_link];
        [backview addSubview:set_region];
        [backview addSubview:textField];
        [backview addSubview:subview];
        [menuitem setView:backview];
        
        [macro_menubar addItem:menuitem ];
        
          //( CGFloat x, CGFloat y, CGFloat w, CGFloat h );
        
    }
    

}

-(void)set_region_from_macro:(id)sender{

    // open the  link
    
    NSButton *clicked = (NSButton *) sender;
    int myInt = (int)clicked.tag;
    
    // Get the link from the array
    
    NSArray * list = [[macro_settings valueForKeyPath:@"medialist"] allKeys];
    NSString * International = [macro_list valueForKeyPath:[NSString stringWithFormat:@"%@.International",list[myInt]]];
    NSString * Service  = [macro_list valueForKeyPath:[NSString stringWithFormat:@"%@.Service",list[myInt]]];
    
    
    // set the international option
    
   

 [self function_change_international:International:Service];
    

    
}

-(void)open_link_from_macro:(id)sender{
    
    // open the  link

    NSButton *clicked = (NSButton *) sender;
    int myInt = (int)clicked.tag;

    // Get the link from the array
    
    NSArray * list = [[macro_settings valueForKeyPath:@"medialist"] allKeys];
    NSString * Link = [macro_list valueForKeyPath:[NSString stringWithFormat:@"%@.Link", list[myInt]]];

    // Open the URL
    
    NSURL*url=[NSURL URLWithString:Link];
    [[NSWorkspace sharedWorkspace] openURL:url];
    
    
    NSLog(@"myInt = %i",myInt);
    
}

// ACTIONS **********************************************************************************************************************************************************


- (IBAction)update_now:(id)sender {
    [status_image setHidden:TRUE];
    
    
    [update_spinner setHidden:FALSE];
    [update_spinner startAnimation:0];
    
    // [self save_function];
    
    // save all the settings
   // [NSThread detachNewThreadSelector:@selector(save_function) toTarget:self withObject:nil];
    
    // call a remote update using another thread
    [NSThread detachNewThreadSelector:@selector(update_fuction) toTarget:self withObject:nil];
    
} // force update

- (IBAction)change_interval_combobox_action:(id)sender {
    
    // interval combobox has been updated.
    // save the settings
    
    [self save_function];
}

- (IBAction)check_for_updates_checkbox:(id)sender {
    
    // save settings
    [self save_function];
}

- (IBAction)help_button:(id)sender {
  
 // [[NSWorkspace sharedWorkspace] openFile:@"manual_v80_r_10.pdf"];
    
    // Open the manual
    NSString* path = [[NSBundle mainBundle] pathForResource:@"manual_v80_r_10" ofType:@"pdf" ];
   [[NSWorkspace sharedWorkspace] openFile:path];
}

- (IBAction)open_manual:(id)sender {
    
    // Open the manual
    NSString* path = [[NSBundle mainBundle] pathForResource:@"manual_v80_r_10" ofType:@"pdf" ];
    [[NSWorkspace sharedWorkspace] openFile:path];
}

- (IBAction)donot_show_newversion:(id)sender {
    
    if(check_for_updates.state == 1){
    
    [check_for_updates setState:0];
    }
   
    
    
    [self save_function];
}

- (IBAction)menuAction:(id)sender {
    
    // force the focus of the window
    /*
    [self.window setLevel: NSNormalWindowLevel];
    [self.window makeKeyAndOrderFront:self];
	*/
	
	[window makeKeyAndOrderFront:self];
	[NSApp activateIgnoringOtherApps:YES];
	
}

- (IBAction)timer_on_menu:(id)sender {
    
    [keep_update_check setStringValue:@"1"];
    [self save_function];
}

- (IBAction)timer_off_menu:(id)sender {
    
    
    [keep_update_check setStringValue:@"0"];
    [self save_function];
}

- (IBAction)select_international_service:(id)sender { // when someone select a service from list
    
    [self international_menu_changed];
    
}

- (IBAction)show_private_key:(id)sender {
    
    NSString * private_key_msg = [NSString stringWithFormat:@"Here you are ! \nThis is your private key: \n%@", private_key_text.stringValue];
    
    NSAlert* msgBox = [[NSAlert alloc] init];
    [msgBox setMessageText:private_key_msg];
    [msgBox addButtonWithTitle: @"OK"];
    [msgBox runModal];
    
    
}

- (IBAction)reset_settings_btn:(id)sender {
    
    // reset all settings
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
	
	
	NSAlert* msgBox = [[NSAlert alloc] init];
	[msgBox setMessageText:NSLocalizedString(@"To reset all the settings, the application must be reloaded.",nil)];
	[msgBox addButtonWithTitle: @"OK"];
	[msgBox runModal];
	
    
    
    
   

}

- (IBAction)logout_btn:(id)sender {
    

    [self logout];
    
    
}

- (IBAction)save_privatekey_window:(id)sender {
    
    
    if([private_key_text.stringValue isEqualToString:@""]){
    
        NSAlert* msgBox = [[NSAlert alloc] init];
        [msgBox setMessageText:@"The private Key cannot be empty"];
        [msgBox addButtonWithTitle: @"OK"];
        [msgBox runModal];
        
        
        return;

    
    }
    else{
        
        // convert the string into a array of lines
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [settings_tab selectTabViewItemAtIndex:1];
        
        [defaults setObject:@"yes" forKey:@"logged_saved"]; // saving the private key
        logged_saved           = [[NSUserDefaults standardUserDefaults] objectForKey:@"logged_saved"];
        
        
        logout_btn.title = [NSString stringWithFormat:@"Go back to Login"];
         [menu_bar_logged_info setHidden:TRUE];
        
        [self save_function];
     
       
        [api_key_wizard_window close];
        
        // disable all the menu items
        // NSLog(@"ENABLE STUFF");
        [international_pre_menu setHidden:FALSE];
        [updates_pre_menu  setHidden:FALSE];
        [update_now_menu_button setHidden:FALSE]; // works only with hidden, not enable
        [update_button setEnabled:TRUE];
        [timer_menu setHidden:FALSE];
        [menu_bar_logged_info setHidden:TRUE];
        [lastupdate_label_menu setHidden:FALSE];
        status_image.image = [NSImage imageNamed:@"green_icon.png"];
        respose_label.stringValue = NSLocalizedString(@"Ready",nil);

        menu_bar_logged_info.title = [NSString stringWithFormat:NSLocalizedString(@"Signed in with the private key",nil)];
        
        
    }
    
}

- (IBAction)notify_me_btn:(id)sender {
    
    [self save_function];
    
}

- (IBAction)notify_something_wrong:(id)sender {
    
    [self save_function];
    
}

- (IBAction)notify_connection_problems_action:(id)sender {
    
    [self save_function];
    
}

- (IBAction)check_for_updates:(id)sender {
    
 // check updates
    
    if(need_update == 0){
    // already the latest version

    [NSThread detachNewThreadSelector:@selector(check_new_versions_function) toTarget:self withObject:nil];
 
        
    }
    
    // update required
    else{
    
        [newversion_popup_window makeKeyAndOrderFront:self];
        [NSApp activateIgnoringOtherApps:YES];
        
    }
    
}

- (IBAction)enable_updates_btn:(id)sender {
    
     [self save_function];

}

- (IBAction)register_account_unlocator:(id)sender {
    
    // load unlocator link
    
    NSURL*url=[NSURL URLWithString:unlocator_register_link];
    [[NSWorkspace sharedWorkspace] openURL:url];
    
}

- (IBAction)home_link_pressed:(id)sender {
    
    NSURL*url=[NSURL URLWithString:marcodalprato_home_link];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)login_btn:(id)sender {
    
    [login_progressbar setHidden:FALSE];
    
    
    [timer_interval_combobox selectItemAtIndex:0];
    
    [NSThread detachNewThreadSelector:@selector(login_function) toTarget:self withObject:nil];
    
  
    
}

- (IBAction)check_update_on_load_action:(id)sender {
   
    [self save_function];

}

- (IBAction)configure_app_firsttime_btn:(id)sender {
	
	[settings_window  makeKeyAndOrderFront:nil];
	[help_window orderOut:nil];
	
}

- (IBAction)region_change_combobox:(id)sender {
    
    
    [NSThread detachNewThreadSelector:@selector(change_regions) toTarget:self withObject:nil];
    
}

- (IBAction)download_new_version_btn:(id)sender {
    
    [download_version_progressbar setHidden:false];
    [download_version_progressbar startAnimation:0];
    
    [NSThread detachNewThreadSelector:@selector(download_newversion_process) toTarget:self withObject:nil];
}

- (IBAction)skip_version_btn:(id)sender {
    
    [newversion_popup_window  makeKeyAndOrderFront:nil];
    [newversion_popup_window orderOut:nil];
}


@end
