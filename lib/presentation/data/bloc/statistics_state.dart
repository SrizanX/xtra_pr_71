import '../../../domain/entity/statistics/usage_statistics.dart';

sealed class StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsFailed extends StatisticsState {
  final String errorMessage;

  StatisticsFailed({required this.errorMessage});
}

class StatisticsSuccessful extends StatisticsState {
  final UsageStatistics statistics;

  StatisticsSuccessful({required this.statistics});
}
