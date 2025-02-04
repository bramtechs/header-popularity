/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "FileCrawler.h"
#import "utils.h"

#import <Foundation/Foundation.h>
#import <stdlib.h>

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
        [pop crawlDirectory:srcFolder];
    }
    return EXIT_SUCCESS;
}
