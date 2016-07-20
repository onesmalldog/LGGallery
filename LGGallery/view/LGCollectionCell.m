
//  Created by lee on 16/7/8.
//

#import "LGCollectionCell.h"
#import "Masonry.h"
#import "UIView+Extention.h"

@implementation LGCollectionCell
- (void)setShowWhat:(SHOW)showWhat {
    _showWhat = showWhat;
    if (showWhat == SHOWImage) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = self.contentView.bounds;
        [self.contentView addSubview:imageV];
        self.imageItem = imageV;
    }
    else {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = self.contentView.bounds;
        [self.contentView addSubview:imageV];
        self.imageItem = imageV;
        
        UIImageView *videoType = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [imageV addSubview:videoType];
        [videoType mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(imageV.mas_left).offset(10);
            make.bottom.equalTo(imageV.mas_bottom).offset(10);
            make.width.mas_equalTo([UIView judgeScreen:40]);
            make.height.mas_equalTo([UIView judgeScreen:40]);
        }];
        
        UILabel *during = [[UILabel alloc]init];
        during.textColor = [UIColor whiteColor];
        during.textAlignment = NSTextAlignmentRight;
        during.font = [UIFont systemFontOfSize:15];
        [imageV addSubview:during];
        self.during = during;
        [during mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(imageV.mas_right).offset(-15);
            make.centerY.equalTo(videoType.mas_centerY);
        }];
    }
}

+ (LGCollectionCell *)cellWithCollection:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"imageItem";
    [collection registerClass:[self class] forCellWithReuseIdentifier:identifer];
    LGCollectionCell *cell = [collection dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    return cell;
}
@end
