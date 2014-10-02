//
//  NSString+HTML.m
//  WashingtonPostCodeTest
//
//  Created by Yi Wang on 10/1/14.
//  Copyright (c) 2014 YI. All rights reserved.
//

#import "NSString+HTML.h"

@implementation NSString (HTML)

-(NSString *)stripMarkUp {
    
    // &#8216;
    // &#8217;
    NSMutableString *returnVal = [self mutableCopy];
    
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\&.+?\\;"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:NULL];
    
    [regex replaceMatchesInString:returnVal
                          options:0
                            range:NSMakeRange(0, [returnVal length])
                     withTemplate:@""];
    
    
    return returnVal;
}

@end
