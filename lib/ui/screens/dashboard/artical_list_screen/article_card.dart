import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:zig_project/model/response/model_article.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({super.key, required this.article});
  Data? article;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: height * 0.16,
            child: Row(children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: SizedBox(
                      height: height * 0.16,
                      child: article?.jetpackFeaturedMediaUrl != null
                          ? Image.network(
                              article!.jetpackFeaturedMediaUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AssetsManager.placeholderImage,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article?.primaryCategory?.name ?? "",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: ColorManager.primary)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        article?.title?.rendered ?? "",
                        textAlign: TextAlign.left,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () async {
                              await launchUrl(
                                  Uri.parse(article?.canonicalUrl ?? ""),
                                  mode: LaunchMode.externalApplication);
                            },
                            child: Text("More >>"),
                            style: ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero))),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
    ;
  }
}
