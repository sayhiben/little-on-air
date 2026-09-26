; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 21m 57s; total estimated time: 30m 17s
; total layer number: 10
; total filament length [mm] : 2717.12
; total filament volume [cm^3] : 6535.45
; total filament weight [g] : 8.30
; filament_density: 1.27,1.27
; filament_diameter: 1.75,1.75
; max_z_height: 2.00
; filament: 1
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
; close_additional_fan_first_x_layers = 3,3
; close_fan_the_first_x_layers = 3,3
; complete_print_exhaust_fan_speed = 70,70
; cool_plate_temp = 0,0
; cool_plate_temp_initial_layer = 0,0
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
; different_settings_to_system = ;;;
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
; enable_prime_tower = 0
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 70,70
; eng_plate_temp_initial_layer = 70,70
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;
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
; fan_cooling_layer_time = 30,30
; fan_direction = left
; fan_max_speed = 90,90
; fan_min_speed = 40,40
; farthest_point_timelapse = 1
; filament_adaptive_volumetric_speed = 0,0
; filament_adhesiveness_category = 300,300
; filament_bridge_speed = 25,25
; filament_change_length = 10,10
; filament_change_length_nc = 10,10
; filament_colour = #161616;#FFFFFF
; filament_colour_type = 0;0
; filament_cooling_before_tower = 0,0
; filament_cost = 30,30
; filament_density = 1.27,1.27
; filament_dev_ams_drying_ams_limitations = 1;0;1;0
; filament_dev_ams_drying_heat_distortion_temperature = 75,75
; filament_dev_ams_drying_temperature = 65,65,55,55,65,65,55,55
; filament_dev_ams_drying_time = 12,12,12,12,12,12,12,12
; filament_dev_chamber_drying_bed_temperature = 80,80
; filament_dev_chamber_drying_time = 12,12
; filament_dev_drying_cooling_temperature = 55,55
; filament_dev_drying_softening_temperature = 60,60
; filament_diameter = 1.75,1.75
; filament_enable_overhang_speed = 1,1
; filament_end_gcode = "; filament end gcode \n\n";"; filament end gcode \n\n"
; filament_extruder_compatibility = 0,0
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.95,0.95
; filament_flush_temp = 0,0
; filament_flush_temp_fast = 0,0
; filament_flush_volumetric_speed = 0,0
; filament_ids = GFG99;GFG99
; filament_is_mixed = 0,0
; filament_is_support = 0,0
; filament_map = 1,1
; filament_map_2 = 0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 12,12
; filament_metal_stickiness = High,High
; filament_minimal_purge_on_wipe_tower = 15,15
; filament_mixed_components = ;
; filament_mixed_gradient = 0,0
; filament_mixed_gradient_curve = ;
; filament_mixed_gradient_per_part = 0,0
; filament_mixed_gradient_range = ;
; filament_mixed_sublayer_ratios = ;
; filament_multi_colour = #161616;#FFFFFF
; filament_notes = 
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
; filament_scarf_gap = 0%,0%
; filament_scarf_height = 10%,10%
; filament_scarf_length = 10,10
; filament_scarf_seam_type = none,none
; filament_self_index = 1,2
; filament_settings_id = "Generic PETG";"Generic PETG"
; filament_shrink = 100%,100%
; filament_soluble = 0,0
; filament_start_gcode = "; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10,10
; filament_tower_interface_pre_extrusion_length = 0,0
; filament_tower_interface_print_temp = -1,-1
; filament_tower_interface_purge_volume = 20,20
; filament_tower_ironing_area = 4,4
; filament_type = PETG;PETG
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
; hot_plate_temp = 70,70
; hot_plate_temp_initial_layer = 70,70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10,10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = ;;;
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
; nozzle_temperature = 255,255
; nozzle_temperature_initial_layer = 255,255
; nozzle_temperature_range_high = 270,270
; nozzle_temperature_range_low = 220,220
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
; overhang_fan_speed = 90,90
; overhang_fan_threshold = 10%,10%
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
; slow_down_layer_time = 12,12
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
; supertack_plate_temp = 70,70
; supertack_plate_temp_initial_layer = 70,70
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
; temperature_vitrification = 70,70
; template_custom_gcode = 
; textured_plate_temp = 70,70
; textured_plate_temp_initial_layer = 70,70
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
; wipe_tower_x = 22,22,22,22
; wipe_tower_y = 185,185,185,185
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
M73 P0 R30
M73 C28
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


;=========register first layer scan=====
M977 S1 P60


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
M620.1 E F299.339 T270

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
M73 P1 R29
M73 C27
G1 E50 F200
M400
M104 S255
G92 E0
M73 P16 R25
M73 C23
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S235 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P17 R25
G1 E-0.5 F300

M73 P17 R24
M73 C22
G1 X70 F9000
M73 P18 R24
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
    G29 A X76 Y109 I104 J38
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
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S255
M73 P19 R24
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
    G1 X120.000 E0.31181 F452.496
    G1 X125.000 E0.31181 F1809.98
    G1 X130.000 E0.31181 F452.496
    G1 X135.000 E0.31181 F1809.98
    G1 X140.000 E0.31181 F452.496
    G1 X145.000 E0.31181 F1809.98
    G1 X150.000 E0.31181 F452.496
    G1 X155.000 E0.31181 F1809.98
M73 P20 R24
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
M73 P20 R23
    G1 X130.000 E0.31181 F452.496
    G1 X135.000 E0.31181 F1809.98
    G1 X140.000 E0.31181 F452.496
    G1 X145.000 E0.31181 F1809.98
    G1 X150.000 E0.31181 F452.496
M73 P21 R23
    G1 X155.000 E0.31181 F1809.98
    G1 X160.000 E0.31181 F452.496
    G1 X165.000 E0.31181 F1809.98
    G1 X170.000 E0.31181 F452.496
    G1 X175.000 E0.31181 F1809.98
M73 C21
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
M73 P22 R23
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
    M109 S255
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
    G1 X155.000 E0.31181 F1809.98
    G1 X160.000 E0.31181 F452.496
    G1 X165.000 E0.31181 F1809.98
    G1 X170.000 E0.31181 F452.496
M73 P23 R23
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
G0 X239 E15 F1809.98
G0 Y12 E0.7 F452.496
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S180


;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/10
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
; OBJECT_ID: 403
G1 X178.229 Y143.229 F30000
M204 S6000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.49999
G1 F1500
M204 S500
G1 X79.734 Y143.229 E3.55619
G1 X77.771 Y141.266 E.1002
G1 X77.771 Y108.771 E1.17325
G1 X178.229 Y108.771 E3.62705
G1 X178.229 Y126 E.62205
G1 X178.229 Y143.169 E.61988
M204 S6000
G1 X178.686 Y143.686 F30000
G1 F1500
M204 S500
G1 X79.544 Y143.686 E3.57953
G1 X77.314 Y141.456 E.11387
G1 X77.314 Y108.314 E1.19658
G1 X178.686 Y108.314 E3.66005
G1 X178.686 Y126 E.63855
G1 X178.686 Y143.626 E.63639
M204 S6000
G1 X179.143 Y144.143 F30000
G1 F1500
M204 S500
G1 X79.355 Y144.143 E3.60287
G1 X76.857 Y141.645 E.12755
G1 X76.857 Y107.857 E1.21992
G1 X179.143 Y107.857 E3.69306
G1 X179.143 Y126 E.65506
G1 X179.143 Y144.083 E.65289
M204 S6000
G1 X179.6 Y144.6 F30000
; FEATURE: Outer wall
G1 F1500
M204 S500
G1 X79.166 Y144.6 E3.62621
G1 X76.4 Y141.834 E.14122
G1 X76.4 Y107.4 E1.24326
G1 X179.6 Y107.4 E3.72606
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

G1 X179.6 Y126 E.67156
G1 X179.6 Y144.54 E.66939
; WIPE_START
M73 P24 R23
G1 X177.6 Y144.541 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
M73 P24 R22
M73 C20
G1 X177.497 Y136.909 Z.6 F30000
G1 X177.118 Y108.954 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50186
G1 F2400
M204 S500
G1 X177.84 Y109.676 E.03703
G1 X177.84 Y110.325 E.02353
G1 X176.675 Y109.16 E.05976
G1 X176.026 Y109.16 E.02353
G1 X177.84 Y110.974 E.09304
G1 X177.84 Y111.623 E.02353
G1 X175.377 Y109.16 E.12631
G1 X174.728 Y109.16 E.02353
M73 P26 R22
G1 X177.84 Y112.272 E.15959
G1 X177.84 Y112.921 E.02353
G1 X174.079 Y109.16 E.19286
G1 X173.429 Y109.16 E.02353
G1 X177.84 Y113.571 E.22614
G1 X177.84 Y114.22 E.02353
G1 X172.78 Y109.16 E.25941
G1 X172.131 Y109.16 E.02353
G1 X177.84 Y114.869 E.29269
G1 X177.84 Y115.518 E.02353
G1 X171.482 Y109.16 E.32597
G1 X170.833 Y109.16 E.02353
G1 X177.84 Y116.167 E.35924
G1 X177.84 Y116.816 E.02353
G1 X170.184 Y109.16 E.39252
G1 X169.535 Y109.16 E.02353
G1 X177.84 Y117.465 E.42579
G1 X177.84 Y118.114 E.02353
G1 X168.886 Y109.16 E.45907
G1 X168.237 Y109.16 E.02353
G1 X177.84 Y118.763 E.49235
G1 X177.84 Y119.412 E.02353
G1 X167.588 Y109.16 E.52562
G1 X166.939 Y109.16 E.02353
G1 X177.84 Y120.061 E.5589
G1 X177.84 Y120.71 E.02353
G1 X166.29 Y109.16 E.59217
G1 X165.641 Y109.16 E.02353
G1 X177.84 Y121.359 E.62545
G1 X177.84 Y122.008 E.02353
G1 X164.992 Y109.16 E.65873
G1 X164.343 Y109.16 E.02353
G1 X177.84 Y122.657 E.692
G1 X177.84 Y123.306 E.02353
G1 X163.694 Y109.16 E.72528
G1 X163.045 Y109.16 E.02353
G1 X177.84 Y123.955 E.75855
G1 X177.84 Y124.604 E.02353
G1 X162.396 Y109.16 E.79183
G1 X161.747 Y109.16 E.02353
G1 X177.84 Y125.253 E.8251
G1 X177.84 Y125.902 E.02353
G1 X161.098 Y109.16 E.85838
G1 X160.449 Y109.16 E.02353
G1 X177.84 Y126.551 E.89166
M73 P27 R21
G1 X177.84 Y127.2 E.02353
G1 X159.8 Y109.16 E.92493
G1 X159.151 Y109.16 E.02353
G1 X177.84 Y127.849 E.95821
G1 X177.84 Y128.498 E.02353
G1 X158.502 Y109.16 E.99148
G1 X157.853 Y109.16 E.02353
G1 X177.84 Y129.147 E1.02476
M73 C19
G1 X177.84 Y129.796 E.02353
G1 X157.204 Y109.16 E1.05804
G1 X156.554 Y109.16 E.02353
M73 P28 R21
G1 X177.84 Y130.446 E1.09131
G1 X177.84 Y131.095 E.02353
G1 X155.905 Y109.16 E1.12459
G1 X155.256 Y109.16 E.02353
G1 X177.84 Y131.744 E1.15786
G1 X177.84 Y132.393 E.02353
G1 X154.607 Y109.16 E1.19114
G1 X153.958 Y109.16 E.02353
G1 X177.84 Y133.042 E1.22441
G1 X177.84 Y133.691 E.02353
G1 X153.309 Y109.16 E1.25769
G1 X152.66 Y109.16 E.02353
G1 X177.84 Y134.34 E1.29097
G1 X177.84 Y134.989 E.02353
G1 X152.011 Y109.16 E1.32424
M73 P29 R21
G1 X151.362 Y109.16 E.02353
G1 X177.84 Y135.638 E1.35752
G1 X177.84 Y136.287 E.02353
G1 X150.713 Y109.16 E1.39079
G1 X150.064 Y109.16 E.02353
G1 X177.84 Y136.936 E1.42407
G1 X177.84 Y137.585 E.02353
G1 X149.415 Y109.16 E1.45735
G1 X148.766 Y109.16 E.02353
G1 X177.84 Y138.234 E1.49062
G1 X177.84 Y138.883 E.02353
G1 X148.117 Y109.16 E1.5239
G1 X147.468 Y109.16 E.02353
G1 X177.84 Y139.532 E1.55717
G1 X177.84 Y140.181 E.02353
G1 X146.819 Y109.16 E1.59045
G1 X146.17 Y109.16 E.02353
G1 X177.84 Y140.83 E1.62373
G1 X177.84 Y141.479 E.02353
G1 X145.521 Y109.16 E1.657
G1 X144.872 Y109.16 E.02353
G1 X177.84 Y142.128 E1.69028
G1 X177.84 Y142.777 E.02353
G1 X144.223 Y109.16 E1.72355
G1 X143.574 Y109.16 E.02353
G1 X177.254 Y142.84 E1.72678
G1 X176.605 Y142.84 E.02353
M73 P30 R21
G1 X142.925 Y109.16 E1.72678
G1 X142.276 Y109.16 E.02353
G1 X175.956 Y142.84 E1.72678
G1 X175.307 Y142.84 E.02353
G1 X141.627 Y109.16 E1.72678
G1 X140.978 Y109.16 E.02353
G1 X174.658 Y142.84 E1.72678
G1 X174.009 Y142.84 E.02353
G1 X140.328 Y109.16 E1.72678
G1 X139.679 Y109.16 E.02353
G1 X173.36 Y142.84 E1.72678
G1 X172.711 Y142.84 E.02353
G1 X139.03 Y109.16 E1.72678
G1 X138.381 Y109.16 E.02353
G1 X172.062 Y142.84 E1.72678
G1 X171.413 Y142.84 E.02353
G1 X137.732 Y109.16 E1.72678
G1 X137.083 Y109.16 E.02353
G1 X170.764 Y142.84 E1.72678
G1 X170.115 Y142.84 E.02353
G1 X136.434 Y109.16 E1.72678
G1 X135.785 Y109.16 E.02353
G1 X169.466 Y142.84 E1.72678
G1 X168.817 Y142.84 E.02353
G1 X135.136 Y109.16 E1.72678
G1 X134.487 Y109.16 E.02353
G1 X168.168 Y142.84 E1.72678
G1 X167.519 Y142.84 E.02353
G1 X133.838 Y109.16 E1.72678
G1 X133.189 Y109.16 E.02353
G1 X166.87 Y142.84 E1.72678
G1 X166.221 Y142.84 E.02353
G1 X132.54 Y109.16 E1.72678
G1 X131.891 Y109.16 E.02353
G1 X165.572 Y142.84 E1.72678
G1 X164.923 Y142.84 E.02353
G1 X131.242 Y109.16 E1.72678
G1 X130.593 Y109.16 E.02353
G1 X164.273 Y142.84 E1.72678
G1 X163.624 Y142.84 E.02353
G1 X129.944 Y109.16 E1.72678
G1 X129.295 Y109.16 E.02353
G1 X162.975 Y142.84 E1.72678
G1 X162.326 Y142.84 E.02353
G1 X128.646 Y109.16 E1.72678
G1 X127.997 Y109.16 E.02353
G1 X161.677 Y142.84 E1.72678
G1 X161.028 Y142.84 E.02353
G1 X127.348 Y109.16 E1.72678
G1 X126.699 Y109.16 E.02353
G1 X160.379 Y142.84 E1.72678
G1 X159.73 Y142.84 E.02353
M73 P30 R20
G1 X126.05 Y109.16 E1.72678
G1 X125.401 Y109.16 E.02353
G1 X159.081 Y142.84 E1.72678
G1 X158.432 Y142.84 E.02353
G1 X124.752 Y109.16 E1.72678
G1 X124.103 Y109.16 E.02353
G1 X157.783 Y142.84 E1.72678
G1 X157.134 Y142.84 E.02353
G1 X123.453 Y109.16 E1.72678
G1 X122.804 Y109.16 E.02353
G1 X156.485 Y142.84 E1.72678
G1 X155.836 Y142.84 E.02353
M73 P31 R20
M73 C18
G1 X122.155 Y109.16 E1.72678
G1 X121.506 Y109.16 E.02353
G1 X155.187 Y142.84 E1.72678
G1 X154.538 Y142.84 E.02353
G1 X120.857 Y109.16 E1.72678
G1 X120.208 Y109.16 E.02353
G1 X153.889 Y142.84 E1.72678
G1 X153.24 Y142.84 E.02353
G1 X119.559 Y109.16 E1.72678
G1 X118.91 Y109.16 E.02353
G1 X152.591 Y142.84 E1.72678
G1 X151.942 Y142.84 E.02353
G1 X118.261 Y109.16 E1.72678
G1 X117.612 Y109.16 E.02353
G1 X151.293 Y142.84 E1.72678
G1 X150.644 Y142.84 E.02353
G1 X116.963 Y109.16 E1.72678
G1 X116.314 Y109.16 E.02353
G1 X149.995 Y142.84 E1.72678
G1 X149.346 Y142.84 E.02353
G1 X115.665 Y109.16 E1.72678
G1 X115.016 Y109.16 E.02353
G1 X148.697 Y142.84 E1.72678
G1 X148.048 Y142.84 E.02353
G1 X114.367 Y109.16 E1.72678
G1 X113.718 Y109.16 E.02353
G1 X147.398 Y142.84 E1.72678
G1 X146.749 Y142.84 E.02353
G1 X113.069 Y109.16 E1.72678
G1 X112.42 Y109.16 E.02353
G1 X146.1 Y142.84 E1.72678
G1 X145.451 Y142.84 E.02353
G1 X111.771 Y109.16 E1.72678
G1 X111.122 Y109.16 E.02353
M73 P32 R20
G1 X144.802 Y142.84 E1.72678
G1 X144.153 Y142.84 E.02353
G1 X110.473 Y109.16 E1.72678
G1 X109.824 Y109.16 E.02353
G1 X143.504 Y142.84 E1.72678
G1 X142.855 Y142.84 E.02353
G1 X109.175 Y109.16 E1.72678
G1 X108.526 Y109.16 E.02353
G1 X142.206 Y142.84 E1.72678
G1 X141.557 Y142.84 E.02353
G1 X107.877 Y109.16 E1.72678
G1 X107.227 Y109.16 E.02353
G1 X140.908 Y142.84 E1.72678
G1 X140.259 Y142.84 E.02353
G1 X106.578 Y109.16 E1.72678
G1 X105.929 Y109.16 E.02353
G1 X139.61 Y142.84 E1.72678
G1 X138.961 Y142.84 E.02353
G1 X105.28 Y109.16 E1.72678
G1 X104.631 Y109.16 E.02353
G1 X138.312 Y142.84 E1.72678
G1 X137.663 Y142.84 E.02353
G1 X103.982 Y109.16 E1.72678
G1 X103.333 Y109.16 E.02353
G1 X137.014 Y142.84 E1.72678
G1 X136.365 Y142.84 E.02353
G1 X102.684 Y109.16 E1.72678
G1 X102.035 Y109.16 E.02353
M73 P33 R20
G1 X135.716 Y142.84 E1.72678
G1 X135.067 Y142.84 E.02353
G1 X101.386 Y109.16 E1.72678
G1 X100.737 Y109.16 E.02353
G1 X134.418 Y142.84 E1.72678
G1 X133.769 Y142.84 E.02353
G1 X100.088 Y109.16 E1.72678
G1 X99.439 Y109.16 E.02353
G1 X133.12 Y142.84 E1.72678
G1 X132.471 Y142.84 E.02353
G1 X98.79 Y109.16 E1.72678
G1 X98.141 Y109.16 E.02353
G1 X131.822 Y142.84 E1.72678
G1 X131.172 Y142.84 E.02353
G1 X97.492 Y109.16 E1.72678
G1 X96.843 Y109.16 E.02353
G1 X130.523 Y142.84 E1.72678
G1 X129.874 Y142.84 E.02353
G1 X96.194 Y109.16 E1.72678
G1 X95.545 Y109.16 E.02353
G1 X129.225 Y142.84 E1.72678
G1 X128.576 Y142.84 E.02353
G1 X94.896 Y109.16 E1.72678
G1 X94.247 Y109.16 E.02353
G1 X127.927 Y142.84 E1.72678
G1 X127.278 Y142.84 E.02353
G1 X93.598 Y109.16 E1.72678
G1 X92.949 Y109.16 E.02353
M73 P34 R19
G1 X126.629 Y142.84 E1.72678
G1 X125.98 Y142.84 E.02353
G1 X92.3 Y109.16 E1.72678
G1 X91.651 Y109.16 E.02353
G1 X125.331 Y142.84 E1.72678
G1 X124.682 Y142.84 E.02353
G1 X91.002 Y109.16 E1.72678
G1 X90.352 Y109.16 E.02353
M73 C17
G1 X124.033 Y142.84 E1.72678
G1 X123.384 Y142.84 E.02353
G1 X89.703 Y109.16 E1.72678
G1 X89.054 Y109.16 E.02353
G1 X122.735 Y142.84 E1.72678
G1 X122.086 Y142.84 E.02353
G1 X88.405 Y109.16 E1.72678
G1 X87.756 Y109.16 E.02353
G1 X121.437 Y142.84 E1.72678
G1 X120.788 Y142.84 E.02353
G1 X87.107 Y109.16 E1.72678
G1 X86.458 Y109.16 E.02353
G1 X120.139 Y142.84 E1.72678
G1 X119.49 Y142.84 E.02353
G1 X85.809 Y109.16 E1.72678
G1 X85.16 Y109.16 E.02353
G1 X118.841 Y142.84 E1.72678
G1 X118.192 Y142.84 E.02353
G1 X84.511 Y109.16 E1.72678
G1 X83.862 Y109.16 E.02353
M73 P35 R19
G1 X117.543 Y142.84 E1.72678
G1 X116.894 Y142.84 E.02353
G1 X83.213 Y109.16 E1.72678
G1 X82.564 Y109.16 E.02353
G1 X116.245 Y142.84 E1.72678
G1 X115.596 Y142.84 E.02353
G1 X81.915 Y109.16 E1.72678
G1 X81.266 Y109.16 E.02353
G1 X114.947 Y142.84 E1.72678
G1 X114.297 Y142.84 E.02353
G1 X80.617 Y109.16 E1.72678
G1 X79.968 Y109.16 E.02353
G1 X113.648 Y142.84 E1.72678
G1 X112.999 Y142.84 E.02353
G1 X79.319 Y109.16 E1.72678
G1 X78.67 Y109.16 E.02353
G1 X112.35 Y142.84 E1.72678
G1 X111.701 Y142.84 E.02353
G1 X78.16 Y109.299 E1.71966
G1 X78.16 Y109.948 E.02353
G1 X111.052 Y142.84 E1.68638
G1 X110.403 Y142.84 E.02353
G1 X78.16 Y110.597 E1.65311
G1 X78.16 Y111.246 E.02353
G1 X109.754 Y142.84 E1.61983
G1 X109.105 Y142.84 E.02353
G1 X78.16 Y111.895 E1.58656
G1 X78.16 Y112.544 E.02353
G1 X108.456 Y142.84 E1.55328
G1 X107.807 Y142.84 E.02353
M73 P36 R19
G1 X78.16 Y113.193 E1.52
G1 X78.16 Y113.842 E.02353
G1 X107.158 Y142.84 E1.48673
G1 X106.509 Y142.84 E.02353
G1 X78.16 Y114.491 E1.45345
G1 X78.16 Y115.14 E.02353
G1 X105.86 Y142.84 E1.42018
G1 X105.211 Y142.84 E.02353
G1 X78.16 Y115.789 E1.3869
G1 X78.16 Y116.438 E.02353
G1 X104.562 Y142.84 E1.35362
G1 X103.913 Y142.84 E.02353
G1 X78.16 Y117.087 E1.32035
G1 X78.16 Y117.736 E.02353
G1 X103.264 Y142.84 E1.28707
G1 X102.615 Y142.84 E.02353
G1 X78.16 Y118.385 E1.2538
G1 X78.16 Y119.034 E.02353
G1 X101.966 Y142.84 E1.22052
G1 X101.317 Y142.84 E.02353
G1 X78.16 Y119.683 E1.18725
G1 X78.16 Y120.332 E.02353
G1 X100.668 Y142.84 E1.15397
G1 X100.019 Y142.84 E.02353
G1 X78.16 Y120.981 E1.12069
G1 X78.16 Y121.63 E.02353
G1 X99.37 Y142.84 E1.08742
G1 X98.721 Y142.84 E.02353
M73 P37 R19
G1 X78.16 Y122.279 E1.05414
G1 X78.16 Y122.929 E.02353
G1 X98.071 Y142.84 E1.02087
G1 X97.422 Y142.84 E.02353
G1 X78.16 Y123.578 E.98759
G1 X78.16 Y124.227 E.02353
G1 X96.773 Y142.84 E.95431
G1 X96.124 Y142.84 E.02353
M73 P37 R18
G1 X78.16 Y124.876 E.92104
G1 X78.16 Y125.525 E.02353
G1 X95.475 Y142.84 E.88776
G1 X94.826 Y142.84 E.02353
G1 X78.16 Y126.174 E.85449
G1 X78.16 Y126.823 E.02353
G1 X94.177 Y142.84 E.82121
G1 X93.528 Y142.84 E.02353
M73 C16
G1 X78.16 Y127.472 E.78794
G1 X78.16 Y128.121 E.02353
G1 X92.879 Y142.84 E.75466
G1 X92.23 Y142.84 E.02353
G1 X78.16 Y128.77 E.72138
G1 X78.16 Y129.419 E.02353
G1 X91.581 Y142.84 E.68811
G1 X90.932 Y142.84 E.02353
G1 X78.16 Y130.068 E.65483
G1 X78.16 Y130.717 E.02353
G1 X90.283 Y142.84 E.62156
G1 X89.634 Y142.84 E.02353
M73 P38 R18
G1 X78.16 Y131.366 E.58828
G1 X78.16 Y132.015 E.02353
G1 X88.985 Y142.84 E.555
G1 X88.336 Y142.84 E.02353
G1 X78.16 Y132.664 E.52173
G1 X78.16 Y133.313 E.02353
G1 X87.687 Y142.84 E.48845
G1 X87.038 Y142.84 E.02353
G1 X78.16 Y133.962 E.45518
G1 X78.16 Y134.611 E.02353
G1 X86.389 Y142.84 E.4219
G1 X85.74 Y142.84 E.02353
G1 X78.16 Y135.26 E.38862
G1 X78.16 Y135.909 E.02353
G1 X85.091 Y142.84 E.35535
G1 X84.442 Y142.84 E.02353
G1 X78.16 Y136.558 E.32207
G1 X78.16 Y137.207 E.02353
G1 X83.793 Y142.84 E.2888
G1 X83.144 Y142.84 E.02353
G1 X78.16 Y137.856 E.25552
G1 X78.16 Y138.505 E.02353
G1 X82.495 Y142.84 E.22225
G1 X81.846 Y142.84 E.02353
G1 X78.16 Y139.154 E.18897
G1 X78.16 Y139.804 E.02353
G1 X81.196 Y142.84 E.15569
G1 X80.547 Y142.84 E.02353
M73 P39 R18
G1 X78.16 Y140.453 E.12242
G1 X78.16 Y141.102 E.02353
G1 X80.104 Y143.046 E.09969
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F2400
G1 X78.69 Y141.632 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/10
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M976 S1 P1 ; scan model before printing 2nd layer
M400 P100
G1 E.8
; OBJECT_ID: 403
G1 E-.8
M204 S10000
G1 X86.321 Y141.781 Z.6 F30000
G1 X178.584 Y143.584 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X79.587 Y143.584 E3.18331
G1 X77.416 Y141.413 E.0987
G1 X77.416 Y108.416 E1.06104
G1 X178.584 Y108.416 E3.25311
G1 X178.584 Y126 E.56542
G1 X178.584 Y143.524 E.56349
M204 S10000
G1 X178.991 Y143.991 F30000
G1 F6000
M204 S3000
G1 X79.418 Y143.991 E3.20183
G1 X77.009 Y141.582 E.10954
G1 X77.009 Y108.009 E1.07956
G1 X178.991 Y108.009 E3.27928
G1 X178.991 Y126 E.57851
G1 X178.991 Y143.931 E.57658
M204 S10000
G1 X179.398 Y144.398 F30000
G1 F6000
M204 S3000
G1 X79.249 Y144.398 E3.22034
G1 X76.602 Y141.751 E.12039
G1 X76.602 Y107.602 E1.09807
G1 X179.398 Y107.602 E3.30546
G1 X179.398 Y126 E.5916
M73 P40 R18
G1 X179.398 Y144.338 E.58967
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E2.99952
G1 X76.21 Y141.913 E.12119
G1 X76.21 Y107.21 E1.03366
G1 X179.79 Y107.21 E3.08522
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

G1 X179.79 Y126 E.55968
G1 X179.79 Y144.73 E.55789
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.658 Y143.422 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F6000
M204 S3000
G1 X178.253 Y142.828 E.0251
G1 X178.253 Y142.294 E.01596
G1 X177.294 Y143.253 E.0405
G1 X176.759 Y143.253 E.01596
G1 X178.253 Y141.759 E.06307
G1 X178.253 Y141.225 E.01596
G1 X176.225 Y143.253 E.08564
G1 X175.69 Y143.253 E.01596
G1 X178.253 Y140.69 E.1082
G1 X178.253 Y140.156 E.01596
G1 X175.156 Y143.253 E.13077
G1 X174.621 Y143.253 E.01596
G1 X178.253 Y139.621 E.15334
G1 X178.253 Y139.087 E.01596
G1 X174.087 Y143.253 E.17591
M73 P40 R17
G1 X173.552 Y143.253 E.01596
G1 X178.253 Y138.552 E.19848
G1 X178.253 Y138.018 E.01596
G1 X173.018 Y143.253 E.22104
G1 X172.483 Y143.253 E.01596
G1 X178.253 Y137.483 E.24361
G1 X178.253 Y136.949 E.01596
G1 X171.949 Y143.253 E.26618
G1 X171.414 Y143.253 E.01596
G1 X178.253 Y136.414 E.28875
G1 X178.253 Y135.88 E.01596
G1 X170.88 Y143.253 E.31131
G1 X170.345 Y143.253 E.01596
G1 X178.253 Y135.345 E.33388
G1 X178.253 Y134.811 E.01596
G1 X169.811 Y143.253 E.35645
G1 X169.276 Y143.253 E.01596
G1 X178.253 Y134.276 E.37902
G1 X178.253 Y133.742 E.01596
G1 X168.742 Y143.253 E.40158
G1 X168.207 Y143.253 E.01596
G1 X178.253 Y133.207 E.42415
G1 X178.253 Y132.673 E.01596
G1 X167.673 Y143.253 E.44672
G1 X167.138 Y143.253 E.01596
G1 X178.253 Y132.138 E.46929
M73 C15
G1 X178.253 Y131.604 E.01596
G1 X166.603 Y143.253 E.49185
G1 X166.069 Y143.253 E.01596
G1 X178.253 Y131.069 E.51442
G1 X178.253 Y130.535 E.01596
G1 X165.534 Y143.253 E.53699
G1 X165 Y143.253 E.01596
G1 X178.253 Y130 E.55956
G1 X178.253 Y129.466 E.01596
G1 X164.465 Y143.253 E.58213
G1 X163.931 Y143.253 E.01596
G1 X178.253 Y128.931 E.60469
G1 X178.253 Y128.396 E.01596
G1 X163.396 Y143.253 E.62726
G1 X162.862 Y143.253 E.01596
G1 X178.253 Y127.862 E.64983
G1 X178.253 Y127.327 E.01596
G1 X162.327 Y143.253 E.6724
G1 X161.793 Y143.253 E.01596
G1 X178.253 Y126.793 E.69496
G1 X178.253 Y126.258 E.01596
M73 P41 R17
G1 X161.258 Y143.253 E.71753
G1 X160.724 Y143.253 E.01596
G1 X178.253 Y125.724 E.7401
G1 X178.253 Y125.189 E.01596
G1 X160.189 Y143.253 E.76267
G1 X159.655 Y143.253 E.01596
G1 X178.253 Y124.655 E.78523
G1 X178.253 Y124.12 E.01596
G1 X159.12 Y143.253 E.8078
G1 X158.586 Y143.253 E.01596
G1 X178.253 Y123.586 E.83037
G1 X178.253 Y123.051 E.01596
G1 X158.051 Y143.253 E.85294
G1 X157.517 Y143.253 E.01596
G1 X178.253 Y122.517 E.8755
G1 X178.253 Y121.982 E.01596
G1 X156.982 Y143.253 E.89807
G1 X156.448 Y143.253 E.01596
G1 X178.253 Y121.448 E.92064
G1 X178.253 Y120.913 E.01596
G1 X155.913 Y143.253 E.94321
G1 X155.379 Y143.253 E.01596
G1 X178.253 Y120.379 E.96578
G1 X178.253 Y119.844 E.01596
G1 X154.844 Y143.253 E.98834
G1 X154.31 Y143.253 E.01596
G1 X178.253 Y119.31 E1.01091
G1 X178.253 Y118.775 E.01596
G1 X153.775 Y143.253 E1.03348
G1 X153.241 Y143.253 E.01596
G1 X178.253 Y118.241 E1.05605
G1 X178.253 Y117.706 E.01596
G1 X152.706 Y143.253 E1.07861
G1 X152.172 Y143.253 E.01596
G1 X178.253 Y117.172 E1.10118
G1 X178.253 Y116.637 E.01596
G1 X151.637 Y143.253 E1.12375
G1 X151.103 Y143.253 E.01596
G1 X178.253 Y116.103 E1.14632
G1 X178.253 Y115.568 E.01596
G1 X150.568 Y143.253 E1.16888
G1 X150.034 Y143.253 E.01596
G1 X178.253 Y115.034 E1.19145
G1 X178.253 Y114.499 E.01596
G1 X149.499 Y143.253 E1.21402
G1 X148.965 Y143.253 E.01596
G1 X178.253 Y113.965 E1.23659
G1 X178.253 Y113.43 E.01596
G1 X148.43 Y143.253 E1.25915
G1 X147.896 Y143.253 E.01596
G1 X178.253 Y112.896 E1.28172
G1 X178.253 Y112.361 E.01596
G1 X147.361 Y143.253 E1.30429
G1 X146.827 Y143.253 E.01596
G1 X178.253 Y111.827 E1.32686
G1 X178.253 Y111.292 E.01596
G1 X146.292 Y143.253 E1.34943
G1 X145.758 Y143.253 E.01596
G1 X178.253 Y110.758 E1.37199
G1 X178.253 Y110.223 E.01596
G1 X145.223 Y143.253 E1.39456
G1 X144.689 Y143.253 E.01596
G1 X178.253 Y109.689 E1.41713
G1 X178.253 Y109.154 E.01596
G1 X144.154 Y143.253 E1.4397
G1 X143.62 Y143.253 E.01596
G1 X178.126 Y108.747 E1.45689
G1 X177.591 Y108.747 E.01596
G1 X143.085 Y143.253 E1.45689
G1 X142.551 Y143.253 E.01596
G1 X177.057 Y108.747 E1.45689
G1 X176.522 Y108.747 E.01596
G1 X142.016 Y143.253 E1.45689
G1 X141.482 Y143.253 E.01596
G1 X175.988 Y108.747 E1.45689
G1 X175.453 Y108.747 E.01596
G1 X140.947 Y143.253 E1.45689
G1 X140.413 Y143.253 E.01596
G1 X174.919 Y108.747 E1.45689
G1 X174.384 Y108.747 E.01596
G1 X139.878 Y143.253 E1.45689
G1 X139.344 Y143.253 E.01596
G1 X173.85 Y108.747 E1.45689
G1 X173.315 Y108.747 E.01596
G1 X138.809 Y143.253 E1.45689
G1 X138.275 Y143.253 E.01596
G1 X172.78 Y108.747 E1.45689
G1 X172.246 Y108.747 E.01596
G1 X137.74 Y143.253 E1.45689
G1 X137.206 Y143.253 E.01596
G1 X171.711 Y108.747 E1.45689
G1 X171.177 Y108.747 E.01596
G1 X136.671 Y143.253 E1.45689
G1 X136.137 Y143.253 E.01596
M73 P42 R17
G1 X170.642 Y108.747 E1.45689
G1 X170.108 Y108.747 E.01596
G1 X135.602 Y143.253 E1.45689
G1 X135.068 Y143.253 E.01596
G1 X169.573 Y108.747 E1.45689
G1 X169.039 Y108.747 E.01596
G1 X134.533 Y143.253 E1.45689
G1 X133.999 Y143.253 E.01596
G1 X168.504 Y108.747 E1.45689
G1 X167.97 Y108.747 E.01596
G1 X133.464 Y143.253 E1.45689
G1 X132.93 Y143.253 E.01596
G1 X167.435 Y108.747 E1.45689
G1 X166.901 Y108.747 E.01596
G1 X132.395 Y143.253 E1.45689
G1 X131.861 Y143.253 E.01596
G1 X166.366 Y108.747 E1.45689
G1 X165.832 Y108.747 E.01596
G1 X131.326 Y143.253 E1.45689
G1 X130.792 Y143.253 E.01596
G1 X165.297 Y108.747 E1.45689
G1 X164.763 Y108.747 E.01596
G1 X130.257 Y143.253 E1.45689
G1 X129.723 Y143.253 E.01596
G1 X164.228 Y108.747 E1.45689
G1 X163.694 Y108.747 E.01596
G1 X129.188 Y143.253 E1.45689
G1 X128.654 Y143.253 E.01596
G1 X163.159 Y108.747 E1.45689
G1 X162.625 Y108.747 E.01596
G1 X128.119 Y143.253 E1.45689
G1 X127.585 Y143.253 E.01596
G1 X162.09 Y108.747 E1.45689
G1 X161.556 Y108.747 E.01596
G1 X127.05 Y143.253 E1.45689
G1 X126.516 Y143.253 E.01596
G1 X161.021 Y108.747 E1.45689
G1 X160.487 Y108.747 E.01596
G1 X125.981 Y143.253 E1.45689
G1 X125.447 Y143.253 E.01596
G1 X159.952 Y108.747 E1.45689
G1 X159.418 Y108.747 E.01596
G1 X124.912 Y143.253 E1.45689
G1 X124.378 Y143.253 E.01596
G1 X158.883 Y108.747 E1.45689
G1 X158.349 Y108.747 E.01596
G1 X123.843 Y143.253 E1.45689
G1 X123.309 Y143.253 E.01596
G1 X157.814 Y108.747 E1.45689
G1 X157.28 Y108.747 E.01596
G1 X122.774 Y143.253 E1.45689
G1 X122.24 Y143.253 E.01596
G1 X156.745 Y108.747 E1.45689
G1 X156.211 Y108.747 E.01596
G1 X121.705 Y143.253 E1.45689
G1 X121.171 Y143.253 E.01596
G1 X155.676 Y108.747 E1.45689
G1 X155.142 Y108.747 E.01596
G1 X120.636 Y143.253 E1.45689
G1 X120.102 Y143.253 E.01596
G1 X154.607 Y108.747 E1.45689
G1 X154.073 Y108.747 E.01596
G1 X119.567 Y143.253 E1.45689
G1 X119.033 Y143.253 E.01596
G1 X153.538 Y108.747 E1.45689
G1 X153.004 Y108.747 E.01596
G1 X118.498 Y143.253 E1.45689
G1 X117.964 Y143.253 E.01596
G1 X152.469 Y108.747 E1.45689
G1 X151.935 Y108.747 E.01596
G1 X117.429 Y143.253 E1.45689
G1 X116.895 Y143.253 E.01596
G1 X151.4 Y108.747 E1.45689
G1 X150.866 Y108.747 E.01596
G1 X116.36 Y143.253 E1.45689
G1 X115.826 Y143.253 E.01596
G1 X150.331 Y108.747 E1.45689
G1 X149.797 Y108.747 E.01596
G1 X115.291 Y143.253 E1.45689
G1 X114.757 Y143.253 E.01596
G1 X149.262 Y108.747 E1.45689
G1 X148.728 Y108.747 E.01596
G1 X114.222 Y143.253 E1.45689
G1 X113.688 Y143.253 E.01596
G1 X148.193 Y108.747 E1.45689
G1 X147.659 Y108.747 E.01596
M73 P43 R17
G1 X113.153 Y143.253 E1.45689
G1 X112.619 Y143.253 E.01596
G1 X147.124 Y108.747 E1.45689
G1 X146.59 Y108.747 E.01596
G1 X112.084 Y143.253 E1.45689
G1 X111.55 Y143.253 E.01596
G1 X146.055 Y108.747 E1.45689
G1 X145.521 Y108.747 E.01596
G1 X111.015 Y143.253 E1.45689
G1 X110.481 Y143.253 E.01596
G1 X144.986 Y108.747 E1.45689
G1 X144.452 Y108.747 E.01596
G1 X109.946 Y143.253 E1.45689
G1 X109.412 Y143.253 E.01596
G1 X143.917 Y108.747 E1.45689
G1 X143.383 Y108.747 E.01596
G1 X108.877 Y143.253 E1.45689
G1 X108.343 Y143.253 E.01596
G1 X142.848 Y108.747 E1.45689
G1 X142.314 Y108.747 E.01596
G1 X107.808 Y143.253 E1.45689
G1 X107.274 Y143.253 E.01596
G1 X141.779 Y108.747 E1.45689
G1 X141.245 Y108.747 E.01596
G1 X106.739 Y143.253 E1.45689
G1 X106.205 Y143.253 E.01596
G1 X140.71 Y108.747 E1.45689
G1 X140.176 Y108.747 E.01596
G1 X105.67 Y143.253 E1.45689
G1 X105.136 Y143.253 E.01596
G1 X139.641 Y108.747 E1.45689
G1 X139.107 Y108.747 E.01596
G1 X104.601 Y143.253 E1.45689
G1 X104.067 Y143.253 E.01596
G1 X138.572 Y108.747 E1.45689
G1 X138.038 Y108.747 E.01596
G1 X103.532 Y143.253 E1.45689
G1 X102.998 Y143.253 E.01596
G1 X137.503 Y108.747 E1.45689
G1 X136.969 Y108.747 E.01596
G1 X102.463 Y143.253 E1.45689
G1 X101.929 Y143.253 E.01596
G1 X136.434 Y108.747 E1.45689
G1 X135.9 Y108.747 E.01596
G1 X101.394 Y143.253 E1.45689
G1 X100.86 Y143.253 E.01596
G1 X135.365 Y108.747 E1.45689
G1 X134.831 Y108.747 E.01596
G1 X100.325 Y143.253 E1.45689
G1 X99.791 Y143.253 E.01596
G1 X134.296 Y108.747 E1.45689
G1 X133.762 Y108.747 E.01596
G1 X99.256 Y143.253 E1.45689
G1 X98.722 Y143.253 E.01596
G1 X133.227 Y108.747 E1.45689
G1 X132.693 Y108.747 E.01596
G1 X98.187 Y143.253 E1.45689
G1 X97.653 Y143.253 E.01596
G1 X132.158 Y108.747 E1.45689
G1 X131.624 Y108.747 E.01596
M73 P43 R16
G1 X97.118 Y143.253 E1.45689
G1 X96.584 Y143.253 E.01596
G1 X131.089 Y108.747 E1.45689
G1 X130.555 Y108.747 E.01596
G1 X96.049 Y143.253 E1.45689
G1 X95.515 Y143.253 E.01596
G1 X130.02 Y108.747 E1.45689
G1 X129.486 Y108.747 E.01596
M73 P44 R16
G1 X94.98 Y143.253 E1.45689
G1 X94.446 Y143.253 E.01596
G1 X128.951 Y108.747 E1.45689
G1 X128.417 Y108.747 E.01596
G1 X93.911 Y143.253 E1.45689
G1 X93.377 Y143.253 E.01596
G1 X127.882 Y108.747 E1.45689
G1 X127.348 Y108.747 E.01596
G1 X92.842 Y143.253 E1.45689
G1 X92.308 Y143.253 E.01596
G1 X126.813 Y108.747 E1.45689
G1 X126.279 Y108.747 E.01596
G1 X91.773 Y143.253 E1.45689
G1 X91.239 Y143.253 E.01596
M73 C14
G1 X125.744 Y108.747 E1.45689
G1 X125.21 Y108.747 E.01596
G1 X90.704 Y143.253 E1.45689
G1 X90.17 Y143.253 E.01596
G1 X124.675 Y108.747 E1.45689
G1 X124.141 Y108.747 E.01596
G1 X89.635 Y143.253 E1.45689
G1 X89.101 Y143.253 E.01596
G1 X123.606 Y108.747 E1.45689
G1 X123.072 Y108.747 E.01596
G1 X88.566 Y143.253 E1.45689
G1 X88.032 Y143.253 E.01596
G1 X122.537 Y108.747 E1.45689
G1 X122.003 Y108.747 E.01596
G1 X87.497 Y143.253 E1.45689
G1 X86.963 Y143.253 E.01596
G1 X121.468 Y108.747 E1.45689
G1 X120.934 Y108.747 E.01596
G1 X86.428 Y143.253 E1.45689
G1 X85.894 Y143.253 E.01596
G1 X120.399 Y108.747 E1.45689
G1 X119.865 Y108.747 E.01596
G1 X85.359 Y143.253 E1.45689
G1 X84.825 Y143.253 E.01596
G1 X119.33 Y108.747 E1.45689
G1 X118.796 Y108.747 E.01596
G1 X84.29 Y143.253 E1.45689
G1 X83.756 Y143.253 E.01596
G1 X118.261 Y108.747 E1.45689
G1 X117.727 Y108.747 E.01596
G1 X83.221 Y143.253 E1.45689
G1 X82.687 Y143.253 E.01596
G1 X117.192 Y108.747 E1.45689
G1 X116.658 Y108.747 E.01596
G1 X82.152 Y143.253 E1.45689
G1 X81.618 Y143.253 E.01596
G1 X116.123 Y108.747 E1.45689
G1 X115.589 Y108.747 E.01596
G1 X81.083 Y143.253 E1.45689
G1 X80.549 Y143.253 E.01596
G1 X115.054 Y108.747 E1.45689
G1 X114.52 Y108.747 E.01596
G1 X80.014 Y143.253 E1.45689
G1 X79.724 Y143.253 E.00867
G1 X79.602 Y143.131 E.00515
G1 X113.985 Y108.747 E1.45174
G1 X113.451 Y108.747 E.01596
G1 X79.334 Y142.864 E1.44045
G1 X79.067 Y142.596 E.01128
G1 X112.916 Y108.747 E1.42917
G1 X112.382 Y108.747 E.01596
G1 X78.8 Y142.329 E1.41789
G1 X78.533 Y142.062 E.01128
G1 X111.847 Y108.747 E1.4066
M73 P45 R16
G1 X111.313 Y108.747 E.01596
G1 X78.265 Y141.795 E1.39532
G1 X77.998 Y141.527 E.01128
G1 X110.778 Y108.747 E1.38403
G1 X110.244 Y108.747 E.01596
G1 X77.747 Y141.244 E1.37206
G1 X77.747 Y140.709 E.01596
G1 X109.709 Y108.747 E1.3495
G1 X109.175 Y108.747 E.01596
G1 X77.747 Y140.175 E1.32693
G1 X77.747 Y139.64 E.01596
G1 X108.64 Y108.747 E1.30436
G1 X108.106 Y108.747 E.01596
G1 X77.747 Y139.106 E1.28179
G1 X77.747 Y138.571 E.01596
G1 X107.571 Y108.747 E1.25923
G1 X107.037 Y108.747 E.01596
G1 X77.747 Y138.037 E1.23666
G1 X77.747 Y137.502 E.01596
G1 X106.502 Y108.747 E1.21409
G1 X105.968 Y108.747 E.01596
G1 X77.747 Y136.968 E1.19152
G1 X77.747 Y136.433 E.01596
G1 X105.433 Y108.747 E1.16895
G1 X104.899 Y108.747 E.01596
G1 X77.747 Y135.899 E1.14639
G1 X77.747 Y135.364 E.01596
G1 X104.364 Y108.747 E1.12382
G1 X103.83 Y108.747 E.01596
G1 X77.747 Y134.83 E1.10125
G1 X77.747 Y134.295 E.01596
G1 X103.295 Y108.747 E1.07868
G1 X102.761 Y108.747 E.01596
G1 X77.747 Y133.761 E1.05612
G1 X77.747 Y133.226 E.01596
G1 X102.226 Y108.747 E1.03355
G1 X101.692 Y108.747 E.01596
G1 X77.747 Y132.692 E1.01098
G1 X77.747 Y132.157 E.01596
G1 X101.157 Y108.747 E.98841
G1 X100.623 Y108.747 E.01596
G1 X77.747 Y131.623 E.96585
G1 X77.747 Y131.088 E.01596
G1 X100.088 Y108.747 E.94328
G1 X99.554 Y108.747 E.01596
G1 X77.747 Y130.554 E.92071
G1 X77.747 Y130.019 E.01596
G1 X99.019 Y108.747 E.89814
G1 X98.485 Y108.747 E.01596
G1 X77.747 Y129.485 E.87558
G1 X77.747 Y128.95 E.01596
G1 X97.95 Y108.747 E.85301
G1 X97.416 Y108.747 E.01596
G1 X77.747 Y128.416 E.83044
G1 X77.747 Y127.881 E.01596
G1 X96.881 Y108.747 E.80787
G1 X96.347 Y108.747 E.01596
G1 X77.747 Y127.347 E.78531
G1 X77.747 Y126.812 E.01596
G1 X95.812 Y108.747 E.76274
G1 X95.278 Y108.747 E.01596
G1 X77.747 Y126.278 E.74017
G1 X77.747 Y125.743 E.01596
G1 X94.743 Y108.747 E.7176
G1 X94.209 Y108.747 E.01596
G1 X77.747 Y125.209 E.69503
G1 X77.747 Y124.674 E.01596
M73 P46 R16
G1 X93.674 Y108.747 E.67247
G1 X93.14 Y108.747 E.01596
G1 X77.747 Y124.14 E.6499
G1 X77.747 Y123.605 E.01596
G1 X92.605 Y108.747 E.62733
G1 X92.071 Y108.747 E.01596
G1 X77.747 Y123.071 E.60476
G1 X77.747 Y122.536 E.01596
G1 X91.536 Y108.747 E.5822
G1 X91.002 Y108.747 E.01596
G1 X77.747 Y122.002 E.55963
G1 X77.747 Y121.467 E.01596
G1 X90.467 Y108.747 E.53706
G1 X89.933 Y108.747 E.01596
G1 X77.747 Y120.933 E.51449
G1 X77.747 Y120.398 E.01596
G1 X89.398 Y108.747 E.49193
G1 X88.864 Y108.747 E.01596
G1 X77.747 Y119.864 E.46936
G1 X77.747 Y119.329 E.01596
G1 X88.329 Y108.747 E.44679
G1 X87.795 Y108.747 E.01596
G1 X77.747 Y118.795 E.42422
G1 X77.747 Y118.26 E.01596
G1 X87.26 Y108.747 E.40165
G1 X86.726 Y108.747 E.01596
G1 X77.747 Y117.726 E.37909
G1 X77.747 Y117.191 E.01596
G1 X86.191 Y108.747 E.35652
G1 X85.657 Y108.747 E.01596
G1 X77.747 Y116.657 E.33395
G1 X77.747 Y116.122 E.01596
G1 X85.122 Y108.747 E.31138
G1 X84.588 Y108.747 E.01596
G1 X77.747 Y115.588 E.28882
G1 X77.747 Y115.053 E.01596
G1 X84.053 Y108.747 E.26625
G1 X83.519 Y108.747 E.01596
G1 X77.747 Y114.519 E.24368
G1 X77.747 Y113.984 E.01596
G1 X82.984 Y108.747 E.22111
G1 X82.45 Y108.747 E.01596
G1 X77.747 Y113.45 E.19855
G1 X77.747 Y112.915 E.01596
G1 X81.915 Y108.747 E.17598
G1 X81.381 Y108.747 E.01596
G1 X77.747 Y112.381 E.15341
G1 X77.747 Y111.846 E.01596
G1 X80.846 Y108.747 E.13084
G1 X80.312 Y108.747 E.01596
G1 X77.747 Y111.312 E.10828
G1 X77.747 Y110.777 E.01596
G1 X79.777 Y108.747 E.08571
G1 X79.243 Y108.747 E.01596
G1 X77.747 Y110.243 E.06314
G1 X77.747 Y109.708 E.01596
G1 X78.708 Y108.747 E.04057
G1 X78.174 Y108.747 E.01596
G1 X77.578 Y109.343 E.02517
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X78.174 Y108.747 E-.32036
G1 X78.708 Y108.747 E-.20311
G1 X78.268 Y109.187 E-.23653
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/10
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 403
M204 S10000
G17
G3 Z.8 I-.395 J1.151 P1  F30000
G1 X178.584 Y143.584 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X79.587 Y143.584 E3.18331
G1 X77.416 Y141.413 E.0987
G1 X77.416 Y108.416 E1.06104
G1 X178.584 Y108.416 E3.25311
G1 X178.584 Y126 E.56542
G1 X178.584 Y143.524 E.56349
M204 S10000
G1 X178.991 Y143.991 F30000
G1 F6000
M204 S3000
G1 X79.418 Y143.991 E3.20183
M73 P47 R16
G1 X77.009 Y141.582 E.10954
G1 X77.009 Y108.009 E1.07956
G1 X178.991 Y108.009 E3.27928
G1 X178.991 Y126 E.57851
G1 X178.991 Y143.931 E.57658
M204 S10000
G1 X179.398 Y144.398 F30000
G1 F6000
M204 S3000
G1 X79.249 Y144.398 E3.22034
G1 X76.602 Y141.751 E.12039
G1 X76.602 Y107.602 E1.09807
G1 X179.398 Y107.602 E3.30546
G1 X179.398 Y126 E.5916
G1 X179.398 Y144.338 E.58967
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E2.99952
G1 X76.21 Y141.913 E.12119
G1 X76.21 Y107.21 E1.03366
G1 X179.79 Y107.21 E3.08522
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

G1 X179.79 Y126 E.55968
G1 X179.79 Y144.73 E.55789
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.926 Y137.1 Z1 F30000
M73 P47 R15
G1 X178.422 Y109.342 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42101
G1 F6000
M204 S3000
G1 X177.828 Y108.747 E.02512
G1 X177.293 Y108.747 E.01597
G1 X178.253 Y109.707 E.04054
G1 X178.253 Y110.242 E.01597
G1 X176.758 Y108.747 E.06312
G1 X176.224 Y108.747 E.01597
G1 X178.253 Y110.776 E.08571
G1 X178.253 Y111.311 E.01597
G1 X175.689 Y108.747 E.10829
G1 X175.154 Y108.747 E.01597
G1 X178.253 Y111.846 E.13088
G1 X178.253 Y112.38 E.01597
G1 X174.62 Y108.747 E.15346
G1 X174.085 Y108.747 E.01597
G1 X178.253 Y112.915 E.17604
G1 X178.253 Y113.45 E.01597
G1 X173.55 Y108.747 E.19863
G1 X173.015 Y108.747 E.01597
G1 X178.253 Y113.985 E.22121
G1 X178.253 Y114.519 E.01597
G1 X172.481 Y108.747 E.2438
G1 X171.946 Y108.747 E.01597
G1 X178.253 Y115.054 E.26638
G1 X178.253 Y115.589 E.01597
G1 X171.411 Y108.747 E.28897
G1 X170.877 Y108.747 E.01597
G1 X178.253 Y116.123 E.31155
G1 X178.253 Y116.658 E.01597
G1 X170.342 Y108.747 E.33413
G1 X169.807 Y108.747 E.01597
G1 X178.253 Y117.193 E.35672
G1 X178.253 Y117.727 E.01597
G1 X169.273 Y108.747 E.3793
G1 X168.738 Y108.747 E.01597
G1 X178.253 Y118.262 E.40189
G1 X178.253 Y118.797 E.01597
G1 X168.203 Y108.747 E.42447
G1 X167.668 Y108.747 E.01597
G1 X178.253 Y119.332 E.44706
G1 X178.253 Y119.866 E.01597
G1 X167.134 Y108.747 E.46964
G1 X166.599 Y108.747 E.01597
G1 X178.253 Y120.401 E.49223
G1 X178.253 Y120.936 E.01597
G1 X166.064 Y108.747 E.51481
G1 X165.53 Y108.747 E.01597
G1 X178.253 Y121.47 E.53739
G1 X178.253 Y122.005 E.01597
G1 X164.995 Y108.747 E.55998
G1 X164.46 Y108.747 E.01597
G1 X178.253 Y122.54 E.58256
G1 X178.253 Y123.074 E.01597
G1 X163.926 Y108.747 E.60515
G1 X163.391 Y108.747 E.01597
G1 X178.253 Y123.609 E.62773
G1 X178.253 Y124.144 E.01597
G1 X162.856 Y108.747 E.65032
G1 X162.321 Y108.747 E.01597
G1 X178.253 Y124.679 E.6729
G1 X178.253 Y125.213 E.01597
G1 X161.787 Y108.747 E.69548
M73 C13
G1 X161.252 Y108.747 E.01597
G1 X178.253 Y125.748 E.71807
G1 X178.253 Y126.283 E.01597
G1 X160.717 Y108.747 E.74065
G1 X160.183 Y108.747 E.01597
G1 X178.253 Y126.817 E.76324
G1 X178.253 Y127.352 E.01597
G1 X159.648 Y108.747 E.78582
G1 X159.113 Y108.747 E.01597
G1 X178.253 Y127.887 E.80841
G1 X178.253 Y128.421 E.01597
G1 X158.579 Y108.747 E.83099
G1 X158.044 Y108.747 E.01597
G1 X178.253 Y128.956 E.85357
G1 X178.253 Y129.491 E.01597
G1 X157.509 Y108.747 E.87616
G1 X156.974 Y108.747 E.01597
G1 X178.253 Y130.026 E.89874
G1 X178.253 Y130.56 E.01597
G1 X156.44 Y108.747 E.92133
G1 X155.905 Y108.747 E.01597
G1 X178.253 Y131.095 E.94391
G1 X178.253 Y131.63 E.01597
G1 X155.37 Y108.747 E.9665
M73 P48 R15
G1 X154.836 Y108.747 E.01597
G1 X178.253 Y132.164 E.98908
G1 X178.253 Y132.699 E.01597
G1 X154.301 Y108.747 E1.01167
G1 X153.766 Y108.747 E.01597
G1 X178.253 Y133.234 E1.03425
G1 X178.253 Y133.768 E.01597
G1 X153.232 Y108.747 E1.05683
G1 X152.697 Y108.747 E.01597
G1 X178.253 Y134.303 E1.07942
G1 X178.253 Y134.838 E.01597
G1 X152.162 Y108.747 E1.102
G1 X151.627 Y108.747 E.01597
G1 X178.253 Y135.373 E1.12459
G1 X178.253 Y135.907 E.01597
G1 X151.093 Y108.747 E1.14717
G1 X150.558 Y108.747 E.01597
G1 X178.253 Y136.442 E1.16976
G1 X178.253 Y136.977 E.01597
G1 X150.023 Y108.747 E1.19234
G1 X149.489 Y108.747 E.01597
G1 X178.253 Y137.511 E1.21492
G1 X178.253 Y138.046 E.01597
G1 X148.954 Y108.747 E1.23751
G1 X148.419 Y108.747 E.01597
G1 X178.253 Y138.581 E1.26009
G1 X178.253 Y139.115 E.01597
G1 X147.885 Y108.747 E1.28268
G1 X147.35 Y108.747 E.01597
G1 X178.253 Y139.65 E1.30526
G1 X178.253 Y140.185 E.01597
G1 X146.815 Y108.747 E1.32785
G1 X146.28 Y108.747 E.01597
G1 X178.253 Y140.72 E1.35043
G1 X178.253 Y141.254 E.01597
G1 X145.746 Y108.747 E1.37302
G1 X145.211 Y108.747 E.01597
G1 X178.253 Y141.789 E1.3956
G1 X178.253 Y142.324 E.01597
G1 X144.676 Y108.747 E1.41818
G1 X144.142 Y108.747 E.01597
G1 X178.253 Y142.858 E1.44077
G1 X178.253 Y143.253 E.01178
G1 X178.113 Y143.253 E.00419
G1 X143.607 Y108.747 E1.45743
G1 X143.072 Y108.747 E.01597
G1 X177.578 Y143.253 E1.45743
G1 X177.043 Y143.253 E.01597
G1 X142.538 Y108.747 E1.45743
G1 X142.003 Y108.747 E.01597
G1 X176.508 Y143.253 E1.45743
G1 X175.974 Y143.253 E.01597
G1 X141.468 Y108.747 E1.45743
G1 X140.933 Y108.747 E.01597
G1 X175.439 Y143.253 E1.45743
G1 X174.904 Y143.253 E.01597
G1 X140.399 Y108.747 E1.45743
G1 X139.864 Y108.747 E.01597
G1 X174.37 Y143.253 E1.45743
G1 X173.835 Y143.253 E.01597
G1 X139.329 Y108.747 E1.45743
G1 X138.795 Y108.747 E.01597
G1 X173.3 Y143.253 E1.45743
G1 X172.766 Y143.253 E.01597
G1 X138.26 Y108.747 E1.45743
G1 X137.725 Y108.747 E.01597
G1 X172.231 Y143.253 E1.45743
G1 X171.696 Y143.253 E.01597
G1 X137.191 Y108.747 E1.45743
G1 X136.656 Y108.747 E.01597
G1 X171.161 Y143.253 E1.45743
G1 X170.627 Y143.253 E.01597
G1 X136.121 Y108.747 E1.45743
G1 X135.586 Y108.747 E.01597
G1 X170.092 Y143.253 E1.45743
G1 X169.557 Y143.253 E.01597
G1 X135.052 Y108.747 E1.45743
G1 X134.517 Y108.747 E.01597
G1 X169.023 Y143.253 E1.45743
G1 X168.488 Y143.253 E.01597
G1 X133.982 Y108.747 E1.45743
G1 X133.448 Y108.747 E.01597
G1 X167.953 Y143.253 E1.45743
G1 X167.419 Y143.253 E.01597
G1 X132.913 Y108.747 E1.45743
G1 X132.378 Y108.747 E.01597
G1 X166.884 Y143.253 E1.45743
G1 X166.349 Y143.253 E.01597
G1 X131.844 Y108.747 E1.45743
G1 X131.309 Y108.747 E.01597
G1 X165.814 Y143.253 E1.45743
G1 X165.28 Y143.253 E.01597
G1 X130.774 Y108.747 E1.45743
G1 X130.239 Y108.747 E.01597
G1 X164.745 Y143.253 E1.45743
G1 X164.21 Y143.253 E.01597
G1 X129.705 Y108.747 E1.45743
G1 X129.17 Y108.747 E.01597
G1 X163.676 Y143.253 E1.45743
G1 X163.141 Y143.253 E.01597
G1 X128.635 Y108.747 E1.45743
G1 X128.101 Y108.747 E.01597
G1 X162.606 Y143.253 E1.45743
G1 X162.072 Y143.253 E.01597
G1 X127.566 Y108.747 E1.45743
G1 X127.031 Y108.747 E.01597
G1 X161.537 Y143.253 E1.45743
G1 X161.002 Y143.253 E.01597
G1 X126.497 Y108.747 E1.45743
G1 X125.962 Y108.747 E.01597
G1 X160.467 Y143.253 E1.45743
G1 X159.933 Y143.253 E.01597
G1 X125.427 Y108.747 E1.45743
G1 X124.892 Y108.747 E.01597
G1 X159.398 Y143.253 E1.45743
G1 X158.863 Y143.253 E.01597
G1 X124.358 Y108.747 E1.45743
G1 X123.823 Y108.747 E.01597
G1 X158.329 Y143.253 E1.45743
G1 X157.794 Y143.253 E.01597
G1 X123.288 Y108.747 E1.45743
G1 X122.754 Y108.747 E.01597
G1 X157.259 Y143.253 E1.45743
M73 P49 R15
G1 X156.725 Y143.253 E.01597
G1 X122.219 Y108.747 E1.45743
G1 X121.684 Y108.747 E.01597
G1 X156.19 Y143.253 E1.45743
G1 X155.655 Y143.253 E.01597
G1 X121.15 Y108.747 E1.45743
G1 X120.615 Y108.747 E.01597
G1 X155.12 Y143.253 E1.45743
G1 X154.586 Y143.253 E.01597
G1 X120.08 Y108.747 E1.45743
G1 X119.545 Y108.747 E.01597
G1 X154.051 Y143.253 E1.45743
G1 X153.516 Y143.253 E.01597
G1 X119.011 Y108.747 E1.45743
G1 X118.476 Y108.747 E.01597
G1 X152.982 Y143.253 E1.45743
G1 X152.447 Y143.253 E.01597
G1 X117.941 Y108.747 E1.45743
G1 X117.407 Y108.747 E.01597
G1 X151.912 Y143.253 E1.45743
G1 X151.378 Y143.253 E.01597
G1 X116.872 Y108.747 E1.45743
G1 X116.337 Y108.747 E.01597
G1 X150.843 Y143.253 E1.45743
G1 X150.308 Y143.253 E.01597
G1 X115.803 Y108.747 E1.45743
G1 X115.268 Y108.747 E.01597
G1 X149.773 Y143.253 E1.45743
G1 X149.239 Y143.253 E.01597
G1 X114.733 Y108.747 E1.45743
G1 X114.198 Y108.747 E.01597
G1 X148.704 Y143.253 E1.45743
G1 X148.169 Y143.253 E.01597
G1 X113.664 Y108.747 E1.45743
G1 X113.129 Y108.747 E.01597
G1 X147.635 Y143.253 E1.45743
G1 X147.1 Y143.253 E.01597
G1 X112.594 Y108.747 E1.45743
G1 X112.06 Y108.747 E.01597
G1 X146.565 Y143.253 E1.45743
G1 X146.031 Y143.253 E.01597
G1 X111.525 Y108.747 E1.45743
G1 X110.99 Y108.747 E.01597
G1 X145.496 Y143.253 E1.45743
G1 X144.961 Y143.253 E.01597
G1 X110.456 Y108.747 E1.45743
G1 X109.921 Y108.747 E.01597
G1 X144.426 Y143.253 E1.45743
G1 X143.892 Y143.253 E.01597
G1 X109.386 Y108.747 E1.45743
G1 X108.851 Y108.747 E.01597
G1 X143.357 Y143.253 E1.45743
G1 X142.822 Y143.253 E.01597
G1 X108.317 Y108.747 E1.45743
G1 X107.782 Y108.747 E.01597
G1 X142.288 Y143.253 E1.45743
G1 X141.753 Y143.253 E.01597
G1 X107.247 Y108.747 E1.45743
G1 X106.713 Y108.747 E.01597
G1 X141.218 Y143.253 E1.45743
G1 X140.684 Y143.253 E.01597
G1 X106.178 Y108.747 E1.45743
G1 X105.643 Y108.747 E.01597
G1 X140.149 Y143.253 E1.45743
G1 X139.614 Y143.253 E.01597
G1 X105.109 Y108.747 E1.45743
G1 X104.574 Y108.747 E.01597
G1 X139.079 Y143.253 E1.45743
G1 X138.545 Y143.253 E.01597
M73 P50 R15
G1 X104.039 Y108.747 E1.45743
G1 X103.504 Y108.747 E.01597
G1 X138.01 Y143.253 E1.45743
G1 X137.475 Y143.253 E.01597
G1 X102.97 Y108.747 E1.45743
G1 X102.435 Y108.747 E.01597
G1 X136.941 Y143.253 E1.45743
G1 X136.406 Y143.253 E.01597
G1 X101.9 Y108.747 E1.45743
G1 X101.366 Y108.747 E.01597
G1 X135.871 Y143.253 E1.45743
G1 X135.337 Y143.253 E.01597
G1 X100.831 Y108.747 E1.45743
G1 X100.296 Y108.747 E.01597
G1 X134.802 Y143.253 E1.45743
G1 X134.267 Y143.253 E.01597
G1 X99.762 Y108.747 E1.45743
G1 X99.227 Y108.747 E.01597
G1 X133.732 Y143.253 E1.45743
G1 X133.198 Y143.253 E.01597
G1 X98.692 Y108.747 E1.45743
G1 X98.157 Y108.747 E.01597
G1 X132.663 Y143.253 E1.45743
G1 X132.128 Y143.253 E.01597
G1 X97.623 Y108.747 E1.45743
G1 X97.088 Y108.747 E.01597
G1 X131.594 Y143.253 E1.45743
G1 X131.059 Y143.253 E.01597
G1 X96.553 Y108.747 E1.45743
G1 X96.019 Y108.747 E.01597
G1 X130.524 Y143.253 E1.45743
G1 X129.99 Y143.253 E.01597
G1 X95.484 Y108.747 E1.45743
G1 X94.949 Y108.747 E.01597
G1 X129.455 Y143.253 E1.45743
G1 X128.92 Y143.253 E.01597
M73 P50 R14
G1 X94.415 Y108.747 E1.45743
G1 X93.88 Y108.747 E.01597
G1 X128.385 Y143.253 E1.45743
G1 X127.851 Y143.253 E.01597
G1 X93.345 Y108.747 E1.45743
G1 X92.81 Y108.747 E.01597
G1 X127.316 Y143.253 E1.45743
G1 X126.781 Y143.253 E.01597
G1 X92.276 Y108.747 E1.45743
G1 X91.741 Y108.747 E.01597
G1 X126.247 Y143.253 E1.45743
G1 X125.712 Y143.253 E.01597
G1 X91.206 Y108.747 E1.45743
G1 X90.672 Y108.747 E.01597
G1 X125.177 Y143.253 E1.45743
G1 X124.643 Y143.253 E.01597
G1 X90.137 Y108.747 E1.45743
G1 X89.602 Y108.747 E.01597
G1 X124.108 Y143.253 E1.45743
G1 X123.573 Y143.253 E.01597
M73 C12
G1 X89.068 Y108.747 E1.45743
G1 X88.533 Y108.747 E.01597
G1 X123.038 Y143.253 E1.45743
G1 X122.504 Y143.253 E.01597
G1 X87.998 Y108.747 E1.45743
G1 X87.463 Y108.747 E.01597
G1 X121.969 Y143.253 E1.45743
G1 X121.434 Y143.253 E.01597
G1 X86.929 Y108.747 E1.45743
G1 X86.394 Y108.747 E.01597
G1 X120.9 Y143.253 E1.45743
G1 X120.365 Y143.253 E.01597
M73 P51 R14
G1 X85.859 Y108.747 E1.45743
G1 X85.325 Y108.747 E.01597
G1 X119.83 Y143.253 E1.45743
G1 X119.296 Y143.253 E.01597
G1 X84.79 Y108.747 E1.45743
G1 X84.255 Y108.747 E.01597
G1 X118.761 Y143.253 E1.45743
G1 X118.226 Y143.253 E.01597
G1 X83.721 Y108.747 E1.45743
G1 X83.186 Y108.747 E.01597
G1 X117.691 Y143.253 E1.45743
G1 X117.157 Y143.253 E.01597
G1 X82.651 Y108.747 E1.45743
G1 X82.116 Y108.747 E.01597
G1 X116.622 Y143.253 E1.45743
G1 X116.087 Y143.253 E.01597
G1 X81.582 Y108.747 E1.45743
G1 X81.047 Y108.747 E.01597
G1 X115.553 Y143.253 E1.45743
G1 X115.018 Y143.253 E.01597
G1 X80.512 Y108.747 E1.45743
G1 X79.978 Y108.747 E.01597
G1 X114.483 Y143.253 E1.45743
G1 X113.949 Y143.253 E.01597
G1 X79.443 Y108.747 E1.45743
G1 X78.908 Y108.747 E.01597
G1 X113.414 Y143.253 E1.45743
G1 X112.879 Y143.253 E.01597
G1 X78.374 Y108.747 E1.45743
G1 X77.839 Y108.747 E.01597
G1 X112.344 Y143.253 E1.45743
G1 X111.81 Y143.253 E.01597
G1 X77.747 Y109.19 E1.43872
G1 X77.747 Y109.725 E.01597
G1 X111.275 Y143.253 E1.41613
G1 X110.74 Y143.253 E.01597
G1 X77.747 Y110.26 E1.39355
G1 X77.747 Y110.794 E.01597
G1 X110.206 Y143.253 E1.37096
G1 X109.671 Y143.253 E.01597
G1 X77.747 Y111.329 E1.34838
G1 X77.747 Y111.864 E.01597
G1 X109.136 Y143.253 E1.32579
G1 X108.602 Y143.253 E.01597
G1 X77.747 Y112.398 E1.30321
G1 X77.747 Y112.933 E.01597
G1 X108.067 Y143.253 E1.28063
G1 X107.532 Y143.253 E.01597
G1 X77.747 Y113.468 E1.25804
G1 X77.747 Y114.003 E.01597
G1 X106.997 Y143.253 E1.23546
G1 X106.463 Y143.253 E.01597
G1 X77.747 Y114.537 E1.21287
G1 X77.747 Y115.072 E.01597
G1 X105.928 Y143.253 E1.19029
G1 X105.393 Y143.253 E.01597
G1 X77.747 Y115.607 E1.1677
G1 X77.747 Y116.141 E.01597
G1 X104.859 Y143.253 E1.14512
G1 X104.324 Y143.253 E.01597
G1 X77.747 Y116.676 E1.12253
G1 X77.747 Y117.211 E.01597
G1 X103.789 Y143.253 E1.09995
G1 X103.255 Y143.253 E.01597
G1 X77.747 Y117.745 E1.07737
G1 X77.747 Y118.28 E.01597
G1 X102.72 Y143.253 E1.05478
G1 X102.185 Y143.253 E.01597
M73 P52 R14
G1 X77.747 Y118.815 E1.0322
G1 X77.747 Y119.35 E.01597
G1 X101.65 Y143.253 E1.00961
G1 X101.116 Y143.253 E.01597
G1 X77.747 Y119.884 E.98703
G1 X77.747 Y120.419 E.01597
G1 X100.581 Y143.253 E.96444
G1 X100.046 Y143.253 E.01597
G1 X77.747 Y120.954 E.94186
G1 X77.747 Y121.488 E.01597
G1 X99.512 Y143.253 E.91928
G1 X98.977 Y143.253 E.01597
G1 X77.747 Y122.023 E.89669
G1 X77.747 Y122.558 E.01597
G1 X98.442 Y143.253 E.87411
G1 X97.908 Y143.253 E.01597
G1 X77.747 Y123.092 E.85152
G1 X77.747 Y123.627 E.01597
G1 X97.373 Y143.253 E.82894
G1 X96.838 Y143.253 E.01597
G1 X77.747 Y124.162 E.80635
G1 X77.747 Y124.697 E.01597
G1 X96.303 Y143.253 E.78377
G1 X95.769 Y143.253 E.01597
G1 X77.747 Y125.231 E.76118
G1 X77.747 Y125.766 E.01597
G1 X95.234 Y143.253 E.7386
G1 X94.699 Y143.253 E.01597
G1 X77.747 Y126.301 E.71602
G1 X77.747 Y126.835 E.01597
G1 X94.165 Y143.253 E.69343
G1 X93.63 Y143.253 E.01597
G1 X77.747 Y127.37 E.67085
G1 X77.747 Y127.905 E.01597
G1 X93.095 Y143.253 E.64826
G1 X92.561 Y143.253 E.01597
G1 X77.747 Y128.439 E.62568
G1 X77.747 Y128.974 E.01597
G1 X92.026 Y143.253 E.60309
G1 X91.491 Y143.253 E.01597
G1 X77.747 Y129.509 E.58051
G1 X77.747 Y130.044 E.01597
G1 X90.956 Y143.253 E.55793
G1 X90.422 Y143.253 E.01597
G1 X77.747 Y130.578 E.53534
G1 X77.747 Y131.113 E.01597
G1 X89.887 Y143.253 E.51276
G1 X89.352 Y143.253 E.01597
G1 X77.747 Y131.648 E.49017
G1 X77.747 Y132.182 E.01597
G1 X88.818 Y143.253 E.46759
G1 X88.283 Y143.253 E.01597
G1 X77.747 Y132.717 E.445
G1 X77.747 Y133.252 E.01597
G1 X87.748 Y143.253 E.42242
G1 X87.214 Y143.253 E.01597
G1 X77.747 Y133.786 E.39983
G1 X77.747 Y134.321 E.01597
G1 X86.679 Y143.253 E.37725
G1 X86.144 Y143.253 E.01597
G1 X77.747 Y134.856 E.35467
G1 X77.747 Y135.391 E.01597
G1 X85.609 Y143.253 E.33208
G1 X85.075 Y143.253 E.01597
G1 X77.747 Y135.925 E.3095
G1 X77.747 Y136.46 E.01597
G1 X84.54 Y143.253 E.28691
G1 X84.005 Y143.253 E.01597
M73 P53 R14
G1 X77.747 Y136.995 E.26433
G1 X77.747 Y137.529 E.01597
G1 X83.471 Y143.253 E.24174
G1 X82.936 Y143.253 E.01597
G1 X77.747 Y138.064 E.21916
G1 X77.747 Y138.599 E.01597
G1 X82.401 Y143.253 E.19658
G1 X81.867 Y143.253 E.01597
G1 X77.747 Y139.133 E.17399
G1 X77.747 Y139.668 E.01597
G1 X81.332 Y143.253 E.15141
G1 X80.797 Y143.253 E.01597
G1 X77.747 Y140.203 E.12882
G1 X77.747 Y140.738 E.01597
G1 X80.262 Y143.253 E.10624
G1 X79.728 Y143.253 E.01597
G1 X77.578 Y141.103 E.09082
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X78.992 Y142.517 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/10
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S102
; OBJECT_ID: 403
M204 S10000
G17
G3 Z1 I-.013 J1.217 P1  F30000
G1 X178.584 Y143.584 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X79.587 Y143.584 E3.18331
G1 X77.416 Y141.413 E.0987
G1 X77.416 Y108.416 E1.06104
G1 X178.584 Y108.416 E3.25311
G1 X178.584 Y126 E.56542
G1 X178.584 Y143.524 E.56349
M204 S10000
G1 X178.991 Y143.991 F30000
G1 F6000
M204 S3000
G1 X79.418 Y143.991 E3.20183
G1 X77.009 Y141.582 E.10954
G1 X77.009 Y108.009 E1.07956
G1 X178.991 Y108.009 E3.27928
G1 X178.991 Y126 E.57851
G1 X178.991 Y143.931 E.57658
M204 S10000
G1 X179.398 Y144.398 F30000
G1 F6000
M204 S3000
G1 X79.249 Y144.398 E3.22034
G1 X76.602 Y141.751 E.12039
G1 X76.602 Y107.602 E1.09807
G1 X179.398 Y107.602 E3.30546
G1 X179.398 Y126 E.5916
G1 X179.398 Y144.338 E.58967
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E2.99952
G1 X76.21 Y141.913 E.12119
G1 X76.21 Y107.21 E1.03366
G1 X179.79 Y107.21 E3.08522
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

G1 X179.79 Y126 E.55968
G1 X179.79 Y144.73 E.55789
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.658 Y143.422 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F6000
M204 S3000
G1 X178.253 Y142.828 E.0251
G1 X178.253 Y142.294 E.01596
G1 X177.294 Y143.253 E.0405
G1 X176.759 Y143.253 E.01596
G1 X178.253 Y141.759 E.06307
G1 X178.253 Y141.225 E.01596
G1 X176.225 Y143.253 E.08564
G1 X175.69 Y143.253 E.01596
G1 X178.253 Y140.69 E.1082
G1 X178.253 Y140.156 E.01596
G1 X175.156 Y143.253 E.13077
G1 X174.621 Y143.253 E.01596
G1 X178.253 Y139.621 E.15334
G1 X178.253 Y139.087 E.01596
G1 X174.087 Y143.253 E.17591
G1 X173.552 Y143.253 E.01596
G1 X178.253 Y138.552 E.19848
G1 X178.253 Y138.018 E.01596
G1 X173.018 Y143.253 E.22104
G1 X172.483 Y143.253 E.01596
G1 X178.253 Y137.483 E.24361
G1 X178.253 Y136.949 E.01596
G1 X171.949 Y143.253 E.26618
G1 X171.414 Y143.253 E.01596
G1 X178.253 Y136.414 E.28875
G1 X178.253 Y135.88 E.01596
G1 X170.88 Y143.253 E.31131
M73 P53 R13
G1 X170.345 Y143.253 E.01596
G1 X178.253 Y135.345 E.33388
G1 X178.253 Y134.811 E.01596
G1 X169.811 Y143.253 E.35645
G1 X169.276 Y143.253 E.01596
G1 X178.253 Y134.276 E.37902
G1 X178.253 Y133.742 E.01596
G1 X168.742 Y143.253 E.40158
G1 X168.207 Y143.253 E.01596
G1 X178.253 Y133.207 E.42415
G1 X178.253 Y132.673 E.01596
G1 X167.673 Y143.253 E.44672
G1 X167.138 Y143.253 E.01596
G1 X178.253 Y132.138 E.46929
G1 X178.253 Y131.604 E.01596
G1 X166.603 Y143.253 E.49185
G1 X166.069 Y143.253 E.01596
G1 X178.253 Y131.069 E.51442
G1 X178.253 Y130.535 E.01596
G1 X165.534 Y143.253 E.53699
G1 X165 Y143.253 E.01596
G1 X178.253 Y130 E.55956
G1 X178.253 Y129.466 E.01596
G1 X164.465 Y143.253 E.58213
G1 X163.931 Y143.253 E.01596
G1 X178.253 Y128.931 E.60469
G1 X178.253 Y128.396 E.01596
G1 X163.396 Y143.253 E.62726
G1 X162.862 Y143.253 E.01596
G1 X178.253 Y127.862 E.64983
G1 X178.253 Y127.327 E.01596
G1 X162.327 Y143.253 E.6724
G1 X161.793 Y143.253 E.01596
G1 X178.253 Y126.793 E.69496
G1 X178.253 Y126.258 E.01596
G1 X161.258 Y143.253 E.71753
G1 X160.724 Y143.253 E.01596
M73 P54 R13
G1 X178.253 Y125.724 E.7401
G1 X178.253 Y125.189 E.01596
G1 X160.189 Y143.253 E.76267
G1 X159.655 Y143.253 E.01596
G1 X178.253 Y124.655 E.78523
G1 X178.253 Y124.12 E.01596
M73 C11
G1 X159.12 Y143.253 E.8078
G1 X158.586 Y143.253 E.01596
G1 X178.253 Y123.586 E.83037
G1 X178.253 Y123.051 E.01596
G1 X158.051 Y143.253 E.85294
G1 X157.517 Y143.253 E.01596
G1 X178.253 Y122.517 E.8755
G1 X178.253 Y121.982 E.01596
G1 X156.982 Y143.253 E.89807
G1 X156.448 Y143.253 E.01596
G1 X178.253 Y121.448 E.92064
G1 X178.253 Y120.913 E.01596
G1 X155.913 Y143.253 E.94321
G1 X155.379 Y143.253 E.01596
G1 X178.253 Y120.379 E.96578
G1 X178.253 Y119.844 E.01596
G1 X154.844 Y143.253 E.98834
G1 X154.31 Y143.253 E.01596
G1 X178.253 Y119.31 E1.01091
G1 X178.253 Y118.775 E.01596
G1 X153.775 Y143.253 E1.03348
G1 X153.241 Y143.253 E.01596
G1 X178.253 Y118.241 E1.05605
G1 X178.253 Y117.706 E.01596
G1 X152.706 Y143.253 E1.07861
G1 X152.172 Y143.253 E.01596
G1 X178.253 Y117.172 E1.10118
G1 X178.253 Y116.637 E.01596
G1 X151.637 Y143.253 E1.12375
G1 X151.103 Y143.253 E.01596
G1 X178.253 Y116.103 E1.14632
G1 X178.253 Y115.568 E.01596
G1 X150.568 Y143.253 E1.16888
G1 X150.034 Y143.253 E.01596
G1 X178.253 Y115.034 E1.19145
G1 X178.253 Y114.499 E.01596
G1 X149.499 Y143.253 E1.21402
G1 X148.965 Y143.253 E.01596
G1 X178.253 Y113.965 E1.23659
G1 X178.253 Y113.43 E.01596
G1 X148.43 Y143.253 E1.25915
G1 X147.896 Y143.253 E.01596
G1 X178.253 Y112.896 E1.28172
G1 X178.253 Y112.361 E.01596
G1 X147.361 Y143.253 E1.30429
G1 X146.827 Y143.253 E.01596
G1 X178.253 Y111.827 E1.32686
G1 X178.253 Y111.292 E.01596
G1 X146.292 Y143.253 E1.34943
G1 X145.758 Y143.253 E.01596
G1 X178.253 Y110.758 E1.37199
G1 X178.253 Y110.223 E.01596
G1 X145.223 Y143.253 E1.39456
G1 X144.689 Y143.253 E.01596
G1 X178.253 Y109.689 E1.41713
G1 X178.253 Y109.154 E.01596
G1 X144.154 Y143.253 E1.4397
G1 X143.62 Y143.253 E.01596
G1 X178.126 Y108.747 E1.45689
G1 X177.591 Y108.747 E.01596
G1 X143.085 Y143.253 E1.45689
G1 X142.551 Y143.253 E.01596
G1 X177.057 Y108.747 E1.45689
G1 X176.522 Y108.747 E.01596
G1 X142.016 Y143.253 E1.45689
G1 X141.482 Y143.253 E.01596
G1 X175.988 Y108.747 E1.45689
G1 X175.453 Y108.747 E.01596
G1 X140.947 Y143.253 E1.45689
G1 X140.413 Y143.253 E.01596
G1 X174.919 Y108.747 E1.45689
G1 X174.384 Y108.747 E.01596
G1 X139.878 Y143.253 E1.45689
G1 X139.344 Y143.253 E.01596
G1 X173.85 Y108.747 E1.45689
G1 X173.315 Y108.747 E.01596
G1 X138.809 Y143.253 E1.45689
G1 X138.275 Y143.253 E.01596
G1 X172.78 Y108.747 E1.45689
G1 X172.246 Y108.747 E.01596
G1 X137.74 Y143.253 E1.45689
G1 X137.206 Y143.253 E.01596
G1 X171.711 Y108.747 E1.45689
G1 X171.177 Y108.747 E.01596
G1 X136.671 Y143.253 E1.45689
G1 X136.137 Y143.253 E.01596
G1 X170.642 Y108.747 E1.45689
G1 X170.108 Y108.747 E.01596
G1 X135.602 Y143.253 E1.45689
G1 X135.068 Y143.253 E.01596
G1 X169.573 Y108.747 E1.45689
G1 X169.039 Y108.747 E.01596
G1 X134.533 Y143.253 E1.45689
G1 X133.999 Y143.253 E.01596
M73 P55 R13
G1 X168.504 Y108.747 E1.45689
G1 X167.97 Y108.747 E.01596
G1 X133.464 Y143.253 E1.45689
G1 X132.93 Y143.253 E.01596
G1 X167.435 Y108.747 E1.45689
G1 X166.901 Y108.747 E.01596
G1 X132.395 Y143.253 E1.45689
G1 X131.861 Y143.253 E.01596
G1 X166.366 Y108.747 E1.45689
G1 X165.832 Y108.747 E.01596
G1 X131.326 Y143.253 E1.45689
G1 X130.792 Y143.253 E.01596
G1 X165.297 Y108.747 E1.45689
G1 X164.763 Y108.747 E.01596
G1 X130.257 Y143.253 E1.45689
G1 X129.723 Y143.253 E.01596
G1 X164.228 Y108.747 E1.45689
G1 X163.694 Y108.747 E.01596
G1 X129.188 Y143.253 E1.45689
G1 X128.654 Y143.253 E.01596
G1 X163.159 Y108.747 E1.45689
G1 X162.625 Y108.747 E.01596
G1 X128.119 Y143.253 E1.45689
G1 X127.585 Y143.253 E.01596
G1 X162.09 Y108.747 E1.45689
G1 X161.556 Y108.747 E.01596
G1 X127.05 Y143.253 E1.45689
G1 X126.516 Y143.253 E.01596
G1 X161.021 Y108.747 E1.45689
G1 X160.487 Y108.747 E.01596
G1 X125.981 Y143.253 E1.45689
G1 X125.447 Y143.253 E.01596
G1 X159.952 Y108.747 E1.45689
G1 X159.418 Y108.747 E.01596
G1 X124.912 Y143.253 E1.45689
G1 X124.378 Y143.253 E.01596
G1 X158.883 Y108.747 E1.45689
G1 X158.349 Y108.747 E.01596
G1 X123.843 Y143.253 E1.45689
G1 X123.309 Y143.253 E.01596
G1 X157.814 Y108.747 E1.45689
G1 X157.28 Y108.747 E.01596
G1 X122.774 Y143.253 E1.45689
G1 X122.24 Y143.253 E.01596
G1 X156.745 Y108.747 E1.45689
G1 X156.211 Y108.747 E.01596
G1 X121.705 Y143.253 E1.45689
G1 X121.171 Y143.253 E.01596
G1 X155.676 Y108.747 E1.45689
G1 X155.142 Y108.747 E.01596
G1 X120.636 Y143.253 E1.45689
G1 X120.102 Y143.253 E.01596
G1 X154.607 Y108.747 E1.45689
G1 X154.073 Y108.747 E.01596
G1 X119.567 Y143.253 E1.45689
G1 X119.033 Y143.253 E.01596
G1 X153.538 Y108.747 E1.45689
G1 X153.004 Y108.747 E.01596
G1 X118.498 Y143.253 E1.45689
G1 X117.964 Y143.253 E.01596
G1 X152.469 Y108.747 E1.45689
G1 X151.935 Y108.747 E.01596
G1 X117.429 Y143.253 E1.45689
G1 X116.895 Y143.253 E.01596
G1 X151.4 Y108.747 E1.45689
G1 X150.866 Y108.747 E.01596
G1 X116.36 Y143.253 E1.45689
G1 X115.826 Y143.253 E.01596
G1 X150.331 Y108.747 E1.45689
G1 X149.797 Y108.747 E.01596
G1 X115.291 Y143.253 E1.45689
G1 X114.757 Y143.253 E.01596
G1 X149.262 Y108.747 E1.45689
G1 X148.728 Y108.747 E.01596
G1 X114.222 Y143.253 E1.45689
G1 X113.688 Y143.253 E.01596
G1 X148.193 Y108.747 E1.45689
G1 X147.659 Y108.747 E.01596
G1 X113.153 Y143.253 E1.45689
G1 X112.619 Y143.253 E.01596
G1 X147.124 Y108.747 E1.45689
G1 X146.59 Y108.747 E.01596
M73 P56 R13
G1 X112.084 Y143.253 E1.45689
G1 X111.55 Y143.253 E.01596
G1 X146.055 Y108.747 E1.45689
G1 X145.521 Y108.747 E.01596
G1 X111.015 Y143.253 E1.45689
G1 X110.481 Y143.253 E.01596
G1 X144.986 Y108.747 E1.45689
G1 X144.452 Y108.747 E.01596
G1 X109.946 Y143.253 E1.45689
G1 X109.412 Y143.253 E.01596
G1 X143.917 Y108.747 E1.45689
G1 X143.383 Y108.747 E.01596
G1 X108.877 Y143.253 E1.45689
G1 X108.343 Y143.253 E.01596
G1 X142.848 Y108.747 E1.45689
G1 X142.314 Y108.747 E.01596
G1 X107.808 Y143.253 E1.45689
G1 X107.274 Y143.253 E.01596
G1 X141.779 Y108.747 E1.45689
G1 X141.245 Y108.747 E.01596
G1 X106.739 Y143.253 E1.45689
G1 X106.205 Y143.253 E.01596
G1 X140.71 Y108.747 E1.45689
G1 X140.176 Y108.747 E.01596
G1 X105.67 Y143.253 E1.45689
G1 X105.136 Y143.253 E.01596
G1 X139.641 Y108.747 E1.45689
G1 X139.107 Y108.747 E.01596
G1 X104.601 Y143.253 E1.45689
G1 X104.067 Y143.253 E.01596
G1 X138.572 Y108.747 E1.45689
G1 X138.038 Y108.747 E.01596
G1 X103.532 Y143.253 E1.45689
G1 X102.998 Y143.253 E.01596
G1 X137.503 Y108.747 E1.45689
G1 X136.969 Y108.747 E.01596
G1 X102.463 Y143.253 E1.45689
G1 X101.929 Y143.253 E.01596
G1 X136.434 Y108.747 E1.45689
G1 X135.9 Y108.747 E.01596
G1 X101.394 Y143.253 E1.45689
G1 X100.86 Y143.253 E.01596
G1 X135.365 Y108.747 E1.45689
G1 X134.831 Y108.747 E.01596
G1 X100.325 Y143.253 E1.45689
G1 X99.791 Y143.253 E.01596
G1 X134.296 Y108.747 E1.45689
G1 X133.762 Y108.747 E.01596
G1 X99.256 Y143.253 E1.45689
G1 X98.722 Y143.253 E.01596
G1 X133.227 Y108.747 E1.45689
G1 X132.693 Y108.747 E.01596
G1 X98.187 Y143.253 E1.45689
G1 X97.653 Y143.253 E.01596
G1 X132.158 Y108.747 E1.45689
G1 X131.624 Y108.747 E.01596
G1 X97.118 Y143.253 E1.45689
G1 X96.584 Y143.253 E.01596
G1 X131.089 Y108.747 E1.45689
G1 X130.555 Y108.747 E.01596
G1 X96.049 Y143.253 E1.45689
G1 X95.515 Y143.253 E.01596
G1 X130.02 Y108.747 E1.45689
G1 X129.486 Y108.747 E.01596
G1 X94.98 Y143.253 E1.45689
G1 X94.446 Y143.253 E.01596
G1 X128.951 Y108.747 E1.45689
G1 X128.417 Y108.747 E.01596
M73 P57 R13
G1 X93.911 Y143.253 E1.45689
G1 X93.377 Y143.253 E.01596
G1 X127.882 Y108.747 E1.45689
G1 X127.348 Y108.747 E.01596
G1 X92.842 Y143.253 E1.45689
G1 X92.308 Y143.253 E.01596
M73 P57 R12
G1 X126.813 Y108.747 E1.45689
G1 X126.279 Y108.747 E.01596
G1 X91.773 Y143.253 E1.45689
G1 X91.239 Y143.253 E.01596
G1 X125.744 Y108.747 E1.45689
G1 X125.21 Y108.747 E.01596
G1 X90.704 Y143.253 E1.45689
G1 X90.17 Y143.253 E.01596
G1 X124.675 Y108.747 E1.45689
G1 X124.141 Y108.747 E.01596
G1 X89.635 Y143.253 E1.45689
G1 X89.101 Y143.253 E.01596
G1 X123.606 Y108.747 E1.45689
G1 X123.072 Y108.747 E.01596
G1 X88.566 Y143.253 E1.45689
G1 X88.032 Y143.253 E.01596
G1 X122.537 Y108.747 E1.45689
G1 X122.003 Y108.747 E.01596
G1 X87.497 Y143.253 E1.45689
G1 X86.963 Y143.253 E.01596
G1 X121.468 Y108.747 E1.45689
G1 X120.934 Y108.747 E.01596
M73 C10
G1 X86.428 Y143.253 E1.45689
G1 X85.894 Y143.253 E.01596
G1 X120.399 Y108.747 E1.45689
G1 X119.865 Y108.747 E.01596
G1 X85.359 Y143.253 E1.45689
G1 X84.825 Y143.253 E.01596
G1 X119.33 Y108.747 E1.45689
G1 X118.796 Y108.747 E.01596
G1 X84.29 Y143.253 E1.45689
G1 X83.756 Y143.253 E.01596
G1 X118.261 Y108.747 E1.45689
G1 X117.727 Y108.747 E.01596
G1 X83.221 Y143.253 E1.45689
G1 X82.687 Y143.253 E.01596
G1 X117.192 Y108.747 E1.45689
G1 X116.658 Y108.747 E.01596
G1 X82.152 Y143.253 E1.45689
G1 X81.618 Y143.253 E.01596
G1 X116.123 Y108.747 E1.45689
G1 X115.589 Y108.747 E.01596
G1 X81.083 Y143.253 E1.45689
G1 X80.549 Y143.253 E.01596
G1 X115.054 Y108.747 E1.45689
G1 X114.52 Y108.747 E.01596
G1 X80.014 Y143.253 E1.45689
G1 X79.724 Y143.253 E.00867
G1 X79.602 Y143.131 E.00515
G1 X113.985 Y108.747 E1.45174
G1 X113.451 Y108.747 E.01596
G1 X79.334 Y142.864 E1.44045
G1 X79.067 Y142.596 E.01128
G1 X112.916 Y108.747 E1.42917
G1 X112.382 Y108.747 E.01596
G1 X78.8 Y142.329 E1.41789
G1 X78.533 Y142.062 E.01128
G1 X111.847 Y108.747 E1.4066
G1 X111.313 Y108.747 E.01596
G1 X78.265 Y141.795 E1.39532
G1 X77.998 Y141.527 E.01128
G1 X110.778 Y108.747 E1.38403
M73 P58 R12
G1 X110.244 Y108.747 E.01596
G1 X77.747 Y141.244 E1.37206
G1 X77.747 Y140.709 E.01596
G1 X109.709 Y108.747 E1.3495
G1 X109.175 Y108.747 E.01596
G1 X77.747 Y140.175 E1.32693
G1 X77.747 Y139.64 E.01596
G1 X108.64 Y108.747 E1.30436
G1 X108.106 Y108.747 E.01596
G1 X77.747 Y139.106 E1.28179
G1 X77.747 Y138.571 E.01596
G1 X107.571 Y108.747 E1.25923
G1 X107.037 Y108.747 E.01596
G1 X77.747 Y138.037 E1.23666
G1 X77.747 Y137.502 E.01596
G1 X106.502 Y108.747 E1.21409
G1 X105.968 Y108.747 E.01596
G1 X77.747 Y136.968 E1.19152
G1 X77.747 Y136.433 E.01596
G1 X105.433 Y108.747 E1.16895
G1 X104.899 Y108.747 E.01596
G1 X77.747 Y135.899 E1.14639
G1 X77.747 Y135.364 E.01596
G1 X104.364 Y108.747 E1.12382
G1 X103.83 Y108.747 E.01596
G1 X77.747 Y134.83 E1.10125
G1 X77.747 Y134.295 E.01596
G1 X103.295 Y108.747 E1.07868
G1 X102.761 Y108.747 E.01596
G1 X77.747 Y133.761 E1.05612
G1 X77.747 Y133.226 E.01596
G1 X102.226 Y108.747 E1.03355
G1 X101.692 Y108.747 E.01596
G1 X77.747 Y132.692 E1.01098
G1 X77.747 Y132.157 E.01596
G1 X101.157 Y108.747 E.98841
G1 X100.623 Y108.747 E.01596
G1 X77.747 Y131.623 E.96585
G1 X77.747 Y131.088 E.01596
G1 X100.088 Y108.747 E.94328
G1 X99.554 Y108.747 E.01596
G1 X77.747 Y130.554 E.92071
G1 X77.747 Y130.019 E.01596
G1 X99.019 Y108.747 E.89814
G1 X98.485 Y108.747 E.01596
G1 X77.747 Y129.485 E.87558
G1 X77.747 Y128.95 E.01596
G1 X97.95 Y108.747 E.85301
G1 X97.416 Y108.747 E.01596
G1 X77.747 Y128.416 E.83044
G1 X77.747 Y127.881 E.01596
G1 X96.881 Y108.747 E.80787
G1 X96.347 Y108.747 E.01596
G1 X77.747 Y127.347 E.78531
G1 X77.747 Y126.812 E.01596
G1 X95.812 Y108.747 E.76274
G1 X95.278 Y108.747 E.01596
G1 X77.747 Y126.278 E.74017
G1 X77.747 Y125.743 E.01596
G1 X94.743 Y108.747 E.7176
G1 X94.209 Y108.747 E.01596
G1 X77.747 Y125.209 E.69503
G1 X77.747 Y124.674 E.01596
G1 X93.674 Y108.747 E.67247
G1 X93.14 Y108.747 E.01596
G1 X77.747 Y124.14 E.6499
G1 X77.747 Y123.605 E.01596
G1 X92.605 Y108.747 E.62733
M73 P59 R12
G1 X92.071 Y108.747 E.01596
G1 X77.747 Y123.071 E.60476
G1 X77.747 Y122.536 E.01596
G1 X91.536 Y108.747 E.5822
G1 X91.002 Y108.747 E.01596
G1 X77.747 Y122.002 E.55963
G1 X77.747 Y121.467 E.01596
G1 X90.467 Y108.747 E.53706
G1 X89.933 Y108.747 E.01596
G1 X77.747 Y120.933 E.51449
G1 X77.747 Y120.398 E.01596
G1 X89.398 Y108.747 E.49193
G1 X88.864 Y108.747 E.01596
G1 X77.747 Y119.864 E.46936
G1 X77.747 Y119.329 E.01596
G1 X88.329 Y108.747 E.44679
G1 X87.795 Y108.747 E.01596
G1 X77.747 Y118.795 E.42422
G1 X77.747 Y118.26 E.01596
G1 X87.26 Y108.747 E.40165
G1 X86.726 Y108.747 E.01596
G1 X77.747 Y117.726 E.37909
G1 X77.747 Y117.191 E.01596
G1 X86.191 Y108.747 E.35652
G1 X85.657 Y108.747 E.01596
G1 X77.747 Y116.657 E.33395
G1 X77.747 Y116.122 E.01596
G1 X85.122 Y108.747 E.31138
G1 X84.588 Y108.747 E.01596
G1 X77.747 Y115.588 E.28882
G1 X77.747 Y115.053 E.01596
G1 X84.053 Y108.747 E.26625
G1 X83.519 Y108.747 E.01596
G1 X77.747 Y114.519 E.24368
G1 X77.747 Y113.984 E.01596
G1 X82.984 Y108.747 E.22111
G1 X82.45 Y108.747 E.01596
G1 X77.747 Y113.45 E.19855
G1 X77.747 Y112.915 E.01596
G1 X81.915 Y108.747 E.17598
G1 X81.381 Y108.747 E.01596
G1 X77.747 Y112.381 E.15341
G1 X77.747 Y111.846 E.01596
G1 X80.846 Y108.747 E.13084
G1 X80.312 Y108.747 E.01596
G1 X77.747 Y111.312 E.10828
G1 X77.747 Y110.777 E.01596
G1 X79.777 Y108.747 E.08571
G1 X79.243 Y108.747 E.01596
G1 X77.747 Y110.243 E.06314
G1 X77.747 Y109.708 E.01596
G1 X78.708 Y108.747 E.04057
G1 X78.174 Y108.747 E.01596
G1 X77.578 Y109.343 E.02517
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X78.174 Y108.747 E-.32036
G1 X78.708 Y108.747 E-.20311
G1 X78.268 Y109.187 E-.23653
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/10
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 403
M204 S10000
G17
G3 Z1.2 I-.395 J1.151 P1  F30000
G1 X178.584 Y143.584 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X79.587 Y143.584 E3.18331
G1 X77.416 Y141.413 E.0987
G1 X77.416 Y108.416 E1.06104
G1 X178.584 Y108.416 E3.25311
G1 X178.584 Y126 E.56542
G1 X178.584 Y143.524 E.56349
M204 S10000
G1 X178.991 Y143.991 F30000
G1 F6000
M204 S3000
G1 X79.418 Y143.991 E3.20183
G1 X77.009 Y141.582 E.10954
G1 X77.009 Y108.009 E1.07956
G1 X178.991 Y108.009 E3.27928
G1 X178.991 Y126 E.57851
G1 X178.991 Y143.931 E.57658
M204 S10000
G1 X179.398 Y144.398 F30000
M73 P60 R12
G1 F6000
M204 S3000
G1 X79.249 Y144.398 E3.22034
G1 X76.602 Y141.751 E.12039
G1 X76.602 Y107.602 E1.09807
G1 X179.398 Y107.602 E3.30546
G1 X179.398 Y126 E.5916
G1 X179.398 Y144.338 E.58967
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E2.99952
G1 X76.21 Y141.913 E.12119
G1 X76.21 Y107.21 E1.03366
G1 X179.79 Y107.21 E3.08522
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

G1 X179.79 Y126 E.55968
G1 X179.79 Y144.73 E.55789
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.926 Y137.1 Z1.4 F30000
G1 X178.422 Y109.342 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42101
G1 F6000
M204 S3000
G1 X177.828 Y108.747 E.02512
G1 X177.293 Y108.747 E.01597
G1 X178.253 Y109.707 E.04054
G1 X178.253 Y110.242 E.01597
G1 X176.758 Y108.747 E.06312
G1 X176.224 Y108.747 E.01597
G1 X178.253 Y110.776 E.08571
G1 X178.253 Y111.311 E.01597
G1 X175.689 Y108.747 E.10829
G1 X175.154 Y108.747 E.01597
G1 X178.253 Y111.846 E.13088
G1 X178.253 Y112.38 E.01597
G1 X174.62 Y108.747 E.15346
G1 X174.085 Y108.747 E.01597
G1 X178.253 Y112.915 E.17604
G1 X178.253 Y113.45 E.01597
G1 X173.55 Y108.747 E.19863
G1 X173.015 Y108.747 E.01597
G1 X178.253 Y113.985 E.22121
G1 X178.253 Y114.519 E.01597
G1 X172.481 Y108.747 E.2438
G1 X171.946 Y108.747 E.01597
G1 X178.253 Y115.054 E.26638
G1 X178.253 Y115.589 E.01597
G1 X171.411 Y108.747 E.28897
G1 X170.877 Y108.747 E.01597
G1 X178.253 Y116.123 E.31155
G1 X178.253 Y116.658 E.01597
G1 X170.342 Y108.747 E.33413
G1 X169.807 Y108.747 E.01597
G1 X178.253 Y117.193 E.35672
G1 X178.253 Y117.727 E.01597
G1 X169.273 Y108.747 E.3793
G1 X168.738 Y108.747 E.01597
G1 X178.253 Y118.262 E.40189
G1 X178.253 Y118.797 E.01597
G1 X168.203 Y108.747 E.42447
G1 X167.668 Y108.747 E.01597
G1 X178.253 Y119.332 E.44706
G1 X178.253 Y119.866 E.01597
G1 X167.134 Y108.747 E.46964
G1 X166.599 Y108.747 E.01597
G1 X178.253 Y120.401 E.49223
G1 X178.253 Y120.936 E.01597
G1 X166.064 Y108.747 E.51481
G1 X165.53 Y108.747 E.01597
G1 X178.253 Y121.47 E.53739
G1 X178.253 Y122.005 E.01597
G1 X164.995 Y108.747 E.55998
G1 X164.46 Y108.747 E.01597
G1 X178.253 Y122.54 E.58256
G1 X178.253 Y123.074 E.01597
G1 X163.926 Y108.747 E.60515
G1 X163.391 Y108.747 E.01597
G1 X178.253 Y123.609 E.62773
G1 X178.253 Y124.144 E.01597
G1 X162.856 Y108.747 E.65032
G1 X162.321 Y108.747 E.01597
G1 X178.253 Y124.679 E.6729
G1 X178.253 Y125.213 E.01597
G1 X161.787 Y108.747 E.69548
M73 P60 R11
G1 X161.252 Y108.747 E.01597
G1 X178.253 Y125.748 E.71807
G1 X178.253 Y126.283 E.01597
G1 X160.717 Y108.747 E.74065
G1 X160.183 Y108.747 E.01597
G1 X178.253 Y126.817 E.76324
G1 X178.253 Y127.352 E.01597
G1 X159.648 Y108.747 E.78582
G1 X159.113 Y108.747 E.01597
G1 X178.253 Y127.887 E.80841
G1 X178.253 Y128.421 E.01597
G1 X158.579 Y108.747 E.83099
G1 X158.044 Y108.747 E.01597
G1 X178.253 Y128.956 E.85357
G1 X178.253 Y129.491 E.01597
G1 X157.509 Y108.747 E.87616
M73 C9
G1 X156.974 Y108.747 E.01597
G1 X178.253 Y130.026 E.89874
G1 X178.253 Y130.56 E.01597
G1 X156.44 Y108.747 E.92133
G1 X155.905 Y108.747 E.01597
G1 X178.253 Y131.095 E.94391
G1 X178.253 Y131.63 E.01597
G1 X155.37 Y108.747 E.9665
G1 X154.836 Y108.747 E.01597
G1 X178.253 Y132.164 E.98908
M73 P61 R11
G1 X178.253 Y132.699 E.01597
G1 X154.301 Y108.747 E1.01167
G1 X153.766 Y108.747 E.01597
G1 X178.253 Y133.234 E1.03425
G1 X178.253 Y133.768 E.01597
G1 X153.232 Y108.747 E1.05683
G1 X152.697 Y108.747 E.01597
G1 X178.253 Y134.303 E1.07942
G1 X178.253 Y134.838 E.01597
G1 X152.162 Y108.747 E1.102
G1 X151.627 Y108.747 E.01597
G1 X178.253 Y135.373 E1.12459
G1 X178.253 Y135.907 E.01597
G1 X151.093 Y108.747 E1.14717
G1 X150.558 Y108.747 E.01597
G1 X178.253 Y136.442 E1.16976
G1 X178.253 Y136.977 E.01597
G1 X150.023 Y108.747 E1.19234
G1 X149.489 Y108.747 E.01597
G1 X178.253 Y137.511 E1.21492
G1 X178.253 Y138.046 E.01597
G1 X148.954 Y108.747 E1.23751
G1 X148.419 Y108.747 E.01597
G1 X178.253 Y138.581 E1.26009
G1 X178.253 Y139.115 E.01597
G1 X147.885 Y108.747 E1.28268
G1 X147.35 Y108.747 E.01597
G1 X178.253 Y139.65 E1.30526
G1 X178.253 Y140.185 E.01597
G1 X146.815 Y108.747 E1.32785
G1 X146.28 Y108.747 E.01597
G1 X178.253 Y140.72 E1.35043
G1 X178.253 Y141.254 E.01597
G1 X145.746 Y108.747 E1.37302
G1 X145.211 Y108.747 E.01597
G1 X178.253 Y141.789 E1.3956
G1 X178.253 Y142.324 E.01597
G1 X144.676 Y108.747 E1.41818
G1 X144.142 Y108.747 E.01597
G1 X178.253 Y142.858 E1.44077
G1 X178.253 Y143.253 E.01178
G1 X178.113 Y143.253 E.00419
G1 X143.607 Y108.747 E1.45743
G1 X143.072 Y108.747 E.01597
G1 X177.578 Y143.253 E1.45743
G1 X177.043 Y143.253 E.01597
G1 X142.538 Y108.747 E1.45743
G1 X142.003 Y108.747 E.01597
G1 X176.508 Y143.253 E1.45743
G1 X175.974 Y143.253 E.01597
G1 X141.468 Y108.747 E1.45743
G1 X140.933 Y108.747 E.01597
G1 X175.439 Y143.253 E1.45743
G1 X174.904 Y143.253 E.01597
G1 X140.399 Y108.747 E1.45743
G1 X139.864 Y108.747 E.01597
G1 X174.37 Y143.253 E1.45743
G1 X173.835 Y143.253 E.01597
G1 X139.329 Y108.747 E1.45743
G1 X138.795 Y108.747 E.01597
G1 X173.3 Y143.253 E1.45743
G1 X172.766 Y143.253 E.01597
G1 X138.26 Y108.747 E1.45743
G1 X137.725 Y108.747 E.01597
G1 X172.231 Y143.253 E1.45743
G1 X171.696 Y143.253 E.01597
G1 X137.191 Y108.747 E1.45743
G1 X136.656 Y108.747 E.01597
G1 X171.161 Y143.253 E1.45743
G1 X170.627 Y143.253 E.01597
G1 X136.121 Y108.747 E1.45743
G1 X135.586 Y108.747 E.01597
G1 X170.092 Y143.253 E1.45743
G1 X169.557 Y143.253 E.01597
G1 X135.052 Y108.747 E1.45743
G1 X134.517 Y108.747 E.01597
G1 X169.023 Y143.253 E1.45743
G1 X168.488 Y143.253 E.01597
G1 X133.982 Y108.747 E1.45743
G1 X133.448 Y108.747 E.01597
G1 X167.953 Y143.253 E1.45743
G1 X167.419 Y143.253 E.01597
G1 X132.913 Y108.747 E1.45743
G1 X132.378 Y108.747 E.01597
G1 X166.884 Y143.253 E1.45743
G1 X166.349 Y143.253 E.01597
G1 X131.844 Y108.747 E1.45743
G1 X131.309 Y108.747 E.01597
G1 X165.814 Y143.253 E1.45743
G1 X165.28 Y143.253 E.01597
G1 X130.774 Y108.747 E1.45743
G1 X130.239 Y108.747 E.01597
G1 X164.745 Y143.253 E1.45743
G1 X164.21 Y143.253 E.01597
G1 X129.705 Y108.747 E1.45743
G1 X129.17 Y108.747 E.01597
G1 X163.676 Y143.253 E1.45743
G1 X163.141 Y143.253 E.01597
G1 X128.635 Y108.747 E1.45743
G1 X128.101 Y108.747 E.01597
G1 X162.606 Y143.253 E1.45743
G1 X162.072 Y143.253 E.01597
G1 X127.566 Y108.747 E1.45743
G1 X127.031 Y108.747 E.01597
G1 X161.537 Y143.253 E1.45743
G1 X161.002 Y143.253 E.01597
G1 X126.497 Y108.747 E1.45743
G1 X125.962 Y108.747 E.01597
G1 X160.467 Y143.253 E1.45743
G1 X159.933 Y143.253 E.01597
G1 X125.427 Y108.747 E1.45743
G1 X124.892 Y108.747 E.01597
G1 X159.398 Y143.253 E1.45743
G1 X158.863 Y143.253 E.01597
G1 X124.358 Y108.747 E1.45743
G1 X123.823 Y108.747 E.01597
G1 X158.329 Y143.253 E1.45743
G1 X157.794 Y143.253 E.01597
G1 X123.288 Y108.747 E1.45743
G1 X122.754 Y108.747 E.01597
G1 X157.259 Y143.253 E1.45743
G1 X156.725 Y143.253 E.01597
G1 X122.219 Y108.747 E1.45743
G1 X121.684 Y108.747 E.01597
G1 X156.19 Y143.253 E1.45743
M73 P62 R11
G1 X155.655 Y143.253 E.01597
G1 X121.15 Y108.747 E1.45743
G1 X120.615 Y108.747 E.01597
G1 X155.12 Y143.253 E1.45743
G1 X154.586 Y143.253 E.01597
G1 X120.08 Y108.747 E1.45743
G1 X119.545 Y108.747 E.01597
G1 X154.051 Y143.253 E1.45743
G1 X153.516 Y143.253 E.01597
G1 X119.011 Y108.747 E1.45743
G1 X118.476 Y108.747 E.01597
G1 X152.982 Y143.253 E1.45743
G1 X152.447 Y143.253 E.01597
G1 X117.941 Y108.747 E1.45743
G1 X117.407 Y108.747 E.01597
G1 X151.912 Y143.253 E1.45743
G1 X151.378 Y143.253 E.01597
G1 X116.872 Y108.747 E1.45743
G1 X116.337 Y108.747 E.01597
G1 X150.843 Y143.253 E1.45743
G1 X150.308 Y143.253 E.01597
G1 X115.803 Y108.747 E1.45743
G1 X115.268 Y108.747 E.01597
G1 X149.773 Y143.253 E1.45743
G1 X149.239 Y143.253 E.01597
G1 X114.733 Y108.747 E1.45743
G1 X114.198 Y108.747 E.01597
G1 X148.704 Y143.253 E1.45743
G1 X148.169 Y143.253 E.01597
G1 X113.664 Y108.747 E1.45743
G1 X113.129 Y108.747 E.01597
G1 X147.635 Y143.253 E1.45743
G1 X147.1 Y143.253 E.01597
G1 X112.594 Y108.747 E1.45743
G1 X112.06 Y108.747 E.01597
G1 X146.565 Y143.253 E1.45743
G1 X146.031 Y143.253 E.01597
G1 X111.525 Y108.747 E1.45743
G1 X110.99 Y108.747 E.01597
G1 X145.496 Y143.253 E1.45743
G1 X144.961 Y143.253 E.01597
G1 X110.456 Y108.747 E1.45743
G1 X109.921 Y108.747 E.01597
G1 X144.426 Y143.253 E1.45743
G1 X143.892 Y143.253 E.01597
G1 X109.386 Y108.747 E1.45743
G1 X108.851 Y108.747 E.01597
G1 X143.357 Y143.253 E1.45743
G1 X142.822 Y143.253 E.01597
G1 X108.317 Y108.747 E1.45743
G1 X107.782 Y108.747 E.01597
G1 X142.288 Y143.253 E1.45743
G1 X141.753 Y143.253 E.01597
G1 X107.247 Y108.747 E1.45743
G1 X106.713 Y108.747 E.01597
G1 X141.218 Y143.253 E1.45743
G1 X140.684 Y143.253 E.01597
G1 X106.178 Y108.747 E1.45743
G1 X105.643 Y108.747 E.01597
G1 X140.149 Y143.253 E1.45743
G1 X139.614 Y143.253 E.01597
G1 X105.109 Y108.747 E1.45743
G1 X104.574 Y108.747 E.01597
G1 X139.079 Y143.253 E1.45743
G1 X138.545 Y143.253 E.01597
G1 X104.039 Y108.747 E1.45743
G1 X103.504 Y108.747 E.01597
G1 X138.01 Y143.253 E1.45743
G1 X137.475 Y143.253 E.01597
G1 X102.97 Y108.747 E1.45743
G1 X102.435 Y108.747 E.01597
M73 P63 R11
G1 X136.941 Y143.253 E1.45743
G1 X136.406 Y143.253 E.01597
G1 X101.9 Y108.747 E1.45743
G1 X101.366 Y108.747 E.01597
G1 X135.871 Y143.253 E1.45743
G1 X135.337 Y143.253 E.01597
G1 X100.831 Y108.747 E1.45743
G1 X100.296 Y108.747 E.01597
G1 X134.802 Y143.253 E1.45743
G1 X134.267 Y143.253 E.01597
G1 X99.762 Y108.747 E1.45743
G1 X99.227 Y108.747 E.01597
G1 X133.732 Y143.253 E1.45743
G1 X133.198 Y143.253 E.01597
G1 X98.692 Y108.747 E1.45743
G1 X98.157 Y108.747 E.01597
G1 X132.663 Y143.253 E1.45743
G1 X132.128 Y143.253 E.01597
G1 X97.623 Y108.747 E1.45743
G1 X97.088 Y108.747 E.01597
G1 X131.594 Y143.253 E1.45743
G1 X131.059 Y143.253 E.01597
G1 X96.553 Y108.747 E1.45743
G1 X96.019 Y108.747 E.01597
G1 X130.524 Y143.253 E1.45743
G1 X129.99 Y143.253 E.01597
G1 X95.484 Y108.747 E1.45743
G1 X94.949 Y108.747 E.01597
G1 X129.455 Y143.253 E1.45743
G1 X128.92 Y143.253 E.01597
G1 X94.415 Y108.747 E1.45743
G1 X93.88 Y108.747 E.01597
G1 X128.385 Y143.253 E1.45743
G1 X127.851 Y143.253 E.01597
G1 X93.345 Y108.747 E1.45743
G1 X92.81 Y108.747 E.01597
G1 X127.316 Y143.253 E1.45743
G1 X126.781 Y143.253 E.01597
G1 X92.276 Y108.747 E1.45743
G1 X91.741 Y108.747 E.01597
G1 X126.247 Y143.253 E1.45743
G1 X125.712 Y143.253 E.01597
G1 X91.206 Y108.747 E1.45743
G1 X90.672 Y108.747 E.01597
G1 X125.177 Y143.253 E1.45743
G1 X124.643 Y143.253 E.01597
G1 X90.137 Y108.747 E1.45743
G1 X89.602 Y108.747 E.01597
M73 P63 R10
G1 X124.108 Y143.253 E1.45743
G1 X123.573 Y143.253 E.01597
G1 X89.068 Y108.747 E1.45743
G1 X88.533 Y108.747 E.01597
G1 X123.038 Y143.253 E1.45743
G1 X122.504 Y143.253 E.01597
G1 X87.998 Y108.747 E1.45743
G1 X87.463 Y108.747 E.01597
G1 X121.969 Y143.253 E1.45743
G1 X121.434 Y143.253 E.01597
G1 X86.929 Y108.747 E1.45743
G1 X86.394 Y108.747 E.01597
G1 X120.9 Y143.253 E1.45743
G1 X120.365 Y143.253 E.01597
G1 X85.859 Y108.747 E1.45743
G1 X85.325 Y108.747 E.01597
G1 X119.83 Y143.253 E1.45743
G1 X119.296 Y143.253 E.01597
G1 X84.79 Y108.747 E1.45743
M73 P64 R10
G1 X84.255 Y108.747 E.01597
M73 C8
G1 X118.761 Y143.253 E1.45743
G1 X118.226 Y143.253 E.01597
G1 X83.721 Y108.747 E1.45743
G1 X83.186 Y108.747 E.01597
G1 X117.691 Y143.253 E1.45743
G1 X117.157 Y143.253 E.01597
G1 X82.651 Y108.747 E1.45743
G1 X82.116 Y108.747 E.01597
G1 X116.622 Y143.253 E1.45743
G1 X116.087 Y143.253 E.01597
G1 X81.582 Y108.747 E1.45743
G1 X81.047 Y108.747 E.01597
G1 X115.553 Y143.253 E1.45743
G1 X115.018 Y143.253 E.01597
G1 X80.512 Y108.747 E1.45743
G1 X79.978 Y108.747 E.01597
G1 X114.483 Y143.253 E1.45743
G1 X113.949 Y143.253 E.01597
G1 X79.443 Y108.747 E1.45743
G1 X78.908 Y108.747 E.01597
G1 X113.414 Y143.253 E1.45743
G1 X112.879 Y143.253 E.01597
G1 X78.374 Y108.747 E1.45743
G1 X77.839 Y108.747 E.01597
G1 X112.344 Y143.253 E1.45743
G1 X111.81 Y143.253 E.01597
G1 X77.747 Y109.19 E1.43872
G1 X77.747 Y109.725 E.01597
G1 X111.275 Y143.253 E1.41613
G1 X110.74 Y143.253 E.01597
G1 X77.747 Y110.26 E1.39355
G1 X77.747 Y110.794 E.01597
G1 X110.206 Y143.253 E1.37096
G1 X109.671 Y143.253 E.01597
G1 X77.747 Y111.329 E1.34838
G1 X77.747 Y111.864 E.01597
G1 X109.136 Y143.253 E1.32579
G1 X108.602 Y143.253 E.01597
G1 X77.747 Y112.398 E1.30321
G1 X77.747 Y112.933 E.01597
G1 X108.067 Y143.253 E1.28063
G1 X107.532 Y143.253 E.01597
G1 X77.747 Y113.468 E1.25804
G1 X77.747 Y114.003 E.01597
G1 X106.997 Y143.253 E1.23546
G1 X106.463 Y143.253 E.01597
G1 X77.747 Y114.537 E1.21287
G1 X77.747 Y115.072 E.01597
G1 X105.928 Y143.253 E1.19029
G1 X105.393 Y143.253 E.01597
G1 X77.747 Y115.607 E1.1677
G1 X77.747 Y116.141 E.01597
G1 X104.859 Y143.253 E1.14512
G1 X104.324 Y143.253 E.01597
G1 X77.747 Y116.676 E1.12253
G1 X77.747 Y117.211 E.01597
G1 X103.789 Y143.253 E1.09995
G1 X103.255 Y143.253 E.01597
G1 X77.747 Y117.745 E1.07737
G1 X77.747 Y118.28 E.01597
G1 X102.72 Y143.253 E1.05478
G1 X102.185 Y143.253 E.01597
G1 X77.747 Y118.815 E1.0322
G1 X77.747 Y119.35 E.01597
G1 X101.65 Y143.253 E1.00961
G1 X101.116 Y143.253 E.01597
M73 P65 R10
G1 X77.747 Y119.884 E.98703
G1 X77.747 Y120.419 E.01597
G1 X100.581 Y143.253 E.96444
G1 X100.046 Y143.253 E.01597
G1 X77.747 Y120.954 E.94186
G1 X77.747 Y121.488 E.01597
G1 X99.512 Y143.253 E.91928
G1 X98.977 Y143.253 E.01597
G1 X77.747 Y122.023 E.89669
G1 X77.747 Y122.558 E.01597
G1 X98.442 Y143.253 E.87411
G1 X97.908 Y143.253 E.01597
G1 X77.747 Y123.092 E.85152
G1 X77.747 Y123.627 E.01597
G1 X97.373 Y143.253 E.82894
G1 X96.838 Y143.253 E.01597
G1 X77.747 Y124.162 E.80635
G1 X77.747 Y124.697 E.01597
G1 X96.303 Y143.253 E.78377
G1 X95.769 Y143.253 E.01597
G1 X77.747 Y125.231 E.76118
G1 X77.747 Y125.766 E.01597
G1 X95.234 Y143.253 E.7386
G1 X94.699 Y143.253 E.01597
G1 X77.747 Y126.301 E.71602
G1 X77.747 Y126.835 E.01597
G1 X94.165 Y143.253 E.69343
G1 X93.63 Y143.253 E.01597
G1 X77.747 Y127.37 E.67085
G1 X77.747 Y127.905 E.01597
G1 X93.095 Y143.253 E.64826
G1 X92.561 Y143.253 E.01597
G1 X77.747 Y128.439 E.62568
G1 X77.747 Y128.974 E.01597
G1 X92.026 Y143.253 E.60309
G1 X91.491 Y143.253 E.01597
G1 X77.747 Y129.509 E.58051
G1 X77.747 Y130.044 E.01597
G1 X90.956 Y143.253 E.55793
G1 X90.422 Y143.253 E.01597
G1 X77.747 Y130.578 E.53534
G1 X77.747 Y131.113 E.01597
G1 X89.887 Y143.253 E.51276
G1 X89.352 Y143.253 E.01597
G1 X77.747 Y131.648 E.49017
G1 X77.747 Y132.182 E.01597
G1 X88.818 Y143.253 E.46759
G1 X88.283 Y143.253 E.01597
G1 X77.747 Y132.717 E.445
G1 X77.747 Y133.252 E.01597
G1 X87.748 Y143.253 E.42242
G1 X87.214 Y143.253 E.01597
G1 X77.747 Y133.786 E.39983
G1 X77.747 Y134.321 E.01597
G1 X86.679 Y143.253 E.37725
G1 X86.144 Y143.253 E.01597
G1 X77.747 Y134.856 E.35467
G1 X77.747 Y135.391 E.01597
G1 X85.609 Y143.253 E.33208
G1 X85.075 Y143.253 E.01597
G1 X77.747 Y135.925 E.3095
G1 X77.747 Y136.46 E.01597
G1 X84.54 Y143.253 E.28691
G1 X84.005 Y143.253 E.01597
G1 X77.747 Y136.995 E.26433
G1 X77.747 Y137.529 E.01597
G1 X83.471 Y143.253 E.24174
G1 X82.936 Y143.253 E.01597
G1 X77.747 Y138.064 E.21916
G1 X77.747 Y138.599 E.01597
M73 P66 R10
G1 X82.401 Y143.253 E.19658
G1 X81.867 Y143.253 E.01597
G1 X77.747 Y139.133 E.17399
G1 X77.747 Y139.668 E.01597
G1 X81.332 Y143.253 E.15141
G1 X80.797 Y143.253 E.01597
G1 X77.747 Y140.203 E.12882
G1 X77.747 Y140.738 E.01597
G1 X80.262 Y143.253 E.10624
G1 X79.728 Y143.253 E.01597
G1 X77.578 Y141.103 E.09082
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X78.992 Y142.517 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/10
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 403
M204 S10000
G17
G3 Z1.4 I-.013 J1.217 P1  F30000
G1 X178.584 Y143.584 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X79.587 Y143.584 E3.18331
G1 X77.416 Y141.413 E.0987
G1 X77.416 Y108.416 E1.06104
G1 X178.584 Y108.416 E3.25311
G1 X178.584 Y126 E.56542
G1 X178.584 Y143.524 E.56349
M204 S10000
G1 X178.991 Y143.991 F30000
G1 F6000
M204 S3000
G1 X79.418 Y143.991 E3.20183
G1 X77.009 Y141.582 E.10954
G1 X77.009 Y108.009 E1.07956
G1 X178.991 Y108.009 E3.27928
G1 X178.991 Y126 E.57851
G1 X178.991 Y143.931 E.57658
M204 S10000
G1 X179.398 Y144.398 F30000
G1 F6000
M204 S3000
G1 X79.249 Y144.398 E3.22034
G1 X76.602 Y141.751 E.12039
G1 X76.602 Y107.602 E1.09807
G1 X179.398 Y107.602 E3.30546
G1 X179.398 Y126 E.5916
G1 X179.398 Y144.338 E.58967
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E2.99952
G1 X76.21 Y141.913 E.12119
G1 X76.21 Y107.21 E1.03366
G1 X179.79 Y107.21 E3.08522
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

G1 X179.79 Y126 E.55968
G1 X179.79 Y144.73 E.55789
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.658 Y143.422 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F6000
M204 S3000
G1 X178.253 Y142.828 E.0251
G1 X178.253 Y142.294 E.01596
G1 X177.294 Y143.253 E.0405
G1 X176.759 Y143.253 E.01596
G1 X178.253 Y141.759 E.06307
G1 X178.253 Y141.225 E.01596
G1 X176.225 Y143.253 E.08564
G1 X175.69 Y143.253 E.01596
G1 X178.253 Y140.69 E.1082
G1 X178.253 Y140.156 E.01596
G1 X175.156 Y143.253 E.13077
G1 X174.621 Y143.253 E.01596
G1 X178.253 Y139.621 E.15334
G1 X178.253 Y139.087 E.01596
G1 X174.087 Y143.253 E.17591
G1 X173.552 Y143.253 E.01596
G1 X178.253 Y138.552 E.19848
G1 X178.253 Y138.018 E.01596
G1 X173.018 Y143.253 E.22104
G1 X172.483 Y143.253 E.01596
G1 X178.253 Y137.483 E.24361
G1 X178.253 Y136.949 E.01596
G1 X171.949 Y143.253 E.26618
G1 X171.414 Y143.253 E.01596
G1 X178.253 Y136.414 E.28875
G1 X178.253 Y135.88 E.01596
G1 X170.88 Y143.253 E.31131
G1 X170.345 Y143.253 E.01596
G1 X178.253 Y135.345 E.33388
G1 X178.253 Y134.811 E.01596
G1 X169.811 Y143.253 E.35645
G1 X169.276 Y143.253 E.01596
G1 X178.253 Y134.276 E.37902
G1 X178.253 Y133.742 E.01596
G1 X168.742 Y143.253 E.40158
G1 X168.207 Y143.253 E.01596
G1 X178.253 Y133.207 E.42415
G1 X178.253 Y132.673 E.01596
G1 X167.673 Y143.253 E.44672
G1 X167.138 Y143.253 E.01596
G1 X178.253 Y132.138 E.46929
G1 X178.253 Y131.604 E.01596
G1 X166.603 Y143.253 E.49185
G1 X166.069 Y143.253 E.01596
G1 X178.253 Y131.069 E.51442
G1 X178.253 Y130.535 E.01596
G1 X165.534 Y143.253 E.53699
G1 X165 Y143.253 E.01596
G1 X178.253 Y130 E.55956
G1 X178.253 Y129.466 E.01596
G1 X164.465 Y143.253 E.58213
G1 X163.931 Y143.253 E.01596
G1 X178.253 Y128.931 E.60469
G1 X178.253 Y128.396 E.01596
G1 X163.396 Y143.253 E.62726
G1 X162.862 Y143.253 E.01596
G1 X178.253 Y127.862 E.64983
G1 X178.253 Y127.327 E.01596
G1 X162.327 Y143.253 E.6724
G1 X161.793 Y143.253 E.01596
G1 X178.253 Y126.793 E.69496
G1 X178.253 Y126.258 E.01596
G1 X161.258 Y143.253 E.71753
G1 X160.724 Y143.253 E.01596
G1 X178.253 Y125.724 E.7401
G1 X178.253 Y125.189 E.01596
M73 P67 R10
G1 X160.189 Y143.253 E.76267
M73 P67 R9
G1 X159.655 Y143.253 E.01596
G1 X178.253 Y124.655 E.78523
G1 X178.253 Y124.12 E.01596
G1 X159.12 Y143.253 E.8078
G1 X158.586 Y143.253 E.01596
G1 X178.253 Y123.586 E.83037
G1 X178.253 Y123.051 E.01596
G1 X158.051 Y143.253 E.85294
G1 X157.517 Y143.253 E.01596
G1 X178.253 Y122.517 E.8755
G1 X178.253 Y121.982 E.01596
G1 X156.982 Y143.253 E.89807
G1 X156.448 Y143.253 E.01596
G1 X178.253 Y121.448 E.92064
G1 X178.253 Y120.913 E.01596
M73 C7
G1 X155.913 Y143.253 E.94321
G1 X155.379 Y143.253 E.01596
G1 X178.253 Y120.379 E.96578
G1 X178.253 Y119.844 E.01596
G1 X154.844 Y143.253 E.98834
G1 X154.31 Y143.253 E.01596
G1 X178.253 Y119.31 E1.01091
G1 X178.253 Y118.775 E.01596
G1 X153.775 Y143.253 E1.03348
G1 X153.241 Y143.253 E.01596
G1 X178.253 Y118.241 E1.05605
G1 X178.253 Y117.706 E.01596
G1 X152.706 Y143.253 E1.07861
G1 X152.172 Y143.253 E.01596
G1 X178.253 Y117.172 E1.10118
G1 X178.253 Y116.637 E.01596
G1 X151.637 Y143.253 E1.12375
G1 X151.103 Y143.253 E.01596
G1 X178.253 Y116.103 E1.14632
G1 X178.253 Y115.568 E.01596
G1 X150.568 Y143.253 E1.16888
G1 X150.034 Y143.253 E.01596
G1 X178.253 Y115.034 E1.19145
G1 X178.253 Y114.499 E.01596
G1 X149.499 Y143.253 E1.21402
G1 X148.965 Y143.253 E.01596
G1 X178.253 Y113.965 E1.23659
G1 X178.253 Y113.43 E.01596
G1 X148.43 Y143.253 E1.25915
G1 X147.896 Y143.253 E.01596
G1 X178.253 Y112.896 E1.28172
G1 X178.253 Y112.361 E.01596
G1 X147.361 Y143.253 E1.30429
G1 X146.827 Y143.253 E.01596
G1 X178.253 Y111.827 E1.32686
G1 X178.253 Y111.292 E.01596
G1 X146.292 Y143.253 E1.34943
G1 X145.758 Y143.253 E.01596
G1 X178.253 Y110.758 E1.37199
G1 X178.253 Y110.223 E.01596
G1 X145.223 Y143.253 E1.39456
G1 X144.689 Y143.253 E.01596
G1 X178.253 Y109.689 E1.41713
G1 X178.253 Y109.154 E.01596
G1 X144.154 Y143.253 E1.4397
G1 X143.62 Y143.253 E.01596
G1 X178.126 Y108.747 E1.45689
G1 X177.591 Y108.747 E.01596
G1 X143.085 Y143.253 E1.45689
G1 X142.551 Y143.253 E.01596
G1 X177.057 Y108.747 E1.45689
G1 X176.522 Y108.747 E.01596
G1 X142.016 Y143.253 E1.45689
G1 X141.482 Y143.253 E.01596
G1 X175.988 Y108.747 E1.45689
G1 X175.453 Y108.747 E.01596
G1 X140.947 Y143.253 E1.45689
G1 X140.413 Y143.253 E.01596
G1 X174.919 Y108.747 E1.45689
G1 X174.384 Y108.747 E.01596
G1 X139.878 Y143.253 E1.45689
G1 X139.344 Y143.253 E.01596
G1 X173.85 Y108.747 E1.45689
G1 X173.315 Y108.747 E.01596
G1 X138.809 Y143.253 E1.45689
G1 X138.275 Y143.253 E.01596
G1 X172.78 Y108.747 E1.45689
G1 X172.246 Y108.747 E.01596
G1 X137.74 Y143.253 E1.45689
G1 X137.206 Y143.253 E.01596
G1 X171.711 Y108.747 E1.45689
G1 X171.177 Y108.747 E.01596
G1 X136.671 Y143.253 E1.45689
G1 X136.137 Y143.253 E.01596
G1 X170.642 Y108.747 E1.45689
G1 X170.108 Y108.747 E.01596
G1 X135.602 Y143.253 E1.45689
G1 X135.068 Y143.253 E.01596
G1 X169.573 Y108.747 E1.45689
G1 X169.039 Y108.747 E.01596
G1 X134.533 Y143.253 E1.45689
G1 X133.999 Y143.253 E.01596
G1 X168.504 Y108.747 E1.45689
G1 X167.97 Y108.747 E.01596
G1 X133.464 Y143.253 E1.45689
G1 X132.93 Y143.253 E.01596
G1 X167.435 Y108.747 E1.45689
G1 X166.901 Y108.747 E.01596
G1 X132.395 Y143.253 E1.45689
G1 X131.861 Y143.253 E.01596
M73 P68 R9
G1 X166.366 Y108.747 E1.45689
G1 X165.832 Y108.747 E.01596
G1 X131.326 Y143.253 E1.45689
G1 X130.792 Y143.253 E.01596
G1 X165.297 Y108.747 E1.45689
G1 X164.763 Y108.747 E.01596
G1 X130.257 Y143.253 E1.45689
G1 X129.723 Y143.253 E.01596
G1 X164.228 Y108.747 E1.45689
G1 X163.694 Y108.747 E.01596
G1 X129.188 Y143.253 E1.45689
G1 X128.654 Y143.253 E.01596
G1 X163.159 Y108.747 E1.45689
G1 X162.625 Y108.747 E.01596
G1 X128.119 Y143.253 E1.45689
G1 X127.585 Y143.253 E.01596
G1 X162.09 Y108.747 E1.45689
G1 X161.556 Y108.747 E.01596
G1 X127.05 Y143.253 E1.45689
G1 X126.516 Y143.253 E.01596
G1 X161.021 Y108.747 E1.45689
G1 X160.487 Y108.747 E.01596
G1 X125.981 Y143.253 E1.45689
G1 X125.447 Y143.253 E.01596
G1 X159.952 Y108.747 E1.45689
G1 X159.418 Y108.747 E.01596
G1 X124.912 Y143.253 E1.45689
G1 X124.378 Y143.253 E.01596
G1 X158.883 Y108.747 E1.45689
G1 X158.349 Y108.747 E.01596
G1 X123.843 Y143.253 E1.45689
G1 X123.309 Y143.253 E.01596
G1 X157.814 Y108.747 E1.45689
G1 X157.28 Y108.747 E.01596
G1 X122.774 Y143.253 E1.45689
G1 X122.24 Y143.253 E.01596
G1 X156.745 Y108.747 E1.45689
G1 X156.211 Y108.747 E.01596
G1 X121.705 Y143.253 E1.45689
G1 X121.171 Y143.253 E.01596
G1 X155.676 Y108.747 E1.45689
G1 X155.142 Y108.747 E.01596
G1 X120.636 Y143.253 E1.45689
G1 X120.102 Y143.253 E.01596
G1 X154.607 Y108.747 E1.45689
G1 X154.073 Y108.747 E.01596
G1 X119.567 Y143.253 E1.45689
G1 X119.033 Y143.253 E.01596
G1 X153.538 Y108.747 E1.45689
G1 X153.004 Y108.747 E.01596
G1 X118.498 Y143.253 E1.45689
G1 X117.964 Y143.253 E.01596
G1 X152.469 Y108.747 E1.45689
G1 X151.935 Y108.747 E.01596
G1 X117.429 Y143.253 E1.45689
G1 X116.895 Y143.253 E.01596
G1 X151.4 Y108.747 E1.45689
G1 X150.866 Y108.747 E.01596
G1 X116.36 Y143.253 E1.45689
G1 X115.826 Y143.253 E.01596
G1 X150.331 Y108.747 E1.45689
G1 X149.797 Y108.747 E.01596
G1 X115.291 Y143.253 E1.45689
G1 X114.757 Y143.253 E.01596
G1 X149.262 Y108.747 E1.45689
G1 X148.728 Y108.747 E.01596
G1 X114.222 Y143.253 E1.45689
G1 X113.688 Y143.253 E.01596
G1 X148.193 Y108.747 E1.45689
G1 X147.659 Y108.747 E.01596
G1 X113.153 Y143.253 E1.45689
G1 X112.619 Y143.253 E.01596
G1 X147.124 Y108.747 E1.45689
G1 X146.59 Y108.747 E.01596
G1 X112.084 Y143.253 E1.45689
G1 X111.55 Y143.253 E.01596
G1 X146.055 Y108.747 E1.45689
G1 X145.521 Y108.747 E.01596
M73 P69 R9
G1 X111.015 Y143.253 E1.45689
G1 X110.481 Y143.253 E.01596
G1 X144.986 Y108.747 E1.45689
G1 X144.452 Y108.747 E.01596
G1 X109.946 Y143.253 E1.45689
G1 X109.412 Y143.253 E.01596
G1 X143.917 Y108.747 E1.45689
G1 X143.383 Y108.747 E.01596
G1 X108.877 Y143.253 E1.45689
G1 X108.343 Y143.253 E.01596
G1 X142.848 Y108.747 E1.45689
G1 X142.314 Y108.747 E.01596
G1 X107.808 Y143.253 E1.45689
G1 X107.274 Y143.253 E.01596
G1 X141.779 Y108.747 E1.45689
G1 X141.245 Y108.747 E.01596
G1 X106.739 Y143.253 E1.45689
G1 X106.205 Y143.253 E.01596
G1 X140.71 Y108.747 E1.45689
G1 X140.176 Y108.747 E.01596
G1 X105.67 Y143.253 E1.45689
G1 X105.136 Y143.253 E.01596
G1 X139.641 Y108.747 E1.45689
G1 X139.107 Y108.747 E.01596
G1 X104.601 Y143.253 E1.45689
G1 X104.067 Y143.253 E.01596
G1 X138.572 Y108.747 E1.45689
G1 X138.038 Y108.747 E.01596
G1 X103.532 Y143.253 E1.45689
G1 X102.998 Y143.253 E.01596
G1 X137.503 Y108.747 E1.45689
G1 X136.969 Y108.747 E.01596
G1 X102.463 Y143.253 E1.45689
G1 X101.929 Y143.253 E.01596
G1 X136.434 Y108.747 E1.45689
G1 X135.9 Y108.747 E.01596
G1 X101.394 Y143.253 E1.45689
G1 X100.86 Y143.253 E.01596
G1 X135.365 Y108.747 E1.45689
G1 X134.831 Y108.747 E.01596
G1 X100.325 Y143.253 E1.45689
G1 X99.791 Y143.253 E.01596
G1 X134.296 Y108.747 E1.45689
G1 X133.762 Y108.747 E.01596
G1 X99.256 Y143.253 E1.45689
G1 X98.722 Y143.253 E.01596
G1 X133.227 Y108.747 E1.45689
G1 X132.693 Y108.747 E.01596
G1 X98.187 Y143.253 E1.45689
G1 X97.653 Y143.253 E.01596
G1 X132.158 Y108.747 E1.45689
G1 X131.624 Y108.747 E.01596
G1 X97.118 Y143.253 E1.45689
G1 X96.584 Y143.253 E.01596
G1 X131.089 Y108.747 E1.45689
G1 X130.555 Y108.747 E.01596
G1 X96.049 Y143.253 E1.45689
G1 X95.515 Y143.253 E.01596
G1 X130.02 Y108.747 E1.45689
G1 X129.486 Y108.747 E.01596
G1 X94.98 Y143.253 E1.45689
G1 X94.446 Y143.253 E.01596
G1 X128.951 Y108.747 E1.45689
G1 X128.417 Y108.747 E.01596
G1 X93.911 Y143.253 E1.45689
G1 X93.377 Y143.253 E.01596
G1 X127.882 Y108.747 E1.45689
G1 X127.348 Y108.747 E.01596
M73 P70 R9
G1 X92.842 Y143.253 E1.45689
G1 X92.308 Y143.253 E.01596
G1 X126.813 Y108.747 E1.45689
G1 X126.279 Y108.747 E.01596
G1 X91.773 Y143.253 E1.45689
G1 X91.239 Y143.253 E.01596
G1 X125.744 Y108.747 E1.45689
G1 X125.21 Y108.747 E.01596
G1 X90.704 Y143.253 E1.45689
G1 X90.17 Y143.253 E.01596
G1 X124.675 Y108.747 E1.45689
G1 X124.141 Y108.747 E.01596
G1 X89.635 Y143.253 E1.45689
G1 X89.101 Y143.253 E.01596
G1 X123.606 Y108.747 E1.45689
G1 X123.072 Y108.747 E.01596
G1 X88.566 Y143.253 E1.45689
G1 X88.032 Y143.253 E.01596
G1 X122.537 Y108.747 E1.45689
G1 X122.003 Y108.747 E.01596
G1 X87.497 Y143.253 E1.45689
G1 X86.963 Y143.253 E.01596
M73 P70 R8
G1 X121.468 Y108.747 E1.45689
G1 X120.934 Y108.747 E.01596
G1 X86.428 Y143.253 E1.45689
G1 X85.894 Y143.253 E.01596
G1 X120.399 Y108.747 E1.45689
G1 X119.865 Y108.747 E.01596
G1 X85.359 Y143.253 E1.45689
G1 X84.825 Y143.253 E.01596
G1 X119.33 Y108.747 E1.45689
G1 X118.796 Y108.747 E.01596
G1 X84.29 Y143.253 E1.45689
G1 X83.756 Y143.253 E.01596
G1 X118.261 Y108.747 E1.45689
G1 X117.727 Y108.747 E.01596
G1 X83.221 Y143.253 E1.45689
G1 X82.687 Y143.253 E.01596
G1 X117.192 Y108.747 E1.45689
G1 X116.658 Y108.747 E.01596
G1 X82.152 Y143.253 E1.45689
G1 X81.618 Y143.253 E.01596
M73 C6
G1 X116.123 Y108.747 E1.45689
G1 X115.589 Y108.747 E.01596
G1 X81.083 Y143.253 E1.45689
G1 X80.549 Y143.253 E.01596
G1 X115.054 Y108.747 E1.45689
G1 X114.52 Y108.747 E.01596
G1 X80.014 Y143.253 E1.45689
G1 X79.724 Y143.253 E.00867
G1 X79.602 Y143.131 E.00515
G1 X113.985 Y108.747 E1.45174
G1 X113.451 Y108.747 E.01596
G1 X79.334 Y142.864 E1.44045
G1 X79.067 Y142.596 E.01128
G1 X112.916 Y108.747 E1.42917
G1 X112.382 Y108.747 E.01596
G1 X78.8 Y142.329 E1.41789
G1 X78.533 Y142.062 E.01128
G1 X111.847 Y108.747 E1.4066
G1 X111.313 Y108.747 E.01596
G1 X78.265 Y141.795 E1.39532
G1 X77.998 Y141.527 E.01128
G1 X110.778 Y108.747 E1.38403
G1 X110.244 Y108.747 E.01596
G1 X77.747 Y141.244 E1.37206
G1 X77.747 Y140.709 E.01596
G1 X109.709 Y108.747 E1.3495
M73 P71 R8
G1 X109.175 Y108.747 E.01596
G1 X77.747 Y140.175 E1.32693
G1 X77.747 Y139.64 E.01596
G1 X108.64 Y108.747 E1.30436
G1 X108.106 Y108.747 E.01596
G1 X77.747 Y139.106 E1.28179
G1 X77.747 Y138.571 E.01596
G1 X107.571 Y108.747 E1.25923
G1 X107.037 Y108.747 E.01596
G1 X77.747 Y138.037 E1.23666
G1 X77.747 Y137.502 E.01596
G1 X106.502 Y108.747 E1.21409
G1 X105.968 Y108.747 E.01596
G1 X77.747 Y136.968 E1.19152
G1 X77.747 Y136.433 E.01596
G1 X105.433 Y108.747 E1.16895
G1 X104.899 Y108.747 E.01596
G1 X77.747 Y135.899 E1.14639
G1 X77.747 Y135.364 E.01596
G1 X104.364 Y108.747 E1.12382
G1 X103.83 Y108.747 E.01596
G1 X77.747 Y134.83 E1.10125
G1 X77.747 Y134.295 E.01596
G1 X103.295 Y108.747 E1.07868
G1 X102.761 Y108.747 E.01596
G1 X77.747 Y133.761 E1.05612
G1 X77.747 Y133.226 E.01596
G1 X102.226 Y108.747 E1.03355
G1 X101.692 Y108.747 E.01596
G1 X77.747 Y132.692 E1.01098
G1 X77.747 Y132.157 E.01596
G1 X101.157 Y108.747 E.98841
G1 X100.623 Y108.747 E.01596
G1 X77.747 Y131.623 E.96585
G1 X77.747 Y131.088 E.01596
G1 X100.088 Y108.747 E.94328
G1 X99.554 Y108.747 E.01596
G1 X77.747 Y130.554 E.92071
G1 X77.747 Y130.019 E.01596
G1 X99.019 Y108.747 E.89814
G1 X98.485 Y108.747 E.01596
G1 X77.747 Y129.485 E.87558
G1 X77.747 Y128.95 E.01596
G1 X97.95 Y108.747 E.85301
G1 X97.416 Y108.747 E.01596
G1 X77.747 Y128.416 E.83044
G1 X77.747 Y127.881 E.01596
G1 X96.881 Y108.747 E.80787
G1 X96.347 Y108.747 E.01596
G1 X77.747 Y127.347 E.78531
G1 X77.747 Y126.812 E.01596
G1 X95.812 Y108.747 E.76274
G1 X95.278 Y108.747 E.01596
G1 X77.747 Y126.278 E.74017
G1 X77.747 Y125.743 E.01596
G1 X94.743 Y108.747 E.7176
G1 X94.209 Y108.747 E.01596
G1 X77.747 Y125.209 E.69503
G1 X77.747 Y124.674 E.01596
G1 X93.674 Y108.747 E.67247
G1 X93.14 Y108.747 E.01596
G1 X77.747 Y124.14 E.6499
G1 X77.747 Y123.605 E.01596
G1 X92.605 Y108.747 E.62733
G1 X92.071 Y108.747 E.01596
G1 X77.747 Y123.071 E.60476
G1 X77.747 Y122.536 E.01596
G1 X91.536 Y108.747 E.5822
M73 P72 R8
G1 X91.002 Y108.747 E.01596
G1 X77.747 Y122.002 E.55963
G1 X77.747 Y121.467 E.01596
G1 X90.467 Y108.747 E.53706
G1 X89.933 Y108.747 E.01596
G1 X77.747 Y120.933 E.51449
G1 X77.747 Y120.398 E.01596
G1 X89.398 Y108.747 E.49193
G1 X88.864 Y108.747 E.01596
G1 X77.747 Y119.864 E.46936
G1 X77.747 Y119.329 E.01596
G1 X88.329 Y108.747 E.44679
G1 X87.795 Y108.747 E.01596
G1 X77.747 Y118.795 E.42422
G1 X77.747 Y118.26 E.01596
G1 X87.26 Y108.747 E.40165
G1 X86.726 Y108.747 E.01596
G1 X77.747 Y117.726 E.37909
G1 X77.747 Y117.191 E.01596
G1 X86.191 Y108.747 E.35652
G1 X85.657 Y108.747 E.01596
G1 X77.747 Y116.657 E.33395
G1 X77.747 Y116.122 E.01596
G1 X85.122 Y108.747 E.31138
G1 X84.588 Y108.747 E.01596
G1 X77.747 Y115.588 E.28882
G1 X77.747 Y115.053 E.01596
G1 X84.053 Y108.747 E.26625
G1 X83.519 Y108.747 E.01596
G1 X77.747 Y114.519 E.24368
G1 X77.747 Y113.984 E.01596
G1 X82.984 Y108.747 E.22111
G1 X82.45 Y108.747 E.01596
G1 X77.747 Y113.45 E.19855
G1 X77.747 Y112.915 E.01596
G1 X81.915 Y108.747 E.17598
G1 X81.381 Y108.747 E.01596
G1 X77.747 Y112.381 E.15341
G1 X77.747 Y111.846 E.01596
G1 X80.846 Y108.747 E.13084
G1 X80.312 Y108.747 E.01596
G1 X77.747 Y111.312 E.10828
G1 X77.747 Y110.777 E.01596
G1 X79.777 Y108.747 E.08571
G1 X79.243 Y108.747 E.01596
G1 X77.747 Y110.243 E.06314
G1 X77.747 Y109.708 E.01596
G1 X78.708 Y108.747 E.04057
G1 X78.174 Y108.747 E.01596
G1 X77.578 Y109.343 E.02517
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X78.174 Y108.747 E-.32036
G1 X78.708 Y108.747 E-.20311
G1 X78.268 Y109.187 E-.23653
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/10
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 403
M204 S10000
G17
G3 Z1.6 I-.395 J1.151 P1  F30000
G1 X178.584 Y143.584 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X79.587 Y143.584 E3.18331
G1 X77.416 Y141.413 E.0987
G1 X77.416 Y108.416 E1.06104
G1 X178.584 Y108.416 E3.25311
G1 X178.584 Y126 E.56542
G1 X178.584 Y143.524 E.56349
M204 S10000
G1 X178.991 Y143.991 F30000
G1 F6000
M204 S3000
G1 X79.418 Y143.991 E3.20183
G1 X77.009 Y141.582 E.10954
G1 X77.009 Y108.009 E1.07956
G1 X178.991 Y108.009 E3.27928
G1 X178.991 Y126 E.57851
G1 X178.991 Y143.931 E.57658
M204 S10000
G1 X179.398 Y144.398 F30000
G1 F6000
M204 S3000
G1 X79.249 Y144.398 E3.22034
G1 X76.602 Y141.751 E.12039
G1 X76.602 Y107.602 E1.09807
G1 X179.398 Y107.602 E3.30546
G1 X179.398 Y126 E.5916
G1 X179.398 Y144.338 E.58967
M204 S250
G1 X179.79 Y144.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
M73 P73 R8
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E2.99952
G1 X76.21 Y141.913 E.12119
G1 X76.21 Y107.21 E1.03366
G1 X179.79 Y107.21 E3.08522
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

G1 X179.79 Y126 E.55968
G1 X179.79 Y144.73 E.55789
; WIPE_START
M204 S3000
G1 X177.79 Y144.731 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X177.926 Y137.1 Z1.8 F30000
G1 X178.422 Y109.342 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42101
G1 F6000
M204 S3000
G1 X177.828 Y108.747 E.02512
G1 X177.293 Y108.747 E.01597
G1 X178.253 Y109.707 E.04054
G1 X178.253 Y110.242 E.01597
G1 X176.758 Y108.747 E.06312
G1 X176.224 Y108.747 E.01597
G1 X178.253 Y110.776 E.08571
G1 X178.253 Y111.311 E.01597
G1 X175.689 Y108.747 E.10829
G1 X175.154 Y108.747 E.01597
G1 X178.253 Y111.846 E.13088
G1 X178.253 Y112.38 E.01597
G1 X174.62 Y108.747 E.15346
G1 X174.085 Y108.747 E.01597
G1 X178.253 Y112.915 E.17604
G1 X178.253 Y113.45 E.01597
G1 X173.55 Y108.747 E.19863
G1 X173.015 Y108.747 E.01597
G1 X178.253 Y113.985 E.22121
G1 X178.253 Y114.519 E.01597
G1 X172.481 Y108.747 E.2438
G1 X171.946 Y108.747 E.01597
G1 X178.253 Y115.054 E.26638
G1 X178.253 Y115.589 E.01597
G1 X171.411 Y108.747 E.28897
G1 X170.877 Y108.747 E.01597
G1 X178.253 Y116.123 E.31155
G1 X178.253 Y116.658 E.01597
G1 X170.342 Y108.747 E.33413
G1 X169.807 Y108.747 E.01597
G1 X178.253 Y117.193 E.35672
G1 X178.253 Y117.727 E.01597
G1 X169.273 Y108.747 E.3793
G1 X168.738 Y108.747 E.01597
G1 X178.253 Y118.262 E.40189
G1 X178.253 Y118.797 E.01597
G1 X168.203 Y108.747 E.42447
G1 X167.668 Y108.747 E.01597
G1 X178.253 Y119.332 E.44706
G1 X178.253 Y119.866 E.01597
G1 X167.134 Y108.747 E.46964
G1 X166.599 Y108.747 E.01597
G1 X178.253 Y120.401 E.49223
G1 X178.253 Y120.936 E.01597
G1 X166.064 Y108.747 E.51481
G1 X165.53 Y108.747 E.01597
G1 X178.253 Y121.47 E.53739
G1 X178.253 Y122.005 E.01597
G1 X164.995 Y108.747 E.55998
G1 X164.46 Y108.747 E.01597
G1 X178.253 Y122.54 E.58256
G1 X178.253 Y123.074 E.01597
G1 X163.926 Y108.747 E.60515
G1 X163.391 Y108.747 E.01597
G1 X178.253 Y123.609 E.62773
G1 X178.253 Y124.144 E.01597
G1 X162.856 Y108.747 E.65032
G1 X162.321 Y108.747 E.01597
G1 X178.253 Y124.679 E.6729
G1 X178.253 Y125.213 E.01597
G1 X161.787 Y108.747 E.69548
G1 X161.252 Y108.747 E.01597
G1 X178.253 Y125.748 E.71807
G1 X178.253 Y126.283 E.01597
G1 X160.717 Y108.747 E.74065
G1 X160.183 Y108.747 E.01597
G1 X178.253 Y126.817 E.76324
G1 X178.253 Y127.352 E.01597
G1 X159.648 Y108.747 E.78582
G1 X159.113 Y108.747 E.01597
G1 X178.253 Y127.887 E.80841
G1 X178.253 Y128.421 E.01597
M73 P73 R7
G1 X158.579 Y108.747 E.83099
G1 X158.044 Y108.747 E.01597
G1 X178.253 Y128.956 E.85357
G1 X178.253 Y129.491 E.01597
G1 X157.509 Y108.747 E.87616
G1 X156.974 Y108.747 E.01597
G1 X178.253 Y130.026 E.89874
G1 X178.253 Y130.56 E.01597
G1 X156.44 Y108.747 E.92133
G1 X155.905 Y108.747 E.01597
G1 X178.253 Y131.095 E.94391
G1 X178.253 Y131.63 E.01597
G1 X155.37 Y108.747 E.9665
G1 X154.836 Y108.747 E.01597
G1 X178.253 Y132.164 E.98908
M73 C5
G1 X178.253 Y132.699 E.01597
M73 P74 R7
G1 X154.301 Y108.747 E1.01167
G1 X153.766 Y108.747 E.01597
G1 X178.253 Y133.234 E1.03425
G1 X178.253 Y133.768 E.01597
G1 X153.232 Y108.747 E1.05683
G1 X152.697 Y108.747 E.01597
G1 X178.253 Y134.303 E1.07942
G1 X178.253 Y134.838 E.01597
G1 X152.162 Y108.747 E1.102
G1 X151.627 Y108.747 E.01597
G1 X178.253 Y135.373 E1.12459
G1 X178.253 Y135.907 E.01597
G1 X151.093 Y108.747 E1.14717
G1 X150.558 Y108.747 E.01597
G1 X178.253 Y136.442 E1.16976
G1 X178.253 Y136.977 E.01597
G1 X150.023 Y108.747 E1.19234
G1 X149.489 Y108.747 E.01597
G1 X178.253 Y137.511 E1.21492
G1 X178.253 Y138.046 E.01597
G1 X148.954 Y108.747 E1.23751
G1 X148.419 Y108.747 E.01597
G1 X178.253 Y138.581 E1.26009
G1 X178.253 Y139.115 E.01597
G1 X147.885 Y108.747 E1.28268
G1 X147.35 Y108.747 E.01597
G1 X178.253 Y139.65 E1.30526
G1 X178.253 Y140.185 E.01597
G1 X146.815 Y108.747 E1.32785
G1 X146.28 Y108.747 E.01597
G1 X178.253 Y140.72 E1.35043
G1 X178.253 Y141.254 E.01597
G1 X145.746 Y108.747 E1.37302
G1 X145.211 Y108.747 E.01597
G1 X178.253 Y141.789 E1.3956
G1 X178.253 Y142.324 E.01597
G1 X144.676 Y108.747 E1.41818
G1 X144.142 Y108.747 E.01597
G1 X178.253 Y142.858 E1.44077
G1 X178.253 Y143.253 E.01178
G1 X178.113 Y143.253 E.00419
G1 X143.607 Y108.747 E1.45743
G1 X143.072 Y108.747 E.01597
G1 X177.578 Y143.253 E1.45743
G1 X177.043 Y143.253 E.01597
G1 X142.538 Y108.747 E1.45743
G1 X142.003 Y108.747 E.01597
G1 X176.508 Y143.253 E1.45743
G1 X175.974 Y143.253 E.01597
G1 X141.468 Y108.747 E1.45743
G1 X140.933 Y108.747 E.01597
G1 X175.439 Y143.253 E1.45743
G1 X174.904 Y143.253 E.01597
G1 X140.399 Y108.747 E1.45743
G1 X139.864 Y108.747 E.01597
G1 X174.37 Y143.253 E1.45743
G1 X173.835 Y143.253 E.01597
G1 X139.329 Y108.747 E1.45743
G1 X138.795 Y108.747 E.01597
G1 X173.3 Y143.253 E1.45743
G1 X172.766 Y143.253 E.01597
G1 X138.26 Y108.747 E1.45743
G1 X137.725 Y108.747 E.01597
G1 X172.231 Y143.253 E1.45743
G1 X171.696 Y143.253 E.01597
G1 X137.191 Y108.747 E1.45743
G1 X136.656 Y108.747 E.01597
G1 X171.161 Y143.253 E1.45743
G1 X170.627 Y143.253 E.01597
G1 X136.121 Y108.747 E1.45743
G1 X135.586 Y108.747 E.01597
G1 X170.092 Y143.253 E1.45743
G1 X169.557 Y143.253 E.01597
G1 X135.052 Y108.747 E1.45743
G1 X134.517 Y108.747 E.01597
G1 X169.023 Y143.253 E1.45743
G1 X168.488 Y143.253 E.01597
G1 X133.982 Y108.747 E1.45743
G1 X133.448 Y108.747 E.01597
G1 X167.953 Y143.253 E1.45743
G1 X167.419 Y143.253 E.01597
G1 X132.913 Y108.747 E1.45743
G1 X132.378 Y108.747 E.01597
G1 X166.884 Y143.253 E1.45743
G1 X166.349 Y143.253 E.01597
G1 X131.844 Y108.747 E1.45743
G1 X131.309 Y108.747 E.01597
G1 X165.814 Y143.253 E1.45743
G1 X165.28 Y143.253 E.01597
G1 X130.774 Y108.747 E1.45743
G1 X130.239 Y108.747 E.01597
G1 X164.745 Y143.253 E1.45743
G1 X164.21 Y143.253 E.01597
G1 X129.705 Y108.747 E1.45743
G1 X129.17 Y108.747 E.01597
G1 X163.676 Y143.253 E1.45743
G1 X163.141 Y143.253 E.01597
G1 X128.635 Y108.747 E1.45743
G1 X128.101 Y108.747 E.01597
G1 X162.606 Y143.253 E1.45743
G1 X162.072 Y143.253 E.01597
G1 X127.566 Y108.747 E1.45743
G1 X127.031 Y108.747 E.01597
G1 X161.537 Y143.253 E1.45743
G1 X161.002 Y143.253 E.01597
G1 X126.497 Y108.747 E1.45743
G1 X125.962 Y108.747 E.01597
G1 X160.467 Y143.253 E1.45743
G1 X159.933 Y143.253 E.01597
G1 X125.427 Y108.747 E1.45743
G1 X124.892 Y108.747 E.01597
G1 X159.398 Y143.253 E1.45743
G1 X158.863 Y143.253 E.01597
G1 X124.358 Y108.747 E1.45743
G1 X123.823 Y108.747 E.01597
G1 X158.329 Y143.253 E1.45743
G1 X157.794 Y143.253 E.01597
G1 X123.288 Y108.747 E1.45743
G1 X122.754 Y108.747 E.01597
G1 X157.259 Y143.253 E1.45743
G1 X156.725 Y143.253 E.01597
G1 X122.219 Y108.747 E1.45743
G1 X121.684 Y108.747 E.01597
G1 X156.19 Y143.253 E1.45743
G1 X155.655 Y143.253 E.01597
G1 X121.15 Y108.747 E1.45743
G1 X120.615 Y108.747 E.01597
G1 X155.12 Y143.253 E1.45743
G1 X154.586 Y143.253 E.01597
G1 X120.08 Y108.747 E1.45743
M73 P75 R7
G1 X119.545 Y108.747 E.01597
G1 X154.051 Y143.253 E1.45743
G1 X153.516 Y143.253 E.01597
G1 X119.011 Y108.747 E1.45743
G1 X118.476 Y108.747 E.01597
G1 X152.982 Y143.253 E1.45743
G1 X152.447 Y143.253 E.01597
G1 X117.941 Y108.747 E1.45743
G1 X117.407 Y108.747 E.01597
G1 X151.912 Y143.253 E1.45743
G1 X151.378 Y143.253 E.01597
G1 X116.872 Y108.747 E1.45743
G1 X116.337 Y108.747 E.01597
G1 X150.843 Y143.253 E1.45743
G1 X150.308 Y143.253 E.01597
G1 X115.803 Y108.747 E1.45743
G1 X115.268 Y108.747 E.01597
G1 X149.773 Y143.253 E1.45743
G1 X149.239 Y143.253 E.01597
G1 X114.733 Y108.747 E1.45743
G1 X114.198 Y108.747 E.01597
G1 X148.704 Y143.253 E1.45743
G1 X148.169 Y143.253 E.01597
G1 X113.664 Y108.747 E1.45743
G1 X113.129 Y108.747 E.01597
G1 X147.635 Y143.253 E1.45743
G1 X147.1 Y143.253 E.01597
G1 X112.594 Y108.747 E1.45743
G1 X112.06 Y108.747 E.01597
G1 X146.565 Y143.253 E1.45743
G1 X146.031 Y143.253 E.01597
G1 X111.525 Y108.747 E1.45743
G1 X110.99 Y108.747 E.01597
G1 X145.496 Y143.253 E1.45743
G1 X144.961 Y143.253 E.01597
G1 X110.456 Y108.747 E1.45743
G1 X109.921 Y108.747 E.01597
G1 X144.426 Y143.253 E1.45743
G1 X143.892 Y143.253 E.01597
G1 X109.386 Y108.747 E1.45743
G1 X108.851 Y108.747 E.01597
G1 X143.357 Y143.253 E1.45743
G1 X142.822 Y143.253 E.01597
G1 X108.317 Y108.747 E1.45743
G1 X107.782 Y108.747 E.01597
G1 X142.288 Y143.253 E1.45743
G1 X141.753 Y143.253 E.01597
G1 X107.247 Y108.747 E1.45743
G1 X106.713 Y108.747 E.01597
G1 X141.218 Y143.253 E1.45743
G1 X140.684 Y143.253 E.01597
G1 X106.178 Y108.747 E1.45743
G1 X105.643 Y108.747 E.01597
G1 X140.149 Y143.253 E1.45743
G1 X139.614 Y143.253 E.01597
G1 X105.109 Y108.747 E1.45743
G1 X104.574 Y108.747 E.01597
G1 X139.079 Y143.253 E1.45743
G1 X138.545 Y143.253 E.01597
G1 X104.039 Y108.747 E1.45743
G1 X103.504 Y108.747 E.01597
G1 X138.01 Y143.253 E1.45743
G1 X137.475 Y143.253 E.01597
G1 X102.97 Y108.747 E1.45743
G1 X102.435 Y108.747 E.01597
G1 X136.941 Y143.253 E1.45743
G1 X136.406 Y143.253 E.01597
G1 X101.9 Y108.747 E1.45743
G1 X101.366 Y108.747 E.01597
M73 P76 R7
G1 X135.871 Y143.253 E1.45743
G1 X135.337 Y143.253 E.01597
G1 X100.831 Y108.747 E1.45743
G1 X100.296 Y108.747 E.01597
G1 X134.802 Y143.253 E1.45743
G1 X134.267 Y143.253 E.01597
G1 X99.762 Y108.747 E1.45743
G1 X99.227 Y108.747 E.01597
G1 X133.732 Y143.253 E1.45743
G1 X133.198 Y143.253 E.01597
G1 X98.692 Y108.747 E1.45743
G1 X98.157 Y108.747 E.01597
G1 X132.663 Y143.253 E1.45743
G1 X132.128 Y143.253 E.01597
G1 X97.623 Y108.747 E1.45743
G1 X97.088 Y108.747 E.01597
G1 X131.594 Y143.253 E1.45743
G1 X131.059 Y143.253 E.01597
G1 X96.553 Y108.747 E1.45743
G1 X96.019 Y108.747 E.01597
G1 X130.524 Y143.253 E1.45743
G1 X129.99 Y143.253 E.01597
G1 X95.484 Y108.747 E1.45743
G1 X94.949 Y108.747 E.01597
G1 X129.455 Y143.253 E1.45743
G1 X128.92 Y143.253 E.01597
G1 X94.415 Y108.747 E1.45743
G1 X93.88 Y108.747 E.01597
G1 X128.385 Y143.253 E1.45743
G1 X127.851 Y143.253 E.01597
G1 X93.345 Y108.747 E1.45743
G1 X92.81 Y108.747 E.01597
G1 X127.316 Y143.253 E1.45743
G1 X126.781 Y143.253 E.01597
G1 X92.276 Y108.747 E1.45743
G1 X91.741 Y108.747 E.01597
G1 X126.247 Y143.253 E1.45743
G1 X125.712 Y143.253 E.01597
G1 X91.206 Y108.747 E1.45743
G1 X90.672 Y108.747 E.01597
G1 X125.177 Y143.253 E1.45743
G1 X124.643 Y143.253 E.01597
G1 X90.137 Y108.747 E1.45743
G1 X89.602 Y108.747 E.01597
G1 X124.108 Y143.253 E1.45743
G1 X123.573 Y143.253 E.01597
G1 X89.068 Y108.747 E1.45743
G1 X88.533 Y108.747 E.01597
G1 X123.038 Y143.253 E1.45743
G1 X122.504 Y143.253 E.01597
G1 X87.998 Y108.747 E1.45743
G1 X87.463 Y108.747 E.01597
G1 X121.969 Y143.253 E1.45743
G1 X121.434 Y143.253 E.01597
G1 X86.929 Y108.747 E1.45743
G1 X86.394 Y108.747 E.01597
G1 X120.9 Y143.253 E1.45743
G1 X120.365 Y143.253 E.01597
G1 X85.859 Y108.747 E1.45743
G1 X85.325 Y108.747 E.01597
G1 X119.83 Y143.253 E1.45743
G1 X119.296 Y143.253 E.01597
M73 P76 R6
G1 X84.79 Y108.747 E1.45743
G1 X84.255 Y108.747 E.01597
G1 X118.761 Y143.253 E1.45743
G1 X118.226 Y143.253 E.01597
G1 X83.721 Y108.747 E1.45743
G1 X83.186 Y108.747 E.01597
M73 P77 R6
G1 X117.691 Y143.253 E1.45743
G1 X117.157 Y143.253 E.01597
G1 X82.651 Y108.747 E1.45743
G1 X82.116 Y108.747 E.01597
G1 X116.622 Y143.253 E1.45743
G1 X116.087 Y143.253 E.01597
G1 X81.582 Y108.747 E1.45743
G1 X81.047 Y108.747 E.01597
G1 X115.553 Y143.253 E1.45743
G1 X115.018 Y143.253 E.01597
G1 X80.512 Y108.747 E1.45743
G1 X79.978 Y108.747 E.01597
G1 X114.483 Y143.253 E1.45743
G1 X113.949 Y143.253 E.01597
M73 C4
G1 X79.443 Y108.747 E1.45743
G1 X78.908 Y108.747 E.01597
G1 X113.414 Y143.253 E1.45743
G1 X112.879 Y143.253 E.01597
G1 X78.374 Y108.747 E1.45743
G1 X77.839 Y108.747 E.01597
G1 X112.344 Y143.253 E1.45743
G1 X111.81 Y143.253 E.01597
G1 X77.747 Y109.19 E1.43872
G1 X77.747 Y109.725 E.01597
G1 X111.275 Y143.253 E1.41613
G1 X110.74 Y143.253 E.01597
G1 X77.747 Y110.26 E1.39355
G1 X77.747 Y110.794 E.01597
G1 X110.206 Y143.253 E1.37096
G1 X109.671 Y143.253 E.01597
G1 X77.747 Y111.329 E1.34838
G1 X77.747 Y111.864 E.01597
G1 X109.136 Y143.253 E1.32579
G1 X108.602 Y143.253 E.01597
G1 X77.747 Y112.398 E1.30321
G1 X77.747 Y112.933 E.01597
G1 X108.067 Y143.253 E1.28063
G1 X107.532 Y143.253 E.01597
G1 X77.747 Y113.468 E1.25804
G1 X77.747 Y114.003 E.01597
G1 X106.997 Y143.253 E1.23546
G1 X106.463 Y143.253 E.01597
G1 X77.747 Y114.537 E1.21287
G1 X77.747 Y115.072 E.01597
G1 X105.928 Y143.253 E1.19029
G1 X105.393 Y143.253 E.01597
G1 X77.747 Y115.607 E1.1677
G1 X77.747 Y116.141 E.01597
G1 X104.859 Y143.253 E1.14512
G1 X104.324 Y143.253 E.01597
G1 X77.747 Y116.676 E1.12253
G1 X77.747 Y117.211 E.01597
G1 X103.789 Y143.253 E1.09995
G1 X103.255 Y143.253 E.01597
G1 X77.747 Y117.745 E1.07737
G1 X77.747 Y118.28 E.01597
G1 X102.72 Y143.253 E1.05478
G1 X102.185 Y143.253 E.01597
G1 X77.747 Y118.815 E1.0322
G1 X77.747 Y119.35 E.01597
G1 X101.65 Y143.253 E1.00961
G1 X101.116 Y143.253 E.01597
G1 X77.747 Y119.884 E.98703
G1 X77.747 Y120.419 E.01597
G1 X100.581 Y143.253 E.96444
G1 X100.046 Y143.253 E.01597
G1 X77.747 Y120.954 E.94186
G1 X77.747 Y121.488 E.01597
M73 P78 R6
G1 X99.512 Y143.253 E.91928
G1 X98.977 Y143.253 E.01597
G1 X77.747 Y122.023 E.89669
G1 X77.747 Y122.558 E.01597
G1 X98.442 Y143.253 E.87411
G1 X97.908 Y143.253 E.01597
G1 X77.747 Y123.092 E.85152
G1 X77.747 Y123.627 E.01597
G1 X97.373 Y143.253 E.82894
G1 X96.838 Y143.253 E.01597
G1 X77.747 Y124.162 E.80635
G1 X77.747 Y124.697 E.01597
G1 X96.303 Y143.253 E.78377
G1 X95.769 Y143.253 E.01597
G1 X77.747 Y125.231 E.76118
G1 X77.747 Y125.766 E.01597
G1 X95.234 Y143.253 E.7386
G1 X94.699 Y143.253 E.01597
G1 X77.747 Y126.301 E.71602
G1 X77.747 Y126.835 E.01597
G1 X94.165 Y143.253 E.69343
G1 X93.63 Y143.253 E.01597
G1 X77.747 Y127.37 E.67085
G1 X77.747 Y127.905 E.01597
G1 X93.095 Y143.253 E.64826
G1 X92.561 Y143.253 E.01597
G1 X77.747 Y128.439 E.62568
G1 X77.747 Y128.974 E.01597
G1 X92.026 Y143.253 E.60309
G1 X91.491 Y143.253 E.01597
G1 X77.747 Y129.509 E.58051
G1 X77.747 Y130.044 E.01597
G1 X90.956 Y143.253 E.55793
G1 X90.422 Y143.253 E.01597
G1 X77.747 Y130.578 E.53534
G1 X77.747 Y131.113 E.01597
G1 X89.887 Y143.253 E.51276
G1 X89.352 Y143.253 E.01597
G1 X77.747 Y131.648 E.49017
G1 X77.747 Y132.182 E.01597
G1 X88.818 Y143.253 E.46759
G1 X88.283 Y143.253 E.01597
G1 X77.747 Y132.717 E.445
G1 X77.747 Y133.252 E.01597
G1 X87.748 Y143.253 E.42242
G1 X87.214 Y143.253 E.01597
G1 X77.747 Y133.786 E.39983
G1 X77.747 Y134.321 E.01597
G1 X86.679 Y143.253 E.37725
G1 X86.144 Y143.253 E.01597
G1 X77.747 Y134.856 E.35467
G1 X77.747 Y135.391 E.01597
G1 X85.609 Y143.253 E.33208
G1 X85.075 Y143.253 E.01597
G1 X77.747 Y135.925 E.3095
G1 X77.747 Y136.46 E.01597
G1 X84.54 Y143.253 E.28691
G1 X84.005 Y143.253 E.01597
G1 X77.747 Y136.995 E.26433
G1 X77.747 Y137.529 E.01597
G1 X83.471 Y143.253 E.24174
G1 X82.936 Y143.253 E.01597
G1 X77.747 Y138.064 E.21916
G1 X77.747 Y138.599 E.01597
G1 X82.401 Y143.253 E.19658
G1 X81.867 Y143.253 E.01597
G1 X77.747 Y139.133 E.17399
G1 X77.747 Y139.668 E.01597
M73 P79 R6
G1 X81.332 Y143.253 E.15141
G1 X80.797 Y143.253 E.01597
G1 X77.747 Y140.203 E.12882
G1 X77.747 Y140.738 E.01597
G1 X80.262 Y143.253 E.10624
G1 X79.728 Y143.253 E.01597
G1 X77.578 Y141.103 E.09082
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6000
G1 X78.992 Y142.517 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/10
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 403
M204 S10000
G17
G3 Z1.8 I.138 J1.209 P1  F30000
G1 X157.926 Y133.477 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.55998
G1 F6000
M204 S3000
G1 X157.713 Y133.496 E.00874
; LINE_WIDTH: 0.523317
G1 X157.499 Y133.514 E.00812
; LINE_WIDTH: 0.486654
G1 X157.286 Y133.532 E.0075
; LINE_WIDTH: 0.44999
G1 X156.21 Y133.532 E.03461
G1 X156.21 Y133.096 E.01405
; LINE_WIDTH: 0.48908
G1 X156.229 Y132.982 E.00405
; LINE_WIDTH: 0.52817
G1 X156.249 Y132.869 E.0044
; LINE_WIDTH: 0.56726
G1 X156.268 Y132.756 E.00476
; LINE_WIDTH: 0.60635
G2 X156.283 Y132.405 I-.893 J-.212 E.01574
; LINE_WIDTH: 0.59598
G1 X156.283 Y126.938 E.23884
G1 X156.258 Y126.609 E.01441
; LINE_WIDTH: 0.547317
G1 X156.234 Y126.28 E.01314
; LINE_WIDTH: 0.498654
G3 X156.234 Y125.622 I2.211 J-.329 E.02377
; LINE_WIDTH: 0.547317
G1 X156.258 Y125.293 E.01314
; LINE_WIDTH: 0.59598
G1 X156.283 Y124.964 E.01441
G1 X156.283 Y118.541 E.28063
G1 X156.836 Y118.541 E.02416
G1 X156.836 Y124.964 E.28063
; LINE_WIDTH: 0.60635
G1 X156.847 Y125.154 E.00844
G1 X156.921 Y125.269 E.00609
; LINE_WIDTH: 0.56726
G1 X156.995 Y125.384 E.00567
; LINE_WIDTH: 0.52817
G1 X157.069 Y125.499 E.00525
; LINE_WIDTH: 0.48908
G1 X157.143 Y125.614 E.00482
; LINE_WIDTH: 0.44999
G1 X157.401 Y125.836 E.01092
G1 X157.621 Y125.893 E.0073
; LINE_WIDTH: 0.422755
G1 X157.84 Y125.951 E.00682
G1 X157.621 Y126.009 E.00682
; LINE_WIDTH: 0.44999
G1 X157.401 Y126.066 E.0073
G1 X157.143 Y126.288 E.01092
; LINE_WIDTH: 0.498654
G1 X157.041 Y126.504 E.00863
; LINE_WIDTH: 0.547317
G1 X156.938 Y126.721 E.00955
; LINE_WIDTH: 0.59598
G1 X156.836 Y126.938 E.01047
G1 X156.836 Y132.405 E.23884
; LINE_WIDTH: 0.60635
G1 X156.847 Y132.594 E.00844
G1 X156.893 Y132.668 E.00386
; LINE_WIDTH: 0.56726
G1 X156.939 Y132.741 E.00359
; LINE_WIDTH: 0.52817
G1 X156.985 Y132.815 E.00332
; LINE_WIDTH: 0.48908
G1 X157.031 Y132.888 E.00306
; LINE_WIDTH: 0.44999
G1 X157.369 Y133.256 E.01606
; LINE_WIDTH: 0.486654
G1 X157.554 Y133.33 E.007
; LINE_WIDTH: 0.523317
G1 X157.74 Y133.404 E.00758
; LINE_WIDTH: 0.55998
G1 X157.87 Y133.455 E.00571
; WIPE_START
G1 X157.713 Y133.496 E-.06177
G1 X157.499 Y133.514 E-.08132
G1 X157.286 Y133.532 E-.08131
G1 X156.21 Y133.532 E-.40903
G1 X156.21 Y133.199 E-.12657
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X161.476 Y127.675 Z2 F30000
G1 X163.182 Y125.887 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.628
G1 F6000
M204 S3000
G2 X161.316 Y125.825 I-1.645 J21.466 E.08631
G1 X161.573 Y125.735 E.0126
G1 X162.28 Y125.37 E.03675
G1 X162.745 Y125.025 E.02677
G1 X162.804 Y125.453 E.01999
G1 X162.887 Y125.637 E.00929
G1 X163.136 Y125.848 E.01507
; WIPE_START
G1 X162.428 Y125.84 E-.2691
G1 X161.316 Y125.825 E-.42258
G1 X161.486 Y125.766 E-.06832
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.172 Y123.49 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.61104
G1 F6000
M204 S3000
G1 X163.913 Y123.68 E.01439
G2 X165.072 Y122.032 I-26.937 J-20.164 E.0904
; LINE_WIDTH: 0.64405
G1 F5988.721
G1 X165.499 Y121.424 E.03527
; LINE_WIDTH: 0.66378
G1 F5798.409
G2 X166.411 Y120.079 I-50.798 J-35.42 E.07971
; LINE_WIDTH: 0.66243
G1 F5811.044
G1 X167.323 Y118.693 E.08122
; LINE_WIDTH: 0.63681
G1 F6000
G1 X167.412 Y118.561 E.00744
G1 X168.106 Y118.561 E.03259
G1 X167.822 Y119.016 E.02515
; LINE_WIDTH: 0.66243
G1 F5811.044
G1 X166.926 Y120.423 E.08164
; LINE_WIDTH: 0.66378
G1 F5798.409
G3 X165.982 Y121.78 I-17.717 J-11.311 E.08109
; LINE_WIDTH: 0.64405
G1 F5988.721
G1 X165.529 Y122.368 E.03527
; LINE_WIDTH: 0.61104
G1 F6000
G3 X164.784 Y123.041 I-5.791 J-5.66 E.04505
G1 X164.22 Y123.455 E.03138
; WIPE_START
G1 X163.913 Y123.68 E-.14468
G1 X164.303 Y123.157 E-.24776
G1 X164.849 Y122.358 E-.36755
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.281 Y129.855 Z2 F30000
G1 X166.807 Y132.609 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.61088
G1 F6000
M204 S3000
G1 X166.601 Y132.764 E.01158
; LINE_WIDTH: 0.59296
G1 X166.347 Y132.917 E.01287
; LINE_WIDTH: 0.565615
G1 X166.094 Y133.071 E.01223
; LINE_WIDTH: 0.53827
G1 X165.862 Y133.151 E.00962
; LINE_WIDTH: 0.49541
G1 X165.629 Y133.231 E.00879
; LINE_WIDTH: 0.45255
G1 X165.22 Y133.339 E.01368
; LINE_WIDTH: 0.409205
G1 X164.812 Y133.447 E.01224
; LINE_WIDTH: 0.4098
G1 X164.734 Y133.435 E.00228
; LINE_WIDTH: 0.45374
G1 X164.656 Y133.423 E.00255
; LINE_WIDTH: 0.49768
G1 X164.578 Y133.411 E.00283
; LINE_WIDTH: 0.54162
G1 X164.501 Y133.399 E.0031
; LINE_WIDTH: 0.58556
G1 X164.423 Y133.388 E.00337
; LINE_WIDTH: 0.6295
G1 X164.345 Y133.376 E.00364
G1 X164.406 Y133.336 E.00339
; LINE_WIDTH: 0.585267
G1 X164.468 Y133.297 E.00313
; LINE_WIDTH: 0.541034
G1 X164.529 Y133.257 E.00288
; LINE_WIDTH: 0.4968
G1 X164.591 Y133.217 E.00262
; LINE_WIDTH: 0.452567
G1 X164.652 Y133.178 E.00237
; LINE_WIDTH: 0.408334
G1 X164.714 Y133.138 E.00211
; LINE_WIDTH: 0.37049
G1 X164.852 Y133.104 E.00369
; LINE_WIDTH: 0.41152
G1 X165.171 Y132.976 E.00999
; LINE_WIDTH: 0.45255
G1 X165.49 Y132.849 E.01111
; LINE_WIDTH: 0.49541
G1 X165.658 Y132.754 E.00691
; LINE_WIDTH: 0.53827
G1 X165.826 Y132.658 E.00757
; LINE_WIDTH: 0.574575
G1 X166.11 Y132.439 E.01506
; LINE_WIDTH: 0.61088
G1 X166.393 Y132.22 E.01609
; LINE_WIDTH: 0.64075
G1 X166.583 Y131.973 E.01469
; LINE_WIDTH: 0.6545
G1 F5886.392
G1 X166.95 Y131.373 E.03397
; LINE_WIDTH: 0.67004
G1 F5740.529
G1 X167.148 Y130.829 E.02871
G1 X167.227 Y130.441 E.01961
; LINE_WIDTH: 0.66299
G1 F5805.796
G1 X167.277 Y129.629 E.03986
; LINE_WIDTH: 0.63594
G1 F6000
G1 X167.208 Y128.968 E.03109
; LINE_WIDTH: 0.61426
G1 X167.117 Y128.667 E.0142
; LINE_WIDTH: 0.585565
G1 X167.026 Y128.366 E.01348
; LINE_WIDTH: 0.55687
G1 X166.781 Y127.894 E.02161
; LINE_WIDTH: 0.5075
G1 X166.658 Y127.728 E.00757
; LINE_WIDTH: 0.469434
G1 X166.534 Y127.563 E.00695
; LINE_WIDTH: 0.431367
G1 X166.41 Y127.398 E.00633
; LINE_WIDTH: 0.3933
G1 X166.065 Y127.011 E.01435
; LINE_WIDTH: 0.39785
G1 X165.597 Y126.631 E.01691
G1 X165.718 Y126.656 E.00348
G1 X166.206 Y126.858 E.0148
; LINE_WIDTH: 0.40116
G1 X166.724 Y127.209 E.01772
; LINE_WIDTH: 0.436607
G1 X166.862 Y127.343 E.00597
; LINE_WIDTH: 0.472054
G1 X166.999 Y127.477 E.00651
; LINE_WIDTH: 0.5075
G1 X167.137 Y127.612 E.00705
; LINE_WIDTH: 0.53841
G1 X167.402 Y128.008 E.01866
; LINE_WIDTH: 0.570435
G1 X167.535 Y128.272 E.01232
; LINE_WIDTH: 0.60246
G1 X167.668 Y128.536 E.01306
; LINE_WIDTH: 0.62029
G1 X167.79 Y128.955 E.01991
; LINE_WIDTH: 0.63885
G1 X167.877 Y129.657 E.0333
; LINE_WIDTH: 0.65607
G1 F5871.32
G1 X167.887 Y129.973 E.01533
; LINE_WIDTH: 0.66299
G1 F5805.796
G1 X167.843 Y130.511 E.02645
; LINE_WIDTH: 0.67004
G1 F5740.529
G3 X167.571 Y131.494 I-3.03 J-.311 E.05073
; LINE_WIDTH: 0.66408
G1 F5795.608
G1 X167.322 Y131.971 E.02643
G1 X167.064 Y132.29 E.0201
; LINE_WIDTH: 0.63748
G1 F6000
G1 X166.845 Y132.562 E.01642
M204 S10000
G1 X167.269 Y132.831 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X167.155 Y132.95 E.00531
G3 X166.865 Y133.163 I-1.522 J-1.773 E.0116
G1 X166.295 Y133.475 E.0209
G3 X163.427 Y133.929 I-3.072 J-10.117 E.09366
G3 X155.803 Y133.939 I-5.844 J-1505.723 E.24516
G1 X155.803 Y118.061 E.51059
G1 X157.316 Y118.061 E.04866
G1 X157.316 Y124.964 E.22199
G1 X157.325 Y125.07 E.00341
G1 X157.457 Y125.354 E.01008
G1 X157.611 Y125.487 E.00655
G1 X157.926 Y125.575 E.0105
G1 X159.593 Y125.57 E.05363
G2 X161.356 Y125.289 I-.294 J-7.507 E.05753
G1 X162.059 Y124.916 E.02557
; LINE_WIDTH: 0.495967
G1 X162.318 Y124.73 E.01143
; LINE_WIDTH: 0.541944
G1 X162.578 Y124.545 E.01259
; LINE_WIDTH: 0.58792
G1 X162.838 Y124.359 E.01375
; LINE_WIDTH: 0.61246
G2 X163.134 Y123.984 I-.862 J-.987 E.02162
; LINE_WIDTH: 0.571843
G1 X163.22 Y123.844 E.00683
; LINE_WIDTH: 0.531225
G1 X163.305 Y123.705 E.00631
; LINE_WIDTH: 0.490608
G1 X163.39 Y123.565 E.00578
; LINE_WIDTH: 0.44999
G2 X165.487 Y120.535 I-40.032 J-29.944 E.11851
G1 X167.144 Y118.061 E.09578
G1 X169.01 Y118.061 E.05999
G1 X167.949 Y119.756 E.06431
G3 X165.876 Y122.714 I-20.732 J-12.321 E.11624
G3 X165.087 Y123.424 I-6.604 J-6.55 E.03417
G1 X163.996 Y124.224 E.0435
; LINE_WIDTH: 0.490608
G1 X163.857 Y124.301 E.00561
; LINE_WIDTH: 0.531225
G1 X163.718 Y124.377 E.00612
; LINE_WIDTH: 0.571843
G1 X163.579 Y124.454 E.00663
; LINE_WIDTH: 0.61246
G2 X163.284 Y124.7 I.219 J.561 E.01758
; LINE_WIDTH: 0.59928
G1 X163.269 Y124.817 E.00518
; LINE_WIDTH: 0.549517
G1 X163.254 Y124.934 E.00471
; LINE_WIDTH: 0.499754
G1 X163.24 Y125.051 E.00425
; LINE_WIDTH: 0.44999
G1 X163.318 Y125.391 E.01122
; LINE_WIDTH: 0.491974
G1 X163.434 Y125.506 E.00578
; LINE_WIDTH: 0.533957
G1 X163.549 Y125.621 E.00632
; LINE_WIDTH: 0.57594
G1 X163.664 Y125.736 E.00686
; LINE_WIDTH: 0.61273
G1 X163.81 Y125.797 E.0071
G1 X164.368 Y125.942 E.02594
; LINE_WIDTH: 0.58668
G1 X164.925 Y126.088 E.02476
; LINE_WIDTH: 0.6099
G1 X165.496 Y126.276 E.02691
G1 X165.548 Y126.271 E.00236
; LINE_WIDTH: 0.570763
G1 X165.601 Y126.265 E.0022
; LINE_WIDTH: 0.531625
G1 X165.653 Y126.26 E.00204
; LINE_WIDTH: 0.492488
G1 X165.706 Y126.254 E.00187
; LINE_WIDTH: 0.45335
G3 X166.368 Y126.512 I-.964 J3.46 E.02308
; LINE_WIDTH: 0.44999
G1 X166.866 Y126.832 E.01903
G1 X167.486 Y127.334 E.02567
G3 X168.128 Y128.371 I-4.26 J3.352 E.03929
G1 X168.278 Y128.888 E.01731
G1 X168.377 Y129.621 E.02379
G1 X168.4 Y129.952 E.01066
G3 X168.251 Y131.147 I-5.833 J-.124 E.0388
G3 X167.475 Y132.616 I-4.156 J-1.256 E.05375
G1 X167.311 Y132.787 E.00762
M204 S10000
G1 X167.714 Y132.962 F30000
G1 F6000
M204 S3000
G1 X167.359 Y133.324 E.01631
G3 X166.362 Y133.896 I-2.796 J-3.719 E.03706
G3 X164.464 Y134.272 I-4.482 J-17.656 E.06224
G3 X162.392 Y134.346 I-1.736 J-19.411 E.0667
G1 X155.396 Y134.346 E.22497
G1 X155.396 Y117.654 E.53677
G1 X157.723 Y117.654 E.07484
G1 X157.723 Y124.964 E.23508
G1 X157.77 Y125.094 E.00444
G1 X157.926 Y125.168 E.00556
G1 X159.592 Y125.163 E.05357
G2 X161.178 Y124.923 I-.302 J-7.349 E.05166
G1 X161.816 Y124.589 E.02317
G1 X162.23 Y124.28 E.01661
G2 X163.567 Y122.648 I-9.596 J-9.224 E.06792
G2 X166.927 Y117.654 I-575.878 J-391.006 E.19357
G1 X169.745 Y117.654 E.09061
G1 X168.684 Y119.349 E.06431
G3 X167.219 Y121.644 I-42.309 J-25.388 E.08758
G3 X166.177 Y122.99 I-17.473 J-12.455 E.05475
G3 X165.339 Y123.744 I-7.003 J-6.94 E.03624
G2 X163.678 Y124.979 I31.201 J43.709 E.06657
G1 X163.657 Y125.156 E.00574
G1 X163.793 Y125.284 E.00603
G1 X165.979 Y125.907 E.07309
G1 X166.558 Y126.15 E.02019
G3 X167.877 Y127.184 I-2.679 J4.777 E.05408
G1 X168.294 Y127.816 E.02436
G1 X168.537 Y128.316 E.01788
G1 X168.681 Y128.833 E.01725
G1 X168.783 Y129.592 E.02464
G1 X168.809 Y129.953 E.01162
G3 X168.645 Y131.256 I-6.361 J-.138 E.0423
G3 X168.122 Y132.44 I-5.709 J-1.809 E.04172
G3 X167.756 Y132.919 I-4.036 J-2.716 E.0194
; WIPE_START
G1 X167.359 Y133.324 E-.21552
G1 X166.891 Y133.634 E-.21326
G1 X166.362 Y133.896 E-.22448
G1 X166.087 Y133.957 E-.10675
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.968 Y131.954 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X165.418 Y132.411 E.02299
G1 X164.959 Y132.661 E.0168
G1 X164.215 Y132.896 E.0251
G1 X163.863 Y132.956 E.01147
G3 X159.884 Y133.017 I-2.933 J-61.828 E.12801
G1 X157.926 Y133.015 E.06294
G1 X157.592 Y132.915 E.01122
G1 X157.389 Y132.695 E.00963
G1 X157.316 Y132.405 E.00962
G1 X157.316 Y126.938 E.17579
G1 X157.457 Y126.548 E.01333
G1 X157.611 Y126.415 E.00655
G1 X157.93 Y126.327 E.01063
G1 X159.93 Y126.324 E.06431
G3 X161.909 Y126.322 I1.085 J74.677 E.06364
G1 X162.746 Y126.345 E.02694
; LINE_WIDTH: 0.491974
G1 X163.013 Y126.349 E.00947
; LINE_WIDTH: 0.533957
G1 X163.28 Y126.353 E.01036
; LINE_WIDTH: 0.57594
G1 X163.548 Y126.356 E.01125
; LINE_WIDTH: 0.61273
G1 X163.688 Y126.353 E.00633
G1 X164.125 Y126.434 E.02
; LINE_WIDTH: 0.58534
G1 X164.562 Y126.516 E.01904
; LINE_WIDTH: 0.583925
G1 X164.929 Y126.661 E.01689
; LINE_WIDTH: 0.6099
G1 X165.297 Y126.805 E.0177
G1 X165.315 Y126.838 E.00169
; LINE_WIDTH: 0.570763
G1 X165.333 Y126.872 E.00157
; LINE_WIDTH: 0.531625
G1 X165.35 Y126.905 E.00146
; LINE_WIDTH: 0.492488
G1 X165.368 Y126.938 E.00134
; LINE_WIDTH: 0.45335
G1 X165.785 Y127.265 E.01717
; LINE_WIDTH: 0.44999
G1 X166.188 Y127.717 E.01947
G1 X166.555 Y128.425 E.02564
G1 X166.708 Y128.955 E.01773
G1 X166.778 Y129.671 E.02315
G1 X166.716 Y130.389 E.02317
G1 X166.531 Y131.056 E.02225
G1 X166.153 Y131.713 E.0244
G1 X166.004 Y131.907 E.00783
M204 S10000
G1 X165.708 Y131.641 F30000
G1 F6000
M204 S3000
G1 X165.158 Y132.097 E.02299
G1 X164.688 Y132.342 E.01702
G1 X164.108 Y132.503 E.01936
G1 X163.366 Y132.576 E.02397
G3 X159.878 Y132.61 I-2.359 J-63.267 E.11218
G1 X157.926 Y132.608 E.06276
G1 X157.815 Y132.575 E.00374
G1 X157.726 Y132.44 E.0052
G1 X157.723 Y126.938 E.17693
G1 X157.821 Y126.763 E.00644
G1 X157.93 Y126.734 E.00363
G1 X161.898 Y126.729 E.12757
G3 X164.491 Y126.972 I-.138 J15.416 E.08385
G1 X165.089 Y127.245 E.02116
G1 X165.484 Y127.54 E.01584
G1 X165.881 Y127.984 E.01916
G1 X166.189 Y128.603 E.02222
G1 X166.32 Y129.086 E.01609
G1 X166.373 Y129.706 E.02001
G1 X166.311 Y130.348 E.02074
G1 X166.144 Y130.93 E.0195
G3 X165.743 Y131.592 I-4.919 J-2.53 E.0249
; WIPE_START
G1 X165.158 Y132.097 E-.29373
G1 X164.688 Y132.342 E-.20114
G1 X164.108 Y132.503 E-.22884
G1 X164.013 Y132.513 E-.03629
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.511 Y125.909 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.4657
G1 F6000
M204 S3000
G1 X160.416 Y125.915 E.00318
; LINE_WIDTH: 0.4536
G1 X160.005 Y125.931 E.01334
; LINE_WIDTH: 0.42197
G1 X159.595 Y125.947 E.01231
; LINE_WIDTH: 0.39034
G1 X157.929 Y125.951 E.0457
; LINE_WIDTH: 0.39552
G1 X157.84 Y125.951 E.00248
; WIPE_START
G1 X157.929 Y125.951 E-.03385
G1 X159.595 Y125.947 E-.63279
G1 X159.84 Y125.938 E-.09335
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.794 Y132.466 Z2 F30000
G1 X164.345 Y133.376 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.6295
G1 F6000
M204 S3000
G1 X163.415 Y133.455 E.04326
; LINE_WIDTH: 0.58364
G1 X162.584 Y133.475 E.03549
; LINE_WIDTH: 0.5615
M73 P80 R6
G1 X161.887 Y133.479 E.02854
; LINE_WIDTH: 0.55724
G1 X161.878 Y133.479 E.0004
; LINE_WIDTH: 0.5586
G1 X159.878 Y133.478 E.08147
; LINE_WIDTH: 0.55998
G1 X157.926 Y133.477 E.07972
; WIPE_START
G1 X159.878 Y133.478 E-.74169
G1 X159.926 Y133.478 E-.01831
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X152.293 Y133.464 Z2 F30000
G1 X149.727 Y133.459 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.59598
G1 F6000
M204 S3000
G1 X149.174 Y133.459 E.02416
G1 X149.174 Y133.183 E.01208
G1 X149.174 Y118.541 E.63968
G1 X149.727 Y118.541 E.02416
G1 X149.727 Y133.399 E.64914
M204 S10000
G1 X150.207 Y133.939 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X148.694 Y133.939 E.04866
G1 X148.694 Y133.183 E.02433
G1 X148.694 Y118.061 E.48626
G1 X150.207 Y118.061 E.04866
G1 X150.207 Y133.879 E.50866
M204 S10000
G1 X150.614 Y134.346 F30000
G1 F6000
M204 S3000
G1 X148.287 Y134.346 E.07484
G1 X148.287 Y133.183 E.03742
G1 X148.287 Y117.654 E.49935
G1 X150.614 Y117.654 E.07484
G1 X150.614 Y134.286 E.53484
; WIPE_START
G1 X148.615 Y134.338 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.039 Y130.463 Z2 F30000
G1 X139.43 Y128.925 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.51914
G1 F6000
M204 S3000
G1 X139.078 Y129.82 E.03618
; LINE_WIDTH: 0.49382
G1 X138.346 Y131.682 E.07124
; LINE_WIDTH: 0.46851
G1 X137.982 Y132.609 E.03349
; LINE_WIDTH: 0.46499
G1 X137.887 Y132.834 E.00816
; LINE_WIDTH: 0.49954
G1 X137.783 Y133.047 E.00854
; LINE_WIDTH: 0.53409
G1 X137.679 Y133.26 E.00919
; LINE_WIDTH: 0.56864
G1 X137.575 Y133.473 E.00984
G2 X137.216 Y133.491 I-.089 J1.821 E.01497
; LINE_WIDTH: 0.532627
G1 X137.034 Y133.509 E.00706
; LINE_WIDTH: 0.496614
G1 X136.853 Y133.527 E.00654
; LINE_WIDTH: 0.4606
G1 X136.427 Y133.527 E.01404
; LINE_WIDTH: 0.50164
G1 X136.114 Y133.507 E.01137
; LINE_WIDTH: 0.54268
G1 X135.8 Y133.486 E.01239
G2 X135.645 Y133.146 I-1.648 J.55 E.01479
; LINE_WIDTH: 0.498894
G1 X135.551 Y132.966 E.00733
; LINE_WIDTH: 0.455107
G1 X135.457 Y132.785 E.00663
; LINE_WIDTH: 0.41132
G1 X135.369 Y132.572 E.00671
; LINE_WIDTH: 0.42491
G1 X134.654 Y130.704 E.06035
; LINE_WIDTH: 0.44726
G1 X133.938 Y128.836 E.06388
; LINE_WIDTH: 0.46961
G1 X133.223 Y126.969 E.06741
; LINE_WIDTH: 0.49196
G1 X132.507 Y125.101 E.07094
; LINE_WIDTH: 0.50286
G2 X131.942 Y123.671 I-24.867 J9.004 E.05588
; LINE_WIDTH: 0.476425
G1 X131.725 Y123.151 E.01928
; LINE_WIDTH: 0.485935
G1 X131.534 Y122.609 E.02012
; LINE_WIDTH: 0.52188
G1 X131.342 Y122.067 E.02175
; LINE_WIDTH: 0.54476
G1 X130.626 Y120.199 E.07928
; LINE_WIDTH: 0.56098
G2 X129.982 Y118.523 I-146.695 J55.412 E.07349
G1 X130.543 Y118.523 E.02293
G2 X131.298 Y120.57 I178.938 J-64.92 E.08927
; LINE_WIDTH: 0.53809
G1 X131.79 Y121.898 E.05542
; LINE_WIDTH: 0.53152
G1 X131.875 Y122.087 E.008
G1 X132.138 Y122.285 E.01269
; LINE_WIDTH: 0.490755
G1 X132.401 Y122.483 E.01164
; LINE_WIDTH: 0.44999
G1 X132.78 Y122.556 E.01243
; LINE_WIDTH: 0.487854
G1 X132.982 Y122.575 E.00711
; LINE_WIDTH: 0.525717
G1 X133.183 Y122.594 E.00772
; LINE_WIDTH: 0.56358
G1 X133.384 Y122.613 E.00832
G1 X133.225 Y122.709 E.00763
; LINE_WIDTH: 0.525717
G1 X133.066 Y122.804 E.00707
; LINE_WIDTH: 0.487854
G1 X132.907 Y122.899 E.00652
; LINE_WIDTH: 0.44999
G1 X132.667 Y123.202 E.01243
; LINE_WIDTH: 0.476425
G1 X132.628 Y123.615 E.01421
; LINE_WIDTH: 0.50286
G1 X132.589 Y124.029 E.01508
G1 X133.284 Y125.904 E.07266
; LINE_WIDTH: 0.4805
G1 X133.978 Y127.78 E.06913
; LINE_WIDTH: 0.45815
G1 X134.673 Y129.655 E.0656
; LINE_WIDTH: 0.4358
G1 X135.367 Y131.531 E.06207
; LINE_WIDTH: 0.41345
G1 X135.706 Y132.445 E.02853
; LINE_WIDTH: 0.41132
G1 X135.786 Y132.623 E.00567
; LINE_WIDTH: 0.455107
G1 X135.89 Y132.755 E.00549
; LINE_WIDTH: 0.498894
G1 X135.994 Y132.888 E.00608
; LINE_WIDTH: 0.54268
G1 X136.098 Y133.021 E.00666
G1 X136.281 Y133.067 E.00742
; LINE_WIDTH: 0.50164
G1 X136.463 Y133.112 E.00681
; LINE_WIDTH: 0.4606
G1 X136.677 Y133.123 E.00706
; LINE_WIDTH: 0.490714
G1 X136.867 Y133.08 E.00691
; LINE_WIDTH: 0.529677
G1 X137.058 Y133.036 E.00751
; LINE_WIDTH: 0.56864
G1 X137.249 Y132.993 E.00812
G1 X137.336 Y132.877 E.00604
; LINE_WIDTH: 0.53409
G1 X137.424 Y132.761 E.00565
; LINE_WIDTH: 0.49954
G1 X137.511 Y132.645 E.00525
; LINE_WIDTH: 0.46499
G1 X137.596 Y132.46 E.00678
; LINE_WIDTH: 0.48121
G1 X138.305 Y130.59 E.06924
; LINE_WIDTH: 0.50653
G1 X139.013 Y128.719 E.07324
; LINE_WIDTH: 0.53185
G1 X139.721 Y126.849 E.07724
; LINE_WIDTH: 0.55716
G1 X140.429 Y124.978 E.08124
; LINE_WIDTH: 0.56978
G1 X140.781 Y124.047 E.04146
; LINE_WIDTH: 0.57973
G1 X140.831 Y123.894 E.00679
G1 X140.785 Y123.678 E.00938
; LINE_WIDTH: 0.536484
G1 X140.74 Y123.461 E.00862
; LINE_WIDTH: 0.493237
G1 X140.695 Y123.245 E.00787
; LINE_WIDTH: 0.44999
G1 X140.458 Y122.921 E.01291
; LINE_WIDTH: 0.498705
G1 X140.115 Y122.763 E.01361
; LINE_WIDTH: 0.54742
G1 X139.771 Y122.605 E.01506
G1 X140.185 Y122.581 E.01654
; LINE_WIDTH: 0.498705
G1 X140.6 Y122.556 E.01494
; LINE_WIDTH: 0.44999
G1 X140.993 Y122.477 E.01291
; LINE_WIDTH: 0.493817
G1 X141.199 Y122.294 E.00982
; LINE_WIDTH: 0.537644
G1 X141.405 Y122.111 E.01077
; LINE_WIDTH: 0.58147
G1 X141.611 Y121.927 E.01173
; LINE_WIDTH: 0.59535
G1 X142.335 Y120.063 E.08728
; LINE_WIDTH: 0.60532
G2 X142.924 Y118.545 I-217.454 J-85.224 E.07232
G1 X143.532 Y118.545 E.02704
G2 X142.641 Y120.79 I321.63 J129.013 E.10731
; LINE_WIDTH: 0.59143
G1 X142.112 Y122.124 E.06216
; LINE_WIDTH: 0.58147
G2 X141.985 Y122.5 I3.296 J1.322 E.01689
; LINE_WIDTH: 0.537604
G1 X141.865 Y122.859 E.01478
; LINE_WIDTH: 0.493797
G1 X141.745 Y123.217 E.01347
; LINE_WIDTH: 0.48992
G1 X141.588 Y123.557 E.01322
; LINE_WIDTH: 0.52985
G1 X141.43 Y123.897 E.0144
; LINE_WIDTH: 0.56978
G1 X141.273 Y124.236 E.01558
G1 X140.541 Y126.098 E.08324
; LINE_WIDTH: 0.54446
G1 X139.81 Y127.959 E.07924
; LINE_WIDTH: 0.51914
G1 X139.452 Y128.869 E.0368
M204 S10000
G1 X139.936 Y128.832 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X137.891 Y133.939 E.17691
G1 X135.49 Y133.939 E.07718
G1 X135.096 Y132.926 E.03499
G1 X129.306 Y118.061 E.51297
G1 X130.867 Y118.061 E.0502
G1 X132.206 Y121.747 E.12613
G1 X132.258 Y121.855 E.00385
G1 X132.553 Y122.105 E.01242
G1 X132.78 Y122.149 E.00746
G1 X138.78 Y122.149 E.19293
G1 X140.6 Y122.149 E.05851
G1 X140.836 Y122.102 E.00774
G1 X141.167 Y121.766 E.01516
G1 X142.591 Y118.061 E.12764
G1 X144.249 Y118.061 E.05331
G1 X139.958 Y128.776 E.37117
M204 S10000
G1 X140.314 Y128.983 F30000
G1 F6000
M204 S3000
G1 X138.166 Y134.346 E.18577
G1 X135.212 Y134.346 E.09499
G1 X134.716 Y133.073 E.04393
G1 X128.71 Y117.654 E.53212
G1 X131.152 Y117.654 E.07851
G1 X132.589 Y121.608 E.1353
G1 X132.704 Y121.728 E.00534
G1 X132.78 Y121.742 E.00249
G1 X138.78 Y121.742 E.19293
G2 X140.645 Y121.737 I.494 J-160.024 E.05996
G1 X140.789 Y121.614 E.00608
G1 X142.311 Y117.654 E.13645
G1 X144.85 Y117.654 E.08164
G1 X140.336 Y128.928 E.39051
; WIPE_START
G1 X139.592 Y130.784 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.301 Y129.384 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X137.212 Y132.317 E.10061
G1 X137.159 Y132.426 E.0039
G1 X136.985 Y132.609 E.0081
G1 X136.64 Y132.716 E.01162
G1 X136.329 Y132.631 E.01035
G1 X136.118 Y132.421 E.00956
G1 X136.066 Y132.314 E.00384
G1 X132.996 Y123.88 E.28859
G1 X133.028 Y123.39 E.0158
G1 X133.172 Y123.208 E.00746
G1 X133.465 Y123.07 E.01039
G1 X139.771 Y123.061 E.20279
G1 X140.183 Y123.221 E.01422
G1 X140.326 Y123.415 E.00774
G1 X140.369 Y123.797 E.01235
G1 X140.344 Y123.884 E.00291
G1 X138.322 Y129.328 E.18674
M204 S10000
G1 X137.92 Y129.242 F30000
G1 F6000
M204 S3000
G1 X136.829 Y132.181 E.10079
G1 X136.755 Y132.273 E.0038
G1 X136.605 Y132.305 E.00494
G1 X136.466 Y132.21 E.00541
G1 X136.448 Y132.175 E.00128
G1 X133.379 Y123.741 E.28859
G1 X133.408 Y123.549 E.00626
G1 X133.57 Y123.468 E.00583
G1 X139.771 Y123.468 E.1994
G1 X139.939 Y123.556 E.00608
G1 X139.962 Y123.742 E.00605
G1 X137.941 Y129.186 E.18672
; WIPE_START
G1 X137.244 Y131.061 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P80 R5
G1 X139.43 Y123.748 Z2 F30000
G1 X139.771 Y122.605 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.54742
G1 F6000
M204 S3000
G1 X133.57 Y122.605 E.24713
; LINE_WIDTH: 0.56358
G1 X133.384 Y122.613 E.00764
; WIPE_START
G1 X133.57 Y122.605 E-.07061
G1 X135.384 Y122.605 E-.68939
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.943 Y126.7 Z2 F30000
G1 X118.211 Y133.524 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.46706
G1 F6000
M204 S3000
G1 X117.787 Y133.524 E.01421
G1 X117.787 Y123.894 E.32265
G1 X117.524 Y123.22 E.02424
; LINE_WIDTH: 0.44999
G1 X117.037 Y122.914 E.01847
G1 X115.726 Y122.544 E.04381
G1 X115.151 Y122.551 E.01849
; LINE_WIDTH: 0.46757
G1 X114.575 Y122.987 E.02426
; LINE_WIDTH: 0.47143
G1 X113.528 Y124.692 E.0677
; LINE_WIDTH: 0.47529
G1 X112.481 Y126.396 E.06831
; LINE_WIDTH: 0.47915
G1 X111.434 Y128.1 E.06892
; LINE_WIDTH: 0.48115
G2 X110.413 Y129.795 I48.058 J30.123 E.06851
; LINE_WIDTH: 0.44999
G1 X108.122 Y133.532 E.14095
G1 X106.876 Y133.532 E.04008
G1 X106.876 Y128.77 E.15314
; LINE_WIDTH: 0.46706
G2 X106.884 Y118.476 I-1771.166 J-6.614 E.34488
G1 X107.308 Y118.476 E.01421
G1 X107.308 Y127.834 E.31353
; LINE_WIDTH: 0.47644
G1 X107.319 Y128.012 E.00611
G1 X107.571 Y128.507 E.01901
; LINE_WIDTH: 0.44999
G1 X108.056 Y128.813 E.01845
G1 X108.729 Y129.004 E.0225
G1 X109.364 Y129.185 E.02123
G1 X109.938 Y129.18 E.01844
; LINE_WIDTH: 0.48115
G1 X110.521 Y128.749 E.02511
G1 X111.571 Y127.047 E.06923
; LINE_WIDTH: 0.47728
G1 X112.621 Y125.345 E.06862
; LINE_WIDTH: 0.47342
G1 X113.671 Y123.643 E.06801
; LINE_WIDTH: 0.46956
G1 X114.213 Y122.765 E.03476
; LINE_WIDTH: 0.46757
G1 X114.698 Y121.964 E.03141
; LINE_WIDTH: 0.44999
G1 X116.859 Y118.468 E.13217
G1 X118.22 Y118.468 E.04376
G1 X118.22 Y122.956 E.14434
; LINE_WIDTH: 0.46706
G2 X118.211 Y133.464 I1819.448 J6.752 E.35204
M204 S10000
G1 X118.627 Y133.939 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X117.372 Y133.939 E.04037
G1 X117.372 Y123.894 E.32303
G1 X117.219 Y123.489 E.0139
G1 X116.927 Y123.306 E.01108
G1 X115.615 Y122.936 E.04381
G1 X115.271 Y122.94 E.01109
G1 X114.93 Y123.203 E.01382
G1 X108.35 Y133.939 E.40493
G1 X106.469 Y133.939 E.0605
G1 X106.468 Y118.061 E.51059
G1 X107.724 Y118.061 E.04037
G1 X107.733 Y127.94 E.31767
G1 X107.876 Y128.238 E.01064
G1 X108.168 Y128.422 E.01107
G1 X108.841 Y128.613 E.0225
G1 X109.476 Y128.793 E.02123
G1 X109.82 Y128.79 E.01106
G1 X110.162 Y128.527 E.01388
G1 X116.632 Y118.061 E.39567
G1 X118.627 Y118.061 E.06414
G1 X118.627 Y133.879 E.50866
M204 S10000
G1 X119.034 Y134.346 F30000
G1 F6000
M204 S3000
G1 X116.965 Y134.346 E.06655
G1 X116.965 Y123.894 E.33612
G1 X116.914 Y123.759 E.00463
G1 X116.816 Y123.698 E.00369
G1 X115.505 Y123.328 E.04381
G1 X115.39 Y123.329 E.0037
G1 X115.277 Y123.417 E.00461
G1 X108.578 Y134.346 E.4122
G1 X106.061 Y134.346 E.08092
G1 X106.061 Y117.654 E.53677
G1 X108.131 Y117.654 E.06655
G1 X108.131 Y127.654 E.32156
G2 X108.182 Y127.969 I.443 J.09 E.0105
G1 X108.279 Y128.03 E.00369
G1 X108.952 Y128.221 E.0225
G1 X109.587 Y128.402 E.02123
G1 X109.701 Y128.401 E.00369
G1 X109.816 Y128.313 E.00463
G1 X116.405 Y117.654 E.40297
G1 X119.034 Y117.654 E.08453
G1 X119.034 Y134.286 E.53484
; WIPE_START
G1 X117.035 Y134.344 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.854 Y131.758 Z2 F30000
G1 X100.723 Y128.469 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.63283
G1 F6000
M204 S3000
G1 X100.534 Y129.188 E.03465
; LINE_WIDTH: 0.62067
G1 X100.204 Y129.968 E.03867
; LINE_WIDTH: 0.59124
G1 X99.825 Y130.643 E.03353
; LINE_WIDTH: 0.56226
G1 X99.448 Y131.225 E.02844
; LINE_WIDTH: 0.53958
G1 X99.069 Y131.768 E.02596
; LINE_WIDTH: 0.51729
G1 X98.726 Y132.08 E.01739
; LINE_WIDTH: 0.4763
G1 X98.219 Y132.479 E.02209
; LINE_WIDTH: 0.45443
G1 X97.695 Y132.854 E.02092
; LINE_WIDTH: 0.4326
G1 X97.073 Y133.219 E.02221
; LINE_WIDTH: 0.40773
G1 X96.373 Y133.506 E.02179
; LINE_WIDTH: 0.3762
G1 X95.689 Y133.68 E.0186
; LINE_WIDTH: 0.34916
G1 X95.054 Y133.781 E.01556
; LINE_WIDTH: 0.33419
G1 X94.482 Y133.844 E.01322
; LINE_WIDTH: 0.33107
G1 X93.713 Y133.894 E.01754
; LINE_WIDTH: 0.34423
G1 X93.107 Y133.86 E.01445
; LINE_WIDTH: 0.35585
G1 X92.48 Y133.796 E.01558
; LINE_WIDTH: 0.37215
G1 X91.784 Y133.67 E.0184
; LINE_WIDTH: 0.40083
G1 X91.065 Y133.461 E.02118
; LINE_WIDTH: 0.44987
G1 X90.466 Y133.236 E.02056
G1 X90.453 Y133.23 E.00048
; LINE_WIDTH: 0.48402
G1 X89.969 Y132.965 E.0192
; LINE_WIDTH: 0.51376
G1 X89.503 Y132.663 E.02067
; LINE_WIDTH: 0.52195
G1 X89.078 Y132.318 E.02072
; LINE_WIDTH: 0.52581
G1 X88.647 Y131.914 E.02252
; LINE_WIDTH: 0.56959
G1 X88.254 Y131.43 E.02594
; LINE_WIDTH: 0.60183
G1 X87.897 Y130.933 E.02703
; LINE_WIDTH: 0.61358
G1 X87.594 Y130.417 E.02697
; LINE_WIDTH: 0.62002
G3 X87.177 Y129.454 I3.856 J-2.244 E.04795
; LINE_WIDTH: 0.61774
G1 X87.014 Y128.946 E.02422
; LINE_WIDTH: 0.6313
G1 X86.886 Y128.458 E.02342
; LINE_WIDTH: 0.64155
G1 X86.789 Y127.965 E.02378
; LINE_WIDTH: 0.64477
G1 F5981.557
G1 X86.719 Y127.415 E.02635
; LINE_WIDTH: 0.64618
G1 F5967.576
G1 X86.674 Y126.723 E.03308
; LINE_WIDTH: 0.65149
G1 F5915.507
G3 X86.692 Y125.067 I9.294 J-.725 E.07968
; LINE_WIDTH: 0.64622
G1 F5967.181
G1 X86.77 Y124.22 E.04058
; LINE_WIDTH: 0.64946
G1 F5935.306
G3 X87.082 Y122.759 I7.356 J.808 E.0717
; LINE_WIDTH: 0.64656
G1 F5963.82
G1 X87.385 Y122.043 E.03704
; LINE_WIDTH: 0.62673
G1 F6000
G1 X87.77 Y121.362 E.03609
; LINE_WIDTH: 0.60267
G1 X88.154 Y120.773 E.03107
; LINE_WIDTH: 0.58317
G1 X88.534 Y120.236 E.02808
; LINE_WIDTH: 0.56388
G1 X88.87 Y119.932 E.01865
; LINE_WIDTH: 0.52406
G1 X89.374 Y119.534 E.02442
; LINE_WIDTH: 0.49762
G1 X89.899 Y119.156 E.02323
; LINE_WIDTH: 0.47093
G1 X90.523 Y118.788 E.02449
; LINE_WIDTH: 0.43982
G1 X91.229 Y118.499 E.02391
; LINE_WIDTH: 0.40031
G1 X91.92 Y118.322 E.02015
; LINE_WIDTH: 0.36564
G1 X92.559 Y118.22 E.01649
; LINE_WIDTH: 0.34459
G1 X93.133 Y118.156 E.01376
; LINE_WIDTH: 0.33502
G1 X93.933 Y118.111 E.0185
; LINE_WIDTH: 0.33684
G1 X94.595 Y118.165 E.01542
; LINE_WIDTH: 0.35804
G1 X95.397 Y118.263 E.02012
; LINE_WIDTH: 0.39042
G1 X96.121 Y118.413 E.02028
; LINE_WIDTH: 0.42479
G1 X96.756 Y118.624 E.0202
; LINE_WIDTH: 0.45187
G1 X97.34 Y118.914 E.02105
; LINE_WIDTH: 0.47865
G1 X97.935 Y119.303 E.02448
; LINE_WIDTH: 0.50763
G1 X98.559 Y119.784 E.0289
; LINE_WIDTH: 0.55372
G1 X99.074 Y120.239 E.02773
; LINE_WIDTH: 0.57599
G1 X99.493 Y120.843 E.03095
; LINE_WIDTH: 0.6026
M73 C3
G1 X99.92 Y121.507 E.03491
; LINE_WIDTH: 0.62747
G1 X100.311 Y122.251 E.03879
; LINE_WIDTH: 0.63986
G1 X100.609 Y123.079 E.04151
; LINE_WIDTH: 0.64174
G1 X100.781 Y123.884 E.03893
; LINE_WIDTH: 0.6438
G1 F5991.213
G1 X100.875 Y124.641 E.03622
; LINE_WIDTH: 0.64986
G1 F5931.394
G1 X100.928 Y125.337 E.03347
; LINE_WIDTH: 0.6524
G1 F5906.675
G3 X100.919 Y126.821 I-8.706 J.689 E.07153
; LINE_WIDTH: 0.64447
G1 F5984.54
G1 X100.845 Y127.68 E.04095
; LINE_WIDTH: 0.63792
G1 F6000
G1 X100.732 Y128.41 E.03471
M204 S10000
G1 X100.188 Y128.118 F30000
; LINE_WIDTH: 0.62885
G1 F6000
M204 S3000
G1 X100.03 Y128.854 E.03484
; LINE_WIDTH: 0.6204
G1 X99.77 Y129.602 E.03611
; LINE_WIDTH: 0.60079
G1 X99.455 Y130.24 E.03137
; LINE_WIDTH: 0.57221
G1 X99.058 Y130.915 E.03273
; LINE_WIDTH: 0.54109
G1 X98.676 Y131.502 E.02758
; LINE_WIDTH: 0.51729
G1 X98.274 Y131.896 E.02106
; LINE_WIDTH: 0.4711
G1 X97.673 Y132.386 E.02626
; LINE_WIDTH: 0.44614
G1 X97.109 Y132.777 E.02184
; LINE_WIDTH: 0.42338
G1 X96.57 Y133.063 E.01835
; LINE_WIDTH: 0.40088
G1 X95.986 Y133.281 E.01761
; LINE_WIDTH: 0.37206
G1 X95.299 Y133.444 E.01836
; LINE_WIDTH: 0.34595
G1 X94.517 Y133.552 E.01891
; LINE_WIDTH: 0.33067
G1 X93.898 Y133.605 E.01411
; LINE_WIDTH: 0.34297
G1 X93.169 Y133.563 E.01732
; LINE_WIDTH: 0.35381
G1 X92.604 Y133.498 E.01397
; LINE_WIDTH: 0.3708
G1 X91.99 Y133.384 E.01618
; LINE_WIDTH: 0.3939
G1 X91.356 Y133.192 E.01835
; LINE_WIDTH: 0.418935
G1 X91.026 Y133.044 E.01075
; LINE_WIDTH: 0.44397
G1 X90.696 Y132.896 E.01146
; LINE_WIDTH: 0.48402
G1 X90.208 Y132.595 E.01996
; LINE_WIDTH: 0.51376
G1 X89.798 Y132.296 E.01887
; LINE_WIDTH: 0.52195
G1 X89.399 Y131.962 E.0197
; LINE_WIDTH: 0.52581
G1 X89.019 Y131.606 E.01987
; LINE_WIDTH: 0.56959
G1 X88.686 Y131.13 E.02417
; LINE_WIDTH: 0.60183
G1 X88.378 Y130.649 E.02522
; LINE_WIDTH: 0.60722
G1 X88.168 Y130.286 E.01866
; LINE_WIDTH: 0.62002
G1 X87.876 Y129.697 E.02999
G1 X87.613 Y128.954 E.03596
; LINE_WIDTH: 0.6313
G1 X87.457 Y128.318 E.03042
; LINE_WIDTH: 0.64474
G1 F5981.855
G1 X87.325 Y127.437 E.04232
; LINE_WIDTH: 0.64639
G1 F5965.5
G1 X87.278 Y126.733 E.03364
; LINE_WIDTH: 0.64758
G1 F5953.76
G3 X87.28 Y125.316 I9.877 J-.692 E.06773
; LINE_WIDTH: 0.64546
G1 F5974.707
G1 X87.328 Y124.645 E.03206
; LINE_WIDTH: 0.64075
G1 F6000
G1 X87.419 Y123.93 E.03402
; LINE_WIDTH: 0.64121
G1 X87.581 Y123.186 E.03597
G1 X87.849 Y122.432 E.03781
; LINE_WIDTH: 0.6315
G1 X88.192 Y121.749 E.03553
; LINE_WIDTH: 0.6089
G1 X88.577 Y121.114 E.0332
; LINE_WIDTH: 0.58416
G1 X88.964 Y120.531 E.02994
; LINE_WIDTH: 0.56388
G1 X89.36 Y120.142 E.02283
; LINE_WIDTH: 0.51679
G1 X89.956 Y119.648 E.02897
; LINE_WIDTH: 0.48585
G1 X90.512 Y119.255 E.02383
; LINE_WIDTH: 0.45728
G1 X91.045 Y118.966 E.01985
; LINE_WIDTH: 0.42858
G1 X91.624 Y118.743 E.01889
; LINE_WIDTH: 0.39292
G1 X92.308 Y118.571 E.01952
; LINE_WIDTH: 0.35939
G1 X93.091 Y118.455 E.01977
; LINE_WIDTH: 0.33699
G1 X93.723 Y118.396 E.01475
; LINE_WIDTH: 0.33438
G1 X94.472 Y118.446 E.01728
; LINE_WIDTH: 0.343
G1 X95.032 Y118.517 E.01337
; LINE_WIDTH: 0.36309
G1 X95.641 Y118.636 E.01571
; LINE_WIDTH: 0.39655
G1 X96.284 Y118.834 E.01878
; LINE_WIDTH: 0.43448
G1 X96.92 Y119.138 E.02182
; LINE_WIDTH: 0.464
G1 X97.483 Y119.507 E.02236
; LINE_WIDTH: 0.48925
G1 X97.961 Y119.885 E.02151
; LINE_WIDTH: 0.51422
G1 X98.434 Y120.292 E.02323
; LINE_WIDTH: 0.55372
G1 X98.651 Y120.525 E.01284
; LINE_WIDTH: 0.5748
G1 X99.016 Y121.084 E.02807
; LINE_WIDTH: 0.5962
G1 X99.375 Y121.679 E.03035
; LINE_WIDTH: 0.62222
G1 X99.714 Y122.344 E.03416
; LINE_WIDTH: 0.64428
G1 F5986.431
G1 X99.969 Y123.017 E.03422
; LINE_WIDTH: 0.64933
G1 F5936.578
G3 X100.241 Y124.369 I-7.494 J2.21 E.06611
; LINE_WIDTH: 0.65021
G1 F5927.975
G1 X100.311 Y125.187 E.03942
; LINE_WIDTH: 0.65677
G1 F5864.625
G3 X100.321 Y126.744 I-9.844 J.84 E.07555
; LINE_WIDTH: 0.64473
G1 F5981.955
G1 X100.276 Y127.41 E.03174
; LINE_WIDTH: 0.63584
G1 F6000
G1 X100.196 Y128.059 E.03062
M204 S10000
G1 X99.691 Y128.057 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G3 X99.314 Y129.444 I-7.533 J-1.303 E.04626
G3 X98.303 Y131.268 I-12.597 J-5.79 E.06715
G1 X97.999 Y131.582 E.01403
G1 X97.418 Y132.072 E.02444
G3 X95.871 Y132.931 I-3.333 J-4.177 E.05717
G3 X93.869 Y133.261 I-2.525 J-9.095 E.06536
G1 X93.2 Y133.211 E.02157
G3 X91.476 Y132.832 I.62 J-6.935 E.05689
G1 X90.881 Y132.536 E.02138
G3 X89.445 Y131.412 I6.303 J-9.53 E.05869
G3 X88.606 Y130.075 I12.099 J-8.528 E.0508
G3 X88.074 Y128.793 I5.587 J-3.066 E.04473
G1 X87.944 Y128.212 E.01913
G3 X87.829 Y124.679 I13.656 J-2.21 E.11399
G3 X88.317 Y122.601 I7.53 J.672 E.06886
G3 X89.354 Y120.781 I12.251 J5.776 E.0674
G1 X89.912 Y120.238 E.02504
G3 X91.749 Y119.1 I3.914 J4.264 E.0699
G3 X93.757 Y118.74 I2.633 J8.905 E.06573
G1 X94.438 Y118.794 E.02198
G3 X96.158 Y119.193 I-.67 J6.788 E.05694
G1 X96.733 Y119.491 E.0208
G3 X98.14 Y120.618 I-5.843 J8.732 E.05806
G3 X98.959 Y121.92 I-10.018 J7.215 E.04948
G3 X99.631 Y123.752 I-6.062 J3.262 E.06296
G3 X99.777 Y127.379 I-14.16 J2.385 E.11704
G3 X99.701 Y127.998 I-7.62 J-.624 E.02007
M204 S10000
G1 X99.287 Y128.008 F30000
G1 F6000
M204 S3000
G3 X98.929 Y129.311 I-7.044 J-1.234 E.04349
G3 X97.958 Y131.052 I-12.434 J-5.795 E.06418
G3 X97.041 Y131.853 I-6.518 J-6.536 E.03915
G3 X95.503 Y132.624 I-2.841 J-3.746 E.05566
G3 X93.834 Y132.855 I-2.289 J-10.398 E.05423
G3 X92.699 Y132.738 I.82 J-13.531 E.03669
G3 X91.067 Y132.174 I.736 J-4.777 E.05583
G3 X89.714 Y131.107 I5.68 J-8.589 E.05547
G3 X88.972 Y129.898 I17.363 J-11.491 E.04563
G3 X88.459 Y128.658 I5.222 J-2.889 E.04323
G3 X88.236 Y124.707 I11.89 J-2.654 E.12784
G3 X88.7 Y122.739 I7.038 J.624 E.06524
G3 X89.696 Y121.002 I12.053 J5.757 E.06445
G3 X90.598 Y120.197 I6.888 J6.806 E.03888
G3 X92.124 Y119.4 I2.924 J3.74 E.05566
G3 X93.797 Y119.145 I2.405 J10.165 E.05449
G3 X94.93 Y119.271 I-.864 J12.905 E.03666
G3 X96.542 Y119.85 I-.772 J4.683 E.05539
G3 X97.868 Y120.921 I-5.793 J8.53 E.05487
G3 X98.607 Y122.124 I-12.634 J8.594 E.04543
G3 X99.233 Y123.839 I-5.605 J3.019 E.05889
G3 X99.371 Y127.354 I-13.791 J2.298 E.11342
G3 X99.297 Y127.949 I-7.128 J-.58 E.0193
; WIPE_START
G1 X99.151 Y128.665 E-.27749
G1 X98.929 Y129.311 E-.25947
G1 X98.676 Y129.84 E-.22304
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.215 Y128.557 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S3000
G1 X101.015 Y129.315 E.02523
G1 X100.719 Y130.027 E.02479
G3 X99.372 Y132.101 I-14.601 J-8.011 E.07957
G3 X97.496 Y133.448 I-9.855 J-11.74 E.07436
G1 X96.852 Y133.749 E.02284
G3 X95.402 Y134.094 I-2.27 J-6.302 E.04801
G3 X93.765 Y134.245 I-2.969 J-23.373 E.05288
G3 X91.993 Y134.101 I.121 J-12.502 E.05723
G3 X90.309 Y133.613 I2.263 J-10.958 E.05643
G3 X87.897 Y131.732 I2.607 J-5.829 E.0993
G3 X86.876 Y130.089 I6.416 J-5.128 E.06237
G3 X86.223 Y127.545 I10.324 J-4.004 E.08465
G3 X86.137 Y125.9 I18.501 J-1.798 E.05297
G3 X86.396 Y123.357 I19.569 J.71 E.08227
G1 X86.595 Y122.614 E.02475
G1 X86.888 Y121.916 E.02433
G3 X88.217 Y119.884 I14.378 J7.953 E.07816
G3 X90.1 Y118.541 I9.787 J11.733 E.07443
G1 X90.746 Y118.243 E.02289
G3 X92.201 Y117.901 I2.262 J6.367 E.04816
G3 X93.828 Y117.756 I2.897 J23.342 E.05252
G3 X96.2 Y118.043 I-.858 J17.076 E.0769
G1 X96.885 Y118.249 E.02299
G3 X98.166 Y118.95 I-2.209 J5.56 E.04708
G3 X99.389 Y119.892 I-11.703 J16.455 E.04966
G3 X100.724 Y121.953 I-13.239 J10.039 E.07902
G1 X101.017 Y122.66 E.02462
G3 X101.345 Y124.233 I-7.473 J2.376 E.05174
G3 X101.472 Y125.976 I-26.838 J2.843 E.05621
G3 X101.225 Y128.497 I-19.969 J-.688 E.08153
M204 S10000
G1 X101.614 Y128.64 F30000
G1 F6000
M204 S3000
G1 X101.401 Y129.446 E.02679
G1 X101.086 Y130.206 E.02646
G3 X99.669 Y132.384 I-15.181 J-8.321 E.08362
G3 X97.69 Y133.807 I-10.293 J-12.23 E.07846
G1 X96.997 Y134.13 E.02459
G3 X95.461 Y134.498 I-2.41 J-6.678 E.05089
G3 X93.771 Y134.652 I-3.062 J-24.128 E.05459
G3 X91.92 Y134.502 I.126 J-13.055 E.05977
G3 X90.152 Y133.99 I2.377 J-11.503 E.05924
G3 X87.582 Y131.99 I2.782 J-6.227 E.10573
G3 X86.5 Y130.249 I6.788 J-5.424 E.06606
G3 X85.819 Y127.589 I10.765 J-4.177 E.0885
G3 X85.729 Y125.896 I19.05 J-1.854 E.05454
G3 X85.997 Y123.272 I20.092 J.728 E.08488
G1 X86.209 Y122.482 E.02631
G1 X86.522 Y121.736 E.026
G3 X87.921 Y119.599 I14.958 J8.264 E.0822
G3 X89.907 Y118.182 I10.222 J12.223 E.07854
G1 X90.603 Y117.861 E.02464
G3 X92.144 Y117.498 I2.402 J6.746 E.05102
G3 X93.829 Y117.348 I2.996 J24.174 E.05439
G3 X96.296 Y117.646 I-.88 J17.635 E.07998
G1 X97.031 Y117.868 E.02468
G1 X97.72 Y118.19 E.02447
G3 X99.687 Y119.609 I-8.261 J13.523 E.07808
G3 X101.091 Y121.774 I-13.752 J10.454 E.08306
G1 X101.404 Y122.529 E.02628
G3 X101.749 Y124.183 I-7.856 J2.502 E.05441
G3 X101.88 Y125.976 I-27.607 J2.921 E.05781
G3 X101.624 Y128.581 I-20.505 J-.703 E.08425
; WIPE_START
G1 X101.401 Y129.446 E-.33929
G1 X101.086 Y130.206 E-.3127
G1 X100.946 Y130.454 E-.10801
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.455 Y131.819 Z2 F30000
G1 X179.79 Y144.79 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X79.087 Y144.79 E2.99952
G1 X76.21 Y141.913 E.12119
G1 X76.21 Y107.21 E1.03366
G1 X179.79 Y107.21 E3.08522
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

G1 X179.79 Y126 E.55968
G1 X179.79 Y144.73 E.55789
M204 S10000
G1 X179.007 Y144.583 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X179.583 Y144.007 E.02423
G1 X179.583 Y143.474
G1 X178.474 Y144.583 E.04669
G1 X177.941 Y144.583
G1 X179.583 Y142.941 E.06916
G1 X179.583 Y142.408
G1 X177.408 Y144.583 E.09162
G1 X176.874 Y144.583
G1 X179.583 Y141.874 E.11408
G1 X179.583 Y141.341
G1 X176.341 Y144.583 E.13655
G1 X175.808 Y144.583
G1 X179.583 Y140.808 E.15901
G1 X179.583 Y140.275
G1 X175.275 Y144.583 E.18147
G1 X174.741 Y144.583
G1 X179.583 Y139.741 E.20394
G1 X179.583 Y139.208
G1 X174.208 Y144.583 E.2264
G1 X173.675 Y144.583
G1 X179.583 Y138.675 E.24886
G1 X179.583 Y138.142
G1 X173.142 Y144.583 E.27133
G1 X172.608 Y144.583
G1 X179.583 Y137.608 E.29379
G1 X179.583 Y137.075
G1 X172.075 Y144.583 E.31625
G1 X171.542 Y144.583
G1 X179.583 Y136.542 E.33872
G1 X179.583 Y136.009
G1 X171.009 Y144.583 E.36118
G1 X170.475 Y144.583
G1 X179.583 Y135.475 E.38364
G1 X179.583 Y134.942
G1 X169.942 Y144.583 E.40611
G1 X169.409 Y144.583
G1 X179.583 Y134.409 E.42857
G1 X179.583 Y133.876
G1 X168.876 Y144.583 E.45103
G1 X168.342 Y144.583
G1 X179.583 Y133.342 E.4735
G1 X179.583 Y132.809
G1 X167.809 Y144.583 E.49596
G1 X167.276 Y144.583
G1 X179.583 Y132.276 E.51842
G1 X179.583 Y131.742
G1 X166.742 Y144.583 E.54089
G1 X166.209 Y144.583
G1 X179.583 Y131.209 E.56335
G1 X179.583 Y130.676
G1 X165.676 Y144.583 E.58581
G1 X165.143 Y144.583
G1 X179.583 Y130.143 E.60828
G1 X179.583 Y129.609
G1 X164.609 Y144.583 E.63074
G1 X164.076 Y144.583
G1 X179.583 Y129.076 E.6532
G1 X179.583 Y128.543
G1 X163.543 Y144.583 E.67566
G1 X163.01 Y144.583
G1 X179.583 Y128.01 E.69813
G1 X179.583 Y127.476
G1 X162.476 Y144.583 E.72059
G1 X161.943 Y144.583
G1 X179.583 Y126.943 E.74305
G1 X179.583 Y126.41
G1 X161.41 Y144.583 E.76552
G1 X160.877 Y144.583
G1 X179.583 Y125.877 E.78798
G1 X179.583 Y125.343
G1 X160.343 Y144.583 E.81044
G1 X159.81 Y144.583
G1 X179.583 Y124.81 E.83291
G1 X179.583 Y124.277
G1 X159.277 Y144.583 E.85537
G1 X158.744 Y144.583
G1 X179.583 Y123.744 E.87783
G1 X179.583 Y123.21
G1 X158.21 Y144.583 E.9003
G1 X157.677 Y144.583
G1 X179.583 Y122.677 E.92276
G1 X179.583 Y122.144
G1 X157.144 Y144.583 E.94522
G1 X156.611 Y144.583
G1 X179.583 Y121.611 E.96769
G1 X179.583 Y121.077
G1 X168.527 Y132.133 E.46571
G1 X168.874 Y131.253
G1 X179.583 Y120.544 E.45111
G1 X179.583 Y120.011
G1 X168.982 Y130.611 E.44654
G1 X169.025 Y130.035
G1 X179.583 Y119.478 E.44472
M73 P81 R5
G1 X179.583 Y118.944
G1 X168.995 Y129.532 E.44602
G1 X168.948 Y129.046
G1 X179.583 Y118.411 E.448
G1 X179.583 Y117.878
G1 X168.862 Y128.598 E.4516
G1 X168.736 Y128.191
G1 X179.583 Y117.345 E.45692
G1 X179.583 Y116.811
G1 X168.557 Y127.837 E.46446
G1 X168.362 Y127.498
G1 X179.583 Y116.278 E.47265
G1 X179.583 Y115.745
G1 X168.145 Y127.182 E.48179
G1 X167.919 Y126.875
G1 X179.583 Y115.212 E.49131
G1 X179.583 Y114.678
G1 X167.625 Y126.636 E.50372
G1 X167.33 Y126.397
G1 X179.583 Y114.145 E.51613
G1 X179.583 Y113.612
G1 X167.02 Y126.175 E.52921
G1 X166.687 Y125.974
G1 X179.583 Y113.078 E.54321
G1 X179.583 Y112.545
G1 X166.326 Y125.802 E.55845
G1 X165.932 Y125.663
G1 X179.583 Y112.012 E.57503
G1 X179.583 Y111.479
G1 X165.517 Y125.544 E.59251
G1 X165.102 Y125.426
G1 X179.583 Y110.945 E.60999
G1 X179.583 Y110.412
G1 X164.687 Y125.308 E.62747
G1 X164.272 Y125.19
G1 X165.917 Y123.544 E.0693
G1 X166.424 Y123.038
G1 X179.583 Y109.879 E.5543
G1 X179.583 Y109.346
G1 X167.886 Y121.042 E.4927
; WIPE_START
M204 S3000
G1 X169.301 Y119.628 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X168.779 Y119.616 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X179.583 Y108.812 E.4551
G1 X179.583 Y108.279
G1 X170.881 Y116.981 E.36656
G1 X170.846 Y117.015
G1 X169.671 Y118.191 E.04951
G1 X169.897 Y117.431
G1 X179.583 Y107.746 E.40799
G1 X179.378 Y107.417
G1 X169.364 Y117.431 E.42183
G1 X168.831 Y117.431
G1 X178.845 Y107.417 E.42183
G1 X178.311 Y107.417
G1 X168.298 Y117.431 E.42183
G1 X167.764 Y117.431
G1 X177.778 Y107.417 E.42183
G1 X177.245 Y107.417
G1 X167.231 Y117.431 E.42183
; WIPE_START
M204 S3000
G1 X168.645 Y116.017 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.802 Y121.916 Z2 F30000
G1 X163.749 Y121.98 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X160.985 Y124.744 E.11644
G1 X160.321 Y124.875
G1 X164.844 Y120.351 E.19056
; WIPE_START
M204 S3000
G1 X163.43 Y121.765 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.94 Y118.722 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X159.738 Y124.924 E.26124
G1 X159.186 Y124.943
G1 X176.712 Y107.417 E.73826
G1 X176.178 Y107.417
G1 X158.65 Y124.945 E.73836
G1 X158.117 Y124.945
G1 X175.645 Y107.417 E.73836
G1 X175.112 Y107.417
M73 P82 R5
G1 X157.945 Y124.584 E.72313
G1 X157.945 Y124.051
G1 X174.579 Y107.417 E.70067
G1 X174.045 Y107.417
G1 X157.945 Y123.517 E.6782
G1 X157.945 Y122.984
G1 X173.512 Y107.417 E.65574
G1 X172.979 Y107.417
G1 X157.945 Y122.451 E.63328
G1 X157.945 Y121.918
G1 X172.446 Y107.417 E.61081
G1 X171.912 Y107.417
G1 X157.945 Y121.384 E.58835
G1 X157.945 Y120.851
G1 X171.379 Y107.417 E.56589
G1 X170.846 Y107.417
G1 X157.945 Y120.318 E.54342
G1 X157.945 Y119.785
G1 X170.313 Y107.417 E.52096
G1 X169.779 Y107.417
G1 X157.945 Y119.251 E.4985
G1 X157.945 Y118.718
G1 X169.246 Y107.417 E.47603
G1 X168.713 Y107.417
G1 X157.945 Y118.185 E.45357
G1 X157.945 Y117.651
G1 X168.179 Y107.417 E.43111
G1 X167.646 Y107.417
G1 X157.632 Y117.431 E.42183
G1 X157.099 Y117.431
G1 X167.113 Y107.417 E.42183
G1 X166.58 Y107.417
G1 X156.566 Y117.431 E.42183
G1 X156.033 Y117.431
G1 X166.046 Y107.417 E.42183
G1 X165.513 Y107.417
G1 X155.499 Y117.431 E.42183
; WIPE_START
M204 S3000
G1 X156.914 Y116.017 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.554 Y122.725 Z2 F30000
G1 X166.667 Y133.993 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X156.077 Y144.583 E.4461
G1 X155.544 Y144.583
G1 X165.891 Y134.235 E.43587
G1 X165.21 Y134.384
G1 X155.011 Y144.583 E.42962
G1 X154.478 Y144.583
G1 X164.579 Y134.481 E.42553
G1 X164.003 Y134.524
G1 X153.944 Y144.583 E.4237
G1 X153.411 Y144.583
G1 X163.435 Y134.559 E.42226
G1 X162.897 Y134.564
G1 X152.878 Y144.583 E.42204
G1 X152.345 Y144.583
G1 X162.358 Y134.569 E.42183
G1 X161.825 Y134.569
G1 X151.811 Y144.583 E.42183
G1 X151.278 Y144.583
G1 X161.292 Y134.569 E.42183
G1 X160.759 Y134.569
G1 X150.745 Y144.583 E.42183
G1 X150.212 Y144.583
G1 X160.225 Y134.569 E.42183
G1 X159.692 Y134.569
G1 X149.678 Y144.583 E.42183
G1 X149.145 Y144.583
G1 X159.159 Y134.569 E.42183
G1 X158.626 Y134.569
G1 X148.612 Y144.583 E.42183
G1 X148.078 Y144.583
G1 X158.092 Y134.569 E.42183
G1 X157.559 Y134.569
G1 X147.545 Y144.583 E.42183
G1 X147.012 Y144.583
G1 X157.026 Y134.569 E.42183
G1 X156.492 Y134.569
G1 X146.479 Y144.583 E.42183
G1 X145.945 Y144.583
G1 X155.959 Y134.569 E.42183
G1 X155.426 Y134.569
G1 X145.412 Y144.583 E.42183
G1 X144.879 Y144.583
G1 X155.173 Y134.288 E.43365
G1 X155.173 Y133.755
G1 X144.346 Y144.583 E.45611
G1 X143.812 Y144.583
G1 X155.173 Y133.222 E.47857
G1 X155.173 Y132.689
G1 X143.279 Y144.583 E.50104
G1 X142.746 Y144.583
G1 X155.173 Y132.155 E.5235
G1 X155.173 Y131.622
G1 X142.213 Y144.583 E.54596
G1 X141.679 Y144.583
G1 X155.173 Y131.089 E.56842
G1 X155.173 Y130.555
G1 X141.146 Y144.583 E.59089
G1 X140.613 Y144.583
G1 X150.627 Y134.569 E.42183
G1 X150.093 Y134.569
M73 P83 R5
G1 X140.08 Y144.583 E.42183
G1 X139.546 Y144.583
G1 X149.56 Y134.569 E.42183
G1 X149.027 Y134.569
G1 X139.013 Y144.583 E.42183
G1 X138.48 Y144.583
G1 X148.494 Y134.569 E.42183
G1 X148.064 Y134.465
G1 X137.947 Y144.583 E.4262
G1 X137.413 Y144.583
G1 X148.064 Y133.932 E.44866
G1 X148.064 Y133.399
G1 X136.88 Y144.583 E.47112
G1 X136.347 Y144.583
G1 X148.064 Y132.865 E.49359
G1 X148.064 Y132.332
G1 X135.814 Y144.583 E.51605
G1 X135.28 Y144.583
G1 X148.064 Y131.799 E.53851
G1 X148.064 Y131.266
G1 X134.747 Y144.583 E.56098
G1 X134.214 Y144.583
G1 X148.064 Y130.732 E.58344
G1 X148.064 Y130.199
G1 X133.681 Y144.583 E.6059
G1 X133.147 Y144.583
G1 X148.064 Y129.666 E.62837
G1 X148.064 Y129.132
G1 X132.614 Y144.583 E.65083
G1 X132.081 Y144.583
G1 X148.064 Y128.599 E.67329
G1 X148.064 Y128.066
G1 X131.547 Y144.583 E.69576
G1 X131.014 Y144.583
G1 X148.064 Y127.533 E.71822
G1 X148.064 Y126.999
G1 X130.481 Y144.583 E.74068
G1 X129.948 Y144.583
G1 X148.064 Y126.466 E.76315
G1 X148.064 Y125.933
G1 X129.414 Y144.583 E.78561
G1 X128.881 Y144.583
G1 X148.064 Y125.4 E.80807
G1 X148.064 Y124.866
G1 X128.348 Y144.583 E.83054
G1 X127.815 Y144.583
G1 X137.828 Y134.569 E.42183
G1 X137.295 Y134.569
G1 X127.281 Y144.583 E.42183
G1 X126.748 Y144.583
G1 X136.762 Y134.569 E.42183
G1 X136.229 Y134.569
G1 X126.215 Y144.583 E.42183
G1 X125.682 Y144.583
M73 P83 R4
G1 X135.695 Y134.569 E.42183
G1 X135.162 Y134.569
G1 X125.148 Y144.583 E.42183
G1 X124.615 Y144.583
G1 X134.939 Y134.259 E.4349
G1 X134.79 Y133.875
G1 X124.082 Y144.583 E.45106
G1 X123.549 Y144.583
G1 X134.64 Y133.491 E.46723
G1 X134.491 Y133.107
G1 X123.015 Y144.583 E.4834
G1 X122.482 Y144.583
G1 X134.341 Y132.723 E.49956
G1 X134.192 Y132.34
G1 X121.949 Y144.583 E.51573
G1 X121.416 Y144.583
G1 X134.042 Y131.956 E.5319
G1 X133.893 Y131.572
G1 X120.882 Y144.583 E.54806
G1 X120.349 Y144.583
G1 X133.743 Y131.188 E.56423
G1 X133.594 Y130.805
G1 X119.816 Y144.583 E.5804
G1 X119.283 Y144.583
G1 X133.444 Y130.421 E.59656
G1 X133.295 Y130.037
G1 X118.749 Y144.583 E.61273
G1 X118.216 Y144.583
G1 X133.145 Y129.653 E.6289
G1 X132.996 Y129.269
G1 X117.683 Y144.583 E.64506
G1 X117.15 Y144.583
M73 C2
G1 X132.847 Y128.886 E.66123
G1 X132.697 Y128.502
G1 X116.616 Y144.583 E.6774
G1 X116.083 Y144.583
G1 X132.548 Y128.118 E.69356
G1 X132.398 Y127.734
G1 X115.55 Y144.583 E.70973
G1 X115.017 Y144.583
G1 X132.249 Y127.351 E.72589
G1 X132.099 Y126.967
G1 X114.483 Y144.583 E.74206
G1 X113.95 Y144.583
G1 X131.95 Y126.583 E.75823
G1 X131.8 Y126.199
M73 P84 R4
G1 X113.417 Y144.583 E.77439
G1 X112.883 Y144.583
G1 X131.651 Y125.815 E.79056
G1 X131.501 Y125.432
G1 X112.35 Y144.583 E.80673
G1 X111.817 Y144.583
G1 X131.352 Y125.048 E.82289
G1 X131.202 Y124.664
G1 X111.284 Y144.583 E.83906
G1 X110.75 Y144.583
G1 X131.053 Y124.28 E.85523
G1 X130.903 Y123.897
G1 X110.217 Y144.583 E.87139
G1 X109.684 Y144.583
G1 X130.754 Y123.513 E.88756
G1 X130.604 Y123.129
G1 X119.256 Y134.477 E.47802
G1 X119.256 Y133.944
G1 X130.455 Y122.745 E.47173
G1 X130.305 Y122.361
G1 X119.256 Y133.41 E.46543
G1 X119.256 Y132.877
G1 X130.156 Y121.978 E.45913
G1 X130.006 Y121.594
G1 X119.256 Y132.344 E.45284
G1 X119.256 Y131.811
G1 X129.857 Y121.21 E.44654
G1 X129.707 Y120.826
G1 X119.256 Y131.277 E.44024
G1 X119.256 Y130.744
G1 X129.558 Y120.443 E.43395
G1 X129.408 Y120.059
G1 X119.256 Y130.211 E.42765
G1 X119.256 Y129.678
G1 X129.259 Y119.675 E.42135
G1 X129.11 Y119.291
G1 X119.256 Y129.144 E.41506
G1 X119.256 Y128.611
G1 X128.96 Y118.907 E.40876
G1 X128.811 Y118.524
G1 X119.256 Y128.078 E.40246
G1 X119.256 Y127.545
G1 X128.661 Y118.14 E.39617
G1 X128.512 Y117.756
G1 X119.256 Y127.011 E.38987
; WIPE_START
M204 S3000
G1 X120.671 Y125.597 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.407 Y133.124 Z2 F30000
G1 X119.164 Y134.569 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X109.151 Y144.583 E.42183
G1 X108.617 Y144.583
G1 X118.631 Y134.569 E.42183
G1 X118.098 Y134.569
G1 X108.084 Y144.583 E.42183
G1 X107.551 Y144.583
G1 X117.565 Y134.569 E.42183
G1 X117.031 Y134.569
G1 X107.018 Y144.583 E.42183
G1 X106.484 Y144.583
G1 X116.742 Y134.325 E.43211
G1 X116.742 Y133.792
G1 X105.951 Y144.583 E.45457
G1 X105.418 Y144.583
G1 X116.742 Y133.258 E.47703
G1 X116.742 Y132.725
G1 X104.885 Y144.583 E.4995
G1 X104.351 Y144.583
G1 X116.742 Y132.192 E.52196
G1 X116.742 Y131.659
G1 X103.818 Y144.583 E.54442
G1 X103.285 Y144.583
G1 X116.742 Y131.125 E.56689
G1 X116.742 Y130.592
G1 X102.752 Y144.583 E.58935
G1 X102.218 Y144.583
G1 X116.742 Y130.059 E.61181
G1 X116.742 Y129.526
G1 X101.685 Y144.583 E.63427
G1 X101.152 Y144.583
M73 P85 R4
G1 X116.742 Y128.992 E.65674
G1 X116.742 Y128.459
G1 X100.619 Y144.583 E.6792
G1 X100.085 Y144.583
G1 X116.742 Y127.926 E.70166
G1 X116.742 Y127.392
G1 X99.552 Y144.583 E.72413
G1 X99.019 Y144.583
G1 X116.742 Y126.859 E.74659
G1 X116.742 Y126.326
G1 X109.025 Y134.044 E.3251
; WIPE_START
M204 S3000
G1 X110.439 Y132.629 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.869 Y132.666 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X116.742 Y125.793 E.28954
G1 X116.742 Y125.259
G1 X110.713 Y131.289 E.25398
; WIPE_START
M204 S3000
G1 X112.127 Y129.874 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.557 Y129.911 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X116.742 Y124.726 E.21842
G1 X116.742 Y124.193
G1 X112.401 Y128.534 E.18285
; WIPE_START
M204 S3000
G1 X113.816 Y127.12 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.246 Y127.156 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X116.549 Y123.853 E.13914
G1 X116.133 Y123.736
G1 X114.09 Y125.779 E.08605
; WIPE_START
M204 S3000
G1 X115.504 Y124.365 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.934 Y124.401 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X115.717 Y123.619 E.03297
; WIPE_START
M204 S3000
G1 X114.934 Y124.401 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.63 Y126.572 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X109.155 Y128.048 E.06217
G1 X108.739 Y127.93
G1 X111.494 Y125.175 E.11604
; WIPE_START
M204 S3000
G1 X110.08 Y126.589 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.357 Y123.778 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X108.353 Y127.782 E.16867
G1 X108.353 Y127.249
G1 X113.221 Y122.382 E.20504
; WIPE_START
M204 S3000
G1 X111.807 Y123.796 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.084 Y120.985 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X108.353 Y126.716 E.24141
G1 X108.353 Y126.183
G1 X114.948 Y119.588 E.27778
; WIPE_START
M204 S3000
G1 X113.533 Y121.003 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.811 Y118.192 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X108.353 Y125.649 E.31416
; WIPE_START
M204 S3000
G1 X109.768 Y124.235 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.838 Y131.811 Z2 F30000
G1 X108.499 Y134.569 Z2
G1 Z1.6
M73 P86 R4
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X98.486 Y144.583 E.42183
G1 X97.952 Y144.583
G1 X107.966 Y134.569 E.42183
G1 X107.433 Y134.569
G1 X97.419 Y144.583 E.42183
G1 X96.886 Y144.583
G1 X106.9 Y134.569 E.42183
G1 X106.366 Y134.569
G1 X96.352 Y144.583 E.42183
G1 X95.819 Y144.583
G1 X105.839 Y134.563 E.42208
G1 X105.839 Y134.03
G1 X95.286 Y144.583 E.44454
G1 X94.753 Y144.583
G1 X105.839 Y133.496 E.46701
G1 X105.839 Y132.963
G1 X94.219 Y144.583 E.48947
G1 X93.686 Y144.583
G1 X105.839 Y132.43 E.51193
G1 X105.839 Y131.897
G1 X93.153 Y144.583 E.5344
G1 X92.62 Y144.583
G1 X105.839 Y131.363 E.55686
G1 X105.839 Y130.83
G1 X92.086 Y144.583 E.57932
G1 X91.553 Y144.583
G1 X105.839 Y130.297 E.60179
G1 X105.839 Y129.764
G1 X91.02 Y144.583 E.62425
G1 X90.487 Y144.583
G1 X105.839 Y129.23 E.64671
G1 X105.839 Y128.697
G1 X89.953 Y144.583 E.66918
G1 X89.42 Y144.583
G1 X105.839 Y128.164 E.69164
G1 X105.839 Y127.63
G1 X88.887 Y144.583 E.7141
G1 X88.354 Y144.583
G1 X105.839 Y127.097 E.73657
G1 X105.839 Y126.564
G1 X87.82 Y144.583 E.75903
G1 X87.287 Y144.583
G1 X97.969 Y133.901 E.44997
G1 X96.958 Y134.378
G1 X86.754 Y144.583 E.42986
G1 X86.221 Y144.583
G1 X96.218 Y134.585 E.42112
G1 X95.565 Y134.705
G1 X85.687 Y144.583 E.41611
G1 X85.154 Y144.583
G1 X94.961 Y134.776 E.41311
G1 X94.373 Y134.831
G1 X84.621 Y144.583 E.41079
G1 X84.088 Y144.583
G1 X93.797 Y134.873 E.409
G1 X93.284 Y134.853
G1 X83.554 Y144.583 E.40987
G1 X83.021 Y144.583
G1 X92.776 Y134.828 E.41092
G1 X92.29 Y134.781
G1 X82.488 Y144.583 E.41289
G1 X81.955 Y144.583
G1 X91.827 Y134.71 E.41588
G1 X91.39 Y134.614
G1 X81.421 Y144.583 E.41994
G1 X80.888 Y144.583
G1 X90.973 Y134.497 E.42485
G1 X90.573 Y134.364
G1 X80.355 Y144.583 E.43045
G1 X79.822 Y144.583
G1 X90.173 Y134.231 E.43605
G1 X89.807 Y134.064
G1 X79.288 Y144.583 E.44308
G1 X78.964 Y144.374
G1 X89.453 Y133.885 E.44185
G1 X89.121 Y133.683
G1 X78.697 Y144.107 E.4391
G1 X78.431 Y143.84
G1 X88.801 Y133.47 E.43686
G1 X88.505 Y133.233
G1 X78.164 Y143.574 E.43559
G1 X77.897 Y143.307
G1 X88.22 Y132.985 E.43483
G1 X87.943 Y132.728
G1 X77.631 Y143.041 E.43439
G1 X77.364 Y142.774
G1 X87.691 Y132.447 E.43502
G1 X87.446 Y132.159
G1 X77.098 Y142.507 E.43593
G1 X76.831 Y142.241
G1 X87.201 Y131.87 E.43684
G1 X86.984 Y131.554
G1 X76.564 Y141.974 E.43892
G1 X76.417 Y141.588
G1 X86.772 Y131.233 E.43619
G1 X86.587 Y130.885
G1 X76.417 Y141.054 E.42839
G1 X76.417 Y140.521
G1 X86.402 Y130.537 E.42059
G1 X86.239 Y130.166
G1 X76.417 Y139.988 E.41372
G1 X76.417 Y139.455
G1 X86.106 Y129.766 E.40813
G1 X85.973 Y129.366
G1 X76.417 Y138.921 E.40253
G1 X76.417 Y138.388
G1 X85.853 Y128.952 E.39748
G1 X85.748 Y128.524
G1 X76.417 Y137.855 E.39304
G1 X76.417 Y137.322
G1 X85.661 Y128.078 E.38939
G1 X85.597 Y127.609
G1 X76.417 Y136.788 E.38669
G1 X76.417 Y136.255
G1 X85.556 Y127.116 E.38497
G1 X85.534 Y126.605
G1 X76.417 Y135.722 E.38403
G1 X76.417 Y135.189
G1 X85.514 Y126.092 E.3832
G1 X85.53 Y125.543
G1 X76.417 Y134.655 E.38385
G1 X76.417 Y134.122
M73 P86 R3
G1 X85.567 Y124.972 E.38543
G1 X85.613 Y124.393
G1 X76.417 Y133.589 E.38735
G1 X76.417 Y133.056
G1 X85.686 Y123.787 E.39044
G1 X85.811 Y123.128
G1 X76.417 Y132.522 E.39571
G1 X76.417 Y131.989
G1 X85.999 Y122.407 E.40362
G1 X86.422 Y121.451
G1 X76.417 Y131.456 E.42143
G1 X76.417 Y130.923
G1 X87.41 Y119.93 E.46308
; WIPE_START
M204 S3000
G1 X85.996 Y121.344 E-.76
; WIPE_END
M73 P87 R3
G1 E-.04 F1800
M204 S10000
G1 X92.413 Y125.476 Z2 F30000
G1 X100.917 Y130.953 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X105.839 Y126.031 E.20733
G1 X105.839 Y125.497
G1 X101.488 Y129.848 E.18328
G1 X101.746 Y129.058
M73 C1
G1 X105.839 Y124.964 E.17243
G1 X105.839 Y124.431
G1 X101.878 Y128.392 E.16686
G1 X101.974 Y127.763
G1 X105.839 Y123.898 E.16283
G1 X105.839 Y123.364
G1 X102.026 Y127.178 E.16064
G1 X102.067 Y126.603
G1 X105.839 Y122.831 E.15888
G1 X105.839 Y122.298
G1 X102.099 Y126.037 E.15753
G1 X102.075 Y125.529
G1 X105.839 Y121.765 E.15858
G1 X105.839 Y121.231
G1 X102.043 Y125.028 E.15992
G1 X102.007 Y124.53
G1 X105.839 Y120.698 E.16143
G1 X105.839 Y120.165
G1 X101.95 Y124.054 E.16381
G1 X101.884 Y123.587
G1 X105.839 Y119.632 E.16661
G1 X105.839 Y119.098
G1 X101.793 Y123.144 E.17043
G1 X101.691 Y122.713
G1 X105.839 Y118.565 E.17474
G1 X105.839 Y118.032
G1 X101.56 Y122.311 E.18025
G1 X101.407 Y121.931
G1 X105.839 Y117.499 E.1867
; WIPE_START
M204 S3000
G1 X104.425 Y118.913 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.427 Y121.95 Z2 F30000
G1 X138.643 Y133.755 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X148.064 Y124.333 E.39687
G1 X148.064 Y123.8
G1 X138.999 Y132.865 E.38187
G1 X139.355 Y131.976
G1 X148.064 Y123.267 E.36687
G1 X148.064 Y122.733
G1 X139.711 Y131.086 E.35187
G1 X140.067 Y130.197
G1 X148.064 Y122.2 E.33687
G1 X148.064 Y121.667
G1 X140.423 Y129.308 E.32187
G1 X140.779 Y128.418
G1 X148.064 Y121.134 E.30687
G1 X148.064 Y120.6
G1 X141.136 Y127.529 E.29187
G1 X141.492 Y126.64
G1 X148.064 Y120.067 E.27686
G1 X148.064 Y119.534
G1 X141.848 Y125.75 E.26186
G1 X142.204 Y124.861
G1 X148.064 Y119.001 E.24686
G1 X148.064 Y118.467
G1 X142.56 Y123.972 E.23186
G1 X142.916 Y123.082
G1 X148.064 Y117.934 E.21686
; WIPE_START
M204 S3000
G1 X146.65 Y119.348 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.821 Y120.912 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X140.212 Y121.52 E.02562
G1 X139.679 Y121.52
G1 X141.153 Y120.045 E.06211
G1 X141.486 Y119.179
G1 X139.146 Y121.52 E.0986
G1 X138.613 Y121.52
G1 X141.819 Y118.313 E.13509
G1 X142.152 Y117.447
G1 X138.079 Y121.52 E.17157
; WIPE_START
M204 S3000
G1 X139.494 Y120.106 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X144.246 Y126.078 Z2 F30000
G1 X150.836 Y134.359 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X155.173 Y130.022 E.1827
G1 X155.173 Y129.489
G1 X150.836 Y133.826 E.1827
G1 X150.836 Y133.293
G1 X155.173 Y128.956 E.1827
G1 X155.173 Y128.422
G1 X150.836 Y132.759 E.1827
G1 X150.836 Y132.226
G1 X155.173 Y127.889 E.1827
G1 X155.173 Y127.356
G1 X150.836 Y131.693 E.1827
G1 X150.836 Y131.16
G1 X155.173 Y126.823 E.1827
G1 X155.173 Y126.289
G1 X150.836 Y130.626 E.1827
M73 P88 R3
G1 X150.836 Y130.093
G1 X155.173 Y125.756 E.1827
G1 X155.173 Y125.223
G1 X150.836 Y129.56 E.1827
G1 X150.836 Y129.027
G1 X155.173 Y124.69 E.1827
G1 X155.173 Y124.156
G1 X150.836 Y128.493 E.1827
G1 X150.836 Y127.96
G1 X155.173 Y123.623 E.1827
G1 X155.173 Y123.09
G1 X150.836 Y127.427 E.1827
G1 X150.836 Y126.894
G1 X155.173 Y122.557 E.1827
G1 X155.173 Y122.023
G1 X150.836 Y126.36 E.1827
G1 X150.836 Y125.827
G1 X155.173 Y121.49 E.1827
G1 X155.173 Y120.957
G1 X150.836 Y125.294 E.1827
G1 X150.836 Y124.761
G1 X155.173 Y120.424 E.1827
G1 X155.173 Y119.89
G1 X150.836 Y124.227 E.1827
G1 X150.836 Y123.694
G1 X155.173 Y119.357 E.1827
G1 X155.173 Y118.824
G1 X150.836 Y123.161 E.1827
G1 X150.836 Y122.628
G1 X155.173 Y118.291 E.1827
G1 X155.173 Y117.757
G1 X150.836 Y122.094 E.1827
G1 X150.836 Y121.561
G1 X164.98 Y107.417 E.5958
G1 X164.447 Y107.417
G1 X150.836 Y121.028 E.57333
G1 X150.836 Y120.495
G1 X163.913 Y107.417 E.55087
G1 X163.38 Y107.417
G1 X150.836 Y119.961 E.52841
G1 X150.836 Y119.428
G1 X162.847 Y107.417 E.50594
G1 X162.314 Y107.417
G1 X150.836 Y118.895 E.48348
G1 X150.836 Y118.362
G1 X161.78 Y107.417 E.46102
G1 X161.247 Y107.417
G1 X150.836 Y117.828 E.43855
G1 X150.7 Y117.431
G1 X160.714 Y107.417 E.42183
G1 X160.181 Y107.417
G1 X150.167 Y117.431 E.42183
G1 X149.634 Y117.431
G1 X159.647 Y107.417 E.42183
G1 X159.114 Y107.417
G1 X149.1 Y117.431 E.42183
G1 X148.567 Y117.431
G1 X158.581 Y107.417 E.42183
G1 X158.048 Y107.417
G1 X143.272 Y122.193 E.62241
G1 X143.628 Y121.303
G1 X157.514 Y107.417 E.58494
G1 X156.981 Y107.417
G1 X143.984 Y120.414 E.54748
G1 X144.341 Y119.525
G1 X156.448 Y107.417 E.51002
G1 X155.915 Y107.417
G1 X144.697 Y118.635 E.47255
G1 X145.053 Y117.746
G1 X145.78 Y117.019 E.03063
G1 X145.818 Y116.981
G1 X155.381 Y107.417 E.40287
G1 X154.848 Y107.417
G1 X144.834 Y117.431 E.42183
G1 X144.301 Y117.431
G1 X154.315 Y107.417 E.42183
G1 X153.782 Y107.417
G1 X143.768 Y117.431 E.42183
G1 X143.235 Y117.431
G1 X153.248 Y107.417 E.42183
G1 X152.715 Y107.417
G1 X142.701 Y117.431 E.42183
G1 X142.168 Y117.431
G1 X152.182 Y107.417 E.42183
G1 X151.649 Y107.417
G1 X137.546 Y121.52 E.59406
G1 X137.013 Y121.52
G1 X151.115 Y107.417 E.59406
G1 X150.582 Y107.417
G1 X136.48 Y121.52 E.59406
G1 X135.946 Y121.52
G1 X150.049 Y107.417 E.59406
G1 X149.515 Y107.417
G1 X135.413 Y121.52 E.59406
G1 X134.88 Y121.52
G1 X148.982 Y107.417 E.59406
G1 X148.449 Y107.417
G1 X134.347 Y121.52 E.59406
G1 X133.813 Y121.52
G1 X147.916 Y107.417 E.59406
G1 X147.382 Y107.417
G1 X133.28 Y121.52 E.59406
G1 X132.781 Y121.486
G1 X146.849 Y107.417 E.59262
G1 X146.316 Y107.417
G1 X132.639 Y121.094 E.57614
G1 X132.497 Y120.703
G1 X145.783 Y107.417 E.55966
G1 X145.249 Y107.417
G1 X132.355 Y120.312 E.54319
G1 X132.212 Y119.921
G1 X144.716 Y107.417 E.52671
G1 X144.183 Y107.417
G1 X132.07 Y119.53 E.51024
G1 X131.928 Y119.139
G1 X143.65 Y107.417 E.49376
G1 X143.116 Y107.417
G1 X131.786 Y118.748 E.47728
G1 X131.644 Y118.356
G1 X142.583 Y107.417 E.46081
G1 X142.05 Y107.417
G1 X131.502 Y117.965 E.44433
G1 X131.36 Y117.574
G1 X141.517 Y107.417 E.42785
G1 X140.983 Y107.417
G1 X130.97 Y117.431 E.42183
G1 X130.436 Y117.431
G1 X140.45 Y107.417 E.42183
G1 X139.917 Y107.417
G1 X129.903 Y117.431 E.42183
G1 X129.37 Y117.431
G1 X139.384 Y107.417 E.42183
G1 X138.85 Y107.417
G1 X128.837 Y117.431 E.42183
; WIPE_START
M204 S3000
G1 X130.251 Y116.017 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.721 Y121.278 Z2 F30000
G1 X119.256 Y126.478 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X138.317 Y107.417 E.80292
G1 X137.784 Y107.417
G1 X119.256 Y125.945 E.78046
G1 X119.256 Y125.411
G1 X137.251 Y107.417 E.75799
G1 X136.717 Y107.417
G1 X119.256 Y124.878 E.73553
G1 X119.256 Y124.345
G1 X136.184 Y107.417 E.71307
G1 X135.651 Y107.417
G1 X119.256 Y123.812 E.69061
G1 X119.256 Y123.278
G1 X135.118 Y107.417 E.66814
G1 X134.584 Y107.417
G1 X119.256 Y122.745 E.64568
G1 X119.256 Y122.212
G1 X134.051 Y107.417 E.62322
G1 X133.518 Y107.417
G1 X119.256 Y121.679 E.60075
G1 X119.256 Y121.145
G1 X132.984 Y107.417 E.57829
G1 X132.451 Y107.417
G1 X119.256 Y120.612 E.55583
G1 X119.256 Y120.079
M73 P89 R3
G1 X131.918 Y107.417 E.53336
G1 X131.385 Y107.417
G1 X119.256 Y119.546 E.5109
G1 X119.256 Y119.012
G1 X130.851 Y107.417 E.48844
G1 X130.318 Y107.417
G1 X119.256 Y118.479 E.46597
G1 X119.256 Y117.946
G1 X129.785 Y107.417 E.44351
G1 X129.252 Y107.417
G1 X119.238 Y117.431 E.42183
G1 X118.705 Y117.431
G1 X128.718 Y107.417 E.42183
G1 X128.185 Y107.417
G1 X118.171 Y117.431 E.42183
G1 X117.638 Y117.431
G1 X127.652 Y107.417 E.42183
G1 X127.119 Y107.417
G1 X117.105 Y117.431 E.42183
G1 X116.572 Y117.431
G1 X126.585 Y107.417 E.42183
G1 X126.052 Y107.417
G1 X108.353 Y125.116 E.74556
G1 X108.353 Y124.583
G1 X125.519 Y107.417 E.72309
G1 X124.986 Y107.417
G1 X108.353 Y124.05 E.70063
G1 X108.353 Y123.516
G1 X124.452 Y107.417 E.67817
G1 X123.919 Y107.417
G1 X108.353 Y122.983 E.6557
G1 X108.353 Y122.45
G1 X123.386 Y107.417 E.63324
G1 X122.853 Y107.417
G1 X108.353 Y121.917 E.61078
G1 X108.353 Y121.383
G1 X122.319 Y107.417 E.58831
G1 X121.786 Y107.417
G1 X108.353 Y120.85 E.56585
G1 X108.353 Y120.317
G1 X121.253 Y107.417 E.54339
G1 X120.72 Y107.417
G1 X108.353 Y119.784 E.52092
G1 X108.353 Y119.25
G1 X120.186 Y107.417 E.49846
G1 X119.653 Y107.417
G1 X108.353 Y118.717 E.476
G1 X108.353 Y118.184
G1 X119.12 Y107.417 E.45353
G1 X118.587 Y107.417
G1 X108.353 Y117.651 E.43107
G1 X108.04 Y117.431
G1 X118.053 Y107.417 E.42183
G1 X117.52 Y107.417
G1 X107.506 Y117.431 E.42183
G1 X106.973 Y117.431
G1 X116.987 Y107.417 E.42183
G1 X116.454 Y107.417
G1 X106.44 Y117.431 E.42183
G1 X105.906 Y117.431
G1 X115.92 Y107.417 E.42183
G1 X115.387 Y107.417
G1 X101.232 Y121.572 E.59626
G1 X101.041 Y121.231
G1 X114.854 Y107.417 E.58187
G1 X114.32 Y107.417
G1 X100.847 Y120.891 E.56756
G1 X100.634 Y120.571
G1 X113.787 Y107.417 E.55409
G1 X113.254 Y107.417
G1 X100.42 Y120.251 E.54061
G1 X100.199 Y119.939
G1 X112.721 Y107.417 E.52745
G1 X112.187 Y107.417
G1 X99.976 Y119.629 E.51441
G1 X99.72 Y119.352
G1 X111.654 Y107.417 E.50273
G1 X111.121 Y107.417
G1 X99.422 Y119.117 E.49282
G1 X99.124 Y118.881
G1 X110.588 Y107.417 E.48291
G1 X110.054 Y107.417
G1 X98.824 Y118.648 E.47309
G1 X98.508 Y118.43
G1 X109.521 Y107.417 E.46392
G1 X108.988 Y107.417
G1 X98.193 Y118.213 E.45474
G1 X97.859 Y118.013
G1 X108.455 Y107.417 E.44635
M73 P90 R3
G1 X107.921 Y107.417
G1 X97.508 Y117.831 E.43867
G1 X97.135 Y117.67
G1 X107.388 Y107.417 E.43189
G1 X106.855 Y107.417
G1 X96.738 Y117.534 E.42615
G1 X96.316 Y117.423
G1 X106.322 Y107.417 E.4215
G1 X105.788 Y107.417
M73 P90 R2
G1 X95.87 Y117.336 E.41783
G1 X95.402 Y117.27
G1 X105.255 Y107.417 E.41506
G1 X104.722 Y107.417
G1 X94.925 Y117.214 E.41269
G1 X94.432 Y117.174
G1 X104.189 Y107.417 E.41101
G1 X103.655 Y107.417
G1 X93.938 Y117.134 E.40932
G1 X93.382 Y117.157
G1 X103.122 Y107.417 E.41028
G1 X102.589 Y107.417
G1 X92.802 Y117.204 E.41228
G1 X92.205 Y117.268
G1 X102.056 Y107.417 E.41495
G1 X101.522 Y107.417
G1 X91.564 Y117.376 E.4195
G1 X90.869 Y117.538
G1 X100.989 Y107.417 E.42631
G1 X100.456 Y107.417
G1 X89.976 Y117.897 E.44146
; WIPE_START
M204 S3000
G1 X91.39 Y116.483 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X88.388 Y118.952 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X99.923 Y107.417 E.4859
G1 X99.389 Y107.417
G1 X76.417 Y130.389 E.96768
G1 X76.417 Y129.856
G1 X98.856 Y107.417 E.94522
G1 X98.323 Y107.417
G1 X76.417 Y129.323 E.92276
G1 X76.417 Y128.789
G1 X97.789 Y107.417 E.90029
G1 X97.256 Y107.417
G1 X76.417 Y128.256 E.87783
G1 X76.417 Y127.723
G1 X96.723 Y107.417 E.85537
G1 X96.19 Y107.417
G1 X76.417 Y127.19 E.8329
G1 X76.417 Y126.656
G1 X95.656 Y107.417 E.81044
G1 X95.123 Y107.417
G1 X76.417 Y126.123 E.78798
G1 X76.417 Y125.59
G1 X94.59 Y107.417 E.76551
G1 X94.057 Y107.417
G1 X76.417 Y125.057 E.74305
G1 X76.417 Y124.523
G1 X93.523 Y107.417 E.72059
G1 X92.99 Y107.417
G1 X76.417 Y123.99 E.69812
G1 X76.417 Y123.457
G1 X92.457 Y107.417 E.67566
G1 X91.924 Y107.417
G1 X76.417 Y122.924 E.6532
G1 X76.417 Y122.39
G1 X91.39 Y107.417 E.63073
G1 X90.857 Y107.417
G1 X76.417 Y121.857 E.60827
G1 X76.417 Y121.324
G1 X90.324 Y107.417 E.58581
G1 X89.791 Y107.417
G1 X76.417 Y120.791 E.56334
G1 X76.417 Y120.257
G1 X89.257 Y107.417 E.54088
G1 X88.724 Y107.417
G1 X76.417 Y119.724 E.51842
G1 X76.417 Y119.191
G1 X88.191 Y107.417 E.49595
G1 X87.658 Y107.417
G1 X76.417 Y118.658 E.47349
G1 X76.417 Y118.124
G1 X87.124 Y107.417 E.45103
M73 P91 R2
G1 X86.591 Y107.417
G1 X76.417 Y117.591 E.42856
G1 X76.417 Y117.058
G1 X86.058 Y107.417 E.4061
G1 X85.525 Y107.417
G1 X76.417 Y116.525 E.38364
G1 X76.417 Y115.991
G1 X84.991 Y107.417 E.36117
G1 X84.458 Y107.417
G1 X76.417 Y115.458 E.33871
G1 X76.417 Y114.925
G1 X83.925 Y107.417 E.31625
G1 X83.392 Y107.417
G1 X76.417 Y114.392 E.29378
G1 X76.417 Y113.858
G1 X82.858 Y107.417 E.27132
G1 X82.325 Y107.417
G1 X76.417 Y113.325 E.24886
G1 X76.417 Y112.792
G1 X81.792 Y107.417 E.22639
G1 X81.259 Y107.417
G1 X76.417 Y112.259 E.20393
G1 X76.417 Y111.725
G1 X80.725 Y107.417 E.18147
G1 X80.192 Y107.417
G1 X76.417 Y111.192 E.159
G1 X76.417 Y110.659
G1 X79.659 Y107.417 E.13654
G1 X79.125 Y107.417
G1 X76.417 Y110.125 E.11408
G1 X76.417 Y109.592
G1 X78.592 Y107.417 E.09162
G1 X78.059 Y107.417
G1 X76.417 Y109.059 E.06915
G1 X76.417 Y108.526
G1 X77.526 Y107.417 E.04669
G1 X76.992 Y107.417
G1 X76.417 Y107.992 E.02423
; WIPE_START
M204 S3000
G1 X76.992 Y107.417 E-.30905
G1 X77.526 Y107.417 E-.20264
G1 X77.064 Y107.879 E-.24831
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.97 Y114.937 Z2 F30000
G1 X86.229 Y130.132 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0951214
G1 F3600
M204 S3000
G1 X86.144 Y129.995 E.00066
M204 S10000
G1 X85.962 Y129.332 F30000
; LINE_WIDTH: 0.119268
G1 F3600
M204 S3000
G1 X85.903 Y129.232 E.0007
G1 X85.926 Y129.146 E.00054
; WIPE_START
G1 X85.903 Y129.232 E-.33168
G1 X85.962 Y129.332 E-.42832
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.687 Y121.734 Z2 F30000
G1 X86.77 Y120.865 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.104921
G1 F3600
M204 S3000
G1 X86.673 Y120.987 E.00076
; LINE_WIDTH: 0.138419
G1 X86.576 Y121.109 E.00118
; LINE_WIDTH: 0.172458
G1 X86.475 Y121.235 E.00165
; LINE_WIDTH: 0.205088
G1 X86.36 Y121.39 E.00247
; WIPE_START
G1 X86.475 Y121.235 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X88.328 Y118.892 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.216656
G1 F3600
M204 S3000
G1 X88.033 Y119.153 E.0054
; LINE_WIDTH: 0.173823
G2 X87.727 Y119.425 I1.75 J2.274 E.00423
; LINE_WIDTH: 0.173824
G1 X87.539 Y119.647 E.00301
; LINE_WIDTH: 0.213589
G1 X87.35 Y119.869 E.00393
; WIPE_START
G1 X87.539 Y119.647 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.914 Y117.836 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.204643
G1 F3600
M204 S3000
G1 X89.773 Y117.938 E.00223
; LINE_WIDTH: 0.173718
M73 P92 R2
G1 X89.661 Y118.024 E.00146
; LINE_WIDTH: 0.139501
G1 X89.549 Y118.111 E.00108
; LINE_WIDTH: 0.105284
G1 X89.437 Y118.197 E.0007
; WIPE_START
G1 X89.549 Y118.111 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.992 Y123.462 Z2 F30000
G1 X101.552 Y129.912 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.189291
G1 F3600
M204 S3000
G1 X101.467 Y130.035 E.00173
; LINE_WIDTH: 0.14884
G1 X101.381 Y130.158 E.00125
; LINE_WIDTH: 0.108388
G1 X101.296 Y130.281 E.00077
M204 S10000
G1 X100.978 Y131.013 F30000
; LINE_WIDTH: 0.208728
G1 F3600
M204 S3000
G1 X100.861 Y131.161 E.00247
; LINE_WIDTH: 0.172587
G1 X100.743 Y131.309 E.00194
; LINE_WIDTH: 0.136218
G1 X100.624 Y131.459 E.00141
; LINE_WIDTH: 0.103045
G1 X100.494 Y131.613 E.00096
; WIPE_START
G1 X100.624 Y131.459 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.667 Y133.44 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.10667
G1 F3600
M204 S3000
G1 X98.505 Y133.575 E.00106
; LINE_WIDTH: 0.143661
G1 X98.344 Y133.709 E.00167
; LINE_WIDTH: 0.181137
G1 X98.178 Y133.847 E.00236
; LINE_WIDTH: 0.212383
G1 X98.03 Y133.962 E.00251
; WIPE_START
G1 X98.178 Y133.847 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X92.008 Y134.795 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0896795
G1 F3600
M204 S3000
G1 X91.853 Y134.713 E.00065
M204 S10000
G1 X91.149 Y134.588 F30000
; LINE_WIDTH: 0.0920537
G1 F3600
M204 S3000
G1 X91.004 Y134.504 E.00065
; WIPE_START
G1 X91.149 Y134.588 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.148 Y131.545 Z2 F30000
G1 X111.013 Y125.952 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.111231
G1 F3600
M204 S3000
G1 X110.865 Y126.138 E.00128
; LINE_WIDTH: 0.157349
G1 X110.717 Y126.325 E.00215
; LINE_WIDTH: 0.203467
G1 X110.57 Y126.511 E.00302
M204 S10000
G1 X110.149 Y127.348 F30000
; LINE_WIDTH: 0.108631
G1 F3600
M204 S3000
G1 X110.02 Y127.512 E.00108
; LINE_WIDTH: 0.149547
G1 X109.89 Y127.675 E.00176
; LINE_WIDTH: 0.190464
G1 X109.761 Y127.839 E.00243
; LINE_WIDTH: 0.23138
G1 X109.631 Y128.002 E.00311
; LINE_WIDTH: 0.272297
G1 X109.502 Y128.166 E.00378
; WIPE_START
G1 X109.631 Y128.002 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.937 Y134.661 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.099216
G1 F3600
M204 S3000
G1 X106.051 Y134.578 E.00063
G1 X106.031 Y134.55 E.00015
; WIPE_START
G1 X106.051 Y134.578 E-.14802
G1 X105.937 Y134.661 E-.61198
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.085 Y134.104 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.206669
G1 F3600
M204 S3000
G1 X108.964 Y134.259 E.00254
; LINE_WIDTH: 0.167714
G1 X108.842 Y134.413 E.00194
; LINE_WIDTH: 0.122352
G3 X108.593 Y134.662 I-.584 J-.336 E.00224
; WIPE_START
G1 X108.72 Y134.567 E-.34002
G1 X108.842 Y134.413 E-.41998
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.93 Y132.727 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203148
G1 F3600
M204 S3000
G1 X109.785 Y132.911 E.00296
; LINE_WIDTH: 0.157159
G1 X109.64 Y133.094 E.00211
; LINE_WIDTH: 0.11117
G1 X109.495 Y133.278 E.00126
; WIPE_START
G1 X109.64 Y133.094 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.774 Y131.349 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203149
G1 F3600
M204 S3000
G1 X110.629 Y131.533 E.00296
; LINE_WIDTH: 0.15716
G1 X110.484 Y131.717 E.00211
; LINE_WIDTH: 0.111171
G1 X110.339 Y131.901 E.00126
; WIPE_START
G1 X110.484 Y131.717 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.618 Y129.972 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203149
G1 F3600
M204 S3000
G1 X111.473 Y130.156 E.00296
; LINE_WIDTH: 0.15716
G1 X111.328 Y130.339 E.00211
; LINE_WIDTH: 0.111171
G1 X111.183 Y130.523 E.00126
; WIPE_START
G1 X111.328 Y130.339 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.462 Y128.595 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203149
G1 F3600
M204 S3000
G1 X112.317 Y128.778 E.00296
; LINE_WIDTH: 0.15716
G1 X112.172 Y128.962 E.00211
; LINE_WIDTH: 0.111171
G1 X112.028 Y129.146 E.00126
; WIPE_START
G1 X112.172 Y128.962 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.306 Y127.217 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203151
G1 F3600
M204 S3000
G1 X113.162 Y127.401 E.00296
; LINE_WIDTH: 0.157161
G1 X113.017 Y127.585 E.00211
; LINE_WIDTH: 0.111171
G1 X112.872 Y127.768 E.00126
; WIPE_START
G1 X113.017 Y127.585 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.151 Y125.84 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203149
G1 F3600
M204 S3000
G1 X114.006 Y126.023 E.00296
; LINE_WIDTH: 0.15716
G1 X113.861 Y126.207 E.00211
; LINE_WIDTH: 0.111171
G1 X113.716 Y126.391 E.00126
; WIPE_START
G1 X113.861 Y126.207 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.995 Y124.462 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203149
G1 F3600
M204 S3000
G1 X114.85 Y124.646 E.00296
; LINE_WIDTH: 0.15716
G1 X114.705 Y124.83 E.00211
; LINE_WIDTH: 0.11117
G1 X114.56 Y125.013 E.00126
; WIPE_START
G1 X114.705 Y124.83 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.485 Y123.534 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0968229
G1 F3600
M204 S3000
G1 X115.404 Y123.636 E.00055
; WIPE_START
G1 X115.485 Y123.534 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.672 Y124.123 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.141765
G1 F3600
M204 S3000
G2 X116.707 Y123.935 I-.174 J-.129 E.00155
G2 X116.608 Y123.913 I-.068 J.073 E.00083
; WIPE_START
G1 X116.669 Y123.913 E-.15418
G1 X116.707 Y123.935 E-.10995
G1 X116.715 Y124.019 E-.21441
G1 X116.672 Y124.123 E-.28146
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.193 Y117.571 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.111232
G1 F3600
M204 S3000
G1 X116.046 Y117.758 E.00128
; LINE_WIDTH: 0.15735
G1 X115.898 Y117.944 E.00215
; LINE_WIDTH: 0.203468
G1 X115.75 Y118.131 E.00302
M204 S10000
G1 X115.33 Y118.968 F30000
; LINE_WIDTH: 0.111232
G1 F3600
M204 S3000
G1 X115.182 Y119.155 E.00128
; LINE_WIDTH: 0.15735
G1 X115.035 Y119.341 E.00215
; LINE_WIDTH: 0.203469
G1 X114.887 Y119.528 E.00302
M204 S10000
G1 X114.466 Y120.365 F30000
; LINE_WIDTH: 0.111234
G1 F3600
M204 S3000
G1 X114.319 Y120.551 E.00128
; LINE_WIDTH: 0.157356
G1 X114.171 Y120.738 E.00215
; LINE_WIDTH: 0.203479
G1 X114.023 Y120.924 E.00302
M204 S10000
G1 X113.603 Y121.762 F30000
; LINE_WIDTH: 0.111231
G1 F3600
M204 S3000
G1 X113.455 Y121.948 E.00128
; LINE_WIDTH: 0.157349
G1 X113.308 Y122.135 E.00215
; LINE_WIDTH: 0.203467
G1 X113.16 Y122.321 E.00302
M204 S10000
G1 X112.739 Y123.158 F30000
; LINE_WIDTH: 0.111232
G1 F3600
M204 S3000
G1 X112.592 Y123.345 E.00128
; LINE_WIDTH: 0.15735
G1 X112.444 Y123.531 E.00215
; LINE_WIDTH: 0.203469
G1 X112.297 Y123.718 E.00302
M204 S10000
G1 X111.876 Y124.555 F30000
; LINE_WIDTH: 0.111234
G1 F3600
M204 S3000
G1 X111.728 Y124.741 E.00128
; LINE_WIDTH: 0.157356
G1 X111.581 Y124.928 E.00215
; LINE_WIDTH: 0.203479
G1 X111.433 Y125.114 E.00302
; WIPE_START
G1 X111.581 Y124.928 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.999 Y126.725 Z2 F30000
G1 X150.942 Y134.465 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.121258
G1 F3600
M204 S3000
G1 X150.732 Y134.674 E.00183
; WIPE_START
G1 X150.942 Y134.465 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.366 Y128.245 Z2 F30000
G1 X157.96 Y124.598 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.109782
G1 F3600
M204 S3000
G1 X157.96 Y124.964 E.00193
; WIPE_START
G1 X157.96 Y124.598 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.382 Y129.971 Z2 F30000
G1 X167.172 Y133.726 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.110274
G1 F3600
M204 S3000
G1 X167.013 Y133.85 E.00107
; LINE_WIDTH: 0.153717
G1 X166.871 Y133.952 E.00153
; LINE_WIDTH: 0.195959
G1 X166.729 Y134.054 E.00211
; WIPE_START
G1 X166.871 Y133.952 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X168.589 Y132.194 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.198588
G1 F3600
M204 S3000
G1 X168.5 Y132.317 E.00186
; LINE_WIDTH: 0.160024
G1 X168.411 Y132.44 E.0014
; LINE_WIDTH: 0.120764
G1 X168.318 Y132.567 E.00097
; LINE_WIDTH: 0.0945608
G1 X168.239 Y132.658 E.00049
; WIPE_START
G1 X168.318 Y132.567 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X169.044 Y130.816 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0990025
G1 F3600
M204 S3000
G1 X168.966 Y130.596 E.00103
; WIPE_START
G1 X169.044 Y130.816 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X168.951 Y128.776 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.102886
G1 F3600
M204 S3000
G2 X168.868 Y128.629 I-2.678 J1.402 E.0008
; WIPE_START
G1 X168.951 Y128.776 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.605 Y124.56 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.104948
G1 F3600
M204 S3000
G1 X164.432 Y124.708 E.00111
; LINE_WIDTH: 0.138494
G1 X164.26 Y124.857 E.00172
; LINE_WIDTH: 0.17204
G1 X164.087 Y125.005 E.00232
; LINE_WIDTH: 0.194718
G1 X164.049 Y125.053 E.00073
G1 X164.189 Y125.186 E.00232
; WIPE_START
G1 X164.049 Y125.053 E-.57715
G1 X164.087 Y125.005 E-.18285
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.021 Y123.004 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.102873
G1 F3600
M204 S3000
G1 X162.872 Y123.177 E.00108
; LINE_WIDTH: 0.141288
G1 X162.589 Y123.493 E.0033
; LINE_WIDTH: 0.193454
G3 X161.762 Y124.32 I-5.941 J-5.118 E.01392
; LINE_WIDTH: 0.145161
G1 X161.635 Y124.418 E.00129
; LINE_WIDTH: 0.107171
G1 X161.508 Y124.515 E.00081
; WIPE_START
G1 X161.635 Y124.418 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.231 Y121.26 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.11187
G1 F3600
M204 S3000
G1 X164.05 Y121.48 E.00155
; LINE_WIDTH: 0.1593
G1 X163.869 Y121.7 E.00262
; LINE_WIDTH: 0.20673
G1 X163.688 Y121.92 E.00368
; WIPE_START
G1 X163.869 Y121.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.327 Y119.631 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.111891
G1 F3600
M204 S3000
G1 X165.146 Y119.851 E.00155
; LINE_WIDTH: 0.159307
G1 X164.965 Y120.071 E.00262
; LINE_WIDTH: 0.206723
G1 X164.784 Y120.291 E.00368
; WIPE_START
G1 X164.965 Y120.071 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.422 Y118.003 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.11189
G1 F3600
M204 S3000
G1 X166.241 Y118.222 E.00155
; LINE_WIDTH: 0.159306
G1 X166.06 Y118.442 E.00262
; LINE_WIDTH: 0.206723
G1 X165.879 Y118.662 E.00368
; WIPE_START
G1 X166.06 Y118.442 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X169.732 Y118.251 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.203935
G1 F3600
M204 S3000
G1 X169.58 Y118.442 E.0031
; LINE_WIDTH: 0.157625
G1 X169.428 Y118.633 E.00221
; LINE_WIDTH: 0.111315
G1 X169.277 Y118.823 E.00132
M204 S10000
G1 X168.84 Y119.677 F30000
; LINE_WIDTH: 0.203936
G1 F3600
M204 S3000
G1 X168.688 Y119.868 E.0031
; LINE_WIDTH: 0.157626
G1 X168.536 Y120.058 E.00221
; LINE_WIDTH: 0.111316
G1 X168.384 Y120.249 E.00132
M204 S10000
G1 X167.947 Y121.102 F30000
; LINE_WIDTH: 0.206271
G1 F3600
M204 S3000
G1 X167.771 Y121.317 E.00358
; LINE_WIDTH: 0.159029
G1 X167.596 Y121.531 E.00254
; LINE_WIDTH: 0.111787
G1 X167.42 Y121.746 E.00151
; WIPE_START
G1 X167.596 Y121.531 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.246 Y128.793 Z2 F30000
G1 X164.118 Y132.276 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X166.09 Y130.304 E.08305
G1 X166.15 Y129.71
G1 X163.521 Y132.34 E.11077
G1 X162.963 Y132.365
G1 X166.108 Y129.219 E.1325
G1 X166.01 Y128.784
G1 X162.411 Y132.383 E.15159
G1 X161.878 Y132.383
G1 X165.855 Y128.406 E.16754
G1 X165.66 Y128.068
G1 X161.344 Y132.384 E.18181
G1 X160.81 Y132.384
G1 X165.41 Y127.785 E.19374
G1 X165.125 Y127.536
G1 X160.277 Y132.384 E.20425
G1 X159.743 Y132.385
G1 X164.789 Y127.339 E.21253
G1 X164.41 Y127.184
G1 X159.21 Y132.385 E.21907
G1 X158.676 Y132.385
G1 X163.949 Y127.113 E.22211
G1 X163.482 Y127.046
G1 X158.142 Y132.386 E.22494
G1 X157.945 Y132.049
G1 X162.995 Y126.999 E.21273
G1 X162.494 Y126.968
G1 X157.945 Y131.516 E.19161
G1 X157.945 Y130.983
G1 X161.975 Y126.953 E.16975
G1 X161.443 Y126.952
G1 X157.945 Y130.45 E.14735
G1 X157.945 Y129.916
G1 X160.909 Y126.952 E.12486
G1 X160.375 Y126.953
G1 X157.945 Y129.383 E.10236
G1 X157.945 Y128.85
G1 X159.841 Y126.954 E.07987
G1 X159.307 Y126.955
G1 X157.945 Y128.317 E.05738
G1 X157.945 Y127.783
G1 X158.773 Y126.955 E.03488
; WIPE_START
M204 S3000
G1 X157.945 Y127.783 E-.44498
G1 X157.945 Y128.317 E-.20264
G1 X158.155 Y128.108 E-.11238
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.406 Y130.488 Z2 F30000
G1 X166.013 Y130.688 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.175495
G1 F3600
M204 S3000
G1 X165.886 Y130.861 E.00225
; LINE_WIDTH: 0.210792
G1 X165.758 Y131.033 E.00285
; LINE_WIDTH: 0.252803
G1 X165.614 Y131.212 E.00381
; LINE_WIDTH: 0.308004
G3 X165.139 Y131.701 I-1.987 J-1.456 E.01431
; LINE_WIDTH: 0.279616
G1 X164.967 Y131.849 E.00424
; LINE_WIDTH: 0.247854
G1 X164.766 Y132.004 E.00412
; LINE_WIDTH: 0.218286
G1 X164.564 Y132.16 E.00353
; WIPE_START
G1 X164.766 Y132.004 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.196 Y132.981 Z2 F30000
G1 X156.687 Y133.047 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.50662
G1 F6000
M204 S3000
G2 X156.685 Y133.147 I-.029 J.05 E.00875
; WIPE_START
G1 X156.629 Y133.147 E-.18492
G1 X156.6 Y133.097 E-.19169
G1 X156.629 Y133.047 E-.19169
G1 X156.687 Y133.047 E-.1917
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.588 Y126.034 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.36392
G1 F6000
M204 S3000
G1 X156.648 Y126.442 E.01044
G1 X156.882 Y126.036 E.01187
G1 X156.981 Y125.951 E.00331
G1 X156.655 Y125.577 E.01258
G1 X156.597 Y125.975 E.01021
; WIPE_START
G1 X156.655 Y125.577 E-.16029
G1 X156.981 Y125.951 E-.19748
G1 X156.882 Y126.036 E-.05201
G1 X156.648 Y126.442 E-.18635
G1 X156.588 Y126.034 E-.16387
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.103 Y124.54 Z2 F30000
G1 X140.929 Y122.908 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.4099
G1 F6000
M204 S3000
G1 X141.057 Y123.111 E.00696
G1 X141.155 Y123.473 E.01087
G1 X141.416 Y122.96 E.0167
G1 X141.532 Y122.534 E.0128
G1 X141.128 Y122.84 E.01468
G1 X140.986 Y122.889 E.00436
; WIPE_START
G1 X141.128 Y122.84 E-.05722
G1 X141.532 Y122.534 E-.19244
G1 X141.416 Y122.96 E-.16772
G1 X141.155 Y123.473 E-.21894
G1 X141.07 Y123.159 E-.12368
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.444 Y123.47 Z2 F30000
G1 X132.282 Y123.517 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.35657
G1 F6000
M204 S3000
G1 X132.363 Y123.011 E.0127
G1 X132.481 Y122.862 E.0047
G1 X132.235 Y122.801 E.00626
G1 X131.939 Y122.595 E.00894
G2 X132.258 Y123.462 I4.072 J-1.003 E.02295
; WIPE_START
G1 X132.108 Y123.125 E-.14038
G1 X131.939 Y122.595 E-.21137
G1 X132.235 Y122.801 E-.13709
G1 X132.481 Y122.862 E-.09608
G1 X132.363 Y123.011 E-.07203
G1 X132.32 Y123.279 E-.10306
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.198 Y129.853 Z2 F30000
G1 X136.97 Y131.161 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X136.491 Y131.641 E.02019
G1 X136.348 Y131.25
G1 X137.285 Y130.313 E.03945
G1 X137.6 Y129.465
G1 X136.206 Y130.859 E.05871
G1 X136.064 Y130.468
G1 X137.915 Y128.617 E.07797
G1 X138.23 Y127.768
G1 X135.922 Y130.077 E.09723
G1 X135.779 Y129.686
G1 X138.545 Y126.92 E.1165
G1 X138.86 Y126.072
G1 X135.637 Y129.295 E.13576
G1 X135.495 Y128.904
G1 X139.175 Y125.224 E.15502
G1 X139.49 Y124.376
G1 X135.352 Y128.513 E.17428
G1 X135.21 Y128.122
G1 X139.642 Y123.69 E.18668
G1 X139.108 Y123.69
G1 X135.068 Y127.731 E.17021
G1 X134.925 Y127.34
G1 X138.575 Y123.69 E.15374
G1 X138.042 Y123.69
G1 X134.783 Y126.949 E.13727
G1 X134.641 Y126.558
G1 X137.509 Y123.69 E.1208
G1 X136.975 Y123.69
G1 X134.499 Y126.167 E.10434
G1 X134.356 Y125.776
G1 X136.442 Y123.69 E.08787
G1 X135.909 Y123.69
G1 X134.214 Y125.385 E.0714
G1 X134.072 Y124.994
G1 X135.376 Y123.69 E.05493
G1 X134.842 Y123.69
G1 X133.929 Y124.603 E.03846
G1 X133.787 Y124.212
G1 X134.309 Y123.69 E.02199
; WIPE_START
M204 S3000
G1 X133.787 Y124.212 E-.28054
G1 X133.929 Y124.603 E-.1581
G1 X134.527 Y124.005 E-.32136
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.691 Y131.325 Z2 F30000
G1 X136.797 Y131.682 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196227
G1 F3600
M204 S3000
G1 X136.64 Y131.858 E.00285
; LINE_WIDTH: 0.19674
G1 X136.573 Y131.798 E.00109
; LINE_WIDTH: 0.163132
G1 X136.506 Y131.738 E.00085
; WIPE_START
G1 X136.573 Y131.798 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.67 Y128.541 Z2 F30000
G1 X117.828 Y122.954 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X117.828 Y118.86 E.12196
G1 X117.078 Y118.86 E.02235
G1 X115.037 Y122.171 E.11586
G1 X115.779 Y122.16 E.02212
G3 X117.144 Y122.537 I-17.476 J65.924 E.04217
G1 X117.776 Y122.925 E.02209
M204 S10000
G1 X117.451 Y122.275 F30000
G1 F6000
M204 S3000
G1 X117.451 Y119.237 E.09051
G1 X117.288 Y119.237 E.00485
G1 X115.713 Y121.784 E.08918
G1 X115.935 Y121.804 E.00662
G1 X117.246 Y122.174 E.04058
G1 X117.397 Y122.249 E.00502
M204 S10000
G1 X117.02 Y121.663 F30000
; LINE_WIDTH: 0.52756
G1 F6000
M204 S3000
G1 X117.02 Y120.49 E.04491
G1 X116.402 Y121.488 E.04495
G1 X116.962 Y121.646 E.02226
; WIPE_START
G1 X116.402 Y121.488 E-.221
G1 X117.02 Y120.49 E-.44622
G1 X117.02 Y120.734 E-.09279
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.305 Y126.735 Z2 F30000
G1 X110.109 Y129.53 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X109.998 Y129.563 E.00342
G1 X109.31 Y129.569 E.0205
G3 X107.949 Y129.19 I17.002 J-63.721 E.04208
G2 X107.268 Y128.773 I-5.246 J7.805 E.02381
G1 X107.268 Y133.14 E.13008
G1 X107.903 Y133.14 E.01891
G1 X110.081 Y129.584 E.12423
M204 S10000
G1 X109.418 Y129.945 F30000
G1 F6000
M204 S3000
G1 X109.154 Y129.925 E.0079
G1 X107.846 Y129.553 E.0405
G1 X107.645 Y129.453 E.0067
G1 X107.645 Y132.763 E.09859
G1 X107.7 Y132.749 E.00171
G1 X109.387 Y129.996 E.09616
M204 S10000
M73 P93 R2
G1 X108.715 Y130.255 F30000
; LINE_WIDTH: 0.54109
G1 F6000
M204 S3000
G1 X108.082 Y130.075 E.0259
G1 X108.082 Y131.288 E.04773
G1 X108.684 Y130.306 E.04531
; WIPE_START
G1 X108.082 Y131.288 E-.43757
G1 X108.082 Y130.439 E-.32243
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.535 Y131.573 Z2 F30000
G1 X95.862 Y132.275 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X98.552 Y129.585 E.11333
G1 X98.91 Y128.693
G1 X95.124 Y132.479 E.15949
G1 X94.503 Y132.567
G1 X99.066 Y128.005 E.1922
G1 X99.142 Y127.395
G1 X93.912 Y132.625 E.22031
G1 X93.407 Y132.597
G1 X99.181 Y126.823 E.24322
G1 X99.202 Y126.268
G1 X92.933 Y132.538 E.26408
G1 X92.467 Y132.47
G1 X99.193 Y125.744 E.28335
G1 X99.168 Y125.236
G1 X92.044 Y132.36 E.30013
G1 X91.647 Y132.224
G1 X99.141 Y124.729 E.31569
G1 X99.083 Y124.255
G1 X91.295 Y132.043 E.32806
G1 X90.963 Y131.842
G1 X98.999 Y123.806 E.33851
G1 X98.896 Y123.375
G1 X90.661 Y131.61 E.3469
G1 X90.362 Y131.376
G1 X98.756 Y122.982 E.35359
G1 X98.598 Y122.606
G1 X90.076 Y131.129 E.35901
G1 X89.812 Y130.86
G1 X98.414 Y122.257 E.36237
G1 X98.223 Y121.915
G1 X89.606 Y130.533 E.36301
G1 X89.406 Y130.198
G1 X98.028 Y121.577 E.36316
G1 X97.821 Y121.25
G1 X89.216 Y129.856 E.36251
G1 X89.025 Y129.513
G1 X97.576 Y120.962 E.36021
G1 X97.29 Y120.715
G1 X88.867 Y129.138 E.35484
G1 X88.721 Y128.751
G1 X97.005 Y120.467 E.34897
G1 X96.704 Y120.235
G1 X88.613 Y128.326 E.34084
G1 X88.522 Y127.883
G1 X96.388 Y120.018 E.33132
G1 X96.041 Y119.831
G1 X88.464 Y127.408 E.31916
G1 X88.432 Y126.907
G1 X95.654 Y119.684 E.30425
G1 X95.24 Y119.565
G1 X88.407 Y126.398 E.28785
G1 X88.394 Y125.879
G1 X94.795 Y119.477 E.26966
G1 X94.324 Y119.415
G1 X88.416 Y125.323 E.24884
G1 X88.456 Y124.75
G1 X93.837 Y119.368 E.22671
G1 X93.25 Y119.422
G1 X88.533 Y124.14 E.19871
G1 X88.68 Y123.459
G1 X92.618 Y119.521 E.16589
G1 X91.9 Y119.706
G1 X89.026 Y122.58 E.12107
; WIPE_START
M204 S3000
G1 X90.44 Y121.166 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.346 Y119.965 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112729
G1 F3600
M204 S3000
G1 X91.168 Y120.107 E.00125
; LINE_WIDTH: 0.161808
G1 X90.99 Y120.248 E.00213
; LINE_WIDTH: 0.208268
G1 X90.693 Y120.514 E.00521
; LINE_WIDTH: 0.252133
G1 X90.395 Y120.78 E.00659
; LINE_WIDTH: 0.288952
G1 X89.986 Y121.168 E.01096
; LINE_WIDTH: 0.27963
G1 X89.844 Y121.345 E.00424
; LINE_WIDTH: 0.231204
G1 X89.702 Y121.521 E.00337
; LINE_WIDTH: 0.182778
G1 X89.559 Y121.698 E.00251
; LINE_WIDTH: 0.140965
G1 X89.466 Y121.818 E.00118
; LINE_WIDTH: 0.105775
G1 X89.373 Y121.938 E.00076
; WIPE_START
G1 X89.466 Y121.818 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.073 Y122.44 Z2 F30000
G1 X98.58 Y122.563 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.100493
G1 F3600
M204 S3000
G2 X98.494 Y122.445 I-1.106 J.721 E.00067
; WIPE_START
G1 X98.58 Y122.563 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.205 Y130.186 Z2 F30000
G1 X98.203 Y130.228 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.107301
G1 F3600
M204 S3000
G1 X98.101 Y130.362 E.00086
; LINE_WIDTH: 0.145588
G1 X97.994 Y130.495 E.00138
; LINE_WIDTH: 0.183939
G1 X97.888 Y130.629 E.0019
; LINE_WIDTH: 0.222289
G1 X97.782 Y130.762 E.00241
; LINE_WIDTH: 0.261179
G1 X97.676 Y130.895 E.00294
G1 X97.261 Y131.284 E.00981
; LINE_WIDTH: 0.218191
G1 X96.961 Y131.549 E.00553
; LINE_WIDTH: 0.168859
G1 X96.662 Y131.813 E.00398
; LINE_WIDTH: 0.130182
G1 X96.562 Y131.891 E.00087
; LINE_WIDTH: 0.102168
G1 X96.463 Y131.969 E.00059
; WIPE_START
G1 X96.562 Y131.891 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.765 Y125.955 Z2 F30000
G1 X89.087 Y122.642 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.193181
G1 F3600
M204 S3000
G1 X88.819 Y123.015 E.00545
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3600
G1 X89.087 Y122.642 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/10
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
M106 S158.1
; PAUSE_PRINTING
M400 U1

; OBJECT_ID: 403
M204 S10000
G17
G3 Z2 I-.02 J1.217 P1  F30000
G1 X163.703 Y123.848 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5799
G1 F6000
M204 S3000
G1 X163.754 Y123.75 E.00472
; LINE_WIDTH: 0.54382
G1 X163.806 Y123.651 E.0044
; LINE_WIDTH: 0.50774
G1 X164.003 Y123.363 E.0128
; LINE_WIDTH: 0.478865
G1 X164.199 Y123.076 E.012
; LINE_WIDTH: 0.44999
G2 X167.334 Y118.416 I-424.638 J-289.131 E.18059
G1 X168.368 Y118.416 E.03323
G1 X168.122 Y118.809 E.01491
G3 X166.596 Y121.203 I-44.122 J-26.436 E.09128
M73 P93 R1
G3 X165.631 Y122.451 I-16.176 J-11.507 E.05075
G3 X164.447 Y123.438 I-5.37 J-5.242 E.04967
; LINE_WIDTH: 0.493294
G1 X164.199 Y123.575 E.01007
; LINE_WIDTH: 0.536597
G1 X163.951 Y123.712 E.01104
; LINE_WIDTH: 0.5799
G1 X163.755 Y123.819 E.00947
; WIPE_START
G1 X163.754 Y123.75 E-.02645
G1 X163.806 Y123.651 E-.04228
G1 X164.003 Y123.363 E-.13243
G1 X164.199 Y123.076 E-.13244
G1 X164.826 Y122.145 E-.42639
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.263 Y125.001 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.48214
G1 F6000
M204 S3000
G1 X163.261 Y125.017 E.00054
; LINE_WIDTH: 0.44999
G1 X163.328 Y125.386 E.01206
G1 X163.701 Y125.973 E.02236
G1 X163.95 Y126.116 E.00922
G1 X163.656 Y126.073 E.00954
G2 X161.264 Y125.967 I-2.086 J20.102 E.07705
; LINE_WIDTH: 0.490194
G1 X161.016 Y125.947 E.00877
; LINE_WIDTH: 0.530397
G1 X160.769 Y125.927 E.00956
; LINE_WIDTH: 0.5706
G1 X160.522 Y125.908 E.01034
G1 X160.565 Y125.892 E.00192
; LINE_WIDTH: 0.55677
G1 X160.789 Y125.827 E.00945
; LINE_WIDTH: 0.521177
G1 X161.012 Y125.762 E.0088
; LINE_WIDTH: 0.485584
G1 X161.236 Y125.697 E.00814
; LINE_WIDTH: 0.44999
G2 X162.77 Y124.819 I-1.468 J-4.347 E.05721
; LINE_WIDTH: 0.492147
G1 X162.972 Y124.632 E.00978
; LINE_WIDTH: 0.534304
G1 X163.173 Y124.444 E.0107
; LINE_WIDTH: 0.57646
G1 X163.375 Y124.256 E.01162
G1 X163.341 Y124.397 E.00612
; LINE_WIDTH: 0.5293
G1 X163.307 Y124.538 E.00558
; LINE_WIDTH: 0.48214
G1 X163.268 Y124.941 E.01405
; WIPE_START
G1 X163.261 Y125.017 E-.02872
G1 X163.328 Y125.386 E-.14252
G1 X163.701 Y125.973 E-.26428
G1 X163.95 Y126.116 E-.10898
G1 X163.656 Y126.073 E-.11277
G1 X163.387 Y126.052 E-.10274
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.711 Y126.688 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.55416
G1 F6000
M204 S3000
G1 X166.308 Y126.951 E.02634
G3 X167.196 Y127.632 I-7.57 J10.784 E.0452
G1 X167.379 Y127.858 E.01176
; LINE_WIDTH: 0.506955
G1 X167.563 Y128.084 E.01068
; LINE_WIDTH: 0.45975
G1 X167.778 Y128.474 E.01465
; LINE_WIDTH: 0.44999
G1 X167.93 Y128.973 E.01677
G1 X168.023 Y129.653 E.02209
G1 X168.041 Y129.985 E.01067
G3 X167.89 Y131.091 I-5.188 J-.144 E.03599
G3 X167.447 Y132.067 I-4.339 J-1.381 E.03454
G1 X166.996 Y132.602 E.02251
; LINE_WIDTH: 0.497223
G1 X166.886 Y132.658 E.00443
; LINE_WIDTH: 0.544455
G1 X166.776 Y132.714 E.00489
; LINE_WIDTH: 0.591688
G1 X166.666 Y132.77 E.00535
; LINE_WIDTH: 0.63892
M73 C0
G2 X166.317 Y132.967 I1.366 J2.829 E.0189
; LINE_WIDTH: 0.613815
G1 X166.078 Y133.108 E.01253
; LINE_WIDTH: 0.58871
G1 X165.833 Y133.189 E.0111
; LINE_WIDTH: 0.542895
G1 X165.589 Y133.27 E.01017
; LINE_WIDTH: 0.49708
G1 X165.239 Y133.364 E.013
; LINE_WIDTH: 0.458285
G1 X164.889 Y133.457 E.01189
; LINE_WIDTH: 0.41949
G1 X164.377 Y133.545 E.01544
; LINE_WIDTH: 0.43389
G1 X164.313 Y133.528 E.00206
; LINE_WIDTH: 0.48011
G1 X164.248 Y133.51 E.00231
; LINE_WIDTH: 0.52633
G1 X164.184 Y133.492 E.00255
; LINE_WIDTH: 0.57255
G1 X164.119 Y133.474 E.00279
; LINE_WIDTH: 0.61877
G1 X164.055 Y133.456 E.00304
; LINE_WIDTH: 0.66499
G1 F5787.131
G1 X163.991 Y133.438 E.00328
G1 X164.044 Y133.4 E.00322
; LINE_WIDTH: 0.61877
G1 F6000
G1 X164.097 Y133.362 E.00298
; LINE_WIDTH: 0.57255
G1 X164.15 Y133.323 E.00274
; LINE_WIDTH: 0.52633
G1 X164.203 Y133.285 E.0025
; LINE_WIDTH: 0.48011
G1 X164.256 Y133.247 E.00226
; LINE_WIDTH: 0.43389
G1 X164.309 Y133.208 E.00202
; LINE_WIDTH: 0.42204
G1 X164.716 Y133.095 E.01263
; LINE_WIDTH: 0.45641
G1 X165.122 Y132.982 E.01378
; LINE_WIDTH: 0.492004
G1 X165.321 Y132.888 E.0078
; LINE_WIDTH: 0.527597
G1 X165.52 Y132.794 E.00842
; LINE_WIDTH: 0.56319
G1 X165.718 Y132.699 E.00904
; LINE_WIDTH: 0.601055
G1 X165.96 Y132.524 E.01317
; LINE_WIDTH: 0.63892
G1 X166.201 Y132.348 E.01406
G1 X166.267 Y132.233 E.00622
; LINE_WIDTH: 0.591688
G1 X166.333 Y132.119 E.00573
; LINE_WIDTH: 0.544455
G1 X166.399 Y132.004 E.00523
; LINE_WIDTH: 0.497223
G1 X166.464 Y131.889 E.00474
; LINE_WIDTH: 0.44999
G1 X166.805 Y131.318 E.02138
G2 X167.072 Y130.417 I-3.145 J-1.423 E.03033
G1 X167.13 Y129.603 E.02624
G1 X167.024 Y128.761 E.02729
; LINE_WIDTH: 0.489587
G1 X166.968 Y128.532 E.00832
; LINE_WIDTH: 0.529184
G1 X166.912 Y128.303 E.00906
; LINE_WIDTH: 0.56878
G2 X166.758 Y127.895 I-.828 J.081 E.01834
; LINE_WIDTH: 0.55416
G1 X166.413 Y127.357 E.02578
G1 X165.963 Y126.886 E.02632
G1 X165.758 Y126.725 E.0105
; WIPE_START
G1 X166.308 Y126.951 E-.22581
G1 X167.196 Y127.632 E-.42517
G1 X167.377 Y127.855 E-.10902
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.021 Y125.818 Z2.2 F30000
G1 X157.039 Y124.992 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.490375
G1 F6000
M204 S3000
G1 X157.065 Y125.065 E.00274
; LINE_WIDTH: 0.44999
G1 X157.335 Y125.487 E.01613
G1 X157.695 Y125.765 E.01462
; LINE_WIDTH: 0.475755
G1 X157.963 Y125.858 E.0097
; LINE_WIDTH: 0.50152
G1 X158.231 Y125.951 E.01027
G1 X157.963 Y126.044 E.01027
; LINE_WIDTH: 0.475755
G1 X157.695 Y126.137 E.0097
; LINE_WIDTH: 0.44999
G1 X157.335 Y126.415 E.01462
G1 X157.065 Y126.837 E.01613
; LINE_WIDTH: 0.499353
G1 X157.014 Y126.969 E.00511
; LINE_WIDTH: 0.548715
G1 X156.963 Y127.101 E.00566
; LINE_WIDTH: 0.598078
G1 X156.912 Y127.234 E.00621
; LINE_WIDTH: 0.64744
G1 F5955.138
G1 X156.862 Y127.366 E.00676
G1 X156.862 Y131.904 E.21669
G1 X156.892 Y131.985 E.00414
; LINE_WIDTH: 0.598078
G1 F6000
G1 X156.922 Y132.066 E.0038
; LINE_WIDTH: 0.548715
G1 X156.953 Y132.147 E.00346
; LINE_WIDTH: 0.499353
G1 X156.983 Y132.228 E.00312
; LINE_WIDTH: 0.44999
G1 X157.181 Y132.729 E.01731
G1 X157.645 Y133.177 E.02074
; LINE_WIDTH: 0.492516
G1 X157.787 Y133.237 E.00547
; LINE_WIDTH: 0.535042
G1 X157.929 Y133.297 E.00599
; LINE_WIDTH: 0.577568
G1 X158.07 Y133.357 E.0065
; LINE_WIDTH: 0.620094
G1 X158.212 Y133.417 E.00702
; LINE_WIDTH: 0.66262
G1 F5809.263
G1 X158.354 Y133.477 E.00754
G1 X158.19 Y133.499 E.0081
; LINE_WIDTH: 0.620094
G1 F6000
G1 X158.026 Y133.52 E.00754
; LINE_WIDTH: 0.577568
G1 X157.862 Y133.541 E.00699
; LINE_WIDTH: 0.535042
G1 X157.698 Y133.563 E.00643
; LINE_WIDTH: 0.492516
G1 X157.534 Y133.584 E.00587
; LINE_WIDTH: 0.44999
G1 X156.158 Y133.584 E.04423
G3 X156.161 Y132.303 I216.084 J-.278 E.04118
; LINE_WIDTH: 0.499353
G1 X156.185 Y132.203 E.0037
; LINE_WIDTH: 0.548715
G1 X156.209 Y132.103 E.0041
; LINE_WIDTH: 0.598078
G1 X156.233 Y132.004 E.00451
; LINE_WIDTH: 0.64744
G1 F5955.138
G1 X156.257 Y131.904 E.00491
G1 X156.257 Y127.366 E.21669
G1 X156.232 Y127.189 E.00853
; LINE_WIDTH: 0.598078
G1 F6000
G1 X156.208 Y127.012 E.00783
; LINE_WIDTH: 0.548715
G1 X156.183 Y126.835 E.00714
; LINE_WIDTH: 0.499353
G1 X156.158 Y126.658 E.00644
; LINE_WIDTH: 0.44999
G3 X156.159 Y124.863 I897.144 J-.328 E.05775
; LINE_WIDTH: 0.499353
G1 X156.184 Y124.763 E.00371
; LINE_WIDTH: 0.548715
G1 X156.208 Y124.663 E.00411
; LINE_WIDTH: 0.598078
G1 X156.233 Y124.563 E.00451
; LINE_WIDTH: 0.64744
G1 F5955.138
G1 X156.257 Y124.463 E.00491
G1 X156.257 Y118.515 E.28404
G1 X156.862 Y118.515 E.02887
G1 X156.862 Y124.463 E.28404
G1 X156.88 Y124.536 E.00358
; LINE_WIDTH: 0.61153
G1 F6000
G1 X156.926 Y124.668 E.00629
; LINE_WIDTH: 0.571145
G1 X156.972 Y124.8 E.00585
; LINE_WIDTH: 0.53076
G1 X157.018 Y124.933 E.0054
; LINE_WIDTH: 0.490375
G1 X157.019 Y124.935 E.00009
; WIPE_START
G1 X157.065 Y125.065 E-.05223
G1 X157.335 Y125.487 E-.19063
G1 X157.695 Y125.765 E-.17281
G1 X157.963 Y125.858 E-.10777
G1 X158.231 Y125.951 E-.10777
G1 X157.963 Y126.044 E-.10777
G1 X157.911 Y126.062 E-.021
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.175 Y126.424 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X158.361 Y126.378 E.00615
G1 X161.886 Y126.373 E.11335
G3 X163.617 Y126.478 I-.173 J17.223 E.0558
; LINE_WIDTH: 0.494764
G1 X163.866 Y126.493 E.00889
; LINE_WIDTH: 0.539537
G1 X164.114 Y126.509 E.00977
; LINE_WIDTH: 0.58431
G1 X164.363 Y126.524 E.01065
; LINE_WIDTH: 0.59146
G1 X164.714 Y126.598 E.01554
G1 X164.859 Y126.697 E.00762
; LINE_WIDTH: 0.544304
G1 X165.005 Y126.796 E.00697
; LINE_WIDTH: 0.497147
G1 X165.15 Y126.895 E.00631
; LINE_WIDTH: 0.44999
G1 X165.553 Y127.131 E.01502
G1 X166.082 Y127.675 E.02438
G3 X166.674 Y129.055 I-3.241 J2.208 E.0486
G1 X166.725 Y129.637 E.01879
G1 X166.667 Y130.376 E.02383
G1 X166.5 Y130.993 E.02054
G1 X166.116 Y131.679 E.02529
G1 X165.881 Y131.962 E.01183
G1 X165.422 Y132.343 E.01917
G1 X164.936 Y132.617 E.01794
G1 X164.211 Y132.845 E.02446
G1 X163.947 Y132.899 E.00865
G3 X159.885 Y132.965 I-3.074 J-64.406 E.13068
G1 X158.354 Y132.964 E.04921
G1 X157.852 Y132.827 E.01674
G1 X157.524 Y132.509 E.01469
G1 X157.382 Y132.147 E.01251
G1 X157.367 Y131.904 E.00784
G1 X157.367 Y127.366 E.14591
G1 X157.441 Y126.991 E.01228
G1 X157.633 Y126.692 E.01142
G1 X157.888 Y126.496 E.01036
G1 X158.117 Y126.439 E.00759
M204 S10000
G1 X158.271 Y126.808 F30000
G1 F6000
M204 S3000
G1 X158.362 Y126.785 E.00299
G1 X161.887 Y126.78 E.11335
G3 X163.579 Y126.883 I-.172 J16.796 E.05454
G3 X164.604 Y127.072 I-.491 J5.546 E.03356
G1 X165.184 Y127.371 E.02099
G3 X165.889 Y128.101 I-2.819 J3.43 E.03271
G3 X166.274 Y129.135 I-3.476 J1.88 E.0356
G1 X166.319 Y129.672 E.01731
G1 X166.262 Y130.335 E.02143
G1 X166.113 Y130.867 E.01777
G1 X165.768 Y131.468 E.02228
G1 X165.54 Y131.716 E.01083
G1 X165.054 Y132.1 E.0199
G3 X163.915 Y132.494 I-1.679 J-3.016 E.03897
G3 X159.881 Y132.558 I-3.042 J-64.179 E.12974
G1 X158.355 Y132.557 E.04909
G1 X158.06 Y132.476 E.00984
G1 X157.866 Y132.29 E.00863
G1 X157.774 Y131.976 E.0105
G1 X157.774 Y127.366 E.14825
G3 X158.08 Y126.854 I.645 J.038 E.01992
G1 X158.213 Y126.822 E.00439
M204 S250
G1 X158.362 Y127.177 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X161.893 Y127.172 E.10516
G3 X164.424 Y127.42 I.072 J12.313 E.07589
G1 X165.004 Y127.719 E.01944
G1 X165.505 Y128.227 E.02124
G1 X165.714 Y128.621 E.01326
G1 X165.876 Y129.13 E.01591
G1 X165.928 Y129.705 E.0172
G1 X165.872 Y130.296 E.0177
G1 X165.722 Y130.787 E.01528
G1 X165.412 Y131.299 E.01784
G1 X164.996 Y131.658 E.01637
G1 X164.529 Y131.927 E.01603
G3 X163.883 Y132.103 I-2.965 J-9.624 E.01995
G3 X159.876 Y132.166 I-2.95 J-59.986 E.11939
G1 X158.355 Y132.165 E.04531
G1 X158.196 Y132.078 E.00538
G1 X158.167 Y131.904 E.00527
G1 X158.167 Y127.366 E.13516
G1 X158.217 Y127.237 E.00412
G1 X158.307 Y127.2 E.00289
; WIPE_START
M204 S3000
G1 X160.307 Y127.185 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.669 Y124.993 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X163.668 Y124.999 E.00017
G1 X163.715 Y125.26 E.00854
G1 X164.023 Y125.715 E.01766
; LINE_WIDTH: 0.494764
G1 X164.168 Y125.807 E.0061
; LINE_WIDTH: 0.539537
G1 X164.312 Y125.899 E.00671
; LINE_WIDTH: 0.58431
G1 X164.456 Y125.991 E.00731
; LINE_WIDTH: 0.59146
G2 X165.057 Y126.09 I.763 J-2.74 E.02648
; LINE_WIDTH: 0.544304
G1 X165.252 Y126.108 E.00773
; LINE_WIDTH: 0.497147
G1 X165.446 Y126.126 E.007
; LINE_WIDTH: 0.44999
G1 X166.044 Y126.31 E.0201
G3 X166.861 Y126.784 I-1.124 J2.878 E.03049
G1 X167.445 Y127.23 E.02364
G3 X168.195 Y128.42 I-3.964 J3.331 E.04537
G1 X168.333 Y128.917 E.0166
G1 X168.429 Y129.624 E.02294
G1 X168.452 Y129.952 E.01056
G3 X168.299 Y131.16 I-5.872 J-.128 E.03923
G3 X167.82 Y132.25 I-5.233 J-1.65 E.03837
G3 X167.13 Y133.047 I-3.619 J-2.437 E.03396
G3 X166.24 Y133.559 I-2.492 J-3.299 E.03312
G3 X163.428 Y133.981 I-3.134 J-11.322 E.09165
G3 X155.751 Y133.991 I-5.871 J-1516.206 E.24686
G1 X155.751 Y118.009 E.5139
G1 X157.367 Y118.009 E.05197
G1 X157.367 Y124.536 E.20987
G1 X157.441 Y124.91 E.01228
G1 X157.633 Y125.21 E.01142
G1 X157.888 Y125.406 E.01036
G1 X158.354 Y125.523 E.01544
G2 X159.657 Y125.516 I.551 J-16.827 E.04193
G1 X160.471 Y125.442 E.02626
G1 X161.383 Y125.22 E.03018
G1 X161.995 Y124.902 E.02217
G1 X162.489 Y124.525 E.02
G2 X163.864 Y122.844 I-11.355 J-10.692 E.0699
G2 X167.117 Y118.009 I-563.057 J-382.333 E.18738
G1 X169.103 Y118.009 E.06385
G1 X168.042 Y119.704 E.06431
G3 X165.914 Y122.749 I-21.326 J-12.637 E.11954
G3 X164.129 Y124.119 I-6.102 J-6.104 E.07257
G1 X163.883 Y124.339 E.01062
G1 X163.711 Y124.663 E.01181
G1 X163.676 Y124.934 E.00878
M204 S10000
G1 X164.087 Y124.974 F30000
G1 F6000
M204 S3000
G1 X164.082 Y125.051 E.00251
G1 X164.258 Y125.379 E.01194
G1 X164.545 Y125.525 E.01037
G3 X166.194 Y125.93 I-1.965 J11.554 E.05465
G3 X167.1 Y126.455 I-1.356 J3.387 E.03379
G1 X167.823 Y127.016 E.02943
G3 X168.309 Y127.736 I-26.563 J18.439 E.02793
G1 X168.583 Y128.298 E.0201
G1 X168.737 Y128.862 E.0188
G1 X168.835 Y129.595 E.0238
G1 X168.86 Y129.953 E.01151
G3 X168.693 Y131.269 I-6.396 J-.142 E.04273
G3 X168.166 Y132.468 I-5.757 J-1.815 E.04221
G3 X167.391 Y133.362 I-4.065 J-2.74 E.03816
G3 X166.379 Y133.945 I-2.831 J-3.749 E.03764
G3 X164.446 Y134.326 I-4.441 J-17.424 E.06338
G3 X162.393 Y134.398 I-1.726 J-19.976 E.0661
G1 X155.344 Y134.398 E.22665
G1 X155.344 Y117.602 E.54008
G1 X157.774 Y117.602 E.07815
G1 X157.774 Y123.602 E.19293
G2 X157.783 Y124.636 I10.241 J.43 E.03327
G1 X157.931 Y124.932 E.01062
G1 X158.08 Y125.047 E.00609
G1 X158.354 Y125.116 E.00908
G2 X159.624 Y125.11 I.551 J-16.4 E.04085
G1 X160.387 Y125.043 E.02463
G1 X161.204 Y124.854 E.02697
G1 X161.751 Y124.576 E.01974
G1 X162.208 Y124.231 E.0184
G2 X163.529 Y122.613 I-11.115 J-10.427 E.06723
G2 X166.9 Y117.602 I-585.512 J-397.5 E.19418
G1 X169.838 Y117.602 E.09447
G1 X168.777 Y119.297 E.06431
G3 X167.263 Y121.671 I-43.776 J-26.252 E.09056
G3 X166.214 Y123.025 I-17.544 J-12.501 E.05506
G3 X164.346 Y124.463 I-6.387 J-6.365 E.07605
G2 X164.109 Y124.786 I.371 J.519 E.01309
G1 X164.094 Y124.914 E.00413
M204 S250
G1 X164.466 Y124.963 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X164.526 Y125.092 E.00424
G1 X164.619 Y125.14 E.00312
G3 X166.339 Y125.565 I-1.826 J11.09 E.05283
G1 X166.969 Y125.874 E.0209
G3 X168.116 Y126.75 I-6.45 J9.633 E.04302
G3 X168.655 Y127.553 I-20.765 J14.534 E.02879
G1 X168.957 Y128.18 E.02074
G1 X169.125 Y128.809 E.01937
G1 X169.226 Y129.568 E.0228
G1 X169.253 Y129.953 E.01152
G3 X169.073 Y131.373 I-6.901 J-.155 E.04271
G3 X168.499 Y132.678 I-6.26 J-1.974 E.04252
G3 X167.642 Y133.667 I-4.495 J-3.032 E.03908
G3 X166.513 Y134.316 I-3.159 J-4.184 E.0389
G3 X163.449 Y134.78 I-3.427 J-12.295 E.09253
G3 X154.952 Y134.79 I-6.293 J-1662.649 E.25308
G1 X154.952 Y117.21 E.52364
G1 X158.167 Y117.21 E.09574
G1 X158.167 Y124.536 E.2182
G1 X158.217 Y124.664 E.00412
G1 X158.355 Y124.724 E.00447
G2 X159.592 Y124.719 I.552 J-15.99 E.03687
G1 X160.307 Y124.659 E.02135
G1 X161.032 Y124.502 E.02212
G1 X161.517 Y124.261 E.01612
G1 X161.937 Y123.947 E.01562
G2 X163.207 Y122.39 I-10.889 J-10.173 E.0599
G2 X166.691 Y117.21 I-605.419 J-410.95 E.18593
G1 X170.546 Y117.21 E.11483
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

G1 X168.424 Y120.601 E.11914
G3 X166.427 Y123.364 I-18.092 J-10.968 E.10167
G3 X164.532 Y124.812 I-6.882 J-7.046 E.07121
G1 X164.49 Y124.908 E.00312
; WIPE_START
M204 S3000
G1 X164.526 Y125.092 E-.07133
G1 X164.619 Y125.14 E-.0398
G1 X165.651 Y125.353 E-.4003
G1 X166.276 Y125.545 E-.24856
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.117 Y132.866 Z2.2 F30000
G1 X163.952 Y133.428 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.69138
G1 F5551.615
M204 S3000
G1 X163.415 Y133.455 E.02755
; LINE_WIDTH: 0.68656
G1 F5593.189
G1 X162.589 Y133.474 E.04197
; LINE_WIDTH: 0.66452
G1 F5791.506
G1 X161.889 Y133.479 E.03439
; LINE_WIDTH: 0.6602
G1 F5832.037
G1 X161.875 Y133.479 E.00067
; LINE_WIDTH: 0.66153
G1 F5819.499
G1 X159.875 Y133.478 E.09773
; LINE_WIDTH: 0.66262
G1 F5809.263
G1 X158.354 Y133.477 E.07446
; WIPE_START
G1 X159.875 Y133.478 E-.57805
G1 X160.354 Y133.478 E-.18195
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X160.522 Y125.908 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.5706
G1 F6000
M204 S3000
G1 X160.386 Y125.917 E.00568
; LINE_WIDTH: 0.55332
G1 X159.984 Y125.932 E.01621
; LINE_WIDTH: 0.52338
G1 X159.582 Y125.948 E.01526
; LINE_WIDTH: 0.49344
G1 X158.36 Y125.951 E.04349
; LINE_WIDTH: 0.50152
G1 X158.231 Y125.951 E.00468
; WIPE_START
G1 X158.36 Y125.951 E-.04905
G1 X159.582 Y125.948 E-.46433
G1 X159.984 Y125.932 E-.15274
G1 X160.231 Y125.923 E-.09388
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.703 Y123.848 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.5799
G1 F6000
M204 S3000
G1 X163.375 Y124.256 E.02218
; WIPE_START
G1 X163.703 Y123.848 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.299 Y125.614 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.36766
G1 F6000
M204 S3000
G3 X163.07 Y125.65 I.128 J5.536 E.01982
G3 X162.925 Y125.164 I.743 J-.487 E.0132
G1 X162.456 Y125.522 E.01514
G1 X162.351 Y125.584 E.00313
; WIPE_START
G1 X162.456 Y125.522 E-.0464
M73 P94 R1
G1 X162.925 Y125.164 E-.22459
G1 X162.968 Y125.438 E-.10542
G1 X163.07 Y125.65 E-.08967
G1 X162.801 Y125.625 E-.10269
G1 X162.299 Y125.614 E-.19123
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.309 Y122.187 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.484585
G1 F6000
M204 S3000
G1 X165.528 Y121.891 E.01286
; LINE_WIDTH: 0.517315
G1 X165.747 Y121.594 E.01381
; LINE_WIDTH: 0.562809
G2 X166.668 Y120.251 I-25.164 J-18.259 E.06687
; LINE_WIDTH: 0.55779
G1 X167.103 Y119.58 E.03254
; LINE_WIDTH: 0.53213
G1 X167.538 Y118.908 E.03092
; WIPE_START
G1 X167.103 Y119.58 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.353 Y127.208 Z2.2 F30000
G1 X167.399 Y128.628 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.46856
G1 F6000
M204 S3000
G1 X167.504 Y129 E.01299
; LINE_WIDTH: 0.501555
G1 X167.537 Y129.343 E.01249
; LINE_WIDTH: 0.529185
G1 X167.57 Y129.686 E.01324
; LINE_WIDTH: 0.570944
G1 X167.535 Y130.463 E.03246
G1 X167.442 Y130.924 E.01959
G1 X167.16 Y131.63 E.03172
; LINE_WIDTH: 0.54391
G1 X166.964 Y131.913 E.01364
; LINE_WIDTH: 0.51229
G1 X166.768 Y132.197 E.01278
; WIPE_START
G1 X166.964 Y131.913 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X159.339 Y132.245 Z2.2 F30000
G1 X156.54 Y132.367 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.39423
G1 F6000
M204 S3000
G1 X156.538 Y133.205 E.02325
G1 X157.136 Y133.205 E.01658
G1 X156.846 Y132.903 E.01159
G1 X156.626 Y132.346 E.01663
G1 X156.576 Y132.269 E.00254
G1 X156.561 Y132.311 E.00122
; WIPE_START
G1 X156.576 Y132.269 E-.01676
G1 X156.626 Y132.346 E-.03474
G1 X156.846 Y132.903 E-.22773
G1 X157.136 Y133.205 E-.15873
G1 X156.538 Y133.205 E-.22709
G1 X156.539 Y132.955 E-.09495
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X156.6 Y126.626 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.51896
G1 F6000
M204 S3000
G1 X156.627 Y126.723 E.00378
G1 X156.986 Y126.147 E.0255
G3 X157.224 Y125.951 I.658 J.554 E.01167
G1 X156.986 Y125.754 E.0116
G1 X156.676 Y125.27 E.02162
G1 X156.601 Y125.05 E.00877
G1 X156.6 Y126.566 E.05702
; WIPE_START
G1 X156.601 Y125.05 E-.57619
G1 X156.676 Y125.27 E-.08859
G1 X156.811 Y125.481 E-.09521
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X151.533 Y130.994 Z2.2 F30000
G1 X149.148 Y133.485 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.64744
G1 F5955.138
M204 S3000
G1 X149.148 Y118.515 E.71487
G1 X149.752 Y118.515 E.02887
G1 X149.752 Y118.817 E.01443
G1 X149.752 Y133.485 E.70043
G1 X149.208 Y133.485 E.026
M204 S10000
G1 X148.642 Y133.991 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X148.642 Y118.009 E.5139
G1 X150.258 Y118.009 E.05197
G1 X150.258 Y118.817 E.02598
G1 X150.258 Y133.991 E.48792
G1 X148.702 Y133.991 E.05004
M204 S10000
G1 X148.235 Y134.398 F30000
G1 F6000
M204 S3000
G1 X148.235 Y117.602 E.54008
G1 X150.665 Y117.602 E.07815
G1 X150.665 Y118.817 E.03907
G1 X150.665 Y134.398 E.50101
G1 X148.295 Y134.398 E.07622
M204 S250
G1 X147.843 Y134.79 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X147.843 Y117.21 E.52364
G1 X151.057 Y117.21 E.09574
G1 X151.057 Y118.817 E.04787
G1 X151.057 Y134.79 E.47576
G1 X147.903 Y134.79 E.09396
; WIPE_START
M204 S3000
G1 X147.896 Y132.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.575 Y128.512 Z2.2 F30000
G1 X132.26 Y122.207 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X132.607 Y122.422 E.01314
G1 X133.08 Y122.505 E.01544
; LINE_WIDTH: 0.494592
G1 X133.249 Y122.527 E.00606
; LINE_WIDTH: 0.539194
G1 X133.417 Y122.549 E.00665
; LINE_WIDTH: 0.583796
G1 X133.585 Y122.572 E.00725
; LINE_WIDTH: 0.628398
G1 X133.754 Y122.594 E.00785
; LINE_WIDTH: 0.673
G1 F5713.561
G1 X133.922 Y122.616 E.00845
G1 X133.793 Y122.701 E.00767
; LINE_WIDTH: 0.628398
G1 F6000
G1 X133.664 Y122.785 E.00713
; LINE_WIDTH: 0.583796
G1 X133.535 Y122.87 E.00659
; LINE_WIDTH: 0.539194
G1 X133.406 Y122.954 E.00604
; LINE_WIDTH: 0.494592
G1 X133.277 Y123.039 E.0055
; LINE_WIDTH: 0.44999
G1 X132.971 Y123.409 E.01544
G1 X132.795 Y123.95 E.01832
; LINE_WIDTH: 0.49873
G1 X132.811 Y124.272 E.01159
; LINE_WIDTH: 0.54747
G1 X132.826 Y124.594 E.01283
G1 X133.52 Y126.469 E.07971
; LINE_WIDTH: 0.52512
G1 X134.215 Y128.345 E.07618
; LINE_WIDTH: 0.50277
G1 X134.909 Y130.22 E.07265
; LINE_WIDTH: 0.48042
G1 X135.325 Y131.343 E.04138
; LINE_WIDTH: 0.4791
G1 X135.439 Y131.594 E.00948
G1 X135.761 Y131.943 E.01639
; LINE_WIDTH: 0.44999
G1 X136.348 Y132.226 E.02096
G2 X137 Y132.212 I.295 J-1.364 E.02115
G1 X137.552 Y131.921 E.02006
; LINE_WIDTH: 0.49224
G1 X137.709 Y131.771 E.00772
; LINE_WIDTH: 0.53449
G1 X137.865 Y131.62 E.00845
G1 X137.985 Y131.361 E.01106
; LINE_WIDTH: 0.54743
G1 X138.693 Y129.491 E.07971
; LINE_WIDTH: 0.57275
G1 X139.401 Y127.62 E.08371
; LINE_WIDTH: 0.59806
G1 X140.109 Y125.75 E.0877
; LINE_WIDTH: 0.61344
G1 X140.539 Y124.614 E.05473
; LINE_WIDTH: 0.62651
G1 X140.606 Y124.405 E.01011
G1 X140.591 Y124.3 E.00491
; LINE_WIDTH: 0.58238
G1 X140.576 Y124.194 E.00453
; LINE_WIDTH: 0.53825
G1 X140.56 Y124.089 E.00416
; LINE_WIDTH: 0.49412
G1 X140.545 Y123.984 E.00379
; LINE_WIDTH: 0.44999
G1 X140.391 Y123.454 E.01774
G1 X140.09 Y123.065 E.01582
; LINE_WIDTH: 0.49006
G1 X139.903 Y122.973 E.00736
; LINE_WIDTH: 0.53013
G1 X139.716 Y122.881 E.00802
; LINE_WIDTH: 0.5702
G1 X139.529 Y122.789 E.00868
; LINE_WIDTH: 0.61027
G1 X139.342 Y122.697 E.00934
; LINE_WIDTH: 0.65034
G1 F5926.707
G1 X139.155 Y122.605 E.01
G1 X139.385 Y122.585 E.01108
; LINE_WIDTH: 0.61027
G1 F6000
G1 X139.615 Y122.565 E.01035
; LINE_WIDTH: 0.5702
G1 X139.845 Y122.545 E.00962
; LINE_WIDTH: 0.53013
G1 X140.075 Y122.525 E.00889
; LINE_WIDTH: 0.49006
G1 X140.305 Y122.505 E.00816
; LINE_WIDTH: 0.44999
G1 X140.79 Y122.418 E.01582
G1 X141.266 Y122.121 E.01805
; LINE_WIDTH: 0.496235
G1 X141.373 Y122.002 E.00574
; LINE_WIDTH: 0.54248
G1 X141.48 Y121.882 E.00632
; LINE_WIDTH: 0.588725
G1 X141.587 Y121.763 E.00691
; LINE_WIDTH: 0.63497
G1 X141.694 Y121.644 E.00749
; LINE_WIDTH: 0.64785
G1 F5951.102
G1 X142.365 Y119.915 E.08863
G1 X142.378 Y119.813 E.00492
; LINE_WIDTH: 0.598385
G1 F6000
G1 X142.391 Y119.71 E.00452
; LINE_WIDTH: 0.54892
G1 X142.403 Y119.608 E.00412
; LINE_WIDTH: 0.499455
G1 X142.416 Y119.506 E.00371
; LINE_WIDTH: 0.44999
G1 X142.835 Y118.416 E.03754
G1 X143.117 Y118.416 E.00906
G1 X143.723 Y118.416 E.0195
G1 X143.169 Y119.801 E.04798
; LINE_WIDTH: 0.499455
G1 X143.108 Y119.885 E.00371
; LINE_WIDTH: 0.54892
G1 X143.048 Y119.969 E.00412
; LINE_WIDTH: 0.598385
G1 X142.988 Y120.052 E.00452
; LINE_WIDTH: 0.64785
G1 F5951.102
G1 X142.928 Y120.136 E.00492
G1 X142.245 Y121.86 E.08863
; LINE_WIDTH: 0.63497
G1 F6000
G2 X142.185 Y122.072 I.879 J.363 E.01034
; LINE_WIDTH: 0.588665
G1 X142.134 Y122.262 E.00845
; LINE_WIDTH: 0.54244
G1 X142.083 Y122.451 E.00774
; LINE_WIDTH: 0.496215
G1 X142.032 Y122.64 E.00702
; LINE_WIDTH: 0.44999
G1 X141.44 Y124.118 E.05118
; LINE_WIDTH: 0.49412
G1 X141.371 Y124.232 E.00475
; LINE_WIDTH: 0.53825
G1 X141.301 Y124.346 E.00522
; LINE_WIDTH: 0.58238
G1 X141.232 Y124.46 E.00568
; LINE_WIDTH: 0.62651
G2 X141.071 Y124.819 I.849 J.595 E.01827
; LINE_WIDTH: 0.61344
G1 X140.34 Y126.681 E.09013
; LINE_WIDTH: 0.58812
G1 X139.608 Y128.542 E.08613
; LINE_WIDTH: 0.5628
G1 X138.876 Y130.403 E.08213
; LINE_WIDTH: 0.53749
G1 X138.432 Y131.534 E.04744
; LINE_WIDTH: 0.53449
G2 X138.224 Y132.093 I2.728 J1.333 E.02323
; LINE_WIDTH: 0.49224
G1 X138.146 Y132.346 E.0094
; LINE_WIDTH: 0.44999
G1 X137.65 Y133.584 E.04287
G1 X135.734 Y133.584 E.06162
G1 X135.242 Y132.321 E.04358
; LINE_WIDTH: 0.46705
G1 X134.928 Y131.492 E.02968
; LINE_WIDTH: 0.48939
G1 X134.213 Y129.625 E.07054
; LINE_WIDTH: 0.51174
G1 X133.497 Y127.757 E.07407
; LINE_WIDTH: 0.53409
G1 X132.782 Y125.89 E.0776
; LINE_WIDTH: 0.54747
G1 X132.354 Y124.772 E.04772
G1 X132.188 Y124.412 E.01577
; LINE_WIDTH: 0.49873
G1 X132.021 Y124.053 E.01425
; LINE_WIDTH: 0.44999
G1 X131.443 Y122.568 E.05125
; LINE_WIDTH: 0.496537
G1 X131.409 Y122.416 E.00561
; LINE_WIDTH: 0.543084
G1 X131.374 Y122.263 E.00618
; LINE_WIDTH: 0.58963
G2 X131.21 Y121.796 I-1.457 J.249 E.02147
; LINE_WIDTH: 0.59965
G1 X130.495 Y119.928 E.08796
; LINE_WIDTH: 0.61243
G2 X129.945 Y118.497 I-125.093 J47.302 E.06897
G1 X130.561 Y118.497 E.02771
G2 X131.323 Y120.561 I181.144 J-65.717 E.09895
; LINE_WIDTH: 0.58954
G1 X131.71 Y121.608 E.04822
G1 X131.828 Y121.869 E.01239
G1 X131.924 Y121.952 E.00548
; LINE_WIDTH: 0.543084
G1 X132.02 Y122.035 E.00501
; LINE_WIDTH: 0.496537
G1 X132.116 Y122.118 E.00454
; LINE_WIDTH: 0.44999
G1 X132.209 Y122.175 E.00351
M204 S10000
G1 X132.493 Y121.883 F30000
G1 F6000
M204 S3000
G1 X132.745 Y122.039 E.00955
G1 X133.08 Y122.098 E.01093
G1 X140.305 Y122.098 E.23232
G1 X140.648 Y122.036 E.01121
G1 X140.986 Y121.826 E.01278
G1 X141.222 Y121.477 E.01355
G1 X142.555 Y118.009 E.11948
G1 X143.117 Y118.009 E.01806
G1 X144.325 Y118.009 E.03884
G1 X137.925 Y133.991 E.55357
G1 X135.455 Y133.991 E.07943
G1 X129.23 Y118.009 E.55151
G1 X130.903 Y118.009 E.05377
G1 X131.586 Y119.889 E.06431
G2 X132.16 Y121.469 I67.873 J-23.781 E.05405
G1 X132.398 Y121.824 E.01374
G1 X132.442 Y121.851 E.00168
M204 S10000
G1 X132.726 Y121.559 F30000
G1 F6000
M204 S3000
G1 X132.884 Y121.656 E.00596
G1 X133.08 Y121.691 E.00643
G1 X140.305 Y121.691 E.23232
G1 X140.419 Y121.68 E.00367
G1 X140.705 Y121.531 E.01037
G1 X140.844 Y121.326 E.00797
G1 X142.276 Y117.602 E.12829
G1 X143.117 Y117.602 E.02705
G1 X144.926 Y117.602 E.05818
G1 X138.201 Y134.398 E.58177
G1 X135.177 Y134.398 E.09724
G1 X128.635 Y117.602 E.5796
G1 X131.188 Y117.602 E.08209
G1 X132.535 Y121.308 E.1268
G1 X132.676 Y121.526 E.00834
M204 S250
G1 X132.95 Y121.246 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X133.08 Y121.299 E.00418
G1 X140.371 Y121.287 E.21715
G1 X140.48 Y121.18 E.00456
G1 X142.006 Y117.21 E.12669
G1 X143.117 Y117.21 E.03308
G1 X145.506 Y117.21 E.07115
G1 X138.466 Y134.79 E.56405
G1 X134.909 Y134.79 E.10596
G1 X128.062 Y117.21 E.56195
G1 X131.463 Y117.21 E.1013
G1 X132.829 Y120.97 E.11914
G2 X132.916 Y121.197 I.653 J-.121 E.00729
; WIPE_START
M204 S3000
G1 X133.08 Y121.299 E-.07341
G1 X134.887 Y121.296 E-.68659
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.232 Y124.258 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X133.2 Y123.994 E.00856
G1 X133.324 Y123.61 E.01297
G1 X133.541 Y123.348 E.01093
G1 X134.011 Y123.127 E.01671
G1 X134.182 Y123.112 E.00551
G1 X139.155 Y123.112 E.1599
G1 X139.817 Y123.367 E.02281
G1 X140.03 Y123.643 E.01121
G1 X140.139 Y124.018 E.01256
G1 X140.081 Y124.444 E.01383
G1 X137.57 Y131.207 E.23198
G3 X137.287 Y131.613 I-.926 J-.344 E.01607
G1 X136.814 Y131.836 E.01681
G1 X136.435 Y131.828 E.01221
G1 X136.019 Y131.628 E.01484
G1 X135.799 Y131.375 E.01077
G1 X135.716 Y131.201 E.00622
G1 X133.254 Y124.438 E.23143
G1 X133.239 Y124.318 E.00388
M204 S10000
G1 X133.626 Y124.21 F30000
G1 F6000
M204 S3000
G1 X133.605 Y124.038 E.0056
G1 X133.728 Y123.738 E.01044
G1 X133.805 Y123.658 E.00356
G1 X134.082 Y123.528 E.00982
G1 X134.182 Y123.519 E.00324
G1 X139.155 Y123.519 E.1599
G1 X139.544 Y123.669 E.01341
G3 X139.734 Y124.052 I-.389 J.431 E.01406
G1 X139.699 Y124.302 E.00813
G1 X137.188 Y131.065 E.23198
G1 X137.022 Y131.304 E.00935
G1 X136.744 Y131.435 E.00988
G1 X136.521 Y131.43 E.00718
G1 X136.276 Y131.313 E.00872
G1 X136.098 Y131.062 E.0099
G1 X133.637 Y124.299 E.23143
G1 X133.633 Y124.27 E.00092
M204 S250
G1 X134.005 Y124.164 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X134.018 Y124.006 E.00472
G1 X134.15 Y123.914 E.00478
G1 X134.182 Y123.911 E.00097
G1 X139.155 Y123.911 E.14812
G1 X139.322 Y124.013 E.00582
G1 X139.332 Y124.166 E.00457
G1 X136.819 Y130.933 E.21502
G1 X136.692 Y131.045 E.00505
G1 X136.524 Y131.009 E.0051
G1 X136.467 Y130.928 E.00298
G1 X134.025 Y124.221 E.21258
; WIPE_START
M204 S3000
G1 X134.018 Y124.006 E-.0815
G1 X134.15 Y123.914 E-.06093
G1 X134.182 Y123.911 E-.01243
G1 X135.775 Y123.911 E-.60515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.922 Y122.616 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.673
G1 F5713.561
M204 S3000
G1 X134.182 Y122.605 E.01297
; LINE_WIDTH: 0.65034
G1 F5926.707
G1 X139.155 Y122.605 E.23861
; WIPE_START
G1 X137.155 Y122.605 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.446 Y122.876 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X140.739 Y123.272 E.01468
G3 X140.975 Y124.076 I-72.571 J21.818 E.02495
G1 X141.093 Y123.931 E.00556
G1 X141.66 Y122.515 E.04542
G1 X141.697 Y122.261 E.00764
G1 X141.506 Y122.429 E.00757
G1 X140.96 Y122.769 E.01916
G1 X140.628 Y122.866 E.01031
G1 X140.506 Y122.872 E.00363
M204 S10000
G1 X141.066 Y123.077 F30000
; LINE_WIDTH: 0.36076
G1 F6000
M204 S3000
G1 X141.007 Y123.112 E.00173
G1 X141.049 Y123.136 E.00122
; WIPE_START
G1 X141.007 Y123.112 E-.31439
G1 X141.066 Y123.077 E-.44561
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X142.811 Y119.607 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.45066
G1 F6000
M204 S3000
G1 X143.095 Y118.882 E.02508
; WIPE_START
G1 X142.811 Y119.607 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.723 Y122.44 Z2.2 F30000
G1 X132.39 Y123.773 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.52597
G1 F6000
M204 S3000
G1 X132.564 Y123.233 E.02163
G1 X132.76 Y122.934 E.01362
G1 X132.408 Y122.817 E.01413
G1 X131.888 Y122.485 E.02354
G1 X132.368 Y123.717 E.05042
; WIPE_START
G1 X131.888 Y122.485 E-.50212
G1 X132.408 Y122.817 E-.23445
G1 X132.467 Y122.837 E-.02343
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.946 Y130.055 Z2.2 F30000
G1 X135.762 Y132.432 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.525497
G1 F6000
M204 S3000
G1 X136.038 Y133.139 E.02893
G2 X137.345 Y133.133 I.545 J-25.672 E.04984
G1 X137.649 Y132.374 E.03119
G1 X137.167 Y132.627 E.02078
G1 X136.644 Y132.691 E.02008
G1 X136.2 Y132.643 E.017
G1 X135.816 Y132.458 E.01625
; WIPE_START
G1 X136.2 Y132.643 E-.16196
G1 X136.644 Y132.691 E-.16947
G1 X137.167 Y132.627 E-.20018
G1 X137.649 Y132.374 E-.20715
G1 X137.628 Y132.425 E-.02124
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.79 Y129.036 Z2.2 F30000
G1 X116.014 Y121.712 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X115.528 Y121.865 E.01637
; LINE_WIDTH: 0.48374
G1 X115.27 Y122.095 E.01203
; LINE_WIDTH: 0.51749
G1 X115.012 Y122.325 E.01295
; LINE_WIDTH: 0.52135
G1 X113.965 Y124.029 E.07558
; LINE_WIDTH: 0.52522
G1 X112.918 Y125.733 E.0762
; LINE_WIDTH: 0.52909
G1 X111.872 Y127.437 E.07681
; LINE_WIDTH: 0.53296
G1 X110.825 Y129.141 E.07742
; LINE_WIDTH: 0.53414
G1 X110.506 Y129.661 E.02366
; LINE_WIDTH: 0.54686
G2 X110.225 Y130.154 I2.129 J1.541 E.02264
; LINE_WIDTH: 0.498425
G1 X110.098 Y130.406 E.01015
; LINE_WIDTH: 0.44999
G1 X108.151 Y133.584 E.11984
G1 X106.824 Y133.584 E.04267
G1 X106.824 Y129.458 E.13265
; LINE_WIDTH: 0.484255
G1 X106.841 Y129.039 E.01465
; LINE_WIDTH: 0.51852
G1 X106.858 Y128.619 E.01578
G1 X106.858 Y118.45 E.38202
G1 X107.334 Y118.45 E.01787
G1 X107.334 Y128.619 E.38202
; LINE_WIDTH: 0.53115
G2 X107.442 Y129.073 I.656 J.084 E.01841
; LINE_WIDTH: 0.49057
G1 X107.535 Y129.28 E.008
; LINE_WIDTH: 0.44999
G1 X107.933 Y129.74 E.01957
G1 X108.484 Y129.99 E.01947
G1 X108.982 Y130.038 E.01608
G1 X109.562 Y129.856 E.01956
; LINE_WIDTH: 0.498425
G1 X109.755 Y129.73 E.00828
; LINE_WIDTH: 0.54686
G2 X110.088 Y129.403 I-.246 J-.583 E.01899
; LINE_WIDTH: 0.53414
G1 X111.138 Y127.701 E.07761
; LINE_WIDTH: 0.53027
G1 X112.188 Y125.999 E.07699
; LINE_WIDTH: 0.5264
G1 X113.238 Y124.297 E.07638
; LINE_WIDTH: 0.52253
G1 X114.288 Y122.595 E.07577
; LINE_WIDTH: 0.51866
G1 X114.608 Y122.076 E.02291
; LINE_WIDTH: 0.51749
G2 X114.816 Y121.707 I-4.565 J-2.82 E.01587
; LINE_WIDTH: 0.483735
G1 X115.02 Y121.344 E.01452
; LINE_WIDTH: 0.44999
G1 X116.83 Y118.416 E.11068
G1 X118.271 Y118.416 E.04634
G1 X118.271 Y119.341 E.02975
G1 X118.271 Y122.259 E.09382
; LINE_WIDTH: 0.484255
G1 X118.254 Y122.679 E.01467
; LINE_WIDTH: 0.51852
G1 X118.237 Y123.1 E.01581
G1 X118.237 Y133.55 E.39258
G1 X117.762 Y133.55 E.01787
G1 X117.762 Y123.1 E.39258
G1 X117.661 Y122.769 E.01299
; LINE_WIDTH: 0.484255
G1 X117.56 Y122.438 E.01205
; LINE_WIDTH: 0.44999
G1 X117.161 Y121.978 E.01959
G1 X116.609 Y121.729 E.01949
G1 X116.109 Y121.681 E.01613
G1 X116.071 Y121.694 E.00129
M204 S10000
G1 X116.081 Y122.107 F30000
G1 F6000
M204 S3000
G1 X115.733 Y122.217 E.01174
G1 X115.39 Y122.552 E.01541
G1 X108.379 Y133.991 E.43142
G1 X106.417 Y133.991 E.06309
G1 X106.417 Y118.009 E.5139
G1 X107.775 Y118.009 E.04368
G1 X107.775 Y128.009 E.32156
G2 X107.79 Y128.79 I4.494 J.305 E.02513
G1 X107.893 Y129.087 E.01011
G1 X108.175 Y129.413 E.01386
G1 X108.493 Y129.569 E.0114
G1 X108.948 Y129.632 E.01477
G1 X109.359 Y129.503 E.01385
G1 X109.606 Y129.302 E.01024
G1 X109.705 Y129.167 E.00539
G1 X116.603 Y118.009 E.42182
G1 X118.678 Y118.009 E.06672
G1 X118.678 Y119.341 E.04284
G1 X118.678 Y133.991 E.47106
G1 X117.32 Y133.991 E.04368
G1 X117.32 Y123.1 E.3502
G1 X117.202 Y122.631 E.01554
G1 X116.919 Y122.306 E.01387
G1 X116.601 Y122.149 E.01141
G1 X116.145 Y122.087 E.01481
G1 X116.138 Y122.089 E.00021
M204 S10000
G1 X116.148 Y122.502 F30000
G1 F6000
M204 S3000
G1 X115.938 Y122.569 E.0071
G1 X115.736 Y122.766 E.00906
G1 X108.607 Y134.398 E.4387
G1 X106.01 Y134.398 E.08351
G1 X106.01 Y117.602 E.54008
G1 X108.182 Y117.602 E.06986
G1 X108.182 Y128.619 E.35425
G1 X108.252 Y128.894 E.00912
G1 X108.417 Y129.085 E.00814
G1 X108.604 Y129.177 E.0067
G1 X108.914 Y129.226 E.01008
G1 X109.156 Y129.151 E.00814
G1 X109.359 Y128.953 E.00912
G1 X116.377 Y117.602 E.42912
G1 X119.086 Y117.602 E.08711
G1 X119.086 Y119.341 E.05593
G1 X119.086 Y134.398 E.48415
G1 X116.913 Y134.398 E.06986
G1 X116.913 Y123.1 E.36329
G1 X116.844 Y122.825 E.00913
G1 X116.677 Y122.633 E.00815
G1 X116.49 Y122.541 E.00671
G1 X116.207 Y122.497 E.00923
M204 S250
G1 X116.214 Y122.883 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X116.069 Y122.972 E.00504
G1 X108.826 Y134.79 E.41287
G1 X105.618 Y134.79 E.09557
G1 X105.618 Y117.21 E.52364
G1 X108.574 Y117.21 E.08806
G1 X108.574 Y128.619 E.33982
G1 X108.651 Y128.77 E.00505
G1 X108.881 Y128.836 E.00713
G1 X109.026 Y128.747 E.00505
G1 X116.158 Y117.21 E.404
G1 X119.478 Y117.21 E.09888
G1 X119.478 Y119.341 E.06349
G1 X119.478 Y134.79 E.46015
G1 X116.521 Y134.79 E.08806
G1 X116.521 Y123.1 E.3482
G1 X116.445 Y122.948 E.00506
G1 X116.271 Y122.899 E.00536
; WIPE_START
M204 S3000
G1 X116.069 Y122.972 E-.08148
G1 X115.136 Y124.494 E-.67852
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.879 Y122.215 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S3000
G1 X117.879 Y118.808 E.10148
G1 X117.049 Y118.808 E.02473
G1 X115.381 Y121.506 E.09447
G1 X116.035 Y121.299 E.02042
G1 X116.79 Y121.375 E.0226
G1 X117.365 Y121.645 E.01894
G1 X117.839 Y122.171 E.02108
M204 S10000
G1 X117.502 Y121.292 F30000
G1 F6000
M204 S3000
G1 X117.502 Y119.185 E.06276
G1 X117.259 Y119.185 E.00724
G1 X116.186 Y120.92 E.06076
G1 X116.836 Y121 E.01949
G1 X117.447 Y121.268 E.01989
M204 S10000
G1 X117.161 Y120.746 F30000
; LINE_WIDTH: 0.34827
G1 F6000
M204 S3000
G1 X117.161 Y119.993 E.01816
G1 X116.757 Y120.647 E.01855
G1 X117.103 Y120.732 E.00859
; WIPE_START
G1 X116.757 Y120.647 E-.14416
G1 X117.161 Y119.993 E-.31115
G1 X117.161 Y120.746 E-.30469
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.455 Y126.755 Z2.2 F30000
G1 X109.758 Y130.2 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S3000
G1 X109.055 Y130.421 E.02192
G1 X108.303 Y130.343 E.02253
G1 X107.728 Y130.072 E.01892
G1 X107.216 Y129.503 E.02281
G1 X107.216 Y133.192 E.10987
G1 X107.931 Y133.192 E.0213
G1 X109.732 Y130.253 E.10265
M204 S10000
G1 X108.955 Y130.799 F30000
G1 F6000
M204 S3000
G1 X108.256 Y130.718 E.02097
G1 X107.593 Y130.426 E.02157
G1 X107.593 Y132.815 E.07115
G1 X107.72 Y132.815 E.00378
G1 X108.924 Y130.851 E.06861
M204 S10000
G1 X108.37 Y131.084 F30000
; LINE_WIDTH: 0.36547
G1 F6000
M204 S3000
G1 X107.943 Y130.985 E.01118
G1 X107.943 Y131.782 E.0203
G1 X108.339 Y131.136 E.01931
; WIPE_START
G1 X107.943 Y131.782 E-.28893
G1 X107.943 Y130.985 E-.30379
G1 X108.37 Y131.084 E-.16729
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.412 Y125.282 Z2.2 F30000
G1 X99.113 Y120.25 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.62765
G1 F6000
M204 S3000
G1 X99.519 Y120.835 E.03288
; LINE_WIDTH: 0.65379
G1 F5893.234
G1 X99.943 Y121.497 E.03794
; LINE_WIDTH: 0.67899
G1 F5659.754
G1 X100.344 Y122.265 E.04354
; LINE_WIDTH: 0.69131
G1 F5552.214
G1 X100.64 Y123.097 E.04519
; LINE_WIDTH: 0.69322
G1 F5535.907
G1 X100.809 Y123.898 E.04205
; LINE_WIDTH: 0.69533
G1 F5518.003
G1 X100.902 Y124.648 E.03894
; LINE_WIDTH: 0.70139
G1 F5467.22
G1 X100.954 Y125.342 E.03622
; LINE_WIDTH: 0.70824
G1 F5410.93
G1 X100.986 Y125.995 E.03434
G1 X100.98 Y126.141 E.0077
; LINE_WIDTH: 0.70367
G1 F5448.354
G1 X100.944 Y126.829 E.03599
; LINE_WIDTH: 0.6958
G1 F5514.03
G1 X100.871 Y127.682 E.04412
; LINE_WIDTH: 0.68917
G1 F5570.599
G1 X100.748 Y128.474 E.04091
; LINE_WIDTH: 0.68385
G1 F5616.838
G1 X100.547 Y129.223 E.03929
; LINE_WIDTH: 0.67058
G1 F5735.59
G1 X100.215 Y130.001 E.04191
; LINE_WIDTH: 0.64157
G1 F6000
M73 P95 R1
G1 X99.84 Y130.667 E.03615
; LINE_WIDTH: 0.61327
G1 X99.465 Y131.247 E.03114
; LINE_WIDTH: 0.59077
G1 X99.09 Y131.783 E.02829
; LINE_WIDTH: 0.56887
G1 X98.693 Y132.139 E.02217
; LINE_WIDTH: 0.52633
G1 X98.227 Y132.505 E.02262
; LINE_WIDTH: 0.50563
G1 X97.801 Y132.815 E.01925
; LINE_WIDTH: 0.48864
G1 X97.308 Y133.126 E.02052
; LINE_WIDTH: 0.48033
G1 X96.639 Y133.443 E.02558
; LINE_WIDTH: 0.44533
G1 X95.67 Y133.709 E.03194
; LINE_WIDTH: 0.40002
G1 X95.045 Y133.808 E.01784
; LINE_WIDTH: 0.38552
G1 X94.476 Y133.87 E.0155
; LINE_WIDTH: 0.38332
G1 X93.675 Y133.918 E.02157
; LINE_WIDTH: 0.40529
G1 X92.892 Y133.871 E.02247
; LINE_WIDTH: 0.42445
G1 X92.043 Y133.76 E.02578
; LINE_WIDTH: 0.45442
G1 X91.025 Y133.474 E.03438
; LINE_WIDTH: 0.50141
G1 X90.441 Y133.252 E.02262
; LINE_WIDTH: 0.53482
G1 X89.961 Y132.991 E.02124
; LINE_WIDTH: 0.56493
G1 X89.487 Y132.682 E.02333
; LINE_WIDTH: 0.57334
G1 X89.056 Y132.333 E.02326
; LINE_WIDTH: 0.57936
G1 X88.628 Y131.93 E.02489
; LINE_WIDTH: 0.62063
G1 X88.237 Y131.45 E.02828
; LINE_WIDTH: 0.65307
G1 F5900.189
G1 X87.875 Y130.946 E.02991
; LINE_WIDTH: 0.66492
G1 F5787.781
G1 X87.573 Y130.433 E.02924
; LINE_WIDTH: 0.67098
G1 F5731.937
G3 X87.152 Y129.461 I4.076 J-2.346 E.05265
; LINE_WIDTH: 0.66893
G1 F5750.707
G1 X86.989 Y128.954 E.02635
; LINE_WIDTH: 0.68253
G1 F5628.43
G1 X86.861 Y128.465 E.02552
; LINE_WIDTH: 0.69288
G1 F5538.803
G1 X86.763 Y127.969 E.02599
; LINE_WIDTH: 0.69631
G1 F5509.726
G1 X86.693 Y127.409 E.02913
; LINE_WIDTH: 0.69765
G1 F5498.45
G1 X86.648 Y126.717 E.03583
; LINE_WIDTH: 0.70295
G1 F5454.297
G3 X86.666 Y125.068 I9.278 J-.721 E.08612
; LINE_WIDTH: 0.69762
G1 F5498.702
G1 X86.745 Y124.218 E.04415
; LINE_WIDTH: 0.70046
G1 F5474.952
G3 X87.059 Y122.75 I7.377 J.81 E.07811
; LINE_WIDTH: 0.69731
G1 F5501.306
G1 X87.374 Y122.011 E.04153
; LINE_WIDTH: 0.67715
G1 F5676.175
G1 X87.755 Y121.338 E.03872
; LINE_WIDTH: 0.65373
G1 F5893.814
G1 X88.137 Y120.754 E.03368
; LINE_WIDTH: 0.63447
G1 F6000
G1 X88.567 Y120.166 E.03405
; LINE_WIDTH: 0.61541
G1 X89.044 Y119.756 E.02844
; LINE_WIDTH: 0.56834
G1 X89.683 Y119.271 E.03332
; LINE_WIDTH: 0.54058
G1 X90.294 Y118.877 E.02857
; LINE_WIDTH: 0.50992
G1 X90.864 Y118.598 E.0234
; LINE_WIDTH: 0.48094
G1 X91.253 Y118.464 E.01423
; LINE_WIDTH: 0.45019
G1 X91.939 Y118.293 E.02276
; LINE_WIDTH: 0.41627
G1 X92.567 Y118.193 E.01876
; LINE_WIDTH: 0.39581
G1 X93.139 Y118.13 E.01603
; LINE_WIDTH: 0.38635
G1 X93.977 Y118.089 E.02276
; LINE_WIDTH: 0.3882
G1 X94.595 Y118.139 E.01691
; LINE_WIDTH: 0.41176
G1 X95.4 Y118.239 E.02363
; LINE_WIDTH: 0.44175
G1 X96.251 Y118.426 E.02744
; LINE_WIDTH: 0.47238
G1 X96.783 Y118.607 E.01909
; LINE_WIDTH: 0.50874
G1 X97.354 Y118.896 E.02356
; LINE_WIDTH: 0.52076
G1 X97.822 Y119.196 E.02096
; LINE_WIDTH: 0.54287
G1 X98.298 Y119.548 E.02339
; LINE_WIDTH: 0.56401
G1 X98.709 Y119.875 E.02164
; LINE_WIDTH: 0.60619
G1 X99.069 Y120.21 E.02184
M204 S10000
G1 X99.427 Y119.856 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G3 X100.769 Y121.928 I-13.281 J10.073 E.07945
G1 X101.044 Y122.591 E.02308
G3 X101.429 Y124.6 I-11.292 J3.208 E.06587
G3 X101.521 Y126.025 I-22.964 J2.199 E.04591
G3 X101.265 Y128.565 I-19.765 J-.707 E.08217
G1 X101.063 Y129.331 E.02545
G1 X100.764 Y130.052 E.0251
G3 X99.41 Y132.136 I-14.655 J-8.037 E.08001
G3 X97.522 Y133.492 I-9.894 J-11.784 E.0748
G1 X96.869 Y133.796 E.02316
G3 X95.408 Y134.145 I-2.29 J-6.35 E.04841
G3 X93.766 Y134.296 I-2.973 J-23.377 E.05303
G3 X91.984 Y134.151 I.122 J-12.532 E.05753
G3 X90.289 Y133.661 I2.268 J-11.009 E.0568
G3 X87.861 Y131.769 I2.638 J-5.89 E.09994
G3 X86.828 Y130.109 I6.497 J-5.194 E.063
G3 X86.172 Y127.551 I10.381 J-4.026 E.08513
G3 X86.085 Y125.9 I18.562 J-1.805 E.05317
G3 X86.346 Y123.348 I19.612 J.713 E.08254
G1 X86.547 Y122.598 E.02497
G1 X86.843 Y121.891 E.02465
G3 X88.18 Y119.848 I14.432 J7.978 E.07859
G3 X90.074 Y118.497 I9.821 J11.772 E.07488
G1 X90.729 Y118.195 E.0232
G3 X92.196 Y117.85 I2.282 J6.415 E.04856
G3 X93.828 Y117.705 I2.907 J23.415 E.0527
G3 X96.21 Y117.993 I-.861 J17.123 E.07722
G1 X96.902 Y118.201 E.02325
G1 X97.551 Y118.505 E.02303
G3 X99.381 Y119.818 I-7.955 J13.015 E.07248
M204 S10000
G1 X99.725 Y119.573 F30000
G1 F6000
M204 S3000
G3 X101.136 Y121.75 I-13.797 J10.489 E.08349
G1 X101.452 Y122.514 E.0266
G3 X101.835 Y124.564 I-9.865 J2.9 E.06717
G3 X101.928 Y126.048 I-21.911 J2.118 E.04781
G3 X101.664 Y128.649 I-20.189 J-.729 E.08414
G1 X101.45 Y129.461 E.02701
G1 X101.13 Y130.23 E.02677
G3 X99.707 Y132.42 I-15.239 J-8.349 E.08406
G3 X97.716 Y133.85 I-10.331 J-12.273 E.0789
G1 X97.015 Y134.178 E.0249
G3 X95.467 Y134.549 I-2.43 J-6.724 E.05129
G3 X93.772 Y134.704 I-3.068 J-24.149 E.05474
G3 X91.911 Y134.553 I.128 J-13.087 E.06007
G3 X90.132 Y134.038 I2.382 J-11.556 E.05962
G3 X87.546 Y132.027 I2.813 J-6.288 E.10637
G3 X86.453 Y130.269 I6.869 J-5.49 E.0667
G3 X85.767 Y127.595 I10.822 J-4.199 E.08898
G3 X85.678 Y125.896 I19.114 J-1.861 E.05474
G3 X85.947 Y123.263 I20.133 J.73 E.08515
G1 X86.161 Y122.466 E.02653
G1 X86.477 Y121.712 E.02631
G3 X87.883 Y119.563 I15.016 J8.293 E.08264
G3 X89.881 Y118.138 I10.256 J12.26 E.07899
G1 X90.585 Y117.813 E.02494
G3 X92.138 Y117.447 I2.421 J6.791 E.05142
G3 X93.829 Y117.297 I3.005 J24.232 E.05457
G3 X96.306 Y117.596 I-.883 J17.684 E.0803
G1 X97.048 Y117.82 E.02493
G1 X97.746 Y118.146 E.02478
G3 X99.679 Y119.535 I-8.291 J13.578 E.07659
M204 S250
G1 X100.011 Y119.301 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X101.489 Y121.578 I-14.297 J10.893 E.08094
G1 X101.825 Y122.388 E.02612
G3 X102.225 Y124.529 I-10.407 J3.054 E.06498
G3 X102.319 Y126.07 I-21.231 J2.067 E.04599
G3 X102.049 Y128.73 I-20.597 J-.751 E.0797
G1 X101.822 Y129.587 E.02641
G1 X101.484 Y130.402 E.02628
G3 X99.993 Y132.693 I-15.801 J-8.649 E.08148
G3 X97.904 Y134.196 I-10.755 J-12.749 E.07674
G1 X97.155 Y134.545 E.02462
G1 X96.36 Y134.784 E.02471
G3 X93.777 Y135.097 I-3.496 J-18.05 E.07756
G3 X91.841 Y134.939 I.133 J-13.618 E.05791
G3 X89.981 Y134.4 I2.491 J-12.081 E.05773
G3 X87.242 Y132.275 I2.982 J-6.671 E.10427
G3 X86.425 Y131.072 I4.996 J-4.272 E.04339
G1 X86.091 Y130.424 E.02173
G3 X85.573 Y128.767 I19.787 J-7.104 E.05172
G3 X85.33 Y127.061 I10.186 J-2.32 E.05139
G1 X85.285 Y125.892 E.03484
G3 X85.563 Y123.182 I20.635 J.746 E.08121
G1 X85.789 Y122.339 E.02598
G1 X86.125 Y121.538 E.02586
G3 X87.598 Y119.289 I15.578 J8.596 E.08016
G3 X89.695 Y117.792 I10.679 J12.738 E.07683
G1 X90.447 Y117.445 E.02466
G3 X92.083 Y117.059 I2.555 J7.155 E.05019
G3 X93.829 Y116.904 I3.101 J25.038 E.05222
G3 X96.398 Y117.215 I-.904 J18.224 E.07713
G1 X97.188 Y117.453 E.02459
G1 X97.934 Y117.801 E.02452
G3 X99.966 Y119.262 I-8.614 J14.122 E.07461
; WIPE_START
M204 S3000
G1 X100.542 Y120.036 E-.36659
G1 X101.051 Y120.798 E-.34851
G1 X101.109 Y120.902 E-.0449
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.459 Y126.033 Z2.2 F30000
G1 X89.189 Y131.727 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.57936
G1 F6000
M204 S3000
G1 X89.04 Y131.586 E.0087
; LINE_WIDTH: 0.62063
G1 X88.711 Y131.121 E.02601
; LINE_WIDTH: 0.65307
G1 F5900.189
G1 X88.4 Y130.636 E.02776
; LINE_WIDTH: 0.66492
G1 F5787.781
G1 X88.125 Y130.146 E.02759
; LINE_WIDTH: 0.67246
G1 F5718.462
G1 X87.885 Y129.655 E.02716
G1 X87.646 Y128.971 E.03605
; LINE_WIDTH: 0.68253
G1 F5628.43
G1 X87.482 Y128.312 E.03429
; LINE_WIDTH: 0.69596
G1 F5512.679
G1 X87.353 Y127.451 E.04495
; LINE_WIDTH: 0.70044
G1 F5475.119
G3 X87.28 Y126.063 I21.637 J-1.828 E.07217
; LINE_WIDTH: 0.69901
G1 F5487.053
G1 X87.306 Y125.324 E.03836
; LINE_WIDTH: 0.69699
G1 F5503.999
G1 X87.353 Y124.655 E.03462
; LINE_WIDTH: 0.69227
G1 F5544.006
G1 X87.442 Y123.951 E.0364
; LINE_WIDTH: 0.69261
G1 F5541.105
G1 X87.6 Y123.217 E.03856
G1 X87.864 Y122.466 E.04085
; LINE_WIDTH: 0.68296
G1 F5624.649
G1 X88.214 Y121.762 E.03977
; LINE_WIDTH: 0.66003
G1 F5833.644
G1 X88.595 Y121.134 E.03578
; LINE_WIDTH: 0.63579
G1 F6000
G1 X88.972 Y120.564 E.03201
; LINE_WIDTH: 0.61603
G1 X89.375 Y120.163 E.02572
; LINE_WIDTH: 0.56834
G1 X89.97 Y119.676 E.0319
; LINE_WIDTH: 0.54058
G1 X90.446 Y119.329 E.02318
; LINE_WIDTH: 0.50907
G1 X91.065 Y118.987 E.02605
; LINE_WIDTH: 0.48094
G1 X91.634 Y118.766 E.02112
; LINE_WIDTH: 0.44362
G1 X92.316 Y118.595 E.02224
; LINE_WIDTH: 0.41047
G1 X93.097 Y118.48 E.02292
; LINE_WIDTH: 0.38835
G1 X93.684 Y118.425 E.01609
; LINE_WIDTH: 0.38575
G1 X94.461 Y118.471 E.0211
; LINE_WIDTH: 0.39424
G1 X95.017 Y118.541 E.01553
; LINE_WIDTH: 0.42934
G1 X95.888 Y118.73 E.02721
; LINE_WIDTH: 0.47097
G1 X96.568 Y118.982 E.02455
; LINE_WIDTH: 0.50874
G1 X97.102 Y119.288 E.02263
; LINE_WIDTH: 0.52076
G1 X97.542 Y119.582 E.01998
; LINE_WIDTH: 0.5404
G1 X97.938 Y119.899 E.01994
; LINE_WIDTH: 0.56401
G1 X98.372 Y120.272 E.02354
; LINE_WIDTH: 0.60619
G1 X98.647 Y120.565 E.01788
; LINE_WIDTH: 0.62617
G1 X98.993 Y121.096 E.02918
; LINE_WIDTH: 0.64724
G1 F5957.109
G1 X99.347 Y121.682 E.0327
; LINE_WIDTH: 0.67258
G1 F5717.372
G1 X99.681 Y122.334 E.03645
; LINE_WIDTH: 0.69505
G1 F5520.372
G1 X99.946 Y123.027 E.03818
; LINE_WIDTH: 0.70035
G1 F5475.868
G3 X100.216 Y124.374 I-7.485 J2.202 E.07145
; LINE_WIDTH: 0.70165
G1 F5465.062
G1 X100.286 Y125.192 E.04271
; LINE_WIDTH: 0.70824
G1 F5410.93
G3 X100.296 Y126.736 I-9.778 J.834 E.08127
; LINE_WIDTH: 0.69627
G1 F5510.064
G1 X100.251 Y127.4 E.0343
; LINE_WIDTH: 0.68737
G1 F5586.158
G1 X100.165 Y128.097 E.03579
; LINE_WIDTH: 0.68033
G1 F5647.856
G1 X100.011 Y128.825 E.03743
; LINE_WIDTH: 0.6719
G1 F5723.553
G1 X99.755 Y129.568 E.03909
; LINE_WIDTH: 0.65237
G1 F5906.966
G1 X99.431 Y130.231 E.03551
; LINE_WIDTH: 0.62324
G1 F6000
G1 X99.039 Y130.895 E.03534
; LINE_WIDTH: 0.59276
G1 X98.67 Y131.465 E.02948
; LINE_WIDTH: 0.56972
G1 X98.26 Y131.875 E.02414
; LINE_WIDTH: 0.52263
G1 X97.658 Y132.365 E.0294
; LINE_WIDTH: 0.49757
G1 X97.098 Y132.743 E.02429
; LINE_WIDTH: 0.48033
G1 X96.612 Y133.021 E.01932
; LINE_WIDTH: 0.44824
G1 X95.968 Y133.254 E.02195
; LINE_WIDTH: 0.42649
G1 X95.292 Y133.42 E.02107
; LINE_WIDTH: 0.39703
G1 X94.511 Y133.527 E.02207
; LINE_WIDTH: 0.38206
G1 X93.933 Y133.576 E.01553
; LINE_WIDTH: 0.39428
G1 X93.179 Y133.538 E.02096
; LINE_WIDTH: 0.41293
G1 X92.344 Y133.43 E.02461
; LINE_WIDTH: 0.44227
G1 X91.425 Y133.186 E.02998
; LINE_WIDTH: 0.45442
G1 X91.184 Y133.096 E.00838
; LINE_WIDTH: 0.50141
G1 X90.661 Y132.85 E.02093
; LINE_WIDTH: 0.53482
G1 X90.228 Y132.578 E.01987
; LINE_WIDTH: 0.56493
G1 X89.814 Y132.276 E.02112
; LINE_WIDTH: 0.57334
G1 X89.412 Y131.939 E.022
; LINE_WIDTH: 0.57936
G1 X89.232 Y131.769 E.01048
M204 S10000
G1 X89.452 Y131.328 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S3000
G1 X89.343 Y131.2 E.0054
G3 X88.677 Y130.099 I15.08 J-9.871 E.04137
G3 X87.994 Y128.202 I6.063 J-3.256 E.0651
G3 X87.88 Y124.691 I13.641 J-2.198 E.11324
G3 X88.356 Y122.643 I7.512 J.666 E.06784
G3 X89.385 Y120.829 I11.842 J5.515 E.06712
G1 X89.687 Y120.51 E.01413
G3 X90.676 Y119.7 I10.195 J11.43 E.04111
G1 X91.276 Y119.353 E.0223
G1 X91.768 Y119.147 E.01713
G3 X93.72 Y118.795 I2.583 J8.742 E.06393
G3 X94.966 Y118.917 I-.343 J9.919 E.04027
G1 X95.793 Y119.115 E.02735
G1 X96.401 Y119.365 E.02115
G3 X97.934 Y120.502 I-4.593 J7.79 E.06149
G1 X98.236 Y120.824 E.01419
G3 X98.909 Y121.936 I-15.258 J9.996 E.0418
G3 X99.582 Y123.764 I-6.069 J3.27 E.06285
G3 X99.726 Y127.367 I-14.127 J2.37 E.11625
G3 X99.274 Y129.402 I-7.603 J-.62 E.06724
G3 X98.274 Y131.217 I-12.115 J-5.495 E.06669
G1 X97.967 Y131.541 E.01437
G3 X96.441 Y132.652 I-6.305 J-7.057 E.06081
G3 X95.217 Y133.047 I-2.522 J-5.733 E.04141
G3 X93.902 Y133.206 I-2.036 J-11.289 E.04263
G3 X92.399 Y133.045 I.329 J-10.169 E.04863
G1 X91.541 Y132.8 E.0287
G1 X91.371 Y132.732 E.00587
G1 X90.881 Y132.478 E.01778
G3 X89.526 Y131.415 I5.868 J-8.876 E.05543
G1 X89.491 Y131.374 E.00174
M204 S10000
G1 X89.741 Y131.031 F30000
G1 F6000
M204 S3000
G1 X89.476 Y130.639 E.01523
G3 X88.742 Y129.304 I9.492 J-6.09 E.04902
G3 X88.391 Y128.115 I4.749 J-2.045 E.03994
G3 X88.286 Y124.719 I13.271 J-2.111 E.10955
G3 X88.739 Y122.781 I7.021 J.619 E.06421
G3 X89.727 Y121.049 I11.606 J5.473 E.06417
G3 X90.832 Y120.087 I6.135 J5.928 E.04718
G1 X91.48 Y119.705 E.02416
G1 X92.113 Y119.457 E.02189
G3 X93.76 Y119.2 I2.371 J9.787 E.05365
G3 X94.911 Y119.32 I-.524 J10.577 E.03723
G1 X95.696 Y119.51 E.02595
G1 X96.239 Y119.738 E.01893
G3 X97.789 Y120.92 I-4.396 J7.377 E.06282
G3 X98.557 Y122.141 I-9.213 J6.647 E.04641
G3 X99.184 Y123.851 I-5.614 J3.027 E.05878
G3 X99.32 Y127.342 I-13.758 J2.283 E.11263
G3 X98.89 Y129.269 I-7.11 J-.575 E.06369
G3 X97.929 Y131 I-11.898 J-5.468 E.06373
G3 X97.018 Y131.805 I-5.867 J-5.724 E.03913
G1 X96.337 Y132.246 E.0261
G3 X95.136 Y132.648 I-2.28 J-4.821 E.0408
G3 X93.867 Y132.801 I-1.961 J-10.936 E.04114
G3 X92.457 Y132.642 I.463 J-10.483 E.04565
G1 X91.558 Y132.37 E.03021
G1 X91.087 Y132.127 E.01703
G3 X89.795 Y131.109 I5.644 J-8.498 E.05295
G1 X89.775 Y131.08 E.00113
M204 S250
G1 X90.054 Y130.815 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X89.684 Y130.242 E.02033
G3 X88.886 Y128.538 I6.356 J-4.015 E.05617
G3 X88.677 Y124.746 I11.5 J-2.534 E.11363
G3 X89.108 Y122.914 I6.545 J.572 E.05625
G3 X90.057 Y121.261 I11.41 J5.452 E.05681
G3 X91.077 Y120.392 I6.893 J7.064 E.03995
G1 X91.676 Y120.045 E.0206
G1 X92.243 Y119.827 E.01811
G3 X93.799 Y119.59 I2.262 J9.633 E.04692
G3 X94.859 Y119.709 I-.812 J12.048 E.03178
G1 X95.602 Y119.891 E.02279
G1 X96.082 Y120.097 E.01555
G3 X97.527 Y121.211 I-4.326 J7.109 E.05445
G3 X98.218 Y122.337 I-11.721 J7.968 E.03938
G3 X98.844 Y124.134 I-5.367 J2.878 E.05691
G3 X98.928 Y127.318 I-14.436 J1.974 E.09505
G3 X98.519 Y129.141 I-6.634 J-.532 E.05583
G3 X97.597 Y130.792 I-11.736 J-5.47 E.05639
G3 X96.771 Y131.501 I-7.083 J-7.421 E.03242
G1 X96.125 Y131.916 E.02288
G1 X95.55 Y132.136 E.01834
G3 X93.833 Y132.41 I-2.174 J-8.09 E.05187
G3 X92.513 Y132.254 I.648 J-11.168 E.03963
G1 X91.737 Y132.021 E.02412
G1 X91.286 Y131.789 E.0151
G3 X90.098 Y130.856 I5.43 J-8.138 E.04505
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3600
M204 S3000
G1 X89.684 Y130.242 E-.28152
G1 X89.369 Y129.698 E-.23862
G1 X89.095 Y129.133 E-.2387
G1 X89.094 Y129.13 E-.00116
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/10
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M106 S102
; OBJECT_ID: 403
M204 S10000
G17
G3 Z2.2 I.065 J1.215 P1  F30000
G1 X164.526 Y125.092 Z2.2
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X164.619 Y125.14 E.00312
G3 X166.339 Y125.565 I-1.835 J11.123 E.05282
G1 X166.969 Y125.874 E.0209
G3 X168.116 Y126.75 I-6.45 J9.633 E.04302
G3 X168.655 Y127.553 I-20.759 J14.53 E.0288
G1 X168.957 Y128.18 E.02074
G1 X169.125 Y128.809 E.01938
G1 X169.226 Y129.568 E.0228
G1 X169.253 Y129.953 E.01152
G3 X169.073 Y131.373 I-6.901 J-.155 E.04271
G3 X168.499 Y132.678 I-6.26 J-1.974 E.04252
G3 X167.642 Y133.667 I-4.495 J-3.031 E.03908
G3 X166.513 Y134.316 I-3.158 J-4.183 E.0389
G3 X163.449 Y134.78 I-3.427 J-12.295 E.09253
G3 X154.952 Y134.79 I-6.293 J-1662.649 E.25308
G1 X154.952 Y117.21 E.52364
G1 X158.167 Y117.21 E.09574
G1 X158.167 Y124.536 E.2182
G1 X158.217 Y124.664 E.00412
G1 X158.355 Y124.724 E.00447
G2 X159.592 Y124.719 I.552 J-15.99 E.03687
G1 X160.307 Y124.659 E.02136
G1 X161.032 Y124.502 E.02212
G1 X161.517 Y124.262 E.01612
G1 X161.937 Y123.947 E.01562
G2 X163.207 Y122.39 I-10.891 J-10.175 E.05991
G2 X166.691 Y117.21 I-605.899 J-411.274 E.18593
G1 X170.546 Y117.21 E.11483
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

G1 X168.424 Y120.601 E.11914
G3 X166.427 Y123.364 I-18.093 J-10.97 E.10167
G3 X164.532 Y124.812 I-6.881 J-7.043 E.0712
G1 X164.467 Y124.963 E.00491
G1 X164.501 Y125.038 E.00245
; WIPE_START
M204 S3000
G1 X164.619 Y125.14 E-.05939
G1 X165.651 Y125.353 E-.40025
G1 X166.339 Y125.565 E-.27371
G1 X166.402 Y125.596 E-.02664
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.913 Y127.069 Z2.4 F30000
G1 X158.362 Y127.177 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X161.893 Y127.172 E.10516
G3 X164.424 Y127.42 I.072 J12.315 E.0759
G1 X165.004 Y127.719 E.01944
G1 X165.505 Y128.227 E.02124
G1 X165.714 Y128.621 E.01326
G1 X165.876 Y129.13 E.01591
G1 X165.928 Y129.705 E.0172
G1 X165.872 Y130.296 E.0177
G1 X165.722 Y130.787 E.01528
G1 X165.412 Y131.299 E.01784
G1 X164.996 Y131.658 E.01637
G1 X164.529 Y131.927 E.01603
G1 X163.993 Y132.076 E.01658
G1 X163.342 Y132.133 E.01948
G3 X159.876 Y132.166 I-2.337 J-63.065 E.10324
G1 X158.355 Y132.165 E.04531
G1 X158.196 Y132.078 E.00538
G1 X158.167 Y131.976 E.00316
G1 X158.167 Y127.366 E.13733
G1 X158.217 Y127.237 E.00412
G1 X158.307 Y127.2 E.00289
; WIPE_START
M204 S3000
G1 X160.307 Y127.185 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.491 Y132.786 Z2.4 F30000
G1 X166.637 Y134.023 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X168.558 Y132.102 E.08095
G1 X168.886 Y131.241
G1 X165.873 Y134.254 E.12694
G1 X165.192 Y134.401
G1 X168.997 Y130.596 E.16027
G1 X169.04 Y130.02
G1 X164.563 Y134.497 E.18859
G1 X163.978 Y134.549
G1 X169.013 Y129.514 E.21209
G1 X168.948 Y129.045
G1 X163.432 Y134.561 E.23236
G1 X162.888 Y134.572
G1 X168.869 Y128.591 E.25196
G1 X168.742 Y128.185
G1 X165.686 Y131.241 E.12873
G1 X166.077 Y130.317
G1 X168.566 Y127.828 E.10485
G1 X168.372 Y127.489
G1 X166.135 Y129.725 E.09423
G1 X166.091 Y129.237
G1 X168.155 Y127.173 E.08695
G1 X167.93 Y126.865
G1 X165.989 Y128.805 E.08176
G1 X165.844 Y128.417
G1 X167.64 Y126.621 E.07564
G1 X167.332 Y126.395
G1 X165.649 Y128.078 E.07089
G1 X165.388 Y127.807
G1 X167.024 Y126.171 E.06893
G1 X166.692 Y125.969
G1 X165.111 Y127.551 E.06662
G1 X164.763 Y127.365
G1 X166.334 Y125.793 E.06622
G1 X165.937 Y125.658
G1 X164.398 Y127.197 E.06482
G1 X163.937 Y127.125
G1 X165.523 Y125.538 E.06684
G1 X165.081 Y125.447
G1 X163.469 Y127.059 E.0679
G1 X162.983 Y127.012
G1 X164.639 Y125.356 E.06977
G1 X164.321 Y125.141
G1 X162.478 Y126.983 E.07761
G1 X161.956 Y126.972
G1 X167.93 Y120.998 E.25164
; WIPE_START
M204 S3000
G1 X166.516 Y122.412 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X168.822 Y119.573 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X161.43 Y126.965 E.31141
G1 X160.896 Y126.966
G1 X169.714 Y118.147 E.37149
G1 X169.911 Y117.417
G1 X160.361 Y126.967 E.40228
G1 X159.827 Y126.968
G1 X169.378 Y117.417 E.40231
G1 X168.845 Y117.417
G1 X159.293 Y126.969 E.40234
G1 X158.759 Y126.969
G1 X161.003 Y124.725 E.09453
G1 X160.33 Y124.865
G1 X158.183 Y127.013 E.09046
; WIPE_START
M204 S3000
G1 X159.597 Y125.599 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X161.829 Y132.897 Z2.4 F30000
G1 X162.345 Y134.583 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X165.076 Y131.851 E.11508
G1 X164.149 Y132.245
G1 X161.811 Y134.583 E.09847
G1 X161.278 Y134.583
G1 X163.535 Y132.326 E.09507
G1 X162.977 Y132.35
G1 X160.745 Y134.583 E.09404
G1 X160.212 Y134.583
G1 X162.424 Y132.37 E.0932
G1 X161.886 Y132.375
G1 X159.678 Y134.583 E.09301
G1 X159.145 Y134.583
G1 X161.353 Y132.374 E.09302
G1 X160.82 Y132.374
G1 X158.612 Y134.583 E.09303
G1 X158.078 Y134.583
G1 X160.287 Y132.374 E.09305
G1 X159.755 Y132.373
G1 X157.545 Y134.583 E.09307
G1 X157.012 Y134.583
G1 X159.222 Y132.373 E.09308
G1 X158.689 Y132.373
G1 X156.479 Y134.583 E.0931
G1 X155.945 Y134.583
G1 X158.198 Y132.33 E.09489
G1 X157.964 Y132.031
G1 X155.412 Y134.583 E.10749
G1 X155.16 Y134.302
G1 X157.959 Y131.502 E.11793
G1 X157.959 Y130.969
G1 X155.16 Y133.769 E.11793
G1 X155.16 Y133.236
G1 X157.959 Y130.436 E.11793
G1 X157.959 Y129.903
G1 X155.16 Y132.702 E.11793
G1 X155.16 Y132.169
G1 X157.959 Y129.369 E.11793
G1 X157.959 Y128.836
G1 X155.16 Y131.636 E.11793
G1 X155.16 Y131.102
G1 X157.959 Y128.303 E.11793
G1 X157.959 Y127.77
G1 X155.16 Y130.569 E.11793
G1 X155.16 Y130.036
G1 X158.004 Y127.192 E.11982
; WIPE_START
M204 S3000
G1 X156.59 Y128.606 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X159.749 Y124.913 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X155.16 Y129.503 E.19333
G1 X155.16 Y128.969
G1 X159.201 Y124.928 E.17024
G1 X158.666 Y124.929
G1 X155.16 Y128.436 E.14772
G1 X155.16 Y127.903
G1 X158.175 Y124.887 E.12704
G1 X157.965 Y124.565
G1 X155.16 Y127.37 E.11816
G1 X155.16 Y126.836
G1 X157.959 Y124.037 E.11793
G1 X157.959 Y123.504
G1 X155.16 Y126.303 E.11793
G1 X155.16 Y125.77
G1 X157.959 Y122.97 E.11793
G1 X157.959 Y122.437
G1 X155.16 Y125.237 E.11793
G1 X155.16 Y124.703
G1 X157.959 Y121.904 E.11793
G1 X157.959 Y121.371
G1 X155.16 Y124.17 E.11793
G1 X155.16 Y123.637
G1 X157.959 Y120.837 E.11793
G1 X157.959 Y120.304
G1 X155.16 Y123.104 E.11793
G1 X155.16 Y122.57
G1 X157.959 Y119.771 E.11793
G1 X157.959 Y119.237
G1 X155.16 Y122.037 E.11793
G1 X155.16 Y121.504
G1 X157.959 Y118.704 E.11793
G1 X157.959 Y118.171
G1 X155.16 Y120.971 E.11793
G1 X155.16 Y120.437
G1 X157.959 Y117.638 E.11793
G1 X157.646 Y117.417
G1 X155.16 Y119.904 E.10475
G1 X155.16 Y119.371
G1 X157.113 Y117.417 E.08229
G1 X156.58 Y117.417
G1 X155.16 Y118.838 E.05983
G1 X155.16 Y118.304
G1 X156.046 Y117.417 E.03736
G1 X155.513 Y117.417
G1 X155.16 Y117.771 E.0149
; WIPE_START
M204 S3000
G1 X155.513 Y117.417 E-.19007
G1 X156.046 Y117.417 E-.20264
G1 X155.363 Y118.101 E-.3673
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X162.266 Y121.357 Z2.4 F30000
G1 X163.697 Y122.032 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X168.311 Y117.417 E.19438
G1 X167.778 Y117.417
G1 X164.793 Y120.402 E.12574
; WIPE_START
M204 S3000
G1 X166.207 Y118.988 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.889 Y118.773 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X167.245 Y117.417 E.0571
; WIPE_START
M204 S3000
G1 X165.889 Y118.773 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X161.983 Y125.33 Z2.4 F30000
G1 X157.981 Y132.048 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0989251
G1 F3600
M204 S3000
G1 X157.889 Y131.839 E.00101
; WIPE_START
G1 X157.981 Y132.048 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.579 Y131.319 Z2.4 F30000
G1 X165.747 Y131.302 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.212041
G1 F3600
M204 S3000
G3 X165.136 Y131.911 I-2.488 J-1.885 E.01155
; WIPE_START
G1 X165.548 Y131.541 E-.48695
G1 X165.747 Y131.302 E-.27305
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X161.649 Y124.863 Z2.4 F30000
G1 X161.438 Y124.531 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.108225
G1 F3600
M204 S3000
G1 X161.314 Y124.617 E.00078
; LINE_WIDTH: 0.148325
G1 X161.191 Y124.704 E.00125
; LINE_WIDTH: 0.188426
G1 X161.068 Y124.79 E.00173
; WIPE_START
G1 X161.191 Y124.704 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.028 Y131.301 Z2.4 F30000
G1 X166.575 Y133.962 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.201294
G1 F3600
M204 S3000
G1 X166.273 Y134.179 E.00466
; WIPE_START
G1 X166.575 Y133.962 E-.76
; WIPE_END
M73 P96 R1
G1 E-.04 F1800
M204 S10000
G1 X168.09 Y132.867 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.114001
G1 F3600
M204 S3000
G3 X167.339 Y133.617 I-5.779 J-5.036 E.00597
; WIPE_START
G1 X167.495 Y133.489 E-.14447
G1 X168.09 Y132.867 E-.61553
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X168.733 Y128.152 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103655
G1 F3600
M204 S3000
G2 X168.64 Y128.021 I-.765 J.444 E.00077
; WIPE_START
G1 X168.733 Y128.152 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.704 Y125.624 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0967431
G1 F3600
M204 S3000
G1 X165.549 Y125.54 E.00075
; WIPE_START
G1 X165.704 Y125.624 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.757 Y122.092 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.207346
G1 F3600
M204 S3000
G1 X163.575 Y122.314 E.00372
; LINE_WIDTH: 0.16098
G1 X163.392 Y122.536 E.00269
; LINE_WIDTH: 0.11292
G1 X163.15 Y122.815 E.00204
; WIPE_START
G1 X163.392 Y122.536 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.854 Y120.463 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.206724
G1 F3600
M204 S3000
G1 X164.673 Y120.683 E.00368
; LINE_WIDTH: 0.159306
G1 X164.492 Y120.903 E.00262
; LINE_WIDTH: 0.111888
G1 X164.311 Y121.122 E.00155
; WIPE_START
G1 X164.492 Y120.903 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.95 Y118.834 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.206722
G1 F3600
M204 S3000
G1 X165.769 Y119.053 E.00368
; LINE_WIDTH: 0.159305
G1 X165.588 Y119.273 E.00262
; LINE_WIDTH: 0.111887
G1 X165.407 Y119.493 E.00155
; WIPE_START
G1 X165.588 Y119.273 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.886 Y117.399 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.158975
G1 F3600
M204 S3000
G1 X166.694 Y117.631 E.00276
; LINE_WIDTH: 0.111777
G1 X166.503 Y117.864 E.00164
; WIPE_START
G1 X166.694 Y117.631 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X170.093 Y117.542 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103121
G1 F3600
M204 S3000
G2 X170.128 Y117.441 I-.185 J-.121 E.00051
G2 X169.99 Y117.418 I-.133 J.37 E.00067
; WIPE_START
G1 X170.128 Y117.441 E-.43244
G1 X170.093 Y117.542 E-.32756
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X169.217 Y118.94 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111318
G1 F3600
M204 S3000
G1 X169.065 Y119.131 E.00132
; LINE_WIDTH: 0.157633
G1 X168.913 Y119.321 E.00221
; LINE_WIDTH: 0.203948
G1 X168.762 Y119.512 E.0031
M204 S10000
G1 X168.325 Y120.366 F30000
; LINE_WIDTH: 0.111332
G1 F3600
M204 S3000
G1 X168.173 Y120.556 E.00132
; LINE_WIDTH: 0.157641
G1 X168.021 Y120.747 E.00221
; LINE_WIDTH: 0.203951
G1 X167.869 Y120.937 E.0031
; WIPE_START
G1 X168.021 Y120.747 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.307 Y121.918 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.112888
G1 F3600
M204 S3000
G1 X167.078 Y122.183 E.00193
; LINE_WIDTH: 0.162332
G1 X166.849 Y122.448 E.0033
; LINE_WIDTH: 0.20978
G1 X166.564 Y122.766 E.00563
; LINE_WIDTH: 0.264327
G3 X165.869 Y123.482 I-5.835 J-4.957 E.01747
; LINE_WIDTH: 0.240688
G1 X165.443 Y123.875 E.00905
; LINE_WIDTH: 0.200358
G1 X165.294 Y124.001 E.00243
; LINE_WIDTH: 0.166793
G1 X165.144 Y124.126 E.00191
; LINE_WIDTH: 0.133228
G1 X164.995 Y124.252 E.00139
; LINE_WIDTH: 0.102307
G1 X164.877 Y124.346 E.00071
; WIPE_START
G1 X164.995 Y124.252 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X158.492 Y128.247 Z2.4 F30000
G1 X147.843 Y134.79 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X147.843 Y117.21 E.52364
G1 X151.057 Y117.21 E.09574
G1 X151.057 Y118.817 E.04787
G1 X151.057 Y134.79 E.47576
G1 X147.903 Y134.79 E.09396
; WIPE_START
M204 S3000
G1 X147.896 Y132.79 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X150.08 Y134.583 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X150.85 Y133.812 E.03245
G1 X150.85 Y133.279
G1 X149.546 Y134.583 E.05492
G1 X149.013 Y134.583
G1 X150.85 Y132.746 E.07738
G1 X150.85 Y132.212
G1 X148.48 Y134.583 E.09984
G1 X148.05 Y134.479
G1 X150.85 Y131.679 E.11793
G1 X150.85 Y131.146
G1 X148.05 Y133.946 E.11793
G1 X148.05 Y133.412
G1 X150.85 Y130.613 E.11793
G1 X150.85 Y130.079
G1 X148.05 Y132.879 E.11793
G1 X148.05 Y132.346
G1 X150.85 Y129.546 E.11793
G1 X150.85 Y129.013
G1 X148.05 Y131.813 E.11793
G1 X148.05 Y131.279
G1 X150.85 Y128.48 E.11793
G1 X150.85 Y127.946
G1 X148.05 Y130.746 E.11793
G1 X148.05 Y130.213
G1 X150.85 Y127.413 E.11793
G1 X150.85 Y126.88
G1 X148.05 Y129.68 E.11793
G1 X148.05 Y129.146
G1 X150.85 Y126.347 E.11793
G1 X150.85 Y125.813
G1 X148.05 Y128.613 E.11793
G1 X148.05 Y128.08
G1 X150.85 Y125.28 E.11793
G1 X150.85 Y124.747
G1 X148.05 Y127.546 E.11793
G1 X148.05 Y127.013
G1 X150.85 Y124.214 E.11793
G1 X150.85 Y123.68
G1 X148.05 Y126.48 E.11793
G1 X148.05 Y125.947
G1 X150.85 Y123.147 E.11793
G1 X150.85 Y122.614
G1 X148.05 Y125.413 E.11793
G1 X148.05 Y124.88
G1 X150.85 Y122.081 E.11793
G1 X150.85 Y121.547
G1 X148.05 Y124.347 E.11793
G1 X148.05 Y123.814
G1 X150.85 Y121.014 E.11793
G1 X150.85 Y120.481
G1 X148.05 Y123.28 E.11793
G1 X148.05 Y122.747
G1 X150.85 Y119.948 E.11793
G1 X150.85 Y119.414
G1 X148.05 Y122.214 E.11793
G1 X148.05 Y121.681
G1 X150.85 Y118.881 E.11793
G1 X150.85 Y118.348
G1 X148.05 Y121.147 E.11793
G1 X148.05 Y120.614
G1 X150.85 Y117.814 E.11793
G1 X150.714 Y117.417
G1 X148.05 Y120.081 E.1122
G1 X148.05 Y119.548
G1 X150.181 Y117.417 E.08974
G1 X149.647 Y117.417
G1 X148.05 Y119.014 E.06727
G1 X148.05 Y118.481
G1 X149.114 Y117.417 E.04481
G1 X148.581 Y117.417
G1 X148.05 Y117.948 E.02235
; WIPE_START
M204 S3000
G1 X148.581 Y117.417 E-.28508
G1 X149.114 Y117.417 E-.20264
G1 X148.607 Y117.924 E-.27229
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X141.141 Y119.508 Z2.4 F30000
G1 X132.95 Y121.246 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X133.08 Y121.299 E.00418
G1 X140.371 Y121.287 E.21715
G1 X140.48 Y121.18 E.00456
G1 X142.006 Y117.21 E.12669
G1 X143.117 Y117.21 E.03308
G1 X145.506 Y117.21 E.07115
G1 X138.466 Y134.79 E.56405
G1 X134.909 Y134.79 E.10596
G1 X128.062 Y117.21 E.56195
G1 X131.463 Y117.21 E.1013
G1 X132.829 Y120.97 E.11914
G2 X132.916 Y121.197 I.653 J-.121 E.00729
; WIPE_START
M204 S3000
G1 X133.08 Y121.299 E-.07341
G1 X134.887 Y121.296 E-.68659
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.276 Y128.801 Z2.4 F30000
G1 X136.692 Y131.045 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X136.524 Y131.009 E.0051
G1 X136.467 Y130.928 E.00298
G1 X134.005 Y124.164 E.21437
G1 X134.018 Y124.006 E.00472
G1 X134.15 Y123.914 E.00478
G1 X134.182 Y123.911 E.00097
G1 X139.155 Y123.911 E.14812
G1 X139.322 Y124.013 E.00582
G1 X139.332 Y124.166 E.00457
G1 X136.819 Y130.933 E.21502
G1 X136.737 Y131.006 E.00326
; WIPE_START
M204 S3000
G1 X136.524 Y131.009 E-.0807
G1 X136.467 Y130.928 E-.038
G1 X135.889 Y129.342 E-.6413
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X138.667 Y133.73 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X137.815 Y134.583 E.03592
G1 X137.281 Y134.583
G1 X139.024 Y132.841 E.07339
G1 X139.38 Y131.951
G1 X136.748 Y134.583 E.11085
G1 X136.215 Y134.583
G1 X139.736 Y131.062 E.14831
G1 X140.092 Y130.172
G1 X135.682 Y134.583 E.18578
G1 X135.148 Y134.583
G1 X140.448 Y129.283 E.22324
G1 X140.804 Y128.394
G1 X134.929 Y134.269 E.2475
G1 X134.779 Y133.885
G1 X141.16 Y127.504 E.2688
G1 X141.516 Y126.615
G1 X134.63 Y133.502 E.2901
G1 X134.48 Y133.118
G1 X136.417 Y131.181 E.08157
G1 X136.217 Y130.848
G1 X134.331 Y132.734 E.07946
G1 X134.181 Y132.35
G1 X136.075 Y130.457 E.07976
G1 X135.932 Y130.066
G1 X134.032 Y131.967 E.08006
G1 X133.882 Y131.583
G1 X135.79 Y129.675 E.08037
G1 X135.648 Y129.284
G1 X133.733 Y131.199 E.08067
G1 X133.583 Y130.815
G1 X135.505 Y128.893 E.08097
G1 X135.363 Y128.502
G1 X133.434 Y130.431 E.08127
G1 X133.284 Y130.048
G1 X135.221 Y128.111 E.08157
G1 X135.079 Y127.72
G1 X133.135 Y129.664 E.08188
G1 X132.985 Y129.28
G1 X134.936 Y127.329 E.08218
G1 X134.794 Y126.938
G1 X132.836 Y128.896 E.08248
G1 X132.686 Y128.513
G1 X134.652 Y126.547 E.08278
G1 X134.509 Y126.156
G1 X132.537 Y128.129 E.08309
G1 X132.387 Y127.745
G1 X134.367 Y125.765 E.08339
G1 X134.225 Y125.374
G1 X132.238 Y127.361 E.08369
G1 X132.088 Y126.977
G1 X134.082 Y124.983 E.08399
G1 X133.94 Y124.593
G1 X131.939 Y126.594 E.0843
G1 X131.79 Y126.21
G1 X133.805 Y124.195 E.08489
; WIPE_START
M204 S3000
G1 X132.39 Y125.609 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.262 Y130.336 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X141.872 Y125.726 E.19423
G1 X142.229 Y124.836
G1 X137.577 Y129.488 E.19596
G1 X137.891 Y128.64
G1 X142.585 Y123.947 E.1977
G1 X142.941 Y123.058
G1 X138.206 Y127.792 E.19943
G1 X138.521 Y126.944
G1 X143.297 Y122.168 E.20116
G1 X143.653 Y121.279
G1 X138.836 Y126.095 E.2029
G1 X139.151 Y125.247
G1 X144.009 Y120.389 E.20463
G1 X144.365 Y119.5
G1 X139.466 Y124.399 E.20636
G1 X139.467 Y123.865
G1 X144.721 Y118.611 E.22135
G1 X145.077 Y117.721
G1 X139.095 Y123.704 E.25202
G1 X138.561 Y123.704
G1 X144.848 Y117.417 E.26482
G1 X144.315 Y117.417
G1 X140.796 Y120.936 E.14821
G1 X141.129 Y120.069
G1 X143.782 Y117.417 E.11172
G1 X143.248 Y117.417
G1 X141.462 Y119.203 E.07523
G1 X141.795 Y118.337
G1 X142.715 Y117.417 E.03874
; WIPE_START
M204 S3000
G1 X141.795 Y118.337 E-.49419
G1 X141.544 Y118.99 E-.26581
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.226 Y121.506 Z2.4 F30000
G1 Z2
M73 P96 R0
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X138.028 Y123.704 E.09259
G1 X137.495 Y123.704
G1 X139.693 Y121.505 E.09261
G1 X139.161 Y121.505
G1 X136.962 Y123.704 E.09264
G1 X136.428 Y123.704
G1 X138.628 Y121.504 E.09266
G1 X138.095 Y121.504
G1 X135.895 Y123.704 E.09268
G1 X135.362 Y123.704
G1 X137.562 Y121.503 E.0927
G1 X137.03 Y121.503
G1 X134.829 Y123.704 E.09272
G1 X134.295 Y123.704
G1 X136.497 Y121.502 E.09274
G1 X135.964 Y121.502
G1 X131.64 Y125.826 E.18215
G1 X131.491 Y125.442
G1 X135.431 Y121.501 E.166
G1 X134.899 Y121.501
G1 X131.341 Y125.058 E.14986
G1 X131.192 Y124.675
G1 X134.366 Y121.5 E.13371
G1 X133.833 Y121.5
G1 X131.042 Y124.291 E.11757
G1 X130.893 Y123.907
G1 X133.3 Y121.499 E.10142
G1 X132.846 Y121.421
G1 X130.743 Y123.523 E.08857
G1 X130.594 Y123.14
G1 X132.65 Y121.084 E.08661
G1 X132.508 Y120.692
G1 X130.444 Y122.756 E.08692
G1 X130.295 Y122.372
G1 X132.365 Y120.301 E.08723
G1 X132.223 Y119.91
G1 X130.145 Y121.988 E.08754
G1 X129.996 Y121.605
G1 X132.081 Y119.519 E.08785
G1 X131.939 Y119.128
G1 X129.846 Y121.221 E.08816
G1 X129.697 Y120.837
G1 X131.797 Y118.737 E.08846
G1 X131.655 Y118.346
G1 X129.547 Y120.453 E.08877
G1 X129.398 Y120.069
G1 X131.513 Y117.955 E.08908
G1 X131.37 Y117.564
G1 X129.248 Y119.686 E.08939
G1 X129.099 Y119.302
G1 X130.983 Y117.417 E.07938
G1 X130.45 Y117.417
G1 X128.949 Y118.918 E.06321
G1 X128.8 Y118.534
G1 X129.917 Y117.417 E.04705
G1 X129.384 Y117.417
G1 X128.65 Y118.15 E.03088
G1 X128.501 Y117.767
G1 X128.85 Y117.417 E.01472
; WIPE_START
M204 S3000
G1 X128.501 Y117.767 E-.18774
G1 X128.65 Y118.15 E-.1565
G1 X129.384 Y117.417 E-.39397
G1 X129.441 Y117.417 E-.02179
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.073 Y117.408 Z2.4 F30000
G1 X144.869 Y117.399 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.235081
G1 F3600
M204 S3000
G1 X145.073 Y117.502 E.00348
G1 X145.061 Y117.583 E.00124
; LINE_WIDTH: 0.19777
G1 X145.006 Y117.589 E.00067
; LINE_WIDTH: 0.164823
G1 X144.952 Y117.596 E.00053
; WIPE_START
G1 X145.006 Y117.589 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X140.872 Y121.011 Z2.4 F30000
M73 P97 R0
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.106995
G1 F3600
M204 S3000
G3 X140.597 Y121.372 I-3.301 J-2.226 E.0023
M204 S10000
G1 X140.427 Y121.572 F30000
; LINE_WIDTH: 0.127462
G1 F3600
M204 S3000
G1 X140.215 Y121.495 E.0015
M204 S10000
G1 X140.56 Y121.41 F30000
; LINE_WIDTH: 0.109742
G1 F3600
M204 S3000
G3 X140.309 Y121.588 I-1.042 J-1.203 E.00163
; WIPE_START
G1 X140.56 Y121.41 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.808 Y121.485 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0981941
G1 F3600
M204 S3000
G1 X137.676 Y121.617 E.00082
; WIPE_START
G1 X137.808 Y121.485 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.887 Y129.061 Z2.4 F30000
G1 X136.622 Y131.243 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103601
G1 F3600
M204 S3000
G1 X136.55 Y131.264 E.00036
G1 X136.468 Y131.206 E.00048
; WIPE_START
G1 X136.55 Y131.264 E-.43479
G1 X136.622 Y131.243 E-.32521
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.92 Y130.028 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0929718
G1 F3600
M204 S3000
G1 X135.836 Y129.896 E.00062
; WIPE_START
G1 X135.92 Y130.028 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.835 Y123.899 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.150568
G1 F3600
M204 S3000
G1 X133.751 Y124.061 E.00155
G1 X133.803 Y124.175 E.00107
M204 S10000
G1 X134.216 Y123.624 F30000
; LINE_WIDTH: 0.11802
G1 F3600
M204 S3000
G2 X133.993 Y123.766 I.671 J1.299 E.00157
; WIPE_START
G1 X134.216 Y123.624 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.733 Y125.131 Z2.4 F30000
G1 X108.651 Y128.77 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G1 X108.881 Y128.836 E.00713
G1 X109.026 Y128.747 E.00505
G1 X116.158 Y117.21 E.404
G1 X119.478 Y117.21 E.09888
G1 X119.478 Y119.341 E.06349
G1 X119.478 Y134.79 E.46015
G1 X116.521 Y134.79 E.08806
G1 X116.521 Y123.1 E.3482
G1 X116.445 Y122.948 E.00506
G1 X116.214 Y122.883 E.00715
G1 X116.069 Y122.972 E.00504
G1 X108.826 Y134.79 E.41287
G1 X105.618 Y134.79 E.09557
G1 X105.618 Y117.21 E.52364
G1 X108.574 Y117.21 E.08806
G1 X108.574 Y128.619 E.33982
G1 X108.624 Y128.717 E.00327
; WIPE_START
M204 S3000
G1 X108.881 Y128.836 E-.10776
G1 X109.026 Y128.747 E-.06446
G1 X109.839 Y127.431 E-.58778
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.91 Y132.624 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X107.952 Y134.583 E.08249
G1 X107.419 Y134.583
G1 X110.755 Y131.247 E.14051
; WIPE_START
M204 S3000
G1 X109.34 Y132.661 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.599 Y129.87 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X106.886 Y134.583 E.19854
G1 X106.352 Y134.583
G1 X112.443 Y128.492 E.25656
; WIPE_START
M204 S3000
G1 X111.029 Y129.906 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.287 Y127.115 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X105.825 Y134.577 E.31433
G1 X105.825 Y134.043
G1 X114.131 Y125.737 E.34989
; WIPE_START
M204 S3000
G1 X112.717 Y127.151 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.976 Y124.36 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X105.825 Y133.51 E.38545
G1 X105.825 Y132.977
G1 X115.82 Y122.982 E.42102
; WIPE_START
M204 S3000
G1 X114.406 Y124.396 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X117.875 Y131.195 Z2.4 F30000
G1 X119.27 Y133.93 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X118.617 Y134.583 E.0275
G1 X118.084 Y134.583
G1 X119.27 Y133.397 E.04996
G1 X119.27 Y132.863
G1 X117.551 Y134.583 E.07243
G1 X117.018 Y134.583
G1 X119.27 Y132.33 E.09489
G1 X119.27 Y131.797
G1 X116.728 Y134.339 E.10707
G1 X116.728 Y133.805
G1 X119.27 Y131.264 E.10707
G1 X119.27 Y130.73
G1 X116.728 Y133.272 E.10707
G1 X116.728 Y132.739
G1 X119.27 Y130.197 E.10707
G1 X119.27 Y129.664
G1 X116.728 Y132.206 E.10707
G1 X116.728 Y131.672
G1 X119.27 Y129.131 E.10707
G1 X119.27 Y128.597
G1 X116.728 Y131.139 E.10707
G1 X116.728 Y130.606
G1 X119.27 Y128.064 E.10707
G1 X119.27 Y127.531
G1 X116.728 Y130.073 E.10707
G1 X116.728 Y129.539
G1 X119.27 Y126.997 E.10707
G1 X119.27 Y126.464
G1 X116.728 Y129.006 E.10707
G1 X116.728 Y128.473
G1 X119.27 Y125.931 E.10707
G1 X119.27 Y125.398
G1 X116.728 Y127.94 E.10707
G1 X116.728 Y127.406
G1 X119.27 Y124.864 E.10707
G1 X119.27 Y124.331
G1 X116.728 Y126.873 E.10707
G1 X116.728 Y126.34
G1 X119.27 Y123.798 E.10707
G1 X119.27 Y123.265
G1 X116.728 Y125.806 E.10707
G1 X116.728 Y125.273
G1 X119.27 Y122.731 E.10707
G1 X119.27 Y122.198
G1 X116.728 Y124.74 E.10707
G1 X116.728 Y124.207
G1 X119.27 Y121.665 E.10707
G1 X119.27 Y121.132
G1 X116.728 Y123.673 E.10707
G1 X116.728 Y123.14
G1 X119.27 Y120.598 E.10707
G1 X119.27 Y120.065
G1 X116.558 Y122.777 E.11424
G1 X116.094 Y122.708
G1 X119.27 Y119.532 E.1338
G1 X119.27 Y118.999
G1 X105.825 Y132.444 E.56636
G1 X105.825 Y131.91
G1 X108.724 Y129.012 E.12209
G1 X108.41 Y128.792
G1 X105.825 Y131.377 E.10889
G1 X105.825 Y130.844
G1 X108.367 Y128.302 E.10707
G1 X108.367 Y127.769
G1 X105.825 Y130.311 E.10707
G1 X105.825 Y129.777
G1 X108.367 Y127.235 E.10707
G1 X108.367 Y126.702
G1 X105.825 Y129.244 E.10707
G1 X105.825 Y128.711
G1 X108.367 Y126.169 E.10707
G1 X108.367 Y125.636
G1 X105.825 Y128.178 E.10707
G1 X105.825 Y127.644
G1 X108.367 Y125.102 E.10707
G1 X108.367 Y124.569
G1 X105.825 Y127.111 E.10707
G1 X105.825 Y126.578
G1 X108.367 Y124.036 E.10707
G1 X108.367 Y123.503
G1 X105.825 Y126.044 E.10707
G1 X105.825 Y125.511
G1 X108.367 Y122.969 E.10707
G1 X108.367 Y122.436
G1 X105.825 Y124.978 E.10707
G1 X105.825 Y124.445
G1 X108.367 Y121.903 E.10707
G1 X108.367 Y121.37
G1 X105.825 Y123.911 E.10707
G1 X105.825 Y123.378
G1 X108.367 Y120.836 E.10707
G1 X108.367 Y120.303
G1 X105.825 Y122.845 E.10707
G1 X105.825 Y122.312
G1 X108.367 Y119.77 E.10707
G1 X108.367 Y119.237
G1 X105.825 Y121.778 E.10707
G1 X105.825 Y121.245
G1 X108.367 Y118.703 E.10707
G1 X108.367 Y118.17
G1 X105.825 Y120.712 E.10707
G1 X105.825 Y120.179
G1 X108.367 Y117.637 E.10707
G1 X108.053 Y117.417
G1 X105.825 Y119.645 E.09385
G1 X105.825 Y119.112
G1 X107.52 Y117.417 E.07139
G1 X106.987 Y117.417
G1 X105.825 Y118.579 E.04893
G1 X105.825 Y118.046
G1 X106.454 Y117.417 E.02646
; WIPE_START
M204 S3000
G1 X105.825 Y118.046 E-.33761
G1 X105.825 Y118.579 E-.20264
G1 X106.234 Y118.17 E-.21975
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.786 Y125.363 Z2.4 F30000
G1 X109.725 Y128.011 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X119.27 Y118.465 E.4021
G1 X119.27 Y117.932
G1 X110.588 Y126.614 E.36573
; WIPE_START
M204 S3000
G1 X112.002 Y125.2 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.451 Y125.218 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X119.252 Y117.417 E.32858
G1 X118.718 Y117.417
G1 X112.315 Y123.821 E.26975
; WIPE_START
M204 S3000
G1 X113.729 Y122.407 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.178 Y122.424 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X118.185 Y117.417 E.21091
G1 X117.652 Y117.417
G1 X114.042 Y121.027 E.15207
; WIPE_START
M204 S3000
G1 X115.456 Y119.613 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.905 Y119.631 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X117.119 Y117.417 E.09324
G1 X116.585 Y117.417
G1 X115.769 Y118.234 E.0344
; WIPE_START
M204 S3000
G1 X116.585 Y117.417 E-.4389
G1 X117.119 Y117.417 E-.20264
G1 X116.898 Y117.638 E-.11846
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.632 Y124.536 Z2.4 F30000
G1 X109.44 Y133.39 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109954
G1 F3600
M204 S3000
G1 X109.304 Y133.563 E.00117
; LINE_WIDTH: 0.153509
G1 X109.167 Y133.736 E.00193
; LINE_WIDTH: 0.197064
G1 X109.031 Y133.909 E.00268
; LINE_WIDTH: 0.240619
G1 X108.894 Y134.082 E.00344
; LINE_WIDTH: 0.284174
G1 X108.758 Y134.255 E.0042
; LINE_WIDTH: 0.327729
G1 X108.621 Y134.428 E.00496
; LINE_WIDTH: 0.371284
G1 X108.485 Y134.601 E.00572
; WIPE_START
G1 X108.621 Y134.428 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.284 Y132.012 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111168
G1 F3600
M204 S3000
G1 X110.139 Y132.196 E.00126
; LINE_WIDTH: 0.157153
G1 X109.994 Y132.38 E.00211
; LINE_WIDTH: 0.203138
G1 X109.85 Y132.564 E.00296
; WIPE_START
G1 X109.994 Y132.38 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.128 Y130.635 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111171
G1 F3600
M204 S3000
G1 X110.984 Y130.819 E.00126
; LINE_WIDTH: 0.15716
G1 X110.839 Y131.002 E.00211
; LINE_WIDTH: 0.203149
G1 X110.694 Y131.186 E.00296
; WIPE_START
G1 X110.839 Y131.002 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.973 Y129.258 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111174
G1 F3600
M204 S3000
G1 X111.828 Y129.441 E.00126
; LINE_WIDTH: 0.157167
G1 X111.683 Y129.625 E.00211
; LINE_WIDTH: 0.203161
G1 X111.538 Y129.809 E.00296
; WIPE_START
G1 X111.683 Y129.625 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X112.817 Y127.88 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111171
G1 F3600
M204 S3000
G1 X112.672 Y128.064 E.00126
; LINE_WIDTH: 0.15716
G1 X112.527 Y128.248 E.00211
; LINE_WIDTH: 0.203149
G1 X112.382 Y128.431 E.00296
; WIPE_START
G1 X112.527 Y128.248 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.661 Y126.503 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111171
G1 F3600
M204 S3000
G1 X113.516 Y126.686 E.00126
; LINE_WIDTH: 0.15716
G1 X113.371 Y126.87 E.00211
; LINE_WIDTH: 0.203149
G1 X113.226 Y127.054 E.00296
; WIPE_START
G1 X113.371 Y126.87 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.505 Y125.125 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111171
G1 F3600
M204 S3000
G1 X114.36 Y125.309 E.00126
; LINE_WIDTH: 0.15716
G1 X114.216 Y125.493 E.00211
; LINE_WIDTH: 0.203149
G1 X114.071 Y125.676 E.00296
; WIPE_START
G1 X114.216 Y125.493 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.349 Y123.748 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111171
G1 F3600
M204 S3000
G1 X115.205 Y123.931 E.00126
; LINE_WIDTH: 0.15716
M73 P98 R0
G1 X115.06 Y124.115 E.00211
; LINE_WIDTH: 0.203149
G1 X114.915 Y124.299 E.00296
; WIPE_START
G1 X115.06 Y124.115 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.097 Y122.711 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.149755
G1 F3600
M204 S3000
G1 X115.996 Y122.7 E.00085
; LINE_WIDTH: 0.181564
G1 X115.978 Y122.7 E.0002
; LINE_WIDTH: 0.219213
G1 X115.961 Y122.7 E.00025
G2 X115.759 Y122.921 I.858 J.982 E.00418
; WIPE_START
G1 X115.961 Y122.7 E-.71735
G1 X115.978 Y122.7 E-.04265
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.829 Y118.295 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.203469
G1 F3600
M204 S3000
G1 X115.682 Y118.481 E.00302
; LINE_WIDTH: 0.15735
G1 X115.534 Y118.668 E.00215
; LINE_WIDTH: 0.111232
G1 X115.387 Y118.854 E.00128
M204 S10000
G1 X114.966 Y119.692 F30000
; LINE_WIDTH: 0.203468
G1 F3600
M204 S3000
G1 X114.818 Y119.878 E.00302
; LINE_WIDTH: 0.15735
G1 X114.671 Y120.065 E.00215
; LINE_WIDTH: 0.111232
G1 X114.523 Y120.251 E.00128
M204 S10000
G1 X114.103 Y121.088 F30000
; LINE_WIDTH: 0.203469
G1 F3600
M204 S3000
G1 X113.955 Y121.275 E.00302
; LINE_WIDTH: 0.15735
G1 X113.807 Y121.461 E.00215
; LINE_WIDTH: 0.111232
G1 X113.66 Y121.648 E.00128
M204 S10000
G1 X113.239 Y122.485 F30000
; LINE_WIDTH: 0.203467
G1 F3600
M204 S3000
G1 X113.092 Y122.671 E.00302
; LINE_WIDTH: 0.157349
G1 X112.944 Y122.858 E.00215
; LINE_WIDTH: 0.111231
G1 X112.796 Y123.044 E.00128
M204 S10000
G1 X112.376 Y123.882 F30000
; LINE_WIDTH: 0.203467
G1 F3600
M204 S3000
G1 X112.228 Y124.068 E.00302
; LINE_WIDTH: 0.157349
G1 X112.08 Y124.255 E.00215
; LINE_WIDTH: 0.111231
G1 X111.933 Y124.441 E.00128
M204 S10000
G1 X111.512 Y125.278 F30000
; LINE_WIDTH: 0.203477
G1 F3600
M204 S3000
G1 X111.365 Y125.465 E.00302
; LINE_WIDTH: 0.157355
G1 X111.217 Y125.651 E.00215
; LINE_WIDTH: 0.111233
G1 X111.069 Y125.838 E.00128
M204 S10000
G1 X110.649 Y126.675 F30000
; LINE_WIDTH: 0.203467
G1 F3600
M204 S3000
G1 X110.501 Y126.862 E.00302
; LINE_WIDTH: 0.157349
G1 X110.354 Y127.048 E.00215
; LINE_WIDTH: 0.111231
G1 X110.206 Y127.235 E.00128
M204 S10000
G1 X109.785 Y128.072 F30000
; LINE_WIDTH: 0.203467
G1 F3600
M204 S3000
G1 X109.638 Y128.258 E.00302
; LINE_WIDTH: 0.157349
G1 X109.49 Y128.445 E.00215
; LINE_WIDTH: 0.111231
G1 X109.343 Y128.631 E.00128
; WIPE_START
G1 X109.49 Y128.445 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.997 Y123.146 Z2.4 F30000
G1 X100.011 Y119.301 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S1500
G3 X101.489 Y121.578 I-14.295 J10.891 E.08094
G1 X101.825 Y122.388 E.02612
G3 X102.225 Y124.529 I-10.409 J3.055 E.06498
G3 X102.319 Y126.07 I-21.231 J2.067 E.04599
G3 X102.049 Y128.73 I-20.597 J-.751 E.07969
G1 X101.822 Y129.587 E.02641
G1 X101.484 Y130.402 E.02628
G3 X100.529 Y131.954 I-10.521 J-5.403 E.05433
G1 X99.993 Y132.693 E.02718
G3 X97.904 Y134.196 I-10.755 J-12.748 E.07675
G1 X97.155 Y134.545 E.02462
G1 X96.36 Y134.784 E.02471
G3 X93.777 Y135.097 I-3.496 J-18.051 E.07756
G3 X91.841 Y134.939 I.133 J-13.619 E.05791
G3 X89.981 Y134.4 I2.49 J-12.079 E.05773
G3 X87.242 Y132.275 I2.982 J-6.671 E.10427
G3 X86.425 Y131.072 I4.996 J-4.272 E.04339
G1 X86.091 Y130.424 E.02173
G3 X85.573 Y128.767 I19.787 J-7.104 E.05172
G3 X85.33 Y127.061 I10.186 J-2.32 E.05139
G1 X85.285 Y125.892 E.03484
G3 X85.563 Y123.181 I20.634 J.746 E.08121
G1 X85.789 Y122.339 E.02598
G1 X86.125 Y121.538 E.02586
G3 X87.598 Y119.289 I15.578 J8.596 E.08016
G3 X89.695 Y117.792 I10.679 J12.739 E.07683
G1 X90.447 Y117.445 E.02467
G3 X92.083 Y117.059 I2.555 J7.156 E.05018
G3 X93.829 Y116.904 I3.101 J25.038 E.05222
G3 X96.398 Y117.215 I-.904 J18.224 E.07713
G1 X97.188 Y117.453 E.02459
G1 X97.934 Y117.801 E.02451
G3 X99.966 Y119.262 I-8.615 J14.123 E.07461
; WIPE_START
M204 S3000
G1 X100.542 Y120.036 E-.36659
G1 X101.051 Y120.798 E-.34843
G1 X101.109 Y120.902 E-.04498
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.427 Y125.997 Z2.4 F30000
G1 X90.054 Y130.815 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S1500
G1 X89.684 Y130.242 E.02033
G3 X88.886 Y128.538 I6.356 J-4.015 E.05617
G3 X88.677 Y124.746 I11.5 J-2.534 E.11364
G3 X89.108 Y122.914 I6.544 J.572 E.05625
G3 X90.057 Y121.261 I11.407 J5.45 E.05681
G3 X91.077 Y120.393 I6.895 J7.067 E.03995
G1 X91.676 Y120.045 E.02061
G1 X92.243 Y119.827 E.01811
G3 X93.799 Y119.59 I2.262 J9.633 E.04692
G3 X94.858 Y119.709 I-.812 J12.044 E.03178
G1 X95.602 Y119.891 E.0228
G1 X96.082 Y120.097 E.01555
G3 X97.527 Y121.211 I-4.327 J7.109 E.05445
G3 X98.218 Y122.337 I-11.718 J7.967 E.03938
G3 X98.844 Y124.134 I-5.367 J2.878 E.05691
G3 X98.928 Y127.318 I-14.436 J1.974 E.09505
G3 X98.519 Y129.141 I-6.635 J-.532 E.05583
G3 X97.597 Y130.792 I-11.732 J-5.468 E.05639
G3 X96.771 Y131.501 I-7.086 J-7.425 E.03242
G1 X96.125 Y131.916 E.02288
G1 X95.55 Y132.136 E.01834
G3 X93.833 Y132.41 I-2.174 J-8.092 E.05187
G3 X92.513 Y132.254 I.648 J-11.174 E.03963
G1 X91.737 Y132.021 E.02412
G1 X91.286 Y131.789 E.0151
G3 X90.098 Y130.856 I5.433 J-8.142 E.04505
; WIPE_START
M204 S3000
G1 X89.684 Y130.242 E-.28152
G1 X89.369 Y129.698 E-.23865
G1 X89.095 Y129.133 E-.23873
G1 X89.094 Y129.13 E-.00111
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.804 Y132.767 Z2.4 F30000
G1 X97.943 Y133.927 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X100.96 Y130.91 E.12709
G1 X101.49 Y129.847
G1 X96.945 Y134.391 E.19143
G1 X96.201 Y134.602
G1 X101.748 Y129.055 E.23366
G1 X101.894 Y128.376
G1 X95.549 Y134.721 E.2673
G1 X94.945 Y134.791
G1 X101.989 Y127.748 E.29669
G1 X102.041 Y127.163
G1 X94.358 Y134.846 E.32364
G1 X93.782 Y134.888
G1 X97.673 Y130.997 E.1639
; WIPE_START
M204 S3000
G1 X96.259 Y132.412 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.921 Y132.216 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X93.271 Y134.866 E.11161
G1 X92.765 Y134.839
G1 X95.147 Y132.457 E.10036
G1 X94.526 Y132.545
G1 X92.288 Y134.783 E.09427
G1 X91.818 Y134.72
G1 X93.932 Y132.605 E.08909
G1 X93.42 Y132.584
G1 X91.39 Y134.614 E.0855
G1 X90.963 Y134.508
G1 X92.945 Y132.526 E.08351
G1 X92.479 Y132.458
G1 X90.562 Y134.375 E.08074
G1 X90.162 Y134.242
G1 X92.069 Y132.335 E.08034
G1 X91.66 Y132.211
G1 X89.796 Y134.075 E.07849
G1 X89.443 Y133.894
G1 X91.306 Y132.032 E.07845
G1 X90.977 Y131.828
G1 X89.112 Y133.693 E.07856
G1 X88.792 Y133.479
G1 X90.666 Y131.605 E.07893
G1 X90.371 Y131.367
G1 X88.495 Y133.243 E.07903
G1 X88.21 Y132.995
G1 X90.087 Y131.117 E.07908
G1 X89.823 Y130.848
G1 X87.933 Y132.738 E.07961
G1 X87.679 Y132.46
G1 X89.616 Y130.522 E.08162
G1 X89.415 Y130.19
G1 X87.43 Y132.175 E.0836
G1 X87.197 Y131.874
G1 X89.219 Y129.852 E.08518
G1 X89.041 Y129.498
G1 X86.967 Y131.571 E.08735
G1 X86.767 Y131.238
G1 X88.874 Y129.131 E.08877
G1 X88.736 Y128.736
G1 X86.57 Y130.901 E.09121
G1 X86.389 Y130.549
G1 X88.625 Y128.314 E.09416
G1 X88.535 Y127.87
G1 X86.228 Y130.177 E.0972
G1 X86.095 Y129.777
G1 X88.476 Y127.396 E.10031
G1 X88.445 Y126.894
G1 X85.962 Y129.377 E.10459
G1 X85.842 Y128.964
G1 X88.42 Y126.385 E.10861
G1 X88.411 Y125.861
G1 X85.736 Y128.536 E.11269
G1 X85.649 Y128.09
G1 X88.441 Y125.298 E.11764
G1 X88.471 Y124.734
G1 X85.585 Y127.621 E.12161
G1 X85.544 Y127.129
G1 X88.549 Y124.124 E.12659
G1 X88.7 Y123.439
G1 X85.521 Y126.619 E.13392
G1 X85.501 Y126.105
G1 X89.056 Y122.55 E.14976
; WIPE_START
M204 S3000
G1 X87.642 Y123.964 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.819 Y121.254 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X85.512 Y125.56 E.18142
; WIPE_START
M204 S3000
G1 X86.927 Y124.146 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.41 Y128.174 Z2.4 F30000
G1 X97.781 Y130.889 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X102.082 Y126.588 E.18118
G1 X102.114 Y126.023
G1 X98.523 Y129.614 E.15129
G1 X98.885 Y128.719
G1 X102.09 Y125.513 E.13504
G1 X102.06 Y125.01
G1 X99.047 Y128.023 E.1269
G1 X99.126 Y127.411
G1 X102.016 Y124.521 E.12173
G1 X101.965 Y124.039
G1 X99.157 Y126.847 E.11828
G1 X99.184 Y126.287
G1 X101.893 Y123.578 E.11413
G1 X101.806 Y123.131
G1 X99.18 Y125.757 E.11063
G1 X99.155 Y125.249
G1 X101.695 Y122.709 E.107
G1 X101.566 Y122.305
G1 X99.129 Y124.742 E.10264
G1 X99.07 Y124.267
G1 X101.409 Y121.928 E.09853
G1 X101.242 Y121.562
G1 X98.987 Y123.817 E.09499
G1 X98.883 Y123.388
G1 X101.05 Y121.221 E.0913
G1 X100.857 Y120.881
G1 X98.745 Y122.993 E.08896
G1 X98.585 Y122.619
G1 X100.644 Y120.561 E.08671
G1 X100.43 Y120.241
G1 X98.412 Y122.26 E.08503
G1 X98.216 Y121.922
G1 X100.209 Y119.929 E.08396
G1 X99.986 Y119.619
G1 X98.017 Y121.588 E.08292
G1 X97.809 Y121.263
G1 X99.73 Y119.341 E.08094
G1 X99.435 Y119.104
G1 X97.565 Y120.973 E.07877
G1 X97.28 Y120.725
G1 X99.136 Y118.869 E.07819
G1 X98.83 Y118.642
G1 X96.995 Y120.477 E.0773
G1 X96.688 Y120.25
G1 X98.523 Y118.415 E.07732
G1 X98.196 Y118.21
G1 X96.366 Y120.039 E.07707
G1 X96.025 Y119.847
G1 X97.868 Y118.004 E.07761
G1 X97.508 Y117.831
G1 X95.649 Y119.69 E.07832
G1 X95.221 Y119.584
G1 X97.144 Y117.661 E.08101
G1 X96.738 Y117.534
G1 X94.781 Y119.491 E.08244
G1 X94.311 Y119.428
G1 X96.327 Y117.412 E.08492
G1 X95.876 Y117.33
G1 X93.82 Y119.385 E.08658
G1 X93.222 Y119.45
G1 X95.418 Y117.255 E.09248
G1 X94.937 Y117.202
G1 X92.604 Y119.535 E.09827
G1 X91.864 Y119.742
G1 X94.449 Y117.157 E.10888
G1 X93.952 Y117.121
G1 X90.413 Y120.659 E.14906
; WIPE_START
M204 S3000
G1 X91.828 Y119.245 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.391 Y117.148 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X85.546 Y124.994 E.33049
G1 X85.599 Y124.407
G1 X92.817 Y117.189 E.30405
G1 X92.22 Y117.252
G1 X85.675 Y123.798 E.27573
G1 X85.785 Y123.155
G1 X91.58 Y117.359 E.24413
G1 X90.871 Y117.536
G1 X85.98 Y122.426 E.20601
G1 X86.4 Y121.473
G1 X89.988 Y117.885 E.15115
; WIPE_START
M204 S3000
G1 X88.574 Y119.299 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.36 Y126.834 Z2.4 F30000
G1 X86.679 Y131.06 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.096999
G1 F3600
M204 S3000
G1 X86.6 Y130.96 E.00054
; WIPE_START
G1 X86.679 Y131.06 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X88.723 Y128.701 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.128171
G1 F3600
M204 S3000
G1 X88.663 Y128.603 E.00077
G1 X88.687 Y128.519 E.00059
; WIPE_START
G1 X88.663 Y128.603 E-.32944
G1 X88.723 Y128.701 E-.43056
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X89.327 Y122.041 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.102074
G1 F3600
M204 S3000
G1 X89.252 Y122.137 E.00057
; LINE_WIDTH: 0.130339
G1 X89.175 Y122.237 E.00087
; LINE_WIDTH: 0.16292
G1 X89.085 Y122.363 E.00147
; LINE_WIDTH: 0.198933
G1 X88.994 Y122.488 E.00191
; WIPE_START
G1 X89.085 Y122.363 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X90.425 Y120.671 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.189066
G1 F3600
M204 S3000
G1 X90.315 Y120.667 E.00128
; LINE_WIDTH: 0.224841
G1 X90.28 Y120.666 E.00049
G2 X89.861 Y121.066 I2.887 J3.438 E.00833
G1 X89.759 Y121.193 E.00235
; WIPE_START
G1 X89.861 Y121.066 E-.15977
G1 X90.28 Y120.666 E-.56658
G1 X90.315 Y120.667 E-.03366
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.795 Y119.673 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.161526
G1 F3600
M204 S3000
G1 X91.642 Y119.78 E.00175
; LINE_WIDTH: 0.141734
G1 X91.523 Y119.872 E.00117
; LINE_WIDTH: 0.106028
G1 X91.404 Y119.964 E.00075
; WIPE_START
G1 X91.523 Y119.872 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.983 Y126.065 Z2.4 F30000
G1 X98.584 Y129.676 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.199591
G1 F3600
M204 S3000
G1 X98.478 Y129.826 E.00228
; LINE_WIDTH: 0.159276
G1 X98.361 Y129.979 E.00176
; LINE_WIDTH: 0.11187
G1 X98.245 Y130.131 E.00104
; WIPE_START
G1 X98.361 Y129.979 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.379 Y131.996 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.124036
G1 F3600
M204 S3000
G3 X95.993 Y132.288 I-2.892 J-3.419 E.0031
M204 S10000
G1 X95.461 Y132.384 F30000
; LINE_WIDTH: 0.100979
G1 F3600
M204 S3000
G3 X95.219 Y132.528 I-1.884 J-2.895 E.00129
; WIPE_START
G1 X95.461 Y132.384 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X92.243 Y132.428 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0921951
G1 F3600
M204 S3000
G1 X92.101 Y132.343 E.00064
; WIPE_START
G1 X92.243 Y132.428 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.882 Y133.866 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.221559
G1 F3600
M204 S3000
G1 X97.772 Y133.953 E.00198
; LINE_WIDTH: 0.194808
G1 X97.666 Y134.028 E.00156
; LINE_WIDTH: 0.152155
G1 X97.559 Y134.103 E.00112
; LINE_WIDTH: 0.109502
G1 X97.452 Y134.178 E.00069
; WIPE_START
G1 X97.559 Y134.103 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.411 Y131.755 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.095365
G1 F3600
M204 S3000
M73 P99 R0
G1 X100.35 Y131.829 E.0004
; LINE_WIDTH: 0.125539
G1 X100.161 Y132.05 E.0019
; LINE_WIDTH: 0.171501
G1 X99.972 Y132.271 E.00295
; LINE_WIDTH: 0.201073
G1 X99.783 Y132.493 E.00363
G1 X99.174 Y133.038 E.01022
; LINE_WIDTH: 0.134571
G1 X99.008 Y133.181 E.00159
; LINE_WIDTH: 0.103641
G1 X98.842 Y133.324 E.00105
; WIPE_START
G1 X99.008 Y133.181 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.651 Y129.45 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.140375
G1 F3600
M204 S3000
G1 X101.539 Y129.617 E.00155
; LINE_WIDTH: 0.186994
G1 X101.427 Y129.785 E.00229
; WIPE_START
G1 X101.539 Y129.617 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.341 Y124.029 Z2.4 F30000
G1 X90.434 Y117.679 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.109166
G1 F3600
M204 S3000
G1 X90.306 Y117.768 E.00082
; LINE_WIDTH: 0.151177
G1 X90.178 Y117.858 E.00133
; LINE_WIDTH: 0.193188
G1 X90.05 Y117.947 E.00185
M204 S10000
G1 X89.291 Y118.287 F30000
; LINE_WIDTH: 0.112756
G1 F3600
M204 S3000
G1 X89.106 Y118.433 E.0013
; LINE_WIDTH: 0.159115
G1 X88.889 Y118.62 E.00263
; LINE_WIDTH: 0.202653
G1 X88.672 Y118.807 E.00361
; LINE_WIDTH: 0.246191
G1 X88.454 Y118.993 E.0046
; LINE_WIDTH: 0.290978
G1 X88.152 Y119.262 E.00793
; LINE_WIDTH: 0.337015
G1 X87.85 Y119.532 E.0094
; LINE_WIDTH: 0.338091
G1 X87.667 Y119.747 E.00659
; LINE_WIDTH: 0.294229
G1 X87.483 Y119.961 E.00561
; LINE_WIDTH: 0.250367
G1 X87.299 Y120.176 E.00463
; LINE_WIDTH: 0.20505
G1 X87.14 Y120.369 E.00321
; LINE_WIDTH: 0.1583
G1 X86.981 Y120.563 E.00228
; LINE_WIDTH: 0.111549
G1 X86.822 Y120.756 E.00136
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F3600
G1 X86.981 Y120.563 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F30000
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
G1 Z2.5 F900 ; lower z a little
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

    G1 Z102 F600
    G1 Z100

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

