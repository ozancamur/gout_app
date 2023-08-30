// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/add_friend_card/add_friend_card.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/view/detail/viewmodel/detail_view_model.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key, required this.eventId, required this.createrName});
  String eventId;
  String createrName;

  final controller = Get.put(DetailViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailViewModel>(
      init: DetailViewModel(),
      initState: (_) {},
      builder: (controller) {
        controller.getEventsDetail(eventId);
        controller.getEventArrivals(
            eventId, controller.detailModel.value.arrivals);
        controller.checkUserForEvent(
            controller.detailModel.value.arrivals,
            controller.detailModel.value.invited,
            controller.detailModel.value.createrId);
        controller.isEventFavorite(eventId);
        controller.getEventMoments(eventId);
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: goutAppBar("Event"),
            backgroundColor: ColorConstants.black,
            body: Padding(
              padding: EdgeInsets.only(
                      left: Get.width * .05,
                      right: Get.width * .05,
                      top: Get.height * .02),
              child: Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _eventCardField(),
                      controller.comingQuestion.value
                          ? _yourAnswerField()
                          : const SizedBox(),
                      controller.down.value ? _momentsField() : const SizedBox()
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Widget _eventCardField() {
    DateTime date = controller.detailModel.value.date.toDate();
    String day;
    String month = controller.monthMap[date.month]!;
    String year = date.year.toString();
    String hour;
    String minute;
    date.day < 10 ? day = "0${date.day}" : day = "${date.day}";
    date.hour < 10 ? hour = "0${date.hour}" : hour = "${date.hour}";
    date.minute < 10 ? minute = "0${date.minute}" : minute = "${date.minute}";

    return Container(
      height: Get.height * .6,
      width: Get.width * .9,
      decoration: BoxDecoration(
          color: ColorConstants.backgrounColor,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.only(
            top: Get.height * .025,
            left: Get.width * .07,
            right: Get.width * .07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ! EVENT TITLE & DESCRIPTION
            Padding(
              padding: EdgeInsets.only(bottom: Get.height * .07),
              child: Container(
                height: Get.height * .15,
                width: Get.width,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.goutPurple,
                      width: 0.65,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.detailModel.value.eventTitle.toUpperCase(),
                      style: const TextStyle(
                          color: ColorConstants.white, fontSize: 27),
                    ),
                    Text(
                        controller.detailModel.value.eventDescription
                            .toLowerCase(),
                        style: const TextStyle(
                            color: ColorConstants.goutWhite, fontSize: 16)),
                  ],
                ),
              ),
            ),

            //! LOCATION
            _eventProperty("Madrid, Spain", "place"),

            //! ABOUT EVENT
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .0125),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! date and organizator
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _eventProperty("$day/$month/$year", "date"),
                      _eventProperty(createrName, "organizator"),
                    ],
                  ),
                  //! time and arrivals
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _eventProperty("$hour:$minute", "time"),
                      InkWell(
                          onTap: () => _showArrivals(),
                          child: _eventProperty(
                              controller.detailModel.value.arrivals.length
                                  .toString(),
                              "arrivals"))
                    ],
                  )
                ],
              ),
            ),

            //! EVENT FUNCTIONS
            _eventMethods(),
          ],
        ),
      ),
    );
  }

  Widget _eventMethods() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //! FAVORITE BUTTON
        controller.isFavorite.value
            ? IconButton(
                onPressed: () {
                  controller.eventIsFavorite(eventId);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: ColorConstants.goutPurple,
                  size: 25,
                ),
              )
            : IconButton(
                onPressed: () {
                  controller.eventIsNotFavorite(eventId);
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: ColorConstants.goutPurple,
                  size: 25,
                ),
              ),
        //! COMMAND BUTTON
        controller.isComing.value
            ? IconButton(
                onPressed: () {
                  _addMoment();
                },
                icon: const Icon(
                  Icons.message,
                  color: ColorConstants.goutPurple,
                  size: 25,
                ),
              )
            : IconButton(
                onPressed: () {
                  Get.showSnackbar(const GetSnackBar(
                    message: "you can not share a moment into this event.",
                    snackPosition: SnackPosition.TOP,
                  ));
                },
                icon: const Icon(
                  Icons.message,
                  color: ColorConstants.grey,
                  size: 25,
                ),
              ),
        //! BLOCK BUTTON
        controller.isComing.value
            ? IconButton(
                icon: const Icon(
                  Icons.block,
                  size: 25,
                  color: ColorConstants.goutPurple,
                ),
                onPressed: () {
                  controller.cantCome(eventId);
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.block,
                  size: 25,
                  color: ColorConstants.grey,
                ),
                onPressed: () {
                  Get.showSnackbar(const GetSnackBar(
                    message: "you are not going to this event.",
                    snackPosition: SnackPosition.TOP,
                  ));
                },
              ),
        //! SEE COMMANDS BUTTON
        controller.down.value
            ? IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_up,
                  size: 25,
                  color: ColorConstants.goutPurple,
                ),
                onPressed: () {
                  controller.down.value = false;
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                  color: ColorConstants.goutPurple,
                ),
                onPressed: () {
                  controller.down.value = true;
                },
              )
      ],
    );
  }

  Widget _eventProperty(String location, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          location,
          style: const TextStyle(color: ColorConstants.white, fontSize: 20),
        ),
        Text(field.toLowerCase(),
            style: const TextStyle(color: ColorConstants.grey, fontSize: 14)),
        SizedBox(
          height: Get.height * .03,
        )
      ],
    );
  }

  Widget _yourAnswerField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            controller.cancelRequest(eventId);
          },
          child: Container(
            width: Get.width * .4,
            height: Get.height * .075,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorConstants.goutRed),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Cancel",
                    style: TextStyle(color: ColorConstants.white, fontSize: 20),
                  ),
                  Icon(
                    Icons.cancel,
                    color: ColorConstants.white,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.acceptRequest(eventId);
          },
          child: Container(
            width: Get.width * .4,
            height: Get.height * .07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorConstants.goutGreen),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accept",
                    style: TextStyle(color: ColorConstants.white, fontSize: 20),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: ColorConstants.white,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _showArrivals() {
    return Get.dialog(
      Center(
        child: Container(
          width: Get.width * .6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorConstants.goutMainDarkColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: controller.detailModel.value.arrivals.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return FriendCard(
                      nickname: controller.arrivalsList[index].nickname!,
                      name: controller.arrivalsList[index].name!,
                      id: controller.arrivalsList[index].id!,
                      imageURL: controller.arrivalsList[index].photoURL,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _addMoment() {
    return Get.dialog(
      Center(
        child: SizedBox(
            height: Get.height * .2,
            width: Get.width * .85,
            child: Material(
              borderRadius: BorderRadius.circular(30),
              color: ColorConstants.goutPurple,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: Get.width * .65,
                            child: TextField(
                              controller: controller.tecComment,
                              cursorColor: ColorConstants.white,
                              keyboardType: TextInputType.emailAddress,
                              strutStyle: const StrutStyle(fontSize: 15),
                              style:
                                  const TextStyle(color: ColorConstants.white),
                              decoration: InputDecoration(
                                hintText: "add a command",
                                hintStyle: const TextStyle(
                                    color: ColorConstants.goutWhite),
                                filled: true,
                                fillColor: ColorConstants.backgrounColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                          _pickPhoto(),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * .03),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.backgrounColor,
                            ),
                            onPressed: () {
                              controller.createAMoment(
                                  eventId, controller.tecComment.text);
                            },
                            child: const Text(
                              "send",
                              style: TextStyle(
                                  color: ColorConstants.goutWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget _pickPhoto() {
    return Center(
      child: GestureDetector(
        onTap: () {
          showPicker();
        },
        child: CircleAvatar(
          radius: Get.height * .03,
          backgroundColor: const Color(0xffFDCF09),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstants.backgrounColor,
                borderRadius: BorderRadius.circular(50)),
            width: Get.width * .5,
            height: Get.height * .2,
            child: const Icon(
              Icons.camera_alt,
              color: ColorConstants.goutWhite,
            ),
          ),
        ),
      ),
    );
  }

  Future showPicker() {
    return showModalBottomSheet(
        context: Get.context!,
        builder: (_) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    controller.pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    controller.pickImageFromCamera();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _momentsField() {
    return controller.momentsList.isEmpty
    ? const Text("not found any moment", style: TextStyle(color: ColorConstants.red),)
    : Flexible(
        child: Container(
      width: Get.width * .75,
      decoration: const BoxDecoration(
          color: ColorConstants.backgrounColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: ListView.builder(
          itemCount: controller.momentsList.length,
          itemBuilder: (context, index) {
            return _comment(index);
          }),
    ));
  }

  Padding _comment(int index) {
    return Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * .006, horizontal: Get.width * .03),
            child: Flexible(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: ColorConstants.goutWhite),
                  color: ColorConstants.backgrounColor,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height*.01),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*.02),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/no_profile_photo.png"),
                          foregroundImage: AssetImage("assets/images/me.png"),
                          radius: 24,
                        ),
                      ),
                      controller.momentsList[index].momentImageUrl.isEmpty
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("@${controller.momentsList[index].owner}", style: const TextStyle(color: ColorConstants.goutWhite, fontSize: 13.5),),
                          SizedBox(
                            width: Get.width*.5,
                            child: Text(controller.momentsList[index].comment, style: const TextStyle(color: Colors.white, fontSize: 12),)),
                        ],
                      )
                      : Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("@${controller.momentsList[index].owner}", style: const TextStyle(color: ColorConstants.goutWhite, fontSize: 13.5),),
                              SizedBox(
                                width: Get.width*.5,
                                child: Text(controller.momentsList[index].comment, style: const TextStyle(color: Colors.white, fontSize: 12),)),
                            ],
                          ),
                          //Image.network(controller.momentsList[index].momentImageUrl)
                        ],
                      )
                    ],
                  ),
                )
              ),
            ),
          );
  }
}