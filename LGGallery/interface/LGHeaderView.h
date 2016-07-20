//  created by lee 2016/7/20

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LGHeaderViewShowImage,
    LGHeaderViewShowVideo
} LGHeaderViewShowWhat;
@class PHAsset;

@protocol LGHeaderViewDelegate <NSObject>
@optional;
/** select item */
- (void)headerViewForCollection:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath showWhat:(LGHeaderViewShowWhat)showWhat;
/** close button */
- (void)headerViewCloseBtnClick:(UIView *)view;
@end

@interface LGHeaderView : UIView
/** 初始化 initlized */
+ (instancetype)headerViewWithFrame:(CGRect)frame type:(LGHeaderViewShowWhat)showWhat;
/** 设置展示哪一种相册 show what album*/
@property (assign, nonatomic) LGHeaderViewShowWhat showWhat;
/** 数据源数组 array of data source */
@property (copy, nonatomic, readonly) NSArray<PHAsset *> *collectionArray;
/** delegate */
@property (weak, nonatomic) id <LGHeaderViewDelegate> delegate;
@end
