
//  Created by lee on 16/7/8.
//

#import "LGPopMenu.h"
#import "LGGetImageAsset.h"
#import "LGPopCell.h"
#import "UIView+Extention.h"
#import "Masonry.h"

#define RowHeight [UIView judgeScreen:229]

@interface LGPopMenu() <UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSArray *dataSource;
@end

@implementation LGPopMenu
@synthesize tableList = _tableList;

- (void)setTableRowHeight:(CGFloat)tableRowHeight {
    _tableRowHeight = tableRowHeight;
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.frame = self.bounds;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor blackColor];
        tableView.alpha = 0.85;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (void)show {
    [self.tableView reloadData];
    self.tableView.hidden = NO;
}
- (void)hide {
    [self removeFromSuperview];
}
- (NSArray *)tableList {
    if (!_tableList) {
        _tableList = [LGGetImageAsset getAllAlbumsName];
    }
    return _tableList;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LGPopCell *cell = [LGPopCell popCellWithTableView:tableView];
    NSString *name = self.tableList[indexPath.row];
    cell.nameLabel.text = name;
    NSArray<PHAsset *> *array = [LGGetImageAsset getImageArrayWithAlbumName:name];
    cell.countLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)array.count];
    PHAsset *coverAsset = [array lastObject];
    [[PHImageManager defaultManager] requestImageForAsset:coverAsset targetSize:CGSizeZero contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageV.image = result;
        });
    }];
    
    if (cell.nameLabel.text.length > 0) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView.mas_left);
            make.right.equalTo(cell.contentView.mas_right);
            make.bottom.equalTo(cell.contentView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    }
    cell.backgroundColor = [UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(popMenuDidChooseAlbum:chooseName:)]) {
        [self.delegate popMenuDidChooseAlbum:self chooseName:self.tableList[indexPath.row]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}
@end
