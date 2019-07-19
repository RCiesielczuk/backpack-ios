/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

#import "BPKStar.h"
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Icon.h>
#import <Backpack/BPKRTLSupport.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKStar ()

@property (nonatomic) BPKIconView *starView;
@property (nonatomic) BPKIconView *halfStarView;

/**
 * Base color of the star when it's empty, its default value is BPKColor.gray100. Setting updates
 * the displayed star.
 */
@property (nullable, nonatomic, strong) UIColor* starColor;

@end

@implementation BPKStar

- (instancetype)initWithSize:(BPKStarSize)size {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self setupWithSize:size];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupWithSize:BPKStarSizeSmall];
    }
    
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupWithSize:BPKStarSizeSmall];
    }
    
    return self;
}

- (void)setupWithSize:(BPKStarSize)size {
    
    self.starView = [[BPKIconView alloc] initWithIconName:BPKIconNameStar size:BPKIconSizeSmall];
    self.starView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.starView];
    
    self.halfStarView = [[BPKIconView alloc] initWithIconName:BPKIconNameStarHalf size:BPKIconSizeSmall];
    self.halfStarView.flipsForRightToLeft = YES;
    self.halfStarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.halfStarView];
    
    [NSLayoutConstraint activateConstraints:@[[self.leadingAnchor constraintEqualToAnchor:self.starView.leadingAnchor],
                                              [self.trailingAnchor constraintEqualToAnchor:self.starView.trailingAnchor],
                                              [self.topAnchor constraintEqualToAnchor:self.starView.topAnchor],
                                              [self.bottomAnchor constraintEqualToAnchor:self.starView.bottomAnchor]
                                              ]];

    [NSLayoutConstraint activateConstraints:@[[self.leadingAnchor constraintEqualToAnchor:self.halfStarView.leadingAnchor],
                                              [self.trailingAnchor constraintEqualToAnchor:self.halfStarView.trailingAnchor],
                                              [self.topAnchor constraintEqualToAnchor:self.halfStarView.topAnchor],
                                              [self.bottomAnchor constraintEqualToAnchor:self.halfStarView.bottomAnchor]
                                              ]];
    
    self.starColor = [BPKColor gray100];
    self.starFilledColor = [BPKColor yellow500];
    _size = size;
    _state = BPKStarStateDefault;
    
    [self updateSize];
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {    
    return [BPKIcon concreteSizeForIconSize:[self iconSizeForStarSize:self.size]];
}

#pragma mark - Setters

- (void)setState:(BPKStarState)state {
    BPKAssertMainThread();
    if (_state != state) {
        _state = state;
        [self updateStarAppearance];
    }
}

- (void)setStarColor:(nullable UIColor *)starColor {
    BPKAssertMainThread();
    if (![_starColor isEqual:starColor]) {
        _starColor = starColor;
        [self updateStarAppearance];
    }
}

- (void)setStarFilledColor:(nullable UIColor *)starFilledColor {
    BPKAssertMainThread();
    if (![_starFilledColor isEqual:starFilledColor]) {
        _starFilledColor = starFilledColor;
        [self updateStarAppearance];
    }
}

- (void)setSize:(BPKStarSize)size {
    BPKAssertMainThread();
    if (_size != size) {
        _size = size;
        [self updateSize];
    }
}

#pragma mark - Helpers

- (BPKIconSize)iconSizeForStarSize:(BPKStarSize)size {
    switch (size) {
        case BPKStarSizeLarge:
            return BPKIconSizeLarge;
            break;
            
        default:
        case BPKStarSizeSmall:
            return BPKIconSizeSmall;
            break;
    }
}

- (void)updateSize {
    self.starView.size = [self iconSizeForStarSize:self.size];
    self.halfStarView.size = [self iconSizeForStarSize:self.size];
    
    [self setNeedsLayout];
    [self updateStarAppearance];
}

- (void)updateStarAppearance {
    self.starView.tintColor = self.state == BPKStarStateFull ? self.starFilledColor : self.starColor;
    self.halfStarView.tintColor = self.starFilledColor;
    self.halfStarView.hidden = self.state != BPKStarStateHalf;
}

@end

NS_ASSUME_NONNULL_END