//  Created by lee on 16/7/20.
//

#import "LGHeaderView.h"
#import "UIView+Extention.h"
#import "LGTitleButton.h"
#import "LGPopMenu.h"
#import "LGGetImageAsset.h"
#import "LGImageVideo.h"

@interface LGHeaderView() <LGPopMenuDelegate, LGImageVideoDelegate>
@property (weak, nonatomic) LGPopMenu *popMenu;
@property (weak, nonatomic) LGImageVideo *iv;
@property (weak, nonatomic) LGTitleButton *titleBtn;
@end

@implementation LGHeaderView {
    CGRect _rect;
    NSString *_title;
}
@synthesize collectionArray = _collectionArray;
- (NSArray<PHAsset *> *)collectionArray {
    
    if (!_collectionArray) {
        _collectionArray = self.iv.assetsArray;
    }
    return _collectionArray;
}
- (LGImageVideo *)iv {
    if (!_iv) {
        CGFloat wh = (ScreenWidth-[UIView judgeScreen:55]*2-[UIView judgeScreen:17]*2-1)/3;
        CGRect colFrame = CGRectMake([UIView judgeScreen:55], 30, ScreenWidth-[UIView judgeScreen:55]*2, self.height-30);
        LGImageVideo *iv = [[LGImageVideo alloc]initWithFrame:colFrame];
        iv.itemSize = CGSizeMake(wh, wh);
        iv.lineSpacing = [UIView judgeScreen:17];
        iv.interitemSpacing = [UIView judgeScreen:17];
        iv.delegate = self;
        [self addSubview:iv];
        _iv = iv;
    }
    return _iv;
}
- (LGPopMenu *)popMenu {
    if (!_popMenu && [_title isEqualToString:@"Photos"]) {
        LGPopMenu *popMenu = [[LGPopMenu alloc]initWithFrame:CGRectMake(0, self.iv.y, ScreenWidth, self.iv.height)];
        popMenu.delegate = self;
        [self addSubview:popMenu];
        popMenu.tableRowHeight = 80;
        _popMenu = popMenu;
    }
    return _popMenu;
}
+ (instancetype)headerViewWithFrame:(CGRect)frame type:(LGHeaderViewShowWhat)showWhat {
    return [[self alloc]initWithFrame:frame type:showWhat];
}

- (id)initWithFrame:(CGRect)frame type:(LGHeaderViewShowWhat)showWhat {
    if (self = [super initWithFrame:frame]) {
        _rect = frame;
        self.showWhat = showWhat;
        switch (showWhat) {
            case LGHeaderViewShowImage:{
                _title = @"Photos";
            }break;
            case LGHeaderViewShowVideo:{
                _title = @"Videos";
            }break;
            default:
                break;
        }
        [self createUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setShowWhat:(LGHeaderViewShowWhat)showWhat {
    _showWhat = showWhat;
    if (showWhat == LGHeaderViewShowImage) {
        self.iv.assetsArray = [LGGetImageAsset getImageArrayWithAlbumName:[LGGetImageAsset getAllAlbumsName][0]];
        _title = @"Photos";
        UIImage *image = [UIImage imageNamed:@"pop"];
        UIImage *down = [UIImage imageNamed:@"close_down"];
        [self.titleBtn setImage:down forState:UIControlStateNormal];
        [self.titleBtn setImage:image forState:UIControlStateSelected];
    }
    else {
        NSArray *array = [LGGetImageAsset getImageArrayWithAlbumName:@"Videos"];
        self.iv.assetsArray = array;
        _title = @"Videos";
        [self.titleBtn setImage:nil forState:UIControlStateNormal];
        [self.titleBtn setImage:nil forState:UIControlStateSelected];
    }
    [self.titleBtn setTitle:_title forState:UIControlStateNormal];
    [self.iv.collection reloadData];
}

- (void)createUI {
    
// close button
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake([UIView judgeScreen:75], [UIView judgeScreen:39], [UIView judgeScreen:39]*2, [UIView judgeScreen:39]*2);
    [left setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:left];
// menu    
    NSString *title = _title;
    LGTitleButton *titleBtn = [LGTitleButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    titleBtn.size = CGSizeMake(120, 20);
    titleBtn.x = self.centerX-titleBtn.width*0.5;
    titleBtn.y = 0;//left.y+left.height*0.5-titleBtn.height*0.5;
    titleBtn.backgroundColor = [UIColor clearColor];
    titleBtn.adjustsImageWhenHighlighted = NO;
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleBtn];
    self.titleBtn = titleBtn;
    
    [self.iv reloadInputViews];
}

- (void)titleBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.popMenu show];
    }
    else [self.popMenu hide];
}

- (void)leftBtnClick {
    if ([self.delegate respondsToSelector:@selector(headerViewCloseBtnClick:)]) {
        [self.delegate headerViewCloseBtnClick:self];
    }
    [self removeFromSuperview];
}

#pragma mark LGPopMenuDelegate
- (void)popMenuDidChooseAlbum:(LGPopMenu *)popMenu chooseName:(NSString *)name {
    [popMenu hide];
    self.titleBtn.selected = NO;
    NSNotification *noti = [NSNotification notificationWithName:@"changeName" object:nil userInfo:@{ @"changeName":name }];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
}
#pragma mark LGImageVideoDelegate
- (void)imageVideoCollection:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(headerViewForCollection:didSelectItemAtIndexPath:showWhat:)]) {
        [self.delegate headerViewForCollection:collectionView didSelectItemAtIndexPath:indexPath showWhat:self.showWhat];
    }
}
@end
