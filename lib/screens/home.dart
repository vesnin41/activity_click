import 'package:activity_click/providers/activity_data_provider.dart';
import 'package:activity_click/screens/favorite_activities.dart';
import 'package:activity_click/screens/history_activities.dart';
import 'package:activity_click/utilities/launch_link.dart';
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryActivities()),
                );
              },
              icon: const Icon(Icons.history)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteActivities()),
                );
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Modal BottomSheet'),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
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
            ] else if (postMdl.listOfActivityModels.isEmpty) ...[
              Center(child: Image.asset('images/4-06.png'))
            ] else if (postMdl.listOfActivityModels.isNotEmpty) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      postMdl.listOfActivityModels.last!.type,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.sports_sharp,
                              size: 35,
                            ),
                            title: Text(
                              postMdl.listOfActivityModels.last!.activity,
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
                              "Participants: ${postMdl.listOfActivityModels.last!.participants}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.price_change_rounded,
                              size: 35,
                            ),
                            title: Text(
                              "Price: ${postMdl.listOfActivityModels.last!.price}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.extension,
                              size: 35,
                            ),
                            title: Text(
                              "Accessibility: ${postMdl.listOfActivityModels.last!.accessibility}",
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
                      postMdl.listOfActivityModels.last!.link != ''
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  final Uri _url = Uri.parse(
                                      postMdl.listOfActivityModels.last!.link);
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
                            postMdl.listOfActivityModels.last!.isFavorite
                                ? postMdl.unlikeActivity(
                                    postMdl.listOfActivityModels.last!)
                                : postMdl.likeActivity(
                                    postMdl.listOfActivityModels.last!);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            // <-- Splash color
                          ),
                          child: postMdl.listOfActivityModels.last!.isFavorite
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
