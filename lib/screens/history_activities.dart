import 'package:activity_click/models/activity_model.dart';
import 'package:activity_click/providers/activity_data_provider.dart';
import 'package:activity_click/utilities/launch_link.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryActivities extends StatefulWidget {
  const HistoryActivities({super.key});

  @override
  State<HistoryActivities> createState() => _HistoryActivitiesState();
}

class _HistoryActivitiesState extends State<HistoryActivities> {
  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<ActivityDataProvider>(context);
    final List<ActivityModel?> reversedListActivities =
        postMdl.listOfActivityModels.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => postMdl.clearData(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: postMdl.listOfActivityModels.isNotEmpty
            ? ListView.builder(
                itemCount: reversedListActivities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.sports_sharp),
                          title: Text(reversedListActivities[index]!.activity),
                        ),
                        ListTile(
                          leading: const Icon(Icons.groups),
                          title: Text(reversedListActivities[index]!
                              .participants
                              .toString()),
                        ),
                        ListTile(
                          leading: const Icon(Icons.price_change_rounded),
                          title: Text(
                              reversedListActivities[index]!.price.toString()),
                        ),
                        ListTile(
                          leading: const Text("Accessibility: "),
                          title: Text(reversedListActivities[index]!
                              .accessibility
                              .toString()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            reversedListActivities[index]!.link != ''
                                ? IconButton(
                                    onPressed: () {
                                      final Uri _url = Uri.parse(
                                          reversedListActivities[index]!.link);
                                      launchInWebViewOrVC(_url);
                                    },
                                    icon: const Icon(Icons.open_in_browser,
                                        size: 35),
                                    tooltip: "Open link",
                                  )
                                : const SizedBox(),
                            IconButton(
                                onPressed: () {
                                  reversedListActivities[index]!.isFavorite
                                      ? postMdl.unlikeActivity(
                                          reversedListActivities[index]!)
                                      : postMdl.likeActivity(
                                          reversedListActivities[index]!);
                                },
                                icon: reversedListActivities[index]!.isFavorite
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
                  );
                },
              )
            : const Center(child: Text('No items')),
      ),
    );
  }
}
