//
//  YBMKAddressItem.m
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YBMKAddressItem.h"
NSString *const kZKAddressItemKey = @"key";
NSString *const kZKAddressItemCity = @"city";

@interface YBMKAddressItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end


@implementation YBMKAddressItem

@synthesize key = _key;
@synthesize city = _city;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.key = [self objectOrNilForKey:kZKAddressItemKey fromDictionary:dict];
        self.city = [self objectOrNilForKey:kZKAddressItemCity fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.key forKey:kZKAddressItemKey];
    [mutableDict setValue:self.city forKey:kZKAddressItemCity];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.key = [aDecoder decodeObjectForKey:kZKAddressItemKey];
    self.city = [aDecoder decodeObjectForKey:kZKAddressItemCity];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_key forKey:kZKAddressItemKey];
    [aCoder encodeObject:_city forKey:kZKAddressItemCity];
}

- (id)copyWithZone:(NSZone *)zone {
    YBMKAddressItem *copy = [[YBMKAddressItem alloc] init];
    
    
    
    if (copy) {
        
        copy.key = [self.key copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
    }
    
    return copy;
}


@end
