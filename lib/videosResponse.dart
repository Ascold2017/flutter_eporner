class VideosResponse {
  int count;
  int start;
  int perPage;
  int page;
  int timeMs;
  int totalCount;
  int totalPages;
  List<Videos> videos;

  VideosResponse(
      {this.count,
      this.start,
      this.perPage,
      this.page,
      this.timeMs,
      this.totalCount,
      this.totalPages,
      this.videos});

  VideosResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    start = json['start'];
    perPage = json['per_page'];
    page = json['page'];
    timeMs = json['time_ms'];
    totalCount = json['total_count'];
    totalPages = json['total_pages'];
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['start'] = this.start;
    data['per_page'] = this.perPage;
    data['page'] = this.page;
    data['time_ms'] = this.timeMs;
    data['total_count'] = this.totalCount;
    data['total_pages'] = this.totalPages;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  String id;
  String title;
  String keywords;
  int views;
  String rate;
  String url;
  String added;
  int lengthSec;
  String lengthMin;
  String embed;
  Thumb defaultThumb;
  List<Thumb> thumbs;

  Videos(
      {this.id,
      this.title,
      this.keywords,
      this.views,
      this.rate,
      this.url,
      this.added,
      this.lengthSec,
      this.lengthMin,
      this.embed,
      this.defaultThumb,
      this.thumbs});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    keywords = json['keywords'];
    views = json['views'];
    rate = json['rate'];
    url = json['url'];
    added = json['added'];
    lengthSec = json['length_sec'];
    lengthMin = json['length_min'];
    embed = json['embed'];
    defaultThumb = json['default_thumb'] != null
        ? new Thumb.fromJson(json['default_thumb'])
        : null;
    if (json['thumbs'] != null) {
      thumbs = new List<Thumb>();
      json['thumbs'].forEach((v) {
        thumbs.add(new Thumb.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['keywords'] = this.keywords;
    data['views'] = this.views;
    data['rate'] = this.rate;
    data['url'] = this.url;
    data['added'] = this.added;
    data['length_sec'] = this.lengthSec;
    data['length_min'] = this.lengthMin;
    data['embed'] = this.embed;
    if (this.defaultThumb != null) {
      data['default_thumb'] = this.defaultThumb.toJson();
    }
    if (this.thumbs != null) {
      data['thumbs'] = this.thumbs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thumb {
  String size;
  int width;
  int height;
  String src;

  Thumb({this.size, this.width, this.height, this.src});

  Thumb.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    width = json['width'];
    height = json['height'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['width'] = this.width;
    data['height'] = this.height;
    data['src'] = this.src;
    return data;
  }
}
