import 'package:activity_click/models/activity_model.dart';
import 'package:activity_click/providers/activity_data_provider.dart';
import 'package:activity_click/utilities/launch_link.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                  void likeActivity(BuildContext context) {
                    postMdl.likeActivity(reversedListActivities[index]!);
                  }

                  void unlikeActivity(BuildContext context) {
                    postMdl.unlikeActivity(reversedListActivities[index]!);
                  }

                  Future<void> deleteActivity(BuildContext context) async {
                    postMdl.deleteActivity(reversedListActivities[index]!);
                  }

                  return Slidable(
                    key: UniqueKey(),
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(
                        onDismissed: () => postMdl
                            .deleteActivity(reversedListActivities[index]!),
                      ),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: deleteActivity,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        reversedListActivities[index]!.isFavorite
                            ? SlidableAction(
                                onPressed: unlikeActivity,
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.thumb_down,
                                label: 'Dislike',
                              )
                            : SlidableAction(
                                onPressed: likeActivity,
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.thumb_up,
                                label: 'Like',
                              ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(
                        onDismissed: () => postMdl
                            .deleteActivity(reversedListActivities[index]!),
                      ),

                      children: [
                        reversedListActivities[index]!.isFavorite
                            ? SlidableAction(
                                onPressed: unlikeActivity,
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.thumb_down,
                                label: 'Dislike',
                              )
                            : SlidableAction(
                                onPressed: likeActivity,
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.thumb_up,
                                label: 'Like',
                              ),
                        SlidableAction(
                          onPressed: deleteActivity,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.sports_sharp),
                            title:
                                Text(reversedListActivities[index]!.activity),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.local_activity),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(reversedListActivities[index]!
                                        .type
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.groups),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(reversedListActivities[index]!
                                        .participants
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.price_change_rounded),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(reversedListActivities[index]!
                                        .price
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.extension),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(reversedListActivities[index]!
                                        .accessibility
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              reversedListActivities[index]!.link != ''
                                  ? IconButton(
                                      onPressed: () {
                                        final Uri _url = Uri.parse(
                                            reversedListActivities[index]!
                                                .link);
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
                                  icon:
                                      reversedListActivities[index]!.isFavorite
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
                  );
                },
              )
            : const Center(child: Text('No items')),
      ),
    );
  }
}
