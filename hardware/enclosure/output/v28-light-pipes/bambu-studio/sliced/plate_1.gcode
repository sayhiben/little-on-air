; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 13m 24s; total estimated time: 28m 40s
; total layer number: 28
; total filament length [mm] : 321.64
; total filament volume [cm^3] : 773.64
; total filament weight [g] : 0.98
; model label id: 1,2,3,4,5,6,7,8,9
; object max height: 2.80,2.80,2.80,2.80,2.80,2.80,2.80,2.80,2.80
; filament_density: 1.27
; filament_diameter: 1.75
; max_z_height: 2.80
; filament: 1
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
; additional_fan_full_speed_layer = 0
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
; bottom_shell_layers = 1
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = alignedrectilinear
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 25
; brim_object_gap = 0.15
; brim_type = no_brim
; brim_width = 3
; chamber_temperatures = 0
; change_filament_gcode = ;=X1 20251031=\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == \"PETG\"}\nM109 S260\n{elsif filament_type[next_extruder] == \"PVA\"}\nM109 S210\n{else}\nM109 S{flush_temperatures[next_extruder]}\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_additional_fan_first_x_layers = 3
; close_fan_the_first_x_layers = 3
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 0
; cool_plate_temp_initial_layer = 0
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10
; cooling_slowdown_logic = uniform_cooling
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; counterbore_hole_bridging = none
; curr_bed_type = Textured PEI Plate
; default_acceleration = 1000
; default_ams_type = -1
; default_filament_colour = ;
; default_filament_profile = "Bambu PLA Basic @BBL X1C"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 0
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50
; different_settings_to_system = bottom_shell_layers;bottom_shell_thickness;bottom_surface_pattern;brim_type;default_acceleration;detect_narrow_internal_solid_infill;elefant_foot_compensation;enable_prime_tower;enable_support;gap_infill_speed;infill_combination;infill_direction;infill_rotate_step;initial_layer_infill_speed;initial_layer_print_height;initial_layer_speed;inner_wall_speed;internal_solid_infill_pattern;internal_solid_infill_speed;ironing_type;layer_height;outer_wall_acceleration;outer_wall_speed;reduce_crossing_wall;scan_first_layer;sparse_infill_density;sparse_infill_pattern;sparse_infill_speed;top_shell_layers;top_shell_thickness;top_surface_pattern;top_surface_speed;wall_generator;wall_loops;;scan_first_layer
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.1
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
; enable_prime_tower = 0
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 70
; eng_plate_temp_initial_layer = 70
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
; fan_cooling_layer_time = 30
; fan_direction = left
; fan_max_speed = 30
; fan_min_speed = 10
; farthest_point_timelapse = 1
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 300
; filament_bridge_speed = 25
; filament_change_length = 10
; filament_change_length_nc = 10
; filament_colour = #D8EDF0
; filament_colour_type = 0
; filament_cooling_before_tower = 0
; filament_cost = 30
; filament_density = 1.27
; filament_dev_ams_drying_ams_limitations = 1
; filament_dev_ams_drying_heat_distortion_temperature = 75
; filament_dev_ams_drying_temperature = 65
; filament_dev_ams_drying_time = 12
; filament_dev_chamber_drying_bed_temperature = 80
; filament_dev_chamber_drying_time = 12
; filament_dev_drying_cooling_temperature = 55
; filament_dev_drying_softening_temperature = 60
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.95
; filament_flush_temp = 0
; filament_flush_temp_fast = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFG99
; filament_is_mixed = 0
; filament_is_support = 0
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 4
; filament_metal_stickiness = High
; filament_minimal_purge_on_wipe_tower = 15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_multi_colour = #D8EDF0
; filament_notes = Generic PETG thermal baseline 255 C / 70 C textured PEI. Low fan and 20 mm/s optical process. Dry and flow-calibrate the actual clear spool; confirm its specified temperature range.
; filament_nozzle_map = 0
; filament_overhang_1_4_speed = 0
; filament_overhang_2_4_speed = 50
; filament_overhang_3_4_speed = 30
; filament_overhang_4_4_speed = 10
; filament_overhang_totally_speed = 10
; filament_pre_cooling_temperature = 0
; filament_pre_cooling_temperature_nc = 0
; filament_preheat_temperature_delta = 0
; filament_prime_volume = 45
; filament_prime_volume_nc = 60
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_travel_time_nc = 0
; filament_ramming_volumetric_speed = -1
; filament_ramming_volumetric_speed_nc = -1
; filament_retract_length_nc = 14
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "ON AIR clear PETG - calibrate actual spool"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = PETG
; filament_velocity_adaptation_factor = 1
; filament_vendor = Generic
; filament_volume_map = 0
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
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 20
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; host_type = octoprint
; hot_plate_temp = 70
; hot_plate_temp_initial_layer = 70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 0
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = "0.20mm Standard @BBL X1C";;
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
; inner_wall_speed = 20
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = alignedrectilinear
; internal_solid_infill_speed = 20
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
; layer_height = 0.1
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
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
; no_slow_down_for_cooling_on_outwalls = 0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 255
; nozzle_temperature_initial_layer = 255
; nozzle_temperature_range_high = 270
; nozzle_temperature_range_low = 220
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
; outer_wall_speed = 20
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 30
; overhang_fan_threshold = 10%
; overhang_threshold_participating_cooling = 95%,95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
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
; print_settings_id = ON AIR indicator guides - 0.10 mm aligned lengthwise
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
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
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
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 12
; slow_down_min_speed = 20
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
; sparse_infill_density = 100%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = alignedrectilinear
; sparse_infill_speed = 20
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 70
; supertack_plate_temp_initial_layer = 70
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
; temperature_vitrification = 70
; template_custom_gcode = 
; textured_plate_temp = 70
; textured_plate_temp_initial_layer = 70
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;========Date 20250206========\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\nM1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C10 O0\nG92 E0\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; SKIPPABLE_END\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 1
; top_shell_thickness = 0
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = alignedrectilinear
; top_surface_speed = 20
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
; volumetric_speed_coefficients = "0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 1
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 22
; wipe_tower_y = 185
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
M73 P0 R28
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
M140 S70 ;set bed temp
M190 S70 ;wait for bed temp



;=============turn on fans to prevent PLA jamming=================

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S255 ;set extruder temp
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
    M109 S255
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F99.7797 T270

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
M73 P2 R28
G1 E50 F200
M400
M104 S255
G92 E0
M73 P17 R23
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S235 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P18 R23
G1 E-0.5 F300

G1 X70 F9000
M73 P19 R23
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
M109 S235
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
    G29 A X98.85 Y109.9 I48.3 J32.1993
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

M106 P2 S100 ; turn on big fan ,to cool down toolhead

M104 S255 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

M73 P19 R22
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
M109 S255
G1 Z0.2
G0 E2 F300
G0 X240 E15 F318.832
G0 Y11 E0.700 F79.708
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X231 E0.700 F318.832
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

    G0 X48.0 E11.9 F318.832
    G0 X48.0 Y12 E0.772 F1200.0
    G0 X45.0 E0.22 F1200.0
    G0 X35.0 Y6.0 E0.86 F1200.0

    ;=========== extruder cali extrusion ==================
    T1000
    M83
    
        
            M204 S500
        
    
    G0 X35.000 Y6.000 Z0.300 F30000 E0
M73 P20 R22
    G1 F1500.000 E0.800
    M106 S0 ; turn off fan
    G0 X185.000 E9.35441 F318.832
    G0 X187 Z0
    G1 F1500.000 E-0.800
    G0 Z1
    G0 X180 Z0.3 F18000

    M900 L1000.0 M1.0
    M900 K0.040
    G0 X45.000 F30000
    G0 Y8.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F79.708
    G1 X70.000 E0.31181 F79.708
    G1 X75.000 E0.31181 F318.832
    G1 X80.000 E0.31181 F79.708
    G1 X85.000 E0.31181 F318.832
    G1 X90.000 E0.31181 F79.708
    G1 X95.000 E0.31181 F318.832
    G1 X100.000 E0.31181 F79.708
    G1 X105.000 E0.31181 F318.832
    G1 X110.000 E0.31181 F79.708
    G1 X115.000 E0.31181 F318.832
    G1 X120.000 E0.31181 F79.708
    G1 X125.000 E0.31181 F318.832
    G1 X130.000 E0.31181 F79.708
    G1 X135.000 E0.31181 F318.832
    G1 X140.000 E0.31181 F79.708
    G1 X145.000 E0.31181 F318.832
M73 P21 R22
    G1 X150.000 E0.31181 F79.708
    G1 X155.000 E0.31181 F318.832
    G1 X160.000 E0.31181 F79.708
    G1 X165.000 E0.31181 F318.832
    G1 X170.000 E0.31181 F79.708
    G1 X175.000 E0.31181 F318.832
    G1 X180.000 E0.31181 F318.832
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
    G1 X65.000 E1.24726 F79.708
    G1 X70.000 E0.31181 F79.708
    G1 X75.000 E0.31181 F318.832
    G1 X80.000 E0.31181 F79.708
    G1 X85.000 E0.31181 F318.832
    G1 X90.000 E0.31181 F79.708
    G1 X95.000 E0.31181 F318.832
    G1 X100.000 E0.31181 F79.708
    G1 X105.000 E0.31181 F318.832
    G1 X110.000 E0.31181 F79.708
    G1 X115.000 E0.31181 F318.832
    G1 X120.000 E0.31181 F79.708
    G1 X125.000 E0.31181 F318.832
M73 P23 R21
    G1 X130.000 E0.31181 F79.708
M73 P24 R21
    G1 X135.000 E0.31181 F318.832
    G1 X140.000 E0.31181 F79.708
    G1 X145.000 E0.31181 F318.832
    G1 X150.000 E0.31181 F79.708
    G1 X155.000 E0.31181 F318.832
    G1 X160.000 E0.31181 F79.708
M73 P25 R21
    G1 X165.000 E0.31181 F318.832
    G1 X170.000 E0.31181 F79.708
    G1 X175.000 E0.31181 F318.832
    G1 X180.000 E0.31181 F318.832
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
M73 P26 R20
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
    G1 X65.000 E1.24726 F79.708
    G1 X70.000 E0.31181 F79.708
M73 P28 R20
    G1 X75.000 E0.31181 F318.832
    G1 X80.000 E0.31181 F79.708
    G1 X85.000 E0.31181 F318.832
    G1 X90.000 E0.31181 F79.708
    G1 X95.000 E0.31181 F318.832
    G1 X100.000 E0.31181 F79.708
    G1 X105.000 E0.31181 F318.832
    G1 X110.000 E0.31181 F79.708
M73 P29 R20
    G1 X115.000 E0.31181 F318.832
    G1 X120.000 E0.31181 F79.708
    G1 X125.000 E0.31181 F318.832
M73 P30 R20
    G1 X130.000 E0.31181 F79.708
    G1 X135.000 E0.31181 F318.832
M73 P30 R19
    G1 X140.000 E0.31181 F79.708
    G1 X145.000 E0.31181 F318.832
    G1 X150.000 E0.31181 F79.708
    G1 X155.000 E0.31181 F318.832
    G1 X160.000 E0.31181 F79.708
    G1 X165.000 E0.31181 F318.832
M73 P31 R19
    G1 X170.000 E0.31181 F79.708
    G1 X175.000 E0.31181 F318.832
    G1 X180.000 E0.31181 F318.832
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
M73 P32 R19
    G1 Z0.3

    G0 X45.000 F30000 ; move to start point

M623 ; end of "draw extrinsic para cali paint"


M1002 judge_flag extrude_cali_flag
M622 J0
    G0 X231 Y1.5 F30000
    G0 X18 E14.3 F318.832
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

    M104 S255 ; rise nozzle temp now ,to reduce temp waiting time.

    T1100
    M400 P400
    M960 S0 P0
    G0 F30000.000 Y10.000 X65.000 Z0.000
    M400 P400
    M960 S1 P1
    M400 P50

    M969 S1 N3 A2000
    G0 F360.000 X181.000 Z0.000
    M980.3 A70.000 B4.97333 C5.000 D19.8933 E5.000 F175.000 H1.000 I0.000 J0.020 K0.040
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
    M109 S255
    G0 Z0.3
    G1 F1500.000 E3.600
    G1 X65.000 E1.24726 F79.708
    G1 X70.000 E0.31181 F79.708
    G1 X75.000 E0.31181 F318.832
    G1 X80.000 E0.31181 F79.708
    G1 X85.000 E0.31181 F318.832
    G1 X90.000 E0.31181 F79.708
    G1 X95.000 E0.31181 F318.832
    G1 X100.000 E0.31181 F79.708
    G1 X105.000 E0.31181 F318.832
M73 P33 R19
    G1 X110.000 E0.31181 F79.708
M73 P33 R18
    G1 X115.000 E0.31181 F318.832
    G1 X120.000 E0.31181 F79.708
M73 P34 R18
    G1 X125.000 E0.31181 F318.832
    G1 X130.000 E0.31181 F79.708
    G1 X135.000 E0.31181 F318.832

    ; see if extrude cali success, if not ,use default value
    M1002 judge_last_extrude_cali_success
    M622 J0
        M400
        M900 K0.02 M0.00663111
    M623

    G1 X140.000 E0.31181 F79.708
    G1 X145.000 E0.31181 F318.832
    G1 X150.000 E0.31181 F79.708
    G1 X155.000 E0.31181 F318.832
    G1 X160.000 E0.31181 F79.708
M73 P35 R18
    G1 X165.000 E0.31181 F318.832
    G1 X170.000 E0.31181 F79.708
    G1 X175.000 E0.31181 F318.832
    G1 X180.000 E0.31181 F79.708
    G1 X185.000 E0.31181 F318.832
    G1 X190.000 E0.31181 F79.708
M73 P36 R18
    G1 X195.000 E0.31181 F318.832
    G1 X200.000 E0.31181 F79.708
    G1 X205.000 E0.31181 F318.832
    G1 X210.000 E0.31181 F79.708
    G1 X215.000 E0.31181 F318.832
    G1 X220.000 E0.31181 F79.708
    G1 X225.000 E0.31181 F318.832
    M973 S4

M623

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M973 S4 ; turn off scanner
M400 ; wait all motion done before implement the emprical L parameters
;M900 L500.0 ; Empirical parameters
M109 S255
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
M109 S255
G1 Z0.2
G0 X239 E15 F318.832
G0 Y12 E0.7 F79.708
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S180


;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.1
; LAYER_HEIGHT: 0.1
G1 E-.8 F1800
; layer num/total_layer_count: 1/28
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
G1 X130.6 Y109.176 F30000
M204 S6000
G1 Z.4
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
M73 P37 R17
G1 X132.8 Y109.176 E.04158
G1 X132.8 Y111.124 E.03681
G1 X130.6 Y111.124 E.04158
M73 P38 R17
G1 X130.6 Y111.6 E.009
G1 X130.1 Y111.6 E.00945
G1 X130.1 Y111.124 E.009
G1 X127.2 Y111.124 E.05481
G1 X127.2 Y109.176 E.03681
G1 X130.1 Y109.176 E.05481
G1 X130.1 Y108.503 E.01271
M73 P39 R17
G1 X130.6 Y108.503 E.00945
G1 X130.6 Y109.116 E.01158
G1 E-.8 F1800
M204 S6000
G1 X132.609 Y109.612 Z.5 F30000
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.55901
G1 F900
M204 S500
M73 P40 R17
G1 X127.607 Y109.612 E.1062
G1 X127.607 Y110.15 E.01141
G1 X132.393 Y110.15 E.10162
G1 X132.393 Y110.688 E.01141
G1 X127.391 Y110.688 E.1062
; OBJECT_ID: 5
; WIPE_START
G1 X129.391 Y110.688 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S6000
G1 X129.391 Y110.756 Z.5 F30000
G1 X130.516 Y123.145
G1 X130.6 Y123.121
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
M73 P40 R16
G1 X132.8 Y123.121 E.04158
G1 X132.8 Y125.179 E.03891
M73 P43 R16
G1 X130.6 Y125.179 E.04158
G1 X130.6 Y125.6 E.00795
G1 X130.1 Y125.6 E.00945
G1 X130.1 Y125.179 E.00795
G1 X127.2 Y125.179 E.05481
G1 X127.2 Y123.121 E.03891
G1 X130.1 Y123.121 E.05481
G1 X130.1 Y122.503 E.01167
G1 X130.6 Y122.503 E.00945
G1 X130.6 Y123.061 E.01053
G1 E-.8 F1800
M204 S6000
G1 X132.609 Y123.575 Z.5 F30000
G1 Z.1
M73 P44 R15
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5957
G1 F900
M204 S500
G1 X127.607 Y123.575 E.11344
M73 P45 R15
G1 X127.607 Y124.15 E.01302
G1 X132.393 Y124.15 E.10856
G1 X132.393 Y124.724 E.01302
G1 X127.391 Y124.724 E.11344
; OBJECT_ID: 6
; WIPE_START
G1 X129.391 Y124.724 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S6000
M73 P46 R15
G1 X129.391 Y124.811 Z.5 F30000
G1 X132.432 Y124.403
G1 X144.178 Y123.165
G1 X144.438 Y122.871
G1 X144.516 Y123.145
G1 X144.6 Y123.121
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
M73 P47 R15
G1 F900
M204 S500
G1 X146.8 Y123.121 E.04158
G1 X146.8 Y125.179 E.03891
G1 X144.6 Y125.179 E.04158
M73 P47 R14
G1 X144.6 Y125.6 E.00795
G1 X144.1 Y125.6 E.00945
M73 P48 R14
G1 X144.1 Y125.179 E.00795
G1 X141.2 Y125.179 E.05481
G1 X141.2 Y123.121 E.03891
G1 X144.1 Y123.121 E.05481
G1 X144.1 Y122.503 E.01167
G1 X144.6 Y122.503 E.00945
G1 X144.6 Y123.061 E.01053
G1 E-.8 F1800
M204 S6000
M73 P49 R14
G1 X146.609 Y123.575 Z.5 F30000
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5957
G1 F900
M204 S500
G1 X141.607 Y123.575 E.11344
G1 X141.607 Y124.15 E.01302
G1 X146.393 Y124.15 E.10856
M73 P50 R14
G1 X146.393 Y124.724 E.01302
G1 X141.391 Y124.724 E.11344
; OBJECT_ID: 3
; WIPE_START
G1 X143.391 Y124.724 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S6000
G1 X143.391 Y124.811 Z.5 F30000
G1 X143.49 Y123.451
G1 X144.477 Y110.756
M73 P52 R13
G1 X144.529 Y109.247
M73 P53 R13
G1 X144.516 Y109.199
G1 X144.6 Y109.176
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X146.8 Y109.176 E.04158
G1 X146.8 Y111.124 E.03681
G1 X144.6 Y111.124 E.04158
G1 X144.6 Y111.6 E.009
G1 X144.1 Y111.6 E.00945
G1 X144.1 Y111.124 E.009
G1 X141.2 Y111.124 E.05481
G1 X141.2 Y109.176 E.03681
G1 X144.1 Y109.176 E.05481
G1 X144.1 Y108.503 E.01271
G1 X144.6 Y108.503 E.00945
G1 X144.6 Y109.116 E.01158
G1 E-.8 F1800
M204 S6000
G1 X146.609 Y109.612 Z.5 F30000
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.55901
G1 F900
M204 S500
G1 X141.607 Y109.612 E.1062
G1 X141.607 Y110.15 E.01141
G1 X146.393 Y110.15 E.10162
G1 X146.393 Y110.688 E.01141
G1 X141.391 Y110.688 E.1062
; OBJECT_ID: 9
; WIPE_START
G1 X143.391 Y110.688 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S6000
G1 X143.391 Y110.756 Z.5 F30000
G1 X143.968 Y123.269
G1 X144.039 Y124.811
G1 X144.516 Y137.091
G1 X144.6 Y137.066
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X146.8 Y137.066 E.04158
G1 X146.8 Y139.234 E.04099
; object ids of layer 1 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer1 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.6 Y139.234 E.04158
G1 X144.6 Y139.6 E.00691
G1 X144.1 Y139.6 E.00945
G1 X144.1 Y139.234 E.00691
G1 X141.2 Y139.234 E.05481
G1 X141.2 Y137.066 E.04099
G1 X144.1 Y137.066 E.05481
G1 X144.1 Y136.503 E.01063
G1 X144.6 Y136.503 E.00945
G1 X144.6 Y137.006 E.00949
G1 E-.8 F1800
M204 S6000
G1 X146.609 Y137.52 Z.5 F30000
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5957
G1 F900
M204 S500
G1 X141.607 Y137.52 E.11344
G1 X141.607 Y138.095 E.01302
G1 X146.393 Y138.095 E.10856
G1 X146.393 Y138.669 E.01302
G1 X141.391 Y138.669 E.11344
; OBJECT_ID: 8
; WIPE_START
G1 X143.391 Y138.669 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S6000
G1 X143.391 Y138.866 Z.5 F30000
G1 X141.568 Y138.44
G1 X130.516 Y137.091
G1 X130.6 Y137.066
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X132.8 Y137.066 E.04158
G1 X132.8 Y139.234 E.04099
G1 X130.6 Y139.234 E.04158
G1 X130.6 Y139.6 E.00691
G1 X130.1 Y139.6 E.00945
G1 X130.1 Y139.234 E.00691
G1 X127.2 Y139.234 E.05481
G1 X127.2 Y137.066 E.04099
G1 X130.1 Y137.066 E.05481
G1 X130.1 Y136.503 E.01063
G1 X130.6 Y136.503 E.00945
G1 X130.6 Y137.006 E.00949
G1 E-.8 F1800
M204 S6000
G1 X132.609 Y137.52 Z.5 F30000
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5957
G1 F900
M204 S500
G1 X127.607 Y137.52 E.11344
G1 X127.607 Y138.095 E.01302
G1 X132.393 Y138.095 E.10856
G1 X132.393 Y138.669 E.01302
G1 X127.391 Y138.669 E.11344
; OBJECT_ID: 7
; WIPE_START
G1 X129.391 Y138.669 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S6000
G1 X129.391 Y138.866 Z.5 F30000
G1 X127.568 Y138.557
G1 X116.432 Y137.877
G1 X116.375 Y137.821
G1 X114 Y137.821
G1 X114 Y137.728
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X116.8 Y137.728 E.05292
G1 X116.8 Y138.272 E.01029
G1 X114 Y138.272 E.05292
G1 X114 Y139.084 E.01534
G1 X101.609 Y139.084 E.23419
G2 X99.45 Y139.209 I-.444 J11.047 E.04095
G1 X99.335 Y139.656 E.00872
G2 X99.124 Y139.661 I-.073 J1.225 E.00399
G3 X99.166 Y138.521 I3.828 J-.431 E.02164
G2 X99.1 Y136.985 I-6.525 J-.49 E.02912
G3 X99.124 Y136.339 I2.432 J-.233 E.01227
G1 X99.245 Y136.346 E.00229
G1 X99.335 Y136.344 E.00171
G1 X99.45 Y136.791 E.00872
G2 X101.609 Y136.916 I1.716 J-10.922 E.04095
G1 X114 Y136.916 E.23419
G1 X114 Y137.668 E.0142
M204 S6000
G1 X113.809 Y137.734 F30000
; FEATURE: Bottom surface
; LINE_WIDTH: 0.55401
G1 F900
M204 S500
G1 X99.584 Y137.734 E.29919
G3 X99.584 Y138.266 I-2.919 J.266 E.01122
G1 X113.809 Y138.266 E.29919
M204 S6000
G1 X113.761 Y138 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0871402
G1 F900
M204 S500
G1 X116.561 Y138 E.00726
; OBJECT_ID: 4
; WIPE_START
G1 X114.561 Y138 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S6000
G1 X114.561 Y137.821 Z.5 F30000
G1 X114.018 Y124.179
G1 X116.375 Y123.821
G1 X114 Y123.821
G1 X114 Y123.728
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X116.8 Y123.728 E.05292
G1 X116.8 Y124.272 E.01029
G1 X114 Y124.272 E.05292
G1 X114 Y125.028 E.0143
G1 X101.609 Y125.028 E.23419
G2 X99.445 Y125.154 I-.444 J11.058 E.04104
G1 X99.331 Y125.654 E.0097
G2 X99.124 Y125.661 I-.063 J1.283 E.00391
G3 X99.166 Y124.521 I3.827 J-.431 E.02163
G2 X99.1 Y122.985 I-6.525 J-.49 E.02912
G3 X99.124 Y122.339 I2.428 J-.233 E.01226
G1 X99.244 Y122.347 E.00227
G1 X99.331 Y122.346 E.00164
G1 X99.445 Y122.846 E.0097
G2 X101.609 Y122.971 I1.72 J-10.933 E.04104
G1 X114 Y122.971 E.23419
G1 X114 Y123.668 E.01316
M204 S6000
M73 P54 R13
G1 X113.809 Y123.748 F30000
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52595
G1 F900
M204 S500
G1 X99.585 Y123.748 E.28341
G3 X99.585 Y124.252 I-2.765 J.252 E.01007
G1 X113.809 Y124.252 E.28341
M204 S6000
G1 X113.761 Y124 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0871402
G1 F900
M204 S500
G1 X116.561 Y124 E.00726
; OBJECT_ID: 1
; WIPE_START
G1 X114.561 Y124 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S6000
G1 X114.561 Y123.821 Z.5 F30000
G1 X114.018 Y110.179
G1 X116.375 Y109.821
G1 X114 Y109.821
G1 X114 Y109.728
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X116.8 Y109.728 E.05292
G1 X116.8 Y110.272 E.01029
G1 X114 Y110.272 E.05292
G1 X114 Y110.973 E.01325
G1 X101.119 Y110.973 E.24346
G2 X99.441 Y111.099 I-.127 J9.548 E.03184
G1 X99.33 Y111.653 E.01068
G2 X99.124 Y111.66 I-.057 J1.358 E.0039
G3 X99.159 Y110.52 I4.081 J-.445 E.02164
G2 X99.1 Y108.987 I-7.037 J-.495 E.02904
G3 X99.124 Y108.34 I2.432 J-.234 E.01228
G1 X99.243 Y108.348 E.00225
G1 X99.33 Y108.347 E.00165
G1 X99.441 Y108.901 E.01068
G2 X101.609 Y109.027 I1.725 J-10.942 E.04112
G1 X114 Y109.027 E.23419
G1 X114 Y109.668 E.01211
M204 S6000
G1 X113.809 Y109.334 F30000
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5957
G1 F900
M204 S500
G1 X99.551 Y109.334 E.32336
G3 X99.586 Y109.909 I-3.829 J.517 E.01306
G1 X113.354 Y109.909 E.31227
G1 X113.354 Y110.45 E.01229
G1 X113.593 Y110.45 E.00542
G1 X113.593 Y110.483 E.00074
G1 X99.352 Y110.483 E.32299
G1 E-.8 F1800
M204 S6000
G1 X106.981 Y110.227 Z.5 F30000
G1 X113.761 Y110 Z.5
G1 Z.1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0871402
G1 F900
M204 S500
G1 X116.561 Y110 E.00726
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F900
G1 X114.561 Y110 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 2/28
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.5 I1.217 J0 P1  F30000
G1 X114.561 Y109.839 Z.5
G1 X116.507 Y109.879
G1 X130.242 Y109.023
G1 X130.511 Y109.221
G1 X130.667 Y109.263
G1 X130.74 Y108.992
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.781 Y108.992 E.00065
G1 X132.94 Y108.995 E.03398
G1 X132.94 Y111.305 E.03636
G1 X130.781 Y111.308 E.03398
G1 X130.74 Y111.308 E.00065
G1 X130.74 Y111.74 E.0068
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.308 E.0068
G1 X129.919 Y111.308 E.00065
G1 X127.06 Y111.305 E.045
G1 X127.06 Y108.995 E.03636
G1 X129.919 Y108.992 E.045
G1 X129.96 Y108.992 E.00065
G1 X129.96 Y108.333 E.01036
G1 X130.74 Y108.333 E.01228
G1 X130.74 Y108.932 E.00942
M204 S10000
G1 X130.581 Y108.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X130.299 Y108.696 E.00497
G1 X130.299 Y109.143 E.00788
G1 X130.401 Y109.143 E.00181
G1 X130.401 Y109.33 E.00331
G1 X132.601 Y109.33 E.03882
G1 X132.601 Y109.59 E.00458
G1 X127.399 Y109.59 E.09181
G1 X127.399 Y110.037 E.00788
G1 X132.601 Y110.037 E.09181
G1 X132.601 Y110.483 E.00788
G1 X127.399 Y110.483 E.09181
G1 X127.399 Y110.93 E.00788
G1 X132.601 Y110.93 E.09181
G1 X132.601 Y110.969 E.00069
M73 P54 R12
G1 X130.401 Y110.969 E.03882
G1 X130.401 Y111.377 E.00719
G1 X130.119 Y111.377 E.00497
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.377 E-.10711
G1 X130.401 Y110.969 E-.15491
G1 X131.712 Y110.969 E-.49798
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.712 Y110.875 Z.6 F30000
G1 X130.476 Y122.99
G1 X130.74 Y122.938
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.781 Y122.938 E.00065
G1 X132.94 Y122.94 E.03398
G1 X132.94 Y125.36 E.0381
G1 X130.781 Y125.362 E.03398
G1 X130.74 Y125.362 E.00065
G1 X130.74 Y125.74 E.00595
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.362 E.00595
G1 X129.919 Y125.362 E.00065
G1 X127.06 Y125.36 E.045
G1 X127.06 Y122.94 E.0381
G1 X129.919 Y122.938 E.045
G1 X129.96 Y122.938 E.00065
G1 X129.96 Y122.333 E.00952
G1 X130.74 Y122.333 E.01228
G1 X130.74 Y122.878 E.00857
M204 S10000
G1 X130.581 Y122.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X130.299 Y122.696 E.00497
G1 X130.299 Y123.143 E.00788
G1 X130.401 Y123.143 E.00181
G1 X130.401 Y123.277 E.00236
M73 P55 R12
G1 X132.601 Y123.277 E.03882
G1 X132.601 Y123.59 E.00553
G1 X127.399 Y123.59 E.09181
G1 X127.399 Y124.037 E.00788
G1 X132.601 Y124.037 E.09181
G1 X132.601 Y124.483 E.00788
G1 X127.399 Y124.483 E.09181
G1 X127.399 Y124.93 E.00788
G1 X132.601 Y124.93 E.09181
G1 X132.601 Y125.023 E.00164
G1 X130.401 Y125.023 E.03882
G1 X130.401 Y125.377 E.00625
G1 X130.119 Y125.377 E.00497
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.377 E-.10711
G1 X130.401 Y125.023 E-.13448
G1 X131.766 Y125.023 E-.51842
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.766 Y124.929 Z.6 F30000
G1 X132.507 Y124.904
G1 X141.493 Y123.46
G1 X143.429 Y123.371
G1 X144.189 Y123.167
G1 X144.432 Y122.766
G1 X144.476 Y122.989
G1 X144.74 Y122.938
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.781 Y122.938 E.00065
G1 X146.94 Y122.94 E.03398
G1 X146.94 Y125.36 E.0381
G1 X144.781 Y125.362 E.03398
G1 X144.74 Y125.362 E.00065
G1 X144.74 Y125.74 E.00595
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.362 E.00595
G1 X143.919 Y125.362 E.00065
G1 X141.06 Y125.36 E.045
G1 X141.06 Y122.94 E.0381
G1 X143.919 Y122.938 E.045
G1 X143.96 Y122.938 E.00065
G1 X143.96 Y122.333 E.00952
G1 X144.74 Y122.333 E.01228
G1 X144.74 Y122.878 E.00857
M204 S10000
G1 X144.581 Y122.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X144.299 Y122.696 E.00497
G1 X144.299 Y123.143 E.00788
G1 X144.401 Y123.143 E.00181
G1 X144.401 Y123.277 E.00236
G1 X146.601 Y123.277 E.03882
G1 X146.601 Y123.59 E.00553
G1 X141.399 Y123.59 E.09181
G1 X141.399 Y124.037 E.00788
G1 X146.601 Y124.037 E.09181
G1 X146.601 Y124.483 E.00788
G1 X141.399 Y124.483 E.09181
G1 X141.399 Y124.93 E.00788
G1 X146.601 Y124.93 E.09181
G1 X146.601 Y125.023 E.00164
G1 X144.401 Y125.023 E.03882
G1 X144.401 Y125.377 E.00625
G1 X144.119 Y125.377 E.00497
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.377 E-.10711
G1 X144.401 Y125.023 E-.13448
G1 X145.766 Y125.023 E-.51842
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.766 Y124.929 Z.6 F30000
G1 X145.66 Y123.371
G1 X144.86 Y110.875
G1 X145.271 Y109.425
G1 X144.667 Y109.263
G1 X144.74 Y108.992
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.781 Y108.992 E.00065
G1 X146.94 Y108.995 E.03398
G1 X146.94 Y111.305 E.03636
G1 X144.781 Y111.308 E.03398
G1 X144.74 Y111.308 E.00065
G1 X144.74 Y111.74 E.0068
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.308 E.0068
G1 X143.919 Y111.308 E.00065
G1 X141.06 Y111.305 E.045
G1 X141.06 Y108.995 E.03636
G1 X143.919 Y108.992 E.045
G1 X143.96 Y108.992 E.00065
G1 X143.96 Y108.333 E.01036
G1 X144.74 Y108.333 E.01228
G1 X144.74 Y108.932 E.00942
M204 S10000
G1 X144.581 Y108.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X144.299 Y108.696 E.00497
G1 X144.299 Y109.143 E.00788
G1 X144.401 Y109.143 E.00181
G1 X144.401 Y109.33 E.00331
G1 X146.601 Y109.33 E.03882
G1 X146.601 Y109.59 E.00458
G1 X141.399 Y109.59 E.09181
G1 X141.399 Y110.037 E.00788
G1 X146.601 Y110.037 E.09181
G1 X146.601 Y110.483 E.00788
G1 X141.399 Y110.483 E.09181
G1 X141.399 Y110.93 E.00788
G1 X146.601 Y110.93 E.09181
G1 X146.601 Y110.969 E.00069
G1 X144.401 Y110.969 E.03882
G1 X144.401 Y111.377 E.00719
G1 X144.119 Y111.377 E.00497
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.377 E-.10711
G1 X144.401 Y110.969 E-.15491
G1 X145.712 Y110.969 E-.49798
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.712 Y110.875 Z.6 F30000
G1 X145.247 Y123.364
G1 X145.188 Y124.929
G1 X144.475 Y136.939
G1 X144.74 Y136.884
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.781 Y136.884 E.00065
G1 X146.94 Y136.885 E.03398
G1 X146.94 Y139.415 E.03983
; object ids of layer 2 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer2 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.781 Y139.415 E.03398
G1 X144.74 Y139.415 E.00065
G1 X144.74 Y139.74 E.00511
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.415 E.00511
G1 X143.919 Y139.415 E.00065
G1 X141.06 Y139.415 E.045
G1 X141.06 Y136.885 E.03983
G1 X143.919 Y136.884 E.045
G1 X143.96 Y136.884 E.00065
G1 X143.96 Y136.333 E.00867
G1 X144.74 Y136.333 E.01228
G1 X144.74 Y136.824 E.00773
M204 S10000
G1 X144.581 Y136.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X144.299 Y136.696 E.00497
G1 X144.299 Y137.143 E.00788
G1 X144.401 Y137.143 E.00181
G1 X144.401 Y137.223 E.00141
G1 X146.601 Y137.223 E.03882
G1 X146.601 Y137.59 E.00647
G1 X141.399 Y137.59 E.09181
G1 X141.399 Y138.037 E.00788
G1 X146.601 Y138.037 E.09181
G1 X146.601 Y138.483 E.00788
G1 X141.399 Y138.483 E.09181
G1 X141.399 Y138.93 E.00788
G1 X146.601 Y138.93 E.09181
G1 X146.601 Y139.077 E.00258
G1 X144.401 Y139.077 E.03882
G1 X144.401 Y139.377 E.0053
G1 X144.119 Y139.377 E.00497
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.377 E-.10711
G1 X144.401 Y139.077 E-.11414
G1 X145.819 Y139.077 E-.53875
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.819 Y138.983 Z.6 F30000
G1 X141.493 Y138.448
G1 X130.475 Y136.939
G1 X130.74 Y136.884
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.781 Y136.884 E.00065
G1 X132.94 Y136.885 E.03398
G1 X132.94 Y139.415 E.03983
G1 X130.781 Y139.415 E.03398
G1 X130.74 Y139.415 E.00065
G1 X130.74 Y139.74 E.00511
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.415 E.00511
G1 X129.919 Y139.415 E.00065
G1 X127.06 Y139.415 E.045
G1 X127.06 Y136.885 E.03983
G1 X129.919 Y136.884 E.045
G1 X129.96 Y136.884 E.00065
G1 X129.96 Y136.333 E.00867
G1 X130.74 Y136.333 E.01228
G1 X130.74 Y136.824 E.00773
M204 S10000
G1 X130.581 Y136.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X130.299 Y136.696 E.00497
G1 X130.299 Y137.143 E.00788
G1 X130.401 Y137.143 E.00181
G1 X130.401 Y137.223 E.00141
G1 X132.601 Y137.223 E.03882
G1 X132.601 Y137.59 E.00647
G1 X127.399 Y137.59 E.09181
G1 X127.399 Y138.037 E.00788
G1 X132.601 Y138.037 E.09181
G1 X132.601 Y138.483 E.00788
G1 X127.399 Y138.483 E.09181
G1 X127.399 Y138.93 E.00788
G1 X132.601 Y138.93 E.09181
G1 X132.601 Y139.077 E.00258
G1 X130.401 Y139.077 E.03882
G1 X130.401 Y139.377 E.0053
G1 X130.119 Y139.377 E.00497
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.377 E-.10711
G1 X130.401 Y139.077 E-.11414
G1 X131.819 Y139.077 E-.53875
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.819 Y138.983 Z.6 F30000
G1 X127.493 Y138.691
G1 X114.14 Y137.839
G1 X114.14 Y137.499
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.181 Y137.499 E.00065
G1 F1560
G1 X116.94 Y137.499 E.04343
G1 F1200
G1 X116.94 Y137.547 E.00076
G1 X116.94 Y138.453 E.01426
G1 X116.94 Y138.501 E.00076
G1 F1560
G1 X114.181 Y138.501 E.04343
G1 F1200
G1 X114.14 Y138.501 E.00065
G1 X114.14 Y139.265 E.01202
G1 X99.481 Y139.265 E.23075
G1 X99.44 Y139.265 E.00065
G1 X99.44 Y139.816 E.00867
G1 X99.06 Y139.816 E.00598
G1 X99.06 Y136.184 E.05717
G1 X99.44 Y136.184 E.00598
G1 X99.44 Y136.735 E.00867
G1 X99.481 Y136.735 E.00065
G1 X114.14 Y136.735 E.23075
G1 X114.14 Y137.439 E.01107
M204 S10000
G1 X113.979 Y137.1 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.1 E.24653
G1 X99.414 Y137.55 E.00762
G1 X113.58 Y137.55 E.23977
G1 X113.58 Y138 E.00762
G1 X99.414 Y138 E.23977
G1 X99.414 Y138.45 E.00762
M73 P56 R12
G1 X113.58 Y138.45 E.23977
G1 X113.58 Y138.659 E.00354
G1 X113.786 Y138.659 E.0035
G1 X113.786 Y138.9 E.00408
G1 X99.221 Y138.9 E.24653
G1 E-.8 F1800
M204 S10000
G1 X106.839 Y138.434 Z.6 F30000
G1 X113.933 Y138 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.6104
G1 F1200
M204 S1000
G1 X116.733 Y138 E.06513
; OBJECT_ID: 4
; WIPE_START
G1 X114.733 Y138 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X114.733 Y137.839 Z.6 F30000
G1 X114.167 Y124.161
G1 X116.397 Y123.839
G1 X114.14 Y123.839
G1 X114.14 Y123.499
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.181 Y123.499 E.00065
G1 F1560
G1 X116.94 Y123.499 E.04343
G1 F1200
G1 X116.94 Y123.547 E.00076
G1 X116.94 Y124.453 E.01426
G1 X116.94 Y124.501 E.00076
G1 F1560
G1 X114.181 Y124.501 E.04343
G1 F1200
G1 X114.14 Y124.501 E.00065
G1 X114.14 Y125.209 E.01115
G1 X99.481 Y125.211 E.23075
G1 X99.44 Y125.211 E.00065
G1 X99.44 Y125.816 E.00952
G1 X99.06 Y125.816 E.00598
G1 X99.06 Y122.184 E.05717
G1 X99.44 Y122.184 E.00598
G1 X99.44 Y122.789 E.00952
G1 X99.481 Y122.789 E.00065
G1 X114.14 Y122.791 E.23075
G1 X114.14 Y123.439 E.0102
M204 S10000
G1 X113.979 Y123.143 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.143 E.24653
G1 X99.414 Y123.571 E.00726
G1 X113.58 Y123.571 E.23977
G1 X113.58 Y124 E.00726
G1 X99.414 Y124 E.23977
G1 X99.414 Y124.429 E.00726
G1 X113.58 Y124.429 E.23977
G1 X113.58 Y124.659 E.0039
G1 X113.786 Y124.659 E.0035
G1 X113.786 Y124.858 E.00336
G1 X99.221 Y124.858 E.24653
G1 E-.8 F1800
M204 S10000
G1 X106.84 Y124.413 Z.6 F30000
G1 X113.933 Y124 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.6104
G1 F1200
M204 S1000
G1 X116.733 Y124 E.06513
; OBJECT_ID: 1
; WIPE_START
G1 X114.733 Y124 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X114.733 Y123.839 Z.6 F30000
G1 X114.167 Y110.161
G1 X116.397 Y109.839
G1 X114.14 Y109.839
G1 X114.14 Y109.499
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.181 Y109.499 E.00065
G1 F1560
G1 X116.94 Y109.499 E.04343
G1 F1200
G1 X116.94 Y109.547 E.00076
G1 X116.94 Y110.453 E.01426
G1 X116.94 Y110.501 E.00076
G1 F1560
G1 X114.181 Y110.501 E.04343
G1 F1200
G1 X114.14 Y110.501 E.00065
G1 X114.14 Y111.154 E.01028
G1 X99.481 Y111.158 E.23075
G1 X99.44 Y111.158 E.00065
G1 X99.44 Y111.816 E.01036
G1 X99.06 Y111.816 E.00598
G1 X99.06 Y108.184 E.05717
G1 X99.44 Y108.184 E.00598
G1 X99.44 Y108.842 E.01036
G1 X99.481 Y108.842 E.00065
G1 X114.14 Y108.846 E.23075
G1 X114.14 Y109.439 E.00933
M204 S10000
G1 X113.979 Y109.236 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.236 E.24653
G1 X99.414 Y109.746 E.00862
G1 X113.58 Y109.746 E.23977
G1 X113.58 Y110.255 E.00862
G1 X99.414 Y110.255 E.23977
G1 X99.414 Y110.764 E.00862
G1 X113.979 Y110.764 E.24653
M204 S10000
G1 X113.933 Y110 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.6104
G1 F1200
M204 S1000
G1 X116.733 Y110 E.06513
; CHANGE_LAYER
; Z_HEIGHT: 0.3
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X114.733 Y110 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 3/28
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I1.217 J0 P1  F30000
G1 X114.733 Y109.839 Z.6
G1 X116.507 Y109.884
G1 X130.242 Y108.988
G1 X130.511 Y109.185
G1 X130.667 Y109.227
G1 X130.74 Y108.955
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.955 E.03463
G1 X132.94 Y111.345 E.03761
G1 X130.74 Y111.345 E.03463
G1 X130.74 Y111.74 E.00622
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.345 E.00622
G1 X127.06 Y111.345 E.04565
G1 X127.06 Y108.955 E.03761
G1 X129.96 Y108.955 E.04565
G1 X129.96 Y108.309 E.01017
G1 X130.74 Y108.309 E.01228
G1 X130.74 Y108.895 E.00923
M204 S10000
G1 X130.581 Y108.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X130.299 Y108.674 E.00501
G1 X130.299 Y109.124 E.00801
G1 X130.401 Y109.124 E.00182
G1 X130.401 Y109.294 E.00303
G1 X132.601 Y109.294 E.03913
G1 X132.601 Y109.574 E.00498
G1 X127.399 Y109.574 E.09252
G1 X127.399 Y110.025 E.00801
G1 X132.601 Y110.025 E.09252
G1 X132.601 Y110.475 E.00801
G1 X127.399 Y110.475 E.09252
G1 X127.399 Y110.925 E.00801
G1 X132.601 Y110.925 E.09252
G1 X132.601 Y111.006 E.00144
G1 X130.401 Y111.006 E.03913
G1 X130.401 Y111.375 E.00657
G1 X130.119 Y111.375 E.00501
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.375 E-.10711
G1 X130.401 Y111.006 E-.14039
G1 X131.75 Y111.006 E-.51249
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.75 Y110.912 Z.7 F30000
G1 X130.476 Y122.955
G1 X130.74 Y122.903
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P57 R12
G1 F1200
M204 S500
G1 X132.94 Y122.903 E.03463
G1 X132.94 Y125.397 E.03926
G1 X130.74 Y125.397 E.03463
G1 X130.74 Y125.74 E.0054
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.397 E.0054
G1 X127.06 Y125.397 E.04565
G1 X127.06 Y122.903 E.03926
G1 X129.96 Y122.903 E.04565
G1 X129.96 Y122.309 E.00935
G1 X130.74 Y122.309 E.01228
G1 X130.74 Y122.843 E.00841
M204 S10000
G1 X130.581 Y122.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X130.299 Y122.674 E.00501
G1 X130.299 Y123.124 E.00801
G1 X130.401 Y123.124 E.00182
G1 X130.401 Y123.242 E.0021
G1 X132.601 Y123.242 E.03913
G1 X132.601 Y123.574 E.00591
G1 X127.399 Y123.574 E.09252
G1 X127.399 Y124.024 E.00801
G1 X132.601 Y124.024 E.09252
G1 X132.601 Y124.475 E.00801
G1 X127.399 Y124.475 E.09252
G1 X127.399 Y124.925 E.00801
G1 X132.601 Y124.925 E.09252
G1 X132.601 Y125.058 E.00237
G1 X130.401 Y125.058 E.03913
G1 X130.401 Y125.375 E.00564
G1 X130.119 Y125.375 E.00501
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.375 E-.10711
G1 X130.401 Y125.058 E-.12052
G1 X131.802 Y125.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.802 Y124.964 Z.7 F30000
G1 X132.507 Y124.941
G1 X141.493 Y123.444
G1 X143.429 Y123.336
G1 X144.189 Y123.132
G1 X144.434 Y122.742
G1 X144.476 Y122.955
G1 X144.74 Y122.903
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.903 E.03463
G1 X146.94 Y125.397 E.03926
G1 X144.74 Y125.397 E.03463
G1 X144.74 Y125.74 E.0054
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.397 E.0054
G1 X141.06 Y125.397 E.04565
G1 X141.06 Y122.903 E.03926
G1 X143.96 Y122.903 E.04565
G1 X143.96 Y122.309 E.00935
G1 X144.74 Y122.309 E.01228
G1 X144.74 Y122.843 E.00841
M204 S10000
G1 X144.581 Y122.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X144.299 Y122.674 E.00501
G1 X144.299 Y123.124 E.00801
G1 X144.401 Y123.124 E.00182
G1 X144.401 Y123.242 E.0021
G1 X146.601 Y123.242 E.03913
G1 X146.601 Y123.574 E.00591
G1 X141.399 Y123.574 E.09252
G1 X141.399 Y124.024 E.00801
G1 X146.601 Y124.024 E.09252
G1 X146.601 Y124.475 E.00801
G1 X141.399 Y124.475 E.09252
G1 X141.399 Y124.925 E.00801
G1 X146.601 Y124.925 E.09252
G1 X146.601 Y125.058 E.00237
G1 X144.401 Y125.058 E.03913
G1 X144.401 Y125.375 E.00564
G1 X144.119 Y125.375 E.00501
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.375 E-.10711
G1 X144.401 Y125.058 E-.12052
G1 X145.802 Y125.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.802 Y124.964 Z.7 F30000
G1 X145.689 Y123.336
G1 X144.869 Y110.912
G1 X145.271 Y109.388
G1 X144.667 Y109.227
G1 X144.74 Y108.955
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.955 E.03463
G1 X146.94 Y111.345 E.03761
G1 X144.74 Y111.345 E.03463
G1 X144.74 Y111.74 E.00622
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.345 E.00622
G1 X141.06 Y111.345 E.04565
G1 X141.06 Y108.955 E.03761
G1 X143.96 Y108.955 E.04565
G1 X143.96 Y108.309 E.01017
G1 X144.74 Y108.309 E.01228
G1 X144.74 Y108.895 E.00923
M204 S10000
G1 X144.581 Y108.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X144.299 Y108.674 E.00501
G1 X144.299 Y109.124 E.00801
G1 X144.401 Y109.124 E.00182
G1 X144.401 Y109.294 E.00303
G1 X146.601 Y109.294 E.03913
G1 X146.601 Y109.574 E.00498
G1 X141.399 Y109.574 E.09252
G1 X141.399 Y110.025 E.00801
G1 X146.601 Y110.025 E.09252
G1 X146.601 Y110.475 E.00801
G1 X141.399 Y110.475 E.09252
G1 X141.399 Y110.925 E.00801
G1 X146.601 Y110.925 E.09252
G1 X146.601 Y111.006 E.00144
G1 X144.401 Y111.006 E.03913
G1 X144.401 Y111.375 E.00657
G1 X144.119 Y111.375 E.00501
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.375 E-.10711
G1 X144.401 Y111.006 E-.14039
G1 X145.75 Y111.006 E-.51249
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.75 Y110.912 Z.7 F30000
G1 X145.268 Y123.335
G1 X145.204 Y124.964
G1 X144.474 Y136.906
G1 X144.74 Y136.851
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.851 E.03463
G1 X146.94 Y139.449 E.0409
; object ids of layer 3 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer3 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.449 E.03463
G1 X144.74 Y139.74 E.00458
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.449 E.00458
G1 X141.06 Y139.449 E.04565
G1 X141.06 Y136.851 E.0409
G1 X143.96 Y136.851 E.04565
G1 X143.96 Y136.309 E.00853
G1 X144.74 Y136.309 E.01228
G1 X144.74 Y136.791 E.00758
M204 S10000
G1 X144.581 Y136.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X144.299 Y136.674 E.00501
G1 X144.299 Y137.124 E.00801
G1 X144.401 Y137.124 E.00182
G1 X144.401 Y137.19 E.00117
G1 X146.601 Y137.19 E.03913
G1 X146.601 Y137.574 E.00684
G1 X141.399 Y137.574 E.09252
G1 X141.399 Y138.024 E.00801
G1 X146.601 Y138.024 E.09252
G1 X146.601 Y138.475 E.00801
G1 X141.399 Y138.475 E.09252
G1 X141.399 Y138.925 E.00801
G1 X146.601 Y138.925 E.09252
G1 X146.601 Y139.11 E.0033
G1 X144.401 Y139.11 E.03913
G1 X144.401 Y139.375 E.00471
G1 X144.119 Y139.375 E.00501
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.375 E-.10711
G1 X144.401 Y139.11 E-.1007
G1 X145.854 Y139.11 E-.55219
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.854 Y139.016 Z.7 F30000
G1 X141.493 Y138.458
G1 X130.474 Y136.906
G1 X130.74 Y136.851
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.851 E.03463
G1 X132.94 Y139.449 E.0409
G1 X130.74 Y139.449 E.03463
G1 X130.74 Y139.74 E.00458
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.449 E.00458
G1 X127.06 Y139.449 E.04565
G1 X127.06 Y136.851 E.0409
G1 X129.96 Y136.851 E.04565
G1 X129.96 Y136.309 E.00853
G1 X130.74 Y136.309 E.01228
G1 X130.74 Y136.791 E.00758
M204 S10000
G1 X130.581 Y136.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X130.299 Y136.674 E.00501
G1 X130.299 Y137.124 E.00801
G1 X130.401 Y137.124 E.00182
G1 X130.401 Y137.19 E.00117
G1 X132.601 Y137.19 E.03913
G1 X132.601 Y137.574 E.00684
G1 X127.399 Y137.574 E.09252
G1 X127.399 Y138.024 E.00801
G1 X132.601 Y138.024 E.09252
G1 X132.601 Y138.475 E.00801
G1 X127.399 Y138.475 E.09252
G1 X127.399 Y138.925 E.00801
G1 X132.601 Y138.925 E.09252
G1 X132.601 Y139.11 E.0033
G1 X130.401 Y139.11 E.03913
G1 X130.401 Y139.375 E.00471
G1 X130.119 Y139.375 E.00501
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.375 E-.10711
G1 X130.401 Y139.11 E-.1007
G1 X131.854 Y139.11 E-.55219
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.854 Y139.016 Z.7 F30000
G1 X127.493 Y138.696
G1 X114.181 Y137.839
G1 X114.181 Y137.431
M73 P58 R12
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.431 E.04343
G1 X116.94 Y137.458 E.00043
G1 X116.94 Y138.542 E.01707
G1 X116.94 Y138.569 E.00043
G1 X114.181 Y138.569 E.04343
G1 X114.14 Y138.569 E.00065
G1 X114.14 Y139.298 E.01148
G1 X99.44 Y139.298 E.23139
G1 X99.44 Y139.841 E.00854
G1 X99.06 Y139.841 E.00598
G1 X99.06 Y136.159 E.05796
G1 X99.44 Y136.159 E.00598
G1 X99.44 Y136.702 E.00854
G1 X114.14 Y136.702 E.23139
G1 X114.14 Y137.412 E.01118
M204 S10000
G1 X113.979 Y137.073 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.073 E.24653
G1 X99.414 Y137.536 E.00785
G1 X113.786 Y137.536 E.24327
G1 X113.786 Y137.784 E.0042
G1 X116.586 Y137.784 E.04739
G1 X116.586 Y138 E.00365
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.464 E.00785
G1 X113.786 Y138.464 E.24327
G1 X113.786 Y138.927 E.00785
G1 X99.221 Y138.927 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.927 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.865 Z.7 F30000
G1 X102.72 Y137.135
G1 X113.025 Y124.813
G1 X113.731 Y124.161
G1 X116.397 Y123.839
G1 X114.181 Y123.839
G1 X114.181 Y123.431
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.431 E.04343
G1 X116.94 Y123.458 E.00043
M73 P58 R11
G1 X116.94 Y124.542 E.01707
G1 X116.94 Y124.569 E.00043
G1 X114.181 Y124.569 E.04343
G1 X114.14 Y124.569 E.00065
G1 X114.14 Y125.246 E.01065
G1 X99.44 Y125.246 E.23139
G1 X99.44 Y125.841 E.00936
G1 X99.06 Y125.841 E.00598
G1 X99.06 Y122.159 E.05796
G1 X99.44 Y122.159 E.00598
G1 X99.44 Y122.754 E.00936
G1 X114.14 Y122.754 E.23139
G1 X114.14 Y123.412 E.01035
M204 S10000
G1 X113.979 Y123.115 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.115 E.24653
G1 X99.414 Y123.557 E.00749
G1 X113.786 Y123.557 E.24327
G1 X113.786 Y123.784 E.00384
G1 X116.586 Y123.784 E.04739
G1 X116.586 Y124 E.00365
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.443 E.00749
G1 X113.786 Y124.443 E.24327
G1 X113.786 Y124.885 E.00749
G1 X99.221 Y124.885 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.885 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.813 Z.7 F30000
G1 X102.645 Y123.187
G1 X113.065 Y110.761
G1 X113.731 Y110.161
G1 X116.397 Y109.839
G1 X114.181 Y109.839
G1 X114.181 Y109.431
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.431 E.04343
G1 X116.94 Y109.458 E.00043
G1 X116.94 Y110.542 E.01707
G1 X116.94 Y110.569 E.00043
G1 X114.181 Y110.569 E.04343
G1 X114.14 Y110.569 E.00065
G1 X114.14 Y111.194 E.00983
G1 X99.44 Y111.194 E.23139
G1 X99.44 Y111.841 E.01019
G1 X99.06 Y111.841 E.00598
G1 X99.06 Y108.159 E.05796
G1 X99.44 Y108.159 E.00598
G1 X99.44 Y108.806 E.01019
G1 X114.14 Y108.806 E.23139
G1 X114.14 Y109.412 E.00953
M204 S10000
G1 X113.979 Y109.203 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.203 E.24653
G1 X99.414 Y109.717 E.0087
G1 X113.786 Y109.717 E.24327
G1 X113.786 Y109.784 E.00114
G1 X116.586 Y109.784 E.04739
G1 X116.586 Y110.216 E.0073
G1 X99.414 Y110.231 E.29066
G1 X99.414 Y110.746 E.0087
G1 X113.979 Y110.746 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X111.979 Y110.746 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 4/28
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S25.5
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.7 I-1.217 J0 P1  F30000
G1 X111.979 Y110.789 Z.7
G1 X113.707 Y110.578
G1 X130.223 Y108.978
G1 X130.429 Y108.723
G1 X130.477 Y108.977
G1 X130.74 Y108.927
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.927 E.03463
G1 X132.94 Y111.372 E.03849
G1 X130.74 Y111.372 E.03463
G1 X130.74 Y111.74 E.00579
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.372 E.00579
G1 X127.06 Y111.372 E.04565
G1 X127.06 Y108.927 E.03849
G1 X129.96 Y108.927 E.04565
G1 X129.96 Y108.29 E.01004
G1 X130.74 Y108.29 E.01228
G1 X130.74 Y108.867 E.00909
M204 S10000
G1 X130.581 Y108.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X130.299 Y108.656 E.00504
G1 X130.299 Y109.109 E.00811
G1 X130.401 Y109.109 E.00183
G1 X130.401 Y109.266 E.00282
G1 X132.601 Y109.266 E.03937
G1 X132.601 Y109.562 E.00529
G1 X127.399 Y109.562 E.09309
G1 X127.399 Y110.015 E.00811
G1 X132.601 Y110.015 E.09309
G1 X132.601 Y110.468 E.00811
G1 X127.399 Y110.468 E.09309
G1 X127.399 Y110.921 E.00811
G1 X132.601 Y110.921 E.09309
G1 X132.601 Y111.034 E.00202
G1 X130.401 Y111.034 E.03937
G1 X130.401 Y111.374 E.00609
G1 X130.119 Y111.374 E.00504
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.374 E-.10711
G1 X130.401 Y111.034 E-.12931
G1 X131.779 Y111.034 E-.52358
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.779 Y110.94 Z.8 F30000
G1 X130.476 Y122.929
G1 X130.74 Y122.876
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P59 R11
G1 F1200
M204 S500
G1 X132.94 Y122.876 E.03463
G1 X132.94 Y125.424 E.04011
G1 X130.74 Y125.424 E.03463
G1 X130.74 Y125.74 E.00498
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.424 E.00498
G1 X127.06 Y125.424 E.04565
G1 X127.06 Y122.876 E.04011
G1 X129.96 Y122.876 E.04565
G1 X129.96 Y122.29 E.00923
G1 X130.74 Y122.29 E.01228
G1 X130.74 Y122.816 E.00828
M204 S10000
G1 X130.581 Y122.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X130.299 Y122.656 E.00504
G1 X130.299 Y123.109 E.00811
G1 X130.401 Y123.109 E.00183
G1 X130.401 Y123.215 E.0019
G1 X132.601 Y123.215 E.03937
G1 X132.601 Y123.562 E.00621
G1 X127.399 Y123.562 E.09309
G1 X127.399 Y124.015 E.00811
G1 X132.601 Y124.015 E.09309
G1 X132.601 Y124.468 E.00811
G1 X127.399 Y124.468 E.09309
G1 X127.399 Y124.921 E.00811
G1 X132.601 Y124.921 E.09309
G1 X132.601 Y125.085 E.00294
G1 X130.401 Y125.085 E.03937
G1 X130.401 Y125.374 E.00517
G1 X130.119 Y125.374 E.00504
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.374 E-.10711
G1 X130.401 Y125.085 E-.10977
G1 X131.831 Y125.085 E-.54312
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.831 Y124.991 Z.8 F30000
G1 X132.507 Y124.969
G1 X141.493 Y123.432
G1 X143.429 Y123.309
G1 X144.189 Y123.105
G1 X144.435 Y122.723
G1 X144.476 Y122.929
G1 X144.74 Y122.876
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.876 E.03463
G1 X146.94 Y125.424 E.04011
G1 X144.74 Y125.424 E.03463
G1 X144.74 Y125.74 E.00498
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.424 E.00498
G1 X141.06 Y125.424 E.04565
G1 X141.06 Y122.876 E.04011
G1 X143.96 Y122.876 E.04565
G1 X143.96 Y122.29 E.00923
G1 X144.74 Y122.29 E.01228
G1 X144.74 Y122.816 E.00828
M204 S10000
G1 X144.581 Y122.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X144.299 Y122.656 E.00504
G1 X144.299 Y123.109 E.00811
G1 X144.401 Y123.109 E.00183
G1 X144.401 Y123.215 E.0019
G1 X146.601 Y123.215 E.03937
G1 X146.601 Y123.562 E.00621
G1 X141.399 Y123.562 E.09309
G1 X141.399 Y124.015 E.00811
G1 X146.601 Y124.015 E.09309
G1 X146.601 Y124.468 E.00811
G1 X141.399 Y124.468 E.09309
G1 X141.399 Y124.921 E.00811
G1 X146.601 Y124.921 E.09309
G1 X146.601 Y125.085 E.00294
G1 X144.401 Y125.085 E.03937
G1 X144.401 Y125.374 E.00517
G1 X144.119 Y125.374 E.00504
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.374 E-.10711
G1 X144.401 Y125.085 E-.10977
G1 X145.831 Y125.085 E-.54312
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.831 Y124.991 Z.8 F30000
G1 X145.711 Y123.309
G1 X144.876 Y110.94
G1 X144.511 Y109.157
G1 X144.477 Y108.977
G1 X144.74 Y108.927
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.927 E.03463
G1 X146.94 Y111.372 E.03849
G1 X144.74 Y111.372 E.03463
G1 X144.74 Y111.74 E.00579
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.372 E.00579
G1 X141.06 Y111.372 E.04565
G1 X141.06 Y108.927 E.03849
G1 X143.96 Y108.927 E.04565
G1 X143.96 Y108.29 E.01004
G1 X144.74 Y108.29 E.01228
G1 X144.74 Y108.867 E.00909
M204 S10000
G1 X144.581 Y108.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X144.299 Y108.656 E.00504
G1 X144.299 Y109.109 E.00811
G1 X144.401 Y109.109 E.00183
G1 X144.401 Y109.266 E.00282
G1 X146.601 Y109.266 E.03937
G1 X146.601 Y109.562 E.00529
G1 X141.399 Y109.562 E.09309
G1 X141.399 Y110.015 E.00811
G1 X146.601 Y110.015 E.09309
G1 X146.601 Y110.468 E.00811
G1 X141.399 Y110.468 E.09309
G1 X141.399 Y110.921 E.00811
G1 X146.601 Y110.921 E.09309
G1 X146.601 Y111.034 E.00202
G1 X144.401 Y111.034 E.03937
G1 X144.401 Y111.374 E.00609
G1 X144.119 Y111.374 E.00504
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.374 E-.10711
G1 X144.401 Y111.034 E-.12931
G1 X145.779 Y111.034 E-.52358
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.779 Y110.94 Z.8 F30000
G1 X145.285 Y123.309
G1 X145.217 Y124.991
G1 X144.474 Y136.88
G1 X144.74 Y136.825
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.825 E.03463
G1 X146.94 Y139.475 E.04172
; object ids of layer 4 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer4 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.475 E.03463
G1 X144.74 Y139.74 E.00417
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.475 E.00417
G1 X141.06 Y139.475 E.04565
G1 X141.06 Y136.825 E.04172
G1 X143.96 Y136.825 E.04565
G1 X143.96 Y136.29 E.00842
G1 X144.74 Y136.29 E.01228
G1 X144.74 Y136.765 E.00748
M204 S10000
G1 X144.581 Y136.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X144.299 Y136.656 E.00504
G1 X144.299 Y137.109 E.00811
G1 X144.401 Y137.109 E.00183
G1 X144.401 Y137.163 E.00098
G1 X146.601 Y137.163 E.03937
G1 X146.601 Y137.562 E.00713
G1 X141.399 Y137.562 E.09309
G1 X141.399 Y138.015 E.00811
G1 X146.601 Y138.015 E.09309
G1 X146.601 Y138.468 E.00811
G1 X141.399 Y138.468 E.09309
G1 X141.399 Y138.921 E.00811
G1 X146.601 Y138.921 E.09309
G1 X146.601 Y139.137 E.00386
G1 X144.401 Y139.137 E.03937
G1 X144.401 Y139.374 E.00425
G1 X144.119 Y139.374 E.00504
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.374 E-.10711
G1 X144.401 Y139.137 E-.09025
G1 X145.882 Y139.137 E-.56265
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.882 Y139.042 Z.8 F30000
G1 X141.493 Y138.466
G1 X130.474 Y136.88
G1 X130.74 Y136.825
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.825 E.03463
M73 P60 R11
G1 X132.94 Y139.475 E.04172
G1 X130.74 Y139.475 E.03463
G1 X130.74 Y139.74 E.00417
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.475 E.00417
G1 X127.06 Y139.475 E.04565
G1 X127.06 Y136.825 E.04172
G1 X129.96 Y136.825 E.04565
G1 X129.96 Y136.29 E.00842
G1 X130.74 Y136.29 E.01228
G1 X130.74 Y136.765 E.00748
M204 S10000
G1 X130.581 Y136.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X130.299 Y136.656 E.00504
G1 X130.299 Y137.109 E.00811
G1 X130.401 Y137.109 E.00183
G1 X130.401 Y137.163 E.00098
G1 X132.601 Y137.163 E.03937
G1 X132.601 Y137.562 E.00713
G1 X127.399 Y137.562 E.09309
G1 X127.399 Y138.015 E.00811
G1 X132.601 Y138.015 E.09309
G1 X132.601 Y138.468 E.00811
G1 X127.399 Y138.468 E.09309
G1 X127.399 Y138.921 E.00811
G1 X132.601 Y138.921 E.09309
G1 X132.601 Y139.137 E.00386
G1 X130.401 Y139.137 E.03937
G1 X130.401 Y139.374 E.00425
G1 X130.119 Y139.374 E.00504
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.374 E-.10711
G1 X130.401 Y139.137 E-.09025
G1 X131.882 Y139.137 E-.56265
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.882 Y139.042 Z.8 F30000
G1 X127.493 Y138.701
G1 X114.181 Y137.815
G1 X114.181 Y137.382
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.382 E.04343
G1 X116.94 Y137.39 E.00012
G1 X116.94 Y138.61 E.01921
G1 X116.94 Y138.618 E.00012
G1 X114.181 Y138.618 E.04343
G1 X114.14 Y138.618 E.00065
G1 X114.14 Y139.325 E.01112
G1 X99.44 Y139.325 E.23139
G1 X99.44 Y139.86 E.00843
G1 X99.06 Y139.86 E.00598
G1 X99.06 Y136.14 E.05856
G1 X99.44 Y136.14 E.00598
G1 X99.44 Y136.675 E.00843
G1 X114.14 Y136.675 E.23139
G1 X114.14 Y137.363 E.01082
M204 S10000
G1 X113.979 Y137.052 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.052 E.24653
G1 X99.414 Y137.526 E.00802
G1 X113.786 Y137.526 E.24327
G1 X113.786 Y137.736 E.00355
G1 X116.586 Y137.736 E.04739
G1 X116.586 Y138 E.00448
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.474 E.00802
G1 X113.786 Y138.474 E.24327
G1 X113.786 Y138.948 E.00802
G1 X99.221 Y138.948 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.948 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.892 Z.8 F30000
G1 X102.753 Y137.108
G1 X112.967 Y124.84
G1 X113.707 Y124.185
G1 X116.507 Y123.815
G1 X114.181 Y123.815
G1 X114.181 Y123.382
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.382 E.04343
G1 X116.94 Y123.39 E.00012
G1 X116.94 Y124.61 E.01921
G1 X116.94 Y124.618 E.00012
G1 X114.181 Y124.618 E.04343
G1 X114.14 Y124.618 E.00065
G1 X114.14 Y125.273 E.01031
G1 X99.44 Y125.273 E.23139
G1 X99.44 Y125.86 E.00924
G1 X99.06 Y125.86 E.00598
G1 X99.06 Y122.14 E.05856
G1 X99.44 Y122.14 E.00598
G1 X99.44 Y122.727 E.00924
G1 X114.14 Y122.727 E.23139
G1 X114.14 Y123.363 E.01001
M204 S10000
G1 X113.979 Y123.093 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.093 E.24653
G1 X99.414 Y123.546 E.00768
G1 X113.786 Y123.546 E.24327
G1 X113.786 Y123.736 E.0032
G1 X116.586 Y123.736 E.04739
G1 X116.586 Y124 E.00448
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.454 E.00768
G1 X113.786 Y124.454 E.24327
G1 X113.786 Y124.907 E.00768
G1 X99.221 Y124.907 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.907 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.84 Z.8 F30000
G1 X102.68 Y123.16
G1 X113.006 Y110.789
G1 X113.707 Y110.185
G1 X116.507 Y109.815
G1 X114.181 Y109.815
G1 X114.181 Y109.382
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.382 E.04343
G1 X116.94 Y109.39 E.00012
G1 X116.94 Y110.61 E.01921
G1 X116.94 Y110.618 E.00012
G1 X114.181 Y110.618 E.04343
G1 X114.14 Y110.618 E.00065
G1 X114.14 Y111.222 E.0095
G1 X99.44 Y111.222 E.23139
G1 X99.44 Y111.86 E.01005
G1 X99.06 Y111.86 E.00598
G1 X99.06 Y108.14 E.05856
G1 X99.44 Y108.14 E.00598
G1 X99.44 Y108.778 E.01005
G1 X114.14 Y108.778 E.23139
G1 X114.14 Y109.363 E.0092
M204 S10000
G1 X113.979 Y109.134 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.134 E.24653
G1 X99.414 Y109.567 E.00733
G1 X113.786 Y109.567 E.24327
G1 X113.786 Y109.736 E.00285
G1 X116.586 Y109.736 E.04739
G1 X116.586 Y110 E.00448
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.433 E.00733
G1 X113.786 Y110.433 E.24327
G1 X113.786 Y110.866 E.00733
G1 X99.221 Y110.866 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 0.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.866 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 5/28
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.8 I1.217 J0 P1  F30000
G1 X101.221 Y110.81 Z.8
G1 X116.507 Y109.851
G1 X130.226 Y108.941
G1 X130.429 Y108.708
G1 X130.477 Y108.956
G1 X130.74 Y108.906
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.906 E.03463
G1 X132.94 Y111.394 E.03915
G1 X130.74 Y111.394 E.03463
G1 X130.74 Y111.74 E.00545
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.394 E.00545
G1 X127.06 Y111.394 E.04565
G1 X127.06 Y108.906 E.03915
G1 X129.96 Y108.906 E.04565
G1 X129.96 Y108.275 E.00994
G1 X130.74 Y108.275 E.01228
G1 X130.74 Y108.846 E.00899
M204 S10000
G1 X130.581 Y108.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X130.299 Y108.642 E.00507
G1 X130.299 Y109.097 E.00818
G1 X130.401 Y109.097 E.00184
G1 X130.401 Y109.245 E.00266
G1 X132.601 Y109.245 E.03955
G1 X132.601 Y109.553 E.00553
G1 X127.399 Y109.553 E.09352
G1 X127.399 Y110.008 E.00818
G1 X132.601 Y110.008 E.09352
G1 X132.601 Y110.463 E.00818
G1 X127.399 Y110.463 E.09352
G1 X127.399 Y110.918 E.00818
G1 X132.601 Y110.918 E.09352
G1 X132.601 Y111.055 E.00246
M73 P61 R11
G1 X130.401 Y111.055 E.03955
G1 X130.401 Y111.373 E.00572
G1 X130.119 Y111.373 E.00507
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.373 E-.10711
G1 X130.401 Y111.055 E-.12092
G1 X131.801 Y111.055 E-.53198
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.801 Y110.961 Z.9 F30000
G1 X130.475 Y122.909
G1 X130.74 Y122.856
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.856 E.03463
G1 X132.94 Y125.444 E.04074
G1 X130.74 Y125.444 E.03463
G1 X130.74 Y125.74 E.00466
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.444 E.00466
G1 X127.06 Y125.444 E.04565
G1 X127.06 Y122.856 E.04074
G1 X129.96 Y122.856 E.04565
G1 X129.96 Y122.275 E.00914
G1 X130.74 Y122.275 E.01228
G1 X130.74 Y122.796 E.00819
M204 S10000
G1 X130.581 Y122.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X130.299 Y122.642 E.00507
G1 X130.299 Y123.097 E.00818
G1 X130.401 Y123.097 E.00184
G1 X130.401 Y123.195 E.00175
G1 X132.601 Y123.195 E.03955
G1 X132.601 Y123.553 E.00644
G1 X127.399 Y123.553 E.09352
G1 X127.399 Y124.008 E.00818
G1 X132.601 Y124.008 E.09352
G1 X132.601 Y124.463 E.00818
G1 X127.399 Y124.463 E.09352
G1 X127.399 Y124.918 E.00818
G1 X132.601 Y124.918 E.09352
G1 X132.601 Y125.105 E.00337
G1 X130.401 Y125.105 E.03955
G1 X130.401 Y125.373 E.00481
G1 X130.119 Y125.373 E.00507
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.373 E-.10711
G1 X130.401 Y125.105 E-.10167
G1 X131.852 Y125.105 E-.55122
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.852 Y125.011 Z.9 F30000
G1 X132.507 Y124.991
G1 X141.493 Y123.423
G1 X143.429 Y123.289
G1 X144.189 Y123.085
G1 X144.435 Y122.708
G1 X144.475 Y122.909
G1 X144.74 Y122.856
M73 P61 R10
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.856 E.03463
G1 X146.94 Y125.444 E.04074
G1 X144.74 Y125.444 E.03463
G1 X144.74 Y125.74 E.00466
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.444 E.00466
G1 X141.06 Y125.444 E.04565
G1 X141.06 Y122.856 E.04074
G1 X143.96 Y122.856 E.04565
G1 X143.96 Y122.275 E.00914
G1 X144.74 Y122.275 E.01228
G1 X144.74 Y122.796 E.00819
M204 S10000
G1 X144.581 Y122.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X144.299 Y122.642 E.00507
G1 X144.299 Y123.097 E.00818
G1 X144.401 Y123.097 E.00184
G1 X144.401 Y123.195 E.00175
G1 X146.601 Y123.195 E.03955
G1 X146.601 Y123.553 E.00644
G1 X141.399 Y123.553 E.09352
G1 X141.399 Y124.008 E.00818
G1 X146.601 Y124.008 E.09352
G1 X146.601 Y124.463 E.00818
G1 X141.399 Y124.463 E.09352
G1 X141.399 Y124.918 E.00818
G1 X146.601 Y124.918 E.09352
G1 X146.601 Y125.105 E.00337
G1 X144.401 Y125.105 E.03955
G1 X144.401 Y125.373 E.00481
G1 X144.119 Y125.373 E.00507
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.373 E-.10711
G1 X144.401 Y125.105 E-.10167
G1 X145.852 Y125.105 E-.55122
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.852 Y125.011 Z.9 F30000
G1 X145.727 Y123.289
G1 X144.881 Y110.961
G1 X144.511 Y109.136
G1 X144.477 Y108.956
G1 X144.74 Y108.906
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.906 E.03463
G1 X146.94 Y111.394 E.03915
G1 X144.74 Y111.394 E.03463
G1 X144.74 Y111.74 E.00545
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.394 E.00545
G1 X141.06 Y111.394 E.04565
G1 X141.06 Y108.906 E.03915
G1 X143.96 Y108.906 E.04565
G1 X143.96 Y108.275 E.00994
G1 X144.74 Y108.275 E.01228
G1 X144.74 Y108.846 E.00899
M204 S10000
G1 X144.581 Y108.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X144.299 Y108.642 E.00507
G1 X144.299 Y109.097 E.00818
G1 X144.401 Y109.097 E.00184
G1 X144.401 Y109.245 E.00266
G1 X146.601 Y109.245 E.03955
G1 X146.601 Y109.553 E.00553
G1 X141.399 Y109.553 E.09352
G1 X141.399 Y110.008 E.00818
G1 X146.601 Y110.008 E.09352
G1 X146.601 Y110.463 E.00818
G1 X141.399 Y110.463 E.09352
G1 X141.399 Y110.918 E.00818
G1 X146.601 Y110.918 E.09352
G1 X146.601 Y111.055 E.00246
G1 X144.401 Y111.055 E.03955
G1 X144.401 Y111.373 E.00572
G1 X144.119 Y111.373 E.00507
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.373 E-.10711
G1 X144.401 Y111.055 E-.12092
G1 X145.801 Y111.055 E-.53198
; WIPE_END
M73 P62 R10
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.801 Y110.961 Z.9 F30000
G1 X145.297 Y123.289
G1 X145.226 Y125.011
G1 X144.307 Y136.805
G1 X144.74 Y136.805
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.805 E.03463
G1 X146.94 Y139.495 E.04233
; object ids of layer 5 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer5 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.495 E.03463
G1 X144.74 Y139.74 E.00386
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.495 E.00386
G1 X141.06 Y139.495 E.04565
G1 X141.06 Y136.805 E.04233
G1 X143.96 Y136.805 E.04565
G1 X143.96 Y136.275 E.00834
G1 X144.74 Y136.275 E.01228
G1 X144.74 Y136.745 E.0074
M204 S10000
G1 X144.581 Y136.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X144.299 Y136.642 E.00507
G1 X144.299 Y137.097 E.00818
G1 X144.401 Y137.097 E.00184
G1 X144.401 Y137.144 E.00084
G1 X146.601 Y137.144 E.03955
G1 X146.601 Y137.553 E.00734
G1 X141.399 Y137.553 E.09352
G1 X141.399 Y138.008 E.00818
G1 X146.601 Y138.008 E.09352
G1 X146.601 Y138.463 E.00818
G1 X141.399 Y138.463 E.09352
G1 X141.399 Y138.918 E.00818
G1 X146.601 Y138.918 E.09352
G1 X146.601 Y139.156 E.00428
G1 X144.401 Y139.156 E.03955
G1 X144.401 Y139.373 E.0039
G1 X144.119 Y139.373 E.00507
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.373 E-.10711
G1 X144.401 Y139.156 E-.08246
G1 X145.902 Y139.156 E-.57043
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.902 Y139.062 Z.9 F30000
G1 X141.493 Y138.472
G1 X130.307 Y136.805
G1 X130.74 Y136.805
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.805 E.03463
G1 X132.94 Y139.495 E.04233
G1 X130.74 Y139.495 E.03463
G1 X130.74 Y139.74 E.00386
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.495 E.00386
G1 X127.06 Y139.495 E.04565
G1 X127.06 Y136.805 E.04233
G1 X129.96 Y136.805 E.04565
G1 X129.96 Y136.275 E.00834
G1 X130.74 Y136.275 E.01228
G1 X130.74 Y136.745 E.0074
M204 S10000
G1 X130.581 Y136.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X130.299 Y136.642 E.00507
G1 X130.299 Y137.097 E.00818
G1 X130.401 Y137.097 E.00184
G1 X130.401 Y137.144 E.00084
G1 X132.601 Y137.144 E.03955
G1 X132.601 Y137.553 E.00734
G1 X127.399 Y137.553 E.09352
G1 X127.399 Y138.008 E.00818
G1 X132.601 Y138.008 E.09352
G1 X132.601 Y138.463 E.00818
G1 X127.399 Y138.463 E.09352
G1 X127.399 Y138.918 E.00818
G1 X132.601 Y138.918 E.09352
G1 X132.601 Y139.156 E.00428
G1 X130.401 Y139.156 E.03955
G1 X130.401 Y139.373 E.0039
G1 X130.119 Y139.373 E.00507
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.373 E-.10711
G1 X130.401 Y139.156 E-.08246
G1 X131.902 Y139.156 E-.57043
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.902 Y139.062 Z.9 F30000
G1 X127.493 Y138.707
G1 X113.707 Y137.346
G1 X114.14 Y137.346
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.346 E.04407
G1 X116.94 Y138.654 E.02058
G1 X114.14 Y138.654 E.04407
G1 X114.14 Y139.344 E.01087
G1 X99.44 Y139.344 E.23139
G1 X99.44 Y139.874 E.00834
G1 X99.06 Y139.874 E.00598
G1 X99.06 Y136.126 E.05901
G1 X99.44 Y136.126 E.00598
G1 X99.44 Y136.656 E.00834
G1 X114.14 Y136.656 E.23139
G1 X114.14 Y137.286 E.00992
M204 S10000
G1 X113.979 Y137.036 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.036 E.24653
G1 X99.414 Y137.518 E.00816
G1 X113.786 Y137.518 E.24327
G1 X113.786 Y137.7 E.00308
G1 X116.586 Y137.7 E.04739
G1 X116.586 Y138 E.00508
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.482 E.00816
G1 X113.786 Y138.482 E.24327
G1 X113.786 Y138.964 E.00816
G1 X99.221 Y138.964 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.964 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.911 Z.9 F30000
G1 X102.772 Y137.089
G1 X112.887 Y124.861
G1 X113.707 Y123.779
G1 X113.707 Y123.346
G1 X114.14 Y123.346
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.346 E.04407
G1 X116.94 Y124.654 E.02058
G1 X114.14 Y124.654 E.04407
G1 X114.14 Y125.293 E.01007
G1 X99.44 Y125.293 E.23139
G1 X99.44 Y125.874 E.00914
G1 X99.06 Y125.874 E.00598
G1 X99.06 Y122.126 E.05901
G1 X99.44 Y122.126 E.00598
G1 X99.44 Y122.707 E.00914
G1 X114.14 Y122.707 E.23139
G1 X114.14 Y123.286 E.00912
M204 S10000
G1 X113.979 Y123.077 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.077 E.24653
G1 X99.414 Y123.538 E.00781
G1 X113.786 Y123.538 E.24327
G1 X113.786 Y123.7 E.00273
G1 X116.586 Y123.7 E.04739
G1 X116.586 Y124 E.00508
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.462 E.00781
G1 X113.786 Y124.462 E.24327
G1 X113.786 Y124.923 E.00781
G1 X99.221 Y124.923 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.923 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.861 Z.9 F30000
G1 X102.7 Y123.139
G1 X112.926 Y110.81
G1 X113.707 Y109.779
G1 X113.707 Y109.346
G1 X114.14 Y109.346
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.346 E.04407
G1 X116.94 Y110.654 E.02058
G1 X114.14 Y110.654 E.04407
G1 X114.14 Y111.243 E.00927
G1 X99.44 Y111.243 E.23139
G1 X99.44 Y111.874 E.00994
G1 X99.06 Y111.874 E.00598
G1 X99.06 Y108.126 E.05901
G1 X99.44 Y108.126 E.00598
G1 X99.44 Y108.757 E.00994
G1 X114.14 Y108.757 E.23139
G1 X114.14 Y109.286 E.00833
M204 S10000
G1 X113.979 Y109.117 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.117 E.24653
G1 X99.414 Y109.559 E.00747
G1 X113.786 Y109.559 E.24327
G1 X113.786 Y109.7 E.00239
G1 X116.586 Y109.7 E.04739
G1 X116.586 Y110 E.00508
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.441 E.00747
G1 X113.786 Y110.441 E.24327
G1 X113.786 Y110.883 E.00747
G1 X99.221 Y110.883 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.883 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 6/28
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.9 I1.217 J0 P1  F30000
G1 X101.221 Y110.824 Z.9
G1 X116.507 Y109.852
G1 X130.227 Y108.928
G1 X130.43 Y108.698
G1 X130.476 Y108.943
G1 X130.74 Y108.893
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.893 E.03463
G1 X132.94 Y111.407 E.03957
G1 X130.74 Y111.407 E.03463
G1 X130.74 Y111.74 E.00524
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.407 E.00524
G1 X127.06 Y111.407 E.04565
G1 X127.06 Y108.893 E.03957
M73 P63 R10
G1 X129.96 Y108.893 E.04565
G1 X129.96 Y108.265 E.00988
G1 X130.74 Y108.265 E.01228
G1 X130.74 Y108.833 E.00893
M204 S10000
G1 X130.581 Y108.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
G1 X130.299 Y108.605 E.00445
G1 X130.299 Y109.004 E.0063
G1 X130.401 Y109.004 E.00162
G1 X130.401 Y109.232 E.00359
G1 X132.601 Y109.232 E.03471
G1 X132.601 Y109.404 E.00271
G1 X127.399 Y109.404 E.08208
G1 X127.399 Y109.803 E.0063
G1 X132.601 Y109.803 E.08208
G1 X132.601 Y110.202 E.0063
G1 X127.399 Y110.202 E.08208
G1 X127.399 Y110.602 E.0063
G1 X132.601 Y110.602 E.08208
G1 X132.601 Y111.001 E.0063
G1 X127.399 Y111.001 E.08208
G1 X127.399 Y111.068 E.00106
G1 X130.299 Y111.068 E.04575
G1 X130.299 Y111.401 E.00525
G1 X130.581 Y111.401 E.00445
; OBJECT_ID: 5
; WIPE_START
G1 X130.299 Y111.401 E-.10711
G1 X130.299 Y111.068 E-.12637
G1 X128.913 Y111.068 E-.52653
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X128.913 Y110.974 Z1 F30000
G1 X130.475 Y122.896
G1 X130.74 Y122.843
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.843 E.03463
G1 X132.94 Y125.457 E.04116
G1 X130.74 Y125.457 E.03463
G1 X130.74 Y125.74 E.00445
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.457 E.00445
G1 X127.06 Y125.457 E.04565
G1 X127.06 Y122.843 E.04116
G1 X129.96 Y122.843 E.04565
G1 X129.96 Y122.265 E.00909
G1 X130.74 Y122.265 E.01228
G1 X130.74 Y122.783 E.00814
M204 S10000
G1 X130.581 Y122.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
G1 X130.299 Y122.605 E.00445
G1 X130.299 Y123.004 E.0063
G1 X130.401 Y123.004 E.00162
G1 X130.401 Y123.181 E.0028
G1 X132.601 Y123.181 E.03471
G1 X132.601 Y123.404 E.0035
G1 X127.399 Y123.404 E.08208
G1 X127.399 Y123.803 E.0063
G1 X132.601 Y123.803 E.08208
G1 X132.601 Y124.202 E.0063
G1 X127.399 Y124.202 E.08208
G1 X127.399 Y124.602 E.0063
G1 X132.601 Y124.602 E.08208
G1 X132.601 Y125.001 E.0063
G1 X127.399 Y125.001 E.08208
G1 X127.399 Y125.118 E.00185
G1 X130.299 Y125.118 E.04575
G1 X130.299 Y125.401 E.00445
G1 X130.581 Y125.401 E.00445
; OBJECT_ID: 6
; WIPE_START
G1 X130.299 Y125.401 E-.10711
G1 X130.299 Y125.118 E-.10725
G1 X128.863 Y125.118 E-.54564
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X128.863 Y125.024 Z1 F30000
G1 X132.507 Y124.596
G1 X141.493 Y123.308
G1 X143.429 Y123.276
G1 X144.189 Y123.072
G1 X144.436 Y122.698
G1 X144.475 Y122.896
G1 X144.74 Y122.843
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.843 E.03463
G1 X146.94 Y125.457 E.04116
G1 X144.74 Y125.457 E.03463
G1 X144.74 Y125.74 E.00445
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.457 E.00445
G1 X141.06 Y125.457 E.04565
G1 X141.06 Y122.843 E.04116
G1 X143.96 Y122.843 E.04565
G1 X143.96 Y122.265 E.00909
G1 X144.74 Y122.265 E.01228
G1 X144.74 Y122.783 E.00814
M204 S10000
G1 X144.581 Y122.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
G1 X144.299 Y122.605 E.00445
G1 X144.299 Y123.004 E.0063
G1 X144.401 Y123.004 E.00162
G1 X144.401 Y123.181 E.0028
G1 X146.601 Y123.181 E.03471
G1 X146.601 Y123.404 E.0035
G1 X141.399 Y123.404 E.08208
G1 X141.399 Y123.803 E.0063
G1 X146.601 Y123.803 E.08208
G1 X146.601 Y124.202 E.0063
G1 X141.399 Y124.202 E.08208
G1 X141.399 Y124.602 E.0063
G1 X146.601 Y124.602 E.08208
G1 X146.601 Y125.001 E.0063
G1 X141.399 Y125.001 E.08208
G1 X141.399 Y125.118 E.00185
G1 X144.299 Y125.118 E.04575
M73 P64 R10
G1 X144.299 Y125.401 E.00445
G1 X144.581 Y125.401 E.00445
; OBJECT_ID: 3
; WIPE_START
G1 X144.299 Y125.401 E-.10711
G1 X144.299 Y125.118 E-.10725
G1 X142.863 Y125.118 E-.54564
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X142.863 Y125.024 Z1 F30000
G1 X143.076 Y123.276
G1 X144.499 Y110.974
G1 X144.511 Y109.122
G1 X144.476 Y108.943
G1 X144.74 Y108.893
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.893 E.03463
G1 X146.94 Y111.407 E.03957
G1 X144.74 Y111.407 E.03463
G1 X144.74 Y111.74 E.00524
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.407 E.00524
G1 X141.06 Y111.407 E.04565
G1 X141.06 Y108.893 E.03957
G1 X143.96 Y108.893 E.04565
G1 X143.96 Y108.265 E.00988
G1 X144.74 Y108.265 E.01228
G1 X144.74 Y108.833 E.00893
M204 S10000
G1 X144.581 Y108.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
G1 X144.299 Y108.605 E.00445
G1 X144.299 Y109.004 E.0063
G1 X144.401 Y109.004 E.00162
G1 X144.401 Y109.232 E.00359
G1 X146.601 Y109.232 E.03471
G1 X146.601 Y109.404 E.00271
G1 X141.399 Y109.404 E.08208
G1 X141.399 Y109.803 E.0063
G1 X146.601 Y109.803 E.08208
G1 X146.601 Y110.202 E.0063
G1 X141.399 Y110.202 E.08208
G1 X141.399 Y110.602 E.0063
G1 X146.601 Y110.602 E.08208
G1 X146.601 Y111.001 E.0063
G1 X141.399 Y111.001 E.08208
G1 X141.399 Y111.068 E.00106
G1 X144.299 Y111.068 E.04575
G1 X144.299 Y111.401 E.00525
G1 X144.581 Y111.401 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X144.299 Y111.401 E-.10711
G1 X144.299 Y111.068 E-.12637
G1 X142.913 Y111.068 E-.52653
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X142.913 Y110.974 Z1 F30000
G1 X143.774 Y123.183
G1 X143.904 Y125.024
G1 X144.307 Y136.792
G1 X144.74 Y136.792
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.792 E.03463
G1 X146.94 Y139.508 E.04274
; object ids of layer 6 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer6 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.508 E.03463
G1 X144.74 Y139.74 E.00366
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.508 E.00366
G1 X141.06 Y139.508 E.04565
G1 X141.06 Y136.792 E.04274
G1 X143.96 Y136.792 E.04565
G1 X143.96 Y136.265 E.00829
G1 X144.74 Y136.265 E.01228
G1 X144.74 Y136.732 E.00735
M204 S10000
G1 X144.581 Y136.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
G1 X144.299 Y136.605 E.00445
G1 X144.299 Y137.004 E.0063
G1 X144.401 Y137.004 E.00162
G1 X144.401 Y137.131 E.002
G1 X146.601 Y137.131 E.03471
G1 X146.601 Y137.404 E.0043
G1 X141.399 Y137.404 E.08208
G1 X141.399 Y137.803 E.0063
G1 X146.601 Y137.803 E.08208
G1 X146.601 Y138.202 E.0063
G1 X141.399 Y138.202 E.08208
G1 X141.399 Y138.602 E.0063
G1 X146.601 Y138.602 E.08208
G1 X146.601 Y139.001 E.0063
G1 X141.399 Y139.001 E.08208
G1 X141.399 Y139.169 E.00264
G1 X144.299 Y139.169 E.04575
G1 X144.299 Y139.401 E.00366
G1 X144.581 Y139.401 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X144.299 Y139.401 E-.10711
G1 X144.299 Y139.169 E-.08812
G1 X142.813 Y139.169 E-.56477
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X142.813 Y139.075 Z1 F30000
G1 X141.493 Y138.909
G1 X130.307 Y136.792
G1 X130.74 Y136.792
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.792 E.03463
G1 X132.94 Y139.508 E.04274
G1 X130.74 Y139.508 E.03463
G1 X130.74 Y139.74 E.00366
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.508 E.00366
G1 X127.06 Y139.508 E.04565
G1 X127.06 Y136.792 E.04274
G1 X129.96 Y136.792 E.04565
G1 X129.96 Y136.265 E.00829
G1 X130.74 Y136.265 E.01228
G1 X130.74 Y136.732 E.00735
M204 S10000
G1 X130.581 Y136.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
G1 X130.299 Y136.605 E.00445
G1 X130.299 Y137.004 E.0063
G1 X130.401 Y137.004 E.00162
G1 X130.401 Y137.131 E.002
G1 X132.601 Y137.131 E.03471
G1 X132.601 Y137.404 E.0043
G1 X127.399 Y137.404 E.08208
G1 X127.399 Y137.803 E.0063
G1 X132.601 Y137.803 E.08208
G1 X132.601 Y138.202 E.0063
G1 X127.399 Y138.202 E.08208
G1 X127.399 Y138.602 E.0063
G1 X132.601 Y138.602 E.08208
G1 X132.601 Y139.001 E.0063
G1 X127.399 Y139.001 E.08208
G1 X127.399 Y139.169 E.00264
G1 X130.299 Y139.169 E.04575
G1 X130.299 Y139.401 E.00366
G1 X130.581 Y139.401 E.00445
; OBJECT_ID: 7
; WIPE_START
G1 X130.299 Y139.401 E-.10711
G1 X130.299 Y139.169 E-.08812
G1 X128.813 Y139.169 E-.56477
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X128.813 Y139.075 Z1 F30000
G1 X127.493 Y139.003
G1 X113.707 Y137.323
G1 X114.14 Y137.323
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.323 E.04407
G1 X116.94 Y138.677 E.02132
G1 X114.14 Y138.677 E.04407
G1 X114.14 Y139.357 E.0107
G1 X99.44 Y139.357 E.23139
G1 X99.44 Y139.884 E.00829
G1 X99.06 Y139.884 E.00598
G1 X99.06 Y136.116 E.0593
G1 X99.44 Y136.116 E.00598
G1 X99.44 Y136.643 E.00829
G1 X114.14 Y136.643 E.23139
G1 X114.14 Y137.263 E.00976
M204 S10000
G1 X113.979 Y137.026 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.026 E.24653
G1 X99.414 Y137.513 E.00824
G1 X113.786 Y137.513 E.24327
G1 X113.786 Y137.677 E.00277
G1 X116.586 Y137.677 E.04739
G1 X116.586 Y138 E.00548
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.487 E.00824
G1 X113.786 Y138.487 E.24327
G1 X113.786 Y138.974 E.00824
G1 X99.221 Y138.974 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.974 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.924 Z1 F30000
G1 X102.788 Y137.076
G1 X112.86 Y124.874
G1 X113.707 Y123.756
G1 X113.707 Y123.323
G1 X114.14 Y123.323
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.323 E.04407
G1 X116.94 Y124.677 E.02132
G1 X114.14 Y124.677 E.04407
G1 X114.14 Y125.307 E.00991
G1 X99.44 Y125.307 E.23139
G1 X99.44 Y125.884 E.00908
G1 X99.06 Y125.884 E.00598
G1 X99.06 Y122.116 E.0593
G1 X99.44 Y122.116 E.00598
G1 X99.44 Y122.693 E.00908
G1 X114.14 Y122.693 E.23139
G1 X114.14 Y123.263 E.00897
M204 S10000
G1 X113.979 Y123.066 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.066 E.24653
G1 X99.414 Y123.533 E.0079
G1 X113.786 Y123.533 E.24327
G1 X113.786 Y123.677 E.00243
G1 X116.586 Y123.677 E.04739
G1 X116.586 Y124 E.00548
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.467 E.0079
G1 X113.786 Y124.467 E.24327
G1 X113.786 Y124.934 E.0079
G1 X99.221 Y124.934 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.934 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.874 Z1 F30000
G1 X102.717 Y123.126
G1 X112.898 Y110.824
G1 X113.707 Y109.756
G1 X113.707 Y109.323
G1 X114.14 Y109.323
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.323 E.04407
G1 X116.94 Y110.677 E.02132
G1 X114.14 Y110.677 E.04407
G1 X114.14 Y111.256 E.00912
G1 X99.44 Y111.256 E.23139
G1 X99.44 Y111.884 E.00987
G1 X99.06 Y111.884 E.00598
G1 X99.06 Y108.116 E.0593
G1 X99.44 Y108.116 E.00598
G1 X99.44 Y108.744 E.00987
G1 X114.14 Y108.744 E.23139
G1 X114.14 Y109.263 E.00817
M204 S10000
G1 X113.979 Y109.106 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.106 E.24653
G1 X99.414 Y109.553 E.00756
G1 X113.786 Y109.553 E.24327
M73 P65 R10
G1 X113.786 Y109.677 E.00209
G1 X116.586 Y109.677 E.04739
G1 X116.586 Y110 E.00547
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.447 E.00756
G1 X113.786 Y110.447 E.24327
G1 X113.786 Y110.894 E.00756
G1 X99.221 Y110.894 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 0.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.894 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 7/28
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1 I1.217 J0 P1  F30000
G1 X101.221 Y110.83 Z1
G1 X116.507 Y109.854
G1 X130.227 Y108.921
G1 X130.43 Y108.694
G1 X130.476 Y108.936
G1 X130.74 Y108.886
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.886 E.03463
G1 X132.94 Y111.414 E.0398
M73 P65 R9
G1 X130.74 Y111.414 E.03463
G1 X130.74 Y111.74 E.00513
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.414 E.00513
G1 X127.06 Y111.414 E.04565
G1 X127.06 Y108.886 E.0398
G1 X129.96 Y108.886 E.04565
G1 X129.96 Y108.261 E.00984
G1 X130.74 Y108.261 E.01228
G1 X130.74 Y108.826 E.00889
M204 S10000
G1 X130.581 Y108.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X130.299 Y108.6 E.00445
G1 X130.299 Y109 E.00632
G1 X130.401 Y109 E.00162
G1 X130.401 Y109.225 E.00354
G1 X132.601 Y109.225 E.03476
G1 X132.601 Y109.4 E.00278
G1 X127.399 Y109.4 E.0822
G1 X127.399 Y109.8 E.00632
G1 X132.601 Y109.8 E.0822
G1 X132.601 Y110.2 E.00632
G1 X127.399 Y110.2 E.0822
G1 X127.399 Y110.6 E.00632
G1 X132.601 Y110.6 E.0822
G1 X132.601 Y111 E.00632
G1 X127.399 Y111 E.0822
G1 X127.399 Y111.075 E.00118
G1 X130.299 Y111.075 E.04582
G1 X130.299 Y111.4 E.00514
G1 X130.581 Y111.4 E.00445
; OBJECT_ID: 5
; WIPE_START
G1 X130.299 Y111.4 E-.10711
G1 X130.299 Y111.075 E-.12355
G1 X128.906 Y111.075 E-.52935
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X128.906 Y110.981 Z1.1 F30000
G1 X130.475 Y122.889
G1 X130.74 Y122.836
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.836 E.03463
G1 X132.94 Y125.464 E.04136
G1 X130.74 Y125.464 E.03463
G1 X130.74 Y125.74 E.00435
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.464 E.00435
G1 X127.06 Y125.464 E.04565
G1 X127.06 Y122.836 E.04136
G1 X129.96 Y122.836 E.04565
G1 X129.96 Y122.261 E.00906
G1 X130.74 Y122.261 E.01228
G1 X130.74 Y122.776 E.00811
M204 S10000
G1 X130.581 Y122.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X130.299 Y122.6 E.00445
G1 X130.299 Y123 E.00632
G1 X130.401 Y123 E.00162
G1 X130.401 Y123.175 E.00276
G1 X132.601 Y123.175 E.03476
G1 X132.601 Y123.4 E.00356
G1 X127.399 Y123.4 E.0822
G1 X127.399 Y123.8 E.00632
G1 X132.601 Y123.8 E.0822
G1 X132.601 Y124.2 E.00632
G1 X127.399 Y124.2 E.0822
G1 X127.399 Y124.6 E.00632
G1 X132.601 Y124.6 E.0822
G1 X132.601 Y125 E.00632
G1 X127.399 Y125 E.0822
G1 X127.399 Y125.125 E.00197
G1 X130.299 Y125.125 E.04582
G1 X130.299 Y125.4 E.00435
G1 X130.581 Y125.4 E.00445
; OBJECT_ID: 6
; WIPE_START
M73 P66 R9
G1 X130.299 Y125.4 E-.10711
G1 X130.299 Y125.125 E-.10463
G1 X128.856 Y125.125 E-.54826
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X128.856 Y125.031 Z1.1 F30000
G1 X132.507 Y124.599
G1 X141.493 Y123.304
G1 X143.429 Y123.269
G1 X144.189 Y123.065
G1 X144.436 Y122.694
G1 X144.475 Y122.889
G1 X144.74 Y122.836
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.836 E.03463
G1 X146.94 Y125.464 E.04136
G1 X144.74 Y125.464 E.03463
G1 X144.74 Y125.74 E.00435
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.464 E.00435
G1 X141.06 Y125.464 E.04565
G1 X141.06 Y122.836 E.04136
G1 X143.96 Y122.836 E.04565
G1 X143.96 Y122.261 E.00906
G1 X144.74 Y122.261 E.01228
G1 X144.74 Y122.776 E.00811
M204 S10000
G1 X144.581 Y122.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X144.299 Y122.6 E.00445
G1 X144.299 Y123 E.00632
G1 X144.401 Y123 E.00162
G1 X144.401 Y123.175 E.00276
G1 X146.601 Y123.175 E.03476
G1 X146.601 Y123.4 E.00356
G1 X141.399 Y123.4 E.0822
G1 X141.399 Y123.8 E.00632
G1 X146.601 Y123.8 E.0822
G1 X146.601 Y124.2 E.00632
G1 X141.399 Y124.2 E.0822
G1 X141.399 Y124.6 E.00632
G1 X146.601 Y124.6 E.0822
G1 X146.601 Y125 E.00632
G1 X141.399 Y125 E.0822
G1 X141.399 Y125.125 E.00197
G1 X144.299 Y125.125 E.04582
G1 X144.299 Y125.4 E.00435
G1 X144.581 Y125.4 E.00445
; OBJECT_ID: 3
; WIPE_START
G1 X144.299 Y125.4 E-.10711
G1 X144.299 Y125.125 E-.10463
G1 X142.856 Y125.125 E-.54826
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X142.856 Y125.031 Z1.1 F30000
G1 X143.071 Y123.269
G1 X144.497 Y110.981
G1 X144.511 Y109.115
G1 X144.476 Y108.936
G1 X144.74 Y108.886
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.886 E.03463
G1 X146.94 Y111.414 E.0398
G1 X144.74 Y111.414 E.03463
G1 X144.74 Y111.74 E.00513
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.414 E.00513
G1 X141.06 Y111.414 E.04565
G1 X141.06 Y108.886 E.0398
G1 X143.96 Y108.886 E.04565
G1 X143.96 Y108.261 E.00984
G1 X144.74 Y108.261 E.01228
G1 X144.74 Y108.826 E.00889
M204 S10000
G1 X144.581 Y108.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X144.299 Y108.6 E.00445
G1 X144.299 Y109 E.00632
G1 X144.401 Y109 E.00162
G1 X144.401 Y109.225 E.00354
G1 X146.601 Y109.225 E.03476
G1 X146.601 Y109.4 E.00278
G1 X141.399 Y109.4 E.0822
G1 X141.399 Y109.8 E.00632
G1 X146.601 Y109.8 E.0822
G1 X146.601 Y110.2 E.00632
G1 X141.399 Y110.2 E.0822
G1 X141.399 Y110.6 E.00632
G1 X146.601 Y110.6 E.0822
G1 X146.601 Y111 E.00632
G1 X141.399 Y111 E.0822
G1 X141.399 Y111.075 E.00118
G1 X144.299 Y111.075 E.04582
G1 X144.299 Y111.4 E.00514
G1 X144.581 Y111.4 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X144.299 Y111.4 E-.10711
G1 X144.299 Y111.075 E-.12355
G1 X142.906 Y111.075 E-.52935
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X142.906 Y110.981 Z1.1 F30000
G1 X143.769 Y123.178
G1 X143.901 Y125.031
G1 X144.307 Y136.786
G1 X144.74 Y136.786
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.786 E.03463
G1 X146.94 Y139.514 E.04294
; object ids of layer 7 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer7 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.514 E.03463
G1 X144.74 Y139.74 E.00356
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.514 E.00356
G1 X141.06 Y139.514 E.04565
G1 X141.06 Y136.786 E.04294
G1 X143.96 Y136.786 E.04565
G1 X143.96 Y136.261 E.00827
G1 X144.74 Y136.261 E.01228
G1 X144.74 Y136.726 E.00733
M204 S10000
G1 X144.581 Y136.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X144.299 Y136.6 E.00445
G1 X144.299 Y137 E.00632
G1 X144.401 Y137 E.00162
G1 X144.401 Y137.125 E.00197
G1 X146.601 Y137.125 E.03476
G1 X146.601 Y137.4 E.00435
G1 X141.399 Y137.4 E.0822
G1 X141.399 Y137.8 E.00632
G1 X146.601 Y137.8 E.0822
G1 X146.601 Y138.2 E.00632
G1 X141.399 Y138.2 E.0822
G1 X141.399 Y138.6 E.00632
G1 X146.601 Y138.6 E.0822
G1 X146.601 Y139 E.00632
G1 X141.399 Y139 E.0822
G1 X141.399 Y139.175 E.00276
G1 X144.299 Y139.175 E.04582
G1 X144.299 Y139.4 E.00356
G1 X144.581 Y139.4 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X144.299 Y139.4 E-.10711
G1 X144.299 Y139.175 E-.08565
G1 X142.806 Y139.175 E-.56725
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X142.806 Y139.081 Z1.1 F30000
G1 X141.493 Y138.915
G1 X130.307 Y136.786
G1 X130.74 Y136.786
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.786 E.03463
G1 X132.94 Y139.514 E.04294
G1 X130.74 Y139.514 E.03463
G1 X130.74 Y139.74 E.00356
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.514 E.00356
G1 X127.06 Y139.514 E.04565
G1 X127.06 Y136.786 E.04294
G1 X129.96 Y136.786 E.04565
G1 X129.96 Y136.261 E.00827
G1 X130.74 Y136.261 E.01228
G1 X130.74 Y136.726 E.00733
M204 S10000
G1 X130.581 Y136.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X130.299 Y136.6 E.00445
G1 X130.299 Y137 E.00632
G1 X130.401 Y137 E.00162
G1 X130.401 Y137.125 E.00197
G1 X132.601 Y137.125 E.03476
G1 X132.601 Y137.4 E.00435
G1 X127.399 Y137.4 E.0822
G1 X127.399 Y137.8 E.00632
G1 X132.601 Y137.8 E.0822
G1 X132.601 Y138.2 E.00632
G1 X127.399 Y138.2 E.0822
G1 X127.399 Y138.6 E.00632
G1 X132.601 Y138.6 E.0822
G1 X132.601 Y139 E.00632
G1 X127.399 Y139 E.0822
G1 X127.399 Y139.175 E.00276
G1 X130.299 Y139.175 E.04582
G1 X130.299 Y139.4 E.00356
G1 X130.581 Y139.4 E.00445
; OBJECT_ID: 7
; WIPE_START
G1 X130.299 Y139.4 E-.10711
G1 X130.299 Y139.175 E-.08565
G1 X128.806 Y139.175 E-.56725
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X128.806 Y139.081 Z1.1 F30000
G1 X127.493 Y139.008
G1 X113.707 Y137.312
G1 X114.14 Y137.312
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.312 E.04407
G1 X116.94 Y138.688 E.02166
G1 X114.14 Y138.688 E.04407
G1 X114.14 Y139.364 E.01063
G1 X99.44 Y139.364 E.23139
G1 X99.44 Y139.889 E.00827
G1 X99.06 Y139.889 E.00598
G1 X99.06 Y136.111 E.05946
G1 X99.44 Y136.111 E.00598
G1 X99.44 Y136.636 E.00827
G1 X114.14 Y136.636 E.23139
G1 X114.14 Y137.252 E.00969
M204 S10000
G1 X113.979 Y137.021 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.021 E.24653
G1 X99.414 Y137.51 E.00829
G1 X113.786 Y137.51 E.24327
G1 X113.786 Y137.666 E.00263
G1 X116.586 Y137.666 E.04739
G1 X116.586 Y138 E.00566
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.49 E.00829
G1 X113.786 Y138.49 E.24327
G1 X113.786 Y138.979 E.00829
M73 P67 R9
G1 X99.221 Y138.979 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.979 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.931 Z1.1 F30000
G1 X102.796 Y137.069
G1 X112.846 Y124.881
G1 X113.707 Y123.745
G1 X113.707 Y123.312
G1 X114.14 Y123.312
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.312 E.04407
G1 X116.94 Y124.688 E.02166
G1 X114.14 Y124.688 E.04407
G1 X114.14 Y125.313 E.00984
G1 X99.44 Y125.313 E.23139
G1 X99.44 Y125.889 E.00905
G1 X99.06 Y125.889 E.00598
G1 X99.06 Y122.111 E.05946
G1 X99.44 Y122.111 E.00598
G1 X99.44 Y122.687 E.00905
G1 X114.14 Y122.687 E.23139
G1 X114.14 Y123.252 E.0089
M204 S10000
G1 X113.979 Y123.061 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.061 E.24653
G1 X99.414 Y123.53 E.00795
G1 X113.786 Y123.53 E.24327
G1 X113.786 Y123.666 E.00229
G1 X116.586 Y123.666 E.04739
G1 X116.586 Y124 E.00566
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.47 E.00795
G1 X113.786 Y124.47 E.24327
G1 X113.786 Y124.939 E.00795
G1 X99.221 Y124.939 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.939 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.881 Z1.1 F30000
G1 X102.725 Y123.119
G1 X112.885 Y110.83
G1 X113.707 Y109.745
G1 X113.707 Y109.312
G1 X114.14 Y109.312
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.312 E.04407
G1 X116.94 Y110.688 E.02166
G1 X114.14 Y110.688 E.04407
G1 X114.14 Y111.263 E.00905
G1 X99.44 Y111.263 E.23139
G1 X99.44 Y111.889 E.00984
G1 X99.06 Y111.889 E.00598
G1 X99.06 Y108.111 E.05946
G1 X99.44 Y108.111 E.00598
G1 X99.44 Y108.737 E.00984
G1 X114.14 Y108.737 E.23139
G1 X114.14 Y109.252 E.00811
M204 S10000
G1 X113.979 Y109.101 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.101 E.24653
G1 X99.414 Y109.551 E.00761
G1 X113.786 Y109.551 E.24327
G1 X113.786 Y109.666 E.00195
G1 X116.586 Y109.666 E.04739
G1 X116.586 Y110 E.00566
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.45 E.00761
G1 X113.786 Y110.45 E.24327
G1 X113.786 Y110.899 E.00761
G1 X99.221 Y110.899 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.899 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 8/28
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.1 I1.217 J0 P1  F30000
G1 X101.221 Y110.83 Z1.1
G1 X116.507 Y109.857
G1 X130.227 Y108.921
G1 X130.43 Y108.694
G1 X130.476 Y108.937
G1 X130.74 Y108.886
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.886 E.03463
G1 X132.94 Y111.414 E.03979
G1 X130.74 Y111.414 E.03463
G1 X130.74 Y111.74 E.00514
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.414 E.00514
G1 X127.06 Y111.414 E.04565
G1 X127.06 Y108.886 E.03979
G1 X129.96 Y108.886 E.04565
G1 X129.96 Y108.261 E.00984
G1 X130.74 Y108.261 E.01228
G1 X130.74 Y108.826 E.0089
M204 S10000
G1 X130.581 Y108.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X130.299 Y108.6 E.00445
G1 X130.299 Y109 E.00632
G1 X130.401 Y109 E.00162
G1 X130.401 Y109.225 E.00355
G1 X132.601 Y109.225 E.03476
G1 X132.601 Y109.4 E.00277
G1 X127.399 Y109.4 E.08219
G1 X127.399 Y109.8 E.00632
G1 X132.601 Y109.8 E.08219
G1 X132.601 Y110.2 E.00632
G1 X127.399 Y110.2 E.08219
G1 X127.399 Y110.6 E.00632
G1 X132.601 Y110.6 E.08219
G1 X132.601 Y111 E.00632
G1 X127.399 Y111 E.08219
G1 X127.399 Y111.075 E.00118
G1 X130.299 Y111.075 E.04582
G1 X130.299 Y111.4 E.00514
G1 X130.581 Y111.4 E.00445
; OBJECT_ID: 5
; WIPE_START
G1 X130.299 Y111.4 E-.10711
G1 X130.299 Y111.075 E-.12367
G1 X128.906 Y111.075 E-.52922
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X128.906 Y110.981 Z1.2 F30000
G1 X130.475 Y122.889
G1 X130.74 Y122.836
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.836 E.03463
G1 X132.94 Y125.464 E.04137
G1 X130.74 Y125.464 E.03463
M73 P68 R9
G1 X130.74 Y125.74 E.00435
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.464 E.00435
G1 X127.06 Y125.464 E.04565
G1 X127.06 Y122.836 E.04137
G1 X129.96 Y122.836 E.04565
G1 X129.96 Y122.261 E.00905
G1 X130.74 Y122.261 E.01228
G1 X130.74 Y122.776 E.00811
M204 S10000
G1 X130.581 Y122.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X130.299 Y122.6 E.00445
G1 X130.299 Y123 E.00632
G1 X130.401 Y123 E.00162
G1 X130.401 Y123.175 E.00275
G1 X132.601 Y123.175 E.03476
G1 X132.601 Y123.4 E.00357
G1 X127.399 Y123.4 E.08219
G1 X127.399 Y123.8 E.00632
G1 X132.601 Y123.8 E.08219
G1 X132.601 Y124.2 E.00632
G1 X127.399 Y124.2 E.08219
G1 X127.399 Y124.6 E.00632
G1 X132.601 Y124.6 E.08219
G1 X132.601 Y125 E.00632
G1 X127.399 Y125 E.08219
G1 X127.399 Y125.125 E.00197
G1 X130.299 Y125.125 E.04582
G1 X130.299 Y125.4 E.00435
G1 X130.581 Y125.4 E.00445
; OBJECT_ID: 6
; WIPE_START
G1 X130.299 Y125.4 E-.10711
G1 X130.299 Y125.125 E-.10461
G1 X128.856 Y125.125 E-.54828
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X128.856 Y125.031 Z1.2 F30000
G1 X132.507 Y124.599
G1 X141.493 Y123.304
G1 X143.429 Y123.269
G1 X144.189 Y123.065
G1 X144.436 Y122.694
G1 X144.475 Y122.889
G1 X144.74 Y122.836
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.836 E.03463
G1 X146.94 Y125.464 E.04137
G1 X144.74 Y125.464 E.03463
G1 X144.74 Y125.74 E.00435
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.464 E.00435
G1 X141.06 Y125.464 E.04565
G1 X141.06 Y122.836 E.04137
G1 X143.96 Y122.836 E.04565
G1 X143.96 Y122.261 E.00905
G1 X144.74 Y122.261 E.01228
G1 X144.74 Y122.776 E.00811
M204 S10000
G1 X144.581 Y122.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X144.299 Y122.6 E.00445
G1 X144.299 Y123 E.00632
G1 X144.401 Y123 E.00162
G1 X144.401 Y123.175 E.00275
G1 X146.601 Y123.175 E.03476
G1 X146.601 Y123.4 E.00357
G1 X141.399 Y123.4 E.08219
G1 X141.399 Y123.8 E.00632
G1 X146.601 Y123.8 E.08219
G1 X146.601 Y124.2 E.00632
G1 X141.399 Y124.2 E.08219
G1 X141.399 Y124.6 E.00632
G1 X146.601 Y124.6 E.08219
G1 X146.601 Y125 E.00632
G1 X141.399 Y125 E.08219
G1 X141.399 Y125.125 E.00197
G1 X144.299 Y125.125 E.04582
G1 X144.299 Y125.4 E.00435
G1 X144.581 Y125.4 E.00445
; OBJECT_ID: 3
; WIPE_START
G1 X144.299 Y125.4 E-.10711
G1 X144.299 Y125.125 E-.10461
G1 X142.856 Y125.125 E-.54828
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X142.856 Y125.031 Z1.2 F30000
M73 P68 R8
G1 X143.071 Y123.269
G1 X144.497 Y110.981
G1 X144.511 Y109.116
G1 X144.476 Y108.937
G1 X144.74 Y108.886
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.886 E.03463
G1 X146.94 Y111.414 E.03979
G1 X144.74 Y111.414 E.03463
G1 X144.74 Y111.74 E.00514
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.414 E.00514
G1 X141.06 Y111.414 E.04565
G1 X141.06 Y108.886 E.03979
G1 X143.96 Y108.886 E.04565
G1 X143.96 Y108.261 E.00984
G1 X144.74 Y108.261 E.01228
G1 X144.74 Y108.826 E.0089
M204 S10000
G1 X144.581 Y108.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X144.299 Y108.6 E.00445
G1 X144.299 Y109 E.00632
G1 X144.401 Y109 E.00162
G1 X144.401 Y109.225 E.00355
G1 X146.601 Y109.225 E.03476
G1 X146.601 Y109.4 E.00277
G1 X141.399 Y109.4 E.08219
G1 X141.399 Y109.8 E.00632
G1 X146.601 Y109.8 E.08219
G1 X146.601 Y110.2 E.00632
G1 X141.399 Y110.2 E.08219
G1 X141.399 Y110.6 E.00632
G1 X146.601 Y110.6 E.08219
G1 X146.601 Y111 E.00632
G1 X141.399 Y111 E.08219
G1 X141.399 Y111.075 E.00118
G1 X144.299 Y111.075 E.04582
G1 X144.299 Y111.4 E.00514
G1 X144.581 Y111.4 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X144.299 Y111.4 E-.10711
G1 X144.299 Y111.075 E-.12367
G1 X142.906 Y111.075 E-.52922
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X142.906 Y110.981 Z1.2 F30000
G1 X143.769 Y123.178
G1 X143.902 Y125.031
G1 X144.307 Y136.786
G1 X144.74 Y136.786
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.786 E.03463
G1 X146.94 Y139.514 E.04295
; object ids of layer 8 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer8 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.514 E.03463
G1 X144.74 Y139.74 E.00355
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.514 E.00355
G1 X141.06 Y139.514 E.04565
G1 X141.06 Y136.786 E.04295
G1 X143.96 Y136.786 E.04565
G1 X143.96 Y136.261 E.00826
G1 X144.74 Y136.261 E.01228
G1 X144.74 Y136.726 E.00732
M204 S10000
G1 X144.581 Y136.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X144.299 Y136.6 E.00445
G1 X144.299 Y137 E.00632
G1 X144.401 Y137 E.00162
G1 X144.401 Y137.125 E.00196
G1 X146.601 Y137.125 E.03476
G1 X146.601 Y137.4 E.00436
G1 X141.399 Y137.4 E.08219
G1 X141.399 Y137.8 E.00632
G1 X146.601 Y137.8 E.08219
G1 X146.601 Y138.2 E.00632
G1 X141.399 Y138.2 E.08219
G1 X141.399 Y138.6 E.00632
G1 X146.601 Y138.6 E.08219
G1 X146.601 Y139 E.00632
G1 X141.399 Y139 E.08219
G1 X141.399 Y139.175 E.00276
G1 X144.299 Y139.175 E.04582
G1 X144.299 Y139.4 E.00356
G1 X144.581 Y139.4 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X144.299 Y139.4 E-.10711
G1 X144.299 Y139.175 E-.08552
M73 P69 R8
G1 X142.806 Y139.175 E-.56737
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X142.806 Y139.081 Z1.2 F30000
G1 X141.493 Y138.915
G1 X130.307 Y136.786
G1 X130.74 Y136.786
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.786 E.03463
G1 X132.94 Y139.514 E.04295
G1 X130.74 Y139.514 E.03463
G1 X130.74 Y139.74 E.00355
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.514 E.00355
G1 X127.06 Y139.514 E.04565
G1 X127.06 Y136.786 E.04295
G1 X129.96 Y136.786 E.04565
G1 X129.96 Y136.261 E.00826
G1 X130.74 Y136.261 E.01228
G1 X130.74 Y136.726 E.00732
M204 S10000
G1 X130.581 Y136.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X130.299 Y136.6 E.00445
G1 X130.299 Y137 E.00632
G1 X130.401 Y137 E.00162
G1 X130.401 Y137.125 E.00196
G1 X132.601 Y137.125 E.03476
G1 X132.601 Y137.4 E.00436
G1 X127.399 Y137.4 E.08219
G1 X127.399 Y137.8 E.00632
G1 X132.601 Y137.8 E.08219
G1 X132.601 Y138.2 E.00632
G1 X127.399 Y138.2 E.08219
G1 X127.399 Y138.6 E.00632
G1 X132.601 Y138.6 E.08219
G1 X132.601 Y139 E.00632
G1 X127.399 Y139 E.08219
G1 X127.399 Y139.175 E.00276
G1 X130.299 Y139.175 E.04582
G1 X130.299 Y139.4 E.00356
G1 X130.581 Y139.4 E.00445
; OBJECT_ID: 7
; WIPE_START
G1 X130.299 Y139.4 E-.10711
G1 X130.299 Y139.175 E-.08552
G1 X128.806 Y139.175 E-.56737
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X128.806 Y139.081 Z1.2 F30000
G1 X127.493 Y139.009
G1 X113.707 Y137.312
G1 X114.14 Y137.312
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.312 E.04407
G1 X116.94 Y138.688 E.02165
G1 X114.14 Y138.688 E.04407
G1 X114.14 Y139.364 E.01064
G1 X99.44 Y139.364 E.23139
G1 X99.44 Y139.889 E.00827
G1 X99.06 Y139.889 E.00598
G1 X99.06 Y136.111 E.05947
G1 X99.44 Y136.111 E.00598
G1 X99.44 Y136.636 E.00827
G1 X114.14 Y136.636 E.23139
G1 X114.14 Y137.252 E.0097
M204 S10000
G1 X113.979 Y137.021 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.021 E.24653
G1 X99.414 Y137.51 E.00829
G1 X113.786 Y137.51 E.24327
G1 X113.786 Y137.666 E.00263
G1 X116.586 Y137.666 E.04739
G1 X116.586 Y138 E.00565
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.49 E.00829
G1 X113.786 Y138.49 E.24327
G1 X113.786 Y138.979 E.00829
G1 X99.221 Y138.979 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.979 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.931 Z1.2 F30000
G1 X102.796 Y137.069
G1 X112.847 Y124.881
G1 X113.707 Y123.745
G1 X113.707 Y123.312
G1 X114.14 Y123.312
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.312 E.04407
G1 X116.94 Y124.688 E.02165
G1 X114.14 Y124.688 E.04407
G1 X114.14 Y125.314 E.00985
G1 X99.44 Y125.314 E.23139
G1 X99.44 Y125.889 E.00906
G1 X99.06 Y125.889 E.00598
G1 X99.06 Y122.111 E.05947
G1 X99.44 Y122.111 E.00598
G1 X99.44 Y122.686 E.00906
G1 X114.14 Y122.686 E.23139
G1 X114.14 Y123.252 E.00891
M204 S10000
G1 X113.979 Y123.061 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.061 E.24653
G1 X99.414 Y123.53 E.00795
G1 X113.786 Y123.53 E.24327
G1 X113.786 Y123.666 E.00229
G1 X116.586 Y123.666 E.04739
G1 X116.586 Y124 E.00565
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.47 E.00795
G1 X113.786 Y124.47 E.24327
G1 X113.786 Y124.939 E.00795
G1 X99.221 Y124.939 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.939 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.881 Z1.2 F30000
G1 X102.726 Y123.119
G1 X112.885 Y110.83
G1 X113.707 Y109.745
G1 X113.707 Y109.312
G1 X114.14 Y109.312
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.312 E.04407
G1 X116.94 Y110.688 E.02165
G1 X114.14 Y110.688 E.04407
G1 X114.14 Y111.263 E.00906
G1 X99.44 Y111.263 E.23139
G1 X99.44 Y111.889 E.00985
G1 X99.06 Y111.889 E.00598
G1 X99.06 Y108.111 E.05947
G1 X99.44 Y108.111 E.00598
G1 X99.44 Y108.737 E.00985
G1 X114.14 Y108.737 E.23139
G1 X114.14 Y109.252 E.00811
M204 S10000
G1 X113.979 Y109.101 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.101 E.24653
G1 X99.414 Y109.551 E.00761
G1 X113.786 Y109.551 E.24327
G1 X113.786 Y109.666 E.00195
G1 X116.586 Y109.666 E.04739
G1 X116.586 Y110 E.00565
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.45 E.00761
G1 X113.786 Y110.45 E.24327
G1 X113.786 Y110.899 E.00761
G1 X99.221 Y110.899 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 0.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.899 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 9/28
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F30000
G1 X101.221 Y110.824 Z1.2
G1 X116.507 Y109.86
G1 X130.226 Y108.928
G1 X130.43 Y108.699
G1 X130.476 Y108.943
G1 X130.74 Y108.893
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.893 E.03463
G1 X132.94 Y111.407 E.03958
G1 X130.74 Y111.407 E.03463
G1 X130.74 Y111.74 E.00524
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.407 E.00524
G1 X127.06 Y111.407 E.04565
G1 X127.06 Y108.893 E.03958
G1 X129.96 Y108.893 E.04565
G1 X129.96 Y108.266 E.00987
G1 X130.74 Y108.266 E.01228
G1 X130.74 Y108.833 E.00892
M204 S10000
G1 X130.581 Y108.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X130.299 Y108.605 E.00445
G1 X130.299 Y109.004 E.0063
G1 X130.401 Y109.004 E.00162
G1 X130.401 Y109.231 E.00358
G1 X132.601 Y109.231 E.03471
G1 X132.601 Y109.404 E.00272
G1 X127.399 Y109.404 E.08207
G1 X127.399 Y109.803 E.0063
G1 X132.601 Y109.803 E.08207
G1 X132.601 Y110.203 E.0063
M73 P70 R8
G1 X127.399 Y110.203 E.08207
G1 X127.399 Y110.602 E.0063
G1 X132.601 Y110.602 E.08207
G1 X132.601 Y111.001 E.0063
G1 X127.399 Y111.001 E.08207
G1 X127.399 Y111.069 E.00106
G1 X130.299 Y111.069 E.04575
G1 X130.299 Y111.401 E.00524
G1 X130.581 Y111.401 E.00445
; OBJECT_ID: 5
; WIPE_START
G1 X130.299 Y111.401 E-.10711
G1 X130.299 Y111.069 E-.12624
G1 X128.913 Y111.069 E-.52666
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X128.913 Y110.974 Z1.3 F30000
G1 X130.475 Y122.896
G1 X130.74 Y122.843
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.843 E.03463
G1 X132.94 Y125.457 E.04115
G1 X130.74 Y125.457 E.03463
G1 X130.74 Y125.74 E.00445
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.457 E.00445
G1 X127.06 Y125.457 E.04565
G1 X127.06 Y122.843 E.04115
G1 X129.96 Y122.843 E.04565
G1 X129.96 Y122.266 E.00908
G1 X130.74 Y122.266 E.01228
G1 X130.74 Y122.783 E.00814
M204 S10000
G1 X130.581 Y122.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X130.299 Y122.605 E.00445
G1 X130.299 Y123.004 E.0063
G1 X130.401 Y123.004 E.00162
G1 X130.401 Y123.181 E.00279
G1 X132.601 Y123.181 E.03471
G1 X132.601 Y123.404 E.00351
G1 X127.399 Y123.404 E.08207
G1 X127.399 Y123.803 E.0063
G1 X132.601 Y123.803 E.08207
G1 X132.601 Y124.203 E.0063
G1 X127.399 Y124.203 E.08207
G1 X127.399 Y124.602 E.0063
G1 X132.601 Y124.602 E.08207
G1 X132.601 Y125.001 E.0063
G1 X127.399 Y125.001 E.08207
G1 X127.399 Y125.118 E.00185
G1 X130.299 Y125.118 E.04575
G1 X130.299 Y125.401 E.00445
G1 X130.581 Y125.401 E.00445
; OBJECT_ID: 6
; WIPE_START
G1 X130.299 Y125.401 E-.10711
G1 X130.299 Y125.118 E-.10728
G1 X128.863 Y125.118 E-.54562
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X128.863 Y125.024 Z1.3 F30000
G1 X132.507 Y124.596
G1 X141.493 Y123.308
G1 X143.429 Y123.276
G1 X144.189 Y123.072
G1 X144.436 Y122.699
G1 X144.475 Y122.896
G1 X144.74 Y122.843
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.843 E.03463
G1 X146.94 Y125.457 E.04115
G1 X144.74 Y125.457 E.03463
G1 X144.74 Y125.74 E.00445
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.457 E.00445
G1 X141.06 Y125.457 E.04565
G1 X141.06 Y122.843 E.04115
G1 X143.96 Y122.843 E.04565
G1 X143.96 Y122.266 E.00908
G1 X144.74 Y122.266 E.01228
G1 X144.74 Y122.783 E.00814
M204 S10000
G1 X144.581 Y122.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X144.299 Y122.605 E.00445
G1 X144.299 Y123.004 E.0063
G1 X144.401 Y123.004 E.00162
G1 X144.401 Y123.181 E.00279
G1 X146.601 Y123.181 E.03471
G1 X146.601 Y123.404 E.00351
G1 X141.399 Y123.404 E.08207
G1 X141.399 Y123.803 E.0063
G1 X146.601 Y123.803 E.08207
G1 X146.601 Y124.203 E.0063
G1 X141.399 Y124.203 E.08207
G1 X141.399 Y124.602 E.0063
G1 X146.601 Y124.602 E.08207
G1 X146.601 Y125.001 E.0063
G1 X141.399 Y125.001 E.08207
G1 X141.399 Y125.118 E.00185
G1 X144.299 Y125.118 E.04575
G1 X144.299 Y125.401 E.00445
G1 X144.581 Y125.401 E.00445
; OBJECT_ID: 3
; WIPE_START
G1 X144.299 Y125.401 E-.10711
G1 X144.299 Y125.118 E-.10728
G1 X142.863 Y125.118 E-.54562
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X142.863 Y125.024 Z1.3 F30000
G1 X143.076 Y123.276
G1 X144.499 Y110.974
G1 X144.511 Y109.122
G1 X144.476 Y108.943
G1 X144.74 Y108.893
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.893 E.03463
G1 X146.94 Y111.407 E.03958
G1 X144.74 Y111.407 E.03463
G1 X144.74 Y111.74 E.00524
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.407 E.00524
G1 X141.06 Y111.407 E.04565
G1 X141.06 Y108.893 E.03958
G1 X143.96 Y108.893 E.04565
G1 X143.96 Y108.266 E.00987
M73 P71 R8
G1 X144.74 Y108.266 E.01228
G1 X144.74 Y108.833 E.00892
M204 S10000
G1 X144.581 Y108.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X144.299 Y108.605 E.00445
G1 X144.299 Y109.004 E.0063
G1 X144.401 Y109.004 E.00162
G1 X144.401 Y109.231 E.00358
G1 X146.601 Y109.231 E.03471
G1 X146.601 Y109.404 E.00272
G1 X141.399 Y109.404 E.08207
G1 X141.399 Y109.803 E.0063
G1 X146.601 Y109.803 E.08207
G1 X146.601 Y110.203 E.0063
G1 X141.399 Y110.203 E.08207
G1 X141.399 Y110.602 E.0063
G1 X146.601 Y110.602 E.08207
G1 X146.601 Y111.001 E.0063
G1 X141.399 Y111.001 E.08207
G1 X141.399 Y111.069 E.00106
G1 X144.299 Y111.069 E.04575
G1 X144.299 Y111.401 E.00524
G1 X144.581 Y111.401 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X144.299 Y111.401 E-.10711
G1 X144.299 Y111.069 E-.12624
G1 X142.913 Y111.069 E-.52666
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X142.913 Y110.974 Z1.3 F30000
G1 X143.773 Y123.183
G1 X143.904 Y125.024
G1 X144.307 Y136.792
G1 X144.74 Y136.792
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.792 E.03463
G1 X146.94 Y139.507 E.04274
; object ids of layer 9 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer9 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.507 E.03463
G1 X144.74 Y139.74 E.00366
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.507 E.00366
G1 X141.06 Y139.507 E.04565
G1 X141.06 Y136.792 E.04274
G1 X143.96 Y136.792 E.04565
G1 X143.96 Y136.266 E.00829
G1 X144.74 Y136.266 E.01228
G1 X144.74 Y136.732 E.00735
M204 S10000
G1 X144.581 Y136.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X144.299 Y136.605 E.00445
G1 X144.299 Y137.004 E.0063
G1 X144.401 Y137.004 E.00162
G1 X144.401 Y137.131 E.002
G1 X146.601 Y137.131 E.03471
G1 X146.601 Y137.404 E.0043
G1 X141.399 Y137.404 E.08207
G1 X141.399 Y137.803 E.0063
G1 X146.601 Y137.803 E.08207
G1 X146.601 Y138.203 E.0063
G1 X141.399 Y138.203 E.08207
G1 X141.399 Y138.602 E.0063
G1 X146.601 Y138.602 E.08207
G1 X146.601 Y139.001 E.0063
G1 X141.399 Y139.001 E.08207
G1 X141.399 Y139.169 E.00264
G1 X144.299 Y139.169 E.04575
G1 X144.299 Y139.401 E.00366
G1 X144.581 Y139.401 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X144.299 Y139.401 E-.10711
G1 X144.299 Y139.169 E-.0882
G1 X142.813 Y139.169 E-.5647
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X142.813 Y139.075 Z1.3 F30000
G1 X141.493 Y138.909
G1 X130.307 Y136.792
G1 X130.74 Y136.792
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.792 E.03463
G1 X132.94 Y139.507 E.04274
G1 X130.74 Y139.507 E.03463
G1 X130.74 Y139.74 E.00366
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.507 E.00366
G1 X127.06 Y139.507 E.04565
G1 X127.06 Y136.792 E.04274
G1 X129.96 Y136.792 E.04565
G1 X129.96 Y136.266 E.00829
G1 X130.74 Y136.266 E.01228
G1 X130.74 Y136.732 E.00735
M204 S10000
G1 X130.581 Y136.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X130.299 Y136.605 E.00445
G1 X130.299 Y137.004 E.0063
G1 X130.401 Y137.004 E.00162
G1 X130.401 Y137.131 E.002
G1 X132.601 Y137.131 E.03471
G1 X132.601 Y137.404 E.0043
G1 X127.399 Y137.404 E.08207
G1 X127.399 Y137.803 E.0063
G1 X132.601 Y137.803 E.08207
G1 X132.601 Y138.203 E.0063
G1 X127.399 Y138.203 E.08207
G1 X127.399 Y138.602 E.0063
G1 X132.601 Y138.602 E.08207
G1 X132.601 Y139.001 E.0063
G1 X127.399 Y139.001 E.08207
G1 X127.399 Y139.169 E.00264
G1 X130.299 Y139.169 E.04575
G1 X130.299 Y139.401 E.00366
G1 X130.581 Y139.401 E.00445
; OBJECT_ID: 7
; WIPE_START
G1 X130.299 Y139.401 E-.10711
G1 X130.299 Y139.169 E-.0882
G1 X128.813 Y139.169 E-.5647
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X128.813 Y139.075 Z1.3 F30000
G1 X127.493 Y139.003
G1 X113.707 Y137.323
G1 X114.14 Y137.323
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.323 E.04407
G1 X116.94 Y138.677 E.0213
G1 X114.14 Y138.677 E.04407
G1 X114.14 Y139.358 E.01072
G1 X99.44 Y139.358 E.23139
G1 X99.44 Y139.884 E.00829
G1 X99.06 Y139.884 E.00598
G1 X99.06 Y136.116 E.05932
G1 X99.44 Y136.116 E.00598
G1 X99.44 Y136.642 E.00829
G1 X114.14 Y136.642 E.23139
G1 X114.14 Y137.263 E.00978
M204 S10000
G1 X113.979 Y137.026 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.026 E.24653
G1 X99.414 Y137.513 E.00825
G1 X113.786 Y137.513 E.24327
G1 X113.786 Y137.677 E.00278
G1 X116.586 Y137.677 E.04739
G1 X116.586 Y138 E.00546
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.487 E.00825
G1 X113.786 Y138.487 E.24327
G1 X113.786 Y138.975 E.00825
G1 X99.221 Y138.975 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.975 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.925 Z1.3 F30000
G1 X102.789 Y137.075
G1 X112.86 Y124.874
G1 X113.707 Y123.756
G1 X113.707 Y123.323
G1 X114.14 Y123.323
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.323 E.04407
G1 X116.94 Y124.677 E.0213
G1 X114.14 Y124.677 E.04407
G1 X114.14 Y125.307 E.00993
G1 X99.44 Y125.307 E.23139
G1 X99.44 Y125.884 E.00908
G1 X99.06 Y125.884 E.00598
G1 X99.06 Y122.116 E.05932
G1 X99.44 Y122.116 E.00598
G1 X99.44 Y122.693 E.00908
G1 X114.14 Y122.693 E.23139
G1 X114.14 Y123.263 E.00898
M204 S10000
G1 X113.979 Y123.066 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.066 E.24653
G1 X99.414 Y123.533 E.00791
G1 X113.786 Y123.533 E.24327
G1 X113.786 Y123.677 E.00244
G1 X116.586 Y123.677 E.04739
G1 X116.586 Y124 E.00546
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.467 E.00791
G1 X113.786 Y124.467 E.24327
G1 X113.786 Y124.934 E.00791
G1 X99.221 Y124.934 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.934 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.874 Z1.3 F30000
G1 X102.718 Y123.126
G1 X112.898 Y110.824
G1 X113.707 Y109.756
G1 X113.707 Y109.323
G1 X114.14 Y109.323
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.323 E.04407
G1 X116.94 Y110.677 E.0213
G1 X114.14 Y110.677 E.04407
G1 X114.14 Y111.256 E.00913
G1 X99.44 Y111.256 E.23139
G1 X99.44 Y111.884 E.00988
G1 X99.06 Y111.884 E.00598
G1 X99.06 Y108.116 E.05932
G1 X99.44 Y108.116 E.00598
G1 X99.44 Y108.744 E.00988
G1 X114.14 Y108.744 E.23139
G1 X114.14 Y109.263 E.00818
M204 S10000
G1 X113.979 Y109.106 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.106 E.24653
G1 X99.414 Y109.553 E.00756
G1 X113.786 Y109.553 E.24327
G1 X113.786 Y109.677 E.0021
G1 X116.586 Y109.677 E.04739
G1 X116.586 Y110 E.00546
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.447 E.00756
G1 X113.786 Y110.447 E.24327
G1 X113.786 Y110.894 E.00756
G1 X99.221 Y110.894 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.894 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 10/28
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.3 I1.217 J0 P1  F30000
G1 X101.221 Y110.81 Z1.3
G1 X116.507 Y109.865
G1 X130.226 Y108.941
G1 X130.429 Y108.708
G1 X130.477 Y108.957
G1 X130.74 Y108.907
G1 Z1
M73 P72 R8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.907 E.03463
G1 X132.94 Y111.393 E.03914
G1 X130.74 Y111.393 E.03463
G1 X130.74 Y111.74 E.00546
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.393 E.00546
M73 P72 R7
G1 X127.06 Y111.393 E.04565
G1 X127.06 Y108.907 E.03914
G1 X129.96 Y108.907 E.04565
G1 X129.96 Y108.275 E.00994
G1 X130.74 Y108.275 E.01228
G1 X130.74 Y108.847 E.009
M204 S10000
G1 X130.581 Y108.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X130.299 Y108.642 E.00507
G1 X130.299 Y109.097 E.00818
G1 X130.401 Y109.097 E.00184
G1 X130.401 Y109.245 E.00266
G1 X132.601 Y109.245 E.03955
G1 X132.601 Y109.552 E.00552
G1 X127.399 Y109.552 E.09352
G1 X127.399 Y110.008 E.00818
G1 X132.601 Y110.008 E.09352
G1 X132.601 Y110.463 E.00818
G1 X127.399 Y110.463 E.09352
G1 X127.399 Y110.918 E.00818
G1 X132.601 Y110.918 E.09352
G1 X132.601 Y111.055 E.00246
G1 X130.401 Y111.055 E.03955
G1 X130.401 Y111.373 E.00572
G1 X130.119 Y111.373 E.00507
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.373 E-.10711
G1 X130.401 Y111.055 E-.12101
G1 X131.801 Y111.055 E-.53189
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.801 Y110.96 Z1.4 F30000
G1 X130.475 Y122.909
G1 X130.74 Y122.856
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.856 E.03463
G1 X132.94 Y125.444 E.04074
G1 X130.74 Y125.444 E.03463
G1 X130.74 Y125.74 E.00466
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.444 E.00466
G1 X127.06 Y125.444 E.04565
G1 X127.06 Y122.856 E.04074
G1 X129.96 Y122.856 E.04565
G1 X129.96 Y122.275 E.00914
G1 X130.74 Y122.275 E.01228
G1 X130.74 Y122.796 E.0082
M204 S10000
G1 X130.581 Y122.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X130.299 Y122.642 E.00507
G1 X130.299 Y123.097 E.00818
G1 X130.401 Y123.097 E.00184
G1 X130.401 Y123.194 E.00175
G1 X132.601 Y123.194 E.03955
G1 X132.601 Y123.552 E.00643
G1 X127.399 Y123.552 E.09352
G1 X127.399 Y124.008 E.00818
G1 X132.601 Y124.008 E.09352
G1 X132.601 Y124.463 E.00818
G1 X127.399 Y124.463 E.09352
G1 X127.399 Y124.918 E.00818
G1 X132.601 Y124.918 E.09352
G1 X132.601 Y125.105 E.00337
G1 X130.401 Y125.105 E.03955
G1 X130.401 Y125.373 E.00481
G1 X130.119 Y125.373 E.00507
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.373 E-.10711
G1 X130.401 Y125.105 E-.10164
G1 X131.852 Y125.105 E-.55125
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.852 Y125.011 Z1.4 F30000
G1 X132.507 Y124.991
G1 X141.493 Y123.423
G1 X143.429 Y123.289
G1 X144.189 Y123.085
G1 X144.435 Y122.708
M73 P73 R7
G1 X144.475 Y122.909
G1 X144.74 Y122.856
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.856 E.03463
G1 X146.94 Y125.444 E.04074
G1 X144.74 Y125.444 E.03463
G1 X144.74 Y125.74 E.00466
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.444 E.00466
G1 X141.06 Y125.444 E.04565
G1 X141.06 Y122.856 E.04074
G1 X143.96 Y122.856 E.04565
G1 X143.96 Y122.275 E.00914
G1 X144.74 Y122.275 E.01228
G1 X144.74 Y122.796 E.0082
M204 S10000
G1 X144.581 Y122.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X144.299 Y122.642 E.00507
G1 X144.299 Y123.097 E.00818
G1 X144.401 Y123.097 E.00184
G1 X144.401 Y123.194 E.00175
G1 X146.601 Y123.194 E.03955
G1 X146.601 Y123.552 E.00643
G1 X141.399 Y123.552 E.09352
G1 X141.399 Y124.008 E.00818
G1 X146.601 Y124.008 E.09352
G1 X146.601 Y124.463 E.00818
G1 X141.399 Y124.463 E.09352
G1 X141.399 Y124.918 E.00818
G1 X146.601 Y124.918 E.09352
G1 X146.601 Y125.105 E.00337
G1 X144.401 Y125.105 E.03955
G1 X144.401 Y125.373 E.00481
G1 X144.119 Y125.373 E.00507
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.373 E-.10711
G1 X144.401 Y125.105 E-.10164
G1 X145.852 Y125.105 E-.55125
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.852 Y125.011 Z1.4 F30000
G1 X145.727 Y123.289
G1 X144.881 Y110.96
G1 X144.511 Y109.136
G1 X144.477 Y108.957
G1 X144.74 Y108.907
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.907 E.03463
G1 X146.94 Y111.393 E.03914
G1 X144.74 Y111.393 E.03463
G1 X144.74 Y111.74 E.00546
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.393 E.00546
G1 X141.06 Y111.393 E.04565
G1 X141.06 Y108.907 E.03914
G1 X143.96 Y108.907 E.04565
G1 X143.96 Y108.275 E.00994
G1 X144.74 Y108.275 E.01228
G1 X144.74 Y108.847 E.009
M204 S10000
G1 X144.581 Y108.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X144.299 Y108.642 E.00507
G1 X144.299 Y109.097 E.00818
G1 X144.401 Y109.097 E.00184
G1 X144.401 Y109.245 E.00266
G1 X146.601 Y109.245 E.03955
G1 X146.601 Y109.552 E.00552
G1 X141.399 Y109.552 E.09352
G1 X141.399 Y110.008 E.00818
G1 X146.601 Y110.008 E.09352
G1 X146.601 Y110.463 E.00818
G1 X141.399 Y110.463 E.09352
G1 X141.399 Y110.918 E.00818
G1 X146.601 Y110.918 E.09352
G1 X146.601 Y111.055 E.00246
G1 X144.401 Y111.055 E.03955
G1 X144.401 Y111.373 E.00572
G1 X144.119 Y111.373 E.00507
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.373 E-.10711
G1 X144.401 Y111.055 E-.12101
G1 X145.801 Y111.055 E-.53189
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.801 Y110.96 Z1.4 F30000
G1 X145.297 Y123.289
G1 X145.226 Y125.011
G1 X144.307 Y136.805
G1 X144.74 Y136.805
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.805 E.03463
G1 X146.94 Y139.495 E.04234
; object ids of layer 10 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer10 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.495 E.03463
G1 X144.74 Y139.74 E.00386
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.495 E.00386
G1 X141.06 Y139.495 E.04565
G1 X141.06 Y136.805 E.04234
G1 X143.96 Y136.805 E.04565
G1 X143.96 Y136.275 E.00834
G1 X144.74 Y136.275 E.01228
G1 X144.74 Y136.745 E.0074
M204 S10000
G1 X144.581 Y136.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X144.299 Y136.642 E.00507
G1 X144.299 Y137.097 E.00818
G1 X144.401 Y137.097 E.00184
G1 X144.401 Y137.144 E.00084
G1 X146.601 Y137.144 E.03955
G1 X146.601 Y137.552 E.00734
G1 X141.399 Y137.552 E.09352
G1 X141.399 Y138.008 E.00818
G1 X146.601 Y138.008 E.09352
G1 X146.601 Y138.463 E.00818
G1 X141.399 Y138.463 E.09352
G1 X141.399 Y138.918 E.00818
G1 X146.601 Y138.918 E.09352
G1 X146.601 Y139.156 E.00428
G1 X144.401 Y139.156 E.03955
G1 X144.401 Y139.373 E.0039
G1 X144.119 Y139.373 E.00507
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.373 E-.10711
G1 X144.401 Y139.156 E-.0824
G1 X145.903 Y139.156 E-.5705
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.903 Y139.062 Z1.4 F30000
G1 X141.493 Y138.472
G1 X130.307 Y136.805
G1 X130.74 Y136.805
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.805 E.03463
G1 X132.94 Y139.495 E.04234
G1 X130.74 Y139.495 E.03463
G1 X130.74 Y139.74 E.00386
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.495 E.00386
G1 X127.06 Y139.495 E.04565
G1 X127.06 Y136.805 E.04234
G1 X129.96 Y136.805 E.04565
G1 X129.96 Y136.275 E.00834
G1 X130.74 Y136.275 E.01228
G1 X130.74 Y136.745 E.0074
M204 S10000
G1 X130.581 Y136.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X130.299 Y136.642 E.00507
G1 X130.299 Y137.097 E.00818
G1 X130.401 Y137.097 E.00184
G1 X130.401 Y137.144 E.00084
G1 X132.601 Y137.144 E.03955
G1 X132.601 Y137.552 E.00734
G1 X127.399 Y137.552 E.09352
G1 X127.399 Y138.008 E.00818
G1 X132.601 Y138.008 E.09352
G1 X132.601 Y138.463 E.00818
G1 X127.399 Y138.463 E.09352
G1 X127.399 Y138.918 E.00818
G1 X132.601 Y138.918 E.09352
G1 X132.601 Y139.156 E.00428
G1 X130.401 Y139.156 E.03955
G1 X130.401 Y139.373 E.0039
G1 X130.119 Y139.373 E.00507
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.373 E-.10711
G1 X130.401 Y139.156 E-.0824
G1 X131.903 Y139.156 E-.5705
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.903 Y139.062 Z1.4 F30000
G1 X127.493 Y138.707
G1 X113.707 Y137.346
G1 X114.14 Y137.346
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.346 E.04407
G1 X116.94 Y138.654 E.02059
G1 X114.14 Y138.654 E.04407
G1 X114.14 Y139.345 E.01088
G1 X99.44 Y139.345 E.23139
G1 X99.44 Y139.874 E.00833
G1 X99.06 Y139.874 E.00598
G1 X99.06 Y136.126 E.05901
G1 X99.44 Y136.126 E.00598
G1 X99.44 Y136.655 E.00833
G1 X114.14 Y136.655 E.23139
G1 X114.14 Y137.286 E.00993
M204 S10000
G1 X113.979 Y137.036 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.036 E.24653
G1 X99.414 Y137.518 E.00816
G1 X113.786 Y137.518 E.24327
G1 X113.786 Y137.7 E.00308
G1 X116.586 Y137.7 E.04739
G1 X116.586 Y138 E.00508
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.482 E.00816
G1 X113.786 Y138.482 E.24327
G1 X113.786 Y138.964 E.00816
G1 X99.221 Y138.964 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.964 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.912 Z1.4 F30000
G1 X102.773 Y137.088
G1 X112.887 Y124.861
G1 X113.707 Y123.779
G1 X113.707 Y123.346
G1 X114.14 Y123.346
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.346 E.04407
G1 X116.94 Y124.654 E.02059
G1 X114.14 Y124.654 E.04407
G1 X114.14 Y125.294 E.01007
G1 X99.44 Y125.294 E.23139
G1 X99.44 Y125.874 E.00913
G1 X99.06 Y125.874 E.00598
G1 X99.06 Y122.126 E.05901
G1 X99.44 Y122.126 E.00598
G1 X99.44 Y122.706 E.00913
G1 X114.14 Y122.706 E.23139
G1 X114.14 Y123.286 E.00913
M204 S10000
G1 X113.979 Y123.076 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.076 E.24653
G1 X99.414 Y123.538 E.00782
G1 X113.786 Y123.538 E.24327
G1 X113.786 Y123.7 E.00273
G1 X116.586 Y123.7 E.04739
G1 X116.586 Y124 E.00508
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.462 E.00782
G1 X113.786 Y124.462 E.24327
G1 X113.786 Y124.924 E.00782
G1 X99.221 Y124.924 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.924 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.861 Z1.4 F30000
G1 X102.701 Y123.139
G1 X112.926 Y110.81
G1 X113.707 Y109.779
G1 X113.707 Y109.346
G1 X114.14 Y109.346
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.346 E.04407
G1 X116.94 Y110.654 E.02059
G1 X114.14 Y110.654 E.04407
G1 X114.14 Y111.243 E.00927
M73 P74 R7
G1 X99.44 Y111.243 E.23139
G1 X99.44 Y111.874 E.00994
G1 X99.06 Y111.874 E.00598
G1 X99.06 Y108.126 E.05901
G1 X99.44 Y108.126 E.00598
G1 X99.44 Y108.757 E.00994
G1 X114.14 Y108.757 E.23139
G1 X114.14 Y109.286 E.00832
M204 S10000
G1 X113.979 Y109.117 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.117 E.24653
G1 X99.414 Y109.559 E.00747
G1 X113.786 Y109.559 E.24327
G1 X113.786 Y109.7 E.00239
G1 X116.586 Y109.7 E.04739
G1 X116.586 Y110 E.00508
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.441 E.00747
G1 X113.786 Y110.441 E.24327
G1 X113.786 Y110.883 E.00747
G1 X99.221 Y110.883 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1.1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.883 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 11/28
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.4 I1.217 J0 P1  F30000
G1 X101.221 Y110.789 Z1.4
G1 X116.507 Y109.87
G1 X130.226 Y108.961
G1 X130.429 Y108.722
G1 X130.477 Y108.977
G1 X130.74 Y108.927
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.927 E.03463
G1 X132.94 Y111.373 E.0385
G1 X130.74 Y111.373 E.03463
G1 X130.74 Y111.74 E.00578
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.373 E.00578
G1 X127.06 Y111.373 E.04565
G1 X127.06 Y108.927 E.0385
G1 X129.96 Y108.927 E.04565
G1 X129.96 Y108.289 E.01004
G1 X130.74 Y108.289 E.01228
G1 X130.74 Y108.867 E.00909
M204 S10000
G1 X130.581 Y108.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
G1 F1200
M204 S1000
G1 X130.299 Y108.656 E.00504
G1 X130.299 Y109.109 E.00811
G1 X130.401 Y109.109 E.00183
G1 X130.401 Y109.266 E.00281
G1 X132.601 Y109.266 E.03937
G1 X132.601 Y109.562 E.00529
G1 X127.399 Y109.562 E.0931
G1 X127.399 Y110.015 E.00811
G1 X132.601 Y110.015 E.0931
G1 X132.601 Y110.468 E.00811
G1 X127.399 Y110.468 E.0931
G1 X127.399 Y110.921 E.00811
G1 X132.601 Y110.921 E.0931
G1 X132.601 Y111.034 E.00203
G1 X130.401 Y111.034 E.03937
G1 X130.401 Y111.374 E.00608
G1 X130.119 Y111.374 E.00504
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.374 E-.10711
G1 X130.401 Y111.034 E-.12915
G1 X131.78 Y111.034 E-.52375
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.78 Y110.94 Z1.5 F30000
G1 X130.476 Y122.929
G1 X130.74 Y122.876
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.876 E.03463
G1 X132.94 Y125.424 E.0401
G1 X130.74 Y125.424 E.03463
G1 X130.74 Y125.74 E.00498
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.424 E.00498
G1 X127.06 Y125.424 E.04565
G1 X127.06 Y122.876 E.0401
G1 X129.96 Y122.876 E.04565
G1 X129.96 Y122.289 E.00923
G1 X130.74 Y122.289 E.01228
G1 X130.74 Y122.816 E.00829
M204 S10000
G1 X130.581 Y122.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
G1 F1200
M204 S1000
G1 X130.299 Y122.656 E.00504
G1 X130.299 Y123.109 E.00811
G1 X130.401 Y123.109 E.00183
G1 X130.401 Y123.215 E.0019
G1 X132.601 Y123.215 E.03937
G1 X132.601 Y123.562 E.00621
G1 X127.399 Y123.562 E.0931
G1 X127.399 Y124.015 E.00811
G1 X132.601 Y124.015 E.0931
G1 X132.601 Y124.468 E.00811
G1 X127.399 Y124.468 E.0931
G1 X127.399 Y124.921 E.00811
G1 X132.601 Y124.921 E.0931
G1 X132.601 Y125.085 E.00294
G1 X130.401 Y125.085 E.03937
M73 P75 R7
G1 X130.401 Y125.374 E.00517
G1 X130.119 Y125.374 E.00504
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.374 E-.10711
G1 X130.401 Y125.085 E-.10976
G1 X131.831 Y125.085 E-.54314
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.831 Y124.991 Z1.5 F30000
G1 X132.507 Y124.969
G1 X141.493 Y123.432
G1 X143.429 Y123.309
G1 X144.189 Y123.105
G1 X144.435 Y122.722
G1 X144.476 Y122.929
G1 X144.74 Y122.876
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.876 E.03463
G1 X146.94 Y125.424 E.0401
G1 X144.74 Y125.424 E.03463
G1 X144.74 Y125.74 E.00498
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.424 E.00498
G1 X141.06 Y125.424 E.04565
G1 X141.06 Y122.876 E.0401
G1 X143.96 Y122.876 E.04565
G1 X143.96 Y122.289 E.00923
G1 X144.74 Y122.289 E.01228
G1 X144.74 Y122.816 E.00829
M204 S10000
G1 X144.581 Y122.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
G1 F1200
M204 S1000
G1 X144.299 Y122.656 E.00504
G1 X144.299 Y123.109 E.00811
G1 X144.401 Y123.109 E.00183
G1 X144.401 Y123.215 E.0019
G1 X146.601 Y123.215 E.03937
G1 X146.601 Y123.562 E.00621
G1 X141.399 Y123.562 E.0931
G1 X141.399 Y124.015 E.00811
G1 X146.601 Y124.015 E.0931
G1 X146.601 Y124.468 E.00811
G1 X141.399 Y124.468 E.0931
G1 X141.399 Y124.921 E.00811
G1 X146.601 Y124.921 E.0931
G1 X146.601 Y125.085 E.00294
G1 X144.401 Y125.085 E.03937
G1 X144.401 Y125.374 E.00517
G1 X144.119 Y125.374 E.00504
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.374 E-.10711
G1 X144.401 Y125.085 E-.10976
G1 X145.831 Y125.085 E-.54314
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.831 Y124.991 Z1.5 F30000
G1 X145.711 Y123.309
G1 X144.876 Y110.94
G1 X144.511 Y109.156
G1 X144.477 Y108.977
G1 X144.74 Y108.927
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.927 E.03463
G1 X146.94 Y111.373 E.0385
G1 X144.74 Y111.373 E.03463
G1 X144.74 Y111.74 E.00578
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.373 E.00578
G1 X141.06 Y111.373 E.04565
G1 X141.06 Y108.927 E.0385
G1 X143.96 Y108.927 E.04565
G1 X143.96 Y108.289 E.01004
G1 X144.74 Y108.289 E.01228
G1 X144.74 Y108.867 E.00909
M204 S10000
G1 X144.581 Y108.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
G1 F1200
M204 S1000
G1 X144.299 Y108.656 E.00504
G1 X144.299 Y109.109 E.00811
G1 X144.401 Y109.109 E.00183
G1 X144.401 Y109.266 E.00281
G1 X146.601 Y109.266 E.03937
G1 X146.601 Y109.562 E.00529
G1 X141.399 Y109.562 E.0931
G1 X141.399 Y110.015 E.00811
G1 X146.601 Y110.015 E.0931
G1 X146.601 Y110.468 E.00811
G1 X141.399 Y110.468 E.0931
G1 X141.399 Y110.921 E.00811
G1 X146.601 Y110.921 E.0931
G1 X146.601 Y111.034 E.00203
G1 X144.401 Y111.034 E.03937
G1 X144.401 Y111.374 E.00608
G1 X144.119 Y111.374 E.00504
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.374 E-.10711
G1 X144.401 Y111.034 E-.12915
G1 X145.78 Y111.034 E-.52375
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.78 Y110.94 Z1.5 F30000
G1 X145.285 Y123.309
G1 X145.217 Y124.991
G1 X144.474 Y136.88
G1 X144.74 Y136.825
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.825 E.03463
G1 X146.94 Y139.475 E.04172
; object ids of layer 11 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer11 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.475 E.03463
G1 X144.74 Y139.74 E.00417
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.475 E.00417
G1 X141.06 Y139.475 E.04565
G1 X141.06 Y136.825 E.04172
G1 X143.96 Y136.825 E.04565
G1 X143.96 Y136.289 E.00842
G1 X144.74 Y136.289 E.01228
G1 X144.74 Y136.765 E.00748
M204 S10000
G1 X144.581 Y136.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
M73 P75 R6
G1 F1200
M204 S1000
G1 X144.299 Y136.656 E.00504
G1 X144.299 Y137.109 E.00811
G1 X144.401 Y137.109 E.00183
G1 X144.401 Y137.163 E.00098
G1 X146.601 Y137.163 E.03937
G1 X146.601 Y137.562 E.00713
G1 X141.399 Y137.562 E.0931
G1 X141.399 Y138.015 E.00811
G1 X146.601 Y138.015 E.0931
G1 X146.601 Y138.468 E.00811
G1 X141.399 Y138.468 E.0931
G1 X141.399 Y138.921 E.00811
G1 X146.601 Y138.921 E.0931
G1 X146.601 Y139.136 E.00386
G1 X144.401 Y139.136 E.03937
G1 X144.401 Y139.374 E.00425
G1 X144.119 Y139.374 E.00504
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.374 E-.10711
G1 X144.401 Y139.136 E-.09024
G1 X145.882 Y139.136 E-.56265
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.882 Y139.042 Z1.5 F30000
G1 X141.493 Y138.466
G1 X130.474 Y136.88
G1 X130.74 Y136.825
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.825 E.03463
G1 X132.94 Y139.475 E.04172
G1 X130.74 Y139.475 E.03463
G1 X130.74 Y139.74 E.00417
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.475 E.00417
G1 X127.06 Y139.475 E.04565
G1 X127.06 Y136.825 E.04172
G1 X129.96 Y136.825 E.04565
G1 X129.96 Y136.289 E.00842
G1 X130.74 Y136.289 E.01228
G1 X130.74 Y136.765 E.00748
M204 S10000
G1 X130.581 Y136.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
G1 F1200
M204 S1000
G1 X130.299 Y136.656 E.00504
G1 X130.299 Y137.109 E.00811
G1 X130.401 Y137.109 E.00183
G1 X130.401 Y137.163 E.00098
G1 X132.601 Y137.163 E.03937
G1 X132.601 Y137.562 E.00713
G1 X127.399 Y137.562 E.0931
G1 X127.399 Y138.015 E.00811
G1 X132.601 Y138.015 E.0931
G1 X132.601 Y138.468 E.00811
G1 X127.399 Y138.468 E.0931
G1 X127.399 Y138.921 E.00811
G1 X132.601 Y138.921 E.0931
G1 X132.601 Y139.136 E.00386
G1 X130.401 Y139.136 E.03937
G1 X130.401 Y139.374 E.00425
G1 X130.119 Y139.374 E.00504
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.374 E-.10711
G1 X130.401 Y139.136 E-.09024
G1 X131.882 Y139.136 E-.56265
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.882 Y139.042 Z1.5 F30000
G1 X127.493 Y138.702
G1 X113.707 Y137.381
G1 X114.14 Y137.381
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.381 E.04407
G1 X116.94 Y138.619 E.01948
G1 X114.14 Y138.619 E.04407
G1 X114.14 Y139.325 E.01113
G1 X99.44 Y139.325 E.23139
G1 X99.44 Y139.86 E.00841
G1 X99.06 Y139.86 E.00598
G1 X99.06 Y136.14 E.05855
G1 X99.44 Y136.14 E.00598
G1 X99.44 Y136.675 E.00841
G1 X114.14 Y136.675 E.23139
G1 X114.14 Y137.321 E.01018
M204 S10000
G1 X113.979 Y137.051 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.051 E.24653
G1 X99.414 Y137.526 E.00803
G1 X113.786 Y137.526 E.24327
G1 X113.786 Y137.735 E.00355
G1 X116.586 Y137.735 E.04739
G1 X116.586 Y138 E.00448
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.474 E.00803
G1 X113.786 Y138.474 E.24327
G1 X113.786 Y138.949 E.00803
M73 P76 R6
G1 X99.221 Y138.949 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.949 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.893 Z1.5 F30000
G1 X102.749 Y137.107
G1 X112.928 Y124.841
G1 X113.707 Y123.814
G1 X113.707 Y123.381
G1 X114.14 Y123.381
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.381 E.04407
G1 X116.94 Y124.619 E.01948
G1 X114.14 Y124.619 E.04407
G1 X114.14 Y125.274 E.01032
G1 X99.44 Y125.274 E.23139
G1 X99.44 Y125.86 E.00922
G1 X99.06 Y125.86 E.00598
G1 X99.06 Y122.14 E.05855
G1 X99.44 Y122.14 E.00598
G1 X99.44 Y122.726 E.00922
G1 X114.14 Y122.726 E.23139
G1 X114.14 Y123.321 E.00937
M204 S10000
G1 X113.979 Y123.092 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.092 E.24653
G1 X99.414 Y123.546 E.00768
G1 X113.786 Y123.546 E.24327
G1 X113.786 Y123.735 E.0032
G1 X116.586 Y123.735 E.04739
G1 X116.586 Y124 E.00448
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.454 E.00768
G1 X113.786 Y124.454 E.24327
G1 X113.786 Y124.908 E.00768
G1 X99.221 Y124.908 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.908 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.841 Z1.5 F30000
G1 X102.676 Y123.159
G1 X112.969 Y110.789
G1 X113.707 Y109.814
G1 X113.707 Y109.381
G1 X114.14 Y109.381
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.381 E.04407
G1 X116.94 Y110.619 E.01948
G1 X114.14 Y110.619 E.04407
G1 X114.14 Y111.222 E.0095
G1 X99.44 Y111.222 E.23139
G1 X99.44 Y111.86 E.01004
G1 X99.06 Y111.86 E.00598
G1 X99.06 Y108.14 E.05855
G1 X99.44 Y108.14 E.00598
G1 X99.44 Y108.778 E.01004
G1 X114.14 Y108.778 E.23139
G1 X114.14 Y109.321 E.00855
M204 S10000
G1 X113.979 Y109.134 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.134 E.24653
G1 X99.414 Y109.567 E.00733
G1 X113.786 Y109.567 E.24327
G1 X113.786 Y109.735 E.00285
G1 X116.586 Y109.735 E.04739
G1 X116.586 Y110 E.00448
G1 X99.414 Y110 E.29066
G1 X99.414 Y110.433 E.00733
G1 X113.786 Y110.433 E.24327
G1 X113.786 Y110.866 E.00733
G1 X99.221 Y110.866 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.866 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 12/28
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.5 I1.217 J0 P1  F30000
G1 X101.221 Y110.761 Z1.5
G1 X116.507 Y109.877
G1 X130.242 Y108.988
G1 X130.511 Y109.185
G1 X130.667 Y109.227
G1 X130.74 Y108.956
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.956 E.03463
G1 X132.94 Y111.344 E.0376
G1 X130.74 Y111.344 E.03463
G1 X130.74 Y111.74 E.00623
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.344 E.00623
G1 X127.06 Y111.344 E.04565
G1 X127.06 Y108.956 E.0376
G1 X129.96 Y108.956 E.04565
G1 X129.96 Y108.309 E.01018
G1 X130.74 Y108.309 E.01228
G1 X130.74 Y108.896 E.00923
M204 S10000
G1 X130.581 Y108.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X130.299 Y108.674 E.00501
G1 X130.299 Y109.124 E.00801
G1 X130.401 Y109.124 E.00182
G1 X130.401 Y109.294 E.00303
G1 X132.601 Y109.294 E.03912
G1 X132.601 Y109.574 E.00498
G1 X127.399 Y109.574 E.09252
G1 X127.399 Y110.025 E.00801
G1 X132.601 Y110.025 E.09252
G1 X132.601 Y110.475 E.00801
G1 X127.399 Y110.475 E.09252
G1 X127.399 Y110.925 E.00801
G1 X132.601 Y110.925 E.09252
G1 X132.601 Y111.006 E.00143
G1 X130.401 Y111.006 E.03912
G1 X130.401 Y111.375 E.00658
G1 X130.119 Y111.375 E.00501
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.375 E-.10711
G1 X130.401 Y111.006 E-.14055
G1 X131.75 Y111.006 E-.51234
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.75 Y110.911 Z1.6 F30000
G1 X130.476 Y122.955
G1 X130.74 Y122.903
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.903 E.03463
G1 X132.94 Y125.397 E.03926
G1 X130.74 Y125.397 E.03463
G1 X130.74 Y125.74 E.0054
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.397 E.0054
G1 X127.06 Y125.397 E.04565
M73 P77 R6
G1 X127.06 Y122.903 E.03926
G1 X129.96 Y122.903 E.04565
G1 X129.96 Y122.309 E.00935
G1 X130.74 Y122.309 E.01228
G1 X130.74 Y122.843 E.0084
M204 S10000
G1 X130.581 Y122.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X130.299 Y122.674 E.00501
G1 X130.299 Y123.124 E.00801
G1 X130.401 Y123.124 E.00182
G1 X130.401 Y123.242 E.00209
G1 X132.601 Y123.242 E.03912
G1 X132.601 Y123.574 E.00592
G1 X127.399 Y123.574 E.09252
G1 X127.399 Y124.025 E.00801
G1 X132.601 Y124.025 E.09252
G1 X132.601 Y124.475 E.00801
G1 X127.399 Y124.475 E.09252
G1 X127.399 Y124.925 E.00801
G1 X132.601 Y124.925 E.09252
G1 X132.601 Y125.058 E.00237
G1 X130.401 Y125.058 E.03912
G1 X130.401 Y125.375 E.00564
G1 X130.119 Y125.375 E.00501
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.375 E-.10711
G1 X130.401 Y125.058 E-.12052
G1 X131.802 Y125.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.802 Y124.964 Z1.6 F30000
G1 X132.507 Y124.941
G1 X141.493 Y123.444
G1 X143.429 Y123.336
G1 X144.189 Y123.132
G1 X144.434 Y122.742
G1 X144.476 Y122.955
G1 X144.74 Y122.903
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.903 E.03463
G1 X146.94 Y125.397 E.03926
G1 X144.74 Y125.397 E.03463
G1 X144.74 Y125.74 E.0054
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.397 E.0054
G1 X141.06 Y125.397 E.04565
G1 X141.06 Y122.903 E.03926
G1 X143.96 Y122.903 E.04565
G1 X143.96 Y122.309 E.00935
G1 X144.74 Y122.309 E.01228
G1 X144.74 Y122.843 E.0084
M204 S10000
G1 X144.581 Y122.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X144.299 Y122.674 E.00501
G1 X144.299 Y123.124 E.00801
G1 X144.401 Y123.124 E.00182
G1 X144.401 Y123.242 E.00209
G1 X146.601 Y123.242 E.03912
G1 X146.601 Y123.574 E.00592
G1 X141.399 Y123.574 E.09252
G1 X141.399 Y124.025 E.00801
G1 X146.601 Y124.025 E.09252
G1 X146.601 Y124.475 E.00801
G1 X141.399 Y124.475 E.09252
G1 X141.399 Y124.925 E.00801
G1 X146.601 Y124.925 E.09252
G1 X146.601 Y125.058 E.00237
G1 X144.401 Y125.058 E.03912
G1 X144.401 Y125.375 E.00564
G1 X144.119 Y125.375 E.00501
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.375 E-.10711
G1 X144.401 Y125.058 E-.12052
G1 X145.802 Y125.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.802 Y124.964 Z1.6 F30000
G1 X145.689 Y123.336
G1 X144.869 Y110.911
G1 X145.271 Y109.389
G1 X144.667 Y109.227
G1 X144.74 Y108.956
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.956 E.03463
G1 X146.94 Y111.344 E.0376
G1 X144.74 Y111.344 E.03463
G1 X144.74 Y111.74 E.00623
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.344 E.00623
G1 X141.06 Y111.344 E.04565
G1 X141.06 Y108.956 E.0376
G1 X143.96 Y108.956 E.04565
G1 X143.96 Y108.309 E.01018
G1 X144.74 Y108.309 E.01228
G1 X144.74 Y108.896 E.00923
M204 S10000
G1 X144.581 Y108.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X144.299 Y108.674 E.00501
G1 X144.299 Y109.124 E.00801
G1 X144.401 Y109.124 E.00182
G1 X144.401 Y109.294 E.00303
G1 X146.601 Y109.294 E.03912
G1 X146.601 Y109.574 E.00498
G1 X141.399 Y109.574 E.09252
G1 X141.399 Y110.025 E.00801
G1 X146.601 Y110.025 E.09252
G1 X146.601 Y110.475 E.00801
G1 X141.399 Y110.475 E.09252
G1 X141.399 Y110.925 E.00801
G1 X146.601 Y110.925 E.09252
G1 X146.601 Y111.006 E.00143
G1 X144.401 Y111.006 E.03912
G1 X144.401 Y111.375 E.00658
G1 X144.119 Y111.375 E.00501
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.375 E-.10711
G1 X144.401 Y111.006 E-.14055
G1 X145.75 Y111.006 E-.51234
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.75 Y110.911 Z1.6 F30000
G1 X145.268 Y123.335
G1 X145.204 Y124.964
G1 X144.474 Y136.906
G1 X144.74 Y136.851
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.851 E.03463
G1 X146.94 Y139.449 E.0409
; object ids of layer 12 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer12 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.449 E.03463
G1 X144.74 Y139.74 E.00458
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.449 E.00458
G1 X141.06 Y139.449 E.04565
G1 X141.06 Y136.851 E.0409
G1 X143.96 Y136.851 E.04565
G1 X143.96 Y136.309 E.00853
G1 X144.74 Y136.309 E.01228
G1 X144.74 Y136.791 E.00758
M204 S10000
G1 X144.581 Y136.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X144.299 Y136.674 E.00501
G1 X144.299 Y137.124 E.00801
G1 X144.401 Y137.124 E.00182
G1 X144.401 Y137.19 E.00117
G1 X146.601 Y137.19 E.03912
G1 X146.601 Y137.574 E.00684
G1 X141.399 Y137.574 E.09252
G1 X141.399 Y138.025 E.00801
G1 X146.601 Y138.025 E.09252
G1 X146.601 Y138.475 E.00801
G1 X141.399 Y138.475 E.09252
G1 X141.399 Y138.925 E.00801
G1 X146.601 Y138.925 E.09252
G1 X146.601 Y139.11 E.00329
G1 X144.401 Y139.11 E.03912
G1 X144.401 Y139.375 E.00471
G1 X144.119 Y139.375 E.00501
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.375 E-.10711
G1 X144.401 Y139.11 E-.10073
G1 X145.854 Y139.11 E-.55217
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.854 Y139.016 Z1.6 F30000
G1 X141.493 Y138.458
G1 X130.474 Y136.906
G1 X130.74 Y136.851
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.851 E.03463
G1 X132.94 Y139.449 E.0409
G1 X130.74 Y139.449 E.03463
G1 X130.74 Y139.74 E.00458
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.449 E.00458
G1 X127.06 Y139.449 E.04565
G1 X127.06 Y136.851 E.0409
G1 X129.96 Y136.851 E.04565
G1 X129.96 Y136.309 E.00853
G1 X130.74 Y136.309 E.01228
G1 X130.74 Y136.791 E.00758
M204 S10000
G1 X130.581 Y136.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X130.299 Y136.674 E.00501
G1 X130.299 Y137.124 E.00801
G1 X130.401 Y137.124 E.00182
G1 X130.401 Y137.19 E.00117
G1 X132.601 Y137.19 E.03912
G1 X132.601 Y137.574 E.00684
M73 P78 R6
G1 X127.399 Y137.574 E.09252
G1 X127.399 Y138.025 E.00801
G1 X132.601 Y138.025 E.09252
G1 X132.601 Y138.475 E.00801
G1 X127.399 Y138.475 E.09252
G1 X127.399 Y138.925 E.00801
G1 X132.601 Y138.925 E.09252
G1 X132.601 Y139.11 E.00329
G1 X130.401 Y139.11 E.03912
G1 X130.401 Y139.375 E.00471
G1 X130.119 Y139.375 E.00501
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.375 E-.10711
G1 X130.401 Y139.11 E-.10073
G1 X131.854 Y139.11 E-.55217
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.854 Y139.016 Z1.6 F30000
G1 X127.493 Y138.697
G1 X114.14 Y137.839
G1 X114.14 Y137.432
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.432 E.04407
G1 X116.94 Y138.568 E.01789
G1 X114.14 Y138.568 E.04407
G1 X114.14 Y139.299 E.0115
G1 X99.44 Y139.299 E.23139
G1 X99.44 Y139.84 E.00852
G1 X99.06 Y139.84 E.00598
G1 X99.06 Y136.16 E.05794
G1 X99.44 Y136.16 E.00598
G1 X99.44 Y136.701 E.00852
G1 X114.14 Y136.701 E.23139
G1 X114.14 Y137.372 E.01056
M204 S10000
G1 X113.979 Y137.072 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.072 E.24653
G1 X99.414 Y137.536 E.00785
G1 X113.786 Y137.536 E.24327
G1 X113.786 Y137.785 E.00422
G1 X116.586 Y137.785 E.04739
G1 X116.586 Y138 E.00363
G1 X99.414 Y138 E.29066
G1 X99.414 Y138.464 E.00785
G1 X113.786 Y138.464 E.24327
G1 X113.786 Y138.928 E.00785
G1 X99.221 Y138.928 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X101.221 Y138.928 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X101.221 Y138.866 Z1.6 F30000
G1 X102.716 Y137.134
G1 X112.987 Y124.814
G1 X113.732 Y124.161
G1 X116.397 Y123.839
G1 X114.14 Y123.839
G1 X114.14 Y123.432
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.432 E.04407
G1 X116.94 Y124.568 E.01789
G1 X114.14 Y124.568 E.04407
G1 X114.14 Y125.247 E.01068
G1 X99.44 Y125.247 E.23139
G1 X99.44 Y125.84 E.00934
G1 X99.06 Y125.84 E.00598
G1 X99.06 Y122.16 E.05794
G1 X99.44 Y122.16 E.00598
G1 X99.44 Y122.753 E.00934
G1 X114.14 Y122.753 E.23139
G1 X114.14 Y123.372 E.00974
M204 S10000
G1 X113.979 Y123.114 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.114 E.24653
G1 X99.414 Y123.557 E.0075
G1 X113.786 Y123.557 E.24327
G1 X113.786 Y123.785 E.00387
G1 X116.586 Y123.785 E.04739
G1 X116.586 Y124 E.00363
G1 X99.414 Y124 E.29066
G1 X99.414 Y124.443 E.0075
G1 X113.786 Y124.443 E.24327
G1 X113.786 Y124.886 E.0075
G1 X99.221 Y124.886 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X101.221 Y124.886 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X101.221 Y124.814 Z1.6 F30000
G1 X102.642 Y123.186
G1 X113.029 Y110.761
G1 X113.732 Y110.161
G1 X116.397 Y109.839
G1 X114.14 Y109.839
G1 X114.14 Y109.432
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y109.432 E.04407
G1 X116.94 Y110.568 E.01789
G1 X114.14 Y110.568 E.04407
G1 X114.14 Y111.194 E.00985
G1 X99.44 Y111.194 E.23139
G1 X99.44 Y111.84 E.01018
G1 X99.06 Y111.84 E.00598
G1 X99.06 Y108.16 E.05794
G1 X99.44 Y108.16 E.00598
G1 X99.44 Y108.806 E.01018
G1 X114.14 Y108.806 E.23139
G1 X114.14 Y109.372 E.0089
M204 S10000
G1 X113.979 Y109.203 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.203 E.24653
G1 X99.414 Y109.717 E.0087
G1 X113.786 Y109.717 E.24327
G1 X113.786 Y109.785 E.00116
G1 X116.586 Y109.785 E.04739
G1 X116.586 Y110.215 E.00727
G1 X99.414 Y110.231 E.29066
G1 X99.414 Y110.746 E.0087
G1 X113.979 Y110.746 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X111.979 Y110.746 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 13/28
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.6 I1.217 J0 P1  F30000
G1 X111.979 Y110.725 Z1.6
G1 X113.755 Y110.579
G1 X130.238 Y109.038
G1 X130.511 Y109.221
G1 X130.667 Y109.263
G1 X130.74 Y108.991
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y108.991 E.03463
G1 X132.94 Y111.308 E.03647
G1 X130.74 Y111.308 E.03463
G1 X130.74 Y111.74 E.00679
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.308 E.00679
G1 X127.06 Y111.308 E.04565
G1 X127.06 Y108.991 E.03647
G1 X129.96 Y108.991 E.04565
G1 X129.96 Y108.334 E.01036
G1 X130.74 Y108.334 E.01228
G1 X130.74 Y108.931 E.00941
M204 S10000
G1 X130.581 Y108.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X130.299 Y108.697 E.00497
G1 X130.299 Y109.143 E.00788
G1 X130.401 Y109.143 E.00181
G1 X130.401 Y109.33 E.0033
G1 X132.601 Y109.33 E.03882
G1 X132.601 Y109.59 E.00458
G1 X127.399 Y109.59 E.0918
G1 X127.399 Y110.037 E.00788
G1 X132.601 Y110.037 E.0918
G1 X132.601 Y110.484 E.00788
G1 X127.399 Y110.484 E.0918
G1 X127.399 Y110.93 E.00788
G1 X132.601 Y110.93 E.0918
G1 X132.601 Y110.97 E.00069
G1 X130.401 Y110.97 E.03882
G1 X130.401 Y111.377 E.00719
G1 X130.119 Y111.377 E.00497
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.377 E-.10711
G1 X130.401 Y110.97 E-.15481
G1 X131.712 Y110.97 E-.49808
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X131.712 Y110.876 Z1.7 F30000
G1 X130.476 Y122.99
G1 X130.74 Y122.938
G1 Z1.3
M73 P79 R6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.938 E.03463
G1 X132.94 Y125.362 E.03815
G1 X130.74 Y125.362 E.03463
G1 X130.74 Y125.74 E.00595
M73 P79 R5
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.362 E.00595
G1 X127.06 Y125.362 E.04565
G1 X127.06 Y122.938 E.03815
G1 X129.96 Y122.938 E.04565
G1 X129.96 Y122.334 E.00951
G1 X130.74 Y122.334 E.01228
G1 X130.74 Y122.878 E.00857
M204 S10000
G1 X130.581 Y122.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X130.299 Y122.697 E.00497
G1 X130.299 Y123.143 E.00788
G1 X130.401 Y123.143 E.00181
G1 X130.401 Y123.277 E.00235
G1 X132.601 Y123.277 E.03882
G1 X132.601 Y123.59 E.00553
G1 X127.399 Y123.59 E.0918
G1 X127.399 Y124.037 E.00788
G1 X132.601 Y124.037 E.0918
G1 X132.601 Y124.484 E.00788
G1 X127.399 Y124.484 E.0918
G1 X127.399 Y124.93 E.00788
G1 X132.601 Y124.93 E.0918
G1 X132.601 Y125.023 E.00164
G1 X130.401 Y125.023 E.03882
G1 X130.401 Y125.377 E.00624
G1 X130.119 Y125.377 E.00497
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.377 E-.10711
G1 X130.401 Y125.023 E-.13449
G1 X131.765 Y125.023 E-.51841
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.765 Y124.929 Z1.7 F30000
G1 X132.507 Y124.904
G1 X141.493 Y123.46
G1 X143.429 Y123.371
G1 X144.189 Y123.167
G1 X144.432 Y122.766
G1 X144.476 Y122.989
G1 X144.74 Y122.938
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.938 E.03463
G1 X146.94 Y125.362 E.03815
G1 X144.74 Y125.362 E.03463
G1 X144.74 Y125.74 E.00595
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.362 E.00595
G1 X141.06 Y125.362 E.04565
G1 X141.06 Y122.938 E.03815
G1 X143.96 Y122.938 E.04565
G1 X143.96 Y122.334 E.00951
G1 X144.74 Y122.334 E.01228
G1 X144.74 Y122.878 E.00857
M204 S10000
G1 X144.581 Y122.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X144.299 Y122.697 E.00497
G1 X144.299 Y123.143 E.00788
G1 X144.401 Y123.143 E.00181
G1 X144.401 Y123.277 E.00235
G1 X146.601 Y123.277 E.03882
G1 X146.601 Y123.59 E.00553
G1 X141.399 Y123.59 E.0918
G1 X141.399 Y124.037 E.00788
G1 X146.601 Y124.037 E.0918
G1 X146.601 Y124.484 E.00788
G1 X141.399 Y124.484 E.0918
G1 X141.399 Y124.93 E.00788
G1 X146.601 Y124.93 E.0918
G1 X146.601 Y125.023 E.00164
G1 X144.401 Y125.023 E.03882
G1 X144.401 Y125.377 E.00624
G1 X144.119 Y125.377 E.00497
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.377 E-.10711
G1 X144.401 Y125.023 E-.13449
G1 X145.765 Y125.023 E-.51841
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.765 Y124.929 Z1.7 F30000
G1 X145.66 Y123.371
G1 X144.861 Y110.876
G1 X145.271 Y109.424
G1 X144.667 Y109.263
G1 X144.74 Y108.991
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y108.991 E.03463
G1 X146.94 Y111.308 E.03647
G1 X144.74 Y111.308 E.03463
G1 X144.74 Y111.74 E.00679
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.308 E.00679
G1 X141.06 Y111.308 E.04565
G1 X141.06 Y108.991 E.03647
G1 X143.96 Y108.991 E.04565
G1 X143.96 Y108.334 E.01036
G1 X144.74 Y108.334 E.01228
G1 X144.74 Y108.931 E.00941
M204 S10000
G1 X144.581 Y108.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X144.299 Y108.697 E.00497
G1 X144.299 Y109.143 E.00788
G1 X144.401 Y109.143 E.00181
G1 X144.401 Y109.33 E.0033
G1 X146.601 Y109.33 E.03882
G1 X146.601 Y109.59 E.00458
G1 X141.399 Y109.59 E.0918
G1 X141.399 Y110.037 E.00788
G1 X146.601 Y110.037 E.0918
G1 X146.601 Y110.484 E.00788
G1 X141.399 Y110.484 E.0918
G1 X141.399 Y110.93 E.00788
G1 X146.601 Y110.93 E.0918
G1 X146.601 Y110.97 E.00069
G1 X144.401 Y110.97 E.03882
G1 X144.401 Y111.377 E.00719
G1 X144.119 Y111.377 E.00497
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.377 E-.10711
G1 X144.401 Y110.97 E-.15481
G1 X145.712 Y110.97 E-.49808
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X145.712 Y110.876 Z1.7 F30000
G1 X145.247 Y123.364
G1 X145.188 Y124.929
G1 X144.475 Y136.939
G1 X144.74 Y136.884
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.884 E.03463
G1 X146.94 Y139.415 E.03984
; object ids of layer 13 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer13 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.415 E.03463
G1 X144.74 Y139.74 E.00511
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.415 E.00511
G1 X141.06 Y139.415 E.04565
G1 X141.06 Y136.884 E.03984
G1 X143.96 Y136.884 E.04565
G1 X143.96 Y136.334 E.00867
G1 X144.74 Y136.334 E.01228
G1 X144.74 Y136.824 E.00773
M204 S10000
G1 X144.581 Y136.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X144.299 Y136.697 E.00497
G1 X144.299 Y137.143 E.00788
G1 X144.401 Y137.143 E.00181
G1 X144.401 Y137.223 E.00141
G1 X146.601 Y137.223 E.03882
G1 X146.601 Y137.59 E.00647
G1 X141.399 Y137.59 E.0918
G1 X141.399 Y138.037 E.00788
G1 X146.601 Y138.037 E.0918
G1 X146.601 Y138.484 E.00788
G1 X141.399 Y138.484 E.0918
G1 X141.399 Y138.93 E.00788
G1 X146.601 Y138.93 E.0918
G1 X146.601 Y139.077 E.00258
G1 X144.401 Y139.077 E.03882
M73 P80 R5
G1 X144.401 Y139.377 E.0053
G1 X144.119 Y139.377 E.00497
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.377 E-.10711
G1 X144.401 Y139.077 E-.11414
G1 X145.819 Y139.077 E-.53875
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.819 Y138.983 Z1.7 F30000
G1 X141.493 Y138.448
G1 X130.475 Y136.939
G1 X130.74 Y136.884
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.884 E.03463
G1 X132.94 Y139.415 E.03984
G1 X130.74 Y139.415 E.03463
G1 X130.74 Y139.74 E.00511
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.415 E.00511
G1 X127.06 Y139.415 E.04565
G1 X127.06 Y136.884 E.03984
G1 X129.96 Y136.884 E.04565
G1 X129.96 Y136.334 E.00867
G1 X130.74 Y136.334 E.01228
G1 X130.74 Y136.824 E.00773
M204 S10000
G1 X130.581 Y136.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X130.299 Y136.697 E.00497
G1 X130.299 Y137.143 E.00788
G1 X130.401 Y137.143 E.00181
G1 X130.401 Y137.223 E.00141
G1 X132.601 Y137.223 E.03882
G1 X132.601 Y137.59 E.00647
G1 X127.399 Y137.59 E.0918
G1 X127.399 Y138.037 E.00788
G1 X132.601 Y138.037 E.0918
G1 X132.601 Y138.484 E.00788
G1 X127.399 Y138.484 E.0918
G1 X127.399 Y138.93 E.00788
G1 X132.601 Y138.93 E.0918
G1 X132.601 Y139.077 E.00258
G1 X130.401 Y139.077 E.03882
G1 X130.401 Y139.377 E.0053
G1 X130.119 Y139.377 E.00497
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.377 E-.10711
G1 X130.401 Y139.077 E-.11414
G1 X131.819 Y139.077 E-.53875
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.819 Y138.983 Z1.7 F30000
G1 X127.493 Y138.69
G1 X114.14 Y137.839
G1 X114.14 Y137.498
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.498 E.04407
G1 X116.94 Y138.502 E.01581
G1 X114.14 Y138.502 E.04407
G1 X114.14 Y139.265 E.01201
G1 X99.44 Y139.265 E.23139
G1 X99.44 Y139.816 E.00867
G1 X99.06 Y139.816 E.00598
G1 X99.06 Y136.184 E.05718
G1 X99.44 Y136.184 E.00598
G1 X99.44 Y136.735 E.00867
G1 X114.14 Y136.735 E.23139
G1 X114.14 Y137.438 E.01107
M204 S10000
G1 X113.979 Y137.099 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.099 E.24653
G1 X99.414 Y137.55 E.00762
G1 X113.58 Y137.55 E.23977
G1 X113.58 Y138 E.00762
G1 X99.414 Y138 E.23977
G1 X99.414 Y138.45 E.00762
G1 X113.58 Y138.45 E.23977
G1 X113.58 Y138.66 E.00355
G1 X113.786 Y138.66 E.0035
G1 X113.786 Y138.901 E.00407
G1 X99.221 Y138.901 E.24653
G1 E-.8 F1800
M204 S10000
G1 X106.839 Y138.434 Z1.7 F30000
G1 X113.933 Y138 Z1.7
G1 Z1.3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.6126
G1 F1200
M204 S1000
G1 X116.733 Y138 E.06537
; OBJECT_ID: 4
; WIPE_START
G1 X114.733 Y138 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X114.733 Y137.839 Z1.7 F30000
G1 X114.167 Y124.161
G1 X116.397 Y123.839
G1 X114.14 Y123.839
G1 X114.14 Y123.498
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.498 E.04407
G1 X116.94 Y124.502 E.01581
G1 X114.14 Y124.502 E.04407
G1 X114.14 Y125.212 E.01118
G1 X99.44 Y125.212 E.23139
G1 X99.44 Y125.816 E.00951
G1 X99.06 Y125.816 E.00598
G1 X99.06 Y122.184 E.05718
G1 X99.44 Y122.184 E.00598
G1 X99.44 Y122.788 E.00951
G1 X114.14 Y122.788 E.23139
G1 X114.14 Y123.438 E.01023
M204 S10000
G1 X113.979 Y123.142 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.142 E.24653
G1 X99.414 Y123.571 E.00726
G1 X113.58 Y123.571 E.23977
G1 X113.58 Y124 E.00726
G1 X99.414 Y124 E.23977
G1 X99.414 Y124.429 E.00726
G1 X113.58 Y124.429 E.23977
G1 X113.58 Y124.66 E.00391
G1 X113.786 Y124.66 E.0035
G1 X113.786 Y124.858 E.00335
G1 X99.221 Y124.858 E.24653
G1 E-.8 F1800
M204 S10000
G1 X106.84 Y124.414 Z1.7 F30000
G1 X113.933 Y124 Z1.7
G1 Z1.3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.6126
G1 F1200
M204 S1000
G1 X116.733 Y124 E.06537
; OBJECT_ID: 1
; WIPE_START
G1 X114.733 Y124 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X114.733 Y123.839 Z1.7 F30000
G1 X114.14 Y110.161
G1 X114.14 Y110.502
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y111.158 E.01032
G1 X99.44 Y111.158 E.23139
G1 X99.44 Y111.816 E.01037
G1 X99.06 Y111.816 E.00598
G1 X99.06 Y108.184 E.05718
G1 X99.44 Y108.184 E.00598
G1 X99.44 Y108.842 E.01037
G1 X114.14 Y108.842 E.23139
G1 X114.14 Y109.498 E.01032
G1 X116.94 Y109.498 E.04407
G1 X116.94 Y110.502 E.01581
G1 X114.2 Y110.502 E.04313
M204 S10000
G1 X113.979 Y110.764 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y110.764 E.24653
G1 X99.414 Y110.255 E.00862
G1 X113.58 Y110.255 E.23977
G1 X113.58 Y109.745 E.00862
G1 X99.414 Y109.745 E.23977
G1 X99.414 Y109.236 E.00862
G1 X113.979 Y109.236 E.24653
M204 S10000
G1 X113.933 Y110 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.6126
G1 F1200
M204 S1000
G1 X116.733 Y110 E.06537
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X114.733 Y110 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 14/28
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.7 I1.217 J0 P1  F30000
G1 X114.733 Y109.839 Z1.7
G1 X116.507 Y109.893
G1 X130.243 Y109.066
G1 X130.511 Y109.266
G1 X130.667 Y109.308
G1 X130.74 Y109.036
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.036 E.03463
G1 X132.94 Y111.264 E.03506
G1 X130.74 Y111.264 E.03463
G1 X130.74 Y111.74 E.0075
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.264 E.0075
G1 X127.06 Y111.264 E.04565
G1 X127.06 Y109.036 E.03506
G1 X129.96 Y109.036 E.04565
G1 X129.96 Y108.363 E.01059
G1 X130.74 Y108.363 E.01228
G1 X130.74 Y108.976 E.00965
M204 S10000
G1 X130.581 Y108.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X130.299 Y108.724 E.00493
G1 X130.299 Y109.167 E.00774
G1 X130.401 Y109.167 E.00179
G1 X130.401 Y109.375 E.00364
M73 P81 R5
G1 X132.601 Y109.375 E.03845
G1 X132.601 Y109.609 E.00409
G1 X127.399 Y109.609 E.09093
G1 X127.399 Y110.052 E.00774
G1 X132.601 Y110.052 E.09093
G1 X132.601 Y110.494 E.00774
G1 X127.399 Y110.494 E.09093
G1 X127.399 Y110.925 E.00753
G1 X130.401 Y110.937 E.05248
G1 X130.401 Y111.379 E.00774
G1 X130.119 Y111.379 E.00493
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.379 E-.10711
G1 X130.401 Y110.937 E-.16817
G1 X129.126 Y110.932 E-.48473
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X129.126 Y110.831 Z1.8 F30000
G1 X130.476 Y123.032
G1 X130.74 Y122.981
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y122.981 E.03463
G1 X132.94 Y125.319 E.03681
G1 X130.74 Y125.319 E.03463
G1 X130.74 Y125.74 E.00662
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.319 E.00662
G1 X127.06 Y125.319 E.04565
G1 X127.06 Y122.981 E.03681
G1 X129.96 Y122.981 E.04565
G1 X129.96 Y122.363 E.00972
G1 X130.74 Y122.363 E.01228
G1 X130.74 Y122.921 E.00877
M204 S10000
G1 X130.581 Y122.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X130.299 Y122.724 E.00493
G1 X130.299 Y123.167 E.00774
G1 X130.401 Y123.167 E.00179
G1 X130.401 Y123.319 E.00267
G1 X132.601 Y123.319 E.03845
G1 X132.601 Y123.609 E.00506
G1 X127.399 Y123.609 E.09093
G1 X127.399 Y124.052 E.00774
G1 X132.601 Y124.052 E.09093
G1 X132.601 Y124.494 E.00774
G1 X127.399 Y124.494 E.09093
G1 X127.399 Y124.937 E.00774
G1 X132.601 Y124.937 E.09093
G1 X132.601 Y124.981 E.00077
G1 X130.401 Y124.981 E.03845
G1 X130.401 Y125.379 E.00697
G1 X130.119 Y125.379 E.00493
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.379 E-.10711
G1 X130.401 Y124.981 E-.15151
G1 X131.721 Y124.981 E-.50139
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X131.721 Y124.886 Z1.8 F30000
G1 X132.507 Y124.86
G1 X141.493 Y123.479
G1 X143.429 Y123.414
G1 X144.189 Y123.21
G1 X144.431 Y122.796
G1 X144.476 Y123.031
G1 X144.74 Y122.981
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y122.981 E.03463
G1 X146.94 Y125.319 E.03681
G1 X144.74 Y125.319 E.03463
G1 X144.74 Y125.74 E.00662
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.319 E.00662
G1 X141.06 Y125.319 E.04565
G1 X141.06 Y122.981 E.03681
G1 X143.96 Y122.981 E.04565
G1 X143.96 Y122.363 E.00972
G1 X144.74 Y122.363 E.01228
G1 X144.74 Y122.921 E.00877
M204 S10000
G1 X144.581 Y122.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X144.299 Y122.724 E.00493
G1 X144.299 Y123.167 E.00774
G1 X144.401 Y123.167 E.00179
G1 X144.401 Y123.319 E.00267
G1 X146.601 Y123.319 E.03845
G1 X146.601 Y123.609 E.00506
G1 X141.399 Y123.609 E.09093
G1 X141.399 Y124.052 E.00774
G1 X146.601 Y124.052 E.09093
G1 X146.601 Y124.494 E.00774
G1 X141.399 Y124.494 E.09093
G1 X141.399 Y124.937 E.00774
G1 X146.601 Y124.937 E.09093
G1 X146.601 Y124.981 E.00077
G1 X144.401 Y124.981 E.03845
G1 X144.401 Y125.379 E.00697
G1 X144.119 Y125.379 E.00493
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.379 E-.10711
G1 X144.401 Y124.981 E-.15151
G1 X145.721 Y124.981 E-.50139
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X145.721 Y124.886 Z1.8 F30000
G1 X145.624 Y123.414
G1 X144.85 Y110.831
G1 X145.271 Y109.469
G1 X144.667 Y109.308
G1 X144.74 Y109.036
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.036 E.03463
G1 X146.94 Y111.264 E.03506
G1 X144.74 Y111.264 E.03463
G1 X144.74 Y111.74 E.0075
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.264 E.0075
G1 X141.06 Y111.264 E.04565
G1 X141.06 Y109.036 E.03506
G1 X143.96 Y109.036 E.04565
G1 X143.96 Y108.363 E.01059
G1 X144.74 Y108.363 E.01228
G1 X144.74 Y108.976 E.00965
M204 S10000
G1 X144.581 Y108.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X144.299 Y108.724 E.00493
G1 X144.299 Y109.167 E.00774
G1 X144.401 Y109.167 E.00179
G1 X144.401 Y109.375 E.00364
G1 X146.601 Y109.375 E.03845
G1 X146.601 Y109.609 E.00409
G1 X141.399 Y109.609 E.09093
G1 X141.399 Y110.052 E.00774
G1 X146.601 Y110.052 E.09093
G1 X146.601 Y110.494 E.00774
G1 X141.399 Y110.494 E.09093
G1 X141.399 Y110.925 E.00753
G1 X144.401 Y110.937 E.05248
G1 X144.401 Y111.379 E.00774
G1 X144.119 Y111.379 E.00493
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.379 E-.10711
G1 X144.401 Y110.937 E-.16817
G1 X143.126 Y110.932 E-.48473
; WIPE_END
M73 P82 R5
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X143.126 Y110.831 Z1.8 F30000
G1 X143.893 Y123.289
G1 X143.992 Y124.886
G1 X144.475 Y136.979
G1 X144.74 Y136.926
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.926 E.03463
G1 X146.94 Y139.374 E.03855
; object ids of layer 14 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer14 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.374 E.03463
G1 X144.74 Y139.74 E.00576
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.374 E.00576
G1 X141.06 Y139.374 E.04565
G1 X141.06 Y136.926 E.03855
G1 X143.96 Y136.926 E.04565
G1 X143.96 Y136.363 E.00885
G1 X144.74 Y136.363 E.01228
G1 X144.74 Y136.866 E.00791
M204 S10000
G1 X144.581 Y136.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X144.299 Y136.724 E.00493
G1 X144.299 Y137.167 E.00774
G1 X144.401 Y137.167 E.00179
G1 X144.401 Y137.264 E.00171
G1 X146.601 Y137.264 E.03845
G1 X146.601 Y137.609 E.00603
G1 X141.399 Y137.609 E.09093
G1 X141.399 Y138.052 E.00774
G1 X146.601 Y138.052 E.09093
G1 X146.601 Y138.494 E.00774
G1 X141.399 Y138.494 E.09093
G1 X141.399 Y138.937 E.00774
G1 X146.601 Y138.937 E.09093
G1 X146.601 Y139.036 E.00173
G1 X144.401 Y139.036 E.03845
G1 X144.401 Y139.379 E.00601
G1 X144.119 Y139.379 E.00493
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.379 E-.10711
G1 X144.401 Y139.036 E-.13058
G1 X145.776 Y139.036 E-.52232
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.776 Y138.941 Z1.8 F30000
G1 X141.493 Y138.435
G1 X130.475 Y136.979
G1 X130.74 Y136.926
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.926 E.03463
G1 X132.94 Y139.374 E.03855
G1 X130.74 Y139.374 E.03463
G1 X130.74 Y139.74 E.00576
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.374 E.00576
G1 X127.06 Y139.374 E.04565
G1 X127.06 Y136.926 E.03855
G1 X129.96 Y136.926 E.04565
G1 X129.96 Y136.363 E.00885
G1 X130.74 Y136.363 E.01228
G1 X130.74 Y136.866 E.00791
M204 S10000
G1 X130.581 Y136.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X130.299 Y136.724 E.00493
G1 X130.299 Y137.167 E.00774
G1 X130.401 Y137.167 E.00179
G1 X130.401 Y137.264 E.00171
G1 X132.601 Y137.264 E.03845
G1 X132.601 Y137.609 E.00603
G1 X127.399 Y137.609 E.09093
G1 X127.399 Y138.052 E.00774
G1 X132.601 Y138.052 E.09093
G1 X132.601 Y138.494 E.00774
G1 X127.399 Y138.494 E.09093
G1 X127.399 Y138.937 E.00774
G1 X132.601 Y138.937 E.09093
G1 X132.601 Y139.036 E.00173
G1 X130.401 Y139.036 E.03845
G1 X130.401 Y139.379 E.00601
G1 X130.119 Y139.379 E.00493
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.379 E-.10711
G1 X130.401 Y139.036 E-.13058
G1 X131.776 Y139.036 E-.52232
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.776 Y138.941 Z1.8 F30000
G1 X127.493 Y138.684
G1 X114.14 Y137.839
G1 X114.14 Y137.589
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.589 E.04407
G1 X116.94 Y138.411 E.01295
G1 X114.14 Y138.411 E.04407
G1 X114.14 Y139.224 E.0128
G1 X99.44 Y139.224 E.23139
G1 X99.44 Y139.787 E.00886
G1 X99.06 Y139.787 E.00598
G1 X99.06 Y136.213 E.05625
G1 X99.44 Y136.213 E.00598
G1 X99.44 Y136.776 E.00886
G1 X114.14 Y136.776 E.23139
G1 X114.14 Y137.529 E.01185
M204 S10000
G1 X113.979 Y137.132 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.132 E.24653
G1 X99.414 Y137.566 E.00734
G1 X113.58 Y137.566 E.23977
G1 X113.58 Y138 E.00734
G1 X99.414 Y138 E.23977
G1 X99.414 Y138.434 E.00734
G1 X113.58 Y138.434 E.23977
G1 X113.58 Y138.569 E.00229
G1 X113.786 Y138.569 E.0035
G1 X113.786 Y138.868 E.00506
G1 X99.221 Y138.868 E.24653
G1 E-.8 F1800
M204 S10000
G1 X106.84 Y138.418 Z1.8 F30000
G1 X113.933 Y138 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43044
G1 F1200
M204 S1000
G1 X116.733 Y138 E.04523
; OBJECT_ID: 4
; WIPE_START
G1 X114.733 Y138 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X114.733 Y137.839 Z1.8 F30000
G1 X114.164 Y124.161
G1 X116.397 Y123.839
G1 X114.14 Y123.839
G1 X114.14 Y123.589
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.589 E.04407
G1 X116.94 Y124.411 E.01295
G1 X114.14 Y124.411 E.04407
G1 X114.14 Y125.17 E.01194
G1 X99.44 Y125.17 E.23139
G1 X99.44 Y125.787 E.00972
G1 X99.06 Y125.787 E.00598
G1 X99.06 Y122.213 E.05625
G1 X99.44 Y122.213 E.00598
G1 X99.44 Y122.83 E.00972
G1 X114.14 Y122.83 E.23139
G1 X114.14 Y123.529 E.01099
M204 S10000
G1 X113.979 Y123.227 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.227 E.24653
G1 X99.414 Y123.741 E.0087
G1 X113.58 Y123.741 E.23977
G1 X113.58 Y124.256 E.0087
G1 X99.414 Y124.256 E.23977
G1 X99.414 Y124.77 E.0087
G1 X113.979 Y124.77 E.24653
M204 S10000
M73 P82 R4
G1 X113.933 Y124 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.43044
G1 F1200
M204 S1000
G1 X116.733 Y124 E.04523
; OBJECT_ID: 1
; WIPE_START
G1 X114.733 Y124 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X114.733 Y123.839 Z1.8 F30000
G1 X114.14 Y110.161
G1 X114.14 Y110.411
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y111.113 E.01105
G1 X99.44 Y111.113 E.23139
G1 X99.44 Y111.787 E.0106
G1 X99.06 Y111.787 E.00598
G1 X99.06 Y108.213 E.05625
G1 X99.44 Y108.213 E.00598
G1 X99.44 Y108.887 E.0106
G1 X114.14 Y108.887 E.23139
G1 X114.14 Y109.589 E.01105
G1 X116.94 Y109.589 E.04407
G1 X116.94 Y110.411 E.01295
G1 X114.2 Y110.411 E.04313
M204 S10000
G1 X113.979 Y110.73 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y110.73 E.24653
G1 X99.414 Y110.243 E.00824
G1 X113.58 Y110.243 E.23977
G1 X113.58 Y109.757 E.00824
G1 X99.414 Y109.757 E.23977
G1 X99.414 Y109.27 E.00824
G1 X113.979 Y109.27 E.24653
M204 S10000
G1 X113.933 Y110 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.43044
G1 F1200
M204 S1000
G1 X116.733 Y110 E.04523
; CHANGE_LAYER
; Z_HEIGHT: 1.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X114.733 Y110 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 15/28
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F30000
G1 X114.733 Y109.839 Z1.8
G1 X116.507 Y109.899
G1 X130.243 Y109.119
G1 X130.511 Y109.32
G1 X130.684 Y109.356
G1 X130.74 Y109.09
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.09 E.03463
G1 X132.94 Y111.21 E.03336
G1 X130.74 Y111.21 E.03463
G1 X130.74 Y111.74 E.00835
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.21 E.00835
G1 X127.06 Y111.21 E.04565
M73 P83 R4
G1 X127.06 Y109.09 E.03336
G1 X129.96 Y109.09 E.04565
G1 X129.96 Y108.399 E.01089
G1 X130.74 Y108.399 E.01228
G1 X130.74 Y109.03 E.00994
M204 S10000
G1 X130.581 Y108.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X130.299 Y108.757 E.00487
G1 X130.299 Y109.194 E.00756
G1 X130.401 Y109.194 E.00177
G1 X130.401 Y109.429 E.00405
G1 X132.601 Y109.429 E.03801
G1 X132.601 Y109.632 E.00351
G1 X127.399 Y109.632 E.08989
G1 X127.399 Y110.069 E.00756
G1 X132.601 Y110.069 E.08989
G1 X132.601 Y110.507 E.00756
G1 X127.399 Y110.507 E.08989
G1 X127.399 Y110.871 E.00629
G1 X130.299 Y110.871 E.05011
G1 X130.299 Y110.944 E.00127
G1 X130.401 Y110.944 E.00177
G1 X130.401 Y111.382 E.00756
G1 X130.119 Y111.382 E.00487
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.382 E-.10711
G1 X130.401 Y110.944 E-.16624
G1 X130.299 Y110.944 E-.03896
G1 X130.299 Y110.871 E-.0279
G1 X129.194 Y110.871 E-.4198
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X129.194 Y110.777 Z1.9 F30000
G1 X130.477 Y123.082
G1 X130.74 Y123.032
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.032 E.03463
G1 X132.94 Y125.267 E.03518
G1 X130.74 Y125.267 E.03463
G1 X130.74 Y125.74 E.00744
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.267 E.00744
G1 X127.06 Y125.267 E.04565
G1 X127.06 Y123.032 E.03518
G1 X129.96 Y123.032 E.04565
G1 X129.96 Y122.399 E.00998
G1 X130.74 Y122.399 E.01228
G1 X130.74 Y122.972 E.00903
M204 S10000
G1 X130.581 Y122.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X130.299 Y122.757 E.00487
G1 X130.299 Y123.194 E.00756
G1 X130.401 Y123.194 E.00177
G1 X130.401 Y123.371 E.00305
G1 X132.601 Y123.371 E.03801
G1 X132.601 Y123.632 E.00451
G1 X127.399 Y123.632 E.08989
G1 X127.399 Y124.069 E.00756
G1 X132.601 Y124.069 E.08989
G1 X132.601 Y124.507 E.00756
G1 X127.399 Y124.507 E.08989
G1 X127.399 Y124.929 E.00729
G1 X130.299 Y124.929 E.05011
G1 X130.299 Y124.944 E.00027
G1 X130.401 Y124.944 E.00177
G1 X130.401 Y125.382 E.00756
G1 X130.119 Y125.382 E.00487
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.382 E-.10711
G1 X130.401 Y124.944 E-.16623
G1 X130.299 Y124.944 E-.03896
G1 X130.299 Y124.929 E-.00591
G1 X129.136 Y124.929 E-.44179
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.136 Y124.835 Z1.9 F30000
G1 X132.507 Y124.519
G1 X144.221 Y123.096
G1 X144.429 Y122.832
G1 X144.477 Y123.082
G1 X144.74 Y123.032
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.032 E.03463
G1 X146.94 Y125.267 E.03518
G1 X144.74 Y125.267 E.03463
G1 X144.74 Y125.74 E.00744
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.267 E.00744
G1 X141.06 Y125.267 E.04565
G1 X141.06 Y123.032 E.03518
G1 X143.96 Y123.032 E.04565
G1 X143.96 Y122.399 E.00998
G1 X144.74 Y122.399 E.01228
G1 X144.74 Y122.972 E.00903
M204 S10000
G1 X144.581 Y122.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X144.299 Y122.757 E.00487
G1 X144.299 Y123.194 E.00756
G1 X144.401 Y123.194 E.00177
G1 X144.401 Y123.371 E.00305
G1 X146.601 Y123.371 E.03801
G1 X146.601 Y123.632 E.00451
G1 X141.399 Y123.632 E.08989
G1 X141.399 Y124.069 E.00756
G1 X146.601 Y124.069 E.08989
G1 X146.601 Y124.507 E.00756
G1 X141.399 Y124.507 E.08989
G1 X141.399 Y124.929 E.00729
G1 X144.299 Y124.929 E.05011
G1 X144.299 Y124.944 E.00027
G1 X144.401 Y124.944 E.00177
G1 X144.401 Y125.382 E.00756
G1 X144.119 Y125.382 E.00487
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.382 E-.10711
G1 X144.401 Y124.944 E-.16623
G1 X144.299 Y124.944 E-.03896
G1 X144.299 Y124.929 E-.00591
G1 X143.136 Y124.929 E-.44179
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.136 Y124.835 Z1.9 F30000
G1 X143.284 Y123.465
G1 X144.569 Y110.777
G1 X145.271 Y109.48
G1 X144.684 Y109.356
G1 X144.74 Y109.09
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.09 E.03463
G1 X146.94 Y111.21 E.03336
G1 X144.74 Y111.21 E.03463
G1 X144.74 Y111.74 E.00835
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.21 E.00835
G1 X141.06 Y111.21 E.04565
G1 X141.06 Y109.09 E.03336
G1 X143.96 Y109.09 E.04565
G1 X143.96 Y108.399 E.01089
G1 X144.74 Y108.399 E.01228
G1 X144.74 Y109.03 E.00994
M204 S10000
G1 X144.581 Y108.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X144.299 Y108.757 E.00487
G1 X144.299 Y109.194 E.00756
G1 X144.401 Y109.194 E.00177
G1 X144.401 Y109.429 E.00405
G1 X146.601 Y109.429 E.03801
G1 X146.601 Y109.632 E.00351
G1 X141.399 Y109.632 E.08989
M73 P84 R4
G1 X141.399 Y110.069 E.00756
G1 X146.601 Y110.069 E.08989
G1 X146.601 Y110.507 E.00756
G1 X141.399 Y110.507 E.08989
G1 X141.399 Y110.871 E.00629
G1 X144.299 Y110.871 E.05011
G1 X144.299 Y110.944 E.00127
G1 X144.401 Y110.944 E.00177
G1 X144.401 Y111.382 E.00756
G1 X144.119 Y111.382 E.00487
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.382 E-.10711
G1 X144.401 Y110.944 E-.16624
G1 X144.299 Y110.944 E-.03896
G1 X144.299 Y110.871 E-.0279
G1 X143.194 Y110.871 E-.4198
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X143.194 Y110.777 Z1.9 F30000
G1 X143.932 Y123.331
G1 X144.021 Y124.835
G1 X144.475 Y137.028
G1 X144.74 Y136.975
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y136.975 E.03463
G1 X146.94 Y139.324 E.03698
; object ids of layer 15 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer15 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.324 E.03463
G1 X144.74 Y139.74 E.00654
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.324 E.00654
G1 X141.06 Y139.324 E.04565
G1 X141.06 Y136.975 E.03698
G1 X143.96 Y136.975 E.04565
G1 X143.96 Y136.399 E.00908
G1 X144.74 Y136.399 E.01228
G1 X144.74 Y136.915 E.00813
M204 S10000
G1 X144.581 Y136.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X144.299 Y136.757 E.00487
G1 X144.299 Y137.194 E.00756
G1 X144.401 Y137.194 E.00177
G1 X144.401 Y137.314 E.00207
G1 X146.601 Y137.314 E.03801
G1 X146.601 Y137.632 E.00549
G1 X141.399 Y137.632 E.08989
G1 X141.399 Y138.069 E.00756
G1 X146.601 Y138.069 E.08989
G1 X146.601 Y138.507 E.00756
G1 X141.399 Y138.507 E.08989
G1 X141.399 Y138.944 E.00756
G1 X146.601 Y138.944 E.08989
G1 X146.601 Y138.986 E.00072
G1 X144.401 Y138.986 E.03801
G1 X144.401 Y139.382 E.00684
G1 X144.119 Y139.382 E.00487
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.382 E-.10711
G1 X144.401 Y138.986 E-.15048
G1 X145.723 Y138.986 E-.50241
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.723 Y138.892 Z1.9 F30000
G1 X141.493 Y138.418
G1 X130.475 Y137.028
G1 X130.74 Y136.975
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y136.975 E.03463
G1 X132.94 Y139.324 E.03698
G1 X130.74 Y139.324 E.03463
G1 X130.74 Y139.74 E.00654
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.324 E.00654
G1 X127.06 Y139.324 E.04565
G1 X127.06 Y136.975 E.03698
G1 X129.96 Y136.975 E.04565
G1 X129.96 Y136.399 E.00908
G1 X130.74 Y136.399 E.01228
G1 X130.74 Y136.915 E.00813
M204 S10000
G1 X130.581 Y136.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X130.299 Y136.757 E.00487
G1 X130.299 Y137.194 E.00756
G1 X130.401 Y137.194 E.00177
G1 X130.401 Y137.314 E.00207
G1 X132.601 Y137.314 E.03801
G1 X132.601 Y137.632 E.00549
G1 X127.399 Y137.632 E.08989
G1 X127.399 Y138.069 E.00756
G1 X132.601 Y138.069 E.08989
G1 X132.601 Y138.507 E.00756
G1 X127.399 Y138.507 E.08989
G1 X127.399 Y138.944 E.00756
G1 X132.601 Y138.944 E.08989
G1 X132.601 Y138.986 E.00072
G1 X130.401 Y138.986 E.03801
G1 X130.401 Y139.382 E.00684
G1 X130.119 Y139.382 E.00487
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.382 E-.10711
G1 X130.401 Y138.986 E-.15048
G1 X131.723 Y138.986 E-.50241
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.723 Y138.892 Z1.9 F30000
G1 X127.493 Y138.68
G1 X116.507 Y137.885
G1 X116.397 Y137.839
G1 X114.14 Y137.839
G1 X114.14 Y137.714
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.714 E.04407
G1 X116.94 Y138.286 E.009
G1 X114.14 Y138.286 E.04407
G1 X114.14 Y139.175 E.01399
G1 X99.44 Y139.175 E.23139
G1 X99.44 Y139.751 E.00907
G1 X99.06 Y139.751 E.00598
G1 X99.06 Y136.249 E.05512
G1 X99.44 Y136.249 E.00598
G1 X99.44 Y136.825 E.00907
G1 X114.14 Y136.825 E.23139
G1 X114.14 Y137.654 E.01304
M204 S10000
G1 X113.933 Y138 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.17968
G1 F1200
M204 S1000
G1 X116.733 Y138 E.0175
; WIPE_START
G1 X114.733 Y138 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.733 Y137.839 Z1.9 F30000
G1 X114.015 Y138.161
G1 X113.776 Y138.67
G1 X113.979 Y138.765
G1 Z1.5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y138.765 E.24653
G1 X99.414 Y138.251 E.0087
G1 X113.58 Y138.251 E.23977
G1 X113.58 Y137.736 E.0087
G1 X99.414 Y137.736 E.23977
G1 X99.414 Y137.222 E.0087
G1 X113.979 Y137.222 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X111.979 Y137.222 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.979 Y137.258 Z1.9 F30000
G1 X114.069 Y124.161
G1 X116.397 Y123.839
G1 X114.14 Y123.839
G1 X114.14 Y123.714
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.714 E.04407
G1 X116.94 Y124.286 E.009
G1 X114.14 Y124.286 E.04407
G1 X114.14 Y125.118 E.01309
G1 X99.44 Y125.118 E.23139
G1 X99.44 Y125.751 E.00997
G1 X99.06 Y125.751 E.00598
G1 X99.06 Y122.249 E.05512
G1 X99.44 Y122.249 E.00598
G1 X99.44 Y122.882 E.00997
G1 X114.14 Y122.882 E.23139
G1 X114.14 Y123.654 E.01215
M204 S10000
G1 X113.933 Y124 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.17968
G1 F1200
M204 S1000
G1 X116.733 Y124 E.0175
; WIPE_START
G1 X114.733 Y124 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.733 Y123.839 Z1.9 F30000
G1 X114.015 Y123.839
G1 X113.788 Y123.356
G1 X113.979 Y123.266
G1 Z1.5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.266 E.24653
G1 X99.414 Y123.755 E.00828
G1 X113.58 Y123.755 E.23977
G1 X113.58 Y124.245 E.00828
G1 X99.414 Y124.245 E.23977
G1 X99.414 Y124.734 E.00828
G1 X113.979 Y124.734 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X111.979 Y124.734 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.979 Y124.685 Z1.9 F30000
G1 X112.191 Y123.315
G1 X114.14 Y110.161
G1 X114.14 Y110.286
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y111.059 E.01217
G1 X99.44 Y111.059 E.23139
G1 X99.44 Y111.751 E.01089
G1 X99.06 Y111.751 E.00598
G1 X99.06 Y108.249 E.05512
G1 X99.44 Y108.249 E.00598
G1 X99.44 Y108.941 E.01089
G1 X114.14 Y108.941 E.23139
G1 X114.14 Y109.714 E.01217
G1 X116.94 Y109.714 E.04407
G1 X116.94 Y110.286 E.009
G1 X114.2 Y110.286 E.04313
M204 S10000
G1 X113.933 Y110 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.17968
G1 F1200
M204 S1000
G1 X116.733 Y110 E.0175
; WIPE_START
G1 X114.733 Y110 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.733 Y109.839 Z1.9 F30000
G1 X114.015 Y109.839
G1 X113.805 Y109.392
G1 X113.979 Y109.31
G1 Z1.5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.31 E.24653
G1 X99.414 Y109.77 E.00778
G1 X113.58 Y109.77 E.23977
G1 X113.58 Y110.23 E.00778
G1 X99.414 Y110.23 E.23977
G1 X99.414 Y110.69 E.00778
G1 X113.979 Y110.69 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X111.979 Y110.69 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 16/28
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.9 I1.217 J0 P1  F30000
G1 X111.979 Y110.561 Z1.9
G1 X113.789 Y110.542
G1 X130.189 Y109.2
G1 X130.511 Y109.384
G1 X130.667 Y109.426
G1 X130.74 Y109.155
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.155 E.03463
M73 P85 R4
G1 X132.94 Y111.145 E.03133
G1 X130.74 Y111.145 E.03463
G1 X130.74 Y111.74 E.00936
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.145 E.00936
G1 X127.06 Y111.145 E.04565
G1 X127.06 Y109.155 E.03133
G1 X129.96 Y109.155 E.04565
G1 X129.96 Y108.44 E.01125
G1 X130.74 Y108.44 E.01228
G1 X130.74 Y109.095 E.0103
M204 S10000
G1 X130.581 Y108.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
G1 X130.299 Y108.795 E.0048
G1 X130.299 Y109.227 E.00736
G1 X130.401 Y109.227 E.00175
G1 X130.401 Y109.493 E.00454
G1 X132.601 Y109.493 E.0375
G1 X132.601 Y109.658 E.00281
G1 X127.399 Y109.658 E.08868
G1 X127.399 Y110.09 E.00736
G1 X132.601 Y110.09 E.08868
G1 X132.601 Y110.522 E.00736
G1 X127.399 Y110.522 E.08868
G1 X127.399 Y110.806 E.00486
G1 X130.299 Y110.806 E.04943
G1 X130.299 Y110.953 E.0025
G1 X130.401 Y110.953 E.00175
G1 X130.401 Y111.385 E.00736
G1 X130.119 Y111.385 E.0048
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.385 E-.10711
G1 X130.401 Y110.953 E-.16399
G1 X130.299 Y110.953 E-.03896
G1 X130.299 Y110.806 E-.05575
G1 X129.261 Y110.806 E-.39419
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X129.261 Y110.712 Z2 F30000
G1 X130.667 Y123.366
G1 X130.74 Y123.094
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.094 E.03463
G1 X132.94 Y125.206 E.03323
G1 X130.74 Y125.206 E.03463
G1 X130.74 Y125.74 E.00841
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.206 E.00841
G1 X127.06 Y125.206 E.04565
G1 X127.06 Y123.094 E.03323
G1 X129.96 Y123.094 E.04565
G1 X129.96 Y122.44 E.0103
G1 X130.74 Y122.44 E.01228
G1 X130.74 Y123.034 E.00935
M204 S10000
G1 X130.581 Y122.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
G1 X130.299 Y122.795 E.0048
G1 X130.299 Y123.227 E.00736
G1 X130.401 Y123.227 E.00175
G1 X130.401 Y123.433 E.00351
G1 X132.601 Y123.433 E.0375
G1 X132.601 Y123.658 E.00384
G1 X127.399 Y123.658 E.08868
G1 X127.399 Y124.09 E.00736
G1 X132.601 Y124.09 E.08868
G1 X132.601 Y124.522 E.00736
G1 X127.399 Y124.522 E.08868
G1 X127.399 Y124.867 E.00589
G1 X130.299 Y124.867 E.04943
G1 X130.299 Y124.953 E.00147
G1 X130.401 Y124.953 E.00175
G1 X130.401 Y125.385 E.00736
G1 X130.119 Y125.385 E.0048
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.385 E-.10711
G1 X130.401 Y124.953 E-.16399
G1 X130.299 Y124.953 E-.03896
G1 X130.299 Y124.867 E-.03277
G1 X129.201 Y124.867 E-.41718
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.201 Y124.773 Z2 F30000
G1 X132.507 Y124.49
G1 X144.235 Y123.152
G1 X144.511 Y123.324
G1 X144.667 Y123.366
G1 X144.74 Y123.094
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.094 E.03463
G1 X146.94 Y125.206 E.03323
G1 X144.74 Y125.206 E.03463
G1 X144.74 Y125.74 E.00841
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.206 E.00841
G1 X141.06 Y125.206 E.04565
G1 X141.06 Y123.094 E.03323
G1 X143.96 Y123.094 E.04565
G1 X143.96 Y122.44 E.0103
G1 X144.74 Y122.44 E.01228
G1 X144.74 Y123.034 E.00935
M204 S10000
G1 X144.581 Y122.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
G1 X144.299 Y122.795 E.0048
G1 X144.299 Y123.227 E.00736
G1 X144.401 Y123.227 E.00175
G1 X144.401 Y123.433 E.00351
G1 X146.601 Y123.433 E.0375
G1 X146.601 Y123.658 E.00384
G1 X141.399 Y123.658 E.08868
G1 X141.399 Y124.09 E.00736
G1 X146.601 Y124.09 E.08868
G1 X146.601 Y124.522 E.00736
G1 X141.399 Y124.522 E.08868
G1 X141.399 Y124.867 E.00589
G1 X144.299 Y124.867 E.04943
G1 X144.299 Y124.953 E.00147
G1 X144.401 Y124.953 E.00175
G1 X144.401 Y125.385 E.00736
G1 X144.119 Y125.385 E.0048
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.385 E-.10711
G1 X144.401 Y124.953 E-.16399
G1 X144.299 Y124.953 E-.03896
G1 X144.299 Y124.867 E-.03277
G1 X143.201 Y124.867 E-.41718
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.201 Y124.773 Z2 F30000
G1 X143.332 Y123.527
G1 X144.569 Y110.9
G1 X145.271 Y109.588
G1 X144.667 Y109.426
G1 X144.74 Y109.155
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.155 E.03463
G1 X146.94 Y111.145 E.03133
G1 X144.74 Y111.145 E.03463
G1 X144.74 Y111.74 E.00936
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.145 E.00936
G1 X141.06 Y111.145 E.04565
G1 X141.06 Y109.155 E.03133
G1 X143.96 Y109.155 E.04565
G1 X143.96 Y108.44 E.01125
G1 X144.74 Y108.44 E.01228
G1 X144.74 Y109.095 E.0103
M204 S10000
G1 X144.581 Y108.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
M73 P86 R4
G1 X144.299 Y108.795 E.0048
G1 X144.299 Y109.227 E.00736
G1 X144.401 Y109.227 E.00175
G1 X144.401 Y109.493 E.00454
G1 X146.601 Y109.493 E.0375
G1 X146.601 Y109.658 E.00281
G1 X141.399 Y109.658 E.08868
G1 X141.399 Y110.09 E.00736
G1 X146.601 Y110.09 E.08868
G1 X146.601 Y110.522 E.00736
G1 X141.399 Y110.522 E.08868
G1 X141.399 Y110.806 E.00486
G1 X144.299 Y110.806 E.04943
G1 X144.299 Y110.953 E.0025
G1 X144.401 Y110.953 E.00175
G1 X144.401 Y111.385 E.00736
G1 X144.119 Y111.385 E.0048
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.385 E-.10711
G1 X144.401 Y110.953 E-.16399
G1 X144.299 Y110.953 E-.03896
M73 P86 R3
G1 X144.299 Y110.806 E-.05575
G1 X143.261 Y110.806 E-.39419
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X143.261 Y110.712 Z2 F30000
G1 X143.97 Y123.382
G1 X144.058 Y124.941
G1 X144.476 Y137.086
G1 X144.74 Y137.034
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y137.034 E.03463
G1 X146.94 Y139.266 E.03513
; object ids of layer 16 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer16 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.266 E.03463
G1 X144.74 Y139.74 E.00746
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.266 E.00746
G1 X141.06 Y139.266 E.04565
G1 X141.06 Y137.034 E.03513
G1 X143.96 Y137.034 E.04565
G1 X143.96 Y136.44 E.00935
G1 X144.74 Y136.44 E.01228
G1 X144.74 Y136.974 E.00841
M204 S10000
G1 X144.581 Y136.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
G1 X144.299 Y136.795 E.0048
G1 X144.299 Y137.227 E.00736
G1 X144.401 Y137.227 E.00175
G1 X144.401 Y137.373 E.00249
G1 X146.601 Y137.373 E.0375
G1 X146.601 Y137.658 E.00487
G1 X141.399 Y137.658 E.08868
G1 X141.399 Y138.09 E.00736
G1 X146.601 Y138.09 E.08868
G1 X146.601 Y138.522 E.00736
G1 X141.399 Y138.522 E.08868
G1 X141.399 Y138.927 E.00691
G1 X144.299 Y138.927 E.04943
G1 X144.299 Y138.953 E.00045
G1 X144.401 Y138.953 E.00175
G1 X144.401 Y139.385 E.00736
G1 X144.119 Y139.385 E.0048
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.385 E-.10711
G1 X144.401 Y138.953 E-.16399
G1 X144.299 Y138.953 E-.03896
G1 X144.299 Y138.927 E-.00992
G1 X143.141 Y138.927 E-.44002
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X143.141 Y138.833 Z2 F30000
G1 X141.493 Y138.675
G1 X130.476 Y137.086
G1 X130.74 Y137.034
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y137.034 E.03463
G1 X132.94 Y139.266 E.03513
G1 X130.74 Y139.266 E.03463
G1 X130.74 Y139.74 E.00746
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.266 E.00746
G1 X127.06 Y139.266 E.04565
G1 X127.06 Y137.034 E.03513
G1 X129.96 Y137.034 E.04565
G1 X129.96 Y136.44 E.00935
G1 X130.74 Y136.44 E.01228
G1 X130.74 Y136.974 E.00841
M204 S10000
G1 X130.581 Y136.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
G1 X130.299 Y136.795 E.0048
G1 X130.299 Y137.227 E.00736
G1 X130.401 Y137.227 E.00175
G1 X130.401 Y137.373 E.00249
G1 X132.601 Y137.373 E.0375
G1 X132.601 Y137.658 E.00487
G1 X127.399 Y137.658 E.08868
G1 X127.399 Y138.09 E.00736
G1 X132.601 Y138.09 E.08868
G1 X132.601 Y138.522 E.00736
G1 X127.399 Y138.522 E.08868
G1 X127.399 Y138.927 E.00691
G1 X130.299 Y138.927 E.04943
G1 X130.299 Y138.953 E.00045
G1 X130.401 Y138.953 E.00175
G1 X130.401 Y139.385 E.00736
G1 X130.119 Y139.385 E.0048
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.385 E-.10711
G1 X130.401 Y138.953 E-.16399
G1 X130.299 Y138.953 E-.03896
G1 X130.299 Y138.927 E-.00992
G1 X129.141 Y138.927 E-.44002
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X129.141 Y138.833 Z2 F30000
G1 X127.493 Y138.816
G1 X116.507 Y138.076
G1 X114.217 Y137.839
G1 X114.213 Y137.835
G1 X114.14 Y137.917
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y137.917 E.04407
G1 X116.94 Y138.083 E.00262
G1 X114.14 Y138.083 E.04407
G1 X114.14 Y139.116 E.01625
G1 X99.44 Y139.116 E.23139
G1 X99.44 Y139.709 E.00934
G1 X99.06 Y139.709 E.00598
G1 X99.06 Y136.291 E.05381
G1 X99.44 Y136.291 E.00598
G1 X99.44 Y136.884 E.00934
G1 X114.14 Y136.884 E.23139
G1 X114.14 Y137.857 E.01531
M204 S10000
G1 X113.979 Y137.268 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.268 E.24653
G1 X99.414 Y137.756 E.00826
G1 X113.786 Y137.756 E.24327
G1 X113.786 Y138.244 E.00826
G1 X99.414 Y138.244 E.24327
G1 X99.414 Y138.732 E.00826
G1 X113.979 Y138.732 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X111.979 Y138.732 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.979 Y138.683 Z2 F30000
G1 X112.186 Y137.317
G1 X114.213 Y123.835
G1 X114.14 Y123.917
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.94 Y123.917 E.04407
G1 X116.94 Y124.083 E.00262
G1 X114.14 Y124.083 E.04407
G1 X114.14 Y125.056 E.01531
G1 X99.44 Y125.056 E.23139
G1 X99.44 Y125.709 E.01029
G1 X99.06 Y125.709 E.00598
G1 X99.06 Y122.291 E.05381
G1 X99.44 Y122.291 E.00598
G1 X99.44 Y122.944 E.01029
G1 X114.14 Y122.944 E.23139
G1 X114.14 Y123.857 E.01436
M204 S10000
G1 X113.979 Y123.313 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.313 E.24653
G1 X99.414 Y123.771 E.00775
G1 X113.786 Y123.771 E.24327
G1 X113.786 Y124.229 E.00775
G1 X99.414 Y124.229 E.24327
G1 X99.414 Y124.687 E.00775
G1 X113.979 Y124.687 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X111.979 Y124.687 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.979 Y124.623 Z2 F30000
G1 X112.173 Y123.377
G1 X114.213 Y110.165
G1 X114.14 Y110.083
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y110.994 E.01434
G1 X99.44 Y110.994 E.23139
G1 X99.44 Y111.709 E.01126
G1 X99.06 Y111.709 E.00598
G1 X99.06 Y108.291 E.05381
G1 X99.44 Y108.291 E.00598
G1 X99.44 Y109.006 E.01126
G1 X114.14 Y109.006 E.23139
G1 X114.14 Y109.917 E.01434
G1 X116.94 Y109.917 E.04407
G1 X116.94 Y110.083 E.00262
G1 X114.2 Y110.083 E.04313
M204 S10000
G1 X113.979 Y109.402 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.402 E.24653
G1 X99.414 Y109.917 E.0087
G1 X113.786 Y109.917 E.24327
G1 X113.786 Y110.431 E.0087
G1 X99.221 Y110.431 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X101.221 Y110.431 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 17/28
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
M106 S30.6
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2 I-1.217 J0 P1  F30000
G1 X101.221 Y110.485 Z2
G1 X113.707 Y109.924
G1 X130.189 Y109.254
G1 X130.489 Y108.7
G1 X130.504 Y109.238
G1 X130.74 Y109.232
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.232 E.03463
G1 X132.94 Y111.068 E.02891
G1 X130.74 Y111.068 E.03463
G1 X130.74 Y111.74 E.01057
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y111.068 E.01057
G1 X127.06 Y111.068 E.04565
G1 X127.06 Y109.232 E.02891
G1 X129.96 Y109.232 E.04565
G1 X129.96 Y108.487 E.01172
G1 X130.74 Y108.487 E.01228
G1 X130.74 Y109.172 E.01077
M204 S10000
G1 X130.35 Y109.438 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y108.694 E.01077
; WIPE_START
G1 X130.35 Y109.438 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.781 Y109.594 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46732
G1 F1200
M204 S1000
G1 X130.883 Y109.594 E.03342
G1 X130.883 Y109.777 E.00322
G1 X129.817 Y109.777 E.01877
G1 X129.817 Y109.594 E.00322
G1 X127.399 Y109.594 E.04259
M73 P87 R3
G1 X127.399 Y110.04 E.00785
G1 X132.601 Y110.04 E.09162
G1 X132.601 Y110.486 E.00785
G1 X127.399 Y110.486 E.09162
G1 X127.399 Y110.73 E.00429
G1 X130.299 Y110.729 E.05107
G1 X130.299 Y110.932 E.00356
G1 X130.401 Y110.932 E.00181
G1 X130.401 Y111.378 E.00785
G1 X130.119 Y111.378 E.00496
; OBJECT_ID: 5
; WIPE_START
G1 X130.401 Y111.378 E-.10711
G1 X130.401 Y110.932 E-.16943
G1 X130.299 Y110.932 E-.03896
G1 X130.299 Y110.729 E-.07684
G1 X129.331 Y110.73 E-.36766
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X129.331 Y110.635 Z2.1 F30000
G1 X130.667 Y123.439
G1 X130.74 Y123.167
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.167 E.03463
G1 X132.94 Y125.133 E.03093
G1 X130.74 Y125.133 E.03463
G1 X130.74 Y125.74 E.00956
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.133 E.00956
G1 X127.06 Y125.133 E.04565
G1 X127.06 Y123.167 E.03093
G1 X129.96 Y123.167 E.04565
G1 X129.96 Y122.487 E.01071
G1 X130.74 Y122.487 E.01228
G1 X130.74 Y123.107 E.00976
M204 S10000
G1 X130.581 Y122.839 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44628
G1 F1200
M204 S1000
G1 X130.299 Y122.839 E.00473
G1 X130.299 Y123.264 E.00713
G1 X130.401 Y123.264 E.00172
G1 X130.401 Y123.506 E.00406
G1 X132.601 Y123.506 E.03691
G1 X132.601 Y123.689 E.00307
G1 X127.399 Y123.689 E.08729
G1 X127.399 Y124.114 E.00713
G1 X132.601 Y124.114 E.08729
G1 X132.601 Y124.538 E.00713
G1 X127.399 Y124.538 E.08729
G1 X127.399 Y124.794 E.00428
G1 X130.299 Y124.794 E.04866
G1 X130.299 Y124.963 E.00284
G1 X130.401 Y124.963 E.00172
G1 X130.401 Y125.388 E.00713
G1 X130.119 Y125.388 E.00473
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.388 E-.10711
G1 X130.401 Y124.963 E-.16143
G1 X130.299 Y124.963 E-.03896
G1 X130.299 Y124.794 E-.06441
G1 X129.277 Y124.794 E-.38809
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.277 Y124.7 Z2.1 F30000
G1 X132.507 Y124.454
G1 X144.237 Y123.22
G1 X144.511 Y123.397
G1 X144.667 Y123.439
G1 X144.74 Y123.167
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.167 E.03463
G1 X146.94 Y125.133 E.03093
G1 X144.74 Y125.133 E.03463
G1 X144.74 Y125.74 E.00956
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.133 E.00956
G1 X141.06 Y125.133 E.04565
G1 X141.06 Y123.167 E.03093
G1 X143.96 Y123.167 E.04565
G1 X143.96 Y122.487 E.01071
G1 X144.74 Y122.487 E.01228
G1 X144.74 Y123.107 E.00976
M204 S10000
G1 X144.581 Y122.839 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44628
G1 F1200
M204 S1000
G1 X144.299 Y122.839 E.00473
G1 X144.299 Y123.264 E.00713
G1 X144.401 Y123.264 E.00172
G1 X144.401 Y123.506 E.00406
G1 X146.601 Y123.506 E.03691
G1 X146.601 Y123.689 E.00307
G1 X141.399 Y123.689 E.08729
G1 X141.399 Y124.114 E.00713
G1 X146.601 Y124.114 E.08729
G1 X146.601 Y124.538 E.00713
G1 X141.399 Y124.538 E.08729
G1 X141.399 Y124.794 E.00428
G1 X144.299 Y124.794 E.04866
G1 X144.299 Y124.963 E.00284
G1 X144.401 Y124.963 E.00172
G1 X144.401 Y125.388 E.00713
G1 X144.119 Y125.388 E.00473
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.388 E-.10711
G1 X144.401 Y124.963 E-.16143
G1 X144.299 Y124.963 E-.03896
G1 X144.299 Y124.794 E-.06441
G1 X143.277 Y124.794 E-.38809
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.277 Y124.7 Z2.1 F30000
G1 X143.39 Y123.6
G1 X144.591 Y110.817
G1 X144.511 Y109.461
G1 X144.504 Y109.238
G1 X144.74 Y109.232
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.232 E.03463
G1 X146.94 Y111.068 E.02891
G1 X144.74 Y111.068 E.03463
G1 X144.74 Y111.74 E.01057
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y111.068 E.01057
G1 X141.06 Y111.068 E.04565
G1 X141.06 Y109.232 E.02891
G1 X143.96 Y109.232 E.04565
G1 X143.96 Y108.487 E.01172
G1 X144.74 Y108.487 E.01228
G1 X144.74 Y109.172 E.01077
M204 S10000
G1 X144.35 Y109.438 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y108.694 E.01077
; WIPE_START
G1 X144.35 Y109.438 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.781 Y109.594 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46732
G1 F1200
M204 S1000
G1 X144.883 Y109.594 E.03342
G1 X144.883 Y109.777 E.00322
G1 X143.817 Y109.777 E.01877
G1 X143.817 Y109.594 E.00322
G1 X141.399 Y109.594 E.04259
G1 X141.399 Y110.04 E.00785
G1 X146.601 Y110.04 E.09162
G1 X146.601 Y110.486 E.00785
G1 X141.399 Y110.486 E.09162
G1 X141.399 Y110.73 E.00429
G1 X144.299 Y110.729 E.05107
G1 X144.299 Y110.932 E.00356
G1 X144.401 Y110.932 E.00181
G1 X144.401 Y111.378 E.00785
G1 X144.119 Y111.378 E.00496
; OBJECT_ID: 9
; WIPE_START
G1 X144.401 Y111.378 E-.10711
G1 X144.401 Y110.932 E-.16943
G1 X144.299 Y110.932 E-.03896
G1 X144.299 Y110.729 E-.07684
G1 X143.331 Y110.73 E-.36766
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X143.331 Y110.635 Z2.1 F30000
G1 X144.01 Y123.445
G1 X144.087 Y124.876
G1 X144.476 Y137.155
G1 X144.74 Y137.104
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y137.104 E.03463
G1 X146.94 Y139.196 E.03293
; object ids of layer 17 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer17 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.196 E.03463
G1 X144.74 Y139.74 E.00856
G1 X143.96 Y139.74 E.01228
M73 P88 R3
G1 X143.96 Y139.196 E.00856
G1 X141.06 Y139.196 E.04565
G1 X141.06 Y137.104 E.03293
G1 X143.96 Y137.104 E.04565
G1 X143.96 Y136.487 E.00971
G1 X144.74 Y136.487 E.01228
G1 X144.74 Y137.044 E.00876
M204 S10000
G1 X144.581 Y136.839 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44628
G1 F1200
M204 S1000
G1 X144.299 Y136.839 E.00473
G1 X144.299 Y137.264 E.00713
G1 X144.401 Y137.264 E.00172
G1 X144.401 Y137.443 E.003
G1 X146.601 Y137.443 E.03691
G1 X146.601 Y137.689 E.00413
G1 X141.399 Y137.689 E.08729
G1 X141.399 Y138.114 E.00713
G1 X146.601 Y138.114 E.08729
G1 X146.601 Y138.538 E.00713
G1 X141.399 Y138.538 E.08729
G1 X141.399 Y138.857 E.00535
G1 X144.299 Y138.857 E.04866
G1 X144.299 Y138.963 E.00178
G1 X144.401 Y138.963 E.00172
G1 X144.401 Y139.388 E.00713
G1 X144.119 Y139.388 E.00473
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.388 E-.10711
G1 X144.401 Y138.963 E-.16143
G1 X144.299 Y138.963 E-.03896
G1 X144.299 Y138.857 E-.04032
G1 X143.214 Y138.857 E-.41218
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X143.214 Y138.763 Z2.1 F30000
G1 X141.493 Y138.615
G1 X130.476 Y137.155
G1 X130.74 Y137.104
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y137.104 E.03463
G1 X132.94 Y139.196 E.03293
G1 X130.74 Y139.196 E.03463
G1 X130.74 Y139.74 E.00856
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.196 E.00856
G1 X127.06 Y139.196 E.04565
G1 X127.06 Y137.104 E.03293
G1 X129.96 Y137.104 E.04565
G1 X129.96 Y136.487 E.00971
G1 X130.74 Y136.487 E.01228
G1 X130.74 Y137.044 E.00876
M204 S10000
G1 X130.581 Y136.839 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44628
G1 F1200
M204 S1000
G1 X130.299 Y136.839 E.00473
G1 X130.299 Y137.264 E.00713
G1 X130.401 Y137.264 E.00172
G1 X130.401 Y137.443 E.003
G1 X132.601 Y137.443 E.03691
G1 X132.601 Y137.689 E.00413
G1 X127.399 Y137.689 E.08729
G1 X127.399 Y138.114 E.00713
G1 X132.601 Y138.114 E.08729
G1 X132.601 Y138.538 E.00713
G1 X127.399 Y138.538 E.08729
G1 X127.399 Y138.857 E.00535
G1 X130.299 Y138.857 E.04866
G1 X130.299 Y138.963 E.00178
G1 X130.401 Y138.963 E.00172
G1 X130.401 Y139.388 E.00713
G1 X130.119 Y139.388 E.00473
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.388 E-.10711
G1 X130.401 Y138.963 E-.16143
G1 X130.299 Y138.963 E-.03896
G1 X130.299 Y138.857 E-.04032
G1 X129.214 Y138.857 E-.41218
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X129.214 Y138.763 Z2.1 F30000
G1 X127.493 Y138.747
G1 X113.707 Y137.866
G1 X100.456 Y137.387
G1 X99.971 Y137.149
G1 X99.43 Y136.989
G1 X99.44 Y136.954
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y136.954 E.23139
G1 X114.14 Y139.046 E.03293
G1 X99.44 Y139.046 E.23139
G1 X99.44 Y139.662 E.0097
G1 X99.06 Y139.662 E.00598
G1 X99.06 Y136.338 E.05232
G1 X99.44 Y136.338 E.00598
G1 X99.44 Y136.894 E.00875
; WIPE_START
M204 S1000
G1 X101.44 Y136.902 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y137.387 Z2.1 F30000
G1 X113.707 Y137.387
G1 X113.979 Y137.32
G1 Z1.7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.32 E.24653
G1 X99.414 Y137.773 E.00767
G1 X113.786 Y137.773 E.24327
G1 X113.786 Y138.227 E.00767
G1 X99.414 Y138.227 E.24327
G1 X99.414 Y138.68 E.00767
G1 X113.979 Y138.68 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X111.979 Y138.68 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.979 Y138.613 Z2.1 F30000
G1 X110.944 Y137.387
G1 X100.666 Y124.549
G1 X99.092 Y122.893
G1 X99.411 Y122.771
G1 X99.411 Y123.018
G1 X99.44 Y123.018
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y123.018 E.23139
G1 X114.14 Y124.982 E.03091
G1 X99.44 Y124.982 E.23139
G1 X99.44 Y125.662 E.0107
G1 X99.06 Y125.662 E.00598
G1 X99.06 Y122.338 E.05232
G1 X99.44 Y122.338 E.00598
G1 X99.44 Y122.958 E.00976
; WIPE_START
M204 S1000
G1 X101.44 Y122.966 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y123.451 Z2.1 F30000
G1 X99.318 Y124.221
G1 X99.241 Y124.45
G1 X99.221 Y124.443
G1 Z1.7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X113.786 Y124.443 E.24653
G1 X113.786 Y123.929 E.0087
G1 X99.414 Y123.929 E.24327
G1 X99.414 Y123.415 E.0087
G1 X113.979 Y123.415 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X111.979 Y123.415 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.979 Y123.451 Z2.1 F30000
G1 X113.655 Y110.485
G1 X113.707 Y110.485
G1 X113.707 Y110.08
G1 X114.14 Y110.081
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y110.917 E.01317
G1 X99.44 Y110.917 E.23139
G1 X99.44 Y111.662 E.01172
G1 X99.06 Y111.662 E.00598
G1 X99.06 Y108.338 E.05232
G1 X99.44 Y108.338 E.00598
G1 X99.44 Y109.083 E.01172
G1 X114.14 Y109.083 E.23139
G1 X114.14 Y110.021 E.01476
M204 S10000
G1 X113.979 Y109.479 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y109.479 E.24653
G1 X99.414 Y109.993 E.0087
G1 X113.786 Y109.993 E.24327
G1 X113.786 Y110.508 E.0087
G1 X99.221 Y110.508 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X101.221 Y110.508 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 18/28
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
M106 S33.15
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.1 I1.217 J0 P1  F30000
G1 X101.221 Y110.393 Z2.1
G1 X113.707 Y110.007
G1 X130.189 Y109.346
G1 X130.489 Y108.793
G1 X130.504 Y109.331
G1 X130.74 Y109.324
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.324 E.03463
G1 X132.94 Y110.976 E.026
G1 X130.74 Y110.976 E.03463
G1 X130.74 Y111.74 E.01203
G1 X129.96 Y111.74 E.01228
G1 X129.96 Y110.976 E.01203
G1 X127.06 Y110.976 E.04565
G1 X127.06 Y109.324 E.026
G1 X129.96 Y109.324 E.04565
G1 X129.96 Y108.542 E.01232
G1 X130.74 Y108.542 E.01228
G1 X130.74 Y109.264 E.01137
M204 S10000
G1 X130.35 Y109.531 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.387953
G1 F1200
M204 S1000
G1 X130.35 Y108.748 E.01132
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y110.769 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y111.533 E.01106
; WIPE_START
G1 X130.35 Y110.769 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.781 Y109.692 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47904
G1 F1200
M204 S1000
G1 X127.399 Y109.692 E.09727
G1 X127.399 Y110.15 E.00827
G1 X132.601 Y110.15 E.09402
G1 X132.601 Y110.608 E.00827
G1 X127.219 Y110.608 E.09727
; OBJECT_ID: 5
; WIPE_START
G1 X129.219 Y110.608 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X129.223 Y110.566 Z2.2 F30000
G1 X129.223 Y110.566
G1 X130.667 Y123.526
G1 X130.74 Y123.254
G1 Z1.8
M73 P89 R3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.254 E.03463
G1 X132.94 Y125.046 E.0282
G1 X130.74 Y125.046 E.03463
G1 X130.74 Y125.74 E.01093
G1 X129.96 Y125.74 E.01228
G1 X129.96 Y125.046 E.01093
G1 X127.06 Y125.046 E.04565
G1 X127.06 Y123.254 E.0282
G1 X129.96 Y123.254 E.04565
G1 X129.96 Y122.542 E.01122
G1 X130.74 Y122.542 E.01228
G1 X130.74 Y123.194 E.01027
M204 S10000
G1 X130.581 Y122.89 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4385
G1 F1200
M204 S1000
G1 X130.299 Y122.89 E.00464
G1 X130.299 Y123.307 E.00687
G1 X130.401 Y123.307 E.00169
G1 X130.401 Y123.593 E.00472
G1 X132.601 Y123.593 E.03624
G1 X132.601 Y123.724 E.00215
G1 X127.399 Y123.724 E.08569
G1 X127.399 Y124.141 E.00687
G1 X132.601 Y124.141 E.08569
G1 X132.601 Y124.558 E.00687
G1 X127.399 Y124.558 E.08569
G1 X127.399 Y124.707 E.00245
G1 X130.299 Y124.707 E.04777
G1 X130.299 Y124.975 E.00442
G1 X130.401 Y124.975 E.00169
G1 X130.401 Y125.392 E.00687
G1 X130.119 Y125.392 E.00464
; OBJECT_ID: 6
; WIPE_START
G1 X130.401 Y125.392 E-.10711
G1 X130.401 Y124.975 E-.15848
G1 X130.299 Y124.975 E-.03896
G1 X130.299 Y124.707 E-.10187
G1 X129.368 Y124.707 E-.35359
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.368 Y124.613 Z2.2 F30000
G1 X132.507 Y124.41
G1 X144.189 Y123.306
G1 X144.511 Y123.484
G1 X144.667 Y123.526
G1 X144.74 Y123.254
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.254 E.03463
G1 X146.94 Y125.046 E.0282
G1 X144.74 Y125.046 E.03463
G1 X144.74 Y125.74 E.01093
G1 X143.96 Y125.74 E.01228
G1 X143.96 Y125.046 E.01093
G1 X141.06 Y125.046 E.04565
G1 X141.06 Y123.254 E.0282
G1 X143.96 Y123.254 E.04565
G1 X143.96 Y122.542 E.01122
G1 X144.74 Y122.542 E.01228
G1 X144.74 Y123.194 E.01027
M204 S10000
G1 X144.581 Y122.89 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4385
G1 F1200
M204 S1000
G1 X144.299 Y122.89 E.00464
G1 X144.299 Y123.307 E.00687
G1 X144.401 Y123.307 E.00169
G1 X144.401 Y123.593 E.00472
G1 X146.601 Y123.593 E.03624
G1 X146.601 Y123.724 E.00215
G1 X141.399 Y123.724 E.08569
G1 X141.399 Y124.141 E.00687
G1 X146.601 Y124.141 E.08569
G1 X146.601 Y124.558 E.00687
G1 X141.399 Y124.558 E.08569
G1 X141.399 Y124.707 E.00245
G1 X144.299 Y124.707 E.04777
G1 X144.299 Y124.975 E.00442
G1 X144.401 Y124.975 E.00169
G1 X144.401 Y125.392 E.00687
G1 X144.119 Y125.392 E.00464
; OBJECT_ID: 3
; WIPE_START
G1 X144.401 Y125.392 E-.10711
G1 X144.401 Y124.975 E-.15848
G1 X144.299 Y124.975 E-.03896
G1 X144.299 Y124.707 E-.10187
G1 X143.368 Y124.707 E-.35359
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.368 Y124.613 Z2.2 F30000
M73 P89 R2
G1 X143.46 Y123.679
G1 X144.616 Y110.718
G1 X144.511 Y109.553
G1 X144.504 Y109.331
G1 X144.74 Y109.324
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.324 E.03463
G1 X146.94 Y110.976 E.026
G1 X144.74 Y110.976 E.03463
G1 X144.74 Y111.74 E.01203
G1 X143.96 Y111.74 E.01228
G1 X143.96 Y110.976 E.01203
G1 X141.06 Y110.976 E.04565
G1 X141.06 Y109.324 E.026
G1 X143.96 Y109.324 E.04565
G1 X143.96 Y108.542 E.01232
G1 X144.74 Y108.542 E.01228
G1 X144.74 Y109.264 E.01137
M204 S10000
G1 X144.35 Y109.531 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.387953
G1 F1200
M204 S1000
G1 X144.35 Y108.748 E.01132
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y110.769 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y111.533 E.01106
; WIPE_START
G1 X144.35 Y110.769 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.781 Y109.692 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47904
G1 F1200
M204 S1000
G1 X141.399 Y109.692 E.09727
G1 X141.399 Y110.15 E.00827
G1 X146.601 Y110.15 E.09402
G1 X146.601 Y110.608 E.00827
G1 X141.219 Y110.608 E.09727
; OBJECT_ID: 9
; WIPE_START
G1 X143.219 Y110.608 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X143.223 Y110.566 Z2.2 F30000
G1 X143.96 Y123.545
G1 X144.03 Y124.774
G1 X144.469 Y137.259
G1 X144.74 Y137.186
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y137.186 E.03463
G1 X146.94 Y139.113 E.03033
; object ids of layer 18 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer18 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.113 E.03463
G1 X144.74 Y139.74 E.00986
G1 X143.96 Y139.74 E.01228
G1 X143.96 Y139.113 E.00986
G1 X141.06 Y139.113 E.04565
G1 X141.06 Y137.186 E.03033
G1 X143.96 Y137.186 E.04565
G1 X143.96 Y136.542 E.01015
G1 X144.74 Y136.542 E.01228
G1 X144.74 Y137.126 E.00921
M204 S10000
G1 X144.581 Y136.89 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4385
G1 F1200
M204 S1000
G1 X144.299 Y136.89 E.00464
G1 X144.299 Y137.307 E.00687
G1 X144.401 Y137.307 E.00169
G1 X144.401 Y137.525 E.0036
G1 X146.601 Y137.525 E.03624
G1 X146.601 Y137.724 E.00327
G1 X141.399 Y137.724 E.08569
G1 X141.399 Y138.141 E.00687
G1 X146.601 Y138.141 E.08569
G1 X146.601 Y138.558 E.00687
G1 X141.399 Y138.558 E.08569
G1 X141.399 Y138.775 E.00357
G1 X144.299 Y138.775 E.04777
G1 X144.299 Y138.975 E.0033
G1 X144.401 Y138.975 E.00169
G1 X144.401 Y139.392 E.00687
G1 X144.119 Y139.392 E.00464
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.392 E-.10711
G1 X144.401 Y138.975 E-.15848
G1 X144.299 Y138.975 E-.03896
G1 X144.299 Y138.775 E-.07609
G1 X143.3 Y138.775 E-.37937
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X143.3 Y138.681 Z2.2 F30000
G1 X141.493 Y138.546
G1 X130.469 Y137.259
G1 X130.74 Y137.186
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y137.186 E.03463
G1 X132.94 Y139.113 E.03033
G1 X130.74 Y139.113 E.03463
G1 X130.74 Y139.74 E.00986
G1 X129.96 Y139.74 E.01228
G1 X129.96 Y139.113 E.00986
G1 X127.06 Y139.113 E.04565
G1 X127.06 Y137.186 E.03033
G1 X129.96 Y137.186 E.04565
G1 X129.96 Y136.542 E.01015
G1 X130.74 Y136.542 E.01228
G1 X130.74 Y137.126 E.00921
M204 S10000
G1 X130.581 Y136.89 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4385
G1 F1200
M204 S1000
G1 X130.299 Y136.89 E.00464
G1 X130.299 Y137.307 E.00687
G1 X130.401 Y137.307 E.00169
G1 X130.401 Y137.525 E.0036
G1 X132.601 Y137.525 E.03624
G1 X132.601 Y137.724 E.00327
G1 X127.399 Y137.724 E.08569
G1 X127.399 Y138.141 E.00687
G1 X132.601 Y138.141 E.08569
G1 X132.601 Y138.558 E.00687
G1 X127.399 Y138.558 E.08569
G1 X127.399 Y138.775 E.00357
G1 X130.299 Y138.775 E.04777
M73 P90 R2
G1 X130.299 Y138.975 E.0033
G1 X130.401 Y138.975 E.00169
G1 X130.401 Y139.392 E.00687
G1 X130.119 Y139.392 E.00464
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.392 E-.10711
G1 X130.401 Y138.975 E-.15848
G1 X130.299 Y138.975 E-.03896
G1 X130.299 Y138.775 E-.07609
G1 X129.3 Y138.775 E-.37937
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X129.3 Y138.681 Z2.2 F30000
G1 X127.493 Y138.67
G1 X113.707 Y137.867
G1 X100.456 Y137.47
G1 X99.411 Y137.066
G1 X99.407 Y137.041
G1 X99.44 Y137.037
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y137.037 E.23139
G1 X114.14 Y138.963 E.03031
G1 X99.44 Y138.963 E.23139
G1 X99.44 Y139.608 E.01015
G1 X99.06 Y139.608 E.00598
G1 X99.06 Y136.392 E.05061
G1 X99.44 Y136.392 E.00598
G1 X99.44 Y136.977 E.0092
; WIPE_START
M204 S1000
G1 X101.44 Y136.985 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y137.47 Z2.2 F30000
G1 X99.399 Y138
G1 X99.226 Y138.464
G1 X99.221 Y138.462
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X113.786 Y138.462 E.24653
G1 X113.786 Y137.948 E.0087
G1 X99.414 Y137.948 E.24327
G1 X99.414 Y137.434 E.0087
G1 X113.979 Y137.434 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X111.979 Y137.434 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.979 Y137.47 Z2.2 F30000
G1 X100.627 Y124.462
G1 X99.093 Y123.003
G1 X99.411 Y122.574
G1 X99.411 Y123.105
G1 X99.44 Y123.105
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y123.105 E.23139
G1 X114.14 Y124.895 E.02817
G1 X99.44 Y124.895 E.23139
G1 X99.44 Y125.608 E.01122
G1 X99.06 Y125.608 E.00598
G1 X99.06 Y122.392 E.05061
G1 X99.44 Y122.392 E.00598
G1 X99.44 Y123.045 E.01028
; WIPE_START
M204 S1000
G1 X101.44 Y123.054 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y123.538 Z2.2 F30000
G1 X99.371 Y124
G1 X99.193 Y124.493
G1 X99.221 Y124.503
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X113.786 Y124.503 E.24653
G1 X113.786 Y124 E.00852
G1 X99.414 Y124 E.24327
G1 X99.414 Y123.497 E.00852
G1 X113.979 Y123.497 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X111.979 Y123.497 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.979 Y123.538 Z2.2 F30000
G1 X99.411 Y110.826
G1 X99.44 Y110.826
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X99.44 Y111.608 E.01231
G1 X99.06 Y111.608 E.00598
G1 X99.06 Y108.392 E.05061
G1 X99.44 Y108.392 E.00598
G1 X99.44 Y109.174 E.01231
G1 X114.14 Y109.174 E.23139
G1 X114.14 Y110.826 E.02599
G1 X99.5 Y110.826 E.23045
M204 S10000
G1 X99.221 Y110.457 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X113.786 Y110.457 E.24653
G1 X113.786 Y110 E.00774
G1 X99.414 Y110 E.24327
G1 X99.414 Y109.543 E.00774
G1 X113.979 Y109.543 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 1.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X111.979 Y109.543 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 19/28
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
M106 S35.7
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.2 I-1.217 J0 P1  F30000
G1 X111.979 Y109.721 Z2.2
G1 X130.189 Y109.44
G1 X130.489 Y108.905
G1 X130.504 Y109.443
G1 X130.74 Y109.437
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.437 E.03463
G1 X132.94 Y110.863 E.02245
G1 X130.74 Y110.863 E.03463
G1 X130.74 Y111.697 E.01313
G1 X129.96 Y111.697 E.01228
G1 X129.96 Y110.863 E.01313
G1 X127.06 Y110.863 E.04565
G1 X127.06 Y109.437 E.02245
G1 X129.96 Y109.437 E.04565
G1 X129.96 Y108.603 E.01312
G1 X130.74 Y108.603 E.01228
G1 X130.74 Y109.377 E.01218
M204 S10000
G1 X130.35 Y109.643 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y108.81 E.01207
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y110.656 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X130.35 Y111.49 E.01207
; WIPE_START
G1 X130.35 Y110.656 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.781 Y110.294 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4997
G1 F1200
M204 S1000
G1 X127.399 Y110.294 E.10166
G1 X127.399 Y109.815 E.00903
G1 X132.781 Y109.815 E.10166
; OBJECT_ID: 5
; WIPE_START
G1 X130.781 Y109.815 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.799 Y109.727 Z2.3 F30000
G1 X130.504 Y123.365
G1 X130.74 Y123.359
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.359 E.03463
G1 X132.94 Y124.941 E.02491
G1 X130.74 Y124.941 E.03463
G1 X130.74 Y125.697 E.0119
G1 X129.96 Y125.697 E.01228
G1 X129.96 Y124.941 E.0119
G1 X127.06 Y124.941 E.04565
G1 X127.06 Y123.359 E.02491
G1 X129.96 Y123.359 E.04565
G1 X129.96 Y122.603 E.0119
G1 X130.74 Y122.603 E.01228
G1 X130.74 Y123.299 E.01095
M204 S10000
G1 X130.35 Y123.565 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y122.81 E.01094
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y124.734 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X130.35 Y125.49 E.01094
; WIPE_START
G1 X130.35 Y124.734 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.781 Y123.716 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45587
G1 F1200
M204 S1000
G1 X130.883 Y123.716 E.03256
G1 X130.883 Y123.904 E.00324
G1 X129.817 Y123.904 E.01828
G1 X129.817 Y123.716 E.00324
G1 X127.399 Y123.716 E.04149
G1 X127.399 Y124.15 E.00745
G1 X132.601 Y124.15 E.08926
G1 X132.601 Y124.584 E.00745
G1 X130.883 Y124.584 E.02948
G1 X130.883 Y124.396 E.00324
G1 X129.817 Y124.396 E.01828
M73 P91 R2
G1 X129.817 Y124.584 E.00324
G1 X127.219 Y124.584 E.04457
; OBJECT_ID: 6
; WIPE_START
G1 X129.219 Y124.584 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.219 Y124.508 Z2.3 F30000
G1 X132.507 Y124.325
G1 X144.189 Y123.402
G1 X144.489 Y122.828
G1 X144.504 Y123.365
G1 X144.74 Y123.359
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.359 E.03463
G1 X146.94 Y124.941 E.02491
G1 X144.74 Y124.941 E.03463
G1 X144.74 Y125.697 E.0119
G1 X143.96 Y125.697 E.01228
G1 X143.96 Y124.941 E.0119
G1 X141.06 Y124.941 E.04565
G1 X141.06 Y123.359 E.02491
G1 X143.96 Y123.359 E.04565
G1 X143.96 Y122.603 E.0119
G1 X144.74 Y122.603 E.01228
G1 X144.74 Y123.299 E.01095
M204 S10000
G1 X144.35 Y123.565 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y122.81 E.01094
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y124.734 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X144.35 Y125.49 E.01094
; WIPE_START
G1 X144.35 Y124.734 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.781 Y123.716 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45587
G1 F1200
M204 S1000
G1 X144.883 Y123.716 E.03256
G1 X144.883 Y123.904 E.00324
G1 X143.817 Y123.904 E.01828
G1 X143.817 Y123.716 E.00324
G1 X141.399 Y123.716 E.04149
G1 X141.399 Y124.15 E.00745
G1 X146.601 Y124.15 E.08926
G1 X146.601 Y124.584 E.00745
G1 X144.883 Y124.584 E.02948
G1 X144.883 Y124.396 E.00324
G1 X143.817 Y124.396 E.01828
G1 X143.817 Y124.584 E.00324
G1 X141.219 Y124.584 E.04457
; OBJECT_ID: 3
; WIPE_START
G1 X143.219 Y124.584 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.219 Y124.508 Z2.3 F30000
G1 X143.299 Y123.792
G1 X144.622 Y110.61
G1 X144.511 Y109.666
G1 X144.504 Y109.443
G1 X144.74 Y109.437
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.437 E.03463
G1 X146.94 Y110.863 E.02245
G1 X144.74 Y110.863 E.03463
G1 X144.74 Y111.697 E.01313
G1 X143.96 Y111.697 E.01228
G1 X143.96 Y110.863 E.01313
G1 X141.06 Y110.863 E.04565
G1 X141.06 Y109.437 E.02245
G1 X143.96 Y109.437 E.04565
G1 X143.96 Y108.603 E.01312
G1 X144.74 Y108.603 E.01228
G1 X144.74 Y109.377 E.01218
M204 S10000
G1 X144.35 Y109.643 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y108.81 E.01207
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y110.656 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X144.35 Y111.49 E.01207
; WIPE_START
G1 X144.35 Y110.656 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.781 Y110.294 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4997
G1 F1200
M204 S1000
G1 X141.399 Y110.294 E.10166
G1 X141.399 Y109.815 E.00903
G1 X146.781 Y109.815 E.10166
; OBJECT_ID: 9
; WIPE_START
G1 X144.781 Y109.815 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.799 Y109.727 Z2.3 F30000
G1 X144.76 Y123.655
G1 X144.759 Y124.645
G1 X144.667 Y137.556
G1 X144.74 Y137.284
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y137.284 E.03463
G1 X146.94 Y139.016 E.02725
; object ids of layer 19 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer19 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y139.016 E.03463
G1 X144.74 Y139.697 E.01073
G1 X143.96 Y139.697 E.01228
G1 X143.96 Y139.016 E.01073
G1 X141.06 Y139.016 E.04565
G1 X141.06 Y137.284 E.02725
G1 X143.96 Y137.284 E.04565
G1 X143.96 Y136.603 E.01072
G1 X144.74 Y136.603 E.01228
G1 X144.74 Y137.224 E.00978
M204 S10000
G1 X144.581 Y136.944 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42359
G1 F1200
M204 S1000
G1 X144.299 Y136.944 E.00448
G1 X144.299 Y137.346 E.00639
G1 X144.401 Y137.346 E.00163
G1 X144.401 Y137.623 E.0044
G1 X146.601 Y137.623 E.03494
G1 X146.601 Y137.748 E.00198
G1 X141.399 Y137.748 E.08263
G1 X141.399 Y138.15 E.00639
G1 X146.601 Y138.15 E.08263
G1 X146.601 Y138.552 E.00639
G1 X141.399 Y138.552 E.08263
G1 X141.399 Y138.677 E.00198
G1 X144.299 Y138.677 E.04606
G1 X144.299 Y138.954 E.00441
G1 X144.401 Y138.954 E.00163
G1 X144.401 Y139.357 E.00639
G1 X144.119 Y139.357 E.00448
; OBJECT_ID: 8
; WIPE_START
G1 X144.401 Y139.357 E-.10711
G1 X144.401 Y138.954 E-.15281
G1 X144.299 Y138.954 E-.03896
G1 X144.299 Y138.677 E-.10546
G1 X143.363 Y138.677 E-.35567
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X143.363 Y138.583 Z2.3 F30000
G1 X141.493 Y138.471
G1 X130.667 Y137.556
G1 X130.74 Y137.284
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y137.284 E.03463
G1 X132.94 Y139.016 E.02725
G1 X130.74 Y139.016 E.03463
G1 X130.74 Y139.697 E.01073
G1 X129.96 Y139.697 E.01228
G1 X129.96 Y139.016 E.01073
G1 X127.06 Y139.016 E.04565
G1 X127.06 Y137.284 E.02725
G1 X129.96 Y137.284 E.04565
G1 X129.96 Y136.603 E.01072
G1 X130.74 Y136.603 E.01228
G1 X130.74 Y137.224 E.00978
M204 S10000
G1 X130.581 Y136.944 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42359
G1 F1200
M204 S1000
G1 X130.299 Y136.944 E.00448
G1 X130.299 Y137.346 E.00639
G1 X130.401 Y137.346 E.00163
G1 X130.401 Y137.623 E.0044
G1 X132.601 Y137.623 E.03494
G1 X132.601 Y137.748 E.00198
G1 X127.399 Y137.748 E.08263
G1 X127.399 Y138.15 E.00639
G1 X132.601 Y138.15 E.08263
G1 X132.601 Y138.552 E.00639
G1 X127.399 Y138.552 E.08263
G1 X127.399 Y138.677 E.00198
G1 X130.299 Y138.677 E.04606
G1 X130.299 Y138.954 E.00441
G1 X130.401 Y138.954 E.00163
G1 X130.401 Y139.357 E.00639
G1 X130.119 Y139.357 E.00448
; OBJECT_ID: 7
; WIPE_START
G1 X130.401 Y139.357 E-.10711
G1 X130.401 Y138.954 E-.15281
G1 X130.299 Y138.954 E-.03896
G1 X130.299 Y138.677 E-.10546
G1 X129.363 Y138.677 E-.35567
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X129.363 Y138.583 Z2.3 F30000
G1 X127.493 Y138.581
G1 X113.707 Y137.87
G1 X100.456 Y137.568
G1 X99.411 Y137.165
G1 X99.411 Y137.135
G1 X99.44 Y137.135
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y137.135 E.23139
G1 X114.14 Y138.865 E.02723
G1 X99.44 Y138.865 E.23139
G1 X99.44 Y139.546 E.01072
G1 X99.06 Y139.546 E.00598
G1 X99.06 Y136.454 E.04867
G1 X99.44 Y136.454 E.00598
G1 X99.44 Y137.075 E.00978
; WIPE_START
M204 S1000
G1 X101.44 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y137.568 Z2.3 F30000
G1 X99.359 Y138
G1 X99.19 Y138.473
G1 X99.221 Y138.484
G1 Z1.9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X113.786 Y138.484 E.24653
G1 X113.786 Y138 E.00818
G1 X99.414 Y138 E.24327
G1 X99.414 Y137.516 E.00818
G1 X113.979 Y137.516 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X111.979 Y137.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.979 Y137.568 Z2.3 F30000
G1 X100.45 Y124.361
G1 X99.09 Y123.044
G1 X99.411 Y122.678
G1 X99.411 Y123.209
G1 X99.44 Y123.209
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y123.209 E.23139
G1 X114.14 Y124.791 E.0249
G1 X99.44 Y124.791 E.23139
G1 X99.44 Y125.546 E.01189
G1 X99.06 Y125.546 E.00598
G1 X99.06 Y122.454 E.04867
G1 X99.44 Y122.454 E.00598
G1 X99.44 Y123.149 E.01094
; WIPE_START
M204 S1000
G1 X101.44 Y123.157 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y123.642 Z2.3 F30000
G1 X99.33 Y124
G1 X99.186 Y124.422
G1 X99.221 Y124.434
G1 Z1.9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X113.786 Y124.434 E.24653
G1 X113.786 Y124 E.00735
G1 X99.414 Y124 E.24327
G1 X99.414 Y123.566 E.00735
G1 X113.979 Y123.566 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X111.979 Y123.566 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.979 Y123.642 Z2.3 F30000
G1 X99.411 Y110.712
M73 P92 R2
G1 X99.44 Y110.712
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X99.44 Y111.546 E.01313
G1 X99.06 Y111.546 E.00598
G1 X99.06 Y108.454 E.04867
G1 X99.44 Y108.454 E.00598
G1 X99.44 Y109.288 E.01313
G1 X114.14 Y109.288 E.23139
G1 X114.14 Y110.712 E.02242
G1 X99.5 Y110.712 E.23045
; WIPE_START
M204 S1000
G1 X99.44 Y111.546 E-.3177
G1 X99.06 Y111.546 E-.1444
G1 X99.06 Y110.762 E-.2979
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.112 Y110.768 Z2.3 F30000
G1 X100.456 Y110.279
G1 X113.707 Y110.279
G1 X113.707 Y110.199
G1 X113.979 Y110.199
G1 Z1.9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y110.199 E.24653
G1 X99.414 Y109.684 E.0087
G1 X113.979 Y109.684 E.24653
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X111.979 Y109.684 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 20/28
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
M106 S43.35
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.3 I-1.217 J0 P1  F30000
G1 X111.979 Y109.839 Z2.3
G1 X130.189 Y109.581
G1 X130.511 Y109.106
G1 X130.511 Y109.577
G1 X130.74 Y109.577
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.577 E.03463
G1 X132.94 Y110.723 E.01803
G1 X130.74 Y110.723 E.03463
G1 X130.74 Y111.627 E.01424
G1 X129.96 Y111.627 E.01228
G1 X129.96 Y110.723 E.01424
G1 X127.06 Y110.723 E.04565
G1 X127.06 Y109.577 E.01803
G1 X129.96 Y109.577 E.04565
G1 X129.96 Y108.673 E.01424
G1 X130.74 Y108.673 E.01228
G1 X130.74 Y109.517 E.01329
M204 S10000
G1 X130.35 Y109.784 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y108.88 E.01309
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y110.516 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X130.35 Y111.42 E.01309
; WIPE_START
G1 X130.35 Y110.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.781 Y110.367 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45456
G1 F1200
M204 S1000
G1 X130.883 Y110.367 E.03246
G1 X130.883 Y110.177 E.00324
G1 X129.817 Y110.177 E.01823
G1 X129.817 Y110.367 E.00324
G1 X127.399 Y110.367 E.04137
G1 X127.399 Y109.933 E.00741
G1 X129.817 Y109.933 E.04137
G1 X129.817 Y110.123 E.00324
G1 X130.883 Y110.123 E.01823
G1 X130.883 Y109.933 E.00324
G1 X132.781 Y109.933 E.03246
; OBJECT_ID: 5
; WIPE_START
G1 X130.883 Y109.933 E-.72115
G1 X130.883 Y110.036 E-.03885
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.915 Y109.904 Z2.4 F30000
G1 X130.504 Y123.494
G1 X130.74 Y123.487
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.487 E.03463
G1 X132.94 Y124.813 E.02087
G1 X130.74 Y124.813 E.03463
G1 X130.74 Y125.627 E.01281
G1 X129.96 Y125.627 E.01228
G1 X129.96 Y124.813 E.01281
G1 X127.06 Y124.813 E.04565
G1 X127.06 Y123.487 E.02087
G1 X129.96 Y123.487 E.04565
G1 X129.96 Y122.673 E.01282
G1 X130.74 Y122.673 E.01228
G1 X130.74 Y123.427 E.01187
M204 S10000
G1 X130.35 Y123.694 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38796
G1 F1200
M204 S1000
G1 X130.35 Y122.88 E.01178
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y124.606 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y125.42 E.01178
; WIPE_START
G1 X130.35 Y124.606 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.781 Y124.344 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4997
G1 F1200
M204 S1000
G1 X127.399 Y124.344 E.10166
G1 X127.399 Y123.866 E.00903
G1 X132.781 Y123.866 E.10166
; OBJECT_ID: 6
; WIPE_START
G1 X130.781 Y123.866 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X130.8 Y123.794 Z2.4 F30000
G1 X144.189 Y123.502
G1 X144.489 Y122.956
G1 X144.504 Y123.494
G1 X144.74 Y123.487
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.487 E.03463
G1 X146.94 Y124.813 E.02087
G1 X144.74 Y124.813 E.03463
G1 X144.74 Y125.627 E.01281
G1 X143.96 Y125.627 E.01228
G1 X143.96 Y124.813 E.01281
G1 X141.06 Y124.813 E.04565
G1 X141.06 Y123.487 E.02087
G1 X143.96 Y123.487 E.04565
G1 X143.96 Y122.673 E.01282
G1 X144.74 Y122.673 E.01228
G1 X144.74 Y123.427 E.01187
M204 S10000
G1 X144.35 Y123.694 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38796
G1 F1200
M204 S1000
G1 X144.35 Y122.88 E.01178
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y124.606 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y125.42 E.01178
; WIPE_START
G1 X144.35 Y124.606 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.781 Y124.344 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4997
G1 F1200
M204 S1000
G1 X141.399 Y124.344 E.10166
G1 X141.399 Y123.866 E.00903
G1 X146.781 Y123.866 E.10166
; OBJECT_ID: 3
; WIPE_START
G1 X144.781 Y123.866 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X144.8 Y123.794 Z2.4 F30000
G1 X144.742 Y110.438
G1 X144.511 Y109.807
G1 X144.511 Y109.577
G1 X144.74 Y109.577
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.577 E.03463
G1 X146.94 Y110.723 E.01803
M73 P93 R2
G1 X144.74 Y110.723 E.03463
G1 X144.74 Y111.627 E.01424
G1 X143.96 Y111.627 E.01228
G1 X143.96 Y110.723 E.01424
G1 X141.06 Y110.723 E.04565
G1 X141.06 Y109.577 E.01803
G1 X143.96 Y109.577 E.04565
G1 X143.96 Y108.673 E.01424
G1 X144.74 Y108.673 E.01228
G1 X144.74 Y109.517 E.01329
M204 S10000
G1 X144.35 Y109.784 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y108.88 E.01309
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y110.516 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F1200
M204 S1000
M73 P93 R1
G1 X144.35 Y111.42 E.01309
; WIPE_START
G1 X144.35 Y110.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.781 Y110.367 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45456
G1 F1200
M204 S1000
G1 X144.883 Y110.367 E.03246
G1 X144.883 Y110.177 E.00324
G1 X143.817 Y110.177 E.01823
G1 X143.817 Y110.367 E.00324
G1 X141.399 Y110.367 E.04137
G1 X141.399 Y109.933 E.00741
G1 X143.817 Y109.933 E.04137
G1 X143.817 Y110.123 E.00324
G1 X144.883 Y110.123 E.01823
G1 X144.883 Y109.933 E.00324
G1 X146.781 Y109.933 E.03246
; OBJECT_ID: 9
; WIPE_START
G1 X144.883 Y109.933 E-.72115
G1 X144.883 Y110.036 E-.03885
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.915 Y109.904 Z2.4 F30000
G1 X144.811 Y123.797
G1 X144.807 Y124.504
G1 X144.667 Y137.673
G1 X144.74 Y137.402
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y137.402 E.03463
G1 X146.94 Y138.898 E.02354
; object ids of layer 20 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer20 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y138.898 E.03463
G1 X144.74 Y139.627 E.01148
G1 X143.96 Y139.627 E.01228
G1 X143.96 Y138.898 E.01148
G1 X141.06 Y138.898 E.04565
G1 X141.06 Y137.402 E.02354
G1 X143.96 Y137.402 E.04565
G1 X143.96 Y136.673 E.01148
G1 X144.74 Y136.673 E.01228
G1 X144.74 Y137.342 E.01053
M204 S10000
G1 X144.581 Y137.035 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4673
G1 F1200
M204 S1000
G1 X144.299 Y137.035 E.00496
G1 X144.299 Y137.481 E.00785
G1 X144.401 Y137.481 E.00181
G1 X144.401 Y137.741 E.00457
G1 X146.601 Y137.741 E.03874
G1 X146.601 Y137.927 E.00328
G1 X141.399 Y137.927 E.09161
G1 X141.399 Y138.373 E.00785
G1 X146.601 Y138.373 E.09161
G1 X146.601 Y138.559 E.00328
G1 X144.401 Y138.559 E.03874
G1 X144.401 Y138.819 E.00457
G1 X144.299 Y138.819 E.00181
G1 X144.299 Y139.265 E.00785
G1 X144.581 Y139.265 E.00496
; OBJECT_ID: 8
; WIPE_START
G1 X144.299 Y139.265 E-.10711
G1 X144.299 Y138.819 E-.16942
G1 X144.401 Y138.819 E-.03896
G1 X144.401 Y138.559 E-.09864
G1 X145.311 Y138.559 E-.34587
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X145.311 Y138.465 Z2.4 F30000
G1 X141.493 Y138.256
G1 X130.667 Y137.673
G1 X130.74 Y137.402
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y137.402 E.03463
G1 X132.94 Y138.898 E.02354
G1 X130.74 Y138.898 E.03463
G1 X130.74 Y139.627 E.01148
G1 X129.96 Y139.627 E.01228
G1 X129.96 Y138.898 E.01148
G1 X127.06 Y138.898 E.04565
G1 X127.06 Y137.402 E.02354
G1 X129.96 Y137.402 E.04565
G1 X129.96 Y136.673 E.01148
G1 X130.74 Y136.673 E.01228
G1 X130.74 Y137.342 E.01053
M204 S10000
G1 X130.581 Y137.035 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4673
G1 F1200
M204 S1000
G1 X130.299 Y137.035 E.00496
G1 X130.299 Y137.481 E.00785
G1 X130.401 Y137.481 E.00181
G1 X130.401 Y137.741 E.00457
G1 X132.601 Y137.741 E.03874
G1 X132.601 Y137.927 E.00328
G1 X127.399 Y137.927 E.09161
G1 X127.399 Y138.373 E.00785
G1 X132.601 Y138.373 E.09161
G1 X132.601 Y138.559 E.00328
G1 X130.401 Y138.559 E.03874
G1 X130.401 Y138.819 E.00457
G1 X130.299 Y138.819 E.00181
G1 X130.299 Y139.265 E.00785
G1 X130.581 Y139.265 E.00496
; OBJECT_ID: 7
; WIPE_START
G1 X130.299 Y139.265 E-.10711
G1 X130.299 Y138.819 E-.16942
G1 X130.401 Y138.819 E-.03896
G1 X130.401 Y138.559 E-.09864
G1 X131.311 Y138.559 E-.34587
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X131.311 Y138.465 Z2.4 F30000
G1 X127.493 Y138.402
G1 X113.707 Y137.837
G1 X100.456 Y137.685
G1 X99.411 Y137.281
G1 X99.411 Y137.252
G1 X99.44 Y137.252
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y137.252 E.23139
G1 X114.14 Y138.748 E.02355
G1 X99.44 Y138.748 E.23139
G1 X99.44 Y139.476 E.01146
G1 X99.06 Y139.476 E.00598
G1 X99.06 Y136.524 E.04648
G1 X99.44 Y136.524 E.00598
G1 X99.44 Y137.192 E.01052
; WIPE_START
M204 S1000
G1 X101.44 Y137.2 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y137.685 Z2.4 F30000
G1 X113.707 Y137.685
G1 X113.979 Y137.648
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y137.648 E.24653
G1 X99.414 Y138.163 E.0087
G1 X113.979 Y138.163 E.24653
; OBJECT_ID: 4
; WIPE_START
G1 X111.979 Y138.163 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.979 Y138.315 Z2.4 F30000
G1 X100.263 Y124.311
G1 X99.089 Y123.09
G1 X99.411 Y122.807
G1 X99.411 Y123.338
G1 X99.44 Y123.338
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y123.338 E.23139
G1 X114.14 Y124.662 E.02084
G1 X99.44 Y124.662 E.23139
G1 X99.44 Y125.476 E.01282
G1 X99.06 Y125.476 E.00598
G1 X99.06 Y122.524 E.04648
G1 X99.44 Y122.524 E.00598
G1 X99.44 Y123.278 E.01187
; WIPE_START
M204 S1000
G1 X101.44 Y123.286 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y123.771 Z2.4 F30000
G1 X113.707 Y123.771
G1 X113.979 Y123.735
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X99.414 Y123.735 E.24653
G1 X99.414 Y124.249 E.0087
G1 X113.979 Y124.249 E.24653
; OBJECT_ID: 1
; WIPE_START
G1 X111.979 Y124.249 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.979 Y124.229 Z2.4 F30000
G1 X111.575 Y123.771
G1 X100.162 Y110.281
G1 X99.122 Y109.545
G1 X99.411 Y108.957
G1 X99.411 Y109.428
G1 X99.44 Y109.428
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y109.428 E.23139
G1 X114.14 Y110.572 E.01801
G1 X99.44 Y110.572 E.23139
G1 X99.44 Y111.476 E.01423
G1 X99.06 Y111.476 E.00598
G1 X99.06 Y108.524 E.04648
G1 X99.44 Y108.524 E.00598
G1 X99.44 Y109.368 E.01329
; WIPE_START
M204 S1000
G1 X101.44 Y109.376 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y109.839 Z2.4 F30000
G1 X113.707 Y109.847
G1 X113.981 Y109.784
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45411
G1 F1200
M204 S1000
G1 X99.399 Y109.784 E.24918
G1 X99.399 Y110.216 E.00739
G1 X113.981 Y110.216 E.24918
; CHANGE_LAYER
; Z_HEIGHT: 2.1
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X111.981 Y110.216 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 21/28
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
M106 S53.55
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F30000
G1 X111.981 Y110.161 Z2.4
G1 X130.185 Y109.779
G1 X130.517 Y109.989
G1 X130.74 Y109.989
G1 X130.74 Y109.766
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y109.766 E.03463
G1 X132.94 Y110.534 E.01209
G1 X130.74 Y110.534 E.03463
G1 X130.74 Y111.548 E.01597
G1 X129.96 Y111.548 E.01228
G1 X129.96 Y110.534 E.01597
G1 X127.06 Y110.534 E.04565
G1 X127.06 Y109.766 E.01209
G1 X129.96 Y109.766 E.04565
G1 X129.96 Y108.752 E.01596
G1 X130.74 Y108.752 E.01228
G1 X130.74 Y109.706 E.01502
M204 S10000
G1 X130.533 Y110.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.395614
G1 F1200
M204 S1000
G1 X130.487 Y110.15 E.00068
; LINE_WIDTH: 0.434441
G1 X130.442 Y110.15 E.00075
; LINE_WIDTH: 0.473267
G1 X130.396 Y110.15 E.00082
; LINE_WIDTH: 0.512094
G1 X130.35 Y110.15 E.00089
; LINE_WIDTH: 0.507591
G1 X130.35 Y110.209 E.00114
; LINE_WIDTH: 0.459731
G1 X130.35 Y110.268 E.00102
; LINE_WIDTH: 0.389268
G1 X130.35 Y111.342 E.01559
; WIPE_START
G1 X130.35 Y110.268 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.733 Y110.15 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.37619
G1 F1200
M204 S1000
G1 X130.533 Y110.15 E.03082
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y108.958 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.389268
G1 F1200
M204 S1000
G1 X130.35 Y110.032 E.01559
; LINE_WIDTH: 0.459727
G1 X130.35 Y110.091 E.00102
; LINE_WIDTH: 0.507571
G1 X130.35 Y110.15 E.00114
; LINE_WIDTH: 0.512091
M73 P94 R1
G1 X130.304 Y110.15 E.00089
; LINE_WIDTH: 0.47326
G1 X130.258 Y110.15 E.00082
; LINE_WIDTH: 0.434428
G1 X130.213 Y110.15 E.00075
; LINE_WIDTH: 0.376492
G1 X127.267 Y110.15 E.04131
; OBJECT_ID: 5
; WIPE_START
G1 X129.267 Y110.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X129.267 Y109.989 Z2.5 F30000
G1 X130.511 Y123.651
G1 X130.74 Y123.651
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.651 E.03463
G1 X132.94 Y124.648 E.01569
G1 X130.74 Y124.648 E.03463
G1 X130.74 Y125.548 E.01417
G1 X129.96 Y125.548 E.01228
G1 X129.96 Y124.648 E.01417
G1 X127.06 Y124.648 E.04565
G1 X127.06 Y123.651 E.01569
G1 X129.96 Y123.651 E.04565
G1 X129.96 Y122.752 E.01416
G1 X130.74 Y122.752 E.01228
G1 X130.74 Y123.591 E.01322
M204 S10000
G1 X130.533 Y124.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.60499
G1 F1200
M204 S1000
G1 X132.733 Y124.15 E.0507
; WIPE_START
G1 X130.733 Y124.15 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.35 Y125.342 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.38897
G1 F1200
M204 S1000
G1 X130.35 Y124.4 E.01367
; LINE_WIDTH: 0.457067
G1 X130.35 Y124.358 E.00072
; LINE_WIDTH: 0.503151
G1 X130.35 Y124.317 E.00079
; LINE_WIDTH: 0.549235
G1 X130.35 Y124.275 E.00087
; LINE_WIDTH: 0.59532
G1 X130.35 Y124.233 E.00094
; LINE_WIDTH: 0.641404
G1 X130.35 Y124.192 E.00102
; LINE_WIDTH: 0.687488
G1 X130.35 Y124.15 E.0011
; LINE_WIDTH: 0.692956
G1 X130.411 Y124.15 E.00162
; LINE_WIDTH: 0.657774
G1 X130.472 Y124.15 E.00154
; LINE_WIDTH: 0.622591
G1 X130.533 Y124.15 E.00145
M204 S10000
G1 X130.35 Y124.15 F30000
; LINE_WIDTH: 0.692944
G1 F1200
M204 S1000
G1 X130.289 Y124.15 E.00162
; LINE_WIDTH: 0.657758
G1 X130.228 Y124.15 E.00154
; LINE_WIDTH: 0.605353
G1 X127.267 Y124.15 E.06829
; OBJECT_ID: 6
; WIPE_START
G1 X129.267 Y124.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.267 Y123.989 Z2.5 F30000
G1 X132.507 Y124.046
G1 X144.189 Y123.669
G1 X144.511 Y123.185
G1 X144.511 Y123.651
G1 X144.74 Y123.651
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.651 E.03463
G1 X146.94 Y124.648 E.01569
G1 X144.74 Y124.648 E.03463
G1 X144.74 Y125.548 E.01417
G1 X143.96 Y125.548 E.01228
G1 X143.96 Y124.648 E.01417
G1 X141.06 Y124.648 E.04565
G1 X141.06 Y123.651 E.01569
G1 X143.96 Y123.651 E.04565
G1 X143.96 Y122.752 E.01416
G1 X144.74 Y122.752 E.01228
G1 X144.74 Y123.591 E.01322
M204 S10000
G1 X144.533 Y124.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.60499
G1 F1200
M204 S1000
G1 X146.733 Y124.15 E.0507
; WIPE_START
G1 X144.733 Y124.15 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.35 Y125.342 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.38897
G1 F1200
M204 S1000
G1 X144.35 Y124.4 E.01367
; LINE_WIDTH: 0.457067
G1 X144.35 Y124.358 E.00072
; LINE_WIDTH: 0.503151
G1 X144.35 Y124.317 E.00079
; LINE_WIDTH: 0.549235
G1 X144.35 Y124.275 E.00087
; LINE_WIDTH: 0.59532
G1 X144.35 Y124.233 E.00094
; LINE_WIDTH: 0.641404
G1 X144.35 Y124.192 E.00102
; LINE_WIDTH: 0.687488
G1 X144.35 Y124.15 E.0011
; LINE_WIDTH: 0.692956
G1 X144.411 Y124.15 E.00162
; LINE_WIDTH: 0.657774
G1 X144.472 Y124.15 E.00154
; LINE_WIDTH: 0.622591
G1 X144.533 Y124.15 E.00145
M204 S10000
G1 X144.35 Y124.15 F30000
; LINE_WIDTH: 0.692944
G1 F1200
M204 S1000
G1 X144.289 Y124.15 E.00162
; LINE_WIDTH: 0.657758
G1 X144.228 Y124.15 E.00154
; LINE_WIDTH: 0.605353
G1 X141.267 Y124.15 E.06829
; OBJECT_ID: 3
; WIPE_START
G1 X143.267 Y124.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.267 Y123.989 Z2.5 F30000
G1 X144.684 Y110.311
G1 X146.439 Y109.989
G1 X144.74 Y109.989
G1 X144.74 Y109.766
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y109.766 E.03463
G1 X146.94 Y110.534 E.01209
G1 X144.74 Y110.534 E.03463
G1 X144.74 Y111.548 E.01597
G1 X143.96 Y111.548 E.01228
G1 X143.96 Y110.534 E.01597
G1 X141.06 Y110.534 E.04565
G1 X141.06 Y109.766 E.01209
G1 X143.96 Y109.766 E.04565
G1 X143.96 Y108.752 E.01596
G1 X144.74 Y108.752 E.01228
G1 X144.74 Y109.706 E.01502
M204 S10000
G1 X144.533 Y110.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.395614
G1 F1200
M204 S1000
G1 X144.487 Y110.15 E.00068
; LINE_WIDTH: 0.434441
G1 X144.442 Y110.15 E.00075
; LINE_WIDTH: 0.473267
G1 X144.396 Y110.15 E.00082
; LINE_WIDTH: 0.512094
G1 X144.35 Y110.15 E.00089
; LINE_WIDTH: 0.507591
G1 X144.35 Y110.209 E.00114
; LINE_WIDTH: 0.459731
G1 X144.35 Y110.268 E.00102
; LINE_WIDTH: 0.389268
G1 X144.35 Y111.342 E.01559
; WIPE_START
G1 X144.35 Y110.268 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.733 Y110.15 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.37619
G1 F1200
M204 S1000
G1 X144.533 Y110.15 E.03082
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y108.958 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.389268
G1 F1200
M204 S1000
G1 X144.35 Y110.032 E.01559
; LINE_WIDTH: 0.459727
G1 X144.35 Y110.091 E.00102
; LINE_WIDTH: 0.507571
G1 X144.35 Y110.15 E.00114
; LINE_WIDTH: 0.512091
G1 X144.304 Y110.15 E.00089
; LINE_WIDTH: 0.47326
G1 X144.258 Y110.15 E.00082
; LINE_WIDTH: 0.434428
G1 X144.213 Y110.15 E.00075
; LINE_WIDTH: 0.376492
G1 X141.267 Y110.15 E.04131
; OBJECT_ID: 9
; WIPE_START
G1 X143.267 Y110.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X143.267 Y109.989 Z2.5 F30000
G1 X144.006 Y123.907
G1 X144.033 Y124.397
G1 X144.504 Y137.556
G1 X144.74 Y137.549
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y137.549 E.03463
G1 X146.94 Y138.75 E.01891
; object ids of layer 21 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer21 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y138.75 E.03463
G1 X144.74 Y139.548 E.01256
G1 X143.96 Y139.548 E.01228
G1 X143.96 Y138.75 E.01256
G1 X141.06 Y138.75 E.04565
G1 X141.06 Y137.549 E.01891
G1 X143.96 Y137.549 E.04565
G1 X143.96 Y136.752 E.01256
G1 X144.74 Y136.752 E.01228
G1 X144.74 Y137.489 E.01161
M204 S10000
G1 X144.35 Y137.756 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y136.958 E.01155
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y138.544 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X144.35 Y139.342 E.01155
; WIPE_START
G1 X144.35 Y138.544 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.781 Y138.381 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.48251
G1 F1200
M204 S1000
G1 X141.399 Y138.381 E.098
G1 X141.399 Y137.919 E.0084
G1 X146.781 Y137.919 E.098
; OBJECT_ID: 8
; WIPE_START
G1 X144.781 Y137.919 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X144.798 Y137.856 Z2.5 F30000
G1 X143.763 Y137.893
G1 X130.504 Y137.556
G1 X130.74 Y137.549
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y137.549 E.03463
G1 X132.94 Y138.75 E.01891
G1 X130.74 Y138.75 E.03463
G1 X130.74 Y139.548 E.01256
G1 X129.96 Y139.548 E.01228
G1 X129.96 Y138.75 E.01256
G1 X127.06 Y138.75 E.04565
G1 X127.06 Y137.549 E.01891
G1 X129.96 Y137.549 E.04565
G1 X129.96 Y136.752 E.01256
G1 X130.74 Y136.752 E.01228
G1 X130.74 Y137.489 E.01161
M204 S10000
G1 X130.35 Y137.756 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y136.958 E.01155
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y138.544 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X130.35 Y139.342 E.01155
; WIPE_START
G1 X130.35 Y138.544 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.781 Y138.381 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.48251
G1 F1200
M204 S1000
G1 X127.399 Y138.381 E.098
G1 X127.399 Y137.919 E.0084
G1 X132.781 Y137.919 E.098
; OBJECT_ID: 7
; WIPE_START
G1 X130.781 Y137.919 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X130.798 Y137.856 Z2.5 F30000
G1 X129.728 Y137.902
G1 X99.411 Y137.4
G1 X99.44 Y137.4
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y137.4 E.23139
G1 X114.14 Y138.6 E.01888
G1 X99.44 Y138.6 E.23139
G1 X99.44 Y139.397 E.01256
G1 X99.06 Y139.397 E.00598
G1 X99.06 Y136.603 E.04399
G1 X99.44 Y136.603 E.00598
G1 X99.44 Y137.34 E.01161
; WIPE_START
M204 S1000
G1 X101.44 Y137.349 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.44 Y137.833 Z2.5 F30000
G1 X113.707 Y137.833
G1 X113.981 Y137.77
G1 Z2.1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.48159
G1 F1200
M204 S1000
G1 X99.399 Y137.77 E.265
G1 X99.399 Y138.23 E.00836
G1 X113.981 Y138.23 E.265
; OBJECT_ID: 4
; WIPE_START
G1 X111.981 Y138.23 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.981 Y138.167 Z2.5 F30000
G1 X111.643 Y137.833
G1 X100.086 Y124.26
G1 X99.113 Y123.571
G1 X99.411 Y123.035
G1 X99.411 Y123.502
G1 X99.44 Y123.502
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y123.502 E.23139
G1 X114.14 Y124.498 E.01569
G1 X99.44 Y124.498 E.23139
G1 X99.44 Y125.397 E.01415
G1 X99.06 Y125.397 E.00598
G1 X99.06 Y122.603 E.04399
G1 X99.44 Y122.603 E.00598
G1 X99.44 Y123.442 E.01321
M204 S10000
G1 X99.267 Y124 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.6044
G1 F1200
M204 S1000
G1 X113.933 Y124 E.33768
; OBJECT_ID: 1
; WIPE_START
G1 X111.933 Y124 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.933 Y123.839 Z2.5 F30000
G1 X99.411 Y110.383
G1 X99.44 Y110.383
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P95 R1
G1 F1200
M204 S500
G1 X99.44 Y111.397 E.01597
G1 X99.06 Y111.397 E.00598
G1 X99.06 Y108.603 E.04399
G1 X99.44 Y108.603 E.00598
G1 X99.44 Y109.617 E.01597
G1 X114.14 Y109.617 E.23139
G1 X114.14 Y110.383 E.01205
G1 X99.5 Y110.383 E.23045
M204 S10000
G1 X99.267 Y110 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.3736
G1 F1200
M204 S1000
G1 X113.933 Y110 E.20399
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X111.933 Y110 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 22/28
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
M106 S61.2
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.5 I1.217 J0 P1  F30000
G1 X111.933 Y109.839 Z2.5
G1 X113.707 Y110.009
G1 X127.493 Y110.077
G1 X129.86 Y109.989
G1 X129.86 Y109.989
G1 X129.96 Y110.09
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X129.96 Y108.841 E.01965
G1 X130.74 Y108.841 E.01228
G1 X130.74 Y110.09 E.01965
G1 X132.94 Y110.09 E.03463
G1 X132.94 Y110.21 E.0019
G1 X130.74 Y110.21 E.03463
G1 X130.74 Y111.459 E.01965
G1 X129.96 Y111.459 E.01228
G1 X129.96 Y110.21 E.01965
G1 X127.06 Y110.21 E.04565
G1 X127.06 Y110.09 E.0019
G1 X129.9 Y110.09 E.0447
; WIPE_START
M204 S1000
G1 X129.96 Y108.841 E-.47483
G1 X130.71 Y108.841 E-.28517
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.511 Y109.274 Z2.6 F30000
G1 X130.35 Y109.274
G1 X130.35 Y109.048
G1 Z2.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y111.252 E.0319
; OBJECT_ID: 5
; WIPE_START
G1 X130.35 Y109.252 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.35 Y109.274 Z2.6 F30000
G1 X130.397 Y111.026
G1 X130.74 Y123.989
G1 X130.74 Y123.888
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y123.888 E.03463
G1 X132.94 Y124.412 E.00825
G1 X130.74 Y124.412 E.03463
G1 X130.74 Y125.459 E.01648
G1 X129.96 Y125.459 E.01228
G1 X129.96 Y124.412 E.01648
G1 X127.06 Y124.412 E.04565
G1 X127.06 Y123.888 E.00825
G1 X129.96 Y123.888 E.04565
G1 X129.96 Y122.841 E.01647
G1 X130.74 Y122.841 E.01228
G1 X130.74 Y123.828 E.01553
M204 S10000
G1 X130.533 Y124.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.154576
G1 F1200
M204 S1000
G1 X130.503 Y124.15 E.00016
; LINE_WIDTH: 0.199968
G1 X130.472 Y124.15 E.00022
; LINE_WIDTH: 0.24536
G1 X130.442 Y124.15 E.00027
; LINE_WIDTH: 0.290753
G1 X130.411 Y124.15 E.00032
; LINE_WIDTH: 0.336145
G1 X130.381 Y124.15 E.00038
; LINE_WIDTH: 0.388174
G1 X130.35 Y124.15 E.00044
G1 X130.35 Y125.252 E.01596
; WIPE_START
G1 X130.35 Y124.15 E-.7395
G1 X130.381 Y124.15 E-.0205
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.733 Y124.15 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.13188
G1 F1200
M204 S1000
G1 X130.533 Y124.15 E.00959
G1 E-.8 F1800
M204 S10000
G1 X130.35 Y123.048 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.388358
G1 F1200
M204 S1000
G1 X130.35 Y124.15 E.01597
; LINE_WIDTH: 0.381519
G1 X130.319 Y124.15 E.00043
; LINE_WIDTH: 0.33613
G1 X130.289 Y124.15 E.00038
; LINE_WIDTH: 0.290741
G1 X130.258 Y124.15 E.00032
; LINE_WIDTH: 0.245352
G1 X130.228 Y124.15 E.00027
; LINE_WIDTH: 0.199964
G1 X130.197 Y124.15 E.00022
; LINE_WIDTH: 0.132117
G1 X127.267 Y124.15 E.01281
; OBJECT_ID: 6
; WIPE_START
G1 X129.267 Y124.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.267 Y124.311 Z2.6 F30000
G1 X132.507 Y124.095
G1 X144.08 Y123.899
G1 X144.639 Y123.989
G1 X144.74 Y123.989
G1 X144.74 Y123.888
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y123.888 E.03463
G1 X146.94 Y124.412 E.00825
G1 X144.74 Y124.412 E.03463
G1 X144.74 Y125.459 E.01648
G1 X143.96 Y125.459 E.01228
G1 X143.96 Y124.412 E.01648
G1 X141.06 Y124.412 E.04565
G1 X141.06 Y123.888 E.00825
G1 X143.96 Y123.888 E.04565
G1 X143.96 Y122.841 E.01647
G1 X144.74 Y122.841 E.01228
G1 X144.74 Y123.828 E.01553
M204 S10000
G1 X144.533 Y124.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.154576
G1 F1200
M204 S1000
G1 X144.503 Y124.15 E.00016
; LINE_WIDTH: 0.199968
G1 X144.472 Y124.15 E.00022
; LINE_WIDTH: 0.24536
G1 X144.442 Y124.15 E.00027
; LINE_WIDTH: 0.290753
G1 X144.411 Y124.15 E.00032
; LINE_WIDTH: 0.336145
G1 X144.381 Y124.15 E.00038
; LINE_WIDTH: 0.388174
G1 X144.35 Y124.15 E.00044
G1 X144.35 Y125.252 E.01596
; WIPE_START
G1 X144.35 Y124.15 E-.7395
G1 X144.381 Y124.15 E-.0205
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.733 Y124.15 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.13188
G1 F1200
M204 S1000
G1 X144.533 Y124.15 E.00959
G1 E-.8 F1800
M204 S10000
G1 X144.35 Y123.048 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.388358
G1 F1200
M204 S1000
G1 X144.35 Y124.15 E.01597
; LINE_WIDTH: 0.381519
G1 X144.319 Y124.15 E.00043
; LINE_WIDTH: 0.33613
G1 X144.289 Y124.15 E.00038
; LINE_WIDTH: 0.290741
G1 X144.258 Y124.15 E.00032
; LINE_WIDTH: 0.245352
G1 X144.228 Y124.15 E.00027
; LINE_WIDTH: 0.199964
G1 X144.197 Y124.15 E.00022
; LINE_WIDTH: 0.132117
G1 X141.267 Y124.15 E.01281
; OBJECT_ID: 3
; WIPE_START
G1 X143.267 Y124.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.267 Y124.311 Z2.6 F30000
G1 X143.86 Y109.989
G1 X143.96 Y110.09
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X143.96 Y108.841 E.01965
G1 X144.74 Y108.841 E.01228
G1 X144.74 Y110.09 E.01965
G1 X146.94 Y110.09 E.03463
G1 X146.94 Y110.21 E.0019
G1 X144.74 Y110.21 E.03463
G1 X144.74 Y111.459 E.01965
G1 X143.96 Y111.459 E.01228
G1 X143.96 Y110.21 E.01965
G1 X141.06 Y110.21 E.04565
G1 X141.06 Y110.09 E.0019
G1 X143.9 Y110.09 E.0447
; WIPE_START
M204 S1000
G1 X143.96 Y108.841 E-.47483
G1 X144.71 Y108.841 E-.28517
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.511 Y109.274 Z2.6 F30000
G1 X144.35 Y109.274
G1 X144.35 Y109.048
G1 Z2.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y111.252 E.0319
; OBJECT_ID: 9
; WIPE_START
G1 X144.35 Y109.252 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.35 Y109.274 Z2.6 F30000
G1 X144.374 Y111.026
G1 X144.545 Y123.528
G1 X144.561 Y124.693
G1 X144.511 Y137.746
G1 X144.74 Y137.746
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X146.94 Y137.746 E.03463
G1 X146.94 Y138.554 E.01272
; object ids of layer 22 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer22 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y138.554 E.03463
G1 X144.74 Y139.459 E.01424
G1 X143.96 Y139.459 E.01228
G1 X143.96 Y138.554 E.01424
G1 X141.06 Y138.554 E.04565
G1 X141.06 Y137.746 E.01272
G1 X143.96 Y137.746 E.04565
G1 X143.96 Y136.841 E.01424
G1 X144.74 Y136.841 E.01228
G1 X144.74 Y137.686 E.01329
M204 S10000
G1 X144.35 Y138.002 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.389061
G1 F1200
M204 S1000
G1 X144.35 Y137.048 E.01385
M204 S10000
G1 X144.35 Y138.002 F30000
; LINE_WIDTH: 0.452395
G1 F1200
M204 S1000
G1 X144.35 Y138.051 E.00084
; LINE_WIDTH: 0.495352
G1 X144.35 Y138.101 E.00092
; LINE_WIDTH: 0.538309
G1 X144.35 Y138.15 E.00101
M204 S10000
G1 X144.35 Y138.15 F30000
; LINE_WIDTH: 0.535805
G1 F1200
M204 S1000
G1 X144.411 Y138.15 E.00124
; LINE_WIDTH: 0.4878
G1 X144.472 Y138.15 E.00113
; LINE_WIDTH: 0.4398
G1 X144.533 Y138.15 E.00101
; LINE_WIDTH: 0.41579
G1 X146.733 Y138.15 E.03426
; WIPE_START
G1 X144.733 Y138.15 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.35 Y139.252 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.38907
G1 F1200
M204 S1000
G1 X144.35 Y138.298 E.01385
; LINE_WIDTH: 0.4524
G1 X144.35 Y138.249 E.00084
; LINE_WIDTH: 0.49536
G1 X144.35 Y138.199 E.00092
; LINE_WIDTH: 0.538321
G1 X144.35 Y138.15 E.00101
; LINE_WIDTH: 0.535801
M73 P96 R1
G1 X144.289 Y138.15 E.00124
; LINE_WIDTH: 0.4878
G1 X144.228 Y138.15 E.00113
; LINE_WIDTH: 0.416295
G1 X141.267 Y138.15 E.04618
; OBJECT_ID: 8
; WIPE_START
G1 X143.267 Y138.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X143.267 Y137.989 Z2.6 F30000
G1 X141.493 Y138.093
G1 X130.511 Y137.746
G1 X130.74 Y137.746
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X132.94 Y137.746 E.03463
G1 X132.94 Y138.554 E.01272
G1 X130.74 Y138.554 E.03463
G1 X130.74 Y139.459 E.01424
G1 X129.96 Y139.459 E.01228
G1 X129.96 Y138.554 E.01424
G1 X127.06 Y138.554 E.04565
G1 X127.06 Y137.746 E.01272
G1 X129.96 Y137.746 E.04565
G1 X129.96 Y136.841 E.01424
G1 X130.74 Y136.841 E.01228
G1 X130.74 Y137.686 E.01329
M204 S10000
G1 X130.35 Y138.002 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.389061
G1 F1200
M204 S1000
G1 X130.35 Y137.048 E.01385
M204 S10000
G1 X130.35 Y138.002 F30000
; LINE_WIDTH: 0.452395
G1 F1200
M204 S1000
G1 X130.35 Y138.051 E.00084
; LINE_WIDTH: 0.495352
G1 X130.35 Y138.101 E.00092
; LINE_WIDTH: 0.538309
G1 X130.35 Y138.15 E.00101
M204 S10000
G1 X130.35 Y138.15 F30000
; LINE_WIDTH: 0.535805
G1 F1200
M204 S1000
G1 X130.411 Y138.15 E.00124
; LINE_WIDTH: 0.4878
G1 X130.472 Y138.15 E.00113
; LINE_WIDTH: 0.4398
G1 X130.533 Y138.15 E.00101
; LINE_WIDTH: 0.41579
G1 X132.733 Y138.15 E.03426
; WIPE_START
G1 X130.733 Y138.15 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.35 Y139.252 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.38907
G1 F1200
M204 S1000
G1 X130.35 Y138.298 E.01385
; LINE_WIDTH: 0.4524
G1 X130.35 Y138.249 E.00084
; LINE_WIDTH: 0.49536
G1 X130.35 Y138.199 E.00092
; LINE_WIDTH: 0.538321
G1 X130.35 Y138.15 E.00101
; LINE_WIDTH: 0.535801
G1 X130.289 Y138.15 E.00124
; LINE_WIDTH: 0.4878
G1 X130.228 Y138.15 E.00113
; LINE_WIDTH: 0.416295
G1 X127.267 Y138.15 E.04618
; OBJECT_ID: 7
; WIPE_START
G1 X129.267 Y138.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X129.267 Y137.989 Z2.6 F30000
G1 X127.493 Y138.117
G1 X113.595 Y137.86
G1 X100.456 Y137.839
G1 X99.971 Y137.818
G1 X99.411 Y137.626
G1 X99.411 Y137.597
G1 X99.44 Y137.597
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y137.597 E.23139
G1 X114.14 Y138.403 E.01268
G1 X99.44 Y138.403 E.23139
G1 X99.44 Y139.308 E.01424
G1 X99.06 Y139.308 E.00598
G1 X99.06 Y136.692 E.04117
G1 X99.44 Y136.692 E.00598
G1 X99.44 Y137.537 E.0133
M204 S10000
G1 X99.267 Y138 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.41372
G1 F1200
M204 S1000
G1 X113.933 Y138 E.22723
; OBJECT_ID: 4
; WIPE_START
G1 X111.933 Y138 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X111.933 Y137.839 Z2.6 F30000
G1 X99.824 Y124.179
G1 X99.106 Y123.761
G1 X99.411 Y123.209
G1 X99.411 Y123.741
G1 X99.44 Y123.741
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y123.741 E.23139
G1 X114.14 Y124.259 E.00816
G1 X99.44 Y124.259 E.23139
G1 X99.44 Y125.308 E.0165
G1 X99.06 Y125.308 E.00598
G1 X99.06 Y122.692 E.04117
G1 X99.44 Y122.692 E.00598
G1 X99.44 Y123.681 E.01556
M204 S10000
G1 X99.267 Y124 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.12664
G1 F1200
M204 S1000
G1 X113.933 Y124 E.06093
; OBJECT_ID: 1
; WIPE_START
G1 X111.933 Y124 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X111.933 Y123.839 Z2.6 F30000
G1 X99.545 Y109.839
G1 X99.44 Y109.945
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X114.14 Y109.945 E.23139
G1 X114.14 Y110.055 E.00174
G1 X99.44 Y110.055 E.23139
G1 X99.44 Y111.308 E.01971
G1 X99.06 Y111.308 E.00598
G1 X99.06 Y108.692 E.04117
G1 X99.44 Y108.692 E.00598
G1 X99.44 Y109.885 E.01877
; CHANGE_LAYER
; Z_HEIGHT: 2.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
M204 S1000
G1 X101.44 Y109.893 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 23/28
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
M106 S76.5
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.6 I.022 J1.217 P1  F30000
G1 X130.244 Y109.376 Z2.6
G1 X130.244 Y109.376
G1 X130.244 Y109.376
G1 X129.96 Y108.944
G1 Z2.3
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y108.944 E.01228
G1 X130.74 Y111.356 E.03798
G1 X129.96 Y111.356 E.01228
G1 X129.96 Y109.004 E.03703
M204 S10000
G1 X130.35 Y109.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y111.149 E.02894
; OBJECT_ID: 5
; WIPE_START
G1 X130.35 Y109.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.35 Y109.376 Z2.7 F30000
G1 X130.3 Y110.923
G1 X130.244 Y123.376
G1 X129.96 Y122.944
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y122.944 E.01228
G1 X130.74 Y125.356 E.03798
G1 X129.96 Y125.356 E.01228
G1 X129.96 Y123.004 E.03703
M204 S10000
G1 X130.35 Y123.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y125.149 E.02894
; OBJECT_ID: 6
; WIPE_START
G1 X130.35 Y123.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X130.35 Y123.376 Z2.7 F30000
G1 X144.244 Y123.376
G1 X143.96 Y122.944
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y122.944 E.01228
G1 X144.74 Y125.356 E.03798
G1 X143.96 Y125.356 E.01228
G1 X143.96 Y123.004 E.03703
M204 S10000
G1 X144.35 Y123.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y125.149 E.02894
; OBJECT_ID: 3
; WIPE_START
G1 X144.35 Y123.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X144.35 Y123.376 Z2.7 F30000
G1 X144.255 Y110.923
G1 X144.189 Y109.493
G1 X144.244 Y109.376
G1 X143.96 Y108.944
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y108.944 E.01228
G1 X144.74 Y111.356 E.03798
G1 X143.96 Y111.356 E.01228
G1 X143.96 Y109.004 E.03703
M204 S10000
M73 P96 R0
G1 X144.35 Y109.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y111.149 E.02894
; OBJECT_ID: 9
; WIPE_START
G1 X144.35 Y109.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.35 Y109.376 Z2.7 F30000
G1 X144.326 Y110.923
G1 X143.867 Y137.989
G1 X143.96 Y138.083
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X143.96 Y136.944 E.01793
G1 X144.74 Y136.944 E.01228
G1 X144.74 Y138.083 E.01793
G1 X146.94 Y138.083 E.03463
; object ids of layer 23 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer23 end: 1,2,3,4,5,6,7,8,9
M625
G1 X146.94 Y138.217 E.00212
G1 X144.74 Y138.217 E.03463
G1 X144.74 Y139.356 E.01793
G1 X143.96 Y139.356 E.01228
G1 X143.96 Y138.217 E.01793
G1 X141.06 Y138.217 E.04565
G1 X141.06 Y138.083 E.00212
G1 X143.9 Y138.083 E.0447
; WIPE_START
M204 S1000
G1 X143.96 Y136.944 E-.43348
G1 X144.74 Y136.944 E-.29641
G1 X144.74 Y137.023 E-.03012
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.439 Y137.376 Z2.7 F30000
G1 X144.439 Y137.376
G1 X144.35 Y137.376
G1 X144.35 Y137.15
G1 Z2.3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.387951
G1 F1200
M204 S1000
G1 X144.35 Y139.149 E.02894
; OBJECT_ID: 8
; WIPE_START
G1 X144.35 Y137.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X144.35 Y137.376 Z2.7 F30000
G1 X131.401 Y137.989
G1 X129.867 Y137.989
G1 X129.96 Y138.083
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X129.96 Y136.944 E.01793
G1 X130.74 Y136.944 E.01228
G1 X130.74 Y138.083 E.01793
G1 X132.94 Y138.083 E.03463
G1 X132.94 Y138.217 E.00212
G1 X130.74 Y138.217 E.03463
G1 X130.74 Y139.356 E.01793
G1 X129.96 Y139.356 E.01228
G1 X129.96 Y138.217 E.01793
G1 X127.06 Y138.217 E.04565
G1 X127.06 Y138.083 E.00212
G1 X129.9 Y138.083 E.0447
; WIPE_START
M204 S1000
G1 X129.96 Y136.944 E-.43348
G1 X130.74 Y136.944 E-.29641
G1 X130.74 Y137.023 E-.03012
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.439 Y137.376 Z2.7 F30000
G1 X130.439 Y137.376
G1 X130.35 Y137.376
G1 X130.35 Y137.15
G1 Z2.3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.387951
G1 F1200
M204 S1000
G1 X130.35 Y139.149 E.02894
; OBJECT_ID: 7
; WIPE_START
G1 X130.35 Y137.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X130.35 Y137.376 Z2.7 F30000
G1 X107.143 Y137.839
G1 X99.533 Y138.161
G1 X99.44 Y138.068
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X99.44 Y139.206 E.01791
G1 X99.06 Y139.206 E.00598
G1 X99.06 Y136.794 E.03795
G1 X99.44 Y136.794 E.00598
G1 X99.44 Y137.932 E.01791
G1 X114.14 Y137.932 E.23139
G1 X114.14 Y138.068 E.00214
G1 X99.5 Y138.068 E.23045
; OBJECT_ID: 4
; WIPE_START
M204 S1000
G1 X99.44 Y139.206 E-.43287
G1 X99.06 Y139.206 E-.1444
G1 X99.06 Y138.725 E-.18273
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X99.099 Y138.718 Z2.7 F30000
G1 X99.096 Y137.304
G1 X99.411 Y123.577
G1 X99.44 Y123.577
G1 Z2.3
G1 E.8 F1800
G1 F1200
M204 S500
M73 P97 R0
G1 X99.44 Y125.206 E.02563
G1 X99.06 Y125.206 E.00598
G1 X99.06 Y122.794 E.03795
G1 X99.44 Y122.794 E.00598
G1 X99.44 Y123.517 E.01138
; OBJECT_ID: 1
; WIPE_START
M204 S1000
G1 X99.44 Y125.206 E-.6415
G1 X99.128 Y125.206 E-.1185
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X99.128 Y124.773 Z2.7 F30000
G1 X99.169 Y123.227
G1 X99.411 Y109.998
G1 X99.44 Y109.998
G1 Z2.3
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y111.206 E.01901
G1 X99.06 Y111.206 E.00598
G1 X99.06 Y108.794 E.03795
G1 X99.44 Y108.794 E.00598
G1 X99.44 Y109.938 E.018
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
M204 S1000
G1 X99.44 Y111.206 E-.48164
G1 X99.06 Y111.206 E-.1444
G1 X99.06 Y110.853 E-.13396
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 24/28
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.7 I1.176 J.314 P1  F30000
G1 X99.113 Y110.655 Z2.7
G1 X99.389 Y110.645
G1 X130.259 Y109.494
G1 X130.259 Y109.494
G1 X130.259 Y109.494
G1 X129.96 Y109.061
G1 Z2.4
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y109.061 E.01228
G1 X130.74 Y111.238 E.03427
G1 X129.96 Y111.238 E.01228
G1 X129.96 Y109.121 E.03333
M204 S10000
G1 X130.35 Y109.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y111.032 E.02553
; OBJECT_ID: 5
; WIPE_START
G1 X130.35 Y109.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.35 Y109.494 Z2.8 F30000
G1 X130.307 Y110.806
G1 X130.259 Y123.494
G1 X129.96 Y123.061
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y123.061 E.01228
G1 X130.74 Y125.238 E.03427
G1 X129.96 Y125.238 E.01228
G1 X129.96 Y123.121 E.03333
M204 S10000
G1 X130.35 Y123.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y125.032 E.02553
; OBJECT_ID: 6
; WIPE_START
G1 X130.35 Y123.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X130.35 Y123.494 Z2.8 F30000
G1 X144.259 Y123.494
G1 X143.96 Y123.061
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y123.061 E.01228
G1 X144.74 Y125.238 E.03427
G1 X143.96 Y125.238 E.01228
G1 X143.96 Y123.121 E.03333
M204 S10000
G1 X144.35 Y123.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y125.032 E.02553
; OBJECT_ID: 3
; WIPE_START
G1 X144.35 Y123.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X144.35 Y123.494 Z2.8 F30000
G1 X144.267 Y110.806
G1 X144.189 Y109.661
G1 X144.259 Y109.494
G1 X143.96 Y109.061
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y109.061 E.01228
G1 X144.74 Y111.238 E.03427
G1 X143.96 Y111.238 E.01228
G1 X143.96 Y109.121 E.03333
M204 S10000
G1 X144.35 Y109.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y111.032 E.02553
; OBJECT_ID: 9
; WIPE_START
G1 X144.35 Y109.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.35 Y109.494 Z2.8 F30000
G1 X144.328 Y110.806
G1 X144.259 Y137.494
G1 X143.96 Y137.061
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y137.061 E.01228
G1 X144.74 Y139.238 E.03427
; object ids of layer 24 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer24 end: 1,2,3,4,5,6,7,8,9
M625
G1 X143.96 Y139.238 E.01228
G1 X143.96 Y137.121 E.03333
M204 S10000
G1 X144.35 Y137.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y139.032 E.02553
; OBJECT_ID: 8
; WIPE_START
G1 X144.35 Y137.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X144.35 Y137.494 Z2.8 F30000
G1 X130.441 Y137.494
G1 X130.259 Y137.494
G1 X130.259 Y137.494
G1 X129.96 Y137.061
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y137.061 E.01228
G1 X130.74 Y139.238 E.03427
G1 X129.96 Y139.238 E.01228
G1 X129.96 Y137.121 E.03333
M204 S10000
G1 X130.35 Y137.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y139.032 E.02553
; OBJECT_ID: 7
; WIPE_START
G1 X130.35 Y137.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X130.35 Y137.494 Z2.8 F30000
G1 X130.259 Y137.495
G1 X99.411 Y137.687
G1 X99.44 Y137.687
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X99.44 Y139.088 E.02206
G1 X99.06 Y139.088 E.00598
G1 X99.06 Y136.912 E.03426
G1 X99.44 Y136.912 E.00598
G1 X99.44 Y137.627 E.01125
; OBJECT_ID: 4
; WIPE_START
M204 S1000
G1 X99.44 Y139.088 E-.55544
G1 X99.06 Y139.088 E-.1444
G1 X99.06 Y138.93 E-.06015
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X99.113 Y138.655 Z2.8 F30000
G1 X99.097 Y137.46
G1 X99.411 Y123.657
G1 X99.44 Y123.657
G1 Z2.4
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y125.088 E.02253
G1 X99.06 Y125.088 E.00598
G1 X99.06 Y122.912 E.03426
G1 X99.44 Y122.912 E.00598
G1 X99.44 Y123.597 E.01079
; OBJECT_ID: 1
; WIPE_START
M204 S1000
G1 X99.44 Y125.088 E-.56662
G1 X99.06 Y125.088 E-.1444
G1 X99.06 Y124.959 E-.04897
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X99.113 Y124.655 Z2.8 F30000
G1 X99.098 Y123.449
G1 X99.411 Y109.894
G1 X99.44 Y109.894
G1 Z2.4
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y111.088 E.0188
G1 X99.06 Y111.088 E.00598
G1 X99.06 Y108.912 E.03426
G1 X99.44 Y108.912 E.00598
G1 X99.44 Y109.834 E.01451
; CHANGE_LAYER
; Z_HEIGHT: 2.5
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
M204 S1000
G1 X99.44 Y111.088 E-.47671
G1 X99.06 Y111.088 E-.1444
G1 X99.06 Y110.723 E-.13888
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 25/28
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.8 I1.193 J.24 P1  F30000
G1 X99.101 Y110.517 Z2.8
G1 X99.4 Y110.508
G1 X130.237 Y109.633
G1 X130.237 Y109.633
G1 X130.237 Y109.633
G1 X129.96 Y109.2
G1 Z2.5
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y109.2 E.01228
G1 X130.74 Y111.1 E.02991
G1 X129.96 Y111.1 E.01228
G1 X129.96 Y109.26 E.02897
M204 S10000
G1 X130.35 Y109.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y110.893 E.02152
; OBJECT_ID: 5
; WIPE_START
G1 X130.35 Y109.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.35 Y109.633 Z2.9 F30000
G1 X130.314 Y110.667
G1 X130.237 Y123.633
G1 X129.96 Y123.2
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y123.2 E.01228
G1 X130.74 Y125.1 E.02991
G1 X129.96 Y125.1 E.01228
G1 X129.96 Y123.26 E.02897
M204 S10000
G1 X130.35 Y123.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y124.893 E.02152
; OBJECT_ID: 6
; WIPE_START
G1 X130.35 Y123.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X130.35 Y123.633 Z2.9 F30000
G1 X144.237 Y123.633
G1 X143.96 Y123.2
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y123.2 E.01228
G1 X144.74 Y125.1 E.02991
G1 X143.96 Y125.1 E.01228
G1 X143.96 Y123.26 E.02897
M204 S10000
G1 X144.35 Y123.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y124.893 E.02152
; OBJECT_ID: 3
; WIPE_START
G1 X144.35 Y123.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X144.35 Y123.633 Z2.9 F30000
G1 X144.245 Y110.667
G1 X144.189 Y109.731
G1 X144.237 Y109.633
G1 X143.96 Y109.2
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y109.2 E.01228
G1 X144.74 Y111.1 E.02991
G1 X143.96 Y111.1 E.01228
G1 X143.96 Y109.26 E.02897
M204 S10000
G1 X144.35 Y109.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y110.893 E.02152
; OBJECT_ID: 9
; WIPE_START
G1 X144.35 Y109.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.35 Y109.633 Z2.9 F30000
G1 X144.332 Y110.667
G1 X144.237 Y137.633
G1 X143.96 Y137.2
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y137.2 E.01228
G1 X144.74 Y139.1 E.02991
; object ids of layer 25 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer25 end: 1,2,3,4,5,6,7,8,9
M625
G1 X143.96 Y139.1 E.01228
G1 X143.96 Y137.26 E.02897
M204 S10000
G1 X144.35 Y137.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y138.893 E.02152
; OBJECT_ID: 8
; WIPE_START
G1 X144.35 Y137.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X144.35 Y137.633 Z2.9 F30000
G1 X130.463 Y137.632
G1 X130.237 Y137.633
G1 X130.237 Y137.633
G1 X129.96 Y137.2
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y137.2 E.01228
G1 X130.74 Y139.1 E.02991
G1 X129.96 Y139.1 E.01228
G1 X129.96 Y137.26 E.02897
M204 S10000
G1 X130.35 Y137.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y138.893 E.02152
; OBJECT_ID: 7
; WIPE_START
G1 X130.35 Y137.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X130.35 Y137.633 Z2.9 F30000
G1 X130.237 Y137.633
G1 X99.411 Y137.78
G1 X99.44 Y137.78
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X99.44 Y138.95 E.01841
G1 X99.06 Y138.95 E.00598
G1 X99.06 Y137.05 E.0299
G1 X99.44 Y137.05 E.00598
G1 X99.44 Y137.72 E.01055
; OBJECT_ID: 4
; WIPE_START
M204 S1000
G1 X99.44 Y138.95 E-.46724
G1 X99.06 Y138.95 E-.1444
G1 X99.06 Y138.559 E-.14836
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X99.101 Y138.517 Z2.9 F30000
G1 X99.123 Y137.483
G1 X99.394 Y124.517
G1 X99.411 Y124.419
G1 X99.411 Y123.734
G1 X99.44 Y123.734
G1 Z2.5
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y124.95 E.01913
G1 X99.06 Y124.95 E.00598
G1 X99.06 Y123.05 E.0299
G1 X99.44 Y123.05 E.00598
G1 X99.44 Y123.674 E.00982
; OBJECT_ID: 1
; WIPE_START
M204 S1000
G1 X99.44 Y124.95 E-.48471
G1 X99.06 Y124.95 E-.1444
G1 X99.06 Y124.605 E-.13088
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X99.101 Y124.517 Z2.9 F30000
G1 X99.123 Y123.483
G1 X99.395 Y110.517
G1 X99.411 Y110.419
G1 X99.411 Y109.792
G1 X99.44 Y109.792
G1 Z2.5
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y110.95 E.01822
G1 X99.06 Y110.95 E.00598
G1 X99.06 Y109.05 E.0299
G1 X99.44 Y109.05 E.00598
G1 X99.44 Y109.732 E.01073
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
M204 S1000
G1 X99.44 Y110.95 E-.4627
G1 X99.06 Y110.95 E-.1444
G1 X99.06 Y110.547 E-.1529
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 26/28
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.9 I1.186 J.274 P1  F30000
G1 X99.106 Y110.349 Z2.9
G1 X99.395 Y110.344
G1 X130.247 Y109.8
G1 X130.247 Y109.8
G1 X130.247 Y109.8
G1 X129.96 Y109.367
G1 Z2.6
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y109.367 E.01228
G1 X130.74 Y110.933 E.02466
G1 X129.96 Y110.933 E.01228
G1 X129.96 Y109.427 E.02371
M204 S10000
G1 X130.35 Y109.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y110.727 E.01669
; OBJECT_ID: 5
; WIPE_START
G1 X130.35 Y109.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.35 Y109.8 Z3 F30000
G1 X130.324 Y110.5
G1 X130.247 Y123.8
G1 X129.96 Y123.367
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y123.367 E.01228
G1 X130.74 Y124.933 E.02466
G1 X129.96 Y124.933 E.01228
G1 X129.96 Y123.427 E.02371
M204 S10000
G1 X130.35 Y123.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y124.727 E.01669
; OBJECT_ID: 6
; WIPE_START
G1 X130.35 Y123.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X130.35 Y123.8 Z3 F30000
G1 X144.247 Y123.8
G1 X143.96 Y123.367
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y123.367 E.01228
M73 P98 R0
G1 X144.74 Y124.933 E.02466
G1 X143.96 Y124.933 E.01228
G1 X143.96 Y123.427 E.02371
M204 S10000
G1 X144.35 Y123.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y124.727 E.01669
; OBJECT_ID: 3
; WIPE_START
G1 X144.35 Y123.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X144.35 Y123.8 Z3 F30000
G1 X144.252 Y110.5
G1 X144.189 Y109.926
G1 X144.247 Y109.8
G1 X143.96 Y109.367
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y109.367 E.01228
G1 X144.74 Y110.933 E.02466
G1 X143.96 Y110.933 E.01228
G1 X143.96 Y109.427 E.02371
M204 S10000
G1 X144.35 Y109.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y110.727 E.01669
; OBJECT_ID: 9
; WIPE_START
G1 X144.35 Y109.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.35 Y109.8 Z3 F30000
G1 X144.337 Y110.5
G1 X144.247 Y137.8
G1 X143.96 Y137.367
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y137.367 E.01228
G1 X144.74 Y138.933 E.02466
; object ids of layer 26 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer26 end: 1,2,3,4,5,6,7,8,9
M625
G1 X143.96 Y138.933 E.01228
G1 X143.96 Y137.427 E.02371
M204 S10000
G1 X144.35 Y137.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X144.35 Y138.727 E.01669
; OBJECT_ID: 8
; WIPE_START
G1 X144.35 Y137.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X144.35 Y137.8 Z3 F30000
G1 X130.453 Y137.8
G1 X130.247 Y137.8
G1 X130.247 Y137.8
G1 X129.96 Y137.367
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y137.367 E.01228
G1 X130.74 Y138.933 E.02466
G1 X129.96 Y138.933 E.01228
G1 X129.96 Y137.427 E.02371
M204 S10000
G1 X130.35 Y137.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X130.35 Y138.727 E.01669
; OBJECT_ID: 7
; WIPE_START
G1 X130.35 Y137.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X130.35 Y137.8 Z3 F30000
G1 X130.247 Y137.8
G1 X99.411 Y137.868
G1 X99.44 Y137.868
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X99.44 Y138.782 E.01439
G1 X99.06 Y138.782 E.00598
G1 X99.06 Y137.218 E.02463
G1 X99.44 Y137.218 E.00598
G1 X99.44 Y137.808 E.0093
; OBJECT_ID: 4
; WIPE_START
M204 S1000
G1 X99.44 Y138.782 E-.37007
G1 X99.06 Y138.782 E-.1444
G1 X99.06 Y138.136 E-.24553
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X99.089 Y138.136 Z3 F30000
G1 X99.099 Y137.702
G1 X99.399 Y124.31
G1 X99.411 Y124.224
G1 X99.411 Y123.807
G1 X99.44 Y123.807
G1 Z2.6
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y124.782 E.01535
G1 X99.06 Y124.782 E.00598
G1 X99.06 Y123.218 E.02463
G1 X99.44 Y123.218 E.00598
G1 X99.44 Y123.747 E.00833
; OBJECT_ID: 1
; WIPE_START
M204 S1000
G1 X99.44 Y124.782 E-.39348
G1 X99.06 Y124.782 E-.1444
G1 X99.06 Y124.198 E-.22212
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X99.089 Y124.198 Z3 F30000
G1 X99.1 Y123.693
G1 X99.387 Y110.349
G1 X99.411 Y109.776
G1 X99.401 Y109.701
G1 X99.44 Y109.696
G1 Z2.6
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y110.782 E.0171
G1 X99.06 Y110.782 E.00598
G1 X99.06 Y109.218 E.02463
G1 X99.44 Y109.218 E.00598
G1 X99.44 Y109.636 E.00659
; CHANGE_LAYER
; Z_HEIGHT: 2.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
M204 S1000
G1 X99.44 Y110.782 E-.43553
G1 X99.06 Y110.782 E-.1444
G1 X99.06 Y110.308 E-.18007
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 27/28
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3 I1.175 J.318 P1  F30000
G1 X99.107 Y110.134 Z3
G1 X99.393 Y110.133
G1 X130.25 Y110.014
G1 X130.25 Y110.014
G1 X130.25 Y110.014
G1 X129.96 Y109.582
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y109.582 E.01228
G1 X130.74 Y110.719 E.0179
G1 X129.96 Y110.719 E.01228
G1 X129.96 Y109.642 E.01695
; OBJECT_ID: 5
; WIPE_START
M204 S1000
G1 X130.74 Y109.582 E-.29728
G1 X130.74 Y110.719 E-.43211
G1 X130.659 Y110.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X130.45 Y110.286 Z3.1 F30000
G1 X130.25 Y124.014
G1 X129.96 Y123.582
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y123.582 E.01228
G1 X130.74 Y124.719 E.0179
G1 X129.96 Y124.719 E.01228
G1 X129.96 Y123.642 E.01695
; OBJECT_ID: 6
; WIPE_START
M204 S1000
G1 X130.74 Y123.582 E-.29728
G1 X130.74 Y124.719 E-.43211
G1 X130.659 Y124.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X130.45 Y124.286 Z3.1 F30000
G1 X130.45 Y124.286
G1 X144.25 Y124.014
G1 X144.25 Y124.014
G1 X144.25 Y124.014
G1 X143.96 Y123.582
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X144.74 Y123.582 E.01228
G1 X144.74 Y124.719 E.0179
G1 X143.96 Y124.719 E.01228
G1 X143.96 Y123.642 E.01695
; OBJECT_ID: 3
; WIPE_START
M204 S1000
G1 X144.74 Y123.582 E-.29728
G1 X144.74 Y124.719 E-.43211
G1 X144.659 Y124.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X144.45 Y124.286 Z3.1 F30000
G1 X144.446 Y124.014
G1 X144.254 Y110.286
G1 X144.189 Y110.15
G1 X144.25 Y110.014
G1 X143.96 Y109.582
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X144.74 Y109.582 E.01228
G1 X144.74 Y110.719 E.0179
G1 X143.96 Y110.719 E.01228
G1 X143.96 Y109.642 E.01695
; OBJECT_ID: 9
; WIPE_START
M204 S1000
G1 X144.74 Y109.582 E-.29728
G1 X144.74 Y110.719 E-.43211
G1 X144.659 Y110.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X144.45 Y110.286 Z3.1 F30000
G1 X144.313 Y124.014
G1 X144.306 Y124.286
G1 X144.25 Y138.014
G1 X143.96 Y137.582
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X144.74 Y137.582 E.01228
G1 X144.74 Y138.719 E.0179
; object ids of layer 27 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer27 end: 1,2,3,4,5,6,7,8,9
M625
G1 X143.96 Y138.719 E.01228
G1 X143.96 Y137.642 E.01695
; OBJECT_ID: 8
; WIPE_START
M204 S1000
G1 X144.74 Y137.582 E-.29728
G1 X144.74 Y138.719 E-.43211
G1 X144.659 Y138.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X144.45 Y138.286 Z3.1 F30000
G1 X144.248 Y138.282
G1 X130.452 Y138.018
G1 X130.25 Y138.014
G1 X130.25 Y138.014
G1 X129.96 Y137.582
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y137.582 E.01228
G1 X130.74 Y138.719 E.0179
G1 X129.96 Y138.719 E.01228
G1 X129.96 Y137.642 E.01695
; OBJECT_ID: 7
; WIPE_START
M204 S1000
G1 X130.74 Y137.582 E-.29728
G1 X130.74 Y138.719 E-.43211
G1 X130.659 Y138.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X130.45 Y138.286 Z3.1 F30000
G1 X130.249 Y138.283
G1 X99.393 Y137.866
G1 X99.393 Y137.866
G1 X99.393 Y137.866
G1 X99.44 Y137.433
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y138.567 E.01785
G1 X99.06 Y138.567 E.00598
G1 X99.06 Y137.433 E.01785
G1 X99.38 Y137.433 E.00504
; OBJECT_ID: 4
; WIPE_START
M204 S1000
G1 X99.44 Y138.567 E-.43162
G1 X99.06 Y138.567 E-.1444
G1 X99.06 Y138.083 E-.18398
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X99.1 Y138.078 Z3.1 F30000
G1 X99.103 Y137.894
G1 X99.387 Y124.134
G1 X99.393 Y123.866
G1 X99.44 Y123.433
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y124.567 E.01785
G1 X99.06 Y124.567 E.00598
G1 X99.06 Y123.433 E.01785
G1 X99.38 Y123.433 E.00504
; OBJECT_ID: 1
; WIPE_START
M204 S1000
G1 X99.44 Y124.567 E-.43162
G1 X99.06 Y124.567 E-.1444
G1 X99.06 Y124.083 E-.18398
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X99.1 Y124.078 Z3.1 F30000
G1 X99.103 Y123.894
G1 X99.387 Y110.134
G1 X99.393 Y109.866
G1 X99.44 Y109.433
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y110.567 E.01785
G1 X99.06 Y110.567 E.00598
G1 X99.06 Y109.433 E.01785
G1 X99.38 Y109.433 E.00504
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
M204 S1000
G1 X99.44 Y110.567 E-.43162
G1 X99.06 Y110.567 E-.1444
G1 X99.06 Y110.083 E-.18398
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 1
M625
; layer num/total_layer_count: 28/28
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 2
; start printing object, unique label id: 2
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.1 I0 J-1.217 P1  F30000
G1 X98.85 Y110.083 Z3.1
G1 X129.75 Y109.906
G1 X129.96 Y109.906
G1 Z2.8
G1 E.8 F1800
G1 F1200
M204 S500
G1 X130.74 Y109.906 E.01228
G1 X130.74 Y110.395 E.0077
G1 X129.96 Y110.395 E.01228
G1 X129.96 Y109.966 E.00676
M204 S10000
G1 X130.167 Y110.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X130.533 Y110.151 E.0011
; OBJECT_ID: 5
; WIPE_START
G1 X130.167 Y110.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 2
M625
; start printing object, unique label id: 5
M624 EAAAAAAAAAA=
M204 S10000
G1 X129.75 Y110.151 Z3.2 F30000
G1 X129.75 Y123.906
G1 X129.96 Y123.906
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y123.906 E.01228
G1 X130.74 Y124.395 E.0077
G1 X129.96 Y124.395 E.01228
G1 X129.96 Y123.966 E.00676
M204 S10000
G1 X130.167 Y124.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X130.533 Y124.151 E.0011
; OBJECT_ID: 6
; WIPE_START
G1 X130.167 Y124.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 5
M625
; start printing object, unique label id: 6
M624 IAAAAAAAAAA=
M204 S10000
G1 X129.75 Y124.151 Z3.2 F30000
G1 X143.75 Y123.906
G1 X143.96 Y123.906
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y123.906 E.01228
G1 X144.74 Y124.395 E.0077
G1 X143.96 Y124.395 E.01228
G1 X143.96 Y123.966 E.00676
M204 S10000
G1 X144.167 Y124.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X144.533 Y124.151 E.0011
; OBJECT_ID: 3
; WIPE_START
G1 X144.167 Y124.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 6
M625
; start printing object, unique label id: 3
M624 BAAAAAAAAAA=
M204 S10000
G1 X143.75 Y124.151 Z3.2 F30000
G1 X143.75 Y109.906
G1 X143.96 Y109.906
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y109.906 E.01228
G1 X144.74 Y110.395 E.0077
G1 X143.96 Y110.395 E.01228
G1 X143.96 Y109.966 E.00676
M204 S10000
G1 X144.167 Y110.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X144.533 Y110.151 E.0011
; OBJECT_ID: 9
; WIPE_START
G1 X144.167 Y110.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 3
M625
; start printing object, unique label id: 9
M624 AAEAAAAAAAA=
M204 S10000
G1 X143.75 Y110.151 Z3.2 F30000
G1 X144.066 Y123.696
G1 X144.059 Y124.605
G1 X143.75 Y137.906
G1 X143.96 Y137.906
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X144.74 Y137.906 E.01228
; object ids of layer 28 start: 1,2,3,4,5,6,7,8,9
M624 /wEAAAAAAAA=
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

; object ids of this layer28 end: 1,2,3,4,5,6,7,8,9
M625
G1 X144.74 Y138.395 E.0077
G1 X143.96 Y138.395 E.01228
G1 X143.96 Y137.966 E.00676
M204 S10000
G1 X144.167 Y138.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X144.533 Y138.151 E.0011
; OBJECT_ID: 8
; WIPE_START
G1 X144.167 Y138.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 gAAAAAAAAAA=
M204 S10000
G1 X143.75 Y138.151 Z3.2 F30000
G1 X130.95 Y137.923
G1 X129.75 Y137.696
G1 X129.75 Y137.906
G1 X129.96 Y137.906
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X130.74 Y137.906 E.01228
G1 X130.74 Y138.395 E.0077
G1 X129.96 Y138.395 E.01228
G1 X129.96 Y137.966 E.00676
M204 S10000
G1 X130.167 Y138.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X130.533 Y138.151 E.0011
; OBJECT_ID: 7
; WIPE_START
G1 X130.167 Y138.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; start printing object, unique label id: 7
M624 QAAAAAAAAAA=
M204 S10000
G1 X129.75 Y138.151 Z3.2 F30000
G1 X99.44 Y137.549
G1 X99.44 Y137.758
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X99.44 Y138.241 E.0076
G1 X99.06 Y138.241 E.00598
G1 X99.06 Y137.758 E.0076
G1 X99.38 Y137.758 E.00504
; OBJECT_ID: 4
; WIPE_START
M204 S1000
G1 X99.44 Y138.241 E-.22153
G1 X99.06 Y138.241 E-.17297
G1 X99.06 Y137.758 E-.21984
G1 X99.38 Y137.758 E-.14566
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 7
M625
; start printing object, unique label id: 4
M624 CAAAAAAAAAA=
M204 S10000
G1 X99.38 Y137.549 Z3.2 F30000
G1 X99.44 Y123.549
G1 X99.44 Y123.758
G1 Z2.8
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y124.241 E.0076
G1 X99.06 Y124.241 E.00598
G1 X99.06 Y123.758 E.0076
G1 X99.38 Y123.758 E.00504
; OBJECT_ID: 1
; WIPE_START
M204 S1000
G1 X99.44 Y124.241 E-.22153
G1 X99.06 Y124.241 E-.17297
G1 X99.06 Y123.758 E-.21984
G1 X99.38 Y123.758 E-.14566
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 4
M625
; start printing object, unique label id: 1
M624 AQAAAAAAAAA=
M204 S10000
G1 X99.38 Y123.549 Z3.2 F30000
G1 X99.44 Y109.549
G1 X99.44 Y109.759
G1 Z2.8
G1 E.8 F1800
G1 F1200
M204 S500
G1 X99.44 Y110.242 E.0076
G1 X99.06 Y110.242 E.00598
G1 X99.06 Y109.759 E.0076
G1 X99.38 Y109.759 E.00504
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1200
M204 S1000
G1 X99.44 Y110.242 E-.22153
G1 X99.06 Y110.242 E-.17297
G1 X99.06 Y109.759 E-.21984
G1 X99.38 Y109.759 E-.14566
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.2 I1.217 J0 P1  F30000
; stop printing object, unique label id: 1
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
G1 Z3.3 F900 ; lower z a little
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

    G1 Z102.8 F600
    G1 Z100.8

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

