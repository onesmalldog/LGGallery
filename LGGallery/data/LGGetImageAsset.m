
//  Created by lee on 16/7/8.
//

#import "LGGetImageAsset.h"

@implementation LGGetImageAsset 
+ (NSArray<NSString *> *)getAllAlbumsName {
    static NSMutableArray *array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = [NSMutableArray arrayWithArray:[self getAllAlbumsNames]];
    });
    return array;
}

// 获取相册列表
+ (NSArray<NSString *> *)getAllAlbumsNames {
    NSMutableArray *array = [NSMutableArray array];
    // 所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHCollection *collection in smartAlbums) {
        NSArray *tmp = [self getImageArrayWithAlbumName:collection.localizedTitle];
        if (tmp.count > 0 && ![collection.localizedTitle isEqualToString:@"Videos"]) {
            [array addObject:collection.localizedTitle];
        }
    }
    // 所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for (PHCollection *collection in topLevelUserCollections) {
        NSArray *tmp = [self getImageArrayWithAlbumName:collection.localizedTitle];
        if (tmp.count > 0) {
            [array addObject:collection.localizedTitle];
        }
    }
    return array;
}

// 获取列表内图片asset的数组
+ (NSArray<PHAsset *> *)getImageArrayWithAlbumName:(NSString *)name {
    // 所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHCollection *collection in smartAlbums) {
        if ([name isEqualToString:collection.localizedTitle]) {
            NSArray *array = [self getPHAssetWithPHCollection:collection];
            if (array.count > 0) {
                return array;
            }
        }
    }
    // 所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for (PHCollection *collection in topLevelUserCollections) {
        if ([name isEqualToString:collection.localizedTitle]) {
            NSArray *array = [self getPHAssetWithPHCollection:collection];
            if (array.count > 0) {
                return array;
            }
        }
    }
    return nil;
}

+ (NSArray<PHAsset *> *)getPHAssetWithPHCollection:(PHCollection *)collection {
    NSMutableArray *array = [NSMutableArray array];
    PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
    // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in fetchResult) {
        [array addObject:asset];
    }
    return array;
}
@end
