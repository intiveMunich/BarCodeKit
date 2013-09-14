//
//  BCKCodabarContentCodeCharacter.m
//  BarCodeKit
//
//  Created by Geoff Breemer on 14/09/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "BCKCodabarContentCodeCharacter.h"

#define NUMBER_OF_CODABAR_CHARACTERS 16
#define CHARACTER_DIMENSION 0
#define ENCODING_DIMENSION 1

// source: http://www.barcodeisland.com/codabar.phtml

static char *char_encodings[NUMBER_OF_CODABAR_CHARACTERS][2] = {
	{"0", "101010011"},
	{"1", "101011001"},
	{"2", "101001011"},
	{"3", "110010101"},
	{"4", "101101001"},
	{"5", "110101001"},
	{"6", "100101011"},
	{"7", "100101101"},
	{"8", "100110101"},
	{"9", "110100101"},
	{"-", "101001101"},
	{"$", "101100101"},
	{":", "1101011011"},
	{"/", "1101101011"},
	{".", "1101101101"},
    {"+", "1011011011"}};

@implementation BCKCodabarContentCodeCharacter
{
	NSString *_character;
}

- (instancetype)initWithCharacter:(NSString *)character
{
	self = [super init];
	
	if (self)
	{
		if (![self _encodingForCharacter:character])
		{
			return nil;
		}
		
		_character = [character copy];
	}
	
	return self;
}

- (char *)_encodingForCharacter:(NSString *)character
{
	char searchChar = [character UTF8String][0];
	
	for (NSUInteger i=0; i<NUMBER_OF_CODABAR_CHARACTERS; i++)
	{
		char testChar = char_encodings[i][CHARACTER_DIMENSION][0];
		
		if (testChar == searchChar)
		{
			return char_encodings[i][ENCODING_DIMENSION];
		}
	}
	
	return NULL;
}

- (NSString *)_bitsForEncoding:(char *)encoding
{
	NSMutableString *tmpString = [NSMutableString string];
	
	for (NSUInteger index=0; index<strlen(encoding); index++)
	{
		char c = encoding[index];
		
		switch (c)
		{
			case '1':
			{
				[tmpString appendString:@"1"];
				break;
			}
				
			case '0':
			{
				[tmpString appendString:@"0"];
				break;
			}
        }
	}
	
	return tmpString;
}

- (NSString *)bitString
{
	char *encoding = [self _encodingForCharacter:_character];
	
	if (!encoding)
	{
		return nil;
	}
	NSLog(@"bits for %@=%@", _character, [self _bitsForEncoding:encoding]);
	return [[self _bitsForEncoding:encoding] copy];
}

@end
