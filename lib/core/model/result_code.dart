/// CreateDate: 2025/7/7 19:29
/// Author: Lee
/// Description:

abstract class ResultCode {
  static const unknown = -1;

  static const success = 200;

  static const fail = 1;

  static const error = 9999;

  static const token_overdue = 401;

  static const qrcode_overdue = 402;

  static const server_question = 500;

  static const iccid_already_exist = 600;

  static const activate_fail = 163;
}
