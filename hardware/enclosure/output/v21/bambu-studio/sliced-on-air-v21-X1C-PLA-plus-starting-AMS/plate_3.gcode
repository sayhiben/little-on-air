; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 43m 36s; total estimated time: 51m 56s
; total layer number: 24
; total filament length [mm] : 3001.18,435.48
; total filament volume [cm^3] : 7218.68,1047.45
; total filament weight [g] : 8.95,1.30
; filament_density: 1.24,1.24
; filament_diameter: 1.75,1.75
; max_z_height: 2.50
; filament: 1,2
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,0
; additional_cooling_fan_speed = 0,0
; additional_fan_full_speed_layer = 0,0
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
; chamber_temperatures = 0,0
; change_filament_gcode = ;=X1 20251031=\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == \"PETG\"}\nM109 S260\n{elsif filament_type[next_extruder] == \"PVA\"}\nM109 S210\n{else}\nM109 S{flush_temperatures[next_extruder]}\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200,200
; close_additional_fan_first_x_layers = 1,1
; close_fan_the_first_x_layers = 1,1
; complete_print_exhaust_fan_speed = 70,70
; cool_plate_temp = 35,35
; cool_plate_temp_initial_layer = 35,35
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10,10
; cooling_slowdown_logic = uniform_cooling,uniform_cooling
; counter_coef_1 = 0,0
; counter_coef_2 = 0.008,0.008
; counter_coef_3 = -0.041,-0.041
; counter_limit_max = 0.033,0.033
; counter_limit_min = -0.035,-0.035
; counterbore_hole_bridging = none
; curr_bed_type = Textured PEI Plate
; default_acceleration = 3000
; default_ams_type = -1
; default_filament_colour = ;
; default_filament_profile = "Bambu PLA Basic @BBL X1C"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50,50
; different_settings_to_system = bottom_shell_layers;bridge_speed;brim_object_gap;brim_type;brim_width;default_acceleration;enable_prime_tower;enable_support;flush_into_infill;flush_into_objects;flush_into_support;gap_infill_speed;initial_layer_infill_speed;initial_layer_print_height;initial_layer_speed;inner_wall_speed;internal_solid_infill_speed;layer_height;outer_wall_acceleration;outer_wall_speed;sparse_infill_density;sparse_infill_pattern;sparse_infill_speed;support_interface_bottom_layers;support_interface_spacing;support_interface_top_layers;support_style;support_type;top_shell_layers;top_surface_speed;wall_generator;wall_loops;;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70,70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1,1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0,0
; enable_prime_tower = 1
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 0,0
; eng_plate_temp_initial_layer = 0,0
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
; fan_cooling_layer_time = 100,100
; fan_direction = left
; fan_max_speed = 100,100
; fan_min_speed = 100,100
; farthest_point_timelapse = 1
; filament_adaptive_volumetric_speed = 0,0
; filament_adhesiveness_category = 100,100
; filament_bridge_speed = 25,25
; filament_change_length = 10,10
; filament_change_length_nc = 10,10
; filament_colour = #161616;#FFFFFF
; filament_colour_type = 0;0
; filament_cooling_before_tower = 0,0
; filament_cost = 20,20
; filament_density = 1.24,1.24
; filament_dev_ams_drying_ams_limitations = 1;0
; filament_dev_ams_drying_heat_distortion_temperature = 45,45
; filament_dev_ams_drying_temperature = 45,45,45,45
; filament_dev_ams_drying_time = 12,12,12,12
; filament_dev_chamber_drying_bed_temperature = 70,70
; filament_dev_chamber_drying_time = 12,12
; filament_dev_drying_cooling_temperature = 45,45
; filament_dev_drying_softening_temperature = 50,50
; filament_diameter = 1.75,1.75
; filament_enable_overhang_speed = 1,1
; filament_end_gcode = "; filament end gcode \n\n";"; filament end gcode \n\n"
; filament_extruder_compatibility = 0,0
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.98,0.98
; filament_flush_temp = 0,0
; filament_flush_temp_fast = 0,0
; filament_flush_volumetric_speed = 0,0
; filament_ids = GFL99;GFL99
; filament_is_mixed = 0,0
; filament_is_support = 0,0
; filament_map = 1,1
; filament_map_2 = 0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 12,12
; filament_metal_stickiness = None,None
; filament_minimal_purge_on_wipe_tower = 15,15
; filament_mixed_components = ;
; filament_mixed_gradient = 0,0
; filament_mixed_gradient_curve = ;
; filament_mixed_gradient_per_part = 0,0
; filament_mixed_gradient_range = ;
; filament_mixed_sublayer_ratios = ;
; filament_multi_colour = #161616;#FFFFFF
; filament_notes = PLA+ uses Generic PLA as a starting point. Set spool maker temperatures and calibrate before printing.,PLA+ uses Generic PLA as a starting point. Set spool maker temperatures and calibrate before printing.
; filament_nozzle_map = 0,0
; filament_overhang_1_4_speed = 0,0
; filament_overhang_2_4_speed = 50,50
; filament_overhang_3_4_speed = 30,30
; filament_overhang_4_4_speed = 10,10
; filament_overhang_totally_speed = 10,10
; filament_pre_cooling_temperature = 0,0
; filament_pre_cooling_temperature_nc = 0,0
; filament_preheat_temperature_delta = 0,0
; filament_prime_volume = 45,45
; filament_prime_volume_nc = 60,60
; filament_printable = 3,3
; filament_ramming_travel_time = 0,0
; filament_ramming_travel_time_nc = 0,0
; filament_ramming_volumetric_speed = -1,-1
; filament_ramming_volumetric_speed_nc = -1,-1
; filament_retract_length_nc = 14,14
; filament_scarf_gap = 15%,15%
; filament_scarf_height = 10%,10%
; filament_scarf_length = 10,10
; filament_scarf_seam_type = none,none
; filament_self_index = 1,2
; filament_settings_id = "Generic PLA";"Generic PLA"
; filament_shrink = 100%,100%
; filament_soluble = 0,0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10,10
; filament_tower_interface_pre_extrusion_length = 0,0
; filament_tower_interface_print_temp = -1,-1
; filament_tower_interface_purge_volume = 20,20
; filament_tower_ironing_area = 4,4
; filament_type = PLA;PLA
; filament_velocity_adaptation_factor = 1,1
; filament_vendor = Generic;Generic
; filament_volume_map = 0,0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0,0
; first_x_layer_part_fan_speed = 0,0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 0
; flush_multiplier = 1
; flush_multiplier_fast = 1.2
; flush_volumes_matrix = 0,700,220,0
; flush_volumes_vector = 140,140,140,140
; full_fan_speed_layer = 0,0
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
; hole_coef_1 = 0,0
; hole_coef_2 = -0.008,-0.008
; hole_coef_3 = 0.23415,0.23415
; hole_limit_max = 0.22,0.22
; hole_limit_min = 0.088,0.088
; host_type = octoprint
; hot_plate_temp = 55,55
; hot_plate_temp_initial_layer = 55,55
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10,10
; independent_support_layer_height = 0
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = "0.20mm Standard @BBL X1C";;;
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 40
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 25
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
; ironing_fan_speed = -1,-1
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
; long_retractions_when_ec = 0,0
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
; no_slow_down_for_cooling_on_outwalls = 0,0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 220,220
; nozzle_temperature_initial_layer = 220,220
; nozzle_temperature_range_high = 240,240
; nozzle_temperature_range_low = 190,190
; nozzle_type = hardened_steel
; nozzle_volume = 107
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 1500
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 60
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100,100
; overhang_fan_threshold = 50%,50%
; overhang_threshold_participating_cooling = 95%,95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0,0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0,0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02,0.02
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
; print_sequence = by layer
; print_settings_id = ON AIR v2.1 PLA-plus-starting - calibrate actual spool and fit coupons
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
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1,1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3,3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0,0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 1
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
; slow_down_for_layer_cooling = 1,1
; slow_down_layer_time = 8,8
; slow_down_min_speed = 20,20
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
; supertack_plate_temp = 45,45
; supertack_plate_temp_initial_layer = 45,45
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
; support_interface_top_layers = 3
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
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = snug
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = normal(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45,45
; template_custom_gcode = 
; textured_plate_temp = 55,55
; textured_plate_temp_initial_layer = 55,55
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
; volumetric_speed_coefficients = "0 0 0 0 0 0";"0 0 0 0 0 0"
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
; wipe_tower_x = 22,22,22
; wipe_tower_y = 185,185,185
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
M73 P0 R51
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


;=========register first layer scan=====
M977 S1 P60


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
M620.1 E F299.339 T240

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
M73 P1 R51
G1 E50 F200
M400
M104 S220
G92 E0
M73 P9 R47
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P10 R46
G1 E-0.5 F300

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
    G29 A X18.7746 Y107.022 I163.204 J112.753
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


;start heatbed  scan====================================
M976 S2 P1
G90
G1 X128 Y128 F20000
M976 S3 P2  ;register void printing detection


;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
M73 P11 R46
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
    
        
            M204 S1500
        
    
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
M73 P11 R45
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
M73 P12 R45
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
M73 P13 R45
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
M73 P13 R44
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
M204 S10000
G1 Z.6 F30000
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/24
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
G1 X51.016 Y211.534 F30000
M204 S6000
G1 Z1
G1 Z.2
G1 E.8 F1800
; LAYER_HEIGHT: 0.200000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S500
G1  X24.516 Y211.534  E1.0072 F1500
G1  Y185.534  E0.9882
G1  X51.016  E1.0072
G1  Y211.534  E0.9882
M204 S6000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #2
M204 S500
G1  Y186.034  E0.0190
G1  X50.516  E0.9502
G1  Y186.534  E0.0190
G1  X25.016  E0.9692
G1  Y187.034  E0.0190
G1  X50.516  E0.9692
G1  Y187.534  E0.0190
G1  X25.016  E0.9692
G1  Y188.034  E0.0190
G1  X50.516  E0.9692
G1  Y188.534  E0.0190
G1  X25.016  E0.9692
G1  Y189.034  E0.0190
G1  X50.516  E0.9692
G1  Y189.534  E0.0190
G1  X25.016  E0.9692
G1  Y190.034  E0.0190
G1  X50.516  E0.9692
G1  Y190.534  E0.0190
G1  X25.016  E0.9692
G1  Y191.034  E0.0190
G1  X50.516  E0.9692
G1  Y191.534  E0.0190
G1  X25.016  E0.9692
G1  Y192.034  E0.0190
M73 P14 R44
G1  X50.516  E0.9692
G1  Y192.534  E0.0190
G1  X25.016  E0.9692
G1  Y193.034  E0.0190
G1  X50.516  E0.9692
G1  Y193.534  E0.0190
G1  X25.016  E0.9692
G1  Y194.034  E0.0190
G1  X50.516  E0.9692
G1  Y194.534  E0.0190
G1  X25.016  E0.9692
G1  Y195.034  E0.0190
G1  X50.516  E0.9692
G1  Y195.534  E0.0190
G1  X25.016  E0.9692
M73 P15 R44
G1  Y196.034  E0.0190
G1  X50.516  E0.9692
G1  Y196.534  E0.0190
G1  X25.016  E0.9692
G1  Y197.034  E0.0190
G1  X50.516  E0.9692
G1  Y197.534  E0.0190
G1  X25.016  E0.9692
G1  Y198.034  E0.0190
M73 P15 R43
G1  X50.516  E0.9692
G1  Y198.534  E0.0190
G1  X25.016  E0.9692
G1  Y199.034  E0.0190
G1  X50.516  E0.9692
G1  Y199.534  E0.0190
G1  X25.016  E0.9692
G1  Y200.034  E0.0190
G1  X50.516  E0.9692
G1  Y200.534  E0.0190
G1  X25.016  E0.9692
G1  Y201.034  E0.0190
G1  X50.516  E0.9692
G1  Y201.534  E0.0190
G1  X25.016  E0.9692
G1  Y202.034  E0.0190
G1  X50.516  E0.9692
G1  Y202.534  E0.0190
G1  X25.016  E0.9692
G1  Y203.034  E0.0190
G1  X50.516  E0.9692
G1  Y203.534  E0.0190
G1  X25.016  E0.9692
G1  Y204.034  E0.0190
G1  X50.516  E0.9692
G1  Y204.534  E0.0190
G1  X25.016  E0.9692
G1  Y205.034  E0.0190
G1  X50.516  E0.9692
G1  Y205.534  E0.0190
G1  X25.016  E0.9692
G1  Y206.034  E0.0190
G1  X50.516  E0.9692
G1  Y206.534  E0.0190
G1  X25.016  E0.9692
G1  Y207.034  E0.0190
G1  X50.516  E0.9692
M73 P16 R43
G1  Y207.534  E0.0190
G1  X25.016  E0.9692
G1  Y208.034  E0.0190
G1  X50.516  E0.9692
G1  Y208.534  E0.0190
G1  X25.016  E0.9692
G1  Y209.034  E0.0190
G1  X50.516  E0.9692
G1  Y209.534  E0.0190
G1  X25.016  E0.9692
G1  Y210.034  E0.0190
G1  X50.516  E0.9692
G1  Y210.534  E0.0190
G1  X25.016  E0.9692
G1  Y211.034  E0.0190
G1  X50.516  E0.9692
G1  Y211.534  E0.0190
; CP EMPTY GRID END
;------------------






M204 S6000
G1  X51.516 Y212.534  
M204 S500
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.1194
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.1140
G2  X43.954 Y212.534   I-2.561 J3.843 E0.1029
G2  X31.397 Y212.538   I-6.188 J319.311 E0.4773
G2  X27.709 Y214.366   I0.466 J5.574 E0.1602
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0908
G3  X22.340 Y210.825   I15.914 J-18.906 E0.1708
G3  X23.138 Y207.675   I2.197 J-1.120 E0.1348
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.1098
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.4773
G2  X22.184 Y188.727   I-5.574 J0.466 E0.1602
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0908
G1  X24.016 Y185.034   E0.0796
G3  X26.400 Y183.047   I4.714 J3.233 E0.1194
G3  X29.023 Y184.259   I0.130 J3.164 E0.1140
G2  X31.578 Y185.034   I2.561 J-3.843 E0.1029
G2  X44.135 Y185.030   I6.188 J-319.311 E0.4773
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.1602
G3  X48.837 Y183.000   I0.873 J1.736 E0.0398
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0511
G1  X51.516 Y185.034   E0.0796
G3  X53.503 Y187.418   I-3.233 J4.714 E0.1194
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0284
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.1065
G2  X51.516 Y192.596   I4.225 J2.118 E0.0823
G2  X51.520 Y205.153   I319.311 J6.188 E0.4773
G2  X53.348 Y208.841   I5.574 J-0.466 E0.1602
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0908
G1  X51.516 Y212.534   E0.0796
M204 S6000
G1  X53.327 Y211.369  
M204 S500
G3  X50.076 Y214.580   I-19.083 J-16.073 E0.1739
G3  X46.389 Y213.782   I-1.423 J-2.345 E0.1581
G2  X43.950 Y212.991   I-2.455 J3.414 E0.0990
G2  X31.415 Y212.994   I-6.184 J318.875 E0.4764
G2  X27.917 Y214.773   I0.719 J5.743 E0.1522
G3  X25.181 Y214.345   I-1.066 J-2.142 E0.1122
G3  X21.970 Y211.094   I16.074 J-19.083 E0.1739
G3  X22.768 Y207.407   I2.345 J-1.423 E0.1581
G2  X23.559 Y204.968   I-3.414 J-2.455 E0.0990
M73 P17 R43
G2  X23.556 Y192.433   I-318.875 J-6.184 E0.4764
G2  X21.777 Y188.935   I-5.743 J0.719 E0.1522
G3  X22.205 Y186.199   I2.142 J-1.066 E0.1122
G3  X25.456 Y182.988   I19.086 J16.077 E0.1739
G3  X29.143 Y183.786   I1.423 J2.345 E0.1581
G2  X31.582 Y184.577   I2.455 J-3.414 E0.0990
G2  X44.117 Y184.574   I6.184 J-318.875 E0.4764
G2  X47.615 Y182.795   I-0.719 J-5.743 E0.1522
G3  X48.873 Y182.544   I1.082 J2.153 E0.0493
G3  X50.351 Y183.223   I-0.197 J2.380 E0.0631
G3  X53.562 Y186.474   I-16.081 J19.090 E0.1739
G3  X52.764 Y190.161   I-2.345 J1.423 E0.1581
M73 P17 R42
G2  X51.973 Y192.600   I3.414 J2.455 E0.0990
G2  X51.976 Y205.135   I318.875 J6.184 E0.4764
G2  X53.755 Y208.633   I5.743 J-0.719 E0.1522
G3  X53.833 Y210.610   I-2.125 J1.073 E0.0775
G3  X53.327 Y211.369   I-2.258 J-0.955 E0.0349
M204 S6000
G1  X53.657 Y211.686  
M204 S500
G3  X50.345 Y214.950   I-19.312 J-16.285 E0.1770
G3  X46.120 Y214.152   I-1.704 J-2.560 E0.1809
G2  X43.946 Y213.448   I-2.185 J3.038 E0.0883
G2  X31.433 Y213.451   I-6.180 J318.401 E0.4756
G2  X28.124 Y215.181   I1.116 J6.164 E0.1441
G3  X24.864 Y214.675   I-1.273 J-2.557 E0.1337
G3  X21.600 Y211.363   I16.285 J-19.313 E0.1770
G3  X22.398 Y207.138   I2.560 J-1.704 E0.1809
G2  X23.102 Y204.964   I-3.038 J-2.185 E0.0883
G2  X23.099 Y192.451   I-318.401 J-6.180 E0.4756
G2  X21.369 Y189.142   I-6.164 J1.116 E0.1441
G3  X21.875 Y185.882   I2.557 J-1.273 E0.1337
G3  X25.187 Y182.618   I19.318 J16.290 E0.1770
G3  X29.412 Y183.416   I1.704 J2.560 E0.1809
G2  X31.586 Y184.120   I2.184 J-3.038 E0.0883
G2  X44.099 Y184.117   I6.180 J-318.401 E0.4756
G2  X47.407 Y182.387   I-1.116 J-6.164 E0.1441
G3  X48.909 Y182.088   I1.292 J2.570 E0.0589
G3  X50.668 Y182.893   I-0.235 J2.838 E0.0750
G3  X53.932 Y186.205   I-16.290 J19.317 E0.1770
G3  X53.134 Y190.430   I-2.560 J1.704 E0.1809
G2  X52.430 Y192.604   I3.038 J2.184 E0.0883
G2  X52.433 Y205.117   I318.401 J6.180 E0.4756
G2  X54.163 Y208.425   I6.164 J-1.116 E0.1441
G3  X54.256 Y210.785   I-2.536 J1.281 E0.0925
G3  X53.657 Y211.686   I-2.690 J-1.137 E0.0414
M204 S6000
G1  X53.986 Y212.003  
M204 S500
G3  X50.614 Y215.320   I-19.569 J-16.524 E0.1800
G3  X45.747 Y214.449   I-1.972 J-3.016 E0.2071
G2  X43.941 Y213.905   I-1.798 J2.700 E0.0727
G2  X31.451 Y213.908   I-6.175 J317.945 E0.4747
G2  X28.557 Y215.463   I0.598 J4.585 E0.1277
G3  X24.547 Y215.004   I-1.710 J-2.804 E0.1652
G3  X21.230 Y211.632   I16.525 J-19.570 E0.1800
G3  X22.101 Y206.765   I3.016 J-1.972 E0.2071
G2  X22.645 Y204.959   I-2.700 J-1.798 E0.0727
G2  X22.642 Y192.469   I-317.945 J-6.175 E0.4747
G2  X21.087 Y189.575   I-4.585 J0.598 E0.1277
G3  X21.546 Y185.565   I2.804 J-1.710 E0.1652
G3  X24.918 Y182.248   I19.568 J16.523 E0.1800
G3  X29.785 Y183.119   I1.972 J3.016 E0.2071
M73 P18 R42
G2  X31.591 Y183.663   I1.798 J-2.700 E0.0727
G2  X44.081 Y183.660   I6.175 J-317.945 E0.4747
G2  X46.975 Y182.105   I-0.598 J-4.586 E0.1277
G3  X48.945 Y181.632   I1.764 J3.008 E0.0781
G3  X50.985 Y182.564   I-0.273 J3.297 E0.0870
G3  X54.302 Y185.936   I-16.530 J19.575 E0.1800
G3  X54.445 Y189.575   I-2.666 J1.927 E0.1467
G2  X52.887 Y192.609   I2.836 J3.373 E0.1331
G2  X52.890 Y205.099   I317.945 J6.175 E0.4747
G2  X54.445 Y207.993   I4.586 J-0.598 E0.1277
G3  X53.986 Y212.003   I-2.804 J1.710 E0.1652
M204 S6000
G1  X54.316 Y212.320  
M204 S500
G3  X50.883 Y215.690   I-19.844 J-16.781 E0.1831
G3  X45.402 Y214.771   I-2.217 J-3.581 E0.2307
G2  X43.937 Y214.362   I-1.465 J2.421 E0.0585
G2  X31.469 Y214.365   I-6.171 J317.464 E0.4739
G2  X28.796 Y215.853   I0.734 J4.465 E0.1186
G3  X24.230 Y215.334   I-1.949 J-3.195 E0.1880
G3  X20.860 Y211.901   I16.785 J-19.848 E0.1831
G3  X21.779 Y206.420   I3.581 J-2.217 E0.2307
G2  X22.188 Y204.955   I-2.421 J-1.465 E0.0585
G2  X22.185 Y192.487   I-317.515 J-6.171 E0.4739
G2  X20.697 Y189.814   I-4.465 J0.734 E0.1186
G3  X21.216 Y185.248   I3.195 J-1.949 E0.1880
G3  X24.649 Y181.878   I19.843 J16.781 E0.1831
G3  X30.130 Y182.797   I2.217 J3.581 E0.2307
G2  X31.595 Y183.206   I1.465 J-2.421 E0.0585
G2  X44.063 Y183.203   I6.171 J-317.515 E0.4739
G2  X46.736 Y181.715   I-0.734 J-4.466 E0.1186
G3  X48.981 Y181.176   I2.010 J3.427 E0.0890
G3  X51.302 Y182.234   I-0.310 J3.756 E0.0989
G3  X54.672 Y185.667   I-16.784 J19.847 E0.1831
G3  X54.835 Y189.814   I-3.039 J2.196 E0.1671
G2  X53.344 Y192.613   I2.892 J3.336 E0.1233
G2  X53.347 Y205.081   I317.464 J6.171 E0.4739
G2  X54.835 Y207.754   I4.465 J-0.734 E0.1186
G3  X54.316 Y212.320   I-3.195 J1.949 E0.1880
M204 S6000
G1  X54.645 Y212.637  
M204 S500
G3  X51.152 Y216.060   I-20.137 J-17.057 E0.1862
G3  X45.084 Y215.115   I-2.487 J-3.980 E0.2544
G2  X43.932 Y214.819   I-1.136 J2.038 E0.0457
G2  X31.488 Y214.822   I-6.166 J316.919 E0.4730
G2  X29.035 Y216.243   I0.899 J4.379 E0.1096
G3  X23.913 Y215.663   I-2.188 J-3.586 E0.2109
G3  X20.490 Y212.170   I17.055 J-20.135 E0.1862
G3  X21.435 Y206.103   I3.980 J-2.487 E0.2544
G2  X21.731 Y204.950   I-2.038 J-1.137 E0.0457
G2  X21.728 Y192.506   I-317.090 J-6.166 E0.4730
G2  X20.307 Y190.053   I-4.379 J0.899 E0.1096
G3  X20.887 Y184.931   I3.586 J-2.188 E0.2109
G3  X24.381 Y181.508   I20.126 J17.046 E0.1862
G3  X30.447 Y182.453   I2.487 J3.980 E0.2544
G2  X31.600 Y182.749   I1.137 J-2.038 E0.0457
G2  X44.044 Y182.746   I6.166 J-317.033 E0.4730
G2  X46.497 Y181.325   I-0.899 J-4.379 E0.1096
G3  X49.016 Y180.720   I2.256 J3.847 E0.0999
G3  X51.619 Y181.905   I-0.348 J4.216 E0.1108
G3  X55.042 Y185.399   I-17.052 J20.132 E0.1862
G3  X54.097 Y191.465   I-3.980 J2.487 E0.2544
G2  X53.801 Y192.618   I2.038 J1.137 E0.0457
G2  X53.804 Y205.062   I316.976 J6.166 E0.4730
G2  X55.225 Y207.515   I4.379 J-0.899 E0.1096
G3  X55.386 Y211.609   I-3.600 J2.191 E0.1626
G3  X54.645 Y212.637   I-4.879 J-2.733 E0.0483
M204 S6000
G1  X54.975 Y212.953  
M204 S500
G3  X51.420 Y216.430   I-20.433 J-17.335 E0.1892
G3  X44.797 Y215.479   I-2.756 J-4.349 E0.2769
G2  X43.928 Y215.276   I-0.858 J1.714 E0.0342
G2  X31.506 Y215.278   I-6.162 J316.383 E0.4722
G2  X29.274 Y216.633   I1.088 J4.310 E0.1007
G3  X23.596 Y215.993   I-2.426 J-3.977 E0.2337
G3  X20.120 Y212.438   I17.330 J-20.428 E0.1892
G3  X21.071 Y205.815   I4.348 J-2.756 E0.2768
G2  X21.274 Y204.946   I-1.714 J-0.858 E0.0342
G2  X21.272 Y192.524   I-316.675 J-6.162 E0.4722
G2  X19.917 Y190.292   I-4.310 J1.089 E0.1007
G3  X20.557 Y184.614   I3.977 J-2.426 E0.2337
G3  X24.112 Y181.138   I20.422 J17.325 E0.1892
G3  X30.735 Y182.089   I2.756 J4.349 E0.2768
G2  X31.604 Y182.292   I0.858 J-1.714 E0.0342
G2  X44.026 Y182.290   I6.162 J-316.610 E0.4722
G2  X46.258 Y180.935   I-1.089 J-4.310 E0.1007
G3  X49.052 Y180.264   I2.502 J4.267 E0.1108
G3  X51.936 Y181.575   I-0.386 J4.675 E0.1228
G3  X55.412 Y185.130   I-17.332 J20.429 E0.1892
G3  X54.461 Y191.753   I-4.348 J2.756 E0.2768
G2  X54.258 Y192.622   I1.714 J0.858 E0.0342
G2  X54.260 Y205.044   I316.578 J6.162 E0.4722
G2  X55.615 Y207.276   I4.311 J-1.089 E0.1007
G3  X55.793 Y211.816   I-3.993 J2.430 E0.1803
G3  X54.975 Y212.954   I-5.415 J-3.034 E0.0534
M204 S6000
G1  X55.304 Y213.270  
M204 S500
G3  X51.689 Y216.800   I-20.735 J-17.620 E0.1923
G3  X44.540 Y215.863   I-3.026 J-4.651 E0.2983
G2  X43.924 Y215.733   I-0.594 J1.298 E0.0241
G2  X31.524 Y215.735   I-6.158 J315.934 E0.4713
G2  X29.513 Y217.023   I1.401 J4.402 E0.0918
G3  X23.280 Y216.322   I-2.665 J-4.368 E0.2566
G3  X19.750 Y212.707   I17.616 J-20.731 E0.1923
G3  X20.688 Y205.558   I4.652 J-3.026 E0.2983
G2  X20.817 Y204.942   I-1.298 J-0.593 E0.0241
G2  X20.815 Y192.542   I-316.349 J-6.158 E0.4713
G2  X19.527 Y190.531   I-4.403 J1.401 E0.0918
G3  X20.228 Y184.298   I4.368 J-2.665 E0.2566
G3  X23.843 Y180.768   I20.724 J17.610 E0.1923
G3  X30.992 Y181.705   I3.026 J4.652 E0.2983
G2  X31.608 Y181.835   I0.593 J-1.298 E0.0241
G2  X44.008 Y181.833   I6.158 J-316.274 E0.4713
G2  X46.019 Y180.545   I-1.408 J-4.414 E0.0918
G3  X49.088 Y179.808   I2.748 J4.687 E0.1217
G3  X52.252 Y181.246   I-0.423 J5.134 E0.1347
G1  X53.778 Y182.772   E0.0820
G3  X56.695 Y187.064   I-4.456 J6.164 E0.2013
G3  X54.823 Y192.060   I-6.238 J0.512 E0.2095
G2  X54.715 Y192.626   I1.365 J0.551 E0.0220
G2  X54.717 Y205.026   I316.348 J6.158 E0.4713
G2  X56.005 Y207.037   I4.416 J-1.410 E0.0918
G3  X56.201 Y212.024   I-4.385 J2.669 E0.1981
G3  X55.304 Y213.270   I-5.949 J-3.333 E0.0585
; WIPE_TOWER_END

; WIPE_START
G1 F24000
M204 S500
G1 X55.534 Y213.022 E-.12845
G1 X55.782 Y212.707 E-.15235
G1 X56.005 Y212.373 E-.15242
G1 X56.201 Y212.023 E-.15236
G1 X56.369 Y211.659 E-.15233
G1 X56.389 Y211.605 E-.02209
; WIPE_END
G1 E-.04 F1800
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S6000
G1 X78.628 Y146.704
G1 Z.2
G1 E.8 F1800
; FEATURE: Brim
; LINE_WIDTH: 0.5
; LAYER_HEIGHT: 0.2
G1 F1500
M204 S500
G1 X78.288 Y146.586 E.01338
G1 X77.953 Y146.398 E.01432
G1 X77.756 Y146.231 E.00962
G1 X74.772 Y143.247 E.15719
G1 X74.532 Y142.942 E.01446
G1 X74.375 Y142.618 E.01339
G1 X74.271 Y142.248 E.01432
G1 X74.25 Y141.991 E.00962
G1 X74.25 Y107.013 E1.30278
G1 X74.296 Y106.626 E.01452
G1 X74.384 Y106.361 E.01041
G1 X74.623 Y105.927 E.01846
G1 X74.875 Y105.663 E.01361
G1 X75.403 Y105.366 E.02254
G1 X75.782 Y105.266 E.0146
G1 X76.008 Y105.25 E.00844
G1 X179.987 Y105.25 E3.87281
G1 X180.371 Y105.295 E.01442
G1 X180.743 Y105.43 E.01475
G1 X181.071 Y105.621 E.01412
G1 X181.337 Y105.875 E.01372
G1 X181.634 Y106.403 E.02254
G1 X181.734 Y106.782 E.0146
G1 X181.75 Y107.008 E.00845
G1 X181.75 Y144.987 E1.41456
G1 X181.704 Y145.374 E.01452
G1 X181.616 Y145.639 E.01041
G1 X181.377 Y146.073 E.01846
G1 X181.125 Y146.337 E.01361
G1 X180.597 Y146.634 E.02254
G1 X180.218 Y146.734 E.0146
G1 X179.992 Y146.75 E.00845
M73 P19 R42
G1 X79.013 Y146.75 E3.76107
G1 X78.687 Y146.711 E.01223
M204 S6000
G1 X78.746 Y146.258 F30000
G1 F1500
M204 S500
G1 X78.488 Y146.172 E.01013
G1 X78.227 Y146.028 E.01109
G1 X78.071 Y145.898 E.00755
G1 X75.12 Y142.948 E.15542
G1 X74.931 Y142.71 E.01133
G1 X74.801 Y142.444 E.01102
G1 X74.726 Y142.18 E.01021
G1 X74.707 Y141.967 E.00796
G1 X74.707 Y107.048 E1.30061
G1 X74.743 Y106.74 E.01154
G1 X74.801 Y106.557 E.00717
G1 X74.986 Y106.215 E.01449
G1 X75.177 Y106.018 E.01022
G1 X75.593 Y105.789 E.01769
G1 X75.844 Y105.722 E.00968
G1 X76.029 Y105.707 E.0069
G1 X179.968 Y105.708 E3.87133
M73 P19 R41
G1 X180.25 Y105.741 E.01057
G1 X180.537 Y105.841 E.01134
G1 X180.78 Y105.981 E.01043
G1 X180.958 Y106.145 E.009
G1 X181.211 Y106.593 E.01918
G1 X181.278 Y106.844 E.00968
G1 X181.293 Y107.029 E.00691
G1 X181.293 Y144.952 E1.41248
G1 X181.257 Y145.26 E.01154
G1 X181.199 Y145.443 E.00717
G1 X181.014 Y145.785 E.01449
G1 X180.823 Y145.982 E.01022
G1 X180.407 Y146.211 E.01769
G1 X180.156 Y146.278 E.00968
G1 X179.971 Y146.293 E.00691
G1 X79.048 Y146.293 E3.75899
G1 X78.805 Y146.265 E.0091
M204 S6000
G1 X78.869 Y145.816 F30000
G1 F1500
M204 S500
G1 X78.829 Y145.81 E.0015
G1 X78.693 Y145.762 E.00536
G1 X78.531 Y145.678 E.00681
G1 X78.402 Y145.583 E.00598
G1 X75.416 Y142.598 E.15727
G1 X75.306 Y142.452 E.00679
G1 X75.244 Y142.322 E.00536
G1 X75.189 Y142.148 E.00681
G1 X75.164 Y141.989 E.00598
G1 X75.164 Y107.011 E1.30281
G1 X75.191 Y106.845 E.00626
G1 X75.249 Y106.67 E.00687
G1 X75.383 Y106.458 E.00934
G1 X75.485 Y106.36 E.00529
G1 X75.698 Y106.235 E.00918
G1 X76.01 Y106.164 E.01191
G1 X179.99 Y106.164 E3.87285
G1 X180.281 Y106.224 E.01105
G1 X180.372 Y106.264 E.0037
G1 X180.54 Y106.381 E.00763
G1 X180.64 Y106.485 E.0054
G1 X180.765 Y106.698 E.00918
G1 X180.836 Y107.01 E.01191
G1 X180.836 Y144.993 E1.41472
G1 X180.774 Y145.283 E.01105
G1 X180.736 Y145.372 E.00359
G1 X180.619 Y145.54 E.00763
G1 X180.515 Y145.64 E.0054
G1 X180.302 Y145.765 E.00918
G1 X179.99 Y145.836 E.01191
G1 X79.01 Y145.836 E3.76113
G1 X78.929 Y145.824 E.00305
M204 S6000
G1 X79 Y145.379 F30000
G1 F1500
M204 S500
G1 X78.913 Y145.361 E.00332
G1 X78.732 Y145.268 E.00756
G1 X75.732 Y142.268 E.15802
G1 X75.683 Y142.194 E.00332
G1 X75.621 Y142 E.00756
G1 X75.621 Y107 E1.30362
G1 X75.688 Y106.799 E.0079
G1 X75.814 Y106.677 E.00651
G1 X76 Y106.621 E.00722
G1 X180 Y106.621 E3.87361
G1 X180.091 Y106.641 E.00348
G1 X180.201 Y106.688 E.00447
G1 X180.323 Y106.814 E.00651
G1 X180.379 Y107 E.00722
G1 X180.379 Y145 E1.41536
G1 X180.359 Y145.091 E.00348
G1 X180.312 Y145.201 E.00447
G1 X180.186 Y145.323 E.00651
G1 X180 Y145.379 E.00722
G1 X79.06 Y145.379 E3.75963
; WIPE_START
G1 X78.913 Y145.361 E-.05642
G1 X78.732 Y145.268 E-.07714
G1 X77.567 Y144.102 E-.62644
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X85.199 Y144.036 Z.6 F30000
G1 X178.229 Y143.229 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.49999
G1 F1500
M204 S500
G1 X79.734 Y143.229 E3.66849
G1 X77.771 Y141.266 E.10337
G1 X77.771 Y108.771 E1.2103
G1 X178.229 Y108.771 E3.74158
G1 X178.229 Y126 E.64169
G1 X178.229 Y143.169 E.63946
M204 S6000
G1 X178.686 Y143.686 F30000
G1 F1500
M204 S500
G1 X79.544 Y143.686 E3.69257
G1 X77.314 Y141.456 E.11747
G1 X77.314 Y108.314 E1.23437
G1 X178.686 Y108.314 E3.77563
G1 X178.686 Y126 E.65872
G1 X178.686 Y143.626 E.65648
M204 S6000
G1 X179.143 Y144.143 F30000
G1 F1500
M204 S500
G1 X79.355 Y144.143 E3.71664
G1 X76.857 Y141.645 E.13157
G1 X76.857 Y107.857 E1.25845
G1 X179.143 Y107.857 E3.80968
G1 X179.143 Y126 E.67574
G1 X179.143 Y144.083 E.67351
M204 S6000
G1 X179.6 Y144.6 F30000
; FEATURE: Outer wall
G1 F1500
M204 S500
G1 X79.166 Y144.6 E3.74072
G1 X76.4 Y141.834 E.14568
G1 X76.4 Y107.4 E1.28252
G1 X179.6 Y107.4 E3.84373
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

G1 X179.6 Y126 E.69277
G1 X179.6 Y144.54 E.69053
; WIPE_START
G1 X177.6 Y144.541 E-.76
; WIPE_END
M73 P20 R41
G1 E-.04 F1800
M204 S6000
G1 X177.497 Y136.909 Z.6 F30000
G1 X177.118 Y108.954 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50186
G1 F2400
M204 S500
G1 X177.84 Y109.676 E.0382
G1 X177.84 Y110.325 E.02427
G1 X176.675 Y109.16 E.06165
G1 X176.026 Y109.16 E.02427
G1 X177.84 Y110.974 E.09597
G1 X177.84 Y111.623 E.02427
G1 X175.377 Y109.16 E.1303
G1 X174.728 Y109.16 E.02427
G1 X177.84 Y112.272 E.16463
G1 X177.84 Y112.921 E.02427
G1 X174.079 Y109.16 E.19895
G1 X173.429 Y109.16 E.02427
G1 X177.84 Y113.571 E.23328
G1 X177.84 Y114.22 E.02427
G1 X172.78 Y109.16 E.26761
G1 X172.131 Y109.16 E.02427
G1 X177.84 Y114.869 E.30193
G1 X177.84 Y115.518 E.02427
G1 X171.482 Y109.16 E.33626
G1 X170.833 Y109.16 E.02427
G1 X177.84 Y116.167 E.37059
G1 X177.84 Y116.816 E.02427
G1 X170.184 Y109.16 E.40491
G1 X169.535 Y109.16 E.02427
G1 X177.84 Y117.465 E.43924
G1 X177.84 Y118.114 E.02427
G1 X168.886 Y109.16 E.47357
G1 X168.237 Y109.16 E.02427
G1 X177.84 Y118.763 E.50789
G1 X177.84 Y119.412 E.02427
G1 X167.588 Y109.16 E.54222
G1 X166.939 Y109.16 E.02427
G1 X177.84 Y120.061 E.57655
G1 X177.84 Y120.71 E.02427
G1 X166.29 Y109.16 E.61087
G1 X165.641 Y109.16 E.02427
G1 X177.84 Y121.359 E.6452
G1 X177.84 Y122.008 E.02427
G1 X164.992 Y109.16 E.67953
G1 X164.343 Y109.16 E.02427
G1 X177.84 Y122.657 E.71385
G1 X177.84 Y123.306 E.02427
G1 X163.694 Y109.16 E.74818
G1 X163.045 Y109.16 E.02427
G1 X177.84 Y123.955 E.78251
G1 X177.84 Y124.604 E.02427
G1 X162.396 Y109.16 E.81683
G1 X161.747 Y109.16 E.02427
G1 X177.84 Y125.253 E.85116
G1 X177.84 Y125.902 E.02427
G1 X161.098 Y109.16 E.88549
G1 X160.449 Y109.16 E.02427
G1 X177.84 Y126.551 E.91981
G1 X177.84 Y127.2 E.02427
G1 X159.8 Y109.16 E.95414
G1 X159.151 Y109.16 E.02427
G1 X177.84 Y127.849 E.98847
G1 X177.84 Y128.498 E.02427
G1 X158.502 Y109.16 E1.02279
G1 X157.853 Y109.16 E.02427
G1 X177.84 Y129.147 E1.05712
G1 X177.84 Y129.796 E.02427
G1 X157.204 Y109.16 E1.09145
M73 P21 R41
G1 X156.554 Y109.16 E.02427
M73 P21 R40
G1 X177.84 Y130.446 E1.12577
G1 X177.84 Y131.095 E.02427
G1 X155.905 Y109.16 E1.1601
G1 X155.256 Y109.16 E.02427
G1 X177.84 Y131.744 E1.19443
G1 X177.84 Y132.393 E.02427
G1 X154.607 Y109.16 E1.22875
G1 X153.958 Y109.16 E.02427
G1 X177.84 Y133.042 E1.26308
G1 X177.84 Y133.691 E.02427
G1 X153.309 Y109.16 E1.29741
G1 X152.66 Y109.16 E.02427
G1 X177.84 Y134.34 E1.33173
G1 X177.84 Y134.989 E.02427
G1 X152.011 Y109.16 E1.36606
G1 X151.362 Y109.16 E.02427
G1 X177.84 Y135.638 E1.40039
G1 X177.84 Y136.287 E.02427
G1 X150.713 Y109.16 E1.43471
G1 X150.064 Y109.16 E.02427
G1 X177.84 Y136.936 E1.46904
M73 P22 R40
G1 X177.84 Y137.585 E.02427
G1 X149.415 Y109.16 E1.50337
G1 X148.766 Y109.16 E.02427
G1 X177.84 Y138.234 E1.53769
G1 X177.84 Y138.883 E.02427
G1 X148.117 Y109.16 E1.57202
G1 X147.468 Y109.16 E.02427
G1 X177.84 Y139.532 E1.60635
G1 X177.84 Y140.181 E.02427
G1 X146.819 Y109.16 E1.64067
G1 X146.17 Y109.16 E.02427
G1 X177.84 Y140.83 E1.675
G1 X177.84 Y141.479 E.02427
G1 X145.521 Y109.16 E1.70933
G1 X144.872 Y109.16 E.02427
G1 X177.84 Y142.128 E1.74365
G1 X177.84 Y142.777 E.02427
G1 X144.223 Y109.16 E1.77798
G1 X143.574 Y109.16 E.02427
G1 X177.254 Y142.84 E1.78131
G1 X176.605 Y142.84 E.02427
G1 X142.925 Y109.16 E1.78131
G1 X142.276 Y109.16 E.02427
G1 X175.956 Y142.84 E1.78131
G1 X175.307 Y142.84 E.02427
G1 X141.627 Y109.16 E1.78131
G1 X140.978 Y109.16 E.02427
G1 X174.658 Y142.84 E1.78131
G1 X174.009 Y142.84 E.02427
G1 X140.328 Y109.16 E1.78131
G1 X139.679 Y109.16 E.02427
G1 X173.36 Y142.84 E1.78131
G1 X172.711 Y142.84 E.02427
G1 X139.03 Y109.16 E1.78131
G1 X138.381 Y109.16 E.02427
G1 X172.062 Y142.84 E1.78131
G1 X171.413 Y142.84 E.02427
G1 X137.732 Y109.16 E1.78131
G1 X137.083 Y109.16 E.02427
G1 X170.764 Y142.84 E1.78131
G1 X170.115 Y142.84 E.02427
G1 X136.434 Y109.16 E1.78131
G1 X135.785 Y109.16 E.02427
G1 X169.466 Y142.84 E1.78131
G1 X168.817 Y142.84 E.02427
G1 X135.136 Y109.16 E1.78131
G1 X134.487 Y109.16 E.02427
G1 X168.168 Y142.84 E1.78131
G1 X167.519 Y142.84 E.02427
G1 X133.838 Y109.16 E1.78131
G1 X133.189 Y109.16 E.02427
G1 X166.87 Y142.84 E1.78131
G1 X166.221 Y142.84 E.02427
G1 X132.54 Y109.16 E1.78131
G1 X131.891 Y109.16 E.02427
G1 X165.572 Y142.84 E1.78131
G1 X164.923 Y142.84 E.02427
G1 X131.242 Y109.16 E1.78131
G1 X130.593 Y109.16 E.02427
G1 X164.273 Y142.84 E1.78131
G1 X163.624 Y142.84 E.02427
G1 X129.944 Y109.16 E1.78131
G1 X129.295 Y109.16 E.02427
G1 X162.975 Y142.84 E1.78131
G1 X162.326 Y142.84 E.02427
G1 X128.646 Y109.16 E1.78131
G1 X127.997 Y109.16 E.02427
G1 X161.677 Y142.84 E1.78131
G1 X161.028 Y142.84 E.02427
G1 X127.348 Y109.16 E1.78131
G1 X126.699 Y109.16 E.02427
G1 X160.379 Y142.84 E1.78131
G1 X159.73 Y142.84 E.02427
G1 X126.05 Y109.16 E1.78131
G1 X125.401 Y109.16 E.02427
G1 X159.081 Y142.84 E1.78131
G1 X158.432 Y142.84 E.02427
G1 X124.752 Y109.16 E1.78131
G1 X124.103 Y109.16 E.02427
G1 X157.783 Y142.84 E1.78131
G1 X157.134 Y142.84 E.02427
G1 X123.453 Y109.16 E1.78131
G1 X122.804 Y109.16 E.02427
G1 X156.485 Y142.84 E1.78131
G1 X155.836 Y142.84 E.02427
G1 X122.155 Y109.16 E1.78131
G1 X121.506 Y109.16 E.02427
G1 X155.187 Y142.84 E1.78131
G1 X154.538 Y142.84 E.02427
G1 X120.857 Y109.16 E1.78131
G1 X120.208 Y109.16 E.02427
G1 X153.889 Y142.84 E1.78131
M73 P23 R40
G1 X153.24 Y142.84 E.02427
M73 P23 R39
G1 X119.559 Y109.16 E1.78131
G1 X118.91 Y109.16 E.02427
G1 X152.591 Y142.84 E1.78131
G1 X151.942 Y142.84 E.02427
G1 X118.261 Y109.16 E1.78131
G1 X117.612 Y109.16 E.02427
G1 X151.293 Y142.84 E1.78131
G1 X150.644 Y142.84 E.02427
G1 X116.963 Y109.16 E1.78131
G1 X116.314 Y109.16 E.02427
G1 X149.995 Y142.84 E1.78131
G1 X149.346 Y142.84 E.02427
G1 X115.665 Y109.16 E1.78131
G1 X115.016 Y109.16 E.02427
G1 X148.697 Y142.84 E1.78131
G1 X148.048 Y142.84 E.02427
G1 X114.367 Y109.16 E1.78131
G1 X113.718 Y109.16 E.02427
G1 X147.398 Y142.84 E1.78131
G1 X146.749 Y142.84 E.02427
G1 X113.069 Y109.16 E1.78131
G1 X112.42 Y109.16 E.02427
G1 X146.1 Y142.84 E1.78131
G1 X145.451 Y142.84 E.02427
G1 X111.771 Y109.16 E1.78131
G1 X111.122 Y109.16 E.02427
G1 X144.802 Y142.84 E1.78131
G1 X144.153 Y142.84 E.02427
G1 X110.473 Y109.16 E1.78131
G1 X109.824 Y109.16 E.02427
G1 X143.504 Y142.84 E1.78131
G1 X142.855 Y142.84 E.02427
G1 X109.175 Y109.16 E1.78131
G1 X108.526 Y109.16 E.02427
G1 X142.206 Y142.84 E1.78131
G1 X141.557 Y142.84 E.02427
G1 X107.877 Y109.16 E1.78131
G1 X107.227 Y109.16 E.02427
G1 X140.908 Y142.84 E1.78131
G1 X140.259 Y142.84 E.02427
G1 X106.578 Y109.16 E1.78131
G1 X105.929 Y109.16 E.02427
G1 X139.61 Y142.84 E1.78131
G1 X138.961 Y142.84 E.02427
G1 X105.28 Y109.16 E1.78131
G1 X104.631 Y109.16 E.02427
G1 X138.312 Y142.84 E1.78131
G1 X137.663 Y142.84 E.02427
G1 X103.982 Y109.16 E1.78131
G1 X103.333 Y109.16 E.02427
M73 P24 R39
G1 X137.014 Y142.84 E1.78131
G1 X136.365 Y142.84 E.02427
G1 X102.684 Y109.16 E1.78131
G1 X102.035 Y109.16 E.02427
G1 X135.716 Y142.84 E1.78131
G1 X135.067 Y142.84 E.02427
G1 X101.386 Y109.16 E1.78131
G1 X100.737 Y109.16 E.02427
G1 X134.418 Y142.84 E1.78131
G1 X133.769 Y142.84 E.02427
G1 X100.088 Y109.16 E1.78131
G1 X99.439 Y109.16 E.02427
G1 X133.12 Y142.84 E1.78131
G1 X132.471 Y142.84 E.02427
G1 X98.79 Y109.16 E1.78131
G1 X98.141 Y109.16 E.02427
G1 X131.822 Y142.84 E1.78131
G1 X131.172 Y142.84 E.02427
G1 X97.492 Y109.16 E1.78131
G1 X96.843 Y109.16 E.02427
G1 X130.523 Y142.84 E1.78131
G1 X129.874 Y142.84 E.02427
G1 X96.194 Y109.16 E1.78131
G1 X95.545 Y109.16 E.02427
G1 X129.225 Y142.84 E1.78131
G1 X128.576 Y142.84 E.02427
G1 X94.896 Y109.16 E1.78131
G1 X94.247 Y109.16 E.02427
G1 X127.927 Y142.84 E1.78131
G1 X127.278 Y142.84 E.02427
G1 X93.598 Y109.16 E1.78131
G1 X92.949 Y109.16 E.02427
G1 X126.629 Y142.84 E1.78131
G1 X125.98 Y142.84 E.02427
G1 X92.3 Y109.16 E1.78131
G1 X91.651 Y109.16 E.02427
G1 X125.331 Y142.84 E1.78131
G1 X124.682 Y142.84 E.02427
G1 X91.002 Y109.16 E1.78131
G1 X90.352 Y109.16 E.02427
G1 X124.033 Y142.84 E1.78131
G1 X123.384 Y142.84 E.02427
G1 X89.703 Y109.16 E1.78131
G1 X89.054 Y109.16 E.02427
G1 X122.735 Y142.84 E1.78131
G1 X122.086 Y142.84 E.02427
M73 P24 R38
G1 X88.405 Y109.16 E1.78131
G1 X87.756 Y109.16 E.02427
G1 X121.437 Y142.84 E1.78131
G1 X120.788 Y142.84 E.02427
M73 P25 R38
G1 X87.107 Y109.16 E1.78131
G1 X86.458 Y109.16 E.02427
G1 X120.139 Y142.84 E1.78131
G1 X119.49 Y142.84 E.02427
G1 X85.809 Y109.16 E1.78131
G1 X85.16 Y109.16 E.02427
G1 X118.841 Y142.84 E1.78131
G1 X118.192 Y142.84 E.02427
G1 X84.511 Y109.16 E1.78131
G1 X83.862 Y109.16 E.02427
G1 X117.543 Y142.84 E1.78131
G1 X116.894 Y142.84 E.02427
G1 X83.213 Y109.16 E1.78131
G1 X82.564 Y109.16 E.02427
G1 X116.245 Y142.84 E1.78131
G1 X115.596 Y142.84 E.02427
G1 X81.915 Y109.16 E1.78131
G1 X81.266 Y109.16 E.02427
G1 X114.947 Y142.84 E1.78131
G1 X114.297 Y142.84 E.02427
G1 X80.617 Y109.16 E1.78131
G1 X79.968 Y109.16 E.02427
G1 X113.648 Y142.84 E1.78131
G1 X112.999 Y142.84 E.02427
G1 X79.319 Y109.16 E1.78131
G1 X78.67 Y109.16 E.02427
G1 X112.35 Y142.84 E1.78131
G1 X111.701 Y142.84 E.02427
G1 X78.16 Y109.299 E1.77396
G1 X78.16 Y109.948 E.02427
G1 X111.052 Y142.84 E1.73964
G1 X110.403 Y142.84 E.02427
G1 X78.16 Y110.597 E1.70531
G1 X78.16 Y111.246 E.02427
G1 X109.754 Y142.84 E1.67098
G1 X109.105 Y142.84 E.02427
G1 X78.16 Y111.895 E1.63666
G1 X78.16 Y112.544 E.02427
G1 X108.456 Y142.84 E1.60233
G1 X107.807 Y142.84 E.02427
G1 X78.16 Y113.193 E1.568
G1 X78.16 Y113.842 E.02427
G1 X107.158 Y142.84 E1.53368
G1 X106.509 Y142.84 E.02427
G1 X78.16 Y114.491 E1.49935
G1 X78.16 Y115.14 E.02427
G1 X105.86 Y142.84 E1.46502
G1 X105.211 Y142.84 E.02427
M73 P26 R38
G1 X78.16 Y115.789 E1.4307
G1 X78.16 Y116.438 E.02427
G1 X104.562 Y142.84 E1.39637
G1 X103.913 Y142.84 E.02427
G1 X78.16 Y117.087 E1.36204
G1 X78.16 Y117.736 E.02427
G1 X103.264 Y142.84 E1.32772
G1 X102.615 Y142.84 E.02427
G1 X78.16 Y118.385 E1.29339
G1 X78.16 Y119.034 E.02427
G1 X101.966 Y142.84 E1.25906
G1 X101.317 Y142.84 E.02427
G1 X78.16 Y119.683 E1.22474
G1 X78.16 Y120.332 E.02427
G1 X100.668 Y142.84 E1.19041
G1 X100.019 Y142.84 E.02427
G1 X78.16 Y120.981 E1.15608
G1 X78.16 Y121.63 E.02427
G1 X99.37 Y142.84 E1.12176
G1 X98.721 Y142.84 E.02427
G1 X78.16 Y122.279 E1.08743
G1 X78.16 Y122.929 E.02427
G1 X98.071 Y142.84 E1.0531
G1 X97.422 Y142.84 E.02427
G1 X78.16 Y123.578 E1.01878
G1 X78.16 Y124.227 E.02427
G1 X96.773 Y142.84 E.98445
G1 X96.124 Y142.84 E.02427
G1 X78.16 Y124.876 E.95012
G1 X78.16 Y125.525 E.02427
G1 X95.475 Y142.84 E.9158
G1 X94.826 Y142.84 E.02427
G1 X78.16 Y126.174 E.88147
G1 X78.16 Y126.823 E.02427
G1 X94.177 Y142.84 E.84714
G1 X93.528 Y142.84 E.02427
G1 X78.16 Y127.472 E.81282
G1 X78.16 Y128.121 E.02427
G1 X92.879 Y142.84 E.77849
G1 X92.23 Y142.84 E.02427
G1 X78.16 Y128.77 E.74416
G1 X78.16 Y129.419 E.02427
M73 P26 R37
G1 X91.581 Y142.84 E.70984
G1 X90.932 Y142.84 E.02427
G1 X78.16 Y130.068 E.67551
G1 X78.16 Y130.717 E.02427
G1 X90.283 Y142.84 E.64118
G1 X89.634 Y142.84 E.02427
M73 P27 R37
G1 X78.16 Y131.366 E.60686
G1 X78.16 Y132.015 E.02427
G1 X88.985 Y142.84 E.57253
G1 X88.336 Y142.84 E.02427
G1 X78.16 Y132.664 E.5382
G1 X78.16 Y133.313 E.02427
G1 X87.687 Y142.84 E.50388
G1 X87.038 Y142.84 E.02427
G1 X78.16 Y133.962 E.46955
G1 X78.16 Y134.611 E.02427
G1 X86.389 Y142.84 E.43522
G1 X85.74 Y142.84 E.02427
G1 X78.16 Y135.26 E.4009
G1 X78.16 Y135.909 E.02427
G1 X85.091 Y142.84 E.36657
G1 X84.442 Y142.84 E.02427
G1 X78.16 Y136.558 E.33224
G1 X78.16 Y137.207 E.02427
G1 X83.793 Y142.84 E.29792
G1 X83.144 Y142.84 E.02427
G1 X78.16 Y137.856 E.26359
G1 X78.16 Y138.505 E.02427
G1 X82.495 Y142.84 E.22926
G1 X81.846 Y142.84 E.02427
G1 X78.16 Y139.154 E.19494
G1 X78.16 Y139.804 E.02427
G1 X81.196 Y142.84 E.16061
G1 X80.547 Y142.84 E.02427
G1 X78.16 Y140.453 E.12628
G1 X78.16 Y141.102 E.02427
G1 X80.104 Y143.046 E.10284
; CHANGE_LAYER
; Z_HEIGHT: 0.3
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F2400
G1 X78.69 Y141.632 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/24
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
; open powerlost recovery
M1003 S1
M976 S1 P1 ; scan model before printing 2nd layer
M400 P100
G1 E.8
G1 E-.8
M204 S10000
G17
G3 Z.6 I-1.132 J-.448 P1  F30000
G1 X51.016 Y211.534 Z.6
G1 Z.3
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #3
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
M73 P28 R37
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
M204 S10000
G1  X50.366 Y183.207  
M204 S3000
G3  X53.579 Y186.461   I-16.082 J19.093 E0.0911
G3  X53.683 Y189.108   I-1.939 J1.402 E0.0558
G2  X51.995 Y192.600   I3.112 J3.659 E0.0794
G2  X51.998 Y205.134   I318.389 J6.184 E0.2494
G2  X53.775 Y208.623   I5.988 J-0.852 E0.0793
G3  X53.343 Y211.384   I-2.162 J1.076 E0.0593
G3  X50.089 Y214.597   I-19.095 J-16.084 E0.0911
G3  X46.376 Y213.799   I-1.435 J-2.360 E0.0833
G2  X43.950 Y213.013   I-2.442 J3.396 E0.0516
G2  X31.416 Y213.016   I-6.184 J318.389 E0.2494
G2  X27.927 Y214.793   I0.852 J5.988 E0.0793
G3  X25.166 Y214.361   I-1.076 J-2.162 E0.0593
G3  X21.953 Y211.107   I16.085 J-19.095 E0.0911
G3  X22.751 Y207.394   I2.360 J-1.435 E0.0833
G2  X23.537 Y204.968   I-3.396 J-2.442 E0.0516
G2  X23.534 Y192.434   I-318.389 J-6.184 E0.2494
G2  X21.757 Y188.945   I-5.988 J0.852 E0.0793
G3  X22.189 Y186.184   I2.162 J-1.076 E0.0593
G3  X25.443 Y182.971   I19.089 J16.078 E0.0911
G3  X29.156 Y183.769   I1.435 J2.360 E0.0833
G2  X31.582 Y184.555   I2.442 J-3.396 E0.0516
G2  X44.116 Y184.552   I6.184 J-318.389 E0.2494
G2  X47.605 Y182.775   I-0.852 J-5.988 E0.0793
G3  X48.875 Y182.523   I1.092 J2.173 E0.0261
G3  X50.366 Y183.207   I-0.199 J2.401 E0.0333
M204 S10000
G1  X50.698 Y182.862  
M204 S3000
G3  X53.967 Y186.180   I-16.301 J19.330 E0.0928
G3  X54.091 Y189.358   I-2.329 J1.683 E0.0671
G2  X52.473 Y192.605   I2.833 J3.439 E0.0743
G2  X52.476 Y205.115   I317.536 J6.179 E0.2489
G2  X54.201 Y208.406   I6.145 J-1.124 E0.0751
G3  X53.688 Y211.716   I-2.595 J1.292 E0.0710
G3  X50.370 Y214.985   I-19.335 J-16.306 E0.0928
G3  X45.977 Y214.105   I-1.705 J-2.893 E0.0976
G2  X43.945 Y213.491   I-2.029 J3.045 E0.0429
G2  X31.434 Y213.494   I-6.179 J317.536 E0.2489
G2  X28.144 Y215.219   I1.124 J6.145 E0.0751
G3  X24.834 Y214.706   I-1.292 J-2.595 E0.0710
G3  X21.565 Y211.388   I16.306 J-19.335 E0.0928
G3  X22.445 Y206.995   I2.893 J-1.705 E0.0976
G2  X23.059 Y204.963   I-3.045 J-2.029 E0.0429
G2  X23.056 Y192.452   I-317.536 J-6.179 E0.2489
G2  X21.331 Y189.162   I-6.145 J1.124 E0.0751
G3  X21.844 Y185.852   I2.595 J-1.292 E0.0710
G3  X25.162 Y182.583   I19.331 J16.302 E0.0928
G3  X29.554 Y183.463   I1.705 J2.892 E0.0976
G2  X31.587 Y184.077   I2.029 J-3.045 E0.0429
G2  X44.097 Y184.074   I6.179 J-317.536 E0.2489
G2  X47.388 Y182.349   I-1.124 J-6.144 E0.0751
G3  X48.912 Y182.046   I1.311 J2.609 E0.0313
G3  X50.698 Y182.862   I-0.238 J2.882 E0.0399
M204 S10000
G1  X51.030 Y182.517  
M204 S3000
G3  X54.354 Y185.898   I-16.555 J19.603 E0.0945
G3  X54.500 Y189.608   I-2.719 J1.965 E0.0783
G2  X52.952 Y192.610   I2.934 J3.413 E0.0689
G2  X52.954 Y205.097   I316.680 J6.174 E0.2484
G2  X54.500 Y207.960   I4.544 J-0.604 E0.0662
G3  X54.033 Y212.048   I-2.859 J1.744 E0.0882
G3  X50.652 Y215.372   I-19.605 J-16.557 E0.0945
G3  X45.712 Y214.503   I-2.008 J-3.060 E0.1099
M73 P28 R36
G2  X43.940 Y213.970   I-1.763 J2.646 E0.0374
G2  X31.453 Y213.972   I-6.174 J316.680 E0.2484
G2  X28.590 Y215.518   I0.604 J4.544 E0.0662
G3  X24.502 Y215.051   I-1.744 J-2.859 E0.0882
G3  X21.178 Y211.670   I16.558 J-19.605 E0.0945
G3  X22.047 Y206.730   I3.060 J-2.008 E0.1099
G2  X22.580 Y204.958   I-2.646 J-1.763 E0.0374
G2  X22.578 Y192.471   I-316.680 J-6.174 E0.2484
G2  X21.032 Y189.608   I-4.544 J0.604 E0.0662
G3  X21.499 Y185.520   I2.859 J-1.744 E0.0882
G3  X24.880 Y182.196   I19.603 J16.555 E0.0945
G3  X29.820 Y183.065   I2.008 J3.060 E0.1099
G2  X31.592 Y183.598   I1.763 J-2.646 E0.0374
G2  X44.079 Y183.596   I6.174 J-316.680 E0.2484
G2  X46.942 Y182.050   I-0.604 J-4.544 E0.0662
G3  X48.950 Y181.568   I1.798 J3.067 E0.0417
G3  X51.030 Y182.517   I-0.278 J3.362 E0.0464
M204 S10000
G1  X51.361 Y182.172  
M204 S3000
G3  X54.741 Y185.617   I-16.824 J19.890 E0.0962
G3  X53.826 Y191.193   I-3.545 J2.281 E0.1232
G2  X53.430 Y192.615   I2.346 J1.419 E0.0297
G2  X53.433 Y205.078   I315.895 J6.169 E0.2480
G2  X54.908 Y207.709   I4.409 J-0.743 E0.0612
G3  X54.378 Y212.379   I-3.268 J1.994 E0.1007
G3  X50.933 Y215.759   I-19.891 J-16.825 E0.0962
G3  X45.357 Y214.844   I-2.281 J-3.545 E0.1232
G2  X43.935 Y214.448   I-1.419 J2.347 E0.0297
G2  X31.472 Y214.451   I-6.169 J315.793 E0.2480
G2  X28.841 Y215.926   I0.743 J4.409 E0.0612
G3  X24.171 Y215.396   I-1.994 J-3.268 E0.1007
G3  X20.791 Y211.951   I16.825 J-19.891 E0.0962
G3  X21.706 Y206.375   I3.545 J-2.281 E0.1232
G2  X22.102 Y204.953   I-2.346 J-1.419 E0.0297
G2  X22.099 Y192.490   I-315.844 J-6.169 E0.2480
G2  X20.624 Y189.859   I-4.409 J0.743 E0.0612
G3  X21.154 Y185.189   I3.268 J-1.994 E0.1007
G3  X24.599 Y181.809   I19.889 J16.823 E0.0962
G3  X30.175 Y182.724   I2.281 J3.545 E0.1232
G2  X31.597 Y183.120   I1.419 J-2.347 E0.0297
G2  X44.060 Y183.117   I6.169 J-315.793 E0.2480
G2  X46.691 Y181.642   I-0.743 J-4.409 E0.0612
G3  X48.987 Y181.091   I2.056 J3.507 E0.0477
G3  X51.361 Y182.172   I-0.317 J3.843 E0.0529
M204 S10000
G1  X51.693 Y181.827  
M204 S3000
G3  X55.129 Y185.335   I-17.109 J20.194 E0.0978
G3  X54.190 Y191.518   I-4.041 J2.549 E0.1356
G2  X53.909 Y192.620   I1.945 J1.084 E0.0229
G2  X53.911 Y205.060   I315.006 J6.164 E0.2475
G2  X55.316 Y207.459   I4.304 J-0.910 E0.0563
G3  X54.723 Y212.711   I-3.677 J2.244 E0.1132
G3  X51.215 Y216.147   I-20.193 J-17.109 E0.0978
G3  X45.031 Y215.208   I-2.549 J-4.042 E0.1356
G2  X43.930 Y214.927   I-1.084 J1.945 E0.0229
G2  X31.490 Y214.929   I-6.164 J315.006 E0.2475
G2  X29.091 Y216.334   I0.909 J4.304 E0.0563
G3  X23.839 Y215.741   I-2.244 J-3.678 E0.1132
G3  X20.403 Y212.233   I17.109 J-20.193 E0.0978
G3  X21.342 Y206.050   I4.041 J-2.549 E0.1356
G2  X21.623 Y204.948   I-1.945 J-1.084 E0.0229
G2  X21.621 Y192.509   I-314.892 J-6.164 E0.2475
G2  X20.216 Y190.109   I-4.304 J0.909 E0.0563
G3  X20.809 Y184.857   I3.678 J-2.244 E0.1132
G3  X24.317 Y181.421   I20.195 J17.111 E0.0978
G3  X30.500 Y182.360   I2.549 J4.041 E0.1356
G2  X31.602 Y182.641   I1.084 J-1.945 E0.0229
G2  X44.041 Y182.639   I6.164 J-314.892 E0.2475
G2  X46.441 Y181.234   I-0.909 J-4.304 E0.0563
G3  X49.025 Y180.613   I2.314 J3.947 E0.0536
G3  X51.693 Y181.827   I-0.357 J4.324 E0.0595
; WIPE_TOWER_END

; WIPE_START
G1 F2400
M204 S3000
G1 X51.48 Y181.63 E-.11041
G1 X51.215 Y181.421 E-.12826
G1 X50.934 Y181.233 E-.12831
G1 X50.639 Y181.068 E-.12826
G1 X50.333 Y180.927 E-.12826
G1 X50.016 Y180.81 E-.12831
G1 X49.995 Y180.804 E-.00819
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.7 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
M73 P29 R36
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.543 Y143.35 Z.7 F30000
G1 Z.3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S3000
G1 X178.17 Y142.722 E.01443
G1 X178.17 Y142.157 E.00918
G1 X177.157 Y143.17 E.02329
G1 X176.593 Y143.17 E.00918
G1 X178.17 Y141.593 E.03627
G1 X178.17 Y141.028 E.00918
G1 X176.028 Y143.17 E.04926
G1 X175.464 Y143.17 E.00918
G1 X178.17 Y140.464 E.06224
G1 X178.17 Y139.9 E.00918
G1 X174.899 Y143.17 E.07522
G1 X174.335 Y143.17 E.00918
G1 X178.17 Y139.335 E.08821
G1 X178.17 Y138.771 E.00918
G1 X173.771 Y143.17 E.10119
G1 X173.206 Y143.17 E.00918
G1 X178.17 Y138.206 E.11417
G1 X178.17 Y137.642 E.00918
G1 X172.642 Y143.17 E.12715
G1 X172.077 Y143.17 E.00918
G1 X178.17 Y137.077 E.14014
G1 X178.17 Y136.513 E.00918
G1 X171.513 Y143.17 E.15312
G1 X170.948 Y143.17 E.00918
G1 X178.17 Y135.948 E.1661
G1 X178.17 Y135.384 E.00918
G1 X170.384 Y143.17 E.17908
G1 X169.819 Y143.17 E.00918
G1 X178.17 Y134.819 E.19207
G1 X178.17 Y134.255 E.00918
G1 X169.255 Y143.17 E.20505
G1 X168.69 Y143.17 E.00918
G1 X178.17 Y133.69 E.21803
G1 X178.17 Y133.126 E.00918
G1 X168.126 Y143.17 E.23101
G1 X167.561 Y143.17 E.00918
G1 X178.17 Y132.561 E.244
G1 X178.17 Y131.997 E.00918
G1 X166.997 Y143.17 E.25698
G1 X166.432 Y143.17 E.00918
G1 X178.17 Y131.432 E.26996
G1 X178.17 Y130.868 E.00918
G1 X165.868 Y143.17 E.28294
G1 X165.303 Y143.17 E.00918
G1 X178.17 Y130.303 E.29593
G1 X178.17 Y129.739 E.00918
G1 X164.739 Y143.17 E.30891
G1 X164.174 Y143.17 E.00918
G1 X178.17 Y129.174 E.32189
G1 X178.17 Y128.61 E.00918
G1 X163.61 Y143.17 E.33488
G1 X163.045 Y143.17 E.00918
G1 X178.17 Y128.045 E.34786
G1 X178.17 Y127.481 E.00918
G1 X162.481 Y143.17 E.36084
G1 X161.916 Y143.17 E.00918
G1 X178.17 Y126.916 E.37382
G1 X178.17 Y126.352 E.00918
G1 X161.352 Y143.17 E.38681
G1 X160.787 Y143.17 E.00918
G1 X178.17 Y125.787 E.39979
G1 X178.17 Y125.223 E.00918
G1 X160.223 Y143.17 E.41277
G1 X159.658 Y143.17 E.00918
G1 X178.17 Y124.658 E.42575
G1 X178.17 Y124.094 E.00918
G1 X159.094 Y143.17 E.43874
G1 X158.529 Y143.17 E.00918
G1 X178.17 Y123.529 E.45172
G1 X178.17 Y122.965 E.00918
G1 X157.965 Y143.17 E.4647
G1 X157.401 Y143.17 E.00918
G1 X178.17 Y122.401 E.47768
G1 X178.17 Y121.836 E.00918
G1 X156.836 Y143.17 E.49067
G1 X156.272 Y143.17 E.00918
G1 X178.17 Y121.272 E.50365
G1 X178.17 Y120.707 E.00918
G1 X155.707 Y143.17 E.51663
G1 X155.143 Y143.17 E.00918
G1 X178.17 Y120.143 E.52961
G1 X178.17 Y119.578 E.00918
G1 X154.578 Y143.17 E.5426
G1 X154.014 Y143.17 E.00918
G1 X178.17 Y119.014 E.55558
G1 X178.17 Y118.449 E.00918
G1 X153.449 Y143.17 E.56856
G1 X152.885 Y143.17 E.00918
G1 X178.17 Y117.885 E.58155
G1 X178.17 Y117.32 E.00918
G1 X152.32 Y143.17 E.59453
G1 X151.756 Y143.17 E.00918
G1 X178.17 Y116.756 E.60751
G1 X178.17 Y116.191 E.00918
G1 X151.191 Y143.17 E.62049
G1 X150.627 Y143.17 E.00918
G1 X178.17 Y115.627 E.63348
G1 X178.17 Y115.062 E.00918
G1 X150.062 Y143.17 E.64646
G1 X149.498 Y143.17 E.00918
G1 X178.17 Y114.498 E.65944
G1 X178.17 Y113.933 E.00918
G1 X148.933 Y143.17 E.67242
G1 X148.369 Y143.17 E.00918
G1 X178.17 Y113.369 E.68541
G1 X178.17 Y112.804 E.00918
G1 X147.804 Y143.17 E.69839
G1 X147.24 Y143.17 E.00918
G1 X178.17 Y112.24 E.71137
G1 X178.17 Y111.675 E.00918
G1 X146.675 Y143.17 E.72435
G1 X146.111 Y143.17 E.00918
G1 X178.17 Y111.111 E.73734
G1 X178.17 Y110.546 E.00918
G1 X145.546 Y143.17 E.75032
G1 X144.982 Y143.17 E.00918
G1 X178.17 Y109.982 E.7633
G1 X178.17 Y109.417 E.00918
G1 X144.417 Y143.17 E.77628
G1 X143.853 Y143.17 E.00918
G1 X178.17 Y108.853 E.78927
G1 X178.17 Y108.83 E.00038
G1 X177.629 Y108.83 E.0088
G1 X143.288 Y143.17 E.7898
G1 X142.724 Y143.17 E.00918
G1 X177.064 Y108.83 E.7898
G1 X176.5 Y108.83 E.00918
G1 X142.159 Y143.17 E.7898
G1 X141.595 Y143.17 E.00918
G1 X175.935 Y108.83 E.7898
G1 X175.371 Y108.83 E.00918
G1 X141.03 Y143.17 E.7898
G1 X140.466 Y143.17 E.00918
G1 X174.806 Y108.83 E.7898
G1 X174.242 Y108.83 E.00918
G1 X139.902 Y143.17 E.7898
G1 X139.337 Y143.17 E.00918
G1 X173.677 Y108.83 E.7898
G1 X173.113 Y108.83 E.00918
G1 X138.773 Y143.17 E.7898
G1 X138.208 Y143.17 E.00918
G1 X172.548 Y108.83 E.7898
G1 X171.984 Y108.83 E.00918
G1 X137.644 Y143.17 E.7898
G1 X137.079 Y143.17 E.00918
G1 X171.419 Y108.83 E.7898
G1 X170.855 Y108.83 E.00918
G1 X136.515 Y143.17 E.7898
G1 X135.95 Y143.17 E.00918
G1 X170.291 Y108.83 E.7898
G1 X169.726 Y108.83 E.00918
G1 X135.386 Y143.17 E.7898
G1 X134.821 Y143.17 E.00918
G1 X169.162 Y108.83 E.7898
G1 X168.597 Y108.83 E.00918
G1 X134.257 Y143.17 E.7898
G1 X133.692 Y143.17 E.00918
G1 X168.033 Y108.83 E.7898
G1 X167.468 Y108.83 E.00918
G1 X133.128 Y143.17 E.7898
G1 X132.563 Y143.17 E.00918
G1 X166.904 Y108.83 E.7898
G1 X166.339 Y108.83 E.00918
G1 X131.999 Y143.17 E.7898
G1 X131.434 Y143.17 E.00918
G1 X165.775 Y108.83 E.7898
G1 X165.21 Y108.83 E.00918
G1 X130.87 Y143.17 E.7898
G1 X130.305 Y143.17 E.00918
G1 X164.646 Y108.83 E.7898
G1 X164.081 Y108.83 E.00918
G1 X129.741 Y143.17 E.7898
G1 X129.176 Y143.17 E.00918
G1 X163.517 Y108.83 E.7898
G1 X162.952 Y108.83 E.00918
G1 X128.612 Y143.17 E.7898
G1 X128.047 Y143.17 E.00918
G1 X162.388 Y108.83 E.7898
G1 X161.823 Y108.83 E.00918
G1 X127.483 Y143.17 E.7898
G1 X126.918 Y143.17 E.00918
G1 X161.259 Y108.83 E.7898
G1 X160.694 Y108.83 E.00918
G1 X126.354 Y143.17 E.7898
G1 X125.789 Y143.17 E.00918
G1 X160.13 Y108.83 E.7898
G1 X159.565 Y108.83 E.00918
G1 X125.225 Y143.17 E.7898
G1 X124.66 Y143.17 E.00918
G1 X159.001 Y108.83 E.7898
G1 X158.436 Y108.83 E.00918
G1 X124.096 Y143.17 E.7898
G1 X123.532 Y143.17 E.00918
G1 X157.872 Y108.83 E.7898
G1 X157.307 Y108.83 E.00918
G1 X122.967 Y143.17 E.7898
G1 X122.403 Y143.17 E.00918
G1 X156.743 Y108.83 E.7898
G1 X156.178 Y108.83 E.00918
M73 P30 R36
G1 X121.838 Y143.17 E.7898
G1 X121.274 Y143.17 E.00918
G1 X155.614 Y108.83 E.7898
G1 X155.049 Y108.83 E.00918
G1 X120.709 Y143.17 E.7898
G1 X120.145 Y143.17 E.00918
G1 X154.485 Y108.83 E.7898
G1 X153.92 Y108.83 E.00918
G1 X119.58 Y143.17 E.7898
G1 X119.016 Y143.17 E.00918
G1 X153.356 Y108.83 E.7898
G1 X152.792 Y108.83 E.00918
G1 X118.451 Y143.17 E.7898
G1 X117.887 Y143.17 E.00918
G1 X152.227 Y108.83 E.7898
G1 X151.663 Y108.83 E.00918
G1 X117.322 Y143.17 E.7898
G1 X116.758 Y143.17 E.00918
G1 X151.098 Y108.83 E.7898
G1 X150.534 Y108.83 E.00918
G1 X116.193 Y143.17 E.7898
G1 X115.629 Y143.17 E.00918
G1 X149.969 Y108.83 E.7898
G1 X149.405 Y108.83 E.00918
G1 X115.064 Y143.17 E.7898
G1 X114.5 Y143.17 E.00918
G1 X148.84 Y108.83 E.7898
G1 X148.276 Y108.83 E.00918
G1 X113.935 Y143.17 E.7898
G1 X113.371 Y143.17 E.00918
G1 X147.711 Y108.83 E.7898
G1 X147.147 Y108.83 E.00918
G1 X112.806 Y143.17 E.7898
G1 X112.242 Y143.17 E.00918
G1 X146.582 Y108.83 E.7898
G1 X146.018 Y108.83 E.00918
G1 X111.677 Y143.17 E.7898
G1 X111.113 Y143.17 E.00918
G1 X145.453 Y108.83 E.7898
G1 X144.889 Y108.83 E.00918
G1 X110.548 Y143.17 E.7898
G1 X109.984 Y143.17 E.00918
G1 X144.324 Y108.83 E.7898
G1 X143.76 Y108.83 E.00918
G1 X109.419 Y143.17 E.7898
G1 X108.855 Y143.17 E.00918
G1 X143.195 Y108.83 E.7898
G1 X142.631 Y108.83 E.00918
G1 X108.29 Y143.17 E.7898
G1 X107.726 Y143.17 E.00918
G1 X142.066 Y108.83 E.7898
G1 X141.502 Y108.83 E.00918
G1 X107.161 Y143.17 E.7898
G1 X106.597 Y143.17 E.00918
G1 X140.937 Y108.83 E.7898
G1 X140.373 Y108.83 E.00918
G1 X106.033 Y143.17 E.7898
G1 X105.468 Y143.17 E.00918
G1 X139.808 Y108.83 E.7898
G1 X139.244 Y108.83 E.00918
G1 X104.904 Y143.17 E.7898
G1 X104.339 Y143.17 E.00918
G1 X138.679 Y108.83 E.7898
G1 X138.115 Y108.83 E.00918
G1 X103.775 Y143.17 E.7898
G1 X103.21 Y143.17 E.00918
G1 X137.55 Y108.83 E.7898
G1 X136.986 Y108.83 E.00918
G1 X102.646 Y143.17 E.7898
G1 X102.081 Y143.17 E.00918
G1 X136.421 Y108.83 E.7898
G1 X135.857 Y108.83 E.00918
G1 X101.517 Y143.17 E.7898
G1 X100.952 Y143.17 E.00918
G1 X135.293 Y108.83 E.7898
G1 X134.728 Y108.83 E.00918
G1 X100.388 Y143.17 E.7898
G1 X99.823 Y143.17 E.00918
G1 X134.164 Y108.83 E.7898
G1 X133.599 Y108.83 E.00918
G1 X99.259 Y143.17 E.7898
G1 X98.694 Y143.17 E.00918
G1 X133.035 Y108.83 E.7898
G1 X132.47 Y108.83 E.00918
M73 P30 R35
G1 X98.13 Y143.17 E.7898
G1 X97.565 Y143.17 E.00918
G1 X131.906 Y108.83 E.7898
G1 X131.341 Y108.83 E.00918
G1 X97.001 Y143.17 E.7898
G1 X96.436 Y143.17 E.00918
G1 X130.777 Y108.83 E.7898
G1 X130.212 Y108.83 E.00918
G1 X95.872 Y143.17 E.7898
G1 X95.307 Y143.17 E.00918
G1 X129.648 Y108.83 E.7898
G1 X129.083 Y108.83 E.00918
G1 X94.743 Y143.17 E.7898
G1 X94.178 Y143.17 E.00918
G1 X128.519 Y108.83 E.7898
G1 X127.954 Y108.83 E.00918
G1 X93.614 Y143.17 E.7898
G1 X93.049 Y143.17 E.00918
G1 X127.39 Y108.83 E.7898
G1 X126.825 Y108.83 E.00918
G1 X92.485 Y143.17 E.7898
G1 X91.92 Y143.17 E.00918
G1 X126.261 Y108.83 E.7898
G1 X125.696 Y108.83 E.00918
G1 X91.356 Y143.17 E.7898
G1 X90.791 Y143.17 E.00918
G1 X125.132 Y108.83 E.7898
G1 X124.567 Y108.83 E.00918
G1 X90.227 Y143.17 E.7898
G1 X89.662 Y143.17 E.00918
G1 X124.003 Y108.83 E.7898
G1 X123.438 Y108.83 E.00918
G1 X89.098 Y143.17 E.7898
G1 X88.534 Y143.17 E.00918
G1 X122.874 Y108.83 E.7898
G1 X122.309 Y108.83 E.00918
M73 P31 R35
G1 X87.969 Y143.17 E.7898
G1 X87.405 Y143.17 E.00918
G1 X121.745 Y108.83 E.7898
G1 X121.18 Y108.83 E.00918
G1 X86.84 Y143.17 E.7898
G1 X86.276 Y143.17 E.00918
G1 X120.616 Y108.83 E.7898
G1 X120.051 Y108.83 E.00918
G1 X85.711 Y143.17 E.7898
G1 X85.147 Y143.17 E.00918
G1 X119.487 Y108.83 E.7898
G1 X118.923 Y108.83 E.00918
G1 X84.582 Y143.17 E.7898
G1 X84.018 Y143.17 E.00918
G1 X118.358 Y108.83 E.7898
G1 X117.794 Y108.83 E.00918
G1 X83.453 Y143.17 E.7898
G1 X82.889 Y143.17 E.00918
G1 X117.229 Y108.83 E.7898
G1 X116.665 Y108.83 E.00918
G1 X82.324 Y143.17 E.7898
G1 X81.76 Y143.17 E.00918
G1 X116.1 Y108.83 E.7898
G1 X115.536 Y108.83 E.00918
G1 X81.195 Y143.17 E.7898
G1 X80.631 Y143.17 E.00918
G1 X114.971 Y108.83 E.7898
G1 X114.407 Y108.83 E.00918
G1 X80.066 Y143.17 E.7898
G1 X79.758 Y143.17 E.00501
G1 X79.63 Y143.042 E.00295
G1 X113.842 Y108.83 E.78685
G1 X113.278 Y108.83 E.00918
G1 X79.348 Y142.76 E.78036
G1 X79.065 Y142.478 E.00649
G1 X112.713 Y108.83 E.77387
G1 X112.149 Y108.83 E.00918
G1 X78.783 Y142.195 E.76738
G1 X78.501 Y141.913 E.00649
G1 X111.584 Y108.83 E.76089
G1 X111.02 Y108.83 E.00918
G1 X78.219 Y141.631 E.7544
G1 X77.936 Y141.349 E.00649
G1 X110.455 Y108.83 E.7479
G1 X109.891 Y108.83 E.00918
G1 X77.83 Y140.891 E.73737
G1 X77.83 Y140.326 E.00918
G1 X109.326 Y108.83 E.72439
G1 X108.762 Y108.83 E.00918
G1 X77.83 Y139.762 E.71141
G1 X77.83 Y139.197 E.00918
G1 X108.197 Y108.83 E.69843
G1 X107.633 Y108.83 E.00918
G1 X77.83 Y138.633 E.68544
G1 X77.83 Y138.068 E.00918
G1 X107.068 Y108.83 E.67246
G1 X106.504 Y108.83 E.00918
G1 X77.83 Y137.504 E.65948
G1 X77.83 Y136.939 E.00918
G1 X105.939 Y108.83 E.6465
G1 X105.375 Y108.83 E.00918
G1 X77.83 Y136.375 E.63351
G1 X77.83 Y135.81 E.00918
G1 X104.81 Y108.83 E.62053
G1 X104.246 Y108.83 E.00918
G1 X77.83 Y135.246 E.60755
G1 X77.83 Y134.681 E.00918
G1 X103.681 Y108.83 E.59457
G1 X103.117 Y108.83 E.00918
G1 X77.83 Y134.117 E.58158
G1 X77.83 Y133.552 E.00918
G1 X102.552 Y108.83 E.5686
G1 X101.988 Y108.83 E.00918
G1 X77.83 Y132.988 E.55562
G1 X77.83 Y132.424 E.00918
G1 X101.424 Y108.83 E.54263
G1 X100.859 Y108.83 E.00918
G1 X77.83 Y131.859 E.52965
G1 X77.83 Y131.295 E.00918
G1 X100.295 Y108.83 E.51667
G1 X99.73 Y108.83 E.00918
G1 X77.83 Y130.73 E.50369
G1 X77.83 Y130.166 E.00918
G1 X99.166 Y108.83 E.4907
G1 X98.601 Y108.83 E.00918
G1 X77.83 Y129.601 E.47772
G1 X77.83 Y129.037 E.00918
G1 X98.037 Y108.83 E.46474
G1 X97.472 Y108.83 E.00918
G1 X77.83 Y128.472 E.45176
G1 X77.83 Y127.908 E.00918
G1 X96.908 Y108.83 E.43877
G1 X96.343 Y108.83 E.00918
G1 X77.83 Y127.343 E.42579
G1 X77.83 Y126.779 E.00918
G1 X95.779 Y108.83 E.41281
G1 X95.214 Y108.83 E.00918
G1 X77.83 Y126.214 E.39983
G1 X77.83 Y125.65 E.00918
G1 X94.65 Y108.83 E.38684
G1 X94.085 Y108.83 E.00918
G1 X77.83 Y125.085 E.37386
G1 X77.83 Y124.521 E.00918
G1 X93.521 Y108.83 E.36088
G1 X92.956 Y108.83 E.00918
G1 X77.83 Y123.956 E.3479
G1 X77.83 Y123.392 E.00918
G1 X92.392 Y108.83 E.33491
G1 X91.827 Y108.83 E.00918
G1 X77.83 Y122.827 E.32193
G1 X77.83 Y122.263 E.00918
G1 X91.263 Y108.83 E.30895
G1 X90.698 Y108.83 E.00918
G1 X77.83 Y121.698 E.29596
G1 X77.83 Y121.134 E.00918
G1 X90.134 Y108.83 E.28298
M73 P32 R35
G1 X89.569 Y108.83 E.00918
G1 X77.83 Y120.569 E.27
G1 X77.83 Y120.005 E.00918
G1 X89.005 Y108.83 E.25702
G1 X88.44 Y108.83 E.00918
G1 X77.83 Y119.44 E.24403
G1 X77.83 Y118.876 E.00918
G1 X87.876 Y108.83 E.23105
G1 X87.311 Y108.83 E.00918
G1 X77.83 Y118.311 E.21807
G1 X77.83 Y117.747 E.00918
G1 X86.747 Y108.83 E.20509
G1 X86.182 Y108.83 E.00918
G1 X77.83 Y117.182 E.1921
G1 X77.83 Y116.618 E.00918
G1 X85.618 Y108.83 E.17912
G1 X85.054 Y108.83 E.00918
G1 X77.83 Y116.054 E.16614
G1 X77.83 Y115.489 E.00918
G1 X84.489 Y108.83 E.15316
G1 X83.925 Y108.83 E.00918
G1 X77.83 Y114.925 E.14017
G1 X77.83 Y114.36 E.00918
G1 X83.36 Y108.83 E.12719
G1 X82.796 Y108.83 E.00918
G1 X77.83 Y113.796 E.11421
G1 X77.83 Y113.231 E.00918
G1 X82.231 Y108.83 E.10123
G1 X81.667 Y108.83 E.00918
G1 X77.83 Y112.667 E.08824
G1 X77.83 Y112.102 E.00918
G1 X81.102 Y108.83 E.07526
G1 X80.538 Y108.83 E.00918
G1 X77.83 Y111.538 E.06228
G1 X77.83 Y110.973 E.00918
G1 X79.973 Y108.83 E.04929
G1 X79.409 Y108.83 E.00918
G1 X77.83 Y110.409 E.03631
G1 X77.83 Y109.844 E.00918
G1 X78.844 Y108.83 E.02333
G1 X78.28 Y108.83 E.00918
G1 X77.65 Y109.459 E.01447
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X78.28 Y108.83 E-.33815
G1 X78.844 Y108.83 E-.21451
G1 X78.458 Y109.216 E-.20735
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/24
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
M204 S10000
G17
G3 Z.7 I-1.175 J-.315 P1  F30000
G1 X51.016 Y211.534 Z.7
G1 Z.4
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #4
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
M204 S10000
G1  X50.366 Y183.207  
M204 S3000
G3  X53.579 Y186.461   I-16.082 J19.093 E0.0911
G3  X53.683 Y189.108   I-1.939 J1.402 E0.0558
G2  X51.995 Y192.600   I3.112 J3.659 E0.0794
G2  X51.998 Y205.134   I318.389 J6.184 E0.2494
G2  X53.775 Y208.623   I5.988 J-0.852 E0.0793
M73 P32 R34
G3  X53.343 Y211.384   I-2.162 J1.076 E0.0593
G3  X50.089 Y214.597   I-19.095 J-16.084 E0.0911
G3  X46.376 Y213.799   I-1.435 J-2.360 E0.0833
G2  X43.950 Y213.013   I-2.442 J3.396 E0.0516
G2  X31.416 Y213.016   I-6.184 J318.389 E0.2494
G2  X27.927 Y214.793   I0.852 J5.988 E0.0793
G3  X25.166 Y214.361   I-1.076 J-2.162 E0.0593
G3  X21.953 Y211.107   I16.085 J-19.095 E0.0911
G3  X22.751 Y207.394   I2.360 J-1.435 E0.0833
G2  X23.537 Y204.968   I-3.396 J-2.442 E0.0516
G2  X23.534 Y192.434   I-318.389 J-6.184 E0.2494
G2  X21.757 Y188.945   I-5.988 J0.852 E0.0793
G3  X22.189 Y186.184   I2.162 J-1.076 E0.0593
G3  X25.443 Y182.971   I19.089 J16.078 E0.0911
G3  X29.156 Y183.769   I1.435 J2.360 E0.0833
G2  X31.582 Y184.555   I2.442 J-3.396 E0.0516
G2  X44.116 Y184.552   I6.184 J-318.389 E0.2494
G2  X47.605 Y182.775   I-0.852 J-5.988 E0.0793
G3  X48.875 Y182.523   I1.092 J2.173 E0.0261
G3  X50.366 Y183.207   I-0.199 J2.401 E0.0333
M204 S10000
G1  X50.698 Y182.862  
M204 S3000
G3  X53.967 Y186.180   I-16.301 J19.330 E0.0928
G3  X54.091 Y189.358   I-2.329 J1.683 E0.0671
G2  X52.473 Y192.605   I2.833 J3.439 E0.0743
G2  X52.476 Y205.115   I317.536 J6.179 E0.2489
G2  X54.201 Y208.406   I6.145 J-1.124 E0.0751
G3  X53.688 Y211.716   I-2.595 J1.292 E0.0710
G3  X50.370 Y214.985   I-19.335 J-16.306 E0.0928
G3  X45.977 Y214.105   I-1.705 J-2.893 E0.0976
G2  X43.945 Y213.491   I-2.029 J3.045 E0.0429
G2  X31.434 Y213.494   I-6.179 J317.536 E0.2489
G2  X28.144 Y215.219   I1.124 J6.145 E0.0751
G3  X24.834 Y214.706   I-1.292 J-2.595 E0.0710
G3  X21.565 Y211.388   I16.306 J-19.335 E0.0928
G3  X22.445 Y206.995   I2.893 J-1.705 E0.0976
G2  X23.059 Y204.963   I-3.045 J-2.029 E0.0429
G2  X23.056 Y192.452   I-317.536 J-6.179 E0.2489
G2  X21.331 Y189.162   I-6.145 J1.124 E0.0751
G3  X21.844 Y185.852   I2.595 J-1.292 E0.0710
G3  X25.162 Y182.583   I19.331 J16.302 E0.0928
G3  X29.554 Y183.463   I1.705 J2.892 E0.0976
G2  X31.587 Y184.077   I2.029 J-3.045 E0.0429
G2  X44.097 Y184.074   I6.179 J-317.536 E0.2489
G2  X47.388 Y182.349   I-1.124 J-6.144 E0.0751
G3  X48.912 Y182.046   I1.311 J2.609 E0.0313
G3  X50.698 Y182.862   I-0.238 J2.882 E0.0399
M204 S10000
G1  X51.030 Y182.517  
M204 S3000
G3  X54.354 Y185.898   I-16.555 J19.603 E0.0945
G3  X54.500 Y189.608   I-2.719 J1.965 E0.0783
G2  X52.952 Y192.610   I2.934 J3.413 E0.0689
G2  X52.954 Y205.097   I316.680 J6.174 E0.2484
G2  X54.500 Y207.960   I4.544 J-0.604 E0.0662
G3  X54.033 Y212.048   I-2.859 J1.744 E0.0882
G3  X50.652 Y215.372   I-19.605 J-16.557 E0.0945
G3  X45.712 Y214.503   I-2.008 J-3.060 E0.1099
G2  X43.940 Y213.970   I-1.763 J2.646 E0.0374
G2  X31.453 Y213.972   I-6.174 J316.680 E0.2484
G2  X28.590 Y215.518   I0.604 J4.544 E0.0662
G3  X24.502 Y215.051   I-1.744 J-2.859 E0.0882
G3  X21.178 Y211.670   I16.558 J-19.605 E0.0945
G3  X22.047 Y206.730   I3.060 J-2.008 E0.1099
G2  X22.580 Y204.958   I-2.646 J-1.763 E0.0374
G2  X22.578 Y192.471   I-316.680 J-6.174 E0.2484
G2  X21.032 Y189.608   I-4.544 J0.604 E0.0662
G3  X21.499 Y185.520   I2.859 J-1.744 E0.0882
G3  X24.880 Y182.196   I19.603 J16.555 E0.0945
G3  X29.820 Y183.065   I2.008 J3.060 E0.1099
G2  X31.592 Y183.598   I1.763 J-2.646 E0.0374
G2  X44.079 Y183.596   I6.174 J-316.680 E0.2484
G2  X46.942 Y182.050   I-0.604 J-4.544 E0.0662
G3  X48.950 Y181.568   I1.798 J3.067 E0.0417
G3  X51.030 Y182.517   I-0.278 J3.362 E0.0464
M204 S10000
G1  X51.361 Y182.172  
M204 S3000
G3  X54.741 Y185.617   I-16.824 J19.890 E0.0962
G3  X53.826 Y191.193   I-3.545 J2.281 E0.1232
G2  X53.430 Y192.615   I2.346 J1.419 E0.0297
G2  X53.433 Y205.078   I315.895 J6.169 E0.2480
G2  X54.908 Y207.709   I4.409 J-0.743 E0.0612
G3  X54.378 Y212.379   I-3.268 J1.994 E0.1007
G3  X50.933 Y215.759   I-19.891 J-16.825 E0.0962
G3  X45.357 Y214.844   I-2.281 J-3.545 E0.1232
G2  X43.935 Y214.448   I-1.419 J2.347 E0.0297
G2  X31.472 Y214.451   I-6.169 J315.793 E0.2480
G2  X28.841 Y215.926   I0.743 J4.409 E0.0612
G3  X24.171 Y215.396   I-1.994 J-3.268 E0.1007
G3  X20.791 Y211.951   I16.825 J-19.891 E0.0962
G3  X21.706 Y206.375   I3.545 J-2.281 E0.1232
G2  X22.102 Y204.953   I-2.346 J-1.419 E0.0297
G2  X22.099 Y192.490   I-315.844 J-6.169 E0.2480
G2  X20.624 Y189.859   I-4.409 J0.743 E0.0612
G3  X21.154 Y185.189   I3.268 J-1.994 E0.1007
G3  X24.599 Y181.809   I19.889 J16.823 E0.0962
G3  X30.175 Y182.724   I2.281 J3.545 E0.1232
G2  X31.597 Y183.120   I1.419 J-2.347 E0.0297
G2  X44.060 Y183.117   I6.169 J-315.793 E0.2480
G2  X46.691 Y181.642   I-0.743 J-4.409 E0.0612
G3  X48.987 Y181.091   I2.056 J3.507 E0.0477
G3  X51.361 Y182.172   I-0.317 J3.843 E0.0529
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.169 Y181.994 E-.09969
G1 X50.933 Y181.808 E-.11397
G1 X50.684 Y181.641 E-.11402
G1 X50.422 Y181.495 E-.11398
G1 X50.15 Y181.369 E-.11398
G1 X49.868 Y181.265 E-.11402
G1 X49.639 Y181.201 E-.09036
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.8 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.911 Y137.1 Z.8 F30000
G1 X178.35 Y109.459 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S3000
G1 X177.721 Y108.83 E.01449
G1 X177.155 Y108.83 E.00921
G1 X178.17 Y109.845 E.02338
G1 X178.17 Y110.41 E.00921
M73 P33 R34
G1 X176.59 Y108.83 E.03641
G1 X176.024 Y108.83 E.00921
G1 X178.17 Y110.976 E.04943
G1 X178.17 Y111.541 E.00921
G1 X175.459 Y108.83 E.06245
G1 X174.894 Y108.83 E.00921
G1 X178.17 Y112.106 E.07548
G1 X178.17 Y112.672 E.00921
G1 X174.328 Y108.83 E.0885
G1 X173.763 Y108.83 E.00921
G1 X178.17 Y113.237 E.10153
G1 X178.17 Y113.803 E.00921
G1 X173.197 Y108.83 E.11455
G1 X172.632 Y108.83 E.00921
G1 X178.17 Y114.368 E.12758
G1 X178.17 Y114.933 E.00921
G1 X172.067 Y108.83 E.1406
G1 X171.501 Y108.83 E.00921
G1 X178.17 Y115.499 E.15362
G1 X178.17 Y116.064 E.00921
G1 X170.936 Y108.83 E.16665
G1 X170.37 Y108.83 E.00921
G1 X178.17 Y116.629 E.17967
G1 X178.17 Y117.195 E.00921
G1 X169.805 Y108.83 E.1927
G1 X169.24 Y108.83 E.00921
G1 X178.17 Y117.76 E.20572
G1 X178.17 Y118.326 E.00921
G1 X168.674 Y108.83 E.21875
G1 X168.109 Y108.83 E.00921
G1 X178.17 Y118.891 E.23177
G1 X178.17 Y119.456 E.00921
G1 X167.544 Y108.83 E.24479
G1 X166.978 Y108.83 E.00921
G1 X178.17 Y120.022 E.25782
G1 X178.17 Y120.587 E.00921
G1 X166.413 Y108.83 E.27084
G1 X165.847 Y108.83 E.00921
G1 X178.17 Y121.153 E.28387
G1 X178.17 Y121.718 E.00921
G1 X165.282 Y108.83 E.29689
G1 X164.717 Y108.83 E.00921
G1 X178.17 Y122.283 E.30992
G1 X178.17 Y122.849 E.00921
G1 X164.151 Y108.83 E.32294
G1 X163.586 Y108.83 E.00921
G1 X178.17 Y123.414 E.33596
G1 X178.17 Y123.98 E.00921
G1 X163.02 Y108.83 E.34899
G1 X162.455 Y108.83 E.00921
G1 X178.17 Y124.545 E.36201
G1 X178.17 Y125.11 E.00921
G1 X161.89 Y108.83 E.37504
G1 X161.324 Y108.83 E.00921
G1 X178.17 Y125.676 E.38806
G1 X178.17 Y126.241 E.00921
G1 X160.759 Y108.83 E.40109
G1 X160.194 Y108.83 E.00921
G1 X178.17 Y126.806 E.41411
G1 X178.17 Y127.372 E.00921
G1 X159.628 Y108.83 E.42713
G1 X159.063 Y108.83 E.00921
G1 X178.17 Y127.937 E.44016
G1 X178.17 Y128.503 E.00921
G1 X158.497 Y108.83 E.45318
G1 X157.932 Y108.83 E.00921
G1 X178.17 Y129.068 E.46621
G1 X178.17 Y129.633 E.00921
G1 X157.367 Y108.83 E.47923
G1 X156.801 Y108.83 E.00921
G1 X178.17 Y130.199 E.49226
G1 X178.17 Y130.764 E.00921
G1 X156.236 Y108.83 E.50528
G1 X155.67 Y108.83 E.00921
G1 X178.17 Y131.33 E.5183
G1 X178.17 Y131.895 E.00921
G1 X155.105 Y108.83 E.53133
G1 X154.54 Y108.83 E.00921
G1 X178.17 Y132.46 E.54435
G1 X178.17 Y133.026 E.00921
G1 X153.974 Y108.83 E.55738
G1 X153.409 Y108.83 E.00921
G1 X178.17 Y133.591 E.5704
G1 X178.17 Y134.157 E.00921
G1 X152.843 Y108.83 E.58343
G1 X152.278 Y108.83 E.00921
G1 X178.17 Y134.722 E.59645
G1 X178.17 Y135.287 E.00921
G1 X151.713 Y108.83 E.60947
G1 X151.147 Y108.83 E.00921
G1 X178.17 Y135.853 E.6225
G1 X178.17 Y136.418 E.00921
G1 X150.582 Y108.83 E.63552
G1 X150.017 Y108.83 E.00921
G1 X178.17 Y136.983 E.64855
G1 X178.17 Y137.549 E.00921
G1 X149.451 Y108.83 E.66157
G1 X148.886 Y108.83 E.00921
G1 X178.17 Y138.114 E.6746
G1 X178.17 Y138.68 E.00921
G1 X148.32 Y108.83 E.68762
G1 X147.755 Y108.83 E.00921
G1 X178.17 Y139.245 E.70064
G1 X178.17 Y139.81 E.00921
G1 X147.19 Y108.83 E.71367
G1 X146.624 Y108.83 E.00921
G1 X178.17 Y140.376 E.72669
G1 X178.17 Y140.941 E.00921
G1 X146.059 Y108.83 E.73972
G1 X145.493 Y108.83 E.00921
G1 X178.17 Y141.507 E.75274
G1 X178.17 Y142.072 E.00921
G1 X144.928 Y108.83 E.76577
G1 X144.363 Y108.83 E.00921
G1 X178.17 Y142.637 E.77879
G1 X178.17 Y143.17 E.00868
G1 X178.138 Y143.17 E.00053
G1 X143.797 Y108.83 E.79106
G1 X143.232 Y108.83 E.00921
G1 X177.572 Y143.17 E.79106
G1 X177.007 Y143.17 E.00921
G1 X142.666 Y108.83 E.79106
G1 X142.101 Y108.83 E.00921
G1 X176.441 Y143.17 E.79106
G1 X175.876 Y143.17 E.00921
G1 X141.536 Y108.83 E.79106
G1 X140.97 Y108.83 E.00921
G1 X175.311 Y143.17 E.79106
G1 X174.745 Y143.17 E.00921
G1 X140.405 Y108.83 E.79106
G1 X139.84 Y108.83 E.00921
G1 X174.18 Y143.17 E.79106
G1 X173.614 Y143.17 E.00921
G1 X139.274 Y108.83 E.79106
G1 X138.709 Y108.83 E.00921
G1 X173.049 Y143.17 E.79106
G1 X172.484 Y143.17 E.00921
G1 X138.143 Y108.83 E.79106
G1 X137.578 Y108.83 E.00921
G1 X171.918 Y143.17 E.79106
G1 X171.353 Y143.17 E.00921
G1 X137.013 Y108.83 E.79106
G1 X136.447 Y108.83 E.00921
G1 X170.788 Y143.17 E.79106
G1 X170.222 Y143.17 E.00921
G1 X135.882 Y108.83 E.79106
G1 X135.316 Y108.83 E.00921
G1 X169.657 Y143.17 E.79106
G1 X169.091 Y143.17 E.00921
G1 X134.751 Y108.83 E.79106
G1 X134.186 Y108.83 E.00921
G1 X168.526 Y143.17 E.79106
G1 X167.961 Y143.17 E.00921
G1 X133.62 Y108.83 E.79106
G1 X133.055 Y108.83 E.00921
G1 X167.395 Y143.17 E.79106
G1 X166.83 Y143.17 E.00921
G1 X132.489 Y108.83 E.79106
G1 X131.924 Y108.83 E.00921
G1 X166.264 Y143.17 E.79106
G1 X165.699 Y143.17 E.00921
G1 X131.359 Y108.83 E.79106
G1 X130.793 Y108.83 E.00921
G1 X165.134 Y143.17 E.79106
G1 X164.568 Y143.17 E.00921
G1 X130.228 Y108.83 E.79106
G1 X129.663 Y108.83 E.00921
G1 X164.003 Y143.17 E.79106
G1 X163.437 Y143.17 E.00921
G1 X129.097 Y108.83 E.79106
G1 X128.532 Y108.83 E.00921
G1 X162.872 Y143.17 E.79106
G1 X162.307 Y143.17 E.00921
G1 X127.966 Y108.83 E.79106
G1 X127.401 Y108.83 E.00921
G1 X161.741 Y143.17 E.79106
G1 X161.176 Y143.17 E.00921
G1 X126.836 Y108.83 E.79106
G1 X126.27 Y108.83 E.00921
G1 X160.611 Y143.17 E.79106
G1 X160.045 Y143.17 E.00921
G1 X125.705 Y108.83 E.79106
G1 X125.139 Y108.83 E.00921
G1 X159.48 Y143.17 E.79106
G1 X158.914 Y143.17 E.00921
G1 X124.574 Y108.83 E.79106
G1 X124.009 Y108.83 E.00921
G1 X158.349 Y143.17 E.79106
G1 X157.784 Y143.17 E.00921
G1 X123.443 Y108.83 E.79106
G1 X122.878 Y108.83 E.00921
G1 X157.218 Y143.17 E.79106
G1 X156.653 Y143.17 E.00921
G1 X122.312 Y108.83 E.79106
G1 X121.747 Y108.83 E.00921
G1 X156.087 Y143.17 E.79106
G1 X155.522 Y143.17 E.00921
G1 X121.182 Y108.83 E.79106
G1 X120.616 Y108.83 E.00921
G1 X154.957 Y143.17 E.79106
M73 P34 R34
G1 X154.391 Y143.17 E.00921
G1 X120.051 Y108.83 E.79106
G1 X119.486 Y108.83 E.00921
G1 X153.826 Y143.17 E.79106
G1 X153.261 Y143.17 E.00921
G1 X118.92 Y108.83 E.79106
G1 X118.355 Y108.83 E.00921
G1 X152.695 Y143.17 E.79106
G1 X152.13 Y143.17 E.00921
G1 X117.789 Y108.83 E.79106
G1 X117.224 Y108.83 E.00921
G1 X151.564 Y143.17 E.79106
G1 X150.999 Y143.17 E.00921
G1 X116.659 Y108.83 E.79106
G1 X116.093 Y108.83 E.00921
G1 X150.434 Y143.17 E.79106
G1 X149.868 Y143.17 E.00921
G1 X115.528 Y108.83 E.79106
G1 X114.962 Y108.83 E.00921
G1 X149.303 Y143.17 E.79106
G1 X148.737 Y143.17 E.00921
G1 X114.397 Y108.83 E.79106
G1 X113.832 Y108.83 E.00921
G1 X148.172 Y143.17 E.79106
G1 X147.607 Y143.17 E.00921
G1 X113.266 Y108.83 E.79106
G1 X112.701 Y108.83 E.00921
G1 X147.041 Y143.17 E.79106
G1 X146.476 Y143.17 E.00921
G1 X112.135 Y108.83 E.79106
G1 X111.57 Y108.83 E.00921
G1 X145.91 Y143.17 E.79106
G1 X145.345 Y143.17 E.00921
G1 X111.005 Y108.83 E.79106
G1 X110.439 Y108.83 E.00921
G1 X144.78 Y143.17 E.79106
G1 X144.214 Y143.17 E.00921
G1 X109.874 Y108.83 E.79106
G1 X109.309 Y108.83 E.00921
G1 X143.649 Y143.17 E.79106
G1 X143.084 Y143.17 E.00921
G1 X108.743 Y108.83 E.79106
G1 X108.178 Y108.83 E.00921
G1 X142.518 Y143.17 E.79106
G1 X141.953 Y143.17 E.00921
G1 X107.612 Y108.83 E.79106
G1 X107.047 Y108.83 E.00921
G1 X141.387 Y143.17 E.79106
G1 X140.822 Y143.17 E.00921
G1 X106.482 Y108.83 E.79106
G1 X105.916 Y108.83 E.00921
G1 X140.257 Y143.17 E.79106
G1 X139.691 Y143.17 E.00921
G1 X105.351 Y108.83 E.79106
G1 X104.785 Y108.83 E.00921
G1 X139.126 Y143.17 E.79106
G1 X138.56 Y143.17 E.00921
G1 X104.22 Y108.83 E.79106
G1 X103.655 Y108.83 E.00921
G1 X137.995 Y143.17 E.79106
G1 X137.43 Y143.17 E.00921
G1 X103.089 Y108.83 E.79106
G1 X102.524 Y108.83 E.00921
G1 X136.864 Y143.17 E.79106
G1 X136.299 Y143.17 E.00921
G1 X101.958 Y108.83 E.79106
G1 X101.393 Y108.83 E.00921
M73 P34 R33
G1 X135.733 Y143.17 E.79106
G1 X135.168 Y143.17 E.00921
G1 X100.828 Y108.83 E.79106
G1 X100.262 Y108.83 E.00921
G1 X134.603 Y143.17 E.79106
G1 X134.037 Y143.17 E.00921
G1 X99.697 Y108.83 E.79106
G1 X99.132 Y108.83 E.00921
G1 X133.472 Y143.17 E.79106
G1 X132.907 Y143.17 E.00921
G1 X98.566 Y108.83 E.79106
G1 X98.001 Y108.83 E.00921
G1 X132.341 Y143.17 E.79106
G1 X131.776 Y143.17 E.00921
G1 X97.435 Y108.83 E.79106
G1 X96.87 Y108.83 E.00921
G1 X131.21 Y143.17 E.79106
G1 X130.645 Y143.17 E.00921
G1 X96.305 Y108.83 E.79106
G1 X95.739 Y108.83 E.00921
G1 X130.08 Y143.17 E.79106
G1 X129.514 Y143.17 E.00921
G1 X95.174 Y108.83 E.79106
G1 X94.608 Y108.83 E.00921
G1 X128.949 Y143.17 E.79106
G1 X128.383 Y143.17 E.00921
G1 X94.043 Y108.83 E.79106
G1 X93.478 Y108.83 E.00921
G1 X127.818 Y143.17 E.79106
G1 X127.253 Y143.17 E.00921
G1 X92.912 Y108.83 E.79106
G1 X92.347 Y108.83 E.00921
G1 X126.687 Y143.17 E.79106
G1 X126.122 Y143.17 E.00921
G1 X91.782 Y108.83 E.79106
G1 X91.216 Y108.83 E.00921
G1 X125.556 Y143.17 E.79106
G1 X124.991 Y143.17 E.00921
G1 X90.651 Y108.83 E.79106
G1 X90.085 Y108.83 E.00921
G1 X124.426 Y143.17 E.79106
G1 X123.86 Y143.17 E.00921
G1 X89.52 Y108.83 E.79106
G1 X88.955 Y108.83 E.00921
G1 X123.295 Y143.17 E.79106
G1 X122.73 Y143.17 E.00921
G1 X88.389 Y108.83 E.79106
G1 X87.824 Y108.83 E.00921
G1 X122.164 Y143.17 E.79106
G1 X121.599 Y143.17 E.00921
G1 X87.258 Y108.83 E.79106
G1 X86.693 Y108.83 E.00921
M73 P35 R33
G1 X121.033 Y143.17 E.79106
G1 X120.468 Y143.17 E.00921
G1 X86.128 Y108.83 E.79106
G1 X85.562 Y108.83 E.00921
G1 X119.903 Y143.17 E.79106
G1 X119.337 Y143.17 E.00921
G1 X84.997 Y108.83 E.79106
G1 X84.431 Y108.83 E.00921
G1 X118.772 Y143.17 E.79106
G1 X118.206 Y143.17 E.00921
G1 X83.866 Y108.83 E.79106
G1 X83.301 Y108.83 E.00921
G1 X117.641 Y143.17 E.79106
G1 X117.076 Y143.17 E.00921
G1 X82.735 Y108.83 E.79106
G1 X82.17 Y108.83 E.00921
G1 X116.51 Y143.17 E.79106
G1 X115.945 Y143.17 E.00921
G1 X81.605 Y108.83 E.79106
G1 X81.039 Y108.83 E.00921
G1 X115.379 Y143.17 E.79106
G1 X114.814 Y143.17 E.00921
G1 X80.474 Y108.83 E.79106
G1 X79.908 Y108.83 E.00921
G1 X114.249 Y143.17 E.79106
G1 X113.683 Y143.17 E.00921
G1 X79.343 Y108.83 E.79106
G1 X78.778 Y108.83 E.00921
G1 X113.118 Y143.17 E.79106
G1 X112.553 Y143.17 E.00921
G1 X78.212 Y108.83 E.79106
G1 X77.83 Y108.83 E.00623
G1 X77.83 Y109.013 E.00298
G1 X111.987 Y143.17 E.78685
G1 X111.422 Y143.17 E.00921
G1 X77.83 Y109.578 E.77382
G1 X77.83 Y110.144 E.00921
G1 X110.856 Y143.17 E.7608
G1 X110.291 Y143.17 E.00921
G1 X77.83 Y110.709 E.74778
G1 X77.83 Y111.274 E.00921
G1 X109.726 Y143.17 E.73475
G1 X109.16 Y143.17 E.00921
G1 X77.83 Y111.84 E.72173
G1 X77.83 Y112.405 E.00921
G1 X108.595 Y143.17 E.7087
G1 X108.029 Y143.17 E.00921
G1 X77.83 Y112.971 E.69568
G1 X77.83 Y113.536 E.00921
G1 X107.464 Y143.17 E.68265
G1 X106.899 Y143.17 E.00921
G1 X77.83 Y114.101 E.66963
G1 X77.83 Y114.667 E.00921
G1 X106.333 Y143.17 E.65661
G1 X105.768 Y143.17 E.00921
G1 X77.83 Y115.232 E.64358
G1 X77.83 Y115.798 E.00921
G1 X105.202 Y143.17 E.63056
G1 X104.637 Y143.17 E.00921
G1 X77.83 Y116.363 E.61753
G1 X77.83 Y116.928 E.00921
G1 X104.072 Y143.17 E.60451
G1 X103.506 Y143.17 E.00921
G1 X77.83 Y117.494 E.59148
G1 X77.83 Y118.059 E.00921
G1 X102.941 Y143.17 E.57846
G1 X102.376 Y143.17 E.00921
G1 X77.83 Y118.624 E.56544
G1 X77.83 Y119.19 E.00921
G1 X101.81 Y143.17 E.55241
G1 X101.245 Y143.17 E.00921
G1 X77.83 Y119.755 E.53939
G1 X77.83 Y120.321 E.00921
G1 X100.679 Y143.17 E.52636
G1 X100.114 Y143.17 E.00921
G1 X77.83 Y120.886 E.51334
G1 X77.83 Y121.451 E.00921
G1 X99.549 Y143.17 E.50031
G1 X98.983 Y143.17 E.00921
G1 X77.83 Y122.017 E.48729
G1 X77.83 Y122.582 E.00921
G1 X98.418 Y143.17 E.47427
G1 X97.852 Y143.17 E.00921
G1 X77.83 Y123.148 E.46124
G1 X77.83 Y123.713 E.00921
G1 X97.287 Y143.17 E.44822
G1 X96.722 Y143.17 E.00921
G1 X77.83 Y124.278 E.43519
G1 X77.83 Y124.844 E.00921
G1 X96.156 Y143.17 E.42217
G1 X95.591 Y143.17 E.00921
G1 X77.83 Y125.409 E.40914
G1 X77.83 Y125.974 E.00921
G1 X95.025 Y143.17 E.39612
G1 X94.46 Y143.17 E.00921
G1 X77.83 Y126.54 E.3831
G1 X77.83 Y127.105 E.00921
G1 X93.895 Y143.17 E.37007
G1 X93.329 Y143.17 E.00921
G1 X77.83 Y127.671 E.35705
G1 X77.83 Y128.236 E.00921
G1 X92.764 Y143.17 E.34402
G1 X92.199 Y143.17 E.00921
G1 X77.83 Y128.801 E.331
G1 X77.83 Y129.367 E.00921
G1 X91.633 Y143.17 E.31797
G1 X91.068 Y143.17 E.00921
G1 X77.83 Y129.932 E.30495
G1 X77.83 Y130.498 E.00921
G1 X90.502 Y143.17 E.29193
G1 X89.937 Y143.17 E.00921
G1 X77.83 Y131.063 E.2789
G1 X77.83 Y131.628 E.00921
G1 X89.372 Y143.17 E.26588
G1 X88.806 Y143.17 E.00921
G1 X77.83 Y132.194 E.25285
G1 X77.83 Y132.759 E.00921
G1 X88.241 Y143.17 E.23983
M73 P36 R33
G1 X87.675 Y143.17 E.00921
G1 X77.83 Y133.325 E.2268
G1 X77.83 Y133.89 E.00921
G1 X87.11 Y143.17 E.21378
G1 X86.545 Y143.17 E.00921
G1 X77.83 Y134.455 E.20076
G1 X77.83 Y135.021 E.00921
G1 X85.979 Y143.17 E.18773
G1 X85.414 Y143.17 E.00921
G1 X77.83 Y135.586 E.17471
G1 X77.83 Y136.151 E.00921
G1 X84.849 Y143.17 E.16168
G1 X84.283 Y143.17 E.00921
G1 X77.83 Y136.717 E.14866
G1 X77.83 Y137.282 E.00921
G1 X83.718 Y143.17 E.13563
G1 X83.152 Y143.17 E.00921
G1 X77.83 Y137.848 E.12261
G1 X77.83 Y138.413 E.00921
G1 X82.587 Y143.17 E.10959
G1 X82.022 Y143.17 E.00921
G1 X77.83 Y138.978 E.09656
G1 X77.83 Y139.544 E.00921
G1 X81.456 Y143.17 E.08354
G1 X80.891 Y143.17 E.00921
G1 X77.83 Y140.109 E.07051
G1 X77.83 Y140.675 E.00921
G1 X80.325 Y143.17 E.05749
G1 X79.76 Y143.17 E.00921
G1 X77.65 Y141.061 E.0486
; CHANGE_LAYER
; Z_HEIGHT: 0.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X79.065 Y142.475 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/24
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M204 S10000
G17
G3 Z.8 I-1.128 J-.458 P1  F30000
G1 X51.016 Y211.534 Z.8
G1 Z.5
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #5
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
M73 P36 R32
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
M204 S10000
G1  X50.366 Y183.207  
M204 S3000
G3  X53.579 Y186.461   I-16.082 J19.093 E0.0911
G3  X53.683 Y189.108   I-1.939 J1.402 E0.0558
G2  X51.995 Y192.600   I3.112 J3.659 E0.0794
G2  X51.998 Y205.134   I318.389 J6.184 E0.2494
G2  X53.775 Y208.623   I5.988 J-0.852 E0.0793
G3  X53.343 Y211.384   I-2.162 J1.076 E0.0593
G3  X50.089 Y214.597   I-19.095 J-16.084 E0.0911
G3  X46.376 Y213.799   I-1.435 J-2.360 E0.0833
G2  X43.950 Y213.013   I-2.442 J3.396 E0.0516
G2  X31.416 Y213.016   I-6.184 J318.389 E0.2494
G2  X27.927 Y214.793   I0.852 J5.988 E0.0793
G3  X25.166 Y214.361   I-1.076 J-2.162 E0.0593
G3  X21.953 Y211.107   I16.085 J-19.095 E0.0911
G3  X22.751 Y207.394   I2.360 J-1.435 E0.0833
G2  X23.537 Y204.968   I-3.396 J-2.442 E0.0516
G2  X23.534 Y192.434   I-318.389 J-6.184 E0.2494
G2  X21.757 Y188.945   I-5.988 J0.852 E0.0793
G3  X22.189 Y186.184   I2.162 J-1.076 E0.0593
G3  X25.443 Y182.971   I19.089 J16.078 E0.0911
G3  X29.156 Y183.769   I1.435 J2.360 E0.0833
G2  X31.582 Y184.555   I2.442 J-3.396 E0.0516
G2  X44.116 Y184.552   I6.184 J-318.389 E0.2494
G2  X47.605 Y182.775   I-0.852 J-5.988 E0.0793
G3  X48.875 Y182.523   I1.092 J2.173 E0.0261
G3  X50.366 Y183.207   I-0.199 J2.401 E0.0333
M204 S10000
G1  X50.698 Y182.862  
M204 S3000
G3  X53.967 Y186.180   I-16.301 J19.330 E0.0928
G3  X54.091 Y189.358   I-2.329 J1.683 E0.0671
G2  X52.473 Y192.605   I2.833 J3.439 E0.0743
G2  X52.476 Y205.115   I317.536 J6.179 E0.2489
G2  X54.201 Y208.406   I6.145 J-1.124 E0.0751
G3  X53.688 Y211.716   I-2.595 J1.292 E0.0710
G3  X50.370 Y214.985   I-19.335 J-16.306 E0.0928
G3  X45.977 Y214.105   I-1.705 J-2.893 E0.0976
G2  X43.945 Y213.491   I-2.029 J3.045 E0.0429
G2  X31.434 Y213.494   I-6.179 J317.536 E0.2489
G2  X28.144 Y215.219   I1.124 J6.145 E0.0751
G3  X24.834 Y214.706   I-1.292 J-2.595 E0.0710
G3  X21.565 Y211.388   I16.306 J-19.335 E0.0928
G3  X22.445 Y206.995   I2.893 J-1.705 E0.0976
G2  X23.059 Y204.963   I-3.045 J-2.029 E0.0429
G2  X23.056 Y192.452   I-317.536 J-6.179 E0.2489
G2  X21.331 Y189.162   I-6.145 J1.124 E0.0751
G3  X21.844 Y185.852   I2.595 J-1.292 E0.0710
G3  X25.162 Y182.583   I19.331 J16.302 E0.0928
G3  X29.554 Y183.463   I1.705 J2.892 E0.0976
G2  X31.587 Y184.077   I2.029 J-3.045 E0.0429
G2  X44.097 Y184.074   I6.179 J-317.536 E0.2489
G2  X47.388 Y182.349   I-1.124 J-6.144 E0.0751
G3  X48.912 Y182.046   I1.311 J2.609 E0.0313
G3  X50.698 Y182.862   I-0.238 J2.882 E0.0399
M204 S10000
G1  X51.030 Y182.517  
M204 S3000
G3  X54.354 Y185.898   I-16.555 J19.603 E0.0945
G3  X54.500 Y189.608   I-2.719 J1.965 E0.0783
G2  X52.952 Y192.610   I2.934 J3.413 E0.0689
G2  X52.954 Y205.097   I316.680 J6.174 E0.2484
G2  X54.500 Y207.960   I4.544 J-0.604 E0.0662
G3  X54.033 Y212.048   I-2.859 J1.744 E0.0882
G3  X50.652 Y215.372   I-19.605 J-16.557 E0.0945
G3  X45.712 Y214.503   I-2.008 J-3.060 E0.1099
G2  X43.940 Y213.970   I-1.763 J2.646 E0.0374
G2  X31.453 Y213.972   I-6.174 J316.680 E0.2484
G2  X28.590 Y215.518   I0.604 J4.544 E0.0662
G3  X24.502 Y215.051   I-1.744 J-2.859 E0.0882
G3  X21.178 Y211.670   I16.558 J-19.605 E0.0945
G3  X22.047 Y206.730   I3.060 J-2.008 E0.1099
G2  X22.580 Y204.958   I-2.646 J-1.763 E0.0374
G2  X22.578 Y192.471   I-316.680 J-6.174 E0.2484
G2  X21.032 Y189.608   I-4.544 J0.604 E0.0662
G3  X21.499 Y185.520   I2.859 J-1.744 E0.0882
G3  X24.880 Y182.196   I19.603 J16.555 E0.0945
G3  X29.820 Y183.065   I2.008 J3.060 E0.1099
G2  X31.592 Y183.598   I1.763 J-2.646 E0.0374
G2  X44.079 Y183.596   I6.174 J-316.680 E0.2484
G2  X46.942 Y182.050   I-0.604 J-4.544 E0.0662
G3  X48.950 Y181.568   I1.798 J3.067 E0.0417
G3  X51.030 Y182.517   I-0.278 J3.362 E0.0464
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X50.858 Y182.358 E-.08898
G1 X50.652 Y182.196 E-.09968
G1 X50.433 Y182.05 E-.09972
G1 X50.205 Y181.922 E-.09969
G1 X49.966 Y181.812 E-.09969
G1 X49.72 Y181.721 E-.09973
G1 X49.468 Y181.65 E-.0997
G1 X49.28 Y181.612 E-.07281
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.9 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.543 Y143.35 Z.9 F30000
G1 Z.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S3000
G1 X178.17 Y142.722 E.01443
G1 X178.17 Y142.157 E.00918
G1 X177.157 Y143.17 E.02329
G1 X176.593 Y143.17 E.00918
G1 X178.17 Y141.593 E.03627
G1 X178.17 Y141.028 E.00918
G1 X176.028 Y143.17 E.04926
G1 X175.464 Y143.17 E.00918
G1 X178.17 Y140.464 E.06224
G1 X178.17 Y139.9 E.00918
G1 X174.899 Y143.17 E.07522
G1 X174.335 Y143.17 E.00918
G1 X178.17 Y139.335 E.08821
G1 X178.17 Y138.771 E.00918
G1 X173.771 Y143.17 E.10119
G1 X173.206 Y143.17 E.00918
G1 X178.17 Y138.206 E.11417
G1 X178.17 Y137.642 E.00918
G1 X172.642 Y143.17 E.12715
G1 X172.077 Y143.17 E.00918
G1 X178.17 Y137.077 E.14014
G1 X178.17 Y136.513 E.00918
G1 X171.513 Y143.17 E.15312
G1 X170.948 Y143.17 E.00918
G1 X178.17 Y135.948 E.1661
G1 X178.17 Y135.384 E.00918
G1 X170.384 Y143.17 E.17908
G1 X169.819 Y143.17 E.00918
G1 X178.17 Y134.819 E.19207
G1 X178.17 Y134.255 E.00918
G1 X169.255 Y143.17 E.20505
G1 X168.69 Y143.17 E.00918
G1 X178.17 Y133.69 E.21803
G1 X178.17 Y133.126 E.00918
G1 X168.126 Y143.17 E.23101
G1 X167.561 Y143.17 E.00918
G1 X178.17 Y132.561 E.244
G1 X178.17 Y131.997 E.00918
G1 X166.997 Y143.17 E.25698
G1 X166.432 Y143.17 E.00918
G1 X178.17 Y131.432 E.26996
G1 X178.17 Y130.868 E.00918
G1 X165.868 Y143.17 E.28294
G1 X165.303 Y143.17 E.00918
G1 X178.17 Y130.303 E.29593
G1 X178.17 Y129.739 E.00918
G1 X164.739 Y143.17 E.30891
G1 X164.174 Y143.17 E.00918
G1 X178.17 Y129.174 E.32189
G1 X178.17 Y128.61 E.00918
G1 X163.61 Y143.17 E.33488
G1 X163.045 Y143.17 E.00918
G1 X178.17 Y128.045 E.34786
G1 X178.17 Y127.481 E.00918
G1 X162.481 Y143.17 E.36084
G1 X161.916 Y143.17 E.00918
G1 X178.17 Y126.916 E.37382
G1 X178.17 Y126.352 E.00918
G1 X161.352 Y143.17 E.38681
G1 X160.787 Y143.17 E.00918
G1 X178.17 Y125.787 E.39979
G1 X178.17 Y125.223 E.00918
M73 P37 R32
G1 X160.223 Y143.17 E.41277
G1 X159.658 Y143.17 E.00918
G1 X178.17 Y124.658 E.42575
G1 X178.17 Y124.094 E.00918
G1 X159.094 Y143.17 E.43874
G1 X158.529 Y143.17 E.00918
G1 X178.17 Y123.529 E.45172
G1 X178.17 Y122.965 E.00918
G1 X157.965 Y143.17 E.4647
G1 X157.401 Y143.17 E.00918
G1 X178.17 Y122.401 E.47768
G1 X178.17 Y121.836 E.00918
G1 X156.836 Y143.17 E.49067
G1 X156.272 Y143.17 E.00918
G1 X178.17 Y121.272 E.50365
G1 X178.17 Y120.707 E.00918
G1 X155.707 Y143.17 E.51663
G1 X155.143 Y143.17 E.00918
G1 X178.17 Y120.143 E.52961
G1 X178.17 Y119.578 E.00918
G1 X154.578 Y143.17 E.5426
G1 X154.014 Y143.17 E.00918
G1 X178.17 Y119.014 E.55558
G1 X178.17 Y118.449 E.00918
G1 X153.449 Y143.17 E.56856
G1 X152.885 Y143.17 E.00918
G1 X178.17 Y117.885 E.58155
G1 X178.17 Y117.32 E.00918
G1 X152.32 Y143.17 E.59453
G1 X151.756 Y143.17 E.00918
G1 X178.17 Y116.756 E.60751
G1 X178.17 Y116.191 E.00918
G1 X151.191 Y143.17 E.62049
G1 X150.627 Y143.17 E.00918
G1 X178.17 Y115.627 E.63348
G1 X178.17 Y115.062 E.00918
G1 X150.062 Y143.17 E.64646
G1 X149.498 Y143.17 E.00918
G1 X178.17 Y114.498 E.65944
G1 X178.17 Y113.933 E.00918
G1 X148.933 Y143.17 E.67242
G1 X148.369 Y143.17 E.00918
G1 X178.17 Y113.369 E.68541
G1 X178.17 Y112.804 E.00918
G1 X147.804 Y143.17 E.69839
G1 X147.24 Y143.17 E.00918
G1 X178.17 Y112.24 E.71137
G1 X178.17 Y111.675 E.00918
G1 X146.675 Y143.17 E.72435
G1 X146.111 Y143.17 E.00918
G1 X178.17 Y111.111 E.73734
G1 X178.17 Y110.546 E.00918
G1 X145.546 Y143.17 E.75032
G1 X144.982 Y143.17 E.00918
G1 X178.17 Y109.982 E.7633
G1 X178.17 Y109.417 E.00918
G1 X144.417 Y143.17 E.77628
G1 X143.853 Y143.17 E.00918
G1 X178.17 Y108.853 E.78927
G1 X178.17 Y108.83 E.00038
G1 X177.629 Y108.83 E.0088
G1 X143.288 Y143.17 E.7898
G1 X142.724 Y143.17 E.00918
G1 X177.064 Y108.83 E.7898
G1 X176.5 Y108.83 E.00918
G1 X142.159 Y143.17 E.7898
G1 X141.595 Y143.17 E.00918
G1 X175.935 Y108.83 E.7898
G1 X175.371 Y108.83 E.00918
G1 X141.03 Y143.17 E.7898
G1 X140.466 Y143.17 E.00918
G1 X174.806 Y108.83 E.7898
G1 X174.242 Y108.83 E.00918
G1 X139.902 Y143.17 E.7898
G1 X139.337 Y143.17 E.00918
G1 X173.677 Y108.83 E.7898
G1 X173.113 Y108.83 E.00918
G1 X138.773 Y143.17 E.7898
G1 X138.208 Y143.17 E.00918
G1 X172.548 Y108.83 E.7898
G1 X171.984 Y108.83 E.00918
G1 X137.644 Y143.17 E.7898
G1 X137.079 Y143.17 E.00918
G1 X171.419 Y108.83 E.7898
G1 X170.855 Y108.83 E.00918
G1 X136.515 Y143.17 E.7898
G1 X135.95 Y143.17 E.00918
G1 X170.291 Y108.83 E.7898
G1 X169.726 Y108.83 E.00918
G1 X135.386 Y143.17 E.7898
G1 X134.821 Y143.17 E.00918
G1 X169.162 Y108.83 E.7898
G1 X168.597 Y108.83 E.00918
G1 X134.257 Y143.17 E.7898
G1 X133.692 Y143.17 E.00918
G1 X168.033 Y108.83 E.7898
G1 X167.468 Y108.83 E.00918
G1 X133.128 Y143.17 E.7898
G1 X132.563 Y143.17 E.00918
G1 X166.904 Y108.83 E.7898
G1 X166.339 Y108.83 E.00918
G1 X131.999 Y143.17 E.7898
G1 X131.434 Y143.17 E.00918
G1 X165.775 Y108.83 E.7898
G1 X165.21 Y108.83 E.00918
G1 X130.87 Y143.17 E.7898
G1 X130.305 Y143.17 E.00918
G1 X164.646 Y108.83 E.7898
G1 X164.081 Y108.83 E.00918
G1 X129.741 Y143.17 E.7898
G1 X129.176 Y143.17 E.00918
G1 X163.517 Y108.83 E.7898
G1 X162.952 Y108.83 E.00918
G1 X128.612 Y143.17 E.7898
G1 X128.047 Y143.17 E.00918
G1 X162.388 Y108.83 E.7898
G1 X161.823 Y108.83 E.00918
G1 X127.483 Y143.17 E.7898
G1 X126.918 Y143.17 E.00918
G1 X161.259 Y108.83 E.7898
G1 X160.694 Y108.83 E.00918
G1 X126.354 Y143.17 E.7898
G1 X125.789 Y143.17 E.00918
G1 X160.13 Y108.83 E.7898
G1 X159.565 Y108.83 E.00918
G1 X125.225 Y143.17 E.7898
G1 X124.66 Y143.17 E.00918
G1 X159.001 Y108.83 E.7898
G1 X158.436 Y108.83 E.00918
G1 X124.096 Y143.17 E.7898
G1 X123.532 Y143.17 E.00918
G1 X157.872 Y108.83 E.7898
G1 X157.307 Y108.83 E.00918
G1 X122.967 Y143.17 E.7898
G1 X122.403 Y143.17 E.00918
G1 X156.743 Y108.83 E.7898
G1 X156.178 Y108.83 E.00918
G1 X121.838 Y143.17 E.7898
G1 X121.274 Y143.17 E.00918
G1 X155.614 Y108.83 E.7898
G1 X155.049 Y108.83 E.00918
G1 X120.709 Y143.17 E.7898
G1 X120.145 Y143.17 E.00918
G1 X154.485 Y108.83 E.7898
G1 X153.92 Y108.83 E.00918
G1 X119.58 Y143.17 E.7898
G1 X119.016 Y143.17 E.00918
G1 X153.356 Y108.83 E.7898
G1 X152.792 Y108.83 E.00918
G1 X118.451 Y143.17 E.7898
G1 X117.887 Y143.17 E.00918
G1 X152.227 Y108.83 E.7898
G1 X151.663 Y108.83 E.00918
G1 X117.322 Y143.17 E.7898
G1 X116.758 Y143.17 E.00918
G1 X151.098 Y108.83 E.7898
M73 P38 R32
G1 X150.534 Y108.83 E.00918
G1 X116.193 Y143.17 E.7898
G1 X115.629 Y143.17 E.00918
G1 X149.969 Y108.83 E.7898
G1 X149.405 Y108.83 E.00918
G1 X115.064 Y143.17 E.7898
G1 X114.5 Y143.17 E.00918
G1 X148.84 Y108.83 E.7898
G1 X148.276 Y108.83 E.00918
G1 X113.935 Y143.17 E.7898
G1 X113.371 Y143.17 E.00918
G1 X147.711 Y108.83 E.7898
G1 X147.147 Y108.83 E.00918
G1 X112.806 Y143.17 E.7898
G1 X112.242 Y143.17 E.00918
G1 X146.582 Y108.83 E.7898
G1 X146.018 Y108.83 E.00918
G1 X111.677 Y143.17 E.7898
G1 X111.113 Y143.17 E.00918
G1 X145.453 Y108.83 E.7898
G1 X144.889 Y108.83 E.00918
G1 X110.548 Y143.17 E.7898
G1 X109.984 Y143.17 E.00918
G1 X144.324 Y108.83 E.7898
G1 X143.76 Y108.83 E.00918
G1 X109.419 Y143.17 E.7898
G1 X108.855 Y143.17 E.00918
G1 X143.195 Y108.83 E.7898
G1 X142.631 Y108.83 E.00918
G1 X108.29 Y143.17 E.7898
G1 X107.726 Y143.17 E.00918
G1 X142.066 Y108.83 E.7898
G1 X141.502 Y108.83 E.00918
G1 X107.161 Y143.17 E.7898
G1 X106.597 Y143.17 E.00918
G1 X140.937 Y108.83 E.7898
G1 X140.373 Y108.83 E.00918
G1 X106.033 Y143.17 E.7898
G1 X105.468 Y143.17 E.00918
G1 X139.808 Y108.83 E.7898
G1 X139.244 Y108.83 E.00918
G1 X104.904 Y143.17 E.7898
G1 X104.339 Y143.17 E.00918
G1 X138.679 Y108.83 E.7898
G1 X138.115 Y108.83 E.00918
G1 X103.775 Y143.17 E.7898
G1 X103.21 Y143.17 E.00918
G1 X137.55 Y108.83 E.7898
G1 X136.986 Y108.83 E.00918
M73 P38 R31
G1 X102.646 Y143.17 E.7898
G1 X102.081 Y143.17 E.00918
G1 X136.421 Y108.83 E.7898
G1 X135.857 Y108.83 E.00918
G1 X101.517 Y143.17 E.7898
G1 X100.952 Y143.17 E.00918
G1 X135.293 Y108.83 E.7898
G1 X134.728 Y108.83 E.00918
G1 X100.388 Y143.17 E.7898
G1 X99.823 Y143.17 E.00918
G1 X134.164 Y108.83 E.7898
G1 X133.599 Y108.83 E.00918
G1 X99.259 Y143.17 E.7898
G1 X98.694 Y143.17 E.00918
G1 X133.035 Y108.83 E.7898
G1 X132.47 Y108.83 E.00918
G1 X98.13 Y143.17 E.7898
G1 X97.565 Y143.17 E.00918
G1 X131.906 Y108.83 E.7898
G1 X131.341 Y108.83 E.00918
G1 X97.001 Y143.17 E.7898
G1 X96.436 Y143.17 E.00918
G1 X130.777 Y108.83 E.7898
G1 X130.212 Y108.83 E.00918
G1 X95.872 Y143.17 E.7898
G1 X95.307 Y143.17 E.00918
G1 X129.648 Y108.83 E.7898
G1 X129.083 Y108.83 E.00918
G1 X94.743 Y143.17 E.7898
G1 X94.178 Y143.17 E.00918
G1 X128.519 Y108.83 E.7898
G1 X127.954 Y108.83 E.00918
G1 X93.614 Y143.17 E.7898
G1 X93.049 Y143.17 E.00918
G1 X127.39 Y108.83 E.7898
G1 X126.825 Y108.83 E.00918
G1 X92.485 Y143.17 E.7898
G1 X91.92 Y143.17 E.00918
G1 X126.261 Y108.83 E.7898
G1 X125.696 Y108.83 E.00918
G1 X91.356 Y143.17 E.7898
G1 X90.791 Y143.17 E.00918
G1 X125.132 Y108.83 E.7898
G1 X124.567 Y108.83 E.00918
G1 X90.227 Y143.17 E.7898
G1 X89.662 Y143.17 E.00918
G1 X124.003 Y108.83 E.7898
G1 X123.438 Y108.83 E.00918
G1 X89.098 Y143.17 E.7898
G1 X88.534 Y143.17 E.00918
G1 X122.874 Y108.83 E.7898
G1 X122.309 Y108.83 E.00918
G1 X87.969 Y143.17 E.7898
G1 X87.405 Y143.17 E.00918
G1 X121.745 Y108.83 E.7898
G1 X121.18 Y108.83 E.00918
G1 X86.84 Y143.17 E.7898
G1 X86.276 Y143.17 E.00918
G1 X120.616 Y108.83 E.7898
G1 X120.051 Y108.83 E.00918
G1 X85.711 Y143.17 E.7898
G1 X85.147 Y143.17 E.00918
G1 X119.487 Y108.83 E.7898
G1 X118.923 Y108.83 E.00918
G1 X84.582 Y143.17 E.7898
G1 X84.018 Y143.17 E.00918
G1 X118.358 Y108.83 E.7898
G1 X117.794 Y108.83 E.00918
G1 X83.453 Y143.17 E.7898
G1 X82.889 Y143.17 E.00918
M73 P39 R31
G1 X117.229 Y108.83 E.7898
G1 X116.665 Y108.83 E.00918
G1 X82.324 Y143.17 E.7898
G1 X81.76 Y143.17 E.00918
G1 X116.1 Y108.83 E.7898
G1 X115.536 Y108.83 E.00918
G1 X81.195 Y143.17 E.7898
G1 X80.631 Y143.17 E.00918
G1 X114.971 Y108.83 E.7898
G1 X114.407 Y108.83 E.00918
G1 X80.066 Y143.17 E.7898
G1 X79.758 Y143.17 E.00501
G1 X79.63 Y143.042 E.00295
G1 X113.842 Y108.83 E.78685
G1 X113.278 Y108.83 E.00918
G1 X79.348 Y142.76 E.78036
G1 X79.065 Y142.478 E.00649
G1 X112.713 Y108.83 E.77387
G1 X112.149 Y108.83 E.00918
G1 X78.783 Y142.195 E.76738
G1 X78.501 Y141.913 E.00649
G1 X111.584 Y108.83 E.76089
G1 X111.02 Y108.83 E.00918
G1 X78.219 Y141.631 E.7544
G1 X77.936 Y141.349 E.00649
G1 X110.455 Y108.83 E.7479
G1 X109.891 Y108.83 E.00918
G1 X77.83 Y140.891 E.73737
G1 X77.83 Y140.326 E.00918
G1 X109.326 Y108.83 E.72439
G1 X108.762 Y108.83 E.00918
G1 X77.83 Y139.762 E.71141
G1 X77.83 Y139.197 E.00918
G1 X108.197 Y108.83 E.69843
G1 X107.633 Y108.83 E.00918
G1 X77.83 Y138.633 E.68544
G1 X77.83 Y138.068 E.00918
G1 X107.068 Y108.83 E.67246
G1 X106.504 Y108.83 E.00918
G1 X77.83 Y137.504 E.65948
G1 X77.83 Y136.939 E.00918
G1 X105.939 Y108.83 E.6465
G1 X105.375 Y108.83 E.00918
G1 X77.83 Y136.375 E.63351
G1 X77.83 Y135.81 E.00918
G1 X104.81 Y108.83 E.62053
G1 X104.246 Y108.83 E.00918
G1 X77.83 Y135.246 E.60755
G1 X77.83 Y134.681 E.00918
G1 X103.681 Y108.83 E.59457
G1 X103.117 Y108.83 E.00918
G1 X77.83 Y134.117 E.58158
G1 X77.83 Y133.552 E.00918
G1 X102.552 Y108.83 E.5686
G1 X101.988 Y108.83 E.00918
G1 X77.83 Y132.988 E.55562
G1 X77.83 Y132.424 E.00918
G1 X101.424 Y108.83 E.54263
G1 X100.859 Y108.83 E.00918
G1 X77.83 Y131.859 E.52965
G1 X77.83 Y131.295 E.00918
G1 X100.295 Y108.83 E.51667
G1 X99.73 Y108.83 E.00918
G1 X77.83 Y130.73 E.50369
G1 X77.83 Y130.166 E.00918
G1 X99.166 Y108.83 E.4907
G1 X98.601 Y108.83 E.00918
G1 X77.83 Y129.601 E.47772
G1 X77.83 Y129.037 E.00918
G1 X98.037 Y108.83 E.46474
G1 X97.472 Y108.83 E.00918
G1 X77.83 Y128.472 E.45176
G1 X77.83 Y127.908 E.00918
G1 X96.908 Y108.83 E.43877
G1 X96.343 Y108.83 E.00918
G1 X77.83 Y127.343 E.42579
G1 X77.83 Y126.779 E.00918
G1 X95.779 Y108.83 E.41281
G1 X95.214 Y108.83 E.00918
G1 X77.83 Y126.214 E.39983
G1 X77.83 Y125.65 E.00918
G1 X94.65 Y108.83 E.38684
G1 X94.085 Y108.83 E.00918
G1 X77.83 Y125.085 E.37386
G1 X77.83 Y124.521 E.00918
G1 X93.521 Y108.83 E.36088
G1 X92.956 Y108.83 E.00918
G1 X77.83 Y123.956 E.3479
G1 X77.83 Y123.392 E.00918
G1 X92.392 Y108.83 E.33491
G1 X91.827 Y108.83 E.00918
G1 X77.83 Y122.827 E.32193
G1 X77.83 Y122.263 E.00918
G1 X91.263 Y108.83 E.30895
G1 X90.698 Y108.83 E.00918
G1 X77.83 Y121.698 E.29596
G1 X77.83 Y121.134 E.00918
G1 X90.134 Y108.83 E.28298
G1 X89.569 Y108.83 E.00918
G1 X77.83 Y120.569 E.27
G1 X77.83 Y120.005 E.00918
G1 X89.005 Y108.83 E.25702
G1 X88.44 Y108.83 E.00918
G1 X77.83 Y119.44 E.24403
G1 X77.83 Y118.876 E.00918
G1 X87.876 Y108.83 E.23105
G1 X87.311 Y108.83 E.00918
G1 X77.83 Y118.311 E.21807
G1 X77.83 Y117.747 E.00918
G1 X86.747 Y108.83 E.20509
G1 X86.182 Y108.83 E.00918
G1 X77.83 Y117.182 E.1921
G1 X77.83 Y116.618 E.00918
G1 X85.618 Y108.83 E.17912
G1 X85.054 Y108.83 E.00918
G1 X77.83 Y116.054 E.16614
G1 X77.83 Y115.489 E.00918
M73 P40 R31
G1 X84.489 Y108.83 E.15316
G1 X83.925 Y108.83 E.00918
G1 X77.83 Y114.925 E.14017
G1 X77.83 Y114.36 E.00918
G1 X83.36 Y108.83 E.12719
G1 X82.796 Y108.83 E.00918
G1 X77.83 Y113.796 E.11421
G1 X77.83 Y113.231 E.00918
G1 X82.231 Y108.83 E.10123
G1 X81.667 Y108.83 E.00918
G1 X77.83 Y112.667 E.08824
G1 X77.83 Y112.102 E.00918
G1 X81.102 Y108.83 E.07526
G1 X80.538 Y108.83 E.00918
G1 X77.83 Y111.538 E.06228
G1 X77.83 Y110.973 E.00918
G1 X79.973 Y108.83 E.04929
G1 X79.409 Y108.83 E.00918
G1 X77.83 Y110.409 E.03631
G1 X77.83 Y109.844 E.00918
G1 X78.844 Y108.83 E.02333
G1 X78.28 Y108.83 E.00918
G1 X77.65 Y109.459 E.01447
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X78.28 Y108.83 E-.33815
G1 X78.844 Y108.83 E-.21451
G1 X78.458 Y109.216 E-.20735
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/24
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M204 S10000
G17
G3 Z.9 I-1.175 J-.315 P1  F30000
G1 X51.016 Y211.534 Z.9
G1 Z.6
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #6
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
M73 P40 R30
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
M204 S10000
G1  X50.366 Y183.207  
M204 S3000
G3  X53.579 Y186.461   I-16.082 J19.093 E0.0911
G3  X53.683 Y189.108   I-1.939 J1.402 E0.0558
G2  X51.995 Y192.600   I3.112 J3.659 E0.0794
G2  X51.998 Y205.134   I318.389 J6.184 E0.2494
G2  X53.775 Y208.623   I5.988 J-0.852 E0.0793
G3  X53.343 Y211.384   I-2.162 J1.076 E0.0593
G3  X50.089 Y214.597   I-19.095 J-16.084 E0.0911
G3  X46.376 Y213.799   I-1.435 J-2.360 E0.0833
G2  X43.950 Y213.013   I-2.442 J3.396 E0.0516
G2  X31.416 Y213.016   I-6.184 J318.389 E0.2494
G2  X27.927 Y214.793   I0.852 J5.988 E0.0793
G3  X25.166 Y214.361   I-1.076 J-2.162 E0.0593
G3  X21.953 Y211.107   I16.085 J-19.095 E0.0911
G3  X22.751 Y207.394   I2.360 J-1.435 E0.0833
G2  X23.537 Y204.968   I-3.396 J-2.442 E0.0516
G2  X23.534 Y192.434   I-318.389 J-6.184 E0.2494
G2  X21.757 Y188.945   I-5.988 J0.852 E0.0793
G3  X22.189 Y186.184   I2.162 J-1.076 E0.0593
G3  X25.443 Y182.971   I19.089 J16.078 E0.0911
G3  X29.156 Y183.769   I1.435 J2.360 E0.0833
G2  X31.582 Y184.555   I2.442 J-3.396 E0.0516
G2  X44.116 Y184.552   I6.184 J-318.389 E0.2494
G2  X47.605 Y182.775   I-0.852 J-5.988 E0.0793
G3  X48.875 Y182.523   I1.092 J2.173 E0.0261
G3  X50.366 Y183.207   I-0.199 J2.401 E0.0333
M204 S10000
G1  X50.698 Y182.862  
M204 S3000
G3  X53.967 Y186.180   I-16.301 J19.330 E0.0928
G3  X54.091 Y189.358   I-2.329 J1.683 E0.0671
G2  X52.473 Y192.605   I2.833 J3.439 E0.0743
G2  X52.476 Y205.115   I317.536 J6.179 E0.2489
G2  X54.201 Y208.406   I6.145 J-1.124 E0.0751
G3  X53.688 Y211.716   I-2.595 J1.292 E0.0710
G3  X50.370 Y214.985   I-19.335 J-16.306 E0.0928
G3  X45.977 Y214.105   I-1.705 J-2.893 E0.0976
G2  X43.945 Y213.491   I-2.029 J3.045 E0.0429
G2  X31.434 Y213.494   I-6.179 J317.536 E0.2489
G2  X28.144 Y215.219   I1.124 J6.145 E0.0751
G3  X24.834 Y214.706   I-1.292 J-2.595 E0.0710
G3  X21.565 Y211.388   I16.306 J-19.335 E0.0928
G3  X22.445 Y206.995   I2.893 J-1.705 E0.0976
G2  X23.059 Y204.963   I-3.045 J-2.029 E0.0429
G2  X23.056 Y192.452   I-317.536 J-6.179 E0.2489
G2  X21.331 Y189.162   I-6.145 J1.124 E0.0751
G3  X21.844 Y185.852   I2.595 J-1.292 E0.0710
G3  X25.162 Y182.583   I19.331 J16.302 E0.0928
G3  X29.554 Y183.463   I1.705 J2.892 E0.0976
G2  X31.587 Y184.077   I2.029 J-3.045 E0.0429
G2  X44.097 Y184.074   I6.179 J-317.536 E0.2489
G2  X47.388 Y182.349   I-1.124 J-6.144 E0.0751
G3  X48.912 Y182.046   I1.311 J2.609 E0.0313
G3  X50.698 Y182.862   I-0.238 J2.882 E0.0399
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X50.547 Y182.722 E-.07826
G1 X50.37 Y182.583 E-.0854
G1 X50.183 Y182.458 E-.08543
G1 X49.987 Y182.348 E-.0854
G1 X49.783 Y182.254 E-.0854
G1 X49.572 Y182.176 E-.08543
G1 X49.356 Y182.115 E-.08541
G1 X49.135 Y182.072 E-.0854
G1 X48.916 Y182.046 E-.08386
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.911 Y137.1 Z1 F30000
G1 X178.35 Y109.459 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S3000
G1 X177.721 Y108.83 E.01449
G1 X177.155 Y108.83 E.00921
G1 X178.17 Y109.845 E.02338
G1 X178.17 Y110.41 E.00921
G1 X176.59 Y108.83 E.03641
G1 X176.024 Y108.83 E.00921
G1 X178.17 Y110.976 E.04943
G1 X178.17 Y111.541 E.00921
G1 X175.459 Y108.83 E.06245
G1 X174.894 Y108.83 E.00921
G1 X178.17 Y112.106 E.07548
G1 X178.17 Y112.672 E.00921
G1 X174.328 Y108.83 E.0885
G1 X173.763 Y108.83 E.00921
G1 X178.17 Y113.237 E.10153
G1 X178.17 Y113.803 E.00921
G1 X173.197 Y108.83 E.11455
G1 X172.632 Y108.83 E.00921
G1 X178.17 Y114.368 E.12758
G1 X178.17 Y114.933 E.00921
G1 X172.067 Y108.83 E.1406
G1 X171.501 Y108.83 E.00921
G1 X178.17 Y115.499 E.15362
G1 X178.17 Y116.064 E.00921
G1 X170.936 Y108.83 E.16665
G1 X170.37 Y108.83 E.00921
G1 X178.17 Y116.629 E.17967
G1 X178.17 Y117.195 E.00921
G1 X169.805 Y108.83 E.1927
G1 X169.24 Y108.83 E.00921
G1 X178.17 Y117.76 E.20572
G1 X178.17 Y118.326 E.00921
G1 X168.674 Y108.83 E.21875
G1 X168.109 Y108.83 E.00921
G1 X178.17 Y118.891 E.23177
G1 X178.17 Y119.456 E.00921
G1 X167.544 Y108.83 E.24479
G1 X166.978 Y108.83 E.00921
G1 X178.17 Y120.022 E.25782
G1 X178.17 Y120.587 E.00921
G1 X166.413 Y108.83 E.27084
G1 X165.847 Y108.83 E.00921
G1 X178.17 Y121.153 E.28387
G1 X178.17 Y121.718 E.00921
G1 X165.282 Y108.83 E.29689
G1 X164.717 Y108.83 E.00921
G1 X178.17 Y122.283 E.30992
G1 X178.17 Y122.849 E.00921
G1 X164.151 Y108.83 E.32294
G1 X163.586 Y108.83 E.00921
G1 X178.17 Y123.414 E.33596
G1 X178.17 Y123.98 E.00921
G1 X163.02 Y108.83 E.34899
G1 X162.455 Y108.83 E.00921
G1 X178.17 Y124.545 E.36201
G1 X178.17 Y125.11 E.00921
G1 X161.89 Y108.83 E.37504
G1 X161.324 Y108.83 E.00921
G1 X178.17 Y125.676 E.38806
G1 X178.17 Y126.241 E.00921
G1 X160.759 Y108.83 E.40109
G1 X160.194 Y108.83 E.00921
G1 X178.17 Y126.806 E.41411
G1 X178.17 Y127.372 E.00921
G1 X159.628 Y108.83 E.42713
G1 X159.063 Y108.83 E.00921
G1 X178.17 Y127.937 E.44016
G1 X178.17 Y128.503 E.00921
G1 X158.497 Y108.83 E.45318
G1 X157.932 Y108.83 E.00921
G1 X178.17 Y129.068 E.46621
G1 X178.17 Y129.633 E.00921
M73 P41 R30
G1 X157.367 Y108.83 E.47923
G1 X156.801 Y108.83 E.00921
G1 X178.17 Y130.199 E.49226
G1 X178.17 Y130.764 E.00921
G1 X156.236 Y108.83 E.50528
G1 X155.67 Y108.83 E.00921
G1 X178.17 Y131.33 E.5183
G1 X178.17 Y131.895 E.00921
G1 X155.105 Y108.83 E.53133
G1 X154.54 Y108.83 E.00921
G1 X178.17 Y132.46 E.54435
G1 X178.17 Y133.026 E.00921
G1 X153.974 Y108.83 E.55738
G1 X153.409 Y108.83 E.00921
G1 X178.17 Y133.591 E.5704
G1 X178.17 Y134.157 E.00921
G1 X152.843 Y108.83 E.58343
G1 X152.278 Y108.83 E.00921
G1 X178.17 Y134.722 E.59645
G1 X178.17 Y135.287 E.00921
G1 X151.713 Y108.83 E.60947
G1 X151.147 Y108.83 E.00921
G1 X178.17 Y135.853 E.6225
G1 X178.17 Y136.418 E.00921
G1 X150.582 Y108.83 E.63552
G1 X150.017 Y108.83 E.00921
G1 X178.17 Y136.983 E.64855
G1 X178.17 Y137.549 E.00921
G1 X149.451 Y108.83 E.66157
G1 X148.886 Y108.83 E.00921
G1 X178.17 Y138.114 E.6746
G1 X178.17 Y138.68 E.00921
G1 X148.32 Y108.83 E.68762
G1 X147.755 Y108.83 E.00921
G1 X178.17 Y139.245 E.70064
G1 X178.17 Y139.81 E.00921
G1 X147.19 Y108.83 E.71367
G1 X146.624 Y108.83 E.00921
G1 X178.17 Y140.376 E.72669
G1 X178.17 Y140.941 E.00921
G1 X146.059 Y108.83 E.73972
G1 X145.493 Y108.83 E.00921
G1 X178.17 Y141.507 E.75274
G1 X178.17 Y142.072 E.00921
G1 X144.928 Y108.83 E.76577
G1 X144.363 Y108.83 E.00921
G1 X178.17 Y142.637 E.77879
G1 X178.17 Y143.17 E.00868
G1 X178.138 Y143.17 E.00053
G1 X143.797 Y108.83 E.79106
G1 X143.232 Y108.83 E.00921
G1 X177.572 Y143.17 E.79106
G1 X177.007 Y143.17 E.00921
G1 X142.666 Y108.83 E.79106
G1 X142.101 Y108.83 E.00921
G1 X176.441 Y143.17 E.79106
G1 X175.876 Y143.17 E.00921
G1 X141.536 Y108.83 E.79106
G1 X140.97 Y108.83 E.00921
G1 X175.311 Y143.17 E.79106
G1 X174.745 Y143.17 E.00921
G1 X140.405 Y108.83 E.79106
G1 X139.84 Y108.83 E.00921
G1 X174.18 Y143.17 E.79106
G1 X173.614 Y143.17 E.00921
G1 X139.274 Y108.83 E.79106
G1 X138.709 Y108.83 E.00921
G1 X173.049 Y143.17 E.79106
G1 X172.484 Y143.17 E.00921
G1 X138.143 Y108.83 E.79106
G1 X137.578 Y108.83 E.00921
G1 X171.918 Y143.17 E.79106
G1 X171.353 Y143.17 E.00921
G1 X137.013 Y108.83 E.79106
G1 X136.447 Y108.83 E.00921
G1 X170.788 Y143.17 E.79106
G1 X170.222 Y143.17 E.00921
G1 X135.882 Y108.83 E.79106
G1 X135.316 Y108.83 E.00921
G1 X169.657 Y143.17 E.79106
G1 X169.091 Y143.17 E.00921
G1 X134.751 Y108.83 E.79106
G1 X134.186 Y108.83 E.00921
G1 X168.526 Y143.17 E.79106
G1 X167.961 Y143.17 E.00921
G1 X133.62 Y108.83 E.79106
G1 X133.055 Y108.83 E.00921
G1 X167.395 Y143.17 E.79106
G1 X166.83 Y143.17 E.00921
G1 X132.489 Y108.83 E.79106
G1 X131.924 Y108.83 E.00921
G1 X166.264 Y143.17 E.79106
G1 X165.699 Y143.17 E.00921
G1 X131.359 Y108.83 E.79106
G1 X130.793 Y108.83 E.00921
G1 X165.134 Y143.17 E.79106
G1 X164.568 Y143.17 E.00921
G1 X130.228 Y108.83 E.79106
G1 X129.663 Y108.83 E.00921
G1 X164.003 Y143.17 E.79106
G1 X163.437 Y143.17 E.00921
G1 X129.097 Y108.83 E.79106
G1 X128.532 Y108.83 E.00921
G1 X162.872 Y143.17 E.79106
G1 X162.307 Y143.17 E.00921
G1 X127.966 Y108.83 E.79106
G1 X127.401 Y108.83 E.00921
G1 X161.741 Y143.17 E.79106
G1 X161.176 Y143.17 E.00921
G1 X126.836 Y108.83 E.79106
G1 X126.27 Y108.83 E.00921
G1 X160.611 Y143.17 E.79106
G1 X160.045 Y143.17 E.00921
G1 X125.705 Y108.83 E.79106
G1 X125.139 Y108.83 E.00921
G1 X159.48 Y143.17 E.79106
G1 X158.914 Y143.17 E.00921
G1 X124.574 Y108.83 E.79106
G1 X124.009 Y108.83 E.00921
G1 X158.349 Y143.17 E.79106
G1 X157.784 Y143.17 E.00921
G1 X123.443 Y108.83 E.79106
G1 X122.878 Y108.83 E.00921
G1 X157.218 Y143.17 E.79106
G1 X156.653 Y143.17 E.00921
G1 X122.312 Y108.83 E.79106
G1 X121.747 Y108.83 E.00921
G1 X156.087 Y143.17 E.79106
G1 X155.522 Y143.17 E.00921
G1 X121.182 Y108.83 E.79106
G1 X120.616 Y108.83 E.00921
G1 X154.957 Y143.17 E.79106
G1 X154.391 Y143.17 E.00921
G1 X120.051 Y108.83 E.79106
G1 X119.486 Y108.83 E.00921
G1 X153.826 Y143.17 E.79106
G1 X153.261 Y143.17 E.00921
G1 X118.92 Y108.83 E.79106
G1 X118.355 Y108.83 E.00921
G1 X152.695 Y143.17 E.79106
G1 X152.13 Y143.17 E.00921
G1 X117.789 Y108.83 E.79106
G1 X117.224 Y108.83 E.00921
G1 X151.564 Y143.17 E.79106
G1 X150.999 Y143.17 E.00921
G1 X116.659 Y108.83 E.79106
G1 X116.093 Y108.83 E.00921
G1 X150.434 Y143.17 E.79106
G1 X149.868 Y143.17 E.00921
G1 X115.528 Y108.83 E.79106
G1 X114.962 Y108.83 E.00921
G1 X149.303 Y143.17 E.79106
G1 X148.737 Y143.17 E.00921
G1 X114.397 Y108.83 E.79106
G1 X113.832 Y108.83 E.00921
G1 X148.172 Y143.17 E.79106
G1 X147.607 Y143.17 E.00921
G1 X113.266 Y108.83 E.79106
G1 X112.701 Y108.83 E.00921
G1 X147.041 Y143.17 E.79106
G1 X146.476 Y143.17 E.00921
G1 X112.135 Y108.83 E.79106
G1 X111.57 Y108.83 E.00921
G1 X145.91 Y143.17 E.79106
G1 X145.345 Y143.17 E.00921
M73 P42 R30
G1 X111.005 Y108.83 E.79106
G1 X110.439 Y108.83 E.00921
G1 X144.78 Y143.17 E.79106
G1 X144.214 Y143.17 E.00921
G1 X109.874 Y108.83 E.79106
G1 X109.309 Y108.83 E.00921
G1 X143.649 Y143.17 E.79106
G1 X143.084 Y143.17 E.00921
G1 X108.743 Y108.83 E.79106
G1 X108.178 Y108.83 E.00921
G1 X142.518 Y143.17 E.79106
G1 X141.953 Y143.17 E.00921
G1 X107.612 Y108.83 E.79106
G1 X107.047 Y108.83 E.00921
G1 X141.387 Y143.17 E.79106
G1 X140.822 Y143.17 E.00921
G1 X106.482 Y108.83 E.79106
G1 X105.916 Y108.83 E.00921
G1 X140.257 Y143.17 E.79106
G1 X139.691 Y143.17 E.00921
G1 X105.351 Y108.83 E.79106
G1 X104.785 Y108.83 E.00921
G1 X139.126 Y143.17 E.79106
G1 X138.56 Y143.17 E.00921
G1 X104.22 Y108.83 E.79106
G1 X103.655 Y108.83 E.00921
G1 X137.995 Y143.17 E.79106
G1 X137.43 Y143.17 E.00921
G1 X103.089 Y108.83 E.79106
G1 X102.524 Y108.83 E.00921
M73 P42 R29
G1 X136.864 Y143.17 E.79106
G1 X136.299 Y143.17 E.00921
G1 X101.958 Y108.83 E.79106
G1 X101.393 Y108.83 E.00921
G1 X135.733 Y143.17 E.79106
G1 X135.168 Y143.17 E.00921
G1 X100.828 Y108.83 E.79106
G1 X100.262 Y108.83 E.00921
G1 X134.603 Y143.17 E.79106
G1 X134.037 Y143.17 E.00921
G1 X99.697 Y108.83 E.79106
G1 X99.132 Y108.83 E.00921
G1 X133.472 Y143.17 E.79106
G1 X132.907 Y143.17 E.00921
G1 X98.566 Y108.83 E.79106
G1 X98.001 Y108.83 E.00921
G1 X132.341 Y143.17 E.79106
G1 X131.776 Y143.17 E.00921
G1 X97.435 Y108.83 E.79106
G1 X96.87 Y108.83 E.00921
G1 X131.21 Y143.17 E.79106
G1 X130.645 Y143.17 E.00921
G1 X96.305 Y108.83 E.79106
G1 X95.739 Y108.83 E.00921
G1 X130.08 Y143.17 E.79106
G1 X129.514 Y143.17 E.00921
G1 X95.174 Y108.83 E.79106
G1 X94.608 Y108.83 E.00921
G1 X128.949 Y143.17 E.79106
G1 X128.383 Y143.17 E.00921
G1 X94.043 Y108.83 E.79106
G1 X93.478 Y108.83 E.00921
G1 X127.818 Y143.17 E.79106
G1 X127.253 Y143.17 E.00921
G1 X92.912 Y108.83 E.79106
G1 X92.347 Y108.83 E.00921
G1 X126.687 Y143.17 E.79106
G1 X126.122 Y143.17 E.00921
G1 X91.782 Y108.83 E.79106
G1 X91.216 Y108.83 E.00921
G1 X125.556 Y143.17 E.79106
G1 X124.991 Y143.17 E.00921
G1 X90.651 Y108.83 E.79106
G1 X90.085 Y108.83 E.00921
G1 X124.426 Y143.17 E.79106
G1 X123.86 Y143.17 E.00921
G1 X89.52 Y108.83 E.79106
G1 X88.955 Y108.83 E.00921
G1 X123.295 Y143.17 E.79106
G1 X122.73 Y143.17 E.00921
G1 X88.389 Y108.83 E.79106
G1 X87.824 Y108.83 E.00921
G1 X122.164 Y143.17 E.79106
G1 X121.599 Y143.17 E.00921
G1 X87.258 Y108.83 E.79106
G1 X86.693 Y108.83 E.00921
G1 X121.033 Y143.17 E.79106
G1 X120.468 Y143.17 E.00921
G1 X86.128 Y108.83 E.79106
G1 X85.562 Y108.83 E.00921
G1 X119.903 Y143.17 E.79106
G1 X119.337 Y143.17 E.00921
G1 X84.997 Y108.83 E.79106
G1 X84.431 Y108.83 E.00921
G1 X118.772 Y143.17 E.79106
G1 X118.206 Y143.17 E.00921
G1 X83.866 Y108.83 E.79106
G1 X83.301 Y108.83 E.00921
G1 X117.641 Y143.17 E.79106
G1 X117.076 Y143.17 E.00921
G1 X82.735 Y108.83 E.79106
G1 X82.17 Y108.83 E.00921
G1 X116.51 Y143.17 E.79106
G1 X115.945 Y143.17 E.00921
G1 X81.605 Y108.83 E.79106
G1 X81.039 Y108.83 E.00921
G1 X115.379 Y143.17 E.79106
G1 X114.814 Y143.17 E.00921
G1 X80.474 Y108.83 E.79106
G1 X79.908 Y108.83 E.00921
G1 X114.249 Y143.17 E.79106
G1 X113.683 Y143.17 E.00921
G1 X79.343 Y108.83 E.79106
G1 X78.778 Y108.83 E.00921
G1 X113.118 Y143.17 E.79106
G1 X112.553 Y143.17 E.00921
M73 P43 R29
G1 X78.212 Y108.83 E.79106
G1 X77.83 Y108.83 E.00623
G1 X77.83 Y109.013 E.00298
G1 X111.987 Y143.17 E.78685
G1 X111.422 Y143.17 E.00921
G1 X77.83 Y109.578 E.77382
G1 X77.83 Y110.144 E.00921
G1 X110.856 Y143.17 E.7608
G1 X110.291 Y143.17 E.00921
G1 X77.83 Y110.709 E.74778
G1 X77.83 Y111.274 E.00921
G1 X109.726 Y143.17 E.73475
G1 X109.16 Y143.17 E.00921
G1 X77.83 Y111.84 E.72173
G1 X77.83 Y112.405 E.00921
G1 X108.595 Y143.17 E.7087
G1 X108.029 Y143.17 E.00921
G1 X77.83 Y112.971 E.69568
G1 X77.83 Y113.536 E.00921
G1 X107.464 Y143.17 E.68265
G1 X106.899 Y143.17 E.00921
G1 X77.83 Y114.101 E.66963
G1 X77.83 Y114.667 E.00921
G1 X106.333 Y143.17 E.65661
G1 X105.768 Y143.17 E.00921
G1 X77.83 Y115.232 E.64358
G1 X77.83 Y115.798 E.00921
G1 X105.202 Y143.17 E.63056
G1 X104.637 Y143.17 E.00921
G1 X77.83 Y116.363 E.61753
G1 X77.83 Y116.928 E.00921
G1 X104.072 Y143.17 E.60451
G1 X103.506 Y143.17 E.00921
G1 X77.83 Y117.494 E.59148
G1 X77.83 Y118.059 E.00921
G1 X102.941 Y143.17 E.57846
G1 X102.376 Y143.17 E.00921
G1 X77.83 Y118.624 E.56544
G1 X77.83 Y119.19 E.00921
G1 X101.81 Y143.17 E.55241
G1 X101.245 Y143.17 E.00921
G1 X77.83 Y119.755 E.53939
G1 X77.83 Y120.321 E.00921
G1 X100.679 Y143.17 E.52636
G1 X100.114 Y143.17 E.00921
G1 X77.83 Y120.886 E.51334
G1 X77.83 Y121.451 E.00921
G1 X99.549 Y143.17 E.50031
G1 X98.983 Y143.17 E.00921
G1 X77.83 Y122.017 E.48729
G1 X77.83 Y122.582 E.00921
G1 X98.418 Y143.17 E.47427
G1 X97.852 Y143.17 E.00921
G1 X77.83 Y123.148 E.46124
G1 X77.83 Y123.713 E.00921
G1 X97.287 Y143.17 E.44822
G1 X96.722 Y143.17 E.00921
G1 X77.83 Y124.278 E.43519
G1 X77.83 Y124.844 E.00921
G1 X96.156 Y143.17 E.42217
G1 X95.591 Y143.17 E.00921
G1 X77.83 Y125.409 E.40914
G1 X77.83 Y125.974 E.00921
G1 X95.025 Y143.17 E.39612
G1 X94.46 Y143.17 E.00921
G1 X77.83 Y126.54 E.3831
G1 X77.83 Y127.105 E.00921
G1 X93.895 Y143.17 E.37007
G1 X93.329 Y143.17 E.00921
G1 X77.83 Y127.671 E.35705
G1 X77.83 Y128.236 E.00921
G1 X92.764 Y143.17 E.34402
G1 X92.199 Y143.17 E.00921
G1 X77.83 Y128.801 E.331
G1 X77.83 Y129.367 E.00921
G1 X91.633 Y143.17 E.31797
G1 X91.068 Y143.17 E.00921
G1 X77.83 Y129.932 E.30495
G1 X77.83 Y130.498 E.00921
G1 X90.502 Y143.17 E.29193
G1 X89.937 Y143.17 E.00921
G1 X77.83 Y131.063 E.2789
G1 X77.83 Y131.628 E.00921
G1 X89.372 Y143.17 E.26588
G1 X88.806 Y143.17 E.00921
G1 X77.83 Y132.194 E.25285
G1 X77.83 Y132.759 E.00921
G1 X88.241 Y143.17 E.23983
G1 X87.675 Y143.17 E.00921
G1 X77.83 Y133.325 E.2268
G1 X77.83 Y133.89 E.00921
G1 X87.11 Y143.17 E.21378
G1 X86.545 Y143.17 E.00921
G1 X77.83 Y134.455 E.20076
G1 X77.83 Y135.021 E.00921
G1 X85.979 Y143.17 E.18773
G1 X85.414 Y143.17 E.00921
G1 X77.83 Y135.586 E.17471
G1 X77.83 Y136.151 E.00921
G1 X84.849 Y143.17 E.16168
G1 X84.283 Y143.17 E.00921
G1 X77.83 Y136.717 E.14866
G1 X77.83 Y137.282 E.00921
G1 X83.718 Y143.17 E.13563
G1 X83.152 Y143.17 E.00921
G1 X77.83 Y137.848 E.12261
G1 X77.83 Y138.413 E.00921
G1 X82.587 Y143.17 E.10959
G1 X82.022 Y143.17 E.00921
G1 X77.83 Y138.978 E.09656
G1 X77.83 Y139.544 E.00921
G1 X81.456 Y143.17 E.08354
G1 X80.891 Y143.17 E.00921
G1 X77.83 Y140.109 E.07051
G1 X77.83 Y140.675 E.00921
G1 X80.325 Y143.17 E.05749
G1 X79.76 Y143.17 E.00921
G1 X77.65 Y141.061 E.0486
; CHANGE_LAYER
; Z_HEIGHT: 0.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
M73 P44 R29
G1 X79.065 Y142.475 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/24
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M204 S10000
G17
G3 Z1 I-1.128 J-.458 P1  F30000
G1 X51.016 Y211.534 Z1
G1 Z.7
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #7
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
M73 P44 R28
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
M204 S10000
G1  X50.366 Y183.207  
M204 S3000
G3  X53.579 Y186.461   I-16.082 J19.093 E0.0911
G3  X53.683 Y189.108   I-1.939 J1.402 E0.0558
G2  X51.995 Y192.600   I3.112 J3.659 E0.0794
G2  X51.998 Y205.134   I318.389 J6.184 E0.2494
G2  X53.775 Y208.623   I5.988 J-0.852 E0.0793
G3  X53.343 Y211.384   I-2.162 J1.076 E0.0593
G3  X50.089 Y214.597   I-19.095 J-16.084 E0.0911
G3  X46.376 Y213.799   I-1.435 J-2.360 E0.0833
G2  X43.950 Y213.013   I-2.442 J3.396 E0.0516
G2  X31.416 Y213.016   I-6.184 J318.389 E0.2494
G2  X27.927 Y214.793   I0.852 J5.988 E0.0793
G3  X25.166 Y214.361   I-1.076 J-2.162 E0.0593
G3  X21.953 Y211.107   I16.085 J-19.095 E0.0911
G3  X22.751 Y207.394   I2.360 J-1.435 E0.0833
G2  X23.537 Y204.968   I-3.396 J-2.442 E0.0516
G2  X23.534 Y192.434   I-318.389 J-6.184 E0.2494
G2  X21.757 Y188.945   I-5.988 J0.852 E0.0793
G3  X22.189 Y186.184   I2.162 J-1.076 E0.0593
G3  X25.443 Y182.971   I19.089 J16.078 E0.0911
G3  X29.156 Y183.769   I1.435 J2.360 E0.0833
G2  X31.582 Y184.555   I2.442 J-3.396 E0.0516
G2  X44.116 Y184.552   I6.184 J-318.389 E0.2494
G2  X47.605 Y182.775   I-0.852 J-5.988 E0.0793
G3  X48.875 Y182.523   I1.092 J2.173 E0.0261
G3  X50.366 Y183.207   I-0.199 J2.401 E0.0333
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X50.236 Y183.086 E-.06755
G1 X50.089 Y182.97 E-.07111
G1 X49.933 Y182.866 E-.07113
G1 X49.77 Y182.775 E-.07112
G1 X49.6 Y182.697 E-.07112
G1 X49.424 Y182.632 E-.07113
G1 X49.244 Y182.581 E-.07112
G1 X49.06 Y182.545 E-.07111
G1 X48.875 Y182.523 E-.07113
G1 X48.688 Y182.515 E-.07112
G1 X48.55 Y182.521 E-.05235
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.1 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.543 Y143.35 Z1.1 F30000
G1 Z.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S3000
G1 X178.17 Y142.722 E.01443
G1 X178.17 Y142.157 E.00918
G1 X177.157 Y143.17 E.02329
G1 X176.593 Y143.17 E.00918
G1 X178.17 Y141.593 E.03627
G1 X178.17 Y141.028 E.00918
G1 X176.028 Y143.17 E.04926
G1 X175.464 Y143.17 E.00918
G1 X178.17 Y140.464 E.06224
G1 X178.17 Y139.9 E.00918
G1 X174.899 Y143.17 E.07522
G1 X174.335 Y143.17 E.00918
G1 X178.17 Y139.335 E.08821
G1 X178.17 Y138.771 E.00918
G1 X173.771 Y143.17 E.10119
G1 X173.206 Y143.17 E.00918
G1 X178.17 Y138.206 E.11417
G1 X178.17 Y137.642 E.00918
G1 X172.642 Y143.17 E.12715
G1 X172.077 Y143.17 E.00918
G1 X178.17 Y137.077 E.14014
G1 X178.17 Y136.513 E.00918
G1 X171.513 Y143.17 E.15312
G1 X170.948 Y143.17 E.00918
G1 X178.17 Y135.948 E.1661
G1 X178.17 Y135.384 E.00918
G1 X170.384 Y143.17 E.17908
G1 X169.819 Y143.17 E.00918
G1 X178.17 Y134.819 E.19207
G1 X178.17 Y134.255 E.00918
G1 X169.255 Y143.17 E.20505
G1 X168.69 Y143.17 E.00918
G1 X178.17 Y133.69 E.21803
G1 X178.17 Y133.126 E.00918
G1 X168.126 Y143.17 E.23101
G1 X167.561 Y143.17 E.00918
G1 X178.17 Y132.561 E.244
G1 X178.17 Y131.997 E.00918
G1 X166.997 Y143.17 E.25698
G1 X166.432 Y143.17 E.00918
G1 X178.17 Y131.432 E.26996
G1 X178.17 Y130.868 E.00918
G1 X165.868 Y143.17 E.28294
G1 X165.303 Y143.17 E.00918
G1 X178.17 Y130.303 E.29593
G1 X178.17 Y129.739 E.00918
G1 X164.739 Y143.17 E.30891
G1 X164.174 Y143.17 E.00918
G1 X178.17 Y129.174 E.32189
G1 X178.17 Y128.61 E.00918
G1 X163.61 Y143.17 E.33488
G1 X163.045 Y143.17 E.00918
G1 X178.17 Y128.045 E.34786
G1 X178.17 Y127.481 E.00918
G1 X162.481 Y143.17 E.36084
G1 X161.916 Y143.17 E.00918
G1 X178.17 Y126.916 E.37382
G1 X178.17 Y126.352 E.00918
G1 X161.352 Y143.17 E.38681
G1 X160.787 Y143.17 E.00918
G1 X178.17 Y125.787 E.39979
G1 X178.17 Y125.223 E.00918
G1 X160.223 Y143.17 E.41277
G1 X159.658 Y143.17 E.00918
G1 X178.17 Y124.658 E.42575
G1 X178.17 Y124.094 E.00918
G1 X159.094 Y143.17 E.43874
G1 X158.529 Y143.17 E.00918
G1 X178.17 Y123.529 E.45172
G1 X178.17 Y122.965 E.00918
G1 X157.965 Y143.17 E.4647
G1 X157.401 Y143.17 E.00918
G1 X178.17 Y122.401 E.47768
G1 X178.17 Y121.836 E.00918
G1 X156.836 Y143.17 E.49067
G1 X156.272 Y143.17 E.00918
G1 X178.17 Y121.272 E.50365
G1 X178.17 Y120.707 E.00918
G1 X155.707 Y143.17 E.51663
G1 X155.143 Y143.17 E.00918
G1 X178.17 Y120.143 E.52961
G1 X178.17 Y119.578 E.00918
G1 X154.578 Y143.17 E.5426
G1 X154.014 Y143.17 E.00918
G1 X178.17 Y119.014 E.55558
G1 X178.17 Y118.449 E.00918
G1 X153.449 Y143.17 E.56856
G1 X152.885 Y143.17 E.00918
G1 X178.17 Y117.885 E.58155
M73 P45 R28
G1 X178.17 Y117.32 E.00918
G1 X152.32 Y143.17 E.59453
G1 X151.756 Y143.17 E.00918
G1 X178.17 Y116.756 E.60751
G1 X178.17 Y116.191 E.00918
G1 X151.191 Y143.17 E.62049
G1 X150.627 Y143.17 E.00918
G1 X178.17 Y115.627 E.63348
G1 X178.17 Y115.062 E.00918
G1 X150.062 Y143.17 E.64646
G1 X149.498 Y143.17 E.00918
G1 X178.17 Y114.498 E.65944
G1 X178.17 Y113.933 E.00918
G1 X148.933 Y143.17 E.67242
G1 X148.369 Y143.17 E.00918
G1 X178.17 Y113.369 E.68541
G1 X178.17 Y112.804 E.00918
G1 X147.804 Y143.17 E.69839
G1 X147.24 Y143.17 E.00918
G1 X178.17 Y112.24 E.71137
G1 X178.17 Y111.675 E.00918
G1 X146.675 Y143.17 E.72435
G1 X146.111 Y143.17 E.00918
G1 X178.17 Y111.111 E.73734
G1 X178.17 Y110.546 E.00918
G1 X145.546 Y143.17 E.75032
G1 X144.982 Y143.17 E.00918
G1 X178.17 Y109.982 E.7633
G1 X178.17 Y109.417 E.00918
G1 X144.417 Y143.17 E.77628
G1 X143.853 Y143.17 E.00918
G1 X178.17 Y108.853 E.78927
G1 X178.17 Y108.83 E.00038
G1 X177.629 Y108.83 E.0088
G1 X143.288 Y143.17 E.7898
G1 X142.724 Y143.17 E.00918
G1 X177.064 Y108.83 E.7898
G1 X176.5 Y108.83 E.00918
G1 X142.159 Y143.17 E.7898
G1 X141.595 Y143.17 E.00918
G1 X175.935 Y108.83 E.7898
G1 X175.371 Y108.83 E.00918
G1 X141.03 Y143.17 E.7898
G1 X140.466 Y143.17 E.00918
G1 X174.806 Y108.83 E.7898
G1 X174.242 Y108.83 E.00918
G1 X139.902 Y143.17 E.7898
G1 X139.337 Y143.17 E.00918
G1 X173.677 Y108.83 E.7898
G1 X173.113 Y108.83 E.00918
G1 X138.773 Y143.17 E.7898
G1 X138.208 Y143.17 E.00918
G1 X172.548 Y108.83 E.7898
G1 X171.984 Y108.83 E.00918
G1 X137.644 Y143.17 E.7898
G1 X137.079 Y143.17 E.00918
G1 X171.419 Y108.83 E.7898
G1 X170.855 Y108.83 E.00918
G1 X136.515 Y143.17 E.7898
G1 X135.95 Y143.17 E.00918
G1 X170.291 Y108.83 E.7898
G1 X169.726 Y108.83 E.00918
G1 X135.386 Y143.17 E.7898
G1 X134.821 Y143.17 E.00918
G1 X169.162 Y108.83 E.7898
G1 X168.597 Y108.83 E.00918
G1 X134.257 Y143.17 E.7898
G1 X133.692 Y143.17 E.00918
G1 X168.033 Y108.83 E.7898
G1 X167.468 Y108.83 E.00918
G1 X133.128 Y143.17 E.7898
G1 X132.563 Y143.17 E.00918
G1 X166.904 Y108.83 E.7898
G1 X166.339 Y108.83 E.00918
G1 X131.999 Y143.17 E.7898
G1 X131.434 Y143.17 E.00918
G1 X165.775 Y108.83 E.7898
G1 X165.21 Y108.83 E.00918
G1 X130.87 Y143.17 E.7898
G1 X130.305 Y143.17 E.00918
G1 X164.646 Y108.83 E.7898
G1 X164.081 Y108.83 E.00918
G1 X129.741 Y143.17 E.7898
G1 X129.176 Y143.17 E.00918
G1 X163.517 Y108.83 E.7898
G1 X162.952 Y108.83 E.00918
G1 X128.612 Y143.17 E.7898
G1 X128.047 Y143.17 E.00918
G1 X162.388 Y108.83 E.7898
G1 X161.823 Y108.83 E.00918
G1 X127.483 Y143.17 E.7898
G1 X126.918 Y143.17 E.00918
G1 X161.259 Y108.83 E.7898
G1 X160.694 Y108.83 E.00918
G1 X126.354 Y143.17 E.7898
G1 X125.789 Y143.17 E.00918
G1 X160.13 Y108.83 E.7898
G1 X159.565 Y108.83 E.00918
G1 X125.225 Y143.17 E.7898
G1 X124.66 Y143.17 E.00918
G1 X159.001 Y108.83 E.7898
G1 X158.436 Y108.83 E.00918
G1 X124.096 Y143.17 E.7898
G1 X123.532 Y143.17 E.00918
G1 X157.872 Y108.83 E.7898
G1 X157.307 Y108.83 E.00918
G1 X122.967 Y143.17 E.7898
G1 X122.403 Y143.17 E.00918
G1 X156.743 Y108.83 E.7898
G1 X156.178 Y108.83 E.00918
G1 X121.838 Y143.17 E.7898
G1 X121.274 Y143.17 E.00918
G1 X155.614 Y108.83 E.7898
G1 X155.049 Y108.83 E.00918
G1 X120.709 Y143.17 E.7898
G1 X120.145 Y143.17 E.00918
G1 X154.485 Y108.83 E.7898
G1 X153.92 Y108.83 E.00918
G1 X119.58 Y143.17 E.7898
G1 X119.016 Y143.17 E.00918
G1 X153.356 Y108.83 E.7898
G1 X152.792 Y108.83 E.00918
G1 X118.451 Y143.17 E.7898
G1 X117.887 Y143.17 E.00918
G1 X152.227 Y108.83 E.7898
G1 X151.663 Y108.83 E.00918
G1 X117.322 Y143.17 E.7898
G1 X116.758 Y143.17 E.00918
G1 X151.098 Y108.83 E.7898
G1 X150.534 Y108.83 E.00918
G1 X116.193 Y143.17 E.7898
G1 X115.629 Y143.17 E.00918
G1 X149.969 Y108.83 E.7898
G1 X149.405 Y108.83 E.00918
G1 X115.064 Y143.17 E.7898
G1 X114.5 Y143.17 E.00918
G1 X148.84 Y108.83 E.7898
G1 X148.276 Y108.83 E.00918
G1 X113.935 Y143.17 E.7898
G1 X113.371 Y143.17 E.00918
G1 X147.711 Y108.83 E.7898
G1 X147.147 Y108.83 E.00918
G1 X112.806 Y143.17 E.7898
G1 X112.242 Y143.17 E.00918
G1 X146.582 Y108.83 E.7898
G1 X146.018 Y108.83 E.00918
G1 X111.677 Y143.17 E.7898
G1 X111.113 Y143.17 E.00918
G1 X145.453 Y108.83 E.7898
G1 X144.889 Y108.83 E.00918
G1 X110.548 Y143.17 E.7898
G1 X109.984 Y143.17 E.00918
G1 X144.324 Y108.83 E.7898
G1 X143.76 Y108.83 E.00918
G1 X109.419 Y143.17 E.7898
G1 X108.855 Y143.17 E.00918
G1 X143.195 Y108.83 E.7898
G1 X142.631 Y108.83 E.00918
G1 X108.29 Y143.17 E.7898
G1 X107.726 Y143.17 E.00918
G1 X142.066 Y108.83 E.7898
G1 X141.502 Y108.83 E.00918
G1 X107.161 Y143.17 E.7898
G1 X106.597 Y143.17 E.00918
G1 X140.937 Y108.83 E.7898
G1 X140.373 Y108.83 E.00918
G1 X106.033 Y143.17 E.7898
G1 X105.468 Y143.17 E.00918
G1 X139.808 Y108.83 E.7898
G1 X139.244 Y108.83 E.00918
G1 X104.904 Y143.17 E.7898
G1 X104.339 Y143.17 E.00918
M73 P46 R28
G1 X138.679 Y108.83 E.7898
G1 X138.115 Y108.83 E.00918
G1 X103.775 Y143.17 E.7898
G1 X103.21 Y143.17 E.00918
G1 X137.55 Y108.83 E.7898
G1 X136.986 Y108.83 E.00918
G1 X102.646 Y143.17 E.7898
G1 X102.081 Y143.17 E.00918
G1 X136.421 Y108.83 E.7898
G1 X135.857 Y108.83 E.00918
G1 X101.517 Y143.17 E.7898
G1 X100.952 Y143.17 E.00918
M73 P46 R27
G1 X135.293 Y108.83 E.7898
G1 X134.728 Y108.83 E.00918
G1 X100.388 Y143.17 E.7898
G1 X99.823 Y143.17 E.00918
G1 X134.164 Y108.83 E.7898
G1 X133.599 Y108.83 E.00918
G1 X99.259 Y143.17 E.7898
G1 X98.694 Y143.17 E.00918
G1 X133.035 Y108.83 E.7898
G1 X132.47 Y108.83 E.00918
G1 X98.13 Y143.17 E.7898
G1 X97.565 Y143.17 E.00918
G1 X131.906 Y108.83 E.7898
G1 X131.341 Y108.83 E.00918
G1 X97.001 Y143.17 E.7898
G1 X96.436 Y143.17 E.00918
G1 X130.777 Y108.83 E.7898
G1 X130.212 Y108.83 E.00918
G1 X95.872 Y143.17 E.7898
G1 X95.307 Y143.17 E.00918
G1 X129.648 Y108.83 E.7898
G1 X129.083 Y108.83 E.00918
G1 X94.743 Y143.17 E.7898
G1 X94.178 Y143.17 E.00918
G1 X128.519 Y108.83 E.7898
G1 X127.954 Y108.83 E.00918
G1 X93.614 Y143.17 E.7898
G1 X93.049 Y143.17 E.00918
G1 X127.39 Y108.83 E.7898
G1 X126.825 Y108.83 E.00918
G1 X92.485 Y143.17 E.7898
G1 X91.92 Y143.17 E.00918
G1 X126.261 Y108.83 E.7898
G1 X125.696 Y108.83 E.00918
G1 X91.356 Y143.17 E.7898
G1 X90.791 Y143.17 E.00918
G1 X125.132 Y108.83 E.7898
G1 X124.567 Y108.83 E.00918
G1 X90.227 Y143.17 E.7898
G1 X89.662 Y143.17 E.00918
G1 X124.003 Y108.83 E.7898
G1 X123.438 Y108.83 E.00918
G1 X89.098 Y143.17 E.7898
G1 X88.534 Y143.17 E.00918
G1 X122.874 Y108.83 E.7898
G1 X122.309 Y108.83 E.00918
G1 X87.969 Y143.17 E.7898
G1 X87.405 Y143.17 E.00918
G1 X121.745 Y108.83 E.7898
G1 X121.18 Y108.83 E.00918
G1 X86.84 Y143.17 E.7898
G1 X86.276 Y143.17 E.00918
G1 X120.616 Y108.83 E.7898
G1 X120.051 Y108.83 E.00918
G1 X85.711 Y143.17 E.7898
G1 X85.147 Y143.17 E.00918
G1 X119.487 Y108.83 E.7898
G1 X118.923 Y108.83 E.00918
G1 X84.582 Y143.17 E.7898
G1 X84.018 Y143.17 E.00918
G1 X118.358 Y108.83 E.7898
G1 X117.794 Y108.83 E.00918
G1 X83.453 Y143.17 E.7898
G1 X82.889 Y143.17 E.00918
G1 X117.229 Y108.83 E.7898
G1 X116.665 Y108.83 E.00918
G1 X82.324 Y143.17 E.7898
G1 X81.76 Y143.17 E.00918
G1 X116.1 Y108.83 E.7898
G1 X115.536 Y108.83 E.00918
G1 X81.195 Y143.17 E.7898
G1 X80.631 Y143.17 E.00918
G1 X114.971 Y108.83 E.7898
G1 X114.407 Y108.83 E.00918
G1 X80.066 Y143.17 E.7898
G1 X79.758 Y143.17 E.00501
G1 X79.63 Y143.042 E.00295
G1 X113.842 Y108.83 E.78685
G1 X113.278 Y108.83 E.00918
G1 X79.348 Y142.76 E.78036
G1 X79.065 Y142.478 E.00649
G1 X112.713 Y108.83 E.77387
G1 X112.149 Y108.83 E.00918
G1 X78.783 Y142.195 E.76738
G1 X78.501 Y141.913 E.00649
G1 X111.584 Y108.83 E.76089
G1 X111.02 Y108.83 E.00918
G1 X78.219 Y141.631 E.7544
G1 X77.936 Y141.349 E.00649
G1 X110.455 Y108.83 E.7479
G1 X109.891 Y108.83 E.00918
G1 X77.83 Y140.891 E.73737
G1 X77.83 Y140.326 E.00918
G1 X109.326 Y108.83 E.72439
G1 X108.762 Y108.83 E.00918
G1 X77.83 Y139.762 E.71141
G1 X77.83 Y139.197 E.00918
G1 X108.197 Y108.83 E.69843
G1 X107.633 Y108.83 E.00918
G1 X77.83 Y138.633 E.68544
G1 X77.83 Y138.068 E.00918
G1 X107.068 Y108.83 E.67246
G1 X106.504 Y108.83 E.00918
G1 X77.83 Y137.504 E.65948
M73 P47 R27
G1 X77.83 Y136.939 E.00918
G1 X105.939 Y108.83 E.6465
G1 X105.375 Y108.83 E.00918
G1 X77.83 Y136.375 E.63351
G1 X77.83 Y135.81 E.00918
G1 X104.81 Y108.83 E.62053
G1 X104.246 Y108.83 E.00918
G1 X77.83 Y135.246 E.60755
G1 X77.83 Y134.681 E.00918
G1 X103.681 Y108.83 E.59457
G1 X103.117 Y108.83 E.00918
G1 X77.83 Y134.117 E.58158
G1 X77.83 Y133.552 E.00918
G1 X102.552 Y108.83 E.5686
G1 X101.988 Y108.83 E.00918
G1 X77.83 Y132.988 E.55562
G1 X77.83 Y132.424 E.00918
G1 X101.424 Y108.83 E.54263
G1 X100.859 Y108.83 E.00918
G1 X77.83 Y131.859 E.52965
G1 X77.83 Y131.295 E.00918
G1 X100.295 Y108.83 E.51667
G1 X99.73 Y108.83 E.00918
G1 X77.83 Y130.73 E.50369
G1 X77.83 Y130.166 E.00918
G1 X99.166 Y108.83 E.4907
G1 X98.601 Y108.83 E.00918
G1 X77.83 Y129.601 E.47772
G1 X77.83 Y129.037 E.00918
G1 X98.037 Y108.83 E.46474
G1 X97.472 Y108.83 E.00918
G1 X77.83 Y128.472 E.45176
G1 X77.83 Y127.908 E.00918
G1 X96.908 Y108.83 E.43877
G1 X96.343 Y108.83 E.00918
G1 X77.83 Y127.343 E.42579
G1 X77.83 Y126.779 E.00918
G1 X95.779 Y108.83 E.41281
G1 X95.214 Y108.83 E.00918
G1 X77.83 Y126.214 E.39983
G1 X77.83 Y125.65 E.00918
G1 X94.65 Y108.83 E.38684
G1 X94.085 Y108.83 E.00918
G1 X77.83 Y125.085 E.37386
G1 X77.83 Y124.521 E.00918
G1 X93.521 Y108.83 E.36088
G1 X92.956 Y108.83 E.00918
G1 X77.83 Y123.956 E.3479
G1 X77.83 Y123.392 E.00918
G1 X92.392 Y108.83 E.33491
G1 X91.827 Y108.83 E.00918
G1 X77.83 Y122.827 E.32193
G1 X77.83 Y122.263 E.00918
G1 X91.263 Y108.83 E.30895
G1 X90.698 Y108.83 E.00918
G1 X77.83 Y121.698 E.29596
G1 X77.83 Y121.134 E.00918
G1 X90.134 Y108.83 E.28298
G1 X89.569 Y108.83 E.00918
G1 X77.83 Y120.569 E.27
G1 X77.83 Y120.005 E.00918
G1 X89.005 Y108.83 E.25702
G1 X88.44 Y108.83 E.00918
G1 X77.83 Y119.44 E.24403
G1 X77.83 Y118.876 E.00918
G1 X87.876 Y108.83 E.23105
G1 X87.311 Y108.83 E.00918
G1 X77.83 Y118.311 E.21807
G1 X77.83 Y117.747 E.00918
G1 X86.747 Y108.83 E.20509
G1 X86.182 Y108.83 E.00918
G1 X77.83 Y117.182 E.1921
G1 X77.83 Y116.618 E.00918
G1 X85.618 Y108.83 E.17912
G1 X85.054 Y108.83 E.00918
G1 X77.83 Y116.054 E.16614
G1 X77.83 Y115.489 E.00918
G1 X84.489 Y108.83 E.15316
G1 X83.925 Y108.83 E.00918
G1 X77.83 Y114.925 E.14017
G1 X77.83 Y114.36 E.00918
G1 X83.36 Y108.83 E.12719
G1 X82.796 Y108.83 E.00918
G1 X77.83 Y113.796 E.11421
G1 X77.83 Y113.231 E.00918
G1 X82.231 Y108.83 E.10123
G1 X81.667 Y108.83 E.00918
G1 X77.83 Y112.667 E.08824
G1 X77.83 Y112.102 E.00918
G1 X81.102 Y108.83 E.07526
G1 X80.538 Y108.83 E.00918
G1 X77.83 Y111.538 E.06228
G1 X77.83 Y110.973 E.00918
G1 X79.973 Y108.83 E.04929
G1 X79.409 Y108.83 E.00918
G1 X77.83 Y110.409 E.03631
G1 X77.83 Y109.844 E.00918
G1 X78.844 Y108.83 E.02333
G1 X78.28 Y108.83 E.00918
G1 X77.65 Y109.459 E.01447
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X78.28 Y108.83 E-.33815
G1 X78.844 Y108.83 E-.21451
G1 X78.458 Y109.216 E-.20735
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/24
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
M204 S10000
G17
G3 Z1.1 I-1.175 J-.315 P1  F30000
G1 X51.016 Y211.534 Z1.1
G1 Z.8
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #8
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
M73 P48 R27
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
M73 P48 R26
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.911 Y137.1 Z1.2 F30000
G1 X178.35 Y109.459 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S3000
G1 X177.721 Y108.83 E.01449
G1 X177.155 Y108.83 E.00921
G1 X178.17 Y109.845 E.02338
G1 X178.17 Y110.41 E.00921
G1 X176.59 Y108.83 E.03641
G1 X176.024 Y108.83 E.00921
G1 X178.17 Y110.976 E.04943
G1 X178.17 Y111.541 E.00921
G1 X175.459 Y108.83 E.06245
G1 X174.894 Y108.83 E.00921
G1 X178.17 Y112.106 E.07548
G1 X178.17 Y112.672 E.00921
G1 X174.328 Y108.83 E.0885
G1 X173.763 Y108.83 E.00921
G1 X178.17 Y113.237 E.10153
G1 X178.17 Y113.803 E.00921
G1 X173.197 Y108.83 E.11455
G1 X172.632 Y108.83 E.00921
G1 X178.17 Y114.368 E.12758
G1 X178.17 Y114.933 E.00921
G1 X172.067 Y108.83 E.1406
G1 X171.501 Y108.83 E.00921
G1 X178.17 Y115.499 E.15362
G1 X178.17 Y116.064 E.00921
G1 X170.936 Y108.83 E.16665
G1 X170.37 Y108.83 E.00921
G1 X178.17 Y116.629 E.17967
G1 X178.17 Y117.195 E.00921
G1 X169.805 Y108.83 E.1927
G1 X169.24 Y108.83 E.00921
G1 X178.17 Y117.76 E.20572
G1 X178.17 Y118.326 E.00921
G1 X168.674 Y108.83 E.21875
G1 X168.109 Y108.83 E.00921
G1 X178.17 Y118.891 E.23177
G1 X178.17 Y119.456 E.00921
G1 X167.544 Y108.83 E.24479
G1 X166.978 Y108.83 E.00921
G1 X178.17 Y120.022 E.25782
G1 X178.17 Y120.587 E.00921
G1 X166.413 Y108.83 E.27084
G1 X165.847 Y108.83 E.00921
G1 X178.17 Y121.153 E.28387
G1 X178.17 Y121.718 E.00921
G1 X165.282 Y108.83 E.29689
G1 X164.717 Y108.83 E.00921
G1 X178.17 Y122.283 E.30992
G1 X178.17 Y122.849 E.00921
G1 X164.151 Y108.83 E.32294
G1 X163.586 Y108.83 E.00921
G1 X178.17 Y123.414 E.33596
G1 X178.17 Y123.98 E.00921
G1 X163.02 Y108.83 E.34899
G1 X162.455 Y108.83 E.00921
G1 X178.17 Y124.545 E.36201
G1 X178.17 Y125.11 E.00921
G1 X161.89 Y108.83 E.37504
G1 X161.324 Y108.83 E.00921
G1 X178.17 Y125.676 E.38806
G1 X178.17 Y126.241 E.00921
G1 X160.759 Y108.83 E.40109
G1 X160.194 Y108.83 E.00921
G1 X178.17 Y126.806 E.41411
G1 X178.17 Y127.372 E.00921
G1 X159.628 Y108.83 E.42713
G1 X159.063 Y108.83 E.00921
G1 X178.17 Y127.937 E.44016
G1 X178.17 Y128.503 E.00921
G1 X158.497 Y108.83 E.45318
G1 X157.932 Y108.83 E.00921
G1 X178.17 Y129.068 E.46621
G1 X178.17 Y129.633 E.00921
G1 X157.367 Y108.83 E.47923
G1 X156.801 Y108.83 E.00921
G1 X178.17 Y130.199 E.49226
G1 X178.17 Y130.764 E.00921
G1 X156.236 Y108.83 E.50528
G1 X155.67 Y108.83 E.00921
G1 X178.17 Y131.33 E.5183
G1 X178.17 Y131.895 E.00921
G1 X155.105 Y108.83 E.53133
G1 X154.54 Y108.83 E.00921
G1 X178.17 Y132.46 E.54435
G1 X178.17 Y133.026 E.00921
G1 X153.974 Y108.83 E.55738
G1 X153.409 Y108.83 E.00921
G1 X178.17 Y133.591 E.5704
G1 X178.17 Y134.157 E.00921
G1 X152.843 Y108.83 E.58343
G1 X152.278 Y108.83 E.00921
G1 X178.17 Y134.722 E.59645
G1 X178.17 Y135.287 E.00921
G1 X151.713 Y108.83 E.60947
G1 X151.147 Y108.83 E.00921
G1 X178.17 Y135.853 E.6225
G1 X178.17 Y136.418 E.00921
G1 X150.582 Y108.83 E.63552
G1 X150.017 Y108.83 E.00921
G1 X178.17 Y136.983 E.64855
G1 X178.17 Y137.549 E.00921
G1 X149.451 Y108.83 E.66157
G1 X148.886 Y108.83 E.00921
G1 X178.17 Y138.114 E.6746
G1 X178.17 Y138.68 E.00921
G1 X148.32 Y108.83 E.68762
G1 X147.755 Y108.83 E.00921
G1 X178.17 Y139.245 E.70064
G1 X178.17 Y139.81 E.00921
G1 X147.19 Y108.83 E.71367
G1 X146.624 Y108.83 E.00921
G1 X178.17 Y140.376 E.72669
G1 X178.17 Y140.941 E.00921
G1 X146.059 Y108.83 E.73972
G1 X145.493 Y108.83 E.00921
G1 X178.17 Y141.507 E.75274
G1 X178.17 Y142.072 E.00921
G1 X144.928 Y108.83 E.76577
G1 X144.363 Y108.83 E.00921
G1 X178.17 Y142.637 E.77879
G1 X178.17 Y143.17 E.00868
G1 X178.138 Y143.17 E.00053
G1 X143.797 Y108.83 E.79106
G1 X143.232 Y108.83 E.00921
G1 X177.572 Y143.17 E.79106
G1 X177.007 Y143.17 E.00921
G1 X142.666 Y108.83 E.79106
G1 X142.101 Y108.83 E.00921
G1 X176.441 Y143.17 E.79106
G1 X175.876 Y143.17 E.00921
G1 X141.536 Y108.83 E.79106
G1 X140.97 Y108.83 E.00921
G1 X175.311 Y143.17 E.79106
G1 X174.745 Y143.17 E.00921
G1 X140.405 Y108.83 E.79106
G1 X139.84 Y108.83 E.00921
G1 X174.18 Y143.17 E.79106
G1 X173.614 Y143.17 E.00921
G1 X139.274 Y108.83 E.79106
G1 X138.709 Y108.83 E.00921
G1 X173.049 Y143.17 E.79106
G1 X172.484 Y143.17 E.00921
G1 X138.143 Y108.83 E.79106
G1 X137.578 Y108.83 E.00921
G1 X171.918 Y143.17 E.79106
G1 X171.353 Y143.17 E.00921
G1 X137.013 Y108.83 E.79106
G1 X136.447 Y108.83 E.00921
G1 X170.788 Y143.17 E.79106
G1 X170.222 Y143.17 E.00921
G1 X135.882 Y108.83 E.79106
G1 X135.316 Y108.83 E.00921
G1 X169.657 Y143.17 E.79106
G1 X169.091 Y143.17 E.00921
G1 X134.751 Y108.83 E.79106
G1 X134.186 Y108.83 E.00921
G1 X168.526 Y143.17 E.79106
G1 X167.961 Y143.17 E.00921
G1 X133.62 Y108.83 E.79106
M73 P49 R26
G1 X133.055 Y108.83 E.00921
G1 X167.395 Y143.17 E.79106
G1 X166.83 Y143.17 E.00921
G1 X132.489 Y108.83 E.79106
G1 X131.924 Y108.83 E.00921
G1 X166.264 Y143.17 E.79106
G1 X165.699 Y143.17 E.00921
G1 X131.359 Y108.83 E.79106
G1 X130.793 Y108.83 E.00921
G1 X165.134 Y143.17 E.79106
G1 X164.568 Y143.17 E.00921
G1 X130.228 Y108.83 E.79106
G1 X129.663 Y108.83 E.00921
G1 X164.003 Y143.17 E.79106
G1 X163.437 Y143.17 E.00921
G1 X129.097 Y108.83 E.79106
G1 X128.532 Y108.83 E.00921
G1 X162.872 Y143.17 E.79106
G1 X162.307 Y143.17 E.00921
G1 X127.966 Y108.83 E.79106
G1 X127.401 Y108.83 E.00921
G1 X161.741 Y143.17 E.79106
G1 X161.176 Y143.17 E.00921
G1 X126.836 Y108.83 E.79106
G1 X126.27 Y108.83 E.00921
G1 X160.611 Y143.17 E.79106
G1 X160.045 Y143.17 E.00921
G1 X125.705 Y108.83 E.79106
G1 X125.139 Y108.83 E.00921
G1 X159.48 Y143.17 E.79106
G1 X158.914 Y143.17 E.00921
G1 X124.574 Y108.83 E.79106
G1 X124.009 Y108.83 E.00921
G1 X158.349 Y143.17 E.79106
G1 X157.784 Y143.17 E.00921
G1 X123.443 Y108.83 E.79106
G1 X122.878 Y108.83 E.00921
G1 X157.218 Y143.17 E.79106
G1 X156.653 Y143.17 E.00921
G1 X122.312 Y108.83 E.79106
G1 X121.747 Y108.83 E.00921
G1 X156.087 Y143.17 E.79106
G1 X155.522 Y143.17 E.00921
G1 X121.182 Y108.83 E.79106
G1 X120.616 Y108.83 E.00921
G1 X154.957 Y143.17 E.79106
G1 X154.391 Y143.17 E.00921
G1 X120.051 Y108.83 E.79106
G1 X119.486 Y108.83 E.00921
G1 X153.826 Y143.17 E.79106
G1 X153.261 Y143.17 E.00921
G1 X118.92 Y108.83 E.79106
G1 X118.355 Y108.83 E.00921
G1 X152.695 Y143.17 E.79106
G1 X152.13 Y143.17 E.00921
G1 X117.789 Y108.83 E.79106
G1 X117.224 Y108.83 E.00921
G1 X151.564 Y143.17 E.79106
G1 X150.999 Y143.17 E.00921
G1 X116.659 Y108.83 E.79106
G1 X116.093 Y108.83 E.00921
G1 X150.434 Y143.17 E.79106
G1 X149.868 Y143.17 E.00921
G1 X115.528 Y108.83 E.79106
G1 X114.962 Y108.83 E.00921
G1 X149.303 Y143.17 E.79106
G1 X148.737 Y143.17 E.00921
G1 X114.397 Y108.83 E.79106
G1 X113.832 Y108.83 E.00921
G1 X148.172 Y143.17 E.79106
G1 X147.607 Y143.17 E.00921
G1 X113.266 Y108.83 E.79106
G1 X112.701 Y108.83 E.00921
G1 X147.041 Y143.17 E.79106
G1 X146.476 Y143.17 E.00921
G1 X112.135 Y108.83 E.79106
G1 X111.57 Y108.83 E.00921
G1 X145.91 Y143.17 E.79106
G1 X145.345 Y143.17 E.00921
G1 X111.005 Y108.83 E.79106
G1 X110.439 Y108.83 E.00921
G1 X144.78 Y143.17 E.79106
G1 X144.214 Y143.17 E.00921
G1 X109.874 Y108.83 E.79106
G1 X109.309 Y108.83 E.00921
G1 X143.649 Y143.17 E.79106
G1 X143.084 Y143.17 E.00921
G1 X108.743 Y108.83 E.79106
G1 X108.178 Y108.83 E.00921
G1 X142.518 Y143.17 E.79106
G1 X141.953 Y143.17 E.00921
G1 X107.612 Y108.83 E.79106
G1 X107.047 Y108.83 E.00921
G1 X141.387 Y143.17 E.79106
G1 X140.822 Y143.17 E.00921
G1 X106.482 Y108.83 E.79106
G1 X105.916 Y108.83 E.00921
G1 X140.257 Y143.17 E.79106
G1 X139.691 Y143.17 E.00921
G1 X105.351 Y108.83 E.79106
G1 X104.785 Y108.83 E.00921
G1 X139.126 Y143.17 E.79106
G1 X138.56 Y143.17 E.00921
G1 X104.22 Y108.83 E.79106
G1 X103.655 Y108.83 E.00921
G1 X137.995 Y143.17 E.79106
G1 X137.43 Y143.17 E.00921
G1 X103.089 Y108.83 E.79106
G1 X102.524 Y108.83 E.00921
G1 X136.864 Y143.17 E.79106
G1 X136.299 Y143.17 E.00921
G1 X101.958 Y108.83 E.79106
G1 X101.393 Y108.83 E.00921
G1 X135.733 Y143.17 E.79106
G1 X135.168 Y143.17 E.00921
G1 X100.828 Y108.83 E.79106
G1 X100.262 Y108.83 E.00921
G1 X134.603 Y143.17 E.79106
G1 X134.037 Y143.17 E.00921
G1 X99.697 Y108.83 E.79106
G1 X99.132 Y108.83 E.00921
G1 X133.472 Y143.17 E.79106
G1 X132.907 Y143.17 E.00921
G1 X98.566 Y108.83 E.79106
G1 X98.001 Y108.83 E.00921
G1 X132.341 Y143.17 E.79106
G1 X131.776 Y143.17 E.00921
M73 P49 R25
G1 X97.435 Y108.83 E.79106
G1 X96.87 Y108.83 E.00921
G1 X131.21 Y143.17 E.79106
G1 X130.645 Y143.17 E.00921
M73 P50 R25
G1 X96.305 Y108.83 E.79106
G1 X95.739 Y108.83 E.00921
G1 X130.08 Y143.17 E.79106
G1 X129.514 Y143.17 E.00921
G1 X95.174 Y108.83 E.79106
G1 X94.608 Y108.83 E.00921
G1 X128.949 Y143.17 E.79106
G1 X128.383 Y143.17 E.00921
G1 X94.043 Y108.83 E.79106
G1 X93.478 Y108.83 E.00921
G1 X127.818 Y143.17 E.79106
G1 X127.253 Y143.17 E.00921
G1 X92.912 Y108.83 E.79106
G1 X92.347 Y108.83 E.00921
G1 X126.687 Y143.17 E.79106
G1 X126.122 Y143.17 E.00921
G1 X91.782 Y108.83 E.79106
G1 X91.216 Y108.83 E.00921
G1 X125.556 Y143.17 E.79106
G1 X124.991 Y143.17 E.00921
G1 X90.651 Y108.83 E.79106
G1 X90.085 Y108.83 E.00921
G1 X124.426 Y143.17 E.79106
G1 X123.86 Y143.17 E.00921
G1 X89.52 Y108.83 E.79106
G1 X88.955 Y108.83 E.00921
G1 X123.295 Y143.17 E.79106
G1 X122.73 Y143.17 E.00921
G1 X88.389 Y108.83 E.79106
G1 X87.824 Y108.83 E.00921
G1 X122.164 Y143.17 E.79106
G1 X121.599 Y143.17 E.00921
G1 X87.258 Y108.83 E.79106
G1 X86.693 Y108.83 E.00921
G1 X121.033 Y143.17 E.79106
G1 X120.468 Y143.17 E.00921
G1 X86.128 Y108.83 E.79106
G1 X85.562 Y108.83 E.00921
G1 X119.903 Y143.17 E.79106
G1 X119.337 Y143.17 E.00921
G1 X84.997 Y108.83 E.79106
G1 X84.431 Y108.83 E.00921
G1 X118.772 Y143.17 E.79106
G1 X118.206 Y143.17 E.00921
G1 X83.866 Y108.83 E.79106
G1 X83.301 Y108.83 E.00921
G1 X117.641 Y143.17 E.79106
G1 X117.076 Y143.17 E.00921
G1 X82.735 Y108.83 E.79106
G1 X82.17 Y108.83 E.00921
G1 X116.51 Y143.17 E.79106
G1 X115.945 Y143.17 E.00921
G1 X81.605 Y108.83 E.79106
G1 X81.039 Y108.83 E.00921
G1 X115.379 Y143.17 E.79106
G1 X114.814 Y143.17 E.00921
G1 X80.474 Y108.83 E.79106
G1 X79.908 Y108.83 E.00921
G1 X114.249 Y143.17 E.79106
G1 X113.683 Y143.17 E.00921
G1 X79.343 Y108.83 E.79106
G1 X78.778 Y108.83 E.00921
G1 X113.118 Y143.17 E.79106
G1 X112.553 Y143.17 E.00921
G1 X78.212 Y108.83 E.79106
G1 X77.83 Y108.83 E.00623
G1 X77.83 Y109.013 E.00298
G1 X111.987 Y143.17 E.78685
G1 X111.422 Y143.17 E.00921
G1 X77.83 Y109.578 E.77382
G1 X77.83 Y110.144 E.00921
G1 X110.856 Y143.17 E.7608
G1 X110.291 Y143.17 E.00921
G1 X77.83 Y110.709 E.74778
G1 X77.83 Y111.274 E.00921
G1 X109.726 Y143.17 E.73475
G1 X109.16 Y143.17 E.00921
G1 X77.83 Y111.84 E.72173
G1 X77.83 Y112.405 E.00921
G1 X108.595 Y143.17 E.7087
G1 X108.029 Y143.17 E.00921
G1 X77.83 Y112.971 E.69568
G1 X77.83 Y113.536 E.00921
G1 X107.464 Y143.17 E.68265
G1 X106.899 Y143.17 E.00921
G1 X77.83 Y114.101 E.66963
G1 X77.83 Y114.667 E.00921
G1 X106.333 Y143.17 E.65661
G1 X105.768 Y143.17 E.00921
G1 X77.83 Y115.232 E.64358
G1 X77.83 Y115.798 E.00921
G1 X105.202 Y143.17 E.63056
G1 X104.637 Y143.17 E.00921
G1 X77.83 Y116.363 E.61753
G1 X77.83 Y116.928 E.00921
G1 X104.072 Y143.17 E.60451
G1 X103.506 Y143.17 E.00921
G1 X77.83 Y117.494 E.59148
G1 X77.83 Y118.059 E.00921
G1 X102.941 Y143.17 E.57846
G1 X102.376 Y143.17 E.00921
G1 X77.83 Y118.624 E.56544
G1 X77.83 Y119.19 E.00921
G1 X101.81 Y143.17 E.55241
G1 X101.245 Y143.17 E.00921
G1 X77.83 Y119.755 E.53939
G1 X77.83 Y120.321 E.00921
G1 X100.679 Y143.17 E.52636
G1 X100.114 Y143.17 E.00921
G1 X77.83 Y120.886 E.51334
G1 X77.83 Y121.451 E.00921
G1 X99.549 Y143.17 E.50031
G1 X98.983 Y143.17 E.00921
G1 X77.83 Y122.017 E.48729
G1 X77.83 Y122.582 E.00921
G1 X98.418 Y143.17 E.47427
G1 X97.852 Y143.17 E.00921
M73 P51 R25
G1 X77.83 Y123.148 E.46124
G1 X77.83 Y123.713 E.00921
G1 X97.287 Y143.17 E.44822
G1 X96.722 Y143.17 E.00921
G1 X77.83 Y124.278 E.43519
G1 X77.83 Y124.844 E.00921
G1 X96.156 Y143.17 E.42217
G1 X95.591 Y143.17 E.00921
G1 X77.83 Y125.409 E.40914
G1 X77.83 Y125.974 E.00921
G1 X95.025 Y143.17 E.39612
G1 X94.46 Y143.17 E.00921
G1 X77.83 Y126.54 E.3831
G1 X77.83 Y127.105 E.00921
G1 X93.895 Y143.17 E.37007
G1 X93.329 Y143.17 E.00921
G1 X77.83 Y127.671 E.35705
G1 X77.83 Y128.236 E.00921
G1 X92.764 Y143.17 E.34402
G1 X92.199 Y143.17 E.00921
G1 X77.83 Y128.801 E.331
G1 X77.83 Y129.367 E.00921
G1 X91.633 Y143.17 E.31797
G1 X91.068 Y143.17 E.00921
G1 X77.83 Y129.932 E.30495
G1 X77.83 Y130.498 E.00921
G1 X90.502 Y143.17 E.29193
G1 X89.937 Y143.17 E.00921
G1 X77.83 Y131.063 E.2789
G1 X77.83 Y131.628 E.00921
G1 X89.372 Y143.17 E.26588
G1 X88.806 Y143.17 E.00921
G1 X77.83 Y132.194 E.25285
G1 X77.83 Y132.759 E.00921
G1 X88.241 Y143.17 E.23983
G1 X87.675 Y143.17 E.00921
G1 X77.83 Y133.325 E.2268
G1 X77.83 Y133.89 E.00921
G1 X87.11 Y143.17 E.21378
G1 X86.545 Y143.17 E.00921
G1 X77.83 Y134.455 E.20076
G1 X77.83 Y135.021 E.00921
G1 X85.979 Y143.17 E.18773
G1 X85.414 Y143.17 E.00921
G1 X77.83 Y135.586 E.17471
G1 X77.83 Y136.151 E.00921
G1 X84.849 Y143.17 E.16168
G1 X84.283 Y143.17 E.00921
G1 X77.83 Y136.717 E.14866
G1 X77.83 Y137.282 E.00921
G1 X83.718 Y143.17 E.13563
G1 X83.152 Y143.17 E.00921
G1 X77.83 Y137.848 E.12261
G1 X77.83 Y138.413 E.00921
G1 X82.587 Y143.17 E.10959
G1 X82.022 Y143.17 E.00921
G1 X77.83 Y138.978 E.09656
G1 X77.83 Y139.544 E.00921
G1 X81.456 Y143.17 E.08354
G1 X80.891 Y143.17 E.00921
G1 X77.83 Y140.109 E.07051
G1 X77.83 Y140.675 E.00921
G1 X80.325 Y143.17 E.05749
G1 X79.76 Y143.17 E.00921
G1 X77.65 Y141.061 E.0486
; CHANGE_LAYER
; Z_HEIGHT: 0.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X79.065 Y142.475 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/24
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
M204 S10000
G17
G3 Z1.2 I-1.128 J-.458 P1  F30000
G1 X51.016 Y211.534 Z1.2
G1 Z.9
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #9
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.3 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
M73 P51 R24
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.543 Y143.35 Z1.3 F30000
G1 Z.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S3000
G1 X178.17 Y142.722 E.01443
G1 X178.17 Y142.157 E.00918
G1 X177.157 Y143.17 E.02329
G1 X176.593 Y143.17 E.00918
G1 X178.17 Y141.593 E.03627
G1 X178.17 Y141.028 E.00918
G1 X176.028 Y143.17 E.04926
G1 X175.464 Y143.17 E.00918
G1 X178.17 Y140.464 E.06224
G1 X178.17 Y139.9 E.00918
G1 X174.899 Y143.17 E.07522
G1 X174.335 Y143.17 E.00918
G1 X178.17 Y139.335 E.08821
M73 P52 R24
G1 X178.17 Y138.771 E.00918
G1 X173.771 Y143.17 E.10119
G1 X173.206 Y143.17 E.00918
G1 X178.17 Y138.206 E.11417
G1 X178.17 Y137.642 E.00918
G1 X172.642 Y143.17 E.12715
G1 X172.077 Y143.17 E.00918
G1 X178.17 Y137.077 E.14014
G1 X178.17 Y136.513 E.00918
G1 X171.513 Y143.17 E.15312
G1 X170.948 Y143.17 E.00918
G1 X178.17 Y135.948 E.1661
G1 X178.17 Y135.384 E.00918
G1 X170.384 Y143.17 E.17908
G1 X169.819 Y143.17 E.00918
G1 X178.17 Y134.819 E.19207
G1 X178.17 Y134.255 E.00918
G1 X169.255 Y143.17 E.20505
G1 X168.69 Y143.17 E.00918
G1 X178.17 Y133.69 E.21803
G1 X178.17 Y133.126 E.00918
G1 X168.126 Y143.17 E.23101
G1 X167.561 Y143.17 E.00918
G1 X178.17 Y132.561 E.244
G1 X178.17 Y131.997 E.00918
G1 X166.997 Y143.17 E.25698
G1 X166.432 Y143.17 E.00918
G1 X178.17 Y131.432 E.26996
G1 X178.17 Y130.868 E.00918
G1 X165.868 Y143.17 E.28294
G1 X165.303 Y143.17 E.00918
G1 X178.17 Y130.303 E.29593
G1 X178.17 Y129.739 E.00918
G1 X164.739 Y143.17 E.30891
G1 X164.174 Y143.17 E.00918
G1 X178.17 Y129.174 E.32189
G1 X178.17 Y128.61 E.00918
G1 X163.61 Y143.17 E.33488
G1 X163.045 Y143.17 E.00918
G1 X178.17 Y128.045 E.34786
G1 X178.17 Y127.481 E.00918
G1 X162.481 Y143.17 E.36084
G1 X161.916 Y143.17 E.00918
G1 X178.17 Y126.916 E.37382
G1 X178.17 Y126.352 E.00918
G1 X161.352 Y143.17 E.38681
G1 X160.787 Y143.17 E.00918
G1 X178.17 Y125.787 E.39979
G1 X178.17 Y125.223 E.00918
G1 X160.223 Y143.17 E.41277
G1 X159.658 Y143.17 E.00918
G1 X178.17 Y124.658 E.42575
G1 X178.17 Y124.094 E.00918
G1 X159.094 Y143.17 E.43874
G1 X158.529 Y143.17 E.00918
G1 X178.17 Y123.529 E.45172
G1 X178.17 Y122.965 E.00918
G1 X157.965 Y143.17 E.4647
G1 X157.401 Y143.17 E.00918
G1 X178.17 Y122.401 E.47768
G1 X178.17 Y121.836 E.00918
G1 X156.836 Y143.17 E.49067
G1 X156.272 Y143.17 E.00918
G1 X178.17 Y121.272 E.50365
G1 X178.17 Y120.707 E.00918
G1 X155.707 Y143.17 E.51663
G1 X155.143 Y143.17 E.00918
G1 X178.17 Y120.143 E.52961
G1 X178.17 Y119.578 E.00918
G1 X154.578 Y143.17 E.5426
G1 X154.014 Y143.17 E.00918
G1 X178.17 Y119.014 E.55558
G1 X178.17 Y118.449 E.00918
G1 X153.449 Y143.17 E.56856
G1 X152.885 Y143.17 E.00918
G1 X178.17 Y117.885 E.58155
G1 X178.17 Y117.32 E.00918
G1 X152.32 Y143.17 E.59453
G1 X151.756 Y143.17 E.00918
G1 X178.17 Y116.756 E.60751
G1 X178.17 Y116.191 E.00918
G1 X151.191 Y143.17 E.62049
G1 X150.627 Y143.17 E.00918
G1 X178.17 Y115.627 E.63348
G1 X178.17 Y115.062 E.00918
G1 X150.062 Y143.17 E.64646
G1 X149.498 Y143.17 E.00918
G1 X178.17 Y114.498 E.65944
G1 X178.17 Y113.933 E.00918
G1 X148.933 Y143.17 E.67242
G1 X148.369 Y143.17 E.00918
G1 X178.17 Y113.369 E.68541
G1 X178.17 Y112.804 E.00918
G1 X147.804 Y143.17 E.69839
G1 X147.24 Y143.17 E.00918
G1 X178.17 Y112.24 E.71137
G1 X178.17 Y111.675 E.00918
G1 X146.675 Y143.17 E.72435
G1 X146.111 Y143.17 E.00918
G1 X178.17 Y111.111 E.73734
G1 X178.17 Y110.546 E.00918
G1 X145.546 Y143.17 E.75032
G1 X144.982 Y143.17 E.00918
G1 X178.17 Y109.982 E.7633
G1 X178.17 Y109.417 E.00918
G1 X144.417 Y143.17 E.77628
G1 X143.853 Y143.17 E.00918
G1 X178.17 Y108.853 E.78927
G1 X178.17 Y108.83 E.00038
G1 X177.629 Y108.83 E.0088
G1 X143.288 Y143.17 E.7898
G1 X142.724 Y143.17 E.00918
G1 X177.064 Y108.83 E.7898
G1 X176.5 Y108.83 E.00918
G1 X142.159 Y143.17 E.7898
G1 X141.595 Y143.17 E.00918
G1 X175.935 Y108.83 E.7898
G1 X175.371 Y108.83 E.00918
G1 X141.03 Y143.17 E.7898
G1 X140.466 Y143.17 E.00918
G1 X174.806 Y108.83 E.7898
G1 X174.242 Y108.83 E.00918
G1 X139.902 Y143.17 E.7898
G1 X139.337 Y143.17 E.00918
G1 X173.677 Y108.83 E.7898
G1 X173.113 Y108.83 E.00918
G1 X138.773 Y143.17 E.7898
G1 X138.208 Y143.17 E.00918
G1 X172.548 Y108.83 E.7898
G1 X171.984 Y108.83 E.00918
G1 X137.644 Y143.17 E.7898
G1 X137.079 Y143.17 E.00918
G1 X171.419 Y108.83 E.7898
G1 X170.855 Y108.83 E.00918
G1 X136.515 Y143.17 E.7898
G1 X135.95 Y143.17 E.00918
G1 X170.291 Y108.83 E.7898
G1 X169.726 Y108.83 E.00918
G1 X135.386 Y143.17 E.7898
G1 X134.821 Y143.17 E.00918
G1 X169.162 Y108.83 E.7898
G1 X168.597 Y108.83 E.00918
G1 X134.257 Y143.17 E.7898
G1 X133.692 Y143.17 E.00918
G1 X168.033 Y108.83 E.7898
G1 X167.468 Y108.83 E.00918
G1 X133.128 Y143.17 E.7898
G1 X132.563 Y143.17 E.00918
G1 X166.904 Y108.83 E.7898
G1 X166.339 Y108.83 E.00918
G1 X131.999 Y143.17 E.7898
G1 X131.434 Y143.17 E.00918
G1 X165.775 Y108.83 E.7898
G1 X165.21 Y108.83 E.00918
G1 X130.87 Y143.17 E.7898
G1 X130.305 Y143.17 E.00918
G1 X164.646 Y108.83 E.7898
G1 X164.081 Y108.83 E.00918
G1 X129.741 Y143.17 E.7898
G1 X129.176 Y143.17 E.00918
G1 X163.517 Y108.83 E.7898
G1 X162.952 Y108.83 E.00918
G1 X128.612 Y143.17 E.7898
G1 X128.047 Y143.17 E.00918
G1 X162.388 Y108.83 E.7898
G1 X161.823 Y108.83 E.00918
G1 X127.483 Y143.17 E.7898
G1 X126.918 Y143.17 E.00918
G1 X161.259 Y108.83 E.7898
G1 X160.694 Y108.83 E.00918
G1 X126.354 Y143.17 E.7898
G1 X125.789 Y143.17 E.00918
G1 X160.13 Y108.83 E.7898
G1 X159.565 Y108.83 E.00918
G1 X125.225 Y143.17 E.7898
G1 X124.66 Y143.17 E.00918
G1 X159.001 Y108.83 E.7898
G1 X158.436 Y108.83 E.00918
G1 X124.096 Y143.17 E.7898
G1 X123.532 Y143.17 E.00918
G1 X157.872 Y108.83 E.7898
G1 X157.307 Y108.83 E.00918
G1 X122.967 Y143.17 E.7898
G1 X122.403 Y143.17 E.00918
G1 X156.743 Y108.83 E.7898
G1 X156.178 Y108.83 E.00918
G1 X121.838 Y143.17 E.7898
M73 P53 R24
G1 X121.274 Y143.17 E.00918
G1 X155.614 Y108.83 E.7898
G1 X155.049 Y108.83 E.00918
G1 X120.709 Y143.17 E.7898
G1 X120.145 Y143.17 E.00918
G1 X154.485 Y108.83 E.7898
G1 X153.92 Y108.83 E.00918
G1 X119.58 Y143.17 E.7898
G1 X119.016 Y143.17 E.00918
G1 X153.356 Y108.83 E.7898
G1 X152.792 Y108.83 E.00918
G1 X118.451 Y143.17 E.7898
G1 X117.887 Y143.17 E.00918
G1 X152.227 Y108.83 E.7898
G1 X151.663 Y108.83 E.00918
G1 X117.322 Y143.17 E.7898
G1 X116.758 Y143.17 E.00918
G1 X151.098 Y108.83 E.7898
G1 X150.534 Y108.83 E.00918
G1 X116.193 Y143.17 E.7898
G1 X115.629 Y143.17 E.00918
G1 X149.969 Y108.83 E.7898
G1 X149.405 Y108.83 E.00918
G1 X115.064 Y143.17 E.7898
G1 X114.5 Y143.17 E.00918
G1 X148.84 Y108.83 E.7898
G1 X148.276 Y108.83 E.00918
G1 X113.935 Y143.17 E.7898
G1 X113.371 Y143.17 E.00918
G1 X147.711 Y108.83 E.7898
G1 X147.147 Y108.83 E.00918
G1 X112.806 Y143.17 E.7898
G1 X112.242 Y143.17 E.00918
G1 X146.582 Y108.83 E.7898
G1 X146.018 Y108.83 E.00918
G1 X111.677 Y143.17 E.7898
G1 X111.113 Y143.17 E.00918
G1 X145.453 Y108.83 E.7898
G1 X144.889 Y108.83 E.00918
G1 X110.548 Y143.17 E.7898
G1 X109.984 Y143.17 E.00918
G1 X144.324 Y108.83 E.7898
G1 X143.76 Y108.83 E.00918
G1 X109.419 Y143.17 E.7898
G1 X108.855 Y143.17 E.00918
G1 X143.195 Y108.83 E.7898
G1 X142.631 Y108.83 E.00918
G1 X108.29 Y143.17 E.7898
G1 X107.726 Y143.17 E.00918
G1 X142.066 Y108.83 E.7898
G1 X141.502 Y108.83 E.00918
G1 X107.161 Y143.17 E.7898
G1 X106.597 Y143.17 E.00918
G1 X140.937 Y108.83 E.7898
G1 X140.373 Y108.83 E.00918
G1 X106.033 Y143.17 E.7898
G1 X105.468 Y143.17 E.00918
G1 X139.808 Y108.83 E.7898
G1 X139.244 Y108.83 E.00918
G1 X104.904 Y143.17 E.7898
G1 X104.339 Y143.17 E.00918
G1 X138.679 Y108.83 E.7898
G1 X138.115 Y108.83 E.00918
G1 X103.775 Y143.17 E.7898
G1 X103.21 Y143.17 E.00918
G1 X137.55 Y108.83 E.7898
G1 X136.986 Y108.83 E.00918
G1 X102.646 Y143.17 E.7898
G1 X102.081 Y143.17 E.00918
G1 X136.421 Y108.83 E.7898
G1 X135.857 Y108.83 E.00918
G1 X101.517 Y143.17 E.7898
G1 X100.952 Y143.17 E.00918
G1 X135.293 Y108.83 E.7898
G1 X134.728 Y108.83 E.00918
G1 X100.388 Y143.17 E.7898
G1 X99.823 Y143.17 E.00918
G1 X134.164 Y108.83 E.7898
G1 X133.599 Y108.83 E.00918
G1 X99.259 Y143.17 E.7898
G1 X98.694 Y143.17 E.00918
G1 X133.035 Y108.83 E.7898
G1 X132.47 Y108.83 E.00918
G1 X98.13 Y143.17 E.7898
G1 X97.565 Y143.17 E.00918
G1 X131.906 Y108.83 E.7898
G1 X131.341 Y108.83 E.00918
G1 X97.001 Y143.17 E.7898
G1 X96.436 Y143.17 E.00918
G1 X130.777 Y108.83 E.7898
G1 X130.212 Y108.83 E.00918
G1 X95.872 Y143.17 E.7898
G1 X95.307 Y143.17 E.00918
G1 X129.648 Y108.83 E.7898
G1 X129.083 Y108.83 E.00918
G1 X94.743 Y143.17 E.7898
G1 X94.178 Y143.17 E.00918
M73 P53 R23
G1 X128.519 Y108.83 E.7898
G1 X127.954 Y108.83 E.00918
G1 X93.614 Y143.17 E.7898
G1 X93.049 Y143.17 E.00918
G1 X127.39 Y108.83 E.7898
G1 X126.825 Y108.83 E.00918
G1 X92.485 Y143.17 E.7898
G1 X91.92 Y143.17 E.00918
G1 X126.261 Y108.83 E.7898
G1 X125.696 Y108.83 E.00918
G1 X91.356 Y143.17 E.7898
G1 X90.791 Y143.17 E.00918
G1 X125.132 Y108.83 E.7898
G1 X124.567 Y108.83 E.00918
G1 X90.227 Y143.17 E.7898
G1 X89.662 Y143.17 E.00918
G1 X124.003 Y108.83 E.7898
G1 X123.438 Y108.83 E.00918
G1 X89.098 Y143.17 E.7898
G1 X88.534 Y143.17 E.00918
G1 X122.874 Y108.83 E.7898
G1 X122.309 Y108.83 E.00918
M73 P54 R23
G1 X87.969 Y143.17 E.7898
G1 X87.405 Y143.17 E.00918
G1 X121.745 Y108.83 E.7898
G1 X121.18 Y108.83 E.00918
G1 X86.84 Y143.17 E.7898
G1 X86.276 Y143.17 E.00918
G1 X120.616 Y108.83 E.7898
G1 X120.051 Y108.83 E.00918
G1 X85.711 Y143.17 E.7898
G1 X85.147 Y143.17 E.00918
G1 X119.487 Y108.83 E.7898
G1 X118.923 Y108.83 E.00918
G1 X84.582 Y143.17 E.7898
G1 X84.018 Y143.17 E.00918
G1 X118.358 Y108.83 E.7898
G1 X117.794 Y108.83 E.00918
G1 X83.453 Y143.17 E.7898
G1 X82.889 Y143.17 E.00918
G1 X117.229 Y108.83 E.7898
G1 X116.665 Y108.83 E.00918
G1 X82.324 Y143.17 E.7898
G1 X81.76 Y143.17 E.00918
G1 X116.1 Y108.83 E.7898
G1 X115.536 Y108.83 E.00918
G1 X81.195 Y143.17 E.7898
G1 X80.631 Y143.17 E.00918
G1 X114.971 Y108.83 E.7898
G1 X114.407 Y108.83 E.00918
G1 X80.066 Y143.17 E.7898
G1 X79.758 Y143.17 E.00501
G1 X79.63 Y143.042 E.00295
G1 X113.842 Y108.83 E.78685
G1 X113.278 Y108.83 E.00918
G1 X79.348 Y142.76 E.78036
G1 X79.065 Y142.478 E.00649
G1 X112.713 Y108.83 E.77387
G1 X112.149 Y108.83 E.00918
G1 X78.783 Y142.195 E.76738
G1 X78.501 Y141.913 E.00649
G1 X111.584 Y108.83 E.76089
G1 X111.02 Y108.83 E.00918
G1 X78.219 Y141.631 E.7544
G1 X77.936 Y141.349 E.00649
G1 X110.455 Y108.83 E.7479
G1 X109.891 Y108.83 E.00918
G1 X77.83 Y140.891 E.73737
G1 X77.83 Y140.326 E.00918
G1 X109.326 Y108.83 E.72439
G1 X108.762 Y108.83 E.00918
G1 X77.83 Y139.762 E.71141
G1 X77.83 Y139.197 E.00918
G1 X108.197 Y108.83 E.69843
G1 X107.633 Y108.83 E.00918
G1 X77.83 Y138.633 E.68544
G1 X77.83 Y138.068 E.00918
G1 X107.068 Y108.83 E.67246
G1 X106.504 Y108.83 E.00918
G1 X77.83 Y137.504 E.65948
G1 X77.83 Y136.939 E.00918
G1 X105.939 Y108.83 E.6465
G1 X105.375 Y108.83 E.00918
G1 X77.83 Y136.375 E.63351
G1 X77.83 Y135.81 E.00918
G1 X104.81 Y108.83 E.62053
G1 X104.246 Y108.83 E.00918
G1 X77.83 Y135.246 E.60755
G1 X77.83 Y134.681 E.00918
G1 X103.681 Y108.83 E.59457
G1 X103.117 Y108.83 E.00918
G1 X77.83 Y134.117 E.58158
G1 X77.83 Y133.552 E.00918
G1 X102.552 Y108.83 E.5686
G1 X101.988 Y108.83 E.00918
G1 X77.83 Y132.988 E.55562
G1 X77.83 Y132.424 E.00918
G1 X101.424 Y108.83 E.54263
G1 X100.859 Y108.83 E.00918
G1 X77.83 Y131.859 E.52965
G1 X77.83 Y131.295 E.00918
G1 X100.295 Y108.83 E.51667
G1 X99.73 Y108.83 E.00918
G1 X77.83 Y130.73 E.50369
G1 X77.83 Y130.166 E.00918
G1 X99.166 Y108.83 E.4907
G1 X98.601 Y108.83 E.00918
G1 X77.83 Y129.601 E.47772
G1 X77.83 Y129.037 E.00918
G1 X98.037 Y108.83 E.46474
G1 X97.472 Y108.83 E.00918
G1 X77.83 Y128.472 E.45176
G1 X77.83 Y127.908 E.00918
G1 X96.908 Y108.83 E.43877
G1 X96.343 Y108.83 E.00918
G1 X77.83 Y127.343 E.42579
G1 X77.83 Y126.779 E.00918
G1 X95.779 Y108.83 E.41281
G1 X95.214 Y108.83 E.00918
G1 X77.83 Y126.214 E.39983
G1 X77.83 Y125.65 E.00918
G1 X94.65 Y108.83 E.38684
G1 X94.085 Y108.83 E.00918
G1 X77.83 Y125.085 E.37386
G1 X77.83 Y124.521 E.00918
G1 X93.521 Y108.83 E.36088
G1 X92.956 Y108.83 E.00918
G1 X77.83 Y123.956 E.3479
G1 X77.83 Y123.392 E.00918
G1 X92.392 Y108.83 E.33491
G1 X91.827 Y108.83 E.00918
G1 X77.83 Y122.827 E.32193
G1 X77.83 Y122.263 E.00918
G1 X91.263 Y108.83 E.30895
G1 X90.698 Y108.83 E.00918
G1 X77.83 Y121.698 E.29596
G1 X77.83 Y121.134 E.00918
G1 X90.134 Y108.83 E.28298
G1 X89.569 Y108.83 E.00918
G1 X77.83 Y120.569 E.27
M73 P55 R23
G1 X77.83 Y120.005 E.00918
G1 X89.005 Y108.83 E.25702
G1 X88.44 Y108.83 E.00918
G1 X77.83 Y119.44 E.24403
G1 X77.83 Y118.876 E.00918
G1 X87.876 Y108.83 E.23105
G1 X87.311 Y108.83 E.00918
G1 X77.83 Y118.311 E.21807
G1 X77.83 Y117.747 E.00918
G1 X86.747 Y108.83 E.20509
G1 X86.182 Y108.83 E.00918
G1 X77.83 Y117.182 E.1921
G1 X77.83 Y116.618 E.00918
G1 X85.618 Y108.83 E.17912
G1 X85.054 Y108.83 E.00918
G1 X77.83 Y116.054 E.16614
G1 X77.83 Y115.489 E.00918
G1 X84.489 Y108.83 E.15316
G1 X83.925 Y108.83 E.00918
G1 X77.83 Y114.925 E.14017
G1 X77.83 Y114.36 E.00918
G1 X83.36 Y108.83 E.12719
G1 X82.796 Y108.83 E.00918
G1 X77.83 Y113.796 E.11421
G1 X77.83 Y113.231 E.00918
G1 X82.231 Y108.83 E.10123
G1 X81.667 Y108.83 E.00918
G1 X77.83 Y112.667 E.08824
G1 X77.83 Y112.102 E.00918
G1 X81.102 Y108.83 E.07526
G1 X80.538 Y108.83 E.00918
G1 X77.83 Y111.538 E.06228
G1 X77.83 Y110.973 E.00918
G1 X79.973 Y108.83 E.04929
G1 X79.409 Y108.83 E.00918
G1 X77.83 Y110.409 E.03631
G1 X77.83 Y109.844 E.00918
G1 X78.844 Y108.83 E.02333
G1 X78.28 Y108.83 E.00918
G1 X77.65 Y109.459 E.01447
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X78.28 Y108.83 E-.33815
G1 X78.844 Y108.83 E-.21451
G1 X78.458 Y109.216 E-.20735
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/24
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
M204 S10000
G17
G3 Z1.3 I-1.175 J-.315 P1  F30000
G1 X51.016 Y211.534 Z1.3
G1 Z1
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #10
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.4 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.911 Y137.1 Z1.4 F30000
G1 X178.35 Y109.459 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S3000
G1 X177.721 Y108.83 E.01449
G1 X177.155 Y108.83 E.00921
G1 X178.17 Y109.845 E.02338
G1 X178.17 Y110.41 E.00921
G1 X176.59 Y108.83 E.03641
G1 X176.024 Y108.83 E.00921
G1 X178.17 Y110.976 E.04943
G1 X178.17 Y111.541 E.00921
G1 X175.459 Y108.83 E.06245
G1 X174.894 Y108.83 E.00921
M73 P55 R22
G1 X178.17 Y112.106 E.07548
G1 X178.17 Y112.672 E.00921
G1 X174.328 Y108.83 E.0885
G1 X173.763 Y108.83 E.00921
G1 X178.17 Y113.237 E.10153
G1 X178.17 Y113.803 E.00921
G1 X173.197 Y108.83 E.11455
G1 X172.632 Y108.83 E.00921
G1 X178.17 Y114.368 E.12758
G1 X178.17 Y114.933 E.00921
G1 X172.067 Y108.83 E.1406
G1 X171.501 Y108.83 E.00921
G1 X178.17 Y115.499 E.15362
G1 X178.17 Y116.064 E.00921
G1 X170.936 Y108.83 E.16665
G1 X170.37 Y108.83 E.00921
G1 X178.17 Y116.629 E.17967
G1 X178.17 Y117.195 E.00921
G1 X169.805 Y108.83 E.1927
G1 X169.24 Y108.83 E.00921
G1 X178.17 Y117.76 E.20572
G1 X178.17 Y118.326 E.00921
G1 X168.674 Y108.83 E.21875
G1 X168.109 Y108.83 E.00921
G1 X178.17 Y118.891 E.23177
G1 X178.17 Y119.456 E.00921
G1 X167.544 Y108.83 E.24479
G1 X166.978 Y108.83 E.00921
G1 X178.17 Y120.022 E.25782
G1 X178.17 Y120.587 E.00921
G1 X166.413 Y108.83 E.27084
G1 X165.847 Y108.83 E.00921
G1 X178.17 Y121.153 E.28387
G1 X178.17 Y121.718 E.00921
G1 X165.282 Y108.83 E.29689
G1 X164.717 Y108.83 E.00921
G1 X178.17 Y122.283 E.30992
G1 X178.17 Y122.849 E.00921
G1 X164.151 Y108.83 E.32294
G1 X163.586 Y108.83 E.00921
G1 X178.17 Y123.414 E.33596
G1 X178.17 Y123.98 E.00921
G1 X163.02 Y108.83 E.34899
G1 X162.455 Y108.83 E.00921
G1 X178.17 Y124.545 E.36201
G1 X178.17 Y125.11 E.00921
G1 X161.89 Y108.83 E.37504
G1 X161.324 Y108.83 E.00921
G1 X178.17 Y125.676 E.38806
G1 X178.17 Y126.241 E.00921
G1 X160.759 Y108.83 E.40109
G1 X160.194 Y108.83 E.00921
G1 X178.17 Y126.806 E.41411
G1 X178.17 Y127.372 E.00921
G1 X159.628 Y108.83 E.42713
G1 X159.063 Y108.83 E.00921
G1 X178.17 Y127.937 E.44016
G1 X178.17 Y128.503 E.00921
G1 X158.497 Y108.83 E.45318
M73 P56 R22
G1 X157.932 Y108.83 E.00921
G1 X178.17 Y129.068 E.46621
G1 X178.17 Y129.633 E.00921
G1 X157.367 Y108.83 E.47923
G1 X156.801 Y108.83 E.00921
G1 X178.17 Y130.199 E.49226
G1 X178.17 Y130.764 E.00921
G1 X156.236 Y108.83 E.50528
G1 X155.67 Y108.83 E.00921
G1 X178.17 Y131.33 E.5183
G1 X178.17 Y131.895 E.00921
G1 X155.105 Y108.83 E.53133
G1 X154.54 Y108.83 E.00921
G1 X178.17 Y132.46 E.54435
G1 X178.17 Y133.026 E.00921
G1 X153.974 Y108.83 E.55738
G1 X153.409 Y108.83 E.00921
G1 X178.17 Y133.591 E.5704
G1 X178.17 Y134.157 E.00921
G1 X152.843 Y108.83 E.58343
G1 X152.278 Y108.83 E.00921
G1 X178.17 Y134.722 E.59645
G1 X178.17 Y135.287 E.00921
G1 X151.713 Y108.83 E.60947
G1 X151.147 Y108.83 E.00921
G1 X178.17 Y135.853 E.6225
G1 X178.17 Y136.418 E.00921
G1 X150.582 Y108.83 E.63552
G1 X150.017 Y108.83 E.00921
G1 X178.17 Y136.983 E.64855
G1 X178.17 Y137.549 E.00921
G1 X149.451 Y108.83 E.66157
G1 X148.886 Y108.83 E.00921
G1 X178.17 Y138.114 E.6746
G1 X178.17 Y138.68 E.00921
G1 X148.32 Y108.83 E.68762
G1 X147.755 Y108.83 E.00921
G1 X178.17 Y139.245 E.70064
G1 X178.17 Y139.81 E.00921
G1 X147.19 Y108.83 E.71367
G1 X146.624 Y108.83 E.00921
G1 X178.17 Y140.376 E.72669
G1 X178.17 Y140.941 E.00921
G1 X146.059 Y108.83 E.73972
G1 X145.493 Y108.83 E.00921
G1 X178.17 Y141.507 E.75274
G1 X178.17 Y142.072 E.00921
G1 X144.928 Y108.83 E.76577
G1 X144.363 Y108.83 E.00921
G1 X178.17 Y142.637 E.77879
G1 X178.17 Y143.17 E.00868
G1 X178.138 Y143.17 E.00053
G1 X143.797 Y108.83 E.79106
G1 X143.232 Y108.83 E.00921
G1 X177.572 Y143.17 E.79106
G1 X177.007 Y143.17 E.00921
G1 X142.666 Y108.83 E.79106
G1 X142.101 Y108.83 E.00921
G1 X176.441 Y143.17 E.79106
G1 X175.876 Y143.17 E.00921
G1 X141.536 Y108.83 E.79106
G1 X140.97 Y108.83 E.00921
G1 X175.311 Y143.17 E.79106
G1 X174.745 Y143.17 E.00921
G1 X140.405 Y108.83 E.79106
G1 X139.84 Y108.83 E.00921
G1 X174.18 Y143.17 E.79106
G1 X173.614 Y143.17 E.00921
G1 X139.274 Y108.83 E.79106
G1 X138.709 Y108.83 E.00921
G1 X173.049 Y143.17 E.79106
G1 X172.484 Y143.17 E.00921
G1 X138.143 Y108.83 E.79106
G1 X137.578 Y108.83 E.00921
G1 X171.918 Y143.17 E.79106
G1 X171.353 Y143.17 E.00921
G1 X137.013 Y108.83 E.79106
G1 X136.447 Y108.83 E.00921
G1 X170.788 Y143.17 E.79106
G1 X170.222 Y143.17 E.00921
G1 X135.882 Y108.83 E.79106
G1 X135.316 Y108.83 E.00921
G1 X169.657 Y143.17 E.79106
G1 X169.091 Y143.17 E.00921
G1 X134.751 Y108.83 E.79106
G1 X134.186 Y108.83 E.00921
G1 X168.526 Y143.17 E.79106
G1 X167.961 Y143.17 E.00921
G1 X133.62 Y108.83 E.79106
G1 X133.055 Y108.83 E.00921
G1 X167.395 Y143.17 E.79106
G1 X166.83 Y143.17 E.00921
G1 X132.489 Y108.83 E.79106
G1 X131.924 Y108.83 E.00921
G1 X166.264 Y143.17 E.79106
G1 X165.699 Y143.17 E.00921
G1 X131.359 Y108.83 E.79106
G1 X130.793 Y108.83 E.00921
G1 X165.134 Y143.17 E.79106
G1 X164.568 Y143.17 E.00921
G1 X130.228 Y108.83 E.79106
G1 X129.663 Y108.83 E.00921
G1 X164.003 Y143.17 E.79106
G1 X163.437 Y143.17 E.00921
G1 X129.097 Y108.83 E.79106
G1 X128.532 Y108.83 E.00921
G1 X162.872 Y143.17 E.79106
G1 X162.307 Y143.17 E.00921
G1 X127.966 Y108.83 E.79106
G1 X127.401 Y108.83 E.00921
G1 X161.741 Y143.17 E.79106
G1 X161.176 Y143.17 E.00921
G1 X126.836 Y108.83 E.79106
G1 X126.27 Y108.83 E.00921
G1 X160.611 Y143.17 E.79106
G1 X160.045 Y143.17 E.00921
G1 X125.705 Y108.83 E.79106
G1 X125.139 Y108.83 E.00921
G1 X159.48 Y143.17 E.79106
G1 X158.914 Y143.17 E.00921
G1 X124.574 Y108.83 E.79106
G1 X124.009 Y108.83 E.00921
G1 X158.349 Y143.17 E.79106
G1 X157.784 Y143.17 E.00921
G1 X123.443 Y108.83 E.79106
G1 X122.878 Y108.83 E.00921
G1 X157.218 Y143.17 E.79106
G1 X156.653 Y143.17 E.00921
G1 X122.312 Y108.83 E.79106
G1 X121.747 Y108.83 E.00921
G1 X156.087 Y143.17 E.79106
G1 X155.522 Y143.17 E.00921
G1 X121.182 Y108.83 E.79106
G1 X120.616 Y108.83 E.00921
G1 X154.957 Y143.17 E.79106
G1 X154.391 Y143.17 E.00921
G1 X120.051 Y108.83 E.79106
G1 X119.486 Y108.83 E.00921
G1 X153.826 Y143.17 E.79106
G1 X153.261 Y143.17 E.00921
G1 X118.92 Y108.83 E.79106
G1 X118.355 Y108.83 E.00921
G1 X152.695 Y143.17 E.79106
G1 X152.13 Y143.17 E.00921
G1 X117.789 Y108.83 E.79106
G1 X117.224 Y108.83 E.00921
G1 X151.564 Y143.17 E.79106
G1 X150.999 Y143.17 E.00921
G1 X116.659 Y108.83 E.79106
G1 X116.093 Y108.83 E.00921
G1 X150.434 Y143.17 E.79106
G1 X149.868 Y143.17 E.00921
G1 X115.528 Y108.83 E.79106
G1 X114.962 Y108.83 E.00921
G1 X149.303 Y143.17 E.79106
G1 X148.737 Y143.17 E.00921
G1 X114.397 Y108.83 E.79106
G1 X113.832 Y108.83 E.00921
G1 X148.172 Y143.17 E.79106
G1 X147.607 Y143.17 E.00921
G1 X113.266 Y108.83 E.79106
G1 X112.701 Y108.83 E.00921
M73 P57 R22
G1 X147.041 Y143.17 E.79106
G1 X146.476 Y143.17 E.00921
G1 X112.135 Y108.83 E.79106
G1 X111.57 Y108.83 E.00921
G1 X145.91 Y143.17 E.79106
G1 X145.345 Y143.17 E.00921
G1 X111.005 Y108.83 E.79106
G1 X110.439 Y108.83 E.00921
G1 X144.78 Y143.17 E.79106
G1 X144.214 Y143.17 E.00921
G1 X109.874 Y108.83 E.79106
G1 X109.309 Y108.83 E.00921
G1 X143.649 Y143.17 E.79106
G1 X143.084 Y143.17 E.00921
G1 X108.743 Y108.83 E.79106
G1 X108.178 Y108.83 E.00921
G1 X142.518 Y143.17 E.79106
G1 X141.953 Y143.17 E.00921
G1 X107.612 Y108.83 E.79106
G1 X107.047 Y108.83 E.00921
G1 X141.387 Y143.17 E.79106
G1 X140.822 Y143.17 E.00921
G1 X106.482 Y108.83 E.79106
G1 X105.916 Y108.83 E.00921
G1 X140.257 Y143.17 E.79106
G1 X139.691 Y143.17 E.00921
G1 X105.351 Y108.83 E.79106
G1 X104.785 Y108.83 E.00921
G1 X139.126 Y143.17 E.79106
G1 X138.56 Y143.17 E.00921
G1 X104.22 Y108.83 E.79106
G1 X103.655 Y108.83 E.00921
G1 X137.995 Y143.17 E.79106
G1 X137.43 Y143.17 E.00921
G1 X103.089 Y108.83 E.79106
G1 X102.524 Y108.83 E.00921
G1 X136.864 Y143.17 E.79106
G1 X136.299 Y143.17 E.00921
G1 X101.958 Y108.83 E.79106
G1 X101.393 Y108.83 E.00921
G1 X135.733 Y143.17 E.79106
G1 X135.168 Y143.17 E.00921
G1 X100.828 Y108.83 E.79106
G1 X100.262 Y108.83 E.00921
G1 X134.603 Y143.17 E.79106
G1 X134.037 Y143.17 E.00921
G1 X99.697 Y108.83 E.79106
G1 X99.132 Y108.83 E.00921
G1 X133.472 Y143.17 E.79106
G1 X132.907 Y143.17 E.00921
G1 X98.566 Y108.83 E.79106
G1 X98.001 Y108.83 E.00921
G1 X132.341 Y143.17 E.79106
G1 X131.776 Y143.17 E.00921
G1 X97.435 Y108.83 E.79106
G1 X96.87 Y108.83 E.00921
G1 X131.21 Y143.17 E.79106
G1 X130.645 Y143.17 E.00921
G1 X96.305 Y108.83 E.79106
G1 X95.739 Y108.83 E.00921
G1 X130.08 Y143.17 E.79106
G1 X129.514 Y143.17 E.00921
G1 X95.174 Y108.83 E.79106
G1 X94.608 Y108.83 E.00921
G1 X128.949 Y143.17 E.79106
G1 X128.383 Y143.17 E.00921
G1 X94.043 Y108.83 E.79106
G1 X93.478 Y108.83 E.00921
G1 X127.818 Y143.17 E.79106
G1 X127.253 Y143.17 E.00921
G1 X92.912 Y108.83 E.79106
G1 X92.347 Y108.83 E.00921
G1 X126.687 Y143.17 E.79106
G1 X126.122 Y143.17 E.00921
G1 X91.782 Y108.83 E.79106
G1 X91.216 Y108.83 E.00921
G1 X125.556 Y143.17 E.79106
G1 X124.991 Y143.17 E.00921
M73 P57 R21
G1 X90.651 Y108.83 E.79106
G1 X90.085 Y108.83 E.00921
G1 X124.426 Y143.17 E.79106
G1 X123.86 Y143.17 E.00921
G1 X89.52 Y108.83 E.79106
G1 X88.955 Y108.83 E.00921
G1 X123.295 Y143.17 E.79106
G1 X122.73 Y143.17 E.00921
G1 X88.389 Y108.83 E.79106
G1 X87.824 Y108.83 E.00921
G1 X122.164 Y143.17 E.79106
G1 X121.599 Y143.17 E.00921
G1 X87.258 Y108.83 E.79106
G1 X86.693 Y108.83 E.00921
G1 X121.033 Y143.17 E.79106
G1 X120.468 Y143.17 E.00921
G1 X86.128 Y108.83 E.79106
G1 X85.562 Y108.83 E.00921
G1 X119.903 Y143.17 E.79106
G1 X119.337 Y143.17 E.00921
G1 X84.997 Y108.83 E.79106
G1 X84.431 Y108.83 E.00921
G1 X118.772 Y143.17 E.79106
G1 X118.206 Y143.17 E.00921
G1 X83.866 Y108.83 E.79106
G1 X83.301 Y108.83 E.00921
G1 X117.641 Y143.17 E.79106
G1 X117.076 Y143.17 E.00921
G1 X82.735 Y108.83 E.79106
G1 X82.17 Y108.83 E.00921
G1 X116.51 Y143.17 E.79106
G1 X115.945 Y143.17 E.00921
G1 X81.605 Y108.83 E.79106
G1 X81.039 Y108.83 E.00921
G1 X115.379 Y143.17 E.79106
G1 X114.814 Y143.17 E.00921
G1 X80.474 Y108.83 E.79106
G1 X79.908 Y108.83 E.00921
M73 P58 R21
G1 X114.249 Y143.17 E.79106
G1 X113.683 Y143.17 E.00921
G1 X79.343 Y108.83 E.79106
G1 X78.778 Y108.83 E.00921
G1 X113.118 Y143.17 E.79106
G1 X112.553 Y143.17 E.00921
G1 X78.212 Y108.83 E.79106
G1 X77.83 Y108.83 E.00623
G1 X77.83 Y109.013 E.00298
G1 X111.987 Y143.17 E.78685
G1 X111.422 Y143.17 E.00921
G1 X77.83 Y109.578 E.77382
G1 X77.83 Y110.144 E.00921
G1 X110.856 Y143.17 E.7608
G1 X110.291 Y143.17 E.00921
G1 X77.83 Y110.709 E.74778
G1 X77.83 Y111.274 E.00921
G1 X109.726 Y143.17 E.73475
G1 X109.16 Y143.17 E.00921
G1 X77.83 Y111.84 E.72173
G1 X77.83 Y112.405 E.00921
G1 X108.595 Y143.17 E.7087
G1 X108.029 Y143.17 E.00921
G1 X77.83 Y112.971 E.69568
G1 X77.83 Y113.536 E.00921
G1 X107.464 Y143.17 E.68265
G1 X106.899 Y143.17 E.00921
G1 X77.83 Y114.101 E.66963
G1 X77.83 Y114.667 E.00921
G1 X106.333 Y143.17 E.65661
G1 X105.768 Y143.17 E.00921
G1 X77.83 Y115.232 E.64358
G1 X77.83 Y115.798 E.00921
G1 X105.202 Y143.17 E.63056
G1 X104.637 Y143.17 E.00921
G1 X77.83 Y116.363 E.61753
G1 X77.83 Y116.928 E.00921
G1 X104.072 Y143.17 E.60451
G1 X103.506 Y143.17 E.00921
G1 X77.83 Y117.494 E.59148
G1 X77.83 Y118.059 E.00921
G1 X102.941 Y143.17 E.57846
G1 X102.376 Y143.17 E.00921
G1 X77.83 Y118.624 E.56544
G1 X77.83 Y119.19 E.00921
G1 X101.81 Y143.17 E.55241
G1 X101.245 Y143.17 E.00921
G1 X77.83 Y119.755 E.53939
G1 X77.83 Y120.321 E.00921
G1 X100.679 Y143.17 E.52636
G1 X100.114 Y143.17 E.00921
G1 X77.83 Y120.886 E.51334
G1 X77.83 Y121.451 E.00921
G1 X99.549 Y143.17 E.50031
G1 X98.983 Y143.17 E.00921
G1 X77.83 Y122.017 E.48729
G1 X77.83 Y122.582 E.00921
G1 X98.418 Y143.17 E.47427
G1 X97.852 Y143.17 E.00921
G1 X77.83 Y123.148 E.46124
G1 X77.83 Y123.713 E.00921
G1 X97.287 Y143.17 E.44822
G1 X96.722 Y143.17 E.00921
G1 X77.83 Y124.278 E.43519
G1 X77.83 Y124.844 E.00921
G1 X96.156 Y143.17 E.42217
G1 X95.591 Y143.17 E.00921
G1 X77.83 Y125.409 E.40914
G1 X77.83 Y125.974 E.00921
G1 X95.025 Y143.17 E.39612
G1 X94.46 Y143.17 E.00921
G1 X77.83 Y126.54 E.3831
G1 X77.83 Y127.105 E.00921
G1 X93.895 Y143.17 E.37007
G1 X93.329 Y143.17 E.00921
G1 X77.83 Y127.671 E.35705
G1 X77.83 Y128.236 E.00921
G1 X92.764 Y143.17 E.34402
G1 X92.199 Y143.17 E.00921
G1 X77.83 Y128.801 E.331
G1 X77.83 Y129.367 E.00921
G1 X91.633 Y143.17 E.31797
G1 X91.068 Y143.17 E.00921
G1 X77.83 Y129.932 E.30495
G1 X77.83 Y130.498 E.00921
G1 X90.502 Y143.17 E.29193
G1 X89.937 Y143.17 E.00921
G1 X77.83 Y131.063 E.2789
G1 X77.83 Y131.628 E.00921
G1 X89.372 Y143.17 E.26588
G1 X88.806 Y143.17 E.00921
G1 X77.83 Y132.194 E.25285
G1 X77.83 Y132.759 E.00921
G1 X88.241 Y143.17 E.23983
G1 X87.675 Y143.17 E.00921
G1 X77.83 Y133.325 E.2268
G1 X77.83 Y133.89 E.00921
G1 X87.11 Y143.17 E.21378
G1 X86.545 Y143.17 E.00921
G1 X77.83 Y134.455 E.20076
G1 X77.83 Y135.021 E.00921
G1 X85.979 Y143.17 E.18773
G1 X85.414 Y143.17 E.00921
G1 X77.83 Y135.586 E.17471
G1 X77.83 Y136.151 E.00921
G1 X84.849 Y143.17 E.16168
G1 X84.283 Y143.17 E.00921
G1 X77.83 Y136.717 E.14866
G1 X77.83 Y137.282 E.00921
G1 X83.718 Y143.17 E.13563
G1 X83.152 Y143.17 E.00921
G1 X77.83 Y137.848 E.12261
G1 X77.83 Y138.413 E.00921
G1 X82.587 Y143.17 E.10959
G1 X82.022 Y143.17 E.00921
G1 X77.83 Y138.978 E.09656
G1 X77.83 Y139.544 E.00921
G1 X81.456 Y143.17 E.08354
G1 X80.891 Y143.17 E.00921
M73 P59 R21
G1 X77.83 Y140.109 E.07051
G1 X77.83 Y140.675 E.00921
G1 X80.325 Y143.17 E.05749
G1 X79.76 Y143.17 E.00921
G1 X77.65 Y141.061 E.0486
; CHANGE_LAYER
; Z_HEIGHT: 1.1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X79.065 Y142.475 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/24
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M204 S10000
G17
G3 Z1.4 I-1.128 J-.458 P1  F30000
G1 X51.016 Y211.534 Z1.4
G1 Z1.1
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #11
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.5 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z1.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.543 Y143.35 Z1.5 F30000
G1 Z1.1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S3000
G1 X178.17 Y142.722 E.01443
G1 X178.17 Y142.157 E.00918
G1 X177.157 Y143.17 E.02329
G1 X176.593 Y143.17 E.00918
G1 X178.17 Y141.593 E.03627
G1 X178.17 Y141.028 E.00918
G1 X176.028 Y143.17 E.04926
G1 X175.464 Y143.17 E.00918
G1 X178.17 Y140.464 E.06224
G1 X178.17 Y139.9 E.00918
G1 X174.899 Y143.17 E.07522
G1 X174.335 Y143.17 E.00918
G1 X178.17 Y139.335 E.08821
G1 X178.17 Y138.771 E.00918
G1 X173.771 Y143.17 E.10119
G1 X173.206 Y143.17 E.00918
G1 X178.17 Y138.206 E.11417
G1 X178.17 Y137.642 E.00918
G1 X172.642 Y143.17 E.12715
G1 X172.077 Y143.17 E.00918
G1 X178.17 Y137.077 E.14014
G1 X178.17 Y136.513 E.00918
G1 X171.513 Y143.17 E.15312
G1 X170.948 Y143.17 E.00918
G1 X178.17 Y135.948 E.1661
G1 X178.17 Y135.384 E.00918
G1 X170.384 Y143.17 E.17908
G1 X169.819 Y143.17 E.00918
G1 X178.17 Y134.819 E.19207
G1 X178.17 Y134.255 E.00918
G1 X169.255 Y143.17 E.20505
G1 X168.69 Y143.17 E.00918
M73 P59 R20
G1 X178.17 Y133.69 E.21803
G1 X178.17 Y133.126 E.00918
G1 X168.126 Y143.17 E.23101
G1 X167.561 Y143.17 E.00918
G1 X178.17 Y132.561 E.244
G1 X178.17 Y131.997 E.00918
G1 X166.997 Y143.17 E.25698
G1 X166.432 Y143.17 E.00918
G1 X178.17 Y131.432 E.26996
G1 X178.17 Y130.868 E.00918
G1 X165.868 Y143.17 E.28294
G1 X165.303 Y143.17 E.00918
G1 X178.17 Y130.303 E.29593
G1 X178.17 Y129.739 E.00918
G1 X164.739 Y143.17 E.30891
G1 X164.174 Y143.17 E.00918
G1 X178.17 Y129.174 E.32189
G1 X178.17 Y128.61 E.00918
G1 X163.61 Y143.17 E.33488
G1 X163.045 Y143.17 E.00918
G1 X178.17 Y128.045 E.34786
G1 X178.17 Y127.481 E.00918
G1 X162.481 Y143.17 E.36084
G1 X161.916 Y143.17 E.00918
G1 X178.17 Y126.916 E.37382
G1 X178.17 Y126.352 E.00918
G1 X161.352 Y143.17 E.38681
G1 X160.787 Y143.17 E.00918
G1 X178.17 Y125.787 E.39979
G1 X178.17 Y125.223 E.00918
G1 X160.223 Y143.17 E.41277
G1 X159.658 Y143.17 E.00918
G1 X178.17 Y124.658 E.42575
G1 X178.17 Y124.094 E.00918
G1 X159.094 Y143.17 E.43874
G1 X158.529 Y143.17 E.00918
G1 X178.17 Y123.529 E.45172
G1 X178.17 Y122.965 E.00918
G1 X157.965 Y143.17 E.4647
G1 X157.401 Y143.17 E.00918
G1 X178.17 Y122.401 E.47768
G1 X178.17 Y121.836 E.00918
G1 X156.836 Y143.17 E.49067
G1 X156.272 Y143.17 E.00918
G1 X178.17 Y121.272 E.50365
G1 X178.17 Y120.707 E.00918
G1 X155.707 Y143.17 E.51663
G1 X155.143 Y143.17 E.00918
G1 X178.17 Y120.143 E.52961
G1 X178.17 Y119.578 E.00918
G1 X154.578 Y143.17 E.5426
G1 X154.014 Y143.17 E.00918
G1 X178.17 Y119.014 E.55558
G1 X178.17 Y118.449 E.00918
G1 X153.449 Y143.17 E.56856
G1 X152.885 Y143.17 E.00918
G1 X178.17 Y117.885 E.58155
M73 P60 R20
G1 X178.17 Y117.32 E.00918
G1 X152.32 Y143.17 E.59453
G1 X151.756 Y143.17 E.00918
G1 X178.17 Y116.756 E.60751
G1 X178.17 Y116.191 E.00918
G1 X151.191 Y143.17 E.62049
G1 X150.627 Y143.17 E.00918
G1 X178.17 Y115.627 E.63348
G1 X178.17 Y115.062 E.00918
G1 X150.062 Y143.17 E.64646
G1 X149.498 Y143.17 E.00918
G1 X178.17 Y114.498 E.65944
G1 X178.17 Y113.933 E.00918
G1 X148.933 Y143.17 E.67242
G1 X148.369 Y143.17 E.00918
G1 X178.17 Y113.369 E.68541
G1 X178.17 Y112.804 E.00918
G1 X147.804 Y143.17 E.69839
G1 X147.24 Y143.17 E.00918
G1 X178.17 Y112.24 E.71137
G1 X178.17 Y111.675 E.00918
G1 X146.675 Y143.17 E.72435
G1 X146.111 Y143.17 E.00918
G1 X178.17 Y111.111 E.73734
G1 X178.17 Y110.546 E.00918
G1 X145.546 Y143.17 E.75032
G1 X144.982 Y143.17 E.00918
G1 X178.17 Y109.982 E.7633
G1 X178.17 Y109.417 E.00918
G1 X144.417 Y143.17 E.77628
G1 X143.853 Y143.17 E.00918
G1 X178.17 Y108.853 E.78927
G1 X178.17 Y108.83 E.00038
G1 X177.629 Y108.83 E.0088
G1 X143.288 Y143.17 E.7898
G1 X142.724 Y143.17 E.00918
G1 X177.064 Y108.83 E.7898
G1 X176.5 Y108.83 E.00918
G1 X142.159 Y143.17 E.7898
G1 X141.595 Y143.17 E.00918
G1 X175.935 Y108.83 E.7898
G1 X175.371 Y108.83 E.00918
G1 X141.03 Y143.17 E.7898
G1 X140.466 Y143.17 E.00918
G1 X174.806 Y108.83 E.7898
G1 X174.242 Y108.83 E.00918
G1 X139.902 Y143.17 E.7898
G1 X139.337 Y143.17 E.00918
G1 X173.677 Y108.83 E.7898
G1 X173.113 Y108.83 E.00918
G1 X138.773 Y143.17 E.7898
G1 X138.208 Y143.17 E.00918
G1 X172.548 Y108.83 E.7898
G1 X171.984 Y108.83 E.00918
G1 X137.644 Y143.17 E.7898
G1 X137.079 Y143.17 E.00918
G1 X171.419 Y108.83 E.7898
G1 X170.855 Y108.83 E.00918
G1 X136.515 Y143.17 E.7898
G1 X135.95 Y143.17 E.00918
G1 X170.291 Y108.83 E.7898
G1 X169.726 Y108.83 E.00918
G1 X135.386 Y143.17 E.7898
G1 X134.821 Y143.17 E.00918
G1 X169.162 Y108.83 E.7898
G1 X168.597 Y108.83 E.00918
G1 X134.257 Y143.17 E.7898
G1 X133.692 Y143.17 E.00918
G1 X168.033 Y108.83 E.7898
G1 X167.468 Y108.83 E.00918
G1 X133.128 Y143.17 E.7898
G1 X132.563 Y143.17 E.00918
G1 X166.904 Y108.83 E.7898
G1 X166.339 Y108.83 E.00918
G1 X131.999 Y143.17 E.7898
G1 X131.434 Y143.17 E.00918
G1 X165.775 Y108.83 E.7898
G1 X165.21 Y108.83 E.00918
G1 X130.87 Y143.17 E.7898
G1 X130.305 Y143.17 E.00918
G1 X164.646 Y108.83 E.7898
G1 X164.081 Y108.83 E.00918
G1 X129.741 Y143.17 E.7898
G1 X129.176 Y143.17 E.00918
G1 X163.517 Y108.83 E.7898
G1 X162.952 Y108.83 E.00918
G1 X128.612 Y143.17 E.7898
G1 X128.047 Y143.17 E.00918
G1 X162.388 Y108.83 E.7898
G1 X161.823 Y108.83 E.00918
G1 X127.483 Y143.17 E.7898
G1 X126.918 Y143.17 E.00918
G1 X161.259 Y108.83 E.7898
G1 X160.694 Y108.83 E.00918
G1 X126.354 Y143.17 E.7898
G1 X125.789 Y143.17 E.00918
G1 X160.13 Y108.83 E.7898
G1 X159.565 Y108.83 E.00918
G1 X125.225 Y143.17 E.7898
G1 X124.66 Y143.17 E.00918
G1 X159.001 Y108.83 E.7898
G1 X158.436 Y108.83 E.00918
G1 X124.096 Y143.17 E.7898
G1 X123.532 Y143.17 E.00918
G1 X157.872 Y108.83 E.7898
G1 X157.307 Y108.83 E.00918
G1 X122.967 Y143.17 E.7898
G1 X122.403 Y143.17 E.00918
G1 X156.743 Y108.83 E.7898
G1 X156.178 Y108.83 E.00918
G1 X121.838 Y143.17 E.7898
G1 X121.274 Y143.17 E.00918
G1 X155.614 Y108.83 E.7898
G1 X155.049 Y108.83 E.00918
G1 X120.709 Y143.17 E.7898
G1 X120.145 Y143.17 E.00918
G1 X154.485 Y108.83 E.7898
G1 X153.92 Y108.83 E.00918
G1 X119.58 Y143.17 E.7898
G1 X119.016 Y143.17 E.00918
G1 X153.356 Y108.83 E.7898
G1 X152.792 Y108.83 E.00918
G1 X118.451 Y143.17 E.7898
G1 X117.887 Y143.17 E.00918
G1 X152.227 Y108.83 E.7898
G1 X151.663 Y108.83 E.00918
G1 X117.322 Y143.17 E.7898
G1 X116.758 Y143.17 E.00918
G1 X151.098 Y108.83 E.7898
G1 X150.534 Y108.83 E.00918
G1 X116.193 Y143.17 E.7898
G1 X115.629 Y143.17 E.00918
G1 X149.969 Y108.83 E.7898
G1 X149.405 Y108.83 E.00918
G1 X115.064 Y143.17 E.7898
G1 X114.5 Y143.17 E.00918
G1 X148.84 Y108.83 E.7898
G1 X148.276 Y108.83 E.00918
G1 X113.935 Y143.17 E.7898
G1 X113.371 Y143.17 E.00918
G1 X147.711 Y108.83 E.7898
G1 X147.147 Y108.83 E.00918
G1 X112.806 Y143.17 E.7898
G1 X112.242 Y143.17 E.00918
G1 X146.582 Y108.83 E.7898
G1 X146.018 Y108.83 E.00918
G1 X111.677 Y143.17 E.7898
G1 X111.113 Y143.17 E.00918
G1 X145.453 Y108.83 E.7898
G1 X144.889 Y108.83 E.00918
G1 X110.548 Y143.17 E.7898
G1 X109.984 Y143.17 E.00918
G1 X144.324 Y108.83 E.7898
G1 X143.76 Y108.83 E.00918
G1 X109.419 Y143.17 E.7898
G1 X108.855 Y143.17 E.00918
G1 X143.195 Y108.83 E.7898
G1 X142.631 Y108.83 E.00918
G1 X108.29 Y143.17 E.7898
G1 X107.726 Y143.17 E.00918
G1 X142.066 Y108.83 E.7898
G1 X141.502 Y108.83 E.00918
G1 X107.161 Y143.17 E.7898
G1 X106.597 Y143.17 E.00918
G1 X140.937 Y108.83 E.7898
G1 X140.373 Y108.83 E.00918
G1 X106.033 Y143.17 E.7898
G1 X105.468 Y143.17 E.00918
G1 X139.808 Y108.83 E.7898
G1 X139.244 Y108.83 E.00918
G1 X104.904 Y143.17 E.7898
G1 X104.339 Y143.17 E.00918
M73 P61 R20
G1 X138.679 Y108.83 E.7898
G1 X138.115 Y108.83 E.00918
G1 X103.775 Y143.17 E.7898
G1 X103.21 Y143.17 E.00918
G1 X137.55 Y108.83 E.7898
G1 X136.986 Y108.83 E.00918
G1 X102.646 Y143.17 E.7898
G1 X102.081 Y143.17 E.00918
G1 X136.421 Y108.83 E.7898
G1 X135.857 Y108.83 E.00918
G1 X101.517 Y143.17 E.7898
G1 X100.952 Y143.17 E.00918
G1 X135.293 Y108.83 E.7898
G1 X134.728 Y108.83 E.00918
G1 X100.388 Y143.17 E.7898
G1 X99.823 Y143.17 E.00918
G1 X134.164 Y108.83 E.7898
G1 X133.599 Y108.83 E.00918
G1 X99.259 Y143.17 E.7898
G1 X98.694 Y143.17 E.00918
G1 X133.035 Y108.83 E.7898
G1 X132.47 Y108.83 E.00918
G1 X98.13 Y143.17 E.7898
G1 X97.565 Y143.17 E.00918
G1 X131.906 Y108.83 E.7898
G1 X131.341 Y108.83 E.00918
G1 X97.001 Y143.17 E.7898
G1 X96.436 Y143.17 E.00918
G1 X130.777 Y108.83 E.7898
G1 X130.212 Y108.83 E.00918
G1 X95.872 Y143.17 E.7898
G1 X95.307 Y143.17 E.00918
G1 X129.648 Y108.83 E.7898
G1 X129.083 Y108.83 E.00918
G1 X94.743 Y143.17 E.7898
G1 X94.178 Y143.17 E.00918
G1 X128.519 Y108.83 E.7898
G1 X127.954 Y108.83 E.00918
G1 X93.614 Y143.17 E.7898
G1 X93.049 Y143.17 E.00918
G1 X127.39 Y108.83 E.7898
G1 X126.825 Y108.83 E.00918
G1 X92.485 Y143.17 E.7898
G1 X91.92 Y143.17 E.00918
G1 X126.261 Y108.83 E.7898
G1 X125.696 Y108.83 E.00918
G1 X91.356 Y143.17 E.7898
G1 X90.791 Y143.17 E.00918
G1 X125.132 Y108.83 E.7898
G1 X124.567 Y108.83 E.00918
G1 X90.227 Y143.17 E.7898
G1 X89.662 Y143.17 E.00918
G1 X124.003 Y108.83 E.7898
G1 X123.438 Y108.83 E.00918
G1 X89.098 Y143.17 E.7898
G1 X88.534 Y143.17 E.00918
G1 X122.874 Y108.83 E.7898
G1 X122.309 Y108.83 E.00918
G1 X87.969 Y143.17 E.7898
G1 X87.405 Y143.17 E.00918
M73 P61 R19
G1 X121.745 Y108.83 E.7898
G1 X121.18 Y108.83 E.00918
G1 X86.84 Y143.17 E.7898
G1 X86.276 Y143.17 E.00918
G1 X120.616 Y108.83 E.7898
G1 X120.051 Y108.83 E.00918
G1 X85.711 Y143.17 E.7898
G1 X85.147 Y143.17 E.00918
G1 X119.487 Y108.83 E.7898
G1 X118.923 Y108.83 E.00918
G1 X84.582 Y143.17 E.7898
G1 X84.018 Y143.17 E.00918
G1 X118.358 Y108.83 E.7898
G1 X117.794 Y108.83 E.00918
G1 X83.453 Y143.17 E.7898
G1 X82.889 Y143.17 E.00918
G1 X117.229 Y108.83 E.7898
G1 X116.665 Y108.83 E.00918
G1 X82.324 Y143.17 E.7898
G1 X81.76 Y143.17 E.00918
G1 X116.1 Y108.83 E.7898
G1 X115.536 Y108.83 E.00918
G1 X81.195 Y143.17 E.7898
G1 X80.631 Y143.17 E.00918
G1 X114.971 Y108.83 E.7898
G1 X114.407 Y108.83 E.00918
G1 X80.066 Y143.17 E.7898
G1 X79.758 Y143.17 E.00501
G1 X79.63 Y143.042 E.00295
G1 X113.842 Y108.83 E.78685
G1 X113.278 Y108.83 E.00918
G1 X79.348 Y142.76 E.78036
G1 X79.065 Y142.478 E.00649
G1 X112.713 Y108.83 E.77387
G1 X112.149 Y108.83 E.00918
G1 X78.783 Y142.195 E.76738
G1 X78.501 Y141.913 E.00649
G1 X111.584 Y108.83 E.76089
G1 X111.02 Y108.83 E.00918
G1 X78.219 Y141.631 E.7544
G1 X77.936 Y141.349 E.00649
G1 X110.455 Y108.83 E.7479
G1 X109.891 Y108.83 E.00918
G1 X77.83 Y140.891 E.73737
G1 X77.83 Y140.326 E.00918
G1 X109.326 Y108.83 E.72439
G1 X108.762 Y108.83 E.00918
G1 X77.83 Y139.762 E.71141
G1 X77.83 Y139.197 E.00918
G1 X108.197 Y108.83 E.69843
G1 X107.633 Y108.83 E.00918
G1 X77.83 Y138.633 E.68544
G1 X77.83 Y138.068 E.00918
G1 X107.068 Y108.83 E.67246
G1 X106.504 Y108.83 E.00918
G1 X77.83 Y137.504 E.65948
G1 X77.83 Y136.939 E.00918
G1 X105.939 Y108.83 E.6465
M73 P62 R19
G1 X105.375 Y108.83 E.00918
G1 X77.83 Y136.375 E.63351
G1 X77.83 Y135.81 E.00918
G1 X104.81 Y108.83 E.62053
G1 X104.246 Y108.83 E.00918
G1 X77.83 Y135.246 E.60755
G1 X77.83 Y134.681 E.00918
G1 X103.681 Y108.83 E.59457
G1 X103.117 Y108.83 E.00918
G1 X77.83 Y134.117 E.58158
G1 X77.83 Y133.552 E.00918
G1 X102.552 Y108.83 E.5686
G1 X101.988 Y108.83 E.00918
G1 X77.83 Y132.988 E.55562
G1 X77.83 Y132.424 E.00918
G1 X101.424 Y108.83 E.54263
G1 X100.859 Y108.83 E.00918
G1 X77.83 Y131.859 E.52965
G1 X77.83 Y131.295 E.00918
G1 X100.295 Y108.83 E.51667
G1 X99.73 Y108.83 E.00918
G1 X77.83 Y130.73 E.50369
G1 X77.83 Y130.166 E.00918
G1 X99.166 Y108.83 E.4907
G1 X98.601 Y108.83 E.00918
G1 X77.83 Y129.601 E.47772
G1 X77.83 Y129.037 E.00918
G1 X98.037 Y108.83 E.46474
G1 X97.472 Y108.83 E.00918
G1 X77.83 Y128.472 E.45176
G1 X77.83 Y127.908 E.00918
G1 X96.908 Y108.83 E.43877
G1 X96.343 Y108.83 E.00918
G1 X77.83 Y127.343 E.42579
G1 X77.83 Y126.779 E.00918
G1 X95.779 Y108.83 E.41281
G1 X95.214 Y108.83 E.00918
G1 X77.83 Y126.214 E.39983
G1 X77.83 Y125.65 E.00918
G1 X94.65 Y108.83 E.38684
G1 X94.085 Y108.83 E.00918
G1 X77.83 Y125.085 E.37386
G1 X77.83 Y124.521 E.00918
G1 X93.521 Y108.83 E.36088
G1 X92.956 Y108.83 E.00918
G1 X77.83 Y123.956 E.3479
G1 X77.83 Y123.392 E.00918
G1 X92.392 Y108.83 E.33491
G1 X91.827 Y108.83 E.00918
G1 X77.83 Y122.827 E.32193
G1 X77.83 Y122.263 E.00918
G1 X91.263 Y108.83 E.30895
G1 X90.698 Y108.83 E.00918
G1 X77.83 Y121.698 E.29596
G1 X77.83 Y121.134 E.00918
G1 X90.134 Y108.83 E.28298
G1 X89.569 Y108.83 E.00918
G1 X77.83 Y120.569 E.27
G1 X77.83 Y120.005 E.00918
G1 X89.005 Y108.83 E.25702
G1 X88.44 Y108.83 E.00918
G1 X77.83 Y119.44 E.24403
G1 X77.83 Y118.876 E.00918
G1 X87.876 Y108.83 E.23105
G1 X87.311 Y108.83 E.00918
G1 X77.83 Y118.311 E.21807
G1 X77.83 Y117.747 E.00918
G1 X86.747 Y108.83 E.20509
G1 X86.182 Y108.83 E.00918
G1 X77.83 Y117.182 E.1921
G1 X77.83 Y116.618 E.00918
G1 X85.618 Y108.83 E.17912
G1 X85.054 Y108.83 E.00918
G1 X77.83 Y116.054 E.16614
G1 X77.83 Y115.489 E.00918
G1 X84.489 Y108.83 E.15316
G1 X83.925 Y108.83 E.00918
G1 X77.83 Y114.925 E.14017
G1 X77.83 Y114.36 E.00918
G1 X83.36 Y108.83 E.12719
G1 X82.796 Y108.83 E.00918
G1 X77.83 Y113.796 E.11421
G1 X77.83 Y113.231 E.00918
G1 X82.231 Y108.83 E.10123
G1 X81.667 Y108.83 E.00918
G1 X77.83 Y112.667 E.08824
G1 X77.83 Y112.102 E.00918
G1 X81.102 Y108.83 E.07526
G1 X80.538 Y108.83 E.00918
G1 X77.83 Y111.538 E.06228
G1 X77.83 Y110.973 E.00918
G1 X79.973 Y108.83 E.04929
G1 X79.409 Y108.83 E.00918
G1 X77.83 Y110.409 E.03631
G1 X77.83 Y109.844 E.00918
G1 X78.844 Y108.83 E.02333
G1 X78.28 Y108.83 E.00918
G1 X77.65 Y109.459 E.01447
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X78.28 Y108.83 E-.33815
G1 X78.844 Y108.83 E-.21451
G1 X78.458 Y109.216 E-.20735
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/24
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
M204 S10000
G17
G3 Z1.5 I-1.175 J-.315 P1  F30000
G1 X51.016 Y211.534 Z1.5
G1 Z1.2
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #12
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
M73 P63 R19
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.6 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.911 Y137.1 Z1.6 F30000
G1 X178.35 Y109.459 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S3000
G1 X177.721 Y108.83 E.01449
G1 X177.155 Y108.83 E.00921
G1 X178.17 Y109.845 E.02338
G1 X178.17 Y110.41 E.00921
G1 X176.59 Y108.83 E.03641
G1 X176.024 Y108.83 E.00921
G1 X178.17 Y110.976 E.04943
G1 X178.17 Y111.541 E.00921
G1 X175.459 Y108.83 E.06245
G1 X174.894 Y108.83 E.00921
G1 X178.17 Y112.106 E.07548
G1 X178.17 Y112.672 E.00921
G1 X174.328 Y108.83 E.0885
G1 X173.763 Y108.83 E.00921
G1 X178.17 Y113.237 E.10153
G1 X178.17 Y113.803 E.00921
G1 X173.197 Y108.83 E.11455
G1 X172.632 Y108.83 E.00921
G1 X178.17 Y114.368 E.12758
G1 X178.17 Y114.933 E.00921
G1 X172.067 Y108.83 E.1406
G1 X171.501 Y108.83 E.00921
G1 X178.17 Y115.499 E.15362
G1 X178.17 Y116.064 E.00921
G1 X170.936 Y108.83 E.16665
G1 X170.37 Y108.83 E.00921
G1 X178.17 Y116.629 E.17967
G1 X178.17 Y117.195 E.00921
G1 X169.805 Y108.83 E.1927
G1 X169.24 Y108.83 E.00921
G1 X178.17 Y117.76 E.20572
G1 X178.17 Y118.326 E.00921
G1 X168.674 Y108.83 E.21875
G1 X168.109 Y108.83 E.00921
G1 X178.17 Y118.891 E.23177
G1 X178.17 Y119.456 E.00921
G1 X167.544 Y108.83 E.24479
G1 X166.978 Y108.83 E.00921
G1 X178.17 Y120.022 E.25782
G1 X178.17 Y120.587 E.00921
G1 X166.413 Y108.83 E.27084
G1 X165.847 Y108.83 E.00921
G1 X178.17 Y121.153 E.28387
G1 X178.17 Y121.718 E.00921
G1 X165.282 Y108.83 E.29689
G1 X164.717 Y108.83 E.00921
G1 X178.17 Y122.283 E.30992
G1 X178.17 Y122.849 E.00921
G1 X164.151 Y108.83 E.32294
G1 X163.586 Y108.83 E.00921
G1 X178.17 Y123.414 E.33596
G1 X178.17 Y123.98 E.00921
G1 X163.02 Y108.83 E.34899
G1 X162.455 Y108.83 E.00921
G1 X178.17 Y124.545 E.36201
G1 X178.17 Y125.11 E.00921
G1 X161.89 Y108.83 E.37504
G1 X161.324 Y108.83 E.00921
G1 X178.17 Y125.676 E.38806
G1 X178.17 Y126.241 E.00921
G1 X160.759 Y108.83 E.40109
G1 X160.194 Y108.83 E.00921
G1 X178.17 Y126.806 E.41411
G1 X178.17 Y127.372 E.00921
M73 P63 R18
G1 X159.628 Y108.83 E.42713
G1 X159.063 Y108.83 E.00921
G1 X178.17 Y127.937 E.44016
G1 X178.17 Y128.503 E.00921
G1 X158.497 Y108.83 E.45318
G1 X157.932 Y108.83 E.00921
G1 X178.17 Y129.068 E.46621
G1 X178.17 Y129.633 E.00921
G1 X157.367 Y108.83 E.47923
G1 X156.801 Y108.83 E.00921
G1 X178.17 Y130.199 E.49226
G1 X178.17 Y130.764 E.00921
G1 X156.236 Y108.83 E.50528
G1 X155.67 Y108.83 E.00921
G1 X178.17 Y131.33 E.5183
G1 X178.17 Y131.895 E.00921
G1 X155.105 Y108.83 E.53133
G1 X154.54 Y108.83 E.00921
G1 X178.17 Y132.46 E.54435
G1 X178.17 Y133.026 E.00921
G1 X153.974 Y108.83 E.55738
G1 X153.409 Y108.83 E.00921
G1 X178.17 Y133.591 E.5704
G1 X178.17 Y134.157 E.00921
G1 X152.843 Y108.83 E.58343
G1 X152.278 Y108.83 E.00921
G1 X178.17 Y134.722 E.59645
G1 X178.17 Y135.287 E.00921
G1 X151.713 Y108.83 E.60947
G1 X151.147 Y108.83 E.00921
G1 X178.17 Y135.853 E.6225
G1 X178.17 Y136.418 E.00921
G1 X150.582 Y108.83 E.63552
G1 X150.017 Y108.83 E.00921
G1 X178.17 Y136.983 E.64855
G1 X178.17 Y137.549 E.00921
G1 X149.451 Y108.83 E.66157
G1 X148.886 Y108.83 E.00921
G1 X178.17 Y138.114 E.6746
G1 X178.17 Y138.68 E.00921
G1 X148.32 Y108.83 E.68762
G1 X147.755 Y108.83 E.00921
G1 X178.17 Y139.245 E.70064
G1 X178.17 Y139.81 E.00921
G1 X147.19 Y108.83 E.71367
G1 X146.624 Y108.83 E.00921
G1 X178.17 Y140.376 E.72669
G1 X178.17 Y140.941 E.00921
G1 X146.059 Y108.83 E.73972
G1 X145.493 Y108.83 E.00921
G1 X178.17 Y141.507 E.75274
G1 X178.17 Y142.072 E.00921
G1 X144.928 Y108.83 E.76577
G1 X144.363 Y108.83 E.00921
G1 X178.17 Y142.637 E.77879
G1 X178.17 Y143.17 E.00868
G1 X178.138 Y143.17 E.00053
G1 X143.797 Y108.83 E.79106
G1 X143.232 Y108.83 E.00921
G1 X177.572 Y143.17 E.79106
G1 X177.007 Y143.17 E.00921
G1 X142.666 Y108.83 E.79106
G1 X142.101 Y108.83 E.00921
G1 X176.441 Y143.17 E.79106
G1 X175.876 Y143.17 E.00921
G1 X141.536 Y108.83 E.79106
G1 X140.97 Y108.83 E.00921
G1 X175.311 Y143.17 E.79106
G1 X174.745 Y143.17 E.00921
G1 X140.405 Y108.83 E.79106
G1 X139.84 Y108.83 E.00921
G1 X174.18 Y143.17 E.79106
G1 X173.614 Y143.17 E.00921
G1 X139.274 Y108.83 E.79106
G1 X138.709 Y108.83 E.00921
G1 X173.049 Y143.17 E.79106
G1 X172.484 Y143.17 E.00921
G1 X138.143 Y108.83 E.79106
G1 X137.578 Y108.83 E.00921
G1 X171.918 Y143.17 E.79106
G1 X171.353 Y143.17 E.00921
G1 X137.013 Y108.83 E.79106
G1 X136.447 Y108.83 E.00921
G1 X170.788 Y143.17 E.79106
G1 X170.222 Y143.17 E.00921
G1 X135.882 Y108.83 E.79106
G1 X135.316 Y108.83 E.00921
G1 X169.657 Y143.17 E.79106
G1 X169.091 Y143.17 E.00921
G1 X134.751 Y108.83 E.79106
G1 X134.186 Y108.83 E.00921
G1 X168.526 Y143.17 E.79106
G1 X167.961 Y143.17 E.00921
G1 X133.62 Y108.83 E.79106
M73 P64 R18
G1 X133.055 Y108.83 E.00921
G1 X167.395 Y143.17 E.79106
G1 X166.83 Y143.17 E.00921
G1 X132.489 Y108.83 E.79106
G1 X131.924 Y108.83 E.00921
G1 X166.264 Y143.17 E.79106
G1 X165.699 Y143.17 E.00921
G1 X131.359 Y108.83 E.79106
G1 X130.793 Y108.83 E.00921
G1 X165.134 Y143.17 E.79106
G1 X164.568 Y143.17 E.00921
G1 X130.228 Y108.83 E.79106
G1 X129.663 Y108.83 E.00921
G1 X164.003 Y143.17 E.79106
G1 X163.437 Y143.17 E.00921
G1 X129.097 Y108.83 E.79106
G1 X128.532 Y108.83 E.00921
G1 X162.872 Y143.17 E.79106
G1 X162.307 Y143.17 E.00921
G1 X127.966 Y108.83 E.79106
G1 X127.401 Y108.83 E.00921
G1 X161.741 Y143.17 E.79106
G1 X161.176 Y143.17 E.00921
G1 X126.836 Y108.83 E.79106
G1 X126.27 Y108.83 E.00921
G1 X160.611 Y143.17 E.79106
G1 X160.045 Y143.17 E.00921
G1 X125.705 Y108.83 E.79106
G1 X125.139 Y108.83 E.00921
G1 X159.48 Y143.17 E.79106
G1 X158.914 Y143.17 E.00921
G1 X124.574 Y108.83 E.79106
G1 X124.009 Y108.83 E.00921
G1 X158.349 Y143.17 E.79106
G1 X157.784 Y143.17 E.00921
G1 X123.443 Y108.83 E.79106
G1 X122.878 Y108.83 E.00921
G1 X157.218 Y143.17 E.79106
G1 X156.653 Y143.17 E.00921
G1 X122.312 Y108.83 E.79106
G1 X121.747 Y108.83 E.00921
G1 X156.087 Y143.17 E.79106
G1 X155.522 Y143.17 E.00921
G1 X121.182 Y108.83 E.79106
G1 X120.616 Y108.83 E.00921
G1 X154.957 Y143.17 E.79106
G1 X154.391 Y143.17 E.00921
G1 X120.051 Y108.83 E.79106
G1 X119.486 Y108.83 E.00921
G1 X153.826 Y143.17 E.79106
G1 X153.261 Y143.17 E.00921
G1 X118.92 Y108.83 E.79106
G1 X118.355 Y108.83 E.00921
G1 X152.695 Y143.17 E.79106
G1 X152.13 Y143.17 E.00921
G1 X117.789 Y108.83 E.79106
G1 X117.224 Y108.83 E.00921
G1 X151.564 Y143.17 E.79106
G1 X150.999 Y143.17 E.00921
G1 X116.659 Y108.83 E.79106
G1 X116.093 Y108.83 E.00921
G1 X150.434 Y143.17 E.79106
G1 X149.868 Y143.17 E.00921
G1 X115.528 Y108.83 E.79106
G1 X114.962 Y108.83 E.00921
G1 X149.303 Y143.17 E.79106
G1 X148.737 Y143.17 E.00921
G1 X114.397 Y108.83 E.79106
G1 X113.832 Y108.83 E.00921
G1 X148.172 Y143.17 E.79106
G1 X147.607 Y143.17 E.00921
G1 X113.266 Y108.83 E.79106
G1 X112.701 Y108.83 E.00921
G1 X147.041 Y143.17 E.79106
G1 X146.476 Y143.17 E.00921
G1 X112.135 Y108.83 E.79106
G1 X111.57 Y108.83 E.00921
G1 X145.91 Y143.17 E.79106
G1 X145.345 Y143.17 E.00921
G1 X111.005 Y108.83 E.79106
G1 X110.439 Y108.83 E.00921
G1 X144.78 Y143.17 E.79106
G1 X144.214 Y143.17 E.00921
G1 X109.874 Y108.83 E.79106
G1 X109.309 Y108.83 E.00921
G1 X143.649 Y143.17 E.79106
G1 X143.084 Y143.17 E.00921
G1 X108.743 Y108.83 E.79106
G1 X108.178 Y108.83 E.00921
G1 X142.518 Y143.17 E.79106
G1 X141.953 Y143.17 E.00921
G1 X107.612 Y108.83 E.79106
G1 X107.047 Y108.83 E.00921
G1 X141.387 Y143.17 E.79106
G1 X140.822 Y143.17 E.00921
G1 X106.482 Y108.83 E.79106
G1 X105.916 Y108.83 E.00921
G1 X140.257 Y143.17 E.79106
G1 X139.691 Y143.17 E.00921
G1 X105.351 Y108.83 E.79106
G1 X104.785 Y108.83 E.00921
G1 X139.126 Y143.17 E.79106
G1 X138.56 Y143.17 E.00921
G1 X104.22 Y108.83 E.79106
G1 X103.655 Y108.83 E.00921
G1 X137.995 Y143.17 E.79106
G1 X137.43 Y143.17 E.00921
G1 X103.089 Y108.83 E.79106
G1 X102.524 Y108.83 E.00921
G1 X136.864 Y143.17 E.79106
G1 X136.299 Y143.17 E.00921
G1 X101.958 Y108.83 E.79106
G1 X101.393 Y108.83 E.00921
G1 X135.733 Y143.17 E.79106
G1 X135.168 Y143.17 E.00921
G1 X100.828 Y108.83 E.79106
G1 X100.262 Y108.83 E.00921
G1 X134.603 Y143.17 E.79106
G1 X134.037 Y143.17 E.00921
G1 X99.697 Y108.83 E.79106
G1 X99.132 Y108.83 E.00921
G1 X133.472 Y143.17 E.79106
G1 X132.907 Y143.17 E.00921
G1 X98.566 Y108.83 E.79106
G1 X98.001 Y108.83 E.00921
G1 X132.341 Y143.17 E.79106
G1 X131.776 Y143.17 E.00921
G1 X97.435 Y108.83 E.79106
G1 X96.87 Y108.83 E.00921
G1 X131.21 Y143.17 E.79106
G1 X130.645 Y143.17 E.00921
M73 P65 R18
G1 X96.305 Y108.83 E.79106
G1 X95.739 Y108.83 E.00921
G1 X130.08 Y143.17 E.79106
G1 X129.514 Y143.17 E.00921
G1 X95.174 Y108.83 E.79106
G1 X94.608 Y108.83 E.00921
G1 X128.949 Y143.17 E.79106
G1 X128.383 Y143.17 E.00921
G1 X94.043 Y108.83 E.79106
G1 X93.478 Y108.83 E.00921
G1 X127.818 Y143.17 E.79106
G1 X127.253 Y143.17 E.00921
G1 X92.912 Y108.83 E.79106
G1 X92.347 Y108.83 E.00921
G1 X126.687 Y143.17 E.79106
G1 X126.122 Y143.17 E.00921
G1 X91.782 Y108.83 E.79106
G1 X91.216 Y108.83 E.00921
G1 X125.556 Y143.17 E.79106
G1 X124.991 Y143.17 E.00921
G1 X90.651 Y108.83 E.79106
G1 X90.085 Y108.83 E.00921
G1 X124.426 Y143.17 E.79106
G1 X123.86 Y143.17 E.00921
G1 X89.52 Y108.83 E.79106
G1 X88.955 Y108.83 E.00921
G1 X123.295 Y143.17 E.79106
G1 X122.73 Y143.17 E.00921
G1 X88.389 Y108.83 E.79106
G1 X87.824 Y108.83 E.00921
G1 X122.164 Y143.17 E.79106
G1 X121.599 Y143.17 E.00921
G1 X87.258 Y108.83 E.79106
G1 X86.693 Y108.83 E.00921
G1 X121.033 Y143.17 E.79106
G1 X120.468 Y143.17 E.00921
G1 X86.128 Y108.83 E.79106
G1 X85.562 Y108.83 E.00921
G1 X119.903 Y143.17 E.79106
G1 X119.337 Y143.17 E.00921
G1 X84.997 Y108.83 E.79106
G1 X84.431 Y108.83 E.00921
M73 P65 R17
G1 X118.772 Y143.17 E.79106
G1 X118.206 Y143.17 E.00921
G1 X83.866 Y108.83 E.79106
G1 X83.301 Y108.83 E.00921
G1 X117.641 Y143.17 E.79106
G1 X117.076 Y143.17 E.00921
G1 X82.735 Y108.83 E.79106
G1 X82.17 Y108.83 E.00921
G1 X116.51 Y143.17 E.79106
G1 X115.945 Y143.17 E.00921
G1 X81.605 Y108.83 E.79106
G1 X81.039 Y108.83 E.00921
G1 X115.379 Y143.17 E.79106
G1 X114.814 Y143.17 E.00921
G1 X80.474 Y108.83 E.79106
G1 X79.908 Y108.83 E.00921
G1 X114.249 Y143.17 E.79106
G1 X113.683 Y143.17 E.00921
G1 X79.343 Y108.83 E.79106
G1 X78.778 Y108.83 E.00921
G1 X113.118 Y143.17 E.79106
G1 X112.553 Y143.17 E.00921
G1 X78.212 Y108.83 E.79106
G1 X77.83 Y108.83 E.00623
G1 X77.83 Y109.013 E.00298
G1 X111.987 Y143.17 E.78685
G1 X111.422 Y143.17 E.00921
G1 X77.83 Y109.578 E.77382
G1 X77.83 Y110.144 E.00921
G1 X110.856 Y143.17 E.7608
G1 X110.291 Y143.17 E.00921
G1 X77.83 Y110.709 E.74778
G1 X77.83 Y111.274 E.00921
G1 X109.726 Y143.17 E.73475
G1 X109.16 Y143.17 E.00921
G1 X77.83 Y111.84 E.72173
G1 X77.83 Y112.405 E.00921
G1 X108.595 Y143.17 E.7087
G1 X108.029 Y143.17 E.00921
G1 X77.83 Y112.971 E.69568
G1 X77.83 Y113.536 E.00921
G1 X107.464 Y143.17 E.68265
G1 X106.899 Y143.17 E.00921
G1 X77.83 Y114.101 E.66963
G1 X77.83 Y114.667 E.00921
G1 X106.333 Y143.17 E.65661
G1 X105.768 Y143.17 E.00921
G1 X77.83 Y115.232 E.64358
G1 X77.83 Y115.798 E.00921
G1 X105.202 Y143.17 E.63056
G1 X104.637 Y143.17 E.00921
G1 X77.83 Y116.363 E.61753
G1 X77.83 Y116.928 E.00921
G1 X104.072 Y143.17 E.60451
G1 X103.506 Y143.17 E.00921
G1 X77.83 Y117.494 E.59148
G1 X77.83 Y118.059 E.00921
G1 X102.941 Y143.17 E.57846
G1 X102.376 Y143.17 E.00921
G1 X77.83 Y118.624 E.56544
G1 X77.83 Y119.19 E.00921
G1 X101.81 Y143.17 E.55241
G1 X101.245 Y143.17 E.00921
G1 X77.83 Y119.755 E.53939
G1 X77.83 Y120.321 E.00921
G1 X100.679 Y143.17 E.52636
G1 X100.114 Y143.17 E.00921
G1 X77.83 Y120.886 E.51334
G1 X77.83 Y121.451 E.00921
G1 X99.549 Y143.17 E.50031
G1 X98.983 Y143.17 E.00921
G1 X77.83 Y122.017 E.48729
G1 X77.83 Y122.582 E.00921
G1 X98.418 Y143.17 E.47427
G1 X97.852 Y143.17 E.00921
G1 X77.83 Y123.148 E.46124
M73 P66 R17
G1 X77.83 Y123.713 E.00921
G1 X97.287 Y143.17 E.44822
G1 X96.722 Y143.17 E.00921
G1 X77.83 Y124.278 E.43519
G1 X77.83 Y124.844 E.00921
G1 X96.156 Y143.17 E.42217
G1 X95.591 Y143.17 E.00921
G1 X77.83 Y125.409 E.40914
G1 X77.83 Y125.974 E.00921
G1 X95.025 Y143.17 E.39612
G1 X94.46 Y143.17 E.00921
G1 X77.83 Y126.54 E.3831
G1 X77.83 Y127.105 E.00921
G1 X93.895 Y143.17 E.37007
G1 X93.329 Y143.17 E.00921
G1 X77.83 Y127.671 E.35705
G1 X77.83 Y128.236 E.00921
G1 X92.764 Y143.17 E.34402
G1 X92.199 Y143.17 E.00921
G1 X77.83 Y128.801 E.331
G1 X77.83 Y129.367 E.00921
G1 X91.633 Y143.17 E.31797
G1 X91.068 Y143.17 E.00921
G1 X77.83 Y129.932 E.30495
G1 X77.83 Y130.498 E.00921
G1 X90.502 Y143.17 E.29193
G1 X89.937 Y143.17 E.00921
G1 X77.83 Y131.063 E.2789
G1 X77.83 Y131.628 E.00921
G1 X89.372 Y143.17 E.26588
G1 X88.806 Y143.17 E.00921
G1 X77.83 Y132.194 E.25285
G1 X77.83 Y132.759 E.00921
G1 X88.241 Y143.17 E.23983
G1 X87.675 Y143.17 E.00921
G1 X77.83 Y133.325 E.2268
G1 X77.83 Y133.89 E.00921
G1 X87.11 Y143.17 E.21378
G1 X86.545 Y143.17 E.00921
G1 X77.83 Y134.455 E.20076
G1 X77.83 Y135.021 E.00921
G1 X85.979 Y143.17 E.18773
G1 X85.414 Y143.17 E.00921
G1 X77.83 Y135.586 E.17471
G1 X77.83 Y136.151 E.00921
G1 X84.849 Y143.17 E.16168
G1 X84.283 Y143.17 E.00921
G1 X77.83 Y136.717 E.14866
G1 X77.83 Y137.282 E.00921
G1 X83.718 Y143.17 E.13563
G1 X83.152 Y143.17 E.00921
G1 X77.83 Y137.848 E.12261
G1 X77.83 Y138.413 E.00921
G1 X82.587 Y143.17 E.10959
G1 X82.022 Y143.17 E.00921
G1 X77.83 Y138.978 E.09656
G1 X77.83 Y139.544 E.00921
G1 X81.456 Y143.17 E.08354
G1 X80.891 Y143.17 E.00921
G1 X77.83 Y140.109 E.07051
G1 X77.83 Y140.675 E.00921
G1 X80.325 Y143.17 E.05749
G1 X79.76 Y143.17 E.00921
G1 X77.65 Y141.061 E.0486
; CHANGE_LAYER
; Z_HEIGHT: 1.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X79.065 Y142.475 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/24
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
M204 S10000
G17
G3 Z1.6 I-1.128 J-.458 P1  F30000
G1 X51.016 Y211.534 Z1.6
G1 Z1.3
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #13
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.7 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z1.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.543 Y143.35 Z1.7 F30000
G1 Z1.3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S3000
G1 X178.17 Y142.722 E.01443
G1 X178.17 Y142.157 E.00918
G1 X177.157 Y143.17 E.02329
G1 X176.593 Y143.17 E.00918
G1 X178.17 Y141.593 E.03627
G1 X178.17 Y141.028 E.00918
G1 X176.028 Y143.17 E.04926
G1 X175.464 Y143.17 E.00918
G1 X178.17 Y140.464 E.06224
G1 X178.17 Y139.9 E.00918
G1 X174.899 Y143.17 E.07522
G1 X174.335 Y143.17 E.00918
G1 X178.17 Y139.335 E.08821
M73 P67 R17
G1 X178.17 Y138.771 E.00918
G1 X173.771 Y143.17 E.10119
G1 X173.206 Y143.17 E.00918
G1 X178.17 Y138.206 E.11417
G1 X178.17 Y137.642 E.00918
G1 X172.642 Y143.17 E.12715
G1 X172.077 Y143.17 E.00918
G1 X178.17 Y137.077 E.14014
G1 X178.17 Y136.513 E.00918
G1 X171.513 Y143.17 E.15312
G1 X170.948 Y143.17 E.00918
G1 X178.17 Y135.948 E.1661
G1 X178.17 Y135.384 E.00918
G1 X170.384 Y143.17 E.17908
G1 X169.819 Y143.17 E.00918
G1 X178.17 Y134.819 E.19207
G1 X178.17 Y134.255 E.00918
G1 X169.255 Y143.17 E.20505
G1 X168.69 Y143.17 E.00918
G1 X178.17 Y133.69 E.21803
G1 X178.17 Y133.126 E.00918
G1 X168.126 Y143.17 E.23101
G1 X167.561 Y143.17 E.00918
G1 X178.17 Y132.561 E.244
G1 X178.17 Y131.997 E.00918
G1 X166.997 Y143.17 E.25698
G1 X166.432 Y143.17 E.00918
G1 X178.17 Y131.432 E.26996
G1 X178.17 Y130.868 E.00918
G1 X165.868 Y143.17 E.28294
G1 X165.303 Y143.17 E.00918
G1 X178.17 Y130.303 E.29593
G1 X178.17 Y129.739 E.00918
G1 X164.739 Y143.17 E.30891
G1 X164.174 Y143.17 E.00918
G1 X178.17 Y129.174 E.32189
G1 X178.17 Y128.61 E.00918
G1 X163.61 Y143.17 E.33488
G1 X163.045 Y143.17 E.00918
G1 X178.17 Y128.045 E.34786
G1 X178.17 Y127.481 E.00918
G1 X162.481 Y143.17 E.36084
G1 X161.916 Y143.17 E.00918
G1 X178.17 Y126.916 E.37382
G1 X178.17 Y126.352 E.00918
G1 X161.352 Y143.17 E.38681
G1 X160.787 Y143.17 E.00918
G1 X178.17 Y125.787 E.39979
G1 X178.17 Y125.223 E.00918
G1 X160.223 Y143.17 E.41277
G1 X159.658 Y143.17 E.00918
G1 X178.17 Y124.658 E.42575
G1 X178.17 Y124.094 E.00918
G1 X159.094 Y143.17 E.43874
G1 X158.529 Y143.17 E.00918
G1 X178.17 Y123.529 E.45172
G1 X178.17 Y122.965 E.00918
G1 X157.965 Y143.17 E.4647
G1 X157.401 Y143.17 E.00918
G1 X178.17 Y122.401 E.47768
M73 P67 R16
G1 X178.17 Y121.836 E.00918
G1 X156.836 Y143.17 E.49067
G1 X156.272 Y143.17 E.00918
G1 X178.17 Y121.272 E.50365
G1 X178.17 Y120.707 E.00918
G1 X155.707 Y143.17 E.51663
G1 X155.143 Y143.17 E.00918
G1 X178.17 Y120.143 E.52961
G1 X178.17 Y119.578 E.00918
G1 X154.578 Y143.17 E.5426
G1 X154.014 Y143.17 E.00918
G1 X178.17 Y119.014 E.55558
G1 X178.17 Y118.449 E.00918
G1 X153.449 Y143.17 E.56856
G1 X152.885 Y143.17 E.00918
G1 X178.17 Y117.885 E.58155
G1 X178.17 Y117.32 E.00918
G1 X152.32 Y143.17 E.59453
G1 X151.756 Y143.17 E.00918
G1 X178.17 Y116.756 E.60751
G1 X178.17 Y116.191 E.00918
G1 X151.191 Y143.17 E.62049
G1 X150.627 Y143.17 E.00918
G1 X178.17 Y115.627 E.63348
G1 X178.17 Y115.062 E.00918
G1 X150.062 Y143.17 E.64646
G1 X149.498 Y143.17 E.00918
G1 X178.17 Y114.498 E.65944
G1 X178.17 Y113.933 E.00918
G1 X148.933 Y143.17 E.67242
G1 X148.369 Y143.17 E.00918
G1 X178.17 Y113.369 E.68541
G1 X178.17 Y112.804 E.00918
G1 X147.804 Y143.17 E.69839
G1 X147.24 Y143.17 E.00918
G1 X178.17 Y112.24 E.71137
G1 X178.17 Y111.675 E.00918
G1 X146.675 Y143.17 E.72435
G1 X146.111 Y143.17 E.00918
G1 X178.17 Y111.111 E.73734
G1 X178.17 Y110.546 E.00918
G1 X145.546 Y143.17 E.75032
G1 X144.982 Y143.17 E.00918
G1 X178.17 Y109.982 E.7633
G1 X178.17 Y109.417 E.00918
G1 X144.417 Y143.17 E.77628
G1 X143.853 Y143.17 E.00918
G1 X178.17 Y108.853 E.78927
G1 X178.17 Y108.83 E.00038
G1 X177.629 Y108.83 E.0088
G1 X143.288 Y143.17 E.7898
G1 X142.724 Y143.17 E.00918
G1 X177.064 Y108.83 E.7898
G1 X176.5 Y108.83 E.00918
G1 X142.159 Y143.17 E.7898
G1 X141.595 Y143.17 E.00918
G1 X175.935 Y108.83 E.7898
G1 X175.371 Y108.83 E.00918
G1 X141.03 Y143.17 E.7898
G1 X140.466 Y143.17 E.00918
G1 X174.806 Y108.83 E.7898
G1 X174.242 Y108.83 E.00918
G1 X139.902 Y143.17 E.7898
G1 X139.337 Y143.17 E.00918
G1 X173.677 Y108.83 E.7898
G1 X173.113 Y108.83 E.00918
G1 X138.773 Y143.17 E.7898
G1 X138.208 Y143.17 E.00918
G1 X172.548 Y108.83 E.7898
G1 X171.984 Y108.83 E.00918
G1 X137.644 Y143.17 E.7898
G1 X137.079 Y143.17 E.00918
G1 X171.419 Y108.83 E.7898
G1 X170.855 Y108.83 E.00918
G1 X136.515 Y143.17 E.7898
G1 X135.95 Y143.17 E.00918
G1 X170.291 Y108.83 E.7898
G1 X169.726 Y108.83 E.00918
G1 X135.386 Y143.17 E.7898
G1 X134.821 Y143.17 E.00918
G1 X169.162 Y108.83 E.7898
G1 X168.597 Y108.83 E.00918
G1 X134.257 Y143.17 E.7898
G1 X133.692 Y143.17 E.00918
G1 X168.033 Y108.83 E.7898
G1 X167.468 Y108.83 E.00918
G1 X133.128 Y143.17 E.7898
G1 X132.563 Y143.17 E.00918
G1 X166.904 Y108.83 E.7898
G1 X166.339 Y108.83 E.00918
G1 X131.999 Y143.17 E.7898
G1 X131.434 Y143.17 E.00918
G1 X165.775 Y108.83 E.7898
G1 X165.21 Y108.83 E.00918
G1 X130.87 Y143.17 E.7898
G1 X130.305 Y143.17 E.00918
G1 X164.646 Y108.83 E.7898
G1 X164.081 Y108.83 E.00918
G1 X129.741 Y143.17 E.7898
G1 X129.176 Y143.17 E.00918
G1 X163.517 Y108.83 E.7898
G1 X162.952 Y108.83 E.00918
G1 X128.612 Y143.17 E.7898
G1 X128.047 Y143.17 E.00918
G1 X162.388 Y108.83 E.7898
G1 X161.823 Y108.83 E.00918
G1 X127.483 Y143.17 E.7898
G1 X126.918 Y143.17 E.00918
G1 X161.259 Y108.83 E.7898
G1 X160.694 Y108.83 E.00918
G1 X126.354 Y143.17 E.7898
G1 X125.789 Y143.17 E.00918
G1 X160.13 Y108.83 E.7898
G1 X159.565 Y108.83 E.00918
G1 X125.225 Y143.17 E.7898
G1 X124.66 Y143.17 E.00918
G1 X159.001 Y108.83 E.7898
G1 X158.436 Y108.83 E.00918
G1 X124.096 Y143.17 E.7898
G1 X123.532 Y143.17 E.00918
G1 X157.872 Y108.83 E.7898
G1 X157.307 Y108.83 E.00918
G1 X122.967 Y143.17 E.7898
G1 X122.403 Y143.17 E.00918
G1 X156.743 Y108.83 E.7898
G1 X156.178 Y108.83 E.00918
G1 X121.838 Y143.17 E.7898
M73 P68 R16
G1 X121.274 Y143.17 E.00918
G1 X155.614 Y108.83 E.7898
G1 X155.049 Y108.83 E.00918
G1 X120.709 Y143.17 E.7898
G1 X120.145 Y143.17 E.00918
G1 X154.485 Y108.83 E.7898
G1 X153.92 Y108.83 E.00918
G1 X119.58 Y143.17 E.7898
G1 X119.016 Y143.17 E.00918
G1 X153.356 Y108.83 E.7898
G1 X152.792 Y108.83 E.00918
G1 X118.451 Y143.17 E.7898
G1 X117.887 Y143.17 E.00918
G1 X152.227 Y108.83 E.7898
G1 X151.663 Y108.83 E.00918
G1 X117.322 Y143.17 E.7898
G1 X116.758 Y143.17 E.00918
G1 X151.098 Y108.83 E.7898
G1 X150.534 Y108.83 E.00918
G1 X116.193 Y143.17 E.7898
G1 X115.629 Y143.17 E.00918
G1 X149.969 Y108.83 E.7898
G1 X149.405 Y108.83 E.00918
G1 X115.064 Y143.17 E.7898
G1 X114.5 Y143.17 E.00918
G1 X148.84 Y108.83 E.7898
G1 X148.276 Y108.83 E.00918
G1 X113.935 Y143.17 E.7898
G1 X113.371 Y143.17 E.00918
G1 X147.711 Y108.83 E.7898
G1 X147.147 Y108.83 E.00918
G1 X112.806 Y143.17 E.7898
G1 X112.242 Y143.17 E.00918
G1 X146.582 Y108.83 E.7898
G1 X146.018 Y108.83 E.00918
G1 X111.677 Y143.17 E.7898
G1 X111.113 Y143.17 E.00918
G1 X145.453 Y108.83 E.7898
G1 X144.889 Y108.83 E.00918
G1 X110.548 Y143.17 E.7898
G1 X109.984 Y143.17 E.00918
G1 X144.324 Y108.83 E.7898
G1 X143.76 Y108.83 E.00918
G1 X109.419 Y143.17 E.7898
G1 X108.855 Y143.17 E.00918
G1 X143.195 Y108.83 E.7898
G1 X142.631 Y108.83 E.00918
G1 X108.29 Y143.17 E.7898
G1 X107.726 Y143.17 E.00918
G1 X142.066 Y108.83 E.7898
G1 X141.502 Y108.83 E.00918
G1 X107.161 Y143.17 E.7898
G1 X106.597 Y143.17 E.00918
G1 X140.937 Y108.83 E.7898
G1 X140.373 Y108.83 E.00918
G1 X106.033 Y143.17 E.7898
G1 X105.468 Y143.17 E.00918
G1 X139.808 Y108.83 E.7898
G1 X139.244 Y108.83 E.00918
G1 X104.904 Y143.17 E.7898
G1 X104.339 Y143.17 E.00918
G1 X138.679 Y108.83 E.7898
G1 X138.115 Y108.83 E.00918
G1 X103.775 Y143.17 E.7898
G1 X103.21 Y143.17 E.00918
G1 X137.55 Y108.83 E.7898
G1 X136.986 Y108.83 E.00918
G1 X102.646 Y143.17 E.7898
G1 X102.081 Y143.17 E.00918
G1 X136.421 Y108.83 E.7898
G1 X135.857 Y108.83 E.00918
G1 X101.517 Y143.17 E.7898
G1 X100.952 Y143.17 E.00918
G1 X135.293 Y108.83 E.7898
G1 X134.728 Y108.83 E.00918
G1 X100.388 Y143.17 E.7898
G1 X99.823 Y143.17 E.00918
G1 X134.164 Y108.83 E.7898
G1 X133.599 Y108.83 E.00918
G1 X99.259 Y143.17 E.7898
G1 X98.694 Y143.17 E.00918
G1 X133.035 Y108.83 E.7898
G1 X132.47 Y108.83 E.00918
G1 X98.13 Y143.17 E.7898
G1 X97.565 Y143.17 E.00918
G1 X131.906 Y108.83 E.7898
G1 X131.341 Y108.83 E.00918
G1 X97.001 Y143.17 E.7898
G1 X96.436 Y143.17 E.00918
G1 X130.777 Y108.83 E.7898
G1 X130.212 Y108.83 E.00918
G1 X95.872 Y143.17 E.7898
G1 X95.307 Y143.17 E.00918
G1 X129.648 Y108.83 E.7898
G1 X129.083 Y108.83 E.00918
G1 X94.743 Y143.17 E.7898
G1 X94.178 Y143.17 E.00918
G1 X128.519 Y108.83 E.7898
G1 X127.954 Y108.83 E.00918
G1 X93.614 Y143.17 E.7898
G1 X93.049 Y143.17 E.00918
G1 X127.39 Y108.83 E.7898
G1 X126.825 Y108.83 E.00918
G1 X92.485 Y143.17 E.7898
G1 X91.92 Y143.17 E.00918
G1 X126.261 Y108.83 E.7898
G1 X125.696 Y108.83 E.00918
G1 X91.356 Y143.17 E.7898
G1 X90.791 Y143.17 E.00918
G1 X125.132 Y108.83 E.7898
G1 X124.567 Y108.83 E.00918
G1 X90.227 Y143.17 E.7898
G1 X89.662 Y143.17 E.00918
G1 X124.003 Y108.83 E.7898
G1 X123.438 Y108.83 E.00918
G1 X89.098 Y143.17 E.7898
G1 X88.534 Y143.17 E.00918
G1 X122.874 Y108.83 E.7898
G1 X122.309 Y108.83 E.00918
M73 P69 R16
G1 X87.969 Y143.17 E.7898
G1 X87.405 Y143.17 E.00918
G1 X121.745 Y108.83 E.7898
G1 X121.18 Y108.83 E.00918
G1 X86.84 Y143.17 E.7898
G1 X86.276 Y143.17 E.00918
G1 X120.616 Y108.83 E.7898
G1 X120.051 Y108.83 E.00918
G1 X85.711 Y143.17 E.7898
G1 X85.147 Y143.17 E.00918
G1 X119.487 Y108.83 E.7898
G1 X118.923 Y108.83 E.00918
G1 X84.582 Y143.17 E.7898
G1 X84.018 Y143.17 E.00918
G1 X118.358 Y108.83 E.7898
G1 X117.794 Y108.83 E.00918
G1 X83.453 Y143.17 E.7898
G1 X82.889 Y143.17 E.00918
G1 X117.229 Y108.83 E.7898
G1 X116.665 Y108.83 E.00918
G1 X82.324 Y143.17 E.7898
G1 X81.76 Y143.17 E.00918
G1 X116.1 Y108.83 E.7898
G1 X115.536 Y108.83 E.00918
G1 X81.195 Y143.17 E.7898
G1 X80.631 Y143.17 E.00918
M73 P69 R15
G1 X114.971 Y108.83 E.7898
G1 X114.407 Y108.83 E.00918
G1 X80.066 Y143.17 E.7898
G1 X79.758 Y143.17 E.00501
G1 X79.63 Y143.042 E.00295
G1 X113.842 Y108.83 E.78685
G1 X113.278 Y108.83 E.00918
G1 X79.348 Y142.76 E.78036
G1 X79.065 Y142.478 E.00649
G1 X112.713 Y108.83 E.77387
G1 X112.149 Y108.83 E.00918
G1 X78.783 Y142.195 E.76738
G1 X78.501 Y141.913 E.00649
G1 X111.584 Y108.83 E.76089
G1 X111.02 Y108.83 E.00918
G1 X78.219 Y141.631 E.7544
G1 X77.936 Y141.349 E.00649
G1 X110.455 Y108.83 E.7479
G1 X109.891 Y108.83 E.00918
G1 X77.83 Y140.891 E.73737
G1 X77.83 Y140.326 E.00918
G1 X109.326 Y108.83 E.72439
G1 X108.762 Y108.83 E.00918
G1 X77.83 Y139.762 E.71141
G1 X77.83 Y139.197 E.00918
G1 X108.197 Y108.83 E.69843
G1 X107.633 Y108.83 E.00918
G1 X77.83 Y138.633 E.68544
G1 X77.83 Y138.068 E.00918
G1 X107.068 Y108.83 E.67246
G1 X106.504 Y108.83 E.00918
G1 X77.83 Y137.504 E.65948
G1 X77.83 Y136.939 E.00918
G1 X105.939 Y108.83 E.6465
G1 X105.375 Y108.83 E.00918
G1 X77.83 Y136.375 E.63351
G1 X77.83 Y135.81 E.00918
G1 X104.81 Y108.83 E.62053
G1 X104.246 Y108.83 E.00918
G1 X77.83 Y135.246 E.60755
G1 X77.83 Y134.681 E.00918
G1 X103.681 Y108.83 E.59457
G1 X103.117 Y108.83 E.00918
G1 X77.83 Y134.117 E.58158
G1 X77.83 Y133.552 E.00918
G1 X102.552 Y108.83 E.5686
G1 X101.988 Y108.83 E.00918
G1 X77.83 Y132.988 E.55562
G1 X77.83 Y132.424 E.00918
G1 X101.424 Y108.83 E.54263
G1 X100.859 Y108.83 E.00918
G1 X77.83 Y131.859 E.52965
G1 X77.83 Y131.295 E.00918
G1 X100.295 Y108.83 E.51667
G1 X99.73 Y108.83 E.00918
G1 X77.83 Y130.73 E.50369
G1 X77.83 Y130.166 E.00918
G1 X99.166 Y108.83 E.4907
G1 X98.601 Y108.83 E.00918
G1 X77.83 Y129.601 E.47772
G1 X77.83 Y129.037 E.00918
G1 X98.037 Y108.83 E.46474
G1 X97.472 Y108.83 E.00918
G1 X77.83 Y128.472 E.45176
G1 X77.83 Y127.908 E.00918
G1 X96.908 Y108.83 E.43877
G1 X96.343 Y108.83 E.00918
G1 X77.83 Y127.343 E.42579
G1 X77.83 Y126.779 E.00918
G1 X95.779 Y108.83 E.41281
G1 X95.214 Y108.83 E.00918
G1 X77.83 Y126.214 E.39983
G1 X77.83 Y125.65 E.00918
G1 X94.65 Y108.83 E.38684
G1 X94.085 Y108.83 E.00918
G1 X77.83 Y125.085 E.37386
G1 X77.83 Y124.521 E.00918
G1 X93.521 Y108.83 E.36088
G1 X92.956 Y108.83 E.00918
G1 X77.83 Y123.956 E.3479
G1 X77.83 Y123.392 E.00918
G1 X92.392 Y108.83 E.33491
G1 X91.827 Y108.83 E.00918
G1 X77.83 Y122.827 E.32193
G1 X77.83 Y122.263 E.00918
G1 X91.263 Y108.83 E.30895
G1 X90.698 Y108.83 E.00918
G1 X77.83 Y121.698 E.29596
G1 X77.83 Y121.134 E.00918
G1 X90.134 Y108.83 E.28298
G1 X89.569 Y108.83 E.00918
G1 X77.83 Y120.569 E.27
M73 P70 R15
G1 X77.83 Y120.005 E.00918
G1 X89.005 Y108.83 E.25702
G1 X88.44 Y108.83 E.00918
G1 X77.83 Y119.44 E.24403
G1 X77.83 Y118.876 E.00918
G1 X87.876 Y108.83 E.23105
G1 X87.311 Y108.83 E.00918
G1 X77.83 Y118.311 E.21807
G1 X77.83 Y117.747 E.00918
G1 X86.747 Y108.83 E.20509
G1 X86.182 Y108.83 E.00918
G1 X77.83 Y117.182 E.1921
G1 X77.83 Y116.618 E.00918
G1 X85.618 Y108.83 E.17912
G1 X85.054 Y108.83 E.00918
G1 X77.83 Y116.054 E.16614
G1 X77.83 Y115.489 E.00918
G1 X84.489 Y108.83 E.15316
G1 X83.925 Y108.83 E.00918
G1 X77.83 Y114.925 E.14017
G1 X77.83 Y114.36 E.00918
G1 X83.36 Y108.83 E.12719
G1 X82.796 Y108.83 E.00918
G1 X77.83 Y113.796 E.11421
G1 X77.83 Y113.231 E.00918
G1 X82.231 Y108.83 E.10123
G1 X81.667 Y108.83 E.00918
G1 X77.83 Y112.667 E.08824
G1 X77.83 Y112.102 E.00918
G1 X81.102 Y108.83 E.07526
G1 X80.538 Y108.83 E.00918
G1 X77.83 Y111.538 E.06228
G1 X77.83 Y110.973 E.00918
G1 X79.973 Y108.83 E.04929
G1 X79.409 Y108.83 E.00918
G1 X77.83 Y110.409 E.03631
G1 X77.83 Y109.844 E.00918
G1 X78.844 Y108.83 E.02333
G1 X78.28 Y108.83 E.00918
G1 X77.65 Y109.459 E.01447
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X78.28 Y108.83 E-.33815
G1 X78.844 Y108.83 E-.21451
G1 X78.458 Y109.216 E-.20735
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/24
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
M204 S10000
G17
G3 Z1.7 I-1.175 J-.315 P1  F30000
G1 X51.016 Y211.534 Z1.7
G1 Z1.4
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #14
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.911 Y137.1 Z1.8 F30000
G1 X178.35 Y109.459 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S3000
G1 X177.721 Y108.83 E.01449
G1 X177.155 Y108.83 E.00921
G1 X178.17 Y109.845 E.02338
G1 X178.17 Y110.41 E.00921
G1 X176.59 Y108.83 E.03641
G1 X176.024 Y108.83 E.00921
G1 X178.17 Y110.976 E.04943
G1 X178.17 Y111.541 E.00921
G1 X175.459 Y108.83 E.06245
G1 X174.894 Y108.83 E.00921
G1 X178.17 Y112.106 E.07548
G1 X178.17 Y112.672 E.00921
G1 X174.328 Y108.83 E.0885
G1 X173.763 Y108.83 E.00921
G1 X178.17 Y113.237 E.10153
G1 X178.17 Y113.803 E.00921
G1 X173.197 Y108.83 E.11455
G1 X172.632 Y108.83 E.00921
G1 X178.17 Y114.368 E.12758
G1 X178.17 Y114.933 E.00921
G1 X172.067 Y108.83 E.1406
G1 X171.501 Y108.83 E.00921
G1 X178.17 Y115.499 E.15362
G1 X178.17 Y116.064 E.00921
G1 X170.936 Y108.83 E.16665
G1 X170.37 Y108.83 E.00921
G1 X178.17 Y116.629 E.17967
G1 X178.17 Y117.195 E.00921
G1 X169.805 Y108.83 E.1927
G1 X169.24 Y108.83 E.00921
G1 X178.17 Y117.76 E.20572
G1 X178.17 Y118.326 E.00921
G1 X168.674 Y108.83 E.21875
G1 X168.109 Y108.83 E.00921
G1 X178.17 Y118.891 E.23177
G1 X178.17 Y119.456 E.00921
G1 X167.544 Y108.83 E.24479
G1 X166.978 Y108.83 E.00921
G1 X178.17 Y120.022 E.25782
G1 X178.17 Y120.587 E.00921
G1 X166.413 Y108.83 E.27084
G1 X165.847 Y108.83 E.00921
G1 X178.17 Y121.153 E.28387
G1 X178.17 Y121.718 E.00921
G1 X165.282 Y108.83 E.29689
G1 X164.717 Y108.83 E.00921
G1 X178.17 Y122.283 E.30992
G1 X178.17 Y122.849 E.00921
G1 X164.151 Y108.83 E.32294
G1 X163.586 Y108.83 E.00921
G1 X178.17 Y123.414 E.33596
G1 X178.17 Y123.98 E.00921
G1 X163.02 Y108.83 E.34899
G1 X162.455 Y108.83 E.00921
G1 X178.17 Y124.545 E.36201
G1 X178.17 Y125.11 E.00921
G1 X161.89 Y108.83 E.37504
G1 X161.324 Y108.83 E.00921
G1 X178.17 Y125.676 E.38806
G1 X178.17 Y126.241 E.00921
G1 X160.759 Y108.83 E.40109
G1 X160.194 Y108.83 E.00921
G1 X178.17 Y126.806 E.41411
G1 X178.17 Y127.372 E.00921
G1 X159.628 Y108.83 E.42713
G1 X159.063 Y108.83 E.00921
G1 X178.17 Y127.937 E.44016
G1 X178.17 Y128.503 E.00921
G1 X158.497 Y108.83 E.45318
M73 P71 R15
G1 X157.932 Y108.83 E.00921
G1 X178.17 Y129.068 E.46621
G1 X178.17 Y129.633 E.00921
G1 X157.367 Y108.83 E.47923
G1 X156.801 Y108.83 E.00921
G1 X178.17 Y130.199 E.49226
G1 X178.17 Y130.764 E.00921
G1 X156.236 Y108.83 E.50528
G1 X155.67 Y108.83 E.00921
G1 X178.17 Y131.33 E.5183
G1 X178.17 Y131.895 E.00921
M73 P71 R14
G1 X155.105 Y108.83 E.53133
G1 X154.54 Y108.83 E.00921
G1 X178.17 Y132.46 E.54435
G1 X178.17 Y133.026 E.00921
G1 X153.974 Y108.83 E.55738
G1 X153.409 Y108.83 E.00921
G1 X178.17 Y133.591 E.5704
G1 X178.17 Y134.157 E.00921
G1 X152.843 Y108.83 E.58343
G1 X152.278 Y108.83 E.00921
G1 X178.17 Y134.722 E.59645
G1 X178.17 Y135.287 E.00921
G1 X151.713 Y108.83 E.60947
G1 X151.147 Y108.83 E.00921
G1 X178.17 Y135.853 E.6225
G1 X178.17 Y136.418 E.00921
G1 X150.582 Y108.83 E.63552
G1 X150.017 Y108.83 E.00921
G1 X178.17 Y136.983 E.64855
G1 X178.17 Y137.549 E.00921
G1 X149.451 Y108.83 E.66157
G1 X148.886 Y108.83 E.00921
G1 X178.17 Y138.114 E.6746
G1 X178.17 Y138.68 E.00921
G1 X148.32 Y108.83 E.68762
G1 X147.755 Y108.83 E.00921
G1 X178.17 Y139.245 E.70064
G1 X178.17 Y139.81 E.00921
G1 X147.19 Y108.83 E.71367
G1 X146.624 Y108.83 E.00921
G1 X178.17 Y140.376 E.72669
G1 X178.17 Y140.941 E.00921
G1 X146.059 Y108.83 E.73972
G1 X145.493 Y108.83 E.00921
G1 X178.17 Y141.507 E.75274
G1 X178.17 Y142.072 E.00921
G1 X144.928 Y108.83 E.76577
G1 X144.363 Y108.83 E.00921
G1 X178.17 Y142.637 E.77879
G1 X178.17 Y143.17 E.00868
G1 X178.138 Y143.17 E.00053
G1 X143.797 Y108.83 E.79106
G1 X143.232 Y108.83 E.00921
G1 X177.572 Y143.17 E.79106
G1 X177.007 Y143.17 E.00921
G1 X142.666 Y108.83 E.79106
G1 X142.101 Y108.83 E.00921
G1 X176.441 Y143.17 E.79106
G1 X175.876 Y143.17 E.00921
G1 X141.536 Y108.83 E.79106
G1 X140.97 Y108.83 E.00921
G1 X175.311 Y143.17 E.79106
G1 X174.745 Y143.17 E.00921
G1 X140.405 Y108.83 E.79106
G1 X139.84 Y108.83 E.00921
G1 X174.18 Y143.17 E.79106
G1 X173.614 Y143.17 E.00921
G1 X139.274 Y108.83 E.79106
G1 X138.709 Y108.83 E.00921
G1 X173.049 Y143.17 E.79106
G1 X172.484 Y143.17 E.00921
G1 X138.143 Y108.83 E.79106
G1 X137.578 Y108.83 E.00921
G1 X171.918 Y143.17 E.79106
G1 X171.353 Y143.17 E.00921
G1 X137.013 Y108.83 E.79106
G1 X136.447 Y108.83 E.00921
G1 X170.788 Y143.17 E.79106
G1 X170.222 Y143.17 E.00921
G1 X135.882 Y108.83 E.79106
G1 X135.316 Y108.83 E.00921
G1 X169.657 Y143.17 E.79106
G1 X169.091 Y143.17 E.00921
G1 X134.751 Y108.83 E.79106
G1 X134.186 Y108.83 E.00921
G1 X168.526 Y143.17 E.79106
G1 X167.961 Y143.17 E.00921
G1 X133.62 Y108.83 E.79106
G1 X133.055 Y108.83 E.00921
G1 X167.395 Y143.17 E.79106
G1 X166.83 Y143.17 E.00921
G1 X132.489 Y108.83 E.79106
G1 X131.924 Y108.83 E.00921
G1 X166.264 Y143.17 E.79106
G1 X165.699 Y143.17 E.00921
G1 X131.359 Y108.83 E.79106
G1 X130.793 Y108.83 E.00921
G1 X165.134 Y143.17 E.79106
G1 X164.568 Y143.17 E.00921
G1 X130.228 Y108.83 E.79106
G1 X129.663 Y108.83 E.00921
G1 X164.003 Y143.17 E.79106
G1 X163.437 Y143.17 E.00921
G1 X129.097 Y108.83 E.79106
G1 X128.532 Y108.83 E.00921
G1 X162.872 Y143.17 E.79106
G1 X162.307 Y143.17 E.00921
G1 X127.966 Y108.83 E.79106
G1 X127.401 Y108.83 E.00921
G1 X161.741 Y143.17 E.79106
G1 X161.176 Y143.17 E.00921
G1 X126.836 Y108.83 E.79106
G1 X126.27 Y108.83 E.00921
G1 X160.611 Y143.17 E.79106
G1 X160.045 Y143.17 E.00921
G1 X125.705 Y108.83 E.79106
G1 X125.139 Y108.83 E.00921
G1 X159.48 Y143.17 E.79106
G1 X158.914 Y143.17 E.00921
G1 X124.574 Y108.83 E.79106
G1 X124.009 Y108.83 E.00921
G1 X158.349 Y143.17 E.79106
G1 X157.784 Y143.17 E.00921
G1 X123.443 Y108.83 E.79106
G1 X122.878 Y108.83 E.00921
G1 X157.218 Y143.17 E.79106
G1 X156.653 Y143.17 E.00921
G1 X122.312 Y108.83 E.79106
G1 X121.747 Y108.83 E.00921
G1 X156.087 Y143.17 E.79106
G1 X155.522 Y143.17 E.00921
G1 X121.182 Y108.83 E.79106
G1 X120.616 Y108.83 E.00921
G1 X154.957 Y143.17 E.79106
G1 X154.391 Y143.17 E.00921
G1 X120.051 Y108.83 E.79106
G1 X119.486 Y108.83 E.00921
G1 X153.826 Y143.17 E.79106
G1 X153.261 Y143.17 E.00921
G1 X118.92 Y108.83 E.79106
G1 X118.355 Y108.83 E.00921
G1 X152.695 Y143.17 E.79106
G1 X152.13 Y143.17 E.00921
G1 X117.789 Y108.83 E.79106
G1 X117.224 Y108.83 E.00921
G1 X151.564 Y143.17 E.79106
G1 X150.999 Y143.17 E.00921
G1 X116.659 Y108.83 E.79106
G1 X116.093 Y108.83 E.00921
G1 X150.434 Y143.17 E.79106
G1 X149.868 Y143.17 E.00921
G1 X115.528 Y108.83 E.79106
G1 X114.962 Y108.83 E.00921
G1 X149.303 Y143.17 E.79106
G1 X148.737 Y143.17 E.00921
G1 X114.397 Y108.83 E.79106
G1 X113.832 Y108.83 E.00921
G1 X148.172 Y143.17 E.79106
G1 X147.607 Y143.17 E.00921
G1 X113.266 Y108.83 E.79106
G1 X112.701 Y108.83 E.00921
M73 P72 R14
G1 X147.041 Y143.17 E.79106
G1 X146.476 Y143.17 E.00921
G1 X112.135 Y108.83 E.79106
G1 X111.57 Y108.83 E.00921
G1 X145.91 Y143.17 E.79106
G1 X145.345 Y143.17 E.00921
G1 X111.005 Y108.83 E.79106
G1 X110.439 Y108.83 E.00921
G1 X144.78 Y143.17 E.79106
G1 X144.214 Y143.17 E.00921
G1 X109.874 Y108.83 E.79106
G1 X109.309 Y108.83 E.00921
G1 X143.649 Y143.17 E.79106
G1 X143.084 Y143.17 E.00921
G1 X108.743 Y108.83 E.79106
G1 X108.178 Y108.83 E.00921
G1 X142.518 Y143.17 E.79106
G1 X141.953 Y143.17 E.00921
G1 X107.612 Y108.83 E.79106
G1 X107.047 Y108.83 E.00921
G1 X141.387 Y143.17 E.79106
G1 X140.822 Y143.17 E.00921
G1 X106.482 Y108.83 E.79106
G1 X105.916 Y108.83 E.00921
G1 X140.257 Y143.17 E.79106
G1 X139.691 Y143.17 E.00921
G1 X105.351 Y108.83 E.79106
G1 X104.785 Y108.83 E.00921
G1 X139.126 Y143.17 E.79106
G1 X138.56 Y143.17 E.00921
G1 X104.22 Y108.83 E.79106
G1 X103.655 Y108.83 E.00921
G1 X137.995 Y143.17 E.79106
G1 X137.43 Y143.17 E.00921
G1 X103.089 Y108.83 E.79106
G1 X102.524 Y108.83 E.00921
G1 X136.864 Y143.17 E.79106
G1 X136.299 Y143.17 E.00921
G1 X101.958 Y108.83 E.79106
G1 X101.393 Y108.83 E.00921
G1 X135.733 Y143.17 E.79106
G1 X135.168 Y143.17 E.00921
G1 X100.828 Y108.83 E.79106
G1 X100.262 Y108.83 E.00921
G1 X134.603 Y143.17 E.79106
G1 X134.037 Y143.17 E.00921
G1 X99.697 Y108.83 E.79106
G1 X99.132 Y108.83 E.00921
G1 X133.472 Y143.17 E.79106
G1 X132.907 Y143.17 E.00921
G1 X98.566 Y108.83 E.79106
G1 X98.001 Y108.83 E.00921
G1 X132.341 Y143.17 E.79106
G1 X131.776 Y143.17 E.00921
G1 X97.435 Y108.83 E.79106
G1 X96.87 Y108.83 E.00921
G1 X131.21 Y143.17 E.79106
G1 X130.645 Y143.17 E.00921
G1 X96.305 Y108.83 E.79106
G1 X95.739 Y108.83 E.00921
G1 X130.08 Y143.17 E.79106
G1 X129.514 Y143.17 E.00921
G1 X95.174 Y108.83 E.79106
G1 X94.608 Y108.83 E.00921
G1 X128.949 Y143.17 E.79106
G1 X128.383 Y143.17 E.00921
G1 X94.043 Y108.83 E.79106
G1 X93.478 Y108.83 E.00921
G1 X127.818 Y143.17 E.79106
G1 X127.253 Y143.17 E.00921
G1 X92.912 Y108.83 E.79106
G1 X92.347 Y108.83 E.00921
G1 X126.687 Y143.17 E.79106
G1 X126.122 Y143.17 E.00921
G1 X91.782 Y108.83 E.79106
G1 X91.216 Y108.83 E.00921
G1 X125.556 Y143.17 E.79106
G1 X124.991 Y143.17 E.00921
G1 X90.651 Y108.83 E.79106
G1 X90.085 Y108.83 E.00921
G1 X124.426 Y143.17 E.79106
G1 X123.86 Y143.17 E.00921
G1 X89.52 Y108.83 E.79106
G1 X88.955 Y108.83 E.00921
G1 X123.295 Y143.17 E.79106
G1 X122.73 Y143.17 E.00921
G1 X88.389 Y108.83 E.79106
G1 X87.824 Y108.83 E.00921
G1 X122.164 Y143.17 E.79106
G1 X121.599 Y143.17 E.00921
G1 X87.258 Y108.83 E.79106
G1 X86.693 Y108.83 E.00921
G1 X121.033 Y143.17 E.79106
G1 X120.468 Y143.17 E.00921
G1 X86.128 Y108.83 E.79106
G1 X85.562 Y108.83 E.00921
G1 X119.903 Y143.17 E.79106
G1 X119.337 Y143.17 E.00921
G1 X84.997 Y108.83 E.79106
G1 X84.431 Y108.83 E.00921
G1 X118.772 Y143.17 E.79106
G1 X118.206 Y143.17 E.00921
G1 X83.866 Y108.83 E.79106
G1 X83.301 Y108.83 E.00921
G1 X117.641 Y143.17 E.79106
G1 X117.076 Y143.17 E.00921
G1 X82.735 Y108.83 E.79106
G1 X82.17 Y108.83 E.00921
G1 X116.51 Y143.17 E.79106
G1 X115.945 Y143.17 E.00921
G1 X81.605 Y108.83 E.79106
G1 X81.039 Y108.83 E.00921
G1 X115.379 Y143.17 E.79106
G1 X114.814 Y143.17 E.00921
G1 X80.474 Y108.83 E.79106
G1 X79.908 Y108.83 E.00921
G1 X114.249 Y143.17 E.79106
G1 X113.683 Y143.17 E.00921
M73 P73 R14
G1 X79.343 Y108.83 E.79106
G1 X78.778 Y108.83 E.00921
G1 X113.118 Y143.17 E.79106
G1 X112.553 Y143.17 E.00921
G1 X78.212 Y108.83 E.79106
G1 X77.83 Y108.83 E.00623
M73 P73 R13
G1 X77.83 Y109.013 E.00298
G1 X111.987 Y143.17 E.78685
G1 X111.422 Y143.17 E.00921
G1 X77.83 Y109.578 E.77382
G1 X77.83 Y110.144 E.00921
G1 X110.856 Y143.17 E.7608
G1 X110.291 Y143.17 E.00921
G1 X77.83 Y110.709 E.74778
G1 X77.83 Y111.274 E.00921
G1 X109.726 Y143.17 E.73475
G1 X109.16 Y143.17 E.00921
G1 X77.83 Y111.84 E.72173
G1 X77.83 Y112.405 E.00921
G1 X108.595 Y143.17 E.7087
G1 X108.029 Y143.17 E.00921
G1 X77.83 Y112.971 E.69568
G1 X77.83 Y113.536 E.00921
G1 X107.464 Y143.17 E.68265
G1 X106.899 Y143.17 E.00921
G1 X77.83 Y114.101 E.66963
G1 X77.83 Y114.667 E.00921
G1 X106.333 Y143.17 E.65661
G1 X105.768 Y143.17 E.00921
G1 X77.83 Y115.232 E.64358
G1 X77.83 Y115.798 E.00921
G1 X105.202 Y143.17 E.63056
G1 X104.637 Y143.17 E.00921
G1 X77.83 Y116.363 E.61753
G1 X77.83 Y116.928 E.00921
G1 X104.072 Y143.17 E.60451
G1 X103.506 Y143.17 E.00921
G1 X77.83 Y117.494 E.59148
G1 X77.83 Y118.059 E.00921
G1 X102.941 Y143.17 E.57846
G1 X102.376 Y143.17 E.00921
G1 X77.83 Y118.624 E.56544
G1 X77.83 Y119.19 E.00921
G1 X101.81 Y143.17 E.55241
G1 X101.245 Y143.17 E.00921
G1 X77.83 Y119.755 E.53939
G1 X77.83 Y120.321 E.00921
G1 X100.679 Y143.17 E.52636
G1 X100.114 Y143.17 E.00921
G1 X77.83 Y120.886 E.51334
G1 X77.83 Y121.451 E.00921
G1 X99.549 Y143.17 E.50031
G1 X98.983 Y143.17 E.00921
G1 X77.83 Y122.017 E.48729
G1 X77.83 Y122.582 E.00921
G1 X98.418 Y143.17 E.47427
G1 X97.852 Y143.17 E.00921
G1 X77.83 Y123.148 E.46124
G1 X77.83 Y123.713 E.00921
G1 X97.287 Y143.17 E.44822
G1 X96.722 Y143.17 E.00921
G1 X77.83 Y124.278 E.43519
G1 X77.83 Y124.844 E.00921
G1 X96.156 Y143.17 E.42217
G1 X95.591 Y143.17 E.00921
G1 X77.83 Y125.409 E.40914
G1 X77.83 Y125.974 E.00921
G1 X95.025 Y143.17 E.39612
G1 X94.46 Y143.17 E.00921
G1 X77.83 Y126.54 E.3831
G1 X77.83 Y127.105 E.00921
G1 X93.895 Y143.17 E.37007
G1 X93.329 Y143.17 E.00921
G1 X77.83 Y127.671 E.35705
G1 X77.83 Y128.236 E.00921
G1 X92.764 Y143.17 E.34402
G1 X92.199 Y143.17 E.00921
G1 X77.83 Y128.801 E.331
G1 X77.83 Y129.367 E.00921
G1 X91.633 Y143.17 E.31797
G1 X91.068 Y143.17 E.00921
G1 X77.83 Y129.932 E.30495
G1 X77.83 Y130.498 E.00921
G1 X90.502 Y143.17 E.29193
G1 X89.937 Y143.17 E.00921
G1 X77.83 Y131.063 E.2789
G1 X77.83 Y131.628 E.00921
G1 X89.372 Y143.17 E.26588
G1 X88.806 Y143.17 E.00921
G1 X77.83 Y132.194 E.25285
G1 X77.83 Y132.759 E.00921
G1 X88.241 Y143.17 E.23983
G1 X87.675 Y143.17 E.00921
G1 X77.83 Y133.325 E.2268
G1 X77.83 Y133.89 E.00921
G1 X87.11 Y143.17 E.21378
G1 X86.545 Y143.17 E.00921
G1 X77.83 Y134.455 E.20076
G1 X77.83 Y135.021 E.00921
G1 X85.979 Y143.17 E.18773
G1 X85.414 Y143.17 E.00921
G1 X77.83 Y135.586 E.17471
G1 X77.83 Y136.151 E.00921
G1 X84.849 Y143.17 E.16168
G1 X84.283 Y143.17 E.00921
G1 X77.83 Y136.717 E.14866
G1 X77.83 Y137.282 E.00921
G1 X83.718 Y143.17 E.13563
G1 X83.152 Y143.17 E.00921
G1 X77.83 Y137.848 E.12261
G1 X77.83 Y138.413 E.00921
G1 X82.587 Y143.17 E.10959
G1 X82.022 Y143.17 E.00921
G1 X77.83 Y138.978 E.09656
G1 X77.83 Y139.544 E.00921
G1 X81.456 Y143.17 E.08354
G1 X80.891 Y143.17 E.00921
M73 P74 R13
G1 X77.83 Y140.109 E.07051
G1 X77.83 Y140.675 E.00921
G1 X80.325 Y143.17 E.05749
G1 X79.76 Y143.17 E.00921
G1 X77.65 Y141.061 E.0486
; CHANGE_LAYER
; Z_HEIGHT: 1.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X79.065 Y142.475 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/24
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
M204 S10000
G17
G3 Z1.8 I-1.128 J-.458 P1  F30000
G1 X51.016 Y211.534 Z1.8
G1 Z1.5
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #15
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.9 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.519 Y143.519
G1 Z1.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.481 E.57454
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.459 E.30484
M204 S10000
G1 X178.948 Y143.948 F30000
G1 F6000
M204 S3000
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.052 E.58512
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.888 E.31232
M204 S10000
G1 X179.376 Y144.376 F30000
G1 F6000
M204 S3000
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.624 E.5957
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.316 E.3198
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.543 Y143.35 Z1.9 F30000
G1 Z1.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S3000
G1 X178.17 Y142.722 E.01443
G1 X178.17 Y142.157 E.00918
G1 X177.157 Y143.17 E.02329
G1 X176.593 Y143.17 E.00918
G1 X178.17 Y141.593 E.03627
G1 X178.17 Y141.028 E.00918
G1 X176.028 Y143.17 E.04926
G1 X175.464 Y143.17 E.00918
G1 X178.17 Y140.464 E.06224
G1 X178.17 Y139.9 E.00918
G1 X174.899 Y143.17 E.07522
G1 X174.335 Y143.17 E.00918
G1 X178.17 Y139.335 E.08821
G1 X178.17 Y138.771 E.00918
G1 X173.771 Y143.17 E.10119
G1 X173.206 Y143.17 E.00918
G1 X178.17 Y138.206 E.11417
G1 X178.17 Y137.642 E.00918
G1 X172.642 Y143.17 E.12715
G1 X172.077 Y143.17 E.00918
G1 X178.17 Y137.077 E.14014
G1 X178.17 Y136.513 E.00918
G1 X171.513 Y143.17 E.15312
G1 X170.948 Y143.17 E.00918
G1 X178.17 Y135.948 E.1661
G1 X178.17 Y135.384 E.00918
G1 X170.384 Y143.17 E.17908
G1 X169.819 Y143.17 E.00918
G1 X178.17 Y134.819 E.19207
G1 X178.17 Y134.255 E.00918
G1 X169.255 Y143.17 E.20505
G1 X168.69 Y143.17 E.00918
G1 X178.17 Y133.69 E.21803
G1 X178.17 Y133.126 E.00918
G1 X168.126 Y143.17 E.23101
G1 X167.561 Y143.17 E.00918
G1 X178.17 Y132.561 E.244
G1 X178.17 Y131.997 E.00918
G1 X166.997 Y143.17 E.25698
G1 X166.432 Y143.17 E.00918
G1 X178.17 Y131.432 E.26996
G1 X178.17 Y130.868 E.00918
G1 X165.868 Y143.17 E.28294
G1 X165.303 Y143.17 E.00918
G1 X178.17 Y130.303 E.29593
G1 X178.17 Y129.739 E.00918
G1 X164.739 Y143.17 E.30891
G1 X164.174 Y143.17 E.00918
G1 X178.17 Y129.174 E.32189
G1 X178.17 Y128.61 E.00918
G1 X163.61 Y143.17 E.33488
G1 X163.045 Y143.17 E.00918
G1 X178.17 Y128.045 E.34786
G1 X178.17 Y127.481 E.00918
G1 X162.481 Y143.17 E.36084
G1 X161.916 Y143.17 E.00918
G1 X178.17 Y126.916 E.37382
G1 X178.17 Y126.352 E.00918
G1 X161.352 Y143.17 E.38681
G1 X160.787 Y143.17 E.00918
G1 X178.17 Y125.787 E.39979
G1 X178.17 Y125.223 E.00918
G1 X160.223 Y143.17 E.41277
G1 X159.658 Y143.17 E.00918
G1 X178.17 Y124.658 E.42575
G1 X178.17 Y124.094 E.00918
G1 X159.094 Y143.17 E.43874
G1 X158.529 Y143.17 E.00918
G1 X178.17 Y123.529 E.45172
G1 X178.17 Y122.965 E.00918
G1 X157.965 Y143.17 E.4647
G1 X157.401 Y143.17 E.00918
G1 X178.17 Y122.401 E.47768
G1 X178.17 Y121.836 E.00918
G1 X156.836 Y143.17 E.49067
G1 X156.272 Y143.17 E.00918
G1 X178.17 Y121.272 E.50365
G1 X178.17 Y120.707 E.00918
G1 X155.707 Y143.17 E.51663
G1 X155.143 Y143.17 E.00918
G1 X178.17 Y120.143 E.52961
G1 X178.17 Y119.578 E.00918
G1 X154.578 Y143.17 E.5426
G1 X154.014 Y143.17 E.00918
G1 X178.17 Y119.014 E.55558
G1 X178.17 Y118.449 E.00918
G1 X153.449 Y143.17 E.56856
G1 X152.885 Y143.17 E.00918
M73 P74 R12
G1 X178.17 Y117.885 E.58155
M73 P75 R12
G1 X178.17 Y117.32 E.00918
G1 X152.32 Y143.17 E.59453
G1 X151.756 Y143.17 E.00918
G1 X178.17 Y116.756 E.60751
G1 X178.17 Y116.191 E.00918
G1 X151.191 Y143.17 E.62049
G1 X150.627 Y143.17 E.00918
G1 X178.17 Y115.627 E.63348
G1 X178.17 Y115.062 E.00918
G1 X150.062 Y143.17 E.64646
G1 X149.498 Y143.17 E.00918
G1 X178.17 Y114.498 E.65944
G1 X178.17 Y113.933 E.00918
G1 X148.933 Y143.17 E.67242
G1 X148.369 Y143.17 E.00918
G1 X178.17 Y113.369 E.68541
G1 X178.17 Y112.804 E.00918
G1 X147.804 Y143.17 E.69839
G1 X147.24 Y143.17 E.00918
G1 X178.17 Y112.24 E.71137
G1 X178.17 Y111.675 E.00918
G1 X146.675 Y143.17 E.72435
G1 X146.111 Y143.17 E.00918
G1 X178.17 Y111.111 E.73734
G1 X178.17 Y110.546 E.00918
G1 X145.546 Y143.17 E.75032
G1 X144.982 Y143.17 E.00918
G1 X178.17 Y109.982 E.7633
G1 X178.17 Y109.417 E.00918
G1 X144.417 Y143.17 E.77628
G1 X143.853 Y143.17 E.00918
G1 X178.17 Y108.853 E.78927
G1 X178.17 Y108.83 E.00038
G1 X177.629 Y108.83 E.0088
G1 X143.288 Y143.17 E.7898
G1 X142.724 Y143.17 E.00918
G1 X177.064 Y108.83 E.7898
G1 X176.5 Y108.83 E.00918
G1 X142.159 Y143.17 E.7898
G1 X141.595 Y143.17 E.00918
G1 X175.935 Y108.83 E.7898
G1 X175.371 Y108.83 E.00918
G1 X141.03 Y143.17 E.7898
G1 X140.466 Y143.17 E.00918
G1 X174.806 Y108.83 E.7898
G1 X174.242 Y108.83 E.00918
G1 X139.902 Y143.17 E.7898
G1 X139.337 Y143.17 E.00918
G1 X173.677 Y108.83 E.7898
G1 X173.113 Y108.83 E.00918
G1 X138.773 Y143.17 E.7898
G1 X138.208 Y143.17 E.00918
G1 X172.548 Y108.83 E.7898
G1 X171.984 Y108.83 E.00918
G1 X137.644 Y143.17 E.7898
G1 X137.079 Y143.17 E.00918
G1 X171.419 Y108.83 E.7898
G1 X170.855 Y108.83 E.00918
G1 X136.515 Y143.17 E.7898
G1 X135.95 Y143.17 E.00918
G1 X170.291 Y108.83 E.7898
G1 X169.726 Y108.83 E.00918
G1 X135.386 Y143.17 E.7898
G1 X134.821 Y143.17 E.00918
G1 X169.162 Y108.83 E.7898
G1 X168.597 Y108.83 E.00918
G1 X134.257 Y143.17 E.7898
G1 X133.692 Y143.17 E.00918
G1 X168.033 Y108.83 E.7898
G1 X167.468 Y108.83 E.00918
G1 X133.128 Y143.17 E.7898
G1 X132.563 Y143.17 E.00918
G1 X166.904 Y108.83 E.7898
G1 X166.339 Y108.83 E.00918
G1 X131.999 Y143.17 E.7898
G1 X131.434 Y143.17 E.00918
G1 X165.775 Y108.83 E.7898
G1 X165.21 Y108.83 E.00918
G1 X130.87 Y143.17 E.7898
G1 X130.305 Y143.17 E.00918
G1 X164.646 Y108.83 E.7898
G1 X164.081 Y108.83 E.00918
G1 X129.741 Y143.17 E.7898
G1 X129.176 Y143.17 E.00918
G1 X163.517 Y108.83 E.7898
G1 X162.952 Y108.83 E.00918
G1 X128.612 Y143.17 E.7898
G1 X128.047 Y143.17 E.00918
G1 X162.388 Y108.83 E.7898
G1 X161.823 Y108.83 E.00918
G1 X127.483 Y143.17 E.7898
G1 X126.918 Y143.17 E.00918
G1 X161.259 Y108.83 E.7898
G1 X160.694 Y108.83 E.00918
G1 X126.354 Y143.17 E.7898
G1 X125.789 Y143.17 E.00918
G1 X160.13 Y108.83 E.7898
G1 X159.565 Y108.83 E.00918
G1 X125.225 Y143.17 E.7898
G1 X124.66 Y143.17 E.00918
G1 X159.001 Y108.83 E.7898
G1 X158.436 Y108.83 E.00918
G1 X124.096 Y143.17 E.7898
G1 X123.532 Y143.17 E.00918
G1 X157.872 Y108.83 E.7898
G1 X157.307 Y108.83 E.00918
G1 X122.967 Y143.17 E.7898
G1 X122.403 Y143.17 E.00918
G1 X156.743 Y108.83 E.7898
G1 X156.178 Y108.83 E.00918
G1 X121.838 Y143.17 E.7898
G1 X121.274 Y143.17 E.00918
G1 X155.614 Y108.83 E.7898
G1 X155.049 Y108.83 E.00918
G1 X120.709 Y143.17 E.7898
G1 X120.145 Y143.17 E.00918
G1 X154.485 Y108.83 E.7898
G1 X153.92 Y108.83 E.00918
G1 X119.58 Y143.17 E.7898
G1 X119.016 Y143.17 E.00918
G1 X153.356 Y108.83 E.7898
G1 X152.792 Y108.83 E.00918
G1 X118.451 Y143.17 E.7898
G1 X117.887 Y143.17 E.00918
G1 X152.227 Y108.83 E.7898
G1 X151.663 Y108.83 E.00918
G1 X117.322 Y143.17 E.7898
G1 X116.758 Y143.17 E.00918
G1 X151.098 Y108.83 E.7898
G1 X150.534 Y108.83 E.00918
G1 X116.193 Y143.17 E.7898
G1 X115.629 Y143.17 E.00918
G1 X149.969 Y108.83 E.7898
G1 X149.405 Y108.83 E.00918
G1 X115.064 Y143.17 E.7898
G1 X114.5 Y143.17 E.00918
G1 X148.84 Y108.83 E.7898
G1 X148.276 Y108.83 E.00918
G1 X113.935 Y143.17 E.7898
G1 X113.371 Y143.17 E.00918
G1 X147.711 Y108.83 E.7898
G1 X147.147 Y108.83 E.00918
G1 X112.806 Y143.17 E.7898
G1 X112.242 Y143.17 E.00918
G1 X146.582 Y108.83 E.7898
G1 X146.018 Y108.83 E.00918
G1 X111.677 Y143.17 E.7898
G1 X111.113 Y143.17 E.00918
G1 X145.453 Y108.83 E.7898
G1 X144.889 Y108.83 E.00918
G1 X110.548 Y143.17 E.7898
G1 X109.984 Y143.17 E.00918
G1 X144.324 Y108.83 E.7898
G1 X143.76 Y108.83 E.00918
G1 X109.419 Y143.17 E.7898
G1 X108.855 Y143.17 E.00918
G1 X143.195 Y108.83 E.7898
G1 X142.631 Y108.83 E.00918
G1 X108.29 Y143.17 E.7898
G1 X107.726 Y143.17 E.00918
G1 X142.066 Y108.83 E.7898
G1 X141.502 Y108.83 E.00918
G1 X107.161 Y143.17 E.7898
G1 X106.597 Y143.17 E.00918
G1 X140.937 Y108.83 E.7898
G1 X140.373 Y108.83 E.00918
G1 X106.033 Y143.17 E.7898
G1 X105.468 Y143.17 E.00918
G1 X139.808 Y108.83 E.7898
G1 X139.244 Y108.83 E.00918
G1 X104.904 Y143.17 E.7898
G1 X104.339 Y143.17 E.00918
M73 P76 R12
G1 X138.679 Y108.83 E.7898
G1 X138.115 Y108.83 E.00918
G1 X103.775 Y143.17 E.7898
G1 X103.21 Y143.17 E.00918
G1 X137.55 Y108.83 E.7898
G1 X136.986 Y108.83 E.00918
G1 X102.646 Y143.17 E.7898
G1 X102.081 Y143.17 E.00918
G1 X136.421 Y108.83 E.7898
G1 X135.857 Y108.83 E.00918
G1 X101.517 Y143.17 E.7898
G1 X100.952 Y143.17 E.00918
G1 X135.293 Y108.83 E.7898
G1 X134.728 Y108.83 E.00918
G1 X100.388 Y143.17 E.7898
G1 X99.823 Y143.17 E.00918
G1 X134.164 Y108.83 E.7898
G1 X133.599 Y108.83 E.00918
G1 X99.259 Y143.17 E.7898
G1 X98.694 Y143.17 E.00918
G1 X133.035 Y108.83 E.7898
G1 X132.47 Y108.83 E.00918
G1 X98.13 Y143.17 E.7898
G1 X97.565 Y143.17 E.00918
G1 X131.906 Y108.83 E.7898
G1 X131.341 Y108.83 E.00918
G1 X97.001 Y143.17 E.7898
G1 X96.436 Y143.17 E.00918
G1 X130.777 Y108.83 E.7898
G1 X130.212 Y108.83 E.00918
G1 X95.872 Y143.17 E.7898
G1 X95.307 Y143.17 E.00918
G1 X129.648 Y108.83 E.7898
G1 X129.083 Y108.83 E.00918
G1 X94.743 Y143.17 E.7898
G1 X94.178 Y143.17 E.00918
G1 X128.519 Y108.83 E.7898
G1 X127.954 Y108.83 E.00918
G1 X93.614 Y143.17 E.7898
G1 X93.049 Y143.17 E.00918
G1 X127.39 Y108.83 E.7898
G1 X126.825 Y108.83 E.00918
G1 X92.485 Y143.17 E.7898
G1 X91.92 Y143.17 E.00918
G1 X126.261 Y108.83 E.7898
G1 X125.696 Y108.83 E.00918
G1 X91.356 Y143.17 E.7898
G1 X90.791 Y143.17 E.00918
G1 X125.132 Y108.83 E.7898
G1 X124.567 Y108.83 E.00918
G1 X90.227 Y143.17 E.7898
G1 X89.662 Y143.17 E.00918
G1 X124.003 Y108.83 E.7898
G1 X123.438 Y108.83 E.00918
G1 X89.098 Y143.17 E.7898
G1 X88.534 Y143.17 E.00918
G1 X122.874 Y108.83 E.7898
G1 X122.309 Y108.83 E.00918
G1 X87.969 Y143.17 E.7898
G1 X87.405 Y143.17 E.00918
G1 X121.745 Y108.83 E.7898
G1 X121.18 Y108.83 E.00918
G1 X86.84 Y143.17 E.7898
G1 X86.276 Y143.17 E.00918
G1 X120.616 Y108.83 E.7898
G1 X120.051 Y108.83 E.00918
G1 X85.711 Y143.17 E.7898
G1 X85.147 Y143.17 E.00918
G1 X119.487 Y108.83 E.7898
G1 X118.923 Y108.83 E.00918
G1 X84.582 Y143.17 E.7898
G1 X84.018 Y143.17 E.00918
G1 X118.358 Y108.83 E.7898
G1 X117.794 Y108.83 E.00918
G1 X83.453 Y143.17 E.7898
G1 X82.889 Y143.17 E.00918
G1 X117.229 Y108.83 E.7898
G1 X116.665 Y108.83 E.00918
G1 X82.324 Y143.17 E.7898
G1 X81.76 Y143.17 E.00918
G1 X116.1 Y108.83 E.7898
G1 X115.536 Y108.83 E.00918
G1 X81.195 Y143.17 E.7898
G1 X80.631 Y143.17 E.00918
G1 X114.971 Y108.83 E.7898
G1 X114.407 Y108.83 E.00918
G1 X80.066 Y143.17 E.7898
G1 X79.758 Y143.17 E.00501
G1 X79.63 Y143.042 E.00295
G1 X113.842 Y108.83 E.78685
G1 X113.278 Y108.83 E.00918
G1 X79.348 Y142.76 E.78036
G1 X79.065 Y142.478 E.00649
G1 X112.713 Y108.83 E.77387
G1 X112.149 Y108.83 E.00918
G1 X78.783 Y142.195 E.76738
G1 X78.501 Y141.913 E.00649
G1 X111.584 Y108.83 E.76089
G1 X111.02 Y108.83 E.00918
G1 X78.219 Y141.631 E.7544
G1 X77.936 Y141.349 E.00649
G1 X110.455 Y108.83 E.7479
G1 X109.891 Y108.83 E.00918
G1 X77.83 Y140.891 E.73737
G1 X77.83 Y140.326 E.00918
G1 X109.326 Y108.83 E.72439
G1 X108.762 Y108.83 E.00918
G1 X77.83 Y139.762 E.71141
M73 P76 R11
G1 X77.83 Y139.197 E.00918
G1 X108.197 Y108.83 E.69843
G1 X107.633 Y108.83 E.00918
G1 X77.83 Y138.633 E.68544
G1 X77.83 Y138.068 E.00918
G1 X107.068 Y108.83 E.67246
G1 X106.504 Y108.83 E.00918
G1 X77.83 Y137.504 E.65948
G1 X77.83 Y136.939 E.00918
G1 X105.939 Y108.83 E.6465
M73 P77 R11
G1 X105.375 Y108.83 E.00918
G1 X77.83 Y136.375 E.63351
G1 X77.83 Y135.81 E.00918
G1 X104.81 Y108.83 E.62053
G1 X104.246 Y108.83 E.00918
G1 X77.83 Y135.246 E.60755
G1 X77.83 Y134.681 E.00918
G1 X103.681 Y108.83 E.59457
G1 X103.117 Y108.83 E.00918
G1 X77.83 Y134.117 E.58158
G1 X77.83 Y133.552 E.00918
G1 X102.552 Y108.83 E.5686
G1 X101.988 Y108.83 E.00918
G1 X77.83 Y132.988 E.55562
G1 X77.83 Y132.424 E.00918
G1 X101.424 Y108.83 E.54263
G1 X100.859 Y108.83 E.00918
G1 X77.83 Y131.859 E.52965
G1 X77.83 Y131.295 E.00918
G1 X100.295 Y108.83 E.51667
G1 X99.73 Y108.83 E.00918
G1 X77.83 Y130.73 E.50369
G1 X77.83 Y130.166 E.00918
G1 X99.166 Y108.83 E.4907
G1 X98.601 Y108.83 E.00918
G1 X77.83 Y129.601 E.47772
G1 X77.83 Y129.037 E.00918
G1 X98.037 Y108.83 E.46474
G1 X97.472 Y108.83 E.00918
G1 X77.83 Y128.472 E.45176
G1 X77.83 Y127.908 E.00918
G1 X96.908 Y108.83 E.43877
G1 X96.343 Y108.83 E.00918
G1 X77.83 Y127.343 E.42579
G1 X77.83 Y126.779 E.00918
G1 X95.779 Y108.83 E.41281
G1 X95.214 Y108.83 E.00918
G1 X77.83 Y126.214 E.39983
G1 X77.83 Y125.65 E.00918
G1 X94.65 Y108.83 E.38684
G1 X94.085 Y108.83 E.00918
G1 X77.83 Y125.085 E.37386
G1 X77.83 Y124.521 E.00918
G1 X93.521 Y108.83 E.36088
G1 X92.956 Y108.83 E.00918
G1 X77.83 Y123.956 E.3479
G1 X77.83 Y123.392 E.00918
G1 X92.392 Y108.83 E.33491
G1 X91.827 Y108.83 E.00918
G1 X77.83 Y122.827 E.32193
G1 X77.83 Y122.263 E.00918
G1 X91.263 Y108.83 E.30895
G1 X90.698 Y108.83 E.00918
G1 X77.83 Y121.698 E.29596
G1 X77.83 Y121.134 E.00918
G1 X90.134 Y108.83 E.28298
G1 X89.569 Y108.83 E.00918
G1 X77.83 Y120.569 E.27
G1 X77.83 Y120.005 E.00918
G1 X89.005 Y108.83 E.25702
G1 X88.44 Y108.83 E.00918
G1 X77.83 Y119.44 E.24403
G1 X77.83 Y118.876 E.00918
G1 X87.876 Y108.83 E.23105
G1 X87.311 Y108.83 E.00918
G1 X77.83 Y118.311 E.21807
G1 X77.83 Y117.747 E.00918
G1 X86.747 Y108.83 E.20509
G1 X86.182 Y108.83 E.00918
G1 X77.83 Y117.182 E.1921
G1 X77.83 Y116.618 E.00918
G1 X85.618 Y108.83 E.17912
G1 X85.054 Y108.83 E.00918
G1 X77.83 Y116.054 E.16614
G1 X77.83 Y115.489 E.00918
G1 X84.489 Y108.83 E.15316
G1 X83.925 Y108.83 E.00918
G1 X77.83 Y114.925 E.14017
G1 X77.83 Y114.36 E.00918
G1 X83.36 Y108.83 E.12719
G1 X82.796 Y108.83 E.00918
G1 X77.83 Y113.796 E.11421
G1 X77.83 Y113.231 E.00918
G1 X82.231 Y108.83 E.10123
G1 X81.667 Y108.83 E.00918
G1 X77.83 Y112.667 E.08824
G1 X77.83 Y112.102 E.00918
G1 X81.102 Y108.83 E.07526
G1 X80.538 Y108.83 E.00918
G1 X77.83 Y111.538 E.06228
G1 X77.83 Y110.973 E.00918
G1 X79.973 Y108.83 E.04929
G1 X79.409 Y108.83 E.00918
G1 X77.83 Y110.409 E.03631
G1 X77.83 Y109.844 E.00918
G1 X78.844 Y108.83 E.02333
G1 X78.28 Y108.83 E.00918
G1 X77.65 Y109.459 E.01447
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X78.28 Y108.83 E-.33815
G1 X78.844 Y108.83 E-.21451
G1 X78.458 Y109.216 E-.20735
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/24
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
M204 S10000
G17
G3 Z1.9 I-1.175 J-.315 P1  F30000
G1 X51.016 Y211.534 Z1.9
G1 Z1.6
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S3000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #16
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S3000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S3000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S3000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S3000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
M73 P78 R11
G1  X51.516 Y212.534   E0.0417
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G3  X22.340 Y210.825   I15.914 J-18.906 E0.0894
G3  X23.138 Y207.675   I2.197 J-1.120 E0.0706
G2  X24.016 Y204.972   I-3.790 J-2.726 E0.0575
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
; WIPE_TOWER_END

; WIPE_START
G1 F6000
M204 S3000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X166.904 Y132.479
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.55883
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S3000
G1 X166.447 Y132.86 E.01302
; LINE_WIDTH: 0.5179
G3 X165.493 Y133.207 I-1.601 J-2.923 E.02061
; LINE_WIDTH: 0.55023
G1 X165.173 Y133.241 E.00694
; LINE_WIDTH: 0.58256
G1 X164.853 Y133.276 E.00737
G1 X165.152 Y133.126 E.00765
; LINE_WIDTH: 0.55023
G1 X165.451 Y132.977 E.00721
; LINE_WIDTH: 0.5179
G1 X166.005 Y132.599 E.01356
; LINE_WIDTH: 0.55883
G1 X166.496 Y132.132 E.01485
; LINE_WIDTH: 0.58976
G1 X166.885 Y131.568 E.01585
; LINE_WIDTH: 0.60447
G1 X167.158 Y130.887 E.01742
G1 X167.275 Y130.3 E.01422
; LINE_WIDTH: 0.59245
G1 X167.301 Y129.656 E.01501
; LINE_WIDTH: 0.57332
G1 X167.244 Y129.061 E.01343
; LINE_WIDTH: 0.55012
G1 X167.127 Y128.568 E.01091
; LINE_WIDTH: 0.51535
G1 X166.939 Y128.105 E.01007
; LINE_WIDTH: 0.46617
G1 X166.784 Y127.856 E.0053
; LINE_WIDTH: 0.42555
G1 X166.63 Y127.608 E.00481
; LINE_WIDTH: 0.38493
G1 X166.273 Y127.164 E.00844
; LINE_WIDTH: 0.35746
G1 X165.813 Y126.744 E.00853
G1 X166.243 Y126.92 E.00636
; LINE_WIDTH: 0.36115
G1 X166.778 Y127.249 E.0087
; LINE_WIDTH: 0.399725
G1 X166.969 Y127.449 E.00426
; LINE_WIDTH: 0.4383
G1 X167.16 Y127.649 E.0047
; LINE_WIDTH: 0.468815
G1 X167.316 Y127.889 E.00521
; LINE_WIDTH: 0.49933
G1 X167.471 Y128.129 E.00557
; LINE_WIDTH: 0.54188
G1 X167.691 Y128.658 E.01215
; LINE_WIDTH: 0.57027
G1 X167.826 Y129.264 E.01388
; LINE_WIDTH: 0.59125
G1 X167.868 Y129.983 E.01672
; LINE_WIDTH: 0.59772
G1 X167.826 Y130.54 E.01313
; LINE_WIDTH: 0.60447
G3 X167.548 Y131.518 I-3.547 J-.483 E.02422
; LINE_WIDTH: 0.60275
G1 X167.222 Y132.091 E.01561
; LINE_WIDTH: 0.58051
G1 X166.942 Y132.432 E.01007
; WIPE_START
G1 X166.447 Y132.86 E-.24844
G1 X165.99 Y133.068 E-.19082
G1 X165.493 Y133.207 E-.19609
G1 X165.173 Y133.241 E-.12243
G1 X165.167 Y133.242 E-.00222
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.965 Y125.934 Z2 F30000
G1 X162.943 Y125.861 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.54105
G1 F6000
M204 S3000
G2 X161.39 Y125.824 I-1.882 J45.89 E.03288
G2 X162.269 Y125.389 I-3.067 J-7.303 E.02077
G1 X162.709 Y125.05 E.01176
G1 X162.65 Y125.299 E.00542
G2 X162.841 Y125.775 I1.104 J-.166 E.01096
G1 X162.897 Y125.822 E.00155
; WIPE_START
G1 X161.39 Y125.824 E-.57257
G1 X161.832 Y125.605 E-.18743
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.343 Y123.354 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5061
G1 F6000
M204 S3000
G1 X163.954 Y123.635 E.00948
G2 X164.576 Y122.753 I-20.536 J-15.157 E.02132
; LINE_WIDTH: 0.51647
G1 X164.904 Y122.286 E.01151
; LINE_WIDTH: 0.56633
G1 X165.233 Y121.84 E.01231
; LINE_WIDTH: 0.589
G1 X165.571 Y121.357 E.01362
; LINE_WIDTH: 0.59922
G2 X166.589 Y119.845 I-84.813 J-58.168 E.04291
; LINE_WIDTH: 0.594
G1 X167.341 Y118.705 E.03186
; LINE_WIDTH: 0.57247
G1 X167.422 Y118.583 E.0033
G1 X168.067 Y118.583 E.01447
G1 X167.803 Y119.004 E.01117
; LINE_WIDTH: 0.594
G1 X167.066 Y120.161 E.032
; LINE_WIDTH: 0.59922
G3 X166.029 Y121.691 I-28.852 J-18.429 E.0435
; LINE_WIDTH: 0.589
G1 X165.655 Y122.181 E.01427
; LINE_WIDTH: 0.56633
G1 X165.466 Y122.395 E.00634
; LINE_WIDTH: 0.54068
G1 X165.276 Y122.609 E.00604
; LINE_WIDTH: 0.51503
G1 X164.836 Y122.999 E.01182
; LINE_WIDTH: 0.5061
G1 X164.392 Y123.319 E.01082
; WIPE_START
G1 X163.954 Y123.635 E-.20528
G1 X164.576 Y122.753 E-.4102
G1 X164.795 Y122.442 E-.14452
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.762 Y128.922 Z2 F30000
G1 X157.927 Y133.477 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.493988
G1 F6000
M204 S3000
G1 X157.767 Y133.457 E.0031
; LINE_WIDTH: 0.535595
G1 X157.607 Y133.436 E.00338
; LINE_WIDTH: 0.577203
G1 X157.447 Y133.415 E.00365
; LINE_WIDTH: 0.61881
G1 X157.287 Y133.394 E.00392
G1 X156.348 Y133.394 E.02286
G2 X156.326 Y132.75 I-5.109 J-.149 E.01569
; LINE_WIDTH: 0.575205
G1 X156.304 Y132.405 E.00781
; LINE_WIDTH: 0.5316
G1 X156.304 Y128.405 E.08314
G2 X156.284 Y126.444 I-23.706 J-.734 E.04077
; LINE_WIDTH: 0.490795
G3 X156.284 Y125.458 I5.954 J-.493 E.01889
; LINE_WIDTH: 0.5316
G1 X156.304 Y124.964 E.01026
G1 X156.304 Y118.562 E.13307
G1 X156.814 Y118.562 E.0106
G1 X156.814 Y124.964 E.13307
; LINE_WIDTH: 0.54197
G1 X156.826 Y125.157 E.0041
G1 X156.964 Y125.403 E.00597
; LINE_WIDTH: 0.49598
G1 X157.102 Y125.648 E.00544
; LINE_WIDTH: 0.44999
G1 X157.374 Y125.882 E.00626
G1 X157.585 Y125.951 E.00388
G1 X157.374 Y126.02 E.00388
G1 X157.102 Y126.253 E.00626
; LINE_WIDTH: 0.490795
G1 X156.958 Y126.595 E.00709
; LINE_WIDTH: 0.5316
G1 X156.814 Y126.937 E.00771
G1 X156.814 Y132.405 E.11364
; LINE_WIDTH: 0.575205
G1 X156.862 Y132.679 E.00628
; LINE_WIDTH: 0.61881
G1 X156.909 Y132.954 E.00678
G1 X157.294 Y133.372 E.01382
G1 X157.452 Y133.398 E.0039
; LINE_WIDTH: 0.577203
G1 X157.61 Y133.425 E.00363
; LINE_WIDTH: 0.535595
G1 X157.768 Y133.451 E.00336
; LINE_WIDTH: 0.493988
G1 X157.867 Y133.468 E.00193
; WIPE_START
G1 X157.767 Y133.457 E-.03849
G1 X157.607 Y133.436 E-.06127
G1 X157.447 Y133.415 E-.06127
G1 X157.287 Y133.394 E-.06126
G1 X156.348 Y133.394 E-.35688
G1 X156.332 Y132.919 E-.18084
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.961 Y132.708 Z2 F30000
G1 X167.446 Y132.612 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X167.107 Y132.948 E.00833
G3 X166.204 Y133.488 I-2.063 J-2.428 E.01846
G1 X165.599 Y133.658 E.01097
G3 X162.387 Y133.907 I-2.938 J-17.065 E.05633
G1 X155.835 Y133.907 E.1144
G1 X155.835 Y118.093 E.27612
G1 X157.284 Y118.093 E.0253
G1 X157.284 Y124.964 E.11998
G1 X157.293 Y125.075 E.00195
G1 X157.432 Y125.375 E.00576
; LINE_WIDTH: 0.494413
G1 X157.576 Y125.474 E.00337
; LINE_WIDTH: 0.538837
G1 X157.72 Y125.572 E.00369
; LINE_WIDTH: 0.58326
G1 X157.865 Y125.671 E.004
G1 X157.927 Y125.672 E.00143
; LINE_WIDTH: 0.58183
G1 X159.428 Y125.67 E.03426
; LINE_WIDTH: 0.58239
G1 X159.459 Y125.669 E.00072
; LINE_WIDTH: 0.59967
G1 X160.085 Y125.646 E.01476
G1 X160.243 Y125.6 E.00387
; LINE_WIDTH: 0.549777
G1 X160.401 Y125.554 E.00354
; LINE_WIDTH: 0.499883
G1 X160.559 Y125.509 E.0032
; LINE_WIDTH: 0.44999
G1 X160.87 Y125.462 E.00549
G1 X161.475 Y125.264 E.01111
G1 X162.179 Y124.881 E.014
; LINE_WIDTH: 0.49131
G1 X162.531 Y124.599 E.00863
; LINE_WIDTH: 0.53263
G1 X162.882 Y124.317 E.00939
G1 X163.049 Y124.087 E.00591
; LINE_WIDTH: 0.49131
G1 X163.215 Y123.858 E.00543
; LINE_WIDTH: 0.44999
G2 X165.63 Y120.374 I-54.152 J-40.122 E.07402
G1 X167.161 Y118.093 E.04797
G1 X168.951 Y118.093 E.03126
G1 X167.89 Y119.788 E.03492
G3 X166.433 Y121.984 I-32.429 J-19.941 E.04602
G3 X165.117 Y123.359 I-6.165 J-4.58 E.03333
G1 X163.716 Y124.369 E.03014
; LINE_WIDTH: 0.497885
G1 X163.534 Y124.471 E.00406
; LINE_WIDTH: 0.54578
G2 X163.208 Y124.72 I.257 J.674 E.00889
; LINE_WIDTH: 0.53575
G1 X163.163 Y124.974 E.00541
; LINE_WIDTH: 0.49287
G1 X163.119 Y125.229 E.00496
; LINE_WIDTH: 0.44999
G1 X163.229 Y125.503 E.00515
; LINE_WIDTH: 0.49955
G1 X163.409 Y125.654 E.00459
; LINE_WIDTH: 0.54911
G1 X163.59 Y125.806 E.00507
G1 X163.809 Y125.85 E.0048
; LINE_WIDTH: 0.53118
G1 X164.602 Y126.029 E.01689
; LINE_WIDTH: 0.50163
G1 X165.431 Y126.228 E.01667
; LINE_WIDTH: 0.49267
G1 X165.844 Y126.348 E.00826
; LINE_WIDTH: 0.44999
G1 X166.321 Y126.523 E.00887
G1 X166.959 Y126.896 E.0129
G1 X167.462 Y127.346 E.01178
G1 X167.852 Y127.874 E.01147
G1 X168.134 Y128.473 E.01156
G1 X168.308 Y129.161 E.01239
G1 X168.369 Y129.96 E.01398
G3 X167.78 Y132.153 I-4.197 J.049 E.04015
G3 X167.486 Y132.567 I-2.736 J-1.633 E.00889
M204 S10000
G1 X167.751 Y132.925 F30000
G1 F6000
M204 S3000
G1 X167.339 Y133.328 E.01006
G1 X166.875 Y133.648 E.00985
G1 X166.353 Y133.891 E.01005
G1 X165.691 Y134.078 E.01201
G3 X162.392 Y134.336 I-3.03 J-17.506 E.05787
G1 X155.406 Y134.336 E.12197
G1 X155.406 Y117.664 E.29108
G1 X157.712 Y117.664 E.04026
G1 X157.712 Y124.964 E.12746
G1 X157.762 Y125.101 E.00254
G1 X157.927 Y125.179 E.00318
G2 X160.002 Y125.149 I.699 J-23.46 E.03625
G1 X160.503 Y125.084 E.00882
G1 X160.758 Y125.048 E.0045
G1 X161.279 Y124.883 E.00954
G1 X161.899 Y124.557 E.01222
G1 X162.524 Y124.013 E.01447
G1 X162.873 Y123.6 E.00944
G2 X165.278 Y120.131 I-53.894 J-39.927 E.07371
G1 X166.933 Y117.664 E.05187
G1 X169.725 Y117.664 E.04876
G1 X168.664 Y119.359 E.03492
G3 X166.776 Y122.24 I-38.908 J-23.436 E.06015
G3 X165.38 Y123.698 I-6.524 J-4.852 E.03533
G2 X163.584 Y125.004 I81.576 J114.076 E.03878
G1 X163.552 Y125.203 E.00352
G1 X163.704 Y125.341 E.00358
G1 X165.638 Y125.815 E.03476
G1 X166.504 Y126.134 E.01613
G1 X167.212 Y126.548 E.01432
G1 X167.78 Y127.056 E.0133
G1 X168.222 Y127.653 E.01298
G1 X168.539 Y128.328 E.01302
G1 X168.733 Y129.091 E.01375
G1 X168.799 Y129.957 E.01515
G3 X168.414 Y131.878 I-5.26 J-.055 E.03442
G3 X167.79 Y132.879 I-3.862 J-1.71 E.02066
; WIPE_START
G1 X167.339 Y133.328 E-.24166
G1 X166.875 Y133.648 E-.21428
G1 X166.353 Y133.891 E-.21863
G1 X166.137 Y133.952 E-.08543
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.102 Y131.853 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X165.687 Y132.264 E.01018
G3 X164.107 Y132.959 I-2.154 J-2.752 E.03045
G1 X163.345 Y133.022 E.01335
G3 X160.212 Y133.046 I-2.231 J-87.891 E.05471
G1 X157.927 Y133.048 E.03991
G1 X157.575 Y132.943 E.00641
G1 X157.361 Y132.71 E.00552
G1 X157.284 Y132.405 E.0055
G1 X157.284 Y126.937 E.09546
G1 X157.432 Y126.527 E.00762
; LINE_WIDTH: 0.494413
G1 X157.576 Y126.428 E.00337
; LINE_WIDTH: 0.538837
G1 X157.72 Y126.329 E.00369
; LINE_WIDTH: 0.58326
G1 X157.865 Y126.231 E.004
G1 X157.928 Y126.23 E.00146
; LINE_WIDTH: 0.58183
G1 X159.428 Y126.23 E.03424
; LINE_WIDTH: 0.5959
G1 X160.039 Y126.224 E.01429
; LINE_WIDTH: 0.60546
G3 X160.311 Y126.239 I.103 J.615 E.00653
; LINE_WIDTH: 0.566593
G1 X160.41 Y126.258 E.00226
; LINE_WIDTH: 0.527725
G1 X160.51 Y126.278 E.0021
; LINE_WIDTH: 0.488858
G1 X160.61 Y126.297 E.00194
; LINE_WIDTH: 0.44999
G3 X162.36 Y126.315 I.51 J35.314 E.03056
; LINE_WIDTH: 0.49955
G1 X162.935 Y126.32 E.01119
; LINE_WIDTH: 0.54911
G1 X163.509 Y126.325 E.01236
G1 X164.332 Y126.456 E.01791
; LINE_WIDTH: 0.53648
G1 X165.081 Y126.693 E.01649
G1 X165.302 Y126.848 E.00566
; LINE_WIDTH: 0.493235
G1 X165.523 Y127.003 E.00518
; LINE_WIDTH: 0.44999
G3 X166.528 Y128.252 I-2.027 J2.659 E.02827
G3 X166.652 Y130.831 I-3.799 J1.476 E.04587
G1 X166.428 Y131.367 E.01015
G1 X166.135 Y131.804 E.00918
M204 S10000
G1 X165.751 Y131.607 F30000
G1 F6000
M204 S3000
G3 X163.955 Y132.552 I-2.216 J-2.031 E.03615
G1 X163.31 Y132.595 E.01128
G3 X160.212 Y132.617 I-2.176 J-86.824 E.0541
G1 X157.927 Y132.619 E.0399
G1 X157.809 Y132.584 E.00214
G1 X157.716 Y132.442 E.00297
G1 X157.712 Y132.405 E.00065
G1 X157.712 Y126.937 E.09546
G1 X157.816 Y126.754 E.00368
G1 X157.928 Y126.723 E.00203
G1 X161.7 Y126.727 E.06585
G3 X164.267 Y126.905 I.087 J17.326 E.04497
G1 X164.921 Y127.137 E.01212
G3 X166.124 Y128.397 I-1.163 J2.316 E.03103
G1 X166.297 Y128.944 E.01002
G1 X166.384 Y129.71 E.01346
G3 X166.036 Y131.195 I-3.384 J-.009 E.02686
G1 X165.785 Y131.557 E.0077
; WIPE_START
G1 X165.365 Y131.975 E-.22501
G1 X164.939 Y132.243 E-.19147
G1 X164.471 Y132.432 E-.1916
G1 X164.082 Y132.522 E-.15193
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.884 Y125.883 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.42196
G1 F6000
M204 S3000
G1 X160.61 Y125.901 E.00448
; WIPE_START
G1 X160.884 Y125.883 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.494 Y132.608 Z2 F30000
G1 X164.853 Y133.276 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.58256
G1 F6000
M204 S3000
G1 X164.532 Y133.336 E.00746
; LINE_WIDTH: 0.53609
G1 X164.211 Y133.395 E.00684
; LINE_WIDTH: 0.48962
G1 X163.66 Y133.44 E.01055
; LINE_WIDTH: 0.4695
G1 X163.053 Y133.464 E.01109
; LINE_WIDTH: 0.46452
G1 X162.383 Y133.474 E.01211
; LINE_WIDTH: 0.45924
G1 X162.213 Y133.476 E.00303
; LINE_WIDTH: 0.45624
G1 X160.213 Y133.476 E.03543
; LINE_WIDTH: 0.45444
G1 X158.213 Y133.477 E.03528
; LINE_WIDTH: 0.45265
G1 X157.928 Y133.477 E.00501
; LINE_WIDTH: 0.4524
G1 X157.927 Y133.477 E.00002
; WIPE_START
G1 X157.928 Y133.477 E-.00037
G1 X158.213 Y133.477 E-.10834
G1 X159.927 Y133.477 E-.65129
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.294 Y133.448 Z2 F30000
G1 X149.705 Y133.438 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5316
G1 F6000
M204 S3000
G1 X149.195 Y133.438 E.0106
G1 X149.195 Y118.562 E.30919
G1 X149.705 Y118.562 E.0106
G1 X149.705 Y133.378 E.30795
M204 S10000
G1 X150.175 Y133.907 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X148.726 Y133.907 E.0253
G1 X148.726 Y118.093 E.27612
G1 X150.175 Y118.093 E.0253
G1 X150.175 Y133.847 E.27507
M204 S10000
G1 X150.603 Y134.336 F30000
G1 F6000
M204 S3000
G1 X148.297 Y134.336 E.04026
G1 X148.297 Y117.664 E.29108
G1 X150.603 Y117.664 E.04026
G1 X150.603 Y134.276 E.29003
; WIPE_START
G1 X148.604 Y134.328 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.608 Y141.692 Z2 F30000
G1 X151.34 Y144.381 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S3000
G1 X146.87 Y144.381 E.07655
G1 X146.66 Y144.381 E.0036
G1 X146.66 Y143.96 E.0072
G1 X151.34 Y143.96 E.08015
G1 X151.34 Y144.321 E.00617
; WIPE_START
G1 X149.34 Y144.347 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.972 Y144.361 Z2 F30000
G1 X167.34 Y144.381 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X162.66 Y144.381 E.08015
G1 X162.66 Y143.96 E.0072
G1 X167.34 Y143.96 E.08015
G1 X167.34 Y144.321 E.00617
; WIPE_START
G1 X165.34 Y144.346 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X171.97 Y140.565 Z2 F30000
G1 X179.381 Y136.34 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44183
G1 F6000
M204 S3000
G1 X178.96 Y136.34 E.0072
G1 X178.96 Y131.66 E.08015
G1 X179.381 Y131.66 E.0072
G1 X179.381 Y131.87 E.0036
G1 X179.381 Y136.28 E.07552
; WIPE_START
G1 X178.96 Y136.34 E-.16136
G1 X178.96 Y134.764 E-.59864
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.59 Y142.371 Z2 F30000
G1 X179.79 Y144.79 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.21 E.56349
G1 X179.79 Y107.21 E1.68189
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

G1 X179.79 Y126 E.3051
G1 X179.79 Y144.73 E.30413
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.308 Y137.116 Z2 F30000
G1 X179.381 Y121.34 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44183
G1 F6000
M204 S3000
G1 X178.96 Y121.34 E.0072
G1 X178.96 Y116.66 E.08015
G1 X179.381 Y116.66 E.0072
G1 X179.381 Y121.28 E.07912
; WIPE_START
G1 X178.96 Y121.34 E-.16136
G1 X178.96 Y119.764 E-.59864
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X173.587 Y114.343 Z2 F30000
G1 X167.34 Y108.04 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S3000
G1 X162.66 Y108.04 E.08015
G1 X162.66 Y107.619 E.0072
G1 X167.34 Y107.619 E.08015
G1 X167.34 Y107.98 E.00617
; WIPE_START
G1 X165.34 Y108.005 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.708 Y108.024 Z2 F30000
G1 X151.34 Y108.04 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X146.87 Y108.04 E.07655
G1 X146.66 Y108.04 E.0036
G1 X146.66 Y107.619 E.0072
G1 X151.34 Y107.619 E.08015
G1 X151.34 Y107.98 E.00617
; WIPE_START
G1 X149.34 Y108.007 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.066 Y114.901 Z2 F30000
G1 X139.41 Y128.917 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.45476
G1 F6000
M204 S3000
G1 X139.058 Y129.812 E.01698
; LINE_WIDTH: 0.42944
G1 X138.326 Y131.674 E.03325
; LINE_WIDTH: 0.40413
G1 X137.962 Y132.601 E.01553
; LINE_WIDTH: 0.40061
G1 X137.867 Y132.826 E.00378
; LINE_WIDTH: 0.43516
G1 X137.765 Y133.035 E.00391
; LINE_WIDTH: 0.46971
G1 X137.663 Y133.243 E.00424
; LINE_WIDTH: 0.50426
G1 X137.56 Y133.452 E.00457
G2 X137.216 Y133.47 I-.082 J1.747 E.00681
; LINE_WIDTH: 0.468247
G1 X137.034 Y133.488 E.00332
; LINE_WIDTH: 0.432233
G1 X136.853 Y133.506 E.00305
; LINE_WIDTH: 0.39622
G1 X136.427 Y133.506 E.0065
; LINE_WIDTH: 0.43726
G1 X136.121 Y133.485 E.00519
; LINE_WIDTH: 0.4783
G1 X135.815 Y133.465 E.00571
G2 X135.635 Y133.067 I-2.464 J.876 E.00813
; LINE_WIDTH: 0.431593
G1 X135.512 Y132.816 E.00468
; LINE_WIDTH: 0.384887
G1 X135.389 Y132.564 E.00415
; LINE_WIDTH: 0.36053
G1 X134.674 Y130.696 E.02763
; LINE_WIDTH: 0.38288
G1 X133.958 Y128.829 E.02945
; LINE_WIDTH: 0.40523
G1 X133.243 Y126.961 E.03127
; LINE_WIDTH: 0.42758
G1 X132.527 Y125.093 E.03309
; LINE_WIDTH: 0.43848
G1 X132.179 Y124.183 E.01656
; LINE_WIDTH: 0.44999
G1 X131.775 Y123.132 E.01966
; LINE_WIDTH: 0.4575
G1 X131.362 Y122.059 E.02042
; LINE_WIDTH: 0.48038
G1 X130.647 Y120.192 E.0374
; LINE_WIDTH: 0.4966
G2 X130.014 Y118.545 I-144.061 J54.405 E.03416
G1 X130.528 Y118.545 E.00995
G2 X131.278 Y120.577 I176.537 J-64.049 E.04194
; LINE_WIDTH: 0.47371
G1 X131.77 Y121.906 E.02611
; LINE_WIDTH: 0.46715
G1 X131.857 Y122.099 E.00384
G1 X132.381 Y122.533 E.01236
; LINE_WIDTH: 0.44999
G1 X132.78 Y122.61 E.0071
; LINE_WIDTH: 0.45628
G1 X133.384 Y122.613 E.01071
G1 X132.872 Y122.859 E.01006
; LINE_WIDTH: 0.44999
G1 X132.62 Y123.177 E.0071
G1 X132.569 Y124.036 E.01502
; LINE_WIDTH: 0.43848
G1 X133.263 Y125.911 E.03398
; LINE_WIDTH: 0.41612
G1 X133.958 Y127.787 E.03216
; LINE_WIDTH: 0.39377
G1 X134.652 Y129.662 E.03034
; LINE_WIDTH: 0.37142
G1 X135.347 Y131.538 E.02852
; LINE_WIDTH: 0.34907
G1 X135.685 Y132.452 E.01301
; LINE_WIDTH: 0.34694
G1 X135.768 Y132.634 E.00264
; LINE_WIDTH: 0.390727
G1 X135.874 Y132.769 E.00259
; LINE_WIDTH: 0.434513
G1 X135.981 Y132.904 E.0029
; LINE_WIDTH: 0.4783
G1 X136.087 Y133.039 E.00321
G1 X136.273 Y133.087 E.00357
; LINE_WIDTH: 0.43726
G1 X136.459 Y133.134 E.00325
; LINE_WIDTH: 0.39622
G1 X136.678 Y133.144 E.00334
; LINE_WIDTH: 0.426333
G1 X136.872 Y133.1 E.00329
; LINE_WIDTH: 0.465297
G1 X137.066 Y133.055 E.00361
; LINE_WIDTH: 0.50426
G1 X137.261 Y133.011 E.00392
G1 X137.35 Y132.893 E.00292
; LINE_WIDTH: 0.46971
G1 X137.44 Y132.774 E.00271
; LINE_WIDTH: 0.43516
G1 X137.53 Y132.656 E.0025
; LINE_WIDTH: 0.40061
G1 X137.617 Y132.468 E.00321
; LINE_WIDTH: 0.41683
G1 X138.325 Y130.597 E.03222
; LINE_WIDTH: 0.44215
G1 X139.033 Y128.727 E.03428
; LINE_WIDTH: 0.46747
G1 X139.741 Y126.856 E.03634
; LINE_WIDTH: 0.49278
G1 X140.449 Y124.986 E.03841
; LINE_WIDTH: 0.5054
G1 X140.802 Y124.054 E.01964
; LINE_WIDTH: 0.51535
G1 X140.852 Y123.899 E.00329
G1 X140.798 Y123.56 E.00689
; LINE_WIDTH: 0.48267
G1 X140.744 Y123.222 E.00644
; LINE_WIDTH: 0.44999
G1 X140.494 Y122.881 E.00738
G1 X139.771 Y122.605 E.01352
G1 X140.6 Y122.61 E.01447
G1 X141.014 Y122.527 E.00738
; LINE_WIDTH: 0.48354
G1 X141.322 Y122.231 E.00805
; LINE_WIDTH: 0.51709
G1 X141.631 Y121.935 E.00863
; LINE_WIDTH: 0.53097
G1 X142.355 Y120.071 E.04152
; LINE_WIDTH: 0.54094
G2 X142.939 Y118.567 I-215.147 J-84.328 E.03414
G1 X143.501 Y118.567 E.0119
G2 X142.621 Y120.782 I317.74 J127.437 E.05045
; LINE_WIDTH: 0.52705
G1 X142.092 Y122.116 E.02955
; LINE_WIDTH: 0.51709
G2 X141.891 Y122.665 I9.87 J3.939 E.01182
; LINE_WIDTH: 0.48351
G1 X141.696 Y123.197 E.01066
; LINE_WIDTH: 0.477695
G1 X141.474 Y123.713 E.01043
; LINE_WIDTH: 0.5054
G1 X141.253 Y124.228 E.01106
G1 X140.521 Y126.09 E.03943
; LINE_WIDTH: 0.48008
G1 X139.79 Y127.951 E.03737
; LINE_WIDTH: 0.45476
G1 X139.432 Y128.861 E.01727
M204 S10000
G1 X139.906 Y128.82 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X137.869 Y133.907 E.09568
G1 X135.512 Y133.907 E.04114
G1 X129.353 Y118.093 E.29632
G1 X130.844 Y118.093 E.02604
G1 X132.176 Y121.758 E.06809
G1 X132.231 Y121.872 E.0022
G1 X132.541 Y122.135 E.0071
M73 P78 R10
G1 X132.78 Y122.181 E.00426
G1 X140.6 Y122.181 E.13653
G1 X140.848 Y122.131 E.00443
G1 X141.196 Y121.778 E.00867
G1 X142.613 Y118.093 E.06893
G1 X144.201 Y118.093 E.02773
G1 X139.928 Y128.764 E.20071
M204 S10000
G1 X140.304 Y128.979 F30000
G1 F6000
M204 S3000
G1 X138.159 Y134.336 E.10074
G1 X135.219 Y134.336 E.05132
G1 X128.726 Y117.664 E.31238
G1 X131.144 Y117.664 E.04223
G1 X132.579 Y121.612 E.07333
G1 X132.7 Y121.737 E.00305
G1 X132.78 Y121.753 E.00142
G1 X138.78 Y121.753 E.10476
G2 X140.647 Y121.748 I.495 J-152.321 E.0326
G1 X140.799 Y121.618 E.00347
G1 X142.319 Y117.664 E.07396
G1 X144.834 Y117.664 E.04393
G1 X140.326 Y128.924 E.21176
; WIPE_START
G1 X139.583 Y130.78 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.331 Y129.395 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X137.242 Y132.329 E.05463
G1 X137.186 Y132.443 E.00223
G1 X137.003 Y132.635 E.00463
G1 X136.64 Y132.748 E.00664
G1 X136.313 Y132.658 E.00592
G1 X136.09 Y132.438 E.00547
G1 X136.036 Y132.325 E.0022
G1 X132.966 Y123.891 E.1567
G1 X133 Y123.375 E.00903
G1 X133.151 Y123.184 E.00426
G1 X133.459 Y123.038 E.00594
G1 X133.57 Y123.029 E.00195
G1 X139.771 Y123.029 E.10827
G1 X140.205 Y123.197 E.00813
G1 X140.355 Y123.402 E.00443
G1 X140.4 Y123.804 E.00706
G1 X140.374 Y123.895 E.00166
G1 X138.352 Y129.339 E.10139
M204 S10000
G1 X137.93 Y129.246 F30000
G1 F6000
M204 S3000
G1 X136.839 Y132.185 E.05473
G1 X136.761 Y132.282 E.00217
G1 X136.603 Y132.316 E.00283
G1 X136.456 Y132.216 E.00309
G1 X136.438 Y132.178 E.00073
G1 X133.369 Y123.745 E.1567
G1 X133.38 Y123.573 E.00301
G1 X133.533 Y123.46 E.00331
G1 X133.57 Y123.457 E.00065
G1 X139.771 Y123.457 E.10827
G1 X139.947 Y123.549 E.00347
G1 X139.972 Y123.746 E.00346
G1 X137.951 Y129.19 E.10139
; WIPE_START
G1 X137.254 Y131.065 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.431 Y123.749 Z2 F30000
G1 X139.771 Y122.605 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44012
G1 F6000
M204 S3000
G1 X133.57 Y122.605 E.10578
; LINE_WIDTH: 0.45628
G1 X133.384 Y122.613 E.00329
; WIPE_START
G1 X133.57 Y122.605 E-.07061
G1 X135.384 Y122.605 E-.68939
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.856 Y118.651 Z2 F30000
G1 X111.34 Y108.04 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S3000
G1 X106.66 Y108.04 E.08015
G1 X106.66 Y107.619 E.0072
G1 X111.13 Y107.619 E.07655
G1 X111.34 Y107.619 E.0036
G1 X111.34 Y107.98 E.00617
; WIPE_START
G1 X109.34 Y108.005 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.708 Y108.024 Z2 F30000
G1 X95.34 Y108.04 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X90.87 Y108.04 E.07655
G1 X90.66 Y108.04 E.0036
G1 X90.66 Y107.619 E.0072
G1 X95.34 Y107.619 E.08015
G1 X95.34 Y107.98 E.00617
; WIPE_START
G1 X93.34 Y108.007 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.887 Y115.202 Z2 F30000
G1 X100.652 Y128.664 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.56709
G1 F6000
M204 S3000
G1 X100.424 Y129.441 E.018
; LINE_WIDTH: 0.54953
G1 X100.124 Y130.175 E.01706
; LINE_WIDTH: 0.52627
G1 X99.749 Y130.857 E.016
; LINE_WIDTH: 0.49794
G1 X99.302 Y131.479 E.01486
; LINE_WIDTH: 0.46625
G1 X98.803 Y132.022 E.01336
; LINE_WIDTH: 0.43529
G1 X98.267 Y132.486 E.01196
; LINE_WIDTH: 0.40536
G1 X97.693 Y132.881 E.0109
; LINE_WIDTH: 0.37447
G1 X97.085 Y133.205 E.00991
; LINE_WIDTH: 0.34393
G1 X96.452 Y133.459 E.00896
; LINE_WIDTH: 0.31579
G1 X95.801 Y133.647 E.00813
; LINE_WIDTH: 0.29229
G1 X95.136 Y133.775 E.00748
; LINE_WIDTH: 0.27549
G1 X94.458 Y133.849 E.00705
; LINE_WIDTH: 0.26764
G1 X93.766 Y133.876 E.00695
; LINE_WIDTH: 0.27328
G1 X93.068 Y133.849 E.00717
; LINE_WIDTH: 0.28541
G1 X92.381 Y133.767 E.00744
; LINE_WIDTH: 0.31118
G1 X91.701 Y133.635 E.00817
; LINE_WIDTH: 0.3448
G1 X91.035 Y133.441 E.00914
; LINE_WIDTH: 0.37916
G1 X90.472 Y133.221 E.00881
; LINE_WIDTH: 0.40871
G1 X89.997 Y132.974 E.00845
; LINE_WIDTH: 0.43123
G1 X89.543 Y132.676 E.00906
; LINE_WIDTH: 0.44866
G1 X89.098 Y132.32 E.00992
; LINE_WIDTH: 0.46411
G1 X88.663 Y131.899 E.01092
; LINE_WIDTH: 0.48294
G1 X88.257 Y131.429 E.01169
; LINE_WIDTH: 0.50804
G1 X87.902 Y130.93 E.01215
; LINE_WIDTH: 0.53151
G1 X87.594 Y130.406 E.01263
; LINE_WIDTH: 0.55032
G1 X87.335 Y129.862 E.01297
; LINE_WIDTH: 0.56809
G1 X87.069 Y129.11 E.01778
; LINE_WIDTH: 0.57286
G1 X86.939 Y128.625 E.01126
; LINE_WIDTH: 0.57988
G1 X86.842 Y128.133 E.01143
; LINE_WIDTH: 0.581
G1 X86.764 Y127.62 E.01183
; LINE_WIDTH: 0.58426
G1 X86.71 Y127.074 E.01258
; LINE_WIDTH: 0.58739
G1 X86.677 Y126.495 E.01336
; LINE_WIDTH: 0.58813
G3 X86.697 Y125.088 I12.252 J-.529 E.03252
; LINE_WIDTH: 0.58527
G3 X86.933 Y123.415 I10.341 J.606 E.03886
; LINE_WIDTH: 0.58164
G1 X87.113 Y122.751 E.0157
; LINE_WIDTH: 0.57591
G1 X87.298 Y122.228 E.01253
; LINE_WIDTH: 0.57428
G1 X87.592 Y121.59 E.01583
; LINE_WIDTH: 0.55991
G1 X87.94 Y121.004 E.01493
; LINE_WIDTH: 0.54023
G1 X88.344 Y120.465 E.01425
; LINE_WIDTH: 0.51544
G1 X88.806 Y119.968 E.01366
; LINE_WIDTH: 0.48742
G1 X89.353 Y119.5 E.01367
; LINE_WIDTH: 0.45388
G1 X89.94 Y119.103 E.01248
; LINE_WIDTH: 0.41599
G1 X90.558 Y118.78 E.01121
; LINE_WIDTH: 0.37675
G1 X91.057 Y118.573 E.00781
; LINE_WIDTH: 0.34862
G1 X91.198 Y118.527 E.00198
; LINE_WIDTH: 0.33989
G1 X91.853 Y118.34 E.00883
; LINE_WIDTH: 0.30908
G1 X92.565 Y118.208 E.0085
; LINE_WIDTH: 0.28572
G1 X93.182 Y118.15 E.00667
; LINE_WIDTH: 0.26842
G1 X93.87 Y118.138 E.00692
; LINE_WIDTH: 0.27776
G1 X94.696 Y118.165 E.00863
; LINE_WIDTH: 0.29986
G1 X95.472 Y118.275 E.0089
; LINE_WIDTH: 0.33012
G1 X96.199 Y118.452 E.00941
; LINE_WIDTH: 0.36488
G1 X96.868 Y118.692 E.00994
; LINE_WIDTH: 0.40069
G1 X97.482 Y118.99 E.01055
; LINE_WIDTH: 0.43491
G1 X98.049 Y119.346 E.01127
; LINE_WIDTH: 0.46584
G1 X98.573 Y119.76 E.01209
; LINE_WIDTH: 0.49388
G1 X99.059 Y120.235 E.01309
; LINE_WIDTH: 0.51902
G1 X99.493 Y120.761 E.01381
; LINE_WIDTH: 0.54034
G1 X99.867 Y121.329 E.01439
; LINE_WIDTH: 0.55958
G1 X100.218 Y122.03 E.01717
; LINE_WIDTH: 0.5738
G1 X100.493 Y122.774 E.01787
; LINE_WIDTH: 0.58332
G1 X100.698 Y123.557 E.01853
; LINE_WIDTH: 0.58881
G1 X100.838 Y124.375 E.01917
; LINE_WIDTH: 0.59641
G1 X100.932 Y125.499 E.02642
G1 X100.933 Y126.467 E.02268
; LINE_WIDTH: 0.5939
G1 X100.903 Y126.997 E.01238
; LINE_WIDTH: 0.58687
G1 X100.81 Y127.848 E.01972
; LINE_WIDTH: 0.57932
G1 X100.663 Y128.605 E.01753
M204 S10000
G1 X100.144 Y128.433 F30000
; LINE_WIDTH: 0.56795
G1 F6000
M204 S3000
G1 X99.96 Y129.159 E.01667
; LINE_WIDTH: 0.55258
G1 X99.717 Y129.847 E.01578
; LINE_WIDTH: 0.53293
G1 X99.433 Y130.448 E.01387
; LINE_WIDTH: 0.51045
G1 X99.104 Y130.989 E.0126
; LINE_WIDTH: 0.48506
G1 X98.72 Y131.493 E.01197
; LINE_WIDTH: 0.45715
G1 X98.281 Y131.957 E.01134
; LINE_WIDTH: 0.42845
G1 X97.801 Y132.367 E.01047
; LINE_WIDTH: 0.39936
G1 X97.277 Y132.725 E.00977
; LINE_WIDTH: 0.36931
G1 X96.702 Y133.031 E.00922
; LINE_WIDTH: 0.33945
G1 X96.069 Y133.281 E.00883
; LINE_WIDTH: 0.31175
G1 X95.37 Y133.47 E.00856
; LINE_WIDTH: 0.28866
G1 X94.605 Y133.59 E.00842
; LINE_WIDTH: 0.27266
G1 X93.86 Y133.629 E.00764
; LINE_WIDTH: 0.27306
G1 X93.31 Y133.612 E.00564
; LINE_WIDTH: 0.28222
G1 X92.528 Y133.525 E.00836
; LINE_WIDTH: 0.30702
G1 X92.034 Y133.422 E.00587
; LINE_WIDTH: 0.3408
G1 X91.29 Y133.195 E.01013
; LINE_WIDTH: 0.37615
G1 X90.669 Y132.918 E.00982
; LINE_WIDTH: 0.40871
G1 X90.204 Y132.646 E.00851
; LINE_WIDTH: 0.43465
G1 X89.578 Y132.179 E.01314
; LINE_WIDTH: 0.45635
G1 X89.094 Y131.714 E.01191
; LINE_WIDTH: 0.48144
M73 P79 R10
G1 X88.648 Y131.179 E.01305
; LINE_WIDTH: 0.50804
G1 X88.317 Y130.676 E.01195
; LINE_WIDTH: 0.53151
G1 X88.053 Y130.184 E.01159
; LINE_WIDTH: 0.55032
G1 X87.833 Y129.685 E.01176
; LINE_WIDTH: 0.55822
G1 X87.64 Y129.127 E.01291
; LINE_WIDTH: 0.57286
G1 X87.473 Y128.487 E.01485
; LINE_WIDTH: 0.5779
G1 X87.339 Y127.709 E.01791
; LINE_WIDTH: 0.58426
G1 X87.271 Y127.031 E.01561
; LINE_WIDTH: 0.58739
G3 X87.231 Y125.978 I19.051 J-1.25 E.02431
; LINE_WIDTH: 0.5909
G1 X87.244 Y125.448 E.0123
; LINE_WIDTH: 0.59145
G3 X87.427 Y123.798 I10.938 J.374 E.03858
; LINE_WIDTH: 0.58932
G1 X87.594 Y123.087 E.0169
; LINE_WIDTH: 0.58384
G1 X87.808 Y122.439 E.01565
; LINE_WIDTH: 0.57428
G1 X88.065 Y121.846 E.01455
; LINE_WIDTH: 0.55991
G1 X88.365 Y121.3 E.01368
; LINE_WIDTH: 0.54023
G1 X88.659 Y120.86 E.01116
; LINE_WIDTH: 0.51544
G1 X88.715 Y120.79 E.00182
G1 X89.039 Y120.4 E.0102
; LINE_WIDTH: 0.49055
G1 X89.527 Y119.919 E.0131
; LINE_WIDTH: 0.45978
G1 X90.044 Y119.508 E.01181
; LINE_WIDTH: 0.42471
G1 X90.601 Y119.157 E.0108
; LINE_WIDTH: 0.38663
G1 X91.19 Y118.872 E.00974
; LINE_WIDTH: 0.34862
G1 X91.807 Y118.652 E.00873
; LINE_WIDTH: 0.31421
G1 X92.446 Y118.497 E.00784
; LINE_WIDTH: 0.28684
G1 X93.101 Y118.405 E.00716
; LINE_WIDTH: 0.26925
G1 X93.772 Y118.374 E.00678
; LINE_WIDTH: 0.26562
G1 X94.436 Y118.397 E.00661
; LINE_WIDTH: 0.28173
G1 X95.084 Y118.478 E.00693
; LINE_WIDTH: 0.30464
G1 X95.717 Y118.621 E.00749
; LINE_WIDTH: 0.33503
G1 X96.332 Y118.828 E.00828
; LINE_WIDTH: 0.37005
G1 X96.922 Y119.102 E.00924
; LINE_WIDTH: 0.40647
G1 X97.483 Y119.44 E.01027
; LINE_WIDTH: 0.44143
G1 X98.008 Y119.843 E.01132
; LINE_WIDTH: 0.47278
G1 X98.495 Y120.309 E.01239
; LINE_WIDTH: 0.50284
G1 X98.944 Y120.846 E.01374
; LINE_WIDTH: 0.53212
G1 X99.341 Y121.454 E.01511
; LINE_WIDTH: 0.55681
G1 X99.67 Y122.114 E.01609
; LINE_WIDTH: 0.57473
G1 X99.922 Y122.794 E.01634
; LINE_WIDTH: 0.58595
G1 X100.108 Y123.486 E.01648
; LINE_WIDTH: 0.59251
G1 X100.247 Y124.246 E.01796
; LINE_WIDTH: 0.59499
G3 X100.369 Y125.984 I-12.427 J1.746 E.04075
; LINE_WIDTH: 0.59369
G1 X100.346 Y126.869 E.02066
; LINE_WIDTH: 0.58861
G1 X100.271 Y127.67 E.01857
; LINE_WIDTH: 0.57959
G1 X100.154 Y128.374 E.01624
M204 S10000
G1 X99.656 Y128.353 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G3 X99.273 Y129.693 I-9.412 J-1.967 E.02436
G3 X95.947 Y132.943 I-5.237 J-2.033 E.0837
G3 X92.575 Y133.184 I-2.173 J-6.709 E.0596
G3 X88.479 Y129.986 I1.02 J-5.53 E.09433
G1 X88.125 Y129.067 E.0172
G3 X87.918 Y123.882 I11.43 J-3.053 E.09134
G3 X89.076 Y121.076 I7.126 J1.3 E.0534
G3 X93.15 Y118.74 I4.635 J3.362 E.08449
G3 X96.746 Y119.448 I.665 J6.105 E.06499
G3 X99.459 Y122.955 I-3.051 J5.162 E.0793
G3 X99.848 Y126.855 I-11.667 J3.135 E.06873
G3 X99.669 Y128.295 I-9.604 J-.469 E.02535
M204 S10000
G1 X99.228 Y128.283 F30000
G1 F6000
M204 S3000
G3 X99.078 Y128.941 I-11.335 J-2.228 E.01178
G3 X96.349 Y132.311 I-5.174 J-1.401 E.07794
G3 X93.219 Y132.839 I-2.563 J-5.648 E.05606
G3 X90.114 Y131.521 I.395 J-5.243 E.05995
G3 X88.53 Y128.926 I3.877 J-4.149 E.05374
G3 X88.34 Y123.954 I11.033 J-2.91 E.08758
G3 X89.412 Y121.342 I6.704 J1.226 E.04965
G3 X93.807 Y119.135 I4.318 J3.119 E.08926
G3 X98.845 Y122.499 I.1 J5.304 E.11257
G3 X99.411 Y125.177 I-8.655 J3.229 E.04796
G3 X99.239 Y128.225 I-11.518 J.879 E.05346
; WIPE_START
G1 X99.078 Y128.941 E-.2792
G1 X98.868 Y129.553 E-.24593
G1 X98.628 Y130.075 E-.21829
G1 X98.605 Y130.113 E-.01658
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.124 Y128.779 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X101.119 Y128.802 E.00041
G3 X100.122 Y131.113 I-8.141 J-2.141 E.04411
G1 X99.632 Y131.764 E.01423
G3 X95.876 Y133.988 I-5.208 J-4.512 E.07754
G3 X91.084 Y133.857 I-2.125 J-9.997 E.08449
G1 X90.329 Y133.588 E.014
G3 X87.918 Y131.718 I2.674 J-5.937 E.05376
G3 X86.357 Y128.227 I5.879 J-4.724 E.06752
G3 X86.379 Y123.597 I13.613 J-2.25 E.08121
G3 X87.54 Y120.747 I7.688 J1.47 E.05409
G3 X90.922 Y118.22 I5.428 J3.739 E.07502
G1 X90.97 Y118.202 E.0009
G3 X93.371 Y117.796 I2.851 J9.55 E.04263
G1 X94.714 Y117.822 E.02345
G3 X97.687 Y118.642 I-.761 J8.562 E.05415
G3 X100.285 Y121.106 I-3.291 J6.07 E.06324
G3 X101.332 Y124.32 I-7.665 J4.276 E.05938
G1 X101.433 Y125.476 E.02026
G3 X101.285 Y127.942 I-12.808 J.467 E.0432
G1 X101.135 Y128.72 E.01383
M204 S10000
G1 X101.553 Y128.844 F30000
G1 F6000
M204 S3000
G3 X100.18 Y131.786 I-7.776 J-1.838 E.05709
G3 X96.365 Y134.319 I-5.684 J-4.421 E.08136
G3 X90.962 Y134.269 I-2.605 J-10.437 E.09536
G1 X90.163 Y133.984 E.01481
G3 X87.586 Y131.99 I2.85 J-6.345 E.05743
G3 X86.505 Y130.236 I6.835 J-5.421 E.03604
G1 X86.191 Y129.376 E.016
G3 X85.748 Y125.385 I12.465 J-3.401 E.07039
G3 X86.44 Y121.892 I10.618 J.287 E.06248
G3 X90.768 Y117.82 I6.581 J2.66 E.10705
G1 X90.837 Y117.794 E.00128
G3 X93.358 Y117.367 I2.994 J10.018 E.04476
G1 X94.745 Y117.394 E.02421
G3 X97.857 Y118.245 I-.624 J8.402 E.05668
G3 X101.315 Y122.309 I-3.423 J6.414 E.09539
G3 X101.862 Y125.461 I-11.093 J3.549 E.05603
G3 X101.566 Y128.785 I-13.174 J.505 E.05843
; WIPE_START
G1 X101.31 Y129.67 E-.35012
G1 X101 Y130.435 E-.31361
G1 X100.881 Y130.658 E-.09628
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.772 Y127.88 Z2 F30000
G1 X77.04 Y121.34 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S3000
G1 X76.619 Y121.34 E.0072
G1 X76.619 Y116.66 E.08015
G1 X77.04 Y116.66 E.0072
G1 X77.04 Y121.28 E.07912
; WIPE_START
G1 X76.619 Y121.34 E-.16136
G1 X76.619 Y119.764 E-.59864
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.813 Y127.394 Z2 F30000
G1 X77.04 Y136.34 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X76.619 Y136.34 E.0072
G1 X76.619 Y131.66 E.08015
G1 X77.04 Y131.66 E.0072
G1 X77.04 Y136.28 E.07912
; WIPE_START
G1 X76.619 Y136.34 E-.16136
G1 X76.619 Y134.764 E-.59864
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.409 Y138.252 Z2 F30000
G1 X95.34 Y144.381 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X90.66 Y144.381 E.08015
G1 X90.66 Y143.96 E.0072
G1 X95.34 Y143.96 E.08015
G1 X95.34 Y144.321 E.00617
; WIPE_START
G1 X93.34 Y144.346 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.972 Y144.361 Z2 F30000
G1 X111.34 Y144.381 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X106.66 Y144.381 E.08015
G1 X106.66 Y143.96 E.0072
G1 X111.34 Y143.96 E.08015
G1 X111.34 Y144.321 E.00617
; WIPE_START
G1 X109.34 Y144.346 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.166 Y138.433 Z2 F30000
G1 X118.19 Y133.502 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.40268
G1 F6000
M204 S3000
G1 X117.809 Y133.502 E.00592
G1 X117.809 Y123.894 E.14924
; LINE_WIDTH: 0.44999
G1 X117.564 Y123.184 E.0131
G1 X117.052 Y122.863 E.01056
G1 X115.741 Y122.493 E.02379
G1 X115.135 Y122.5 E.01057
G1 X114.556 Y122.976 E.0131
; LINE_WIDTH: 0.40705
G1 X113.509 Y124.68 E.03142
; LINE_WIDTH: 0.41091
G1 X112.463 Y126.385 E.03174
; LINE_WIDTH: 0.41477
G1 X111.416 Y128.089 E.03205
; LINE_WIDTH: 0.41677
G1 X110.876 Y128.968 E.01661
; LINE_WIDTH: 0.44999
G2 X108.092 Y133.479 I399.616 J249.753 E.09255
G1 X106.929 Y133.479 E.0203
G1 X106.929 Y129.705 E.06588
G2 X106.906 Y127.834 I-36.998 J-.468 E.03267
; LINE_WIDTH: 0.40268
G1 X106.906 Y118.498 E.14502
G1 X107.287 Y118.498 E.00592
G1 X107.287 Y127.834 E.14502
; LINE_WIDTH: 0.41206
G1 X107.298 Y128.016 E.0029
; LINE_WIDTH: 0.44999
G1 X107.531 Y128.543 E.01005
G1 X108.042 Y128.865 E.01055
G1 X109.35 Y129.236 E.02374
G1 X109.953 Y129.231 E.01054
G1 X110.54 Y128.761 E.01313
; LINE_WIDTH: 0.41677
G1 X111.59 Y127.058 E.03221
; LINE_WIDTH: 0.4129
G1 X112.64 Y125.356 E.0319
; LINE_WIDTH: 0.40904
G1 X113.69 Y123.654 E.03158
; LINE_WIDTH: 0.40518
G1 X114.231 Y122.776 E.01613
; LINE_WIDTH: 0.40319
G1 X114.234 Y122.772 E.00007
; LINE_WIDTH: 0.44999
G2 X116.847 Y118.59 I-171.184 J-109.861 E.08611
G1 X116.889 Y118.521 E.0014
G1 X118.166 Y118.521 E.0223
G1 X118.166 Y122.521 E.06984
G2 X118.19 Y123.894 I27.196 J.218 E.02397
; LINE_WIDTH: 0.40268
G1 X118.19 Y133.442 E.14831
M204 S10000
G1 X118.595 Y133.907 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X117.404 Y133.907 E.02079
G1 X117.404 Y123.894 E.17484
G1 X117.243 Y123.468 E.00795
G1 X116.936 Y123.275 E.00634
G1 X115.624 Y122.905 E.02379
G1 X115.261 Y122.909 E.00634
G1 X114.903 Y123.186 E.0079
G1 X108.332 Y133.907 E.21955
G1 X106.501 Y133.907 E.03198
G1 X106.501 Y129.705 E.07337
G1 X106.501 Y118.093 E.20275
G1 X107.692 Y118.093 E.02079
G1 X107.701 Y127.945 E.17202
G1 X107.852 Y128.259 E.00608
G1 X108.159 Y128.453 E.00633
G1 X109.467 Y128.824 E.02374
G1 X109.829 Y128.821 E.00632
G1 X110.189 Y128.544 E.00794
G1 X116.65 Y118.093 E.21453
G1 X118.595 Y118.093 E.03395
G1 X118.595 Y133.847 E.27507
M204 S10000
G1 X119.023 Y134.336 F30000
G1 F6000
M204 S3000
G1 X116.975 Y134.336 E.03576
G1 X116.975 Y123.894 E.18232
G1 X116.922 Y123.752 E.00265
G1 X116.819 Y123.687 E.00211
G1 X115.508 Y123.318 E.02379
G1 X115.387 Y123.319 E.00211
G1 X115.267 Y123.411 E.00263
G1 X108.572 Y134.336 E.22372
G1 X106.072 Y134.336 E.04365
G1 X106.072 Y129.705 E.08085
G1 X106.072 Y117.664 E.21023
G1 X108.12 Y117.664 E.03576
G1 X108.12 Y127.664 E.1746
G2 X108.174 Y127.976 I.439 J.085 E.00564
G1 X108.276 Y128.04 E.00211
G1 X109.584 Y128.412 E.02374
G1 X109.705 Y128.411 E.00211
G1 X109.825 Y128.319 E.00265
G1 X116.411 Y117.664 E.2187
G1 X119.023 Y117.664 E.04561
G1 X119.023 Y134.276 E.29003
; WIPE_START
G1 X117.024 Y134.334 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.67 Y130.107 Z2 F30000
G1 X109.962 Y129.636 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X109.293 Y129.642 E.01087
G3 X107.929 Y129.263 I16.16 J-60.771 E.02299
G1 X107.343 Y128.903 E.01117
G1 X107.343 Y133.065 E.06759
G1 X107.861 Y133.065 E.00841
G1 X109.931 Y129.687 E.06433
M204 S10000
G1 X109.251 Y130.034 F30000
G1 F6000
M204 S3000
G3 X107.741 Y129.611 I4.084 J-17.467 E.02546
G1 X107.741 Y132.497 E.04686
G1 X109.219 Y130.085 E.04593
M204 S10000
G1 X108.633 Y130.287 F30000
; LINE_WIDTH: 0.41235
G1 F6000
M204 S3000
G1 X108.136 Y130.146 E.00822
G1 X108.136 Y131.098 E.01516
G1 X108.601 Y130.338 E.01418
; WIPE_START
G1 X108.136 Y131.098 E-.33842
G1 X108.136 Y130.146 E-.36162
G1 X108.288 Y130.189 E-.05996
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.312 Y125.502 Z2 F30000
G1 X117.753 Y122.825 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X117.753 Y118.935 E.06317
G1 X117.119 Y118.935 E.01028
G1 X115.166 Y122.094 E.06032
G1 X115.796 Y122.087 E.01023
G3 X117.164 Y122.465 I-16.582 J62.767 E.02304
G1 X117.702 Y122.794 E.01023
M204 S10000
G1 X117.354 Y122.117 F30000
G1 F6000
M204 S3000
G1 X117.354 Y119.333 E.04521
G1 X115.878 Y121.7 E.04529
G3 X117.299 Y122.093 I-8.142 J32.215 E.02394
M204 S10000
G1 X116.966 Y121.592 F30000
; LINE_WIDTH: 0.39881
G1 F6000
M204 S3000
G1 X116.966 Y120.678 E.01404
G1 X116.486 Y121.456 E.01406
G1 X116.909 Y121.575 E.00676
; WIPE_START
G1 X116.486 Y121.456 E-.16702
G1 X116.966 Y120.678 E-.34743
G1 X116.966 Y121.325 E-.24555
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.558 Y122.112 Z2 F30000
G1 X132.241 Y122.909 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.51746
G1 F6000
M204 S3000
G2 X132.242 Y123.014 I-.025 J.053 E.00482
; WIPE_START
G1 X132.179 Y123.016 E-.19232
G1 X132.148 Y122.962 E-.18922
G1 X132.179 Y122.909 E-.18922
G1 X132.241 Y122.909 E-.18923
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.936 Y123.691 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X139.524 Y124.28 E.01351
G1 X139.372 Y124.69
G1 X138.372 Y123.691 E.02294
G1 X137.809 Y123.691
G1 X139.219 Y125.101 E.03238
G1 X139.066 Y125.512
G1 X137.245 Y123.691 E.04182
G1 X136.682 Y123.691
G1 X138.914 Y125.923 E.05126
G1 X138.761 Y126.334
G1 X136.118 Y123.691 E.0607
G1 X135.554 Y123.691
G1 X138.609 Y126.745 E.07013
G1 X138.456 Y127.156
G1 X134.991 Y123.691 E.07957
G1 X134.427 Y123.691
G1 X138.303 Y127.567 E.08901
G1 X138.151 Y127.978
G1 X133.864 Y123.691 E.09845
G1 X133.769 Y124.161
G1 X137.998 Y128.389 E.0971
G1 X137.845 Y128.8
G1 X134.092 Y125.047 E.08619
G1 X134.415 Y125.933
G1 X137.693 Y129.211 E.07528
G1 X137.54 Y129.622
G1 X134.737 Y126.819 E.06437
G1 X135.06 Y127.705
G1 X137.388 Y130.033 E.05346
G1 X137.235 Y130.444
G1 X135.382 Y128.592 E.04255
G1 X135.705 Y129.478
G1 X137.082 Y130.855 E.03164
G1 X136.93 Y131.266
G1 X136.027 Y130.364 E.02073
; WIPE_START
M204 S3000
G1 X136.93 Y131.266 E-.48506
G1 X137.082 Y130.855 E-.1666
G1 X136.881 Y130.654 E-.10835
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.643 Y124.013 Z2 F30000
G1 X141.252 Y122.939 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.62904
G1 F6000
M204 S3000
G2 X141.26 Y123.057 I-.035 J.061 E.00754
; WIPE_START
G1 X141.252 Y123.07 E-.03788
G1 X141.176 Y123.07 E-.18052
G1 X141.138 Y123.005 E-.18053
G1 X141.176 Y122.939 E-.18053
G1 X141.252 Y122.939 E-.18052
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X148.75 Y124.367 Z2 F30000
G1 X156.771 Y125.895 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.53894
G1 F6000
M204 S3000
G2 X156.773 Y126.003 I-.027 J.055 E.0053
; WIPE_START
G1 X156.706 Y126.007 E-.19536
G1 X156.674 Y125.951 E-.18821
G1 X156.706 Y125.895 E-.18821
G1 X156.771 Y125.895 E-.18822
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.054 Y128.177 Z2 F30000
G1 X166.017 Y128.792 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X164.409 Y127.184 E.03692
G1 X163.726 Y127.064
G1 X166.135 Y129.473 E.05533
G1 X166.128 Y130.03
G1 X163.108 Y127.01 E.06936
G1 X162.524 Y126.99
G1 X166.046 Y130.512 E.08088
G1 X165.898 Y130.927
G1 X161.94 Y126.969 E.09088
G1 X161.368 Y126.961
G1 X165.692 Y131.284 E.09929
G1 X165.434 Y131.59
G1 X160.804 Y126.96 E.10633
G1 X160.24 Y126.96
G1 X165.128 Y131.848 E.11226
G1 X164.774 Y132.057
G1 X159.675 Y126.959 E.11708
G1 X159.111 Y126.958
G1 X164.369 Y132.216 E.12073
G1 X163.91 Y132.32
G1 X158.547 Y126.958 E.12314
G1 X157.983 Y126.957
G1 X163.381 Y132.355 E.12396
G1 X162.832 Y132.37
G1 X157.946 Y127.484 E.11218
G1 X157.946 Y128.048
G1 X162.278 Y132.38 E.09948
G1 X161.716 Y132.382
G1 X157.946 Y128.612 E.08657
G1 X157.946 Y129.175
G1 X161.153 Y132.382 E.07364
G1 X160.59 Y132.383
G1 X157.946 Y129.739 E.06071
G1 X157.946 Y130.302
G1 X160.027 Y132.383 E.04778
G1 X159.464 Y132.384
G1 X157.946 Y130.866 E.03485
G1 X157.946 Y131.43
G1 X158.901 Y132.384 E.02192
G1 X158.338 Y132.385
G1 X157.946 Y131.993 E.00899
; WIPE_START
M204 S3000
G1 X158.338 Y132.385 E-.21034
G1 X158.901 Y132.384 E-.21398
G1 X158.276 Y131.76 E-.33569
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.178 Y128.501 Z2 F30000
G1 X165.762 Y128.226 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0812386
G1 F3600
M204 S3000
G1 X165.695 Y128.137 E.00027
; LINE_WIDTH: 0.118507
G2 X165.155 Y127.584 I-3.584 J2.959 E.00306
; LINE_WIDTH: 0.0904694
G1 X164.99 Y127.452 E.00059
; WIPE_START
G1 X165.155 Y127.584 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X171.49 Y131.842 Z2 F30000
G1 X179.571 Y137.273 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X178.868 Y136.57 E.01615
; WIPE_START
M204 S3000
G1 X179.571 Y137.273 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.571 Y129.641 Z2 F30000
G1 X179.571 Y122.056 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X179.085 Y121.57 E.01115
; WIPE_START
M204 S3000
G1 X179.571 Y122.056 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y114.428 Z2 F30000
G1 X179.035 Y107.429 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X179.571 Y107.965 E.01232
G1 X179.571 Y108.529
G1 X178.471 Y107.429 E.02526
G1 X177.907 Y107.429
G1 X179.571 Y109.093 E.0382
G1 X179.571 Y109.656
G1 X177.344 Y107.429 E.05114
G1 X176.78 Y107.429
G1 X179.571 Y110.22 E.06409
G1 X179.571 Y110.784
G1 X176.216 Y107.429 E.07703
G1 X175.653 Y107.429
G1 X179.571 Y111.347 E.08997
G1 X179.571 Y111.911
G1 X175.089 Y107.429 E.10291
G1 X174.526 Y107.429
G1 X179.571 Y112.474 E.11586
G1 X179.571 Y113.038
G1 X173.962 Y107.429 E.1288
G1 X173.398 Y107.429
G1 X179.571 Y113.602 E.14174
G1 X179.571 Y114.165
G1 X172.835 Y107.429 E.15469
G1 X172.271 Y107.429
G1 X179.571 Y114.729 E.16763
G1 X179.571 Y115.292
G1 X171.708 Y107.429 E.18057
G1 X171.144 Y107.429
G1 X179.571 Y115.856 E.19351
G1 X179.571 Y116.42
G1 X170.58 Y107.429 E.20646
G1 X170.017 Y107.429
G1 X179.018 Y116.43 E.2067
G1 X178.73 Y116.706
G1 X169.453 Y107.429 E.21303
G1 X168.89 Y107.429
G1 X178.73 Y117.27 E.22598
G1 X178.73 Y117.833
G1 X168.326 Y107.429 E.23892
G1 X167.762 Y107.429
G1 X178.73 Y118.397 E.25186
G1 X178.73 Y118.96
G1 X167.57 Y107.8 E.25628
G1 X167.476 Y108.27
G1 X178.73 Y119.524 E.25844
G1 X178.73 Y120.088
G1 X166.912 Y108.27 E.27138
G1 X166.349 Y108.27
G1 X178.73 Y120.651 E.28433
G1 X178.73 Y121.215
G1 X165.785 Y108.27 E.29727
G1 X165.221 Y108.27
G1 X179.571 Y122.619 E.32952
G1 X179.571 Y123.183
G1 X164.658 Y108.27 E.34246
G1 X164.094 Y108.27
G1 X179.571 Y123.746 E.3554
G1 X179.571 Y124.31
G1 X163.531 Y108.27 E.36835
G1 X162.967 Y108.27
G1 X179.571 Y124.874 E.38129
G1 X179.571 Y125.437
G1 X161.563 Y107.429 E.41354
G1 X160.999 Y107.429
G1 X179.571 Y126.001 E.42648
G1 X179.571 Y126.565
G1 X160.435 Y107.429 E.43942
G1 X159.872 Y107.429
G1 X169.873 Y117.43 E.22966
G1 X169.309 Y117.43
G1 X159.308 Y107.429 E.22966
G1 X158.745 Y107.429
G1 X168.746 Y117.43 E.22966
G1 X168.182 Y117.43
G1 X158.181 Y107.429 E.22966
G1 X157.617 Y107.429
G1 X167.618 Y117.43 E.22966
G1 X167.055 Y117.43
G1 X157.054 Y107.429 E.22966
G1 X156.49 Y107.429
G1 X166.68 Y117.619 E.234
G1 X166.453 Y117.956
G1 X155.927 Y107.429 E.24174
G1 X155.363 Y107.429
G1 X166.226 Y118.293 E.24947
G1 X166 Y118.629
G1 X154.799 Y107.429 E.2572
G1 X154.236 Y107.429
G1 X165.773 Y118.966 E.26493
G1 X165.546 Y119.303
G1 X153.672 Y107.429 E.27266
G1 X153.109 Y107.429
G1 X165.319 Y119.639 E.2804
G1 X165.092 Y119.976
G1 X152.545 Y107.429 E.28813
G1 X151.981 Y107.429
G1 X164.865 Y120.313 E.29586
G1 X164.638 Y120.65
G1 X151.57 Y107.581 E.3001
G1 X151.57 Y108.145
G1 X164.411 Y120.986 E.29489
G1 X164.184 Y121.323
G1 X151.131 Y108.27 E.29975
G1 X150.568 Y108.27
G1 X163.957 Y121.66 E.30748
G1 X163.73 Y121.996
G1 X150.004 Y108.27 E.31521
G1 X149.441 Y108.27
G1 X163.504 Y122.333 E.32294
G1 X163.271 Y122.664
G1 X148.877 Y108.27 E.33055
G1 X148.313 Y108.27
G1 X157.473 Y117.43 E.21035
G1 X156.91 Y117.43
G1 X147.75 Y108.27 E.21035
G1 X147.186 Y108.27
G1 X156.346 Y117.43 E.21035
G1 X155.783 Y117.43
G1 X146.622 Y108.27 E.21035
G1 X146.43 Y108.078
G1 X145.782 Y107.429 E.01489
G1 X145.218 Y107.429
G1 X155.219 Y117.43 E.22966
G1 X155.172 Y117.947
G1 X144.655 Y107.429 E.24153
G1 X144.091 Y107.429
G1 X155.172 Y118.51 E.25447
G1 X155.172 Y119.074
G1 X143.527 Y107.429 E.26741
G1 X142.964 Y107.429
G1 X155.172 Y119.638 E.28036
G1 X155.172 Y120.201
G1 X142.4 Y107.429 E.2933
G1 X141.836 Y107.429
G1 X155.172 Y120.765 E.30624
G1 X155.172 Y121.329
G1 X141.273 Y107.429 E.31918
G1 X140.709 Y107.429
G1 X150.71 Y117.43 E.22966
G1 X150.147 Y117.43
G1 X140.146 Y107.429 E.22966
G1 X139.582 Y107.429
G1 X149.583 Y117.43 E.22966
G1 X149.019 Y117.43
G1 X139.018 Y107.429 E.22966
G1 X138.455 Y107.429
G1 X148.456 Y117.43 E.22966
G1 X148.063 Y117.601
G1 X137.891 Y107.429 E.23359
G1 X137.328 Y107.429
G1 X148.063 Y118.165 E.24653
G1 X148.063 Y118.728
G1 X136.764 Y107.429 E.25947
G1 X136.2 Y107.429
G1 X145.751 Y116.98 E.21932
G1 X145.818 Y117.047
G1 X148.063 Y119.292 E.05155
G1 X148.063 Y119.855
G1 X135.637 Y107.429 E.28536
G1 X135.073 Y107.429
G1 X145.074 Y117.43 E.22966
G1 X144.51 Y117.43
G1 X134.51 Y107.429 E.22966
G1 X133.946 Y107.429
G1 X143.947 Y117.43 E.22966
G1 X143.383 Y117.43
G1 X133.382 Y107.429 E.22966
G1 X132.819 Y107.429
G1 X142.82 Y117.43 E.22966
G1 X142.256 Y117.43
G1 X132.255 Y107.429 E.22966
G1 X131.692 Y107.429
G1 X142.028 Y117.766 E.23738
G1 X141.872 Y118.173
G1 X131.128 Y107.429 E.24673
G1 X130.564 Y107.429
G1 X141.716 Y118.58 E.25607
G1 X141.559 Y118.987
G1 X130.001 Y107.429 E.26542
G1 X129.437 Y107.429
M73 P80 R10
G1 X141.403 Y119.395 E.27477
G1 X141.246 Y119.802
G1 X128.874 Y107.429 E.28412
G1 X128.31 Y107.429
G1 X141.09 Y120.209 E.29347
G1 X140.933 Y120.616
G1 X127.746 Y107.429 E.30282
G1 X127.183 Y107.429
G1 X140.777 Y121.023 E.31217
G1 X140.62 Y121.43
G1 X126.619 Y107.429 E.32152
G1 X126.055 Y107.429
G1 X140.145 Y121.519 E.32355
G1 X139.581 Y121.519
G1 X125.492 Y107.429 E.32355
G1 X124.928 Y107.429
G1 X139.018 Y121.519 E.32355
G1 X138.454 Y121.519
G1 X124.365 Y107.429 E.32355
G1 X123.801 Y107.429
G1 X137.891 Y121.519 E.32355
G1 X137.327 Y121.519
G1 X123.237 Y107.429 E.32355
G1 X122.674 Y107.429
G1 X136.763 Y121.519 E.32355
G1 X136.2 Y121.519
G1 X122.11 Y107.429 E.32355
G1 X121.547 Y107.429
G1 X135.636 Y121.519 E.32355
G1 X135.073 Y121.519
G1 X131.494 Y117.94 E.08218
G1 X131.815 Y118.825
G1 X134.509 Y121.519 E.06185
G1 X133.945 Y121.519
G1 X132.137 Y119.71 E.04152
G1 X132.459 Y120.596
G1 X133.382 Y121.519 E.02119
; WIPE_START
M204 S3000
G1 X132.459 Y120.596 E-.496
G1 X132.222 Y119.943 E-.264
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.984 Y117.43 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X120.983 Y107.429 E.22966
G1 X120.419 Y107.429
G1 X130.42 Y117.43 E.22966
G1 X129.857 Y117.43
G1 X119.856 Y107.429 E.22966
G1 X119.292 Y107.429
G1 X129.293 Y117.43 E.22966
G1 X128.73 Y117.43
G1 X118.729 Y107.429 E.22966
G1 X118.165 Y107.429
G1 X127.731 Y116.995 E.21967
G1 X127.776 Y117.04
G1 X128.522 Y117.786 E.01713
G1 X128.882 Y118.71
G1 X117.601 Y107.429 E.25904
G1 X117.038 Y107.429
G1 X129.241 Y119.633 E.28024
G1 X129.601 Y120.556
G1 X116.474 Y107.429 E.30144
G1 X115.911 Y107.429
G1 X129.961 Y121.479 E.32264
G1 X130.32 Y122.402
G1 X115.347 Y107.429 E.34384
G1 X114.783 Y107.429
G1 X130.68 Y123.326 E.36504
G1 X131.039 Y124.249
G1 X114.22 Y107.429 E.38624
G1 X113.656 Y107.429
G1 X131.399 Y125.172 E.40744
G1 X131.758 Y126.095
G1 X113.093 Y107.429 E.42864
G1 X112.529 Y107.429
G1 X132.118 Y127.018 E.44984
G1 X132.478 Y127.941
G1 X111.965 Y107.429 E.47104
G1 X111.57 Y107.597
G1 X132.837 Y128.865 E.48838
G1 X133.197 Y129.788
G1 X111.57 Y108.161 E.49664
G1 X111.115 Y108.27
G1 X133.556 Y130.711 E.51534
G1 X133.916 Y131.634
G1 X110.552 Y108.27 E.53654
G1 X109.988 Y108.27
G1 X119.148 Y117.43 E.21035
G1 X118.585 Y117.43
G1 X109.424 Y108.27 E.21035
G1 X108.861 Y108.27
G1 X118.021 Y117.43 E.21035
G1 X117.457 Y117.43
G1 X108.297 Y108.27 E.21035
G1 X107.734 Y108.27
G1 X116.894 Y117.43 E.21035
G1 X116.33 Y117.43
G1 X107.17 Y108.27 E.21035
G1 X106.606 Y108.27
G1 X116.084 Y117.748 E.21765
; WIPE_START
M204 S3000
G1 X114.67 Y116.334 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.257 Y117.539 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X134.275 Y132.557 E.34487
G1 X134.635 Y133.481
G1 X119.257 Y118.103 E.35313
G1 X119.257 Y118.667
G1 X134.995 Y134.404 E.36139
; WIPE_START
M204 S3000
G1 X133.58 Y132.989 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.612 Y130.021 Z2 F30000
G1 X170.042 Y117.599 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X179.571 Y127.128 E.21882
G1 X179.571 Y127.692
G1 X169.824 Y117.945 E.22381
M73 P80 R9
G1 X169.607 Y118.291
G1 X179.571 Y128.255 E.22881
G1 X179.571 Y128.819
G1 X169.389 Y118.638 E.23381
G1 X169.172 Y118.984
G1 X179.571 Y129.383 E.2388
G1 X179.571 Y129.946
G1 X168.954 Y119.33 E.2438
G1 X168.737 Y119.676
G1 X179.571 Y130.51 E.24879
G1 X179.571 Y131.073
G1 X168.519 Y120.022 E.25379
G1 X168.302 Y120.368
G1 X179.364 Y131.43 E.25403
G1 X178.8 Y131.43
G1 X168.084 Y120.714 E.24608
G1 X167.867 Y121.06
G1 X178.73 Y131.923 E.24946
G1 X178.73 Y132.487
G1 X167.644 Y121.401 E.25457
G1 X167.416 Y121.737
G1 X178.73 Y133.051 E.25981
G1 X178.73 Y133.614
G1 X167.187 Y122.071 E.26508
G1 X166.943 Y122.391
G1 X178.73 Y134.178 E.27068
G1 X178.73 Y134.741
G1 X166.699 Y122.71 E.27629
G1 X166.448 Y123.023
G1 X178.73 Y135.305 E.28205
G1 X178.73 Y135.869
G1 X166.171 Y123.31 E.2884
G1 X165.881 Y123.584
G1 X178.73 Y136.432 E.29506
; WIPE_START
M204 S3000
G1 X177.316 Y135.018 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.571 Y137.837 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X165.575 Y123.84 E.32141
G1 X165.251 Y124.08
G1 X179.571 Y138.4 E.32885
G1 X179.571 Y138.964
G1 X168.694 Y128.087 E.24978
G1 X168.93 Y128.887
M73 P81 R9
G1 X179.571 Y139.527 E.24435
G1 X179.571 Y140.091
G1 X169.018 Y129.538 E.24234
G1 X169.024 Y130.108
G1 X179.571 Y140.655 E.2422
G1 X179.571 Y141.218
G1 X168.99 Y130.638 E.24297
G1 X168.907 Y131.118
G1 X179.571 Y141.782 E.24488
G1 X179.571 Y142.346
G1 X168.785 Y131.56 E.24769
G1 X168.63 Y131.969
G1 X179.571 Y142.909 E.25124
G1 X179.571 Y143.473
G1 X168.441 Y132.343 E.25559
G1 X168.225 Y132.69
G1 X179.571 Y144.036 E.26055
G1 X179.542 Y144.571
G1 X167.983 Y133.012 E.26544
G1 X167.714 Y133.306
G1 X178.978 Y144.571 E.25867
G1 X178.415 Y144.571
G1 X167.411 Y133.567 E.25269
G1 X167.078 Y133.798
G1 X177.851 Y144.571 E.24739
G1 X177.287 Y144.571
G1 X166.712 Y133.996 E.24285
G1 X166.306 Y134.153
G1 X176.724 Y144.571 E.23923
G1 X176.16 Y144.571
G1 X165.859 Y134.27 E.23656
G1 X165.394 Y134.369
G1 X175.597 Y144.571 E.23428
G1 X175.033 Y144.571
G1 X164.896 Y134.434 E.23278
G1 X164.391 Y134.492
G1 X174.469 Y144.571 E.23144
G1 X173.906 Y144.571
G1 X163.859 Y134.524 E.2307
G1 X163.322 Y134.551
G1 X173.342 Y144.571 E.2301
G1 X172.778 Y144.571
G1 X162.773 Y134.566 E.22976
G1 X162.214 Y134.57
G1 X172.215 Y144.571 E.22966
G1 X171.651 Y144.571
G1 X161.65 Y134.57 E.22966
G1 X161.087 Y134.57
G1 X171.088 Y144.571 E.22966
G1 X170.524 Y144.571
G1 X160.523 Y134.57 E.22966
G1 X159.96 Y134.57
G1 X169.96 Y144.571 E.22966
G1 X169.397 Y144.571
G1 X159.396 Y134.57 E.22966
G1 X158.832 Y134.57
G1 X168.833 Y144.571 E.22966
G1 X168.27 Y144.571
G1 X167.57 Y143.871 E.01607
G1 X167.429 Y143.73
G1 X158.269 Y134.57 E.21035
G1 X157.705 Y134.57
G1 X166.865 Y143.73 E.21035
G1 X166.302 Y143.73
G1 X157.142 Y134.57 E.21035
G1 X156.578 Y134.57
G1 X165.738 Y143.73 E.21035
G1 X165.174 Y143.73
G1 X156.014 Y134.57 E.21035
G1 X155.451 Y134.57
G1 X164.611 Y143.73 E.21035
; WIPE_START
M204 S3000
G1 X163.197 Y142.316 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.688 Y134.831 Z2 F30000
G1 X166.475 Y125.868 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X164.923 Y124.316 E.03564
G1 X164.595 Y124.552
G1 X165.611 Y125.568 E.02333
G1 X164.864 Y125.385
G1 X164.268 Y124.788 E.0137
; WIPE_START
M204 S3000
G1 X164.864 Y125.385 E-.32062
G1 X165.611 Y125.568 E-.29215
G1 X165.337 Y125.294 E-.14722
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.032 Y122.989 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X157.946 Y117.903 E.11679
G1 X157.946 Y118.467
G1 X162.793 Y123.313 E.1113
G1 X162.544 Y123.627
G1 X157.946 Y119.03 E.10557
G1 X157.946 Y119.594
G1 X162.278 Y123.926 E.09948
G1 X161.984 Y124.195
G1 X157.946 Y120.158 E.09273
G1 X157.946 Y120.721
G1 X161.658 Y124.433 E.08523
G1 X161.291 Y124.63
G1 X157.946 Y121.285 E.07681
G1 X157.946 Y121.848
G1 X160.873 Y124.775 E.0672
G1 X160.402 Y124.867
G1 X157.946 Y122.412 E.05638
G1 X157.946 Y122.976
G1 X159.889 Y124.918 E.04461
G1 X159.347 Y124.939
G1 X157.946 Y123.539 E.03215
G1 X157.946 Y124.103
G1 X158.788 Y124.944 E.01933
; WIPE_START
M204 S3000
G1 X157.946 Y124.103 E-.45227
G1 X157.946 Y123.539 E-.21417
G1 X158.121 Y123.713 E-.09355
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.172 Y121.892 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X150.837 Y117.557 E.09955
G1 X150.837 Y118.121
G1 X155.172 Y122.456 E.09955
G1 X155.172 Y123.019
G1 X150.837 Y118.684 E.09955
G1 X150.837 Y119.248
G1 X155.172 Y123.583 E.09955
G1 X155.172 Y124.147
G1 X150.837 Y119.812 E.09955
G1 X150.837 Y120.375
G1 X155.172 Y124.71 E.09955
G1 X155.172 Y125.274
G1 X150.837 Y120.939 E.09955
G1 X150.837 Y121.502
G1 X155.172 Y125.837 E.09955
G1 X155.172 Y126.401
G1 X150.837 Y122.066 E.09955
G1 X150.837 Y122.63
G1 X155.172 Y126.965 E.09955
G1 X155.172 Y127.528
G1 X150.837 Y123.193 E.09955
G1 X150.837 Y123.757
G1 X155.172 Y128.092 E.09955
G1 X155.172 Y128.655
G1 X150.837 Y124.321 E.09955
G1 X150.837 Y124.884
G1 X155.172 Y129.219 E.09955
G1 X155.172 Y129.783
G1 X150.837 Y125.448 E.09955
G1 X150.837 Y126.011
G1 X155.172 Y130.346 E.09955
G1 X155.172 Y130.91
G1 X150.837 Y126.575 E.09955
G1 X150.837 Y127.139
G1 X155.172 Y131.473 E.09955
G1 X155.172 Y132.037
G1 X150.837 Y127.702 E.09955
G1 X150.837 Y128.266
G1 X155.172 Y132.601 E.09955
G1 X155.172 Y133.164
G1 X150.837 Y128.829 E.09955
G1 X150.837 Y129.393
G1 X155.172 Y133.728 E.09955
G1 X155.172 Y134.291
G1 X150.837 Y129.957 E.09955
G1 X150.837 Y130.52
G1 X164.047 Y143.73 E.30335
M73 P82 R9
G1 X163.484 Y143.73
G1 X150.837 Y131.084 E.29041
G1 X150.837 Y131.647
G1 X162.92 Y143.73 E.27747
G1 X162.43 Y143.804
G1 X150.837 Y132.211 E.26622
G1 X150.837 Y132.775
G1 X162.43 Y144.367 E.26622
G1 X162.07 Y144.571
G1 X150.837 Y133.338 E.25795
G1 X150.837 Y133.902
G1 X161.506 Y144.571 E.245
G1 X160.943 Y144.571
G1 X150.837 Y134.465 E.23206
G1 X150.378 Y134.57
G1 X160.379 Y144.571 E.22966
G1 X159.816 Y144.571
G1 X149.815 Y134.57 E.22966
G1 X149.251 Y134.57
G1 X159.252 Y144.571 E.22966
G1 X158.688 Y144.571
G1 X148.687 Y134.57 E.22966
G1 X148.124 Y134.57
G1 X158.125 Y144.571 E.22966
; WIPE_START
M204 S3000
G1 X156.71 Y143.157 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X153.997 Y136.023 Z2 F30000
G1 X148.063 Y120.419 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X145.15 Y117.506 E.0669
G1 X144.989 Y117.908
G1 X148.063 Y120.983 E.0706
G1 X148.063 Y121.546
G1 X144.828 Y118.311 E.0743
G1 X144.667 Y118.713
G1 X148.063 Y122.11 E.078
G1 X148.063 Y122.673
G1 X144.505 Y119.116 E.0817
G1 X144.344 Y119.518
G1 X148.063 Y123.237 E.0854
G1 X148.063 Y123.801
G1 X144.183 Y119.921 E.0891
G1 X144.022 Y120.323
G1 X148.063 Y124.364 E.0928
G1 X148.063 Y124.928
G1 X143.861 Y120.726 E.0965
G1 X143.7 Y121.128
G1 X148.063 Y125.492 E.1002
G1 X148.063 Y126.055
G1 X143.538 Y121.531 E.1039
G1 X143.377 Y121.933
G1 X148.063 Y126.619 E.1076
G1 X148.063 Y127.182
G1 X143.216 Y122.335 E.1113
G1 X143.055 Y122.738
G1 X148.063 Y127.746 E.115
G1 X148.063 Y128.31
G1 X142.894 Y123.14 E.11871
G1 X142.733 Y123.543
G1 X148.063 Y128.873 E.12241
G1 X148.063 Y129.437
G1 X142.572 Y123.945 E.12611
G1 X142.41 Y124.348
G1 X148.063 Y130 E.12981
G1 X148.063 Y130.564
G1 X142.249 Y124.75 E.13351
G1 X142.088 Y125.153
G1 X148.063 Y131.128 E.13721
G1 X148.063 Y131.691
G1 X141.927 Y125.555 E.14091
G1 X141.766 Y125.958
G1 X148.063 Y132.255 E.14461
G1 X148.063 Y132.818
G1 X141.605 Y126.36 E.14831
G1 X141.444 Y126.762
G1 X148.063 Y133.382 E.15201
G1 X148.063 Y133.946
G1 X141.282 Y127.165 E.15571
G1 X141.121 Y127.567
G1 X148.063 Y134.509 E.15941
; WIPE_START
M204 S3000
G1 X146.649 Y133.095 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.978 Y127.986 Z2 F30000
G1 X140.96 Y127.97 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X157.561 Y144.571 E.38122
G1 X156.997 Y144.571
G1 X140.799 Y128.372 E.37198
G1 X140.638 Y128.775
G1 X156.434 Y144.571 E.36274
G1 X155.87 Y144.571
G1 X140.477 Y129.177 E.3535
G1 X140.316 Y129.58
G1 X155.307 Y144.571 E.34426
G1 X154.743 Y144.571
G1 X140.154 Y129.982 E.33501
G1 X139.993 Y130.385
G1 X154.179 Y144.571 E.32577
G1 X153.616 Y144.571
G1 X139.832 Y130.787 E.31653
G1 X139.671 Y131.19
G1 X153.052 Y144.571 E.30729
G1 X152.489 Y144.571
G1 X139.51 Y131.592 E.29805
G1 X139.349 Y131.994
G1 X151.084 Y143.73 E.2695
G1 X150.521 Y143.73
G1 X139.187 Y132.397 E.26025
G1 X139.026 Y132.799
G1 X149.957 Y143.73 E.25101
G1 X149.393 Y143.73
G1 X138.865 Y133.202 E.24177
G1 X138.704 Y133.604
G1 X148.83 Y143.73 E.23253
G1 X148.266 Y143.73
G1 X138.543 Y134.007 E.22329
G1 X138.382 Y134.409
G1 X147.703 Y143.73 E.21404
G1 X147.139 Y143.73
G1 X137.979 Y134.57 E.21035
G1 X137.415 Y134.57
G1 X146.575 Y143.73 E.21035
G1 X146.43 Y144.148
G1 X136.852 Y134.57 E.21996
G1 X136.288 Y134.57
G1 X146.289 Y144.571 E.22966
G1 X145.725 Y144.571
G1 X135.724 Y134.57 E.22966
G1 X135.161 Y134.57
G1 X145.162 Y144.571 E.22966
G1 X144.598 Y144.571
G1 X119.257 Y119.23 E.58192
G1 X119.257 Y119.794
G1 X144.035 Y144.571 E.56898
G1 X143.471 Y144.571
G1 X119.257 Y120.357 E.55604
G1 X119.257 Y120.921
G1 X142.907 Y144.571 E.54309
G1 X142.344 Y144.571
G1 X119.257 Y121.485 E.53015
G1 X119.257 Y122.048
G1 X141.78 Y144.571 E.51721
G1 X141.216 Y144.571
G1 X119.257 Y122.612 E.50427
G1 X119.257 Y123.175
G1 X140.653 Y144.571 E.49132
G1 X140.089 Y144.571
G1 X119.257 Y123.739 E.47838
G1 X119.257 Y124.303
G1 X139.526 Y144.571 E.46544
G1 X138.962 Y144.571
G1 X119.257 Y124.866 E.4525
G1 X119.257 Y125.43
G1 X138.398 Y144.571 E.43955
G1 X137.835 Y144.571
G1 X119.257 Y125.993 E.42661
G1 X119.257 Y126.557
G1 X137.271 Y144.571 E.41367
G1 X136.708 Y144.571
G1 X119.257 Y127.121 E.40072
G1 X119.257 Y127.684
G1 X136.144 Y144.571 E.38778
G1 X135.58 Y144.571
G1 X119.257 Y128.248 E.37484
G1 X119.257 Y128.812
G1 X135.017 Y144.571 E.3619
G1 X134.453 Y144.571
G1 X119.257 Y129.375 E.34895
G1 X119.257 Y129.939
G1 X133.89 Y144.571 E.33601
G1 X133.326 Y144.571
G1 X119.257 Y130.502 E.32307
G1 X119.257 Y131.066
G1 X132.762 Y144.571 E.31013
G1 X132.199 Y144.571
G1 X119.257 Y131.63 E.29718
G1 X119.257 Y132.193
G1 X131.635 Y144.571 E.28424
G1 X131.072 Y144.571
G1 X119.257 Y132.757 E.2713
G1 X119.257 Y133.32
G1 X130.508 Y144.571 E.25836
G1 X129.944 Y144.571
G1 X119.257 Y133.884 E.24541
G1 X119.257 Y134.448
G1 X129.381 Y144.571 E.23247
G1 X128.817 Y144.571
G1 X118.816 Y134.57 E.22966
G1 X118.253 Y134.57
G1 X128.254 Y144.571 E.22966
G1 X127.69 Y144.571
G1 X117.689 Y134.57 E.22966
G1 X117.125 Y134.57
G1 X127.126 Y144.571 E.22966
; WIPE_START
M204 S3000
G1 X125.712 Y143.157 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.39 Y136.285 Z2 F30000
G1 X116.741 Y124.604 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
M73 P82 R8
G1 X115.772 Y123.636 E.02225
G1 X115.33 Y123.757
G1 X116.741 Y125.168 E.0324
G1 X116.741 Y125.732
G1 X115.116 Y124.106 E.03732
G1 X114.902 Y124.456
G1 X116.741 Y126.295 E.04224
G1 X116.741 Y126.859
G1 X114.688 Y124.805 E.04715
G1 X114.474 Y125.155
G1 X116.741 Y127.422 E.05207
G1 X116.741 Y127.986
G1 X114.259 Y125.504 E.05699
G1 X114.045 Y125.854
G1 X116.741 Y128.55 E.06191
G1 X116.741 Y129.113
G1 X113.831 Y126.203 E.06683
G1 X113.617 Y126.553
G1 X116.741 Y129.677 E.07175
G1 X116.741 Y130.24
G1 X113.403 Y126.902 E.07666
G1 X113.189 Y127.251
G1 X116.741 Y130.804 E.08158
G1 X116.741 Y131.368
G1 X112.974 Y127.601 E.0865
G1 X112.76 Y127.95
G1 X116.741 Y131.931 E.09142
G1 X116.741 Y132.495
G1 X112.546 Y128.3 E.09634
G1 X112.332 Y128.649
G1 X116.741 Y133.058 E.10125
G1 X116.741 Y133.622
G1 X112.118 Y128.999 E.10617
G1 X111.904 Y129.348
G1 X116.741 Y134.186 E.11109
; WIPE_START
M204 S3000
G1 X115.327 Y132.771 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.689 Y129.698 Z2 F30000
G1 Z1.6
G1 E.8 F1800
M73 P83 R8
G1 F2700
M204 S2000
G1 X126.563 Y144.571 E.34155
G1 X125.999 Y144.571
G1 X111.475 Y130.047 E.33353
G1 X111.261 Y130.396
G1 X125.436 Y144.571 E.3255
G1 X124.872 Y144.571
G1 X111.047 Y130.746 E.31748
G1 X110.833 Y131.095
G1 X124.308 Y144.571 E.30945
G1 X123.745 Y144.571
G1 X110.619 Y131.445 E.30143
G1 X110.404 Y131.794
G1 X123.181 Y144.571 E.2934
G1 X122.617 Y144.571
G1 X110.19 Y132.144 E.28538
G1 X109.976 Y132.493
G1 X122.054 Y144.571 E.27735
G1 X121.49 Y144.571
G1 X109.762 Y132.842 E.26933
G1 X109.548 Y133.192
G1 X120.927 Y144.571 E.2613
G1 X120.363 Y144.571
G1 X109.334 Y133.541 E.25328
G1 X109.119 Y133.891
G1 X119.799 Y144.571 E.24526
G1 X119.236 Y144.571
G1 X108.905 Y134.24 E.23723
G1 X108.671 Y134.57
G1 X118.672 Y144.571 E.22966
G1 X118.109 Y144.571
G1 X108.108 Y134.57 E.22966
G1 X107.544 Y134.57
G1 X117.545 Y144.571 E.22966
G1 X116.981 Y144.571
G1 X106.981 Y134.57 E.22966
G1 X106.417 Y134.57
G1 X116.418 Y144.571 E.22966
G1 X115.854 Y144.571
G1 X105.853 Y134.57 E.22966
; WIPE_START
M204 S3000
G1 X107.268 Y135.984 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.038 Y128.355 Z2 F30000
G1 X106.43 Y108.094 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X105.766 Y107.429 E.01526
G1 X105.202 Y107.429
G1 X115.869 Y118.096 E.24495
G1 X115.654 Y118.444
G1 X104.638 Y107.429 E.25295
G1 X104.075 Y107.429
G1 X115.438 Y118.793 E.26095
G1 X115.223 Y119.141
G1 X103.511 Y107.429 E.26895
G1 X102.948 Y107.429
G1 X115.008 Y119.489 E.27695
G1 X114.792 Y119.838
G1 X102.384 Y107.429 E.28495
G1 X101.82 Y107.429
G1 X114.577 Y120.186 E.29294
G1 X114.362 Y120.534
G1 X101.257 Y107.429 E.30094
G1 X100.693 Y107.429
G1 X114.146 Y120.882 E.30894
G1 X113.931 Y121.231
G1 X100.13 Y107.429 E.31694
G1 X99.566 Y107.429
G1 X113.716 Y121.579 E.32494
G1 X113.5 Y121.927
G1 X99.002 Y107.429 E.33293
G1 X98.439 Y107.429
G1 X113.285 Y122.276 E.34093
G1 X113.07 Y122.624
G1 X108.354 Y117.908 E.10829
G1 X108.354 Y118.472
G1 X112.855 Y122.972 E.10334
G1 X112.639 Y123.32
G1 X108.354 Y119.036 E.0984
G1 X108.354 Y119.599
G1 X112.424 Y123.669 E.09345
G1 X112.209 Y124.017
G1 X108.354 Y120.163 E.08851
G1 X108.354 Y120.726
G1 X111.993 Y124.365 E.08356
G1 X111.778 Y124.714
G1 X108.354 Y121.29 E.07862
G1 X108.354 Y121.854
G1 X111.563 Y125.062 E.07368
G1 X111.347 Y125.41
G1 X108.354 Y122.417 E.06873
G1 X108.354 Y122.981
G1 X111.132 Y125.758 E.06379
G1 X110.917 Y126.107
G1 X108.354 Y123.544 E.05884
G1 X108.354 Y124.108
G1 X110.701 Y126.455 E.0539
G1 X110.486 Y126.803
G1 X108.354 Y124.672 E.04895
G1 X108.354 Y125.235
G1 X110.271 Y127.152 E.04401
G1 X110.055 Y127.5
G1 X108.354 Y125.799 E.03906
G1 X108.354 Y126.362
G1 X109.84 Y127.848 E.03412
G1 X109.602 Y128.174
G1 X108.354 Y126.926 E.02865
G1 X108.354 Y127.49
G1 X108.815 Y127.95 E.01057
; WIPE_START
M204 S3000
G1 X108.354 Y127.49 E-.24738
G1 X108.354 Y126.926 E-.21417
G1 X108.91 Y127.481 E-.29845
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.129 Y119.889 Z2 F30000
G1 X107.876 Y117.43 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X97.875 Y107.429 E.22966
G1 X97.312 Y107.429
G1 X107.312 Y117.43 E.22966
G1 X106.749 Y117.43
G1 X96.748 Y107.429 E.22966
G1 X96.184 Y107.429
G1 X106.185 Y117.43 E.22966
G1 X105.838 Y117.646
G1 X95.621 Y107.429 E.23463
G1 X95.57 Y107.942
G1 X105.838 Y118.21 E.2358
G1 X105.838 Y118.774
G1 X95.334 Y108.27 E.24121
G1 X94.771 Y108.27
G1 X105.838 Y119.337 E.25415
G1 X105.838 Y119.901
G1 X94.207 Y108.27 E.26709
G1 X93.643 Y108.27
G1 X105.838 Y120.464 E.28003
G1 X105.838 Y121.028
G1 X93.08 Y108.27 E.29298
G1 X92.516 Y108.27
G1 X105.838 Y121.592 E.30592
G1 X105.838 Y122.155
G1 X91.953 Y108.27 E.31886
G1 X91.389 Y108.27
G1 X105.838 Y122.719 E.3318
G1 X105.838 Y123.282
G1 X90.825 Y108.27 E.34475
G1 X89.985 Y107.429
G1 X90.43 Y107.875 E.01023
G1 X89.421 Y107.429
G1 X105.838 Y123.846 E.377
G1 X105.838 Y124.41
G1 X88.857 Y107.429 E.38994
G1 X88.294 Y107.429
G1 X105.838 Y124.973 E.40288
G1 X105.838 Y125.537
G1 X100.372 Y120.071 E.12552
M204 S10000
G1 X101.225 Y121.487 F30000
G1 F2700
M204 S2000
G1 X105.838 Y126.1 E.10594
G1 X105.838 Y126.664
G1 X101.588 Y122.414 E.0976
G1 X101.801 Y123.191
G1 X105.838 Y127.228 E.0927
G1 X105.838 Y127.791
G1 X101.938 Y123.891 E.08956
G1 X102.033 Y124.55
G1 X105.838 Y128.355 E.08739
G1 X105.838 Y128.919
G1 X102.076 Y125.157 E.08639
G1 X102.096 Y125.741
G1 X105.838 Y129.482 E.08592
G1 X105.838 Y130.046
G1 X102.093 Y126.301 E.08599
G1 X102.074 Y126.846
G1 X105.838 Y130.609 E.08643
G1 X105.838 Y131.173
G1 X102.029 Y127.364 E.08746
G1 X101.973 Y127.872
G1 X105.838 Y131.737 E.08875
G1 X105.838 Y132.3
G1 X101.889 Y128.351 E.09069
G1 X101.796 Y128.822
G1 X105.838 Y132.864 E.09281
M73 P84 R8
G1 X105.838 Y133.427
G1 X101.674 Y129.263 E.09562
G1 X101.546 Y129.699
G1 X105.838 Y133.991 E.09856
G1 X105.838 Y134.555
G1 X101.387 Y130.104 E.10221
G1 X101.224 Y130.505
G1 X115.291 Y144.571 E.32301
G1 X114.727 Y144.571
G1 X101.031 Y130.874 E.31452
G1 X100.834 Y131.242
G1 X114.163 Y144.571 E.30609
G1 X113.6 Y144.571
G1 X100.607 Y131.578 E.29837
G1 X100.377 Y131.912
G1 X113.036 Y144.571 E.29069
G1 X112.473 Y144.571
G1 X100.118 Y132.216 E.28372
G1 X99.856 Y132.518
G1 X111.068 Y143.73 E.25747
G1 X110.505 Y143.73
G1 X99.566 Y132.792 E.25118
G1 X99.274 Y133.064
G1 X109.941 Y143.73 E.24495
G1 X109.377 Y143.73
G1 X98.954 Y133.307 E.23935
G1 X98.632 Y133.548
G1 X108.814 Y143.73 E.23382
G1 X108.25 Y143.73
G1 X98.278 Y133.758 E.22899
G1 X97.923 Y133.966
G1 X107.687 Y143.73 E.22422
G1 X107.123 Y143.73
G1 X97.534 Y134.141 E.2202
G1 X97.14 Y134.31
G1 X106.559 Y143.73 E.21631
G1 X106.43 Y144.164
G1 X96.716 Y134.45 E.22308
G1 X96.28 Y134.578
G1 X106.273 Y144.571 E.22949
G1 X105.709 Y144.571
G1 X95.818 Y134.68 E.22714
G1 X95.336 Y134.762
G1 X105.146 Y144.571 E.22526
G1 X104.582 Y144.571
G1 X94.836 Y134.824 E.22381
G1 X94.304 Y134.856
G1 X104.018 Y144.571 E.22309
G1 X103.455 Y144.571
G1 X93.76 Y134.876 E.22263
G1 X93.172 Y134.851
G1 X102.891 Y144.571 E.2232
G1 X102.328 Y144.571
G1 X92.566 Y134.809 E.22416
G1 X91.916 Y134.723
G1 X101.764 Y144.571 E.22615
G1 X101.2 Y144.571
G1 X91.206 Y134.576 E.22952
G1 X90.39 Y134.324
G1 X100.637 Y144.571 E.23531
G1 X100.073 Y144.571
G1 X89.309 Y133.806 E.24719
; WIPE_START
M204 S3000
G1 X90.723 Y135.221 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.127 Y128.389 Z2 F30000
G1 X98.97 Y118.669 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X87.73 Y107.429 E.2581
G1 X87.167 Y107.429
G1 X97.597 Y117.859 E.23952
G1 X96.704 Y117.53
G1 X86.603 Y107.429 E.23196
G1 X86.039 Y107.429
G1 X95.944 Y117.334 E.22744
G1 X95.263 Y117.216
G1 X85.476 Y107.429 E.22475
G1 X84.912 Y107.429
G1 X94.646 Y117.163 E.22352
G1 X94.051 Y117.132
G1 X84.349 Y107.429 E.2228
G1 X83.785 Y107.429
G1 X93.488 Y117.132 E.22282
G1 X92.956 Y117.164
G1 X83.221 Y107.429 E.22355
G1 X82.658 Y107.429
G1 X92.435 Y117.206 E.22452
G1 X91.953 Y117.288
G1 X82.094 Y107.429 E.2264
G1 X81.531 Y107.429
G1 X91.479 Y117.378 E.22846
G1 X91.036 Y117.498
G1 X80.967 Y107.429 E.23121
G1 X80.403 Y107.429
G1 X90.606 Y117.632 E.23429
G1 X90.199 Y117.788
G1 X79.84 Y107.429 E.23788
G1 X79.276 Y107.429
G1 X89.81 Y117.963 E.24189
G1 X89.437 Y118.154
G1 X78.713 Y107.429 E.24628
G1 X78.149 Y107.429
G1 X89.086 Y118.366 E.25115
G1 X88.746 Y118.59
G1 X77.585 Y107.429 E.2563
G1 X77.022 Y107.429
G1 X88.43 Y118.837 E.26197
G1 X88.122 Y119.093
G1 X76.458 Y107.429 E.26785
G1 X76.429 Y107.964
G1 X87.831 Y119.366 E.26184
G1 X87.563 Y119.662
G1 X76.429 Y108.527 E.25569
G1 X76.429 Y109.091
G1 X87.302 Y119.964 E.24968
G1 X87.063 Y120.289
G1 X76.429 Y109.655 E.2442
G1 X76.429 Y110.218
G1 X86.833 Y120.622 E.23892
G1 X86.628 Y120.981
G1 X76.429 Y110.782 E.2342
G1 X76.429 Y111.345
G1 X86.431 Y121.347 E.22968
G1 X86.26 Y121.74
G1 X76.429 Y111.909 E.22576
G1 X76.429 Y112.473
G1 X86.096 Y122.14 E.222
G1 X85.963 Y122.57
G1 X76.429 Y113.036 E.21892
G1 X76.429 Y113.6
G1 X85.833 Y123.004 E.21596
G1 X85.739 Y123.474
G1 X76.429 Y114.163 E.2138
G1 X76.429 Y114.727
G1 X85.647 Y123.945 E.21169
G1 X85.588 Y124.45
G1 X76.429 Y115.291 E.21033
G1 X76.429 Y115.854
G1 X77.005 Y116.43 E.01322
G1 X77.27 Y116.695
M73 P84 R7
G1 X85.538 Y124.963 E.18987
G1 X85.519 Y125.507
G1 X77.27 Y117.259 E.18942
G1 X77.27 Y117.822
G1 X85.508 Y126.061 E.18919
G1 X85.523 Y126.639
G1 X77.27 Y118.386 E.18953
G1 X77.27 Y118.949
G1 X85.562 Y127.242 E.19042
G1 X85.633 Y127.876
G1 X77.27 Y119.513 E.19205
G1 X77.27 Y120.077
G1 X85.748 Y128.554 E.19468
G1 X85.923 Y129.294
G1 X77.27 Y120.64 E.19872
G1 X77.27 Y121.204
G1 X86.22 Y130.154 E.20552
M204 S10000
G1 X86.833 Y131.331 F30000
G1 F2700
M204 S2000
G1 X77.072 Y121.57 E.22414
G1 X76.509 Y121.57
G1 X99.51 Y144.571 E.52819
G1 X98.946 Y144.571
G1 X76.429 Y122.054 E.51708
G1 X76.429 Y122.618
G1 X98.382 Y144.571 E.50413
G1 X97.819 Y144.571
G1 X76.429 Y123.181 E.49119
G1 X76.429 Y123.745
G1 X97.255 Y144.571 E.47825
G1 X96.692 Y144.571
G1 X76.429 Y124.308 E.46531
G1 X76.429 Y124.872
G1 X95.287 Y143.73 E.43306
G1 X94.724 Y143.73
G1 X76.429 Y125.436 E.42011
G1 X76.429 Y125.999
G1 X94.16 Y143.73 E.40717
G1 X93.596 Y143.73
G1 X76.429 Y126.563 E.39423
G1 X76.429 Y127.126
G1 X93.033 Y143.73 E.38129
G1 X92.469 Y143.73
G1 X76.429 Y127.69 E.36834
G1 X76.429 Y128.254
G1 X91.906 Y143.73 E.3554
G1 X91.342 Y143.73
G1 X76.429 Y128.817 E.34246
G1 X76.429 Y129.381
G1 X90.778 Y143.73 E.32951
G1 X90.43 Y143.945
G1 X76.429 Y129.944 E.32152
G1 X76.429 Y130.508
G1 X90.43 Y144.509 E.32152
G1 X89.928 Y144.571
G1 X77.27 Y131.912 E.29069
G1 X77.27 Y132.476
G1 X89.365 Y144.571 E.27774
G1 X88.801 Y144.571
G1 X77.27 Y133.04 E.2648
G1 X77.27 Y133.603
G1 X88.237 Y144.571 E.25186
G1 X87.674 Y144.571
G1 X77.27 Y134.167 E.23892
G1 X77.27 Y134.73
G1 X87.11 Y144.571 E.22597
G1 X86.547 Y144.571
G1 X77.27 Y135.294 E.21303
G1 X77.27 Y135.858
G1 X85.983 Y144.571 E.20009
G1 X85.419 Y144.571
G1 X77.27 Y136.421 E.18715
M73 P85 R7
G1 X76.855 Y136.57
G1 X84.856 Y144.571 E.18373
G1 X84.292 Y144.571
G1 X76.429 Y136.708 E.18057
G1 X76.429 Y137.271
G1 X83.729 Y144.571 E.16763
G1 X83.165 Y144.571
G1 X76.429 Y137.835 E.15468
G1 X76.429 Y138.399
G1 X82.601 Y144.571 E.14174
G1 X82.038 Y144.571
G1 X76.429 Y138.962 E.1288
G1 X76.429 Y139.526
G1 X81.474 Y144.571 E.11585
G1 X80.911 Y144.571
G1 X76.429 Y140.089 E.10291
G1 X76.429 Y140.653
G1 X80.347 Y144.571 E.08997
G1 X79.783 Y144.571
G1 X76.429 Y141.217 E.07703
; WIPE_START
M204 S3000
G1 X77.843 Y142.631 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.453 Y143.224 Z2 F30000
G1 X95.57 Y144.013 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X96.128 Y144.571 E.01282
; WIPE_START
M204 S3000
G1 X95.57 Y144.013 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.942 Y144.285 Z2 F30000
G1 X79.345 Y144.591 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.270249
G1 F3600
M204 S3000
G1 X76.409 Y141.655 E.04209
; WIPE_START
G1 X77.823 Y143.069 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.44 Y142.579 Z2 F30000
G1 X178.867 Y136.57 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.148585
G1 F3600
M204 S3000
G1 X178.727 Y136.614 E.00076
G1 X178.686 Y136.573 E.0003
G1 X178.73 Y136.433 E.00076
; WIPE_START
G1 X178.686 Y136.573 E-.31723
G1 X178.727 Y136.614 E-.12551
G1 X178.867 Y136.57 E-.31725
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.54 Y131.45 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.128042
G1 F3600
M204 S3000
G1 X179.54 Y131.254 E.00085
G1 X179.497 Y131.148 E.0005
; WIPE_START
G1 X179.54 Y131.254 E-.28014
G1 X179.54 Y131.45 E-.47986
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X176.143 Y124.615 Z2 F30000
G1 X167.592 Y107.409 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.105098
G1 F3600
M204 S3000
G1 X167.592 Y107.778 E.00126
; WIPE_START
G1 X167.592 Y107.409 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.254 Y109.508 Z2 F30000
G1 X86.438 Y130.625 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0940941
G1 F3600
M204 S3000
G1 X86.34 Y130.49 E.00049
; LINE_WIDTH: 0.143731
G1 X86.243 Y130.354 E.00083
; LINE_WIDTH: 0.169664
G1 X86.151 Y130.222 E.00097
M204 S10000
G1 X87.468 Y132.215 F30000
; LINE_WIDTH: 0.0714827
G1 F3600
M204 S3000
G1 X87.399 Y132.141 E.00021
; LINE_WIDTH: 0.0909008
G1 X87.244 Y131.962 E.00067
; LINE_WIDTH: 0.125074
G1 X87.089 Y131.783 E.001
; LINE_WIDTH: 0.159752
G1 X86.93 Y131.599 E.00137
; LINE_WIDTH: 0.196514
G1 X86.769 Y131.395 E.00185
M204 S10000
G1 X89.245 Y133.871 F30000
; LINE_WIDTH: 0.197221
G1 F3600
M204 S3000
G1 X89.078 Y133.739 E.00152
; LINE_WIDTH: 0.159382
G1 X88.907 Y133.603 E.00123
; LINE_WIDTH: 0.122449
G1 X88.688 Y133.41 E.0012
; LINE_WIDTH: 0.087009
G1 X88.469 Y133.217 E.00078
M204 S10000
G1 X90.319 Y134.394 F30000
; LINE_WIDTH: 0.0996353
G1 F3600
M204 S3000
G3 X89.957 Y134.145 I6.132 J-9.28 E.0014
; WIPE_START
G1 X90.319 Y134.394 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.317 Y129.674 Z2 F30000
G1 X102.151 Y125.082 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.102339
G1 F3600
M204 S3000
G1 X102.042 Y124.841 E.00087
M204 S10000
G1 X101.29 Y121.422 F30000
; LINE_WIDTH: 0.183954
G1 F3600
M204 S3000
G1 X101.209 Y121.307 E.00093
; LINE_WIDTH: 0.145844
G1 X101.129 Y121.192 E.00071
; LINE_WIDTH: 0.107242
G1 X101.046 Y121.074 E.0005
; LINE_WIDTH: 0.0784554
G1 X100.984 Y120.995 E.00023
M204 S10000
G1 X100.436 Y120.007 F30000
; LINE_WIDTH: 0.207116
G1 F3600
M204 S3000
G2 X100.171 Y119.706 I-5.587 J4.642 E.00304
; LINE_WIDTH: 0.180017
G2 X99.604 Y119.128 I-10.848 J10.074 E.00523
; LINE_WIDTH: 0.187099
G1 X99.318 Y118.866 E.00261
; LINE_WIDTH: 0.216388
G1 X99.033 Y118.605 E.00307
M204 S10000
G1 X98.118 Y118.127 F30000
; LINE_WIDTH: 0.0921021
G1 F3600
M204 S3000
G1 X97.966 Y118.016 E.00054
; LINE_WIDTH: 0.137741
G1 X97.814 Y117.905 E.00089
; LINE_WIDTH: 0.18338
G1 X97.662 Y117.794 E.00124
; WIPE_START
G1 X97.814 Y117.905 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.667 Y117.284 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0877471
G1 F3600
M204 S3000
G2 X91.511 Y117.372 I1.601 J3.056 E.00048
; WIPE_START
G1 X91.667 Y117.284 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.3 Y117.319 Z2 F30000
G1 X150.843 Y117.551 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.146437
G1 F3600
M204 S3000
G1 X150.879 Y117.416 E.00071
G1 X150.851 Y117.388 E.0002
G1 X150.716 Y117.424 E.00071
; WIPE_START
G1 X150.851 Y117.388 E-.33279
G1 X150.879 Y117.416 E-.09442
G1 X150.843 Y117.551 E-.33279
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.475 Y117.469 Z2 F30000
G1 X169.958 Y117.345 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0717588
G1 F3600
M204 S3000
G1 X170.12 Y117.428 E.00037
G1 X170.141 Y117.458 E.00008
G1 X170.097 Y117.514 E.00015
; WIPE_START
G1 X170.141 Y117.458 E-.18599
G1 X170.12 Y117.428 E-.09637
G1 X169.958 Y117.345 E-.47764
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.5 Y124.571 Z2 F30000
G1 X166.975 Y126.115 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0893443
G1 F3600
M204 S3000
G1 X166.862 Y126.032 E.00039
; LINE_WIDTH: 0.129449
G1 X166.748 Y125.949 E.00062
; LINE_WIDTH: 0.180948
G1 X166.541 Y125.802 E.00165
M204 S10000
G1 X164.147 Y124.877 F30000
; LINE_WIDTH: 0.0714761
G1 F3600
M204 S3000
G1 X164.108 Y124.911 E.0001
; LINE_WIDTH: 0.0915055
G1 X164.051 Y125.051 E.00043
; LINE_WIDTH: 0.12717
G1 X163.994 Y125.192 E.00065
; WIPE_START
G1 X164.051 Y125.051 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.309 Y132.679 Z2 F30000
G1 X164.37 Y134.492 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.103547
G1 F3600
M204 S3000
G1 X164.192 Y134.575 E.00066
M204 S10000
G1 X165.367 Y134.372 F30000
; LINE_WIDTH: 0.0856927
G1 F3600
M204 S3000
G3 X165.202 Y134.458 I-1.904 J-3.444 E.00049
; WIPE_START
G1 X165.367 Y134.372 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X169.086 Y129.325 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0787109
G1 F3600
M204 S3000
G1 X169.001 Y129.555 E.00057
M204 S10000
G1 X168.763 Y128.018 F30000
; LINE_WIDTH: 0.157358
G1 F3600
M204 S3000
G1 X168.65 Y127.857 E.00109
; LINE_WIDTH: 0.134474
G1 X168.556 Y127.729 E.00073
; LINE_WIDTH: 0.0910173
G1 X168.461 Y127.602 E.00045
; WIPE_START
G1 X168.556 Y127.729 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.949 Y127.106 Z2 F30000
G1 X98.335 Y121.979 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X96.342 Y119.986 E.04578
G1 X95.379 Y119.586
G1 X98.762 Y122.97 E.0777
G1 X98.979 Y123.751
G1 X94.664 Y119.435 E.09911
G1 X94.044 Y119.379
G1 X99.1 Y124.435 E.1161
G1 X99.166 Y125.064
G1 X93.486 Y119.384 E.13044
G1 X92.973 Y119.435
G1 X99.196 Y125.659 E.14291
G1 X99.203 Y126.229
G1 X92.499 Y119.525 E.15394
G1 X92.06 Y119.65
G1 X99.188 Y126.777 E.16367
G1 X99.144 Y127.297
G1 X91.651 Y119.804 E.17206
G1 X91.278 Y119.994
G1 X99.082 Y127.798 E.17921
G1 X99 Y128.281
G1 X90.929 Y120.209 E.18535
G1 X90.602 Y120.446
G1 X98.889 Y128.733 E.1903
G1 X98.755 Y129.163
G1 X90.294 Y120.702 E.1943
G1 X90.014 Y120.985
G1 X98.602 Y129.573 E.19721
G1 X98.424 Y129.958
G1 X89.754 Y121.288 E.1991
G1 X89.51 Y121.609
G1 X98.216 Y130.315 E.19993
G1 X97.989 Y130.651
G1 X89.295 Y121.957 E.19965
G1 X89.104 Y122.33
G1 X97.741 Y130.966 E.19833
G1 X97.46 Y131.25
G1 X88.932 Y122.721 E.19585
G1 X88.784 Y123.136
G1 X97.161 Y131.513 E.19237
G1 X96.84 Y131.757
G1 X88.664 Y123.58 E.18777
G1 X88.563 Y124.043
G1 X96.497 Y131.977 E.1822
G1 X96.119 Y132.163
G1 X88.481 Y124.525 E.1754
G1 X88.432 Y125.039
G1 X95.715 Y132.322 E.16725
G1 X95.281 Y132.452
G1 X88.403 Y125.573 E.15796
G1 X88.393 Y126.127
G1 X94.815 Y132.549 E.14747
G1 X94.312 Y132.61
G1 X88.41 Y126.707 E.13554
G1 X88.461 Y127.322
G1 X93.767 Y132.629 E.12186
G1 X93.172 Y132.597
G1 X88.554 Y127.979 E.10605
G1 X88.715 Y128.703
G1 X92.497 Y132.486 E.08686
G1 X91.682 Y132.234
G1 X89.015 Y129.567 E.06125
; WIPE_START
M204 S3000
G1 X90.429 Y130.981 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.45 Y123.972 Z2 F30000
G1 X95.31 Y119.655 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0758378
G1 F3600
M204 S3000
G1 X95.031 Y119.496 E.00071
M204 S10000
G1 X91.219 Y120.024 F30000
; LINE_WIDTH: 0.0784855
G1 F3600
M204 S3000
G2 X91.111 Y120.109 I.704 J1.006 E.00032
; WIPE_START
G1 X91.219 Y120.024 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.539 Y127.47 Z2 F30000
G1 X89.08 Y129.502 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.201504
G1 F3600
M204 S3000
G1 X88.841 Y129.16 E.00306
M204 S10000
G1 X91.054 Y131.918 F30000
; LINE_WIDTH: 0.0913949
G1 F3600
M204 S3000
G1 X90.883 Y131.781 E.00062
; LINE_WIDTH: 0.135629
G1 X90.713 Y131.644 E.00102
; LINE_WIDTH: 0.17149
G1 X90.513 Y131.464 E.00164
; LINE_WIDTH: 0.207227
G3 X89.928 Y130.895 I4.984 J-5.722 E.00618
; LINE_WIDTH: 0.193059
G1 X89.74 Y130.684 E.00198
; LINE_WIDTH: 0.159479
G1 X89.552 Y130.472 E.00159
; LINE_WIDTH: 0.124335
G1 X89.45 Y130.342 E.0007
; LINE_WIDTH: 0.0876284
G1 X89.347 Y130.211 E.00045
; WIPE_START
G1 X89.45 Y130.342 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.077 Y130.063 Z2 F30000
G1 X98.397 Y130.014 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0793153
G1 F3600
M204 S3000
G1 X98.31 Y130.126 E.00033
; WIPE_START
G1 X98.397 Y130.014 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.574 Y122.472 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0927601
G1 F3600
M204 S3000
G1 X98.474 Y122.328 E.00051
; LINE_WIDTH: 0.139702
G1 X98.373 Y122.185 E.00084
; LINE_WIDTH: 0.186645
G1 X98.273 Y122.042 E.00118
; CHANGE_LAYER
; Z_HEIGHT: 1.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F3600
G1 X98.373 Y122.185 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/24
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
M204 S10000
G17
G3 Z2 I-1.075 J-.57 P1  F30000
G1 X51.016 Y211.534 Z2
G1 Z1.7
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X51.516 Y212.534  
M204 S3000
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625 F5400
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
G1  X24.150 Y212.668   E0.0379
G1 E-0.8000 F1800
M204 S10000
G1  X22.392 Y210.891   F600
G1 E0.8000 F1800
M204 S3000
G3  X23.029 Y207.819   I1.729 J-1.243 E0.0702 F5400
G2  X24.016 Y204.972   I-3.627 J-2.852 E0.0611
G2  X24.012 Y192.415   I-319.311 J-6.188 E0.2498
G2  X22.184 Y188.727   I-5.574 J0.466 E0.0839
G3  X22.534 Y186.516   I1.728 J-0.860 E0.0475
G1  X24.016 Y185.034   E0.0417
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
M73 P86 R7
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G1  X37.766  E0.1231
G1  X39.016  E0.0249
G2  X44.674 Y184.977   I2.469 J-35.970 E0.1127
G2  X47.959 Y183.140   I-2.287 J-7.942 E0.0756
G3  X50.034 Y183.552   I0.727 J1.768 E0.0446
G1  X51.516 Y185.034   E0.0417
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
; WIPE_TOWER_END
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
;--------------------
; CP TOOLCHANGE START
; toolchange #1
; material : PLA -> PLA
;--------------------
M220 B
M220 S100
; WIPE_TOWER_START
G1 E-2 F1800
G17
G3 Z2.1 I1.217 J0 P1  F5400
; filament end gcode 


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

M620.1 E F299.339 T240
T1
M73 E0
M620.1 E F299.339 T240



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S240


G1 E23.7 F299.339 ; do not need pulsatile flushing for start part
G1 E0.981131 F50
G1 E11.283 F299.339
G1 E0.981131 F50
G1 E11.283 F299.339
G1 E0.981131 F50
G1 E11.283 F299.339
G1 E0.981131 F50
G1 E11.283 F299.339

; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
G1 E13.0962 F299.339
G1 E1.45513 F50
; FLUSH_END

; FLUSH_START
M400
M109 S220
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

M204 S3000


M621 S1A
M106 S255
M106 P2 S0
G1 X43.564 Y219.775 F30000
G1 Z1.7
G1 X35.931 Y219.775 Z2.1
G1 X16.775 Y219.775 Z2.1
G1 X16.775 Y211.784

; filament start gcode
M106 P3 S150


G1 X24.516 Y211.784
G1 Z1.7
G1 E2 F1800

G4 S0
; CP_TOOLCHANGE_WIPE CT0 FL0
; LAYER_HEIGHT: 0.200000
M204 S3000
G1  X27.516 Y211.784  E0.1140 F1782
G1 E-0.8000 F1800
M204 S10000
G1  X23.016  F600
G1  X27.516  F240
G1 E0.8000 F1800
M204 S3000
G1  X51.016  E0.8931 F1782
; LAYER_HEIGHT: 0.100000
G1  Y211.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072 F2025
; LAYER_HEIGHT: 0.100000
G1  Y210.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072 F2473
; LAYER_HEIGHT: 0.100000
G1  Y209.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072 F4725
; LAYER_HEIGHT: 0.100000
G1  Y208.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072 F4775
; LAYER_HEIGHT: 0.100000
G1  Y208.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y207.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y206.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
M73 P88 R6
G1  Y205.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y205.034  E0.0149
; LAYER_HEIGHT: 0.200000
M73 P88 R5
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y204.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y203.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y202.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y202.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y201.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y200.534  E0.0149
; LAYER_HEIGHT: 0.200000
M73 P89 R5
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y199.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y199.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y198.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y197.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y196.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y196.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y195.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y194.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
M73 P90 R5
G1  Y193.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y193.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y192.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y191.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
M73 P90 R4
G1  Y190.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y190.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y189.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y188.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y187.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y187.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
M73 P91 R4
G1  Y186.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y185.534  E0.0149
G1  X24.516  E0.5272
; WIPE_TOWER_END
M220 R
G1 F30000
G4 S0
G92 E0
; CP TOOLCHANGE END
;------------------



; WIPE_START
G1 F3600
M204 S3000
G1 X26.516 Y185.534 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.1 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X178.51 Y116.21
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F3600
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.1 F30000
G1 X178.51 Y131.21 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.1 F30000
G1 X162.21 Y143.51 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.1 F30000
G1 X146.21 Y143.51 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.608 Y136.374 Z2.1 F30000
G1 X149.726 Y133.458 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S3000
G1 X149.175 Y133.458 E.01236
G1 X149.175 Y118.542 E.33479
G1 X149.726 Y118.542 E.01236
G1 X149.726 Y118.817 E.00618
G1 X149.726 Y133.398 E.32726
M204 S10000
G1 X150.215 Y133.948 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X148.685 Y133.948 E.02672
G1 X148.685 Y118.052 E.27754
G1 X150.215 Y118.052 E.02672
G1 X150.215 Y118.817 E.01336
G1 X150.215 Y133.888 E.26313
M204 S10000
G1 X150.644 Y134.376 F30000
G1 F6000
M204 S3000
G1 X148.257 Y134.376 E.04168
G1 X148.257 Y117.624 E.2925
G1 X150.644 Y117.624 E.04168
G1 X150.644 Y118.817 E.02084
G1 X150.644 Y134.316 E.27062
M204 S250
G1 X151.057 Y134.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
; WIPE_START
M204 S3000
G1 X149.058 Y134.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.169 Y130.195 Z2.1 F30000
G1 X163.885 Y123.673 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54611
G1 F6000
M204 S3000
G2 X164.559 Y122.741 I-10.858 J-8.572 E.02459
; LINE_WIDTH: 0.55718
G1 X164.889 Y122.272 E.01252
; LINE_WIDTH: 0.582185
G1 X165.054 Y122.048 E.00636
; LINE_WIDTH: 0.60719
G1 X165.22 Y121.824 E.00665
; LINE_WIDTH: 0.62971
G1 X165.555 Y121.345 E.01448
; LINE_WIDTH: 0.63992
G2 X166.573 Y119.832 I-84.852 J-58.196 E.04596
; LINE_WIDTH: 0.63471
G1 X167.324 Y118.693 E.03408
; LINE_WIDTH: 0.6132
G1 X167.412 Y118.562 E.0038
G1 X168.104 Y118.562 E.01669
G1 X167.82 Y119.015 E.01288
; LINE_WIDTH: 0.63471
G1 X167.086 Y120.168 E.03416
; LINE_WIDTH: 0.63992
G3 X166.046 Y121.703 I-28.858 J-18.431 E.04671
; LINE_WIDTH: 0.62971
G1 X165.673 Y122.191 E.01522
; LINE_WIDTH: 0.60719
G1 X165.481 Y122.407 E.00691
; LINE_WIDTH: 0.581235
G1 X165.289 Y122.624 E.0066
; LINE_WIDTH: 0.55528
G1 X164.843 Y123.019 E.01296
; LINE_WIDTH: 0.54611
G3 X163.936 Y123.641 I-7.653 J-10.2 E.02352
; WIPE_START
G1 X164.559 Y122.741 E-.41593
G1 X164.889 Y122.272 E-.21799
G1 X165.054 Y122.048 E-.10586
G1 X165.086 Y122.005 E-.02022
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.609 Y125.921 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X163.655 Y125.996 E.00154
G2 X161.686 Y125.91 I-2.331 J30.98 E.03442
; LINE_WIDTH: 0.475485
G1 X161.278 Y125.897 E.00754
; LINE_WIDTH: 0.50098
G1 X160.871 Y125.884 E.00796
G1 X160.999 Y125.847 E.0026
; LINE_WIDTH: 0.48378
G1 X161.618 Y125.629 E.01236
; LINE_WIDTH: 0.44999
G1 X162.182 Y125.339 E.01107
G1 X162.474 Y125.143 E.00614
G1 X163.006 Y124.681 E.01231
; LINE_WIDTH: 0.45052
G1 X163.399 Y124.233 E.01042
G1 X163.27 Y124.543 E.00587
; LINE_WIDTH: 0.44999
G1 X163.221 Y124.793 E.00445
G1 X163.281 Y125.393 E.01053
G1 X163.577 Y125.87 E.0098
; WIPE_START
G1 X163.655 Y125.996 E-.05631
G1 X162.85 Y125.941 E-.30646
G1 X161.805 Y125.914 E-.39723
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.835 Y129.365 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S3000
G1 X156.835 Y131.966 E.05838
; LINE_WIDTH: 0.58603
G1 X156.851 Y132.231 E.00612
G1 X156.944 Y132.408 E.00458
; LINE_WIDTH: 0.540684
G1 X157.037 Y132.584 E.00422
; LINE_WIDTH: 0.495337
G1 X157.129 Y132.761 E.00385
; LINE_WIDTH: 0.44999
G1 X157.62 Y133.232 E.01187
; LINE_WIDTH: 0.491915
G1 X157.993 Y133.355 E.00753
; LINE_WIDTH: 0.53384
G1 X158.366 Y133.477 E.0082
G1 X157.954 Y133.498 E.00862
; LINE_WIDTH: 0.491915
G1 X157.541 Y133.519 E.00791
; LINE_WIDTH: 0.44999
G1 X156.223 Y133.519 E.02302
G1 X156.223 Y133.027 E.0086
; LINE_WIDTH: 0.49077
G1 X156.243 Y132.673 E.00678
; LINE_WIDTH: 0.53155
G1 X156.264 Y132.319 E.00736
; LINE_WIDTH: 0.57233
G1 X156.284 Y131.966 E.00795
G1 X156.284 Y127.966 E.08978
G2 X156.264 Y127.139 I-4.825 J-.294 E.01858
; LINE_WIDTH: 0.53155
G1 X156.243 Y126.901 E.00496
; LINE_WIDTH: 0.49077
G1 X156.223 Y126.664 E.00456
; LINE_WIDTH: 0.44999
G1 X156.223 Y125.238 E.02489
; LINE_WIDTH: 0.495337
G1 X156.245 Y125.105 E.0026
; LINE_WIDTH: 0.540684
G1 X156.268 Y124.972 E.00285
; LINE_WIDTH: 0.58603
G2 X156.284 Y124.525 I-1.15 J-.265 E.01036
; LINE_WIDTH: 0.57233
G1 X156.284 Y118.542 E.13429
G1 X156.835 Y118.542 E.01236
G1 X156.835 Y124.525 E.13429
; LINE_WIDTH: 0.58603
G1 X156.851 Y124.791 E.00612
G1 X156.903 Y124.888 E.00254
; LINE_WIDTH: 0.540684
G1 X156.954 Y124.986 E.00234
; LINE_WIDTH: 0.495337
G1 X157.006 Y125.083 E.00213
; LINE_WIDTH: 0.44999
G1 X157.292 Y125.529 E.00924
G1 X157.673 Y125.821 E.00839
G1 X157.957 Y125.886 E.00509
; LINE_WIDTH: 0.411405
G1 X158.241 Y125.951 E.00463
G1 X157.957 Y126.016 E.00463
; LINE_WIDTH: 0.44999
G1 X157.673 Y126.08 E.00509
G1 X157.292 Y126.373 E.00839
G1 X157.006 Y126.818 E.00924
; LINE_WIDTH: 0.49077
G1 X156.949 Y127.004 E.00372
; LINE_WIDTH: 0.53155
G1 X156.892 Y127.191 E.00405
; LINE_WIDTH: 0.57233
G1 X156.835 Y127.377 E.00437
G1 X156.835 Y129.305 E.04327
; WIPE_START
G1 X156.835 Y131.305 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.574 Y127.721 Z2.1 F30000
G1 X165.612 Y126.637 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.39723
G1 F6000
M204 S3000
G1 X166.144 Y126.84 E.00871
; LINE_WIDTH: 0.39845
G1 X166.768 Y127.213 E.01117
; LINE_WIDTH: 0.439795
G1 X166.985 Y127.444 E.00541
; LINE_WIDTH: 0.48114
G1 X167.202 Y127.676 E.00594
; LINE_WIDTH: 0.510205
G1 X167.345 Y127.898 E.00527
; LINE_WIDTH: 0.53927
G1 X167.489 Y128.121 E.00558
; LINE_WIDTH: 0.58192
G1 X167.71 Y128.654 E.01318
; LINE_WIDTH: 0.61045
G1 X167.845 Y129.264 E.01499
; LINE_WIDTH: 0.63163
G1 X167.887 Y129.986 E.01798
; LINE_WIDTH: 0.63865
G1 X167.85 Y130.523 E.01355
; LINE_WIDTH: 0.64478
G3 X167.576 Y131.507 I-3.882 J-.55 E.026
; LINE_WIDTH: 0.64303
G1 X167.335 Y131.965 E.01311
; LINE_WIDTH: 0.62898
G1 X166.947 Y132.461 E.01559
; LINE_WIDTH: 0.60303
G1 X166.458 Y132.876 E.0152
; LINE_WIDTH: 0.55804
G1 X166.032 Y133.076 E.0103
G1 X165.494 Y133.227 E.01221
; LINE_WIDTH: 0.595907
G1 X165.291 Y133.24 E.00476
; LINE_WIDTH: 0.633774
G1 X165.089 Y133.253 E.00507
; LINE_WIDTH: 0.67164
G1 X164.886 Y133.267 E.00538
G1 X165.059 Y133.17 E.00526
; LINE_WIDTH: 0.633774
G1 X165.233 Y133.074 E.00495
; LINE_WIDTH: 0.595907
G1 X165.407 Y132.978 E.00465
; LINE_WIDTH: 0.55804
G1 X165.851 Y132.696 E.0115
; LINE_WIDTH: 0.57607
G1 X166.297 Y132.307 E.01337
; LINE_WIDTH: 0.61751
G1 X166.602 Y131.961 E.0112
; LINE_WIDTH: 0.63174
G1 X166.884 Y131.519 E.01303
; LINE_WIDTH: 0.64478
G1 X167.139 Y130.882 E.01742
G1 X167.257 Y130.264 E.016
; LINE_WIDTH: 0.63271
G1 X167.279 Y129.629 E.01582
; LINE_WIDTH: 0.61329
G1 X167.218 Y129.036 E.01436
; LINE_WIDTH: 0.58935
G1 X167.066 Y128.462 E.01375
; LINE_WIDTH: 0.54655
G1 X166.93 Y128.174 E.00681
; LINE_WIDTH: 0.512415
G1 X166.793 Y127.886 E.00637
; LINE_WIDTH: 0.47828
G1 X166.602 Y127.63 E.00596
; LINE_WIDTH: 0.437755
G1 X166.41 Y127.374 E.00543
; LINE_WIDTH: 0.39723
G2 X165.661 Y126.672 I-3.021 J2.473 E.01575
; WIPE_START
G1 X166.144 Y126.84 E-.19411
G1 X166.768 Y127.213 E-.27632
G1 X166.985 Y127.444 E-.12054
G1 X167.202 Y127.676 E-.12054
G1 X167.271 Y127.783 E-.04849
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.924 Y125.642 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X163.96 Y125.7 E.00119
; LINE_WIDTH: 0.486565
G1 X164.179 Y125.844 E.00497
; LINE_WIDTH: 0.52314
G1 X164.398 Y125.989 E.00536
; LINE_WIDTH: 0.53007
G1 X164.641 Y126.04 E.00515
; LINE_WIDTH: 0.57933
G2 X165.471 Y126.227 I2.057 J-7.204 E.01934
; LINE_WIDTH: 0.536217
G1 X165.674 Y126.264 E.00433
; LINE_WIDTH: 0.493103
G1 X165.877 Y126.3 E.00396
; LINE_WIDTH: 0.44999
G1 X166.318 Y126.476 E.00829
G1 X166.981 Y126.864 E.01341
G1 X167.44 Y127.274 E.01075
G3 X168.189 Y128.532 I-3.272 J2.801 E.02569
G1 X168.353 Y129.225 E.01242
G1 X168.406 Y130.018 E.01389
G3 X167.497 Y132.616 I-4.083 J.029 E.04901
G1 X167.138 Y132.98 E.00892
G1 X166.681 Y133.309 E.00984
G1 X166.217 Y133.526 E.00893
G1 X165.606 Y133.698 E.01109
G3 X162.388 Y133.948 I-2.943 J-17.054 E.05643
G1 X155.794 Y133.948 E.11513
G1 X155.794 Y118.052 E.27754
G1 X157.324 Y118.052 E.02672
G1 X157.324 Y124.525 E.11302
G1 X157.403 Y124.921 E.00704
G1 X157.605 Y125.236 E.00655
G1 X157.875 Y125.444 E.00594
G1 X158.367 Y125.566 E.00885
G2 X160.884 Y125.417 I.511 J-12.649 E.0441
M73 P92 R4
G1 X161.462 Y125.228 E.01063
G1 X162.193 Y124.819 E.01462
G1 X162.725 Y124.357 E.01231
G2 X164.481 Y122.014 I-18.003 J-15.321 E.05116
G1 X167.14 Y118.052 E.0833
G1 X169.025 Y118.052 E.03292
G1 X167.964 Y119.747 E.03492
G3 X166.466 Y122.007 I-32.942 J-20.204 E.04734
G3 X164.665 Y123.733 I-5.532 J-3.97 E.0438
G1 X164.025 Y124.143 E.01327
G1 X163.774 Y124.442 E.00682
G1 X163.647 Y124.839 E.00727
G1 X163.69 Y125.264 E.00746
G1 X163.893 Y125.591 E.00672
M204 S10000
G1 X164.24 Y125.362 F30000
G1 F6000
M204 S3000
G1 X164.257 Y125.391 E.00059
G1 X164.521 Y125.541 E.00529
G3 X166.009 Y125.893 I-2.195 J12.605 E.02672
G1 X166.509 Y126.092 E.0094
G1 X167.235 Y126.515 E.01467
G1 X167.81 Y127.03 E.01347
G1 X168.256 Y127.633 E.0131
G1 X168.576 Y128.315 E.01316
G1 X168.746 Y128.983 E.01203
G3 X168.833 Y130.046 I-9.282 J1.299 E.01862
G3 X167.782 Y132.951 I-4.49 J.018 E.05508
G1 X167.364 Y133.358 E.01018
G1 X166.894 Y133.683 E.00997
G1 X166.367 Y133.929 E.01017
G1 X165.698 Y134.117 E.01213
G3 X162.393 Y134.376 I-3.035 J-17.495 E.05797
G1 X155.366 Y134.376 E.12269
G1 X155.366 Y117.624 E.2925
G1 X157.753 Y117.624 E.04168
G1 X157.753 Y124.525 E.1205
G1 X157.762 Y124.631 E.00186
G1 X157.918 Y124.944 E.0061
G1 X158.077 Y125.066 E.0035
G1 X158.366 Y125.138 E.00521
G2 X160.773 Y125.003 I.487 J-12.826 E.04214
G1 X161.266 Y124.846 E.00904
G1 X161.912 Y124.495 E.01283
G1 X162.445 Y124.033 E.01231
G2 X164.128 Y121.771 I-18.627 J-15.621 E.04927
G1 X166.911 Y117.624 E.0872
G1 X169.799 Y117.624 E.05042
G1 X168.738 Y119.319 E.03492
G3 X166.809 Y122.264 I-39.596 J-23.82 E.06147
G3 X164.358 Y124.43 I-6.174 J-4.516 E.05756
G1 X164.207 Y124.563 E.00351
G1 X164.094 Y124.78 E.00428
G1 X164.092 Y125.114 E.00582
G1 X164.209 Y125.31 E.004
M204 S250
G1 X164.544 Y125.093 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X164.648 Y125.146 E.00189
G3 X166.694 Y125.72 I-1.09 J7.81 E.0346
G1 X167.479 Y126.179 E.01478
G1 X168.117 Y126.75 E.01389
G1 X168.613 Y127.42 E.01354
G1 X168.967 Y128.175 E.01355
G1 X169.147 Y128.882 E.01183
G3 X169.246 Y130.072 I-8.741 J1.329 E.0194
G1 X169.206 Y130.702 E.01025
G1 X169.065 Y131.404 E.01164
G1 X168.829 Y132.062 E.01135
G1 X168.5 Y132.677 E.01132
G1 X168.094 Y133.224 E.01106
G1 X167.628 Y133.679 E.01057
G1 X167.101 Y134.043 E.0104
G1 X166.511 Y134.318 E.01057
G1 X165.787 Y134.522 E.01222
G3 X162.397 Y134.79 I-3.123 J-17.922 E.0553
G1 X154.952 Y134.79 E.12089
G1 X154.952 Y117.21 E.28546
G1 X158.167 Y117.21 E.05219
G1 X158.167 Y124.525 E.11878
G1 X158.22 Y124.661 E.00238
G1 X158.366 Y124.724 E.00258
G2 X160.64 Y124.608 I.487 J-12.823 E.03702
G1 X161.078 Y124.479 E.00741
G1 X161.674 Y124.154 E.01102
G1 X162.198 Y123.696 E.0113
G2 X163.788 Y121.536 I-19.101 J-15.728 E.04357
G1 X166.69 Y117.21 E.08459
G1 X170.546 Y117.21 E.0626
G1 X168.423 Y120.6 E.06495
G3 X166.642 Y123.13 I-18.991 J-11.48 E.05028
G1 X166.043 Y123.735 E.01382
G3 X164.557 Y124.795 I-6.952 J-8.174 E.02968
G1 X164.485 Y124.929 E.00246
G1 X164.524 Y125.037 E.00187
; WIPE_START
M204 S3000
G1 X164.648 Y125.146 E-.06283
G1 X165.205 Y125.244 E-.21483
G1 X165.723 Y125.369 E-.20234
G1 X166.202 Y125.52 E-.19106
G1 X166.419 Y125.609 E-.08894
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.711 Y130.676 Z2.1 F30000
G1 X158.152 Y132.949 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X157.837 Y132.863 E.0057
G1 X157.49 Y132.529 E.00841
G1 X157.34 Y132.146 E.00718
G1 X157.324 Y131.966 E.00315
G1 X157.324 Y127.377 E.08012
G1 X157.403 Y126.981 E.00704
G1 X157.605 Y126.666 E.00655
G1 X157.875 Y126.458 E.00594
G1 X158.367 Y126.335 E.00885
G1 X160.367 Y126.337 E.03492
G3 X163.639 Y126.424 I.607 J38.865 E.05717
; LINE_WIDTH: 0.486565
G1 X163.967 Y126.452 E.00624
; LINE_WIDTH: 0.52314
G1 X164.295 Y126.479 E.00673
; LINE_WIDTH: 0.5665
G1 X164.908 Y126.655 E.01416
; LINE_WIDTH: 0.57933
G3 X165.232 Y126.83 I-.083 J.542 E.00852
; LINE_WIDTH: 0.536217
G1 X165.374 Y126.942 E.00381
; LINE_WIDTH: 0.493103
G1 X165.517 Y127.055 E.00349
; LINE_WIDTH: 0.44999
G1 X166.117 Y127.649 E.01475
G1 X166.407 Y128.103 E.0094
G3 X166.626 Y130.763 I-3.454 J1.623 E.0476
G1 X166.409 Y131.311 E.01029
G1 X166.093 Y131.794 E.01008
G1 X165.69 Y132.205 E.01006
G1 X165.214 Y132.531 E.01007
G1 X164.681 Y132.768 E.01018
G1 X164.108 Y132.917 E.01033
G1 X163.352 Y132.981 E.01325
G3 X160.208 Y133.005 I-2.247 J-87.423 E.05489
G1 X158.366 Y133.007 E.03217
G1 X158.21 Y132.965 E.00282
M204 S10000
G1 X158.261 Y132.55 F30000
G1 F6000
M204 S3000
G1 X158.055 Y132.494 E.00373
G1 X157.85 Y132.297 E.00495
G1 X157.753 Y131.966 E.00603
G1 X157.753 Y127.377 E.08012
G3 X158.077 Y126.836 I.681 J.041 E.01144
G1 X158.369 Y126.764 E.00526
G1 X160.369 Y126.766 E.03492
G3 X163.61 Y126.852 I.592 J38.924 E.05662
G3 X164.993 Y127.226 I-.257 J3.7 E.02518
G1 X165.431 Y127.546 E.00947
G1 X165.805 Y127.943 E.00953
G1 X166.07 Y128.378 E.00889
G1 X166.239 Y128.857 E.00887
G3 X166.296 Y130.294 I-4.343 J.893 E.02521
G3 X164.984 Y132.17 I-2.605 J-.426 E.04134
G3 X164.009 Y132.5 I-1.508 J-2.843 E.01805
G1 X163.324 Y132.553 E.01199
G3 X160.208 Y132.577 I-2.222 J-88.444 E.05442
G1 X158.366 Y132.579 E.03216
G1 X158.319 Y132.566 E.00085
M204 S250
G1 X158.366 Y132.165 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X158.198 Y132.073 E.0031
G1 X158.167 Y131.966 E.00182
G1 X158.167 Y127.377 E.07451
G1 X158.22 Y127.241 E.00238
G1 X158.369 Y127.177 E.00262
G1 X161.694 Y127.181 E.05399
G3 X164.169 Y127.349 I.112 J16.666 E.04032
G1 X164.712 Y127.542 E.00936
G1 X165.13 Y127.83 E.00823
G1 X165.505 Y128.227 E.00887
G1 X165.709 Y128.585 E.00669
G1 X165.851 Y129.032 E.00761
G1 X165.929 Y129.709 E.01106
G1 X165.893 Y130.2 E.008
G1 X165.755 Y130.705 E.00851
G3 X164.761 Y131.821 I-1.95 J-.736 E.02481
G3 X163.88 Y132.103 I-1.296 J-2.532 E.0151
G3 X160.207 Y132.163 I-2.726 J-54.374 E.05965
G1 X158.426 Y132.165 E.02893
; WIPE_START
M204 S3000
G1 X158.198 Y132.073 E-.0932
G1 X158.167 Y131.966 E-.04268
G1 X158.167 Y130.323 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.886 Y133.267 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S3000
G1 X164.554 Y133.33 E.00895
; LINE_WIDTH: 0.62207
G1 X164.222 Y133.394 E.00827
; LINE_WIDTH: 0.5725
G1 X163.66 Y133.441 E.01266
; LINE_WIDTH: 0.55022
G1 X163.054 Y133.464 E.01307
; LINE_WIDTH: 0.54592
G1 X162.383 Y133.474 E.01434
; LINE_WIDTH: 0.54068
G1 X162.209 Y133.476 E.00368
; LINE_WIDTH: 0.53768
G1 X160.209 Y133.477 E.04207
; LINE_WIDTH: 0.53568
G1 X158.367 Y133.477 E.03858
; LINE_WIDTH: 0.53384
G1 X158.366 Y133.477 E.00003
; WIPE_START
G1 X158.367 Y133.477 E-.00057
G1 X160.209 Y133.477 E-.69973
G1 X160.366 Y133.476 E-.05969
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.871 Y125.884 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.50098
G1 F6000
M204 S3000
G1 X160.807 Y125.889 E.00125
; LINE_WIDTH: 0.49122
G1 X160.417 Y125.913 E.00749
; LINE_WIDTH: 0.44249
G1 X160.026 Y125.937 E.00672
; LINE_WIDTH: 0.39376
G1 X159.42 Y125.95 E.00918
; LINE_WIDTH: 0.3662
G1 X158.37 Y125.951 E.01475
; LINE_WIDTH: 0.37282
G1 X158.241 Y125.951 E.00185
; WIPE_START
G1 X158.37 Y125.951 E-.04904
G1 X159.42 Y125.95 E-.39912
G1 X160.026 Y125.937 E-.23009
G1 X160.241 Y125.924 E-.08175
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.693 Y123.867 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.45052
G1 F6000
M204 S3000
G1 X163.399 Y124.233 E.00821
; WIPE_START
G1 X163.693 Y123.867 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.849 Y125.419 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5442
G1 F6000
M204 S3000
G2 X162.851 Y125.527 I-.028 J.055 E.00542
; WIPE_START
G1 X162.783 Y125.532 E-.19609
G1 X162.751 Y125.475 E-.18797
G1 X162.783 Y125.419 E-.18797
G1 X162.849 Y125.419 E-.18796
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.639 Y126.627 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S3000
G1 X156.966 Y126.118 E.00995
G3 X157.163 Y125.951 I.576 J.483 E.00427
G1 X156.968 Y125.788 E.00418
G1 X156.639 Y125.299 E.0097
G1 X156.639 Y126.567 E.02085
M204 S10000
G1 X156.753 Y132.969 F30000
; LINE_WIDTH: 0.57486
G1 F6000
M204 S3000
G2 X156.757 Y133.08 I-.03 J.057 E.00614
; WIPE_START
G1 X156.683 Y133.088 E-.20014
G1 X156.649 Y133.028 E-.18662
G1 X156.683 Y132.969 E-.18663
G1 X156.753 Y132.969 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X153.733 Y125.959 Z2.1 F30000
G1 X146.21 Y108.49 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.1 F30000
G1 X167.79 Y108.49 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.234 Y110.885 Z2.1 F30000
G1 X131.727 Y121.709 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.51468
G1 F6000
M204 S3000
G1 X131.803 Y121.878 E.00373
G1 X131.938 Y122.02 E.00393
; LINE_WIDTH: 0.482335
G1 X132.072 Y122.162 E.00367
; LINE_WIDTH: 0.44999
G1 X132.59 Y122.482 E.01064
G1 X133.088 Y122.569 E.00882
; LINE_WIDTH: 0.497195
G1 X133.512 Y122.593 E.00823
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00904
G1 X133.59 Y122.804 E.00838
; LINE_WIDTH: 0.497195
G1 X133.244 Y122.992 E.00763
; LINE_WIDTH: 0.44999
G1 X132.921 Y123.381 E.00882
G1 X132.736 Y123.953 E.01049
; LINE_WIDTH: 0.4722
G1 X132.806 Y124.617 E.01227
G1 X133.5 Y126.493 E.03673
; LINE_WIDTH: 0.44985
G1 X134.195 Y128.368 E.03491
; LINE_WIDTH: 0.4275
G1 X134.889 Y130.244 E.03309
; LINE_WIDTH: 0.40515
G1 X135.29 Y131.325 E.01802
; LINE_WIDTH: 0.4044
G1 X135.406 Y131.582 E.00441
; LINE_WIDTH: 0.44999
G1 X135.717 Y131.973 E.00872
G1 X136.34 Y132.27 E.01204
G2 X137.011 Y132.255 I.304 J-1.438 E.01183
G1 X137.597 Y131.95 E.01154
; LINE_WIDTH: 0.45984
G1 X137.898 Y131.608 E.00813
G1 X138.021 Y131.343 E.00522
; LINE_WIDTH: 0.47269
G1 X138.729 Y129.473 E.03677
; LINE_WIDTH: 0.49801
G1 X139.437 Y127.602 E.03883
; LINE_WIDTH: 0.52333
G1 X140.145 Y125.732 E.0409
; LINE_WIDTH: 0.53814
G1 X140.559 Y124.638 E.02463
; LINE_WIDTH: 0.55128
G1 X140.628 Y124.424 E.00486
G1 X140.62 Y124.278 E.00314
; LINE_WIDTH: 0.517517
G1 X140.612 Y124.133 E.00294
; LINE_WIDTH: 0.483753
G1 X140.604 Y123.988 E.00274
; LINE_WIDTH: 0.44999
G1 X140.442 Y123.429 E.01016
G1 X140.125 Y123.02 E.00904
; LINE_WIDTH: 0.485785
G1 X139.632 Y122.812 E.01011
; LINE_WIDTH: 0.52158
G1 X139.14 Y122.605 E.01089
G1 X139.719 Y122.587 E.01181
; LINE_WIDTH: 0.485785
G1 X140.298 Y122.569 E.01096
; LINE_WIDTH: 0.44999
G1 X140.807 Y122.478 E.00904
G1 X141.31 Y122.165 E.01034
; LINE_WIDTH: 0.486633
G1 X141.447 Y121.992 E.00418
; LINE_WIDTH: 0.523277
G1 X141.584 Y121.819 E.00451
; LINE_WIDTH: 0.55992
G1 X141.721 Y121.646 E.00484
; LINE_WIDTH: 0.5738
G1 X142.445 Y119.782 E.04501
; LINE_WIDTH: 0.58167
G2 X142.925 Y118.546 I-177.652 J-69.604 E.03025
G1 X143.117 Y118.546 E.00439
G1 X143.531 Y118.546 E.00945
G2 X142.64 Y120.79 I322.528 J129.367 E.0551
; LINE_WIDTH: 0.56778
G1 X142.222 Y121.843 E.02522
; LINE_WIDTH: 0.55992
G2 X142.133 Y122.116 I1.951 J.791 E.0063
; LINE_WIDTH: 0.523217
G1 X142.053 Y122.365 E.00536
; LINE_WIDTH: 0.486603
G1 X141.973 Y122.615 E.00497
; LINE_WIDTH: 0.44999
G1 X141.377 Y124.103 E.02799
; LINE_WIDTH: 0.494065
G1 X141.209 Y124.463 E.00765
; LINE_WIDTH: 0.53814
G1 X141.041 Y124.824 E.00837
G1 X140.309 Y126.685 E.0421
; LINE_WIDTH: 0.51281
G1 X139.577 Y128.546 E.04004
; LINE_WIDTH: 0.48749
G1 X138.846 Y130.408 E.03798
; LINE_WIDTH: 0.46217
G1 X138.418 Y131.496 E.021
; LINE_WIDTH: 0.45984
G2 X138.092 Y132.306 I14.436 J6.276 E.01559
; LINE_WIDTH: 0.44999
G1 X137.606 Y133.519 E.02282
G1 X135.778 Y133.519 E.03193
G2 X135.119 Y131.868 I-26.011 J9.418 E.03104
; LINE_WIDTH: 0.42113
G1 X134.943 Y131.455 E.00731
; LINE_WIDTH: 0.41461
G1 X134.227 Y129.588 E.03204
; LINE_WIDTH: 0.43696
G1 X133.512 Y127.72 E.03386
; LINE_WIDTH: 0.45931
G1 X132.796 Y125.853 E.03568
; LINE_WIDTH: 0.4722
G2 X132.085 Y124.039 I-46.648 J17.252 E.03578
; LINE_WIDTH: 0.44999
G1 X131.502 Y122.543 E.02803
; LINE_WIDTH: 0.47587
G1 X131.368 Y122.161 E.0075
; LINE_WIDTH: 0.50175
G1 X131.233 Y121.779 E.00793
; LINE_WIDTH: 0.52463
G1 X130.517 Y119.912 E.041
; LINE_WIDTH: 0.53733
G2 X129.984 Y118.524 I-121.17 J45.803 E.03124
G1 X130.542 Y118.524 E.01173
G2 X131.297 Y120.57 I179.136 J-64.994 E.04584
; LINE_WIDTH: 0.51444
G1 X131.682 Y121.61 E.02228
; LINE_WIDTH: 0.51468
G1 X131.702 Y121.655 E.00098
M204 S10000
G1 X132.205 Y121.608 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X132.368 Y121.852 E.00512
G1 X132.735 Y122.079 E.00754
G1 X133.088 Y122.141 E.00625
G1 X140.298 Y122.141 E.12589
G1 X140.659 Y122.076 E.0064
G1 X141.015 Y121.855 E.00732
G1 X141.265 Y121.486 E.00777
G1 X142.585 Y118.052 E.06424
G1 X143.117 Y118.052 E.00929
G1 X144.261 Y118.052 E.01998
G1 X137.896 Y133.948 E.29896
G1 X135.485 Y133.948 E.04211
G1 X129.293 Y118.052 E.29785
G1 X130.873 Y118.052 E.02758
G1 X131.556 Y119.932 E.03492
G2 X132.118 Y121.477 I68.526 J-24.037 E.02871
G1 X132.172 Y121.558 E.0017
M204 S10000
G1 X132.559 Y121.38 F30000
G1 F6000
M204 S3000
G1 X132.665 Y121.542 E.00339
G1 X132.881 Y121.676 E.00444
G1 X133.088 Y121.712 E.00368
G1 X140.298 Y121.712 E.12589
G1 X140.417 Y121.7 E.0021
G1 X140.72 Y121.544 E.00595
G1 X140.867 Y121.327 E.00457
G1 X142.291 Y117.624 E.06928
G1 X143.117 Y117.624 E.01443
G1 X144.894 Y117.624 E.03104
G1 X138.186 Y134.376 E.31508
G1 X135.192 Y134.376 E.05229
G1 X128.666 Y117.624 E.31391
G1 X131.173 Y117.624 E.04376
G1 X132.512 Y121.309 E.06846
G1 X132.526 Y121.33 E.00044
M204 S250
G1 X132.901 Y121.167 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G2 X132.95 Y121.243 I.574 J-.321 E.00147
G1 X133.088 Y121.299 E.00241
G1 X140.298 Y121.299 E.11707
G1 X140.367 Y121.286 E.00114
G1 X140.483 Y121.173 E.00263
G1 X142.006 Y117.21 E.06895
G1 X143.117 Y117.21 E.01803
G1 X145.506 Y117.21 E.03878
G1 X138.466 Y134.79 E.30749
G1 X134.909 Y134.79 E.05776
G1 X128.062 Y117.21 E.30635
G1 X131.463 Y117.21 E.05523
G1 X132.829 Y120.97 E.06495
G2 X132.874 Y121.114 I.646 J-.123 E.00246
; WIPE_START
M204 S3000
G1 X132.95 Y121.243 E-.05716
G1 X133.088 Y121.299 E-.05637
G1 X134.789 Y121.299 E-.64646
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.788 Y128.865 Z2.1 F30000
G1 X136.166 Y131.725 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X135.988 Y131.64 E.00345
G1 X135.753 Y131.372 E.00622
G1 X135.665 Y131.188 E.00356
G1 X133.219 Y124.467 E.12488
G1 X133.162 Y123.999 E.00823
G1 X133.293 Y123.594 E.00743
G1 X133.522 Y123.318 E.00625
G1 X134.018 Y123.085 E.00957
G1 X134.197 Y123.069 E.00315
G1 X139.14 Y123.069 E.08629
G1 X139.837 Y123.338 E.01306
G1 X140.062 Y123.628 E.0064
G1 X140.177 Y124.023 E.0072
G1 X140.116 Y124.473 E.00793
G1 X137.62 Y131.194 E.12518
G1 X137.529 Y131.38 E.00361
G1 X137.319 Y131.624 E.00562
G1 X136.824 Y131.858 E.00956
G1 X136.429 Y131.851 E.0069
G1 X136.22 Y131.751 E.00403
M204 S10000
G1 X136.194 Y131.218 F30000
G1 F6000
M204 S3000
G1 X136.068 Y131.042 E.00378
G1 X133.622 Y124.32 E.12488
G1 X133.588 Y124.045 E.00485
G1 X133.719 Y123.728 E.00598
G1 X133.8 Y123.644 E.00203
G1 X134.092 Y123.507 E.00563
G1 X134.197 Y123.498 E.00186
G1 X139.14 Y123.498 E.08629
G1 X139.55 Y123.656 E.00768
G1 X139.682 Y123.826 E.00377
G1 X139.75 Y124.059 E.00424
G1 X139.714 Y124.324 E.00466
G1 X137.218 Y131.045 E.12518
G1 X137.041 Y131.298 E.00539
G1 X136.75 Y131.436 E.00563
G1 X136.517 Y131.431 E.00406
G1 X136.258 Y131.308 E.00502
G1 X136.228 Y131.267 E.00088
M204 S250
G1 X136.518 Y130.987 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X136.457 Y130.9 E.00173
G1 X134.01 Y124.179 E.11614
G1 X134.024 Y124.012 E.00272
M73 P92 R3
G1 X134.163 Y123.914 E.00275
G1 X134.197 Y123.911 E.00056
G1 X139.14 Y123.911 E.08025
G1 X139.299 Y123.992 E.0029
G1 X139.335 Y124.152 E.00266
G1 X139.326 Y124.18 E.00048
G1 X136.829 Y130.906 E.1165
G1 X136.694 Y131.025 E.00292
G1 X136.577 Y130.999 E.00194
; WIPE_START
M204 S3000
G1 X136.457 Y130.9 E-.05928
G1 X135.826 Y129.167 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.14 Y122.605 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S3000
G1 X134.197 Y122.605 E.1007
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00559
; WIPE_START
G1 X134.197 Y122.605 E-.0997
G1 X135.935 Y122.605 E-.6603
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.393 Y123.666 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S3000
G1 X132.558 Y123.173 E.0087
G1 X132.709 Y122.949 E.00451
G1 X132.404 Y122.855 E.00533
G1 X131.958 Y122.558 E.00895
G1 X132.371 Y123.61 E.0189
; WIPE_START
G1 X131.958 Y122.558 E-.42968
G1 X132.404 Y122.855 E-.20356
G1 X132.709 Y122.949 E-.1212
G1 X132.701 Y122.961 E-.00556
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.333 Y122.978 Z2.1 F30000
G1 X140.691 Y122.979 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S3000
G1 X140.854 Y123.265 E.00622
G1 X141.013 Y123.811 E.01075
G1 X141.515 Y122.558 E.0255
G1 X141.004 Y122.876 E.01136
G1 X140.748 Y122.96 E.0051
; WIPE_START
G1 X141.004 Y122.876 E-.10257
G1 X141.515 Y122.558 E-.22853
G1 X141.095 Y123.606 E-.42891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.203 Y130.172 Z2.1 F30000
G1 X135.83 Y132.489 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S3000
G1 X136.067 Y133.097 E.01107
G2 X137.316 Y133.091 I.52 J-24.617 E.0212
G1 X137.572 Y132.44 E.01188
G1 X137.117 Y132.67 E.00865
G1 X136.623 Y132.713 E.00842
G1 X136.206 Y132.668 E.00713
G1 X135.884 Y132.515 E.00605
; WIPE_START
G1 X136.206 Y132.668 E-.13544
G1 X136.623 Y132.713 E-.15954
G1 X137.117 Y132.67 E-.18848
G1 X137.572 Y132.44 E-.19363
G1 X137.492 Y132.643 E-.08291
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.451 Y127.979 Z2.1 F30000
G1 X106.21 Y108.49 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y108.196 Z2.1 F30000
G1 X90.21 Y108.49 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.144 Y115.586 Z2.1 F30000
G1 X96.146 Y133.568 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.35598
G1 F6000
M204 S3000
G1 X95.782 Y133.672 E.00516
; LINE_WIDTH: 0.33261
G1 X95.116 Y133.798 E.00859
; LINE_WIDTH: 0.31593
G1 X94.438 Y133.87 E.00818
; LINE_WIDTH: 0.30859
G1 X93.747 Y133.896 E.0081
; LINE_WIDTH: 0.31477
G1 X93.046 Y133.868 E.00838
; LINE_WIDTH: 0.33132
G1 X92.347 Y133.788 E.00888
; LINE_WIDTH: 0.3643
G1 X91.56 Y133.626 E.01123
; LINE_WIDTH: 0.38649
G1 X91.015 Y133.454 E.0085
; LINE_WIDTH: 0.40817
G1 X90.538 Y133.257 E.00812
; LINE_WIDTH: 0.44963
G1 X89.963 Y132.977 E.01116
; LINE_WIDTH: 0.47196
G1 X89.53 Y132.693 E.00951
; LINE_WIDTH: 0.48939
G1 X89.084 Y132.335 E.0109
; LINE_WIDTH: 0.50523
G1 X88.639 Y131.903 E.01222
; LINE_WIDTH: 0.52781
G1 X88.156 Y131.324 E.01556
; LINE_WIDTH: 0.54902
G1 X87.836 Y130.862 E.01207
; LINE_WIDTH: 0.57222
G1 X87.576 Y130.415 E.01163
; LINE_WIDTH: 0.59243
G1 X87.31 Y129.858 E.01435
; LINE_WIDTH: 0.60335
G1 X87.094 Y129.264 E.01498
; LINE_WIDTH: 0.61368
G1 X86.92 Y128.633 E.0158
; LINE_WIDTH: 0.62061
G1 X86.822 Y128.136 E.01237
; LINE_WIDTH: 0.62174
G1 X86.744 Y127.622 E.01272
; LINE_WIDTH: 0.625
G1 X86.689 Y127.075 E.0135
; LINE_WIDTH: 0.62812
G1 X86.657 Y126.495 E.01435
; LINE_WIDTH: 0.62886
G1 X86.645 Y125.883 E.01517
; LINE_WIDTH: 0.632
G3 X86.765 Y124.217 I10.837 J-.059 E.04159
; LINE_WIDTH: 0.62599
G1 X86.918 Y123.392 E.02066
; LINE_WIDTH: 0.62226
G1 X87.088 Y122.763 E.01595
; LINE_WIDTH: 0.61732
G1 X87.279 Y122.219 E.014
; LINE_WIDTH: 0.61481
G1 X87.575 Y121.58 E.01703
; LINE_WIDTH: 0.60042
G1 X87.924 Y120.992 E.01612
; LINE_WIDTH: 0.5807
G1 X88.329 Y120.45 E.01542
; LINE_WIDTH: 0.55591
G1 X88.809 Y119.939 E.01527
; LINE_WIDTH: 0.52689
G1 X89.361 Y119.47 E.01491
; LINE_WIDTH: 0.49317
G1 X89.952 Y119.074 E.01368
; LINE_WIDTH: 0.45518
G1 X90.574 Y118.752 E.01237
; LINE_WIDTH: 0.41597
G1 X91.217 Y118.501 E.01109
; LINE_WIDTH: 0.37924
G1 X91.873 Y118.316 E.00994
; LINE_WIDTH: 0.34866
G1 X92.564 Y118.188 E.00938
; LINE_WIDTH: 0.32627
G1 X93.384 Y118.116 E.01022
; LINE_WIDTH: 0.31221
G1 X93.89 Y118.119 E.006
; LINE_WIDTH: 0.31835
G1 X94.701 Y118.146 E.00981
; LINE_WIDTH: 0.34039
G1 X95.476 Y118.255 E.01017
; LINE_WIDTH: 0.37063
G1 X96.205 Y118.433 E.01068
; LINE_WIDTH: 0.40536
G1 X96.876 Y118.674 E.01115
; LINE_WIDTH: 0.44117
G1 X97.492 Y118.973 E.01172
; LINE_WIDTH: 0.47539
G1 X98.061 Y119.33 E.01241
; LINE_WIDTH: 0.50634
G1 X98.587 Y119.745 E.01325
; LINE_WIDTH: 0.53435
G1 X99.074 Y120.222 E.01424
; LINE_WIDTH: 0.55949
G1 X99.51 Y120.749 E.01499
; LINE_WIDTH: 0.58147
G1 X99.896 Y121.341 E.01613
; LINE_WIDTH: 0.60064
G1 X100.244 Y122.043 E.01849
; LINE_WIDTH: 0.61475
G1 X100.518 Y122.788 E.01918
; LINE_WIDTH: 0.62416
G1 X100.721 Y123.571 E.01986
; LINE_WIDTH: 0.62955
G1 X100.859 Y124.388 E.02054
; LINE_WIDTH: 0.63713
G1 X100.952 Y125.498 E.02795
G1 X100.953 Y126.468 E.02432
; LINE_WIDTH: 0.63462
G1 X100.924 Y127.007 E.01349
; LINE_WIDTH: 0.62855
G1 X100.827 Y127.867 E.02142
; LINE_WIDTH: 0.61965
G1 X100.666 Y128.687 E.02035
; LINE_WIDTH: 0.60726
G1 X100.436 Y129.468 E.01943
; LINE_WIDTH: 0.58952
G1 X100.131 Y130.204 E.01845
; LINE_WIDTH: 0.56612
G1 X99.752 Y130.889 E.01736
; LINE_WIDTH: 0.53773
G1 X99.3 Y131.512 E.01619
; LINE_WIDTH: 0.50608
G1 X98.799 Y132.054 E.01457
; LINE_WIDTH: 0.47526
G1 X98.26 Y132.517 E.01313
; LINE_WIDTH: 0.44536
G1 X97.682 Y132.911 E.01209
; LINE_WIDTH: 0.41449
G1 X97.07 Y133.233 E.01107
; LINE_WIDTH: 0.38401
G1 X96.435 Y133.486 E.0101
; LINE_WIDTH: 0.35598
G1 X96.204 Y133.551 E.00328
; WIPE_START
G1 X95.782 Y133.672 E-.16656
G1 X95.116 Y133.798 E-.25758
G1 X94.438 Y133.87 E-.25898
G1 X94.236 Y133.878 E-.07689
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.858 Y126.71 Z2.1 F30000
G1 X98.973 Y120.93 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S3000
G1 X99.311 Y121.444 E.01379
; LINE_WIDTH: 0.59672
G1 X99.642 Y122.103 E.01729
; LINE_WIDTH: 0.61527
G1 X99.903 Y122.801 E.01803
; LINE_WIDTH: 0.62651
G1 X100.088 Y123.491 E.01762
; LINE_WIDTH: 0.63308
G1 X100.227 Y124.249 E.0192
; LINE_WIDTH: 0.63563
G3 X100.349 Y125.984 I-12.367 J1.74 E.04355
; LINE_WIDTH: 0.63443
G1 X100.326 Y126.855 E.02176
; LINE_WIDTH: 0.62953
G1 X100.253 Y127.652 E.01984
; LINE_WIDTH: 0.62185
G1 X100.126 Y128.412 E.01884
; LINE_WIDTH: 0.60881
G1 X99.946 Y129.135 E.01782
; LINE_WIDTH: 0.59354
G1 X99.706 Y129.819 E.0169
; LINE_WIDTH: 0.57402
G1 X99.414 Y130.439 E.01543
; LINE_WIDTH: 0.55095
G1 X99.087 Y130.978 E.0136
; LINE_WIDTH: 0.52553
G1 X98.704 Y131.48 E.01297
; LINE_WIDTH: 0.49762
G1 X98.266 Y131.942 E.01234
; LINE_WIDTH: 0.46894
G1 X97.788 Y132.351 E.01147
; LINE_WIDTH: 0.43985
G1 X97.266 Y132.708 E.01077
; LINE_WIDTH: 0.4098
G1 X96.693 Y133.012 E.01027
; LINE_WIDTH: 0.37993
G1 X96.061 Y133.262 E.00992
; LINE_WIDTH: 0.35225
G1 X95.365 Y133.451 E.00973
; LINE_WIDTH: 0.32919
G1 X94.602 Y133.57 E.00967
; LINE_WIDTH: 0.31323
G1 X93.878 Y133.608 E.00862
; LINE_WIDTH: 0.3138
G1 X93.31 Y133.592 E.00676
; LINE_WIDTH: 0.32712
G1 X92.553 Y133.51 E.00949
; LINE_WIDTH: 0.346
G1 X91.916 Y133.372 E.00862
; LINE_WIDTH: 0.37605
G1 X91.297 Y133.173 E.00939
; LINE_WIDTH: 0.40817
G1 X90.703 Y132.907 E.01026
; LINE_WIDTH: 0.44963
G1 X90.192 Y132.615 E.01026
; LINE_WIDTH: 0.47509
G1 X89.61 Y132.179 E.01346
; LINE_WIDTH: 0.49664
G1 X89.126 Y131.717 E.01295
; LINE_WIDTH: 0.52136
G1 X88.681 Y131.187 E.0141
; LINE_WIDTH: 0.54877
G1 X88.334 Y130.665 E.01346
; LINE_WIDTH: 0.57222
G1 X88.072 Y130.175 E.01247
; LINE_WIDTH: 0.59243
G1 X87.844 Y129.658 E.01314
; LINE_WIDTH: 0.60335
G1 X87.652 Y129.103 E.01392
; LINE_WIDTH: 0.61357
G1 X87.497 Y128.498 E.01507
; LINE_WIDTH: 0.61871
G1 X87.362 Y127.721 E.0192
; LINE_WIDTH: 0.625
G1 X87.291 Y127.03 E.01709
; LINE_WIDTH: 0.62812
G3 X87.251 Y125.966 I18.614 J-1.226 E.02632
; LINE_WIDTH: 0.6317
G1 X87.265 Y125.435 E.0132
; LINE_WIDTH: 0.63259
G3 X87.447 Y123.803 I10.97 J.394 E.04093
; LINE_WIDTH: 0.62992
G1 X87.614 Y123.093 E.01809
; LINE_WIDTH: 0.62438
G1 X87.699 Y122.808 E.0073
; LINE_WIDTH: 0.61382
G1 X87.905 Y122.244 E.01447
; LINE_WIDTH: 0.60427
G1 X88.216 Y121.593 E.01715
; LINE_WIDTH: 0.58513
G1 X88.595 Y120.986 E.01642
; LINE_WIDTH: 0.56044
G1 X89.04 Y120.432 E.01562
; LINE_WIDTH: 0.53221
G1 X89.525 Y119.949 E.01424
; LINE_WIDTH: 0.50137
G1 X90.039 Y119.538 E.01286
; LINE_WIDTH: 0.46644
G1 X90.591 Y119.187 E.01186
; LINE_WIDTH: 0.42844
G1 X91.177 Y118.9 E.01082
; LINE_WIDTH: 0.39039
G1 X91.791 Y118.679 E.00982
; LINE_WIDTH: 0.35588
G1 X92.428 Y118.522 E.00893
; LINE_WIDTH: 0.32832
G1 X93.083 Y118.428 E.00827
; LINE_WIDTH: 0.31053
G1 X93.753 Y118.395 E.0079
; LINE_WIDTH: 0.30573
G1 X94.414 Y118.417 E.00766
; LINE_WIDTH: 0.32208
G1 X95.059 Y118.495 E.00796
; LINE_WIDTH: 0.34481
G1 X95.689 Y118.636 E.00851
; LINE_WIDTH: 0.37507
G1 X96.302 Y118.839 E.0093
; LINE_WIDTH: 0.40998
G1 X96.891 Y119.109 E.01026
; LINE_WIDTH: 0.44638
G1 X97.451 Y119.445 E.01131
; LINE_WIDTH: 0.48135
G1 X97.977 Y119.845 E.01238
; LINE_WIDTH: 0.51276
G1 X98.463 Y120.306 E.01341
; LINE_WIDTH: 0.54272
G1 X98.912 Y120.838 E.01479
; LINE_WIDTH: 0.57196
G1 X98.94 Y120.88 E.00113
M204 S10000
G1 X98.586 Y121.208 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X98.886 Y121.702 E.01009
G3 X99.42 Y122.969 I-5.392 J3.018 E.02406
G3 X99.808 Y126.84 I-11.617 J3.118 E.06823
G3 X99.242 Y129.659 I-9.592 J-.461 E.05038
G3 X95.933 Y132.905 I-5.2 J-1.992 E.08346
G3 X92.603 Y133.146 I-2.156 J-6.651 E.05886
G3 X88.742 Y130.416 I.966 J-5.461 E.08529
G3 X87.805 Y126.983 I7.256 J-3.825 E.06265
G3 X88.18 Y122.977 I11.438 J-.949 E.07061
G3 X88.664 Y121.806 I6.495 J2.001 E.02215
G3 X93.769 Y118.749 I5.078 J2.688 E.1092
G3 X97.694 Y120.187 I.123 J5.738 E.07471
G3 X98.529 Y121.138 I-4.2 J4.533 E.02214
G1 X98.549 Y121.162 E.00053
M204 S10000
G1 X98.226 Y121.435 F30000
G1 F6000
M204 S3000
G1 X98.529 Y121.92 E.00999
G3 X98.799 Y122.496 I-4.622 J2.519 E.01111
G3 X99.371 Y125.185 I-8.57 J3.23 E.04818
G3 X99.044 Y128.912 I-11.512 J.867 E.06562
G3 X96.815 Y132.003 I-5.185 J-1.39 E.06801
G3 X93.844 Y132.824 I-2.955 J-4.907 E.05449
G3 X90.6 Y131.858 I-.119 J-5.534 E.06006
G3 X88.792 Y129.547 I3.199 J-4.365 E.05189
G3 X88.232 Y126.943 I8.092 J-3.102 E.04667
G3 X88.584 Y123.119 I11.265 J-.89 E.06739
G1 X88.784 Y122.558 E.01039
G3 X93.789 Y119.177 I4.963 J1.95 E.11211
G3 X98.194 Y121.385 I.118 J5.262 E.08953
M204 S250
G1 X97.871 Y121.656 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X98.625 Y123.246 I-4.123 J2.931 E.02873
G3 X98.966 Y126.817 I-10.895 J2.842 E.05849
G3 X98.446 Y129.384 I-8.698 J-.426 E.0427
G3 X95.933 Y132.009 I-4.436 J-1.732 E.06053
G3 X93.259 Y132.386 I-2.133 J-5.453 E.04425
G3 X89.414 Y129.9 I.348 J-4.755 E.07756
G3 X88.643 Y126.906 I6.771 J-3.338 E.05056
G3 X88.975 Y123.256 I10.864 J-.854 E.05979
G3 X91.74 Y120.006 I4.95 J1.411 E.07143
G3 X95.87 Y119.994 I2.08 J4.945 E.06884
G3 X97.836 Y121.607 I-2.122 J4.592 E.04173
; WIPE_START
M204 S3000
G1 X98.173 Y122.137 E-.23878
G1 X98.424 Y122.671 E-.22423
G1 X98.625 Y123.246 E-.23154
G1 X98.667 Y123.413 E-.06546
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.966 Y130.853 Z2.1 F30000
G1 X96.263 Y133.926 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X95.862 Y134.033 E.00724
G3 X91.479 Y134.004 I-2.125 J-10.184 E.07711
G1 X90.693 Y133.772 E.01431
G3 X89.737 Y133.34 I17.586 J-40.2 E.01831
G3 X87.429 Y131.113 I3.703 J-6.146 E.05647
G3 X86.416 Y128.72 I6.058 J-3.975 E.04562
G3 X86.339 Y123.59 I13.043 J-2.762 E.09013
G3 X87.507 Y120.724 I7.729 J1.478 E.0544
G3 X91.707 Y117.961 I5.59 J3.923 E.08988
G3 X93.366 Y117.756 I1.993 J9.29 E.02923
G1 X94.72 Y117.782 E.02364
G3 X97.678 Y118.59 I-.594 J7.997 E.05387
G3 X100.948 Y122.437 I-3.239 J6.065 E.09026
G3 X101.474 Y125.489 I-10.643 J3.408 E.05426
G3 X101.153 Y128.83 I-12.165 J.515 E.05878
G3 X100.56 Y130.434 I-7.662 J-1.919 E.02991
G1 X100.141 Y131.156 E.01457
G1 X99.645 Y131.811 E.01434
G3 X96.554 Y133.848 I-5.223 J-4.561 E.06544
G1 X96.321 Y133.91 E.00421
M204 S10000
G1 X96.373 Y134.339 F30000
G1 F6000
M204 S3000
G1 X95.955 Y134.451 E.00756
G3 X91.38 Y134.421 I-2.219 J-10.619 E.08049
G1 X90.545 Y134.175 E.0152
G1 X89.574 Y133.743 E.01856
G3 X85.997 Y128.806 I3.886 J-6.58 E.1095
G3 X85.918 Y123.506 I13.475 J-2.849 E.09312
G3 X87.154 Y120.48 I8.148 J1.561 E.05744
G3 X90.825 Y117.755 I5.842 J4.035 E.08127
G3 X93.353 Y117.327 I3.006 J10.055 E.04488
G1 X94.751 Y117.354 E.02441
G3 X97.876 Y118.209 I-.627 J8.434 E.05691
G3 X101.353 Y122.296 I-3.442 J6.451 E.09593
G3 X101.903 Y125.482 I-10.871 J3.517 E.05664
G3 X101.593 Y128.853 I-13.331 J.474 E.05927
G3 X100.212 Y131.811 I-7.816 J-1.848 E.05739
G3 X96.689 Y134.259 I-5.734 J-4.494 E.07603
G1 X96.431 Y134.324 E.00464
M204 S250
G1 X96.485 Y134.757 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X91.283 Y134.824 I-2.743 J-11.011 E.08522
G1 X90.402 Y134.564 E.01493
G1 X89.379 Y134.11 E.01816
G3 X85.488 Y128.382 I4.112 J-6.981 E.11618
G3 X85.513 Y123.425 I14.135 J-2.407 E.0809
G3 X86.813 Y120.246 I8.552 J1.641 E.05614
G3 X90.696 Y117.362 I6.182 J4.269 E.07997
G3 X93.34 Y116.913 I3.144 J10.506 E.04365
G1 X94.781 Y116.941 E.02339
G3 X98.066 Y117.841 I-.66 J8.855 E.05566
G3 X101.744 Y122.16 I-3.639 J6.824 E.0943
G3 X102.316 Y125.475 I-11.241 J3.648 E.05481
G3 X101.995 Y128.951 I-13.534 J.502 E.05685
G3 X101.012 Y131.376 I-9.292 J-2.357 E.04261
G3 X96.543 Y134.741 I-6.56 J-4.061 E.09296
; WIPE_START
M204 S3000
G1 X95.634 Y134.946 E-.35398
G1 X94.733 Y135.059 E-.34495
G1 X94.573 Y135.065 E-.06108
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.448 Y129.409 Z2.1 F30000
G1 X77.49 Y116.21 Z2.1
G1 Z1.7
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.314 Y126.926 Z2.1 F30000
G1 X77.49 Y131.21 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.261 Y138.665 Z2.1 F30000
G1 X90.21 Y143.51 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y143.711 Z2.1 F30000
G1 X106.21 Y143.51 Z2.1
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.494 Y136.69 Z2.1 F30000
G1 X116.009 Y121.65 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X115.495 Y121.813 E.0094
G1 X114.985 Y122.317 E.01253
; LINE_WIDTH: 0.44625
G1 X113.938 Y124.022 E.03462
; LINE_WIDTH: 0.45012
G1 X112.891 Y125.726 E.03493
; LINE_WIDTH: 0.45399
G1 X111.845 Y127.43 E.03525
; LINE_WIDTH: 0.45786
G1 X110.798 Y129.134 E.03556
; LINE_WIDTH: 0.45901
G1 X110.487 Y129.64 E.01058
; LINE_WIDTH: 0.47181
G2 X110.045 Y130.37 I8.569 J5.689 E.01567
; LINE_WIDTH: 0.44999
G1 X108.115 Y133.519 E.06449
G1 X106.888 Y133.519 E.02141
G1 X106.888 Y129.519 E.06984
G2 X106.885 Y128.611 I-116.699 J-.032 E.01587
; LINE_WIDTH: 0.44341
G1 X106.885 Y118.477 E.17421
G1 X107.307 Y118.477 E.00725
G1 X107.307 Y128.611 E.17421
; LINE_WIDTH: 0.45612
G1 X107.323 Y128.865 E.00452
G1 X107.479 Y129.307 E.0083
; LINE_WIDTH: 0.44999
G1 X107.899 Y129.792 E.0112
G1 X108.459 Y130.049 E.01076
G1 X108.984 Y130.1 E.0092
G1 X109.595 Y129.909 E.01119
; LINE_WIDTH: 0.47181
G1 X109.97 Y129.616 E.00873
G1 X110.115 Y129.411 E.0046
; LINE_WIDTH: 0.45901
G1 X111.165 Y127.708 E.03565
; LINE_WIDTH: 0.45514
G1 X112.215 Y126.006 E.03534
; LINE_WIDTH: 0.45127
G1 X113.265 Y124.304 E.03502
; LINE_WIDTH: 0.4474
G1 X114.315 Y122.602 E.03471
; LINE_WIDTH: 0.44353
G1 X114.626 Y122.097 E.01021
; LINE_WIDTH: 0.44239
G1 X114.63 Y122.091 E.00011
; LINE_WIDTH: 0.44999
G2 X116.866 Y118.481 I-868.396 J-540.416 E.07416
G1 X118.207 Y118.481 E.02341
G1 X118.207 Y119.341 E.01503
G1 X118.207 Y121.341 E.03492
G2 X118.21 Y123.108 I227.257 J.46 E.03085
; LINE_WIDTH: 0.44341
G1 X118.21 Y133.523 E.17905
G1 X117.788 Y133.523 E.00725
G1 X117.788 Y123.108 E.17905
; LINE_WIDTH: 0.44999
G1 X117.616 Y122.411 E.01254
G1 X117.195 Y121.926 E.01121
G1 X116.634 Y121.669 E.01078
G1 X116.108 Y121.619 E.00923
G1 X116.066 Y121.632 E.00076
M204 S10000
G1 X116.079 Y122.067 F30000
G1 F6000
M204 S3000
G1 X115.711 Y122.183 E.00674
G1 X115.349 Y122.536 E.00882
G1 X108.355 Y133.948 E.2337
G1 X106.46 Y133.948 E.03309
G1 X106.46 Y118.052 E.27754
G1 X107.732 Y118.052 E.02222
G1 X107.732 Y128.052 E.1746
G2 X107.748 Y128.791 I4.251 J.279 E.01292
G1 X107.857 Y129.104 E.00579
G1 X108.154 Y129.448 E.00793
G1 X108.489 Y129.612 E.00653
G1 X108.948 Y129.673 E.00807
G1 X109.381 Y129.537 E.00793
G1 X109.641 Y129.325 E.00586
G1 X109.746 Y129.183 E.00308
G1 X116.627 Y118.052 E.22848
G1 X118.636 Y118.052 E.03506
G1 X118.636 Y119.341 E.02251
G1 X118.636 Y133.948 E.25503
G1 X117.363 Y133.948 E.02222
G1 X117.363 Y123.108 E.18926
G1 X117.238 Y122.614 E.0089
G1 X116.94 Y122.27 E.00794
G1 X116.605 Y122.106 E.00653
G1 X116.145 Y122.046 E.0081
G1 X116.136 Y122.049 E.00015
M204 S10000
G1 X116.149 Y122.483 F30000
G1 F6000
M204 S3000
G1 X115.927 Y122.554 E.00408
G1 X115.714 Y122.761 E.00519
G1 X108.595 Y134.376 E.23786
G1 X106.031 Y134.376 E.04476
G1 X106.031 Y117.624 E.2925
G1 X108.161 Y117.624 E.03718
G1 X108.161 Y128.611 E.19184
G1 X108.234 Y128.901 E.00523
G1 X108.409 Y129.103 E.00467
G1 X108.606 Y129.2 E.00384
G1 X108.912 Y129.246 E.00539
G1 X109.167 Y129.166 E.00467
G1 X109.382 Y128.958 E.00523
G1 X116.389 Y117.624 E.23265
G1 X119.064 Y117.624 E.04671
G1 X119.064 Y119.341 E.02999
G1 X119.064 Y134.376 E.26251
G1 X116.935 Y134.376 E.03718
G1 X116.935 Y123.108 E.19675
G1 X116.861 Y122.817 E.00523
G1 X116.686 Y122.615 E.00467
G1 X116.488 Y122.518 E.00384
G1 X116.208 Y122.477 E.00495
M204 S250
G1 X116.218 Y122.885 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X116.065 Y122.979 E.0029
G1 X108.826 Y134.79 E.22494
G1 X105.618 Y134.79 E.0521
G1 X105.618 Y117.21 E.28546
G1 X108.574 Y117.21 E.04801
G1 X108.574 Y128.611 E.18512
G1 X108.655 Y128.771 E.00291
G1 X108.877 Y128.834 E.00375
G1 X109.03 Y128.74 E.00291
G1 X116.158 Y117.21 E.22011
G1 X119.478 Y117.21 E.0539
G1 X119.478 Y119.341 E.03461
G1 X119.478 Y134.79 E.25085
G1 X116.521 Y134.79 E.04801
G1 X116.521 Y123.108 E.18969
G1 X116.44 Y122.948 E.00291
G1 X116.275 Y122.901 E.00278
; WIPE_START
M204 S3000
G1 X116.065 Y122.979 E-.08506
G1 X115.137 Y124.493 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.793 Y121.992 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S3000
G1 X117.793 Y118.894 E.05031
G1 X117.097 Y118.894 E.01132
G1 X115.564 Y121.363 E.04719
G1 X116.113 Y121.208 E.00926
G1 X116.803 Y121.289 E.01128
G1 X117.41 Y121.574 E.0109
G1 X117.753 Y121.948 E.00824
M204 S10000
G1 X117.395 Y121.123 F30000
G1 F6000
M204 S3000
G1 X117.395 Y119.293 E.02972
G1 X117.304 Y119.316 E.00153
G1 X116.36 Y120.836 E.02905
G1 X116.918 Y120.906 E.00912
G1 X117.34 Y121.098 E.00754
M204 S10000
G1 X117.031 Y120.488 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S3000
G1 X116.96 Y120.529 E.00125
G1 X117.02 Y120.563 E.00105
; WIPE_START
G1 X116.96 Y120.529 E-.34737
G1 X117.031 Y120.488 E-.41263
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.427 Y126.575 Z2.1 F30000
G1 X109.577 Y130.342 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X109.061 Y130.504 E.00878
G1 X108.29 Y130.429 E.01258
G1 X107.683 Y130.143 E.01089
G1 X107.307 Y129.732 E.00905
G1 X107.302 Y133.106 E.05478
G1 X107.883 Y133.106 E.00943
G1 X109.546 Y130.393 E.05166
M204 S10000
G1 X108.775 Y130.888 F30000
G1 F6000
M204 S3000
G1 X108.242 Y130.824 E.00871
G1 X107.704 Y130.597 E.00948
G1 X107.701 Y132.64 E.03317
G1 X108.744 Y130.94 E.03238
M204 S10000
G1 X108.131 Y131.165 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S3000
G2 X108.122 Y131.253 I-.025 J.042 E.00327
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X108.081 Y131.253 E-.16312
G1 X108.055 Y131.209 E-.19896
G1 X108.081 Y131.165 E-.19898
G1 X108.131 Y131.165 E-.19893
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/24
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.1 I.253 J1.19 P1  F30000
G1 X178.51 Y116.21 Z2.1
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.2 F30000
G1 X178.51 Y131.21 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.2 F30000
G1 X162.21 Y143.51 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.2 F30000
G1 X146.21 Y143.51 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.608 Y136.374 Z2.2 F30000
G1 X149.726 Y133.458 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S3000
G1 X149.175 Y133.458 E.01236
G1 X149.175 Y118.542 E.33479
G1 X149.726 Y118.542 E.01236
G1 X149.726 Y118.817 E.00618
G1 X149.726 Y133.398 E.32726
M204 S10000
G1 X150.215 Y133.948 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X148.685 Y133.948 E.02672
G1 X148.685 Y118.052 E.27754
G1 X150.215 Y118.052 E.02672
G1 X150.215 Y118.817 E.01336
G1 X150.215 Y133.888 E.26313
M204 S10000
G1 X150.644 Y134.376 F30000
G1 F6000
M204 S3000
M73 P93 R3
G1 X148.257 Y134.376 E.04168
G1 X148.257 Y117.624 E.2925
G1 X150.644 Y117.624 E.04168
G1 X150.644 Y118.817 E.02084
G1 X150.644 Y134.316 E.27062
M204 S250
G1 X151.057 Y134.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
; WIPE_START
M204 S3000
G1 X149.058 Y134.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.169 Y130.195 Z2.2 F30000
G1 X163.885 Y123.673 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54612
G1 F6000
M204 S3000
G2 X164.559 Y122.741 I-10.862 J-8.575 E.02459
; LINE_WIDTH: 0.55718
G1 X164.889 Y122.272 E.01252
; LINE_WIDTH: 0.582185
G1 X165.054 Y122.048 E.00636
; LINE_WIDTH: 0.60719
G1 X165.22 Y121.824 E.00665
; LINE_WIDTH: 0.62971
G1 X165.555 Y121.345 E.01448
; LINE_WIDTH: 0.63992
G2 X166.573 Y119.832 I-85.003 J-58.297 E.04596
; LINE_WIDTH: 0.63471
G1 X167.324 Y118.693 E.03408
; LINE_WIDTH: 0.6132
G1 X167.412 Y118.562 E.0038
G1 X168.104 Y118.562 E.01669
G1 X167.82 Y119.015 E.01288
; LINE_WIDTH: 0.63471
G1 X167.084 Y120.171 E.03424
; LINE_WIDTH: 0.63992
G3 X166.046 Y121.703 I-28.835 J-18.418 E.04663
; LINE_WIDTH: 0.62971
G1 X165.673 Y122.191 E.01522
; LINE_WIDTH: 0.60719
G1 X165.481 Y122.407 E.00691
; LINE_WIDTH: 0.58124
G1 X165.289 Y122.624 E.0066
; LINE_WIDTH: 0.55529
G1 X164.843 Y123.019 E.01296
; LINE_WIDTH: 0.54612
G3 X163.936 Y123.641 I-7.663 J-10.214 E.02352
; WIPE_START
G1 X164.559 Y122.741 E-.41593
G1 X164.889 Y122.272 E-.218
G1 X165.054 Y122.048 E-.10586
G1 X165.086 Y122.005 E-.02021
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.609 Y125.921 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X163.655 Y125.996 E.00154
G2 X161.686 Y125.91 I-2.331 J30.999 E.03442
; LINE_WIDTH: 0.475475
G1 X161.278 Y125.897 E.00754
; LINE_WIDTH: 0.50096
G1 X160.871 Y125.884 E.00796
G1 X160.999 Y125.847 E.00261
; LINE_WIDTH: 0.48376
G1 X161.618 Y125.629 E.01236
; LINE_WIDTH: 0.44999
G1 X162.182 Y125.339 E.01107
G1 X162.474 Y125.143 E.00614
G1 X163.006 Y124.681 E.01231
; LINE_WIDTH: 0.45056
G1 X163.399 Y124.233 E.01042
G1 X163.27 Y124.543 E.00588
; LINE_WIDTH: 0.44999
G1 X163.221 Y124.793 E.00445
G1 X163.281 Y125.393 E.01053
G1 X163.577 Y125.87 E.00979
; WIPE_START
G1 X163.655 Y125.996 E-.05633
G1 X162.85 Y125.941 E-.30645
G1 X161.805 Y125.913 E-.39722
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.835 Y129.364 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S3000
G1 X156.835 Y131.966 E.0584
; LINE_WIDTH: 0.58603
G1 X156.851 Y132.231 E.00612
G1 X156.944 Y132.408 E.00458
; LINE_WIDTH: 0.540684
G1 X157.037 Y132.584 E.00422
; LINE_WIDTH: 0.495337
G1 X157.129 Y132.761 E.00385
; LINE_WIDTH: 0.44999
G1 X157.62 Y133.232 E.01187
; LINE_WIDTH: 0.491915
G1 X157.993 Y133.355 E.00753
; LINE_WIDTH: 0.53384
G1 X158.366 Y133.477 E.0082
G1 X157.954 Y133.498 E.00862
; LINE_WIDTH: 0.491915
G1 X157.541 Y133.519 E.00791
; LINE_WIDTH: 0.44999
G1 X156.223 Y133.519 E.02302
G1 X156.223 Y133.027 E.0086
; LINE_WIDTH: 0.49077
G1 X156.243 Y132.673 E.00678
; LINE_WIDTH: 0.53155
G1 X156.264 Y132.319 E.00736
; LINE_WIDTH: 0.57233
G1 X156.284 Y131.966 E.00795
G1 X156.284 Y127.966 E.08978
G2 X156.264 Y127.139 I-4.825 J-.294 E.01858
; LINE_WIDTH: 0.53155
G1 X156.243 Y126.901 E.00496
; LINE_WIDTH: 0.49077
G1 X156.223 Y126.664 E.00456
; LINE_WIDTH: 0.44999
G1 X156.223 Y125.238 E.02489
; LINE_WIDTH: 0.495337
G1 X156.245 Y125.105 E.0026
; LINE_WIDTH: 0.540684
G1 X156.268 Y124.972 E.00285
; LINE_WIDTH: 0.58603
G2 X156.284 Y124.525 I-1.15 J-.265 E.01036
; LINE_WIDTH: 0.57233
G1 X156.284 Y118.542 E.13429
G1 X156.835 Y118.542 E.01236
G1 X156.835 Y124.525 E.13429
; LINE_WIDTH: 0.58603
G1 X156.851 Y124.791 E.00612
G1 X156.903 Y124.888 E.00254
; LINE_WIDTH: 0.540684
G1 X156.954 Y124.986 E.00234
; LINE_WIDTH: 0.495337
G1 X157.006 Y125.083 E.00213
; LINE_WIDTH: 0.44999
G1 X157.292 Y125.529 E.00924
G1 X157.673 Y125.821 E.00839
G1 X157.957 Y125.886 E.00509
; LINE_WIDTH: 0.411405
G1 X158.241 Y125.951 E.00463
G1 X157.957 Y126.016 E.00463
; LINE_WIDTH: 0.44999
G1 X157.673 Y126.08 E.00509
G1 X157.292 Y126.373 E.00839
G1 X157.006 Y126.818 E.00924
; LINE_WIDTH: 0.49077
G1 X156.949 Y127.004 E.00372
; LINE_WIDTH: 0.53155
G1 X156.892 Y127.191 E.00405
; LINE_WIDTH: 0.57233
G1 X156.835 Y127.377 E.00437
G1 X156.835 Y129.304 E.04325
; WIPE_START
G1 X156.835 Y131.304 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.579 Y127.729 Z2.2 F30000
G1 X165.629 Y126.643 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.39724
G1 F6000
M204 S3000
G3 X166.221 Y126.885 I-1.148 J3.645 E.0098
; LINE_WIDTH: 0.39845
G1 X166.768 Y127.213 E.0098
; LINE_WIDTH: 0.4398
G1 X166.985 Y127.444 E.00541
; LINE_WIDTH: 0.48115
G1 X167.202 Y127.676 E.00594
; LINE_WIDTH: 0.51021
G1 X167.345 Y127.898 E.00527
; LINE_WIDTH: 0.53927
G1 X167.489 Y128.121 E.00558
; LINE_WIDTH: 0.58192
G1 X167.71 Y128.654 E.01318
; LINE_WIDTH: 0.61045
G1 X167.845 Y129.264 E.01499
; LINE_WIDTH: 0.63163
G1 X167.887 Y129.986 E.01798
; LINE_WIDTH: 0.63865
G1 X167.85 Y130.523 E.01355
; LINE_WIDTH: 0.64478
G3 X167.576 Y131.507 I-3.881 J-.55 E.026
; LINE_WIDTH: 0.64303
G1 X167.335 Y131.965 E.01311
; LINE_WIDTH: 0.62898
G1 X166.947 Y132.461 E.01559
; LINE_WIDTH: 0.60303
G1 X166.458 Y132.876 E.0152
; LINE_WIDTH: 0.55804
G1 X166.032 Y133.076 E.0103
G1 X165.494 Y133.227 E.01221
; LINE_WIDTH: 0.595907
G1 X165.291 Y133.24 E.00476
; LINE_WIDTH: 0.633774
G1 X165.089 Y133.253 E.00507
; LINE_WIDTH: 0.67164
G1 X164.886 Y133.267 E.00538
G1 X165.059 Y133.17 E.00526
; LINE_WIDTH: 0.633774
G1 X165.233 Y133.074 E.00495
; LINE_WIDTH: 0.595907
G1 X165.407 Y132.978 E.00465
; LINE_WIDTH: 0.55804
G1 X165.851 Y132.696 E.0115
; LINE_WIDTH: 0.57607
G1 X166.297 Y132.307 E.01337
; LINE_WIDTH: 0.61751
G1 X166.602 Y131.961 E.0112
; LINE_WIDTH: 0.63175
G1 X166.884 Y131.519 E.01303
; LINE_WIDTH: 0.64478
G1 X167.139 Y130.882 E.01742
G1 X167.257 Y130.264 E.016
; LINE_WIDTH: 0.63271
G1 X167.279 Y129.629 E.01582
; LINE_WIDTH: 0.61329
G1 X167.218 Y129.036 E.01436
; LINE_WIDTH: 0.58935
G1 X167.066 Y128.462 E.01375
; LINE_WIDTH: 0.54655
G1 X166.93 Y128.174 E.00681
; LINE_WIDTH: 0.512425
G1 X166.793 Y127.886 E.00637
; LINE_WIDTH: 0.4783
G1 X166.638 Y127.672 E.00493
; LINE_WIDTH: 0.43777
G1 X166.483 Y127.457 E.00449
; LINE_WIDTH: 0.39724
G1 X166.047 Y126.973 E.00998
G1 X165.676 Y126.68 E.00724
; WIPE_START
G1 X166.221 Y126.885 E-.22119
G1 X166.768 Y127.213 E-.24238
G1 X166.985 Y127.444 E-.12054
G1 X167.202 Y127.676 E-.12055
G1 X167.281 Y127.798 E-.05534
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.924 Y125.642 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X163.96 Y125.699 E.00119
; LINE_WIDTH: 0.48657
G1 X164.179 Y125.844 E.00497
; LINE_WIDTH: 0.52315
G1 X164.398 Y125.989 E.00537
; LINE_WIDTH: 0.53006
G1 X164.641 Y126.04 E.00515
; LINE_WIDTH: 0.57932
G2 X165.45 Y126.22 I1.637 J-5.451 E.01885
; LINE_WIDTH: 0.53621
G1 X165.632 Y126.25 E.00387
; LINE_WIDTH: 0.4931
G1 X165.814 Y126.28 E.00355
; LINE_WIDTH: 0.44999
G1 X166.318 Y126.476 E.00944
G1 X166.981 Y126.864 E.01341
G1 X167.44 Y127.274 E.01075
G3 X168.189 Y128.532 I-3.273 J2.801 E.02569
G1 X168.353 Y129.225 E.01242
G1 X168.406 Y130.018 E.01389
G3 X167.497 Y132.616 I-4.083 J.029 E.04901
G1 X167.138 Y132.98 E.00892
G1 X166.681 Y133.309 E.00984
G1 X166.217 Y133.526 E.00893
G1 X165.606 Y133.698 E.01109
G3 X162.388 Y133.948 I-2.943 J-17.055 E.05643
G1 X155.794 Y133.948 E.11513
G1 X155.794 Y118.052 E.27754
G1 X157.324 Y118.052 E.02672
G1 X157.324 Y124.525 E.11302
G1 X157.403 Y124.921 E.00704
G1 X157.605 Y125.236 E.00655
G1 X157.875 Y125.444 E.00594
G1 X158.367 Y125.566 E.00885
G2 X160.884 Y125.417 I.511 J-12.65 E.0441
G1 X161.462 Y125.228 E.01063
G1 X162.193 Y124.819 E.01462
G1 X162.725 Y124.357 E.01231
G2 X164.481 Y122.014 I-17.996 J-15.316 E.05116
G1 X167.14 Y118.052 E.0833
G1 X169.025 Y118.052 E.03292
G1 X167.964 Y119.747 E.03492
G3 X166.466 Y122.007 I-32.952 J-20.21 E.04734
G3 X164.665 Y123.733 I-5.532 J-3.97 E.04381
G1 X164.025 Y124.143 E.01327
G1 X163.774 Y124.442 E.00682
G1 X163.647 Y124.839 E.00727
G1 X163.69 Y125.264 E.00746
G1 X163.893 Y125.591 E.00672
M204 S10000
G1 X164.24 Y125.362 F30000
G1 F6000
M204 S3000
G1 X164.257 Y125.391 E.00059
G1 X164.521 Y125.541 E.00529
G3 X165.946 Y125.872 I-2.272 J12.998 E.02557
G1 X166.509 Y126.092 E.01055
G1 X167.235 Y126.515 E.01467
G1 X167.81 Y127.03 E.01347
G1 X168.256 Y127.633 E.0131
G1 X168.576 Y128.315 E.01316
G1 X168.746 Y128.983 E.01203
G3 X168.833 Y130.046 I-9.284 J1.299 E.01862
G3 X167.782 Y132.951 I-4.49 J.018 E.05508
G1 X167.364 Y133.358 E.01018
G1 X166.894 Y133.683 E.00997
G1 X166.367 Y133.929 E.01017
G1 X165.698 Y134.117 E.01213
G3 X162.393 Y134.376 I-3.035 J-17.495 E.05797
G1 X155.366 Y134.376 E.12269
G1 X155.366 Y117.624 E.2925
G1 X157.753 Y117.624 E.04168
G1 X157.753 Y124.525 E.1205
G1 X157.762 Y124.631 E.00186
G1 X157.918 Y124.944 E.0061
G1 X158.077 Y125.066 E.0035
G1 X158.366 Y125.138 E.00521
G2 X160.773 Y125.003 I.487 J-12.825 E.04214
G1 X161.266 Y124.846 E.00904
G1 X161.912 Y124.495 E.01283
G1 X162.445 Y124.033 E.01231
G2 X164.128 Y121.771 I-18.617 J-15.614 E.04927
G1 X166.911 Y117.624 E.0872
G1 X169.799 Y117.624 E.05042
G1 X168.738 Y119.319 E.03492
G3 X166.809 Y122.264 I-39.592 J-23.817 E.06147
G3 X164.358 Y124.43 I-6.174 J-4.516 E.05756
G1 X164.207 Y124.563 E.00351
G1 X164.094 Y124.78 E.00428
G1 X164.092 Y125.114 E.00582
G1 X164.209 Y125.31 E.00399
M204 S250
G1 X164.544 Y125.093 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X164.648 Y125.146 E.00189
G3 X166.694 Y125.72 I-1.09 J7.81 E.0346
G1 X167.479 Y126.179 E.01478
G1 X168.117 Y126.75 E.01389
G1 X168.613 Y127.42 E.01354
G1 X168.967 Y128.175 E.01355
G1 X169.147 Y128.882 E.01183
G3 X169.246 Y130.072 I-8.742 J1.329 E.01941
G1 X169.206 Y130.702 E.01025
G1 X169.065 Y131.404 E.01164
G1 X168.829 Y132.062 E.01135
G1 X168.5 Y132.677 E.01132
G1 X168.094 Y133.224 E.01106
G1 X167.628 Y133.678 E.01057
G1 X167.101 Y134.043 E.0104
G1 X166.511 Y134.318 E.01057
G1 X165.787 Y134.522 E.01222
G3 X162.397 Y134.79 I-3.123 J-17.921 E.0553
G1 X154.952 Y134.79 E.12089
G1 X154.952 Y117.21 E.28546
G1 X158.167 Y117.21 E.05219
G1 X158.167 Y124.525 E.11878
G1 X158.22 Y124.661 E.00238
G1 X158.366 Y124.724 E.00258
G2 X160.64 Y124.608 I.487 J-12.824 E.03702
G1 X161.078 Y124.479 E.00741
G1 X161.674 Y124.154 E.01102
G1 X162.198 Y123.696 E.0113
G2 X163.788 Y121.536 I-19.097 J-15.726 E.04357
G1 X166.69 Y117.21 E.08459
G1 X170.546 Y117.21 E.0626
G1 X168.423 Y120.6 E.06495
G3 X166.642 Y123.13 I-18.991 J-11.48 E.05028
G1 X166.043 Y123.735 E.01382
G3 X164.557 Y124.795 I-6.954 J-8.176 E.02968
G1 X164.485 Y124.929 E.00246
G1 X164.524 Y125.037 E.00187
; WIPE_START
M204 S3000
G1 X164.648 Y125.146 E-.06284
G1 X165.205 Y125.244 E-.21482
G1 X165.723 Y125.369 E-.20234
G1 X166.202 Y125.521 E-.19109
G1 X166.419 Y125.609 E-.08891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.711 Y130.676 Z2.2 F30000
G1 X158.152 Y132.949 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X157.837 Y132.863 E.0057
G1 X157.49 Y132.529 E.00841
G1 X157.34 Y132.146 E.00718
G1 X157.324 Y131.966 E.00315
G1 X157.324 Y127.377 E.08012
G1 X157.403 Y126.981 E.00704
G1 X157.605 Y126.666 E.00655
G1 X157.875 Y126.458 E.00594
G1 X158.367 Y126.335 E.00885
G1 X160.367 Y126.337 E.03492
G3 X163.639 Y126.424 I.607 J38.868 E.05716
; LINE_WIDTH: 0.48657
G1 X163.967 Y126.452 E.00624
; LINE_WIDTH: 0.52315
G1 X164.295 Y126.479 E.00674
; LINE_WIDTH: 0.56649
G1 X164.908 Y126.655 E.01416
; LINE_WIDTH: 0.57932
G3 X165.243 Y126.835 I-.095 J.578 E.00879
; LINE_WIDTH: 0.53621
G1 X165.396 Y126.954 E.00406
; LINE_WIDTH: 0.4931
G1 X165.549 Y127.072 E.00372
; LINE_WIDTH: 0.44999
G3 X166.502 Y128.301 I-2.1 J2.612 E.02739
G3 X166.588 Y130.895 I-3.77 J1.425 E.04615
G1 X166.374 Y131.383 E.0093
G1 X166.013 Y131.894 E.01092
G1 X165.533 Y132.328 E.0113
G3 X164.55 Y132.812 I-1.938 J-2.698 E.01922
G1 X163.934 Y132.943 E.011
G3 X160.208 Y133.005 I-2.696 J-50.217 E.06507
G1 X158.366 Y133.007 E.03217
G1 X158.21 Y132.965 E.00282
M204 S10000
G1 X158.261 Y132.55 F30000
G1 F6000
M204 S3000
G1 X158.055 Y132.494 E.00373
G1 X157.85 Y132.297 E.00495
G1 X157.753 Y131.966 E.00603
G1 X157.753 Y127.377 E.08012
G3 X158.077 Y126.836 I.681 J.041 E.01144
G1 X158.369 Y126.764 E.00526
G1 X160.369 Y126.766 E.03492
G3 X163.61 Y126.852 I.592 J38.926 E.05661
G3 X165.006 Y127.233 I-.242 J3.635 E.02545
G1 X165.496 Y127.594 E.01063
G1 X165.836 Y127.979 E.00897
G1 X166.098 Y128.445 E.00934
G1 X166.257 Y128.953 E.00928
G1 X166.341 Y129.684 E.01286
G1 X166.311 Y130.197 E.00898
G1 X166.185 Y130.751 E.00992
G1 X165.957 Y131.245 E.00949
G1 X165.664 Y131.639 E.00858
G1 X165.302 Y131.967 E.00851
G3 X163.906 Y132.516 I-1.913 J-2.815 E.02642
G3 X160.208 Y132.577 I-2.665 J-49.496 E.0646
G1 X158.366 Y132.579 E.03216
G1 X158.319 Y132.566 E.00085
M204 S250
G1 X158.366 Y132.165 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X158.198 Y132.073 E.0031
G1 X158.167 Y131.966 E.00182
G1 X158.167 Y127.377 E.07451
G1 X158.22 Y127.241 E.00238
G1 X158.369 Y127.177 E.00262
G1 X161.694 Y127.181 E.05399
G3 X164.169 Y127.349 I.112 J16.663 E.04032
G1 X164.712 Y127.542 E.00936
G3 X165.533 Y128.266 I-1.099 J2.073 E.01794
G1 X165.773 Y128.763 E.00895
G1 X165.902 Y129.293 E.00886
G3 X165.893 Y130.2 I-4.116 J.413 E.01476
G1 X165.755 Y130.705 E.00851
G3 X165.08 Y131.618 I-2.098 J-.846 E.01863
G3 X163.879 Y132.103 I-1.673 J-2.411 E.0212
G3 X160.207 Y132.163 I-2.726 J-54.39 E.05965
G1 X158.426 Y132.165 E.02893
; WIPE_START
M204 S3000
G1 X158.198 Y132.073 E-.0932
G1 X158.167 Y131.966 E-.04268
G1 X158.167 Y130.323 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.886 Y133.267 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S3000
G1 X164.554 Y133.33 E.00896
; LINE_WIDTH: 0.62207
G1 X164.222 Y133.394 E.00827
; LINE_WIDTH: 0.5725
G1 X163.66 Y133.441 E.01266
; LINE_WIDTH: 0.55022
G1 X163.054 Y133.464 E.01307
; LINE_WIDTH: 0.54592
G1 X162.383 Y133.474 E.01434
; LINE_WIDTH: 0.54068
G1 X162.209 Y133.476 E.00368
; LINE_WIDTH: 0.53768
G1 X160.209 Y133.477 E.04207
; LINE_WIDTH: 0.53568
G1 X158.367 Y133.477 E.03858
; LINE_WIDTH: 0.53384
G1 X158.366 Y133.477 E.00003
; WIPE_START
G1 X158.367 Y133.477 E-.00057
G1 X160.209 Y133.477 E-.69973
G1 X160.366 Y133.476 E-.05969
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.871 Y125.884 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.50096
G1 F6000
M204 S3000
G1 X160.807 Y125.889 E.00125
; LINE_WIDTH: 0.49122
G1 X160.417 Y125.913 E.00749
; LINE_WIDTH: 0.44249
G1 X160.026 Y125.937 E.00672
; LINE_WIDTH: 0.39376
G1 X159.42 Y125.95 E.00918
; LINE_WIDTH: 0.3662
G1 X158.37 Y125.951 E.01475
; LINE_WIDTH: 0.37282
G1 X158.241 Y125.951 E.00185
; WIPE_START
G1 X158.37 Y125.951 E-.04904
G1 X159.42 Y125.95 E-.39912
G1 X160.026 Y125.937 E-.23009
G1 X160.241 Y125.924 E-.08175
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.693 Y123.867 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.45056
G1 F6000
M204 S3000
G1 X163.399 Y124.233 E.0082
; WIPE_START
G1 X163.693 Y123.867 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.849 Y125.419 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.54422
G1 F6000
M204 S3000
G2 X162.851 Y125.527 I-.028 J.055 E.00542
; WIPE_START
G1 X162.783 Y125.532 E-.19609
G1 X162.751 Y125.475 E-.18797
G1 X162.783 Y125.419 E-.18797
G1 X162.849 Y125.419 E-.18796
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.639 Y126.627 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S3000
G1 X156.966 Y126.118 E.00995
G3 X157.163 Y125.951 I.576 J.483 E.00427
G1 X156.968 Y125.788 E.00418
G1 X156.639 Y125.299 E.0097
G1 X156.639 Y126.567 E.02085
M204 S10000
G1 X156.753 Y132.969 F30000
; LINE_WIDTH: 0.57486
G1 F6000
M204 S3000
G2 X156.757 Y133.08 I-.03 J.057 E.00614
; WIPE_START
G1 X156.683 Y133.088 E-.20014
G1 X156.649 Y133.028 E-.18662
G1 X156.683 Y132.969 E-.18663
G1 X156.753 Y132.969 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X153.733 Y125.959 Z2.2 F30000
G1 X146.21 Y108.49 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.2 F30000
G1 X167.79 Y108.49 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.234 Y110.885 Z2.2 F30000
G1 X131.727 Y121.709 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.51468
G1 F6000
M204 S3000
G1 X131.803 Y121.878 E.00373
G1 X131.938 Y122.02 E.00393
; LINE_WIDTH: 0.482335
G1 X132.072 Y122.162 E.00367
; LINE_WIDTH: 0.44999
G1 X132.59 Y122.482 E.01064
G1 X133.088 Y122.569 E.00882
; LINE_WIDTH: 0.497195
G1 X133.512 Y122.593 E.00823
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00904
G1 X133.59 Y122.804 E.00838
; LINE_WIDTH: 0.497195
G1 X133.244 Y122.992 E.00763
; LINE_WIDTH: 0.44999
G1 X132.921 Y123.381 E.00882
G1 X132.736 Y123.953 E.01049
; LINE_WIDTH: 0.4722
G1 X132.806 Y124.617 E.01227
G1 X133.5 Y126.493 E.03673
; LINE_WIDTH: 0.44985
G1 X134.195 Y128.368 E.03491
; LINE_WIDTH: 0.4275
G1 X134.889 Y130.244 E.03309
; LINE_WIDTH: 0.40515
G1 X135.29 Y131.325 E.01802
; LINE_WIDTH: 0.4044
G1 X135.406 Y131.582 E.00441
; LINE_WIDTH: 0.44999
G1 X135.717 Y131.973 E.00872
G1 X136.34 Y132.27 E.01204
G2 X137.011 Y132.255 I.304 J-1.438 E.01183
G1 X137.597 Y131.95 E.01154
; LINE_WIDTH: 0.45984
G1 X137.898 Y131.608 E.00813
G1 X138.021 Y131.343 E.00522
; LINE_WIDTH: 0.47269
G1 X138.729 Y129.473 E.03677
; LINE_WIDTH: 0.49801
G1 X139.437 Y127.602 E.03883
; LINE_WIDTH: 0.52333
G1 X140.145 Y125.732 E.0409
; LINE_WIDTH: 0.53814
G1 X140.559 Y124.638 E.02463
; LINE_WIDTH: 0.55128
G1 X140.628 Y124.424 E.00486
G1 X140.62 Y124.278 E.00314
; LINE_WIDTH: 0.517517
G1 X140.612 Y124.133 E.00294
; LINE_WIDTH: 0.483753
G1 X140.604 Y123.988 E.00274
; LINE_WIDTH: 0.44999
G1 X140.442 Y123.429 E.01016
G1 X140.125 Y123.02 E.00904
; LINE_WIDTH: 0.485785
G1 X139.632 Y122.812 E.01011
; LINE_WIDTH: 0.52158
G1 X139.14 Y122.605 E.01089
G1 X139.719 Y122.587 E.01181
; LINE_WIDTH: 0.485785
G1 X140.298 Y122.569 E.01096
; LINE_WIDTH: 0.44999
G1 X140.807 Y122.478 E.00904
G1 X141.31 Y122.165 E.01034
; LINE_WIDTH: 0.486633
G1 X141.447 Y121.992 E.00418
; LINE_WIDTH: 0.523277
G1 X141.584 Y121.819 E.00451
; LINE_WIDTH: 0.55992
G1 X141.721 Y121.646 E.00484
; LINE_WIDTH: 0.5738
G1 X142.445 Y119.782 E.04501
; LINE_WIDTH: 0.58167
G2 X142.925 Y118.546 I-177.652 J-69.604 E.03025
G1 X143.117 Y118.546 E.00439
G1 X143.531 Y118.546 E.00945
G2 X142.64 Y120.79 I322.528 J129.367 E.0551
; LINE_WIDTH: 0.56778
G1 X142.222 Y121.843 E.02522
; LINE_WIDTH: 0.55992
G2 X142.133 Y122.116 I1.951 J.791 E.0063
; LINE_WIDTH: 0.523217
G1 X142.053 Y122.365 E.00536
; LINE_WIDTH: 0.486603
G1 X141.973 Y122.615 E.00497
; LINE_WIDTH: 0.44999
G1 X141.377 Y124.103 E.02799
; LINE_WIDTH: 0.494065
G1 X141.209 Y124.463 E.00765
; LINE_WIDTH: 0.53814
G1 X141.041 Y124.824 E.00837
G1 X140.309 Y126.685 E.0421
; LINE_WIDTH: 0.51281
G1 X139.577 Y128.546 E.04004
; LINE_WIDTH: 0.48749
G1 X138.846 Y130.408 E.03798
; LINE_WIDTH: 0.46217
G1 X138.418 Y131.496 E.021
; LINE_WIDTH: 0.45984
G2 X138.092 Y132.306 I14.436 J6.276 E.01559
; LINE_WIDTH: 0.44999
G1 X137.606 Y133.519 E.02282
G1 X135.778 Y133.519 E.03193
G2 X135.119 Y131.868 I-26.011 J9.418 E.03104
; LINE_WIDTH: 0.42113
G1 X134.943 Y131.455 E.00731
; LINE_WIDTH: 0.41461
G1 X134.227 Y129.588 E.03204
; LINE_WIDTH: 0.43696
G1 X133.512 Y127.72 E.03386
; LINE_WIDTH: 0.45931
G1 X132.796 Y125.853 E.03568
; LINE_WIDTH: 0.4722
G2 X132.085 Y124.039 I-46.648 J17.252 E.03578
; LINE_WIDTH: 0.44999
G1 X131.502 Y122.543 E.02803
; LINE_WIDTH: 0.47587
G1 X131.368 Y122.161 E.0075
; LINE_WIDTH: 0.50175
G1 X131.233 Y121.779 E.00793
; LINE_WIDTH: 0.52463
G1 X130.517 Y119.912 E.041
; LINE_WIDTH: 0.53733
G2 X129.984 Y118.524 I-121.17 J45.803 E.03124
G1 X130.542 Y118.524 E.01173
G2 X131.297 Y120.57 I179.136 J-64.994 E.04584
; LINE_WIDTH: 0.51444
G1 X131.682 Y121.61 E.02228
; LINE_WIDTH: 0.51468
G1 X131.702 Y121.655 E.00098
M204 S10000
G1 X132.205 Y121.608 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X132.368 Y121.852 E.00512
G1 X132.735 Y122.079 E.00754
G1 X133.088 Y122.141 E.00625
G1 X140.298 Y122.141 E.12589
G1 X140.659 Y122.076 E.0064
G1 X141.015 Y121.855 E.00732
G1 X141.265 Y121.486 E.00777
G1 X142.585 Y118.052 E.06424
G1 X143.117 Y118.052 E.00929
G1 X144.261 Y118.052 E.01998
G1 X137.896 Y133.948 E.29896
G1 X135.485 Y133.948 E.04211
G1 X129.293 Y118.052 E.29785
G1 X130.873 Y118.052 E.02758
G1 X131.556 Y119.932 E.03492
G2 X132.118 Y121.477 I68.526 J-24.037 E.02871
G1 X132.172 Y121.558 E.0017
M204 S10000
G1 X132.559 Y121.38 F30000
G1 F6000
M204 S3000
G1 X132.665 Y121.542 E.00339
G1 X132.881 Y121.676 E.00444
G1 X133.088 Y121.712 E.00368
G1 X140.298 Y121.712 E.12589
G1 X140.417 Y121.7 E.0021
G1 X140.72 Y121.544 E.00595
G1 X140.867 Y121.327 E.00457
G1 X142.291 Y117.624 E.06928
G1 X143.117 Y117.624 E.01443
G1 X144.894 Y117.624 E.03104
G1 X138.186 Y134.376 E.31508
G1 X135.192 Y134.376 E.05229
G1 X128.666 Y117.624 E.31391
G1 X131.173 Y117.624 E.04376
G1 X132.512 Y121.309 E.06846
G1 X132.526 Y121.33 E.00044
M204 S250
G1 X132.901 Y121.167 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G2 X132.95 Y121.243 I.574 J-.321 E.00147
G1 X133.088 Y121.299 E.00241
G1 X140.298 Y121.299 E.11707
G1 X140.367 Y121.286 E.00114
G1 X140.483 Y121.173 E.00263
G1 X142.006 Y117.21 E.06895
G1 X143.117 Y117.21 E.01803
G1 X145.506 Y117.21 E.03878
G1 X138.466 Y134.79 E.30749
G1 X134.909 Y134.79 E.05776
G1 X128.062 Y117.21 E.30635
G1 X131.463 Y117.21 E.05523
G1 X132.829 Y120.97 E.06495
G2 X132.874 Y121.114 I.646 J-.123 E.00246
; WIPE_START
M204 S3000
G1 X132.95 Y121.243 E-.05716
G1 X133.088 Y121.299 E-.05637
G1 X134.789 Y121.299 E-.64646
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.788 Y128.865 Z2.2 F30000
G1 X136.166 Y131.725 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X135.988 Y131.64 E.00345
G1 X135.753 Y131.372 E.00622
G1 X135.665 Y131.188 E.00356
G1 X133.219 Y124.467 E.12488
G1 X133.162 Y123.999 E.00823
G1 X133.293 Y123.594 E.00743
G1 X133.522 Y123.318 E.00625
G1 X134.018 Y123.085 E.00957
G1 X134.197 Y123.069 E.00315
G1 X139.14 Y123.069 E.08629
G1 X139.837 Y123.338 E.01306
G1 X140.062 Y123.628 E.0064
G1 X140.177 Y124.023 E.0072
G1 X140.116 Y124.473 E.00793
G1 X137.62 Y131.194 E.12518
G1 X137.529 Y131.38 E.00361
G1 X137.319 Y131.624 E.00562
G1 X136.824 Y131.858 E.00956
G1 X136.429 Y131.851 E.0069
G1 X136.22 Y131.751 E.00403
M204 S10000
G1 X136.194 Y131.218 F30000
G1 F6000
M204 S3000
G1 X136.068 Y131.042 E.00378
G1 X133.622 Y124.32 E.12488
G1 X133.588 Y124.045 E.00485
G1 X133.719 Y123.728 E.00598
G1 X133.8 Y123.644 E.00203
G1 X134.092 Y123.507 E.00563
G1 X134.197 Y123.498 E.00186
G1 X139.14 Y123.498 E.08629
G1 X139.55 Y123.656 E.00768
G1 X139.682 Y123.826 E.00377
G1 X139.75 Y124.059 E.00424
G1 X139.714 Y124.324 E.00466
G1 X137.218 Y131.045 E.12518
G1 X137.041 Y131.298 E.00539
G1 X136.75 Y131.436 E.00563
G1 X136.517 Y131.431 E.00406
G1 X136.258 Y131.308 E.00502
G1 X136.228 Y131.267 E.00088
M204 S250
G1 X136.518 Y130.987 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X136.457 Y130.9 E.00173
G1 X134.01 Y124.179 E.11614
G1 X134.024 Y124.012 E.00272
G1 X134.163 Y123.914 E.00275
G1 X134.197 Y123.911 E.00056
G1 X139.14 Y123.911 E.08025
G1 X139.299 Y123.992 E.0029
G1 X139.335 Y124.152 E.00266
G1 X139.326 Y124.18 E.00048
G1 X136.829 Y130.906 E.1165
G1 X136.694 Y131.025 E.00292
G1 X136.577 Y130.999 E.00194
; WIPE_START
M204 S3000
G1 X136.457 Y130.9 E-.05928
G1 X135.826 Y129.167 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.14 Y122.605 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S3000
G1 X134.197 Y122.605 E.1007
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00559
; WIPE_START
G1 X134.197 Y122.605 E-.0997
G1 X135.935 Y122.605 E-.6603
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.393 Y123.666 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S3000
G1 X132.558 Y123.173 E.0087
G1 X132.709 Y122.949 E.00451
G1 X132.404 Y122.855 E.00533
G1 X131.958 Y122.558 E.00895
G1 X132.371 Y123.61 E.0189
; WIPE_START
G1 X131.958 Y122.558 E-.42968
G1 X132.404 Y122.855 E-.20356
G1 X132.709 Y122.949 E-.1212
G1 X132.701 Y122.961 E-.00556
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.333 Y122.978 Z2.2 F30000
G1 X140.691 Y122.979 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S3000
G1 X140.854 Y123.265 E.00622
G1 X141.013 Y123.811 E.01075
G1 X141.515 Y122.558 E.0255
G1 X141.004 Y122.876 E.01136
G1 X140.748 Y122.96 E.0051
; WIPE_START
G1 X141.004 Y122.876 E-.10257
G1 X141.515 Y122.558 E-.22853
G1 X141.095 Y123.606 E-.42891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.203 Y130.172 Z2.2 F30000
G1 X135.83 Y132.489 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S3000
G1 X136.067 Y133.097 E.01107
G2 X137.316 Y133.091 I.52 J-24.617 E.0212
G1 X137.572 Y132.44 E.01188
G1 X137.117 Y132.67 E.00865
G1 X136.623 Y132.713 E.00842
G1 X136.206 Y132.668 E.00713
G1 X135.884 Y132.515 E.00605
; WIPE_START
G1 X136.206 Y132.668 E-.13544
G1 X136.623 Y132.713 E-.15954
G1 X137.117 Y132.67 E-.18848
G1 X137.572 Y132.44 E-.19363
G1 X137.492 Y132.643 E-.08291
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.451 Y127.979 Z2.2 F30000
G1 X106.21 Y108.49 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y108.196 Z2.2 F30000
G1 X90.21 Y108.49 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.144 Y115.586 Z2.2 F30000
G1 X96.146 Y133.568 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.35597
G1 F6000
M204 S3000
G1 X95.782 Y133.672 E.00516
; LINE_WIDTH: 0.33261
G1 X95.116 Y133.798 E.00859
; LINE_WIDTH: 0.31593
G1 X94.438 Y133.87 E.00818
; LINE_WIDTH: 0.30859
G1 X93.747 Y133.896 E.0081
; LINE_WIDTH: 0.31477
G1 X93.046 Y133.868 E.00838
; LINE_WIDTH: 0.33132
G1 X92.347 Y133.788 E.00888
; LINE_WIDTH: 0.3643
G1 X91.56 Y133.626 E.01123
; LINE_WIDTH: 0.38649
G1 X91.015 Y133.454 E.0085
; LINE_WIDTH: 0.40816
G1 X90.539 Y133.257 E.00812
; LINE_WIDTH: 0.44963
G1 X89.963 Y132.977 E.01116
; LINE_WIDTH: 0.47195
G1 X89.53 Y132.693 E.00951
; LINE_WIDTH: 0.48939
G1 X89.084 Y132.335 E.0109
; LINE_WIDTH: 0.50523
G1 X88.639 Y131.903 E.01222
; LINE_WIDTH: 0.52781
G1 X88.156 Y131.324 E.01556
; LINE_WIDTH: 0.54901
G1 X87.836 Y130.862 E.01207
; LINE_WIDTH: 0.57222
G1 X87.576 Y130.415 E.01162
; LINE_WIDTH: 0.59243
G1 X87.31 Y129.858 E.01435
; LINE_WIDTH: 0.60335
G1 X87.094 Y129.264 E.01498
; LINE_WIDTH: 0.61368
G1 X86.92 Y128.633 E.0158
; LINE_WIDTH: 0.62061
G1 X86.822 Y128.136 E.01237
; LINE_WIDTH: 0.62174
G1 X86.744 Y127.622 E.01272
; LINE_WIDTH: 0.625
G1 X86.689 Y127.075 E.0135
; LINE_WIDTH: 0.62812
G1 X86.657 Y126.495 E.01435
; LINE_WIDTH: 0.62886
G1 X86.645 Y125.883 E.01517
; LINE_WIDTH: 0.632
G3 X86.765 Y124.217 I10.838 J-.059 E.04159
; LINE_WIDTH: 0.62599
G1 X86.918 Y123.392 E.02066
; LINE_WIDTH: 0.62228
G1 X87.088 Y122.763 E.01595
; LINE_WIDTH: 0.61732
G1 X87.279 Y122.219 E.014
; LINE_WIDTH: 0.61482
G1 X87.575 Y121.58 E.01703
; LINE_WIDTH: 0.60042
G1 X87.924 Y120.992 E.01612
; LINE_WIDTH: 0.5807
G1 X88.329 Y120.45 E.01542
; LINE_WIDTH: 0.55591
G1 X88.809 Y119.939 E.01527
; LINE_WIDTH: 0.5269
G1 X89.361 Y119.47 E.01492
; LINE_WIDTH: 0.49317
G1 X89.952 Y119.074 E.01368
; LINE_WIDTH: 0.45518
G1 X90.574 Y118.752 E.01237
; LINE_WIDTH: 0.41598
G1 X91.217 Y118.501 E.01109
; LINE_WIDTH: 0.37925
G1 X91.873 Y118.316 E.00994
; LINE_WIDTH: 0.34865
G1 X92.564 Y118.188 E.00938
; LINE_WIDTH: 0.32627
G1 X93.384 Y118.116 E.01022
; LINE_WIDTH: 0.31221
G1 X93.89 Y118.119 E.006
; LINE_WIDTH: 0.31836
G1 X94.701 Y118.146 E.00982
; LINE_WIDTH: 0.3404
G1 X95.476 Y118.255 E.01017
; LINE_WIDTH: 0.37063
G1 X96.205 Y118.433 E.01068
; LINE_WIDTH: 0.40536
G1 X96.876 Y118.674 E.01115
; LINE_WIDTH: 0.44117
G1 X97.492 Y118.973 E.01172
; LINE_WIDTH: 0.47538
G1 X98.061 Y119.33 E.01241
; LINE_WIDTH: 0.50635
G1 X98.587 Y119.745 E.01325
; LINE_WIDTH: 0.53435
G1 X99.074 Y120.222 E.01424
; LINE_WIDTH: 0.55948
G1 X99.51 Y120.749 E.01499
; LINE_WIDTH: 0.58147
G1 X99.896 Y121.341 E.01613
; LINE_WIDTH: 0.60064
G1 X100.244 Y122.043 E.01849
; LINE_WIDTH: 0.61475
G1 X100.518 Y122.788 E.01919
; LINE_WIDTH: 0.62417
G1 X100.721 Y123.571 E.01986
; LINE_WIDTH: 0.62955
G1 X100.859 Y124.388 E.02054
; LINE_WIDTH: 0.63713
G1 X100.952 Y125.498 E.02795
G1 X100.953 Y126.468 E.02432
; LINE_WIDTH: 0.63462
G1 X100.924 Y127.007 E.01349
; LINE_WIDTH: 0.62855
G1 X100.827 Y127.867 E.02142
; LINE_WIDTH: 0.61965
G1 X100.666 Y128.687 E.02035
; LINE_WIDTH: 0.60725
G1 X100.436 Y129.468 E.01943
; LINE_WIDTH: 0.58952
G1 X100.131 Y130.204 E.01845
; LINE_WIDTH: 0.56612
G1 X99.752 Y130.889 E.01736
; LINE_WIDTH: 0.53773
G1 X99.3 Y131.512 E.01619
; LINE_WIDTH: 0.50609
G1 X98.799 Y132.054 E.01457
; LINE_WIDTH: 0.47526
G1 X98.26 Y132.517 E.01313
; LINE_WIDTH: 0.44536
G1 X97.682 Y132.911 E.01209
; LINE_WIDTH: 0.41449
G1 X97.07 Y133.233 E.01107
; LINE_WIDTH: 0.38402
G1 X96.435 Y133.486 E.0101
; LINE_WIDTH: 0.35597
G1 X96.204 Y133.551 E.00327
; WIPE_START
G1 X95.782 Y133.672 E-.16655
G1 X95.116 Y133.798 E-.25758
G1 X94.438 Y133.87 E-.25898
G1 X94.236 Y133.878 E-.07689
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.858 Y126.71 Z2.2 F30000
G1 X98.972 Y120.93 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S3000
G1 X99.311 Y121.444 E.0138
; LINE_WIDTH: 0.59672
G1 X99.642 Y122.103 E.01729
; LINE_WIDTH: 0.61527
G1 X99.903 Y122.801 E.01803
; LINE_WIDTH: 0.62651
G1 X100.088 Y123.491 E.01762
; LINE_WIDTH: 0.63308
G1 X100.227 Y124.249 E.0192
; LINE_WIDTH: 0.63563
G3 X100.349 Y125.984 I-12.366 J1.74 E.04355
; LINE_WIDTH: 0.63443
G1 X100.326 Y126.855 E.02176
; LINE_WIDTH: 0.62953
G1 X100.253 Y127.652 E.01984
; LINE_WIDTH: 0.62185
G1 X100.126 Y128.412 E.01884
; LINE_WIDTH: 0.60881
G1 X99.946 Y129.135 E.01782
; LINE_WIDTH: 0.59354
G1 X99.706 Y129.819 E.0169
; LINE_WIDTH: 0.57402
G1 X99.414 Y130.439 E.01543
; LINE_WIDTH: 0.55094
G1 X99.087 Y130.978 E.0136
; LINE_WIDTH: 0.52555
G1 X98.704 Y131.48 E.01298
; LINE_WIDTH: 0.49762
G1 X98.266 Y131.942 E.01234
; LINE_WIDTH: 0.46894
G1 X97.788 Y132.351 E.01147
; LINE_WIDTH: 0.43985
G1 X97.266 Y132.708 E.01077
; LINE_WIDTH: 0.40979
G1 X96.693 Y133.012 E.01026
; LINE_WIDTH: 0.37994
G1 X96.061 Y133.262 E.00993
; LINE_WIDTH: 0.35226
G1 X95.365 Y133.451 E.00973
; LINE_WIDTH: 0.32919
G1 X94.602 Y133.57 E.00967
; LINE_WIDTH: 0.31323
G1 X93.878 Y133.608 E.00862
; LINE_WIDTH: 0.3138
G1 X93.31 Y133.592 E.00676
; LINE_WIDTH: 0.32712
G1 X92.553 Y133.51 E.00949
; LINE_WIDTH: 0.346
G1 X91.916 Y133.372 E.00862
; LINE_WIDTH: 0.37604
G1 X91.297 Y133.173 E.00939
; LINE_WIDTH: 0.40816
G1 X90.703 Y132.907 E.01026
; LINE_WIDTH: 0.44963
G1 X90.192 Y132.615 E.01026
; LINE_WIDTH: 0.47509
G1 X89.61 Y132.178 E.01346
; LINE_WIDTH: 0.49664
G1 X89.126 Y131.717 E.01294
; LINE_WIDTH: 0.52136
G1 X88.681 Y131.187 E.0141
; LINE_WIDTH: 0.54877
G1 X88.334 Y130.665 E.01346
; LINE_WIDTH: 0.57222
G1 X88.072 Y130.175 E.01247
; LINE_WIDTH: 0.59243
G1 X87.844 Y129.658 E.01314
; LINE_WIDTH: 0.60335
G1 X87.652 Y129.103 E.01392
; LINE_WIDTH: 0.61358
G1 X87.497 Y128.498 E.01507
; LINE_WIDTH: 0.61872
G1 X87.362 Y127.721 E.0192
; LINE_WIDTH: 0.625
G1 X87.291 Y127.03 E.01709
; LINE_WIDTH: 0.62812
G3 X87.251 Y125.966 I18.613 J-1.226 E.02632
; LINE_WIDTH: 0.6317
G1 X87.265 Y125.435 E.0132
; LINE_WIDTH: 0.63259
G3 X87.447 Y123.803 I10.97 J.394 E.04092
; LINE_WIDTH: 0.62992
G1 X87.614 Y123.093 E.0181
; LINE_WIDTH: 0.62439
G1 X87.699 Y122.807 E.0073
; LINE_WIDTH: 0.61383
G1 X87.905 Y122.244 E.01447
; LINE_WIDTH: 0.60427
G1 X88.216 Y121.593 E.01715
; LINE_WIDTH: 0.58513
G1 X88.595 Y120.986 E.01642
; LINE_WIDTH: 0.56044
G1 X89.04 Y120.432 E.01562
; LINE_WIDTH: 0.53221
G1 X89.525 Y119.949 E.01424
; LINE_WIDTH: 0.50136
G1 X90.039 Y119.538 E.01287
; LINE_WIDTH: 0.46644
G1 X90.591 Y119.187 E.01186
; LINE_WIDTH: 0.42844
G1 X91.177 Y118.9 E.01082
; LINE_WIDTH: 0.3904
G1 X91.791 Y118.679 E.00982
; LINE_WIDTH: 0.35589
G1 X92.428 Y118.522 E.00893
; LINE_WIDTH: 0.32832
G1 X93.083 Y118.428 E.00827
; LINE_WIDTH: 0.31053
G1 X93.753 Y118.395 E.0079
; LINE_WIDTH: 0.30572
G1 X94.414 Y118.417 E.00766
; LINE_WIDTH: 0.32208
G1 X95.059 Y118.495 E.00796
; LINE_WIDTH: 0.34481
G1 X95.689 Y118.636 E.00851
; LINE_WIDTH: 0.37508
G1 X96.302 Y118.839 E.0093
; LINE_WIDTH: 0.40998
G1 X96.891 Y119.109 E.01026
; LINE_WIDTH: 0.44637
G1 X97.451 Y119.445 E.01131
; LINE_WIDTH: 0.48136
G1 X97.977 Y119.845 E.01238
; LINE_WIDTH: 0.51276
G1 X98.463 Y120.306 E.01341
; LINE_WIDTH: 0.54273
G1 X98.912 Y120.838 E.01479
; LINE_WIDTH: 0.57196
G1 X98.94 Y120.88 E.00113
M204 S10000
G1 X98.586 Y121.208 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X98.886 Y121.702 E.01009
G3 X99.42 Y122.969 I-5.392 J3.018 E.02406
G3 X99.808 Y126.84 I-11.617 J3.118 E.06823
G3 X99.242 Y129.659 I-9.592 J-.461 E.05038
G3 X95.933 Y132.905 I-5.2 J-1.992 E.08346
G3 X92.603 Y133.146 I-2.156 J-6.651 E.05886
G3 X88.742 Y130.416 I.966 J-5.461 E.08529
G3 X87.805 Y126.983 I7.256 J-3.825 E.06265
G3 X88.18 Y122.977 I11.437 J-.949 E.07061
G3 X88.664 Y121.806 I6.493 J2.001 E.02215
G3 X93.769 Y118.749 I5.078 J2.688 E.1092
G3 X97.694 Y120.187 I.123 J5.738 E.07471
G3 X98.529 Y121.138 I-4.2 J4.533 E.02213
G1 X98.549 Y121.162 E.00053
M204 S10000
G1 X98.226 Y121.435 F30000
G1 F6000
M204 S3000
G1 X98.529 Y121.92 E.00999
G3 X98.799 Y122.496 I-4.622 J2.519 E.01111
G3 X99.371 Y125.185 I-8.571 J3.23 E.04818
G3 X99.044 Y128.912 I-11.512 J.867 E.06562
G3 X96.815 Y132.003 I-5.185 J-1.391 E.06801
G3 X93.844 Y132.824 I-2.955 J-4.908 E.05449
G3 X90.6 Y131.858 I-.119 J-5.534 E.06006
G3 X88.792 Y129.547 I3.199 J-4.365 E.05188
G3 X88.232 Y126.943 I8.093 J-3.103 E.04668
G3 X88.584 Y123.119 I11.265 J-.89 E.06739
G1 X88.784 Y122.558 E.01039
G3 X93.789 Y119.177 I4.963 J1.95 E.11211
G3 X98.194 Y121.385 I.118 J5.262 E.08953
M204 S250
G1 X97.871 Y121.656 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X98.625 Y123.246 I-4.123 J2.931 E.02873
G3 X98.966 Y126.817 I-10.895 J2.842 E.05849
G3 X98.446 Y129.384 I-8.698 J-.426 E.0427
G3 X95.933 Y132.009 I-4.436 J-1.732 E.06053
G3 X93.259 Y132.386 I-2.133 J-5.453 E.04425
G3 X89.414 Y129.9 I.348 J-4.755 E.07756
G3 X88.643 Y126.906 I6.771 J-3.338 E.05056
G3 X88.975 Y123.256 I10.864 J-.854 E.05979
G3 X91.74 Y120.006 I4.95 J1.411 E.07143
G3 X95.87 Y119.994 I2.08 J4.945 E.06884
G3 X97.835 Y121.607 I-2.122 J4.592 E.04173
; WIPE_START
M204 S3000
G1 X98.173 Y122.137 E-.23879
G1 X98.424 Y122.671 E-.22423
G1 X98.625 Y123.246 E-.23154
G1 X98.667 Y123.413 E-.06545
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.966 Y130.853 Z2.2 F30000
G1 X96.263 Y133.926 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X95.862 Y134.033 E.00724
G3 X91.479 Y134.004 I-2.125 J-10.184 E.07711
G1 X90.693 Y133.772 E.01431
G3 X89.737 Y133.34 I17.62 J-40.274 E.01831
G3 X87.429 Y131.113 I3.703 J-6.145 E.05648
G3 X86.416 Y128.72 I6.058 J-3.975 E.04562
G3 X86.339 Y123.59 I13.044 J-2.762 E.09013
G3 X87.507 Y120.724 I7.729 J1.478 E.0544
G3 X91.707 Y117.961 I5.59 J3.923 E.08988
G3 X93.366 Y117.756 I1.993 J9.29 E.02923
G1 X94.72 Y117.782 E.02365
G3 X97.678 Y118.59 I-.594 J7.997 E.05387
G3 X100.948 Y122.437 I-3.239 J6.065 E.09026
G3 X101.474 Y125.489 I-10.643 J3.408 E.05426
G3 X101.153 Y128.83 I-12.164 J.515 E.05878
G3 X100.56 Y130.434 I-7.662 J-1.919 E.02991
G1 X100.141 Y131.156 E.01457
G1 X99.645 Y131.811 E.01434
G3 X96.554 Y133.848 I-5.223 J-4.561 E.06544
G1 X96.321 Y133.91 E.00421
M204 S10000
G1 X96.373 Y134.339 F30000
G1 F6000
M204 S3000
G1 X95.955 Y134.451 E.00756
G3 X91.38 Y134.421 I-2.219 J-10.619 E.08049
G1 X90.545 Y134.175 E.0152
G1 X89.574 Y133.743 E.01856
G3 X85.997 Y128.806 I3.886 J-6.58 E.1095
G3 X85.918 Y123.506 I13.475 J-2.849 E.09312
G3 X87.154 Y120.48 I8.147 J1.561 E.05744
G3 X90.825 Y117.755 I5.842 J4.035 E.08127
G3 X93.353 Y117.327 I3.006 J10.055 E.04488
G1 X94.751 Y117.354 E.02442
G3 X97.876 Y118.209 I-.627 J8.433 E.05691
G3 X101.353 Y122.296 I-3.443 J6.451 E.09593
G3 X101.903 Y125.482 I-10.871 J3.517 E.05664
G3 X101.593 Y128.853 I-13.331 J.474 E.05927
G3 X100.212 Y131.811 I-7.816 J-1.848 E.05739
G3 X96.689 Y134.259 I-5.735 J-4.494 E.07603
G1 X96.431 Y134.324 E.00464
M204 S250
G1 X96.485 Y134.757 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X91.283 Y134.824 I-2.743 J-11.011 E.08522
G1 X90.402 Y134.564 E.01493
G1 X89.379 Y134.11 E.01816
G3 X85.488 Y128.382 I4.112 J-6.98 E.11618
G3 X85.513 Y123.425 I14.135 J-2.407 E.0809
G3 X86.813 Y120.246 I8.552 J1.641 E.05614
G3 X90.696 Y117.362 I6.182 J4.269 E.07997
G3 X93.34 Y116.913 I3.144 J10.506 E.04365
G1 X94.781 Y116.941 E.0234
G3 X98.066 Y117.841 I-.66 J8.855 E.05566
G3 X101.744 Y122.16 I-3.639 J6.824 E.0943
G3 X102.316 Y125.475 I-11.241 J3.648 E.05481
G3 X101.995 Y128.951 I-13.534 J.502 E.05685
G3 X101.012 Y131.376 I-9.292 J-2.357 E.04261
G3 X96.543 Y134.741 I-6.56 J-4.061 E.09296
; WIPE_START
M204 S3000
G1 X95.634 Y134.946 E-.35398
G1 X94.733 Y135.059 E-.34495
G1 X94.573 Y135.065 E-.06108
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.448 Y129.409 Z2.2 F30000
G1 X77.49 Y116.21 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.314 Y126.926 Z2.2 F30000
G1 X77.49 Y131.21 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.261 Y138.665 Z2.2 F30000
G1 X90.21 Y143.51 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y143.711 Z2.2 F30000
G1 X106.21 Y143.51 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.494 Y136.69 Z2.2 F30000
G1 X116.009 Y121.65 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X115.495 Y121.813 E.0094
G1 X114.985 Y122.317 E.01253
; LINE_WIDTH: 0.44625
G1 X113.938 Y124.022 E.03462
; LINE_WIDTH: 0.45012
G1 X112.891 Y125.726 E.03493
; LINE_WIDTH: 0.45399
G1 X111.845 Y127.43 E.03525
; LINE_WIDTH: 0.45786
G1 X110.798 Y129.134 E.03556
; LINE_WIDTH: 0.45901
G1 X110.487 Y129.64 E.01058
; LINE_WIDTH: 0.47181
G2 X110.045 Y130.37 I8.569 J5.689 E.01567
; LINE_WIDTH: 0.44999
G1 X108.115 Y133.519 E.06449
G1 X106.888 Y133.519 E.02141
G1 X106.888 Y129.519 E.06984
G2 X106.885 Y128.611 I-116.699 J-.032 E.01587
; LINE_WIDTH: 0.44341
G1 X106.885 Y118.477 E.17421
G1 X107.307 Y118.477 E.00725
G1 X107.307 Y128.611 E.17421
; LINE_WIDTH: 0.45612
G1 X107.323 Y128.865 E.00452
G1 X107.479 Y129.307 E.0083
; LINE_WIDTH: 0.44999
G1 X107.899 Y129.792 E.0112
G1 X108.459 Y130.049 E.01076
G1 X108.984 Y130.1 E.0092
G1 X109.595 Y129.909 E.01119
; LINE_WIDTH: 0.47181
G1 X109.97 Y129.616 E.00873
G1 X110.115 Y129.411 E.0046
; LINE_WIDTH: 0.45901
G1 X111.165 Y127.708 E.03565
; LINE_WIDTH: 0.45514
G1 X112.215 Y126.006 E.03534
; LINE_WIDTH: 0.45127
G1 X113.265 Y124.304 E.03502
; LINE_WIDTH: 0.4474
G1 X114.315 Y122.602 E.03471
; LINE_WIDTH: 0.44353
G1 X114.626 Y122.097 E.01021
; LINE_WIDTH: 0.44239
G1 X114.63 Y122.091 E.00011
; LINE_WIDTH: 0.44999
G2 X116.866 Y118.481 I-868.396 J-540.416 E.07416
G1 X118.207 Y118.481 E.02341
G1 X118.207 Y119.341 E.01503
G1 X118.207 Y121.341 E.03492
G2 X118.21 Y123.108 I227.257 J.46 E.03085
; LINE_WIDTH: 0.44341
G1 X118.21 Y133.523 E.17905
G1 X117.788 Y133.523 E.00725
G1 X117.788 Y123.108 E.17905
; LINE_WIDTH: 0.44999
G1 X117.616 Y122.411 E.01254
G1 X117.195 Y121.926 E.01121
G1 X116.634 Y121.669 E.01078
G1 X116.108 Y121.619 E.00923
G1 X116.066 Y121.632 E.00076
M204 S10000
G1 X116.079 Y122.067 F30000
G1 F6000
M204 S3000
G1 X115.711 Y122.183 E.00674
G1 X115.349 Y122.536 E.00882
G1 X108.355 Y133.948 E.2337
G1 X106.46 Y133.948 E.03309
G1 X106.46 Y118.052 E.27754
G1 X107.732 Y118.052 E.02222
G1 X107.732 Y128.052 E.1746
G2 X107.748 Y128.791 I4.251 J.279 E.01292
G1 X107.857 Y129.104 E.00579
G1 X108.154 Y129.448 E.00793
G1 X108.489 Y129.612 E.00653
G1 X108.948 Y129.673 E.00807
G1 X109.381 Y129.537 E.00793
G1 X109.641 Y129.325 E.00586
G1 X109.746 Y129.183 E.00308
G1 X116.627 Y118.052 E.22848
G1 X118.636 Y118.052 E.03506
G1 X118.636 Y119.341 E.02251
G1 X118.636 Y133.948 E.25503
G1 X117.363 Y133.948 E.02222
G1 X117.363 Y123.108 E.18926
G1 X117.238 Y122.614 E.0089
G1 X116.94 Y122.27 E.00794
G1 X116.605 Y122.106 E.00653
G1 X116.145 Y122.046 E.0081
G1 X116.136 Y122.049 E.00015
M204 S10000
G1 X116.149 Y122.483 F30000
G1 F6000
M204 S3000
G1 X115.927 Y122.554 E.00408
G1 X115.714 Y122.761 E.00519
G1 X108.595 Y134.376 E.23786
G1 X106.031 Y134.376 E.04476
G1 X106.031 Y117.624 E.2925
G1 X108.161 Y117.624 E.03718
G1 X108.161 Y128.611 E.19184
G1 X108.234 Y128.901 E.00523
G1 X108.409 Y129.103 E.00467
G1 X108.606 Y129.2 E.00384
G1 X108.912 Y129.246 E.00539
G1 X109.167 Y129.166 E.00467
G1 X109.382 Y128.958 E.00523
G1 X116.389 Y117.624 E.23265
G1 X119.064 Y117.624 E.04671
G1 X119.064 Y119.341 E.02999
G1 X119.064 Y134.376 E.26251
G1 X116.935 Y134.376 E.03718
G1 X116.935 Y123.108 E.19675
G1 X116.861 Y122.817 E.00523
G1 X116.686 Y122.615 E.00467
G1 X116.488 Y122.518 E.00384
G1 X116.208 Y122.477 E.00495
M204 S250
G1 X116.218 Y122.885 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X116.065 Y122.979 E.0029
G1 X108.826 Y134.79 E.22494
G1 X105.618 Y134.79 E.0521
G1 X105.618 Y117.21 E.28546
G1 X108.574 Y117.21 E.04801
G1 X108.574 Y128.611 E.18512
G1 X108.655 Y128.771 E.00291
G1 X108.877 Y128.834 E.00375
G1 X109.03 Y128.74 E.00291
M73 P94 R3
G1 X116.158 Y117.21 E.22011
G1 X119.478 Y117.21 E.0539
G1 X119.478 Y119.341 E.03461
G1 X119.478 Y134.79 E.25085
G1 X116.521 Y134.79 E.04801
G1 X116.521 Y123.108 E.18969
G1 X116.44 Y122.948 E.00291
G1 X116.275 Y122.901 E.00278
; WIPE_START
M204 S3000
G1 X116.065 Y122.979 E-.08506
G1 X115.137 Y124.493 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.793 Y121.992 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S3000
G1 X117.793 Y118.894 E.05031
G1 X117.097 Y118.894 E.01132
G1 X115.564 Y121.363 E.04719
G1 X116.113 Y121.208 E.00926
G1 X116.803 Y121.289 E.01128
G1 X117.41 Y121.574 E.0109
G1 X117.753 Y121.948 E.00824
M204 S10000
G1 X117.395 Y121.123 F30000
G1 F6000
M204 S3000
G1 X117.395 Y119.293 E.02972
G1 X117.304 Y119.316 E.00153
G1 X116.36 Y120.836 E.02905
G1 X116.918 Y120.906 E.00912
G1 X117.34 Y121.098 E.00754
M204 S10000
G1 X117.031 Y120.488 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S3000
G1 X116.96 Y120.529 E.00125
G1 X117.02 Y120.563 E.00105
; WIPE_START
G1 X116.96 Y120.529 E-.34737
G1 X117.031 Y120.488 E-.41263
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.427 Y126.575 Z2.2 F30000
G1 X109.577 Y130.342 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X109.061 Y130.504 E.00878
G1 X108.29 Y130.429 E.01258
G1 X107.683 Y130.143 E.01089
G1 X107.307 Y129.732 E.00905
G1 X107.302 Y133.106 E.05478
G1 X107.883 Y133.106 E.00943
G1 X109.546 Y130.393 E.05166
M204 S10000
G1 X108.775 Y130.888 F30000
G1 F6000
M204 S3000
G1 X108.242 Y130.824 E.00871
G1 X107.704 Y130.597 E.00948
G1 X107.701 Y132.64 E.03317
G1 X108.744 Y130.94 E.03238
M204 S10000
G1 X108.131 Y131.165 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S3000
G2 X108.122 Y131.253 I-.025 J.042 E.00327
; CHANGE_LAYER
; Z_HEIGHT: 1.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X108.081 Y131.253 E-.16312
G1 X108.055 Y131.209 E-.19896
G1 X108.081 Y131.165 E-.19898
G1 X108.131 Y131.165 E-.19893
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/24
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.2 I.253 J1.19 P1  F30000
G1 X178.51 Y116.21 Z2.2
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F3600
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.3 F30000
G1 X178.51 Y131.21 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.3 F30000
G1 X162.21 Y143.51 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.3 F30000
G1 X146.21 Y143.51 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.608 Y136.374 Z2.3 F30000
G1 X149.726 Y133.458 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S3000
G1 X149.175 Y133.458 E.01236
G1 X149.175 Y118.542 E.33479
G1 X149.726 Y118.542 E.01236
G1 X149.726 Y118.817 E.00618
G1 X149.726 Y133.398 E.32726
M204 S10000
G1 X150.215 Y133.948 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X148.685 Y133.948 E.02672
G1 X148.685 Y118.052 E.27754
G1 X150.215 Y118.052 E.02672
G1 X150.215 Y118.817 E.01336
G1 X150.215 Y133.888 E.26313
M204 S10000
G1 X150.644 Y134.376 F30000
G1 F6000
M204 S3000
G1 X148.257 Y134.376 E.04168
G1 X148.257 Y117.624 E.2925
G1 X150.644 Y117.624 E.04168
G1 X150.644 Y118.817 E.02084
G1 X150.644 Y134.316 E.27062
M204 S250
G1 X151.057 Y134.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
; WIPE_START
M204 S3000
G1 X149.058 Y134.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.169 Y130.195 Z2.3 F30000
G1 X163.885 Y123.673 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54611
G1 F6000
M204 S3000
G2 X164.559 Y122.741 I-10.854 J-8.569 E.02459
; LINE_WIDTH: 0.55718
G1 X164.889 Y122.272 E.01252
; LINE_WIDTH: 0.582185
G1 X165.054 Y122.048 E.00636
; LINE_WIDTH: 0.60719
G1 X165.22 Y121.824 E.00665
; LINE_WIDTH: 0.62971
G1 X165.555 Y121.345 E.01448
; LINE_WIDTH: 0.63992
G2 X166.573 Y119.832 I-84.883 J-58.216 E.04596
; LINE_WIDTH: 0.63471
M73 P94 R2
G1 X167.324 Y118.693 E.03408
; LINE_WIDTH: 0.6132
G1 X167.412 Y118.562 E.0038
G1 X168.104 Y118.562 E.01669
G1 X167.82 Y119.015 E.01288
; LINE_WIDTH: 0.63471
G1 X167.086 Y120.168 E.03416
; LINE_WIDTH: 0.63992
G3 X166.046 Y121.703 I-28.868 J-18.438 E.04671
; LINE_WIDTH: 0.62971
G1 X165.673 Y122.191 E.01522
; LINE_WIDTH: 0.60719
G1 X165.481 Y122.407 E.00691
; LINE_WIDTH: 0.58124
G1 X165.289 Y122.624 E.0066
; LINE_WIDTH: 0.55529
G1 X164.843 Y123.019 E.01296
; LINE_WIDTH: 0.54611
G3 X163.936 Y123.641 I-7.635 J-10.174 E.02352
; WIPE_START
G1 X164.559 Y122.741 E-.41593
G1 X164.889 Y122.272 E-.218
G1 X165.054 Y122.048 E-.10586
G1 X165.086 Y122.005 E-.02021
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.973 Y124.71 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X163.006 Y124.681 E.00077
; LINE_WIDTH: 0.45054
G1 X163.399 Y124.233 E.01042
G1 X163.27 Y124.543 E.00587
; LINE_WIDTH: 0.44999
G1 X163.221 Y124.793 E.00445
G1 X163.281 Y125.393 E.01053
G1 X163.655 Y125.996 E.01238
G2 X161.686 Y125.91 I-2.33 J30.976 E.03442
; LINE_WIDTH: 0.475475
G1 X161.278 Y125.897 E.00754
; LINE_WIDTH: 0.50096
G1 X160.871 Y125.884 E.00796
G1 X160.999 Y125.847 E.00261
; LINE_WIDTH: 0.48376
G1 X161.618 Y125.629 E.01236
; LINE_WIDTH: 0.44999
G1 X162.182 Y125.339 E.01107
G1 X162.474 Y125.143 E.00614
G1 X162.927 Y124.749 E.01049
; WIPE_START
G1 X163.006 Y124.681 E-.03959
G1 X163.399 Y124.233 E-.22641
G1 X163.27 Y124.543 E-.12769
G1 X163.221 Y124.793 E-.09677
G1 X163.281 Y125.393 E-.22909
G1 X163.337 Y125.483 E-.04045
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.835 Y124.394 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S3000
G1 X156.835 Y124.525 E.00294
; LINE_WIDTH: 0.58603
G1 X156.851 Y124.791 E.00612
G1 X156.903 Y124.888 E.00254
; LINE_WIDTH: 0.540684
G1 X156.954 Y124.986 E.00234
; LINE_WIDTH: 0.495337
G1 X157.006 Y125.083 E.00213
; LINE_WIDTH: 0.44999
G1 X157.292 Y125.529 E.00924
G1 X157.673 Y125.821 E.00839
G1 X157.957 Y125.886 E.00509
; LINE_WIDTH: 0.411405
G1 X158.241 Y125.951 E.00463
G1 X157.957 Y126.016 E.00463
; LINE_WIDTH: 0.44999
G1 X157.673 Y126.08 E.00509
G1 X157.292 Y126.373 E.00839
G1 X157.006 Y126.818 E.00924
; LINE_WIDTH: 0.49077
G1 X156.949 Y127.004 E.00372
; LINE_WIDTH: 0.53155
G1 X156.892 Y127.191 E.00405
; LINE_WIDTH: 0.57233
G1 X156.835 Y127.377 E.00437
G1 X156.835 Y131.966 E.103
; LINE_WIDTH: 0.58603
G1 X156.851 Y132.231 E.00612
G1 X156.944 Y132.408 E.00458
; LINE_WIDTH: 0.540684
G1 X157.037 Y132.584 E.00422
; LINE_WIDTH: 0.495337
G1 X157.129 Y132.761 E.00385
; LINE_WIDTH: 0.44999
G1 X157.62 Y133.232 E.01187
; LINE_WIDTH: 0.491915
G1 X157.993 Y133.355 E.00753
; LINE_WIDTH: 0.53384
G1 X158.366 Y133.477 E.0082
G1 X157.954 Y133.498 E.00862
; LINE_WIDTH: 0.491915
G1 X157.541 Y133.519 E.00791
; LINE_WIDTH: 0.44999
G1 X156.223 Y133.519 E.02302
G1 X156.223 Y133.027 E.0086
; LINE_WIDTH: 0.49077
G1 X156.243 Y132.673 E.00678
; LINE_WIDTH: 0.53155
G1 X156.264 Y132.319 E.00736
; LINE_WIDTH: 0.57233
G1 X156.284 Y131.966 E.00795
G1 X156.284 Y127.966 E.08978
G2 X156.264 Y127.139 I-4.825 J-.294 E.01858
; LINE_WIDTH: 0.53155
G1 X156.243 Y126.901 E.00496
; LINE_WIDTH: 0.49077
G1 X156.223 Y126.664 E.00456
; LINE_WIDTH: 0.44999
G1 X156.223 Y125.238 E.02489
; LINE_WIDTH: 0.495337
G1 X156.245 Y125.105 E.0026
; LINE_WIDTH: 0.540684
G1 X156.268 Y124.972 E.00285
; LINE_WIDTH: 0.58603
G2 X156.284 Y124.525 I-1.15 J-.265 E.01036
; LINE_WIDTH: 0.57233
G1 X156.284 Y118.542 E.13429
G1 X156.835 Y118.542 E.01236
G1 X156.835 Y124.334 E.13001
; WIPE_START
G1 X156.835 Y124.525 E-.07253
G1 X156.851 Y124.791 E-.10116
G1 X156.903 Y124.888 E-.04195
G1 X156.954 Y124.986 E-.04195
G1 X157.006 Y125.083 E-.04194
G1 X157.292 Y125.529 E-.20116
G1 X157.673 Y125.821 E-.18256
G1 X157.87 Y125.866 E-.07674
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.465 Y126.626 Z2.3 F30000
G1 X165.629 Y126.643 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.39724
G1 F6000
M204 S3000
G3 X166.221 Y126.885 I-1.148 J3.645 E.0098
; LINE_WIDTH: 0.39846
G1 X166.768 Y127.213 E.0098
; LINE_WIDTH: 0.439805
G1 X166.985 Y127.444 E.00541
; LINE_WIDTH: 0.48115
G1 X167.202 Y127.676 E.00594
; LINE_WIDTH: 0.51021
G1 X167.345 Y127.898 E.00527
; LINE_WIDTH: 0.53927
G1 X167.489 Y128.121 E.00558
; LINE_WIDTH: 0.58192
G1 X167.71 Y128.654 E.01318
; LINE_WIDTH: 0.61045
G1 X167.845 Y129.264 E.01499
; LINE_WIDTH: 0.63163
G1 X167.887 Y129.986 E.01798
; LINE_WIDTH: 0.63865
G1 X167.85 Y130.523 E.01355
; LINE_WIDTH: 0.64477
G3 X167.576 Y131.507 I-3.882 J-.55 E.026
; LINE_WIDTH: 0.64302
G1 X167.335 Y131.965 E.01311
; LINE_WIDTH: 0.62896
G1 X166.947 Y132.461 E.01559
; LINE_WIDTH: 0.60303
G1 X166.458 Y132.876 E.0152
; LINE_WIDTH: 0.55802
G1 X166.032 Y133.076 E.0103
G1 X165.494 Y133.227 E.01221
; LINE_WIDTH: 0.595894
G1 X165.291 Y133.24 E.00476
; LINE_WIDTH: 0.633767
G1 X165.089 Y133.253 E.00507
; LINE_WIDTH: 0.67164
G1 X164.886 Y133.267 E.00538
G1 X165.059 Y133.17 E.00526
; LINE_WIDTH: 0.633767
G1 X165.233 Y133.074 E.00495
; LINE_WIDTH: 0.595894
G1 X165.407 Y132.978 E.00465
; LINE_WIDTH: 0.55802
G1 X165.851 Y132.696 E.0115
; LINE_WIDTH: 0.57607
G1 X166.297 Y132.307 E.01337
; LINE_WIDTH: 0.61751
G1 X166.602 Y131.961 E.0112
; LINE_WIDTH: 0.63174
G1 X166.884 Y131.519 E.01303
; LINE_WIDTH: 0.64477
G1 X167.139 Y130.882 E.01742
G1 X167.257 Y130.264 E.016
; LINE_WIDTH: 0.63271
G1 X167.279 Y129.629 E.01582
; LINE_WIDTH: 0.61329
G1 X167.218 Y129.036 E.01436
; LINE_WIDTH: 0.58935
G1 X167.066 Y128.462 E.01375
; LINE_WIDTH: 0.54655
G1 X166.93 Y128.174 E.00681
; LINE_WIDTH: 0.51242
G1 X166.793 Y127.886 E.00637
; LINE_WIDTH: 0.47829
G1 X166.638 Y127.672 E.00493
; LINE_WIDTH: 0.437765
G1 X166.483 Y127.457 E.00449
; LINE_WIDTH: 0.39724
G1 X166.047 Y126.973 E.00998
G1 X165.676 Y126.68 E.00724
; WIPE_START
G1 X166.221 Y126.885 E-.22119
G1 X166.768 Y127.213 E-.24239
G1 X166.985 Y127.444 E-.12054
G1 X167.202 Y127.676 E-.12054
G1 X167.281 Y127.798 E-.05534
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.648 Y124.849 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X163.69 Y125.264 E.00728
G1 X163.96 Y125.699 E.00895
; LINE_WIDTH: 0.48657
G1 X164.179 Y125.844 E.00497
; LINE_WIDTH: 0.52315
G1 X164.398 Y125.989 E.00537
; LINE_WIDTH: 0.53006
G1 X164.641 Y126.04 E.00515
; LINE_WIDTH: 0.57932
G2 X165.45 Y126.22 I1.637 J-5.451 E.01885
; LINE_WIDTH: 0.53621
G1 X165.632 Y126.25 E.00387
; LINE_WIDTH: 0.4931
G1 X165.814 Y126.28 E.00355
; LINE_WIDTH: 0.44999
G1 X166.318 Y126.476 E.00944
G1 X166.981 Y126.864 E.01341
G1 X167.44 Y127.274 E.01075
G3 X168.189 Y128.532 I-3.272 J2.801 E.02569
G1 X168.353 Y129.225 E.01242
G1 X168.406 Y130.018 E.01389
G3 X167.497 Y132.616 I-4.083 J.029 E.04901
G1 X167.138 Y132.98 E.00892
G1 X166.681 Y133.309 E.00984
G1 X166.217 Y133.526 E.00893
G1 X165.606 Y133.698 E.01109
G3 X162.388 Y133.948 I-2.943 J-17.055 E.05643
G1 X155.794 Y133.948 E.11513
G1 X155.794 Y118.052 E.27754
G1 X157.324 Y118.052 E.02672
G1 X157.324 Y124.525 E.11302
G1 X157.403 Y124.921 E.00704
G1 X157.605 Y125.236 E.00655
G1 X157.875 Y125.444 E.00594
G1 X158.367 Y125.566 E.00885
G2 X160.884 Y125.417 I.511 J-12.649 E.0441
G1 X161.462 Y125.228 E.01063
G1 X162.193 Y124.819 E.01462
G1 X162.725 Y124.357 E.01231
G2 X164.481 Y122.014 I-18.002 J-15.321 E.05116
G1 X167.14 Y118.052 E.0833
G1 X169.025 Y118.052 E.03292
G1 X167.964 Y119.747 E.03492
G3 X166.466 Y122.007 I-32.948 J-20.208 E.04734
G3 X164.666 Y123.733 I-5.532 J-3.97 E.04379
G1 X164.025 Y124.143 E.01329
G1 X163.774 Y124.442 E.00682
G1 X163.662 Y124.791 E.0064
M204 S10000
G1 X164.093 Y124.896 F30000
G1 F6000
M204 S3000
G1 X164.092 Y125.114 E.00381
G1 X164.257 Y125.391 E.00563
G1 X164.521 Y125.541 E.00529
G3 X165.946 Y125.872 I-2.272 J12.998 E.02557
G1 X166.509 Y126.092 E.01055
G1 X167.235 Y126.515 E.01467
G1 X167.81 Y127.03 E.01347
G1 X168.256 Y127.633 E.0131
G1 X168.576 Y128.315 E.01316
G1 X168.746 Y128.983 E.01203
G3 X168.833 Y130.046 I-9.283 J1.299 E.01862
G3 X167.782 Y132.951 I-4.49 J.018 E.05507
G1 X167.364 Y133.358 E.01018
G1 X166.894 Y133.683 E.00997
G1 X166.367 Y133.929 E.01017
G1 X165.698 Y134.117 E.01213
G3 X162.393 Y134.376 I-3.035 J-17.495 E.05797
G1 X155.366 Y134.376 E.12269
G1 X155.366 Y117.624 E.2925
G1 X157.753 Y117.624 E.04168
G1 X157.753 Y124.525 E.1205
G1 X157.762 Y124.631 E.00186
G1 X157.918 Y124.944 E.0061
G1 X158.077 Y125.066 E.0035
G1 X158.366 Y125.138 E.00521
G2 X160.773 Y125.003 I.487 J-12.825 E.04214
G1 X161.266 Y124.846 E.00904
G1 X161.912 Y124.495 E.01283
G1 X162.445 Y124.033 E.01231
G2 X164.128 Y121.771 I-18.625 J-15.62 E.04927
G1 X166.911 Y117.624 E.0872
G1 X169.799 Y117.624 E.05042
G1 X168.738 Y119.319 E.03492
G3 X166.809 Y122.264 I-39.592 J-23.817 E.06147
G3 X164.358 Y124.43 I-6.174 J-4.516 E.05756
G1 X164.207 Y124.563 E.00351
G1 X164.094 Y124.78 E.00428
G1 X164.094 Y124.836 E.00097
M204 S250
G1 X164.485 Y124.929 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X164.544 Y125.093 E.00285
G1 X164.648 Y125.146 E.00189
G3 X166.694 Y125.72 I-1.09 J7.81 E.0346
G1 X167.479 Y126.179 E.01478
G1 X168.117 Y126.75 E.01389
G1 X168.613 Y127.42 E.01354
G1 X168.967 Y128.175 E.01355
G1 X169.147 Y128.882 E.01183
G3 X169.246 Y130.072 I-8.742 J1.329 E.01941
G1 X169.206 Y130.702 E.01025
G1 X169.065 Y131.404 E.01164
G1 X168.829 Y132.062 E.01135
G1 X168.5 Y132.677 E.01132
G1 X168.094 Y133.224 E.01106
G1 X167.628 Y133.678 E.01057
G1 X167.101 Y134.043 E.0104
G1 X166.511 Y134.318 E.01057
G1 X165.787 Y134.522 E.01222
G3 X162.397 Y134.79 I-3.123 J-17.921 E.0553
G1 X154.952 Y134.79 E.12089
G1 X154.952 Y117.21 E.28546
G1 X158.167 Y117.21 E.05219
G1 X158.167 Y124.525 E.11878
G1 X158.22 Y124.661 E.00238
G1 X158.366 Y124.724 E.00258
G2 X160.64 Y124.608 I.487 J-12.824 E.03702
G1 X161.078 Y124.479 E.00741
G1 X161.674 Y124.154 E.01102
G1 X162.198 Y123.696 E.0113
G2 X163.788 Y121.536 I-19.105 J-15.732 E.04357
G1 X166.69 Y117.21 E.08459
G1 X170.546 Y117.21 E.0626
G1 X168.423 Y120.6 E.06495
G3 X166.642 Y123.13 I-18.991 J-11.48 E.05028
G1 X166.043 Y123.735 E.01382
G3 X164.557 Y124.795 I-6.948 J-8.169 E.02968
G1 X164.513 Y124.876 E.00149
; WIPE_START
M204 S3000
G1 X164.544 Y125.093 E-.08347
G1 X164.648 Y125.146 E-.04422
G1 X165.205 Y125.244 E-.21482
G1 X165.723 Y125.369 E-.20234
G1 X166.202 Y125.521 E-.19109
G1 X166.261 Y125.544 E-.02405
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.624 Y130.691 Z2.3 F30000
G1 X158.152 Y132.949 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X157.837 Y132.863 E.0057
G1 X157.49 Y132.529 E.00841
G1 X157.34 Y132.146 E.00718
G1 X157.324 Y131.966 E.00315
G1 X157.324 Y127.377 E.08012
G1 X157.403 Y126.981 E.00704
G1 X157.605 Y126.666 E.00655
G1 X157.875 Y126.458 E.00594
G1 X158.367 Y126.335 E.00885
G1 X160.367 Y126.337 E.03492
G3 X163.639 Y126.424 I.607 J38.861 E.05716
; LINE_WIDTH: 0.48657
G1 X163.967 Y126.452 E.00624
; LINE_WIDTH: 0.52315
G1 X164.295 Y126.479 E.00674
; LINE_WIDTH: 0.56649
G1 X164.908 Y126.655 E.01416
; LINE_WIDTH: 0.57932
G3 X165.243 Y126.835 I-.095 J.578 E.00879
; LINE_WIDTH: 0.53621
G1 X165.396 Y126.954 E.00406
; LINE_WIDTH: 0.4931
G1 X165.549 Y127.072 E.00372
; LINE_WIDTH: 0.44999
G3 X166.502 Y128.301 I-2.101 J2.612 E.02739
G3 X166.588 Y130.895 I-3.77 J1.425 E.04616
G1 X166.374 Y131.383 E.0093
G1 X166.013 Y131.895 E.01092
G1 X165.533 Y132.328 E.0113
G3 X164.55 Y132.812 I-1.938 J-2.698 E.01922
G1 X163.934 Y132.943 E.011
G3 X160.208 Y133.005 I-2.696 J-50.185 E.06507
G1 X158.366 Y133.007 E.03217
G1 X158.21 Y132.965 E.00282
M204 S10000
G1 X158.261 Y132.55 F30000
G1 F6000
M204 S3000
G1 X158.055 Y132.494 E.00373
G1 X157.85 Y132.297 E.00495
G1 X157.753 Y131.966 E.00603
G1 X157.753 Y127.377 E.08012
G3 X158.077 Y126.836 I.681 J.041 E.01144
G1 X158.369 Y126.764 E.00526
G1 X160.369 Y126.766 E.03492
G3 X163.61 Y126.852 I.592 J38.926 E.05661
G3 X165.006 Y127.233 I-.242 J3.635 E.02545
G1 X165.496 Y127.594 E.01063
G1 X165.836 Y127.979 E.00897
G1 X166.098 Y128.445 E.00934
G1 X166.257 Y128.953 E.00928
G1 X166.341 Y129.684 E.01286
G1 X166.311 Y130.197 E.00898
G1 X166.185 Y130.751 E.00992
G1 X165.957 Y131.245 E.00949
G1 X165.664 Y131.639 E.00858
G1 X165.302 Y131.967 E.00851
G3 X163.906 Y132.516 I-1.913 J-2.815 E.02641
G3 X160.208 Y132.577 I-2.665 J-49.482 E.0646
G1 X158.366 Y132.579 E.03216
G1 X158.319 Y132.566 E.00085
M204 S250
G1 X158.366 Y132.165 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X158.198 Y132.073 E.0031
G1 X158.167 Y131.966 E.00182
G1 X158.167 Y127.377 E.07451
G1 X158.22 Y127.241 E.00238
G1 X158.369 Y127.177 E.00262
G1 X161.694 Y127.181 E.05399
G3 X164.169 Y127.349 I.112 J16.663 E.04032
G1 X164.712 Y127.542 E.00936
G3 X165.533 Y128.266 I-1.099 J2.073 E.01794
G1 X165.773 Y128.763 E.00895
G1 X165.902 Y129.293 E.00886
G3 X165.893 Y130.2 I-4.116 J.413 E.01476
G1 X165.755 Y130.705 E.00851
G3 X165.08 Y131.618 I-2.098 J-.846 E.01863
G3 X163.88 Y132.103 I-1.673 J-2.41 E.0212
G3 X160.207 Y132.163 I-2.726 J-54.366 E.05965
G1 X158.426 Y132.165 E.02893
; WIPE_START
M204 S3000
G1 X158.198 Y132.073 E-.0932
G1 X158.167 Y131.966 E-.04268
G1 X158.167 Y130.323 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.886 Y133.267 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S3000
G1 X164.554 Y133.33 E.00895
; LINE_WIDTH: 0.62207
G1 X164.222 Y133.394 E.00827
; LINE_WIDTH: 0.5725
G1 X163.66 Y133.441 E.01266
; LINE_WIDTH: 0.55022
G1 X163.054 Y133.464 E.01307
; LINE_WIDTH: 0.54592
G1 X162.383 Y133.474 E.01434
; LINE_WIDTH: 0.54068
G1 X162.209 Y133.476 E.00368
; LINE_WIDTH: 0.53768
G1 X160.209 Y133.477 E.04207
; LINE_WIDTH: 0.53568
G1 X158.367 Y133.477 E.03858
; LINE_WIDTH: 0.53384
G1 X158.366 Y133.477 E.00003
; WIPE_START
G1 X158.367 Y133.477 E-.00057
G1 X160.209 Y133.477 E-.69973
G1 X160.366 Y133.476 E-.05969
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.871 Y125.884 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.50096
G1 F6000
M204 S3000
G1 X160.807 Y125.889 E.00125
; LINE_WIDTH: 0.49122
G1 X160.417 Y125.913 E.00749
; LINE_WIDTH: 0.44249
G1 X160.026 Y125.937 E.00672
; LINE_WIDTH: 0.39376
G1 X159.42 Y125.95 E.00918
; LINE_WIDTH: 0.3662
G1 X158.37 Y125.951 E.01475
; LINE_WIDTH: 0.37282
G1 X158.241 Y125.951 E.00185
; WIPE_START
G1 X158.37 Y125.951 E-.04904
G1 X159.42 Y125.95 E-.39912
G1 X160.026 Y125.937 E-.23009
G1 X160.241 Y125.924 E-.08175
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.693 Y123.867 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.45054
G1 F6000
M204 S3000
G1 X163.399 Y124.233 E.0082
; WIPE_START
G1 X163.693 Y123.867 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.849 Y125.419 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5442
G1 F6000
M204 S3000
G2 X162.851 Y125.527 I-.028 J.055 E.00542
; WIPE_START
G1 X162.783 Y125.532 E-.19609
G1 X162.751 Y125.475 E-.18797
G1 X162.783 Y125.419 E-.18797
G1 X162.849 Y125.419 E-.18796
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.639 Y126.627 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S3000
G1 X156.966 Y126.118 E.00995
G3 X157.163 Y125.951 I.576 J.483 E.00427
G1 X156.968 Y125.788 E.00418
G1 X156.639 Y125.299 E.0097
G1 X156.639 Y126.567 E.02085
M204 S10000
G1 X156.753 Y132.969 F30000
; LINE_WIDTH: 0.57486
G1 F6000
M204 S3000
G2 X156.757 Y133.08 I-.03 J.057 E.00614
; WIPE_START
G1 X156.683 Y133.088 E-.20014
G1 X156.649 Y133.028 E-.18662
G1 X156.683 Y132.969 E-.18663
G1 X156.753 Y132.969 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X153.733 Y125.959 Z2.3 F30000
G1 X146.21 Y108.49 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.3 F30000
G1 X167.79 Y108.49 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.291 Y111.021 Z2.3 F30000
G1 X132.224 Y122.256 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X132.59 Y122.482 E.00753
G1 X133.088 Y122.569 E.00882
; LINE_WIDTH: 0.497195
G1 X133.512 Y122.593 E.00823
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00904
G1 X133.59 Y122.804 E.00838
; LINE_WIDTH: 0.497195
G1 X133.244 Y122.992 E.00763
; LINE_WIDTH: 0.44999
G1 X132.921 Y123.381 E.00882
G1 X132.736 Y123.953 E.01049
; LINE_WIDTH: 0.4722
G1 X132.806 Y124.617 E.01227
G1 X133.5 Y126.493 E.03673
; LINE_WIDTH: 0.44985
G1 X134.195 Y128.368 E.03491
; LINE_WIDTH: 0.4275
G1 X134.889 Y130.244 E.03309
; LINE_WIDTH: 0.40515
G1 X135.29 Y131.325 E.01802
; LINE_WIDTH: 0.4044
G1 X135.406 Y131.582 E.00441
; LINE_WIDTH: 0.44999
G1 X135.717 Y131.973 E.00872
G1 X136.34 Y132.27 E.01204
G2 X137.011 Y132.255 I.304 J-1.438 E.01183
G1 X137.597 Y131.95 E.01154
; LINE_WIDTH: 0.45984
G1 X137.898 Y131.608 E.00813
G1 X138.021 Y131.343 E.00522
; LINE_WIDTH: 0.47269
G1 X138.729 Y129.473 E.03677
; LINE_WIDTH: 0.49801
G1 X139.437 Y127.602 E.03883
; LINE_WIDTH: 0.52333
G1 X140.145 Y125.732 E.0409
; LINE_WIDTH: 0.53814
G1 X140.559 Y124.638 E.02463
; LINE_WIDTH: 0.55128
G1 X140.628 Y124.424 E.00486
G1 X140.62 Y124.278 E.00314
; LINE_WIDTH: 0.517517
G1 X140.612 Y124.133 E.00294
; LINE_WIDTH: 0.483753
G1 X140.604 Y123.988 E.00274
; LINE_WIDTH: 0.44999
G1 X140.442 Y123.429 E.01016
G1 X140.125 Y123.02 E.00904
; LINE_WIDTH: 0.485785
G1 X139.632 Y122.812 E.01011
; LINE_WIDTH: 0.52158
G1 X139.14 Y122.605 E.01089
G1 X139.719 Y122.587 E.01181
; LINE_WIDTH: 0.485785
G1 X140.298 Y122.569 E.01096
; LINE_WIDTH: 0.44999
G1 X140.807 Y122.478 E.00904
G1 X141.31 Y122.165 E.01034
; LINE_WIDTH: 0.486633
G1 X141.447 Y121.992 E.00418
; LINE_WIDTH: 0.523277
G1 X141.584 Y121.819 E.00451
; LINE_WIDTH: 0.55992
G1 X141.721 Y121.646 E.00484
; LINE_WIDTH: 0.5738
G1 X142.445 Y119.782 E.04501
; LINE_WIDTH: 0.58167
G2 X142.925 Y118.546 I-177.652 J-69.604 E.03025
G1 X143.117 Y118.546 E.00439
G1 X143.531 Y118.546 E.00945
G2 X142.64 Y120.79 I322.528 J129.367 E.0551
; LINE_WIDTH: 0.56778
G1 X142.222 Y121.843 E.02522
; LINE_WIDTH: 0.55992
G2 X142.133 Y122.116 I1.951 J.791 E.0063
; LINE_WIDTH: 0.523217
G1 X142.053 Y122.365 E.00536
; LINE_WIDTH: 0.486603
G1 X141.973 Y122.615 E.00497
; LINE_WIDTH: 0.44999
G1 X141.377 Y124.103 E.02799
; LINE_WIDTH: 0.494065
G1 X141.209 Y124.463 E.00765
; LINE_WIDTH: 0.53814
G1 X141.041 Y124.824 E.00837
G1 X140.309 Y126.685 E.0421
; LINE_WIDTH: 0.51281
G1 X139.577 Y128.546 E.04004
; LINE_WIDTH: 0.48749
G1 X138.846 Y130.408 E.03798
; LINE_WIDTH: 0.46217
G1 X138.418 Y131.496 E.021
; LINE_WIDTH: 0.45984
G2 X138.092 Y132.306 I14.436 J6.276 E.01559
; LINE_WIDTH: 0.44999
G1 X137.606 Y133.519 E.02282
G1 X135.778 Y133.519 E.03193
G2 X135.119 Y131.868 I-26.011 J9.418 E.03104
; LINE_WIDTH: 0.42113
G1 X134.943 Y131.455 E.00731
; LINE_WIDTH: 0.41461
G1 X134.227 Y129.588 E.03204
; LINE_WIDTH: 0.43696
G1 X133.512 Y127.72 E.03386
; LINE_WIDTH: 0.45931
G1 X132.796 Y125.853 E.03568
; LINE_WIDTH: 0.4722
G2 X132.085 Y124.039 I-46.648 J17.252 E.03578
; LINE_WIDTH: 0.44999
G1 X131.502 Y122.543 E.02803
; LINE_WIDTH: 0.47587
G1 X131.368 Y122.161 E.0075
; LINE_WIDTH: 0.50175
G1 X131.233 Y121.779 E.00793
; LINE_WIDTH: 0.52463
G1 X130.517 Y119.912 E.041
; LINE_WIDTH: 0.53733
G2 X129.984 Y118.524 I-121.17 J45.803 E.03124
G1 X130.542 Y118.524 E.01173
G2 X131.297 Y120.57 I179.136 J-64.994 E.04584
; LINE_WIDTH: 0.51444
G1 X131.682 Y121.61 E.02228
; LINE_WIDTH: 0.51468
G1 X131.803 Y121.878 E.00591
G1 X131.938 Y122.02 E.00393
; LINE_WIDTH: 0.482335
G1 X132.072 Y122.162 E.00367
; LINE_WIDTH: 0.44999
G1 X132.173 Y122.224 E.00206
M204 S10000
G1 X132.469 Y121.914 F30000
G1 F6000
M204 S3000
G1 X132.735 Y122.079 E.00547
G1 X133.088 Y122.141 E.00625
G1 X140.298 Y122.141 E.12589
G1 X140.659 Y122.076 E.0064
G1 X141.015 Y121.855 E.00732
G1 X141.265 Y121.486 E.00777
G1 X142.585 Y118.052 E.06424
G1 X143.117 Y118.052 E.00929
G1 X144.261 Y118.052 E.01998
G1 X137.896 Y133.948 E.29896
G1 X135.485 Y133.948 E.04211
G1 X129.293 Y118.052 E.29785
G1 X130.873 Y118.052 E.02758
G1 X131.556 Y119.932 E.03492
G2 X132.118 Y121.477 I68.526 J-24.037 E.02871
G1 X132.368 Y121.852 E.00787
G1 X132.418 Y121.883 E.00102
M204 S10000
G1 X132.714 Y121.573 F30000
G1 F6000
M204 S3000
G1 X132.881 Y121.676 E.00342
G1 X133.088 Y121.712 E.00368
G1 X140.298 Y121.712 E.12589
G1 X140.417 Y121.7 E.0021
G1 X140.72 Y121.544 E.00595
G1 X140.867 Y121.327 E.00457
G1 X142.291 Y117.624 E.06928
G1 X143.117 Y117.624 E.01443
G1 X144.894 Y117.624 E.03104
G1 X138.186 Y134.376 E.31508
G1 X135.192 Y134.376 E.05229
G1 X128.666 Y117.624 E.31391
G1 X131.173 Y117.624 E.04376
G1 X132.512 Y121.309 E.06846
G1 X132.663 Y121.541 E.00484
M204 S250
G1 X132.95 Y121.243 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X133.088 Y121.299 E.00241
G1 X140.298 Y121.299 E.11707
G1 X140.367 Y121.286 E.00114
G1 X140.483 Y121.173 E.00263
G1 X142.006 Y117.21 E.06895
G1 X143.117 Y117.21 E.01803
G1 X145.506 Y117.21 E.03878
G1 X138.466 Y134.79 E.30749
G1 X134.909 Y134.79 E.05776
G1 X128.062 Y117.21 E.30635
G1 X131.463 Y117.21 E.05523
G1 X132.829 Y120.97 E.06495
G2 X132.916 Y121.194 I.646 J-.123 E.00393
; WIPE_START
M204 S3000
G1 X133.088 Y121.299 E-.07642
G1 X134.887 Y121.299 E-.68358
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.816 Y128.874 Z2.3 F30000
G1 X136.166 Y131.725 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X135.988 Y131.64 E.00345
G1 X135.753 Y131.372 E.00622
G1 X135.665 Y131.188 E.00356
G1 X133.219 Y124.467 E.12488
G1 X133.162 Y123.999 E.00823
G1 X133.293 Y123.594 E.00743
G1 X133.522 Y123.318 E.00625
G1 X134.018 Y123.085 E.00957
G1 X134.197 Y123.069 E.00315
G1 X139.14 Y123.069 E.08629
G1 X139.837 Y123.338 E.01306
G1 X140.062 Y123.628 E.0064
G1 X140.177 Y124.023 E.0072
G1 X140.116 Y124.473 E.00793
G1 X137.62 Y131.194 E.12518
G1 X137.529 Y131.38 E.00361
G1 X137.319 Y131.624 E.00562
G1 X136.824 Y131.858 E.00956
G1 X136.429 Y131.851 E.0069
G1 X136.22 Y131.751 E.00403
M204 S10000
G1 X136.194 Y131.218 F30000
G1 F6000
M204 S3000
G1 X136.068 Y131.042 E.00378
G1 X133.622 Y124.32 E.12488
G1 X133.588 Y124.045 E.00485
G1 X133.719 Y123.728 E.00598
G1 X133.8 Y123.644 E.00203
G1 X134.092 Y123.507 E.00563
G1 X134.197 Y123.498 E.00186
G1 X139.14 Y123.498 E.08629
G1 X139.55 Y123.656 E.00768
G1 X139.682 Y123.826 E.00377
G1 X139.75 Y124.059 E.00424
G1 X139.714 Y124.324 E.00466
G1 X137.218 Y131.045 E.12518
G1 X137.041 Y131.298 E.00539
G1 X136.75 Y131.436 E.00563
G1 X136.517 Y131.431 E.00406
G1 X136.258 Y131.308 E.00502
G1 X136.228 Y131.267 E.00088
M204 S250
G1 X136.518 Y130.987 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X136.457 Y130.9 E.00173
G1 X134.01 Y124.179 E.11614
G1 X134.024 Y124.012 E.00272
G1 X134.163 Y123.914 E.00275
G1 X134.197 Y123.911 E.00056
G1 X139.14 Y123.911 E.08025
G1 X139.299 Y123.992 E.0029
G1 X139.335 Y124.152 E.00266
G1 X139.326 Y124.18 E.00048
G1 X136.829 Y130.906 E.1165
G1 X136.694 Y131.025 E.00292
G1 X136.577 Y130.999 E.00194
; WIPE_START
M204 S3000
G1 X136.457 Y130.9 E-.05928
G1 X135.826 Y129.167 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.14 Y122.605 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S3000
G1 X134.197 Y122.605 E.1007
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00559
; WIPE_START
G1 X134.197 Y122.605 E-.0997
G1 X135.935 Y122.605 E-.6603
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.393 Y123.666 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S3000
G1 X132.558 Y123.173 E.0087
G1 X132.709 Y122.949 E.00451
G1 X132.404 Y122.855 E.00533
G1 X131.958 Y122.558 E.00895
G1 X132.371 Y123.61 E.0189
; WIPE_START
G1 X131.958 Y122.558 E-.42968
G1 X132.404 Y122.855 E-.20356
G1 X132.709 Y122.949 E-.1212
G1 X132.701 Y122.961 E-.00556
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.333 Y122.978 Z2.3 F30000
G1 X140.691 Y122.979 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S3000
G1 X140.854 Y123.265 E.00622
G1 X141.013 Y123.811 E.01075
G1 X141.515 Y122.558 E.0255
G1 X141.004 Y122.876 E.01136
G1 X140.748 Y122.96 E.0051
; WIPE_START
G1 X141.004 Y122.876 E-.10257
G1 X141.515 Y122.558 E-.22853
G1 X141.095 Y123.606 E-.42891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.203 Y130.172 Z2.3 F30000
G1 X135.83 Y132.489 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S3000
G1 X136.067 Y133.097 E.01107
G2 X137.316 Y133.091 I.52 J-24.617 E.0212
G1 X137.572 Y132.44 E.01188
G1 X137.117 Y132.67 E.00865
G1 X136.623 Y132.713 E.00842
G1 X136.206 Y132.668 E.00713
G1 X135.884 Y132.515 E.00605
; WIPE_START
G1 X136.206 Y132.668 E-.13544
G1 X136.623 Y132.713 E-.15954
G1 X137.117 Y132.67 E-.18848
G1 X137.572 Y132.44 E-.19363
G1 X137.492 Y132.643 E-.08291
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.451 Y127.979 Z2.3 F30000
G1 X106.21 Y108.49 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y108.196 Z2.3 F30000
G1 X90.21 Y108.49 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.144 Y115.586 Z2.3 F30000
G1 X96.146 Y133.568 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.35597
G1 F6000
M204 S3000
G1 X95.782 Y133.672 E.00516
; LINE_WIDTH: 0.33261
G1 X95.116 Y133.798 E.00859
; LINE_WIDTH: 0.31593
G1 X94.438 Y133.87 E.00818
; LINE_WIDTH: 0.30859
G1 X93.747 Y133.896 E.0081
; LINE_WIDTH: 0.31477
G1 X93.046 Y133.868 E.00838
; LINE_WIDTH: 0.33132
G1 X92.347 Y133.788 E.00888
; LINE_WIDTH: 0.3643
G1 X91.56 Y133.626 E.01123
; LINE_WIDTH: 0.38649
G1 X91.015 Y133.454 E.0085
; LINE_WIDTH: 0.40816
G1 X90.539 Y133.257 E.00812
; LINE_WIDTH: 0.44963
G1 X89.963 Y132.977 E.01116
; LINE_WIDTH: 0.47195
G1 X89.53 Y132.693 E.00951
; LINE_WIDTH: 0.48939
G1 X89.084 Y132.335 E.0109
; LINE_WIDTH: 0.50523
G1 X88.639 Y131.903 E.01222
; LINE_WIDTH: 0.52781
G1 X88.156 Y131.324 E.01556
; LINE_WIDTH: 0.54902
G1 X87.836 Y130.862 E.01207
; LINE_WIDTH: 0.57223
G1 X87.576 Y130.415 E.01163
; LINE_WIDTH: 0.59242
G1 X87.31 Y129.858 E.01435
; LINE_WIDTH: 0.60335
G1 X87.094 Y129.264 E.01498
; LINE_WIDTH: 0.61368
G1 X86.92 Y128.633 E.0158
; LINE_WIDTH: 0.62061
G1 X86.822 Y128.136 E.01237
; LINE_WIDTH: 0.62174
G1 X86.744 Y127.622 E.01272
; LINE_WIDTH: 0.625
G1 X86.689 Y127.075 E.0135
; LINE_WIDTH: 0.62812
G1 X86.657 Y126.495 E.01435
; LINE_WIDTH: 0.62886
G1 X86.645 Y125.883 E.01517
; LINE_WIDTH: 0.632
G3 X86.765 Y124.217 I10.837 J-.059 E.04159
; LINE_WIDTH: 0.62599
G1 X86.918 Y123.392 E.02066
; LINE_WIDTH: 0.62227
G1 X87.088 Y122.763 E.01595
; LINE_WIDTH: 0.61731
G1 X87.279 Y122.219 E.014
; LINE_WIDTH: 0.61482
G1 X87.575 Y121.58 E.01703
; LINE_WIDTH: 0.60042
G1 X87.924 Y120.992 E.01612
; LINE_WIDTH: 0.58069
G1 X88.329 Y120.45 E.01542
; LINE_WIDTH: 0.55592
G1 X88.809 Y119.939 E.01527
; LINE_WIDTH: 0.5269
G1 X89.361 Y119.47 E.01492
; LINE_WIDTH: 0.49317
G1 X89.952 Y119.074 E.01368
; LINE_WIDTH: 0.45518
G1 X90.574 Y118.752 E.01237
; LINE_WIDTH: 0.41598
G1 X91.217 Y118.501 E.01109
; LINE_WIDTH: 0.37925
G1 X91.873 Y118.316 E.00994
; LINE_WIDTH: 0.34865
G1 X92.564 Y118.188 E.00938
; LINE_WIDTH: 0.32627
G1 X93.384 Y118.116 E.01022
; LINE_WIDTH: 0.31221
G1 X93.89 Y118.119 E.006
; LINE_WIDTH: 0.31836
G1 X94.701 Y118.146 E.00981
; LINE_WIDTH: 0.34039
G1 X95.476 Y118.255 E.01016
; LINE_WIDTH: 0.37063
G1 X96.205 Y118.433 E.01068
; LINE_WIDTH: 0.40537
G1 X96.876 Y118.674 E.01115
; LINE_WIDTH: 0.44117
G1 X97.492 Y118.973 E.01172
; LINE_WIDTH: 0.47538
G1 X98.061 Y119.33 E.01241
; LINE_WIDTH: 0.50634
G1 X98.587 Y119.745 E.01325
; LINE_WIDTH: 0.53435
G1 X99.074 Y120.222 E.01424
; LINE_WIDTH: 0.55948
G1 X99.51 Y120.749 E.01499
; LINE_WIDTH: 0.58147
G1 X99.896 Y121.341 E.01613
; LINE_WIDTH: 0.60064
G1 X100.244 Y122.043 E.01849
; LINE_WIDTH: 0.61475
G1 X100.518 Y122.788 E.01919
; LINE_WIDTH: 0.62417
G1 X100.721 Y123.571 E.01986
; LINE_WIDTH: 0.62955
G1 X100.859 Y124.388 E.02054
; LINE_WIDTH: 0.63713
G1 X100.952 Y125.498 E.02795
G1 X100.953 Y126.468 E.02432
; LINE_WIDTH: 0.63462
G1 X100.924 Y127.007 E.01349
; LINE_WIDTH: 0.62855
G1 X100.827 Y127.867 E.02142
; LINE_WIDTH: 0.61965
G1 X100.666 Y128.687 E.02035
; LINE_WIDTH: 0.60725
G1 X100.436 Y129.468 E.01943
; LINE_WIDTH: 0.58952
G1 X100.131 Y130.204 E.01845
; LINE_WIDTH: 0.56612
G1 X99.752 Y130.889 E.01736
; LINE_WIDTH: 0.53772
G1 X99.3 Y131.512 E.01619
; LINE_WIDTH: 0.50607
G1 X98.799 Y132.054 E.01457
; LINE_WIDTH: 0.47527
G1 X98.26 Y132.517 E.01313
; LINE_WIDTH: 0.44536
G1 X97.682 Y132.911 E.01209
; LINE_WIDTH: 0.41449
G1 X97.07 Y133.233 E.01107
; LINE_WIDTH: 0.38402
G1 X96.435 Y133.486 E.0101
; LINE_WIDTH: 0.35597
G1 X96.204 Y133.551 E.00327
; WIPE_START
G1 X95.782 Y133.672 E-.16662
G1 X95.116 Y133.798 E-.25758
G1 X94.438 Y133.87 E-.25898
G1 X94.236 Y133.878 E-.07682
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.858 Y126.71 Z2.3 F30000
G1 X98.972 Y120.93 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S3000
G1 X99.311 Y121.444 E.0138
; LINE_WIDTH: 0.59672
G1 X99.642 Y122.103 E.01729
; LINE_WIDTH: 0.61527
G1 X99.903 Y122.801 E.01803
; LINE_WIDTH: 0.62651
G1 X100.088 Y123.491 E.01762
; LINE_WIDTH: 0.63308
G1 X100.227 Y124.249 E.0192
; LINE_WIDTH: 0.63563
G3 X100.349 Y125.984 I-12.366 J1.74 E.04355
; LINE_WIDTH: 0.63443
G1 X100.326 Y126.855 E.02176
; LINE_WIDTH: 0.62953
G1 X100.253 Y127.652 E.01984
; LINE_WIDTH: 0.62185
G1 X100.126 Y128.412 E.01884
; LINE_WIDTH: 0.60881
G1 X99.946 Y129.135 E.01782
; LINE_WIDTH: 0.59354
G1 X99.706 Y129.819 E.0169
; LINE_WIDTH: 0.57401
G1 X99.414 Y130.439 E.01543
; LINE_WIDTH: 0.55095
G1 X99.087 Y130.978 E.0136
; LINE_WIDTH: 0.52553
G1 X98.704 Y131.48 E.01297
; LINE_WIDTH: 0.49762
G1 X98.266 Y131.942 E.01234
; LINE_WIDTH: 0.46894
G1 X97.788 Y132.351 E.01147
; LINE_WIDTH: 0.43985
G1 X97.266 Y132.708 E.01077
; LINE_WIDTH: 0.40979
G1 X96.693 Y133.012 E.01026
; LINE_WIDTH: 0.37995
G1 X96.062 Y133.262 E.00992
; LINE_WIDTH: 0.35227
G1 X95.365 Y133.451 E.00973
; LINE_WIDTH: 0.3292
G1 X94.602 Y133.57 E.00967
; LINE_WIDTH: 0.31322
G1 X93.878 Y133.608 E.00862
; LINE_WIDTH: 0.3138
G1 X93.31 Y133.592 E.00676
; LINE_WIDTH: 0.32712
G1 X92.553 Y133.51 E.00949
; LINE_WIDTH: 0.346
G1 X91.916 Y133.372 E.00862
; LINE_WIDTH: 0.37604
G1 X91.297 Y133.173 E.00939
; LINE_WIDTH: 0.40816
G1 X90.703 Y132.907 E.01026
; LINE_WIDTH: 0.44963
G1 X90.192 Y132.615 E.01026
; LINE_WIDTH: 0.47508
G1 X89.61 Y132.179 E.01346
; LINE_WIDTH: 0.49664
G1 X89.126 Y131.717 E.01295
; LINE_WIDTH: 0.52136
G1 X88.681 Y131.187 E.0141
; LINE_WIDTH: 0.54877
G1 X88.334 Y130.665 E.01346
; LINE_WIDTH: 0.57223
G1 X88.072 Y130.175 E.01247
; LINE_WIDTH: 0.59242
G1 X87.844 Y129.658 E.01314
; LINE_WIDTH: 0.60335
G1 X87.652 Y129.103 E.01392
; LINE_WIDTH: 0.61358
G1 X87.497 Y128.498 E.01507
; LINE_WIDTH: 0.61872
G1 X87.362 Y127.721 E.0192
; LINE_WIDTH: 0.625
G1 X87.291 Y127.03 E.01709
; LINE_WIDTH: 0.62812
G3 X87.251 Y125.966 I18.613 J-1.226 E.02632
; LINE_WIDTH: 0.6317
G1 X87.265 Y125.435 E.0132
; LINE_WIDTH: 0.63259
G3 X87.447 Y123.803 I10.971 J.394 E.04092
; LINE_WIDTH: 0.62991
G1 X87.614 Y123.093 E.0181
; LINE_WIDTH: 0.62438
G1 X87.699 Y122.807 E.0073
; LINE_WIDTH: 0.61383
G1 X87.905 Y122.244 E.01447
; LINE_WIDTH: 0.60427
G1 X88.216 Y121.593 E.01715
; LINE_WIDTH: 0.58513
G1 X88.595 Y120.987 E.01641
; LINE_WIDTH: 0.56044
G1 X89.04 Y120.432 E.01562
; LINE_WIDTH: 0.53221
G1 X89.525 Y119.949 E.01424
; LINE_WIDTH: 0.50138
G1 X90.039 Y119.538 E.01287
; LINE_WIDTH: 0.46646
G1 X90.591 Y119.187 E.01186
; LINE_WIDTH: 0.42844
G1 X91.177 Y118.9 E.01082
; LINE_WIDTH: 0.3904
G1 X91.791 Y118.679 E.00982
; LINE_WIDTH: 0.35589
G1 X92.428 Y118.522 E.00893
; LINE_WIDTH: 0.32832
G1 X93.083 Y118.428 E.00827
; LINE_WIDTH: 0.31053
G1 X93.753 Y118.395 E.0079
; LINE_WIDTH: 0.30572
G1 X94.414 Y118.417 E.00766
; LINE_WIDTH: 0.32208
G1 X95.059 Y118.495 E.00796
; LINE_WIDTH: 0.34481
G1 X95.689 Y118.636 E.00851
; LINE_WIDTH: 0.37507
G1 X96.302 Y118.839 E.0093
; LINE_WIDTH: 0.40998
G1 X96.891 Y119.109 E.01026
; LINE_WIDTH: 0.44638
G1 X97.451 Y119.445 E.01131
; LINE_WIDTH: 0.48135
G1 X97.977 Y119.845 E.01238
; LINE_WIDTH: 0.51276
G1 X98.463 Y120.306 E.01341
; LINE_WIDTH: 0.54273
G1 X98.912 Y120.838 E.01479
; LINE_WIDTH: 0.57196
G1 X98.94 Y120.88 E.00113
M204 S10000
G1 X98.586 Y121.208 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X98.886 Y121.702 E.01009
G3 X99.42 Y122.969 I-5.392 J3.019 E.02406
G3 X99.808 Y126.84 I-11.617 J3.118 E.06823
G3 X99.242 Y129.659 I-9.593 J-.461 E.05038
G3 X95.933 Y132.905 I-5.2 J-1.992 E.08346
G3 X92.603 Y133.146 I-2.156 J-6.65 E.05887
G3 X88.742 Y130.416 I.966 J-5.461 E.08529
G3 X87.805 Y126.983 I7.256 J-3.825 E.06265
G3 X88.18 Y122.977 I11.437 J-.949 E.07061
G3 X88.664 Y121.806 I6.494 J2.001 E.02215
G3 X93.769 Y118.749 I5.078 J2.688 E.1092
G3 X97.694 Y120.187 I.123 J5.738 E.07471
G3 X98.529 Y121.138 I-4.2 J4.533 E.02213
G1 X98.549 Y121.162 E.00053
M204 S10000
G1 X98.226 Y121.435 F30000
G1 F6000
M204 S3000
G1 X98.529 Y121.92 E.00999
G3 X98.799 Y122.496 I-4.622 J2.519 E.01111
G3 X99.371 Y125.185 I-8.571 J3.23 E.04818
G3 X99.044 Y128.912 I-11.512 J.867 E.06562
G3 X96.815 Y132.003 I-5.184 J-1.39 E.06801
G3 X93.844 Y132.824 I-2.955 J-4.908 E.05449
G3 X90.599 Y131.858 I-.119 J-5.534 E.06006
G3 X88.792 Y129.547 I3.199 J-4.365 E.05188
G3 X88.232 Y126.943 I8.093 J-3.103 E.04667
G3 X88.584 Y123.119 I11.265 J-.89 E.06739
G1 X88.784 Y122.558 E.01039
G3 X93.789 Y119.177 I4.963 J1.95 E.11211
G3 X98.194 Y121.385 I.118 J5.262 E.08953
M204 S250
G1 X97.871 Y121.656 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X98.625 Y123.246 I-4.123 J2.931 E.02873
G3 X98.966 Y126.817 I-10.895 J2.842 E.05849
G3 X98.446 Y129.384 I-8.698 J-.426 E.0427
G3 X95.933 Y132.009 I-4.436 J-1.732 E.06053
G3 X93.259 Y132.386 I-2.133 J-5.453 E.04425
G3 X89.414 Y129.9 I.348 J-4.755 E.07756
G3 X88.643 Y126.906 I6.771 J-3.338 E.05056
G3 X88.975 Y123.256 I10.864 J-.854 E.05979
G3 X91.74 Y120.006 I4.95 J1.411 E.07143
G3 X95.87 Y119.994 I2.08 J4.945 E.06884
G3 X97.835 Y121.607 I-2.122 J4.592 E.04173
; WIPE_START
M204 S3000
G1 X98.173 Y122.137 E-.23879
G1 X98.424 Y122.671 E-.22423
G1 X98.625 Y123.246 E-.23154
G1 X98.667 Y123.413 E-.06545
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.966 Y130.853 Z2.3 F30000
G1 X96.263 Y133.926 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X95.862 Y134.033 E.00725
G3 X91.479 Y134.004 I-2.125 J-10.184 E.07711
G1 X90.693 Y133.772 E.01431
G3 X89.737 Y133.34 I17.613 J-40.261 E.01831
G3 X87.429 Y131.113 I3.703 J-6.146 E.05647
G3 X86.416 Y128.72 I6.057 J-3.975 E.04563
G3 X86.339 Y123.59 I13.043 J-2.762 E.09013
G3 X87.507 Y120.724 I7.729 J1.478 E.0544
G3 X91.707 Y117.961 I5.59 J3.923 E.08988
G3 X93.366 Y117.756 I1.993 J9.29 E.02923
G1 X94.72 Y117.782 E.02365
G3 X97.678 Y118.59 I-.594 J7.997 E.05387
G3 X100.948 Y122.437 I-3.239 J6.065 E.09026
G3 X101.474 Y125.489 I-10.643 J3.408 E.05426
G3 X101.153 Y128.83 I-12.164 J.515 E.05878
G3 X100.56 Y130.434 I-7.662 J-1.919 E.02991
G1 X100.141 Y131.156 E.01458
G1 X99.645 Y131.811 E.01434
G3 X96.554 Y133.848 I-5.223 J-4.561 E.06544
G1 X96.321 Y133.91 E.00421
M204 S10000
G1 X96.373 Y134.339 F30000
G1 F6000
M204 S3000
G1 X95.955 Y134.451 E.00756
G3 X91.38 Y134.421 I-2.219 J-10.619 E.08049
G1 X90.545 Y134.175 E.0152
G1 X89.574 Y133.743 E.01856
G3 X85.997 Y128.806 I3.887 J-6.58 E.1095
G3 X85.918 Y123.506 I13.475 J-2.849 E.09312
G3 X87.154 Y120.48 I8.148 J1.561 E.05744
G3 X90.825 Y117.756 I5.842 J4.035 E.08127
G3 X93.353 Y117.327 I3.006 J10.055 E.04488
G1 X94.751 Y117.354 E.02442
G3 X97.876 Y118.209 I-.628 J8.434 E.05691
G3 X101.353 Y122.296 I-3.443 J6.451 E.09593
G3 X101.903 Y125.482 I-10.871 J3.517 E.05664
G3 X101.593 Y128.853 I-13.331 J.474 E.05927
G3 X100.212 Y131.811 I-7.816 J-1.848 E.05739
G3 X96.689 Y134.259 I-5.734 J-4.494 E.07603
G1 X96.431 Y134.324 E.00464
M204 S250
G1 X96.485 Y134.757 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X91.283 Y134.824 I-2.743 J-11.011 E.08522
G1 X90.402 Y134.564 E.01493
G1 X89.379 Y134.11 E.01816
G3 X85.488 Y128.382 I4.112 J-6.98 E.11618
G3 X85.513 Y123.425 I14.135 J-2.407 E.0809
G3 X86.813 Y120.246 I8.552 J1.641 E.05614
G3 X90.696 Y117.362 I6.182 J4.269 E.07997
G3 X93.34 Y116.913 I3.145 J10.506 E.04366
M73 P95 R2
G1 X94.781 Y116.941 E.0234
G3 X98.066 Y117.841 I-.66 J8.855 E.05566
G3 X101.744 Y122.16 I-3.639 J6.824 E.0943
G3 X102.316 Y125.475 I-11.241 J3.648 E.05481
G3 X101.995 Y128.951 I-13.534 J.502 E.05685
G3 X101.012 Y131.376 I-9.292 J-2.357 E.04261
G3 X96.543 Y134.741 I-6.56 J-4.061 E.09296
; WIPE_START
M204 S3000
G1 X95.634 Y134.946 E-.35405
G1 X94.733 Y135.059 E-.34495
G1 X94.573 Y135.065 E-.061
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.448 Y129.409 Z2.3 F30000
G1 X77.49 Y116.21 Z2.3
G1 Z1.9
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.314 Y126.926 Z2.3 F30000
G1 X77.49 Y131.21 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.261 Y138.665 Z2.3 F30000
G1 X90.21 Y143.51 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y143.711 Z2.3 F30000
G1 X106.21 Y143.51 Z2.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.494 Y136.69 Z2.3 F30000
G1 X116.009 Y121.65 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X115.495 Y121.813 E.0094
G1 X114.985 Y122.317 E.01253
; LINE_WIDTH: 0.44625
G1 X113.938 Y124.022 E.03462
; LINE_WIDTH: 0.45012
G1 X112.891 Y125.726 E.03493
; LINE_WIDTH: 0.45399
G1 X111.845 Y127.43 E.03525
; LINE_WIDTH: 0.45786
G1 X110.798 Y129.134 E.03556
; LINE_WIDTH: 0.45901
G1 X110.487 Y129.64 E.01058
; LINE_WIDTH: 0.47181
G2 X110.045 Y130.37 I8.569 J5.689 E.01567
; LINE_WIDTH: 0.44999
G1 X108.115 Y133.519 E.06449
G1 X106.888 Y133.519 E.02141
G1 X106.888 Y129.519 E.06984
G2 X106.885 Y128.611 I-116.699 J-.032 E.01587
; LINE_WIDTH: 0.44341
G1 X106.885 Y118.477 E.17421
G1 X107.307 Y118.477 E.00725
G1 X107.307 Y128.611 E.17421
; LINE_WIDTH: 0.45612
G1 X107.323 Y128.865 E.00452
G1 X107.479 Y129.307 E.0083
; LINE_WIDTH: 0.44999
G1 X107.899 Y129.792 E.0112
G1 X108.459 Y130.049 E.01076
G1 X108.984 Y130.1 E.0092
G1 X109.595 Y129.909 E.01119
; LINE_WIDTH: 0.47181
G1 X109.97 Y129.616 E.00873
G1 X110.115 Y129.411 E.0046
; LINE_WIDTH: 0.45901
G1 X111.165 Y127.708 E.03565
; LINE_WIDTH: 0.45514
G1 X112.215 Y126.006 E.03534
; LINE_WIDTH: 0.45127
G1 X113.265 Y124.304 E.03502
; LINE_WIDTH: 0.4474
G1 X114.315 Y122.602 E.03471
; LINE_WIDTH: 0.44353
G1 X114.626 Y122.097 E.01021
; LINE_WIDTH: 0.44239
G1 X114.63 Y122.091 E.00011
; LINE_WIDTH: 0.44999
G2 X116.866 Y118.481 I-868.396 J-540.416 E.07416
G1 X118.207 Y118.481 E.02341
G1 X118.207 Y119.341 E.01503
G1 X118.207 Y121.341 E.03492
G2 X118.21 Y123.108 I227.257 J.46 E.03085
; LINE_WIDTH: 0.44341
G1 X118.21 Y133.523 E.17905
G1 X117.788 Y133.523 E.00725
G1 X117.788 Y123.108 E.17905
; LINE_WIDTH: 0.44999
G1 X117.616 Y122.411 E.01254
G1 X117.195 Y121.926 E.01121
G1 X116.634 Y121.669 E.01078
G1 X116.108 Y121.619 E.00923
G1 X116.066 Y121.632 E.00076
M204 S10000
G1 X116.079 Y122.067 F30000
G1 F6000
M204 S3000
G1 X115.711 Y122.183 E.00674
G1 X115.349 Y122.536 E.00882
G1 X108.355 Y133.948 E.2337
G1 X106.46 Y133.948 E.03309
G1 X106.46 Y118.052 E.27754
G1 X107.732 Y118.052 E.02222
G1 X107.732 Y128.052 E.1746
G2 X107.748 Y128.791 I4.251 J.279 E.01292
G1 X107.857 Y129.104 E.00579
G1 X108.154 Y129.448 E.00793
G1 X108.489 Y129.612 E.00653
G1 X108.948 Y129.673 E.00807
G1 X109.381 Y129.537 E.00793
G1 X109.641 Y129.325 E.00586
G1 X109.746 Y129.183 E.00308
G1 X116.627 Y118.052 E.22848
G1 X118.636 Y118.052 E.03506
G1 X118.636 Y119.341 E.02251
G1 X118.636 Y133.948 E.25503
G1 X117.363 Y133.948 E.02222
G1 X117.363 Y123.108 E.18926
G1 X117.238 Y122.614 E.0089
G1 X116.94 Y122.27 E.00794
G1 X116.605 Y122.106 E.00653
G1 X116.145 Y122.046 E.0081
G1 X116.136 Y122.049 E.00015
M204 S10000
G1 X116.149 Y122.483 F30000
G1 F6000
M204 S3000
G1 X115.927 Y122.554 E.00408
G1 X115.714 Y122.761 E.00519
G1 X108.595 Y134.376 E.23786
G1 X106.031 Y134.376 E.04476
G1 X106.031 Y117.624 E.2925
G1 X108.161 Y117.624 E.03718
G1 X108.161 Y128.611 E.19184
G1 X108.234 Y128.901 E.00523
G1 X108.409 Y129.103 E.00467
G1 X108.606 Y129.2 E.00384
G1 X108.912 Y129.246 E.00539
G1 X109.167 Y129.166 E.00467
G1 X109.382 Y128.958 E.00523
G1 X116.389 Y117.624 E.23265
G1 X119.064 Y117.624 E.04671
G1 X119.064 Y119.341 E.02999
G1 X119.064 Y134.376 E.26251
G1 X116.935 Y134.376 E.03718
G1 X116.935 Y123.108 E.19675
G1 X116.861 Y122.817 E.00523
G1 X116.686 Y122.615 E.00467
G1 X116.488 Y122.518 E.00384
G1 X116.208 Y122.477 E.00495
M204 S250
G1 X116.218 Y122.885 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X116.065 Y122.979 E.0029
G1 X108.826 Y134.79 E.22494
G1 X105.618 Y134.79 E.0521
G1 X105.618 Y117.21 E.28546
G1 X108.574 Y117.21 E.04801
G1 X108.574 Y128.611 E.18512
G1 X108.655 Y128.771 E.00291
G1 X108.877 Y128.834 E.00375
G1 X109.03 Y128.74 E.00291
G1 X116.158 Y117.21 E.22011
G1 X119.478 Y117.21 E.0539
G1 X119.478 Y119.341 E.03461
G1 X119.478 Y134.79 E.25085
G1 X116.521 Y134.79 E.04801
G1 X116.521 Y123.108 E.18969
G1 X116.44 Y122.948 E.00291
G1 X116.275 Y122.901 E.00278
; WIPE_START
M204 S3000
G1 X116.065 Y122.979 E-.08506
G1 X115.137 Y124.493 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.793 Y121.992 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S3000
G1 X117.793 Y118.894 E.05031
G1 X117.097 Y118.894 E.01132
G1 X115.564 Y121.363 E.04719
G1 X116.113 Y121.208 E.00926
G1 X116.803 Y121.289 E.01128
G1 X117.41 Y121.574 E.0109
G1 X117.753 Y121.948 E.00824
M204 S10000
G1 X117.395 Y121.123 F30000
G1 F6000
M204 S3000
G1 X117.395 Y119.293 E.02972
G1 X117.304 Y119.316 E.00153
G1 X116.36 Y120.836 E.02905
G1 X116.918 Y120.906 E.00912
G1 X117.34 Y121.098 E.00754
M204 S10000
G1 X117.031 Y120.488 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S3000
G1 X116.96 Y120.529 E.00125
G1 X117.02 Y120.563 E.00105
; WIPE_START
G1 X116.96 Y120.529 E-.34737
G1 X117.031 Y120.488 E-.41263
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.427 Y126.575 Z2.3 F30000
G1 X109.577 Y130.342 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X109.061 Y130.504 E.00878
G1 X108.29 Y130.429 E.01258
G1 X107.683 Y130.143 E.01089
G1 X107.307 Y129.732 E.00905
G1 X107.302 Y133.106 E.05478
G1 X107.883 Y133.106 E.00943
G1 X109.546 Y130.393 E.05166
M204 S10000
G1 X108.775 Y130.888 F30000
G1 F6000
M204 S3000
G1 X108.242 Y130.824 E.00871
G1 X107.704 Y130.597 E.00948
G1 X107.701 Y132.64 E.03317
G1 X108.744 Y130.94 E.03238
M204 S10000
G1 X108.131 Y131.165 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S3000
G2 X108.122 Y131.253 I-.025 J.042 E.00327
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X108.081 Y131.253 E-.16312
G1 X108.055 Y131.209 E-.19896
G1 X108.081 Y131.165 E-.19898
G1 X108.131 Y131.165 E-.19893
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/24
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.3 I.253 J1.19 P1  F30000
G1 X178.51 Y116.21 Z2.3
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.4 F30000
G1 X178.51 Y131.21 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.4 F30000
G1 X162.21 Y143.51 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.4 F30000
G1 X146.21 Y143.51 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.731 Y136.503 Z2.4 F30000
G1 X151.057 Y134.79 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
; WIPE_START
M204 S3000
G1 X149.058 Y134.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.536 Y127.15 Z2.4 F30000
G1 X150.146 Y117.429 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X150.838 Y118.122 E.0159
G1 X150.838 Y118.685
G1 X149.582 Y117.429 E.02885
G1 X149.018 Y117.429
G1 X150.838 Y119.249 E.04179
G1 X150.838 Y119.813
G1 X148.455 Y117.429 E.05473
G1 X148.062 Y117.6
G1 X150.838 Y120.376 E.06375
G1 X150.838 Y120.94
G1 X148.062 Y118.164 E.06375
G1 X148.062 Y118.727
G1 X150.838 Y121.503 E.06375
G1 X150.838 Y122.067
G1 X148.062 Y119.291 E.06375
G1 X148.062 Y119.855
G1 X150.838 Y122.631 E.06375
G1 X150.838 Y123.194
G1 X148.062 Y120.418 E.06375
G1 X148.062 Y120.982
G1 X150.838 Y123.758 E.06375
G1 X150.838 Y124.321
G1 X148.062 Y121.545 E.06375
G1 X148.062 Y122.109
G1 X150.838 Y124.885 E.06375
G1 X150.838 Y125.449
G1 X148.062 Y122.673 E.06375
G1 X148.062 Y123.236
G1 X150.838 Y126.012 E.06375
G1 X150.838 Y126.576
G1 X148.062 Y123.8 E.06375
G1 X148.062 Y124.363
G1 X150.838 Y127.139 E.06375
G1 X150.838 Y127.703
G1 X148.062 Y124.927 E.06375
G1 X148.062 Y125.491
G1 X150.838 Y128.267 E.06375
G1 X150.838 Y128.83
G1 X148.062 Y126.054 E.06375
G1 X148.062 Y126.618
G1 X150.838 Y129.394 E.06375
G1 X150.838 Y129.957
G1 X148.062 Y127.181 E.06375
G1 X148.062 Y127.745
G1 X150.838 Y130.521 E.06375
G1 X150.838 Y131.085
G1 X148.062 Y128.309 E.06375
G1 X148.062 Y128.872
G1 X150.838 Y131.648 E.06375
G1 X150.838 Y132.212
G1 X148.062 Y129.436 E.06375
G1 X148.062 Y129.999
G1 X150.838 Y132.776 E.06375
G1 X150.838 Y133.339
G1 X148.062 Y130.563 E.06375
G1 X148.062 Y131.127
G1 X150.838 Y133.903 E.06375
G1 X150.838 Y134.466
G1 X148.062 Y131.69 E.06375
G1 X148.062 Y132.254
G1 X150.379 Y134.571 E.05321
G1 X149.816 Y134.571
G1 X148.062 Y132.818 E.04026
G1 X148.062 Y133.381
G1 X149.252 Y134.571 E.02732
G1 X148.688 Y134.571
G1 X148.062 Y133.945 E.01438
; WIPE_START
M204 S3000
G1 X148.688 Y134.571 E-.33647
G1 X149.252 Y134.571 E-.21417
G1 X148.862 Y134.181 E-.20936
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.466 Y130.354 Z2.4 F30000
G1 X164.544 Y125.093 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X164.648 Y125.146 E.00189
G3 X166.694 Y125.72 I-1.09 J7.812 E.0346
G1 X167.479 Y126.179 E.01478
G1 X168.117 Y126.75 E.01389
G1 X168.613 Y127.42 E.01354
G1 X168.967 Y128.175 E.01355
G1 X169.147 Y128.882 E.01184
G3 X169.246 Y130.072 I-8.741 J1.329 E.01941
G1 X169.206 Y130.702 E.01025
G1 X169.065 Y131.404 E.01164
G1 X168.829 Y132.062 E.01135
G1 X168.5 Y132.677 E.01132
G1 X168.094 Y133.224 E.01106
G1 X167.628 Y133.678 E.01057
G1 X167.101 Y134.043 E.0104
G1 X166.511 Y134.318 E.01057
G1 X165.787 Y134.522 E.01222
G3 X162.397 Y134.79 I-3.123 J-17.921 E.0553
G1 X154.952 Y134.79 E.12089
G1 X154.952 Y117.21 E.28546
G1 X158.167 Y117.21 E.05219
G1 X158.167 Y124.525 E.11878
G1 X158.22 Y124.661 E.00238
G1 X158.366 Y124.724 E.00258
G2 X160.64 Y124.608 I.487 J-12.825 E.03702
G1 X161.078 Y124.479 E.00741
G1 X161.674 Y124.154 E.01102
G1 X162.198 Y123.696 E.0113
G2 X163.788 Y121.537 I-19.101 J-15.729 E.04356
G1 X166.69 Y117.21 E.0846
G1 X170.546 Y117.21 E.0626
G1 X168.423 Y120.6 E.06495
G3 X166.642 Y123.13 I-18.992 J-11.481 E.05028
G1 X166.043 Y123.735 E.01382
G3 X164.557 Y124.795 I-6.947 J-8.167 E.02968
G1 X164.485 Y124.929 E.00246
G1 X164.524 Y125.037 E.00187
; WIPE_START
M204 S3000
G1 X164.648 Y125.146 E-.06284
G1 X165.205 Y125.244 E-.21484
G1 X165.723 Y125.369 E-.20233
G1 X166.202 Y125.521 E-.19109
G1 X166.419 Y125.609 E-.0889
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.5 Y130.428 Z2.4 F30000
G1 X158.366 Y132.165 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X158.198 Y132.073 E.0031
G1 X158.167 Y131.966 E.00182
G1 X158.167 Y127.377 E.07451
G1 X158.22 Y127.241 E.00238
G1 X158.369 Y127.177 E.00262
G1 X161.694 Y127.181 E.05399
G3 X164.169 Y127.349 I.112 J16.662 E.04032
G1 X164.712 Y127.542 E.00936
G3 X165.533 Y128.266 I-1.099 J2.073 E.01794
G1 X165.773 Y128.763 E.00895
G1 X165.902 Y129.293 E.00886
G3 X165.893 Y130.2 I-4.116 J.413 E.01476
G1 X165.755 Y130.705 E.00851
G3 X165.08 Y131.618 I-2.098 J-.846 E.01863
G3 X163.88 Y132.103 I-1.673 J-2.41 E.0212
G3 X160.207 Y132.163 I-2.726 J-54.375 E.05965
G1 X158.426 Y132.165 E.02893
; WIPE_START
M204 S3000
G1 X158.198 Y132.073 E-.0932
G1 X158.167 Y131.966 E-.04268
G1 X158.167 Y130.323 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.157 Y124.548 Z2.4 F30000
G1 X169.308 Y117.429 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X169.826 Y117.947 E.01188
G1 X169.609 Y118.293
G1 X168.745 Y117.429 E.01984
G1 X168.181 Y117.429
G1 X169.392 Y118.64 E.0278
G1 X169.175 Y118.987
G1 X167.617 Y117.429 E.03576
G1 X167.054 Y117.429
G1 X168.958 Y119.333 E.04372
G1 X168.741 Y119.68
G1 X166.68 Y117.619 E.04732
G1 X166.454 Y117.956
G1 X168.524 Y120.026 E.04754
G1 X168.307 Y120.373
G1 X166.227 Y118.294 E.04775
G1 X166.001 Y118.631
G1 X168.09 Y120.719 E.04796
G1 X167.868 Y121.061
G1 X165.775 Y118.968 E.04806
G1 X165.549 Y119.305
G1 X167.644 Y121.401 E.04813
G1 X167.419 Y121.739
G1 X165.322 Y119.643 E.04815
G1 X165.096 Y119.98
G1 X167.185 Y122.069 E.04798
G1 X166.951 Y122.398
G1 X164.87 Y120.317 E.04779
G1 X164.643 Y120.655
G1 X166.702 Y122.713 E.04728
G1 X166.444 Y123.019
G1 X164.417 Y120.992 E.04655
G1 X164.191 Y121.329
G1 X166.167 Y123.305 E.04537
G1 X165.882 Y123.584
G1 X163.964 Y121.666 E.04404
G1 X163.731 Y121.997
G1 X165.575 Y123.841 E.04234
G1 X165.251 Y124.081
G1 X163.498 Y122.328 E.04025
G1 X163.266 Y122.659
G1 X164.917 Y124.31 E.03793
G1 X164.572 Y124.528
G1 X163.033 Y122.989 E.03534
G1 X162.791 Y123.311
G1 X164.295 Y124.815 E.03453
; WIPE_START
M204 S3000
G1 X162.881 Y123.401 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.473 Y125.866 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X168.675 Y128.068 E.05056
G1 X168.919 Y128.876
G1 X165.61 Y125.567 E.07599
G1 X164.89 Y125.41
G1 X169 Y129.52 E.09438
G1 X169.024 Y130.108
G1 X162.537 Y123.62 E.14898
G1 X162.275 Y123.922
G1 X168.99 Y130.638 E.15422
G1 X168.9 Y131.111
G1 X161.969 Y124.18 E.15917
G1 X161.654 Y124.429
G1 X164.447 Y127.221 E.06413
G1 X163.726 Y127.064
G1 X161.282 Y124.62 E.05613
G1 X160.87 Y124.772
G1 X163.111 Y127.013 E.05145
G1 X162.518 Y126.983
G1 X160.394 Y124.86 E.04877
G1 X159.889 Y124.918
G1 X161.939 Y126.968 E.04709
G1 X161.369 Y126.962
G1 X159.347 Y124.94 E.04642
G1 X158.785 Y124.941
G1 X160.805 Y126.961 E.04639
G1 X160.241 Y126.961
G1 X158.177 Y124.897 E.04739
; WIPE_START
M204 S3000
G1 X159.591 Y126.311 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.127 Y118.821 Z2.4 F30000
G1 X157.947 Y117.904 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X157.473 Y117.429 E.0109
G1 X156.909 Y117.429
G1 X157.947 Y118.468 E.02385
G1 X157.947 Y119.031
G1 X156.345 Y117.429 E.03679
G1 X155.782 Y117.429
G1 X157.947 Y119.595 E.04973
G1 X157.947 Y120.158
G1 X155.218 Y117.429 E.06267
G1 X155.171 Y117.946
G1 X157.947 Y120.722 E.06375
G1 X157.947 Y121.286
G1 X155.171 Y118.51 E.06375
G1 X155.171 Y119.073
G1 X157.947 Y121.849 E.06375
G1 X157.947 Y122.413
G1 X155.171 Y119.637 E.06375
G1 X155.171 Y120.2
G1 X157.947 Y122.976 E.06375
G1 X157.947 Y123.54
G1 X155.171 Y120.764 E.06375
G1 X155.171 Y121.328
G1 X157.947 Y124.104 E.06375
G1 X158.004 Y124.724
G1 X155.171 Y121.891 E.06505
G1 X155.171 Y122.455
G1 X159.677 Y126.961 E.10347
G1 X159.113 Y126.96
G1 X155.171 Y123.018 E.09052
G1 X155.171 Y123.582
G1 X158.549 Y126.96 E.07757
G1 X158.092 Y127.066
G1 X155.171 Y124.146 E.06707
G1 X155.171 Y124.709
G1 X157.947 Y127.485 E.06375
G1 X157.947 Y128.049
G1 X155.171 Y125.273 E.06375
G1 X155.171 Y125.836
G1 X157.947 Y128.613 E.06375
G1 X157.947 Y129.176
G1 X155.171 Y126.4 E.06375
G1 X155.171 Y126.964
G1 X157.947 Y129.74 E.06375
G1 X157.947 Y130.303
G1 X155.171 Y127.527 E.06375
G1 X155.171 Y128.091
G1 X157.947 Y130.867 E.06375
G1 X157.947 Y131.431
G1 X155.171 Y128.655 E.06375
G1 X155.171 Y129.218
G1 X157.95 Y131.997 E.06381
; WIPE_START
M204 S3000
G1 X156.536 Y130.583 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.035 Y129.162 Z2.4 F30000
G1 X166.013 Y128.788 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X168.779 Y131.553 E.06351
G1 X168.63 Y131.968
G1 X166.134 Y129.472 E.05732
G1 X166.127 Y130.028
G1 X168.434 Y132.336 E.05299
G1 X168.221 Y132.686
G1 X166.043 Y130.508 E.05001
G1 X165.896 Y130.925
G1 X167.98 Y133.009 E.04786
G1 X167.705 Y133.297
G1 X165.689 Y131.282 E.04629
G1 X165.431 Y131.588
G1 X167.408 Y133.564 E.04539
G1 X167.074 Y133.794
G1 X165.127 Y131.847 E.04473
G1 X164.773 Y132.056
G1 X166.703 Y133.986 E.04432
G1 X166.302 Y134.149
G1 X164.368 Y132.215 E.04441
G1 X163.905 Y132.316
G1 X165.862 Y134.273 E.04493
G1 X165.389 Y134.363
G1 X163.38 Y132.354 E.04614
G1 X162.831 Y132.369
G1 X164.903 Y134.441 E.04759
G1 X164.386 Y134.488
G1 X162.277 Y132.379 E.04843
G1 X161.716 Y132.381
G1 X163.864 Y134.529 E.04933
G1 X163.321 Y134.55
G1 X161.153 Y132.381 E.0498
G1 X160.59 Y132.382
G1 X162.77 Y134.562 E.05007
G1 X162.215 Y134.571
G1 X160.027 Y132.382 E.05025
G1 X159.463 Y132.383
G1 X161.651 Y134.571 E.05024
G1 X161.088 Y134.571
G1 X158.9 Y132.384 E.05023
G1 X158.328 Y132.374
G1 X160.524 Y134.571 E.05044
G1 X159.96 Y134.571
G1 X155.171 Y129.782 E.10998
G1 X155.171 Y130.345
G1 X159.397 Y134.571 E.09703
G1 X158.833 Y134.571
G1 X155.171 Y130.909 E.08409
G1 X155.171 Y131.473
G1 X158.27 Y134.571 E.07115
G1 X157.706 Y134.571
G1 X155.171 Y132.036 E.05821
G1 X155.171 Y132.6
G1 X157.142 Y134.571 E.04526
G1 X156.579 Y134.571
G1 X155.171 Y133.163 E.03232
G1 X155.171 Y133.727
G1 X156.015 Y134.571 E.01938
; WIPE_START
M204 S3000
G1 X155.171 Y133.727 E-.4535
G1 X155.171 Y133.163 E-.21417
G1 X155.343 Y133.335 E-.09233
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X159.468 Y126.913 Z2.4 F30000
G1 X160.838 Y124.781 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.118195
G1 F3600
M204 S3000
G1 X160.729 Y124.843 E.00049
G1 X160.629 Y124.813 E.00041
; WIPE_START
G1 X160.729 Y124.843 E-.34568
G1 X160.838 Y124.781 E-.41432
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.763 Y118.95 Z2.4 F30000
G1 X167.008 Y117.476 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0897016
G1 F3600
M204 S3000
G1 X166.815 Y117.444 E.00054
G2 X166.748 Y117.52 I.202 J.245 E.00028
; WIPE_START
G1 X166.815 Y117.444 E-.25992
G1 X167.008 Y117.476 E-.50008
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.365 Y124.636 Z2.4 F30000
G1 X164.285 Y124.85 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0851878
G1 F3600
M204 S3000
M73 P96 R2
G2 X164.205 Y125.007 I.701 J.459 E.00046
; WIPE_START
G1 X164.285 Y124.85 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.407 Y125.932 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.178812
G1 F3600
M204 S3000
G1 X166.231 Y125.814 E.00136
; LINE_WIDTH: 0.139607
G1 X166.055 Y125.696 E.00102
; WIPE_START
G1 X166.231 Y125.814 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X168.329 Y127.409 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0917426
G1 F3600
M204 S3000
G1 X168.123 Y127.17 E.0009
; LINE_WIDTH: 0.136807
G1 X167.918 Y126.931 E.00148
G1 X167.334 Y126.379 E.00378
; LINE_WIDTH: 0.0919581
G1 X167.175 Y126.256 E.00058
; WIPE_START
G1 X167.334 Y126.379 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.089 Y128.712 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.092698
G1 F3600
M204 S3000
G2 X165.835 Y128.357 I-4.151 J2.709 E.00127
; WIPE_START
G1 X166.089 Y128.712 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X159.201 Y131.999 Z2.4 F30000
G1 X158.248 Y132.454 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.151257
G1 F3600
M204 S3000
G3 X157.867 Y132.08 I1.01 J-1.411 E.00284
; WIPE_START
G1 X157.987 Y132.227 E-.26884
G1 X158.248 Y132.454 E-.49116
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X154.822 Y125.634 Z2.4 F30000
G1 X146.21 Y108.49 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.4 F30000
G1 X167.79 Y108.49 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.237 Y110.892 Z2.4 F30000
G1 X132.95 Y121.243 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X133.088 Y121.299 E.00241
G1 X140.298 Y121.299 E.11707
G1 X140.367 Y121.286 E.00114
G1 X140.483 Y121.173 E.00263
G1 X142.006 Y117.21 E.06895
G1 X143.117 Y117.21 E.01803
G1 X145.506 Y117.21 E.03878
G1 X138.466 Y134.79 E.30749
G1 X134.909 Y134.79 E.05776
G1 X128.062 Y117.21 E.30635
G1 X131.463 Y117.21 E.05523
G1 X132.829 Y120.97 E.06495
G2 X132.916 Y121.194 I.646 J-.123 E.00393
; WIPE_START
M204 S3000
G1 X133.088 Y121.299 E-.07642
G1 X134.887 Y121.299 E-.68358
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.154 Y128.825 Z2.4 F30000
G1 X136.518 Y130.987 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X136.457 Y130.9 E.00173
G1 X134.01 Y124.179 E.11614
G1 X134.024 Y124.012 E.00272
G1 X134.163 Y123.914 E.00275
G1 X134.197 Y123.911 E.00056
G1 X139.14 Y123.911 E.08025
G1 X139.299 Y123.992 E.0029
G1 X139.335 Y124.152 E.00266
G1 X139.326 Y124.18 E.00048
G1 X136.829 Y130.906 E.1165
G1 X136.694 Y131.025 E.00292
G1 X136.577 Y130.999 E.00194
; WIPE_START
M204 S3000
G1 X136.457 Y130.9 E-.05928
G1 X135.826 Y129.167 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.365 Y123.031 Z2.4 F30000
G1 X144.51 Y117.429 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X144.99 Y117.909 E.01102
G1 X144.828 Y118.312
G1 X143.946 Y117.429 E.02026
G1 X143.382 Y117.429
G1 X144.667 Y118.714 E.0295
G1 X144.506 Y119.116
G1 X142.819 Y117.429 E.03875
G1 X142.255 Y117.429
G1 X144.345 Y119.519 E.04799
G1 X144.184 Y119.921
G1 X142.028 Y117.765 E.04951
G1 X141.871 Y118.173
G1 X144.023 Y120.324 E.0494
G1 X143.861 Y120.726
G1 X141.715 Y118.58 E.0493
G1 X141.558 Y118.987
G1 X143.7 Y121.129 E.04919
G1 X143.539 Y121.531
G1 X141.402 Y119.394 E.04908
G1 X141.245 Y119.801
G1 X143.378 Y121.934 E.04898
G1 X143.217 Y122.336
G1 X141.089 Y120.208 E.04887
G1 X140.932 Y120.615
M73 P96 R1
G1 X143.056 Y122.739 E.04876
G1 X142.895 Y123.141
G1 X140.776 Y121.022 E.04865
G1 X140.589 Y121.399
G1 X142.733 Y123.544 E.04924
G1 X142.572 Y123.946
G1 X140.144 Y121.518 E.05576
G1 X139.58 Y121.517
G1 X142.411 Y124.348 E.06502
G1 X142.25 Y124.751
G1 X139.016 Y121.517 E.07427
G1 X138.452 Y121.516
G1 X142.089 Y125.153 E.08353
G1 X141.928 Y125.556
G1 X137.887 Y121.515 E.09278
G1 X137.323 Y121.515
G1 X141.767 Y125.958 E.10204
G1 X141.605 Y126.361
G1 X139.523 Y124.279 E.04781
G1 X139.371 Y124.69
G1 X141.444 Y126.763 E.04761
G1 X141.283 Y127.166
G1 X139.218 Y125.101 E.04742
G1 X139.066 Y125.512
G1 X141.122 Y127.568 E.04722
G1 X140.961 Y127.971
G1 X138.913 Y125.923 E.04702
G1 X138.76 Y126.334
G1 X140.8 Y128.373 E.04683
G1 X140.638 Y128.775
G1 X138.608 Y126.745 E.04663
G1 X138.455 Y127.156
G1 X140.477 Y129.178 E.04644
G1 X140.316 Y129.58
G1 X138.303 Y127.567 E.04624
G1 X138.15 Y127.978
G1 X140.155 Y129.983 E.04604
G1 X139.994 Y130.385
G1 X137.997 Y128.389 E.04585
G1 X137.845 Y128.8
G1 X139.833 Y130.788 E.04565
G1 X139.672 Y131.19
G1 X137.692 Y129.211 E.04546
G1 X137.54 Y129.622
G1 X139.51 Y131.593 E.04526
G1 X139.349 Y131.995
G1 X137.387 Y130.033 E.04506
G1 X137.234 Y130.444
G1 X139.188 Y132.398 E.04487
G1 X139.027 Y132.8
G1 X137.082 Y130.855 E.04467
G1 X136.849 Y131.185
G1 X138.866 Y133.203 E.04632
; WIPE_START
M204 S3000
G1 X137.452 Y131.788 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.829 Y124.281 Z2.4 F30000
G1 X138.937 Y123.692 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X136.759 Y121.514 E.05001
G1 X136.195 Y121.514
G1 X138.373 Y123.692 E.05003
G1 X137.81 Y123.692
G1 X135.631 Y121.513 E.05004
G1 X135.067 Y121.513
G1 X137.246 Y123.692 E.05005
G1 X136.682 Y123.692
G1 X134.502 Y121.512 E.05006
G1 X133.938 Y121.512
G1 X136.119 Y123.692 E.05008
G1 X135.555 Y123.692
G1 X133.374 Y121.511 E.05009
; WIPE_START
M204 S3000
G1 X134.788 Y122.925 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.495 Y117.941 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X130.983 Y117.429 E.01176
G1 X130.419 Y117.429
G1 X131.817 Y118.827 E.03209
G1 X132.139 Y119.712
G1 X129.856 Y117.429 E.05242
G1 X129.292 Y117.429
G1 X132.46 Y120.597 E.07275
; WIPE_START
M204 S3000
G1 X131.046 Y119.183 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.992 Y123.692 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X128.729 Y117.429 E.14382
G1 X128.521 Y117.785
G1 X134.428 Y123.692 E.13566
G1 X133.952 Y123.779
G1 X128.88 Y118.708 E.11646
G1 X129.24 Y119.631
G1 X133.796 Y124.187 E.10462
G1 X134.094 Y125.048
G1 X129.599 Y120.554 E.1032
G1 X129.959 Y121.478
G1 X134.416 Y125.935 E.10235
G1 X134.739 Y126.821
G1 X130.319 Y122.401 E.1015
G1 X130.678 Y123.324
G1 X135.061 Y127.707 E.10065
G1 X135.384 Y128.593
G1 X131.038 Y124.247 E.0998
G1 X131.397 Y125.17
G1 X135.706 Y129.479 E.09895
G1 X136.029 Y130.365
G1 X131.757 Y126.094 E.0981
G1 X132.116 Y127.017
G1 X138.705 Y133.605 E.15129
G1 X138.544 Y134.007
G1 X132.476 Y127.94 E.13933
G1 X132.836 Y128.863
G1 X138.382 Y134.41 E.12738
G1 X137.98 Y134.571
G1 X133.195 Y129.786 E.10987
G1 X133.555 Y130.709
G1 X137.416 Y134.571 E.08867
G1 X136.853 Y134.571
G1 X133.914 Y131.633 E.06747
G1 X134.274 Y132.556
G1 X136.289 Y134.571 E.04627
G1 X135.725 Y134.571
G1 X134.633 Y133.479 E.02507
; WIPE_START
M204 S3000
G1 X135.725 Y134.571 E-.58677
G1 X136.181 Y134.571 E-.17323
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.532 Y128.996 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.183948
G1 F3600
M204 S3000
G1 X135.317 Y128.66 E.00264
; WIPE_START
G1 X135.532 Y128.996 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.177 Y130.769 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.186627
G1 F3600
M204 S3000
G1 X135.962 Y130.432 E.00269
; WIPE_START
G1 X136.177 Y130.769 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X139.614 Y124.188 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0751765
G1 F3600
M204 S3000
G2 X139.546 Y124.045 I-.687 J.241 E.00035
M204 S10000
G1 X139.228 Y123.718 F30000
; LINE_WIDTH: 0.0990026
G1 F3600
M204 S3000
G1 X139.02 Y123.609 E.00074
; WIPE_START
G1 X139.228 Y123.718 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.5 Y121.458 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0743146
G1 F3600
M204 S3000
G1 X140.448 Y121.499 E.00014
G1 X140.395 Y121.486 E.00012
; WIPE_START
G1 X140.448 Y121.499 E-.34682
G1 X140.5 Y121.458 E-.41318
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.361 Y118.759 Z2.4 F30000
G1 X106.21 Y108.49 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y108.196 Z2.4 F30000
G1 X90.21 Y108.49 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.884 Y114.739 Z2.4 F30000
G1 X98.758 Y118.262 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X101.419 Y121.357 I-4.269 J6.362 E.06709
G3 X102.288 Y124.933 I-9.672 J4.246 E.06006
G1 X102.316 Y125.475 E.00881
G3 X101.995 Y128.951 I-13.534 J.502 E.05685
G3 X101.012 Y131.376 I-9.293 J-2.357 E.04261
G3 X96.485 Y134.757 I-6.56 J-4.061 E.09393
G3 X91.283 Y134.824 I-2.743 J-11.011 E.08522
G1 X90.402 Y134.564 E.01493
G1 X89.379 Y134.11 E.01817
G3 X85.488 Y128.382 I4.112 J-6.98 E.11618
G3 X85.513 Y123.425 I14.135 J-2.407 E.0809
G3 X86.813 Y120.246 I8.552 J1.641 E.05614
G3 X90.696 Y117.362 I6.182 J4.269 E.07997
G3 X93.888 Y116.904 I3.079 J10.116 E.05256
G3 X97.32 Y117.505 I.039 J9.89 E.05687
G3 X98.708 Y118.228 I-2.832 J7.119 E.02546
; WIPE_START
M204 S3000
G1 X99.413 Y118.739 E-.33091
G1 X100.014 Y119.301 E-.31246
G1 X100.214 Y119.533 E-.11663
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.871 Y121.656 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S1500
G3 X98.625 Y123.246 I-4.123 J2.931 E.02873
G3 X98.966 Y126.817 I-10.895 J2.842 E.05849
G3 X98.446 Y129.384 I-8.699 J-.426 E.0427
G3 X95.933 Y132.009 I-4.436 J-1.732 E.06053
G3 X93.259 Y132.386 I-2.133 J-5.453 E.04425
G3 X89.707 Y130.379 I.351 J-4.767 E.06844
G3 X88.809 Y128.172 I5.311 J-3.447 E.03892
G3 X88.626 Y125.475 I10.957 J-2.101 E.044
G3 X89.299 Y122.433 I8.061 J.187 E.05091
G1 X89.723 Y121.684 E.01398
G3 X91.29 Y120.236 I4.366 J3.153 E.03488
G1 X91.74 Y120.006 E.00819
G3 X95.87 Y119.994 I2.079 J4.945 E.06884
G3 X97.835 Y121.607 I-2.122 J4.592 E.04173
; WIPE_START
M204 S3000
G1 X98.173 Y122.137 E-.2388
G1 X98.424 Y122.671 E-.22423
G1 X98.625 Y123.246 E-.23154
G1 X98.667 Y123.413 E-.06544
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.616 Y117.878 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X101.242 Y121.504 E.08326
G1 X101.591 Y122.417
G1 X96.707 Y117.533 E.11215
G1 X95.949 Y117.339
G1 X101.808 Y123.198 E.13455
G1 X101.946 Y123.9
G1 X95.27 Y117.224 E.15331
G1 X94.638 Y117.155
G1 X102.021 Y124.538 E.16955
G1 X102.079 Y125.159
G1 X94.05 Y117.13 E.18438
G1 X93.486 Y117.13
G1 X96.348 Y119.992 E.06572
G1 X95.382 Y119.59
G1 X92.956 Y117.164 E.05573
G1 X92.434 Y117.206
G1 X94.667 Y119.438 E.05128
G1 X94.046 Y119.381
G1 X91.952 Y117.287 E.04808
G1 X91.479 Y117.377
G1 X93.487 Y119.385 E.04611
G1 X92.974 Y119.436
G1 X91.035 Y117.497 E.04453
G1 X90.606 Y117.631
G1 X92.501 Y119.527 E.04353
G1 X92.062 Y119.651
G1 X90.198 Y117.788 E.04279
G1 X89.809 Y117.962
G1 X91.652 Y119.805 E.04232
G1 X91.279 Y119.996
G1 X89.437 Y118.153 E.0423
G1 X89.086 Y118.366
G1 X90.93 Y120.21 E.04236
G1 X90.603 Y120.447
G1 X88.746 Y118.59 E.04264
G1 X88.429 Y118.837
G1 X90.295 Y120.703 E.04285
G1 X90.016 Y120.987
G1 X88.122 Y119.093 E.04351
G1 X87.837 Y119.371
G1 X89.754 Y121.289 E.04404
G1 X89.512 Y121.611
G1 X87.56 Y119.658 E.04484
G1 X87.305 Y119.967
G1 X89.296 Y121.958 E.04572
G1 X89.106 Y122.331
G1 X87.059 Y120.285 E.04699
G1 X86.837 Y120.626
G1 X88.934 Y122.723 E.04815
G1 X88.784 Y123.137
G1 X86.623 Y120.976 E.04963
G1 X86.435 Y121.351
G1 X88.665 Y123.581 E.0512
G1 X88.564 Y124.044
G1 X86.255 Y121.734 E.05304
G1 X86.102 Y122.146
G1 X88.482 Y124.526 E.05467
G1 X88.433 Y125.04
G1 X85.956 Y122.563 E.0569
G1 X85.84 Y123.011
G1 X88.404 Y125.575 E.05887
G1 X88.394 Y126.128
G1 X85.729 Y123.463 E.0612
G1 X85.653 Y123.951
G1 X88.411 Y126.709 E.06332
G1 X88.462 Y127.324
G1 X85.581 Y124.443 E.06616
G1 X85.543 Y124.968
G1 X88.555 Y127.981 E.06918
G1 X88.717 Y128.706
G1 X85.514 Y125.502 E.07356
G1 X85.515 Y126.068
G1 X89.019 Y129.572 E.08047
; WIPE_START
M204 S3000
G1 X87.605 Y128.158 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.216 Y124.344 Z2.4 F30000
G1 X98.328 Y121.972 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X102.098 Y125.742 E.08658
G1 X102.1 Y126.308
G1 X98.76 Y122.968 E.0767
G1 X98.977 Y123.749
G1 X102.078 Y126.849 E.0712
G1 X102.03 Y127.365
G1 X99.099 Y124.434 E.06732
G1 X99.165 Y125.063
G1 X101.974 Y127.873 E.06452
G1 X101.889 Y128.352
G1 X99.195 Y125.657 E.06187
G1 X99.202 Y126.228
G1 X101.797 Y128.822 E.05958
G1 X101.674 Y129.264
G1 X99.187 Y126.776 E.05713
G1 X99.143 Y127.296
G1 X101.546 Y129.699 E.05519
G1 X101.387 Y130.104
G1 X99.081 Y127.797 E.05297
G1 X98.999 Y128.279
G1 X101.225 Y130.505 E.05111
G1 X101.031 Y130.875
G1 X98.888 Y128.732 E.04922
G1 X98.754 Y129.162
G1 X100.835 Y131.242 E.04777
G1 X100.607 Y131.578
G1 X98.601 Y129.572 E.04607
G1 X98.423 Y129.958
G1 X100.378 Y131.912 E.04489
G1 X100.118 Y132.216
G1 X98.215 Y130.313 E.0437
G1 X97.987 Y130.649
G1 X99.857 Y132.518 E.04293
G1 X99.567 Y132.792
G1 X97.738 Y130.964 E.04199
G1 X97.459 Y131.248
G1 X99.275 Y133.064 E.04169
G1 X98.955 Y133.307
G1 X97.159 Y131.512 E.04123
G1 X96.838 Y131.755
G1 X98.632 Y133.548 E.04119
G1 X98.279 Y133.759
G1 X96.495 Y131.975 E.04097
G1 X96.118 Y132.162
G1 X97.923 Y133.966 E.04144
G1 X97.534 Y134.141
G1 X95.714 Y132.321 E.04181
G1 X95.28 Y132.45
G1 X97.14 Y134.311 E.04273
G1 X96.716 Y134.45
G1 X94.813 Y132.547 E.04371
G1 X94.309 Y132.607
G1 X96.28 Y134.578 E.04526
G1 X95.819 Y134.68
G1 X93.766 Y132.628 E.04713
G1 X93.17 Y132.595
G1 X95.337 Y134.762 E.04977
G1 X94.836 Y134.825
G1 X92.494 Y132.483 E.05378
G1 X91.677 Y132.229
G1 X94.304 Y134.857 E.06034
G1 X93.761 Y134.877
G1 X85.522 Y126.638 E.1892
G1 X85.561 Y127.241
G1 X93.181 Y134.86 E.17498
G1 X92.564 Y134.807
G1 X85.632 Y127.875 E.15919
G1 X85.746 Y128.553
G1 X91.91 Y134.716 E.14153
G1 X91.201 Y134.571
G1 X85.922 Y129.293 E.12122
G1 X86.218 Y130.152
G1 X90.381 Y134.315 E.09561
G1 X89.312 Y133.809
G1 X86.83 Y131.328 E.05699
; WIPE_START
M204 S3000
G1 X88.244 Y132.742 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.807 Y127.516 Z2.4 F30000
G1 X100.9 Y120.852 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0866681
G1 F3600
M204 S3000
G1 X100.816 Y120.738 E.00038
; LINE_WIDTH: 0.128902
G1 X100.645 Y120.532 E.00117
; LINE_WIDTH: 0.178577
G1 X100.474 Y120.326 E.00171
; LINE_WIDTH: 0.228252
G1 X100.303 Y120.12 E.00225
; LINE_WIDTH: 0.267845
G1 X100.034 Y119.83 E.00397
; LINE_WIDTH: 0.298365
G2 X99.2 Y118.994 I-8.129 J7.274 E.01333
; LINE_WIDTH: 0.267124
G1 X99.003 Y118.823 E.0026
; LINE_WIDTH: 0.230157
G1 X98.807 Y118.653 E.00221
; LINE_WIDTH: 0.193191
G1 X98.61 Y118.483 E.00182
; LINE_WIDTH: 0.157145
G1 X98.494 Y118.392 E.00082
; LINE_WIDTH: 0.121999
G1 X98.377 Y118.302 E.0006
; LINE_WIDTH: 0.0868525
G1 X98.26 Y118.211 E.00039
M204 S10000
G1 X97.55 Y117.944 F30000
; LINE_WIDTH: 0.184087
G1 F3600
M204 S3000
G1 X97.422 Y117.855 E.00103
; LINE_WIDTH: 0.149
G1 X97.294 Y117.767 E.00081
; LINE_WIDTH: 0.113913
G1 X97.166 Y117.678 E.00059
; WIPE_START
G1 X97.294 Y117.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.89 Y117.398 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0700459
G1 F3600
M204 S3000
G1 X95.615 Y117.263 E.00061
; WIPE_START
G1 X95.89 Y117.398 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.736 Y123.801 Z2.4 F30000
G1 X86.894 Y131.264 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.19757
G1 F3600
M204 S3000
G1 X86.769 Y131.105 E.00145
; LINE_WIDTH: 0.161984
G1 X86.644 Y130.947 E.00115
; LINE_WIDTH: 0.125457
G1 X86.569 Y130.842 E.00055
; LINE_WIDTH: 0.0880026
G1 X86.494 Y130.738 E.00035
; WIPE_START
G1 X86.569 Y130.842 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.256 Y130.061 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0787793
G1 F3600
M204 S3000
G1 X89.192 Y129.979 E.00024
; LINE_WIDTH: 0.107658
G1 X89.113 Y129.865 E.00049
; LINE_WIDTH: 0.145618
G1 X89.033 Y129.751 E.0007
; LINE_WIDTH: 0.183578
G1 X88.954 Y129.637 E.00092
M204 S10000
G1 X88.827 Y129.079 F30000
; LINE_WIDTH: 0.167886
G1 F3600
M204 S3000
G3 X88.649 Y128.774 I7.009 J-4.309 E.00211
; WIPE_START
G1 X88.827 Y129.079 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X88.341 Y127.485 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0777827
G1 F3600
M204 S3000
G1 X88.484 Y127.342 E.00046
M204 S10000
G1 X88.498 Y127.62 F30000
; LINE_WIDTH: 0.112544
G1 F3600
M204 S3000
G1 X88.389 Y127.398 E.00092
; WIPE_START
G1 X88.498 Y127.62 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X88.354 Y125.12 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0837015
G1 F3600
M204 S3000
G1 X88.429 Y125.318 E.00054
; WIPE_START
G1 X88.354 Y125.12 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.122 Y121.592 Z2.4 F30000
G1 X97.143 Y120.538 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0820169
G1 F3600
M204 S3000
G1 X96.919 Y120.333 E.00075
; LINE_WIDTH: 0.112807
G1 X96.78 Y120.22 E.00067
; LINE_WIDTH: 0.148449
G1 X96.642 Y120.107 E.00093
; LINE_WIDTH: 0.192364
G1 X96.413 Y119.927 E.00203
; WIPE_START
G1 X96.642 Y120.107 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.392 Y121.908 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.192215
G1 F3600
M204 S3000
G1 X98.248 Y121.724 E.00162
; LINE_WIDTH: 0.147142
G1 X98.1 Y121.536 E.00123
; LINE_WIDTH: 0.110604
G1 X97.946 Y121.361 E.00085
; LINE_WIDTH: 0.0830606
G1 X97.792 Y121.186 E.00059
; WIPE_START
G1 X97.946 Y121.361 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P97 R1
G1 X98.833 Y122.895 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0706676
G1 F3600
M204 S3000
G2 X98.619 Y122.574 I-5.727 J3.566 E.00077
; WIPE_START
G1 X98.833 Y122.895 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.652 Y130.209 Z2.4 F30000
G1 X96.062 Y132.19 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0730278
G1 F3600
M204 S3000
G3 X95.945 Y132.27 I-1.403 J-1.917 E.0003
; WIPE_START
G1 X96.062 Y132.19 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.099 Y132.665 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0791942
G1 F3600
M204 S3000
G1 X92.865 Y132.549 E.00061
; WIPE_START
G1 X93.099 Y132.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.688 Y132.218 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.141284
G1 F3600
M204 S3000
G1 X91.58 Y132.238 E.00054
; LINE_WIDTH: 0.158812
G1 X91.558 Y132.242 E.00012
; LINE_WIDTH: 0.184784
G1 X91.536 Y132.245 E.00015
; LINE_WIDTH: 0.176356
G1 X91.421 Y132.163 E.00089
; LINE_WIDTH: 0.133529
G1 X91.306 Y132.08 E.00065
; LINE_WIDTH: 0.0907009
G1 X91.192 Y131.997 E.0004
; WIPE_START
G1 X91.306 Y132.08 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.793 Y128.058 Z2.4 F30000
G1 X102.054 Y125.417 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.115975
G1 F3600
M204 S3000
G1 X102.054 Y125.184 E.0009
; WIPE_START
G1 X102.054 Y125.417 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.907 Y122.738 Z2.4 F30000
G1 X77.49 Y116.21 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.314 Y126.926 Z2.4 F30000
G1 X77.49 Y131.21 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.261 Y138.665 Z2.4 F30000
G1 X90.21 Y143.51 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y143.711 Z2.4 F30000
G1 X106.21 Y143.51 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.676 Y136.747 Z2.4 F30000
G1 X116.218 Y122.885 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X116.065 Y122.979 E.0029
G1 X108.826 Y134.79 E.22494
G1 X105.618 Y134.79 E.0521
G1 X105.618 Y117.21 E.28546
G1 X108.574 Y117.21 E.04801
G1 X108.574 Y128.611 E.18512
G1 X108.655 Y128.771 E.00291
G1 X108.877 Y128.834 E.00375
G1 X109.03 Y128.74 E.00291
G1 X116.158 Y117.21 E.22011
G1 X119.478 Y117.21 E.0539
G1 X119.478 Y119.341 E.03461
G1 X119.478 Y134.79 E.25085
G1 X116.521 Y134.79 E.04801
G1 X116.521 Y123.108 E.18969
G1 X116.44 Y122.948 E.00291
G1 X116.275 Y122.901 E.00278
; WIPE_START
M204 S3000
G1 X116.065 Y122.979 E-.08506
G1 X115.137 Y124.493 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.258 Y118.104 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X118.584 Y117.429 E.01549
G1 X118.02 Y117.429
G1 X119.258 Y118.667 E.02844
G1 X119.258 Y119.231
G1 X117.456 Y117.429 E.04138
G1 X116.893 Y117.429
G1 X119.258 Y119.795 E.05432
G1 X119.258 Y120.358
G1 X116.329 Y117.429 E.06726
G1 X116.084 Y117.747
G1 X119.258 Y120.922 E.07291
G1 X119.258 Y121.486
G1 X115.868 Y118.095 E.07785
G1 X115.653 Y118.444
G1 X119.258 Y122.049 E.08279
G1 X119.258 Y122.613
G1 X115.438 Y118.792 E.08774
G1 X115.222 Y119.14
G1 X119.258 Y123.176 E.09268
G1 X119.258 Y123.74
G1 X115.007 Y119.489 E.09763
G1 X114.792 Y119.837
G1 X119.258 Y124.304 E.10257
G1 X119.258 Y124.867
G1 X114.576 Y120.185 E.10752
G1 X114.361 Y120.533
G1 X119.258 Y125.431 E.11246
G1 X119.258 Y125.994
G1 X116.74 Y123.476 E.05783
G1 X116.74 Y124.04
G1 X119.258 Y126.558 E.05783
G1 X119.258 Y127.122
G1 X116.74 Y124.603 E.05783
G1 X116.74 Y125.167
G1 X119.258 Y127.685 E.05783
G1 X119.258 Y128.249
G1 X116.74 Y125.731 E.05783
G1 X116.74 Y126.294
G1 X119.258 Y128.812 E.05783
G1 X119.258 Y129.376
G1 X116.74 Y126.858 E.05783
G1 X116.74 Y127.421
G1 X119.258 Y129.94 E.05783
G1 X119.258 Y130.503
G1 X116.74 Y127.985 E.05783
G1 X116.74 Y128.549
G1 X119.258 Y131.067 E.05783
G1 X119.258 Y131.63
G1 X116.74 Y129.112 E.05783
G1 X116.74 Y129.676
G1 X119.258 Y132.194 E.05783
G1 X119.258 Y132.758
G1 X116.74 Y130.239 E.05783
G1 X116.74 Y130.803
G1 X119.258 Y133.321 E.05783
G1 X119.258 Y133.885
G1 X116.74 Y131.367 E.05783
G1 X116.74 Y131.93
G1 X119.258 Y134.448 E.05783
G1 X118.817 Y134.571
G1 X116.74 Y132.494 E.04769
G1 X116.74 Y133.058
G1 X118.254 Y134.571 E.03475
G1 X117.69 Y134.571
G1 X116.74 Y133.621 E.02181
G1 X116.74 Y134.185
G1 X117.126 Y134.571 E.00887
; WIPE_START
M204 S3000
G1 X116.74 Y134.185 E-.20749
G1 X116.74 Y133.621 E-.21417
G1 X117.37 Y134.251 E-.33833
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.471 Y126.671 Z2.4 F30000
G1 X116.004 Y122.74 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X114.146 Y120.882 E.04268
G1 X113.93 Y121.23
G1 X115.759 Y123.059 E.04199
G1 X115.545 Y123.408
G1 X113.715 Y121.578 E.04202
G1 X113.5 Y121.927
G1 X115.331 Y123.758 E.04205
G1 X115.117 Y124.107
G1 X113.285 Y122.275 E.04207
G1 X113.069 Y122.623
G1 X114.902 Y124.456 E.0421
G1 X114.688 Y124.806
G1 X112.854 Y122.972 E.04213
G1 X112.639 Y123.32
G1 X114.474 Y125.155 E.04215
G1 X114.26 Y125.505
G1 X112.423 Y123.668 E.04218
G1 X112.208 Y124.016
G1 X114.046 Y125.854 E.04221
G1 X113.832 Y126.204
G1 X111.993 Y124.365 E.04223
G1 X111.777 Y124.713
G1 X113.618 Y126.553 E.04226
G1 X113.403 Y126.903
G1 X111.562 Y125.061 E.04228
G1 X111.347 Y125.41
G1 X113.189 Y127.252 E.04231
G1 X112.975 Y127.601
G1 X111.131 Y125.758 E.04234
G1 X110.916 Y126.106
G1 X112.761 Y127.951 E.04236
G1 X112.547 Y128.3
G1 X110.701 Y126.454 E.04239
G1 X110.485 Y126.803
G1 X112.333 Y128.65 E.04242
G1 X112.118 Y128.999
G1 X110.27 Y127.151 E.04244
G1 X110.055 Y127.499
G1 X111.904 Y129.349 E.04247
G1 X111.69 Y129.698
G1 X109.839 Y127.848 E.0425
G1 X109.624 Y128.196
G1 X111.476 Y130.048 E.04252
G1 X111.262 Y130.397
G1 X109.409 Y128.544 E.04255
G1 X109.186 Y128.885
G1 X111.048 Y130.746 E.04274
G1 X110.833 Y131.096
G1 X108.769 Y129.032 E.0474
; WIPE_START
M204 S3000
G1 X110.184 Y130.446 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.082 Y122.893 Z2.4 F30000
G1 X108.355 Y117.909 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X107.875 Y117.429 E.01102
G1 X107.312 Y117.429
G1 X108.355 Y118.473 E.02397
G1 X108.355 Y119.036
G1 X106.748 Y117.429 E.03691
G1 X106.184 Y117.429
G1 X108.355 Y119.6 E.04985
G1 X108.355 Y120.164
G1 X105.837 Y117.646 E.05783
G1 X105.837 Y118.209
G1 X108.355 Y120.727 E.05783
G1 X108.355 Y121.291
G1 X105.837 Y118.773 E.05783
G1 X105.837 Y119.336
G1 X108.355 Y121.855 E.05783
G1 X108.355 Y122.418
G1 X105.837 Y119.9 E.05783
G1 X105.837 Y120.464
G1 X108.355 Y122.982 E.05783
G1 X108.355 Y123.545
G1 X105.837 Y121.027 E.05783
G1 X105.837 Y121.591
G1 X108.355 Y124.109 E.05783
G1 X108.355 Y124.673
G1 X105.837 Y122.154 E.05783
G1 X105.837 Y122.718
G1 X108.355 Y125.236 E.05783
G1 X108.355 Y125.8
G1 X105.837 Y123.282 E.05783
G1 X105.837 Y123.845
G1 X108.355 Y126.363 E.05783
G1 X108.355 Y126.927
G1 X105.837 Y124.409 E.05783
G1 X105.837 Y124.972
G1 X108.355 Y127.491 E.05783
G1 X108.355 Y128.054
G1 X105.837 Y125.536 E.05783
G1 X105.837 Y126.1
G1 X108.357 Y128.619 E.05786
; WIPE_START
M204 S3000
G1 X106.943 Y127.205 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.837 Y126.663 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X110.619 Y131.445 E.10982
G1 X110.405 Y131.795
G1 X105.837 Y127.227 E.1049
G1 X105.837 Y127.79
G1 X110.191 Y132.144 E.09998
G1 X109.977 Y132.494
G1 X105.837 Y128.354 E.09506
G1 X105.837 Y128.918
G1 X109.763 Y132.843 E.09015
G1 X109.548 Y133.193
G1 X105.837 Y129.481 E.08523
G1 X105.837 Y130.045
G1 X109.334 Y133.542 E.08031
G1 X109.12 Y133.891
G1 X105.837 Y130.608 E.07539
G1 X105.837 Y131.172
G1 X108.906 Y134.241 E.07047
G1 X108.672 Y134.571
G1 X105.837 Y131.736 E.06511
G1 X105.837 Y132.299
G1 X108.109 Y134.571 E.05216
G1 X107.545 Y134.571
G1 X105.837 Y132.863 E.03922
G1 X105.837 Y133.426
G1 X106.981 Y134.571 E.02628
G1 X106.418 Y134.571
G1 X105.837 Y133.99 E.01334
; WIPE_START
M204 S3000
G1 X106.418 Y134.571 E-.31209
G1 X106.981 Y134.571 E-.21417
G1 X106.546 Y134.136 E-.23373
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.346 Y126.506 Z2.4 F30000
G1 X106.11 Y117.503 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.136692
G1 F3600
M204 S3000
G1 X106.018 Y117.465 E.00047
G1 X105.817 Y117.465 E.00094
; WIPE_START
G1 X106.018 Y117.465 E-.50657
G1 X106.11 Y117.503 E-.25343
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.828 Y124.94 Z2.4 F30000
G1 X108.772 Y129.029 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.146858
G1 F3600
M204 S3000
G1 X108.628 Y129.063 E.00076
G3 X108.277 Y128.7 I.744 J-1.072 E.0026
; CHANGE_LAYER
; Z_HEIGHT: 2.1
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F3600
G1 X108.496 Y128.966 E-.39928
G1 X108.628 Y129.063 E-.18962
G1 X108.772 Y129.029 E-.1711
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/24
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.4 I.585 J1.067 P1  F30000
G1 X146.21 Y108.49 Z2.4
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F2020
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.5 F30000
G1 X167.79 Y108.49 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X171.782 Y112.029 Z2.5 F30000
G1 X178.51 Y116.21 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2020
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.5 F30000
G1 X178.51 Y131.21 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2020
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.5 F30000
G1 X162.21 Y143.51 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.5 F30000
G1 X146.21 Y143.51 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.668 Y143.913 Z2.5 F30000
G1 X106.21 Y143.51 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y143.804 Z2.5 F30000
G1 X90.21 Y143.51 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.366 Y139.2 Z2.5 F30000
G1 X77.49 Y131.21 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.207 Y126.67 Z2.5 F30000
G1 X77.49 Y116.21 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.907 Y114.466 Z2.5 F30000
G1 X90.21 Y108.49 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y108.289 Z2.5 F30000
G1 X106.21 Y108.49 Z2.5
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2020
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2020
M204 S3000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/24
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.5 I-.016 J1.217 P1  F30000
G1 X146.21 Y108.49 Z2.5
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.6 F30000
G1 X167.79 Y108.49 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X171.782 Y112.029 Z2.6 F30000
G1 X178.51 Y116.21 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2019
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.6 F30000
G1 X178.51 Y131.21 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2019
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.6 F30000
G1 X162.21 Y143.51 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.6 F30000
G1 X146.21 Y143.51 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.668 Y143.913 Z2.6 F30000
G1 X106.21 Y143.51 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y143.804 Z2.6 F30000
G1 X90.21 Y143.51 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
M73 P98 R1
G1 F2019
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.366 Y139.2 Z2.6 F30000
G1 X77.49 Y131.21 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.207 Y126.67 Z2.6 F30000
G1 X77.49 Y116.21 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.907 Y114.466 Z2.6 F30000
G1 X90.21 Y108.49 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y108.289 Z2.6 F30000
G1 X106.21 Y108.49 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
M73 P98 R0
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/24
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.6 I-.016 J1.217 P1  F30000
G1 X146.21 Y108.49 Z2.6
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F2019
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.7 F30000
G1 X167.79 Y108.49 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.7 F30000
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X171.782 Y112.029 Z2.7 F30000
G1 X178.51 Y116.21 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.7 F30000
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2019
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.7 F30000
G1 X178.51 Y131.21 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.7 F30000
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2019
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.7 F30000
G1 X162.21 Y143.51 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.7 F30000
G1 X146.21 Y143.51 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.668 Y143.913 Z2.7 F30000
G1 X106.21 Y143.51 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y143.804 Z2.7 F30000
G1 X90.21 Y143.51 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.366 Y139.2 Z2.7 F30000
G1 X77.49 Y131.21 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.207 Y126.67 Z2.7 F30000
G1 X77.49 Y116.21 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.907 Y114.466 Z2.7 F30000
G1 X90.21 Y108.49 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y108.289 Z2.7 F30000
G1 X106.21 Y108.49 Z2.7
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/24
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.7 I-.016 J1.217 P1  F30000
G1 X146.21 Y108.49 Z2.7
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.93 Y108.202 Z2.8 F30000
G1 X167.79 Y108.49 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S3000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.7 Y108 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X171.782 Y112.029 Z2.8 F30000
G1 X178.51 Y116.21 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y121.3 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2019
M204 S3000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.701 Y126.327 Z2.8 F30000
G1 X178.51 Y131.21 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
G1 F3600
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179 Y136.3 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2019
M204 S3000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.41 Y137.55 Z2.8 F30000
G1 X162.21 Y143.51 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.67 Y143.804 Z2.8 F30000
G1 X146.21 Y143.51 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.668 Y143.913 Z2.8 F30000
G1 X106.21 Y143.51 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.67 Y143.804 Z2.8 F30000
G1 X90.21 Y143.51 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.366 Y139.2 Z2.8 F30000
G1 X77.49 Y131.21 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.207 Y126.67 Z2.8 F30000
G1 X77.49 Y116.21 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.907 Y114.466 Z2.8 F30000
G1 X90.21 Y108.49 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.927 Y108.289 Z2.8 F30000
G1 X106.21 Y108.49 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2019
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2019
M204 S3000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.5
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/24
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.8 I-.016 J1.217 P1  F30000
G1 X146.21 Y108.49 Z2.8
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
; WIPE_START
M204 S3000
G1 X146.21 Y107.51 E-.37311
G1 X147.228 Y107.51 E-.38689
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.083 Y108.271 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X151.571 Y107.783 E.01119
G1 X151.061 Y107.729
G1 X150.52 Y108.271 E.01244
G1 X149.956 Y108.271
G1 X150.498 Y107.729 E.01244
G1 X149.934 Y107.729
G1 X149.393 Y108.271 E.01244
G1 X148.829 Y108.271
G1 X149.371 Y107.729 E.01244
G1 X148.807 Y107.729
G1 X148.265 Y108.271 E.01244
G1 X147.702 Y108.271
G1 X148.243 Y107.729 E.01244
G1 X147.68 Y107.729
G1 X147.138 Y108.271 E.01244
G1 X146.575 Y108.271
G1 X147.116 Y107.729 E.01244
; WIPE_START
M204 S3000
G1 X146.575 Y108.271 E-.29108
G1 X147.138 Y108.271 E-.21417
G1 X147.612 Y107.797 E-.25475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.24 Y108.059 Z2.9 F30000
G1 X167.79 Y108.49 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
M204 S10000
G1 X166.864 Y108.271 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X167.406 Y107.729 E.01244
G1 X166.842 Y107.729
G1 X166.301 Y108.271 E.01244
G1 X165.737 Y108.271
G1 X166.279 Y107.729 E.01244
G1 X165.715 Y107.729
G1 X165.174 Y108.271 E.01244
G1 X164.61 Y108.271
G1 X165.152 Y107.729 E.01244
G1 X164.588 Y107.729
G1 X164.046 Y108.271 E.01244
G1 X163.483 Y108.271
G1 X164.024 Y107.729 E.01244
G1 X163.461 Y107.729
G1 X162.919 Y108.271 E.01244
G1 X162.429 Y108.197
G1 X162.897 Y107.729 E.01075
; WIPE_START
M204 S3000
G1 X162.429 Y108.197 E-.25149
G1 X162.919 Y108.271 E-.18827
G1 X163.461 Y107.729 E-.29108
G1 X163.537 Y107.729 E-.02915
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.565 Y108.291 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0727399
G1 F3600
M204 S3000
G1 X167.565 Y107.709 E.00121
; WIPE_START
G1 X167.565 Y108.291 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X173.749 Y112.765 Z2.9 F30000
G1 X178.51 Y116.21 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y116.21 E.01591
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

G1 X179.49 Y116.7 E.00796
G1 X179.49 Y121.79 E.08265
G1 X178.51 Y121.79 E.01591
G1 X178.51 Y116.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.271 Y120.663 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X178.729 Y121.205 E.01244
G1 X178.729 Y120.641
G1 X179.271 Y120.099 E.01244
G1 X179.271 Y119.536
G1 X178.729 Y120.077 E.01244
G1 X178.729 Y119.514
G1 X179.271 Y118.972 E.01244
G1 X179.271 Y118.409
G1 X178.729 Y118.95 E.01244
G1 X178.729 Y118.387
G1 X179.271 Y117.845 E.01244
G1 X179.271 Y117.281
G1 X178.729 Y117.823 E.01244
G1 X178.729 Y117.259
G1 X179.271 Y116.718 E.01244
; WIPE_START
M204 S3000
G1 X178.729 Y117.259 E-.29107
G1 X178.729 Y117.823 E-.21417
G1 X179.203 Y117.349 E-.25476
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y121.404 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.290185
G1 F3600
M204 S3000
G1 X178.834 Y121.466 E.00504
; LINE_WIDTH: 0.256314
G1 X178.772 Y121.358 E.00119
; LINE_WIDTH: 0.225421
G1 X178.709 Y121.25 E.00104
; WIPE_START
G1 X178.772 Y121.358 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.291 Y116.73 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.214572
G1 F3600
M204 S3000
G1 X179.194 Y116.506 E.00192
G1 X178.709 Y116.512 E.00382
; WIPE_START
G1 X179.194 Y116.506 E-.50546
G1 X179.291 Y116.73 E-.25454
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.88 Y124.352 Z2.9 F30000
G1 X178.51 Y131.21 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S3000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.271 Y135.88 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X178.729 Y136.422 E.01244
G1 X178.729 Y135.858
G1 X179.271 Y135.317 E.01244
G1 X179.271 Y134.753
G1 X178.729 Y135.295 E.01244
G1 X178.729 Y134.731
G1 X179.271 Y134.19 E.01244
G1 X179.271 Y133.626
G1 X178.729 Y134.168 E.01244
G1 X178.729 Y133.604
G1 X179.271 Y133.062 E.01244
G1 X179.271 Y132.499
G1 X178.729 Y133.04 E.01244
G1 X178.729 Y132.477
G1 X179.271 Y131.935 E.01244
G1 X179.213 Y131.429
G1 X178.729 Y131.913 E.01111
; WIPE_START
M204 S3000
G1 X179.213 Y131.429 E-.2601
G1 X179.271 Y131.935 E-.19351
G1 X178.729 Y132.477 E-.29107
G1 X178.729 Y132.517 E-.01531
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X172.375 Y136.746 Z2.9 F30000
G1 X162.21 Y143.51 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
M73 P99 R0
G1 F3600
M204 S1500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
; WIPE_START
M204 S3000
G1 X164.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.935 Y144.271 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X167.477 Y143.729 E.01244
G1 X166.913 Y143.729
G1 X166.372 Y144.271 E.01244
G1 X165.808 Y144.271
G1 X166.35 Y143.729 E.01244
G1 X165.786 Y143.729
G1 X165.244 Y144.271 E.01244
G1 X164.681 Y144.271
G1 X165.222 Y143.729 E.01244
G1 X164.659 Y143.729
G1 X164.117 Y144.271 E.01244
G1 X163.554 Y144.271
G1 X164.095 Y143.729 E.01244
G1 X163.532 Y143.729
G1 X162.99 Y144.271 E.01244
G1 X162.429 Y144.268
G1 X162.968 Y143.729 E.01237
; WIPE_START
M204 S3000
G1 X162.429 Y144.268 E-.28954
G1 X162.99 Y144.271 E-.21308
G1 X163.469 Y143.792 E-.25738
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.837 Y143.667 Z2.9 F30000
G1 X146.21 Y143.51 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
; WIPE_START
M204 S3000
G1 X148.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.154 Y144.271 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X151.571 Y143.854 E.00957
G1 X151.132 Y143.729
G1 X150.591 Y144.271 E.01244
G1 X150.027 Y144.271
G1 X150.569 Y143.729 E.01244
G1 X150.005 Y143.729
G1 X149.463 Y144.271 E.01244
G1 X148.9 Y144.271
G1 X149.441 Y143.729 E.01244
G1 X148.878 Y143.729
G1 X148.336 Y144.271 E.01244
G1 X147.773 Y144.271
G1 X148.314 Y143.729 E.01244
G1 X147.751 Y143.729
G1 X147.209 Y144.271 E.01244
G1 X146.645 Y144.271
G1 X147.187 Y143.729 E.01244
M204 S10000
G1 X146.465 Y143.709 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.13289
G1 F3600
M204 S3000
G1 X146.465 Y144.291 E.00264
; WIPE_START
G1 X146.465 Y143.709 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.833 Y143.671 Z2.9 F30000
G1 X106.21 Y143.51 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
; WIPE_START
M204 S3000
G1 X108.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.138 Y144.271 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X111.571 Y143.838 E.00994
G1 X111.116 Y143.729
G1 X110.574 Y144.271 E.01244
G1 X110.011 Y144.271
G1 X110.553 Y143.729 E.01244
G1 X109.989 Y143.729
G1 X109.447 Y144.271 E.01244
G1 X108.884 Y144.271
G1 X109.425 Y143.729 E.01244
G1 X108.862 Y143.729
G1 X108.32 Y144.271 E.01244
G1 X107.756 Y144.271
G1 X108.298 Y143.729 E.01244
G1 X107.735 Y143.729
G1 X107.193 Y144.271 E.01244
G1 X106.629 Y144.271
G1 X107.171 Y143.729 E.01244
M204 S10000
G1 X106.456 Y143.709 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.114072
G1 F3600
M204 S3000
G1 X106.456 Y144.291 E.00219
; WIPE_START
G1 X106.456 Y143.709 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.824 Y143.616 Z2.9 F30000
G1 X90.21 Y143.51 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
; WIPE_START
M204 S3000
G1 X92.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.794 Y144.271 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X95.335 Y143.729 E.01244
G1 X94.772 Y143.729
G1 X94.23 Y144.271 E.01244
G1 X93.666 Y144.271
G1 X94.208 Y143.729 E.01244
G1 X93.644 Y143.729
G1 X93.103 Y144.271 E.01244
G1 X92.539 Y144.271
G1 X93.081 Y143.729 E.01244
G1 X92.517 Y143.729
G1 X91.975 Y144.271 E.01244
G1 X91.412 Y144.271
G1 X91.954 Y143.729 E.01244
G1 X91.39 Y143.729
G1 X90.848 Y144.271 E.01244
G1 X90.429 Y144.126
G1 X90.826 Y143.729 E.00912
; WIPE_START
M204 S3000
G1 X90.429 Y144.126 E-.21343
G1 X90.848 Y144.271 E-.16846
G1 X91.39 Y143.729 E-.29109
G1 X91.619 Y143.729 E-.08703
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.524 Y144.291 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.158551
G1 F3600
M204 S3000
G1 X95.524 Y143.823 E.00261
G1 X95.477 Y143.709 E.00069
; WIPE_START
G1 X95.524 Y143.823 E-.15793
G1 X95.524 Y144.291 E-.60207
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.345 Y139.809 Z2.9 F30000
G1 X77.49 Y131.21 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
; WIPE_START
M204 S3000
G1 X77.49 Y131.7 E-.18759
G1 X77.49 Y133.206 E-.57241
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.271 Y135.868 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X76.729 Y136.409 E.01244
G1 X76.729 Y135.846
G1 X77.271 Y135.304 E.01244
G1 X77.271 Y134.74
G1 X76.729 Y135.282 E.01244
G1 X76.729 Y134.718
G1 X77.271 Y134.177 E.01244
G1 X77.271 Y133.613
G1 X76.729 Y134.155 E.01244
G1 X76.729 Y133.591
G1 X77.271 Y133.05 E.01244
G1 X77.271 Y132.486
G1 X76.729 Y133.028 E.01244
G1 X76.729 Y132.464
G1 X77.271 Y131.922 E.01244
G1 X77.2 Y131.429
G1 X76.729 Y131.9 E.01082
; WIPE_START
M204 S3000
G1 X77.2 Y131.429 E-.25325
G1 X77.271 Y131.922 E-.18932
G1 X76.729 Y132.464 E-.29108
G1 X76.729 Y132.533 E-.02635
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.085 Y124.909 Z2.9 F30000
G1 X77.49 Y116.21 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
; WIPE_START
M204 S3000
G1 X77.49 Y116.7 E-.18759
G1 X77.49 Y118.206 E-.57241
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.729 Y121.192 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X77.271 Y120.65 E.01244
G1 X77.271 Y120.087
G1 X76.729 Y120.628 E.01244
G1 X76.729 Y120.065
G1 X77.271 Y119.523 E.01244
G1 X77.271 Y118.959
G1 X76.729 Y119.501 E.01244
G1 X76.729 Y118.937
G1 X77.271 Y118.396 E.01244
G1 X77.271 Y117.832
G1 X76.729 Y118.374 E.01244
G1 X76.729 Y117.81
G1 X77.271 Y117.269 E.01244
G1 X77.271 Y116.705
G1 X76.729 Y117.247 E.01244
; WIPE_START
M204 S3000
G1 X77.271 Y116.705 E-.29108
G1 X77.271 Y117.269 E-.21417
G1 X76.797 Y117.743 E-.25475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.291 Y121.393 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.303207
G1 F3600
M204 S3000
G1 X76.84 Y121.46 E.00523
; LINE_WIDTH: 0.264639
G1 X76.775 Y121.352 E.00125
; LINE_WIDTH: 0.228196
G1 X76.709 Y121.243 E.00107
; WIPE_START
G1 X76.775 Y121.352 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.291 Y116.54 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.203147
G1 F3600
M204 S3000
G1 X77.194 Y116.5 E.00078
G1 X76.709 Y116.5 E.00359
; WIPE_START
G1 X77.194 Y116.5 E-.62499
G1 X77.291 Y116.54 E-.13501
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.769 Y112.504 Z2.9 F30000
G1 X90.21 Y108.49 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
; WIPE_START
M204 S3000
G1 X90.21 Y107.51 E-.3731
G1 X91.228 Y107.51 E-.3869
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.264 Y107.729 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X94.723 Y108.271 E.01244
G1 X94.159 Y108.271
G1 X94.701 Y107.729 E.01244
G1 X94.137 Y107.729
G1 X93.596 Y108.271 E.01244
G1 X93.032 Y108.271
G1 X93.574 Y107.729 E.01244
G1 X93.01 Y107.729
G1 X92.468 Y108.271 E.01244
G1 X91.905 Y108.271
G1 X92.446 Y107.729 E.01244
G1 X91.883 Y107.729
G1 X91.341 Y108.271 E.01244
G1 X90.777 Y108.271
G1 X91.319 Y107.729 E.01244
M204 S10000
G1 X90.579 Y107.709 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.272324
G1 F3600
M204 S3000
G1 X90.527 Y108.173 E.00477
; LINE_WIDTH: 0.23345
G1 X90.742 Y108.291 E.00212
; WIPE_START
G1 X90.527 Y108.173 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.466 Y108.291 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.227293
G1 F3600
M204 S3000
G1 X95.489 Y107.811 E.00403
G1 X95.27 Y107.709 E.00203
; WIPE_START
G1 X95.489 Y107.811 E-.25438
G1 X95.466 Y108.291 E-.50562
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.097 Y108.432 Z2.9 F30000
G1 X106.21 Y108.49 Z2.9
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
; WIPE_START
M204 S3000
G1 X106.21 Y107.51 E-.3731
G1 X107.228 Y107.51 E-.3869
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.067 Y108.271 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X111.571 Y107.767 E.01156
G1 X111.045 Y107.729
G1 X110.504 Y108.271 E.01244
G1 X109.94 Y108.271
G1 X110.482 Y107.729 E.01244
G1 X109.918 Y107.729
G1 X109.376 Y108.271 E.01244
G1 X108.813 Y108.271
G1 X109.355 Y107.729 E.01244
G1 X108.791 Y107.729
G1 X108.249 Y108.271 E.01244
G1 X107.686 Y108.271
G1 X108.227 Y107.729 E.01244
G1 X107.664 Y107.729
G1 X107.122 Y108.271 E.01244
G1 X106.558 Y108.271
G1 X107.1 Y107.729 E.01244
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F2700
M204 S3000
G1 X106.558 Y108.271 E-.29108
G1 X107.122 Y108.271 E-.21417
G1 X107.596 Y107.797 E-.25476
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.9 I1.217 J0 P1  F30000
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
G1 Z3 F900 ; lower z a little
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

    G1 Z102.5 F600
    G1 Z100.5

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

