class_name GameData
extends Resource

var player_profiles: Dictionary = {}
var current_profile_name: String = ""
var level_count: int = 0


func _init(_level_count: int) -> void:
    level_count = _level_count


func set_current_profile(profile_name: String) -> void:
    if profile_exists(profile_name):
        current_profile_name = profile_name


func profile_exists(profile_name: String) -> bool:
    return player_profiles.keys().has(profile_name)


func get_current_profile() -> PlayerProfile:
    return get_profile(current_profile_name)


func get_profile(profile_name: String) -> PlayerProfile:
    if player_profiles.keys().has(profile_name):
        return player_profiles[profile_name]
    else:
        return null


func create_profile(profile_name: String) -> PlayerProfile:
    if not player_profiles.keys().has(profile_name):
        var new_profile: PlayerProfile = PlayerProfile.new(level_count)
        player_profiles[profile_name] = new_profile
        return new_profile
    else:
        return null


func current_profile_is_set() -> bool:
    return current_profile_name != ""
