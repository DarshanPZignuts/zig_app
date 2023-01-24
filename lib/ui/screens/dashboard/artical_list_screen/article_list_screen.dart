import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zig_project/bloc/network_cubit.dart';

import 'package:zig_project/controller/article_controller.dart';
import 'package:zig_project/model/response/model_article.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/services/check_connetion.dart';
import 'package:zig_project/ui/screens/dashboard/artical_list_screen/article_card.dart';
import 'package:zig_project/ui/widgets/shimmer.dart';
import 'package:zig_project/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ArticalList extends StatefulWidget {
  const ArticalList({super.key});

  @override
  State<ArticalList> createState() => _ArticalListState();
}

class _ArticalListState extends State<ArticalList> {
  // ArticleController? articleController;

  // ModelArticles? articles;
  // void getArticleData() async {
  //   ModelArticles? _articles = await articleController?.getArticle();
  //   setState(() {
  //     articles = _articles;
  //   });
  // }
  bool isConnection = false;
  ArticleController articleController = ArticleController();
  checkConnectivity() async {
    isConnection = await CheckConnection.checkInternetConnection();
    setState(() {
      isConnection;
    });
  }

  @override
  void initState() {
    checkConnectivity();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    // articleController = Provider.of<ArticleController>(context);
    // articleController?.networkCubit ??= BlocProvider.of<NetworkCubit>(context);
    // getArticleData();
    return isConnection
        ? FutureBuilder(
            future: articleController.getArticle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: snapshot.data?.data?.length,
                    itemBuilder: (context, index) {
                      Data article = snapshot.data!.data!.elementAt(index);
                      return ArticleCard(
                        article: article,
                      );
                    });
              } else {
                return ShimmerWidget();
              }
            })
        : Center(
            child: Container(
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.network_cell_sharp,
                      size: 40, color: ColorManager.grey),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No Internet Connecion. Please check your settings and try again.",
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                      onPressed: () => checkConnectivity(),
                      child: Text("Retry"))
                ],
              ),
            ),
          );
  }
}
