import 'package:activity_click/models/activity_model.dart';
import 'package:activity_click/providers/activity_data_provider.dart';
import 'package:activity_click/utilities/launch_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class FavoriteActivities extends StatefulWidget {
  const FavoriteActivities({super.key});

  @override
  State<FavoriteActivities> createState() => _FavoriteActivitiesState();
}

class _FavoriteActivitiesState extends State<FavoriteActivities> {
  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<ActivityDataProvider>(context);
    final List<ActivityModel?> reversedListActivities =
        postMdl.listOfFavoriteActivities.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => postMdl.clearFavorites(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: postMdl.listOfFavoriteActivities.isNotEmpty
            ? ListView.builder(
                itemCount: reversedListActivities.length,
                itemBuilder: (BuildContext context, int index) {
                  void unlikeActivity(BuildContext context) {
                    postMdl.unlikeActivity(reversedListActivities[index]!);
                  }

                  if (reversedListActivities[index]!.isFavorite) {
                    return Slidable(
                      key: UniqueKey(),
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(
                          onDismissed: () => postMdl
                              .unlikeActivity(reversedListActivities[index]!),
                        ),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: unlikeActivity,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.thumb_down,
                            label: 'Dislike',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () => postMdl
                              .unlikeActivity(reversedListActivities[index]!),
                        ),
                        children: [
                          SlidableAction(
                            onPressed: unlikeActivity,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.thumb_down,
                            label: 'Dislike',
                          )
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    icon: reversedListActivities[index]!
                                            .isFavorite
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
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(child: Text('No items')),
      ),
    );
  }
}
