//
//  RTLinks.h
//
//  File generated by Magnet rest2mobile 1.1 - Feb 7, 2015 11:25:59 AM
//  @See Also: http://developer.magnet.com
//
/** Generated from json example
{
  "alternate" : "http://www.rottentomatoes.com/m/dawn_of_the_planet_of_the_apes/",
  "reviews" : "http://api.rottentomatoes.com/api/public/v1.0/movies/771308675/reviews.json",
  "self" : "http://api.rottentomatoes.com/api/public/v1.0/movies/771308675.json",
  "cast" : "http://api.rottentomatoes.com/api/public/v1.0/movies/771308675/cast.json",
  "similar" : "http://api.rottentomatoes.com/api/public/v1.0/movies/771308675/similar.json"
}

*/

#import <Rest2Mobile/Rest2Mobile.h>


@interface RTLinks : MMResourceNode <NSCoding>

//field declarations

@property (nonatomic, copy) NSString *alternate;


@property (nonatomic, copy) NSString *cast;


@property (nonatomic, copy) NSString *magnetSelf;


@property (nonatomic, copy) NSString *next;


@property (nonatomic, copy) NSString *reviews;


@property (nonatomic, copy) NSString *similar;



@end