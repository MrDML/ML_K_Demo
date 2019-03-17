//
//  MainViewController.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//
// main_identifier
#import "MainViewController.h"
#import "ChartCustomViewController.h"
@interface MainViewController ()
{
    NSArray *dataSource_Cls_;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    NSLog(@"%@",[self class]);
    
    dataSource_Cls_ = @[@{@"cls":@"ChartCustomViewController",@"title":@"自定义视图"},
                        @{@"cls":@"ChartCustomViewController",@"title":@"自定义视图"},
                        @{@"cls":@"ChartCustomViewController",@"title":@"自定义视图"},
                        @{@"cls":@"ChartCustomViewController",@"title":@"自定义视图"},
                        @{@"cls":@"ChartCustomViewController",@"title":@"自定义视图"},
                        @{@"cls":@"ChartCustomViewController",@"title":@"自定义视图"},];
    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return dataSource_Cls_.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main_identifier" forIndexPath:indexPath];
    
    NSDictionary *dict  =  dataSource_Cls_[indexPath.row];
    NSString *title = dict[@"title"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",title];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict  =  dataSource_Cls_[indexPath.row];
    NSString *cls_name = dict[@"cls"];
    NSString *title = dict[@"title"];
    Class cls = NSClassFromString(cls_name);
    UIViewController *vc = [[cls alloc] init];
    vc.navigationItem.title = title;
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"index.row:%ld",(long)indexPath.row);
    
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
