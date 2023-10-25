// ignore_for_file: must_be_immutable, unnecessary_null_comparison, iterable_contains_unrelated_type
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/add_friend_card/add_friend_card.dart';
import 'package:gout_app/core/widgets/card/change_card.dart';
import 'package:gout_app/view/detail/viewmodel/detail_view_model.dart';

class DetailView extends StatelessWidget {
  DetailView(
      {Key? key,
      required this.eventId,
      required this.createrName,
      required this.createrId,
      required this.arrivals,
      required this.friends})
      : super(key: key);
  String eventId;
  String createrName;
  String createrId;
  List arrivals;
  List friends;

  final controller = Get.put(DetailViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailViewModel>(
      initState: (state) {
        controller.getEventsDetail(eventId);
      },
      init: DetailViewModel(),
      builder: (controller) {
        controller.getEventArrivals(controller.detailModel.value.arrivals);
        controller.getEventInviteds(controller.detailModel.value.invited);
        controller.getFriend();
        controller.checkUserForEvent(
            controller.detailModel.value.arrivals,
            controller.detailModel.value.invited,
            controller.detailModel.value.createrId,
            controller.detailModel.value.createdOnDate);
        controller.getEventMoments(eventId);
        return SafeArea(
          child: Obx(
            () => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorConstants.black,
              appBar: _appBarField(controller),
              body: _bodyField(controller),
            ),
          ),
        );
      },
    );
  }

  AppBar _appBarField(DetailViewModel controller) {
    return AppBar(
      centerTitle: true,
      backgroundColor: ColorConstants.black,
      foregroundColor: ColorConstants.goutWhite,
      title: const Text(
        "Event",
        style: TextStyle(color: ColorConstants.white, fontSize: 25),
      ),
      actions: [
        createrId == controller.box.read("userUID")
            ? PopupMenuButton(
                icon: const Icon(
                  Icons.menu,
                  size: 20,
                  color: ColorConstants.goutWhite,
                ),
                color: ColorConstants.backgrounColor,
                itemBuilder: (BuildContext context) => [
                  changeEvent(
                    "change Event Title",
                    "event title",
                    TextInputType.text,
                    controller.tecEventTitle,
                    () => controller.changeEventTitle(
                      eventId,
                      controller.tecEventTitle.text,
                    ),
                  ),
                  changeEvent(
                    "change Event Description",
                    "event description",
                    TextInputType.text,
                    controller.tecEventDescription,
                    () => controller.changeEventDescription(
                      eventId,
                      controller.tecEventDescription.text,
                    ),
                  ),
                  PopupMenuItem(
                      onTap: () {
                        chooseFriends();
                      },
                      child: const Text(
                        "change Inviteds",
                        style: TextStyle(color: ColorConstants.goutWhite),
                      ))
                ],
              )
            : const SizedBox()
      ],
    );
  }

  Widget _bodyField(DetailViewModel controller) {
    return Padding(
      padding: EdgeInsets.only(
          left: Get.width * .05, right: Get.width * .05, top: Get.height * .02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _eventCardField(),
          controller.comingQuestion.value
              ? _yourAnswerField()
              : const SizedBox(),
          controller.down.value ? _momentsField() : const SizedBox()
        ],
      ),
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
        padding: EdgeInsets.only(left: Get.width * .07, right: Get.width * .07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ! EVENT TITLE & DESCRIPTION
            Padding(
              padding: EdgeInsets.only(bottom: Get.height * .02),
              child: Container(
                height: Get.height * .25,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * .65,
                          child: Text(
                            controller.detailModel.value.eventTitle
                                .toUpperCase(),
                            style: const TextStyle(
                                color: ColorConstants.white, fontSize: 27),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: SizedBox(
                        height: Get.height * .05,
                        child: Text(
                            controller.detailModel.value.eventDescription
                                .toLowerCase(),
                            style: const TextStyle(
                                color: ColorConstants.goutWhite, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //! ABOUT EVENT
            Row(
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

            //! EVENT FUNCTIONS
            _eventMethods(),
          ],
        ),
      ),
    );
  }

  Widget _eventMethods() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //! FAVORITE BUTTON
          eventButton(
              controller.isFavorite.value,
              () => controller.eventIsNotFavorite(eventId),
              Icons.favorite,
              () => controller.eventIsFavorite(eventId),
              secondIcon: Icons.favorite_border,
              color: ColorConstants.goutPurple),
          //! COMMAND BUTTON
          eventButton(
            controller.momentTime.value,
            () => _addMoment(),
            Icons.message,
            () => Get.showSnackbar(
              const GetSnackBar(
                message: "you can not share a moment into this event.",
                snackPosition: SnackPosition.TOP,
              ),
            ),
          ),
          //! BLOCK BUTTON
          eventButton(
            controller.isComing.value,
            () => controller.cantCome(eventId),
            Icons.block,
            () => Get.showSnackbar(
              const GetSnackBar(
                message: "you are not going to this event.",
                snackPosition: SnackPosition.TOP,
              ),
            ),
          ),
          //! LOCATION
          eventButton(
            controller.isComing.value,
            () => controller.displayLocation(
                controller.detailModel.value.location.latitude,
                controller.detailModel.value.location.longitude),
            Icons.location_on,
            () => Get.showSnackbar(
              const GetSnackBar(
                message: "you can not see thi event's location.",
                snackPosition: SnackPosition.TOP,
              ),
            ),
          ),
          //! SEE COMMANDS BUTTON
          eventButton(
              controller.down.value,
              () => controller.down.value = false,
              Icons.keyboard_arrow_up,
              () => controller.down.value = true,
              secondIcon: Icons.keyboard_arrow_down,
              color: ColorConstants.goutPurple),
        ],
      ),
    );
  }

  IconButton eventButton(bool value, Function() truePressed, IconData icon,
      Function() falsePressed,
      {IconData? secondIcon, Color? color}) {
    secondIcon ??= icon;
    color ??= ColorConstants.grey;
    return value
        ? IconButton(
            onPressed: truePressed,
            icon: Icon(
              icon,
              color: ColorConstants.goutPurple,
              size: 25,
            ),
          )
        : IconButton(
            onPressed: falsePressed,
            icon: Icon(
              secondIcon,
              color: color,
              size: 25,
            ),
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
                      photoURL: controller.arrivalsList[index].photoURL,
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
                                hintText: "add a memory",
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
                    controller.pickImageFromGalleryForMoment();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    controller.pickImageFromCameraForMoment();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _momentsField() {
    return controller.momentsList.isEmpty
        ? const Text(
            "not found any moment",
            style: TextStyle(color: ColorConstants.red),
          )
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
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .01),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/no_profile_photo.png"),
                      foregroundImage: AssetImage("assets/images/me.png"),
                      radius: 24,
                    ),
                  ),
                  controller.momentsList[index].momentImageUrl.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@${controller.momentsList[index].owner}",
                              style: const TextStyle(
                                  color: ColorConstants.goutWhite,
                                  fontSize: 13.5),
                            ),
                            SizedBox(
                                width: Get.width * .5,
                                child: Text(
                                  controller.momentsList[index].comment,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                          ],
                        )
                      : Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "@${controller.momentsList[index].owner}",
                                  style: const TextStyle(
                                      color: ColorConstants.goutWhite,
                                      fontSize: 13.5),
                                ),
                                SizedBox(
                                    width: Get.width * .5,
                                    child: Text(
                                      controller.momentsList[index].comment,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                              ],
                            ),
                            //Image.network(controller.momentsList[index].momentImageUrl)
                          ],
                        )
                ],
              ),
            )),
      ),
    );
  }

  chooseFriends() async {
    Get.dialog(
      Center(
        child: Container(
          width: Get.width * .8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorConstants.backgrounColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _changeInvitedsTitleField("Inviteds"),
              Flexible(
                child: ListView.builder(
                  itemCount: controller.detailModel.value.invited.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    var refreshKeyInviteds = GlobalKey<RefreshIndicatorState>();
                    return controller.friendList.isEmpty
                        ? RefreshIndicator(
                            child: const Text("No İnvited"),
                            onRefresh: () async {
                              await controller.getEventInviteds(
                                  controller.detailModel.value.invited);
                            },
                          )
                        : RefreshIndicator(
                            key: refreshKeyInviteds,
                            onRefresh: () async {
                              await controller.getEventInviteds(
                                  controller.detailModel.value.invited);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FriendCard(
                                  nickname:
                                      "${controller.invitedList[index].nickname}",
                                  name: "${controller.invitedList[index].name}",
                                  id: "${controller.invitedList[index].id}",
                                  photoURL:
                                      controller.invitedList[index].photoURL,
                                ),
                                _inviteIconButtonField(
                                    () => controller.removeInvite(eventId,
                                        controller.invitedList[index].id!),
                                    Icons.remove,
                                    ColorConstants.goutRed)
                              ],
                            ),
                          );
                  },
                ),
              ),
              const Text(
                "         .",
                style: TextStyle(
                  color: ColorConstants.backgrounColor,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: ColorConstants.goutWhite,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: .75 
                  ),
              ),
              _changeInvitedsTitleField("Friends"),
              
              Flexible(
                child: ListView.builder(
                  itemCount: friends.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    var refreshKeyFriends = GlobalKey<RefreshIndicatorState>();
                    return controller.friendList.isEmpty
                        ? RefreshIndicator(
                            child: const Text("No Friends"),
                            onRefresh: () async {
                              await controller.getFriend();
                            },
                          )
                        : RefreshIndicator(
                            key: refreshKeyFriends,
                            onRefresh: () async {
                              await controller.getFriend();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FriendCard(
                                  nickname:
                                      "${controller.friendList[index].nickname}",
                                  name: "${controller.friendList[index].name}",
                                  id: "${controller.friendList[index].id}",
                                  photoURL:
                                      controller.friendList[index].photoURL,
                                ),
                                controller.detailModel.value.invited.contains(
                                        controller.friendList[index].id)
                                    ? _inviteIconButtonField(
                                        () =>
                                            Get.showSnackbar(const GetSnackBar(
                                          message: "this user invited",
                                        )),
                                        Icons.add,
                                        ColorConstants.grey,
                                      )
                                    : _inviteIconButtonField(() {
                                        controller.updateInvite(eventId,
                                            controller.friendList[index].id!);
                                        Get.back();
                                      }, Icons.add, ColorConstants.goutGreen)
                              ],
                            ),
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

  IconButton _inviteIconButtonField(
      Function() onPressed, IconData icon, Color color) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 25,
        color: color,
      ),
    );
  }

  Text _changeInvitedsTitleField(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 35,
          color: ColorConstants.goutPurple,
          decoration: TextDecoration.none,
          height: 1.5),
    );
  }

  buildCenterLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
