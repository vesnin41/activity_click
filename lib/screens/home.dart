import 'package:activity_click/providers/activity_data_provider.dart';
import 'package:activity_click/screens/favorite_activities.dart';
import 'package:activity_click/screens/history_activities.dart';
import 'package:activity_click/utilities/launch_link.dart';
import 'package:activity_click/widgets/tune_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<ActivityDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Don't be lazy!",
        ),
        actions: [
          IconButton(
              onPressed: () {
                postMdl.getActivitiesDB();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryActivities()),
                );
              },
              icon: const Icon(Icons.history)),
          IconButton(
              onPressed: () {
                postMdl.getFavoriteActivitiesDB().then((value) {
                  if (postMdl.listOfFavoriteActivities.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoriteActivities()),
                    );
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Add favorite activities!'),
                      duration: Duration(milliseconds: 1500),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              icon: const Icon(Icons.favorite))
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: "f1",
            onPressed: () => {
              Provider.of<ActivityDataProvider>(context, listen: false)
                  .getData()
            },
            label: const Text('Click!'),
            icon: const Icon(Icons.ads_click),
          ),
          const SizedBox(
            height: 30,
          ),
          FloatingActionButton.extended(
            heroTag: "f2",
            onPressed: () => {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const TuneSheet();
                },
              ),
            },
            label: const Text('Tune!'),
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(children: [
            if (postMdl.loading == true) ...[
              const Center(
                  heightFactor: 5.0, child: CircularProgressIndicator())
            ] else if (postMdl.model == null) ...[
              Center(child: Image.asset('images/4-06.png'))
            ] else if (postMdl.model != null) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Text(
                              postMdl.model!.type.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.sports_sharp,
                              size: 35,
                            ),
                            title: Text(
                              postMdl.model!.activity,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(
                              Icons.groups,
                              size: 35,
                            ),
                            title: Text(
                              "Participants: ${postMdl.model!.participants}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.price_change_rounded,
                              size: 35,
                            ),
                            title: Text(
                              "Price: ${postMdl.model!.price}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.extension,
                              size: 35,
                            ),
                            title: Text(
                              "Accessibility: ${postMdl.model!.accessibility}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          // ignore: unrelated_type_equality_checks
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      postMdl.model!.link != ''
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  final Uri _url =
                                      Uri.parse(postMdl.model!.link);
                                  launchInWebViewOrVC(_url);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  // <-- Splash color
                                ),
                                child:
                                    const Icon(Icons.open_in_browser, size: 35),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            postMdl.model!.isFavorite
                                ? postMdl.unlikeActivity(postMdl.model!)
                                : postMdl.likeActivity(postMdl.model!);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            // <-- Splash color
                          ),
                          child: postMdl.model!.isFavorite
                              ? const Icon(
                                  Icons.favorite,
                                  size: 35,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_outline,
                                  size: 35, color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ]),
        ),
      ),
    );
  }
}
