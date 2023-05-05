import 'package:budget_app_flutter/model/profile.dart';
import 'package:budget_app_flutter/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserProfileService userProfileService = UserProfileService();
  final Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading(true);

      UserProfileResponse userProfileResponse =
          await userProfileService.getUserProfile();
      userProfileModel.value = userProfileResponse.data;

      debugPrint("User Profile Data: $userProfileResponse");
    } catch (e) {
      isLoading(false);
      debugPrint("Error fetching a user's category: $e");
    } finally {
      isLoading(false);
    }
  }
}
