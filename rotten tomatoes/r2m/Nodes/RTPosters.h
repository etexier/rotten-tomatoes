//
//  RTPosters.h
//
//  File generated by Magnet rest2mobile 1.1 - Feb 7, 2015 11:25:59 AM
//  @See Also: http://developer.magnet.com
//
/** Generated from json example
{
  "original" : "http://content7.flixster.com/movie/11/16/52/11165293_tmb.jpg",
  "detailed" : "http://content7.flixster.com/movie/11/16/52/11165293_tmb.jpg",
  "thumbnail" : "http://content7.flixster.com/movie/11/16/52/11165293_tmb.jpg",
  "profile" : "http://content7.flixster.com/movie/11/16/52/11165293_tmb.jpg"
}

*/

#import <Rest2Mobile/Rest2Mobile.h>


@interface RTPosters : MMResourceNode <NSCoding>

//field declarations

@property (nonatomic, copy) NSString *detailed;


@property (nonatomic, copy) NSString *original;


@property (nonatomic, copy) NSString *profile;


@property (nonatomic, copy) NSString *thumbnail;



@end
