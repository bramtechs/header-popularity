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
{
    BOOL _verbose;
    NSMutableArray<NSString *> *_sourceFileExtensions;
}

@property(nonatomic, assign) BOOL verbose;
@property(nonnull, nonatomic, strong) NSMutableArray<NSString *> *sourceFileExtensions;

- (instancetype)init;

@end

@implementation HeaderPopularity

@synthesize verbose = _verbose;
@synthesize sourceFileExtensions = _sourceFileExtensions;

- (nonnull instancetype)init
{
    self = [super init];
    if (self)
    {
        self.verbose = NO;
        self.sourceFileExtensions = [NSMutableArray arrayWithCapacity:32];
        [self.sourceFileExtensions addObjectsFromArray:@[ @"cc", @"c", @"cpp", @"cxx", @"m", @"mm" ]];
    }
    return self;
}

- (void)processFile:(NSString *)filePath
{
    if (![self hasSourceExtension:filePath])
        return;

    if (self.verbose)
        NSLog(@">>> %@", filePath);
}

- (BOOL)hasSourceExtension:(NSString *)filePath
{
    for (NSString *ext in self.sourceFileExtensions)
    {
        NSString *extWithDot;
        if ([ext hasPrefix:@"."])
            extWithDot = ext;
        else
            extWithDot = [NSString stringWithFormat:@".%@", ext];

        if ([filePath hasSuffix:extWithDot])
            return YES;
    }
    return NO;
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
    }
    return EXIT_SUCCESS;
}
