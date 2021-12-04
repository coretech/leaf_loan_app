import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/constants/urls.dart';
import 'package:loan_app/core/data/dto/response_dto.dart';
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
      final _token = await _authHelper.getToken() ?? '';
      final _response = await _httpHelper.get(
        url: '${URLs.baseURL}/userservice/profile',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(_token),
        ]),
        cacheAge: const Duration(minutes: 20),
      );
      final _responseDto = ResponseDTO.fromMap(_response.data);
      final _userDto = UserDTO.fromMap(_responseDto.data);
      final _user = _userDto.toEntity();
      await _localStorage.setString(
        Keys.firstName,
        _user.userId.firstName,
      );
      return Right(_user);
    } catch (e) {
      return left(UserFailure());
    }
  }
}
