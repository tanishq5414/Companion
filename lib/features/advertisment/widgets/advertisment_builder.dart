import 'package:cached_network_image/cached_network_image.dart';
import 'package:companion/apis/advertisment_api.dart';
import 'package:companion/features/advertisment/controller/advertisment_controller.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

advertismentBuilder(Size size, context, WidgetRef ref, String place) {
  final advert = ref.read(advertisementsDataProvider);
  
  _launchURL(String url) async {
    final uri = Uri.parse(url);
    // ignore: deprecated_member_use
    await launch(url);
  }

  return (advert == null)?Container():ListView.builder(
      itemCount: (place == "home")?1:advert.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String image = advert[index].photoUrl!;
        String url = advert[index].redirectUrl!;
        return (advert[index].display! == false)?Container():(advert[index].size == "large" )
            ? largeAdvertisment(_launchURL, url, size, image)
            : advertismentSmallBuilder(
                _launchURL,
                url,
                size,
                image,
                advert[index].title!,
                advert[index].subititle!,
                advert[index].description!);
      });
}

Container largeAdvertisment(
    Future<Null> _launchURL(String url), String url, Size size, String image) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    child: ZoomTapAnimation(
      beginDuration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: () => _launchURL(url),
        child: SizedBox(
            width: size.width,
            height: size.width * 0.7,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                ))),
      ),
    ),
  );
}

InkWell advertismentSmallBuilder(
    Future<Null> _launchURL(String url),
    String url,
    Size size,
    String imageUrl,
    String title,
    String subtitle,
    String description) {
  return InkWell(
    onTap: () {
      _launchURL(url);
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        height: size.width * 0.4,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Pallete.greyColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Row(
            children: [
              Container(
                width: size.width * 0.4,
                height: size.width * 0.4,
                // decoration: BoxDecoration(
                //   color: Pallete.greyColor,
                //   borderRadius: BorderRadius.circular(15),
                // ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: size.width * 0.05),
              Container(
                width: size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: size.width * 0.3,
                      child: Text(
                        subtitle,
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: size.width * 0.3,
                      child: Text(
                        description,
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
