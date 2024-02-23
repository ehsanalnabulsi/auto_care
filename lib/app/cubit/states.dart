abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeModeState extends AppStates {}

class SendMobileTokenLoadingState extends AppInitialState {}

class SendMobileTokenSuccessState extends AppInitialState {}

class SendMobileTokenErrorState extends AppInitialState {}
