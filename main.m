/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "utils.h"

#import <Foundation/Foundation.h>
#import <stdlib.h>

@interface FileCrawler : NSObject

- (void)processFile:(NSString *)filePath;

@end

@implementation FileCrawler

- (void)processFile:(NSString *)filePath
{
    @throw [NSException exceptionWithName:@"FileCrawlerException"
                                   reason:@"processFile: must be overridden"
                                 userInfo:nil];
}

@end

static void crawlFiles(NSString *path, FileCrawler *cb)
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
            crawlFiles(fullChild, cb);
        }
        else
        {
            [cb processFile:child];
        }
    }
}

@interface HeaderPopularity : FileCrawler
@end

@implementation HeaderPopularity

- (void)processFile:(NSString *)filePath
{
    NSLog(@">>> %@", filePath);
}

@end

int main(int argc, const char *argv[])
{
    @autoreleasepool
    {
        if (argc <= 1)
        {
            NSLog(@"No source folder passed!");
            return EXIT_FAILURE;
        }

        let pop = [[HeaderPopularity alloc] init];

        NSString *srcFolder = [NSString stringWithUTF8String:argv[argc - 1]];
        NSLog(@"Will check source folder %@", srcFolder);
        crawlFiles(srcFolder, pop);
    }
    return EXIT_SUCCESS;
}
