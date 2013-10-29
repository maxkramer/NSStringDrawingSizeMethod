//
//  NSString+Drawing.m
//  School
//
//  Created by Max Kramer on 29/10/2013.
//  Copyright (c) 2013 Max Kramer. All rights reserved.
//

#import "NSString+Drawing.h"
#import <objc/runtime.h>

static char SCTextStorageKey;
static char SCLayoutManagerKey;
static char SCTextContainerKey;

@implementation NSString (Drawing)


- (float) heightWithFont:(UIFont *)font maxSize:(CGSize)maxSize andLinebreakMode:(NSLineBreakMode)linebreakMode
{
    NSTextStorage *textStorage = objc_getAssociatedObject(self, &SCTextStorageKey);
    NSLayoutManager *layoutManager = objc_getAssociatedObject(self, &SCLayoutManagerKey);
    NSTextContainer *textContainer = objc_getAssociatedObject(self, &SCTextContainerKey);
    
    if (!textStorage) {
        textStorage = [[NSTextStorage alloc] initWithString:self attributes:@{NSFontAttributeName : font}];
        objc_setAssociatedObject(self, &SCTextStorageKey, textStorage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (!textContainer) {
        textContainer = [[NSTextContainer alloc] init];
        [textContainer setLineBreakMode:linebreakMode];
        [textContainer setLineFragmentPadding:0.0f];
        objc_setAssociatedObject(self, &SCTextContainerKey, textContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [textContainer setSize:maxSize];
    
    if (!layoutManager) {
        layoutManager = [[NSLayoutManager alloc] init];
        [layoutManager addTextContainer:textContainer];
        objc_setAssociatedObject(self, &SCLayoutManagerKey, layoutManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [textStorage addLayoutManager:layoutManager];
    
    CGRect rect = [layoutManager usedRectForTextContainer:textContainer];
    return rect.size.height;
}

@end
