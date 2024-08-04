import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/user/data/models/user_model.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/get_authenticated_user_usecase.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/logout_usecase.dart';

class HomePageData {
  final String route;
  final bool loggingOut;
  final UserEntity user;

  HomePageData({
    required this.route,
    required this.loggingOut,
    required this.user,
  });

  HomePageData copyWith({
    String? route,
    bool? loggingOut,
    UserEntity? user,
  }) {
    return HomePageData(
      route: route ?? this.route,
      loggingOut: loggingOut ?? this.loggingOut,
      user: user ?? this.user,
    );
  }
}

class HomePageMethods {
  final Widget Function(BuildContext context) pageViewer;
  final void Function(String route) goToRoute;
  final bool Function() showBackButton;
  final void Function() onPop;
  final void Function() logout;
  final void Function() loadUser;

  HomePageMethods({
    required this.pageViewer,
    required this.goToRoute,
    required this.showBackButton,
    required this.onPop,
    required this.logout,
    required this.loadUser,
  });
}

class HomePageController extends AppController<HomePageData, HomePageMethods> {
  late final LogoutUseCase _logoutUseCase;
  late final GetAuthenticatedUserUseCase _getAuthenticatedUserUseCase;
  HomePageController(
    final LogoutUseCase logoutUseCase,
    final GetAuthenticatedUserUseCase getAuthenticatedUserUseCase,
  ) {
    _getAuthenticatedUserUseCase = getAuthenticatedUserUseCase;
    _logoutUseCase = logoutUseCase;
    methods.loadUser();
    methods.goToRoute(data.route);
  }

  @override
  HomePageMethods defineMethods() {
    return HomePageMethods(
      goToRoute: (route) {
        if (Modular.to.canPop()) {
          Modular.to.pop();
        }
        updateData(
          data.copyWith(
            route: route,
          ),
        );
        Modular.to.navigate(data.route);
      },
      pageViewer: (context) {
        return const RouterOutlet();
      },
      onPop: () {
        final history = Modular.to.navigateHistory;
        final String route = history.last.name;
        final List<String> routeWithoutParams = route
            .split('/')
            .where((path) => path.isNotEmpty && !path.contains(':'))
            .toList();
        final List<String> newRoute = routeWithoutParams..removeLast();
        if (newRoute.length == 2) {
          Modular.to.navigate('/${newRoute.join('/')}/');
        }
      },
      showBackButton: () {
        final route = Modular.to.navigateHistory.last.name;
        return route.split('/').where((path) => path.isNotEmpty).length > 2;
      },
      logout: () async {
        updateData(
          data.copyWith(
            loggingOut: true,
          ),
        );
        try {
          await _logoutUseCase();
          Modular.to.pushNamedAndRemoveUntil('/auth/login/', (route) => false);
        } catch (e) {
          if (e is AppError) {
            catchError(e);
          }
        }
        updateData(
          data.copyWith(
            loggingOut: false,
          ),
        );
      },
      loadUser: () async {
        try {
          final user = await _getAuthenticatedUserUseCase();
          updateData(
            data.copyWith(
              user: user,
            ),
          );
        } catch (e) {
          if (e is AppError) {
            catchError(e);
          }
        }
      },
    );
  }

  @override
  HomePageData defineData() {
    return HomePageData(
      route: '/home/main/',
      loggingOut: false,
      user: UserModel(
        id: '',
        admin: false,
        name: '',
        surname: '',
        birthday: UserBirthday(
          day: '',
          month: '',
          year: '',
        ),
        cpf: '',
        email: '',
        verifiedEmail: false,
        createdAt: DateTime.now(),
      ),
    );
  }
}
