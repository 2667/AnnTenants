//
//  ATCollectionCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/24.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATCollectionCellView.h"

@interface ATCollectionCellView()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    CGFloat _itemWH;
    CGFloat _margin;
}
@property(nonatomic, strong) UILabel *sectionTitle;
@property(nonatomic, strong) UIImageView *backImage;
@property(nonatomic, strong) UILabel *houseInfoDetail;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *layout;
@property(nonatomic, strong) ATPickerController *pickerController;
@property(nonatomic, weak) ATPublishSharedHouseController *pshc;

@end

@implementation ATCollectionCellView
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectedPhotos = [NSMutableArray array];
        _selectedAssets = [NSMutableArray array];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        [self.pshc presentViewController:self.pickerController animated:FALSE completion:^{
            [self.pickerController choosePictureOfNumbers:4];
        }];
        
        self.pickerController.numbers = 9;
        __weak typeof(self) weakSelf = self;
        self.pickerController.tzimagePC.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
            self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
            [weakSelf.collectionView reloadData];
            weakSelf.pshc.pictures = [NSMutableArray arrayWithArray:photos];
            [weakSelf.pshc.tableView reloadData];
            NSLog(@"-------->%@, ------->%@",photos, assets);
        };
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count +1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ATCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ATCollectionCell" forIndexPath:indexPath];
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
    }else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_collectionView reloadData];
    }];
}


//由于cell的布局特殊化，所有约束条件都在layoutSubviews方法中写
- (void)layoutSubviews {
    [super layoutSubviews];
    
//    NSInteger contentSizeH = (ATSCREEN_WIDTH - 4*5)/4;

    
    [self.contentView addSubview:self.sectionTitle];
    [self.contentView addSubview:self.houseInfoDetail];
    [self.contentView addSubview:self.backImage];
    [self.contentView addSubview:self.collectionView];
    
    self.sectionTitle.frame = CGRectMake(15, 10, 70, 25);
    self.houseInfoDetail.frame = CGRectMake(self.frame.size.width-116, 10, 100, 25);
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}



- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM {
    self.sectionTitle.text = shareHouseVM.functionTitle;
    self.houseInfoDetail.text = shareHouseVM.houseInfo;
}

//#pragma mark - 获得高度自适应
+ (CGFloat)heightWithModel
{
    ATCollectionCellView *cell = [[ATCollectionCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATShareHouseCellView"];
    [cell layoutIfNeeded];//此方法强制立即布局并显示更新,调用 layoutSubviews, 它会自动执行相当于setNeedsLayout的操作
    CGRect frame = cell.sectionTitle.frame;
    CGFloat height = frame.origin.y + frame.size.height + 10;
    return height;
}

- (UILabel *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc] init];
    }
    return _sectionTitle;
}
- (UILabel *)houseInfoDetail {
    if (!_houseInfoDetail) {
        _houseInfoDetail = [[UILabel alloc] init];
    }
    return _houseInfoDetail;
}

- (UICollectionViewFlowLayout *)layout {
    _margin = 10;
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _itemWH = (self.frame.size.width - 5 * _margin) / 4;
//        cell的大小
        _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
//        最小列举
        _layout.minimumInteritemSpacing = _margin;
//        最小行距
        _layout.minimumLineSpacing = _margin;
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout: self.layout];
        CGFloat rgb = 244 / 255.0;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
        _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_collectionView registerClass:[ATCollectionCell class] forCellWithReuseIdentifier:@"ATCollectionCell"];
    }
    return _collectionView;
}

- (ATPickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [ATPickerController new];
    }
    return _pickerController;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setControlelr:(ATPublishSharedHouseController *)controller {
    self.pshc = controller;
}
@end
