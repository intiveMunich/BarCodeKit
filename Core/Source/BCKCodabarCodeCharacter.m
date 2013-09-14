//
//  BCKCodabarCodeCharacter.m
//  BarCodeKit
//
//  Created by Geoff Breemer on 14/09/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "BCKCodabarCodeCharacter.h"
#import "BCKCodabarContentCodeCharacter.h"

#define NUMBER_OF_CODABAR_STARTSTOPCHARACTERS 8
#define CHARACTER_DIMENSION 0
#define ENCODING_DIMENSION 1

// source: http://www.barcodeisland.com/codabar.phtml

static char *char_encodings[NUMBER_OF_CODABAR_STARTSTOPCHARACTERS][2] = {
	{"A", "1011001001"},
	{"B", "1001001011"},
	{"C", "1010010011"},
	{"D", "1010011001"},
	{"T", "1010010011"},
    {"N", "1010010011"},
    {"*", "1010010011"},
    {"E", "1010010011"}};

@implementation BCKCodabarCodeCharacter

#pragma mark - Generating Special Characters

+ (BCKCodabarCodeCharacter *)startStopCodeCharacter:(NSString *)character
{
    char searchChar = [character UTF8String][0];
        
    for (NSUInteger i=0; i<NUMBER_OF_CODABAR_STARTSTOPCHARACTERS; i++)
    {
        char testChar = char_encodings[i][CHARACTER_DIMENSION][0];
        
        if (testChar == searchChar)
        {
            NSString *charString = [NSString stringWithUTF8String:char_encodings[i][ENCODING_DIMENSION]];

            return [[BCKCodabarCodeCharacter alloc] initWithBitString:charString isMarker:NO];
        }
    }
    
    return nil;
}

+ (BCKCodabarCodeCharacter *)spacingCodeCharacter
{
	return [[BCKCodabarCodeCharacter alloc] initWithBitString:@"0" isMarker:NO];
}

+ (BCKCodabarContentCodeCharacter *)codeCharacterForCharacter:(NSString *)character
{
	return [[BCKCodabarContentCodeCharacter alloc] initWithCharacter:character];
}

@end
