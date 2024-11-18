import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:xtra_pr_71/data/network/mapper/base/mapper.dart';
import 'package:xtra_pr_71/domain/entity/internet/internet_allowance.dart';

import '../../../domain/type.dart';

class AllowanceApiMapper extends Mapper<dynamic, InternetAllowanceEntity> {
  @override
  InternetAllowanceEntity map(input) {
    var xmlParser = Xml2Json();
    xmlParser.parse(input);
    var decodedJson = jsonDecode(xmlParser.toOpenRally()) as JMap;
    return InternetAllowanceEntity.fromJson(decodedJson['blog']);
  }
}
