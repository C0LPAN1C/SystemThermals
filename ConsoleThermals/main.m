//
//  main.m
//  SystemThermals
//
//  Created by Apollo SOFTWARE on 2/1/21.
//

#import <Foundation/Foundation.h>
#import "SMCWrapper.h"

NSString *get_cpu_temperature(int core_number)
{
    SMCWrapper *smc = [SMCWrapper sharedWrapper];
    NSNumber *temp;
    if ( [smc readKey:"TC0P" intoNumber:&temp] ){
       return (void)(@"%@"),[temp stringValue];
    }
    else return @"0";
}

int main(int argc, const char * argv[]) {
    NSLog(@"%@°", get_cpu_temperature(0));
    
    return 0;
}


