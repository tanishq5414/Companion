import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/advertisment_provider.dart';
import 'package:notesapp/modal/advertisment.dart';
import 'package:url_launcher/url_launcher.dart';

List<Advertisment> advertlist = [];
ListView advertismentBuilder(Size size, context, WidgetRef ref) {
  final advert = ref.watch(advertismentDataProvider);
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
  _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  return ListView.builder(
      itemCount: 1,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String image = advertlist[0].photoUrl;
        String url = advertlist[0].redirectLink;
        // print  (usercourses);
        return InkWell(
          onTap: () => _launchURL(url),
          child: SizedBox(
              width: size.width,
              height: size.width * 0.7,
              child: ClipRRect(borderRadius: BorderRadius.circular(20.0),child: Image.network(image))),
        );
      });
}