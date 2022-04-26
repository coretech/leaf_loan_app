import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/user_profile/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';

class UserRemoteRepository extends UserRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  final LocalStorage _localStorage = IntegrationIOC.localStorage();
  @override
  Future<Either<UserFailure, User>> getUser() async {
    try {
      final token = await _authHelper.getToken() ;
      final response = await _httpHelper.get(
        url: '${URLs.baseURL}/userservice/profile',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      final responseDto = ResponseDto.fromMap(response.data);
      final userDto = UserDto.fromMap(responseDto.data);
      final user = userDto.toEntity();
      await _localStorage.setString(
        Keys.firstName,
        user.firstName,
      );
      await _localStorage.setString(
        Keys.username,
        user.username,
      );
      return Right(user);
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(UserFailure());
    }
  }
}
