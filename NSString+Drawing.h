//
//  NSString+Drawing.h
//  School
//
//  Created by Max Kramer on 29/10/2013.
//  Copyright (c) 2013 Max Kramer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Drawing)

- (float) heightWithFont:(UIFont *) font maxSize:(CGSize) maxSize andLinebreakMode:(NSLineBreakMode) linebreakMode;

@end
