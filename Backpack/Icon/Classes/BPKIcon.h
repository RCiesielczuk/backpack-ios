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
#import <Foundation/Foundation.h>

#import "BPKIconNames.h"

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

/**
 * This class encapsulates all Backpack icons and the ability to render them as `UIImage`. It
 * leverages a `NSCache` to prevent excessive performance impact when using the same icon many
 * times. Further the use of `NSCache` means that in low memory scenarios the cache will be cleared
 * to allow more important memory use.
 */
@interface BPKIcon : NSObject

/**
 * A dictionary mapping icon names to the unicode code point in the icon font of the icon.
 */
@property(class, nonatomic, readonly, nullable) NSDictionary<BPKIconName, NSString *> *iconMapping;

/**
 * Render a given icon as a UIImage for use as a template, i.e. with
 * `renderMode` set to `UIImageRenderingModeAlwaysTemplate`.
 *
 * @param name The name of the icon e.g. "flight".
 * @return The rendered icon as a `UIImage` in template mode.
 */
+ (UIImage *)templateIconNamed:(BPKIconName)name NS_SWIFT_NAME(makeTemplateIcon(name:));

/**
 * Render a given icon as a UIImage.
 *
 * @param name The name of the icon e.g. "flight".
 * @param color The color to render the icon in.
 * @return The rendered icon as a `UIImage`.
 */
+ (UIImage *)iconNamed:(BPKIconName)name
                 color:(UIColor *)color NS_SWIFT_NAME(makeIcon(name:color:));

/**
 * Calculates the concrete point size a given BPKIconSize.
 *
 * @param iconName The BPKIconName for which to calculate the concrete size.
 * @return The concerete point size for the given size.
 */
+ (CGSize)concreteSizeForIconName:(BPKIconName)iconName NS_SWIFT_NAME(concreteSize(forIconName:));
@end
NS_ASSUME_NONNULL_END
