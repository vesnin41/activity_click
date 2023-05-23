import 'package:activity_click/activity_model.dart';
import 'package:activity_click/api_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ActivityModel? activityModel;
  bool proccessing = false;
  @override
  void initState() {
    super.initState();
    activityModel = null;
  }

  void getData() async {
    activityModel = (await ApiService().getActivity());
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => {getData()},
        label: const Text('Click and Go!'),
        icon: const Icon(Icons.ads_click),
      ),
      body: SafeArea(
        child: activityModel == null
            ? Image.asset('images/4-06.png')
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      activityModel!.type.toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.sports_sharp),
                            title: Text(activityModel!.activity),
                          ),
                          ListTile(
                            leading: const Icon(Icons.groups),
                            title: Text(activityModel!.participants.toString()),
                          ),
                          ListTile(
                            leading: Icon(Icons.price_change_rounded),
                            title: Text(activityModel!.price.toString()),
                          ),
                          ListTile(
                            leading: const Text("Accessibility: "),
                            title:
                                Text(activityModel!.accessibility.toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
