import 'package:companion/config/config.dart';
import 'package:companion/core/core.dart';
import 'package:companion/model/courses.model.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coursesAPIProvider = Provider((ref) => CoursesAPI());
final dio = Dio();

abstract class ICoursesAPI {
  FutureEither<List<CoursesModel>> getCourses(String token);
}

class CoursesAPI implements ICoursesAPI {
  @override
  FutureEither<List<CoursesModel>> getCourses(String token) async {
    try {
      dio.options.headers['authorization'] = token;
      final coursesData = await dio.get(coursesUrl);
      List<CoursesModel> coursesList = [];
      coursesData.data['data']['files'].forEach((element) {
        coursesList.add(CoursesModel.fromJson(element));
      });
      return right(coursesList);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
