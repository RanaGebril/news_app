abstract class HomeStates{}

// initialize cubit
class HomeInitState extends HomeStates{}

// sorces
class SourcesLoadingState extends HomeStates{}
class SourcesErrorState extends HomeStates{}
class SourcesSuccessState extends HomeStates{}

// news data
class NewsLoadingState extends HomeStates{}
class NewsErrorState extends HomeStates{}
class NewsSuccessState extends HomeStates{}

class ChangeSource extends HomeStates{}

class CategorySelectState extends HomeStates{}



