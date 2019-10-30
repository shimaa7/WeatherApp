//
//  SearchForCityViewController.m
//  Weather
//
//  Created by Shimaa Hassan on 10/29/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

#import "SearchForCityViewController.h"
#import "CitiesTableViewCell.h"

static NSString * const CellIDTitle = @"CitiesCell";

@implementation SearchForCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
    [self cofigureTableview];
    self.content = @[ @"London, UK", @"Paris, FR", @"Vienna, AUT"];

}
-(void)setupLayout{
    
    //-------- setup views ----------------
    
    // main view color
    self.view.backgroundColor = [UIColor colorWithRed:37/255.0 green:37/255.0 blue:38/255.0 alpha:1/1.0];
    
    // main label
    UILabel *mainLabel = [[UILabel alloc] init];
    mainLabel.textColor = [UIColor colorWithRed:121/255.0 green:127/255.0 blue:136/255.0 alpha:1/1.0];
    mainLabel.numberOfLines = 2;
    mainLabel.text = @"Enter city, postcode or airoport location";
    mainLabel.textAlignment = NSTextAlignmentCenter;
    mainLabel.font = [UIFont fontWithName:@"AlNile" size:15];
    mainLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    mainLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: mainLabel];
    
    // add city btn image view
    UIImageView *addBtnImageView = [[UIImageView alloc] init];
    addBtnImageView.backgroundColor = UIColor.clearColor;
    addBtnImageView.image = [UIImage imageNamed: @"Button_left.png"];
    [addBtnImageView setContentMode:UIViewContentModeScaleAspectFit];
    addBtnImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: addBtnImageView];
    
    // add city btn
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setExclusiveTouch:YES];
    addBtn.backgroundColor = UIColor.clearColor;
    UIImage *btnImage = [UIImage imageNamed:@"left-arrow-black.png"];
    [addBtn setImage:btnImage forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [addBtn addTarget:self action:@selector(addNewCityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: addBtn];
    
    
    //-------- setup constrains ----------------
    
    float viewHeight = self.view.frame.size.height;
    float viewWidth = self.view.frame.size.width;
    
    // main label
    [mainLabel.topAnchor constraintEqualToAnchor: self.view.topAnchor
                                        constant:-viewHeight * 0.005].active = YES;
    [mainLabel.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor
                                            constant:0.0].active = YES;
    [mainLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor
                                         multiplier:0.2].active = YES;
    
    // add city Btn image view
    [addBtnImageView.leftAnchor constraintEqualToAnchor: self.view.leftAnchor
                                               constant: -viewWidth * 0.04].active = YES;
    [addBtnImageView.topAnchor constraintEqualToAnchor: self.view.topAnchor
                                              constant:viewHeight * 0.03].active = YES;
    [addBtnImageView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor
                                               multiplier:0.2].active = YES;
    [addBtnImageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor
                                              multiplier:0.4].active = YES;
    
    // add city btn
    [addBtn.leftAnchor constraintEqualToAnchor: self.view.leftAnchor
                                      constant: 0].active = YES;
    [addBtn.centerYAnchor constraintEqualToAnchor: mainLabel.centerYAnchor
                                         constant:0].active = YES;
    [addBtn.heightAnchor constraintEqualToAnchor:self.view.heightAnchor
                                      multiplier:0.3].active = YES;
    [addBtn.widthAnchor constraintEqualToAnchor:self.view.widthAnchor
                                     multiplier:0.2].active = YES;
    
}
-(void) addNewCityBtnClick:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//---------------------- Cities Table View ------------------------------------

-(void)cofigureTableview
{
    //-------- setup views ----------------
    _citiesTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _citiesTableView.delegate = self;
    _citiesTableView.dataSource = self;
    _citiesTableView.tableFooterView = [UIView new];
    _citiesTableView.backgroundColor = UIColor.clearColor;
    [_citiesTableView setSeparatorColor:[UIColor blackColor]];
    _citiesTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_citiesTableView];
    [[self citiesTableView] registerClass:[CitiesTableViewCell class] forCellReuseIdentifier:CellIDTitle];
    
    
    //-------- setup constrains ----------------
    [_citiesTableView.topAnchor constraintEqualToAnchor: self.view.topAnchor
                                               constant: self.view.frame.size.height * 0.18].active = YES;
    [_citiesTableView.rightAnchor constraintEqualToAnchor: self.view.rightAnchor
                                                 constant:-15].active = YES;
    [_citiesTableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor
                                                constant:0].active = YES;
    [_citiesTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor
                                                  constant:15].active = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //-------- setup cell configuration ----------------
    static NSString *cellIdentifier = CellIDTitle;
    
    CitiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = UIColor.clearColor;
    
    //-------- fill data ----------------
    cell.cityName.text = [_content objectAtIndex:indexPath.row];
    [cell.historicalBtn addTarget:self action:@selector(addNewCityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"title of cell %@", [_content objectAtIndex:indexPath.row]);
}
@end
