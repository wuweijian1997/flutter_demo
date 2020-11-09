class PageRouteModel {
  PageRouteModel({title, this.page, this.arguments}) : this.title = title ?? page;

  String title;
  String page;
  Object arguments;
}
