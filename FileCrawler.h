/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import <Foundation/Foundation.h>

@interface FileCrawler : NSObject

- (void)crawlDirectory:(NSString *)path;

- (void)processFile:(NSString *)filePath;

@end
