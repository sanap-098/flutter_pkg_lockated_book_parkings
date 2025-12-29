import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({
    Key? key,
    this.image,
    this.height,
    this.width,
    this.radius,
    this.padding,
    this.boxfit,
    this.noImage = false,
    this.errorImage,
    this.greyFilterRequired = false,
    this.isAsset = false,
    this.package, // 1. Add this parameter
  }) : super(key: key);

  final String? image;
  final String? errorImage;
  final double? height;
  final double? width;
  final BorderRadius? radius;
  final double? padding;
  final BoxFit? boxfit;
  final bool noImage;
  final bool? greyFilterRequired;
  final bool isAsset;
  final String? package; // 2. Declare it

  @override
  Widget build(BuildContext context) {
    // Define the fallback image provider with the correct package
    final ImageProvider fallbackImage = AssetImage(
      errorImage ?? 'assets/images/no_image.webp',
      package: 'flutter_pkg_lockated_book_parking', // Hardcoded package for fallback
    );

    return Container(
      padding: EdgeInsets.all(padding ?? 8.0),
      width: width,
      height: height,
      child: noImage || image == null
          ? Image(
              image: fallbackImage,
              width: width,
              height: height,
              fit: BoxFit.fill,
            )
          : ClipRRect(
              borderRadius: radius ?? BorderRadius.circular(10),
              child: isAsset
                  ? Image.asset(
                      image!,
                      package: package, // 3. Pass package here
                      fit: boxfit ?? BoxFit.fitWidth,
                      color: greyFilterRequired == true
                          ? Colors.black.withValues(alpha: 0.2)
                          : null,
                      colorBlendMode:
                          greyFilterRequired == true ? BlendMode.darken : null,
                      errorBuilder: (context, error, stackTrace) {
                        return Image(
                          image: fallbackImage,
                          width: width,
                          height: height,
                          fit: BoxFit.fill,
                        );
                      },
                    )
                  : CachedNetworkImage(
                      imageUrl: image!,
                      fit: boxfit ?? BoxFit.fitWidth,
                      color: greyFilterRequired == true
                          ? Colors.black.withValues(alpha: 0.2)
                          : null,
                      colorBlendMode:
                          greyFilterRequired == true ? BlendMode.darken : null,
                      progressIndicatorBuilder: (context, url, progress) {
                        return Center(
                          child: SizedBox(
                              height: ((height ?? 30) < 30) ? height : 30,
                              width: ((width ?? 30) < 30) ? width : 30,
                              child: CircularProgressIndicator(
                                  value: progress.progress)),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Image(
                          image: fallbackImage,
                          width: width,
                          height: height,
                          color: greyFilterRequired == true
                              ? Colors.black.withValues(alpha: 0.4)
                              : null,
                          colorBlendMode: greyFilterRequired == true
                              ? BlendMode.darken
                              : null,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
            ),
    );
  }
}




// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class ImageCardWidget extends StatelessWidget {
//   const ImageCardWidget({
//     Key? key,
//     this.image,
//     this.height,
//     this.width,
//     this.radius,
//     this.padding,
//     this.boxfit,
//     this.noImage = false,
//     this.errorImage,
//     this.greyFilterRequired = false,
//     this.isAsset = false,
//   }) : super(key: key);

//   final String? image;
//   final String? errorImage;
//   final double? height;
//   final double? width;
//   final BorderRadius? radius;
//   final double? padding;
//   final BoxFit? boxfit;
//   final bool noImage;
//   final bool? greyFilterRequired;
//   final bool isAsset;
  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(padding ?? 8.0),
//       width: width,
//       height: height,
//       child: noImage || image == null
//           ? Image(
//               image: AssetImage(errorImage ?? 'assets/images/no_image.webp'),
//               width: width,
//               height: height,
//               fit: BoxFit.fill,
//             )
//           : ClipRRect(
//               borderRadius: radius ?? BorderRadius.circular(10),
//               child: isAsset
//                   ? Image.asset(
//                       image!,
//                       fit: boxfit ?? BoxFit.fitWidth,
//                       color: greyFilterRequired == true
//                           ? Colors.black.withValues(alpha: 0.2)
//                           : null,
//                       colorBlendMode:
//                           greyFilterRequired == true ? BlendMode.darken : null,
//                     )
//                   : CachedNetworkImage(
//                       imageUrl: image!,
//                       fit: boxfit ?? BoxFit.fitWidth,
//                       color: greyFilterRequired == true
//                           ? Colors.black.withValues(alpha: 0.2)
//                           : null,
//                       colorBlendMode:
//                           greyFilterRequired == true ? BlendMode.darken : null,
//                       progressIndicatorBuilder: (context, url, progress) {
//                         return Center(
//                           child: SizedBox(
//                               height: ((height ?? 30) < 30) ? height : 30,
//                               width: ((width ?? 30) < 30) ? width : 30,
//                               child: CircularProgressIndicator(
//                                   value: progress.progress)),
//                         );
//                       },
//                       errorWidget: (context, url, error) {
//                         return Image(
//                           image: AssetImage(
//                               errorImage ?? 'assets/images/no_image.webp'),
//                           width: width,
//                           height: height,
//                           color: greyFilterRequired == true
//                               ? Colors.black.withValues(alpha: 0.4)
//                               : null,
//                           colorBlendMode: greyFilterRequired == true
//                               ? BlendMode.darken
//                               : null,
//                           fit: BoxFit.fill,
//                         );
//                       },
//                     ),
//             ),
//     );
//   }
// }
