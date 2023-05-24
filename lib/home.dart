import 'package:activity_click/activity_model.dart';
import 'package:activity_click/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  // void getData() async {
  //   activityModel = (await ApiService().getActivity());
  //   Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {}));
  // }

  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<ActivityDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Do not be lazy!',
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Provider.of<ActivityDataProvider>(context, listen: false)
              .getData(context)
        },
        label: const Text('Click and Go!'),
        icon: const Icon(Icons.ads_click),
      ),
      body: SafeArea(
        child: Column(children: [
          if (postMdl.loading == true) ...[
            const CircularProgressIndicator()
          ] else ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    postMdl.activityModel!.type!.toUpperCase(),
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
                          title: Text(postMdl.activityModel!.activity!),
                        ),
                        ListTile(
                          leading: const Icon(Icons.groups),
                          title: Text(
                              postMdl.activityModel!.participants.toString()),
                        ),
                        ListTile(
                          leading: const Icon(Icons.price_change_rounded),
                          title: Text(postMdl.activityModel!.price.toString()),
                        ),
                        ListTile(
                          leading: const Text("Accessibility: "),
                          title: Text(
                              postMdl.activityModel!.accessibility.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]
        ]),
      ),
    );
  }
}

class ActivityDataProvider with ChangeNotifier {
  ActivityModel? activityModel = ActivityModel();
  bool loading = false;
  void getData(context) async {
    loading = true;
    activityModel = await ApiService().getActivity(context);
    loading = false;

    notifyListeners();
  }
}
