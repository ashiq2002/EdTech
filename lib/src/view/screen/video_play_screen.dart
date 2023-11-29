import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:edtech/res/app_colors.dart';
import 'package:edtech/res/app_strings.dart';
import 'package:edtech/src/controllers/videoplay_screen_controller.dart';
import 'package:edtech/src/model/video_bookmark_model.dart';
import 'package:edtech/src/view/widgets/custom_checkbox.dart';
import 'package:edtech/src/view/widgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({
    super.key,
  });

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  String dropdownValue = dropDownList.first; //current dropdown value

  late VideoPlayScreenController _controller; // video player screen controller

  late VideoPlayerController _videoPlayerController; //video player controller

  late CustomVideoPlayerController _customVideoPlayerController; // custom video player controller

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(showSeekButtons: true); // custom video settings

  @override
  void initState() {
    super.initState();
    _controller = Get.put(VideoPlayScreenController());
    _initializeVideo(index: _controller.index, context: context);
    debugPrint("Video Player - screen initialize");
  }

  //---------------------------------------------------------------------------initialize all video controllers
  void _initializeVideo(
      {required int index, required BuildContext context, List<VideoBookmarkModel>? videos, Duration? duration}) {
    if (_controller.videos.isNotEmpty) {
      debugPrint("URI $index: ${_controller.videos[index].uri}");
    }

    // _videoPlayerController = VideoPlayerController.networkUrl(
    //   Uri.parse(_controller.videos.isNotEmpty? _controller.videos[index].uri:""),
    // )..initialize().then((value) {
    //     _controller.updateIsSuccess(true);
    //     debugPrint("URI : ${_controller.isSuccess}");
    //   }).onError((error, stackTrace) {
    //     _controller.updateIsSuccess(false);
    //   });

    //--------------------------------------------------------------------initialize VideoPlayerController
    _videoPlayerController = VideoPlayerController.asset(videos == null
        ? _controller.videos[index].uri
        : videos[index].video.uri)
      ..initialize().then((value) async{

        //-----------------------------------------------------------------------------------set video position
        await _videoPlayerController.seekTo(duration ?? const Duration(seconds: 0));
        _videoPlayerController.play();
        _controller.updateIsSuccess(true);

      }).onError((error, stackTrace) {
        _controller.updateIsSuccess(false);
      });

    //--------------------------------------------------------------initialize CustomVideoPlayerController
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _videoPlayerController.closedCaptionFile;
    _videoPlayerController.pause();
    _videoPlayerController.dispose(); //dispose _videoPlayerController
    _customVideoPlayerController.dispose(); //dispose _customVideoPlayerController
    Get.delete<VideoPlayScreenController>(); //delete VideoPlayScreenController from memory

    debugPrint("Video Player - Screen Disposed");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("VALUE : $dropdownValue");

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalBlue,
        title: const Text(
          "Video Play",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
          child: Column(
        children: [
          //-----------------------------------------------video player
          Expanded(
              flex: 3,
              child: Column(
                children: [

                  Obx(() => _controller.isSuccess
                  //---------------------------------------------------------play video
                      ? CustomVideoPlayer(
                          customVideoPlayerController:
                              _customVideoPlayerController,
                        )
                  //--------------------------------------------------showing loading indicator
                      : const Center(
                          child: CircularProgressIndicator(),
                        )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //----------------------------------------------------------------goto previous video
                      IconButton(
                          onPressed: () {
                            //if index is less than 0 return
                            if(_controller.index < 0) return;

                            _controller.goToPrevious();
                            _initializeVideo(index: _controller.index, context: context);
                          },
                          icon: const Icon(Icons.arrow_back_ios)),

                      //----------------------------------------------------------------------bookmark video
                      IconButton(
                          onPressed: () {
                            _controller.addToBookmark(_controller.index, VideoBookmarkModel(
                                _controller.videos[_controller.index],
                                _videoPlayerController.position));
                          },
                          icon: const Icon(CupertinoIcons.bookmark)),

                      //---------------------------------------------------------------------------goto next video
                      IconButton(
                          onPressed: () {
                            if (dropdownValue == dropDownList[1]) {
                              //if index is equal to video length then return
                              if(_controller.index == _controller.bookmarkVideo.length-1) return;
                              debugPrint("Bookmark next");

                              _controller.gotToNext(_controller.bookmarkVideo.length);

                              //---------------if drop down value == bookmark then re-instantiate the video controllers
                              _controller.bookmarkVideo[_controller.index].duration.then((value){

                                debugPrint("$_controller.index - Duration - $value");

                                _initializeVideo(index: _controller.index, context: context,
                                    videos: _controller.bookmarkVideo, duration: value);
                              });

                            } else {
                              if(_controller.index == _controller.videos.length-1) return;
                              debugPrint("All next");
                              _controller.gotToNext(_controller.videos.length);
                              _initializeVideo(index: _controller.index, context: context);
                            }
                          },
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ],
                  )
                ],
              )),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //------------------------------mark as all checkbox
              Obx(() => CustomCheckBox(
                    value: _controller.isCompleted,
                    onChanged: (value) {
                      _controller.markAsAllCompleted();
                      if(value!){
                        _videoPlayerController.pause();
                        showDialog(context: context, barrierDismissible: false,builder: (context)=> const CustomDialog());
                      }
                    },
                    child: const Text("Mark  as Complete"),
                  )),

              //--------------------------------------dropdown button
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15)),
                  //---------------------------------------------------------dropdown
                  child: DropdownButton(
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(15),
                    value: dropdownValue,
                    //-------------------------------------drop down value change listener
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;

                        //-------------------------------------------------------for debugging
                        for(VideoBookmarkModel v in _controller.bookmarkVideo){
                          v.duration.then((value){
                            debugPrint("Duration - $value");
                          });

                        }//end

                        if(dropdownValue == dropDownList[1]){
                          //------------------if dropdown value is equal Bookmark then update the index
                          _controller.updateIndex(0);
                        }

                      });
                    },
                    //---------------------------------------------------dropdown list
                    items: dropDownList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),
          VideoListView(
            controller: _controller,
            dropDownValue: dropdownValue,
          )
        ],
      )),
    );
  }
}

//-----------------------------------------------------------------------------video list view widget
class VideoListView extends StatelessWidget {
  final VideoPlayScreenController controller;
  final String dropDownValue;

  const VideoListView(
      {super.key, required this.controller, required this.dropDownValue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ListView.builder(
          itemCount: dropDownValue == dropDownList[0]
              ? controller.videos.length
              : controller.bookmarkVideo.length,
          itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                //-----------------------------------------------------------------------custom checkbox
                child: Obx(() => CustomCheckBox(
                      value: controller.isCompleted
                          ? controller.isCompleted
                          : dropDownValue == dropDownList[0]
                              ? controller.videos[index].isCompleted
                              : controller
                                  .bookmarkVideo[index].video.isCompleted,
                      onChanged: (value) {
                        controller.setAsCompleteVideo(
                            index, controller.videos[index]);
                      },
                  //---------------------------------------------------------------------------------video tile
                      child: Expanded(
                        child: InkWell(
                          onTap: () {},
                          //---------------------------------------------------------container
                          child: Container(
                            height: 56,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: controller.index == index
                                    ? Border.all(width: 2, color: royalBlue)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(2, 2),
                                    blurRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(-2, -2),
                                    blurRadius: 2,
                                  ),
                                ]),
                            child: Row(
                              children: [
                                //----------------------------------------------video icon
                                const Icon(
                                  CupertinoIcons.play_rectangle,
                                  size: 32,
                                ),
                                const Gap(25),
                                //---------------------------------------------------video name
                                Text(
                                  dropDownValue == dropDownList[0]
                                      ? controller.videos[index].name
                                      : controller
                                          .bookmarkVideo[index].video.name,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              )),
    );
  }
}
