/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import "BPKIconView.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKIconView ()

- (void)setUp;
@end

@implementation BPKIconView

- (instancetype)initWithIconName:(nullable BPKIconName)iconName {
    BPKAssertMainThread();
    CGSize displaySize = [BPKIcon concreteSizeForIconName:iconName];

    self = [super initWithFrame:CGRectMake(0, 0, displaySize.width, displaySize.height)];

    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        _iconName = [iconName copy];
        [self setUp];
    }

    return self;
}

- (void)setUp {
    if (self.iconName) {
        super.image = [BPKIcon templateIconNamed:self.iconName];
    }
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.tintColor = BPKColor.textPrimaryColor;
}

- (void)setIconName:(nullable BPKIconName)iconName {
    BPKAssertMainThread();
    if (![iconName isEqualToString:_iconName]) {
        _iconName = [iconName copy];

        if (iconName) {
            super.image = [self imageWithIconName:iconName flipsForRightToLeft:self.flipsForRightToLeft];
        } else {
            super.image = nil;
        }
    }
}

- (void)setFlipsForRightToLeft:(BOOL)flipsForRightToLeft {
    BPKAssertMainThread();
    if (flipsForRightToLeft != _flipsForRightToLeft) {
        _flipsForRightToLeft = flipsForRightToLeft;

        if (self.iconName) {
            super.image = [self imageWithIconName:self.iconName flipsForRightToLeft:flipsForRightToLeft];
        }
    }
}

- (UIImage *)imageWithIconName:(BPKIconName)iconName
           flipsForRightToLeft:(BOOL)flipsForRightToLeft {
    UIImage *image = [BPKIcon templateIconNamed:iconName];

    if (flipsForRightToLeft) {
        image = [image imageFlippedForRightToLeftLayoutDirection];
    }

    return image;
}

- (CGSize)intrinsicContentSize {
    return [BPKIcon concreteSizeForIconName:self.iconName];
}

@end

NS_ASSUME_NONNULL_END
