//
//  ZooThreadSafeMutableDictionary.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooThreadSafeMutableDictionary<KeyType, ObjectType> : NSMutableDictionary

- (instancetype)init;
- (instancetype)initWithCapacity:(NSUInteger)numItems;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

- (NSUInteger)count;
- (id)objectForKey:(id)key;
- (id)objectForKeyedSubscript:(id)key;
- (NSEnumerator *)keyEnumerator;
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (NSArray *)allKeys;
- (NSArray *)allValues;
- (void)removeObjectForKey:(id)aKey;
- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
