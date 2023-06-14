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
                            leading: const Icon(Icons.sports_sharp),
                            title: Text(
                                postMdl.listOfActivityModels.last!.activity),
                          ),
                          ListTile(
                            leading: const Icon(Icons.groups),
                            title: Text(postMdl
                                .listOfActivityModels.last!.participants
                                .toString()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.price_change_rounded),
                            title: Text(postMdl.listOfActivityModels.last!.price
                                .toString()),
                          ),
                          ListTile(
                            leading: const Text("Accessibility: "),
                            title: Text(postMdl
                                .listOfActivityModels.last!.accessibility
                                .toString()),
                          ),
                          // ignore: unrelated_type_equality_checks
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              postMdl.listOfActivityModels.last!.link != ''
                                  ? IconButton(
                                      onPressed: () {
                                        final Uri _url = Uri.parse(postMdl
                                            .listOfActivityModels.last!.link);
                                        launchInWebViewOrVC(_url);
                                      },
                                      icon: const Icon(Icons.open_in_browser,
                                          size: 35),
                                      tooltip: "Open link",
                                    )
                                  : const SizedBox(),
                              IconButton(
                                  onPressed: () {
                                    postMdl.listOfActivityModels.last!
                                            .isFavorite
                                        ? postMdl.unlikeActivity(
                                            postMdl.listOfActivityModels.last!)
                                        : postMdl.likeActivity(
                                            postMdl.listOfActivityModels.last!);
                                  },
                                  icon: postMdl
                                          .listOfActivityModels.last!.isFavorite
                                      ? const Icon(
                                          Icons.favorite,
                                          size: 35,
                                        )
                                      : const Icon(Icons.favorite_outline,
                                          size: 35),
                                  color: Colors.red,
                                  tooltip: "Add to favorite")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ]),
        ),
      ),
    );
  }
}
