
//  Created by lee on 16/7/20.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SHOWImage,
    SHOWVideo
} SHOW;

@interface LGCollectionCell : UICollectionViewCell
/** image */
@property (weak, nonatomic) UIImageView *imageItem;
/** 视频的时长 during of the video */
@property (weak, nonatomic) UILabel *during;
/** 展示图片或者视频，请先设置这个属性 show image or video, set this property first */
@property (assign, nonatomic) SHOW showWhat;
/** initlized */
+ (LGCollectionCell *)cellWithCollection:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath;
@end
