class Object {

	final int? id;
	bool? archived = false;
	bool? favorited = false;
	bool? delivered = false;
	String name;
	String trackingCode;
	String? lastInfo;
	DateTime lastUpdate;

	Object({

		this.id,
		this.archived,
		this.favorited,
		this.delivered,
		required this.name,
		required this.trackingCode,
		this.lastInfo,
		required this.lastUpdate,
	});

	Map<String, dynamic> toMap() {

		return {

			"archived": archived == true ? 1 : 0,
			"favorited": favorited == true ? 1 : 0,
			"delivered": delivered == true ? 1 : 0,
			"name": name,
			"tracking_code": trackingCode,
			"last_info": lastInfo,
			"last_update": lastUpdate.toString(),
		};
	}	
}