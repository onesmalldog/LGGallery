
//  Created by apple on 15-3-4.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
@end
