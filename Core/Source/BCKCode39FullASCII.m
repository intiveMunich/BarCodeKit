//
//  BCKCode39FullASCII.m
//  BarCodeKit
//
//  Created by Geoff Breemer on 03/09/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "BCKCode39FullASCII.h"
#import "BCKCode39CodeCharacter.h"

@implementation BCKCode39FullASCII

- (instancetype)initWithContent:(NSString *)content
{
	self = [super init];
	
	if (self)
	{
		_content = [content copy];
	}
	
	return self;
}

#pragma mark Helper Methods

// source: http://en.wikipedia.org/wiki/Code_39

+ (NSString *)fullASCIIEncoding:(NSString *)character
{
	NSDictionary *encodingDictionary = @{
													 @"␀": @"%U",
													 @"␁": @"$A",
													 @"␂": @"$B",
													 @"␃": @"$C",
													 @"␄": @"$D",
													 @"␅": @"$E",
													 @"␆": @"$F",
													 @"␇": @"$G",
													 @"␈": @"$H",
													 @"␉": @"$I",
													 @"␊": @"$J",
													 @"␋": @"$K",
													 @"␌": @"$L",
													 @"␍": @"$M",
													 @"␎": @"$N",
													 @"␏": @"$O",
													 @"␐": @"$P",
													 @"␑": @"$Q",
													 @"␒": @"$R",
													 @"␓": @"$S",
													 @"␔": @"$T",
													 @"␕": @"$U",
													 @"␖": @"$V",
													 @"␗": @"$W",
													 @"␘": @"$X",
													 @"␙": @"$Y",
													 @"␚": @"$Z",
													 @"␛": @"%A",
													 @"␜": @"%B",
													 @"␝": @"%C",
													 @"␞": @"%D",
													 @"␟": @"%E",
													 @" ": @" ",
													 @"!": @"/A",
													 @"\"": @"/B",
													 @"#": @"/C",
													 @"$": @"/D",
													 @"%": @"/E",
													 @"&": @"/F",
													 @"'": @"/G",
													 @"(": @"/H",
													 @")": @"/I",
													 @"*": @"/J",
													 @"+": @"/K",
													 @",": @"/L",
													 @"-": @"-",
													 @".": @".",
													 @"/": @"/O",
													 @"0": @"0",
													 @"1": @"1",
													 @"2": @"2",
													 @"3": @"3",
													 @"4": @"4",
													 @"5": @"5",
													 @"6": @"6",
													 @"7": @"7",
													 @"8": @"8",
													 @"9": @"9",
													 @":": @"/Z",
													 @";": @"%)F",
													 @"<": @"%)G",
													 @"=": @"%)H",
													 @">": @"%)I",
													 @"?": @"%)J",
													 @"@": @"%)V",
													 @"A": @"A",
													 @"B": @"B",
													 @"C": @"C",
													 @"D": @"D",
													 @"E": @"E",
													 @"F": @"F",
													 @"G": @"G",
													 @"H": @"H",
													 @"I": @"I",
													 @"J": @"J",
													 @"K": @"K",
													 @"L": @"L",
													 @"M": @"M",
													 @"N": @"N",
													 @"O": @"O",
													 @"P": @"P",
													 @"Q": @"Q",
													 @"R": @"R",
													 @"S": @"S",
													 @"T": @"T",
													 @"U": @"U",
													 @"V": @"V",
													 @"W": @"W",
													 @"X": @"X",
													 @"Y": @"Y",
													 @"Z": @"Z",
													 @"[": @"%K",
													 @"\\": @"%L",
													 @"]": @"%M",
													 @"^": @"%N",
													 @"_": @"%O",
													 @"`": @"%W",
													 @"a": @"+A",
													 @"b": @"+B",
													 @"c": @"+C",
													 @"d": @"+D",
													 @"e": @"+E",
													 @"f": @"+F",
													 @"g": @"+G",
													 @"h": @"+H",
													 @"i": @"+I",
													 @"j": @"+J",
													 @"k": @"+K",
													 @"l": @"+L",
													 @"m": @"+M",
													 @"n": @"+N",
													 @"o": @"+O",
													 @"p": @"+P",
													 @"q": @"+Q",
													 @"r": @"+R",
													 @"s": @"+S",
													 @"t": @"+T",
													 @"u": @"+U",
													 @"v": @"+V",
													 @"w": @"+W",
													 @"x": @"+X",
													 @"y": @"+Y",
													 @"z": @"+Z",
													 @"{": @"%P",
													 @"|": @"%Q",
													 @"}": @"%R",
													 @"~": @"%S",
													 @"␡": @"%T",
													 @"␡": @"%X",
													 @"␡": @"%Y",
													 @"␡": @"%Z"
													 };
	
	return [encodingDictionary valueForKey:character];
}

#pragma mark - Subclass Methods

+ (NSString *)barcodeDescription
{
	return @"Code 39 Full ASCII";
}

- (NSArray *)codeCharacters
{
	// If the array was created earlier just return it
	if (_codeCharacters)
	{
		return _codeCharacters;
	}
   
	// Array that holds all code characters, including start/stop and any special characters required to represent any full ASCII characters included in the content
	NSMutableArray *finalArray = [NSMutableArray array];
	BCKCode39CodeCharacter *tmpCharacter = nil;
	
	// end marker
	[finalArray addObject:[BCKCode39CodeCharacter endMarkerCodeCharacter]];
	
	// Encode the barcode's content and add it to the array
	for (NSUInteger index=0; index<[_content length]; index++)
	{
		[finalArray addObject:[BCKCode39CodeCharacter spacingCodeCharacter]];
		
		NSString *character = [_content substringWithRange:NSMakeRange(index, 1)];
		NSString *characterEncoding = [BCKCode39FullASCII fullASCIIEncoding:character];
		
		if ([characterEncoding length]==1)
		{
			tmpCharacter = [BCKCode39CodeCharacter codeCharacterForCharacter:character];
			[finalArray addObject:tmpCharacter];
		}
		else
		{
			// Create the two ContentCodeCharacters and add to array
			tmpCharacter = [BCKCode39CodeCharacter codeCharacterForCharacter:[characterEncoding substringWithRange:NSMakeRange(0, 1)]];
			[finalArray addObject:tmpCharacter];
			
			[finalArray addObject:[BCKCode39CodeCharacter spacingCodeCharacter]];
			
			tmpCharacter = [BCKCode39CodeCharacter codeCharacterForCharacter:[characterEncoding substringWithRange:NSMakeRange(1, 1)]];
			[finalArray addObject:tmpCharacter];
		}
	}
	
	// space
	[finalArray addObject:[BCKCode39CodeCharacter spacingCodeCharacter]];
	
	// end marker
	[finalArray addObject:[BCKCode39CodeCharacter endMarkerCodeCharacter]];
	
	_codeCharacters = [finalArray copy];
	return _codeCharacters;
}

@end