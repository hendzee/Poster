import '../models/poster_card_model.dart';

class FakeExploreData {
  static final List<PosterCardModel> exploreList = [
    PosterCardModel(
      title: 'Mega Concert 2020',
      posterImage: 'assets/dummy_images/poster1.png',
      date: '20 Sep, 2020',
      location: 'Jl. Pahlawan Jaya no. 10, Malang',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nulla lorem, vulputate a pretium quis, ultrices nec ex. Sed commodo tempor sem, ac ullamcorper dui venenatis in.',
    ),
    PosterCardModel(
      title: 'Mega Concert 2020',
      posterImage: 'assets/dummy_images/poster1.png',
      date: '20 Sep, 2020',
      location: 'Jl. Pahlawan Jaya no. 10, Malang',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nulla lorem, vulputate a pretium quis, ultrices nec ex. Sed commodo tempor sem, ac ullamcorper dui venenatis in.',
    ),
    PosterCardModel(
      title: 'Mega Concert 2020',
      posterImage: 'assets/dummy_images/poster1.png',
      date: '20 Sep, 2020',
      location: 'Jl. Pahlawan Jaya no. 10, Malang',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nulla lorem, vulputate a pretium quis, ultrices nec ex. Sed commodo tempor sem, ac ullamcorper dui venenatis in.',
    ),
  ];

  static List<PosterCardModel> getExploreList() {
    return exploreList;
  }
}
