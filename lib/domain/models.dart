
//onBoarding models
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject,this.currentIndex,this.numOfSlides);

}
class Customer{
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id,this.name,this.numOfNotifications);
}

class Contacts{
  String phone;
  String email;
  String link;

  Contacts(this.email,this.link,this.phone);
}
class Authentication{
  Customer customer;
  Contacts contacts;

  Authentication(this.customer,this.contacts);
}