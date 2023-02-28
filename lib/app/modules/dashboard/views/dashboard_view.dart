import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ujikom/app/data/headline_response.dart';
import 'package:ujikom/app/data/sport_response.dart';
import 'package:ujikom/app/data/technology_response.dart';
import 'package:ujikom/app/data/entertaiment_response.dart';
import 'package:ujikom/app/modules/home/views/home_view.dart';
import '../controllers/dashboard_controller.dart';
import 'package:get_storage/get_storage.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();
    final auth = GetStorage();
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "Hallo!",
                    textAlign: TextAlign.end,
                  ),
                  subtitle: Text(
                    auth.read('full_name').toString(),
                    textAlign: TextAlign.end,
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 50.0,
                    height: 50.0,
                    child: Lottie.network(
                      'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: "Headline"),
                      Tab(text: "Teknologi"),
                      Tab(text: "Olahraga"),
                      Tab(text: "Hiburan"),
                      Tab(text: "Profile"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              headline(controller, scrollController),
              technology(controller, scrollController),
              sports(controller, scrollController),
              entertainment(controller, scrollController),
              profile(controller, scrollController),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     await auth.erase();
          //     Get.offAll(() => const HomeView());
          //   },
          //   backgroundColor: Colors.redAccent,
          //   child: const Icon(Icons.logout_rounded),
          // ),
        ),
      ),
    );
  }

  FutureBuilder<HeadlineResponse> headline(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<HeadlineResponse>(
      future: controller.getHeadline(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Lottie.network(
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ));
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Tidak ada data'),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 8,
                  left: 8,
                  bottom: 5,
                ),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.data![index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Author : ${snapshot.data!.data![index].author}'),
                              Text(
                                  'Name : ${snapshot.data!.data![index].name}'),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  FutureBuilder<TechnologyResponse> technology(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<TechnologyResponse>(
      future: controller.getTechnology(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Lottie.network(
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ));
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Tidak ada data'),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 8,
                  left: 8,
                  bottom: 5,
                ),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.data![index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Author : ${snapshot.data!.data![index].author}'),
                              Text(
                                  'Name : ${snapshot.data!.data![index].name}'),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  FutureBuilder<SportResponse> sports(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<SportResponse>(
      future: controller.getSport(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Lottie.network(
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ));
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Tidak ada data'),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 8,
                  left: 8,
                  bottom: 5,
                ),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.data![index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Author : ${snapshot.data!.data![index].author}'),
                              Text(
                                  'Name : ${snapshot.data!.data![index].name}'),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  FutureBuilder<EntertainmentResponse> entertainment(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<EntertainmentResponse>(
      future: controller.getEntertaiment(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Lottie.network(
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ));
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Tidak ada data'),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 8,
                  left: 8,
                  bottom: 5,
                ),
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data!.data![index].urlToImage.toString(),
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.data![index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Author : ${snapshot.data!.data![index].author}'),
                              Text(
                                  'Name : ${snapshot.data!.data![index].name}'),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  Widget profile(
      DashboardController controller, ScrollController scrollController) {
    final auth = GetStorage();
    return Container(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/56459378?v=4'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  auth.read('full_name').toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Gatau Apaan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                  title: const Text('Logout'),
                  onTap: () async {
                    await auth.erase();
                    Get.offAll(() => const HomeView());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
