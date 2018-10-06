//
//  UnlocatorUpdatedAppDelegate.h
//  Unlocator Updated
//
//  Created by Marco Dalprato on 02/06/14.
//  Copyright (c) 2015 Marco Dalprato. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>


@interface UnlocatorUpdatedAppDelegate : NSObject <NSApplicationDelegate, NSXMLParserDelegate>{
    @private
        NSXMLParser *xmlParser;
        NSInteger depth;
        NSMutableString *currentName;
        NSString *currentElement;
        NSMutableArray * unlocator_services_array ;
        NSMutableArray * unlocator_services_lang_array ;
        NSMutableArray * unlocator_services_index_array ;
    }

@property (nonatomic, retain) NSMutableArray *unlocator_services_array;
@property (nonatomic, retain) NSMutableArray *unlocator_services_lang_array;
@property (nonatomic, retain) NSMutableArray *unlocator_services_index_array;
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSProgressIndicator *login_progressbar;
@property (weak) IBOutlet NSMenu *International_menu_settings;
@property (weak) IBOutlet NSMenuItem *timer_on_status_menu;
@property (weak) IBOutlet NSMenuItem *timer_off_status_menu;
@property (weak) IBOutlet NSWindow *api_key_wizard_window;
@property (weak) IBOutlet NSTextField *private_key_text;
@property (weak) IBOutlet NSTextField *respose_label;
@property (weak) IBOutlet NSButton *keep_update_check;
@property (weak) IBOutlet NSButton *notify_only_if_changed;
@property (weak) IBOutlet NSButton *notify_if_something_wrong;
@property (weak) IBOutlet NSButton *notify_connection_problems;
@property (weak) IBOutlet NSMenuItem *updates_pre_menu;
@property (weak) IBOutlet NSMenuItem *update_now_menu_button;
@property (readwrite, retain) IBOutlet NSMenu *menu;
@property (readwrite, retain) IBOutlet NSStatusItem *statusItem;
@property (weak) IBOutlet NSComboBox *timer_interval_combobox;
@property (weak) IBOutlet NSMenuItem *lastupdate_label_menu;
@property (weak) IBOutlet NSMenuItem *respose_label_menu;
@property (weak) IBOutlet NSImageView *status_image;
@property (weak) IBOutlet NSComboBox *international_service_lang_list;
@property (weak) IBOutlet NSComboBox *international_service_name_list;
@property (weak) IBOutlet NSComboBox *select_international_service_title;
@property (weak) IBOutlet NSTabView *settings_tab;
@property (weak) IBOutlet NSButton *update_button;
@property (weak) IBOutlet NSButton *home_link_btn;
@property (weak) IBOutlet NSButton *check_update_on_load;
@property (weak) IBOutlet NSButton *logout_btn;
@property (weak) IBOutlet NSMenuItem *menu_bar_logged_info;
@property (weak) IBOutlet NSMenu *timer_interval_menu;
@property (weak) IBOutlet NSMenuItem *international_pre_menu;
@property (weak) IBOutlet NSMenuItem *prefereces_menu;
@property (weak) IBOutlet NSButton *preferecens_button;
@property (weak) IBOutlet NSMenuItem *timer_menu;
@property (weak) IBOutlet NSTextField *username_login;
@property (weak) IBOutlet NSSecureTextField *password_login;
@property (weak) IBOutlet NSMenuItem *check_updates_menuitem;
@property (weak) IBOutlet NSWindow *help_window;
@property (weak) IBOutlet NSWindow *settings_window;
@property (weak) IBOutlet NSTextField *Internationa_response_label;
@property (weak) IBOutlet NSProgressIndicator *update_spinner;
@property (weak) IBOutlet NSButton *check_for_updates;
@property (weak) IBOutlet NSWindow *newversion_popup_window;
@property (weak) IBOutlet NSTextField *newversion_infolabel;
@property (weak) IBOutlet NSProgressIndicator *download_version_progressbar;
@property (weak) IBOutlet NSButton *download_new_version_btn;
@property (weak) IBOutlet NSMenu *macro_menubar;
@property (weak) IBOutlet NSMenuItem *macro_pre_menu;

@property (unsafe_unretained) IBOutlet NSTextView *relesenotes_text;

- (IBAction)download_new_version_btn:(id)sender;
- (IBAction)skip_version_btn:(id)sender;

- (BOOL)windowShouldClose:(id)sender;
- (IBAction)check_update_on_load_action:(id)sender;
- (IBAction)login_btn:(id)sender;
- (IBAction)configure_app_firsttime_btn:(id)sender;
- (IBAction)region_change_combobox:(id)sender;
- (IBAction)update_now:(id)sender;
- (IBAction)menuAction:(id)sender;
- (IBAction)timer_on_menu:(id)sender;
- (IBAction)timer_off_menu:(id)sender;
- (IBAction)select_international_service:(id)sender;
- (IBAction)show_private_key:(id)sender;
- (IBAction)reset_settings_btn:(id)sender;
- (IBAction)logout_btn:(id)sender;
- (IBAction)save_privatekey_window:(id)sender;
- (IBAction)notify_me_btn:(id)sender;
- (IBAction)notify_something_wrong:(id)sender;
- (IBAction)notify_connection_problems_action:(id)sender;
- (IBAction)check_for_updates:(id)sender;
- (IBAction)enable_updates_btn:(id)sender;
- (IBAction)register_account_unlocator:(id)sender;
- (IBAction)home_link_pressed:(id)sender;
- (BOOL)connected;
- (IBAction)change_interval_combobox_action:(id)sender;
- (IBAction)check_for_updates_checkbox:(id)sender;
- (IBAction)help_button:(id)sender;
- (IBAction)open_manual:(id)sender;
- (IBAction)donot_show_newversion:(id)sender;


@end
