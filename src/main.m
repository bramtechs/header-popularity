/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "HeaderPopularity.h"
#import "utils.h"

#import <Foundation/Foundation.h>
#import <stdlib.h>

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
        NSMutableArray<NSString *> *sourceDirs = [NSMutableArray<NSString *> arrayWithCapacity:32];

        for (int i = 1; i < argc; i++)
        {
            if (strcmp(argv[i], "--verbose") == 0)
            {
                [pop setVerbose:YES];
                NSLog(@"Enabled verbose output");
            }
            else
            {
                NSString *dir = [NSString stringWithUTF8String:argv[i]];
                [sourceDirs addObject:dir];
            }
        }

        for (NSString *sourceDir in sourceDirs)
        {
            if (pop.verbose)
                NSLog(@"Will check source folder %@", sourceDir);

            [pop crawlDirectory:sourceDir];
        }

        let results = [pop countIncludes];
        for (NSString *key in results)
        {
            NSNumber *value = [results objectForKey:key];
            NSLog(@"%@ -> %@ references", key, value);
        }
    }
    return EXIT_SUCCESS;
}
