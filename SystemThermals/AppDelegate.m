//
//  AppDelegate.m
//  SystemThermals
//
//  Created by Amit Apollo Barman on 2/16/21.
//

#import "AppDelegate.h"
#import "SMCWrapper.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


NSString *get_cpu_temperature(int core_number)
{
    SMCWrapper *smc = [SMCWrapper sharedWrapper];
    NSNumber *temp;
    if ( [smc readKey:"TC0P" intoNumber:&temp] ){
       return (void)(@"%@°"),[temp stringValue];
    }
    else return @"0°";
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // The text that will be shown in the menu bar
    [self update_temp];
    
    [self performSelector:@selector(mainthread_dotask) withObject:nil afterDelay:DELAY];
}

- (void) mainthread_dotask
{
    [self update_temp];
    [self performSelector:@selector(mainthread_dotask) withObject:nil afterDelay:DELAY];
}

- (void) update_temp
{
    _statusItem.button.title = [NSString stringWithFormat:@"%@°",get_cpu_temperature(0)];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
