import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/modules/edit_profile/edit_screen.dart';
import 'package:social/modules/new_post/new_post_screen.dart';
import 'package:social/shared/adaptive/adaptivw_indicator.dart';
import 'package:social/shared/components/componets.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              cubit.userModel != null
                  ? InkWell(
                      onTap: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: CircleAvatar(
                        radius: 24,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(cubit.userModel!.image),
                        ),
                      ),
                    )
                  : Center(
                      child: AdaptiveIndicator(
                        os: getOS(),
                      ),
                    ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
