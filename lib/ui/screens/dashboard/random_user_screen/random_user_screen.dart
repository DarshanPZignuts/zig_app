import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:zig_project/bloc/network_cubit.dart';
import 'package:zig_project/controller/random_user_controller.dart';
import 'package:zig_project/model/response/model_random_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zig_project/resources/assets_manager.dart';

class RandomUserScreen extends StatefulWidget {
  const RandomUserScreen({super.key});

  @override
  State<RandomUserScreen> createState() => _RandomUserScreenState();
}

class _RandomUserScreenState extends State<RandomUserScreen> {
  RandomUserController? randomUserController;
  ModelRandomUser? user;
  bool isUserDataRecieved = false;
  void randomUser() async {
    if (isUserDataRecieved) return;
    isUserDataRecieved = true;
    ModelRandomUser? modelRandomUser =
        await randomUserController?.getRandomUser();
    setState(() {
      user = modelRandomUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    randomUserController = Provider.of<RandomUserController>(context);
    randomUserController?.networkCubit ??=
        BlocProvider.of<NetworkCubit>(context);
    randomUser();
    return SafeArea(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              user?.results!.first.picture?.large == null
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(AssetsManager.placeholderImage),
                    )
                  : Image.network(user?.results!.first.picture?.large ?? ""),
              Text(user?.results!.first.name!.first ?? "Loading"),
            ],
          ),
        ),
      ),
    );
  }
}
