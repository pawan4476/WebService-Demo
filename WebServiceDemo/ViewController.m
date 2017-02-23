//
//  ViewController.m
//  WebServiceDemo
//
//  Created by Nagam Pawan on 10/1/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray * artistNameDetails;
@property(nonatomic,strong) NSArray * artistnme;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.artistNameDetails = [[NSMutableArray alloc]init];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@" All JSon DATA %@", json);
    
        NSArray * results=[[json valueForKey:@"results"] valueForKey:@"artistName"];
       // self.artistnme=[results valueForKey:@"artistName"];
        
        NSLog(@"Artist Names %@",results);
        
    
        [self.artistNameDetails addObjectsFromArray:results];
        
        [self.tableView reloadData];
        
    }];
    
    [dataTask resume];



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.artistNameDetails count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text=[self.artistNameDetails objectAtIndex:indexPath.row];
    return cell;
}

@end
