import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_payment/data/dtos/dtos.dart';
import 'package:loan_app/features/loan_payment/domain/entities/payment.dart';
import 'package:loan_app/features/loan_payment/domain/repositories/repositories.dart';

class LoanPaymentRemoteRepo implements LoanPaymentRepo {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();

  @override
  Future<Either<LoanPaymentFailure, Payment>> getLoanPayment(
    String paymentId,
  ) async {
    try {
      final token = await _authHelper.getToken();
      final _response = await _httpHelper.get(
        url: '${URLs.baseURL}/loanservice/payments/$paymentId',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      final _responseDto = ResponseDto.fromMap(_response.data);
      final _paymentDto = PaymentDto.fromMap(_responseDto.data);
      final _payment = _paymentDto.toEntity();
      return Right(_payment);
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(LoanPaymentFailure());
    }
  }

  @override
  Future<Either<LoanPaymentFailure, List<Payment>>> getLoanPayments({
    required String loanId,
  }) async {
    log('Loan ID now $loanId');
    try {
      final token = await _authHelper.getToken();
      final _response = await _httpHelper.get(
        url: '${URLs.baseURL}/loanservice/payments/loan/$loanId',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      final _responseDto = ResponseDto.fromMap(_response.data);
      if (_responseDto.data != null) {
        final _paymentDtos = (_responseDto.data as List)
            .map((e) => PaymentDto.fromMap(e))
            .toList();
        final _payments = _paymentDtos.map((e) => e.toEntity()).toList();
        return Right(_payments);
      } else {
        return const Right([]);
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(LoanPaymentFailure());
    }
  }

  @override
  Future<Either<LoanPaymentFailure, List<Payment>>> getUserPayments() async {
    try {
      final token = await _authHelper.getToken();
      final _response = await _httpHelper.get(
        url: '${URLs.baseURL}/loanservice/payments',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      final _responseDto = ResponseDto.fromMap(_response.data);
      final _paymentDtos = (_responseDto.data as List)
          .map((e) => PaymentDto.fromMap(e))
          .toList();
      final _payments = _paymentDtos.map((e) => e.toEntity()).toList();

      return Right(_payments);
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(LoanPaymentFailure());
    }
  }

  @override
  Future<Either<LoanPaymentFailure, Payment>> payLoan({
    required double amount,
    required String currencyId,
    required String loanId,
    required String password,
  }) async {
    try {
      final token = await _authHelper.getToken();
      final response = await _httpHelper.post(
        url: '${URLs.baseURL}/loanservice/payments',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
        data: {
          'amount': amount,
          'currencyid': currencyId,
          'loanid': loanId,
          'password': password,
        },
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        final responseDto = ResponseDto.fromMap(response.data);

        final payment = PaymentDto.fromMap(responseDto.data).toEntity();
        return Right(payment);
      } else {
        return Left(LoanPaymentFailure());
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return Left(LoanPaymentFailure());
    }
  }
}
