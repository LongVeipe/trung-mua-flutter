import 'package:get/get.dart';
import 'package:viettel_app/models/support/init_session_model.dart';
import 'package:viettel_app/models/support/message_model.dart';
import 'package:viettel_app/repositories/support_repo.dart';

class SupportController extends GetxController {
  InitSessionModel? initSessionModel;
  List<InitSessionModel>? listSession;
  List<MessageModel> listData = [];
  int pageIndex = 0;
  int pageIndex2 = 0;
  bool lastItemSession = false;
  bool lastItemMessage = false;

  initSupport(List<String> images,String type) async {
    pageIndex = 0;
    listData = [];
    initSessionModel = await supportRepository.initMessages(images,type);
    getAllMessage();
  }

  getAllMessage() async {
    listData.addAll((await supportRepository.getAllMessage(
            sessionsId: initSessionModel!.id ?? 0, pageIndex: pageIndex))
        .reversed
        .toList());
    if (listData.length < (pageIndex == 0 ? 10 : pageIndex * 10)) {
      lastItemMessage = true;
    }
    update();
  }

  insertMessages(String message) async {
    listData = [];
    pageIndex = 0;
    if (initSessionModel != null) {
      await supportRepository.addMessages(message, initSessionModel!.id ?? 0);
      getAllMessage();
    }
  }

  getAllSessionByUser() async {
    if (listSession == null) listSession = [];
    listSession?.addAll(
        await supportRepository.getSessionsByUser(pageIndex: pageIndex2));
    if ((listSession?.length ?? 0) < (pageIndex2 == 0 ? 10 : pageIndex2 * 10)) {
      lastItemSession = true;
    }
    update();
  }

  closeSession(int sessionsId) async {
    print("closeSession---- $sessionsId");
    await supportRepository.closeMessages(sessionsId);
    listSession = [];
    pageIndex2 = 0;
    lastItemSession = false;
    getAllSessionByUser();
  }
}
