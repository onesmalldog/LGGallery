
//  Created by lee on 16/7/20.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface LGGetImageAsset : NSObject
/** 获取图片相册列表 */
+ (NSArray<NSString *> *)getAllAlbumsName;
/** 获取列表下的图片的PHAsset */
+ (NSArray<PHAsset *> *)getImageArrayWithAlbumName:(NSString *)name;
@end
