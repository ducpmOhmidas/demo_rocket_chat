import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:flutter_application/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_application/presentation/blocs/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../design_system_widgets/app_loading_widget.dart';
import '../../initialize_dependencies.dart';

class UserAvatarWidget extends StatefulWidget {
  const UserAvatarWidget(
      {Key? key, this.width = 54, this.height = 54, required this.profile})
      : super(key: key);
  final ProfileEntity profile;
  final double width;
  final double height;

  @override
  State<UserAvatarWidget> createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(profile: widget.profile, userService: sl.get()),
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        return state.when(
            (profile, avatarPath) => Image.file(
                  File(avatarPath),
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                ),
            loading: () => Container(
                  color: Colors.black,
                  width: widget.width,
                  height: widget.height,
                  child: AppLoadingWidget(),
                ),
            error: (e) => Container(
                  color: Colors.black,
                  width: widget.width,
                  height: widget.height,
                  child: AppLoadingWidget(),
                ));
      }),
    );
  }
}
