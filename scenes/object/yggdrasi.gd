extends StaticBody2D

@export var tile_map_tanah: TileMapLayer
@export var radius_maksimal: int = 10
@export var source_id_gersang: int = 4
@export var source_id_subur: int = 1
@export var atlas_tanah_subur: Vector2i = Vector2i(0, 0)

var radius_sekarang: int = 1
var posisi_pohon_grid: Vector2i

func _ready() -> void:
	if tile_map_tanah == null:
		return
	
	var posisi_lokal = tile_map_tanah.to_local(global_position)
	posisi_pohon_grid = tile_map_tanah.local_to_map(posisi_lokal)

func _on_timer_timeout() -> void:
	if tile_map_tanah == null:
		return
		
	if radius_sekarang > radius_maksimal:
		$Timer.stop()
		return
	
	sebar_tanah_subur()
	radius_sekarang += 1

func sebar_tanah_subur() -> void:
	for x in range(-radius_sekarang, radius_sekarang + 1):
		for y in range(-radius_sekarang, radius_sekarang + 1):
			if Vector2(x, y).length() <= radius_sekarang:
				var koordinat_target = posisi_pohon_grid + Vector2i(x, y)
				var id_saat_ini = tile_map_tanah.get_cell_source_id(koordinat_target)
				
				if id_saat_ini != source_id_gersang:
					continue
				
				tile_map_tanah.set_cell(koordinat_target, source_id_subur, atlas_tanah_subur)
