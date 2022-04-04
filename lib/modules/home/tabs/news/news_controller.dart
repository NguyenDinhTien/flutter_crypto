import 'package:crypto_flutter/api/api.dart';
import 'package:crypto_flutter/models/article_model.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var listtNews = [].obs;
  var isLoading = true.obs;
  var errorMsg = RxString('');

  getDataNews() async {
    errorMsg.value = '';
    DateTime time = DateTime(
        DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

    Map<String, String> qParams = {
      'q': 'crypto and 1inch',
      'from': '${time.year}-${time.month}-${time.day}',
      'sortBy': 'publishedAt',
      'apiKey': ApiConstans.keyArticle,
// 'qInTitle': 'two',
    };

    try {
      var result = await fetch(
          newUrl: 'https://newsapi.org/v2/everything',
          method: 2,
          queryParams: qParams);
      if (result != null) {
        List listData = result['articles'];
        List<Article> tempList = [];
        if (listData.isNotEmpty) {
          for (var e in listData) {
            tempList.add(Article.fromJson(e));
          }
          listtNews.value = [...tempList];
          print('debugging');
          // Article test = tempList[0];
          // var parsedDate = DateTime.parse(test.publishedAt);
          // print(timeago.format(parsedDate));

        }
      }
      //final fifteenAgo = DateTime.now().subtract(Duration(minutes: 15));

    } catch (e) {
      errorMsg.value = e.toString();
    }
  }

  showLoading(bool value) {
    isLoading.value = value;
  }
}
