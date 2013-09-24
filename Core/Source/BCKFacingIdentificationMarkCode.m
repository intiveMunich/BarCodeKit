//
//  BCKFacingIdentificationMarkCode.m
//  BarCodeKit
//
//  Created by Geoff Breemer on 24/09/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "BCKFacingIdentificationMarkCode.h"
#import "BCKFacingIdentificationMarkCodeCharacter.h"
#import "NSError+BCKCode.h"

@implementation BCKFacingIdentificationMarkCode
{
	BCKFacingIdentificationMarkTypes _fimType;
}

- (instancetype)initWithContent:(NSString *)content error:(NSError**)error
{
    return [self initWithFIMType:[content integerValue] error:error];
}

- (instancetype)initWithFIMType:(BCKFacingIdentificationMarkTypes)fimType error:(NSError *__autoreleasing *)error;
{
    if (fimType == BCKFIMTypeA ||
        fimType == BCKFIMTypeB ||
        fimType == BCKFIMTypeC ||
        fimType == BCKFIMTypeD ||
        fimType == BCKFIMTypeE)
    {
        self = [super initWithContent:@"" error:error];
        
        if (self)
        {
            _fimType = fimType;
        }
    }
    else
    {
        if (error)
        {
            NSString *message = [NSString stringWithFormat:@"%d is not a supported FIM type for %@", fimType, NSStringFromClass([self class])];
            *error = [NSError BCKCodeErrorWithMessage:message];
        }
        self = nil;
    }

    
	return self;
}

+ (NSString *)barcodeStandard
{
	return @"Not an international standard";
}

+ (NSString *)barcodeDescription
{
	return @"Facing Identification Mark";
}

+ (BOOL)canEncodeContent:(NSString *)content error:(NSError **)error
{
    return YES;
}

- (NSString *)captionTextForZone:(BCKCodeDrawingCaption)captionZone withRenderOptions:(NSDictionary *)options;
{
    return @"";
}

- (NSArray *)codeCharacters
{
	// If the array was created earlier just return it
	if (_codeCharacters)
	{
		return _codeCharacters;
	}
	
	NSMutableArray *tmpArray = [NSMutableArray array];

	// end marker
	[tmpArray addObject:[BCKFacingIdentificationMarkCodeCharacter facingIdentificationMarkCode:_fimType]];
	
	_codeCharacters = [tmpArray copy];
	return _codeCharacters;
}

@end
