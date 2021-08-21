class OnBoardContent {
  String image;
  String title;
  String desc;

  OnBoardContent(
      {required this.image, required this.title, required this.desc});
}

List<OnBoardContent> contents = [
  OnBoardContent(
      image: 'images/onboarding1.png',
      title: 'Where to go?',
      desc: 'Confused where you want to go to eat?'),
  OnBoardContent(
      image: 'images/onboarding2.png',
      title: 'Which one?',
      desc: "Confused what kind of food that some restaurants have?"),
  OnBoardContent(
      image: 'images/onboarding3.png',
      title: 'Calm down!',
      desc: "Know you shouldn’t confuse again! Just check it out in RESTAIL"),
];
