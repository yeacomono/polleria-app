class ItemModuleModel {
    final String? name;
    final String? router;

    ItemModuleModel({
        this.name,
        this.router,
    });

    ItemModuleModel copyWith({
        String? name,
        String? router,
    }) => 
        ItemModuleModel(
            name: name ?? this.name,
            router: router ?? this.router,
        );

    factory ItemModuleModel.fromJson(Map<String, dynamic> json) => ItemModuleModel(
        name: json["name"],
        router: json["router"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "router": router,
    };
}
