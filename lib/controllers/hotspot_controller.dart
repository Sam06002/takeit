import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/hotspot_model.dart';
import '../models/shop_model.dart';

class HotspotController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  // Observable list of hotspots
  final RxList<Hotspot> _hotspots = <Hotspot>[].obs;
  List<Hotspot> get hotspots => _hotspots;
  final Rx<Hotspot?> selectedHotspot = Rx<Hotspot?>(null);
  // Loading state
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  RxList<Shop> shops = <Shop>[].obs;

  // Fetch all hotspots
  Future<void> getHotspots() async {
    try {
      final snapshot = await _firestore.collection('hotspots').get();
      _hotspots.value =
          snapshot.docs.map((doc) => Hotspot.fromMap(doc.data())).toList();
    } catch (e) {
      print('Error fetching hotspots: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getHotspots();
  }
}
