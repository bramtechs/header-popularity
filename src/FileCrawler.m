/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "FileCrawler.h"
#import "utils.h"

@implementation FileCrawler

- (void)crawlDirectory:(NSString *)path
{
    NSFileManager *fileMan = [NSFileManager defaultManager];

    NSError *error;
    let *children = [fileMan contentsOfDirectoryAtPath:path error:&error];
    if (children == nil)
    {
        @throw [NSException exceptionWithName:@"FileCrawlerException"
                                       reason:[NSString stringWithFormat:@"Failed to crawl directory %@: %@", path,
                                                                         error.localizedDescription]
                                     userInfo:nil];
    }

    for (NSString *child in children)
    {
        let fullChild = [NSString pathWithComponents:@[ path, child ]];
        BOOL isDirectory;
        if (![fileMan fileExistsAtPath:fullChild isDirectory:&isDirectory])
        {
            @throw [NSException exceptionWithName:@"FileCrawlerException"
                                           reason:[NSString stringWithFormat:@"File disappeared: %@", child]
                                         userInfo:nil];
        }

        if (isDirectory)
        {
            [self crawlDirectory:fullChild];
        }
        else
        {
            [self processFile:fullChild];
        }
    }
}

- (void)processFile:(NSString *)filePath
{
    @throw [NSException exceptionWithName:@"FileCrawlerException"
                                   reason:@"processFile: must be overridden"
                                 userInfo:nil];
}

@end
