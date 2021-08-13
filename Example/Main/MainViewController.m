//
//  MainViewController.m
//  ExampleInjection
//
//  Created by zsh on 2021/7/31.
//

#import "MainViewController.h"
#import <Masonry/Masonry.h> //第三方库 检查一下 Other Linker Flags: $(inherited)
#import "MainTableViewCell.h"
#import "TestModel.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel * textLab;
@property (nonatomic, strong) UILabel * descLab;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) TestModel * testModel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self layout];
}

- (TestModel *)testModel {
    if (!_testModel) {
        _testModel = [[TestModel alloc] init];
        _testModel.name = @"一段文字~~~";
    }
    
    return _testModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)createUI {
    [self.view addSubview:self.textLab];
    [self.view addSubview:self.descLab];
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

- (void)layout {
    if (self.textLab.superview) {
        [self.textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
        }];
    }
    if (self.descLab.superview) {
        [self.descLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textLab);
            make.top.equalTo(self.textLab.mas_bottom).offset(50);
        }];
    }
    if (self.tableView.superview) {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textLab);
            make.right.mas_equalTo(-10);
            make.top.equalTo(self.descLab.mas_bottom).offset(30);
            make.bottom.mas_equalTo(-10);
        }];
    }
}

- (UILabel *)textLab {
    if (!_textLab) {
        _textLab = [[UILabel alloc] init];
        _textLab.text = @"Hello";
        _textLab.textColor = UIColor.redColor;
        _textLab.backgroundColor = UIColor.cyanColor;
        _textLab.font = [UIFont systemFontOfSize:28];
    }
    return _textLab;
}

- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [[UILabel alloc] init];
        _descLab.text = self.testModel.name;
        _descLab.textColor = UIColor.redColor;
        _descLab.backgroundColor = UIColor.yellowColor;
        _descLab.font = [UIFont systemFontOfSize:30 weight:UIFontWeightSemibold];
    }
    return _descLab;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:MainTableViewCell.class forCellReuseIdentifier:@"MainTableViewCell"];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"MainTableViewCell";
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

@end
