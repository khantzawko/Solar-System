//
//  ListTableViewController.m
//  Solar System
//
//  Created by Khant Zaw Ko on 28/5/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListViewCell.h"
#import "Planet.h"
#import "DetailsTableViewController.h"

@interface ListTableViewController ()

@property (nonatomic) NSArray *planetNames;
@property (nonatomic) NSArray *planetDescriptions;
@property (nonatomic) NSArray *planetImageUrls;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"Solar System";
    
    _planetNames = @[@"Mercury", @"Venus", @"Earth", @"Mars", @"Jupiter", @"Saturn", @"Uranus", @"Neptune"];
    _planetDescriptions = @[@"Mercury (0.4 AU from the Sun) is the closest planet to the Sun and the smallest planet in the Solar System (0.055 Earth masses). Mercury has no natural satellites; besides impact craters,           its only known geological features are lobed ridges or rupes that were probably produced by a period of contraction early in its history.[69] Mercury's very tenuous atmosphere consists of atoms blasted off its surface by the solar wind.[70] Its relatively large iron core and thin mantle have not yet been adequately explained. Hypotheses include that its outer layers were stripped off by a giant impact; or, that it was prevented from fully accreting by the young Sun's energy.",
                            @"Venus (0.7 AU from the Sun) is close in size to Earth (0.815 Earth masses) and, like Earth, has a thick silicate mantle around an iron core, a substantial atmosphere, and evidence of internal geological activity. It is much drier than Earth, and its atmosphere is ninety times as dense. Venus has no natural satellites. It is the hottest planet, with surface temperatures over 400 °C (752 °F), most likely due to the amount of greenhouse gases in the atmosphere.[73] No definitive evidence of current geological activity has been detected on Venus, but it has no magnetic field that would prevent depletion of its substantial atmosphere, which suggests that its atmosphere is being replenished by volcanic eruptions.",
                            @"Earth (1 AU from the Sun) is the largest and densest of the inner planets, the only one known to have current geological activity, and the only place where life is known to exist.[75] Its liquid hydrosphere is unique among the terrestrial planets, and it is the only planet where plate tectonics has been observed. Earth's atmosphere is radically different from those of the other planets, having been altered by the presence of life to contain 21% free oxygen.[76] It has one natural satellite, the Moon, the only large satellite of a terrestrial planet in the Solar System.",
                            @"Mars (1.5 AU from the Sun) is smaller than Earth and Venus (0.107 Earth masses). It has an atmosphere of mostly carbon dioxide with a surface pressure of 6.1 millibars (roughly 0.6% of that of Earth).[77] Its surface, peppered with vast volcanoes, such as Olympus Mons, and rift valleys, such as Valles Marineris, shows geological activity that may have persisted until as recently as 2 million years ago.[78] Its red colour comes from iron oxide (rust) in its soil.[79] Mars has two tiny natural satellites (Deimos and Phobos) thought to be either captured asteroids,[80] or ejected debris from a massive impact early in Mars's history.",
                            @"Jupiter (5.2 AU), at 318 Earth masses, is 2.5 times the mass of all the other planets put together. It is composed largely of hydrogen and helium. Jupiter's strong internal heat creates semi-permanent features in its atmosphere, such as cloud bands and the Great Red Spot. Jupiter has 69 known satellites. The four largest, Ganymede, Callisto, Io, and Europa, show similarities to the terrestrial planets, such as volcanism and internal heating.[91] Ganymede, the largest satellite in the Solar System, is larger than Mercury.",
                            @"Saturn (9.5 AU), distinguished by its extensive ring system, has several similarities to Jupiter, such as its atmospheric composition and magnetosphere. Although Saturn has 60% of Jupiter's volume, it is less than a third as massive, at 95 Earth masses. Saturn is the only planet of the Solar System that is less dense than water.[92] The rings of Saturn are made up of small ice and rock particles. Saturn has 62 confirmed satellites composed largely of ice. Two of these, Titan and Enceladus, show signs of geological activity.[93] Titan, the second-largest moon in the Solar System, is larger than Mercury and the only satellite in the Solar System with a substantial atmosphere.",
                            @"Uranus (19.2 AU), at 14 Earth masses, is the lightest of the outer planets. Uniquely among the planets, it orbits the Sun on its side; its axial tilt is over ninety degrees to the ecliptic. It has a much colder core than the other giant planets and radiates very little heat into space.[94] Uranus has 27 known satellites, the largest ones being Titania, Oberon, Umbriel, Ariel, and Miranda.",
                            @"Neptune (30.1 AU), though slightly smaller than Uranus, is more massive (equivalent to 17 Earths) and hence more dense. It radiates more internal heat, but not as much as Jupiter or Saturn.[95] Neptune has 14 known satellites. The largest, Triton, is geologically active, with geysers of liquid nitrogen.[96] Triton is the only large satellite with a retrograde orbit. Neptune is accompanied in its orbit by several minor planets, termed Neptune trojans, that are in 1:1 resonance with it."];
    [self setupData];    
}

- (void)setupData {
    
    for (NSInteger i = 0; i < _planetNames.count; i++) {
        Planet *planet = Planet.new;
        planet.name = _planetNames[i];
        planet.planetDescription = _planetDescriptions[i];
        [_planets insertObject:planet atIndex:i];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _planetNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListViewCell *cell = [[ListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListViewCell"];
    
    NSString *name = _planetNames[indexPath.row];
    cell.planetName.text = name;
    NSString *path = [NSString stringWithFormat:@"Planets/%@", [[name lowercaseString] stringByAppendingString:@".jpg"]];
    cell.planetImage.image = [UIImage imageNamed: path];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsTableViewController *dvc = [DetailsTableViewController new];
    dvc.planetName = _planetNames[indexPath.row];
    dvc.planetDescription = _planetDescriptions[indexPath.row];
    
    NSString *name = _planetNames[indexPath.row];
    NSString *path = [NSString stringWithFormat:@"Planets/%@", [[name lowercaseString] stringByAppendingString:@".jpg"]];
    
    dvc.planetImagePath = path;
    [self presentViewController:dvc animated:YES completion:nil];
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
