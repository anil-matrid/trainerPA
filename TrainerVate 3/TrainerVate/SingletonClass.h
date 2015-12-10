//
//  SingletonClass.h
//  Tenderlicious
//
//  Created by Sahil Garg on 08/10/14.
//  Copyright (c) 2014 cogniter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject

// Trainer Part
@property(strong,nonatomic) NSMutableArray *productArray;  // Dic to store the values of My Stats
@property(strong,nonatomic) NSMutableDictionary *clientDat;
@property(strong,nonatomic) NSMutableDictionary *basicStats;
@property(strong,nonatomic) NSMutableDictionary *bmiStats;
@property(strong,nonatomic) NSMutableDictionary *smStats;
@property(strong,nonatomic) NSMutableDictionary *sfStats;
@property(strong,nonatomic) NSMutableDictionary *bfStats;
@property(strong,nonatomic) NSMutableDictionary *clientInfo;
@property(strong,nonatomic) NSMutableArray *setProfileInfo;
@property(strong,nonatomic) NSMutableArray *MyClientDetail;
@property(strong,nonatomic) NSMutableDictionary *calenderDate;
@property(strong,nonatomic) NSMutableDictionary *errorMessages;
@property(strong,nonatomic) NSMutableDictionary *reminderCreateClient;
@property(strong,nonatomic) NSMutableDictionary *reminderCreateClient1;
@property(strong,nonatomic) NSMutableDictionary *updationValue;
@property(strong,nonatomic) NSMutableDictionary *aboutClientData;
@property(strong,nonatomic) NSMutableArray *cartSelectedProduct;
@property(strong,nonatomic) NSMutableArray *ShopSelectedProduct;
@property(strong,nonatomic) NSMutableDictionary *bundelSelectedProduct;
@property(strong,nonatomic) NSMutableArray *breakfastdietPlanBundelFood;
@property(strong,nonatomic) NSMutableArray *breakfastdietPlanBundelSuppliment;
@property(strong,nonatomic) NSMutableArray *lunchdietPlanBundelArray;
@property(strong,nonatomic) NSMutableArray *lunchdietPlanBundelSuppliment;
@property(strong,nonatomic) NSMutableArray *dinnerdietPlanBundelArray;
@property(strong,nonatomic) NSMutableArray *dinnerdietPlanBundelSuppliment;
@property(strong,nonatomic) NSMutableArray *snaksdietPlanBundelArray;
@property(strong,nonatomic) NSMutableArray *snaksdietPlanBundelSuppliment;
@property(strong,nonatomic) NSMutableArray *dietPlanBundelSuppliment;
@property(strong,nonatomic) NSMutableArray *dietPlanBundelArray;
@property(strong,nonatomic) NSMutableArray *selectedWorkout;
@property(strong,nonatomic) NSMutableArray *existWorkouts;
@property(strong,nonatomic) NSMutableArray *dietArray;
@property(strong,nonatomic) NSString *Workout;
@property(strong,nonatomic) NSString *remove;
@property(strong,nonatomic) NSString *workoutRemove;
@property(strong,nonatomic) NSMutableDictionary *DietPlanSelected;
@property(strong,nonatomic) NSMutableArray *DietPlanSelectedProduct;
//dietPlanBundelSuppliment
@property(strong,nonatomic) NSMutableArray *shopSearchSelected;

+(SingletonClass*)singleton;



@end