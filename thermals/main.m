//
//  main.m
//  thermals
//
//  Created by Amit Apollo Barman on 2/1/21.
//

#import <Foundation/Foundation.h>
#import "SMCWrapper.h"

NSString *get_cpu_temperature(int core_number)
{
    SMCWrapper *smc = [SMCWrapper sharedWrapper];
    NSNumber *temp;
    if ( [smc readKey:"TC0D" intoNumber:&temp] ){
       return (void)(@"[%d] CPU Temperature:\t %@"), (void)(core_number), [temp stringValue];
    }
    else return @"CPU Temperature: UNKNOWN";
}

int main(int argc, const char * argv[]) {
    NSLog(@"%@", get_cpu_temperature(0));
    
    return 0;
}


