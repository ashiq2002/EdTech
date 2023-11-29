import 'package:edtech/res/app_colors.dart';
import 'package:edtech/res/app_strings.dart';
import 'package:edtech/route/routes_name.dart';
import 'package:edtech/src/model/course_tile_model.dart';
import 'package:edtech/src/view/widgets/user_input_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalBlue,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: const [Icon(Icons.notifications), Gap(10)],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-----------------------------------custom search view
              SearchView(),
              Gap(30),

              //-----------------------title
              Text(
                'Enrolled Courses',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Gap(20),

              //----------------------------------enrolled course list
              EnrolledCourseList()
            ],
          ),
        ),
      ),
    );
  }
}

//--------------------------------------------------- course list widget
class EnrolledCourseList extends StatelessWidget {
  const EnrolledCourseList({super.key});

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CourseTile(course: courses[index]),
                )));
  }
}

//-----------------------------------------------------------------------------course tile
class CourseTile extends StatelessWidget {
  final CourseTileModel course;
  const CourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        height: 110,
        width: size.width,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15)),
              //----------------------------------------------------------icon
              child: Image.asset(
                course.iconPath,
                scale: 2.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //--------------------------------------name of the course
                  Text(
                    course.course,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.teal.shade800),
                  ),
                  const Gap(8),
                  //---------------------------------------------continue button
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            RoutesName.videoPlayScreen,);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Colors.teal.shade900
                      ),
                      child: const Text(
                        "Continue Course",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ))
                ],
              ),
            )
          ],
        ));
  }
}


//--------------------------------------------------------custom search view widget
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.grey.shade500,
          ),
          const Gap(8),
          Text(
            'Search new courses...',
            style: TextStyle(color: Colors.grey.shade500),
          )
        ],
      ),
    );
  }
}
