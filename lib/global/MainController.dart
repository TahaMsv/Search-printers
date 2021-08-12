
import '../global/MainModel.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  MainModel? mainModel;
  MainModel get model => mainModel??MainModel();
  set model(MainModel model){
    mainModel = model;
  }
  MainController({this.mainModel});
}