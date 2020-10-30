
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CachedImage extends StatelessWidget {

  const CachedImage({
    Key key,
    @required this.imageUrl, @required this.height, @required this.width,
  }) : super(key: key);

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      imageUrl: imageUrl ?? '',
      errorWidget: (context, url, error) =>
          // Icon(FontAwesomeIcons.image,size: 80,color: Theme.of(context).primaryColor,),
          Image.asset(
        'assets/images/image_placeholder.png',
        height: height,
        width: width,
      ),
      placeholder: (context, url) => Image.asset(
        'assets/images/image_placeholder.png',
        height: height,
        width: width,
      ),
    );
  }
}
