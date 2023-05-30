import 'package:activity_click/activity_model.dart';
import 'package:activity_click/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  // void getData() async {
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
          ] else if (postMdl.listOfActivityModels.isEmpty) ...[
            Center(child: Image.asset('images/4-06.png'))
          ] else if (postMdl.listOfActivityModels.isNotEmpty &&
              postMdl.listOfActivityModels.last != null) ...[
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
                          title:
                              Text(postMdl.listOfActivityModels.last!.activity),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            const Text('Try one more!')
          ]
        ]),
      ),
    );
  }
}

class ActivityDataProvider with ChangeNotifier {
  List<ActivityModel?> listOfActivityModels = [];
  bool loading = false;
  void getData(context) async {
    loading = true;
    notifyListeners();
    listOfActivityModels.add((await ApiService().getActivity(context))!);
    loading = false;
    notifyListeners();
  }
}
