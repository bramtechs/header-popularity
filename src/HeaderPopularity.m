/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "HeaderPopularity.h"
#include "Foundation/NSCharacterSet.h"
#include "Foundation/NSObjCRuntime.h"

@implementation HeaderPopularity

@synthesize verbose = _verbose;
@synthesize sourceFileExtensions = _sourceFileExtensions;
@synthesize uniqueSourceFiles = _uniqueSourceFiles;

- (nonnull instancetype)init
{
    self = [super init];
    if (self)
    {
        self.verbose = NO;
        self.uniqueSourceFiles = [NSMutableSet<NSString *> setWithCapacity:128];
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

    [self.uniqueSourceFiles addObject:filePath];
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

- (BOOL)lineContainsInclude:(NSString *)line
{
    let searches = @[ @"#include", @"#import" ];
    for (NSString *term in searches)
    {
        if ([line containsString:term])
        {
            return YES;
        }
    }
    return NO;
}

- (NSString *)determineHeaderFromIncludeLine:(NSString *)line
{
    NSCharacterSet *startSet = [NSCharacterSet characterSetWithCharactersInString:@"<\""];
    NSRange start = [line rangeOfCharacterFromSet:startSet];
    if (start.location == NSNotFound)
        return nil;

    NSCharacterSet *endSet = [NSCharacterSet characterSetWithCharactersInString:@">\""];
    NSRange end = [line rangeOfCharacterFromSet:endSet
                                        options:0
                                          range:NSMakeRange(start.location + 1, line.length - start.location - 1)];
    if (end.location == NSNotFound)
        return nil;

    if (end.location <= start.location + 1) // Ensure there's something between the delimiters
        return nil;

    NSRange headerRange = NSMakeRange(start.location + 1, end.location - start.location - 1);
    NSString *headerPath = [line substringWithRange:headerRange];

    // assuming all headers have unique file names...
    return [headerPath lastPathComponent];
}

- (void)countIncludesOfFile:(NSString *)path total:(nonnull NSMutableDictionary<NSString *, NSNumber *> *)total
{
    @autoreleasepool
    {
        NSError *error = nil;
        NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (fileContents == nil || error != nil)
        {
            NSLog(@"Failed to read file %@", path);
            if (error != nil)
                NSLog(@"error: %@", error.localizedDescription);
            return;
        }

        let lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (long lineNumber = 0; lineNumber < [lines count]; ++lineNumber)
        {
            NSString *line = [lines objectAtIndex:lineNumber];

            if (![self lineContainsInclude:line])
                continue;

            let file = [self determineHeaderFromIncludeLine:line];
            if (file == nil)
            {
                NSLog(@"%@:%ld Failed to determine file from include line '%@'", path, lineNumber, line);
                continue;
            }

            if (self.verbose)
                NSLog(@"Found reference to header '%@'", file);

            NSNumber *curValue = [total objectForKey:file];
            if (curValue)
                [total setValue:@(curValue.integerValue + 1) forKey:file];
            else
                [total setValue:@1 forKey:file];
        }
    }
}

- (NSMutableDictionary<NSString *, NSNumber *> *)countIncludes
{
    let totalIncludes = [NSMutableDictionary<NSString *, NSNumber *> dictionaryWithCapacity:32];
    for (NSString *sourceFile in self.uniqueSourceFiles)
    {
        [self countIncludesOfFile:sourceFile total:totalIncludes];
    }

    return totalIncludes;
}

@end
