//
//  AppDelegate.h
//  SystemThermals
//
//  Created by Amit Apollo Barman on 2/16/21.
//

#import <Cocoa/Cocoa.h>

#define DELAY_T     5.0
#define TJ_MID      50.0
#define TJ_WARN1    60.0
#define TJ_WARN2    70.0
#define TJ_WARN3    80.0
#define TJ_MAX      90.0

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (strong, nonatomic) NSStatusItem *statusItem;

@end

