import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class HomeMenuAvatar extends StatelessWidget {
  final UserEntity user;
  final void Function() onLogout;
  final bool loggingOut;
  const HomeMenuAvatar({
    required this.user,
    required this.onLogout,
    required this.loggingOut,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => HomeAppBarAvatarMenu(
            user: user,
            onLogout: onLogout,
            loggingOut: loggingOut,
          ),
        );
      },
      child: CircleAvatar(
        child: Text(
          userInitialLetters(user),
        ),
      ),
    );
  }
}

class HomeAppBarAvatarMenu extends StatelessWidget {
  final UserEntity user;
  final bool loggingOut;
  final void Function() onLogout;
  const HomeAppBarAvatarMenu({
    required this.user,
    required this.onLogout,
    required this.loggingOut,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderless: true,
      actions: [
        FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.red,
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Center(
                  child: AppCard(
                    titleText: 'Do you want to log out?',
                    loading: loggingOut,
                    width: 300,
                    actions: [
                      FilledButton(
                        onPressed: loggingOut
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: loggingOut ? null : () => onLogout(),
                        style: loggingOut
                            ? null
                            : ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.red,
                                ),
                              ),
                        child: Text(
                          'Log out',
                          style: loggingOut
                              ? null
                              : const TextStyle(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Text(
            'Log out',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                child: Text(userInitialLetters(user)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${user.name} ${user.surname}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String userInitialLetters(UserEntity user) {
  if (user.name.isEmpty || user.surname.isEmpty) {
    return '';
  }
  return '${user.name[0]}${user.surname[0]}';
}
