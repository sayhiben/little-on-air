; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 1h 7m 51s; total estimated time: 1h 16m 17s
; total layer number: 58
; total filament length [mm] : 2920.47,368.45
; total filament volume [cm^3] : 7024.55,886.22
; total filament weight [g] : 8.78,1.13
; model label id: 272,399
; object max height: 2.50,4.90
; filament_density: 1.25,1.27,1.27
; filament_diameter: 1.75,1.75,1.75
; max_z_height: 4.90
; filament: 1,2
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,0,0
; additional_cooling_fan_speed = 70,0,0
; additional_fan_full_speed_layer = 0,0,0
; alternate_extra_wall = 0
; ams_filament_load_time_ams = 0
; ams_filament_load_time_ams_lite = 0
; ams_filament_load_time_n3f_s = 0
; ams_filament_unload_time_ams = 0
; ams_filament_unload_time_ams_lite = 0
; ams_filament_unload_time_n3f_s = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; bed_heat_soak_area = 
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 5
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 25
; brim_object_gap = 0.15
; brim_type = no_brim
; brim_width = 3
; chamber_temperatures = 0,0,0
; change_filament_gcode = ;=X1 20251031=\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == \"PETG\"}\nM109 S260\n{elsif filament_type[next_extruder] == \"PVA\"}\nM109 S210\n{else}\nM109 S{flush_temperatures[next_extruder]}\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200,200,200
; close_additional_fan_first_x_layers = 1,3,3
; close_fan_the_first_x_layers = 1,3,3
; complete_print_exhaust_fan_speed = 70,70,70
; cool_plate_temp = 35,0,0
; cool_plate_temp_initial_layer = 35,0,0
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10,10,10
; cooling_slowdown_logic = uniform_cooling,uniform_cooling,uniform_cooling
; counter_coef_1 = 0,0,0
; counter_coef_2 = 0.008,0.008,0.008
; counter_coef_3 = -0.041,-0.041,-0.041
; counter_limit_max = 0.033,0.033,0.033
; counter_limit_min = -0.035,-0.035,-0.035
; counterbore_hole_bridging = none
; curr_bed_type = Textured PEI Plate
; default_acceleration = 1000
; default_ams_type = -1
; default_filament_colour = ;;
; default_filament_profile = "Bambu PLA Basic @BBL X1C"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50,50,50
; different_settings_to_system = bottom_shell_layers;bridge_speed;brim_object_gap;brim_type;brim_width;default_acceleration;enable_support;flush_into_support;gap_infill_speed;initial_layer_infill_speed;initial_layer_print_height;initial_layer_speed;inner_wall_speed;internal_solid_infill_speed;outer_wall_acceleration;outer_wall_speed;reduce_crossing_wall;sparse_infill_density;sparse_infill_pattern;sparse_infill_speed;support_interface_bottom_layers;support_interface_spacing;support_on_build_plate_only;support_style;support_type;top_surface_speed;wall_generator;wall_loops;;;;scan_first_layer
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70,70,70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1,1,1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0,0,0
; enable_prime_tower = 0
; enable_support = 1
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 0,70,70
; eng_plate_temp_initial_layer = 0,70,70
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = Standard#1
; extruder_nozzle_stats_new = Standard#1
; extruder_offset = 0x2
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow"
; fan_cooling_layer_time = 100,30,30
; fan_direction = left
; fan_max_speed = 100,90,90
; fan_min_speed = 100,40,40
; farthest_point_timelapse = 1
; filament_adaptive_volumetric_speed = 0,0,0
; filament_adhesiveness_category = 100,300,300
; filament_bridge_speed = 25,25,25
; filament_change_length = 10,10,10
; filament_change_length_nc = 10,10,10
; filament_colour = #161616;#C1C1C1;#C1C1C1
; filament_colour_type = 0;0;0
; filament_cooling_before_tower = 0,0,0
; filament_cost = 22.99,30,30
; filament_density = 1.25,1.27,1.27
; filament_dev_ams_drying_ams_limitations = 1;1;0;1;0
; filament_dev_ams_drying_heat_distortion_temperature = 45,75,75
; filament_dev_ams_drying_temperature = 45,65,65,55,55,65,65,55,55
; filament_dev_ams_drying_time = 12,12,12,12,12,12,12,12,12
; filament_dev_chamber_drying_bed_temperature = 70,80,80
; filament_dev_chamber_drying_time = 12,12,12
; filament_dev_drying_cooling_temperature = 45,55,55
; filament_dev_drying_softening_temperature = 50,60,60
; filament_diameter = 1.75,1.75,1.75
; filament_enable_overhang_speed = 1,1,1
; filament_end_gcode = "; filament end gcode \n\n";"; filament end gcode \n\n";"; filament end gcode \n\n"
; filament_extruder_compatibility = 0,0,0
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.98,0.95,0.95
; filament_flush_temp = 0,0,0
; filament_flush_temp_fast = 0,0,0
; filament_flush_volumetric_speed = 0,0,0
; filament_ids = GFL03;GFG99;GFG99
; filament_is_mixed = 0
; filament_is_support = 0,0,0
; filament_map = 1,1,1
; filament_map_2 = 0,0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 16,12,12
; filament_metal_stickiness = None,High,High
; filament_minimal_purge_on_wipe_tower = 15,15,15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_multi_colour = #161616;#C1C1C1;#C1C1C1
; filament_notes = Black and white share the previous eSUN PLA+ baseline. Clear PETG retains the optical profile. Match actual spool temperatures and calibrated flow before printing.
; filament_nozzle_map = 0,0,0
; filament_overhang_1_4_speed = 0,0,0
; filament_overhang_2_4_speed = 50,50,50
; filament_overhang_3_4_speed = 30,30,30
; filament_overhang_4_4_speed = 10,10,10
; filament_overhang_totally_speed = 10,10,10
; filament_pre_cooling_temperature = 0,0,0
; filament_pre_cooling_temperature_nc = 0,0,0
; filament_preheat_temperature_delta = 10,0,0
; filament_prime_volume = 45,45,45
; filament_prime_volume_nc = 60,60,60
; filament_printable = 3,3,3
; filament_ramming_travel_time = 0,0,0
; filament_ramming_travel_time_nc = 0,0,0
; filament_ramming_volumetric_speed = -1,-1,-1
; filament_ramming_volumetric_speed_nc = -1,-1,-1
; filament_retract_length_nc = 14,14,14
; filament_scarf_gap = 15%,0%,0%
; filament_scarf_height = 10%,10%,10%
; filament_scarf_length = 10,10,10
; filament_scarf_seam_type = none,none,none
; filament_self_index = 1,2,3
; filament_settings_id = "ON AIR black PLA+ - eSUN baseline(on-air-v213-X1C-all-plates.3mf)";"Generic PETG";"Generic PETG"
; filament_shrink = 100%,100%,100%
; filament_soluble = 0,0,0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10,10,10
; filament_tower_interface_pre_extrusion_length = 0,0,0
; filament_tower_interface_print_temp = -1,-1,-1
; filament_tower_interface_purge_volume = 20,20,20
; filament_tower_ironing_area = 4,4,4
; filament_type = PLA;PETG;PETG
; filament_velocity_adaptation_factor = 1,1,1
; filament_vendor = eSUN;Generic;Generic
; filament_volume_map = 0,0,0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0,0,0
; first_x_layer_part_fan_speed = 0,0,0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 0
; flush_multiplier = 1
; flush_multiplier_fast = 1.2
; flush_volumes_matrix = 0,530,530,167,0,167,167,167,0
; flush_volumes_vector = 140,140,140,140,140,140
; full_fan_speed_layer = 0,0,0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 60
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0,0,0
; hole_coef_2 = -0.008,-0.008,-0.008
; hole_coef_3 = 0.23415,0.23415,0.23415
; hole_limit_max = 0.22,0.22,0.22
; hole_limit_min = 0.088,0.088,0.088
; host_type = octoprint
; hot_plate_temp = 55,70,70
; hot_plate_temp_initial_layer = 55,70,70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10,10,10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = "0.20mm Standard @BBL X1C";;;;
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 15
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.1
; initial_layer_speed = 15
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 100
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 100
; ironing_direction = 45
; ironing_fan_speed = -1,-1,-1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0,0,0
; machine_bed_mass_Y = 0
; machine_end_gcode = ;===== date: 20240528 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos\nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of \"timelapse_record_flag\"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A0 B20 L100 C37 D20 M40 E42 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C46 D10 M80 E46 F10 N80\nM1006 A44 B20 L100 C39 D20 M60 E48 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C48 D10 M60 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10  N100\nM1006 A49 B20 L100 C44 D20 M100 E41 F20 N100\nM1006 A0 B20 L100 C0 D20 M60 E0 F20 N100\nM1006 A0 B20 L100 C37 D20 M30 E37 F20 N60\nM1006 W\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\nM960 S5 P0 ; turn off logo lamp\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,500
; machine_max_force_Y = 0
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_printed_mass = 0
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,500
; machine_max_speed_y = 500,500
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0
; machine_min_travel_rate = 0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;===== machine: X1-0.4 ====================\n;===== date: 20251031 ==================\n;===== start printer sound ================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B10 L100 C37 D10 M60 E37 F10 N60\nM1006 A0 B10 L100 C41 D10 M60 E41 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A46 B10 L100 C43 D10 M70 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A43 B10 L100 C0 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A41 B10 L100 C0 D10 M100 E41 F10 N100\nM1006 A44 B10 L100 C0 D10 M100 E44 F10 N100\nM1006 A49 B10 L100 C0 D10 M100 E49 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A48 B10 L100 C44 D10 M60 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A44 B10 L100 C0 D10 M90 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N100\nM1006 A46 B10 L100 C43 D10 M60 E39 F10 N100\nM1006 W\n;===== turn on the HB fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\n;===== reset machine status =================\nM290 X40 Y40 Z2.6666666\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action:54\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n{if scan_first_layer}\n;=========register first layer scan=====\nM977 S1 P60\n{endif}\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]==\"PLA\"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_no_support_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_no_support_extruder]A\nM620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T{flush_temperatures[initial_no_support_extruder]}\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X128 Y128\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n;===== check scanner clarity ===========================\nG1 X128 Y128 F24000\nG28 Z P0\nM972 S5 P0\nG1 X230 Y15 F24000\n;===== check scanner clarity end =======================\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_no_support_extruder]==\"PLA\"}\n    {if (bed_temperature[initial_no_support_extruder] >45)||(bed_temperature_initial_layer[initial_no_support_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n    M142 P1 R35 S40\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\nM104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== mech mode fast check============================\n\n{if scan_first_layer}\n;start heatbed  scan====================================\nM976 S2 P1\nG90\nG1 X128 Y128 F20000\nM976 S3 P2  ;register void printing detection\n{endif}\n\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature[initial_no_support_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X231 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type==\"Textured PEI Plate\"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n\n;===== draw extrinsic para cali paint =================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M1002 gcode_claim_action : 8\n\n    T1000\n\n    G0 F1200.0 X231 Y12   Z0.2 E0.577\n    G0 F1200.0 X226 Y12   Z0.2 E0.275\n    G0 F1200.0 X226 Y1.5  Z0.2 E0.577\n    G0 F1200.0 X220 Y1.5  Z0.2 E0.330\n    G0 F1200.0 X220 Y8    Z0.2 E0.358\n    G0 F1200.0 X210 Y8    Z0.2 E0.549\n    G0 F1200.0 X210 Y1.5  Z0.2 E0.357\n\n    G0 X48.0 E11.9 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X48.0 Y12 E0.772 F1200.0\n    G0 X45.0 E0.22 F1200.0\n    G0 X35.0 Y6.0 E0.86 F1200.0\n\n    ;=========== extruder cali extrusion ==================\n    T1000\n    M83\n    {if default_acceleration > 0}\n        {if outer_wall_acceleration > 0}\n            M204 S[outer_wall_acceleration]\n        {else}\n            M204 S[default_acceleration]\n        {endif}\n    {endif}\n    G0 X35.000 Y6.000 Z0.300 F30000 E0\n    G1 F1500.000 E0.800\n    M106 S0 ; turn off fan\n    G0 X185.000 E9.35441 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G0 X187 Z0\n    G1 F1500.000 E-0.800\n    G0 Z1\n    G0 X180 Z0.3 F18000\n\n    M900 L1000.0 M1.0\n    M900 K0.040\n    G0 X45.000 F30000\n    G0 Y8.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.020\n    G0 X45.000 F30000\n    G0 Y10.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n    M400\n\n    G0 X45.000 F30000\n    M900 K0.000\n    G0 X45.000 F30000\n    G0 Y12.000 F30000\n    G1 F1500.000 E0.800\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 F1500.000 E-0.800\n    G1 X183 Z0.15 F30000\n    G1 X185\n    G1 Z1.0\n    G0 Y6.000 F30000 ; move y to clear pos\n    G1 Z0.3\n\n    G0 X45.000 F30000 ; move to start point\n\nM623 ; end of \"draw extrinsic para cali paint\"\n\n\nM1002 judge_flag extrude_cali_flag\nM622 J0\n    G0 X231 Y1.5 F30000\n    G0 X18 E14.3 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM623\n\nM104 S140\n\n\n;=========== laser and rgb calibration ===========\nM400\nM18 E\nM500 R\n\nM973 S3 P14\n\nG1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nT1100\nG1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos\nM400 P100\nM960 S1 P1\nM400 P100\nM973 S6 P0; use auto exposure for horizontal laser by xcam\nM960 S0 P0\n\nG1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos\nM960 S2 P1\nM400 P100\nM973 S6 P1; use auto exposure for vertical laser by xcam\nM960 S0 P0\n\n;=========== handeye calibration ======================\nM1002 judge_flag extrude_cali_flag\nM622 J1\n\n    M973 S3 P1 ; camera start stream\n    M400 P500\n    M973 S1\n    G0 F6000 X228.500 Y4.750 Z0.000\n    M960 S0 P1\n    M973 S1\n    M400 P800\n    M971 S6 P0\n    M973 S2 P0\n    M400 P500\n    G0 Z0.000 F12000\n    M960 S0 P0\n    M960 S1 P1\n    G0 X215.00 Y4.750\n    M400 P200\n    M971 S5 P1\n    M973 S2 P1\n    M400 P500\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y6.75\n    M400 P200\n    M971 S5 P3\n    G0 Z0.500 F12000\n    M960 S0 P0\n    M960 S2 P1\n    G0 X228.5 Y6.75\n    M400 P200\n    M971 S5 P4\n    M973 S2 P0\n    M400 P500\n    M960 S0 P0\n    M960 S1 P1\n    G0 X215.00 Y4.750\n    M400 P500\n    M971 S5 P2\n    M963 S1\n    M400 P1500\n    M964\n    T1100\n    G1 Z3 F3000\n\n    M400\n    M500 ; save cali data\n\n    M104 S{nozzle_temperature[initial_no_support_extruder]} ; rise nozzle temp now ,to reduce temp waiting time.\n\n    T1100\n    M400 P400\n    M960 S0 P0\n    G0 F30000.000 Y10.000 X65.000 Z0.000\n    M400 P400\n    M960 S1 P1\n    M400 P50\n\n    M969 S1 N3 A2000\n    G0 F360.000 X181.000 Z0.000\n    M980.3 A70.000 B{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60/4} C5.000 D{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*60} E5.000 F175.000 H1.000 I0.000 J0.020 K0.040\n    M400 P100\n    G0 F20000\n    G0 Z1 ; rise nozzle up\n    T1000 ; change to nozzle space\n    G0 X45.000 Y4.000 F30000 ; move to test line pos\n    M969 S0 ; turn off scanning\n    M960 S0 P0\n\n\n    G1 Z2 F20000\n    T1000\n    G0 X45.000 Y4.000 F30000 E0\n    M109 S{nozzle_temperature[initial_no_support_extruder]}\n    G0 Z0.3\n    G1 F1500.000 E3.600\n    G1 X65.000 E1.24726 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X70.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X75.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X80.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X85.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X90.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X95.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X100.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X105.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X110.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X115.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X120.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X125.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X130.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X135.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n\n    ; see if extrude cali success, if not ,use default value\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M400\n        M900 K0.02 M{outer_wall_volumetric_speed/(1.75*1.75/4*3.14)*0.02}\n    M623\n\n    G1 X140.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X145.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X150.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X155.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X160.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X165.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X170.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X175.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X180.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X185.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X190.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X195.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X200.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X205.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X210.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X215.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    G1 X220.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\n    G1 X225.000 E0.31181 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\n    M973 S4\n\nM623\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM973 S4 ; turn off scanner\nM400 ; wait all motion done before implement the emprical L parameters\n;M900 L500.0 ; Empirical parameters\nM109 S[nozzle_temperature_initial_layer]\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\n;===== purge line to wipe the nozzle ============================\nG1 E{-retraction_length[initial_no_support_extruder]} F1800\nG1 X18.0 Y2.5 Z0.8 F18000.0;Move to start position\nG1 E{retraction_length[initial_no_support_extruder]} F1800\nM109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\nG1 Z0.2\nG0 X239 E15 F{outer_wall_volumetric_speed/(0.3*0.5)    * 60}\nG0 Y12 E0.7 F{outer_wall_volumetric_speed/(0.3*0.5)/4* 60}\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 28
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 0%
; no_slow_down_for_cooling_on_outwalls = 0,0,0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 220,255,255
; nozzle_temperature_initial_layer = 220,255,255
; nozzle_temperature_range_high = 240,270,270
; nozzle_temperature_range_low = 190,220,220
; nozzle_type = hardened_steel
; nozzle_volume = 107
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 500
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 60
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100,90,90
; overhang_fan_threshold = 50%,10%,10%
; overhang_threshold_participating_cooling = 95%,95%,95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0,0,0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0,0,0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02,0.02,0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_in_clockwise = 0
; print_sequence = by object
; print_settings_id = 0.20mm Standard @BBL X1C
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab X1 Carbon
; printer_notes = 
; printer_settings_id = Bambu Lab X1 Carbon 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 1
; reduce_fan_stop_start_freq = 1,1,1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3,3,3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0,0,0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; skirt_per_object = 1
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1,1,1
; slow_down_layer_time = 6,12,12
; slow_down_min_speed = 20,20,20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 150
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 25%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = gyroid
; sparse_infill_speed = 120
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 45,70,70
; supertack_plate_temp_initial_layer = 45,70,70
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_fast_purge_mode = 0
; support_filament = 0
; support_interface_bottom_layers = 3
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.3
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 1
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = snug
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = normal(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45,70,70
; template_custom_gcode = 
; textured_plate_temp = 55,70,70
; textured_plate_temp_initial_layer = 55,70,70
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;========Date 20250206========\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\nM1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C10 O0\nG92 E0\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; SKIPPABLE_END\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 45
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle";"Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab X2D 0.4 nozzle";"Bambu Lab A2L 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = arachne
; wall_loops = 4
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 22,40,40
; wipe_tower_y = 185,200,200
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R76
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: X1-0.4 ====================
;===== date: 20251031 ==================
;===== start printer sound ================
M17
M400 S1
M1006 S1
M1006 A0 B10 L100 C37 D10 M60 E37 F10 N60
M1006 A0 B10 L100 C41 D10 M60 E41 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A46 B10 L100 C43 D10 M70 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A43 B10 L100 C0 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A41 B10 L100 C0 D10 M100 E41 F10 N100
M1006 A44 B10 L100 C0 D10 M100 E44 F10 N100
M1006 A49 B10 L100 C0 D10 M100 E49 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A48 B10 L100 C44 D10 M60 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A44 B10 L100 C0 D10 M90 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N100
M1006 A46 B10 L100 C43 D10 M60 E39 F10 N100
M1006 W
;===== turn on the HB fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
;===== reset machine status =================
M290 X40 Y40 Z2.6666666
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action:54
M140 S55 ;set bed temp
M190 S55 ;wait for bed temp



;=============turn on fans to prevent PLA jamming=================

    
    M106 P3 S180
    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F399.119 T240

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
M73 P0 R75
G1 E50 F200
M400
M104 S220
G92 E0
M73 P6 R71
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
G1 E-0.5 F300

M73 P7 R70
G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
G1 Z10
G1 F30000
G1 X128 Y128
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================

;===== check scanner clarity ===========================
G1 X128 Y128 F24000
G28 Z P0
M972 S5 P0
G1 X230 Y15 F24000
;===== check scanner clarity end =======================

;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X103.927 Y55.3254 I109.966 J159.346
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression

;=============turn on fans to prevent PLA jamming=================

    
    M106 P3 S180
    ;Prevent PLA from jamming
    M142 P1 R35 S40

M106 P2 S100 ; turn on big fan ,to cool down toolhead

M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== mech mode fast check============================



;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
G1 Z0.2
G0 E2 F300
G0 X240 E15 F1809.98
G0 Y11 E0.700 F452.496
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X231 E0.700 F1809.98
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Textured PEI Plate

G29.1 Z-0.04 ; for Textured PEI Plate


;===== draw extrinsic para cali paint =================
M1002 judge_flag extrude_cali_flag
M622 J1

    M1002 gcode_claim_action : 8

    T1000

    G0 F1200.0 X231 Y12   Z0.2 E0.577
    G0 F1200.0 X226 Y12   Z0.2 E0.275
    G0 F1200.0 X226 Y1.5  Z0.2 E0.577
    G0 F1200.0 X220 Y1.5  Z0.2 E0.330
    G0 F1200.0 X220 Y8    Z0.2 E0.358
    G0 F1200.0 X210 Y8    Z0.2 E0.549
    G0 F1200.0 X210 Y1.5  Z0.2 E0.357

    G0 X48.0 E11.9 F1809.98
    G0 X48.0 Y12 E0.772 F1200.0
    G0 X45.0 E0.22 F1200.0
    G0 X35.0 Y6.0 E0.86 F1200.0

    ;=========== extruder cali extrusion ==================
    T1000
    M83
    
        
            M204 S500
        
    
    G0 X35.000 Y6.000 Z0.300 F30000 E0
    G1 F1500.000 E0.800
    M106 S0 ; turn off fan
    G0 X185.000 E9.35441 F1809.98
    G0 X187 Z0
    G1 F1500.000 E-0.800
    G0 Z1
    G0 X180 Z0.3 F18000

    M900 L1000.0 M1.0
    M900 K0.040
    G0 X45.000 F30000
    G0 Y8.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F452.496
    G1 X70.000 E0.31181 F452.496
    G1 X75.000 E0.31181 F1809.98
    G1 X80.000 E0.31181 F452.496
    G1 X85.000 E0.31181 F1809.98
    G1 X90.000 E0.31181 F452.496
    G1 X95.000 E0.31181 F1809.98
    G1 X100.000 E0.31181 F452.496
    G1 X105.000 E0.31181 F1809.98
    G1 X110.000 E0.31181 F452.496
    G1 X115.000 E0.31181 F1809.98
    G1 X120.000 E0.31181 F452.496
    G1 X125.000 E0.31181 F1809.98
    G1 X130.000 E0.31181 F452.496
    G1 X135.000 E0.31181 F1809.98
    G1 X140.000 E0.31181 F452.496
    G1 X145.000 E0.31181 F1809.98
    G1 X150.000 E0.31181 F452.496
    G1 X155.000 E0.31181 F1809.98
    G1 X160.000 E0.31181 F452.496
    G1 X165.000 E0.31181 F1809.98
    G1 X170.000 E0.31181 F452.496
    G1 X175.000 E0.31181 F1809.98
    G1 X180.000 E0.31181 F1809.98
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.020
    G0 X45.000 F30000
    G0 Y10.000 F30000
    G1 F1500.000 E0.800
M73 P8 R70
    G1 X65.000 E1.24726 F452.496
    G1 X70.000 E0.31181 F452.496
    G1 X75.000 E0.31181 F1809.98
    G1 X80.000 E0.31181 F452.496
    G1 X85.000 E0.31181 F1809.98
    G1 X90.000 E0.31181 F452.496
    G1 X95.000 E0.31181 F1809.98
    G1 X100.000 E0.31181 F452.496
    G1 X105.000 E0.31181 F1809.98
    G1 X110.000 E0.31181 F452.496
    G1 X115.000 E0.31181 F1809.98
    G1 X120.000 E0.31181 F452.496
    G1 X125.000 E0.31181 F1809.98
M73 P8 R69
    G1 X130.000 E0.31181 F452.496
    G1 X135.000 E0.31181 F1809.98
    G1 X140.000 E0.31181 F452.496
    G1 X145.000 E0.31181 F1809.98
    G1 X150.000 E0.31181 F452.496
    G1 X155.000 E0.31181 F1809.98
    G1 X160.000 E0.31181 F452.496
    G1 X165.000 E0.31181 F1809.98
    G1 X170.000 E0.31181 F452.496
    G1 X175.000 E0.31181 F1809.98
    G1 X180.000 E0.31181 F1809.98
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3
    M400

    G0 X45.000 F30000
    M900 K0.000
    G0 X45.000 F30000
    G0 Y12.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F452.496
    G1 X70.000 E0.31181 F452.496
    G1 X75.000 E0.31181 F1809.98
    G1 X80.000 E0.31181 F452.496
    G1 X85.000 E0.31181 F1809.98
    G1 X90.000 E0.31181 F452.496
    G1 X95.000 E0.31181 F1809.98
    G1 X100.000 E0.31181 F452.496
    G1 X105.000 E0.31181 F1809.98
    G1 X110.000 E0.31181 F452.496
    G1 X115.000 E0.31181 F1809.98
    G1 X120.000 E0.31181 F452.496
    G1 X125.000 E0.31181 F1809.98
    G1 X130.000 E0.31181 F452.496
    G1 X135.000 E0.31181 F1809.98
    G1 X140.000 E0.31181 F452.496
    G1 X145.000 E0.31181 F1809.98
    G1 X150.000 E0.31181 F452.496
    G1 X155.000 E0.31181 F1809.98
    G1 X160.000 E0.31181 F452.496
    G1 X165.000 E0.31181 F1809.98
    G1 X170.000 E0.31181 F452.496
    G1 X175.000 E0.31181 F1809.98
    G1 X180.000 E0.31181 F1809.98
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3

    G0 X45.000 F30000 ; move to start point

M623 ; end of "draw extrinsic para cali paint"


M1002 judge_flag extrude_cali_flag
M622 J0
    G0 X231 Y1.5 F30000
    G0 X18 E14.3 F1809.98
M623

M104 S140


;=========== laser and rgb calibration ===========
M400
M18 E
M500 R

M973 S3 P14

G1 X120 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
T1100
G1 X235.0 Y1.0 Z0.3 F18000.0;Move to first extrude line pos
M400 P100
M960 S1 P1
M400 P100
M973 S6 P0; use auto exposure for horizontal laser by xcam
M960 S0 P0

G1 X240.0 Y6.0 Z0.3 F18000.0;Move to vertical extrude line pos
M960 S2 P1
M400 P100
M973 S6 P1; use auto exposure for vertical laser by xcam
M960 S0 P0

;=========== handeye calibration ======================
M1002 judge_flag extrude_cali_flag
M622 J1

    M973 S3 P1 ; camera start stream
    M400 P500
    M973 S1
    G0 F6000 X228.500 Y4.750 Z0.000
    M960 S0 P1
    M973 S1
    M400 P800
    M971 S6 P0
    M973 S2 P0
    M400 P500
    G0 Z0.000 F12000
    M960 S0 P0
    M960 S1 P1
    G0 X215.00 Y4.750
    M400 P200
    M971 S5 P1
    M973 S2 P1
    M400 P500
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y6.75
    M400 P200
    M971 S5 P3
    G0 Z0.500 F12000
    M960 S0 P0
    M960 S2 P1
    G0 X228.5 Y6.75
    M400 P200
    M971 S5 P4
    M973 S2 P0
    M400 P500
    M960 S0 P0
    M960 S1 P1
    G0 X215.00 Y4.750
    M400 P500
    M971 S5 P2
    M963 S1
    M400 P1500
    M964
    T1100
    G1 Z3 F3000

    M400
    M500 ; save cali data

    M104 S220 ; rise nozzle temp now ,to reduce temp waiting time.

    T1100
    M400 P400
    M960 S0 P0
    G0 F30000.000 Y10.000 X65.000 Z0.000
    M400 P400
    M960 S1 P1
    M400 P50

    M969 S1 N3 A2000
    G0 F360.000 X181.000 Z0.000
    M980.3 A70.000 B28.2332 C5.000 D112.933 E5.000 F175.000 H1.000 I0.000 J0.020 K0.040
    M400 P100
    G0 F20000
    G0 Z1 ; rise nozzle up
    T1000 ; change to nozzle space
    G0 X45.000 Y4.000 F30000 ; move to test line pos
    M969 S0 ; turn off scanning
    M960 S0 P0


    G1 Z2 F20000
    T1000
    G0 X45.000 Y4.000 F30000 E0
    M109 S220
    G0 Z0.3
    G1 F1500.000 E3.600
    G1 X65.000 E1.24726 F452.496
    G1 X70.000 E0.31181 F452.496
    G1 X75.000 E0.31181 F1809.98
    G1 X80.000 E0.31181 F452.496
    G1 X85.000 E0.31181 F1809.98
    G1 X90.000 E0.31181 F452.496
    G1 X95.000 E0.31181 F1809.98
    G1 X100.000 E0.31181 F452.496
    G1 X105.000 E0.31181 F1809.98
M73 P9 R69
    G1 X110.000 E0.31181 F452.496
    G1 X115.000 E0.31181 F1809.98
    G1 X120.000 E0.31181 F452.496
    G1 X125.000 E0.31181 F1809.98
    G1 X130.000 E0.31181 F452.496
    G1 X135.000 E0.31181 F1809.98

    ; see if extrude cali success, if not ,use default value
    M1002 judge_last_extrude_cali_success
    M622 J0
        M400
        M900 K0.02 M0.0376442
    M623

    G1 X140.000 E0.31181 F452.496
    G1 X145.000 E0.31181 F1809.98
    G1 X150.000 E0.31181 F452.496
    G1 X155.000 E0.31181 F1809.98
    G1 X160.000 E0.31181 F452.496
    G1 X165.000 E0.31181 F1809.98
    G1 X170.000 E0.31181 F452.496
    G1 X175.000 E0.31181 F1809.98
    G1 X180.000 E0.31181 F452.496
    G1 X185.000 E0.31181 F1809.98
    G1 X190.000 E0.31181 F452.496
    G1 X195.000 E0.31181 F1809.98
    G1 X200.000 E0.31181 F452.496
    G1 X205.000 E0.31181 F1809.98
    G1 X210.000 E0.31181 F452.496
    G1 X215.000 E0.31181 F1809.98
    G1 X220.000 E0.31181 F452.496
    G1 X225.000 E0.31181 F1809.98
    M973 S4

M623

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M973 S4 ; turn off scanner
M400 ; wait all motion done before implement the emprical L parameters
;M900 L500.0 ; Empirical parameters
M109 S220
M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
M83
T1000
;===== purge line to wipe the nozzle ============================
G1 E-0.8 F1800
G1 X18.0 Y2.5 Z0.8 F18000.0;Move to start position
G1 E0.8 F1800
M109 S220
G1 Z0.2
G0 X239 E15 F1809.98
G0 Y12 E0.7 F452.496
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S150


;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.1
; LAYER_HEIGHT: 0.1
G1 E-.8 F1800
; layer num/total_layer_count: 1/58
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
G1 X104.211 Y55.007 F30000
M204 S6000
G1 Z.4
G1 Z.1
G1 E.8 F1800
; FEATURE: Brim
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X104.306 Y54.72 E.0059
G1 X104.548 Y54.278 E.00982
G1 X104.804 Y54.007 E.00727
G1 X105.366 Y53.686 E.01262
G1 X105.753 Y53.583 E.00781
G1 X105.999 Y53.565 E.00482
G1 X209.977 Y53.565 E2.0273
G1 X210.37 Y53.61 E.00771
G1 X210.765 Y53.751 E.00817
G1 X211.1 Y53.945 E.00755
G1 X211.374 Y54.203 E.00733
G1 X211.695 Y54.764 E.01262
G1 X211.798 Y55.152 E.00781
G1 X211.816 Y55.398 E.00482
G1 X211.816 Y93.376 E.74047
G1 X211.77 Y93.772 E.00777
G1 X211.675 Y94.059 E.0059
G1 X211.433 Y94.501 E.00982
G1 X211.178 Y94.772 E.00727
G1 X210.616 Y95.093 E.01262
G1 X210.229 Y95.196 E.00781
G1 X209.982 Y95.214 E.00482
G1 X109.005 Y95.214 E1.96881
G1 X108.61 Y95.169 E.00774
G1 X108.25 Y95.045 E.00743
G1 X107.907 Y94.854 E.00765
G1 X107.694 Y94.673 E.00546
G1 X104.71 Y91.69 E.08227
G1 X104.463 Y91.379 E.00774
G1 X104.297 Y91.036 E.00743
M73 P9 R68
G1 X104.189 Y90.659 E.00765
G1 X104.166 Y90.38 E.00546
G1 X104.166 Y55.403 E.68196
G1 X104.205 Y55.067 E.0066
M204 S6000
G1 X104.679 Y55.126 F30000
G1 F900
M204 S500
G1 X104.743 Y54.924 E.00412
G1 X104.93 Y54.578 E.00768
G1 X105.122 Y54.376 E.00543
G1 X105.567 Y54.127 E.00994
G1 X105.819 Y54.06 E.0051
G1 X106.022 Y54.043 E.00396
G1 X209.958 Y54.044 E2.02649
G1 X210.276 Y54.085 E.00626
G1 X210.55 Y54.182 E.00567
M73 P10 R68
G1 X210.798 Y54.323 E.00556
G1 X210.978 Y54.487 E.00475
G1 X211.253 Y54.966 E.01076
G1 X211.32 Y55.218 E.00509
G1 X211.337 Y55.421 E.00397
G1 X211.337 Y93.34 E.73933
G1 X211.302 Y93.653 E.00614
G1 X211.239 Y93.855 E.00412
G1 X211.051 Y94.201 E.00768
G1 X210.859 Y94.403 E.00543
G1 X210.415 Y94.652 E.00994
G1 X210.162 Y94.719 E.00509
G1 X209.959 Y94.736 E.00397
G1 X109.04 Y94.736 E1.96767
G1 X108.732 Y94.701 E.00604
G1 X108.458 Y94.61 E.00564
G1 X108.193 Y94.466 E.00588
G1 X108.022 Y94.325 E.00432
G1 X105.074 Y91.376 E.0813
G1 X104.88 Y91.135 E.00603
G1 X104.742 Y90.852 E.00613
G1 X104.666 Y90.586 E.00539
G1 X104.644 Y90.354 E.00454
G1 X104.644 Y55.439 E.68076
G1 X104.673 Y55.185 E.00497
M204 S6000
G1 X105.145 Y55.261 F30000
G1 F900
M204 S500
G1 X105.151 Y55.229 E.00065
G1 X105.21 Y55.051 E.00366
G1 X105.35 Y54.827 E.00514
G1 X105.457 Y54.724 E.00289
G1 X105.681 Y54.594 E.00506
G1 X106.001 Y54.522 E.00641
G1 X209.98 Y54.522 E2.02733
G1 X210.284 Y54.585 E.00606
G1 X210.375 Y54.624 E.00192
G1 X210.551 Y54.746 E.00418
G1 X210.656 Y54.856 E.00296
G1 X210.787 Y55.079 E.00506
G1 X210.859 Y55.4 E.00641
G1 X210.859 Y93.382 E.74056
G1 X210.795 Y93.686 E.00606
G1 X210.756 Y93.773 E.00186
G1 X210.634 Y93.949 E.00418
G1 X210.525 Y94.055 E.00296
M73 P10 R67
G1 X210.301 Y94.186 E.00506
M73 P11 R67
G1 X209.98 Y94.257 E.00641
G1 X109.001 Y94.257 E1.96884
G1 X108.812 Y94.231 E.00372
G1 X108.669 Y94.18 E.00296
G1 X108.504 Y94.094 E.00363
G1 X108.369 Y93.995 E.00325
G1 X105.384 Y91.01 E.08231
G1 X105.27 Y90.858 E.00372
G1 X105.204 Y90.721 E.00296
G1 X105.148 Y90.544 E.00363
G1 X105.123 Y90.379 E.00325
G1 X105.123 Y55.401 E.68197
G1 X105.136 Y55.321 E.00159
M204 S6000
G1 X105.602 Y55.39 F30000
G1 F900
M204 S500
G1 X105.669 Y55.184 E.00422
G1 X105.801 Y55.057 E.00357
G1 X105.991 Y55 E.00386
G1 X209.991 Y55 E2.02774
G1 X210.086 Y55.02 E.0019
G1 X210.196 Y55.068 E.00234
G1 X210.323 Y55.2 E.00357
G1 X210.38 Y55.39 E.00386
G1 X210.38 Y93.39 E.7409
G1 X210.36 Y93.485 E.0019
G1 X210.312 Y93.595 E.00234
G1 X210.18 Y93.722 E.00357
G1 X209.991 Y93.779 E.00386
G1 X108.991 Y93.779 E1.96924
G1 X108.899 Y93.761 E.00182
G1 X108.716 Y93.665 E.00404
G1 X105.716 Y90.665 E.08272
G1 X105.664 Y90.587 E.00182
G1 X105.602 Y90.39 E.00404
G1 X105.602 Y55.45 E.68124
; WIPE_START
G1 X105.669 Y55.184 E-.10414
G1 X105.801 Y55.057 E-.06958
G1 X105.991 Y55 E-.07518
G1 X107.336 Y55 E-.5111
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X107.58 Y56.107 Z.5 F30000
G1 X107.826 Y57.225
G1 Z.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.49999
G1 F900
M204 S500
G1 X208.155 Y57.225 E1.95612
G1 X208.155 Y74.39 E.33466
G1 X208.155 Y91.554 E.33466
G1 X109.751 Y91.554 E1.91859
G1 X107.826 Y89.629 E.05307
G1 X107.826 Y57.285 E.63061
M204 S6000
G1 X107.348 Y56.747 F30000
G1 F900
M204 S500
G1 X208.634 Y56.747 E1.97478
G1 X208.634 Y74.39 E.34399
G1 X208.634 Y92.033 E.34399
G1 X109.553 Y92.033 E1.93179
G1 X107.348 Y89.827 E.0608
G1 X107.348 Y56.807 E.64381
M204 S6000
G1 X106.869 Y56.268 F30000
G1 F900
M204 S500
G1 X209.112 Y56.268 E1.99344
G1 X209.112 Y74.39 E.35332
G1 X209.112 Y92.511 E.35332
G1 X109.355 Y92.511 E1.94498
G1 X106.869 Y90.026 E.06853
G1 X106.869 Y56.328 E.657
M204 S6000
G1 X106.391 Y55.79 F30000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X209.591 Y55.79 E2.0121
G1 X209.591 Y74.39 E.36265
G1 X209.591 Y92.99 E.36265
; object ids of layer 1 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer1 end: 272
M625
G1 X109.156 Y92.99 E1.95817
G1 X106.391 Y90.224 E.07626
G1 X106.391 Y55.85 E.6702
G1 E-.8 F1800
M204 S6000
G1 X114.022 Y55.968 Z.5 F30000
G1 X206.995 Y57.417 Z.5
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5007
G1 F900
M204 S500
G1 X207.748 Y58.17 E.02081
G1 X207.748 Y58.848 E.01323
G1 X206.533 Y57.632 E.03358
G1 X205.855 Y57.632 E.01323
M73 P12 R67
G1 X207.748 Y59.526 E.05229
G1 X207.748 Y60.203 E.01323
G1 X205.177 Y57.632 E.07101
G1 X204.499 Y57.632 E.01323
G1 X207.748 Y60.881 E.08972
G1 X207.748 Y61.559 E.01323
G1 X203.822 Y57.632 E.10844
G1 X203.144 Y57.632 E.01323
G1 X207.748 Y62.237 E.12715
G1 X207.748 Y62.914 E.01323
G1 X202.466 Y57.632 E.14587
G1 X201.788 Y57.632 E.01323
G1 X207.748 Y63.592 E.16458
G1 X207.748 Y64.27 E.01323
M73 P12 R66
G1 X201.111 Y57.632 E.1833
G1 X200.433 Y57.632 E.01323
G1 X207.748 Y64.948 E.20201
G1 X207.748 Y65.625 E.01323
G1 X199.755 Y57.632 E.22073
G1 X199.077 Y57.632 E.01323
G1 X207.748 Y66.303 E.23944
G1 X207.748 Y66.981 E.01323
G1 X198.4 Y57.632 E.25816
G1 X197.722 Y57.632 E.01323
G1 X207.748 Y67.659 E.27688
G1 X207.748 Y68.336 E.01323
G1 X197.044 Y57.632 E.29559
G1 X196.366 Y57.632 E.01323
G1 X207.748 Y69.014 E.31431
G1 X207.748 Y69.692 E.01323
G1 X195.689 Y57.632 E.33302
G1 X195.011 Y57.632 E.01323
G1 X207.748 Y70.37 E.35174
G1 X207.748 Y71.047 E.01323
G1 X194.333 Y57.632 E.37045
G1 X193.655 Y57.632 E.01323
G1 X207.748 Y71.725 E.38917
G1 X207.748 Y72.403 E.01323
G1 X192.978 Y57.632 E.40788
G1 X192.3 Y57.632 E.01323
G1 X207.748 Y73.081 E.4266
G1 X207.748 Y73.758 E.01323
G1 X191.622 Y57.632 E.44531
G1 X190.944 Y57.632 E.01323
G1 X207.748 Y74.436 E.46403
G1 X207.748 Y75.114 E.01323
G1 X190.267 Y57.632 E.48274
G1 X189.589 Y57.632 E.01323
G1 X207.748 Y75.791 E.50146
G1 X207.748 Y76.469 E.01323
G1 X188.911 Y57.632 E.52017
G1 X188.233 Y57.632 E.01323
G1 X207.748 Y77.147 E.53889
G1 X207.748 Y77.825 E.01323
G1 X187.556 Y57.632 E.5576
G1 X186.878 Y57.632 E.01323
G1 X207.748 Y78.502 E.57632
G1 X207.748 Y79.18 E.01323
G1 X186.2 Y57.632 E.59503
G1 X185.522 Y57.632 E.01323
G1 X207.748 Y79.858 E.61375
M73 P13 R66
G1 X207.748 Y80.536 E.01323
G1 X184.845 Y57.632 E.63247
G1 X184.167 Y57.632 E.01323
G1 X207.748 Y81.213 E.65118
G1 X207.748 Y81.891 E.01323
G1 X183.489 Y57.632 E.6699
G1 X182.811 Y57.632 E.01323
G1 X207.748 Y82.569 E.68861
G1 X207.748 Y83.247 E.01323
G1 X182.134 Y57.632 E.70733
M73 P13 R65
G1 X181.456 Y57.632 E.01323
G1 X207.748 Y83.924 E.72604
G1 X207.748 Y84.602 E.01323
G1 X180.778 Y57.632 E.74476
G1 X180.1 Y57.632 E.01323
G1 X207.748 Y85.28 E.76347
G1 X207.748 Y85.958 E.01323
G1 X179.423 Y57.632 E.78219
G1 X178.745 Y57.632 E.01323
G1 X207.748 Y86.635 E.8009
G1 X207.748 Y87.313 E.01323
M73 P14 R65
G1 X178.067 Y57.632 E.81962
G1 X177.389 Y57.632 E.01323
G1 X207.748 Y87.991 E.83833
G1 X207.748 Y88.669 E.01323
G1 X176.712 Y57.632 E.85705
G1 X176.034 Y57.632 E.01323
G1 X207.748 Y89.346 E.87576
G1 X207.748 Y90.024 E.01323
G1 X175.356 Y57.632 E.89448
G1 X174.678 Y57.632 E.01323
G1 X207.748 Y90.702 E.91319
G1 X207.748 Y91.147 E.0087
G1 X207.516 Y91.147 E.00454
G1 X174.001 Y57.632 E.92549
G1 X173.323 Y57.632 E.01323
G1 X206.838 Y91.147 E.92549
G1 X206.161 Y91.147 E.01323
G1 X172.645 Y57.632 E.92549
G1 X171.967 Y57.632 E.01323
G1 X205.483 Y91.147 E.92549
G1 X204.805 Y91.147 E.01323
G1 X171.29 Y57.632 E.92549
G1 X170.612 Y57.632 E.01323
G1 X204.127 Y91.147 E.92549
G1 X203.45 Y91.147 E.01323
G1 X169.934 Y57.632 E.92549
G1 X169.256 Y57.632 E.01323
G1 X202.772 Y91.147 E.92549
G1 X202.094 Y91.147 E.01323
G1 X168.579 Y57.632 E.92549
G1 X167.901 Y57.632 E.01323
G1 X201.416 Y91.147 E.92549
G1 X200.739 Y91.147 E.01323
G1 X167.223 Y57.632 E.92549
G1 X166.545 Y57.632 E.01323
G1 X200.061 Y91.147 E.92549
G1 X199.383 Y91.147 E.01323
G1 X165.868 Y57.632 E.92549
G1 X165.19 Y57.632 E.01323
G1 X198.705 Y91.147 E.92549
G1 X198.028 Y91.147 E.01323
G1 X164.512 Y57.632 E.92549
G1 X163.834 Y57.632 E.01323
G1 X197.35 Y91.147 E.92549
G1 X196.672 Y91.147 E.01323
G1 X163.157 Y57.632 E.92549
G1 X162.479 Y57.632 E.01323
G1 X195.994 Y91.147 E.92549
G1 X195.317 Y91.147 E.01323
G1 X161.801 Y57.632 E.92549
G1 X161.123 Y57.632 E.01323
G1 X194.639 Y91.147 E.92549
G1 X193.961 Y91.147 E.01323
G1 X160.446 Y57.632 E.92549
G1 X159.768 Y57.632 E.01323
G1 X193.283 Y91.147 E.92549
G1 X192.606 Y91.147 E.01323
G1 X159.09 Y57.632 E.92549
G1 X158.412 Y57.632 E.01323
G1 X191.928 Y91.147 E.92549
M73 P14 R64
G1 X191.25 Y91.147 E.01323
G1 X157.735 Y57.632 E.92549
G1 X157.057 Y57.632 E.01323
G1 X190.572 Y91.147 E.92549
G1 X189.895 Y91.147 E.01323
G1 X156.379 Y57.632 E.92549
G1 X155.701 Y57.632 E.01323
G1 X189.217 Y91.147 E.92549
G1 X188.539 Y91.147 E.01323
G1 X155.024 Y57.632 E.92549
M73 P15 R64
G1 X154.346 Y57.632 E.01323
G1 X187.861 Y91.147 E.92549
G1 X187.184 Y91.147 E.01323
G1 X153.668 Y57.632 E.92549
G1 X152.99 Y57.632 E.01323
G1 X186.506 Y91.147 E.92549
G1 X185.828 Y91.147 E.01323
G1 X152.313 Y57.632 E.92549
G1 X151.635 Y57.632 E.01323
G1 X185.15 Y91.147 E.92549
G1 X184.473 Y91.147 E.01323
G1 X150.957 Y57.632 E.92549
G1 X150.279 Y57.632 E.01323
G1 X183.795 Y91.147 E.92549
G1 X183.117 Y91.147 E.01323
G1 X149.602 Y57.632 E.92549
G1 X148.924 Y57.632 E.01323
G1 X182.439 Y91.147 E.92549
G1 X181.762 Y91.147 E.01323
G1 X148.246 Y57.632 E.92549
G1 X147.568 Y57.632 E.01323
G1 X181.084 Y91.147 E.92549
G1 X180.406 Y91.147 E.01323
G1 X146.891 Y57.632 E.92549
G1 X146.213 Y57.632 E.01323
G1 X179.728 Y91.147 E.92549
G1 X179.051 Y91.147 E.01323
G1 X145.535 Y57.632 E.92549
G1 X144.857 Y57.632 E.01323
G1 X178.373 Y91.147 E.92549
G1 X177.695 Y91.147 E.01323
G1 X144.18 Y57.632 E.92549
G1 X143.502 Y57.632 E.01323
G1 X177.017 Y91.147 E.92549
G1 X176.34 Y91.147 E.01323
G1 X142.824 Y57.632 E.92549
M73 P16 R64
G1 X142.147 Y57.632 E.01323
G1 X175.662 Y91.147 E.92549
G1 X174.984 Y91.147 E.01323
G1 X141.469 Y57.632 E.92549
G1 X140.791 Y57.632 E.01323
M73 P16 R63
G1 X174.306 Y91.147 E.92549
G1 X173.629 Y91.147 E.01323
G1 X140.113 Y57.632 E.92549
G1 X139.436 Y57.632 E.01323
G1 X172.951 Y91.147 E.92549
G1 X172.273 Y91.147 E.01323
G1 X138.758 Y57.632 E.92549
G1 X138.08 Y57.632 E.01323
G1 X171.595 Y91.147 E.92549
G1 X170.918 Y91.147 E.01323
G1 X137.402 Y57.632 E.92549
G1 X136.725 Y57.632 E.01323
G1 X170.24 Y91.147 E.92549
G1 X169.562 Y91.147 E.01323
G1 X136.047 Y57.632 E.92549
G1 X135.369 Y57.632 E.01323
G1 X168.884 Y91.147 E.92549
G1 X168.207 Y91.147 E.01323
G1 X134.691 Y57.632 E.92549
G1 X134.014 Y57.632 E.01323
G1 X167.529 Y91.147 E.92549
G1 X166.851 Y91.147 E.01323
G1 X133.336 Y57.632 E.92549
G1 X132.658 Y57.632 E.01323
M73 P17 R63
G1 X166.173 Y91.147 E.92549
G1 X165.496 Y91.147 E.01323
G1 X131.98 Y57.632 E.92549
G1 X131.303 Y57.632 E.01323
G1 X164.818 Y91.147 E.92549
G1 X164.14 Y91.147 E.01323
G1 X130.625 Y57.632 E.92549
G1 X129.947 Y57.632 E.01323
G1 X163.462 Y91.147 E.92549
G1 X162.785 Y91.147 E.01323
G1 X129.269 Y57.632 E.92549
G1 X128.592 Y57.632 E.01323
G1 X162.107 Y91.147 E.92549
G1 X161.429 Y91.147 E.01323
M73 P17 R62
G1 X127.914 Y57.632 E.92549
G1 X127.236 Y57.632 E.01323
G1 X160.751 Y91.147 E.92549
G1 X160.074 Y91.147 E.01323
G1 X126.558 Y57.632 E.92549
G1 X125.881 Y57.632 E.01323
G1 X159.396 Y91.147 E.92549
G1 X158.718 Y91.147 E.01323
G1 X125.203 Y57.632 E.92549
G1 X124.525 Y57.632 E.01323
G1 X158.04 Y91.147 E.92549
G1 X157.363 Y91.147 E.01323
G1 X123.847 Y57.632 E.92549
G1 X123.17 Y57.632 E.01323
G1 X156.685 Y91.147 E.92549
G1 X156.007 Y91.147 E.01323
M73 P18 R62
G1 X122.492 Y57.632 E.92549
G1 X121.814 Y57.632 E.01323
G1 X155.329 Y91.147 E.92549
G1 X154.652 Y91.147 E.01323
G1 X121.136 Y57.632 E.92549
G1 X120.459 Y57.632 E.01323
G1 X153.974 Y91.147 E.92549
G1 X153.296 Y91.147 E.01323
G1 X119.781 Y57.632 E.92549
G1 X119.103 Y57.632 E.01323
G1 X152.618 Y91.147 E.92549
G1 X151.941 Y91.147 E.01323
G1 X118.425 Y57.632 E.92549
G1 X117.748 Y57.632 E.01323
G1 X151.263 Y91.147 E.92549
G1 X150.585 Y91.147 E.01323
G1 X117.07 Y57.632 E.92549
G1 X116.392 Y57.632 E.01323
G1 X149.907 Y91.147 E.92549
G1 X149.23 Y91.147 E.01323
M73 P18 R61
G1 X115.714 Y57.632 E.92549
G1 X115.037 Y57.632 E.01323
G1 X148.552 Y91.147 E.92549
G1 X147.874 Y91.147 E.01323
G1 X114.359 Y57.632 E.92549
G1 X113.681 Y57.632 E.01323
G1 X147.196 Y91.147 E.92549
G1 X146.519 Y91.147 E.01323
M73 P19 R61
G1 X113.003 Y57.632 E.92549
G1 X112.326 Y57.632 E.01323
G1 X145.841 Y91.147 E.92549
G1 X145.163 Y91.147 E.01323
G1 X111.648 Y57.632 E.92549
G1 X110.97 Y57.632 E.01323
G1 X144.485 Y91.147 E.92549
G1 X143.808 Y91.147 E.01323
G1 X110.292 Y57.632 E.92549
G1 X109.615 Y57.632 E.01323
G1 X143.13 Y91.147 E.92549
G1 X142.452 Y91.147 E.01323
G1 X108.937 Y57.632 E.92549
G1 X108.259 Y57.632 E.01323
G1 X141.775 Y91.147 E.92549
G1 X141.097 Y91.147 E.01323
G1 X108.233 Y58.284 E.90749
G1 X108.233 Y58.961 E.01323
G1 X140.419 Y91.147 E.88878
G1 X139.741 Y91.147 E.01323
G1 X108.233 Y59.639 E.87006
G1 X108.233 Y60.317 E.01323
G1 X139.064 Y91.147 E.85135
G1 X138.386 Y91.147 E.01323
G1 X108.233 Y60.995 E.83263
G1 X108.233 Y61.672 E.01323
G1 X137.708 Y91.147 E.81392
G1 X137.03 Y91.147 E.01323
M73 P20 R61
G1 X108.233 Y62.35 E.7952
G1 X108.233 Y63.028 E.01323
M73 P20 R60
G1 X136.353 Y91.147 E.77649
G1 X135.675 Y91.147 E.01323
G1 X108.233 Y63.706 E.75777
G1 X108.233 Y64.383 E.01323
G1 X134.997 Y91.147 E.73906
G1 X134.319 Y91.147 E.01323
G1 X108.233 Y65.061 E.72034
G1 X108.233 Y65.739 E.01323
G1 X133.642 Y91.147 E.70163
G1 X132.964 Y91.147 E.01323
G1 X108.233 Y66.417 E.68291
G1 X108.233 Y67.094 E.01323
G1 X132.286 Y91.147 E.6642
G1 X131.608 Y91.147 E.01323
G1 X108.233 Y67.772 E.64548
G1 X108.233 Y68.45 E.01323
G1 X130.931 Y91.147 E.62677
G1 X130.253 Y91.147 E.01323
G1 X108.233 Y69.128 E.60805
G1 X108.233 Y69.805 E.01323
G1 X129.575 Y91.147 E.58933
G1 X128.897 Y91.147 E.01323
G1 X108.233 Y70.483 E.57062
G1 X108.233 Y71.161 E.01323
G1 X128.22 Y91.147 E.5519
G1 X127.542 Y91.147 E.01323
M73 P21 R60
G1 X108.233 Y71.839 E.53319
G1 X108.233 Y72.516 E.01323
G1 X126.864 Y91.147 E.51447
G1 X126.186 Y91.147 E.01323
G1 X108.233 Y73.194 E.49576
G1 X108.233 Y73.872 E.01323
G1 X125.509 Y91.147 E.47704
G1 X124.831 Y91.147 E.01323
G1 X108.233 Y74.55 E.45833
G1 X108.233 Y75.227 E.01323
G1 X124.153 Y91.147 E.43961
G1 X123.475 Y91.147 E.01323
M73 P21 R59
G1 X108.233 Y75.905 E.4209
G1 X108.233 Y76.583 E.01323
G1 X122.798 Y91.147 E.40218
G1 X122.12 Y91.147 E.01323
G1 X108.233 Y77.261 E.38347
G1 X108.233 Y77.938 E.01323
G1 X121.442 Y91.147 E.36475
G1 X120.764 Y91.147 E.01323
G1 X108.233 Y78.616 E.34604
G1 X108.233 Y79.294 E.01323
G1 X120.087 Y91.147 E.32732
G1 X119.409 Y91.147 E.01323
G1 X108.233 Y79.972 E.30861
G1 X108.233 Y80.649 E.01323
G1 X118.731 Y91.147 E.28989
G1 X118.053 Y91.147 E.01323
G1 X108.233 Y81.327 E.27118
G1 X108.233 Y82.005 E.01323
M73 P22 R59
G1 X117.376 Y91.147 E.25246
G1 X116.698 Y91.147 E.01323
G1 X108.233 Y82.683 E.23374
G1 X108.233 Y83.36 E.01323
G1 X116.02 Y91.147 E.21503
G1 X115.342 Y91.147 E.01323
G1 X108.233 Y84.038 E.19631
G1 X108.233 Y84.716 E.01323
G1 X114.665 Y91.147 E.1776
G1 X113.987 Y91.147 E.01323
G1 X108.233 Y85.394 E.15888
G1 X108.233 Y86.071 E.01323
G1 X113.309 Y91.147 E.14017
G1 X112.631 Y91.147 E.01323
G1 X108.233 Y86.749 E.12145
G1 X108.233 Y87.427 E.01323
G1 X111.954 Y91.147 E.10274
G1 X111.276 Y91.147 E.01323
M73 P22 R58
G1 X108.233 Y88.105 E.08402
G1 X108.233 Y88.782 E.01323
G1 X110.598 Y91.147 E.06531
G1 X109.92 Y91.147 E.01323
G1 X108.018 Y89.245 E.05254
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F900
G1 X109.432 Y90.659 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 2/58
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
M106 P2 S178
; open powerlost recovery
M1003 S1
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.5 I1.215 J-.07 P1  F30000
G1 X107.471 Y56.87 Z.5
M73 P23 R58
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 2 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer2 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
M73 P23 R57
G1 E-.04 F1800
M204 S10000
G1 X107.641 Y57.849 Z.6 F30000
M73 P24 R57
G1 Z.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X108.27 Y57.219 E.01447
G1 X108.835 Y57.219 E.00918
G1 X107.821 Y58.234 E.02333
G1 X107.821 Y58.798 E.00918
G1 X109.399 Y57.219 E.03631
G1 X109.964 Y57.219 E.00918
G1 X107.821 Y59.363 E.04929
G1 X107.821 Y59.927 E.00918
G1 X110.528 Y57.219 E.06228
G1 X111.093 Y57.219 E.00918
G1 X107.821 Y60.492 E.07526
G1 X107.821 Y61.056 E.00918
G1 X111.657 Y57.219 E.08824
G1 X112.222 Y57.219 E.00918
G1 X107.821 Y61.621 E.10123
G1 X107.821 Y62.185 E.00918
G1 X112.786 Y57.219 E.11421
G1 X113.351 Y57.219 E.00918
G1 X107.821 Y62.75 E.12719
G1 X107.821 Y63.314 E.00918
G1 X113.915 Y57.219 E.14017
G1 X114.48 Y57.219 E.00918
G1 X107.821 Y63.879 E.15316
G1 X107.821 Y64.443 E.00918
G1 X115.044 Y57.219 E.16614
G1 X115.609 Y57.219 E.00918
G1 X107.821 Y65.008 E.17912
G1 X107.821 Y65.572 E.00918
G1 X116.173 Y57.219 E.1921
G1 X116.738 Y57.219 E.00918
G1 X107.821 Y66.137 E.20509
G1 X107.821 Y66.701 E.00918
G1 X117.302 Y57.219 E.21807
G1 X117.867 Y57.219 E.00918
G1 X107.821 Y67.265 E.23105
G1 X107.821 Y67.83 E.00918
G1 X118.431 Y57.219 E.24403
G1 X118.996 Y57.219 E.00918
G1 X107.821 Y68.394 E.25702
G1 X107.821 Y68.959 E.00918
G1 X119.56 Y57.219 E.27
G1 X120.125 Y57.219 E.00918
G1 X107.821 Y69.523 E.28298
G1 X107.821 Y70.088 E.00918
G1 X120.689 Y57.219 E.29596
G1 X121.254 Y57.219 E.00918
G1 X107.821 Y70.652 E.30895
G1 X107.821 Y71.217 E.00918
G1 X121.818 Y57.219 E.32193
G1 X122.383 Y57.219 E.00918
G1 X107.821 Y71.781 E.33491
G1 X107.821 Y72.346 E.00918
G1 X122.947 Y57.219 E.3479
G1 X123.512 Y57.219 E.00918
G1 X107.821 Y72.91 E.36088
G1 X107.821 Y73.475 E.00918
G1 X124.076 Y57.219 E.37386
G1 X124.641 Y57.219 E.00918
G1 X107.821 Y74.039 E.38684
G1 X107.821 Y74.604 E.00918
G1 X125.205 Y57.219 E.39983
G1 X125.769 Y57.219 E.00918
G1 X107.821 Y75.168 E.41281
G1 X107.821 Y75.733 E.00918
G1 X126.334 Y57.219 E.42579
G1 X126.898 Y57.219 E.00918
G1 X107.821 Y76.297 E.43877
G1 X107.821 Y76.862 E.00918
G1 X127.463 Y57.219 E.45176
G1 X128.027 Y57.219 E.00918
G1 X107.821 Y77.426 E.46474
G1 X107.821 Y77.991 E.00918
G1 X128.592 Y57.219 E.47772
G1 X129.156 Y57.219 E.00918
G1 X107.821 Y78.555 E.4907
G1 X107.821 Y79.12 E.00918
G1 X129.721 Y57.219 E.50369
G1 X130.285 Y57.219 E.00918
G1 X107.821 Y79.684 E.51667
G1 X107.821 Y80.249 E.00918
G1 X130.85 Y57.219 E.52965
G1 X131.414 Y57.219 E.00918
G1 X107.821 Y80.813 E.54263
G1 X107.821 Y81.378 E.00918
G1 X131.979 Y57.219 E.55562
G1 X132.543 Y57.219 E.00918
G1 X107.821 Y81.942 E.5686
G1 X107.821 Y82.507 E.00918
G1 X133.108 Y57.219 E.58158
M73 P25 R57
G1 X133.672 Y57.219 E.00918
G1 X107.821 Y83.071 E.59457
G1 X107.821 Y83.636 E.00918
G1 X134.237 Y57.219 E.60755
G1 X134.801 Y57.219 E.00918
G1 X107.821 Y84.2 E.62053
G1 X107.821 Y84.764 E.00918
G1 X135.366 Y57.219 E.63351
G1 X135.93 Y57.219 E.00918
G1 X107.821 Y85.329 E.6465
G1 X107.821 Y85.893 E.00918
G1 X136.495 Y57.219 E.65948
G1 X137.059 Y57.219 E.00918
G1 X107.821 Y86.458 E.67246
G1 X107.821 Y87.022 E.00918
G1 X137.624 Y57.219 E.68544
G1 X138.188 Y57.219 E.00918
G1 X107.821 Y87.587 E.69843
G1 X107.821 Y88.151 E.00918
G1 X138.753 Y57.219 E.71141
G1 X139.317 Y57.219 E.00918
G1 X107.821 Y88.716 E.72439
G1 X107.821 Y89.28 E.00918
G1 X139.882 Y57.219 E.73737
G1 X140.446 Y57.219 E.00918
G1 X107.927 Y89.738 E.7479
G1 X108.209 Y90.02 E.00649
G1 X141.011 Y57.219 E.7544
G1 X141.575 Y57.219 E.00918
G1 X108.492 Y90.303 E.76089
G1 X108.774 Y90.585 E.00649
G1 X142.14 Y57.219 E.76738
G1 X142.704 Y57.219 E.00918
G1 X109.056 Y90.867 E.77387
G1 X109.338 Y91.149 E.00649
G1 X143.268 Y57.219 E.78036
G1 X143.833 Y57.219 E.00918
G1 X109.621 Y91.432 E.78685
G1 X109.749 Y91.56 E.00295
G1 X110.057 Y91.56 E.00501
G1 X144.397 Y57.219 E.7898
G1 X144.962 Y57.219 E.00918
G1 X110.622 Y91.56 E.7898
G1 X111.186 Y91.56 E.00918
G1 X145.526 Y57.219 E.7898
G1 X146.091 Y57.219 E.00918
G1 X111.751 Y91.56 E.7898
G1 X112.315 Y91.56 E.00918
G1 X146.655 Y57.219 E.7898
G1 X147.22 Y57.219 E.00918
G1 X112.879 Y91.56 E.7898
G1 X113.444 Y91.56 E.00918
G1 X147.784 Y57.219 E.7898
G1 X148.349 Y57.219 E.00918
G1 X114.008 Y91.56 E.7898
G1 X114.573 Y91.56 E.00918
G1 X148.913 Y57.219 E.7898
G1 X149.478 Y57.219 E.00918
G1 X115.137 Y91.56 E.7898
G1 X115.702 Y91.56 E.00918
G1 X150.042 Y57.219 E.7898
G1 X150.607 Y57.219 E.00918
G1 X116.266 Y91.56 E.7898
G1 X116.831 Y91.56 E.00918
G1 X151.171 Y57.219 E.7898
G1 X151.736 Y57.219 E.00918
G1 X117.395 Y91.56 E.7898
G1 X117.96 Y91.56 E.00918
G1 X152.3 Y57.219 E.7898
G1 X152.865 Y57.219 E.00918
G1 X118.524 Y91.56 E.7898
G1 X119.089 Y91.56 E.00918
G1 X153.429 Y57.219 E.7898
G1 X153.994 Y57.219 E.00918
G1 X119.653 Y91.56 E.7898
G1 X120.218 Y91.56 E.00918
G1 X154.558 Y57.219 E.7898
G1 X155.123 Y57.219 E.00918
G1 X120.782 Y91.56 E.7898
G1 X121.347 Y91.56 E.00918
G1 X155.687 Y57.219 E.7898
G1 X156.252 Y57.219 E.00918
G1 X121.911 Y91.56 E.7898
G1 X122.476 Y91.56 E.00918
G1 X156.816 Y57.219 E.7898
G1 X157.381 Y57.219 E.00918
G1 X123.04 Y91.56 E.7898
G1 X123.605 Y91.56 E.00918
G1 X157.945 Y57.219 E.7898
G1 X158.51 Y57.219 E.00918
G1 X124.169 Y91.56 E.7898
G1 X124.734 Y91.56 E.00918
G1 X159.074 Y57.219 E.7898
G1 X159.638 Y57.219 E.00918
G1 X125.298 Y91.56 E.7898
G1 X125.863 Y91.56 E.00918
G1 X160.203 Y57.219 E.7898
M73 P25 R56
G1 X160.767 Y57.219 E.00918
G1 X126.427 Y91.56 E.7898
G1 X126.992 Y91.56 E.00918
G1 X161.332 Y57.219 E.7898
G1 X161.896 Y57.219 E.00918
G1 X127.556 Y91.56 E.7898
G1 X128.121 Y91.56 E.00918
G1 X162.461 Y57.219 E.7898
G1 X163.025 Y57.219 E.00918
G1 X128.685 Y91.56 E.7898
G1 X129.25 Y91.56 E.00918
G1 X163.59 Y57.219 E.7898
G1 X164.154 Y57.219 E.00918
G1 X129.814 Y91.56 E.7898
G1 X130.378 Y91.56 E.00918
G1 X164.719 Y57.219 E.7898
G1 X165.283 Y57.219 E.00918
G1 X130.943 Y91.56 E.7898
G1 X131.507 Y91.56 E.00918
G1 X165.848 Y57.219 E.7898
G1 X166.412 Y57.219 E.00918
G1 X132.072 Y91.56 E.7898
G1 X132.636 Y91.56 E.00918
G1 X166.977 Y57.219 E.7898
G1 X167.541 Y57.219 E.00918
G1 X133.201 Y91.56 E.7898
G1 X133.765 Y91.56 E.00918
G1 X168.106 Y57.219 E.7898
G1 X168.67 Y57.219 E.00918
G1 X134.33 Y91.56 E.7898
G1 X134.894 Y91.56 E.00918
G1 X169.235 Y57.219 E.7898
G1 X169.799 Y57.219 E.00918
G1 X135.459 Y91.56 E.7898
G1 X136.023 Y91.56 E.00918
G1 X170.364 Y57.219 E.7898
G1 X170.928 Y57.219 E.00918
G1 X136.588 Y91.56 E.7898
G1 X137.152 Y91.56 E.00918
G1 X171.493 Y57.219 E.7898
G1 X172.057 Y57.219 E.00918
G1 X137.717 Y91.56 E.7898
G1 X138.281 Y91.56 E.00918
G1 X172.622 Y57.219 E.7898
G1 X173.186 Y57.219 E.00918
G1 X138.846 Y91.56 E.7898
G1 X139.41 Y91.56 E.00918
G1 X173.751 Y57.219 E.7898
G1 X174.315 Y57.219 E.00918
G1 X139.975 Y91.56 E.7898
G1 X140.539 Y91.56 E.00918
G1 X174.88 Y57.219 E.7898
G1 X175.444 Y57.219 E.00918
G1 X141.104 Y91.56 E.7898
G1 X141.668 Y91.56 E.00918
G1 X176.009 Y57.219 E.7898
G1 X176.573 Y57.219 E.00918
G1 X142.233 Y91.56 E.7898
G1 X142.797 Y91.56 E.00918
G1 X177.137 Y57.219 E.7898
G1 X177.702 Y57.219 E.00918
G1 X143.362 Y91.56 E.7898
G1 X143.926 Y91.56 E.00918
G1 X178.266 Y57.219 E.7898
G1 X178.831 Y57.219 E.00918
G1 X144.491 Y91.56 E.7898
G1 X145.055 Y91.56 E.00918
G1 X179.395 Y57.219 E.7898
G1 X179.96 Y57.219 E.00918
G1 X145.62 Y91.56 E.7898
G1 X146.184 Y91.56 E.00918
G1 X180.524 Y57.219 E.7898
G1 X181.089 Y57.219 E.00918
G1 X146.748 Y91.56 E.7898
G1 X147.313 Y91.56 E.00918
G1 X181.653 Y57.219 E.7898
G1 X182.218 Y57.219 E.00918
G1 X147.877 Y91.56 E.7898
G1 X148.442 Y91.56 E.00918
G1 X182.782 Y57.219 E.7898
G1 X183.347 Y57.219 E.00918
G1 X149.006 Y91.56 E.7898
G1 X149.571 Y91.56 E.00918
G1 X183.911 Y57.219 E.7898
G1 X184.476 Y57.219 E.00918
G1 X150.135 Y91.56 E.7898
G1 X150.7 Y91.56 E.00918
G1 X185.04 Y57.219 E.7898
G1 X185.605 Y57.219 E.00918
G1 X151.264 Y91.56 E.7898
G1 X151.829 Y91.56 E.00918
G1 X186.169 Y57.219 E.7898
G1 X186.734 Y57.219 E.00918
G1 X152.393 Y91.56 E.7898
G1 X152.958 Y91.56 E.00918
G1 X187.298 Y57.219 E.7898
G1 X187.863 Y57.219 E.00918
G1 X153.522 Y91.56 E.7898
G1 X154.087 Y91.56 E.00918
G1 X188.427 Y57.219 E.7898
G1 X188.992 Y57.219 E.00918
G1 X154.651 Y91.56 E.7898
G1 X155.216 Y91.56 E.00918
G1 X189.556 Y57.219 E.7898
G1 X190.121 Y57.219 E.00918
G1 X155.78 Y91.56 E.7898
G1 X156.345 Y91.56 E.00918
G1 X190.685 Y57.219 E.7898
G1 X191.25 Y57.219 E.00918
G1 X156.909 Y91.56 E.7898
G1 X157.474 Y91.56 E.00918
G1 X191.814 Y57.219 E.7898
G1 X192.379 Y57.219 E.00918
M73 P26 R56
G1 X158.038 Y91.56 E.7898
G1 X158.603 Y91.56 E.00918
G1 X192.943 Y57.219 E.7898
G1 X193.507 Y57.219 E.00918
G1 X159.167 Y91.56 E.7898
G1 X159.732 Y91.56 E.00918
G1 X194.072 Y57.219 E.7898
G1 X194.636 Y57.219 E.00918
G1 X160.296 Y91.56 E.7898
G1 X160.861 Y91.56 E.00918
G1 X195.201 Y57.219 E.7898
G1 X195.765 Y57.219 E.00918
G1 X161.425 Y91.56 E.7898
G1 X161.99 Y91.56 E.00918
G1 X196.33 Y57.219 E.7898
G1 X196.894 Y57.219 E.00918
G1 X162.554 Y91.56 E.7898
G1 X163.119 Y91.56 E.00918
G1 X197.459 Y57.219 E.7898
G1 X198.023 Y57.219 E.00918
G1 X163.683 Y91.56 E.7898
G1 X164.247 Y91.56 E.00918
G1 X198.588 Y57.219 E.7898
G1 X199.152 Y57.219 E.00918
G1 X164.812 Y91.56 E.7898
G1 X165.376 Y91.56 E.00918
G1 X199.717 Y57.219 E.7898
G1 X200.281 Y57.219 E.00918
G1 X165.941 Y91.56 E.7898
G1 X166.505 Y91.56 E.00918
G1 X200.846 Y57.219 E.7898
G1 X201.41 Y57.219 E.00918
G1 X167.07 Y91.56 E.7898
G1 X167.634 Y91.56 E.00918
G1 X201.975 Y57.219 E.7898
G1 X202.539 Y57.219 E.00918
G1 X168.199 Y91.56 E.7898
G1 X168.763 Y91.56 E.00918
G1 X203.104 Y57.219 E.7898
G1 X203.668 Y57.219 E.00918
G1 X169.328 Y91.56 E.7898
G1 X169.892 Y91.56 E.00918
G1 X204.233 Y57.219 E.7898
G1 X204.797 Y57.219 E.00918
G1 X170.457 Y91.56 E.7898
G1 X171.021 Y91.56 E.00918
G1 X205.362 Y57.219 E.7898
G1 X205.926 Y57.219 E.00918
G1 X171.586 Y91.56 E.7898
G1 X172.15 Y91.56 E.00918
G1 X206.491 Y57.219 E.7898
G1 X207.055 Y57.219 E.00918
G1 X172.715 Y91.56 E.7898
G1 X173.279 Y91.56 E.00918
G1 X207.62 Y57.219 E.7898
G1 X208.161 Y57.219 E.0088
G1 X208.161 Y57.242 E.00038
G1 X173.844 Y91.56 E.78927
G1 X174.408 Y91.56 E.00918
G1 X208.161 Y57.807 E.77628
G1 X208.161 Y58.371 E.00918
G1 X174.973 Y91.56 E.7633
G1 X175.537 Y91.56 E.00918
G1 X208.161 Y58.936 E.75032
G1 X208.161 Y59.5 E.00918
G1 X176.102 Y91.56 E.73734
G1 X176.666 Y91.56 E.00918
G1 X208.161 Y60.065 E.72435
G1 X208.161 Y60.629 E.00918
G1 X177.231 Y91.56 E.71137
G1 X177.795 Y91.56 E.00918
G1 X208.161 Y61.194 E.69839
G1 X208.161 Y61.758 E.00918
G1 X178.36 Y91.56 E.68541
G1 X178.924 Y91.56 E.00918
G1 X208.161 Y62.323 E.67242
G1 X208.161 Y62.887 E.00918
G1 X179.489 Y91.56 E.65944
G1 X180.053 Y91.56 E.00918
G1 X208.161 Y63.452 E.64646
G1 X208.161 Y64.016 E.00918
G1 X180.617 Y91.56 E.63348
G1 X181.182 Y91.56 E.00918
G1 X208.161 Y64.581 E.62049
G1 X208.161 Y65.145 E.00918
G1 X181.746 Y91.56 E.60751
G1 X182.311 Y91.56 E.00918
G1 X208.161 Y65.71 E.59453
G1 X208.161 Y66.274 E.00918
G1 X182.875 Y91.56 E.58155
G1 X183.44 Y91.56 E.00918
G1 X208.161 Y66.839 E.56856
M73 P26 R55
G1 X208.161 Y67.403 E.00918
G1 X184.004 Y91.56 E.55558
G1 X184.569 Y91.56 E.00918
G1 X208.161 Y67.968 E.5426
G1 X208.161 Y68.532 E.00918
G1 X185.133 Y91.56 E.52961
G1 X185.698 Y91.56 E.00918
G1 X208.161 Y69.097 E.51663
G1 X208.161 Y69.661 E.00918
G1 X186.262 Y91.56 E.50365
G1 X186.827 Y91.56 E.00918
G1 X208.161 Y70.226 E.49067
G1 X208.161 Y70.79 E.00918
G1 X187.391 Y91.56 E.47768
G1 X187.956 Y91.56 E.00918
G1 X208.161 Y71.355 E.4647
G1 X208.161 Y71.919 E.00918
G1 X188.52 Y91.56 E.45172
G1 X189.085 Y91.56 E.00918
G1 X208.161 Y72.484 E.43874
G1 X208.161 Y73.048 E.00918
G1 X189.649 Y91.56 E.42575
G1 X190.214 Y91.56 E.00918
G1 X208.161 Y73.612 E.41277
G1 X208.161 Y74.177 E.00918
G1 X190.778 Y91.56 E.39979
G1 X191.343 Y91.56 E.00918
G1 X208.161 Y74.741 E.38681
G1 X208.161 Y75.306 E.00918
G1 X191.907 Y91.56 E.37382
G1 X192.472 Y91.56 E.00918
G1 X208.161 Y75.87 E.36084
G1 X208.161 Y76.435 E.00918
G1 X193.036 Y91.56 E.34786
G1 X193.601 Y91.56 E.00918
G1 X208.161 Y76.999 E.33488
G1 X208.161 Y77.564 E.00918
G1 X194.165 Y91.56 E.32189
G1 X194.73 Y91.56 E.00918
G1 X208.161 Y78.128 E.30891
G1 X208.161 Y78.693 E.00918
G1 X195.294 Y91.56 E.29593
G1 X195.859 Y91.56 E.00918
G1 X208.161 Y79.257 E.28294
G1 X208.161 Y79.822 E.00918
G1 X196.423 Y91.56 E.26996
G1 X196.988 Y91.56 E.00918
G1 X208.161 Y80.386 E.25698
G1 X208.161 Y80.951 E.00918
G1 X197.552 Y91.56 E.244
G1 X198.116 Y91.56 E.00918
G1 X208.161 Y81.515 E.23101
G1 X208.161 Y82.08 E.00918
G1 X198.681 Y91.56 E.21803
G1 X199.245 Y91.56 E.00918
G1 X208.161 Y82.644 E.20505
G1 X208.161 Y83.209 E.00918
G1 X199.81 Y91.56 E.19207
G1 X200.374 Y91.56 E.00918
G1 X208.161 Y83.773 E.17908
M73 P27 R55
G1 X208.161 Y84.338 E.00918
G1 X200.939 Y91.56 E.1661
G1 X201.503 Y91.56 E.00918
G1 X208.161 Y84.902 E.15312
G1 X208.161 Y85.467 E.00918
G1 X202.068 Y91.56 E.14014
G1 X202.632 Y91.56 E.00918
G1 X208.161 Y86.031 E.12715
G1 X208.161 Y86.596 E.00918
G1 X203.197 Y91.56 E.11417
G1 X203.761 Y91.56 E.00918
G1 X208.161 Y87.16 E.10119
G1 X208.161 Y87.725 E.00918
G1 X204.326 Y91.56 E.08821
G1 X204.89 Y91.56 E.00918
G1 X208.161 Y88.289 E.07522
G1 X208.161 Y88.854 E.00918
G1 X205.455 Y91.56 E.06224
G1 X206.019 Y91.56 E.00918
G1 X208.161 Y89.418 E.04926
G1 X208.161 Y89.983 E.00918
G1 X206.584 Y91.56 E.03627
G1 X207.148 Y91.56 E.00918
G1 X208.161 Y90.547 E.02329
G1 X208.161 Y91.111 E.00918
G1 X207.533 Y91.739 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 0.3
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X208.161 Y91.111 E-.33727
G1 X208.161 Y90.547 E-.21451
G1 X207.774 Y90.934 E-.20822
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 3/58
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I.391 J-1.152 P1  F30000
G1 X107.471 Y56.87 Z.6
G1 Z.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 3 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer3 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.074 Y63.29 Z.7 F30000
G1 X107.641 Y89.45 Z.7
G1 Z.3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X109.751 Y91.56 E.0486
G1 X110.316 Y91.56 E.00921
G1 X107.821 Y89.064 E.05749
G1 X107.821 Y88.499 E.00921
G1 X110.882 Y91.56 E.07051
G1 X111.447 Y91.56 E.00921
G1 X107.821 Y87.933 E.08354
G1 X107.821 Y87.368 E.00921
G1 X112.012 Y91.56 E.09656
G1 X112.578 Y91.56 E.00921
G1 X107.821 Y86.803 E.10959
G1 X107.821 Y86.237 E.00921
G1 X113.143 Y91.56 E.12261
G1 X113.709 Y91.56 E.00921
G1 X107.821 Y85.672 E.13563
G1 X107.821 Y85.106 E.00921
G1 X114.274 Y91.56 E.14866
G1 X114.839 Y91.56 E.00921
G1 X107.821 Y84.541 E.16168
G1 X107.821 Y83.976 E.00921
G1 X115.405 Y91.56 E.17471
G1 X115.97 Y91.56 E.00921
G1 X107.821 Y83.41 E.18773
G1 X107.821 Y82.845 E.00921
G1 X116.535 Y91.56 E.20076
G1 X117.101 Y91.56 E.00921
G1 X107.821 Y82.28 E.21378
G1 X107.821 Y81.714 E.00921
G1 X117.666 Y91.56 E.2268
G1 X118.232 Y91.56 E.00921
G1 X107.821 Y81.149 E.23983
G1 X107.821 Y80.583 E.00921
G1 X118.797 Y91.56 E.25285
G1 X119.362 Y91.56 E.00921
G1 X107.821 Y80.018 E.26588
G1 X107.821 Y79.453 E.00921
G1 X119.928 Y91.56 E.2789
G1 X120.493 Y91.56 E.00921
G1 X107.821 Y78.887 E.29193
G1 X107.821 Y78.322 E.00921
G1 X121.059 Y91.56 E.30495
G1 X121.624 Y91.56 E.00921
G1 X107.821 Y77.756 E.31797
G1 X107.821 Y77.191 E.00921
G1 X122.189 Y91.56 E.331
G1 X122.755 Y91.56 E.00921
G1 X107.821 Y76.626 E.34402
G1 X107.821 Y76.06 E.00921
G1 X123.32 Y91.56 E.35705
G1 X123.886 Y91.56 E.00921
G1 X107.821 Y75.495 E.37007
G1 X107.821 Y74.929 E.00921
G1 X124.451 Y91.56 E.3831
G1 X125.016 Y91.56 E.00921
G1 X107.821 Y74.364 E.39612
G1 X107.821 Y73.799 E.00921
G1 X125.582 Y91.56 E.40914
G1 X126.147 Y91.56 E.00921
G1 X107.821 Y73.233 E.42217
G1 X107.821 Y72.668 E.00921
G1 X126.712 Y91.56 E.43519
G1 X127.278 Y91.56 E.00921
G1 X107.821 Y72.103 E.44822
G1 X107.821 Y71.537 E.00921
G1 X127.843 Y91.56 E.46124
G1 X128.409 Y91.56 E.00921
G1 X107.821 Y70.972 E.47427
G1 X107.821 Y70.406 E.00921
G1 X128.974 Y91.56 E.48729
G1 X129.539 Y91.56 E.00921
G1 X107.821 Y69.841 E.50031
G1 X107.821 Y69.276 E.00921
G1 X130.105 Y91.56 E.51334
G1 X130.67 Y91.56 E.00921
G1 X107.821 Y68.71 E.52636
G1 X107.821 Y68.145 E.00921
G1 X131.236 Y91.56 E.53939
G1 X131.801 Y91.56 E.00921
G1 X107.821 Y67.579 E.55241
G1 X107.821 Y67.014 E.00921
G1 X132.366 Y91.56 E.56544
G1 X132.932 Y91.56 E.00921
G1 X107.821 Y66.449 E.57846
G1 X107.821 Y65.883 E.00921
G1 X133.497 Y91.56 E.59148
G1 X134.063 Y91.56 E.00921
G1 X107.821 Y65.318 E.60451
G1 X107.821 Y64.752 E.00921
G1 X134.628 Y91.56 E.61753
G1 X135.193 Y91.56 E.00921
G1 X107.821 Y64.187 E.63056
G1 X107.821 Y63.622 E.00921
G1 X135.759 Y91.56 E.64358
G1 X136.324 Y91.56 E.00921
G1 X107.821 Y63.056 E.65661
G1 X107.821 Y62.491 E.00921
G1 X136.889 Y91.56 E.66963
G1 X137.455 Y91.56 E.00921
G1 X107.821 Y61.926 E.68265
G1 X107.821 Y61.36 E.00921
G1 X138.02 Y91.56 E.69568
G1 X138.586 Y91.56 E.00921
G1 X107.821 Y60.795 E.7087
G1 X107.821 Y60.229 E.00921
G1 X139.151 Y91.56 E.72173
G1 X139.716 Y91.56 E.00921
G1 X107.821 Y59.664 E.73475
G1 X107.821 Y59.099 E.00921
G1 X140.282 Y91.56 E.74778
G1 X140.847 Y91.56 E.00921
G1 X107.821 Y58.533 E.7608
G1 X107.821 Y57.968 E.00921
G1 X141.413 Y91.56 E.77382
G1 X141.978 Y91.56 E.00921
G1 X107.821 Y57.402 E.78685
G1 X107.821 Y57.219 E.00298
G1 X108.203 Y57.219 E.00623
G1 X142.543 Y91.56 E.79106
G1 X143.109 Y91.56 E.00921
G1 X108.768 Y57.219 E.79106
G1 X109.334 Y57.219 E.00921
G1 X143.674 Y91.56 E.79106
G1 X144.239 Y91.56 E.00921
G1 X109.899 Y57.219 E.79106
G1 X110.465 Y57.219 E.00921
G1 X144.805 Y91.56 E.79106
G1 X145.37 Y91.56 E.00921
G1 X111.03 Y57.219 E.79106
G1 X111.595 Y57.219 E.00921
G1 X145.936 Y91.56 E.79106
G1 X146.501 Y91.56 E.00921
G1 X112.161 Y57.219 E.79106
G1 X112.726 Y57.219 E.00921
G1 X147.066 Y91.56 E.79106
G1 X147.632 Y91.56 E.00921
G1 X113.291 Y57.219 E.79106
G1 X113.857 Y57.219 E.00921
G1 X148.197 Y91.56 E.79106
G1 X148.763 Y91.56 E.00921
G1 X114.422 Y57.219 E.79106
G1 X114.988 Y57.219 E.00921
G1 X149.328 Y91.56 E.79106
G1 X149.893 Y91.56 E.00921
G1 X115.553 Y57.219 E.79106
M73 P27 R54
G1 X116.118 Y57.219 E.00921
G1 X150.459 Y91.56 E.79106
G1 X151.024 Y91.56 E.00921
G1 X116.684 Y57.219 E.79106
G1 X117.249 Y57.219 E.00921
G1 X151.59 Y91.56 E.79106
G1 X152.155 Y91.56 E.00921
G1 X117.815 Y57.219 E.79106
G1 X118.38 Y57.219 E.00921
G1 X152.72 Y91.56 E.79106
G1 X153.286 Y91.56 E.00921
G1 X118.945 Y57.219 E.79106
G1 X119.511 Y57.219 E.00921
G1 X153.851 Y91.56 E.79106
G1 X154.416 Y91.56 E.00921
G1 X120.076 Y57.219 E.79106
G1 X120.642 Y57.219 E.00921
G1 X154.982 Y91.56 E.79106
G1 X155.547 Y91.56 E.00921
G1 X121.207 Y57.219 E.79106
M73 P28 R54
G1 X121.772 Y57.219 E.00921
G1 X156.113 Y91.56 E.79106
G1 X156.678 Y91.56 E.00921
G1 X122.338 Y57.219 E.79106
G1 X122.903 Y57.219 E.00921
G1 X157.243 Y91.56 E.79106
G1 X157.809 Y91.56 E.00921
G1 X123.468 Y57.219 E.79106
G1 X124.034 Y57.219 E.00921
G1 X158.374 Y91.56 E.79106
G1 X158.94 Y91.56 E.00921
G1 X124.599 Y57.219 E.79106
G1 X125.165 Y57.219 E.00921
G1 X159.505 Y91.56 E.79106
G1 X160.07 Y91.56 E.00921
G1 X125.73 Y57.219 E.79106
G1 X126.295 Y57.219 E.00921
G1 X160.636 Y91.56 E.79106
G1 X161.201 Y91.56 E.00921
G1 X126.861 Y57.219 E.79106
G1 X127.426 Y57.219 E.00921
G1 X161.767 Y91.56 E.79106
G1 X162.332 Y91.56 E.00921
G1 X127.992 Y57.219 E.79106
G1 X128.557 Y57.219 E.00921
G1 X162.897 Y91.56 E.79106
G1 X163.463 Y91.56 E.00921
G1 X129.122 Y57.219 E.79106
G1 X129.688 Y57.219 E.00921
G1 X164.028 Y91.56 E.79106
G1 X164.593 Y91.56 E.00921
G1 X130.253 Y57.219 E.79106
G1 X130.819 Y57.219 E.00921
G1 X165.159 Y91.56 E.79106
G1 X165.724 Y91.56 E.00921
G1 X131.384 Y57.219 E.79106
G1 X131.949 Y57.219 E.00921
G1 X166.29 Y91.56 E.79106
G1 X166.855 Y91.56 E.00921
G1 X132.515 Y57.219 E.79106
G1 X133.08 Y57.219 E.00921
G1 X167.42 Y91.56 E.79106
G1 X167.986 Y91.56 E.00921
G1 X133.645 Y57.219 E.79106
G1 X134.211 Y57.219 E.00921
G1 X168.551 Y91.56 E.79106
G1 X169.117 Y91.56 E.00921
G1 X134.776 Y57.219 E.79106
G1 X135.342 Y57.219 E.00921
G1 X169.682 Y91.56 E.79106
G1 X170.247 Y91.56 E.00921
G1 X135.907 Y57.219 E.79106
G1 X136.472 Y57.219 E.00921
G1 X170.813 Y91.56 E.79106
G1 X171.378 Y91.56 E.00921
G1 X137.038 Y57.219 E.79106
G1 X137.603 Y57.219 E.00921
G1 X171.944 Y91.56 E.79106
G1 X172.509 Y91.56 E.00921
G1 X138.169 Y57.219 E.79106
G1 X138.734 Y57.219 E.00921
G1 X173.074 Y91.56 E.79106
G1 X173.64 Y91.56 E.00921
G1 X139.299 Y57.219 E.79106
G1 X139.865 Y57.219 E.00921
G1 X174.205 Y91.56 E.79106
G1 X174.77 Y91.56 E.00921
G1 X140.43 Y57.219 E.79106
G1 X140.996 Y57.219 E.00921
G1 X175.336 Y91.56 E.79106
G1 X175.901 Y91.56 E.00921
G1 X141.561 Y57.219 E.79106
G1 X142.126 Y57.219 E.00921
G1 X176.467 Y91.56 E.79106
G1 X177.032 Y91.56 E.00921
G1 X142.692 Y57.219 E.79106
G1 X143.257 Y57.219 E.00921
G1 X177.597 Y91.56 E.79106
G1 X178.163 Y91.56 E.00921
G1 X143.822 Y57.219 E.79106
G1 X144.388 Y57.219 E.00921
G1 X178.728 Y91.56 E.79106
G1 X179.294 Y91.56 E.00921
G1 X144.953 Y57.219 E.79106
G1 X145.519 Y57.219 E.00921
G1 X179.859 Y91.56 E.79106
G1 X180.424 Y91.56 E.00921
G1 X146.084 Y57.219 E.79106
G1 X146.649 Y57.219 E.00921
G1 X180.99 Y91.56 E.79106
G1 X181.555 Y91.56 E.00921
G1 X147.215 Y57.219 E.79106
G1 X147.78 Y57.219 E.00921
G1 X182.121 Y91.56 E.79106
G1 X182.686 Y91.56 E.00921
G1 X148.346 Y57.219 E.79106
G1 X148.911 Y57.219 E.00921
G1 X183.251 Y91.56 E.79106
G1 X183.817 Y91.56 E.00921
G1 X149.476 Y57.219 E.79106
G1 X150.042 Y57.219 E.00921
G1 X184.382 Y91.56 E.79106
G1 X184.947 Y91.56 E.00921
G1 X150.607 Y57.219 E.79106
G1 X151.172 Y57.219 E.00921
G1 X185.513 Y91.56 E.79106
G1 X186.078 Y91.56 E.00921
G1 X151.738 Y57.219 E.79106
G1 X152.303 Y57.219 E.00921
G1 X186.644 Y91.56 E.79106
G1 X187.209 Y91.56 E.00921
G1 X152.869 Y57.219 E.79106
G1 X153.434 Y57.219 E.00921
G1 X187.774 Y91.56 E.79106
G1 X188.34 Y91.56 E.00921
G1 X153.999 Y57.219 E.79106
G1 X154.565 Y57.219 E.00921
G1 X188.905 Y91.56 E.79106
G1 X189.471 Y91.56 E.00921
G1 X155.13 Y57.219 E.79106
G1 X155.696 Y57.219 E.00921
G1 X190.036 Y91.56 E.79106
G1 X190.601 Y91.56 E.00921
G1 X156.261 Y57.219 E.79106
G1 X156.826 Y57.219 E.00921
G1 X191.167 Y91.56 E.79106
G1 X191.732 Y91.56 E.00921
G1 X157.392 Y57.219 E.79106
G1 X157.957 Y57.219 E.00921
G1 X192.298 Y91.56 E.79106
G1 X192.863 Y91.56 E.00921
G1 X158.523 Y57.219 E.79106
G1 X159.088 Y57.219 E.00921
G1 X193.428 Y91.56 E.79106
G1 X193.994 Y91.56 E.00921
G1 X159.653 Y57.219 E.79106
G1 X160.219 Y57.219 E.00921
G1 X194.559 Y91.56 E.79106
G1 X195.124 Y91.56 E.00921
G1 X160.784 Y57.219 E.79106
G1 X161.349 Y57.219 E.00921
G1 X195.69 Y91.56 E.79106
G1 X196.255 Y91.56 E.00921
G1 X161.915 Y57.219 E.79106
G1 X162.48 Y57.219 E.00921
G1 X196.821 Y91.56 E.79106
G1 X197.386 Y91.56 E.00921
G1 X163.046 Y57.219 E.79106
G1 X163.611 Y57.219 E.00921
G1 X197.951 Y91.56 E.79106
G1 X198.517 Y91.56 E.00921
G1 X164.176 Y57.219 E.79106
G1 X164.742 Y57.219 E.00921
G1 X199.082 Y91.56 E.79106
G1 X199.648 Y91.56 E.00921
G1 X165.307 Y57.219 E.79106
G1 X165.873 Y57.219 E.00921
G1 X200.213 Y91.56 E.79106
G1 X200.778 Y91.56 E.00921
G1 X166.438 Y57.219 E.79106
G1 X167.003 Y57.219 E.00921
G1 X201.344 Y91.56 E.79106
G1 X201.909 Y91.56 E.00921
M73 P29 R54
G1 X167.569 Y57.219 E.79106
G1 X168.134 Y57.219 E.00921
G1 X202.475 Y91.56 E.79106
G1 X203.04 Y91.56 E.00921
G1 X168.7 Y57.219 E.79106
G1 X169.265 Y57.219 E.00921
G1 X203.605 Y91.56 E.79106
G1 X204.171 Y91.56 E.00921
G1 X169.83 Y57.219 E.79106
G1 X170.396 Y57.219 E.00921
G1 X204.736 Y91.56 E.79106
G1 X205.301 Y91.56 E.00921
G1 X170.961 Y57.219 E.79106
G1 X171.526 Y57.219 E.00921
G1 X205.867 Y91.56 E.79106
G1 X206.432 Y91.56 E.00921
G1 X172.092 Y57.219 E.79106
G1 X172.657 Y57.219 E.00921
G1 X206.998 Y91.56 E.79106
G1 X207.563 Y91.56 E.00921
G1 X173.223 Y57.219 E.79106
G1 X173.788 Y57.219 E.00921
G1 X208.128 Y91.56 E.79106
G1 X208.161 Y91.56 E.00053
G1 X208.161 Y91.027 E.00868
G1 X174.353 Y57.219 E.77879
G1 X174.919 Y57.219 E.00921
G1 X208.161 Y90.462 E.76577
G1 X208.161 Y89.896 E.00921
G1 X175.484 Y57.219 E.75274
G1 X176.05 Y57.219 E.00921
G1 X208.161 Y89.331 E.73972
G1 X208.161 Y88.765 E.00921
G1 X176.615 Y57.219 E.72669
M73 P29 R53
G1 X177.18 Y57.219 E.00921
G1 X208.161 Y88.2 E.71367
G1 X208.161 Y87.635 E.00921
G1 X177.746 Y57.219 E.70064
G1 X178.311 Y57.219 E.00921
G1 X208.161 Y87.069 E.68762
G1 X208.161 Y86.504 E.00921
G1 X178.877 Y57.219 E.6746
G1 X179.442 Y57.219 E.00921
G1 X208.161 Y85.938 E.66157
G1 X208.161 Y85.373 E.00921
G1 X180.007 Y57.219 E.64855
G1 X180.573 Y57.219 E.00921
G1 X208.161 Y84.808 E.63552
G1 X208.161 Y84.242 E.00921
G1 X181.138 Y57.219 E.6225
G1 X181.703 Y57.219 E.00921
G1 X208.161 Y83.677 E.60947
G1 X208.161 Y83.111 E.00921
G1 X182.269 Y57.219 E.59645
G1 X182.834 Y57.219 E.00921
G1 X208.161 Y82.546 E.58343
G1 X208.161 Y81.981 E.00921
G1 X183.4 Y57.219 E.5704
G1 X183.965 Y57.219 E.00921
G1 X208.161 Y81.415 E.55738
G1 X208.161 Y80.85 E.00921
G1 X184.53 Y57.219 E.54435
G1 X185.096 Y57.219 E.00921
G1 X208.161 Y80.285 E.53133
G1 X208.161 Y79.719 E.00921
G1 X185.661 Y57.219 E.5183
G1 X186.227 Y57.219 E.00921
G1 X208.161 Y79.154 E.50528
G1 X208.161 Y78.588 E.00921
G1 X186.792 Y57.219 E.49226
G1 X187.357 Y57.219 E.00921
G1 X208.161 Y78.023 E.47923
G1 X208.161 Y77.458 E.00921
G1 X187.923 Y57.219 E.46621
G1 X188.488 Y57.219 E.00921
G1 X208.161 Y76.892 E.45318
G1 X208.161 Y76.327 E.00921
G1 X189.054 Y57.219 E.44016
G1 X189.619 Y57.219 E.00921
G1 X208.161 Y75.761 E.42713
G1 X208.161 Y75.196 E.00921
G1 X190.184 Y57.219 E.41411
G1 X190.75 Y57.219 E.00921
G1 X208.161 Y74.631 E.40109
G1 X208.161 Y74.065 E.00921
G1 X191.315 Y57.219 E.38806
G1 X191.88 Y57.219 E.00921
G1 X208.161 Y73.5 E.37504
G1 X208.161 Y72.934 E.00921
G1 X192.446 Y57.219 E.36201
G1 X193.011 Y57.219 E.00921
G1 X208.161 Y72.369 E.34899
G1 X208.161 Y71.804 E.00921
G1 X193.577 Y57.219 E.33596
G1 X194.142 Y57.219 E.00921
G1 X208.161 Y71.238 E.32294
G1 X208.161 Y70.673 E.00921
G1 X194.707 Y57.219 E.30992
G1 X195.273 Y57.219 E.00921
G1 X208.161 Y70.108 E.29689
G1 X208.161 Y69.542 E.00921
G1 X195.838 Y57.219 E.28387
G1 X196.404 Y57.219 E.00921
G1 X208.161 Y68.977 E.27084
G1 X208.161 Y68.411 E.00921
G1 X196.969 Y57.219 E.25782
G1 X197.534 Y57.219 E.00921
G1 X208.161 Y67.846 E.24479
G1 X208.161 Y67.281 E.00921
G1 X198.1 Y57.219 E.23177
G1 X198.665 Y57.219 E.00921
G1 X208.161 Y66.715 E.21875
G1 X208.161 Y66.15 E.00921
G1 X199.231 Y57.219 E.20572
G1 X199.796 Y57.219 E.00921
G1 X208.161 Y65.584 E.1927
G1 X208.161 Y65.019 E.00921
G1 X200.361 Y57.219 E.17967
G1 X200.927 Y57.219 E.00921
G1 X208.161 Y64.454 E.16665
G1 X208.161 Y63.888 E.00921
G1 X201.492 Y57.219 E.15362
G1 X202.057 Y57.219 E.00921
G1 X208.161 Y63.323 E.1406
G1 X208.161 Y62.758 E.00921
G1 X202.623 Y57.219 E.12758
G1 X203.188 Y57.219 E.00921
G1 X208.161 Y62.192 E.11455
G1 X208.161 Y61.627 E.00921
G1 X203.754 Y57.219 E.10153
G1 X204.319 Y57.219 E.00921
G1 X208.161 Y61.061 E.0885
G1 X208.161 Y60.496 E.00921
G1 X204.884 Y57.219 E.07548
G1 X205.45 Y57.219 E.00921
G1 X208.161 Y59.931 E.06245
G1 X208.161 Y59.365 E.00921
G1 X206.015 Y57.219 E.04943
G1 X206.581 Y57.219 E.00921
G1 X208.161 Y58.8 E.03641
G1 X208.161 Y58.234 E.00921
G1 X207.146 Y57.219 E.02338
G1 X207.711 Y57.219 E.00921
G1 X208.34 Y57.848 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X207.711 Y57.219 E-.338
G1 X207.146 Y57.219 E-.21485
G1 X207.531 Y57.605 E-.20715
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 4/58
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.7 I.009 J-1.217 P1  F30000
G1 X107.471 Y56.87 Z.7
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
M73 P30 R53
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 4 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer4 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.641 Y57.849 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X108.27 Y57.219 E.01447
G1 X108.835 Y57.219 E.00918
G1 X107.821 Y58.234 E.02333
G1 X107.821 Y58.798 E.00918
G1 X109.399 Y57.219 E.03631
G1 X109.964 Y57.219 E.00918
G1 X107.821 Y59.363 E.04929
G1 X107.821 Y59.927 E.00918
G1 X110.528 Y57.219 E.06228
G1 X111.093 Y57.219 E.00918
G1 X107.821 Y60.492 E.07526
G1 X107.821 Y61.056 E.00918
G1 X111.657 Y57.219 E.08824
G1 X112.222 Y57.219 E.00918
G1 X107.821 Y61.621 E.10123
G1 X107.821 Y62.185 E.00918
G1 X112.786 Y57.219 E.11421
G1 X113.351 Y57.219 E.00918
G1 X107.821 Y62.75 E.12719
G1 X107.821 Y63.314 E.00918
G1 X113.915 Y57.219 E.14017
G1 X114.48 Y57.219 E.00918
G1 X107.821 Y63.879 E.15316
G1 X107.821 Y64.443 E.00918
G1 X115.044 Y57.219 E.16614
G1 X115.609 Y57.219 E.00918
G1 X107.821 Y65.008 E.17912
G1 X107.821 Y65.572 E.00918
G1 X116.173 Y57.219 E.1921
G1 X116.738 Y57.219 E.00918
G1 X107.821 Y66.137 E.20509
G1 X107.821 Y66.701 E.00918
G1 X117.302 Y57.219 E.21807
G1 X117.867 Y57.219 E.00918
G1 X107.821 Y67.265 E.23105
G1 X107.821 Y67.83 E.00918
G1 X118.431 Y57.219 E.24403
G1 X118.996 Y57.219 E.00918
G1 X107.821 Y68.394 E.25702
G1 X107.821 Y68.959 E.00918
G1 X119.56 Y57.219 E.27
G1 X120.125 Y57.219 E.00918
G1 X107.821 Y69.523 E.28298
G1 X107.821 Y70.088 E.00918
G1 X120.689 Y57.219 E.29596
G1 X121.254 Y57.219 E.00918
G1 X107.821 Y70.652 E.30895
G1 X107.821 Y71.217 E.00918
G1 X121.818 Y57.219 E.32193
G1 X122.383 Y57.219 E.00918
G1 X107.821 Y71.781 E.33491
G1 X107.821 Y72.346 E.00918
G1 X122.947 Y57.219 E.3479
G1 X123.512 Y57.219 E.00918
G1 X107.821 Y72.91 E.36088
G1 X107.821 Y73.475 E.00918
G1 X124.076 Y57.219 E.37386
G1 X124.641 Y57.219 E.00918
G1 X107.821 Y74.039 E.38684
G1 X107.821 Y74.604 E.00918
G1 X125.205 Y57.219 E.39983
G1 X125.769 Y57.219 E.00918
G1 X107.821 Y75.168 E.41281
G1 X107.821 Y75.733 E.00918
G1 X126.334 Y57.219 E.42579
G1 X126.898 Y57.219 E.00918
G1 X107.821 Y76.297 E.43877
G1 X107.821 Y76.862 E.00918
G1 X127.463 Y57.219 E.45176
G1 X128.027 Y57.219 E.00918
G1 X107.821 Y77.426 E.46474
G1 X107.821 Y77.991 E.00918
G1 X128.592 Y57.219 E.47772
G1 X129.156 Y57.219 E.00918
G1 X107.821 Y78.555 E.4907
G1 X107.821 Y79.12 E.00918
G1 X129.721 Y57.219 E.50369
G1 X130.285 Y57.219 E.00918
G1 X107.821 Y79.684 E.51667
G1 X107.821 Y80.249 E.00918
G1 X130.85 Y57.219 E.52965
G1 X131.414 Y57.219 E.00918
G1 X107.821 Y80.813 E.54263
G1 X107.821 Y81.378 E.00918
G1 X131.979 Y57.219 E.55562
G1 X132.543 Y57.219 E.00918
G1 X107.821 Y81.942 E.5686
G1 X107.821 Y82.507 E.00918
G1 X133.108 Y57.219 E.58158
M73 P30 R52
G1 X133.672 Y57.219 E.00918
G1 X107.821 Y83.071 E.59457
G1 X107.821 Y83.636 E.00918
G1 X134.237 Y57.219 E.60755
G1 X134.801 Y57.219 E.00918
G1 X107.821 Y84.2 E.62053
G1 X107.821 Y84.764 E.00918
G1 X135.366 Y57.219 E.63351
G1 X135.93 Y57.219 E.00918
G1 X107.821 Y85.329 E.6465
G1 X107.821 Y85.893 E.00918
G1 X136.495 Y57.219 E.65948
G1 X137.059 Y57.219 E.00918
G1 X107.821 Y86.458 E.67246
G1 X107.821 Y87.022 E.00918
G1 X137.624 Y57.219 E.68544
G1 X138.188 Y57.219 E.00918
G1 X107.821 Y87.587 E.69843
G1 X107.821 Y88.151 E.00918
G1 X138.753 Y57.219 E.71141
G1 X139.317 Y57.219 E.00918
G1 X107.821 Y88.716 E.72439
G1 X107.821 Y89.28 E.00918
G1 X139.882 Y57.219 E.73737
G1 X140.446 Y57.219 E.00918
G1 X107.927 Y89.738 E.7479
G1 X108.209 Y90.02 E.00649
G1 X141.011 Y57.219 E.7544
G1 X141.575 Y57.219 E.00918
G1 X108.492 Y90.303 E.76089
G1 X108.774 Y90.585 E.00649
G1 X142.14 Y57.219 E.76738
G1 X142.704 Y57.219 E.00918
G1 X109.056 Y90.867 E.77387
G1 X109.338 Y91.149 E.00649
G1 X143.268 Y57.219 E.78036
G1 X143.833 Y57.219 E.00918
G1 X109.621 Y91.432 E.78685
G1 X109.749 Y91.56 E.00295
G1 X110.057 Y91.56 E.00501
G1 X144.397 Y57.219 E.7898
G1 X144.962 Y57.219 E.00918
G1 X110.622 Y91.56 E.7898
G1 X111.186 Y91.56 E.00918
G1 X145.526 Y57.219 E.7898
G1 X146.091 Y57.219 E.00918
G1 X111.751 Y91.56 E.7898
G1 X112.315 Y91.56 E.00918
G1 X146.655 Y57.219 E.7898
G1 X147.22 Y57.219 E.00918
G1 X112.879 Y91.56 E.7898
G1 X113.444 Y91.56 E.00918
G1 X147.784 Y57.219 E.7898
G1 X148.349 Y57.219 E.00918
G1 X114.008 Y91.56 E.7898
G1 X114.573 Y91.56 E.00918
G1 X148.913 Y57.219 E.7898
G1 X149.478 Y57.219 E.00918
G1 X115.137 Y91.56 E.7898
G1 X115.702 Y91.56 E.00918
G1 X150.042 Y57.219 E.7898
G1 X150.607 Y57.219 E.00918
G1 X116.266 Y91.56 E.7898
G1 X116.831 Y91.56 E.00918
G1 X151.171 Y57.219 E.7898
G1 X151.736 Y57.219 E.00918
G1 X117.395 Y91.56 E.7898
G1 X117.96 Y91.56 E.00918
G1 X152.3 Y57.219 E.7898
G1 X152.865 Y57.219 E.00918
G1 X118.524 Y91.56 E.7898
G1 X119.089 Y91.56 E.00918
G1 X153.429 Y57.219 E.7898
G1 X153.994 Y57.219 E.00918
G1 X119.653 Y91.56 E.7898
G1 X120.218 Y91.56 E.00918
G1 X154.558 Y57.219 E.7898
G1 X155.123 Y57.219 E.00918
G1 X120.782 Y91.56 E.7898
G1 X121.347 Y91.56 E.00918
G1 X155.687 Y57.219 E.7898
G1 X156.252 Y57.219 E.00918
G1 X121.911 Y91.56 E.7898
G1 X122.476 Y91.56 E.00918
G1 X156.816 Y57.219 E.7898
G1 X157.381 Y57.219 E.00918
G1 X123.04 Y91.56 E.7898
G1 X123.605 Y91.56 E.00918
G1 X157.945 Y57.219 E.7898
G1 X158.51 Y57.219 E.00918
G1 X124.169 Y91.56 E.7898
G1 X124.734 Y91.56 E.00918
G1 X159.074 Y57.219 E.7898
G1 X159.638 Y57.219 E.00918
G1 X125.298 Y91.56 E.7898
G1 X125.863 Y91.56 E.00918
G1 X160.203 Y57.219 E.7898
G1 X160.767 Y57.219 E.00918
G1 X126.427 Y91.56 E.7898
G1 X126.992 Y91.56 E.00918
G1 X161.332 Y57.219 E.7898
G1 X161.896 Y57.219 E.00918
G1 X127.556 Y91.56 E.7898
G1 X128.121 Y91.56 E.00918
G1 X162.461 Y57.219 E.7898
G1 X163.025 Y57.219 E.00918
G1 X128.685 Y91.56 E.7898
G1 X129.25 Y91.56 E.00918
G1 X163.59 Y57.219 E.7898
G1 X164.154 Y57.219 E.00918
G1 X129.814 Y91.56 E.7898
G1 X130.378 Y91.56 E.00918
G1 X164.719 Y57.219 E.7898
G1 X165.283 Y57.219 E.00918
G1 X130.943 Y91.56 E.7898
G1 X131.507 Y91.56 E.00918
G1 X165.848 Y57.219 E.7898
G1 X166.412 Y57.219 E.00918
G1 X132.072 Y91.56 E.7898
G1 X132.636 Y91.56 E.00918
G1 X166.977 Y57.219 E.7898
G1 X167.541 Y57.219 E.00918
G1 X133.201 Y91.56 E.7898
M73 P31 R52
G1 X133.765 Y91.56 E.00918
G1 X168.106 Y57.219 E.7898
G1 X168.67 Y57.219 E.00918
G1 X134.33 Y91.56 E.7898
G1 X134.894 Y91.56 E.00918
G1 X169.235 Y57.219 E.7898
G1 X169.799 Y57.219 E.00918
G1 X135.459 Y91.56 E.7898
G1 X136.023 Y91.56 E.00918
G1 X170.364 Y57.219 E.7898
G1 X170.928 Y57.219 E.00918
G1 X136.588 Y91.56 E.7898
G1 X137.152 Y91.56 E.00918
G1 X171.493 Y57.219 E.7898
G1 X172.057 Y57.219 E.00918
G1 X137.717 Y91.56 E.7898
G1 X138.281 Y91.56 E.00918
G1 X172.622 Y57.219 E.7898
G1 X173.186 Y57.219 E.00918
G1 X138.846 Y91.56 E.7898
G1 X139.41 Y91.56 E.00918
G1 X173.751 Y57.219 E.7898
G1 X174.315 Y57.219 E.00918
G1 X139.975 Y91.56 E.7898
G1 X140.539 Y91.56 E.00918
G1 X174.88 Y57.219 E.7898
G1 X175.444 Y57.219 E.00918
G1 X141.104 Y91.56 E.7898
G1 X141.668 Y91.56 E.00918
G1 X176.009 Y57.219 E.7898
G1 X176.573 Y57.219 E.00918
G1 X142.233 Y91.56 E.7898
G1 X142.797 Y91.56 E.00918
G1 X177.137 Y57.219 E.7898
G1 X177.702 Y57.219 E.00918
G1 X143.362 Y91.56 E.7898
G1 X143.926 Y91.56 E.00918
G1 X178.266 Y57.219 E.7898
G1 X178.831 Y57.219 E.00918
G1 X144.491 Y91.56 E.7898
G1 X145.055 Y91.56 E.00918
G1 X179.395 Y57.219 E.7898
G1 X179.96 Y57.219 E.00918
G1 X145.62 Y91.56 E.7898
G1 X146.184 Y91.56 E.00918
G1 X180.524 Y57.219 E.7898
G1 X181.089 Y57.219 E.00918
G1 X146.748 Y91.56 E.7898
G1 X147.313 Y91.56 E.00918
G1 X181.653 Y57.219 E.7898
G1 X182.218 Y57.219 E.00918
G1 X147.877 Y91.56 E.7898
G1 X148.442 Y91.56 E.00918
G1 X182.782 Y57.219 E.7898
G1 X183.347 Y57.219 E.00918
G1 X149.006 Y91.56 E.7898
G1 X149.571 Y91.56 E.00918
G1 X183.911 Y57.219 E.7898
G1 X184.476 Y57.219 E.00918
G1 X150.135 Y91.56 E.7898
G1 X150.7 Y91.56 E.00918
G1 X185.04 Y57.219 E.7898
G1 X185.605 Y57.219 E.00918
G1 X151.264 Y91.56 E.7898
G1 X151.829 Y91.56 E.00918
G1 X186.169 Y57.219 E.7898
G1 X186.734 Y57.219 E.00918
G1 X152.393 Y91.56 E.7898
G1 X152.958 Y91.56 E.00918
G1 X187.298 Y57.219 E.7898
G1 X187.863 Y57.219 E.00918
G1 X153.522 Y91.56 E.7898
G1 X154.087 Y91.56 E.00918
G1 X188.427 Y57.219 E.7898
G1 X188.992 Y57.219 E.00918
G1 X154.651 Y91.56 E.7898
G1 X155.216 Y91.56 E.00918
G1 X189.556 Y57.219 E.7898
G1 X190.121 Y57.219 E.00918
G1 X155.78 Y91.56 E.7898
G1 X156.345 Y91.56 E.00918
G1 X190.685 Y57.219 E.7898
G1 X191.25 Y57.219 E.00918
G1 X156.909 Y91.56 E.7898
G1 X157.474 Y91.56 E.00918
G1 X191.814 Y57.219 E.7898
G1 X192.379 Y57.219 E.00918
G1 X158.038 Y91.56 E.7898
G1 X158.603 Y91.56 E.00918
G1 X192.943 Y57.219 E.7898
G1 X193.507 Y57.219 E.00918
G1 X159.167 Y91.56 E.7898
G1 X159.732 Y91.56 E.00918
G1 X194.072 Y57.219 E.7898
G1 X194.636 Y57.219 E.00918
G1 X160.296 Y91.56 E.7898
G1 X160.861 Y91.56 E.00918
G1 X195.201 Y57.219 E.7898
G1 X195.765 Y57.219 E.00918
G1 X161.425 Y91.56 E.7898
G1 X161.99 Y91.56 E.00918
G1 X196.33 Y57.219 E.7898
G1 X196.894 Y57.219 E.00918
G1 X162.554 Y91.56 E.7898
G1 X163.119 Y91.56 E.00918
G1 X197.459 Y57.219 E.7898
G1 X198.023 Y57.219 E.00918
G1 X163.683 Y91.56 E.7898
G1 X164.247 Y91.56 E.00918
G1 X198.588 Y57.219 E.7898
G1 X199.152 Y57.219 E.00918
G1 X164.812 Y91.56 E.7898
G1 X165.376 Y91.56 E.00918
G1 X199.717 Y57.219 E.7898
G1 X200.281 Y57.219 E.00918
G1 X165.941 Y91.56 E.7898
G1 X166.505 Y91.56 E.00918
G1 X200.846 Y57.219 E.7898
G1 X201.41 Y57.219 E.00918
G1 X167.07 Y91.56 E.7898
G1 X167.634 Y91.56 E.00918
G1 X201.975 Y57.219 E.7898
G1 X202.539 Y57.219 E.00918
G1 X168.199 Y91.56 E.7898
G1 X168.763 Y91.56 E.00918
G1 X203.104 Y57.219 E.7898
G1 X203.668 Y57.219 E.00918
G1 X169.328 Y91.56 E.7898
G1 X169.892 Y91.56 E.00918
G1 X204.233 Y57.219 E.7898
G1 X204.797 Y57.219 E.00918
M73 P31 R51
G1 X170.457 Y91.56 E.7898
G1 X171.021 Y91.56 E.00918
G1 X205.362 Y57.219 E.7898
G1 X205.926 Y57.219 E.00918
G1 X171.586 Y91.56 E.7898
G1 X172.15 Y91.56 E.00918
G1 X206.491 Y57.219 E.7898
G1 X207.055 Y57.219 E.00918
G1 X172.715 Y91.56 E.7898
G1 X173.279 Y91.56 E.00918
G1 X207.62 Y57.219 E.7898
G1 X208.161 Y57.219 E.0088
G1 X208.161 Y57.242 E.00038
G1 X173.844 Y91.56 E.78927
G1 X174.408 Y91.56 E.00918
G1 X208.161 Y57.807 E.77628
G1 X208.161 Y58.371 E.00918
G1 X174.973 Y91.56 E.7633
G1 X175.537 Y91.56 E.00918
G1 X208.161 Y58.936 E.75032
G1 X208.161 Y59.5 E.00918
G1 X176.102 Y91.56 E.73734
G1 X176.666 Y91.56 E.00918
G1 X208.161 Y60.065 E.72435
M73 P32 R51
G1 X208.161 Y60.629 E.00918
G1 X177.231 Y91.56 E.71137
G1 X177.795 Y91.56 E.00918
G1 X208.161 Y61.194 E.69839
G1 X208.161 Y61.758 E.00918
G1 X178.36 Y91.56 E.68541
G1 X178.924 Y91.56 E.00918
G1 X208.161 Y62.323 E.67242
G1 X208.161 Y62.887 E.00918
G1 X179.489 Y91.56 E.65944
G1 X180.053 Y91.56 E.00918
G1 X208.161 Y63.452 E.64646
G1 X208.161 Y64.016 E.00918
G1 X180.617 Y91.56 E.63348
G1 X181.182 Y91.56 E.00918
G1 X208.161 Y64.581 E.62049
G1 X208.161 Y65.145 E.00918
G1 X181.746 Y91.56 E.60751
G1 X182.311 Y91.56 E.00918
G1 X208.161 Y65.71 E.59453
G1 X208.161 Y66.274 E.00918
G1 X182.875 Y91.56 E.58155
G1 X183.44 Y91.56 E.00918
G1 X208.161 Y66.839 E.56856
G1 X208.161 Y67.403 E.00918
G1 X184.004 Y91.56 E.55558
G1 X184.569 Y91.56 E.00918
G1 X208.161 Y67.968 E.5426
G1 X208.161 Y68.532 E.00918
G1 X185.133 Y91.56 E.52961
G1 X185.698 Y91.56 E.00918
G1 X208.161 Y69.097 E.51663
G1 X208.161 Y69.661 E.00918
G1 X186.262 Y91.56 E.50365
G1 X186.827 Y91.56 E.00918
G1 X208.161 Y70.226 E.49067
G1 X208.161 Y70.79 E.00918
G1 X187.391 Y91.56 E.47768
G1 X187.956 Y91.56 E.00918
G1 X208.161 Y71.355 E.4647
G1 X208.161 Y71.919 E.00918
G1 X188.52 Y91.56 E.45172
G1 X189.085 Y91.56 E.00918
G1 X208.161 Y72.484 E.43874
G1 X208.161 Y73.048 E.00918
G1 X189.649 Y91.56 E.42575
G1 X190.214 Y91.56 E.00918
G1 X208.161 Y73.612 E.41277
G1 X208.161 Y74.177 E.00918
G1 X190.778 Y91.56 E.39979
G1 X191.343 Y91.56 E.00918
G1 X208.161 Y74.741 E.38681
G1 X208.161 Y75.306 E.00918
G1 X191.907 Y91.56 E.37382
G1 X192.472 Y91.56 E.00918
G1 X208.161 Y75.87 E.36084
G1 X208.161 Y76.435 E.00918
G1 X193.036 Y91.56 E.34786
G1 X193.601 Y91.56 E.00918
G1 X208.161 Y76.999 E.33488
G1 X208.161 Y77.564 E.00918
G1 X194.165 Y91.56 E.32189
G1 X194.73 Y91.56 E.00918
G1 X208.161 Y78.128 E.30891
G1 X208.161 Y78.693 E.00918
G1 X195.294 Y91.56 E.29593
G1 X195.859 Y91.56 E.00918
G1 X208.161 Y79.257 E.28294
G1 X208.161 Y79.822 E.00918
G1 X196.423 Y91.56 E.26996
G1 X196.988 Y91.56 E.00918
G1 X208.161 Y80.386 E.25698
G1 X208.161 Y80.951 E.00918
G1 X197.552 Y91.56 E.244
G1 X198.116 Y91.56 E.00918
G1 X208.161 Y81.515 E.23101
G1 X208.161 Y82.08 E.00918
G1 X198.681 Y91.56 E.21803
G1 X199.245 Y91.56 E.00918
G1 X208.161 Y82.644 E.20505
G1 X208.161 Y83.209 E.00918
G1 X199.81 Y91.56 E.19207
G1 X200.374 Y91.56 E.00918
G1 X208.161 Y83.773 E.17908
G1 X208.161 Y84.338 E.00918
G1 X200.939 Y91.56 E.1661
G1 X201.503 Y91.56 E.00918
G1 X208.161 Y84.902 E.15312
G1 X208.161 Y85.467 E.00918
G1 X202.068 Y91.56 E.14014
G1 X202.632 Y91.56 E.00918
G1 X208.161 Y86.031 E.12715
G1 X208.161 Y86.596 E.00918
G1 X203.197 Y91.56 E.11417
G1 X203.761 Y91.56 E.00918
G1 X208.161 Y87.16 E.10119
G1 X208.161 Y87.725 E.00918
G1 X204.326 Y91.56 E.08821
G1 X204.89 Y91.56 E.00918
G1 X208.161 Y88.289 E.07522
G1 X208.161 Y88.854 E.00918
G1 X205.455 Y91.56 E.06224
G1 X206.019 Y91.56 E.00918
G1 X208.161 Y89.418 E.04926
G1 X208.161 Y89.983 E.00918
G1 X206.584 Y91.56 E.03627
G1 X207.148 Y91.56 E.00918
G1 X208.161 Y90.547 E.02329
G1 X208.161 Y91.111 E.00918
G1 X207.533 Y91.739 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 0.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X208.161 Y91.111 E-.33727
G1 X208.161 Y90.547 E-.21451
G1 X207.774 Y90.934 E-.20822
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 5/58
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.8 I.391 J-1.152 P1  F30000
G1 X107.471 Y56.87 Z.8
G1 Z.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 5 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer5 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.074 Y63.29 Z.9 F30000
G1 X107.641 Y89.45 Z.9
G1 Z.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X109.751 Y91.56 E.0486
G1 X110.316 Y91.56 E.00921
G1 X107.821 Y89.064 E.05749
G1 X107.821 Y88.499 E.00921
G1 X110.882 Y91.56 E.07051
G1 X111.447 Y91.56 E.00921
G1 X107.821 Y87.933 E.08354
G1 X107.821 Y87.368 E.00921
G1 X112.012 Y91.56 E.09656
G1 X112.578 Y91.56 E.00921
G1 X107.821 Y86.803 E.10959
G1 X107.821 Y86.237 E.00921
G1 X113.143 Y91.56 E.12261
G1 X113.709 Y91.56 E.00921
G1 X107.821 Y85.672 E.13563
G1 X107.821 Y85.106 E.00921
G1 X114.274 Y91.56 E.14866
G1 X114.839 Y91.56 E.00921
G1 X107.821 Y84.541 E.16168
G1 X107.821 Y83.976 E.00921
G1 X115.405 Y91.56 E.17471
G1 X115.97 Y91.56 E.00921
G1 X107.821 Y83.41 E.18773
G1 X107.821 Y82.845 E.00921
G1 X116.535 Y91.56 E.20076
G1 X117.101 Y91.56 E.00921
G1 X107.821 Y82.28 E.21378
G1 X107.821 Y81.714 E.00921
G1 X117.666 Y91.56 E.2268
G1 X118.232 Y91.56 E.00921
G1 X107.821 Y81.149 E.23983
G1 X107.821 Y80.583 E.00921
M73 P33 R51
G1 X118.797 Y91.56 E.25285
G1 X119.362 Y91.56 E.00921
G1 X107.821 Y80.018 E.26588
G1 X107.821 Y79.453 E.00921
G1 X119.928 Y91.56 E.2789
G1 X120.493 Y91.56 E.00921
G1 X107.821 Y78.887 E.29193
G1 X107.821 Y78.322 E.00921
G1 X121.059 Y91.56 E.30495
G1 X121.624 Y91.56 E.00921
G1 X107.821 Y77.756 E.31797
G1 X107.821 Y77.191 E.00921
G1 X122.189 Y91.56 E.331
G1 X122.755 Y91.56 E.00921
G1 X107.821 Y76.626 E.34402
G1 X107.821 Y76.06 E.00921
G1 X123.32 Y91.56 E.35705
G1 X123.886 Y91.56 E.00921
G1 X107.821 Y75.495 E.37007
G1 X107.821 Y74.929 E.00921
G1 X124.451 Y91.56 E.3831
G1 X125.016 Y91.56 E.00921
G1 X107.821 Y74.364 E.39612
G1 X107.821 Y73.799 E.00921
G1 X125.582 Y91.56 E.40914
G1 X126.147 Y91.56 E.00921
G1 X107.821 Y73.233 E.42217
G1 X107.821 Y72.668 E.00921
G1 X126.712 Y91.56 E.43519
G1 X127.278 Y91.56 E.00921
G1 X107.821 Y72.103 E.44822
G1 X107.821 Y71.537 E.00921
G1 X127.843 Y91.56 E.46124
G1 X128.409 Y91.56 E.00921
G1 X107.821 Y70.972 E.47427
G1 X107.821 Y70.406 E.00921
G1 X128.974 Y91.56 E.48729
G1 X129.539 Y91.56 E.00921
G1 X107.821 Y69.841 E.50031
G1 X107.821 Y69.276 E.00921
M73 P33 R50
G1 X130.105 Y91.56 E.51334
G1 X130.67 Y91.56 E.00921
G1 X107.821 Y68.71 E.52636
G1 X107.821 Y68.145 E.00921
G1 X131.236 Y91.56 E.53939
G1 X131.801 Y91.56 E.00921
G1 X107.821 Y67.579 E.55241
G1 X107.821 Y67.014 E.00921
G1 X132.366 Y91.56 E.56544
G1 X132.932 Y91.56 E.00921
G1 X107.821 Y66.449 E.57846
G1 X107.821 Y65.883 E.00921
G1 X133.497 Y91.56 E.59148
G1 X134.063 Y91.56 E.00921
G1 X107.821 Y65.318 E.60451
G1 X107.821 Y64.752 E.00921
G1 X134.628 Y91.56 E.61753
G1 X135.193 Y91.56 E.00921
G1 X107.821 Y64.187 E.63056
G1 X107.821 Y63.622 E.00921
G1 X135.759 Y91.56 E.64358
G1 X136.324 Y91.56 E.00921
G1 X107.821 Y63.056 E.65661
G1 X107.821 Y62.491 E.00921
G1 X136.889 Y91.56 E.66963
G1 X137.455 Y91.56 E.00921
G1 X107.821 Y61.926 E.68265
G1 X107.821 Y61.36 E.00921
G1 X138.02 Y91.56 E.69568
G1 X138.586 Y91.56 E.00921
G1 X107.821 Y60.795 E.7087
G1 X107.821 Y60.229 E.00921
G1 X139.151 Y91.56 E.72173
G1 X139.716 Y91.56 E.00921
G1 X107.821 Y59.664 E.73475
G1 X107.821 Y59.099 E.00921
G1 X140.282 Y91.56 E.74778
G1 X140.847 Y91.56 E.00921
G1 X107.821 Y58.533 E.7608
G1 X107.821 Y57.968 E.00921
G1 X141.413 Y91.56 E.77382
G1 X141.978 Y91.56 E.00921
G1 X107.821 Y57.402 E.78685
G1 X107.821 Y57.219 E.00298
G1 X108.203 Y57.219 E.00623
G1 X142.543 Y91.56 E.79106
G1 X143.109 Y91.56 E.00921
G1 X108.768 Y57.219 E.79106
G1 X109.334 Y57.219 E.00921
G1 X143.674 Y91.56 E.79106
G1 X144.239 Y91.56 E.00921
G1 X109.899 Y57.219 E.79106
G1 X110.465 Y57.219 E.00921
G1 X144.805 Y91.56 E.79106
G1 X145.37 Y91.56 E.00921
G1 X111.03 Y57.219 E.79106
G1 X111.595 Y57.219 E.00921
G1 X145.936 Y91.56 E.79106
G1 X146.501 Y91.56 E.00921
G1 X112.161 Y57.219 E.79106
G1 X112.726 Y57.219 E.00921
G1 X147.066 Y91.56 E.79106
G1 X147.632 Y91.56 E.00921
G1 X113.291 Y57.219 E.79106
G1 X113.857 Y57.219 E.00921
G1 X148.197 Y91.56 E.79106
G1 X148.763 Y91.56 E.00921
G1 X114.422 Y57.219 E.79106
G1 X114.988 Y57.219 E.00921
G1 X149.328 Y91.56 E.79106
G1 X149.893 Y91.56 E.00921
G1 X115.553 Y57.219 E.79106
G1 X116.118 Y57.219 E.00921
G1 X150.459 Y91.56 E.79106
G1 X151.024 Y91.56 E.00921
G1 X116.684 Y57.219 E.79106
G1 X117.249 Y57.219 E.00921
G1 X151.59 Y91.56 E.79106
G1 X152.155 Y91.56 E.00921
G1 X117.815 Y57.219 E.79106
G1 X118.38 Y57.219 E.00921
G1 X152.72 Y91.56 E.79106
G1 X153.286 Y91.56 E.00921
G1 X118.945 Y57.219 E.79106
G1 X119.511 Y57.219 E.00921
G1 X153.851 Y91.56 E.79106
G1 X154.416 Y91.56 E.00921
G1 X120.076 Y57.219 E.79106
G1 X120.642 Y57.219 E.00921
G1 X154.982 Y91.56 E.79106
G1 X155.547 Y91.56 E.00921
G1 X121.207 Y57.219 E.79106
G1 X121.772 Y57.219 E.00921
G1 X156.113 Y91.56 E.79106
G1 X156.678 Y91.56 E.00921
G1 X122.338 Y57.219 E.79106
G1 X122.903 Y57.219 E.00921
G1 X157.243 Y91.56 E.79106
G1 X157.809 Y91.56 E.00921
G1 X123.468 Y57.219 E.79106
G1 X124.034 Y57.219 E.00921
G1 X158.374 Y91.56 E.79106
G1 X158.94 Y91.56 E.00921
G1 X124.599 Y57.219 E.79106
G1 X125.165 Y57.219 E.00921
G1 X159.505 Y91.56 E.79106
G1 X160.07 Y91.56 E.00921
G1 X125.73 Y57.219 E.79106
G1 X126.295 Y57.219 E.00921
G1 X160.636 Y91.56 E.79106
G1 X161.201 Y91.56 E.00921
G1 X126.861 Y57.219 E.79106
G1 X127.426 Y57.219 E.00921
G1 X161.767 Y91.56 E.79106
G1 X162.332 Y91.56 E.00921
G1 X127.992 Y57.219 E.79106
G1 X128.557 Y57.219 E.00921
G1 X162.897 Y91.56 E.79106
G1 X163.463 Y91.56 E.00921
G1 X129.122 Y57.219 E.79106
G1 X129.688 Y57.219 E.00921
G1 X164.028 Y91.56 E.79106
G1 X164.593 Y91.56 E.00921
G1 X130.253 Y57.219 E.79106
G1 X130.819 Y57.219 E.00921
G1 X165.159 Y91.56 E.79106
G1 X165.724 Y91.56 E.00921
G1 X131.384 Y57.219 E.79106
G1 X131.949 Y57.219 E.00921
G1 X166.29 Y91.56 E.79106
G1 X166.855 Y91.56 E.00921
G1 X132.515 Y57.219 E.79106
G1 X133.08 Y57.219 E.00921
G1 X167.42 Y91.56 E.79106
G1 X167.986 Y91.56 E.00921
G1 X133.645 Y57.219 E.79106
G1 X134.211 Y57.219 E.00921
G1 X168.551 Y91.56 E.79106
G1 X169.117 Y91.56 E.00921
G1 X134.776 Y57.219 E.79106
G1 X135.342 Y57.219 E.00921
G1 X169.682 Y91.56 E.79106
G1 X170.247 Y91.56 E.00921
G1 X135.907 Y57.219 E.79106
G1 X136.472 Y57.219 E.00921
G1 X170.813 Y91.56 E.79106
G1 X171.378 Y91.56 E.00921
G1 X137.038 Y57.219 E.79106
G1 X137.603 Y57.219 E.00921
G1 X171.944 Y91.56 E.79106
G1 X172.509 Y91.56 E.00921
G1 X138.169 Y57.219 E.79106
G1 X138.734 Y57.219 E.00921
G1 X173.074 Y91.56 E.79106
G1 X173.64 Y91.56 E.00921
G1 X139.299 Y57.219 E.79106
G1 X139.865 Y57.219 E.00921
G1 X174.205 Y91.56 E.79106
G1 X174.77 Y91.56 E.00921
G1 X140.43 Y57.219 E.79106
G1 X140.996 Y57.219 E.00921
G1 X175.336 Y91.56 E.79106
G1 X175.901 Y91.56 E.00921
G1 X141.561 Y57.219 E.79106
G1 X142.126 Y57.219 E.00921
G1 X176.467 Y91.56 E.79106
G1 X177.032 Y91.56 E.00921
G1 X142.692 Y57.219 E.79106
G1 X143.257 Y57.219 E.00921
M73 P34 R50
G1 X177.597 Y91.56 E.79106
G1 X178.163 Y91.56 E.00921
G1 X143.822 Y57.219 E.79106
G1 X144.388 Y57.219 E.00921
G1 X178.728 Y91.56 E.79106
G1 X179.294 Y91.56 E.00921
G1 X144.953 Y57.219 E.79106
G1 X145.519 Y57.219 E.00921
G1 X179.859 Y91.56 E.79106
G1 X180.424 Y91.56 E.00921
G1 X146.084 Y57.219 E.79106
G1 X146.649 Y57.219 E.00921
G1 X180.99 Y91.56 E.79106
G1 X181.555 Y91.56 E.00921
G1 X147.215 Y57.219 E.79106
G1 X147.78 Y57.219 E.00921
G1 X182.121 Y91.56 E.79106
G1 X182.686 Y91.56 E.00921
G1 X148.346 Y57.219 E.79106
G1 X148.911 Y57.219 E.00921
G1 X183.251 Y91.56 E.79106
G1 X183.817 Y91.56 E.00921
G1 X149.476 Y57.219 E.79106
G1 X150.042 Y57.219 E.00921
G1 X184.382 Y91.56 E.79106
G1 X184.947 Y91.56 E.00921
G1 X150.607 Y57.219 E.79106
G1 X151.172 Y57.219 E.00921
G1 X185.513 Y91.56 E.79106
G1 X186.078 Y91.56 E.00921
G1 X151.738 Y57.219 E.79106
G1 X152.303 Y57.219 E.00921
G1 X186.644 Y91.56 E.79106
G1 X187.209 Y91.56 E.00921
G1 X152.869 Y57.219 E.79106
G1 X153.434 Y57.219 E.00921
G1 X187.774 Y91.56 E.79106
G1 X188.34 Y91.56 E.00921
G1 X153.999 Y57.219 E.79106
G1 X154.565 Y57.219 E.00921
G1 X188.905 Y91.56 E.79106
G1 X189.471 Y91.56 E.00921
G1 X155.13 Y57.219 E.79106
G1 X155.696 Y57.219 E.00921
G1 X190.036 Y91.56 E.79106
G1 X190.601 Y91.56 E.00921
G1 X156.261 Y57.219 E.79106
G1 X156.826 Y57.219 E.00921
G1 X191.167 Y91.56 E.79106
G1 X191.732 Y91.56 E.00921
G1 X157.392 Y57.219 E.79106
G1 X157.957 Y57.219 E.00921
G1 X192.298 Y91.56 E.79106
G1 X192.863 Y91.56 E.00921
G1 X158.523 Y57.219 E.79106
G1 X159.088 Y57.219 E.00921
G1 X193.428 Y91.56 E.79106
G1 X193.994 Y91.56 E.00921
G1 X159.653 Y57.219 E.79106
G1 X160.219 Y57.219 E.00921
G1 X194.559 Y91.56 E.79106
G1 X195.124 Y91.56 E.00921
G1 X160.784 Y57.219 E.79106
G1 X161.349 Y57.219 E.00921
G1 X195.69 Y91.56 E.79106
G1 X196.255 Y91.56 E.00921
G1 X161.915 Y57.219 E.79106
G1 X162.48 Y57.219 E.00921
G1 X196.821 Y91.56 E.79106
G1 X197.386 Y91.56 E.00921
G1 X163.046 Y57.219 E.79106
G1 X163.611 Y57.219 E.00921
M73 P34 R49
G1 X197.951 Y91.56 E.79106
G1 X198.517 Y91.56 E.00921
G1 X164.176 Y57.219 E.79106
G1 X164.742 Y57.219 E.00921
G1 X199.082 Y91.56 E.79106
G1 X199.648 Y91.56 E.00921
G1 X165.307 Y57.219 E.79106
G1 X165.873 Y57.219 E.00921
G1 X200.213 Y91.56 E.79106
G1 X200.778 Y91.56 E.00921
G1 X166.438 Y57.219 E.79106
G1 X167.003 Y57.219 E.00921
G1 X201.344 Y91.56 E.79106
G1 X201.909 Y91.56 E.00921
G1 X167.569 Y57.219 E.79106
G1 X168.134 Y57.219 E.00921
G1 X202.475 Y91.56 E.79106
G1 X203.04 Y91.56 E.00921
G1 X168.7 Y57.219 E.79106
G1 X169.265 Y57.219 E.00921
G1 X203.605 Y91.56 E.79106
G1 X204.171 Y91.56 E.00921
G1 X169.83 Y57.219 E.79106
G1 X170.396 Y57.219 E.00921
G1 X204.736 Y91.56 E.79106
G1 X205.301 Y91.56 E.00921
G1 X170.961 Y57.219 E.79106
G1 X171.526 Y57.219 E.00921
G1 X205.867 Y91.56 E.79106
G1 X206.432 Y91.56 E.00921
G1 X172.092 Y57.219 E.79106
G1 X172.657 Y57.219 E.00921
G1 X206.998 Y91.56 E.79106
G1 X207.563 Y91.56 E.00921
G1 X173.223 Y57.219 E.79106
G1 X173.788 Y57.219 E.00921
G1 X208.128 Y91.56 E.79106
G1 X208.161 Y91.56 E.00053
G1 X208.161 Y91.027 E.00868
G1 X174.353 Y57.219 E.77879
G1 X174.919 Y57.219 E.00921
G1 X208.161 Y90.462 E.76577
G1 X208.161 Y89.896 E.00921
G1 X175.484 Y57.219 E.75274
G1 X176.05 Y57.219 E.00921
G1 X208.161 Y89.331 E.73972
G1 X208.161 Y88.765 E.00921
G1 X176.615 Y57.219 E.72669
G1 X177.18 Y57.219 E.00921
G1 X208.161 Y88.2 E.71367
G1 X208.161 Y87.635 E.00921
G1 X177.746 Y57.219 E.70064
G1 X178.311 Y57.219 E.00921
G1 X208.161 Y87.069 E.68762
G1 X208.161 Y86.504 E.00921
G1 X178.877 Y57.219 E.6746
G1 X179.442 Y57.219 E.00921
G1 X208.161 Y85.938 E.66157
G1 X208.161 Y85.373 E.00921
G1 X180.007 Y57.219 E.64855
G1 X180.573 Y57.219 E.00921
G1 X208.161 Y84.808 E.63552
G1 X208.161 Y84.242 E.00921
G1 X181.138 Y57.219 E.6225
G1 X181.703 Y57.219 E.00921
G1 X208.161 Y83.677 E.60947
G1 X208.161 Y83.111 E.00921
G1 X182.269 Y57.219 E.59645
G1 X182.834 Y57.219 E.00921
G1 X208.161 Y82.546 E.58343
G1 X208.161 Y81.981 E.00921
G1 X183.4 Y57.219 E.5704
G1 X183.965 Y57.219 E.00921
G1 X208.161 Y81.415 E.55738
G1 X208.161 Y80.85 E.00921
G1 X184.53 Y57.219 E.54435
G1 X185.096 Y57.219 E.00921
G1 X208.161 Y80.285 E.53133
G1 X208.161 Y79.719 E.00921
G1 X185.661 Y57.219 E.5183
G1 X186.227 Y57.219 E.00921
G1 X208.161 Y79.154 E.50528
M73 P35 R49
G1 X208.161 Y78.588 E.00921
G1 X186.792 Y57.219 E.49226
G1 X187.357 Y57.219 E.00921
G1 X208.161 Y78.023 E.47923
G1 X208.161 Y77.458 E.00921
G1 X187.923 Y57.219 E.46621
G1 X188.488 Y57.219 E.00921
G1 X208.161 Y76.892 E.45318
G1 X208.161 Y76.327 E.00921
G1 X189.054 Y57.219 E.44016
G1 X189.619 Y57.219 E.00921
G1 X208.161 Y75.761 E.42713
G1 X208.161 Y75.196 E.00921
G1 X190.184 Y57.219 E.41411
G1 X190.75 Y57.219 E.00921
G1 X208.161 Y74.631 E.40109
G1 X208.161 Y74.065 E.00921
G1 X191.315 Y57.219 E.38806
G1 X191.88 Y57.219 E.00921
G1 X208.161 Y73.5 E.37504
G1 X208.161 Y72.934 E.00921
G1 X192.446 Y57.219 E.36201
G1 X193.011 Y57.219 E.00921
G1 X208.161 Y72.369 E.34899
G1 X208.161 Y71.804 E.00921
G1 X193.577 Y57.219 E.33596
G1 X194.142 Y57.219 E.00921
G1 X208.161 Y71.238 E.32294
G1 X208.161 Y70.673 E.00921
G1 X194.707 Y57.219 E.30992
G1 X195.273 Y57.219 E.00921
G1 X208.161 Y70.108 E.29689
G1 X208.161 Y69.542 E.00921
G1 X195.838 Y57.219 E.28387
G1 X196.404 Y57.219 E.00921
G1 X208.161 Y68.977 E.27084
G1 X208.161 Y68.411 E.00921
G1 X196.969 Y57.219 E.25782
G1 X197.534 Y57.219 E.00921
G1 X208.161 Y67.846 E.24479
G1 X208.161 Y67.281 E.00921
G1 X198.1 Y57.219 E.23177
G1 X198.665 Y57.219 E.00921
G1 X208.161 Y66.715 E.21875
G1 X208.161 Y66.15 E.00921
G1 X199.231 Y57.219 E.20572
G1 X199.796 Y57.219 E.00921
G1 X208.161 Y65.584 E.1927
G1 X208.161 Y65.019 E.00921
G1 X200.361 Y57.219 E.17967
G1 X200.927 Y57.219 E.00921
G1 X208.161 Y64.454 E.16665
G1 X208.161 Y63.888 E.00921
G1 X201.492 Y57.219 E.15362
G1 X202.057 Y57.219 E.00921
G1 X208.161 Y63.323 E.1406
G1 X208.161 Y62.758 E.00921
G1 X202.623 Y57.219 E.12758
G1 X203.188 Y57.219 E.00921
G1 X208.161 Y62.192 E.11455
G1 X208.161 Y61.627 E.00921
G1 X203.754 Y57.219 E.10153
G1 X204.319 Y57.219 E.00921
G1 X208.161 Y61.061 E.0885
G1 X208.161 Y60.496 E.00921
G1 X204.884 Y57.219 E.07548
G1 X205.45 Y57.219 E.00921
G1 X208.161 Y59.931 E.06245
G1 X208.161 Y59.365 E.00921
G1 X206.015 Y57.219 E.04943
G1 X206.581 Y57.219 E.00921
G1 X208.161 Y58.8 E.03641
G1 X208.161 Y58.234 E.00921
G1 X207.146 Y57.219 E.02338
G1 X207.711 Y57.219 E.00921
G1 X208.34 Y57.848 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X207.711 Y57.219 E-.338
G1 X207.146 Y57.219 E-.21485
G1 X207.531 Y57.605 E-.20715
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 6/58
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.9 I.009 J-1.217 P1  F30000
G1 X107.471 Y56.87 Z.9
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 6 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer6 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.512 Y57.042 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X107.836 Y57.718 E.01671
G1 X107.836 Y58.326 E.01061
G1 X108.927 Y57.234 E.02695
G1 X109.535 Y57.234 E.01061
G1 X107.836 Y58.933 E.04195
G1 X107.836 Y59.541 E.01061
G1 X110.142 Y57.234 E.05695
G1 X110.75 Y57.234 E.01061
G1 X107.836 Y60.148 E.07195
G1 X107.836 Y60.756 E.01061
G1 X111.357 Y57.234 E.08696
G1 X111.965 Y57.234 E.01061
G1 X107.836 Y61.363 E.10196
G1 X107.836 Y61.971 E.01061
G1 X112.572 Y57.234 E.11696
G1 X113.18 Y57.234 E.01061
G1 X107.836 Y62.578 E.13196
G1 X107.836 Y63.186 E.01061
G1 X113.787 Y57.234 E.14696
G1 X114.395 Y57.234 E.01061
G1 X107.836 Y63.794 E.16196
G1 X107.836 Y64.401 E.01061
G1 X115.002 Y57.234 E.17696
G1 X115.61 Y57.234 E.01061
G1 X107.836 Y65.009 E.19196
G1 X107.836 Y65.616 E.01061
G1 X116.217 Y57.234 E.20696
G1 X116.825 Y57.234 E.01061
G1 X107.836 Y66.224 E.22197
G1 X107.836 Y66.831 E.01061
G1 X117.432 Y57.234 E.23697
G1 X118.04 Y57.234 E.01061
G1 X107.836 Y67.439 E.25197
G1 X107.836 Y68.046 E.01061
G1 X118.647 Y57.234 E.26697
G1 X119.255 Y57.234 E.01061
G1 X107.836 Y68.654 E.28197
M73 P35 R48
G1 X107.836 Y69.261 E.01061
G1 X119.862 Y57.234 E.29697
G1 X120.47 Y57.234 E.01061
G1 X107.836 Y69.869 E.31197
G1 X107.836 Y70.476 E.01061
G1 X121.077 Y57.234 E.32697
G1 X121.685 Y57.234 E.01061
G1 X107.836 Y71.084 E.34198
G1 X107.836 Y71.691 E.01061
G1 X122.292 Y57.234 E.35698
G1 X122.9 Y57.234 E.01061
G1 X107.836 Y72.299 E.37198
G1 X107.836 Y72.906 E.01061
G1 X123.508 Y57.234 E.38698
G1 X124.115 Y57.234 E.01061
G1 X107.836 Y73.514 E.40198
G1 X107.836 Y74.121 E.01061
G1 X124.723 Y57.234 E.41698
G1 X125.33 Y57.234 E.01061
G1 X107.836 Y74.729 E.43198
G1 X107.836 Y75.336 E.01061
G1 X125.938 Y57.234 E.44698
G1 X126.545 Y57.234 E.01061
G1 X107.836 Y75.944 E.46198
G1 X107.836 Y76.551 E.01061
G1 X127.153 Y57.234 E.47699
G1 X127.76 Y57.234 E.01061
G1 X107.836 Y77.159 E.49199
G1 X107.836 Y77.766 E.01061
G1 X128.368 Y57.234 E.50699
G1 X128.975 Y57.234 E.01061
G1 X107.836 Y78.374 E.52199
G1 X107.836 Y78.981 E.01061
G1 X129.583 Y57.234 E.53699
G1 X130.19 Y57.234 E.01061
G1 X107.836 Y79.589 E.55199
G1 X107.836 Y80.196 E.01061
G1 X130.798 Y57.234 E.56699
G1 X131.405 Y57.234 E.01061
G1 X107.836 Y80.804 E.58199
G1 X107.836 Y81.412 E.01061
G1 X132.013 Y57.234 E.597
G1 X132.62 Y57.234 E.01061
G1 X107.836 Y82.019 E.612
M73 P36 R48
G1 X107.836 Y82.627 E.01061
G1 X133.228 Y57.234 E.627
G1 X133.835 Y57.234 E.01061
G1 X107.836 Y83.234 E.642
G1 X107.836 Y83.842 E.01061
G1 X134.443 Y57.234 E.657
G1 X135.05 Y57.234 E.01061
G1 X107.836 Y84.449 E.672
G1 X107.836 Y85.057 E.01061
G1 X135.658 Y57.234 E.687
G1 X136.265 Y57.234 E.01061
G1 X107.836 Y85.664 E.702
G1 X107.836 Y86.272 E.01061
G1 X136.873 Y57.234 E.71701
G1 X137.48 Y57.234 E.01061
G1 X107.836 Y86.879 E.73201
G1 X107.836 Y87.487 E.01061
G1 X138.088 Y57.234 E.74701
G1 X138.695 Y57.234 E.01061
G1 X107.836 Y88.094 E.76201
G1 X107.836 Y88.702 E.01061
G1 X139.303 Y57.234 E.77701
G1 X139.91 Y57.234 E.01061
G1 X107.836 Y89.309 E.79201
G2 X107.981 Y89.771 I.304 J.158 E.00939
G1 X140.518 Y57.234 E.80341
G1 X141.126 Y57.234 E.01061
G1 X108.285 Y90.075 E.81092
G1 X108.589 Y90.379 E.0075
G1 X141.733 Y57.234 E.81842
G1 X142.341 Y57.234 E.01061
G1 X108.893 Y90.682 E.82592
G1 X109.196 Y90.986 E.0075
G1 X142.948 Y57.234 E.83342
G1 X143.556 Y57.234 E.01061
G1 X109.5 Y91.29 E.84092
G1 X109.755 Y91.545 E.00629
G1 X109.853 Y91.545 E.00171
G1 X144.163 Y57.234 E.84721
G1 X144.771 Y57.234 E.01061
G1 X110.46 Y91.545 E.84721
G1 X111.068 Y91.545 E.01061
G1 X145.378 Y57.234 E.84721
G1 X145.986 Y57.234 E.01061
G1 X111.675 Y91.545 E.84721
G1 X112.283 Y91.545 E.01061
G1 X146.593 Y57.234 E.84721
G1 X147.201 Y57.234 E.01061
G1 X112.89 Y91.545 E.84721
G1 X113.498 Y91.545 E.01061
G1 X147.808 Y57.234 E.84721
G1 X148.416 Y57.234 E.01061
G1 X114.105 Y91.545 E.84721
G1 X114.713 Y91.545 E.01061
G1 X149.023 Y57.234 E.84721
G1 X149.631 Y57.234 E.01061
G1 X115.32 Y91.545 E.84721
G1 X115.928 Y91.545 E.01061
G1 X150.238 Y57.234 E.84721
G1 X150.846 Y57.234 E.01061
G1 X116.535 Y91.545 E.84721
G1 X117.143 Y91.545 E.01061
G1 X151.453 Y57.234 E.84721
G1 X152.061 Y57.234 E.01061
G1 X117.75 Y91.545 E.84721
G1 X118.358 Y91.545 E.01061
G1 X152.668 Y57.234 E.84721
G1 X153.276 Y57.234 E.01061
G1 X118.966 Y91.545 E.84721
G1 X119.573 Y91.545 E.01061
G1 X153.883 Y57.234 E.84721
G1 X154.491 Y57.234 E.01061
G1 X120.181 Y91.545 E.84721
G1 X120.788 Y91.545 E.01061
G1 X155.098 Y57.234 E.84721
G1 X155.706 Y57.234 E.01061
G1 X121.396 Y91.545 E.84721
G1 X122.003 Y91.545 E.01061
G1 X156.313 Y57.234 E.84721
G1 X156.921 Y57.234 E.01061
G1 X122.611 Y91.545 E.84721
G1 X123.218 Y91.545 E.01061
G1 X157.529 Y57.234 E.84721
G1 X158.136 Y57.234 E.01061
G1 X123.826 Y91.545 E.84721
G1 X124.433 Y91.545 E.01061
G1 X158.744 Y57.234 E.84721
G1 X159.351 Y57.234 E.01061
G1 X125.041 Y91.545 E.84721
G1 X125.648 Y91.545 E.01061
G1 X159.959 Y57.234 E.84721
G1 X160.566 Y57.234 E.01061
G1 X126.256 Y91.545 E.84721
G1 X126.863 Y91.545 E.01061
G1 X161.174 Y57.234 E.84721
G1 X161.781 Y57.234 E.01061
G1 X127.471 Y91.545 E.84721
G1 X128.078 Y91.545 E.01061
G1 X162.389 Y57.234 E.84721
G1 X162.996 Y57.234 E.01061
G1 X128.686 Y91.545 E.84721
G1 X129.293 Y91.545 E.01061
G1 X163.604 Y57.234 E.84721
G1 X164.211 Y57.234 E.01061
G1 X129.901 Y91.545 E.84721
G1 X130.508 Y91.545 E.01061
G1 X164.819 Y57.234 E.84721
G1 X165.426 Y57.234 E.01061
G1 X131.116 Y91.545 E.84721
G1 X131.723 Y91.545 E.01061
G1 X166.034 Y57.234 E.84721
G1 X166.641 Y57.234 E.01061
G1 X132.331 Y91.545 E.84721
G1 X132.938 Y91.545 E.01061
G1 X167.249 Y57.234 E.84721
G1 X167.856 Y57.234 E.01061
G1 X133.546 Y91.545 E.84721
G1 X134.153 Y91.545 E.01061
G1 X168.464 Y57.234 E.84721
G1 X169.071 Y57.234 E.01061
G1 X134.761 Y91.545 E.84721
G1 X135.369 Y91.545 E.01061
G1 X169.679 Y57.234 E.84721
G1 X170.286 Y57.234 E.01061
G1 X135.976 Y91.545 E.84721
G1 X136.584 Y91.545 E.01061
G1 X170.894 Y57.234 E.84721
G1 X171.501 Y57.234 E.01061
G1 X137.191 Y91.545 E.84721
G1 X137.799 Y91.545 E.01061
G1 X172.109 Y57.234 E.84721
G1 X172.716 Y57.234 E.01061
G1 X138.406 Y91.545 E.84721
G1 X139.014 Y91.545 E.01061
G1 X173.324 Y57.234 E.84721
G1 X173.931 Y57.234 E.01061
G1 X139.621 Y91.545 E.84721
G1 X140.229 Y91.545 E.01061
G1 X174.539 Y57.234 E.84721
G1 X175.147 Y57.234 E.01061
G1 X140.836 Y91.545 E.84721
G1 X141.444 Y91.545 E.01061
G1 X175.754 Y57.234 E.84721
G1 X176.362 Y57.234 E.01061
G1 X142.051 Y91.545 E.84721
G1 X142.659 Y91.545 E.01061
G1 X176.969 Y57.234 E.84721
G1 X177.577 Y57.234 E.01061
G1 X143.266 Y91.545 E.84721
G1 X143.874 Y91.545 E.01061
G1 X178.184 Y57.234 E.84721
G1 X178.792 Y57.234 E.01061
G1 X144.481 Y91.545 E.84721
G1 X145.089 Y91.545 E.01061
G1 X179.399 Y57.234 E.84721
G1 X180.007 Y57.234 E.01061
G1 X145.696 Y91.545 E.84721
G1 X146.304 Y91.545 E.01061
G1 X180.614 Y57.234 E.84721
G1 X181.222 Y57.234 E.01061
G1 X146.911 Y91.545 E.84721
G1 X147.519 Y91.545 E.01061
G1 X181.829 Y57.234 E.84721
G1 X182.437 Y57.234 E.01061
G1 X148.126 Y91.545 E.84721
G1 X148.734 Y91.545 E.01061
G1 X183.044 Y57.234 E.84721
G1 X183.652 Y57.234 E.01061
G1 X149.341 Y91.545 E.84721
G1 X149.949 Y91.545 E.01061
G1 X184.259 Y57.234 E.84721
G1 X184.867 Y57.234 E.01061
G1 X150.556 Y91.545 E.84721
G1 X151.164 Y91.545 E.01061
G1 X185.474 Y57.234 E.84721
G1 X186.082 Y57.234 E.01061
G1 X151.771 Y91.545 E.84721
G1 X152.379 Y91.545 E.01061
G1 X186.689 Y57.234 E.84721
G1 X187.297 Y57.234 E.01061
G1 X152.987 Y91.545 E.84721
G1 X153.594 Y91.545 E.01061
G1 X187.904 Y57.234 E.84721
G1 X188.512 Y57.234 E.01061
G1 X154.202 Y91.545 E.84721
G1 X154.809 Y91.545 E.01061
G1 X189.119 Y57.234 E.84721
G1 X189.727 Y57.234 E.01061
G1 X155.417 Y91.545 E.84721
G1 X156.024 Y91.545 E.01061
G1 X190.334 Y57.234 E.84721
G1 X190.942 Y57.234 E.01061
G1 X156.632 Y91.545 E.84721
G1 X157.239 Y91.545 E.01061
G1 X191.55 Y57.234 E.84721
G1 X192.157 Y57.234 E.01061
G1 X157.847 Y91.545 E.84721
G1 X158.454 Y91.545 E.01061
G1 X192.765 Y57.234 E.84721
G1 X193.372 Y57.234 E.01061
G1 X159.062 Y91.545 E.84721
G1 X159.669 Y91.545 E.01061
G1 X193.98 Y57.234 E.84721
G1 X194.587 Y57.234 E.01061
G1 X160.277 Y91.545 E.84721
G1 X160.884 Y91.545 E.01061
G1 X195.195 Y57.234 E.84721
G1 X195.802 Y57.234 E.01061
M73 P37 R48
G1 X161.492 Y91.545 E.84721
G1 X162.099 Y91.545 E.01061
G1 X196.41 Y57.234 E.84721
G1 X197.017 Y57.234 E.01061
G1 X162.707 Y91.545 E.84721
G1 X163.314 Y91.545 E.01061
G1 X197.625 Y57.234 E.84721
G1 X198.232 Y57.234 E.01061
G1 X163.922 Y91.545 E.84721
G1 X164.529 Y91.545 E.01061
G1 X198.84 Y57.234 E.84721
G1 X199.447 Y57.234 E.01061
G1 X165.137 Y91.545 E.84721
G1 X165.744 Y91.545 E.01061
G1 X200.055 Y57.234 E.84721
G1 X200.662 Y57.234 E.01061
M73 P37 R47
G1 X166.352 Y91.545 E.84721
G1 X166.959 Y91.545 E.01061
G1 X201.27 Y57.234 E.84721
G1 X201.877 Y57.234 E.01061
G1 X167.567 Y91.545 E.84721
G1 X168.174 Y91.545 E.01061
G1 X202.485 Y57.234 E.84721
G1 X203.092 Y57.234 E.01061
G1 X168.782 Y91.545 E.84721
G1 X169.39 Y91.545 E.01061
G1 X203.7 Y57.234 E.84721
G1 X204.307 Y57.234 E.01061
G1 X169.997 Y91.545 E.84721
G1 X170.605 Y91.545 E.01061
G1 X204.915 Y57.234 E.84721
G1 X205.522 Y57.234 E.01061
G1 X171.212 Y91.545 E.84721
G1 X171.82 Y91.545 E.01061
G1 X206.13 Y57.234 E.84721
G1 X206.737 Y57.234 E.01061
G1 X172.427 Y91.545 E.84721
G1 X173.035 Y91.545 E.01061
G1 X207.345 Y57.234 E.84721
G1 X207.952 Y57.234 E.01061
G1 X173.642 Y91.545 E.84721
G1 X174.25 Y91.545 E.01061
G1 X208.146 Y57.648 E.83699
G1 X208.146 Y58.256 E.01061
G1 X174.857 Y91.545 E.82199
G1 X175.465 Y91.545 E.01061
G1 X208.146 Y58.863 E.80698
G1 X208.146 Y59.471 E.01061
G1 X176.072 Y91.545 E.79198
G1 X176.68 Y91.545 E.01061
G1 X208.146 Y60.079 E.77698
G1 X208.146 Y60.686 E.01061
G1 X177.287 Y91.545 E.76198
G1 X177.895 Y91.545 E.01061
G1 X208.146 Y61.294 E.74698
G1 X208.146 Y61.901 E.01061
G1 X178.502 Y91.545 E.73198
G1 X179.11 Y91.545 E.01061
G1 X208.146 Y62.509 E.71698
G1 X208.146 Y63.116 E.01061
G1 X179.717 Y91.545 E.70198
G1 X180.325 Y91.545 E.01061
G1 X208.146 Y63.724 E.68698
G1 X208.146 Y64.331 E.01061
G1 X180.932 Y91.545 E.67197
G1 X181.54 Y91.545 E.01061
G1 X208.146 Y64.939 E.65697
G1 X208.146 Y65.546 E.01061
G1 X182.147 Y91.545 E.64197
G1 X182.755 Y91.545 E.01061
G1 X208.146 Y66.154 E.62697
G1 X208.146 Y66.761 E.01061
G1 X183.362 Y91.545 E.61197
G1 X183.97 Y91.545 E.01061
G1 X208.146 Y67.369 E.59697
G1 X208.146 Y67.976 E.01061
G1 X184.577 Y91.545 E.58197
G1 X185.185 Y91.545 E.01061
G1 X208.146 Y68.584 E.56697
G1 X208.146 Y69.191 E.01061
G1 X185.793 Y91.545 E.55196
G1 X186.4 Y91.545 E.01061
G1 X208.146 Y69.799 E.53696
G1 X208.146 Y70.406 E.01061
G1 X187.008 Y91.545 E.52196
G1 X187.615 Y91.545 E.01061
G1 X208.146 Y71.014 E.50696
G1 X208.146 Y71.621 E.01061
G1 X188.223 Y91.545 E.49196
G1 X188.83 Y91.545 E.01061
G1 X208.146 Y72.229 E.47696
G1 X208.146 Y72.836 E.01061
G1 X189.438 Y91.545 E.46196
G1 X190.045 Y91.545 E.01061
G1 X208.146 Y73.444 E.44696
G1 X208.146 Y74.051 E.01061
G1 X190.653 Y91.545 E.43195
G1 X191.26 Y91.545 E.01061
G1 X208.146 Y74.659 E.41695
G1 X208.146 Y75.266 E.01061
G1 X191.868 Y91.545 E.40195
G1 X192.475 Y91.545 E.01061
G1 X208.146 Y75.874 E.38695
G1 X208.146 Y76.481 E.01061
G1 X193.083 Y91.545 E.37195
G1 X193.69 Y91.545 E.01061
G1 X208.146 Y77.089 E.35695
G1 X208.146 Y77.697 E.01061
G1 X194.298 Y91.545 E.34195
G1 X194.905 Y91.545 E.01061
G1 X208.146 Y78.304 E.32695
G1 X208.146 Y78.912 E.01061
G1 X195.513 Y91.545 E.31195
G1 X196.12 Y91.545 E.01061
G1 X208.146 Y79.519 E.29694
G1 X208.146 Y80.127 E.01061
G1 X196.728 Y91.545 E.28194
G1 X197.335 Y91.545 E.01061
G1 X208.146 Y80.734 E.26694
G1 X208.146 Y81.342 E.01061
G1 X197.943 Y91.545 E.25194
G1 X198.55 Y91.545 E.01061
G1 X208.146 Y81.949 E.23694
G1 X208.146 Y82.557 E.01061
G1 X199.158 Y91.545 E.22194
G1 X199.765 Y91.545 E.01061
G1 X208.146 Y83.164 E.20694
G1 X208.146 Y83.772 E.01061
G1 X200.373 Y91.545 E.19194
G1 X200.98 Y91.545 E.01061
G1 X208.146 Y84.379 E.17693
G1 X208.146 Y84.987 E.01061
G1 X201.588 Y91.545 E.16193
G1 X202.195 Y91.545 E.01061
G1 X208.146 Y85.594 E.14693
G1 X208.146 Y86.202 E.01061
G1 X202.803 Y91.545 E.13193
G1 X203.411 Y91.545 E.01061
G1 X208.146 Y86.809 E.11693
G1 X208.146 Y87.417 E.01061
G1 X204.018 Y91.545 E.10193
G1 X204.626 Y91.545 E.01061
G1 X208.146 Y88.024 E.08693
G1 X208.146 Y88.632 E.01061
G1 X205.233 Y91.545 E.07193
G1 X205.841 Y91.545 E.01061
G1 X208.146 Y89.239 E.05693
G1 X208.146 Y89.847 E.01061
G1 X206.448 Y91.545 E.04192
G1 X207.056 Y91.545 E.01061
G1 X208.146 Y90.454 E.02692
G1 X208.146 Y91.062 E.01061
G1 X207.47 Y91.738 E.01668
; CHANGE_LAYER
; Z_HEIGHT: 0.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F7200
G1 X208.146 Y91.062 E-.3631
G1 X208.146 Y90.454 E-.23085
G1 X207.837 Y90.763 E-.16605
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 7/58
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1 I.389 J-1.153 P1  F30000
G1 X107.471 Y56.87 Z1
G1 Z.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
M73 P38 R47
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 7 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer7 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.37 Y60.152 Z1.1 F30000
G1 X125.727 Y68.425 Z1.1
G1 Z.7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X122.752 Y65.45 E.07347
G2 X122.209 Y65.514 I.46 J6.2 E.00955
G1 X124.629 Y67.934 E.05977
G2 X123.966 Y67.878 I-.628 J3.469 E.01165
G1 X121.69 Y65.603 E.05618
G2 X121.196 Y65.716 I.933 J5.216 E.00886
G1 X123.371 Y67.891 E.05371
G1 X123.257 Y67.896 E.00199
G2 X122.83 Y67.958 I.4 J4.317 E.00753
G1 X120.725 Y65.852 E.05198
G2 X120.279 Y66.013 I6.234 J18 E.00829
G1 X122.335 Y68.07 E.05079
G2 X121.881 Y68.223 I.513 J2.275 E.00839
G1 X119.854 Y66.196 E.05006
G2 X119.449 Y66.399 I1.652 J3.79 E.0079
G1 X121.462 Y68.412 E.0497
G2 X121.075 Y68.631 I.851 J1.95 E.00779
G1 X119.065 Y66.622 E.04962
G2 X118.7 Y66.865 I2.007 J3.414 E.00765
G1 X120.715 Y68.88 E.04976
G1 X120.383 Y69.154 E.00753
G1 X118.354 Y67.126 E.05008
G2 X118.026 Y67.405 I2.383 J3.128 E.00753
G1 X120.08 Y69.459 E.05071
G2 X119.801 Y69.787 I1.467 J1.53 E.00754
G1 X117.716 Y67.702 E.05148
G2 X117.423 Y68.017 I2.754 J2.861 E.00751
G1 X119.546 Y70.14 E.05242
G2 X119.316 Y70.517 I2.265 J1.642 E.00772
G1 X117.147 Y68.349 E.05354
G2 X116.89 Y68.699 I25.043 J18.663 E.00759
G1 X119.12 Y70.928 E.05505
G2 X118.951 Y71.366 I2.215 J1.107 E.00821
G1 X116.653 Y69.068 E.05674
G2 X116.434 Y69.457 I3.502 J2.225 E.00779
G1 X118.806 Y71.829 E.05857
G2 X118.687 Y72.317 I3.132 J1.025 E.00878
G1 X116.235 Y69.865 E.06055
G2 X116.055 Y70.293 I4.073 J1.961 E.00811
G1 X118.599 Y72.837 E.0628
G1 X118.585 Y72.916 E.00141
G2 X118.54 Y73.385 I6.311 J.846 E.00823
G1 X115.896 Y70.741 E.06528
G2 X115.757 Y71.21 I4.82 J1.682 E.00854
G1 X118.506 Y73.959 E.06788
G2 X118.497 Y74.557 I5.273 J.376 E.01046
G1 X115.639 Y71.699 E.07057
G2 X115.544 Y72.212 I5.174 J1.222 E.0091
G1 X118.516 Y75.183 E.07337
G1 X118.577 Y75.852 E.01172
G1 X115.468 Y72.743 E.07676
G2 X115.418 Y73.3 I29.228 J2.947 E.00976
G1 X118.693 Y76.575 E.08088
G2 X118.92 Y77.409 I11.848 J-2.774 E.0151
G1 X115.391 Y73.88 E.08714
G2 X115.388 Y74.485 I8.285 J.344 E.01055
G1 X124.271 Y83.368 E.21936
G3 X123.672 Y83.377 I-.587 J-19.861 E.01046
G1 X115.406 Y75.111 E.20411
G2 X115.454 Y75.766 I7.471 J-.214 E.01147
G1 X123.043 Y83.355 E.1874
G3 X122.378 Y83.297 I.312 J-7.368 E.01168
G1 X115.54 Y76.459 E.16884
G2 X115.677 Y77.203 I7.301 J-.962 E.01323
G1 X121.658 Y83.185 E.14769
G3 X120.858 Y82.992 I1.427 J-7.686 E.01437
G1 X115.907 Y78.041 E.12226
G2 X116.333 Y79.074 I6.521 J-2.083 E.01954
G1 X119.889 Y82.631 E.08782
G3 X117.805 Y81.154 I4.095 J-7.988 E.04475
G1 X116.616 Y79.965 E.02937
M204 S10000
G1 X116.219 Y79.37 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X107.821 Y70.971 E.19347
G1 X107.821 Y70.406 E.00921
G1 X115.48 Y78.065 E.17644
G3 X115.293 Y77.388 I5.662 J-1.927 E.01144
G1 X115.273 Y77.294 E.00158
G1 X107.821 Y69.841 E.17168
G1 X107.821 Y69.275 E.00921
M73 P38 R46
G1 X115.142 Y76.597 E.16867
G1 X115.057 Y75.946 E.01069
G1 X107.821 Y68.71 E.1667
G1 X107.821 Y68.144 E.00921
G1 X115.005 Y75.329 E.16551
G1 X114.979 Y74.737 E.00965
G1 X107.821 Y67.579 E.1649
G1 X107.821 Y67.014 E.00921
G1 X114.972 Y74.165 E.16474
G1 X114.986 Y73.614 E.00898
G1 X107.821 Y66.448 E.16507
G1 X107.821 Y65.883 E.00921
G1 X115.021 Y73.083 E.16586
G1 X115.074 Y72.571 E.00838
G1 X107.821 Y65.318 E.16709
G1 X107.821 Y64.752 E.00921
G1 X115.148 Y72.079 E.16879
G1 X115.237 Y71.603 E.00789
G1 X107.821 Y64.187 E.17085
G1 X107.821 Y63.621 E.00921
G1 X115.346 Y71.147 E.17335
G1 X115.472 Y70.708 E.00744
G1 X107.821 Y63.056 E.17626
G1 X107.821 Y62.491 E.00921
G1 X115.616 Y70.286 E.17957
G1 X115.776 Y69.881 E.00709
G1 X107.821 Y61.925 E.18327
G1 X107.821 Y61.36 E.00921
G1 X115.953 Y69.492 E.18734
G1 X116.146 Y69.12 E.00683
G1 X107.821 Y60.794 E.19179
G1 X107.821 Y60.229 E.00921
G1 X116.355 Y68.764 E.1966
G3 X116.554 Y68.457 I5.342 J3.254 E.00596
G1 X116.58 Y68.423 E.00069
G1 X107.821 Y59.664 E.20177
G1 X107.821 Y59.098 E.00921
G1 X116.819 Y68.097 E.20729
G1 X117.074 Y67.786 E.00654
G1 X107.821 Y58.533 E.21315
G1 X107.821 Y57.968 E.00921
G1 X117.344 Y67.491 E.21938
G3 X117.628 Y67.21 I2.952 J2.7 E.00651
G1 X107.821 Y57.402 E.22592
G1 X107.821 Y57.219 E.00298
G1 X108.203 Y57.219 E.00623
G1 X117.926 Y66.943 E.22398
G1 X118.239 Y66.69 E.00655
G1 X108.768 Y57.219 E.21817
G1 X109.334 Y57.219 E.00921
G1 X118.567 Y66.453 E.2127
G1 X118.911 Y66.231 E.00666
G1 X109.899 Y57.219 E.20759
G1 X110.465 Y57.219 E.00921
G1 X119.271 Y66.025 E.20286
G1 X119.647 Y65.836 E.00686
G1 X111.03 Y57.219 E.1985
G1 X111.595 Y57.219 E.00921
G1 X120.04 Y65.664 E.19454
G1 X120.452 Y65.51 E.00715
G1 X112.161 Y57.219 E.19099
G1 X112.726 Y57.219 E.00921
G1 X120.881 Y65.374 E.18786
G1 X121.33 Y65.258 E.00755
G1 X113.292 Y57.219 E.18518
G1 X113.857 Y57.219 E.00921
G1 X121.799 Y65.161 E.18294
G1 X122.287 Y65.084 E.00806
G1 X114.422 Y57.219 E.18118
G1 X114.988 Y57.219 E.00921
G1 X122.798 Y65.029 E.17991
G1 X123.33 Y64.996 E.00869
G1 X115.553 Y57.219 E.17915
G1 X116.119 Y57.219 E.00921
G1 X123.887 Y64.988 E.17896
G1 X124.472 Y65.008 E.00953
G1 X116.684 Y57.219 E.17941
G1 X117.249 Y57.219 E.00921
G1 X125.086 Y65.056 E.18052
G1 X125.742 Y65.146 E.01079
G1 X117.815 Y57.219 E.18261
G1 X118.38 Y57.219 E.00921
G1 X126.465 Y65.304 E.18624
G1 X127.01 Y65.461 E.00925
G1 X127.286 Y65.56 E.00478
G1 X118.945 Y57.219 E.19214
G1 X119.511 Y57.219 E.00921
G1 X128.837 Y66.546 E.21484
M204 S10000
G1 X131.024 Y68.863 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G2 X128.008 Y66.326 I-8.965 J7.599 E.06914
G1 X127.761 Y66.207 E.0048
G1 X131.278 Y69.724 E.08685
G3 X131.681 Y70.734 I-15.641 J6.822 E.01899
G1 X126.766 Y65.82 E.12135
G2 X125.947 Y65.608 I-2.644 J8.549 E.01477
G1 X131.914 Y71.574 E.14732
G3 X132.059 Y72.327 I-8.51 J2.034 E.01339
G1 X125.217 Y65.485 E.16894
G2 X124.55 Y65.426 I-1.573 J13.936 E.01169
G1 X132.143 Y73.019 E.18749
G3 X132.19 Y73.673 I-8.601 J.94 E.01145
G1 X123.919 Y65.402 E.20422
G1 X123.82 Y65.4 E.00173
G2 X123.32 Y65.411 I-.12 J6.27 E.00873
G1 X132.207 Y74.297 E.21942
G3 X132.199 Y74.896 I-41.667 J-.259 E.01047
G1 X128.619 Y71.317 E.08839
G3 X128.861 Y72.166 I-4.651 J1.783 E.01544
G1 X132.166 Y75.471 E.08161
G3 X132.111 Y76.023 I-6.942 J-.411 E.0097
G1 X128.995 Y72.935 E.07659
G3 X129.055 Y73.575 I-8.641 J1.126 E.01122
G1 X132.034 Y76.554 E.07357
G3 X131.936 Y77.064 I-5.836 J-.858 E.00906
G1 X129.079 Y74.207 E.07055
G1 X129.086 Y74.445 E.00416
G3 X129.076 Y74.811 I-6.48 J.006 E.0064
G1 X131.817 Y77.552 E.06769
G3 X131.678 Y78.02 I-4.966 J-1.227 E.00853
G1 X129.049 Y75.391 E.06491
G3 X128.998 Y75.947 I-7.718 J-.428 E.00976
G1 X131.518 Y78.467 E.06223
G3 X131.338 Y78.895 I-4.255 J-1.537 E.0081
G1 X128.913 Y76.47 E.05989
G3 X128.802 Y76.967 I-3.278 J-.468 E.0089
G1 X131.139 Y79.303 E.0577
G3 X130.92 Y79.692 I-3.704 J-1.827 E.00779
G1 X128.667 Y77.438 E.05565
G3 X128.505 Y77.884 I-2.506 J-.653 E.00829
G1 X130.683 Y80.061 E.05376
G3 X130.425 Y80.412 I-3.251 J-2.116 E.00759
G1 X128.313 Y78.299 E.05216
G1 X128.291 Y78.347 E.00091
G3 X128.089 Y78.683 I-3.077 J-1.623 E.00685
G1 X130.15 Y80.744 E.0509
G3 X129.857 Y81.058 I-3.062 J-2.56 E.00751
G1 X127.838 Y79.039 E.04986
G3 X127.561 Y79.369 I-1.678 J-1.13 E.00754
G1 X129.547 Y81.356 E.04905
G3 X129.22 Y81.636 I-2.75 J-2.882 E.00753
G1 X127.257 Y79.673 E.04847
G1 X126.922 Y79.945 E.00754
G1 X128.875 Y81.898 E.04823
G3 X128.511 Y82.142 I-2.403 J-3.191 E.00765
G1 X126.557 Y80.188 E.04824
G3 X126.163 Y80.401 I-1.192 J-1.733 E.00784
G1 X128.128 Y82.366 E.04853
G3 X127.726 Y82.571 I-2.085 J-3.598 E.00789
G1 X125.736 Y80.582 E.04913
G3 X125.273 Y80.726 I-.937 J-2.193 E.00848
G1 X127.303 Y82.756 E.05012
G3 X126.858 Y82.919 I-1.772 J-4.144 E.00827
G1 X124.77 Y80.83 E.05157
G3 X124.223 Y80.89 I-.611 J-3.044 E.00963
G1 X126.39 Y83.057 E.05351
G3 X125.897 Y83.172 I-1.435 J-5.038 E.00883
G1 X123.625 Y80.9 E.0561
G3 X122.964 Y80.846 I-.033 J-3.656 E.01161
G1 X125.38 Y83.263 E.05968
G3 X124.839 Y83.328 I-1.008 J-6.048 E.00953
G1 X121.887 Y80.377 E.07288
M204 S10000
G1 X119.532 Y78.256 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43076
G1 F6000
M204 S1000
G1 X120.649 Y79.373 E.02634
G1 X120.984 Y79.645 E.0072
G1 X121.388 Y79.905 E.008
G1 X121.816 Y80.116 E.00797
G1 X122.059 Y80.204 E.00431
G1 X119.407 Y77.552 E.06255
G1 X119.247 Y77.09 E.00816
G1 X119.155 Y76.721 E.00634
G1 X122.846 Y80.412 E.08705
G1 X123.268 Y80.47 E.00711
G1 X123.493 Y80.48 E.00376
G1 X119.018 Y76.005 E.10554
G1 X118.947 Y75.355 E.01091
G1 X124.074 Y80.483 E.12092
G1 X124.348 Y80.471 E.00456
G1 X124.606 Y80.435 E.00434
G1 X118.916 Y74.746 E.13418
G1 X118.914 Y74.164 E.0097
G1 X125.093 Y80.344 E.14574
G1 X125.34 Y80.284 E.00424
G1 X125.54 Y80.212 E.00355
G1 X118.934 Y73.606 E.1558
G1 X118.984 Y73.078 E.00885
G1 X125.951 Y80.045 E.16431
G1 X126.329 Y79.843 E.00714
G1 X119.062 Y72.577 E.17138
G1 X119.164 Y72.099 E.00814
G1 X126.676 Y79.612 E.17717
G1 X126.995 Y79.353 E.00684
G1 X119.29 Y71.646 E.18173
G1 X119.442 Y71.22 E.00755
G1 X127.283 Y79.061 E.18493
G1 X127.544 Y78.743 E.00686
G1 X119.627 Y70.826 E.18673
G1 X119.836 Y70.456 E.00708
G1 X127.778 Y78.398 E.1873
G1 X127.984 Y78.026 E.0071
G1 X120.071 Y70.112 E.18663
G1 X120.331 Y69.793 E.00686
G1 X128.164 Y77.627 E.18474
G1 X128.313 Y77.196 E.00759
G1 X120.618 Y69.502 E.18146
G1 X120.932 Y69.237 E.00685
G1 X128.433 Y76.738 E.1769
G1 X128.529 Y76.255 E.00821
G1 X121.271 Y68.997 E.17116
G1 X121.639 Y68.786 E.00707
G1 X128.601 Y75.748 E.16421
G1 X128.649 Y75.218 E.00889
G1 X122.038 Y68.606 E.15593
G1 X122.472 Y68.462 E.00764
G1 X128.667 Y74.656 E.14609
G1 X128.662 Y74.072 E.00974
G1 X122.948 Y68.358 E.13476
G1 X123.469 Y68.301 E.00874
G1 X128.629 Y73.461 E.1217
G1 X128.555 Y72.808 E.01095
G1 X124.043 Y68.296 E.10643
G1 X124.33 Y68.309 E.0048
G1 X124.686 Y68.36 E.006
G1 X128.416 Y72.09 E.08795
G1 X128.328 Y71.739 E.00603
G1 X128.16 Y71.255 E.00854
G1 X125.468 Y68.564 E.06347
G1 X125.748 Y68.669 E.00498
G1 X126.171 Y68.883 E.00791
G1 X126.573 Y69.147 E.00801
G1 X126.905 Y69.422 E.00719
G1 X128.026 Y70.542 E.02643
M204 S10000
G1 X138.65 Y65.933 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X138.424 Y65.707 E.00558
G1 X137.815 Y65.707 E.01063
G1 X138.457 Y66.35 E.01586
G1 X138.457 Y66.959 E.01063
G1 X137.206 Y65.707 E.0309
G1 X136.597 Y65.707 E.01063
G1 X138.457 Y67.568 E.04593
G1 X138.457 Y68.177 E.01063
G1 X135.988 Y65.707 E.06097
G1 X135.716 Y65.707 E.00474
G1 X135.716 Y66.045 E.00589
G1 X138.457 Y68.786 E.06768
G1 X138.457 Y69.395 E.01063
G1 X135.716 Y66.654 E.06768
G1 X135.716 Y67.263 E.01063
G1 X138.457 Y70.004 E.06768
G1 X138.457 Y70.613 E.01063
G1 X135.716 Y67.872 E.06768
G1 X135.716 Y68.481 E.01063
G1 X138.457 Y71.222 E.06768
G1 X138.457 Y71.831 E.01063
G1 X135.716 Y69.09 E.06768
G1 X135.716 Y69.699 E.01063
G1 X138.457 Y72.44 E.06768
G1 X138.457 Y73.049 E.01063
G1 X135.716 Y70.308 E.06768
G1 X135.716 Y70.917 E.01063
G1 X138.457 Y73.658 E.06768
G1 X138.457 Y74.267 E.01063
G1 X135.716 Y71.526 E.06768
G1 X135.716 Y72.135 E.01063
G1 X138.457 Y74.876 E.06768
G1 X138.457 Y75.485 E.01063
G1 X135.716 Y72.744 E.06768
G1 X135.716 Y73.353 E.01063
G1 X138.457 Y76.094 E.06768
G1 X138.457 Y76.703 E.01063
G1 X135.716 Y73.962 E.06768
G1 X135.716 Y74.571 E.01063
G1 X140.832 Y79.686 E.12631
M73 P39 R46
G1 X141.063 Y79.309 E.00773
G1 X138.937 Y77.183 E.0525
G1 X139.088 Y77.226 E.00274
G1 X139.28 Y76.916 E.00635
G1 X141.295 Y78.931 E.04976
G1 X141.526 Y78.553 E.00773
G1 X139.512 Y76.54 E.04972
G1 X139.745 Y76.163 E.00773
G1 X141.757 Y78.176 E.04969
G1 X141.989 Y77.798 E.00773
G1 X139.978 Y75.787 E.04966
G1 X140.21 Y75.411 E.00773
G1 X142.22 Y77.421 E.04963
G1 X142.452 Y77.043 E.00773
G1 X140.443 Y75.034 E.0496
G1 X140.676 Y74.658 E.00773
G1 X142.683 Y76.665 E.04957
G1 X142.915 Y76.288 E.00773
G1 X140.908 Y74.282 E.04954
G1 X141.141 Y73.905 E.00773
G1 X143.146 Y75.91 E.04951
G1 X143.377 Y75.533 E.00773
G1 X141.374 Y73.529 E.04948
G1 X141.606 Y73.153 E.00773
G1 X143.609 Y75.155 E.04945
G1 X143.84 Y74.777 E.00773
G1 X141.839 Y72.776 E.04942
G1 X142.072 Y72.4 E.00773
G1 X144.072 Y74.4 E.04939
G1 X144.303 Y74.022 E.00773
G1 X142.304 Y72.023 E.04936
G1 X142.537 Y71.647 E.00773
G1 X144.535 Y73.645 E.04933
G1 X144.766 Y73.267 E.00773
G1 X142.77 Y71.271 E.04929
G1 X143.002 Y70.894 E.00773
G1 X144.997 Y72.889 E.04926
G1 X145.229 Y72.512 E.00773
G1 X143.235 Y70.518 E.04923
G1 X143.468 Y70.142 E.00773
G1 X145.46 Y72.134 E.0492
G1 X145.692 Y71.757 E.00773
G1 X143.7 Y69.765 E.04917
G1 X143.933 Y69.389 E.00773
G1 X146.063 Y71.519 E.0526
M204 S10000
G1 X146.385 Y72.221 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X146.08 Y71.915 E.00704
G1 X145.865 Y72.265 E.0067
G1 X146.206 Y72.607 E.00786
G1 X146.206 Y73.172 E.00921
G1 X145.65 Y72.616 E.01281
G1 X145.435 Y72.967 E.0067
G1 X146.206 Y73.738 E.01776
G1 X146.206 Y74.303 E.00921
G1 X145.22 Y73.317 E.02271
G1 X145.005 Y73.668 E.0067
G1 X146.206 Y74.868 E.02766
G1 X146.206 Y75.434 E.00921
G1 X144.791 Y74.018 E.03261
G1 X144.576 Y74.369 E.0067
G1 X146.206 Y75.999 E.03756
G1 X146.206 Y76.564 E.00921
G1 X144.361 Y74.719 E.04251
G1 X144.146 Y75.07 E.0067
G1 X146.206 Y77.13 E.04745
G1 X146.206 Y77.695 E.00921
G1 X143.931 Y75.42 E.0524
G1 X143.716 Y75.771 E.0067
G1 X146.206 Y78.261 E.05735
G1 X146.206 Y78.826 E.00921
G1 X143.502 Y76.121 E.0623
G1 X143.287 Y76.472 E.0067
G1 X146.206 Y79.391 E.06725
G1 X146.206 Y79.957 E.00921
G1 X143.072 Y76.823 E.0722
G1 X142.857 Y77.173 E.0067
G1 X146.206 Y80.522 E.07715
G1 X146.206 Y81.088 E.00921
G1 X142.642 Y77.524 E.0821
G1 X142.427 Y77.874 E.0067
G1 X146.206 Y81.653 E.08705
G1 X146.206 Y82.218 E.00921
G1 X142.212 Y78.225 E.092
G1 X141.998 Y78.575 E.0067
G1 X146.206 Y82.784 E.09695
G1 X146.206 Y83.271 E.00793
G1 X146.421 Y83.485 E.00495
G1 X146.908 Y83.485 E.00793
G1 X154.982 Y91.56 E.18601
G1 X155.548 Y91.56 E.00921
G1 X147.473 Y83.485 E.18601
G1 X148.038 Y83.485 E.00921
G1 X156.113 Y91.56 E.186
G1 X156.678 Y91.56 E.00921
G1 X148.604 Y83.485 E.186
G1 X149.169 Y83.485 E.00921
G1 X157.244 Y91.56 E.18601
G1 X157.809 Y91.56 E.00921
G1 X149.647 Y83.398 E.18802
G1 X149.774 Y83.271 E.00293
G1 X149.774 Y82.959 E.00507
G1 X158.375 Y91.56 E.19812
G1 X158.94 Y91.56 E.00921
G1 X149.774 Y82.394 E.21114
G1 X149.774 Y81.829 E.00921
G1 X159.505 Y91.56 E.22417
G1 X160.071 Y91.56 E.00921
G1 X149.774 Y81.263 E.23719
G1 X149.774 Y80.698 E.00921
G1 X160.636 Y91.56 E.25022
G1 X161.201 Y91.56 E.00921
G1 X149.774 Y80.133 E.26324
G1 X149.774 Y79.567 E.00921
G1 X161.767 Y91.56 E.27626
G1 X162.332 Y91.56 E.00921
G1 X149.774 Y79.002 E.28929
G1 X149.774 Y78.436 E.00921
G1 X162.898 Y91.56 E.30231
G1 X163.463 Y91.56 E.00921
G1 X149.774 Y77.871 E.31534
G1 X149.774 Y77.306 E.00921
G1 X164.028 Y91.56 E.32836
G1 X164.594 Y91.56 E.00921
G1 X149.774 Y76.74 E.34139
G1 X149.774 Y76.175 E.00921
G1 X165.159 Y91.56 E.35441
G1 X165.725 Y91.56 E.00921
G1 X149.774 Y75.609 E.36743
G1 X149.774 Y75.044 E.00921
G1 X166.29 Y91.56 E.38046
G1 X166.855 Y91.56 E.00921
G1 X149.774 Y74.479 E.39348
G1 X149.774 Y73.913 E.00921
G1 X167.421 Y91.56 E.40651
G1 X167.986 Y91.56 E.00921
G1 X149.774 Y73.348 E.41953
G1 X149.774 Y72.782 E.00921
G1 X168.551 Y91.56 E.43256
G1 X169.117 Y91.56 E.00921
G1 X149.774 Y72.217 E.44558
G1 X149.774 Y71.652 E.00921
G1 X169.682 Y91.56 E.4586
G1 X170.248 Y91.56 E.00921
G1 X149.774 Y71.086 E.47163
G1 X149.774 Y70.521 E.00921
G1 X170.813 Y91.56 E.48465
G1 X171.378 Y91.56 E.00921
G1 X149.774 Y69.956 E.49768
G1 X149.774 Y69.39 E.00921
G1 X171.944 Y91.56 E.5107
G1 X172.509 Y91.56 E.00921
G1 X149.774 Y68.825 E.52373
G1 X149.774 Y68.259 E.00921
G1 X173.075 Y91.56 E.53675
G1 X173.64 Y91.56 E.00921
G1 X165.565 Y83.485 E.18601
G1 X166.131 Y83.485 E.00921
G1 X174.205 Y91.56 E.18601
G1 X174.771 Y91.56 E.00921
G1 X166.696 Y83.485 E.186
G1 X167.262 Y83.485 E.00921
G1 X175.336 Y91.56 E.18601
G1 X175.902 Y91.56 E.00921
G1 X167.827 Y83.485 E.18601
G1 X168.392 Y83.485 E.00921
G1 X176.467 Y91.56 E.18601
G1 X177.032 Y91.56 E.00921
G1 X168.748 Y83.276 E.19084
G1 X168.91 Y82.872 E.00708
G1 X177.598 Y91.56 E.20014
G1 X178.163 Y91.56 E.00921
G1 X169.071 Y82.468 E.20944
G1 X169.233 Y82.064 E.00708
G1 X178.728 Y91.56 E.21874
G1 X179.294 Y91.56 E.00921
G1 X169.395 Y81.661 E.22804
G1 X169.556 Y81.257 E.00708
G1 X179.859 Y91.56 E.23734
G1 X180.425 Y91.56 E.00921
G1 X169.718 Y80.853 E.24664
G1 X169.88 Y80.449 E.00708
G1 X180.99 Y91.56 E.25594
G1 X181.555 Y91.56 E.00921
G1 X170.041 Y80.046 E.26524
G1 X170.203 Y79.642 E.00708
G1 X182.121 Y91.56 E.27454
G1 X182.686 Y91.56 E.00921
G1 X170.365 Y79.238 E.28384
G1 X170.526 Y78.835 E.00708
G1 X183.252 Y91.56 E.29314
G1 X183.817 Y91.56 E.00921
G1 X170.688 Y78.431 E.30244
G1 X170.85 Y78.027 E.00708
G1 X184.382 Y91.56 E.31174
G1 X184.948 Y91.56 E.00921
G1 X171.011 Y77.623 E.32104
G1 X171.173 Y77.22 E.00708
G1 X185.692 Y91.739 E.33447
M204 S10000
G1 X185.824 Y83.265 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X185.051 Y82.491 E.0191
G1 X185.051 Y81.884 E.0106
G1 X186.238 Y83.072 E.02932
G1 X186.845 Y83.072 E.0106
G1 X185.051 Y81.277 E.04431
G1 X185.051 Y80.67 E.0106
G1 X187.452 Y83.072 E.0593
G1 X188.059 Y83.072 E.0106
G1 X185.051 Y80.063 E.07428
G1 X185.051 Y79.456 E.0106
G1 X188.666 Y83.072 E.08927
G1 X189.273 Y83.072 E.0106
G1 X185.051 Y78.849 E.10426
G1 X185.051 Y78.243 E.0106
G1 X190.073 Y83.265 E.12401
M204 S10000
G1 X195.6 Y77.873 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G3 X195.583 Y78.536 I-3.369 J.246 E.01078
G1 X195.419 Y79.077 E.00917
G1 X195.145 Y79.521 E.00848
G1 X194.726 Y79.864 E.00879
G1 X194.238 Y80.093 E.00874
G1 X193.704 Y80.202 E.00885
G3 X188.484 Y80.249 I-3.671 J-118.444 E.08478
G1 X188.463 Y80.237 E.00039
G1 X188.463 Y75.893 E.07053
G1 X188.475 Y75.873 E.00039
G3 X192.276 Y75.888 I1.158 J182.966 E.06171
G3 X194.117 Y76.053 I-.03 J10.699 E.03006
G1 X194.591 Y76.217 E.00814
G1 X195.075 Y76.582 E.00984
G1 X195.338 Y76.95 E.00735
G1 X195.527 Y77.4 E.00792
G1 X195.59 Y77.814 E.0068
; Slow Down End
M204 S10000
G1 X195.202 Y77.896 F30000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X195.206 Y78.223 E.00532
G1 X195.115 Y78.78 E.00917
G1 X194.921 Y79.148 E.00675
G1 X194.645 Y79.444 E.00656
G1 X194.253 Y79.657 E.00725
G1 X193.656 Y79.805 E.00999
G3 X188.862 Y79.85 I-3.45 J-112.085 E.07785
G1 X188.862 Y76.271 E.05812
G3 X193.146 Y76.325 I1.207 J73.802 E.06958
G3 X194.18 Y76.475 I-.334 J5.973 E.01699
G1 X194.636 Y76.723 E.00842
G1 X194.934 Y77.043 E.0071
G1 X195.103 Y77.398 E.00639
G1 X195.19 Y77.837 E.00726
; Slow Down End
M204 S10000
G1 X194.804 Y77.919 F30000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X194.792 Y78.413 E.00804
G1 X194.652 Y78.839 E.00728
G1 X194.4 Y79.127 E.00621
G1 X194.103 Y79.288 E.00549
G1 X193.607 Y79.409 E.00828
G3 X189.26 Y79.452 I-3.224 J-105.424 E.07059
G1 X189.26 Y76.67 E.04517
G3 X193.154 Y76.727 I.84 J75.522 E.06325
G1 X193.972 Y76.837 E.0134
G1 X194.28 Y76.967 E.00543
G1 X194.539 Y77.187 E.00552
G1 X194.718 Y77.504 E.00591
G1 X194.792 Y77.86 E.0059
; Slow Down End
M204 S10000
G1 X194.406 Y77.941 F30000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X194.384 Y78.41 E.00762
G1 X194.272 Y78.686 E.00483
G1 X194.039 Y78.884 E.00497
G1 X193.558 Y79.012 E.00808
G3 X189.659 Y79.053 I-3.005 J-98.921 E.06333
G1 X189.659 Y77.068 E.03223
G3 X193.115 Y77.123 I.609 J70.213 E.05614
G1 X193.861 Y77.221 E.01222
G1 X194.148 Y77.357 E.00516
G1 X194.325 Y77.588 E.00472
G1 X194.392 Y77.883 E.00491
; Slow Down End
M204 S10000
G1 X194.008 Y77.964 F30000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X193.985 Y78.361 E.00646
G1 X193.895 Y78.503 E.00273
G1 X193.51 Y78.615 E.00652
G3 X190.057 Y78.655 I-2.799 J-92.798 E.05607
G1 X190.057 Y77.467 E.01929
G3 X193.075 Y77.52 I.355 J65.552 E.04902
G1 X193.759 Y77.606 E.01118
G1 X193.928 Y77.699 E.00313
G1 X193.991 Y77.907 E.00352
; Slow Down End
M204 S10000
G1 X193.645 Y77.985 F30000
; Slow Down Start
; LINE_WIDTH: 0.359022
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X193.643 Y78.216 E.00318
G1 X193.452 Y78.253 E.00267
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.36463
;_EXTRUDE_SET_SPEED
G1 X193.183 Y78.256 E.00377
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.406981
;_EXTRUDE_SET_SPEED
G3 X190.454 Y78.258 I-1.923 J-609.627 E.04286
G1 X190.454 Y77.863 E.0062
G3 X192.188 Y77.871 I-.049 J198.495 E.02724
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.39173
;_EXTRUDE_SET_SPEED
G1 X192.613 Y77.884 E.00641
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.365498
;_EXTRUDE_SET_SPEED
G3 X193.602 Y77.946 I-.056 J8.853 E.0139
; Slow Down End
M204 S10000
G1 X195.167 Y72.945 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X195.651 Y73.428 E.01113
G3 X196.354 Y73.642 I-2.988 J11.101 E.01198
G1 X196.483 Y73.695 E.00228
G1 X195.627 Y72.839 E.01972
G2 X195.843 Y72.684 I-2.061 J-3.076 E.00433
G1 X195.949 Y72.595 E.00225
G1 X208.161 Y84.808 E.28133
G1 X208.161 Y84.242 E.00921
G1 X196.256 Y72.337 E.27424
G2 X196.545 Y72.06 I-1.712 J-2.072 E.00652
G1 X208.161 Y83.677 E.26759
G1 X208.161 Y83.111 E.00921
G1 X196.822 Y71.773 E.2612
G1 X197.081 Y71.466 E.00654
G1 X208.161 Y82.546 E.25525
G1 X208.161 Y81.981 E.00921
G1 X197.328 Y71.148 E.24955
G1 X197.567 Y70.821 E.00659
G1 X208.161 Y81.415 E.24405
G1 X208.161 Y80.85 E.00921
G1 X197.8 Y70.489 E.23868
G1 X198.028 Y70.152 E.00663
G1 X208.161 Y80.284 E.23342
G1 X208.161 Y79.719 E.00921
G1 X198.253 Y69.811 E.22824
G1 X198.475 Y69.468 E.00666
G1 X208.161 Y79.154 E.22313
G1 X208.161 Y78.588 E.00921
G1 X198.693 Y69.12 E.21811
G1 X198.911 Y68.772 E.00668
G1 X208.161 Y78.023 E.21309
G1 X208.161 Y77.458 E.00921
G1 X199.128 Y68.425 E.20808
G1 X199.346 Y68.077 E.00668
G1 X208.161 Y76.892 E.20306
G1 X208.161 Y76.327 E.00921
G1 X199.564 Y67.729 E.19805
G1 X199.781 Y67.382 E.00668
G1 X208.161 Y75.761 E.19303
G1 X208.161 Y75.196 E.00921
G1 X199.999 Y67.034 E.18802
G1 X200.217 Y66.686 E.00668
G1 X208.161 Y74.631 E.183
G1 X208.161 Y74.065 E.00921
G1 X200.434 Y66.339 E.17799
G1 X200.652 Y65.991 E.00668
G1 X208.161 Y73.5 E.17297
G1 X208.161 Y72.934 E.00921
G1 X192.446 Y57.219 E.36201
G1 X193.011 Y57.219 E.00921
G1 X208.161 Y72.369 E.34899
G1 X208.161 Y71.804 E.00921
G1 X193.577 Y57.219 E.33596
G1 X194.142 Y57.219 E.00921
G1 X208.161 Y71.238 E.32294
G1 X208.161 Y70.673 E.00921
G1 X194.708 Y57.219 E.30992
G1 X195.273 Y57.219 E.00921
G1 X208.161 Y70.107 E.29689
G1 X208.161 Y69.542 E.00921
G1 X195.838 Y57.219 E.28387
G1 X196.404 Y57.219 E.00921
G1 X208.161 Y68.977 E.27084
G1 X208.161 Y68.411 E.00921
G1 X196.969 Y57.219 E.25782
G1 X197.534 Y57.219 E.00921
G1 X208.161 Y67.846 E.24479
G1 X208.161 Y67.281 E.00921
G1 X198.1 Y57.219 E.23177
G1 X198.665 Y57.219 E.00921
G1 X208.161 Y66.715 E.21875
G1 X208.161 Y66.15 E.00921
G1 X199.231 Y57.219 E.20572
G1 X199.796 Y57.219 E.00921
G1 X208.161 Y65.584 E.1927
G1 X208.161 Y65.019 E.00921
G1 X200.361 Y57.219 E.17967
G1 X200.927 Y57.219 E.00921
G1 X208.161 Y64.454 E.16665
G1 X208.161 Y63.888 E.00921
G1 X201.492 Y57.219 E.15362
M73 P39 R45
G1 X202.058 Y57.219 E.00921
G1 X208.161 Y63.323 E.1406
G1 X208.161 Y62.757 E.00921
G1 X202.623 Y57.219 E.12758
G1 X203.188 Y57.219 E.00921
G1 X208.161 Y62.192 E.11455
G1 X208.161 Y61.627 E.00921
G1 X203.754 Y57.219 E.10153
G1 X204.319 Y57.219 E.00921
G1 X208.161 Y61.061 E.0885
G1 X208.161 Y60.496 E.00921
G1 X204.884 Y57.219 E.07548
G1 X205.45 Y57.219 E.00921
G1 X208.161 Y59.93 E.06245
G1 X208.161 Y59.365 E.00921
G1 X206.015 Y57.219 E.04943
G1 X206.581 Y57.219 E.00921
G1 X208.161 Y58.8 E.03641
G1 X208.161 Y58.234 E.00921
G1 X207.146 Y57.219 E.02338
G1 X207.711 Y57.219 E.00921
G1 X208.34 Y57.848 E.01449
M204 S10000
G1 X200.134 Y65.473 F30000
G1 F6000
M204 S1000
G1 X191.881 Y57.219 E.19014
G1 X191.315 Y57.219 E.00921
G1 X199.39 Y65.294 E.186
G1 X198.824 Y65.294 E.00921
G1 X190.75 Y57.219 E.18601
G1 X190.184 Y57.219 E.00921
G1 X198.259 Y65.294 E.18601
G1 X197.694 Y65.294 E.00921
G1 X189.619 Y57.219 E.18601
G1 X189.054 Y57.219 E.00921
G1 X197.128 Y65.294 E.18601
G1 X196.622 Y65.294 E.00824
G1 X196.583 Y65.314 E.00071
G1 X188.488 Y57.219 E.18648
G1 X187.923 Y57.219 E.00921
G1 X196.309 Y65.606 E.19319
G1 X196.082 Y65.944 E.00664
G1 X187.357 Y57.219 E.20098
G1 X186.792 Y57.219 E.00921
G1 X195.855 Y66.282 E.20877
G1 X195.628 Y66.621 E.00664
G1 X186.227 Y57.219 E.21657
G1 X185.661 Y57.219 E.00921
G1 X195.401 Y66.959 E.22436
G1 X195.174 Y67.297 E.00664
G1 X185.096 Y57.219 E.23216
G1 X184.531 Y57.219 E.00921
G1 X194.947 Y67.636 E.23995
G1 X194.72 Y67.974 E.00664
G1 X183.965 Y57.219 E.24775
G1 X183.4 Y57.219 E.00921
G1 X194.493 Y68.312 E.25554
G1 X194.266 Y68.651 E.00664
G1 X182.834 Y57.219 E.26334
G1 X182.269 Y57.219 E.00921
G1 X194.039 Y68.989 E.27113
G1 X193.812 Y69.328 E.00664
G1 X181.704 Y57.219 E.27893
G1 X181.138 Y57.219 E.00921
G1 X193.585 Y69.666 E.28672
G3 X193.355 Y70.002 I-13.874 J-9.245 E.00663
G1 X180.573 Y57.219 E.29446
G1 X180.007 Y57.219 E.00921
G1 X193.125 Y70.336 E.30217
G1 X192.893 Y70.67 E.00662
G1 X188.463 Y66.24 E.10205
G1 X188.463 Y66.806 E.00921
G1 X192.657 Y71 E.09662
G1 X192.416 Y71.324 E.00658
G1 X188.463 Y67.371 E.09107
G1 X188.463 Y67.937 E.00921
G1 X192.168 Y71.641 E.08534
G1 X191.901 Y71.94 E.00652
G1 X188.463 Y68.502 E.0792
G1 X188.463 Y69.067 E.00921
G1 X191.603 Y72.208 E.07234
G1 X191.44 Y72.334 E.00336
G1 X191.268 Y72.437 E.00328
G1 X188.463 Y69.633 E.06461
G1 X188.463 Y70.198 E.00921
G1 X190.882 Y72.617 E.05572
G1 X190.424 Y72.724 E.00766
G1 X188.463 Y70.763 E.04517
G1 X188.463 Y71.329 E.00921
G1 X189.916 Y72.781 E.03346
G3 X189.374 Y72.805 I-.837 J-12.861 E.00883
G1 X188.463 Y71.894 E.02099
G1 X188.463 Y72.46 E.00921
G1 X188.991 Y72.987 E.01216
M204 S10000
G1 X191.104 Y72.764 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X193.929 Y75.588 E.06975
G2 X193.594 Y75.548 I-.824 J5.382 E.0059
G1 X193.253 Y75.519 E.00597
G1 X190.803 Y73.069 E.0605
G1 X190.287 Y73.161 E.00914
G1 X192.612 Y75.486 E.05741
G1 X191.988 Y75.468 E.0109
G1 X189.727 Y73.207 E.05583
G1 X189.134 Y73.221 E.01035
G1 X191.374 Y75.461 E.0553
G2 X190.765 Y75.459 I-.463 J55.142 E.01063
G1 X185.051 Y69.745 E.1411
G1 X185.051 Y70.352 E.0106
G1 X190.158 Y75.459 E.12611
G1 X189.551 Y75.459 E.0106
G1 X185.051 Y70.959 E.11112
G1 X185.051 Y71.566 E.0106
G1 X188.944 Y75.459 E.09614
G1 X188.337 Y75.459 E.0106
G1 X185.051 Y72.173 E.08115
G1 X185.051 Y72.78 E.0106
G1 X188.05 Y75.779 E.07405
G1 X188.05 Y76.386 E.0106
G1 X185.051 Y73.387 E.07405
G1 X185.051 Y73.994 E.0106
G1 X188.05 Y76.993 E.07405
G1 X188.05 Y77.6 E.0106
G1 X185.051 Y74.601 E.07405
G1 X185.051 Y75.208 E.0106
G1 X188.05 Y78.207 E.07405
G1 X188.05 Y78.813 E.0106
G1 X185.051 Y75.815 E.07405
G1 X185.051 Y76.422 E.0106
G1 X188.05 Y79.42 E.07405
G1 X188.05 Y80.027 E.0106
M73 P40 R45
G1 X185.051 Y77.029 E.07405
G1 X185.051 Y77.636 E.0106
G1 X190.487 Y83.072 E.13423
G1 X191.094 Y83.072 E.0106
G1 X188.684 Y80.662 E.0595
G1 X189.291 Y80.662 E.0106
G1 X191.701 Y83.072 E.0595
G1 X192.308 Y83.072 E.0106
G1 X189.898 Y80.662 E.0595
G1 X190.505 Y80.662 E.0106
G1 X192.909 Y83.066 E.05935
G2 X193.499 Y83.049 I-.051 J-12.2 E.01031
G1 X191.112 Y80.662 E.05894
G2 X191.717 Y80.66 I.046 J-78.048 E.01056
G1 X194.076 Y83.019 E.05823
G2 X194.636 Y82.972 I-.424 J-8.473 E.00982
G1 X192.321 Y80.657 E.05717
G1 X192.919 Y80.648 E.01044
G1 X195.177 Y82.906 E.05576
G2 X195.695 Y82.817 I-.679 J-5.515 E.00918
G1 X193.505 Y80.627 E.05409
G2 X194.049 Y80.564 I.009 J-2.301 E.00958
G1 X196.182 Y82.698 E.05269
G2 X196.629 Y82.538 I-.742 J-2.776 E.0083
G1 X194.518 Y80.426 E.05213
G2 X194.926 Y80.227 I-.407 J-1.351 E.00796
G1 X197.038 Y82.339 E.05214
G2 X197.403 Y82.097 I-2.968 J-4.863 E.00765
G1 X195.274 Y79.968 E.05256
G2 X195.562 Y79.65 I-.745 J-.963 E.00754
G1 X197.734 Y81.821 E.05361
G2 X198.03 Y81.51 I-3.602 J-3.736 E.0075
G1 X195.788 Y79.268 E.05537
G2 X195.942 Y78.815 I-1.251 J-.679 E.00839
G1 X198.293 Y81.166 E.05805
G2 X198.526 Y80.793 I-2.431 J-1.783 E.0077
G1 X196.016 Y78.283 E.06199
G2 X196 Y77.667 I-5.023 J-.175 E.01075
G1 X198.73 Y80.389 E.0673
G2 X198.894 Y79.947 I-2.914 J-1.337 E.00825
G1 X191.642 Y72.695 E.17907
G2 X191.981 Y72.437 I-6.419 J-8.767 E.00743
G1 X199.023 Y79.468 E.17375
G2 X199.103 Y78.942 I-6.065 J-1.199 E.0093
G1 X192.293 Y72.131 E.16818
G1 X192.57 Y71.802 E.00752
G1 X199.136 Y78.368 E.16212
G2 X199.102 Y77.726 I-8.714 J.144 E.01121
G1 X195.102 Y73.727 E.09876
G1 X194.652 Y73.647 E.00797
G1 X194.563 Y73.187 E.00818
G1 X192.833 Y71.458 E.04271
G1 X193.089 Y71.107 E.00758
G1 X194.85 Y72.867 E.04346
G2 X195.216 Y72.626 I-1.645 J-2.9 E.00766
G1 X193.341 Y70.752 E.0463
G1 X193.588 Y70.392 E.00762
G1 X195.568 Y72.372 E.04889
G2 X195.9 Y72.096 I-1.715 J-2.397 E.00753
G1 X193.836 Y70.033 E.05096
G2 X194.08 Y69.67 I-14.762 J-10.201 E.00764
G1 X196.215 Y71.805 E.05271
G2 X196.514 Y71.497 I-2.125 J-2.363 E.0075
G1 X194.324 Y69.307 E.05408
G1 X194.568 Y68.943 E.00764
G1 X196.791 Y71.167 E.0549
G2 X197.044 Y70.837 I-5.044 J-4.145 E.00726
G1 X194.811 Y68.58 E.05544
G1 X195.055 Y68.217 E.00764
G1 X197.309 Y70.471 E.05566
G1 X197.554 Y70.118 E.00749
G1 X195.299 Y67.854 E.0558
G1 X195.542 Y67.49 E.00764
G1 X197.8 Y69.748 E.05576
G2 X198.039 Y69.38 I-12.172 J-8.16 E.00766
G1 X195.786 Y67.127 E.05564
G1 X196.03 Y66.764 E.00764
G1 X198.275 Y69.009 E.05543
G1 X198.508 Y68.636 E.00769
G1 X196.274 Y66.401 E.05518
G1 X196.517 Y66.037 E.00764
G1 X198.742 Y68.262 E.05494
G1 X198.976 Y67.889 E.00769
G1 X196.794 Y65.707 E.05387
G1 X197.401 Y65.707 E.0106
G1 X199.21 Y67.516 E.04465
G1 X199.443 Y67.142 E.00769
G1 X198.008 Y65.707 E.03544
G1 X198.615 Y65.707 E.0106
G1 X199.677 Y66.769 E.02622
G1 X199.911 Y66.396 E.00769
G1 X199.222 Y65.707 E.017
G1 X199.829 Y65.707 E.0106
G1 X200.284 Y66.163 E.01124
M204 S10000
G1 X198.979 Y76.39 F30000
G1 F7200
M204 S1000
G1 X196.97 Y74.38 E.04961
G2 X195.916 Y73.934 I-2.786 J5.104 E.02002
G1 X199.226 Y77.243 E.08172
M204 S10000
G1 X208.34 Y85.552 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X199.245 Y76.457 E.20952
G3 X199.447 Y77.224 I-6.824 J2.206 E.01293
G1 X208.161 Y85.938 E.20074
G1 X208.161 Y86.504 E.00921
G1 X199.533 Y77.876 E.19876
G3 X199.547 Y78.455 I-4.359 J.396 E.00945
G1 X208.161 Y87.069 E.19843
G1 X208.161 Y87.634 E.00921
G1 X199.514 Y78.988 E.19919
G1 X199.501 Y79.125 E.00225
G3 X199.443 Y79.481 I-5.28 J-.684 E.00588
G1 X208.161 Y88.2 E.20084
G1 X208.161 Y88.765 E.00921
G1 X199.332 Y79.936 E.2034
G3 X199.188 Y80.357 I-3.031 J-.8 E.00726
G1 X208.161 Y89.331 E.20671
G1 X208.161 Y89.896 E.00921
G1 X199.015 Y80.75 E.21069
G1 X198.94 Y80.903 E.00277
G3 X198.816 Y81.117 I-2.934 J-1.561 E.00402
G1 X208.161 Y90.461 E.21527
G1 X208.161 Y91.027 E.00921
G1 X198.593 Y81.459 E.22041
G1 X198.545 Y81.529 E.00139
G3 X198.346 Y81.777 I-3.556 J-2.647 E.00518
G1 X208.129 Y91.56 E.22535
G1 X207.563 Y91.56 E.00921
G1 X198.074 Y82.071 E.2186
G3 X197.773 Y82.335 I-7.389 J-8.095 E.00653
G1 X206.998 Y91.56 E.2125
G1 X206.433 Y91.56 E.00921
G1 X197.445 Y82.572 E.20705
G3 X197.087 Y82.78 I-1.46 J-2.103 E.00674
G1 X205.867 Y91.56 E.20226
G1 X205.302 Y91.56 E.00921
G1 X196.699 Y82.957 E.19818
G1 X196.616 Y82.991 E.00146
G3 X196.278 Y83.101 I-1.432 J-3.826 E.00579
G1 X204.736 Y91.56 E.19485
G1 X204.171 Y91.56 E.00921
G1 X195.825 Y83.214 E.19226
G1 X195.346 Y83.3 E.00793
G1 X203.606 Y91.56 E.19026
G1 X203.04 Y91.56 E.00921
G1 X194.847 Y83.367 E.18873
G1 X194.332 Y83.417 E.00844
G1 X202.475 Y91.56 E.18758
G1 X201.909 Y91.56 E.00921
G1 X193.8 Y83.45 E.18681
G1 X193.256 Y83.472 E.00887
G1 X201.344 Y91.56 E.18632
G1 X200.779 Y91.56 E.00921
G1 X192.701 Y83.482 E.18609
G1 X192.139 Y83.485 E.00915
G1 X200.213 Y91.56 E.186
G1 X199.648 Y91.56 E.00921
G1 X191.573 Y83.485 E.186
G1 X191.008 Y83.485 E.00921
G1 X199.082 Y91.56 E.186
G1 X198.517 Y91.56 E.00921
G1 X190.443 Y83.485 E.186
G1 X189.877 Y83.485 E.00921
G1 X197.952 Y91.56 E.186
G1 X197.386 Y91.56 E.00921
G1 X189.312 Y83.485 E.186
G1 X188.746 Y83.485 E.00921
G1 X196.821 Y91.56 E.186
G1 X196.256 Y91.56 E.00921
G1 X188.181 Y83.485 E.186
G1 X187.616 Y83.485 E.00921
G1 X195.69 Y91.56 E.186
G1 X195.125 Y91.56 E.00921
G1 X187.05 Y83.485 E.186
G1 X186.485 Y83.485 E.00921
G1 X194.559 Y91.56 E.186
G1 X193.994 Y91.56 E.00921
G1 X185.919 Y83.485 E.186
G1 X185.354 Y83.485 E.00921
G1 X193.429 Y91.56 E.186
G1 X192.863 Y91.56 E.00921
G1 X181.354 Y80.051 E.26513
G1 X181.354 Y79.485 E.00921
G1 X184.637 Y82.768 E.07563
G1 X184.637 Y82.203 E.00921
G1 X181.354 Y78.92 E.07563
G1 X181.354 Y78.354 E.00921
G1 X184.637 Y81.638 E.07563
G1 X184.637 Y81.072 E.00921
G1 X181.354 Y77.789 E.07563
G1 X181.354 Y77.224 E.00921
G1 X184.637 Y80.507 E.07563
G1 X184.637 Y79.942 E.00921
G1 X181.354 Y76.658 E.07563
G1 X181.354 Y76.093 E.00921
G1 X184.637 Y79.376 E.07563
G1 X184.637 Y78.811 E.00921
G1 X181.354 Y75.527 E.07563
G1 X181.354 Y74.962 E.00921
G1 X184.637 Y78.245 E.07563
G1 X184.637 Y77.68 E.00921
G1 X181.354 Y74.397 E.07563
G1 X181.354 Y73.831 E.00921
G1 X184.637 Y77.115 E.07563
G1 X184.637 Y76.549 E.00921
G1 X181.354 Y73.266 E.07563
G1 X181.354 Y72.701 E.00921
G1 X184.637 Y75.984 E.07563
G1 X184.637 Y75.418 E.00921
G1 X181.354 Y72.135 E.07563
G1 X181.354 Y71.57 E.00921
G1 X184.637 Y74.853 E.07563
G1 X184.637 Y74.288 E.00921
G1 X181.354 Y71.004 E.07563
G1 X181.354 Y70.439 E.00921
G1 X184.637 Y73.722 E.07563
G1 X184.637 Y73.157 E.00921
G1 X181.354 Y69.874 E.07563
G1 X181.354 Y69.308 E.00921
G1 X184.637 Y72.591 E.07563
G1 X184.637 Y72.026 E.00921
G1 X181.354 Y68.743 E.07563
G1 X181.354 Y68.177 E.00921
G1 X184.637 Y71.461 E.07563
G1 X184.637 Y70.895 E.00921
G1 X181.354 Y67.612 E.07563
G1 X181.354 Y67.047 E.00921
G1 X184.637 Y70.33 E.07563
G1 X184.637 Y69.765 E.00921
G1 X181.354 Y66.481 E.07563
G1 X181.354 Y65.916 E.00921
G1 X184.637 Y69.199 E.07563
G1 X184.637 Y68.634 E.00921
G1 X173.223 Y57.219 E.26294
G1 X173.788 Y57.219 E.00921
G1 X184.637 Y68.068 E.24992
G1 X184.637 Y67.503 E.00921
G1 X174.354 Y57.219 E.23689
G1 X174.919 Y57.219 E.00921
G1 X184.637 Y66.938 E.22387
G1 X184.637 Y66.372 E.00921
G1 X175.484 Y57.219 E.21085
G1 X176.05 Y57.219 E.00921
G1 X184.637 Y65.807 E.19782
G1 X184.637 Y65.509 E.00486
G1 X184.771 Y65.375 E.00308
G1 X176.615 Y57.219 E.18787
G1 X177.18 Y57.219 E.00921
G1 X185.255 Y65.294 E.186
G1 X185.82 Y65.294 E.00921
G1 X177.746 Y57.219 E.18601
G1 X178.311 Y57.219 E.00921
G1 X186.386 Y65.294 E.18601
G1 X186.951 Y65.294 E.00921
G1 X178.877 Y57.219 E.18601
G1 X179.442 Y57.219 E.00921
G1 X187.696 Y65.473 E.19014
M204 S10000
G1 X188.242 Y66.26 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X187.69 Y65.707 E.01365
G1 X187.083 Y65.707 E.0106
G1 X188.05 Y66.674 E.02387
G1 X188.05 Y67.281 E.0106
G1 X186.476 Y65.707 E.03886
G1 X185.869 Y65.707 E.0106
G1 X188.05 Y67.888 E.05385
G1 X188.05 Y68.495 E.0106
G1 X185.262 Y65.707 E.06884
G1 X185.051 Y65.707 E.00369
G1 X185.051 Y66.103 E.00691
G1 X188.05 Y69.102 E.07405
G1 X188.05 Y69.709 E.0106
G1 X185.051 Y66.71 E.07405
G1 X185.051 Y67.317 E.0106
G1 X188.05 Y70.316 E.07405
G1 X188.05 Y70.923 E.0106
G1 X185.051 Y67.924 E.07405
G1 X185.051 Y68.531 E.0106
G1 X188.05 Y71.53 E.07405
G1 X188.05 Y72.137 E.0106
G1 X184.858 Y68.945 E.07881
M204 S10000
G1 X181.133 Y66.497 F30000
G1 F7200
M204 S1000
G1 X180.343 Y65.707 E.0195
G1 X179.725 Y65.707 E.0108
G1 X180.94 Y66.923 E.03001
G1 X180.94 Y67.541 E.0108
G1 X179.107 Y65.707 E.04528
G1 X178.488 Y65.707 E.0108
G1 X180.94 Y68.159 E.06055
G1 X180.94 Y68.778 E.0108
G1 X177.942 Y65.779 E.07405
G1 X177.942 Y66.397 E.0108
G1 X180.94 Y69.396 E.07405
G1 X180.94 Y70.015 E.0108
G1 X177.942 Y67.016 E.07405
G1 X177.942 Y67.634 E.0108
G1 X180.94 Y70.633 E.07405
G1 X180.94 Y71.251 E.0108
G1 X177.942 Y68.252 E.07405
G1 X177.942 Y68.871 E.0108
G1 X180.94 Y71.87 E.07405
G1 X180.94 Y72.488 E.0108
G1 X177.942 Y69.489 E.07405
G1 X177.942 Y70.107 E.0108
G1 X180.94 Y73.106 E.07405
G1 X180.94 Y73.725 E.0108
G1 X177.942 Y70.726 E.07405
G1 X177.942 Y71.344 E.0108
G1 X180.94 Y74.343 E.07405
G1 X180.94 Y74.961 E.0108
G1 X177.942 Y71.963 E.07405
G1 X177.942 Y72.581 E.0108
G1 X180.94 Y75.58 E.07405
G1 X180.94 Y76.198 E.0108
G1 X177.942 Y73.199 E.07405
G1 X177.942 Y73.818 E.0108
G1 X180.94 Y76.816 E.07405
G1 X180.94 Y77.435 E.0108
G1 X177.942 Y74.436 E.07405
G1 X177.942 Y75.054 E.0108
G1 X180.94 Y78.053 E.07405
G1 X180.94 Y78.671 E.0108
G1 X177.942 Y75.673 E.07405
G1 X177.942 Y76.291 E.0108
G1 X180.94 Y79.29 E.07405
G1 X180.94 Y79.908 E.0108
G1 X177.942 Y76.909 E.07405
G1 X177.942 Y77.528 E.0108
G1 X180.94 Y80.526 E.07405
G1 X180.94 Y81.145 E.0108
G1 X177.942 Y78.146 E.07405
G1 X177.942 Y78.764 E.0108
G1 X180.94 Y81.763 E.07405
G1 X180.94 Y82.382 E.0108
G1 X177.942 Y79.383 E.07405
G1 X177.942 Y80.001 E.0108
G1 X180.94 Y83 E.07405
G1 X180.94 Y83.072 E.00126
G1 X180.394 Y83.072 E.00954
G1 X177.942 Y80.619 E.06056
G1 X177.942 Y81.238 E.0108
G1 X179.776 Y83.072 E.04529
G1 X179.157 Y83.072 E.0108
G1 X177.942 Y81.856 E.03002
G1 X177.942 Y82.474 E.0108
G1 X178.732 Y83.265 E.01951
M204 S10000
G1 X181.175 Y80.437 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X192.298 Y91.56 E.25623
G1 X191.732 Y91.56 E.00921
G1 X181.354 Y81.181 E.23908
G1 X181.354 Y81.747 E.00921
G1 X191.167 Y91.56 E.22605
G1 X190.602 Y91.56 E.00921
G1 X181.354 Y82.312 E.21303
G1 X181.354 Y82.878 E.00921
G1 X190.036 Y91.56 E.20001
G1 X189.471 Y91.56 E.00921
G1 X181.268 Y83.357 E.18897
G1 X181.139 Y83.485 E.00296
G1 X180.831 Y83.485 E.00502
G1 X188.905 Y91.56 E.186
G1 X188.34 Y91.56 E.00921
G1 X180.266 Y83.485 E.18601
G1 X179.7 Y83.485 E.00921
G1 X187.775 Y91.56 E.18601
G1 X187.209 Y91.56 E.00921
G1 X179.135 Y83.485 E.18601
G1 X178.569 Y83.485 E.00921
G1 X186.644 Y91.56 E.18601
G1 X186.079 Y91.56 E.00921
G1 X178.004 Y83.485 E.18601
G1 X177.743 Y83.485 E.00426
G1 X177.528 Y83.271 E.00495
G1 X177.528 Y83.009 E.00426
G1 X171.335 Y76.816 E.14267
G1 X171.496 Y76.412 E.00708
G1 X177.528 Y82.444 E.13895
G1 X177.528 Y81.879 E.00921
G1 X171.658 Y76.008 E.13523
G1 X171.82 Y75.605 E.00708
G1 X177.528 Y81.313 E.1315
G1 X177.528 Y80.748 E.00921
G1 X171.981 Y75.201 E.12778
G1 X172.143 Y74.797 E.00708
G1 X177.528 Y80.182 E.12405
G1 X177.528 Y79.617 E.00921
G1 X172.304 Y74.393 E.12033
G1 X172.466 Y73.99 E.00708
G1 X177.528 Y79.052 E.11661
G1 X177.528 Y78.486 E.00921
G1 X172.628 Y73.586 E.11288
G1 X172.789 Y73.182 E.00708
G1 X177.528 Y77.921 E.10916
G1 X177.528 Y77.355 E.00921
G1 X172.951 Y72.779 E.10543
G1 X173.113 Y72.375 E.00708
G1 X177.528 Y76.79 E.10171
G1 X177.528 Y76.225 E.00921
G1 X173.274 Y71.971 E.09799
G1 X173.436 Y71.567 E.00708
G1 X177.528 Y75.659 E.09426
G1 X177.528 Y75.094 E.00921
G1 X173.598 Y71.164 E.09054
G1 X173.759 Y70.76 E.00708
G1 X177.528 Y74.529 E.08681
G1 X177.528 Y73.963 E.00921
G1 X173.921 Y70.356 E.08309
G1 X174.083 Y69.952 E.00708
G1 X177.528 Y73.398 E.07937
G1 X177.528 Y72.832 E.00921
G1 X174.244 Y69.549 E.07564
G1 X174.406 Y69.145 E.00708
G1 X177.528 Y72.267 E.07192
G1 X177.528 Y71.702 E.00921
G1 X174.568 Y68.741 E.06819
G1 X174.729 Y68.338 E.00708
G1 X177.528 Y71.136 E.06447
G1 X177.528 Y70.571 E.00921
G1 X174.891 Y67.934 E.06075
G1 X175.053 Y67.53 E.00708
G1 X177.528 Y70.005 E.05702
G1 X177.528 Y69.44 E.00921
G1 X175.214 Y67.126 E.0533
G1 X175.376 Y66.723 E.00708
G1 X177.528 Y68.875 E.04958
G1 X177.528 Y68.309 E.00921
G1 X175.538 Y66.319 E.04585
G1 X175.699 Y65.915 E.00708
G1 X177.528 Y67.744 E.04213
G1 X177.528 Y67.178 E.00921
G1 X167.569 Y57.219 E.22942
G1 X168.134 Y57.219 E.00921
G1 X177.528 Y66.613 E.2164
G1 X177.528 Y66.048 E.00921
G1 X168.7 Y57.219 E.20337
G1 X169.265 Y57.219 E.00921
G1 X177.541 Y65.495 E.19065
G1 X177.743 Y65.294 E.00464
G1 X177.905 Y65.294 E.00264
G1 X169.83 Y57.219 E.186
G1 X170.396 Y57.219 E.00921
G1 X178.47 Y65.294 E.18601
G1 X179.036 Y65.294 E.00921
G1 X170.961 Y57.219 E.18601
G1 X171.527 Y57.219 E.00921
G1 X179.601 Y65.294 E.18601
G1 X180.167 Y65.294 E.00921
G1 X172.092 Y57.219 E.18601
G1 X172.657 Y57.219 E.00921
G1 X180.911 Y65.473 E.19014
M204 S10000
G1 X175.327 Y66.252 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X174.783 Y65.707 E.01344
G1 X174.165 Y65.707 E.01079
G1 X175.002 Y66.545 E.02067
G1 X174.825 Y66.986 E.0083
G1 X173.547 Y65.707 E.03157
G1 X172.929 Y65.707 E.01079
G1 X174.648 Y67.427 E.04247
G1 X174.472 Y67.868 E.0083
G1 X172.311 Y65.707 E.05336
G1 X172.071 Y65.707 E.00418
G1 X171.966 Y65.981 E.00511
G1 X174.295 Y68.31 E.05751
G1 X174.118 Y68.751 E.0083
G1 X171.795 Y66.427 E.05738
G1 X171.623 Y66.873 E.00835
G1 X173.942 Y69.192 E.05725
G1 X173.765 Y69.633 E.0083
G1 X171.451 Y67.32 E.05713
G1 X171.28 Y67.766 E.00835
G1 X173.588 Y70.075 E.057
G1 X173.412 Y70.516 E.0083
G1 X171.108 Y68.213 E.05688
G1 X170.937 Y68.659 E.00835
G1 X173.235 Y70.957 E.05675
G1 X173.058 Y71.398 E.0083
G1 X170.765 Y69.105 E.05662
G1 X170.594 Y69.552 E.00835
G1 X172.882 Y71.84 E.0565
G1 X172.705 Y72.281 E.0083
G1 X170.22 Y69.796 E.06136
G1 X169.602 Y69.796 E.01079
G1 X172.528 Y72.722 E.07225
G1 X172.352 Y73.163 E.0083
G1 X168.984 Y69.796 E.08315
G1 X168.366 Y69.796 E.01079
G1 X172.175 Y73.605 E.09405
G1 X171.998 Y74.046 E.0083
G1 X167.748 Y69.796 E.10494
G1 X167.13 Y69.796 E.01079
G1 X171.822 Y74.487 E.11584
G1 X171.645 Y74.928 E.0083
G1 X166.512 Y69.796 E.12673
G1 X165.894 Y69.796 E.01079
G1 X168.292 Y72.193 E.05919
G1 X167.674 Y72.193 E.01079
G1 X165.277 Y69.796 E.05919
G1 X164.659 Y69.796 E.01079
G1 X167.056 Y72.193 E.05919
G1 X166.438 Y72.193 E.01079
G1 X164.041 Y69.796 E.05919
G1 X163.423 Y69.796 E.01079
G1 X165.82 Y72.193 E.05919
G1 X165.202 Y72.193 E.01079
G1 X158.716 Y65.707 E.16015
G1 X159.334 Y65.707 E.01079
G1 X162.545 Y68.918 E.07928
G1 X162.192 Y67.947 E.01803
G1 X159.952 Y65.707 E.05531
G1 X160.57 Y65.707 E.01079
G1 X161.839 Y66.977 E.03134
G1 X161.487 Y66.006 E.01803
G1 X160.995 Y65.515 E.01214
M204 S10000
G1 X158 Y65.609 F30000
G1 F7200
M204 S1000
G1 X164.584 Y72.193 E.16258
G1 X164.144 Y72.193 E.00769
G1 X164.071 Y72.298 E.00223
G1 X158.676 Y66.903 E.13321
G1 X159.07 Y67.915 E.01897
G1 X163.98 Y72.825 E.12123
G1 X164.333 Y73.796 E.01805
G1 X159.464 Y68.927 E.12023
G1 X159.858 Y69.939 E.01897
G1 X164.687 Y74.768 E.11923
G1 X165.04 Y75.739 E.01805
G1 X160.253 Y70.952 E.11822
G1 X160.647 Y71.964 E.01897
G1 X165.394 Y76.711 E.11722
G1 X165.748 Y77.682 E.01805
G1 X161.041 Y72.976 E.11622
G1 X161.435 Y73.988 E.01897
G1 X166.101 Y78.654 E.11522
G1 X166.332 Y79.287 E.01175
G1 X166.735 Y79.288 E.00705
G1 X168.995 Y81.547 E.05579
G1 X169.171 Y81.106 E.0083
G1 X167.05 Y78.985 E.05238
G1 X167.217 Y78.534 E.00839
G1 X169.348 Y80.665 E.05261
G1 X169.525 Y80.224 E.0083
G1 X167.385 Y78.084 E.05284
G1 X167.552 Y77.633 E.00839
G1 X169.701 Y79.782 E.05307
G1 X169.878 Y79.341 E.0083
G1 X167.719 Y77.182 E.0533
G1 X167.887 Y76.732 E.00839
M73 P41 R45
G1 X170.055 Y78.9 E.05353
G1 X170.231 Y78.459 E.0083
G1 X168.054 Y76.281 E.05377
G1 X168.221 Y75.831 E.00839
G1 X170.408 Y78.017 E.054
G1 X170.585 Y77.576 E.0083
G1 X168.389 Y75.38 E.05423
G1 X168.556 Y74.929 E.00839
G1 X170.761 Y77.135 E.05446
G1 X170.938 Y76.693 E.0083
G1 X168.723 Y74.479 E.05469
G1 X168.891 Y74.028 E.00839
G1 X171.115 Y76.252 E.05492
G1 X171.291 Y75.811 E.0083
G1 X169.058 Y73.577 E.05515
G1 X169.225 Y73.127 E.00839
G1 X171.616 Y75.518 E.05905
M204 S10000
G1 X168.965 Y72.615 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X166.655 Y78.861 E.10812
G1 X166.621 Y78.874 E.00059
G1 X164.35 Y72.634 E.10782
G1 X164.359 Y72.607 E.00047
M73 P41 R44
G1 X168.907 Y72.607 E.07385
; Slow Down End
M204 S10000
G1 X168.404 Y73.005 F30000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X166.639 Y77.758 E.08233
G1 X164.909 Y73.005 E.08213
G1 X168.344 Y73.005 E.05577
; Slow Down End
M204 S10000
G1 X167.831 Y73.404 F30000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X166.643 Y76.603 E.05542
G1 X165.479 Y73.404 E.05529
G1 X167.771 Y73.404 E.03723
; Slow Down End
M204 S10000
G1 X167.258 Y73.802 F30000
; Slow Down Start
G1 F1500;_EXTRUDE_SET_SPEED
M204 S1000
G1 X166.647 Y75.448 E.02851
G1 X166.048 Y73.802 E.02844
G1 X167.198 Y73.802 E.01868
; Slow Down End
M204 S10000
G1 X166.707 Y74.225 F30000
; LINE_WIDTH: 0.46752
G1 F4800
M204 S1000
G3 X166.621 Y74.18 I-.055 J.001 E.0041
M204 S10000
G1 X165.211 Y69.562 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X162.081 Y66.432 E.07211
G1 X162.404 Y67.32 E.01539
G1 X164.467 Y69.382 E.04752
G1 X163.901 Y69.382 E.00921
G1 X162.727 Y68.208 E.02706
G1 X163.049 Y69.096 E.01539
G1 X163.515 Y69.562 E.01073
M204 S10000
G1 X175.257 Y65.473 F30000
G1 F6000
M204 S1000
G1 X167.003 Y57.219 E.19014
G1 X166.438 Y57.219 E.00921
G1 X174.513 Y65.294 E.186
G1 X173.947 Y65.294 E.00921
G1 X165.873 Y57.219 E.186
G1 X165.307 Y57.219 E.00921
G1 X173.382 Y65.294 E.186
G1 X172.816 Y65.294 E.00921
G1 X164.742 Y57.219 E.186
G1 X164.177 Y57.219 E.00921
G1 X172.251 Y65.294 E.186
G1 X171.925 Y65.294 E.00531
G1 X171.783 Y65.391 E.00281
G1 X163.611 Y57.219 E.18825
G1 X163.046 Y57.219 E.00921
G1 X171.602 Y65.776 E.1971
G1 X171.445 Y66.184 E.00713
G1 X162.48 Y57.219 E.20651
G1 X161.915 Y57.219 E.00921
G1 X171.288 Y66.592 E.21592
G1 X171.131 Y67.001 E.00713
G1 X161.35 Y57.219 E.22533
G1 X160.784 Y57.219 E.00921
G1 X170.974 Y67.409 E.23473
G1 X170.817 Y67.818 E.00713
G1 X160.219 Y57.219 E.24414
G1 X159.653 Y57.219 E.00921
G1 X170.66 Y68.226 E.25355
G1 X170.503 Y68.634 E.00713
G1 X159.088 Y57.219 E.26296
G1 X158.523 Y57.219 E.00921
G1 X170.346 Y69.043 E.27237
G1 X170.218 Y69.375 E.0058
G3 X170.12 Y69.382 I-.054 J-.068 E.0017
G1 X157.957 Y57.219 E.28019
G1 X157.392 Y57.219 E.00921
G1 X169.555 Y69.382 E.28019
G1 X168.99 Y69.382 E.00921
G1 X156.826 Y57.219 E.28019
G1 X156.261 Y57.219 E.00921
G1 X168.424 Y69.382 E.28019
G1 X167.859 Y69.382 E.00921
G1 X155.696 Y57.219 E.28019
G1 X155.13 Y57.219 E.00921
G1 X167.294 Y69.382 E.28019
G1 X166.728 Y69.382 E.00921
G1 X154.565 Y57.219 E.28019
G1 X154 Y57.219 E.00921
G1 X166.163 Y69.382 E.28019
G1 X165.597 Y69.382 E.00921
G1 X153.434 Y57.219 E.28019
G1 X152.869 Y57.219 E.00921
G1 X160.943 Y65.294 E.18601
G1 X160.378 Y65.294 E.00921
G1 X152.303 Y57.219 E.18601
G1 X151.738 Y57.219 E.00921
G1 X159.813 Y65.294 E.18601
G1 X159.247 Y65.294 E.00921
G1 X151.173 Y57.219 E.18601
G1 X150.607 Y57.219 E.00921
G1 X158.682 Y65.294 E.18601
G1 X158.116 Y65.294 E.00921
G1 X150.042 Y57.219 E.18601
G1 X149.476 Y57.219 E.00921
G1 X157.787 Y65.53 E.19144
G1 X157.73 Y65.613 E.00165
G1 X158 Y66.309 E.01216
G1 X148.911 Y57.219 E.20938
G1 X148.346 Y57.219 E.00921
G1 X158.361 Y67.235 E.23072
G1 X158.722 Y68.161 E.01619
G1 X147.78 Y57.219 E.25205
G1 X147.215 Y57.219 E.00921
G1 X159.083 Y69.087 E.27338
G1 X159.443 Y70.013 E.01619
G1 X146.649 Y57.219 E.29472
G1 X146.084 Y57.219 E.00921
G1 X159.804 Y70.939 E.31605
G1 X160.165 Y71.865 E.01619
G1 X145.519 Y57.219 E.33739
G1 X144.953 Y57.219 E.00921
G1 X160.525 Y72.791 E.35872
G1 X160.886 Y73.718 E.01619
G1 X144.388 Y57.219 E.38005
G1 X143.823 Y57.219 E.00921
G1 X161.247 Y74.644 E.40139
G1 X161.608 Y75.57 E.01619
G1 X143.257 Y57.219 E.42272
G1 X142.692 Y57.219 E.00921
G1 X161.968 Y76.496 E.44405
G1 X162.329 Y77.422 E.01619
G1 X142.126 Y57.219 E.46539
G1 X141.561 Y57.219 E.00921
G1 X162.69 Y78.348 E.48672
G1 X163.05 Y79.274 E.01619
G1 X149.774 Y65.998 E.30583
G1 X149.774 Y66.563 E.00921
G1 X163.411 Y80.2 E.31414
G1 X163.772 Y81.126 E.01619
G1 X149.774 Y67.129 E.32245
G1 X149.774 Y67.694 E.00921
G1 X164.448 Y82.368 E.33802
M204 S10000
G1 X165.768 Y83.265 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X164.589 Y82.085 E.02912
G1 X164.195 Y81.073 E.01897
G1 X166.193 Y83.072 E.04935
G1 X166.811 Y83.072 E.01079
G1 X163.801 Y80.061 E.07434
G1 X163.407 Y79.049 E.01897
G1 X167.429 Y83.072 E.09933
G1 X168.047 Y83.072 E.01079
G1 X163.012 Y78.037 E.12433
G1 X162.618 Y77.025 E.01897
G1 X168.465 Y82.871 E.14437
G1 X168.641 Y82.43 E.0083
G1 X162.224 Y76.012 E.15846
G1 X161.83 Y75 E.01897
G1 X168.966 Y82.137 E.17622
M204 S10000
G1 X154.596 Y91.739 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X141.783 Y78.926 E.29517
G1 X141.568 Y79.276 E.0067
G1 X153.851 Y91.56 E.28296
G1 X153.286 Y91.56 E.00921
G1 X141.353 Y79.627 E.27489
G1 X141.138 Y79.978 E.0067
G1 X152.721 Y91.56 E.26681
G1 X152.155 Y91.56 E.00921
G1 X140.923 Y80.328 E.25874
G1 X140.709 Y80.679 E.0067
G1 X151.59 Y91.56 E.25066
G1 X151.024 Y91.56 E.00921
G1 X140.494 Y81.029 E.24258
G1 X140.279 Y81.38 E.0067
G1 X150.459 Y91.56 E.23451
G1 X149.894 Y91.56 E.00921
G1 X140.064 Y81.73 E.22643
G1 X139.849 Y82.081 E.0067
G1 X149.328 Y91.56 E.21836
G1 X148.763 Y91.56 E.00921
G1 X139.634 Y82.431 E.21028
G1 X139.42 Y82.782 E.0067
G1 X148.198 Y91.56 E.20221
G1 X147.632 Y91.56 E.00921
G1 X139.205 Y83.132 E.19413
G1 X139.046 Y83.392 E.00496
G1 X138.952 Y83.445 E.00176
G1 X147.067 Y91.56 E.18694
G1 X146.501 Y91.56 E.00921
G1 X138.427 Y83.485 E.18601
G1 X137.861 Y83.485 E.00921
G1 X145.936 Y91.56 E.186
G1 X145.371 Y91.56 E.00921
G1 X137.296 Y83.485 E.186
G1 X136.731 Y83.485 E.00921
G1 X144.805 Y91.56 E.18601
G1 X144.24 Y91.56 E.00921
G1 X135.986 Y83.306 E.19014
M204 S10000
G1 X135.482 Y82.802 F30000
G1 F6000
M204 S1000
G1 X131.724 Y79.044 E.08657
G1 X131.892 Y78.647 E.00703
G1 X135.303 Y82.058 E.07857
G1 X135.303 Y81.492 E.00921
G1 X132.044 Y78.233 E.07508
G1 X132.178 Y77.802 E.00735
G1 X135.303 Y80.927 E.07198
G1 X135.303 Y80.361 E.00921
G1 X132.296 Y77.354 E.06927
G1 X132.396 Y76.889 E.00775
G1 X135.303 Y79.796 E.06697
G1 X135.303 Y79.231 E.00921
G1 X132.478 Y76.405 E.06508
G1 X132.542 Y75.904 E.00824
G1 X135.303 Y78.665 E.06361
G1 X135.303 Y78.1 E.00921
G1 X132.587 Y75.384 E.06257
G1 X132.613 Y74.845 E.00879
G1 X135.303 Y77.535 E.06196
G1 X135.303 Y76.969 E.00921
G1 X132.62 Y74.286 E.0618
G1 X132.606 Y73.707 E.00944
G1 X135.303 Y76.404 E.06213
G1 X135.303 Y75.838 E.00921
G1 X132.566 Y73.102 E.06305
G1 X132.495 Y72.465 E.01043
G1 X135.303 Y75.273 E.06468
G1 X135.303 Y74.708 E.00921
G1 X132.384 Y71.789 E.06724
G1 X132.206 Y71.046 E.01244
G1 X135.303 Y74.142 E.07133
G1 X135.303 Y73.577 E.00921
G1 X131.932 Y70.206 E.07764
G2 X131.488 Y69.219 I-8.623 J3.291 E.01765
G1 X131.457 Y69.166 E.00099
G1 X135.303 Y73.011 E.08859
G1 X135.303 Y72.446 E.00921
G1 X120.076 Y57.219 E.35076
G1 X120.642 Y57.219 E.00921
G1 X135.303 Y71.881 E.33774
G1 X135.303 Y71.315 E.00921
G1 X121.207 Y57.219 E.32471
G1 X121.772 Y57.219 E.00921
G1 X135.303 Y70.75 E.31169
G1 X135.303 Y70.184 E.00921
G1 X122.338 Y57.219 E.29867
G1 X122.903 Y57.219 E.00921
G1 X135.303 Y69.619 E.28564
G1 X135.303 Y69.054 E.00921
G1 X123.469 Y57.219 E.27262
G1 X124.034 Y57.219 E.00921
G1 X135.303 Y68.488 E.25959
G1 X135.303 Y67.923 E.00921
G1 X124.599 Y57.219 E.24657
G1 X125.165 Y57.219 E.00921
G1 X135.303 Y67.358 E.23354
G1 X135.303 Y66.792 E.00921
G1 X125.73 Y57.219 E.22052
G1 X126.296 Y57.219 E.00921
G1 X135.303 Y66.227 E.2075
G1 X135.303 Y65.661 E.00921
G1 X126.861 Y57.219 E.19447
G1 X127.426 Y57.219 E.00921
G1 X135.509 Y65.302 E.1862
G1 X136.066 Y65.294 E.00907
G1 X127.992 Y57.219 E.18601
G1 X128.557 Y57.219 E.00921
G1 X136.632 Y65.294 E.18601
G1 X137.197 Y65.294 E.00921
G1 X129.122 Y57.219 E.18601
G1 X129.688 Y57.219 E.00921
G1 X137.762 Y65.294 E.186
G1 X138.328 Y65.294 E.00921
G1 X130.253 Y57.219 E.186
G1 X130.819 Y57.219 E.00921
G1 X143.272 Y69.672 E.28687
G1 X143.488 Y69.323 E.00669
G1 X131.384 Y57.219 E.27882
G1 X131.949 Y57.219 E.00921
G1 X143.704 Y68.973 E.27077
G1 X143.92 Y68.624 E.00669
G1 X132.515 Y57.219 E.26272
G1 X133.08 Y57.219 E.00921
G1 X144.136 Y68.275 E.25467
G1 X144.352 Y67.925 E.00669
G1 X133.646 Y57.219 E.24662
G1 X134.211 Y57.219 E.00921
G1 X144.568 Y67.576 E.23858
G1 X144.784 Y67.227 E.00669
G1 X134.776 Y57.219 E.23053
G1 X135.342 Y57.219 E.00921
G1 X145 Y66.877 E.22248
G1 X145.216 Y66.528 E.00669
G1 X135.907 Y57.219 E.21443
G1 X136.472 Y57.219 E.00921
G1 X145.432 Y66.178 E.20638
G1 X145.648 Y65.829 E.00669
G1 X137.038 Y57.219 E.19833
G1 X137.603 Y57.219 E.00921
G1 X145.864 Y65.48 E.19028
G1 X145.921 Y65.387 E.00178
G1 X146.087 Y65.294 E.0031
G1 X146.243 Y65.294 E.00254
G1 X138.169 Y57.219 E.18601
G1 X138.734 Y57.219 E.00921
G1 X146.809 Y65.294 E.18601
G1 X147.374 Y65.294 E.00921
G1 X139.299 Y57.219 E.18601
G1 X139.865 Y57.219 E.00921
G1 X147.939 Y65.294 E.18601
G1 X148.505 Y65.294 E.00921
G1 X140.43 Y57.219 E.18601
G1 X140.996 Y57.219 E.00921
G1 X149.249 Y65.473 E.19014
M204 S10000
G1 X149.553 Y66.483 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X148.778 Y65.707 E.01916
G1 X148.169 Y65.707 E.01063
G1 X149.361 Y66.899 E.02944
G1 X149.361 Y67.508 E.01063
G1 X147.559 Y65.707 E.04447
G1 X146.95 Y65.707 E.01063
G1 X149.361 Y68.117 E.05951
G1 X149.361 Y68.726 E.01063
G1 X146.341 Y65.707 E.07455
G1 X146.209 Y65.707 E.00232
G1 X146.027 Y66.002 E.00604
G1 X149.361 Y69.335 E.08232
G1 X149.361 Y69.945 E.01063
G1 X145.794 Y66.378 E.08806
G1 X145.562 Y66.754 E.00773
G1 X149.361 Y70.554 E.09381
G1 X149.361 Y71.163 E.01063
G1 X145.329 Y67.131 E.09955
G1 X145.096 Y67.507 E.00773
G1 X149.361 Y71.772 E.1053
G1 X149.361 Y72.381 E.01063
G1 X144.864 Y67.884 E.11104
G1 X144.631 Y68.26 E.00773
G1 X149.361 Y72.99 E.11679
G1 X149.361 Y73.599 E.01063
G1 X144.398 Y68.636 E.12253
G1 X144.166 Y69.013 E.00773
G1 X149.361 Y74.208 E.12828
G1 X149.361 Y74.817 E.01063
G1 X146.62 Y72.076 E.06768
G1 X146.62 Y72.685 E.01063
G1 X149.361 Y75.426 E.06768
G1 X149.361 Y76.035 E.01063
G1 X146.62 Y73.294 E.06768
G1 X146.62 Y73.903 E.01063
G1 X149.361 Y76.644 E.06768
G1 X149.361 Y77.253 E.01063
G1 X146.62 Y74.512 E.06768
G1 X146.62 Y75.121 E.01063
G1 X149.361 Y77.862 E.06768
G1 X149.361 Y78.471 E.01063
G1 X146.62 Y75.73 E.06768
G1 X146.62 Y76.339 E.01063
G1 X149.361 Y79.08 E.06768
G1 X149.361 Y79.689 E.01063
G1 X146.62 Y76.948 E.06768
G1 X146.62 Y77.557 E.01063
G1 X149.361 Y80.298 E.06768
G1 X149.361 Y80.907 E.01063
G1 X146.62 Y78.166 E.06768
G1 X146.62 Y78.775 E.01063
G1 X149.361 Y81.516 E.06768
G1 X149.361 Y82.125 E.01063
G1 X146.62 Y79.384 E.06768
G1 X146.62 Y79.993 E.01063
G1 X149.361 Y82.734 E.06768
G1 X149.361 Y83.072 E.0059
G1 X149.089 Y83.072 E.00473
G1 X146.62 Y80.602 E.06099
G1 X146.62 Y81.211 E.01063
G1 X148.48 Y83.072 E.04595
G1 X147.871 Y83.072 E.01063
G1 X146.62 Y81.82 E.03091
G1 X146.62 Y82.429 E.01063
G1 X147.262 Y83.072 E.01587
G1 X146.653 Y83.072 E.01063
G1 X146.427 Y82.845 E.0056
M204 S10000
G1 X140.741 Y80.204 F30000
G1 F7200
M204 S1000
G1 X135.716 Y75.18 E.12406
G1 X135.716 Y75.789 E.01063
G1 X140.369 Y80.441 E.11488
G1 X140.138 Y80.819 E.00773
G1 X135.716 Y76.398 E.10917
G1 X135.716 Y77.007 E.01063
G1 X139.906 Y81.197 E.10345
G1 X139.675 Y81.574 E.00773
G1 X135.716 Y77.616 E.09774
G1 X135.716 Y78.225 E.01063
G1 X139.443 Y81.952 E.09202
G1 X139.212 Y82.329 E.00773
G1 X135.716 Y78.834 E.08631
G1 X135.716 Y79.443 E.01063
G1 X138.98 Y82.707 E.0806
G1 X138.736 Y83.072 E.00766
G1 X135.716 Y80.052 E.07456
G1 X135.716 Y80.661 E.01063
G1 X138.127 Y83.072 E.05953
G1 X137.518 Y83.072 E.01063
G1 X135.716 Y81.27 E.04449
G1 X135.716 Y81.879 E.01063
G1 X136.909 Y83.072 E.02945
G1 X136.3 Y83.072 E.01063
G1 X135.524 Y82.295 E.01917
M204 S10000
G1 X139.082 Y76.79 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X138.871 Y76.579 E.00486
G1 X138.871 Y76.014 E.00921
G1 X139.168 Y76.311 E.00684
G1 X139.384 Y75.961 E.00669
G1 X138.871 Y75.449 E.01181
G1 X138.871 Y74.883 E.00921
G1 X139.6 Y75.612 E.01679
G1 X139.816 Y75.263 E.00669
G1 X138.871 Y74.318 E.02176
G1 X138.871 Y73.752 E.00921
G1 X140.032 Y74.913 E.02674
G1 X140.248 Y74.564 E.00669
G1 X138.871 Y73.187 E.03171
G1 X138.871 Y72.622 E.00921
G1 X140.464 Y74.214 E.03669
G1 X140.68 Y73.865 E.00669
G1 X138.871 Y72.056 E.04166
G1 X138.871 Y71.491 E.00921
G1 X140.896 Y73.516 E.04664
G1 X141.112 Y73.166 E.00669
G1 X138.871 Y70.926 E.05162
G1 X138.871 Y70.36 E.00921
G1 X141.328 Y72.817 E.05659
G1 X141.544 Y72.467 E.00669
G1 X138.871 Y69.795 E.06157
G1 X138.871 Y69.229 E.00921
G1 X141.76 Y72.118 E.06654
G1 X141.976 Y71.769 E.00669
G1 X138.871 Y68.664 E.07152
G1 X138.871 Y68.099 E.00921
G1 X142.192 Y71.419 E.07649
G1 X142.408 Y71.07 E.00669
G1 X138.871 Y67.533 E.08147
G1 X138.871 Y66.968 E.00921
G1 X142.624 Y70.72 E.08645
G1 X142.84 Y70.371 E.00669
G1 X138.871 Y66.402 E.09142
G1 X138.871 Y65.837 E.00921
G1 X143.186 Y70.152 E.0994
M204 S10000
G1 X143.854 Y91.739 F30000
G1 F6000
M204 S1000
G1 X131.54 Y79.426 E.28366
G1 X131.34 Y79.791 E.00678
G1 X143.109 Y91.56 E.27111
G1 X142.544 Y91.56 E.00921
G1 X131.124 Y80.14 E.26306
G1 X130.893 Y80.475 E.00662
G1 X141.978 Y91.56 E.25536
G1 X141.413 Y91.56 E.00921
G1 X130.647 Y80.794 E.248
G1 X130.386 Y81.099 E.00653
G1 X140.847 Y91.56 E.24099
G1 X140.282 Y91.56 E.00921
G1 X130.111 Y81.389 E.2343
G1 X129.822 Y81.665 E.00651
G1 X139.717 Y91.56 E.22794
G1 X139.151 Y91.56 E.00921
M73 P42 R44
G1 X129.518 Y81.927 E.22191
G1 X129.2 Y82.174 E.00656
G1 X138.586 Y91.56 E.21621
G1 X138.021 Y91.56 E.00921
G1 X128.867 Y82.407 E.21085
G3 X128.519 Y82.623 I-2.411 J-3.491 E.00669
G1 X137.455 Y91.56 E.20586
G1 X136.89 Y91.56 E.00921
G1 X128.154 Y82.824 E.20124
G1 X127.772 Y83.008 E.0069
G1 X136.324 Y91.56 E.19701
G1 X135.759 Y91.56 E.00921
G1 X127.373 Y83.174 E.19318
G1 X126.956 Y83.322 E.00721
G1 X135.194 Y91.56 E.18977
G1 X134.628 Y91.56 E.00921
G1 X126.519 Y83.451 E.18679
G1 X126.064 Y83.561 E.00764
G1 X134.063 Y91.56 E.18427
G1 X133.497 Y91.56 E.00921
G1 X125.588 Y83.65 E.18221
G1 X125.09 Y83.718 E.00818
G1 X132.932 Y91.56 E.18064
G1 X132.367 Y91.56 E.00921
G1 X124.571 Y83.764 E.17958
G1 X124.029 Y83.787 E.00884
G1 X131.801 Y91.56 E.17905
G1 X131.236 Y91.56 E.00921
G1 X123.462 Y83.786 E.17908
G1 X122.869 Y83.758 E.00967
G1 X130.67 Y91.56 E.17971
G1 X130.105 Y91.56 E.00921
G1 X122.243 Y83.698 E.18111
G1 X122.178 Y83.691 E.00107
G3 X121.568 Y83.588 I.737 J-6.254 E.01008
G1 X129.54 Y91.56 E.18364
G1 X128.974 Y91.56 E.00921
G1 X120.826 Y83.411 E.18771
G1 X120.742 Y83.389 E.00141
G3 X119.965 Y83.116 I3.588 J-11.449 E.01342
G1 X128.409 Y91.56 E.19452
G1 X127.844 Y91.56 E.00921
G1 X107.821 Y71.537 E.46125
G1 X107.821 Y72.102 E.00921
G1 X127.278 Y91.56 E.44823
G1 X126.713 Y91.56 E.00921
G1 X107.821 Y72.668 E.4352
G1 X107.821 Y73.233 E.00921
G1 X126.147 Y91.56 E.42218
G1 X125.582 Y91.56 E.00921
G1 X107.821 Y73.798 E.40915
G1 X107.821 Y74.364 E.00921
G1 X125.017 Y91.56 E.39613
G1 X124.451 Y91.56 E.00921
G1 X107.821 Y74.929 E.3831
G1 X107.821 Y75.495 E.00921
G1 X123.886 Y91.56 E.37008
G1 X123.32 Y91.56 E.00921
G1 X107.821 Y76.06 E.35706
G1 X107.821 Y76.625 E.00921
G1 X122.755 Y91.56 E.34403
G1 X122.19 Y91.56 E.00921
G1 X107.821 Y77.191 E.33101
G1 X107.821 Y77.756 E.00921
G1 X121.624 Y91.56 E.31798
G1 X121.059 Y91.56 E.00921
G1 X107.821 Y78.321 E.30496
G1 X107.821 Y78.887 E.00921
G1 X120.493 Y91.56 E.29193
G1 X119.928 Y91.56 E.00921
G1 X107.821 Y79.452 E.27891
G1 X107.821 Y80.018 E.00921
G1 X119.363 Y91.56 E.26589
G1 X118.797 Y91.56 E.00921
G1 X107.821 Y80.583 E.25286
G1 X107.821 Y81.148 E.00921
G1 X118.232 Y91.56 E.23984
G1 X117.667 Y91.56 E.00921
G1 X107.821 Y81.714 E.22681
G1 X107.821 Y82.279 E.00921
G1 X117.101 Y91.56 E.21379
G1 X116.536 Y91.56 E.00921
G1 X107.821 Y82.845 E.20076
G1 X107.821 Y83.41 E.00921
G1 X115.97 Y91.56 E.18774
G1 X115.405 Y91.56 E.00921
G1 X107.821 Y83.975 E.17472
G1 X107.821 Y84.541 E.00921
G1 X114.84 Y91.56 E.16169
G1 X114.274 Y91.56 E.00921
G1 X107.821 Y85.106 E.14867
G1 X107.821 Y85.672 E.00921
G1 X113.709 Y91.56 E.13564
G1 X113.143 Y91.56 E.00921
G1 X107.821 Y86.237 E.12262
G1 X107.821 Y86.802 E.00921
G1 X112.578 Y91.56 E.10959
G1 X112.013 Y91.56 E.00921
G1 X107.821 Y87.368 E.09657
G1 X107.821 Y87.933 E.00921
G1 X111.447 Y91.56 E.08355
G1 X110.882 Y91.56 E.00921
G1 X107.821 Y88.498 E.07052
G1 X107.821 Y89.064 E.00921
G1 X110.316 Y91.56 E.0575
G1 X109.751 Y91.56 E.00921
G1 X107.641 Y89.45 E.0486
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X109.055 Y90.864 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 8/58
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.1 I1.216 J-.057 P1  F30000
G1 X107.471 Y56.87 Z1.1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 8 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer8 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.641 Y57.849 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X108.27 Y57.219 E.01447
G1 X108.835 Y57.219 E.00918
G1 X107.821 Y58.234 E.02333
G1 X107.821 Y58.798 E.00918
G1 X109.399 Y57.219 E.03631
G1 X109.964 Y57.219 E.00918
G1 X107.821 Y59.363 E.04929
G1 X107.821 Y59.927 E.00918
G1 X110.528 Y57.219 E.06228
G1 X111.093 Y57.219 E.00918
G1 X107.821 Y60.492 E.07526
M73 P42 R43
G1 X107.821 Y61.056 E.00918
G1 X111.657 Y57.219 E.08824
G1 X112.222 Y57.219 E.00918
G1 X107.821 Y61.621 E.10123
G1 X107.821 Y62.185 E.00918
G1 X112.786 Y57.219 E.11421
G1 X113.351 Y57.219 E.00918
G1 X107.821 Y62.75 E.12719
G1 X107.821 Y63.314 E.00918
G1 X113.915 Y57.219 E.14017
G1 X114.48 Y57.219 E.00918
G1 X107.821 Y63.879 E.15316
G1 X107.821 Y64.443 E.00918
G1 X115.044 Y57.219 E.16614
G1 X115.609 Y57.219 E.00918
G1 X107.821 Y65.008 E.17912
G1 X107.821 Y65.572 E.00918
G1 X116.173 Y57.219 E.1921
G1 X116.738 Y57.219 E.00918
G1 X107.821 Y66.137 E.20509
G1 X107.821 Y66.701 E.00918
G1 X117.302 Y57.219 E.21807
G1 X117.867 Y57.219 E.00918
G1 X107.821 Y67.265 E.23105
G1 X107.821 Y67.83 E.00918
G1 X118.431 Y57.219 E.24403
G1 X118.996 Y57.219 E.00918
G1 X107.821 Y68.394 E.25702
G1 X107.821 Y68.959 E.00918
G1 X119.56 Y57.219 E.27
G1 X120.125 Y57.219 E.00918
G1 X107.821 Y69.523 E.28298
G1 X107.821 Y70.088 E.00918
G1 X120.689 Y57.219 E.29596
G1 X121.254 Y57.219 E.00918
G1 X107.821 Y70.652 E.30895
G1 X107.821 Y71.217 E.00918
G1 X121.818 Y57.219 E.32193
G1 X122.383 Y57.219 E.00918
G1 X107.821 Y71.781 E.33491
G1 X107.821 Y72.346 E.00918
G1 X122.947 Y57.219 E.3479
G1 X123.512 Y57.219 E.00918
G1 X107.821 Y72.91 E.36088
G1 X107.821 Y73.475 E.00918
G1 X124.076 Y57.219 E.37386
G1 X124.641 Y57.219 E.00918
G1 X107.821 Y74.039 E.38684
G1 X107.821 Y74.604 E.00918
G1 X125.205 Y57.219 E.39983
G1 X125.769 Y57.219 E.00918
G1 X107.821 Y75.168 E.41281
G1 X107.821 Y75.733 E.00918
G1 X126.334 Y57.219 E.42579
G1 X126.898 Y57.219 E.00918
G1 X107.821 Y76.297 E.43877
G1 X107.821 Y76.862 E.00918
G1 X127.463 Y57.219 E.45176
G1 X128.027 Y57.219 E.00918
G1 X107.821 Y77.426 E.46474
G1 X107.821 Y77.991 E.00918
G1 X128.592 Y57.219 E.47772
G1 X129.156 Y57.219 E.00918
G1 X107.821 Y78.555 E.4907
G1 X107.821 Y79.12 E.00918
G1 X129.721 Y57.219 E.50369
G1 X130.285 Y57.219 E.00918
G1 X107.821 Y79.684 E.51667
G1 X107.821 Y80.249 E.00918
G1 X130.85 Y57.219 E.52965
G1 X131.414 Y57.219 E.00918
G1 X107.821 Y80.813 E.54263
G1 X107.821 Y81.378 E.00918
G1 X131.979 Y57.219 E.55562
G1 X132.543 Y57.219 E.00918
G1 X107.821 Y81.942 E.5686
G1 X107.821 Y82.507 E.00918
G1 X133.108 Y57.219 E.58158
G1 X133.672 Y57.219 E.00918
G1 X107.821 Y83.071 E.59457
G1 X107.821 Y83.636 E.00918
G1 X134.237 Y57.219 E.60755
G1 X134.801 Y57.219 E.00918
G1 X107.821 Y84.2 E.62053
G1 X107.821 Y84.764 E.00918
G1 X135.366 Y57.219 E.63351
G1 X135.93 Y57.219 E.00918
G1 X107.821 Y85.329 E.6465
G1 X107.821 Y85.893 E.00918
G1 X136.495 Y57.219 E.65948
G1 X137.059 Y57.219 E.00918
G1 X107.821 Y86.458 E.67246
G1 X107.821 Y87.022 E.00918
G1 X137.624 Y57.219 E.68544
G1 X138.188 Y57.219 E.00918
G1 X107.821 Y87.587 E.69843
G1 X107.821 Y88.151 E.00918
G1 X138.753 Y57.219 E.71141
G1 X139.317 Y57.219 E.00918
G1 X107.821 Y88.716 E.72439
G1 X107.821 Y89.28 E.00918
G1 X139.882 Y57.219 E.73737
G1 X140.446 Y57.219 E.00918
G1 X107.927 Y89.738 E.7479
G1 X108.209 Y90.02 E.00649
G1 X141.011 Y57.219 E.7544
G1 X141.575 Y57.219 E.00918
G1 X108.492 Y90.303 E.76089
G1 X108.774 Y90.585 E.00649
G1 X142.14 Y57.219 E.76738
G1 X142.704 Y57.219 E.00918
G1 X109.056 Y90.867 E.77387
G1 X109.338 Y91.149 E.00649
G1 X143.268 Y57.219 E.78036
G1 X143.833 Y57.219 E.00918
G1 X109.621 Y91.432 E.78685
G1 X109.749 Y91.56 E.00295
G1 X110.057 Y91.56 E.00501
G1 X144.397 Y57.219 E.7898
G1 X144.962 Y57.219 E.00918
G1 X110.622 Y91.56 E.7898
G1 X111.186 Y91.56 E.00918
G1 X145.526 Y57.219 E.7898
G1 X146.091 Y57.219 E.00918
G1 X111.751 Y91.56 E.7898
G1 X112.315 Y91.56 E.00918
G1 X146.655 Y57.219 E.7898
G1 X147.22 Y57.219 E.00918
G1 X112.879 Y91.56 E.7898
G1 X113.444 Y91.56 E.00918
G1 X147.784 Y57.219 E.7898
G1 X148.349 Y57.219 E.00918
G1 X114.008 Y91.56 E.7898
G1 X114.573 Y91.56 E.00918
G1 X148.913 Y57.219 E.7898
G1 X149.478 Y57.219 E.00918
G1 X115.137 Y91.56 E.7898
G1 X115.702 Y91.56 E.00918
G1 X150.042 Y57.219 E.7898
G1 X150.607 Y57.219 E.00918
G1 X116.266 Y91.56 E.7898
G1 X116.831 Y91.56 E.00918
G1 X151.171 Y57.219 E.7898
G1 X151.736 Y57.219 E.00918
G1 X117.395 Y91.56 E.7898
G1 X117.96 Y91.56 E.00918
G1 X152.3 Y57.219 E.7898
G1 X152.865 Y57.219 E.00918
G1 X118.524 Y91.56 E.7898
G1 X119.089 Y91.56 E.00918
G1 X153.429 Y57.219 E.7898
G1 X153.994 Y57.219 E.00918
G1 X119.653 Y91.56 E.7898
G1 X120.218 Y91.56 E.00918
G1 X154.558 Y57.219 E.7898
G1 X155.123 Y57.219 E.00918
G1 X120.782 Y91.56 E.7898
G1 X121.347 Y91.56 E.00918
G1 X155.687 Y57.219 E.7898
G1 X156.252 Y57.219 E.00918
G1 X121.911 Y91.56 E.7898
G1 X122.476 Y91.56 E.00918
G1 X156.816 Y57.219 E.7898
G1 X157.381 Y57.219 E.00918
G1 X123.04 Y91.56 E.7898
M73 P43 R43
G1 X123.605 Y91.56 E.00918
G1 X157.945 Y57.219 E.7898
G1 X158.51 Y57.219 E.00918
G1 X124.169 Y91.56 E.7898
G1 X124.734 Y91.56 E.00918
G1 X159.074 Y57.219 E.7898
G1 X159.638 Y57.219 E.00918
G1 X125.298 Y91.56 E.7898
G1 X125.863 Y91.56 E.00918
G1 X160.203 Y57.219 E.7898
G1 X160.767 Y57.219 E.00918
G1 X126.427 Y91.56 E.7898
G1 X126.992 Y91.56 E.00918
G1 X161.332 Y57.219 E.7898
G1 X161.896 Y57.219 E.00918
G1 X127.556 Y91.56 E.7898
G1 X128.121 Y91.56 E.00918
G1 X162.461 Y57.219 E.7898
G1 X163.025 Y57.219 E.00918
G1 X128.685 Y91.56 E.7898
G1 X129.25 Y91.56 E.00918
G1 X163.59 Y57.219 E.7898
G1 X164.154 Y57.219 E.00918
G1 X129.814 Y91.56 E.7898
G1 X130.378 Y91.56 E.00918
G1 X164.719 Y57.219 E.7898
G1 X165.283 Y57.219 E.00918
G1 X130.943 Y91.56 E.7898
G1 X131.507 Y91.56 E.00918
G1 X165.848 Y57.219 E.7898
G1 X166.412 Y57.219 E.00918
G1 X132.072 Y91.56 E.7898
G1 X132.636 Y91.56 E.00918
G1 X166.977 Y57.219 E.7898
G1 X167.541 Y57.219 E.00918
G1 X133.201 Y91.56 E.7898
G1 X133.765 Y91.56 E.00918
G1 X168.106 Y57.219 E.7898
G1 X168.67 Y57.219 E.00918
G1 X134.33 Y91.56 E.7898
G1 X134.894 Y91.56 E.00918
G1 X169.235 Y57.219 E.7898
G1 X169.799 Y57.219 E.00918
G1 X135.459 Y91.56 E.7898
G1 X136.023 Y91.56 E.00918
G1 X170.364 Y57.219 E.7898
G1 X170.928 Y57.219 E.00918
G1 X136.588 Y91.56 E.7898
G1 X137.152 Y91.56 E.00918
G1 X171.493 Y57.219 E.7898
G1 X172.057 Y57.219 E.00918
G1 X137.717 Y91.56 E.7898
G1 X138.281 Y91.56 E.00918
G1 X172.622 Y57.219 E.7898
G1 X173.186 Y57.219 E.00918
G1 X138.846 Y91.56 E.7898
G1 X139.41 Y91.56 E.00918
G1 X173.751 Y57.219 E.7898
G1 X174.315 Y57.219 E.00918
G1 X139.975 Y91.56 E.7898
G1 X140.539 Y91.56 E.00918
G1 X174.88 Y57.219 E.7898
G1 X175.444 Y57.219 E.00918
G1 X141.104 Y91.56 E.7898
G1 X141.668 Y91.56 E.00918
G1 X176.009 Y57.219 E.7898
G1 X176.573 Y57.219 E.00918
G1 X142.233 Y91.56 E.7898
G1 X142.797 Y91.56 E.00918
G1 X177.137 Y57.219 E.7898
G1 X177.702 Y57.219 E.00918
G1 X143.362 Y91.56 E.7898
G1 X143.926 Y91.56 E.00918
G1 X178.266 Y57.219 E.7898
G1 X178.831 Y57.219 E.00918
G1 X144.491 Y91.56 E.7898
G1 X145.055 Y91.56 E.00918
G1 X179.395 Y57.219 E.7898
G1 X179.96 Y57.219 E.00918
G1 X145.62 Y91.56 E.7898
G1 X146.184 Y91.56 E.00918
G1 X180.524 Y57.219 E.7898
G1 X181.089 Y57.219 E.00918
G1 X146.748 Y91.56 E.7898
G1 X147.313 Y91.56 E.00918
G1 X181.653 Y57.219 E.7898
G1 X182.218 Y57.219 E.00918
G1 X147.877 Y91.56 E.7898
G1 X148.442 Y91.56 E.00918
G1 X182.782 Y57.219 E.7898
G1 X183.347 Y57.219 E.00918
G1 X149.006 Y91.56 E.7898
G1 X149.571 Y91.56 E.00918
G1 X183.911 Y57.219 E.7898
G1 X184.476 Y57.219 E.00918
G1 X150.135 Y91.56 E.7898
G1 X150.7 Y91.56 E.00918
G1 X185.04 Y57.219 E.7898
G1 X185.605 Y57.219 E.00918
G1 X151.264 Y91.56 E.7898
G1 X151.829 Y91.56 E.00918
G1 X186.169 Y57.219 E.7898
G1 X186.734 Y57.219 E.00918
G1 X152.393 Y91.56 E.7898
G1 X152.958 Y91.56 E.00918
G1 X187.298 Y57.219 E.7898
G1 X187.863 Y57.219 E.00918
M73 P43 R42
G1 X153.522 Y91.56 E.7898
G1 X154.087 Y91.56 E.00918
G1 X188.427 Y57.219 E.7898
G1 X188.992 Y57.219 E.00918
G1 X154.651 Y91.56 E.7898
G1 X155.216 Y91.56 E.00918
G1 X189.556 Y57.219 E.7898
G1 X190.121 Y57.219 E.00918
G1 X155.78 Y91.56 E.7898
G1 X156.345 Y91.56 E.00918
G1 X190.685 Y57.219 E.7898
G1 X191.25 Y57.219 E.00918
G1 X156.909 Y91.56 E.7898
G1 X157.474 Y91.56 E.00918
G1 X191.814 Y57.219 E.7898
G1 X192.379 Y57.219 E.00918
G1 X158.038 Y91.56 E.7898
G1 X158.603 Y91.56 E.00918
G1 X192.943 Y57.219 E.7898
G1 X193.507 Y57.219 E.00918
G1 X159.167 Y91.56 E.7898
G1 X159.732 Y91.56 E.00918
G1 X194.072 Y57.219 E.7898
G1 X194.636 Y57.219 E.00918
G1 X160.296 Y91.56 E.7898
G1 X160.861 Y91.56 E.00918
G1 X195.201 Y57.219 E.7898
G1 X195.765 Y57.219 E.00918
G1 X161.425 Y91.56 E.7898
G1 X161.99 Y91.56 E.00918
G1 X196.33 Y57.219 E.7898
G1 X196.894 Y57.219 E.00918
G1 X162.554 Y91.56 E.7898
G1 X163.119 Y91.56 E.00918
G1 X197.459 Y57.219 E.7898
G1 X198.023 Y57.219 E.00918
G1 X163.683 Y91.56 E.7898
G1 X164.247 Y91.56 E.00918
G1 X198.588 Y57.219 E.7898
G1 X199.152 Y57.219 E.00918
G1 X164.812 Y91.56 E.7898
G1 X165.376 Y91.56 E.00918
G1 X199.717 Y57.219 E.7898
G1 X200.281 Y57.219 E.00918
G1 X165.941 Y91.56 E.7898
G1 X166.505 Y91.56 E.00918
G1 X200.846 Y57.219 E.7898
G1 X201.41 Y57.219 E.00918
G1 X167.07 Y91.56 E.7898
G1 X167.634 Y91.56 E.00918
G1 X201.975 Y57.219 E.7898
G1 X202.539 Y57.219 E.00918
G1 X168.199 Y91.56 E.7898
G1 X168.763 Y91.56 E.00918
M73 P44 R42
G1 X203.104 Y57.219 E.7898
G1 X203.668 Y57.219 E.00918
G1 X169.328 Y91.56 E.7898
G1 X169.892 Y91.56 E.00918
G1 X204.233 Y57.219 E.7898
G1 X204.797 Y57.219 E.00918
G1 X170.457 Y91.56 E.7898
G1 X171.021 Y91.56 E.00918
G1 X205.362 Y57.219 E.7898
G1 X205.926 Y57.219 E.00918
G1 X171.586 Y91.56 E.7898
G1 X172.15 Y91.56 E.00918
G1 X206.491 Y57.219 E.7898
G1 X207.055 Y57.219 E.00918
G1 X172.715 Y91.56 E.7898
G1 X173.279 Y91.56 E.00918
G1 X207.62 Y57.219 E.7898
G1 X208.161 Y57.219 E.0088
G1 X208.161 Y57.242 E.00038
G1 X173.844 Y91.56 E.78927
G1 X174.408 Y91.56 E.00918
G1 X208.161 Y57.807 E.77628
G1 X208.161 Y58.371 E.00918
G1 X174.973 Y91.56 E.7633
G1 X175.537 Y91.56 E.00918
G1 X208.161 Y58.936 E.75032
G1 X208.161 Y59.5 E.00918
G1 X176.102 Y91.56 E.73734
G1 X176.666 Y91.56 E.00918
G1 X208.161 Y60.065 E.72435
G1 X208.161 Y60.629 E.00918
G1 X177.231 Y91.56 E.71137
G1 X177.795 Y91.56 E.00918
G1 X208.161 Y61.194 E.69839
G1 X208.161 Y61.758 E.00918
G1 X178.36 Y91.56 E.68541
G1 X178.924 Y91.56 E.00918
G1 X208.161 Y62.323 E.67242
G1 X208.161 Y62.887 E.00918
G1 X179.489 Y91.56 E.65944
G1 X180.053 Y91.56 E.00918
G1 X208.161 Y63.452 E.64646
G1 X208.161 Y64.016 E.00918
G1 X180.617 Y91.56 E.63348
G1 X181.182 Y91.56 E.00918
G1 X208.161 Y64.581 E.62049
G1 X208.161 Y65.145 E.00918
G1 X181.746 Y91.56 E.60751
G1 X182.311 Y91.56 E.00918
G1 X208.161 Y65.71 E.59453
G1 X208.161 Y66.274 E.00918
G1 X182.875 Y91.56 E.58155
G1 X183.44 Y91.56 E.00918
G1 X208.161 Y66.839 E.56856
G1 X208.161 Y67.403 E.00918
G1 X184.004 Y91.56 E.55558
G1 X184.569 Y91.56 E.00918
G1 X208.161 Y67.968 E.5426
G1 X208.161 Y68.532 E.00918
G1 X185.133 Y91.56 E.52961
G1 X185.698 Y91.56 E.00918
G1 X208.161 Y69.097 E.51663
G1 X208.161 Y69.661 E.00918
G1 X186.262 Y91.56 E.50365
G1 X186.827 Y91.56 E.00918
G1 X208.161 Y70.226 E.49067
G1 X208.161 Y70.79 E.00918
G1 X187.391 Y91.56 E.47768
G1 X187.956 Y91.56 E.00918
G1 X208.161 Y71.355 E.4647
G1 X208.161 Y71.919 E.00918
G1 X188.52 Y91.56 E.45172
G1 X189.085 Y91.56 E.00918
G1 X208.161 Y72.484 E.43874
G1 X208.161 Y73.048 E.00918
G1 X189.649 Y91.56 E.42575
G1 X190.214 Y91.56 E.00918
G1 X208.161 Y73.612 E.41277
G1 X208.161 Y74.177 E.00918
G1 X190.778 Y91.56 E.39979
G1 X191.343 Y91.56 E.00918
G1 X208.161 Y74.741 E.38681
G1 X208.161 Y75.306 E.00918
G1 X191.907 Y91.56 E.37382
G1 X192.472 Y91.56 E.00918
G1 X208.161 Y75.87 E.36084
G1 X208.161 Y76.435 E.00918
G1 X193.036 Y91.56 E.34786
G1 X193.601 Y91.56 E.00918
G1 X208.161 Y76.999 E.33488
G1 X208.161 Y77.564 E.00918
G1 X194.165 Y91.56 E.32189
G1 X194.73 Y91.56 E.00918
G1 X208.161 Y78.128 E.30891
G1 X208.161 Y78.693 E.00918
G1 X195.294 Y91.56 E.29593
G1 X195.859 Y91.56 E.00918
G1 X208.161 Y79.257 E.28294
G1 X208.161 Y79.822 E.00918
G1 X196.423 Y91.56 E.26996
G1 X196.988 Y91.56 E.00918
G1 X208.161 Y80.386 E.25698
G1 X208.161 Y80.951 E.00918
G1 X197.552 Y91.56 E.244
G1 X198.116 Y91.56 E.00918
G1 X208.161 Y81.515 E.23101
G1 X208.161 Y82.08 E.00918
G1 X198.681 Y91.56 E.21803
G1 X199.245 Y91.56 E.00918
G1 X208.161 Y82.644 E.20505
G1 X208.161 Y83.209 E.00918
G1 X199.81 Y91.56 E.19207
G1 X200.374 Y91.56 E.00918
G1 X208.161 Y83.773 E.17908
G1 X208.161 Y84.338 E.00918
G1 X200.939 Y91.56 E.1661
G1 X201.503 Y91.56 E.00918
G1 X208.161 Y84.902 E.15312
G1 X208.161 Y85.467 E.00918
G1 X202.068 Y91.56 E.14014
G1 X202.632 Y91.56 E.00918
G1 X208.161 Y86.031 E.12715
G1 X208.161 Y86.596 E.00918
G1 X203.197 Y91.56 E.11417
G1 X203.761 Y91.56 E.00918
G1 X208.161 Y87.16 E.10119
G1 X208.161 Y87.725 E.00918
G1 X204.326 Y91.56 E.08821
G1 X204.89 Y91.56 E.00918
G1 X208.161 Y88.289 E.07522
G1 X208.161 Y88.854 E.00918
G1 X205.455 Y91.56 E.06224
G1 X206.019 Y91.56 E.00918
G1 X208.161 Y89.418 E.04926
G1 X208.161 Y89.983 E.00918
G1 X206.584 Y91.56 E.03627
G1 X207.148 Y91.56 E.00918
G1 X208.161 Y90.547 E.02329
G1 X208.161 Y91.111 E.00918
G1 X207.533 Y91.739 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 0.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X208.161 Y91.111 E-.33727
G1 X208.161 Y90.547 E-.21451
G1 X207.774 Y90.934 E-.20822
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 9/58
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I.391 J-1.152 P1  F30000
G1 X107.471 Y56.87 Z1.2
G1 Z.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
M73 P44 R41
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
M73 P45 R41
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 9 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer9 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.074 Y63.29 Z1.3 F30000
G1 X107.641 Y89.45 Z1.3
G1 Z.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X109.751 Y91.56 E.0486
G1 X110.316 Y91.56 E.00921
G1 X107.821 Y89.064 E.05749
G1 X107.821 Y88.499 E.00921
G1 X110.882 Y91.56 E.07051
G1 X111.447 Y91.56 E.00921
G1 X107.821 Y87.933 E.08354
G1 X107.821 Y87.368 E.00921
G1 X112.012 Y91.56 E.09656
G1 X112.578 Y91.56 E.00921
G1 X107.821 Y86.803 E.10959
G1 X107.821 Y86.237 E.00921
G1 X113.143 Y91.56 E.12261
G1 X113.709 Y91.56 E.00921
G1 X107.821 Y85.672 E.13563
G1 X107.821 Y85.106 E.00921
G1 X114.274 Y91.56 E.14866
G1 X114.839 Y91.56 E.00921
G1 X107.821 Y84.541 E.16168
G1 X107.821 Y83.976 E.00921
G1 X115.405 Y91.56 E.17471
G1 X115.97 Y91.56 E.00921
G1 X107.821 Y83.41 E.18773
G1 X107.821 Y82.845 E.00921
G1 X116.535 Y91.56 E.20076
G1 X117.101 Y91.56 E.00921
G1 X107.821 Y82.28 E.21378
G1 X107.821 Y81.714 E.00921
G1 X117.666 Y91.56 E.2268
G1 X118.232 Y91.56 E.00921
G1 X107.821 Y81.149 E.23983
G1 X107.821 Y80.583 E.00921
G1 X118.797 Y91.56 E.25285
G1 X119.362 Y91.56 E.00921
G1 X107.821 Y80.018 E.26588
G1 X107.821 Y79.453 E.00921
G1 X119.928 Y91.56 E.2789
G1 X120.493 Y91.56 E.00921
G1 X107.821 Y78.887 E.29193
G1 X107.821 Y78.322 E.00921
G1 X121.059 Y91.56 E.30495
G1 X121.624 Y91.56 E.00921
G1 X107.821 Y77.756 E.31797
G1 X107.821 Y77.191 E.00921
G1 X122.189 Y91.56 E.331
G1 X122.755 Y91.56 E.00921
G1 X107.821 Y76.626 E.34402
G1 X107.821 Y76.06 E.00921
G1 X123.32 Y91.56 E.35705
G1 X123.886 Y91.56 E.00921
G1 X107.821 Y75.495 E.37007
G1 X107.821 Y74.929 E.00921
G1 X124.451 Y91.56 E.3831
G1 X125.016 Y91.56 E.00921
G1 X107.821 Y74.364 E.39612
G1 X107.821 Y73.799 E.00921
G1 X125.582 Y91.56 E.40914
G1 X126.147 Y91.56 E.00921
G1 X107.821 Y73.233 E.42217
G1 X107.821 Y72.668 E.00921
G1 X126.712 Y91.56 E.43519
G1 X127.278 Y91.56 E.00921
G1 X107.821 Y72.103 E.44822
G1 X107.821 Y71.537 E.00921
G1 X127.843 Y91.56 E.46124
G1 X128.409 Y91.56 E.00921
G1 X107.821 Y70.972 E.47427
G1 X107.821 Y70.406 E.00921
G1 X128.974 Y91.56 E.48729
G1 X129.539 Y91.56 E.00921
G1 X107.821 Y69.841 E.50031
G1 X107.821 Y69.276 E.00921
G1 X130.105 Y91.56 E.51334
G1 X130.67 Y91.56 E.00921
G1 X107.821 Y68.71 E.52636
G1 X107.821 Y68.145 E.00921
G1 X131.236 Y91.56 E.53939
G1 X131.801 Y91.56 E.00921
G1 X107.821 Y67.579 E.55241
G1 X107.821 Y67.014 E.00921
G1 X132.366 Y91.56 E.56544
G1 X132.932 Y91.56 E.00921
G1 X107.821 Y66.449 E.57846
G1 X107.821 Y65.883 E.00921
G1 X133.497 Y91.56 E.59148
G1 X134.063 Y91.56 E.00921
G1 X107.821 Y65.318 E.60451
G1 X107.821 Y64.752 E.00921
G1 X134.628 Y91.56 E.61753
G1 X135.193 Y91.56 E.00921
G1 X107.821 Y64.187 E.63056
G1 X107.821 Y63.622 E.00921
G1 X135.759 Y91.56 E.64358
G1 X136.324 Y91.56 E.00921
G1 X107.821 Y63.056 E.65661
G1 X107.821 Y62.491 E.00921
G1 X136.889 Y91.56 E.66963
G1 X137.455 Y91.56 E.00921
G1 X107.821 Y61.926 E.68265
G1 X107.821 Y61.36 E.00921
G1 X138.02 Y91.56 E.69568
G1 X138.586 Y91.56 E.00921
G1 X107.821 Y60.795 E.7087
G1 X107.821 Y60.229 E.00921
G1 X139.151 Y91.56 E.72173
G1 X139.716 Y91.56 E.00921
G1 X107.821 Y59.664 E.73475
G1 X107.821 Y59.099 E.00921
G1 X140.282 Y91.56 E.74778
G1 X140.847 Y91.56 E.00921
G1 X107.821 Y58.533 E.7608
G1 X107.821 Y57.968 E.00921
G1 X141.413 Y91.56 E.77382
G1 X141.978 Y91.56 E.00921
G1 X107.821 Y57.402 E.78685
G1 X107.821 Y57.219 E.00298
G1 X108.203 Y57.219 E.00623
G1 X142.543 Y91.56 E.79106
G1 X143.109 Y91.56 E.00921
G1 X108.768 Y57.219 E.79106
G1 X109.334 Y57.219 E.00921
G1 X143.674 Y91.56 E.79106
G1 X144.239 Y91.56 E.00921
G1 X109.899 Y57.219 E.79106
G1 X110.465 Y57.219 E.00921
G1 X144.805 Y91.56 E.79106
G1 X145.37 Y91.56 E.00921
G1 X111.03 Y57.219 E.79106
G1 X111.595 Y57.219 E.00921
G1 X145.936 Y91.56 E.79106
G1 X146.501 Y91.56 E.00921
G1 X112.161 Y57.219 E.79106
G1 X112.726 Y57.219 E.00921
G1 X147.066 Y91.56 E.79106
G1 X147.632 Y91.56 E.00921
G1 X113.291 Y57.219 E.79106
G1 X113.857 Y57.219 E.00921
G1 X148.197 Y91.56 E.79106
G1 X148.763 Y91.56 E.00921
G1 X114.422 Y57.219 E.79106
G1 X114.988 Y57.219 E.00921
G1 X149.328 Y91.56 E.79106
G1 X149.893 Y91.56 E.00921
G1 X115.553 Y57.219 E.79106
G1 X116.118 Y57.219 E.00921
G1 X150.459 Y91.56 E.79106
G1 X151.024 Y91.56 E.00921
G1 X116.684 Y57.219 E.79106
G1 X117.249 Y57.219 E.00921
G1 X151.59 Y91.56 E.79106
G1 X152.155 Y91.56 E.00921
G1 X117.815 Y57.219 E.79106
G1 X118.38 Y57.219 E.00921
G1 X152.72 Y91.56 E.79106
G1 X153.286 Y91.56 E.00921
G1 X118.945 Y57.219 E.79106
G1 X119.511 Y57.219 E.00921
G1 X153.851 Y91.56 E.79106
G1 X154.416 Y91.56 E.00921
G1 X120.076 Y57.219 E.79106
G1 X120.642 Y57.219 E.00921
G1 X154.982 Y91.56 E.79106
G1 X155.547 Y91.56 E.00921
G1 X121.207 Y57.219 E.79106
G1 X121.772 Y57.219 E.00921
G1 X156.113 Y91.56 E.79106
G1 X156.678 Y91.56 E.00921
G1 X122.338 Y57.219 E.79106
G1 X122.903 Y57.219 E.00921
G1 X157.243 Y91.56 E.79106
G1 X157.809 Y91.56 E.00921
G1 X123.468 Y57.219 E.79106
G1 X124.034 Y57.219 E.00921
G1 X158.374 Y91.56 E.79106
G1 X158.94 Y91.56 E.00921
G1 X124.599 Y57.219 E.79106
G1 X125.165 Y57.219 E.00921
G1 X159.505 Y91.56 E.79106
G1 X160.07 Y91.56 E.00921
G1 X125.73 Y57.219 E.79106
G1 X126.295 Y57.219 E.00921
G1 X160.636 Y91.56 E.79106
G1 X161.201 Y91.56 E.00921
G1 X126.861 Y57.219 E.79106
G1 X127.426 Y57.219 E.00921
G1 X161.767 Y91.56 E.79106
G1 X162.332 Y91.56 E.00921
G1 X127.992 Y57.219 E.79106
G1 X128.557 Y57.219 E.00921
G1 X162.897 Y91.56 E.79106
G1 X163.463 Y91.56 E.00921
G1 X129.122 Y57.219 E.79106
G1 X129.688 Y57.219 E.00921
G1 X164.028 Y91.56 E.79106
G1 X164.593 Y91.56 E.00921
G1 X130.253 Y57.219 E.79106
G1 X130.819 Y57.219 E.00921
G1 X165.159 Y91.56 E.79106
G1 X165.724 Y91.56 E.00921
G1 X131.384 Y57.219 E.79106
G1 X131.949 Y57.219 E.00921
G1 X166.29 Y91.56 E.79106
G1 X166.855 Y91.56 E.00921
G1 X132.515 Y57.219 E.79106
G1 X133.08 Y57.219 E.00921
G1 X167.42 Y91.56 E.79106
G1 X167.986 Y91.56 E.00921
G1 X133.645 Y57.219 E.79106
G1 X134.211 Y57.219 E.00921
G1 X168.551 Y91.56 E.79106
G1 X169.117 Y91.56 E.00921
G1 X134.776 Y57.219 E.79106
M73 P46 R41
G1 X135.342 Y57.219 E.00921
G1 X169.682 Y91.56 E.79106
G1 X170.247 Y91.56 E.00921
G1 X135.907 Y57.219 E.79106
G1 X136.472 Y57.219 E.00921
G1 X170.813 Y91.56 E.79106
G1 X171.378 Y91.56 E.00921
G1 X137.038 Y57.219 E.79106
G1 X137.603 Y57.219 E.00921
G1 X171.944 Y91.56 E.79106
G1 X172.509 Y91.56 E.00921
G1 X138.169 Y57.219 E.79106
G1 X138.734 Y57.219 E.00921
G1 X173.074 Y91.56 E.79106
G1 X173.64 Y91.56 E.00921
G1 X139.299 Y57.219 E.79106
G1 X139.865 Y57.219 E.00921
G1 X174.205 Y91.56 E.79106
G1 X174.77 Y91.56 E.00921
G1 X140.43 Y57.219 E.79106
G1 X140.996 Y57.219 E.00921
G1 X175.336 Y91.56 E.79106
G1 X175.901 Y91.56 E.00921
G1 X141.561 Y57.219 E.79106
G1 X142.126 Y57.219 E.00921
G1 X176.467 Y91.56 E.79106
G1 X177.032 Y91.56 E.00921
G1 X142.692 Y57.219 E.79106
G1 X143.257 Y57.219 E.00921
G1 X177.597 Y91.56 E.79106
G1 X178.163 Y91.56 E.00921
G1 X143.822 Y57.219 E.79106
G1 X144.388 Y57.219 E.00921
G1 X178.728 Y91.56 E.79106
G1 X179.294 Y91.56 E.00921
G1 X144.953 Y57.219 E.79106
G1 X145.519 Y57.219 E.00921
G1 X179.859 Y91.56 E.79106
G1 X180.424 Y91.56 E.00921
G1 X146.084 Y57.219 E.79106
G1 X146.649 Y57.219 E.00921
M73 P46 R40
G1 X180.99 Y91.56 E.79106
G1 X181.555 Y91.56 E.00921
G1 X147.215 Y57.219 E.79106
G1 X147.78 Y57.219 E.00921
G1 X182.121 Y91.56 E.79106
G1 X182.686 Y91.56 E.00921
G1 X148.346 Y57.219 E.79106
G1 X148.911 Y57.219 E.00921
G1 X183.251 Y91.56 E.79106
G1 X183.817 Y91.56 E.00921
G1 X149.476 Y57.219 E.79106
G1 X150.042 Y57.219 E.00921
G1 X184.382 Y91.56 E.79106
G1 X184.947 Y91.56 E.00921
G1 X150.607 Y57.219 E.79106
G1 X151.172 Y57.219 E.00921
G1 X185.513 Y91.56 E.79106
G1 X186.078 Y91.56 E.00921
G1 X151.738 Y57.219 E.79106
G1 X152.303 Y57.219 E.00921
G1 X186.644 Y91.56 E.79106
G1 X187.209 Y91.56 E.00921
G1 X152.869 Y57.219 E.79106
G1 X153.434 Y57.219 E.00921
G1 X187.774 Y91.56 E.79106
G1 X188.34 Y91.56 E.00921
G1 X153.999 Y57.219 E.79106
G1 X154.565 Y57.219 E.00921
G1 X188.905 Y91.56 E.79106
G1 X189.471 Y91.56 E.00921
G1 X155.13 Y57.219 E.79106
G1 X155.696 Y57.219 E.00921
G1 X190.036 Y91.56 E.79106
G1 X190.601 Y91.56 E.00921
G1 X156.261 Y57.219 E.79106
G1 X156.826 Y57.219 E.00921
G1 X191.167 Y91.56 E.79106
G1 X191.732 Y91.56 E.00921
G1 X157.392 Y57.219 E.79106
G1 X157.957 Y57.219 E.00921
G1 X192.298 Y91.56 E.79106
G1 X192.863 Y91.56 E.00921
G1 X158.523 Y57.219 E.79106
G1 X159.088 Y57.219 E.00921
G1 X193.428 Y91.56 E.79106
G1 X193.994 Y91.56 E.00921
G1 X159.653 Y57.219 E.79106
G1 X160.219 Y57.219 E.00921
G1 X194.559 Y91.56 E.79106
G1 X195.124 Y91.56 E.00921
G1 X160.784 Y57.219 E.79106
G1 X161.349 Y57.219 E.00921
G1 X195.69 Y91.56 E.79106
G1 X196.255 Y91.56 E.00921
G1 X161.915 Y57.219 E.79106
G1 X162.48 Y57.219 E.00921
G1 X196.821 Y91.56 E.79106
G1 X197.386 Y91.56 E.00921
G1 X163.046 Y57.219 E.79106
G1 X163.611 Y57.219 E.00921
G1 X197.951 Y91.56 E.79106
G1 X198.517 Y91.56 E.00921
G1 X164.176 Y57.219 E.79106
G1 X164.742 Y57.219 E.00921
G1 X199.082 Y91.56 E.79106
G1 X199.648 Y91.56 E.00921
G1 X165.307 Y57.219 E.79106
G1 X165.873 Y57.219 E.00921
G1 X200.213 Y91.56 E.79106
G1 X200.778 Y91.56 E.00921
G1 X166.438 Y57.219 E.79106
G1 X167.003 Y57.219 E.00921
G1 X201.344 Y91.56 E.79106
G1 X201.909 Y91.56 E.00921
G1 X167.569 Y57.219 E.79106
G1 X168.134 Y57.219 E.00921
G1 X202.475 Y91.56 E.79106
G1 X203.04 Y91.56 E.00921
G1 X168.7 Y57.219 E.79106
G1 X169.265 Y57.219 E.00921
G1 X203.605 Y91.56 E.79106
G1 X204.171 Y91.56 E.00921
G1 X169.83 Y57.219 E.79106
G1 X170.396 Y57.219 E.00921
G1 X204.736 Y91.56 E.79106
G1 X205.301 Y91.56 E.00921
G1 X170.961 Y57.219 E.79106
G1 X171.526 Y57.219 E.00921
G1 X205.867 Y91.56 E.79106
G1 X206.432 Y91.56 E.00921
G1 X172.092 Y57.219 E.79106
G1 X172.657 Y57.219 E.00921
G1 X206.998 Y91.56 E.79106
G1 X207.563 Y91.56 E.00921
G1 X173.223 Y57.219 E.79106
G1 X173.788 Y57.219 E.00921
G1 X208.128 Y91.56 E.79106
G1 X208.161 Y91.56 E.00053
G1 X208.161 Y91.027 E.00868
G1 X174.353 Y57.219 E.77879
G1 X174.919 Y57.219 E.00921
G1 X208.161 Y90.462 E.76577
G1 X208.161 Y89.896 E.00921
G1 X175.484 Y57.219 E.75274
G1 X176.05 Y57.219 E.00921
G1 X208.161 Y89.331 E.73972
G1 X208.161 Y88.765 E.00921
G1 X176.615 Y57.219 E.72669
G1 X177.18 Y57.219 E.00921
G1 X208.161 Y88.2 E.71367
G1 X208.161 Y87.635 E.00921
G1 X177.746 Y57.219 E.70064
M73 P47 R40
G1 X178.311 Y57.219 E.00921
G1 X208.161 Y87.069 E.68762
G1 X208.161 Y86.504 E.00921
G1 X178.877 Y57.219 E.6746
G1 X179.442 Y57.219 E.00921
G1 X208.161 Y85.938 E.66157
G1 X208.161 Y85.373 E.00921
G1 X180.007 Y57.219 E.64855
G1 X180.573 Y57.219 E.00921
G1 X208.161 Y84.808 E.63552
G1 X208.161 Y84.242 E.00921
G1 X181.138 Y57.219 E.6225
G1 X181.703 Y57.219 E.00921
G1 X208.161 Y83.677 E.60947
G1 X208.161 Y83.111 E.00921
G1 X182.269 Y57.219 E.59645
G1 X182.834 Y57.219 E.00921
G1 X208.161 Y82.546 E.58343
G1 X208.161 Y81.981 E.00921
G1 X183.4 Y57.219 E.5704
G1 X183.965 Y57.219 E.00921
G1 X208.161 Y81.415 E.55738
G1 X208.161 Y80.85 E.00921
G1 X184.53 Y57.219 E.54435
G1 X185.096 Y57.219 E.00921
G1 X208.161 Y80.285 E.53133
G1 X208.161 Y79.719 E.00921
G1 X185.661 Y57.219 E.5183
G1 X186.227 Y57.219 E.00921
G1 X208.161 Y79.154 E.50528
G1 X208.161 Y78.588 E.00921
G1 X186.792 Y57.219 E.49226
G1 X187.357 Y57.219 E.00921
G1 X208.161 Y78.023 E.47923
G1 X208.161 Y77.458 E.00921
G1 X187.923 Y57.219 E.46621
G1 X188.488 Y57.219 E.00921
G1 X208.161 Y76.892 E.45318
G1 X208.161 Y76.327 E.00921
G1 X189.054 Y57.219 E.44016
G1 X189.619 Y57.219 E.00921
G1 X208.161 Y75.761 E.42713
G1 X208.161 Y75.196 E.00921
G1 X190.184 Y57.219 E.41411
G1 X190.75 Y57.219 E.00921
G1 X208.161 Y74.631 E.40109
G1 X208.161 Y74.065 E.00921
G1 X191.315 Y57.219 E.38806
G1 X191.88 Y57.219 E.00921
G1 X208.161 Y73.5 E.37504
G1 X208.161 Y72.934 E.00921
G1 X192.446 Y57.219 E.36201
G1 X193.011 Y57.219 E.00921
G1 X208.161 Y72.369 E.34899
G1 X208.161 Y71.804 E.00921
G1 X193.577 Y57.219 E.33596
G1 X194.142 Y57.219 E.00921
G1 X208.161 Y71.238 E.32294
G1 X208.161 Y70.673 E.00921
G1 X194.707 Y57.219 E.30992
G1 X195.273 Y57.219 E.00921
G1 X208.161 Y70.108 E.29689
G1 X208.161 Y69.542 E.00921
G1 X195.838 Y57.219 E.28387
G1 X196.404 Y57.219 E.00921
G1 X208.161 Y68.977 E.27084
G1 X208.161 Y68.411 E.00921
G1 X196.969 Y57.219 E.25782
G1 X197.534 Y57.219 E.00921
G1 X208.161 Y67.846 E.24479
G1 X208.161 Y67.281 E.00921
G1 X198.1 Y57.219 E.23177
G1 X198.665 Y57.219 E.00921
G1 X208.161 Y66.715 E.21875
G1 X208.161 Y66.15 E.00921
G1 X199.231 Y57.219 E.20572
G1 X199.796 Y57.219 E.00921
G1 X208.161 Y65.584 E.1927
G1 X208.161 Y65.019 E.00921
G1 X200.361 Y57.219 E.17967
G1 X200.927 Y57.219 E.00921
G1 X208.161 Y64.454 E.16665
G1 X208.161 Y63.888 E.00921
G1 X201.492 Y57.219 E.15362
G1 X202.057 Y57.219 E.00921
G1 X208.161 Y63.323 E.1406
G1 X208.161 Y62.758 E.00921
G1 X202.623 Y57.219 E.12758
G1 X203.188 Y57.219 E.00921
G1 X208.161 Y62.192 E.11455
G1 X208.161 Y61.627 E.00921
M73 P47 R39
G1 X203.754 Y57.219 E.10153
G1 X204.319 Y57.219 E.00921
G1 X208.161 Y61.061 E.0885
G1 X208.161 Y60.496 E.00921
G1 X204.884 Y57.219 E.07548
G1 X205.45 Y57.219 E.00921
G1 X208.161 Y59.931 E.06245
G1 X208.161 Y59.365 E.00921
G1 X206.015 Y57.219 E.04943
G1 X206.581 Y57.219 E.00921
G1 X208.161 Y58.8 E.03641
G1 X208.161 Y58.234 E.00921
G1 X207.146 Y57.219 E.02338
G1 X207.711 Y57.219 E.00921
G1 X208.34 Y57.848 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X207.711 Y57.219 E-.338
G1 X207.146 Y57.219 E-.21485
G1 X207.531 Y57.605 E-.20715
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 10/58
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.3 I.009 J-1.217 P1  F30000
G1 X107.471 Y56.87 Z1.3
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 10 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer10 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.641 Y57.849 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X108.27 Y57.219 E.01447
G1 X108.835 Y57.219 E.00918
G1 X107.821 Y58.234 E.02333
G1 X107.821 Y58.798 E.00918
G1 X109.399 Y57.219 E.03631
G1 X109.964 Y57.219 E.00918
G1 X107.821 Y59.363 E.04929
G1 X107.821 Y59.927 E.00918
G1 X110.528 Y57.219 E.06228
G1 X111.093 Y57.219 E.00918
G1 X107.821 Y60.492 E.07526
G1 X107.821 Y61.056 E.00918
G1 X111.657 Y57.219 E.08824
G1 X112.222 Y57.219 E.00918
G1 X107.821 Y61.621 E.10123
G1 X107.821 Y62.185 E.00918
G1 X112.786 Y57.219 E.11421
G1 X113.351 Y57.219 E.00918
G1 X107.821 Y62.75 E.12719
G1 X107.821 Y63.314 E.00918
G1 X113.915 Y57.219 E.14017
G1 X114.48 Y57.219 E.00918
G1 X107.821 Y63.879 E.15316
G1 X107.821 Y64.443 E.00918
G1 X115.044 Y57.219 E.16614
G1 X115.609 Y57.219 E.00918
G1 X107.821 Y65.008 E.17912
G1 X107.821 Y65.572 E.00918
G1 X116.173 Y57.219 E.1921
G1 X116.738 Y57.219 E.00918
G1 X107.821 Y66.137 E.20509
G1 X107.821 Y66.701 E.00918
G1 X117.302 Y57.219 E.21807
G1 X117.867 Y57.219 E.00918
G1 X107.821 Y67.265 E.23105
G1 X107.821 Y67.83 E.00918
G1 X118.431 Y57.219 E.24403
G1 X118.996 Y57.219 E.00918
G1 X107.821 Y68.394 E.25702
G1 X107.821 Y68.959 E.00918
G1 X119.56 Y57.219 E.27
G1 X120.125 Y57.219 E.00918
G1 X107.821 Y69.523 E.28298
G1 X107.821 Y70.088 E.00918
G1 X120.689 Y57.219 E.29596
G1 X121.254 Y57.219 E.00918
G1 X107.821 Y70.652 E.30895
G1 X107.821 Y71.217 E.00918
G1 X121.818 Y57.219 E.32193
G1 X122.383 Y57.219 E.00918
G1 X107.821 Y71.781 E.33491
G1 X107.821 Y72.346 E.00918
G1 X122.947 Y57.219 E.3479
G1 X123.512 Y57.219 E.00918
G1 X107.821 Y72.91 E.36088
G1 X107.821 Y73.475 E.00918
G1 X124.076 Y57.219 E.37386
G1 X124.641 Y57.219 E.00918
M73 P48 R39
G1 X107.821 Y74.039 E.38684
G1 X107.821 Y74.604 E.00918
G1 X125.205 Y57.219 E.39983
G1 X125.769 Y57.219 E.00918
G1 X107.821 Y75.168 E.41281
G1 X107.821 Y75.733 E.00918
G1 X126.334 Y57.219 E.42579
G1 X126.898 Y57.219 E.00918
G1 X107.821 Y76.297 E.43877
G1 X107.821 Y76.862 E.00918
G1 X127.463 Y57.219 E.45176
G1 X128.027 Y57.219 E.00918
G1 X107.821 Y77.426 E.46474
G1 X107.821 Y77.991 E.00918
G1 X128.592 Y57.219 E.47772
G1 X129.156 Y57.219 E.00918
G1 X107.821 Y78.555 E.4907
G1 X107.821 Y79.12 E.00918
G1 X129.721 Y57.219 E.50369
G1 X130.285 Y57.219 E.00918
G1 X107.821 Y79.684 E.51667
G1 X107.821 Y80.249 E.00918
G1 X130.85 Y57.219 E.52965
G1 X131.414 Y57.219 E.00918
G1 X107.821 Y80.813 E.54263
G1 X107.821 Y81.378 E.00918
G1 X131.979 Y57.219 E.55562
G1 X132.543 Y57.219 E.00918
G1 X107.821 Y81.942 E.5686
G1 X107.821 Y82.507 E.00918
G1 X133.108 Y57.219 E.58158
G1 X133.672 Y57.219 E.00918
G1 X107.821 Y83.071 E.59457
G1 X107.821 Y83.636 E.00918
G1 X134.237 Y57.219 E.60755
G1 X134.801 Y57.219 E.00918
G1 X107.821 Y84.2 E.62053
G1 X107.821 Y84.764 E.00918
G1 X135.366 Y57.219 E.63351
G1 X135.93 Y57.219 E.00918
G1 X107.821 Y85.329 E.6465
G1 X107.821 Y85.893 E.00918
G1 X136.495 Y57.219 E.65948
G1 X137.059 Y57.219 E.00918
G1 X107.821 Y86.458 E.67246
G1 X107.821 Y87.022 E.00918
G1 X137.624 Y57.219 E.68544
G1 X138.188 Y57.219 E.00918
G1 X107.821 Y87.587 E.69843
G1 X107.821 Y88.151 E.00918
G1 X138.753 Y57.219 E.71141
G1 X139.317 Y57.219 E.00918
G1 X107.821 Y88.716 E.72439
G1 X107.821 Y89.28 E.00918
G1 X139.882 Y57.219 E.73737
G1 X140.446 Y57.219 E.00918
G1 X107.927 Y89.738 E.7479
G1 X108.209 Y90.02 E.00649
G1 X141.011 Y57.219 E.7544
G1 X141.575 Y57.219 E.00918
G1 X108.492 Y90.303 E.76089
G1 X108.774 Y90.585 E.00649
G1 X142.14 Y57.219 E.76738
G1 X142.704 Y57.219 E.00918
G1 X109.056 Y90.867 E.77387
G1 X109.338 Y91.149 E.00649
G1 X143.268 Y57.219 E.78036
G1 X143.833 Y57.219 E.00918
G1 X109.621 Y91.432 E.78685
G1 X109.749 Y91.56 E.00295
G1 X110.057 Y91.56 E.00501
G1 X144.397 Y57.219 E.7898
G1 X144.962 Y57.219 E.00918
G1 X110.622 Y91.56 E.7898
G1 X111.186 Y91.56 E.00918
G1 X145.526 Y57.219 E.7898
G1 X146.091 Y57.219 E.00918
G1 X111.751 Y91.56 E.7898
G1 X112.315 Y91.56 E.00918
G1 X146.655 Y57.219 E.7898
G1 X147.22 Y57.219 E.00918
G1 X112.879 Y91.56 E.7898
G1 X113.444 Y91.56 E.00918
G1 X147.784 Y57.219 E.7898
G1 X148.349 Y57.219 E.00918
G1 X114.008 Y91.56 E.7898
G1 X114.573 Y91.56 E.00918
G1 X148.913 Y57.219 E.7898
G1 X149.478 Y57.219 E.00918
G1 X115.137 Y91.56 E.7898
G1 X115.702 Y91.56 E.00918
G1 X150.042 Y57.219 E.7898
G1 X150.607 Y57.219 E.00918
G1 X116.266 Y91.56 E.7898
G1 X116.831 Y91.56 E.00918
G1 X151.171 Y57.219 E.7898
G1 X151.736 Y57.219 E.00918
G1 X117.395 Y91.56 E.7898
G1 X117.96 Y91.56 E.00918
G1 X152.3 Y57.219 E.7898
G1 X152.865 Y57.219 E.00918
G1 X118.524 Y91.56 E.7898
G1 X119.089 Y91.56 E.00918
G1 X153.429 Y57.219 E.7898
G1 X153.994 Y57.219 E.00918
G1 X119.653 Y91.56 E.7898
G1 X120.218 Y91.56 E.00918
G1 X154.558 Y57.219 E.7898
G1 X155.123 Y57.219 E.00918
G1 X120.782 Y91.56 E.7898
G1 X121.347 Y91.56 E.00918
G1 X155.687 Y57.219 E.7898
G1 X156.252 Y57.219 E.00918
G1 X121.911 Y91.56 E.7898
G1 X122.476 Y91.56 E.00918
G1 X156.816 Y57.219 E.7898
G1 X157.381 Y57.219 E.00918
G1 X123.04 Y91.56 E.7898
G1 X123.605 Y91.56 E.00918
G1 X157.945 Y57.219 E.7898
G1 X158.51 Y57.219 E.00918
G1 X124.169 Y91.56 E.7898
G1 X124.734 Y91.56 E.00918
G1 X159.074 Y57.219 E.7898
G1 X159.638 Y57.219 E.00918
G1 X125.298 Y91.56 E.7898
G1 X125.863 Y91.56 E.00918
G1 X160.203 Y57.219 E.7898
G1 X160.767 Y57.219 E.00918
G1 X126.427 Y91.56 E.7898
G1 X126.992 Y91.56 E.00918
G1 X161.332 Y57.219 E.7898
G1 X161.896 Y57.219 E.00918
G1 X127.556 Y91.56 E.7898
G1 X128.121 Y91.56 E.00918
G1 X162.461 Y57.219 E.7898
G1 X163.025 Y57.219 E.00918
G1 X128.685 Y91.56 E.7898
G1 X129.25 Y91.56 E.00918
G1 X163.59 Y57.219 E.7898
G1 X164.154 Y57.219 E.00918
G1 X129.814 Y91.56 E.7898
G1 X130.378 Y91.56 E.00918
G1 X164.719 Y57.219 E.7898
G1 X165.283 Y57.219 E.00918
G1 X130.943 Y91.56 E.7898
G1 X131.507 Y91.56 E.00918
G1 X165.848 Y57.219 E.7898
G1 X166.412 Y57.219 E.00918
G1 X132.072 Y91.56 E.7898
G1 X132.636 Y91.56 E.00918
G1 X166.977 Y57.219 E.7898
G1 X167.541 Y57.219 E.00918
G1 X133.201 Y91.56 E.7898
G1 X133.765 Y91.56 E.00918
G1 X168.106 Y57.219 E.7898
G1 X168.67 Y57.219 E.00918
G1 X134.33 Y91.56 E.7898
G1 X134.894 Y91.56 E.00918
G1 X169.235 Y57.219 E.7898
G1 X169.799 Y57.219 E.00918
G1 X135.459 Y91.56 E.7898
G1 X136.023 Y91.56 E.00918
G1 X170.364 Y57.219 E.7898
G1 X170.928 Y57.219 E.00918
G1 X136.588 Y91.56 E.7898
G1 X137.152 Y91.56 E.00918
G1 X171.493 Y57.219 E.7898
G1 X172.057 Y57.219 E.00918
G1 X137.717 Y91.56 E.7898
G1 X138.281 Y91.56 E.00918
G1 X172.622 Y57.219 E.7898
G1 X173.186 Y57.219 E.00918
G1 X138.846 Y91.56 E.7898
G1 X139.41 Y91.56 E.00918
G1 X173.751 Y57.219 E.7898
G1 X174.315 Y57.219 E.00918
M73 P48 R38
G1 X139.975 Y91.56 E.7898
G1 X140.539 Y91.56 E.00918
G1 X174.88 Y57.219 E.7898
G1 X175.444 Y57.219 E.00918
G1 X141.104 Y91.56 E.7898
G1 X141.668 Y91.56 E.00918
G1 X176.009 Y57.219 E.7898
G1 X176.573 Y57.219 E.00918
G1 X142.233 Y91.56 E.7898
G1 X142.797 Y91.56 E.00918
G1 X177.137 Y57.219 E.7898
G1 X177.702 Y57.219 E.00918
G1 X143.362 Y91.56 E.7898
G1 X143.926 Y91.56 E.00918
G1 X178.266 Y57.219 E.7898
G1 X178.831 Y57.219 E.00918
M73 P49 R38
G1 X144.491 Y91.56 E.7898
G1 X145.055 Y91.56 E.00918
G1 X179.395 Y57.219 E.7898
G1 X179.96 Y57.219 E.00918
G1 X145.62 Y91.56 E.7898
G1 X146.184 Y91.56 E.00918
G1 X180.524 Y57.219 E.7898
G1 X181.089 Y57.219 E.00918
G1 X146.748 Y91.56 E.7898
G1 X147.313 Y91.56 E.00918
G1 X181.653 Y57.219 E.7898
G1 X182.218 Y57.219 E.00918
G1 X147.877 Y91.56 E.7898
G1 X148.442 Y91.56 E.00918
G1 X182.782 Y57.219 E.7898
G1 X183.347 Y57.219 E.00918
G1 X149.006 Y91.56 E.7898
G1 X149.571 Y91.56 E.00918
G1 X183.911 Y57.219 E.7898
G1 X184.476 Y57.219 E.00918
G1 X150.135 Y91.56 E.7898
G1 X150.7 Y91.56 E.00918
G1 X185.04 Y57.219 E.7898
G1 X185.605 Y57.219 E.00918
G1 X151.264 Y91.56 E.7898
G1 X151.829 Y91.56 E.00918
G1 X186.169 Y57.219 E.7898
G1 X186.734 Y57.219 E.00918
G1 X152.393 Y91.56 E.7898
G1 X152.958 Y91.56 E.00918
G1 X187.298 Y57.219 E.7898
G1 X187.863 Y57.219 E.00918
G1 X153.522 Y91.56 E.7898
G1 X154.087 Y91.56 E.00918
G1 X188.427 Y57.219 E.7898
G1 X188.992 Y57.219 E.00918
G1 X154.651 Y91.56 E.7898
G1 X155.216 Y91.56 E.00918
G1 X189.556 Y57.219 E.7898
G1 X190.121 Y57.219 E.00918
G1 X155.78 Y91.56 E.7898
G1 X156.345 Y91.56 E.00918
G1 X190.685 Y57.219 E.7898
G1 X191.25 Y57.219 E.00918
G1 X156.909 Y91.56 E.7898
G1 X157.474 Y91.56 E.00918
G1 X191.814 Y57.219 E.7898
G1 X192.379 Y57.219 E.00918
G1 X158.038 Y91.56 E.7898
G1 X158.603 Y91.56 E.00918
G1 X192.943 Y57.219 E.7898
G1 X193.507 Y57.219 E.00918
G1 X159.167 Y91.56 E.7898
G1 X159.732 Y91.56 E.00918
G1 X194.072 Y57.219 E.7898
G1 X194.636 Y57.219 E.00918
G1 X160.296 Y91.56 E.7898
G1 X160.861 Y91.56 E.00918
G1 X195.201 Y57.219 E.7898
G1 X195.765 Y57.219 E.00918
G1 X161.425 Y91.56 E.7898
G1 X161.99 Y91.56 E.00918
G1 X196.33 Y57.219 E.7898
G1 X196.894 Y57.219 E.00918
G1 X162.554 Y91.56 E.7898
G1 X163.119 Y91.56 E.00918
G1 X197.459 Y57.219 E.7898
G1 X198.023 Y57.219 E.00918
G1 X163.683 Y91.56 E.7898
G1 X164.247 Y91.56 E.00918
G1 X198.588 Y57.219 E.7898
G1 X199.152 Y57.219 E.00918
G1 X164.812 Y91.56 E.7898
G1 X165.376 Y91.56 E.00918
G1 X199.717 Y57.219 E.7898
G1 X200.281 Y57.219 E.00918
G1 X165.941 Y91.56 E.7898
G1 X166.505 Y91.56 E.00918
G1 X200.846 Y57.219 E.7898
G1 X201.41 Y57.219 E.00918
G1 X167.07 Y91.56 E.7898
G1 X167.634 Y91.56 E.00918
G1 X201.975 Y57.219 E.7898
G1 X202.539 Y57.219 E.00918
G1 X168.199 Y91.56 E.7898
G1 X168.763 Y91.56 E.00918
G1 X203.104 Y57.219 E.7898
G1 X203.668 Y57.219 E.00918
G1 X169.328 Y91.56 E.7898
G1 X169.892 Y91.56 E.00918
G1 X204.233 Y57.219 E.7898
G1 X204.797 Y57.219 E.00918
G1 X170.457 Y91.56 E.7898
G1 X171.021 Y91.56 E.00918
G1 X205.362 Y57.219 E.7898
G1 X205.926 Y57.219 E.00918
G1 X171.586 Y91.56 E.7898
G1 X172.15 Y91.56 E.00918
G1 X206.491 Y57.219 E.7898
G1 X207.055 Y57.219 E.00918
G1 X172.715 Y91.56 E.7898
G1 X173.279 Y91.56 E.00918
G1 X207.62 Y57.219 E.7898
G1 X208.161 Y57.219 E.0088
G1 X208.161 Y57.242 E.00038
G1 X173.844 Y91.56 E.78927
G1 X174.408 Y91.56 E.00918
G1 X208.161 Y57.807 E.77628
G1 X208.161 Y58.371 E.00918
G1 X174.973 Y91.56 E.7633
G1 X175.537 Y91.56 E.00918
G1 X208.161 Y58.936 E.75032
G1 X208.161 Y59.5 E.00918
G1 X176.102 Y91.56 E.73734
G1 X176.666 Y91.56 E.00918
G1 X208.161 Y60.065 E.72435
G1 X208.161 Y60.629 E.00918
G1 X177.231 Y91.56 E.71137
G1 X177.795 Y91.56 E.00918
G1 X208.161 Y61.194 E.69839
G1 X208.161 Y61.758 E.00918
G1 X178.36 Y91.56 E.68541
G1 X178.924 Y91.56 E.00918
G1 X208.161 Y62.323 E.67242
G1 X208.161 Y62.887 E.00918
G1 X179.489 Y91.56 E.65944
G1 X180.053 Y91.56 E.00918
G1 X208.161 Y63.452 E.64646
G1 X208.161 Y64.016 E.00918
G1 X180.617 Y91.56 E.63348
G1 X181.182 Y91.56 E.00918
G1 X208.161 Y64.581 E.62049
G1 X208.161 Y65.145 E.00918
G1 X181.746 Y91.56 E.60751
G1 X182.311 Y91.56 E.00918
G1 X208.161 Y65.71 E.59453
G1 X208.161 Y66.274 E.00918
G1 X182.875 Y91.56 E.58155
G1 X183.44 Y91.56 E.00918
G1 X208.161 Y66.839 E.56856
G1 X208.161 Y67.403 E.00918
G1 X184.004 Y91.56 E.55558
G1 X184.569 Y91.56 E.00918
G1 X208.161 Y67.968 E.5426
G1 X208.161 Y68.532 E.00918
G1 X185.133 Y91.56 E.52961
G1 X185.698 Y91.56 E.00918
G1 X208.161 Y69.097 E.51663
G1 X208.161 Y69.661 E.00918
G1 X186.262 Y91.56 E.50365
G1 X186.827 Y91.56 E.00918
G1 X208.161 Y70.226 E.49067
G1 X208.161 Y70.79 E.00918
G1 X187.391 Y91.56 E.47768
M73 P50 R38
G1 X187.956 Y91.56 E.00918
G1 X208.161 Y71.355 E.4647
G1 X208.161 Y71.919 E.00918
G1 X188.52 Y91.56 E.45172
G1 X189.085 Y91.56 E.00918
G1 X208.161 Y72.484 E.43874
G1 X208.161 Y73.048 E.00918
G1 X189.649 Y91.56 E.42575
G1 X190.214 Y91.56 E.00918
G1 X208.161 Y73.612 E.41277
G1 X208.161 Y74.177 E.00918
G1 X190.778 Y91.56 E.39979
G1 X191.343 Y91.56 E.00918
G1 X208.161 Y74.741 E.38681
G1 X208.161 Y75.306 E.00918
G1 X191.907 Y91.56 E.37382
G1 X192.472 Y91.56 E.00918
G1 X208.161 Y75.87 E.36084
G1 X208.161 Y76.435 E.00918
G1 X193.036 Y91.56 E.34786
G1 X193.601 Y91.56 E.00918
G1 X208.161 Y76.999 E.33488
G1 X208.161 Y77.564 E.00918
G1 X194.165 Y91.56 E.32189
G1 X194.73 Y91.56 E.00918
G1 X208.161 Y78.128 E.30891
G1 X208.161 Y78.693 E.00918
G1 X195.294 Y91.56 E.29593
G1 X195.859 Y91.56 E.00918
G1 X208.161 Y79.257 E.28294
G1 X208.161 Y79.822 E.00918
G1 X196.423 Y91.56 E.26996
M73 P50 R37
G1 X196.988 Y91.56 E.00918
G1 X208.161 Y80.386 E.25698
G1 X208.161 Y80.951 E.00918
G1 X197.552 Y91.56 E.244
G1 X198.116 Y91.56 E.00918
G1 X208.161 Y81.515 E.23101
G1 X208.161 Y82.08 E.00918
G1 X198.681 Y91.56 E.21803
G1 X199.245 Y91.56 E.00918
G1 X208.161 Y82.644 E.20505
G1 X208.161 Y83.209 E.00918
G1 X199.81 Y91.56 E.19207
G1 X200.374 Y91.56 E.00918
G1 X208.161 Y83.773 E.17908
G1 X208.161 Y84.338 E.00918
G1 X200.939 Y91.56 E.1661
G1 X201.503 Y91.56 E.00918
G1 X208.161 Y84.902 E.15312
G1 X208.161 Y85.467 E.00918
G1 X202.068 Y91.56 E.14014
G1 X202.632 Y91.56 E.00918
G1 X208.161 Y86.031 E.12715
G1 X208.161 Y86.596 E.00918
G1 X203.197 Y91.56 E.11417
G1 X203.761 Y91.56 E.00918
G1 X208.161 Y87.16 E.10119
G1 X208.161 Y87.725 E.00918
G1 X204.326 Y91.56 E.08821
G1 X204.89 Y91.56 E.00918
G1 X208.161 Y88.289 E.07522
G1 X208.161 Y88.854 E.00918
G1 X205.455 Y91.56 E.06224
G1 X206.019 Y91.56 E.00918
G1 X208.161 Y89.418 E.04926
G1 X208.161 Y89.983 E.00918
G1 X206.584 Y91.56 E.03627
G1 X207.148 Y91.56 E.00918
G1 X208.161 Y90.547 E.02329
G1 X208.161 Y91.111 E.00918
G1 X207.533 Y91.739 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 1.1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X208.161 Y91.111 E-.33727
G1 X208.161 Y90.547 E-.21451
G1 X207.774 Y90.934 E-.20822
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 11/58
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.4 I.391 J-1.152 P1  F30000
G1 X107.471 Y56.87 Z1.4
G1 Z1.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 11 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer11 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.074 Y63.29 Z1.5 F30000
G1 X107.641 Y89.45 Z1.5
G1 Z1.1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X109.751 Y91.56 E.0486
G1 X110.316 Y91.56 E.00921
G1 X107.821 Y89.064 E.05749
G1 X107.821 Y88.499 E.00921
G1 X110.882 Y91.56 E.07051
G1 X111.447 Y91.56 E.00921
G1 X107.821 Y87.933 E.08354
G1 X107.821 Y87.368 E.00921
G1 X112.012 Y91.56 E.09656
G1 X112.578 Y91.56 E.00921
G1 X107.821 Y86.803 E.10959
G1 X107.821 Y86.237 E.00921
G1 X113.143 Y91.56 E.12261
G1 X113.709 Y91.56 E.00921
G1 X107.821 Y85.672 E.13563
G1 X107.821 Y85.106 E.00921
G1 X114.274 Y91.56 E.14866
G1 X114.839 Y91.56 E.00921
G1 X107.821 Y84.541 E.16168
G1 X107.821 Y83.976 E.00921
G1 X115.405 Y91.56 E.17471
G1 X115.97 Y91.56 E.00921
G1 X107.821 Y83.41 E.18773
G1 X107.821 Y82.845 E.00921
G1 X116.535 Y91.56 E.20076
G1 X117.101 Y91.56 E.00921
G1 X107.821 Y82.28 E.21378
G1 X107.821 Y81.714 E.00921
G1 X117.666 Y91.56 E.2268
G1 X118.232 Y91.56 E.00921
G1 X107.821 Y81.149 E.23983
G1 X107.821 Y80.583 E.00921
G1 X118.797 Y91.56 E.25285
G1 X119.362 Y91.56 E.00921
G1 X107.821 Y80.018 E.26588
G1 X107.821 Y79.453 E.00921
G1 X119.928 Y91.56 E.2789
G1 X120.493 Y91.56 E.00921
G1 X107.821 Y78.887 E.29193
G1 X107.821 Y78.322 E.00921
G1 X121.059 Y91.56 E.30495
G1 X121.624 Y91.56 E.00921
G1 X107.821 Y77.756 E.31797
G1 X107.821 Y77.191 E.00921
G1 X122.189 Y91.56 E.331
G1 X122.755 Y91.56 E.00921
G1 X107.821 Y76.626 E.34402
G1 X107.821 Y76.06 E.00921
G1 X123.32 Y91.56 E.35705
G1 X123.886 Y91.56 E.00921
G1 X107.821 Y75.495 E.37007
G1 X107.821 Y74.929 E.00921
G1 X124.451 Y91.56 E.3831
G1 X125.016 Y91.56 E.00921
G1 X107.821 Y74.364 E.39612
G1 X107.821 Y73.799 E.00921
G1 X125.582 Y91.56 E.40914
G1 X126.147 Y91.56 E.00921
G1 X107.821 Y73.233 E.42217
G1 X107.821 Y72.668 E.00921
G1 X126.712 Y91.56 E.43519
G1 X127.278 Y91.56 E.00921
G1 X107.821 Y72.103 E.44822
G1 X107.821 Y71.537 E.00921
G1 X127.843 Y91.56 E.46124
G1 X128.409 Y91.56 E.00921
G1 X107.821 Y70.972 E.47427
G1 X107.821 Y70.406 E.00921
G1 X128.974 Y91.56 E.48729
G1 X129.539 Y91.56 E.00921
G1 X107.821 Y69.841 E.50031
G1 X107.821 Y69.276 E.00921
G1 X130.105 Y91.56 E.51334
G1 X130.67 Y91.56 E.00921
G1 X107.821 Y68.71 E.52636
G1 X107.821 Y68.145 E.00921
G1 X131.236 Y91.56 E.53939
G1 X131.801 Y91.56 E.00921
G1 X107.821 Y67.579 E.55241
G1 X107.821 Y67.014 E.00921
G1 X132.366 Y91.56 E.56544
G1 X132.932 Y91.56 E.00921
G1 X107.821 Y66.449 E.57846
G1 X107.821 Y65.883 E.00921
G1 X133.497 Y91.56 E.59148
M73 P51 R37
G1 X134.063 Y91.56 E.00921
G1 X107.821 Y65.318 E.60451
G1 X107.821 Y64.752 E.00921
G1 X134.628 Y91.56 E.61753
G1 X135.193 Y91.56 E.00921
G1 X107.821 Y64.187 E.63056
G1 X107.821 Y63.622 E.00921
G1 X135.759 Y91.56 E.64358
G1 X136.324 Y91.56 E.00921
G1 X107.821 Y63.056 E.65661
G1 X107.821 Y62.491 E.00921
G1 X136.889 Y91.56 E.66963
G1 X137.455 Y91.56 E.00921
G1 X107.821 Y61.926 E.68265
G1 X107.821 Y61.36 E.00921
G1 X138.02 Y91.56 E.69568
G1 X138.586 Y91.56 E.00921
G1 X107.821 Y60.795 E.7087
G1 X107.821 Y60.229 E.00921
G1 X139.151 Y91.56 E.72173
G1 X139.716 Y91.56 E.00921
G1 X107.821 Y59.664 E.73475
G1 X107.821 Y59.099 E.00921
G1 X140.282 Y91.56 E.74778
G1 X140.847 Y91.56 E.00921
G1 X107.821 Y58.533 E.7608
G1 X107.821 Y57.968 E.00921
G1 X141.413 Y91.56 E.77382
G1 X141.978 Y91.56 E.00921
G1 X107.821 Y57.402 E.78685
G1 X107.821 Y57.219 E.00298
G1 X108.203 Y57.219 E.00623
G1 X142.543 Y91.56 E.79106
G1 X143.109 Y91.56 E.00921
G1 X108.768 Y57.219 E.79106
G1 X109.334 Y57.219 E.00921
G1 X143.674 Y91.56 E.79106
G1 X144.239 Y91.56 E.00921
G1 X109.899 Y57.219 E.79106
G1 X110.465 Y57.219 E.00921
G1 X144.805 Y91.56 E.79106
G1 X145.37 Y91.56 E.00921
G1 X111.03 Y57.219 E.79106
G1 X111.595 Y57.219 E.00921
G1 X145.936 Y91.56 E.79106
G1 X146.501 Y91.56 E.00921
G1 X112.161 Y57.219 E.79106
G1 X112.726 Y57.219 E.00921
G1 X147.066 Y91.56 E.79106
G1 X147.632 Y91.56 E.00921
G1 X113.291 Y57.219 E.79106
G1 X113.857 Y57.219 E.00921
G1 X148.197 Y91.56 E.79106
G1 X148.763 Y91.56 E.00921
G1 X114.422 Y57.219 E.79106
G1 X114.988 Y57.219 E.00921
G1 X149.328 Y91.56 E.79106
G1 X149.893 Y91.56 E.00921
G1 X115.553 Y57.219 E.79106
G1 X116.118 Y57.219 E.00921
G1 X150.459 Y91.56 E.79106
G1 X151.024 Y91.56 E.00921
G1 X116.684 Y57.219 E.79106
G1 X117.249 Y57.219 E.00921
G1 X151.59 Y91.56 E.79106
G1 X152.155 Y91.56 E.00921
G1 X117.815 Y57.219 E.79106
G1 X118.38 Y57.219 E.00921
G1 X152.72 Y91.56 E.79106
G1 X153.286 Y91.56 E.00921
G1 X118.945 Y57.219 E.79106
G1 X119.511 Y57.219 E.00921
G1 X153.851 Y91.56 E.79106
G1 X154.416 Y91.56 E.00921
G1 X120.076 Y57.219 E.79106
G1 X120.642 Y57.219 E.00921
G1 X154.982 Y91.56 E.79106
G1 X155.547 Y91.56 E.00921
G1 X121.207 Y57.219 E.79106
G1 X121.772 Y57.219 E.00921
G1 X156.113 Y91.56 E.79106
G1 X156.678 Y91.56 E.00921
G1 X122.338 Y57.219 E.79106
G1 X122.903 Y57.219 E.00921
G1 X157.243 Y91.56 E.79106
G1 X157.809 Y91.56 E.00921
G1 X123.468 Y57.219 E.79106
G1 X124.034 Y57.219 E.00921
G1 X158.374 Y91.56 E.79106
G1 X158.94 Y91.56 E.00921
G1 X124.599 Y57.219 E.79106
G1 X125.165 Y57.219 E.00921
G1 X159.505 Y91.56 E.79106
G1 X160.07 Y91.56 E.00921
G1 X125.73 Y57.219 E.79106
G1 X126.295 Y57.219 E.00921
G1 X160.636 Y91.56 E.79106
G1 X161.201 Y91.56 E.00921
G1 X126.861 Y57.219 E.79106
G1 X127.426 Y57.219 E.00921
G1 X161.767 Y91.56 E.79106
G1 X162.332 Y91.56 E.00921
G1 X127.992 Y57.219 E.79106
G1 X128.557 Y57.219 E.00921
G1 X162.897 Y91.56 E.79106
G1 X163.463 Y91.56 E.00921
G1 X129.122 Y57.219 E.79106
G1 X129.688 Y57.219 E.00921
G1 X164.028 Y91.56 E.79106
G1 X164.593 Y91.56 E.00921
G1 X130.253 Y57.219 E.79106
G1 X130.819 Y57.219 E.00921
G1 X165.159 Y91.56 E.79106
G1 X165.724 Y91.56 E.00921
G1 X131.384 Y57.219 E.79106
G1 X131.949 Y57.219 E.00921
G1 X166.29 Y91.56 E.79106
G1 X166.855 Y91.56 E.00921
G1 X132.515 Y57.219 E.79106
M73 P51 R36
G1 X133.08 Y57.219 E.00921
G1 X167.42 Y91.56 E.79106
G1 X167.986 Y91.56 E.00921
G1 X133.645 Y57.219 E.79106
G1 X134.211 Y57.219 E.00921
G1 X168.551 Y91.56 E.79106
G1 X169.117 Y91.56 E.00921
G1 X134.776 Y57.219 E.79106
G1 X135.342 Y57.219 E.00921
G1 X169.682 Y91.56 E.79106
G1 X170.247 Y91.56 E.00921
G1 X135.907 Y57.219 E.79106
G1 X136.472 Y57.219 E.00921
G1 X170.813 Y91.56 E.79106
G1 X171.378 Y91.56 E.00921
G1 X137.038 Y57.219 E.79106
G1 X137.603 Y57.219 E.00921
G1 X171.944 Y91.56 E.79106
G1 X172.509 Y91.56 E.00921
G1 X138.169 Y57.219 E.79106
G1 X138.734 Y57.219 E.00921
G1 X173.074 Y91.56 E.79106
G1 X173.64 Y91.56 E.00921
G1 X139.299 Y57.219 E.79106
G1 X139.865 Y57.219 E.00921
G1 X174.205 Y91.56 E.79106
G1 X174.77 Y91.56 E.00921
G1 X140.43 Y57.219 E.79106
G1 X140.996 Y57.219 E.00921
G1 X175.336 Y91.56 E.79106
G1 X175.901 Y91.56 E.00921
G1 X141.561 Y57.219 E.79106
G1 X142.126 Y57.219 E.00921
G1 X176.467 Y91.56 E.79106
G1 X177.032 Y91.56 E.00921
G1 X142.692 Y57.219 E.79106
G1 X143.257 Y57.219 E.00921
G1 X177.597 Y91.56 E.79106
G1 X178.163 Y91.56 E.00921
G1 X143.822 Y57.219 E.79106
G1 X144.388 Y57.219 E.00921
G1 X178.728 Y91.56 E.79106
G1 X179.294 Y91.56 E.00921
G1 X144.953 Y57.219 E.79106
G1 X145.519 Y57.219 E.00921
G1 X179.859 Y91.56 E.79106
G1 X180.424 Y91.56 E.00921
G1 X146.084 Y57.219 E.79106
G1 X146.649 Y57.219 E.00921
G1 X180.99 Y91.56 E.79106
G1 X181.555 Y91.56 E.00921
G1 X147.215 Y57.219 E.79106
G1 X147.78 Y57.219 E.00921
G1 X182.121 Y91.56 E.79106
G1 X182.686 Y91.56 E.00921
G1 X148.346 Y57.219 E.79106
G1 X148.911 Y57.219 E.00921
G1 X183.251 Y91.56 E.79106
G1 X183.817 Y91.56 E.00921
G1 X149.476 Y57.219 E.79106
G1 X150.042 Y57.219 E.00921
G1 X184.382 Y91.56 E.79106
G1 X184.947 Y91.56 E.00921
G1 X150.607 Y57.219 E.79106
G1 X151.172 Y57.219 E.00921
G1 X185.513 Y91.56 E.79106
G1 X186.078 Y91.56 E.00921
G1 X151.738 Y57.219 E.79106
G1 X152.303 Y57.219 E.00921
G1 X186.644 Y91.56 E.79106
G1 X187.209 Y91.56 E.00921
G1 X152.869 Y57.219 E.79106
G1 X153.434 Y57.219 E.00921
G1 X187.774 Y91.56 E.79106
G1 X188.34 Y91.56 E.00921
G1 X153.999 Y57.219 E.79106
G1 X154.565 Y57.219 E.00921
M73 P52 R36
G1 X188.905 Y91.56 E.79106
G1 X189.471 Y91.56 E.00921
G1 X155.13 Y57.219 E.79106
G1 X155.696 Y57.219 E.00921
G1 X190.036 Y91.56 E.79106
G1 X190.601 Y91.56 E.00921
G1 X156.261 Y57.219 E.79106
G1 X156.826 Y57.219 E.00921
G1 X191.167 Y91.56 E.79106
G1 X191.732 Y91.56 E.00921
G1 X157.392 Y57.219 E.79106
G1 X157.957 Y57.219 E.00921
G1 X192.298 Y91.56 E.79106
G1 X192.863 Y91.56 E.00921
G1 X158.523 Y57.219 E.79106
G1 X159.088 Y57.219 E.00921
G1 X193.428 Y91.56 E.79106
G1 X193.994 Y91.56 E.00921
G1 X159.653 Y57.219 E.79106
G1 X160.219 Y57.219 E.00921
G1 X194.559 Y91.56 E.79106
G1 X195.124 Y91.56 E.00921
G1 X160.784 Y57.219 E.79106
G1 X161.349 Y57.219 E.00921
G1 X195.69 Y91.56 E.79106
G1 X196.255 Y91.56 E.00921
G1 X161.915 Y57.219 E.79106
G1 X162.48 Y57.219 E.00921
G1 X196.821 Y91.56 E.79106
G1 X197.386 Y91.56 E.00921
G1 X163.046 Y57.219 E.79106
G1 X163.611 Y57.219 E.00921
G1 X197.951 Y91.56 E.79106
G1 X198.517 Y91.56 E.00921
G1 X164.176 Y57.219 E.79106
G1 X164.742 Y57.219 E.00921
G1 X199.082 Y91.56 E.79106
G1 X199.648 Y91.56 E.00921
G1 X165.307 Y57.219 E.79106
G1 X165.873 Y57.219 E.00921
G1 X200.213 Y91.56 E.79106
G1 X200.778 Y91.56 E.00921
G1 X166.438 Y57.219 E.79106
G1 X167.003 Y57.219 E.00921
G1 X201.344 Y91.56 E.79106
G1 X201.909 Y91.56 E.00921
G1 X167.569 Y57.219 E.79106
G1 X168.134 Y57.219 E.00921
G1 X202.475 Y91.56 E.79106
G1 X203.04 Y91.56 E.00921
G1 X168.7 Y57.219 E.79106
G1 X169.265 Y57.219 E.00921
G1 X203.605 Y91.56 E.79106
G1 X204.171 Y91.56 E.00921
G1 X169.83 Y57.219 E.79106
G1 X170.396 Y57.219 E.00921
G1 X204.736 Y91.56 E.79106
G1 X205.301 Y91.56 E.00921
G1 X170.961 Y57.219 E.79106
G1 X171.526 Y57.219 E.00921
G1 X205.867 Y91.56 E.79106
G1 X206.432 Y91.56 E.00921
G1 X172.092 Y57.219 E.79106
G1 X172.657 Y57.219 E.00921
G1 X206.998 Y91.56 E.79106
G1 X207.563 Y91.56 E.00921
G1 X173.223 Y57.219 E.79106
G1 X173.788 Y57.219 E.00921
G1 X208.128 Y91.56 E.79106
G1 X208.161 Y91.56 E.00053
G1 X208.161 Y91.027 E.00868
G1 X174.353 Y57.219 E.77879
G1 X174.919 Y57.219 E.00921
G1 X208.161 Y90.462 E.76577
G1 X208.161 Y89.896 E.00921
G1 X175.484 Y57.219 E.75274
G1 X176.05 Y57.219 E.00921
G1 X208.161 Y89.331 E.73972
G1 X208.161 Y88.765 E.00921
G1 X176.615 Y57.219 E.72669
G1 X177.18 Y57.219 E.00921
G1 X208.161 Y88.2 E.71367
G1 X208.161 Y87.635 E.00921
G1 X177.746 Y57.219 E.70064
G1 X178.311 Y57.219 E.00921
G1 X208.161 Y87.069 E.68762
G1 X208.161 Y86.504 E.00921
G1 X178.877 Y57.219 E.6746
G1 X179.442 Y57.219 E.00921
G1 X208.161 Y85.938 E.66157
G1 X208.161 Y85.373 E.00921
G1 X180.007 Y57.219 E.64855
G1 X180.573 Y57.219 E.00921
G1 X208.161 Y84.808 E.63552
G1 X208.161 Y84.242 E.00921
G1 X181.138 Y57.219 E.6225
G1 X181.703 Y57.219 E.00921
G1 X208.161 Y83.677 E.60947
G1 X208.161 Y83.111 E.00921
G1 X182.269 Y57.219 E.59645
G1 X182.834 Y57.219 E.00921
G1 X208.161 Y82.546 E.58343
G1 X208.161 Y81.981 E.00921
G1 X183.4 Y57.219 E.5704
G1 X183.965 Y57.219 E.00921
G1 X208.161 Y81.415 E.55738
G1 X208.161 Y80.85 E.00921
G1 X184.53 Y57.219 E.54435
G1 X185.096 Y57.219 E.00921
G1 X208.161 Y80.285 E.53133
G1 X208.161 Y79.719 E.00921
G1 X185.661 Y57.219 E.5183
G1 X186.227 Y57.219 E.00921
G1 X208.161 Y79.154 E.50528
G1 X208.161 Y78.588 E.00921
G1 X186.792 Y57.219 E.49226
G1 X187.357 Y57.219 E.00921
G1 X208.161 Y78.023 E.47923
G1 X208.161 Y77.458 E.00921
G1 X187.923 Y57.219 E.46621
G1 X188.488 Y57.219 E.00921
G1 X208.161 Y76.892 E.45318
G1 X208.161 Y76.327 E.00921
G1 X189.054 Y57.219 E.44016
G1 X189.619 Y57.219 E.00921
G1 X208.161 Y75.761 E.42713
M73 P52 R35
G1 X208.161 Y75.196 E.00921
G1 X190.184 Y57.219 E.41411
G1 X190.75 Y57.219 E.00921
G1 X208.161 Y74.631 E.40109
G1 X208.161 Y74.065 E.00921
G1 X191.315 Y57.219 E.38806
G1 X191.88 Y57.219 E.00921
G1 X208.161 Y73.5 E.37504
G1 X208.161 Y72.934 E.00921
G1 X192.446 Y57.219 E.36201
G1 X193.011 Y57.219 E.00921
G1 X208.161 Y72.369 E.34899
G1 X208.161 Y71.804 E.00921
G1 X193.577 Y57.219 E.33596
G1 X194.142 Y57.219 E.00921
G1 X208.161 Y71.238 E.32294
G1 X208.161 Y70.673 E.00921
G1 X194.707 Y57.219 E.30992
G1 X195.273 Y57.219 E.00921
G1 X208.161 Y70.108 E.29689
G1 X208.161 Y69.542 E.00921
G1 X195.838 Y57.219 E.28387
G1 X196.404 Y57.219 E.00921
G1 X208.161 Y68.977 E.27084
G1 X208.161 Y68.411 E.00921
G1 X196.969 Y57.219 E.25782
G1 X197.534 Y57.219 E.00921
M73 P53 R35
G1 X208.161 Y67.846 E.24479
G1 X208.161 Y67.281 E.00921
G1 X198.1 Y57.219 E.23177
G1 X198.665 Y57.219 E.00921
G1 X208.161 Y66.715 E.21875
G1 X208.161 Y66.15 E.00921
G1 X199.231 Y57.219 E.20572
G1 X199.796 Y57.219 E.00921
G1 X208.161 Y65.584 E.1927
G1 X208.161 Y65.019 E.00921
G1 X200.361 Y57.219 E.17967
G1 X200.927 Y57.219 E.00921
G1 X208.161 Y64.454 E.16665
G1 X208.161 Y63.888 E.00921
G1 X201.492 Y57.219 E.15362
G1 X202.057 Y57.219 E.00921
G1 X208.161 Y63.323 E.1406
G1 X208.161 Y62.758 E.00921
G1 X202.623 Y57.219 E.12758
G1 X203.188 Y57.219 E.00921
G1 X208.161 Y62.192 E.11455
G1 X208.161 Y61.627 E.00921
G1 X203.754 Y57.219 E.10153
G1 X204.319 Y57.219 E.00921
G1 X208.161 Y61.061 E.0885
G1 X208.161 Y60.496 E.00921
G1 X204.884 Y57.219 E.07548
G1 X205.45 Y57.219 E.00921
G1 X208.161 Y59.931 E.06245
G1 X208.161 Y59.365 E.00921
G1 X206.015 Y57.219 E.04943
G1 X206.581 Y57.219 E.00921
G1 X208.161 Y58.8 E.03641
G1 X208.161 Y58.234 E.00921
G1 X207.146 Y57.219 E.02338
G1 X207.711 Y57.219 E.00921
G1 X208.34 Y57.848 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X207.711 Y57.219 E-.338
G1 X207.146 Y57.219 E-.21485
G1 X207.531 Y57.605 E-.20715
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 12/58
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.5 I.009 J-1.217 P1  F30000
G1 X107.471 Y56.87 Z1.5
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 12 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer12 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.641 Y57.849 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X108.27 Y57.219 E.01447
G1 X108.835 Y57.219 E.00918
G1 X107.821 Y58.234 E.02333
G1 X107.821 Y58.798 E.00918
G1 X109.399 Y57.219 E.03631
G1 X109.964 Y57.219 E.00918
G1 X107.821 Y59.363 E.04929
G1 X107.821 Y59.927 E.00918
G1 X110.528 Y57.219 E.06228
G1 X111.093 Y57.219 E.00918
G1 X107.821 Y60.492 E.07526
G1 X107.821 Y61.056 E.00918
G1 X111.657 Y57.219 E.08824
G1 X112.222 Y57.219 E.00918
G1 X107.821 Y61.621 E.10123
G1 X107.821 Y62.185 E.00918
G1 X112.786 Y57.219 E.11421
G1 X113.351 Y57.219 E.00918
G1 X107.821 Y62.75 E.12719
G1 X107.821 Y63.314 E.00918
G1 X113.915 Y57.219 E.14017
G1 X114.48 Y57.219 E.00918
G1 X107.821 Y63.879 E.15316
G1 X107.821 Y64.443 E.00918
G1 X115.044 Y57.219 E.16614
G1 X115.609 Y57.219 E.00918
G1 X107.821 Y65.008 E.17912
G1 X107.821 Y65.572 E.00918
G1 X116.173 Y57.219 E.1921
G1 X116.738 Y57.219 E.00918
G1 X107.821 Y66.137 E.20509
G1 X107.821 Y66.701 E.00918
G1 X117.302 Y57.219 E.21807
G1 X117.867 Y57.219 E.00918
G1 X107.821 Y67.265 E.23105
G1 X107.821 Y67.83 E.00918
G1 X118.431 Y57.219 E.24403
G1 X118.996 Y57.219 E.00918
G1 X107.821 Y68.394 E.25702
G1 X107.821 Y68.959 E.00918
G1 X119.56 Y57.219 E.27
G1 X120.125 Y57.219 E.00918
G1 X107.821 Y69.523 E.28298
G1 X107.821 Y70.088 E.00918
G1 X120.689 Y57.219 E.29596
G1 X121.254 Y57.219 E.00918
G1 X107.821 Y70.652 E.30895
G1 X107.821 Y71.217 E.00918
G1 X121.818 Y57.219 E.32193
G1 X122.383 Y57.219 E.00918
G1 X107.821 Y71.781 E.33491
G1 X107.821 Y72.346 E.00918
G1 X122.947 Y57.219 E.3479
G1 X123.512 Y57.219 E.00918
G1 X107.821 Y72.91 E.36088
G1 X107.821 Y73.475 E.00918
G1 X124.076 Y57.219 E.37386
G1 X124.641 Y57.219 E.00918
G1 X107.821 Y74.039 E.38684
G1 X107.821 Y74.604 E.00918
G1 X125.205 Y57.219 E.39983
G1 X125.769 Y57.219 E.00918
G1 X107.821 Y75.168 E.41281
G1 X107.821 Y75.733 E.00918
G1 X126.334 Y57.219 E.42579
G1 X126.898 Y57.219 E.00918
G1 X107.821 Y76.297 E.43877
G1 X107.821 Y76.862 E.00918
G1 X127.463 Y57.219 E.45176
G1 X128.027 Y57.219 E.00918
G1 X107.821 Y77.426 E.46474
G1 X107.821 Y77.991 E.00918
G1 X128.592 Y57.219 E.47772
G1 X129.156 Y57.219 E.00918
G1 X107.821 Y78.555 E.4907
G1 X107.821 Y79.12 E.00918
G1 X129.721 Y57.219 E.50369
G1 X130.285 Y57.219 E.00918
G1 X107.821 Y79.684 E.51667
G1 X107.821 Y80.249 E.00918
G1 X130.85 Y57.219 E.52965
G1 X131.414 Y57.219 E.00918
G1 X107.821 Y80.813 E.54263
G1 X107.821 Y81.378 E.00918
G1 X131.979 Y57.219 E.55562
G1 X132.543 Y57.219 E.00918
G1 X107.821 Y81.942 E.5686
G1 X107.821 Y82.507 E.00918
G1 X133.108 Y57.219 E.58158
G1 X133.672 Y57.219 E.00918
G1 X107.821 Y83.071 E.59457
G1 X107.821 Y83.636 E.00918
G1 X134.237 Y57.219 E.60755
G1 X134.801 Y57.219 E.00918
G1 X107.821 Y84.2 E.62053
G1 X107.821 Y84.764 E.00918
G1 X135.366 Y57.219 E.63351
G1 X135.93 Y57.219 E.00918
G1 X107.821 Y85.329 E.6465
G1 X107.821 Y85.893 E.00918
G1 X136.495 Y57.219 E.65948
G1 X137.059 Y57.219 E.00918
G1 X107.821 Y86.458 E.67246
G1 X107.821 Y87.022 E.00918
G1 X137.624 Y57.219 E.68544
G1 X138.188 Y57.219 E.00918
G1 X107.821 Y87.587 E.69843
G1 X107.821 Y88.151 E.00918
G1 X138.753 Y57.219 E.71141
G1 X139.317 Y57.219 E.00918
G1 X107.821 Y88.716 E.72439
G1 X107.821 Y89.28 E.00918
G1 X139.882 Y57.219 E.73737
G1 X140.446 Y57.219 E.00918
G1 X107.927 Y89.738 E.7479
G1 X108.209 Y90.02 E.00649
G1 X141.011 Y57.219 E.7544
G1 X141.575 Y57.219 E.00918
G1 X108.492 Y90.303 E.76089
G1 X108.774 Y90.585 E.00649
G1 X142.14 Y57.219 E.76738
G1 X142.704 Y57.219 E.00918
G1 X109.056 Y90.867 E.77387
G1 X109.338 Y91.149 E.00649
G1 X143.268 Y57.219 E.78036
G1 X143.833 Y57.219 E.00918
G1 X109.621 Y91.432 E.78685
G1 X109.749 Y91.56 E.00295
G1 X110.057 Y91.56 E.00501
G1 X144.397 Y57.219 E.7898
G1 X144.962 Y57.219 E.00918
G1 X110.622 Y91.56 E.7898
G1 X111.186 Y91.56 E.00918
G1 X145.526 Y57.219 E.7898
G1 X146.091 Y57.219 E.00918
G1 X111.751 Y91.56 E.7898
G1 X112.315 Y91.56 E.00918
G1 X146.655 Y57.219 E.7898
G1 X147.22 Y57.219 E.00918
G1 X112.879 Y91.56 E.7898
G1 X113.444 Y91.56 E.00918
G1 X147.784 Y57.219 E.7898
G1 X148.349 Y57.219 E.00918
G1 X114.008 Y91.56 E.7898
G1 X114.573 Y91.56 E.00918
G1 X148.913 Y57.219 E.7898
G1 X149.478 Y57.219 E.00918
G1 X115.137 Y91.56 E.7898
G1 X115.702 Y91.56 E.00918
G1 X150.042 Y57.219 E.7898
M73 P54 R35
G1 X150.607 Y57.219 E.00918
G1 X116.266 Y91.56 E.7898
G1 X116.831 Y91.56 E.00918
G1 X151.171 Y57.219 E.7898
G1 X151.736 Y57.219 E.00918
G1 X117.395 Y91.56 E.7898
G1 X117.96 Y91.56 E.00918
G1 X152.3 Y57.219 E.7898
G1 X152.865 Y57.219 E.00918
G1 X118.524 Y91.56 E.7898
G1 X119.089 Y91.56 E.00918
G1 X153.429 Y57.219 E.7898
G1 X153.994 Y57.219 E.00918
G1 X119.653 Y91.56 E.7898
G1 X120.218 Y91.56 E.00918
G1 X154.558 Y57.219 E.7898
G1 X155.123 Y57.219 E.00918
G1 X120.782 Y91.56 E.7898
G1 X121.347 Y91.56 E.00918
G1 X155.687 Y57.219 E.7898
G1 X156.252 Y57.219 E.00918
G1 X121.911 Y91.56 E.7898
G1 X122.476 Y91.56 E.00918
G1 X156.816 Y57.219 E.7898
G1 X157.381 Y57.219 E.00918
G1 X123.04 Y91.56 E.7898
G1 X123.605 Y91.56 E.00918
G1 X157.945 Y57.219 E.7898
G1 X158.51 Y57.219 E.00918
G1 X124.169 Y91.56 E.7898
G1 X124.734 Y91.56 E.00918
M73 P54 R34
G1 X159.074 Y57.219 E.7898
G1 X159.638 Y57.219 E.00918
G1 X125.298 Y91.56 E.7898
G1 X125.863 Y91.56 E.00918
G1 X160.203 Y57.219 E.7898
G1 X160.767 Y57.219 E.00918
G1 X126.427 Y91.56 E.7898
G1 X126.992 Y91.56 E.00918
G1 X161.332 Y57.219 E.7898
G1 X161.896 Y57.219 E.00918
G1 X127.556 Y91.56 E.7898
G1 X128.121 Y91.56 E.00918
G1 X162.461 Y57.219 E.7898
G1 X163.025 Y57.219 E.00918
G1 X128.685 Y91.56 E.7898
G1 X129.25 Y91.56 E.00918
G1 X163.59 Y57.219 E.7898
G1 X164.154 Y57.219 E.00918
G1 X129.814 Y91.56 E.7898
G1 X130.378 Y91.56 E.00918
G1 X164.719 Y57.219 E.7898
G1 X165.283 Y57.219 E.00918
G1 X130.943 Y91.56 E.7898
G1 X131.507 Y91.56 E.00918
G1 X165.848 Y57.219 E.7898
G1 X166.412 Y57.219 E.00918
G1 X132.072 Y91.56 E.7898
G1 X132.636 Y91.56 E.00918
G1 X166.977 Y57.219 E.7898
G1 X167.541 Y57.219 E.00918
G1 X133.201 Y91.56 E.7898
G1 X133.765 Y91.56 E.00918
G1 X168.106 Y57.219 E.7898
G1 X168.67 Y57.219 E.00918
G1 X134.33 Y91.56 E.7898
G1 X134.894 Y91.56 E.00918
G1 X169.235 Y57.219 E.7898
G1 X169.799 Y57.219 E.00918
G1 X135.459 Y91.56 E.7898
G1 X136.023 Y91.56 E.00918
G1 X170.364 Y57.219 E.7898
G1 X170.928 Y57.219 E.00918
G1 X136.588 Y91.56 E.7898
G1 X137.152 Y91.56 E.00918
G1 X171.493 Y57.219 E.7898
G1 X172.057 Y57.219 E.00918
G1 X137.717 Y91.56 E.7898
G1 X138.281 Y91.56 E.00918
G1 X172.622 Y57.219 E.7898
G1 X173.186 Y57.219 E.00918
G1 X138.846 Y91.56 E.7898
G1 X139.41 Y91.56 E.00918
G1 X173.751 Y57.219 E.7898
G1 X174.315 Y57.219 E.00918
G1 X139.975 Y91.56 E.7898
G1 X140.539 Y91.56 E.00918
G1 X174.88 Y57.219 E.7898
G1 X175.444 Y57.219 E.00918
G1 X141.104 Y91.56 E.7898
G1 X141.668 Y91.56 E.00918
G1 X176.009 Y57.219 E.7898
G1 X176.573 Y57.219 E.00918
G1 X142.233 Y91.56 E.7898
G1 X142.797 Y91.56 E.00918
G1 X177.137 Y57.219 E.7898
G1 X177.702 Y57.219 E.00918
G1 X143.362 Y91.56 E.7898
G1 X143.926 Y91.56 E.00918
G1 X178.266 Y57.219 E.7898
G1 X178.831 Y57.219 E.00918
G1 X144.491 Y91.56 E.7898
G1 X145.055 Y91.56 E.00918
G1 X179.395 Y57.219 E.7898
G1 X179.96 Y57.219 E.00918
G1 X145.62 Y91.56 E.7898
G1 X146.184 Y91.56 E.00918
G1 X180.524 Y57.219 E.7898
G1 X181.089 Y57.219 E.00918
G1 X146.748 Y91.56 E.7898
G1 X147.313 Y91.56 E.00918
G1 X181.653 Y57.219 E.7898
G1 X182.218 Y57.219 E.00918
G1 X147.877 Y91.56 E.7898
G1 X148.442 Y91.56 E.00918
G1 X182.782 Y57.219 E.7898
G1 X183.347 Y57.219 E.00918
G1 X149.006 Y91.56 E.7898
G1 X149.571 Y91.56 E.00918
G1 X183.911 Y57.219 E.7898
G1 X184.476 Y57.219 E.00918
G1 X150.135 Y91.56 E.7898
G1 X150.7 Y91.56 E.00918
G1 X185.04 Y57.219 E.7898
G1 X185.605 Y57.219 E.00918
G1 X151.264 Y91.56 E.7898
G1 X151.829 Y91.56 E.00918
G1 X186.169 Y57.219 E.7898
G1 X186.734 Y57.219 E.00918
G1 X152.393 Y91.56 E.7898
G1 X152.958 Y91.56 E.00918
G1 X187.298 Y57.219 E.7898
G1 X187.863 Y57.219 E.00918
G1 X153.522 Y91.56 E.7898
G1 X154.087 Y91.56 E.00918
G1 X188.427 Y57.219 E.7898
G1 X188.992 Y57.219 E.00918
G1 X154.651 Y91.56 E.7898
G1 X155.216 Y91.56 E.00918
G1 X189.556 Y57.219 E.7898
G1 X190.121 Y57.219 E.00918
G1 X155.78 Y91.56 E.7898
G1 X156.345 Y91.56 E.00918
G1 X190.685 Y57.219 E.7898
G1 X191.25 Y57.219 E.00918
G1 X156.909 Y91.56 E.7898
G1 X157.474 Y91.56 E.00918
G1 X191.814 Y57.219 E.7898
G1 X192.379 Y57.219 E.00918
G1 X158.038 Y91.56 E.7898
G1 X158.603 Y91.56 E.00918
G1 X192.943 Y57.219 E.7898
G1 X193.507 Y57.219 E.00918
G1 X159.167 Y91.56 E.7898
G1 X159.732 Y91.56 E.00918
G1 X194.072 Y57.219 E.7898
G1 X194.636 Y57.219 E.00918
G1 X160.296 Y91.56 E.7898
G1 X160.861 Y91.56 E.00918
G1 X195.201 Y57.219 E.7898
G1 X195.765 Y57.219 E.00918
G1 X161.425 Y91.56 E.7898
G1 X161.99 Y91.56 E.00918
G1 X196.33 Y57.219 E.7898
G1 X196.894 Y57.219 E.00918
G1 X162.554 Y91.56 E.7898
G1 X163.119 Y91.56 E.00918
G1 X197.459 Y57.219 E.7898
G1 X198.023 Y57.219 E.00918
G1 X163.683 Y91.56 E.7898
M73 P55 R34
G1 X164.247 Y91.56 E.00918
G1 X198.588 Y57.219 E.7898
G1 X199.152 Y57.219 E.00918
G1 X164.812 Y91.56 E.7898
G1 X165.376 Y91.56 E.00918
G1 X199.717 Y57.219 E.7898
G1 X200.281 Y57.219 E.00918
G1 X165.941 Y91.56 E.7898
G1 X166.505 Y91.56 E.00918
G1 X200.846 Y57.219 E.7898
G1 X201.41 Y57.219 E.00918
G1 X167.07 Y91.56 E.7898
G1 X167.634 Y91.56 E.00918
G1 X201.975 Y57.219 E.7898
G1 X202.539 Y57.219 E.00918
G1 X168.199 Y91.56 E.7898
G1 X168.763 Y91.56 E.00918
G1 X203.104 Y57.219 E.7898
G1 X203.668 Y57.219 E.00918
G1 X169.328 Y91.56 E.7898
G1 X169.892 Y91.56 E.00918
G1 X204.233 Y57.219 E.7898
G1 X204.797 Y57.219 E.00918
G1 X170.457 Y91.56 E.7898
G1 X171.021 Y91.56 E.00918
G1 X205.362 Y57.219 E.7898
G1 X205.926 Y57.219 E.00918
G1 X171.586 Y91.56 E.7898
G1 X172.15 Y91.56 E.00918
G1 X206.491 Y57.219 E.7898
G1 X207.055 Y57.219 E.00918
G1 X172.715 Y91.56 E.7898
G1 X173.279 Y91.56 E.00918
G1 X207.62 Y57.219 E.7898
G1 X208.161 Y57.219 E.0088
G1 X208.161 Y57.242 E.00038
G1 X173.844 Y91.56 E.78927
G1 X174.408 Y91.56 E.00918
G1 X208.161 Y57.807 E.77628
G1 X208.161 Y58.371 E.00918
G1 X174.973 Y91.56 E.7633
G1 X175.537 Y91.56 E.00918
G1 X208.161 Y58.936 E.75032
G1 X208.161 Y59.5 E.00918
G1 X176.102 Y91.56 E.73734
G1 X176.666 Y91.56 E.00918
G1 X208.161 Y60.065 E.72435
G1 X208.161 Y60.629 E.00918
G1 X177.231 Y91.56 E.71137
G1 X177.795 Y91.56 E.00918
G1 X208.161 Y61.194 E.69839
G1 X208.161 Y61.758 E.00918
G1 X178.36 Y91.56 E.68541
G1 X178.924 Y91.56 E.00918
G1 X208.161 Y62.323 E.67242
G1 X208.161 Y62.887 E.00918
G1 X179.489 Y91.56 E.65944
G1 X180.053 Y91.56 E.00918
G1 X208.161 Y63.452 E.64646
G1 X208.161 Y64.016 E.00918
G1 X180.617 Y91.56 E.63348
G1 X181.182 Y91.56 E.00918
G1 X208.161 Y64.581 E.62049
G1 X208.161 Y65.145 E.00918
G1 X181.746 Y91.56 E.60751
G1 X182.311 Y91.56 E.00918
G1 X208.161 Y65.71 E.59453
G1 X208.161 Y66.274 E.00918
G1 X182.875 Y91.56 E.58155
M73 P55 R33
G1 X183.44 Y91.56 E.00918
G1 X208.161 Y66.839 E.56856
G1 X208.161 Y67.403 E.00918
G1 X184.004 Y91.56 E.55558
G1 X184.569 Y91.56 E.00918
G1 X208.161 Y67.968 E.5426
G1 X208.161 Y68.532 E.00918
G1 X185.133 Y91.56 E.52961
G1 X185.698 Y91.56 E.00918
G1 X208.161 Y69.097 E.51663
G1 X208.161 Y69.661 E.00918
G1 X186.262 Y91.56 E.50365
G1 X186.827 Y91.56 E.00918
G1 X208.161 Y70.226 E.49067
G1 X208.161 Y70.79 E.00918
G1 X187.391 Y91.56 E.47768
G1 X187.956 Y91.56 E.00918
G1 X208.161 Y71.355 E.4647
G1 X208.161 Y71.919 E.00918
G1 X188.52 Y91.56 E.45172
G1 X189.085 Y91.56 E.00918
G1 X208.161 Y72.484 E.43874
G1 X208.161 Y73.048 E.00918
G1 X189.649 Y91.56 E.42575
G1 X190.214 Y91.56 E.00918
G1 X208.161 Y73.612 E.41277
G1 X208.161 Y74.177 E.00918
G1 X190.778 Y91.56 E.39979
G1 X191.343 Y91.56 E.00918
G1 X208.161 Y74.741 E.38681
G1 X208.161 Y75.306 E.00918
G1 X191.907 Y91.56 E.37382
G1 X192.472 Y91.56 E.00918
G1 X208.161 Y75.87 E.36084
G1 X208.161 Y76.435 E.00918
G1 X193.036 Y91.56 E.34786
G1 X193.601 Y91.56 E.00918
G1 X208.161 Y76.999 E.33488
G1 X208.161 Y77.564 E.00918
G1 X194.165 Y91.56 E.32189
G1 X194.73 Y91.56 E.00918
G1 X208.161 Y78.128 E.30891
G1 X208.161 Y78.693 E.00918
G1 X195.294 Y91.56 E.29593
G1 X195.859 Y91.56 E.00918
G1 X208.161 Y79.257 E.28294
G1 X208.161 Y79.822 E.00918
G1 X196.423 Y91.56 E.26996
G1 X196.988 Y91.56 E.00918
G1 X208.161 Y80.386 E.25698
G1 X208.161 Y80.951 E.00918
G1 X197.552 Y91.56 E.244
G1 X198.116 Y91.56 E.00918
G1 X208.161 Y81.515 E.23101
G1 X208.161 Y82.08 E.00918
G1 X198.681 Y91.56 E.21803
G1 X199.245 Y91.56 E.00918
G1 X208.161 Y82.644 E.20505
G1 X208.161 Y83.209 E.00918
G1 X199.81 Y91.56 E.19207
G1 X200.374 Y91.56 E.00918
G1 X208.161 Y83.773 E.17908
G1 X208.161 Y84.338 E.00918
G1 X200.939 Y91.56 E.1661
G1 X201.503 Y91.56 E.00918
G1 X208.161 Y84.902 E.15312
G1 X208.161 Y85.467 E.00918
G1 X202.068 Y91.56 E.14014
G1 X202.632 Y91.56 E.00918
G1 X208.161 Y86.031 E.12715
G1 X208.161 Y86.596 E.00918
G1 X203.197 Y91.56 E.11417
G1 X203.761 Y91.56 E.00918
G1 X208.161 Y87.16 E.10119
G1 X208.161 Y87.725 E.00918
G1 X204.326 Y91.56 E.08821
G1 X204.89 Y91.56 E.00918
G1 X208.161 Y88.289 E.07522
G1 X208.161 Y88.854 E.00918
G1 X205.455 Y91.56 E.06224
G1 X206.019 Y91.56 E.00918
G1 X208.161 Y89.418 E.04926
G1 X208.161 Y89.983 E.00918
G1 X206.584 Y91.56 E.03627
G1 X207.148 Y91.56 E.00918
G1 X208.161 Y90.547 E.02329
G1 X208.161 Y91.111 E.00918
M73 P56 R33
G1 X207.533 Y91.739 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 1.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X208.161 Y91.111 E-.33727
G1 X208.161 Y90.547 E-.21451
G1 X207.774 Y90.934 E-.20822
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 13/58
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.6 I.391 J-1.152 P1  F30000
G1 X107.471 Y56.87 Z1.6
G1 Z1.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 13 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer13 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.074 Y63.29 Z1.7 F30000
G1 X107.641 Y89.45 Z1.7
G1 Z1.3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X109.751 Y91.56 E.0486
G1 X110.316 Y91.56 E.00921
G1 X107.821 Y89.064 E.05749
G1 X107.821 Y88.499 E.00921
G1 X110.882 Y91.56 E.07051
G1 X111.447 Y91.56 E.00921
G1 X107.821 Y87.933 E.08354
G1 X107.821 Y87.368 E.00921
G1 X112.012 Y91.56 E.09656
G1 X112.578 Y91.56 E.00921
G1 X107.821 Y86.803 E.10959
G1 X107.821 Y86.237 E.00921
G1 X113.143 Y91.56 E.12261
G1 X113.709 Y91.56 E.00921
G1 X107.821 Y85.672 E.13563
G1 X107.821 Y85.106 E.00921
G1 X114.274 Y91.56 E.14866
G1 X114.839 Y91.56 E.00921
G1 X107.821 Y84.541 E.16168
G1 X107.821 Y83.976 E.00921
G1 X115.405 Y91.56 E.17471
G1 X115.97 Y91.56 E.00921
G1 X107.821 Y83.41 E.18773
G1 X107.821 Y82.845 E.00921
G1 X116.535 Y91.56 E.20076
G1 X117.101 Y91.56 E.00921
G1 X107.821 Y82.28 E.21378
G1 X107.821 Y81.714 E.00921
G1 X117.666 Y91.56 E.2268
G1 X118.232 Y91.56 E.00921
G1 X107.821 Y81.149 E.23983
G1 X107.821 Y80.583 E.00921
G1 X118.797 Y91.56 E.25285
G1 X119.362 Y91.56 E.00921
G1 X107.821 Y80.018 E.26588
G1 X107.821 Y79.453 E.00921
G1 X119.928 Y91.56 E.2789
G1 X120.493 Y91.56 E.00921
G1 X107.821 Y78.887 E.29193
G1 X107.821 Y78.322 E.00921
G1 X121.059 Y91.56 E.30495
G1 X121.624 Y91.56 E.00921
G1 X107.821 Y77.756 E.31797
G1 X107.821 Y77.191 E.00921
G1 X122.189 Y91.56 E.331
G1 X122.755 Y91.56 E.00921
G1 X107.821 Y76.626 E.34402
G1 X107.821 Y76.06 E.00921
G1 X123.32 Y91.56 E.35705
G1 X123.886 Y91.56 E.00921
G1 X107.821 Y75.495 E.37007
G1 X107.821 Y74.929 E.00921
G1 X124.451 Y91.56 E.3831
G1 X125.016 Y91.56 E.00921
G1 X107.821 Y74.364 E.39612
G1 X107.821 Y73.799 E.00921
G1 X125.582 Y91.56 E.40914
G1 X126.147 Y91.56 E.00921
G1 X107.821 Y73.233 E.42217
G1 X107.821 Y72.668 E.00921
G1 X126.712 Y91.56 E.43519
G1 X127.278 Y91.56 E.00921
G1 X107.821 Y72.103 E.44822
G1 X107.821 Y71.537 E.00921
G1 X127.843 Y91.56 E.46124
G1 X128.409 Y91.56 E.00921
G1 X107.821 Y70.972 E.47427
G1 X107.821 Y70.406 E.00921
G1 X128.974 Y91.56 E.48729
G1 X129.539 Y91.56 E.00921
G1 X107.821 Y69.841 E.50031
G1 X107.821 Y69.276 E.00921
G1 X130.105 Y91.56 E.51334
G1 X130.67 Y91.56 E.00921
G1 X107.821 Y68.71 E.52636
G1 X107.821 Y68.145 E.00921
G1 X131.236 Y91.56 E.53939
G1 X131.801 Y91.56 E.00921
G1 X107.821 Y67.579 E.55241
G1 X107.821 Y67.014 E.00921
G1 X132.366 Y91.56 E.56544
G1 X132.932 Y91.56 E.00921
G1 X107.821 Y66.449 E.57846
G1 X107.821 Y65.883 E.00921
G1 X133.497 Y91.56 E.59148
G1 X134.063 Y91.56 E.00921
G1 X107.821 Y65.318 E.60451
G1 X107.821 Y64.752 E.00921
G1 X134.628 Y91.56 E.61753
G1 X135.193 Y91.56 E.00921
G1 X107.821 Y64.187 E.63056
G1 X107.821 Y63.622 E.00921
G1 X135.759 Y91.56 E.64358
G1 X136.324 Y91.56 E.00921
G1 X107.821 Y63.056 E.65661
G1 X107.821 Y62.491 E.00921
G1 X136.889 Y91.56 E.66963
G1 X137.455 Y91.56 E.00921
G1 X107.821 Y61.926 E.68265
G1 X107.821 Y61.36 E.00921
G1 X138.02 Y91.56 E.69568
G1 X138.586 Y91.56 E.00921
G1 X107.821 Y60.795 E.7087
G1 X107.821 Y60.229 E.00921
G1 X139.151 Y91.56 E.72173
G1 X139.716 Y91.56 E.00921
G1 X107.821 Y59.664 E.73475
G1 X107.821 Y59.099 E.00921
G1 X140.282 Y91.56 E.74778
G1 X140.847 Y91.56 E.00921
G1 X107.821 Y58.533 E.7608
G1 X107.821 Y57.968 E.00921
G1 X141.413 Y91.56 E.77382
G1 X141.978 Y91.56 E.00921
G1 X107.821 Y57.402 E.78685
G1 X107.821 Y57.219 E.00298
G1 X108.203 Y57.219 E.00623
G1 X142.543 Y91.56 E.79106
G1 X143.109 Y91.56 E.00921
G1 X108.768 Y57.219 E.79106
G1 X109.334 Y57.219 E.00921
G1 X143.674 Y91.56 E.79106
G1 X144.239 Y91.56 E.00921
G1 X109.899 Y57.219 E.79106
G1 X110.465 Y57.219 E.00921
G1 X144.805 Y91.56 E.79106
G1 X145.37 Y91.56 E.00921
G1 X111.03 Y57.219 E.79106
G1 X111.595 Y57.219 E.00921
G1 X145.936 Y91.56 E.79106
G1 X146.501 Y91.56 E.00921
G1 X112.161 Y57.219 E.79106
G1 X112.726 Y57.219 E.00921
G1 X147.066 Y91.56 E.79106
G1 X147.632 Y91.56 E.00921
G1 X113.291 Y57.219 E.79106
G1 X113.857 Y57.219 E.00921
G1 X148.197 Y91.56 E.79106
M73 P56 R32
G1 X148.763 Y91.56 E.00921
G1 X114.422 Y57.219 E.79106
G1 X114.988 Y57.219 E.00921
G1 X149.328 Y91.56 E.79106
G1 X149.893 Y91.56 E.00921
G1 X115.553 Y57.219 E.79106
G1 X116.118 Y57.219 E.00921
G1 X150.459 Y91.56 E.79106
G1 X151.024 Y91.56 E.00921
G1 X116.684 Y57.219 E.79106
G1 X117.249 Y57.219 E.00921
G1 X151.59 Y91.56 E.79106
G1 X152.155 Y91.56 E.00921
G1 X117.815 Y57.219 E.79106
G1 X118.38 Y57.219 E.00921
G1 X152.72 Y91.56 E.79106
G1 X153.286 Y91.56 E.00921
G1 X118.945 Y57.219 E.79106
G1 X119.511 Y57.219 E.00921
G1 X153.851 Y91.56 E.79106
G1 X154.416 Y91.56 E.00921
G1 X120.076 Y57.219 E.79106
G1 X120.642 Y57.219 E.00921
G1 X154.982 Y91.56 E.79106
G1 X155.547 Y91.56 E.00921
G1 X121.207 Y57.219 E.79106
G1 X121.772 Y57.219 E.00921
G1 X156.113 Y91.56 E.79106
G1 X156.678 Y91.56 E.00921
G1 X122.338 Y57.219 E.79106
G1 X122.903 Y57.219 E.00921
G1 X157.243 Y91.56 E.79106
G1 X157.809 Y91.56 E.00921
G1 X123.468 Y57.219 E.79106
G1 X124.034 Y57.219 E.00921
G1 X158.374 Y91.56 E.79106
G1 X158.94 Y91.56 E.00921
G1 X124.599 Y57.219 E.79106
G1 X125.165 Y57.219 E.00921
G1 X159.505 Y91.56 E.79106
G1 X160.07 Y91.56 E.00921
G1 X125.73 Y57.219 E.79106
G1 X126.295 Y57.219 E.00921
G1 X160.636 Y91.56 E.79106
G1 X161.201 Y91.56 E.00921
G1 X126.861 Y57.219 E.79106
G1 X127.426 Y57.219 E.00921
G1 X161.767 Y91.56 E.79106
G1 X162.332 Y91.56 E.00921
G1 X127.992 Y57.219 E.79106
G1 X128.557 Y57.219 E.00921
G1 X162.897 Y91.56 E.79106
G1 X163.463 Y91.56 E.00921
G1 X129.122 Y57.219 E.79106
M73 P57 R32
G1 X129.688 Y57.219 E.00921
G1 X164.028 Y91.56 E.79106
G1 X164.593 Y91.56 E.00921
G1 X130.253 Y57.219 E.79106
G1 X130.819 Y57.219 E.00921
G1 X165.159 Y91.56 E.79106
G1 X165.724 Y91.56 E.00921
G1 X131.384 Y57.219 E.79106
G1 X131.949 Y57.219 E.00921
G1 X166.29 Y91.56 E.79106
G1 X166.855 Y91.56 E.00921
G1 X132.515 Y57.219 E.79106
G1 X133.08 Y57.219 E.00921
G1 X167.42 Y91.56 E.79106
G1 X167.986 Y91.56 E.00921
G1 X133.645 Y57.219 E.79106
G1 X134.211 Y57.219 E.00921
G1 X168.551 Y91.56 E.79106
G1 X169.117 Y91.56 E.00921
G1 X134.776 Y57.219 E.79106
G1 X135.342 Y57.219 E.00921
G1 X169.682 Y91.56 E.79106
G1 X170.247 Y91.56 E.00921
G1 X135.907 Y57.219 E.79106
G1 X136.472 Y57.219 E.00921
G1 X170.813 Y91.56 E.79106
G1 X171.378 Y91.56 E.00921
G1 X137.038 Y57.219 E.79106
G1 X137.603 Y57.219 E.00921
G1 X171.944 Y91.56 E.79106
G1 X172.509 Y91.56 E.00921
G1 X138.169 Y57.219 E.79106
G1 X138.734 Y57.219 E.00921
G1 X173.074 Y91.56 E.79106
G1 X173.64 Y91.56 E.00921
G1 X139.299 Y57.219 E.79106
G1 X139.865 Y57.219 E.00921
G1 X174.205 Y91.56 E.79106
G1 X174.77 Y91.56 E.00921
G1 X140.43 Y57.219 E.79106
G1 X140.996 Y57.219 E.00921
G1 X175.336 Y91.56 E.79106
G1 X175.901 Y91.56 E.00921
G1 X141.561 Y57.219 E.79106
G1 X142.126 Y57.219 E.00921
G1 X176.467 Y91.56 E.79106
G1 X177.032 Y91.56 E.00921
G1 X142.692 Y57.219 E.79106
G1 X143.257 Y57.219 E.00921
G1 X177.597 Y91.56 E.79106
G1 X178.163 Y91.56 E.00921
G1 X143.822 Y57.219 E.79106
G1 X144.388 Y57.219 E.00921
G1 X178.728 Y91.56 E.79106
G1 X179.294 Y91.56 E.00921
G1 X144.953 Y57.219 E.79106
G1 X145.519 Y57.219 E.00921
G1 X179.859 Y91.56 E.79106
G1 X180.424 Y91.56 E.00921
G1 X146.084 Y57.219 E.79106
G1 X146.649 Y57.219 E.00921
G1 X180.99 Y91.56 E.79106
G1 X181.555 Y91.56 E.00921
G1 X147.215 Y57.219 E.79106
G1 X147.78 Y57.219 E.00921
G1 X182.121 Y91.56 E.79106
G1 X182.686 Y91.56 E.00921
G1 X148.346 Y57.219 E.79106
G1 X148.911 Y57.219 E.00921
G1 X183.251 Y91.56 E.79106
G1 X183.817 Y91.56 E.00921
G1 X149.476 Y57.219 E.79106
G1 X150.042 Y57.219 E.00921
G1 X184.382 Y91.56 E.79106
G1 X184.947 Y91.56 E.00921
G1 X150.607 Y57.219 E.79106
G1 X151.172 Y57.219 E.00921
G1 X185.513 Y91.56 E.79106
G1 X186.078 Y91.56 E.00921
G1 X151.738 Y57.219 E.79106
G1 X152.303 Y57.219 E.00921
G1 X186.644 Y91.56 E.79106
G1 X187.209 Y91.56 E.00921
G1 X152.869 Y57.219 E.79106
G1 X153.434 Y57.219 E.00921
G1 X187.774 Y91.56 E.79106
G1 X188.34 Y91.56 E.00921
G1 X153.999 Y57.219 E.79106
G1 X154.565 Y57.219 E.00921
G1 X188.905 Y91.56 E.79106
G1 X189.471 Y91.56 E.00921
G1 X155.13 Y57.219 E.79106
G1 X155.696 Y57.219 E.00921
G1 X190.036 Y91.56 E.79106
G1 X190.601 Y91.56 E.00921
G1 X156.261 Y57.219 E.79106
G1 X156.826 Y57.219 E.00921
G1 X191.167 Y91.56 E.79106
G1 X191.732 Y91.56 E.00921
G1 X157.392 Y57.219 E.79106
G1 X157.957 Y57.219 E.00921
G1 X192.298 Y91.56 E.79106
G1 X192.863 Y91.56 E.00921
G1 X158.523 Y57.219 E.79106
G1 X159.088 Y57.219 E.00921
G1 X193.428 Y91.56 E.79106
G1 X193.994 Y91.56 E.00921
G1 X159.653 Y57.219 E.79106
G1 X160.219 Y57.219 E.00921
G1 X194.559 Y91.56 E.79106
G1 X195.124 Y91.56 E.00921
G1 X160.784 Y57.219 E.79106
G1 X161.349 Y57.219 E.00921
G1 X195.69 Y91.56 E.79106
G1 X196.255 Y91.56 E.00921
G1 X161.915 Y57.219 E.79106
G1 X162.48 Y57.219 E.00921
G1 X196.821 Y91.56 E.79106
G1 X197.386 Y91.56 E.00921
G1 X163.046 Y57.219 E.79106
G1 X163.611 Y57.219 E.00921
G1 X197.951 Y91.56 E.79106
G1 X198.517 Y91.56 E.00921
G1 X164.176 Y57.219 E.79106
G1 X164.742 Y57.219 E.00921
G1 X199.082 Y91.56 E.79106
G1 X199.648 Y91.56 E.00921
G1 X165.307 Y57.219 E.79106
G1 X165.873 Y57.219 E.00921
G1 X200.213 Y91.56 E.79106
G1 X200.778 Y91.56 E.00921
G1 X166.438 Y57.219 E.79106
G1 X167.003 Y57.219 E.00921
G1 X201.344 Y91.56 E.79106
G1 X201.909 Y91.56 E.00921
G1 X167.569 Y57.219 E.79106
G1 X168.134 Y57.219 E.00921
G1 X202.475 Y91.56 E.79106
G1 X203.04 Y91.56 E.00921
G1 X168.7 Y57.219 E.79106
G1 X169.265 Y57.219 E.00921
G1 X203.605 Y91.56 E.79106
G1 X204.171 Y91.56 E.00921
G1 X169.83 Y57.219 E.79106
G1 X170.396 Y57.219 E.00921
G1 X204.736 Y91.56 E.79106
G1 X205.301 Y91.56 E.00921
G1 X170.961 Y57.219 E.79106
G1 X171.526 Y57.219 E.00921
G1 X205.867 Y91.56 E.79106
G1 X206.432 Y91.56 E.00921
G1 X172.092 Y57.219 E.79106
G1 X172.657 Y57.219 E.00921
G1 X206.998 Y91.56 E.79106
G1 X207.563 Y91.56 E.00921
G1 X173.223 Y57.219 E.79106
G1 X173.788 Y57.219 E.00921
M73 P58 R32
G1 X208.128 Y91.56 E.79106
G1 X208.161 Y91.56 E.00053
G1 X208.161 Y91.027 E.00868
G1 X174.353 Y57.219 E.77879
G1 X174.919 Y57.219 E.00921
G1 X208.161 Y90.462 E.76577
G1 X208.161 Y89.896 E.00921
G1 X175.484 Y57.219 E.75274
G1 X176.05 Y57.219 E.00921
G1 X208.161 Y89.331 E.73972
M73 P58 R31
G1 X208.161 Y88.765 E.00921
G1 X176.615 Y57.219 E.72669
G1 X177.18 Y57.219 E.00921
G1 X208.161 Y88.2 E.71367
G1 X208.161 Y87.635 E.00921
G1 X177.746 Y57.219 E.70064
G1 X178.311 Y57.219 E.00921
G1 X208.161 Y87.069 E.68762
G1 X208.161 Y86.504 E.00921
G1 X178.877 Y57.219 E.6746
G1 X179.442 Y57.219 E.00921
G1 X208.161 Y85.938 E.66157
G1 X208.161 Y85.373 E.00921
G1 X180.007 Y57.219 E.64855
G1 X180.573 Y57.219 E.00921
G1 X208.161 Y84.808 E.63552
G1 X208.161 Y84.242 E.00921
G1 X181.138 Y57.219 E.6225
G1 X181.703 Y57.219 E.00921
G1 X208.161 Y83.677 E.60947
G1 X208.161 Y83.111 E.00921
G1 X182.269 Y57.219 E.59645
G1 X182.834 Y57.219 E.00921
G1 X208.161 Y82.546 E.58343
G1 X208.161 Y81.981 E.00921
G1 X183.4 Y57.219 E.5704
G1 X183.965 Y57.219 E.00921
G1 X208.161 Y81.415 E.55738
G1 X208.161 Y80.85 E.00921
G1 X184.53 Y57.219 E.54435
G1 X185.096 Y57.219 E.00921
G1 X208.161 Y80.285 E.53133
G1 X208.161 Y79.719 E.00921
G1 X185.661 Y57.219 E.5183
G1 X186.227 Y57.219 E.00921
G1 X208.161 Y79.154 E.50528
G1 X208.161 Y78.588 E.00921
G1 X186.792 Y57.219 E.49226
G1 X187.357 Y57.219 E.00921
G1 X208.161 Y78.023 E.47923
G1 X208.161 Y77.458 E.00921
G1 X187.923 Y57.219 E.46621
G1 X188.488 Y57.219 E.00921
G1 X208.161 Y76.892 E.45318
G1 X208.161 Y76.327 E.00921
G1 X189.054 Y57.219 E.44016
G1 X189.619 Y57.219 E.00921
G1 X208.161 Y75.761 E.42713
G1 X208.161 Y75.196 E.00921
G1 X190.184 Y57.219 E.41411
G1 X190.75 Y57.219 E.00921
G1 X208.161 Y74.631 E.40109
G1 X208.161 Y74.065 E.00921
G1 X191.315 Y57.219 E.38806
G1 X191.88 Y57.219 E.00921
G1 X208.161 Y73.5 E.37504
G1 X208.161 Y72.934 E.00921
G1 X192.446 Y57.219 E.36201
G1 X193.011 Y57.219 E.00921
G1 X208.161 Y72.369 E.34899
G1 X208.161 Y71.804 E.00921
G1 X193.577 Y57.219 E.33596
G1 X194.142 Y57.219 E.00921
G1 X208.161 Y71.238 E.32294
G1 X208.161 Y70.673 E.00921
G1 X194.707 Y57.219 E.30992
G1 X195.273 Y57.219 E.00921
G1 X208.161 Y70.108 E.29689
G1 X208.161 Y69.542 E.00921
G1 X195.838 Y57.219 E.28387
G1 X196.404 Y57.219 E.00921
G1 X208.161 Y68.977 E.27084
G1 X208.161 Y68.411 E.00921
G1 X196.969 Y57.219 E.25782
G1 X197.534 Y57.219 E.00921
G1 X208.161 Y67.846 E.24479
G1 X208.161 Y67.281 E.00921
G1 X198.1 Y57.219 E.23177
G1 X198.665 Y57.219 E.00921
G1 X208.161 Y66.715 E.21875
G1 X208.161 Y66.15 E.00921
G1 X199.231 Y57.219 E.20572
G1 X199.796 Y57.219 E.00921
G1 X208.161 Y65.584 E.1927
G1 X208.161 Y65.019 E.00921
G1 X200.361 Y57.219 E.17967
G1 X200.927 Y57.219 E.00921
G1 X208.161 Y64.454 E.16665
G1 X208.161 Y63.888 E.00921
G1 X201.492 Y57.219 E.15362
G1 X202.057 Y57.219 E.00921
G1 X208.161 Y63.323 E.1406
G1 X208.161 Y62.758 E.00921
G1 X202.623 Y57.219 E.12758
G1 X203.188 Y57.219 E.00921
G1 X208.161 Y62.192 E.11455
G1 X208.161 Y61.627 E.00921
G1 X203.754 Y57.219 E.10153
G1 X204.319 Y57.219 E.00921
G1 X208.161 Y61.061 E.0885
G1 X208.161 Y60.496 E.00921
G1 X204.884 Y57.219 E.07548
G1 X205.45 Y57.219 E.00921
G1 X208.161 Y59.931 E.06245
G1 X208.161 Y59.365 E.00921
G1 X206.015 Y57.219 E.04943
G1 X206.581 Y57.219 E.00921
G1 X208.161 Y58.8 E.03641
G1 X208.161 Y58.234 E.00921
G1 X207.146 Y57.219 E.02338
G1 X207.711 Y57.219 E.00921
G1 X208.34 Y57.848 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X207.711 Y57.219 E-.338
G1 X207.146 Y57.219 E-.21485
G1 X207.531 Y57.605 E-.20715
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 14/58
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.7 I.009 J-1.217 P1  F30000
G1 X107.471 Y56.87 Z1.7
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 14 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer14 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.641 Y57.849 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X108.27 Y57.219 E.01447
G1 X108.835 Y57.219 E.00918
G1 X107.821 Y58.234 E.02333
G1 X107.821 Y58.798 E.00918
M73 P59 R31
G1 X109.399 Y57.219 E.03631
G1 X109.964 Y57.219 E.00918
G1 X107.821 Y59.363 E.04929
G1 X107.821 Y59.927 E.00918
G1 X110.528 Y57.219 E.06228
G1 X111.093 Y57.219 E.00918
G1 X107.821 Y60.492 E.07526
G1 X107.821 Y61.056 E.00918
G1 X111.657 Y57.219 E.08824
G1 X112.222 Y57.219 E.00918
G1 X107.821 Y61.621 E.10123
G1 X107.821 Y62.185 E.00918
G1 X112.786 Y57.219 E.11421
G1 X113.351 Y57.219 E.00918
G1 X107.821 Y62.75 E.12719
G1 X107.821 Y63.314 E.00918
G1 X113.915 Y57.219 E.14017
G1 X114.48 Y57.219 E.00918
G1 X107.821 Y63.879 E.15316
G1 X107.821 Y64.443 E.00918
G1 X115.044 Y57.219 E.16614
G1 X115.609 Y57.219 E.00918
G1 X107.821 Y65.008 E.17912
G1 X107.821 Y65.572 E.00918
G1 X116.173 Y57.219 E.1921
G1 X116.738 Y57.219 E.00918
G1 X107.821 Y66.137 E.20509
G1 X107.821 Y66.701 E.00918
G1 X117.302 Y57.219 E.21807
G1 X117.867 Y57.219 E.00918
G1 X107.821 Y67.265 E.23105
G1 X107.821 Y67.83 E.00918
G1 X118.431 Y57.219 E.24403
G1 X118.996 Y57.219 E.00918
G1 X107.821 Y68.394 E.25702
G1 X107.821 Y68.959 E.00918
G1 X119.56 Y57.219 E.27
G1 X120.125 Y57.219 E.00918
G1 X107.821 Y69.523 E.28298
G1 X107.821 Y70.088 E.00918
G1 X120.689 Y57.219 E.29596
G1 X121.254 Y57.219 E.00918
G1 X107.821 Y70.652 E.30895
G1 X107.821 Y71.217 E.00918
G1 X121.818 Y57.219 E.32193
G1 X122.383 Y57.219 E.00918
G1 X107.821 Y71.781 E.33491
G1 X107.821 Y72.346 E.00918
G1 X122.947 Y57.219 E.3479
G1 X123.512 Y57.219 E.00918
G1 X107.821 Y72.91 E.36088
G1 X107.821 Y73.475 E.00918
G1 X124.076 Y57.219 E.37386
G1 X124.641 Y57.219 E.00918
G1 X107.821 Y74.039 E.38684
G1 X107.821 Y74.604 E.00918
G1 X125.205 Y57.219 E.39983
G1 X125.769 Y57.219 E.00918
G1 X107.821 Y75.168 E.41281
G1 X107.821 Y75.733 E.00918
G1 X126.334 Y57.219 E.42579
G1 X126.898 Y57.219 E.00918
G1 X107.821 Y76.297 E.43877
G1 X107.821 Y76.862 E.00918
G1 X127.463 Y57.219 E.45176
G1 X128.027 Y57.219 E.00918
G1 X107.821 Y77.426 E.46474
G1 X107.821 Y77.991 E.00918
G1 X128.592 Y57.219 E.47772
G1 X129.156 Y57.219 E.00918
G1 X107.821 Y78.555 E.4907
G1 X107.821 Y79.12 E.00918
G1 X129.721 Y57.219 E.50369
G1 X130.285 Y57.219 E.00918
G1 X107.821 Y79.684 E.51667
G1 X107.821 Y80.249 E.00918
G1 X130.85 Y57.219 E.52965
G1 X131.414 Y57.219 E.00918
G1 X107.821 Y80.813 E.54263
G1 X107.821 Y81.378 E.00918
G1 X131.979 Y57.219 E.55562
G1 X132.543 Y57.219 E.00918
G1 X107.821 Y81.942 E.5686
G1 X107.821 Y82.507 E.00918
M73 P59 R30
G1 X133.108 Y57.219 E.58158
G1 X133.672 Y57.219 E.00918
G1 X107.821 Y83.071 E.59457
G1 X107.821 Y83.636 E.00918
G1 X134.237 Y57.219 E.60755
G1 X134.801 Y57.219 E.00918
G1 X107.821 Y84.2 E.62053
G1 X107.821 Y84.764 E.00918
G1 X135.366 Y57.219 E.63351
G1 X135.93 Y57.219 E.00918
G1 X107.821 Y85.329 E.6465
G1 X107.821 Y85.893 E.00918
G1 X136.495 Y57.219 E.65948
G1 X137.059 Y57.219 E.00918
G1 X107.821 Y86.458 E.67246
G1 X107.821 Y87.022 E.00918
G1 X137.624 Y57.219 E.68544
G1 X138.188 Y57.219 E.00918
G1 X107.821 Y87.587 E.69843
G1 X107.821 Y88.151 E.00918
G1 X138.753 Y57.219 E.71141
G1 X139.317 Y57.219 E.00918
G1 X107.821 Y88.716 E.72439
G1 X107.821 Y89.28 E.00918
G1 X139.882 Y57.219 E.73737
G1 X140.446 Y57.219 E.00918
G1 X107.927 Y89.738 E.7479
G1 X108.209 Y90.02 E.00649
G1 X141.011 Y57.219 E.7544
G1 X141.575 Y57.219 E.00918
G1 X108.492 Y90.303 E.76089
G1 X108.774 Y90.585 E.00649
G1 X142.14 Y57.219 E.76738
G1 X142.704 Y57.219 E.00918
G1 X109.056 Y90.867 E.77387
G1 X109.338 Y91.149 E.00649
G1 X143.268 Y57.219 E.78036
G1 X143.833 Y57.219 E.00918
G1 X109.621 Y91.432 E.78685
G1 X109.749 Y91.56 E.00295
G1 X110.057 Y91.56 E.00501
G1 X144.397 Y57.219 E.7898
G1 X144.962 Y57.219 E.00918
G1 X110.622 Y91.56 E.7898
G1 X111.186 Y91.56 E.00918
G1 X145.526 Y57.219 E.7898
G1 X146.091 Y57.219 E.00918
G1 X111.751 Y91.56 E.7898
G1 X112.315 Y91.56 E.00918
G1 X146.655 Y57.219 E.7898
G1 X147.22 Y57.219 E.00918
G1 X112.879 Y91.56 E.7898
G1 X113.444 Y91.56 E.00918
G1 X147.784 Y57.219 E.7898
G1 X148.349 Y57.219 E.00918
G1 X114.008 Y91.56 E.7898
G1 X114.573 Y91.56 E.00918
G1 X148.913 Y57.219 E.7898
G1 X149.478 Y57.219 E.00918
G1 X115.137 Y91.56 E.7898
G1 X115.702 Y91.56 E.00918
G1 X150.042 Y57.219 E.7898
G1 X150.607 Y57.219 E.00918
G1 X116.266 Y91.56 E.7898
G1 X116.831 Y91.56 E.00918
G1 X151.171 Y57.219 E.7898
G1 X151.736 Y57.219 E.00918
G1 X117.395 Y91.56 E.7898
G1 X117.96 Y91.56 E.00918
G1 X152.3 Y57.219 E.7898
G1 X152.865 Y57.219 E.00918
G1 X118.524 Y91.56 E.7898
G1 X119.089 Y91.56 E.00918
G1 X153.429 Y57.219 E.7898
G1 X153.994 Y57.219 E.00918
G1 X119.653 Y91.56 E.7898
G1 X120.218 Y91.56 E.00918
G1 X154.558 Y57.219 E.7898
G1 X155.123 Y57.219 E.00918
G1 X120.782 Y91.56 E.7898
G1 X121.347 Y91.56 E.00918
G1 X155.687 Y57.219 E.7898
G1 X156.252 Y57.219 E.00918
G1 X121.911 Y91.56 E.7898
G1 X122.476 Y91.56 E.00918
G1 X156.816 Y57.219 E.7898
G1 X157.381 Y57.219 E.00918
G1 X123.04 Y91.56 E.7898
G1 X123.605 Y91.56 E.00918
G1 X157.945 Y57.219 E.7898
G1 X158.51 Y57.219 E.00918
G1 X124.169 Y91.56 E.7898
G1 X124.734 Y91.56 E.00918
G1 X159.074 Y57.219 E.7898
G1 X159.638 Y57.219 E.00918
G1 X125.298 Y91.56 E.7898
G1 X125.863 Y91.56 E.00918
G1 X160.203 Y57.219 E.7898
G1 X160.767 Y57.219 E.00918
G1 X126.427 Y91.56 E.7898
G1 X126.992 Y91.56 E.00918
G1 X161.332 Y57.219 E.7898
G1 X161.896 Y57.219 E.00918
G1 X127.556 Y91.56 E.7898
G1 X128.121 Y91.56 E.00918
G1 X162.461 Y57.219 E.7898
G1 X163.025 Y57.219 E.00918
G1 X128.685 Y91.56 E.7898
G1 X129.25 Y91.56 E.00918
G1 X163.59 Y57.219 E.7898
G1 X164.154 Y57.219 E.00918
G1 X129.814 Y91.56 E.7898
G1 X130.378 Y91.56 E.00918
G1 X164.719 Y57.219 E.7898
G1 X165.283 Y57.219 E.00918
G1 X130.943 Y91.56 E.7898
G1 X131.507 Y91.56 E.00918
G1 X165.848 Y57.219 E.7898
G1 X166.412 Y57.219 E.00918
G1 X132.072 Y91.56 E.7898
G1 X132.636 Y91.56 E.00918
G1 X166.977 Y57.219 E.7898
G1 X167.541 Y57.219 E.00918
G1 X133.201 Y91.56 E.7898
G1 X133.765 Y91.56 E.00918
G1 X168.106 Y57.219 E.7898
G1 X168.67 Y57.219 E.00918
G1 X134.33 Y91.56 E.7898
G1 X134.894 Y91.56 E.00918
G1 X169.235 Y57.219 E.7898
G1 X169.799 Y57.219 E.00918
G1 X135.459 Y91.56 E.7898
G1 X136.023 Y91.56 E.00918
G1 X170.364 Y57.219 E.7898
G1 X170.928 Y57.219 E.00918
G1 X136.588 Y91.56 E.7898
G1 X137.152 Y91.56 E.00918
G1 X171.493 Y57.219 E.7898
G1 X172.057 Y57.219 E.00918
G1 X137.717 Y91.56 E.7898
G1 X138.281 Y91.56 E.00918
G1 X172.622 Y57.219 E.7898
G1 X173.186 Y57.219 E.00918
G1 X138.846 Y91.56 E.7898
G1 X139.41 Y91.56 E.00918
G1 X173.751 Y57.219 E.7898
G1 X174.315 Y57.219 E.00918
M73 P60 R30
G1 X139.975 Y91.56 E.7898
G1 X140.539 Y91.56 E.00918
G1 X174.88 Y57.219 E.7898
G1 X175.444 Y57.219 E.00918
G1 X141.104 Y91.56 E.7898
G1 X141.668 Y91.56 E.00918
G1 X176.009 Y57.219 E.7898
G1 X176.573 Y57.219 E.00918
G1 X142.233 Y91.56 E.7898
G1 X142.797 Y91.56 E.00918
G1 X177.137 Y57.219 E.7898
G1 X177.702 Y57.219 E.00918
G1 X143.362 Y91.56 E.7898
G1 X143.926 Y91.56 E.00918
G1 X178.266 Y57.219 E.7898
G1 X178.831 Y57.219 E.00918
G1 X144.491 Y91.56 E.7898
G1 X145.055 Y91.56 E.00918
G1 X179.395 Y57.219 E.7898
G1 X179.96 Y57.219 E.00918
G1 X145.62 Y91.56 E.7898
G1 X146.184 Y91.56 E.00918
G1 X180.524 Y57.219 E.7898
G1 X181.089 Y57.219 E.00918
G1 X146.748 Y91.56 E.7898
G1 X147.313 Y91.56 E.00918
G1 X181.653 Y57.219 E.7898
G1 X182.218 Y57.219 E.00918
G1 X147.877 Y91.56 E.7898
G1 X148.442 Y91.56 E.00918
G1 X182.782 Y57.219 E.7898
G1 X183.347 Y57.219 E.00918
G1 X149.006 Y91.56 E.7898
G1 X149.571 Y91.56 E.00918
G1 X183.911 Y57.219 E.7898
G1 X184.476 Y57.219 E.00918
G1 X150.135 Y91.56 E.7898
G1 X150.7 Y91.56 E.00918
G1 X185.04 Y57.219 E.7898
G1 X185.605 Y57.219 E.00918
G1 X151.264 Y91.56 E.7898
G1 X151.829 Y91.56 E.00918
G1 X186.169 Y57.219 E.7898
G1 X186.734 Y57.219 E.00918
G1 X152.393 Y91.56 E.7898
G1 X152.958 Y91.56 E.00918
G1 X187.298 Y57.219 E.7898
G1 X187.863 Y57.219 E.00918
G1 X153.522 Y91.56 E.7898
G1 X154.087 Y91.56 E.00918
G1 X188.427 Y57.219 E.7898
G1 X188.992 Y57.219 E.00918
G1 X154.651 Y91.56 E.7898
G1 X155.216 Y91.56 E.00918
G1 X189.556 Y57.219 E.7898
G1 X190.121 Y57.219 E.00918
G1 X155.78 Y91.56 E.7898
G1 X156.345 Y91.56 E.00918
G1 X190.685 Y57.219 E.7898
G1 X191.25 Y57.219 E.00918
G1 X156.909 Y91.56 E.7898
G1 X157.474 Y91.56 E.00918
G1 X191.814 Y57.219 E.7898
G1 X192.379 Y57.219 E.00918
G1 X158.038 Y91.56 E.7898
G1 X158.603 Y91.56 E.00918
G1 X192.943 Y57.219 E.7898
G1 X193.507 Y57.219 E.00918
G1 X159.167 Y91.56 E.7898
G1 X159.732 Y91.56 E.00918
G1 X194.072 Y57.219 E.7898
G1 X194.636 Y57.219 E.00918
G1 X160.296 Y91.56 E.7898
G1 X160.861 Y91.56 E.00918
G1 X195.201 Y57.219 E.7898
G1 X195.765 Y57.219 E.00918
G1 X161.425 Y91.56 E.7898
G1 X161.99 Y91.56 E.00918
G1 X196.33 Y57.219 E.7898
G1 X196.894 Y57.219 E.00918
G1 X162.554 Y91.56 E.7898
G1 X163.119 Y91.56 E.00918
G1 X197.459 Y57.219 E.7898
G1 X198.023 Y57.219 E.00918
G1 X163.683 Y91.56 E.7898
G1 X164.247 Y91.56 E.00918
G1 X198.588 Y57.219 E.7898
G1 X199.152 Y57.219 E.00918
G1 X164.812 Y91.56 E.7898
G1 X165.376 Y91.56 E.00918
G1 X199.717 Y57.219 E.7898
G1 X200.281 Y57.219 E.00918
G1 X165.941 Y91.56 E.7898
G1 X166.505 Y91.56 E.00918
G1 X200.846 Y57.219 E.7898
G1 X201.41 Y57.219 E.00918
G1 X167.07 Y91.56 E.7898
G1 X167.634 Y91.56 E.00918
G1 X201.975 Y57.219 E.7898
G1 X202.539 Y57.219 E.00918
G1 X168.199 Y91.56 E.7898
G1 X168.763 Y91.56 E.00918
G1 X203.104 Y57.219 E.7898
G1 X203.668 Y57.219 E.00918
G1 X169.328 Y91.56 E.7898
G1 X169.892 Y91.56 E.00918
M73 P60 R29
G1 X204.233 Y57.219 E.7898
G1 X204.797 Y57.219 E.00918
G1 X170.457 Y91.56 E.7898
G1 X171.021 Y91.56 E.00918
G1 X205.362 Y57.219 E.7898
G1 X205.926 Y57.219 E.00918
G1 X171.586 Y91.56 E.7898
G1 X172.15 Y91.56 E.00918
G1 X206.491 Y57.219 E.7898
G1 X207.055 Y57.219 E.00918
G1 X172.715 Y91.56 E.7898
G1 X173.279 Y91.56 E.00918
G1 X207.62 Y57.219 E.7898
G1 X208.161 Y57.219 E.0088
G1 X208.161 Y57.242 E.00038
G1 X173.844 Y91.56 E.78927
G1 X174.408 Y91.56 E.00918
G1 X208.161 Y57.807 E.77628
G1 X208.161 Y58.371 E.00918
G1 X174.973 Y91.56 E.7633
G1 X175.537 Y91.56 E.00918
G1 X208.161 Y58.936 E.75032
G1 X208.161 Y59.5 E.00918
G1 X176.102 Y91.56 E.73734
G1 X176.666 Y91.56 E.00918
G1 X208.161 Y60.065 E.72435
G1 X208.161 Y60.629 E.00918
G1 X177.231 Y91.56 E.71137
G1 X177.795 Y91.56 E.00918
G1 X208.161 Y61.194 E.69839
G1 X208.161 Y61.758 E.00918
G1 X178.36 Y91.56 E.68541
G1 X178.924 Y91.56 E.00918
G1 X208.161 Y62.323 E.67242
G1 X208.161 Y62.887 E.00918
G1 X179.489 Y91.56 E.65944
G1 X180.053 Y91.56 E.00918
G1 X208.161 Y63.452 E.64646
G1 X208.161 Y64.016 E.00918
G1 X180.617 Y91.56 E.63348
G1 X181.182 Y91.56 E.00918
G1 X208.161 Y64.581 E.62049
G1 X208.161 Y65.145 E.00918
G1 X181.746 Y91.56 E.60751
G1 X182.311 Y91.56 E.00918
G1 X208.161 Y65.71 E.59453
G1 X208.161 Y66.274 E.00918
G1 X182.875 Y91.56 E.58155
M73 P61 R29
G1 X183.44 Y91.56 E.00918
G1 X208.161 Y66.839 E.56856
G1 X208.161 Y67.403 E.00918
G1 X184.004 Y91.56 E.55558
G1 X184.569 Y91.56 E.00918
G1 X208.161 Y67.968 E.5426
G1 X208.161 Y68.532 E.00918
G1 X185.133 Y91.56 E.52961
G1 X185.698 Y91.56 E.00918
G1 X208.161 Y69.097 E.51663
G1 X208.161 Y69.661 E.00918
G1 X186.262 Y91.56 E.50365
G1 X186.827 Y91.56 E.00918
G1 X208.161 Y70.226 E.49067
G1 X208.161 Y70.79 E.00918
G1 X187.391 Y91.56 E.47768
G1 X187.956 Y91.56 E.00918
G1 X208.161 Y71.355 E.4647
G1 X208.161 Y71.919 E.00918
G1 X188.52 Y91.56 E.45172
G1 X189.085 Y91.56 E.00918
G1 X208.161 Y72.484 E.43874
G1 X208.161 Y73.048 E.00918
G1 X189.649 Y91.56 E.42575
G1 X190.214 Y91.56 E.00918
G1 X208.161 Y73.612 E.41277
G1 X208.161 Y74.177 E.00918
G1 X190.778 Y91.56 E.39979
G1 X191.343 Y91.56 E.00918
G1 X208.161 Y74.741 E.38681
G1 X208.161 Y75.306 E.00918
G1 X191.907 Y91.56 E.37382
G1 X192.472 Y91.56 E.00918
G1 X208.161 Y75.87 E.36084
G1 X208.161 Y76.435 E.00918
G1 X193.036 Y91.56 E.34786
G1 X193.601 Y91.56 E.00918
G1 X208.161 Y76.999 E.33488
G1 X208.161 Y77.564 E.00918
G1 X194.165 Y91.56 E.32189
G1 X194.73 Y91.56 E.00918
G1 X208.161 Y78.128 E.30891
G1 X208.161 Y78.693 E.00918
G1 X195.294 Y91.56 E.29593
G1 X195.859 Y91.56 E.00918
G1 X208.161 Y79.257 E.28294
G1 X208.161 Y79.822 E.00918
G1 X196.423 Y91.56 E.26996
G1 X196.988 Y91.56 E.00918
G1 X208.161 Y80.386 E.25698
G1 X208.161 Y80.951 E.00918
G1 X197.552 Y91.56 E.244
G1 X198.116 Y91.56 E.00918
G1 X208.161 Y81.515 E.23101
G1 X208.161 Y82.08 E.00918
G1 X198.681 Y91.56 E.21803
G1 X199.245 Y91.56 E.00918
G1 X208.161 Y82.644 E.20505
G1 X208.161 Y83.209 E.00918
G1 X199.81 Y91.56 E.19207
G1 X200.374 Y91.56 E.00918
G1 X208.161 Y83.773 E.17908
G1 X208.161 Y84.338 E.00918
G1 X200.939 Y91.56 E.1661
G1 X201.503 Y91.56 E.00918
G1 X208.161 Y84.902 E.15312
G1 X208.161 Y85.467 E.00918
G1 X202.068 Y91.56 E.14014
G1 X202.632 Y91.56 E.00918
G1 X208.161 Y86.031 E.12715
G1 X208.161 Y86.596 E.00918
G1 X203.197 Y91.56 E.11417
G1 X203.761 Y91.56 E.00918
G1 X208.161 Y87.16 E.10119
G1 X208.161 Y87.725 E.00918
G1 X204.326 Y91.56 E.08821
G1 X204.89 Y91.56 E.00918
G1 X208.161 Y88.289 E.07522
G1 X208.161 Y88.854 E.00918
G1 X205.455 Y91.56 E.06224
G1 X206.019 Y91.56 E.00918
G1 X208.161 Y89.418 E.04926
G1 X208.161 Y89.983 E.00918
G1 X206.584 Y91.56 E.03627
G1 X207.148 Y91.56 E.00918
G1 X208.161 Y90.547 E.02329
G1 X208.161 Y91.111 E.00918
G1 X207.533 Y91.739 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 1.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X208.161 Y91.111 E-.33727
G1 X208.161 Y90.547 E-.21451
G1 X207.774 Y90.934 E-.20822
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 15/58
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I.391 J-1.152 P1  F30000
G1 X107.471 Y56.87 Z1.8
G1 Z1.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X208.51 Y56.87 E1.76413
G1 X208.51 Y74.39 E.30589
G1 X208.51 Y91.909 E.30589
G1 X109.604 Y91.909 E1.72689
G1 X107.471 Y89.776 E.05266
G1 X107.471 Y56.93 E.57349
M204 S10000
G1 X107.043 Y56.442 F30000
G1 F6000
M204 S1000
G1 X208.939 Y56.442 E1.77909
G1 X208.939 Y74.39 E.31337
G1 X208.939 Y92.338 E.31337
G1 X109.427 Y92.338 E1.73747
G1 X107.043 Y89.954 E.05886
G1 X107.043 Y56.502 E.58407
M204 S10000
G1 X106.614 Y56.013 F30000
G1 F6000
M204 S1000
G1 X209.367 Y56.013 E1.79405
G1 X209.367 Y74.39 E.32085
G1 X209.367 Y92.766 E.32085
G1 X109.249 Y92.766 E1.74805
G1 X106.614 Y90.131 E.06506
G1 X106.614 Y56.073 E.59465
M204 S250
G1 X106.201 Y55.6 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 15 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer15 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.074 Y63.29 Z1.9 F30000
G1 X107.641 Y89.45 Z1.9
G1 Z1.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X109.751 Y91.56 E.0486
G1 X110.316 Y91.56 E.00921
G1 X107.821 Y89.064 E.05749
G1 X107.821 Y88.499 E.00921
G1 X110.882 Y91.56 E.07051
G1 X111.447 Y91.56 E.00921
G1 X107.821 Y87.933 E.08354
G1 X107.821 Y87.368 E.00921
G1 X112.012 Y91.56 E.09656
G1 X112.578 Y91.56 E.00921
G1 X107.821 Y86.803 E.10959
G1 X107.821 Y86.237 E.00921
G1 X113.143 Y91.56 E.12261
G1 X113.709 Y91.56 E.00921
G1 X107.821 Y85.672 E.13563
G1 X107.821 Y85.106 E.00921
G1 X114.274 Y91.56 E.14866
G1 X114.839 Y91.56 E.00921
G1 X107.821 Y84.541 E.16168
G1 X107.821 Y83.976 E.00921
G1 X115.405 Y91.56 E.17471
G1 X115.97 Y91.56 E.00921
G1 X107.821 Y83.41 E.18773
G1 X107.821 Y82.845 E.00921
G1 X116.535 Y91.56 E.20076
G1 X117.101 Y91.56 E.00921
G1 X107.821 Y82.28 E.21378
G1 X107.821 Y81.714 E.00921
G1 X117.666 Y91.56 E.2268
G1 X118.232 Y91.56 E.00921
G1 X107.821 Y81.149 E.23983
G1 X107.821 Y80.583 E.00921
G1 X118.797 Y91.56 E.25285
G1 X119.362 Y91.56 E.00921
G1 X107.821 Y80.018 E.26588
G1 X107.821 Y79.453 E.00921
G1 X119.928 Y91.56 E.2789
G1 X120.493 Y91.56 E.00921
G1 X107.821 Y78.887 E.29193
G1 X107.821 Y78.322 E.00921
G1 X121.059 Y91.56 E.30495
G1 X121.624 Y91.56 E.00921
G1 X107.821 Y77.756 E.31797
G1 X107.821 Y77.191 E.00921
G1 X122.189 Y91.56 E.331
G1 X122.755 Y91.56 E.00921
G1 X107.821 Y76.626 E.34402
G1 X107.821 Y76.06 E.00921
G1 X123.32 Y91.56 E.35705
G1 X123.886 Y91.56 E.00921
G1 X107.821 Y75.495 E.37007
G1 X107.821 Y74.929 E.00921
G1 X124.451 Y91.56 E.3831
G1 X125.016 Y91.56 E.00921
G1 X107.821 Y74.364 E.39612
G1 X107.821 Y73.799 E.00921
G1 X125.582 Y91.56 E.40914
G1 X126.147 Y91.56 E.00921
G1 X107.821 Y73.233 E.42217
G1 X107.821 Y72.668 E.00921
G1 X126.712 Y91.56 E.43519
G1 X127.278 Y91.56 E.00921
G1 X107.821 Y72.103 E.44822
G1 X107.821 Y71.537 E.00921
G1 X127.843 Y91.56 E.46124
G1 X128.409 Y91.56 E.00921
G1 X107.821 Y70.972 E.47427
G1 X107.821 Y70.406 E.00921
G1 X128.974 Y91.56 E.48729
G1 X129.539 Y91.56 E.00921
G1 X107.821 Y69.841 E.50031
G1 X107.821 Y69.276 E.00921
M73 P62 R28
G1 X130.105 Y91.56 E.51334
G1 X130.67 Y91.56 E.00921
G1 X107.821 Y68.71 E.52636
G1 X107.821 Y68.145 E.00921
G1 X131.236 Y91.56 E.53939
G1 X131.801 Y91.56 E.00921
G1 X107.821 Y67.579 E.55241
G1 X107.821 Y67.014 E.00921
G1 X132.366 Y91.56 E.56544
G1 X132.932 Y91.56 E.00921
G1 X107.821 Y66.449 E.57846
G1 X107.821 Y65.883 E.00921
G1 X133.497 Y91.56 E.59148
G1 X134.063 Y91.56 E.00921
G1 X107.821 Y65.318 E.60451
G1 X107.821 Y64.752 E.00921
G1 X134.628 Y91.56 E.61753
G1 X135.193 Y91.56 E.00921
G1 X107.821 Y64.187 E.63056
G1 X107.821 Y63.622 E.00921
G1 X135.759 Y91.56 E.64358
G1 X136.324 Y91.56 E.00921
G1 X107.821 Y63.056 E.65661
G1 X107.821 Y62.491 E.00921
G1 X136.889 Y91.56 E.66963
G1 X137.455 Y91.56 E.00921
G1 X107.821 Y61.926 E.68265
G1 X107.821 Y61.36 E.00921
G1 X138.02 Y91.56 E.69568
G1 X138.586 Y91.56 E.00921
G1 X107.821 Y60.795 E.7087
G1 X107.821 Y60.229 E.00921
G1 X139.151 Y91.56 E.72173
G1 X139.716 Y91.56 E.00921
G1 X107.821 Y59.664 E.73475
G1 X107.821 Y59.099 E.00921
G1 X140.282 Y91.56 E.74778
G1 X140.847 Y91.56 E.00921
G1 X107.821 Y58.533 E.7608
G1 X107.821 Y57.968 E.00921
G1 X141.413 Y91.56 E.77382
G1 X141.978 Y91.56 E.00921
G1 X107.821 Y57.402 E.78685
G1 X107.821 Y57.219 E.00298
G1 X108.203 Y57.219 E.00623
G1 X142.543 Y91.56 E.79106
G1 X143.109 Y91.56 E.00921
G1 X108.768 Y57.219 E.79106
G1 X109.334 Y57.219 E.00921
G1 X143.674 Y91.56 E.79106
G1 X144.239 Y91.56 E.00921
G1 X109.899 Y57.219 E.79106
G1 X110.465 Y57.219 E.00921
G1 X144.805 Y91.56 E.79106
G1 X145.37 Y91.56 E.00921
G1 X111.03 Y57.219 E.79106
G1 X111.595 Y57.219 E.00921
G1 X145.936 Y91.56 E.79106
G1 X146.501 Y91.56 E.00921
G1 X112.161 Y57.219 E.79106
G1 X112.726 Y57.219 E.00921
G1 X147.066 Y91.56 E.79106
G1 X147.632 Y91.56 E.00921
G1 X113.291 Y57.219 E.79106
G1 X113.857 Y57.219 E.00921
G1 X148.197 Y91.56 E.79106
G1 X148.763 Y91.56 E.00921
G1 X114.422 Y57.219 E.79106
G1 X114.988 Y57.219 E.00921
G1 X149.328 Y91.56 E.79106
G1 X149.893 Y91.56 E.00921
G1 X115.553 Y57.219 E.79106
G1 X116.118 Y57.219 E.00921
G1 X150.459 Y91.56 E.79106
G1 X151.024 Y91.56 E.00921
G1 X116.684 Y57.219 E.79106
G1 X117.249 Y57.219 E.00921
G1 X151.59 Y91.56 E.79106
G1 X152.155 Y91.56 E.00921
G1 X117.815 Y57.219 E.79106
G1 X118.38 Y57.219 E.00921
G1 X152.72 Y91.56 E.79106
G1 X153.286 Y91.56 E.00921
G1 X118.945 Y57.219 E.79106
G1 X119.511 Y57.219 E.00921
G1 X153.851 Y91.56 E.79106
G1 X154.416 Y91.56 E.00921
G1 X120.076 Y57.219 E.79106
G1 X120.642 Y57.219 E.00921
G1 X154.982 Y91.56 E.79106
G1 X155.547 Y91.56 E.00921
G1 X121.207 Y57.219 E.79106
G1 X121.772 Y57.219 E.00921
G1 X156.113 Y91.56 E.79106
G1 X156.678 Y91.56 E.00921
G1 X122.338 Y57.219 E.79106
G1 X122.903 Y57.219 E.00921
G1 X157.243 Y91.56 E.79106
G1 X157.809 Y91.56 E.00921
G1 X123.468 Y57.219 E.79106
G1 X124.034 Y57.219 E.00921
G1 X158.374 Y91.56 E.79106
G1 X158.94 Y91.56 E.00921
G1 X124.599 Y57.219 E.79106
G1 X125.165 Y57.219 E.00921
G1 X159.505 Y91.56 E.79106
G1 X160.07 Y91.56 E.00921
G1 X125.73 Y57.219 E.79106
G1 X126.295 Y57.219 E.00921
G1 X160.636 Y91.56 E.79106
G1 X161.201 Y91.56 E.00921
G1 X126.861 Y57.219 E.79106
G1 X127.426 Y57.219 E.00921
G1 X161.767 Y91.56 E.79106
G1 X162.332 Y91.56 E.00921
G1 X127.992 Y57.219 E.79106
G1 X128.557 Y57.219 E.00921
G1 X162.897 Y91.56 E.79106
G1 X163.463 Y91.56 E.00921
G1 X129.122 Y57.219 E.79106
G1 X129.688 Y57.219 E.00921
G1 X164.028 Y91.56 E.79106
G1 X164.593 Y91.56 E.00921
G1 X130.253 Y57.219 E.79106
G1 X130.819 Y57.219 E.00921
G1 X165.159 Y91.56 E.79106
G1 X165.724 Y91.56 E.00921
G1 X131.384 Y57.219 E.79106
G1 X131.949 Y57.219 E.00921
G1 X166.29 Y91.56 E.79106
G1 X166.855 Y91.56 E.00921
G1 X132.515 Y57.219 E.79106
G1 X133.08 Y57.219 E.00921
G1 X167.42 Y91.56 E.79106
G1 X167.986 Y91.56 E.00921
G1 X133.645 Y57.219 E.79106
G1 X134.211 Y57.219 E.00921
G1 X168.551 Y91.56 E.79106
G1 X169.117 Y91.56 E.00921
G1 X134.776 Y57.219 E.79106
G1 X135.342 Y57.219 E.00921
G1 X169.682 Y91.56 E.79106
G1 X170.247 Y91.56 E.00921
G1 X135.907 Y57.219 E.79106
G1 X136.472 Y57.219 E.00921
G1 X170.813 Y91.56 E.79106
G1 X171.378 Y91.56 E.00921
G1 X137.038 Y57.219 E.79106
G1 X137.603 Y57.219 E.00921
G1 X171.944 Y91.56 E.79106
G1 X172.509 Y91.56 E.00921
G1 X138.169 Y57.219 E.79106
G1 X138.734 Y57.219 E.00921
G1 X173.074 Y91.56 E.79106
G1 X173.64 Y91.56 E.00921
G1 X139.299 Y57.219 E.79106
G1 X139.865 Y57.219 E.00921
G1 X174.205 Y91.56 E.79106
G1 X174.77 Y91.56 E.00921
G1 X140.43 Y57.219 E.79106
G1 X140.996 Y57.219 E.00921
G1 X175.336 Y91.56 E.79106
G1 X175.901 Y91.56 E.00921
G1 X141.561 Y57.219 E.79106
G1 X142.126 Y57.219 E.00921
G1 X176.467 Y91.56 E.79106
G1 X177.032 Y91.56 E.00921
G1 X142.692 Y57.219 E.79106
G1 X143.257 Y57.219 E.00921
G1 X177.597 Y91.56 E.79106
G1 X178.163 Y91.56 E.00921
G1 X143.822 Y57.219 E.79106
G1 X144.388 Y57.219 E.00921
G1 X178.728 Y91.56 E.79106
G1 X179.294 Y91.56 E.00921
G1 X144.953 Y57.219 E.79106
G1 X145.519 Y57.219 E.00921
G1 X179.859 Y91.56 E.79106
G1 X180.424 Y91.56 E.00921
G1 X146.084 Y57.219 E.79106
G1 X146.649 Y57.219 E.00921
G1 X180.99 Y91.56 E.79106
G1 X181.555 Y91.56 E.00921
G1 X147.215 Y57.219 E.79106
G1 X147.78 Y57.219 E.00921
G1 X182.121 Y91.56 E.79106
G1 X182.686 Y91.56 E.00921
G1 X148.346 Y57.219 E.79106
G1 X148.911 Y57.219 E.00921
G1 X183.251 Y91.56 E.79106
G1 X183.817 Y91.56 E.00921
M73 P63 R28
G1 X149.476 Y57.219 E.79106
G1 X150.042 Y57.219 E.00921
G1 X184.382 Y91.56 E.79106
G1 X184.947 Y91.56 E.00921
G1 X150.607 Y57.219 E.79106
G1 X151.172 Y57.219 E.00921
G1 X185.513 Y91.56 E.79106
G1 X186.078 Y91.56 E.00921
G1 X151.738 Y57.219 E.79106
G1 X152.303 Y57.219 E.00921
G1 X186.644 Y91.56 E.79106
G1 X187.209 Y91.56 E.00921
G1 X152.869 Y57.219 E.79106
G1 X153.434 Y57.219 E.00921
G1 X187.774 Y91.56 E.79106
G1 X188.34 Y91.56 E.00921
G1 X153.999 Y57.219 E.79106
G1 X154.565 Y57.219 E.00921
G1 X188.905 Y91.56 E.79106
G1 X189.471 Y91.56 E.00921
G1 X155.13 Y57.219 E.79106
G1 X155.696 Y57.219 E.00921
G1 X190.036 Y91.56 E.79106
G1 X190.601 Y91.56 E.00921
G1 X156.261 Y57.219 E.79106
G1 X156.826 Y57.219 E.00921
G1 X191.167 Y91.56 E.79106
G1 X191.732 Y91.56 E.00921
G1 X157.392 Y57.219 E.79106
G1 X157.957 Y57.219 E.00921
G1 X192.298 Y91.56 E.79106
G1 X192.863 Y91.56 E.00921
G1 X158.523 Y57.219 E.79106
G1 X159.088 Y57.219 E.00921
G1 X193.428 Y91.56 E.79106
G1 X193.994 Y91.56 E.00921
G1 X159.653 Y57.219 E.79106
G1 X160.219 Y57.219 E.00921
G1 X194.559 Y91.56 E.79106
G1 X195.124 Y91.56 E.00921
G1 X160.784 Y57.219 E.79106
G1 X161.349 Y57.219 E.00921
G1 X195.69 Y91.56 E.79106
G1 X196.255 Y91.56 E.00921
G1 X161.915 Y57.219 E.79106
G1 X162.48 Y57.219 E.00921
G1 X196.821 Y91.56 E.79106
G1 X197.386 Y91.56 E.00921
M73 P63 R27
G1 X163.046 Y57.219 E.79106
G1 X163.611 Y57.219 E.00921
G1 X197.951 Y91.56 E.79106
G1 X198.517 Y91.56 E.00921
G1 X164.176 Y57.219 E.79106
G1 X164.742 Y57.219 E.00921
G1 X199.082 Y91.56 E.79106
G1 X199.648 Y91.56 E.00921
G1 X165.307 Y57.219 E.79106
G1 X165.873 Y57.219 E.00921
G1 X200.213 Y91.56 E.79106
G1 X200.778 Y91.56 E.00921
G1 X166.438 Y57.219 E.79106
G1 X167.003 Y57.219 E.00921
G1 X201.344 Y91.56 E.79106
G1 X201.909 Y91.56 E.00921
G1 X167.569 Y57.219 E.79106
G1 X168.134 Y57.219 E.00921
G1 X202.475 Y91.56 E.79106
G1 X203.04 Y91.56 E.00921
G1 X168.7 Y57.219 E.79106
G1 X169.265 Y57.219 E.00921
G1 X203.605 Y91.56 E.79106
G1 X204.171 Y91.56 E.00921
G1 X169.83 Y57.219 E.79106
G1 X170.396 Y57.219 E.00921
G1 X204.736 Y91.56 E.79106
G1 X205.301 Y91.56 E.00921
G1 X170.961 Y57.219 E.79106
G1 X171.526 Y57.219 E.00921
G1 X205.867 Y91.56 E.79106
G1 X206.432 Y91.56 E.00921
G1 X172.092 Y57.219 E.79106
G1 X172.657 Y57.219 E.00921
G1 X206.998 Y91.56 E.79106
G1 X207.563 Y91.56 E.00921
G1 X173.223 Y57.219 E.79106
G1 X173.788 Y57.219 E.00921
G1 X208.128 Y91.56 E.79106
G1 X208.161 Y91.56 E.00053
G1 X208.161 Y91.027 E.00868
G1 X174.353 Y57.219 E.77879
G1 X174.919 Y57.219 E.00921
G1 X208.161 Y90.462 E.76577
G1 X208.161 Y89.896 E.00921
G1 X175.484 Y57.219 E.75274
G1 X176.05 Y57.219 E.00921
G1 X208.161 Y89.331 E.73972
G1 X208.161 Y88.765 E.00921
G1 X176.615 Y57.219 E.72669
G1 X177.18 Y57.219 E.00921
G1 X208.161 Y88.2 E.71367
G1 X208.161 Y87.635 E.00921
G1 X177.746 Y57.219 E.70064
G1 X178.311 Y57.219 E.00921
G1 X208.161 Y87.069 E.68762
G1 X208.161 Y86.504 E.00921
G1 X178.877 Y57.219 E.6746
G1 X179.442 Y57.219 E.00921
G1 X208.161 Y85.938 E.66157
G1 X208.161 Y85.373 E.00921
G1 X180.007 Y57.219 E.64855
G1 X180.573 Y57.219 E.00921
G1 X208.161 Y84.808 E.63552
G1 X208.161 Y84.242 E.00921
G1 X181.138 Y57.219 E.6225
G1 X181.703 Y57.219 E.00921
G1 X208.161 Y83.677 E.60947
G1 X208.161 Y83.111 E.00921
G1 X182.269 Y57.219 E.59645
G1 X182.834 Y57.219 E.00921
G1 X208.161 Y82.546 E.58343
G1 X208.161 Y81.981 E.00921
G1 X183.4 Y57.219 E.5704
G1 X183.965 Y57.219 E.00921
G1 X208.161 Y81.415 E.55738
G1 X208.161 Y80.85 E.00921
G1 X184.53 Y57.219 E.54435
G1 X185.096 Y57.219 E.00921
G1 X208.161 Y80.285 E.53133
G1 X208.161 Y79.719 E.00921
G1 X185.661 Y57.219 E.5183
G1 X186.227 Y57.219 E.00921
G1 X208.161 Y79.154 E.50528
G1 X208.161 Y78.588 E.00921
G1 X186.792 Y57.219 E.49226
G1 X187.357 Y57.219 E.00921
G1 X208.161 Y78.023 E.47923
G1 X208.161 Y77.458 E.00921
G1 X187.923 Y57.219 E.46621
G1 X188.488 Y57.219 E.00921
G1 X208.161 Y76.892 E.45318
G1 X208.161 Y76.327 E.00921
G1 X189.054 Y57.219 E.44016
G1 X189.619 Y57.219 E.00921
G1 X208.161 Y75.761 E.42713
G1 X208.161 Y75.196 E.00921
G1 X190.184 Y57.219 E.41411
G1 X190.75 Y57.219 E.00921
G1 X208.161 Y74.631 E.40109
G1 X208.161 Y74.065 E.00921
G1 X191.315 Y57.219 E.38806
G1 X191.88 Y57.219 E.00921
G1 X208.161 Y73.5 E.37504
G1 X208.161 Y72.934 E.00921
G1 X192.446 Y57.219 E.36201
M73 P64 R27
G1 X193.011 Y57.219 E.00921
G1 X208.161 Y72.369 E.34899
G1 X208.161 Y71.804 E.00921
G1 X193.577 Y57.219 E.33596
G1 X194.142 Y57.219 E.00921
G1 X208.161 Y71.238 E.32294
G1 X208.161 Y70.673 E.00921
G1 X194.707 Y57.219 E.30992
G1 X195.273 Y57.219 E.00921
G1 X208.161 Y70.108 E.29689
G1 X208.161 Y69.542 E.00921
G1 X195.838 Y57.219 E.28387
G1 X196.404 Y57.219 E.00921
G1 X208.161 Y68.977 E.27084
G1 X208.161 Y68.411 E.00921
G1 X196.969 Y57.219 E.25782
G1 X197.534 Y57.219 E.00921
G1 X208.161 Y67.846 E.24479
G1 X208.161 Y67.281 E.00921
G1 X198.1 Y57.219 E.23177
G1 X198.665 Y57.219 E.00921
G1 X208.161 Y66.715 E.21875
G1 X208.161 Y66.15 E.00921
G1 X199.231 Y57.219 E.20572
G1 X199.796 Y57.219 E.00921
G1 X208.161 Y65.584 E.1927
G1 X208.161 Y65.019 E.00921
G1 X200.361 Y57.219 E.17967
G1 X200.927 Y57.219 E.00921
G1 X208.161 Y64.454 E.16665
G1 X208.161 Y63.888 E.00921
G1 X201.492 Y57.219 E.15362
G1 X202.057 Y57.219 E.00921
G1 X208.161 Y63.323 E.1406
G1 X208.161 Y62.758 E.00921
G1 X202.623 Y57.219 E.12758
G1 X203.188 Y57.219 E.00921
G1 X208.161 Y62.192 E.11455
G1 X208.161 Y61.627 E.00921
G1 X203.754 Y57.219 E.10153
G1 X204.319 Y57.219 E.00921
G1 X208.161 Y61.061 E.0885
G1 X208.161 Y60.496 E.00921
G1 X204.884 Y57.219 E.07548
G1 X205.45 Y57.219 E.00921
G1 X208.161 Y59.931 E.06245
G1 X208.161 Y59.365 E.00921
G1 X206.015 Y57.219 E.04943
G1 X206.581 Y57.219 E.00921
G1 X208.161 Y58.8 E.03641
G1 X208.161 Y58.234 E.00921
G1 X207.146 Y57.219 E.02338
G1 X207.711 Y57.219 E.00921
G1 X208.34 Y57.848 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X207.711 Y57.219 E-.338
G1 X207.146 Y57.219 E-.21485
G1 X207.531 Y57.605 E-.20715
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 16/58
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.9 I-1.011 J-.677 P1  F30000
G1 X195.803 Y75.133 Z1.9
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.35756
G1 F6000
M204 S1000
G1 X196.234 Y75.31 E.00637
; LINE_WIDTH: 0.36124
G1 X196.769 Y75.639 E.0087
; LINE_WIDTH: 0.399815
G1 X196.96 Y75.839 E.00426
; LINE_WIDTH: 0.43839
G1 X197.151 Y76.039 E.0047
; LINE_WIDTH: 0.468905
G1 X197.307 Y76.278 E.00521
; LINE_WIDTH: 0.49942
G1 X197.462 Y76.518 E.00557
; LINE_WIDTH: 0.54198
G1 X197.682 Y77.047 E.01215
; LINE_WIDTH: 0.57036
G1 X197.817 Y77.653 E.01388
; LINE_WIDTH: 0.59135
G1 X197.858 Y78.372 E.01672
; LINE_WIDTH: 0.59782
G1 X197.817 Y78.93 E.01313
; LINE_WIDTH: 0.60458
G3 X197.539 Y79.907 I-3.547 J-.483 E.02422
; LINE_WIDTH: 0.60284
G1 X197.213 Y80.48 E.01562
; LINE_WIDTH: 0.5806
G1 X196.895 Y80.868 E.01143
; LINE_WIDTH: 0.55893
G1 X196.438 Y81.25 E.01302
; LINE_WIDTH: 0.51801
G3 X195.484 Y81.596 I-1.601 J-2.923 E.02062
; LINE_WIDTH: 0.550385
G1 X195.164 Y81.631 E.00694
; LINE_WIDTH: 0.58276
G1 X194.843 Y81.666 E.00737
G1 X195.143 Y81.516 E.00765
; LINE_WIDTH: 0.550385
G1 X195.442 Y81.366 E.00721
; LINE_WIDTH: 0.51801
G1 X195.996 Y80.989 E.01356
; LINE_WIDTH: 0.55893
G1 X196.487 Y80.521 E.01485
; LINE_WIDTH: 0.58985
G1 X196.876 Y79.957 E.01586
; LINE_WIDTH: 0.60458
G1 X197.149 Y79.277 E.01742
G1 X197.266 Y78.69 E.01423
; LINE_WIDTH: 0.59255
G1 X197.292 Y78.045 E.01501
; LINE_WIDTH: 0.57342
G1 X197.235 Y77.451 E.01343
; LINE_WIDTH: 0.55023
G1 X197.118 Y76.958 E.01091
; LINE_WIDTH: 0.51545
G1 X196.929 Y76.494 E.01007
; LINE_WIDTH: 0.46626
G1 X196.775 Y76.246 E.0053
; LINE_WIDTH: 0.42564
G1 X196.621 Y75.997 E.00481
; LINE_WIDTH: 0.38502
G1 X196.264 Y75.554 E.00844
; LINE_WIDTH: 0.35756
G1 X195.848 Y75.174 E.00772
G1 E-.8 F1800
M204 S10000
G1 X191.381 Y74.213 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5412
G1 F6000
M204 S1000
G2 X192.26 Y73.778 I-3.077 J-7.324 E.02078
G1 X192.7 Y73.439 E.01177
G1 X192.642 Y73.689 E.00543
G2 X192.832 Y74.165 I1.104 J-.166 E.01095
G1 X192.934 Y74.251 E.00283
G2 X191.441 Y74.214 I-1.882 J45.85 E.03163
G1 E-.8 F1800
M204 S10000
G1 X193.944 Y72.025 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.50619
G1 F6000
M204 S1000
G2 X194.567 Y71.142 I-20.497 J-15.131 E.02133
; LINE_WIDTH: 0.51657
G1 X194.895 Y70.675 E.01151
; LINE_WIDTH: 0.56644
G1 X195.224 Y70.229 E.01231
; LINE_WIDTH: 0.5891
G1 X195.562 Y69.747 E.01362
; LINE_WIDTH: 0.5993
G2 X196.579 Y68.235 I-84.695 J-58.091 E.04291
; LINE_WIDTH: 0.59409
G1 X197.331 Y67.094 E.03187
; LINE_WIDTH: 0.57256
G1 X197.413 Y66.972 E.0033
G1 X198.058 Y66.972 E.01447
G1 X197.794 Y67.394 E.01117
; LINE_WIDTH: 0.59409
G1 X197.06 Y68.546 E.03187
; LINE_WIDTH: 0.5993
G3 X196.02 Y70.081 I-28.852 J-18.423 E.04364
; LINE_WIDTH: 0.5891
G1 X195.646 Y70.571 E.01427
; LINE_WIDTH: 0.56644
G1 X195.457 Y70.785 E.00634
; LINE_WIDTH: 0.540785
G1 X195.267 Y70.998 E.00604
; LINE_WIDTH: 0.51513
G1 X194.827 Y71.388 E.01182
; LINE_WIDTH: 0.50619
M73 P64 R26
G1 X193.993 Y71.99 E.02032
G1 E-.8 F1800
M204 S10000
G1 X187.607 Y67.81 Z2 F30000
G1 X186.295 Y66.952 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5317
G1 F6000
M204 S1000
G1 X186.805 Y66.952 E.01061
G1 X186.805 Y73.354 E.13309
; LINE_WIDTH: 0.54207
G1 X186.817 Y73.547 E.0041
G1 X186.955 Y73.792 E.00597
; LINE_WIDTH: 0.49603
G1 X187.093 Y74.038 E.00545
; LINE_WIDTH: 0.44999
G1 X187.365 Y74.272 E.00626
G1 X187.576 Y74.34 E.00389
G1 X187.365 Y74.409 E.00389
G1 X187.093 Y74.643 E.00626
; LINE_WIDTH: 0.490845
G1 X186.949 Y74.985 E.0071
; LINE_WIDTH: 0.5317
G1 X186.805 Y75.327 E.00771
G1 X186.805 Y80.794 E.11366
; LINE_WIDTH: 0.575315
G1 X186.853 Y81.069 E.00628
; LINE_WIDTH: 0.61893
G1 X186.9 Y81.343 E.00678
G1 X187.285 Y81.762 E.01383
G1 X187.443 Y81.788 E.0039
; LINE_WIDTH: 0.577343
G1 X187.601 Y81.814 E.00363
; LINE_WIDTH: 0.535755
G1 X187.759 Y81.841 E.00336
; LINE_WIDTH: 0.494168
G1 X187.917 Y81.867 E.00309
G1 X187.758 Y81.846 E.00311
; LINE_WIDTH: 0.535755
G1 X187.598 Y81.825 E.00338
; LINE_WIDTH: 0.577343
G1 X187.438 Y81.805 E.00365
; LINE_WIDTH: 0.61893
G1 X187.278 Y81.784 E.00392
G1 X186.339 Y81.784 E.02286
G2 X186.317 Y81.14 I-5.111 J-.149 E.0157
; LINE_WIDTH: 0.575315
G1 X186.295 Y80.794 E.00781
; LINE_WIDTH: 0.5317
G1 X186.295 Y76.794 E.08316
G2 X186.275 Y74.834 I-23.683 J-.734 E.04077
; LINE_WIDTH: 0.490845
G3 X186.275 Y73.847 I5.949 J-.493 E.01889
; LINE_WIDTH: 0.5317
G1 X186.295 Y73.354 E.01026
G1 X186.295 Y67.012 E.13185
M204 S10000
G1 X185.826 Y66.482 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X187.275 Y66.482 E.0253
G1 X187.275 Y73.354 E.11998
G1 X187.284 Y73.465 E.00195
G1 X187.423 Y73.764 E.00576
; LINE_WIDTH: 0.494447
G1 X187.567 Y73.863 E.00337
; LINE_WIDTH: 0.538903
G1 X187.711 Y73.962 E.00369
; LINE_WIDTH: 0.58336
G1 X187.856 Y74.061 E.004
G1 X187.918 Y74.061 E.00143
; LINE_WIDTH: 0.58193
G1 X189.419 Y74.059 E.03426
; LINE_WIDTH: 0.58248
G1 X189.45 Y74.059 E.00072
; LINE_WIDTH: 0.59977
G1 X190.076 Y74.036 E.01476
G1 X190.233 Y73.99 E.00386
; LINE_WIDTH: 0.549843
G1 X190.391 Y73.944 E.00353
; LINE_WIDTH: 0.499917
G1 X190.548 Y73.898 E.00319
; LINE_WIDTH: 0.44999
G1 X190.861 Y73.851 E.00552
G1 X191.466 Y73.653 E.01111
G1 X192.17 Y73.271 E.014
; LINE_WIDTH: 0.49138
G1 X192.522 Y72.989 E.00863
; LINE_WIDTH: 0.53277
G1 X192.873 Y72.706 E.00939
G1 X193.04 Y72.477 E.00591
; LINE_WIDTH: 0.49138
G1 X193.206 Y72.247 E.00543
; LINE_WIDTH: 0.44999
G2 X195.621 Y68.764 I-54.141 J-40.115 E.07402
G1 X197.152 Y66.482 E.04797
G1 X198.942 Y66.482 E.03126
G1 X197.881 Y68.177 E.03492
G3 X196.424 Y70.373 I-32.429 J-19.94 E.04602
G3 X195.108 Y71.749 I-6.167 J-4.581 E.03333
G1 X193.707 Y72.758 E.03014
; LINE_WIDTH: 0.49796
G1 X193.525 Y72.86 E.00406
; LINE_WIDTH: 0.54593
G2 X193.199 Y73.109 I.256 J.673 E.00889
; LINE_WIDTH: 0.53589
G1 X193.155 Y73.364 E.00541
; LINE_WIDTH: 0.49294
G1 X193.11 Y73.618 E.00496
; LINE_WIDTH: 0.44999
G1 X193.22 Y73.892 E.00515
; LINE_WIDTH: 0.499605
G1 X193.401 Y74.044 E.00459
; LINE_WIDTH: 0.54922
G1 X193.581 Y74.195 E.00507
G1 X193.8 Y74.24 E.0048
; LINE_WIDTH: 0.53132
G1 X194.593 Y74.419 E.01689
; LINE_WIDTH: 0.50176
G1 X195.422 Y74.617 E.01668
; LINE_WIDTH: 0.49273
G1 X195.835 Y74.737 E.00825
; LINE_WIDTH: 0.44999
G1 X196.312 Y74.913 E.00887
G1 X196.95 Y75.285 E.0129
G1 X197.452 Y75.735 E.01178
G1 X197.843 Y76.263 E.01147
G1 X198.125 Y76.863 E.01156
G1 X198.299 Y77.551 E.01239
G1 X198.36 Y78.349 E.01398
G3 X197.771 Y80.543 I-4.197 J.049 E.04015
G3 X196.195 Y81.878 I-2.736 J-1.633 E.03674
G1 X195.59 Y82.048 E.01097
G3 X192.378 Y82.297 I-2.938 J-17.065 E.05633
G1 X185.826 Y82.297 E.1144
G1 X185.826 Y66.542 E.27507
M204 S10000
G1 X185.397 Y66.054 F30000
G1 F6000
M204 S1000
G1 X187.703 Y66.054 E.04026
G1 X187.703 Y73.354 E.12746
G1 X187.753 Y73.491 E.00254
G1 X187.918 Y73.568 E.00318
G2 X189.993 Y73.538 I.699 J-23.447 E.03625
G1 X190.492 Y73.473 E.00879
G1 X190.749 Y73.438 E.00453
G1 X191.27 Y73.272 E.00954
G1 X191.89 Y72.947 E.01223
G1 X192.514 Y72.403 E.01447
G1 X192.863 Y71.99 E.00944
G2 X195.268 Y68.521 I-53.906 J-39.935 E.07371
G1 X196.923 Y66.054 E.05187
G1 X199.716 Y66.054 E.04876
G1 X198.655 Y67.749 E.03492
G3 X196.767 Y70.63 I-38.906 J-23.435 E.06015
G3 X195.371 Y72.088 I-6.524 J-4.851 E.03533
G2 X193.575 Y73.393 I81.436 J113.881 E.03877
G1 X193.544 Y73.593 E.00352
G1 X193.695 Y73.731 E.00358
G1 X195.628 Y74.205 E.03476
G1 X196.495 Y74.524 E.01613
G1 X197.203 Y74.937 E.01432
G1 X197.771 Y75.445 E.0133
G1 X198.213 Y76.043 E.01298
G1 X198.53 Y76.718 E.01302
G1 X198.723 Y77.481 E.01375
G1 X198.79 Y78.346 E.01515
G3 X198.405 Y80.268 I-5.26 J-.055 E.03442
G3 X197.742 Y81.315 I-3.861 J-1.709 E.02171
G1 X197.33 Y81.717 E.01006
G1 X196.866 Y82.038 E.00984
G1 X196.344 Y82.281 E.01005
G1 X195.682 Y82.467 E.01201
G3 X192.383 Y82.725 I-3.03 J-17.506 E.05787
G1 X185.397 Y82.725 E.12197
G1 X185.397 Y66.114 E.29004
G1 E-.8 F1800
M204 S10000
G1 X186.921 Y73.592 Z2 F30000
G1 X187.275 Y75.327 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X187.423 Y74.917 E.00762
; LINE_WIDTH: 0.494447
G1 X187.567 Y74.818 E.00337
; LINE_WIDTH: 0.538903
G1 X187.711 Y74.719 E.00369
; LINE_WIDTH: 0.58336
G1 X187.856 Y74.62 E.004
G1 X187.919 Y74.62 E.00146
; LINE_WIDTH: 0.58193
G1 X189.419 Y74.62 E.03424
; LINE_WIDTH: 0.596
G1 X190.03 Y74.613 E.01429
; LINE_WIDTH: 0.60546
G3 X190.3 Y74.628 I.102 J.612 E.00649
; LINE_WIDTH: 0.566593
G1 X190.4 Y74.648 E.00226
; LINE_WIDTH: 0.527725
G1 X190.499 Y74.667 E.0021
; LINE_WIDTH: 0.488858
G1 X190.599 Y74.687 E.00194
; LINE_WIDTH: 0.44999
G3 X192.351 Y74.705 I.51 J35.349 E.03059
; LINE_WIDTH: 0.499605
G1 X192.926 Y74.71 E.0112
; LINE_WIDTH: 0.54922
G1 X193.5 Y74.715 E.01236
G1 X194.323 Y74.845 E.01791
; LINE_WIDTH: 0.53659
G1 X195.072 Y75.083 E.01649
G1 X195.293 Y75.238 E.00566
; LINE_WIDTH: 0.49329
G1 X195.514 Y75.392 E.00518
; LINE_WIDTH: 0.44999
G3 X196.518 Y76.642 I-2.027 J2.659 E.02827
G3 X196.643 Y79.22 I-3.799 J1.476 E.04586
G1 X196.419 Y79.757 E.01015
G1 X196.092 Y80.243 E.01023
G1 X195.678 Y80.653 E.01018
G3 X194.098 Y81.349 I-2.154 J-2.752 E.03045
G1 X193.336 Y81.411 E.01335
G3 X190.203 Y81.435 I-2.231 J-87.892 E.05471
G1 X187.917 Y81.437 E.03991
G1 X187.565 Y81.332 E.00641
G1 X187.352 Y81.1 E.00552
G1 X187.275 Y80.794 E.0055
G1 X187.275 Y75.387 E.09441
M204 S10000
G1 X187.703 Y75.327 F30000
G1 F6000
M204 S1000
G1 X187.807 Y75.144 E.00368
G1 X187.919 Y75.113 E.00203
G1 X191.69 Y75.116 E.06585
G3 X194.257 Y75.295 I.087 J17.327 E.04497
G1 X194.911 Y75.527 E.01212
G3 X196.115 Y76.787 I-1.163 J2.316 E.03103
G1 X196.288 Y77.334 E.01002
G1 X196.374 Y78.1 E.01346
G3 X196.027 Y79.584 I-3.384 J-.009 E.02685
G1 X195.742 Y79.996 E.00874
G3 X193.946 Y80.941 I-2.216 J-2.031 E.03615
G1 X193.308 Y80.984 E.01117
G3 X190.203 Y81.007 I-2.205 J-89.159 E.05422
G1 X187.917 Y81.009 E.0399
G1 X187.8 Y80.974 E.00214
G1 X187.706 Y80.831 E.00297
G1 X187.703 Y80.794 E.00065
G1 X187.703 Y75.387 E.09441
G1 E-.8 F1800
M204 S10000
G1 X190.599 Y74.291 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.42216
G1 F6000
M204 S1000
G1 X190.875 Y74.272 E.00451
G1 E-.8 F1800
M204 S10000
G1 X194.485 Y80.997 Z2 F30000
G1 X194.843 Y81.666 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.58276
G1 F6000
M204 S1000
G1 X194.523 Y81.725 E.00746
; LINE_WIDTH: 0.53629
G1 X194.202 Y81.785 E.00684
; LINE_WIDTH: 0.48982
G1 X193.651 Y81.83 E.01055
; LINE_WIDTH: 0.4697
G1 X193.044 Y81.854 E.01109
; LINE_WIDTH: 0.46472
G1 X192.373 Y81.864 E.01212
; LINE_WIDTH: 0.45944
G1 X192.203 Y81.865 E.00303
; LINE_WIDTH: 0.45644
G1 X190.203 Y81.866 E.03545
; LINE_WIDTH: 0.45464
G1 X188.203 Y81.867 E.0353
; LINE_WIDTH: 0.45285
G1 X187.918 Y81.867 E.00501
; LINE_WIDTH: 0.4526
G1 X187.917 Y81.867 E.00002
G1 E-.8 F1800
M204 S10000
G1 X184.061 Y75.28 Z2 F30000
G1 X179.186 Y66.952 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5317
G1 F6000
M204 S1000
G1 X179.696 Y66.952 E.01061
G1 X179.696 Y81.827 E.30925
G1 X179.186 Y81.827 E.01061
G1 X179.186 Y67.012 E.30801
M204 S10000
G1 X178.716 Y66.482 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X180.166 Y66.482 E.0253
G1 X180.166 Y82.297 E.27612
G1 X178.716 Y82.297 E.0253
G1 X178.716 Y66.542 E.27507
M204 S10000
G1 X178.288 Y66.054 F30000
G1 F6000
M204 S1000
G1 X180.594 Y66.054 E.04026
G1 X180.594 Y82.725 E.29109
G1 X178.288 Y82.725 E.04026
G1 X178.288 Y66.114 E.29004
G1 E-.8 F1800
M204 S10000
G1 X177.813 Y73.731 Z2 F30000
G1 X176.651 Y92.35 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44189
G1 F6000
M204 S1000
G1 X181.331 Y92.35 E.08016
G1 X181.331 Y92.77 E.0072
G1 X176.861 Y92.77 E.07656
G1 X176.651 Y92.77 E.0036
G1 X176.651 Y92.41 E.00617
G1 E-.8 F1800
M204 S10000
G1 X184.283 Y92.381 Z2 F30000
G1 X192.651 Y92.35 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X197.331 Y92.35 E.08016
G1 X197.331 Y92.77 E.0072
G1 X192.651 Y92.77 E.08016
G1 X192.651 Y92.41 E.00617
G1 E-.8 F1800
M204 S10000
G1 X198.733 Y87.798 Z2 F30000
G1 X208.951 Y80.05 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44188
G1 F6000
M204 S1000
G1 X209.371 Y80.05 E.0072
G1 X209.371 Y80.26 E.0036
G1 X209.371 Y84.729 E.07656
G1 X208.951 Y84.729 E.0072
G1 X208.951 Y80.11 E.07913
; WIPE_START
G1 X209.371 Y80.05 E-.16138
G1 X209.371 Y80.26 E-.07988
G1 X209.371 Y81.625 E-.51874
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.348 Y81.625 Z2 F30000
G1 X208.548 Y81.417
G1 X199.153 Y79.047
G1 X184.99 Y83.132
G1 X184.99 Y75.475
G1 X181.001 Y74.468
G1 X177.881 Y73.681
G1 X172.73 Y72.382
G1 X159.439 Y69.029
G1 X149.421 Y66.502
G1 X146.156 Y65.678
G1 X106.201 Y55.6
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.781 Y55.6 E1.68189
G1 X209.781 Y74.39 E.3051
G1 X209.781 Y93.18 E.3051
; object ids of layer 16 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer16 end: 272
M625
G1 X109.078 Y93.18 E1.63517
G1 X106.201 Y90.303 E.06607
G1 X106.201 Y55.66 E.56252
; WIPE_START
M204 S1000
G1 X108.201 Y55.658 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.8 Y56.367 Z2 F30000
G1 X208.951 Y65.05 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44188
G1 F6000
M204 S1000
G1 X209.371 Y65.05 E.0072
G1 X209.371 Y69.729 E.08016
G1 X208.951 Y69.729 E.0072
G1 X208.951 Y65.11 E.07913
G1 E-.8 F1800
M204 S10000
G1 X202.287 Y61.389 Z2 F30000
G1 X192.651 Y56.009 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44189
G1 F6000
M204 S1000
G1 X197.331 Y56.009 E.08016
G1 X197.331 Y56.429 E.0072
G1 X192.651 Y56.429 E.08016
G1 X192.651 Y56.069 E.00617
G1 E-.8 F1800
M204 S10000
G1 X185.018 Y56.04 Z2 F30000
G1 X176.651 Y56.009 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X181.331 Y56.009 E.08016
G1 X181.331 Y56.429 E.0072
G1 X176.861 Y56.429 E.07656
G1 X176.651 Y56.429 E.0036
G1 X176.651 Y56.069 E.00617
G1 E-.8 F1800
M204 S10000
G1 X170.259 Y60.241 Z2 F30000
G1 X160.004 Y66.934 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.49671
G1 F6000
M204 S1000
G1 X160.518 Y66.934 E.00995
G2 X161.269 Y68.966 I178.269 J-64.689 E.04195
; LINE_WIDTH: 0.47381
G1 X161.761 Y70.295 E.02611
; LINE_WIDTH: 0.46725
G1 X161.848 Y70.488 E.00384
G1 X162.372 Y70.922 E.01236
; LINE_WIDTH: 0.44999
G1 X162.771 Y70.999 E.0071
; LINE_WIDTH: 0.45648
G1 X163.375 Y71.003 E.01071
G1 X162.863 Y71.248 E.01007
; LINE_WIDTH: 0.44999
G1 X162.61 Y71.567 E.0071
G1 X162.56 Y72.426 E.01502
; LINE_WIDTH: 0.43858
G1 X163.254 Y74.301 E.03399
; LINE_WIDTH: 0.41622
G1 X163.949 Y76.177 E.03217
; LINE_WIDTH: 0.39387
G1 X164.643 Y78.052 E.03035
; LINE_WIDTH: 0.37152
G1 X165.338 Y79.928 E.02853
; LINE_WIDTH: 0.34917
G1 X165.676 Y80.842 E.01301
; LINE_WIDTH: 0.34703
G1 X165.758 Y81.023 E.00264
; LINE_WIDTH: 0.39084
G1 X165.865 Y81.158 E.00259
; LINE_WIDTH: 0.43465
G1 X165.972 Y81.294 E.0029
; LINE_WIDTH: 0.47846
G1 X166.078 Y81.429 E.00321
G1 X166.264 Y81.476 E.00357
; LINE_WIDTH: 0.43743
G1 X166.45 Y81.523 E.00325
; LINE_WIDTH: 0.3964
G1 X166.668 Y81.534 E.00334
; LINE_WIDTH: 0.426507
G1 X166.863 Y81.489 E.00329
; LINE_WIDTH: 0.465463
G1 X167.057 Y81.445 E.00361
; LINE_WIDTH: 0.50442
G1 X167.251 Y81.4 E.00392
G1 X167.341 Y81.282 E.00292
; LINE_WIDTH: 0.469853
G1 X167.431 Y81.164 E.00271
; LINE_WIDTH: 0.435287
G1 X167.52 Y81.045 E.0025
; LINE_WIDTH: 0.40072
G1 X167.607 Y80.857 E.00321
; LINE_WIDTH: 0.41693
G1 X168.315 Y78.986 E.03223
; LINE_WIDTH: 0.44225
G1 X169.024 Y77.116 E.03429
; LINE_WIDTH: 0.46757
G1 X169.732 Y75.246 E.03635
; LINE_WIDTH: 0.49289
G1 X170.44 Y73.375 E.03842
; LINE_WIDTH: 0.5055
G1 X170.792 Y72.444 E.01964
; LINE_WIDTH: 0.51546
G1 X170.842 Y72.288 E.00329
G1 X170.788 Y71.95 E.00689
; LINE_WIDTH: 0.482725
G1 X170.734 Y71.612 E.00644
; LINE_WIDTH: 0.44999
G1 X170.485 Y71.271 E.00738
G1 X169.762 Y70.995 E.01352
G1 X170.59 Y70.999 E.01447
G1 X171.005 Y70.916 E.00738
; LINE_WIDTH: 0.48359
G1 X171.313 Y70.62 E.00805
; LINE_WIDTH: 0.51719
G1 X171.622 Y70.325 E.00863
; LINE_WIDTH: 0.53107
G1 X172.346 Y68.46 E.04153
; LINE_WIDTH: 0.54104
G2 X172.929 Y66.956 I-218.187 J-85.508 E.03415
G1 X173.492 Y66.956 E.0119
G2 X172.612 Y69.172 I320.134 J128.388 E.05047
; LINE_WIDTH: 0.52715
G1 X172.083 Y70.506 E.02956
; LINE_WIDTH: 0.51719
G2 X171.881 Y71.055 I10.228 J4.07 E.01182
; LINE_WIDTH: 0.483565
G1 X171.686 Y71.587 E.01067
; LINE_WIDTH: 0.477745
G1 X171.465 Y72.102 E.01043
; LINE_WIDTH: 0.5055
G1 X171.244 Y72.618 E.01106
G1 X170.512 Y74.479 E.03944
; LINE_WIDTH: 0.48018
G1 X169.78 Y76.341 E.03738
; LINE_WIDTH: 0.45486
G1 X169.049 Y78.202 E.03532
; LINE_WIDTH: 0.42954
G1 X168.317 Y80.063 E.03325
; LINE_WIDTH: 0.40422
G1 X167.953 Y80.99 E.01553
; LINE_WIDTH: 0.40072
G1 X167.858 Y81.216 E.00378
; LINE_WIDTH: 0.435287
G1 X167.755 Y81.424 E.00391
; LINE_WIDTH: 0.469853
M73 P65 R26
G1 X167.653 Y81.633 E.00424
; LINE_WIDTH: 0.50442
G1 X167.551 Y81.841 E.00457
G2 X167.206 Y81.859 I-.082 J1.748 E.00681
; LINE_WIDTH: 0.468413
G1 X167.025 Y81.877 E.00332
; LINE_WIDTH: 0.432407
G1 X166.843 Y81.895 E.00305
; LINE_WIDTH: 0.3964
G1 X166.418 Y81.895 E.0065
; LINE_WIDTH: 0.43743
G1 X166.112 Y81.875 E.0052
; LINE_WIDTH: 0.47846
G1 X165.806 Y81.854 E.00571
G2 X165.626 Y81.457 I-2.467 J.877 E.00813
; LINE_WIDTH: 0.431733
G1 X165.503 Y81.205 E.00469
; LINE_WIDTH: 0.385007
G1 X165.38 Y80.953 E.00415
; LINE_WIDTH: 0.36063
G1 X164.664 Y79.086 E.02764
; LINE_WIDTH: 0.38298
G1 X163.949 Y77.218 E.02946
; LINE_WIDTH: 0.40533
G1 X163.233 Y75.35 E.03128
; LINE_WIDTH: 0.42768
G1 X162.518 Y73.483 E.0331
; LINE_WIDTH: 0.43858
G1 X162.169 Y72.573 E.01656
; LINE_WIDTH: 0.44999
G1 X161.766 Y71.521 E.01966
; LINE_WIDTH: 0.45759
G1 X161.352 Y70.449 E.02043
; LINE_WIDTH: 0.48048
G1 X160.637 Y68.581 E.0374
; LINE_WIDTH: 0.49671
G2 X160.026 Y66.99 I-143.784 J54.298 E.033
M204 S10000
G1 X159.343 Y66.482 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X160.835 Y66.482 E.02604
G1 X162.167 Y70.148 E.06809
G1 X162.221 Y70.261 E.0022
G1 X162.531 Y70.525 E.0071
G1 X162.771 Y70.571 E.00426
G1 X170.59 Y70.571 E.13652
G1 X170.839 Y70.521 E.00443
G1 X171.187 Y70.167 E.00867
G1 X172.604 Y66.482 E.06893
G1 X174.192 Y66.482 E.02773
G1 X167.86 Y82.297 E.29743
G1 X165.503 Y82.297 E.04115
G1 X159.365 Y66.538 E.29528
M204 S10000
G1 X158.717 Y66.054 F30000
G1 F6000
M204 S1000
G1 X161.135 Y66.054 E.04223
G1 X162.57 Y70.001 E.07333
G1 X162.691 Y70.127 E.00305
G1 X162.771 Y70.142 E.00142
G1 X168.771 Y70.142 E.10476
G2 X170.638 Y70.137 I.495 J-152.607 E.0326
G1 X170.789 Y70.008 E.00347
G1 X172.309 Y66.054 E.07396
G1 X174.825 Y66.054 E.04393
G1 X168.15 Y82.725 E.31355
G1 X165.21 Y82.725 E.05132
G1 X158.738 Y66.11 E.31134
G1 E-.8 F1800
M204 S10000
G1 X162.991 Y71.765 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X163.142 Y71.573 E.00426
G1 X163.45 Y71.428 E.00594
G1 X163.561 Y71.418 E.00195
G1 X169.762 Y71.418 E.10827
G1 X170.196 Y71.587 E.00813
G1 X170.345 Y71.791 E.00443
G1 X170.391 Y72.193 E.00706
G1 X170.364 Y72.285 E.00166
G1 X167.233 Y80.718 E.15706
G1 X167.177 Y80.833 E.00223
G1 X166.994 Y81.024 E.00463
G1 X166.63 Y81.137 E.00664
G1 X166.304 Y81.048 E.00592
G1 X166.081 Y80.827 E.00547
G1 X166.026 Y80.714 E.0022
G1 X162.957 Y72.281 E.15669
G1 X162.987 Y71.825 E.00799
M204 S10000
G1 X163.371 Y71.962 F30000
G1 F6000
M204 S1000
G1 X163.524 Y71.85 E.00331
G1 X163.561 Y71.847 E.00065
G1 X169.762 Y71.847 E.10827
G1 X169.938 Y71.939 E.00347
G1 X169.963 Y72.136 E.00346
G1 X166.829 Y80.574 E.15716
G1 X166.752 Y80.671 E.00217
G1 X166.593 Y80.705 E.00283
G1 X166.447 Y80.605 E.00309
G1 X166.429 Y80.567 E.00073
G1 X163.36 Y72.134 E.15669
G1 X163.367 Y72.022 E.00196
G1 E-.8 F1800
M204 S10000
G1 X163.375 Y71.003 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.45648
G1 F6000
M204 S1000
G1 X163.561 Y70.995 E.00329
; LINE_WIDTH: 0.44032
G1 X169.762 Y70.995 E.10582
G1 E-.8 F1800
M204 S10000
G1 X162.808 Y67.848 Z2 F30000
G1 X136.651 Y56.009 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44189
G1 F6000
M204 S1000
G1 X141.12 Y56.009 E.07656
G1 X141.331 Y56.009 E.0036
G1 X141.331 Y56.429 E.0072
G1 X136.651 Y56.429 E.08016
G1 X136.651 Y56.069 E.00617
G1 E-.8 F1800
M204 S10000
G1 X129.018 Y56.04 Z2 F30000
G1 X120.651 Y56.009 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X125.331 Y56.009 E.08016
G1 X125.331 Y56.429 E.0072
G1 X120.861 Y56.429 E.07656
G1 X120.651 Y56.429 E.0036
G1 X120.651 Y56.069 E.00617
G1 E-.8 F1800
M204 S10000
G1 X119.512 Y63.616 Z2 F30000
G1 X118.797 Y68.357 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.48752
G1 F6000
M204 S1000
G1 X119.344 Y67.889 E.01367
; LINE_WIDTH: 0.45399
G1 X119.931 Y67.492 E.01249
; LINE_WIDTH: 0.41607
G1 X120.549 Y67.169 E.01121
; LINE_WIDTH: 0.37684
G1 X121.048 Y66.963 E.00782
; LINE_WIDTH: 0.3487
G1 X121.189 Y66.917 E.00198
; LINE_WIDTH: 0.33998
G1 X121.843 Y66.73 E.00883
; LINE_WIDTH: 0.30919
G1 X122.556 Y66.597 E.0085
; LINE_WIDTH: 0.28582
G1 X123.173 Y66.539 E.00667
; LINE_WIDTH: 0.26851
G1 X123.861 Y66.528 E.00693
; LINE_WIDTH: 0.27786
G1 X124.686 Y66.555 E.00863
; LINE_WIDTH: 0.29996
G1 X125.463 Y66.664 E.0089
; LINE_WIDTH: 0.33022
G1 X126.19 Y66.842 E.00941
; LINE_WIDTH: 0.36497
G1 X126.859 Y67.081 E.00994
; LINE_WIDTH: 0.40078
G1 X127.473 Y67.38 E.01055
; LINE_WIDTH: 0.43501
G1 X128.04 Y67.735 E.01127
; LINE_WIDTH: 0.46594
G1 X128.564 Y68.149 E.0121
; LINE_WIDTH: 0.49396
G1 X129.05 Y68.625 E.01309
; LINE_WIDTH: 0.51911
G1 X129.484 Y69.15 E.01382
; LINE_WIDTH: 0.54044
G1 X129.858 Y69.719 E.0144
; LINE_WIDTH: 0.55967
G1 X130.208 Y70.419 E.01718
; LINE_WIDTH: 0.5739
G1 X130.484 Y71.164 E.01787
; LINE_WIDTH: 0.58341
G1 X130.689 Y71.947 E.01853
; LINE_WIDTH: 0.58892
G1 X130.828 Y72.764 E.01918
; LINE_WIDTH: 0.59651
G1 X130.923 Y73.888 E.02643
G1 X130.923 Y74.856 E.02268
; LINE_WIDTH: 0.594
G1 X130.894 Y75.387 E.01239
; LINE_WIDTH: 0.58697
G1 X130.801 Y76.238 E.01973
; LINE_WIDTH: 0.57943
G1 X130.642 Y77.054 E.0189
; LINE_WIDTH: 0.56721
G1 X130.415 Y77.831 E.01801
; LINE_WIDTH: 0.54963
G1 X130.115 Y78.565 E.01706
; LINE_WIDTH: 0.52637
G1 X129.74 Y79.246 E.01601
; LINE_WIDTH: 0.49803
G1 X129.293 Y79.868 E.01487
; LINE_WIDTH: 0.46633
G1 X128.794 Y80.411 E.01336
; LINE_WIDTH: 0.43539
G1 X128.258 Y80.876 E.01196
; LINE_WIDTH: 0.40547
G1 X127.684 Y81.27 E.01091
; LINE_WIDTH: 0.37457
G1 X127.076 Y81.594 E.00991
; LINE_WIDTH: 0.34404
G1 X126.443 Y81.848 E.00896
; LINE_WIDTH: 0.31589
G1 X125.791 Y82.036 E.00813
; LINE_WIDTH: 0.29239
G1 X125.126 Y82.165 E.00748
; LINE_WIDTH: 0.27558
G1 X124.449 Y82.239 E.00706
; LINE_WIDTH: 0.26774
G1 X123.757 Y82.266 E.00695
; LINE_WIDTH: 0.27338
G1 X123.059 Y82.239 E.00717
; LINE_WIDTH: 0.28551
G1 X122.372 Y82.156 E.00744
; LINE_WIDTH: 0.31127
G1 X121.692 Y82.024 E.00818
; LINE_WIDTH: 0.34489
G1 X121.026 Y81.83 E.00914
; LINE_WIDTH: 0.37926
G1 X120.463 Y81.61 E.00881
; LINE_WIDTH: 0.40881
G1 X119.987 Y81.363 E.00845
; LINE_WIDTH: 0.43133
G1 X119.533 Y81.066 E.00906
; LINE_WIDTH: 0.44877
G1 X119.089 Y80.71 E.00992
; LINE_WIDTH: 0.46422
G1 X118.654 Y80.289 E.01092
; LINE_WIDTH: 0.48306
G1 X118.248 Y79.818 E.01169
; LINE_WIDTH: 0.50816
G1 X117.892 Y79.319 E.01215
; LINE_WIDTH: 0.53159
G1 X117.585 Y78.795 E.01263
; LINE_WIDTH: 0.55041
G1 X117.325 Y78.252 E.01297
; LINE_WIDTH: 0.56818
G1 X117.059 Y77.499 E.01778
; LINE_WIDTH: 0.57295
G1 X116.93 Y77.015 E.01126
; LINE_WIDTH: 0.57998
G1 X116.832 Y76.522 E.01143
; LINE_WIDTH: 0.5811
G1 X116.755 Y76.009 E.01183
; LINE_WIDTH: 0.58436
G1 X116.7 Y75.463 E.01258
; LINE_WIDTH: 0.58749
G1 X116.668 Y74.885 E.01337
; LINE_WIDTH: 0.58823
G3 X116.688 Y73.477 I12.252 J-.529 E.03252
; LINE_WIDTH: 0.58537
G3 X116.924 Y71.804 I10.338 J.606 E.03886
; LINE_WIDTH: 0.58173
G1 X117.104 Y71.14 E.0157
; LINE_WIDTH: 0.576
G1 X117.288 Y70.617 E.01253
; LINE_WIDTH: 0.57438
G1 X117.583 Y69.979 E.01582
; LINE_WIDTH: 0.56001
G1 X117.93 Y69.394 E.01494
; LINE_WIDTH: 0.54031
G1 X118.334 Y68.854 E.01425
; LINE_WIDTH: 0.51552
G1 X118.756 Y68.401 E.01245
M204 S10000
G1 X119.128 Y68.693 F30000
; LINE_WIDTH: 0.49065
G1 F6000
M204 S1000
G1 X119.518 Y68.309 E.01047
; LINE_WIDTH: 0.45989
G1 X120.035 Y67.897 E.01181
; LINE_WIDTH: 0.42481
G1 X120.591 Y67.547 E.0108
; LINE_WIDTH: 0.38673
G1 X121.181 Y67.261 E.00975
; LINE_WIDTH: 0.3487
G1 X121.798 Y67.041 E.00873
; LINE_WIDTH: 0.31432
G1 X122.436 Y66.887 E.00784
; LINE_WIDTH: 0.28694
G1 X123.092 Y66.795 E.00716
; LINE_WIDTH: 0.26935
G1 X123.763 Y66.764 E.00678
; LINE_WIDTH: 0.26572
G1 X124.427 Y66.787 E.00661
; LINE_WIDTH: 0.28183
G1 X125.075 Y66.868 E.00693
; LINE_WIDTH: 0.30474
G1 X125.708 Y67.011 E.00749
; LINE_WIDTH: 0.33513
G1 X126.323 Y67.218 E.00829
; LINE_WIDTH: 0.37015
G1 X126.913 Y67.491 E.00924
; LINE_WIDTH: 0.40657
G1 X127.473 Y67.83 E.01028
; LINE_WIDTH: 0.44152
G1 X127.998 Y68.233 E.01132
; LINE_WIDTH: 0.47288
G1 X128.486 Y68.698 E.01239
; LINE_WIDTH: 0.50294
G1 X128.935 Y69.235 E.01374
; LINE_WIDTH: 0.53223
G1 X129.332 Y69.844 E.01511
; LINE_WIDTH: 0.55691
G1 X129.661 Y70.504 E.0161
; LINE_WIDTH: 0.57482
G1 X129.913 Y71.184 E.01634
; LINE_WIDTH: 0.58604
G1 X130.099 Y71.876 E.01648
; LINE_WIDTH: 0.59261
G1 X130.238 Y72.635 E.01797
; LINE_WIDTH: 0.59509
G3 X130.36 Y74.373 I-12.426 J1.746 E.04075
; LINE_WIDTH: 0.59379
G1 X130.337 Y75.259 E.02066
; LINE_WIDTH: 0.58871
G1 X130.262 Y76.059 E.01857
; LINE_WIDTH: 0.57969
G1 X130.134 Y76.823 E.0176
; LINE_WIDTH: 0.56805
G1 X129.951 Y77.549 E.01668
; LINE_WIDTH: 0.55268
G1 X129.708 Y78.236 E.01579
; LINE_WIDTH: 0.53303
G1 X129.424 Y78.838 E.01387
; LINE_WIDTH: 0.51057
G1 X129.095 Y79.378 E.01261
; LINE_WIDTH: 0.48517
G1 X128.711 Y79.882 E.01198
; LINE_WIDTH: 0.45725
G1 X128.271 Y80.346 E.01134
; LINE_WIDTH: 0.42855
G1 X127.791 Y80.756 E.01047
; LINE_WIDTH: 0.39946
G1 X127.268 Y81.114 E.00977
; LINE_WIDTH: 0.36939
G1 X126.693 Y81.42 E.00922
; LINE_WIDTH: 0.33955
G1 X126.059 Y81.671 E.00883
; LINE_WIDTH: 0.31185
G1 X125.361 Y81.86 E.00857
; LINE_WIDTH: 0.28876
G1 X124.596 Y81.979 E.00843
; LINE_WIDTH: 0.27275
G1 X123.85 Y82.019 E.00764
; LINE_WIDTH: 0.27316
G1 X123.3 Y82.002 E.00564
; LINE_WIDTH: 0.28232
G1 X122.519 Y81.914 E.00836
; LINE_WIDTH: 0.30711
G1 X122.025 Y81.812 E.00587
; LINE_WIDTH: 0.34091
G1 X121.281 Y81.584 E.01013
; LINE_WIDTH: 0.37626
G1 X120.66 Y81.308 E.00982
; LINE_WIDTH: 0.40881
G1 X120.195 Y81.036 E.00851
; LINE_WIDTH: 0.43475
G1 X119.569 Y80.569 E.01314
; LINE_WIDTH: 0.45646
G1 X119.084 Y80.103 E.01191
; LINE_WIDTH: 0.48154
G1 X118.639 Y79.569 E.01305
; LINE_WIDTH: 0.50816
G1 X118.308 Y79.065 E.01196
; LINE_WIDTH: 0.53159
G1 X118.044 Y78.573 E.01159
; LINE_WIDTH: 0.55041
G1 X117.824 Y78.074 E.01176
; LINE_WIDTH: 0.55831
G1 X117.631 Y77.517 E.01291
; LINE_WIDTH: 0.57295
G1 X117.464 Y76.877 E.01485
; LINE_WIDTH: 0.57799
G1 X117.33 Y76.098 E.01791
; LINE_WIDTH: 0.58436
G1 X117.262 Y75.421 E.01562
; LINE_WIDTH: 0.58749
G3 X117.222 Y74.368 I19.051 J-1.25 E.02431
; LINE_WIDTH: 0.59099
G1 X117.235 Y73.838 E.0123
; LINE_WIDTH: 0.59155
G3 X117.417 Y72.188 I10.939 J.374 E.03859
; LINE_WIDTH: 0.58942
G1 X117.585 Y71.477 E.01691
; LINE_WIDTH: 0.58394
G1 X117.799 Y70.828 E.01566
; LINE_WIDTH: 0.57438
G1 X118.056 Y70.235 E.01455
; LINE_WIDTH: 0.56001
G1 X118.356 Y69.689 E.01368
; LINE_WIDTH: 0.54031
G1 X118.65 Y69.25 E.01117
; LINE_WIDTH: 0.51552
G1 X118.706 Y69.179 E.00182
G1 X119.03 Y68.79 E.01019
; LINE_WIDTH: 0.49065
G1 X119.085 Y68.736 E.00148
M204 S10000
G1 X119.69 Y68.753 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X119.826 Y68.613 E.00341
G3 X123.141 Y67.129 I3.876 J4.215 E.06452
G3 X126.737 Y67.838 I.665 J6.104 E.06499
G3 X129.45 Y71.345 I-3.051 J5.162 E.0793
G3 X129.839 Y75.245 I-11.668 J3.135 E.06873
G3 X129.264 Y78.083 I-9.604 J-.469 E.05075
G3 X125.938 Y81.332 I-5.237 J-2.033 E.0837
G3 X122.566 Y81.573 I-2.173 J-6.709 E.0596
G3 X118.469 Y78.375 I1.02 J-5.53 E.09433
G1 X118.116 Y77.456 E.0172
G3 X117.909 Y72.272 I11.43 J-3.053 E.09134
G3 X119.067 Y69.466 I7.125 J1.3 E.0534
G3 X119.382 Y69.069 I4.635 J3.362 E.00884
G1 X119.648 Y68.796 E.00665
M204 S10000
G1 X119.944 Y69.104 F30000
G1 F6000
M204 S1000
G1 X120.132 Y68.915 E.00465
G3 X123.798 Y67.525 I3.589 J3.936 E.07011
G3 X128.836 Y70.889 I.1 J5.304 E.11257
G3 X129.402 Y73.566 I-8.656 J3.23 E.04796
G3 X129.069 Y77.331 I-11.518 J.879 E.06629
G3 X126.34 Y80.7 I-5.174 J-1.401 E.07794
G3 X123.209 Y81.229 I-2.563 J-5.648 E.05606
G3 X120.105 Y79.91 I.433 J-5.334 E.05991
G3 X118.52 Y77.315 I3.877 J-4.15 E.05374
G3 X118.331 Y72.343 I11.032 J-2.91 E.08758
G3 X119.403 Y69.732 I6.704 J1.226 E.04965
G3 X119.719 Y69.336 I4.318 J3.119 E.00884
G1 X119.903 Y69.147 E.00461
G1 E-.8 F1800
M204 S10000
G1 X118.483 Y68.037 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G3 X120.913 Y66.61 I4.477 J4.838 E.04959
G1 X120.961 Y66.591 E.0009
G3 X123.362 Y66.185 I2.851 J9.551 E.04263
G1 X124.704 Y66.212 E.02345
G3 X127.678 Y67.032 I-.761 J8.563 E.05415
G3 X130.276 Y69.496 I-3.291 J6.07 E.06324
G3 X131.323 Y72.709 I-7.667 J4.276 E.05938
G1 X131.424 Y73.865 E.02026
G3 X131.11 Y77.191 I-12.809 J.467 E.05849
G3 X130.113 Y79.502 I-8.141 J-2.141 E.04411
G1 X129.623 Y80.154 E.01423
G3 X125.867 Y82.378 I-5.208 J-4.512 E.07755
G3 X121.075 Y82.247 I-2.125 J-9.997 E.08449
G1 X120.319 Y81.978 E.014
G3 X117.909 Y80.108 I2.674 J-5.937 E.05376
G3 X116.348 Y76.616 I5.879 J-4.724 E.06752
G3 X116.37 Y71.987 I13.614 J-2.25 E.08121
G3 X117.531 Y69.136 I7.687 J1.47 E.0541
G3 X118.439 Y68.078 I5.428 J3.74 E.02438
M204 S10000
G1 X118.195 Y67.727 F30000
G1 F6000
M204 S1000
G3 X120.759 Y66.21 I4.817 J5.214 E.05242
G1 X120.828 Y66.183 E.00128
G3 X123.349 Y65.756 I2.994 J10.018 E.04476
G1 X124.736 Y65.784 E.02421
G3 X127.848 Y66.634 I-.624 J8.402 E.05668
G3 X131.305 Y70.698 I-3.423 J6.415 E.09539
G3 X131.852 Y73.85 I-11.093 J3.549 E.05603
G3 X131.544 Y77.233 I-13.175 J.505 E.05947
G3 X130.171 Y80.176 I-7.775 J-1.837 E.05709
G3 X126.356 Y82.708 I-5.684 J-4.421 E.08137
G3 X120.953 Y82.659 I-2.605 J-10.438 E.09536
G1 X120.154 Y82.374 E.01481
G3 X117.577 Y80.379 I2.85 J-6.345 E.05743
G3 X116.496 Y78.626 I6.834 J-5.421 E.03604
G1 X116.181 Y77.765 E.016
G3 X115.739 Y73.775 I12.464 J-3.402 E.07039
G3 X116.431 Y70.281 I10.618 J.287 E.06248
G3 X118.151 Y67.768 I6.581 J2.66 E.05358
G1 E-.8 F1800
M204 S10000
G1 X110.722 Y66.018 Z2 F30000
G1 X106.61 Y65.05 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44189
G1 F6000
M204 S1000
G1 X107.031 Y65.05 E.0072
G1 X107.031 Y69.729 E.08016
G1 X106.61 Y69.729 E.0072
G1 X106.61 Y65.11 E.07914
G1 E-.8 F1800
M204 S10000
G1 X106.61 Y72.742 Z2 F30000
G1 X106.61 Y80.05 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X107.031 Y80.05 E.0072
G1 X107.031 Y84.729 E.08016
G1 X106.61 Y84.729 E.0072
G1 X106.61 Y80.11 E.07914
G1 E-.8 F1800
M204 S10000
G1 X112.363 Y85.125 Z2 F30000
G1 X120.651 Y92.35 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X125.331 Y92.35 E.08016
G1 X125.331 Y92.77 E.0072
G1 X120.651 Y92.77 E.08016
G1 X120.651 Y92.41 E.00617
G1 E-.8 F1800
M204 S10000
G1 X128.283 Y92.381 Z2 F30000
G1 X136.651 Y92.35 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X141.331 Y92.35 E.08016
G1 X141.331 Y92.77 E.0072
G1 X136.651 Y92.77 E.08016
G1 X136.651 Y92.41 E.00617
G1 E-.8 F1800
M204 S10000
G1 X136.724 Y84.778 Z2 F30000
G1 X136.896 Y66.887 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.40278
G1 F6000
M204 S1000
G1 X137.278 Y66.887 E.00592
G1 X137.278 Y76.223 E.14505
; LINE_WIDTH: 0.41216
G1 X137.289 Y76.405 E.0029
; LINE_WIDTH: 0.44999
G1 X137.522 Y76.932 E.01005
G1 X138.033 Y77.254 E.01055
G1 X139.341 Y77.626 E.02374
G1 X139.944 Y77.62 E.01054
G1 X140.531 Y77.15 E.01313
; LINE_WIDTH: 0.41688
G1 X141.581 Y75.448 E.03222
; LINE_WIDTH: 0.41301
G1 X142.631 Y73.745 E.03191
; LINE_WIDTH: 0.40914
G1 X143.681 Y72.043 E.03159
; LINE_WIDTH: 0.40528
G1 X144.222 Y71.166 E.01612
; LINE_WIDTH: 0.40329
G1 X144.224 Y71.162 E.00007
; LINE_WIDTH: 0.44999
G2 X146.837 Y66.979 I-171.625 J-110.134 E.08611
G1 X146.88 Y66.911 E.00141
G1 X148.157 Y66.911 E.0223
G1 X148.157 Y70.911 E.06984
G2 X148.181 Y72.284 I27.265 J.218 E.02398
; LINE_WIDTH: 0.40278
G1 X148.181 Y81.892 E.14928
G1 X147.799 Y81.892 E.00592
G1 X147.799 Y72.284 E.14928
; LINE_WIDTH: 0.44999
G1 X147.555 Y71.574 E.0131
G1 X147.043 Y71.253 E.01056
G1 X145.731 Y70.883 E.02379
G1 X145.126 Y70.89 E.01057
G1 X144.547 Y71.366 E.0131
; LINE_WIDTH: 0.40715
G1 X143.5 Y73.07 E.03143
; LINE_WIDTH: 0.41102
G1 X142.453 Y74.775 E.03174
; LINE_WIDTH: 0.41488
G1 X141.407 Y76.479 E.03206
; LINE_WIDTH: 0.41688
G1 X140.867 Y77.357 E.01661
; LINE_WIDTH: 0.44999
G2 X138.083 Y81.868 I400.475 J250.279 E.09256
G1 X136.92 Y81.868 E.02031
G1 X136.92 Y78.095 E.06589
G2 X136.896 Y76.223 I-37.082 J-.468 E.03267
; LINE_WIDTH: 0.40278
G1 X136.896 Y66.947 E.14412
M204 S10000
G1 X136.491 Y66.482 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X137.683 Y66.482 E.0208
G1 X137.692 Y76.335 E.17202
G1 X137.843 Y76.648 E.00608
G1 X138.15 Y76.842 E.00633
G1 X139.458 Y77.213 E.02374
G1 X139.82 Y77.21 E.00632
G1 X140.18 Y76.933 E.00794
G1 X146.641 Y66.482 E.21452
G1 X148.586 Y66.482 E.03396
G1 X148.586 Y82.297 E.27612
G1 X147.395 Y82.297 E.0208
G1 X147.395 Y72.284 E.17483
G1 X147.233 Y71.858 E.00795
G1 X146.926 Y71.665 E.00634
G1 X145.615 Y71.295 E.02379
G1 X145.252 Y71.299 E.00634
G1 X144.894 Y71.576 E.0079
G1 X138.323 Y82.297 E.21955
G1 X136.491 Y82.297 E.03198
G1 X136.491 Y78.095 E.07337
G1 X136.491 Y66.542 E.2017
M204 S10000
G1 X136.063 Y66.054 F30000
G1 F6000
M204 S1000
G1 X138.111 Y66.054 E.03576
G1 X138.111 Y76.054 E.1746
G2 X138.165 Y76.365 I.439 J.085 E.00564
G1 X138.267 Y76.43 E.00211
G1 X139.575 Y76.801 E.02374
G1 X139.695 Y76.8 E.00211
G1 X139.816 Y76.708 E.00265
G1 X146.402 Y66.054 E.21869
G1 X149.014 Y66.054 E.04561
G1 X149.014 Y82.725 E.29109
G1 X146.966 Y82.725 E.03576
G1 X146.966 Y72.284 E.18231
G1 X146.912 Y72.142 E.00265
G1 X146.81 Y72.077 E.00211
G1 X145.499 Y71.708 E.02379
G1 X145.378 Y71.709 E.00211
G1 X145.258 Y71.801 E.00263
G1 X138.563 Y82.725 E.22371
G1 X136.063 Y82.725 E.04365
G1 X136.063 Y78.095 E.08085
G1 X136.063 Y66.114 E.20918
G1 E-.8 F1800
M204 S10000
G1 X138.433 Y73.369 Z2 F30000
G1 X139.953 Y78.025 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
G1 X139.284 Y78.031 E.01087
G3 X137.919 Y77.652 I16.149 J-60.735 E.02299
G1 X137.333 Y77.292 E.01117
G1 X137.333 Y81.455 E.0676
G1 X137.851 Y81.455 E.00841
G1 X139.922 Y78.076 E.06434
M204 S10000
G1 X139.242 Y78.423 F30000
G1 F6000
M204 S1000
G3 X137.732 Y78 I4.078 J-17.447 E.02547
G1 X137.732 Y80.887 E.04688
G1 X139.21 Y78.475 E.04594
M204 S10000
G1 X138.624 Y78.677 F30000
; LINE_WIDTH: 0.4125
G1 F6000
M204 S1000
G1 X138.127 Y78.535 E.00823
G1 X138.127 Y79.487 E.01517
G1 X138.592 Y78.728 E.0142
G1 E-.8 F1800
M204 S10000
G1 X130.967 Y78.406 Z2 F30000
G1 X128.437 Y78.299 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X126.255 Y80.481 E.0501
G1 X125.35 Y80.823
G1 X128.812 Y77.36 E.07951
G1 X129.004 Y76.605
G1 X124.649 Y80.96 E.10002
G1 X124.035 Y81.011
G1 X129.112 Y75.933 E.1166
G1 X129.169 Y75.313
G1 X123.476 Y81.006 E.13073
G1 X122.96 Y80.958
G1 X129.191 Y74.727 E.14309
G1 X129.19 Y74.164
G1 X122.481 Y80.873 E.15407
G1 X122.036 Y80.755
G1 X129.172 Y73.619 E.16386
G1 X129.124 Y73.103
G1 X121.622 Y80.605 E.17228
G1 X121.244 Y80.42
G1 X129.055 Y72.608 E.17939
G1 X128.968 Y72.132
G1 X120.89 Y80.21 E.1855
G1 X120.559 Y79.977
G1 X128.856 Y71.681 E.19052
G1 X128.717 Y71.256
G1 X120.249 Y79.724 E.19446
G1 X119.969 Y79.441
G1 X128.559 Y70.85 E.19728
G1 X128.38 Y70.466
G1 X119.708 Y79.137 E.19914
G1 X119.467 Y78.815
G1 X128.17 Y70.112 E.19985
G1 X127.94 Y69.778
G1 X119.254 Y78.465 E.19948
G1 X119.067 Y78.088
G1 X127.692 Y69.463 E.19806
G1 X127.412 Y69.179
G1 X118.899 Y77.692 E.19549
G1 X118.754 Y77.274
G1 X127.115 Y68.913 E.192
G1 X126.798 Y68.666
G1 X118.639 Y76.825 E.18737
G1 X118.543 Y76.357
G1 X126.458 Y68.442 E.18176
G1 X126.086 Y68.25
G1 X118.466 Y75.871 E.17499
G1 X118.419 Y75.354
G1 X125.688 Y68.085 E.16694
G1 X125.261 Y67.949
G1 X118.392 Y74.817 E.15773
G1 X118.385 Y74.261
G1 X124.8 Y67.846 E.14733
G1 X124.301 Y67.781
G1 X118.402 Y73.68 E.13547
G1 X118.458 Y73.061
G1 X123.758 Y67.761 E.12171
G1 X123.159 Y67.796
G1 X118.56 Y72.395 E.10561
G1 X118.735 Y71.657
G1 X122.472 Y67.92 E.08583
G1 X121.625 Y68.203
G1 X119.082 Y70.746 E.0584
G1 E-.8 F1800
M204 S10000
G1 X120.71 Y78.203 Z2 F30000
G1 X121.187 Y80.392 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0821394
G1 F3600
M204 S1000
G3 X121.075 Y80.307 I.694 J-1.026 E.00035
G1 E-.8 F1800
M204 S10000
G1 X119.557 Y72.827 Z2 F30000
G1 X119.148 Y70.811 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.190911
G1 F3600
M204 S1000
G1 X119.016 Y70.998 E.00158
; LINE_WIDTH: 0.165116
G1 X118.884 Y71.185 E.00134
M204 S10000
G1 X120.905 Y68.611 F30000
; LINE_WIDTH: 0.0891842
G1 F3600
M204 S1000
G1 X120.735 Y68.749 E.00061
; LINE_WIDTH: 0.12215
G1 X120.533 Y68.933 E.00112
; LINE_WIDTH: 0.155823
G2 X119.936 Y69.513 I5.361 J6.104 E.00456
; LINE_WIDTH: 0.140992
G1 X119.744 Y69.729 E.00141
; LINE_WIDTH: 0.107696
G1 X119.552 Y69.945 E.00102
; LINE_WIDTH: 0.0801683
G1 X119.478 Y70.038 E.00028
G1 E-.8 F1800
M204 S10000
G1 X125.296 Y74.979 Z2 F30000
G1 X128.652 Y77.829 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0728934
G1 F3600
M204 S1000
G1 X128.631 Y77.863 E.00008
; LINE_WIDTH: 0.0975346
G1 X128.544 Y77.986 E.00047
; LINE_WIDTH: 0.139596
G1 X128.458 Y78.11 E.00073
; LINE_WIDTH: 0.181658
G1 X128.371 Y78.234 E.00099
M204 S10000
G1 X127.855 Y79.195 F30000
; LINE_WIDTH: 0.0866252
G1 F3600
M204 S1000
G3 X127.148 Y79.902 I-7.391 J-6.681 E.00266
G1 E-.8 F1800
M204 S10000
G1 X134.181 Y76.936 Z2 F30000
G1 X147.744 Y71.215 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
G1 X147.744 Y67.324 E.06317
G1 X147.11 Y67.324 E.01028
G1 X145.157 Y70.484 E.06033
G1 X145.787 Y70.477 E.01024
G3 X147.155 Y70.855 I-16.582 J62.767 E.02304
G1 X147.692 Y71.184 E.01024
M204 S10000
G1 X147.345 Y70.507 F30000
G1 F6000
M204 S1000
G1 X147.345 Y67.723 E.04522
G1 X145.869 Y70.09 E.0453
G3 X147.29 Y70.483 I-8.087 J32.019 E.02395
M204 S10000
G1 X146.957 Y69.982 F30000
; LINE_WIDTH: 0.39897
G1 F6000
M204 S1000
G1 X146.957 Y69.068 E.01405
G1 X146.476 Y69.846 E.01407
G1 X146.899 Y69.965 E.00676
G1 E-.8 F1800
M204 S10000
G1 X154.503 Y70.626 Z2 F30000
G1 X162.232 Y71.298 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.51766
G1 F6000
M204 S1000
G2 X162.233 Y71.404 I-.025 J.053 E.00483
G1 E-.8 F1800
M204 S10000
G1 X169.865 Y71.34 Z2 F30000
G1 X171.243 Y71.328 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.62928
G1 F6000
M204 S1000
G2 X171.251 Y71.446 I-.035 J.062 E.00754
G1 E-.8 F1800
M204 S10000
G1 X167.623 Y78.162 Z2 F30000
G1 X167.15 Y79.039 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X166.396 Y79.792 E.0173
G1 X166.246 Y79.379
G1 X167.482 Y78.143 E.0284
G1 X167.815 Y77.246
G1 X166.095 Y78.966 E.03949
G1 X165.945 Y78.553
G1 X168.148 Y76.35 E.05059
G1 X168.481 Y75.453
G1 X165.795 Y78.14 E.06169
M73 P65 R25
G1 X165.644 Y77.726
G1 X168.814 Y74.557 E.07279
G1 X169.147 Y73.66
G1 X165.494 Y77.313 E.08389
G1 X165.343 Y76.9
G1 X169.48 Y72.764 E.09498
G1 X169.599 Y72.081
G1 X165.193 Y76.487 E.10117
G1 X165.043 Y76.074
G1 X169.035 Y72.081 E.09168
G1 X168.472 Y72.081
G1 X164.892 Y75.66 E.08219
M73 P66 R25
G1 X164.742 Y75.247
G1 X167.908 Y72.081 E.07271
G1 X167.344 Y72.081
G1 X164.591 Y74.834 E.06322
G1 X164.441 Y74.421
G1 X166.781 Y72.081 E.05373
G1 X166.217 Y72.081
G1 X164.291 Y74.007 E.04424
G1 X164.14 Y73.594
G1 X165.654 Y72.081 E.03475
G1 X165.09 Y72.081
G1 X163.99 Y73.181 E.02526
G1 X163.84 Y72.768
G1 X164.526 Y72.081 E.01577
G1 E-.8 F1800
M204 S10000
G1 X166.916 Y79.33 Z2 F30000
G1 X166.984 Y79.538 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.321855
G1 F3600
M204 S1000
G1 X166.632 Y80.053 E.00764
; LINE_WIDTH: 0.301715
G1 X166.58 Y80.021 E.00069
; LINE_WIDTH: 0.252868
G1 X166.528 Y79.99 E.00057
; LINE_WIDTH: 0.204021
G1 X166.476 Y79.958 E.00045
; LINE_WIDTH: 0.155174
G1 X166.424 Y79.927 E.00033
G1 E-.8 F1800
M204 S10000
G1 X173.779 Y77.886 Z2 F30000
G1 X186.762 Y74.284 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.53918
G1 F6000
M204 S1000
G2 X186.764 Y74.392 I-.027 J.055 E.0053
G1 E-.8 F1800
M204 S10000
G1 X192.655 Y79.245 Z2 F30000
G1 X194.317 Y80.615 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X196.039 Y78.894 E.03953
G1 X196.132 Y78.237
G1 X193.642 Y80.727 E.05718
G1 X193.051 Y80.755
G1 X196.116 Y77.69 E.07038
G1 X196.022 Y77.22
G1 X192.476 Y80.766 E.08142
G1 X191.907 Y80.771
G1 X195.865 Y76.813 E.09088
G1 X195.653 Y76.461
G1 X191.343 Y80.771 E.09898
G1 X190.779 Y80.772
G1 X195.392 Y76.159 E.10594
G1 X195.083 Y75.905
G1 X190.215 Y80.772 E.11179
G1 X189.651 Y80.773
G1 X194.723 Y75.701 E.11648
G1 X194.31 Y75.55
G1 X189.087 Y80.773 E.11996
G1 X188.523 Y80.774
G1 X193.831 Y75.465 E.12191
G1 X193.319 Y75.414
G1 X187.958 Y80.774 E.12309
G1 X187.937 Y80.232
G1 X192.781 Y75.388 E.11123
G1 X192.236 Y75.37
G1 X187.937 Y79.668 E.09872
G1 X187.937 Y79.105
G1 X191.691 Y75.351 E.08621
G1 X191.128 Y75.35
G1 X187.937 Y78.541 E.07328
G1 X187.937 Y77.978
G1 X190.565 Y75.349 E.06035
G1 X190.002 Y75.349
G1 X187.937 Y77.414 E.04742
G1 X187.937 Y76.85
G1 X189.439 Y75.348 E.03449
G1 X188.876 Y75.348
G1 X187.937 Y76.287 E.02156
G1 X187.937 Y75.723
G1 X188.313 Y75.347 E.00863
G1 E-.8 F1800
M204 S10000
G1 X195.044 Y78.945 Z2 F30000
G1 X195.861 Y79.381 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0864401
G1 F3600
M204 S1000
G1 X195.795 Y79.478 E.00031
; LINE_WIDTH: 0.12281
G1 X195.651 Y79.649 E.00092
; LINE_WIDTH: 0.170069
G3 X195.19 Y80.129 I-2.642 J-2.077 E.00403
; LINE_WIDTH: 0.144071
G1 X195.013 Y80.27 E.00113
; LINE_WIDTH: 0.0947916
G1 X194.837 Y80.412 E.00068
; LINE_WIDTH: 0.0697183
G1 X194.815 Y80.427 E.00005
G1 E-.8 F1800
M204 S10000
G1 X194.893 Y75.812 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0851681
G1 F3600
M204 S1000
G2 X194.769 Y75.72 I-.644 J.737 E.0004
G1 E-.8 F1800
M204 S10000
G1 X199.633 Y81.602 Z2 F30000
G1 X209.025 Y92.96 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X209.562 Y92.424 E.01232
G1 X209.562 Y91.86
G1 X208.462 Y92.96 E.02526
G1 X207.898 Y92.96
G1 X209.562 Y91.297 E.0382
G1 X209.562 Y90.733
G1 X207.334 Y92.96 E.05114
G1 X206.771 Y92.96
G1 X209.562 Y90.17 E.06409
G1 X209.562 Y89.606
G1 X206.207 Y92.96 E.07703
G1 X205.644 Y92.96
G1 X209.562 Y89.042 E.08997
G1 X209.562 Y88.479
G1 X205.08 Y92.96 E.10291
G1 X204.516 Y92.96
G1 X209.562 Y87.915 E.11586
G1 X209.562 Y87.352
G1 X203.953 Y92.96 E.1288
G1 X203.389 Y92.96
G1 X209.562 Y86.788 E.14174
G1 X209.562 Y86.224
G1 X202.826 Y92.96 E.15469
G1 X202.262 Y92.96
G1 X209.562 Y85.661 E.16763
G1 X209.562 Y85.097
G1 X201.698 Y92.96 E.18057
G1 X201.135 Y92.96
G1 X209.136 Y84.96 E.18373
G1 X208.721 Y84.811
G1 X200.571 Y92.96 E.18715
G1 X200.008 Y92.96
G1 X208.721 Y84.247 E.20009
G1 X208.721 Y83.684
G1 X199.444 Y92.96 E.21303
G1 X198.88 Y92.96
G1 X208.721 Y83.12 E.22597
G1 X208.721 Y82.556
G1 X198.317 Y92.96 E.23892
G1 X197.753 Y92.96
G1 X208.721 Y81.993 E.25186
G1 X208.721 Y81.429
G1 X197.561 Y92.589 E.25628
G1 X197.467 Y92.12
G1 X208.721 Y80.866 E.25844
G1 X208.721 Y80.302
G1 X196.903 Y92.12 E.27138
G1 X196.34 Y92.12
G1 X209.562 Y78.898 E.30363
G1 X209.562 Y78.334
G1 X195.776 Y92.12 E.31657
G1 X195.212 Y92.12
G1 X209.562 Y77.77 E.32952
G1 X209.562 Y77.207
G1 X194.649 Y92.12 E.34246
G1 X194.085 Y92.12
G1 X209.562 Y76.643 E.3554
G1 X209.562 Y76.079
G1 X193.522 Y92.12 E.36834
G1 X192.958 Y92.12
G1 X209.562 Y75.516 E.38129
G1 X209.562 Y74.952
G1 X191.553 Y92.96 E.41354
G1 X190.99 Y92.96
G1 X209.562 Y74.389 E.42648
G1 X209.562 Y73.825
G1 X190.426 Y92.96 E.43942
G1 X189.863 Y92.96
G1 X209.562 Y73.261 E.45237
G1 X209.562 Y72.698
G1 X189.299 Y92.96 E.46531
G1 X188.735 Y92.96
G1 X209.562 Y72.134 E.47825
G1 X209.562 Y71.571
G1 X188.172 Y92.96 E.49119
G1 X187.608 Y92.96
G1 X209.562 Y71.007 E.50414
G1 X209.562 Y70.443
G1 X187.045 Y92.96 E.51708
G1 X186.481 Y92.96
G1 X209.482 Y69.96 E.52819
G1 X208.918 Y69.96
G1 X198.689 Y80.189 E.23491
G1 X198.925 Y79.389
G1 X208.721 Y69.593 E.22495
G1 X208.721 Y69.03
G1 X198.999 Y78.752 E.22326
G1 X199.018 Y78.169
G1 X208.721 Y68.466 E.22282
G1 X208.721 Y67.903
G1 X198.979 Y77.644 E.22371
G1 X198.897 Y77.162
G1 X208.721 Y67.339 E.22558
G1 X208.721 Y66.775
G1 X198.776 Y76.72 E.22837
G1 X198.618 Y76.314
G1 X208.721 Y66.212 E.232
G1 X208.721 Y65.648
G1 X198.426 Y75.943 E.23641
G1 X198.202 Y75.603
G1 X208.721 Y65.085 E.24154
G1 X208.986 Y64.82
G1 X209.562 Y64.244 E.01322
G1 X209.562 Y63.68
G1 X197.949 Y75.292 E.26666
G1 X197.668 Y75.011
G1 X209.562 Y63.117 E.27314
G1 X209.562 Y62.553
G1 X197.356 Y74.758 E.28029
G1 X197.016 Y74.535
G1 X209.562 Y61.989 E.2881
G1 X209.562 Y61.426
G1 X196.648 Y74.339 E.29654
G1 X196.254 Y74.169
G1 X209.562 Y60.862 E.30559
G1 X209.562 Y60.299
G1 X195.835 Y74.025 E.31522
G1 X195.391 Y73.905
G1 X209.562 Y59.735 E.32541
G1 X209.562 Y59.171
G1 X194.938 Y73.794 E.33581
G1 X194.486 Y73.684
G1 X209.562 Y58.608 E.3462
G1 X209.562 Y58.044
G1 X197.255 Y70.351 E.28261
M204 S10000
G1 X198.307 Y68.736 F30000
G1 F720
M204 S2000
G1 X209.562 Y57.48 E.25846
G1 X209.562 Y56.917
G1 X199.26 Y67.218 E.23656
M204 S10000
G1 X200.095 Y65.82 F30000
G1 F720
M204 S2000
G1 X209.562 Y56.353 E.21738
G1 X209.533 Y55.819
G1 X199.532 Y65.82 E.22966
G1 X198.968 Y65.82
G1 X208.969 Y55.819 E.22966
G1 X208.405 Y55.819
G1 X198.405 Y65.82 E.22966
G1 X197.841 Y65.82
G1 X207.842 Y55.819 E.22966
G1 X207.278 Y55.819
G1 X197.277 Y65.82 E.22966
G1 E-.8 F1800
M204 S10000
G1 X193.479 Y70.745 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X191.146 Y73.078 E.05357
G1 X190.406 Y73.255
G1 X194.644 Y69.016 E.09733
M204 S10000
G1 X195.809 Y67.288 F30000
G1 F720
M204 S2000
G1 X189.782 Y73.315 E.13841
M73 P67 R25
G1 X189.201 Y73.332
G1 X206.715 Y55.819 E.40217
G1 X206.151 Y55.819
G1 X188.636 Y73.334 E.40222
G1 X188.072 Y73.334
G1 X205.587 Y55.819 E.40222
G1 X205.024 Y55.819
G1 X187.937 Y72.905 E.39237
G1 X187.937 Y72.341
G1 X204.46 Y55.819 E.37943
M73 P67 R24
G1 X203.896 Y55.819
G1 X187.937 Y71.778 E.36648
G1 X187.937 Y71.214
G1 X203.333 Y55.819 E.35354
G1 X202.769 Y55.819
G1 X187.937 Y70.651 E.3406
G1 X187.937 Y70.087
G1 X202.206 Y55.819 E.32766
G1 X201.642 Y55.819
G1 X187.937 Y69.523 E.31471
G1 X187.937 Y68.96
G1 X201.078 Y55.819 E.30177
G1 X200.515 Y55.819
G1 X187.937 Y68.396 E.28883
G1 X187.937 Y67.833
G1 X199.951 Y55.819 E.27589
G1 X199.388 Y55.819
G1 X187.937 Y67.269 E.26294
G1 X187.937 Y66.705
G1 X198.824 Y55.819 E.25
G1 X198.26 Y55.819
G1 X197.561 Y56.518 E.01607
G1 X197.42 Y56.66
G1 X187.937 Y66.142 E.21775
G1 X187.696 Y65.82
G1 X196.856 Y56.66 E.21035
G1 X196.292 Y56.66
G1 X187.132 Y65.82 E.21035
G1 X186.569 Y65.82
G1 X195.729 Y56.66 E.21035
G1 X195.165 Y56.66
G1 X186.005 Y65.82 E.21035
G1 X185.442 Y65.82
G1 X194.602 Y56.66 E.21035
G1 E-.8 F1800
M204 S10000
G1 X195.117 Y64.275 Z2 F30000
G1 X196.353 Y82.524 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X185.917 Y92.96 E.23965
G1 X185.354 Y92.96
M73 P68 R24
G1 X195.602 Y82.712 E.23534
G1 X194.932 Y82.819
G1 X184.79 Y92.96 E.2329
G1 X184.227 Y92.96
G1 X194.295 Y82.892 E.23121
G1 X193.702 Y82.921
G1 X183.663 Y92.96 E.23054
G1 X183.099 Y92.96
G1 X193.11 Y82.95 E.22988
G1 X192.538 Y82.958
G1 X182.536 Y92.96 E.2297
G1 X181.972 Y92.96
G1 X191.973 Y82.96 E.22966
G1 X191.409 Y82.96
G1 X181.561 Y92.808 E.22616
G1 X181.561 Y92.245
G1 X190.846 Y82.96 E.21322
G1 X190.282 Y82.96
G1 X181.122 Y92.12 E.21035
G1 X180.559 Y92.12
G1 X189.719 Y82.96 E.21035
G1 X189.155 Y82.96
G1 X179.995 Y92.12 E.21035
G1 X179.431 Y92.12
G1 X188.591 Y82.96 E.21035
G1 X188.028 Y82.96
G1 X178.868 Y92.12 E.21035
G1 X178.304 Y92.12
G1 X187.464 Y82.96 E.21035
G1 X186.901 Y82.96
G1 X177.741 Y92.12 E.21035
G1 X177.177 Y92.12
G1 X186.337 Y82.96 E.21035
G1 X185.773 Y82.96
G1 X176.613 Y92.12 E.21035
G1 X176.421 Y92.312
G1 X175.773 Y92.96 E.01489
G1 X175.209 Y92.96
G1 X185.21 Y82.96 E.22966
G1 X185.163 Y82.443
G1 X174.645 Y92.96 E.24153
G1 X174.082 Y92.96
G1 X185.163 Y81.879 E.25447
G1 X185.163 Y81.316
G1 X173.518 Y92.96 E.26741
M73 P68 R23
G1 X172.954 Y92.96
G1 X185.163 Y80.752 E.28035
G1 X185.163 Y80.188
G1 X172.391 Y92.96 E.2933
G1 X171.827 Y92.96
G1 X185.163 Y79.625 E.30624
G1 X185.163 Y79.061
G1 X171.264 Y92.96 E.31918
G1 X170.7 Y92.96
G1 X180.701 Y82.96 E.22966
G1 X180.137 Y82.96
G1 X170.136 Y92.96 E.22966
G1 X169.573 Y92.96
G1 X179.574 Y82.96 E.22966
G1 X179.01 Y82.96
G1 X169.009 Y92.96 E.22966
G1 X168.446 Y92.96
G1 X178.446 Y82.96 E.22966
G1 X178.054 Y82.789
G1 X167.882 Y92.96 E.23358
G1 X167.318 Y92.96
G1 X178.054 Y82.225 E.24653
M73 P69 R23
G1 X178.054 Y81.661
G1 X166.755 Y92.96 E.25947
G1 X166.191 Y92.96
G1 X178.054 Y81.098 E.27241
G1 X178.054 Y80.534
G1 X165.628 Y92.96 E.28535
G1 X165.064 Y92.96
G1 X178.054 Y79.971 E.2983
G1 X178.054 Y79.407
G1 X164.5 Y92.96 E.31124
G1 X163.937 Y92.96
G1 X178.054 Y78.843 E.32418
G1 X178.054 Y78.28
G1 X163.373 Y92.96 E.33712
G1 X162.81 Y92.96
G1 X178.054 Y77.716 E.35007
G1 X178.054 Y77.153
G1 X162.246 Y92.96 E.36301
G1 X161.682 Y92.96
G1 X178.054 Y76.589 E.37595
G1 X178.054 Y76.025
G1 X161.119 Y92.96 E.3889
G1 X160.555 Y92.96
G1 X178.054 Y75.462 E.40184
G1 X178.054 Y74.898
G1 X159.992 Y92.96 E.41478
G1 X159.428 Y92.96
G1 X178.054 Y74.335 E.42772
G1 X178.054 Y73.771
G1 X158.864 Y92.96 E.44067
G1 X158.301 Y92.96
G1 X168.302 Y82.96 E.22966
G1 X167.738 Y82.96
G1 X157.737 Y92.96 E.22966
G1 X157.173 Y92.96
G1 X167.174 Y82.96 E.22966
G1 X166.611 Y82.96
G1 X156.61 Y92.96 E.22966
G1 X156.046 Y92.96
G1 X166.047 Y82.96 E.22966
G1 X165.483 Y82.96
G1 X155.483 Y92.96 E.22966
G1 X154.919 Y92.96
G1 X165.014 Y82.866 E.23181
G1 X164.856 Y82.46
G1 X154.355 Y92.96 E.24112
G1 X153.792 Y92.96
G1 X164.698 Y82.055 E.25044
G1 X164.54 Y81.649
G1 X153.228 Y92.96 E.25975
G1 X152.665 Y92.96
G1 X164.382 Y81.243 E.26907
G1 X164.224 Y80.838
G1 X152.101 Y92.96 E.27838
G1 X151.537 Y92.96
G1 X164.066 Y80.432 E.2877
G1 X163.908 Y80.027
G1 X150.974 Y92.96 E.29701
G1 X150.41 Y92.96
G1 X163.75 Y79.621 E.30633
G1 X163.592 Y79.215
G1 X149.847 Y92.96 E.31564
G1 X149.283 Y92.96
G1 X163.434 Y78.81 E.32496
G1 X163.276 Y78.404
G1 X148.719 Y92.96 E.33427
G1 X148.156 Y92.96
G1 X163.118 Y77.998 E.34359
G1 X162.96 Y77.593
G1 X147.592 Y92.96 E.3529
G1 X147.029 Y92.96
G1 X162.802 Y77.187 E.36222
G1 X162.644 Y76.782
M73 P69 R22
G1 X146.465 Y92.96 E.37153
G1 X145.901 Y92.96
G1 X162.486 Y76.376 E.38084
G1 X162.328 Y75.97
G1 X145.338 Y92.96 E.39016
G1 X144.774 Y92.96
G1 X162.17 Y75.565 E.39947
G1 X162.012 Y75.159
M73 P70 R22
G1 X144.211 Y92.96 E.40879
G1 X143.647 Y92.96
G1 X161.854 Y74.753 E.4181
G1 X161.696 Y74.348
G1 X143.083 Y92.96 E.42742
G1 X142.52 Y92.96
G1 X161.538 Y73.942 E.43673
G1 X161.38 Y73.537
G1 X141.956 Y92.96 E.44605
G1 X141.561 Y92.792
G1 X161.222 Y73.131 E.4515
G1 X161.064 Y72.725
G1 X141.561 Y92.228 E.44787
G1 X141.106 Y92.12
G1 X160.906 Y72.32 E.45468
G1 X160.748 Y71.914
G1 X140.543 Y92.12 E.464
G1 X139.979 Y92.12
G1 X149.139 Y82.96 E.21035
G1 X148.575 Y82.96
G1 X139.415 Y92.12 E.21035
G1 X138.852 Y92.12
G1 X148.012 Y82.96 E.21035
G1 X147.448 Y82.96
G1 X138.288 Y92.12 E.21035
G1 X137.725 Y92.12
G1 X146.884 Y82.96 E.21035
G1 X146.732 Y82.549
G1 X137.161 Y92.12 E.21979
G1 X136.597 Y92.12
G1 X146.732 Y81.985 E.23273
G1 E-.8 F1800
M204 S10000
G1 X149.248 Y82.85 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X160.59 Y71.509 E.26045
G1 X160.432 Y71.103
G1 X149.248 Y82.286 E.25682
G1 X149.248 Y81.723
G1 X160.274 Y70.697 E.25319
G1 X160.116 Y70.292
G1 X149.248 Y81.159 E.24956
G1 X149.248 Y80.596
G1 X159.958 Y69.886 E.24594
G1 X159.8 Y69.48
G1 X149.248 Y80.032 E.24231
G1 X149.248 Y79.468
G1 X159.642 Y69.075 E.23868
G1 X159.484 Y68.669
G1 X149.248 Y78.905 E.23505
G1 X149.248 Y78.341
G1 X159.326 Y68.264 E.23142
G1 X159.168 Y67.858
G1 X149.248 Y77.778 E.22779
G1 X149.248 Y77.214
G1 X159.01 Y67.452 E.22417
G1 X158.852 Y67.047
M73 P71 R22
G1 X149.248 Y76.65 E.22054
G1 X149.248 Y76.087
G1 X158.694 Y66.641 E.21691
G1 X158.536 Y66.235
G1 X149.248 Y75.523 E.21328
G1 X149.248 Y74.96
G1 X158.378 Y65.83 E.20966
G1 E-.8 F1800
M204 S10000
G1 X165.762 Y67.762 Z2 F30000
G1 X170.886 Y69.103 Z2
G1 Z1.6
G1 E.8 F1800
M73 P71 R21
G1 F720
M204 S2000
G1 X170.081 Y69.908 E.0185
G1 X169.517 Y69.908
G1 X171.238 Y68.187 E.03952
G1 X171.59 Y67.272
G1 X168.954 Y69.908 E.06055
G1 X168.39 Y69.908
G1 X171.942 Y66.356 E.08157
G1 E-.8 F1800
M204 S10000
G1 X177.023 Y72.052 Z2 F30000
G1 X178.054 Y73.207 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X168.313 Y82.948 E.22369
G1 X168.689 Y82.008
G1 X178.054 Y72.644 E.21505
G1 X178.054 Y72.08
G1 X169.066 Y81.068 E.20641
G1 X169.442 Y80.128
G1 X178.054 Y71.517 E.19776
G1 X178.054 Y70.953
G1 X169.818 Y79.188 E.18912
G1 X170.195 Y78.248
G1 X178.054 Y70.389 E.18048
G1 X178.054 Y69.826
G1 X170.571 Y77.308 E.17183
G1 X170.947 Y76.368
G1 X178.054 Y69.262 E.16319
G1 X178.054 Y68.698
G1 X171.324 Y75.428 E.15455
G1 X171.7 Y74.488
G1 X178.054 Y68.135 E.1459
G1 X178.054 Y67.571
G1 X172.077 Y73.548 E.13726
G1 X172.453 Y72.609
G1 X178.054 Y67.008 E.12862
G1 X178.054 Y66.444
G1 X172.829 Y71.669 E.11997
G1 X173.206 Y70.729
M73 P72 R21
G1 X178.054 Y65.88 E.11133
G1 E-.8 F1800
M204 S10000
G1 X181.8 Y72.53 Z2 F30000
G1 X185.163 Y78.498 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X180.828 Y82.832 E.09954
G1 X180.828 Y82.269
G1 X185.163 Y77.934 E.09954
G1 X185.163 Y77.37
G1 X180.828 Y81.705 E.09954
G1 X180.828 Y81.141
G1 X185.163 Y76.807 E.09954
G1 X185.163 Y76.243
G1 X180.828 Y80.578 E.09954
G1 X180.828 Y80.014
G1 X185.163 Y75.68 E.09954
G1 X185.163 Y75.116
G1 X180.828 Y79.451 E.09954
G1 X180.828 Y78.887
G1 X185.163 Y74.552 E.09954
G1 X185.163 Y73.989
G1 X180.828 Y78.323 E.09954
G1 X180.828 Y77.76
G1 X185.163 Y73.425 E.09954
G1 X185.163 Y72.861
G1 X180.828 Y77.196 E.09954
G1 X180.828 Y76.633
G1 X185.163 Y72.298 E.09954
G1 X185.163 Y71.734
G1 X180.828 Y76.069 E.09954
G1 X180.828 Y75.505
G1 X185.163 Y71.171 E.09954
M73 P72 R20
G1 X185.163 Y70.607
G1 X180.828 Y74.942 E.09954
G1 X180.828 Y74.378
G1 X185.163 Y70.043 E.09954
G1 X185.163 Y69.48
G1 X180.828 Y73.815 E.09954
G1 X180.828 Y73.251
G1 X185.163 Y68.916 E.09954
G1 X185.163 Y68.353
G1 X180.828 Y72.687 E.09954
G1 X180.828 Y72.124
G1 X185.163 Y67.789 E.09954
G1 X185.163 Y67.225
G1 X180.828 Y71.56 E.09954
G1 X180.828 Y70.996
G1 X185.163 Y66.662 E.09954
G1 X185.163 Y66.098
G1 X180.828 Y70.433 E.09954
G1 X180.828 Y69.869
G1 X194.038 Y56.66 E.30335
G1 X193.474 Y56.66
G1 X180.828 Y69.306 E.2904
G1 X180.828 Y68.742
G1 X192.911 Y56.66 E.27746
G1 X192.421 Y56.586
G1 X180.828 Y68.178 E.26621
G1 X180.828 Y67.615
G1 X192.421 Y56.022 E.26621
G1 X192.061 Y55.819
G1 X180.828 Y67.051 E.25794
G1 X180.828 Y66.488
G1 X191.497 Y55.819 E.245
G1 X190.934 Y55.819
G1 X180.828 Y65.924 E.23206
G1 X180.369 Y65.82
G1 X190.37 Y55.819 E.22966
G1 X189.806 Y55.819
G1 X179.806 Y65.82 E.22966
G1 X179.242 Y65.82
G1 X189.243 Y55.819 E.22966
G1 X188.679 Y55.819
G1 X178.678 Y65.82 E.22966
G1 X178.115 Y65.82
G1 X188.115 Y55.819 E.22966
G1 X187.552 Y55.819
G1 X173.582 Y69.789 E.3208
G1 X173.958 Y68.849
G1 X186.988 Y55.819 E.29922
G1 X186.425 Y55.819
G1 X174.335 Y67.909 E.27763
G1 X174.711 Y66.969
G1 X185.861 Y55.819 E.25605
G1 X185.297 Y55.819
G1 X175.747 Y65.369 E.21932
G1 X175.744 Y65.372
G1 X175.088 Y66.029 E.01507
G1 X174.733 Y65.82
G1 X184.734 Y55.819 E.22966
M73 P73 R20
G1 X184.17 Y55.819
G1 X174.169 Y65.82 E.22966
G1 X173.606 Y65.82
G1 X183.607 Y55.819 E.22966
G1 X183.043 Y55.819
G1 X173.042 Y65.82 E.22966
G1 X172.479 Y65.82
G1 X182.479 Y55.819 E.22966
G1 E-.8 F1800
M204 S10000
G1 X181.075 Y56.66 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X167.826 Y69.908 E.30424
G1 X167.263 Y69.908
G1 X180.511 Y56.66 E.30424
G1 X179.948 Y56.66
G1 X166.699 Y69.908 E.30424
G1 X166.136 Y69.908
G1 X179.384 Y56.66 E.30424
G1 X178.821 Y56.66
G1 X165.572 Y69.908 E.30424
G1 X165.008 Y69.908
G1 X178.257 Y56.66 E.30424
G1 X177.693 Y56.66
G1 X164.445 Y69.908 E.30424
G1 X163.881 Y69.908
G1 X177.13 Y56.66 E.30424
G1 X176.566 Y56.66
G1 X163.318 Y69.908 E.30424
G1 X162.777 Y69.885
G1 X176.421 Y56.241 E.31332
G1 X176.28 Y55.819
G1 X162.627 Y69.472 E.31353
G1 X162.476 Y69.059
G1 X175.716 Y55.819 E.30404
G1 X175.153 Y55.819
G1 X162.326 Y68.645 E.29455
G1 X162.176 Y68.232
G1 X174.589 Y55.819 E.28505
G1 X174.025 Y55.819
G1 X162.026 Y67.818 E.27556
G1 X161.875 Y67.405
G1 X173.462 Y55.819 E.26607
G1 X172.898 Y55.819
G1 X161.725 Y66.992 E.25657
G1 X161.575 Y66.578
G1 X172.335 Y55.819 E.24708
G1 X171.771 Y55.819
G1 X161.425 Y66.165 E.23759
G1 X161.206 Y65.82
G1 X171.207 Y55.819 E.22966
G1 X170.644 Y55.819
G1 X160.643 Y65.82 E.22966
G1 X160.079 Y65.82
G1 X170.08 Y55.819 E.22966
G1 X169.516 Y55.819
G1 X159.516 Y65.82 E.22966
G1 X158.952 Y65.82
G1 X168.953 Y55.819 E.22966
G1 X168.389 Y55.819
G1 X158.388 Y65.82 E.22966
G1 E-.8 F1800
M204 S10000
G1 X163.627 Y60.268 Z2 F30000
G1 X167.826 Y55.819 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X149.248 Y74.396 E.42661
G1 X149.248 Y73.832
G1 X167.262 Y55.819 E.41367
G1 X166.698 Y55.819
G1 X149.248 Y73.269 E.40072
G1 X149.248 Y72.705
G1 X166.135 Y55.819 E.38778
G1 X165.571 Y55.819
G1 X149.248 Y72.142 E.37484
G1 X149.248 Y71.578
G1 X165.008 Y55.819 E.36189
G1 X164.444 Y55.819
G1 X149.248 Y71.014 E.34895
G1 X149.248 Y70.451
G1 X163.88 Y55.819 E.33601
G1 X163.317 Y55.819
G1 X149.248 Y69.887 E.32307
G1 X149.248 Y69.324
G1 X162.753 Y55.819 E.31012
G1 X162.19 Y55.819
G1 X149.248 Y68.76 E.29718
M73 P73 R19
G1 X149.248 Y68.196
G1 X161.626 Y55.819 E.28424
G1 X161.062 Y55.819
G1 X149.248 Y67.633 E.2713
G1 X149.248 Y67.069
G1 X160.499 Y55.819 E.25835
G1 X159.935 Y55.819
G1 X149.248 Y66.506 E.24541
G1 X149.248 Y65.942
G1 X159.372 Y55.819 E.23247
G1 X158.808 Y55.819
G1 X148.807 Y65.82 E.22966
G1 X148.244 Y65.82
G1 X158.244 Y55.819 E.22966
G1 X157.681 Y55.819
G1 X147.68 Y65.82 E.22966
M73 P74 R19
G1 X147.116 Y65.82
G1 X157.117 Y55.819 E.22966
G1 X156.554 Y55.819
G1 X146.553 Y65.82 E.22966
M204 S10000
G1 X140.34 Y75.414 F30000
G1 F720
M204 S2000
G1 X139.28 Y76.474 E.02435
G1 X138.841 Y76.349
G1 X141.253 Y73.937 E.05539
M204 S10000
G1 X142.166 Y72.461 F30000
G1 F720
M204 S2000
G1 X138.402 Y76.225 E.08642
G1 X138.345 Y75.718
G1 X143.078 Y70.985 E.10869
M204 S10000
G1 X143.991 Y69.509 F30000
G1 F720
M204 S2000
G1 X138.345 Y75.154 E.12964
G1 X138.345 Y74.591
G1 X144.903 Y68.033 E.1506
M204 S10000
G1 X145.816 Y66.556 F30000
G1 F720
M204 S2000
G1 X138.345 Y74.027 E.17155
G1 X138.345 Y73.463
G1 X155.99 Y55.819 E.40519
G1 X155.426 Y55.819
G1 X138.345 Y72.9 E.39225
G1 X138.345 Y72.336
G1 X154.863 Y55.819 E.37931
G1 X154.299 Y55.819
G1 X138.345 Y71.773 E.36636
G1 X138.345 Y71.209
G1 X153.735 Y55.819 E.35342
G1 X153.172 Y55.819
G1 X138.345 Y70.645 E.34048
G1 X138.345 Y70.082
G1 X152.608 Y55.819 E.32754
G1 X152.045 Y55.819
G1 X138.345 Y69.518 E.31459
G1 X138.345 Y68.955
G1 X151.481 Y55.819 E.30165
G1 X150.917 Y55.819
G1 X138.345 Y68.391 E.28871
G1 X138.345 Y67.827
G1 X150.354 Y55.819 E.27576
G1 X149.79 Y55.819
G1 X138.345 Y67.264 E.26282
G1 X138.345 Y66.7
G1 X149.227 Y55.819 E.24988
G1 X148.663 Y55.819
G1 X138.345 Y66.137 E.23694
G1 X138.099 Y65.82
G1 X148.099 Y55.819 E.22966
G1 X147.536 Y55.819
G1 X137.535 Y65.82 E.22966
G1 X136.971 Y65.82
G1 X146.972 Y55.819 E.22966
G1 X146.409 Y55.819
G1 X136.408 Y65.82 E.22966
G1 X135.844 Y65.82
G1 X145.845 Y55.819 E.22966
G1 E-.8 F1800
M204 S10000
G1 X143.936 Y63.209 Z2 F30000
G1 X136.421 Y92.296 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X135.756 Y92.96 E.01526
G1 X135.193 Y92.96
G1 X146.732 Y81.421 E.26498
M73 P75 R19
G1 X146.732 Y80.858
G1 X134.629 Y92.96 E.27792
G1 X134.066 Y92.96
G1 X146.732 Y80.294 E.29087
M73 P75 R18
G1 X146.732 Y79.731
G1 X133.502 Y92.96 E.30381
G1 X132.938 Y92.96
G1 X146.732 Y79.167 E.31675
G1 X146.732 Y78.603
G1 X132.375 Y92.96 E.32969
G1 X131.811 Y92.96
G1 X146.732 Y78.04 E.34264
G1 X146.732 Y77.476
G1 X131.248 Y92.96 E.35558
G1 X130.684 Y92.96
G1 X146.732 Y76.913 E.36852
G1 X146.732 Y76.349
G1 X130.12 Y92.96 E.38146
G1 X129.557 Y92.96
G1 X146.732 Y75.785 E.39441
G1 X146.732 Y75.222
G1 X128.993 Y92.96 E.40735
G1 X128.43 Y92.96
G1 X138.43 Y82.96 E.22966
G1 X137.867 Y82.96
G1 X127.866 Y92.96 E.22966
G1 X127.302 Y92.96
G1 X137.303 Y82.96 E.22966
G1 X136.74 Y82.96
G1 X126.739 Y92.96 E.22966
G1 X126.175 Y92.96
G1 X136.176 Y82.96 E.22966
G1 X135.829 Y82.743
G1 X125.612 Y92.96 E.23463
G1 X125.561 Y92.448
G1 X135.829 Y82.18 E.23579
G1 X135.829 Y81.616
G1 X125.325 Y92.12 E.2412
G1 X124.762 Y92.12
G1 X135.829 Y81.052 E.25414
G1 X135.829 Y80.489
G1 X124.198 Y92.12 E.26709
G1 X123.634 Y92.12
G1 X135.829 Y79.925 E.28003
G1 X135.829 Y79.362
G1 X123.071 Y92.12 E.29297
G1 X122.507 Y92.12
G1 X135.829 Y78.798 E.30591
G1 X135.829 Y78.234
G1 X121.944 Y92.12 E.31886
G1 X121.38 Y92.12
G1 X135.829 Y77.671 E.3318
G1 X135.829 Y77.107
G1 X120.816 Y92.12 E.34474
G1 X120.421 Y92.515
G1 X119.975 Y92.96 E.01023
G1 X119.412 Y92.96
G1 X135.829 Y76.544 E.37699
G1 X135.829 Y75.98
G1 X118.848 Y92.96 E.38994
G1 X118.285 Y92.96
G1 X135.829 Y75.416 E.40288
G1 X135.829 Y74.853
G1 X130.318 Y80.364 E.12655
M204 S10000
G1 X131.21 Y78.908 F30000
G1 F720
M204 S2000
G1 X135.829 Y74.289 E.10607
G1 X135.829 Y73.726
M73 P76 R18
G1 X131.566 Y77.988 E.09788
G1 X131.789 Y77.202
G1 X135.829 Y73.162 E.09276
G1 X135.829 Y72.598
G1 X131.927 Y76.5 E.0896
G1 X132.009 Y75.854
G1 X135.829 Y72.035 E.08771
G1 X135.829 Y71.471
G1 X132.065 Y75.235 E.08642
G1 X132.086 Y74.651
G1 X135.829 Y70.908 E.08596
G1 X135.829 Y70.344
G1 X132.086 Y74.087 E.08595
G1 X132.067 Y73.542
G1 X135.829 Y69.78 E.08639
G1 X135.829 Y69.217
G1 X132.03 Y73.015 E.08722
G1 X131.965 Y72.517
G1 X135.829 Y68.653 E.08873
G1 X135.829 Y68.089
G1 X131.89 Y72.028 E.09044
G1 X131.789 Y71.566
G1 X135.829 Y67.526 E.09278
G1 X135.829 Y66.962
G1 X131.678 Y71.113 E.09531
G1 X131.539 Y70.688
G1 X135.829 Y66.399 E.09851
G1 X135.829 Y65.835
G1 X131.394 Y70.27 E.10185
G1 X131.218 Y69.882
G1 X145.281 Y55.819 E.32295
G1 X144.718 Y55.819
G1 X131.039 Y69.498 E.31413
G1 X130.828 Y69.144
G1 X144.154 Y55.819 E.30601
M73 P76 R17
G1 X143.591 Y55.819
G1 X130.616 Y68.793 E.29795
G1 X130.373 Y68.473
G1 X143.027 Y55.819 E.29059
G1 X142.463 Y55.819
G1 X130.128 Y68.154 E.28327
G1 X129.853 Y67.866
G1 X141.059 Y56.66 E.25733
G1 X140.495 Y56.66
G1 X129.577 Y67.578 E.25073
G1 X129.272 Y67.319
G1 X139.932 Y56.66 E.24479
G1 X139.368 Y56.66
G1 X128.965 Y67.062 E.23889
G1 X128.629 Y66.835
G1 X138.804 Y56.66 E.23368
G1 X138.241 Y56.66
G1 X128.289 Y66.611 E.22852
G1 X127.918 Y66.419
G1 X137.677 Y56.66 E.2241
G1 X137.114 Y56.66
G1 X127.542 Y66.231 E.2198
G1 X127.136 Y66.073
G1 X136.55 Y56.66 E.21618
G1 X136.421 Y56.225
G1 X126.72 Y65.926 E.22278
G1 X126.277 Y65.805
G1 X136.264 Y55.819 E.22933
G1 X135.7 Y55.819
G1 X125.816 Y65.703 E.22697
G1 X125.336 Y65.62
G1 X135.136 Y55.819 E.22507
G1 X134.573 Y55.819
G1 X124.825 Y65.567 E.22386
M73 P77 R17
G1 X124.302 Y65.526
G1 X134.009 Y55.819 E.22292
G1 X133.446 Y55.819
G1 X123.743 Y65.521 E.22281
G1 X123.165 Y65.536
G1 X132.882 Y55.819 E.22315
G1 X132.318 Y55.819
G1 X122.552 Y65.585 E.22428
G1 X121.887 Y65.687
G1 X131.755 Y55.819 E.22662
G1 X131.191 Y55.819
G1 X121.159 Y65.851 E.23039
G1 X120.318 Y66.128
G1 X130.628 Y55.819 E.23674
G1 X130.064 Y55.819
G1 X119.226 Y66.657 E.24889
G1 E-.8 F1800
M204 S10000
G1 X123.437 Y73.022 Z2 F30000
G1 X129.101 Y81.581 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X117.721 Y92.96 E.26132
G1 X117.157 Y92.96
G1 X127.638 Y82.48 E.24068
G1 X126.719 Y82.836
G1 X116.594 Y92.96 E.2325
G1 X116.03 Y92.96
G1 X125.953 Y83.038 E.22787
G1 X125.268 Y83.159
G1 X115.467 Y92.96 E.22509
G1 X114.903 Y92.96
G1 X124.631 Y83.232 E.2234
G1 X124.044 Y83.256
G1 X114.339 Y92.96 E.22286
G1 X113.776 Y92.96
G1 X123.482 Y83.254 E.22289
G1 X122.941 Y83.232
G1 X113.212 Y92.96 E.22341
G1 X112.649 Y92.96
G1 X122.427 Y83.182 E.22456
G1 X121.93 Y83.115
G1 X112.085 Y92.96 E.22608
G1 X111.521 Y92.96
G1 X121.455 Y83.027 E.22811
G1 X121.004 Y82.915
G1 X110.958 Y92.96 E.23069
G1 X110.394 Y92.96
G1 X120.573 Y82.782 E.23375
G1 X120.162 Y82.629
G1 X109.831 Y92.96 E.23726
G1 X109.267 Y92.96
G1 X119.776 Y82.451 E.24133
G1 X119.403 Y82.261
G1 X108.936 Y92.728 E.24037
G1 X108.654 Y92.446
G1 X119.056 Y82.044 E.23886
G1 X118.727 Y81.81
G1 X108.372 Y92.164 E.23778
G1 X108.091 Y91.882
G1 X118.409 Y81.564 E.23695
G1 X118.117 Y81.293
G1 X107.809 Y91.601 E.23671
G1 X107.527 Y91.319
G1 X117.83 Y81.016 E.2366
M73 P77 R16
G1 X117.564 Y80.718
G1 X107.245 Y91.037 E.23697
G1 X106.963 Y90.755
G1 X117.308 Y80.411 E.23755
G1 X117.067 Y80.088
G1 X106.682 Y90.473 E.23849
G1 X106.42 Y90.171
G1 X116.842 Y79.75 E.23933
G1 X116.627 Y79.401
G1 X106.42 Y89.608 E.23439
G1 X106.42 Y89.044
G1 X116.436 Y79.028 E.23
G1 X116.252 Y78.648
G1 X106.42 Y88.48 E.22579
G1 X106.42 Y87.917
G1 X116.092 Y78.245 E.22211
G1 X115.953 Y77.821
G1 X106.42 Y87.353 E.21891
G1 X106.42 Y86.79
G1 X115.833 Y77.376 E.21616
M73 P78 R16
G1 X115.732 Y76.914
G1 X106.42 Y86.226 E.21384
G1 X106.42 Y85.662
G1 X107.123 Y84.96 E.01614
G1 X107.261 Y84.822
G1 X115.649 Y76.433 E.19263
G1 X115.584 Y75.934
G1 X107.261 Y84.258 E.19114
G1 X107.261 Y83.694
G1 X115.537 Y75.418 E.19006
G1 X115.507 Y74.884
G1 X107.261 Y83.131 E.18937
G1 X107.261 Y82.567
G1 X115.497 Y74.331 E.18913
G1 X115.515 Y73.75
G1 X107.261 Y82.004 E.18954
G1 X107.261 Y81.44
G1 X115.544 Y73.157 E.19021
G1 X115.614 Y72.523
G1 X107.261 Y80.876 E.19183
G1 X107.261 Y80.313
G1 X115.735 Y71.839 E.1946
G1 X115.912 Y71.098
G1 X107.19 Y79.82 E.20028
G1 X106.627 Y79.82
G1 X116.205 Y70.241 E.21996
G1 X116.742 Y69.141
G1 X106.42 Y79.463 E.23704
G1 X106.42 Y78.899
G1 X129.5 Y55.819 E.53002
G1 X128.937 Y55.819
G1 X106.42 Y78.336 E.51708
G1 X106.42 Y77.772
G1 X128.373 Y55.819 E.50413
G1 X127.81 Y55.819
G1 X106.42 Y77.208 E.49119
G1 X106.42 Y76.645
G1 X127.246 Y55.819 E.47825
G1 X126.682 Y55.819
G1 X106.42 Y76.081 E.46531
G1 X106.42 Y75.518
G1 X125.278 Y56.66 E.43305
G1 X124.714 Y56.66
G1 X106.42 Y74.954 E.42011
G1 X106.42 Y74.39
G1 X124.151 Y56.66 E.40717
G1 X123.587 Y56.66
G1 X106.42 Y73.827 E.39423
G1 X106.42 Y73.263
G1 X123.023 Y56.66 E.38128
G1 X122.46 Y56.66
G1 X106.42 Y72.7 E.36834
G1 X106.42 Y72.136
G1 X121.896 Y56.66 E.3554
G1 X121.333 Y56.66
G1 X106.42 Y71.572 E.34246
G1 X106.42 Y71.009
G1 X120.769 Y56.66 E.32951
G1 X120.421 Y56.444
G1 X107.261 Y69.604 E.3022
G1 X107.261 Y69.041
G1 X120.421 Y55.881 E.3022
G1 X119.919 Y55.819
G1 X107.261 Y68.477 E.29068
G1 X107.261 Y67.913
G1 X119.355 Y55.819 E.27774
G1 X118.792 Y55.819
G1 X107.261 Y67.35 E.2648
G1 X107.261 Y66.786
G1 X118.228 Y55.819 E.25186
G1 X117.665 Y55.819
G1 X107.261 Y66.223 E.23891
G1 X107.261 Y65.659
G1 X117.101 Y55.819 E.22597
G1 X116.537 Y55.819
G1 X107.261 Y65.095 E.21303
G1 X106.973 Y64.82
G1 X115.974 Y55.819 E.20669
G1 X115.41 Y55.819
M73 P79 R16
G1 X106.42 Y64.809 E.20645
G1 X106.42 Y64.245
M73 P79 R15
G1 X114.847 Y55.819 E.19351
G1 X114.283 Y55.819
G1 X106.42 Y63.682 E.18057
G1 X106.42 Y63.118
G1 X113.719 Y55.819 E.16762
G1 X113.156 Y55.819
G1 X106.42 Y62.555 E.15468
G1 X106.42 Y61.991
G1 X112.592 Y55.819 E.14174
G1 X112.029 Y55.819
G1 X106.42 Y61.427 E.1288
G1 X106.42 Y60.864
G1 X111.465 Y55.819 E.11585
G1 X110.901 Y55.819
G1 X106.42 Y60.3 E.10291
G1 X106.42 Y59.737
G1 X110.338 Y55.819 E.08997
G1 X109.774 Y55.819
G1 X106.42 Y59.173 E.07703
G1 X106.42 Y58.609
G1 X109.211 Y55.819 E.06408
G1 X108.647 Y55.819
G1 X106.42 Y58.046 E.05114
G1 X106.42 Y57.482
G1 X108.083 Y55.819 E.0382
G1 X107.52 Y55.819
G1 X106.42 Y56.919 E.02526
G1 X106.42 Y56.355
G1 X106.956 Y55.819 E.01231
G1 E-.8 F1800
M204 S10000
G1 X106.677 Y63.446 Z2 F30000
G1 X106.42 Y70.445 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X106.905 Y69.96 E.01115
G1 E-.8 F1800
M204 S10000
G1 X113.052 Y65.435 Z2 F30000
G1 X126.119 Y55.819 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X125.561 Y56.377 E.01281
G1 E-.8 F1800
M204 S10000
G1 X131.338 Y61.365 Z2 F30000
G1 X146.732 Y74.658 Z2
G1 Z1.6
G1 E.8 F1800
G1 F720
M204 S2000
G1 X139.112 Y82.278 E.17499
M204 S10000
G1 X140.004 Y80.823 F30000
G1 F720
M204 S2000
G1 X146.732 Y74.095 E.1545
G1 X146.732 Y73.531
G1 X140.896 Y79.367 E.13401
M204 S10000
G1 X141.788 Y77.911 F30000
G1 F720
M204 S2000
G1 X146.732 Y72.967 E.11352
G1 X146.732 Y72.404
G1 X142.681 Y76.455 E.09303
M204 S10000
M73 P80 R15
G1 X143.573 Y74.999 F30000
G1 F720
M204 S2000
G1 X146.374 Y72.198 E.06433
G1 X145.935 Y72.074
G1 X144.465 Y73.543 E.03374
G1 E-.8 F1800
M204 S10000
G1 X137.782 Y77.229 Z2 F30000
G1 X109.224 Y92.98 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11092
G1 F3600
M204 S1000
G1 X109.094 Y92.851 E.00067
G1 E-.8 F1800
M204 S10000
G1 X116.727 Y92.83 Z2 F30000
G1 X197.583 Y92.611 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.104982
G1 F3600
M204 S1000
M73 P80 R14
G1 X197.583 Y92.98 E.00126
G1 E-.8 F1800
M204 S10000
G1 X190.032 Y91.866 Z2 F30000
G1 X106.494 Y79.537 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.128012
G1 F3600
M204 S1000
G1 X106.45 Y79.643 E.0005
G1 X106.45 Y79.839 E.00085
G1 E-.8 F1800
M204 S10000
G1 X111.687 Y74.287 Z2 F30000
G1 X117.34 Y68.294 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0751432
G1 F3600
M204 S1000
G1 X117.211 Y68.432 E.00041
; LINE_WIDTH: 0.103654
G1 X117.033 Y68.646 E.00093
; LINE_WIDTH: 0.148512
G1 X116.855 Y68.86 E.00144
; LINE_WIDTH: 0.193371
G1 X116.676 Y69.075 E.00195
M204 S10000
G1 X119.162 Y66.593 F30000
; LINE_WIDTH: 0.199022
G1 F3600
M204 S1000
G1 X118.984 Y66.738 E.00166
; LINE_WIDTH: 0.159513
G1 X118.806 Y66.883 E.00129
; LINE_WIDTH: 0.119633
G1 X118.626 Y67.031 E.00093
; LINE_WIDTH: 0.0844496
G1 X118.362 Y67.271 E.00091
M204 S10000
G1 X120.246 Y66.056 F30000
; LINE_WIDTH: 0.0977989
G1 F3600
M204 S1000
G2 X119.884 Y66.309 I4.46 J6.762 E.00137
G1 E-.8 F1800
M204 S10000
G1 X124.32 Y65.544 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0905382
G1 F3600
M204 S1000
G1 X124.099 Y65.447 E.00068
G1 E-.8 F1800
M204 S10000
G1 X128.014 Y71.999 Z2 F30000
G1 X131.634 Y78.055 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.173983
G1 F3600
M204 S1000
G3 X131.425 Y78.393 I-6.802 J-3.971 E.00247
M204 S10000
G1 X131.275 Y78.974 F30000
; LINE_WIDTH: 0.184225
G1 F3600
M204 S1000
G1 X131.158 Y79.131 E.0013
; LINE_WIDTH: 0.138245
G1 X131.042 Y79.288 E.00093
; LINE_WIDTH: 0.0922649
G1 X130.925 Y79.446 E.00057
M204 S10000
G1 X130.381 Y80.427 F30000
; LINE_WIDTH: 0.206639
G1 F3600
M204 S1000
G3 X129.164 Y81.645 I-12.584 J-11.363 E.01299
M204 S10000
G1 X128.151 Y82.218 F30000
; LINE_WIDTH: 0.084433
G1 F3600
M204 S1000
G1 X128.047 Y82.299 E.00034
; LINE_WIDTH: 0.115422
G1 X127.938 Y82.383 E.00053
; LINE_WIDTH: 0.149165
G1 X127.821 Y82.464 E.00074
; LINE_WIDTH: 0.184072
G1 X127.704 Y82.545 E.00094
M204 S10000
G1 X124.844 Y83.301 F30000
; LINE_WIDTH: 0.103751
G1 F3600
M204 S1000
G1 X124.616 Y83.217 E.00082
G1 E-.8 F1800
M204 S10000
G1 X131.49 Y79.9 Z2 F30000
G1 X144.529 Y73.608 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X144.376 Y73.802 E.00171
; LINE_WIDTH: 0.142202
G1 X144.223 Y73.996 E.00122
; LINE_WIDTH: 0.0935901
G1 X144.07 Y74.19 E.00073
M204 S10000
G1 X143.637 Y75.063 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X143.484 Y75.258 E.00171
; LINE_WIDTH: 0.142203
G1 X143.331 Y75.452 E.00122
; LINE_WIDTH: 0.0935905
G1 X143.178 Y75.646 E.00073
M204 S10000
G1 X142.745 Y76.519 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X142.592 Y76.713 E.00171
; LINE_WIDTH: 0.142202
G1 X142.439 Y76.908 E.00122
; LINE_WIDTH: 0.0935901
G1 X142.285 Y77.102 E.00073
M204 S10000
G1 X141.853 Y77.975 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X141.699 Y78.169 E.00171
; LINE_WIDTH: 0.142203
G1 X141.546 Y78.363 E.00122
; LINE_WIDTH: 0.0935905
G1 X141.393 Y78.558 E.00073
M204 S10000
G1 X140.96 Y79.431 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X140.807 Y79.625 E.00171
; LINE_WIDTH: 0.142202
G1 X140.654 Y79.819 E.00122
; LINE_WIDTH: 0.0935904
G1 X140.501 Y80.014 E.00073
M204 S10000
G1 X140.068 Y80.887 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X139.915 Y81.081 E.00171
; LINE_WIDTH: 0.142203
G1 X139.762 Y81.275 E.00122
; LINE_WIDTH: 0.0935906
G1 X139.609 Y81.469 E.00073
M204 S10000
G1 X139.176 Y82.343 F30000
; LINE_WIDTH: 0.190825
G1 F3600
M204 S1000
G1 X139.023 Y82.537 E.00171
; LINE_WIDTH: 0.142209
G1 X138.87 Y82.731 E.00122
; LINE_WIDTH: 0.0935926
G1 X138.716 Y82.925 E.00073
G1 E-.8 F1800
M204 S10000
G1 X139.832 Y76.234 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0890518
G1 F3600
M204 S1000
G1 X139.697 Y76.404 E.0006
; LINE_WIDTH: 0.128589
G1 X139.562 Y76.575 E.00095
M204 S10000
G1 X140.744 Y74.758 F30000
; LINE_WIDTH: 0.0936571
G1 F3600
M204 S1000
G1 X140.588 Y74.955 E.00074
; LINE_WIDTH: 0.142407
G1 X140.432 Y75.152 E.00124
; LINE_WIDTH: 0.191156
G1 X140.276 Y75.349 E.00174
M204 S10000
G1 X141.657 Y73.282 F30000
; LINE_WIDTH: 0.0936601
G1 F3600
M204 S1000
G1 X141.501 Y73.479 E.00074
; LINE_WIDTH: 0.142414
G1 X141.345 Y73.676 E.00124
; LINE_WIDTH: 0.191168
G1 X141.189 Y73.873 E.00174
M204 S10000
G1 X142.569 Y71.805 F30000
; LINE_WIDTH: 0.0936598
G1 F3600
M204 S1000
G1 X142.413 Y72.003 E.00074
; LINE_WIDTH: 0.142414
G1 X142.257 Y72.2 E.00124
; LINE_WIDTH: 0.191168
G1 X142.101 Y72.397 E.00174
M204 S10000
G1 X143.482 Y70.329 F30000
; LINE_WIDTH: 0.09366
G1 F3600
M204 S1000
G1 X143.326 Y70.526 E.00074
; LINE_WIDTH: 0.142414
G1 X143.17 Y70.724 E.00124
; LINE_WIDTH: 0.191168
G1 X143.014 Y70.921 E.00174
M204 S10000
G1 X144.395 Y68.853 F30000
; LINE_WIDTH: 0.0936593
G1 F3600
M204 S1000
G1 X144.239 Y69.05 E.00074
; LINE_WIDTH: 0.142413
G1 X144.083 Y69.247 E.00124
; LINE_WIDTH: 0.191166
G1 X143.926 Y69.445 E.00174
M204 S10000
G1 X145.307 Y67.377 F30000
; LINE_WIDTH: 0.0936573
G1 F3600
M204 S1000
G1 X145.151 Y67.574 E.00074
; LINE_WIDTH: 0.142407
G1 X144.995 Y67.771 E.00124
; LINE_WIDTH: 0.191156
G1 X144.839 Y67.968 E.00174
M204 S10000
G1 X146.22 Y65.901 F30000
; LINE_WIDTH: 0.09366
G1 F3600
M204 S1000
G1 X146.064 Y66.098 E.00074
; LINE_WIDTH: 0.142414
G1 X145.908 Y66.295 E.00124
; LINE_WIDTH: 0.191168
G1 X145.752 Y66.492 E.00174
G1 E-.8 F1800
M204 S10000
G1 X145.578 Y71.953 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.241797
G1 F3600
M204 S1000
G1 X145.424 Y72.148 E.00223
; LINE_WIDTH: 0.192508
G1 X145.27 Y72.343 E.00173
; LINE_WIDTH: 0.143218
G1 X145.116 Y72.539 E.00123
; LINE_WIDTH: 0.0939291
G1 X144.962 Y72.734 E.00073
G1 E-.8 F1800
M204 S10000
G1 X152.417 Y71.097 Z2 F30000
G1 X175.159 Y66.1 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.193713
G1 F3600
M204 S1000
G1 X174.907 Y66.425 E.00289
G1 E-.8 F1800
M204 S10000
G1 X177.5 Y73.604 Z2 F30000
G1 X180.834 Y82.838 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.146477
G1 F3600
M204 S1000
G1 X180.87 Y82.973 E.00071
G1 X180.842 Y83.001 E.0002
G1 X180.707 Y82.965 E.00071
G1 E-.8 F1800
M204 S10000
G1 X188.333 Y82.67 Z2 F30000
G1 X196.788 Y82.342 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0791069
G1 F3600
M204 S1000
G1 X196.717 Y82.395 E.00021
; LINE_WIDTH: 0.106575
G1 X196.618 Y82.461 E.00041
; LINE_WIDTH: 0.141183
G1 X196.52 Y82.527 E.00058
; LINE_WIDTH: 0.17579
G1 X196.422 Y82.593 E.00074
G1 E-.8 F1800
M204 S10000
G1 X193.828 Y75.414 Z2 F30000
G1 X192.579 Y71.959 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0876077
G1 F3600
M204 S1000
G3 X191.89 Y72.648 I-6.101 J-5.419 E.00263
M204 S10000
G1 X193.992 Y69.981 F30000
; LINE_WIDTH: 0.0881022
G1 F3600
M204 S1000
G1 X193.848 Y70.156 E.00062
; LINE_WIDTH: 0.125715
G1 X193.704 Y70.331 E.00096
; LINE_WIDTH: 0.163327
G1 X193.559 Y70.506 E.00131
; LINE_WIDTH: 0.200939
G1 X193.415 Y70.681 E.00166
M204 S10000
G1 X195.157 Y68.253 F30000
; LINE_WIDTH: 0.0881023
G1 F3600
M204 S1000
G1 X195.013 Y68.428 E.00062
; LINE_WIDTH: 0.125715
G1 X194.868 Y68.602 E.00096
; LINE_WIDTH: 0.163327
G1 X194.724 Y68.777 E.00131
; LINE_WIDTH: 0.200939
G1 X194.58 Y68.952 E.00166
M204 S10000
G1 X196.322 Y66.524 F30000
; LINE_WIDTH: 0.0881023
G1 F3600
M204 S1000
G1 X196.178 Y66.699 E.00062
; LINE_WIDTH: 0.125715
G1 X196.033 Y66.874 E.00096
; LINE_WIDTH: 0.163327
G1 X195.889 Y67.049 E.00131
; LINE_WIDTH: 0.200939
G1 X195.745 Y67.224 E.00166
G1 E-.8 F1800
M204 S10000
G1 X200.173 Y65.897 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.163593
G1 F3600
M204 S1000
G1 X200.046 Y66.056 E.00118
; LINE_WIDTH: 0.125871
G1 X199.919 Y66.215 E.00087
; LINE_WIDTH: 0.0881488
G1 X199.792 Y66.374 E.00055
M204 S10000
G1 X199.324 Y67.283 F30000
; LINE_WIDTH: 0.191819
G1 F3600
M204 S1000
G1 X199.162 Y67.486 E.0018
; LINE_WIDTH: 0.142806
G1 X199 Y67.689 E.00128
; LINE_WIDTH: 0.093794
G1 X198.839 Y67.892 E.00077
M204 S10000
G1 X198.371 Y68.8 F30000
; LINE_WIDTH: 0.191818
G1 F3600
M204 S1000
G1 X198.209 Y69.003 E.0018
; LINE_WIDTH: 0.142806
G1 X198.047 Y69.206 E.00128
; LINE_WIDTH: 0.0937937
G1 X197.885 Y69.409 E.00077
M204 S10000
G1 X197.243 Y70.338 F30000
; LINE_WIDTH: 0.195674
G1 F3600
M204 S1000
G1 X197.255 Y70.492 E.00109
; LINE_WIDTH: 0.196561
G1 X197.012 Y70.768 E.00263
; LINE_WIDTH: 0.147728
G1 X196.77 Y71.045 E.00189
; LINE_WIDTH: 0.0987669
G1 X196.526 Y71.324 E.00117
; LINE_WIDTH: 0.0717872
G1 X196.452 Y71.402 E.00022
M204 S10000
G1 X195.908 Y71.947 F30000
; LINE_WIDTH: 0.0908456
G1 F3600
M204 S1000
G1 X195.529 Y72.294 E.00145
; LINE_WIDTH: 0.135653
G1 X195.31 Y72.48 E.00134
; LINE_WIDTH: 0.181917
G1 X195.091 Y72.667 E.00188
; LINE_WIDTH: 0.22818
G1 X194.872 Y72.853 E.00242
; LINE_WIDTH: 0.274444
G1 X194.653 Y73.039 E.00297
; LINE_WIDTH: 0.320707
G1 X194.434 Y73.226 E.00351
; LINE_WIDTH: 0.366971
G1 X194.214 Y73.412 E.00405
; LINE_WIDTH: 0.394679
G1 X194.188 Y73.437 E.00054
; LINE_WIDTH: 0.374764
G1 X194.222 Y73.484 E.00084
; LINE_WIDTH: 0.325782
G1 X194.256 Y73.531 E.00072
; LINE_WIDTH: 0.276801
G1 X194.29 Y73.578 E.0006
; LINE_WIDTH: 0.227819
G1 X194.323 Y73.625 E.00049
; LINE_WIDTH: 0.178837
G1 X194.357 Y73.672 E.00037
M204 S10000
G1 X196.209 Y74.151 F30000
; LINE_WIDTH: 0.0774171
G1 F3600
M204 S1000
G1 X196.077 Y74.065 E.00036
G1 E-.8 F1800
M204 S10000
G1 X198.757 Y80.257 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.170658
G1 F3600
M204 S1000
G1 X198.668 Y80.387 E.00096
; LINE_WIDTH: 0.152902
G1 X198.604 Y80.476 E.00059
; LINE_WIDTH: 0.119452
G1 X198.54 Y80.565 E.00044
; LINE_WIDTH: 0.0860022
G1 X198.477 Y80.654 E.00029
; CHANGE_LAYER
; Z_HEIGHT: 1.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F3600
G1 X198.54 Y80.565 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 17/58
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
G1 E-1.2
; filament end gcode 

M204 S10000
G17
G3 Z2 I1.217 J0 P1  F30000
;=X1 20251031=
M620 S1A
M204 S9000
G1 Z4.7 F1200

G1 X70 F21000
G1 Y245
G1 Y265 F3000
M400
M106 P1 S0
M106 P2 S0

M104 S220


M620.11 S0

M400
G1 X90
G1 Y255 F4000
G1 X100 F5000
G1 X120 F15000
G1 X20 Y50 F21000
G1 Y-3

M620.1 E F399.119 T240
T1
M73 E1
M620.1 E F299.339 T270



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S260


G1 E23.7 F399.119 ; do not need pulsatile flushing for start part
G1 E0.627742 F50
G1 E7.21903 F399.119
G1 E0.627742 F50
G1 E7.21903 F299.339
G1 E0.627742 F50
M73 P81 R14
G1 E7.21903 F299.339
G1 E0.627742 F50
G1 E7.21903 F299.339

; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
G1 E9.91568 F299.339
G1 E1.10174 F50
; FLUSH_END

; FLUSH_START
M400
M109 S255
G1 E2 F299.339 ;Compensate for filament spillage during waiting temperature
; FLUSH_END
M400
G92 E0
G1 E-2 F1800
M106 P1 S255
M400 S3

G1 X70 F5000
G1 X90 F3000
G1 Y255 F4000
G1 X105 F5000
G1 Y265
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000

G1 X70 F10000
G1 X80 F15000
G1 X60
G1 X80
G1 X60
G1 X80 ; shake to put down garbage
G1 X100 F5000
G1 X165 F15000; wipe and shake
G1 Y256 ; move Y to aside, prevent collision
M400
G1 Z4.7 F3000

M204 S1000


M621 S1A
M106 S102
M106 P2 S0
M104 S255 ; set nozzle temperature
; filament start gcode
M106 P3 S180


; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
G1 X198.333 Y80.464 F30000
G1 Z1.7
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 E2 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
M204 S1000
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.1 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.1 F30000
G1 X208.887 Y69.747
G1 X208.865 Y80.032
M73 P82 R13
G1 X208.501 Y79.6
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 17 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer17 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.1 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
M73 P83 R12
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.1 F30000
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.1 F30000
G1 X192.634 Y92.321
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.1 F30000
G1 X179.68 Y82.747
G1 X179.716 Y81.848
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X179.166 Y81.848 E.01199
G1 X179.166 Y66.931 E.32454
G1 X179.716 Y66.931 E.01199
G1 X179.716 Y67.207 E.00599
G1 X179.716 Y81.788 E.31725
M204 S10000
G1 X180.206 Y82.338 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X178.676 Y82.338 E.0259
G1 X178.676 Y66.442 E.26904
G1 X180.206 Y66.442 E.0259
G1 X180.206 Y67.207 E.01295
G1 X180.206 Y82.278 E.25508
M204 S10000
G1 X180.635 Y82.766 F30000
G1 F6000
M204 S1000
G1 X178.247 Y82.766 E.04041
G1 X178.247 Y66.013 E.28355
G1 X180.635 Y66.013 E.04041
G1 X180.635 Y67.207 E.0202
G1 X180.635 Y82.706 E.26233
M204 S250
G1 X181.048 Y83.18 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X177.834 Y83.18 E.0506
G1 X177.834 Y65.6 E.27672
G1 X181.048 Y65.6 E.0506
M73 P84 R12
G1 X181.048 Y67.207 E.0253
G1 X181.048 Y83.12 E.25048
; WIPE_START
M204 S1000
G1 X179.049 Y83.157 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.049 Y82.747 Z2.1 F30000
G1 X180.615 Y81.984
G1 X185.376 Y78.422
G1 X187.725 Y75.134
G1 X193.876 Y72.062
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54611
G1 F6000
M204 S1000
G2 X194.55 Y71.131 I-10.858 J-8.572 E.02383
; LINE_WIDTH: 0.55718
G1 X194.88 Y70.661 E.01214
; LINE_WIDTH: 0.582185
G1 X195.045 Y70.437 E.00617
; LINE_WIDTH: 0.60719
G1 X195.211 Y70.213 E.00644
; LINE_WIDTH: 0.62971
G1 X195.545 Y69.734 E.01404
; LINE_WIDTH: 0.63992
G2 X196.564 Y68.221 I-84.852 J-58.196 E.04455
; LINE_WIDTH: 0.63471
G1 X197.314 Y67.083 E.03303
; LINE_WIDTH: 0.6132
G1 X197.402 Y66.952 E.00369
G1 X198.094 Y66.952 E.01618
G1 X197.811 Y67.405 E.01249
; LINE_WIDTH: 0.63471
G1 X197.076 Y68.558 E.03311
; LINE_WIDTH: 0.63992
G3 X196.037 Y70.092 I-28.858 J-18.431 E.04528
; LINE_WIDTH: 0.62971
G1 X195.664 Y70.58 E.01475
; LINE_WIDTH: 0.60719
G1 X195.472 Y70.797 E.0067
; LINE_WIDTH: 0.581235
G1 X195.28 Y71.014 E.0064
; LINE_WIDTH: 0.55528
G1 X194.834 Y71.409 E.01256
; LINE_WIDTH: 0.54611
G3 X193.926 Y72.031 I-7.653 J-10.2 E.0228
G1 E-.8 F1800
M204 S10000
G1 X193.599 Y74.31 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X193.646 Y74.385 E.00149
G2 X191.677 Y74.3 I-2.331 J30.98 E.03337
; LINE_WIDTH: 0.475485
G1 X191.269 Y74.287 E.00731
; LINE_WIDTH: 0.50098
G1 X190.862 Y74.274 E.00772
G1 X190.99 Y74.236 E.00252
; LINE_WIDTH: 0.48378
G1 X191.609 Y74.019 E.01198
; LINE_WIDTH: 0.44999
G1 X192.173 Y73.729 E.01074
G1 X192.464 Y73.532 E.00595
G1 X192.997 Y73.07 E.01193
; LINE_WIDTH: 0.45052
G1 X193.39 Y72.623 E.0101
G1 X193.261 Y72.933 E.00569
; LINE_WIDTH: 0.44999
G1 X193.212 Y73.183 E.00431
G1 X193.272 Y73.783 E.0102
G1 X193.568 Y74.259 E.0095
; WIPE_START
G1 X193.646 Y74.385 E-.05631
G1 X192.841 Y74.331 E-.30646
G1 X191.796 Y74.303 E-.39723
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X191.781 Y75.139 Z2.1 F30000
G1 X191.687 Y75.138
G1 X191.058 Y75.134
G1 X187.725 Y75.134
G1 X186.826 Y77.754
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X186.826 Y80.355 E.05659
; LINE_WIDTH: 0.58603
G1 X186.842 Y80.621 E.00594
G1 X186.935 Y80.797 E.00444
; LINE_WIDTH: 0.540684
G1 X187.027 Y80.974 E.00409
; LINE_WIDTH: 0.495337
G1 X187.12 Y81.15 E.00373
; LINE_WIDTH: 0.44999
G1 X187.61 Y81.622 E.01151
; LINE_WIDTH: 0.491915
G1 X187.983 Y81.744 E.0073
; LINE_WIDTH: 0.53384
G1 X188.357 Y81.867 E.00795
G1 X187.944 Y81.888 E.00835
; LINE_WIDTH: 0.491915
G1 X187.532 Y81.909 E.00767
; LINE_WIDTH: 0.44999
G1 X186.214 Y81.909 E.02232
G1 X186.214 Y81.417 E.00834
; LINE_WIDTH: 0.49077
G1 X186.234 Y81.063 E.00657
; LINE_WIDTH: 0.53155
G1 X186.254 Y80.709 E.00714
; LINE_WIDTH: 0.57233
G1 X186.275 Y80.355 E.00771
G1 X186.275 Y76.355 E.08703
G2 X186.254 Y75.529 I-4.825 J-.294 E.01801
; LINE_WIDTH: 0.53155
G1 X186.234 Y75.291 E.00481
; LINE_WIDTH: 0.49077
G1 X186.214 Y75.053 E.00442
; LINE_WIDTH: 0.44999
G1 X186.214 Y73.628 E.02413
; LINE_WIDTH: 0.495337
G1 X186.236 Y73.495 E.00252
; LINE_WIDTH: 0.540684
G1 X186.259 Y73.362 E.00276
; LINE_WIDTH: 0.58603
G2 X186.275 Y72.915 I-1.15 J-.265 E.01004
; LINE_WIDTH: 0.57233
G1 X186.275 Y66.931 E.13018
G1 X186.826 Y66.931 E.01199
G1 X186.826 Y72.915 E.13018
; LINE_WIDTH: 0.58603
G1 X186.842 Y73.18 E.00594
G1 X186.894 Y73.278 E.00246
; LINE_WIDTH: 0.540684
G1 X186.945 Y73.375 E.00226
; LINE_WIDTH: 0.495337
G1 X186.997 Y73.473 E.00207
; LINE_WIDTH: 0.44999
G1 X187.283 Y73.918 E.00896
G1 X187.664 Y74.211 E.00813
G1 X187.948 Y74.276 E.00493
; LINE_WIDTH: 0.411405
G1 X188.232 Y74.34 E.00449
G1 X187.948 Y74.405 E.00449
; LINE_WIDTH: 0.44999
G1 X187.664 Y74.47 E.00493
G1 X187.283 Y74.762 E.00813
G1 X186.997 Y75.208 E.00896
; LINE_WIDTH: 0.49077
G1 X186.94 Y75.394 E.00361
; LINE_WIDTH: 0.53155
G1 X186.883 Y75.58 E.00392
; LINE_WIDTH: 0.57233
G1 X186.826 Y75.766 E.00424
G1 X186.826 Y77.694 E.04194
; WIPE_START
G1 X186.826 Y79.694 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X187.725 Y75.134 Z2.1 F30000
G1 X191.058 Y75.134
G1 X191.687 Y75.138
G1 X192.258 Y75.148
G1 X192.77 Y75.166
G1 X193.224 Y75.191
G1 X193.623 Y75.224
G1 X193.968 Y75.265
G1 X194.268 Y75.318
G1 X194.532 Y75.389
G1 X194.928 Y75.557
G1 X195.175 Y75.711
G1 X195.603 Y75.027
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.39723
G1 F6000
M204 S1000
G1 X196.134 Y75.23 E.00844
; LINE_WIDTH: 0.39845
G1 X196.759 Y75.603 E.01083
; LINE_WIDTH: 0.439795
G1 X196.976 Y75.834 E.00524
; LINE_WIDTH: 0.48114
G1 X197.193 Y76.065 E.00576
; LINE_WIDTH: 0.510205
G1 X197.336 Y76.288 E.00511
; LINE_WIDTH: 0.53927
G1 X197.48 Y76.51 E.00541
; LINE_WIDTH: 0.58192
G1 X197.701 Y77.043 E.01277
; LINE_WIDTH: 0.61045
G1 X197.836 Y77.653 E.01453
; LINE_WIDTH: 0.63163
G1 X197.878 Y78.375 E.01743
; LINE_WIDTH: 0.63865
G1 X197.841 Y78.913 E.01314
; LINE_WIDTH: 0.64478
G3 X197.567 Y79.896 I-3.882 J-.55 E.0252
; LINE_WIDTH: 0.64303
G1 X197.326 Y80.354 E.01271
; LINE_WIDTH: 0.62898
G1 X196.938 Y80.85 E.01511
; LINE_WIDTH: 0.60303
G1 X196.449 Y81.266 E.01473
; LINE_WIDTH: 0.55804
G1 X196.023 Y81.466 E.00999
G1 X195.485 Y81.617 E.01183
; LINE_WIDTH: 0.595907
G1 X195.282 Y81.63 E.00461
; LINE_WIDTH: 0.633774
G1 X195.079 Y81.643 E.00491
; LINE_WIDTH: 0.67164
G1 X194.877 Y81.656 E.00522
G1 X195.05 Y81.56 E.0051
; LINE_WIDTH: 0.633774
G1 X195.224 Y81.464 E.0048
; LINE_WIDTH: 0.595907
G1 X195.398 Y81.368 E.0045
; LINE_WIDTH: 0.55804
G1 X195.841 Y81.085 E.01115
; LINE_WIDTH: 0.57607
G1 X196.288 Y80.697 E.01297
; LINE_WIDTH: 0.61751
G1 X196.593 Y80.351 E.01086
; LINE_WIDTH: 0.63174
G1 X196.875 Y79.909 E.01263
; LINE_WIDTH: 0.64478
G1 X197.129 Y79.272 E.01688
G1 X197.247 Y78.653 E.01551
; LINE_WIDTH: 0.63271
G1 X197.269 Y78.018 E.01534
; LINE_WIDTH: 0.61329
G1 X197.209 Y77.426 E.01392
; LINE_WIDTH: 0.58935
G1 X197.057 Y76.851 E.01333
; LINE_WIDTH: 0.54655
G1 X196.921 Y76.564 E.00661
; LINE_WIDTH: 0.512415
G1 X196.784 Y76.276 E.00618
; LINE_WIDTH: 0.47828
G1 X196.592 Y76.019 E.00577
; LINE_WIDTH: 0.437755
G1 X196.401 Y75.763 E.00526
; LINE_WIDTH: 0.39723
G2 X195.652 Y75.061 I-3.021 J2.473 E.01527
G1 E-.8 F1800
M204 S10000
G1 X193.915 Y74.031 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X193.951 Y74.089 E.00115
; LINE_WIDTH: 0.486565
G1 X194.17 Y74.234 E.00482
; LINE_WIDTH: 0.52314
G1 X194.389 Y74.379 E.0052
; LINE_WIDTH: 0.53007
G1 X194.632 Y74.43 E.005
; LINE_WIDTH: 0.57933
G2 X195.462 Y74.617 I2.057 J-7.204 E.01875
; LINE_WIDTH: 0.536217
G1 X195.665 Y74.653 E.00419
; LINE_WIDTH: 0.493103
G1 X195.868 Y74.69 E.00384
; LINE_WIDTH: 0.44999
G1 X196.309 Y74.866 E.00804
G1 X196.972 Y75.253 E.013
G1 X197.431 Y75.664 E.01042
G3 X198.18 Y76.922 I-3.272 J2.801 E.0249
G1 X198.343 Y77.614 E.01204
G1 X198.396 Y78.408 E.01347
G3 X197.487 Y81.006 I-4.083 J.029 E.04751
G1 X197.129 Y81.37 E.00865
G1 X196.671 Y81.699 E.00954
G1 X196.208 Y81.915 E.00866
G1 X195.596 Y82.088 E.01075
G3 X192.379 Y82.337 I-2.943 J-17.054 E.05471
G1 X185.785 Y82.338 E.1116
G1 X185.785 Y66.442 E.26904
G1 X187.315 Y66.442 E.0259
G1 X187.315 Y72.915 E.10956
G1 X187.393 Y73.31 E.00682
G1 X187.596 Y73.626 E.00635
G1 X187.866 Y73.833 E.00576
G1 X188.358 Y73.956 E.00858
G2 X190.875 Y73.806 I.511 J-12.649 E.04275
G1 X191.453 Y73.617 E.0103
G1 X192.184 Y73.208 E.01417
G1 X192.716 Y72.746 E.01193
G2 X194.472 Y70.403 I-18.003 J-15.321 E.04959
G1 X197.13 Y66.442 E.08075
G1 X199.016 Y66.442 E.03191
G1 X197.954 Y68.137 E.03385
G3 X196.457 Y70.397 I-32.942 J-20.204 E.04589
G3 X194.656 Y72.122 I-5.532 J-3.97 E.04246
G1 X194.016 Y72.532 E.01287
G1 X193.764 Y72.832 E.00661
G1 X193.638 Y73.228 E.00705
G1 X193.681 Y73.653 E.00723
G1 X193.883 Y73.98 E.00651
M204 S10000
G1 X194.231 Y73.752 F30000
G1 F6000
M204 S1000
G1 X194.248 Y73.781 E.00057
G1 X194.511 Y73.93 E.00513
G3 X196 Y74.282 I-2.195 J12.605 E.0259
G1 X196.5 Y74.481 E.00911
G1 X197.226 Y74.905 E.01422
G1 X197.8 Y75.419 E.01306
G1 X198.247 Y76.023 E.0127
G1 X198.567 Y76.705 E.01276
G1 X198.737 Y77.373 E.01167
G3 X198.824 Y78.435 I-9.282 J1.299 E.01805
G3 X197.772 Y81.341 I-4.49 J.018 E.05339
G1 X197.355 Y81.748 E.00987
G1 X196.885 Y82.072 E.00966
G1 X196.357 Y82.318 E.00986
G1 X195.689 Y82.507 E.01176
G3 X192.383 Y82.766 I-3.035 J-17.495 E.0562
G1 X185.356 Y82.766 E.11893
G1 X185.356 Y66.013 E.28355
G1 X187.744 Y66.013 E.04041
G1 X187.744 Y72.915 E.11681
G1 X187.753 Y73.02 E.0018
G1 X187.909 Y73.333 E.00591
G1 X188.068 Y73.455 E.00339
G1 X188.357 Y73.527 E.00505
G2 X190.764 Y73.392 I.487 J-12.826 E.04085
G1 X191.257 Y73.236 E.00876
G1 X191.903 Y72.885 E.01244
G1 X192.435 Y72.423 E.01193
G2 X194.119 Y70.16 I-18.627 J-15.621 E.04776
G1 X196.902 Y66.013 E.08453
G1 X199.79 Y66.013 E.04888
G1 X198.728 Y67.708 E.03385
G3 X196.8 Y70.653 I-39.596 J-23.82 E.05959
G3 X194.349 Y72.82 I-6.174 J-4.516 E.0558
G1 X194.198 Y72.953 E.0034
G1 X194.085 Y73.17 E.00415
G1 X194.083 Y73.503 E.00565
G1 X194.2 Y73.7 E.00387
M204 S250
G1 X194.535 Y73.483 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X194.639 Y73.536 E.00183
G3 X196.684 Y74.11 I-1.09 J7.81 E.03355
G1 X197.47 Y74.569 E.01432
G1 X198.108 Y75.139 E.01346
G1 X198.604 Y75.81 E.01312
G1 X198.958 Y76.565 E.01313
G1 X199.137 Y77.271 E.01147
G3 X199.237 Y78.461 I-8.741 J1.329 E.01881
G1 X199.197 Y79.091 E.00994
G1 X199.055 Y79.794 E.01128
G1 X198.82 Y80.452 E.011
G1 X198.491 Y81.067 E.01098
G1 X198.085 Y81.614 E.01072
G1 X197.619 Y82.068 E.01025
G1 X197.092 Y82.432 E.01008
G1 X196.502 Y82.707 E.01024
G1 X195.778 Y82.911 E.01184
G3 X192.388 Y83.179 I-3.123 J-17.922 E.0536
G1 X184.943 Y83.18 E.11719
G1 X184.943 Y65.6 E.27672
G1 X188.157 Y65.6 E.0506
G1 X188.157 Y72.915 E.11514
G1 X188.211 Y73.051 E.0023
G1 X188.357 Y73.114 E.0025
G2 X190.631 Y72.998 I.487 J-12.823 E.03589
G1 X191.068 Y72.868 E.00718
G1 X191.665 Y72.544 E.01068
G1 X192.189 Y72.085 E.01096
G2 X193.779 Y69.926 I-19.101 J-15.728 E.04224
G1 X196.681 Y65.6 E.082
G1 X200.537 Y65.6 E.06068
G1 X198.414 Y68.99 E.06296
G3 X196.632 Y71.52 I-18.991 J-11.48 E.04874
G1 X196.034 Y72.125 E.0134
G3 X194.548 Y73.185 I-6.952 J-8.174 E.02877
G1 X194.475 Y73.318 E.00239
G1 X194.515 Y73.426 E.00181
; WIPE_START
M204 S1000
G1 X194.639 Y73.536 E-.06283
G1 X195.196 Y73.634 E-.21483
G1 X195.713 Y73.758 E-.20234
G1 X196.193 Y73.91 E-.19106
G1 X196.41 Y73.998 E-.08894
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X196.244 Y74.396 Z2.1 F30000
G1 X187.725 Y75.134
G1 X187.725 Y80.987
G1 X188.143 Y80.987
G1 X188.143 Y81.338
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X187.828 Y81.252 E.00552
G1 X187.481 Y80.918 E.00816
G1 X187.331 Y80.535 E.00696
G1 X187.315 Y80.355 E.00306
G1 X187.315 Y75.766 E.07767
G1 X187.393 Y75.371 E.00682
G1 X187.596 Y75.055 E.00635
G1 X187.866 Y74.848 E.00576
G1 X188.358 Y74.725 E.00858
G1 X190.358 Y74.727 E.03385
G3 X193.63 Y74.814 I.607 J38.865 E.05542
; LINE_WIDTH: 0.486565
G1 X193.958 Y74.841 E.00605
; LINE_WIDTH: 0.52314
G1 X194.286 Y74.869 E.00653
; LINE_WIDTH: 0.5665
G1 X194.899 Y75.045 E.01372
; LINE_WIDTH: 0.57933
G3 X195.223 Y75.219 I-.083 J.542 E.00826
; LINE_WIDTH: 0.536217
G1 X195.365 Y75.332 E.00369
; LINE_WIDTH: 0.493103
G1 X195.508 Y75.445 E.00338
; LINE_WIDTH: 0.44999
G1 X196.108 Y76.039 E.0143
G1 X196.398 Y76.492 E.00911
G3 X196.617 Y79.152 I-3.454 J1.623 E.04615
G1 X196.4 Y79.7 E.00998
G1 X196.084 Y80.184 E.00977
G1 X195.68 Y80.595 E.00975
G1 X195.205 Y80.921 E.00976
G1 X194.672 Y81.157 E.00987
G1 X194.099 Y81.307 E.01002
G1 X193.343 Y81.37 E.01285
G3 X190.199 Y81.395 I-2.247 J-87.423 E.05321
G1 X188.357 Y81.397 E.03118
G1 X188.201 Y81.354 E.00273
M204 S10000
G1 X188.252 Y80.939 F30000
G1 F6000
M204 S1000
G1 X188.045 Y80.883 E.00362
G1 X187.841 Y80.687 E.0048
G1 X187.744 Y80.355 E.00585
G1 X187.744 Y75.766 E.07767
G3 X188.068 Y75.226 I.681 J.041 E.01109
G1 X188.36 Y75.153 E.0051
G1 X190.36 Y75.156 E.03385
G3 X193.601 Y75.241 I.592 J38.924 E.05488
G3 X194.984 Y75.615 I-.257 J3.7 E.02441
G1 X195.422 Y75.936 E.00918
G1 X195.796 Y76.333 E.00924
G1 X196.061 Y76.768 E.00861
G1 X196.229 Y77.247 E.0086
G3 X196.287 Y78.684 I-4.343 J.893 E.02444
G3 X194.974 Y80.559 I-2.605 J-.426 E.04008
G3 X194 Y80.89 I-1.508 J-2.843 E.0175
G1 X193.315 Y80.943 E.01162
G3 X190.199 Y80.966 I-2.222 J-88.444 E.05275
G1 X188.357 Y80.968 E.03118
G1 X188.31 Y80.955 E.00083
M204 S250
G1 X188.357 Y80.555 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X188.189 Y80.463 E.00301
G1 X188.157 Y80.355 E.00177
G1 X188.157 Y75.766 E.07223
G1 X188.211 Y75.63 E.0023
G1 X188.36 Y75.567 E.00254
G1 X191.685 Y75.571 E.05234
G3 X194.16 Y75.739 I.112 J16.666 E.03909
G1 X194.703 Y75.932 E.00907
G1 X195.121 Y76.219 E.00798
G1 X195.495 Y76.617 E.00859
G1 X195.7 Y76.975 E.00649
G1 X195.842 Y77.421 E.00738
G1 X195.919 Y78.098 E.01072
G1 X195.884 Y78.589 E.00775
G1 X195.746 Y79.095 E.00825
G3 X194.752 Y80.211 I-1.95 J-.736 E.02405
G3 X193.87 Y80.493 I-1.296 J-2.532 E.01464
G3 X190.198 Y80.553 I-2.726 J-54.374 E.05782
G1 X188.417 Y80.554 E.02804
; WIPE_START
M204 S1000
M73 P84 R11
G1 X188.189 Y80.463 E-.0932
G1 X188.157 Y80.355 E-.04268
G1 X188.157 Y78.713 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X187.725 Y78.713 Z2.1 F30000
G1 X187.725 Y80.987
G1 X194.877 Y81.656
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S1000
G1 X194.545 Y81.72 E.00868
; LINE_WIDTH: 0.62207
G1 X194.212 Y81.783 E.00802
; LINE_WIDTH: 0.5725
G1 X193.651 Y81.83 E.01227
; LINE_WIDTH: 0.55022
G1 X193.044 Y81.854 E.01267
; LINE_WIDTH: 0.54592
G1 X192.374 Y81.864 E.0139
; LINE_WIDTH: 0.54068
G1 X192.199 Y81.865 E.00357
; LINE_WIDTH: 0.53768
G1 X190.199 Y81.866 E.04078
; LINE_WIDTH: 0.53568
G1 X188.358 Y81.867 E.0374
; LINE_WIDTH: 0.53384
G1 X188.357 Y81.867 E.00003
; WIPE_START
G1 X188.358 Y81.867 E-.00057
G1 X190.199 Y81.866 E-.69973
G1 X190.357 Y81.866 E-.05969
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X194.471 Y80.797 Z2.1 F30000
G1 X194.937 Y80.606
G1 X195.355 Y80.34
G1 X195.713 Y80
G1 X196 Y79.593
G1 X196.201 Y79.135
G1 X196.317 Y78.639
G1 X196.354 Y78.113
G1 X196.326 Y77.641
G1 X196.239 Y77.196
G1 X196.089 Y76.779
G1 X195.875 Y76.398
G1 X195.606 Y76.064
G1 X195.289 Y75.782
G1 X194.928 Y75.557
G1 X194.532 Y75.389
G1 X190.862 Y74.274
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.50098
G1 F6000
M204 S1000
G1 X190.798 Y74.278 E.00121
; LINE_WIDTH: 0.49122
G1 X190.407 Y74.302 E.00726
; LINE_WIDTH: 0.44249
G1 X190.017 Y74.326 E.00651
; LINE_WIDTH: 0.39376
G1 X189.411 Y74.339 E.0089
; LINE_WIDTH: 0.3662
G1 X188.361 Y74.34 E.0143
; LINE_WIDTH: 0.37282
G1 X188.232 Y74.34 E.00179
G1 E-.8 F1800
M204 S10000
G1 X193.684 Y72.256 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.45052
G1 F6000
M204 S1000
G1 X193.39 Y72.623 E.00796
G1 E-.8 F1800
M204 S10000
G1 X192.839 Y73.808 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5442
G1 F6000
M204 S1000
G2 X192.842 Y73.917 I-.028 J.055 E.00525
G1 E-.8 F1800
M204 S10000
G1 X186.63 Y75.016 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S1000
G1 X186.957 Y74.507 E.00965
G3 X187.154 Y74.34 I.576 J.483 E.00414
G1 X186.959 Y74.177 E.00405
G1 X186.63 Y73.688 E.0094
G1 X186.63 Y74.956 E.02022
G1 E-.8 F1800
M204 S10000
G1 X186.743 Y81.358 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57486
G1 F6000
M204 S1000
G2 X186.748 Y81.47 I-.03 J.057 E.00595
; WIPE_START
G1 X186.674 Y81.478 E-.20014
G1 X186.64 Y81.418 E-.18662
G1 X186.674 Y81.358 E-.18663
G1 X186.743 Y81.358 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X185.376 Y78.182 Z2.1 F30000
G1 X180.615 Y67.13
G1 X180.143 Y66.032
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.1 F30000
G1 X181.348 Y56.444
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.1 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.1 F30000
G1 X162.522 Y69.807
G1 X161.718 Y70.099
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.51468
G1 F6000
M204 S1000
G1 X161.794 Y70.268 E.00361
G1 X161.929 Y70.41 E.00381
; LINE_WIDTH: 0.482335
G1 X162.063 Y70.551 E.00356
; LINE_WIDTH: 0.44999
G1 X162.581 Y70.872 E.01031
G1 X163.079 Y70.959 E.00855
; LINE_WIDTH: 0.497195
G1 X163.502 Y70.982 E.00797
; LINE_WIDTH: 0.5444
G1 X163.926 Y71.006 E.00876
G1 X163.58 Y71.194 E.00813
; LINE_WIDTH: 0.497195
G1 X163.235 Y71.382 E.00739
; LINE_WIDTH: 0.44999
G1 X162.912 Y71.771 E.00855
G1 X162.727 Y72.342 E.01017
; LINE_WIDTH: 0.4722
G1 X162.797 Y73.007 E.0119
G1 X163.491 Y74.882 E.03561
; LINE_WIDTH: 0.44985
G1 X164.186 Y76.758 E.03384
; LINE_WIDTH: 0.4275
G1 X164.88 Y78.633 E.03207
; LINE_WIDTH: 0.40515
G1 X165.28 Y79.714 E.01747
; LINE_WIDTH: 0.4044
G1 X165.397 Y79.972 E.00427
; LINE_WIDTH: 0.44999
G1 X165.708 Y80.363 E.00845
G1 X166.331 Y80.66 E.01167
G2 X167.002 Y80.645 I.304 J-1.438 E.01147
G1 X167.588 Y80.34 E.01118
; LINE_WIDTH: 0.45984
G1 X167.888 Y79.998 E.00788
G1 X168.011 Y79.733 E.00506
; LINE_WIDTH: 0.47269
G1 X168.719 Y77.862 E.03564
; LINE_WIDTH: 0.49801
G1 X169.427 Y75.992 E.03764
; LINE_WIDTH: 0.52333
G1 X170.135 Y74.121 E.03964
; LINE_WIDTH: 0.53814
G1 X170.55 Y73.027 E.02387
; LINE_WIDTH: 0.55128
G1 X170.618 Y72.813 E.00471
G1 X170.611 Y72.668 E.00305
; LINE_WIDTH: 0.517517
G1 X170.603 Y72.522 E.00285
; LINE_WIDTH: 0.483753
G1 X170.595 Y72.377 E.00266
; LINE_WIDTH: 0.44999
G1 X170.432 Y71.818 E.00985
G1 X170.115 Y71.409 E.00876
; LINE_WIDTH: 0.485785
G1 X169.623 Y71.202 E.0098
; LINE_WIDTH: 0.52158
G1 X169.13 Y70.995 E.01056
G1 X169.71 Y70.977 E.01145
; LINE_WIDTH: 0.485785
G1 X170.289 Y70.959 E.01063
; LINE_WIDTH: 0.44999
G1 X170.798 Y70.868 E.00876
G1 X171.301 Y70.555 E.01002
; LINE_WIDTH: 0.486633
G1 X171.438 Y70.382 E.00405
; LINE_WIDTH: 0.523277
G1 X171.575 Y70.209 E.00437
; LINE_WIDTH: 0.55992
G1 X171.712 Y70.036 E.00469
; LINE_WIDTH: 0.5738
G1 X172.436 Y68.172 E.04363
; LINE_WIDTH: 0.58167
G2 X172.915 Y66.936 I-177.652 J-69.604 E.02933
G1 X173.108 Y66.936 E.00426
G1 X173.522 Y66.936 E.00916
G2 X172.631 Y69.179 I322.528 J129.367 E.05341
; LINE_WIDTH: 0.56778
G1 X172.213 Y70.233 E.02445
; LINE_WIDTH: 0.55992
G2 X172.124 Y70.505 I1.951 J.791 E.00611
; LINE_WIDTH: 0.523217
G1 X172.044 Y70.755 E.00519
; LINE_WIDTH: 0.486603
G1 X171.963 Y71.004 E.00482
; LINE_WIDTH: 0.44999
G1 X171.368 Y72.493 E.02713
; LINE_WIDTH: 0.494065
G1 X171.2 Y72.853 E.00742
; LINE_WIDTH: 0.53814
G1 X171.032 Y73.213 E.00811
G1 X170.3 Y75.075 E.04081
; LINE_WIDTH: 0.51281
G1 X169.568 Y76.936 E.03881
; LINE_WIDTH: 0.48749
G1 X168.837 Y78.797 E.03681
; LINE_WIDTH: 0.46217
G1 X168.409 Y79.886 E.02036
; LINE_WIDTH: 0.45984
G2 X168.083 Y80.695 I14.436 J6.276 E.01511
; LINE_WIDTH: 0.44999
G1 X167.597 Y81.909 E.02212
G1 X165.768 Y81.909 E.03095
G2 X165.11 Y80.258 I-26.011 J9.418 E.03009
; LINE_WIDTH: 0.42113
G1 X164.934 Y79.845 E.00709
; LINE_WIDTH: 0.41461
G1 X164.218 Y77.977 E.03106
; LINE_WIDTH: 0.43696
G1 X163.503 Y76.11 E.03282
; LINE_WIDTH: 0.45931
G1 X162.787 Y74.242 E.03459
; LINE_WIDTH: 0.4722
G2 X162.076 Y72.428 I-46.648 J17.252 E.03469
; LINE_WIDTH: 0.44999
G1 X161.493 Y70.933 E.02717
; LINE_WIDTH: 0.47587
G1 X161.358 Y70.551 E.00727
; LINE_WIDTH: 0.50175
G1 X161.223 Y70.169 E.00768
; LINE_WIDTH: 0.52463
G1 X160.508 Y68.301 E.03975
; LINE_WIDTH: 0.53733
G2 X159.975 Y66.914 I-121.17 J45.803 E.03029
G1 X160.533 Y66.914 E.01137
G2 X161.288 Y68.96 I179.136 J-64.994 E.04443
; LINE_WIDTH: 0.51444
G1 X161.673 Y70 E.0216
; LINE_WIDTH: 0.51468
G1 X161.693 Y70.044 E.00095
M204 S10000
G1 X162.196 Y69.998 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X162.359 Y70.242 E.00497
G1 X162.726 Y70.469 E.00731
G1 X163.079 Y70.53 E.00606
G1 X170.289 Y70.53 E.12203
G1 X170.65 Y70.466 E.00621
G1 X171.006 Y70.244 E.0071
G1 X171.255 Y69.876 E.00753
G1 X172.576 Y66.442 E.06228
G1 X173.108 Y66.442 E.009
G1 X174.252 Y66.442 E.01937
G1 X167.887 Y82.338 E.28981
G1 X165.475 Y82.338 E.04082
G1 X159.284 Y66.442 E.28873
G1 X160.864 Y66.442 E.02673
G1 X161.547 Y68.321 E.03385
G2 X162.108 Y69.867 I68.526 J-24.037 E.02783
G1 X162.163 Y69.948 E.00165
M204 S10000
G1 X162.549 Y69.77 F30000
G1 F6000
M204 S1000
G1 X162.655 Y69.932 E.00328
G1 X162.871 Y70.066 E.0043
G1 X163.079 Y70.102 E.00356
G1 X170.289 Y70.102 E.12203
G1 X170.408 Y70.09 E.00203
G1 X170.711 Y69.933 E.00576
G1 X170.858 Y69.717 E.00443
G1 X172.281 Y66.013 E.06716
G1 X173.108 Y66.013 E.01399
G1 X174.885 Y66.013 E.03009
G1 X168.177 Y82.766 E.30544
G1 X165.182 Y82.766 E.05069
G1 X158.657 Y66.013 E.3043
G1 X161.164 Y66.013 E.04242
G1 X162.503 Y69.698 E.06636
G1 X162.517 Y69.719 E.00042
M204 S250
G1 X162.891 Y69.557 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G2 X162.941 Y69.633 I.574 J-.321 E.00143
G1 X163.079 Y69.688 E.00234
G1 X170.289 Y69.688 E.11349
G1 X170.358 Y69.676 E.0011
G1 X170.474 Y69.563 E.00255
G1 X171.997 Y65.6 E.06684
G1 X173.108 Y65.6 E.01748
G1 X175.496 Y65.6 E.0376
G1 X168.457 Y83.18 E.29808
G1 X164.9 Y83.18 E.056
G1 X158.052 Y65.6 E.29697
G1 X161.453 Y65.6 E.05354
G1 X162.82 Y69.359 E.06296
G2 X162.865 Y69.503 I.646 J-.123 E.00239
; WIPE_START
M204 S1000
G1 X162.941 Y69.633 E-.05716
G1 X163.079 Y69.688 E-.05637
G1 X164.78 Y69.688 E-.64646
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.78 Y70.121 Z2.1 F30000
G1 X163.286 Y71.868
G1 X165.921 Y79.108
G1 X166.184 Y79.832
G1 X166.157 Y80.115
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X165.978 Y80.03 E.00334
G1 X165.744 Y79.761 E.00603
G1 X165.656 Y79.578 E.00345
G1 X163.21 Y72.856 E.12106
G1 X163.153 Y72.388 E.00798
G1 X163.284 Y71.983 E.0072
G1 X163.513 Y71.708 E.00606
G1 X164.008 Y71.475 E.00927
G1 X164.188 Y71.459 E.00306
G1 X169.13 Y71.459 E.08365
G1 X169.828 Y71.727 E.01266
G1 X170.053 Y72.017 E.00621
G1 X170.168 Y72.413 E.00698
G1 X170.107 Y72.863 E.00768
G1 X167.611 Y79.584 E.12135
G1 X167.52 Y79.77 E.0035
G1 X167.31 Y80.014 E.00545
G1 X166.815 Y80.247 E.00927
G1 X166.419 Y80.24 E.00669
G1 X166.211 Y80.141 E.00391
M204 S10000
G1 X166.184 Y79.607 F30000
G1 F6000
M204 S1000
G1 X166.059 Y79.431 E.00366
G1 X163.612 Y72.71 E.12106
G1 X163.579 Y72.434 E.0047
G1 X163.71 Y72.118 E.0058
G1 X163.791 Y72.034 E.00197
G1 X164.082 Y71.897 E.00546
G1 X164.188 Y71.887 E.0018
G1 X169.13 Y71.887 E.08365
G1 X169.541 Y72.045 E.00745
G1 X169.673 Y72.216 E.00365
G1 X169.741 Y72.449 E.00411
G1 X169.705 Y72.714 E.00452
G1 X167.209 Y79.435 E.12135
G1 X167.032 Y79.688 E.00523
G1 X166.74 Y79.825 E.00546
G1 X166.508 Y79.821 E.00394
G1 X166.248 Y79.697 E.00487
G1 X166.219 Y79.656 E.00085
M204 S250
G1 X166.509 Y79.376 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X166.447 Y79.29 E.00167
G1 X164.001 Y72.568 E.11259
G1 X164.015 Y72.401 E.00264
G1 X164.154 Y72.304 E.00267
G1 X164.188 Y72.301 E.00054
G1 X169.13 Y72.301 E.07779
G1 X169.29 Y72.381 E.00282
G1 X169.325 Y72.541 E.00258
G1 X169.317 Y72.57 E.00047
G1 X166.82 Y79.296 E.11293
G1 X166.684 Y79.414 E.00283
G1 X166.568 Y79.389 E.00188
; WIPE_START
M204 S1000
G1 X166.447 Y79.29 E-.05928
G1 X165.817 Y77.557 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.41 Y77.705 Z2.1 F30000
G1 X166.184 Y79.832
G1 X167.081 Y79.834
G1 X170.039 Y71.868
G1 X169.13 Y70.995
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S1000
G1 X164.188 Y70.995 E.09762
; LINE_WIDTH: 0.5444
G1 X163.926 Y71.006 E.00542
G1 E-.8 F1800
M204 S10000
G1 X162.384 Y72.056 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S1000
G1 X162.548 Y71.562 E.00843
G1 X162.7 Y71.339 E.00437
G1 X162.395 Y71.244 E.00517
G1 X161.949 Y70.947 E.00868
G1 X162.362 Y72 E.01832
G1 E-.8 F1800
M204 S10000
G1 X169.972 Y71.422 Z2.1 F30000
G1 X170.682 Y71.369 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S1000
G1 X170.845 Y71.654 E.00603
G1 X171.004 Y72.201 E.01042
G1 X171.506 Y70.948 E.02472
G1 X170.995 Y71.266 E.01102
G1 X170.739 Y71.35 E.00494
; WIPE_START
G1 X170.995 Y71.266 E-.10257
G1 X171.506 Y70.948 E-.22853
G1 X171.086 Y71.996 E-.42891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.614 Y78.792 Z2.1 F30000
G1 X167.081 Y79.834 Z2.1
G1 X165.821 Y80.878
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S1000
G1 X166.058 Y81.486 E.01073
G2 X167.306 Y81.481 I.52 J-24.617 E.02055
G1 X167.563 Y80.83 E.01152
G1 X167.108 Y81.06 E.00838
G1 X166.614 Y81.102 E.00816
G1 X166.197 Y81.058 E.00691
G1 X165.875 Y80.904 E.00586
; WIPE_START
G1 X166.197 Y81.058 E-.13544
G1 X166.614 Y81.102 E-.15954
G1 X167.108 Y81.06 E-.18848
G1 X167.563 Y80.83 E-.19363
G1 X167.483 Y81.033 E-.08291
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.257 Y77.77 Z2.1 F30000
G1 X149.036 Y66.789
G1 X148.055 Y66.032
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.1 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.1 F30000
G1 X124.331 Y65.739
G1 X131.847 Y73.351
G1 X126.361 Y82.729
G1 X126.329 Y82.737
G1 X126.137 Y81.957
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.35598
G1 F6000
M204 S1000
G1 X125.773 Y82.061 E.005
; LINE_WIDTH: 0.33261
G1 X125.107 Y82.187 E.00833
; LINE_WIDTH: 0.31593
G1 X124.429 Y82.26 E.00793
; LINE_WIDTH: 0.30859
G1 X123.737 Y82.286 E.00785
; LINE_WIDTH: 0.31477
G1 X123.037 Y82.257 E.00812
; LINE_WIDTH: 0.33132
G1 X122.338 Y82.178 E.00861
; LINE_WIDTH: 0.3643
G1 X121.551 Y82.015 E.01089
; LINE_WIDTH: 0.38649
G1 X121.006 Y81.843 E.00824
; LINE_WIDTH: 0.40817
G1 X120.529 Y81.647 E.00788
; LINE_WIDTH: 0.44963
G1 X119.954 Y81.366 E.01082
; LINE_WIDTH: 0.47196
G1 X119.521 Y81.082 E.00922
; LINE_WIDTH: 0.48939
G1 X119.075 Y80.725 E.01056
; LINE_WIDTH: 0.50523
G1 X118.63 Y80.293 E.01185
; LINE_WIDTH: 0.52781
G1 X118.147 Y79.713 E.01509
; LINE_WIDTH: 0.54902
G1 X117.827 Y79.252 E.0117
; LINE_WIDTH: 0.57222
G1 X117.566 Y78.804 E.01127
; LINE_WIDTH: 0.59243
G1 X117.3 Y78.248 E.01391
; LINE_WIDTH: 0.60335
G1 X117.085 Y77.654 E.01452
; LINE_WIDTH: 0.61368
G1 X116.911 Y77.023 E.01531
; LINE_WIDTH: 0.62061
G1 X116.812 Y76.525 E.01199
; LINE_WIDTH: 0.62174
G1 X116.735 Y76.011 E.01233
; LINE_WIDTH: 0.625
G1 X116.68 Y75.465 E.01309
; LINE_WIDTH: 0.62812
G1 X116.647 Y74.885 E.01391
; LINE_WIDTH: 0.62886
G1 X116.636 Y74.272 E.01471
; LINE_WIDTH: 0.632
G3 X116.756 Y72.606 I10.837 J-.059 E.04031
; LINE_WIDTH: 0.62599
G1 X116.909 Y71.782 E.02002
; LINE_WIDTH: 0.62226
G1 X117.079 Y71.153 E.01546
; LINE_WIDTH: 0.61732
G1 X117.27 Y70.609 E.01357
; LINE_WIDTH: 0.61481
G1 X117.566 Y69.969 E.01651
; LINE_WIDTH: 0.60042
G1 X117.915 Y69.382 E.01562
; LINE_WIDTH: 0.5807
G1 X118.32 Y68.84 E.01495
; LINE_WIDTH: 0.55591
G1 X118.8 Y68.328 E.0148
; LINE_WIDTH: 0.52689
G1 X119.352 Y67.86 E.01446
; LINE_WIDTH: 0.49317
G1 X119.943 Y67.463 E.01326
; LINE_WIDTH: 0.45518
G1 X120.565 Y67.141 E.01199
; LINE_WIDTH: 0.41597
G1 X121.207 Y66.89 E.01075
; LINE_WIDTH: 0.37924
G1 X121.864 Y66.706 E.00963
; LINE_WIDTH: 0.34866
G1 X122.555 Y66.577 E.00909
; LINE_WIDTH: 0.32627
G1 X123.375 Y66.505 E.00991
; LINE_WIDTH: 0.31221
G1 X123.881 Y66.508 E.00582
; LINE_WIDTH: 0.31835
G1 X124.692 Y66.535 E.00951
; LINE_WIDTH: 0.34039
G1 X125.467 Y66.644 E.00986
; LINE_WIDTH: 0.37063
G1 X126.196 Y66.823 E.01035
; LINE_WIDTH: 0.40536
G1 X126.867 Y67.063 E.01081
; LINE_WIDTH: 0.44117
G1 X127.483 Y67.362 E.01136
; LINE_WIDTH: 0.47539
G1 X128.052 Y67.719 E.01203
; LINE_WIDTH: 0.50634
G1 X128.578 Y68.135 E.01284
; LINE_WIDTH: 0.53435
G1 X129.065 Y68.611 E.01381
; LINE_WIDTH: 0.55949
G1 X129.5 Y69.139 E.01453
; LINE_WIDTH: 0.58147
G1 X129.887 Y69.731 E.01564
; LINE_WIDTH: 0.60064
G1 X130.235 Y70.433 E.01792
; LINE_WIDTH: 0.61475
G1 X130.509 Y71.177 E.0186
; LINE_WIDTH: 0.62416
G1 X130.712 Y71.96 E.01925
; LINE_WIDTH: 0.62955
G1 X130.85 Y72.778 E.01991
; LINE_WIDTH: 0.63713
G1 X130.943 Y73.888 E.02709
G1 X130.944 Y74.857 E.02358
; LINE_WIDTH: 0.63462
G1 X130.915 Y75.397 E.01308
; LINE_WIDTH: 0.62855
G1 X130.817 Y76.257 E.02076
; LINE_WIDTH: 0.61965
G1 X130.657 Y77.076 E.01973
; LINE_WIDTH: 0.60726
G1 X130.427 Y77.857 E.01883
; LINE_WIDTH: 0.58952
G1 X130.122 Y78.594 E.01789
; LINE_WIDTH: 0.56612
G1 X129.743 Y79.278 E.01683
; LINE_WIDTH: 0.53773
G1 X129.291 Y79.901 E.0157
; LINE_WIDTH: 0.50608
G1 X128.789 Y80.443 E.01413
; LINE_WIDTH: 0.47526
G1 X128.251 Y80.906 E.01273
; LINE_WIDTH: 0.44536
G1 X127.673 Y81.3 E.01172
; LINE_WIDTH: 0.41449
G1 X127.061 Y81.623 E.01073
; LINE_WIDTH: 0.38401
G1 X126.425 Y81.875 E.00979
; LINE_WIDTH: 0.35598
G1 X126.194 Y81.941 E.00317
; WIPE_START
G1 X125.773 Y82.061 E-.16656
G1 X125.107 Y82.187 E-.25758
G1 X124.429 Y82.26 E-.25898
G1 X124.227 Y82.267 E-.07689
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.274 Y83.042 Z2.1 F30000
G1 X127.491 Y79.901
G1 X127.895 Y79.493
G1 X128.259 Y79.029
G1 X128.573 Y78.511
G1 X128.835 Y77.945
G1 X129.046 Y77.334
G1 X129.208 Y76.679
G1 X129.322 Y75.981
G1 X129.389 Y75.238
G1 X129.411 Y74.451
G1 X129.389 Y73.654
G1 X129.319 Y72.902
G1 X128.963 Y69.32
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S1000
G1 X129.301 Y69.834 E.01337
; LINE_WIDTH: 0.59672
G1 X129.633 Y70.493 E.01676
; LINE_WIDTH: 0.61527
G1 X129.894 Y71.19 E.01748
; LINE_WIDTH: 0.62651
G1 X130.079 Y71.881 E.01708
; LINE_WIDTH: 0.63308
G1 X130.218 Y72.639 E.01862
; LINE_WIDTH: 0.63563
G3 X130.34 Y74.374 I-12.367 J1.74 E.04222
; LINE_WIDTH: 0.63443
G1 X130.317 Y75.245 E.02109
; LINE_WIDTH: 0.62953
G1 X130.244 Y76.042 E.01923
; LINE_WIDTH: 0.62185
G1 X130.117 Y76.802 E.01827
; LINE_WIDTH: 0.60881
G1 X129.936 Y77.524 E.01728
; LINE_WIDTH: 0.59354
G1 X129.696 Y78.209 E.01639
; LINE_WIDTH: 0.57402
G1 X129.405 Y78.829 E.01496
; LINE_WIDTH: 0.55095
G1 X129.078 Y79.368 E.01318
; LINE_WIDTH: 0.52553
G1 X128.694 Y79.87 E.01258
; LINE_WIDTH: 0.49762
G1 X128.257 Y80.332 E.01196
; LINE_WIDTH: 0.46894
G1 X127.779 Y80.74 E.01112
; LINE_WIDTH: 0.43985
G1 X127.257 Y81.097 E.01044
; LINE_WIDTH: 0.4098
G1 X126.684 Y81.402 E.00995
; LINE_WIDTH: 0.37993
G1 X126.052 Y81.652 E.00962
; LINE_WIDTH: 0.35225
G1 X125.355 Y81.84 E.00943
; LINE_WIDTH: 0.32919
G1 X124.593 Y81.959 E.00938
; LINE_WIDTH: 0.31323
G1 X123.869 Y81.998 E.00836
; LINE_WIDTH: 0.3138
G1 X123.301 Y81.982 E.00655
; LINE_WIDTH: 0.32712
G1 X122.543 Y81.899 E.0092
; LINE_WIDTH: 0.346
G1 X121.906 Y81.761 E.00836
; LINE_WIDTH: 0.37605
G1 X121.288 Y81.562 E.0091
; LINE_WIDTH: 0.40817
G1 X120.693 Y81.297 E.00994
; LINE_WIDTH: 0.44963
G1 X120.183 Y81.004 E.00994
; LINE_WIDTH: 0.47509
G1 X119.6 Y80.568 E.01304
; LINE_WIDTH: 0.49664
G1 X119.117 Y80.107 E.01255
; LINE_WIDTH: 0.52136
G1 X118.671 Y79.576 E.01367
; LINE_WIDTH: 0.54877
G1 X118.325 Y79.054 E.01305
; LINE_WIDTH: 0.57222
G1 X118.062 Y78.565 E.01209
; LINE_WIDTH: 0.59243
G1 X117.835 Y78.048 E.01274
; LINE_WIDTH: 0.60335
G1 X117.643 Y77.493 E.01349
; LINE_WIDTH: 0.61357
G1 X117.488 Y76.888 E.01461
; LINE_WIDTH: 0.61871
G1 X117.352 Y76.111 E.01861
; LINE_WIDTH: 0.625
G1 X117.282 Y75.419 E.01657
; LINE_WIDTH: 0.62812
G3 X117.242 Y74.355 I18.614 J-1.226 E.02551
; LINE_WIDTH: 0.6317
G1 X117.256 Y73.825 E.0128
; LINE_WIDTH: 0.63259
G3 X117.437 Y72.192 I10.97 J.394 E.03967
; LINE_WIDTH: 0.62992
G1 X117.605 Y71.482 E.01754
; LINE_WIDTH: 0.62438
G1 X117.689 Y71.197 E.00708
; LINE_WIDTH: 0.61382
G1 X117.895 Y70.634 E.01403
; LINE_WIDTH: 0.60427
G1 X118.207 Y69.982 E.01663
; LINE_WIDTH: 0.58513
G1 X118.586 Y69.376 E.01591
; LINE_WIDTH: 0.56044
G1 X119.031 Y68.821 E.01514
; LINE_WIDTH: 0.53221
G1 X119.516 Y68.339 E.01381
; LINE_WIDTH: 0.50137
G1 X120.03 Y67.927 E.01247
; LINE_WIDTH: 0.46644
G1 X120.582 Y67.577 E.0115
; LINE_WIDTH: 0.42844
G1 X121.168 Y67.29 E.01049
; LINE_WIDTH: 0.39039
G1 X121.782 Y67.068 E.00952
; LINE_WIDTH: 0.35588
G1 X122.419 Y66.912 E.00866
; LINE_WIDTH: 0.32832
G1 X123.074 Y66.817 E.00802
; LINE_WIDTH: 0.31053
G1 X123.743 Y66.785 E.00765
; LINE_WIDTH: 0.30573
G1 X124.404 Y66.807 E.00743
; LINE_WIDTH: 0.32208
G1 X125.049 Y66.885 E.00771
; LINE_WIDTH: 0.34481
G1 X125.68 Y67.025 E.00825
; LINE_WIDTH: 0.37507
G1 X126.292 Y67.229 E.00902
; LINE_WIDTH: 0.40998
G1 X126.882 Y67.498 E.00994
; LINE_WIDTH: 0.44638
G1 X127.442 Y67.834 E.01096
; LINE_WIDTH: 0.48135
G1 X127.968 Y68.234 E.012
; LINE_WIDTH: 0.51276
G1 X128.454 Y68.695 E.013
; LINE_WIDTH: 0.54272
G1 X128.903 Y69.228 E.01434
; LINE_WIDTH: 0.57196
G1 X128.93 Y69.27 E.00109
M204 S10000
G1 X128.577 Y69.598 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X128.877 Y70.092 E.00978
G3 X129.411 Y71.359 I-5.392 J3.018 E.02332
G3 X129.799 Y75.23 I-11.617 J3.118 E.06614
G3 X129.233 Y78.049 I-9.592 J-.461 E.04884
G3 X125.924 Y81.294 I-5.2 J-1.992 E.08091
G3 X122.594 Y81.536 I-2.156 J-6.651 E.05706
G3 X118.733 Y78.806 I.966 J-5.461 E.08268
G3 X117.796 Y75.372 I7.256 J-3.825 E.06073
G3 X118.171 Y71.366 I11.438 J-.949 E.06845
G3 X118.655 Y70.196 I6.495 J2.001 E.02147
G3 X123.76 Y67.138 I5.078 J2.688 E.10586
G3 X127.685 Y68.577 I.123 J5.738 E.07242
G3 X128.52 Y69.527 I-4.2 J4.533 E.02146
G1 X128.539 Y69.551 E.00052
M204 S10000
G1 X128.216 Y69.825 F30000
G1 F6000
M204 S1000
G1 X128.519 Y70.31 E.00968
G3 X128.789 Y70.886 I-4.622 J2.519 E.01077
G3 X129.362 Y73.574 I-8.57 J3.23 E.0467
G3 X129.035 Y77.302 I-11.512 J.867 E.06361
G3 X126.806 Y80.392 I-5.185 J-1.39 E.06593
G3 X123.835 Y81.213 I-2.955 J-4.907 E.05282
G3 X120.59 Y80.248 I-.119 J-5.534 E.05822
G3 X118.782 Y77.936 I3.199 J-4.365 E.0503
G3 X118.222 Y75.333 I8.092 J-3.102 E.04525
G3 X118.575 Y71.508 I11.265 J-.89 E.06533
G1 X118.775 Y70.948 E.01007
G3 X123.78 Y67.566 I4.963 J1.95 E.10868
G3 X128.184 Y69.774 I.118 J5.262 E.08679
M204 S250
G1 X127.861 Y70.045 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G3 X128.616 Y71.636 I-4.123 J2.931 E.02785
G3 X128.957 Y75.206 I-10.895 J2.842 E.0567
G3 X128.437 Y77.774 I-8.698 J-.426 E.04139
G3 X125.924 Y80.398 I-4.436 J-1.732 E.05868
G3 X123.25 Y80.776 I-2.133 J-5.453 E.04289
G3 X119.405 Y78.29 I.348 J-4.755 E.07518
G3 X118.634 Y75.295 I6.771 J-3.338 E.04901
G3 X118.965 Y71.645 I10.864 J-.854 E.05796
G3 X121.73 Y68.396 I4.95 J1.411 E.06924
G3 X125.86 Y68.384 I2.08 J4.945 E.06673
G3 X127.826 Y69.996 I-2.122 J4.592 E.04046
; WIPE_START
M204 S1000
G1 X128.164 Y70.526 E-.23878
G1 X128.415 Y71.061 E-.22423
G1 X128.616 Y71.636 E-.23154
G1 X128.658 Y71.803 E-.06546
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.079 Y71.698 Z2.1 F30000
G1 X129.202 Y72.193
G1 X129.319 Y72.902
G1 X129.389 Y73.654
G1 X129.411 Y74.451
G1 X129.389 Y75.238
G1 X129.322 Y75.981
G1 X129.208 Y76.679
G1 X129.046 Y77.334
G1 X128.835 Y77.945
G1 X128.573 Y78.511
G1 X128.259 Y79.029
G1 X127.895 Y79.493
G1 X127.491 Y79.901
G1 X127.055 Y80.256
G1 X126.668 Y80.503
G1 X126.377 Y82.725
G1 X126.254 Y82.315
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X125.853 Y82.422 E.00702
G3 X121.47 Y82.394 I-2.125 J-10.184 E.07475
G1 X120.684 Y82.162 E.01387
G3 X119.728 Y81.73 I17.586 J-40.2 E.01775
G3 X117.42 Y79.503 I3.703 J-6.146 E.05475
G3 X116.407 Y77.109 I6.058 J-3.975 E.04423
G3 X116.33 Y71.98 I13.043 J-2.762 E.08737
G3 X117.498 Y69.114 I7.729 J1.478 E.05273
G3 X121.697 Y66.351 I5.59 J3.923 E.08713
G3 X123.357 Y66.145 I1.993 J9.29 E.02833
G1 X124.711 Y66.172 E.02292
G3 X127.669 Y66.979 I-.594 J7.997 E.05222
G3 X130.938 Y70.827 I-3.239 J6.065 E.0875
G3 X131.465 Y73.879 I-10.643 J3.408 E.05259
G3 X131.143 Y77.22 I-12.165 J.515 E.05698
G3 X130.551 Y78.823 I-7.662 J-1.919 E.02899
G1 X130.132 Y79.545 E.01413
G1 X129.636 Y80.2 E.0139
G3 X126.545 Y82.237 I-5.223 J-4.561 E.06343
G1 X126.312 Y82.3 E.00408
M204 S10000
G1 X126.364 Y82.729 F30000
G1 F6000
M204 S1000
G1 X125.946 Y82.841 E.00733
G3 X121.37 Y82.811 I-2.219 J-10.619 E.07802
G1 X120.535 Y82.565 E.01473
G1 X119.564 Y82.133 E.01799
G3 X115.988 Y77.195 I3.886 J-6.58 E.10615
G3 X115.909 Y71.896 I13.475 J-2.849 E.09027
G3 X117.144 Y68.87 I8.148 J1.561 E.05568
G3 X120.816 Y66.145 I5.842 J4.035 E.07879
G3 X123.344 Y65.716 I3.006 J10.055 E.04351
G1 X124.742 Y65.744 E.02367
G3 X127.866 Y66.598 I-.627 J8.434 E.05517
G3 X131.343 Y70.685 I-3.442 J6.451 E.09299
G3 X131.893 Y73.872 I-10.871 J3.517 E.05491
G3 X131.583 Y77.243 I-13.331 J.474 E.05745
G3 X130.203 Y80.2 I-7.816 J-1.848 E.05563
G3 X126.68 Y82.648 I-5.734 J-4.494 E.0737
G1 X126.422 Y82.714 E.0045
M204 S250
G1 X126.476 Y83.147 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G3 X121.274 Y83.214 I-2.743 J-11.011 E.08261
G1 X120.392 Y82.954 E.01447
G1 X119.37 Y82.499 E.01761
G3 X115.478 Y76.772 I4.112 J-6.981 E.11262
G3 X115.503 Y71.815 I14.135 J-2.407 E.07842
G3 X116.803 Y68.635 I8.552 J1.641 E.05442
G3 X120.687 Y65.751 I6.182 J4.269 E.07752
G3 X123.331 Y65.302 I3.144 J10.506 E.04232
G1 X124.772 Y65.331 E.02268
G3 X128.057 Y66.231 I-.66 J8.855 E.05396
G3 X131.734 Y70.549 I-3.639 J6.824 E.09141
G3 X132.307 Y73.864 I-11.241 J3.648 E.05314
G3 X131.985 Y77.341 I-13.534 J.502 E.05511
G3 X131.002 Y79.765 I-9.292 J-2.357 E.04131
G3 X126.533 Y83.131 I-6.56 J-4.061 E.09011
; WIPE_START
M204 S1000
G1 X125.625 Y83.335 E-.35398
G1 X124.724 Y83.448 E-.34495
G1 X124.563 Y83.455 E-.06108
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.537 Y83.026 Z2.1 F30000
G1 X116.013 Y77.225
G1 X115.722 Y73.696
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z1.7
G1 E.8 F1800
G1 F3600
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.1 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.1 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y92.55 Z2.1 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y92.39 E.10565
; WIPE_START
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y92.55 Z2.1 F30000
G1 X145.651 Y71.201
G1 X145.937 Y70.735
G1 X146 Y70.04
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X145.486 Y70.203 E.00911
G1 X144.976 Y70.707 E.01215
; LINE_WIDTH: 0.44625
G1 X143.929 Y72.411 E.03356
; LINE_WIDTH: 0.45012
G1 X142.882 Y74.115 E.03386
; LINE_WIDTH: 0.45399
G1 X141.835 Y75.82 E.03417
; LINE_WIDTH: 0.45786
G1 X140.789 Y77.524 E.03447
; LINE_WIDTH: 0.45901
G1 X140.478 Y78.03 E.01026
; LINE_WIDTH: 0.47181
G2 X140.036 Y78.76 I8.569 J5.689 E.01519
; LINE_WIDTH: 0.44999
G1 X138.106 Y81.909 E.06251
G1 X136.879 Y81.909 E.02076
G1 X136.879 Y77.909 E.0677
G2 X136.876 Y77 I-116.699 J-.032 E.01538
; LINE_WIDTH: 0.44341
G1 X136.876 Y66.867 E.16888
G1 X137.298 Y66.867 E.00703
G1 X137.298 Y77 E.16888
; LINE_WIDTH: 0.45612
G1 X137.314 Y77.255 E.00438
G1 X137.47 Y77.697 E.00804
; LINE_WIDTH: 0.44999
G1 X137.89 Y78.181 E.01085
G1 X138.45 Y78.439 E.01044
G1 X138.974 Y78.49 E.00892
G1 X139.586 Y78.298 E.01085
; LINE_WIDTH: 0.47181
G1 X139.961 Y78.005 E.00847
G1 X140.105 Y77.8 E.00446
; LINE_WIDTH: 0.45901
G1 X141.155 Y76.098 E.03456
; LINE_WIDTH: 0.45514
G1 X142.205 Y74.396 E.03426
; LINE_WIDTH: 0.45127
G1 X143.255 Y72.694 E.03395
; LINE_WIDTH: 0.4474
G1 X144.305 Y70.991 E.03365
; LINE_WIDTH: 0.44353
G1 X144.617 Y70.486 E.00989
; LINE_WIDTH: 0.44239
G1 X144.62 Y70.481 E.00011
; LINE_WIDTH: 0.44999
G2 X146.857 Y66.87 I-868.396 J-540.416 E.07189
G1 X148.198 Y66.87 E.02269
G1 X148.198 Y67.731 E.01457
G1 X148.198 Y69.731 E.03385
G2 X148.201 Y71.498 I227.257 J.46 E.0299
; LINE_WIDTH: 0.44341
G1 X148.201 Y81.912 E.17357
G1 X147.779 Y81.912 E.00703
G1 X147.779 Y71.498 E.17357
; LINE_WIDTH: 0.44999
G1 X147.607 Y70.8 E.01216
G1 X147.186 Y70.315 E.01087
G1 X146.625 Y70.058 E.01045
G1 X146.098 Y70.009 E.00895
G1 X146.057 Y70.022 E.00074
M204 S10000
G1 X146.07 Y70.456 F30000
G1 F6000
M204 S1000
G1 X145.702 Y70.573 E.00654
G1 X145.34 Y70.925 E.00855
G1 X138.346 Y82.338 E.22654
G1 X136.451 Y82.338 E.03207
G1 X136.451 Y66.442 E.26904
G1 X137.723 Y66.442 E.02154
G1 X137.723 Y76.442 E.16925
G2 X137.739 Y77.18 I4.251 J.279 E.01252
G1 X137.847 Y77.494 E.00561
G1 X138.145 Y77.837 E.00769
G1 X138.48 Y78.002 E.00633
G1 X138.938 Y78.063 E.00783
G1 X139.372 Y77.927 E.00769
G1 X139.632 Y77.714 E.00568
G1 X139.737 Y77.573 E.00299
G1 X146.618 Y66.442 E.22149
G1 X148.626 Y66.442 E.03399
G1 X148.626 Y67.731 E.02182
G1 X148.626 Y82.338 E.24722
G1 X147.354 Y82.338 E.02154
G1 X147.354 Y71.498 E.18347
G1 X147.229 Y71.004 E.00862
G1 X146.931 Y70.66 E.0077
G1 X146.595 Y70.495 E.00633
G1 X146.136 Y70.436 E.00785
G1 X146.127 Y70.438 E.00015
M204 S10000
G1 X146.14 Y70.873 F30000
G1 F6000
M204 S1000
G1 X145.917 Y70.943 E.00396
G1 X145.704 Y71.151 E.00503
G1 X138.586 Y82.766 E.23058
G1 X136.022 Y82.766 E.04339
G1 X136.022 Y66.013 E.28355
G1 X138.152 Y66.013 E.03604
G1 X138.152 Y77 E.18596
G1 X138.225 Y77.291 E.00507
G1 X138.4 Y77.493 E.00452
G1 X138.597 Y77.59 E.00372
G1 X138.903 Y77.636 E.00523
G1 X139.158 Y77.556 E.00452
G1 X139.373 Y77.347 E.00507
G1 X146.379 Y66.013 E.22553
G1 X149.055 Y66.013 E.04528
G1 X149.055 Y67.731 E.02908
G1 X149.055 Y82.766 E.25447
G1 X146.925 Y82.766 E.03604
G1 X146.925 Y71.498 E.19072
G1 X146.852 Y71.207 E.00507
G1 X146.677 Y71.005 E.00453
G1 X146.479 Y70.908 E.00373
G1 X146.198 Y70.866 E.0048
M204 S250
G1 X146.208 Y71.275 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X146.056 Y71.368 E.00281
G1 X138.817 Y83.18 E.21805
G1 X135.609 Y83.18 E.0505
G1 X135.609 Y65.6 E.27672
G1 X138.565 Y65.6 E.04654
G1 X138.565 Y77 E.17945
G1 X138.646 Y77.16 E.00282
G1 X138.868 Y77.224 E.00363
G1 X139.021 Y77.13 E.00282
G1 X146.149 Y65.6 E.21337
G1 X149.468 Y65.6 E.05225
G1 X149.468 Y67.731 E.03355
G1 X149.468 Y83.18 E.24317
G1 X146.512 Y83.18 E.04654
G1 X146.512 Y71.498 E.18388
G1 X146.431 Y71.337 E.00283
G1 X146.266 Y71.291 E.0027
; WIPE_START
M204 S1000
G1 X146.056 Y71.368 E-.08506
G1 X145.128 Y72.883 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.759 Y72.657 Z2.1 F30000
G1 X145.937 Y70.735
G1 X147.784 Y70.382
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S1000
G1 X147.784 Y67.284 E.04877
G1 X147.087 Y67.284 E.01097
G1 X145.555 Y69.753 E.04574
G1 X146.103 Y69.597 E.00897
G1 X146.793 Y69.679 E.01094
G1 X147.401 Y69.964 E.01056
G1 X147.744 Y70.338 E.00798
M204 S10000
G1 X147.386 Y69.513 F30000
G1 F6000
M204 S1000
G1 X147.386 Y67.682 E.02881
G1 X147.295 Y67.705 E.00148
G1 X146.351 Y69.225 E.02816
G1 X146.908 Y69.295 E.00884
G1 X147.331 Y69.488 E.00731
M204 S10000
G1 X147.022 Y68.877 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S1000
G1 X146.951 Y68.918 E.00121
G1 X147.01 Y68.952 E.00102
G1 E-.8 F1800
M204 S10000
G1 X142.388 Y75.026 Z2.1 F30000
G1 X139.568 Y78.732 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
G1 X139.052 Y78.893 E.00851
G1 X138.281 Y78.818 E.01219
G1 X137.674 Y78.532 E.01055
G1 X137.298 Y78.122 E.00877
G1 X137.293 Y81.495 E.05311
G1 X137.874 Y81.495 E.00915
G1 X139.537 Y78.783 E.05008
M204 S10000
G1 X138.766 Y79.278 F30000
G1 F6000
M204 S1000
G1 X138.233 Y79.214 E.00844
G1 X137.695 Y78.987 E.00919
G1 X137.692 Y81.03 E.03215
G1 X138.734 Y79.329 E.03139
M204 S10000
G1 X138.122 Y79.555 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S1000
G2 X138.113 Y79.643 I-.025 J.042 E.00317
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X138.071 Y79.643 E-.16312
G1 X138.046 Y79.599 E-.19896
G1 X138.071 Y79.555 E-.19898
G1 X138.122 Y79.555 E-.19893
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 18/58
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
M106 S127.5
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.1 I.911 J.807 P1  F30000
G1 X145.937 Y70.735 Z2.1
G1 X146.945 Y71.019
G1 X149.036 Y77.236
G1 X161.978 Y74.486
G1 X168.164 Y82.747
G1 X172.355 Y72.28
G1 X178.267 Y71.024
G1 X180.615 Y70.525
G1 X185.376 Y69.514
G1 X187.725 Y73.547
G1 X189.107 Y73.547
G1 X189.421 Y73.543
G1 X189.718 Y73.533
G1 X189.998 Y73.516
G1 X190.259 Y73.492
G1 X190.503 Y73.46
G1 X190.732 Y73.42
G1 X190.946 Y73.37
G1 X191.156 Y73.305
G1 X191.512 Y73.152
G1 X191.858 Y72.944
G1 X192.185 Y72.691
G1 X200.283 Y65.746
G1 X199.552 Y66.501
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
M204 S1000
M73 P85 R11
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.2 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.2 F30000
G1 X208.887 Y69.747
G1 X208.865 Y80.032
G1 X208.501 Y79.6
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 18 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer18 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.2 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.2 F30000
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.2 F30000
G1 X192.634 Y92.321
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.2 F30000
G1 X179.68 Y82.747
G1 X179.716 Y81.848
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X179.166 Y81.848 E.01199
G1 X179.166 Y66.931 E.32454
G1 X179.716 Y66.931 E.01199
G1 X179.716 Y67.207 E.00599
G1 X179.716 Y81.788 E.31725
M204 S10000
G1 X180.206 Y82.338 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X178.676 Y82.338 E.0259
G1 X178.676 Y66.442 E.26904
G1 X180.206 Y66.442 E.0259
G1 X180.206 Y67.207 E.01295
G1 X180.206 Y82.278 E.25508
M204 S10000
G1 X180.635 Y82.766 F30000
G1 F6000
M204 S1000
G1 X178.247 Y82.766 E.04041
G1 X178.247 Y66.013 E.28355
G1 X180.635 Y66.013 E.04041
G1 X180.635 Y67.207 E.0202
G1 X180.635 Y82.706 E.26233
M204 S250
G1 X181.048 Y83.18 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X177.834 Y83.18 E.0506
G1 X177.834 Y65.6 E.27672
G1 X181.048 Y65.6 E.0506
G1 X181.048 Y67.207 E.0253
G1 X181.048 Y83.12 E.25048
; WIPE_START
M204 S1000
G1 X179.049 Y83.157 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.049 Y82.747 Z2.2 F30000
G1 X180.615 Y81.984
G1 X185.376 Y78.422
G1 X187.725 Y75.134
G1 X193.875 Y72.062
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54612
G1 F6000
M204 S1000
G2 X194.55 Y71.131 I-10.862 J-8.575 E.02383
; LINE_WIDTH: 0.55718
G1 X194.88 Y70.661 E.01214
; LINE_WIDTH: 0.582185
G1 X195.045 Y70.437 E.00617
; LINE_WIDTH: 0.60719
G1 X195.211 Y70.213 E.00644
; LINE_WIDTH: 0.62971
G1 X195.545 Y69.734 E.01404
; LINE_WIDTH: 0.63992
G2 X196.564 Y68.221 I-85.003 J-58.297 E.04455
; LINE_WIDTH: 0.63471
G1 X197.314 Y67.083 E.03303
; LINE_WIDTH: 0.6132
G1 X197.402 Y66.952 E.00369
G1 X198.094 Y66.952 E.01618
G1 X197.811 Y67.405 E.01249
; LINE_WIDTH: 0.63471
G1 X197.075 Y68.56 E.03319
; LINE_WIDTH: 0.63992
G3 X196.037 Y70.092 I-28.835 J-18.418 E.0452
; LINE_WIDTH: 0.62971
G1 X195.664 Y70.58 E.01475
; LINE_WIDTH: 0.60719
G1 X195.472 Y70.797 E.0067
; LINE_WIDTH: 0.58124
G1 X195.28 Y71.014 E.0064
; LINE_WIDTH: 0.55529
G1 X194.834 Y71.409 E.01256
; LINE_WIDTH: 0.54612
G3 X193.926 Y72.031 I-7.663 J-10.214 E.0228
G1 E-.8 F1800
M204 S10000
G1 X193.599 Y74.31 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X193.646 Y74.385 E.00149
G2 X191.677 Y74.3 I-2.331 J30.999 E.03337
; LINE_WIDTH: 0.475475
G1 X191.269 Y74.287 E.00731
; LINE_WIDTH: 0.50096
G1 X190.862 Y74.274 E.00772
G1 X190.99 Y74.236 E.00253
; LINE_WIDTH: 0.48376
G1 X191.609 Y74.019 E.01198
; LINE_WIDTH: 0.44999
G1 X192.173 Y73.729 E.01073
G1 X192.464 Y73.532 E.00595
G1 X192.997 Y73.07 E.01193
; LINE_WIDTH: 0.45056
G1 X193.39 Y72.622 E.0101
G1 X193.261 Y72.933 E.0057
; LINE_WIDTH: 0.44999
G1 X193.212 Y73.183 E.00431
G1 X193.272 Y73.783 E.0102
G1 X193.568 Y74.259 E.00949
; WIPE_START
G1 X193.646 Y74.385 E-.05633
G1 X192.841 Y74.331 E-.30645
G1 X191.796 Y74.303 E-.39722
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X191.781 Y75.139 Z2.2 F30000
G1 X191.687 Y75.138
G1 X191.058 Y75.134
G1 X187.725 Y75.134
G1 X186.826 Y77.753
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X186.826 Y80.355 E.05661
; LINE_WIDTH: 0.58603
G1 X186.842 Y80.621 E.00594
G1 X186.935 Y80.797 E.00444
; LINE_WIDTH: 0.540684
G1 X187.027 Y80.974 E.00409
; LINE_WIDTH: 0.495337
G1 X187.12 Y81.15 E.00373
; LINE_WIDTH: 0.44999
G1 X187.61 Y81.622 E.01151
; LINE_WIDTH: 0.491915
G1 X187.983 Y81.744 E.0073
; LINE_WIDTH: 0.53384
G1 X188.357 Y81.867 E.00795
G1 X187.944 Y81.888 E.00835
; LINE_WIDTH: 0.491915
G1 X187.532 Y81.909 E.00767
; LINE_WIDTH: 0.44999
G1 X186.214 Y81.909 E.02232
G1 X186.214 Y81.417 E.00834
; LINE_WIDTH: 0.49077
G1 X186.234 Y81.063 E.00657
; LINE_WIDTH: 0.53155
G1 X186.254 Y80.709 E.00714
; LINE_WIDTH: 0.57233
G1 X186.275 Y80.355 E.00771
G1 X186.275 Y76.355 E.08703
G2 X186.254 Y75.529 I-4.825 J-.294 E.01801
; LINE_WIDTH: 0.53155
G1 X186.234 Y75.291 E.00481
; LINE_WIDTH: 0.49077
G1 X186.214 Y75.053 E.00442
; LINE_WIDTH: 0.44999
G1 X186.214 Y73.628 E.02413
; LINE_WIDTH: 0.495337
G1 X186.236 Y73.495 E.00252
; LINE_WIDTH: 0.540684
G1 X186.259 Y73.362 E.00276
; LINE_WIDTH: 0.58603
G2 X186.275 Y72.915 I-1.15 J-.265 E.01004
; LINE_WIDTH: 0.57233
G1 X186.275 Y66.931 E.13018
G1 X186.826 Y66.931 E.01199
G1 X186.826 Y72.915 E.13018
; LINE_WIDTH: 0.58603
G1 X186.842 Y73.18 E.00594
G1 X186.894 Y73.278 E.00246
; LINE_WIDTH: 0.540684
G1 X186.945 Y73.375 E.00226
; LINE_WIDTH: 0.495337
G1 X186.997 Y73.473 E.00207
; LINE_WIDTH: 0.44999
G1 X187.283 Y73.918 E.00896
G1 X187.664 Y74.211 E.00813
G1 X187.948 Y74.276 E.00493
; LINE_WIDTH: 0.411405
G1 X188.232 Y74.34 E.00449
G1 X187.948 Y74.405 E.00449
; LINE_WIDTH: 0.44999
G1 X187.664 Y74.47 E.00493
G1 X187.283 Y74.762 E.00813
G1 X186.997 Y75.208 E.00896
; LINE_WIDTH: 0.49077
G1 X186.94 Y75.394 E.00361
; LINE_WIDTH: 0.53155
G1 X186.883 Y75.58 E.00392
; LINE_WIDTH: 0.57233
G1 X186.826 Y75.766 E.00424
G1 X186.826 Y77.693 E.04193
; WIPE_START
G1 X186.826 Y79.693 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X187.725 Y75.134 Z2.2 F30000
G1 X191.058 Y75.134
G1 X191.687 Y75.138
G1 X192.258 Y75.148
G1 X192.77 Y75.166
G1 X193.225 Y75.191
G1 X193.623 Y75.224
G1 X193.968 Y75.265
G1 X194.268 Y75.318
G1 X194.532 Y75.389
G1 X194.928 Y75.557
G1 X195.19 Y75.72
G1 X195.62 Y75.032
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.39724
G1 F6000
M204 S1000
G3 X196.212 Y75.275 I-1.148 J3.645 E.0095
; LINE_WIDTH: 0.39845
G1 X196.759 Y75.603 E.0095
; LINE_WIDTH: 0.4398
G1 X196.976 Y75.834 E.00524
; LINE_WIDTH: 0.48115
G1 X197.193 Y76.065 E.00576
; LINE_WIDTH: 0.51021
G1 X197.336 Y76.288 E.00511
; LINE_WIDTH: 0.53927
G1 X197.48 Y76.51 E.00541
; LINE_WIDTH: 0.58192
G1 X197.701 Y77.043 E.01277
; LINE_WIDTH: 0.61045
G1 X197.836 Y77.653 E.01453
; LINE_WIDTH: 0.63163
G1 X197.878 Y78.375 E.01743
; LINE_WIDTH: 0.63865
G1 X197.841 Y78.913 E.01314
; LINE_WIDTH: 0.64478
G3 X197.567 Y79.896 I-3.881 J-.55 E.0252
; LINE_WIDTH: 0.64303
G1 X197.326 Y80.354 E.01271
; LINE_WIDTH: 0.62898
G1 X196.938 Y80.85 E.01511
; LINE_WIDTH: 0.60303
G1 X196.449 Y81.266 E.01473
; LINE_WIDTH: 0.55804
G1 X196.023 Y81.466 E.00999
G1 X195.485 Y81.617 E.01183
; LINE_WIDTH: 0.595907
G1 X195.282 Y81.63 E.00461
; LINE_WIDTH: 0.633774
G1 X195.079 Y81.643 E.00491
; LINE_WIDTH: 0.67164
G1 X194.877 Y81.656 E.00522
G1 X195.05 Y81.56 E.0051
; LINE_WIDTH: 0.633774
G1 X195.224 Y81.464 E.0048
; LINE_WIDTH: 0.595907
G1 X195.398 Y81.368 E.0045
; LINE_WIDTH: 0.55804
G1 X195.841 Y81.085 E.01115
; LINE_WIDTH: 0.57607
G1 X196.288 Y80.697 E.01297
; LINE_WIDTH: 0.61751
G1 X196.593 Y80.351 E.01086
; LINE_WIDTH: 0.63175
G1 X196.875 Y79.909 E.01264
; LINE_WIDTH: 0.64478
G1 X197.129 Y79.272 E.01688
G1 X197.247 Y78.653 E.01551
; LINE_WIDTH: 0.63271
G1 X197.269 Y78.018 E.01534
; LINE_WIDTH: 0.61329
G1 X197.209 Y77.426 E.01392
; LINE_WIDTH: 0.58935
G1 X197.057 Y76.851 E.01333
; LINE_WIDTH: 0.54655
G1 X196.921 Y76.564 E.00661
; LINE_WIDTH: 0.512425
G1 X196.784 Y76.276 E.00618
; LINE_WIDTH: 0.4783
G1 X196.629 Y76.061 E.00478
; LINE_WIDTH: 0.43777
G1 X196.474 Y75.847 E.00435
; LINE_WIDTH: 0.39724
G1 X196.038 Y75.362 E.00967
G1 X195.667 Y75.069 E.00702
G1 E-.8 F1800
M204 S10000
G1 X193.915 Y74.031 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X193.951 Y74.089 E.00115
; LINE_WIDTH: 0.48657
G1 X194.17 Y74.234 E.00482
; LINE_WIDTH: 0.52315
G1 X194.388 Y74.379 E.0052
; LINE_WIDTH: 0.53006
G1 X194.632 Y74.43 E.005
; LINE_WIDTH: 0.57932
G2 X195.441 Y74.61 I1.637 J-5.451 E.01828
; LINE_WIDTH: 0.53621
G1 X195.623 Y74.64 E.00375
; LINE_WIDTH: 0.4931
G1 X195.805 Y74.67 E.00344
; LINE_WIDTH: 0.44999
G1 X196.309 Y74.866 E.00915
G1 X196.972 Y75.253 E.013
G1 X197.431 Y75.664 E.01042
G3 X198.18 Y76.922 I-3.273 J2.801 E.0249
G1 X198.343 Y77.614 E.01204
G1 X198.396 Y78.408 E.01347
G3 X197.487 Y81.006 I-4.083 J.029 E.04751
G1 X197.129 Y81.37 E.00864
G1 X196.671 Y81.699 E.00954
G1 X196.208 Y81.915 E.00866
G1 X195.597 Y82.088 E.01075
G3 X192.379 Y82.337 I-2.943 J-17.055 E.05471
G1 X185.785 Y82.338 E.1116
G1 X185.785 Y66.442 E.26904
G1 X187.315 Y66.442 E.0259
G1 X187.315 Y72.915 E.10956
G1 X187.393 Y73.31 E.00682
G1 X187.596 Y73.626 E.00635
G1 X187.866 Y73.833 E.00576
G1 X188.358 Y73.956 E.00858
G2 X190.875 Y73.806 I.511 J-12.65 E.04275
G1 X191.453 Y73.617 E.0103
G1 X192.184 Y73.208 E.01417
G1 X192.716 Y72.746 E.01193
G2 X194.472 Y70.403 I-17.996 J-15.316 E.04959
G1 X197.13 Y66.442 E.08075
G1 X199.016 Y66.442 E.03191
G1 X197.954 Y68.137 E.03385
G3 X196.457 Y70.397 I-32.952 J-20.21 E.04589
G3 X194.656 Y72.123 I-5.532 J-3.97 E.04246
G1 X194.015 Y72.532 E.01287
G1 X193.764 Y72.832 E.00661
G1 X193.638 Y73.228 E.00705
G1 X193.681 Y73.653 E.00723
G1 X193.883 Y73.98 E.00651
M204 S10000
G1 X194.231 Y73.751 F30000
G1 F6000
M204 S1000
G1 X194.248 Y73.78 E.00057
G1 X194.511 Y73.93 E.00513
G3 X195.937 Y74.262 I-2.272 J12.998 E.02479
G1 X196.5 Y74.481 E.01022
G1 X197.226 Y74.905 E.01422
G1 X197.8 Y75.419 E.01306
G1 X198.247 Y76.023 E.0127
G1 X198.567 Y76.705 E.01276
G1 X198.737 Y77.373 E.01167
G3 X198.824 Y78.435 I-9.284 J1.299 E.01805
G3 X197.772 Y81.341 I-4.49 J.018 E.05339
G1 X197.355 Y81.748 E.00987
G1 X196.885 Y82.072 E.00966
G1 X196.357 Y82.318 E.00986
G1 X195.689 Y82.507 E.01176
G3 X192.383 Y82.766 I-3.035 J-17.495 E.0562
G1 X185.356 Y82.766 E.11893
G1 X185.356 Y66.013 E.28355
G1 X187.744 Y66.013 E.04041
G1 X187.744 Y72.915 E.11681
G1 X187.753 Y73.02 E.0018
G1 X187.909 Y73.333 E.00591
G1 X188.068 Y73.455 E.00339
G1 X188.357 Y73.527 E.00505
G2 X190.764 Y73.392 I.487 J-12.825 E.04085
G1 X191.257 Y73.236 E.00876
G1 X191.903 Y72.885 E.01244
G1 X192.435 Y72.423 E.01193
G2 X194.119 Y70.16 I-18.617 J-15.614 E.04776
G1 X196.902 Y66.013 E.08453
G1 X199.79 Y66.013 E.04888
G1 X198.728 Y67.708 E.03385
G3 X196.8 Y70.653 I-39.592 J-23.817 E.05959
G3 X194.349 Y72.82 I-6.174 J-4.516 E.0558
G1 X194.198 Y72.953 E.0034
G1 X194.085 Y73.17 E.00415
G1 X194.083 Y73.503 E.00565
G1 X194.2 Y73.7 E.00387
M204 S250
G1 X194.535 Y73.483 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X194.639 Y73.536 E.00183
G3 X196.684 Y74.11 I-1.09 J7.81 E.03354
G1 X197.47 Y74.569 E.01432
G1 X198.108 Y75.139 E.01346
G1 X198.604 Y75.81 E.01312
G1 X198.958 Y76.565 E.01313
G1 X199.137 Y77.271 E.01147
G3 X199.237 Y78.461 I-8.742 J1.329 E.01881
G1 X199.197 Y79.091 E.00994
G1 X199.055 Y79.794 E.01128
G1 X198.82 Y80.452 E.011
G1 X198.491 Y81.067 E.01098
G1 X198.085 Y81.614 E.01072
G1 X197.619 Y82.068 E.01024
G1 X197.092 Y82.432 E.01008
G1 X196.502 Y82.707 E.01024
G1 X195.778 Y82.911 E.01184
G3 X192.388 Y83.179 I-3.123 J-17.921 E.0536
G1 X184.943 Y83.18 E.11719
G1 X184.943 Y65.6 E.27672
G1 X188.157 Y65.6 E.0506
G1 X188.157 Y72.915 E.11514
G1 X188.211 Y73.051 E.0023
G1 X188.357 Y73.114 E.0025
G2 X190.631 Y72.998 I.487 J-12.824 E.03589
G1 X191.068 Y72.868 E.00718
G1 X191.665 Y72.544 E.01068
G1 X192.189 Y72.085 E.01096
G2 X193.779 Y69.926 I-19.097 J-15.726 E.04224
G1 X196.681 Y65.6 E.082
G1 X200.537 Y65.6 E.06068
G1 X198.414 Y68.99 E.06296
G3 X196.632 Y71.52 I-18.991 J-11.48 E.04874
G1 X196.034 Y72.125 E.0134
G3 X194.548 Y73.185 I-6.954 J-8.176 E.02877
G1 X194.475 Y73.318 E.00238
G1 X194.515 Y73.426 E.00181
; WIPE_START
M204 S1000
G1 X194.639 Y73.536 E-.06284
G1 X195.196 Y73.634 E-.21482
G1 X195.713 Y73.758 E-.20234
G1 X196.193 Y73.91 E-.19109
G1 X196.41 Y73.998 E-.08891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X196.244 Y74.396 Z2.2 F30000
G1 X187.725 Y75.134
G1 X187.725 Y80.987
G1 X188.143 Y80.987
G1 X188.143 Y81.338
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X187.828 Y81.252 E.00552
G1 X187.481 Y80.918 E.00816
G1 X187.331 Y80.535 E.00696
G1 X187.315 Y80.355 E.00306
G1 X187.315 Y75.766 E.07767
G1 X187.393 Y75.371 E.00682
G1 X187.596 Y75.055 E.00635
G1 X187.866 Y74.848 E.00576
G1 X188.358 Y74.725 E.00858
G1 X190.358 Y74.727 E.03385
G3 X193.629 Y74.814 I.607 J38.868 E.05541
; LINE_WIDTH: 0.48657
G1 X193.958 Y74.841 E.00605
; LINE_WIDTH: 0.52315
G1 X194.286 Y74.869 E.00653
; LINE_WIDTH: 0.56649
G1 X194.899 Y75.045 E.01372
; LINE_WIDTH: 0.57932
G3 X195.233 Y75.225 I-.095 J.578 E.00852
; LINE_WIDTH: 0.53621
G1 X195.387 Y75.343 E.00394
; LINE_WIDTH: 0.4931
G1 X195.54 Y75.462 E.00361
; LINE_WIDTH: 0.44999
G3 X196.492 Y76.69 I-2.1 J2.612 E.02655
G3 X196.579 Y79.285 I-3.77 J1.425 E.04474
G1 X196.364 Y79.773 E.00902
G1 X196.004 Y80.284 E.01059
G1 X195.524 Y80.717 E.01095
G3 X194.54 Y81.201 I-1.938 J-2.698 E.01863
G1 X193.924 Y81.333 E.01066
G3 X190.199 Y81.395 I-2.696 J-50.217 E.06308
G1 X188.357 Y81.397 E.03118
G1 X188.201 Y81.354 E.00273
M204 S10000
G1 X188.252 Y80.939 F30000
G1 F6000
M204 S1000
G1 X188.045 Y80.883 E.00362
G1 X187.841 Y80.687 E.0048
G1 X187.744 Y80.355 E.00585
G1 X187.744 Y75.766 E.07767
G3 X188.068 Y75.226 I.681 J.041 E.01109
G1 X188.36 Y75.153 E.0051
G1 X190.36 Y75.156 E.03385
G3 X193.6 Y75.241 I.592 J38.926 E.05488
G3 X194.997 Y75.623 I-.242 J3.635 E.02467
G1 X195.487 Y75.984 E.0103
G1 X195.827 Y76.368 E.0087
G1 X196.089 Y76.835 E.00905
G1 X196.248 Y77.342 E.009
G1 X196.332 Y78.074 E.01246
G1 X196.301 Y78.587 E.0087
G1 X196.176 Y79.141 E.00961
G1 X195.947 Y79.634 E.0092
G1 X195.655 Y80.029 E.00832
G1 X195.293 Y80.356 E.00825
G3 X193.897 Y80.905 I-1.913 J-2.815 E.02561
G3 X190.199 Y80.966 I-2.665 J-49.496 E.06262
G1 X188.357 Y80.968 E.03118
G1 X188.31 Y80.955 E.00083
M204 S250
G1 X188.357 Y80.555 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X188.189 Y80.463 E.00301
G1 X188.157 Y80.355 E.00177
G1 X188.157 Y75.766 E.07223
G1 X188.211 Y75.63 E.0023
G1 X188.36 Y75.567 E.00254
G1 X191.685 Y75.571 E.05234
G3 X194.16 Y75.739 I.112 J16.663 E.03909
G1 X194.703 Y75.932 E.00907
G3 X195.524 Y76.656 I-1.099 J2.073 E.01739
G1 X195.764 Y77.152 E.00868
G1 X195.893 Y77.682 E.00859
G3 X195.884 Y78.589 I-4.116 J.413 E.01431
G1 X195.746 Y79.095 E.00825
G3 X195.071 Y80.007 I-2.098 J-.846 E.01806
G3 X193.87 Y80.493 I-1.673 J-2.411 E.02055
G3 X190.198 Y80.553 I-2.726 J-54.39 E.05782
G1 X188.417 Y80.554 E.02804
; WIPE_START
M204 S1000
G1 X188.189 Y80.463 E-.0932
G1 X188.157 Y80.355 E-.04268
G1 X188.157 Y78.713 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X187.725 Y78.713 Z2.2 F30000
G1 X187.725 Y80.987
G1 X194.877 Y81.656
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S1000
G1 X194.544 Y81.72 E.00868
; LINE_WIDTH: 0.62207
G1 X194.212 Y81.783 E.00802
; LINE_WIDTH: 0.5725
G1 X193.651 Y81.83 E.01227
; LINE_WIDTH: 0.55022
G1 X193.044 Y81.854 E.01267
; LINE_WIDTH: 0.54592
G1 X192.374 Y81.864 E.0139
; LINE_WIDTH: 0.54068
G1 X192.199 Y81.865 E.00357
; LINE_WIDTH: 0.53768
G1 X190.199 Y81.866 E.04078
; LINE_WIDTH: 0.53568
G1 X188.358 Y81.867 E.0374
; LINE_WIDTH: 0.53384
G1 X188.357 Y81.867 E.00003
; WIPE_START
G1 X188.358 Y81.867 E-.00057
G1 X190.199 Y81.866 E-.69973
G1 X190.357 Y81.866 E-.05969
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X194.471 Y80.797 Z2.2 F30000
G1 X194.937 Y80.606
G1 X195.355 Y80.34
G1 X195.713 Y80
G1 X196 Y79.593
G1 X196.201 Y79.135
G1 X196.317 Y78.639
G1 X196.354 Y78.113
G1 X196.326 Y77.641
G1 X196.239 Y77.196
G1 X196.089 Y76.779
G1 X195.875 Y76.398
G1 X195.606 Y76.064
G1 X195.289 Y75.782
G1 X194.928 Y75.557
G1 X194.532 Y75.389
G1 X190.862 Y74.274
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.50096
G1 F6000
M204 S1000
G1 X190.798 Y74.278 E.00121
; LINE_WIDTH: 0.49122
G1 X190.407 Y74.302 E.00726
; LINE_WIDTH: 0.44249
G1 X190.017 Y74.326 E.00651
; LINE_WIDTH: 0.39376
G1 X189.411 Y74.339 E.0089
; LINE_WIDTH: 0.3662
G1 X188.361 Y74.34 E.0143
; LINE_WIDTH: 0.37282
G1 X188.232 Y74.34 E.00179
G1 E-.8 F1800
M204 S10000
G1 X193.684 Y72.257 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.45056
G1 F6000
M204 S1000
G1 X193.39 Y72.622 E.00795
G1 E-.8 F1800
M204 S10000
G1 X192.839 Y73.808 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.54422
G1 F6000
M204 S1000
G2 X192.842 Y73.917 I-.028 J.055 E.00525
G1 E-.8 F1800
M204 S10000
G1 X186.63 Y75.016 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S1000
G1 X186.957 Y74.507 E.00965
G3 X187.154 Y74.34 I.576 J.483 E.00414
G1 X186.959 Y74.177 E.00405
G1 X186.63 Y73.688 E.0094
G1 X186.63 Y74.956 E.02022
G1 E-.8 F1800
M204 S10000
G1 X186.743 Y81.358 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57486
G1 F6000
M204 S1000
G2 X186.748 Y81.47 I-.03 J.057 E.00595
; WIPE_START
G1 X186.674 Y81.478 E-.20014
G1 X186.64 Y81.418 E-.18662
G1 X186.674 Y81.358 E-.18663
G1 X186.743 Y81.358 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X185.376 Y78.182 Z2.2 F30000
G1 X180.615 Y67.13
G1 X180.143 Y66.032
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.2 F30000
G1 X181.348 Y56.444
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.2 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.2 F30000
G1 X162.522 Y69.807
G1 X161.718 Y70.099
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.51468
G1 F6000
M204 S1000
G1 X161.794 Y70.268 E.00361
G1 X161.929 Y70.41 E.00381
; LINE_WIDTH: 0.482335
G1 X162.063 Y70.551 E.00356
; LINE_WIDTH: 0.44999
G1 X162.581 Y70.872 E.01031
G1 X163.079 Y70.959 E.00855
; LINE_WIDTH: 0.497195
G1 X163.502 Y70.982 E.00797
; LINE_WIDTH: 0.5444
G1 X163.926 Y71.006 E.00876
G1 X163.58 Y71.194 E.00813
; LINE_WIDTH: 0.497195
G1 X163.235 Y71.382 E.00739
; LINE_WIDTH: 0.44999
G1 X162.912 Y71.771 E.00855
G1 X162.727 Y72.342 E.01017
; LINE_WIDTH: 0.4722
G1 X162.797 Y73.007 E.0119
G1 X163.491 Y74.882 E.03561
; LINE_WIDTH: 0.44985
G1 X164.186 Y76.758 E.03384
; LINE_WIDTH: 0.4275
G1 X164.88 Y78.633 E.03207
; LINE_WIDTH: 0.40515
G1 X165.28 Y79.714 E.01747
; LINE_WIDTH: 0.4044
G1 X165.397 Y79.972 E.00427
; LINE_WIDTH: 0.44999
G1 X165.708 Y80.363 E.00845
G1 X166.331 Y80.66 E.01167
G2 X167.002 Y80.645 I.304 J-1.438 E.01147
G1 X167.588 Y80.34 E.01118
; LINE_WIDTH: 0.45984
G1 X167.888 Y79.998 E.00788
G1 X168.011 Y79.733 E.00506
; LINE_WIDTH: 0.47269
G1 X168.719 Y77.862 E.03564
; LINE_WIDTH: 0.49801
G1 X169.427 Y75.992 E.03764
; LINE_WIDTH: 0.52333
G1 X170.135 Y74.121 E.03964
; LINE_WIDTH: 0.53814
G1 X170.55 Y73.027 E.02387
; LINE_WIDTH: 0.55128
G1 X170.618 Y72.813 E.00471
G1 X170.611 Y72.668 E.00305
; LINE_WIDTH: 0.517517
G1 X170.603 Y72.522 E.00285
; LINE_WIDTH: 0.483753
G1 X170.595 Y72.377 E.00266
; LINE_WIDTH: 0.44999
G1 X170.432 Y71.818 E.00985
G1 X170.115 Y71.409 E.00876
; LINE_WIDTH: 0.485785
G1 X169.623 Y71.202 E.0098
; LINE_WIDTH: 0.52158
G1 X169.13 Y70.995 E.01056
G1 X169.71 Y70.977 E.01145
; LINE_WIDTH: 0.485785
G1 X170.289 Y70.959 E.01063
; LINE_WIDTH: 0.44999
G1 X170.798 Y70.868 E.00876
G1 X171.301 Y70.555 E.01002
; LINE_WIDTH: 0.486633
G1 X171.438 Y70.382 E.00405
; LINE_WIDTH: 0.523277
G1 X171.575 Y70.209 E.00437
; LINE_WIDTH: 0.55992
G1 X171.712 Y70.036 E.00469
; LINE_WIDTH: 0.5738
G1 X172.436 Y68.172 E.04363
; LINE_WIDTH: 0.58167
G2 X172.915 Y66.936 I-177.652 J-69.604 E.02933
G1 X173.108 Y66.936 E.00426
G1 X173.522 Y66.936 E.00916
G2 X172.631 Y69.179 I322.528 J129.367 E.05341
; LINE_WIDTH: 0.56778
G1 X172.213 Y70.233 E.02445
; LINE_WIDTH: 0.55992
G2 X172.124 Y70.505 I1.951 J.791 E.00611
; LINE_WIDTH: 0.523217
G1 X172.044 Y70.755 E.00519
; LINE_WIDTH: 0.486603
G1 X171.963 Y71.004 E.00482
; LINE_WIDTH: 0.44999
G1 X171.368 Y72.493 E.02713
; LINE_WIDTH: 0.494065
G1 X171.2 Y72.853 E.00742
; LINE_WIDTH: 0.53814
G1 X171.032 Y73.213 E.00811
G1 X170.3 Y75.075 E.04081
; LINE_WIDTH: 0.51281
G1 X169.568 Y76.936 E.03881
; LINE_WIDTH: 0.48749
G1 X168.837 Y78.797 E.03681
; LINE_WIDTH: 0.46217
G1 X168.409 Y79.886 E.02036
; LINE_WIDTH: 0.45984
G2 X168.083 Y80.695 I14.436 J6.276 E.01511
; LINE_WIDTH: 0.44999
G1 X167.597 Y81.909 E.02212
G1 X165.768 Y81.909 E.03095
G2 X165.11 Y80.258 I-26.011 J9.418 E.03009
; LINE_WIDTH: 0.42113
G1 X164.934 Y79.845 E.00709
; LINE_WIDTH: 0.41461
G1 X164.218 Y77.977 E.03106
; LINE_WIDTH: 0.43696
G1 X163.503 Y76.11 E.03282
; LINE_WIDTH: 0.45931
G1 X162.787 Y74.242 E.03459
; LINE_WIDTH: 0.4722
G2 X162.076 Y72.428 I-46.648 J17.252 E.03469
; LINE_WIDTH: 0.44999
G1 X161.493 Y70.933 E.02717
; LINE_WIDTH: 0.47587
G1 X161.358 Y70.551 E.00727
; LINE_WIDTH: 0.50175
G1 X161.223 Y70.169 E.00768
; LINE_WIDTH: 0.52463
G1 X160.508 Y68.301 E.03975
; LINE_WIDTH: 0.53733
G2 X159.975 Y66.914 I-121.17 J45.803 E.03029
G1 X160.533 Y66.914 E.01137
G2 X161.288 Y68.96 I179.136 J-64.994 E.04443
; LINE_WIDTH: 0.51444
G1 X161.673 Y70 E.0216
; LINE_WIDTH: 0.51468
G1 X161.693 Y70.044 E.00095
M204 S10000
G1 X162.196 Y69.998 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X162.359 Y70.242 E.00497
G1 X162.726 Y70.469 E.00731
G1 X163.079 Y70.53 E.00606
G1 X170.289 Y70.53 E.12203
G1 X170.65 Y70.466 E.00621
G1 X171.006 Y70.244 E.0071
G1 X171.255 Y69.876 E.00753
G1 X172.576 Y66.442 E.06228
G1 X173.108 Y66.442 E.009
G1 X174.252 Y66.442 E.01937
G1 X167.887 Y82.338 E.28981
G1 X165.475 Y82.338 E.04082
G1 X159.284 Y66.442 E.28873
G1 X160.864 Y66.442 E.02673
G1 X161.547 Y68.321 E.03385
G2 X162.108 Y69.867 I68.526 J-24.037 E.02783
G1 X162.163 Y69.948 E.00165
M204 S10000
G1 X162.549 Y69.77 F30000
G1 F6000
M204 S1000
G1 X162.655 Y69.932 E.00328
G1 X162.871 Y70.066 E.0043
G1 X163.079 Y70.102 E.00356
G1 X170.289 Y70.102 E.12203
G1 X170.408 Y70.09 E.00203
G1 X170.711 Y69.933 E.00576
G1 X170.858 Y69.717 E.00443
G1 X172.281 Y66.013 E.06716
G1 X173.108 Y66.013 E.01399
G1 X174.885 Y66.013 E.03009
G1 X168.177 Y82.766 E.30544
G1 X165.182 Y82.766 E.05069
G1 X158.657 Y66.013 E.3043
G1 X161.164 Y66.013 E.04242
G1 X162.503 Y69.698 E.06636
G1 X162.517 Y69.719 E.00042
M204 S250
G1 X162.891 Y69.557 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G2 X162.941 Y69.633 I.574 J-.321 E.00143
G1 X163.079 Y69.688 E.00234
G1 X170.289 Y69.688 E.11349
G1 X170.358 Y69.676 E.0011
G1 X170.474 Y69.563 E.00255
G1 X171.997 Y65.6 E.06684
G1 X173.108 Y65.6 E.01748
G1 X175.496 Y65.6 E.0376
G1 X168.457 Y83.18 E.29808
G1 X164.9 Y83.18 E.056
G1 X158.052 Y65.6 E.29697
G1 X161.453 Y65.6 E.05354
G1 X162.82 Y69.359 E.06296
G2 X162.865 Y69.503 I.646 J-.123 E.00239
; WIPE_START
M204 S1000
G1 X162.941 Y69.633 E-.05716
G1 X163.079 Y69.688 E-.05637
G1 X164.78 Y69.688 E-.64646
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.78 Y70.121 Z2.2 F30000
G1 X163.286 Y71.868
G1 X165.921 Y79.108
G1 X166.184 Y79.832
G1 X166.157 Y80.115
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X165.978 Y80.03 E.00334
G1 X165.744 Y79.761 E.00603
G1 X165.656 Y79.578 E.00345
G1 X163.21 Y72.856 E.12106
G1 X163.153 Y72.388 E.00798
G1 X163.284 Y71.983 E.0072
G1 X163.513 Y71.708 E.00606
G1 X164.008 Y71.475 E.00927
G1 X164.188 Y71.459 E.00306
G1 X169.13 Y71.459 E.08365
G1 X169.828 Y71.727 E.01266
G1 X170.053 Y72.017 E.00621
G1 X170.168 Y72.413 E.00698
G1 X170.107 Y72.863 E.00768
G1 X167.611 Y79.584 E.12135
G1 X167.52 Y79.77 E.0035
G1 X167.31 Y80.014 E.00545
G1 X166.815 Y80.247 E.00927
G1 X166.419 Y80.24 E.00669
G1 X166.211 Y80.141 E.00391
M204 S10000
G1 X166.184 Y79.607 F30000
G1 F6000
M204 S1000
G1 X166.059 Y79.431 E.00366
G1 X163.612 Y72.71 E.12106
G1 X163.579 Y72.434 E.0047
G1 X163.71 Y72.118 E.0058
G1 X163.791 Y72.034 E.00197
G1 X164.082 Y71.897 E.00546
G1 X164.188 Y71.887 E.0018
G1 X169.13 Y71.887 E.08365
G1 X169.541 Y72.045 E.00745
G1 X169.673 Y72.216 E.00365
G1 X169.741 Y72.449 E.00411
G1 X169.705 Y72.714 E.00452
G1 X167.209 Y79.435 E.12135
G1 X167.032 Y79.688 E.00523
G1 X166.74 Y79.825 E.00546
G1 X166.508 Y79.821 E.00394
G1 X166.248 Y79.697 E.00487
G1 X166.219 Y79.656 E.00085
M204 S250
G1 X166.509 Y79.376 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X166.447 Y79.29 E.00167
G1 X164.001 Y72.568 E.11259
G1 X164.015 Y72.401 E.00264
G1 X164.154 Y72.304 E.00267
G1 X164.188 Y72.301 E.00054
G1 X169.13 Y72.301 E.07779
G1 X169.29 Y72.381 E.00282
G1 X169.325 Y72.541 E.00258
G1 X169.317 Y72.57 E.00047
G1 X166.82 Y79.296 E.11293
G1 X166.684 Y79.414 E.00283
G1 X166.568 Y79.389 E.00188
; WIPE_START
M204 S1000
G1 X166.447 Y79.29 E-.05928
G1 X165.817 Y77.557 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.41 Y77.705 Z2.2 F30000
G1 X166.184 Y79.832
G1 X167.081 Y79.834
G1 X170.039 Y71.868
G1 X169.13 Y70.995
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S1000
G1 X164.188 Y70.995 E.09762
; LINE_WIDTH: 0.5444
G1 X163.926 Y71.006 E.00542
G1 E-.8 F1800
M204 S10000
G1 X162.384 Y72.056 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S1000
G1 X162.548 Y71.562 E.00843
G1 X162.7 Y71.339 E.00437
M73 P85 R10
G1 X162.395 Y71.244 E.00517
G1 X161.949 Y70.947 E.00868
G1 X162.362 Y72 E.01832
G1 E-.8 F1800
M204 S10000
G1 X169.972 Y71.422 Z2.2 F30000
G1 X170.682 Y71.369 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S1000
G1 X170.845 Y71.654 E.00603
G1 X171.004 Y72.201 E.01042
G1 X171.506 Y70.948 E.02472
G1 X170.995 Y71.266 E.01102
G1 X170.739 Y71.35 E.00494
; WIPE_START
G1 X170.995 Y71.266 E-.10257
G1 X171.506 Y70.948 E-.22853
G1 X171.086 Y71.996 E-.42891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.614 Y78.792 Z2.2 F30000
G1 X167.081 Y79.834 Z2.2
G1 X165.821 Y80.878
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S1000
G1 X166.058 Y81.486 E.01073
G2 X167.306 Y81.481 I.52 J-24.617 E.02055
G1 X167.563 Y80.83 E.01152
G1 X167.108 Y81.06 E.00838
G1 X166.614 Y81.102 E.00816
G1 X166.197 Y81.058 E.00691
G1 X165.875 Y80.904 E.00586
; WIPE_START
G1 X166.197 Y81.058 E-.13544
G1 X166.614 Y81.102 E-.15954
G1 X167.108 Y81.06 E-.18848
G1 X167.563 Y80.83 E-.19363
G1 X167.483 Y81.033 E-.08291
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.257 Y77.77 Z2.2 F30000
G1 X149.036 Y66.789
G1 X148.055 Y66.032
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.2 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.2 F30000
G1 X124.331 Y65.737
G1 X131.847 Y73.351
G1 X126.361 Y82.729
G1 X126.329 Y82.737
G1 X126.137 Y81.957
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.35597
G1 F6000
M204 S1000
G1 X125.773 Y82.061 E.005
; LINE_WIDTH: 0.33261
G1 X125.107 Y82.187 E.00833
; LINE_WIDTH: 0.31593
G1 X124.429 Y82.26 E.00793
; LINE_WIDTH: 0.30859
G1 X123.737 Y82.286 E.00785
; LINE_WIDTH: 0.31477
G1 X123.037 Y82.257 E.00812
; LINE_WIDTH: 0.33132
G1 X122.338 Y82.178 E.00861
; LINE_WIDTH: 0.3643
G1 X121.551 Y82.015 E.01089
; LINE_WIDTH: 0.38649
G1 X121.006 Y81.843 E.00824
; LINE_WIDTH: 0.40816
G1 X120.529 Y81.647 E.00787
; LINE_WIDTH: 0.44963
G1 X119.954 Y81.366 E.01082
; LINE_WIDTH: 0.47195
G1 X119.521 Y81.082 E.00922
; LINE_WIDTH: 0.48939
G1 X119.075 Y80.725 E.01056
; LINE_WIDTH: 0.50523
G1 X118.63 Y80.293 E.01185
; LINE_WIDTH: 0.52781
G1 X118.147 Y79.713 E.01509
; LINE_WIDTH: 0.54901
G1 X117.827 Y79.252 E.0117
; LINE_WIDTH: 0.57222
G1 X117.566 Y78.804 E.01127
; LINE_WIDTH: 0.59243
G1 X117.3 Y78.248 E.01391
; LINE_WIDTH: 0.60335
G1 X117.085 Y77.654 E.01452
; LINE_WIDTH: 0.61368
G1 X116.911 Y77.022 E.01531
; LINE_WIDTH: 0.62061
G1 X116.812 Y76.525 E.01199
; LINE_WIDTH: 0.62174
G1 X116.735 Y76.011 E.01233
; LINE_WIDTH: 0.625
G1 X116.68 Y75.465 E.01309
; LINE_WIDTH: 0.62812
G1 X116.647 Y74.885 E.01391
; LINE_WIDTH: 0.62886
G1 X116.636 Y74.272 E.01471
; LINE_WIDTH: 0.632
G3 X116.756 Y72.606 I10.838 J-.059 E.04031
; LINE_WIDTH: 0.62599
G1 X116.909 Y71.782 E.02002
; LINE_WIDTH: 0.62228
G1 X117.079 Y71.153 E.01546
; LINE_WIDTH: 0.61732
G1 X117.27 Y70.609 E.01357
; LINE_WIDTH: 0.61482
G1 X117.566 Y69.969 E.01651
; LINE_WIDTH: 0.60042
G1 X117.915 Y69.382 E.01562
; LINE_WIDTH: 0.5807
G1 X118.32 Y68.84 E.01495
; LINE_WIDTH: 0.55591
G1 X118.8 Y68.329 E.0148
; LINE_WIDTH: 0.5269
G1 X119.352 Y67.86 E.01446
; LINE_WIDTH: 0.49317
G1 X119.943 Y67.463 E.01326
; LINE_WIDTH: 0.45518
G1 X120.565 Y67.141 E.01199
; LINE_WIDTH: 0.41598
G1 X121.207 Y66.89 E.01075
; LINE_WIDTH: 0.37925
G1 X121.864 Y66.706 E.00963
; LINE_WIDTH: 0.34865
G1 X122.555 Y66.577 E.00909
; LINE_WIDTH: 0.32627
G1 X123.375 Y66.505 E.00991
; LINE_WIDTH: 0.31221
G1 X123.881 Y66.508 E.00582
; LINE_WIDTH: 0.31836
G1 X124.692 Y66.535 E.00951
; LINE_WIDTH: 0.3404
G1 X125.467 Y66.644 E.00985
; LINE_WIDTH: 0.37063
G1 X126.196 Y66.823 E.01035
; LINE_WIDTH: 0.40536
G1 X126.867 Y67.063 E.01081
; LINE_WIDTH: 0.44117
G1 X127.483 Y67.362 E.01136
; LINE_WIDTH: 0.47538
G1 X128.052 Y67.719 E.01203
; LINE_WIDTH: 0.50635
G1 X128.578 Y68.135 E.01285
; LINE_WIDTH: 0.53435
G1 X129.065 Y68.611 E.01381
; LINE_WIDTH: 0.55948
G1 X129.5 Y69.139 E.01453
; LINE_WIDTH: 0.58147
G1 X129.887 Y69.731 E.01564
; LINE_WIDTH: 0.60064
G1 X130.235 Y70.433 E.01792
; LINE_WIDTH: 0.61475
G1 X130.509 Y71.177 E.0186
; LINE_WIDTH: 0.62417
G1 X130.712 Y71.96 E.01925
; LINE_WIDTH: 0.62955
G1 X130.85 Y72.778 E.01991
; LINE_WIDTH: 0.63713
G1 X130.943 Y73.888 E.02709
G1 X130.944 Y74.857 E.02358
; LINE_WIDTH: 0.63462
G1 X130.915 Y75.397 E.01308
; LINE_WIDTH: 0.62855
G1 X130.817 Y76.257 E.02076
; LINE_WIDTH: 0.61965
G1 X130.657 Y77.076 E.01973
; LINE_WIDTH: 0.60725
G1 X130.427 Y77.857 E.01883
; LINE_WIDTH: 0.58952
G1 X130.122 Y78.594 E.01789
; LINE_WIDTH: 0.56612
G1 X129.743 Y79.278 E.01683
; LINE_WIDTH: 0.53773
G1 X129.291 Y79.901 E.0157
; LINE_WIDTH: 0.50609
G1 X128.789 Y80.443 E.01413
; LINE_WIDTH: 0.47526
G1 X128.251 Y80.906 E.01273
; LINE_WIDTH: 0.44536
G1 X127.673 Y81.3 E.01172
; LINE_WIDTH: 0.41449
G1 X127.061 Y81.623 E.01073
; LINE_WIDTH: 0.38402
G1 X126.425 Y81.875 E.00979
; LINE_WIDTH: 0.35597
G1 X126.194 Y81.941 E.00317
; WIPE_START
G1 X125.773 Y82.061 E-.16655
G1 X125.107 Y82.187 E-.25758
G1 X124.429 Y82.26 E-.25898
G1 X124.227 Y82.267 E-.07689
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.274 Y83.042 Z2.2 F30000
G1 X127.491 Y79.901
G1 X127.895 Y79.493
G1 X128.259 Y79.029
G1 X128.573 Y78.511
G1 X128.835 Y77.945
G1 X129.046 Y77.334
G1 X129.208 Y76.679
G1 X129.322 Y75.981
G1 X129.389 Y75.238
G1 X129.411 Y74.451
G1 X129.389 Y73.654
G1 X129.319 Y72.902
G1 X128.963 Y69.32
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S1000
G1 X129.301 Y69.834 E.01337
; LINE_WIDTH: 0.59672
G1 X129.633 Y70.493 E.01676
; LINE_WIDTH: 0.61527
G1 X129.894 Y71.19 E.01748
; LINE_WIDTH: 0.62651
G1 X130.079 Y71.881 E.01708
; LINE_WIDTH: 0.63308
G1 X130.218 Y72.639 E.01862
; LINE_WIDTH: 0.63563
G3 X130.34 Y74.374 I-12.366 J1.74 E.04222
; LINE_WIDTH: 0.63443
G1 X130.317 Y75.245 E.02109
; LINE_WIDTH: 0.62953
G1 X130.244 Y76.042 E.01923
; LINE_WIDTH: 0.62185
G1 X130.117 Y76.802 E.01827
; LINE_WIDTH: 0.60881
G1 X129.936 Y77.524 E.01728
; LINE_WIDTH: 0.59354
G1 X129.696 Y78.209 E.01639
; LINE_WIDTH: 0.57402
G1 X129.405 Y78.829 E.01496
; LINE_WIDTH: 0.55094
G1 X129.078 Y79.368 E.01318
; LINE_WIDTH: 0.52555
G1 X128.694 Y79.87 E.01258
; LINE_WIDTH: 0.49762
G1 X128.257 Y80.332 E.01196
; LINE_WIDTH: 0.46894
G1 X127.779 Y80.74 E.01112
; LINE_WIDTH: 0.43985
G1 X127.257 Y81.097 E.01044
; LINE_WIDTH: 0.40979
G1 X126.684 Y81.402 E.00995
; LINE_WIDTH: 0.37994
G1 X126.052 Y81.652 E.00962
; LINE_WIDTH: 0.35226
G1 X125.355 Y81.84 E.00943
; LINE_WIDTH: 0.32919
G1 X124.593 Y81.959 E.00938
; LINE_WIDTH: 0.31323
G1 X123.869 Y81.998 E.00836
; LINE_WIDTH: 0.3138
G1 X123.301 Y81.982 E.00655
; LINE_WIDTH: 0.32712
G1 X122.543 Y81.899 E.0092
; LINE_WIDTH: 0.346
G1 X121.906 Y81.761 E.00836
; LINE_WIDTH: 0.37604
G1 X121.288 Y81.562 E.0091
; LINE_WIDTH: 0.40816
G1 X120.693 Y81.297 E.00994
; LINE_WIDTH: 0.44963
G1 X120.183 Y81.004 E.00995
; LINE_WIDTH: 0.47509
G1 X119.6 Y80.568 E.01304
; LINE_WIDTH: 0.49664
G1 X119.117 Y80.107 E.01255
; LINE_WIDTH: 0.52136
G1 X118.671 Y79.576 E.01367
; LINE_WIDTH: 0.54877
G1 X118.325 Y79.054 E.01305
; LINE_WIDTH: 0.57222
G1 X118.062 Y78.565 E.01209
; LINE_WIDTH: 0.59243
G1 X117.835 Y78.048 E.01274
; LINE_WIDTH: 0.60335
G1 X117.643 Y77.493 E.01349
; LINE_WIDTH: 0.61358
G1 X117.488 Y76.888 E.01461
; LINE_WIDTH: 0.61872
G1 X117.352 Y76.111 E.01861
; LINE_WIDTH: 0.625
G1 X117.282 Y75.419 E.01657
; LINE_WIDTH: 0.62812
G3 X117.242 Y74.355 I18.613 J-1.226 E.02551
; LINE_WIDTH: 0.6317
G1 X117.256 Y73.825 E.0128
; LINE_WIDTH: 0.63259
G3 X117.437 Y72.193 I10.97 J.394 E.03967
; LINE_WIDTH: 0.62992
G1 X117.605 Y71.482 E.01754
; LINE_WIDTH: 0.62439
G1 X117.689 Y71.197 E.00708
; LINE_WIDTH: 0.61383
G1 X117.895 Y70.634 E.01403
; LINE_WIDTH: 0.60427
G1 X118.207 Y69.982 E.01663
; LINE_WIDTH: 0.58513
G1 X118.586 Y69.376 E.01591
; LINE_WIDTH: 0.56044
G1 X119.031 Y68.821 E.01514
; LINE_WIDTH: 0.53221
G1 X119.516 Y68.339 E.01381
; LINE_WIDTH: 0.50136
G1 X120.03 Y67.927 E.01247
; LINE_WIDTH: 0.46644
G1 X120.582 Y67.577 E.01149
; LINE_WIDTH: 0.42844
G1 X121.168 Y67.29 E.01049
; LINE_WIDTH: 0.3904
G1 X121.782 Y67.068 E.00952
; LINE_WIDTH: 0.35589
G1 X122.419 Y66.912 E.00866
; LINE_WIDTH: 0.32832
G1 X123.074 Y66.817 E.00802
; LINE_WIDTH: 0.31053
G1 X123.743 Y66.785 E.00765
; LINE_WIDTH: 0.30572
G1 X124.404 Y66.807 E.00743
; LINE_WIDTH: 0.32208
G1 X125.049 Y66.885 E.00771
; LINE_WIDTH: 0.34481
G1 X125.68 Y67.025 E.00825
; LINE_WIDTH: 0.37508
G1 X126.292 Y67.229 E.00902
; LINE_WIDTH: 0.40998
G1 X126.882 Y67.498 E.00994
; LINE_WIDTH: 0.44637
G1 X127.442 Y67.834 E.01096
; LINE_WIDTH: 0.48136
G1 X127.968 Y68.234 E.012
; LINE_WIDTH: 0.51276
G1 X128.454 Y68.695 E.013
; LINE_WIDTH: 0.54273
G1 X128.903 Y69.228 E.01434
; LINE_WIDTH: 0.57196
G1 X128.93 Y69.27 E.00109
M204 S10000
G1 X128.577 Y69.598 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X128.877 Y70.092 E.00978
G3 X129.411 Y71.359 I-5.392 J3.018 E.02332
G3 X129.799 Y75.23 I-11.617 J3.118 E.06614
G3 X129.233 Y78.049 I-9.592 J-.461 E.04884
G3 X125.924 Y81.294 I-5.2 J-1.992 E.08091
G3 X122.594 Y81.536 I-2.156 J-6.651 E.05706
G3 X118.733 Y78.806 I.966 J-5.461 E.08268
G3 X117.796 Y75.372 I7.256 J-3.825 E.06073
G3 X118.171 Y71.366 I11.437 J-.949 E.06845
G3 X118.655 Y70.196 I6.493 J2.001 E.02147
G3 X123.76 Y67.138 I5.078 J2.688 E.10586
G3 X127.685 Y68.577 I.123 J5.738 E.07242
G3 X128.52 Y69.527 I-4.2 J4.533 E.02146
G1 X128.539 Y69.551 E.00052
M204 S10000
G1 X128.216 Y69.825 F30000
G1 F6000
M204 S1000
G1 X128.519 Y70.31 E.00968
G3 X128.789 Y70.886 I-4.622 J2.519 E.01077
G3 X129.362 Y73.574 I-8.571 J3.23 E.0467
G3 X129.035 Y77.302 I-11.512 J.867 E.06361
G3 X126.806 Y80.392 I-5.185 J-1.391 E.06593
G3 X123.835 Y81.213 I-2.955 J-4.908 E.05282
G3 X120.59 Y80.248 I-.119 J-5.534 E.05822
G3 X118.782 Y77.936 I3.199 J-4.365 E.0503
G3 X118.222 Y75.333 I8.093 J-3.103 E.04525
G3 X118.575 Y71.508 I11.265 J-.89 E.06533
G1 X118.775 Y70.948 E.01007
G3 X123.78 Y67.566 I4.963 J1.95 E.10868
G3 X128.184 Y69.774 I.118 J5.262 E.08679
M204 S250
G1 X127.861 Y70.045 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G3 X128.616 Y71.636 I-4.123 J2.931 E.02785
G3 X128.957 Y75.206 I-10.895 J2.842 E.0567
G3 X128.437 Y77.774 I-8.698 J-.426 E.04139
G3 X125.924 Y80.398 I-4.436 J-1.732 E.05868
G3 X123.25 Y80.776 I-2.133 J-5.453 E.04289
G3 X119.405 Y78.29 I.348 J-4.755 E.07518
G3 X118.634 Y75.295 I6.771 J-3.338 E.04901
G3 X118.965 Y71.645 I10.864 J-.854 E.05796
G3 X121.73 Y68.396 I4.95 J1.411 E.06924
G3 X125.86 Y68.384 I2.079 J4.945 E.06673
G3 X127.826 Y69.996 I-2.122 J4.592 E.04045
; WIPE_START
M204 S1000
G1 X128.164 Y70.526 E-.23879
G1 X128.415 Y71.061 E-.22423
G1 X128.616 Y71.636 E-.23154
G1 X128.658 Y71.803 E-.06545
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.079 Y71.698 Z2.2 F30000
G1 X129.202 Y72.193
G1 X129.319 Y72.902
G1 X129.389 Y73.654
G1 X129.411 Y74.451
G1 X129.389 Y75.238
G1 X129.322 Y75.981
G1 X129.208 Y76.679
G1 X129.046 Y77.334
G1 X128.835 Y77.945
G1 X128.573 Y78.511
G1 X128.259 Y79.029
G1 X127.895 Y79.493
G1 X127.491 Y79.901
G1 X127.055 Y80.256
G1 X126.668 Y80.503
G1 X126.377 Y82.725
G1 X126.254 Y82.315
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X125.853 Y82.422 E.00702
G3 X121.47 Y82.394 I-2.125 J-10.184 E.07475
G1 X120.684 Y82.162 E.01387
G3 X119.728 Y81.73 I17.62 J-40.274 E.01775
G3 X117.42 Y79.503 I3.703 J-6.145 E.05475
G3 X116.407 Y77.109 I6.058 J-3.975 E.04423
G3 X116.33 Y71.98 I13.044 J-2.762 E.08737
G3 X117.498 Y69.114 I7.729 J1.478 E.05273
G3 X121.697 Y66.351 I5.59 J3.923 E.08713
G3 X123.357 Y66.145 I1.993 J9.29 E.02833
G1 X124.711 Y66.172 E.02292
G3 X127.669 Y66.979 I-.594 J7.997 E.05222
G3 X130.938 Y70.827 I-3.239 J6.065 E.0875
G3 X131.465 Y73.879 I-10.643 J3.408 E.05259
G3 X131.143 Y77.22 I-12.164 J.515 E.05698
G3 X130.551 Y78.823 I-7.662 J-1.919 E.02899
G1 X130.132 Y79.545 E.01413
G1 X129.636 Y80.2 E.0139
G3 X126.545 Y82.238 I-5.223 J-4.561 E.06343
G1 X126.312 Y82.3 E.00408
M204 S10000
G1 X126.364 Y82.729 F30000
G1 F6000
M204 S1000
G1 X125.946 Y82.841 E.00733
G3 X121.37 Y82.811 I-2.219 J-10.619 E.07802
G1 X120.535 Y82.565 E.01473
G1 X119.564 Y82.133 E.01799
G3 X115.988 Y77.195 I3.886 J-6.58 E.10615
G3 X115.909 Y71.896 I13.475 J-2.849 E.09027
G3 X117.144 Y68.87 I8.147 J1.561 E.05568
G3 X120.816 Y66.145 I5.842 J4.035 E.07879
G3 X123.344 Y65.716 I3.006 J10.055 E.04351
G1 X124.742 Y65.744 E.02367
G3 X127.866 Y66.598 I-.627 J8.433 E.05517
G3 X131.343 Y70.685 I-3.443 J6.451 E.09299
G3 X131.893 Y73.872 I-10.871 J3.517 E.05491
G3 X131.583 Y77.243 I-13.331 J.474 E.05745
G3 X130.203 Y80.2 I-7.816 J-1.848 E.05563
G3 X126.68 Y82.648 I-5.735 J-4.494 E.0737
G1 X126.422 Y82.714 E.0045
M204 S250
G1 X126.476 Y83.147 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G3 X121.274 Y83.214 I-2.743 J-11.011 E.08261
G1 X120.392 Y82.954 E.01447
G1 X119.37 Y82.499 E.01761
G3 X115.478 Y76.772 I4.112 J-6.98 E.11262
G3 X115.503 Y71.815 I14.135 J-2.407 E.07842
G3 X116.803 Y68.635 I8.552 J1.641 E.05443
G3 X120.687 Y65.751 I6.182 J4.269 E.07752
G3 X123.331 Y65.302 I3.144 J10.506 E.04232
G1 X124.772 Y65.331 E.02268
G3 X128.057 Y66.231 I-.66 J8.855 E.05395
G3 X131.734 Y70.549 I-3.639 J6.824 E.09141
G3 X132.307 Y73.864 I-11.241 J3.648 E.05314
G3 X131.985 Y77.341 I-13.534 J.502 E.05511
G3 X131.002 Y79.765 I-9.292 J-2.357 E.04131
G3 X126.533 Y83.131 I-6.56 J-4.061 E.09011
; WIPE_START
M204 S1000
G1 X125.625 Y83.335 E-.35398
G1 X124.724 Y83.448 E-.34495
G1 X124.563 Y83.455 E-.06108
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.537 Y83.026 Z2.2 F30000
G1 X116.013 Y77.225
G1 X115.722 Y73.696
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z1.8
G1 E.8 F1800
G1 F3600
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.2 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.2 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y92.55 Z2.2 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y92.39 E.10565
; WIPE_START
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y92.55 Z2.2 F30000
G1 X145.651 Y71.201
G1 X145.937 Y70.735
G1 X146 Y70.04
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X145.486 Y70.203 E.00911
G1 X144.976 Y70.707 E.01215
; LINE_WIDTH: 0.44625
G1 X143.929 Y72.411 E.03356
; LINE_WIDTH: 0.45012
G1 X142.882 Y74.115 E.03386
; LINE_WIDTH: 0.45399
G1 X141.835 Y75.82 E.03417
; LINE_WIDTH: 0.45786
G1 X140.789 Y77.524 E.03447
; LINE_WIDTH: 0.45901
G1 X140.478 Y78.03 E.01026
; LINE_WIDTH: 0.47181
G2 X140.036 Y78.76 I8.569 J5.689 E.01519
; LINE_WIDTH: 0.44999
G1 X138.106 Y81.909 E.06251
G1 X136.879 Y81.909 E.02076
G1 X136.879 Y77.909 E.0677
G2 X136.876 Y77 I-116.699 J-.032 E.01538
; LINE_WIDTH: 0.44341
G1 X136.876 Y66.867 E.16888
G1 X137.298 Y66.867 E.00703
G1 X137.298 Y77 E.16888
; LINE_WIDTH: 0.45612
G1 X137.314 Y77.255 E.00438
G1 X137.47 Y77.697 E.00804
; LINE_WIDTH: 0.44999
G1 X137.89 Y78.181 E.01085
G1 X138.45 Y78.439 E.01044
G1 X138.974 Y78.49 E.00892
G1 X139.586 Y78.298 E.01085
; LINE_WIDTH: 0.47181
G1 X139.961 Y78.005 E.00847
G1 X140.105 Y77.8 E.00446
; LINE_WIDTH: 0.45901
G1 X141.155 Y76.098 E.03456
; LINE_WIDTH: 0.45514
G1 X142.205 Y74.396 E.03426
; LINE_WIDTH: 0.45127
G1 X143.255 Y72.694 E.03395
; LINE_WIDTH: 0.4474
G1 X144.305 Y70.991 E.03365
; LINE_WIDTH: 0.44353
G1 X144.617 Y70.486 E.00989
; LINE_WIDTH: 0.44239
G1 X144.62 Y70.481 E.00011
; LINE_WIDTH: 0.44999
G2 X146.857 Y66.87 I-868.396 J-540.416 E.07189
G1 X148.198 Y66.87 E.02269
G1 X148.198 Y67.731 E.01457
G1 X148.198 Y69.731 E.03385
G2 X148.201 Y71.498 I227.257 J.46 E.0299
; LINE_WIDTH: 0.44341
G1 X148.201 Y81.912 E.17357
G1 X147.779 Y81.912 E.00703
G1 X147.779 Y71.498 E.17357
; LINE_WIDTH: 0.44999
G1 X147.607 Y70.8 E.01216
G1 X147.186 Y70.315 E.01087
G1 X146.625 Y70.058 E.01045
G1 X146.098 Y70.009 E.00895
G1 X146.057 Y70.022 E.00074
M204 S10000
G1 X146.07 Y70.456 F30000
G1 F6000
M204 S1000
G1 X145.702 Y70.573 E.00654
G1 X145.34 Y70.925 E.00855
G1 X138.346 Y82.338 E.22654
G1 X136.451 Y82.338 E.03207
G1 X136.451 Y66.442 E.26904
G1 X137.723 Y66.442 E.02154
G1 X137.723 Y76.442 E.16925
G2 X137.739 Y77.18 I4.251 J.279 E.01252
G1 X137.847 Y77.494 E.00561
G1 X138.145 Y77.837 E.00769
G1 X138.48 Y78.002 E.00633
G1 X138.938 Y78.063 E.00783
G1 X139.372 Y77.927 E.00769
G1 X139.632 Y77.714 E.00568
G1 X139.737 Y77.573 E.00299
G1 X146.618 Y66.442 E.22149
G1 X148.626 Y66.442 E.03399
G1 X148.626 Y67.731 E.02182
G1 X148.626 Y82.338 E.24722
G1 X147.354 Y82.338 E.02154
G1 X147.354 Y71.498 E.18347
G1 X147.229 Y71.004 E.00862
G1 X146.931 Y70.66 E.0077
G1 X146.595 Y70.495 E.00633
G1 X146.136 Y70.436 E.00785
G1 X146.127 Y70.438 E.00015
M204 S10000
G1 X146.14 Y70.873 F30000
G1 F6000
M204 S1000
G1 X145.917 Y70.943 E.00396
G1 X145.704 Y71.151 E.00503
G1 X138.586 Y82.766 E.23058
G1 X136.022 Y82.766 E.04339
G1 X136.022 Y66.013 E.28355
G1 X138.152 Y66.013 E.03604
G1 X138.152 Y77 E.18596
G1 X138.225 Y77.291 E.00507
G1 X138.4 Y77.493 E.00452
G1 X138.597 Y77.59 E.00372
G1 X138.903 Y77.636 E.00523
G1 X139.158 Y77.556 E.00452
G1 X139.373 Y77.347 E.00507
G1 X146.379 Y66.013 E.22553
G1 X149.055 Y66.013 E.04528
G1 X149.055 Y67.731 E.02908
G1 X149.055 Y82.766 E.25447
G1 X146.925 Y82.766 E.03604
G1 X146.925 Y71.498 E.19072
G1 X146.852 Y71.207 E.00507
G1 X146.677 Y71.005 E.00453
G1 X146.479 Y70.908 E.00373
G1 X146.198 Y70.866 E.0048
M204 S250
G1 X146.208 Y71.275 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X146.056 Y71.368 E.00281
G1 X138.817 Y83.18 E.21805
G1 X135.609 Y83.18 E.0505
G1 X135.609 Y65.6 E.27672
G1 X138.565 Y65.6 E.04654
G1 X138.565 Y77 E.17945
G1 X138.646 Y77.16 E.00282
G1 X138.868 Y77.224 E.00363
G1 X139.021 Y77.13 E.00282
G1 X146.149 Y65.6 E.21337
G1 X149.468 Y65.6 E.05225
G1 X149.468 Y67.731 E.03355
G1 X149.468 Y83.18 E.24317
G1 X146.512 Y83.18 E.04654
G1 X146.512 Y71.498 E.18388
G1 X146.431 Y71.337 E.00283
G1 X146.266 Y71.291 E.0027
; WIPE_START
M204 S1000
G1 X146.056 Y71.368 E-.08506
G1 X145.128 Y72.883 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.759 Y72.657 Z2.2 F30000
G1 X145.937 Y70.735
G1 X147.784 Y70.382
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S1000
G1 X147.784 Y67.284 E.04877
G1 X147.087 Y67.284 E.01097
G1 X145.555 Y69.753 E.04574
G1 X146.103 Y69.597 E.00897
G1 X146.793 Y69.679 E.01094
G1 X147.401 Y69.964 E.01056
G1 X147.744 Y70.338 E.00798
M204 S10000
G1 X147.386 Y69.513 F30000
G1 F6000
M204 S1000
G1 X147.386 Y67.682 E.02881
G1 X147.295 Y67.705 E.00148
G1 X146.351 Y69.225 E.02816
G1 X146.908 Y69.295 E.00884
G1 X147.331 Y69.488 E.00731
M204 S10000
G1 X147.022 Y68.877 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S1000
G1 X146.951 Y68.918 E.00121
G1 X147.01 Y68.952 E.00102
G1 E-.8 F1800
M204 S10000
G1 X142.388 Y75.026 Z2.2 F30000
G1 X139.568 Y78.732 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
M73 P86 R10
G1 X139.052 Y78.893 E.00851
G1 X138.281 Y78.818 E.01219
G1 X137.674 Y78.532 E.01055
G1 X137.298 Y78.122 E.00877
G1 X137.293 Y81.495 E.05311
G1 X137.874 Y81.495 E.00915
G1 X139.537 Y78.783 E.05008
M204 S10000
G1 X138.766 Y79.278 F30000
G1 F6000
M204 S1000
G1 X138.233 Y79.214 E.00844
G1 X137.695 Y78.987 E.00919
G1 X137.692 Y81.03 E.03215
G1 X138.734 Y79.329 E.03139
M204 S10000
G1 X138.122 Y79.555 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S1000
G2 X138.113 Y79.643 I-.025 J.042 E.00317
; CHANGE_LAYER
; Z_HEIGHT: 1.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X138.071 Y79.643 E-.16312
G1 X138.046 Y79.599 E-.19896
G1 X138.071 Y79.555 E-.19898
G1 X138.122 Y79.555 E-.19893
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 19/58
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.2 I.911 J.807 P1  F30000
G1 X145.937 Y70.735 Z2.2
G1 X146.945 Y71.019
G1 X149.036 Y77.236
G1 X161.978 Y74.486
G1 X168.164 Y82.747
G1 X172.355 Y72.28
G1 X178.267 Y71.024
G1 X180.615 Y70.525
G1 X185.376 Y69.514
G1 X187.725 Y73.547
G1 X189.107 Y73.547
G1 X189.421 Y73.543
G1 X189.718 Y73.533
G1 X189.998 Y73.516
G1 X190.259 Y73.492
G1 X190.503 Y73.46
G1 X190.732 Y73.42
G1 X190.946 Y73.37
G1 X191.156 Y73.305
G1 X191.512 Y73.152
G1 X191.858 Y72.944
G1 X192.185 Y72.691
G1 X200.283 Y65.746
G1 X199.552 Y66.501
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
M204 S1000
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.3 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.3 F30000
G1 X208.887 Y69.747
G1 X208.865 Y80.032
G1 X208.501 Y79.6
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 19 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer19 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.3 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.3 F30000
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.3 F30000
G1 X192.634 Y92.321
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.3 F30000
G1 X179.68 Y82.747
G1 X179.716 Y81.848
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X179.166 Y81.848 E.01199
G1 X179.166 Y66.931 E.32454
G1 X179.716 Y66.931 E.01199
G1 X179.716 Y67.207 E.00599
G1 X179.716 Y81.788 E.31725
M204 S10000
G1 X180.206 Y82.338 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X178.676 Y82.338 E.0259
G1 X178.676 Y66.442 E.26904
G1 X180.206 Y66.442 E.0259
G1 X180.206 Y67.207 E.01295
G1 X180.206 Y82.278 E.25508
M204 S10000
G1 X180.635 Y82.766 F30000
G1 F6000
M204 S1000
G1 X178.247 Y82.766 E.04041
G1 X178.247 Y66.013 E.28355
G1 X180.635 Y66.013 E.04041
G1 X180.635 Y67.207 E.0202
G1 X180.635 Y82.706 E.26233
M204 S250
G1 X181.048 Y83.18 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X177.834 Y83.18 E.0506
G1 X177.834 Y65.6 E.27672
G1 X181.048 Y65.6 E.0506
G1 X181.048 Y67.207 E.0253
G1 X181.048 Y83.12 E.25048
; WIPE_START
M204 S1000
G1 X179.049 Y83.157 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.049 Y82.747 Z2.3 F30000
G1 X180.615 Y81.984
G1 X185.376 Y78.422
G1 X187.725 Y75.134
G1 X193.875 Y72.062
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54611
G1 F6000
M204 S1000
G2 X194.55 Y71.131 I-10.854 J-8.569 E.02383
; LINE_WIDTH: 0.55718
G1 X194.88 Y70.661 E.01214
; LINE_WIDTH: 0.582185
G1 X195.045 Y70.437 E.00617
; LINE_WIDTH: 0.60719
G1 X195.211 Y70.213 E.00644
; LINE_WIDTH: 0.62971
G1 X195.545 Y69.734 E.01404
; LINE_WIDTH: 0.63992
G2 X196.564 Y68.221 I-84.883 J-58.216 E.04455
; LINE_WIDTH: 0.63471
G1 X197.314 Y67.083 E.03303
; LINE_WIDTH: 0.6132
G1 X197.402 Y66.952 E.00369
G1 X198.094 Y66.952 E.01618
G1 X197.811 Y67.405 E.01249
; LINE_WIDTH: 0.63471
G1 X197.076 Y68.558 E.03311
; LINE_WIDTH: 0.63992
G3 X196.037 Y70.092 I-28.868 J-18.438 E.04528
; LINE_WIDTH: 0.62971
G1 X195.664 Y70.58 E.01475
; LINE_WIDTH: 0.60719
G1 X195.472 Y70.797 E.0067
; LINE_WIDTH: 0.58124
G1 X195.28 Y71.014 E.0064
; LINE_WIDTH: 0.55529
G1 X194.834 Y71.409 E.01257
; LINE_WIDTH: 0.54611
G3 X193.926 Y72.031 I-7.635 J-10.174 E.0228
G1 E-.8 F1800
M204 S10000
G1 X193.599 Y74.31 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X193.646 Y74.385 E.00149
G2 X191.677 Y74.3 I-2.33 J30.976 E.03337
; LINE_WIDTH: 0.475475
G1 X191.269 Y74.287 E.00731
; LINE_WIDTH: 0.50096
G1 X190.862 Y74.274 E.00772
G1 X190.99 Y74.236 E.00253
; LINE_WIDTH: 0.48376
G1 X191.609 Y74.019 E.01198
; LINE_WIDTH: 0.44999
G1 X192.173 Y73.729 E.01074
G1 X192.464 Y73.532 E.00595
G1 X192.997 Y73.07 E.01193
; LINE_WIDTH: 0.45054
G1 X193.39 Y72.622 E.0101
G1 X193.261 Y72.933 E.00569
; LINE_WIDTH: 0.44999
G1 X193.212 Y73.183 E.00431
G1 X193.272 Y73.783 E.0102
G1 X193.568 Y74.259 E.0095
; WIPE_START
G1 X193.646 Y74.385 E-.05632
G1 X192.841 Y74.331 E-.30645
G1 X191.796 Y74.303 E-.39723
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X191.781 Y75.139 Z2.3 F30000
G1 X191.687 Y75.138
G1 X191.058 Y75.134
G1 X187.725 Y75.134
G1 X186.826 Y77.754
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X186.826 Y80.355 E.05659
; LINE_WIDTH: 0.58603
G1 X186.842 Y80.621 E.00594
G1 X186.935 Y80.797 E.00444
; LINE_WIDTH: 0.540684
G1 X187.027 Y80.974 E.00409
; LINE_WIDTH: 0.495337
G1 X187.12 Y81.15 E.00373
; LINE_WIDTH: 0.44999
G1 X187.61 Y81.622 E.01151
; LINE_WIDTH: 0.491915
G1 X187.983 Y81.744 E.0073
; LINE_WIDTH: 0.53384
G1 X188.357 Y81.867 E.00795
G1 X187.944 Y81.888 E.00835
; LINE_WIDTH: 0.491915
G1 X187.532 Y81.909 E.00767
; LINE_WIDTH: 0.44999
G1 X186.214 Y81.909 E.02232
G1 X186.214 Y81.417 E.00834
; LINE_WIDTH: 0.49077
G1 X186.234 Y81.063 E.00657
; LINE_WIDTH: 0.53155
G1 X186.254 Y80.709 E.00714
; LINE_WIDTH: 0.57233
G1 X186.275 Y80.355 E.00771
G1 X186.275 Y76.355 E.08703
G2 X186.254 Y75.529 I-4.825 J-.294 E.01801
; LINE_WIDTH: 0.53155
G1 X186.234 Y75.291 E.00481
; LINE_WIDTH: 0.49077
G1 X186.214 Y75.053 E.00442
; LINE_WIDTH: 0.44999
G1 X186.214 Y73.628 E.02413
; LINE_WIDTH: 0.495337
G1 X186.236 Y73.495 E.00252
; LINE_WIDTH: 0.540684
G1 X186.259 Y73.362 E.00276
; LINE_WIDTH: 0.58603
G2 X186.275 Y72.915 I-1.15 J-.265 E.01004
; LINE_WIDTH: 0.57233
G1 X186.275 Y66.931 E.13018
G1 X186.826 Y66.931 E.01199
G1 X186.826 Y72.915 E.13018
; LINE_WIDTH: 0.58603
G1 X186.842 Y73.18 E.00594
G1 X186.894 Y73.278 E.00246
; LINE_WIDTH: 0.540684
G1 X186.945 Y73.375 E.00226
; LINE_WIDTH: 0.495337
G1 X186.997 Y73.473 E.00207
; LINE_WIDTH: 0.44999
G1 X187.283 Y73.918 E.00896
G1 X187.664 Y74.211 E.00813
G1 X187.948 Y74.276 E.00493
; LINE_WIDTH: 0.411405
G1 X188.232 Y74.34 E.00449
G1 X187.948 Y74.405 E.00449
; LINE_WIDTH: 0.44999
G1 X187.664 Y74.47 E.00493
G1 X187.283 Y74.762 E.00813
G1 X186.997 Y75.208 E.00896
; LINE_WIDTH: 0.49077
G1 X186.94 Y75.394 E.00361
; LINE_WIDTH: 0.53155
G1 X186.883 Y75.58 E.00392
; LINE_WIDTH: 0.57233
G1 X186.826 Y75.766 E.00424
G1 X186.826 Y77.694 E.04195
; WIPE_START
G1 X186.826 Y79.694 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X187.725 Y75.134 Z2.3 F30000
G1 X191.058 Y75.134
G1 X191.687 Y75.138
G1 X192.258 Y75.148
G1 X192.77 Y75.166
G1 X193.225 Y75.191
G1 X193.623 Y75.224
G1 X193.968 Y75.265
G1 X194.268 Y75.318
G1 X194.532 Y75.389
G1 X194.928 Y75.557
G1 X195.19 Y75.72
G1 X195.62 Y75.032
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.39724
G1 F6000
M204 S1000
G3 X196.212 Y75.275 I-1.148 J3.645 E.0095
; LINE_WIDTH: 0.39846
G1 X196.759 Y75.603 E.0095
; LINE_WIDTH: 0.439805
G1 X196.976 Y75.834 E.00524
; LINE_WIDTH: 0.48115
G1 X197.193 Y76.065 E.00576
; LINE_WIDTH: 0.51021
G1 X197.336 Y76.288 E.00511
; LINE_WIDTH: 0.53927
G1 X197.48 Y76.51 E.00541
; LINE_WIDTH: 0.58192
G1 X197.701 Y77.043 E.01277
; LINE_WIDTH: 0.61045
G1 X197.836 Y77.653 E.01453
; LINE_WIDTH: 0.63163
G1 X197.878 Y78.375 E.01743
; LINE_WIDTH: 0.63865
G1 X197.841 Y78.913 E.01314
; LINE_WIDTH: 0.64477
G3 X197.567 Y79.896 I-3.882 J-.55 E.0252
; LINE_WIDTH: 0.64302
G1 X197.326 Y80.354 E.01271
; LINE_WIDTH: 0.62896
G1 X196.938 Y80.85 E.01511
; LINE_WIDTH: 0.60303
G1 X196.449 Y81.266 E.01473
; LINE_WIDTH: 0.55802
G1 X196.023 Y81.466 E.00999
G1 X195.485 Y81.617 E.01183
; LINE_WIDTH: 0.595894
G1 X195.282 Y81.63 E.00461
; LINE_WIDTH: 0.633767
G1 X195.079 Y81.643 E.00491
; LINE_WIDTH: 0.67164
G1 X194.877 Y81.656 E.00522
G1 X195.05 Y81.56 E.0051
; LINE_WIDTH: 0.633767
G1 X195.224 Y81.464 E.0048
; LINE_WIDTH: 0.595894
G1 X195.398 Y81.368 E.0045
; LINE_WIDTH: 0.55802
G1 X195.841 Y81.085 E.01115
; LINE_WIDTH: 0.57607
G1 X196.288 Y80.697 E.01297
; LINE_WIDTH: 0.61751
G1 X196.593 Y80.351 E.01086
; LINE_WIDTH: 0.63174
G1 X196.875 Y79.909 E.01263
; LINE_WIDTH: 0.64477
G1 X197.129 Y79.272 E.01688
G1 X197.247 Y78.653 E.01551
; LINE_WIDTH: 0.63271
G1 X197.269 Y78.018 E.01534
; LINE_WIDTH: 0.61329
G1 X197.209 Y77.426 E.01392
; LINE_WIDTH: 0.58935
G1 X197.057 Y76.851 E.01333
; LINE_WIDTH: 0.54655
G1 X196.921 Y76.564 E.00661
; LINE_WIDTH: 0.51242
G1 X196.784 Y76.276 E.00618
; LINE_WIDTH: 0.47829
G1 X196.629 Y76.061 E.00478
; LINE_WIDTH: 0.437765
G1 X196.474 Y75.847 E.00435
; LINE_WIDTH: 0.39724
G1 X196.038 Y75.362 E.00967
G1 X195.667 Y75.069 E.00702
G1 E-.8 F1800
M204 S10000
G1 X193.915 Y74.031 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X193.951 Y74.089 E.00115
; LINE_WIDTH: 0.48657
G1 X194.17 Y74.234 E.00482
; LINE_WIDTH: 0.52315
G1 X194.388 Y74.379 E.0052
; LINE_WIDTH: 0.53006
G1 X194.632 Y74.43 E.005
; LINE_WIDTH: 0.57932
G2 X195.441 Y74.61 I1.637 J-5.451 E.01828
; LINE_WIDTH: 0.53621
G1 X195.623 Y74.64 E.00375
; LINE_WIDTH: 0.4931
G1 X195.805 Y74.67 E.00344
; LINE_WIDTH: 0.44999
G1 X196.309 Y74.866 E.00915
G1 X196.972 Y75.253 E.013
G1 X197.431 Y75.664 E.01042
G3 X198.18 Y76.922 I-3.272 J2.801 E.0249
G1 X198.343 Y77.614 E.01204
G1 X198.396 Y78.408 E.01347
G3 X197.487 Y81.006 I-4.083 J.029 E.04751
G1 X197.129 Y81.37 E.00865
G1 X196.671 Y81.699 E.00954
G1 X196.208 Y81.915 E.00866
G1 X195.597 Y82.088 E.01075
G3 X192.379 Y82.337 I-2.943 J-17.055 E.05471
G1 X185.785 Y82.338 E.1116
G1 X185.785 Y66.442 E.26904
G1 X187.315 Y66.442 E.0259
G1 X187.315 Y72.915 E.10956
G1 X187.393 Y73.31 E.00682
G1 X187.596 Y73.626 E.00635
G1 X187.866 Y73.833 E.00576
G1 X188.358 Y73.956 E.00858
G2 X190.875 Y73.806 I.511 J-12.649 E.04275
G1 X191.453 Y73.617 E.0103
G1 X192.184 Y73.208 E.01417
G1 X192.716 Y72.746 E.01193
G2 X194.472 Y70.403 I-18.002 J-15.321 E.04959
G1 X197.13 Y66.442 E.08075
G1 X199.016 Y66.442 E.03191
G1 X197.954 Y68.137 E.03385
G3 X196.457 Y70.397 I-32.948 J-20.208 E.04589
G3 X194.656 Y72.122 I-5.532 J-3.97 E.04245
G1 X194.015 Y72.532 E.01288
G1 X193.764 Y72.832 E.00661
G1 X193.638 Y73.228 E.00705
G1 X193.681 Y73.653 E.00723
G1 X193.883 Y73.98 E.00651
M204 S10000
G1 X194.231 Y73.752 F30000
G1 F6000
M204 S1000
G1 X194.248 Y73.78 E.00057
G1 X194.511 Y73.93 E.00513
G3 X195.937 Y74.262 I-2.272 J12.998 E.02479
G1 X196.5 Y74.481 E.01022
G1 X197.226 Y74.905 E.01422
G1 X197.8 Y75.419 E.01305
G1 X198.247 Y76.023 E.0127
G1 X198.567 Y76.705 E.01276
G1 X198.737 Y77.373 E.01167
G3 X198.824 Y78.435 I-9.283 J1.299 E.01805
G3 X197.772 Y81.341 I-4.49 J.018 E.05339
G1 X197.355 Y81.748 E.00987
G1 X196.885 Y82.072 E.00966
G1 X196.357 Y82.318 E.00986
G1 X195.689 Y82.507 E.01176
G3 X192.383 Y82.766 I-3.035 J-17.495 E.0562
G1 X185.356 Y82.766 E.11893
G1 X185.356 Y66.013 E.28355
G1 X187.744 Y66.013 E.04041
G1 X187.744 Y72.915 E.11681
G1 X187.753 Y73.02 E.0018
G1 X187.909 Y73.333 E.00591
G1 X188.068 Y73.455 E.00339
G1 X188.357 Y73.527 E.00505
G2 X190.764 Y73.392 I.487 J-12.825 E.04085
G1 X191.257 Y73.236 E.00876
G1 X191.903 Y72.885 E.01244
G1 X192.435 Y72.423 E.01193
G2 X194.119 Y70.16 I-18.625 J-15.619 E.04776
G1 X196.902 Y66.013 E.08453
G1 X199.79 Y66.013 E.04888
G1 X198.728 Y67.708 E.03385
G3 X196.8 Y70.653 I-39.592 J-23.817 E.05959
G3 X194.349 Y72.82 I-6.174 J-4.516 E.0558
G1 X194.198 Y72.953 E.0034
G1 X194.085 Y73.17 E.00415
G1 X194.083 Y73.503 E.00565
G1 X194.2 Y73.7 E.00387
M204 S250
G1 X194.535 Y73.483 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X194.639 Y73.536 E.00183
G3 X196.684 Y74.11 I-1.09 J7.81 E.03354
G1 X197.47 Y74.569 E.01432
G1 X198.108 Y75.139 E.01346
G1 X198.604 Y75.81 E.01312
G1 X198.958 Y76.565 E.01313
G1 X199.137 Y77.271 E.01147
G3 X199.237 Y78.461 I-8.742 J1.329 E.01881
G1 X199.197 Y79.091 E.00994
G1 X199.055 Y79.794 E.01128
G1 X198.82 Y80.452 E.011
G1 X198.491 Y81.067 E.01098
G1 X198.085 Y81.614 E.01072
G1 X197.619 Y82.068 E.01025
G1 X197.092 Y82.432 E.01008
G1 X196.502 Y82.707 E.01024
G1 X195.778 Y82.911 E.01184
G3 X192.388 Y83.179 I-3.123 J-17.921 E.0536
G1 X184.943 Y83.18 E.11719
G1 X184.943 Y65.6 E.27672
G1 X188.157 Y65.6 E.0506
G1 X188.157 Y72.915 E.11514
G1 X188.211 Y73.051 E.0023
G1 X188.357 Y73.114 E.0025
G2 X190.631 Y72.998 I.487 J-12.824 E.03589
G1 X191.068 Y72.868 E.00718
G1 X191.665 Y72.544 E.01068
G1 X192.189 Y72.085 E.01096
G2 X193.779 Y69.926 I-19.105 J-15.732 E.04224
G1 X196.681 Y65.6 E.082
G1 X200.537 Y65.6 E.06068
G1 X198.414 Y68.99 E.06296
G3 X196.632 Y71.52 I-18.991 J-11.48 E.04874
G1 X196.034 Y72.125 E.0134
G3 X194.548 Y73.185 I-6.948 J-8.168 E.02877
G1 X194.475 Y73.318 E.00238
G1 X194.515 Y73.426 E.00181
; WIPE_START
M204 S1000
G1 X194.639 Y73.536 E-.06284
G1 X195.196 Y73.634 E-.21482
G1 X195.713 Y73.758 E-.20234
G1 X196.193 Y73.91 E-.19109
G1 X196.41 Y73.998 E-.08891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X196.244 Y74.396 Z2.3 F30000
G1 X187.725 Y75.134
G1 X187.725 Y80.987
G1 X188.143 Y80.987
G1 X188.143 Y81.338
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X187.828 Y81.252 E.00552
G1 X187.481 Y80.918 E.00816
G1 X187.331 Y80.535 E.00696
G1 X187.315 Y80.355 E.00306
G1 X187.315 Y75.766 E.07767
G1 X187.393 Y75.371 E.00682
G1 X187.596 Y75.055 E.00635
G1 X187.866 Y74.848 E.00576
G1 X188.358 Y74.725 E.00858
G1 X190.358 Y74.727 E.03385
G3 X193.629 Y74.814 I.607 J38.861 E.05541
; LINE_WIDTH: 0.48657
G1 X193.958 Y74.841 E.00605
; LINE_WIDTH: 0.52315
G1 X194.286 Y74.869 E.00653
; LINE_WIDTH: 0.56649
G1 X194.899 Y75.045 E.01372
; LINE_WIDTH: 0.57932
G3 X195.233 Y75.225 I-.095 J.578 E.00852
; LINE_WIDTH: 0.53621
G1 X195.387 Y75.343 E.00394
; LINE_WIDTH: 0.4931
G1 X195.54 Y75.462 E.00361
; LINE_WIDTH: 0.44999
G3 X196.492 Y76.69 I-2.101 J2.612 E.02655
G3 X196.579 Y79.285 I-3.77 J1.425 E.04474
G1 X196.364 Y79.773 E.00902
G1 X196.004 Y80.284 E.01059
G1 X195.524 Y80.717 E.01095
G3 X194.54 Y81.201 I-1.938 J-2.698 E.01863
G1 X193.925 Y81.333 E.01066
G3 X190.199 Y81.395 I-2.696 J-50.185 E.06308
G1 X188.357 Y81.397 E.03118
G1 X188.201 Y81.354 E.00273
M204 S10000
G1 X188.252 Y80.939 F30000
G1 F6000
M204 S1000
G1 X188.045 Y80.883 E.00362
G1 X187.841 Y80.687 E.0048
G1 X187.744 Y80.355 E.00585
G1 X187.744 Y75.766 E.07767
G3 X188.068 Y75.226 I.681 J.041 E.01109
G1 X188.36 Y75.153 E.0051
G1 X190.36 Y75.156 E.03385
G3 X193.6 Y75.241 I.592 J38.926 E.05488
G3 X194.997 Y75.623 I-.242 J3.635 E.02467
G1 X195.487 Y75.984 E.0103
G1 X195.827 Y76.368 E.0087
G1 X196.089 Y76.835 E.00905
G1 X196.248 Y77.342 E.009
G1 X196.332 Y78.074 E.01246
G1 X196.301 Y78.587 E.0087
G1 X196.176 Y79.141 E.00961
G1 X195.947 Y79.634 E.0092
G1 X195.655 Y80.029 E.00832
G1 X195.293 Y80.356 E.00825
G3 X193.897 Y80.905 I-1.913 J-2.815 E.0256
G3 X190.199 Y80.966 I-2.665 J-49.482 E.06262
G1 X188.357 Y80.968 E.03118
G1 X188.31 Y80.955 E.00083
M204 S250
G1 X188.357 Y80.555 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X188.189 Y80.463 E.00301
G1 X188.157 Y80.355 E.00177
G1 X188.157 Y75.766 E.07223
G1 X188.211 Y75.63 E.0023
G1 X188.36 Y75.567 E.00254
G1 X191.685 Y75.571 E.05234
G3 X194.16 Y75.739 I.112 J16.663 E.03909
G1 X194.703 Y75.932 E.00907
G3 X195.524 Y76.656 I-1.099 J2.073 E.01739
G1 X195.764 Y77.152 E.00868
G1 X195.893 Y77.682 E.00859
G3 X195.884 Y78.589 I-4.116 J.413 E.01431
G1 X195.746 Y79.095 E.00825
G3 X195.071 Y80.007 I-2.098 J-.846 E.01806
G3 X193.87 Y80.493 I-1.673 J-2.41 E.02055
G3 X190.198 Y80.553 I-2.726 J-54.366 E.05782
G1 X188.417 Y80.554 E.02804
; WIPE_START
M204 S1000
G1 X188.189 Y80.463 E-.0932
G1 X188.157 Y80.355 E-.04268
G1 X188.157 Y78.713 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X187.725 Y78.713 Z2.3 F30000
G1 X187.725 Y80.987
G1 X194.877 Y81.656
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S1000
G1 X194.545 Y81.72 E.00868
; LINE_WIDTH: 0.62207
G1 X194.212 Y81.783 E.00802
; LINE_WIDTH: 0.5725
G1 X193.651 Y81.83 E.01227
; LINE_WIDTH: 0.55022
G1 X193.044 Y81.854 E.01267
; LINE_WIDTH: 0.54592
G1 X192.374 Y81.864 E.0139
; LINE_WIDTH: 0.54068
G1 X192.199 Y81.865 E.00357
; LINE_WIDTH: 0.53768
G1 X190.199 Y81.866 E.04078
; LINE_WIDTH: 0.53568
G1 X188.358 Y81.867 E.0374
; LINE_WIDTH: 0.53384
G1 X188.357 Y81.867 E.00003
; WIPE_START
G1 X188.358 Y81.867 E-.00057
G1 X190.199 Y81.866 E-.69973
G1 X190.357 Y81.866 E-.05969
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X194.471 Y80.797 Z2.3 F30000
G1 X194.937 Y80.606
G1 X195.355 Y80.34
G1 X195.713 Y80
G1 X196 Y79.593
G1 X196.201 Y79.135
G1 X196.317 Y78.639
G1 X196.354 Y78.113
G1 X196.326 Y77.641
G1 X196.239 Y77.196
G1 X196.089 Y76.779
G1 X195.875 Y76.398
G1 X195.606 Y76.064
G1 X195.289 Y75.782
G1 X194.928 Y75.557
G1 X194.532 Y75.389
G1 X190.862 Y74.274
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.50096
G1 F6000
M204 S1000
G1 X190.798 Y74.278 E.00121
; LINE_WIDTH: 0.49122
G1 X190.407 Y74.302 E.00726
; LINE_WIDTH: 0.44249
G1 X190.017 Y74.326 E.00651
; LINE_WIDTH: 0.39376
G1 X189.411 Y74.339 E.0089
; LINE_WIDTH: 0.3662
G1 X188.361 Y74.34 E.0143
; LINE_WIDTH: 0.37282
G1 X188.232 Y74.34 E.00179
G1 E-.8 F1800
M204 S10000
G1 X193.684 Y72.257 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.45054
G1 F6000
M204 S1000
G1 X193.39 Y72.622 E.00795
G1 E-.8 F1800
M204 S10000
G1 X192.839 Y73.808 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5442
G1 F6000
M204 S1000
G2 X192.842 Y73.917 I-.028 J.055 E.00525
G1 E-.8 F1800
M204 S10000
G1 X186.63 Y75.016 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S1000
G1 X186.957 Y74.507 E.00965
G3 X187.154 Y74.34 I.576 J.483 E.00414
G1 X186.959 Y74.177 E.00405
G1 X186.63 Y73.688 E.0094
G1 X186.63 Y74.956 E.02022
G1 E-.8 F1800
M204 S10000
G1 X186.743 Y81.358 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57486
G1 F6000
M204 S1000
G2 X186.748 Y81.47 I-.03 J.057 E.00595
; WIPE_START
G1 X186.674 Y81.478 E-.20014
G1 X186.64 Y81.418 E-.18662
G1 X186.674 Y81.358 E-.18663
G1 X186.743 Y81.358 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X185.376 Y78.182 Z2.3 F30000
G1 X180.615 Y67.13
G1 X180.143 Y66.032
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.3 F30000
G1 X181.348 Y56.444
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.3 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.3 F30000
G1 X172.918 Y66.032
G1 X170.723 Y70.121
G1 X162.636 Y70.121
G1 X162.215 Y70.645
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X162.581 Y70.872 E.0073
G1 X163.079 Y70.959 E.00855
; LINE_WIDTH: 0.497195
G1 X163.502 Y70.982 E.00797
; LINE_WIDTH: 0.5444
G1 X163.926 Y71.006 E.00876
G1 X163.58 Y71.194 E.00813
; LINE_WIDTH: 0.497195
G1 X163.235 Y71.382 E.00739
; LINE_WIDTH: 0.44999
G1 X162.912 Y71.771 E.00855
G1 X162.727 Y72.342 E.01017
; LINE_WIDTH: 0.4722
G1 X162.797 Y73.007 E.0119
G1 X163.491 Y74.882 E.03561
; LINE_WIDTH: 0.44985
G1 X164.186 Y76.758 E.03384
; LINE_WIDTH: 0.4275
G1 X164.88 Y78.633 E.03207
; LINE_WIDTH: 0.40515
G1 X165.28 Y79.714 E.01747
; LINE_WIDTH: 0.4044
G1 X165.397 Y79.972 E.00427
; LINE_WIDTH: 0.44999
G1 X165.708 Y80.363 E.00845
G1 X166.331 Y80.66 E.01167
G2 X167.002 Y80.645 I.304 J-1.438 E.01147
G1 X167.588 Y80.34 E.01118
; LINE_WIDTH: 0.45984
G1 X167.888 Y79.998 E.00788
G1 X168.011 Y79.733 E.00506
; LINE_WIDTH: 0.47269
G1 X168.719 Y77.862 E.03564
; LINE_WIDTH: 0.49801
G1 X169.427 Y75.992 E.03764
; LINE_WIDTH: 0.52333
G1 X170.135 Y74.121 E.03964
; LINE_WIDTH: 0.53814
G1 X170.55 Y73.027 E.02387
; LINE_WIDTH: 0.55128
G1 X170.618 Y72.813 E.00471
G1 X170.611 Y72.668 E.00305
; LINE_WIDTH: 0.517517
G1 X170.603 Y72.522 E.00285
; LINE_WIDTH: 0.483753
G1 X170.595 Y72.377 E.00266
; LINE_WIDTH: 0.44999
G1 X170.432 Y71.818 E.00985
G1 X170.115 Y71.409 E.00876
; LINE_WIDTH: 0.485785
G1 X169.623 Y71.202 E.0098
; LINE_WIDTH: 0.52158
G1 X169.13 Y70.995 E.01056
G1 X169.71 Y70.977 E.01145
; LINE_WIDTH: 0.485785
G1 X170.289 Y70.959 E.01063
; LINE_WIDTH: 0.44999
G1 X170.798 Y70.868 E.00876
G1 X171.301 Y70.555 E.01002
; LINE_WIDTH: 0.486633
G1 X171.438 Y70.382 E.00405
; LINE_WIDTH: 0.523277
G1 X171.575 Y70.209 E.00437
; LINE_WIDTH: 0.55992
G1 X171.712 Y70.036 E.00469
; LINE_WIDTH: 0.5738
G1 X172.436 Y68.172 E.04363
; LINE_WIDTH: 0.58167
G2 X172.915 Y66.936 I-177.652 J-69.604 E.02933
G1 X173.108 Y66.936 E.00426
G1 X173.522 Y66.936 E.00916
G2 X172.631 Y69.179 I322.528 J129.367 E.05341
; LINE_WIDTH: 0.56778
G1 X172.213 Y70.233 E.02445
; LINE_WIDTH: 0.55992
G2 X172.124 Y70.505 I1.951 J.791 E.00611
; LINE_WIDTH: 0.523217
G1 X172.044 Y70.755 E.00519
; LINE_WIDTH: 0.486603
G1 X171.963 Y71.004 E.00482
; LINE_WIDTH: 0.44999
G1 X171.368 Y72.493 E.02713
; LINE_WIDTH: 0.494065
G1 X171.2 Y72.853 E.00742
; LINE_WIDTH: 0.53814
G1 X171.032 Y73.213 E.00811
G1 X170.3 Y75.075 E.04081
; LINE_WIDTH: 0.51281
G1 X169.568 Y76.936 E.03881
; LINE_WIDTH: 0.48749
G1 X168.837 Y78.797 E.03681
; LINE_WIDTH: 0.46217
G1 X168.409 Y79.886 E.02036
; LINE_WIDTH: 0.45984
G2 X168.083 Y80.695 I14.436 J6.276 E.01511
; LINE_WIDTH: 0.44999
G1 X167.597 Y81.909 E.02212
G1 X165.768 Y81.909 E.03095
G2 X165.11 Y80.258 I-26.011 J9.418 E.03009
; LINE_WIDTH: 0.42113
G1 X164.934 Y79.845 E.00709
; LINE_WIDTH: 0.41461
G1 X164.218 Y77.977 E.03106
; LINE_WIDTH: 0.43696
G1 X163.503 Y76.11 E.03282
; LINE_WIDTH: 0.45931
G1 X162.787 Y74.242 E.03459
; LINE_WIDTH: 0.4722
G2 X162.076 Y72.428 I-46.648 J17.252 E.03469
; LINE_WIDTH: 0.44999
G1 X161.493 Y70.933 E.02717
; LINE_WIDTH: 0.47587
G1 X161.358 Y70.551 E.00727
; LINE_WIDTH: 0.50175
G1 X161.223 Y70.169 E.00768
; LINE_WIDTH: 0.52463
G1 X160.508 Y68.301 E.03975
; LINE_WIDTH: 0.53733
G2 X159.975 Y66.914 I-121.17 J45.803 E.03029
G1 X160.533 Y66.914 E.01137
G2 X161.288 Y68.96 I179.136 J-64.994 E.04443
; LINE_WIDTH: 0.51444
G1 X161.673 Y70 E.0216
; LINE_WIDTH: 0.51468
G1 X161.794 Y70.268 E.00573
G1 X161.929 Y70.41 E.00381
; LINE_WIDTH: 0.482335
G1 X162.063 Y70.551 E.00356
; LINE_WIDTH: 0.44999
G1 X162.164 Y70.614 E.002
M204 S10000
G1 X162.46 Y70.304 F30000
G1 F6000
M204 S1000
G1 X162.726 Y70.469 E.0053
G1 X163.079 Y70.53 E.00606
G1 X170.289 Y70.53 E.12203
G1 X170.65 Y70.466 E.00621
G1 X171.006 Y70.244 E.0071
G1 X171.255 Y69.876 E.00753
G1 X172.576 Y66.442 E.06228
G1 X173.108 Y66.442 E.009
G1 X174.252 Y66.442 E.01937
G1 X167.887 Y82.338 E.28981
G1 X165.475 Y82.338 E.04082
G1 X159.284 Y66.442 E.28873
G1 X160.864 Y66.442 E.02673
G1 X161.547 Y68.321 E.03385
G2 X162.108 Y69.867 I68.526 J-24.037 E.02783
G1 X162.359 Y70.242 E.00763
G1 X162.409 Y70.272 E.00099
M204 S10000
G1 X162.705 Y69.963 F30000
G1 F6000
M204 S1000
G1 X162.871 Y70.066 E.00332
G1 X163.079 Y70.102 E.00356
G1 X170.289 Y70.102 E.12203
G1 X170.408 Y70.09 E.00203
G1 X170.711 Y69.933 E.00576
G1 X170.858 Y69.717 E.00443
G1 X172.281 Y66.013 E.06716
G1 X173.108 Y66.013 E.01399
G1 X174.885 Y66.013 E.03009
G1 X168.177 Y82.766 E.30544
G1 X165.182 Y82.766 E.05069
G1 X158.657 Y66.013 E.3043
G1 X161.164 Y66.013 E.04242
G1 X162.503 Y69.698 E.06636
G1 X162.654 Y69.93 E.00469
M204 S250
G1 X162.941 Y69.633 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X163.079 Y69.688 E.00234
G1 X170.289 Y69.688 E.11349
G1 X170.358 Y69.676 E.0011
G1 X170.474 Y69.563 E.00255
G1 X171.997 Y65.6 E.06684
G1 X173.108 Y65.6 E.01748
G1 X175.496 Y65.6 E.0376
G1 X168.457 Y83.18 E.29808
G1 X164.9 Y83.18 E.056
G1 X158.052 Y65.6 E.29697
G1 X161.453 Y65.6 E.05354
G1 X162.82 Y69.359 E.06296
G2 X162.907 Y69.583 I.646 J-.123 E.00381
; WIPE_START
M204 S1000
G1 X163.079 Y69.688 E-.07642
G1 X164.878 Y69.688 E-.68358
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.878 Y70.121 Z2.3 F30000
G1 X163.286 Y71.868
G1 X165.921 Y79.108
G1 X166.184 Y79.832
G1 X166.157 Y80.115
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X165.978 Y80.03 E.00334
G1 X165.744 Y79.761 E.00603
G1 X165.656 Y79.578 E.00345
G1 X163.21 Y72.856 E.12106
G1 X163.153 Y72.388 E.00798
G1 X163.284 Y71.983 E.0072
G1 X163.513 Y71.708 E.00606
G1 X164.008 Y71.475 E.00927
G1 X164.188 Y71.459 E.00306
G1 X169.13 Y71.459 E.08365
G1 X169.828 Y71.727 E.01266
G1 X170.053 Y72.017 E.00621
G1 X170.168 Y72.413 E.00698
G1 X170.107 Y72.863 E.00768
G1 X167.611 Y79.584 E.12135
G1 X167.52 Y79.77 E.0035
G1 X167.31 Y80.014 E.00545
G1 X166.815 Y80.247 E.00927
G1 X166.419 Y80.24 E.00669
G1 X166.211 Y80.141 E.00391
M204 S10000
G1 X166.184 Y79.607 F30000
G1 F6000
M204 S1000
G1 X166.059 Y79.431 E.00366
G1 X163.612 Y72.71 E.12106
G1 X163.579 Y72.434 E.0047
G1 X163.71 Y72.118 E.0058
G1 X163.791 Y72.034 E.00197
G1 X164.082 Y71.897 E.00546
G1 X164.188 Y71.887 E.0018
G1 X169.13 Y71.887 E.08365
G1 X169.541 Y72.045 E.00745
G1 X169.673 Y72.216 E.00365
G1 X169.741 Y72.449 E.00411
G1 X169.705 Y72.714 E.00452
G1 X167.209 Y79.435 E.12135
G1 X167.032 Y79.688 E.00523
G1 X166.74 Y79.825 E.00546
G1 X166.508 Y79.821 E.00394
G1 X166.248 Y79.697 E.00487
G1 X166.219 Y79.656 E.00085
M204 S250
G1 X166.509 Y79.376 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X166.447 Y79.29 E.00167
G1 X164.001 Y72.568 E.11259
G1 X164.015 Y72.401 E.00264
G1 X164.154 Y72.304 E.00267
G1 X164.188 Y72.301 E.00054
G1 X169.13 Y72.301 E.07779
G1 X169.29 Y72.381 E.00282
G1 X169.325 Y72.541 E.00258
G1 X169.317 Y72.57 E.00047
G1 X166.82 Y79.296 E.11293
G1 X166.684 Y79.414 E.00283
G1 X166.568 Y79.389 E.00188
; WIPE_START
M204 S1000
G1 X166.447 Y79.29 E-.05928
G1 X165.817 Y77.557 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.41 Y77.705 Z2.3 F30000
G1 X166.184 Y79.832
G1 X167.081 Y79.834
G1 X170.039 Y71.868
G1 X169.13 Y70.995
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S1000
G1 X164.188 Y70.995 E.09762
; LINE_WIDTH: 0.5444
G1 X163.926 Y71.006 E.00542
G1 E-.8 F1800
M204 S10000
G1 X162.384 Y72.056 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S1000
G1 X162.548 Y71.562 E.00843
G1 X162.7 Y71.339 E.00437
G1 X162.395 Y71.244 E.00517
G1 X161.949 Y70.947 E.00868
G1 X162.362 Y72 E.01832
G1 E-.8 F1800
M204 S10000
G1 X169.972 Y71.422 Z2.3 F30000
G1 X170.682 Y71.369 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S1000
G1 X170.845 Y71.654 E.00603
G1 X171.004 Y72.201 E.01042
G1 X171.506 Y70.948 E.02472
G1 X170.995 Y71.266 E.01102
G1 X170.739 Y71.35 E.00494
; WIPE_START
G1 X170.995 Y71.266 E-.10257
G1 X171.506 Y70.948 E-.22853
G1 X171.086 Y71.996 E-.42891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.614 Y78.792 Z2.3 F30000
G1 X167.081 Y79.834 Z2.3
G1 X165.821 Y80.878
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S1000
G1 X166.058 Y81.486 E.01073
G2 X167.306 Y81.481 I.52 J-24.617 E.02055
G1 X167.563 Y80.83 E.01152
G1 X167.108 Y81.06 E.00838
G1 X166.614 Y81.102 E.00816
G1 X166.197 Y81.058 E.00691
G1 X165.875 Y80.904 E.00586
; WIPE_START
G1 X166.197 Y81.058 E-.13544
G1 X166.614 Y81.102 E-.15954
G1 X167.108 Y81.06 E-.18848
G1 X167.563 Y80.83 E-.19363
G1 X167.483 Y81.033 E-.08291
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.257 Y77.77 Z2.3 F30000
G1 X149.036 Y66.789
G1 X148.055 Y66.032
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.3 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.3 F30000
G1 X124.331 Y65.737
G1 X131.847 Y73.351
G1 X126.361 Y82.729
G1 X126.33 Y82.737
G1 X126.137 Y81.957
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.35597
G1 F6000
M204 S1000
G1 X125.773 Y82.061 E.005
; LINE_WIDTH: 0.33261
G1 X125.107 Y82.187 E.00833
; LINE_WIDTH: 0.31593
G1 X124.429 Y82.26 E.00793
; LINE_WIDTH: 0.30859
G1 X123.737 Y82.286 E.00785
; LINE_WIDTH: 0.31477
G1 X123.037 Y82.257 E.00812
; LINE_WIDTH: 0.33132
G1 X122.338 Y82.178 E.00861
; LINE_WIDTH: 0.3643
G1 X121.551 Y82.015 E.01089
; LINE_WIDTH: 0.38649
G1 X121.006 Y81.843 E.00824
; LINE_WIDTH: 0.40816
G1 X120.529 Y81.647 E.00787
; LINE_WIDTH: 0.44963
G1 X119.954 Y81.366 E.01082
; LINE_WIDTH: 0.47195
G1 X119.521 Y81.082 E.00922
; LINE_WIDTH: 0.48939
G1 X119.075 Y80.725 E.01057
; LINE_WIDTH: 0.50523
G1 X118.63 Y80.293 E.01184
; LINE_WIDTH: 0.52781
G1 X118.147 Y79.713 E.01509
; LINE_WIDTH: 0.54902
G1 X117.827 Y79.252 E.0117
; LINE_WIDTH: 0.57223
G1 X117.566 Y78.804 E.01127
; LINE_WIDTH: 0.59242
G1 X117.301 Y78.248 E.01391
; LINE_WIDTH: 0.60335
G1 X117.085 Y77.654 E.01453
; LINE_WIDTH: 0.61368
G1 X116.911 Y77.022 E.01531
; LINE_WIDTH: 0.62061
G1 X116.812 Y76.525 E.01199
; LINE_WIDTH: 0.62174
G1 X116.735 Y76.011 E.01233
; LINE_WIDTH: 0.625
G1 X116.68 Y75.465 E.01309
; LINE_WIDTH: 0.62812
G1 X116.647 Y74.885 E.01391
; LINE_WIDTH: 0.62886
G1 X116.636 Y74.272 E.01471
; LINE_WIDTH: 0.632
G3 X116.756 Y72.606 I10.837 J-.059 E.04031
; LINE_WIDTH: 0.62599
G1 X116.909 Y71.782 E.02002
; LINE_WIDTH: 0.62227
G1 X117.079 Y71.153 E.01546
; LINE_WIDTH: 0.61731
G1 X117.27 Y70.609 E.01357
; LINE_WIDTH: 0.61482
G1 X117.566 Y69.969 E.01651
; LINE_WIDTH: 0.60042
G1 X117.915 Y69.382 E.01562
; LINE_WIDTH: 0.58069
G1 X118.32 Y68.84 E.01495
; LINE_WIDTH: 0.55592
G1 X118.799 Y68.329 E.0148
; LINE_WIDTH: 0.5269
G1 X119.352 Y67.86 E.01446
; LINE_WIDTH: 0.49317
G1 X119.943 Y67.463 E.01326
; LINE_WIDTH: 0.45518
G1 X120.565 Y67.141 E.01199
; LINE_WIDTH: 0.41598
G1 X121.207 Y66.89 E.01075
; LINE_WIDTH: 0.37925
G1 X121.864 Y66.706 E.00963
; LINE_WIDTH: 0.34865
G1 X122.555 Y66.577 E.00909
; LINE_WIDTH: 0.32627
G1 X123.375 Y66.505 E.00991
; LINE_WIDTH: 0.31221
G1 X123.881 Y66.508 E.00582
; LINE_WIDTH: 0.31836
G1 X124.692 Y66.535 E.00951
; LINE_WIDTH: 0.34039
G1 X125.467 Y66.644 E.00985
; LINE_WIDTH: 0.37063
G1 X126.196 Y66.823 E.01035
; LINE_WIDTH: 0.40537
G1 X126.867 Y67.063 E.01081
; LINE_WIDTH: 0.44117
G1 X127.483 Y67.362 E.01136
; LINE_WIDTH: 0.47538
G1 X128.052 Y67.719 E.01203
; LINE_WIDTH: 0.50634
G1 X128.578 Y68.135 E.01284
; LINE_WIDTH: 0.53435
G1 X129.065 Y68.611 E.01381
; LINE_WIDTH: 0.55948
G1 X129.5 Y69.139 E.01453
; LINE_WIDTH: 0.58147
G1 X129.887 Y69.731 E.01564
; LINE_WIDTH: 0.60064
G1 X130.235 Y70.433 E.01792
; LINE_WIDTH: 0.61475
G1 X130.509 Y71.177 E.0186
; LINE_WIDTH: 0.62417
G1 X130.712 Y71.96 E.01925
; LINE_WIDTH: 0.62955
G1 X130.85 Y72.778 E.01991
; LINE_WIDTH: 0.63713
G1 X130.943 Y73.888 E.02709
G1 X130.944 Y74.857 E.02358
; LINE_WIDTH: 0.63462
G1 X130.915 Y75.397 E.01308
; LINE_WIDTH: 0.62855
G1 X130.817 Y76.257 E.02076
; LINE_WIDTH: 0.61965
G1 X130.657 Y77.076 E.01973
; LINE_WIDTH: 0.60725
G1 X130.427 Y77.857 E.01883
; LINE_WIDTH: 0.58952
G1 X130.122 Y78.594 E.01789
; LINE_WIDTH: 0.56612
G1 X129.743 Y79.278 E.01683
; LINE_WIDTH: 0.53772
G1 X129.291 Y79.901 E.0157
; LINE_WIDTH: 0.50607
G1 X128.789 Y80.443 E.01413
; LINE_WIDTH: 0.47527
G1 X128.251 Y80.906 E.01273
; LINE_WIDTH: 0.44536
G1 X127.673 Y81.3 E.01172
; LINE_WIDTH: 0.41449
G1 X127.061 Y81.623 E.01073
; LINE_WIDTH: 0.38402
G1 X126.425 Y81.875 E.00979
; LINE_WIDTH: 0.35597
G1 X126.195 Y81.941 E.00317
; WIPE_START
G1 X125.773 Y82.061 E-.16662
G1 X125.107 Y82.187 E-.25758
G1 X124.429 Y82.26 E-.25898
G1 X124.227 Y82.267 E-.07682
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.274 Y83.042 Z2.3 F30000
G1 X127.491 Y79.901
G1 X127.895 Y79.493
G1 X128.259 Y79.029
G1 X128.573 Y78.511
G1 X128.835 Y77.945
G1 X129.046 Y77.334
G1 X129.208 Y76.679
G1 X129.322 Y75.981
G1 X129.389 Y75.238
G1 X129.411 Y74.451
G1 X129.389 Y73.654
G1 X129.319 Y72.902
G1 X128.963 Y69.32
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S1000
G1 X129.301 Y69.834 E.01337
; LINE_WIDTH: 0.59672
G1 X129.633 Y70.493 E.01676
; LINE_WIDTH: 0.61527
G1 X129.894 Y71.19 E.01748
; LINE_WIDTH: 0.62651
G1 X130.079 Y71.881 E.01708
; LINE_WIDTH: 0.63308
G1 X130.218 Y72.639 E.01862
; LINE_WIDTH: 0.63563
G3 X130.34 Y74.374 I-12.366 J1.74 E.04222
; LINE_WIDTH: 0.63443
G1 X130.317 Y75.245 E.02109
; LINE_WIDTH: 0.62953
G1 X130.244 Y76.042 E.01923
; LINE_WIDTH: 0.62185
G1 X130.117 Y76.802 E.01827
; LINE_WIDTH: 0.60881
G1 X129.936 Y77.524 E.01728
; LINE_WIDTH: 0.59354
G1 X129.696 Y78.209 E.01638
; LINE_WIDTH: 0.57401
G1 X129.405 Y78.829 E.01496
; LINE_WIDTH: 0.55095
G1 X129.078 Y79.368 E.01318
; LINE_WIDTH: 0.52553
G1 X128.694 Y79.87 E.01257
; LINE_WIDTH: 0.49762
G1 X128.257 Y80.332 E.01197
; LINE_WIDTH: 0.46894
G1 X127.779 Y80.74 E.01112
; LINE_WIDTH: 0.43985
G1 X127.257 Y81.097 E.01044
; LINE_WIDTH: 0.40979
G1 X126.684 Y81.402 E.00995
; LINE_WIDTH: 0.37995
G1 X126.052 Y81.652 E.00962
; LINE_WIDTH: 0.35227
G1 X125.355 Y81.84 E.00943
; LINE_WIDTH: 0.3292
G1 X124.593 Y81.959 E.00938
; LINE_WIDTH: 0.31322
G1 X123.869 Y81.998 E.00836
; LINE_WIDTH: 0.3138
G1 X123.301 Y81.982 E.00655
; LINE_WIDTH: 0.32712
G1 X122.543 Y81.899 E.0092
; LINE_WIDTH: 0.346
G1 X121.906 Y81.761 E.00836
; LINE_WIDTH: 0.37604
G1 X121.288 Y81.562 E.0091
; LINE_WIDTH: 0.40816
G1 X120.693 Y81.297 E.00994
; LINE_WIDTH: 0.44963
G1 X120.183 Y81.004 E.00995
; LINE_WIDTH: 0.47508
G1 X119.6 Y80.568 E.01304
; LINE_WIDTH: 0.49664
G1 X119.117 Y80.107 E.01255
; LINE_WIDTH: 0.52136
G1 X118.671 Y79.576 E.01367
; LINE_WIDTH: 0.54877
G1 X118.325 Y79.054 E.01305
; LINE_WIDTH: 0.57223
G1 X118.062 Y78.565 E.01208
; LINE_WIDTH: 0.59242
G1 X117.835 Y78.048 E.01274
; LINE_WIDTH: 0.60335
G1 X117.643 Y77.493 E.0135
; LINE_WIDTH: 0.61358
G1 X117.488 Y76.888 E.01461
; LINE_WIDTH: 0.61872
G1 X117.352 Y76.111 E.01861
; LINE_WIDTH: 0.625
G1 X117.282 Y75.419 E.01657
; LINE_WIDTH: 0.62812
G3 X117.242 Y74.355 I18.613 J-1.226 E.02551
; LINE_WIDTH: 0.6317
G1 X117.256 Y73.825 E.0128
; LINE_WIDTH: 0.63259
G3 X117.437 Y72.193 I10.971 J.394 E.03967
; LINE_WIDTH: 0.62991
G1 X117.605 Y71.482 E.01754
; LINE_WIDTH: 0.62438
G1 X117.689 Y71.197 E.00708
; LINE_WIDTH: 0.61383
G1 X117.895 Y70.634 E.01403
; LINE_WIDTH: 0.60427
G1 X118.207 Y69.982 E.01663
; LINE_WIDTH: 0.58513
G1 X118.586 Y69.376 E.01591
; LINE_WIDTH: 0.56044
G1 X119.031 Y68.821 E.01514
; LINE_WIDTH: 0.53221
G1 X119.516 Y68.339 E.01381
; LINE_WIDTH: 0.50138
G1 X120.03 Y67.927 E.01247
; LINE_WIDTH: 0.46646
G1 X120.582 Y67.577 E.01149
; LINE_WIDTH: 0.42844
G1 X121.168 Y67.29 E.01049
; LINE_WIDTH: 0.3904
G1 X121.782 Y67.068 E.00952
; LINE_WIDTH: 0.35589
G1 X122.419 Y66.912 E.00866
; LINE_WIDTH: 0.32832
G1 X123.074 Y66.817 E.00802
; LINE_WIDTH: 0.31053
G1 X123.743 Y66.785 E.00765
; LINE_WIDTH: 0.30572
G1 X124.404 Y66.807 E.00743
; LINE_WIDTH: 0.32208
G1 X125.049 Y66.885 E.00771
; LINE_WIDTH: 0.34481
G1 X125.68 Y67.025 E.00825
; LINE_WIDTH: 0.37507
G1 X126.292 Y67.229 E.00902
; LINE_WIDTH: 0.40998
G1 X126.882 Y67.498 E.00994
; LINE_WIDTH: 0.44638
G1 X127.442 Y67.834 E.01097
; LINE_WIDTH: 0.48135
G1 X127.968 Y68.234 E.012
; LINE_WIDTH: 0.51276
G1 X128.454 Y68.695 E.013
; LINE_WIDTH: 0.54273
G1 X128.903 Y69.228 E.01434
; LINE_WIDTH: 0.57196
G1 X128.93 Y69.27 E.00109
M204 S10000
G1 X128.577 Y69.598 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X128.877 Y70.092 E.00978
G3 X129.411 Y71.359 I-5.392 J3.019 E.02332
G3 X129.799 Y75.23 I-11.617 J3.118 E.06614
G3 X129.233 Y78.049 I-9.593 J-.461 E.04884
G3 X125.924 Y81.294 I-5.2 J-1.992 E.08091
G3 X122.594 Y81.536 I-2.156 J-6.65 E.05707
G3 X118.733 Y78.806 I.966 J-5.461 E.08268
G3 X117.796 Y75.372 I7.256 J-3.825 E.06073
G3 X118.171 Y71.366 I11.437 J-.949 E.06845
G3 X118.655 Y70.196 I6.494 J2.001 E.02147
G3 X123.76 Y67.138 I5.078 J2.688 E.10586
G3 X127.685 Y68.577 I.123 J5.738 E.07242
G3 X128.52 Y69.527 I-4.2 J4.533 E.02146
G1 X128.539 Y69.551 E.00052
M204 S10000
G1 X128.216 Y69.825 F30000
G1 F6000
M204 S1000
G1 X128.519 Y70.31 E.00968
G3 X128.789 Y70.886 I-4.622 J2.519 E.01077
G3 X129.362 Y73.574 I-8.571 J3.23 E.0467
G3 X129.035 Y77.302 I-11.512 J.867 E.06361
G3 X126.806 Y80.392 I-5.184 J-1.39 E.06593
G3 X123.835 Y81.213 I-2.955 J-4.908 E.05282
G3 X120.59 Y80.248 I-.119 J-5.534 E.05822
G3 X118.782 Y77.936 I3.199 J-4.365 E.0503
G3 X118.222 Y75.333 I8.093 J-3.103 E.04525
G3 X118.575 Y71.508 I11.265 J-.89 E.06533
G1 X118.775 Y70.948 E.01007
G3 X123.78 Y67.566 I4.963 J1.95 E.10868
G3 X128.184 Y69.774 I.118 J5.262 E.08679
M204 S250
G1 X127.861 Y70.045 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G3 X128.616 Y71.636 I-4.123 J2.931 E.02785
G3 X128.957 Y75.206 I-10.895 J2.842 E.0567
G3 X128.437 Y77.774 I-8.698 J-.426 E.04139
G3 X125.924 Y80.398 I-4.436 J-1.732 E.05868
G3 X123.25 Y80.776 I-2.133 J-5.453 E.04289
G3 X119.405 Y78.29 I.348 J-4.755 E.07518
G3 X118.634 Y75.295 I6.771 J-3.338 E.04901
G3 X118.965 Y71.645 I10.864 J-.854 E.05796
G3 X121.73 Y68.396 I4.95 J1.411 E.06924
G3 X125.86 Y68.384 I2.08 J4.945 E.06673
G3 X127.826 Y69.996 I-2.122 J4.592 E.04045
; WIPE_START
M204 S1000
G1 X128.164 Y70.526 E-.23879
G1 X128.415 Y71.061 E-.22423
G1 X128.616 Y71.636 E-.23154
G1 X128.658 Y71.803 E-.06545
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.079 Y71.698 Z2.3 F30000
G1 X129.202 Y72.193
G1 X129.319 Y72.902
G1 X129.389 Y73.654
G1 X129.411 Y74.451
G1 X129.389 Y75.238
G1 X129.322 Y75.981
G1 X129.208 Y76.679
G1 X129.046 Y77.334
G1 X128.835 Y77.945
G1 X128.573 Y78.511
G1 X128.259 Y79.029
G1 X127.895 Y79.493
G1 X127.491 Y79.901
G1 X127.055 Y80.256
G1 X126.668 Y80.503
G1 X126.377 Y82.725
G1 X126.254 Y82.315
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X125.853 Y82.422 E.00702
G3 X121.47 Y82.394 I-2.125 J-10.184 E.07475
G1 X120.684 Y82.162 E.01387
G3 X119.728 Y81.73 I17.613 J-40.261 E.01775
G3 X117.42 Y79.503 I3.703 J-6.146 E.05475
G3 X116.407 Y77.109 I6.057 J-3.975 E.04423
G3 X116.33 Y71.98 I13.043 J-2.762 E.08737
G3 X117.498 Y69.114 I7.729 J1.478 E.05273
G3 X121.697 Y66.351 I5.59 J3.923 E.08713
G3 X123.357 Y66.145 I1.993 J9.29 E.02833
G1 X124.711 Y66.172 E.02292
G3 X127.669 Y66.979 I-.594 J7.997 E.05222
G3 X130.938 Y70.827 I-3.239 J6.065 E.0875
G3 X131.465 Y73.879 I-10.643 J3.408 E.05259
G3 X131.143 Y77.22 I-12.164 J.515 E.05698
G3 X130.551 Y78.823 I-7.662 J-1.919 E.02899
G1 X130.132 Y79.545 E.01413
G1 X129.636 Y80.2 E.0139
G3 X126.545 Y82.238 I-5.223 J-4.561 E.06343
G1 X126.312 Y82.3 E.00408
M204 S10000
G1 X126.364 Y82.729 F30000
G1 F6000
M204 S1000
G1 X125.946 Y82.841 E.00733
G3 X121.37 Y82.811 I-2.219 J-10.619 E.07803
G1 X120.535 Y82.565 E.01473
G1 X119.564 Y82.133 E.01799
G3 X115.988 Y77.195 I3.887 J-6.58 E.10615
G3 X115.909 Y71.896 I13.475 J-2.849 E.09027
G3 X117.144 Y68.87 I8.148 J1.561 E.05568
G3 X120.815 Y66.145 I5.842 J4.035 E.07878
G3 X123.344 Y65.716 I3.006 J10.055 E.04351
G1 X124.742 Y65.744 E.02367
G3 X127.866 Y66.598 I-.628 J8.434 E.05517
G3 X131.343 Y70.685 I-3.443 J6.451 E.09299
G3 X131.893 Y73.872 I-10.871 J3.517 E.05491
G3 X131.583 Y77.243 I-13.331 J.474 E.05745
G3 X130.203 Y80.2 I-7.816 J-1.848 E.05563
G3 X126.68 Y82.648 I-5.734 J-4.494 E.0737
G1 X126.422 Y82.714 E.0045
M204 S250
G1 X126.476 Y83.147 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G3 X121.274 Y83.214 I-2.743 J-11.011 E.08262
G1 X120.392 Y82.954 E.01447
G1 X119.37 Y82.499 E.01761
G3 X115.478 Y76.772 I4.112 J-6.98 E.11262
G3 X115.503 Y71.815 I14.135 J-2.407 E.07842
G3 X116.803 Y68.635 I8.552 J1.641 E.05443
G3 X120.687 Y65.751 I6.182 J4.269 E.07752
G3 X123.331 Y65.302 I3.145 J10.506 E.04232
G1 X124.772 Y65.331 E.02268
G3 X128.057 Y66.231 I-.66 J8.855 E.05395
G3 X131.734 Y70.549 I-3.639 J6.824 E.09141
G3 X132.307 Y73.864 I-11.241 J3.648 E.05314
G3 X131.985 Y77.341 I-13.534 J.502 E.05511
G3 X131.002 Y79.765 I-9.292 J-2.357 E.04131
G3 X126.534 Y83.131 I-6.56 J-4.061 E.09011
; WIPE_START
M204 S1000
G1 X125.625 Y83.335 E-.35405
G1 X124.724 Y83.448 E-.34495
G1 X124.564 Y83.455 E-.061
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.538 Y83.026 Z2.3 F30000
G1 X116.013 Y77.225
G1 X115.722 Y73.695
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z1.9
G1 E.8 F1800
G1 F3600
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
M73 P86 R9
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.3 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.3 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y92.55 Z2.3 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y92.39 E.10565
; WIPE_START
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y92.55 Z2.3 F30000
G1 X145.651 Y71.201
G1 X145.937 Y70.735
G1 X146 Y70.04
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X145.486 Y70.203 E.00911
G1 X144.976 Y70.707 E.01215
; LINE_WIDTH: 0.44625
G1 X143.929 Y72.411 E.03356
; LINE_WIDTH: 0.45012
G1 X142.882 Y74.115 E.03386
; LINE_WIDTH: 0.45399
G1 X141.835 Y75.82 E.03417
; LINE_WIDTH: 0.45786
G1 X140.789 Y77.524 E.03447
; LINE_WIDTH: 0.45901
G1 X140.478 Y78.03 E.01026
; LINE_WIDTH: 0.47181
G2 X140.036 Y78.76 I8.569 J5.689 E.01519
; LINE_WIDTH: 0.44999
G1 X138.106 Y81.909 E.06251
G1 X136.879 Y81.909 E.02076
G1 X136.879 Y77.909 E.0677
G2 X136.876 Y77 I-116.699 J-.032 E.01538
; LINE_WIDTH: 0.44341
G1 X136.876 Y66.867 E.16888
G1 X137.298 Y66.867 E.00703
G1 X137.298 Y77 E.16888
; LINE_WIDTH: 0.45612
G1 X137.314 Y77.255 E.00438
G1 X137.47 Y77.697 E.00804
; LINE_WIDTH: 0.44999
G1 X137.89 Y78.181 E.01085
G1 X138.45 Y78.439 E.01044
G1 X138.974 Y78.49 E.00892
G1 X139.586 Y78.298 E.01085
; LINE_WIDTH: 0.47181
G1 X139.961 Y78.005 E.00847
G1 X140.105 Y77.8 E.00446
; LINE_WIDTH: 0.45901
G1 X141.155 Y76.098 E.03456
; LINE_WIDTH: 0.45514
G1 X142.205 Y74.396 E.03426
; LINE_WIDTH: 0.45127
G1 X143.255 Y72.694 E.03395
; LINE_WIDTH: 0.4474
G1 X144.305 Y70.991 E.03365
; LINE_WIDTH: 0.44353
G1 X144.617 Y70.486 E.00989
; LINE_WIDTH: 0.44239
G1 X144.62 Y70.481 E.00011
; LINE_WIDTH: 0.44999
G2 X146.857 Y66.87 I-868.396 J-540.416 E.07189
G1 X148.198 Y66.87 E.02269
G1 X148.198 Y67.731 E.01457
G1 X148.198 Y69.731 E.03385
G2 X148.201 Y71.498 I227.257 J.46 E.0299
; LINE_WIDTH: 0.44341
G1 X148.201 Y81.912 E.17357
G1 X147.779 Y81.912 E.00703
G1 X147.779 Y71.498 E.17357
; LINE_WIDTH: 0.44999
G1 X147.607 Y70.8 E.01216
G1 X147.186 Y70.315 E.01087
G1 X146.625 Y70.058 E.01045
G1 X146.098 Y70.009 E.00895
G1 X146.057 Y70.022 E.00074
M204 S10000
G1 X146.07 Y70.456 F30000
G1 F6000
M204 S1000
G1 X145.702 Y70.573 E.00654
G1 X145.34 Y70.925 E.00855
G1 X138.346 Y82.338 E.22654
G1 X136.451 Y82.338 E.03207
G1 X136.451 Y66.442 E.26904
G1 X137.723 Y66.442 E.02154
G1 X137.723 Y76.442 E.16925
G2 X137.739 Y77.18 I4.251 J.279 E.01252
G1 X137.847 Y77.494 E.00561
G1 X138.145 Y77.837 E.00769
G1 X138.48 Y78.002 E.00633
M73 P87 R9
G1 X138.938 Y78.063 E.00783
G1 X139.372 Y77.927 E.00769
G1 X139.632 Y77.714 E.00568
G1 X139.737 Y77.573 E.00299
G1 X146.618 Y66.442 E.22149
G1 X148.626 Y66.442 E.03399
G1 X148.626 Y67.731 E.02182
G1 X148.626 Y82.338 E.24722
G1 X147.354 Y82.338 E.02154
G1 X147.354 Y71.498 E.18347
G1 X147.229 Y71.004 E.00862
G1 X146.931 Y70.66 E.0077
G1 X146.595 Y70.495 E.00633
G1 X146.136 Y70.436 E.00785
G1 X146.127 Y70.438 E.00015
M204 S10000
G1 X146.14 Y70.873 F30000
G1 F6000
M204 S1000
G1 X145.917 Y70.943 E.00396
G1 X145.704 Y71.151 E.00503
G1 X138.586 Y82.766 E.23058
G1 X136.022 Y82.766 E.04339
G1 X136.022 Y66.013 E.28355
G1 X138.152 Y66.013 E.03604
G1 X138.152 Y77 E.18596
G1 X138.225 Y77.291 E.00507
G1 X138.4 Y77.493 E.00452
G1 X138.597 Y77.59 E.00372
G1 X138.903 Y77.636 E.00523
G1 X139.158 Y77.556 E.00452
G1 X139.373 Y77.347 E.00507
G1 X146.379 Y66.013 E.22553
G1 X149.055 Y66.013 E.04528
G1 X149.055 Y67.731 E.02908
G1 X149.055 Y82.766 E.25447
G1 X146.925 Y82.766 E.03604
G1 X146.925 Y71.498 E.19072
G1 X146.852 Y71.207 E.00507
G1 X146.677 Y71.005 E.00453
G1 X146.479 Y70.908 E.00373
G1 X146.198 Y70.866 E.0048
M204 S250
G1 X146.208 Y71.275 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X146.056 Y71.368 E.00281
G1 X138.817 Y83.18 E.21805
G1 X135.609 Y83.18 E.0505
G1 X135.609 Y65.6 E.27672
G1 X138.565 Y65.6 E.04654
G1 X138.565 Y77 E.17945
G1 X138.646 Y77.16 E.00282
G1 X138.868 Y77.224 E.00363
G1 X139.021 Y77.13 E.00282
G1 X146.149 Y65.6 E.21337
G1 X149.468 Y65.6 E.05225
G1 X149.468 Y67.731 E.03355
G1 X149.468 Y83.18 E.24317
G1 X146.512 Y83.18 E.04654
G1 X146.512 Y71.498 E.18388
G1 X146.431 Y71.337 E.00283
G1 X146.266 Y71.291 E.0027
; WIPE_START
M204 S1000
G1 X146.056 Y71.368 E-.08506
G1 X145.128 Y72.883 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.759 Y72.657 Z2.3 F30000
G1 X145.937 Y70.735
G1 X147.784 Y70.382
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S1000
G1 X147.784 Y67.284 E.04877
G1 X147.087 Y67.284 E.01097
G1 X145.555 Y69.753 E.04574
G1 X146.103 Y69.597 E.00897
G1 X146.793 Y69.679 E.01094
G1 X147.401 Y69.964 E.01056
G1 X147.744 Y70.338 E.00798
M204 S10000
G1 X147.386 Y69.513 F30000
G1 F6000
M204 S1000
G1 X147.386 Y67.682 E.02881
G1 X147.295 Y67.705 E.00148
G1 X146.351 Y69.225 E.02816
G1 X146.908 Y69.295 E.00884
G1 X147.331 Y69.488 E.00731
M204 S10000
G1 X147.022 Y68.877 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S1000
G1 X146.951 Y68.918 E.00121
G1 X147.01 Y68.952 E.00102
G1 E-.8 F1800
M204 S10000
G1 X142.388 Y75.026 Z2.3 F30000
G1 X139.568 Y78.732 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
G1 X139.052 Y78.893 E.00851
G1 X138.281 Y78.818 E.01219
G1 X137.674 Y78.532 E.01055
G1 X137.298 Y78.122 E.00877
G1 X137.293 Y81.495 E.05311
G1 X137.874 Y81.495 E.00915
G1 X139.537 Y78.783 E.05008
M204 S10000
G1 X138.766 Y79.278 F30000
G1 F6000
M204 S1000
G1 X138.233 Y79.214 E.00844
G1 X137.695 Y78.987 E.00919
G1 X137.692 Y81.03 E.03215
G1 X138.734 Y79.329 E.03139
M204 S10000
G1 X138.122 Y79.555 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S1000
G2 X138.113 Y79.643 I-.025 J.042 E.00317
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X138.071 Y79.643 E-.16312
G1 X138.046 Y79.599 E-.19896
G1 X138.071 Y79.555 E-.19898
G1 X138.122 Y79.555 E-.19893
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 20/58
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
M106 S102
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.3 I.251 J1.191 P1  F30000
G1 X199.415 Y66.652 Z2.3
G1 X199.533 Y66.514
G1 X199.552 Y66.501
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
M204 S1000
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.4 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.4 F30000
G1 X208.887 Y69.747
G1 X208.865 Y80.032
G1 X208.501 Y79.6
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 20 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer20 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.4 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.4 F30000
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.4 F30000
G1 X192.634 Y92.321
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.4 F30000
G1 X181.048 Y83.18
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X177.834 Y83.18 E.0506
G1 X177.834 Y65.6 E.27672
G1 X181.048 Y65.6 E.0506
G1 X181.048 Y67.207 E.0253
G1 X181.048 Y83.12 E.25048
M204 S10000
G1 X180.136 Y82.96 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X180.829 Y82.268 E.01542
G1 X180.829 Y81.704
G1 X179.573 Y82.96 E.02796
G1 X179.009 Y82.96
G1 X180.829 Y81.141 E.04051
G1 X180.829 Y80.577
G1 X178.446 Y82.96 E.05306
G1 X178.053 Y82.789
G1 X180.829 Y80.013 E.0618
G1 X180.829 Y79.45
G1 X178.053 Y82.226 E.0618
G1 X178.053 Y81.662
G1 X180.829 Y78.886 E.0618
G1 X180.829 Y78.323
G1 X178.053 Y81.099 E.0618
G1 X178.053 Y80.535
G1 X180.829 Y77.759 E.0618
G1 X180.829 Y77.195
G1 X178.053 Y79.971 E.0618
G1 X178.053 Y79.408
G1 X180.829 Y76.632 E.0618
G1 X180.829 Y76.068
G1 X178.053 Y78.844 E.0618
G1 X178.053 Y78.281
G1 X180.829 Y75.505 E.0618
G1 X180.829 Y74.941
G1 X178.053 Y77.717 E.0618
G1 X178.053 Y77.153
G1 X180.829 Y74.377 E.0618
G1 X180.829 Y73.814
G1 X178.053 Y76.59 E.0618
G1 X178.053 Y76.026
G1 X180.829 Y73.25 E.0618
G1 X180.829 Y72.687
G1 X178.053 Y75.463 E.0618
G1 X178.053 Y74.899
G1 X180.829 Y72.123 E.0618
G1 X180.829 Y71.559
G1 X178.053 Y74.335 E.0618
G1 X178.053 Y73.772
G1 X180.829 Y70.996 E.0618
G1 X180.829 Y70.432
G1 X178.053 Y73.208 E.0618
G1 X178.053 Y72.645
G1 X180.829 Y69.868 E.0618
G1 X180.829 Y69.305
G1 X178.053 Y72.081 E.0618
G1 X178.053 Y71.517
G1 X180.829 Y68.741 E.0618
G1 X180.829 Y68.178
G1 X178.053 Y70.954 E.0618
G1 X178.053 Y70.39
G1 X180.829 Y67.614 E.0618
G1 X180.829 Y67.05
G1 X178.053 Y69.826 E.0618
G1 X178.053 Y69.263
G1 X180.829 Y66.487 E.0618
G1 X180.829 Y65.923
G1 X178.053 Y68.699 E.0618
G1 X178.053 Y68.136
G1 X180.37 Y65.819 E.05158
G1 X179.806 Y65.819
G1 X178.053 Y67.572 E.03903
G1 X178.053 Y67.008
G1 X179.243 Y65.819 E.02648
G1 X178.679 Y65.819
G1 X178.053 Y66.445 E.01394
G1 E-.8 F1800
M204 S10000
G1 X185.072 Y69.442 Z2.4 F30000
G1 X194.535 Y73.483 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X194.639 Y73.536 E.00183
G3 X196.684 Y74.11 I-1.09 J7.812 E.03355
G1 X197.47 Y74.569 E.01432
G1 X198.108 Y75.139 E.01347
G1 X198.604 Y75.81 E.01312
G1 X198.958 Y76.565 E.01313
G1 X199.137 Y77.271 E.01147
G3 X199.237 Y78.461 I-8.741 J1.329 E.01881
G1 X199.197 Y79.091 E.00994
G1 X199.055 Y79.794 E.01128
G1 X198.82 Y80.452 E.011
G1 X198.491 Y81.067 E.01098
G1 X198.085 Y81.614 E.01072
G1 X197.619 Y82.068 E.01025
G1 X197.092 Y82.432 E.01008
G1 X196.502 Y82.707 E.01024
G1 X195.778 Y82.911 E.01184
G3 X192.388 Y83.179 I-3.123 J-17.921 E.0536
G1 X184.943 Y83.18 E.11719
G1 X184.943 Y65.6 E.27672
G1 X188.157 Y65.6 E.0506
G1 X188.157 Y72.915 E.11514
G1 X188.211 Y73.051 E.0023
G1 X188.357 Y73.114 E.0025
G2 X190.631 Y72.998 I.487 J-12.825 E.03589
G1 X191.068 Y72.868 E.00718
G1 X191.665 Y72.544 E.01068
G1 X192.189 Y72.085 E.01096
G2 X193.779 Y69.926 I-19.101 J-15.729 E.04223
G1 X196.681 Y65.6 E.08201
G1 X200.537 Y65.6 E.06068
G1 X198.414 Y68.99 E.06296
G3 X196.632 Y71.52 I-18.992 J-11.481 E.04874
G1 X196.034 Y72.125 E.0134
G3 X194.548 Y73.185 I-6.947 J-8.167 E.02877
G1 X194.475 Y73.318 E.00238
G1 X194.515 Y73.426 E.00181
G1 E-.8 F1800
M204 S10000
G1 X189.525 Y79.202 Z2.4 F30000
G1 X188.357 Y80.555 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S500
G1 X188.189 Y80.463 E.00301
G1 X188.157 Y80.355 E.00177
G1 X188.157 Y75.766 E.07223
G1 X188.211 Y75.63 E.0023
G1 X188.36 Y75.567 E.00254
G1 X191.685 Y75.571 E.05234
G3 X194.16 Y75.739 I.112 J16.662 E.03909
G1 X194.703 Y75.932 E.00908
G3 X195.524 Y76.656 I-1.099 J2.073 E.01739
G1 X195.764 Y77.152 E.00868
G1 X195.893 Y77.682 E.00859
G3 X195.884 Y78.589 I-4.116 J.413 E.01431
G1 X195.746 Y79.095 E.00825
G3 X195.071 Y80.007 I-2.098 J-.846 E.01806
G3 X193.87 Y80.493 I-1.673 J-2.41 E.02055
G3 X190.198 Y80.553 I-2.726 J-54.375 E.05782
G1 X188.417 Y80.554 E.02804
G1 E-.8 F1800
M204 S10000
G1 X196.045 Y80.291 Z2.4 F30000
G1 X198.677 Y80.201 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X196.358 Y82.52 E.05163
G1 X195.596 Y82.718
G1 X198.91 Y79.404 E.07378
G1 X198.999 Y78.752
G1 X194.925 Y82.825 E.09068
G1 X194.304 Y82.883
G1 X199.011 Y78.176 E.10479
G1 X198.971 Y77.652
G1 X193.693 Y82.931 E.11751
G1 X193.116 Y82.944
G1 X198.886 Y77.173 E.12846
G1 X198.772 Y76.724
G1 X192.539 Y82.957 E.13875
G1 X191.972 Y82.96
G1 X194.319 Y80.614 E.05223
G1 X193.645 Y80.724
G1 X191.409 Y82.96 E.04979
G1 X190.845 Y82.96
G1 X193.051 Y80.754 E.04912
G1 X192.477 Y80.765
G1 X190.281 Y82.96 E.04888
G1 X189.718 Y82.96
G1 X191.908 Y80.77 E.04876
G1 X191.344 Y80.771
G1 X189.154 Y82.96 E.04874
G1 X188.591 Y82.96
G1 X190.78 Y80.771 E.04873
G1 X190.215 Y80.772
G1 X188.027 Y82.96 E.04872
G1 X187.463 Y82.96
G1 X189.651 Y80.772 E.04871
G1 X189.087 Y80.773
G1 X186.9 Y82.96 E.04869
G1 X186.336 Y82.96
G1 X188.523 Y80.774 E.04868
G1 X188.079 Y80.654
G1 X185.773 Y82.96 E.05134
G1 X185.209 Y82.96
G1 X187.938 Y80.231 E.06076
G1 X187.938 Y79.668
G1 X185.162 Y82.444 E.0618
G1 X185.162 Y81.88
G1 X187.938 Y79.104 E.0618
G1 X187.938 Y78.54
G1 X185.162 Y81.316 E.0618
G1 X185.162 Y80.753
G1 X187.938 Y77.977 E.0618
G1 X187.938 Y77.413
G1 X185.162 Y80.189 E.0618
G1 X185.162 Y79.626
G1 X187.938 Y76.85 E.0618
G1 X187.938 Y76.286
G1 X185.162 Y79.062 E.0618
G1 X185.162 Y78.498
G1 X187.948 Y75.712 E.06203
G1 E-.8 F1800
M204 S10000
G1 X195.049 Y78.511 Z2.4 F30000
G1 X196.033 Y78.899 Z2.4
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X198.605 Y76.328 E.05725
G1 X198.425 Y75.944
G1 X196.129 Y78.24 E.05111
G1 X196.115 Y77.691
G1 X198.188 Y75.617 E.04616
G1 X197.949 Y75.293
G1 X196.02 Y77.222 E.04293
G1 X195.864 Y76.815
G1 X197.652 Y75.026 E.03982
G1 X197.355 Y74.76
G1 X195.652 Y76.462 E.0379
G1 X195.392 Y76.159
G1 X197.002 Y74.549 E.03584
G1 X196.646 Y74.341
G1 X195.081 Y75.906 E.03483
G1 X194.713 Y75.711
G1 X196.255 Y74.169 E.03433
G1 X195.835 Y74.025
G1 X194.3 Y75.561 E.03419
G1 X193.827 Y75.469
G1 X195.392 Y73.905 E.03483
G1 X194.925 Y73.808
G1 X193.316 Y75.417 E.03582
G1 X192.788 Y75.381
G1 X194.475 Y73.694 E.03756
G1 X194.262 Y73.344
G1 X192.24 Y75.366 E.04502
G1 X191.691 Y75.352
G1 X198.328 Y68.715 E.14775
G1 E-.8 F1800
M204 S10000
G1 X199.271 Y67.207 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X191.128 Y75.351 E.18129
G1 X190.564 Y75.351
G1 X200.096 Y65.819 E.21219
G1 X199.533 Y65.819
G1 X190.001 Y75.35 E.21218
G1 X189.438 Y75.35
G1 X198.969 Y65.819 E.21218
G1 X198.405 Y65.819
G1 X193.448 Y70.776 E.11035
G1 E-.8 F1800
M204 S10000
G1 X194.671 Y68.99 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X197.842 Y65.819 E.07059
G1 X197.278 Y65.819
G1 X195.82 Y67.277 E.03247
G1 E-.8 F1800
M204 S10000
G1 X191.153 Y73.071 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X188.874 Y75.35 E.05073
G1 X188.308 Y75.353
G1 X190.415 Y73.245 E.04692
G1 X189.785 Y73.312
G1 X185.162 Y77.935 E.10291
G1 X185.162 Y77.371
G1 X189.203 Y73.33 E.08996
G1 X188.639 Y73.331
G1 X185.162 Y76.808 E.07739
G1 X185.162 Y76.244
G1 X188.138 Y73.268 E.06625
G1 X187.938 Y72.904
G1 X185.162 Y75.68 E.0618
G1 X185.162 Y75.117
G1 X187.938 Y72.341 E.0618
G1 X187.938 Y71.777
G1 X185.162 Y74.553 E.0618
G1 X185.162 Y73.989
G1 X187.938 Y71.213 E.0618
G1 X187.938 Y70.65
G1 X185.162 Y73.426 E.0618
G1 X185.162 Y72.862
G1 X187.938 Y70.086 E.0618
G1 X187.938 Y69.523
G1 X185.162 Y72.299 E.0618
G1 X185.162 Y71.735
G1 X187.938 Y68.959 E.0618
G1 X187.938 Y68.395
G1 X185.162 Y71.171 E.0618
G1 X185.162 Y70.608
G1 X187.938 Y67.832 E.0618
G1 X187.938 Y67.268
G1 X185.162 Y70.044 E.0618
G1 X185.162 Y69.481
G1 X187.938 Y66.705 E.0618
G1 X187.938 Y66.141
G1 X185.162 Y68.917 E.0618
G1 X185.162 Y68.353
G1 X187.697 Y65.819 E.05642
G1 X187.133 Y65.819
G1 X185.162 Y67.79 E.04388
G1 X185.162 Y67.226
G1 X186.57 Y65.819 E.03133
G1 X186.006 Y65.819
G1 X185.162 Y66.663 E.01879
G1 E-.8 F1800
M204 S10000
G1 X192.597 Y68.388 Z2.4 F30000
G1 X197.767 Y69.588 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.087496
G1 F3600
M204 S1000
G1 X197.649 Y69.732 E.00049
; LINE_WIDTH: 0.123929
G1 X197.531 Y69.877 E.00075
; LINE_WIDTH: 0.160363
G1 X197.414 Y70.021 E.00102
; LINE_WIDTH: 0.20326
G1 X197.226 Y70.244 E.0021
; LINE_WIDTH: 0.252621
G1 X197.038 Y70.467 E.00266
; LINE_WIDTH: 0.301981
G1 X196.849 Y70.69 E.00323
; LINE_WIDTH: 0.346711
G1 X196.623 Y70.946 E.00439
; LINE_WIDTH: 0.386802
G1 X196.396 Y71.201 E.00493
; LINE_WIDTH: 0.405779
G3 X195.42 Y72.151 I-9.675 J-8.958 E.02068
; LINE_WIDTH: 0.346979
G1 X195.194 Y72.344 E.00382
; LINE_WIDTH: 0.299201
G1 X194.967 Y72.536 E.00326
; LINE_WIDTH: 0.25504
G1 X194.825 Y72.65 E.00168
; LINE_WIDTH: 0.214507
G1 X194.682 Y72.764 E.00139
; LINE_WIDTH: 0.173973
G1 X194.54 Y72.878 E.0011
; LINE_WIDTH: 0.126942
G2 X194.176 Y73.258 I.892 J1.217 E.0022
G1 E-.8 F1800
M204 S10000
G1 X198.745 Y68.046 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0937608
M73 P88 R9
G1 F3600
M204 S1000
G1 X198.584 Y68.247 E.00074
; LINE_WIDTH: 0.142713
G1 X198.424 Y68.449 E.00123
; LINE_WIDTH: 0.191665
G1 X198.263 Y68.65 E.00173
G1 E-.8 F1800
M204 S10000
G1 X199.689 Y66.538 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0937608
G1 F3600
M204 S1000
G1 X199.528 Y66.74 E.00074
; LINE_WIDTH: 0.142713
G1 X199.368 Y66.941 E.00123
; LINE_WIDTH: 0.191665
G1 X199.207 Y67.143 E.00173
G1 E-.8 F1800
M204 S10000
G1 X196.893 Y65.799 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.158689
G1 F3600
M204 S1000
G1 X196.749 Y65.973 E.00122
; LINE_WIDTH: 0.122926
G1 X196.606 Y66.147 E.0009
; LINE_WIDTH: 0.0871628
G1 X196.463 Y66.322 E.00059
G1 E-.8 F1800
M204 S10000
G1 X195.884 Y67.341 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.200741
G1 F3600
M204 S1000
G1 X195.741 Y67.515 E.00159
; LINE_WIDTH: 0.163181
G1 X195.599 Y67.688 E.00126
; LINE_WIDTH: 0.125621
G1 X195.456 Y67.861 E.00092
; LINE_WIDTH: 0.0880617
G1 X195.314 Y68.034 E.00059
G1 E-.8 F1800
M204 S10000
G1 X194.735 Y69.054 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.200753
G1 F3600
M204 S1000
G1 X194.592 Y69.227 E.00159
; LINE_WIDTH: 0.16319
G1 X194.45 Y69.4 E.00126
; LINE_WIDTH: 0.125627
G1 X194.307 Y69.574 E.00092
; LINE_WIDTH: 0.0880636
G1 X194.165 Y69.747 E.00059
G1 E-.8 F1800
M204 S10000
G1 X193.512 Y70.84 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.19716
M73 P88 R8
G1 F3600
M204 S1000
G1 X193.305 Y71.086 E.00224
; LINE_WIDTH: 0.147601
G1 X193.097 Y71.333 E.0016
; LINE_WIDTH: 0.0978925
G1 X192.888 Y71.581 E.00098
; LINE_WIDTH: 0.0711352
G1 X192.847 Y71.627 E.00012
G1 E-.8 F1800
M204 S10000
G1 X191.673 Y72.804 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0922421
G1 F3600
M204 S1000
G1 X191.521 Y72.915 E.00052
; LINE_WIDTH: 0.138176
G1 X191.37 Y73.025 E.00086
; LINE_WIDTH: 0.18411
G1 X191.218 Y73.136 E.00121
G1 E-.8 F1800
M204 S10000
G1 X189.507 Y73.308 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0869748
G1 F3600
M204 S1000
G1 X189.279 Y73.405 E.00064
G1 E-.8 F1800
M204 S10000
G1 X193.766 Y79.58 Z2.4 F30000
G1 X194.553 Y80.662 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111948
G1 F3600
M204 S1000
G1 X194.307 Y80.602 E.0009
M204 S10000
G1 X193.361 Y80.726 F30000
; LINE_WIDTH: 0.0767985
G1 F3600
M204 S1000
G1 X193.127 Y80.829 E.00056
G1 E-.8 F1800
M204 S10000
G1 X188.24 Y75.285 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.166143
G1 F3600
M204 S1000
G2 X187.921 Y75.572 I.478 J.854 E.00247
G1 X187.949 Y75.712 E.00082
G1 E-.8 F1800
M204 S10000
G1 X195.036 Y78.545 Z2.4 F30000
G1 X196.106 Y78.973 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.150033
G1 F3600
M204 S1000
G1 X196.031 Y79.094 E.00072
; LINE_WIDTH: 0.127671
G1 X195.965 Y79.191 E.00049
; LINE_WIDTH: 0.0887411
G1 X195.899 Y79.288 E.00031
G1 E-.8 F1800
M204 S10000
G1 X198.38 Y80.809 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0890421
G1 F3600
M204 S1000
G1 X198.285 Y80.936 E.00042
; LINE_WIDTH: 0.132297
G1 X198.076 Y81.179 E.00141
; LINE_WIDTH: 0.192141
G3 X197.436 Y81.846 I-4.501 J-3.673 E.00624
; LINE_WIDTH: 0.177113
G1 X197.283 Y81.974 E.00123
; LINE_WIDTH: 0.141032
G1 X197.129 Y82.102 E.00094
; LINE_WIDTH: 0.104951
G1 X196.976 Y82.23 E.00066
; LINE_WIDTH: 0.0780965
G1 X196.915 Y82.273 E.00017
G1 E-.8 F1800
M204 S10000
G1 X192.09 Y76.359 Z2.4 F30000
G1 X176.201 Y56.88 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.4 F30000
G1 X181.348 Y56.444
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.4 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.4 F30000
G1 X162.941 Y69.633
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X163.079 Y69.688 E.00234
G1 X170.289 Y69.688 E.11349
G1 X170.358 Y69.676 E.0011
G1 X170.474 Y69.563 E.00255
G1 X171.997 Y65.6 E.06684
G1 X173.108 Y65.6 E.01748
G1 X175.496 Y65.6 E.0376
G1 X168.457 Y83.18 E.29808
G1 X164.9 Y83.18 E.056
G1 X158.052 Y65.6 E.29697
G1 X161.453 Y65.6 E.05354
G1 X162.82 Y69.359 E.06296
G2 X162.907 Y69.583 I.646 J-.123 E.00381
G1 E-.8 F1800
M204 S10000
G1 X165.542 Y76.747 Z2.4 F30000
G1 X166.509 Y79.376 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S500
G1 X166.447 Y79.29 E.00167
G1 X164.001 Y72.568 E.11259
G1 X164.015 Y72.401 E.00264
G1 X164.154 Y72.304 E.00267
G1 X164.188 Y72.301 E.00054
G1 X169.13 Y72.301 E.07779
G1 X169.29 Y72.381 E.00282
G1 X169.325 Y72.541 E.00258
G1 X169.317 Y72.57 E.00047
G1 X166.82 Y79.296 E.11293
G1 X166.684 Y79.414 E.00283
G1 X166.568 Y79.389 E.00188
G1 E-.8 F1800
M204 S10000
G1 X167.737 Y82.96 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X168.691 Y82.007 E.02122
G1 X169.067 Y81.067
G1 X167.174 Y82.96 E.04215
G1 X166.61 Y82.96
G1 X169.443 Y80.127 E.06307
G1 X169.82 Y79.187
G1 X166.046 Y82.96 E.084
G1 X165.483 Y82.96
G1 X170.196 Y78.247 E.10492
G1 X170.572 Y77.307
G1 X165.013 Y82.866 E.12376
G1 X164.855 Y82.461
G1 X170.949 Y76.367 E.13565
G1 X171.325 Y75.427
G1 X164.697 Y82.055 E.14755
G1 X164.539 Y81.65
G1 X166.557 Y79.631 E.04493
G1 X166.247 Y79.378
G1 X164.381 Y81.244 E.04154
G1 X164.223 Y80.838
G1 X166.096 Y78.965 E.0417
G1 X165.946 Y78.552
G1 X164.065 Y80.433 E.04187
G1 X163.907 Y80.027
G1 X165.795 Y78.139 E.04203
G1 X165.645 Y77.726
G1 X163.749 Y79.622 E.0422
G1 X163.591 Y79.216
G1 X165.495 Y77.312 E.04237
G1 X165.344 Y76.899
G1 X163.433 Y78.81 E.04254
G1 X163.275 Y78.405
G1 X165.194 Y76.486 E.04271
G1 X165.043 Y76.073
G1 X163.117 Y77.999 E.04288
G1 X162.959 Y77.593
G1 X164.893 Y75.66 E.04305
G1 X164.743 Y75.246
G1 X162.801 Y77.188 E.04322
G1 X162.643 Y76.782
G1 X164.592 Y74.833 E.04339
G1 X164.442 Y74.42
G1 X162.485 Y76.377 E.04355
G1 X162.327 Y75.971
G1 X164.291 Y74.007 E.04372
G1 X164.141 Y73.594
G1 X162.169 Y75.565 E.04389
G1 X162.011 Y75.16
G1 X163.991 Y73.18 E.04406
G1 X163.84 Y72.767
G1 X161.853 Y74.754 E.04423
G1 E-.8 F1800
M204 S10000
G1 X167.148 Y79.04 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X171.702 Y74.487 E.10136
G1 X172.078 Y73.547
G1 X167.481 Y78.144 E.10233
G1 X167.814 Y77.247
G1 X172.454 Y72.607 E.1033
G1 X172.831 Y71.667
G1 X168.147 Y76.351 E.10427
G1 X168.48 Y75.454
G1 X173.207 Y70.727 E.10524
G1 X173.583 Y69.787
G1 X168.813 Y74.558 E.1062
G1 X169.146 Y73.662
G1 X173.96 Y68.847 E.10717
G1 X174.336 Y67.907
G1 X169.478 Y72.765 E.10814
G1 X169.446 Y72.234
G1 X174.713 Y66.967 E.11725
G1 X175.089 Y66.027
G1 X169.034 Y72.082 E.13478
G1 X168.471 Y72.082
G1 X174.734 Y65.819 E.13942
G1 X174.17 Y65.819
G1 X170.885 Y69.104 E.07313
G1 X171.237 Y68.188
G1 X173.607 Y65.819 E.05275
G1 X173.043 Y65.819
G1 X171.589 Y67.273 E.03237
G1 X171.941 Y66.357
G1 X172.479 Y65.819 E.01199
G1 E-.8 F1800
M204 S10000
G1 X170.082 Y69.907 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X167.907 Y72.082 E.04841
G1 X167.344 Y72.082
G1 X169.519 Y69.907 E.04842
G1 X168.956 Y69.906
G1 X166.78 Y72.082 E.04843
G1 X166.216 Y72.082
G1 X168.393 Y69.906 E.04845
G1 X167.83 Y69.905
G1 X165.653 Y72.082 E.04846
G1 X165.089 Y72.082
G1 X167.267 Y69.904 E.04847
G1 X166.703 Y69.904
G1 X164.526 Y72.082 E.04848
G1 E-.8 F1800
M204 S10000
G1 X166.14 Y69.903 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X161.695 Y74.348 E.09895
G1 X161.537 Y73.943
G1 X165.577 Y69.903 E.08994
G1 X165.014 Y69.902
G1 X161.379 Y73.537 E.08092
G1 X161.221 Y73.132
G1 X164.451 Y69.902 E.0719
G1 X163.888 Y69.901
G1 X161.063 Y72.726 E.06289
G1 X160.905 Y72.32
G1 X163.325 Y69.901 E.05387
G1 X162.839 Y69.823
G1 X160.747 Y71.915 E.04657
G1 X160.589 Y71.509
G1 X162.627 Y69.471 E.04537
G1 X162.477 Y69.058
G1 X160.431 Y71.104 E.04554
G1 X160.273 Y70.698
G1 X162.327 Y68.644 E.04571
G1 X162.177 Y68.231
G1 X160.115 Y70.292 E.04588
G1 X159.957 Y69.887
G1 X162.026 Y67.818 E.04606
G1 X161.876 Y67.404
G1 X159.799 Y69.481 E.04623
G1 X159.641 Y69.075
G1 X161.726 Y66.991 E.0464
G1 X161.576 Y66.578
G1 X159.483 Y68.67 E.04658
G1 X159.325 Y68.264
G1 X161.425 Y66.164 E.04675
G1 X161.207 Y65.819
G1 X159.167 Y67.859 E.04541
G1 X159.009 Y67.453
G1 X160.644 Y65.819 E.03638
G1 X160.08 Y65.819
G1 X158.851 Y67.047 E.02735
G1 X158.693 Y66.642
G1 X159.516 Y65.819 E.01832
G1 X158.953 Y65.819
G1 X158.536 Y66.236 E.00929
G1 E-.8 F1800
M204 S10000
G1 X162.803 Y72.564 Z2.4 F30000
G1 X167.221 Y79.113 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0928185
G1 F3600
M204 S1000
G3 X166.981 Y79.461 I-7.565 J-4.947 E.00119
M204 S10000
G1 X166.895 Y79.547 F30000
; LINE_WIDTH: 0.0919619
G1 F3600
M204 S1000
G1 X166.756 Y79.649 E.00048
; LINE_WIDTH: 0.13855
G3 X166.631 Y79.705 I-.315 J-.532 E.00063
G1 E-.8 F1800
M204 S10000
G1 X169.339 Y72.569 Z2.4 F30000
G1 X170.354 Y69.893 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0925734
G1 F3600
M204 S1000
G3 X170.161 Y69.986 I-1.102 J-2.039 E.0006
G1 E-.8 F1800
M204 S10000
G1 X175.181 Y65.85 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.128394
G1 F3600
M204 S1000
G1 X174.912 Y65.85 E.00114
G1 X174.808 Y65.893 E.00047
G1 E-.8 F1800
M204 S10000
G1 X167.376 Y64.158 Z2.4 F30000
G1 X136.201 Y56.88 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.4 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.4 F30000
G1 X128.748 Y66.651
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G3 X131.409 Y69.747 I-4.269 J6.362 E.06504
G3 X132.279 Y73.322 I-9.672 J4.246 E.05823
G1 X132.307 Y73.864 E.00854
G3 X131.985 Y77.341 I-13.534 J.502 E.05511
G3 X131.002 Y79.765 I-9.293 J-2.357 E.04131
G3 X126.476 Y83.147 I-6.56 J-4.061 E.09105
G3 X121.274 Y83.214 I-2.743 J-11.011 E.08262
G1 X120.392 Y82.954 E.01447
G1 X119.37 Y82.499 E.01761
G3 X115.478 Y76.772 I4.112 J-6.98 E.11262
G3 X115.503 Y71.814 I14.135 J-2.407 E.07843
G3 X116.803 Y68.635 I8.552 J1.641 E.05442
M73 P89 R8
G3 X120.687 Y65.751 I6.182 J4.269 E.07752
G3 X123.879 Y65.294 I3.079 J10.116 E.05095
G3 X127.311 Y65.894 I.039 J9.89 E.05513
G3 X128.698 Y66.618 I-2.832 J7.119 E.02468
G1 E-.8 F1800
M204 S10000
G1 X127.861 Y70.045 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S500
G3 X128.616 Y71.636 I-4.123 J2.931 E.02785
G3 X128.957 Y75.206 I-10.895 J2.842 E.0567
G3 X128.437 Y77.774 I-8.699 J-.426 E.04139
G3 X125.924 Y80.398 I-4.436 J-1.732 E.05868
G3 X123.25 Y80.776 I-2.133 J-5.453 E.04289
G3 X119.698 Y78.769 I.351 J-4.767 E.06635
G3 X118.8 Y76.562 I5.311 J-3.447 E.03773
G3 X118.617 Y73.865 I10.957 J-2.101 E.04265
G3 X119.289 Y70.823 I8.061 J.187 E.04935
G1 X119.713 Y70.073 E.01355
G3 X121.281 Y68.625 I4.366 J3.153 E.03381
G1 X121.73 Y68.396 E.00794
G3 X125.86 Y68.384 I2.079 J4.945 E.06673
G3 X127.826 Y69.996 I-2.122 J4.592 E.04045
G1 E-.8 F1800
M204 S10000
G1 X127.711 Y77.628 Z2.4 F30000
G1 X127.638 Y82.48 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X131.21 Y78.908 E.07953
G1 X131.567 Y77.987
G1 X126.718 Y82.836 E.10794
G1 X125.953 Y83.038
G1 X131.79 Y77.201 E.12994
G1 X131.928 Y76.499
G1 X125.268 Y83.159 E.14826
G1 X124.631 Y83.233
G1 X132.01 Y75.853 E.16428
G1 X132.069 Y75.231
G1 X124.044 Y83.256 E.17866
G1 X123.475 Y83.261
G1 X126.26 Y80.476 E.06199
G1 X125.353 Y80.819
G1 X122.942 Y83.23 E.05367
G1 X122.423 Y83.186
G1 X124.651 Y80.958 E.04959
G1 X124.037 Y81.008
G1 X121.933 Y83.112 E.04683
G1 X121.457 Y83.025
G1 X123.477 Y81.005 E.04496
G1 X122.961 Y80.957
G1 X121.011 Y82.908 E.04342
G1 X120.575 Y82.779
G1 X122.482 Y80.872 E.04246
G1 X122.037 Y80.754
G1 X120.174 Y82.617 E.04147
G1 X119.784 Y82.443
G1 X121.624 Y80.603 E.04097
G1 X121.246 Y80.418
G1 X119.403 Y82.261 E.04103
G1 X119.055 Y82.045
G1 X120.891 Y80.209 E.04088
G1 X120.56 Y79.977
G1 X118.726 Y81.81 E.04082
G1 X118.408 Y81.564
G1 X120.25 Y79.722 E.041
G1 X119.97 Y79.439
G1 X118.116 Y81.293 E.04127
G1 X117.83 Y81.016
G1 X119.709 Y79.137 E.04184
G1 X119.469 Y78.813
G1 X117.564 Y80.718 E.0424
G1 X117.307 Y80.411
G1 X119.256 Y78.463 E.04338
G1 X119.068 Y78.087
G1 X117.066 Y80.088 E.04456
G1 X116.841 Y79.75
G1 X118.9 Y77.691 E.04583
G1 X118.755 Y77.273
G1 X116.626 Y79.401 E.04738
G1 X116.435 Y79.029
G1 X118.64 Y76.824 E.04909
G1 X118.544 Y76.357
G1 X116.252 Y78.649 E.05103
G1 X116.092 Y78.245
G1 X118.467 Y75.869 E.05289
G1 X118.42 Y75.353
G1 X115.952 Y77.821 E.05493
G1 X115.832 Y77.377
G1 X118.393 Y74.816 E.05701
G1 X118.386 Y74.26
G1 X115.731 Y76.915 E.05909
G1 X115.649 Y76.434
G1 X118.403 Y73.679 E.06132
G1 X118.46 Y73.059
G1 X115.584 Y75.935 E.06402
G1 X115.536 Y75.419
G1 X118.562 Y72.393 E.06735
G1 X118.737 Y71.654
G1 X115.507 Y74.884 E.0719
G1 X115.506 Y74.322
G1 X119.086 Y70.742 E.0797
G1 E-.8 F1800
M204 S10000
G1 X125.021 Y75.541 Z2.4 F30000
G1 X128.435 Y78.301 Z2.4
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X132.092 Y74.645 E.0814
G1 X132.087 Y74.085
G1 X128.81 Y77.362 E.07295
G1 X129.003 Y76.606
G1 X132.069 Y73.54 E.06825
G1 X132.022 Y73.024
G1 X129.111 Y75.934 E.0648
G1 X129.167 Y75.314
G1 X131.968 Y72.514 E.06234
G1 X131.887 Y72.032
G1 X129.19 Y74.728 E.06003
G1 X129.189 Y74.165
G1 X131.794 Y71.561 E.05798
G1 X131.673 Y71.118
G1 X129.171 Y73.62 E.05571
G1 X129.123 Y73.104
G1 X131.545 Y70.682 E.05391
G1 X131.387 Y70.276
G1 X129.054 Y72.609 E.05194
G1 X128.967 Y72.133
G1 X131.225 Y69.875 E.05027
G1 X131.032 Y69.505
G1 X128.855 Y71.682 E.04847
G1 X128.716 Y71.257
G1 X130.836 Y69.137 E.0472
G1 X130.609 Y68.8
G1 X128.558 Y70.851 E.04565
G1 X128.379 Y70.466
G1 X130.38 Y68.466 E.04454
G1 X130.121 Y68.161
G1 X128.169 Y70.113 E.04346
G1 X127.938 Y69.78
G1 X129.86 Y67.858 E.04278
G1 X129.57 Y67.585
G1 X127.689 Y69.466 E.04187
G1 X127.411 Y69.18
G1 X129.279 Y67.312 E.04158
G1 X128.959 Y67.069
G1 X127.113 Y68.914 E.04107
G1 X126.796 Y68.668
G1 X128.636 Y66.828 E.04096
G1 X128.282 Y66.618
G1 X126.457 Y68.443 E.04062
G1 X126.085 Y68.252
G1 X127.925 Y66.412 E.04095
G1 X127.537 Y66.236
G1 X125.687 Y68.086 E.04118
G1 X125.259 Y67.95
G1 X127.141 Y66.069 E.04189
G1 X126.717 Y65.929
G1 X124.798 Y67.848 E.04273
G1 X124.3 Y67.782
G1 X126.279 Y65.804 E.04404
G1 X125.817 Y65.701
G1 X123.757 Y67.762 E.04587
G1 X123.157 Y67.798
G1 X125.333 Y65.622 E.04843
G1 X124.832 Y65.559
G1 X122.47 Y67.922 E.0526
G1 X121.623 Y68.205
G1 X124.298 Y65.53 E.05954
G1 X123.748 Y65.516
G1 X115.504 Y73.76 E.18351
G1 X115.549 Y73.152
G1 X123.165 Y65.536 E.16955
G1 X122.552 Y65.585
G1 X115.616 Y72.521 E.15441
G1 X115.719 Y71.854
G1 X121.887 Y65.687 E.1373
G1 X121.159 Y65.851
G1 X115.904 Y71.106 E.11699
G1 X116.191 Y70.255
G1 X120.319 Y66.127 E.09189
G1 X119.227 Y66.656
G1 X116.766 Y69.117 E.05477
G1 E-.8 F1800
M204 S10000
G1 X122.895 Y73.665 Z2.4 F30000
G1 X130.857 Y79.572 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0789438
G1 F3600
M204 S1000
G1 X130.803 Y79.644 E.0002
; LINE_WIDTH: 0.11335
G1 X130.631 Y79.851 E.00098
; LINE_WIDTH: 0.162857
G1 X130.459 Y80.058 E.0015
; LINE_WIDTH: 0.212364
G1 X130.287 Y80.265 E.00203
; LINE_WIDTH: 0.251517
G1 X130.016 Y80.557 E.00362
; LINE_WIDTH: 0.280388
G3 X129.174 Y81.398 I-8.166 J-7.324 E.01217
; LINE_WIDTH: 0.24726
G1 X128.977 Y81.57 E.00233
; LINE_WIDTH: 0.209565
G1 X128.779 Y81.741 E.00194
; LINE_WIDTH: 0.17187
G1 X128.581 Y81.912 E.00155
; LINE_WIDTH: 0.1321
G1 X128.44 Y82.021 E.00078
; LINE_WIDTH: 0.0902259
G1 X128.3 Y82.129 E.00048
G1 E-.8 F1800
M204 S10000
G1 X124.986 Y75.254 Z2.4 F30000
G1 X121.558 Y68.14 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.186307
G1 F3600
M204 S1000
G1 X121.427 Y68.236 E.00106
; LINE_WIDTH: 0.145384
G1 X121.295 Y68.331 E.00079
; LINE_WIDTH: 0.104025
G1 X121.161 Y68.429 E.00054
; LINE_WIDTH: 0.0761929
G1 X121.09 Y68.487 E.0002
G1 E-.8 F1800
M204 S10000
G1 X127.478 Y72.663 Z2.4 F30000
G1 X129.25 Y73.822 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0746229
G1 F3600
M204 S1000
M73 P89 R7
G1 X129.151 Y73.601 E.00051
G1 E-.8 F1800
M204 S10000
G1 X128.424 Y78.291 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.174991
G1 F3600
M204 S1000
G1 X128.446 Y78.442 E.00093
; LINE_WIDTH: 0.182001
G1 X128.327 Y78.594 E.00122
; LINE_WIDTH: 0.136913
G1 X128.209 Y78.746 E.00088
; LINE_WIDTH: 0.0918257
G1 X128.09 Y78.898 E.00054
G1 E-.8 F1800
M204 S10000
G1 X126.865 Y80.123 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0910135
G1 F3600
M204 S1000
G1 X126.695 Y80.26 E.0006
; LINE_WIDTH: 0.135246
G1 X126.519 Y80.402 E.00101
; LINE_WIDTH: 0.181917
G1 X126.325 Y80.542 E.00152
G1 E-.8 F1800
M204 S10000
G1 X122.07 Y74.205 Z2.4 F30000
G1 X119.378 Y70.198 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0831812
G1 F3600
M204 S1000
G1 X119.295 Y70.303 E.00033
; LINE_WIDTH: 0.111575
G1 X119.208 Y70.413 E.0005
; LINE_WIDTH: 0.14591
G1 X119.114 Y70.545 E.0008
; LINE_WIDTH: 0.184753
G1 X119.021 Y70.677 E.00104
G1 E-.8 F1800
M204 S10000
G1 X116.83 Y69.181 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.198999
G1 F3600
M204 S1000
G1 X116.717 Y69.325 E.00128
; LINE_WIDTH: 0.167147
G1 X116.604 Y69.469 E.00105
; LINE_WIDTH: 0.130742
G1 X116.528 Y69.576 E.00057
; LINE_WIDTH: 0.0897689
G1 X116.453 Y69.684 E.00035
G1 E-.8 F1800
M204 S10000
G1 X116.376 Y77.316 Z2.4 F30000
G1 X116.36 Y78.822 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0830177
G1 F3600
M204 S1000
G3 X116.268 Y78.692 I1.56 J-1.203 E.00039
G1 E-.8 F1800
M204 S10000
G1 X123.518 Y81.08 Z2.4 F30000
G1 X127.572 Y82.415 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.179506
G1 F3600
M204 S1000
G1 X127.44 Y82.506 E.001
; LINE_WIDTH: 0.13542
G1 X127.307 Y82.597 E.00072
; LINE_WIDTH: 0.0913333
G1 X127.175 Y82.689 E.00044
; WIPE_START
G1 X127.307 Y82.597 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.549 Y77.588 Z2.4 F30000
G1 X107.116 Y65.032 Z2.4
G1 X107.116 Y65.032
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.4 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.4 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y92.55 Z2.4 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X141.291 Y92.39 E.10565
; WIPE_START
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y92.55 Z2.4 F30000
G1 X146.208 Y71.275
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X146.056 Y71.368 E.00281
G1 X138.817 Y83.18 E.21805
G1 X135.609 Y83.18 E.0505
G1 X135.609 Y65.6 E.27672
G1 X138.565 Y65.6 E.04654
G1 X138.565 Y77 E.17945
G1 X138.646 Y77.16 E.00282
G1 X138.868 Y77.224 E.00363
G1 X139.021 Y77.13 E.00282
G1 X146.149 Y65.6 E.21337
G1 X149.468 Y65.6 E.05225
G1 X149.468 Y67.731 E.03355
G1 X149.468 Y83.18 E.24317
G1 X146.512 Y83.18 E.04654
G1 X146.512 Y71.498 E.18388
G1 X146.431 Y71.337 E.00283
G1 X146.266 Y71.291 E.0027
G1 E-.8 F1800
M204 S10000
G1 X141.807 Y77.485 Z2.4 F30000
G1 X137.866 Y82.96 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X140.006 Y80.82 E.04764
G1 E-.8 F1800
M204 S10000
G1 X140.898 Y79.364 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X137.302 Y82.96 E.08005
G1 X136.739 Y82.96
G1 X141.791 Y77.908 E.11246
G1 E-.8 F1800
M204 S10000
G1 X142.683 Y76.453 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X136.175 Y82.96 E.14487
G1 X135.828 Y82.744
G1 X143.575 Y74.997 E.17246
G1 E-.8 F1800
M204 S10000
G1 X144.467 Y73.541 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X135.828 Y82.18 E.19233
G1 X135.828 Y81.617
G1 X145.36 Y72.085 E.21219
G1 E-.8 F1800
M204 S10000
G1 X148.079 Y79.217 Z2.4 F30000
G1 X149.249 Y82.286 Z2.4
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X148.574 Y82.96 E.01502
G1 X148.011 Y82.96
G1 X149.249 Y81.722 E.02757
G1 X149.249 Y81.158
G1 X147.447 Y82.96 E.04011
G1 X146.884 Y82.96
G1 X149.249 Y80.595 E.05266
G1 X149.249 Y80.031
G1 X146.731 Y82.549 E.05606
G1 X146.731 Y81.986
G1 X149.249 Y79.468 E.05606
G1 X149.249 Y78.904
G1 X146.731 Y81.422 E.05606
G1 X146.731 Y80.859
G1 X149.249 Y78.34 E.05606
G1 X149.249 Y77.777
G1 X146.731 Y80.295 E.05606
G1 X146.731 Y79.731
G1 X149.249 Y77.213 E.05606
G1 X149.249 Y76.65
G1 X146.731 Y79.168 E.05606
G1 X146.731 Y78.604
G1 X149.249 Y76.086 E.05606
G1 X149.249 Y75.522
G1 X146.731 Y78.041 E.05606
G1 X146.731 Y77.477
G1 X149.249 Y74.959 E.05606
G1 X149.249 Y74.395
G1 X146.731 Y76.913 E.05606
G1 X146.731 Y76.35
G1 X149.249 Y73.832 E.05606
G1 X149.249 Y73.268
G1 X146.731 Y75.786 E.05606
G1 X146.731 Y75.223
G1 X149.249 Y72.704 E.05606
G1 X149.249 Y72.141
G1 X146.731 Y74.659 E.05606
G1 X146.731 Y74.095
G1 X149.249 Y71.577 E.05606
G1 X149.249 Y71.014
G1 X146.731 Y73.532 E.05606
G1 X146.731 Y72.968
G1 X149.249 Y70.45 E.05606
G1 X149.249 Y69.886
G1 X146.731 Y72.405 E.05606
G1 X146.731 Y71.841
G1 X149.249 Y69.323 E.05606
G1 X149.249 Y68.759
G1 X146.687 Y71.321 E.05703
G1 X146.364 Y71.08
G1 X149.249 Y68.196 E.06422
G1 X149.249 Y67.632
G1 X135.828 Y81.053 E.29877
G1 X135.828 Y80.49
G1 X138.877 Y77.441 E.06787
G1 X138.47 Y77.284
G1 X135.828 Y79.926 E.05881
G1 X135.828 Y79.362
G1 X138.346 Y76.844 E.05606
G1 X138.346 Y76.281
G1 X135.828 Y78.799 E.05606
G1 X135.828 Y78.235
G1 X138.346 Y75.717 E.05606
G1 X138.346 Y75.153
G1 X135.828 Y77.672 E.05606
G1 X135.828 Y77.108
G1 X138.346 Y74.59 E.05606
G1 X138.346 Y74.026
G1 X135.828 Y76.544 E.05606
G1 X135.828 Y75.981
G1 X138.346 Y73.463 E.05606
G1 X138.346 Y72.899
G1 X135.828 Y75.417 E.05606
G1 X135.828 Y74.854
G1 X138.346 Y72.335 E.05606
M73 P90 R7
G1 X138.346 Y71.772
G1 X135.828 Y74.29 E.05606
G1 X135.828 Y73.726
G1 X138.346 Y71.208 E.05606
G1 X138.346 Y70.645
G1 X135.828 Y73.163 E.05606
G1 X135.828 Y72.599
G1 X138.346 Y70.081 E.05606
G1 X138.346 Y69.517
G1 X135.828 Y72.036 E.05606
G1 X135.828 Y71.472
G1 X138.346 Y68.954 E.05606
G1 X138.346 Y68.39
G1 X135.828 Y70.908 E.05606
G1 X135.828 Y70.345
G1 X138.346 Y67.827 E.05606
G1 X138.346 Y67.263
G1 X135.828 Y69.781 E.05606
G1 X135.828 Y69.218
G1 X138.346 Y66.699 E.05606
G1 X138.346 Y66.136
G1 X135.828 Y68.654 E.05606
G1 X135.828 Y68.09
G1 X138.099 Y65.819 E.05057
G1 X137.536 Y65.819
G1 X135.828 Y67.527 E.03802
G1 X135.828 Y66.963
G1 X136.972 Y65.819 E.02547
G1 X136.409 Y65.819
G1 X135.828 Y66.399 E.01293
G1 E-.8 F1800
M204 S10000
G1 X138.303 Y73.619 Z2.4 F30000
G1 X139.425 Y76.892 Z2.4
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X149.249 Y67.068 E.21869
G1 X149.249 Y66.505
G1 X140.338 Y75.416 E.19837
G1 E-.8 F1800
M204 S10000
G1 X141.251 Y73.94 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X149.249 Y65.941 E.17806
G1 X148.808 Y65.819
G1 X142.163 Y72.464 E.14792
G1 E-.8 F1800
M204 S10000
G1 X143.076 Y70.987 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X148.244 Y65.819 E.11506
G1 X147.681 Y65.819
G1 X143.988 Y69.511 E.0822
G1 E-.8 F1800
M204 S10000
G1 X144.901 Y68.035 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F720
M204 S2000
G1 X147.117 Y65.819 E.04934
G1 X146.554 Y65.819
G1 X145.813 Y66.559 E.01648
G1 E-.8 F1800
M204 S10000
G1 X141.847 Y73.08 Z2.4 F30000
G1 X139.49 Y76.956 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.198256
G1 F3600
M204 S1000
G1 X139.366 Y77.112 E.00138
; LINE_WIDTH: 0.153739
G3 X138.957 Y77.522 I-1.522 J-1.11 E.00304
G1 E-.8 F1800
M204 S10000
G1 X140.402 Y75.48 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X140.246 Y75.677 E.00169
; LINE_WIDTH: 0.142414
G1 X140.09 Y75.874 E.0012
; LINE_WIDTH: 0.0936598
G1 X139.934 Y76.072 E.00072
G1 E-.8 F1800
M204 S10000
G1 X141.315 Y74.004 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191156
G1 F3600
M204 S1000
G1 X141.159 Y74.201 E.00169
; LINE_WIDTH: 0.142407
G1 X141.003 Y74.398 E.0012
; LINE_WIDTH: 0.093657
G1 X140.847 Y74.595 E.00072
G1 E-.8 F1800
M204 S10000
G1 X142.227 Y72.528 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X142.071 Y72.725 E.00169
; LINE_WIDTH: 0.142414
G1 X141.915 Y72.922 E.0012
; LINE_WIDTH: 0.0936598
G1 X141.759 Y73.119 E.00072
G1 E-.8 F1800
M204 S10000
G1 X143.14 Y71.052 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191156
G1 F3600
M204 S1000
G1 X142.984 Y71.249 E.00169
; LINE_WIDTH: 0.142407
G1 X142.828 Y71.446 E.0012
; LINE_WIDTH: 0.093657
G1 X142.672 Y71.643 E.00072
G1 E-.8 F1800
M204 S10000
G1 X144.052 Y69.575 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191156
G1 F3600
M204 S1000
G1 X143.896 Y69.773 E.00169
; LINE_WIDTH: 0.142407
G1 X143.74 Y69.97 E.0012
; LINE_WIDTH: 0.0936571
G1 X143.584 Y70.167 E.00072
G1 E-.8 F1800
M204 S10000
G1 X144.965 Y68.099 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X144.809 Y68.296 E.00169
; LINE_WIDTH: 0.142414
G1 X144.653 Y68.494 E.0012
; LINE_WIDTH: 0.09366
G1 X144.497 Y68.691 E.00072
G1 E-.8 F1800
M204 S10000
G1 X145.878 Y66.623 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X145.722 Y66.82 E.00169
; LINE_WIDTH: 0.142414
G1 X145.566 Y67.017 E.0012
; LINE_WIDTH: 0.09366
G1 X145.41 Y67.214 E.00072
G1 E-.8 F1800
M204 S10000
G1 X145.755 Y71.438 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0935903
G1 F3600
M204 S1000
G1 X145.602 Y71.632 E.0007
; LINE_WIDTH: 0.142202
G1 X145.449 Y71.827 E.00118
; LINE_WIDTH: 0.190815
G1 X145.295 Y72.021 E.00165
M204 S10000
G1 X144.863 Y72.894 F30000
; LINE_WIDTH: 0.0935903
G1 F3600
M204 S1000
G1 X144.709 Y73.088 E.0007
; LINE_WIDTH: 0.142202
G1 X144.556 Y73.282 E.00118
; LINE_WIDTH: 0.190815
G1 X144.403 Y73.477 E.00165
M204 S10000
G1 X143.97 Y74.35 F30000
; LINE_WIDTH: 0.0935901
G1 F3600
M204 S1000
G1 X143.817 Y74.544 E.0007
; LINE_WIDTH: 0.142202
G1 X143.664 Y74.738 E.00118
; LINE_WIDTH: 0.190815
G1 X143.511 Y74.932 E.00165
M204 S10000
G1 X143.078 Y75.806 F30000
; LINE_WIDTH: 0.0935907
G1 F3600
M204 S1000
G1 X142.925 Y76 E.0007
; LINE_WIDTH: 0.142203
G1 X142.772 Y76.194 E.00118
; LINE_WIDTH: 0.190815
G1 X142.619 Y76.388 E.00165
M204 S10000
G1 X142.186 Y77.262 F30000
; LINE_WIDTH: 0.0935903
G1 F3600
M204 S1000
G1 X142.033 Y77.456 E.0007
; LINE_WIDTH: 0.142202
G1 X141.88 Y77.65 E.00118
; LINE_WIDTH: 0.190815
G1 X141.726 Y77.844 E.00165
M204 S10000
G1 X141.294 Y78.717 F30000
; LINE_WIDTH: 0.0935926
G1 F3600
M204 S1000
G1 X141.14 Y78.912 E.0007
; LINE_WIDTH: 0.142209
G1 X140.987 Y79.106 E.00118
; LINE_WIDTH: 0.190826
G1 X140.834 Y79.3 E.00165
M204 S10000
G1 X140.401 Y80.173 F30000
; LINE_WIDTH: 0.0935927
G1 F3600
M204 S1000
G1 X140.248 Y80.367 E.0007
; LINE_WIDTH: 0.14221
G1 X140.095 Y80.562 E.00118
; LINE_WIDTH: 0.190826
G1 X139.942 Y80.756 E.00165
M204 S10000
G1 X139.509 Y81.629 F30000
; LINE_WIDTH: 0.093616
G1 F3600
M204 S1000
G1 X139.357 Y81.822 E.0007
; LINE_WIDTH: 0.142279
G1 X139.205 Y82.015 E.00117
; LINE_WIDTH: 0.190942
G1 X139.053 Y82.208 E.00165
; LINE_WIDTH: 0.239606
G1 X138.9 Y82.401 E.00212
; LINE_WIDTH: 0.288269
G1 X138.748 Y82.594 E.00259
; LINE_WIDTH: 0.336932
G1 X138.596 Y82.787 E.00306
; LINE_WIDTH: 0.385595
G1 X138.444 Y82.98 E.00354
; CHANGE_LAYER
; Z_HEIGHT: 2.1
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F3600
G1 X138.596 Y82.787 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 21/58
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
M106 S226.95
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.4 I-.294 J1.181 P1  F30000
G1 X176.634 Y92.264 Z2.4
G1 X176.201 Y91.9
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.5 F30000
G1 X181.348 Y92.311
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.5 F30000
G1 X208.865 Y80.032
G1 X208.501 Y79.6
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 21 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer21 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.5 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1260
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
G1 F6000
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.5 F30000
G1 X208.933 Y80.032
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.5 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1260
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 F6000
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.5 F30000
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
G1 F3600
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.5 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.5 F30000
G1 X192.634 Y56.458
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.5 F30000
G1 X176.634 Y56.42
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.5 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.5 F30000
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.5 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.5 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P90 R6
G1 X123.291 Y92.55 Z2.5 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1260
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1260
M204 S1000
G1 X141.291 Y92.39 E.10565
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 22/58
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.5 I-1.217 J0 P1  F30000
G1 X139.291 Y92.55 Z2.5
G1 X141.348 Y92.362
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.6 F30000
G1 X181.348 Y92.311
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.6 F30000
G1 X208.865 Y80.032
G1 X208.501 Y79.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 22 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer22 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.6 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1262
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
G1 F6000
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.6 F30000
G1 X208.933 Y80.032
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.6 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1262
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 F6000
M73 P91 R6
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.6 F30000
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
G1 F3600
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.6 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.6 F30000
G1 X192.634 Y56.458
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.6 F30000
G1 X176.634 Y56.42
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.6 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.6 F30000
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.6 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.6 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y92.55 Z2.6 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X141.291 Y92.39 E.10565
; CHANGE_LAYER
; Z_HEIGHT: 2.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 23/58
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.6 I-1.217 J0 P1  F30000
G1 X139.291 Y92.55 Z2.6
G1 X141.348 Y92.362
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.7 F30000
G1 X181.348 Y92.311
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.7 F30000
G1 X208.865 Y80.032
G1 X208.501 Y79.6
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 23 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer23 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.7 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1262
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
G1 F6000
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.7 F30000
G1 X208.933 Y80.032
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.7 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1262
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 F6000
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.7 F30000
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
G1 F3600
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.7 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.7 F30000
G1 X192.634 Y56.458
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.7 F30000
G1 X176.634 Y56.42
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.7 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.7 F30000
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.7 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.7 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y92.55 Z2.7 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X141.291 Y92.39 E.10565
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 24/58
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.7 I-1.217 J0 P1  F30000
G1 X139.291 Y92.55 Z2.7
G1 X141.348 Y92.362
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
M204 S10000
G1 X176.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X181.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y92.55 Z2.8 F30000
G1 X181.348 Y92.311
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
M204 S10000
G1 X192.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X197.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y92.55 Z2.8 F30000
G1 X208.865 Y80.032
G1 X208.501 Y79.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 24 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer24 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y79.6 E-.3731
G1 X209.481 Y80.09 E-.1862
G1 X209.481 Y80.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y80.618 Z2.8 F30000
G1 X208.865 Y84.747
G1 X208.991 Y84.747
G1 X208.991 Y84.69
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1262
M204 S1000
G1 X208.991 Y80.09 E.10564
; WIPE_START
G1 F6000
G1 X208.991 Y82.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y82.09 Z2.8 F30000
G1 X208.933 Y80.032
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
; WIPE_START
G1 F3600
M204 S1000
G1 X209.481 Y64.6 E-.3731
G1 X209.481 Y65.09 E-.1862
G1 X209.481 Y65.618 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y65.618 Z2.8 F30000
G1 X208.865 Y69.747
G1 X208.991 Y69.747
G1 X208.991 Y69.69
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F1262
M204 S1000
G1 X208.991 Y65.09 E.10564
; WIPE_START
G1 F6000
G1 X208.991 Y67.09 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.151 Y67.09 Z2.8 F30000
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
G1 F3600
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.55 Z2.8 F30000
G1 X192.634 Y56.515
G1 X192.634 Y56.39
G1 X192.691 Y56.39
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X197.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X195.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.291 Y56.55 Z2.8 F30000
G1 X192.634 Y56.458
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
M204 S10000
G1 X176.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X181.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X179.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y56.55 Z2.8 F30000
G1 X176.634 Y56.42
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
M204 S10000
G1 X136.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X141.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X139.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.291 Y56.55 Z2.8 F30000
G1 X136.634 Y56.458
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
M204 S10000
G1 X120.691 Y56.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X125.291 Y56.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y56.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y56.55 Z2.8 F30000
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.991 Y65.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X106.991 Y69.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y67.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y67.69 Z2.8 F30000
G1 X107.075 Y69.747
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X106.991 Y80.09 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X106.991 Y84.69 E.10565
; WIPE_START
G1 F6000
G1 X106.991 Y82.69 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.151 Y82.69 Z2.8 F30000
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
M204 S10000
G1 X120.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X125.291 Y92.39 E.10565
; WIPE_START
G1 F6000
G1 X123.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.291 Y92.55 Z2.8 F30000
G1 X125.348 Y92.311
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1262
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
M204 S10000
G1 X136.691 Y92.39 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F1262
M204 S1000
G1 X141.291 Y92.39 E.10565
; CHANGE_LAYER
; Z_HEIGHT: 2.5
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X139.291 Y92.39 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 272
M625
; layer num/total_layer_count: 25/58
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
M106 S191.25
; OBJECT_ID: 272
; start printing object, unique label id: 272
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.8 I1.217 J-.001 P1  F30000
G1 X139.291 Y92.292 Z2.8
G1 X141.348 Y92.29
G1 X176.634 Y92.264
G1 X176.201 Y91.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X181.781 Y91.9 E.08783
G1 X181.781 Y92.39 E.00771
G1 X181.781 Y92.88 E.00771
G1 X176.201 Y92.88 E.08783
G1 X176.201 Y91.96 E.01448
; WIPE_START
M204 S1000
G1 X178.201 Y91.938 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.201 Y92.229 Z2.9 F30000
G1 X181.074 Y92.229
G1 X181.074 Y92.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X181.562 Y92.606 E.01085
G1 X181.052 Y92.66
G1 X180.511 Y92.119 E.01206
G1 X179.947 Y92.119
G1 X180.489 Y92.66 E.01206
G1 X179.925 Y92.66
G1 X179.383 Y92.119 E.01206
G1 X178.82 Y92.119
G1 X179.361 Y92.66 E.01206
G1 X178.798 Y92.66
G1 X178.256 Y92.119 E.01206
G1 X177.693 Y92.119
G1 X178.234 Y92.66 E.01206
G1 X177.671 Y92.66
G1 X177.129 Y92.119 E.01206
G1 X176.565 Y92.119
G1 X177.107 Y92.66 E.01206
; WIPE_START
M204 S1000
G1 X176.565 Y92.119 E-.29108
G1 X177.129 Y92.119 E-.21417
G1 X177.603 Y92.593 E-.25475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.603 Y92.55 Z2.9 F30000
G1 X179.821 Y92.488
G1 X192.634 Y92.264
G1 X192.201 Y91.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X197.781 Y91.9 E.08783
G1 X197.781 Y92.39 E.00771
G1 X197.781 Y92.88 E.00771
G1 X192.201 Y92.88 E.08783
G1 X192.201 Y91.96 E.01448
; WIPE_START
M204 S1000
G1 X194.201 Y91.938 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X194.201 Y92.229 Z2.9 F30000
G1 X196.855 Y92.229
G1 X196.855 Y92.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X197.397 Y92.66 E.01206
G1 X196.833 Y92.66
G1 X196.292 Y92.119 E.01206
G1 X195.728 Y92.119
G1 X196.27 Y92.66 E.01206
G1 X195.706 Y92.66
G1 X195.164 Y92.119 E.01206
G1 X194.601 Y92.119
G1 X195.142 Y92.66 E.01206
G1 X194.579 Y92.66
G1 X194.037 Y92.119 E.01206
G1 X193.474 Y92.119
G1 X194.015 Y92.66 E.01206
G1 X193.452 Y92.66
G1 X192.91 Y92.119 E.01206
G1 X192.42 Y92.192
G1 X192.888 Y92.66 E.01042
G1 E-.8 F1800
M204 S10000
G1 X197.556 Y92.68 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0727399
G1 F3600
M204 S1000
G1 X197.556 Y92.099 E.00118
; WIPE_START
G1 X197.556 Y92.68 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X202.454 Y86.827 Z2.9 F30000
G1 X208.501 Y79.6 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y79.6 E.01543
G1 X209.481 Y80.09 E.00771
G1 X209.481 Y85.18 E.08012
; object ids of layer 25 start: 272
M624 AQAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer25 end: 272
M625
G1 X208.501 Y85.18 E.01543
G1 X208.501 Y79.66 E.08689
M204 S10000
G1 X209.262 Y80.29 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X208.79 Y79.819 E.01049
G1 X208.72 Y80.312
G1 X209.262 Y80.854 E.01206
G1 X209.262 Y81.417
G1 X208.72 Y80.876 E.01206
G1 X208.72 Y81.439
G1 X209.262 Y81.981 E.01206
M73 P92 R6
G1 X209.262 Y82.545
G1 X208.72 Y82.003 E.01206
G1 X208.72 Y82.567
G1 X209.262 Y83.108 E.01206
G1 X209.262 Y83.672
G1 X208.72 Y83.13 E.01206
G1 X208.72 Y83.694
G1 X209.262 Y84.235 E.01206
G1 X209.262 Y84.799
G1 X208.72 Y84.257 E.01206
; WIPE_START
M204 S1000
G1 X209.262 Y84.799 E-.29107
G1 X209.262 Y84.235 E-.21417
G1 X208.788 Y83.761 E-.25476
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X208.83 Y83.761 Z2.9 F30000
G1 X208.837 Y80.166
G1 X208.857 Y69.706
G1 X208.865 Y65.032
G1 X208.501 Y64.6
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X209.481 Y64.6 E.01543
G1 X209.481 Y65.09 E.00771
G1 X209.481 Y70.18 E.08012
G1 X208.501 Y70.18 E.01543
G1 X208.501 Y64.66 E.08689
M204 S10000
G1 X208.72 Y65.095 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X209.262 Y65.636 E.01206
G1 X209.262 Y66.2
G1 X208.72 Y65.658 E.01206
G1 X208.72 Y66.222
G1 X209.262 Y66.764 E.01206
G1 X209.262 Y67.327
G1 X208.72 Y66.786 E.01206
G1 X208.72 Y67.349
G1 X209.262 Y67.891 E.01206
G1 X209.262 Y68.454
G1 X208.72 Y67.913 E.01206
G1 X208.72 Y68.476
G1 X209.262 Y69.018 E.01206
G1 X209.262 Y69.582
G1 X208.72 Y69.04 E.01206
G1 E-.8 F1800
M204 S10000
G1 X209.282 Y64.89 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.203318
G1 F3600
M204 S1000
G1 X208.797 Y64.89 E.00348
G1 X208.7 Y64.93 E.00075
G1 E-.8 F1800
M204 S10000
G1 X209.282 Y69.633 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.228153
G1 F3600
M204 S1000
G1 X209.216 Y69.741 E.00103
; LINE_WIDTH: 0.264538
G1 X209.151 Y69.85 E.00122
; LINE_WIDTH: 0.303057
G1 X208.7 Y69.783 E.00507
; WIPE_START
G1 X209.151 Y69.85 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X208.893 Y69.747 Z2.9 F30000
G1 X208.83 Y69.484
G1 X197.348 Y56.515
G1 X197.781 Y56.88
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X192.201 Y56.88 E.08783
G1 X192.201 Y55.9 E.01543
G1 X197.781 Y55.9 E.08783
G1 X197.781 Y56.39 E.00771
G1 X197.781 Y56.82 E.00677
; WIPE_START
M204 S1000
G1 X195.781 Y56.841 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X195.781 Y56.292 Z2.9 F30000
G1 X197.182 Y56.229
G1 X196.926 Y56.229
G1 X196.926 Y56.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X197.468 Y56.66 E.01206
G1 X196.904 Y56.66
G1 X196.362 Y56.119 E.01206
G1 X195.799 Y56.119
G1 X196.34 Y56.66 E.01206
G1 X195.777 Y56.66
G1 X195.235 Y56.119 E.01206
G1 X194.672 Y56.119
G1 X195.213 Y56.66 E.01206
G1 X194.65 Y56.66
G1 X194.108 Y56.119 E.01206
G1 X193.544 Y56.119
G1 X194.086 Y56.66 E.01206
G1 X193.522 Y56.66
G1 X192.981 Y56.119 E.01206
G1 X192.42 Y56.122
G1 X192.959 Y56.66 E.01199
; WIPE_START
M204 S1000
G1 X192.42 Y56.122 E-.28954
G1 X192.981 Y56.119 E-.21308
G1 X193.46 Y56.598 E-.25738
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X193.46 Y56.55 Z2.9 F30000
G1 X192.793 Y56.549
G1 X181.302 Y56.525
G1 X176.634 Y56.515
G1 X176.201 Y56.88
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X176.201 Y55.9 E.01543
G1 X181.781 Y55.9 E.08783
G1 X181.781 Y56.39 E.00771
G1 X181.781 Y56.88 E.00771
G1 X176.261 Y56.88 E.08689
; WIPE_START
M204 S1000
G1 X176.201 Y55.9 E-.37311
G1 X177.219 Y55.9 E-.38689
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.219 Y56.229 Z2.9 F30000
G1 X181.145 Y56.229
G1 X181.145 Y56.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X181.562 Y56.535 E.00928
G1 X181.123 Y56.66
G1 X180.581 Y56.119 E.01206
G1 X180.018 Y56.119
G1 X180.559 Y56.66 E.01206
G1 X179.996 Y56.66
G1 X179.454 Y56.119 E.01206
G1 X178.891 Y56.119
G1 X179.432 Y56.66 E.01206
G1 X178.869 Y56.66
G1 X178.327 Y56.119 E.01206
G1 X177.763 Y56.119
M73 P92 R5
G1 X178.305 Y56.66 E.01206
G1 X177.741 Y56.66
G1 X177.2 Y56.119 E.01206
G1 X176.636 Y56.119
G1 X177.178 Y56.66 E.01206
M204 S10000
G1 X176.456 Y56.099 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132876
G1 F3600
M204 S1000
G1 X176.456 Y56.68 E.00256
; WIPE_START
G1 X176.456 Y56.099 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X176.634 Y56.264 Z2.9 F30000
G1 X141.037 Y56.488
G1 X136.799 Y56.55
G1 X136.634 Y56.515
G1 X136.201 Y56.88
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X136.201 Y55.9 E.01543
G1 X141.781 Y55.9 E.08783
G1 X141.781 Y56.39 E.00771
G1 X141.781 Y56.88 E.00771
G1 X136.261 Y56.88 E.08689
; WIPE_START
M204 S1000
G1 X136.201 Y55.9 E-.3731
G1 X137.219 Y55.9 E-.3869
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.219 Y56.229 Z2.9 F30000
G1 X141.129 Y56.229
G1 X141.129 Y56.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X141.562 Y56.551 E.00963
G1 X141.107 Y56.66
G1 X140.565 Y56.119 E.01206
G1 X140.002 Y56.119
G1 X140.543 Y56.66 E.01206
G1 X139.98 Y56.66
G1 X139.438 Y56.119 E.01206
G1 X138.874 Y56.119
G1 X139.416 Y56.66 E.01206
G1 X138.853 Y56.66
G1 X138.311 Y56.119 E.01206
G1 X137.747 Y56.119
G1 X138.289 Y56.66 E.01206
G1 X137.725 Y56.66
G1 X137.184 Y56.119 E.01206
G1 X136.62 Y56.119
G1 X137.162 Y56.66 E.01206
M204 S10000
G1 X136.446 Y56.099 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.114086
G1 F3600
M204 S1000
G1 X136.446 Y56.68 E.00213
; WIPE_START
G1 X136.446 Y56.099 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.634 Y56.264 Z2.9 F30000
G1 X122.395 Y56.488
G1 X120.634 Y56.515
G1 X120.201 Y56.88
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X120.201 Y55.9 E.01543
G1 X125.781 Y55.9 E.08783
G1 X125.781 Y56.39 E.00771
G1 X125.781 Y56.88 E.00771
G1 X120.261 Y56.88 E.08689
; WIPE_START
M204 S1000
G1 X120.201 Y55.9 E-.3731
G1 X121.219 Y55.9 E-.3869
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.219 Y56.229 Z2.9 F30000
G1 X124.784 Y56.229
G1 X124.784 Y56.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X125.326 Y56.66 E.01206
G1 X124.762 Y56.66
G1 X124.221 Y56.119 E.01206
G1 X123.657 Y56.119
G1 X124.199 Y56.66 E.01206
G1 X123.635 Y56.66
G1 X123.093 Y56.119 E.01206
G1 X122.53 Y56.119
G1 X123.072 Y56.66 E.01206
G1 X122.508 Y56.66
G1 X121.966 Y56.119 E.01206
G1 X121.403 Y56.119
G1 X121.944 Y56.66 E.01206
G1 X121.381 Y56.66
G1 X120.839 Y56.119 E.01206
G1 X120.42 Y56.263
G1 X120.817 Y56.66 E.00884
G1 E-.8 F1800
M204 S10000
G1 X125.467 Y56.68 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.158541
G1 F3600
M204 S1000
G1 X125.514 Y56.567 E.00066
G1 X125.514 Y56.099 E.00253
; WIPE_START
G1 X125.514 Y56.567 E-.60208
G1 X125.467 Y56.68 E-.15792
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.348 Y56.515 Z2.9 F30000
G1 X107.116 Y65.032
G1 X107.481 Y64.6
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X107.481 Y65.09 E.00771
G1 X107.481 Y70.18 E.08012
G1 X106.501 Y70.18 E.01543
G1 X106.501 Y64.6 E.08783
G1 X107.421 Y64.6 E.01448
M204 S10000
G1 X106.72 Y65.107 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X107.262 Y65.649 E.01206
G1 X107.262 Y66.213
G1 X106.72 Y65.671 E.01206
G1 X106.72 Y66.235
G1 X107.262 Y66.776 E.01206
G1 X107.262 Y67.34
G1 X106.72 Y66.798 E.01206
G1 X106.72 Y67.362
G1 X107.262 Y67.904 E.01206
G1 X107.262 Y68.467
G1 X106.72 Y67.926 E.01206
G1 X106.72 Y68.489
G1 X107.262 Y69.031 E.01206
G1 X107.262 Y69.594
G1 X106.72 Y69.053 E.01206
G1 E-.8 F1800
M204 S10000
G1 X107.282 Y64.902 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.214669
G1 F3600
M204 S1000
G1 X106.796 Y64.895 E.0037
G1 X106.7 Y65.119 E.00186
G1 E-.8 F1800
M204 S10000
G1 X107.282 Y69.639 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.22538
G1 F3600
M204 S1000
G1 X107.219 Y69.747 E.001
; LINE_WIDTH: 0.256219
G1 X107.156 Y69.855 E.00116
; LINE_WIDTH: 0.29006
G1 X106.7 Y69.794 E.00489
; WIPE_START
G1 X107.156 Y69.855 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.116 Y69.747 Z2.9 F30000
G1 X107.116 Y69.747
G1 X107.116 Y80.032
G1 X107.116 Y80.032
G1 X107.481 Y79.6
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X107.481 Y80.09 E.00771
G1 X107.481 Y85.18 E.08012
G1 X106.501 Y85.18 E.01543
G1 X106.501 Y79.6 E.08783
G1 X107.421 Y79.6 E.01448
M204 S10000
G1 X107.262 Y80.303 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X106.777 Y79.819 E.01078
G1 X106.72 Y80.325
G1 X107.262 Y80.867 E.01206
G1 X107.262 Y81.43
G1 X106.72 Y80.888 E.01206
G1 X106.72 Y81.452
G1 X107.262 Y81.994 E.01206
G1 X107.262 Y82.557
G1 X106.72 Y82.016 E.01206
G1 X106.72 Y82.579
G1 X107.262 Y83.121 E.01206
G1 X107.262 Y83.685
G1 X106.72 Y83.143 E.01206
G1 X106.72 Y83.706
G1 X107.262 Y84.248 E.01206
G1 X107.262 Y84.812
G1 X106.72 Y84.27 E.01206
; WIPE_START
M204 S1000
G1 X107.262 Y84.812 E-.29108
G1 X107.262 Y84.248 E-.21417
G1 X106.788 Y83.774 E-.25475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.83 Y83.774 Z2.9 F30000
G1 X106.893 Y83.838
G1 X107.089 Y83.957
G1 X107.151 Y83.995
G1 X120.634 Y92.264
G1 X120.201 Y91.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X125.781 Y91.9 E.08783
G1 X125.781 Y92.39 E.00771
G1 X125.781 Y92.88 E.00771
G1 X120.201 Y92.88 E.08783
G1 X120.201 Y91.96 E.01448
; WIPE_START
M204 S1000
G1 X122.201 Y91.938 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.201 Y92.229 Z2.9 F30000
G1 X124.714 Y92.229
G1 X124.714 Y92.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X125.255 Y92.66 E.01206
G1 X124.692 Y92.66
G1 X124.15 Y92.119 E.01206
G1 X123.586 Y92.119
G1 X124.128 Y92.66 E.01206
G1 X123.564 Y92.66
G1 X123.023 Y92.119 E.01206
G1 X122.459 Y92.119
G1 X123.001 Y92.66 E.01206
G1 X122.437 Y92.66
G1 X121.895 Y92.119 E.01206
G1 X121.332 Y92.119
G1 X121.874 Y92.66 E.01206
G1 X121.31 Y92.66
G1 X120.768 Y92.119 E.01206
G1 E-.8 F1800
M204 S10000
G1 X125.456 Y92.099 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.2273
G1 F3600
M204 S1000
G1 X125.479 Y92.578 E.0039
G1 X125.261 Y92.68 E.00196
G1 E-.8 F1800
M204 S10000
G1 X120.733 Y92.099 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.233458
G1 F3600
M204 S1000
G1 X120.518 Y92.217 E.00205
; LINE_WIDTH: 0.272336
G1 X120.57 Y92.68 E.00462
; WIPE_START
G1 X120.518 Y92.217 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.634 Y92.264 Z2.9 F30000
G1 X125.348 Y92.264
G1 X136.634 Y92.264
G1 X136.634 Y92.264
G1 X136.201 Y91.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X141.781 Y91.9 E.08783
G1 X141.781 Y92.39 E.00771
G1 X141.781 Y92.88 E.00771
G1 X136.201 Y92.88 E.08783
G1 X136.201 Y91.96 E.01448
; WIPE_START
M204 S1000
G1 X138.201 Y91.938 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.201 Y92.229 Z2.9 F30000
G1 X141.058 Y92.229
G1 X141.058 Y92.119
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F720
M204 S2000
G1 X141.562 Y92.622 E.01121
G1 X141.036 Y92.66
G1 X140.495 Y92.119 E.01206
G1 X139.931 Y92.119
G1 X140.473 Y92.66 E.01206
G1 X139.909 Y92.66
G1 X139.367 Y92.119 E.01206
G1 X138.804 Y92.119
G1 X139.345 Y92.66 E.01206
G1 X138.782 Y92.66
G1 X138.24 Y92.119 E.01206
G1 X137.676 Y92.119
G1 X138.218 Y92.66 E.01206
G1 X137.655 Y92.66
G1 X137.113 Y92.119 E.01206
G1 X136.549 Y92.119
G1 X137.091 Y92.66 E.01206
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F5400
M204 S1000
G1 X136.549 Y92.119 E-.7277
G1 X137.113 Y92.119 E-.53543
G1 X137.587 Y92.593 E-.63687
; WIPE_END
G1 E-.09999 F1800
; stop printing object, unique label id: 272
M625
; filament end gcode 

M204 S10000
G17
G3 Z2.9 I1.217 J0 P1  F30000
;=X1 20251031=
M620 S0A
M204 S9000
G1 Z5.5 F1200

G1 X70 F21000
G1 Y245
G1 Y265 F3000
M400
M106 P1 S0
M106 P2 S0

M104 S255


M620.11 S0

M400
G1 X90 F3000
G1 Y255 F4000
G1 X100 F5000
G1 X120 F15000
G1 X20 Y50 F21000
G1 Y-3

; get travel path for change filament
M620.1 X54 Y0 F21000 P0
M620.1 X54 Y0 F21000 P1
M620.1 X54 Y245 F21000 P2

M620.1 E F299.339 T270
T0
M73 E0
M620.1 E F399.119 T240



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S240


G1 E23.7 F299.339 ; do not need pulsatile flushing for start part
G1 E0.914611 F50
G1 E10.518 F299.339
G1 E0.914611 F50
G1 E10.518 F399.119
G1 E0.914611 F50
G1 E10.518 F399.119
G1 E0.914611 F50
G1 E10.518 F399.119

; FLUSH_END
G1 E-2 F1800
G1 E2 F300







; FLUSH_START
M400
M109 S220
G1 E2 F399.119 ;Compensate for filament spillage during waiting temperature
; FLUSH_END
M400
G92 E0
G1 E-2 F1800
M106 P1 S255
M400 S3

G1 X70 F5000
G1 X90 F3000
G1 Y255 F4000
G1 X105 F5000
G1 Y265 F5000
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000

G1 X70 F10000
G1 X80 F15000
G1 X60
G1 X80
G1 X60
G1 X80 ; shake to put down garbage
G1 X100 F5000
G1 X165 F15000; wipe and shake
G1 Y256 ; move Y to aside, prevent collision
M400
G1 Z5.5 F3000

M204 S500


M621 S0A
;_FORCE_RESUME_FAN_SPEED
M104 S220 ; set nozzle temperature
; filament start gcode
M106 P3 S150


G1 Z2.9 F30000
G1 X137.587 Y92.546 F30000
G1 Z3.3 F30000
G1 X203.061 Y201.098 F30000
G1 X203.784 Y202.295 F30000
G1 X204.418 Y203.346 F30000
M104 S220 ; set nozzle temperature
; CHANGE_LAYER
; Z_HEIGHT: 0.1
; LAYER_HEIGHT: 0.1
; layer num/total_layer_count: 26/58
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
M106 S0
M106 P2 S0
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S6000
G1 X211.302 Y194.272 Z.1 F30000
G1 E2 F1800
; FEATURE: Support
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G3 X213.154 Y194.866 I-.529 J4.831 E.03816
G3 X213.643 Y196.621 I-4.792 J2.282 E.0357
G1 X213.643 Y206.923 E.20085
G3 X211.271 Y209.271 I-2.403 J-.055 E.07195
G1 X207.044 Y209.271 E.08241
G3 X205.543 Y208.756 I.112 J-2.767 E.03138
G3 X205.244 Y211.074 I-4.644 J.58 E.04606
G3 X204.412 Y212.238 I-9.525 J-5.934 E.02792
G3 X203.036 Y212.421 I-2.004 J-9.766 E.02708
G1 X197.701 Y212.421 E.10402
G3 X195.193 Y209.914 I.069 J-2.577 E.07624
G1 X195.193 Y201.228 E.16936
G3 X197.699 Y198.721 I2.577 J.07 E.07619
G1 X202.01 Y198.721 E.08406
G3 X202.793 Y198.671 I.517 J1.943 E.01539
G1 X204.693 Y198.672 E.03705
G3 X204.705 Y196.404 I20.411 J-1.025 E.04423
G3 X207.042 Y194.271 I2.394 J.276 E.0673
G1 X211.231 Y194.272 E.08166
M204 S6000
G1 X200.695 Y203.023 F30000
G1 F900
M204 S500
G1 X201.257 Y203.053 E.01096
G1 X201.969 Y203.228 E.0143
G1 X202.618 Y203.543 E.01407
G1 X203.069 Y203.879 E.01097
G1 X203.566 Y204.419 E.0143
G1 X203.932 Y205.04 E.01407
G1 X204.123 Y205.569 E.01096
G1 X204.239 Y206.294 E.0143
G1 X204.2 Y207.014 E.01408
G1 X204.008 Y207.722 E.01429
G1 X203.671 Y208.374 E.0143
G1 X203.324 Y208.816 E.01096
G1 X202.781 Y209.291 E.01406
G1 X202.296 Y209.577 E.01098
G1 X201.606 Y209.824 E.01428
G1 X200.891 Y209.92 E.01407
G1 X200.329 Y209.89 E.01096
G1 X199.617 Y209.715 E.0143
G1 X198.968 Y209.399 E.01407
G1 X198.517 Y209.064 E.01096
G1 X198.027 Y208.533 E.01408
G1 X197.654 Y207.902 E.0143
G1 X197.463 Y207.373 E.01096
G1 X197.348 Y206.649 E.0143
G1 X197.386 Y205.928 E.01407
G1 X197.578 Y205.22 E.01431
G1 X197.824 Y204.715 E.01096
G1 X198.254 Y204.136 E.01407
G1 X198.805 Y203.652 E.0143
G1 X199.29 Y203.366 E.01097
G1 X199.969 Y203.121 E.01407
G1 X200.624 Y203.027 E.01291
G1 E-.8 F1800
M204 S6000
G1 X207.646 Y206.017 Z.5 F30000
G1 X212.925 Y208.266 Z.5
M73 P93 R4
G1 Z.1
G1 E.8 F1800
M73 P94 R4
G1 F900
M204 S500
G1 X212.925 Y195.518 E.24856
G1 X212.811 Y195.19 E.00676
G1 X212.394 Y195.018 E.0088
G1 X212.394 Y208.468 E.26226
G3 X211.862 Y208.741 I-1.971 J-3.184 E.01167
G1 X211.862 Y194.801 E.27179
G2 X211.33 Y194.705 I-.628 J1.949 E.01057
G1 X211.33 Y208.841 E.27561
G1 X210.799 Y208.841 E.01037
G1 X210.799 Y194.703 E.27566
G1 X210.267 Y194.703 E.01037
G1 X210.267 Y208.841 E.27566
G1 X209.735 Y208.841 E.01037
G1 X209.735 Y194.703 E.27566
G1 X209.204 Y194.702 E.01037
G1 X209.204 Y208.841 E.27566
G1 X208.672 Y208.841 E.01037
G1 X208.672 Y194.702 E.27566
G1 X208.14 Y194.702 E.01037
G1 X208.14 Y208.841 E.27566
G1 X207.608 Y208.841 E.01037
G1 X207.608 Y194.702 E.27566
G1 X207.077 Y194.702 E.01037
G1 X207.077 Y208.841 E.27567
G3 X206.545 Y208.762 I.295 J-3.817 E.01049
G1 X206.545 Y194.781 E.27259
G2 X206.013 Y195.024 I1.255 J3.447 E.01141
G1 X206.013 Y208.523 E.2632
G1 X205.482 Y208.23 E.01184
G1 X205.482 Y195.541 E.24739
G2 X205.124 Y196.635 I1.857 J1.213 E.02269
G1 X205.124 Y199.102 E.04811
G1 X204.95 Y199.102 E.00339
G1 X204.95 Y210.689 E.22591
G3 X204.418 Y211.506 I-3.508 J-1.701 E.01906
G1 X204.412 Y207.874 E.07082
G3 X203.886 Y208.814 I-3.722 J-1.462 E.02106
G1 X203.886 Y211.88 E.05979
G1 X203.355 Y211.959 E.01048
G1 X203.34 Y209.399 E.04991
G3 X202.823 Y209.778 I-2.496 J-2.863 E.01251
G1 X202.823 Y211.991 E.04314
G1 X202.291 Y211.991 E.01037
G1 X202.285 Y210.054 E.03777
G3 X201.76 Y210.229 I-1.576 J-3.845 E.01081
G1 X201.76 Y211.991 E.03435
G1 X201.228 Y211.991 E.01037
G1 X201.228 Y210.327 E.03245
G1 X201.114 Y210.339 E.00223
G3 X200.696 Y210.351 I-.321 J-3.876 E.00816
G1 X200.696 Y211.991 E.03197
G1 X200.164 Y211.991 E.01037
G1 X200.164 Y210.3 E.03297
G1 X200.085 Y210.287 E.00156
G3 X199.633 Y210.174 I.888 J-4.516 E.0091
G1 X199.633 Y211.991 E.03542
G1 X199.101 Y211.991 E.01037
G1 X199.086 Y209.956 E.03966
G3 X198.569 Y209.652 I1.973 J-3.936 E.01171
G1 X198.569 Y211.991 E.04561
G1 X198.038 Y211.991 E.01037
G1 X198.038 Y209.203 E.05436
G1 X197.95 Y209.112 E.00246
G3 X197.506 Y208.532 I3.017 J-2.767 E.01427
G1 X197.506 Y211.978 E.06719
G3 X196.974 Y211.846 I.272 J-2.239 E.01071
G1 X196.974 Y199.297 E.24468
G3 X197.506 Y199.165 I.803 J2.105 E.01071
G1 X197.506 Y204.411 E.10228
G1 X197.553 Y204.335 E.00174
G3 X198.038 Y203.74 I3.403 J2.275 E.01498
G1 X198.038 Y199.152 E.08946
G1 X198.569 Y199.152 E.01037
G1 X198.572 Y203.289 E.08066
G3 X199.101 Y202.979 I2.47 J3.607 E.01196
G1 X199.101 Y199.152 E.07462
G1 X199.633 Y199.152 E.01037
G1 X199.661 Y202.759 E.07034
G3 X200.164 Y202.643 I1.208 J4.076 E.01008
G1 X200.164 Y199.152 E.06807
G1 X200.696 Y199.152 E.01037
G1 X200.702 Y202.592 E.06707
G3 X201.228 Y202.616 I.072 J4.114 E.01026
G1 X201.228 Y199.152 E.06754
G1 X201.76 Y199.152 E.01037
G1 X201.76 Y202.714 E.06944
G3 X202.291 Y202.891 I-1.059 J4.05 E.01094
G1 X202.291 Y199.104 E.07384
G3 X202.823 Y199.102 I.394 J28.567 E.01037
G1 X202.841 Y203.175 E.07942
G3 X203.355 Y203.556 I-2.248 J3.566 E.01248
G1 X203.355 Y199.102 E.08684
G1 X203.886 Y199.102 E.01037
G1 X203.901 Y204.147 E.09837
G3 X204.418 Y205.087 I-3.216 J2.382 E.02098
G1 X204.418 Y198.887 E.12089
; WIPE_START
G1 X204.418 Y200.887 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X201.986 Y204.219 Z.5 F30000
G1 X199.679 Y204.178
G1 X198.276 Y206.065
G1 X199.011 Y208.294
G1 X196.442 Y211.812
G1 Z.1
G1 E.8 F1800
G1 F900
M204 S500
G1 X196.442 Y199.599 E.23813
G2 X195.911 Y200.208 I1.582 J1.917 E.01584
G1 X195.911 Y211.318 E.21662
; WIPE_START
G1 X195.911 Y209.318 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X198.245 Y206.42 Z.5 F30000
G1 X199.327 Y204.385
M73 P94 R3
G1 X200.189 Y203.995
G1 X200.288 Y203.973
G1 X200.272 Y203.903
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.50845
G1 F900
M204 S500
G1 X200.431 Y203.864 E.00323
G1 X200.796 Y203.839 E.00727
; LINE_WIDTH: 0.49772
G1 X201.346 Y203.898 E.01072
; LINE_WIDTH: 0.50683
G1 X201.84 Y204.057 E.01027
; LINE_WIDTH: 0.50757
G1 X202.326 Y204.333 E.01107
G1 X202.745 Y204.704 E.01108
; LINE_WIDTH: 0.50295
G1 X203.076 Y205.155 E.01099
; LINE_WIDTH: 0.50573
G1 X203.3 Y205.669 E.01106
; LINE_WIDTH: 0.50793
G1 X203.412 Y206.217 E.01109
G1 X203.407 Y206.783 E.01121
; LINE_WIDTH: 0.50542
G1 X203.271 Y207.359 E.01168
; object ids of layer 26 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer26 end: 399
M625
; LINE_WIDTH: 0.5036
G1 X203.049 Y207.83 E.01023
; LINE_WIDTH: 0.50749
G1 X202.709 Y208.275 E.01109
G1 X202.284 Y208.64 E.01107
; LINE_WIDTH: 0.50668
G1 X201.788 Y208.91 E.01118
; LINE_WIDTH: 0.50144
G1 X201.229 Y209.068 E.01136
; LINE_WIDTH: 0.50664
G1 X200.697 Y209.101 E.01053
; LINE_WIDTH: 0.50754
G1 X200.144 Y209.021 E.01107
G1 X199.619 Y208.828 E.01108
; LINE_WIDTH: 0.5037
G1 X199.146 Y208.529 E.011
; LINE_WIDTH: 0.50523
G1 X198.75 Y208.132 E.01105
; LINE_WIDTH: 0.50781
G1 X198.446 Y207.661 E.0111
G1 X198.247 Y207.139 E.01108
; LINE_WIDTH: 0.50602
G1 X198.162 Y206.563 E.01149
; LINE_WIDTH: 0.49938
G1 X198.21 Y205.97 E.01159
; LINE_WIDTH: 0.50729
G1 X198.352 Y205.489 E.00992
G1 X198.615 Y204.995 E.01107
; LINE_WIDTH: 0.50699
G1 X198.974 Y204.567 E.01106
; LINE_WIDTH: 0.50195
G1 X199.429 Y204.218 E.01123
; LINE_WIDTH: 0.50627
G1 X199.925 Y203.987 E.01079
; LINE_WIDTH: 0.50845
G1 X200.214 Y203.917 E.00591
; WIPE_START
G1 X200.431 Y203.864 E-.08474
G1 X200.796 Y203.839 E-.13928
G1 X201.346 Y203.898 E-.20994
G1 X201.84 Y204.057 E-.19736
G1 X202.135 Y204.224 E-.12869
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X201.947 Y204.542 Z.5 F30000
G1 X201.869 Y204.495
G1 X201.734 Y204.428
M73 P95 R3
G1 X201.59 Y204.367
G1 X201.44 Y204.316
G1 X201.294 Y204.278
G1 X201.141 Y204.249
G1 X200.987 Y204.23
G1 X200.827 Y204.222
G1 X200.677 Y204.225
G1 X200.522 Y204.238
G1 X200.369 Y204.262
G1 X200.217 Y204.296
G1 X200.068 Y204.341
G1 X199.923 Y204.396
G1 X199.778 Y204.464
G1 X199.646 Y204.536
G1 X199.515 Y204.62
G1 X199.387 Y204.715
G1 X199.272 Y204.813
G1 X199.161 Y204.923
G1 X199.056 Y205.042
G1 X198.964 Y205.162
G1 X198.878 Y205.291
G1 X198.812 Y205.406
G1 X198.899 Y205.456
G1 Z.1
G1 E.8 F1800
; LINE_WIDTH: 0.49463
G1 F900
M204 S500
G1 X199.208 Y205.011 E.01044
; LINE_WIDTH: 0.50005
G1 X199.664 Y204.632 E.01158
G1 X200.21 Y204.396 E.01159
; LINE_WIDTH: 0.50363
G1 X200.745 Y204.317 E.01064
G1 X201.249 Y204.362 E.00993
; LINE_WIDTH: 0.49772
G1 X201.795 Y204.563 E.01129
; LINE_WIDTH: 0.49443
G1 X202.28 Y204.911 E.01152
; LINE_WIDTH: 0.49899
G1 X202.652 Y205.375 E.01156
G1 X202.879 Y205.924 E.01156
; LINE_WIDTH: 0.4957
G1 X202.948 Y206.513 E.01147
; LINE_WIDTH: 0.49663
G1 X202.858 Y207.095 E.0114
; LINE_WIDTH: 0.5036
G1 X202.638 Y207.582 E.0105
G1 X202.219 Y208.088 E.0129
; LINE_WIDTH: 0.49479
G1 X201.724 Y208.415 E.01144
; LINE_WIDTH: 0.50099
G1 X201.168 Y208.596 E.01143
G1 X200.566 Y208.615 E.01177
; LINE_WIDTH: 0.49464
G1 X199.99 Y208.472 E.01144
; LINE_WIDTH: 0.49825
G1 X199.474 Y208.178 E.01153
G1 X199.059 Y207.753 E.01154
; LINE_WIDTH: 0.49621
G1 X198.778 Y207.235 E.0114
; LINE_WIDTH: 0.49599
G1 X198.645 Y206.657 E.01146
; LINE_WIDTH: 0.50286
G1 X198.67 Y206.107 E.01082
G1 X198.867 Y205.507 E.01239
; CHANGE_LAYER
; Z_HEIGHT: 0.3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F900
G1 X199.208 Y205.011 E-.22852
G1 X199.664 Y204.632 E-.22558
G1 X200.21 Y204.396 E-.22577
G1 X200.418 Y204.365 E-.08013
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 27/58
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
M106 S255
M106 P2 S178
; open powerlost recovery
M1003 S1
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S250
M204 S10000
G17
G3 Z.5 I1.14 J-.427 P1  F30000
G1 X200.19 Y203.754 Z.5
M204 S10000
G1 Z.3
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F1200
M204 S500
G1 X200.719 Y203.683 E.01641
G1 X201.31 Y203.731 E.01822
G1 X201.878 Y203.902 E.01823
G1 X202.396 Y204.189 E.0182
G1 X202.842 Y204.58 E.01823
G1 X203.196 Y205.055 E.01822
G1 X203.442 Y205.597 E.01828
G1 X203.552 Y206.087 E.01543
G1 X203.578 Y206.62 E.01638
G1 X203.484 Y207.205 E.01822
G1 X203.268 Y207.757 E.01822
; object ids of layer 27 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer27 end: 399
M625
G1 X202.94 Y208.251 E.01822
G1 X202.515 Y208.665 E.01822
G1 X202.013 Y208.979 E.01821
G1 X201.455 Y209.181 E.01822
G1 X200.867 Y209.259 E.01822
G1 X200.276 Y209.212 E.01822
G1 X199.709 Y209.041 E.01823
G1 X199.19 Y208.754 E.0182
G1 X198.744 Y208.363 E.01823
G1 X198.39 Y207.887 E.01821
G1 X198.16 Y207.38 E.01713
G1 X198.036 Y206.892 E.01546
G1 X198.008 Y206.323 E.0175
G1 X198.102 Y205.738 E.01822
G1 X198.318 Y205.186 E.01822
G1 X198.646 Y204.692 E.01821
G1 X199.071 Y204.278 E.01823
G1 X199.573 Y203.963 E.01821
G1 X200.13 Y203.762 E.01818
; WIPE_START
G1 F3600
M204 S1000
G1 X200.719 Y203.683 E-.22567
G1 X201.31 Y203.731 E-.22534
G1 X201.878 Y203.902 E-.22541
G1 X202.07 Y204.009 E-.08358
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X201.834 Y204.481 Z.7 F30000
G1 X201.733 Y204.43
G1 X201.588 Y204.369
G1 X201.425 Y204.315
G1 X201.293 Y204.28
G1 X201.141 Y204.251
G1 X200.985 Y204.232
G1 X200.814 Y204.225
G1 X200.677 Y204.227
G1 X200.522 Y204.24
G1 X200.369 Y204.264
G1 X200.218 Y204.299
G1 X200.069 Y204.344
G1 X199.924 Y204.399
G1 X199.783 Y204.464
G1 X199.647 Y204.538
G1 X199.517 Y204.622
G1 X199.392 Y204.714
G1 X199.274 Y204.815
G1 X199.163 Y204.924
G1 X199.06 Y205.04
G1 X198.966 Y205.163
G1 X198.88 Y205.292
G1 X198.808 Y205.418
G1 X199.019 Y205.538
G1 Z.3
G1 E.8 F1800
G1 F1200
M204 S500
G1 X199.271 Y205.174 E.01363
G1 X199.747 Y204.757 E.01943
G1 X200.254 Y204.537 E.01699
G1 X200.778 Y204.464 E.01625
G1 X201.265 Y204.519 E.01506
G1 X201.744 Y204.701 E.01575
G1 X202.182 Y205.02 E.01665
G1 X202.525 Y205.455 E.01701
G1 X202.737 Y205.965 E.01699
G1 X202.801 Y206.515 E.01699
G1 X202.718 Y207.034 E.01616
G1 X202.48 Y207.562 E.01779
G1 X202.118 Y207.98 E.01699
G1 X201.657 Y208.285 E.01698
G1 X201.129 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.041 Y208.333 E.01699
G1 X199.561 Y208.058 E.01699
G1 X199.175 Y207.662 E.01698
G1 X198.912 Y207.175 E.01699
G1 X198.793 Y206.653 E.01646
G1 X198.822 Y206.085 E.01748
G1 X198.992 Y205.592 E.01603
; WIPE_START
G1 F3600
M204 S1000
G1 X199.271 Y205.174 E-.1909
G1 X199.747 Y204.757 E-.24026
G1 X200.254 Y204.537 E-.21012
G1 X200.563 Y204.494 E-.11873
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.542 Y204.239 Z.7 F30000
G1 X200.522 Y204.24
G1 X200.369 Y204.264
G1 X200.273 Y204.286
G1 X200.24 Y204.14
G1 Z.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44616
G1 F1200
M204 S1000
G1 X200.736 Y204.076 E.01645
; LINE_WIDTH: 0.44734
G1 X201.237 Y204.117 E.01656
; LINE_WIDTH: 0.457
G1 X201.723 Y204.268 E.01718
; LINE_WIDTH: 0.46072
G1 X202.166 Y204.516 E.01728
G1 X202.552 Y204.847 E.01732
; LINE_WIDTH: 0.45024
G1 X202.859 Y205.254 E.01691
; LINE_WIDTH: 0.4558
G1 X203.066 Y205.726 E.01734
; LINE_WIDTH: 0.45724
G1 X203.156 Y206.107 E.01322
G1 X203.188 Y206.598 E.01662
; LINE_WIDTH: 0.44938
G1 X203.104 Y207.101 E.01689
; LINE_WIDTH: 0.45872
G1 X202.914 Y207.573 E.01724
G1 X202.633 Y207.997 E.01722
; LINE_WIDTH: 0.45854
G1 X202.272 Y208.355 E.01723
; LINE_WIDTH: 0.44882
G1 X201.842 Y208.627 E.01685
; LINE_WIDTH: 0.4564
G1 X201.361 Y208.794 E.01715
; LINE_WIDTH: 0.45972
G1 X200.857 Y208.86 E.01726
G1 X200.35 Y208.823 E.01727
; LINE_WIDTH: 0.45352
G1 X199.86 Y208.681 E.01705
; LINE_WIDTH: 0.45278
G1 X199.418 Y208.43 E.017
; LINE_WIDTH: 0.45962
G1 X199.037 Y208.092 E.01727
G1 X198.804 Y207.798 E.01273
; LINE_WIDTH: 0.4362
G1 X198.557 Y207.325 E.01713
; LINE_WIDTH: 0.45526
G1 X198.429 Y206.836 E.01697
; LINE_WIDTH: 0.46126
G1 X198.407 Y206.345 E.01675
G1 X198.484 Y205.842 E.01735
; LINE_WIDTH: 0.45242
G1 X198.665 Y205.366 E.017
; LINE_WIDTH: 0.45388
G1 X198.951 Y204.944 E.01705
; LINE_WIDTH: 0.45974
G1 X199.317 Y204.592 E.01728
G1 X199.747 Y204.321 E.01726
; LINE_WIDTH: 0.45614
G1 X200.183 Y204.158 E.01565
; CHANGE_LAYER
; Z_HEIGHT: 0.366667
; LAYER_HEIGHT: 0.0666667
; WIPE_START
G1 F6000
G1 X200.736 Y204.076 E-.21264
G1 X201.237 Y204.117 E-.19095
G1 X201.723 Y204.268 E-.19349
G1 X202.097 Y204.478 E-.16292
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 28/58
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.7 I1.013 J.675 P1  F30000
G1 X202.19 Y204.339 Z.7
G1 X204.282 Y203.909
G1 Z.367
G1 E.8 F1800
; FEATURE: Support transition
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.266667
G1 F1500
M204 S1000
G1 X204.282 Y204.44 E.02093
G1 X203.915 Y204.807 E.02044
G1 X204.191 Y205.488 E.02897
G1 X204.282 Y205.398 E.00504
M204 S10000
G1 X204.282 Y207.529 F30000
G1 F1500
M204 S1000
G1 X204.142 Y207.613 E.00644
G1 X204.209 Y207.396 E.00897
G3 X204.239 Y207.355 I.048 J.005 E.0021
M204 S10000
G1 X204.33 Y206.412 F30000
; FEATURE: Support
G1 F2957
M204 S1000
G1 X204.312 Y206.841 E.01696
G1 X204.659 Y207.308 E.0229
G1 X205.521 Y206.799 E.03945
G1 X205.998 Y206.792 E.01881
G2 X206.941 Y207.307 I2.738 J-3.899 E.04245
G2 X207.098 Y207.333 I.164 J-.5 E.00628
G1 X211.27 Y207.333 E.16445
G2 X211.705 Y206.866 I-.032 J-.465 E.0277
; object ids of layer 28 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer28 end: 399
M625
G1 X211.705 Y206.223 E.02531
G1 X204.322 Y206.223 E.29099
G1 X204.312 Y206.101 E.00483
G1 X204.659 Y205.666 E.02193
G1 X204.659 Y204.008 E.06535
G1 X204.88 Y203.787 E.01231
G1 X206.602 Y203.787 E.06788
G1 X206.994 Y203.394 E.02188
G1 X207.11 Y203.346 E.00494
G1 X211.705 Y203.346 E.1811
G1 X211.705 Y200.469 E.1134
G1 X208.965 Y200.469 E.10798
G1 X208.652 Y200.156 E.01748
G1 X207.283 Y200.156 E.05395
G1 X207.144 Y200.098 E.00591
G1 X206.602 Y199.556 E.03025
G1 X206.404 Y199.556 E.0078
G1 X206.632 Y199.083 E.02068
G1 X206.632 Y197.592 E.05877
G1 X211.705 Y197.592 E.19996
G2 X211.676 Y196.512 I-3.129 J-.458 E.04282
G2 X211.346 Y196.222 I-.29 J-.003 E.01967
G2 X211.25 Y196.211 I-.097 J.416 E.00381
G1 X207.097 Y196.21 E.16369
G2 X206.632 Y196.677 I.004 J.469 E.02879
G1 X206.632 Y197.404 E.02866
M204 S10000
G1 X208.782 Y202.044 F30000
; FEATURE: Support transition
G1 F1500
M204 S1000
G1 X208.782 Y202.674 E.02483
G1 X208.496 Y202.96 E.01595
G1 X207.866 Y202.96 E.02483
M204 S10000
G1 X207.146 Y202.96 F30000
G1 F1500
M204 S1000
G1 X207.677 Y202.96 E.02093
G1 X208.782 Y201.855 E.06158
G1 X208.782 Y200.898 E.03774
G1 X206.27 Y203.41 E.14004
G1 X205.312 Y203.41 E.03774
G1 X208.189 Y200.533 E.16038
G1 X207.232 Y200.533 E.03774
G1 X203.532 Y204.232 E.20621
G1 X203.055 Y203.752 E.02669
G1 X206.66 Y200.147 E.20093
G1 X206.446 Y199.933 E.01195
G1 X206.027 Y199.933 E.01651
G1 X205.523 Y200.437 E.02811
G1 X205.335 Y200.515 E.00801
G1 X202.485 Y203.364 E.15883
G1 X201.81 Y203.082 E.02885
G1 X204.282 Y200.61 E.13781
G1 X203.325 Y200.61 E.03774
G1 X200.995 Y202.94 E.12987
G1 X200.504 Y202.945 E.01936
G1 X199.939 Y203.038 E.02254
G1 X202.346 Y200.631 E.13416
G3 X201.36 Y200.66 I-.621 J-4.362 E.03898
G1 X197.131 Y204.888 E.23569
G1 X197.131 Y203.93 E.03774
G1 X200.402 Y200.66 E.18231
G1 X199.445 Y200.66 E.03774
G1 X197.131 Y202.973 E.12894
G1 X197.131 Y202.015 E.03774
G1 X198.487 Y200.66 E.07557
G1 X197.748 Y200.66 E.02915
G2 X197.202 Y200.987 I0 J.619 E.02635
M204 S10000
G1 X199.058 Y203.388 F30000
G1 F1500
M204 S1000
G1 X198.603 Y203.693 E.0216
M204 S10000
G1 X197.732 Y204.698 F30000
G1 F1500
M204 S1000
G1 X197.574 Y205.003 E.01353
G3 X197.131 Y205.845 I-1.463 J-.231 E.03818
G1 X197.131 Y206.803 E.03774
G1 X197.261 Y206.674 E.0072
G1 X197.405 Y207.487 E.03256
G1 X197.131 Y207.76 E.01523
G1 X197.131 Y208.718 E.03774
G1 X197.686 Y208.163 E.03093
G1 X198.073 Y208.734 E.02718
G1 X197.131 Y209.675 E.05247
G2 X197.389 Y210.369 I.693 J.137 E.03069
G1 X198.554 Y209.21 E.06478
G1 X199.129 Y209.593 E.02722
G1 X198.239 Y210.483 E.04961
G1 X199.197 Y210.483 E.03774
G1 X199.81 Y209.87 E.03419
G1 X200.632 Y210.005 E.03284
G1 X200.154 Y210.483 E.02664
G1 X201.112 Y210.483 E.03774
G1 X201.705 Y209.889 E.03311
G1 X202.632 Y209.494 E.03969
M204 S10000
G1 X203.162 Y209.099 F30000
G1 F1500
M204 S1000
G1 X203.605 Y208.619 E.02577
G1 X203.605 Y208.947 E.01296
G1 X202.069 Y210.483 E.0856
G2 X203.029 Y210.481 I.46 J-9.749 E.03783
G1 X203.603 Y209.907 E.03201
; CHANGE_LAYER
; Z_HEIGHT: 0.5
; LAYER_HEIGHT: 0.133333
; WIPE_START
G1 X203.029 Y210.481 E-.30861
G1 X202.069 Y210.483 E-.36461
G1 X202.231 Y210.322 E-.08677
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 29/58
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.767 I1.158 J-.375 P1  F30000
G1 X201.749 Y208.837 Z.767
G1 X203.287 Y207.01
G1 X202.668 Y204.74
G1 X200.454 Y203.942
G1 X200.189 Y203.993
G1 X200.169 Y203.998
G1 X200.11 Y203.778
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.2
G1 F2957
M204 S500
G1 X200.568 Y203.692 E.01432
G1 X201.312 Y203.731 E.02289
G1 X201.878 Y203.902 E.01815
G1 X202.396 Y204.189 E.0182
G1 X202.842 Y204.579 E.01822
G1 X203.196 Y205.056 E.01823
G1 X203.442 Y205.597 E.01826
G1 X203.555 Y206.112 E.0162
G1 X203.578 Y206.619 E.0156
G1 X203.484 Y207.205 E.01824
G1 X203.268 Y207.757 E.01822
; object ids of layer 29 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer29 end: 399
M625
G1 X202.94 Y208.251 E.01821
G1 X202.515 Y208.665 E.01824
G1 X202.013 Y208.98 E.01821
G1 X201.455 Y209.181 E.01821
G1 X200.909 Y209.254 E.01693
G3 X199.849 Y209.096 I-.067 J-3.188 E.03308
G1 X199.314 Y208.836 E.0183
G1 X198.847 Y208.469 E.01822
G1 X198.469 Y208.013 E.01821
G1 X198.212 Y207.518 E.01716
G1 X198.068 Y207.063 E.01464
G1 X198.004 Y206.471 E.0183
G1 X198.067 Y205.882 E.01822
G1 X198.254 Y205.319 E.01822
G1 X198.555 Y204.808 E.01822
G1 X198.957 Y204.373 E.01821
G1 X199.442 Y204.032 E.01822
G1 X199.988 Y203.801 E.01822
G1 X200.051 Y203.789 E.00198
; WIPE_START
G1 F3600
M204 S1000
G1 X200.568 Y203.692 E-.19986
G1 X201.312 Y203.731 E-.28314
G1 X201.878 Y203.902 E-.2244
G1 X201.999 Y203.969 E-.05259
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X201.759 Y204.443 Z.9 F30000
G1 X201.733 Y204.43
G1 X201.587 Y204.369
G1 X201.408 Y204.31
G1 X201.293 Y204.28
G1 X201.141 Y204.251
G1 X200.984 Y204.232
G1 X200.796 Y204.225
G1 X200.677 Y204.227
G1 X200.522 Y204.24
G1 X200.366 Y204.265
G1 X200.183 Y204.309
G1 X200.069 Y204.344
G1 X199.924 Y204.399
G1 X199.783 Y204.464
G1 X199.647 Y204.538
G1 X199.516 Y204.622
G1 X199.392 Y204.715
G1 X199.274 Y204.815
G1 X199.163 Y204.924
G1 X199.06 Y205.04
G1 X198.966 Y205.163
G1 X198.88 Y205.292
G1 X198.808 Y205.418
G1 X199.018 Y205.538
G1 Z.5
G1 E.8 F1800
G1 F2957
M204 S500
G1 X199.319 Y205.107 E.01614
G1 X199.788 Y204.732 E.01847
G1 X200.26 Y204.535 E.0157
G1 X200.765 Y204.464 E.01568
G1 X201.132 Y204.492 E.01129
G1 X201.61 Y204.637 E.01537
G1 X202.052 Y204.907 E.0159
G1 X202.45 Y205.336 E.01798
G1 X202.684 Y205.818 E.01648
G1 X202.793 Y206.289 E.01486
G1 X202.776 Y206.791 E.01541
G1 X202.614 Y207.319 E.01699
G1 X202.314 Y207.784 E.01699
G1 X201.969 Y208.099 E.01435
G1 X201.529 Y208.34 E.01541
G1 X200.992 Y208.47 E.01699
G1 X200.44 Y208.448 E.01699
G1 X199.914 Y208.277 E.01699
G1 X199.455 Y207.969 E.01699
G1 X199.097 Y207.547 E.01698
G1 X198.868 Y207.044 E.017
G1 X198.785 Y206.498 E.01698
G1 X198.833 Y206.033 E.01435
G1 X198.992 Y205.591 E.01441
; WIPE_START
G1 F3600
M204 S1000
G1 X199.319 Y205.107 E-.22198
G1 X199.788 Y204.732 E-.22847
G1 X200.26 Y204.535 E-.19414
G1 X200.561 Y204.493 E-.11541
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.539 Y204.239 Z.9 F30000
G1 X200.522 Y204.24
G1 X200.366 Y204.265
G1 X200.25 Y204.293
G1 X200.215 Y204.151
G1 Z.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43796
G1 F2957
M204 S1000
G1 X200.723 Y204.083 E.01648
; LINE_WIDTH: 0.44616
G1 X201.245 Y204.119 E.01719
G1 X201.861 Y204.332 E.02142
; LINE_WIDTH: 0.43494
G1 X202.376 Y204.682 E.0199
; LINE_WIDTH: 0.43446
G1 X202.734 Y205.078 E.01705
; LINE_WIDTH: 0.4341
G1 X203.005 Y205.56 E.01761
; LINE_WIDTH: 0.44816
G1 X203.164 Y206.13 E.01953
; LINE_WIDTH: 0.45968
G1 X203.18 Y206.596 E.01585
G1 X203.1 Y207.1 E.01733
; LINE_WIDTH: 0.4575
G1 X202.92 Y207.576 E.0172
; LINE_WIDTH: 0.44662
G1 X202.638 Y208.001 E.01675
G1 X202.269 Y208.36 E.01693
; LINE_WIDTH: 0.4571
G1 X201.839 Y208.622 E.01702
G1 X201.566 Y208.732 E.00992
; LINE_WIDTH: 0.44078
G1 X200.92 Y208.861 E.02135
G1 X200.42 Y208.835 E.01625
; LINE_WIDTH: 0.46044
G1 X199.99 Y208.722 E.01512
G1 X199.525 Y208.498 E.01756
; LINE_WIDTH: 0.45746
G1 X199.121 Y208.188 E.01719
; LINE_WIDTH: 0.44668
G1 X198.796 Y207.796 E.01677
; LINE_WIDTH: 0.45828
G1 X198.563 Y207.335 E.01748
G1 X198.455 Y206.985 E.0124
; LINE_WIDTH: 0.4534
G1 X198.395 Y206.471 E.0173
; LINE_WIDTH: 0.44268
G1 X198.449 Y205.964 E.01661
; LINE_WIDTH: 0.45202
G1 X198.614 Y205.482 E.01699
; LINE_WIDTH: 0.4595
G1 X198.875 Y205.046 E.01726
G1 X199.219 Y204.672 E.01724
; LINE_WIDTH: 0.45734
G1 X199.637 Y204.373 E.01736
; LINE_WIDTH: 0.44572
G1 X200.159 Y204.173 E.01837
; CHANGE_LAYER
; Z_HEIGHT: 0.633333
; LAYER_HEIGHT: 0.133333
; WIPE_START
G1 F6000
G1 X200.723 Y204.083 E-.21685
G1 X201.245 Y204.119 E-.19874
G1 X201.861 Y204.332 E-.24775
G1 X202.071 Y204.475 E-.09666
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 30/58
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.9 I1.013 J.675 P1  F30000
G1 X202.17 Y204.326 Z.9
G1 X203.79 Y204.932
G1 Z.633
G1 E.8 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.266667
G1 F2053
M204 S1000
G1 X204.282 Y204.44 E.02744
G1 X204.282 Y205.398 E.03774
G1 X204.053 Y205.626 E.01273
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.033 I-1.215 J-.062 P1  F30000
G1 X203.95 Y207.645 Z1.033
G1 Z.633
G1 E.8 F1800
G1 F2053
M204 S1000
G1 X204.36 Y207.234 E.02286
M204 S10000
G1 X204.33 Y206.412 F30000
; FEATURE: Support
G1 F2053
M204 S1000
G1 X204.312 Y206.841 E.01695
G1 X204.659 Y207.308 E.0229
G1 X205.521 Y206.799 E.03945
G1 X205.998 Y206.792 E.01881
G2 X206.941 Y207.307 I2.742 J-3.906 E.04244
G2 X207.098 Y207.333 I.164 J-.5 E.0063
G1 X211.271 Y207.333 E.16445
G2 X211.705 Y206.866 I-.032 J-.465 E.02769
; object ids of layer 30 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer30 end: 399
M625
G1 X211.705 Y206.223 E.02531
G1 X204.322 Y206.223 E.29099
G1 X204.312 Y206.101 E.00483
G1 X204.659 Y205.666 E.02193
G1 X204.659 Y204.008 E.06535
G1 X204.88 Y203.787 E.01231
G1 X206.602 Y203.787 E.06788
G1 X206.994 Y203.394 E.02188
G1 X207.11 Y203.346 E.00494
G1 X211.705 Y203.346 E.1811
G1 X211.705 Y200.469 E.1134
G1 X208.965 Y200.469 E.10798
G1 X208.652 Y200.156 E.01748
G1 X207.283 Y200.156 E.05395
G1 X207.144 Y200.098 E.00591
G1 X206.602 Y199.556 E.03025
G1 X206.404 Y199.556 E.0078
G1 X206.632 Y199.083 E.02068
G1 X206.632 Y197.592 E.05877
G1 X211.705 Y197.592 E.19996
G2 X211.676 Y196.511 I-3.126 J-.458 E.04283
G2 X211.434 Y196.252 I-.296 J.034 E.01497
G2 X211.25 Y196.211 I-.226 J.574 E.00748
G1 X207.097 Y196.21 E.16369
G2 X206.632 Y196.677 I.004 J.47 E.0288
G1 X206.632 Y197.404 E.02866
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.033 I-1.203 J.184 P1  F30000
G1 X207.507 Y203.13 Z1.033
G1 Z.633
G1 E.8 F1800
; FEATURE: Support interface
G1 F2053
M204 S1000
G1 X208.782 Y201.855 E.07104
G1 X208.782 Y200.898 E.03774
G1 X206.27 Y203.41 E.14004
G1 X205.312 Y203.41 E.03774
G1 X208.189 Y200.533 E.16038
G1 X207.232 Y200.533 E.03774
G1 X203.532 Y204.232 E.20621
G1 X203.055 Y203.752 E.02669
G1 X206.66 Y200.147 E.20093
G1 X206.446 Y199.933 E.01195
G1 X206.027 Y199.933 E.01651
G1 X205.523 Y200.437 E.02811
G1 X205.335 Y200.515 E.00801
G1 X202.485 Y203.364 E.15883
G1 X201.81 Y203.082 E.02885
G1 X204.282 Y200.61 E.13781
G1 X203.325 Y200.61 E.03774
G1 X200.995 Y202.94 E.12987
G1 X200.504 Y202.945 E.01936
G1 X199.939 Y203.038 E.02255
G1 X202.537 Y200.44 E.14479
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.033 I-.013 J-1.217 P1  F30000
G1 X197.697 Y200.492 Z1.033
G1 Z.633
G1 E.8 F1800
G1 F2053
M204 S1000
G1 X197.202 Y200.987 E.0276
G2 X197.131 Y202.015 I2.073 J.658 E.041
G1 X198.487 Y200.66 E.07557
G1 X199.445 Y200.66 E.03774
G1 X197.131 Y202.973 E.12894
G1 X197.131 Y203.93 E.03774
G1 X200.402 Y200.66 E.18231
G1 X201.36 Y200.66 E.03774
G1 X197.131 Y204.888 E.23569
G1 X197.131 Y205.845 E.03774
G1 X197.361 Y205.616 E.01278
G1 X197.274 Y206.103 E.01947
G1 X197.261 Y206.674 E.02252
G1 X197.131 Y206.803 E.0072
G1 X197.131 Y207.76 E.03774
G1 X197.405 Y207.487 E.01523
G1 X197.686 Y208.163 E.02886
G1 X197.131 Y208.718 E.03093
G1 X197.131 Y209.675 E.03774
G1 X198.073 Y208.734 E.05247
G1 X198.554 Y209.21 E.02669
G1 X197.393 Y210.372 E.06475
G2 X198.239 Y210.483 I.601 J-1.296 E.03417
G1 X199.129 Y209.593 E.04961
G1 X199.81 Y209.87 E.02897
G1 X199.197 Y210.483 E.03419
G1 X200.154 Y210.483 E.03774
G1 X200.632 Y210.005 E.02664
G1 X201.255 Y209.979 E.0246
G1 X201.705 Y209.889 E.01809
G1 X201.112 Y210.483 E.03311
G1 X202.069 Y210.483 E.03774
G1 X203.605 Y208.947 E.0856
G3 X203.603 Y209.907 I-9.742 J.461 E.03783
G1 X202.857 Y210.653 E.04158
; CHANGE_LAYER
; Z_HEIGHT: 0.7
; LAYER_HEIGHT: 0.0666667
; WIPE_START
G1 F4800
G1 X203.603 Y209.907 E-.40086
G1 X203.605 Y208.962 E-.35914
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 31/58
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.033 I1 J-.693 P1  F30000
G1 X202.888 Y207.928 Z1.033
G1 X203.17 Y205.542
G1 X201.398 Y203.992
G1 X200.188 Y203.992
G1 X200.088 Y204.019
G1 X200.029 Y203.805
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.2
G1 F2053
M204 S500
G1 X200.463 Y203.704 E.01368
G3 X202.049 Y203.986 I.294 J2.955 E.05011
G1 X202.556 Y204.318 E.01864
G1 X202.967 Y204.732 E.01794
G1 X203.283 Y205.225 E.01798
G1 X203.491 Y205.78 E.0182
G1 X203.576 Y206.365 E.01816
G1 X203.513 Y207.037 E.02074
G1 X203.371 Y207.524 E.01562
; object ids of layer 31 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer31 end: 399
M625
G1 X203.09 Y208.046 E.01819
G1 X202.706 Y208.495 E.01817
G1 X202.234 Y208.854 E.0182
G1 X201.659 Y209.114 E.01939
G1 X201.075 Y209.238 E.01835
G1 X200.529 Y209.244 E.01678
G1 X199.95 Y209.126 E.01816
G1 X199.478 Y208.926 E.01576
G1 X199.043 Y208.638 E.01602
G1 X198.623 Y208.216 E.01831
G1 X198.303 Y207.718 E.01818
G1 X198.087 Y207.109 E.01985
G1 X198.014 Y206.52 E.01825
G1 X198.051 Y205.987 E.01643
G1 X198.215 Y205.418 E.01818
G1 X198.496 Y204.897 E.01817
G1 X198.88 Y204.448 E.01818
G1 X199.356 Y204.087 E.01834
G1 X199.888 Y203.838 E.01806
G1 X199.971 Y203.819 E.00261
; WIPE_START
G1 F3600
M204 S1000
G1 X200.463 Y203.704 E-.19198
G1 X200.978 Y203.698 E-.19575
G1 X201.495 Y203.777 E-.19876
G1 X201.922 Y203.938 E-.17352
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X201.718 Y204.424 Z1.1 F30000
G1 X201.586 Y204.368
G1 X201.391 Y204.306
G1 X201.293 Y204.28
G1 X201.141 Y204.251
G1 X200.982 Y204.232
G1 X200.778 Y204.225
G1 X200.677 Y204.227
G1 X200.522 Y204.24
G1 X200.369 Y204.264
G1 X200.218 Y204.299
G1 X200.069 Y204.344
G1 X199.924 Y204.399
G1 X199.783 Y204.464
G1 X199.647 Y204.538
G1 X199.513 Y204.624
G1 X199.351 Y204.749
G1 X199.274 Y204.815
G1 X199.163 Y204.924
G1 X199.06 Y205.04
G1 X198.966 Y205.163
G1 X198.878 Y205.296
G1 X198.812 Y205.415
G1 X199.03 Y205.534
G1 Z.7
G1 E.8 F1800
G1 F2053
M204 S500
G1 X199.07 Y205.44 E.00315
G1 X199.366 Y205.061 E.01477
G1 X199.782 Y204.735 E.01624
G1 X200.254 Y204.537 E.01574
G1 X200.883 Y204.473 E.01943
G1 X201.481 Y204.584 E.01868
G1 X201.97 Y204.844 E.017
G1 X202.364 Y205.221 E.01677
G1 X202.649 Y205.703 E.0172
G1 X202.788 Y206.238 E.01699
G1 X202.776 Y206.791 E.01699
G1 X202.614 Y207.319 E.01699
G1 X202.314 Y207.784 E.01699
G1 X201.97 Y208.099 E.01434
G1 X201.529 Y208.34 E.01541
G1 X201.024 Y208.463 E.01599
G1 X200.388 Y208.439 E.01953
G1 X199.914 Y208.277 E.0154
G1 X199.455 Y207.969 E.01699
G1 X199.097 Y207.547 E.01699
G1 X198.868 Y207.044 E.01699
G1 X198.792 Y206.545 E.01552
G1 X198.854 Y205.949 E.01842
G1 X199.006 Y205.589 E.01199
; WIPE_START
G1 F3600
M204 S1000
G1 X199.07 Y205.44 E-.06174
G1 X199.366 Y205.061 E-.18265
G1 X199.782 Y204.735 E-.20088
G1 X200.254 Y204.537 E-.1946
G1 X200.568 Y204.505 E-.12013
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.546 Y204.238 Z1.1 F30000
G1 X200.522 Y204.24
G1 X200.369 Y204.264
G1 X200.218 Y204.299
G1 X200.174 Y204.312
G1 X200.134 Y204.179
G1 Z.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45674
G1 F2053
M204 S1000
G1 X200.277 Y204.139 E.00502
; LINE_WIDTH: 0.45598
G1 X200.849 Y204.08 E.01935
; LINE_WIDTH: 0.45956
G1 X201.36 Y204.15 E.01753
G1 X201.839 Y204.321 E.01724
; LINE_WIDTH: 0.45714
G1 X202.284 Y204.597 E.01769
; LINE_WIDTH: 0.446
G1 X202.642 Y204.948 E.01647
; LINE_WIDTH: 0.45808
G1 X202.914 Y205.369 E.01697
; LINE_WIDTH: 0.45912
G1 X203.099 Y205.843 E.01724
G1 X203.184 Y206.344 E.01723
; LINE_WIDTH: 0.45066
G1 X203.161 Y206.853 E.01694
; LINE_WIDTH: 0.45526
G1 X203.021 Y207.342 E.0171
; LINE_WIDTH: 0.45982
G1 X202.784 Y207.792 E.01726
G1 X202.463 Y208.186 E.01727
; LINE_WIDTH: 0.45574
G1 X202.062 Y208.499 E.01711
G1 X201.607 Y208.727 E.01713
; LINE_WIDTH: 0.44988
G1 X201.111 Y208.845 E.01689
; LINE_WIDTH: 0.4589
G1 X200.603 Y208.854 E.01724
G1 X200.265 Y208.802 E.01159
; LINE_WIDTH: 0.43796
G1 X199.757 Y208.63 E.01724
; LINE_WIDTH: 0.4559
G1 X199.319 Y208.355 E.01743
; LINE_WIDTH: 0.45984
G1 X198.953 Y207.996 E.01739
G1 X198.67 Y207.574 E.01726
; LINE_WIDTH: 0.4548
G1 X198.479 Y207.102 E.0171
; LINE_WIDTH: 0.4513
G1 X198.403 Y206.599 E.01694
; LINE_WIDTH: 0.45926
G1 X198.434 Y206.091 E.01727
G1 X198.567 Y205.601 E.01724
; LINE_WIDTH: 0.45776
G1 X198.796 Y205.147 E.0172
; LINE_WIDTH: 0.4481
G1 X199.122 Y204.755 E.01681
G1 X199.526 Y204.437 E.01699
; LINE_WIDTH: 0.45674
G1 X199.982 Y204.222 E.017
G1 X200.076 Y204.195 E.0033
; CHANGE_LAYER
; Z_HEIGHT: 0.9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X200.277 Y204.139 E-.07942
G1 X200.849 Y204.08 E-.21843
G1 X201.36 Y204.15 E-.19616
G1 X201.839 Y204.321 E-.19301
G1 X202.002 Y204.422 E-.07298
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 32/58
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.1 I1.048 J.618 P1  F30000
G1 X202.088 Y204.276 Z1.1
G1 X201.349 Y203.15
G1 Z.9
G1 E.8 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.266667
G1 F2026
M204 S1000
G1 X198.859 Y200.66 E.13881
G1 X197.901 Y200.66 E.03774
G1 X200.222 Y202.98 E.12936
G1 X199.473 Y203.189 E.03064
G1 X197.221 Y200.954 E.12507
G2 X197.131 Y201.805 I1.242 J.561 E.03431
G1 X198.845 Y203.519 E.09553
G1 X198.315 Y203.946 E.02684
G1 X197.131 Y202.762 E.06598
G1 X197.131 Y203.72 E.03774
G1 X197.878 Y204.467 E.04164
G1 X197.539 Y205.085 E.02779
G1 X197.131 Y204.677 E.02271
G1 X197.131 Y205.635 E.03774
G1 X197.316 Y205.82 E.01031
G1 X197.265 Y206.726 E.03577
G1 X197.131 Y206.592 E.00744
G1 X197.131 Y207.55 E.03774
G1 X197.624 Y208.042 E.02743
G1 X197.949 Y208.576 E.02463
G1 X198.32 Y209.001 E.02225
G1 X198.753 Y209.363 E.02225
G1 X199.224 Y209.642 E.02157
G1 X200.065 Y210.483 E.04687
G1 X201.022 Y210.483 E.03774
G1 X200.539 Y210 E.02692
G1 X201.446 Y209.949 E.03578
G1 X201.98 Y210.483 E.02977
G1 X202.937 Y210.483 E.03774
G1 X202.18 Y209.726 E.04218
G1 X202.798 Y209.386 E.02778
G1 X203.545 Y210.133 E.04164
G2 X203.605 Y209.236 I-1.968 J-.582 E.03575
G1 X203.198 Y208.829 E.02268
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.3 I-.513 J-1.103 P1  F30000
G1 X199.277 Y210.653 Z1.3
G1 Z.9
G1 E.8 F1800
G1 F2026
M204 S1000
G1 X197.131 Y208.507 E.11958
G1 X197.131 Y209.465 E.03774
G1 X198.319 Y210.653 E.06621
; WIPE_START
G1 F4800
G1 X197.131 Y209.465 E-.63828
G1 X197.131 Y209.145 E-.12172
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.3 I.68 J1.009 P1  F30000
G1 X198.78 Y208.034 Z1.3
G1 X200.862 Y209.02
G1 X202.918 Y207.881
G1 X203.168 Y205.543
G1 X202.997 Y205.191
G1 X208.952 Y201.177
G1 Z.9
G1 E.8 F1800
G1 F2026
M204 S1000
G1 X208.307 Y200.533 E.03593
G1 X207.35 Y200.533 E.03774
G1 X208.782 Y201.965 E.07984
G1 X208.782 Y202.674 E.02794
G1 X208.658 Y202.798 E.00693
G1 X205.909 Y200.05 E.15319
G1 X205.523 Y200.437 E.02156
G1 X205.393 Y200.491 E.00555
G1 X207.862 Y202.96 E.13765
G1 X207.058 Y202.96 E.03169
G1 X206.949 Y203.005 E.00463
G1 X204.554 Y200.61 E.13352
G1 X203.597 Y200.61 E.03774
G1 X206.397 Y203.41 E.1561
G1 X205.439 Y203.41 E.03774
G1 X202.639 Y200.61 E.1561
G3 X201.731 Y200.66 I-1.596 J-20.712 E.03583
G1 X204.603 Y203.531 E.16005
G1 X204.282 Y203.852 E.01788
G1 X204.282 Y204.168 E.01245
G1 X200.774 Y200.66 E.19554
G1 X199.816 Y200.66 E.03774
G1 X204.452 Y205.295 E.25837
M204 S10000
G1 X204.33 Y206.412 F30000
; FEATURE: Support
G1 F2026
M204 S1000
G1 X204.312 Y206.841 E.01695
G1 X204.659 Y207.308 E.0229
G1 X205.521 Y206.799 E.03945
G1 X205.998 Y206.792 E.01881
G2 X206.941 Y207.307 I2.74 J-3.902 E.04244
G2 X207.098 Y207.333 I.164 J-.5 E.00631
G1 X211.271 Y207.333 E.16447
G2 X211.705 Y206.865 I-.032 J-.465 E.02768
G1 X211.705 Y206.223 E.02531
G1 X204.322 Y206.223 E.29099
G1 X204.312 Y206.101 E.00483
G1 X204.659 Y205.666 E.02193
G1 X204.659 Y204.008 E.06535
G1 X204.88 Y203.787 E.01231
G1 X206.602 Y203.787 E.06788
G1 X206.994 Y203.394 E.02188
G1 X207.11 Y203.346 E.00494
G1 X211.705 Y203.346 E.1811
G1 X211.705 Y200.469 E.1134
G1 X208.965 Y200.469 E.10798
G1 X208.652 Y200.156 E.01748
G1 X207.283 Y200.156 E.05395
G1 X207.144 Y200.098 E.00591
G1 X206.602 Y199.556 E.03025
G1 X206.404 Y199.556 E.0078
G1 X206.632 Y199.083 E.02068
G1 X206.632 Y197.592 E.05877
G1 X211.705 Y197.592 E.19996
G2 X211.676 Y196.512 I-3.13 J-.458 E.04281
G2 X211.346 Y196.222 I-.402 J.124 E.01824
G2 X211.25 Y196.211 I-.097 J.415 E.0038
G1 X207.097 Y196.21 E.16369
G2 X206.632 Y196.676 I.004 J.47 E.02879
G1 X206.632 Y197.404 E.02867
; WIPE_START
G1 F9000
G1 X206.632 Y196.676 E-.27642
G1 X206.677 Y196.472 E-.0797
G1 X206.775 Y196.338 E-.06295
G1 X207.097 Y196.21 E-.13166
G1 X207.648 Y196.21 E-.20926
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.3 I-.872 J-.849 P1  F30000
G1 X200.028 Y204.04 Z1.3
G1 X199.954 Y203.816
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.2
G1 F2026
M204 S500
G1 X199.988 Y203.801 E.00114
G1 X200.545 Y203.696 E.0174
G1 X200.862 Y203.683 E.00978
G1 X201.455 Y203.762 E.01837
G1 X202.013 Y203.963 E.01823
G1 X202.477 Y204.249 E.01671
G1 X202.865 Y204.609 E.01628
G1 X203.249 Y205.173 E.02098
G1 X203.45 Y205.636 E.0155
G1 X203.561 Y206.163 E.01654
G1 X203.578 Y206.618 E.01402
G1 X203.484 Y207.205 E.01825
G1 X203.268 Y207.758 E.01825
; object ids of layer 32 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer32 end: 399
M625
G3 X202.631 Y208.569 I-2.674 J-1.443 E.03185
G1 X202.144 Y208.911 E.01827
G1 X201.598 Y209.141 E.0182
G1 X201.016 Y209.251 E.01823
G1 X200.423 Y209.236 E.01821
G1 X199.847 Y209.095 E.01822
G1 X199.314 Y208.835 E.01823
G1 X198.847 Y208.469 E.01821
G1 X198.469 Y208.013 E.01821
G1 X198.196 Y207.487 E.01821
G1 X198.04 Y206.915 E.01822
G1 X198.008 Y206.323 E.01823
G1 X198.102 Y205.738 E.01821
G1 X198.319 Y205.185 E.01824
G3 X198.955 Y204.373 I2.674 J1.443 E.03185
G1 X199.442 Y204.032 E.01826
G1 X199.898 Y203.839 E.01523
; WIPE_START
G1 F3600
M204 S1000
G1 X199.988 Y203.801 E-.03694
G1 X200.545 Y203.696 E-.21519
G1 X200.862 Y203.683 E-.12092
G1 X201.455 Y203.762 E-.22724
G1 X201.851 Y203.905 E-.15971
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X201.646 Y204.391 Z1.3 F30000
G1 X201.591 Y204.368
G1 X201.444 Y204.317
G1 X201.294 Y204.278
G1 X201.141 Y204.249
G1 X200.987 Y204.231
G1 X200.832 Y204.222
G1 X200.75 Y204.223
G1 X200.677 Y204.225
G1 X200.522 Y204.238
G1 X200.368 Y204.262
G1 X200.217 Y204.296
G1 X200.068 Y204.341
G1 X199.923 Y204.396
G1 X199.782 Y204.461
G1 X199.71 Y204.5
G1 X199.646 Y204.536
G1 X199.515 Y204.62
G1 X199.39 Y204.712
G1 X199.272 Y204.813
G1 X199.162 Y204.922
G1 X199.059 Y205.039
G1 X198.964 Y205.161
G1 X198.878 Y205.291
G1 X198.806 Y205.417
G1 X199.018 Y205.539
G1 Z.9
G1 E.8 F1800
G1 F2026
M204 S500
G1 X199.319 Y205.107 E.01615
G1 X199.747 Y204.757 E.01699
G1 X200.252 Y204.537 E.01694
G1 X200.802 Y204.463 E.01704
G1 X201.265 Y204.519 E.01434
G1 X201.734 Y204.697 E.01541
G1 X202.182 Y205.021 E.01699
G1 X202.525 Y205.455 E.01698
G1 X202.737 Y205.965 E.01699
G1 X202.801 Y206.515 E.01699
G1 X202.718 Y207.034 E.01615
G1 X202.48 Y207.562 E.0178
G1 X202.118 Y207.98 E.01699
G1 X201.657 Y208.285 E.01698
G1 X201.129 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.081 Y208.344 E.01569
G1 X199.561 Y208.058 E.01824
G1 X199.176 Y207.662 E.01699
G1 X198.912 Y207.175 E.01699
G1 X198.82 Y206.771 E.01276
G1 X198.788 Y206.584 E.00582
G1 X198.823 Y206.084 E.0154
G1 X198.992 Y205.592 E.01599
; WIPE_START
G1 F3600
M204 S1000
G1 X199.319 Y205.107 E-.22211
G1 X199.747 Y204.757 E-.21007
G1 X200.252 Y204.537 E-.20955
G1 X200.561 Y204.496 E-.11828
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.539 Y204.236 Z1.3 F30000
G1 X200.522 Y204.238
G1 X200.368 Y204.262
G1 X200.217 Y204.296
G1 X200.133 Y204.322
G1 X200.097 Y204.202
G1 Z.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.4457
G1 F2026
M204 S1000
G1 X200.258 Y204.142 E.00564
; LINE_WIDTH: 0.44428
G1 X200.842 Y204.073 E.01923
G1 X201.362 Y204.142 E.01718
; LINE_WIDTH: 0.45022
G1 X201.842 Y204.319 E.01697
; LINE_WIDTH: 0.45966
G3 X202.55 Y204.843 I-1.255 J2.432 E.03004
; LINE_WIDTH: 0.45034
G1 X202.859 Y205.254 E.01707
; LINE_WIDTH: 0.4556
G1 X203.065 Y205.722 E.01719
; LINE_WIDTH: 0.45936
G1 X203.165 Y206.177 E.01581
G1 X203.188 Y206.595 E.01418
; LINE_WIDTH: 0.4494
G1 X203.104 Y207.101 E.01701
; LINE_WIDTH: 0.4589
G1 X202.913 Y207.575 E.01732
G1 X202.74 Y207.861 E.01132
; LINE_WIDTH: 0.44366
G1 X202.376 Y208.273 E.01796
; LINE_WIDTH: 0.45496
G1 X201.952 Y208.564 E.01726
; LINE_WIDTH: 0.45982
G1 X201.483 Y208.759 E.01725
G1 X200.984 Y208.856 E.01728
; LINE_WIDTH: 0.45514
G1 X200.475 Y208.848 E.0171
; LINE_WIDTH: 0.45078
G1 X199.981 Y208.724 E.01693
; LINE_WIDTH: 0.45914
G1 X199.525 Y208.497 E.01726
G1 X199.125 Y208.184 E.01723
; LINE_WIDTH: 0.458
G1 X198.797 Y207.796 E.01721
; LINE_WIDTH: 0.44736
G1 X198.561 Y207.344 E.01679
; LINE_WIDTH: 0.45718
G1 X198.433 Y206.852 E.01718
G1 X198.405 Y206.557 E.00998
; LINE_WIDTH: 0.4409
G1 X198.469 Y205.902 E.02136
G1 X198.644 Y205.415 E.01678
; LINE_WIDTH: 0.45632
G1 X198.927 Y204.977 E.01757
; LINE_WIDTH: 0.45764
G1 X199.215 Y204.675 E.01411
G1 X199.641 Y204.371 E.01767
; LINE_WIDTH: 0.4457
G1 X200.04 Y204.222 E.014
; CHANGE_LAYER
; Z_HEIGHT: 1.1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X200.258 Y204.142 E-.08814
G1 X200.842 Y204.073 E-.22341
G1 X201.362 Y204.142 E-.1996
G1 X201.842 Y204.319 E-.19432
G1 X201.964 Y204.395 E-.05454
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 33/58
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.3 I1.048 J.618 P1  F30000
G1 X202.049 Y204.25 Z1.3
G1 X200.056 Y204.028
G1 X199.969 Y204.057
G1 X199.897 Y203.839
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1200
M204 S500
G1 X199.988 Y203.801 E.00302
G1 X200.544 Y203.696 E.01738
G3 X202.967 Y204.732 I.205 J2.874 E.0841
G1 X203.283 Y205.225 E.01798
G1 X203.491 Y205.78 E.01819
G1 X203.576 Y206.365 E.01817
G1 X203.547 Y206.915 E.01693
G1 X203.391 Y207.487 E.01821
; object ids of layer 33 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer33 end: 399
M625
G1 X203.117 Y208.013 E.01822
G1 X202.739 Y208.469 E.01822
G1 X202.273 Y208.836 E.01822
G1 X201.739 Y209.095 E.01822
G1 X201.163 Y209.236 E.01822
G1 X200.571 Y209.251 E.01821
G1 X199.988 Y209.141 E.01822
G1 X199.442 Y208.911 E.01821
G1 X198.957 Y208.57 E.01822
G1 X198.554 Y208.135 E.01822
G1 X198.253 Y207.624 E.01822
G1 X198.067 Y207.061 E.01822
G1 X198.004 Y206.471 E.01822
G1 X198.067 Y205.882 E.01822
G1 X198.254 Y205.319 E.01823
G1 X198.555 Y204.808 E.01821
G1 X198.957 Y204.372 E.01822
G1 X199.442 Y204.032 E.01822
G1 X199.842 Y203.863 E.01334
; WIPE_START
G1 F3600
M204 S1000
G1 X199.988 Y203.801 E-.06021
G1 X200.544 Y203.696 E-.215
G1 X200.978 Y203.698 E-.16499
G1 X201.495 Y203.777 E-.19865
G1 X201.793 Y203.889 E-.12115
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X201.591 Y204.371 Z1.5 F30000
G1 X201.443 Y204.32
G1 X201.337 Y204.291
G1 X201.145 Y204.252
G1 X200.987 Y204.233
G1 X200.832 Y204.224
G1 X200.722 Y204.226
G1 X200.526 Y204.24
G1 X200.369 Y204.264
G1 X200.218 Y204.299
G1 X200.069 Y204.344
G1 X199.924 Y204.399
G1 X199.783 Y204.464
G1 X199.687 Y204.516
G1 X199.52 Y204.62
G1 X199.392 Y204.714
G1 X199.274 Y204.815
G1 X199.163 Y204.924
G1 X199.061 Y205.04
G1 X198.966 Y205.163
G1 X198.88 Y205.292
G1 X198.812 Y205.411
G1 X199.029 Y205.535
G1 Z1.1
G1 E.8 F1800
G1 F1200
M204 S500
G1 X199.07 Y205.44 E.00319
G1 X199.416 Y205.009 E.01698
G1 X199.827 Y204.711 E.0156
G1 X200.292 Y204.525 E.01537
G1 X200.875 Y204.474 E.018
G1 X201.481 Y204.584 E.01891
G1 X201.969 Y204.844 E.01699
G1 X202.364 Y205.221 E.01678
G1 X202.649 Y205.703 E.01719
G1 X202.788 Y206.238 E.01699
G1 X202.776 Y206.791 E.017
G1 X202.614 Y207.319 E.01699
G1 X202.314 Y207.783 E.01698
G1 X201.898 Y208.148 E.017
G1 X201.441 Y208.367 E.01556
G1 X200.854 Y208.479 E.01838
G1 X200.304 Y208.419 E.01698
G1 X199.791 Y208.212 E.01699
G1 X199.355 Y207.873 E.01698
G1 X199.049 Y207.465 E.01567
G1 X198.854 Y206.994 E.01566
G1 X198.784 Y206.491 E.0156
G1 X198.854 Y205.949 E.01681
G1 X199.006 Y205.591 E.01195
; WIPE_START
G1 F3600
M204 S1000
G1 X199.07 Y205.44 E-.06231
G1 X199.416 Y205.009 E-.21006
G1 X199.827 Y204.711 E-.19291
G1 X200.292 Y204.525 E-.19009
G1 X200.566 Y204.501 E-.10463
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.547 Y204.238 Z1.5 F30000
G1 X200.526 Y204.24
G1 X200.369 Y204.264
G1 X200.218 Y204.299
G1 X200.069 Y204.344
G1 X200.033 Y204.226
G1 Z1.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44158
G1 F1200
M204 S1000
G1 X200.277 Y204.139 E.00843
; LINE_WIDTH: 0.45776
G1 X200.841 Y204.079 E.01917
; LINE_WIDTH: 0.45958
G1 X201.36 Y204.15 E.01779
G1 X201.839 Y204.321 E.01725
; LINE_WIDTH: 0.45712
G1 X202.284 Y204.597 E.01768
; LINE_WIDTH: 0.446
G1 X202.642 Y204.948 E.01647
; LINE_WIDTH: 0.45806
G1 X202.914 Y205.369 E.01697
; LINE_WIDTH: 0.45914
G1 X203.099 Y205.843 E.01724
G1 X203.184 Y206.344 E.01724
; LINE_WIDTH: 0.45066
G1 X203.161 Y206.853 E.01693
; LINE_WIDTH: 0.45528
G1 X203.021 Y207.342 E.0171
; LINE_WIDTH: 0.45982
G1 X202.785 Y207.792 E.01726
G1 X202.462 Y208.185 E.01727
; LINE_WIDTH: 0.4549
G1 X202.065 Y208.504 E.0171
; LINE_WIDTH: 0.45114
G1 X201.605 Y208.723 E.01695
; LINE_WIDTH: 0.45924
G1 X201.11 Y208.84 E.01725
G1 X200.602 Y208.854 E.01723
; LINE_WIDTH: 0.4578
G1 X200.101 Y208.765 E.01721
; LINE_WIDTH: 0.44688
G1 X199.632 Y208.568 E.01676
; LINE_WIDTH: 0.45736
G1 X199.219 Y208.271 E.01719
G1 X198.873 Y207.898 E.01717
; LINE_WIDTH: 0.45706
G1 X198.616 Y207.459 E.01716
G1 X198.454 Y206.977 E.01717
; LINE_WIDTH: 0.45318
G1 X198.395 Y206.471 E.01703
G1 X198.454 Y205.966 E.01702
; LINE_WIDTH: 0.45966
G1 X198.617 Y205.484 E.01728
G1 X198.874 Y205.045 E.01725
; LINE_WIDTH: 0.45668
G1 X199.224 Y204.661 E.01753
; LINE_WIDTH: 0.44436
G1 X199.683 Y204.351 E.01811
; LINE_WIDTH: 0.44158
G1 X199.976 Y204.246 E.01013
; CHANGE_LAYER
; Z_HEIGHT: 1.15714
; LAYER_HEIGHT: 0.0571429
; WIPE_START
G1 F6000
G1 X200.277 Y204.139 E-.12146
G1 X200.841 Y204.079 E-.21546
G1 X201.36 Y204.15 E-.1991
G1 X201.839 Y204.321 E-.19303
G1 X201.908 Y204.364 E-.03096
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 34/58
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.5 I1.081 J.559 P1  F30000
G1 X201.984 Y204.218 Z1.5
G1 X206.632 Y206.412
G1 Z1.157
G1 E.8 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.257143
G1 F9000
M204 S1000
G2 X206.893 Y207.287 I.834 J.227 E.03679
G2 X207.098 Y207.333 I.234 J-.567 E.00806
G1 X211.271 Y207.333 E.1595
G2 X211.705 Y206.865 I-.033 J-.465 E.02683
; object ids of layer 34 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer34 end: 399
M625
G1 X211.705 Y206.223 E.02454
G1 X206.632 Y206.223 E.1939
G1 X206.632 Y205.96 E.01008
G1 X207.126 Y205.96 E.0189
M204 S10000
G1 X207.989 Y205.922 F30000
G1 F9000
M204 S1000
G1 X208.341 Y205.689 E.01611
G1 X209.243 Y203.564 E.08823
G1 X209.203 Y203.346 E.00848
G1 X211.705 Y203.346 E.09562
G1 X211.705 Y200.469 E.10997
G1 X208.564 Y200.469 E.12005
G2 X208.572 Y199.706 I-1.365 J-.396 E.02955
G1 X208.124 Y198.36 E.05421
G1 X207.06 Y197.592 E.05016
G1 X211.705 Y197.592 E.17754
G1 X211.705 Y196.676 E.03502
G2 X211.611 Y196.325 I-1.063 J.096 E.01395
G2 X211.25 Y196.211 I-.469 J.85 E.01456
G1 X207.097 Y196.21 E.15873
G2 X206.658 Y196.519 I-.001 J.465 E.0219
G2 X206.632 Y197.533 I2.675 J.576 E.03899
G1 X206.89 Y197.533 E.00989
; CHANGE_LAYER
; Z_HEIGHT: 1.3
; LAYER_HEIGHT: 0.142857
; WIPE_START
G1 X206.632 Y197.533 E-.09829
G1 X206.658 Y196.519 E-.3854
G1 X206.848 Y196.281 E-.11591
G1 X207.097 Y196.21 E-.09849
G1 X207.26 Y196.21 E-.06191
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 35/58
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.557 I-.989 J-.709 P1  F30000
G1 X203.807 Y201.032 Z1.557
G1 X199.29 Y204.586
G1 X199.163 Y204.695
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.658 Y205.351
G1 X198.586 Y205.501
G1 X198.524 Y205.655
G1 X198.473 Y205.814
G1 X198.434 Y205.975
G1 X198.41 Y206.112
G1 X198.388 Y206.302
G1 X198.382 Y206.471
G1 X198.388 Y206.638
G1 X198.405 Y206.803
G1 X198.434 Y206.967
G1 X198.473 Y207.129
G1 X198.524 Y207.287
G1 X198.575 Y207.415
G1 X198.657 Y207.589
G1 X198.741 Y207.736
G1 X198.833 Y207.875
G1 X198.934 Y208.007
G1 X198.986 Y208.065
G1 X198.395 Y208.589
G1 Z1.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44639
; LAYER_HEIGHT: 0.2
G1 F600
M204 S1000
G1 X198.58 Y208.782 E.00881
; FEATURE: Overhang wall

M204 S500
G2 X198.807 Y208.978 I.558 J-.416 E.00992
; FEATURE: Inner wall
M204 S1000
G1 X199.215 Y209.254 E.0162
; FEATURE: Overhang wall

M204 S500
G1 X198.358 Y209.254 E.02817
G1 X198.358 Y208.556 E.02292
; WIPE_START
M204 S1000
G1 X198.58 Y208.782 E-.12035
G1 X198.699 Y208.906 E-.06497
G1 X198.807 Y208.978 E-.04942
G1 X199.215 Y209.254 E-.18727
G1 X198.358 Y209.254 E-.32564
G1 X198.358 Y209.221 E-.01234
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.7 I.212 J1.198 P1  F30000
G1 X202.781 Y208.438 Z1.7
G1 Z1.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X202.781 Y208.463 E.00086
G1 X202.781 Y208.491 E.00091
G1 X202.781 Y208.518 E.00091
G1 X202.781 Y208.545 E.00091
G1 X202.781 Y208.573 E.00091
G1 F5968.469
G1 X202.781 Y208.6 E.00091
G1 F5574.723
G1 X202.781 Y208.627 E.00091
G1 F5194.274
G1 X202.781 Y208.655 E.00091
G1 F4827.27
G1 X202.781 Y208.682 E.00091
G1 F4473.711
G1 X202.781 Y208.709 E.00091
G1 F4133.719
G1 X202.781 Y208.737 E.00091
G1 F3807.045
G1 X202.781 Y208.764 E.00091
G1 F3493.815
G1 X202.781 Y208.791 E.00091
G1 F3194.137
G1 X202.781 Y208.819 E.00091
G1 F2907.792
G1 X202.781 Y208.846 E.00091
G1 F2634.892
G1 X202.781 Y208.873 E.00091
G1 F2375.528
G1 X202.781 Y208.901 E.00091
G1 F2129.512
G1 X202.781 Y208.928 E.00091
G1 F1896.941
G1 X202.781 Y208.955 E.00091
G1 F1677.892
G1 X202.781 Y208.979 E.00078
; FEATURE: Overhang wall
G1 F1500
M204 S500
G1 X202.78 Y209.662 E.02266
G2 X201.095 Y209.662 I-.861 J606.939 E.0559
; LINE_WIDTH: 0.45524
G1 F600
G1 X201.043 Y209.661 E.00175
; FEATURE: Inner wall
; LINE_WIDTH: 0.46119
M204 S1000
G1 X200.489 Y209.656 E.0189
; FEATURE: Overhang wall
; LINE_WIDTH: 0.46307
G1 F1500
M204 S500
G2 X199.763 Y209.66 I-.274 J16.27 E.02483
; LINE_WIDTH: 0.44999
G1 F600
G1 X197.952 Y209.659 E.06008
G1 X197.953 Y207.946 E.05681
; FEATURE: Inner wall
G1 F903.254
M204 S1000
G1 X197.953 Y207.887 E.00194
G1 F1332.978
G1 X197.953 Y207.819 E.00226
G1 F1846.057
G1 X197.953 Y207.751 E.00226
G1 F2442.49
G1 X197.953 Y207.683 E.00226
G1 F3122.278
G1 X197.953 Y207.615 E.00226
G1 F3885.42
G1 X197.953 Y207.547 E.00226
G1 F4731.916
G1 X197.953 Y207.479 E.00226
G1 F5661.91
G1 X197.953 Y207.411 E.00226
G1 F6000
G1 X197.953 Y207.343 E.00226
G1 X197.953 Y207.307 E.00118
; LINE_WIDTH: 0.45421
G1 X197.956 Y207.262 E.00152
; LINE_WIDTH: 0.46308
G1 X197.96 Y207.167 E.00326
; LINE_WIDTH: 0.47194
G1 X197.964 Y207.071 E.00333
; LINE_WIDTH: 0.4808
G1 X197.969 Y206.976 E.0034
; LINE_WIDTH: 0.48967
G1 X197.973 Y206.881 E.00347
; LINE_WIDTH: 0.49853
G1 X197.978 Y206.786 E.00354
; LINE_WIDTH: 0.49986
G1 X197.979 Y206.771 E.00053
G1 X197.987 Y206.805 E.00128
; LINE_WIDTH: 0.49555
G1 X198.013 Y206.894 E.00342
; LINE_WIDTH: 0.49008
G1 X198.072 Y207.094 E.00762
; LINE_WIDTH: 0.47776
G1 X198.131 Y207.295 E.00741
; LINE_WIDTH: 0.46543
G1 X198.19 Y207.496 E.0072
; LINE_WIDTH: 0.45311
G1 X198.205 Y207.547 E.00177
; LINE_WIDTH: 0.44999
G1 X198.596 Y208.212 E.0256
G2 X199.154 Y208.745 I2.197 J-1.74 E.02568
G1 X199.836 Y209.106 E.0256
; LINE_WIDTH: 0.45334
G1 X199.96 Y209.14 E.0043
; LINE_WIDTH: 0.46307
G1 X200.319 Y209.241 E.01277
G1 X200.454 Y209.252 E.00464
; LINE_WIDTH: 0.45317
G1 X200.591 Y209.264 E.00458
; LINE_WIDTH: 0.44769
G1 X201.092 Y209.257 E.01654
; LINE_WIDTH: 0.45272
G1 X201.301 Y209.227 E.00704
; LINE_WIDTH: 0.45418
G2 X201.62 Y209.126 I-.089 J-.833 E.01129
; LINE_WIDTH: 0.45269
G1 X202.088 Y208.958 E.01661
; LINE_WIDTH: 0.44999
G1 X202.51 Y208.687 E.01663
G1 X202.737 Y208.478 E.01024
M204 S10000
G1 X202.4 Y209.212 F30000
; LINE_WIDTH: 0.44774
G1 F600
M204 S1000
G1 X202.398 Y209.212 E.00006
G2 X202.325 Y209.255 I-.024 J.043 E.00339
G1 X202.335 Y209.275 E.00076
; FEATURE: Overhang wall

M204 S500
G1 X202.349 Y209.3 E.00094
G2 X202.425 Y209.256 I.025 J-.044 E.0035
; WIPE_START
M204 S1000
G1 X202.4 Y209.3 E-.15238
G1 X202.349 Y209.3 E-.15238
G1 X202.335 Y209.275 E-.0854
G1 X202.325 Y209.255 E-.06907
G1 X202.349 Y209.212 E-.14839
G1 X202.398 Y209.212 E-.14693
G1 X202.4 Y209.212 E-.00545
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.7 I1.047 J-.621 P1  F30000
G1 X202.009 Y208.552 Z1.7
G1 X201.95 Y208.587
G1 X201.802 Y208.661
G1 X201.648 Y208.726
G1 X201.49 Y208.779
G1 X201.33 Y208.822
G1 X201.166 Y208.853
G1 X201.001 Y208.873
G1 X200.835 Y208.882
G1 X200.668 Y208.879
G1 X200.503 Y208.865
G1 X200.338 Y208.839
G1 X200.176 Y208.802
G1 X200.017 Y208.754
G1 X199.861 Y208.695
G1 X199.71 Y208.625
G1 X199.564 Y208.545
G1 X199.423 Y208.456
G1 X199.29 Y208.356
G1 X199.163 Y208.248
G1 X199.045 Y208.132
G1 X198.934 Y208.007
G1 X198.833 Y207.875
G1 X198.741 Y207.736
G1 X198.657 Y207.589
G1 X198.575 Y207.415
G1 X198.524 Y207.287
G1 X198.473 Y207.129
G1 X198.434 Y206.967
G1 X198.405 Y206.803
G1 X198.388 Y206.638
G1 X198.382 Y206.471
G1 X198.388 Y206.302
G1 X198.41 Y206.112
G1 X198.434 Y205.975
G1 X198.473 Y205.814
G1 X198.524 Y205.655
G1 X198.586 Y205.501
G1 X198.658 Y205.351
G1 X198.741 Y205.206
G1 X198.833 Y205.068
G1 X198.934 Y204.936
G1 X199.045 Y204.811
G1 X199.163 Y204.695
G1 X199.286 Y204.59
G1 X198.773 Y203.99
G1 Z1.3
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F600
M204 S500
G2 X198.362 Y204.38 I1.197 J1.676 E.01887
G1 X198.363 Y201.888 E.08269
G1 X202.813 Y201.888 E.14762

G1 X202.389 Y202.717 E.03089
G2 X202.377 Y203.686 I7.378 J.58 E.03219
G2 X202.057 Y203.532 I-.634 J.906 E.0118
; FEATURE: Inner wall
M204 S1000
G1 X201.678 Y203.397 E.01335
; FEATURE: Overhang wall

M204 S500
G1 X201.511 Y203.337 E.00589
G2 X200.477 Y203.288 I-.665 J3.077 E.03451
; FEATURE: Inner wall
M204 S1000
G1 X200.315 Y203.308 E.0054
; FEATURE: Overhang wall

M204 S500
G2 X199.935 Y203.39 I-.001 J.923 E.013
; FEATURE: Inner wall
M204 S1000
G2 X199.077 Y203.771 I.87 J3.111 E.03123
; FEATURE: Overhang wall

M204 S500
G2 X198.842 Y203.936 I.309 J.69 E.00958
; FEATURE: Inner wall
M204 S1000
G1 X198.82 Y203.953 E.00093
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.7 I-.167 J1.205 P1  F30000
G1 X202.783 Y204.502 Z1.7
G1 Z1.3
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X202.659 Y204.379 E.00578
G1 X202.023 Y203.952 E.02543
G1 X201.35 Y203.723 E.02357
G1 X200.706 Y203.67 E.02145
G1 X200.208 Y203.73 E.01664
G2 X199.249 Y204.132 I.909 J3.514 E.03462
G1 X198.669 Y204.642 E.02559
G1 X198.251 Y205.291 E.0256
; LINE_WIDTH: 0.45416
G1 X198.236 Y205.333 E.00153
; LINE_WIDTH: 0.46851
G1 X198.183 Y205.481 E.00544
; LINE_WIDTH: 0.48287
G1 X198.131 Y205.629 E.00562
; LINE_WIDTH: 0.49722
G1 X198.078 Y205.777 E.00581
; LINE_WIDTH: 0.51158
G1 X198.026 Y205.925 E.00599
; LINE_WIDTH: 0.52142
G1 X197.99 Y206.026 E.00419
G1 X197.987 Y206 E.00103
; LINE_WIDTH: 0.51671
G1 X197.98 Y205.916 E.00324
; LINE_WIDTH: 0.50171
G1 X197.972 Y205.833 E.00313
; LINE_WIDTH: 0.48671
G1 X197.965 Y205.749 E.00303
; LINE_WIDTH: 0.47172
G1 X197.964 Y205.74 E.00032
; LINE_WIDTH: 0.4701
G1 X197.963 Y205.673 E.00234
; LINE_WIDTH: 0.46741
G1 X197.961 Y205.598 E.00261
; LINE_WIDTH: 0.46439
G1 X197.96 Y205.522 E.00259
; LINE_WIDTH: 0.46137
G1 X197.958 Y205.447 E.00257
; LINE_WIDTH: 0.45835
G1 X197.957 Y205.372 E.00255
; LINE_WIDTH: 0.45533
G1 X197.955 Y205.296 E.00253
; LINE_WIDTH: 0.4523
G1 X197.954 Y205.239 E.00192
; LINE_WIDTH: 0.44999
G1 F3835.193
G1 X197.954 Y205.225 E.00047
G1 F3671.88
G1 X197.954 Y205.165 E.00198
G1 F3017.568
G1 X197.954 Y205.105 E.00198
G1 F2427.504
G1 X197.954 Y205.046 E.00198
G1 F1901.489
G1 X197.954 Y204.994 E.0017
; FEATURE: Overhang wall
G1 F1500
M204 S500
G1 X197.956 Y201.48 E.11656
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102

G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G1 F600
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.521 Y201.746 E.00906
G1 F1500
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663

G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102

G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 F600
G1 X202.793 Y202.77 E.02192
G1 X202.783 Y203.966 E.03967
; FEATURE: Inner wall
G1 F715.406
M204 S1000
G1 X202.783 Y203.99 E.00079
G1 F862.218
G1 X202.783 Y204.017 E.00091
G1 F1022.721
G1 X202.783 Y204.045 E.00091
G1 F1196.851
G1 X202.783 Y204.073 E.00091
G1 F1384.733
G1 X202.783 Y204.1 E.00091
G1 F1586.307
G1 X202.783 Y204.128 E.00091
G1 F1801.573
G1 X202.783 Y204.155 E.00091
G1 F2030.445
G1 X202.783 Y204.183 E.00091
G1 F2273.089
G1 X202.783 Y204.21 E.00091
G1 F2529.426
G1 X202.783 Y204.238 E.00091
G1 F2799.454
G1 X202.783 Y204.266 E.00091
G1 F3083.174
G1 X202.783 Y204.293 E.00091
G1 F3380.475
G1 X202.783 Y204.321 E.00091
G1 F3691.574
G1 X202.783 Y204.348 E.00091
G1 F4016.364
G1 X202.783 Y204.376 E.00091
G1 F4354.846
G1 X202.783 Y204.403 E.00091
G1 F4707.021
G1 X202.783 Y204.431 E.00091
G1 F4845.356
G1 X202.783 Y204.442 E.00035
G1 E-.8 F1800
M204 S10000
G1 X203.181 Y205.524 Z1.7 F30000
G1 Z1.3
G1 E.8 F1800
; LINE_WIDTH: 0.475215
G1 F6000
M204 S1000
G1 X203.177 Y205.637 E.004
; LINE_WIDTH: 0.50044
G1 X203.164 Y205.973 E.01251
G1 X203.114 Y205.815 E.00617
; LINE_WIDTH: 0.47889
G1 X202.836 Y205.216 E.02347
; LINE_WIDTH: 0.44999
G1 X202.416 Y204.706 E.0219
G1 X201.876 Y204.332 E.0218
G1 X201.298 Y204.126 E.02037
G1 X200.755 Y204.074 E.01809
G1 X200.102 Y204.175 E.0219
G1 X199.502 Y204.451 E.0219
G1 X199 Y204.879 E.02189
G1 X198.634 Y205.428 E.0219
G1 X198.431 Y206.057 E.0219
G1 X198.408 Y206.716 E.0219
G1 X198.565 Y207.358 E.0219
G1 X198.891 Y207.932 E.0219
G1 X199.361 Y208.395 E.0219
G1 X199.94 Y208.712 E.0219
G1 X200.584 Y208.86 E.0219
G1 X201.243 Y208.827 E.0219
G1 X201.723 Y208.682 E.01664
G1 X201.936 Y208.571 E.00797
G1 X202.412 Y208.241 E.01921
G1 X202.833 Y207.732 E.0219
; LINE_WIDTH: 0.495095
G1 X202.988 Y207.434 E.01238
; LINE_WIDTH: 0.5402
G1 X203.144 Y207.136 E.01361
G1 X203.164 Y207.311 E.00714
; LINE_WIDTH: 0.50024
G1 X203.176 Y207.562 E.00936
; LINE_WIDTH: 0.475115
G1 X203.188 Y207.813 E.00885
; object ids of layer 35 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer35 end: 399
M625
; LINE_WIDTH: 0.44999
G1 X203.188 Y207.853 E.0013
G1 X203.188 Y207.892 E.0013
G1 X203.188 Y207.931 E.0013
G1 X203.188 Y207.97 E.0013
G1 X203.188 Y208.009 E.0013
G1 X203.188 Y208.048 E.0013
G1 X203.188 Y208.088 E.0013
G1 X203.188 Y208.127 E.0013
G1 X203.188 Y208.166 E.0013
G1 X203.188 Y208.205 E.0013
G1 F5681.764
G1 X203.188 Y208.244 E.0013
G1 F5135.232
M73 P96 R3
G1 X203.188 Y208.284 E.0013
G1 F4616.46
G1 X203.188 Y208.323 E.0013
G1 F4125.184
G1 X203.188 Y208.362 E.0013
G1 F3661.654
G1 X203.188 Y208.401 E.0013
G1 F3225.634
G1 X203.188 Y208.44 E.0013
G1 F2817.345
G1 X203.188 Y208.479 E.0013
G1 F2436.58
G1 X203.188 Y208.519 E.0013
G1 F2083.533
G1 X203.188 Y208.558 E.0013
G1 F1758.024
G1 X203.188 Y208.591 E.00112
; FEATURE: Overhang wall
G1 F1500
M204 S500
G1 X203.187 Y209.861 E.04212
G1 X203.111 Y210.015 E.0057
G1 X202.95 Y210.069 E.00564
G1 X197.753 Y210.066 E.17239
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00564
G1 X197.549 Y201.281 E.28351
G1 X197.625 Y201.127 E.0057
G1 X197.786 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862

G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734

G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605

G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477

G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349

G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 F600
G1 X206.16 Y201.746 E.00474
G1 F1500
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349

G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477

G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605

G1 X205.894 Y201.979 E.00383
; LINE_WIDTH: 0.533734

G1 X205.828 Y202.038 E.00353
; LINE_WIDTH: 0.491862

G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 F600
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.196 Y202.824 E.01288
G1 X203.19 Y204.353 E.05074
; FEATURE: Inner wall
G1 F806.488
M204 S1000
G1 X203.19 Y204.394 E.00136
G1 F1084.424
G1 X203.19 Y204.442 E.00158
G1 F1403.506
G1 X203.19 Y204.49 E.00158
G1 F1763.602
G1 X203.19 Y204.538 E.00158
G1 F2164.773
G1 X203.19 Y204.585 E.00158
G1 F2607.117
G1 X203.19 Y204.633 E.00158
G1 F3090.447
G1 X203.19 Y204.681 E.00158
G1 F3614.854
G1 X203.19 Y204.729 E.00158
G1 F4180.458
G1 X203.19 Y204.776 E.00158
G1 F4787.024
G1 X203.19 Y204.824 E.00158
G1 F5434.666
G1 X203.19 Y204.872 E.00158
G1 F6000
G1 X203.19 Y204.92 E.00158
G1 X203.19 Y204.968 E.00158
G1 X203.19 Y205.015 E.00158
G1 X203.19 Y205.063 E.00158
G1 X203.19 Y205.111 E.00158
G1 X203.19 Y205.159 E.00158
G1 X203.19 Y205.206 E.00158
G1 X203.19 Y205.254 E.00158
G1 X203.19 Y205.302 E.00158
; LINE_WIDTH: 0.475215
G1 X203.184 Y205.464 E.0057
M204 S250
G1 X203.582 Y205.539 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3000
M204 S500
G1 X203.582 Y205.645 E.00325
G1 X203.582 Y205.75 E.00325
G1 X203.582 Y205.856 E.00325
G1 X203.582 Y205.962 E.00325
G1 X203.581 Y206.068 E.00325
G1 X203.581 Y206.174 E.00325
G1 X203.581 Y206.279 E.00325
G1 X203.581 Y206.385 E.00325
G1 X203.581 Y206.491 E.00325
G1 X203.581 Y206.597 E.00325
G1 X203.581 Y206.702 E.00325
G1 X203.581 Y206.808 E.00325
G1 X203.581 Y206.959 E.00463
G1 X203.581 Y207.019 E.00185
G1 X203.581 Y207.079 E.00185
G1 X203.581 Y207.139 E.00185
G1 X203.581 Y207.2 E.00185
G1 X203.581 Y207.26 E.00185
G1 X203.581 Y207.32 E.00185
G1 X203.581 Y207.38 E.00185
G1 X203.581 Y207.44 E.00185
G1 X203.581 Y207.5 E.00185
G1 X203.581 Y207.56 E.00185
G1 X203.581 Y207.62 E.00185
G1 X203.581 Y207.681 E.00185
G1 X203.581 Y207.741 E.00185
G1 F2810.809
G1 X203.581 Y207.801 E.00185
G1 F2238.485
G1 X203.581 Y207.861 E.00185
G1 F1731.242
G1 X203.58 Y207.921 E.00185
G1 F1289.08
G1 X203.58 Y207.981 E.00185
G1 F912
G1 X203.58 Y208.041 E.00185
; FEATURE: Overhang wall
G1 F600
G3 X203.552 Y210.009 I-27.252 J.593 E.06049
G1 X203.438 Y210.236 E.0078
G1 X203.264 Y210.378 E.00689
G1 X202.979 Y210.461 E.00913
G1 X198.559 Y210.458 E.13582
G1 X197.605 Y210.43 E.02931
G1 X197.378 Y210.316 E.0078
G1 X197.236 Y210.142 E.00689
G1 X197.153 Y209.857 E.00913
G1 X197.157 Y201.329 E.26202
G3 X197.472 Y200.764 I.646 J-.01 E.02083
G1 X197.757 Y200.681 E.00913
G1 X202.815 Y200.681 E.15539
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582

G1 X208.083 Y202.261 E.01582
G1 X206.222 Y202.261 E.0572
G1 X206.119 Y202.292 E.00329
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.582 Y204.904 E.06159
; FEATURE: Outer wall
G1 F1192.195
G1 X203.582 Y205.01 E.00325
G1 F1985.807
G1 X203.582 Y205.116 E.00325
G1 F2980.791
G1 X203.582 Y205.222 E.00325
G1 F3000
G1 X203.582 Y205.327 E.00325
G1 X203.582 Y205.433 E.00325
G1 X203.582 Y205.479 E.00141
; WIPE_START
M204 S1000
G1 X203.582 Y205.645 E-.06299
G1 X203.582 Y205.75 E-.04019
G1 X203.582 Y205.856 E-.04019
G1 X203.582 Y205.962 E-.04019
G1 X203.581 Y206.068 E-.04019
G1 X203.581 Y206.174 E-.04019
G1 X203.581 Y206.279 E-.04019
G1 X203.581 Y206.385 E-.04019
G1 X203.581 Y206.491 E-.04019
G1 X203.581 Y206.597 E-.04019
G1 X203.581 Y206.702 E-.04019
G1 X203.581 Y206.808 E-.04019
G1 X203.581 Y206.959 E-.05732
G1 X203.581 Y207.019 E-.02285
G1 X203.581 Y207.079 E-.02285
G1 X203.581 Y207.139 E-.02285
G1 X203.581 Y207.2 E-.02285
G1 X203.581 Y207.26 E-.02285
G1 X203.581 Y207.32 E-.02285
G1 X203.581 Y207.38 E-.02285
G1 X203.581 Y207.44 E-.02285
G1 X203.581 Y207.479 E-.01479
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.266 Y207.434 Z1.7 F30000
G1 X203.182 Y204.69
G1 X203.182 Y202.311
G1 X207.508 Y201.594
G1 X206.16 Y201.594
G1 X206.16 Y201.746
G1 Z1.3
G1 E.8 F1800
; FEATURE: Overhang wall
; LINE_WIDTH: 0.70122
G1 F1500
M204 S500
G1 X206.222 Y201.746 E.0033
; LINE_WIDTH: 0.69586

G1 X207.568 Y201.746 E.07164
; WIPE_START
M204 S1000
G1 X206.222 Y201.746 E-.72678
G1 X206.16 Y201.746 E-.03322
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.7 I1.217 J0 P1  F30000
G1 X206.16 Y201.594 Z1.7
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.424 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.695
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.666 Y205.338
G1 X199.018 Y205.539
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X199.319 Y205.107 E.01617
G1 X199.747 Y204.757 E.01698
G1 X200.254 Y204.537 E.01699
G1 X200.802 Y204.463 E.01699
G1 X201.29 Y204.526 E.01514
G1 X201.78 Y204.722 E.01619
G1 X202.182 Y205.021 E.01541
G1 X202.525 Y205.455 E.01699
G1 X202.737 Y205.965 E.01698
G1 X202.801 Y206.515 E.01699
M73 P96 R2
G1 X202.713 Y207.06 E.01698
G1 X202.48 Y207.562 E.017
G1 X202.118 Y207.981 E.01699
G1 X201.657 Y208.285 E.01698
G1 X201.129 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.04 Y208.333 E.01699
G1 X199.561 Y208.058 E.01699
G1 X199.175 Y207.662 E.01699
G1 X198.912 Y207.175 E.01699
G1 X198.791 Y206.636 E.01699
G1 X198.823 Y206.084 E.01699
G1 X198.992 Y205.592 E.01597
; WIPE_START
M204 S1000
G1 X199.319 Y205.107 E-.22229
G1 X199.747 Y204.757 E-.21003
G1 X200.254 Y204.537 E-.2101
G1 X200.561 Y204.495 E-.11759
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.529 Y204.076 Z1.7 F30000
G1 X200.506 Y204.077
G1 X200.338 Y204.104
G1 X200.176 Y204.141
G1 X200.017 Y204.189
G1 X199.861 Y204.248
G1 X199.71 Y204.317
G1 X199.564 Y204.397
G1 X199.424 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.695
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.658 Y205.351
G1 X198.586 Y205.501
G1 X198.524 Y205.655
G1 X198.473 Y205.814
G1 X198.434 Y205.975
G1 X198.412 Y206.1
G1 X197.99 Y206.026
G1 Z1.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52142
G1 F6000
M204 S1000
G1 X197.981 Y206.638 E.02387
; LINE_WIDTH: 0.50371
G1 X197.979 Y206.771 E.005
; WIPE_START
G1 X197.981 Y206.638 E-.13584
G1 X197.99 Y206.026 E-.62416
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.7 I0 J-1.217 P1  F30000
G1 X197.554 Y206.026 Z1.7
G1 X197.758 Y210.061
G1 X203.182 Y209.856
G1 X203.182 Y208.103
G1 X203.337 Y206.153
G1 X203.319 Y205.958
G1 X203.164 Y205.973
G1 Z1.3
G1 E.8 F1800
; LINE_WIDTH: 0.50044
G1 F6000
M204 S1000
G1 X203.177 Y206.223 E.00936
; LINE_WIDTH: 0.47429
G1 X203.19 Y206.474 E.00883
; LINE_WIDTH: 0.4941
G1 X203.167 Y206.805 E.01218
; LINE_WIDTH: 0.54006
G1 X203.144 Y207.135 E.01343
; LINE_WIDTH: 0.5402
G1 X203.144 Y207.136 E.00004
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.7 I1.206 J-.165 P1  F30000
G1 X202.47 Y202.229 Z1.7
G1 Z1.3
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.44147
G1 F1500
M204 S1000
G1 X198.694 Y202.229 E.12265
G1 X198.693 Y202.628 E.01294
G1 X202.076 Y202.628 E.10985
G1 X202.06 Y202.658 E.0011
G1 X202.053 Y203.026 E.01197
G1 X198.693 Y203.026 E.1091
G1 X198.693 Y203.425 E.01294
G1 X199.369 Y203.425 E.02194
; CHANGE_LAYER
; Z_HEIGHT: 1.41429
; LAYER_HEIGHT: 0.114286
; WIPE_START
G1 F1500
G1 X198.693 Y203.425 E-.25669
G1 X198.693 Y203.026 E-.15145
G1 X199.619 Y203.026 E-.35186
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 36/58
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.7 I-.529 J1.096 P1  F30000
G1 X203.195 Y204.753 Z1.7
G1 X206.632 Y206.412
G1 Z1.414
G1 E.8 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.257143
G1 F2555
M204 S1000
G2 X206.893 Y207.287 I.834 J.227 E.03679
G2 X207.098 Y207.333 I.235 J-.568 E.00806
G1 X211.271 Y207.333 E.15951
G2 X211.705 Y206.865 I-.033 J-.465 E.02683
; object ids of layer 36 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer36 end: 399
M625
G1 X211.705 Y206.223 E.02454
G1 X206.632 Y206.223 E.1939
G1 X206.632 Y205.96 E.01008
G1 X207.126 Y205.96 E.0189
M204 S10000
G1 X207.989 Y205.922 F30000
G1 F2555
M204 S1000
G1 X208.341 Y205.689 E.01611
G1 X209.243 Y203.564 E.08823
G1 X209.203 Y203.346 E.00848
G1 X211.705 Y203.346 E.09562
G1 X211.705 Y200.469 E.10997
G1 X208.564 Y200.469 E.12005
G2 X208.572 Y199.706 I-1.365 J-.396 E.02956
G1 X208.124 Y198.36 E.05421
G1 X207.06 Y197.592 E.05016
G1 X211.705 Y197.592 E.17754
G1 X211.705 Y196.676 E.03502
G2 X211.611 Y196.325 I-1.062 J.096 E.01395
G2 X211.25 Y196.211 I-.471 J.857 E.01456
G1 X207.098 Y196.21 E.15872
G2 X206.658 Y196.519 I-.001 J.465 E.02191
G2 X206.632 Y197.533 I2.673 J.576 E.03899
G1 X206.89 Y197.533 E.00989
; CHANGE_LAYER
; Z_HEIGHT: 1.5
; LAYER_HEIGHT: 0.0857143
; WIPE_START
G1 F9000
G1 X206.632 Y197.533 E-.0983
G1 X206.658 Y196.519 E-.38543
G1 X206.848 Y196.281 E-.11587
G1 X207.098 Y196.21 E-.09861
G1 X207.26 Y196.21 E-.0618
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 37/58
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.814 I-.987 J-.712 P1  F30000
G1 X203.782 Y201.032 Z1.814
G1 X203.404 Y201.082
G1 X197.554 Y201.286
G1 X197.554 Y208.55
G1 X198.358 Y208.55
G1 Z1.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44638
; LAYER_HEIGHT: 0.2
G1 F2555
M204 S1000
G1 X198.698 Y208.906 E.01619
G1 X199.218 Y209.254 E.02057
G1 X198.358 Y209.254 E.02828
G1 X198.358 Y208.61 E.02116
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.9 I1.192 J-.246 P1  F30000
G1 X197.979 Y206.771 Z1.9
G1 Z1.5
G1 E.8 F1800
; LINE_WIDTH: 0.49986
G1 F2555
M204 S1000
G1 X197.987 Y206.805 E.00128
; LINE_WIDTH: 0.49555
G1 X198.205 Y207.547 E.02851
; LINE_WIDTH: 0.44999
G1 X198.596 Y208.212 E.02559
G2 X199.154 Y208.745 I2.198 J-1.741 E.02568
G1 X199.836 Y209.106 E.0256
; LINE_WIDTH: 0.46307
G1 X200.319 Y209.241 E.01717
G1 X200.59 Y209.264 E.00933
; LINE_WIDTH: 0.44769
G1 X201.092 Y209.257 E.01654
; LINE_WIDTH: 0.45418
G1 X201.361 Y209.218 E.00912
G1 X202.087 Y208.958 E.02586
; LINE_WIDTH: 0.44999
G1 X202.51 Y208.687 E.01664
G1 X202.781 Y208.438 E.01223
G1 X202.78 Y209.662 E.04062
G2 X201.095 Y209.662 I-.86 J596.743 E.0559
; LINE_WIDTH: 0.46307
G2 X199.763 Y209.66 I-.713 J29.836 E.0456
; LINE_WIDTH: 0.44999
G1 X197.952 Y209.659 E.06008
G1 X197.953 Y207.307 E.078
; LINE_WIDTH: 0.49986
G1 X197.976 Y206.831 E.01774
; WIPE_START
G1 F6000
G1 X197.987 Y206.805 E-.01103
G1 X198.205 Y207.547 E-.29378
G1 X198.596 Y208.212 E-.29319
G1 X198.889 Y208.521 E-.162
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.9 I-.248 J1.191 P1  F30000
G1 X202.425 Y209.256 Z1.9
G1 Z1.5
G1 E.8 F1800
; LINE_WIDTH: 0.44776
G1 F2555
M204 S1000
G3 X202.4 Y209.212 I-.047 J-.002 E.00808
; WIPE_START
G1 F6000
G1 X202.349 Y209.212 E-.152
G1 X202.324 Y209.256 E-.152
G1 X202.349 Y209.3 E-.152
G1 X202.4 Y209.3 E-.152
G1 X202.425 Y209.256 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.9 I0 J1.217 P1  F30000
G1 X203.182 Y209.256 Z1.9
G1 X203.182 Y202.311
G1 X202.813 Y201.888
G1 Z1.5
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F2555
M204 S1000
G1 X202.389 Y202.716 E.03088
G2 X202.377 Y203.687 I7.368 J.581 E.03222
G1 X202.162 Y203.569 E.00812
G1 X201.503 Y203.334 E.02319
G2 X199.545 Y203.526 I-.682 J3.129 E.06635
G1 X198.995 Y203.814 E.02059
G2 X198.362 Y204.38 I1.721 J2.56 E.02826
G1 X198.363 Y201.888 E.08269
G1 X202.753 Y201.888 E.14563
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.9 I.062 J1.215 P1  F30000
G1 X205.521 Y201.746 Z1.9
G1 Z1.5
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F2555
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663
G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102
G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 X202.793 Y202.77 E.02191
G1 X202.783 Y204.502 E.05745
G1 X202.659 Y204.379 E.00578
G1 X202.017 Y203.95 E.02561
G1 X201.317 Y203.715 E.02449
G1 X200.706 Y203.67 E.02035
G1 X200.208 Y203.73 E.01663
G2 X199.248 Y204.132 I.91 J3.515 E.03463
G1 X198.669 Y204.642 E.02559
G1 X198.252 Y205.289 E.02554
; LINE_WIDTH: 0.486805
G1 X198.121 Y205.652 E.01395
; LINE_WIDTH: 0.52362
G1 X197.991 Y206.015 E.01511
G1 X197.973 Y205.626 E.01526
; LINE_WIDTH: 0.486805
G1 X197.954 Y205.237 E.01409
; LINE_WIDTH: 0.44999
G1 X197.956 Y201.48 E.1246
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102
G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.874 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F2555
M204 S1000
G1 X205.828 Y202.038 E.00246
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.196 Y202.823 E.01288
G1 X203.191 Y202.9 E.00253
G1 X203.19 Y205.302 E.07969
; LINE_WIDTH: 0.475215
G1 X203.177 Y205.637 E.01182
; LINE_WIDTH: 0.50044
G1 X203.164 Y205.973 E.01251
G1 X203.114 Y205.815 E.00617
; LINE_WIDTH: 0.47889
G1 X202.836 Y205.216 E.02346
; LINE_WIDTH: 0.44999
G1 X202.416 Y204.706 E.0219
G1 X201.873 Y204.33 E.02191
G1 X201.268 Y204.119 E.02125
G1 X200.755 Y204.074 E.01711
G1 X200.102 Y204.175 E.0219
G1 X199.502 Y204.451 E.0219
G1 X199 Y204.879 E.02189
G1 X198.634 Y205.427 E.02187
G1 X198.434 Y206.047 E.0216
G1 X198.408 Y206.716 E.02222
G1 X198.565 Y207.357 E.0219
G1 X198.891 Y207.931 E.02189
G1 X199.361 Y208.395 E.0219
G1 X199.94 Y208.712 E.0219
G1 X200.584 Y208.86 E.0219
G1 X201.243 Y208.827 E.0219
G1 X201.723 Y208.682 E.01663
G1 X201.936 Y208.571 E.00797
G1 X202.412 Y208.24 E.01921
G1 X202.833 Y207.733 E.02187
G1 X203.096 Y207.137 E.02161
; LINE_WIDTH: 0.45374
G1 X203.187 Y206.635 E.01708
G1 X203.189 Y207.145 E.01708
; LINE_WIDTH: 0.44999
G1 X203.187 Y209.861 E.09009
G1 X203.111 Y210.016 E.0057
G1 X202.95 Y210.069 E.00564
G1 X197.753 Y210.066 E.17239
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00564
G1 X197.549 Y201.281 E.28352
G1 X197.625 Y201.127 E.0057
G1 X197.786 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.919 Y201.957 E.00239
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2555
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.01 I-15.381 J.17 E.03412
G1 X203.438 Y210.236 E.0078
G1 X203.264 Y210.378 E.0069
G1 X202.979 Y210.461 E.00913
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.193 J-24.1 E.04223
G1 X197.378 Y210.316 E.0078
G1 X197.236 Y210.142 E.00689
G1 X197.153 Y209.857 E.00913
G1 X197.157 Y201.329 E.26202
G3 X197.472 Y200.764 I.646 J-.01 E.02083
G1 X197.757 Y200.681 E.00913
G1 X202.815 Y200.681 E.15539
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
; object ids of layer 37 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer37 end: 399
M625
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.9 I1.217 J0 P1  F30000
G1 X204.521 Y202.311 Z1.9
G1 X205.671 Y201.899
G1 X207.682 Y201.885
G1 X207.682 Y201.746
G1 X207.568 Y201.746
G1 Z1.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69586
G1 F2555
M204 S1000
G1 X206.222 Y201.746 E.07164
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.0033
; WIPE_START
G1 F6000
G1 X206.222 Y201.746 E-.03322
G1 X207.568 Y201.746 E-.72678
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.9 I0 J1.217 P1  F30000
G1 X207.682 Y201.746 Z1.9
G1 X205.671 Y201.899
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.839 Y205.06
G1 X198.741 Y205.205
G1 X198.666 Y205.338
G1 X199.018 Y205.539
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2555
M204 S500
G1 X199.319 Y205.107 E.01617
G1 X199.747 Y204.757 E.01698
G1 X200.254 Y204.537 E.01699
G1 X200.802 Y204.463 E.01699
G1 X201.265 Y204.519 E.01434
G1 X201.734 Y204.697 E.01541
G1 X202.182 Y205.021 E.017
G1 X202.525 Y205.455 E.01699
G1 X202.737 Y205.965 E.01698
G1 X202.801 Y206.515 E.017
G1 X202.71 Y207.069 E.01725
G1 X202.48 Y207.562 E.01673
G1 X202.118 Y207.98 E.01698
G1 X201.657 Y208.285 E.01699
G1 X201.129 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.04 Y208.333 E.01699
G1 X199.561 Y208.058 E.01699
G1 X199.175 Y207.661 E.01699
G1 X198.912 Y207.175 E.01699
G1 X198.792 Y206.636 E.01699
G1 X198.825 Y206.075 E.01726
G1 X198.992 Y205.592 E.0157
; WIPE_START
G1 F3600
M204 S1000
G1 X199.319 Y205.107 E-.22229
G1 X199.747 Y204.757 E-.21005
G1 X200.254 Y204.537 E-.21015
G1 X200.56 Y204.495 E-.11751
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.526 Y204.076 Z1.9 F30000
G1 X200.504 Y204.078
G1 X200.338 Y204.104
G1 X200.176 Y204.141
G1 X200.017 Y204.189
G1 X199.861 Y204.248
G1 X199.71 Y204.317
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.839 Y205.06
G1 X198.741 Y205.205
G1 X198.658 Y205.351
G1 X198.586 Y205.501
G1 X198.524 Y205.655
G1 X198.473 Y205.814
G1 X198.436 Y205.966
G1 X198.414 Y206.091
G1 X197.991 Y206.015
G1 Z1.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52362
G1 F2555
M204 S1000
G1 X197.979 Y206.771 E.02964
; WIPE_START
G1 F6000
G1 X197.991 Y206.015 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.9 I0 J-1.217 P1  F30000
G1 X197.554 Y206.015 Z1.9
G1 X197.758 Y210.061
G1 X203.182 Y209.856
G1 X203.182 Y208.103
G1 X203.337 Y206.153
G1 X203.319 Y205.958
G1 X203.164 Y205.973
G1 Z1.5
G1 E.8 F1800
; LINE_WIDTH: 0.50044
G1 F2555
M204 S1000
G1 X203.177 Y206.223 E.00937
; LINE_WIDTH: 0.47429
G1 X203.19 Y206.474 E.00883
; LINE_WIDTH: 0.45374
G1 X203.187 Y206.635 E.00539
G1 E-.8 F1800
M204 S10000
G17
G3 Z1.9 I1.149 J-.4 P1  F30000
G1 X201.917 Y202.985 Z1.9
G1 Z1.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.552096
G1 F2555
M204 S1000
G1 X201.952 Y202.569 E.01733
G1 X202.061 Y202.355 E.00996
G2 X199.985 Y202.353 I-1.065 J27.295 E.08615
; LINE_WIDTH: 0.542965
G1 X199.73 Y202.329 E.01045
; LINE_WIDTH: 0.493775
G1 X199.475 Y202.304 E.00942
; LINE_WIDTH: 0.422574
G2 X198.755 Y202.28 I-.488 J3.725 E.02232
G1 X198.754 Y203.505 E.0379
G1 X199.181 Y203.253 E.01534
; LINE_WIDTH: 0.43899
G1 X199.443 Y203.138 E.00924
; LINE_WIDTH: 0.47699
G1 X199.705 Y203.022 E.01012
; LINE_WIDTH: 0.528435
G1 X199.966 Y202.906 E.01132
G1 X200.602 Y202.821 E.02536
G1 X201.05 Y202.822 E.01775
; LINE_WIDTH: 0.556651
G1 X201.583 Y202.876 E.02242
G1 X201.86 Y202.967 E.01218
M204 S10000
G1 X199.254 Y202.685 F30000
; LINE_WIDTH: 0.5957
G1 F2555
M204 S1000
G2 X199.259 Y202.797 I-.03 J.057 E.01225
; CHANGE_LAYER
; Z_HEIGHT: 1.67143
; LAYER_HEIGHT: 0.171429
; WIPE_START
G1 F6000
G1 X199.185 Y202.804 E-.20008
G1 X199.15 Y202.745 E-.18664
G1 X199.185 Y202.685 E-.18665
G1 X199.254 Y202.685 E-.18663
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 38/58
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.9 I-.549 J1.086 P1  F30000
G1 X203.193 Y204.675 Z1.9
G1 X206.632 Y206.412
G1 Z1.671
G1 E.8 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.257143
G1 F2448
M204 S1000
G2 X206.893 Y207.287 I.834 J.227 E.03679
G2 X207.098 Y207.333 I.234 J-.567 E.00807
G1 X211.271 Y207.333 E.1595
G2 X211.705 Y206.865 I-.033 J-.465 E.02683
; object ids of layer 38 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer38 end: 399
M625
G1 X211.705 Y206.223 E.02454
G1 X206.632 Y206.223 E.1939
G1 X206.632 Y205.96 E.01008
G1 X207.126 Y205.96 E.0189
M204 S10000
G1 X207.989 Y205.922 F30000
G1 F2448
M204 S1000
G1 X208.341 Y205.689 E.01611
G1 X209.243 Y203.564 E.08823
G1 X209.203 Y203.346 E.00848
G1 X211.705 Y203.346 E.09562
G1 X211.705 Y200.469 E.10997
G1 X208.564 Y200.469 E.12005
G2 X208.572 Y199.706 I-1.364 J-.396 E.02956
G1 X208.124 Y198.36 E.05421
G1 X207.06 Y197.592 E.05016
G1 X211.705 Y197.592 E.17754
G1 X211.705 Y196.676 E.03502
G2 X211.611 Y196.325 I-1.062 J.096 E.01395
G2 X211.25 Y196.211 I-.476 J.871 E.01455
G1 X207.098 Y196.21 E.15873
G2 X206.658 Y196.519 I-.002 J.465 E.02191
G2 X206.632 Y197.533 I2.674 J.576 E.03899
G1 X206.89 Y197.533 E.00989
; CHANGE_LAYER
; Z_HEIGHT: 1.7
; LAYER_HEIGHT: 0.0285715
; WIPE_START
G1 F9000
G1 X206.632 Y197.533 E-.09831
G1 X206.658 Y196.519 E-.38543
G1 X206.848 Y196.281 E-.11583
G1 X207.098 Y196.21 E-.0987
G1 X207.26 Y196.21 E-.06173
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 39/58
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.071 I-.987 J-.712 P1  F30000
G1 X203.782 Y201.032 Z2.071
G1 X203.404 Y201.082
G1 X197.554 Y201.286
G1 X197.554 Y208.55
G1 X198.358 Y208.55
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44639
; LAYER_HEIGHT: 0.2
G1 F2448
M204 S1000
G1 X198.699 Y208.906 E.01619
G1 X199.22 Y209.254 E.02062
G1 X198.358 Y209.254 E.02834
G1 X198.358 Y208.61 E.02116
G1 E-.8 F1800
M204 S10000
G1 X197.979 Y206.78 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.50074
G1 F2448
M204 S1000
G1 X197.988 Y206.815 E.00135
; LINE_WIDTH: 0.49613
G1 X198.205 Y207.547 E.02819
; LINE_WIDTH: 0.44999
G1 X198.596 Y208.212 E.02561
G2 X199.156 Y208.746 I2.183 J-1.728 E.02576
G1 X199.848 Y209.11 E.02592
; LINE_WIDTH: 0.46199
G1 X200.332 Y209.242 E.01713
G1 X200.581 Y209.264 E.00855
; LINE_WIDTH: 0.44772
G1 X201.094 Y209.257 E.01691
; LINE_WIDTH: 0.45419
G1 X201.361 Y209.218 E.00906
G1 X202.09 Y208.956 E.02595
; LINE_WIDTH: 0.44999
G1 X202.518 Y208.68 E.0169
G1 X202.781 Y208.439 E.01184
G1 X202.78 Y209.662 E.04059
G2 X201.097 Y209.662 I-.867 J605.541 E.05582
; LINE_WIDTH: 0.46199
G2 X199.777 Y209.66 I-.71 J31.887 E.04508
; LINE_WIDTH: 0.44999
G1 X197.952 Y209.659 E.06054
G1 X197.953 Y207.309 E.07794
; LINE_WIDTH: 0.475365
G1 X197.966 Y207.044 E.00933
; LINE_WIDTH: 0.50074
G1 X197.976 Y206.84 E.00764
; WIPE_START
G1 F6000
G1 X197.988 Y206.815 E-.01054
G1 X198.205 Y207.547 E-.29002
G1 X198.596 Y208.212 E-.29337
G1 X198.897 Y208.529 E-.16606
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X202.425 Y209.256 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44794
G1 F2448
M204 S1000
G3 X202.4 Y209.212 I-.047 J-.002 E.00809
; WIPE_START
G1 F6000
G1 X202.349 Y209.212 E-.152
G1 X202.324 Y209.256 E-.152
G1 X202.349 Y209.3 E-.152
G1 X202.4 Y209.3 E-.152
G1 X202.425 Y209.256 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.182 Y209.256 Z2.1 F30000
G1 X203.182 Y202.311
G1 X202.813 Y201.888
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F2448
M204 S1000
G1 X202.389 Y202.716 E.03088
G2 X202.377 Y203.687 I7.368 J.581 E.03222
G1 X202.162 Y203.569 E.00811
G1 X201.503 Y203.334 E.0232
G2 X199.546 Y203.525 I-.682 J3.14 E.0663
G1 X198.995 Y203.814 E.02063
G2 X198.362 Y204.38 I1.721 J2.561 E.02827
G1 X198.363 Y201.888 E.08269
G1 X202.753 Y201.888 E.14563
G1 E-.8 F1800
M204 S10000
G1 X205.521 Y201.746 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F2448
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663
G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102
G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 X202.793 Y202.77 E.02191
G1 X202.783 Y204.502 E.05744
G1 X202.659 Y204.379 E.00579
G1 X202.018 Y203.95 E.0256
G1 X201.314 Y203.715 E.02459
G1 X200.693 Y203.67 E.02067
G1 X200.195 Y203.733 E.01664
G2 X199.249 Y204.132 I.912 J3.485 E.03419
G1 X198.669 Y204.642 E.02559
G1 X198.251 Y205.291 E.02561
; LINE_WIDTH: 0.485595
G1 X198.12 Y205.66 E.01412
; LINE_WIDTH: 0.5212
G1 X197.99 Y206.029 E.01526
G1 X197.977 Y205.885 E.00565
; LINE_WIDTH: 0.495365
G1 X197.964 Y205.74 E.00534
; LINE_WIDTH: 0.46953
G1 X197.954 Y205.239 E.01743
; LINE_WIDTH: 0.44999
G1 X197.956 Y201.48 E.12468
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102
G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.874 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F2448
M204 S1000
G1 X205.828 Y202.038 E.00246
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.196 Y202.823 E.01288
G1 X203.191 Y202.9 E.00253
G1 X203.19 Y205.302 E.07968
; LINE_WIDTH: 0.475205
G1 X203.177 Y205.637 E.01183
; LINE_WIDTH: 0.50042
G1 X203.164 Y205.973 E.01252
G1 X203.114 Y205.815 E.00618
; LINE_WIDTH: 0.47887
G1 X202.836 Y205.215 E.02348
; LINE_WIDTH: 0.44999
G1 X202.416 Y204.706 E.0219
G1 X201.873 Y204.33 E.0219
G1 X201.267 Y204.119 E.02131
G1 X200.744 Y204.074 E.01741
G1 X200.093 Y204.178 E.02185
G1 X199.502 Y204.45 E.02159
G1 X199 Y204.879 E.02189
G1 X198.634 Y205.429 E.02191
G1 X198.431 Y206.058 E.02195
G1 X198.409 Y206.726 E.02214
G1 X198.565 Y207.357 E.02159
G1 X198.891 Y207.932 E.02191
G1 X199.363 Y208.396 E.02195
G1 X199.95 Y208.716 E.0222
G1 X200.593 Y208.861 E.02185
G1 X201.243 Y208.827 E.02159
G1 X201.723 Y208.682 E.01664
G1 X201.934 Y208.572 E.00789
G1 X202.419 Y208.234 E.0196
G1 X202.833 Y207.732 E.0216
; LINE_WIDTH: 0.495105
G1 X202.988 Y207.434 E.01237
; LINE_WIDTH: 0.54022
G1 X203.144 Y207.137 E.01361
G1 X203.164 Y207.311 E.00714
; LINE_WIDTH: 0.50026
G1 X203.176 Y207.562 E.00936
; LINE_WIDTH: 0.475125
G1 X203.188 Y207.813 E.00884
; LINE_WIDTH: 0.44999
G1 X203.187 Y209.861 E.06795
G1 X203.111 Y210.016 E.0057
G1 X202.95 Y210.069 E.00565
G1 X197.753 Y210.066 E.17239
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00565
G1 X197.549 Y201.281 E.28351
G1 X197.625 Y201.127 E.0057
G1 X197.786 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.919 Y201.957 E.00239
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2448
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.01 I-15.383 J.17 E.03412
G1 X203.438 Y210.236 E.0078
G1 X203.264 Y210.378 E.0069
G1 X202.979 Y210.461 E.00914
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.193 J-24.088 E.04222
G1 X197.378 Y210.316 E.0078
G1 X197.236 Y210.142 E.00689
G1 X197.153 Y209.857 E.00914
G1 X197.157 Y201.33 E.26201
G3 X197.472 Y200.764 I.646 J-.01 E.02084
G1 X197.757 Y200.681 E.00913
G1 X202.815 Y200.681 E.15539
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
; object ids of layer 39 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer39 end: 399
M625
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.521 Y202.311 Z2.1 F30000
G1 X205.671 Y201.899
G1 X207.682 Y201.885
G1 X207.682 Y201.746
G1 X207.568 Y201.746
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69586
G1 F2448
M204 S1000
G1 X206.222 Y201.746 E.07164
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.0033
; WIPE_START
G1 F6000
G1 X206.222 Y201.746 E-.03322
G1 X207.568 Y201.746 E-.72678
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X207.682 Y201.746 Z2.1 F30000
G1 X205.671 Y201.899
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.695
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.665 Y205.338
G1 X199.018 Y205.539
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2448
M204 S500
G1 X199.319 Y205.107 E.01618
G1 X199.747 Y204.757 E.01698
G1 X200.246 Y204.539 E.01672
G1 X200.793 Y204.463 E.01698
G1 X201.265 Y204.519 E.01462
G1 X201.734 Y204.697 E.01542
G1 X202.182 Y205.021 E.01699
G1 X202.525 Y205.455 E.01699
G1 X202.737 Y205.965 E.01699
G1 X202.801 Y206.515 E.01699
G1 X202.713 Y207.06 E.01698
G1 X202.48 Y207.562 E.01699
G1 X202.125 Y207.975 E.01673
G1 X201.657 Y208.284 E.01723
G1 X201.13 Y208.451 E.017
G1 X200.585 Y208.469 E.01673
G1 X200.049 Y208.336 E.01698
G1 X199.562 Y208.058 E.01725
G1 X199.176 Y207.662 E.017
G1 X198.912 Y207.175 E.017
G1 X198.792 Y206.644 E.01672
G1 X198.822 Y206.084 E.01723
G1 X198.992 Y205.593 E.01598
; WIPE_START
G1 F3600
M204 S1000
G1 X199.319 Y205.107 E-.22241
G1 X199.747 Y204.757 E-.21004
G1 X200.246 Y204.539 E-.2068
G1 X200.56 Y204.496 E-.12075
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.524 Y204.076 Z2.1 F30000
G1 X200.502 Y204.078
G1 X200.337 Y204.104
G1 X200.167 Y204.143
G1 X200.016 Y204.189
G1 X199.86 Y204.248
G1 X199.701 Y204.322
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.695
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.658 Y205.352
G1 X198.582 Y205.51
G1 X198.524 Y205.655
G1 X198.473 Y205.814
G1 X198.434 Y205.976
G1 X198.411 Y206.103
G1 X197.99 Y206.029
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5212
G1 F2448
M204 S1000
G1 X197.979 Y206.78 E.02926
; WIPE_START
G1 F6000
G1 X197.99 Y206.029 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X198.411 Y206.103 Z2.1 F30000
G1 X198.405 Y206.139
G1 X198.388 Y206.305
G1 X198.382 Y206.473
G1 X198.389 Y206.647
G1 X198.405 Y206.803
G1 X198.434 Y206.967
G1 X198.473 Y207.129
G1 X198.524 Y207.287
G1 X198.586 Y207.442
G1 X198.658 Y207.592
G1 X198.741 Y207.736
G1 X198.834 Y207.876
G1 X198.941 Y208.014
G1 X199.045 Y208.131
G1 X199.163 Y208.248
G1 X199.29 Y208.356
G1 X199.423 Y208.456
G1 X199.564 Y208.545
G1 X199.711 Y208.626
G1 X199.87 Y208.698
G1 X200.016 Y208.754
G1 X200.176 Y208.802
G1 X200.339 Y208.839
G1 X200.512 Y208.866
G1 X200.668 Y208.879
G1 X200.835 Y208.882
G1 X201.001 Y208.873
G1 X201.166 Y208.853
G1 X201.33 Y208.822
G1 X201.491 Y208.779
G1 X201.648 Y208.726
G1 X201.802 Y208.661
G1 X201.95 Y208.587
G1 X202.093 Y208.502
G1 X202.232 Y208.406
G1 X202.368 Y208.297
G1 X202.483 Y208.191
G1 X202.598 Y208.07
G1 X202.704 Y207.942
G1 X202.79 Y207.799
G1 X202.849 Y207.641
G1 X202.901 Y207.476
G1 X202.94 Y207.328
G1 X202.974 Y207.172
G1 X202.985 Y207.109
G1 X203.144 Y207.137
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.54022
G1 F2448
M204 S1000
G1 X203.144 Y207.136 E.00004
; LINE_WIDTH: 0.54006
G1 X203.167 Y206.805 E.01343
; LINE_WIDTH: 0.4941
G1 X203.19 Y206.474 E.01218
; LINE_WIDTH: 0.47428
G1 X203.177 Y206.224 E.00883
; LINE_WIDTH: 0.50042
G1 X203.164 Y205.973 E.00936
G1 E-.8 F1800
M204 S10000
G1 X201.917 Y202.985 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.551772
G1 F2448
M204 S1000
G1 X201.952 Y202.569 E.01732
G1 X202.061 Y202.355 E.00995
G2 X200.054 Y202.351 I-1.062 J27.056 E.08326
; LINE_WIDTH: 0.539215
G1 X199.885 Y202.327 E.0069
; LINE_WIDTH: 0.491525
G1 X199.716 Y202.303 E.00624
; LINE_WIDTH: 0.421388
G1 X199.547 Y202.28 E.00526
G1 X198.755 Y202.28 E.02443
G1 X198.754 Y203.505 E.03778
G1 X199.393 Y203.164 E.02234
; LINE_WIDTH: 0.441332
G1 X199.613 Y203.07 E.00776
; LINE_WIDTH: 0.484015
G1 X199.833 Y202.977 E.00859
; LINE_WIDTH: 0.534134
G1 X200.053 Y202.883 E.00957
G3 X201.037 Y202.821 I.767 J4.326 E.03952
; LINE_WIDTH: 0.556418
G1 X201.582 Y202.876 E.02295
G1 X201.86 Y202.967 E.0122
M204 S10000
G1 X199.249 Y202.681 F30000
; LINE_WIDTH: 0.5863
G1 F2448
M204 S1000
G2 X199.253 Y202.792 I-.03 J.057 E.0118
; CHANGE_LAYER
; Z_HEIGHT: 1.9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X199.181 Y202.799 E-.19885
G1 X199.147 Y202.74 E-.18705
G1 X199.181 Y202.681 E-.18705
G1 X199.249 Y202.681 E-.18705
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 40/58
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.1 I-1.203 J-.183 P1  F30000
G1 X198.358 Y208.55 Z2.1
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44639
G1 F1954
M204 S1000
G1 X198.699 Y208.906 E.01619
G1 X199.218 Y209.254 E.02057
G1 X198.358 Y209.254 E.02828
G1 X198.358 Y208.61 E.02116
G1 E-.8 F1800
M204 S10000
G1 X197.979 Y206.771 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.49986
G1 F1954
M204 S1000
G1 X197.987 Y206.805 E.00128
; LINE_WIDTH: 0.49555
G1 X198.205 Y207.547 E.02852
; LINE_WIDTH: 0.44999
G1 X198.596 Y208.212 E.0256
G2 X199.154 Y208.745 I2.197 J-1.74 E.02567
G1 X199.836 Y209.106 E.0256
; LINE_WIDTH: 0.46307
G1 X200.319 Y209.241 E.01717
G1 X200.591 Y209.264 E.00933
; LINE_WIDTH: 0.44769
G1 X201.092 Y209.257 E.01654
; LINE_WIDTH: 0.45418
G1 X201.361 Y209.218 E.00912
G1 X202.088 Y208.958 E.02586
; LINE_WIDTH: 0.44999
G1 X202.51 Y208.687 E.01663
G1 X202.781 Y208.437 E.01223
G1 X202.78 Y209.662 E.04062
G2 X201.095 Y209.662 I-.86 J596.732 E.0559
; LINE_WIDTH: 0.46307
G2 X199.764 Y209.66 I-.713 J29.851 E.0456
; LINE_WIDTH: 0.44999
G1 X197.952 Y209.659 E.06008
G1 X197.953 Y207.307 E.078
; LINE_WIDTH: 0.49986
G1 X197.976 Y206.831 E.01774
; WIPE_START
G1 F6000
G1 X197.987 Y206.805 E-.01103
G1 X198.205 Y207.547 E-.29385
G1 X198.596 Y208.212 E-.2933
G1 X198.889 Y208.521 E-.16182
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X202.425 Y209.256 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44776
G1 F1954
M204 S1000
G3 X202.4 Y209.212 I-.047 J-.002 E.00808
; WIPE_START
G1 F6000
G1 X202.349 Y209.212 E-.152
G1 X202.324 Y209.256 E-.152
G1 X202.349 Y209.3 E-.152
G1 X202.4 Y209.3 E-.152
G1 X202.425 Y209.256 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.182 Y209.256 Z2.3 F30000
G1 X203.182 Y202.311
G1 X202.813 Y201.888
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1954
M204 S1000
G1 X202.389 Y202.716 E.03088
G2 X202.377 Y203.687 I7.368 J.581 E.03222
G1 X202.162 Y203.569 E.00812
G1 X201.503 Y203.334 E.0232
G2 X199.545 Y203.526 I-.68 J3.15 E.06634
G1 X198.995 Y203.814 E.02059
G2 X198.362 Y204.383 I1.67 J2.495 E.02831
G1 X198.363 Y201.888 E.08276
G1 X202.753 Y201.888 E.14563
G1 E-.8 F1800
M204 S10000
G1 X205.521 Y201.746 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1954
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663
G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102
G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 X202.793 Y202.77 E.02191
G1 X202.783 Y204.502 E.05744
G1 X202.659 Y204.379 E.00578
G1 X202.018 Y203.95 E.02561
G1 X201.309 Y203.714 E.02477
G1 X200.8 Y203.663 E.01698
G1 X200.203 Y203.731 E.01993
G2 X198.856 Y204.445 I.772 J3.081 E.05105
G1 X198.665 Y204.649 E.00928
G1 X198.238 Y205.318 E.02633
; LINE_WIDTH: 0.485695
G1 X198.114 Y205.672 E.01354
; LINE_WIDTH: 0.5214
G1 X197.99 Y206.026 E.01463
G1 X197.972 Y205.648 E.01477
; LINE_WIDTH: 0.485695
G1 X197.954 Y205.269 E.01367
; LINE_WIDTH: 0.44999
G1 X197.956 Y201.48 E.12568
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102
G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.874 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1954
M204 S1000
G1 X205.828 Y202.038 E.00246
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.196 Y202.823 E.01288
G1 X203.191 Y202.9 E.00253
G1 X203.19 Y205.302 E.07968
; LINE_WIDTH: 0.475205
G1 X203.177 Y205.637 E.01183
; LINE_WIDTH: 0.50042
G1 X203.164 Y205.973 E.01252
G1 X203.114 Y205.815 E.00617
; LINE_WIDTH: 0.47887
G1 X202.836 Y205.215 E.02348
; LINE_WIDTH: 0.44999
G1 X202.416 Y204.706 E.02189
G1 X201.873 Y204.33 E.0219
G1 X201.263 Y204.119 E.02141
G1 X200.727 Y204.075 E.01787
G1 X200.102 Y204.175 E.02098
G1 X199.502 Y204.451 E.0219
G1 X198.997 Y204.883 E.02205
G1 X198.622 Y205.454 E.02266
G1 X198.431 Y206.057 E.02097
G1 X198.408 Y206.716 E.02189
G1 X198.565 Y207.358 E.0219
G1 X198.891 Y207.932 E.0219
G1 X199.361 Y208.395 E.02189
G1 X199.94 Y208.712 E.0219
G1 X200.584 Y208.86 E.0219
G1 X201.243 Y208.827 E.0219
G1 X201.723 Y208.682 E.01664
G1 X201.936 Y208.571 E.00796
G1 X202.412 Y208.24 E.01922
G1 X202.833 Y207.732 E.02191
; LINE_WIDTH: 0.495105
G1 X202.988 Y207.434 E.01237
; LINE_WIDTH: 0.54022
G1 X203.144 Y207.137 E.0136
G1 X203.164 Y207.311 E.00714
; LINE_WIDTH: 0.50027
G1 X203.176 Y207.562 E.00935
; LINE_WIDTH: 0.47513
G1 X203.188 Y207.813 E.00884
; LINE_WIDTH: 0.44999
G1 X203.187 Y209.861 E.06795
G1 X203.112 Y210.015 E.0057
G1 X202.95 Y210.069 E.00564
G1 X197.753 Y210.066 E.17239
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00564
G1 X197.549 Y201.281 E.28351
G1 X197.625 Y201.127 E.0057
G1 X197.786 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.919 Y201.957 E.00239
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1954
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.009 I-15.385 J.17 E.03411
G1 X203.438 Y210.236 E.00781
G1 X203.264 Y210.378 E.00689
G1 X202.979 Y210.461 E.00913
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.193 J-24.101 E.04223
G1 X197.378 Y210.316 E.00781
G1 X197.236 Y210.142 E.00689
G1 X197.153 Y209.857 E.00913
G1 X197.157 Y201.329 E.26202
G3 X197.472 Y200.764 I.646 J-.01 E.02083
G1 X197.757 Y200.681 E.00913
G1 X202.815 Y200.681 E.15539
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
; object ids of layer 40 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer40 end: 399
M625
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.521 Y202.311 Z2.3 F30000
G1 X205.671 Y201.899
G1 X207.682 Y201.885
G1 X207.682 Y201.746
G1 X207.568 Y201.746
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69586
G1 F1954
M204 S1000
G1 X206.222 Y201.746 E.07164
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.0033
; WIPE_START
G1 F6000
G1 X206.222 Y201.746 E-.03322
G1 X207.568 Y201.746 E-.72678
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X207.682 Y201.746 Z2.3 F30000
G1 X205.671 Y201.899
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.739 Y205.209
G1 X198.664 Y205.344
G1 X199.021 Y205.542
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1954
M204 S500
G1 X199.318 Y205.109 E.01614
G1 X199.747 Y204.757 E.01703
G1 X200.254 Y204.537 E.01699
G1 X200.776 Y204.464 E.0162
G1 X201.265 Y204.519 E.01513
G1 X201.734 Y204.697 E.01541
G1 X202.182 Y205.021 E.01699
G1 X202.525 Y205.455 E.01698
G1 X202.737 Y205.966 E.01699
G1 X202.801 Y206.515 E.01699
G1 X202.713 Y207.06 E.01698
G1 X202.48 Y207.562 E.01699
G1 X202.118 Y207.98 E.017
G1 X201.657 Y208.285 E.01698
G1 X201.13 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.041 Y208.333 E.01699
G1 X199.561 Y208.058 E.01699
G1 X199.176 Y207.662 E.01698
G1 X198.912 Y207.175 E.01699
G1 X198.791 Y206.636 E.01699
G1 X198.823 Y206.084 E.01699
G1 X198.989 Y205.592 E.01594
; WIPE_START
G1 F3600
M204 S1000
G1 X199.318 Y205.109 E-.22231
G1 X199.747 Y204.757 E-.21065
G1 X200.254 Y204.537 E-.21017
G1 X200.559 Y204.494 E-.11688
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.522 Y204.076 Z2.3 F30000
G1 X200.503 Y204.078
G1 X200.338 Y204.104
G1 X200.176 Y204.141
G1 X200.017 Y204.189
G1 X199.861 Y204.248
G1 X199.71 Y204.317
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.739 Y205.209
G1 X198.646 Y205.376
G1 X198.586 Y205.501
G1 X198.523 Y205.659
G1 X198.467 Y205.841
G1 X198.434 Y205.976
G1 X198.412 Y206.1
G1 X197.99 Y206.026
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5214
G1 F1954
M204 S1000
G1 X197.979 Y206.771 E.02906
; WIPE_START
G1 F6000
G1 X197.99 Y206.026 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X197.554 Y206.026 Z2.3 F30000
G1 X197.758 Y210.061
G1 X203.182 Y209.856
G1 X203.182 Y208.103
G1 X203.337 Y206.153
G1 X203.319 Y205.958
G1 X203.164 Y205.973
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.50042
G1 F1954
M204 S1000
G1 X203.177 Y206.224 E.00936
; LINE_WIDTH: 0.47428
G1 X203.19 Y206.474 E.00883
; LINE_WIDTH: 0.49411
G1 X203.167 Y206.805 E.01219
; LINE_WIDTH: 0.54008
G1 X203.144 Y207.136 E.01343
; LINE_WIDTH: 0.54022
G1 X203.144 Y207.137 E.00004
G1 E-.8 F1800
M204 S10000
G1 X201.917 Y202.985 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.551808
G1 F1954
M204 S1000
G1 X201.952 Y202.569 E.01732
G1 X202.061 Y202.355 E.00995
G2 X200.036 Y202.352 I-1.065 J26.967 E.08401
; LINE_WIDTH: 0.539824
G1 X199.85 Y202.328 E.00759
; LINE_WIDTH: 0.49189
G1 X199.664 Y202.304 E.00685
; LINE_WIDTH: 0.42156
G1 X199.478 Y202.28 E.00578
G1 X198.755 Y202.28 E.02233
G1 X198.754 Y203.505 E.0378
G1 X199.393 Y203.165 E.02233
; LINE_WIDTH: 0.441182
G1 X199.615 Y203.07 E.00784
; LINE_WIDTH: 0.483565
G1 X199.838 Y202.976 E.00868
; LINE_WIDTH: 0.533679
G1 X200.061 Y202.881 E.00967
G3 X201.01 Y202.821 I.747 J4.219 E.03813
; LINE_WIDTH: 0.555974
G1 X201.581 Y202.876 E.02399
G1 X201.86 Y202.967 E.01224
M204 S10000
G1 X199.249 Y202.681 F30000
; LINE_WIDTH: 0.58666
G1 F1954
M204 S1000
G2 X199.253 Y202.792 I-.03 J.057 E.01181
; CHANGE_LAYER
; Z_HEIGHT: 1.92857
; LAYER_HEIGHT: 0.0285715
; WIPE_START
G1 F6000
G1 X199.181 Y202.799 E-.19891
G1 X199.147 Y202.74 E-.18703
G1 X199.181 Y202.681 E-.18703
G1 X199.249 Y202.681 E-.18702
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 41/58
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.3 I-.549 J1.086 P1  F30000
G1 X203.193 Y204.674 Z2.3
G1 X206.632 Y206.412
G1 Z1.929
G1 E.8 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.257143
G1 F2452
M204 S1000
G2 X206.893 Y207.287 I.834 J.227 E.03678
G2 X207.098 Y207.333 I.234 J-.567 E.00807
G1 X211.271 Y207.333 E.1595
G2 X211.705 Y206.865 I-.033 J-.465 E.02683
; object ids of layer 41 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer41 end: 399
M625
G1 X211.705 Y206.223 E.02454
G1 X206.632 Y206.223 E.1939
G1 X206.632 Y205.96 E.01008
G1 X207.126 Y205.96 E.0189
M204 S10000
G1 X207.989 Y205.922 F30000
G1 F2452
M204 S1000
G1 X208.341 Y205.689 E.01612
G1 X209.243 Y203.564 E.08823
G1 X209.203 Y203.346 E.00848
G1 X211.705 Y203.346 E.09562
G1 X211.705 Y200.469 E.10997
G1 X208.564 Y200.469 E.12005
G2 X208.572 Y199.705 I-1.364 J-.396 E.02956
G1 X208.124 Y198.36 E.05421
G1 X207.06 Y197.592 E.05016
G1 X211.705 Y197.592 E.17754
G1 X211.705 Y196.676 E.03501
G2 X211.251 Y196.211 I-.428 J-.037 E.0282
G1 X207.098 Y196.21 E.15873
G2 X206.658 Y196.519 I-.002 J.465 E.02191
G2 X206.632 Y197.533 I2.672 J.576 E.039
G1 X206.89 Y197.533 E.00989
; CHANGE_LAYER
; Z_HEIGHT: 2.1
; LAYER_HEIGHT: 0.171428
; WIPE_START
G1 F9000
G1 X206.632 Y197.533 E-.09832
G1 X206.658 Y196.519 E-.38548
G1 X206.848 Y196.281 E-.11576
G1 X207.098 Y196.21 E-.09871
G1 X207.26 Y196.21 E-.06172
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 42/58
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.329 I-.987 J-.712 P1  F30000
G1 X203.779 Y201.032 Z2.329
G1 X203.404 Y201.082
G1 X197.554 Y201.286
G1 X197.554 Y208.543
G1 X198.358 Y208.543
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44575
; LAYER_HEIGHT: 0.2
G1 F2452
M204 S1000
G2 X199.203 Y209.255 I2.416 J-2.011 E.03647
G1 X198.357 Y209.254 E.02776
G1 X198.358 Y208.603 E.02138
G1 E-.8 F1800
M204 S10000
G1 X198.011 Y207.148 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.56522
G1 F2452
M204 S1000
G1 X198.065 Y207.261 E.00531
; LINE_WIDTH: 0.527955
G1 X198.118 Y207.374 E.00493
; LINE_WIDTH: 0.49069
G1 X198.481 Y208.056 E.0282
; LINE_WIDTH: 0.44999
G2 X199.001 Y208.627 I2.312 J-1.585 E.02569
G1 X199.656 Y209.034 E.02559
; LINE_WIDTH: 0.45354
G1 X200.398 Y209.248 E.02584
G1 X201.17 Y209.249 E.02581
; LINE_WIDTH: 0.44999
G1 X201.913 Y209.041 E.0256
G1 X202.353 Y208.8 E.01663
G1 X202.781 Y208.432 E.01873
G1 X202.78 Y209.662 E.0408
G2 X200.889 Y209.665 I-.652 J169.192 E.06274
; LINE_WIDTH: 0.45056
G2 X199.553 Y209.66 I-1.098 J103.281 E.04439
; LINE_WIDTH: 0.44999
G1 X197.952 Y209.659 E.05308
G1 X197.953 Y207.905 E.05816
; LINE_WIDTH: 0.4884
G1 X197.972 Y207.653 E.00919
; LINE_WIDTH: 0.52681
G1 X197.992 Y207.401 E.00998
; LINE_WIDTH: 0.56522
G1 X198.006 Y207.208 E.00822
; WIPE_START
G1 F6000
G1 X198.065 Y207.261 E-.02986
G1 X198.118 Y207.374 E-.04743
G1 X198.481 Y208.056 E-.29367
G1 X198.801 Y208.443 E-.19062
G1 X199.001 Y208.627 E-.10335
G1 X199.214 Y208.759 E-.09507
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X202.424 Y209.254 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.45122
G1 F2452
M204 S1000
G3 X202.398 Y209.21 I-.048 J-.002 E.00822
; WIPE_START
G1 F6000
G1 X202.347 Y209.21 E-.15198
G1 X202.322 Y209.254 E-.15201
G1 X202.347 Y209.298 E-.15199
G1 X202.398 Y209.298 E-.15201
G1 X202.424 Y209.254 E-.15201
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.182 Y209.254 Z2.5 F30000
G1 X203.182 Y202.311
G1 X202.813 Y201.888
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F2452
M204 S1000
G1 X202.388 Y202.722 E.03106
G2 X202.377 Y203.679 I7.502 J.571 E.03175
G1 X201.749 Y203.408 E.02266
G2 X200.83 Y203.267 I-.911 J2.864 E.03098
G1 X200.086 Y203.337 E.02478
G2 X198.995 Y203.814 I1.08 J3.955 E.03965
G1 X198.365 Y204.365 E.02775
G3 X198.363 Y201.888 I576.145 J-1.664 E.08217
G1 X202.753 Y201.888 E.14563
G1 E-.8 F1800
M204 S10000
G1 X205.521 Y201.746 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F2452
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663
G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102
G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 X202.792 Y202.774 E.02204
G1 X202.783 Y204.5 E.05725
G1 X202.219 Y204.055 E.02383
G1 X201.659 Y203.805 E.02036
G1 X201.17 Y203.694 E.01663
G1 X200.865 Y203.673 E.01014
G1 X200.156 Y203.738 E.0236
G2 X199.248 Y204.132 I1.122 J3.823 E.03292
G1 X198.69 Y204.615 E.02449
G1 X198.338 Y205.118 E.02036
; LINE_WIDTH: 0.486294
G1 X198.228 Y205.356 E.00946
; LINE_WIDTH: 0.522597
G1 X198.118 Y205.593 E.01024
; LINE_WIDTH: 0.5589
G1 X198.008 Y205.831 E.01101
G1 X197.988 Y205.685 E.00621
; LINE_WIDTH: 0.51869
G1 X197.968 Y205.539 E.00572
; LINE_WIDTH: 0.47848
G1 X197.954 Y205.037 E.0178
; LINE_WIDTH: 0.44999
G1 X197.956 Y201.48 E.11798
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102
G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.874 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F2452
M204 S1000
G1 X205.828 Y202.038 E.00246
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.191 Y202.9 E.01524
G1 X203.19 Y205.472 E.08532
; LINE_WIDTH: 0.475135
G1 X203.177 Y205.723 E.00884
; LINE_WIDTH: 0.50028
G1 X203.164 Y205.973 E.00936
G1 X203.041 Y205.666 E.01233
; LINE_WIDTH: 0.475135
G1 X202.918 Y205.359 E.01165
; LINE_WIDTH: 0.44999
G1 X202.534 Y204.822 E.0219
G1 X202.036 Y204.419 E.02125
G1 X201.559 Y204.2 E.0174
G1 X200.9 Y204.078 E.02225
G1 X200.102 Y204.175 E.02665
G1 X199.502 Y204.451 E.0219
G1 X199.012 Y204.863 E.02125
G1 X198.711 Y205.282 E.01711
G1 X198.466 Y205.895 E.02189
G1 X198.397 Y206.552 E.02191
G1 X198.509 Y207.202 E.02189
G1 X198.795 Y207.797 E.02189
G1 X199.232 Y208.292 E.0219
G1 X199.788 Y208.648 E.02189
G1 X200.419 Y208.84 E.0219
G1 X201.079 Y208.852 E.02189
G1 X201.718 Y208.684 E.0219
G1 X202.286 Y208.348 E.0219
G1 X202.741 Y207.87 E.0219
G1 X203.049 Y207.285 E.0219
; LINE_WIDTH: 0.46116
G1 X203.179 Y206.801 E.01708
G1 X203.189 Y207.302 E.01708
; LINE_WIDTH: 0.44999
G1 X203.187 Y209.861 E.08489
G1 X203.112 Y210.016 E.0057
G1 X202.95 Y210.069 E.00564
G1 X197.753 Y210.066 E.17239
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00564
G1 X197.549 Y201.281 E.28351
G1 X197.625 Y201.127 E.00569
G1 X197.786 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.919 Y201.957 E.00239
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2452
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.009 I-15.407 J.169 E.03412
G1 X203.438 Y210.236 E.0078
G1 X203.264 Y210.378 E.00689
G1 X202.979 Y210.461 E.00913
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.194 J-24.087 E.04223
G1 X197.378 Y210.316 E.0078
G1 X197.236 Y210.142 E.0069
G1 X197.153 Y209.857 E.00913
G1 X197.157 Y201.329 E.26202
G3 X197.472 Y200.764 I.646 J-.01 E.02083
G1 X197.757 Y200.681 E.00913
G1 X202.815 Y200.681 E.15539
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
; object ids of layer 42 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer42 end: 399
M625
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.521 Y202.311 Z2.5 F30000
G1 X205.671 Y201.899
G1 X207.682 Y201.885
G1 X207.682 Y201.746
G1 X207.568 Y201.746
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69586
G1 F2452
M204 S1000
G1 X206.222 Y201.746 E.07164
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.0033
; WIPE_START
G1 F6000
G1 X206.222 Y201.746 E-.03322
G1 X207.568 Y201.746 E-.72678
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X207.682 Y201.746 Z2.5 F30000
G1 X205.671 Y201.899
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.738 Y205.211
G1 X198.666 Y205.342
G1 X199.027 Y205.54
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2452
M204 S500
G1 X199.07 Y205.44 E.00335
G1 X199.355 Y205.07 E.01435
G1 X199.747 Y204.757 E.01541
G1 X200.254 Y204.537 E.01699
G1 X200.934 Y204.469 E.02099
G1 X201.472 Y204.582 E.01691
G1 X201.898 Y204.794 E.01461
G1 X202.279 Y205.12 E.01541
G1 X202.591 Y205.577 E.01699
G1 X202.767 Y206.101 E.01699
G1 X202.793 Y206.653 E.01699
G1 X202.668 Y207.191 E.01698
G1 X202.4 Y207.676 E.01699
G1 X202.011 Y208.068 E.01699
G1 X201.53 Y208.34 E.01699
G1 X200.992 Y208.47 E.01699
G1 X200.44 Y208.448 E.01698
G1 X199.914 Y208.277 E.01699
G1 X199.455 Y207.969 E.01699
G1 X199.097 Y207.547 E.01699
G1 X198.868 Y207.044 E.01698
G1 X198.785 Y206.498 E.01698
G1 X198.854 Y205.949 E.017
G1 X199.004 Y205.595 E.01179
; WIPE_START
G1 F3600
M204 S1000
G1 X199.07 Y205.44 E-.06419
G1 X199.355 Y205.07 E-.17744
G1 X199.747 Y204.757 E-.19055
G1 X200.254 Y204.537 E-.21017
G1 X200.562 Y204.506 E-.11766
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.525 Y204.076 Z2.5 F30000
G1 X200.502 Y204.078
G1 X200.338 Y204.104
G1 X200.176 Y204.141
G1 X200.016 Y204.189
G1 X199.861 Y204.248
G1 X199.71 Y204.317
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.738 Y205.211
G1 X198.638 Y205.393
G1 X198.586 Y205.501
G1 X198.524 Y205.655
G1 X198.473 Y205.814
G1 X198.434 Y205.976
G1 X198.405 Y206.139
G1 X198.388 Y206.305
G1 X198.382 Y206.477
G1 X198.393 Y206.684
G1 X198.405 Y206.803
G1 X198.434 Y206.967
G1 X198.451 Y207.04
G1 X198.011 Y207.148
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.56522
G1 F2452
M204 S1000
G1 X197.992 Y206.879 E.01148
; LINE_WIDTH: 0.52756
G1 X197.974 Y206.61 E.01065
; LINE_WIDTH: 0.5244
G1 X197.991 Y206.221 E.0153
; LINE_WIDTH: 0.5589
G1 X198.008 Y205.831 E.0164
; WIPE_START
G1 F6000
G1 X197.991 Y206.221 E-.22467
G1 X197.974 Y206.61 E-.22467
G1 X197.992 Y206.879 E-.15533
G1 X198.011 Y207.148 E-.15533
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X197.554 Y207.148 Z2.5 F30000
G1 X197.758 Y210.061
G1 X203.182 Y209.856
G1 X203.182 Y208.103
G1 X203.337 Y206.153
G1 X203.319 Y205.959
G1 X203.164 Y205.973
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.50028
G1 F2452
M204 S1000
G1 X203.187 Y206.64 E.02484
; LINE_WIDTH: 0.4624
G1 X203.183 Y206.761 E.00417
G1 E-.8 F1800
M204 S10000
G1 X201.913 Y202.94 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.572672
G1 F2452
M204 S1000
G1 X201.947 Y202.574 E.01584
G1 X202.057 Y202.359 E.01041
G1 X201.419 Y202.346 E.02754
; LINE_WIDTH: 0.544537
G2 X200.005 Y202.353 I-.634 J15.161 E.0578
; LINE_WIDTH: 0.542099
G1 X199.743 Y202.328 E.0107
; LINE_WIDTH: 0.493255
G1 X199.481 Y202.304 E.00966
; LINE_WIDTH: 0.422615
G2 X198.755 Y202.28 I-.494 J3.887 E.02253
G1 X198.754 Y203.505 E.03791
G1 X199.182 Y203.253 E.01534
; LINE_WIDTH: 0.43899
G1 X199.443 Y203.138 E.00923
; LINE_WIDTH: 0.47699
G1 X199.705 Y203.022 E.01012
; LINE_WIDTH: 0.51499
G1 X199.966 Y202.906 E.01101
; LINE_WIDTH: 0.547221
G1 X200.028 Y202.875 E.00282
G1 X200.929 Y202.817 E.0371
; LINE_WIDTH: 0.54046
G1 X201.262 Y202.853 E.01357
; LINE_WIDTH: 0.572175
G3 X201.854 Y202.93 I-.487 J6.045 E.02576
M204 S10000
G1 X199.254 Y202.685 F30000
; LINE_WIDTH: 0.59568
G1 F2452
M204 S1000
G2 X199.259 Y202.797 I-.03 J.057 E.01225
; CHANGE_LAYER
; Z_HEIGHT: 2.18571
; LAYER_HEIGHT: 0.0857143
; WIPE_START
G1 F6000
G1 X199.185 Y202.804 E-.20008
G1 X199.15 Y202.745 E-.18664
G1 X199.185 Y202.685 E-.18665
G1 X199.254 Y202.685 E-.18663
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 43/58
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.5 I-.581 J1.07 P1  F30000
G1 X203.197 Y204.825 Z2.5
G1 X206.631 Y206.689
G1 Z2.186
G1 E.8 F1800
; FEATURE: Support transition
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.257143
G1 F1500
M204 S1000
G1 X206.631 Y205.96 E.02788
G1 X207.361 Y205.96 E.0279
G1 E-.8 F1800
M204 S10000
G17
G3 Z2.586 I.891 J.828 P1  F30000
G1 X209.077 Y204.114 Z2.586
G1 Z2.186
G1 E.8 F1800
; FEATURE: Support
G1 F9000
M204 S1000
G1 X209.065 Y203.985 E.00494
G1 X208.731 Y204.771 E.03262
G1 X208.978 Y204.503 E.01392
G1 X209.075 Y204.171 E.01324
M204 S10000
G1 X208.994 Y205.046 F30000
; FEATURE: Support transition
G1 F1500
M204 S1000
G1 X208.527 Y205.258 E.01963
G3 X207.932 Y205.96 I-.833 J-.104 E.03719
G1 X207.55 Y205.96 E.0146
G1 X206.632 Y206.878 E.04961
G2 X207.134 Y207.333 I.467 J-.011 E.02899
G1 X211.705 Y202.762 E.24706
G1 X211.705 Y203.72 E.0366
G1 X208.092 Y207.333 E.19531
G1 X209.049 Y207.333 E.0366
G1 X211.532 Y204.85 E.1342
G1 X211.532 Y205.808 E.0366
G1 X210.007 Y207.333 E.08244
G1 X210.964 Y207.333 E.0366
G1 X211.532 Y206.765 E.03068
; object ids of layer 43 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer43 end: 399
M625
G1 X211.532 Y207.231 E.0178
G3 X211.271 Y207.333 I-.325 J-.449 E.0108
G1 X211.153 Y207.333 E.00454
M204 S10000
G1 X211.705 Y202.574 F30000
G1 F1500
M204 S1000
G1 X211.705 Y201.805 E.02939
G1 X209.452 Y204.058 E.12178
G2 X209.203 Y203.349 I-1.55 J.145 E.029
G1 X211.705 Y200.847 E.13521
G1 X211.705 Y199.89 E.0366
G1 X208.839 Y202.756 E.15491
G1 X208.805 Y202.721 E.00186
G1 X208.832 Y201.805 E.03499
G1 X211.705 Y198.932 E.15531
G1 X211.705 Y197.975 E.0366
G1 X208.832 Y200.848 E.15531
G1 X208.556 Y200.502 E.0169
G1 X209.002 Y200.29 E.01884
M204 S10000
G1 X209.075 Y199.423 F30000
; FEATURE: Support
G1 F9000
M204 S1000
G1 X208.925 Y199.835 E.01679
G1 X208.591 Y200.096 E.01617
G1 X208.572 Y199.705 E.01494
G1 X208.2 Y198.587 E.04506
G1 X208.52 Y198.621 E.01233
G1 X208.811 Y198.784 E.01273
G1 X209.009 Y199.052 E.01273
G1 X209.077 Y199.366 E.01229
M204 S10000
G1 X211.705 Y197.786 F30000
; FEATURE: Support transition
G1 F1500
M204 S1000
G1 X211.705 Y197.017 E.02939
G1 X209.449 Y199.272 E.12191
G1 X209.354 Y198.901 E.01464
G1 X209.162 Y198.602 E.01359
G1 X211.49 Y196.275 E.1258
G1 X211.447 Y196.257 E.00176
G2 X210.597 Y196.21 I-.524 J1.762 E.03285
G1 X208.564 Y198.243 E.10987
G1 X208.278 Y198.21 E.01101
G3 X207.755 Y198.094 I-.181 J-.42 E.02185
G1 X209.639 Y196.21 E.10183
G1 X208.682 Y196.21 E.03659
G1 X207.199 Y197.693 E.08015
G2 X206.631 Y197.533 I-.395 J.314 E.02407
G1 X206.631 Y197.303 E.0088
G1 X207.725 Y196.21 E.05909
G2 X206.805 Y196.311 I-.314 J1.381 E.036
G2 X206.631 Y197.114 I.652 J.562 E.03277
; CHANGE_LAYER
; Z_HEIGHT: 2.3
; LAYER_HEIGHT: 0.114286
; WIPE_START
G1 X206.643 Y196.569 E-.20737
G1 X206.805 Y196.311 E-.11582
G1 X207.041 Y196.213 E-.09712
G1 X207.725 Y196.21 E-.25957
G1 X207.575 Y196.359 E-.08013
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 44/58
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.586 I-.971 J-.734 P1  F30000
G1 X204.042 Y201.032 Z2.586
G1 X203.404 Y201.082
G1 X197.554 Y201.286
G1 X197.554 Y208.55
G1 X198.358 Y208.55
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44639
; LAYER_HEIGHT: 0.2
G1 F6000
M204 S1000
G1 X198.699 Y208.906 E.01619
G1 X199.218 Y209.254 E.02057
G1 X198.358 Y209.254 E.02828
G1 X198.358 Y208.61 E.02116
G1 E-.8 F1800
M204 S10000
G1 X197.979 Y206.771 Z2.7 F30000
G1 Z2.3
G1 E.8 F1800
; LINE_WIDTH: 0.49986
G1 F6000
M204 S1000
G1 X197.987 Y206.805 E.00128
; LINE_WIDTH: 0.49556
G1 X198.205 Y207.547 E.02852
; LINE_WIDTH: 0.44999
G1 X198.596 Y208.212 E.0256
G2 X199.154 Y208.745 I2.197 J-1.741 E.02568
G1 X199.836 Y209.106 E.0256
; LINE_WIDTH: 0.46306
G1 X200.319 Y209.241 E.01717
G1 X200.591 Y209.264 E.00933
; LINE_WIDTH: 0.44769
G1 X201.092 Y209.257 E.01654
; LINE_WIDTH: 0.45418
G1 X201.361 Y209.218 E.00912
G1 X202.088 Y208.958 E.02586
; LINE_WIDTH: 0.44999
G1 X202.51 Y208.687 E.01664
G1 X202.781 Y208.438 E.01222
G1 X202.78 Y209.662 E.04062
G2 X201.095 Y209.662 I-.861 J606.932 E.05589
; LINE_WIDTH: 0.46306
G2 X199.763 Y209.66 I-.713 J29.883 E.0456
; LINE_WIDTH: 0.44999
G1 X197.952 Y209.659 E.06008
G1 X197.953 Y207.307 E.078
; LINE_WIDTH: 0.49986
G1 X197.976 Y206.831 E.01773
; WIPE_START
G1 X197.987 Y206.805 E-.01104
G1 X198.205 Y207.547 E-.29378
G1 X198.596 Y208.212 E-.29327
M73 P97 R2
G1 X198.889 Y208.521 E-.16191
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X202.425 Y209.256 Z2.7 F30000
G1 Z2.3
G1 E.8 F1800
; LINE_WIDTH: 0.44776
G1 F6000
M204 S1000
G3 X202.4 Y209.212 I-.047 J-.002 E.00808
; WIPE_START
G1 X202.349 Y209.212 E-.152
G1 X202.324 Y209.256 E-.152
G1 X202.349 Y209.3 E-.152
G1 X202.4 Y209.3 E-.152
G1 X202.425 Y209.256 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.182 Y209.256 Z2.7 F30000
G1 X203.182 Y202.311
G1 X202.813 Y201.888
G1 Z2.3
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X202.389 Y202.716 E.03088
G2 X202.377 Y203.687 I7.368 J.581 E.03222
G1 X202.162 Y203.569 E.00812
G1 X201.503 Y203.334 E.02319
G2 X199.545 Y203.526 I-.682 J3.129 E.06635
G1 X198.995 Y203.814 E.02059
G2 X198.362 Y204.38 I1.72 J2.559 E.02826
G1 X198.363 Y201.888 E.08269
G1 X202.753 Y201.888 E.14563
G1 E-.8 F1800
M204 S10000
G1 X205.521 Y201.746 Z2.7 F30000
G1 Z2.3
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F6000
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663
G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102
G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 X202.793 Y202.77 E.02191
G1 X202.783 Y204.502 E.05745
G1 X202.659 Y204.379 E.00579
G1 X202.017 Y203.95 E.0256
G1 X201.317 Y203.715 E.02449
G1 X200.706 Y203.67 E.02035
G1 X200.208 Y203.73 E.01663
G2 X199.248 Y204.132 I.91 J3.515 E.03463
G1 X198.669 Y204.642 E.0256
G1 X198.251 Y205.291 E.02559
; LINE_WIDTH: 0.485695
G1 X198.12 Y205.658 E.01408
; LINE_WIDTH: 0.5214
G1 X197.99 Y206.026 E.01522
G1 X197.977 Y205.883 E.00559
; LINE_WIDTH: 0.49575
G1 X197.964 Y205.74 E.00529
; LINE_WIDTH: 0.4701
G1 X197.954 Y205.239 E.01746
; LINE_WIDTH: 0.44999
G1 X197.956 Y201.48 E.12467
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102
G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.874 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F6000
M204 S1000
G1 X205.828 Y202.038 E.00246
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.196 Y202.823 E.01288
G1 X203.191 Y202.9 E.00253
G1 X203.19 Y205.302 E.07968
; LINE_WIDTH: 0.475215
G1 X203.177 Y205.637 E.01183
; LINE_WIDTH: 0.50044
G1 X203.164 Y205.973 E.01252
G1 X203.114 Y205.815 E.00617
; LINE_WIDTH: 0.47889
G1 X202.836 Y205.215 E.02348
; LINE_WIDTH: 0.44999
G1 X202.416 Y204.706 E.02189
G1 X201.873 Y204.33 E.0219
G1 X201.268 Y204.119 E.02125
G1 X200.755 Y204.074 E.01711
G1 X200.102 Y204.175 E.0219
G1 X199.502 Y204.451 E.0219
G1 X199 Y204.879 E.0219
G1 X198.634 Y205.428 E.02189
G1 X198.431 Y206.057 E.0219
G1 X198.408 Y206.716 E.02189
G1 X198.565 Y207.357 E.0219
G1 X198.891 Y207.931 E.0219
G1 X199.361 Y208.395 E.0219
G1 X199.94 Y208.712 E.0219
G1 X200.584 Y208.86 E.0219
G1 X201.243 Y208.827 E.0219
G1 X201.723 Y208.682 E.01663
G1 X201.936 Y208.571 E.00797
G1 X202.412 Y208.24 E.01922
G1 X202.833 Y207.732 E.0219
; LINE_WIDTH: 0.495095
G1 X202.988 Y207.434 E.01237
; LINE_WIDTH: 0.5402
G1 X203.144 Y207.137 E.01361
G1 X203.164 Y207.312 E.00714
; LINE_WIDTH: 0.50025
G1 X203.176 Y207.562 E.00936
; LINE_WIDTH: 0.47512
G1 X203.188 Y207.813 E.00884
; LINE_WIDTH: 0.44999
G1 X203.187 Y209.861 E.06795
G1 X203.111 Y210.016 E.0057
G1 X202.95 Y210.069 E.00565
G1 X197.753 Y210.066 E.17239
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00565
G1 X197.549 Y201.281 E.28351
G1 X197.625 Y201.127 E.0057
G1 X197.787 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.919 Y201.957 E.00239
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.01 I-15.386 J.17 E.03412
G1 X203.438 Y210.236 E.0078
G1 X203.264 Y210.378 E.0069
G1 X202.979 Y210.461 E.00913
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.193 J-24.088 E.04222
G1 X197.378 Y210.316 E.0078
G1 X197.236 Y210.142 E.00689
G1 X197.153 Y209.857 E.00914
G1 X197.157 Y201.33 E.26201
G3 X197.472 Y200.764 I.646 J-.01 E.02084
G1 X197.758 Y200.681 E.00913
G1 X202.815 Y200.681 E.15538
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
; object ids of layer 44 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer44 end: 399
M625
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.521 Y202.311 Z2.7 F30000
G1 X205.671 Y201.899
G1 X207.682 Y201.885
G1 X207.682 Y201.746
G1 X207.568 Y201.746
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69586
G1 F6000
M204 S1000
G1 X206.222 Y201.746 E.07164
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.0033
; WIPE_START
G1 X206.222 Y201.746 E-.03322
G1 X207.568 Y201.746 E-.72678
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X207.682 Y201.746 Z2.7 F30000
G1 X205.671 Y201.899
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.424 Y204.487
G1 X199.29 Y204.586
G1 X199.164 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.665 Y205.339
G1 X199.018 Y205.539
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X199.319 Y205.107 E.01618
G1 X199.747 Y204.757 E.01699
G1 X200.254 Y204.537 E.01699
G1 X200.802 Y204.463 E.01699
G1 X201.265 Y204.519 E.01434
G1 X201.734 Y204.697 E.01541
G1 X202.182 Y205.021 E.01699
G1 X202.525 Y205.455 E.01698
G1 X202.737 Y205.965 E.01699
G1 X202.801 Y206.515 E.01699
G1 X202.713 Y207.06 E.01698
G1 X202.48 Y207.562 E.01699
G1 X202.118 Y207.98 E.01699
G1 X201.657 Y208.285 E.01699
G1 X201.129 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.04 Y208.333 E.01699
G1 X199.561 Y208.058 E.01699
G1 X199.175 Y207.662 E.01699
G1 X198.912 Y207.175 E.01699
G1 X198.792 Y206.636 E.01699
G1 X198.823 Y206.084 E.01698
G1 X198.992 Y205.593 E.01596
; WIPE_START
M204 S1000
G1 X199.319 Y205.107 E-.22242
G1 X199.747 Y204.757 E-.21011
G1 X200.254 Y204.537 E-.21018
G1 X200.56 Y204.496 E-.11729
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.524 Y204.076 Z2.7 F30000
G1 X200.502 Y204.078
G1 X200.338 Y204.104
G1 X200.176 Y204.141
G1 X200.016 Y204.189
G1 X199.861 Y204.248
G1 X199.71 Y204.317
G1 X199.564 Y204.397
G1 X199.424 Y204.487
G1 X199.29 Y204.586
G1 X199.164 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.658 Y205.351
G1 X198.586 Y205.501
G1 X198.524 Y205.655
G1 X198.473 Y205.814
G1 X198.434 Y205.976
G1 X198.405 Y206.139
G1 X198.388 Y206.305
G1 X198.382 Y206.471
G1 X198.388 Y206.638
G1 X198.397 Y206.728
G1 X197.979 Y206.771
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5214
G1 F6000
M204 S1000
G1 X197.99 Y206.026 E.02906
; WIPE_START
G1 X197.979 Y206.771 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X197.554 Y206.771 Z2.7 F30000
G1 X197.758 Y210.061
G1 X203.182 Y209.856
G1 X203.182 Y208.103
G1 X203.337 Y206.153
G1 X203.319 Y205.958
G1 X203.164 Y205.973
G1 Z2.3
G1 E.8 F1800
; LINE_WIDTH: 0.50044
G1 F6000
M204 S1000
G1 X203.177 Y206.223 E.00936
; LINE_WIDTH: 0.47429
G1 X203.19 Y206.474 E.00883
; LINE_WIDTH: 0.49409
G1 X203.167 Y206.805 E.01218
; LINE_WIDTH: 0.54004
G1 X203.144 Y207.136 E.01343
; LINE_WIDTH: 0.5402
G1 X203.144 Y207.137 E.00004
G1 E-.8 F1800
M204 S10000
G1 X201.917 Y202.985 Z2.7 F30000
G1 Z2.3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.552102
G1 F6000
M204 S1000
G1 X201.952 Y202.569 E.01733
G1 X202.061 Y202.355 E.00996
G2 X199.986 Y202.353 I-1.065 J27.302 E.08615
; LINE_WIDTH: 0.542974
G1 X199.73 Y202.329 E.01045
; LINE_WIDTH: 0.49378
G1 X199.475 Y202.304 E.00943
; LINE_WIDTH: 0.422574
G2 X198.755 Y202.28 I-.488 J3.725 E.02233
G1 X198.754 Y203.505 E.0379
G1 X199.181 Y203.253 E.01533
; LINE_WIDTH: 0.438989
G1 X199.443 Y203.138 E.00924
; LINE_WIDTH: 0.476985
G1 X199.705 Y203.022 E.01012
; LINE_WIDTH: 0.528434
G1 X199.966 Y202.906 E.01132
G1 X200.602 Y202.821 E.02536
G1 X201.05 Y202.822 E.01775
; LINE_WIDTH: 0.556653
G1 X201.583 Y202.876 E.02242
G1 X201.86 Y202.967 E.01218
M204 S10000
G1 X199.254 Y202.685 F30000
; LINE_WIDTH: 0.59572
G1 F6000
M204 S1000
G2 X199.259 Y202.797 I-.03 J.057 E.01225
; CHANGE_LAYER
; Z_HEIGHT: 2.44286
; LAYER_HEIGHT: 0.142857
; WIPE_START
G1 F6000
G1 X199.185 Y202.804 E-.20007
G1 X199.15 Y202.745 E-.18664
G1 X199.185 Y202.685 E-.18664
G1 X199.254 Y202.685 E-.18665
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 45/58
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.7 I-.627 J1.043 P1  F30000
G1 X203.205 Y205.058 Z2.7
G1 X206.482 Y207.027
G1 Z2.443
G1 E.8 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.257143
G1 F2998
M204 S1000
G1 X207.72 Y205.79 E.06689
G1 E-.8 F1800
M204 S10000
G17
G3 Z2.843 I.933 J.781 P1  F30000
G1 X209.075 Y204.171 Z2.843
G1 Z2.443
G1 E.8 F1800
; FEATURE: Support
G1 F2998
M204 S1000
G1 X208.978 Y204.503 E.01324
G1 X208.731 Y204.771 E.01392
G1 X209.065 Y203.985 E.03262
G1 X209.077 Y204.114 E.00494
G1 E-.8 F1800
M204 S10000
G17
G3 Z2.843 I-1.085 J.55 P1  F30000
G1 X210.794 Y207.503 Z2.843
G1 Z2.443
G1 E.8 F1800
; FEATURE: Support interface
G1 F2998
M204 S1000
G1 X211.532 Y206.765 E.03985
; object ids of layer 45 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer45 end: 399
M625
G1 X211.532 Y205.808 E.0366
G1 X210.007 Y207.333 E.08244
G1 X209.049 Y207.333 E.0366
G1 X211.532 Y204.85 E.1342
G1 X211.532 Y204.152 E.02671
G2 X211.705 Y203.72 I-.129 J-.302 E.01975
G1 X208.092 Y207.333 E.19531
G1 X207.134 Y207.333 E.0366
G1 X211.705 Y202.762 E.24706
G1 X211.705 Y201.805 E.0366
G1 X209.452 Y204.058 E.12178
G1 X209.385 Y203.728 E.01284
G1 X209.23 Y203.437 E.01263
G3 X209.203 Y203.349 I.075 J-.071 E.00364
G1 X211.705 Y200.847 E.13521
G1 X211.705 Y199.89 E.0366
G1 X208.839 Y202.756 E.15491
G1 X208.805 Y202.721 E.00186
G1 X208.832 Y201.805 E.03499
G1 X211.705 Y198.932 E.15531
G1 X211.705 Y197.975 E.0366
G1 X208.832 Y200.848 E.15531
G1 X208.556 Y200.502 E.0169
G1 X208.909 Y200.355 E.0146
G1 X209.168 Y200.134 E.01302
G1 X209.403 Y199.711 E.01846
G1 X209.449 Y199.272 E.01687
G1 X211.705 Y197.017 E.12191
G2 X211.611 Y196.325 I-1.195 J-.19 E.02708
G1 X211.49 Y196.275 E.00502
G1 X209.162 Y198.602 E.1258
G1 X208.909 Y198.388 E.01268
G1 X208.564 Y198.243 E.01431
G1 X210.597 Y196.21 E.10987
G1 X209.639 Y196.21 E.03659
G1 X207.755 Y198.094 E.10183
G1 X207.199 Y197.693 E.02622
G1 X208.682 Y196.21 E.08015
G1 X207.725 Y196.21 E.03659
G1 X206.462 Y197.473 E.06826
G1 E-.8 F1800
M204 S10000
G17
G3 Z2.843 I-.714 J.986 P1  F30000
G1 X209.077 Y199.366 Z2.843
G1 Z2.443
G1 E.8 F1800
; FEATURE: Support
G1 F2998
M204 S1000
G1 X209.009 Y199.052 E.01229
G1 X208.811 Y198.784 E.01273
G1 X208.521 Y198.621 E.01273
G1 X208.2 Y198.587 E.01233
G1 X208.572 Y199.705 E.04506
G1 X208.591 Y200.096 E.01494
G1 X208.924 Y199.836 E.01616
G1 X209.075 Y199.423 E.0168
; CHANGE_LAYER
; Z_HEIGHT: 2.5
; LAYER_HEIGHT: 0.057143
; WIPE_START
G1 F9000
G1 X208.924 Y199.836 E-.16703
G1 X208.591 Y200.096 E-.16065
G1 X208.572 Y199.705 E-.1485
G1 X208.336 Y198.997 E-.28381
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 46/58
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.843 I-.842 J-.879 P1  F30000
G1 X205.669 Y201.55 Z2.843
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.658 Y205.351
G1 X198.586 Y205.501
G1 X198.545 Y205.604
G1 X198.475 Y205.808
G1 X198.434 Y205.976
G1 X198.405 Y206.139
G1 X198.388 Y206.305
G1 X198.382 Y206.471
G1 X198.388 Y206.638
G1 X198.405 Y206.803
G1 X198.434 Y206.967
G1 X198.473 Y207.129
G1 X198.524 Y207.287
G1 X198.565 Y207.39
G1 X198.655 Y207.587
G1 X198.741 Y207.736
G1 X198.833 Y207.875
G1 X198.9 Y207.963
G1 X198.962 Y208.036
G1 X198.358 Y208.55
G1 Z2.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44639
; LAYER_HEIGHT: 0.2
G1 F2998
M204 S1000
G1 X198.699 Y208.906 E.01619
G1 X199.218 Y209.254 E.02057
G1 X198.358 Y209.254 E.02828
G1 X198.358 Y208.61 E.02116
G1 E-.8 F1800
M204 S10000
G1 X197.979 Y206.771 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.49986
G1 F2998
M204 S1000
G1 X197.987 Y206.805 E.00128
; LINE_WIDTH: 0.49555
G1 X198.205 Y207.547 E.02852
; LINE_WIDTH: 0.44999
G1 X198.596 Y208.212 E.0256
G2 X199.154 Y208.745 I2.197 J-1.74 E.02568
G1 X199.836 Y209.106 E.0256
; LINE_WIDTH: 0.46306
G1 X200.319 Y209.241 E.01717
G1 X200.591 Y209.264 E.00933
; LINE_WIDTH: 0.44769
G1 X201.092 Y209.257 E.01654
; LINE_WIDTH: 0.45418
G1 X201.361 Y209.218 E.00912
G1 X202.088 Y208.958 E.02587
; LINE_WIDTH: 0.44999
G1 X202.51 Y208.687 E.01663
G1 X202.781 Y208.438 E.01223
G1 X202.78 Y209.662 E.04062
G2 X201.095 Y209.662 I-.861 J606.953 E.0559
; LINE_WIDTH: 0.46306
G2 X199.764 Y209.66 I-.713 J29.877 E.0456
; LINE_WIDTH: 0.44999
G1 X197.952 Y209.659 E.06008
G1 X197.953 Y207.307 E.078
; LINE_WIDTH: 0.49986
G1 X197.976 Y206.831 E.01774
; WIPE_START
G1 F6000
G1 X197.987 Y206.805 E-.01104
G1 X198.205 Y207.547 E-.29383
G1 X198.596 Y208.212 E-.29328
G1 X198.889 Y208.521 E-.16186
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X202.425 Y209.256 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.44774
G1 F2998
M204 S1000
G3 X202.4 Y209.212 I-.047 J-.002 E.00808
; WIPE_START
G1 F6000
G1 X202.349 Y209.212 E-.152
G1 X202.324 Y209.256 E-.152
G1 X202.349 Y209.3 E-.152
G1 X202.4 Y209.3 E-.152
G1 X202.425 Y209.256 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.182 Y209.256 Z2.9 F30000
G1 X203.182 Y202.311
G1 X202.813 Y201.888
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F2998
M204 S1000
G1 X202.389 Y202.719 E.03097
G3 X202.359 Y203.671 I-61.034 J-1.432 E.03158
G2 X199.545 Y203.526 I-1.553 J2.774 E.09685
G1 X198.995 Y203.814 E.02059
G2 X198.362 Y204.38 I1.721 J2.56 E.02826
G1 X198.363 Y201.888 E.08269
G1 X202.753 Y201.888 E.14563
G1 E-.8 F1800
M204 S10000
G1 X205.521 Y201.746 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F2998
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663
G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102
G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 X202.792 Y202.772 E.02198
G1 X202.783 Y204.5 E.05732
G1 X202.189 Y204.04 E.02492
G2 X199.702 Y203.902 I-1.381 J2.4 E.08569
G1 X199.248 Y204.132 E.01688
G1 X198.669 Y204.642 E.0256
G1 X198.251 Y205.291 E.0256
; LINE_WIDTH: 0.485695
G1 X198.12 Y205.658 E.01408
; LINE_WIDTH: 0.5214
G1 X197.99 Y206.026 E.01522
G1 X197.977 Y205.883 E.00559
; LINE_WIDTH: 0.495745
G1 X197.964 Y205.74 E.00529
; LINE_WIDTH: 0.47009
G1 X197.954 Y205.239 E.01746
; LINE_WIDTH: 0.44999
G1 X197.956 Y201.48 E.12467
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102
G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.874 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F2998
M204 S1000
G1 X205.828 Y202.038 E.00246
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.196 Y202.825 E.01292
G1 X203.191 Y202.9 E.00249
G1 X203.19 Y205.459 E.08491
; LINE_WIDTH: 0.48942
G1 X203.17 Y206.029 E.02074
G1 X203.133 Y205.892 E.00514
; LINE_WIDTH: 0.47517
G1 X202.918 Y205.359 E.02025
; LINE_WIDTH: 0.44999
G1 X202.534 Y204.822 E.0219
G1 X202.018 Y204.41 E.02189
G1 X201.41 Y204.154 E.0219
G1 X200.755 Y204.074 E.0219
G1 X200.102 Y204.175 E.0219
G1 X199.502 Y204.451 E.0219
G1 X199 Y204.879 E.0219
G1 X198.634 Y205.428 E.0219
G1 X198.431 Y206.057 E.0219
G1 X198.408 Y206.716 E.0219
G1 X198.565 Y207.358 E.0219
G1 X198.891 Y207.932 E.0219
G1 X199.361 Y208.395 E.02189
G1 X199.94 Y208.712 E.0219
G1 X200.584 Y208.86 E.0219
G1 X201.243 Y208.827 E.0219
G1 X201.723 Y208.682 E.01664
G1 X201.936 Y208.571 E.00796
G1 X202.412 Y208.241 E.01921
G1 X202.833 Y207.732 E.02189
; LINE_WIDTH: 0.495105
G1 X202.988 Y207.434 E.01238
; LINE_WIDTH: 0.54022
G1 X203.144 Y207.137 E.01362
G1 X203.164 Y207.312 E.00714
; LINE_WIDTH: 0.50024
G1 X203.176 Y207.563 E.00936
; LINE_WIDTH: 0.475115
G1 X203.188 Y207.814 E.00885
; LINE_WIDTH: 0.44999
G1 X203.187 Y209.861 E.06793
G1 X203.111 Y210.016 E.0057
G1 X202.95 Y210.069 E.00564
G1 X197.753 Y210.066 E.17239
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00564
G1 X197.549 Y201.281 E.28351
G1 X197.625 Y201.127 E.0057
G1 X197.786 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.919 Y201.957 E.00239
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2998
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.01 I-15.385 J.17 E.03412
G1 X203.438 Y210.236 E.0078
G1 X203.264 Y210.379 E.0069
G1 X202.979 Y210.461 E.00913
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.193 J-24.108 E.04223
G1 X197.378 Y210.316 E.0078
G1 X197.236 Y210.142 E.0069
G1 X197.153 Y209.857 E.00913
G1 X197.157 Y201.329 E.26202
G3 X197.472 Y200.764 I.646 J-.01 E.02083
G1 X197.757 Y200.681 E.00913
G1 X202.815 Y200.681 E.15539
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
; object ids of layer 46 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer46 end: 399
M625
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.521 Y202.311 Z2.9 F30000
G1 X205.671 Y201.899
G1 X207.682 Y201.885
G1 X207.682 Y201.746
G1 X207.568 Y201.746
G1 Z2.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69586
G1 F2998
M204 S1000
G1 X206.222 Y201.746 E.07164
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.0033
; WIPE_START
G1 F6000
G1 X206.222 Y201.746 E-.03322
G1 X207.568 Y201.746 E-.72678
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X207.682 Y201.746 Z2.9 F30000
G1 X205.671 Y201.899
G1 X203.182 Y202.311
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.658 Y205.351
G1 X198.652 Y205.364
G1 X199.018 Y205.54
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2998
M204 S500
G1 X199.319 Y205.107 E.01619
G1 X199.747 Y204.757 E.01699
G1 X200.254 Y204.537 E.01699
G1 X200.802 Y204.463 E.01699
G1 X201.349 Y204.542 E.01699
G1 X201.854 Y204.766 E.01699
G1 X202.279 Y205.12 E.01698
G1 X202.591 Y205.577 E.01699
G1 X202.76 Y206.067 E.01593
G1 X202.799 Y206.567 E.01541
G1 X202.713 Y207.061 E.01541
G1 X202.479 Y207.562 E.017
G1 X202.118 Y207.98 E.01698
G1 X201.657 Y208.285 E.01698
G1 X201.129 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.041 Y208.333 E.01699
G1 X199.561 Y208.058 E.01699
G1 X199.176 Y207.662 E.01699
G1 X198.912 Y207.175 E.01699
G1 X198.792 Y206.636 E.01699
G1 X198.823 Y206.084 E.01699
G1 X198.992 Y205.593 E.01595
; WIPE_START
G1 F3600
M204 S1000
G1 X199.319 Y205.107 E-.22251
G1 X199.747 Y204.757 E-.21011
G1 X200.254 Y204.537 E-.2101
G1 X200.56 Y204.496 E-.11729
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.532 Y204.075 Z2.9 F30000
G1 X200.508 Y204.077
G1 X200.338 Y204.104
G1 X200.176 Y204.141
G1 X200.017 Y204.189
G1 X199.861 Y204.248
G1 X199.71 Y204.317
G1 X199.564 Y204.397
G1 X199.423 Y204.487
G1 X199.29 Y204.586
G1 X199.163 Y204.694
G1 X199.045 Y204.811
G1 X198.934 Y204.936
G1 X198.833 Y205.068
G1 X198.741 Y205.206
G1 X198.658 Y205.351
G1 X198.586 Y205.501
G1 X198.545 Y205.604
G1 X198.475 Y205.808
G1 X198.434 Y205.976
G1 X198.412 Y206.1
G1 X197.99 Y206.026
M73 P97 R1
G1 Z2.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5214
G1 F2998
M204 S1000
G1 X197.979 Y206.771 E.02907
; WIPE_START
G1 F6000
G1 X197.99 Y206.026 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X198.412 Y206.1 Z2.9 F30000
G1 X198.434 Y205.976
G1 X198.475 Y205.808
G1 X198.545 Y205.604
G1 X198.586 Y205.501
G1 X198.658 Y205.351
G1 X198.741 Y205.206
G1 X198.833 Y205.068
G1 X198.934 Y204.936
G1 X199.045 Y204.811
G1 X199.163 Y204.694
G1 X199.29 Y204.586
G1 X199.423 Y204.487
G1 X199.564 Y204.397
G1 X199.71 Y204.317
G1 X199.861 Y204.248
G1 X200.017 Y204.189
G1 X200.176 Y204.141
G1 X200.338 Y204.104
G1 X200.508 Y204.077
G1 X200.724 Y204.063
G1 X200.835 Y204.061
G1 X201.001 Y204.069
G1 X201.172 Y204.09
G1 X201.384 Y204.135
G1 X201.491 Y204.163
G1 X201.654 Y204.219
G1 X201.851 Y204.306
G1 X201.95 Y204.356
G1 X202.093 Y204.441
G1 X202.23 Y204.536
G1 X202.361 Y204.639
G1 X202.483 Y204.752
G1 X202.598 Y204.873
G1 X202.704 Y205.001
G1 X202.79 Y205.143
G1 X202.849 Y205.3
G1 X202.899 Y205.457
G1 X202.94 Y205.614
G1 X202.976 Y205.776
G1 X203.007 Y205.982
G1 X203.016 Y206.049
G1 X203.17 Y206.029
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.48942
G1 F2998
M204 S1000
G1 X203.192 Y206.535 E.01842
; LINE_WIDTH: 0.49252
G1 X203.168 Y206.835 E.01104
; LINE_WIDTH: 0.54006
G1 X203.144 Y207.136 E.01221
; LINE_WIDTH: 0.54022
G1 X203.144 Y207.137 E.00004
; WIPE_START
G1 F6000
G1 X203.144 Y207.136 E-.00068
G1 X203.168 Y206.835 E-.20639
G1 X203.192 Y206.535 E-.20638
G1 X203.17 Y206.029 E-.34655
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.016 Y206.049 Z2.9 F30000
G1 X203.007 Y205.982
G1 X202.976 Y205.776
G1 X202.94 Y205.614
G1 X202.899 Y205.457
G1 X202.849 Y205.3
G1 X202.79 Y205.143
G1 X202.704 Y205.001
G1 X202.598 Y204.873
G1 X202.483 Y204.752
G1 X202.361 Y204.639
G1 X202.23 Y204.536
G1 X202.093 Y204.441
G1 X199.249 Y202.681
G1 Z2.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.58668
G1 F2998
M204 S1000
G2 X199.253 Y202.792 I-.03 J.057 E.01181
M204 S10000
G1 X201.673 Y202.594 F30000
; LINE_WIDTH: 0.36344
G1 F2998
M204 S1000
G1 X201.613 Y202.628 E.00181
G1 X201.656 Y202.653 E.00129
M204 S10000
G1 X201.99 Y203.081 F30000
; LINE_WIDTH: 0.41999
G1 F2998
M204 S1000
G1 X202.019 Y202.607 E.01458
G1 X202.186 Y202.28 E.0113
G1 X201.653 Y202.28 E.01637
; LINE_WIDTH: 0.438939
G1 X201.472 Y202.299 E.00588
; LINE_WIDTH: 0.476835
G1 X201.291 Y202.318 E.00644
; LINE_WIDTH: 0.514732
G1 X201.11 Y202.336 E.007
; LINE_WIDTH: 0.54722
G1 X200.08 Y202.35 E.04232
; LINE_WIDTH: 0.537299
G1 X199.907 Y202.327 E.00706
; LINE_WIDTH: 0.490375
G1 X199.733 Y202.303 E.00639
; LINE_WIDTH: 0.421394
G1 X199.56 Y202.28 E.0054
G1 X198.755 Y202.28 E.02482
G1 X198.754 Y203.505 E.03779
G1 X199.393 Y203.165 E.02232
; LINE_WIDTH: 0.441192
G1 X199.618 Y203.07 E.00794
; LINE_WIDTH: 0.483595
G1 X199.844 Y202.975 E.00879
; LINE_WIDTH: 0.532753
G1 X200.07 Y202.88 E.00977
G1 X200.8 Y202.812 E.02927
G1 X201.115 Y202.828 E.0126
; LINE_WIDTH: 0.517265
G1 X201.291 Y202.879 E.00708
; LINE_WIDTH: 0.478355
G1 X201.467 Y202.93 E.0065
; LINE_WIDTH: 0.427344
G1 X201.933 Y203.064 E.01518
; CHANGE_LAYER
; Z_HEIGHT: 2.7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X201.467 Y202.93 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 47/58
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.9 I-.726 J.977 P1  F30000
G1 X203.193 Y204.213 Z2.9
G1 X207.617 Y207.503
G1 Z2.7
G1 E.8 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.257143
G1 F2829
M204 S1000
G1 X206.631 Y206.517 E.05328
G1 X206.631 Y205.96 E.02131
G1 X207.031 Y205.96 E.01529
G1 X208.405 Y207.333 E.07424
G1 X209.362 Y207.333 E.0366
G1 X207.966 Y205.937 E.07547
G1 X208.341 Y205.689 E.01717
G1 X208.441 Y205.454 E.00976
G1 X210.32 Y207.333 E.10158
G1 X211.277 Y207.333 E.0366
G1 X208.726 Y204.782 E.13791
G1 X209.012 Y204.11 E.02791
G1 X211.532 Y206.63 E.13623
G1 X211.532 Y205.672 E.0366
G1 X209.202 Y203.343 E.12592
G1 X209.154 Y203.082 E.01013
G1 X208.805 Y202.721 E.01921
G1 X208.831 Y202.015 E.02701
G1 X211.532 Y204.715 E.14597
G1 X211.532 Y204.152 E.02153
G1 X211.705 Y203.93 E.01074
G1 X208.831 Y201.057 E.15532
G1 X208.831 Y200.798 E.00989
G1 X208.552 Y200.519 E.01509
G1 X208.67 Y200.001 E.02032
G1 X208.639 Y199.907 E.00378
G1 X211.705 Y202.973 E.16573
G1 X211.705 Y202.015 E.0366
G1 X206.631 Y196.942 E.27424
G3 X206.892 Y196.256 I.548 J-.184 E.03038
G1 X211.705 Y201.058 E.25986
G1 X211.705 Y200.1 E.0366
G1 X207.814 Y196.21 E.2103
G1 X208.772 Y196.21 E.0366
G1 X211.705 Y199.143 E.15853
G1 X211.705 Y198.185 E.0366
G1 X209.73 Y196.21 E.10677
G1 X210.687 Y196.21 E.0366
G1 X211.875 Y197.397 E.06417
; WIPE_START
G1 F4800
G1 X210.687 Y196.21 E-.63799
G1 X210.366 Y196.21 E-.12201
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X205.656 Y201.047 Z3.1 F30000
G1 X203.193 Y202.321
G1 X199.569 Y204.406
G1 X199.429 Y204.496
G1 X199.296 Y204.595
G1 X199.171 Y204.702
G1 X199.052 Y204.818
G1 X198.942 Y204.943
G1 X198.841 Y205.074
G1 X198.75 Y205.212
G1 X198.668 Y205.356
G1 X198.612 Y205.471
G1 X198.536 Y205.655
G1 X198.484 Y205.817
G1 X198.453 Y205.941
G1 X198.416 Y206.136
G1 X198.398 Y206.306
G1 X198.393 Y206.471
G1 X198.398 Y206.637
G1 X198.416 Y206.802
G1 X198.444 Y206.965
G1 X198.475 Y207.089
G1 X198.533 Y207.28
G1 X198.596 Y207.438
G1 X198.651 Y207.553
G1 X198.747 Y207.727
G1 X198.841 Y207.869
G1 X198.92 Y207.97
G1 X198.964 Y208.022
G1 X198.358 Y208.543
G1 Z2.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44576
; LAYER_HEIGHT: 0.2
G1 F2829
M204 S1000
G2 X199.203 Y209.255 I2.416 J-2.011 E.03647
G1 X198.357 Y209.254 E.02776
G1 X198.358 Y208.603 E.02138
G1 E-.8 F1800
M204 S10000
G1 X198.007 Y207.115 Z3.1 F30000
G1 Z2.7
G1 E.8 F1800
; LINE_WIDTH: 0.55716
G1 F2829
M204 S1000
G1 X198.056 Y207.223 E.00498
; LINE_WIDTH: 0.52421
G1 X198.105 Y207.332 E.00466
; LINE_WIDTH: 0.49126
G1 X198.481 Y208.056 E.0298
; LINE_WIDTH: 0.44999
G2 X199.001 Y208.627 I2.312 J-1.584 E.02569
G1 X199.656 Y209.034 E.0256
; LINE_WIDTH: 0.45357
G1 X200.398 Y209.248 E.02583
G1 X201.17 Y209.249 E.02583
; LINE_WIDTH: 0.44999
G1 X201.913 Y209.041 E.0256
G1 X202.353 Y208.8 E.01664
G1 X202.781 Y208.432 E.01873
G1 X202.78 Y209.662 E.0408
G2 X200.889 Y209.665 I-.652 J169.197 E.06275
; LINE_WIDTH: 0.45057
G2 X199.553 Y209.66 I-1.098 J103.292 E.04439
; LINE_WIDTH: 0.44999
G1 X197.952 Y209.659 E.05308
G1 X197.953 Y207.893 E.05858
; LINE_WIDTH: 0.485714
G1 X197.971 Y207.633 E.00937
; LINE_WIDTH: 0.521437
G1 X197.989 Y207.374 E.01013
; LINE_WIDTH: 0.55716
G1 X198.003 Y207.175 E.00837
; WIPE_START
G1 F6000
G1 X198.056 Y207.223 E-.02737
G1 X198.105 Y207.332 E-.04518
G1 X198.481 Y208.056 E-.30997
G1 X198.8 Y208.443 E-.19063
G1 X199.001 Y208.627 E-.10335
G1 X199.188 Y208.742 E-.0835
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X202.424 Y209.254 Z3.1 F30000
G1 Z2.7
G1 E.8 F1800
; LINE_WIDTH: 0.45124
G1 F2829
M204 S1000
G3 X202.398 Y209.21 I-.048 J-.002 E.00822
; WIPE_START
G1 F6000
G1 X202.347 Y209.21 E-.152
G1 X202.322 Y209.254 E-.152
G1 X202.347 Y209.298 E-.152
G1 X202.398 Y209.298 E-.152
G1 X202.424 Y209.254 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X203.193 Y209.254 Z3.1 F30000
G1 X203.193 Y202.321
G1 X202.813 Y201.888
G1 Z2.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F2829
M204 S1000
G1 X202.388 Y202.722 E.03106
G2 X202.377 Y203.691 I7.6 J.577 E.03218
G1 X201.749 Y203.408 E.02282
G2 X200.83 Y203.267 I-.911 J2.864 E.03098
G1 X200.086 Y203.337 E.02479
G2 X198.603 Y204.127 I.937 J3.548 E.05624
G1 X198.362 Y204.38 E.01161
G1 X198.363 Y201.888 E.08269
G1 X202.753 Y201.888 E.14563
G1 E-.8 F1800
M204 S10000
G1 X205.521 Y201.746 Z3.1 F30000
G1 Z2.7
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F2829
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.772 Y201.894 E.05913
; LINE_WIDTH: 0.49663
G1 X203.597 Y201.904 E.00647
G1 X203.316 Y202.023 E.01127
; LINE_WIDTH: 0.45102
G1 X203.093 Y202.182 E.00911
; LINE_WIDTH: 0.44999
G1 X202.792 Y202.774 E.02204
G1 X202.783 Y204.503 E.05735
G1 X202.353 Y204.142 E.01862
G1 X201.659 Y203.805 E.0256
G1 X201.17 Y203.694 E.01663
G1 X200.865 Y203.673 E.01014
G1 X200.156 Y203.738 E.02361
G2 X199.249 Y204.132 I1.122 J3.823 E.03292
G1 X198.669 Y204.642 E.02559
G1 X198.253 Y205.284 E.02537
; LINE_WIDTH: 0.491815
G1 X198.125 Y205.615 E.013
; LINE_WIDTH: 0.53364
G1 X197.996 Y205.947 E.01422
G1 X197.975 Y205.589 E.01434
; LINE_WIDTH: 0.491815
G1 X197.954 Y205.23 E.01312
; LINE_WIDTH: 0.44999
G1 X197.956 Y201.48 E.12439
G1 X202.815 Y201.48 E.16117
; LINE_WIDTH: 0.45102
G1 X203.172 Y201.431 E.012
; LINE_WIDTH: 0.48732
G2 X205.327 Y201.449 I1.377 J-35.62 E.07806
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.874 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F2829
M204 S1000
G1 X205.828 Y202.038 E.00246
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.772 Y202.319 E.06348
G1 X203.671 Y202.328 E.00334
G1 X203.373 Y202.478 E.01107
G1 X203.191 Y202.9 E.01524
G1 X203.19 Y205.472 E.08533
; LINE_WIDTH: 0.475135
G1 X203.177 Y205.723 E.00884
; LINE_WIDTH: 0.50028
G1 X203.164 Y205.973 E.00936
G1 X203.042 Y205.668 E.01225
; LINE_WIDTH: 0.475135
G1 X202.92 Y205.363 E.01158
; LINE_WIDTH: 0.44999
G1 X202.575 Y204.866 E.02009
G1 X202.158 Y204.5 E.01841
G1 X201.559 Y204.2 E.02219
G1 X200.9 Y204.078 E.02224
G1 X200.102 Y204.175 E.02666
G1 X199.502 Y204.451 E.0219
G1 X199 Y204.879 E.02189
G1 X198.635 Y205.424 E.02177
G1 X198.442 Y205.998 E.02008
G1 X198.396 Y206.547 E.01828
G1 X198.499 Y207.164 E.02074
G1 X198.795 Y207.797 E.02317
G1 X199.232 Y208.291 E.02191
G1 X199.788 Y208.648 E.0219
G1 X200.419 Y208.84 E.02189
G1 X201.079 Y208.852 E.0219
G1 X201.718 Y208.684 E.0219
G1 X202.286 Y208.348 E.0219
G1 X202.741 Y207.87 E.0219
G1 X203.049 Y207.285 E.0219
; LINE_WIDTH: 0.46116
G1 X203.179 Y206.801 E.01709
G1 X203.189 Y207.302 E.01709
; LINE_WIDTH: 0.44999
G1 X203.187 Y209.861 E.08488
G1 X203.111 Y210.016 E.0057
G1 X202.95 Y210.069 E.00565
G1 X197.753 Y210.066 E.17238
G1 X197.599 Y209.99 E.0057
G1 X197.545 Y209.828 E.00565
G1 X197.549 Y201.281 E.28351
G1 X197.625 Y201.127 E.0057
G1 X197.787 Y201.073 E.00565
G1 X202.815 Y201.073 E.16679
G1 X202.995 Y201.023 E.00621
G1 X205.622 Y201.023 E.08713
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.919 Y201.957 E.00239
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2829
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.009 I-15.402 J.169 E.03412
G1 X203.438 Y210.236 E.00781
G1 X203.264 Y210.378 E.00689
G1 X202.979 Y210.461 E.00913
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.194 J-24.083 E.04222
G1 X197.378 Y210.316 E.00781
G1 X197.236 Y210.142 E.00689
G1 X197.153 Y209.857 E.00914
G1 X197.157 Y201.33 E.26201
G3 X197.472 Y200.764 I.646 J-.01 E.02084
G1 X197.758 Y200.681 E.00913
G1 X202.815 Y200.681 E.15538
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
; object ids of layer 47 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer47 end: 399
M625
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.521 Y202.321 Z3.1 F30000
G1 X205.668 Y201.896
G1 X207.693 Y201.887
G1 X207.693 Y201.746
G1 X207.568 Y201.746
G1 Z2.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69586
G1 F2829
M204 S1000
G1 X206.222 Y201.746 E.07164
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.0033
; WIPE_START
G1 F6000
G1 X206.222 Y201.746 E-.03322
G1 X207.568 Y201.746 E-.72678
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X207.693 Y201.746 Z3.1 F30000
G1 X205.668 Y201.896
G1 X203.193 Y202.321
G1 X199.569 Y204.406
G1 X199.429 Y204.496
G1 X199.296 Y204.595
G1 X199.171 Y204.702
G1 X199.052 Y204.818
G1 X198.942 Y204.943
G1 X198.841 Y205.074
G1 X198.75 Y205.212
G1 X198.668 Y205.356
G1 X198.661 Y205.369
G1 X199.017 Y205.54
G1 Z2.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2829
M204 S500
G1 X199.027 Y205.515 E.00083
G1 X199.319 Y205.107 E.01541
G1 X199.747 Y204.757 E.01698
G1 X200.254 Y204.537 E.01699
G1 X200.934 Y204.469 E.021
G1 X201.472 Y204.582 E.0169
G1 X201.969 Y204.844 E.01726
G1 X202.335 Y205.186 E.0154
G1 X202.614 Y205.623 E.01594
G1 X202.767 Y206.101 E.01541
G1 X202.793 Y206.653 E.01699
G1 X202.668 Y207.192 E.01699
G1 X202.4 Y207.676 E.01699
G1 X202.011 Y208.068 E.01699
G1 X201.529 Y208.34 E.01699
G1 X200.992 Y208.47 E.01699
G1 X200.439 Y208.448 E.01699
G1 X199.914 Y208.277 E.01698
G1 X199.455 Y207.969 E.01699
G1 X199.097 Y207.547 E.017
G1 X198.859 Y207.01 E.01805
G1 X198.785 Y206.496 E.01596
G1 X198.842 Y205.999 E.01536
G1 X198.996 Y205.596 E.01325
; WIPE_START
G1 F3600
M204 S1000
G1 X199.027 Y205.515 E-.03311
G1 X199.319 Y205.107 E-.19062
G1 X199.747 Y204.757 E-.21005
G1 X200.254 Y204.537 E-.21014
G1 X200.558 Y204.506 E-.11608
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.528 Y204.086 Z3.1 F30000
G1 X200.508 Y204.088
G1 X200.34 Y204.114
G1 X200.179 Y204.151
G1 X200.02 Y204.199
G1 X199.865 Y204.258
G1 X199.714 Y204.327
G1 X199.569 Y204.406
G1 X199.429 Y204.496
G1 X199.296 Y204.595
G1 X199.171 Y204.702
G1 X199.052 Y204.818
G1 X198.942 Y204.943
G1 X198.841 Y205.074
G1 X198.75 Y205.212
G1 X198.668 Y205.356
G1 X198.612 Y205.471
G1 X198.536 Y205.655
G1 X198.484 Y205.817
G1 X198.453 Y205.941
G1 X198.416 Y206.136
G1 X198.398 Y206.306
G1 X198.393 Y206.471
G1 X198.398 Y206.637
G1 X198.416 Y206.802
G1 X198.444 Y206.965
G1 X198.454 Y207.005
G1 X198.007 Y207.115
G1 Z2.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.55716
G1 F2829
M204 S1000
G1 X197.99 Y206.859 E.01076
; LINE_WIDTH: 0.52302
G1 X197.973 Y206.603 E.01005
; LINE_WIDTH: 0.53364
G1 X197.996 Y205.947 E.02625
; WIPE_START
G1 F6000
G1 X197.973 Y206.603 E-.42634
G1 X197.99 Y206.859 E-.16683
G1 X198.007 Y207.115 E-.16683
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X197.543 Y207.115 Z3.1 F30000
G1 X197.758 Y210.071
G1 X203.193 Y209.857
G1 X203.193 Y208.106
G1 X203.335 Y206.152
G1 X203.317 Y205.959
G1 X203.164 Y205.973
G1 Z2.7
G1 E.8 F1800
; LINE_WIDTH: 0.50028
G1 F2829
M204 S1000
G1 X203.187 Y206.64 E.02484
; LINE_WIDTH: 0.4624
G1 X203.183 Y206.761 E.00417
G1 E-.8 F1800
M204 S10000
G1 X201.913 Y202.943 Z3.1 F30000
G1 Z2.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.572711
G1 F2829
M204 S1000
G1 X201.947 Y202.574 E.016
G1 X202.057 Y202.359 E.01042
G1 X201.419 Y202.346 E.02753
; LINE_WIDTH: 0.544545
G2 X200.006 Y202.353 I-.634 J15.158 E.05781
; LINE_WIDTH: 0.54209
G1 X199.743 Y202.328 E.0107
; LINE_WIDTH: 0.49325
G1 X199.481 Y202.304 E.00966
; LINE_WIDTH: 0.422615
G2 X198.755 Y202.28 I-.494 J3.887 E.02253
G1 X198.754 Y203.505 E.03791
G1 X199.182 Y203.253 E.01534
; LINE_WIDTH: 0.43899
G1 X199.443 Y203.138 E.00923
; LINE_WIDTH: 0.47699
G1 X199.705 Y203.022 E.01012
; LINE_WIDTH: 0.51499
G1 X199.966 Y202.906 E.01101
; LINE_WIDTH: 0.547221
G1 X200.028 Y202.875 E.00282
G1 X200.929 Y202.817 E.03711
; LINE_WIDTH: 0.54047
G1 X201.262 Y202.853 E.01357
; LINE_WIDTH: 0.572193
G3 X201.854 Y202.933 I-.368 J4.945 E.02578
M204 S10000
G1 X199.254 Y202.685 F30000
; LINE_WIDTH: 0.59568
G1 F2829
M204 S1000
G2 X199.259 Y202.797 I-.03 J.057 E.01225
; CHANGE_LAYER
; Z_HEIGHT: 2.9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X199.185 Y202.804 E-.20008
G1 X199.15 Y202.745 E-.18664
G1 X199.185 Y202.685 E-.18665
G1 X199.254 Y202.685 E-.18663
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 48/58
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.1 I-.111 J1.212 P1  F30000
G1 X203.193 Y203.047 Z3.1
G1 X211.432 Y203.805
G1 Z2.9
G1 E.8 F1800
; FEATURE: Support transition
; LINE_WIDTH: 0.42
G1 F1500
M204 S1000
G1 X211.432 Y203.61 E.00598
G1 X211.705 Y203.61 E.0084
G1 X211.705 Y203.72 E.00338
G1 X211.432 Y203.993 E.01187
G1 X211.432 Y204.951 E.02942
G1 X211.705 Y204.677 E.01187
G1 X211.705 Y205.635 E.02942
G1 X211.432 Y205.908 E.01187
G1 X211.432 Y206.865 E.02942
G1 X211.705 Y206.592 E.01187
G3 X211.443 Y207.287 I-.547 J.19 E.02474
G1 X211.432 Y207.054 E.00717
; WIPE_START
G1 X211.443 Y207.287 E-.08861
G1 X211.679 Y207.024 E-.1341
G1 X211.705 Y206.592 E-.16423
G1 X211.432 Y206.865 E-.14676
G1 X211.432 Y206.27 E-.2263
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.3 I.766 J-.945 P1  F30000
G1 X205.668 Y201.596 Z3.3
G1 X205.508 Y201.746
G1 Z2.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.48732
G1 F2454
M204 S1000
G1 X205.396 Y201.894 E.0067
G1 X203.872 Y201.894 E.05518
G1 X203.872 Y201.449 E.01609
G1 X205.29 Y201.449 E.05135
G2 X205.469 Y201.701 I1.679 J-1.002 E.01119
M204 S10000
G1 X205.894 Y201.997 F30000
; LINE_WIDTH: 0.44999
G1 F2454
M204 S1000
G1 X205.785 Y202.07 E.00437
G1 X205.687 Y202.319 E.00887
G2 X203.732 Y202.323 I-.796 J90.93 E.06485
G1 X203.447 Y202.174 E.01067
G1 X203.447 Y201.023 E.03818
G1 X205.622 Y201.023 E.07215
G1 X205.73 Y201.338 E.01105
G1 X205.878 Y201.509 E.00748
G1 X206.05 Y201.546 E.00583
; LINE_WIDTH: 0.410045
G1 X206.222 Y201.583 E.00526
; LINE_WIDTH: 0.3701
G1 X207.568 Y201.583 E.03589
; LINE_WIDTH: 0.36954
G1 X207.731 Y201.583 E.00435
G1 X207.731 Y201.746 E.00435
G1 X207.731 Y201.91 E.00434
; object ids of layer 48 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer48 end: 399
M625
G1 X207.568 Y201.91 E.00434
; LINE_WIDTH: 0.3701
G1 X206.222 Y201.911 E.03589
; LINE_WIDTH: 0.39888
G1 X206.096 Y201.928 E.00368
; LINE_WIDTH: 0.42766
G1 X205.97 Y201.946 E.00398
; LINE_WIDTH: 0.44999
G1 X205.944 Y201.964 E.00106
M204 S250
G1 X206.119 Y202.292 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2454
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.772 Y202.711 E.06949
G1 X203.642 Y202.763 E.00428
G1 X203.583 Y202.9 E.00458
G1 X203.58 Y208.9 E.18436
G3 X203.552 Y210.009 I-15.383 J.17 E.03412
G1 X203.438 Y210.236 E.0078
G1 X203.264 Y210.378 E.00689
G1 X202.979 Y210.461 E.00914
G1 X198.979 Y210.458 E.12291
G3 X197.605 Y210.43 I-.193 J-24.101 E.04222
G1 X197.378 Y210.316 E.0078
G1 X197.236 Y210.142 E.00689
G1 X197.153 Y209.857 E.00914
G1 X197.157 Y201.33 E.26201
G3 X197.472 Y200.764 I.646 J-.01 E.02084
G1 X197.758 Y200.681 E.00914
G1 X202.815 Y200.681 E.15538
G1 X202.899 Y200.631 E.003
G1 X206.033 Y200.631 E.09631
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.083 Y201.231 E.0572
G1 X208.083 Y201.746 E.01582
G1 X208.083 Y202.261 E.01582
G1 X206.222 Y202.261 E.0572
G1 X206.176 Y202.275 E.00145
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.086
G1 X206.033 Y202.711 E-.09936
G1 X204.521 Y202.711 E-.57464
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.521 Y202.321 Z3.3 F30000
G1 X203.193 Y202.321
G1 X199.569 Y204.406
G1 X199.429 Y204.496
G1 X199.296 Y204.595
G1 X199.171 Y204.702
G1 X199.052 Y204.818
G1 X198.943 Y204.942
G1 X198.841 Y205.074
G1 X198.75 Y205.212
G1 X198.668 Y205.356
G1 X198.662 Y205.368
G1 X199.018 Y205.54
G1 Z2.9
G1 E.8 F1800
G1 F2454
M204 S500
G1 X199.319 Y205.107 E.0162
G1 X199.747 Y204.757 E.01698
G1 X200.254 Y204.537 E.01699
G1 X200.802 Y204.463 E.01699
G1 X201.282 Y204.524 E.01487
G1 X201.78 Y204.722 E.01646
G1 X202.182 Y205.021 E.01542
G1 X202.534 Y205.47 E.01752
G1 X202.737 Y205.966 E.01647
G1 X202.801 Y206.515 E.01697
G1 X202.713 Y207.06 E.01698
G1 X202.48 Y207.562 E.017
G1 X202.118 Y207.98 E.01699
G1 X201.657 Y208.285 E.01699
G1 X201.129 Y208.451 E.01699
G1 X200.577 Y208.468 E.01699
G1 X200.04 Y208.333 E.01699
G1 X199.561 Y208.058 E.01699
G1 X199.175 Y207.662 E.01699
G1 X198.912 Y207.175 E.01699
G1 X198.791 Y206.636 E.01699
G1 X198.823 Y206.084 E.01699
G1 X198.992 Y205.593 E.01594
; WIPE_START
G1 F3600
M204 S1000
G1 X199.319 Y205.107 E-.22266
G1 X199.747 Y204.757 E-.21004
G1 X200.254 Y204.537 E-.21013
G1 X200.56 Y204.496 E-.11717
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X200.527 Y204.086 Z3.3 F30000
G1 X200.688 Y204.074
G1 X200.835 Y204.071
G1 X201 Y204.08
G1 X201.167 Y204.1
G1 X201.346 Y204.136
G1 X201.487 Y204.173
G1 X201.644 Y204.227
G1 X201.797 Y204.291
G1 X201.945 Y204.365
G1 X202.088 Y204.45
G1 X202.224 Y204.544
G1 X202.354 Y204.647
G1 X202.476 Y204.759
G1 X202.59 Y204.88
G1 X202.695 Y205.007
G1 X202.793 Y205.144
G1 X202.856 Y205.318
G1 X202.901 Y205.456
G1 X202.943 Y205.613
G1 X202.977 Y205.77
G1 X203.004 Y205.927
G1 X203.023 Y206.083
G1 X203.225 Y206.064
G1 Z2.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.48934
G1 F2454
M204 S1000
G3 X203.197 Y206.016 I-.052 J-.002 E.00982
G1 E-.8 F1800
M204 S10000
G1 X202.76 Y200.889 Z3.3 F30000
G1 Z2.9
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2454
M204 S2000
G1 X203.224 Y201.353 E.02016
G1 X203.224 Y201.886
G1 X202.227 Y200.889 E.04333
G1 X201.694 Y200.889
G1 X203.471 Y202.666 E.07723
G1 X203.379 Y203.107
G1 X201.161 Y200.889 E.09639
G1 X200.627 Y200.889
G1 X203.378 Y203.639 E.11952
G1 X203.377 Y204.172
G1 X200.094 Y200.889 E.14265
G1 X199.561 Y200.889
G1 X203.376 Y204.704 E.16579
G1 X203.375 Y205.236
G1 X199.028 Y200.889 E.18892
G1 X198.494 Y200.889
G1 X203.352 Y205.747 E.2111
G1 E-.8 F1800
M204 S10000
G1 X201.437 Y204.364 Z3.3 F30000
G1 Z2.9
G1 E.8 F1800
G1 F2454
M204 S2000
G1 X197.961 Y200.889 E.15104
G1 X197.515 Y200.976
G1 X200.803 Y204.264 E.14288
G1 X200.32 Y204.314
G1 X197.364 Y201.358 E.12844
G1 X197.364 Y201.891
G1 X199.926 Y204.453 E.11133
G1 X199.572 Y204.633
G1 X197.364 Y202.424 E.09597
G1 X197.364 Y202.957
G1 X199.282 Y204.876 E.08336
G1 X199.033 Y205.16
G1 X197.363 Y203.491 E.07254
G1 X197.363 Y204.024
G1 X198.816 Y205.477 E.06316
G1 X198.673 Y205.866
G1 X197.363 Y204.557 E.05692
G1 X197.363 Y205.09
G1 X198.598 Y206.325 E.0537
G1 X198.639 Y206.899
G1 X197.362 Y205.623 E.05547
G1 X197.362 Y206.156
G1 X199.303 Y208.097 E.08434
; WIPE_START
G1 F2700
M204 S1000
G1 X197.889 Y206.682 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X198.398 Y206.637 Z3.3 F30000
G1 X198.414 Y206.783
G1 X198.443 Y206.963
G1 X198.484 Y207.126
G1 X198.534 Y207.284
G1 X198.589 Y207.42
G1 X198.666 Y207.585
G1 X198.75 Y207.731
G1 X198.841 Y207.869
G1 X198.931 Y207.985
G1 X199.051 Y208.122
G1 X199.171 Y208.24
G1 X199.296 Y208.348
G1 X199.429 Y208.447
G1 X199.569 Y208.536
G1 X199.714 Y208.616
G1 X199.865 Y208.685
G1 X200.02 Y208.744
G1 X200.179 Y208.792
G1 X200.34 Y208.829
G1 X200.504 Y208.854
G1 X200.669 Y208.869
G1 X200.835 Y208.871
G1 X201 Y208.863
G1 X201.165 Y208.843
G1 X201.327 Y208.812
G1 X201.487 Y208.769
G1 X201.626 Y208.722
G1 X201.795 Y208.653
G1 X201.945 Y208.577
G1 X202.071 Y208.502
G1 X202.222 Y208.4
G1 X202.354 Y208.295
G1 X202.476 Y208.183
G1 X202.59 Y208.063
G1 X202.695 Y207.935
G1 X202.792 Y207.801
G1 X202.851 Y207.644
G1 X202.901 Y207.486
G1 X202.943 Y207.329
G1 X202.977 Y207.172
G1 X203.001 Y207.034
G1 X203.023 Y206.862
G1 X203.036 Y206.705
G1 X203.043 Y206.549
G1 X203.043 Y206.535
G1 X203.074 Y206.535
G1 Z2.9
G1 E.8 F1800
G1 F2454
M204 S2000
G1 X203.374 Y206.835 E.013
G1 X203.373 Y207.368
G1 X202.938 Y206.932 E.01892
G1 X202.815 Y207.343
G1 X203.373 Y207.901 E.02424
G1 X203.373 Y208.434
G1 X202.632 Y207.693 E.03217
G1 X202.388 Y207.982
G1 X203.373 Y208.967 E.04277
G1 X203.372 Y209.499
G1 X202.11 Y208.238 E.05483
G1 X201.779 Y208.439
G1 X203.339 Y209.999 E.06778
G1 X203.048 Y210.241
G1 X201.389 Y208.582 E.07209
G1 X200.942 Y208.669
G1 X202.527 Y210.254 E.06885
G1 X201.993 Y210.253
G1 X200.365 Y208.626 E.07073
G1 X199.397 Y208.19
G1 X201.459 Y210.253 E.08962
G1 X200.926 Y210.253
G1 X197.362 Y206.689 E.15487
G1 X197.362 Y207.222
G1 X200.392 Y210.252 E.13169
G1 X199.858 Y210.252
G1 X197.361 Y207.755 E.10851
G1 X197.361 Y208.288
G1 X199.325 Y210.251 E.08533
G1 X198.791 Y210.251
G1 X197.361 Y208.821 E.06215
G1 X197.361 Y209.354
G1 X198.258 Y210.251 E.03897
M204 S10000
G1 X197.825 Y210.269 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.329306
G1 F2454
M204 S1000
G3 X197.342 Y209.737 I1.096 J-1.479 E.01688
G1 E-.8 F1800
M204 S10000
G1 X198.707 Y207.209 Z3.3 F30000
G1 Z2.9
G1 E.8 F1800
; LINE_WIDTH: 0.0964298
G1 F2454
M204 S1000
G3 X198.567 Y206.971 I3.001 J-1.928 E.0012
; WIPE_START
G1 F3600
G1 X198.707 Y207.209 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X198.529 Y207.266 Z3.3 F30000
G1 X198.484 Y207.126
G1 X198.443 Y206.963
G1 X198.414 Y206.783
G1 X198.398 Y206.637
G1 X198.393 Y206.471
G1 X198.398 Y206.303
G1 X198.419 Y206.122
G1 X198.444 Y205.978
G1 X198.484 Y205.817
G1 X198.534 Y205.659
G1 X198.596 Y205.505
G1 X198.668 Y205.356
G1 X198.75 Y205.212
G1 X198.841 Y205.074
G1 X198.943 Y204.942
G1 X199.052 Y204.818
G1 X199.171 Y204.702
G1 X199.296 Y204.595
G1 X199.429 Y204.496
G1 X199.569 Y204.406
G1 X199.715 Y204.327
G1 X199.865 Y204.258
G1 X200.02 Y204.199
G1 X200.179 Y204.151
G1 X200.34 Y204.114
G1 X200.506 Y204.088
G1 X200.688 Y204.074
G1 X200.835 Y204.071
G1 X201 Y204.08
G1 X201.011 Y204.081
G1 X200.998 Y204.192
G1 Z2.9
G1 E.8 F1800
; LINE_WIDTH: 0.110545
G1 F2454
M204 S1000
G1 X200.793 Y204.275 E.00122
; CHANGE_LAYER
; Z_HEIGHT: 3.1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3600
G1 X200.998 Y204.192 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 49/58
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.3 I.021 J1.217 P1  F30000
G1 X210.342 Y204.031 Z3.3
G1 X210.633 Y204.446
G1 X210.641 Y204
G1 X211.412 Y204.013
G1 Z3.1
G1 E.8 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
G1 F4800
M204 S1000
G1 X211.705 Y203.76 E.01189
G1 X211.705 Y204.677 E.02819
G1 X211.582 Y204.801 E.00536
G1 X211.582 Y205.758 E.02942
G1 X211.705 Y205.635 E.00536
G1 X211.705 Y206.592 E.02942
G1 X211.412 Y206.885 E.01273
; WIPE_START
G1 X211.705 Y206.592 E-.15742
G1 X211.705 Y205.635 E-.36386
G1 X211.582 Y205.758 E-.06623
G1 X211.582 Y205.304 E-.1725
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.5 I1.046 J-.622 P1  F30000
G1 X210.622 Y203.69 Z3.5
G1 X209.372 Y201.347
G1 X209.287 Y201.389
G1 X209.464 Y201.742
G1 Z3.1
G1 E.8 F1800
; FEATURE: Overhang wall
; LINE_WIDTH: 0.44999
G1 F1500
M204 S500
G2 X210.016 Y201.385 I-1.116 J-2.329 E.02186
G1 X210.498 Y200.846 E.02399
G2 X210.824 Y200.165 I-2.205 J-1.475 E.02514
G1 X210.866 Y199.911 E.00856
; LINE_WIDTH: 0.424075
G1 F600
G1 X210.908 Y199.656 E.00801
G1 F1500
G1 X210.895 Y199.914 E.00801
; LINE_WIDTH: 0.44999

G1 X210.883 Y202.241 E.07721
G2 X210.468 Y202.382 I.022 J.748 E.01475
G1 X210.373 Y202.491 E.00481
G2 X210.045 Y202.132 I-1.31 J.868 E.0162
G1 X209.514 Y201.776 E.02122
M204 S250
G1 X210.413 Y201.679 F30000
; LINE_WIDTH: 0.6521
G1 F600
M204 S500
G2 X210.451 Y201.745 I-.033 J.063 E.01829
; WIPE_START
M204 S1000
G1 X210.413 Y201.811 E-.152
G1 X210.337 Y201.811 E-.152
G1 X210.299 Y201.745 E-.152
G1 X210.337 Y201.679 E-.152
G1 X210.413 Y201.679 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.5 I-1.216 J-.034 P1  F30000
G1 X210.34 Y204.268 Z3.5
G1 X210.331 Y204.414
G1 X210.315 Y204.561
G1 X210.293 Y204.708
G1 X210.263 Y204.856
G1 X210.226 Y205.004
G1 X210.181 Y205.152
G1 X210.128 Y205.301
G1 X210.066 Y205.449
G1 X209.994 Y205.595
G1 X209.884 Y205.713
G1 X209.767 Y205.822
G1 X209.642 Y205.923
G1 X209.51 Y206.015
G1 X209.372 Y206.097
G1 X209.228 Y206.168
G1 X209.08 Y206.23
G1 X208.927 Y206.281
G1 X208.771 Y206.32
G1 X208.613 Y206.349
G1 X208.454 Y206.366
G1 X208.304 Y206.371
G1 X207.082 Y206.371
G1 X207.082 Y206.406
G1 Z3.1
G1 E.8 F1800
; LINE_WIDTH: 0.51847
G1 F1500
M204 S500
G1 X207.32 Y206.406 E.00923
; LINE_WIDTH: 0.5202

G1 X208.414 Y206.404 E.04254
G1 X208.543 Y206.39 E.00507
; LINE_WIDTH: 0.51977

G1 X208.849 Y206.294 E.01247
; LINE_WIDTH: 0.48488

G1 X209.155 Y206.197 E.01156
; LINE_WIDTH: 0.44999
G1 F600
G1 X209.616 Y205.943 E.01743
G1 X210.042 Y205.534 E.01961
G1 X210.369 Y204.984 E.02123
G1 X210.441 Y204.762 E.00773
G1 F1500
G1 X210.441 Y206.919 E.07153
G1 X209.071 Y206.917 E.04543
; LINE_WIDTH: 0.485095

G1 X208.743 Y206.899 E.01187
; LINE_WIDTH: 0.5202

G2 X207.32 Y206.881 I-.878 J13.121 E.05536
; LINE_WIDTH: 0.51847

G1 X207.095 Y206.87 E.00874
G1 X207.083 Y206.466 E.01564
G1 E-.8 F1800
M204 S10000
G17
G3 Z3.5 I.064 J1.215 P1  F30000
G1 X209.95 Y206.315 Z3.5
G1 Z3.1
G1 E.8 F1800
; LINE_WIDTH: 0.6992
G1 F600
M204 S500
G2 X209.991 Y206.386 I-.036 J.068 E.02123
; WIPE_START
M204 S1000
G1 X209.95 Y206.458 E-.15201
G1 X209.868 Y206.458 E-.152
G1 X209.827 Y206.386 E-.152
G1 X209.868 Y206.315 E-.15201
G1 X209.95 Y206.315 E-.15198
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.5 I0 J1.217 P1  F30000
G1 X210.443 Y206.315 Z3.5
G1 X210.34 Y203.975
G1 X210.331 Y203.828
G1 X210.315 Y203.682
G1 X210.293 Y203.534
G1 X210.263 Y203.387
G1 X210.226 Y203.239
G1 X210.181 Y203.09
G1 X210.128 Y202.942
G1 X210.067 Y202.793
G1 X209.994 Y202.648
G1 X209.884 Y202.53
G1 X209.767 Y202.421
G1 X209.642 Y202.32
G1 X209.51 Y202.228
G1 X209.372 Y202.146
G1 X209.228 Y202.074
G1 X209.08 Y202.013
G1 X208.927 Y201.962
G1 X208.771 Y201.922
G1 X208.612 Y201.906
G1 X208.452 Y201.898
G1 X208.303 Y201.896
G1 X205.668 Y201.896
G1 X205.656 Y201.021
G1 X205.668 Y201.596
G1 X205.521 Y201.746
G1 Z3.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.48732
G1 F6000
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F6000
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00238
; WIPE_START
G1 X205.828 Y202.038 E-.04632
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.5904
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.321 Z3.5 F30000
G1 X205.668 Y201.596
G1 X208.303 Y201.596
G1 X208.452 Y201.595
G1 X208.612 Y201.587
G1 X208.771 Y201.57
G1 X208.927 Y201.531
G1 X209.08 Y201.48
G1 X209.228 Y201.418
G1 X209.372 Y201.347
G1 X209.51 Y201.265
G1 X209.642 Y201.173
G1 X209.767 Y201.072
G1 X209.886 Y200.961
G1 X210.002 Y200.835
G1 X210.095 Y200.72
G1 X210.186 Y200.588
G1 X210.268 Y200.45
G1 X210.34 Y200.306
G1 X210.402 Y200.158
G1 X210.452 Y200.005
G1 X210.492 Y199.85
G1 X210.521 Y199.692
G1 X210.538 Y199.53
G1 X210.543 Y199.359
G1 X210.538 Y199.211
G1 X210.521 Y199.051
G1 X210.492 Y198.893
G1 X210.452 Y198.737
G1 X210.402 Y198.585
G1 X210.38 Y198.533
G1 X210.81 Y198.355
G1 Z3.1
G1 E.8 F1800
; FEATURE: Overhang wall
; LINE_WIDTH: 0.59215
G1 F600
M204 S500
G1 X210.608 Y197.936 E.02085
G1 X210.317 Y197.547 E.02175
G1 X209.794 Y197.106 E.03061
G1 X210.809 Y197.106 E.04544
G1 X210.81 Y198.295 E.05325
; WIPE_START
M204 S1000
G1 X210.608 Y197.936 E-.15677
G1 X210.317 Y197.547 E-.18463
G1 X209.794 Y197.106 E-.25994
G1 X210.211 Y197.106 E-.15866
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.5 I1.217 J0 P1  F30000
G1 X210.211 Y196.622 Z3.5
G1 X211.293 Y202.63
G1 X208.927 Y201.962
G1 X208.771 Y201.922
G1 X208.612 Y201.906
G1 X208.452 Y201.898
G1 X208.452 Y201.898
G1 X208.46 Y201.75
G1 Z3.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.71542
G1 F3000
M204 S1000
G1 X208.46 Y201.75 E.00002
; LINE_WIDTH: 0.71185
G1 X208.464 Y201.748 E.00026
; LINE_WIDTH: 0.6667
G1 X208.468 Y201.745 E.00024
; LINE_WIDTH: 0.62155
G1 X208.472 Y201.743 E.00022
; LINE_WIDTH: 0.5764
G1 X208.477 Y201.741 E.00021
; LINE_WIDTH: 0.53125
G1 X208.481 Y201.738 E.00019
; LINE_WIDTH: 0.4861
G1 X208.485 Y201.736 E.00017
; LINE_WIDTH: 0.44095
G1 X208.489 Y201.734 E.00015
; LINE_WIDTH: 0.395795
G1 F1535.279
G1 X208.493 Y201.731 E.00014
; FEATURE: Overhang wall
; LINE_WIDTH: 0.397115
G1 F1500
M204 S500
G1 X208.545 Y201.702 E.00173
; LINE_WIDTH: 0.44359

G1 X208.597 Y201.673 E.00195
; LINE_WIDTH: 0.490065

G1 X208.649 Y201.643 E.00218
; LINE_WIDTH: 0.53654

G3 X208.974 Y201.506 I.672 J1.132 E.01422
; LINE_WIDTH: 0.493265

G1 X209.246 Y201.397 E.01075
; LINE_WIDTH: 0.44999

G1 X209.728 Y201.097 E.01882
G1 X210.141 Y200.651 E.02016
G1 X210.427 Y200.079 E.02123
G1 X210.539 Y199.449 E.02122
G1 X210.47 Y198.813 E.02122
G1 X210.225 Y198.222 E.02122
G1 X209.823 Y197.725 E.02122
G1 X209.297 Y197.36 E.02122
; LINE_WIDTH: 0.481955

G1 X209.006 Y197.245 E.01122
; LINE_WIDTH: 0.51392

G1 X208.714 Y197.129 E.01204
G1 X208.294 Y197.098 E.01618
; LINE_WIDTH: 0.4924

G1 X207.069 Y197.098 E.04487
G1 X207.083 Y196.668 E.01576
G1 X207.294 Y196.649 E.00778
; LINE_WIDTH: 0.51392

G1 X208.739 Y196.659 E.05546
G1 X209.084 Y196.643 E.01326
; LINE_WIDTH: 0.481955

G1 X209.429 Y196.627 E.01236
; LINE_WIDTH: 0.44999
G1 F600
G3 X211.254 Y196.641 I.552 J48.479 E.06051
G1 X211.287 Y196.715 E.00268
G1 F1500
G1 X211.291 Y202.619 E.19587
G1 X211.022 Y202.619 E.00892
G1 X210.696 Y202.719 E.01128
G1 X210.499 Y202.946 E.00998
G1 X210.449 Y203.104 E.00548
G1 X210.456 Y203.569 E.01543
G1 X210.225 Y202.972 E.02121
G1 X209.871 Y202.514 E.0192
G1 X209.442 Y202.19 E.01784
G1 X208.966 Y201.987 E.01716
; LINE_WIDTH: 0.49731

G1 X208.887 Y201.95 E.00322
; LINE_WIDTH: 0.54463

G1 X208.808 Y201.913 E.00356
; object ids of layer 49 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer49 end: 399
M625
; LINE_WIDTH: 0.59195

G1 X208.73 Y201.876 E.00389
; LINE_WIDTH: 0.63927

G1 X208.651 Y201.84 E.00423
; LINE_WIDTH: 0.68659

G1 X208.572 Y201.803 E.00456
; LINE_WIDTH: 0.73391
G1 F600
G1 X208.514 Y201.776 E.0036
; WIPE_START
M204 S1000
G1 X208.46 Y201.75 E-.02272
G1 X208.464 Y201.748 E-.00181
G1 X208.468 Y201.745 E-.00181
G1 X208.472 Y201.743 E-.00181
G1 X208.477 Y201.741 E-.00181
G1 X208.481 Y201.738 E-.00181
G1 X208.485 Y201.736 E-.00181
G1 X208.489 Y201.734 E-.00181
G1 X208.493 Y201.731 E-.00181
G1 X208.545 Y201.702 E-.02272
G1 X208.597 Y201.673 E-.02272
G1 X208.649 Y201.643 E-.02272
G1 X208.974 Y201.506 E-.13391
G1 X209.246 Y201.397 E-.11136
G1 X209.728 Y201.097 E-.21564
G1 X210.074 Y200.723 E-.19371
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.5 I-.764 J.947 P1  F30000
G1 X210.085 Y200.732 Z3.5
G1 X210.002 Y200.835
G1 X209.886 Y200.961
G1 X209.767 Y201.072
G1 X209.642 Y201.173
G1 X209.51 Y201.265
G1 X209.372 Y201.347
G1 X209.228 Y201.418
G1 X209.08 Y201.48
G1 X208.927 Y201.531
G1 X208.771 Y201.57
G1 X205.668 Y201.896
G1 X206.119 Y201.896
G1 X206.119 Y202.292
G1 Z3.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X206.445 Y201.231 E.00685
G1 X206.668 Y201.23 E.00685
G1 X206.891 Y201.23 E.00685
G1 X207.114 Y201.23 E.00685
G1 X207.337 Y201.229 E.00685
G1 F3450
G1 X207.56 Y201.229 E.00685
G1 F3300
G1 X207.783 Y201.228 E.00685
G1 F3150
G1 X208.006 Y201.228 E.00685
G1 F3600
G1 X208.222 Y201.227 E.00665
G1 F2531.092
G1 X208.246 Y201.227 E.00072
G1 F2311.101
G1 X208.27 Y201.227 E.00072
G1 F2101.109
G1 X208.293 Y201.227 E.00072
G1 F1901.117
G1 X208.317 Y201.227 E.00072
G1 F1711.202
G1 X208.34 Y201.227 E.00072
G1 F1531.204
G1 X208.364 Y201.227 E.00072
G1 F1361.207
G1 X208.387 Y201.227 E.00072
G1 F1201.275
G1 X208.411 Y201.227 E.00072
G1 F1051.273
G1 X208.437 Y201.224 E.00079
G1 F899.29
G1 X208.465 Y201.218 E.00089
G1 F742.126
G1 X208.493 Y201.212 E.00089
; FEATURE: Overhang wall
G1 F600
G1 X208.917 Y201.122 E.01332
G1 X209.385 Y200.875 E.01626
G1 X209.764 Y200.506 E.01625
G1 X210.025 Y200.046 E.01626
G1 X210.146 Y199.523 E.01649
G1 X210.114 Y199.003 E.01602
G1 X209.937 Y198.504 E.01625
G1 X209.625 Y198.075 E.01631
G1 X209.207 Y197.753 E.0162
G1 X208.714 Y197.561 E.01625
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.24 E.01234
G1 X211.2 Y196.235 E.12737
G1 X211.475 Y196.303 E.00869
G1 X211.612 Y196.44 E.00596
G1 X211.679 Y196.714 E.00868

G1 X211.683 Y203.011 E.19349
G1 X211.022 Y203.011 E.02032
G1 X210.916 Y203.044 E.00339
G1 X210.833 Y203.2 E.00543
G1 X210.833 Y207.311 E.12632
G1 X207.137 Y207.307 E.11358
G1 X206.862 Y207.24 E.0087
G3 X206.657 Y206.909 I.241 J-.378 E.01236
G1 X206.654 Y205.981 E.02853
G1 X208.413 Y205.977 E.05404
G1 X208.917 Y205.872 E.01584
G1 X209.399 Y205.617 E.01675
G1 X209.764 Y205.256 E.01576
G1 X210.025 Y204.796 E.01626
G1 X210.146 Y204.273 E.01649
G1 X210.114 Y203.753 E.01602
G1 X209.937 Y203.254 E.01625
G1 X209.626 Y202.826 E.01625
G1 X209.207 Y202.503 E.01625
G1 X208.714 Y202.311 E.01626
G1 X208.493 Y202.285 E.00684
; FEATURE: Outer wall
G1 F722.711
G1 X208.468 Y202.282 E.00077
G1 F856.831
G1 X208.443 Y202.279 E.00077
G1 F1002.426
G1 X208.418 Y202.276 E.00077
G1 F1159.368
G1 X208.393 Y202.273 E.00077
G1 F1327.727
G1 X208.368 Y202.27 E.00077
G1 F1507.561
G1 X208.343 Y202.267 E.00077
G1 F1698.744
G1 X208.318 Y202.264 E.00077
G1 F1924.538
G1 X208.29 Y202.261 E.00086
G1 F3558.683
G1 X208.124 Y202.261 E.00511
G1 F3600
G1 X207.958 Y202.261 E.00511
G1 X207.791 Y202.261 E.00511
G1 X207.625 Y202.261 E.00511
G1 X207.458 Y202.261 E.00511
G1 X207.292 Y202.261 E.00511
G1 X207.126 Y202.261 E.00511
G1 X206.959 Y202.261 E.00511
G1 X206.793 Y202.261 E.00511
G1 X206.626 Y202.261 E.00511
G1 X206.46 Y202.261 E.00511
G1 X206.294 Y202.261 E.00511
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.321 Z3.5 F30000
G1 X205.668 Y201.596
G1 X208.303 Y201.596
G1 X208.452 Y201.595
G1 X208.612 Y201.587
G1 X208.771 Y201.57
G1 X208.927 Y201.531
G1 X209.08 Y201.48
G1 X209.228 Y201.418
G1 X209.372 Y201.347
G1 X209.51 Y201.265
G1 X209.642 Y201.173
G1 X209.767 Y201.072
G1 X209.886 Y200.961
G1 X210.002 Y200.835
G1 X210.095 Y200.72
G1 X210.186 Y200.588
G1 X210.268 Y200.45
G1 X210.34 Y200.306
G1 X210.402 Y200.158
G1 X210.452 Y200.005
G1 X210.492 Y199.85
G1 X210.521 Y199.692
G1 X210.538 Y199.53
G1 X210.543 Y199.359
G1 X210.538 Y199.211
G1 X210.521 Y199.051
G1 X210.514 Y199.016
G1 X210.897 Y198.947
G1 Z3.1
G1 E.8 F1800
; FEATURE: Overhang wall
; LINE_WIDTH: 0.4198
G1 F1500
M204 S500
G1 X210.908 Y199.656 E.02179
G1 E-.8 F1800
M204 S10000
G17
G3 Z3.5 I-1.21 J-.129 P1  F30000
G1 X210.473 Y203.727 Z3.5
G1 Z3.1
G1 E.8 F1800
; LINE_WIDTH: 0.38546
M73 P98 R1
G1 F1500
M204 S500
G1 X210.487 Y204.333 E.01692
; WIPE_START
M204 S1000
G1 X210.473 Y203.727 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.5 I.079 J1.214 P1  F30000
G1 X210.623 Y203.717 Z3.5
G1 X209.994 Y202.648
G1 X209.884 Y202.53
G1 X209.767 Y202.421
G1 X209.642 Y202.32
G1 X209.51 Y202.228
G1 X209.372 Y202.146
G1 X209.228 Y202.074
G1 X209.08 Y202.013
G1 X208.927 Y201.962
G1 X208.771 Y201.922
G1 X208.612 Y201.906
G1 X208.452 Y201.898
G1 X208.303 Y201.896
G1 X206.223 Y201.896
G1 X206.223 Y201.746
G1 Z3.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.70122
G1 F6000
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X206.388 Y201.746 E.01225
; LINE_WIDTH: 0.70108
G1 X206.617 Y201.746 E.01224
; LINE_WIDTH: 0.70093
G1 X206.845 Y201.746 E.01224
; LINE_WIDTH: 0.70079
G1 X207.073 Y201.745 E.01224
; LINE_WIDTH: 0.70064
G1 X207.302 Y201.745 E.01224
; LINE_WIDTH: 0.70049
G1 F5250
G1 X207.53 Y201.745 E.01223
; LINE_WIDTH: 0.70035
G1 F4500
G1 X207.758 Y201.745 E.01223
; LINE_WIDTH: 0.7002
G1 F3750
G1 X207.986 Y201.745 E.01223
; LINE_WIDTH: 0.70006
G1 F6000
G1 X208.16 Y201.744 E.0093
; LINE_WIDTH: 0.69994
G1 X208.17 Y201.744 E.00053
G1 X208.211 Y201.744 E.0022
; LINE_WIDTH: 0.69991
G1 X208.252 Y201.744 E.0022
; LINE_WIDTH: 0.69989
G1 X208.293 Y201.744 E.0022
; LINE_WIDTH: 0.69987
G1 X208.294 Y201.744 E.00003
; LINE_WIDTH: 0.70375
G1 X208.335 Y201.746 E.00224
; LINE_WIDTH: 0.70769
G1 X208.377 Y201.747 E.00228
; LINE_WIDTH: 0.71163
G1 X208.419 Y201.749 E.00229
; LINE_WIDTH: 0.71542
G1 X208.46 Y201.75 E.00221
; CHANGE_LAYER
; Z_HEIGHT: 3.3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X208.419 Y201.749 E-.01535
G1 X208.377 Y201.747 E-.01599
G1 X208.335 Y201.746 E-.01598
G1 X208.294 Y201.744 E-.0158
G1 X208.293 Y201.744 E-.00018
G1 X208.252 Y201.744 E-.0156
G1 X208.211 Y201.744 E-.0156
G1 X208.17 Y201.744 E-.01561
G1 X208.16 Y201.744 E-.00373
G1 X207.986 Y201.745 E-.06599
G1 X207.758 Y201.745 E-.08675
G1 X207.53 Y201.745 E-.08675
G1 X207.302 Y201.745 E-.08675
G1 X207.073 Y201.745 E-.08675
G1 X206.845 Y201.746 E-.08675
G1 X206.617 Y201.746 E-.08675
G1 X206.46 Y201.746 E-.05966
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 50/58
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.5 I1.217 J0 P1  F30000
G1 X206.46 Y201.596 Z3.5
G1 X208.303 Y201.596
G1 X210.571 Y202.749
G1 X210.61 Y203.521
G1 X210.612 Y203.551
G1 X211.874 Y204.1
G1 Z3.3
G1 E.8 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
G1 F1436
M204 S1000
G1 X211.582 Y203.807 E.01272
G1 X211.582 Y204.765 E.02942
G1 X211.705 Y204.888 E.00535
G1 X211.705 Y205.845 E.02942
G1 X211.582 Y205.722 E.00535
G1 X211.582 Y206.68 E.02942
G1 X211.867 Y206.965 E.01238
; WIPE_START
G1 F4800
G1 X211.582 Y206.68 E-.15314
G1 X211.582 Y205.722 E-.36386
G1 X211.705 Y205.845 E-.06618
G1 X211.705 Y205.38 E-.17683
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.7 I1.036 J-.638 P1  F30000
G1 X210.616 Y203.613 Z3.7
G1 X209.372 Y201.347
G1 X209.287 Y201.389
G1 X209.464 Y201.742
G1 Z3.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F1436
M204 S1000
G2 X210.016 Y201.385 I-1.117 J-2.331 E.02186
G1 X210.498 Y200.846 E.02399
G2 X210.824 Y200.165 I-2.205 J-1.475 E.02514
G1 X210.866 Y199.911 E.00856
; LINE_WIDTH: 0.424075
G1 X210.908 Y199.656 E.00801
G1 X210.895 Y199.914 E.00801
; LINE_WIDTH: 0.44999
G1 X210.883 Y202.241 E.07721
G2 X210.469 Y202.382 I.022 J.747 E.01474
G1 X210.373 Y202.491 E.00482
G2 X210.045 Y202.132 I-1.31 J.869 E.0162
G1 X209.514 Y201.776 E.02123
M204 S10000
G1 X210.451 Y201.745 F30000
; LINE_WIDTH: 0.65208
G1 F1436
M204 S1000
G3 X210.413 Y201.679 I-.071 J-.003 E.01829
; WIPE_START
G1 F6000
G1 X210.337 Y201.679 E-.152
G1 X210.299 Y201.745 E-.152
G1 X210.337 Y201.811 E-.152
G1 X210.413 Y201.811 E-.152
G1 X210.451 Y201.745 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.7 I-1.216 J-.053 P1  F30000
G1 X210.341 Y204.266 Z3.7
G1 X210.331 Y204.414
G1 X210.315 Y204.561
G1 X210.292 Y204.709
G1 X210.263 Y204.856
G1 X210.226 Y205.004
G1 X210.188 Y205.128
G1 X210.13 Y205.298
G1 X210.066 Y205.449
G1 X209.994 Y205.595
G1 X209.884 Y205.713
G1 X209.767 Y205.822
G1 X209.642 Y205.923
G1 X209.51 Y206.015
G1 X209.372 Y206.097
G1 X209.228 Y206.168
G1 X209.08 Y206.23
G1 X208.927 Y206.281
G1 X208.795 Y206.314
G1 X208.617 Y206.349
G1 X208.454 Y206.366
G1 X208.304 Y206.371
G1 X207.082 Y206.371
G1 X207.082 Y206.406
G1 Z3.3
G1 E.8 F1800
; LINE_WIDTH: 0.51847
G1 F1436
M204 S1000
G1 X207.32 Y206.406 E.00923
; LINE_WIDTH: 0.5202
G1 X208.414 Y206.404 E.04255
G1 X208.543 Y206.39 E.00507
; LINE_WIDTH: 0.51977
G1 X208.849 Y206.294 E.01247
; LINE_WIDTH: 0.48488
G1 X209.155 Y206.197 E.01156
; LINE_WIDTH: 0.44999
G1 X209.616 Y205.943 E.01743
G1 X210.042 Y205.534 E.01961
G1 X210.369 Y204.984 E.02123
G1 X210.441 Y204.762 E.00773
G1 X210.441 Y206.919 E.07153
G1 X209.071 Y206.917 E.04543
; LINE_WIDTH: 0.485095
G1 X208.743 Y206.899 E.01187
; LINE_WIDTH: 0.5202
G2 X207.32 Y206.881 I-.878 J13.122 E.05536
; LINE_WIDTH: 0.51847
G1 X207.095 Y206.87 E.00874
G1 X207.083 Y206.466 E.01564
G1 E-.8 F1800
M204 S10000
G17
G3 Z3.7 I.033 J1.217 P1  F30000
G1 X209.991 Y206.386 Z3.7
G1 Z3.3
G1 E.8 F1800
; LINE_WIDTH: 0.6992
G1 F1436
M204 S1000
G3 X209.95 Y206.315 I-.077 J-.003 E.02123
; WIPE_START
G1 F6000
G1 X209.868 Y206.315 E-.15198
G1 X209.827 Y206.386 E-.15201
G1 X209.868 Y206.458 E-.152
G1 X209.95 Y206.458 E-.152
G1 X209.991 Y206.386 E-.15201
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.7 I0 J1.217 P1  F30000
G1 X210.443 Y206.386 Z3.7
G1 X210.34 Y203.975
G1 X210.331 Y203.826
G1 X210.312 Y203.658
G1 X210.293 Y203.534
G1 X210.263 Y203.387
G1 X210.226 Y203.239
G1 X210.181 Y203.09
G1 X210.128 Y202.942
G1 X210.067 Y202.793
G1 X209.994 Y202.648
G1 X209.882 Y202.528
G1 X209.748 Y202.405
G1 X209.642 Y202.32
G1 X209.51 Y202.228
G1 X209.372 Y202.146
G1 X209.228 Y202.074
G1 X209.08 Y202.013
G1 X208.927 Y201.962
G1 X208.771 Y201.922
G1 X208.612 Y201.906
G1 X208.452 Y201.898
G1 X208.303 Y201.896
G1 X205.668 Y201.896
G1 X205.521 Y201.746
G1 Z3.3
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1436
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1436
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.321 Z3.7 F30000
G1 X205.668 Y201.596
G1 X208.303 Y201.596
G1 X208.452 Y201.595
G1 X208.612 Y201.587
G1 X208.771 Y201.57
G1 X208.927 Y201.531
G1 X209.08 Y201.48
G1 X209.228 Y201.418
G1 X209.372 Y201.347
G1 X209.51 Y201.265
G1 X209.642 Y201.173
G1 X209.767 Y201.072
G1 X209.885 Y200.963
G1 X209.994 Y200.845
G1 X210.095 Y200.72
G1 X210.186 Y200.588
G1 X210.268 Y200.45
G1 X210.34 Y200.306
G1 X210.402 Y200.158
G1 X210.452 Y200.005
G1 X210.492 Y199.85
G1 X210.521 Y199.692
G1 X210.538 Y199.532
G1 X210.544 Y199.371
G1 X210.538 Y199.211
G1 X210.521 Y199.051
G1 X210.492 Y198.893
G1 X210.452 Y198.737
G1 X210.402 Y198.585
G1 X210.34 Y198.436
G1 X210.268 Y198.293
G1 X210.186 Y198.155
G1 X210.095 Y198.023
G1 X209.994 Y197.898
G1 X209.882 Y197.778
G1 X209.748 Y197.655
G1 X209.642 Y197.57
G1 X209.527 Y197.49
G1 X209.794 Y197.106
G1 Z3.3
G1 E.8 F1800
; LINE_WIDTH: 0.59216
G1 F1436
M204 S1000
G1 X210.809 Y197.106 E.04544
G1 X210.81 Y198.355 E.05594
G1 X210.608 Y197.936 E.02086
G1 X210.316 Y197.547 E.02174
G1 X209.84 Y197.144 E.02793
; WIPE_START
G1 F6000
G1 X210.809 Y197.106 E-.36871
G1 X210.81 Y198.135 E-.39129
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.7 I0 J1.217 P1  F30000
G1 X211.293 Y198.135 Z3.7
G1 X209.51 Y202.228
G1 X209.372 Y202.146
G1 X209.228 Y202.074
G1 X209.08 Y202.013
G1 X208.927 Y201.962
G1 X208.771 Y201.922
G1 X208.612 Y201.906
G1 X208.452 Y201.898
G1 X208.452 Y201.898
G1 X208.46 Y201.75
G1 Z3.3
G1 E.8 F1800
; LINE_WIDTH: 0.71542
G1 F1436
M204 S1000
G1 X208.52 Y201.716 E.0038
; LINE_WIDTH: 0.670695
G1 X208.581 Y201.682 E.00355
; LINE_WIDTH: 0.62597
G1 X208.641 Y201.648 E.0033
; LINE_WIDTH: 0.581245
G1 X208.702 Y201.614 E.00305
; LINE_WIDTH: 0.53652
G1 X208.974 Y201.506 E.01178
; LINE_WIDTH: 0.493255
G1 X209.246 Y201.398 E.01075
; LINE_WIDTH: 0.44999
G1 X209.728 Y201.097 E.01883
G1 X210.141 Y200.651 E.02016
G1 X210.427 Y200.079 E.02123
G1 X210.539 Y199.449 E.02122
G1 X210.47 Y198.813 E.02122
G1 X210.225 Y198.222 E.02123
G1 X209.823 Y197.724 E.02122
G1 X209.297 Y197.36 E.02122
; LINE_WIDTH: 0.48196
G1 X209.006 Y197.245 E.01122
; LINE_WIDTH: 0.51393
G1 X208.714 Y197.129 E.01204
G1 X208.294 Y197.098 E.01618
; LINE_WIDTH: 0.4924
G1 X207.069 Y197.098 E.04487
G1 X207.083 Y196.668 E.01577
G1 X207.294 Y196.649 E.00777
; LINE_WIDTH: 0.51393
G1 X208.739 Y196.659 E.05546
G1 X209.084 Y196.643 E.01326
; LINE_WIDTH: 0.48196
G1 X209.429 Y196.627 E.01236
; LINE_WIDTH: 0.44999
G3 X211.254 Y196.641 I.553 J48.461 E.06052
G1 X211.287 Y196.715 E.00268
G1 X211.291 Y202.619 E.19587
G1 X211.022 Y202.619 E.00892
G1 X210.697 Y202.719 E.01128
G1 X210.5 Y202.946 E.00998
G2 X210.456 Y203.451 I.84 J.327 E.01704
; LINE_WIDTH: 0.420535
G1 X210.471 Y203.702 E.00773
; LINE_WIDTH: 0.41447
G1 X210.447 Y203.546 E.00477
; LINE_WIDTH: 0.44999
G1 X210.225 Y202.972 E.02041
G1 X209.871 Y202.514 E.0192
G1 X209.442 Y202.19 E.01784
G1 X208.966 Y201.987 E.01716
; LINE_WIDTH: 0.494229
G1 X208.882 Y201.947 E.00343
; LINE_WIDTH: 0.538467
G1 X208.797 Y201.908 E.00376
; LINE_WIDTH: 0.582705
G1 X208.713 Y201.869 E.0041
; LINE_WIDTH: 0.626944
G1 X208.628 Y201.829 E.00443
; LINE_WIDTH: 0.671182
G1 X208.544 Y201.79 E.00477
; LINE_WIDTH: 0.71542
G1 X208.514 Y201.776 E.00182
; WIPE_START
G1 F6000
G1 X208.52 Y201.716 E-.02271
G1 X208.581 Y201.682 E-.02638
G1 X208.641 Y201.648 E-.02638
G1 X208.702 Y201.614 E-.02639
G1 X208.974 Y201.506 E-.11133
G1 X209.246 Y201.398 E-.11133
G1 X209.728 Y201.097 E-.21568
G1 X210.121 Y200.673 E-.21979
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.7 I-.694 J1 P1  F30000
G1 X210.125 Y200.676 Z3.7
G1 X210.095 Y200.72
G1 X209.994 Y200.845
G1 X209.885 Y200.963
G1 X209.767 Y201.072
G1 X209.642 Y201.173
G1 X209.51 Y201.265
G1 X209.372 Y201.347
G1 X209.228 Y201.418
G1 X209.08 Y201.48
G1 X208.927 Y201.531
G1 X208.771 Y201.57
G1 X205.668 Y201.896
G1 X206.119 Y201.896
G1 X206.119 Y202.292
G1 Z3.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1436
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.425 Y201.227 E.06769
G1 X208.917 Y201.122 E.01547
G1 X209.385 Y200.875 E.01626
G1 X209.764 Y200.506 E.01625
G1 X210.025 Y200.046 E.01626
G1 X210.146 Y199.523 E.01649
G1 X210.114 Y199.003 E.01602
G1 X209.937 Y198.504 E.01625
G1 X209.625 Y198.075 E.01631
G1 X209.207 Y197.753 E.01619
G1 X208.714 Y197.561 E.01625
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.24 E.01234
G1 X211.055 Y196.235 E.12291
G3 X211.474 Y196.303 I.073 J.887 E.01319
G1 X211.612 Y196.44 E.00596
G1 X211.679 Y196.714 E.00868
G1 X211.683 Y203.011 E.19349
G1 X211.022 Y203.011 E.02032
G1 X210.916 Y203.044 E.00339
G1 X210.833 Y203.2 E.00543
G1 X210.833 Y207.311 E.12632
; object ids of layer 50 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer50 end: 399
M625
G1 X207.137 Y207.307 E.11358
G1 X206.862 Y207.24 E.0087
G3 X206.657 Y206.909 I.241 J-.378 E.01236
G1 X206.654 Y205.981 E.02853
G1 X208.452 Y205.973 E.05526
G1 X208.968 Y205.853 E.01625
G1 X209.428 Y205.593 E.01626
G1 X209.797 Y205.213 E.01625
G1 X210.043 Y204.745 E.01626
G1 X210.149 Y204.24 E.01585
G1 X210.109 Y203.73 E.01572
G1 X209.936 Y203.253 E.01558
G1 X209.626 Y202.826 E.01622
G1 X209.207 Y202.503 E.01625
G1 X208.714 Y202.311 E.01625
G1 X208.294 Y202.261 E.01302
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.321 Z3.7 F30000
G1 X205.668 Y201.596
G1 X208.303 Y201.596
G1 X208.452 Y201.595
G1 X208.612 Y201.587
G1 X208.771 Y201.57
G1 X208.927 Y201.531
G1 X209.08 Y201.48
G1 X209.228 Y201.418
G1 X209.372 Y201.347
G1 X209.51 Y201.265
G1 X209.642 Y201.173
G1 X209.767 Y201.072
G1 X209.885 Y200.963
G1 X209.994 Y200.845
G1 X210.095 Y200.72
G1 X210.186 Y200.588
G1 X210.268 Y200.45
G1 X210.34 Y200.306
G1 X210.402 Y200.158
G1 X210.452 Y200.005
G1 X210.492 Y199.85
G1 X210.521 Y199.692
G1 X210.529 Y199.615
G1 X210.908 Y199.656
G1 Z3.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.41984
G1 F1436
M204 S1000
G1 X210.897 Y198.947 E.0218
G1 E-.8 F1800
M204 S10000
G17
G3 Z3.7 I-1.213 J-.092 P1  F30000
G1 X210.487 Y204.333 Z3.7
G1 Z3.3
G1 E.8 F1800
; LINE_WIDTH: 0.39108
G1 F1436
M204 S1000
G1 X210.471 Y203.702 E.01791
; WIPE_START
G1 F6000
G1 X210.487 Y204.333 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.7 I-.021 J1.217 P1  F30000
G1 X210.635 Y204.335 Z3.7
G1 X210.128 Y202.942
G1 X210.067 Y202.793
G1 X209.994 Y202.648
G1 X209.882 Y202.528
G1 X209.748 Y202.405
G1 X209.642 Y202.32
G1 X209.51 Y202.228
G1 X209.372 Y202.146
G1 X209.228 Y202.074
G1 X209.08 Y202.013
G1 X208.927 Y201.962
G1 X208.771 Y201.922
G1 X208.612 Y201.906
G1 X208.452 Y201.898
G1 X208.452 Y201.898
G1 X208.46 Y201.75
G1 Z3.3
G1 E.8 F1800
; LINE_WIDTH: 0.71542
G1 F1436
M204 S1000
G1 X208.294 Y201.744 E.0091
; LINE_WIDTH: 0.69994
G1 X208.16 Y201.744 E.00715
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.10729
G1 X206.223 Y201.746 E.00337
; CHANGE_LAYER
; Z_HEIGHT: 3.5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X206.16 Y201.746 E-.02391
G1 X208.097 Y201.745 E-.73609
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 51/58
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.7 I.001 J1.217 P1  F30000
G1 X209.462 Y201.743 Z3.7
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1360
M204 S1000
G2 X210.016 Y201.385 I-1.295 J-2.609 E.02191
G1 X210.498 Y200.846 E.02399
G2 X210.824 Y200.165 I-2.205 J-1.475 E.02514
G1 X210.866 Y199.911 E.00856
; LINE_WIDTH: 0.424075
G1 X210.908 Y199.656 E.00801
G1 X210.895 Y199.914 E.00801
; LINE_WIDTH: 0.44999
G1 X210.883 Y202.241 E.07721
G2 X210.468 Y202.382 I.022 J.747 E.01475
G1 X210.373 Y202.491 E.00482
G1 X210.05 Y202.136 E.01595
G1 X209.512 Y201.777 E.02144
M204 S10000
G1 X210.451 Y201.745 F30000
; LINE_WIDTH: 0.6521
G1 F1360
M204 S1000
G3 X210.413 Y201.679 I-.071 J-.003 E.01829
; WIPE_START
G1 F6000
G1 X210.337 Y201.679 E-.152
G1 X210.299 Y201.745 E-.152
G1 X210.337 Y201.811 E-.152
G1 X210.413 Y201.811 E-.152
G1 X210.451 Y201.745 E-.152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.9 I-1.216 J-.055 P1  F30000
G1 X210.338 Y204.268 Z3.9
G1 X210.328 Y204.414
G1 X210.312 Y204.561
G1 X210.29 Y204.708
G1 X210.261 Y204.855
G1 X210.224 Y205.003
G1 X210.189 Y205.115
G1 X210.128 Y205.296
G1 X210.064 Y205.447
G1 X209.993 Y205.594
G1 X209.892 Y205.72
G1 X209.774 Y205.83
G1 X209.648 Y205.931
G1 X209.516 Y206.024
G1 X209.377 Y206.106
G1 X209.232 Y206.178
G1 X209.083 Y206.24
G1 X208.93 Y206.291
G1 X208.774 Y206.331
G1 X208.615 Y206.359
G1 X208.454 Y206.377
G1 X208.304 Y206.382
G1 X207.082 Y206.382
G1 X207.082 Y206.406
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.51847
G1 F1360
M204 S1000
G1 X207.32 Y206.406 E.00923
; LINE_WIDTH: 0.5202
G1 X208.414 Y206.404 E.04255
G1 X208.543 Y206.39 E.00507
; LINE_WIDTH: 0.51976
G1 X208.849 Y206.293 E.01247
; LINE_WIDTH: 0.484875
G1 X209.155 Y206.197 E.01156
; LINE_WIDTH: 0.44999
G1 X209.616 Y205.943 E.01743
G1 X210.042 Y205.534 E.01961
G1 X210.369 Y204.984 E.02122
G1 X210.441 Y204.762 E.00773
G1 X210.441 Y206.919 E.07153
G1 X209.072 Y206.917 E.04543
; LINE_WIDTH: 0.485095
G1 X208.743 Y206.899 E.01187
; LINE_WIDTH: 0.5202
G2 X207.32 Y206.881 I-.878 J13.123 E.05537
; LINE_WIDTH: 0.51847
G1 X207.095 Y206.87 E.00874
G1 X207.083 Y206.466 E.01564
G1 E-.8 F1800
M204 S10000
G17
G3 Z3.9 I.033 J1.217 P1  F30000
G1 X209.991 Y206.386 Z3.9
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.69922
G1 F1360
M204 S1000
G3 X209.95 Y206.315 I-.077 J-.003 E.02123
; WIPE_START
G1 F6000
G1 X209.868 Y206.315 E-.15198
G1 X209.827 Y206.386 E-.15201
G1 X209.868 Y206.458 E-.152
G1 X209.95 Y206.458 E-.152
G1 X209.991 Y206.386 E-.15201
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.9 I0 J1.217 P1  F30000
G1 X210.432 Y206.386 Z3.9
G1 X210.338 Y203.975
G1 X210.328 Y203.826
G1 X210.308 Y203.647
G1 X210.29 Y203.535
G1 X210.26 Y203.388
G1 X210.224 Y203.24
G1 X210.179 Y203.092
G1 X210.126 Y202.943
G1 X210.065 Y202.795
G1 X209.997 Y202.645
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.512 Y202.217
G1 X209.344 Y202.12
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X205.671 Y201.899
G1 X205.652 Y201.032
G1 X205.671 Y201.594
G1 X205.521 Y201.746
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1360
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1360
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.311 Z3.9 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.28 Y200.451
G1 X210.364 Y200.277
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.05
G1 X210.503 Y198.891
G1 X210.463 Y198.734
G1 X210.412 Y198.581
G1 X210.35 Y198.432
G1 X210.278 Y198.288
G1 X210.195 Y198.149
G1 X210.103 Y198.016
G1 X210.002 Y197.891
G1 X209.892 Y197.772
G1 X209.774 Y197.663
G1 X209.648 Y197.561
G1 X209.533 Y197.481
G1 X209.794 Y197.106
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.59215
G1 F1360
M204 S1000
G1 X210.809 Y197.106 E.04544
G1 X210.81 Y198.355 E.05594
G1 X210.608 Y197.936 E.02085
G1 X210.317 Y197.547 E.02174
G1 X209.84 Y197.144 E.02793
; WIPE_START
G1 F6000
G1 X210.809 Y197.106 E-.36873
G1 X210.81 Y198.135 E-.39127
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.9 I0 J1.217 P1  F30000
G1 X211.282 Y198.135 Z3.9
G1 X209.648 Y202.311
G1 X209.512 Y202.217
G1 X209.344 Y202.12
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.452 Y201.901
G1 X208.46 Y201.75
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.71542
G1 F1360
M204 S1000
G1 X208.52 Y201.716 E.0038
; LINE_WIDTH: 0.670703
G1 X208.581 Y201.682 E.00355
; LINE_WIDTH: 0.625985
G1 X208.641 Y201.648 E.0033
; LINE_WIDTH: 0.581268
G1 X208.702 Y201.614 E.00305
; LINE_WIDTH: 0.53655
G1 X208.957 Y201.515 E.01103
; LINE_WIDTH: 0.49327
G1 X209.213 Y201.416 E.01006
; LINE_WIDTH: 0.44999
G1 X209.728 Y201.097 E.02008
G1 X210.141 Y200.651 E.02017
G1 X210.427 Y200.079 E.02123
G1 X210.539 Y199.449 E.02122
G1 X210.47 Y198.813 E.02122
G1 X210.225 Y198.222 E.02122
G1 X209.823 Y197.725 E.02122
G1 X209.297 Y197.36 E.02123
; LINE_WIDTH: 0.481955
G1 X209.005 Y197.245 E.01122
; LINE_WIDTH: 0.51392
G1 X208.714 Y197.129 E.01204
G1 X208.294 Y197.098 E.01618
; LINE_WIDTH: 0.4924
G1 X207.069 Y197.098 E.04487
G1 X207.083 Y196.668 E.01576
G1 X207.294 Y196.649 E.00778
; LINE_WIDTH: 0.51392
G1 X208.739 Y196.659 E.05546
G1 X209.084 Y196.643 E.01325
; LINE_WIDTH: 0.481955
G1 X209.429 Y196.627 E.01236
; LINE_WIDTH: 0.44999
G3 X211.254 Y196.641 I.552 J48.453 E.06052
G1 X211.287 Y196.715 E.00268
G1 X211.291 Y202.619 E.19587
G1 X211.022 Y202.619 E.00892
G1 X210.696 Y202.719 E.01128
G1 X210.499 Y202.946 E.00997
G1 X210.45 Y203.099 E.00533
G1 X210.459 Y203.394 E.00979
; LINE_WIDTH: 0.421955
G1 X210.469 Y203.689 E.00912
; LINE_WIDTH: 0.41618
G1 X210.445 Y203.534 E.00478
; LINE_WIDTH: 0.44999
G1 X210.225 Y202.972 E.02
G1 X209.824 Y202.476 E.02116
G1 X209.408 Y202.171 E.01711
G1 X208.968 Y201.987 E.01582
; LINE_WIDTH: 0.494229
G1 X208.883 Y201.947 E.00344
; LINE_WIDTH: 0.538467
G1 X208.799 Y201.908 E.00377
; LINE_WIDTH: 0.582705
G1 X208.714 Y201.868 E.00411
; LINE_WIDTH: 0.626944
G1 X208.629 Y201.829 E.00445
; LINE_WIDTH: 0.671182
G1 X208.544 Y201.79 E.00478
; LINE_WIDTH: 0.71542
G1 X208.514 Y201.776 E.00183
; WIPE_START
G1 F6000
G1 X208.52 Y201.716 E-.02267
G1 X208.581 Y201.682 E-.02638
G1 X208.641 Y201.648 E-.02638
G1 X208.702 Y201.614 E-.02638
G1 X208.957 Y201.515 E-.10419
G1 X209.213 Y201.416 E-.10419
G1 X209.728 Y201.097 E-.23006
G1 X210.121 Y200.673 E-.21976
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.9 I-.694 J1 P1  F30000
G1 X210.134 Y200.682 Z3.9
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.119 Y201.899
G1 X206.119 Y202.292
G1 Z3.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1360
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.425 Y201.227 E.06769
G1 X208.917 Y201.122 E.01547
G1 X209.385 Y200.875 E.01626
G1 X209.765 Y200.506 E.01625
G1 X210.025 Y200.046 E.01625
G1 X210.146 Y199.523 E.01649
G1 X210.114 Y199.003 E.01602
G1 X209.937 Y198.504 E.01625
G1 X209.625 Y198.075 E.0163
G1 X209.207 Y197.753 E.0162
G1 X208.714 Y197.561 E.01625
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.24 E.01235
G1 X211.055 Y196.235 E.12291
G3 X211.475 Y196.303 I.073 J.887 E.01319
G1 X211.612 Y196.44 E.00596
G1 X211.679 Y196.714 E.00868
G1 X211.683 Y203.011 E.19348
G1 X211.022 Y203.011 E.02032
G1 X210.916 Y203.044 E.00339
G1 X210.833 Y203.2 E.00543
G1 X210.833 Y207.311 E.12632
; object ids of layer 51 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer51 end: 399
M625
G1 X207.137 Y207.307 E.11358
G1 X206.862 Y207.24 E.0087
G3 X206.657 Y206.909 I.241 J-.378 E.01236
G1 X206.654 Y205.981 E.02853
G1 X208.413 Y205.977 E.05404
G1 X208.968 Y205.853 E.01747
G1 X209.428 Y205.593 E.01626
G1 X209.797 Y205.213 E.01625
G1 X210.043 Y204.745 E.01626
G1 X210.148 Y204.225 E.01632
G1 X210.106 Y203.719 E.01559
G1 X209.911 Y203.207 E.01683
G1 X209.588 Y202.789 E.01623
G1 X209.177 Y202.488 E.01568
G1 X208.713 Y202.311 E.01525
G1 X208.294 Y202.261 E.01297
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.311 Z3.9 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.28 Y200.451
G1 X210.364 Y200.277
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.539 Y199.616
G1 X210.908 Y199.656
G1 Z3.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.41982
G1 F1360
M204 S1000
G1 X210.897 Y198.947 E.02179
G1 E-.8 F1800
M204 S10000
G17
G3 Z3.9 I-1.213 J-.092 P1  F30000
G1 X210.487 Y204.333 Z3.9
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.39392
G1 F1360
M204 S1000
G1 X210.469 Y203.689 E.01842
; WIPE_START
G1 F6000
G1 X210.487 Y204.333 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.9 I-.021 J1.217 P1  F30000
G1 X210.638 Y204.336 Z3.9
G1 X210.126 Y202.943
G1 X210.065 Y202.795
G1 X209.997 Y202.645
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.512 Y202.217
G1 X209.344 Y202.12
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X206.223 Y201.899
G1 X206.223 Y201.746
G1 Z3.5
G1 E.8 F1800
; LINE_WIDTH: 0.70122
G1 F1360
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X208.16 Y201.744 E.10729
; LINE_WIDTH: 0.69994
G1 X208.294 Y201.744 E.00715
; LINE_WIDTH: 0.71542
G1 X208.46 Y201.75 E.0091
; CHANGE_LAYER
; Z_HEIGHT: 3.7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X208.294 Y201.744 E-.06314
G1 X208.16 Y201.744 E-.05072
G1 X206.46 Y201.746 E-.64615
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 52/58
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.9 I-.002 J1.217 P1  F30000
G1 X209.461 Y201.75 Z3.9
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1609
M204 S1000
G1 X209.604 Y201.678 E.00533
G2 X210.387 Y201 I-1.781 J-2.847 E.0345
G2 X210.761 Y200.344 I-2.095 J-1.629 E.02512
G1 X210.902 Y199.777 E.01937
G1 X210.882 Y200.361 E.01939
G1 X210.882 Y202.361 E.06634
G2 X210.883 Y203.012 I35.382 J.246 E.0216
; LINE_WIDTH: 0.44651
G1 X210.885 Y203.201 E.00621
; LINE_WIDTH: 0.44302
G1 X210.886 Y203.39 E.00616
; LINE_WIDTH: 0.43953
G1 X210.888 Y203.579 E.0061
; LINE_WIDTH: 0.43604
G1 X210.888 Y203.607 E.00089
G1 X210.884 Y203.591 E.00054
; LINE_WIDTH: 0.43952
G1 X210.853 Y203.48 E.00371
; LINE_WIDTH: 0.44301
G1 X210.822 Y203.37 E.00374
; LINE_WIDTH: 0.4465
G1 X210.792 Y203.259 E.00377
; LINE_WIDTH: 0.44999
G2 X209.515 Y201.776 I-2.407 J.781 E.06666
M204 S10000
G1 X210.447 Y201.746 F30000
; LINE_WIDTH: 0.6607
G1 F1609
M204 S1000
G3 X210.408 Y201.679 I-.072 J-.003 E.01882
G1 E-.8 F1800
M204 S10000
G1 X210.907 Y204.407 Z4.1 F30000
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.423545
G1 F1609
M204 S1000
G1 X210.894 Y204.664 E.00799
; LINE_WIDTH: 0.44999
G2 X210.88 Y205.17 I4.909 J.383 E.01678
G1 X210.88 Y206.509 E.04441
G1 X210.532 Y206.509 E.01153
G1 X210.165 Y206.509 E.01217
G1 X209.798 Y206.51 E.01217
G1 X209.432 Y206.51 E.01217
G1 X209.768 Y206.326 E.01272
G1 X210.261 Y205.89 E.02183
G2 X210.843 Y204.8 I-1.676 J-1.596 E.04148
; LINE_WIDTH: 0.43804
G1 X210.862 Y204.686 E.00375
; LINE_WIDTH: 0.42609
G1 X210.88 Y204.571 E.00363
; LINE_WIDTH: 0.41414
G1 X210.897 Y204.466 E.0032
G1 E-.8 F1800
M204 S10000
G1 X210.557 Y206.146 Z4.1 F30000
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.36098
G1 F1609
M204 S1000
G1 X210.537 Y206.181 E.00103
G1 X210.478 Y206.146 E.00178
G1 X210.537 Y206.112 E.00178
; WIPE_START
G1 F6000
G1 X210.478 Y206.146 E-.29487
G1 X210.537 Y206.181 E-.29487
G1 X210.557 Y206.146 E-.17025
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y206.146 Z4.1 F30000
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X205.671 Y201.899
G1 X205.652 Y201.032
G1 X205.671 Y201.594
G1 X205.521 Y201.746
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1609
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1609
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.311 Z4.1 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.521 Y201.271
G1 X209.686 Y201.151
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.006 Y200.848
G1 X210.131 Y200.686
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.044
G1 X210.491 Y198.844
G1 X210.463 Y198.734
G1 X210.412 Y198.581
G1 X210.35 Y198.432
G1 X210.278 Y198.288
G1 X210.192 Y198.144
G1 X210.073 Y197.978
G1 X210.002 Y197.891
G1 X209.892 Y197.773
G1 X209.77 Y197.659
G1 X209.608 Y197.533
G1 X209.531 Y197.48
G1 X209.792 Y197.103
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.59146
G1 F1609
M204 S1000
G1 X210.813 Y197.102 E.04563
G1 X210.813 Y198.343 E.05547
G1 X210.447 Y197.705 E.03287
G1 X210.249 Y197.477 E.01347
G1 X209.839 Y197.141 E.02372
; WIPE_START
G1 F6000
G1 X210.813 Y197.102 E-.37056
G1 X210.813 Y198.126 E-.38945
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y198.126 Z4.1 F30000
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.131 Y200.686
G1 X210.006 Y200.848
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.686 Y201.151
G1 X209.521 Y201.271
G1 X209.377 Y201.356
G1 X208.303 Y201.899
G1 X208.433 Y201.9
G1 X208.434 Y201.751
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.71332
G1 F1609
M204 S1000
G1 X208.501 Y201.716 E.0041
; LINE_WIDTH: 0.669432
G1 X208.567 Y201.681 E.00383
; LINE_WIDTH: 0.625544
G1 X208.633 Y201.646 E.00356
; LINE_WIDTH: 0.581655
G1 X208.7 Y201.611 E.00329
; LINE_WIDTH: 0.537767
G1 X208.766 Y201.576 E.00302
; LINE_WIDTH: 0.493879
G1 X208.833 Y201.541 E.00276
; LINE_WIDTH: 0.44999
G1 X209.137 Y201.457 E.01049
G1 X209.577 Y201.216 E.01664
G1 X210.045 Y200.78 E.02122
G1 X210.371 Y200.229 E.02122
G1 X210.528 Y199.609 E.02122
G1 X210.505 Y198.97 E.02123
G1 X210.302 Y198.363 E.02121
G1 X209.937 Y197.838 E.02123
G1 X209.438 Y197.437 E.02123
; LINE_WIDTH: 0.490775
G1 X209.145 Y197.295 E.01187
; LINE_WIDTH: 0.53156
G1 X208.853 Y197.153 E.01295
G1 X208.294 Y197.098 E.02237
; LINE_WIDTH: 0.49301
G1 X207.069 Y197.098 E.04493
; LINE_WIDTH: 0.49253
G1 X207.083 Y196.668 E.01576
G1 X207.294 Y196.648 E.00777
; LINE_WIDTH: 0.49301
G1 X208.293 Y196.648 E.03665
; LINE_WIDTH: 0.53156
G2 X209.251 Y196.646 I.467 J-5.394 E.03817
; LINE_WIDTH: 0.490775
G1 X209.614 Y196.625 E.01328
; LINE_WIDTH: 0.44999
G3 X211.251 Y196.64 I.495 J34.877 E.05429
G1 X211.291 Y196.707 E.00259
G1 X211.288 Y202.743 E.20022
G1 X211.288 Y202.779 E.00119
G1 X211.288 Y202.815 E.00119
G1 X211.288 Y202.851 E.00119
G1 X211.288 Y202.887 E.00119
G1 X211.288 Y202.923 E.00119
G1 X211.288 Y202.959 E.00119
G1 X211.288 Y202.995 E.00119
G1 X211.288 Y203.031 E.00119
G1 X211.288 Y203.067 E.00119
G1 X211.288 Y203.103 E.00119
G1 X211.288 Y203.139 E.00119
G1 X211.288 Y203.175 E.00119
G1 X211.288 Y203.21 E.00119
G1 X211.288 Y203.246 E.00119
G1 X211.288 Y203.282 E.00119
G1 F1419.188
G1 X211.288 Y203.318 E.00119
G1 F1173.727
G1 X211.288 Y203.354 E.00119
G1 F951.555
G1 X211.288 Y203.39 E.00119
G1 F752.62
G1 X211.288 Y203.421 E.00103
; FEATURE: Overhang wall
G1 F600
M204 S500
G1 X211.287 Y206.845 E.11357
; object ids of layer 52 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer52 end: 399
M625
G1 X211.243 Y206.888 E.00202
; FEATURE: Inner wall
G1 F750.71
M204 S1000
G1 X211.221 Y206.909 E.00102
G1 F1263.732
G1 X211.136 Y206.915 E.00285
G1 F1609
G1 X211.029 Y206.916 E.00354
G1 X210.922 Y206.916 E.00354
G1 X210.815 Y206.916 E.00354
G1 X210.709 Y206.916 E.00354
G1 X210.602 Y206.916 E.00354
G1 X210.495 Y206.916 E.00354
G1 X210.389 Y206.916 E.00354
G1 X210.282 Y206.916 E.00354
G1 X210.175 Y206.916 E.00354
G1 X210.068 Y206.916 E.00354
G1 X209.962 Y206.917 E.00354
G1 X209.855 Y206.917 E.00354
G1 X209.748 Y206.917 E.00354
G1 X209.642 Y206.917 E.00354
G1 X209.535 Y206.917 E.00354
G1 X209.428 Y206.917 E.00354
G1 X209.321 Y206.917 E.00354
G1 X209.072 Y206.917 E.00826
; LINE_WIDTH: 0.48543
G1 X208.743 Y206.9 E.01188
; LINE_WIDTH: 0.52087
G2 X207.319 Y206.884 I-.86 J13.133 E.05549
; LINE_WIDTH: 0.5202
G1 X207.095 Y206.869 E.00873
G1 X207.08 Y206.407 E.01796
G1 X207.318 Y206.407 E.00926
; LINE_WIDTH: 0.52087
G1 X208.414 Y206.405 E.04265
G1 X208.543 Y206.39 E.00508
; LINE_WIDTH: 0.52071
G1 X208.849 Y206.294 E.0125
; LINE_WIDTH: 0.48535
G1 X209.156 Y206.197 E.01158
; LINE_WIDTH: 0.44999
G1 X209.705 Y205.87 E.02122
G1 X210.141 Y205.401 E.02121
G1 X210.427 Y204.829 E.02123
G1 X210.541 Y204.22 E.02056
G1 X210.505 Y203.72 E.01663
G1 X210.302 Y203.113 E.02121
G1 X209.937 Y202.588 E.02123
G1 X209.438 Y202.187 E.02123
G1 X208.967 Y201.974 E.01714
; LINE_WIDTH: 0.493879
G1 X208.878 Y201.936 E.00354
; LINE_WIDTH: 0.537767
G1 X208.789 Y201.899 E.00388
; LINE_WIDTH: 0.581655
G1 X208.701 Y201.862 E.00423
; LINE_WIDTH: 0.625544
G1 X208.612 Y201.825 E.00457
; LINE_WIDTH: 0.669432
G1 X208.523 Y201.788 E.00492
; LINE_WIDTH: 0.71332
G1 X208.489 Y201.774 E.00198
; WIPE_START
G1 F6000
G1 X208.501 Y201.716 E-.02245
G1 X208.567 Y201.681 E-.0285
G1 X208.633 Y201.646 E-.0285
G1 X208.7 Y201.611 E-.0285
G1 X208.766 Y201.576 E-.0285
G1 X208.833 Y201.541 E-.0285
G1 X209.137 Y201.457 E-.12014
G1 X209.577 Y201.216 E-.19061
G1 X210.045 Y200.78 E-.24305
G1 X210.1 Y200.686 E-.04125
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.119 Y200.701 Z4.1 F30000
G1 X210.006 Y200.848
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.686 Y201.151
G1 X209.521 Y201.271
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.119 Y201.899
G1 X206.119 Y202.292
G1 Z3.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1609
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.418 Y201.227 E.06749
G1 X208.917 Y201.122 E.01568
G1 X209.321 Y200.92 E.01386
G1 X209.715 Y200.568 E.01625
G1 X209.994 Y200.119 E.01625
G1 X210.136 Y199.609 E.01625
G1 X210.128 Y199.08 E.01626
G1 X209.972 Y198.575 E.01624
G1 X209.68 Y198.134 E.01625
G1 X209.275 Y197.794 E.01626
G1 X208.791 Y197.581 E.01624
G1 X208.294 Y197.511 E.01543
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.241 E.01235
G1 X209.055 Y196.233 E.06145
G3 X211.313 Y196.252 I.781 J41.653 E.0694
G1 X211.508 Y196.34 E.00655
G1 X211.625 Y196.487 E.00579
G1 X211.683 Y196.707 E.00699
G1 X211.681 Y202.743 E.18546
G1 X211.681 Y202.778 E.0011
G1 X211.68 Y202.814 E.0011
G1 X211.68 Y202.85 E.0011
G1 X211.68 Y202.886 E.0011
G1 X211.68 Y202.921 E.0011
G1 X211.68 Y202.957 E.0011
G1 X211.68 Y202.993 E.0011
G1 X211.68 Y203.028 E.0011
G1 X211.68 Y203.064 E.0011
G1 X211.68 Y203.1 E.0011
G1 X211.68 Y203.136 E.0011
G1 X211.68 Y203.171 E.0011
G1 X211.68 Y203.207 E.0011
G1 X211.68 Y203.243 E.0011
G1 X211.68 Y203.278 E.0011
G1 F1447.706
G1 X211.68 Y203.314 E.0011
G1 F1201.318
G1 X211.68 Y203.35 E.0011
G1 F977.956
G1 X211.68 Y203.386 E.0011
G1 F777.495
G1 X211.68 Y203.421 E.0011
; FEATURE: Overhang wall
G1 F600
G1 X211.679 Y206.829 E.1047
G1 X211.612 Y207.103 E.00866
G3 X211.243 Y207.307 I-.371 J-.234 E.01351
; FEATURE: Outer wall
G1 F1154.758
G1 X211.143 Y207.308 E.00307
G1 F1609
G1 X211.043 Y207.308 E.00307
G1 X210.943 Y207.308 E.00307
G1 X210.843 Y207.308 E.00307
G1 X210.743 Y207.308 E.00307
G1 X210.643 Y207.308 E.00307
G1 X210.543 Y207.308 E.00307
G1 X210.443 Y207.308 E.00307
G1 X210.343 Y207.308 E.00307
G1 X210.243 Y207.308 E.00307
G1 X210.143 Y207.308 E.00307
G1 X210.043 Y207.309 E.00307
G1 X209.943 Y207.309 E.00307
G1 X209.843 Y207.309 E.00307
G1 X209.743 Y207.309 E.00307
G1 X209.643 Y207.309 E.00307
G1 X209.543 Y207.309 E.00307
G1 X209.443 Y207.309 E.00307
G1 X209.343 Y207.309 E.00307
G1 X207.32 Y207.311 E.06218
G1 X206.904 Y207.263 E.01284
G1 X206.753 Y207.143 E.00594
G1 X206.653 Y206.86 E.00921
G1 X206.653 Y205.981 E.02702
G1 X208.413 Y205.977 E.05406
G1 X208.917 Y205.872 E.01584
G1 X209.385 Y205.625 E.01626
G1 X209.764 Y205.256 E.01624
G1 X210.025 Y204.796 E.01626
G1 X210.145 Y204.281 E.01625
G1 X210.128 Y203.83 E.01385
G1 X209.972 Y203.325 E.01624
G1 X209.68 Y202.884 E.01625
G1 X209.275 Y202.544 E.01626
G1 X208.791 Y202.331 E.01624
G1 X208.294 Y202.261 E.01543
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.311 Z4.1 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.521 Y201.271
G1 X209.686 Y201.151
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.006 Y200.848
G1 X210.131 Y200.686
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.044
G1 X210.508 Y198.933
G1 X210.889 Y198.857
G1 Z3.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.4376
G1 F1609
M204 S1000
G1 X210.909 Y199.133 E.00892
; LINE_WIDTH: 0.412
G1 X210.902 Y199.777 E.01937
; WIPE_START
G1 F6000
G1 X210.909 Y199.133 E-.53126
G1 X210.889 Y198.857 E-.22874
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.508 Y198.933 Z4.1 F30000
G1 X210.531 Y199.044
G1 X210.548 Y199.21
G1 X210.554 Y199.371
G1 X210.548 Y199.533
G1 X210.531 Y199.693
G1 X210.503 Y199.852
G1 X210.463 Y200.008
G1 X210.412 Y200.161
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.131 Y200.686
G1 X210.006 Y200.848
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.686 Y201.151
G1 X209.521 Y201.271
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.223 Y201.899
G1 X206.223 Y201.746
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.70122
G1 F1609
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X208.16 Y201.744 E.10729
; LINE_WIDTH: 0.69994
G1 X208.294 Y201.744 E.00715
; LINE_WIDTH: 0.71332
G1 X208.434 Y201.751 E.00768
; WIPE_START
G1 F6000
G1 X208.294 Y201.744 E-.05345
G1 X208.16 Y201.744 E-.05072
G1 X206.434 Y201.746 E-.65583
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X206.434 Y201.594 Z4.1 F30000
G1 X208.772 Y201.921
G1 X208.93 Y201.952
G1 X209.083 Y202.003
G1 X209.232 Y202.065
G1 X209.377 Y202.137
G1 X209.516 Y202.219
G1 X209.648 Y202.311
G1 X209.774 Y202.413
G1 X209.892 Y202.523
G1 X210.002 Y202.641
G1 X210.103 Y202.766
G1 X210.195 Y202.899
G1 X210.278 Y203.038
G1 X210.35 Y203.182
G1 X210.412 Y203.331
G1 X210.463 Y203.484
G1 X210.491 Y203.594
G1 X210.531 Y203.794
G1 X210.548 Y203.96
G1 X210.554 Y204.121
G1 X210.548 Y204.283
G1 X210.539 Y204.367
G1 X210.907 Y204.407
G1 Z3.7
G1 E.8 F1800
; LINE_WIDTH: 0.3971
G1 F1609
M204 S1000
G1 X210.908 Y203.849 E.01611
; LINE_WIDTH: 0.43552
G1 X210.888 Y203.607 E.00776
; CHANGE_LAYER
; Z_HEIGHT: 3.9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X210.908 Y203.849 E-.2303
G1 X210.907 Y204.407 E-.5297
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 53/58
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.1 I1.07 J-.58 P1  F30000
G1 X209.464 Y201.742 Z4.1
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1456
M204 S1000
G2 X210.015 Y201.386 I-1.116 J-2.33 E.02184
G1 X210.498 Y200.846 E.02401
G2 X210.824 Y200.165 I-2.205 J-1.475 E.02514
G1 X210.866 Y199.911 E.00854
; LINE_WIDTH: 0.424655
G1 X210.908 Y199.657 E.00801
G1 X210.895 Y199.914 E.00801
; LINE_WIDTH: 0.44999
G1 X210.882 Y202.172 E.07488
G2 X210.896 Y203.697 I38.113 J.398 E.05059
; LINE_WIDTH: 0.44109
G1 X210.848 Y203.423 E.00903
; LINE_WIDTH: 0.44999
G2 X210.045 Y202.132 I-2.472 J.643 E.05118
G1 X209.514 Y201.776 E.02122
M204 S10000
G1 X210.45 Y201.745 F30000
; LINE_WIDTH: 0.65124
G1 F1456
M204 S1000
G3 X210.412 Y201.679 I-.071 J-.003 E.01824
G1 E-.8 F1800
M204 S10000
G1 X210.907 Y204.407 Z4.3 F30000
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.423715
G1 F1456
M204 S1000
G1 X210.894 Y204.664 E.00799
; LINE_WIDTH: 0.44999
G1 X210.88 Y206.509 E.06118
G1 X209.432 Y206.51 E.04805
G1 X209.768 Y206.326 E.01271
G1 X210.261 Y205.89 E.02185
G2 X210.824 Y204.915 I-2.289 J-1.973 E.03755
G1 X210.866 Y204.661 E.00854
; LINE_WIDTH: 0.423715
G1 X210.898 Y204.466 E.00613
G1 E-.8 F1800
M204 S10000
G1 X210.538 Y206.112 Z4.3 F30000
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.3612
G1 F1456
M204 S1000
G1 X210.478 Y206.146 E.00179
G1 X210.538 Y206.181 E.00179
G1 X210.557 Y206.146 E.00103
; WIPE_START
G1 F6000
G1 X210.538 Y206.181 E-.17025
G1 X210.478 Y206.146 E-.29488
G1 X210.538 Y206.112 E-.29488
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.3 I.829 J-.891 P1  F30000
G1 X209.996 Y205.608 Z4.3
G1 X210.002 Y205.602
G1 X210.103 Y205.476
G1 X210.195 Y205.344
G1 X210.278 Y205.205
G1 X210.35 Y205.061
G1 X210.412 Y204.911
G1 X210.463 Y204.758
G1 X210.503 Y204.602
G1 X210.531 Y204.443
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.8
G1 X210.503 Y203.641
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.412
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X205.671 Y201.899
G1 X205.652 Y201.032
G1 X205.671 Y201.594
G1 X205.521 Y201.746
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1456
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1456
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.311 Z4.3 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.273
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.05
G1 X210.503 Y198.891
G1 X210.463 Y198.734
G1 X210.412 Y198.581
G1 X210.35 Y198.432
G1 X210.278 Y198.288
G1 X210.195 Y198.149
G1 X210.103 Y198.016
G1 X210.002 Y197.891
G1 X209.892 Y197.773
G1 X209.774 Y197.662
G1 X209.648 Y197.561
G1 X209.532 Y197.48
G1 X209.793 Y197.104
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.59406
G1 F1456
M204 S1000
G1 X210.812 Y197.103 E.04574
G1 X210.811 Y198.356 E.05629
G1 X210.608 Y197.935 E.02099
G1 X210.317 Y197.546 E.02183
G1 X209.839 Y197.143 E.0281
; WIPE_START
G1 F6000
G1 X210.812 Y197.103 E-.36994
G1 X210.811 Y198.129 E-.39006
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y198.129 Z4.3 F30000
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.516 Y201.273
G1 X209.377 Y201.356
G1 X208.303 Y201.899
G1 X208.452 Y201.901
G1 X208.46 Y201.75
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.71542
G1 F1456
M204 S1000
G1 X208.52 Y201.716 E.0038
; LINE_WIDTH: 0.670703
G1 X208.581 Y201.682 E.00355
; LINE_WIDTH: 0.625985
G1 X208.641 Y201.648 E.0033
; LINE_WIDTH: 0.581268
G1 X208.702 Y201.614 E.00305
; LINE_WIDTH: 0.53655
G1 X208.974 Y201.506 E.01179
; LINE_WIDTH: 0.49327
G1 X209.246 Y201.397 E.01076
; LINE_WIDTH: 0.44999
G1 X209.728 Y201.098 E.01881
G1 X210.141 Y200.651 E.02018
G1 X210.427 Y200.079 E.02123
G1 X210.54 Y199.449 E.02122
G1 X210.47 Y198.813 E.02122
G1 X210.225 Y198.222 E.02123
G1 X209.823 Y197.725 E.02121
G1 X209.297 Y197.36 E.02122
; LINE_WIDTH: 0.48236
G1 X209.006 Y197.244 E.01124
; LINE_WIDTH: 0.51473
G1 X208.714 Y197.129 E.01206
G1 X208.294 Y197.098 E.01621
; LINE_WIDTH: 0.49299
G1 X207.069 Y197.098 E.04492
; LINE_WIDTH: 0.49251
G1 X207.086 Y196.665 E.01587
G1 X207.294 Y196.648 E.00766
; LINE_WIDTH: 0.51473
G1 X208.739 Y196.658 E.05555
G1 X209.084 Y196.642 E.01329
; LINE_WIDTH: 0.48236
G1 X209.43 Y196.625 E.01238
; LINE_WIDTH: 0.44999
G3 X211.251 Y196.64 I.59 J38.883 E.06042
G1 X211.291 Y196.707 E.00258
G1 X211.287 Y206.843 E.33623
; object ids of layer 53 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer53 end: 399
M625
G1 X211.215 Y206.915 E.0034
G1 X209.072 Y206.917 E.07107
; LINE_WIDTH: 0.485435
G1 X208.743 Y206.9 E.01188
; LINE_WIDTH: 0.52088
G2 X207.319 Y206.884 I-.86 J13.133 E.0555
; LINE_WIDTH: 0.5202
G1 X207.095 Y206.869 E.00873
G1 X207.08 Y206.407 E.01796
G1 X207.318 Y206.407 E.00926
; LINE_WIDTH: 0.52088
G1 X208.414 Y206.405 E.04265
G1 X208.543 Y206.39 E.00508
; LINE_WIDTH: 0.52071
G1 X208.849 Y206.294 E.0125
; LINE_WIDTH: 0.48535
G1 X209.155 Y206.197 E.01157
; LINE_WIDTH: 0.44999
G1 X209.705 Y205.87 E.02122
G1 X210.141 Y205.401 E.02122
G1 X210.427 Y204.829 E.02123
G1 X210.541 Y204.241 E.01987
G1 X210.506 Y203.725 E.01716
G1 X210.304 Y203.117 E.02122
G1 X209.94 Y202.592 E.02122
G1 X209.442 Y202.19 E.02122
G1 X208.966 Y201.987 E.01716
; LINE_WIDTH: 0.494229
G1 X208.882 Y201.947 E.00343
; LINE_WIDTH: 0.538467
G1 X208.797 Y201.908 E.00376
; LINE_WIDTH: 0.582705
G1 X208.713 Y201.869 E.0041
; LINE_WIDTH: 0.626944
G1 X208.628 Y201.829 E.00443
; LINE_WIDTH: 0.671182
G1 X208.544 Y201.79 E.00477
; LINE_WIDTH: 0.71542
G1 X208.514 Y201.776 E.00182
; WIPE_START
G1 F6000
G1 X208.52 Y201.716 E-.02271
G1 X208.581 Y201.682 E-.02638
G1 X208.641 Y201.648 E-.02638
G1 X208.702 Y201.614 E-.02638
G1 X208.974 Y201.506 E-.11137
G1 X209.246 Y201.397 E-.11138
G1 X209.728 Y201.098 E-.21543
G1 X210.121 Y200.673 E-.21998
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.134 Y200.682 Z4.3 F30000
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.516 Y201.273
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.119 Y201.899
G1 X206.119 Y202.292
G1 Z3.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1456
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.425 Y201.227 E.06769
G1 X208.917 Y201.122 E.01547
G1 X209.385 Y200.875 E.01625
G1 X209.764 Y200.506 E.01625
G1 X210.025 Y200.046 E.01626
G1 X210.146 Y199.523 E.01649
G1 X210.114 Y199.003 E.01602
G1 X209.937 Y198.504 E.01626
G1 X209.625 Y198.075 E.0163
G1 X209.207 Y197.753 E.01619
G1 X208.714 Y197.561 E.01626
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.716 E.02444
G1 X206.725 Y196.44 E.00874
G1 X206.857 Y196.306 E.00578
G1 X207.055 Y196.235 E.00646
G1 X209.055 Y196.233 E.06145
G3 X211.313 Y196.252 I.78 J41.766 E.06939
G1 X211.508 Y196.34 E.00655
G1 X211.625 Y196.487 E.00579
G1 X211.683 Y196.707 E.00699
G1 X211.679 Y206.707 E.30726
G3 X211.612 Y207.103 I-.839 J.06 E.01246
G3 X211.281 Y207.307 I-.378 J-.24 E.01235
G1 X207.32 Y207.311 E.12173
G1 X206.904 Y207.263 E.01285
G1 X206.753 Y207.143 E.00594
G1 X206.653 Y206.86 E.00921
G1 X206.653 Y205.981 E.02702
G1 X208.413 Y205.977 E.05406
G1 X208.917 Y205.872 E.01584
G1 X209.385 Y205.625 E.01625
G1 X209.764 Y205.256 E.01625
G1 X210.025 Y204.796 E.01626
G1 X210.146 Y204.273 E.01648
G1 X210.114 Y203.753 E.01602
G1 X209.937 Y203.254 E.01626
G1 X209.626 Y202.827 E.01625
G1 X209.207 Y202.503 E.01625
G1 X208.714 Y202.311 E.01626
G1 X208.294 Y202.261 E.01302
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.311 Z4.3 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.273
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
M73 P98 R0
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.539 Y199.617
G1 X210.908 Y199.657
G1 Z3.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.4215
G1 F1456
M204 S1000
G1 X210.897 Y198.947 E.02192
G1 E-.8 F1800
M204 S10000
G1 X210.907 Y204.407 Z4.3 F30000
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.41966
G1 F1456
M204 S1000
G1 X210.896 Y203.697 E.02181
; WIPE_START
G1 F6000
G1 X210.907 Y204.407 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.539 Y204.367 Z4.3 F30000
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.8
G1 X210.503 Y203.641
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.412
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X206.223 Y201.899
G1 X206.223 Y201.746
G1 Z3.9
G1 E.8 F1800
; LINE_WIDTH: 0.70122
G1 F1456
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X208.16 Y201.744 E.10729
; LINE_WIDTH: 0.69994
G1 X208.294 Y201.744 E.00715
; LINE_WIDTH: 0.71542
G1 X208.46 Y201.75 E.0091
; CHANGE_LAYER
; Z_HEIGHT: 4.1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X208.294 Y201.744 E-.06313
G1 X208.16 Y201.744 E-.05072
G1 X206.46 Y201.746 E-.64615
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 54/58
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.3 I.001 J1.217 P1  F30000
G1 X209.464 Y201.742 Z4.3
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1459
M204 S1000
G2 X210.015 Y201.386 I-1.118 J-2.332 E.02184
G1 X210.498 Y200.846 E.02401
G2 X210.824 Y200.165 I-2.205 J-1.475 E.02514
G1 X210.866 Y199.911 E.00854
; LINE_WIDTH: 0.424655
G1 X210.908 Y199.657 E.00801
G1 X210.895 Y199.914 E.00801
; LINE_WIDTH: 0.44999
G1 X210.882 Y202.172 E.07488
G2 X210.896 Y203.697 I38.115 J.398 E.05059
; LINE_WIDTH: 0.44108
G1 X210.848 Y203.423 E.00903
; LINE_WIDTH: 0.44999
G2 X210.045 Y202.132 I-2.473 J.644 E.05117
G1 X209.514 Y201.776 E.02123
M204 S10000
G1 X210.45 Y201.745 F30000
; LINE_WIDTH: 0.65124
G1 F1459
M204 S1000
G3 X210.412 Y201.679 I-.071 J-.003 E.01824
G1 E-.8 F1800
M204 S10000
G1 X210.907 Y204.407 Z4.5 F30000
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.423715
G1 F1459
M204 S1000
G1 X210.894 Y204.664 E.00799
; LINE_WIDTH: 0.44999
G1 X210.88 Y206.509 E.06119
G1 X209.432 Y206.51 E.04805
G1 X209.768 Y206.326 E.01272
G1 X210.261 Y205.89 E.02184
G2 X210.824 Y204.915 I-2.29 J-1.973 E.03756
G1 X210.866 Y204.661 E.00854
; LINE_WIDTH: 0.423715
G1 X210.898 Y204.466 E.00613
G1 E-.8 F1800
M204 S10000
G1 X210.538 Y206.112 Z4.5 F30000
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.3612
G1 F1459
M204 S1000
G1 X210.478 Y206.146 E.00179
G1 X210.538 Y206.181 E.00179
G1 X210.557 Y206.146 E.00103
; WIPE_START
G1 F6000
G1 X210.538 Y206.181 E-.17025
G1 X210.478 Y206.146 E-.29488
G1 X210.538 Y206.112 E-.29488
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.5 I.829 J-.891 P1  F30000
G1 X209.996 Y205.608 Z4.5
G1 X210.002 Y205.602
G1 X210.103 Y205.476
G1 X210.195 Y205.344
G1 X210.278 Y205.205
G1 X210.35 Y205.061
G1 X210.412 Y204.911
G1 X210.463 Y204.758
G1 X210.503 Y204.602
G1 X210.531 Y204.443
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.799
G1 X210.503 Y203.641
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.412
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X205.671 Y201.899
G1 X205.652 Y201.032
G1 X205.671 Y201.594
G1 X205.521 Y201.746
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1459
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1459
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.311 Z4.5 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.697 Y201.578
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.515 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.049
G1 X210.503 Y198.891
G1 X210.463 Y198.734
G1 X210.412 Y198.581
G1 X210.35 Y198.432
G1 X210.278 Y198.288
G1 X210.195 Y198.149
G1 X210.103 Y198.016
G1 X210.002 Y197.891
G1 X209.892 Y197.773
G1 X209.774 Y197.662
G1 X209.648 Y197.561
G1 X209.532 Y197.48
G1 X209.793 Y197.104
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.59406
G1 F1459
M204 S1000
G1 X210.812 Y197.103 E.04575
G1 X210.811 Y198.356 E.05629
G1 X210.608 Y197.935 E.02099
G1 X210.317 Y197.546 E.02183
G1 X209.839 Y197.143 E.0281
; WIPE_START
G1 F6000
G1 X210.812 Y197.103 E-.36994
G1 X210.811 Y198.129 E-.39006
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y198.129 Z4.5 F30000
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.515 Y201.274
G1 X209.377 Y201.356
G1 X208.303 Y201.899
G1 X208.452 Y201.901
G1 X208.46 Y201.75
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.71542
G1 F1459
M204 S1000
G1 X208.52 Y201.716 E.0038
; LINE_WIDTH: 0.670708
G1 X208.581 Y201.682 E.00355
; LINE_WIDTH: 0.625995
G1 X208.641 Y201.648 E.0033
; LINE_WIDTH: 0.581283
G1 X208.702 Y201.614 E.00305
; LINE_WIDTH: 0.53657
G1 X208.974 Y201.506 E.01179
; LINE_WIDTH: 0.49328
G1 X209.246 Y201.397 E.01075
; LINE_WIDTH: 0.44999
G1 X209.727 Y201.098 E.01881
G1 X210.141 Y200.651 E.02018
G1 X210.427 Y200.079 E.02123
G1 X210.54 Y199.449 E.02122
G1 X210.47 Y198.813 E.02121
G1 X210.225 Y198.222 E.02123
G1 X209.823 Y197.725 E.02122
G1 X209.297 Y197.36 E.02122
; LINE_WIDTH: 0.48236
G1 X209.006 Y197.244 E.01124
; LINE_WIDTH: 0.51473
G1 X208.714 Y197.129 E.01206
G1 X208.294 Y197.098 E.01621
; LINE_WIDTH: 0.493
G1 X207.069 Y197.098 E.04493
; LINE_WIDTH: 0.49252
G1 X207.083 Y196.668 E.01576
G1 X207.294 Y196.648 E.00777
; LINE_WIDTH: 0.51473
G1 X208.739 Y196.658 E.05555
G1 X209.084 Y196.642 E.01329
; LINE_WIDTH: 0.48236
G1 X209.429 Y196.625 E.01238
; LINE_WIDTH: 0.44999
G3 X211.251 Y196.64 I.59 J38.928 E.06042
G1 X211.291 Y196.707 E.00259
G1 X211.287 Y206.843 E.33623
; object ids of layer 54 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer54 end: 399
M625
G1 X211.215 Y206.915 E.0034
G1 X209.072 Y206.917 E.07107
; LINE_WIDTH: 0.485435
G1 X208.743 Y206.9 E.01188
; LINE_WIDTH: 0.52088
G2 X207.319 Y206.884 I-.86 J13.132 E.05549
; LINE_WIDTH: 0.5202
G1 X207.095 Y206.869 E.00873
G1 X207.08 Y206.407 E.01796
G1 X207.318 Y206.407 E.00926
; LINE_WIDTH: 0.52088
G1 X208.414 Y206.405 E.04265
G1 X208.543 Y206.39 E.00508
; LINE_WIDTH: 0.52071
G1 X208.849 Y206.294 E.0125
; LINE_WIDTH: 0.48535
G1 X209.155 Y206.197 E.01157
; LINE_WIDTH: 0.44999
G1 X209.705 Y205.87 E.02123
G1 X210.141 Y205.401 E.02121
G1 X210.427 Y204.829 E.02123
G1 X210.541 Y204.241 E.01987
G1 X210.506 Y203.725 E.01716
G1 X210.304 Y203.117 E.02122
G1 X209.94 Y202.592 E.02122
G1 X209.442 Y202.19 E.02122
G1 X208.966 Y201.987 E.01716
; LINE_WIDTH: 0.494229
G1 X208.882 Y201.947 E.00343
; LINE_WIDTH: 0.538467
G1 X208.797 Y201.908 E.00376
; LINE_WIDTH: 0.582705
G1 X208.713 Y201.869 E.0041
; LINE_WIDTH: 0.626944
G1 X208.628 Y201.829 E.00443
; LINE_WIDTH: 0.671182
G1 X208.544 Y201.79 E.00477
; LINE_WIDTH: 0.71542
G1 X208.514 Y201.776 E.00182
; WIPE_START
G1 F6000
G1 X208.52 Y201.716 E-.02271
G1 X208.581 Y201.682 E-.02637
G1 X208.641 Y201.648 E-.02637
G1 X208.702 Y201.614 E-.02638
G1 X208.974 Y201.506 E-.11136
G1 X209.246 Y201.397 E-.11136
G1 X209.727 Y201.098 E-.21545
G1 X210.121 Y200.673 E-.22
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.134 Y200.682 Z4.5 F30000
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.515 Y201.274
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.119 Y201.899
G1 X206.119 Y202.292
G1 Z4.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1459
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.425 Y201.227 E.06769
G1 X208.917 Y201.122 E.01547
G1 X209.385 Y200.875 E.01626
G1 X209.764 Y200.506 E.01624
G1 X210.025 Y200.046 E.01626
G1 X210.146 Y199.523 E.01648
G1 X210.114 Y199.003 E.01602
G1 X209.937 Y198.504 E.01626
G1 X209.625 Y198.075 E.0163
G1 X209.207 Y197.753 E.0162
G1 X208.714 Y197.561 E.01625
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.24 E.01234
G1 X209.055 Y196.233 E.06145
G3 X211.313 Y196.252 I.78 J41.79 E.06941
G1 X211.508 Y196.34 E.00655
G1 X211.625 Y196.487 E.00579
G1 X211.683 Y196.707 E.00699
G1 X211.679 Y206.707 E.30726
G3 X211.612 Y207.103 I-.839 J.06 E.01245
G3 X211.281 Y207.307 I-.378 J-.24 E.01235
G1 X207.32 Y207.311 E.12173
G1 X206.904 Y207.263 E.01285
G1 X206.753 Y207.143 E.00594
G1 X206.653 Y206.86 E.00921
G1 X206.653 Y205.981 E.02702
G1 X208.413 Y205.977 E.05406
G1 X208.917 Y205.872 E.01584
G1 X209.385 Y205.625 E.01626
G1 X209.764 Y205.256 E.01624
G1 X210.025 Y204.796 E.01626
G1 X210.146 Y204.273 E.01648
G1 X210.114 Y203.753 E.01602
G1 X209.937 Y203.254 E.01626
G1 X209.626 Y202.827 E.01625
G1 X209.207 Y202.503 E.01625
G1 X208.714 Y202.311 E.01625
G1 X208.294 Y202.261 E.01302
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.311 Z4.5 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.697 Y201.578
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.515 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.161
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.539 Y199.617
G1 X210.908 Y199.657
G1 Z4.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.42148
G1 F1459
M204 S1000
G1 X210.897 Y198.947 E.02192
G1 E-.8 F1800
M204 S10000
G1 X210.907 Y204.407 Z4.5 F30000
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.41966
G1 F1459
M204 S1000
G1 X210.896 Y203.697 E.02181
; WIPE_START
G1 F6000
G1 X210.907 Y204.407 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.539 Y204.367 Z4.5 F30000
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.799
G1 X210.503 Y203.641
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.412
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.232 Y202.065
G1 X209.083 Y202.003
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X206.223 Y201.899
G1 X206.223 Y201.746
G1 Z4.1
G1 E.8 F1800
; LINE_WIDTH: 0.70122
G1 F1459
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X208.16 Y201.744 E.10729
; LINE_WIDTH: 0.69994
G1 X208.294 Y201.744 E.00715
; LINE_WIDTH: 0.71542
G1 X208.46 Y201.75 E.00911
; CHANGE_LAYER
; Z_HEIGHT: 4.3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X208.294 Y201.744 E-.06314
G1 X208.16 Y201.744 E-.05072
G1 X206.46 Y201.746 E-.64614
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 55/58
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.5 I0 J1.217 P1  F30000
G1 X209.455 Y201.747 Z4.5
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1452
M204 S1000
G2 X210.011 Y201.39 I-.869 J-1.964 E.022
G1 X210.493 Y200.856 E.02388
G1 X210.796 Y200.254 E.02234
G1 X210.902 Y199.777 E.01621
G1 X210.883 Y200.266 E.01622
G1 X210.882 Y202.266 E.06634
G2 X210.888 Y203.607 I74.078 J.307 E.04449
G2 X209.509 Y201.773 I-2.525 J.464 E.07891
M204 S10000
G1 X210.448 Y201.751 F30000
; LINE_WIDTH: 0.65654
G1 F1452
M204 S1000
G3 X210.41 Y201.685 I-.072 J-.003 E.01856
G1 E-.8 F1800
M204 S10000
G1 X210.901 Y204.527 Z4.7 F30000
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1452
M204 S1000
G2 X210.88 Y206.509 I24.379 J1.245 E.06576
G1 X209.432 Y206.51 E.04805
G1 X209.993 Y206.158 E.02199
G1 X210.493 Y205.606 E.0247
G1 X210.796 Y205.004 E.02234
G1 X210.888 Y204.586 E.01422
G1 E-.8 F1800
M204 S10000
G1 X210.538 Y206.112 Z4.7 F30000
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.3612
G1 F1452
M204 S1000
G1 X210.478 Y206.146 E.00179
G1 X210.538 Y206.181 E.00179
G1 X210.557 Y206.146 E.00103
; WIPE_START
G1 F6000
G1 X210.538 Y206.181 E-.17025
G1 X210.478 Y206.146 E-.29488
G1 X210.538 Y206.112 E-.29488
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.996 Y205.608 Z4.7 F30000
G1 X210.002 Y205.602
G1 X210.103 Y205.476
G1 X210.195 Y205.344
G1 X210.278 Y205.205
G1 X210.35 Y205.061
G1 X210.393 Y204.956
G1 X210.461 Y204.764
G1 X210.503 Y204.602
G1 X210.531 Y204.443
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.799
G1 X210.503 Y203.641
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.276 Y202.086
G1 X209.089 Y202.005
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X205.671 Y201.899
G1 X205.652 Y201.032
G1 X205.671 Y201.594
G1 X205.521 Y201.746
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1452
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1452
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.311 Z4.7 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.736 Y201.111
G1 X209.888 Y200.974
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.393 Y200.206
G1 X210.461 Y200.014
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.05
G1 X210.511 Y198.939
G1 X210.464 Y198.74
G1 X210.412 Y198.581
G1 X210.35 Y198.432
G1 X210.278 Y198.288
G1 X210.195 Y198.149
G1 X210.103 Y198.016
G1 X210.032 Y197.929
G1 X209.896 Y197.776
G1 X209.774 Y197.663
G1 X209.648 Y197.561
G1 X209.547 Y197.491
G1 X209.814 Y197.106
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.59289
G1 F1452
M204 S1000
G3 X210.812 Y197.102 I.681 J44.202 E.04475
G1 X210.812 Y198.339 E.05542
G1 X210.711 Y198.114 E.01106
G1 X210.317 Y197.546 E.03096
G1 X209.859 Y197.146 E.02725
; WIPE_START
G1 F6000
G1 X210.812 Y197.102 E-.36263
G1 X210.812 Y198.148 E-.39737
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y198.148 Z4.7 F30000
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.888 Y200.974
G1 X209.736 Y201.111
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X208.303 Y201.899
G1 X208.433 Y201.9
G1 X208.434 Y201.751
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.71334
G1 F1452
M204 S1000
G1 X208.501 Y201.716 E.0041
; LINE_WIDTH: 0.669449
G1 X208.567 Y201.681 E.00383
; LINE_WIDTH: 0.625557
G1 X208.633 Y201.646 E.00356
; LINE_WIDTH: 0.581665
G1 X208.7 Y201.611 E.00329
; LINE_WIDTH: 0.537774
G1 X208.766 Y201.576 E.00302
; LINE_WIDTH: 0.493882
G1 X208.833 Y201.541 E.00276
; LINE_WIDTH: 0.44999
G1 X209.155 Y201.447 E.01116
G1 X209.63 Y201.183 E.01802
G1 X210.042 Y200.784 E.01902
G1 X210.349 Y200.279 E.01961
G1 X210.519 Y199.71 E.0197
G1 X210.528 Y199.133 E.01912
G1 X210.371 Y198.513 E.02122
G1 X210.075 Y198.002 E.0196
G1 X209.697 Y197.615 E.01795
G1 X209.201 Y197.315 E.01923
; LINE_WIDTH: 0.4833
G1 X208.946 Y197.22 E.00975
; LINE_WIDTH: 0.51661
G1 X208.692 Y197.124 E.01048
G1 X208.294 Y197.098 E.01542
; LINE_WIDTH: 0.493
G1 X207.069 Y197.098 E.04492
; LINE_WIDTH: 0.49252
G1 X207.083 Y196.668 E.01577
G1 X207.294 Y196.648 E.00777
; LINE_WIDTH: 0.50272
G1 X208.872 Y196.639 E.05913
; LINE_WIDTH: 0.476355
G1 X209.154 Y196.625 E.00996
; LINE_WIDTH: 0.44999
G3 X211.251 Y196.64 I.733 J44.744 E.06956
G1 X211.291 Y196.707 E.00259
G1 X211.287 Y206.843 E.33623
; object ids of layer 55 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer55 end: 399
M625
G1 X211.215 Y206.915 E.0034
G1 X209.072 Y206.917 E.07107
; LINE_WIDTH: 0.485435
G1 X208.743 Y206.9 E.01188
; LINE_WIDTH: 0.52088
G2 X207.319 Y206.884 I-.86 J13.132 E.05549
; LINE_WIDTH: 0.5202
G1 X207.095 Y206.869 E.00873
G1 X207.08 Y206.407 E.01796
G1 X207.318 Y206.407 E.00926
; LINE_WIDTH: 0.52088
G1 X208.414 Y206.405 E.04265
G1 X208.543 Y206.39 E.00508
; LINE_WIDTH: 0.52071
G1 X208.849 Y206.294 E.0125
; LINE_WIDTH: 0.48535
G1 X209.155 Y206.197 E.01157
; LINE_WIDTH: 0.44999
G1 X209.705 Y205.87 E.02123
G1 X210.138 Y205.407 E.02101
G1 X210.403 Y204.897 E.01905
G1 X210.528 Y204.359 E.01833
G1 X210.505 Y203.72 E.02123
G1 X210.302 Y203.113 E.02122
G1 X209.937 Y202.588 E.02122
G1 X209.438 Y202.187 E.02122
G1 X208.967 Y201.974 E.01715
; LINE_WIDTH: 0.493882
G1 X208.878 Y201.936 E.00354
; LINE_WIDTH: 0.537774
G1 X208.789 Y201.899 E.00388
; LINE_WIDTH: 0.581665
G1 X208.701 Y201.862 E.00423
; LINE_WIDTH: 0.625557
G1 X208.612 Y201.825 E.00457
; LINE_WIDTH: 0.669449
G1 X208.523 Y201.788 E.00492
; LINE_WIDTH: 0.71334
G1 X208.489 Y201.774 E.00198
; WIPE_START
G1 F6000
G1 X208.501 Y201.716 E-.02245
G1 X208.567 Y201.681 E-.0285
G1 X208.633 Y201.646 E-.0285
G1 X208.7 Y201.611 E-.0285
G1 X208.766 Y201.576 E-.0285
G1 X208.833 Y201.541 E-.0285
G1 X209.155 Y201.447 E-.12784
G1 X209.63 Y201.183 E-.20649
G1 X210.042 Y200.784 E-.21788
G1 X210.1 Y200.687 E-.04285
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.121 Y200.701 Z4.7 F30000
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.888 Y200.974
G1 X209.736 Y201.111
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.119 Y201.899
G1 X206.119 Y202.292
G1 Z4.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1452
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.418 Y201.227 E.06749
G1 X208.93 Y201.118 E.01609
G1 X209.404 Y200.863 E.01653
G1 X209.764 Y200.506 E.01559
G1 X210.007 Y200.087 E.01488
G1 X210.133 Y199.642 E.01422
G1 X210.136 Y199.133 E.01563
M73 P99 R0
G1 X209.994 Y198.624 E.01625
G1 X209.743 Y198.21 E.01488
G1 X209.425 Y197.897 E.01369
G1 X209.009 Y197.657 E.01477
G1 X208.581 Y197.535 E.0137
G1 X208.294 Y197.511 E.00885
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.241 E.01234
G1 X209.055 Y196.233 E.06145
G3 X211.313 Y196.252 I.78 J41.712 E.06941
G1 X211.508 Y196.34 E.00655
G1 X211.625 Y196.487 E.00579
G1 X211.683 Y196.707 E.00699
G1 X211.679 Y206.707 E.30726
G3 X211.612 Y207.103 I-.839 J.06 E.01245
G3 X211.281 Y207.307 I-.378 J-.24 E.01235
G1 X207.32 Y207.311 E.12173
G1 X206.904 Y207.263 E.01285
G1 X206.753 Y207.143 E.00593
G1 X206.653 Y206.86 E.00921
G1 X206.653 Y205.981 E.02702
G1 X208.413 Y205.977 E.05406
G1 X208.917 Y205.872 E.01584
G1 X209.385 Y205.625 E.01626
G1 X209.764 Y205.256 E.01624
G1 X210.007 Y204.837 E.01488
G1 X210.136 Y204.359 E.01521
G1 X210.128 Y203.83 E.01626
G1 X209.972 Y203.325 E.01625
G1 X209.68 Y202.884 E.01625
G1 X209.275 Y202.544 E.01625
G1 X208.791 Y202.331 E.01625
G1 X208.294 Y202.261 E.01543
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.311 Z4.7 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.736 Y201.111
G1 X209.888 Y200.974
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.393 Y200.206
G1 X210.461 Y200.014
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.05
G1 X210.511 Y198.939
G1 X210.889 Y198.857
G1 Z4.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43766
G1 F1452
M204 S1000
G1 X210.909 Y199.133 E.00892
; LINE_WIDTH: 0.41216
G1 X210.902 Y199.777 E.01937
; WIPE_START
G1 F6000
G1 X210.909 Y199.133 E-.53118
G1 X210.889 Y198.857 E-.22882
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.511 Y198.939 Z4.7 F30000
G1 X210.531 Y199.05
G1 X210.548 Y199.21
G1 X210.554 Y199.371
G1 X210.548 Y199.533
G1 X210.531 Y199.693
G1 X210.503 Y199.852
G1 X210.461 Y200.014
G1 X210.393 Y200.206
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.888 Y200.974
G1 X209.736 Y201.111
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.223 Y201.899
G1 X206.223 Y201.746
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.70122
G1 F1452
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X208.16 Y201.744 E.10729
; LINE_WIDTH: 0.69994
G1 X208.294 Y201.744 E.00715
; LINE_WIDTH: 0.71334
G1 X208.434 Y201.751 E.00768
G1 E-.8 F1800
M204 S10000
G1 X210.888 Y203.607 Z4.7 F30000
G1 Z4.3
G1 E.8 F1800
; LINE_WIDTH: 0.43578
G1 F1452
M204 S1000
G1 X210.908 Y203.883 E.00887
; LINE_WIDTH: 0.41028
G1 X210.901 Y204.527 E.01927
; CHANGE_LAYER
; Z_HEIGHT: 4.5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X210.908 Y203.883 E-.53132
G1 X210.888 Y203.607 E-.22868
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 56/58
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.7 I.967 J-.739 P1  F30000
G1 X209.464 Y201.742 Z4.7
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1452
M204 S1000
G2 X210.015 Y201.386 I-1.118 J-2.332 E.02184
G1 X210.498 Y200.847 E.024
G2 X210.824 Y200.165 I-2.203 J-1.474 E.02514
G1 X210.866 Y199.911 E.00856
; LINE_WIDTH: 0.423755
G1 X210.907 Y199.656 E.00801
G1 X210.894 Y199.914 E.00801
; LINE_WIDTH: 0.44999
G1 X210.882 Y202.172 E.07489
G2 X210.897 Y203.696 I40.054 J.368 E.05059
; LINE_WIDTH: 0.44154
G1 X210.848 Y203.422 E.00905
; LINE_WIDTH: 0.44999
G2 X210.045 Y202.132 I-2.474 J.645 E.05117
G1 X209.514 Y201.776 E.02123
M204 S10000
G1 X210.45 Y201.745 F30000
; LINE_WIDTH: 0.65122
G1 F1452
M204 S1000
G3 X210.412 Y201.679 I-.071 J-.003 E.01824
G1 E-.8 F1800
M204 S10000
G1 X210.908 Y204.406 Z4.9 F30000
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.424675
G1 F1452
M204 S1000
G1 X210.896 Y204.664 E.00803
; LINE_WIDTH: 0.44999
G1 X210.884 Y206.512 E.06129
G1 X209.431 Y206.51 E.0482
G1 X209.768 Y206.326 E.01275
G1 X210.262 Y205.889 E.02186
G2 X210.866 Y204.661 I-1.656 J-1.578 E.04612
; LINE_WIDTH: 0.424675
G1 X210.899 Y204.466 E.00616
G1 E-.8 F1800
M204 S10000
G1 X210.56 Y206.147 Z4.9 F30000
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.36466
G1 F1452
M204 S1000
G1 X210.539 Y206.182 E.00105
G1 X210.479 Y206.147 E.00183
G1 X210.539 Y206.112 E.00183
; WIPE_START
G1 F6000
G1 X210.479 Y206.147 E-.29487
G1 X210.539 Y206.182 E-.29487
G1 X210.56 Y206.147 E-.17026
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y206.147 Z4.9 F30000
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.265 Y202.081
G1 X209.088 Y202.004
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X205.671 Y201.899
G1 X205.652 Y201.032
G1 X205.671 Y201.594
G1 X205.521 Y201.746
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1452
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1452
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.311 Z4.9 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.162
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.554 Y199.371
G1 X210.548 Y199.21
G1 X210.531 Y199.05
G1 X210.509 Y198.927
G1 X210.464 Y198.739
G1 X210.412 Y198.581
G1 X210.35 Y198.432
G1 X210.278 Y198.288
G1 X210.195 Y198.149
G1 X210.103 Y198.016
G1 X210.025 Y197.919
G1 X209.895 Y197.776
G1 X209.774 Y197.663
G1 X209.648 Y197.561
G1 X209.533 Y197.481
G1 X209.794 Y197.106
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.5921
G1 F1452
M204 S1000
G1 X210.809 Y197.106 E.04544
G1 X210.81 Y198.36 E.05613
G1 X210.608 Y197.936 E.02102
G1 X210.316 Y197.547 E.02175
G1 X209.84 Y197.144 E.02793
; WIPE_START
G1 F6000
G1 X210.809 Y197.106 E-.36872
G1 X210.81 Y198.135 E-.39128
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y198.135 Z4.9 F30000
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X208.303 Y201.899
G1 X208.452 Y201.901
G1 X208.46 Y201.75
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.7154
G1 F1452
M204 S1000
G1 X208.52 Y201.716 E.0038
; LINE_WIDTH: 0.670678
G1 X208.581 Y201.682 E.00355
; LINE_WIDTH: 0.625955
G1 X208.641 Y201.648 E.0033
; LINE_WIDTH: 0.581233
G1 X208.702 Y201.614 E.00305
; LINE_WIDTH: 0.53651
G1 X208.974 Y201.506 E.01179
; LINE_WIDTH: 0.49325
G1 X209.246 Y201.397 E.01076
; LINE_WIDTH: 0.44999
G1 X209.727 Y201.098 E.0188
G1 X210.141 Y200.651 E.02018
G1 X210.427 Y200.079 E.02123
G1 X210.54 Y199.454 E.02108
G1 X210.478 Y198.851 E.02008
G1 X210.225 Y198.222 E.02249
G1 X209.823 Y197.725 E.02121
G1 X209.297 Y197.36 E.02122
; LINE_WIDTH: 0.481955
G1 X209.006 Y197.245 E.01122
; LINE_WIDTH: 0.51392
G1 X208.714 Y197.129 E.01204
G1 X208.294 Y197.098 E.01618
; LINE_WIDTH: 0.4924
G1 X207.069 Y197.098 E.04487
G1 X207.083 Y196.668 E.01576
G1 X207.294 Y196.649 E.00778
; LINE_WIDTH: 0.51392
G1 X208.739 Y196.659 E.05546
G1 X209.084 Y196.643 E.01326
; LINE_WIDTH: 0.481955
G1 X209.429 Y196.627 E.01236
; LINE_WIDTH: 0.44999
G3 X211.254 Y196.641 I.553 J48.46 E.06051
G1 X211.287 Y196.714 E.00268
G1 X211.29 Y204.714 E.26537
G3 X211.28 Y206.854 I-67.634 J.743 E.07099
; object ids of layer 56 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer56 end: 399
M625
G1 X211.21 Y206.919 E.00315
G1 X209.071 Y206.917 E.07095
; LINE_WIDTH: 0.485075
G1 X208.743 Y206.899 E.01186
; LINE_WIDTH: 0.52016
G2 X207.32 Y206.881 I-.878 J13.127 E.05536
; LINE_WIDTH: 0.51846
G1 X207.095 Y206.87 E.00874
G1 X207.082 Y206.406 E.01796
G1 X207.32 Y206.406 E.00923
; LINE_WIDTH: 0.52016
G1 X208.414 Y206.404 E.04254
G1 X208.543 Y206.39 E.00507
; LINE_WIDTH: 0.51974
G1 X208.849 Y206.294 E.01247
; LINE_WIDTH: 0.484865
G1 X209.155 Y206.197 E.01156
; LINE_WIDTH: 0.44999
G1 X209.705 Y205.87 E.02123
G1 X210.141 Y205.401 E.02121
G1 X210.427 Y204.829 E.02122
G1 X210.541 Y204.24 E.0199
G1 X210.506 Y203.725 E.01715
G1 X210.304 Y203.117 E.02122
G1 X209.94 Y202.591 E.02122
G1 X209.442 Y202.19 E.02121
G1 X208.966 Y201.987 E.01717
; LINE_WIDTH: 0.494225
G1 X208.882 Y201.947 E.00343
; LINE_WIDTH: 0.53846
G1 X208.797 Y201.908 E.00376
; LINE_WIDTH: 0.582695
G1 X208.713 Y201.869 E.0041
; LINE_WIDTH: 0.62693
G1 X208.628 Y201.829 E.00443
; LINE_WIDTH: 0.671165
G1 X208.544 Y201.79 E.00477
; LINE_WIDTH: 0.7154
G1 X208.514 Y201.776 E.00182
; WIPE_START
G1 F6000
G1 X208.52 Y201.716 E-.02271
G1 X208.581 Y201.682 E-.02638
G1 X208.641 Y201.648 E-.02638
G1 X208.702 Y201.614 E-.02639
G1 X208.974 Y201.506 E-.11138
G1 X209.246 Y201.397 E-.11138
G1 X209.727 Y201.098 E-.21539
G1 X210.121 Y200.673 E-.21999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.134 Y200.682 Z4.9 F30000
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.119 Y201.899
G1 X206.119 Y202.292
G1 Z4.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1452
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.222 Y201.227 E.06145
G2 X208.452 Y201.223 I.027 J-4.363 E.00709
G1 X208.968 Y201.103 E.01625
G1 X209.448 Y200.823 E.01707
G1 X209.797 Y200.463 E.01541
G1 X210.043 Y199.996 E.01626
G1 X210.149 Y199.49 E.01586
G1 X210.11 Y198.984 E.0156
G1 X209.937 Y198.506 E.0156
G1 X209.625 Y198.075 E.01637
G1 X209.207 Y197.753 E.0162
G1 X208.714 Y197.561 E.01626
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.24 E.01234
G1 X211.055 Y196.235 E.12291
G3 X211.475 Y196.303 I.073 J.887 E.01319
G1 X211.612 Y196.44 E.00596
G1 X211.679 Y196.714 E.00868
G1 X211.683 Y206.714 E.30726
G3 X211.635 Y207.06 I-.992 J.039 E.01079
G1 X211.515 Y207.211 E.00594
G1 X211.232 Y207.311 E.00921
G1 X207.137 Y207.307 E.12583
G1 X206.862 Y207.24 E.0087
G3 X206.657 Y206.909 I.241 J-.378 E.01236
G1 X206.654 Y205.981 E.02853
G1 X208.413 Y205.977 E.05404
G1 X208.917 Y205.872 E.01584
G1 X209.385 Y205.625 E.01626
G1 X209.764 Y205.256 E.01624
G1 X210.025 Y204.796 E.01625
G1 X210.146 Y204.273 E.0165
G1 X210.114 Y203.753 E.01602
G1 X209.937 Y203.254 E.01625
G1 X209.626 Y202.826 E.01625
G1 X209.207 Y202.503 E.01625
G1 X208.714 Y202.311 E.01626
G1 X208.294 Y202.261 E.01302
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.311 Z4.9 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.162
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.539 Y199.617
G1 X210.907 Y199.656
G1 Z4.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.41304
G1 F1452
M204 S1000
G1 X210.899 Y198.986 E.02021
G1 E-.8 F1800
M204 S10000
G1 X210.908 Y204.406 Z4.9 F30000
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.42114
G1 F1452
M204 S1000
G1 X210.897 Y203.696 E.02188
; WIPE_START
G1 F6000
G1 X210.908 Y204.406 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.539 Y204.367 Z4.9 F30000
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.799
G1 X210.503 Y203.641
G1 X210.463 Y203.484
G1 X210.412 Y203.331
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.265 Y202.081
G1 X209.088 Y202.004
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X206.223 Y201.899
G1 X206.223 Y201.746
G1 Z4.5
G1 E.8 F1800
; LINE_WIDTH: 0.70122
G1 F1452
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X208.16 Y201.744 E.10729
; LINE_WIDTH: 0.69994
G1 X208.294 Y201.744 E.00715
; LINE_WIDTH: 0.7154
G1 X208.46 Y201.75 E.0091
; CHANGE_LAYER
; Z_HEIGHT: 4.7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X208.294 Y201.744 E-.06312
G1 X208.16 Y201.744 E-.05072
G1 X206.46 Y201.746 E-.64616
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 57/58
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.9 I.001 J1.217 P1  F30000
G1 X209.464 Y201.742 Z4.9
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F1455
M204 S1000
G2 X210.015 Y201.386 I-1.118 J-2.332 E.02184
G1 X210.498 Y200.847 E.024
G2 X210.824 Y200.165 I-2.204 J-1.475 E.02514
G1 X210.866 Y199.911 E.00856
; LINE_WIDTH: 0.423755
G1 X210.907 Y199.656 E.00801
G1 X210.894 Y199.914 E.00801
; LINE_WIDTH: 0.44999
G1 X210.882 Y202.172 E.07489
G2 X210.897 Y203.697 I40.051 J.368 E.05059
; LINE_WIDTH: 0.44153
G1 X210.848 Y203.422 E.00905
; LINE_WIDTH: 0.44999
G2 X210.045 Y202.132 I-2.475 J.645 E.05118
G1 X209.514 Y201.776 E.02122
M204 S10000
G1 X210.45 Y201.745 F30000
; LINE_WIDTH: 0.65122
G1 F1455
M204 S1000
G3 X210.412 Y201.679 I-.071 J-.003 E.01824
G1 E-.8 F1800
M204 S10000
G1 X210.908 Y204.406 Z5.1 F30000
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.424675
G1 F1455
M204 S1000
G1 X210.896 Y204.664 E.00803
; LINE_WIDTH: 0.44999
G1 X210.884 Y206.512 E.06129
G1 X209.431 Y206.51 E.0482
G1 X209.768 Y206.326 E.01275
G1 X210.262 Y205.889 E.02186
G2 X210.866 Y204.661 I-1.656 J-1.578 E.04612
; LINE_WIDTH: 0.424675
G1 X210.899 Y204.466 E.00616
G1 E-.8 F1800
M204 S10000
G1 X210.539 Y206.112 Z5.1 F30000
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.36468
G1 F1455
M204 S1000
G1 X210.479 Y206.147 E.00183
G1 X210.539 Y206.182 E.00183
G1 X210.56 Y206.147 E.00105
; WIPE_START
G1 F6000
G1 X210.539 Y206.182 E-.17024
G1 X210.479 Y206.147 E-.29488
G1 X210.539 Y206.112 E-.29488
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X209.997 Y205.607 Z5.1 F30000
G1 X210.002 Y205.602
G1 X210.103 Y205.476
G1 X210.195 Y205.344
G1 X210.278 Y205.205
G1 X210.339 Y205.083
G1 X210.411 Y204.915
G1 X210.463 Y204.758
G1 X210.503 Y204.602
G1 X210.531 Y204.443
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.8
G1 X210.503 Y203.641
G1 X210.469 Y203.508
G1 X210.413 Y203.334
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.255 Y202.076
G1 X209.087 Y202.004
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X205.671 Y201.899
G1 X205.652 Y201.032
G1 X205.671 Y201.594
G1 X205.521 Y201.746
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.48732
G1 F1455
M204 S1000
G1 X205.405 Y201.894 E.0068
G1 X203.821 Y201.894 E.05735
G1 X203.821 Y201.449 E.01609
G1 X205.327 Y201.449 E.05455
G1 X205.357 Y201.558 E.00408
G1 X205.482 Y201.701 E.00689
M204 S10000
G1 X205.875 Y201.997 F30000
; LINE_WIDTH: 0.533734
G1 F1455
M204 S1000
G1 X205.828 Y202.038 E.00248
; LINE_WIDTH: 0.491862
G1 X205.762 Y202.096 E.00323
; LINE_WIDTH: 0.44999
G1 X205.686 Y202.319 E.00783
G1 X203.57 Y202.319 E.07017
G1 X203.395 Y202.207 E.00689
G1 X203.395 Y201.023 E.03926
G1 X205.622 Y201.023 E.07385
G1 X205.762 Y201.397 E.01323
; LINE_WIDTH: 0.491862
G1 X205.828 Y201.455 E.00323
; LINE_WIDTH: 0.533734
G1 X205.894 Y201.513 E.00353
; LINE_WIDTH: 0.575605
G1 X205.961 Y201.572 E.00383
; LINE_WIDTH: 0.617477
G1 X206.027 Y201.63 E.00414
; LINE_WIDTH: 0.659349
G1 X206.094 Y201.688 E.00444
; LINE_WIDTH: 0.70122
G1 X206.16 Y201.746 E.00474
G1 X206.094 Y201.805 E.00474
; LINE_WIDTH: 0.659349
G1 X206.027 Y201.863 E.00444
; LINE_WIDTH: 0.617477
G1 X205.961 Y201.921 E.00414
; LINE_WIDTH: 0.575605
G1 X205.92 Y201.957 E.00237
; WIPE_START
G1 F6000
G1 X205.828 Y202.038 E-.04639
G1 X205.762 Y202.096 E-.03357
G1 X205.686 Y202.319 E-.08972
G1 X204.132 Y202.319 E-.59033
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.132 Y202.311 Z5.1 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.162
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.548 Y199.533
G1 X210.553 Y199.396
G1 X210.549 Y199.213
G1 X210.531 Y199.05
G1 X210.503 Y198.891
G1 X210.463 Y198.734
G1 X210.412 Y198.581
G1 X210.35 Y198.432
G1 X210.278 Y198.288
G1 X210.195 Y198.149
G1 X210.103 Y198.016
G1 X210.002 Y197.891
G1 X209.892 Y197.773
G1 X209.774 Y197.663
G1 X209.648 Y197.561
G1 X209.533 Y197.481
G1 X209.794 Y197.106
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.59211
G1 F1455
M204 S1000
G1 X210.809 Y197.106 E.04544
G1 X210.81 Y198.354 E.05589
G1 X210.608 Y197.936 E.0208
G1 X210.316 Y197.547 E.02175
G1 X209.84 Y197.144 E.02793
; WIPE_START
G1 F6000
G1 X210.809 Y197.106 E-.36871
G1 X210.81 Y198.135 E-.39129
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X211.282 Y198.135 Z5.1 F30000
G1 X210.35 Y200.311
G1 X210.278 Y200.455
G1 X210.195 Y200.594
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X208.303 Y201.899
G1 X208.452 Y201.901
G1 X208.46 Y201.75
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.71542
G1 F1455
M204 S1000
G1 X208.52 Y201.716 E.0038
; LINE_WIDTH: 0.670693
G1 X208.581 Y201.682 E.00355
; LINE_WIDTH: 0.625965
G1 X208.641 Y201.648 E.0033
; LINE_WIDTH: 0.581238
G1 X208.702 Y201.614 E.00305
; LINE_WIDTH: 0.53651
G1 X208.974 Y201.506 E.01179
; LINE_WIDTH: 0.49325
G1 X209.246 Y201.397 E.01075
; LINE_WIDTH: 0.44999
G1 X209.727 Y201.098 E.01881
G1 X210.141 Y200.651 E.02018
G1 X210.427 Y200.079 E.02123
G1 X210.54 Y199.449 E.02123
G1 X210.47 Y198.813 E.02122
G1 X210.225 Y198.222 E.02122
G1 X209.823 Y197.725 E.02122
G1 X209.297 Y197.36 E.02122
; LINE_WIDTH: 0.481955
G1 X209.006 Y197.245 E.01122
; LINE_WIDTH: 0.51392
G1 X208.714 Y197.129 E.01204
G1 X208.294 Y197.098 E.01618
; LINE_WIDTH: 0.4924
G1 X207.069 Y197.098 E.04487
G1 X207.083 Y196.668 E.01577
G1 X207.294 Y196.649 E.00777
; LINE_WIDTH: 0.51392
G1 X208.739 Y196.659 E.05546
G1 X209.084 Y196.643 E.01326
; LINE_WIDTH: 0.481955
G1 X209.429 Y196.627 E.01236
; LINE_WIDTH: 0.44999
G3 X211.254 Y196.641 I.553 J48.429 E.06051
G1 X211.287 Y196.714 E.00268
G1 X211.29 Y204.714 E.26537
G3 X211.28 Y206.854 I-67.803 J.743 E.07099
; object ids of layer 57 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer57 end: 399
M625
G1 X211.21 Y206.919 E.00316
G1 X209.072 Y206.917 E.07094
; LINE_WIDTH: 0.485075
G1 X208.743 Y206.899 E.01187
; LINE_WIDTH: 0.52016
G2 X207.32 Y206.881 I-.878 J13.131 E.05536
; LINE_WIDTH: 0.51846
G1 X207.095 Y206.87 E.00874
G1 X207.082 Y206.406 E.01796
G1 X207.32 Y206.406 E.00923
; LINE_WIDTH: 0.52016
G1 X208.414 Y206.404 E.04254
G1 X208.543 Y206.39 E.00507
; LINE_WIDTH: 0.51973
G1 X208.849 Y206.293 E.01247
; LINE_WIDTH: 0.48486
G1 X209.156 Y206.197 E.01156
; LINE_WIDTH: 0.44999
G1 X209.705 Y205.87 E.02122
G1 X210.141 Y205.401 E.02121
G1 X210.427 Y204.829 E.02122
G1 X210.541 Y204.24 E.0199
G1 X210.506 Y203.725 E.01714
G1 X210.304 Y203.117 E.02122
G1 X209.94 Y202.591 E.02122
G1 X209.442 Y202.19 E.02122
G1 X208.966 Y201.987 E.01716
; LINE_WIDTH: 0.494229
G1 X208.882 Y201.947 E.00343
; LINE_WIDTH: 0.538467
G1 X208.797 Y201.908 E.00376
; LINE_WIDTH: 0.582705
G1 X208.713 Y201.869 E.0041
; LINE_WIDTH: 0.626944
G1 X208.628 Y201.829 E.00444
; LINE_WIDTH: 0.671182
G1 X208.544 Y201.79 E.00477
; LINE_WIDTH: 0.71542
G1 X208.514 Y201.776 E.00182
; WIPE_START
G1 F6000
G1 X208.52 Y201.716 E-.02271
G1 X208.581 Y201.682 E-.02638
G1 X208.641 Y201.648 E-.02638
G1 X208.702 Y201.614 E-.02639
G1 X208.974 Y201.506 E-.11135
G1 X209.246 Y201.397 E-.11135
G1 X209.727 Y201.098 E-.21544
G1 X210.121 Y200.673 E-.21999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.134 Y200.682 Z5.1 F30000
G1 X210.103 Y200.726
G1 X210.002 Y200.852
G1 X209.892 Y200.97
G1 X209.774 Y201.08
G1 X209.648 Y201.181
G1 X209.516 Y201.274
G1 X209.377 Y201.356
G1 X209.232 Y201.428
G1 X209.083 Y201.49
G1 X208.93 Y201.541
G1 X208.772 Y201.572
G1 X205.671 Y201.899
G1 X206.119 Y201.899
G1 X206.119 Y202.292
G1 Z4.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1455
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.425 Y201.227 E.06769
G1 X208.917 Y201.122 E.01548
G1 X209.385 Y200.875 E.01625
G1 X209.764 Y200.506 E.01625
G1 X210.025 Y200.046 E.01626
G1 X210.146 Y199.523 E.01649
G1 X210.114 Y199.003 E.01602
G1 X209.937 Y198.504 E.01625
G1 X209.625 Y198.075 E.01631
G1 X209.207 Y197.753 E.0162
G1 X208.714 Y197.561 E.01625
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.377 J.24 E.01235
G1 X211.055 Y196.235 E.12291
G3 X211.475 Y196.303 I.072 J.886 E.01318
G1 X211.612 Y196.44 E.00596
G1 X211.679 Y196.714 E.00868
G1 X211.683 Y206.714 E.30726
G3 X211.635 Y207.06 I-.992 J.039 E.01079
G1 X211.515 Y207.211 E.00594
G1 X211.232 Y207.311 E.00921
G1 X207.137 Y207.307 E.12583
G1 X206.862 Y207.24 E.0087
G3 X206.657 Y206.909 I.241 J-.378 E.01235
G1 X206.654 Y205.981 E.02853
G1 X208.413 Y205.977 E.05404
G1 X208.917 Y205.872 E.01584
G1 X209.385 Y205.625 E.01625
G1 X209.764 Y205.256 E.01625
G1 X210.025 Y204.796 E.01625
G1 X210.146 Y204.273 E.0165
G1 X210.114 Y203.753 E.01602
G1 X209.937 Y203.254 E.01625
G1 X209.626 Y202.826 E.01625
G1 X209.207 Y202.503 E.01625
G1 X208.714 Y202.311 E.01625
G1 X208.294 Y202.261 E.01302
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X204.524 Y202.311 Z5.1 F30000
G1 X205.671 Y201.594
G1 X208.303 Y201.594
G1 X208.452 Y201.592
G1 X208.611 Y201.584
G1 X208.772 Y201.572
G1 X208.93 Y201.541
G1 X209.083 Y201.49
G1 X209.232 Y201.428
G1 X209.377 Y201.356
G1 X209.516 Y201.274
G1 X209.648 Y201.181
G1 X209.774 Y201.08
G1 X209.892 Y200.97
G1 X210.002 Y200.852
G1 X210.103 Y200.726
G1 X210.195 Y200.594
G1 X210.278 Y200.455
G1 X210.35 Y200.311
G1 X210.412 Y200.162
G1 X210.463 Y200.008
G1 X210.503 Y199.852
G1 X210.531 Y199.693
G1 X210.539 Y199.617
G1 X210.907 Y199.656
G1 Z4.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.4193
G1 F1455
M204 S1000
G1 X210.896 Y198.947 E.02177
G1 E-.8 F1800
M204 S10000
G1 X210.908 Y204.406 Z5.1 F30000
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.42114
G1 F1455
M204 S1000
G1 X210.897 Y203.697 E.02188
; WIPE_START
G1 F6000
G1 X210.908 Y204.406 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.539 Y204.367 Z5.1 F30000
G1 X210.548 Y204.283
G1 X210.554 Y204.121
G1 X210.548 Y203.96
G1 X210.531 Y203.8
G1 X210.503 Y203.641
G1 X210.469 Y203.508
G1 X210.413 Y203.334
G1 X210.35 Y203.182
G1 X210.278 Y203.038
G1 X210.195 Y202.899
G1 X210.103 Y202.766
G1 X210.002 Y202.641
G1 X209.892 Y202.523
G1 X209.774 Y202.413
G1 X209.648 Y202.311
G1 X209.516 Y202.219
G1 X209.377 Y202.137
G1 X209.255 Y202.076
G1 X209.087 Y202.004
G1 X208.93 Y201.952
G1 X208.772 Y201.921
G1 X208.611 Y201.908
G1 X208.452 Y201.9
G1 X208.303 Y201.899
G1 X206.223 Y201.899
G1 X206.223 Y201.746
G1 Z4.7
G1 E.8 F1800
; LINE_WIDTH: 0.70122
G1 F1455
M204 S1000
G1 X206.16 Y201.746 E.00337
G1 X208.16 Y201.744 E.10729
; LINE_WIDTH: 0.69994
G1 X208.294 Y201.744 E.00715
; LINE_WIDTH: 0.71542
G1 X208.46 Y201.75 E.0091
; CHANGE_LAYER
; Z_HEIGHT: 4.9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X208.294 Y201.744 E-.06314
G1 X208.16 Y201.744 E-.05072
G1 X206.46 Y201.746 E-.64615
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 399
M625
; layer num/total_layer_count: 58/58
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
; OBJECT_ID: 399
; start printing object, unique label id: 399
M624 AgAAAAAAAAA=
M204 S250
M204 S10000
G17
G3 Z5.1 I-1.032 J-.645 P1  F30000
G1 X206.119 Y202.292 Z5.1
M204 S10000
G1 Z4.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F1705
M204 S500
G1 X206.033 Y202.45 E.00553
G1 X206.033 Y202.711 E.00803
G1 X203.455 Y202.711 E.07922
G1 X203.003 Y202.426 E.01641
G1 X203.003 Y200.631 E.05516
G1 X206.033 Y200.631 E.0931
G1 X206.033 Y201.043 E.01264
G1 X206.072 Y201.158 E.00373
G1 X206.222 Y201.231 E.00512
G1 X208.425 Y201.227 E.06769
G1 X208.917 Y201.122 E.01547
G1 X209.385 Y200.875 E.01626
G1 X209.757 Y200.515 E.0159
G1 X210.024 Y200.046 E.01657
G1 X210.146 Y199.523 E.01652
G1 X210.114 Y199.003 E.01602
G1 X209.937 Y198.504 E.01625
G1 X209.625 Y198.075 E.0163
G1 X209.207 Y197.753 E.0162
G1 X208.714 Y197.561 E.01625
G1 X208.294 Y197.511 E.01302
G1 X206.654 Y197.511 E.05038
G1 X206.657 Y196.714 E.0245
G1 X206.725 Y196.44 E.00868
G3 X207.055 Y196.235 I.378 J.241 E.01235
G1 X211.055 Y196.235 E.12291
G3 X211.475 Y196.303 I.073 J.886 E.01318
G1 X211.612 Y196.44 E.00596
G1 X211.679 Y196.714 E.00868
G1 X211.683 Y206.714 E.30726
; object ids of layer 58 start: 399
M624 AgAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; object ids of this layer58 end: 399
M625
G3 X211.635 Y207.06 I-.992 J.039 E.01079
G1 X211.515 Y207.211 E.00594
G1 X211.232 Y207.311 E.00921
G1 X207.137 Y207.307 E.12583
G1 X206.862 Y207.24 E.0087
G3 X206.657 Y206.909 I.241 J-.378 E.01235
G1 X206.654 Y205.981 E.02853
G1 X208.413 Y205.977 E.05405
G1 X208.917 Y205.872 E.01584
G1 X209.385 Y205.625 E.01626
G1 X209.764 Y205.256 E.01624
G1 X210.025 Y204.796 E.01625
G1 X210.146 Y204.273 E.0165
G1 X210.114 Y203.753 E.01602
G1 X209.937 Y203.254 E.01625
G1 X209.626 Y202.826 E.01625
G1 X209.207 Y202.503 E.01625
G1 X208.714 Y202.311 E.01625
G1 X208.294 Y202.261 E.01302
G1 X206.294 Y202.261 E.06145
G2 X206.175 Y202.27 I-.035 J.314 E.00367
; WIPE_START
G1 F3600
M204 S1000
G1 X206.033 Y202.45 E-.08699
G1 X206.033 Y202.711 E-.09936
G1 X204.524 Y202.711 E-.57366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X210.56 Y198.041 Z5.3 F30000
G1 X211.472 Y197.336 Z5.3
G1 Z4.9
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1705
M204 S2000
G1 X210.579 Y196.443 E.0388
G1 X210.046 Y196.443
G1 X211.472 Y197.869 E.06198
G1 X211.472 Y198.402
G1 X209.513 Y196.443 E.08516
G1 X208.979 Y196.443
G1 X211.473 Y198.936 E.10834
G1 X211.473 Y199.469
G1 X208.446 Y196.443 E.13152
G1 X207.913 Y196.443
G1 X208.881 Y197.41 E.04205
G1 X208.241 Y197.304
G1 X207.38 Y196.443 E.03743
G1 X206.931 Y196.527
G1 X207.708 Y197.304 E.03376
G1 E-.8 F1800
M204 S10000
G1 X210.267 Y198.797 Z5.3 F30000
G1 Z4.9
G1 E.8 F1800
G1 F1705
M204 S2000
G1 X211.473 Y200.003 E.0524
G1 X211.473 Y200.536
G1 X210.352 Y199.415 E.04873
G1 X210.281 Y199.878
G1 X211.474 Y201.07 E.05181
G1 X211.474 Y201.603
G1 X210.139 Y200.268 E.05801
G1 X209.945 Y200.608
G1 X211.474 Y202.137 E.06644
G1 X211.474 Y202.67
G1 X209.684 Y200.88 E.07778
G1 X209.383 Y201.112
G1 X211.474 Y203.204 E.09088
G1 X211.475 Y203.737
G1 X209.035 Y201.297 E.10603
G1 X208.601 Y201.397
G1 X211.475 Y204.271 E.12487
G1 X211.475 Y204.804
G1 X210.297 Y203.626 E.05121
G1 X210.355 Y204.217
G1 X211.475 Y205.337 E.04869
G1 X211.475 Y205.871
G1 X210.271 Y204.666 E.05234
G1 X210.122 Y205.051
G1 X211.476 Y206.404 E.05883
G1 X211.455 Y206.917
G1 X209.924 Y205.386 E.06653
G1 X209.659 Y205.655
G1 X211.102 Y207.098 E.06271
G1 X210.569 Y207.098
G1 X209.351 Y205.88 E.05294
G1 X208.999 Y206.061
G1 X210.037 Y207.098 E.0451
G1 X209.504 Y207.099
G1 X208.56 Y206.155 E.041
G1 X208.057 Y206.185
G1 X208.971 Y207.099 E.03971
G1 X208.438 Y207.099
G1 X207.525 Y206.186 E.03967
G1 X206.993 Y206.188
G1 X207.905 Y207.1 E.03963
G1 X207.372 Y207.1
G1 X206.863 Y206.591 E.02209
G1 E-.8 F1800
M204 S10000
G1 X208.789 Y202.118 Z5.3 F30000
G1 Z4.9
G1 E.8 F1800
G1 F1705
M204 S2000
G1 X208.106 Y201.435 E.02968
G1 X207.573 Y201.436
G1 X208.192 Y202.054 E.02688
G1 X207.659 Y202.054
G1 X207.041 Y201.436 E.02686
G1 X206.508 Y201.437
G1 X207.126 Y202.055 E.02685
G1 X206.593 Y202.055
G1 X205.377 Y200.839 E.05286
G1 X204.843 Y200.839
G1 X206.092 Y202.088 E.05427
G1 X205.849 Y202.378
G1 X204.31 Y200.839 E.06688
G1 X203.777 Y200.839
G1 X205.442 Y202.504 E.07236
G1 X204.909 Y202.504
G1 X203.244 Y200.839 E.07236
G1 X203.211 Y201.339
G1 X204.376 Y202.504 E.05063
G1 X203.842 Y202.504
G1 X203.211 Y201.872 E.02746
M204 S10000
G1 X203.558 Y202.523 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.122986
G1 F1705
M204 S1000
G1 X203.375 Y202.375 E.00153
; LINE_WIDTH: 0.158764
G1 X203.192 Y202.228 E.00222
G1 E-.8 F1800
M204 S10000
G1 X208.52 Y201.478 Z5.3 F30000
G1 Z4.9
G1 E.8 F1800
; LINE_WIDTH: 0.0947478
G1 F1705
M204 S1000
G1 X208.359 Y201.421 E.00072
; WIPE_START
G1 F3600
G1 X208.52 Y201.478 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X208.469 Y201.591 Z5.3 F30000
G1 X208.469 Y201.591
G1 X207.054 Y207.107
G1 Z4.9
G1 E.8 F1800
; LINE_WIDTH: 0.125316
G1 F1705
M204 S1000
G1 X206.857 Y206.91 E.00187
G1 E-.8 F1800
M204 S10000
G1 X211.451 Y206.944 Z5.3 F30000
G1 Z4.9
G1 E.8 F1800
; LINE_WIDTH: 0.0933957
G1 F1705
M204 S1000
G3 X211.3 Y207.072 I-.305 J-.207 E.00083
; LINE_WIDTH: 0.123724
G1 X211.265 Y207.066 E.00023
; LINE_WIDTH: 0.156532
G1 X211.173 Y207.028 E.00093
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F3600
G1 X211.265 Y207.066 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.3 I1.217 J0 P1  F30000
; stop printing object, unique label id: 399
M625
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20240528 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z5.4 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z104.9 F600
    G1 Z102.9

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0
;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A0 B20 L100 C37 D20 M40 E42 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C46 D10 M80 E46 F10 N80
M1006 A44 B20 L100 C39 D20 M60 E48 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C48 D10 M60 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M60 E0 F10  N100
M1006 A49 B20 L100 C44 D20 M100 E41 F20 N100
M1006 A0 B20 L100 C0 D20 M60 E0 F20 N100
M1006 A0 B20 L100 C37 D20 M30 E37 F20 N60
M1006 W

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M960 S5 P0 ; turn off logo lamp
M73 P100 R0
; EXECUTABLE_BLOCK_END

