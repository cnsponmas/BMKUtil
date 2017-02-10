//
//  YBMKAddressItem.h
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBMKAddressItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *city;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
