/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import <Foundation/Foundation.h>

@interface ResultPrinter : NSObject
{
    BOOL _printFlames;
    NSMutableDictionary<NSString *, NSNumber *> *_entries;
}

@property(nonnull, nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *entries;
@property BOOL printFlames;

- (nonnull instancetype)init:(nonnull NSMutableDictionary<NSString *, NSNumber *> *)entries;

- (void)print;

@end
