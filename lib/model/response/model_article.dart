class ModelArticles {
  List<Data>? data;

  ModelArticles({this.data});

  ModelArticles.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Title? title;

  String? jetpackFeaturedMediaUrl;

  String? canonicalUrl;
  PrimaryCategory? primaryCategory;

  Data({
    this.title,
    this.jetpackFeaturedMediaUrl,
    this.canonicalUrl,
    this.primaryCategory,
  });

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;

    canonicalUrl = json['canonical_url'];
    jetpackFeaturedMediaUrl = json['jetpack_featured_media_url'];
    primaryCategory = json['primary_category'] != null
        ? new PrimaryCategory.fromJson(json['primary_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }

    data['jetpack_featured_media_url'] = this.jetpackFeaturedMediaUrl;

    data['canonical_url'] = this.canonicalUrl;
    if (this.primaryCategory != null) {
      data['primary_category'] = this.primaryCategory!.toJson();
    }

    return data;
  }
}

class Title {
  String? rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class PrimaryCategory {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;

  PrimaryCategory(
      {this.termId,
      this.name,
      this.slug,
      this.termGroup,
      this.termTaxonomyId,
      this.taxonomy,
      this.description,
      this.parent,
      this.count,
      this.filter});

  PrimaryCategory.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    data['term_taxonomy_id'] = this.termTaxonomyId;
    data['taxonomy'] = this.taxonomy;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['count'] = this.count;
    data['filter'] = this.filter;
    return data;
  }
}
