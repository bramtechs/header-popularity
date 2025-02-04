/*
 * Copyright (c) 2025. Doomhowl Interactive - bramtechs/brambasiel
 * MIT License. Absolutely no warranty.
 *
 * File created on: 04-02-2025
 */

#import "ResultPrinter.h"
#import "utils.h"

#import <math.h>

@implementation ResultPrinter

@synthesize printFlames = _printFlames;
@synthesize entries = _entries;

- (nonnull instancetype)init:(NSMutableDictionary<NSString *, NSNumber *> *)entries
{
    self = [super init];
    if (self)
    {
        self.printFlames = YES;
        self.entries = entries;
    }

    return self;
}

- (nonnull NSArray *)getKeysSortedByValue
{
    NSMutableArray *sortedKeys = [[self.entries allKeys] mutableCopy];
    for (NSUInteger i = 0; i < [sortedKeys count]; i++)
    {
        NSUInteger maxIndex = i;
        for (NSUInteger j = i + 1; j < [sortedKeys count]; j++)
        {
            if ([[self.entries objectForKey:[sortedKeys objectAtIndex:j]] integerValue] >
                [[self.entries objectForKey:[sortedKeys objectAtIndex:maxIndex]] integerValue])
            {
                maxIndex = j;
            }
        }
        if (maxIndex != i)
        {
            [sortedKeys exchangeObjectAtIndex:i withObjectAtIndex:maxIndex];
        }
    }

    return sortedKeys;
}

- (void)print
{
    int maxKeyLen = 0;
    int maxCount = 0;

    for (NSString *key in self.entries)
    {
        NSNumber *value = [self.entries objectForKey:key];
        maxKeyLen = fmax([key length], maxKeyLen);
        maxCount = fmax([value integerValue], maxCount);
    }

    for (NSString *key in [self getKeysSortedByValue])
    {
        char buffer[256];
        memset(buffer, ' ', sizeof(buffer));
        buffer[255] = '\0';

        const char *cKey = [key cString];
        int keyLen = strlen(cKey);
        memcpy(buffer, cKey, keyLen);

        buffer[maxKeyLen + 1] = '|';

        long valueCount = [[self.entries objectForKey:key] integerValue];
        sprintf(&buffer[maxKeyLen + 3], "%ld ", valueCount);

        if (self.printFlames)
        {
            int flames = (int)ceilf(fmax(0.f, valueCount / ((float)maxCount) - 0.5f) * 10.f);
            for (int j = 0; j < flames; ++j)
            {
                strcat(buffer, "🔥");
            }
        }

        printf("%s\n", buffer);
    }
}

@end
