import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/core/config/constants/storage_keys.dart';
import 'package:track_trace/core/widgets/utils/shared_prefs.dart';
import 'package:track_trace/models/animal.dart';
import 'package:track_trace/service_locator.dart';

class MainController extends GetxController {
  final storage = locator<SharedPrefs>();

  RxBool isPremium = false.obs;
  RxBool isNotsOn = true.obs;

  RxInt screenIndex = 0.obs;
  final RxList<Animal> animals = <Animal>[].obs;

  final RxString currentNestedRoute = ''.obs;

  @override
  void onInit() {
    super.onInit();

    storage.init().then((_) {
      getPremium();
      isNotsOn.value = getNots();
    });
    animals.addAll(Animal.buildFromAssetPaths(AppImages.animals));
  }

  void getPremium() => isPremium.value = storage.getBool(StorageKeys.isPremium);

  Future<void> setPremium() async {
    isPremium.value = await storage.setBool(StorageKeys.isPremium, true);
    Get.back();
  }

  bool getNots() => storage.getBool(StorageKeys.isNotificationsOn);

  Future<void> setNots(bool value) async {
    await storage.setBool(StorageKeys.isNotificationsOn, value);
    isNotsOn.value = value;
  }

  void updateFav(Animal animal) {
    final index = animals.indexWhere((test) => test.name == animal.name);

    animals[index].isFavorite = !animals[index].isFavorite;
    animals.refresh();
    update();
  }
}
