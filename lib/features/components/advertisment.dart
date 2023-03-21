// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:companion_rebuild/core/provider/advertisment_provider.dart';
import 'package:companion_rebuild/modal/advertisment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

List<Advertisment> advertlist = [];
ListView advertismentBuilder(Size size, context, WidgetRef ref) {
  final advert = ref.watch(advertismentDataProvider);
  getadvert() {
    advert.when(
      data: (advert) {
        advertlist = advert.map((e) => e).toList();
      },
      error: ((error, stackTrace) => Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
    return advertlist;
  }

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    print(url);
      // ignore: deprecated_member_use
      await launch(url);
  }

  return ListView.builder(
      itemCount: getadvert().length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var advertlist = getadvert();
        String image = advertlist[index].photoUrl;
        String url = advertlist[index].redirectLink;
        // print  (usercourses);
        return ZoomTapAnimation(
          child: InkWell(
            onTap: () => _launchURL(url),
            child: SizedBox(
                width: size.width,
                height: size.width * 0.7,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(image))),
          ),
        );
      });
}
