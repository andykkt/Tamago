//
//  ColyseusClientManager.m
//  Tamago
//
//  Created by Andy Kim on 3/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

#import "ColyseusClientManager.h"
#import "Colyseus_ObjC.h"

@interface ColyseusClientManager() {
    ColyseusClient *client;
}
@end

@implementation ColyseusClientManager

- (void)start {
    client = [[ColyseusClient alloc] initWithEndpoint:@"ws://localhost:1337" ID:nil];
    
    __block ColyseusClientManager *weakself = self;
    [client.onOpen addObject:^void(ColyseusClient *c, ColyseusEventArgs *e) {
        NSLog(@"Connection open");
        
        //Once the connection is open, join a room
        ColyseusRoom *room = [weakself->client join:@"canvas" options:@{@"name" : @"Andy"}];
//        ColyseusRoom *room = [weakself->client join:@"canvas" options:nil];
        __block ColyseusRoom *weakroom = room;
        [room.onJoin addObject:^void(ColyseusRoom *r, ColyseusMessageEventArgs *m) {
            NSLog(@"Joined with SessionID: %@",[m message]);
            [weakroom connect];
            [weakroom send:@{@"type":@"nameset", @"name" : @"switt", @"ts" : @([[NSDate date] timeIntervalSince1970])}];
        }];
        [room.onMessage addObject:^void(ColyseusRoom *r, ColyseusMessageEventArgs *m) {
            NSLog(@"Room: Message received %@",[m message]);
        }];
        [room.onStateChange addObject:^void(ColyseusRoom *ro, ColyseusRoomUpdateEventArgs *r) {
            NSLog(@"State Change; IsFirst %d, Data : %@", r.isFirstState, [r state]);
        }];
        [room.onError addObject:^void(ColyseusRoom *r, ColyseusErrorEventArgs *e) {
            NSLog(@"Error; %@",[e message]);
        }];
        
        // Listen for changes at players.playerName.position.(x or y or z)
        // Here, ":string" will capture playerName, and ":axis" will capture the axis.
        // The @path property in ColyseusDataChange will store strings corresponding to our capture blocks
        [room listen:@"players/:string/position/:axis" callback:^(NSArray *arguments) {
            ColyseusDataChange *change = [arguments firstObject];
            NSLog(@"Axis:%@ changed for player:%@, operation:%@, value:%@", change.path[@"axis"], change.path[@"string"], change.operation, change.value);
        }];
        [room listen:@"players/:*" callback:^(NSArray *arguments) {
            ColyseusDataChange *change = [arguments firstObject];
            NSLog(@"Mutated players, operation:%@, player info is %@", change.operation, change.value);
            //[players setObject:change.value forKey:change.path[@"*"]];
        }];
    }];
    [client connect];
}

@end
