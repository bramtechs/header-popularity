/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "FileCrawler.h"
#import "utils.h"

#import <Foundation/Foundation.h>

@interface HeaderPopularity : FileCrawler
{
    BOOL _verbose;
    NSMutableArray<NSString *> *_sourceFileExtensions;
}

@property(nonatomic, assign) BOOL verbose;
@property(nonnull, nonatomic, strong) NSMutableArray<NSString *> *sourceFileExtensions;

- (nonnull instancetype)init;

@end
