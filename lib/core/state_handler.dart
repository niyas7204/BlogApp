import 'package:cleanarchitecture/core/enums.dart';

class StateHandler<T> {
  T? data;
  String? errorMessage;
  StateStatus status;
  StateHandler(this.data, this.errorMessage, this.status);
  StateHandler.initial() : status = StateStatus.initial;
  StateHandler.loading() : status = StateStatus.loading;
  StateHandler.success(this.data) : status = StateStatus.success;
  StateHandler.error(this.errorMessage) : status = StateStatus.failure;
}
