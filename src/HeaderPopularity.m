/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "HeaderPopularity.h"

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
