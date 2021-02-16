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

float get_cpu_temp()
{
    SMCWrapper *smc = [SMCWrapper sharedWrapper];
    NSNumber *temp;
    if ( [smc readKey:"TC0P" intoNumber:&temp] ){
       return [temp floatValue];
    }
    else return 0.0f;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [NSApp setActivationPolicy: NSApplicationActivationPolicyProhibited];
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // The text that will be shown in the menu bar
    [self update_temp];
    
    [self performSelector:@selector(mainthread_dotask) withObject:nil afterDelay:DELAY_T];
    
}

- (void) mainthread_dotask
{
    [self update_temp];
    [self performSelector:@selector(mainthread_dotask) withObject:nil afterDelay:DELAY_T];
}

- (void) update_temp
{
    NSColor *tempColour = [NSColor textColor];
   
    float t = get_cpu_temp();
    
    if (t < TJ_MID)
    {
        tempColour = [NSColor greenColor];
    }
    if (t >= TJ_WARN1)
    {
        tempColour = [NSColor yellowColor];
    }
    if (t >= TJ_WARN2)
    {
        tempColour = [NSColor orangeColor];
    }
    if (t >= TJ_WARN3)
    {
        tempColour = [NSColor brownColor];
    }
    if (t >= TJ_MAX)
    {
        tempColour = [NSColor redColor];
    }

    
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObject:tempColour forKey:NSForegroundColorAttributeName];
    
    NSAttributedString* colouredTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°",get_cpu_temperature(0)] attributes:titleAttributes];

    _statusItem.button.attributedTitle = colouredTitle;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
