import 'package:companion/config/config.dart';
import 'package:companion/core/core.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coursesAPIProvider = Provider((ref) => CoursesAPI());
final dio = Dio();

abstract class ICoursesAPI {
  FutureEither<List<CoursesModal>> getCourses(String token);
}

class CoursesAPI implements ICoursesAPI {
  @override
  FutureEither<List<CoursesModal>> getCourses(String token) async {
    try {
      dio.options.headers['authorization'] = token;
      final coursesData = await dio.get(coursesUrl);
      List<CoursesModal> coursesList = [];
      coursesData.data['data']['files'].forEach((element) {
        coursesList.add(CoursesModal.fromJson(element));
      });
      return right(coursesList);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
