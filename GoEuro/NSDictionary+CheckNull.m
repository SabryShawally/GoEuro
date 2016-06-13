//
//  NSDictionary+CheckNull.m
//  ShoppingList
//
//  Created by khaled el morabea on 12/16/14.
//  Copyright (c) 2014 ahmed zahran. All rights reserved.
//

#import "NSDictionary+CheckNull.h"
#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

@implementation NSDictionary (CheckNull)
-(id)CheckobjectForKey:(id)aKey
{
    if (NULL_TO_NIL([self objectForKey:aKey])==nil)
    {
        return nil;
    }
    else
    {
        return [self objectForKey:aKey];
    }
}

@end
