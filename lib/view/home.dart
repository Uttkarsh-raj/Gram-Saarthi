import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/const/colors.dart';
import 'package:hackathon/view/contact.dart';
import 'package:hackathon/view/eplore_emp.dart';
import 'package:hackathon/view/explore_market.dart';
import 'package:hackathon/view/grievances/greivances.dart';
import 'package:hackathon/view/inventory.dart';
import 'package:hackathon/view/schedule.dart';
import 'package:hackathon/widgets/banner_list.dart';
import 'package:hackathon/widgets/events_widget.dart';
import 'package:hackathon/widgets/explore_widget.dart';
import 'package:hackathon/widgets/grey_space.dart';
import 'package:hackathon/widgets/panchayat_list.dart';
import 'package:hackathon/widgets/search_widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> labels = [
    "Greivances",
    "Inventory",
    "Contact",
    "Schedule"
  ];
  final List<String> icons = [
    'assets/icons/checklist.png',
    'assets/icons/inventory.png',
    'assets/icons/contacts.png',
    'assets/icons/calendar.png',
  ];
  dynamic data;
  bool loaded = false;

  void getEvents() async {
    setState(() {
      loaded = false;
    });
    var res = await http.get(
      Uri.parse('https://gramsarthi.vercel.app/api/events/rampur'),
    );
    var d = jsonDecode(res.body);
    data = d["data"];
    print(data);
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(16.0).copyWith(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.green,
                              radius: size.height * 0.03,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white,
                                radius: size.height * 0.028,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.orange,
                                  radius: size.height * 0.026,
                                  child: CircleAvatar(
                                    backgroundImage: const AssetImage(
                                        'assets/images/john doe.jpeg'),
                                    radius: size.height * 0.024,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rajesh Sharma',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blue,
                                    fontSize: 18,
                                    // color:
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: AppColors.blue,
                                      size: 14,
                                    ),
                                    Text(
                                      'Rampur',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blue,
                                        fontSize: 14,
                                        // color:
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const Icon(
                          Icons.logout_outlined,
                          color: AppColors.blue,
                          size: 25,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    const SearchWidget(),
                    SizedBox(height: size.height * 0.019),
                    const Text(
                      'Ongoing Events',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.blue,
                        fontSize: 20,
                        // color:
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    (loaded)
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.23,
                            child: Swiper(
                              itemCount: 3,
                              autoplay: true,
                              itemBuilder: (context, index) {
                                return BannersListTile(
                                  imageUrl: data[index]['image'],
                                  name: data[index]['name'],
                                );
                              },
                              pagination: const SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                  activeColor: Colors.red,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
              const GreySpace(),
              Padding(
                padding:
                    const EdgeInsets.all(16.0).copyWith(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Panchayat',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.blue,
                            fontSize: 20,
                            // color:
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'View All',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //         color: AppColors.blue,
                        //         fontSize: 14,
                        //         // color:
                        //       ),
                        //     ),
                        //     Icon(
                        //       Icons.arrow_forward_outlined,
                        //       color: AppColors.blue,
                        //       size: 16,
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    SizedBox(
                      height: size.height * 0.135,
                      child: ListView.separated(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: PanchayatList(
                            icon: icons[index],
                            label: labels[index],
                            onTap: () {
                              if (index == 0) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const GrievancesPage(),
                                  ),
                                );
                              } else if (index == 1) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Inventory(),
                                  ),
                                );
                              } else if (index == 2) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ContactsPage(),
                                  ),
                                );
                              } else if (index == 3) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Schedules(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
              const GreySpace(),
              Padding(
                padding:
                    const EdgeInsets.all(16.0).copyWith(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Events',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.blue,
                            fontSize: 20,
                            // color:
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'View All',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //         color: AppColors.blue,
                        //         fontSize: 14,
                        //         // color:
                        //       ),
                        //     ),
                        //     Icon(
                        //       Icons.arrow_forward_outlined,
                        //       color: AppColors.blue,
                        //       size: 16,
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    (loaded)
                        ? SizedBox(
                            height: size.height * 0.145,
                            child: ListView.separated(
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: EventsListTile(
                                  icon: data[index]['image'],
                                  label: data[index]['name'],
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
              const GreySpace(),
              Padding(
                padding:
                    const EdgeInsets.all(16.0).copyWith(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Employment',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.blue,
                            fontSize: 20,
                            // color:
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'View All',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //         color: AppColors.blue,
                        //         fontSize: 14,
                        //         // color:
                        //       ),
                        //     ),
                        //     Icon(
                        //       Icons.arrow_forward_outlined,
                        //       color: AppColors.blue,
                        //       size: 16,
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    ExploreAndAddWidget(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ExploreEmployment(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
              const GreySpace(),
              Padding(
                padding:
                    const EdgeInsets.all(16.0).copyWith(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Market-Place',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.blue,
                            fontSize: 20,
                            // color:
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'View All',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //         color: AppColors.blue,
                        //         fontSize: 14,
                        //         // color:
                        //       ),
                        //     ),
                        //     Icon(
                        //       Icons.arrow_forward_outlined,
                        //       color: AppColors.blue,
                        //       size: 16,
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    ExploreAndAddWidget(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ExploreMarketPlace(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }
}
