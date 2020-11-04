class PageRouteModel {
  PageRouteModel({title, this.page}) : this.title = title ?? page;

  String title;
  String page;
}
