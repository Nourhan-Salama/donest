
import 'package:equatable/equatable.dart';

sealed class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object?> get props => [];
}

final class CreateTaskInitial extends CreateTaskState {
  const CreateTaskInitial();
}

final class CreateTaskLoading extends CreateTaskState {
  const CreateTaskLoading();
}

final class CreateTaskSuccess extends CreateTaskState {
  final String message;
  
  const CreateTaskSuccess(this.message);
  
  @override
  List<Object> get props => [message];
}

final class CreateTaskError extends CreateTaskState {
  final String message;
  
  const CreateTaskError(this.message);
  
  @override
  List<Object> get props => [message];
}

final class CreateTaskValidationError extends CreateTaskState {
  final String message;
  
  const CreateTaskValidationError(this.message);
  
  @override
  List<Object> get props => [message];
}

final class CreateTaskPriorityChanged extends CreateTaskState {
  final String? priority;
  
  const CreateTaskPriorityChanged(this.priority);
  
  @override
  List<Object?> get props => [priority];
}
