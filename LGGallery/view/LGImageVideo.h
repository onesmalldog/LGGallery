
//  Created by 东途 on 16/7/8.
//

#import <UIKit/UIKit.h>

@protocol LGImageVideoDelegate <NSObject>
@optional;
- (void)imageVideoCollection:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface LGImageVideo : UIView
/** 相册列表，tableView的数据源 list of album */
@property (strong, nonatomic, readonly) NSArray *tableList;
/** 图片asset，collection的数据源，默认是图片 data source of collection, default is image */
@property (strong, nonatomic) NSArray *assetsArray;
/** 设置完assetsArray请刷新collectionView; After setting assetsArray Please refresh collectionView  */
@property (weak, nonatomic) UICollectionView *collection;
/** size of collection item */
@property (assign, nonatomic) CGSize itemSize;
/** collection item 之间横向距离 Lateral distance */
@property (assign, nonatomic) CGFloat interitemSpacing;
/** collection item 之间纵向距离 Longitudinal distance  */
@property (assign, nonatomic) CGFloat lineSpacing;

@property (weak, nonatomic) id <LGImageVideoDelegate> delegate;
@end
