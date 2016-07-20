
//  Created by 东途 on 16/7/8.
//

#import "LGImageVideo.h"
#import "LGCollectionCell.h"
#import "LGGetImageAsset.h"
#import "Masonry.h"

@interface LGImageVideo () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@end

@implementation LGImageVideo
@synthesize tableList = _tableList;
- (NSArray *)assetsArray {
    if (!_assetsArray) {
        _assetsArray = [NSArray array];
    }
    return _assetsArray;
}
- (NSArray *)tableList {
    if (!_tableList) {
        _tableList = [LGGetImageAsset getAllAlbumsName];
    }
    return _tableList;
}

// 添加视图 add view
- (void)drawRect:(CGRect)rect {
    [self showCollectionView];
}

// 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        NSString *def = self.tableList[0];
        self.assetsArray = [LGGetImageAsset getImageArrayWithAlbumName:def];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeName:) name:@"changeName" object:nil];
    }
    return self;
}
// 监听下拉菜单的选择
- (void)didChangeName:(NSNotification *)noti {
    NSString *newName = noti.userInfo[@"changeName"];
    self.assetsArray = [LGGetImageAsset getImageArrayWithAlbumName:newName];
    [self.collection reloadData];
}

- (void)showCollectionView {
    self.userInteractionEnabled = YES;
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:flowLayout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.delegate = self;
    collection.dataSource = self;
    [self addSubview:collection];
    self.collection = collection;
}

#pragma mark collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(imageVideoCollection:didSelectItemAtIndexPath:)]) {
        [self.delegate imageVideoCollection:collectionView didSelectItemAtIndexPath:indexPath];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"camera"];
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"camera" forIndexPath:indexPath];
        if (cell.contentView.subviews.count == 0) {
            UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"itemBg"]];
            cell.backgroundView = bgView;
            UIImageView *camera = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"camera"]];
            [cell.contentView addSubview:camera];
            [camera sizeToFit];
            [camera mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.centerX.mas_equalTo(cell.contentView.mas_centerX);
            }];
        }
        return cell;
    }
    else {
        LGCollectionCell *cell = [LGCollectionCell cellWithCollection:collectionView indexPath:indexPath];
        cell.showWhat = SHOWImage;
        [[PHImageManager defaultManager] requestImageForAsset:self.assetsArray[indexPath.row-1] targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageItem.image = result;
            });
        }];
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.lineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.interitemSpacing;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
@end
