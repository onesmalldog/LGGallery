
//  Created by lee on 16/7/9.
//

#import "LGPopCell.h"
#import "Masonry.h"
#import "UIView+Extention.h"

@implementation LGPopCell
- (UIImageView *)imageV {
    if (!_imageV) {
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:imageV];
        _imageV = imageV;
    }
    return _imageV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}
- (UILabel *)countLabel {
    if (!_countLabel) {
        UILabel *countLabel = [[UILabel alloc]init];
        countLabel.textColor = [UIColor blackColor];
        countLabel.textAlignment = NSTextAlignmentLeft;
        countLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
    }
    return _countLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellBg"]];
        self.backgroundView = imgV;
        
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset([UIView judgeScreen:73]);
            make.top.equalTo(self.contentView.mas_top).offset([UIView judgeScreen:23]);
            make.width.mas_equalTo([UIView judgeScreen:182]);
            make.height.mas_equalTo([UIView judgeScreen:182]);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView.mas_top).offset([UIView judgeScreen:73]);
            make.left.equalTo(self.imageV.mas_right).offset([UIView judgeScreen:86]);
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.nameLabel.mas_left);
            make.top.equalTo(self.nameLabel.mas_bottom).offset([UIView judgeScreen:30]);
        }];
        
    }
    return self;
}
+ (LGPopCell *)popCellWithTableView:(UITableView *)tableView {
    NSString *identifer = @"popCell";
    [tableView registerClass:[self class] forCellReuseIdentifier:identifer];
    LGPopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.backgroundColor = [UIColor lightGrayColor];//colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    return cell;
}
@end
