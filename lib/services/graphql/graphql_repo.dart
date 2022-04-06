import 'package:flutter/material.dart';
import 'package:gql/ast.dart';
import 'package:get/get.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:viettel_app/config/app_key.dart';
import 'package:viettel_app/export.dart';
import 'package:viettel_app/models/user/user_model.dart';
import 'package:viettel_app/services/firebase/firebase_auth.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'package:viettel_app/src/login/login_page.dart';

import '../spref.dart';
import 'graphql_client.dart';

class GraphqlRepository {
  Future<QueryResult> query(
    String? query, {
    Map<String, dynamic>? variables,
    FetchPolicy? fetchPolicy,
    String? variablesParams,
  }) {
    var document = this.generateGQL(
        type: 'query', document: query, variablesParams: variablesParams);
    return graphqlClient.query(QueryOptions(
        document: document,
        variables: variables ?? Map(),
        fetchPolicy: fetchPolicy));
  }

  Future<QueryResult> mutate(
    String mutation, {
    Map<String, dynamic>? variables,
    Context? context,
    String? variablesParams,
  }) {
    return graphqlClient.mutate(MutationOptions(
        document: this.generateGQL(
            type: 'mutation',
            document: mutation,
            variablesParams: variablesParams),
        variables: variables ?? Map(),
        fetchPolicy: FetchPolicy.noCache,
        context: context));
  }

  clearCache() {
    graphqlClient.resetStore();
  }

  DocumentNode generateGQL(
      {required String type,
      String? document,
      List<String>? documents,
      String? variablesParams}) {
    String tmp = '$type${variablesParams ?? ''} {';
    if (document != null) {
      tmp += 'g0: $document';
    } else {
      if (documents != null)
        for (var i = 0; i < documents.length; i++) {
          tmp += '\ng$i: ${documents[i]}';
        }
    }
    tmp += '}';
    tmp = tmp.replaceAll(new RegExp('\\s{2,}', multiLine: true), " ");
    print('query - $tmp');
    return parseString(tmp);
  }

  handleException(QueryResult result, {bool showDataResult = false}) {
    print("handleException: ${result.exception}");
    if (showDataResult == true) print("result.data: ${result.data}");
    if (result.exception != null) {
      for (final err in result.exception!.graphqlErrors) {
        if(err.message == "Chưa xác thực") {
          // showSnackBar(title: "Thông báo", body: err.message,backgroundColor: Colors.red);
          // Get.offAll(LoginPage());
          ConfigFirebaseAuth.intent.auth.signOut();
          SPref.instance.clear();
          Get.find<AuthController>().userCurrent = User();
        }
      }
    }
  }
}
