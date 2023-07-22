import '../../../constants/sponsors_data.dart';
import '../../../models/sponsor.dart';

class SponsorsService {
  List<Sponsor> getSponsors() {
    return sponsorsData.map((e) => Sponsor.fromJson(e)).toList();
  }
}
