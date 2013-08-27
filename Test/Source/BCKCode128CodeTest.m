//
//  BCKCode128CodeTest.m
//  BarCodeKit
//
//  Created by Jaanus Siim on 8/25/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "BCKCode128Code.h"

@interface BCKCode128Code () // private

- (NSString *)bitString;

@end

@interface BCKCode128CodeTest : SenTestCase

@end

@implementation BCKCode128CodeTest

- (void)testEncodingOneCharacter
{
    BCKCode128Code *code = [[BCKCode128Code alloc] initWithContent:@"J"];
    NSString *expected = @"11010000100 10110111000 10110111000 1100011101011";
    expected = [expected stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *actual = [code bitString];
    BOOL isEqual = [expected isEqualToString:actual];
    STAssertTrue(isEqual, @"Result from encoding incorrect");
}

- (void)testEncodingWikipedia
{
    BCKCode128Code *code = [[BCKCode128Code alloc] initWithContent:@"Wikipedia"];
    NSString *expected = @"11010010000111010001101000011010011000010010100001101001010011110010110010000100001001101000011010010010110000111100100101100011101011";
    NSString *actual = [code bitString];
    BOOL isEqual = [expected isEqualToString:actual];

    STAssertTrue(isEqual, @"Result from encoding incorrect");
}

- (void)testAppleStoreCodeEncoding
{
    BCKCode128Code *code = [[BCKCode128Code alloc] initWithContent:@"CAM395A"];
    NSString *expected = @"1101000010010001000110101000110001011101100011001011100111001011001101110010010100011000100001101001100011101011";
    NSString *actual = [code bitString];
    BOOL isEqual = [expected isEqualToString:actual];

    STAssertTrue(isEqual, @"Result from encoding incorrect");
}

- (void)testSymbolsEncoding
{
    BCKCode128Code *code = [[BCKCode128Code alloc] initWithContent:@"'&%$#\"! ~_|}"];
    NSString *expected = @"11010010000100110001001001100100010001001100100100011001001001100011001100110110011011001101100110010001011110101001100001010111100010100011110100111101001100011101011";
    NSString *actual = [code bitString];
    BOOL isEqual = [expected isEqualToString:actual];

    STAssertTrue(isEqual, @"Result from encoding incorrect");
}

@end
