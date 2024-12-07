import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: PathRouter.splash,
  routes: [
    GoRoute(
      path: PathRouter.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: PathRouter.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: PathRouter.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: PathRouter.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: PathRouter.recoveryPassword,
      builder: (context, state) => const RecoveryPassword(),
    ),
    GoRoute(
      path: PathRouter.activeAccount,
      builder: (context, state) => const ActiveAccountPage(),
    ),
    GoRoute(
      path: PathRouter.description,
      builder: (context, state) => const DescriptionPage(),
    ),
    GoRoute(
      path: PathRouter.information,
      builder: (context, state) => const InformationPage(),
    ),
    GoRoute(
      path: PathRouter.saleRent,
      builder: (context, state) => const SaleRentPage(),
    ),
    GoRoute(
      path: PathRouter.loadImages,
      builder: (context, state) => const LoadImagesPage(),
    ),
    GoRoute(
      path: PathRouter.category,
      builder: (context, state) => const CategoryPage(),
    ),
    GoRoute(
      path: PathRouter.publishPage,
      builder: (context, state) => const PublishPage(),
    ),
    GoRoute(
      path: PathRouter.requestPage,
      builder: (context, state) => const RequestPage(),
    ),
    GoRoute(
      path: PathRouter.welcomePage,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: PathRouter.terrenosPage,
      builder: (context, state) => const TerrenoPage(),
    ),
    GoRoute(
      path: PathRouter.matchsPage,
      builder: (context, state) => const MatchsPage(),
    ),
    GoRoute(
      path: PathRouter.misMatchsPage,
      builder: (context, state) => const MisMatchsPage(),
    ),
    GoRoute(
        path: PathRouter.pricePage,
        builder: (context, state) {
          Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
          return PricePage(
              listMunicipalitiesString: extra['arg1'],
              listColoniesString: extra['arg2']);
        } // const PricePage(listMunicipalitiesString: state.extra[0], listColoniesString: []),
        ),
    GoRoute(
      path: PathRouter.perfilPage,
      builder: (context, state) => const PerfilScreen(),
    ),
    GoRoute(
      path: PathRouter.attendedPage,
      builder: (context, state) => const AttendedPage(),
    ),
  ],
);
