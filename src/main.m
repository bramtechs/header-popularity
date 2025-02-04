/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "HeaderPopularity.h"
#import "ResultPrinter.h"
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

        let printFlames = YES;
        let pop = [[HeaderPopularity alloc] init];
        NSMutableArray<NSString *> *sourceDirs = [NSMutableArray<NSString *> arrayWithCapacity:32];

        for (int i = 1; i < argc; i++)
        {
            if (strcmp(argv[i], "--verbose") == 0)
            {
                [pop setVerbose:YES];
                NSLog(@"Enabled verbose output");
            }
            else if (strcmp(argv[i], "--no-flames") == 0)
            {
                printFlames = NO;
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
        let printer = [[ResultPrinter alloc] init:results];
        [printer setPrintFlames:printFlames];
        [printer print];

        if (pop.verbose)
            NSLog(@"Done!");
    }
    return EXIT_SUCCESS;
}
