import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/view/splash/splash_page.dart';

void main() {
  // SPManager.getThemeDark();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SPManager.getThemeDark()
    return getView(context);
    // return
    //   ScopedModel(
    //   model: ThemeModel(),
    //   child: getView(),
    // );
  }

  Widget getView(BuildContext context) {
    return
      // ScopedModelDescendant<ThemeModel>(
      //   builder: (context, _, model) =>
        MaterialApp(
              title: StringConst.APP_NAME,
              debugShowCheckedModeBanner: false,
              // darkTheme: ThemeData(brightness: Brightness.dark),
              theme: ThemeData(brightness: isDarkMode() ?Brightness.dark:Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: AssetsConst.ZILLASLAB_FONT,
                  // accentColor: ColorConst.APP_COLOR,
                  // accentColorBrightness: Brightness.light,
                  primarySwatch: ColorConst.APP_COLOR,),
              // darkTheme: model.getTheme != null ? ThemeData(brightness: Brightness.dark):ThemeData(brightness: Brightness.light),
              // theme: ThemeData(
              //   brightness: Brightness.light,
              //   fontFamily: AssetsConst.ZILLASLAB_FONT,
              //   accentColor: ColorConst.APP_COLOR,
              //   accentColorBrightness: Brightness.light,
              //   primarySwatch: ColorConst.APP_COLOR,
              // ),
          home: SplashPage(),
          // initialRoute: SplashPage.route,
          // routes: <String, WidgetBuilder>{
          //   // Set routes for using the Navigator.
          //   '/home': (BuildContext context) =>  HomeScreen(),
          //   '/splash': (BuildContext context) =>  SplashPage()
          // },
            // )
    );
  }
}











// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Custom Named Routes Example',
//       initialRoute: HomePage.route,
//       onGenerateRoute: RouteConfiguration.onGenerateRoute,
//     ),
//   );
// }
//
// class Path {
//   const Path(this.pattern, this.builder);
//
//   /// A RegEx string for route matching.
//   final String pattern;
//
//   /// The builder for the associated pattern route. The first argument is the
//   /// [BuildContext] and the second argument is a RegEx match if it is
//   /// included inside of the pattern.
//   final Widget Function(BuildContext, String) builder;
// }
//
// class RouteConfiguration {
//   /// List of [Path] to for route matching. When a named route is pushed with
//   /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
//   /// in the list below. As soon as there is a match, the associated builder
//   /// will be returned. This means that the paths higher up in the list will
//   /// take priority.
//   static List<Path> paths = [
//     Path(
//       r'^' + ArticlePage.baseRoute + r'/([\w-]+)$',
//           (context, match) => Article.getArticlePage(match),
//     ),
//     Path(
//       r'^' + OverviewPage.route,
//           (context, match) => OverviewPage(),
//     ),
//     Path(
//       r'^' + HomePage.route,
//           (context, match) => HomePage(),
//     ),
//   ];
//
//   /// The route generator callback used when the app is navigated to a named
//   /// route. Set it on the [MaterialApp.onGenerateRoute] or
//   /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
//   /// matching.
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     for (Path path in paths) {
//       final regExpPattern = RegExp(path.pattern);
//       if (regExpPattern.hasMatch(settings.name)) {
//         final firstMatch = regExpPattern.firstMatch(settings.name);
//         final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
//         return MaterialPageRoute<void>(
//           builder: (context) => path.builder(context, match),
//           settings: settings,
//         );
//       }
//     }
//
//     // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
//     return null;
//   }
// }
//
// // In a real application this would probably be some kind of database interface.
// const List<Article> articles = [
//   Article(
//     title: 'A very interesting article',
//     slug: 'a-very-interesting-article',
//   ),
//   Article(
//     title: 'Newsworthy news',
//     slug: 'newsworthy-news',
//   ),
//   Article(
//     title: 'RegEx is cool',
//     slug: 'regex-is-cool',
//   ),
// ];
//
// class Article {
//   const Article({this.title, this.slug});
//
//   final String title;
//   final String slug;
//
//   static Widget getArticlePage(String slug) {
//     for (Article article in articles) {
//       if (article.slug == slug) {
//         return ArticlePage(article: article);
//       }
//     }
//     return UnknownArticle();
//   }
// }
//
// class ArticlePage extends StatelessWidget {
//   const ArticlePage({Key key, this.article}) : super(key: key);
//
//   static const String baseRoute = '/article';
//   static String Function(String slug) routeFromSlug =
//       (String slug) => baseRoute + '/$slug';
//
//   final Article article;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(article.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(article.title),
//             RaisedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Go back!'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class UnknownArticle extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Unknown article'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Unknown article'),
//             RaisedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Go back!'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class OverviewPage extends StatelessWidget {
//   static const String route = '/overview';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Overview Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             for (Article article in articles)
//               RaisedButton(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed(
//                     ArticlePage.routeFromSlug(article.slug),
//                   );
//                 },
//                 child: Text(article.title),
//               ),
//             RaisedButton(
//               onPressed: () {
//                 // Navigate back to the home screen by popping the current route
//                 // off the stack.
//                 Navigator.pop(context);
//               },
//               child: Text('Go back!'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   static const String route = '/';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Overview page'),
//           onPressed: () {
//             // Navigate to the overview page using a named route.
//             Navigator.pushNamed(context, OverviewPage.route);
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
