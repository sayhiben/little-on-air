; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 56m 25s; total estimated time: 1h 4m 51s
; total layer number: 25
; total filament length [mm] : 2941.41,435.56
; total filament volume [cm^3] : 7074.91,1047.64
; total filament weight [g] : 8.84,1.31
; filament_density: 1.25,1.25,1.27
; filament_diameter: 1.75,1.75,1.75
; max_z_height: 2.50
; filament: 1,2
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,0,0
; additional_cooling_fan_speed = 70,70,0
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
; close_additional_fan_first_x_layers = 1,1,3
; close_fan_the_first_x_layers = 1,1,3
; complete_print_exhaust_fan_speed = 70,70,70
; cool_plate_temp = 35,35,0
; cool_plate_temp_initial_layer = 35,35,0
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
; different_settings_to_system = bottom_shell_layers;bridge_speed;brim_object_gap;brim_type;brim_width;default_acceleration;enable_prime_tower;enable_support;flush_into_infill;flush_into_objects;flush_into_support;gap_infill_speed;initial_layer_infill_speed;initial_layer_print_height;initial_layer_speed;inner_wall_speed;internal_solid_infill_speed;layer_height;outer_wall_acceleration;outer_wall_speed;reduce_crossing_wall;sparse_infill_density;sparse_infill_pattern;sparse_infill_speed;support_interface_bottom_layers;support_interface_spacing;support_interface_top_layers;support_object_xy_distance;support_on_build_plate_only;support_style;support_threshold_angle;support_top_z_distance;support_type;top_shell_layers;top_surface_speed;wall_generator;wall_loops;activate_air_filtration;additional_cooling_fan_speed;additional_fan_full_speed_layer;chamber_temperatures;circle_compensation_speed;close_additional_fan_first_x_layers;close_fan_the_first_x_layers;complete_print_exhaust_fan_speed;cool_plate_temp;cool_plate_temp_initial_layer;cooling_perimeter_transition_distance;cooling_slowdown_logic;counter_coef_1;counter_coef_2;counter_coef_3;counter_limit_max;counter_limit_min;default_filament_colour;diameter_limit;during_print_exhaust_fan_speed;enable_overhang_bridge_fan;enable_pressure_advance;eng_plate_temp;eng_plate_temp_initial_layer;fan_cooling_layer_time;fan_max_speed;fan_min_speed;filament_adaptive_volumetric_speed;filament_adhesiveness_category;filament_bridge_speed;filament_change_length;filament_change_length_nc;filament_colour;filament_colour_type;filament_cooling_before_tower;filament_cost;filament_density;filament_deretraction_speed;filament_dev_ams_drying_ams_limitations;filament_dev_ams_drying_heat_distortion_temperature;filament_dev_ams_drying_temperature;filament_dev_ams_drying_time;filament_dev_chamber_drying_bed_temperature;filament_dev_chamber_drying_time;filament_dev_drying_cooling_temperature;filament_dev_drying_softening_temperature;filament_diameter;filament_enable_overhang_speed;filament_end_gcode;filament_extruder_compatibility;filament_extruder_variant;filament_flow_ratio;filament_flush_temp;filament_flush_temp_fast;filament_flush_volumetric_speed;filament_ids;filament_is_support;filament_long_retractions_when_cut;filament_max_volumetric_speed;filament_metal_stickiness;filament_minimal_purge_on_wipe_tower;filament_multi_colour;filament_notes;filament_overhang_1_4_speed;filament_overhang_2_4_speed;filament_overhang_3_4_speed;filament_overhang_4_4_speed;filament_overhang_totally_speed;filament_pre_cooling_temperature;filament_pre_cooling_temperature_nc;filament_preheat_temperature_delta;filament_prime_volume;filament_prime_volume_nc;filament_printable;filament_ramming_travel_time;filament_ramming_travel_time_nc;filament_ramming_volumetric_speed;filament_ramming_volumetric_speed_nc;filament_retract_before_wipe;filament_retract_length_nc;filament_retract_restart_extra;filament_retract_when_changing_layer;filament_retraction_distances_when_cut;filament_retraction_length;filament_retraction_minimum_travel;filament_retraction_speed;filament_scarf_gap;filament_scarf_height;filament_scarf_length;filament_scarf_seam_type;filament_settings_id;filament_shrink;filament_soluble;filament_start_gcode;filament_tower_interface_pre_extrusion_dist;filament_tower_interface_pre_extrusion_length;filament_tower_interface_print_temp;filament_tower_interface_purge_volume;filament_tower_ironing_area;filament_type;filament_velocity_adaptation_factor;filament_vendor;filament_wipe;filament_wipe_distance;filament_z_hop;filament_z_hop_types;first_x_layer_fan_speed;first_x_layer_part_fan_speed;full_fan_speed_layer;hole_coef_1;hole_coef_2;hole_coef_3;hole_limit_max;hole_limit_min;hot_plate_temp;hot_plate_temp_initial_layer;impact_strength_z;ironing_fan_speed;long_retractions_when_ec;no_slow_down_for_cooling_on_outwalls;nozzle_temperature;nozzle_temperature_initial_layer;nozzle_temperature_range_high;nozzle_temperature_range_low;overhang_fan_speed;overhang_fan_threshold;overhang_threshold_participating_cooling;override_process_overhang_speed;pre_start_fan_time;pressure_advance;reduce_fan_stop_start_freq;retraction_distances_when_ec;slow_down_for_layer_cooling;slow_down_layer_time;slow_down_min_speed;supertack_plate_temp;supertack_plate_temp_initial_layer;temperature_vitrification;textured_plate_temp;textured_plate_temp_initial_layer;volumetric_speed_coefficients;activate_air_filtration;additional_cooling_fan_speed;additional_fan_full_speed_layer;chamber_temperatures;circle_compensation_speed;close_additional_fan_first_x_layers;close_fan_the_first_x_layers;complete_print_exhaust_fan_speed;cool_plate_temp;cool_plate_temp_initial_layer;cooling_perimeter_transition_distance;cooling_slowdown_logic;counter_coef_1;counter_coef_2;counter_coef_3;counter_limit_max;counter_limit_min;default_filament_colour;diameter_limit;during_print_exhaust_fan_speed;enable_overhang_bridge_fan;enable_pressure_advance;eng_plate_temp;eng_plate_temp_initial_layer;fan_cooling_layer_time;fan_max_speed;fan_min_speed;filament_adaptive_volumetric_speed;filament_adhesiveness_category;filament_bridge_speed;filament_change_length;filament_change_length_nc;filament_colour;filament_colour_type;filament_cooling_before_tower;filament_cost;filament_density;filament_deretraction_speed;filament_dev_ams_drying_ams_limitations;filament_dev_ams_drying_heat_distortion_temperature;filament_dev_ams_drying_temperature;filament_dev_ams_drying_time;filament_dev_chamber_drying_bed_temperature;filament_dev_chamber_drying_time;filament_dev_drying_cooling_temperature;filament_dev_drying_softening_temperature;filament_diameter;filament_enable_overhang_speed;filament_end_gcode;filament_extruder_compatibility;filament_extruder_variant;filament_flow_ratio;filament_flush_temp;filament_flush_temp_fast;filament_flush_volumetric_speed;filament_ids;filament_is_support;filament_long_retractions_when_cut;filament_max_volumetric_speed;filament_metal_stickiness;filament_minimal_purge_on_wipe_tower;filament_multi_colour;filament_notes;filament_overhang_1_4_speed;filament_overhang_2_4_speed;filament_overhang_3_4_speed;filament_overhang_4_4_speed;filament_overhang_totally_speed;filament_pre_cooling_temperature;filament_pre_cooling_temperature_nc;filament_preheat_temperature_delta;filament_prime_volume;filament_prime_volume_nc;filament_printable;filament_ramming_travel_time;filament_ramming_travel_time_nc;filament_ramming_volumetric_speed;filament_ramming_volumetric_speed_nc;filament_retract_before_wipe;filament_retract_length_nc;filament_retract_restart_extra;filament_retract_when_changing_layer;filament_retraction_distances_when_cut;filament_retraction_length;filament_retraction_minimum_travel;filament_retraction_speed;filament_scarf_gap;filament_scarf_height;filament_scarf_length;filament_scarf_seam_type;filament_settings_id;filament_shrink;filament_soluble;filament_start_gcode;filament_tower_interface_pre_extrusion_dist;filament_tower_interface_pre_extrusion_length;filament_tower_interface_print_temp;filament_tower_interface_purge_volume;filament_tower_ironing_area;filament_type;filament_velocity_adaptation_factor;filament_vendor;filament_wipe;filament_wipe_distance;filament_z_hop;filament_z_hop_types;first_x_layer_fan_speed;first_x_layer_part_fan_speed;full_fan_speed_layer;hole_coef_1;hole_coef_2;hole_coef_3;hole_limit_max;hole_limit_min;hot_plate_temp;hot_plate_temp_initial_layer;impact_strength_z;ironing_fan_speed;long_retractions_when_ec;no_slow_down_for_cooling_on_outwalls;nozzle_temperature;nozzle_temperature_initial_layer;nozzle_temperature_range_high;nozzle_temperature_range_low;overhang_fan_speed;overhang_fan_threshold;overhang_threshold_participating_cooling;override_process_overhang_speed;pre_start_fan_time;pressure_advance;reduce_fan_stop_start_freq;retraction_distances_when_ec;slow_down_for_layer_cooling;slow_down_layer_time;slow_down_min_speed;supertack_plate_temp;supertack_plate_temp_initial_layer;temperature_vitrification;textured_plate_temp;textured_plate_temp_initial_layer;volumetric_speed_coefficients;activate_air_filtration;additional_cooling_fan_speed;additional_fan_full_speed_layer;chamber_temperatures;circle_compensation_speed;close_additional_fan_first_x_layers;close_fan_the_first_x_layers;complete_print_exhaust_fan_speed;cool_plate_temp;cool_plate_temp_initial_layer;cooling_perimeter_transition_distance;cooling_slowdown_logic;counter_coef_1;counter_coef_2;counter_coef_3;counter_limit_max;counter_limit_min;default_filament_colour;diameter_limit;during_print_exhaust_fan_speed;enable_overhang_bridge_fan;enable_pressure_advance;eng_plate_temp;eng_plate_temp_initial_layer;fan_cooling_layer_time;fan_max_speed;fan_min_speed;filament_adaptive_volumetric_speed;filament_adhesiveness_category;filament_bridge_speed;filament_change_length;filament_change_length_nc;filament_colour;filament_colour_type;filament_cooling_before_tower;filament_cost;filament_density;filament_deretraction_speed;filament_dev_ams_drying_ams_limitations;filament_dev_ams_drying_heat_distortion_temperature;filament_dev_ams_drying_temperature;filament_dev_ams_drying_time;filament_dev_chamber_drying_bed_temperature;filament_dev_chamber_drying_time;filament_dev_drying_cooling_temperature;filament_dev_drying_softening_temperature;filament_diameter;filament_enable_overhang_speed;filament_end_gcode;filament_extruder_compatibility;filament_extruder_variant;filament_flow_ratio;filament_flush_temp;filament_flush_temp_fast;filament_flush_volumetric_speed;filament_ids;filament_is_support;filament_long_retractions_when_cut;filament_max_volumetric_speed;filament_metal_stickiness;filament_minimal_purge_on_wipe_tower;filament_multi_colour;filament_notes;filament_overhang_1_4_speed;filament_overhang_2_4_speed;filament_overhang_3_4_speed;filament_overhang_4_4_speed;filament_overhang_totally_speed;filament_pre_cooling_temperature;filament_pre_cooling_temperature_nc;filament_preheat_temperature_delta;filament_prime_volume;filament_prime_volume_nc;filament_printable;filament_ramming_travel_time;filament_ramming_travel_time_nc;filament_ramming_volumetric_speed;filament_ramming_volumetric_speed_nc;filament_retract_before_wipe;filament_retract_length_nc;filament_retract_restart_extra;filament_retract_when_changing_layer;filament_retraction_distances_when_cut;filament_retraction_length;filament_retraction_minimum_travel;filament_retraction_speed;filament_scarf_gap;filament_scarf_height;filament_scarf_length;filament_scarf_seam_type;filament_settings_id;filament_shrink;filament_soluble;filament_start_gcode;filament_tower_interface_pre_extrusion_dist;filament_tower_interface_pre_extrusion_length;filament_tower_interface_print_temp;filament_tower_interface_purge_volume;filament_tower_ironing_area;filament_type;filament_velocity_adaptation_factor;filament_vendor;filament_wipe;filament_wipe_distance;filament_z_hop;filament_z_hop_types;first_x_layer_fan_speed;first_x_layer_part_fan_speed;full_fan_speed_layer;hole_coef_1;hole_coef_2;hole_coef_3;hole_limit_max;hole_limit_min;hot_plate_temp;hot_plate_temp_initial_layer;impact_strength_z;ironing_fan_speed;long_retractions_when_ec;no_slow_down_for_cooling_on_outwalls;nozzle_temperature;nozzle_temperature_initial_layer;nozzle_temperature_range_high;nozzle_temperature_range_low;overhang_fan_speed;overhang_fan_threshold;overhang_threshold_participating_cooling;override_process_overhang_speed;pre_start_fan_time;pressure_advance;reduce_fan_stop_start_freq;retraction_distances_when_ec;slow_down_for_layer_cooling;slow_down_layer_time;slow_down_min_speed;supertack_plate_temp;supertack_plate_temp_initial_layer;temperature_vitrification;textured_plate_temp;textured_plate_temp_initial_layer;volumetric_speed_coefficients;scan_first_layer
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
; enable_prime_tower = 1
; enable_support = 1
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 0,0,70
; eng_plate_temp_initial_layer = 0,0,70
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
; fan_cooling_layer_time = 100,100,30
; fan_direction = left
; fan_max_speed = 100,100,30
; fan_min_speed = 100,100,10
; farthest_point_timelapse = 1
; filament_adaptive_volumetric_speed = 0,0,0
; filament_adhesiveness_category = 100,100,300
; filament_bridge_speed = 25,25,25
; filament_change_length = 10,10,10
; filament_change_length_nc = 10,10,10
; filament_colour = #161616;#FFFFFF;#D8EDF0
; filament_colour_type = 0;0;0
; filament_cooling_before_tower = 0,0,0
; filament_cost = 22.99,22.99,30
; filament_density = 1.25,1.25,1.27
; filament_dev_ams_drying_ams_limitations = 1;1;1
; filament_dev_ams_drying_heat_distortion_temperature = 45,45,75
; filament_dev_ams_drying_temperature = 45,45,65
; filament_dev_ams_drying_time = 12,12,12
; filament_dev_chamber_drying_bed_temperature = 70,70,80
; filament_dev_chamber_drying_time = 12,12,12
; filament_dev_drying_cooling_temperature = 45,45,55
; filament_dev_drying_softening_temperature = 50,50,60
; filament_diameter = 1.75,1.75,1.75
; filament_enable_overhang_speed = 1,1,1
; filament_end_gcode = "; filament end gcode \n\n";"; filament end gcode \n\n";"; filament end gcode \n\n"
; filament_extruder_compatibility = 0,0,0
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.98,0.98,0.95
; filament_flush_temp = 0,0,0
; filament_flush_temp_fast = 0,0,0
; filament_flush_volumetric_speed = 0,0,0
; filament_ids = GFL03;GFL03;GFG99
; filament_is_mixed = 0
; filament_is_support = 0,0,0
; filament_map = 1,1,1
; filament_map_2 = 0,0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 16,16,4
; filament_metal_stickiness = None,None,High
; filament_minimal_purge_on_wipe_tower = 15,15,15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_multi_colour = #161616;#FFFFFF;#D8EDF0
; filament_notes = Black and white share the previous eSUN PLA+ baseline. Clear PETG retains the optical profile. Match actual spool temperatures and calibrated flow before printing.
; filament_nozzle_map = 0,0,0
; filament_overhang_1_4_speed = 0,0,0
; filament_overhang_2_4_speed = 50,50,50
; filament_overhang_3_4_speed = 30,30,30
; filament_overhang_4_4_speed = 10,10,10
; filament_overhang_totally_speed = 10,10,10
; filament_pre_cooling_temperature = 0,0,0
; filament_pre_cooling_temperature_nc = 0,0,0
; filament_preheat_temperature_delta = 10,10,0
; filament_prime_volume = 45,45,45
; filament_prime_volume_nc = 60,60,60
; filament_printable = 3,3,3
; filament_ramming_travel_time = 0,0,0
; filament_ramming_travel_time_nc = 0,0,0
; filament_ramming_volumetric_speed = -1,-1,-1
; filament_ramming_volumetric_speed_nc = -1,-1,-1
; filament_retract_length_nc = 14,14,14
; filament_scarf_gap = 15%,15%,0%
; filament_scarf_height = 10%,10%,10%
; filament_scarf_length = 10,10,10
; filament_scarf_seam_type = none,none,none
; filament_self_index = 1,2,3
; filament_settings_id = "ON AIR black PLA+ - eSUN baseline";"ON AIR white PLA+ - eSUN baseline";"ON AIR clear PETG - calibrate actual spool"
; filament_shrink = 100%,100%,100%
; filament_soluble = 0,0,0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10,10,10
; filament_tower_interface_pre_extrusion_length = 0,0,0
; filament_tower_interface_print_temp = -1,-1,-1
; filament_tower_interface_purge_volume = 20,20,20
; filament_tower_ironing_area = 4,4,4
; filament_type = PLA;PLA;PETG
; filament_velocity_adaptation_factor = 1,1,1
; filament_vendor = eSUN;eSUN;Generic
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
; flush_volumes_matrix = 0,700,700,220,0,500,500,500,0
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
; hot_plate_temp = 55,55,70
; hot_plate_temp_initial_layer = 55,55,70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10,10,10
; independent_support_layer_height = 0
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
; nozzle_temperature = 220,220,255
; nozzle_temperature_initial_layer = 220,220,255
; nozzle_temperature_range_high = 240,240,270
; nozzle_temperature_range_low = 190,190,220
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
; overhang_fan_speed = 100,100,30
; overhang_fan_threshold = 50%,50%,10%
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
; print_sequence = by layer
; print_settings_id = ON AIR complete v2.13 - structural + two-color insert + clear guides
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
; slow_down_layer_time = 6,6,12
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
; supertack_plate_temp = 45,45,70
; supertack_plate_temp_initial_layer = 45,45,70
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
; temperature_vitrification = 45,45,70
; template_custom_gcode = 
; textured_plate_temp = 55,55,70
; textured_plate_temp_initial_layer = 55,55,70
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
M73 P0 R64
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
G1 E50 F200
M400
M104 S220
G92 E0
M73 P7 R59
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P8 R59
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
    G29 A X19.1032 Y106.936 I162.961 J112.511
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
M73 P9 R58
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
M73 P10 R58
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
M73 P10 R57
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
M204 S10000
G1 Z.5 F30000
; CHANGE_LAYER
; Z_HEIGHT: 0.1
; LAYER_HEIGHT: 0.1
G1 E-.8 F1800
; layer num/total_layer_count: 1/25
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
G1 X51.016 Y211.534 F30000
M204 S6000
G1 Z.9
G1 Z.1
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S500
G1  X24.516 Y211.534  E0.5272 F900
M73 P11 R57
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S6000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #2
M204 S500
G1  Y186.034  E0.0099
G1  X50.516  E0.4974
G1  Y186.534  E0.0099
G1  X25.016  E0.5073
G1  Y187.034  E0.0099
G1  X50.516  E0.5073
G1  Y187.534  E0.0099
G1  X25.016  E0.5073
G1  Y188.034  E0.0099
G1  X50.516  E0.5073
G1  Y188.534  E0.0099
G1  X25.016  E0.5073
G1  Y189.034  E0.0099
G1  X50.516  E0.5073
G1  Y189.534  E0.0099
G1  X25.016  E0.5073
G1  Y190.034  E0.0099
G1  X50.516  E0.5073
G1  Y190.534  E0.0099
G1  X25.016  E0.5073
G1  Y191.034  E0.0099
G1  X50.516  E0.5073
G1  Y191.534  E0.0099
G1  X25.016  E0.5073
G1  Y192.034  E0.0099
G1  X50.516  E0.5073
G1  Y192.534  E0.0099
G1  X25.016  E0.5073
G1  Y193.034  E0.0099
G1  X50.516  E0.5073
G1  Y193.534  E0.0099
G1  X25.016  E0.5073
G1  Y194.034  E0.0099
G1  X50.516  E0.5073
G1  Y194.534  E0.0099
G1  X25.016  E0.5073
G1  Y195.034  E0.0099
G1  X50.516  E0.5073
G1  Y195.534  E0.0099
G1  X25.016  E0.5073
M73 P12 R56
G1  Y196.034  E0.0099
G1  X50.516  E0.5073
G1  Y196.534  E0.0099
G1  X25.016  E0.5073
G1  Y197.034  E0.0099
G1  X50.516  E0.5073
G1  Y197.534  E0.0099
G1  X25.016  E0.5073
G1  Y198.034  E0.0099
G1  X50.516  E0.5073
G1  Y198.534  E0.0099
G1  X25.016  E0.5073
G1  Y199.034  E0.0099
G1  X50.516  E0.5073
G1  Y199.534  E0.0099
G1  X25.016  E0.5073
G1  Y200.034  E0.0099
G1  X50.516  E0.5073
G1  Y200.534  E0.0099
G1  X25.016  E0.5073
G1  Y201.034  E0.0099
G1  X50.516  E0.5073
G1  Y201.534  E0.0099
G1  X25.016  E0.5073
G1  Y202.034  E0.0099
G1  X50.516  E0.5073
G1  Y202.534  E0.0099
G1  X25.016  E0.5073
G1  Y203.034  E0.0099
G1  X50.516  E0.5073
G1  Y203.534  E0.0099
G1  X25.016  E0.5073
G1  Y204.034  E0.0099
G1  X50.516  E0.5073
G1  Y204.534  E0.0099
G1  X25.016  E0.5073
G1  Y205.034  E0.0099
G1  X50.516  E0.5073
G1  Y205.534  E0.0099
G1  X25.016  E0.5073
G1  Y206.034  E0.0099
G1  X50.516  E0.5073
G1  Y206.534  E0.0099
G1  X25.016  E0.5073
G1  Y207.034  E0.0099
G1  X50.516  E0.5073
G1  Y207.534  E0.0099
G1  X25.016  E0.5073
G1  Y208.034  E0.0099
G1  X50.516  E0.5073
G1  Y208.534  E0.0099
G1  X25.016  E0.5073
G1  Y209.034  E0.0099
M73 P13 R56
G1  X50.516  E0.5073
G1  Y209.534  E0.0099
G1  X25.016  E0.5073
G1  Y210.034  E0.0099
G1  X50.516  E0.5073
G1  Y210.534  E0.0099
G1  X25.016  E0.5073
G1  Y211.034  E0.0099
G1  X50.516  E0.5073
G1  Y211.534  E0.0099
; CP EMPTY GRID END
;------------------






M204 S6000
G1  X51.516 Y212.534  
M204 S500
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
M73 P13 R55
G3  X26.400 Y183.047   I4.714 J3.233 E0.0625
G3  X29.023 Y184.259   I0.130 J3.164 E0.0597
G2  X31.578 Y185.034   I2.561 J-3.843 E0.0539
G2  X44.135 Y185.030   I6.188 J-319.311 E0.2498
G2  X47.823 Y183.202   I-0.466 J-5.574 E0.0839
G3  X48.837 Y183.000   I0.873 J1.736 E0.0208
G3  X50.034 Y183.552   I-0.160 J1.921 E0.0268
G1  X51.516 Y185.034   E0.0417
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
M204 S6000
M73 P14 R55
G1  X53.343 Y211.384  
M204 S500
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
G3  X53.579 Y186.461   I-16.082 J19.093 E0.0911
G3  X53.683 Y189.108   I-1.939 J1.402 E0.0558
G2  X51.995 Y192.600   I3.112 J3.659 E0.0794
G2  X51.998 Y205.134   I318.389 J6.184 E0.2494
G2  X53.775 Y208.623   I5.988 J-0.852 E0.0793
G3  X53.343 Y211.384   I-2.162 J1.076 E0.0593
M204 S6000
G1  X53.688 Y211.716  
M204 S500
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
M73 P15 R55
G3  X48.912 Y182.046   I1.311 J2.609 E0.0313
G3  X50.698 Y182.862   I-0.238 J2.882 E0.0399
G3  X53.967 Y186.180   I-16.301 J19.330 E0.0928
G3  X54.091 Y189.358   I-2.329 J1.683 E0.0671
G2  X52.473 Y192.605   I2.833 J3.439 E0.0743
G2  X52.476 Y205.115   I317.536 J6.179 E0.2489
G2  X54.201 Y208.406   I6.145 J-1.124 E0.0751
G3  X53.688 Y211.716   I-2.595 J1.292 E0.0710
M204 S6000
G1  X54.033 Y212.048  
M204 S500
G3  X50.652 Y215.372   I-19.605 J-16.557 E0.0945
M73 P15 R54
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
G3  X54.354 Y185.898   I-16.555 J19.603 E0.0945
G3  X54.500 Y189.608   I-2.719 J1.965 E0.0783
G2  X52.952 Y192.610   I2.934 J3.413 E0.0689
G2  X52.954 Y205.097   I316.680 J6.174 E0.2484
G2  X54.500 Y207.960   I4.544 J-0.604 E0.0662
G3  X54.033 Y212.048   I-2.859 J1.744 E0.0882
M204 S6000
G1  X54.378 Y212.379  
M204 S500
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
G3  X54.741 Y185.617   I-16.824 J19.890 E0.0962
G3  X53.826 Y191.193   I-3.545 J2.281 E0.1232
G2  X53.430 Y192.615   I2.346 J1.419 E0.0297
G2  X53.433 Y205.078   I315.895 J6.169 E0.2480
G2  X54.908 Y207.709   I4.409 J-0.743 E0.0612
G3  X54.378 Y212.379   I-3.268 J1.994 E0.1007
M204 S6000
G1  X54.723 Y212.711  
M204 S500
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
G3  X55.129 Y185.335   I-17.109 J20.194 E0.0978
G3  X54.190 Y191.518   I-4.041 J2.549 E0.1356
G2  X53.909 Y192.620   I1.945 J1.084 E0.0229
G2  X53.911 Y205.060   I315.006 J6.164 E0.2475
G2  X55.316 Y207.459   I4.304 J-0.910 E0.0563
G3  X54.723 Y212.711   I-3.677 J2.244 E0.1132
M204 S6000
G1  X55.068 Y213.043  
M204 S500
M73 P16 R54
G3  X51.496 Y216.534   I-20.504 J-17.402 E0.0995
G3  X44.738 Y215.594   I-2.847 J-4.294 E0.1484
G2  X43.925 Y215.405   I-0.799 J1.597 E0.0168
G2  X31.509 Y215.407   I-6.159 J314.135 E0.2470
G2  X29.341 Y216.743   I1.390 J4.683 E0.0513
G3  X23.507 Y216.086   I-2.494 J-4.087 E0.1257
G3  X20.016 Y212.514   I17.403 J-20.505 E0.0995
G3  X20.956 Y205.756   I4.294 J-2.847 E0.1484
G2  X21.145 Y204.943   I-1.597 J-0.799 E0.0168
G2  X21.143 Y192.527   I-314.070 J-6.159 E0.2470
G2  X19.807 Y190.359   I-4.683 J1.390 E0.0513
G3  X20.464 Y184.525   I4.087 J-2.494 E0.1257
G3  X24.036 Y181.034   I20.507 J17.405 E0.0995
G3  X30.794 Y181.974   I2.847 J4.294 E0.1484
G2  X31.607 Y182.163   I0.799 J-1.597 E0.0168
G2  X44.023 Y182.161   I6.159 J-314.005 E0.2470
G2  X46.191 Y180.825   I-1.380 J-4.668 E0.0513
G3  X49.062 Y180.136   I2.572 J4.386 E0.0596
G3  X52.025 Y181.482   I-0.396 J4.804 E0.0660
G3  X55.516 Y185.054   I-17.404 J20.506 E0.0995
G3  X54.576 Y191.812   I-4.295 J2.847 E0.1484
G2  X54.387 Y192.625   I1.597 J0.799 E0.0168
G2  X54.389 Y205.041   I314.134 J6.159 E0.2470
G2  X55.725 Y207.209   I4.669 J-1.381 E0.0513
G3  X55.068 Y213.043   I-4.087 J2.494 E0.1257
; WIPE_TOWER_END

; WIPE_START
G1 F24000
M204 S500
G1 X55.284 Y212.808 E-.12113
G1 X55.516 Y212.514 E-.14254
G1 X55.725 Y212.202 E-.1426
G1 X55.908 Y211.874 E-.14255
G1 X56.065 Y211.534 E-.14255
G1 X56.128 Y211.364 E-.06864
; WIPE_END
G1 E-.04 F1800
M204 S6000
G17
G3 Z.5 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S6000
G1 X78.458 Y146.724
G1 Z.1
G1 E.8 F1800
; FEATURE: Brim
; LINE_WIDTH: 0.5
; LAYER_HEIGHT: 0.1
G1 F900
M204 S500
G1 X78.259 Y146.655 E.00409
G1 X77.916 Y146.465 E.00765
G1 X77.703 Y146.284 E.00546
G1 X74.719 Y143.3 E.08227
G1 X74.473 Y142.989 E.00774
G1 X74.306 Y142.647 E.00743
G1 X74.198 Y142.269 E.00765
G1 X74.175 Y141.99 E.00546
G1 X74.175 Y107.014 E.68196
G1 X74.221 Y106.618 E.00777
G1 X74.316 Y106.331 E.0059
G1 X74.558 Y105.889 E.00982
G1 X74.813 Y105.617 E.00727
G1 X75.375 Y105.296 E.01262
G1 X75.762 Y105.193 E.00781
G1 X76.009 Y105.175 E.00482
G1 X179.986 Y105.175 E2.0273
G1 X180.379 Y105.22 E.00771
G1 X180.774 Y105.361 E.00817
G1 X181.109 Y105.556 E.00755
G1 X181.383 Y105.813 E.00733
G1 X181.704 Y106.375 E.01262
G1 X181.807 Y106.762 E.00781
G1 X181.825 Y107.009 E.00482
G1 X181.825 Y144.986 E.74047
G1 X181.779 Y145.382 E.00777
G1 X181.684 Y145.669 E.0059
G1 X181.442 Y146.111 E.00982
G1 X181.187 Y146.383 E.00727
G1 X180.625 Y146.704 E.01262
G1 X180.238 Y146.807 E.00781
G1 X179.991 Y146.825 E.00482
G1 X79.014 Y146.825 E1.96881
G1 X78.619 Y146.78 E.00774
G1 X78.515 Y146.743 E.00216
M204 S6000
G1 X78.666 Y146.287 F30000
G1 F900
M204 S500
G1 X78.467 Y146.221 E.00409
G1 X78.202 Y146.076 E.00588
G1 X78.032 Y145.935 E.00432
G1 X75.083 Y142.987 E.0813
G1 X74.89 Y142.745 E.00603
G1 X74.751 Y142.463 E.00613
G1 X74.675 Y142.197 E.00539
G1 X74.654 Y141.965 E.00454
G1 X74.654 Y107.049 E.68076
G1 X74.689 Y106.736 E.00614
M73 P16 R53
G1 X74.752 Y106.535 E.00412
G1 X74.939 Y106.188 E.00768
G1 X75.131 Y105.986 E.00543
G1 X75.576 Y105.738 E.00994
G1 X75.829 Y105.671 E.0051
G1 X76.031 Y105.654 E.00396
G1 X179.967 Y105.655 E2.02649
G1 X180.286 Y105.695 E.00626
G1 X180.559 Y105.793 E.00567
G1 X180.807 Y105.934 E.00556
G1 X180.987 Y106.098 E.00475
G1 X181.262 Y106.576 E.01076
G1 X181.329 Y106.829 E.00509
G1 X181.346 Y107.031 E.00397
G1 X181.346 Y144.951 E.73933
G1 X181.311 Y145.264 E.00614
G1 X181.248 Y145.465 E.00412
G1 X181.061 Y145.812 E.00768
G1 X180.869 Y146.014 E.00543
G1 X180.424 Y146.262 E.00994
G1 X180.171 Y146.329 E.00509
G1 X179.969 Y146.346 E.00397
G1 X79.049 Y146.346 E1.96767
G1 X78.742 Y146.312 E.00604
G1 X78.723 Y146.306 E.00038
M204 S6000
G1 X78.821 Y145.841 F30000
G1 F900
M204 S500
G1 X78.678 Y145.791 E.00296
M73 P17 R53
G1 X78.513 Y145.705 E.00363
G1 X78.379 Y145.606 E.00325
G1 X75.394 Y142.621 E.08231
G1 X75.279 Y142.468 E.00372
G1 X75.213 Y142.331 E.00296
G1 X75.158 Y142.154 E.00363
G1 X75.132 Y141.989 E.00325
G1 X75.132 Y107.011 E.68197
G1 X75.16 Y106.839 E.0034
G1 X75.219 Y106.661 E.00366
G1 X75.359 Y106.438 E.00514
G1 X75.466 Y106.335 E.00289
G1 X75.69 Y106.204 E.00506
G1 X76.01 Y106.132 E.00641
G1 X179.989 Y106.132 E2.02733
G1 X180.294 Y106.195 E.00606
G1 X180.384 Y106.234 E.00192
G1 X180.56 Y106.357 E.00418
G1 X180.665 Y106.466 E.00296
G1 X180.796 Y106.69 E.00506
G1 X180.868 Y107.01 E.00641
G1 X180.868 Y144.993 E.74056
G1 X180.804 Y145.297 E.00606
G1 X180.766 Y145.384 E.00186
G1 X180.643 Y145.56 E.00418
G1 X180.534 Y145.665 E.00296
G1 X180.31 Y145.796 E.00506
G1 X179.99 Y145.868 E.00641
G1 X79.01 Y145.868 E1.96884
G1 X78.881 Y145.849 E.00255
M204 S6000
G1 X78.973 Y145.384 F30000
G1 F900
M204 S500
G1 X78.908 Y145.371 E.00129
G1 X78.725 Y145.275 E.00404
G1 X75.725 Y142.275 E.08272
G1 X75.673 Y142.198 E.00182
G1 X75.611 Y142 E.00404
G1 X75.611 Y107 E.68241
G1 X75.679 Y106.794 E.00422
G1 X75.81 Y106.667 E.00357
G1 X76 Y106.611 E.00386
G1 X180 Y106.611 E2.02774
G1 X180.096 Y106.631 E.0019
G1 X180.206 Y106.679 E.00234
G1 X180.333 Y106.81 E.00357
G1 X180.389 Y107 E.00386
G1 X180.389 Y145 E.7409
G1 X180.369 Y145.096 E.0019
G1 X180.321 Y145.206 E.00234
G1 X180.19 Y145.333 E.00357
G1 X180 Y145.389 E.00386
G1 X79.033 Y145.389 E1.96861
; WIPE_START
G1 X78.908 Y145.371 E-.04775
G1 X78.725 Y145.275 E-.07874
G1 X77.546 Y144.096 E-.63351
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X77.559 Y142.543 Z.5 F30000
G1 X77.836 Y108.836
G1 Z.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.49999
G1 F900
M204 S500
G1 X178.164 Y108.836 E1.95612
G1 X178.164 Y126 E.33466
G1 X178.164 Y143.164 E.33466
G1 X79.76 Y143.164 E1.91859
G1 X77.836 Y141.24 E.05307
G1 X77.836 Y108.896 E.63062
M204 S6000
G1 X77.357 Y108.357 F30000
G1 F900
M204 S500
G1 X178.643 Y108.357 E1.97478
G1 X178.643 Y126 E.34399
G1 X178.643 Y143.643 E.34399
G1 X79.562 Y143.643 E1.93179
G1 X77.357 Y141.438 E.0608
G1 X77.357 Y108.417 E.64381
M204 S6000
G1 X76.879 Y107.879 F30000
G1 F900
M204 S500
G1 X179.121 Y107.879 E1.99344
G1 X179.121 Y126 E.35332
G1 X179.121 Y144.121 E.35332
G1 X79.364 Y144.121 E1.94498
G1 X76.879 Y141.636 E.06853
G1 X76.879 Y107.939 E.657
M204 S6000
G1 X76.4 Y107.4 F30000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X179.6 Y107.4 E2.0121
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

G1 X179.6 Y126 E.36265
G1 X179.6 Y144.6 E.36265
G1 X79.166 Y144.6 E1.95817
G1 X76.4 Y141.834 E.07626
G1 X76.4 Y107.46 E.6702
G1 E-.8 F1800
M204 S6000
M73 P18 R53
G1 X84.032 Y107.579 Z.5 F30000
G1 X177.004 Y109.027 Z.5
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5007
G1 F900
M204 S500
G1 X177.758 Y109.78 E.02081
G1 X177.758 Y110.458 E.01323
G1 X176.542 Y109.242 E.03358
G1 X175.864 Y109.242 E.01323
G1 X177.758 Y111.136 E.05229
G1 X177.758 Y111.814 E.01323
G1 X175.186 Y109.242 E.07101
G1 X174.509 Y109.242 E.01323
G1 X177.758 Y112.491 E.08972
G1 X177.758 Y113.169 E.01323
G1 X173.831 Y109.242 E.10844
G1 X173.153 Y109.242 E.01323
G1 X177.758 Y113.847 E.12715
G1 X177.758 Y114.525 E.01323
G1 X172.475 Y109.242 E.14587
M73 P18 R52
G1 X171.798 Y109.242 E.01323
G1 X177.758 Y115.202 E.16458
G1 X177.758 Y115.88 E.01323
G1 X171.12 Y109.242 E.1833
G1 X170.442 Y109.242 E.01323
G1 X177.758 Y116.558 E.20201
G1 X177.758 Y117.236 E.01323
G1 X169.764 Y109.242 E.22073
G1 X169.087 Y109.242 E.01323
G1 X177.758 Y117.913 E.23944
G1 X177.758 Y118.591 E.01323
G1 X168.409 Y109.242 E.25816
G1 X167.731 Y109.242 E.01323
G1 X177.758 Y119.269 E.27688
G1 X177.758 Y119.947 E.01323
G1 X167.053 Y109.242 E.29559
G1 X166.376 Y109.242 E.01323
G1 X177.758 Y120.624 E.31431
G1 X177.758 Y121.302 E.01323
G1 X165.698 Y109.242 E.33302
G1 X165.02 Y109.242 E.01323
G1 X177.758 Y121.98 E.35174
G1 X177.758 Y122.658 E.01323
G1 X164.342 Y109.242 E.37045
G1 X163.665 Y109.242 E.01323
G1 X177.758 Y123.335 E.38917
G1 X177.758 Y124.013 E.01323
G1 X162.987 Y109.242 E.40788
G1 X162.309 Y109.242 E.01323
G1 X177.758 Y124.691 E.4266
G1 X177.758 Y125.369 E.01323
G1 X161.631 Y109.242 E.44531
G1 X160.954 Y109.242 E.01323
G1 X177.758 Y126.046 E.46403
G1 X177.758 Y126.724 E.01323
G1 X160.276 Y109.242 E.48274
G1 X159.598 Y109.242 E.01323
M73 P19 R52
G1 X177.758 Y127.402 E.50146
G1 X177.758 Y128.08 E.01323
G1 X158.92 Y109.242 E.52017
G1 X158.243 Y109.242 E.01323
G1 X177.758 Y128.757 E.53889
G1 X177.758 Y129.435 E.01323
G1 X157.565 Y109.242 E.5576
G1 X156.887 Y109.242 E.01323
G1 X177.758 Y130.113 E.57632
G1 X177.758 Y130.791 E.01323
G1 X156.209 Y109.242 E.59503
G1 X155.532 Y109.242 E.01323
G1 X177.758 Y131.468 E.61375
G1 X177.758 Y132.146 E.01323
G1 X154.854 Y109.242 E.63247
G1 X154.176 Y109.242 E.01323
G1 X177.758 Y132.824 E.65118
G1 X177.758 Y133.502 E.01323
G1 X153.498 Y109.242 E.6699
G1 X152.821 Y109.242 E.01323
G1 X177.758 Y134.179 E.68861
M73 P19 R51
G1 X177.758 Y134.857 E.01323
G1 X152.143 Y109.242 E.70733
M73 P20 R51
G1 X151.465 Y109.242 E.01323
G1 X177.758 Y135.535 E.72604
G1 X177.758 Y136.213 E.01323
G1 X150.787 Y109.242 E.74476
G1 X150.11 Y109.242 E.01323
G1 X177.758 Y136.89 E.76347
G1 X177.758 Y137.568 E.01323
G1 X149.432 Y109.242 E.78219
G1 X148.754 Y109.242 E.01323
G1 X177.758 Y138.246 E.8009
G1 X177.758 Y138.924 E.01323
G1 X148.076 Y109.242 E.81962
G1 X147.399 Y109.242 E.01323
G1 X177.758 Y139.601 E.83833
G1 X177.758 Y140.279 E.01323
G1 X146.721 Y109.242 E.85705
G1 X146.043 Y109.242 E.01323
G1 X177.758 Y140.957 E.87576
G1 X177.758 Y141.635 E.01323
G1 X145.365 Y109.242 E.89448
G1 X144.688 Y109.242 E.01323
G1 X177.758 Y142.312 E.91319
G1 X177.758 Y142.758 E.0087
G1 X177.525 Y142.758 E.00454
G1 X144.01 Y109.242 E.92549
G1 X143.332 Y109.242 E.01323
G1 X176.847 Y142.758 E.92549
G1 X176.17 Y142.758 E.01323
G1 X142.654 Y109.242 E.92549
G1 X141.977 Y109.242 E.01323
G1 X175.492 Y142.758 E.92549
M73 P21 R51
G1 X174.814 Y142.758 E.01323
G1 X141.299 Y109.242 E.92549
G1 X140.621 Y109.242 E.01323
G1 X174.136 Y142.758 E.92549
G1 X173.459 Y142.758 E.01323
G1 X139.943 Y109.242 E.92549
G1 X139.266 Y109.242 E.01323
G1 X172.781 Y142.758 E.92549
G1 X172.103 Y142.758 E.01323
G1 X138.588 Y109.242 E.92549
G1 X137.91 Y109.242 E.01323
G1 X171.426 Y142.758 E.92549
G1 X170.748 Y142.758 E.01323
G1 X137.232 Y109.242 E.92549
G1 X136.555 Y109.242 E.01323
G1 X170.07 Y142.758 E.92549
G1 X169.392 Y142.758 E.01323
G1 X135.877 Y109.242 E.92549
G1 X135.199 Y109.242 E.01323
G1 X168.715 Y142.758 E.92549
G1 X168.037 Y142.758 E.01323
G1 X134.521 Y109.242 E.92549
G1 X133.844 Y109.242 E.01323
G1 X167.359 Y142.758 E.92549
G1 X166.681 Y142.758 E.01323
G1 X133.166 Y109.242 E.92549
G1 X132.488 Y109.242 E.01323
G1 X166.004 Y142.758 E.92549
G1 X165.326 Y142.758 E.01323
G1 X131.81 Y109.242 E.92549
G1 X131.133 Y109.242 E.01323
G1 X164.648 Y142.758 E.92549
M73 P21 R50
G1 X163.97 Y142.758 E.01323
G1 X130.455 Y109.242 E.92549
G1 X129.777 Y109.242 E.01323
G1 X163.293 Y142.758 E.92549
G1 X162.615 Y142.758 E.01323
G1 X129.099 Y109.242 E.92549
G1 X128.422 Y109.242 E.01323
G1 X161.937 Y142.758 E.92549
G1 X161.259 Y142.758 E.01323
G1 X127.744 Y109.242 E.92549
G1 X127.066 Y109.242 E.01323
G1 X160.582 Y142.758 E.92549
G1 X159.904 Y142.758 E.01323
G1 X126.388 Y109.242 E.92549
G1 X125.711 Y109.242 E.01323
G1 X159.226 Y142.758 E.92549
G1 X158.548 Y142.758 E.01323
G1 X125.033 Y109.242 E.92549
G1 X124.355 Y109.242 E.01323
G1 X157.871 Y142.758 E.92549
G1 X157.193 Y142.758 E.01323
G1 X123.677 Y109.242 E.92549
G1 X123 Y109.242 E.01323
G1 X156.515 Y142.758 E.92549
G1 X155.837 Y142.758 E.01323
G1 X122.322 Y109.242 E.92549
G1 X121.644 Y109.242 E.01323
G1 X155.16 Y142.758 E.92549
M73 P22 R50
G1 X154.482 Y142.758 E.01323
G1 X120.966 Y109.242 E.92549
G1 X120.289 Y109.242 E.01323
G1 X153.804 Y142.758 E.92549
G1 X153.126 Y142.758 E.01323
G1 X119.611 Y109.242 E.92549
G1 X118.933 Y109.242 E.01323
G1 X152.449 Y142.758 E.92549
G1 X151.771 Y142.758 E.01323
G1 X118.255 Y109.242 E.92549
G1 X117.578 Y109.242 E.01323
G1 X151.093 Y142.758 E.92549
G1 X150.415 Y142.758 E.01323
G1 X116.9 Y109.242 E.92549
G1 X116.222 Y109.242 E.01323
G1 X149.738 Y142.758 E.92549
G1 X149.06 Y142.758 E.01323
G1 X115.544 Y109.242 E.92549
G1 X114.867 Y109.242 E.01323
G1 X148.382 Y142.758 E.92549
G1 X147.704 Y142.758 E.01323
G1 X114.189 Y109.242 E.92549
G1 X113.511 Y109.242 E.01323
G1 X147.027 Y142.758 E.92549
G1 X146.349 Y142.758 E.01323
G1 X112.833 Y109.242 E.92549
M73 P22 R49
G1 X112.156 Y109.242 E.01323
G1 X145.671 Y142.758 E.92549
M73 P23 R49
G1 X144.993 Y142.758 E.01323
G1 X111.478 Y109.242 E.92549
G1 X110.8 Y109.242 E.01323
G1 X144.316 Y142.758 E.92549
G1 X143.638 Y142.758 E.01323
G1 X110.122 Y109.242 E.92549
G1 X109.445 Y109.242 E.01323
G1 X142.96 Y142.758 E.92549
G1 X142.282 Y142.758 E.01323
G1 X108.767 Y109.242 E.92549
G1 X108.089 Y109.242 E.01323
G1 X141.605 Y142.758 E.92549
G1 X140.927 Y142.758 E.01323
G1 X107.411 Y109.242 E.92549
G1 X106.734 Y109.242 E.01323
G1 X140.249 Y142.758 E.92549
G1 X139.571 Y142.758 E.01323
G1 X106.056 Y109.242 E.92549
G1 X105.378 Y109.242 E.01323
G1 X138.894 Y142.758 E.92549
G1 X138.216 Y142.758 E.01323
G1 X104.7 Y109.242 E.92549
G1 X104.023 Y109.242 E.01323
G1 X137.538 Y142.758 E.92549
G1 X136.86 Y142.758 E.01323
M73 P24 R49
G1 X103.345 Y109.242 E.92549
G1 X102.667 Y109.242 E.01323
G1 X136.183 Y142.758 E.92549
G1 X135.505 Y142.758 E.01323
G1 X101.99 Y109.242 E.92549
G1 X101.312 Y109.242 E.01323
G1 X134.827 Y142.758 E.92549
G1 X134.149 Y142.758 E.01323
G1 X100.634 Y109.242 E.92549
G1 X99.956 Y109.242 E.01323
G1 X133.472 Y142.758 E.92549
G1 X132.794 Y142.758 E.01323
M73 P24 R48
G1 X99.279 Y109.242 E.92549
G1 X98.601 Y109.242 E.01323
G1 X132.116 Y142.758 E.92549
G1 X131.438 Y142.758 E.01323
G1 X97.923 Y109.242 E.92549
G1 X97.245 Y109.242 E.01323
G1 X130.761 Y142.758 E.92549
G1 X130.083 Y142.758 E.01323
G1 X96.568 Y109.242 E.92549
G1 X95.89 Y109.242 E.01323
G1 X129.405 Y142.758 E.92549
G1 X128.727 Y142.758 E.01323
M73 P25 R48
G1 X95.212 Y109.242 E.92549
G1 X94.534 Y109.242 E.01323
G1 X128.05 Y142.758 E.92549
G1 X127.372 Y142.758 E.01323
G1 X93.857 Y109.242 E.92549
G1 X93.179 Y109.242 E.01323
G1 X126.694 Y142.758 E.92549
G1 X126.016 Y142.758 E.01323
G1 X92.501 Y109.242 E.92549
G1 X91.823 Y109.242 E.01323
G1 X125.339 Y142.758 E.92549
G1 X124.661 Y142.758 E.01323
G1 X91.146 Y109.242 E.92549
G1 X90.468 Y109.242 E.01323
G1 X123.983 Y142.758 E.92549
G1 X123.305 Y142.758 E.01323
G1 X89.79 Y109.242 E.92549
G1 X89.112 Y109.242 E.01323
G1 X122.628 Y142.758 E.92549
G1 X121.95 Y142.758 E.01323
G1 X88.435 Y109.242 E.92549
G1 X87.757 Y109.242 E.01323
G1 X121.272 Y142.758 E.92549
G1 X120.594 Y142.758 E.01323
M73 P26 R47
G1 X87.079 Y109.242 E.92549
G1 X86.401 Y109.242 E.01323
G1 X119.917 Y142.758 E.92549
G1 X119.239 Y142.758 E.01323
G1 X85.724 Y109.242 E.92549
G1 X85.046 Y109.242 E.01323
G1 X118.561 Y142.758 E.92549
G1 X117.883 Y142.758 E.01323
G1 X84.368 Y109.242 E.92549
G1 X83.69 Y109.242 E.01323
G1 X117.206 Y142.758 E.92549
G1 X116.528 Y142.758 E.01323
G1 X83.013 Y109.242 E.92549
G1 X82.335 Y109.242 E.01323
G1 X115.85 Y142.758 E.92549
G1 X115.172 Y142.758 E.01323
G1 X81.657 Y109.242 E.92549
G1 X80.979 Y109.242 E.01323
G1 X114.495 Y142.758 E.92549
G1 X113.817 Y142.758 E.01323
G1 X80.302 Y109.242 E.92549
G1 X79.624 Y109.242 E.01323
G1 X113.139 Y142.758 E.92549
G1 X112.461 Y142.758 E.01323
G1 X78.946 Y109.242 E.92549
G1 X78.268 Y109.242 E.01323
M73 P27 R47
G1 X111.784 Y142.758 E.92549
G1 X111.106 Y142.758 E.01323
G1 X78.242 Y109.894 E.90749
G1 X78.242 Y110.572 E.01323
G1 X110.428 Y142.758 E.88878
G1 X109.75 Y142.758 E.01323
G1 X78.242 Y111.25 E.87006
G1 X78.242 Y111.927 E.01323
G1 X109.073 Y142.758 E.85135
G1 X108.395 Y142.758 E.01323
G1 X78.242 Y112.605 E.83263
G1 X78.242 Y113.283 E.01323
M73 P27 R46
G1 X107.717 Y142.758 E.81392
G1 X107.039 Y142.758 E.01323
G1 X78.242 Y113.961 E.7952
G1 X78.242 Y114.638 E.01323
G1 X106.362 Y142.758 E.77649
G1 X105.684 Y142.758 E.01323
G1 X78.242 Y115.316 E.75777
G1 X78.242 Y115.994 E.01323
G1 X105.006 Y142.758 E.73906
G1 X104.328 Y142.758 E.01323
G1 X78.242 Y116.672 E.72034
G1 X78.242 Y117.349 E.01323
M73 P28 R46
G1 X103.651 Y142.758 E.70163
G1 X102.973 Y142.758 E.01323
G1 X78.242 Y118.027 E.68291
G1 X78.242 Y118.705 E.01323
G1 X102.295 Y142.758 E.6642
G1 X101.617 Y142.758 E.01323
G1 X78.242 Y119.383 E.64548
G1 X78.242 Y120.06 E.01323
G1 X100.94 Y142.758 E.62677
G1 X100.262 Y142.758 E.01323
G1 X78.242 Y120.738 E.60805
G1 X78.242 Y121.416 E.01323
G1 X99.584 Y142.758 E.58933
G1 X98.906 Y142.758 E.01323
G1 X78.242 Y122.094 E.57062
G1 X78.242 Y122.771 E.01323
G1 X98.229 Y142.758 E.5519
G1 X97.551 Y142.758 E.01323
G1 X78.242 Y123.449 E.53319
G1 X78.242 Y124.127 E.01323
G1 X96.873 Y142.758 E.51447
G1 X96.196 Y142.758 E.01323
G1 X78.242 Y124.804 E.49576
G1 X78.242 Y125.482 E.01323
M73 P29 R46
G1 X95.518 Y142.758 E.47704
G1 X94.84 Y142.758 E.01323
M73 P29 R45
G1 X78.242 Y126.16 E.45833
G1 X78.242 Y126.838 E.01323
G1 X94.162 Y142.758 E.43961
G1 X93.485 Y142.758 E.01323
G1 X78.242 Y127.515 E.4209
G1 X78.242 Y128.193 E.01323
G1 X92.807 Y142.758 E.40218
G1 X92.129 Y142.758 E.01323
G1 X78.242 Y128.871 E.38347
G1 X78.242 Y129.549 E.01323
G1 X91.451 Y142.758 E.36475
G1 X90.774 Y142.758 E.01323
G1 X78.242 Y130.226 E.34604
G1 X78.242 Y130.904 E.01323
G1 X90.096 Y142.758 E.32732
G1 X89.418 Y142.758 E.01323
G1 X78.242 Y131.582 E.30861
G1 X78.242 Y132.26 E.01323
G1 X88.74 Y142.758 E.28989
G1 X88.063 Y142.758 E.01323
G1 X78.242 Y132.937 E.27117
G1 X78.242 Y133.615 E.01323
M73 P30 R45
G1 X87.385 Y142.758 E.25246
G1 X86.707 Y142.758 E.01323
G1 X78.242 Y134.293 E.23374
G1 X78.242 Y134.971 E.01323
G1 X86.029 Y142.758 E.21503
G1 X85.352 Y142.758 E.01323
G1 X78.242 Y135.648 E.19631
G1 X78.242 Y136.326 E.01323
G1 X84.674 Y142.758 E.1776
G1 X83.996 Y142.758 E.01323
G1 X78.242 Y137.004 E.15888
G1 X78.242 Y137.682 E.01323
G1 X83.318 Y142.758 E.14017
G1 X82.641 Y142.758 E.01323
G1 X78.242 Y138.359 E.12145
M73 P30 R44
G1 X78.242 Y139.037 E.01323
G1 X81.963 Y142.758 E.10274
G1 X81.285 Y142.758 E.01323
G1 X78.242 Y139.715 E.08402
G1 X78.242 Y140.393 E.01323
G1 X80.607 Y142.758 E.06531
G1 X79.93 Y142.758 E.01323
G1 X78.027 Y140.855 E.05254
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F900
M73 P31 R44
G1 X79.441 Y142.269 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/25
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
M106 P2 S178
; open powerlost recovery
M1003 S1
M204 S10000
G17
G3 Z.5 I-1.126 J-.462 P1  F30000
G1 X78.814 Y143.798 Z.5
G1 X51.016 Y211.534
G1 Z.2
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #3
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
G3  X52.017 Y190.508   I-8.876 J-4.065 E0.0558
G2  X51.516 Y192.596   I4.225 J2.118 E0.0431
G2  X51.520 Y205.153   I319.311 J6.188 E0.2498
G2  X53.348 Y208.841   I5.574 J-0.466 E0.0839
G3  X52.998 Y211.052   I-1.728 J0.860 E0.0475
G1  X51.516 Y212.534   E0.0417
M73 P32 R44
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625
G3  X46.509 Y213.309   I-0.130 J-3.164 E0.0597
G2  X43.954 Y212.534   I-2.561 J3.843 E0.0539
G2  X31.397 Y212.538   I-6.188 J319.311 E0.2498
G2  X27.709 Y214.366   I0.466 J5.574 E0.0839
G3  X25.498 Y214.016   I-0.860 J-1.728 E0.0475
M73 P32 R43
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
M204 S1000
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
M204 S1000
M73 P33 R43
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
M204 S1000
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
M204 S1000
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
M204 S1000
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
G1 F900
M204 S1000
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
G3 Z.6 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X76.643 Y110.685
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.65 Y109.459 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X78.28 Y108.83 E.01447
G1 X78.844 Y108.83 E.00918
G1 X77.83 Y109.844 E.02333
G1 X77.83 Y110.409 E.00918
G1 X79.409 Y108.83 E.03631
G1 X79.973 Y108.83 E.00918
G1 X77.83 Y110.973 E.04929
G1 X77.83 Y111.538 E.00918
G1 X80.538 Y108.83 E.06228
G1 X81.102 Y108.83 E.00918
G1 X77.83 Y112.102 E.07526
G1 X77.83 Y112.667 E.00918
G1 X81.667 Y108.83 E.08824
G1 X82.231 Y108.83 E.00918
G1 X77.83 Y113.231 E.10123
G1 X77.83 Y113.796 E.00918
G1 X82.796 Y108.83 E.11421
G1 X83.36 Y108.83 E.00918
G1 X77.83 Y114.36 E.12719
G1 X77.83 Y114.925 E.00918
G1 X83.925 Y108.83 E.14017
G1 X84.489 Y108.83 E.00918
G1 X77.83 Y115.489 E.15316
G1 X77.83 Y116.054 E.00918
G1 X85.054 Y108.83 E.16614
G1 X85.618 Y108.83 E.00918
G1 X77.83 Y116.618 E.17912
G1 X77.83 Y117.182 E.00918
G1 X86.182 Y108.83 E.1921
G1 X86.747 Y108.83 E.00918
G1 X77.83 Y117.747 E.20509
G1 X77.83 Y118.311 E.00918
G1 X87.311 Y108.83 E.21807
G1 X87.876 Y108.83 E.00918
G1 X77.83 Y118.876 E.23105
G1 X77.83 Y119.44 E.00918
G1 X88.44 Y108.83 E.24403
G1 X89.005 Y108.83 E.00918
G1 X77.83 Y120.005 E.25702
G1 X77.83 Y120.569 E.00918
G1 X89.569 Y108.83 E.27
G1 X90.134 Y108.83 E.00918
G1 X77.83 Y121.134 E.28298
G1 X77.83 Y121.698 E.00918
G1 X90.698 Y108.83 E.29596
G1 X91.263 Y108.83 E.00918
G1 X77.83 Y122.263 E.30895
G1 X77.83 Y122.827 E.00918
G1 X91.827 Y108.83 E.32193
G1 X92.392 Y108.83 E.00918
G1 X77.83 Y123.392 E.33491
G1 X77.83 Y123.956 E.00918
G1 X92.956 Y108.83 E.3479
G1 X93.521 Y108.83 E.00918
G1 X77.83 Y124.521 E.36088
G1 X77.83 Y125.085 E.00918
G1 X94.085 Y108.83 E.37386
G1 X94.65 Y108.83 E.00918
G1 X77.83 Y125.65 E.38684
G1 X77.83 Y126.214 E.00918
G1 X95.214 Y108.83 E.39983
G1 X95.779 Y108.83 E.00918
G1 X77.83 Y126.779 E.41281
G1 X77.83 Y127.343 E.00918
G1 X96.343 Y108.83 E.42579
G1 X96.908 Y108.83 E.00918
G1 X77.83 Y127.908 E.43877
G1 X77.83 Y128.472 E.00918
G1 X97.472 Y108.83 E.45176
G1 X98.037 Y108.83 E.00918
G1 X77.83 Y129.037 E.46474
G1 X77.83 Y129.601 E.00918
G1 X98.601 Y108.83 E.47772
M73 P33 R42
G1 X99.166 Y108.83 E.00918
G1 X77.83 Y130.166 E.4907
G1 X77.83 Y130.73 E.00918
G1 X99.73 Y108.83 E.50369
G1 X100.295 Y108.83 E.00918
G1 X77.83 Y131.295 E.51667
G1 X77.83 Y131.859 E.00918
G1 X100.859 Y108.83 E.52965
G1 X101.424 Y108.83 E.00918
G1 X77.83 Y132.424 E.54263
G1 X77.83 Y132.988 E.00918
G1 X101.988 Y108.83 E.55562
G1 X102.552 Y108.83 E.00918
G1 X77.83 Y133.552 E.5686
G1 X77.83 Y134.117 E.00918
G1 X103.117 Y108.83 E.58158
G1 X103.681 Y108.83 E.00918
G1 X77.83 Y134.681 E.59457
G1 X77.83 Y135.246 E.00918
G1 X104.246 Y108.83 E.60755
G1 X104.81 Y108.83 E.00918
G1 X77.83 Y135.81 E.62053
G1 X77.83 Y136.375 E.00918
G1 X105.375 Y108.83 E.63351
G1 X105.939 Y108.83 E.00918
G1 X77.83 Y136.939 E.6465
G1 X77.83 Y137.504 E.00918
G1 X106.504 Y108.83 E.65948
G1 X107.068 Y108.83 E.00918
G1 X77.83 Y138.068 E.67246
G1 X77.83 Y138.633 E.00918
G1 X107.633 Y108.83 E.68544
G1 X108.197 Y108.83 E.00918
G1 X77.83 Y139.197 E.69843
G1 X77.83 Y139.762 E.00918
G1 X108.762 Y108.83 E.71141
G1 X109.326 Y108.83 E.00918
G1 X77.83 Y140.326 E.72439
G1 X77.83 Y140.891 E.00918
G1 X109.891 Y108.83 E.73737
G1 X110.455 Y108.83 E.00918
G1 X77.936 Y141.349 E.7479
G1 X78.219 Y141.631 E.00649
G1 X111.02 Y108.83 E.7544
G1 X111.584 Y108.83 E.00918
G1 X78.501 Y141.913 E.76089
G1 X78.783 Y142.195 E.00649
G1 X112.149 Y108.83 E.76738
G1 X112.713 Y108.83 E.00918
G1 X79.065 Y142.478 E.77387
G1 X79.348 Y142.76 E.00649
G1 X113.278 Y108.83 E.78036
G1 X113.842 Y108.83 E.00918
G1 X79.63 Y143.042 E.78685
G1 X79.758 Y143.17 E.00295
M73 P34 R42
G1 X80.066 Y143.17 E.00501
G1 X114.407 Y108.83 E.7898
G1 X114.971 Y108.83 E.00918
G1 X80.631 Y143.17 E.7898
G1 X81.195 Y143.17 E.00918
G1 X115.536 Y108.83 E.7898
G1 X116.1 Y108.83 E.00918
G1 X81.76 Y143.17 E.7898
G1 X82.324 Y143.17 E.00918
G1 X116.665 Y108.83 E.7898
G1 X117.229 Y108.83 E.00918
G1 X82.889 Y143.17 E.7898
G1 X83.453 Y143.17 E.00918
G1 X117.794 Y108.83 E.7898
G1 X118.358 Y108.83 E.00918
G1 X84.018 Y143.17 E.7898
G1 X84.582 Y143.17 E.00918
G1 X118.923 Y108.83 E.7898
G1 X119.487 Y108.83 E.00918
G1 X85.147 Y143.17 E.7898
G1 X85.711 Y143.17 E.00918
G1 X120.051 Y108.83 E.7898
G1 X120.616 Y108.83 E.00918
G1 X86.276 Y143.17 E.7898
G1 X86.84 Y143.17 E.00918
G1 X121.18 Y108.83 E.7898
G1 X121.745 Y108.83 E.00918
G1 X87.405 Y143.17 E.7898
G1 X87.969 Y143.17 E.00918
G1 X122.309 Y108.83 E.7898
G1 X122.874 Y108.83 E.00918
G1 X88.534 Y143.17 E.7898
G1 X89.098 Y143.17 E.00918
G1 X123.438 Y108.83 E.7898
G1 X124.003 Y108.83 E.00918
G1 X89.662 Y143.17 E.7898
G1 X90.227 Y143.17 E.00918
G1 X124.567 Y108.83 E.7898
G1 X125.132 Y108.83 E.00918
G1 X90.791 Y143.17 E.7898
G1 X91.356 Y143.17 E.00918
G1 X125.696 Y108.83 E.7898
G1 X126.261 Y108.83 E.00918
G1 X91.92 Y143.17 E.7898
G1 X92.485 Y143.17 E.00918
G1 X126.825 Y108.83 E.7898
G1 X127.39 Y108.83 E.00918
G1 X93.049 Y143.17 E.7898
G1 X93.614 Y143.17 E.00918
G1 X127.954 Y108.83 E.7898
G1 X128.519 Y108.83 E.00918
G1 X94.178 Y143.17 E.7898
G1 X94.743 Y143.17 E.00918
G1 X129.083 Y108.83 E.7898
G1 X129.648 Y108.83 E.00918
G1 X95.307 Y143.17 E.7898
G1 X95.872 Y143.17 E.00918
G1 X130.212 Y108.83 E.7898
G1 X130.777 Y108.83 E.00918
G1 X96.436 Y143.17 E.7898
G1 X97.001 Y143.17 E.00918
G1 X131.341 Y108.83 E.7898
G1 X131.906 Y108.83 E.00918
G1 X97.565 Y143.17 E.7898
G1 X98.13 Y143.17 E.00918
G1 X132.47 Y108.83 E.7898
G1 X133.035 Y108.83 E.00918
G1 X98.694 Y143.17 E.7898
G1 X99.259 Y143.17 E.00918
G1 X133.599 Y108.83 E.7898
G1 X134.164 Y108.83 E.00918
G1 X99.823 Y143.17 E.7898
G1 X100.388 Y143.17 E.00918
G1 X134.728 Y108.83 E.7898
G1 X135.293 Y108.83 E.00918
G1 X100.952 Y143.17 E.7898
G1 X101.517 Y143.17 E.00918
G1 X135.857 Y108.83 E.7898
G1 X136.421 Y108.83 E.00918
G1 X102.081 Y143.17 E.7898
G1 X102.646 Y143.17 E.00918
G1 X136.986 Y108.83 E.7898
G1 X137.55 Y108.83 E.00918
G1 X103.21 Y143.17 E.7898
G1 X103.775 Y143.17 E.00918
G1 X138.115 Y108.83 E.7898
G1 X138.679 Y108.83 E.00918
G1 X104.339 Y143.17 E.7898
G1 X104.904 Y143.17 E.00918
G1 X139.244 Y108.83 E.7898
G1 X139.808 Y108.83 E.00918
G1 X105.468 Y143.17 E.7898
G1 X106.033 Y143.17 E.00918
G1 X140.373 Y108.83 E.7898
G1 X140.937 Y108.83 E.00918
G1 X106.597 Y143.17 E.7898
G1 X107.161 Y143.17 E.00918
G1 X141.502 Y108.83 E.7898
G1 X142.066 Y108.83 E.00918
G1 X107.726 Y143.17 E.7898
G1 X108.29 Y143.17 E.00918
G1 X142.631 Y108.83 E.7898
G1 X143.195 Y108.83 E.00918
G1 X108.855 Y143.17 E.7898
G1 X109.419 Y143.17 E.00918
G1 X143.76 Y108.83 E.7898
G1 X144.324 Y108.83 E.00918
G1 X109.984 Y143.17 E.7898
G1 X110.548 Y143.17 E.00918
G1 X144.889 Y108.83 E.7898
G1 X145.453 Y108.83 E.00918
G1 X111.113 Y143.17 E.7898
G1 X111.677 Y143.17 E.00918
G1 X146.018 Y108.83 E.7898
G1 X146.582 Y108.83 E.00918
G1 X112.242 Y143.17 E.7898
G1 X112.806 Y143.17 E.00918
G1 X147.147 Y108.83 E.7898
G1 X147.711 Y108.83 E.00918
G1 X113.371 Y143.17 E.7898
G1 X113.935 Y143.17 E.00918
G1 X148.276 Y108.83 E.7898
G1 X148.84 Y108.83 E.00918
G1 X114.5 Y143.17 E.7898
G1 X115.064 Y143.17 E.00918
G1 X149.405 Y108.83 E.7898
G1 X149.969 Y108.83 E.00918
G1 X115.629 Y143.17 E.7898
G1 X116.193 Y143.17 E.00918
G1 X150.534 Y108.83 E.7898
G1 X151.098 Y108.83 E.00918
G1 X116.758 Y143.17 E.7898
G1 X117.322 Y143.17 E.00918
G1 X151.663 Y108.83 E.7898
G1 X152.227 Y108.83 E.00918
G1 X117.887 Y143.17 E.7898
G1 X118.451 Y143.17 E.00918
G1 X152.792 Y108.83 E.7898
G1 X153.356 Y108.83 E.00918
G1 X119.016 Y143.17 E.7898
G1 X119.58 Y143.17 E.00918
G1 X153.92 Y108.83 E.7898
G1 X154.485 Y108.83 E.00918
G1 X120.145 Y143.17 E.7898
G1 X120.709 Y143.17 E.00918
G1 X155.049 Y108.83 E.7898
G1 X155.614 Y108.83 E.00918
G1 X121.274 Y143.17 E.7898
G1 X121.838 Y143.17 E.00918
G1 X156.178 Y108.83 E.7898
G1 X156.743 Y108.83 E.00918
G1 X122.403 Y143.17 E.7898
G1 X122.967 Y143.17 E.00918
G1 X157.307 Y108.83 E.7898
G1 X157.872 Y108.83 E.00918
G1 X123.532 Y143.17 E.7898
G1 X124.096 Y143.17 E.00918
G1 X158.436 Y108.83 E.7898
G1 X159.001 Y108.83 E.00918
M73 P35 R42
G1 X124.66 Y143.17 E.7898
G1 X125.225 Y143.17 E.00918
G1 X159.565 Y108.83 E.7898
G1 X160.13 Y108.83 E.00918
G1 X125.789 Y143.17 E.7898
G1 X126.354 Y143.17 E.00918
G1 X160.694 Y108.83 E.7898
G1 X161.259 Y108.83 E.00918
G1 X126.918 Y143.17 E.7898
G1 X127.483 Y143.17 E.00918
G1 X161.823 Y108.83 E.7898
G1 X162.388 Y108.83 E.00918
G1 X128.047 Y143.17 E.7898
G1 X128.612 Y143.17 E.00918
G1 X162.952 Y108.83 E.7898
G1 X163.517 Y108.83 E.00918
G1 X129.176 Y143.17 E.7898
G1 X129.741 Y143.17 E.00918
G1 X164.081 Y108.83 E.7898
G1 X164.646 Y108.83 E.00918
G1 X130.305 Y143.17 E.7898
G1 X130.87 Y143.17 E.00918
G1 X165.21 Y108.83 E.7898
G1 X165.775 Y108.83 E.00918
G1 X131.434 Y143.17 E.7898
G1 X131.999 Y143.17 E.00918
G1 X166.339 Y108.83 E.7898
G1 X166.904 Y108.83 E.00918
G1 X132.563 Y143.17 E.7898
G1 X133.128 Y143.17 E.00918
G1 X167.468 Y108.83 E.7898
G1 X168.033 Y108.83 E.00918
M73 P35 R41
G1 X133.692 Y143.17 E.7898
G1 X134.257 Y143.17 E.00918
G1 X168.597 Y108.83 E.7898
G1 X169.162 Y108.83 E.00918
G1 X134.821 Y143.17 E.7898
G1 X135.386 Y143.17 E.00918
G1 X169.726 Y108.83 E.7898
G1 X170.291 Y108.83 E.00918
G1 X135.95 Y143.17 E.7898
G1 X136.515 Y143.17 E.00918
G1 X170.855 Y108.83 E.7898
G1 X171.419 Y108.83 E.00918
G1 X137.079 Y143.17 E.7898
G1 X137.644 Y143.17 E.00918
G1 X171.984 Y108.83 E.7898
G1 X172.548 Y108.83 E.00918
G1 X138.208 Y143.17 E.7898
G1 X138.773 Y143.17 E.00918
G1 X173.113 Y108.83 E.7898
G1 X173.677 Y108.83 E.00918
G1 X139.337 Y143.17 E.7898
G1 X139.902 Y143.17 E.00918
G1 X174.242 Y108.83 E.7898
G1 X174.806 Y108.83 E.00918
G1 X140.466 Y143.17 E.7898
G1 X141.03 Y143.17 E.00918
G1 X175.371 Y108.83 E.7898
G1 X175.935 Y108.83 E.00918
G1 X141.595 Y143.17 E.7898
G1 X142.159 Y143.17 E.00918
G1 X176.5 Y108.83 E.7898
G1 X177.064 Y108.83 E.00918
G1 X142.724 Y143.17 E.7898
G1 X143.288 Y143.17 E.00918
G1 X177.629 Y108.83 E.7898
G1 X178.17 Y108.83 E.0088
G1 X178.17 Y108.853 E.00038
G1 X143.853 Y143.17 E.78927
G1 X144.417 Y143.17 E.00918
G1 X178.17 Y109.417 E.77628
G1 X178.17 Y109.982 E.00918
G1 X144.982 Y143.17 E.7633
G1 X145.546 Y143.17 E.00918
G1 X178.17 Y110.546 E.75032
G1 X178.17 Y111.111 E.00918
G1 X146.111 Y143.17 E.73734
G1 X146.675 Y143.17 E.00918
G1 X178.17 Y111.675 E.72435
G1 X178.17 Y112.24 E.00918
G1 X147.24 Y143.17 E.71137
G1 X147.804 Y143.17 E.00918
G1 X178.17 Y112.804 E.69839
G1 X178.17 Y113.369 E.00918
G1 X148.369 Y143.17 E.68541
G1 X148.933 Y143.17 E.00918
G1 X178.17 Y113.933 E.67242
G1 X178.17 Y114.498 E.00918
G1 X149.498 Y143.17 E.65944
G1 X150.062 Y143.17 E.00918
G1 X178.17 Y115.062 E.64646
G1 X178.17 Y115.627 E.00918
G1 X150.627 Y143.17 E.63348
G1 X151.191 Y143.17 E.00918
G1 X178.17 Y116.191 E.62049
G1 X178.17 Y116.756 E.00918
G1 X151.756 Y143.17 E.60751
G1 X152.32 Y143.17 E.00918
G1 X178.17 Y117.32 E.59453
G1 X178.17 Y117.885 E.00918
G1 X152.885 Y143.17 E.58155
G1 X153.449 Y143.17 E.00918
G1 X178.17 Y118.449 E.56856
G1 X178.17 Y119.014 E.00918
G1 X154.014 Y143.17 E.55558
G1 X154.578 Y143.17 E.00918
G1 X178.17 Y119.578 E.5426
G1 X178.17 Y120.143 E.00918
G1 X155.143 Y143.17 E.52961
G1 X155.707 Y143.17 E.00918
G1 X178.17 Y120.707 E.51663
G1 X178.17 Y121.272 E.00918
G1 X156.272 Y143.17 E.50365
G1 X156.836 Y143.17 E.00918
G1 X178.17 Y121.836 E.49067
G1 X178.17 Y122.401 E.00918
G1 X157.401 Y143.17 E.47768
G1 X157.965 Y143.17 E.00918
G1 X178.17 Y122.965 E.4647
G1 X178.17 Y123.529 E.00918
G1 X158.529 Y143.17 E.45172
G1 X159.094 Y143.17 E.00918
G1 X178.17 Y124.094 E.43874
G1 X178.17 Y124.658 E.00918
G1 X159.658 Y143.17 E.42575
G1 X160.223 Y143.17 E.00918
G1 X178.17 Y125.223 E.41277
G1 X178.17 Y125.787 E.00918
G1 X160.787 Y143.17 E.39979
M73 P36 R41
G1 X161.352 Y143.17 E.00918
G1 X178.17 Y126.352 E.38681
G1 X178.17 Y126.916 E.00918
G1 X161.916 Y143.17 E.37382
G1 X162.481 Y143.17 E.00918
G1 X178.17 Y127.481 E.36084
G1 X178.17 Y128.045 E.00918
G1 X163.045 Y143.17 E.34786
G1 X163.61 Y143.17 E.00918
G1 X178.17 Y128.61 E.33488
G1 X178.17 Y129.174 E.00918
G1 X164.174 Y143.17 E.32189
G1 X164.739 Y143.17 E.00918
G1 X178.17 Y129.739 E.30891
G1 X178.17 Y130.303 E.00918
G1 X165.303 Y143.17 E.29593
G1 X165.868 Y143.17 E.00918
G1 X178.17 Y130.868 E.28294
G1 X178.17 Y131.432 E.00918
G1 X166.432 Y143.17 E.26996
G1 X166.997 Y143.17 E.00918
G1 X178.17 Y131.997 E.25698
G1 X178.17 Y132.561 E.00918
G1 X167.561 Y143.17 E.244
G1 X168.126 Y143.17 E.00918
G1 X178.17 Y133.126 E.23101
G1 X178.17 Y133.69 E.00918
G1 X168.69 Y143.17 E.21803
G1 X169.255 Y143.17 E.00918
G1 X178.17 Y134.255 E.20505
G1 X178.17 Y134.819 E.00918
G1 X169.819 Y143.17 E.19207
G1 X170.384 Y143.17 E.00918
G1 X178.17 Y135.384 E.17908
G1 X178.17 Y135.948 E.00918
G1 X170.948 Y143.17 E.1661
G1 X171.513 Y143.17 E.00918
G1 X178.17 Y136.513 E.15312
G1 X178.17 Y137.077 E.00918
G1 X172.077 Y143.17 E.14014
G1 X172.642 Y143.17 E.00918
G1 X178.17 Y137.642 E.12715
G1 X178.17 Y138.206 E.00918
G1 X173.206 Y143.17 E.11417
G1 X173.771 Y143.17 E.00918
G1 X178.17 Y138.771 E.10119
G1 X178.17 Y139.335 E.00918
G1 X174.335 Y143.17 E.08821
G1 X174.899 Y143.17 E.00918
G1 X178.17 Y139.9 E.07522
G1 X178.17 Y140.464 E.00918
G1 X175.464 Y143.17 E.06224
G1 X176.028 Y143.17 E.00918
G1 X178.17 Y141.028 E.04926
G1 X178.17 Y141.593 E.00918
G1 X176.593 Y143.17 E.03627
G1 X177.157 Y143.17 E.00918
G1 X178.17 Y142.157 E.02329
G1 X178.17 Y142.722 E.00918
G1 X177.543 Y143.35 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 0.3
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X178.17 Y142.722 E-.33727
G1 X178.17 Y142.157 E-.21451
G1 X177.783 Y142.545 E-.20822
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/25
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
M204 S10000
G17
G3 Z.6 I-.582 J-1.069 P1  F30000
G1 X174.453 Y144.357 Z.6
G1 X51.016 Y211.534
G1 Z.3
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #4
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
M204 S1000
G3  X53.967 Y186.180   I-16.301 J19.330 E0.0928
G3  X54.091 Y189.358   I-2.329 J1.683 E0.0671
M73 P36 R40
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
M204 S1000
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
M204 S1000
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
M204 S1000
G1 X51.169 Y181.994 E-.09969
G1 X50.933 Y181.808 E-.11397
G1 X50.684 Y181.641 E-.11402
G1 X50.422 Y181.495 E-.11398
G1 X50.15 Y181.369 E-.11398
G1 X49.868 Y181.265 E-.11402
M73 P37 R40
G1 X49.639 Y181.201 E-.09036
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.7 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X76.643 Y110.669
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.084 Y114.9 Z.7 F30000
G1 X77.65 Y141.061 Z.7
G1 Z.3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X79.76 Y143.17 E.0486
G1 X80.325 Y143.17 E.00921
G1 X77.83 Y140.675 E.05749
G1 X77.83 Y140.109 E.00921
G1 X80.891 Y143.17 E.07051
G1 X81.456 Y143.17 E.00921
G1 X77.83 Y139.544 E.08354
G1 X77.83 Y138.978 E.00921
G1 X82.022 Y143.17 E.09656
G1 X82.587 Y143.17 E.00921
G1 X77.83 Y138.413 E.10959
G1 X77.83 Y137.848 E.00921
G1 X83.152 Y143.17 E.12261
G1 X83.718 Y143.17 E.00921
G1 X77.83 Y137.282 E.13563
G1 X77.83 Y136.717 E.00921
G1 X84.283 Y143.17 E.14866
G1 X84.849 Y143.17 E.00921
G1 X77.83 Y136.151 E.16168
G1 X77.83 Y135.586 E.00921
G1 X85.414 Y143.17 E.17471
G1 X85.979 Y143.17 E.00921
G1 X77.83 Y135.021 E.18773
G1 X77.83 Y134.455 E.00921
G1 X86.545 Y143.17 E.20076
G1 X87.11 Y143.17 E.00921
G1 X77.83 Y133.89 E.21378
G1 X77.83 Y133.325 E.00921
G1 X87.675 Y143.17 E.2268
G1 X88.241 Y143.17 E.00921
G1 X77.83 Y132.759 E.23983
G1 X77.83 Y132.194 E.00921
G1 X88.806 Y143.17 E.25285
G1 X89.372 Y143.17 E.00921
G1 X77.83 Y131.628 E.26588
G1 X77.83 Y131.063 E.00921
G1 X89.937 Y143.17 E.2789
G1 X90.502 Y143.17 E.00921
G1 X77.83 Y130.498 E.29193
G1 X77.83 Y129.932 E.00921
G1 X91.068 Y143.17 E.30495
G1 X91.633 Y143.17 E.00921
G1 X77.83 Y129.367 E.31797
G1 X77.83 Y128.801 E.00921
G1 X92.199 Y143.17 E.331
G1 X92.764 Y143.17 E.00921
G1 X77.83 Y128.236 E.34402
G1 X77.83 Y127.671 E.00921
G1 X93.329 Y143.17 E.35705
G1 X93.895 Y143.17 E.00921
G1 X77.83 Y127.105 E.37007
G1 X77.83 Y126.54 E.00921
G1 X94.46 Y143.17 E.3831
G1 X95.025 Y143.17 E.00921
G1 X77.83 Y125.974 E.39612
G1 X77.83 Y125.409 E.00921
G1 X95.591 Y143.17 E.40914
G1 X96.156 Y143.17 E.00921
G1 X77.83 Y124.844 E.42217
G1 X77.83 Y124.278 E.00921
G1 X96.722 Y143.17 E.43519
G1 X97.287 Y143.17 E.00921
G1 X77.83 Y123.713 E.44822
G1 X77.83 Y123.148 E.00921
G1 X97.852 Y143.17 E.46124
G1 X98.418 Y143.17 E.00921
G1 X77.83 Y122.582 E.47427
G1 X77.83 Y122.017 E.00921
G1 X98.983 Y143.17 E.48729
G1 X99.549 Y143.17 E.00921
G1 X77.83 Y121.451 E.50031
G1 X77.83 Y120.886 E.00921
G1 X100.114 Y143.17 E.51334
G1 X100.679 Y143.17 E.00921
G1 X77.83 Y120.321 E.52636
G1 X77.83 Y119.755 E.00921
G1 X101.245 Y143.17 E.53939
G1 X101.81 Y143.17 E.00921
G1 X77.83 Y119.19 E.55241
G1 X77.83 Y118.624 E.00921
G1 X102.376 Y143.17 E.56544
G1 X102.941 Y143.17 E.00921
G1 X77.83 Y118.059 E.57846
G1 X77.83 Y117.494 E.00921
G1 X103.506 Y143.17 E.59148
G1 X104.072 Y143.17 E.00921
G1 X77.83 Y116.928 E.60451
G1 X77.83 Y116.363 E.00921
G1 X104.637 Y143.17 E.61753
G1 X105.202 Y143.17 E.00921
G1 X77.83 Y115.798 E.63056
G1 X77.83 Y115.232 E.00921
G1 X105.768 Y143.17 E.64358
G1 X106.333 Y143.17 E.00921
G1 X77.83 Y114.667 E.65661
G1 X77.83 Y114.101 E.00921
G1 X106.899 Y143.17 E.66963
G1 X107.464 Y143.17 E.00921
G1 X77.83 Y113.536 E.68265
G1 X77.83 Y112.971 E.00921
G1 X108.029 Y143.17 E.69568
G1 X108.595 Y143.17 E.00921
G1 X77.83 Y112.405 E.7087
G1 X77.83 Y111.84 E.00921
G1 X109.16 Y143.17 E.72173
G1 X109.726 Y143.17 E.00921
G1 X77.83 Y111.274 E.73475
G1 X77.83 Y110.709 E.00921
G1 X110.291 Y143.17 E.74778
G1 X110.856 Y143.17 E.00921
G1 X77.83 Y110.144 E.7608
G1 X77.83 Y109.578 E.00921
G1 X111.422 Y143.17 E.77382
G1 X111.987 Y143.17 E.00921
G1 X77.83 Y109.013 E.78685
G1 X77.83 Y108.83 E.00298
G1 X78.212 Y108.83 E.00623
G1 X112.553 Y143.17 E.79106
G1 X113.118 Y143.17 E.00921
G1 X78.778 Y108.83 E.79106
G1 X79.343 Y108.83 E.00921
G1 X113.683 Y143.17 E.79106
G1 X114.249 Y143.17 E.00921
G1 X79.908 Y108.83 E.79106
G1 X80.474 Y108.83 E.00921
G1 X114.814 Y143.17 E.79106
G1 X115.379 Y143.17 E.00921
G1 X81.039 Y108.83 E.79106
G1 X81.605 Y108.83 E.00921
G1 X115.945 Y143.17 E.79106
G1 X116.51 Y143.17 E.00921
G1 X82.17 Y108.83 E.79106
G1 X82.735 Y108.83 E.00921
G1 X117.076 Y143.17 E.79106
G1 X117.641 Y143.17 E.00921
G1 X83.301 Y108.83 E.79106
G1 X83.866 Y108.83 E.00921
G1 X118.206 Y143.17 E.79106
G1 X118.772 Y143.17 E.00921
G1 X84.431 Y108.83 E.79106
G1 X84.997 Y108.83 E.00921
G1 X119.337 Y143.17 E.79106
G1 X119.903 Y143.17 E.00921
G1 X85.562 Y108.83 E.79106
G1 X86.128 Y108.83 E.00921
G1 X120.468 Y143.17 E.79106
G1 X121.033 Y143.17 E.00921
G1 X86.693 Y108.83 E.79106
G1 X87.258 Y108.83 E.00921
G1 X121.599 Y143.17 E.79106
G1 X122.164 Y143.17 E.00921
G1 X87.824 Y108.83 E.79106
G1 X88.389 Y108.83 E.00921
G1 X122.73 Y143.17 E.79106
G1 X123.295 Y143.17 E.00921
G1 X88.955 Y108.83 E.79106
G1 X89.52 Y108.83 E.00921
G1 X123.86 Y143.17 E.79106
G1 X124.426 Y143.17 E.00921
G1 X90.085 Y108.83 E.79106
G1 X90.651 Y108.83 E.00921
G1 X124.991 Y143.17 E.79106
G1 X125.556 Y143.17 E.00921
G1 X91.216 Y108.83 E.79106
G1 X91.782 Y108.83 E.00921
G1 X126.122 Y143.17 E.79106
G1 X126.687 Y143.17 E.00921
G1 X92.347 Y108.83 E.79106
G1 X92.912 Y108.83 E.00921
G1 X127.253 Y143.17 E.79106
G1 X127.818 Y143.17 E.00921
G1 X93.478 Y108.83 E.79106
G1 X94.043 Y108.83 E.00921
G1 X128.383 Y143.17 E.79106
G1 X128.949 Y143.17 E.00921
G1 X94.608 Y108.83 E.79106
G1 X95.174 Y108.83 E.00921
G1 X129.514 Y143.17 E.79106
G1 X130.08 Y143.17 E.00921
G1 X95.739 Y108.83 E.79106
G1 X96.305 Y108.83 E.00921
G1 X130.645 Y143.17 E.79106
G1 X131.21 Y143.17 E.00921
G1 X96.87 Y108.83 E.79106
G1 X97.435 Y108.83 E.00921
G1 X131.776 Y143.17 E.79106
G1 X132.341 Y143.17 E.00921
G1 X98.001 Y108.83 E.79106
G1 X98.566 Y108.83 E.00921
G1 X132.907 Y143.17 E.79106
G1 X133.472 Y143.17 E.00921
G1 X99.132 Y108.83 E.79106
G1 X99.697 Y108.83 E.00921
G1 X134.037 Y143.17 E.79106
G1 X134.603 Y143.17 E.00921
G1 X100.262 Y108.83 E.79106
G1 X100.828 Y108.83 E.00921
G1 X135.168 Y143.17 E.79106
M73 P38 R40
G1 X135.733 Y143.17 E.00921
G1 X101.393 Y108.83 E.79106
G1 X101.958 Y108.83 E.00921
G1 X136.299 Y143.17 E.79106
G1 X136.864 Y143.17 E.00921
G1 X102.524 Y108.83 E.79106
G1 X103.089 Y108.83 E.00921
G1 X137.43 Y143.17 E.79106
G1 X137.995 Y143.17 E.00921
G1 X103.655 Y108.83 E.79106
G1 X104.22 Y108.83 E.00921
G1 X138.56 Y143.17 E.79106
G1 X139.126 Y143.17 E.00921
G1 X104.785 Y108.83 E.79106
G1 X105.351 Y108.83 E.00921
G1 X139.691 Y143.17 E.79106
G1 X140.257 Y143.17 E.00921
G1 X105.916 Y108.83 E.79106
G1 X106.482 Y108.83 E.00921
G1 X140.822 Y143.17 E.79106
G1 X141.387 Y143.17 E.00921
G1 X107.047 Y108.83 E.79106
G1 X107.612 Y108.83 E.00921
G1 X141.953 Y143.17 E.79106
G1 X142.518 Y143.17 E.00921
G1 X108.178 Y108.83 E.79106
G1 X108.743 Y108.83 E.00921
G1 X143.084 Y143.17 E.79106
G1 X143.649 Y143.17 E.00921
G1 X109.309 Y108.83 E.79106
G1 X109.874 Y108.83 E.00921
G1 X144.214 Y143.17 E.79106
G1 X144.78 Y143.17 E.00921
G1 X110.439 Y108.83 E.79106
G1 X111.005 Y108.83 E.00921
G1 X145.345 Y143.17 E.79106
G1 X145.91 Y143.17 E.00921
G1 X111.57 Y108.83 E.79106
G1 X112.135 Y108.83 E.00921
G1 X146.476 Y143.17 E.79106
G1 X147.041 Y143.17 E.00921
G1 X112.701 Y108.83 E.79106
G1 X113.266 Y108.83 E.00921
G1 X147.607 Y143.17 E.79106
G1 X148.172 Y143.17 E.00921
M73 P38 R39
G1 X113.832 Y108.83 E.79106
G1 X114.397 Y108.83 E.00921
G1 X148.737 Y143.17 E.79106
G1 X149.303 Y143.17 E.00921
G1 X114.962 Y108.83 E.79106
G1 X115.528 Y108.83 E.00921
G1 X149.868 Y143.17 E.79106
G1 X150.434 Y143.17 E.00921
G1 X116.093 Y108.83 E.79106
G1 X116.659 Y108.83 E.00921
G1 X150.999 Y143.17 E.79106
G1 X151.564 Y143.17 E.00921
G1 X117.224 Y108.83 E.79106
G1 X117.789 Y108.83 E.00921
G1 X152.13 Y143.17 E.79106
G1 X152.695 Y143.17 E.00921
G1 X118.355 Y108.83 E.79106
G1 X118.92 Y108.83 E.00921
G1 X153.261 Y143.17 E.79106
G1 X153.826 Y143.17 E.00921
G1 X119.486 Y108.83 E.79106
G1 X120.051 Y108.83 E.00921
G1 X154.391 Y143.17 E.79106
G1 X154.957 Y143.17 E.00921
G1 X120.616 Y108.83 E.79106
G1 X121.182 Y108.83 E.00921
G1 X155.522 Y143.17 E.79106
G1 X156.087 Y143.17 E.00921
G1 X121.747 Y108.83 E.79106
G1 X122.312 Y108.83 E.00921
G1 X156.653 Y143.17 E.79106
G1 X157.218 Y143.17 E.00921
G1 X122.878 Y108.83 E.79106
G1 X123.443 Y108.83 E.00921
G1 X157.784 Y143.17 E.79106
G1 X158.349 Y143.17 E.00921
G1 X124.009 Y108.83 E.79106
G1 X124.574 Y108.83 E.00921
G1 X158.914 Y143.17 E.79106
G1 X159.48 Y143.17 E.00921
G1 X125.139 Y108.83 E.79106
G1 X125.705 Y108.83 E.00921
G1 X160.045 Y143.17 E.79106
G1 X160.611 Y143.17 E.00921
G1 X126.27 Y108.83 E.79106
G1 X126.836 Y108.83 E.00921
G1 X161.176 Y143.17 E.79106
G1 X161.741 Y143.17 E.00921
G1 X127.401 Y108.83 E.79106
G1 X127.966 Y108.83 E.00921
G1 X162.307 Y143.17 E.79106
G1 X162.872 Y143.17 E.00921
G1 X128.532 Y108.83 E.79106
G1 X129.097 Y108.83 E.00921
G1 X163.437 Y143.17 E.79106
G1 X164.003 Y143.17 E.00921
G1 X129.663 Y108.83 E.79106
G1 X130.228 Y108.83 E.00921
G1 X164.568 Y143.17 E.79106
G1 X165.134 Y143.17 E.00921
G1 X130.793 Y108.83 E.79106
G1 X131.359 Y108.83 E.00921
G1 X165.699 Y143.17 E.79106
G1 X166.264 Y143.17 E.00921
G1 X131.924 Y108.83 E.79106
G1 X132.489 Y108.83 E.00921
G1 X166.83 Y143.17 E.79106
G1 X167.395 Y143.17 E.00921
G1 X133.055 Y108.83 E.79106
G1 X133.62 Y108.83 E.00921
G1 X167.961 Y143.17 E.79106
G1 X168.526 Y143.17 E.00921
G1 X134.186 Y108.83 E.79106
G1 X134.751 Y108.83 E.00921
G1 X169.091 Y143.17 E.79106
G1 X169.657 Y143.17 E.00921
G1 X135.316 Y108.83 E.79106
G1 X135.882 Y108.83 E.00921
G1 X170.222 Y143.17 E.79106
G1 X170.788 Y143.17 E.00921
G1 X136.447 Y108.83 E.79106
G1 X137.013 Y108.83 E.00921
G1 X171.353 Y143.17 E.79106
G1 X171.918 Y143.17 E.00921
G1 X137.578 Y108.83 E.79106
G1 X138.143 Y108.83 E.00921
G1 X172.484 Y143.17 E.79106
G1 X173.049 Y143.17 E.00921
M73 P39 R39
G1 X138.709 Y108.83 E.79106
G1 X139.274 Y108.83 E.00921
G1 X173.614 Y143.17 E.79106
G1 X174.18 Y143.17 E.00921
G1 X139.84 Y108.83 E.79106
G1 X140.405 Y108.83 E.00921
G1 X174.745 Y143.17 E.79106
G1 X175.311 Y143.17 E.00921
G1 X140.97 Y108.83 E.79106
G1 X141.536 Y108.83 E.00921
G1 X175.876 Y143.17 E.79106
G1 X176.441 Y143.17 E.00921
G1 X142.101 Y108.83 E.79106
G1 X142.666 Y108.83 E.00921
G1 X177.007 Y143.17 E.79106
G1 X177.572 Y143.17 E.00921
G1 X143.232 Y108.83 E.79106
G1 X143.797 Y108.83 E.00921
G1 X178.138 Y143.17 E.79106
G1 X178.17 Y143.17 E.00053
G1 X178.17 Y142.637 E.00868
G1 X144.363 Y108.83 E.77879
G1 X144.928 Y108.83 E.00921
G1 X178.17 Y142.072 E.76577
G1 X178.17 Y141.507 E.00921
G1 X145.493 Y108.83 E.75274
G1 X146.059 Y108.83 E.00921
G1 X178.17 Y140.941 E.73972
G1 X178.17 Y140.376 E.00921
G1 X146.624 Y108.83 E.72669
G1 X147.19 Y108.83 E.00921
G1 X178.17 Y139.81 E.71367
G1 X178.17 Y139.245 E.00921
G1 X147.755 Y108.83 E.70064
G1 X148.32 Y108.83 E.00921
G1 X178.17 Y138.68 E.68762
G1 X178.17 Y138.114 E.00921
G1 X148.886 Y108.83 E.6746
G1 X149.451 Y108.83 E.00921
G1 X178.17 Y137.549 E.66157
G1 X178.17 Y136.983 E.00921
G1 X150.017 Y108.83 E.64855
G1 X150.582 Y108.83 E.00921
G1 X178.17 Y136.418 E.63552
G1 X178.17 Y135.853 E.00921
G1 X151.147 Y108.83 E.6225
G1 X151.713 Y108.83 E.00921
G1 X178.17 Y135.287 E.60947
G1 X178.17 Y134.722 E.00921
G1 X152.278 Y108.83 E.59645
G1 X152.843 Y108.83 E.00921
G1 X178.17 Y134.157 E.58343
G1 X178.17 Y133.591 E.00921
G1 X153.409 Y108.83 E.5704
G1 X153.974 Y108.83 E.00921
G1 X178.17 Y133.026 E.55738
G1 X178.17 Y132.46 E.00921
G1 X154.54 Y108.83 E.54435
G1 X155.105 Y108.83 E.00921
G1 X178.17 Y131.895 E.53133
G1 X178.17 Y131.33 E.00921
G1 X155.67 Y108.83 E.5183
G1 X156.236 Y108.83 E.00921
G1 X178.17 Y130.764 E.50528
G1 X178.17 Y130.199 E.00921
G1 X156.801 Y108.83 E.49226
G1 X157.367 Y108.83 E.00921
G1 X178.17 Y129.633 E.47923
G1 X178.17 Y129.068 E.00921
G1 X157.932 Y108.83 E.46621
G1 X158.497 Y108.83 E.00921
G1 X178.17 Y128.503 E.45318
G1 X178.17 Y127.937 E.00921
G1 X159.063 Y108.83 E.44016
G1 X159.628 Y108.83 E.00921
G1 X178.17 Y127.372 E.42713
G1 X178.17 Y126.806 E.00921
G1 X160.194 Y108.83 E.41411
G1 X160.759 Y108.83 E.00921
G1 X178.17 Y126.241 E.40109
G1 X178.17 Y125.676 E.00921
G1 X161.324 Y108.83 E.38806
G1 X161.89 Y108.83 E.00921
G1 X178.17 Y125.11 E.37504
G1 X178.17 Y124.545 E.00921
G1 X162.455 Y108.83 E.36201
G1 X163.02 Y108.83 E.00921
G1 X178.17 Y123.98 E.34899
G1 X178.17 Y123.414 E.00921
G1 X163.586 Y108.83 E.33596
G1 X164.151 Y108.83 E.00921
G1 X178.17 Y122.849 E.32294
G1 X178.17 Y122.283 E.00921
G1 X164.717 Y108.83 E.30992
G1 X165.282 Y108.83 E.00921
G1 X178.17 Y121.718 E.29689
G1 X178.17 Y121.153 E.00921
G1 X165.847 Y108.83 E.28387
G1 X166.413 Y108.83 E.00921
G1 X178.17 Y120.587 E.27084
G1 X178.17 Y120.022 E.00921
G1 X166.978 Y108.83 E.25782
G1 X167.544 Y108.83 E.00921
G1 X178.17 Y119.456 E.24479
G1 X178.17 Y118.891 E.00921
G1 X168.109 Y108.83 E.23177
G1 X168.674 Y108.83 E.00921
G1 X178.17 Y118.326 E.21875
G1 X178.17 Y117.76 E.00921
G1 X169.24 Y108.83 E.20572
G1 X169.805 Y108.83 E.00921
G1 X178.17 Y117.195 E.1927
G1 X178.17 Y116.629 E.00921
G1 X170.37 Y108.83 E.17967
M73 P39 R38
G1 X170.936 Y108.83 E.00921
G1 X178.17 Y116.064 E.16665
G1 X178.17 Y115.499 E.00921
G1 X171.501 Y108.83 E.15362
G1 X172.067 Y108.83 E.00921
G1 X178.17 Y114.933 E.1406
G1 X178.17 Y114.368 E.00921
G1 X172.632 Y108.83 E.12758
G1 X173.197 Y108.83 E.00921
G1 X178.17 Y113.803 E.11455
G1 X178.17 Y113.237 E.00921
G1 X173.763 Y108.83 E.10153
G1 X174.328 Y108.83 E.00921
G1 X178.17 Y112.672 E.0885
G1 X178.17 Y112.106 E.00921
G1 X174.894 Y108.83 E.07548
G1 X175.459 Y108.83 E.00921
G1 X178.17 Y111.541 E.06245
G1 X178.17 Y110.976 E.00921
M73 P40 R38
G1 X176.024 Y108.83 E.04943
G1 X176.59 Y108.83 E.00921
G1 X178.17 Y110.41 E.03641
G1 X178.17 Y109.845 E.00921
G1 X177.155 Y108.83 E.02338
G1 X177.721 Y108.83 E.00921
G1 X178.35 Y109.459 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X177.721 Y108.83 E-.338
G1 X177.155 Y108.83 E-.21485
G1 X177.541 Y109.215 E-.20715
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/25
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M204 S10000
G17
G3 Z.7 I-.765 J-.946 P1  F30000
G1 X134.085 Y144.357 Z.7
G1 X51.016 Y211.534
G1 Z.4
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #5
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S1000
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
G3 Z.8 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X76.643 Y110.653
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.65 Y109.459 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X78.28 Y108.83 E.01447
G1 X78.844 Y108.83 E.00918
G1 X77.83 Y109.844 E.02333
G1 X77.83 Y110.409 E.00918
G1 X79.409 Y108.83 E.03631
G1 X79.973 Y108.83 E.00918
G1 X77.83 Y110.973 E.04929
G1 X77.83 Y111.538 E.00918
G1 X80.538 Y108.83 E.06228
G1 X81.102 Y108.83 E.00918
G1 X77.83 Y112.102 E.07526
G1 X77.83 Y112.667 E.00918
G1 X81.667 Y108.83 E.08824
G1 X82.231 Y108.83 E.00918
G1 X77.83 Y113.231 E.10123
G1 X77.83 Y113.796 E.00918
G1 X82.796 Y108.83 E.11421
G1 X83.36 Y108.83 E.00918
G1 X77.83 Y114.36 E.12719
G1 X77.83 Y114.925 E.00918
G1 X83.925 Y108.83 E.14017
G1 X84.489 Y108.83 E.00918
G1 X77.83 Y115.489 E.15316
G1 X77.83 Y116.054 E.00918
G1 X85.054 Y108.83 E.16614
G1 X85.618 Y108.83 E.00918
G1 X77.83 Y116.618 E.17912
G1 X77.83 Y117.182 E.00918
G1 X86.182 Y108.83 E.1921
G1 X86.747 Y108.83 E.00918
G1 X77.83 Y117.747 E.20509
G1 X77.83 Y118.311 E.00918
G1 X87.311 Y108.83 E.21807
G1 X87.876 Y108.83 E.00918
G1 X77.83 Y118.876 E.23105
G1 X77.83 Y119.44 E.00918
G1 X88.44 Y108.83 E.24403
G1 X89.005 Y108.83 E.00918
G1 X77.83 Y120.005 E.25702
G1 X77.83 Y120.569 E.00918
G1 X89.569 Y108.83 E.27
G1 X90.134 Y108.83 E.00918
G1 X77.83 Y121.134 E.28298
G1 X77.83 Y121.698 E.00918
G1 X90.698 Y108.83 E.29596
G1 X91.263 Y108.83 E.00918
G1 X77.83 Y122.263 E.30895
G1 X77.83 Y122.827 E.00918
G1 X91.827 Y108.83 E.32193
G1 X92.392 Y108.83 E.00918
G1 X77.83 Y123.392 E.33491
G1 X77.83 Y123.956 E.00918
G1 X92.956 Y108.83 E.3479
G1 X93.521 Y108.83 E.00918
G1 X77.83 Y124.521 E.36088
G1 X77.83 Y125.085 E.00918
G1 X94.085 Y108.83 E.37386
G1 X94.65 Y108.83 E.00918
G1 X77.83 Y125.65 E.38684
G1 X77.83 Y126.214 E.00918
G1 X95.214 Y108.83 E.39983
G1 X95.779 Y108.83 E.00918
G1 X77.83 Y126.779 E.41281
G1 X77.83 Y127.343 E.00918
G1 X96.343 Y108.83 E.42579
G1 X96.908 Y108.83 E.00918
G1 X77.83 Y127.908 E.43877
G1 X77.83 Y128.472 E.00918
G1 X97.472 Y108.83 E.45176
G1 X98.037 Y108.83 E.00918
G1 X77.83 Y129.037 E.46474
G1 X77.83 Y129.601 E.00918
G1 X98.601 Y108.83 E.47772
G1 X99.166 Y108.83 E.00918
G1 X77.83 Y130.166 E.4907
G1 X77.83 Y130.73 E.00918
G1 X99.73 Y108.83 E.50369
G1 X100.295 Y108.83 E.00918
G1 X77.83 Y131.295 E.51667
G1 X77.83 Y131.859 E.00918
G1 X100.859 Y108.83 E.52965
G1 X101.424 Y108.83 E.00918
G1 X77.83 Y132.424 E.54263
G1 X77.83 Y132.988 E.00918
G1 X101.988 Y108.83 E.55562
G1 X102.552 Y108.83 E.00918
M73 P41 R38
G1 X77.83 Y133.552 E.5686
G1 X77.83 Y134.117 E.00918
G1 X103.117 Y108.83 E.58158
G1 X103.681 Y108.83 E.00918
G1 X77.83 Y134.681 E.59457
G1 X77.83 Y135.246 E.00918
G1 X104.246 Y108.83 E.60755
G1 X104.81 Y108.83 E.00918
G1 X77.83 Y135.81 E.62053
G1 X77.83 Y136.375 E.00918
G1 X105.375 Y108.83 E.63351
G1 X105.939 Y108.83 E.00918
G1 X77.83 Y136.939 E.6465
G1 X77.83 Y137.504 E.00918
G1 X106.504 Y108.83 E.65948
G1 X107.068 Y108.83 E.00918
G1 X77.83 Y138.068 E.67246
G1 X77.83 Y138.633 E.00918
G1 X107.633 Y108.83 E.68544
G1 X108.197 Y108.83 E.00918
G1 X77.83 Y139.197 E.69843
G1 X77.83 Y139.762 E.00918
G1 X108.762 Y108.83 E.71141
G1 X109.326 Y108.83 E.00918
G1 X77.83 Y140.326 E.72439
G1 X77.83 Y140.891 E.00918
G1 X109.891 Y108.83 E.73737
G1 X110.455 Y108.83 E.00918
G1 X77.936 Y141.349 E.7479
G1 X78.219 Y141.631 E.00649
G1 X111.02 Y108.83 E.7544
G1 X111.584 Y108.83 E.00918
G1 X78.501 Y141.913 E.76089
G1 X78.783 Y142.195 E.00649
G1 X112.149 Y108.83 E.76738
G1 X112.713 Y108.83 E.00918
G1 X79.065 Y142.478 E.77387
G1 X79.348 Y142.76 E.00649
G1 X113.278 Y108.83 E.78036
G1 X113.842 Y108.83 E.00918
G1 X79.63 Y143.042 E.78685
G1 X79.758 Y143.17 E.00295
G1 X80.066 Y143.17 E.00501
G1 X114.407 Y108.83 E.7898
G1 X114.971 Y108.83 E.00918
G1 X80.631 Y143.17 E.7898
G1 X81.195 Y143.17 E.00918
G1 X115.536 Y108.83 E.7898
G1 X116.1 Y108.83 E.00918
G1 X81.76 Y143.17 E.7898
G1 X82.324 Y143.17 E.00918
G1 X116.665 Y108.83 E.7898
G1 X117.229 Y108.83 E.00918
G1 X82.889 Y143.17 E.7898
G1 X83.453 Y143.17 E.00918
G1 X117.794 Y108.83 E.7898
G1 X118.358 Y108.83 E.00918
G1 X84.018 Y143.17 E.7898
G1 X84.582 Y143.17 E.00918
G1 X118.923 Y108.83 E.7898
G1 X119.487 Y108.83 E.00918
G1 X85.147 Y143.17 E.7898
G1 X85.711 Y143.17 E.00918
G1 X120.051 Y108.83 E.7898
G1 X120.616 Y108.83 E.00918
G1 X86.276 Y143.17 E.7898
G1 X86.84 Y143.17 E.00918
G1 X121.18 Y108.83 E.7898
G1 X121.745 Y108.83 E.00918
G1 X87.405 Y143.17 E.7898
G1 X87.969 Y143.17 E.00918
G1 X122.309 Y108.83 E.7898
G1 X122.874 Y108.83 E.00918
G1 X88.534 Y143.17 E.7898
G1 X89.098 Y143.17 E.00918
G1 X123.438 Y108.83 E.7898
G1 X124.003 Y108.83 E.00918
G1 X89.662 Y143.17 E.7898
G1 X90.227 Y143.17 E.00918
G1 X124.567 Y108.83 E.7898
G1 X125.132 Y108.83 E.00918
G1 X90.791 Y143.17 E.7898
G1 X91.356 Y143.17 E.00918
G1 X125.696 Y108.83 E.7898
G1 X126.261 Y108.83 E.00918
G1 X91.92 Y143.17 E.7898
G1 X92.485 Y143.17 E.00918
G1 X126.825 Y108.83 E.7898
G1 X127.39 Y108.83 E.00918
G1 X93.049 Y143.17 E.7898
G1 X93.614 Y143.17 E.00918
G1 X127.954 Y108.83 E.7898
G1 X128.519 Y108.83 E.00918
G1 X94.178 Y143.17 E.7898
M73 P41 R37
G1 X94.743 Y143.17 E.00918
G1 X129.083 Y108.83 E.7898
G1 X129.648 Y108.83 E.00918
G1 X95.307 Y143.17 E.7898
G1 X95.872 Y143.17 E.00918
G1 X130.212 Y108.83 E.7898
G1 X130.777 Y108.83 E.00918
G1 X96.436 Y143.17 E.7898
G1 X97.001 Y143.17 E.00918
G1 X131.341 Y108.83 E.7898
G1 X131.906 Y108.83 E.00918
G1 X97.565 Y143.17 E.7898
G1 X98.13 Y143.17 E.00918
G1 X132.47 Y108.83 E.7898
G1 X133.035 Y108.83 E.00918
G1 X98.694 Y143.17 E.7898
G1 X99.259 Y143.17 E.00918
G1 X133.599 Y108.83 E.7898
G1 X134.164 Y108.83 E.00918
G1 X99.823 Y143.17 E.7898
G1 X100.388 Y143.17 E.00918
G1 X134.728 Y108.83 E.7898
G1 X135.293 Y108.83 E.00918
G1 X100.952 Y143.17 E.7898
G1 X101.517 Y143.17 E.00918
G1 X135.857 Y108.83 E.7898
G1 X136.421 Y108.83 E.00918
G1 X102.081 Y143.17 E.7898
G1 X102.646 Y143.17 E.00918
G1 X136.986 Y108.83 E.7898
G1 X137.55 Y108.83 E.00918
G1 X103.21 Y143.17 E.7898
G1 X103.775 Y143.17 E.00918
G1 X138.115 Y108.83 E.7898
G1 X138.679 Y108.83 E.00918
G1 X104.339 Y143.17 E.7898
G1 X104.904 Y143.17 E.00918
G1 X139.244 Y108.83 E.7898
G1 X139.808 Y108.83 E.00918
G1 X105.468 Y143.17 E.7898
G1 X106.033 Y143.17 E.00918
G1 X140.373 Y108.83 E.7898
G1 X140.937 Y108.83 E.00918
G1 X106.597 Y143.17 E.7898
G1 X107.161 Y143.17 E.00918
G1 X141.502 Y108.83 E.7898
G1 X142.066 Y108.83 E.00918
G1 X107.726 Y143.17 E.7898
G1 X108.29 Y143.17 E.00918
G1 X142.631 Y108.83 E.7898
G1 X143.195 Y108.83 E.00918
G1 X108.855 Y143.17 E.7898
G1 X109.419 Y143.17 E.00918
G1 X143.76 Y108.83 E.7898
G1 X144.324 Y108.83 E.00918
G1 X109.984 Y143.17 E.7898
G1 X110.548 Y143.17 E.00918
G1 X144.889 Y108.83 E.7898
G1 X145.453 Y108.83 E.00918
G1 X111.113 Y143.17 E.7898
G1 X111.677 Y143.17 E.00918
G1 X146.018 Y108.83 E.7898
G1 X146.582 Y108.83 E.00918
G1 X112.242 Y143.17 E.7898
G1 X112.806 Y143.17 E.00918
G1 X147.147 Y108.83 E.7898
G1 X147.711 Y108.83 E.00918
G1 X113.371 Y143.17 E.7898
G1 X113.935 Y143.17 E.00918
G1 X148.276 Y108.83 E.7898
G1 X148.84 Y108.83 E.00918
G1 X114.5 Y143.17 E.7898
G1 X115.064 Y143.17 E.00918
G1 X149.405 Y108.83 E.7898
G1 X149.969 Y108.83 E.00918
G1 X115.629 Y143.17 E.7898
G1 X116.193 Y143.17 E.00918
G1 X150.534 Y108.83 E.7898
G1 X151.098 Y108.83 E.00918
G1 X116.758 Y143.17 E.7898
G1 X117.322 Y143.17 E.00918
M73 P42 R37
G1 X151.663 Y108.83 E.7898
G1 X152.227 Y108.83 E.00918
G1 X117.887 Y143.17 E.7898
G1 X118.451 Y143.17 E.00918
G1 X152.792 Y108.83 E.7898
G1 X153.356 Y108.83 E.00918
G1 X119.016 Y143.17 E.7898
G1 X119.58 Y143.17 E.00918
G1 X153.92 Y108.83 E.7898
G1 X154.485 Y108.83 E.00918
G1 X120.145 Y143.17 E.7898
G1 X120.709 Y143.17 E.00918
G1 X155.049 Y108.83 E.7898
G1 X155.614 Y108.83 E.00918
G1 X121.274 Y143.17 E.7898
G1 X121.838 Y143.17 E.00918
G1 X156.178 Y108.83 E.7898
G1 X156.743 Y108.83 E.00918
G1 X122.403 Y143.17 E.7898
G1 X122.967 Y143.17 E.00918
G1 X157.307 Y108.83 E.7898
G1 X157.872 Y108.83 E.00918
G1 X123.532 Y143.17 E.7898
G1 X124.096 Y143.17 E.00918
G1 X158.436 Y108.83 E.7898
G1 X159.001 Y108.83 E.00918
G1 X124.66 Y143.17 E.7898
G1 X125.225 Y143.17 E.00918
G1 X159.565 Y108.83 E.7898
G1 X160.13 Y108.83 E.00918
G1 X125.789 Y143.17 E.7898
G1 X126.354 Y143.17 E.00918
G1 X160.694 Y108.83 E.7898
G1 X161.259 Y108.83 E.00918
G1 X126.918 Y143.17 E.7898
G1 X127.483 Y143.17 E.00918
G1 X161.823 Y108.83 E.7898
G1 X162.388 Y108.83 E.00918
G1 X128.047 Y143.17 E.7898
G1 X128.612 Y143.17 E.00918
G1 X162.952 Y108.83 E.7898
G1 X163.517 Y108.83 E.00918
G1 X129.176 Y143.17 E.7898
G1 X129.741 Y143.17 E.00918
G1 X164.081 Y108.83 E.7898
G1 X164.646 Y108.83 E.00918
G1 X130.305 Y143.17 E.7898
G1 X130.87 Y143.17 E.00918
G1 X165.21 Y108.83 E.7898
G1 X165.775 Y108.83 E.00918
G1 X131.434 Y143.17 E.7898
G1 X131.999 Y143.17 E.00918
G1 X166.339 Y108.83 E.7898
G1 X166.904 Y108.83 E.00918
G1 X132.563 Y143.17 E.7898
G1 X133.128 Y143.17 E.00918
G1 X167.468 Y108.83 E.7898
G1 X168.033 Y108.83 E.00918
G1 X133.692 Y143.17 E.7898
G1 X134.257 Y143.17 E.00918
G1 X168.597 Y108.83 E.7898
G1 X169.162 Y108.83 E.00918
G1 X134.821 Y143.17 E.7898
G1 X135.386 Y143.17 E.00918
G1 X169.726 Y108.83 E.7898
G1 X170.291 Y108.83 E.00918
G1 X135.95 Y143.17 E.7898
G1 X136.515 Y143.17 E.00918
G1 X170.855 Y108.83 E.7898
G1 X171.419 Y108.83 E.00918
G1 X137.079 Y143.17 E.7898
G1 X137.644 Y143.17 E.00918
G1 X171.984 Y108.83 E.7898
G1 X172.548 Y108.83 E.00918
G1 X138.208 Y143.17 E.7898
G1 X138.773 Y143.17 E.00918
G1 X173.113 Y108.83 E.7898
G1 X173.677 Y108.83 E.00918
G1 X139.337 Y143.17 E.7898
G1 X139.902 Y143.17 E.00918
G1 X174.242 Y108.83 E.7898
G1 X174.806 Y108.83 E.00918
G1 X140.466 Y143.17 E.7898
G1 X141.03 Y143.17 E.00918
G1 X175.371 Y108.83 E.7898
G1 X175.935 Y108.83 E.00918
G1 X141.595 Y143.17 E.7898
G1 X142.159 Y143.17 E.00918
G1 X176.5 Y108.83 E.7898
G1 X177.064 Y108.83 E.00918
G1 X142.724 Y143.17 E.7898
G1 X143.288 Y143.17 E.00918
G1 X177.629 Y108.83 E.7898
G1 X178.17 Y108.83 E.0088
G1 X178.17 Y108.853 E.00038
G1 X143.853 Y143.17 E.78927
G1 X144.417 Y143.17 E.00918
G1 X178.17 Y109.417 E.77628
G1 X178.17 Y109.982 E.00918
G1 X144.982 Y143.17 E.7633
G1 X145.546 Y143.17 E.00918
G1 X178.17 Y110.546 E.75032
G1 X178.17 Y111.111 E.00918
G1 X146.111 Y143.17 E.73734
G1 X146.675 Y143.17 E.00918
G1 X178.17 Y111.675 E.72435
G1 X178.17 Y112.24 E.00918
G1 X147.24 Y143.17 E.71137
G1 X147.804 Y143.17 E.00918
G1 X178.17 Y112.804 E.69839
G1 X178.17 Y113.369 E.00918
G1 X148.369 Y143.17 E.68541
G1 X148.933 Y143.17 E.00918
G1 X178.17 Y113.933 E.67242
G1 X178.17 Y114.498 E.00918
G1 X149.498 Y143.17 E.65944
G1 X150.062 Y143.17 E.00918
G1 X178.17 Y115.062 E.64646
G1 X178.17 Y115.627 E.00918
G1 X150.627 Y143.17 E.63348
G1 X151.191 Y143.17 E.00918
G1 X178.17 Y116.191 E.62049
G1 X178.17 Y116.756 E.00918
G1 X151.756 Y143.17 E.60751
G1 X152.32 Y143.17 E.00918
G1 X178.17 Y117.32 E.59453
M73 P42 R36
G1 X178.17 Y117.885 E.00918
G1 X152.885 Y143.17 E.58155
G1 X153.449 Y143.17 E.00918
G1 X178.17 Y118.449 E.56856
G1 X178.17 Y119.014 E.00918
G1 X154.014 Y143.17 E.55558
M73 P43 R36
G1 X154.578 Y143.17 E.00918
G1 X178.17 Y119.578 E.5426
G1 X178.17 Y120.143 E.00918
G1 X155.143 Y143.17 E.52961
G1 X155.707 Y143.17 E.00918
G1 X178.17 Y120.707 E.51663
G1 X178.17 Y121.272 E.00918
G1 X156.272 Y143.17 E.50365
G1 X156.836 Y143.17 E.00918
G1 X178.17 Y121.836 E.49067
G1 X178.17 Y122.401 E.00918
G1 X157.401 Y143.17 E.47768
G1 X157.965 Y143.17 E.00918
G1 X178.17 Y122.965 E.4647
G1 X178.17 Y123.529 E.00918
G1 X158.529 Y143.17 E.45172
G1 X159.094 Y143.17 E.00918
G1 X178.17 Y124.094 E.43874
G1 X178.17 Y124.658 E.00918
G1 X159.658 Y143.17 E.42575
G1 X160.223 Y143.17 E.00918
G1 X178.17 Y125.223 E.41277
G1 X178.17 Y125.787 E.00918
G1 X160.787 Y143.17 E.39979
G1 X161.352 Y143.17 E.00918
G1 X178.17 Y126.352 E.38681
G1 X178.17 Y126.916 E.00918
G1 X161.916 Y143.17 E.37382
G1 X162.481 Y143.17 E.00918
G1 X178.17 Y127.481 E.36084
G1 X178.17 Y128.045 E.00918
G1 X163.045 Y143.17 E.34786
G1 X163.61 Y143.17 E.00918
G1 X178.17 Y128.61 E.33488
G1 X178.17 Y129.174 E.00918
G1 X164.174 Y143.17 E.32189
G1 X164.739 Y143.17 E.00918
G1 X178.17 Y129.739 E.30891
G1 X178.17 Y130.303 E.00918
G1 X165.303 Y143.17 E.29593
G1 X165.868 Y143.17 E.00918
G1 X178.17 Y130.868 E.28294
G1 X178.17 Y131.432 E.00918
G1 X166.432 Y143.17 E.26996
G1 X166.997 Y143.17 E.00918
G1 X178.17 Y131.997 E.25698
G1 X178.17 Y132.561 E.00918
G1 X167.561 Y143.17 E.244
G1 X168.126 Y143.17 E.00918
G1 X178.17 Y133.126 E.23101
G1 X178.17 Y133.69 E.00918
G1 X168.69 Y143.17 E.21803
G1 X169.255 Y143.17 E.00918
G1 X178.17 Y134.255 E.20505
G1 X178.17 Y134.819 E.00918
G1 X169.819 Y143.17 E.19207
G1 X170.384 Y143.17 E.00918
G1 X178.17 Y135.384 E.17908
G1 X178.17 Y135.948 E.00918
G1 X170.948 Y143.17 E.1661
G1 X171.513 Y143.17 E.00918
G1 X178.17 Y136.513 E.15312
G1 X178.17 Y137.077 E.00918
G1 X172.077 Y143.17 E.14014
G1 X172.642 Y143.17 E.00918
G1 X178.17 Y137.642 E.12715
G1 X178.17 Y138.206 E.00918
G1 X173.206 Y143.17 E.11417
G1 X173.771 Y143.17 E.00918
G1 X178.17 Y138.771 E.10119
G1 X178.17 Y139.335 E.00918
G1 X174.335 Y143.17 E.08821
G1 X174.899 Y143.17 E.00918
G1 X178.17 Y139.9 E.07522
G1 X178.17 Y140.464 E.00918
G1 X175.464 Y143.17 E.06224
G1 X176.028 Y143.17 E.00918
G1 X178.17 Y141.028 E.04926
G1 X178.17 Y141.593 E.00918
G1 X176.593 Y143.17 E.03627
G1 X177.157 Y143.17 E.00918
G1 X178.17 Y142.157 E.02329
G1 X178.17 Y142.722 E.00918
G1 X177.543 Y143.35 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 0.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X178.17 Y142.722 E-.33727
G1 X178.17 Y142.157 E-.21451
G1 X177.783 Y142.545 E-.20822
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/25
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M204 S10000
G17
G3 Z.8 I-.582 J-1.069 P1  F30000
G1 X174.453 Y144.357 Z.8
G1 X51.016 Y211.534
G1 Z.5
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #6
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
M204 S1000
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
M73 P44 R36
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
M204 S1000
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
G3 Z.9 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X76.643 Y110.638
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.084 Y114.9 Z.9 F30000
G1 X77.65 Y141.061 Z.9
G1 Z.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X79.76 Y143.17 E.0486
G1 X80.325 Y143.17 E.00921
G1 X77.83 Y140.675 E.05749
G1 X77.83 Y140.109 E.00921
G1 X80.891 Y143.17 E.07051
G1 X81.456 Y143.17 E.00921
G1 X77.83 Y139.544 E.08354
G1 X77.83 Y138.978 E.00921
G1 X82.022 Y143.17 E.09656
G1 X82.587 Y143.17 E.00921
G1 X77.83 Y138.413 E.10959
G1 X77.83 Y137.848 E.00921
G1 X83.152 Y143.17 E.12261
G1 X83.718 Y143.17 E.00921
G1 X77.83 Y137.282 E.13563
G1 X77.83 Y136.717 E.00921
G1 X84.283 Y143.17 E.14866
G1 X84.849 Y143.17 E.00921
G1 X77.83 Y136.151 E.16168
G1 X77.83 Y135.586 E.00921
G1 X85.414 Y143.17 E.17471
G1 X85.979 Y143.17 E.00921
G1 X77.83 Y135.021 E.18773
G1 X77.83 Y134.455 E.00921
G1 X86.545 Y143.17 E.20076
G1 X87.11 Y143.17 E.00921
G1 X77.83 Y133.89 E.21378
G1 X77.83 Y133.325 E.00921
G1 X87.675 Y143.17 E.2268
G1 X88.241 Y143.17 E.00921
G1 X77.83 Y132.759 E.23983
G1 X77.83 Y132.194 E.00921
G1 X88.806 Y143.17 E.25285
G1 X89.372 Y143.17 E.00921
G1 X77.83 Y131.628 E.26588
G1 X77.83 Y131.063 E.00921
G1 X89.937 Y143.17 E.2789
G1 X90.502 Y143.17 E.00921
G1 X77.83 Y130.498 E.29193
G1 X77.83 Y129.932 E.00921
G1 X91.068 Y143.17 E.30495
G1 X91.633 Y143.17 E.00921
G1 X77.83 Y129.367 E.31797
G1 X77.83 Y128.801 E.00921
G1 X92.199 Y143.17 E.331
G1 X92.764 Y143.17 E.00921
G1 X77.83 Y128.236 E.34402
G1 X77.83 Y127.671 E.00921
G1 X93.329 Y143.17 E.35705
G1 X93.895 Y143.17 E.00921
G1 X77.83 Y127.105 E.37007
G1 X77.83 Y126.54 E.00921
G1 X94.46 Y143.17 E.3831
G1 X95.025 Y143.17 E.00921
G1 X77.83 Y125.974 E.39612
G1 X77.83 Y125.409 E.00921
G1 X95.591 Y143.17 E.40914
G1 X96.156 Y143.17 E.00921
G1 X77.83 Y124.844 E.42217
G1 X77.83 Y124.278 E.00921
G1 X96.722 Y143.17 E.43519
G1 X97.287 Y143.17 E.00921
G1 X77.83 Y123.713 E.44822
G1 X77.83 Y123.148 E.00921
G1 X97.852 Y143.17 E.46124
G1 X98.418 Y143.17 E.00921
G1 X77.83 Y122.582 E.47427
G1 X77.83 Y122.017 E.00921
G1 X98.983 Y143.17 E.48729
G1 X99.549 Y143.17 E.00921
G1 X77.83 Y121.451 E.50031
G1 X77.83 Y120.886 E.00921
G1 X100.114 Y143.17 E.51334
G1 X100.679 Y143.17 E.00921
G1 X77.83 Y120.321 E.52636
G1 X77.83 Y119.755 E.00921
G1 X101.245 Y143.17 E.53939
G1 X101.81 Y143.17 E.00921
G1 X77.83 Y119.19 E.55241
G1 X77.83 Y118.624 E.00921
M73 P44 R35
G1 X102.376 Y143.17 E.56544
G1 X102.941 Y143.17 E.00921
G1 X77.83 Y118.059 E.57846
G1 X77.83 Y117.494 E.00921
G1 X103.506 Y143.17 E.59148
G1 X104.072 Y143.17 E.00921
G1 X77.83 Y116.928 E.60451
G1 X77.83 Y116.363 E.00921
G1 X104.637 Y143.17 E.61753
G1 X105.202 Y143.17 E.00921
G1 X77.83 Y115.798 E.63056
G1 X77.83 Y115.232 E.00921
G1 X105.768 Y143.17 E.64358
G1 X106.333 Y143.17 E.00921
G1 X77.83 Y114.667 E.65661
G1 X77.83 Y114.101 E.00921
G1 X106.899 Y143.17 E.66963
G1 X107.464 Y143.17 E.00921
G1 X77.83 Y113.536 E.68265
G1 X77.83 Y112.971 E.00921
G1 X108.029 Y143.17 E.69568
G1 X108.595 Y143.17 E.00921
G1 X77.83 Y112.405 E.7087
G1 X77.83 Y111.84 E.00921
G1 X109.16 Y143.17 E.72173
G1 X109.726 Y143.17 E.00921
G1 X77.83 Y111.274 E.73475
G1 X77.83 Y110.709 E.00921
G1 X110.291 Y143.17 E.74778
G1 X110.856 Y143.17 E.00921
G1 X77.83 Y110.144 E.7608
G1 X77.83 Y109.578 E.00921
G1 X111.422 Y143.17 E.77382
G1 X111.987 Y143.17 E.00921
G1 X77.83 Y109.013 E.78685
G1 X77.83 Y108.83 E.00298
G1 X78.212 Y108.83 E.00623
G1 X112.553 Y143.17 E.79106
G1 X113.118 Y143.17 E.00921
G1 X78.778 Y108.83 E.79106
G1 X79.343 Y108.83 E.00921
G1 X113.683 Y143.17 E.79106
G1 X114.249 Y143.17 E.00921
G1 X79.908 Y108.83 E.79106
G1 X80.474 Y108.83 E.00921
G1 X114.814 Y143.17 E.79106
G1 X115.379 Y143.17 E.00921
G1 X81.039 Y108.83 E.79106
G1 X81.605 Y108.83 E.00921
G1 X115.945 Y143.17 E.79106
G1 X116.51 Y143.17 E.00921
G1 X82.17 Y108.83 E.79106
G1 X82.735 Y108.83 E.00921
G1 X117.076 Y143.17 E.79106
G1 X117.641 Y143.17 E.00921
G1 X83.301 Y108.83 E.79106
G1 X83.866 Y108.83 E.00921
G1 X118.206 Y143.17 E.79106
G1 X118.772 Y143.17 E.00921
G1 X84.431 Y108.83 E.79106
G1 X84.997 Y108.83 E.00921
G1 X119.337 Y143.17 E.79106
G1 X119.903 Y143.17 E.00921
G1 X85.562 Y108.83 E.79106
G1 X86.128 Y108.83 E.00921
G1 X120.468 Y143.17 E.79106
G1 X121.033 Y143.17 E.00921
G1 X86.693 Y108.83 E.79106
G1 X87.258 Y108.83 E.00921
G1 X121.599 Y143.17 E.79106
G1 X122.164 Y143.17 E.00921
G1 X87.824 Y108.83 E.79106
G1 X88.389 Y108.83 E.00921
G1 X122.73 Y143.17 E.79106
G1 X123.295 Y143.17 E.00921
G1 X88.955 Y108.83 E.79106
G1 X89.52 Y108.83 E.00921
G1 X123.86 Y143.17 E.79106
G1 X124.426 Y143.17 E.00921
G1 X90.085 Y108.83 E.79106
G1 X90.651 Y108.83 E.00921
G1 X124.991 Y143.17 E.79106
G1 X125.556 Y143.17 E.00921
G1 X91.216 Y108.83 E.79106
G1 X91.782 Y108.83 E.00921
G1 X126.122 Y143.17 E.79106
G1 X126.687 Y143.17 E.00921
G1 X92.347 Y108.83 E.79106
G1 X92.912 Y108.83 E.00921
G1 X127.253 Y143.17 E.79106
G1 X127.818 Y143.17 E.00921
G1 X93.478 Y108.83 E.79106
G1 X94.043 Y108.83 E.00921
G1 X128.383 Y143.17 E.79106
G1 X128.949 Y143.17 E.00921
G1 X94.608 Y108.83 E.79106
G1 X95.174 Y108.83 E.00921
G1 X129.514 Y143.17 E.79106
G1 X130.08 Y143.17 E.00921
G1 X95.739 Y108.83 E.79106
G1 X96.305 Y108.83 E.00921
G1 X130.645 Y143.17 E.79106
G1 X131.21 Y143.17 E.00921
G1 X96.87 Y108.83 E.79106
M73 P45 R35
G1 X97.435 Y108.83 E.00921
G1 X131.776 Y143.17 E.79106
G1 X132.341 Y143.17 E.00921
G1 X98.001 Y108.83 E.79106
G1 X98.566 Y108.83 E.00921
G1 X132.907 Y143.17 E.79106
G1 X133.472 Y143.17 E.00921
G1 X99.132 Y108.83 E.79106
G1 X99.697 Y108.83 E.00921
G1 X134.037 Y143.17 E.79106
G1 X134.603 Y143.17 E.00921
G1 X100.262 Y108.83 E.79106
G1 X100.828 Y108.83 E.00921
G1 X135.168 Y143.17 E.79106
G1 X135.733 Y143.17 E.00921
G1 X101.393 Y108.83 E.79106
G1 X101.958 Y108.83 E.00921
G1 X136.299 Y143.17 E.79106
G1 X136.864 Y143.17 E.00921
G1 X102.524 Y108.83 E.79106
G1 X103.089 Y108.83 E.00921
G1 X137.43 Y143.17 E.79106
G1 X137.995 Y143.17 E.00921
G1 X103.655 Y108.83 E.79106
G1 X104.22 Y108.83 E.00921
G1 X138.56 Y143.17 E.79106
G1 X139.126 Y143.17 E.00921
G1 X104.785 Y108.83 E.79106
G1 X105.351 Y108.83 E.00921
G1 X139.691 Y143.17 E.79106
G1 X140.257 Y143.17 E.00921
G1 X105.916 Y108.83 E.79106
G1 X106.482 Y108.83 E.00921
G1 X140.822 Y143.17 E.79106
G1 X141.387 Y143.17 E.00921
G1 X107.047 Y108.83 E.79106
G1 X107.612 Y108.83 E.00921
G1 X141.953 Y143.17 E.79106
G1 X142.518 Y143.17 E.00921
G1 X108.178 Y108.83 E.79106
G1 X108.743 Y108.83 E.00921
G1 X143.084 Y143.17 E.79106
G1 X143.649 Y143.17 E.00921
G1 X109.309 Y108.83 E.79106
G1 X109.874 Y108.83 E.00921
G1 X144.214 Y143.17 E.79106
G1 X144.78 Y143.17 E.00921
G1 X110.439 Y108.83 E.79106
G1 X111.005 Y108.83 E.00921
G1 X145.345 Y143.17 E.79106
G1 X145.91 Y143.17 E.00921
G1 X111.57 Y108.83 E.79106
G1 X112.135 Y108.83 E.00921
G1 X146.476 Y143.17 E.79106
G1 X147.041 Y143.17 E.00921
G1 X112.701 Y108.83 E.79106
G1 X113.266 Y108.83 E.00921
G1 X147.607 Y143.17 E.79106
G1 X148.172 Y143.17 E.00921
G1 X113.832 Y108.83 E.79106
G1 X114.397 Y108.83 E.00921
G1 X148.737 Y143.17 E.79106
G1 X149.303 Y143.17 E.00921
G1 X114.962 Y108.83 E.79106
G1 X115.528 Y108.83 E.00921
G1 X149.868 Y143.17 E.79106
G1 X150.434 Y143.17 E.00921
G1 X116.093 Y108.83 E.79106
G1 X116.659 Y108.83 E.00921
G1 X150.999 Y143.17 E.79106
G1 X151.564 Y143.17 E.00921
G1 X117.224 Y108.83 E.79106
G1 X117.789 Y108.83 E.00921
G1 X152.13 Y143.17 E.79106
G1 X152.695 Y143.17 E.00921
G1 X118.355 Y108.83 E.79106
G1 X118.92 Y108.83 E.00921
G1 X153.261 Y143.17 E.79106
G1 X153.826 Y143.17 E.00921
G1 X119.486 Y108.83 E.79106
G1 X120.051 Y108.83 E.00921
G1 X154.391 Y143.17 E.79106
G1 X154.957 Y143.17 E.00921
G1 X120.616 Y108.83 E.79106
G1 X121.182 Y108.83 E.00921
G1 X155.522 Y143.17 E.79106
G1 X156.087 Y143.17 E.00921
G1 X121.747 Y108.83 E.79106
G1 X122.312 Y108.83 E.00921
G1 X156.653 Y143.17 E.79106
G1 X157.218 Y143.17 E.00921
G1 X122.878 Y108.83 E.79106
G1 X123.443 Y108.83 E.00921
G1 X157.784 Y143.17 E.79106
G1 X158.349 Y143.17 E.00921
G1 X124.009 Y108.83 E.79106
G1 X124.574 Y108.83 E.00921
G1 X158.914 Y143.17 E.79106
G1 X159.48 Y143.17 E.00921
G1 X125.139 Y108.83 E.79106
G1 X125.705 Y108.83 E.00921
G1 X160.045 Y143.17 E.79106
G1 X160.611 Y143.17 E.00921
G1 X126.27 Y108.83 E.79106
G1 X126.836 Y108.83 E.00921
G1 X161.176 Y143.17 E.79106
G1 X161.741 Y143.17 E.00921
G1 X127.401 Y108.83 E.79106
G1 X127.966 Y108.83 E.00921
G1 X162.307 Y143.17 E.79106
G1 X162.872 Y143.17 E.00921
G1 X128.532 Y108.83 E.79106
G1 X129.097 Y108.83 E.00921
G1 X163.437 Y143.17 E.79106
G1 X164.003 Y143.17 E.00921
G1 X129.663 Y108.83 E.79106
G1 X130.228 Y108.83 E.00921
G1 X164.568 Y143.17 E.79106
G1 X165.134 Y143.17 E.00921
G1 X130.793 Y108.83 E.79106
G1 X131.359 Y108.83 E.00921
G1 X165.699 Y143.17 E.79106
G1 X166.264 Y143.17 E.00921
G1 X131.924 Y108.83 E.79106
G1 X132.489 Y108.83 E.00921
G1 X166.83 Y143.17 E.79106
G1 X167.395 Y143.17 E.00921
G1 X133.055 Y108.83 E.79106
G1 X133.62 Y108.83 E.00921
G1 X167.961 Y143.17 E.79106
G1 X168.526 Y143.17 E.00921
G1 X134.186 Y108.83 E.79106
G1 X134.751 Y108.83 E.00921
G1 X169.091 Y143.17 E.79106
G1 X169.657 Y143.17 E.00921
M73 P46 R35
G1 X135.316 Y108.83 E.79106
G1 X135.882 Y108.83 E.00921
G1 X170.222 Y143.17 E.79106
G1 X170.788 Y143.17 E.00921
G1 X136.447 Y108.83 E.79106
G1 X137.013 Y108.83 E.00921
M73 P46 R34
G1 X171.353 Y143.17 E.79106
G1 X171.918 Y143.17 E.00921
G1 X137.578 Y108.83 E.79106
G1 X138.143 Y108.83 E.00921
G1 X172.484 Y143.17 E.79106
G1 X173.049 Y143.17 E.00921
G1 X138.709 Y108.83 E.79106
G1 X139.274 Y108.83 E.00921
G1 X173.614 Y143.17 E.79106
G1 X174.18 Y143.17 E.00921
G1 X139.84 Y108.83 E.79106
G1 X140.405 Y108.83 E.00921
G1 X174.745 Y143.17 E.79106
G1 X175.311 Y143.17 E.00921
G1 X140.97 Y108.83 E.79106
G1 X141.536 Y108.83 E.00921
G1 X175.876 Y143.17 E.79106
G1 X176.441 Y143.17 E.00921
G1 X142.101 Y108.83 E.79106
G1 X142.666 Y108.83 E.00921
G1 X177.007 Y143.17 E.79106
G1 X177.572 Y143.17 E.00921
G1 X143.232 Y108.83 E.79106
G1 X143.797 Y108.83 E.00921
G1 X178.138 Y143.17 E.79106
G1 X178.17 Y143.17 E.00053
G1 X178.17 Y142.637 E.00868
G1 X144.363 Y108.83 E.77879
G1 X144.928 Y108.83 E.00921
G1 X178.17 Y142.072 E.76577
G1 X178.17 Y141.507 E.00921
G1 X145.493 Y108.83 E.75274
G1 X146.059 Y108.83 E.00921
G1 X178.17 Y140.941 E.73972
G1 X178.17 Y140.376 E.00921
G1 X146.624 Y108.83 E.72669
G1 X147.19 Y108.83 E.00921
G1 X178.17 Y139.81 E.71367
G1 X178.17 Y139.245 E.00921
G1 X147.755 Y108.83 E.70064
G1 X148.32 Y108.83 E.00921
G1 X178.17 Y138.68 E.68762
G1 X178.17 Y138.114 E.00921
G1 X148.886 Y108.83 E.6746
G1 X149.451 Y108.83 E.00921
G1 X178.17 Y137.549 E.66157
G1 X178.17 Y136.983 E.00921
G1 X150.017 Y108.83 E.64855
G1 X150.582 Y108.83 E.00921
G1 X178.17 Y136.418 E.63552
G1 X178.17 Y135.853 E.00921
G1 X151.147 Y108.83 E.6225
G1 X151.713 Y108.83 E.00921
G1 X178.17 Y135.287 E.60947
G1 X178.17 Y134.722 E.00921
G1 X152.278 Y108.83 E.59645
G1 X152.843 Y108.83 E.00921
G1 X178.17 Y134.157 E.58343
G1 X178.17 Y133.591 E.00921
G1 X153.409 Y108.83 E.5704
G1 X153.974 Y108.83 E.00921
G1 X178.17 Y133.026 E.55738
G1 X178.17 Y132.46 E.00921
G1 X154.54 Y108.83 E.54435
G1 X155.105 Y108.83 E.00921
G1 X178.17 Y131.895 E.53133
G1 X178.17 Y131.33 E.00921
G1 X155.67 Y108.83 E.5183
G1 X156.236 Y108.83 E.00921
G1 X178.17 Y130.764 E.50528
G1 X178.17 Y130.199 E.00921
G1 X156.801 Y108.83 E.49226
G1 X157.367 Y108.83 E.00921
G1 X178.17 Y129.633 E.47923
G1 X178.17 Y129.068 E.00921
G1 X157.932 Y108.83 E.46621
G1 X158.497 Y108.83 E.00921
G1 X178.17 Y128.503 E.45318
G1 X178.17 Y127.937 E.00921
G1 X159.063 Y108.83 E.44016
G1 X159.628 Y108.83 E.00921
G1 X178.17 Y127.372 E.42713
G1 X178.17 Y126.806 E.00921
G1 X160.194 Y108.83 E.41411
G1 X160.759 Y108.83 E.00921
G1 X178.17 Y126.241 E.40109
G1 X178.17 Y125.676 E.00921
G1 X161.324 Y108.83 E.38806
G1 X161.89 Y108.83 E.00921
G1 X178.17 Y125.11 E.37504
G1 X178.17 Y124.545 E.00921
G1 X162.455 Y108.83 E.36201
G1 X163.02 Y108.83 E.00921
G1 X178.17 Y123.98 E.34899
G1 X178.17 Y123.414 E.00921
G1 X163.586 Y108.83 E.33596
G1 X164.151 Y108.83 E.00921
G1 X178.17 Y122.849 E.32294
G1 X178.17 Y122.283 E.00921
G1 X164.717 Y108.83 E.30992
G1 X165.282 Y108.83 E.00921
G1 X178.17 Y121.718 E.29689
G1 X178.17 Y121.153 E.00921
G1 X165.847 Y108.83 E.28387
G1 X166.413 Y108.83 E.00921
G1 X178.17 Y120.587 E.27084
G1 X178.17 Y120.022 E.00921
G1 X166.978 Y108.83 E.25782
G1 X167.544 Y108.83 E.00921
G1 X178.17 Y119.456 E.24479
G1 X178.17 Y118.891 E.00921
G1 X168.109 Y108.83 E.23177
G1 X168.674 Y108.83 E.00921
G1 X178.17 Y118.326 E.21875
G1 X178.17 Y117.76 E.00921
G1 X169.24 Y108.83 E.20572
G1 X169.805 Y108.83 E.00921
G1 X178.17 Y117.195 E.1927
G1 X178.17 Y116.629 E.00921
G1 X170.37 Y108.83 E.17967
G1 X170.936 Y108.83 E.00921
G1 X178.17 Y116.064 E.16665
G1 X178.17 Y115.499 E.00921
G1 X171.501 Y108.83 E.15362
G1 X172.067 Y108.83 E.00921
M73 P47 R34
G1 X178.17 Y114.933 E.1406
G1 X178.17 Y114.368 E.00921
G1 X172.632 Y108.83 E.12758
G1 X173.197 Y108.83 E.00921
G1 X178.17 Y113.803 E.11455
G1 X178.17 Y113.237 E.00921
G1 X173.763 Y108.83 E.10153
G1 X174.328 Y108.83 E.00921
G1 X178.17 Y112.672 E.0885
G1 X178.17 Y112.106 E.00921
G1 X174.894 Y108.83 E.07548
G1 X175.459 Y108.83 E.00921
G1 X178.17 Y111.541 E.06245
G1 X178.17 Y110.976 E.00921
G1 X176.024 Y108.83 E.04943
G1 X176.59 Y108.83 E.00921
G1 X178.17 Y110.41 E.03641
G1 X178.17 Y109.845 E.00921
G1 X177.155 Y108.83 E.02338
G1 X177.721 Y108.83 E.00921
G1 X178.35 Y109.459 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X177.721 Y108.83 E-.338
G1 X177.155 Y108.83 E-.21485
G1 X177.541 Y109.215 E-.20715
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/25
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M204 S10000
G17
G3 Z.9 I-.765 J-.946 P1  F30000
G1 X134.085 Y144.357 Z.9
G1 X51.016 Y211.534
G1 Z.6
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #7
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
M204 S1000
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
G3 Z1 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X76.643 Y110.625
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
M73 P47 R33
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.522 Y108.652 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7200
M204 S1000
G1 X77.845 Y109.329 E.01671
G1 X77.845 Y109.936 E.01061
G1 X78.936 Y108.845 E.02695
G1 X79.544 Y108.845 E.01061
G1 X77.845 Y110.544 E.04195
G1 X77.845 Y111.151 E.01061
G1 X80.151 Y108.845 E.05695
G1 X80.759 Y108.845 E.01061
G1 X77.845 Y111.759 E.07195
G1 X77.845 Y112.366 E.01061
G1 X81.366 Y108.845 E.08696
G1 X81.974 Y108.845 E.01061
G1 X77.845 Y112.974 E.10196
G1 X77.845 Y113.581 E.01061
G1 X82.581 Y108.845 E.11696
G1 X83.189 Y108.845 E.01061
G1 X77.845 Y114.189 E.13196
G1 X77.845 Y114.796 E.01061
G1 X83.796 Y108.845 E.14696
G1 X84.404 Y108.845 E.01061
G1 X77.845 Y115.404 E.16196
G1 X77.845 Y116.011 E.01061
G1 X85.011 Y108.845 E.17696
G1 X85.619 Y108.845 E.01061
G1 X77.845 Y116.619 E.19196
G1 X77.845 Y117.227 E.01061
G1 X86.226 Y108.845 E.20696
G1 X86.834 Y108.845 E.01061
G1 X77.845 Y117.834 E.22197
G1 X77.845 Y118.442 E.01061
G1 X87.442 Y108.845 E.23697
G1 X88.049 Y108.845 E.01061
G1 X77.845 Y119.049 E.25197
G1 X77.845 Y119.657 E.01061
G1 X88.657 Y108.845 E.26697
G1 X89.264 Y108.845 E.01061
G1 X77.845 Y120.264 E.28197
G1 X77.845 Y120.872 E.01061
G1 X89.872 Y108.845 E.29697
G1 X90.479 Y108.845 E.01061
G1 X77.845 Y121.479 E.31197
G1 X77.845 Y122.087 E.01061
G1 X91.087 Y108.845 E.32697
G1 X91.694 Y108.845 E.01061
G1 X77.845 Y122.694 E.34198
G1 X77.845 Y123.302 E.01061
G1 X92.302 Y108.845 E.35698
G1 X92.909 Y108.845 E.01061
G1 X77.845 Y123.909 E.37198
G1 X77.845 Y124.517 E.01061
G1 X93.517 Y108.845 E.38698
G1 X94.124 Y108.845 E.01061
G1 X77.845 Y125.124 E.40198
G1 X77.845 Y125.732 E.01061
G1 X94.732 Y108.845 E.41698
G1 X95.339 Y108.845 E.01061
G1 X77.845 Y126.339 E.43198
G1 X77.845 Y126.947 E.01061
G1 X95.947 Y108.845 E.44698
G1 X96.554 Y108.845 E.01061
G1 X77.845 Y127.554 E.46198
G1 X77.845 Y128.162 E.01061
G1 X97.162 Y108.845 E.47699
G1 X97.769 Y108.845 E.01061
G1 X77.845 Y128.769 E.49199
G1 X77.845 Y129.377 E.01061
G1 X98.377 Y108.845 E.50699
G1 X98.984 Y108.845 E.01061
G1 X77.845 Y129.984 E.52199
G1 X77.845 Y130.592 E.01061
G1 X99.592 Y108.845 E.53699
G1 X100.199 Y108.845 E.01061
G1 X77.845 Y131.199 E.55199
G1 X77.845 Y131.807 E.01061
G1 X100.807 Y108.845 E.56699
G1 X101.414 Y108.845 E.01061
G1 X77.845 Y132.414 E.58199
G1 X77.845 Y133.022 E.01061
G1 X102.022 Y108.845 E.597
G1 X102.629 Y108.845 E.01061
G1 X77.845 Y133.629 E.612
G1 X77.845 Y134.237 E.01061
G1 X103.237 Y108.845 E.627
G1 X103.845 Y108.845 E.01061
G1 X77.845 Y134.845 E.642
G1 X77.845 Y135.452 E.01061
M73 P48 R33
G1 X104.452 Y108.845 E.657
G1 X105.06 Y108.845 E.01061
G1 X77.845 Y136.06 E.672
G1 X77.845 Y136.667 E.01061
G1 X105.667 Y108.845 E.687
G1 X106.275 Y108.845 E.01061
G1 X77.845 Y137.275 E.702
G1 X77.845 Y137.882 E.01061
G1 X106.882 Y108.845 E.71701
G1 X107.49 Y108.845 E.01061
G1 X77.845 Y138.49 E.73201
G1 X77.845 Y139.097 E.01061
G1 X108.097 Y108.845 E.74701
G1 X108.705 Y108.845 E.01061
G1 X77.845 Y139.705 E.76201
G1 X77.845 Y140.312 E.01061
G1 X109.312 Y108.845 E.77701
G1 X109.92 Y108.845 E.01061
G1 X77.845 Y140.92 E.79201
G2 X77.991 Y141.382 I.304 J.158 E.00939
G1 X110.527 Y108.845 E.80341
G1 X111.135 Y108.845 E.01061
G1 X78.294 Y141.685 E.81092
G1 X78.598 Y141.989 E.0075
G1 X111.742 Y108.845 E.81842
G1 X112.35 Y108.845 E.01061
G1 X78.902 Y142.293 E.82592
G1 X79.206 Y142.597 E.0075
G1 X112.957 Y108.845 E.83342
G1 X113.565 Y108.845 E.01061
G1 X79.509 Y142.9 E.84092
G1 X79.764 Y143.155 E.00629
G1 X79.862 Y143.155 E.00171
G1 X114.172 Y108.845 E.84721
G1 X114.78 Y108.845 E.01061
G1 X80.469 Y143.155 E.84721
G1 X81.077 Y143.155 E.01061
G1 X115.387 Y108.845 E.84721
G1 X115.995 Y108.845 E.01061
G1 X81.685 Y143.155 E.84721
G1 X82.292 Y143.155 E.01061
G1 X116.602 Y108.845 E.84721
G1 X117.21 Y108.845 E.01061
G1 X82.9 Y143.155 E.84721
G1 X83.507 Y143.155 E.01061
G1 X117.817 Y108.845 E.84721
G1 X118.425 Y108.845 E.01061
G1 X84.115 Y143.155 E.84721
G1 X84.722 Y143.155 E.01061
G1 X119.032 Y108.845 E.84721
G1 X119.64 Y108.845 E.01061
G1 X85.33 Y143.155 E.84721
G1 X85.937 Y143.155 E.01061
G1 X120.248 Y108.845 E.84721
G1 X120.855 Y108.845 E.01061
G1 X86.545 Y143.155 E.84721
G1 X87.152 Y143.155 E.01061
G1 X121.463 Y108.845 E.84721
G1 X122.07 Y108.845 E.01061
G1 X87.76 Y143.155 E.84721
G1 X88.367 Y143.155 E.01061
G1 X122.678 Y108.845 E.84721
G1 X123.285 Y108.845 E.01061
G1 X88.975 Y143.155 E.84721
G1 X89.582 Y143.155 E.01061
G1 X123.893 Y108.845 E.84721
G1 X124.5 Y108.845 E.01061
G1 X90.19 Y143.155 E.84721
G1 X90.797 Y143.155 E.01061
G1 X125.108 Y108.845 E.84721
G1 X125.715 Y108.845 E.01061
G1 X91.405 Y143.155 E.84721
G1 X92.012 Y143.155 E.01061
G1 X126.323 Y108.845 E.84721
G1 X126.93 Y108.845 E.01061
G1 X92.62 Y143.155 E.84721
G1 X93.227 Y143.155 E.01061
G1 X127.538 Y108.845 E.84721
G1 X128.145 Y108.845 E.01061
G1 X93.835 Y143.155 E.84721
G1 X94.442 Y143.155 E.01061
G1 X128.753 Y108.845 E.84721
G1 X129.36 Y108.845 E.01061
G1 X95.05 Y143.155 E.84721
G1 X95.657 Y143.155 E.01061
G1 X129.968 Y108.845 E.84721
G1 X130.575 Y108.845 E.01061
G1 X96.265 Y143.155 E.84721
G1 X96.872 Y143.155 E.01061
G1 X131.183 Y108.845 E.84721
G1 X131.79 Y108.845 E.01061
G1 X97.48 Y143.155 E.84721
G1 X98.088 Y143.155 E.01061
G1 X132.398 Y108.845 E.84721
G1 X133.005 Y108.845 E.01061
G1 X98.695 Y143.155 E.84721
G1 X99.303 Y143.155 E.01061
G1 X133.613 Y108.845 E.84721
G1 X134.22 Y108.845 E.01061
G1 X99.91 Y143.155 E.84721
G1 X100.518 Y143.155 E.01061
G1 X134.828 Y108.845 E.84721
G1 X135.435 Y108.845 E.01061
G1 X101.125 Y143.155 E.84721
G1 X101.733 Y143.155 E.01061
G1 X136.043 Y108.845 E.84721
G1 X136.65 Y108.845 E.01061
G1 X102.34 Y143.155 E.84721
G1 X102.948 Y143.155 E.01061
G1 X137.258 Y108.845 E.84721
G1 X137.866 Y108.845 E.01061
G1 X103.555 Y143.155 E.84721
G1 X104.163 Y143.155 E.01061
G1 X138.473 Y108.845 E.84721
G1 X139.081 Y108.845 E.01061
G1 X104.77 Y143.155 E.84721
G1 X105.378 Y143.155 E.01061
G1 X139.688 Y108.845 E.84721
G1 X140.296 Y108.845 E.01061
G1 X105.985 Y143.155 E.84721
G1 X106.593 Y143.155 E.01061
G1 X140.903 Y108.845 E.84721
G1 X141.511 Y108.845 E.01061
G1 X107.2 Y143.155 E.84721
G1 X107.808 Y143.155 E.01061
G1 X142.118 Y108.845 E.84721
G1 X142.726 Y108.845 E.01061
G1 X108.415 Y143.155 E.84721
G1 X109.023 Y143.155 E.01061
G1 X143.333 Y108.845 E.84721
G1 X143.941 Y108.845 E.01061
G1 X109.63 Y143.155 E.84721
G1 X110.238 Y143.155 E.01061
G1 X144.548 Y108.845 E.84721
G1 X145.156 Y108.845 E.01061
G1 X110.845 Y143.155 E.84721
G1 X111.453 Y143.155 E.01061
G1 X145.763 Y108.845 E.84721
G1 X146.371 Y108.845 E.01061
G1 X112.06 Y143.155 E.84721
G1 X112.668 Y143.155 E.01061
G1 X146.978 Y108.845 E.84721
G1 X147.586 Y108.845 E.01061
G1 X113.275 Y143.155 E.84721
G1 X113.883 Y143.155 E.01061
G1 X148.193 Y108.845 E.84721
G1 X148.801 Y108.845 E.01061
G1 X114.49 Y143.155 E.84721
G1 X115.098 Y143.155 E.01061
G1 X149.408 Y108.845 E.84721
G1 X150.016 Y108.845 E.01061
G1 X115.706 Y143.155 E.84721
G1 X116.313 Y143.155 E.01061
G1 X150.623 Y108.845 E.84721
G1 X151.231 Y108.845 E.01061
G1 X116.921 Y143.155 E.84721
G1 X117.528 Y143.155 E.01061
G1 X151.838 Y108.845 E.84721
G1 X152.446 Y108.845 E.01061
G1 X118.136 Y143.155 E.84721
G1 X118.743 Y143.155 E.01061
G1 X153.053 Y108.845 E.84721
G1 X153.661 Y108.845 E.01061
G1 X119.351 Y143.155 E.84721
G1 X119.958 Y143.155 E.01061
G1 X154.269 Y108.845 E.84721
G1 X154.876 Y108.845 E.01061
G1 X120.566 Y143.155 E.84721
G1 X121.173 Y143.155 E.01061
G1 X155.484 Y108.845 E.84721
G1 X156.091 Y108.845 E.01061
G1 X121.781 Y143.155 E.84721
G1 X122.388 Y143.155 E.01061
G1 X156.699 Y108.845 E.84721
G1 X157.306 Y108.845 E.01061
G1 X122.996 Y143.155 E.84721
G1 X123.603 Y143.155 E.01061
G1 X157.914 Y108.845 E.84721
G1 X158.521 Y108.845 E.01061
G1 X124.211 Y143.155 E.84721
G1 X124.818 Y143.155 E.01061
G1 X159.129 Y108.845 E.84721
G1 X159.736 Y108.845 E.01061
M73 P49 R33
G1 X125.426 Y143.155 E.84721
G1 X126.033 Y143.155 E.01061
G1 X160.344 Y108.845 E.84721
G1 X160.951 Y108.845 E.01061
G1 X126.641 Y143.155 E.84721
G1 X127.248 Y143.155 E.01061
G1 X161.559 Y108.845 E.84721
G1 X162.166 Y108.845 E.01061
G1 X127.856 Y143.155 E.84721
G1 X128.463 Y143.155 E.01061
G1 X162.774 Y108.845 E.84721
G1 X163.381 Y108.845 E.01061
G1 X129.071 Y143.155 E.84721
G1 X129.678 Y143.155 E.01061
G1 X163.989 Y108.845 E.84721
G1 X164.596 Y108.845 E.01061
G1 X130.286 Y143.155 E.84721
G1 X130.893 Y143.155 E.01061
M73 P49 R32
G1 X165.204 Y108.845 E.84721
G1 X165.811 Y108.845 E.01061
G1 X131.501 Y143.155 E.84721
G1 X132.109 Y143.155 E.01061
G1 X166.419 Y108.845 E.84721
G1 X167.026 Y108.845 E.01061
G1 X132.716 Y143.155 E.84721
G1 X133.324 Y143.155 E.01061
G1 X167.634 Y108.845 E.84721
G1 X168.241 Y108.845 E.01061
G1 X133.931 Y143.155 E.84721
G1 X134.539 Y143.155 E.01061
G1 X168.849 Y108.845 E.84721
G1 X169.456 Y108.845 E.01061
G1 X135.146 Y143.155 E.84721
G1 X135.754 Y143.155 E.01061
G1 X170.064 Y108.845 E.84721
G1 X170.671 Y108.845 E.01061
G1 X136.361 Y143.155 E.84721
G1 X136.969 Y143.155 E.01061
G1 X171.279 Y108.845 E.84721
G1 X171.887 Y108.845 E.01061
G1 X137.576 Y143.155 E.84721
G1 X138.184 Y143.155 E.01061
G1 X172.494 Y108.845 E.84721
G1 X173.102 Y108.845 E.01061
G1 X138.791 Y143.155 E.84721
G1 X139.399 Y143.155 E.01061
G1 X173.709 Y108.845 E.84721
G1 X174.317 Y108.845 E.01061
G1 X140.006 Y143.155 E.84721
G1 X140.614 Y143.155 E.01061
G1 X174.924 Y108.845 E.84721
G1 X175.532 Y108.845 E.01061
G1 X141.221 Y143.155 E.84721
G1 X141.829 Y143.155 E.01061
G1 X176.139 Y108.845 E.84721
G1 X176.747 Y108.845 E.01061
G1 X142.436 Y143.155 E.84721
G1 X143.044 Y143.155 E.01061
G1 X177.354 Y108.845 E.84721
G1 X177.962 Y108.845 E.01061
G1 X143.651 Y143.155 E.84721
G1 X144.259 Y143.155 E.01061
G1 X178.155 Y109.259 E.83699
G1 X178.155 Y109.866 E.01061
G1 X144.866 Y143.155 E.82199
G1 X145.474 Y143.155 E.01061
G1 X178.155 Y110.474 E.80698
G1 X178.155 Y111.081 E.01061
G1 X146.081 Y143.155 E.79198
G1 X146.689 Y143.155 E.01061
G1 X178.155 Y111.689 E.77698
G1 X178.155 Y112.296 E.01061
G1 X147.296 Y143.155 E.76198
G1 X147.904 Y143.155 E.01061
G1 X178.155 Y112.904 E.74698
G1 X178.155 Y113.512 E.01061
G1 X148.511 Y143.155 E.73198
G1 X149.119 Y143.155 E.01061
G1 X178.155 Y114.119 E.71698
G1 X178.155 Y114.727 E.01061
G1 X149.727 Y143.155 E.70198
G1 X150.334 Y143.155 E.01061
G1 X178.155 Y115.334 E.68698
G1 X178.155 Y115.942 E.01061
G1 X150.942 Y143.155 E.67197
G1 X151.549 Y143.155 E.01061
G1 X178.155 Y116.549 E.65697
G1 X178.155 Y117.157 E.01061
G1 X152.157 Y143.155 E.64197
G1 X152.764 Y143.155 E.01061
G1 X178.155 Y117.764 E.62697
G1 X178.155 Y118.372 E.01061
G1 X153.372 Y143.155 E.61197
G1 X153.979 Y143.155 E.01061
G1 X178.155 Y118.979 E.59697
G1 X178.155 Y119.587 E.01061
G1 X154.587 Y143.155 E.58197
G1 X155.194 Y143.155 E.01061
G1 X178.155 Y120.194 E.56697
G1 X178.155 Y120.802 E.01061
G1 X155.802 Y143.155 E.55196
G1 X156.409 Y143.155 E.01061
G1 X178.155 Y121.409 E.53696
G1 X178.155 Y122.017 E.01061
G1 X157.017 Y143.155 E.52196
G1 X157.624 Y143.155 E.01061
G1 X178.155 Y122.624 E.50696
G1 X178.155 Y123.232 E.01061
G1 X158.232 Y143.155 E.49196
G1 X158.839 Y143.155 E.01061
G1 X178.155 Y123.839 E.47696
G1 X178.155 Y124.447 E.01061
G1 X159.447 Y143.155 E.46196
G1 X160.054 Y143.155 E.01061
G1 X178.155 Y125.054 E.44696
G1 X178.155 Y125.662 E.01061
G1 X160.662 Y143.155 E.43195
G1 X161.269 Y143.155 E.01061
G1 X178.155 Y126.269 E.41695
G1 X178.155 Y126.877 E.01061
G1 X161.877 Y143.155 E.40195
G1 X162.484 Y143.155 E.01061
G1 X178.155 Y127.484 E.38695
G1 X178.155 Y128.092 E.01061
G1 X163.092 Y143.155 E.37195
G1 X163.699 Y143.155 E.01061
G1 X178.155 Y128.699 E.35695
G1 X178.155 Y129.307 E.01061
G1 X164.307 Y143.155 E.34195
G1 X164.914 Y143.155 E.01061
G1 X178.155 Y129.914 E.32695
G1 X178.155 Y130.522 E.01061
G1 X165.522 Y143.155 E.31195
G1 X166.13 Y143.155 E.01061
G1 X178.155 Y131.13 E.29694
G1 X178.155 Y131.737 E.01061
G1 X166.737 Y143.155 E.28194
G1 X167.345 Y143.155 E.01061
G1 X178.155 Y132.345 E.26694
G1 X178.155 Y132.952 E.01061
G1 X167.952 Y143.155 E.25194
G1 X168.56 Y143.155 E.01061
G1 X178.155 Y133.56 E.23694
G1 X178.155 Y134.167 E.01061
G1 X169.167 Y143.155 E.22194
G1 X169.775 Y143.155 E.01061
M73 P50 R32
G1 X178.155 Y134.775 E.20694
G1 X178.155 Y135.382 E.01061
G1 X170.382 Y143.155 E.19194
G1 X170.99 Y143.155 E.01061
G1 X178.155 Y135.99 E.17693
G1 X178.155 Y136.597 E.01061
G1 X171.597 Y143.155 E.16193
G1 X172.205 Y143.155 E.01061
G1 X178.155 Y137.205 E.14693
G1 X178.155 Y137.812 E.01061
G1 X172.812 Y143.155 E.13193
G1 X173.42 Y143.155 E.01061
G1 X178.155 Y138.42 E.11693
G1 X178.155 Y139.027 E.01061
G1 X174.027 Y143.155 E.10193
G1 X174.635 Y143.155 E.01061
G1 X178.155 Y139.635 E.08693
G1 X178.155 Y140.242 E.01061
G1 X175.242 Y143.155 E.07193
G1 X175.85 Y143.155 E.01061
G1 X178.155 Y140.85 E.05693
G1 X178.155 Y141.457 E.01061
G1 X176.457 Y143.155 E.04192
G1 X177.065 Y143.155 E.01061
G1 X178.155 Y142.065 E.02692
G1 X178.155 Y142.672 E.01061
G1 X177.48 Y143.348 E.01668
; CHANGE_LAYER
; Z_HEIGHT: 0.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F7200
G1 X178.155 Y142.672 E-.3631
G1 X178.155 Y142.065 E-.23085
G1 X177.846 Y142.374 E-.16605
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/25
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
M204 S10000
G17
G3 Z1 I-.583 J-1.068 P1  F30000
G1 X174.209 Y144.357 Z1
G1 X51.016 Y211.534
G1 Z.7
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #8
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
G1 F7200
M204 S1000
G1 X51.516 Y185.034 E0
G1 X51.516 Y185.034 E0
G1 X50.102 Y183.619 E-.75999
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.1 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.084 Y114.9 Z1.1 F30000
G1 X77.65 Y141.061 Z1.1
G1 Z.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X79.76 Y143.17 E.0486
G1 X80.325 Y143.17 E.00921
G1 X77.83 Y140.675 E.05749
G1 X77.83 Y140.109 E.00921
G1 X80.891 Y143.17 E.07051
G1 X81.456 Y143.17 E.00921
G1 X77.83 Y139.544 E.08354
G1 X77.83 Y138.978 E.00921
G1 X82.022 Y143.17 E.09656
G1 X82.587 Y143.17 E.00921
G1 X77.83 Y138.413 E.10959
G1 X77.83 Y137.848 E.00921
G1 X83.152 Y143.17 E.12261
G1 X83.718 Y143.17 E.00921
G1 X77.83 Y137.282 E.13563
G1 X77.83 Y136.717 E.00921
G1 X84.283 Y143.17 E.14866
G1 X84.849 Y143.17 E.00921
M73 P50 R31
G1 X77.83 Y136.151 E.16168
G1 X77.83 Y135.586 E.00921
G1 X85.414 Y143.17 E.17471
G1 X85.979 Y143.17 E.00921
G1 X77.83 Y135.021 E.18773
G1 X77.83 Y134.455 E.00921
G1 X86.545 Y143.17 E.20076
G1 X87.11 Y143.17 E.00921
G1 X77.83 Y133.89 E.21378
G1 X77.83 Y133.325 E.00921
G1 X87.675 Y143.17 E.2268
G1 X88.241 Y143.17 E.00921
G1 X77.83 Y132.759 E.23983
G1 X77.83 Y132.194 E.00921
G1 X88.806 Y143.17 E.25285
G1 X89.372 Y143.17 E.00921
G1 X77.83 Y131.628 E.26588
G1 X77.83 Y131.063 E.00921
G1 X89.937 Y143.17 E.2789
G1 X90.502 Y143.17 E.00921
G1 X77.83 Y130.498 E.29193
G1 X77.83 Y129.932 E.00921
G1 X91.068 Y143.17 E.30495
G1 X91.633 Y143.17 E.00921
G1 X77.83 Y129.367 E.31797
G1 X77.83 Y128.801 E.00921
G1 X92.199 Y143.17 E.331
G1 X92.764 Y143.17 E.00921
G1 X77.83 Y128.236 E.34402
G1 X77.83 Y127.671 E.00921
G1 X93.329 Y143.17 E.35705
G1 X93.895 Y143.17 E.00921
G1 X77.83 Y127.105 E.37007
G1 X77.83 Y126.54 E.00921
G1 X94.46 Y143.17 E.3831
G1 X95.025 Y143.17 E.00921
G1 X77.83 Y125.974 E.39612
G1 X77.83 Y125.409 E.00921
G1 X95.591 Y143.17 E.40914
G1 X96.156 Y143.17 E.00921
G1 X77.83 Y124.844 E.42217
G1 X77.83 Y124.278 E.00921
G1 X96.722 Y143.17 E.43519
G1 X97.287 Y143.17 E.00921
G1 X77.83 Y123.713 E.44822
G1 X77.83 Y123.148 E.00921
G1 X97.852 Y143.17 E.46124
G1 X98.418 Y143.17 E.00921
G1 X77.83 Y122.582 E.47427
G1 X77.83 Y122.017 E.00921
G1 X98.983 Y143.17 E.48729
G1 X99.549 Y143.17 E.00921
G1 X77.83 Y121.451 E.50031
G1 X77.83 Y120.886 E.00921
G1 X100.114 Y143.17 E.51334
G1 X100.679 Y143.17 E.00921
G1 X77.83 Y120.321 E.52636
G1 X77.83 Y119.755 E.00921
G1 X101.245 Y143.17 E.53939
G1 X101.81 Y143.17 E.00921
G1 X77.83 Y119.19 E.55241
G1 X77.83 Y118.624 E.00921
G1 X102.376 Y143.17 E.56544
G1 X102.941 Y143.17 E.00921
G1 X77.83 Y118.059 E.57846
G1 X77.83 Y117.494 E.00921
G1 X103.506 Y143.17 E.59148
M73 P51 R31
G1 X104.072 Y143.17 E.00921
G1 X77.83 Y116.928 E.60451
G1 X77.83 Y116.363 E.00921
G1 X104.637 Y143.17 E.61753
G1 X105.202 Y143.17 E.00921
G1 X77.83 Y115.798 E.63056
G1 X77.83 Y115.232 E.00921
G1 X105.768 Y143.17 E.64358
G1 X106.333 Y143.17 E.00921
G1 X77.83 Y114.667 E.65661
G1 X77.83 Y114.101 E.00921
G1 X106.899 Y143.17 E.66963
G1 X107.464 Y143.17 E.00921
G1 X77.83 Y113.536 E.68265
G1 X77.83 Y112.971 E.00921
G1 X108.029 Y143.17 E.69568
G1 X108.595 Y143.17 E.00921
G1 X77.83 Y112.405 E.7087
G1 X77.83 Y111.84 E.00921
G1 X109.16 Y143.17 E.72173
G1 X109.726 Y143.17 E.00921
G1 X77.83 Y111.274 E.73475
G1 X77.83 Y110.709 E.00921
G1 X110.291 Y143.17 E.74778
G1 X110.856 Y143.17 E.00921
G1 X77.83 Y110.144 E.7608
G1 X77.83 Y109.578 E.00921
G1 X111.422 Y143.17 E.77382
G1 X111.987 Y143.17 E.00921
G1 X77.83 Y109.013 E.78685
G1 X77.83 Y108.83 E.00298
G1 X78.212 Y108.83 E.00623
G1 X112.553 Y143.17 E.79106
G1 X113.118 Y143.17 E.00921
G1 X78.778 Y108.83 E.79106
G1 X79.343 Y108.83 E.00921
G1 X113.683 Y143.17 E.79106
G1 X114.249 Y143.17 E.00921
G1 X79.908 Y108.83 E.79106
G1 X80.474 Y108.83 E.00921
G1 X114.814 Y143.17 E.79106
G1 X115.379 Y143.17 E.00921
G1 X81.039 Y108.83 E.79106
G1 X81.605 Y108.83 E.00921
G1 X115.945 Y143.17 E.79106
G1 X116.51 Y143.17 E.00921
G1 X82.17 Y108.83 E.79106
G1 X82.735 Y108.83 E.00921
G1 X117.076 Y143.17 E.79106
G1 X117.641 Y143.17 E.00921
G1 X83.301 Y108.83 E.79106
G1 X83.866 Y108.83 E.00921
G1 X118.206 Y143.17 E.79106
G1 X118.772 Y143.17 E.00921
G1 X84.431 Y108.83 E.79106
G1 X84.997 Y108.83 E.00921
G1 X119.337 Y143.17 E.79106
G1 X119.903 Y143.17 E.00921
G1 X85.562 Y108.83 E.79106
G1 X86.128 Y108.83 E.00921
G1 X120.468 Y143.17 E.79106
G1 X121.033 Y143.17 E.00921
G1 X86.693 Y108.83 E.79106
G1 X87.258 Y108.83 E.00921
G1 X121.599 Y143.17 E.79106
G1 X122.164 Y143.17 E.00921
G1 X87.824 Y108.83 E.79106
G1 X88.389 Y108.83 E.00921
G1 X122.73 Y143.17 E.79106
G1 X123.295 Y143.17 E.00921
G1 X88.955 Y108.83 E.79106
G1 X89.52 Y108.83 E.00921
G1 X123.86 Y143.17 E.79106
G1 X124.426 Y143.17 E.00921
G1 X90.085 Y108.83 E.79106
G1 X90.651 Y108.83 E.00921
G1 X124.991 Y143.17 E.79106
G1 X125.556 Y143.17 E.00921
G1 X91.216 Y108.83 E.79106
G1 X91.782 Y108.83 E.00921
G1 X126.122 Y143.17 E.79106
G1 X126.687 Y143.17 E.00921
G1 X92.347 Y108.83 E.79106
G1 X92.912 Y108.83 E.00921
G1 X127.253 Y143.17 E.79106
G1 X127.818 Y143.17 E.00921
G1 X93.478 Y108.83 E.79106
G1 X94.043 Y108.83 E.00921
G1 X128.383 Y143.17 E.79106
G1 X128.949 Y143.17 E.00921
G1 X94.608 Y108.83 E.79106
G1 X95.174 Y108.83 E.00921
G1 X129.514 Y143.17 E.79106
G1 X130.08 Y143.17 E.00921
G1 X95.739 Y108.83 E.79106
G1 X96.305 Y108.83 E.00921
G1 X130.645 Y143.17 E.79106
G1 X131.21 Y143.17 E.00921
G1 X96.87 Y108.83 E.79106
G1 X97.435 Y108.83 E.00921
G1 X131.776 Y143.17 E.79106
G1 X132.341 Y143.17 E.00921
G1 X98.001 Y108.83 E.79106
G1 X98.566 Y108.83 E.00921
G1 X132.907 Y143.17 E.79106
G1 X133.472 Y143.17 E.00921
G1 X99.132 Y108.83 E.79106
G1 X99.697 Y108.83 E.00921
G1 X134.037 Y143.17 E.79106
G1 X134.603 Y143.17 E.00921
G1 X100.262 Y108.83 E.79106
G1 X100.828 Y108.83 E.00921
G1 X135.168 Y143.17 E.79106
G1 X135.733 Y143.17 E.00921
G1 X101.393 Y108.83 E.79106
G1 X101.958 Y108.83 E.00921
G1 X136.299 Y143.17 E.79106
G1 X136.864 Y143.17 E.00921
G1 X102.524 Y108.83 E.79106
G1 X103.089 Y108.83 E.00921
G1 X137.43 Y143.17 E.79106
G1 X137.995 Y143.17 E.00921
G1 X103.655 Y108.83 E.79106
G1 X104.22 Y108.83 E.00921
G1 X138.56 Y143.17 E.79106
G1 X139.126 Y143.17 E.00921
G1 X104.785 Y108.83 E.79106
G1 X105.351 Y108.83 E.00921
G1 X139.691 Y143.17 E.79106
G1 X140.257 Y143.17 E.00921
G1 X105.916 Y108.83 E.79106
G1 X106.482 Y108.83 E.00921
G1 X140.822 Y143.17 E.79106
G1 X141.387 Y143.17 E.00921
G1 X107.047 Y108.83 E.79106
G1 X107.612 Y108.83 E.00921
G1 X141.953 Y143.17 E.79106
G1 X142.518 Y143.17 E.00921
G1 X108.178 Y108.83 E.79106
G1 X108.743 Y108.83 E.00921
G1 X143.084 Y143.17 E.79106
G1 X143.649 Y143.17 E.00921
G1 X109.309 Y108.83 E.79106
G1 X109.874 Y108.83 E.00921
G1 X144.214 Y143.17 E.79106
G1 X144.78 Y143.17 E.00921
G1 X110.439 Y108.83 E.79106
G1 X111.005 Y108.83 E.00921
G1 X145.345 Y143.17 E.79106
G1 X145.91 Y143.17 E.00921
G1 X111.57 Y108.83 E.79106
G1 X112.135 Y108.83 E.00921
G1 X146.476 Y143.17 E.79106
G1 X147.041 Y143.17 E.00921
G1 X112.701 Y108.83 E.79106
G1 X113.266 Y108.83 E.00921
G1 X147.607 Y143.17 E.79106
G1 X148.172 Y143.17 E.00921
G1 X113.832 Y108.83 E.79106
G1 X114.397 Y108.83 E.00921
G1 X148.737 Y143.17 E.79106
G1 X149.303 Y143.17 E.00921
G1 X114.962 Y108.83 E.79106
G1 X115.528 Y108.83 E.00921
G1 X149.868 Y143.17 E.79106
G1 X150.434 Y143.17 E.00921
G1 X116.093 Y108.83 E.79106
G1 X116.659 Y108.83 E.00921
G1 X150.999 Y143.17 E.79106
G1 X151.564 Y143.17 E.00921
G1 X117.224 Y108.83 E.79106
G1 X117.789 Y108.83 E.00921
G1 X152.13 Y143.17 E.79106
G1 X152.695 Y143.17 E.00921
M73 P52 R31
G1 X118.355 Y108.83 E.79106
G1 X118.92 Y108.83 E.00921
G1 X153.261 Y143.17 E.79106
G1 X153.826 Y143.17 E.00921
G1 X119.486 Y108.83 E.79106
G1 X120.051 Y108.83 E.00921
G1 X154.391 Y143.17 E.79106
G1 X154.957 Y143.17 E.00921
G1 X120.616 Y108.83 E.79106
G1 X121.182 Y108.83 E.00921
G1 X155.522 Y143.17 E.79106
G1 X156.087 Y143.17 E.00921
G1 X121.747 Y108.83 E.79106
G1 X122.312 Y108.83 E.00921
G1 X156.653 Y143.17 E.79106
G1 X157.218 Y143.17 E.00921
G1 X122.878 Y108.83 E.79106
G1 X123.443 Y108.83 E.00921
G1 X157.784 Y143.17 E.79106
G1 X158.349 Y143.17 E.00921
G1 X124.009 Y108.83 E.79106
G1 X124.574 Y108.83 E.00921
G1 X158.914 Y143.17 E.79106
G1 X159.48 Y143.17 E.00921
G1 X125.139 Y108.83 E.79106
G1 X125.705 Y108.83 E.00921
G1 X160.045 Y143.17 E.79106
G1 X160.611 Y143.17 E.00921
M73 P52 R30
G1 X126.27 Y108.83 E.79106
G1 X126.836 Y108.83 E.00921
G1 X161.176 Y143.17 E.79106
G1 X161.741 Y143.17 E.00921
G1 X127.401 Y108.83 E.79106
G1 X127.966 Y108.83 E.00921
G1 X162.307 Y143.17 E.79106
G1 X162.872 Y143.17 E.00921
G1 X128.532 Y108.83 E.79106
G1 X129.097 Y108.83 E.00921
G1 X163.437 Y143.17 E.79106
G1 X164.003 Y143.17 E.00921
G1 X129.663 Y108.83 E.79106
G1 X130.228 Y108.83 E.00921
G1 X164.568 Y143.17 E.79106
G1 X165.134 Y143.17 E.00921
G1 X130.793 Y108.83 E.79106
G1 X131.359 Y108.83 E.00921
G1 X165.699 Y143.17 E.79106
G1 X166.264 Y143.17 E.00921
G1 X131.924 Y108.83 E.79106
G1 X132.489 Y108.83 E.00921
G1 X166.83 Y143.17 E.79106
G1 X167.395 Y143.17 E.00921
G1 X133.055 Y108.83 E.79106
G1 X133.62 Y108.83 E.00921
G1 X167.961 Y143.17 E.79106
G1 X168.526 Y143.17 E.00921
G1 X134.186 Y108.83 E.79106
G1 X134.751 Y108.83 E.00921
G1 X169.091 Y143.17 E.79106
G1 X169.657 Y143.17 E.00921
G1 X135.316 Y108.83 E.79106
G1 X135.882 Y108.83 E.00921
G1 X170.222 Y143.17 E.79106
G1 X170.788 Y143.17 E.00921
G1 X136.447 Y108.83 E.79106
G1 X137.013 Y108.83 E.00921
G1 X171.353 Y143.17 E.79106
G1 X171.918 Y143.17 E.00921
G1 X137.578 Y108.83 E.79106
G1 X138.143 Y108.83 E.00921
G1 X172.484 Y143.17 E.79106
G1 X173.049 Y143.17 E.00921
G1 X138.709 Y108.83 E.79106
G1 X139.274 Y108.83 E.00921
G1 X173.614 Y143.17 E.79106
G1 X174.18 Y143.17 E.00921
G1 X139.84 Y108.83 E.79106
G1 X140.405 Y108.83 E.00921
G1 X174.745 Y143.17 E.79106
G1 X175.311 Y143.17 E.00921
G1 X140.97 Y108.83 E.79106
G1 X141.536 Y108.83 E.00921
G1 X175.876 Y143.17 E.79106
G1 X176.441 Y143.17 E.00921
G1 X142.101 Y108.83 E.79106
G1 X142.666 Y108.83 E.00921
G1 X177.007 Y143.17 E.79106
G1 X177.572 Y143.17 E.00921
G1 X143.232 Y108.83 E.79106
G1 X143.797 Y108.83 E.00921
G1 X178.138 Y143.17 E.79106
G1 X178.17 Y143.17 E.00053
G1 X178.17 Y142.637 E.00868
G1 X144.363 Y108.83 E.77879
G1 X144.928 Y108.83 E.00921
G1 X178.17 Y142.072 E.76577
G1 X178.17 Y141.507 E.00921
G1 X145.493 Y108.83 E.75274
G1 X146.059 Y108.83 E.00921
G1 X178.17 Y140.941 E.73972
G1 X178.17 Y140.376 E.00921
G1 X146.624 Y108.83 E.72669
G1 X147.19 Y108.83 E.00921
G1 X178.17 Y139.81 E.71367
G1 X178.17 Y139.245 E.00921
G1 X147.755 Y108.83 E.70064
G1 X148.32 Y108.83 E.00921
G1 X178.17 Y138.68 E.68762
G1 X178.17 Y138.114 E.00921
G1 X148.886 Y108.83 E.6746
G1 X149.451 Y108.83 E.00921
G1 X178.17 Y137.549 E.66157
G1 X178.17 Y136.983 E.00921
G1 X150.017 Y108.83 E.64855
G1 X150.582 Y108.83 E.00921
G1 X178.17 Y136.418 E.63552
G1 X178.17 Y135.853 E.00921
G1 X151.147 Y108.83 E.6225
G1 X151.713 Y108.83 E.00921
G1 X178.17 Y135.287 E.60947
G1 X178.17 Y134.722 E.00921
G1 X152.278 Y108.83 E.59645
G1 X152.843 Y108.83 E.00921
G1 X178.17 Y134.157 E.58343
G1 X178.17 Y133.591 E.00921
G1 X153.409 Y108.83 E.5704
G1 X153.974 Y108.83 E.00921
G1 X178.17 Y133.026 E.55738
G1 X178.17 Y132.46 E.00921
G1 X154.54 Y108.83 E.54435
M73 P53 R30
G1 X155.105 Y108.83 E.00921
G1 X178.17 Y131.895 E.53133
G1 X178.17 Y131.33 E.00921
G1 X155.67 Y108.83 E.5183
G1 X156.236 Y108.83 E.00921
G1 X178.17 Y130.764 E.50528
G1 X178.17 Y130.199 E.00921
G1 X156.801 Y108.83 E.49226
G1 X157.367 Y108.83 E.00921
G1 X178.17 Y129.633 E.47923
G1 X178.17 Y129.068 E.00921
G1 X157.932 Y108.83 E.46621
G1 X158.497 Y108.83 E.00921
G1 X178.17 Y128.503 E.45318
G1 X178.17 Y127.937 E.00921
G1 X159.063 Y108.83 E.44016
G1 X159.628 Y108.83 E.00921
G1 X178.17 Y127.372 E.42713
G1 X178.17 Y126.806 E.00921
G1 X160.194 Y108.83 E.41411
G1 X160.759 Y108.83 E.00921
G1 X178.17 Y126.241 E.40109
G1 X178.17 Y125.676 E.00921
G1 X161.324 Y108.83 E.38806
G1 X161.89 Y108.83 E.00921
G1 X178.17 Y125.11 E.37504
G1 X178.17 Y124.545 E.00921
G1 X162.455 Y108.83 E.36201
G1 X163.02 Y108.83 E.00921
G1 X178.17 Y123.98 E.34899
G1 X178.17 Y123.414 E.00921
G1 X163.586 Y108.83 E.33596
G1 X164.151 Y108.83 E.00921
G1 X178.17 Y122.849 E.32294
G1 X178.17 Y122.283 E.00921
G1 X164.717 Y108.83 E.30992
G1 X165.282 Y108.83 E.00921
G1 X178.17 Y121.718 E.29689
G1 X178.17 Y121.153 E.00921
G1 X165.847 Y108.83 E.28387
G1 X166.413 Y108.83 E.00921
G1 X178.17 Y120.587 E.27084
G1 X178.17 Y120.022 E.00921
G1 X166.978 Y108.83 E.25782
G1 X167.544 Y108.83 E.00921
G1 X178.17 Y119.456 E.24479
G1 X178.17 Y118.891 E.00921
G1 X168.109 Y108.83 E.23177
G1 X168.674 Y108.83 E.00921
G1 X178.17 Y118.326 E.21875
G1 X178.17 Y117.76 E.00921
G1 X169.24 Y108.83 E.20572
G1 X169.805 Y108.83 E.00921
G1 X178.17 Y117.195 E.1927
G1 X178.17 Y116.629 E.00921
G1 X170.37 Y108.83 E.17967
G1 X170.936 Y108.83 E.00921
G1 X178.17 Y116.064 E.16665
G1 X178.17 Y115.499 E.00921
G1 X171.501 Y108.83 E.15362
G1 X172.067 Y108.83 E.00921
G1 X178.17 Y114.933 E.1406
G1 X178.17 Y114.368 E.00921
G1 X172.632 Y108.83 E.12758
G1 X173.197 Y108.83 E.00921
G1 X178.17 Y113.803 E.11455
G1 X178.17 Y113.237 E.00921
G1 X173.763 Y108.83 E.10153
G1 X174.328 Y108.83 E.00921
G1 X178.17 Y112.672 E.0885
G1 X178.17 Y112.106 E.00921
G1 X174.894 Y108.83 E.07548
G1 X175.459 Y108.83 E.00921
G1 X178.17 Y111.541 E.06245
G1 X178.17 Y110.976 E.00921
G1 X176.024 Y108.83 E.04943
G1 X176.59 Y108.83 E.00921
G1 X178.17 Y110.41 E.03641
G1 X178.17 Y109.845 E.00921
G1 X177.155 Y108.83 E.02338
G1 X177.721 Y108.83 E.00921
G1 X178.35 Y109.459 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X177.721 Y108.83 E-.338
G1 X177.155 Y108.83 E-.21485
G1 X177.541 Y109.215 E-.20715
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/25
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
M204 S10000
G17
G3 Z1.1 I-.765 J-.946 P1  F30000
G1 X134.085 Y144.357 Z1.1
G1 X51.016 Y211.534
G1 Z.8
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #9
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
G3  X53.503 Y187.418   I-3.233 J4.714 E0.0625
G3  X53.532 Y188.160   I-1.932 J0.448 E0.0149
M73 P53 R29
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
M204 S1000
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.65 Y109.459 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X78.28 Y108.83 E.01447
G1 X78.844 Y108.83 E.00918
G1 X77.83 Y109.844 E.02333
G1 X77.83 Y110.409 E.00918
G1 X79.409 Y108.83 E.03631
M73 P54 R29
G1 X79.973 Y108.83 E.00918
G1 X77.83 Y110.973 E.04929
G1 X77.83 Y111.538 E.00918
G1 X80.538 Y108.83 E.06228
G1 X81.102 Y108.83 E.00918
G1 X77.83 Y112.102 E.07526
G1 X77.83 Y112.667 E.00918
G1 X81.667 Y108.83 E.08824
G1 X82.231 Y108.83 E.00918
G1 X77.83 Y113.231 E.10123
G1 X77.83 Y113.796 E.00918
G1 X82.796 Y108.83 E.11421
G1 X83.36 Y108.83 E.00918
G1 X77.83 Y114.36 E.12719
G1 X77.83 Y114.925 E.00918
G1 X83.925 Y108.83 E.14017
G1 X84.489 Y108.83 E.00918
G1 X77.83 Y115.489 E.15316
G1 X77.83 Y116.054 E.00918
G1 X85.054 Y108.83 E.16614
G1 X85.618 Y108.83 E.00918
G1 X77.83 Y116.618 E.17912
G1 X77.83 Y117.182 E.00918
G1 X86.182 Y108.83 E.1921
G1 X86.747 Y108.83 E.00918
G1 X77.83 Y117.747 E.20509
G1 X77.83 Y118.311 E.00918
G1 X87.311 Y108.83 E.21807
G1 X87.876 Y108.83 E.00918
G1 X77.83 Y118.876 E.23105
G1 X77.83 Y119.44 E.00918
G1 X88.44 Y108.83 E.24403
G1 X89.005 Y108.83 E.00918
G1 X77.83 Y120.005 E.25702
G1 X77.83 Y120.569 E.00918
G1 X89.569 Y108.83 E.27
G1 X90.134 Y108.83 E.00918
G1 X77.83 Y121.134 E.28298
G1 X77.83 Y121.698 E.00918
G1 X90.698 Y108.83 E.29596
G1 X91.263 Y108.83 E.00918
G1 X77.83 Y122.263 E.30895
G1 X77.83 Y122.827 E.00918
G1 X91.827 Y108.83 E.32193
G1 X92.392 Y108.83 E.00918
G1 X77.83 Y123.392 E.33491
G1 X77.83 Y123.956 E.00918
G1 X92.956 Y108.83 E.3479
G1 X93.521 Y108.83 E.00918
G1 X77.83 Y124.521 E.36088
G1 X77.83 Y125.085 E.00918
G1 X94.085 Y108.83 E.37386
G1 X94.65 Y108.83 E.00918
G1 X77.83 Y125.65 E.38684
G1 X77.83 Y126.214 E.00918
G1 X95.214 Y108.83 E.39983
G1 X95.779 Y108.83 E.00918
G1 X77.83 Y126.779 E.41281
G1 X77.83 Y127.343 E.00918
G1 X96.343 Y108.83 E.42579
G1 X96.908 Y108.83 E.00918
G1 X77.83 Y127.908 E.43877
G1 X77.83 Y128.472 E.00918
G1 X97.472 Y108.83 E.45176
G1 X98.037 Y108.83 E.00918
G1 X77.83 Y129.037 E.46474
G1 X77.83 Y129.601 E.00918
G1 X98.601 Y108.83 E.47772
G1 X99.166 Y108.83 E.00918
G1 X77.83 Y130.166 E.4907
G1 X77.83 Y130.73 E.00918
G1 X99.73 Y108.83 E.50369
G1 X100.295 Y108.83 E.00918
G1 X77.83 Y131.295 E.51667
G1 X77.83 Y131.859 E.00918
G1 X100.859 Y108.83 E.52965
G1 X101.424 Y108.83 E.00918
G1 X77.83 Y132.424 E.54263
G1 X77.83 Y132.988 E.00918
G1 X101.988 Y108.83 E.55562
G1 X102.552 Y108.83 E.00918
G1 X77.83 Y133.552 E.5686
G1 X77.83 Y134.117 E.00918
G1 X103.117 Y108.83 E.58158
G1 X103.681 Y108.83 E.00918
G1 X77.83 Y134.681 E.59457
G1 X77.83 Y135.246 E.00918
G1 X104.246 Y108.83 E.60755
G1 X104.81 Y108.83 E.00918
G1 X77.83 Y135.81 E.62053
G1 X77.83 Y136.375 E.00918
G1 X105.375 Y108.83 E.63351
G1 X105.939 Y108.83 E.00918
G1 X77.83 Y136.939 E.6465
G1 X77.83 Y137.504 E.00918
G1 X106.504 Y108.83 E.65948
G1 X107.068 Y108.83 E.00918
G1 X77.83 Y138.068 E.67246
G1 X77.83 Y138.633 E.00918
G1 X107.633 Y108.83 E.68544
G1 X108.197 Y108.83 E.00918
G1 X77.83 Y139.197 E.69843
G1 X77.83 Y139.762 E.00918
G1 X108.762 Y108.83 E.71141
G1 X109.326 Y108.83 E.00918
G1 X77.83 Y140.326 E.72439
G1 X77.83 Y140.891 E.00918
G1 X109.891 Y108.83 E.73737
G1 X110.455 Y108.83 E.00918
G1 X77.936 Y141.349 E.7479
G1 X78.219 Y141.631 E.00649
G1 X111.02 Y108.83 E.7544
G1 X111.584 Y108.83 E.00918
G1 X78.501 Y141.913 E.76089
G1 X78.783 Y142.195 E.00649
G1 X112.149 Y108.83 E.76738
G1 X112.713 Y108.83 E.00918
G1 X79.065 Y142.478 E.77387
G1 X79.348 Y142.76 E.00649
G1 X113.278 Y108.83 E.78036
G1 X113.842 Y108.83 E.00918
G1 X79.63 Y143.042 E.78685
G1 X79.758 Y143.17 E.00295
G1 X80.066 Y143.17 E.00501
G1 X114.407 Y108.83 E.7898
G1 X114.971 Y108.83 E.00918
G1 X80.631 Y143.17 E.7898
G1 X81.195 Y143.17 E.00918
G1 X115.536 Y108.83 E.7898
G1 X116.1 Y108.83 E.00918
G1 X81.76 Y143.17 E.7898
G1 X82.324 Y143.17 E.00918
G1 X116.665 Y108.83 E.7898
G1 X117.229 Y108.83 E.00918
G1 X82.889 Y143.17 E.7898
G1 X83.453 Y143.17 E.00918
G1 X117.794 Y108.83 E.7898
G1 X118.358 Y108.83 E.00918
G1 X84.018 Y143.17 E.7898
G1 X84.582 Y143.17 E.00918
G1 X118.923 Y108.83 E.7898
G1 X119.487 Y108.83 E.00918
G1 X85.147 Y143.17 E.7898
G1 X85.711 Y143.17 E.00918
G1 X120.051 Y108.83 E.7898
G1 X120.616 Y108.83 E.00918
G1 X86.276 Y143.17 E.7898
G1 X86.84 Y143.17 E.00918
G1 X121.18 Y108.83 E.7898
G1 X121.745 Y108.83 E.00918
G1 X87.405 Y143.17 E.7898
G1 X87.969 Y143.17 E.00918
G1 X122.309 Y108.83 E.7898
G1 X122.874 Y108.83 E.00918
G1 X88.534 Y143.17 E.7898
G1 X89.098 Y143.17 E.00918
G1 X123.438 Y108.83 E.7898
G1 X124.003 Y108.83 E.00918
G1 X89.662 Y143.17 E.7898
G1 X90.227 Y143.17 E.00918
G1 X124.567 Y108.83 E.7898
G1 X125.132 Y108.83 E.00918
G1 X90.791 Y143.17 E.7898
G1 X91.356 Y143.17 E.00918
G1 X125.696 Y108.83 E.7898
G1 X126.261 Y108.83 E.00918
G1 X91.92 Y143.17 E.7898
G1 X92.485 Y143.17 E.00918
G1 X126.825 Y108.83 E.7898
G1 X127.39 Y108.83 E.00918
G1 X93.049 Y143.17 E.7898
G1 X93.614 Y143.17 E.00918
G1 X127.954 Y108.83 E.7898
G1 X128.519 Y108.83 E.00918
G1 X94.178 Y143.17 E.7898
G1 X94.743 Y143.17 E.00918
G1 X129.083 Y108.83 E.7898
G1 X129.648 Y108.83 E.00918
G1 X95.307 Y143.17 E.7898
G1 X95.872 Y143.17 E.00918
G1 X130.212 Y108.83 E.7898
G1 X130.777 Y108.83 E.00918
G1 X96.436 Y143.17 E.7898
G1 X97.001 Y143.17 E.00918
G1 X131.341 Y108.83 E.7898
G1 X131.906 Y108.83 E.00918
G1 X97.565 Y143.17 E.7898
G1 X98.13 Y143.17 E.00918
G1 X132.47 Y108.83 E.7898
G1 X133.035 Y108.83 E.00918
G1 X98.694 Y143.17 E.7898
G1 X99.259 Y143.17 E.00918
G1 X133.599 Y108.83 E.7898
G1 X134.164 Y108.83 E.00918
G1 X99.823 Y143.17 E.7898
G1 X100.388 Y143.17 E.00918
G1 X134.728 Y108.83 E.7898
G1 X135.293 Y108.83 E.00918
G1 X100.952 Y143.17 E.7898
G1 X101.517 Y143.17 E.00918
G1 X135.857 Y108.83 E.7898
G1 X136.421 Y108.83 E.00918
G1 X102.081 Y143.17 E.7898
M73 P55 R29
G1 X102.646 Y143.17 E.00918
G1 X136.986 Y108.83 E.7898
G1 X137.55 Y108.83 E.00918
G1 X103.21 Y143.17 E.7898
G1 X103.775 Y143.17 E.00918
G1 X138.115 Y108.83 E.7898
G1 X138.679 Y108.83 E.00918
G1 X104.339 Y143.17 E.7898
G1 X104.904 Y143.17 E.00918
G1 X139.244 Y108.83 E.7898
G1 X139.808 Y108.83 E.00918
G1 X105.468 Y143.17 E.7898
G1 X106.033 Y143.17 E.00918
G1 X140.373 Y108.83 E.7898
G1 X140.937 Y108.83 E.00918
G1 X106.597 Y143.17 E.7898
G1 X107.161 Y143.17 E.00918
G1 X141.502 Y108.83 E.7898
G1 X142.066 Y108.83 E.00918
G1 X107.726 Y143.17 E.7898
G1 X108.29 Y143.17 E.00918
G1 X142.631 Y108.83 E.7898
G1 X143.195 Y108.83 E.00918
G1 X108.855 Y143.17 E.7898
G1 X109.419 Y143.17 E.00918
G1 X143.76 Y108.83 E.7898
G1 X144.324 Y108.83 E.00918
G1 X109.984 Y143.17 E.7898
G1 X110.548 Y143.17 E.00918
G1 X144.889 Y108.83 E.7898
G1 X145.453 Y108.83 E.00918
G1 X111.113 Y143.17 E.7898
G1 X111.677 Y143.17 E.00918
G1 X146.018 Y108.83 E.7898
G1 X146.582 Y108.83 E.00918
G1 X112.242 Y143.17 E.7898
G1 X112.806 Y143.17 E.00918
G1 X147.147 Y108.83 E.7898
G1 X147.711 Y108.83 E.00918
M73 P55 R28
G1 X113.371 Y143.17 E.7898
G1 X113.935 Y143.17 E.00918
G1 X148.276 Y108.83 E.7898
G1 X148.84 Y108.83 E.00918
G1 X114.5 Y143.17 E.7898
G1 X115.064 Y143.17 E.00918
G1 X149.405 Y108.83 E.7898
G1 X149.969 Y108.83 E.00918
G1 X115.629 Y143.17 E.7898
G1 X116.193 Y143.17 E.00918
G1 X150.534 Y108.83 E.7898
G1 X151.098 Y108.83 E.00918
G1 X116.758 Y143.17 E.7898
G1 X117.322 Y143.17 E.00918
G1 X151.663 Y108.83 E.7898
G1 X152.227 Y108.83 E.00918
G1 X117.887 Y143.17 E.7898
G1 X118.451 Y143.17 E.00918
G1 X152.792 Y108.83 E.7898
G1 X153.356 Y108.83 E.00918
G1 X119.016 Y143.17 E.7898
G1 X119.58 Y143.17 E.00918
G1 X153.92 Y108.83 E.7898
G1 X154.485 Y108.83 E.00918
G1 X120.145 Y143.17 E.7898
G1 X120.709 Y143.17 E.00918
G1 X155.049 Y108.83 E.7898
G1 X155.614 Y108.83 E.00918
G1 X121.274 Y143.17 E.7898
G1 X121.838 Y143.17 E.00918
G1 X156.178 Y108.83 E.7898
G1 X156.743 Y108.83 E.00918
G1 X122.403 Y143.17 E.7898
G1 X122.967 Y143.17 E.00918
G1 X157.307 Y108.83 E.7898
G1 X157.872 Y108.83 E.00918
G1 X123.532 Y143.17 E.7898
G1 X124.096 Y143.17 E.00918
G1 X158.436 Y108.83 E.7898
G1 X159.001 Y108.83 E.00918
G1 X124.66 Y143.17 E.7898
G1 X125.225 Y143.17 E.00918
G1 X159.565 Y108.83 E.7898
G1 X160.13 Y108.83 E.00918
G1 X125.789 Y143.17 E.7898
G1 X126.354 Y143.17 E.00918
G1 X160.694 Y108.83 E.7898
G1 X161.259 Y108.83 E.00918
G1 X126.918 Y143.17 E.7898
G1 X127.483 Y143.17 E.00918
G1 X161.823 Y108.83 E.7898
G1 X162.388 Y108.83 E.00918
G1 X128.047 Y143.17 E.7898
G1 X128.612 Y143.17 E.00918
G1 X162.952 Y108.83 E.7898
G1 X163.517 Y108.83 E.00918
G1 X129.176 Y143.17 E.7898
G1 X129.741 Y143.17 E.00918
G1 X164.081 Y108.83 E.7898
G1 X164.646 Y108.83 E.00918
G1 X130.305 Y143.17 E.7898
G1 X130.87 Y143.17 E.00918
G1 X165.21 Y108.83 E.7898
G1 X165.775 Y108.83 E.00918
G1 X131.434 Y143.17 E.7898
G1 X131.999 Y143.17 E.00918
G1 X166.339 Y108.83 E.7898
G1 X166.904 Y108.83 E.00918
G1 X132.563 Y143.17 E.7898
G1 X133.128 Y143.17 E.00918
G1 X167.468 Y108.83 E.7898
G1 X168.033 Y108.83 E.00918
G1 X133.692 Y143.17 E.7898
G1 X134.257 Y143.17 E.00918
G1 X168.597 Y108.83 E.7898
G1 X169.162 Y108.83 E.00918
G1 X134.821 Y143.17 E.7898
G1 X135.386 Y143.17 E.00918
G1 X169.726 Y108.83 E.7898
G1 X170.291 Y108.83 E.00918
G1 X135.95 Y143.17 E.7898
G1 X136.515 Y143.17 E.00918
G1 X170.855 Y108.83 E.7898
G1 X171.419 Y108.83 E.00918
G1 X137.079 Y143.17 E.7898
G1 X137.644 Y143.17 E.00918
G1 X171.984 Y108.83 E.7898
G1 X172.548 Y108.83 E.00918
G1 X138.208 Y143.17 E.7898
G1 X138.773 Y143.17 E.00918
G1 X173.113 Y108.83 E.7898
G1 X173.677 Y108.83 E.00918
M73 P56 R28
G1 X139.337 Y143.17 E.7898
G1 X139.902 Y143.17 E.00918
G1 X174.242 Y108.83 E.7898
G1 X174.806 Y108.83 E.00918
G1 X140.466 Y143.17 E.7898
G1 X141.03 Y143.17 E.00918
G1 X175.371 Y108.83 E.7898
G1 X175.935 Y108.83 E.00918
G1 X141.595 Y143.17 E.7898
G1 X142.159 Y143.17 E.00918
G1 X176.5 Y108.83 E.7898
G1 X177.064 Y108.83 E.00918
G1 X142.724 Y143.17 E.7898
G1 X143.288 Y143.17 E.00918
G1 X177.629 Y108.83 E.7898
G1 X178.17 Y108.83 E.0088
G1 X178.17 Y108.853 E.00038
G1 X143.853 Y143.17 E.78927
G1 X144.417 Y143.17 E.00918
G1 X178.17 Y109.417 E.77628
G1 X178.17 Y109.982 E.00918
G1 X144.982 Y143.17 E.7633
G1 X145.546 Y143.17 E.00918
G1 X178.17 Y110.546 E.75032
G1 X178.17 Y111.111 E.00918
G1 X146.111 Y143.17 E.73734
G1 X146.675 Y143.17 E.00918
G1 X178.17 Y111.675 E.72435
G1 X178.17 Y112.24 E.00918
G1 X147.24 Y143.17 E.71137
G1 X147.804 Y143.17 E.00918
G1 X178.17 Y112.804 E.69839
G1 X178.17 Y113.369 E.00918
G1 X148.369 Y143.17 E.68541
G1 X148.933 Y143.17 E.00918
G1 X178.17 Y113.933 E.67242
G1 X178.17 Y114.498 E.00918
G1 X149.498 Y143.17 E.65944
G1 X150.062 Y143.17 E.00918
G1 X178.17 Y115.062 E.64646
G1 X178.17 Y115.627 E.00918
G1 X150.627 Y143.17 E.63348
G1 X151.191 Y143.17 E.00918
G1 X178.17 Y116.191 E.62049
G1 X178.17 Y116.756 E.00918
G1 X151.756 Y143.17 E.60751
G1 X152.32 Y143.17 E.00918
G1 X178.17 Y117.32 E.59453
G1 X178.17 Y117.885 E.00918
G1 X152.885 Y143.17 E.58155
G1 X153.449 Y143.17 E.00918
G1 X178.17 Y118.449 E.56856
G1 X178.17 Y119.014 E.00918
G1 X154.014 Y143.17 E.55558
G1 X154.578 Y143.17 E.00918
G1 X178.17 Y119.578 E.5426
G1 X178.17 Y120.143 E.00918
G1 X155.143 Y143.17 E.52961
G1 X155.707 Y143.17 E.00918
G1 X178.17 Y120.707 E.51663
G1 X178.17 Y121.272 E.00918
G1 X156.272 Y143.17 E.50365
G1 X156.836 Y143.17 E.00918
G1 X178.17 Y121.836 E.49067
G1 X178.17 Y122.401 E.00918
G1 X157.401 Y143.17 E.47768
G1 X157.965 Y143.17 E.00918
G1 X178.17 Y122.965 E.4647
G1 X178.17 Y123.529 E.00918
G1 X158.529 Y143.17 E.45172
G1 X159.094 Y143.17 E.00918
G1 X178.17 Y124.094 E.43874
G1 X178.17 Y124.658 E.00918
G1 X159.658 Y143.17 E.42575
G1 X160.223 Y143.17 E.00918
G1 X178.17 Y125.223 E.41277
G1 X178.17 Y125.787 E.00918
G1 X160.787 Y143.17 E.39979
G1 X161.352 Y143.17 E.00918
G1 X178.17 Y126.352 E.38681
G1 X178.17 Y126.916 E.00918
G1 X161.916 Y143.17 E.37382
G1 X162.481 Y143.17 E.00918
G1 X178.17 Y127.481 E.36084
G1 X178.17 Y128.045 E.00918
G1 X163.045 Y143.17 E.34786
G1 X163.61 Y143.17 E.00918
G1 X178.17 Y128.61 E.33488
G1 X178.17 Y129.174 E.00918
G1 X164.174 Y143.17 E.32189
G1 X164.739 Y143.17 E.00918
G1 X178.17 Y129.739 E.30891
G1 X178.17 Y130.303 E.00918
G1 X165.303 Y143.17 E.29593
G1 X165.868 Y143.17 E.00918
G1 X178.17 Y130.868 E.28294
G1 X178.17 Y131.432 E.00918
G1 X166.432 Y143.17 E.26996
G1 X166.997 Y143.17 E.00918
G1 X178.17 Y131.997 E.25698
G1 X178.17 Y132.561 E.00918
G1 X167.561 Y143.17 E.244
G1 X168.126 Y143.17 E.00918
G1 X178.17 Y133.126 E.23101
G1 X178.17 Y133.69 E.00918
G1 X168.69 Y143.17 E.21803
G1 X169.255 Y143.17 E.00918
G1 X178.17 Y134.255 E.20505
G1 X178.17 Y134.819 E.00918
G1 X169.819 Y143.17 E.19207
M73 P56 R27
G1 X170.384 Y143.17 E.00918
G1 X178.17 Y135.384 E.17908
G1 X178.17 Y135.948 E.00918
G1 X170.948 Y143.17 E.1661
G1 X171.513 Y143.17 E.00918
G1 X178.17 Y136.513 E.15312
G1 X178.17 Y137.077 E.00918
G1 X172.077 Y143.17 E.14014
G1 X172.642 Y143.17 E.00918
G1 X178.17 Y137.642 E.12715
G1 X178.17 Y138.206 E.00918
G1 X173.206 Y143.17 E.11417
G1 X173.771 Y143.17 E.00918
G1 X178.17 Y138.771 E.10119
G1 X178.17 Y139.335 E.00918
G1 X174.335 Y143.17 E.08821
G1 X174.899 Y143.17 E.00918
G1 X178.17 Y139.9 E.07522
G1 X178.17 Y140.464 E.00918
G1 X175.464 Y143.17 E.06224
G1 X176.028 Y143.17 E.00918
G1 X178.17 Y141.028 E.04926
G1 X178.17 Y141.593 E.00918
M73 P57 R27
G1 X176.593 Y143.17 E.03627
G1 X177.157 Y143.17 E.00918
G1 X178.17 Y142.157 E.02329
G1 X178.17 Y142.722 E.00918
G1 X177.543 Y143.35 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 0.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X178.17 Y142.722 E-.33727
G1 X178.17 Y142.157 E-.21451
G1 X177.783 Y142.545 E-.20822
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/25
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
M204 S10000
G17
G3 Z1.2 I-.582 J-1.069 P1  F30000
G1 X174.453 Y144.357 Z1.2
G1 X51.016 Y211.534
G1 Z.9
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #10
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.084 Y114.9 Z1.3 F30000
G1 X77.65 Y141.061 Z1.3
G1 Z.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X79.76 Y143.17 E.0486
G1 X80.325 Y143.17 E.00921
G1 X77.83 Y140.675 E.05749
G1 X77.83 Y140.109 E.00921
G1 X80.891 Y143.17 E.07051
G1 X81.456 Y143.17 E.00921
G1 X77.83 Y139.544 E.08354
G1 X77.83 Y138.978 E.00921
G1 X82.022 Y143.17 E.09656
G1 X82.587 Y143.17 E.00921
G1 X77.83 Y138.413 E.10959
G1 X77.83 Y137.848 E.00921
G1 X83.152 Y143.17 E.12261
G1 X83.718 Y143.17 E.00921
G1 X77.83 Y137.282 E.13563
G1 X77.83 Y136.717 E.00921
G1 X84.283 Y143.17 E.14866
G1 X84.849 Y143.17 E.00921
G1 X77.83 Y136.151 E.16168
G1 X77.83 Y135.586 E.00921
G1 X85.414 Y143.17 E.17471
G1 X85.979 Y143.17 E.00921
G1 X77.83 Y135.021 E.18773
G1 X77.83 Y134.455 E.00921
G1 X86.545 Y143.17 E.20076
G1 X87.11 Y143.17 E.00921
G1 X77.83 Y133.89 E.21378
G1 X77.83 Y133.325 E.00921
G1 X87.675 Y143.17 E.2268
G1 X88.241 Y143.17 E.00921
G1 X77.83 Y132.759 E.23983
G1 X77.83 Y132.194 E.00921
G1 X88.806 Y143.17 E.25285
G1 X89.372 Y143.17 E.00921
G1 X77.83 Y131.628 E.26588
G1 X77.83 Y131.063 E.00921
G1 X89.937 Y143.17 E.2789
G1 X90.502 Y143.17 E.00921
G1 X77.83 Y130.498 E.29193
G1 X77.83 Y129.932 E.00921
G1 X91.068 Y143.17 E.30495
G1 X91.633 Y143.17 E.00921
G1 X77.83 Y129.367 E.31797
G1 X77.83 Y128.801 E.00921
G1 X92.199 Y143.17 E.331
G1 X92.764 Y143.17 E.00921
G1 X77.83 Y128.236 E.34402
G1 X77.83 Y127.671 E.00921
G1 X93.329 Y143.17 E.35705
G1 X93.895 Y143.17 E.00921
G1 X77.83 Y127.105 E.37007
G1 X77.83 Y126.54 E.00921
G1 X94.46 Y143.17 E.3831
G1 X95.025 Y143.17 E.00921
G1 X77.83 Y125.974 E.39612
G1 X77.83 Y125.409 E.00921
G1 X95.591 Y143.17 E.40914
G1 X96.156 Y143.17 E.00921
G1 X77.83 Y124.844 E.42217
G1 X77.83 Y124.278 E.00921
G1 X96.722 Y143.17 E.43519
G1 X97.287 Y143.17 E.00921
G1 X77.83 Y123.713 E.44822
G1 X77.83 Y123.148 E.00921
G1 X97.852 Y143.17 E.46124
G1 X98.418 Y143.17 E.00921
G1 X77.83 Y122.582 E.47427
G1 X77.83 Y122.017 E.00921
G1 X98.983 Y143.17 E.48729
G1 X99.549 Y143.17 E.00921
G1 X77.83 Y121.451 E.50031
G1 X77.83 Y120.886 E.00921
G1 X100.114 Y143.17 E.51334
G1 X100.679 Y143.17 E.00921
G1 X77.83 Y120.321 E.52636
G1 X77.83 Y119.755 E.00921
G1 X101.245 Y143.17 E.53939
G1 X101.81 Y143.17 E.00921
G1 X77.83 Y119.19 E.55241
G1 X77.83 Y118.624 E.00921
G1 X102.376 Y143.17 E.56544
G1 X102.941 Y143.17 E.00921
G1 X77.83 Y118.059 E.57846
G1 X77.83 Y117.494 E.00921
G1 X103.506 Y143.17 E.59148
G1 X104.072 Y143.17 E.00921
G1 X77.83 Y116.928 E.60451
G1 X77.83 Y116.363 E.00921
G1 X104.637 Y143.17 E.61753
G1 X105.202 Y143.17 E.00921
G1 X77.83 Y115.798 E.63056
G1 X77.83 Y115.232 E.00921
G1 X105.768 Y143.17 E.64358
G1 X106.333 Y143.17 E.00921
G1 X77.83 Y114.667 E.65661
G1 X77.83 Y114.101 E.00921
G1 X106.899 Y143.17 E.66963
G1 X107.464 Y143.17 E.00921
G1 X77.83 Y113.536 E.68265
G1 X77.83 Y112.971 E.00921
G1 X108.029 Y143.17 E.69568
G1 X108.595 Y143.17 E.00921
G1 X77.83 Y112.405 E.7087
G1 X77.83 Y111.84 E.00921
G1 X109.16 Y143.17 E.72173
G1 X109.726 Y143.17 E.00921
G1 X77.83 Y111.274 E.73475
G1 X77.83 Y110.709 E.00921
G1 X110.291 Y143.17 E.74778
G1 X110.856 Y143.17 E.00921
G1 X77.83 Y110.144 E.7608
G1 X77.83 Y109.578 E.00921
G1 X111.422 Y143.17 E.77382
G1 X111.987 Y143.17 E.00921
G1 X77.83 Y109.013 E.78685
M73 P58 R27
G1 X77.83 Y108.83 E.00298
G1 X78.212 Y108.83 E.00623
G1 X112.553 Y143.17 E.79106
G1 X113.118 Y143.17 E.00921
G1 X78.778 Y108.83 E.79106
G1 X79.343 Y108.83 E.00921
G1 X113.683 Y143.17 E.79106
G1 X114.249 Y143.17 E.00921
G1 X79.908 Y108.83 E.79106
G1 X80.474 Y108.83 E.00921
G1 X114.814 Y143.17 E.79106
G1 X115.379 Y143.17 E.00921
G1 X81.039 Y108.83 E.79106
G1 X81.605 Y108.83 E.00921
G1 X115.945 Y143.17 E.79106
G1 X116.51 Y143.17 E.00921
G1 X82.17 Y108.83 E.79106
G1 X82.735 Y108.83 E.00921
G1 X117.076 Y143.17 E.79106
G1 X117.641 Y143.17 E.00921
G1 X83.301 Y108.83 E.79106
G1 X83.866 Y108.83 E.00921
G1 X118.206 Y143.17 E.79106
G1 X118.772 Y143.17 E.00921
G1 X84.431 Y108.83 E.79106
G1 X84.997 Y108.83 E.00921
G1 X119.337 Y143.17 E.79106
G1 X119.903 Y143.17 E.00921
G1 X85.562 Y108.83 E.79106
G1 X86.128 Y108.83 E.00921
G1 X120.468 Y143.17 E.79106
G1 X121.033 Y143.17 E.00921
G1 X86.693 Y108.83 E.79106
G1 X87.258 Y108.83 E.00921
G1 X121.599 Y143.17 E.79106
G1 X122.164 Y143.17 E.00921
G1 X87.824 Y108.83 E.79106
G1 X88.389 Y108.83 E.00921
G1 X122.73 Y143.17 E.79106
G1 X123.295 Y143.17 E.00921
G1 X88.955 Y108.83 E.79106
G1 X89.52 Y108.83 E.00921
G1 X123.86 Y143.17 E.79106
G1 X124.426 Y143.17 E.00921
G1 X90.085 Y108.83 E.79106
G1 X90.651 Y108.83 E.00921
G1 X124.991 Y143.17 E.79106
G1 X125.556 Y143.17 E.00921
G1 X91.216 Y108.83 E.79106
G1 X91.782 Y108.83 E.00921
G1 X126.122 Y143.17 E.79106
G1 X126.687 Y143.17 E.00921
G1 X92.347 Y108.83 E.79106
G1 X92.912 Y108.83 E.00921
G1 X127.253 Y143.17 E.79106
G1 X127.818 Y143.17 E.00921
G1 X93.478 Y108.83 E.79106
G1 X94.043 Y108.83 E.00921
G1 X128.383 Y143.17 E.79106
G1 X128.949 Y143.17 E.00921
G1 X94.608 Y108.83 E.79106
G1 X95.174 Y108.83 E.00921
G1 X129.514 Y143.17 E.79106
G1 X130.08 Y143.17 E.00921
G1 X95.739 Y108.83 E.79106
G1 X96.305 Y108.83 E.00921
G1 X130.645 Y143.17 E.79106
G1 X131.21 Y143.17 E.00921
G1 X96.87 Y108.83 E.79106
G1 X97.435 Y108.83 E.00921
G1 X131.776 Y143.17 E.79106
G1 X132.341 Y143.17 E.00921
G1 X98.001 Y108.83 E.79106
G1 X98.566 Y108.83 E.00921
G1 X132.907 Y143.17 E.79106
G1 X133.472 Y143.17 E.00921
G1 X99.132 Y108.83 E.79106
G1 X99.697 Y108.83 E.00921
G1 X134.037 Y143.17 E.79106
G1 X134.603 Y143.17 E.00921
G1 X100.262 Y108.83 E.79106
M73 P58 R26
G1 X100.828 Y108.83 E.00921
G1 X135.168 Y143.17 E.79106
G1 X135.733 Y143.17 E.00921
G1 X101.393 Y108.83 E.79106
G1 X101.958 Y108.83 E.00921
G1 X136.299 Y143.17 E.79106
G1 X136.864 Y143.17 E.00921
G1 X102.524 Y108.83 E.79106
G1 X103.089 Y108.83 E.00921
G1 X137.43 Y143.17 E.79106
G1 X137.995 Y143.17 E.00921
G1 X103.655 Y108.83 E.79106
G1 X104.22 Y108.83 E.00921
G1 X138.56 Y143.17 E.79106
G1 X139.126 Y143.17 E.00921
G1 X104.785 Y108.83 E.79106
G1 X105.351 Y108.83 E.00921
G1 X139.691 Y143.17 E.79106
G1 X140.257 Y143.17 E.00921
G1 X105.916 Y108.83 E.79106
G1 X106.482 Y108.83 E.00921
G1 X140.822 Y143.17 E.79106
G1 X141.387 Y143.17 E.00921
G1 X107.047 Y108.83 E.79106
G1 X107.612 Y108.83 E.00921
G1 X141.953 Y143.17 E.79106
G1 X142.518 Y143.17 E.00921
G1 X108.178 Y108.83 E.79106
G1 X108.743 Y108.83 E.00921
G1 X143.084 Y143.17 E.79106
G1 X143.649 Y143.17 E.00921
G1 X109.309 Y108.83 E.79106
G1 X109.874 Y108.83 E.00921
G1 X144.214 Y143.17 E.79106
G1 X144.78 Y143.17 E.00921
G1 X110.439 Y108.83 E.79106
G1 X111.005 Y108.83 E.00921
G1 X145.345 Y143.17 E.79106
G1 X145.91 Y143.17 E.00921
G1 X111.57 Y108.83 E.79106
G1 X112.135 Y108.83 E.00921
G1 X146.476 Y143.17 E.79106
G1 X147.041 Y143.17 E.00921
G1 X112.701 Y108.83 E.79106
G1 X113.266 Y108.83 E.00921
G1 X147.607 Y143.17 E.79106
G1 X148.172 Y143.17 E.00921
G1 X113.832 Y108.83 E.79106
G1 X114.397 Y108.83 E.00921
G1 X148.737 Y143.17 E.79106
G1 X149.303 Y143.17 E.00921
G1 X114.962 Y108.83 E.79106
G1 X115.528 Y108.83 E.00921
G1 X149.868 Y143.17 E.79106
G1 X150.434 Y143.17 E.00921
G1 X116.093 Y108.83 E.79106
G1 X116.659 Y108.83 E.00921
G1 X150.999 Y143.17 E.79106
G1 X151.564 Y143.17 E.00921
G1 X117.224 Y108.83 E.79106
G1 X117.789 Y108.83 E.00921
G1 X152.13 Y143.17 E.79106
G1 X152.695 Y143.17 E.00921
G1 X118.355 Y108.83 E.79106
G1 X118.92 Y108.83 E.00921
G1 X153.261 Y143.17 E.79106
G1 X153.826 Y143.17 E.00921
G1 X119.486 Y108.83 E.79106
G1 X120.051 Y108.83 E.00921
G1 X154.391 Y143.17 E.79106
G1 X154.957 Y143.17 E.00921
G1 X120.616 Y108.83 E.79106
G1 X121.182 Y108.83 E.00921
G1 X155.522 Y143.17 E.79106
G1 X156.087 Y143.17 E.00921
G1 X121.747 Y108.83 E.79106
G1 X122.312 Y108.83 E.00921
G1 X156.653 Y143.17 E.79106
G1 X157.218 Y143.17 E.00921
G1 X122.878 Y108.83 E.79106
G1 X123.443 Y108.83 E.00921
G1 X157.784 Y143.17 E.79106
G1 X158.349 Y143.17 E.00921
M73 P59 R26
G1 X124.009 Y108.83 E.79106
G1 X124.574 Y108.83 E.00921
G1 X158.914 Y143.17 E.79106
G1 X159.48 Y143.17 E.00921
G1 X125.139 Y108.83 E.79106
G1 X125.705 Y108.83 E.00921
G1 X160.045 Y143.17 E.79106
G1 X160.611 Y143.17 E.00921
G1 X126.27 Y108.83 E.79106
G1 X126.836 Y108.83 E.00921
G1 X161.176 Y143.17 E.79106
G1 X161.741 Y143.17 E.00921
G1 X127.401 Y108.83 E.79106
G1 X127.966 Y108.83 E.00921
G1 X162.307 Y143.17 E.79106
G1 X162.872 Y143.17 E.00921
G1 X128.532 Y108.83 E.79106
G1 X129.097 Y108.83 E.00921
G1 X163.437 Y143.17 E.79106
G1 X164.003 Y143.17 E.00921
G1 X129.663 Y108.83 E.79106
G1 X130.228 Y108.83 E.00921
G1 X164.568 Y143.17 E.79106
G1 X165.134 Y143.17 E.00921
G1 X130.793 Y108.83 E.79106
G1 X131.359 Y108.83 E.00921
G1 X165.699 Y143.17 E.79106
G1 X166.264 Y143.17 E.00921
G1 X131.924 Y108.83 E.79106
G1 X132.489 Y108.83 E.00921
G1 X166.83 Y143.17 E.79106
G1 X167.395 Y143.17 E.00921
G1 X133.055 Y108.83 E.79106
G1 X133.62 Y108.83 E.00921
G1 X167.961 Y143.17 E.79106
G1 X168.526 Y143.17 E.00921
G1 X134.186 Y108.83 E.79106
G1 X134.751 Y108.83 E.00921
G1 X169.091 Y143.17 E.79106
G1 X169.657 Y143.17 E.00921
G1 X135.316 Y108.83 E.79106
G1 X135.882 Y108.83 E.00921
G1 X170.222 Y143.17 E.79106
G1 X170.788 Y143.17 E.00921
G1 X136.447 Y108.83 E.79106
G1 X137.013 Y108.83 E.00921
G1 X171.353 Y143.17 E.79106
G1 X171.918 Y143.17 E.00921
G1 X137.578 Y108.83 E.79106
G1 X138.143 Y108.83 E.00921
G1 X172.484 Y143.17 E.79106
G1 X173.049 Y143.17 E.00921
G1 X138.709 Y108.83 E.79106
G1 X139.274 Y108.83 E.00921
G1 X173.614 Y143.17 E.79106
G1 X174.18 Y143.17 E.00921
G1 X139.84 Y108.83 E.79106
G1 X140.405 Y108.83 E.00921
G1 X174.745 Y143.17 E.79106
G1 X175.311 Y143.17 E.00921
G1 X140.97 Y108.83 E.79106
G1 X141.536 Y108.83 E.00921
G1 X175.876 Y143.17 E.79106
G1 X176.441 Y143.17 E.00921
G1 X142.101 Y108.83 E.79106
G1 X142.666 Y108.83 E.00921
G1 X177.007 Y143.17 E.79106
G1 X177.572 Y143.17 E.00921
G1 X143.232 Y108.83 E.79106
G1 X143.797 Y108.83 E.00921
G1 X178.138 Y143.17 E.79106
G1 X178.17 Y143.17 E.00053
G1 X178.17 Y142.637 E.00868
G1 X144.363 Y108.83 E.77879
G1 X144.928 Y108.83 E.00921
G1 X178.17 Y142.072 E.76577
G1 X178.17 Y141.507 E.00921
G1 X145.493 Y108.83 E.75274
G1 X146.059 Y108.83 E.00921
G1 X178.17 Y140.941 E.73972
G1 X178.17 Y140.376 E.00921
G1 X146.624 Y108.83 E.72669
G1 X147.19 Y108.83 E.00921
G1 X178.17 Y139.81 E.71367
G1 X178.17 Y139.245 E.00921
G1 X147.755 Y108.83 E.70064
G1 X148.32 Y108.83 E.00921
G1 X178.17 Y138.68 E.68762
G1 X178.17 Y138.114 E.00921
G1 X148.886 Y108.83 E.6746
G1 X149.451 Y108.83 E.00921
G1 X178.17 Y137.549 E.66157
G1 X178.17 Y136.983 E.00921
G1 X150.017 Y108.83 E.64855
G1 X150.582 Y108.83 E.00921
G1 X178.17 Y136.418 E.63552
G1 X178.17 Y135.853 E.00921
G1 X151.147 Y108.83 E.6225
G1 X151.713 Y108.83 E.00921
G1 X178.17 Y135.287 E.60947
G1 X178.17 Y134.722 E.00921
G1 X152.278 Y108.83 E.59645
G1 X152.843 Y108.83 E.00921
G1 X178.17 Y134.157 E.58343
G1 X178.17 Y133.591 E.00921
G1 X153.409 Y108.83 E.5704
G1 X153.974 Y108.83 E.00921
G1 X178.17 Y133.026 E.55738
G1 X178.17 Y132.46 E.00921
G1 X154.54 Y108.83 E.54435
G1 X155.105 Y108.83 E.00921
G1 X178.17 Y131.895 E.53133
G1 X178.17 Y131.33 E.00921
G1 X155.67 Y108.83 E.5183
G1 X156.236 Y108.83 E.00921
G1 X178.17 Y130.764 E.50528
G1 X178.17 Y130.199 E.00921
G1 X156.801 Y108.83 E.49226
G1 X157.367 Y108.83 E.00921
G1 X178.17 Y129.633 E.47923
M73 P59 R25
G1 X178.17 Y129.068 E.00921
G1 X157.932 Y108.83 E.46621
G1 X158.497 Y108.83 E.00921
G1 X178.17 Y128.503 E.45318
G1 X178.17 Y127.937 E.00921
G1 X159.063 Y108.83 E.44016
G1 X159.628 Y108.83 E.00921
G1 X178.17 Y127.372 E.42713
G1 X178.17 Y126.806 E.00921
G1 X160.194 Y108.83 E.41411
M73 P60 R25
G1 X160.759 Y108.83 E.00921
G1 X178.17 Y126.241 E.40109
G1 X178.17 Y125.676 E.00921
G1 X161.324 Y108.83 E.38806
G1 X161.89 Y108.83 E.00921
G1 X178.17 Y125.11 E.37504
G1 X178.17 Y124.545 E.00921
G1 X162.455 Y108.83 E.36201
G1 X163.02 Y108.83 E.00921
G1 X178.17 Y123.98 E.34899
G1 X178.17 Y123.414 E.00921
G1 X163.586 Y108.83 E.33596
G1 X164.151 Y108.83 E.00921
G1 X178.17 Y122.849 E.32294
G1 X178.17 Y122.283 E.00921
G1 X164.717 Y108.83 E.30992
G1 X165.282 Y108.83 E.00921
G1 X178.17 Y121.718 E.29689
G1 X178.17 Y121.153 E.00921
G1 X165.847 Y108.83 E.28387
G1 X166.413 Y108.83 E.00921
G1 X178.17 Y120.587 E.27084
G1 X178.17 Y120.022 E.00921
G1 X166.978 Y108.83 E.25782
G1 X167.544 Y108.83 E.00921
G1 X178.17 Y119.456 E.24479
G1 X178.17 Y118.891 E.00921
G1 X168.109 Y108.83 E.23177
G1 X168.674 Y108.83 E.00921
G1 X178.17 Y118.326 E.21875
G1 X178.17 Y117.76 E.00921
G1 X169.24 Y108.83 E.20572
G1 X169.805 Y108.83 E.00921
G1 X178.17 Y117.195 E.1927
G1 X178.17 Y116.629 E.00921
G1 X170.37 Y108.83 E.17967
G1 X170.936 Y108.83 E.00921
G1 X178.17 Y116.064 E.16665
G1 X178.17 Y115.499 E.00921
G1 X171.501 Y108.83 E.15362
G1 X172.067 Y108.83 E.00921
G1 X178.17 Y114.933 E.1406
G1 X178.17 Y114.368 E.00921
G1 X172.632 Y108.83 E.12758
G1 X173.197 Y108.83 E.00921
G1 X178.17 Y113.803 E.11455
G1 X178.17 Y113.237 E.00921
G1 X173.763 Y108.83 E.10153
G1 X174.328 Y108.83 E.00921
G1 X178.17 Y112.672 E.0885
G1 X178.17 Y112.106 E.00921
G1 X174.894 Y108.83 E.07548
G1 X175.459 Y108.83 E.00921
G1 X178.17 Y111.541 E.06245
G1 X178.17 Y110.976 E.00921
G1 X176.024 Y108.83 E.04943
G1 X176.59 Y108.83 E.00921
G1 X178.17 Y110.41 E.03641
G1 X178.17 Y109.845 E.00921
G1 X177.155 Y108.83 E.02338
G1 X177.721 Y108.83 E.00921
G1 X178.35 Y109.459 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X177.721 Y108.83 E-.338
G1 X177.155 Y108.83 E-.21485
G1 X177.541 Y109.215 E-.20715
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/25
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M204 S10000
G17
G3 Z1.3 I-.765 J-.946 P1  F30000
G1 X134.085 Y144.357 Z1.3
G1 X51.016 Y211.534
G1 Z1
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #11
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.65 Y109.459 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X78.28 Y108.83 E.01447
G1 X78.844 Y108.83 E.00918
G1 X77.83 Y109.844 E.02333
G1 X77.83 Y110.409 E.00918
G1 X79.409 Y108.83 E.03631
G1 X79.973 Y108.83 E.00918
G1 X77.83 Y110.973 E.04929
G1 X77.83 Y111.538 E.00918
G1 X80.538 Y108.83 E.06228
G1 X81.102 Y108.83 E.00918
G1 X77.83 Y112.102 E.07526
G1 X77.83 Y112.667 E.00918
G1 X81.667 Y108.83 E.08824
G1 X82.231 Y108.83 E.00918
G1 X77.83 Y113.231 E.10123
G1 X77.83 Y113.796 E.00918
G1 X82.796 Y108.83 E.11421
G1 X83.36 Y108.83 E.00918
G1 X77.83 Y114.36 E.12719
G1 X77.83 Y114.925 E.00918
G1 X83.925 Y108.83 E.14017
G1 X84.489 Y108.83 E.00918
G1 X77.83 Y115.489 E.15316
G1 X77.83 Y116.054 E.00918
G1 X85.054 Y108.83 E.16614
G1 X85.618 Y108.83 E.00918
G1 X77.83 Y116.618 E.17912
G1 X77.83 Y117.182 E.00918
G1 X86.182 Y108.83 E.1921
G1 X86.747 Y108.83 E.00918
G1 X77.83 Y117.747 E.20509
G1 X77.83 Y118.311 E.00918
G1 X87.311 Y108.83 E.21807
G1 X87.876 Y108.83 E.00918
G1 X77.83 Y118.876 E.23105
G1 X77.83 Y119.44 E.00918
G1 X88.44 Y108.83 E.24403
G1 X89.005 Y108.83 E.00918
G1 X77.83 Y120.005 E.25702
G1 X77.83 Y120.569 E.00918
G1 X89.569 Y108.83 E.27
G1 X90.134 Y108.83 E.00918
G1 X77.83 Y121.134 E.28298
G1 X77.83 Y121.698 E.00918
G1 X90.698 Y108.83 E.29596
G1 X91.263 Y108.83 E.00918
G1 X77.83 Y122.263 E.30895
G1 X77.83 Y122.827 E.00918
G1 X91.827 Y108.83 E.32193
G1 X92.392 Y108.83 E.00918
G1 X77.83 Y123.392 E.33491
G1 X77.83 Y123.956 E.00918
G1 X92.956 Y108.83 E.3479
G1 X93.521 Y108.83 E.00918
G1 X77.83 Y124.521 E.36088
G1 X77.83 Y125.085 E.00918
M73 P61 R25
G1 X94.085 Y108.83 E.37386
G1 X94.65 Y108.83 E.00918
G1 X77.83 Y125.65 E.38684
G1 X77.83 Y126.214 E.00918
G1 X95.214 Y108.83 E.39983
G1 X95.779 Y108.83 E.00918
G1 X77.83 Y126.779 E.41281
G1 X77.83 Y127.343 E.00918
G1 X96.343 Y108.83 E.42579
G1 X96.908 Y108.83 E.00918
G1 X77.83 Y127.908 E.43877
G1 X77.83 Y128.472 E.00918
G1 X97.472 Y108.83 E.45176
G1 X98.037 Y108.83 E.00918
G1 X77.83 Y129.037 E.46474
G1 X77.83 Y129.601 E.00918
G1 X98.601 Y108.83 E.47772
G1 X99.166 Y108.83 E.00918
G1 X77.83 Y130.166 E.4907
G1 X77.83 Y130.73 E.00918
G1 X99.73 Y108.83 E.50369
G1 X100.295 Y108.83 E.00918
G1 X77.83 Y131.295 E.51667
G1 X77.83 Y131.859 E.00918
G1 X100.859 Y108.83 E.52965
G1 X101.424 Y108.83 E.00918
G1 X77.83 Y132.424 E.54263
G1 X77.83 Y132.988 E.00918
G1 X101.988 Y108.83 E.55562
G1 X102.552 Y108.83 E.00918
G1 X77.83 Y133.552 E.5686
G1 X77.83 Y134.117 E.00918
G1 X103.117 Y108.83 E.58158
G1 X103.681 Y108.83 E.00918
G1 X77.83 Y134.681 E.59457
G1 X77.83 Y135.246 E.00918
G1 X104.246 Y108.83 E.60755
G1 X104.81 Y108.83 E.00918
G1 X77.83 Y135.81 E.62053
G1 X77.83 Y136.375 E.00918
G1 X105.375 Y108.83 E.63351
G1 X105.939 Y108.83 E.00918
G1 X77.83 Y136.939 E.6465
G1 X77.83 Y137.504 E.00918
G1 X106.504 Y108.83 E.65948
G1 X107.068 Y108.83 E.00918
G1 X77.83 Y138.068 E.67246
G1 X77.83 Y138.633 E.00918
G1 X107.633 Y108.83 E.68544
G1 X108.197 Y108.83 E.00918
G1 X77.83 Y139.197 E.69843
G1 X77.83 Y139.762 E.00918
G1 X108.762 Y108.83 E.71141
G1 X109.326 Y108.83 E.00918
G1 X77.83 Y140.326 E.72439
G1 X77.83 Y140.891 E.00918
G1 X109.891 Y108.83 E.73737
G1 X110.455 Y108.83 E.00918
G1 X77.936 Y141.349 E.7479
G1 X78.219 Y141.631 E.00649
G1 X111.02 Y108.83 E.7544
G1 X111.584 Y108.83 E.00918
G1 X78.501 Y141.913 E.76089
G1 X78.783 Y142.195 E.00649
G1 X112.149 Y108.83 E.76738
G1 X112.713 Y108.83 E.00918
G1 X79.065 Y142.478 E.77387
G1 X79.348 Y142.76 E.00649
G1 X113.278 Y108.83 E.78036
G1 X113.842 Y108.83 E.00918
G1 X79.63 Y143.042 E.78685
G1 X79.758 Y143.17 E.00295
G1 X80.066 Y143.17 E.00501
G1 X114.407 Y108.83 E.7898
G1 X114.971 Y108.83 E.00918
G1 X80.631 Y143.17 E.7898
M73 P61 R24
G1 X81.195 Y143.17 E.00918
G1 X115.536 Y108.83 E.7898
G1 X116.1 Y108.83 E.00918
G1 X81.76 Y143.17 E.7898
G1 X82.324 Y143.17 E.00918
G1 X116.665 Y108.83 E.7898
G1 X117.229 Y108.83 E.00918
G1 X82.889 Y143.17 E.7898
G1 X83.453 Y143.17 E.00918
G1 X117.794 Y108.83 E.7898
G1 X118.358 Y108.83 E.00918
G1 X84.018 Y143.17 E.7898
G1 X84.582 Y143.17 E.00918
G1 X118.923 Y108.83 E.7898
G1 X119.487 Y108.83 E.00918
G1 X85.147 Y143.17 E.7898
G1 X85.711 Y143.17 E.00918
G1 X120.051 Y108.83 E.7898
G1 X120.616 Y108.83 E.00918
G1 X86.276 Y143.17 E.7898
G1 X86.84 Y143.17 E.00918
G1 X121.18 Y108.83 E.7898
G1 X121.745 Y108.83 E.00918
G1 X87.405 Y143.17 E.7898
G1 X87.969 Y143.17 E.00918
G1 X122.309 Y108.83 E.7898
G1 X122.874 Y108.83 E.00918
G1 X88.534 Y143.17 E.7898
G1 X89.098 Y143.17 E.00918
G1 X123.438 Y108.83 E.7898
G1 X124.003 Y108.83 E.00918
G1 X89.662 Y143.17 E.7898
G1 X90.227 Y143.17 E.00918
G1 X124.567 Y108.83 E.7898
G1 X125.132 Y108.83 E.00918
G1 X90.791 Y143.17 E.7898
G1 X91.356 Y143.17 E.00918
G1 X125.696 Y108.83 E.7898
G1 X126.261 Y108.83 E.00918
G1 X91.92 Y143.17 E.7898
G1 X92.485 Y143.17 E.00918
G1 X126.825 Y108.83 E.7898
G1 X127.39 Y108.83 E.00918
G1 X93.049 Y143.17 E.7898
G1 X93.614 Y143.17 E.00918
G1 X127.954 Y108.83 E.7898
G1 X128.519 Y108.83 E.00918
G1 X94.178 Y143.17 E.7898
G1 X94.743 Y143.17 E.00918
G1 X129.083 Y108.83 E.7898
G1 X129.648 Y108.83 E.00918
G1 X95.307 Y143.17 E.7898
G1 X95.872 Y143.17 E.00918
G1 X130.212 Y108.83 E.7898
G1 X130.777 Y108.83 E.00918
G1 X96.436 Y143.17 E.7898
G1 X97.001 Y143.17 E.00918
G1 X131.341 Y108.83 E.7898
G1 X131.906 Y108.83 E.00918
G1 X97.565 Y143.17 E.7898
G1 X98.13 Y143.17 E.00918
G1 X132.47 Y108.83 E.7898
G1 X133.035 Y108.83 E.00918
G1 X98.694 Y143.17 E.7898
G1 X99.259 Y143.17 E.00918
G1 X133.599 Y108.83 E.7898
G1 X134.164 Y108.83 E.00918
G1 X99.823 Y143.17 E.7898
G1 X100.388 Y143.17 E.00918
G1 X134.728 Y108.83 E.7898
G1 X135.293 Y108.83 E.00918
G1 X100.952 Y143.17 E.7898
G1 X101.517 Y143.17 E.00918
G1 X135.857 Y108.83 E.7898
G1 X136.421 Y108.83 E.00918
G1 X102.081 Y143.17 E.7898
G1 X102.646 Y143.17 E.00918
G1 X136.986 Y108.83 E.7898
G1 X137.55 Y108.83 E.00918
G1 X103.21 Y143.17 E.7898
G1 X103.775 Y143.17 E.00918
G1 X138.115 Y108.83 E.7898
G1 X138.679 Y108.83 E.00918
G1 X104.339 Y143.17 E.7898
G1 X104.904 Y143.17 E.00918
G1 X139.244 Y108.83 E.7898
G1 X139.808 Y108.83 E.00918
G1 X105.468 Y143.17 E.7898
G1 X106.033 Y143.17 E.00918
G1 X140.373 Y108.83 E.7898
G1 X140.937 Y108.83 E.00918
G1 X106.597 Y143.17 E.7898
G1 X107.161 Y143.17 E.00918
G1 X141.502 Y108.83 E.7898
G1 X142.066 Y108.83 E.00918
G1 X107.726 Y143.17 E.7898
G1 X108.29 Y143.17 E.00918
M73 P62 R24
G1 X142.631 Y108.83 E.7898
G1 X143.195 Y108.83 E.00918
G1 X108.855 Y143.17 E.7898
G1 X109.419 Y143.17 E.00918
G1 X143.76 Y108.83 E.7898
G1 X144.324 Y108.83 E.00918
G1 X109.984 Y143.17 E.7898
G1 X110.548 Y143.17 E.00918
G1 X144.889 Y108.83 E.7898
G1 X145.453 Y108.83 E.00918
G1 X111.113 Y143.17 E.7898
G1 X111.677 Y143.17 E.00918
G1 X146.018 Y108.83 E.7898
G1 X146.582 Y108.83 E.00918
G1 X112.242 Y143.17 E.7898
G1 X112.806 Y143.17 E.00918
G1 X147.147 Y108.83 E.7898
G1 X147.711 Y108.83 E.00918
G1 X113.371 Y143.17 E.7898
G1 X113.935 Y143.17 E.00918
G1 X148.276 Y108.83 E.7898
G1 X148.84 Y108.83 E.00918
G1 X114.5 Y143.17 E.7898
G1 X115.064 Y143.17 E.00918
G1 X149.405 Y108.83 E.7898
G1 X149.969 Y108.83 E.00918
G1 X115.629 Y143.17 E.7898
G1 X116.193 Y143.17 E.00918
G1 X150.534 Y108.83 E.7898
G1 X151.098 Y108.83 E.00918
G1 X116.758 Y143.17 E.7898
G1 X117.322 Y143.17 E.00918
G1 X151.663 Y108.83 E.7898
G1 X152.227 Y108.83 E.00918
G1 X117.887 Y143.17 E.7898
G1 X118.451 Y143.17 E.00918
G1 X152.792 Y108.83 E.7898
G1 X153.356 Y108.83 E.00918
G1 X119.016 Y143.17 E.7898
G1 X119.58 Y143.17 E.00918
G1 X153.92 Y108.83 E.7898
G1 X154.485 Y108.83 E.00918
G1 X120.145 Y143.17 E.7898
G1 X120.709 Y143.17 E.00918
G1 X155.049 Y108.83 E.7898
G1 X155.614 Y108.83 E.00918
G1 X121.274 Y143.17 E.7898
G1 X121.838 Y143.17 E.00918
G1 X156.178 Y108.83 E.7898
G1 X156.743 Y108.83 E.00918
G1 X122.403 Y143.17 E.7898
G1 X122.967 Y143.17 E.00918
G1 X157.307 Y108.83 E.7898
G1 X157.872 Y108.83 E.00918
G1 X123.532 Y143.17 E.7898
G1 X124.096 Y143.17 E.00918
G1 X158.436 Y108.83 E.7898
G1 X159.001 Y108.83 E.00918
G1 X124.66 Y143.17 E.7898
G1 X125.225 Y143.17 E.00918
G1 X159.565 Y108.83 E.7898
G1 X160.13 Y108.83 E.00918
G1 X125.789 Y143.17 E.7898
G1 X126.354 Y143.17 E.00918
G1 X160.694 Y108.83 E.7898
G1 X161.259 Y108.83 E.00918
G1 X126.918 Y143.17 E.7898
G1 X127.483 Y143.17 E.00918
G1 X161.823 Y108.83 E.7898
G1 X162.388 Y108.83 E.00918
G1 X128.047 Y143.17 E.7898
G1 X128.612 Y143.17 E.00918
G1 X162.952 Y108.83 E.7898
G1 X163.517 Y108.83 E.00918
G1 X129.176 Y143.17 E.7898
G1 X129.741 Y143.17 E.00918
G1 X164.081 Y108.83 E.7898
G1 X164.646 Y108.83 E.00918
G1 X130.305 Y143.17 E.7898
G1 X130.87 Y143.17 E.00918
G1 X165.21 Y108.83 E.7898
G1 X165.775 Y108.83 E.00918
G1 X131.434 Y143.17 E.7898
G1 X131.999 Y143.17 E.00918
G1 X166.339 Y108.83 E.7898
G1 X166.904 Y108.83 E.00918
G1 X132.563 Y143.17 E.7898
G1 X133.128 Y143.17 E.00918
G1 X167.468 Y108.83 E.7898
G1 X168.033 Y108.83 E.00918
G1 X133.692 Y143.17 E.7898
G1 X134.257 Y143.17 E.00918
G1 X168.597 Y108.83 E.7898
G1 X169.162 Y108.83 E.00918
G1 X134.821 Y143.17 E.7898
G1 X135.386 Y143.17 E.00918
G1 X169.726 Y108.83 E.7898
G1 X170.291 Y108.83 E.00918
G1 X135.95 Y143.17 E.7898
G1 X136.515 Y143.17 E.00918
G1 X170.855 Y108.83 E.7898
G1 X171.419 Y108.83 E.00918
G1 X137.079 Y143.17 E.7898
G1 X137.644 Y143.17 E.00918
G1 X171.984 Y108.83 E.7898
G1 X172.548 Y108.83 E.00918
G1 X138.208 Y143.17 E.7898
G1 X138.773 Y143.17 E.00918
G1 X173.113 Y108.83 E.7898
G1 X173.677 Y108.83 E.00918
G1 X139.337 Y143.17 E.7898
G1 X139.902 Y143.17 E.00918
G1 X174.242 Y108.83 E.7898
G1 X174.806 Y108.83 E.00918
G1 X140.466 Y143.17 E.7898
G1 X141.03 Y143.17 E.00918
G1 X175.371 Y108.83 E.7898
G1 X175.935 Y108.83 E.00918
G1 X141.595 Y143.17 E.7898
G1 X142.159 Y143.17 E.00918
G1 X176.5 Y108.83 E.7898
G1 X177.064 Y108.83 E.00918
G1 X142.724 Y143.17 E.7898
G1 X143.288 Y143.17 E.00918
G1 X177.629 Y108.83 E.7898
G1 X178.17 Y108.83 E.0088
G1 X178.17 Y108.853 E.00038
G1 X143.853 Y143.17 E.78927
G1 X144.417 Y143.17 E.00918
G1 X178.17 Y109.417 E.77628
M73 P63 R23
G1 X178.17 Y109.982 E.00918
G1 X144.982 Y143.17 E.7633
G1 X145.546 Y143.17 E.00918
G1 X178.17 Y110.546 E.75032
G1 X178.17 Y111.111 E.00918
G1 X146.111 Y143.17 E.73734
G1 X146.675 Y143.17 E.00918
G1 X178.17 Y111.675 E.72435
G1 X178.17 Y112.24 E.00918
G1 X147.24 Y143.17 E.71137
G1 X147.804 Y143.17 E.00918
G1 X178.17 Y112.804 E.69839
G1 X178.17 Y113.369 E.00918
G1 X148.369 Y143.17 E.68541
G1 X148.933 Y143.17 E.00918
G1 X178.17 Y113.933 E.67242
G1 X178.17 Y114.498 E.00918
G1 X149.498 Y143.17 E.65944
G1 X150.062 Y143.17 E.00918
G1 X178.17 Y115.062 E.64646
G1 X178.17 Y115.627 E.00918
G1 X150.627 Y143.17 E.63348
G1 X151.191 Y143.17 E.00918
G1 X178.17 Y116.191 E.62049
G1 X178.17 Y116.756 E.00918
G1 X151.756 Y143.17 E.60751
G1 X152.32 Y143.17 E.00918
G1 X178.17 Y117.32 E.59453
G1 X178.17 Y117.885 E.00918
G1 X152.885 Y143.17 E.58155
G1 X153.449 Y143.17 E.00918
G1 X178.17 Y118.449 E.56856
G1 X178.17 Y119.014 E.00918
G1 X154.014 Y143.17 E.55558
G1 X154.578 Y143.17 E.00918
G1 X178.17 Y119.578 E.5426
G1 X178.17 Y120.143 E.00918
G1 X155.143 Y143.17 E.52961
G1 X155.707 Y143.17 E.00918
G1 X178.17 Y120.707 E.51663
G1 X178.17 Y121.272 E.00918
G1 X156.272 Y143.17 E.50365
G1 X156.836 Y143.17 E.00918
G1 X178.17 Y121.836 E.49067
G1 X178.17 Y122.401 E.00918
G1 X157.401 Y143.17 E.47768
G1 X157.965 Y143.17 E.00918
G1 X178.17 Y122.965 E.4647
G1 X178.17 Y123.529 E.00918
G1 X158.529 Y143.17 E.45172
G1 X159.094 Y143.17 E.00918
G1 X178.17 Y124.094 E.43874
G1 X178.17 Y124.658 E.00918
G1 X159.658 Y143.17 E.42575
G1 X160.223 Y143.17 E.00918
G1 X178.17 Y125.223 E.41277
G1 X178.17 Y125.787 E.00918
G1 X160.787 Y143.17 E.39979
G1 X161.352 Y143.17 E.00918
G1 X178.17 Y126.352 E.38681
G1 X178.17 Y126.916 E.00918
G1 X161.916 Y143.17 E.37382
G1 X162.481 Y143.17 E.00918
G1 X178.17 Y127.481 E.36084
G1 X178.17 Y128.045 E.00918
G1 X163.045 Y143.17 E.34786
G1 X163.61 Y143.17 E.00918
G1 X178.17 Y128.61 E.33488
G1 X178.17 Y129.174 E.00918
G1 X164.174 Y143.17 E.32189
G1 X164.739 Y143.17 E.00918
G1 X178.17 Y129.739 E.30891
G1 X178.17 Y130.303 E.00918
G1 X165.303 Y143.17 E.29593
G1 X165.868 Y143.17 E.00918
G1 X178.17 Y130.868 E.28294
G1 X178.17 Y131.432 E.00918
G1 X166.432 Y143.17 E.26996
G1 X166.997 Y143.17 E.00918
G1 X178.17 Y131.997 E.25698
G1 X178.17 Y132.561 E.00918
G1 X167.561 Y143.17 E.244
G1 X168.126 Y143.17 E.00918
G1 X178.17 Y133.126 E.23101
G1 X178.17 Y133.69 E.00918
G1 X168.69 Y143.17 E.21803
G1 X169.255 Y143.17 E.00918
G1 X178.17 Y134.255 E.20505
G1 X178.17 Y134.819 E.00918
G1 X169.819 Y143.17 E.19207
G1 X170.384 Y143.17 E.00918
G1 X178.17 Y135.384 E.17908
G1 X178.17 Y135.948 E.00918
G1 X170.948 Y143.17 E.1661
G1 X171.513 Y143.17 E.00918
G1 X178.17 Y136.513 E.15312
G1 X178.17 Y137.077 E.00918
G1 X172.077 Y143.17 E.14014
G1 X172.642 Y143.17 E.00918
G1 X178.17 Y137.642 E.12715
G1 X178.17 Y138.206 E.00918
G1 X173.206 Y143.17 E.11417
G1 X173.771 Y143.17 E.00918
G1 X178.17 Y138.771 E.10119
G1 X178.17 Y139.335 E.00918
G1 X174.335 Y143.17 E.08821
G1 X174.899 Y143.17 E.00918
G1 X178.17 Y139.9 E.07522
G1 X178.17 Y140.464 E.00918
G1 X175.464 Y143.17 E.06224
G1 X176.028 Y143.17 E.00918
G1 X178.17 Y141.028 E.04926
G1 X178.17 Y141.593 E.00918
G1 X176.593 Y143.17 E.03627
G1 X177.157 Y143.17 E.00918
G1 X178.17 Y142.157 E.02329
G1 X178.17 Y142.722 E.00918
G1 X177.543 Y143.35 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 1.1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X178.17 Y142.722 E-.33727
G1 X178.17 Y142.157 E-.21451
G1 X177.783 Y142.545 E-.20822
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/25
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
M204 S10000
G17
G3 Z1.4 I-.582 J-1.069 P1  F30000
G1 X174.453 Y144.357 Z1.4
G1 X51.016 Y211.534
G1 Z1.1
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #12
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
M73 P64 R23
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z1.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.084 Y114.9 Z1.5 F30000
G1 X77.65 Y141.061 Z1.5
G1 Z1.1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X79.76 Y143.17 E.0486
G1 X80.325 Y143.17 E.00921
G1 X77.83 Y140.675 E.05749
G1 X77.83 Y140.109 E.00921
G1 X80.891 Y143.17 E.07051
G1 X81.456 Y143.17 E.00921
G1 X77.83 Y139.544 E.08354
G1 X77.83 Y138.978 E.00921
G1 X82.022 Y143.17 E.09656
G1 X82.587 Y143.17 E.00921
G1 X77.83 Y138.413 E.10959
G1 X77.83 Y137.848 E.00921
G1 X83.152 Y143.17 E.12261
G1 X83.718 Y143.17 E.00921
G1 X77.83 Y137.282 E.13563
G1 X77.83 Y136.717 E.00921
G1 X84.283 Y143.17 E.14866
G1 X84.849 Y143.17 E.00921
G1 X77.83 Y136.151 E.16168
G1 X77.83 Y135.586 E.00921
G1 X85.414 Y143.17 E.17471
G1 X85.979 Y143.17 E.00921
G1 X77.83 Y135.021 E.18773
G1 X77.83 Y134.455 E.00921
G1 X86.545 Y143.17 E.20076
G1 X87.11 Y143.17 E.00921
G1 X77.83 Y133.89 E.21378
G1 X77.83 Y133.325 E.00921
G1 X87.675 Y143.17 E.2268
G1 X88.241 Y143.17 E.00921
G1 X77.83 Y132.759 E.23983
G1 X77.83 Y132.194 E.00921
G1 X88.806 Y143.17 E.25285
G1 X89.372 Y143.17 E.00921
G1 X77.83 Y131.628 E.26588
G1 X77.83 Y131.063 E.00921
G1 X89.937 Y143.17 E.2789
G1 X90.502 Y143.17 E.00921
G1 X77.83 Y130.498 E.29193
G1 X77.83 Y129.932 E.00921
G1 X91.068 Y143.17 E.30495
G1 X91.633 Y143.17 E.00921
G1 X77.83 Y129.367 E.31797
G1 X77.83 Y128.801 E.00921
G1 X92.199 Y143.17 E.331
G1 X92.764 Y143.17 E.00921
G1 X77.83 Y128.236 E.34402
G1 X77.83 Y127.671 E.00921
G1 X93.329 Y143.17 E.35705
G1 X93.895 Y143.17 E.00921
G1 X77.83 Y127.105 E.37007
G1 X77.83 Y126.54 E.00921
G1 X94.46 Y143.17 E.3831
G1 X95.025 Y143.17 E.00921
G1 X77.83 Y125.974 E.39612
G1 X77.83 Y125.409 E.00921
G1 X95.591 Y143.17 E.40914
G1 X96.156 Y143.17 E.00921
G1 X77.83 Y124.844 E.42217
G1 X77.83 Y124.278 E.00921
G1 X96.722 Y143.17 E.43519
G1 X97.287 Y143.17 E.00921
G1 X77.83 Y123.713 E.44822
G1 X77.83 Y123.148 E.00921
G1 X97.852 Y143.17 E.46124
G1 X98.418 Y143.17 E.00921
G1 X77.83 Y122.582 E.47427
G1 X77.83 Y122.017 E.00921
G1 X98.983 Y143.17 E.48729
G1 X99.549 Y143.17 E.00921
G1 X77.83 Y121.451 E.50031
M73 P64 R22
G1 X77.83 Y120.886 E.00921
G1 X100.114 Y143.17 E.51334
G1 X100.679 Y143.17 E.00921
G1 X77.83 Y120.321 E.52636
G1 X77.83 Y119.755 E.00921
G1 X101.245 Y143.17 E.53939
G1 X101.81 Y143.17 E.00921
G1 X77.83 Y119.19 E.55241
G1 X77.83 Y118.624 E.00921
G1 X102.376 Y143.17 E.56544
G1 X102.941 Y143.17 E.00921
G1 X77.83 Y118.059 E.57846
G1 X77.83 Y117.494 E.00921
G1 X103.506 Y143.17 E.59148
G1 X104.072 Y143.17 E.00921
G1 X77.83 Y116.928 E.60451
G1 X77.83 Y116.363 E.00921
G1 X104.637 Y143.17 E.61753
G1 X105.202 Y143.17 E.00921
G1 X77.83 Y115.798 E.63056
G1 X77.83 Y115.232 E.00921
G1 X105.768 Y143.17 E.64358
G1 X106.333 Y143.17 E.00921
G1 X77.83 Y114.667 E.65661
G1 X77.83 Y114.101 E.00921
G1 X106.899 Y143.17 E.66963
G1 X107.464 Y143.17 E.00921
G1 X77.83 Y113.536 E.68265
G1 X77.83 Y112.971 E.00921
G1 X108.029 Y143.17 E.69568
G1 X108.595 Y143.17 E.00921
G1 X77.83 Y112.405 E.7087
G1 X77.83 Y111.84 E.00921
G1 X109.16 Y143.17 E.72173
G1 X109.726 Y143.17 E.00921
G1 X77.83 Y111.274 E.73475
G1 X77.83 Y110.709 E.00921
G1 X110.291 Y143.17 E.74778
G1 X110.856 Y143.17 E.00921
G1 X77.83 Y110.144 E.7608
G1 X77.83 Y109.578 E.00921
G1 X111.422 Y143.17 E.77382
G1 X111.987 Y143.17 E.00921
G1 X77.83 Y109.013 E.78685
G1 X77.83 Y108.83 E.00298
G1 X78.212 Y108.83 E.00623
G1 X112.553 Y143.17 E.79106
G1 X113.118 Y143.17 E.00921
G1 X78.778 Y108.83 E.79106
G1 X79.343 Y108.83 E.00921
G1 X113.683 Y143.17 E.79106
G1 X114.249 Y143.17 E.00921
G1 X79.908 Y108.83 E.79106
G1 X80.474 Y108.83 E.00921
G1 X114.814 Y143.17 E.79106
G1 X115.379 Y143.17 E.00921
G1 X81.039 Y108.83 E.79106
G1 X81.605 Y108.83 E.00921
G1 X115.945 Y143.17 E.79106
G1 X116.51 Y143.17 E.00921
G1 X82.17 Y108.83 E.79106
G1 X82.735 Y108.83 E.00921
G1 X117.076 Y143.17 E.79106
G1 X117.641 Y143.17 E.00921
G1 X83.301 Y108.83 E.79106
G1 X83.866 Y108.83 E.00921
G1 X118.206 Y143.17 E.79106
G1 X118.772 Y143.17 E.00921
G1 X84.431 Y108.83 E.79106
G1 X84.997 Y108.83 E.00921
G1 X119.337 Y143.17 E.79106
G1 X119.903 Y143.17 E.00921
G1 X85.562 Y108.83 E.79106
G1 X86.128 Y108.83 E.00921
G1 X120.468 Y143.17 E.79106
G1 X121.033 Y143.17 E.00921
G1 X86.693 Y108.83 E.79106
G1 X87.258 Y108.83 E.00921
G1 X121.599 Y143.17 E.79106
G1 X122.164 Y143.17 E.00921
G1 X87.824 Y108.83 E.79106
G1 X88.389 Y108.83 E.00921
G1 X122.73 Y143.17 E.79106
G1 X123.295 Y143.17 E.00921
G1 X88.955 Y108.83 E.79106
M73 P65 R22
G1 X89.52 Y108.83 E.00921
G1 X123.86 Y143.17 E.79106
G1 X124.426 Y143.17 E.00921
G1 X90.085 Y108.83 E.79106
G1 X90.651 Y108.83 E.00921
G1 X124.991 Y143.17 E.79106
G1 X125.556 Y143.17 E.00921
G1 X91.216 Y108.83 E.79106
G1 X91.782 Y108.83 E.00921
G1 X126.122 Y143.17 E.79106
G1 X126.687 Y143.17 E.00921
G1 X92.347 Y108.83 E.79106
G1 X92.912 Y108.83 E.00921
G1 X127.253 Y143.17 E.79106
G1 X127.818 Y143.17 E.00921
G1 X93.478 Y108.83 E.79106
G1 X94.043 Y108.83 E.00921
G1 X128.383 Y143.17 E.79106
G1 X128.949 Y143.17 E.00921
G1 X94.608 Y108.83 E.79106
G1 X95.174 Y108.83 E.00921
G1 X129.514 Y143.17 E.79106
G1 X130.08 Y143.17 E.00921
G1 X95.739 Y108.83 E.79106
G1 X96.305 Y108.83 E.00921
G1 X130.645 Y143.17 E.79106
G1 X131.21 Y143.17 E.00921
G1 X96.87 Y108.83 E.79106
G1 X97.435 Y108.83 E.00921
G1 X131.776 Y143.17 E.79106
G1 X132.341 Y143.17 E.00921
G1 X98.001 Y108.83 E.79106
G1 X98.566 Y108.83 E.00921
G1 X132.907 Y143.17 E.79106
G1 X133.472 Y143.17 E.00921
G1 X99.132 Y108.83 E.79106
G1 X99.697 Y108.83 E.00921
G1 X134.037 Y143.17 E.79106
G1 X134.603 Y143.17 E.00921
G1 X100.262 Y108.83 E.79106
G1 X100.828 Y108.83 E.00921
G1 X135.168 Y143.17 E.79106
G1 X135.733 Y143.17 E.00921
G1 X101.393 Y108.83 E.79106
G1 X101.958 Y108.83 E.00921
G1 X136.299 Y143.17 E.79106
G1 X136.864 Y143.17 E.00921
G1 X102.524 Y108.83 E.79106
G1 X103.089 Y108.83 E.00921
G1 X137.43 Y143.17 E.79106
G1 X137.995 Y143.17 E.00921
G1 X103.655 Y108.83 E.79106
G1 X104.22 Y108.83 E.00921
G1 X138.56 Y143.17 E.79106
G1 X139.126 Y143.17 E.00921
G1 X104.785 Y108.83 E.79106
G1 X105.351 Y108.83 E.00921
G1 X139.691 Y143.17 E.79106
G1 X140.257 Y143.17 E.00921
G1 X105.916 Y108.83 E.79106
G1 X106.482 Y108.83 E.00921
G1 X140.822 Y143.17 E.79106
G1 X141.387 Y143.17 E.00921
G1 X107.047 Y108.83 E.79106
G1 X107.612 Y108.83 E.00921
G1 X141.953 Y143.17 E.79106
G1 X142.518 Y143.17 E.00921
G1 X108.178 Y108.83 E.79106
G1 X108.743 Y108.83 E.00921
G1 X143.084 Y143.17 E.79106
G1 X143.649 Y143.17 E.00921
G1 X109.309 Y108.83 E.79106
G1 X109.874 Y108.83 E.00921
G1 X144.214 Y143.17 E.79106
G1 X144.78 Y143.17 E.00921
G1 X110.439 Y108.83 E.79106
G1 X111.005 Y108.83 E.00921
G1 X145.345 Y143.17 E.79106
G1 X145.91 Y143.17 E.00921
G1 X111.57 Y108.83 E.79106
G1 X112.135 Y108.83 E.00921
G1 X146.476 Y143.17 E.79106
G1 X147.041 Y143.17 E.00921
G1 X112.701 Y108.83 E.79106
G1 X113.266 Y108.83 E.00921
G1 X147.607 Y143.17 E.79106
G1 X148.172 Y143.17 E.00921
G1 X113.832 Y108.83 E.79106
G1 X114.397 Y108.83 E.00921
G1 X148.737 Y143.17 E.79106
G1 X149.303 Y143.17 E.00921
G1 X114.962 Y108.83 E.79106
G1 X115.528 Y108.83 E.00921
G1 X149.868 Y143.17 E.79106
G1 X150.434 Y143.17 E.00921
G1 X116.093 Y108.83 E.79106
G1 X116.659 Y108.83 E.00921
G1 X150.999 Y143.17 E.79106
G1 X151.564 Y143.17 E.00921
G1 X117.224 Y108.83 E.79106
G1 X117.789 Y108.83 E.00921
G1 X152.13 Y143.17 E.79106
G1 X152.695 Y143.17 E.00921
G1 X118.355 Y108.83 E.79106
G1 X118.92 Y108.83 E.00921
G1 X153.261 Y143.17 E.79106
G1 X153.826 Y143.17 E.00921
G1 X119.486 Y108.83 E.79106
G1 X120.051 Y108.83 E.00921
G1 X154.391 Y143.17 E.79106
G1 X154.957 Y143.17 E.00921
G1 X120.616 Y108.83 E.79106
G1 X121.182 Y108.83 E.00921
G1 X155.522 Y143.17 E.79106
G1 X156.087 Y143.17 E.00921
G1 X121.747 Y108.83 E.79106
G1 X122.312 Y108.83 E.00921
G1 X156.653 Y143.17 E.79106
G1 X157.218 Y143.17 E.00921
G1 X122.878 Y108.83 E.79106
G1 X123.443 Y108.83 E.00921
G1 X157.784 Y143.17 E.79106
G1 X158.349 Y143.17 E.00921
G1 X124.009 Y108.83 E.79106
G1 X124.574 Y108.83 E.00921
G1 X158.914 Y143.17 E.79106
G1 X159.48 Y143.17 E.00921
G1 X125.139 Y108.83 E.79106
G1 X125.705 Y108.83 E.00921
G1 X160.045 Y143.17 E.79106
G1 X160.611 Y143.17 E.00921
G1 X126.27 Y108.83 E.79106
G1 X126.836 Y108.83 E.00921
G1 X161.176 Y143.17 E.79106
G1 X161.741 Y143.17 E.00921
G1 X127.401 Y108.83 E.79106
G1 X127.966 Y108.83 E.00921
G1 X162.307 Y143.17 E.79106
G1 X162.872 Y143.17 E.00921
G1 X128.532 Y108.83 E.79106
G1 X129.097 Y108.83 E.00921
G1 X163.437 Y143.17 E.79106
G1 X164.003 Y143.17 E.00921
M73 P66 R22
G1 X129.663 Y108.83 E.79106
G1 X130.228 Y108.83 E.00921
G1 X164.568 Y143.17 E.79106
G1 X165.134 Y143.17 E.00921
G1 X130.793 Y108.83 E.79106
G1 X131.359 Y108.83 E.00921
G1 X165.699 Y143.17 E.79106
G1 X166.264 Y143.17 E.00921
G1 X131.924 Y108.83 E.79106
G1 X132.489 Y108.83 E.00921
M73 P66 R21
G1 X166.83 Y143.17 E.79106
G1 X167.395 Y143.17 E.00921
G1 X133.055 Y108.83 E.79106
G1 X133.62 Y108.83 E.00921
G1 X167.961 Y143.17 E.79106
G1 X168.526 Y143.17 E.00921
G1 X134.186 Y108.83 E.79106
G1 X134.751 Y108.83 E.00921
G1 X169.091 Y143.17 E.79106
G1 X169.657 Y143.17 E.00921
G1 X135.316 Y108.83 E.79106
G1 X135.882 Y108.83 E.00921
G1 X170.222 Y143.17 E.79106
G1 X170.788 Y143.17 E.00921
G1 X136.447 Y108.83 E.79106
G1 X137.013 Y108.83 E.00921
G1 X171.353 Y143.17 E.79106
G1 X171.918 Y143.17 E.00921
G1 X137.578 Y108.83 E.79106
G1 X138.143 Y108.83 E.00921
G1 X172.484 Y143.17 E.79106
G1 X173.049 Y143.17 E.00921
G1 X138.709 Y108.83 E.79106
G1 X139.274 Y108.83 E.00921
G1 X173.614 Y143.17 E.79106
G1 X174.18 Y143.17 E.00921
G1 X139.84 Y108.83 E.79106
G1 X140.405 Y108.83 E.00921
G1 X174.745 Y143.17 E.79106
G1 X175.311 Y143.17 E.00921
G1 X140.97 Y108.83 E.79106
G1 X141.536 Y108.83 E.00921
G1 X175.876 Y143.17 E.79106
G1 X176.441 Y143.17 E.00921
G1 X142.101 Y108.83 E.79106
G1 X142.666 Y108.83 E.00921
G1 X177.007 Y143.17 E.79106
G1 X177.572 Y143.17 E.00921
G1 X143.232 Y108.83 E.79106
G1 X143.797 Y108.83 E.00921
G1 X178.138 Y143.17 E.79106
G1 X178.17 Y143.17 E.00053
G1 X178.17 Y142.637 E.00868
G1 X144.363 Y108.83 E.77879
G1 X144.928 Y108.83 E.00921
G1 X178.17 Y142.072 E.76577
G1 X178.17 Y141.507 E.00921
G1 X145.493 Y108.83 E.75274
G1 X146.059 Y108.83 E.00921
G1 X178.17 Y140.941 E.73972
G1 X178.17 Y140.376 E.00921
G1 X146.624 Y108.83 E.72669
G1 X147.19 Y108.83 E.00921
G1 X178.17 Y139.81 E.71367
G1 X178.17 Y139.245 E.00921
G1 X147.755 Y108.83 E.70064
G1 X148.32 Y108.83 E.00921
G1 X178.17 Y138.68 E.68762
G1 X178.17 Y138.114 E.00921
G1 X148.886 Y108.83 E.6746
G1 X149.451 Y108.83 E.00921
G1 X178.17 Y137.549 E.66157
G1 X178.17 Y136.983 E.00921
G1 X150.017 Y108.83 E.64855
G1 X150.582 Y108.83 E.00921
G1 X178.17 Y136.418 E.63552
G1 X178.17 Y135.853 E.00921
G1 X151.147 Y108.83 E.6225
G1 X151.713 Y108.83 E.00921
G1 X178.17 Y135.287 E.60947
G1 X178.17 Y134.722 E.00921
G1 X152.278 Y108.83 E.59645
G1 X152.843 Y108.83 E.00921
G1 X178.17 Y134.157 E.58343
G1 X178.17 Y133.591 E.00921
G1 X153.409 Y108.83 E.5704
G1 X153.974 Y108.83 E.00921
G1 X178.17 Y133.026 E.55738
G1 X178.17 Y132.46 E.00921
G1 X154.54 Y108.83 E.54435
G1 X155.105 Y108.83 E.00921
G1 X178.17 Y131.895 E.53133
G1 X178.17 Y131.33 E.00921
G1 X155.67 Y108.83 E.5183
G1 X156.236 Y108.83 E.00921
G1 X178.17 Y130.764 E.50528
G1 X178.17 Y130.199 E.00921
G1 X156.801 Y108.83 E.49226
G1 X157.367 Y108.83 E.00921
G1 X178.17 Y129.633 E.47923
G1 X178.17 Y129.068 E.00921
G1 X157.932 Y108.83 E.46621
G1 X158.497 Y108.83 E.00921
G1 X178.17 Y128.503 E.45318
G1 X178.17 Y127.937 E.00921
G1 X159.063 Y108.83 E.44016
G1 X159.628 Y108.83 E.00921
G1 X178.17 Y127.372 E.42713
G1 X178.17 Y126.806 E.00921
G1 X160.194 Y108.83 E.41411
G1 X160.759 Y108.83 E.00921
G1 X178.17 Y126.241 E.40109
G1 X178.17 Y125.676 E.00921
G1 X161.324 Y108.83 E.38806
G1 X161.89 Y108.83 E.00921
G1 X178.17 Y125.11 E.37504
G1 X178.17 Y124.545 E.00921
G1 X162.455 Y108.83 E.36201
G1 X163.02 Y108.83 E.00921
G1 X178.17 Y123.98 E.34899
G1 X178.17 Y123.414 E.00921
G1 X163.586 Y108.83 E.33596
G1 X164.151 Y108.83 E.00921
G1 X178.17 Y122.849 E.32294
G1 X178.17 Y122.283 E.00921
G1 X164.717 Y108.83 E.30992
G1 X165.282 Y108.83 E.00921
G1 X178.17 Y121.718 E.29689
G1 X178.17 Y121.153 E.00921
G1 X165.847 Y108.83 E.28387
M73 P67 R21
G1 X166.413 Y108.83 E.00921
G1 X178.17 Y120.587 E.27084
G1 X178.17 Y120.022 E.00921
G1 X166.978 Y108.83 E.25782
G1 X167.544 Y108.83 E.00921
G1 X178.17 Y119.456 E.24479
G1 X178.17 Y118.891 E.00921
G1 X168.109 Y108.83 E.23177
G1 X168.674 Y108.83 E.00921
G1 X178.17 Y118.326 E.21875
G1 X178.17 Y117.76 E.00921
G1 X169.24 Y108.83 E.20572
G1 X169.805 Y108.83 E.00921
G1 X178.17 Y117.195 E.1927
G1 X178.17 Y116.629 E.00921
G1 X170.37 Y108.83 E.17967
G1 X170.936 Y108.83 E.00921
G1 X178.17 Y116.064 E.16665
G1 X178.17 Y115.499 E.00921
G1 X171.501 Y108.83 E.15362
G1 X172.067 Y108.83 E.00921
G1 X178.17 Y114.933 E.1406
G1 X178.17 Y114.368 E.00921
G1 X172.632 Y108.83 E.12758
G1 X173.197 Y108.83 E.00921
G1 X178.17 Y113.803 E.11455
G1 X178.17 Y113.237 E.00921
G1 X173.763 Y108.83 E.10153
G1 X174.328 Y108.83 E.00921
G1 X178.17 Y112.672 E.0885
G1 X178.17 Y112.106 E.00921
G1 X174.894 Y108.83 E.07548
G1 X175.459 Y108.83 E.00921
G1 X178.17 Y111.541 E.06245
G1 X178.17 Y110.976 E.00921
G1 X176.024 Y108.83 E.04943
G1 X176.59 Y108.83 E.00921
G1 X178.17 Y110.41 E.03641
G1 X178.17 Y109.845 E.00921
G1 X177.155 Y108.83 E.02338
G1 X177.721 Y108.83 E.00921
G1 X178.35 Y109.459 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X177.721 Y108.83 E-.338
G1 X177.155 Y108.83 E-.21485
G1 X177.541 Y109.215 E-.20715
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/25
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
M204 S10000
G17
G3 Z1.5 I-.765 J-.946 P1  F30000
G1 X134.085 Y144.357 Z1.5
G1 X51.016 Y211.534
G1 Z1.2
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #13
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
M73 P67 R20
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.65 Y109.459 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X78.28 Y108.83 E.01447
G1 X78.844 Y108.83 E.00918
G1 X77.83 Y109.844 E.02333
G1 X77.83 Y110.409 E.00918
G1 X79.409 Y108.83 E.03631
G1 X79.973 Y108.83 E.00918
G1 X77.83 Y110.973 E.04929
G1 X77.83 Y111.538 E.00918
G1 X80.538 Y108.83 E.06228
G1 X81.102 Y108.83 E.00918
G1 X77.83 Y112.102 E.07526
G1 X77.83 Y112.667 E.00918
G1 X81.667 Y108.83 E.08824
G1 X82.231 Y108.83 E.00918
G1 X77.83 Y113.231 E.10123
G1 X77.83 Y113.796 E.00918
G1 X82.796 Y108.83 E.11421
G1 X83.36 Y108.83 E.00918
G1 X77.83 Y114.36 E.12719
G1 X77.83 Y114.925 E.00918
G1 X83.925 Y108.83 E.14017
G1 X84.489 Y108.83 E.00918
G1 X77.83 Y115.489 E.15316
G1 X77.83 Y116.054 E.00918
G1 X85.054 Y108.83 E.16614
G1 X85.618 Y108.83 E.00918
G1 X77.83 Y116.618 E.17912
G1 X77.83 Y117.182 E.00918
G1 X86.182 Y108.83 E.1921
G1 X86.747 Y108.83 E.00918
G1 X77.83 Y117.747 E.20509
G1 X77.83 Y118.311 E.00918
G1 X87.311 Y108.83 E.21807
G1 X87.876 Y108.83 E.00918
G1 X77.83 Y118.876 E.23105
G1 X77.83 Y119.44 E.00918
G1 X88.44 Y108.83 E.24403
G1 X89.005 Y108.83 E.00918
G1 X77.83 Y120.005 E.25702
G1 X77.83 Y120.569 E.00918
G1 X89.569 Y108.83 E.27
G1 X90.134 Y108.83 E.00918
G1 X77.83 Y121.134 E.28298
G1 X77.83 Y121.698 E.00918
G1 X90.698 Y108.83 E.29596
G1 X91.263 Y108.83 E.00918
G1 X77.83 Y122.263 E.30895
G1 X77.83 Y122.827 E.00918
G1 X91.827 Y108.83 E.32193
G1 X92.392 Y108.83 E.00918
G1 X77.83 Y123.392 E.33491
G1 X77.83 Y123.956 E.00918
G1 X92.956 Y108.83 E.3479
G1 X93.521 Y108.83 E.00918
G1 X77.83 Y124.521 E.36088
G1 X77.83 Y125.085 E.00918
G1 X94.085 Y108.83 E.37386
G1 X94.65 Y108.83 E.00918
G1 X77.83 Y125.65 E.38684
G1 X77.83 Y126.214 E.00918
G1 X95.214 Y108.83 E.39983
G1 X95.779 Y108.83 E.00918
G1 X77.83 Y126.779 E.41281
G1 X77.83 Y127.343 E.00918
G1 X96.343 Y108.83 E.42579
G1 X96.908 Y108.83 E.00918
G1 X77.83 Y127.908 E.43877
G1 X77.83 Y128.472 E.00918
G1 X97.472 Y108.83 E.45176
G1 X98.037 Y108.83 E.00918
G1 X77.83 Y129.037 E.46474
G1 X77.83 Y129.601 E.00918
G1 X98.601 Y108.83 E.47772
M73 P68 R20
G1 X99.166 Y108.83 E.00918
G1 X77.83 Y130.166 E.4907
G1 X77.83 Y130.73 E.00918
G1 X99.73 Y108.83 E.50369
G1 X100.295 Y108.83 E.00918
G1 X77.83 Y131.295 E.51667
G1 X77.83 Y131.859 E.00918
G1 X100.859 Y108.83 E.52965
G1 X101.424 Y108.83 E.00918
G1 X77.83 Y132.424 E.54263
G1 X77.83 Y132.988 E.00918
G1 X101.988 Y108.83 E.55562
G1 X102.552 Y108.83 E.00918
G1 X77.83 Y133.552 E.5686
G1 X77.83 Y134.117 E.00918
G1 X103.117 Y108.83 E.58158
G1 X103.681 Y108.83 E.00918
G1 X77.83 Y134.681 E.59457
G1 X77.83 Y135.246 E.00918
G1 X104.246 Y108.83 E.60755
G1 X104.81 Y108.83 E.00918
G1 X77.83 Y135.81 E.62053
G1 X77.83 Y136.375 E.00918
G1 X105.375 Y108.83 E.63351
G1 X105.939 Y108.83 E.00918
G1 X77.83 Y136.939 E.6465
G1 X77.83 Y137.504 E.00918
G1 X106.504 Y108.83 E.65948
G1 X107.068 Y108.83 E.00918
G1 X77.83 Y138.068 E.67246
G1 X77.83 Y138.633 E.00918
G1 X107.633 Y108.83 E.68544
G1 X108.197 Y108.83 E.00918
G1 X77.83 Y139.197 E.69843
G1 X77.83 Y139.762 E.00918
G1 X108.762 Y108.83 E.71141
G1 X109.326 Y108.83 E.00918
G1 X77.83 Y140.326 E.72439
G1 X77.83 Y140.891 E.00918
G1 X109.891 Y108.83 E.73737
G1 X110.455 Y108.83 E.00918
G1 X77.936 Y141.349 E.7479
G1 X78.219 Y141.631 E.00649
G1 X111.02 Y108.83 E.7544
G1 X111.584 Y108.83 E.00918
G1 X78.501 Y141.913 E.76089
G1 X78.783 Y142.195 E.00649
G1 X112.149 Y108.83 E.76738
G1 X112.713 Y108.83 E.00918
G1 X79.065 Y142.478 E.77387
G1 X79.348 Y142.76 E.00649
G1 X113.278 Y108.83 E.78036
G1 X113.842 Y108.83 E.00918
G1 X79.63 Y143.042 E.78685
G1 X79.758 Y143.17 E.00295
G1 X80.066 Y143.17 E.00501
G1 X114.407 Y108.83 E.7898
G1 X114.971 Y108.83 E.00918
G1 X80.631 Y143.17 E.7898
G1 X81.195 Y143.17 E.00918
G1 X115.536 Y108.83 E.7898
G1 X116.1 Y108.83 E.00918
G1 X81.76 Y143.17 E.7898
G1 X82.324 Y143.17 E.00918
G1 X116.665 Y108.83 E.7898
G1 X117.229 Y108.83 E.00918
G1 X82.889 Y143.17 E.7898
G1 X83.453 Y143.17 E.00918
G1 X117.794 Y108.83 E.7898
G1 X118.358 Y108.83 E.00918
G1 X84.018 Y143.17 E.7898
G1 X84.582 Y143.17 E.00918
G1 X118.923 Y108.83 E.7898
G1 X119.487 Y108.83 E.00918
G1 X85.147 Y143.17 E.7898
G1 X85.711 Y143.17 E.00918
G1 X120.051 Y108.83 E.7898
G1 X120.616 Y108.83 E.00918
G1 X86.276 Y143.17 E.7898
G1 X86.84 Y143.17 E.00918
G1 X121.18 Y108.83 E.7898
G1 X121.745 Y108.83 E.00918
G1 X87.405 Y143.17 E.7898
G1 X87.969 Y143.17 E.00918
G1 X122.309 Y108.83 E.7898
G1 X122.874 Y108.83 E.00918
G1 X88.534 Y143.17 E.7898
G1 X89.098 Y143.17 E.00918
G1 X123.438 Y108.83 E.7898
G1 X124.003 Y108.83 E.00918
G1 X89.662 Y143.17 E.7898
G1 X90.227 Y143.17 E.00918
G1 X124.567 Y108.83 E.7898
G1 X125.132 Y108.83 E.00918
G1 X90.791 Y143.17 E.7898
G1 X91.356 Y143.17 E.00918
G1 X125.696 Y108.83 E.7898
G1 X126.261 Y108.83 E.00918
G1 X91.92 Y143.17 E.7898
G1 X92.485 Y143.17 E.00918
G1 X126.825 Y108.83 E.7898
G1 X127.39 Y108.83 E.00918
G1 X93.049 Y143.17 E.7898
G1 X93.614 Y143.17 E.00918
G1 X127.954 Y108.83 E.7898
G1 X128.519 Y108.83 E.00918
G1 X94.178 Y143.17 E.7898
G1 X94.743 Y143.17 E.00918
G1 X129.083 Y108.83 E.7898
G1 X129.648 Y108.83 E.00918
G1 X95.307 Y143.17 E.7898
G1 X95.872 Y143.17 E.00918
G1 X130.212 Y108.83 E.7898
G1 X130.777 Y108.83 E.00918
G1 X96.436 Y143.17 E.7898
G1 X97.001 Y143.17 E.00918
G1 X131.341 Y108.83 E.7898
G1 X131.906 Y108.83 E.00918
G1 X97.565 Y143.17 E.7898
G1 X98.13 Y143.17 E.00918
G1 X132.47 Y108.83 E.7898
G1 X133.035 Y108.83 E.00918
G1 X98.694 Y143.17 E.7898
G1 X99.259 Y143.17 E.00918
G1 X133.599 Y108.83 E.7898
G1 X134.164 Y108.83 E.00918
G1 X99.823 Y143.17 E.7898
G1 X100.388 Y143.17 E.00918
G1 X134.728 Y108.83 E.7898
G1 X135.293 Y108.83 E.00918
G1 X100.952 Y143.17 E.7898
G1 X101.517 Y143.17 E.00918
G1 X135.857 Y108.83 E.7898
G1 X136.421 Y108.83 E.00918
G1 X102.081 Y143.17 E.7898
G1 X102.646 Y143.17 E.00918
G1 X136.986 Y108.83 E.7898
G1 X137.55 Y108.83 E.00918
G1 X103.21 Y143.17 E.7898
G1 X103.775 Y143.17 E.00918
G1 X138.115 Y108.83 E.7898
G1 X138.679 Y108.83 E.00918
G1 X104.339 Y143.17 E.7898
G1 X104.904 Y143.17 E.00918
G1 X139.244 Y108.83 E.7898
G1 X139.808 Y108.83 E.00918
G1 X105.468 Y143.17 E.7898
G1 X106.033 Y143.17 E.00918
G1 X140.373 Y108.83 E.7898
G1 X140.937 Y108.83 E.00918
G1 X106.597 Y143.17 E.7898
G1 X107.161 Y143.17 E.00918
G1 X141.502 Y108.83 E.7898
G1 X142.066 Y108.83 E.00918
G1 X107.726 Y143.17 E.7898
G1 X108.29 Y143.17 E.00918
G1 X142.631 Y108.83 E.7898
G1 X143.195 Y108.83 E.00918
G1 X108.855 Y143.17 E.7898
G1 X109.419 Y143.17 E.00918
G1 X143.76 Y108.83 E.7898
G1 X144.324 Y108.83 E.00918
G1 X109.984 Y143.17 E.7898
G1 X110.548 Y143.17 E.00918
G1 X144.889 Y108.83 E.7898
G1 X145.453 Y108.83 E.00918
G1 X111.113 Y143.17 E.7898
G1 X111.677 Y143.17 E.00918
G1 X146.018 Y108.83 E.7898
G1 X146.582 Y108.83 E.00918
G1 X112.242 Y143.17 E.7898
G1 X112.806 Y143.17 E.00918
G1 X147.147 Y108.83 E.7898
G1 X147.711 Y108.83 E.00918
G1 X113.371 Y143.17 E.7898
G1 X113.935 Y143.17 E.00918
M73 P69 R20
G1 X148.276 Y108.83 E.7898
G1 X148.84 Y108.83 E.00918
G1 X114.5 Y143.17 E.7898
G1 X115.064 Y143.17 E.00918
G1 X149.405 Y108.83 E.7898
G1 X149.969 Y108.83 E.00918
G1 X115.629 Y143.17 E.7898
G1 X116.193 Y143.17 E.00918
G1 X150.534 Y108.83 E.7898
G1 X151.098 Y108.83 E.00918
G1 X116.758 Y143.17 E.7898
G1 X117.322 Y143.17 E.00918
G1 X151.663 Y108.83 E.7898
G1 X152.227 Y108.83 E.00918
G1 X117.887 Y143.17 E.7898
G1 X118.451 Y143.17 E.00918
G1 X152.792 Y108.83 E.7898
G1 X153.356 Y108.83 E.00918
G1 X119.016 Y143.17 E.7898
G1 X119.58 Y143.17 E.00918
G1 X153.92 Y108.83 E.7898
G1 X154.485 Y108.83 E.00918
M73 P69 R19
G1 X120.145 Y143.17 E.7898
G1 X120.709 Y143.17 E.00918
G1 X155.049 Y108.83 E.7898
G1 X155.614 Y108.83 E.00918
G1 X121.274 Y143.17 E.7898
G1 X121.838 Y143.17 E.00918
G1 X156.178 Y108.83 E.7898
G1 X156.743 Y108.83 E.00918
G1 X122.403 Y143.17 E.7898
G1 X122.967 Y143.17 E.00918
G1 X157.307 Y108.83 E.7898
G1 X157.872 Y108.83 E.00918
G1 X123.532 Y143.17 E.7898
G1 X124.096 Y143.17 E.00918
G1 X158.436 Y108.83 E.7898
G1 X159.001 Y108.83 E.00918
G1 X124.66 Y143.17 E.7898
G1 X125.225 Y143.17 E.00918
G1 X159.565 Y108.83 E.7898
G1 X160.13 Y108.83 E.00918
G1 X125.789 Y143.17 E.7898
G1 X126.354 Y143.17 E.00918
G1 X160.694 Y108.83 E.7898
G1 X161.259 Y108.83 E.00918
G1 X126.918 Y143.17 E.7898
G1 X127.483 Y143.17 E.00918
G1 X161.823 Y108.83 E.7898
G1 X162.388 Y108.83 E.00918
G1 X128.047 Y143.17 E.7898
G1 X128.612 Y143.17 E.00918
G1 X162.952 Y108.83 E.7898
G1 X163.517 Y108.83 E.00918
G1 X129.176 Y143.17 E.7898
G1 X129.741 Y143.17 E.00918
G1 X164.081 Y108.83 E.7898
G1 X164.646 Y108.83 E.00918
G1 X130.305 Y143.17 E.7898
G1 X130.87 Y143.17 E.00918
G1 X165.21 Y108.83 E.7898
G1 X165.775 Y108.83 E.00918
G1 X131.434 Y143.17 E.7898
G1 X131.999 Y143.17 E.00918
G1 X166.339 Y108.83 E.7898
G1 X166.904 Y108.83 E.00918
G1 X132.563 Y143.17 E.7898
G1 X133.128 Y143.17 E.00918
G1 X167.468 Y108.83 E.7898
G1 X168.033 Y108.83 E.00918
G1 X133.692 Y143.17 E.7898
G1 X134.257 Y143.17 E.00918
G1 X168.597 Y108.83 E.7898
G1 X169.162 Y108.83 E.00918
G1 X134.821 Y143.17 E.7898
G1 X135.386 Y143.17 E.00918
G1 X169.726 Y108.83 E.7898
G1 X170.291 Y108.83 E.00918
G1 X135.95 Y143.17 E.7898
G1 X136.515 Y143.17 E.00918
G1 X170.855 Y108.83 E.7898
G1 X171.419 Y108.83 E.00918
G1 X137.079 Y143.17 E.7898
G1 X137.644 Y143.17 E.00918
G1 X171.984 Y108.83 E.7898
G1 X172.548 Y108.83 E.00918
G1 X138.208 Y143.17 E.7898
G1 X138.773 Y143.17 E.00918
G1 X173.113 Y108.83 E.7898
G1 X173.677 Y108.83 E.00918
G1 X139.337 Y143.17 E.7898
G1 X139.902 Y143.17 E.00918
G1 X174.242 Y108.83 E.7898
G1 X174.806 Y108.83 E.00918
G1 X140.466 Y143.17 E.7898
G1 X141.03 Y143.17 E.00918
G1 X175.371 Y108.83 E.7898
G1 X175.935 Y108.83 E.00918
G1 X141.595 Y143.17 E.7898
G1 X142.159 Y143.17 E.00918
G1 X176.5 Y108.83 E.7898
G1 X177.064 Y108.83 E.00918
G1 X142.724 Y143.17 E.7898
G1 X143.288 Y143.17 E.00918
G1 X177.629 Y108.83 E.7898
G1 X178.17 Y108.83 E.0088
G1 X178.17 Y108.853 E.00038
G1 X143.853 Y143.17 E.78927
G1 X144.417 Y143.17 E.00918
G1 X178.17 Y109.417 E.77628
G1 X178.17 Y109.982 E.00918
G1 X144.982 Y143.17 E.7633
G1 X145.546 Y143.17 E.00918
G1 X178.17 Y110.546 E.75032
G1 X178.17 Y111.111 E.00918
G1 X146.111 Y143.17 E.73734
G1 X146.675 Y143.17 E.00918
G1 X178.17 Y111.675 E.72435
G1 X178.17 Y112.24 E.00918
G1 X147.24 Y143.17 E.71137
G1 X147.804 Y143.17 E.00918
G1 X178.17 Y112.804 E.69839
G1 X178.17 Y113.369 E.00918
G1 X148.369 Y143.17 E.68541
G1 X148.933 Y143.17 E.00918
G1 X178.17 Y113.933 E.67242
G1 X178.17 Y114.498 E.00918
G1 X149.498 Y143.17 E.65944
G1 X150.062 Y143.17 E.00918
G1 X178.17 Y115.062 E.64646
M73 P70 R19
G1 X178.17 Y115.627 E.00918
G1 X150.627 Y143.17 E.63348
G1 X151.191 Y143.17 E.00918
G1 X178.17 Y116.191 E.62049
G1 X178.17 Y116.756 E.00918
G1 X151.756 Y143.17 E.60751
G1 X152.32 Y143.17 E.00918
G1 X178.17 Y117.32 E.59453
G1 X178.17 Y117.885 E.00918
G1 X152.885 Y143.17 E.58155
G1 X153.449 Y143.17 E.00918
G1 X178.17 Y118.449 E.56856
G1 X178.17 Y119.014 E.00918
G1 X154.014 Y143.17 E.55558
G1 X154.578 Y143.17 E.00918
G1 X178.17 Y119.578 E.5426
G1 X178.17 Y120.143 E.00918
G1 X155.143 Y143.17 E.52961
G1 X155.707 Y143.17 E.00918
G1 X178.17 Y120.707 E.51663
G1 X178.17 Y121.272 E.00918
G1 X156.272 Y143.17 E.50365
G1 X156.836 Y143.17 E.00918
G1 X178.17 Y121.836 E.49067
G1 X178.17 Y122.401 E.00918
G1 X157.401 Y143.17 E.47768
G1 X157.965 Y143.17 E.00918
G1 X178.17 Y122.965 E.4647
G1 X178.17 Y123.529 E.00918
G1 X158.529 Y143.17 E.45172
G1 X159.094 Y143.17 E.00918
G1 X178.17 Y124.094 E.43874
G1 X178.17 Y124.658 E.00918
G1 X159.658 Y143.17 E.42575
G1 X160.223 Y143.17 E.00918
G1 X178.17 Y125.223 E.41277
G1 X178.17 Y125.787 E.00918
G1 X160.787 Y143.17 E.39979
G1 X161.352 Y143.17 E.00918
G1 X178.17 Y126.352 E.38681
G1 X178.17 Y126.916 E.00918
G1 X161.916 Y143.17 E.37382
G1 X162.481 Y143.17 E.00918
G1 X178.17 Y127.481 E.36084
G1 X178.17 Y128.045 E.00918
G1 X163.045 Y143.17 E.34786
G1 X163.61 Y143.17 E.00918
G1 X178.17 Y128.61 E.33488
G1 X178.17 Y129.174 E.00918
G1 X164.174 Y143.17 E.32189
G1 X164.739 Y143.17 E.00918
G1 X178.17 Y129.739 E.30891
G1 X178.17 Y130.303 E.00918
G1 X165.303 Y143.17 E.29593
G1 X165.868 Y143.17 E.00918
G1 X178.17 Y130.868 E.28294
G1 X178.17 Y131.432 E.00918
G1 X166.432 Y143.17 E.26996
G1 X166.997 Y143.17 E.00918
G1 X178.17 Y131.997 E.25698
G1 X178.17 Y132.561 E.00918
G1 X167.561 Y143.17 E.244
G1 X168.126 Y143.17 E.00918
G1 X178.17 Y133.126 E.23101
G1 X178.17 Y133.69 E.00918
G1 X168.69 Y143.17 E.21803
G1 X169.255 Y143.17 E.00918
G1 X178.17 Y134.255 E.20505
G1 X178.17 Y134.819 E.00918
G1 X169.819 Y143.17 E.19207
G1 X170.384 Y143.17 E.00918
G1 X178.17 Y135.384 E.17908
G1 X178.17 Y135.948 E.00918
G1 X170.948 Y143.17 E.1661
G1 X171.513 Y143.17 E.00918
G1 X178.17 Y136.513 E.15312
G1 X178.17 Y137.077 E.00918
G1 X172.077 Y143.17 E.14014
G1 X172.642 Y143.17 E.00918
G1 X178.17 Y137.642 E.12715
G1 X178.17 Y138.206 E.00918
G1 X173.206 Y143.17 E.11417
G1 X173.771 Y143.17 E.00918
G1 X178.17 Y138.771 E.10119
G1 X178.17 Y139.335 E.00918
G1 X174.335 Y143.17 E.08821
G1 X174.899 Y143.17 E.00918
G1 X178.17 Y139.9 E.07522
G1 X178.17 Y140.464 E.00918
G1 X175.464 Y143.17 E.06224
G1 X176.028 Y143.17 E.00918
G1 X178.17 Y141.028 E.04926
G1 X178.17 Y141.593 E.00918
G1 X176.593 Y143.17 E.03627
G1 X177.157 Y143.17 E.00918
M73 P70 R18
G1 X178.17 Y142.157 E.02329
G1 X178.17 Y142.722 E.00918
G1 X177.543 Y143.35 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 1.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X178.17 Y142.722 E-.33727
G1 X178.17 Y142.157 E-.21451
G1 X177.783 Y142.545 E-.20822
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/25
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
M204 S10000
G17
G3 Z1.6 I-.582 J-1.069 P1  F30000
G1 X174.453 Y144.357 Z1.6
G1 X51.016 Y211.534
G1 Z1.3
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #14
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
M73 P71 R18
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z1.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.084 Y114.9 Z1.7 F30000
G1 X77.65 Y141.061 Z1.7
G1 Z1.3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X79.76 Y143.17 E.0486
G1 X80.325 Y143.17 E.00921
G1 X77.83 Y140.675 E.05749
G1 X77.83 Y140.109 E.00921
G1 X80.891 Y143.17 E.07051
G1 X81.456 Y143.17 E.00921
G1 X77.83 Y139.544 E.08354
G1 X77.83 Y138.978 E.00921
G1 X82.022 Y143.17 E.09656
G1 X82.587 Y143.17 E.00921
G1 X77.83 Y138.413 E.10959
G1 X77.83 Y137.848 E.00921
G1 X83.152 Y143.17 E.12261
G1 X83.718 Y143.17 E.00921
G1 X77.83 Y137.282 E.13563
G1 X77.83 Y136.717 E.00921
G1 X84.283 Y143.17 E.14866
G1 X84.849 Y143.17 E.00921
G1 X77.83 Y136.151 E.16168
G1 X77.83 Y135.586 E.00921
G1 X85.414 Y143.17 E.17471
G1 X85.979 Y143.17 E.00921
G1 X77.83 Y135.021 E.18773
G1 X77.83 Y134.455 E.00921
G1 X86.545 Y143.17 E.20076
G1 X87.11 Y143.17 E.00921
G1 X77.83 Y133.89 E.21378
G1 X77.83 Y133.325 E.00921
G1 X87.675 Y143.17 E.2268
G1 X88.241 Y143.17 E.00921
G1 X77.83 Y132.759 E.23983
G1 X77.83 Y132.194 E.00921
G1 X88.806 Y143.17 E.25285
G1 X89.372 Y143.17 E.00921
G1 X77.83 Y131.628 E.26588
G1 X77.83 Y131.063 E.00921
G1 X89.937 Y143.17 E.2789
G1 X90.502 Y143.17 E.00921
G1 X77.83 Y130.498 E.29193
G1 X77.83 Y129.932 E.00921
G1 X91.068 Y143.17 E.30495
G1 X91.633 Y143.17 E.00921
G1 X77.83 Y129.367 E.31797
G1 X77.83 Y128.801 E.00921
G1 X92.199 Y143.17 E.331
G1 X92.764 Y143.17 E.00921
G1 X77.83 Y128.236 E.34402
G1 X77.83 Y127.671 E.00921
G1 X93.329 Y143.17 E.35705
G1 X93.895 Y143.17 E.00921
G1 X77.83 Y127.105 E.37007
G1 X77.83 Y126.54 E.00921
G1 X94.46 Y143.17 E.3831
G1 X95.025 Y143.17 E.00921
G1 X77.83 Y125.974 E.39612
G1 X77.83 Y125.409 E.00921
G1 X95.591 Y143.17 E.40914
G1 X96.156 Y143.17 E.00921
G1 X77.83 Y124.844 E.42217
G1 X77.83 Y124.278 E.00921
G1 X96.722 Y143.17 E.43519
G1 X97.287 Y143.17 E.00921
G1 X77.83 Y123.713 E.44822
G1 X77.83 Y123.148 E.00921
G1 X97.852 Y143.17 E.46124
G1 X98.418 Y143.17 E.00921
G1 X77.83 Y122.582 E.47427
G1 X77.83 Y122.017 E.00921
G1 X98.983 Y143.17 E.48729
G1 X99.549 Y143.17 E.00921
G1 X77.83 Y121.451 E.50031
G1 X77.83 Y120.886 E.00921
G1 X100.114 Y143.17 E.51334
G1 X100.679 Y143.17 E.00921
G1 X77.83 Y120.321 E.52636
G1 X77.83 Y119.755 E.00921
G1 X101.245 Y143.17 E.53939
G1 X101.81 Y143.17 E.00921
G1 X77.83 Y119.19 E.55241
G1 X77.83 Y118.624 E.00921
G1 X102.376 Y143.17 E.56544
G1 X102.941 Y143.17 E.00921
G1 X77.83 Y118.059 E.57846
G1 X77.83 Y117.494 E.00921
G1 X103.506 Y143.17 E.59148
G1 X104.072 Y143.17 E.00921
G1 X77.83 Y116.928 E.60451
G1 X77.83 Y116.363 E.00921
G1 X104.637 Y143.17 E.61753
G1 X105.202 Y143.17 E.00921
G1 X77.83 Y115.798 E.63056
G1 X77.83 Y115.232 E.00921
G1 X105.768 Y143.17 E.64358
G1 X106.333 Y143.17 E.00921
G1 X77.83 Y114.667 E.65661
G1 X77.83 Y114.101 E.00921
G1 X106.899 Y143.17 E.66963
G1 X107.464 Y143.17 E.00921
G1 X77.83 Y113.536 E.68265
G1 X77.83 Y112.971 E.00921
G1 X108.029 Y143.17 E.69568
G1 X108.595 Y143.17 E.00921
G1 X77.83 Y112.405 E.7087
G1 X77.83 Y111.84 E.00921
G1 X109.16 Y143.17 E.72173
G1 X109.726 Y143.17 E.00921
G1 X77.83 Y111.274 E.73475
G1 X77.83 Y110.709 E.00921
G1 X110.291 Y143.17 E.74778
G1 X110.856 Y143.17 E.00921
G1 X77.83 Y110.144 E.7608
G1 X77.83 Y109.578 E.00921
G1 X111.422 Y143.17 E.77382
G1 X111.987 Y143.17 E.00921
G1 X77.83 Y109.013 E.78685
G1 X77.83 Y108.83 E.00298
G1 X78.212 Y108.83 E.00623
G1 X112.553 Y143.17 E.79106
G1 X113.118 Y143.17 E.00921
G1 X78.778 Y108.83 E.79106
G1 X79.343 Y108.83 E.00921
G1 X113.683 Y143.17 E.79106
G1 X114.249 Y143.17 E.00921
G1 X79.908 Y108.83 E.79106
G1 X80.474 Y108.83 E.00921
G1 X114.814 Y143.17 E.79106
G1 X115.379 Y143.17 E.00921
G1 X81.039 Y108.83 E.79106
G1 X81.605 Y108.83 E.00921
G1 X115.945 Y143.17 E.79106
G1 X116.51 Y143.17 E.00921
G1 X82.17 Y108.83 E.79106
G1 X82.735 Y108.83 E.00921
G1 X117.076 Y143.17 E.79106
G1 X117.641 Y143.17 E.00921
G1 X83.301 Y108.83 E.79106
G1 X83.866 Y108.83 E.00921
G1 X118.206 Y143.17 E.79106
G1 X118.772 Y143.17 E.00921
G1 X84.431 Y108.83 E.79106
G1 X84.997 Y108.83 E.00921
G1 X119.337 Y143.17 E.79106
G1 X119.903 Y143.17 E.00921
G1 X85.562 Y108.83 E.79106
G1 X86.128 Y108.83 E.00921
G1 X120.468 Y143.17 E.79106
G1 X121.033 Y143.17 E.00921
G1 X86.693 Y108.83 E.79106
G1 X87.258 Y108.83 E.00921
G1 X121.599 Y143.17 E.79106
G1 X122.164 Y143.17 E.00921
G1 X87.824 Y108.83 E.79106
G1 X88.389 Y108.83 E.00921
G1 X122.73 Y143.17 E.79106
G1 X123.295 Y143.17 E.00921
G1 X88.955 Y108.83 E.79106
G1 X89.52 Y108.83 E.00921
G1 X123.86 Y143.17 E.79106
G1 X124.426 Y143.17 E.00921
G1 X90.085 Y108.83 E.79106
G1 X90.651 Y108.83 E.00921
G1 X124.991 Y143.17 E.79106
G1 X125.556 Y143.17 E.00921
G1 X91.216 Y108.83 E.79106
G1 X91.782 Y108.83 E.00921
G1 X126.122 Y143.17 E.79106
G1 X126.687 Y143.17 E.00921
G1 X92.347 Y108.83 E.79106
G1 X92.912 Y108.83 E.00921
G1 X127.253 Y143.17 E.79106
G1 X127.818 Y143.17 E.00921
G1 X93.478 Y108.83 E.79106
G1 X94.043 Y108.83 E.00921
G1 X128.383 Y143.17 E.79106
G1 X128.949 Y143.17 E.00921
G1 X94.608 Y108.83 E.79106
G1 X95.174 Y108.83 E.00921
G1 X129.514 Y143.17 E.79106
G1 X130.08 Y143.17 E.00921
G1 X95.739 Y108.83 E.79106
G1 X96.305 Y108.83 E.00921
G1 X130.645 Y143.17 E.79106
G1 X131.21 Y143.17 E.00921
G1 X96.87 Y108.83 E.79106
M73 P72 R18
G1 X97.435 Y108.83 E.00921
G1 X131.776 Y143.17 E.79106
G1 X132.341 Y143.17 E.00921
G1 X98.001 Y108.83 E.79106
G1 X98.566 Y108.83 E.00921
G1 X132.907 Y143.17 E.79106
G1 X133.472 Y143.17 E.00921
G1 X99.132 Y108.83 E.79106
G1 X99.697 Y108.83 E.00921
G1 X134.037 Y143.17 E.79106
G1 X134.603 Y143.17 E.00921
G1 X100.262 Y108.83 E.79106
G1 X100.828 Y108.83 E.00921
G1 X135.168 Y143.17 E.79106
G1 X135.733 Y143.17 E.00921
G1 X101.393 Y108.83 E.79106
G1 X101.958 Y108.83 E.00921
G1 X136.299 Y143.17 E.79106
G1 X136.864 Y143.17 E.00921
G1 X102.524 Y108.83 E.79106
G1 X103.089 Y108.83 E.00921
G1 X137.43 Y143.17 E.79106
G1 X137.995 Y143.17 E.00921
G1 X103.655 Y108.83 E.79106
G1 X104.22 Y108.83 E.00921
G1 X138.56 Y143.17 E.79106
G1 X139.126 Y143.17 E.00921
G1 X104.785 Y108.83 E.79106
G1 X105.351 Y108.83 E.00921
G1 X139.691 Y143.17 E.79106
G1 X140.257 Y143.17 E.00921
G1 X105.916 Y108.83 E.79106
G1 X106.482 Y108.83 E.00921
G1 X140.822 Y143.17 E.79106
G1 X141.387 Y143.17 E.00921
G1 X107.047 Y108.83 E.79106
G1 X107.612 Y108.83 E.00921
M73 P72 R17
G1 X141.953 Y143.17 E.79106
G1 X142.518 Y143.17 E.00921
G1 X108.178 Y108.83 E.79106
G1 X108.743 Y108.83 E.00921
G1 X143.084 Y143.17 E.79106
G1 X143.649 Y143.17 E.00921
G1 X109.309 Y108.83 E.79106
G1 X109.874 Y108.83 E.00921
G1 X144.214 Y143.17 E.79106
G1 X144.78 Y143.17 E.00921
G1 X110.439 Y108.83 E.79106
G1 X111.005 Y108.83 E.00921
G1 X145.345 Y143.17 E.79106
G1 X145.91 Y143.17 E.00921
G1 X111.57 Y108.83 E.79106
G1 X112.135 Y108.83 E.00921
G1 X146.476 Y143.17 E.79106
G1 X147.041 Y143.17 E.00921
G1 X112.701 Y108.83 E.79106
G1 X113.266 Y108.83 E.00921
G1 X147.607 Y143.17 E.79106
G1 X148.172 Y143.17 E.00921
G1 X113.832 Y108.83 E.79106
G1 X114.397 Y108.83 E.00921
G1 X148.737 Y143.17 E.79106
G1 X149.303 Y143.17 E.00921
G1 X114.962 Y108.83 E.79106
G1 X115.528 Y108.83 E.00921
G1 X149.868 Y143.17 E.79106
G1 X150.434 Y143.17 E.00921
G1 X116.093 Y108.83 E.79106
G1 X116.659 Y108.83 E.00921
G1 X150.999 Y143.17 E.79106
G1 X151.564 Y143.17 E.00921
G1 X117.224 Y108.83 E.79106
G1 X117.789 Y108.83 E.00921
G1 X152.13 Y143.17 E.79106
G1 X152.695 Y143.17 E.00921
G1 X118.355 Y108.83 E.79106
G1 X118.92 Y108.83 E.00921
G1 X153.261 Y143.17 E.79106
G1 X153.826 Y143.17 E.00921
G1 X119.486 Y108.83 E.79106
G1 X120.051 Y108.83 E.00921
G1 X154.391 Y143.17 E.79106
G1 X154.957 Y143.17 E.00921
G1 X120.616 Y108.83 E.79106
G1 X121.182 Y108.83 E.00921
G1 X155.522 Y143.17 E.79106
G1 X156.087 Y143.17 E.00921
G1 X121.747 Y108.83 E.79106
G1 X122.312 Y108.83 E.00921
G1 X156.653 Y143.17 E.79106
G1 X157.218 Y143.17 E.00921
G1 X122.878 Y108.83 E.79106
G1 X123.443 Y108.83 E.00921
G1 X157.784 Y143.17 E.79106
G1 X158.349 Y143.17 E.00921
G1 X124.009 Y108.83 E.79106
G1 X124.574 Y108.83 E.00921
G1 X158.914 Y143.17 E.79106
G1 X159.48 Y143.17 E.00921
G1 X125.139 Y108.83 E.79106
G1 X125.705 Y108.83 E.00921
G1 X160.045 Y143.17 E.79106
G1 X160.611 Y143.17 E.00921
G1 X126.27 Y108.83 E.79106
G1 X126.836 Y108.83 E.00921
G1 X161.176 Y143.17 E.79106
G1 X161.741 Y143.17 E.00921
G1 X127.401 Y108.83 E.79106
G1 X127.966 Y108.83 E.00921
G1 X162.307 Y143.17 E.79106
G1 X162.872 Y143.17 E.00921
G1 X128.532 Y108.83 E.79106
G1 X129.097 Y108.83 E.00921
G1 X163.437 Y143.17 E.79106
G1 X164.003 Y143.17 E.00921
G1 X129.663 Y108.83 E.79106
G1 X130.228 Y108.83 E.00921
G1 X164.568 Y143.17 E.79106
G1 X165.134 Y143.17 E.00921
G1 X130.793 Y108.83 E.79106
G1 X131.359 Y108.83 E.00921
G1 X165.699 Y143.17 E.79106
G1 X166.264 Y143.17 E.00921
G1 X131.924 Y108.83 E.79106
G1 X132.489 Y108.83 E.00921
G1 X166.83 Y143.17 E.79106
G1 X167.395 Y143.17 E.00921
G1 X133.055 Y108.83 E.79106
G1 X133.62 Y108.83 E.00921
G1 X167.961 Y143.17 E.79106
G1 X168.526 Y143.17 E.00921
G1 X134.186 Y108.83 E.79106
G1 X134.751 Y108.83 E.00921
G1 X169.091 Y143.17 E.79106
G1 X169.657 Y143.17 E.00921
M73 P73 R17
G1 X135.316 Y108.83 E.79106
G1 X135.882 Y108.83 E.00921
G1 X170.222 Y143.17 E.79106
G1 X170.788 Y143.17 E.00921
G1 X136.447 Y108.83 E.79106
G1 X137.013 Y108.83 E.00921
G1 X171.353 Y143.17 E.79106
G1 X171.918 Y143.17 E.00921
G1 X137.578 Y108.83 E.79106
G1 X138.143 Y108.83 E.00921
G1 X172.484 Y143.17 E.79106
G1 X173.049 Y143.17 E.00921
G1 X138.709 Y108.83 E.79106
G1 X139.274 Y108.83 E.00921
G1 X173.614 Y143.17 E.79106
G1 X174.18 Y143.17 E.00921
G1 X139.84 Y108.83 E.79106
G1 X140.405 Y108.83 E.00921
G1 X174.745 Y143.17 E.79106
G1 X175.311 Y143.17 E.00921
G1 X140.97 Y108.83 E.79106
G1 X141.536 Y108.83 E.00921
G1 X175.876 Y143.17 E.79106
G1 X176.441 Y143.17 E.00921
G1 X142.101 Y108.83 E.79106
G1 X142.666 Y108.83 E.00921
G1 X177.007 Y143.17 E.79106
G1 X177.572 Y143.17 E.00921
G1 X143.232 Y108.83 E.79106
G1 X143.797 Y108.83 E.00921
G1 X178.138 Y143.17 E.79106
G1 X178.17 Y143.17 E.00053
G1 X178.17 Y142.637 E.00868
G1 X144.363 Y108.83 E.77879
G1 X144.928 Y108.83 E.00921
G1 X178.17 Y142.072 E.76577
G1 X178.17 Y141.507 E.00921
G1 X145.493 Y108.83 E.75274
G1 X146.059 Y108.83 E.00921
G1 X178.17 Y140.941 E.73972
G1 X178.17 Y140.376 E.00921
G1 X146.624 Y108.83 E.72669
G1 X147.19 Y108.83 E.00921
G1 X178.17 Y139.81 E.71367
G1 X178.17 Y139.245 E.00921
G1 X147.755 Y108.83 E.70064
G1 X148.32 Y108.83 E.00921
G1 X178.17 Y138.68 E.68762
G1 X178.17 Y138.114 E.00921
G1 X148.886 Y108.83 E.6746
G1 X149.451 Y108.83 E.00921
G1 X178.17 Y137.549 E.66157
G1 X178.17 Y136.983 E.00921
G1 X150.017 Y108.83 E.64855
G1 X150.582 Y108.83 E.00921
G1 X178.17 Y136.418 E.63552
G1 X178.17 Y135.853 E.00921
G1 X151.147 Y108.83 E.6225
G1 X151.713 Y108.83 E.00921
G1 X178.17 Y135.287 E.60947
G1 X178.17 Y134.722 E.00921
G1 X152.278 Y108.83 E.59645
G1 X152.843 Y108.83 E.00921
G1 X178.17 Y134.157 E.58343
G1 X178.17 Y133.591 E.00921
G1 X153.409 Y108.83 E.5704
G1 X153.974 Y108.83 E.00921
G1 X178.17 Y133.026 E.55738
G1 X178.17 Y132.46 E.00921
G1 X154.54 Y108.83 E.54435
G1 X155.105 Y108.83 E.00921
G1 X178.17 Y131.895 E.53133
G1 X178.17 Y131.33 E.00921
G1 X155.67 Y108.83 E.5183
G1 X156.236 Y108.83 E.00921
G1 X178.17 Y130.764 E.50528
G1 X178.17 Y130.199 E.00921
G1 X156.801 Y108.83 E.49226
G1 X157.367 Y108.83 E.00921
G1 X178.17 Y129.633 E.47923
G1 X178.17 Y129.068 E.00921
G1 X157.932 Y108.83 E.46621
G1 X158.497 Y108.83 E.00921
G1 X178.17 Y128.503 E.45318
G1 X178.17 Y127.937 E.00921
G1 X159.063 Y108.83 E.44016
G1 X159.628 Y108.83 E.00921
G1 X178.17 Y127.372 E.42713
G1 X178.17 Y126.806 E.00921
G1 X160.194 Y108.83 E.41411
G1 X160.759 Y108.83 E.00921
G1 X178.17 Y126.241 E.40109
G1 X178.17 Y125.676 E.00921
G1 X161.324 Y108.83 E.38806
G1 X161.89 Y108.83 E.00921
G1 X178.17 Y125.11 E.37504
G1 X178.17 Y124.545 E.00921
G1 X162.455 Y108.83 E.36201
G1 X163.02 Y108.83 E.00921
G1 X178.17 Y123.98 E.34899
G1 X178.17 Y123.414 E.00921
G1 X163.586 Y108.83 E.33596
G1 X164.151 Y108.83 E.00921
G1 X178.17 Y122.849 E.32294
M73 P73 R16
G1 X178.17 Y122.283 E.00921
G1 X164.717 Y108.83 E.30992
G1 X165.282 Y108.83 E.00921
G1 X178.17 Y121.718 E.29689
G1 X178.17 Y121.153 E.00921
G1 X165.847 Y108.83 E.28387
G1 X166.413 Y108.83 E.00921
G1 X178.17 Y120.587 E.27084
G1 X178.17 Y120.022 E.00921
G1 X166.978 Y108.83 E.25782
G1 X167.544 Y108.83 E.00921
G1 X178.17 Y119.456 E.24479
G1 X178.17 Y118.891 E.00921
G1 X168.109 Y108.83 E.23177
G1 X168.674 Y108.83 E.00921
G1 X178.17 Y118.326 E.21875
G1 X178.17 Y117.76 E.00921
G1 X169.24 Y108.83 E.20572
G1 X169.805 Y108.83 E.00921
G1 X178.17 Y117.195 E.1927
G1 X178.17 Y116.629 E.00921
G1 X170.37 Y108.83 E.17967
G1 X170.936 Y108.83 E.00921
G1 X178.17 Y116.064 E.16665
G1 X178.17 Y115.499 E.00921
G1 X171.501 Y108.83 E.15362
G1 X172.067 Y108.83 E.00921
M73 P74 R16
G1 X178.17 Y114.933 E.1406
G1 X178.17 Y114.368 E.00921
G1 X172.632 Y108.83 E.12758
G1 X173.197 Y108.83 E.00921
G1 X178.17 Y113.803 E.11455
G1 X178.17 Y113.237 E.00921
G1 X173.763 Y108.83 E.10153
G1 X174.328 Y108.83 E.00921
G1 X178.17 Y112.672 E.0885
G1 X178.17 Y112.106 E.00921
G1 X174.894 Y108.83 E.07548
G1 X175.459 Y108.83 E.00921
G1 X178.17 Y111.541 E.06245
G1 X178.17 Y110.976 E.00921
G1 X176.024 Y108.83 E.04943
G1 X176.59 Y108.83 E.00921
G1 X178.17 Y110.41 E.03641
G1 X178.17 Y109.845 E.00921
G1 X177.155 Y108.83 E.02338
G1 X177.721 Y108.83 E.00921
G1 X178.35 Y109.459 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X177.721 Y108.83 E-.338
G1 X177.155 Y108.83 E-.21485
G1 X177.541 Y109.215 E-.20715
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/25
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
M204 S10000
G17
G3 Z1.7 I-.765 J-.946 P1  F30000
G1 X134.085 Y144.357 Z1.7
G1 X51.016 Y211.534
G1 Z1.4
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #15
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.65 Y109.459 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42061
G1 F6000
M204 S1000
G1 X78.28 Y108.83 E.01447
G1 X78.844 Y108.83 E.00918
G1 X77.83 Y109.844 E.02333
G1 X77.83 Y110.409 E.00918
G1 X79.409 Y108.83 E.03631
G1 X79.973 Y108.83 E.00918
G1 X77.83 Y110.973 E.04929
G1 X77.83 Y111.538 E.00918
G1 X80.538 Y108.83 E.06228
G1 X81.102 Y108.83 E.00918
G1 X77.83 Y112.102 E.07526
G1 X77.83 Y112.667 E.00918
G1 X81.667 Y108.83 E.08824
G1 X82.231 Y108.83 E.00918
G1 X77.83 Y113.231 E.10123
G1 X77.83 Y113.796 E.00918
G1 X82.796 Y108.83 E.11421
G1 X83.36 Y108.83 E.00918
G1 X77.83 Y114.36 E.12719
G1 X77.83 Y114.925 E.00918
G1 X83.925 Y108.83 E.14017
G1 X84.489 Y108.83 E.00918
G1 X77.83 Y115.489 E.15316
G1 X77.83 Y116.054 E.00918
G1 X85.054 Y108.83 E.16614
G1 X85.618 Y108.83 E.00918
G1 X77.83 Y116.618 E.17912
G1 X77.83 Y117.182 E.00918
G1 X86.182 Y108.83 E.1921
G1 X86.747 Y108.83 E.00918
G1 X77.83 Y117.747 E.20509
G1 X77.83 Y118.311 E.00918
G1 X87.311 Y108.83 E.21807
G1 X87.876 Y108.83 E.00918
G1 X77.83 Y118.876 E.23105
G1 X77.83 Y119.44 E.00918
G1 X88.44 Y108.83 E.24403
G1 X89.005 Y108.83 E.00918
G1 X77.83 Y120.005 E.25702
G1 X77.83 Y120.569 E.00918
G1 X89.569 Y108.83 E.27
G1 X90.134 Y108.83 E.00918
G1 X77.83 Y121.134 E.28298
G1 X77.83 Y121.698 E.00918
G1 X90.698 Y108.83 E.29596
G1 X91.263 Y108.83 E.00918
G1 X77.83 Y122.263 E.30895
G1 X77.83 Y122.827 E.00918
G1 X91.827 Y108.83 E.32193
G1 X92.392 Y108.83 E.00918
G1 X77.83 Y123.392 E.33491
G1 X77.83 Y123.956 E.00918
G1 X92.956 Y108.83 E.3479
G1 X93.521 Y108.83 E.00918
G1 X77.83 Y124.521 E.36088
G1 X77.83 Y125.085 E.00918
G1 X94.085 Y108.83 E.37386
G1 X94.65 Y108.83 E.00918
G1 X77.83 Y125.65 E.38684
G1 X77.83 Y126.214 E.00918
G1 X95.214 Y108.83 E.39983
G1 X95.779 Y108.83 E.00918
G1 X77.83 Y126.779 E.41281
G1 X77.83 Y127.343 E.00918
G1 X96.343 Y108.83 E.42579
G1 X96.908 Y108.83 E.00918
G1 X77.83 Y127.908 E.43877
G1 X77.83 Y128.472 E.00918
G1 X97.472 Y108.83 E.45176
G1 X98.037 Y108.83 E.00918
G1 X77.83 Y129.037 E.46474
G1 X77.83 Y129.601 E.00918
G1 X98.601 Y108.83 E.47772
G1 X99.166 Y108.83 E.00918
G1 X77.83 Y130.166 E.4907
G1 X77.83 Y130.73 E.00918
G1 X99.73 Y108.83 E.50369
G1 X100.295 Y108.83 E.00918
G1 X77.83 Y131.295 E.51667
G1 X77.83 Y131.859 E.00918
G1 X100.859 Y108.83 E.52965
G1 X101.424 Y108.83 E.00918
G1 X77.83 Y132.424 E.54263
G1 X77.83 Y132.988 E.00918
G1 X101.988 Y108.83 E.55562
G1 X102.552 Y108.83 E.00918
G1 X77.83 Y133.552 E.5686
M73 P75 R16
G1 X77.83 Y134.117 E.00918
G1 X103.117 Y108.83 E.58158
G1 X103.681 Y108.83 E.00918
G1 X77.83 Y134.681 E.59457
G1 X77.83 Y135.246 E.00918
G1 X104.246 Y108.83 E.60755
G1 X104.81 Y108.83 E.00918
G1 X77.83 Y135.81 E.62053
G1 X77.83 Y136.375 E.00918
G1 X105.375 Y108.83 E.63351
G1 X105.939 Y108.83 E.00918
G1 X77.83 Y136.939 E.6465
G1 X77.83 Y137.504 E.00918
G1 X106.504 Y108.83 E.65948
G1 X107.068 Y108.83 E.00918
G1 X77.83 Y138.068 E.67246
G1 X77.83 Y138.633 E.00918
G1 X107.633 Y108.83 E.68544
G1 X108.197 Y108.83 E.00918
G1 X77.83 Y139.197 E.69843
G1 X77.83 Y139.762 E.00918
G1 X108.762 Y108.83 E.71141
G1 X109.326 Y108.83 E.00918
G1 X77.83 Y140.326 E.72439
G1 X77.83 Y140.891 E.00918
G1 X109.891 Y108.83 E.73737
G1 X110.455 Y108.83 E.00918
G1 X77.936 Y141.349 E.7479
G1 X78.219 Y141.631 E.00649
G1 X111.02 Y108.83 E.7544
G1 X111.584 Y108.83 E.00918
G1 X78.501 Y141.913 E.76089
G1 X78.783 Y142.195 E.00649
G1 X112.149 Y108.83 E.76738
G1 X112.713 Y108.83 E.00918
G1 X79.065 Y142.478 E.77387
G1 X79.348 Y142.76 E.00649
G1 X113.278 Y108.83 E.78036
G1 X113.842 Y108.83 E.00918
G1 X79.63 Y143.042 E.78685
G1 X79.758 Y143.17 E.00295
G1 X80.066 Y143.17 E.00501
G1 X114.407 Y108.83 E.7898
G1 X114.971 Y108.83 E.00918
G1 X80.631 Y143.17 E.7898
G1 X81.195 Y143.17 E.00918
G1 X115.536 Y108.83 E.7898
G1 X116.1 Y108.83 E.00918
G1 X81.76 Y143.17 E.7898
G1 X82.324 Y143.17 E.00918
G1 X116.665 Y108.83 E.7898
G1 X117.229 Y108.83 E.00918
G1 X82.889 Y143.17 E.7898
G1 X83.453 Y143.17 E.00918
G1 X117.794 Y108.83 E.7898
G1 X118.358 Y108.83 E.00918
G1 X84.018 Y143.17 E.7898
G1 X84.582 Y143.17 E.00918
G1 X118.923 Y108.83 E.7898
G1 X119.487 Y108.83 E.00918
G1 X85.147 Y143.17 E.7898
G1 X85.711 Y143.17 E.00918
G1 X120.051 Y108.83 E.7898
G1 X120.616 Y108.83 E.00918
G1 X86.276 Y143.17 E.7898
G1 X86.84 Y143.17 E.00918
G1 X121.18 Y108.83 E.7898
G1 X121.745 Y108.83 E.00918
G1 X87.405 Y143.17 E.7898
G1 X87.969 Y143.17 E.00918
G1 X122.309 Y108.83 E.7898
G1 X122.874 Y108.83 E.00918
G1 X88.534 Y143.17 E.7898
G1 X89.098 Y143.17 E.00918
G1 X123.438 Y108.83 E.7898
G1 X124.003 Y108.83 E.00918
G1 X89.662 Y143.17 E.7898
G1 X90.227 Y143.17 E.00918
G1 X124.567 Y108.83 E.7898
G1 X125.132 Y108.83 E.00918
G1 X90.791 Y143.17 E.7898
G1 X91.356 Y143.17 E.00918
G1 X125.696 Y108.83 E.7898
G1 X126.261 Y108.83 E.00918
G1 X91.92 Y143.17 E.7898
G1 X92.485 Y143.17 E.00918
G1 X126.825 Y108.83 E.7898
M73 P75 R15
G1 X127.39 Y108.83 E.00918
G1 X93.049 Y143.17 E.7898
G1 X93.614 Y143.17 E.00918
G1 X127.954 Y108.83 E.7898
G1 X128.519 Y108.83 E.00918
G1 X94.178 Y143.17 E.7898
G1 X94.743 Y143.17 E.00918
G1 X129.083 Y108.83 E.7898
G1 X129.648 Y108.83 E.00918
G1 X95.307 Y143.17 E.7898
G1 X95.872 Y143.17 E.00918
G1 X130.212 Y108.83 E.7898
G1 X130.777 Y108.83 E.00918
G1 X96.436 Y143.17 E.7898
G1 X97.001 Y143.17 E.00918
G1 X131.341 Y108.83 E.7898
G1 X131.906 Y108.83 E.00918
G1 X97.565 Y143.17 E.7898
G1 X98.13 Y143.17 E.00918
G1 X132.47 Y108.83 E.7898
G1 X133.035 Y108.83 E.00918
G1 X98.694 Y143.17 E.7898
G1 X99.259 Y143.17 E.00918
G1 X133.599 Y108.83 E.7898
G1 X134.164 Y108.83 E.00918
G1 X99.823 Y143.17 E.7898
G1 X100.388 Y143.17 E.00918
G1 X134.728 Y108.83 E.7898
G1 X135.293 Y108.83 E.00918
G1 X100.952 Y143.17 E.7898
G1 X101.517 Y143.17 E.00918
G1 X135.857 Y108.83 E.7898
G1 X136.421 Y108.83 E.00918
G1 X102.081 Y143.17 E.7898
G1 X102.646 Y143.17 E.00918
G1 X136.986 Y108.83 E.7898
G1 X137.55 Y108.83 E.00918
G1 X103.21 Y143.17 E.7898
G1 X103.775 Y143.17 E.00918
G1 X138.115 Y108.83 E.7898
G1 X138.679 Y108.83 E.00918
G1 X104.339 Y143.17 E.7898
G1 X104.904 Y143.17 E.00918
G1 X139.244 Y108.83 E.7898
G1 X139.808 Y108.83 E.00918
G1 X105.468 Y143.17 E.7898
G1 X106.033 Y143.17 E.00918
G1 X140.373 Y108.83 E.7898
G1 X140.937 Y108.83 E.00918
G1 X106.597 Y143.17 E.7898
G1 X107.161 Y143.17 E.00918
G1 X141.502 Y108.83 E.7898
G1 X142.066 Y108.83 E.00918
G1 X107.726 Y143.17 E.7898
G1 X108.29 Y143.17 E.00918
G1 X142.631 Y108.83 E.7898
G1 X143.195 Y108.83 E.00918
G1 X108.855 Y143.17 E.7898
G1 X109.419 Y143.17 E.00918
G1 X143.76 Y108.83 E.7898
G1 X144.324 Y108.83 E.00918
G1 X109.984 Y143.17 E.7898
G1 X110.548 Y143.17 E.00918
G1 X144.889 Y108.83 E.7898
G1 X145.453 Y108.83 E.00918
G1 X111.113 Y143.17 E.7898
G1 X111.677 Y143.17 E.00918
G1 X146.018 Y108.83 E.7898
G1 X146.582 Y108.83 E.00918
G1 X112.242 Y143.17 E.7898
G1 X112.806 Y143.17 E.00918
G1 X147.147 Y108.83 E.7898
G1 X147.711 Y108.83 E.00918
G1 X113.371 Y143.17 E.7898
G1 X113.935 Y143.17 E.00918
G1 X148.276 Y108.83 E.7898
G1 X148.84 Y108.83 E.00918
G1 X114.5 Y143.17 E.7898
G1 X115.064 Y143.17 E.00918
G1 X149.405 Y108.83 E.7898
G1 X149.969 Y108.83 E.00918
G1 X115.629 Y143.17 E.7898
G1 X116.193 Y143.17 E.00918
G1 X150.534 Y108.83 E.7898
G1 X151.098 Y108.83 E.00918
G1 X116.758 Y143.17 E.7898
G1 X117.322 Y143.17 E.00918
G1 X151.663 Y108.83 E.7898
G1 X152.227 Y108.83 E.00918
G1 X117.887 Y143.17 E.7898
G1 X118.451 Y143.17 E.00918
G1 X152.792 Y108.83 E.7898
G1 X153.356 Y108.83 E.00918
G1 X119.016 Y143.17 E.7898
G1 X119.58 Y143.17 E.00918
M73 P76 R15
G1 X153.92 Y108.83 E.7898
G1 X154.485 Y108.83 E.00918
G1 X120.145 Y143.17 E.7898
G1 X120.709 Y143.17 E.00918
G1 X155.049 Y108.83 E.7898
G1 X155.614 Y108.83 E.00918
G1 X121.274 Y143.17 E.7898
G1 X121.838 Y143.17 E.00918
G1 X156.178 Y108.83 E.7898
G1 X156.743 Y108.83 E.00918
G1 X122.403 Y143.17 E.7898
G1 X122.967 Y143.17 E.00918
G1 X157.307 Y108.83 E.7898
G1 X157.872 Y108.83 E.00918
G1 X123.532 Y143.17 E.7898
G1 X124.096 Y143.17 E.00918
G1 X158.436 Y108.83 E.7898
G1 X159.001 Y108.83 E.00918
G1 X124.66 Y143.17 E.7898
G1 X125.225 Y143.17 E.00918
G1 X159.565 Y108.83 E.7898
G1 X160.13 Y108.83 E.00918
G1 X125.789 Y143.17 E.7898
G1 X126.354 Y143.17 E.00918
G1 X160.694 Y108.83 E.7898
G1 X161.259 Y108.83 E.00918
G1 X126.918 Y143.17 E.7898
G1 X127.483 Y143.17 E.00918
G1 X161.823 Y108.83 E.7898
G1 X162.388 Y108.83 E.00918
G1 X128.047 Y143.17 E.7898
G1 X128.612 Y143.17 E.00918
G1 X162.952 Y108.83 E.7898
G1 X163.517 Y108.83 E.00918
G1 X129.176 Y143.17 E.7898
G1 X129.741 Y143.17 E.00918
G1 X164.081 Y108.83 E.7898
G1 X164.646 Y108.83 E.00918
G1 X130.305 Y143.17 E.7898
G1 X130.87 Y143.17 E.00918
G1 X165.21 Y108.83 E.7898
G1 X165.775 Y108.83 E.00918
G1 X131.434 Y143.17 E.7898
G1 X131.999 Y143.17 E.00918
G1 X166.339 Y108.83 E.7898
G1 X166.904 Y108.83 E.00918
G1 X132.563 Y143.17 E.7898
G1 X133.128 Y143.17 E.00918
G1 X167.468 Y108.83 E.7898
G1 X168.033 Y108.83 E.00918
G1 X133.692 Y143.17 E.7898
G1 X134.257 Y143.17 E.00918
G1 X168.597 Y108.83 E.7898
G1 X169.162 Y108.83 E.00918
G1 X134.821 Y143.17 E.7898
G1 X135.386 Y143.17 E.00918
G1 X169.726 Y108.83 E.7898
G1 X170.291 Y108.83 E.00918
G1 X135.95 Y143.17 E.7898
G1 X136.515 Y143.17 E.00918
G1 X170.855 Y108.83 E.7898
G1 X171.419 Y108.83 E.00918
G1 X137.079 Y143.17 E.7898
G1 X137.644 Y143.17 E.00918
G1 X171.984 Y108.83 E.7898
G1 X172.548 Y108.83 E.00918
G1 X138.208 Y143.17 E.7898
G1 X138.773 Y143.17 E.00918
G1 X173.113 Y108.83 E.7898
G1 X173.677 Y108.83 E.00918
G1 X139.337 Y143.17 E.7898
G1 X139.902 Y143.17 E.00918
G1 X174.242 Y108.83 E.7898
G1 X174.806 Y108.83 E.00918
G1 X140.466 Y143.17 E.7898
G1 X141.03 Y143.17 E.00918
G1 X175.371 Y108.83 E.7898
G1 X175.935 Y108.83 E.00918
G1 X141.595 Y143.17 E.7898
G1 X142.159 Y143.17 E.00918
G1 X176.5 Y108.83 E.7898
G1 X177.064 Y108.83 E.00918
G1 X142.724 Y143.17 E.7898
G1 X143.288 Y143.17 E.00918
G1 X177.629 Y108.83 E.7898
G1 X178.17 Y108.83 E.0088
G1 X178.17 Y108.853 E.00038
G1 X143.853 Y143.17 E.78927
G1 X144.417 Y143.17 E.00918
G1 X178.17 Y109.417 E.77628
G1 X178.17 Y109.982 E.00918
G1 X144.982 Y143.17 E.7633
G1 X145.546 Y143.17 E.00918
G1 X178.17 Y110.546 E.75032
G1 X178.17 Y111.111 E.00918
G1 X146.111 Y143.17 E.73734
G1 X146.675 Y143.17 E.00918
G1 X178.17 Y111.675 E.72435
G1 X178.17 Y112.24 E.00918
G1 X147.24 Y143.17 E.71137
G1 X147.804 Y143.17 E.00918
G1 X178.17 Y112.804 E.69839
G1 X178.17 Y113.369 E.00918
G1 X148.369 Y143.17 E.68541
G1 X148.933 Y143.17 E.00918
G1 X178.17 Y113.933 E.67242
G1 X178.17 Y114.498 E.00918
G1 X149.498 Y143.17 E.65944
G1 X150.062 Y143.17 E.00918
G1 X178.17 Y115.062 E.64646
G1 X178.17 Y115.627 E.00918
G1 X150.627 Y143.17 E.63348
G1 X151.191 Y143.17 E.00918
G1 X178.17 Y116.191 E.62049
M73 P76 R14
G1 X178.17 Y116.756 E.00918
G1 X151.756 Y143.17 E.60751
G1 X152.32 Y143.17 E.00918
G1 X178.17 Y117.32 E.59453
G1 X178.17 Y117.885 E.00918
G1 X152.885 Y143.17 E.58155
G1 X153.449 Y143.17 E.00918
G1 X178.17 Y118.449 E.56856
G1 X178.17 Y119.014 E.00918
G1 X154.014 Y143.17 E.55558
G1 X154.578 Y143.17 E.00918
G1 X178.17 Y119.578 E.5426
G1 X178.17 Y120.143 E.00918
G1 X155.143 Y143.17 E.52961
G1 X155.707 Y143.17 E.00918
G1 X178.17 Y120.707 E.51663
M73 P77 R14
G1 X178.17 Y121.272 E.00918
G1 X156.272 Y143.17 E.50365
G1 X156.836 Y143.17 E.00918
G1 X178.17 Y121.836 E.49067
G1 X178.17 Y122.401 E.00918
G1 X157.401 Y143.17 E.47768
G1 X157.965 Y143.17 E.00918
G1 X178.17 Y122.965 E.4647
G1 X178.17 Y123.529 E.00918
G1 X158.529 Y143.17 E.45172
G1 X159.094 Y143.17 E.00918
G1 X178.17 Y124.094 E.43874
G1 X178.17 Y124.658 E.00918
G1 X159.658 Y143.17 E.42575
G1 X160.223 Y143.17 E.00918
G1 X178.17 Y125.223 E.41277
G1 X178.17 Y125.787 E.00918
G1 X160.787 Y143.17 E.39979
G1 X161.352 Y143.17 E.00918
G1 X178.17 Y126.352 E.38681
G1 X178.17 Y126.916 E.00918
G1 X161.916 Y143.17 E.37382
G1 X162.481 Y143.17 E.00918
G1 X178.17 Y127.481 E.36084
G1 X178.17 Y128.045 E.00918
G1 X163.045 Y143.17 E.34786
G1 X163.61 Y143.17 E.00918
G1 X178.17 Y128.61 E.33488
G1 X178.17 Y129.174 E.00918
G1 X164.174 Y143.17 E.32189
G1 X164.739 Y143.17 E.00918
G1 X178.17 Y129.739 E.30891
G1 X178.17 Y130.303 E.00918
G1 X165.303 Y143.17 E.29593
G1 X165.868 Y143.17 E.00918
G1 X178.17 Y130.868 E.28294
G1 X178.17 Y131.432 E.00918
G1 X166.432 Y143.17 E.26996
G1 X166.997 Y143.17 E.00918
G1 X178.17 Y131.997 E.25698
G1 X178.17 Y132.561 E.00918
G1 X167.561 Y143.17 E.244
G1 X168.126 Y143.17 E.00918
G1 X178.17 Y133.126 E.23101
G1 X178.17 Y133.69 E.00918
G1 X168.69 Y143.17 E.21803
G1 X169.255 Y143.17 E.00918
G1 X178.17 Y134.255 E.20505
G1 X178.17 Y134.819 E.00918
G1 X169.819 Y143.17 E.19207
G1 X170.384 Y143.17 E.00918
G1 X178.17 Y135.384 E.17908
G1 X178.17 Y135.948 E.00918
G1 X170.948 Y143.17 E.1661
G1 X171.513 Y143.17 E.00918
G1 X178.17 Y136.513 E.15312
G1 X178.17 Y137.077 E.00918
G1 X172.077 Y143.17 E.14014
G1 X172.642 Y143.17 E.00918
G1 X178.17 Y137.642 E.12715
G1 X178.17 Y138.206 E.00918
G1 X173.206 Y143.17 E.11417
G1 X173.771 Y143.17 E.00918
G1 X178.17 Y138.771 E.10119
G1 X178.17 Y139.335 E.00918
G1 X174.335 Y143.17 E.08821
G1 X174.899 Y143.17 E.00918
G1 X178.17 Y139.9 E.07522
G1 X178.17 Y140.464 E.00918
G1 X175.464 Y143.17 E.06224
G1 X176.028 Y143.17 E.00918
G1 X178.17 Y141.028 E.04926
G1 X178.17 Y141.593 E.00918
G1 X176.593 Y143.17 E.03627
G1 X177.157 Y143.17 E.00918
G1 X178.17 Y142.157 E.02329
G1 X178.17 Y142.722 E.00918
G1 X177.543 Y143.35 E.01443
; CHANGE_LAYER
; Z_HEIGHT: 1.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X178.17 Y142.722 E-.33727
G1 X178.17 Y142.157 E-.21451
G1 X177.783 Y142.545 E-.20822
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/25
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
M204 S10000
G17
G3 Z1.8 I-.582 J-1.069 P1  F30000
G1 X174.453 Y144.357 Z1.8
G1 X51.016 Y211.534
G1 Z1.5
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #16
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
G1 X76.643 Y110.78
G1 X76.643 Y108.481
G1 X77.481 Y108.481
G1 Z1.5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
G1 X178.519 Y108.481 E1.76413
G1 X178.519 Y126 E.30589
G1 X178.519 Y143.519 E.30589
G1 X79.613 Y143.519 E1.72689
G1 X77.481 Y141.387 E.05266
G1 X77.481 Y108.541 E.57349
M204 S10000
G1 X77.052 Y108.052 F30000
G1 F6000
M204 S1000
G1 X178.948 Y108.052 E1.77909
G1 X178.948 Y126 E.31337
G1 X178.948 Y143.948 E.31337
G1 X79.436 Y143.948 E1.73747
G1 X77.052 Y141.564 E.05886
G1 X77.052 Y108.112 E.58407
M204 S10000
G1 X76.624 Y107.624 F30000
G1 F6000
M204 S1000
G1 X179.376 Y107.624 E1.79405
G1 X179.376 Y126 E.32085
G1 X179.376 Y144.376 E.32085
G1 X79.258 Y144.376 E1.74805
G1 X76.624 Y141.742 E.06506
G1 X76.624 Y107.684 E.59465
M204 S250
G1 X76.21 Y107.21 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.084 Y114.9 Z1.9 F30000
G1 X77.65 Y141.061 Z1.9
G1 Z1.5
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42125
G1 F6000
M204 S1000
G1 X79.76 Y143.17 E.0486
G1 X80.325 Y143.17 E.00921
G1 X77.83 Y140.675 E.05749
G1 X77.83 Y140.109 E.00921
G1 X80.891 Y143.17 E.07051
G1 X81.456 Y143.17 E.00921
G1 X77.83 Y139.544 E.08354
G1 X77.83 Y138.978 E.00921
G1 X82.022 Y143.17 E.09656
M73 P78 R14
G1 X82.587 Y143.17 E.00921
G1 X77.83 Y138.413 E.10959
G1 X77.83 Y137.848 E.00921
G1 X83.152 Y143.17 E.12261
G1 X83.718 Y143.17 E.00921
G1 X77.83 Y137.282 E.13563
G1 X77.83 Y136.717 E.00921
G1 X84.283 Y143.17 E.14866
G1 X84.849 Y143.17 E.00921
G1 X77.83 Y136.151 E.16168
G1 X77.83 Y135.586 E.00921
G1 X85.414 Y143.17 E.17471
G1 X85.979 Y143.17 E.00921
G1 X77.83 Y135.021 E.18773
G1 X77.83 Y134.455 E.00921
G1 X86.545 Y143.17 E.20076
G1 X87.11 Y143.17 E.00921
G1 X77.83 Y133.89 E.21378
G1 X77.83 Y133.325 E.00921
G1 X87.675 Y143.17 E.2268
G1 X88.241 Y143.17 E.00921
G1 X77.83 Y132.759 E.23983
G1 X77.83 Y132.194 E.00921
G1 X88.806 Y143.17 E.25285
G1 X89.372 Y143.17 E.00921
G1 X77.83 Y131.628 E.26588
G1 X77.83 Y131.063 E.00921
G1 X89.937 Y143.17 E.2789
G1 X90.502 Y143.17 E.00921
G1 X77.83 Y130.498 E.29193
G1 X77.83 Y129.932 E.00921
G1 X91.068 Y143.17 E.30495
G1 X91.633 Y143.17 E.00921
G1 X77.83 Y129.367 E.31797
G1 X77.83 Y128.801 E.00921
G1 X92.199 Y143.17 E.331
G1 X92.764 Y143.17 E.00921
G1 X77.83 Y128.236 E.34402
G1 X77.83 Y127.671 E.00921
G1 X93.329 Y143.17 E.35705
G1 X93.895 Y143.17 E.00921
G1 X77.83 Y127.105 E.37007
G1 X77.83 Y126.54 E.00921
G1 X94.46 Y143.17 E.3831
G1 X95.025 Y143.17 E.00921
G1 X77.83 Y125.974 E.39612
G1 X77.83 Y125.409 E.00921
G1 X95.591 Y143.17 E.40914
G1 X96.156 Y143.17 E.00921
G1 X77.83 Y124.844 E.42217
G1 X77.83 Y124.278 E.00921
G1 X96.722 Y143.17 E.43519
G1 X97.287 Y143.17 E.00921
G1 X77.83 Y123.713 E.44822
G1 X77.83 Y123.148 E.00921
G1 X97.852 Y143.17 E.46124
G1 X98.418 Y143.17 E.00921
G1 X77.83 Y122.582 E.47427
G1 X77.83 Y122.017 E.00921
G1 X98.983 Y143.17 E.48729
G1 X99.549 Y143.17 E.00921
G1 X77.83 Y121.451 E.50031
G1 X77.83 Y120.886 E.00921
G1 X100.114 Y143.17 E.51334
G1 X100.679 Y143.17 E.00921
G1 X77.83 Y120.321 E.52636
G1 X77.83 Y119.755 E.00921
G1 X101.245 Y143.17 E.53939
G1 X101.81 Y143.17 E.00921
G1 X77.83 Y119.19 E.55241
G1 X77.83 Y118.624 E.00921
G1 X102.376 Y143.17 E.56544
G1 X102.941 Y143.17 E.00921
G1 X77.83 Y118.059 E.57846
G1 X77.83 Y117.494 E.00921
G1 X103.506 Y143.17 E.59148
G1 X104.072 Y143.17 E.00921
M73 P78 R13
G1 X77.83 Y116.928 E.60451
G1 X77.83 Y116.363 E.00921
G1 X104.637 Y143.17 E.61753
G1 X105.202 Y143.17 E.00921
G1 X77.83 Y115.798 E.63056
G1 X77.83 Y115.232 E.00921
G1 X105.768 Y143.17 E.64358
G1 X106.333 Y143.17 E.00921
G1 X77.83 Y114.667 E.65661
G1 X77.83 Y114.101 E.00921
G1 X106.899 Y143.17 E.66963
G1 X107.464 Y143.17 E.00921
G1 X77.83 Y113.536 E.68265
G1 X77.83 Y112.971 E.00921
G1 X108.029 Y143.17 E.69568
G1 X108.595 Y143.17 E.00921
G1 X77.83 Y112.405 E.7087
G1 X77.83 Y111.84 E.00921
G1 X109.16 Y143.17 E.72173
G1 X109.726 Y143.17 E.00921
G1 X77.83 Y111.274 E.73475
G1 X77.83 Y110.709 E.00921
G1 X110.291 Y143.17 E.74778
G1 X110.856 Y143.17 E.00921
G1 X77.83 Y110.144 E.7608
G1 X77.83 Y109.578 E.00921
G1 X111.422 Y143.17 E.77382
G1 X111.987 Y143.17 E.00921
G1 X77.83 Y109.013 E.78685
G1 X77.83 Y108.83 E.00298
G1 X78.212 Y108.83 E.00623
G1 X112.553 Y143.17 E.79106
G1 X113.118 Y143.17 E.00921
G1 X78.778 Y108.83 E.79106
G1 X79.343 Y108.83 E.00921
G1 X113.683 Y143.17 E.79106
G1 X114.249 Y143.17 E.00921
G1 X79.908 Y108.83 E.79106
G1 X80.474 Y108.83 E.00921
G1 X114.814 Y143.17 E.79106
G1 X115.379 Y143.17 E.00921
G1 X81.039 Y108.83 E.79106
G1 X81.605 Y108.83 E.00921
G1 X115.945 Y143.17 E.79106
G1 X116.51 Y143.17 E.00921
G1 X82.17 Y108.83 E.79106
G1 X82.735 Y108.83 E.00921
G1 X117.076 Y143.17 E.79106
G1 X117.641 Y143.17 E.00921
G1 X83.301 Y108.83 E.79106
G1 X83.866 Y108.83 E.00921
G1 X118.206 Y143.17 E.79106
G1 X118.772 Y143.17 E.00921
G1 X84.431 Y108.83 E.79106
G1 X84.997 Y108.83 E.00921
G1 X119.337 Y143.17 E.79106
G1 X119.903 Y143.17 E.00921
G1 X85.562 Y108.83 E.79106
G1 X86.128 Y108.83 E.00921
G1 X120.468 Y143.17 E.79106
G1 X121.033 Y143.17 E.00921
G1 X86.693 Y108.83 E.79106
G1 X87.258 Y108.83 E.00921
G1 X121.599 Y143.17 E.79106
G1 X122.164 Y143.17 E.00921
G1 X87.824 Y108.83 E.79106
G1 X88.389 Y108.83 E.00921
G1 X122.73 Y143.17 E.79106
G1 X123.295 Y143.17 E.00921
G1 X88.955 Y108.83 E.79106
G1 X89.52 Y108.83 E.00921
G1 X123.86 Y143.17 E.79106
G1 X124.426 Y143.17 E.00921
G1 X90.085 Y108.83 E.79106
G1 X90.651 Y108.83 E.00921
G1 X124.991 Y143.17 E.79106
G1 X125.556 Y143.17 E.00921
G1 X91.216 Y108.83 E.79106
G1 X91.782 Y108.83 E.00921
G1 X126.122 Y143.17 E.79106
G1 X126.687 Y143.17 E.00921
G1 X92.347 Y108.83 E.79106
G1 X92.912 Y108.83 E.00921
G1 X127.253 Y143.17 E.79106
G1 X127.818 Y143.17 E.00921
G1 X93.478 Y108.83 E.79106
G1 X94.043 Y108.83 E.00921
G1 X128.383 Y143.17 E.79106
G1 X128.949 Y143.17 E.00921
G1 X94.608 Y108.83 E.79106
G1 X95.174 Y108.83 E.00921
G1 X129.514 Y143.17 E.79106
G1 X130.08 Y143.17 E.00921
G1 X95.739 Y108.83 E.79106
G1 X96.305 Y108.83 E.00921
G1 X130.645 Y143.17 E.79106
G1 X131.21 Y143.17 E.00921
G1 X96.87 Y108.83 E.79106
G1 X97.435 Y108.83 E.00921
G1 X131.776 Y143.17 E.79106
G1 X132.341 Y143.17 E.00921
G1 X98.001 Y108.83 E.79106
G1 X98.566 Y108.83 E.00921
G1 X132.907 Y143.17 E.79106
G1 X133.472 Y143.17 E.00921
G1 X99.132 Y108.83 E.79106
G1 X99.697 Y108.83 E.00921
G1 X134.037 Y143.17 E.79106
G1 X134.603 Y143.17 E.00921
G1 X100.262 Y108.83 E.79106
G1 X100.828 Y108.83 E.00921
G1 X135.168 Y143.17 E.79106
G1 X135.733 Y143.17 E.00921
G1 X101.393 Y108.83 E.79106
G1 X101.958 Y108.83 E.00921
G1 X136.299 Y143.17 E.79106
G1 X136.864 Y143.17 E.00921
G1 X102.524 Y108.83 E.79106
G1 X103.089 Y108.83 E.00921
G1 X137.43 Y143.17 E.79106
M73 P79 R13
G1 X137.995 Y143.17 E.00921
G1 X103.655 Y108.83 E.79106
G1 X104.22 Y108.83 E.00921
G1 X138.56 Y143.17 E.79106
G1 X139.126 Y143.17 E.00921
G1 X104.785 Y108.83 E.79106
G1 X105.351 Y108.83 E.00921
G1 X139.691 Y143.17 E.79106
G1 X140.257 Y143.17 E.00921
G1 X105.916 Y108.83 E.79106
G1 X106.482 Y108.83 E.00921
G1 X140.822 Y143.17 E.79106
G1 X141.387 Y143.17 E.00921
G1 X107.047 Y108.83 E.79106
G1 X107.612 Y108.83 E.00921
G1 X141.953 Y143.17 E.79106
G1 X142.518 Y143.17 E.00921
G1 X108.178 Y108.83 E.79106
G1 X108.743 Y108.83 E.00921
G1 X143.084 Y143.17 E.79106
G1 X143.649 Y143.17 E.00921
G1 X109.309 Y108.83 E.79106
G1 X109.874 Y108.83 E.00921
G1 X144.214 Y143.17 E.79106
G1 X144.78 Y143.17 E.00921
G1 X110.439 Y108.83 E.79106
G1 X111.005 Y108.83 E.00921
G1 X145.345 Y143.17 E.79106
G1 X145.91 Y143.17 E.00921
G1 X111.57 Y108.83 E.79106
G1 X112.135 Y108.83 E.00921
G1 X146.476 Y143.17 E.79106
G1 X147.041 Y143.17 E.00921
G1 X112.701 Y108.83 E.79106
G1 X113.266 Y108.83 E.00921
G1 X147.607 Y143.17 E.79106
G1 X148.172 Y143.17 E.00921
G1 X113.832 Y108.83 E.79106
G1 X114.397 Y108.83 E.00921
G1 X148.737 Y143.17 E.79106
G1 X149.303 Y143.17 E.00921
G1 X114.962 Y108.83 E.79106
G1 X115.528 Y108.83 E.00921
G1 X149.868 Y143.17 E.79106
G1 X150.434 Y143.17 E.00921
G1 X116.093 Y108.83 E.79106
G1 X116.659 Y108.83 E.00921
G1 X150.999 Y143.17 E.79106
G1 X151.564 Y143.17 E.00921
G1 X117.224 Y108.83 E.79106
G1 X117.789 Y108.83 E.00921
G1 X152.13 Y143.17 E.79106
G1 X152.695 Y143.17 E.00921
G1 X118.355 Y108.83 E.79106
G1 X118.92 Y108.83 E.00921
G1 X153.261 Y143.17 E.79106
G1 X153.826 Y143.17 E.00921
G1 X119.486 Y108.83 E.79106
G1 X120.051 Y108.83 E.00921
G1 X154.391 Y143.17 E.79106
G1 X154.957 Y143.17 E.00921
G1 X120.616 Y108.83 E.79106
G1 X121.182 Y108.83 E.00921
G1 X155.522 Y143.17 E.79106
G1 X156.087 Y143.17 E.00921
G1 X121.747 Y108.83 E.79106
G1 X122.312 Y108.83 E.00921
G1 X156.653 Y143.17 E.79106
G1 X157.218 Y143.17 E.00921
G1 X122.878 Y108.83 E.79106
G1 X123.443 Y108.83 E.00921
G1 X157.784 Y143.17 E.79106
G1 X158.349 Y143.17 E.00921
G1 X124.009 Y108.83 E.79106
G1 X124.574 Y108.83 E.00921
G1 X158.914 Y143.17 E.79106
G1 X159.48 Y143.17 E.00921
G1 X125.139 Y108.83 E.79106
G1 X125.705 Y108.83 E.00921
G1 X160.045 Y143.17 E.79106
G1 X160.611 Y143.17 E.00921
G1 X126.27 Y108.83 E.79106
G1 X126.836 Y108.83 E.00921
G1 X161.176 Y143.17 E.79106
G1 X161.741 Y143.17 E.00921
G1 X127.401 Y108.83 E.79106
G1 X127.966 Y108.83 E.00921
G1 X162.307 Y143.17 E.79106
G1 X162.872 Y143.17 E.00921
G1 X128.532 Y108.83 E.79106
G1 X129.097 Y108.83 E.00921
G1 X163.437 Y143.17 E.79106
G1 X164.003 Y143.17 E.00921
G1 X129.663 Y108.83 E.79106
G1 X130.228 Y108.83 E.00921
G1 X164.568 Y143.17 E.79106
G1 X165.134 Y143.17 E.00921
G1 X130.793 Y108.83 E.79106
G1 X131.359 Y108.83 E.00921
G1 X165.699 Y143.17 E.79106
G1 X166.264 Y143.17 E.00921
G1 X131.924 Y108.83 E.79106
G1 X132.489 Y108.83 E.00921
G1 X166.83 Y143.17 E.79106
G1 X167.395 Y143.17 E.00921
G1 X133.055 Y108.83 E.79106
G1 X133.62 Y108.83 E.00921
G1 X167.961 Y143.17 E.79106
G1 X168.526 Y143.17 E.00921
G1 X134.186 Y108.83 E.79106
G1 X134.751 Y108.83 E.00921
G1 X169.091 Y143.17 E.79106
G1 X169.657 Y143.17 E.00921
G1 X135.316 Y108.83 E.79106
G1 X135.882 Y108.83 E.00921
G1 X170.222 Y143.17 E.79106
G1 X170.788 Y143.17 E.00921
G1 X136.447 Y108.83 E.79106
G1 X137.013 Y108.83 E.00921
G1 X171.353 Y143.17 E.79106
G1 X171.918 Y143.17 E.00921
G1 X137.578 Y108.83 E.79106
G1 X138.143 Y108.83 E.00921
G1 X172.484 Y143.17 E.79106
G1 X173.049 Y143.17 E.00921
G1 X138.709 Y108.83 E.79106
G1 X139.274 Y108.83 E.00921
M73 P79 R12
G1 X173.614 Y143.17 E.79106
G1 X174.18 Y143.17 E.00921
G1 X139.84 Y108.83 E.79106
G1 X140.405 Y108.83 E.00921
M73 P80 R12
G1 X174.745 Y143.17 E.79106
G1 X175.311 Y143.17 E.00921
G1 X140.97 Y108.83 E.79106
G1 X141.536 Y108.83 E.00921
G1 X175.876 Y143.17 E.79106
G1 X176.441 Y143.17 E.00921
G1 X142.101 Y108.83 E.79106
G1 X142.666 Y108.83 E.00921
G1 X177.007 Y143.17 E.79106
G1 X177.572 Y143.17 E.00921
G1 X143.232 Y108.83 E.79106
G1 X143.797 Y108.83 E.00921
G1 X178.138 Y143.17 E.79106
G1 X178.17 Y143.17 E.00053
G1 X178.17 Y142.637 E.00868
G1 X144.363 Y108.83 E.77879
G1 X144.928 Y108.83 E.00921
G1 X178.17 Y142.072 E.76577
G1 X178.17 Y141.507 E.00921
G1 X145.493 Y108.83 E.75274
G1 X146.059 Y108.83 E.00921
G1 X178.17 Y140.941 E.73972
G1 X178.17 Y140.376 E.00921
G1 X146.624 Y108.83 E.72669
G1 X147.19 Y108.83 E.00921
G1 X178.17 Y139.81 E.71367
G1 X178.17 Y139.245 E.00921
G1 X147.755 Y108.83 E.70064
G1 X148.32 Y108.83 E.00921
G1 X178.17 Y138.68 E.68762
G1 X178.17 Y138.114 E.00921
G1 X148.886 Y108.83 E.6746
G1 X149.451 Y108.83 E.00921
G1 X178.17 Y137.549 E.66157
G1 X178.17 Y136.983 E.00921
G1 X150.017 Y108.83 E.64855
G1 X150.582 Y108.83 E.00921
G1 X178.17 Y136.418 E.63552
G1 X178.17 Y135.853 E.00921
G1 X151.147 Y108.83 E.6225
G1 X151.713 Y108.83 E.00921
G1 X178.17 Y135.287 E.60947
G1 X178.17 Y134.722 E.00921
G1 X152.278 Y108.83 E.59645
G1 X152.843 Y108.83 E.00921
G1 X178.17 Y134.157 E.58343
G1 X178.17 Y133.591 E.00921
G1 X153.409 Y108.83 E.5704
G1 X153.974 Y108.83 E.00921
G1 X178.17 Y133.026 E.55738
G1 X178.17 Y132.46 E.00921
G1 X154.54 Y108.83 E.54435
G1 X155.105 Y108.83 E.00921
G1 X178.17 Y131.895 E.53133
G1 X178.17 Y131.33 E.00921
G1 X155.67 Y108.83 E.5183
G1 X156.236 Y108.83 E.00921
G1 X178.17 Y130.764 E.50528
G1 X178.17 Y130.199 E.00921
G1 X156.801 Y108.83 E.49226
G1 X157.367 Y108.83 E.00921
G1 X178.17 Y129.633 E.47923
G1 X178.17 Y129.068 E.00921
G1 X157.932 Y108.83 E.46621
G1 X158.497 Y108.83 E.00921
G1 X178.17 Y128.503 E.45318
G1 X178.17 Y127.937 E.00921
G1 X159.063 Y108.83 E.44016
G1 X159.628 Y108.83 E.00921
G1 X178.17 Y127.372 E.42713
G1 X178.17 Y126.806 E.00921
G1 X160.194 Y108.83 E.41411
G1 X160.759 Y108.83 E.00921
G1 X178.17 Y126.241 E.40109
G1 X178.17 Y125.676 E.00921
G1 X161.324 Y108.83 E.38806
G1 X161.89 Y108.83 E.00921
G1 X178.17 Y125.11 E.37504
G1 X178.17 Y124.545 E.00921
G1 X162.455 Y108.83 E.36201
G1 X163.02 Y108.83 E.00921
G1 X178.17 Y123.98 E.34899
G1 X178.17 Y123.414 E.00921
G1 X163.586 Y108.83 E.33596
G1 X164.151 Y108.83 E.00921
G1 X178.17 Y122.849 E.32294
G1 X178.17 Y122.283 E.00921
G1 X164.717 Y108.83 E.30992
G1 X165.282 Y108.83 E.00921
G1 X178.17 Y121.718 E.29689
G1 X178.17 Y121.153 E.00921
G1 X165.847 Y108.83 E.28387
G1 X166.413 Y108.83 E.00921
G1 X178.17 Y120.587 E.27084
G1 X178.17 Y120.022 E.00921
G1 X166.978 Y108.83 E.25782
G1 X167.544 Y108.83 E.00921
G1 X178.17 Y119.456 E.24479
G1 X178.17 Y118.891 E.00921
G1 X168.109 Y108.83 E.23177
G1 X168.674 Y108.83 E.00921
G1 X178.17 Y118.326 E.21875
G1 X178.17 Y117.76 E.00921
G1 X169.24 Y108.83 E.20572
G1 X169.805 Y108.83 E.00921
G1 X178.17 Y117.195 E.1927
G1 X178.17 Y116.629 E.00921
G1 X170.37 Y108.83 E.17967
G1 X170.936 Y108.83 E.00921
G1 X178.17 Y116.064 E.16665
G1 X178.17 Y115.499 E.00921
G1 X171.501 Y108.83 E.15362
G1 X172.067 Y108.83 E.00921
G1 X178.17 Y114.933 E.1406
G1 X178.17 Y114.368 E.00921
G1 X172.632 Y108.83 E.12758
G1 X173.197 Y108.83 E.00921
G1 X178.17 Y113.803 E.11455
G1 X178.17 Y113.237 E.00921
G1 X173.763 Y108.83 E.10153
G1 X174.328 Y108.83 E.00921
G1 X178.17 Y112.672 E.0885
G1 X178.17 Y112.106 E.00921
G1 X174.894 Y108.83 E.07548
G1 X175.459 Y108.83 E.00921
G1 X178.17 Y111.541 E.06245
G1 X178.17 Y110.976 E.00921
G1 X176.024 Y108.83 E.04943
G1 X176.59 Y108.83 E.00921
G1 X178.17 Y110.41 E.03641
G1 X178.17 Y109.845 E.00921
G1 X177.155 Y108.83 E.02338
G1 X177.721 Y108.83 E.00921
G1 X178.35 Y109.459 E.01449
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
M73 P81 R12
G1 X177.721 Y108.83 E-.338
G1 X177.155 Y108.83 E-.21485
G1 X177.541 Y109.215 E-.20715
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/25
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
M204 S10000
G17
G3 Z1.9 I-.765 J-.946 P1  F30000
G1 X134.085 Y144.357 Z1.9
G1 X51.016 Y211.534
G1 Z1.6
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S1000
G1  X24.516 Y211.534  E0.5272 F5400
G1  Y185.534  E0.5173
G1  X51.016  E0.5272
G1  Y211.534  E0.5173
M204 S10000
G1  X25.516 Y185.534  
;--------------------
; CP EMPTY GRID START
; layer #17
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X33.683 
M204 S1000
G1  Y185.534  E0.5173
M204 S10000
G1  X41.849 
M204 S1000
G1  Y211.534  E0.5173
M204 S10000
G1  X50.016 
M204 S1000
G1  Y185.534  E0.5173
; CP EMPTY GRID END
;------------------






M204 S10000
G1  X51.516 Y185.034  
M204 S1000
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
M204 S1000
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
G1 X129.979 Y144.357
G1 X165.813 Y126.744
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.35746
; LAYER_HEIGHT: 0.1
G1 F6000
M204 S1000
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
G1 X166.904 Y132.479 E.01143
; LINE_WIDTH: 0.55883
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
G1 X165.857 Y126.784 E.00771
G1 E-.8 F1800
M204 S10000
G1 X161.39 Y125.824 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.54105
G1 F6000
M204 S1000
G2 X162.269 Y125.389 I-3.067 J-7.303 E.02077
G1 X162.709 Y125.05 E.01176
G1 X162.65 Y125.299 E.00542
G2 X162.841 Y125.775 I1.104 J-.166 E.01096
G1 X162.943 Y125.861 E.00282
G2 X161.45 Y125.824 I-1.882 J45.89 E.03161
G1 E-.8 F1800
M204 S10000
G1 X163.954 Y123.635 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5061
G1 F6000
M204 S1000
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
G1 X164.002 Y123.6 E.0203
G1 E-.8 F1800
M204 S10000
G1 X157.616 Y119.42 Z2 F30000
G1 X156.304 Y118.562 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5316
M73 P81 R11
G1 F6000
M204 S1000
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
G1 X157.927 Y133.477 E.00309
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
G1 X156.304 Y118.622 E.13182
M204 S10000
G1 X155.835 Y118.093 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
G3 X166.204 Y133.488 I-2.736 J-1.633 E.03673
G1 X165.599 Y133.658 E.01097
G3 X162.387 Y133.907 I-2.938 J-17.065 E.05633
G1 X155.835 Y133.907 E.1144
G1 X155.835 Y118.153 E.27507
M204 S10000
G1 X155.406 Y117.664 F30000
G1 F6000
M204 S1000
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
G3 X167.751 Y132.925 I-3.862 J-1.71 E.02171
G1 X167.339 Y133.328 E.01006
G1 X166.875 Y133.648 E.00985
G1 X166.353 Y133.891 E.01005
G1 X165.691 Y134.078 E.01201
G3 X162.392 Y134.336 I-3.03 J-17.506 E.05787
G1 X155.406 Y134.336 E.12197
G1 X155.406 Y117.724 E.29003
G1 E-.8 F1800
M204 S10000
G1 X156.93 Y125.203 Z2 F30000
G1 X157.284 Y126.937 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
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
G1 X166.102 Y131.853 E.01023
G1 X165.687 Y132.264 E.01018
G3 X164.107 Y132.959 I-2.154 J-2.752 E.03045
G1 X163.345 Y133.022 E.01335
G3 X160.212 Y133.046 I-2.231 J-87.891 E.05471
G1 X157.927 Y133.048 E.03991
G1 X157.575 Y132.943 E.00641
G1 X157.361 Y132.71 E.00552
G1 X157.284 Y132.405 E.0055
G1 X157.284 Y126.997 E.09441
M204 S10000
G1 X157.712 Y126.937 F30000
G1 F6000
M204 S1000
G1 X157.816 Y126.754 E.00368
G1 X157.928 Y126.723 E.00203
G1 X161.7 Y126.727 E.06585
G3 X164.267 Y126.905 I.087 J17.326 E.04497
G1 X164.921 Y127.137 E.01212
G3 X166.124 Y128.397 I-1.163 J2.316 E.03103
G1 X166.297 Y128.944 E.01002
G1 X166.384 Y129.71 E.01346
G3 X166.036 Y131.195 I-3.384 J-.009 E.02686
G1 X165.751 Y131.607 E.00874
G3 X163.955 Y132.552 I-2.216 J-2.031 E.03615
G1 X163.31 Y132.595 E.01128
G3 X160.212 Y132.617 I-2.176 J-86.824 E.0541
G1 X157.927 Y132.619 E.0399
G1 X157.809 Y132.584 E.00214
G1 X157.716 Y132.442 E.00297
G1 X157.712 Y132.405 E.00065
G1 X157.712 Y126.997 E.09441
G1 E-.8 F1800
M204 S10000
G1 X160.884 Y125.883 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.42196
G1 F6000
M204 S1000
G1 X160.61 Y125.901 E.00448
G1 E-.8 F1800
M204 S10000
G1 X164.416 Y132.517 Z2 F30000
G1 X164.853 Y133.276 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.58256
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X154.071 Y126.891 Z2 F30000
G1 X149.195 Y118.562 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.5316
G1 F6000
M204 S1000
G1 X149.705 Y118.562 E.0106
G1 X149.705 Y133.438 E.30919
G1 X149.195 Y133.438 E.0106
G1 X149.195 Y118.622 E.30795
M204 S10000
G1 X148.726 Y118.093 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X150.175 Y118.093 E.0253
G1 X150.175 Y133.907 E.27612
G1 X148.726 Y133.907 E.0253
G1 X148.726 Y118.153 E.27507
M204 S10000
G1 X148.297 Y117.664 F30000
G1 F6000
M204 S1000
G1 X150.603 Y117.664 E.04026
G1 X150.603 Y134.336 E.29108
G1 X148.297 Y134.336 E.04026
G1 X148.297 Y117.724 E.29003
G1 E-.8 F1800
M204 S10000
G1 X147.822 Y125.342 Z2 F30000
G1 X146.66 Y143.96 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S1000
G1 X151.34 Y143.96 E.08015
G1 X151.34 Y144.381 E.0072
G1 X146.87 Y144.381 E.07655
G1 X146.66 Y144.381 E.0036
G1 X146.66 Y144.02 E.00617
G1 E-.8 F1800
M204 S10000
G1 X154.293 Y143.992 Z2 F30000
G1 X162.66 Y143.96 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X167.34 Y143.96 E.08015
G1 X167.34 Y144.381 E.0072
G1 X162.66 Y144.381 E.08015
G1 X162.66 Y144.02 E.00617
G1 E-.8 F1800
M204 S10000
G1 X168.742 Y139.409 Z2 F30000
G1 X178.96 Y131.66 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44183
G1 F6000
M204 S1000
G1 X179.381 Y131.66 E.0072
G1 X179.381 Y131.87 E.0036
G1 X179.381 Y136.34 E.07655
G1 X178.96 Y136.34 E.0072
G1 X178.96 Y131.72 E.07912
; WIPE_START
G1 X179.381 Y131.66 E-.16136
G1 X179.381 Y131.87 E-.07987
G1 X179.381 Y133.236 E-.51876
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.357 Y133.236 Z2 F30000
G1 X178.557 Y133.028
G1 X169.162 Y130.658
G1 X154.999 Y134.743
G1 X154.999 Y127.085
G1 X151.01 Y126.079
G1 X147.89 Y125.292
G1 X142.739 Y123.992
G1 X129.448 Y120.64
G1 X119.43 Y118.113
G1 X116.165 Y117.289
G1 X76.21 Y107.21
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 X179.79 Y144.79 E.3051
G1 X79.087 Y144.79 E1.63517
G1 X76.21 Y141.913 E.06607
G1 X76.21 Y107.27 E.56252
; WIPE_START
M204 S1000
G1 X78.21 Y107.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.809 Y107.977 Z2 F30000
G1 X178.96 Y116.66 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44183
G1 F6000
M204 S1000
G1 X179.381 Y116.66 E.0072
G1 X179.381 Y121.34 E.08015
G1 X178.96 Y121.34 E.0072
G1 X178.96 Y116.72 E.07912
G1 E-.8 F1800
M204 S10000
G1 X172.296 Y112.999 Z2 F30000
G1 X162.66 Y107.619 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S1000
G1 X167.34 Y107.619 E.08015
G1 X167.34 Y108.04 E.0072
G1 X162.66 Y108.04 E.08015
G1 X162.66 Y107.679 E.00617
G1 E-.8 F1800
M204 S10000
G1 X155.028 Y107.651 Z2 F30000
G1 X146.66 Y107.619 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X151.34 Y107.619 E.08015
G1 X151.34 Y108.04 E.0072
G1 X146.87 Y108.04 E.07655
G1 X146.66 Y108.04 E.0036
G1 X146.66 Y107.679 E.00617
G1 E-.8 F1800
M204 S10000
G1 X140.269 Y111.851 Z2 F30000
G1 X130.014 Y118.545 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.4966
G1 F6000
M204 S1000
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
G1 X139.058 Y129.812 E.03531
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
G2 X130.036 Y118.601 I-144.061 J54.405 E.033
M204 S10000
G1 X129.353 Y118.093 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X130.844 Y118.093 E.02604
G1 X132.176 Y121.758 E.06809
G1 X132.231 Y121.872 E.0022
G1 X132.541 Y122.135 E.0071
G1 X132.78 Y122.181 E.00426
G1 X140.6 Y122.181 E.13653
G1 X140.848 Y122.131 E.00443
G1 X141.196 Y121.778 E.00867
G1 X142.613 Y118.093 E.06893
G1 X144.201 Y118.093 E.02773
G1 X137.869 Y133.907 E.29743
G1 X135.512 Y133.907 E.04114
G1 X129.375 Y118.149 E.29528
M204 S10000
G1 X128.726 Y117.664 F30000
G1 F6000
M204 S1000
G1 X131.144 Y117.664 E.04223
G1 X132.579 Y121.612 E.07333
G1 X132.7 Y121.737 E.00305
G1 X132.78 Y121.753 E.00142
G1 X138.78 Y121.753 E.10476
G2 X140.647 Y121.748 I.495 J-152.321 E.0326
G1 X140.799 Y121.618 E.00347
G1 X142.319 Y117.664 E.07396
G1 X144.834 Y117.664 E.04393
G1 X138.159 Y134.336 E.31355
G1 X135.219 Y134.336 E.05132
M73 P82 R11
G1 X128.748 Y117.72 E.31133
G1 E-.8 F1800
M204 S10000
G1 X133 Y123.375 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X133.151 Y123.184 E.00426
G1 X133.459 Y123.038 E.00594
G1 X133.57 Y123.029 E.00195
G1 X139.771 Y123.029 E.10827
G1 X140.205 Y123.197 E.00813
G1 X140.355 Y123.402 E.00443
G1 X140.4 Y123.804 E.00706
G1 X140.374 Y123.895 E.00166
G1 X137.242 Y132.329 E.15707
G1 X137.186 Y132.443 E.00223
G1 X137.003 Y132.635 E.00463
G1 X136.64 Y132.748 E.00664
G1 X136.313 Y132.658 E.00592
G1 X136.09 Y132.438 E.00547
G1 X136.036 Y132.325 E.0022
G1 X132.966 Y123.891 E.1567
G1 X132.996 Y123.435 E.00799
M204 S10000
G1 X133.38 Y123.573 F30000
G1 F6000
M204 S1000
G1 X133.533 Y123.46 E.00331
G1 X133.57 Y123.457 E.00065
G1 X139.771 Y123.457 E.10827
G1 X139.947 Y123.549 E.00347
G1 X139.972 Y123.746 E.00346
G1 X136.839 Y132.185 E.15717
G1 X136.761 Y132.282 E.00217
G1 X136.603 Y132.316 E.00283
G1 X136.456 Y132.216 E.00309
G1 X136.438 Y132.178 E.00073
G1 X133.369 Y123.745 E.1567
G1 X133.376 Y123.632 E.00196
G1 E-.8 F1800
M204 S10000
G1 X139.771 Y122.605 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44012
G1 F6000
M204 S1000
G1 X133.57 Y122.605 E.10578
; LINE_WIDTH: 0.45628
G1 X133.384 Y122.613 E.00329
G1 E-.8 F1800
M204 S10000
G1 X126.728 Y118.879 Z2 F30000
G1 X106.66 Y107.619 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S1000
G1 X111.13 Y107.619 E.07655
G1 X111.34 Y107.619 E.0036
G1 X111.34 Y108.04 E.0072
G1 X106.66 Y108.04 E.08015
G1 X106.66 Y107.679 E.00617
G1 E-.8 F1800
M204 S10000
G1 X99.028 Y107.651 Z2 F30000
G1 X90.66 Y107.619 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X95.34 Y107.619 E.08015
G1 X95.34 Y108.04 E.0072
G1 X90.87 Y108.04 E.07655
G1 X90.66 Y108.04 E.0036
G1 X90.66 Y107.679 E.00617
G1 E-.8 F1800
M204 S10000
G1 X89.521 Y115.226 Z2 F30000
G1 X88.806 Y119.968 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.48742
G1 F6000
M204 S1000
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
G1 X100.652 Y128.664 E.0189
; LINE_WIDTH: 0.56709
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
G1 X88.765 Y120.012 E.01245
M204 S10000
G1 X89.136 Y120.304 F30000
; LINE_WIDTH: 0.49055
G1 F6000
M204 S1000
G1 X89.527 Y119.919 E.01049
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
G1 X100.144 Y128.433 E.0176
; LINE_WIDTH: 0.56795
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
G1 X89.094 Y120.347 E.00147
M204 S10000
G1 X89.699 Y120.364 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X89.835 Y120.223 E.00342
G3 X93.15 Y118.74 I3.876 J4.215 E.06452
G3 X96.746 Y119.448 I.665 J6.105 E.06499
G3 X99.459 Y122.955 I-3.051 J5.162 E.0793
G3 X99.848 Y126.855 I-11.667 J3.135 E.06873
G3 X99.273 Y129.693 I-9.604 J-.469 E.05075
G3 X95.947 Y132.943 I-5.237 J-2.033 E.0837
G3 X92.575 Y133.184 I-2.173 J-6.709 E.0596
G3 X88.479 Y129.986 I1.02 J-5.53 E.09433
G1 X88.125 Y129.067 E.0172
G3 X87.918 Y123.882 I11.43 J-3.053 E.09134
G3 X89.076 Y121.076 I7.126 J1.3 E.0534
G3 X89.391 Y120.68 I4.635 J3.362 E.00884
G1 X89.657 Y120.407 E.00665
M204 S10000
G1 X89.953 Y120.715 F30000
G1 F6000
M204 S1000
G1 X90.141 Y120.525 E.00465
G3 X93.807 Y119.135 I3.589 J3.936 E.07011
G3 X98.845 Y122.499 I.1 J5.304 E.11257
G3 X99.411 Y125.177 I-8.655 J3.229 E.04796
G3 X99.078 Y128.941 I-11.518 J.879 E.06629
G3 X96.349 Y132.311 I-5.174 J-1.401 E.07794
G3 X93.219 Y132.839 I-2.563 J-5.648 E.05606
G3 X90.114 Y131.521 I.395 J-5.243 E.05995
G3 X88.53 Y128.926 I3.877 J-4.149 E.05374
G3 X88.34 Y123.954 I11.033 J-2.91 E.08758
G3 X89.412 Y121.342 I6.704 J1.226 E.04965
G3 X89.728 Y120.946 I4.318 J3.119 E.00884
G1 X89.912 Y120.758 E.0046
G1 E-.8 F1800
M204 S10000
G1 X88.492 Y119.648 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G3 X90.922 Y118.22 I4.476 J4.838 E.04959
G1 X90.97 Y118.202 E.0009
G3 X93.371 Y117.796 I2.851 J9.55 E.04263
G1 X94.714 Y117.822 E.02345
G3 X97.687 Y118.642 I-.761 J8.562 E.05415
G3 X100.285 Y121.106 I-3.291 J6.07 E.06324
G3 X101.332 Y124.32 I-7.665 J4.276 E.05938
G1 X101.433 Y125.476 E.02026
G3 X101.119 Y128.802 I-12.808 J.467 E.05849
G3 X100.122 Y131.113 I-8.141 J-2.141 E.04411
G1 X99.632 Y131.764 E.01423
G3 X95.876 Y133.988 I-5.208 J-4.512 E.07754
G3 X91.084 Y133.857 I-2.125 J-9.997 E.08449
G1 X90.329 Y133.588 E.014
G3 X87.918 Y131.718 I2.674 J-5.937 E.05376
G3 X86.357 Y128.227 I5.879 J-4.724 E.06752
G3 X86.379 Y123.597 I13.613 J-2.25 E.08121
G3 X87.54 Y120.747 I7.688 J1.47 E.05409
G3 X88.448 Y119.689 I5.428 J3.739 E.02438
M204 S10000
G1 X88.204 Y119.338 F30000
G1 F6000
M204 S1000
G3 X90.768 Y117.82 I4.817 J5.214 E.05242
G1 X90.837 Y117.794 E.00128
G3 X93.358 Y117.367 I2.994 J10.018 E.04476
G1 X94.745 Y117.394 E.02421
G3 X97.857 Y118.245 I-.624 J8.402 E.05668
G3 X101.315 Y122.309 I-3.423 J6.414 E.09539
G3 X101.862 Y125.461 I-11.093 J3.549 E.05603
G3 X101.553 Y128.844 I-13.174 J.505 E.05947
G3 X100.18 Y131.786 I-7.776 J-1.838 E.05709
G3 X96.365 Y134.319 I-5.684 J-4.421 E.08136
G3 X90.962 Y134.269 I-2.605 J-10.437 E.09536
G1 X90.163 Y133.984 E.01481
G3 X87.586 Y131.99 I2.85 J-6.345 E.05743
G3 X86.505 Y130.236 I6.835 J-5.421 E.03604
G1 X86.191 Y129.376 E.016
G3 X85.748 Y125.385 I12.465 J-3.401 E.07039
G3 X86.44 Y121.892 I10.618 J.287 E.06248
G3 X88.16 Y119.379 I6.581 J2.66 E.05358
G1 E-.8 F1800
M204 S10000
G1 X80.731 Y117.629 Z2 F30000
G1 X76.619 Y116.66 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.44184
G1 F6000
M204 S1000
G1 X77.04 Y116.66 E.0072
G1 X77.04 Y121.34 E.08015
G1 X76.619 Y121.34 E.0072
G1 X76.619 Y116.72 E.07912
G1 E-.8 F1800
M204 S10000
G1 X76.619 Y124.353 Z2 F30000
G1 X76.619 Y131.66 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X77.04 Y131.66 E.0072
G1 X77.04 Y136.34 E.08015
G1 X76.619 Y136.34 E.0072
G1 X76.619 Y131.72 E.07912
G1 E-.8 F1800
M204 S10000
G1 X82.373 Y136.736 Z2 F30000
G1 X90.66 Y143.96 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X95.34 Y143.96 E.08015
G1 X95.34 Y144.381 E.0072
G1 X90.66 Y144.381 E.08015
G1 X90.66 Y144.02 E.00617
G1 E-.8 F1800
M204 S10000
G1 X98.293 Y143.992 Z2 F30000
G1 X106.66 Y143.96 Z2
G1 Z1.6
G1 E.8 F1800
G1 F6000
M204 S1000
G1 X111.34 Y143.96 E.08015
G1 X111.34 Y144.381 E.0072
G1 X106.66 Y144.381 E.08015
G1 X106.66 Y144.02 E.00617
G1 E-.8 F1800
M204 S10000
G1 X106.734 Y136.388 Z2 F30000
G1 X106.906 Y118.498 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.40268
G1 F6000
M204 S1000
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
G1 X118.19 Y133.502 E.14924
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
G1 X106.906 Y118.558 E.14409
M204 S10000
G1 X106.501 Y118.093 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X107.692 Y118.093 E.02079
G1 X107.701 Y127.945 E.17202
G1 X107.852 Y128.259 E.00608
G1 X108.159 Y128.453 E.00633
G1 X109.467 Y128.824 E.02374
G1 X109.829 Y128.821 E.00632
G1 X110.189 Y128.544 E.00794
G1 X116.65 Y118.093 E.21453
G1 X118.595 Y118.093 E.03395
G1 X118.595 Y133.907 E.27612
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
G1 X106.501 Y118.153 E.2017
M204 S10000
G1 X106.072 Y117.664 F30000
G1 F6000
M204 S1000
G1 X108.12 Y117.664 E.03576
G1 X108.12 Y127.664 E.1746
G2 X108.174 Y127.976 I.439 J.085 E.00564
G1 X108.276 Y128.04 E.00211
G1 X109.584 Y128.412 E.02374
G1 X109.705 Y128.411 E.00211
G1 X109.825 Y128.319 E.00265
G1 X116.411 Y117.664 E.2187
G1 X119.023 Y117.664 E.04561
G1 X119.023 Y134.336 E.29108
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
G1 X106.072 Y117.724 E.20919
G1 E-.8 F1800
M204 S10000
G1 X108.442 Y124.98 Z2 F30000
G1 X109.962 Y129.636 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
G1 X109.293 Y129.642 E.01087
G3 X107.929 Y129.263 I16.16 J-60.771 E.02299
G1 X107.343 Y128.903 E.01117
G1 X107.343 Y133.065 E.06759
G1 X107.861 Y133.065 E.00841
G1 X109.931 Y129.687 E.06433
M204 S10000
G1 X109.251 Y130.034 F30000
G1 F6000
M204 S1000
G3 X107.741 Y129.611 I4.084 J-17.467 E.02546
G1 X107.741 Y132.497 E.04686
G1 X109.219 Y130.085 E.04593
M204 S10000
G1 X108.633 Y130.287 F30000
; LINE_WIDTH: 0.41235
G1 F6000
M204 S1000
G1 X108.136 Y130.146 E.00822
G1 X108.136 Y131.098 E.01516
G1 X108.601 Y130.338 E.01418
G1 E-.8 F1800
M204 S10000
G1 X100.976 Y130.016 Z2 F30000
G1 X98.446 Y129.91 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X96.264 Y132.092 E.05011
G1 X95.359 Y132.433
G1 X98.822 Y128.971 E.07952
G1 X99.014 Y128.215
G1 X94.658 Y132.571 E.10003
G1 X94.044 Y132.621
G1 X99.122 Y127.543 E.11661
G1 X99.178 Y126.923
G1 X93.485 Y132.616 E.13074
G1 X92.969 Y132.569
G1 X99.2 Y126.338 E.14309
G1 X99.2 Y125.775
G1 X92.49 Y132.484 E.15408
G1 X92.045 Y132.365
G1 X99.181 Y125.23 E.16387
G1 X99.133 Y124.714
G1 X91.631 Y132.216 E.17228
G1 X91.253 Y132.031
G1 X99.065 Y124.219 E.17939
G1 X98.977 Y123.742
G1 X90.899 Y131.821 E.18551
G1 X90.568 Y131.588
G1 X98.865 Y123.291 E.19052
G1 X98.726 Y122.867
G1 X90.258 Y131.335 E.19446
G1 X89.978 Y131.051
G1 X98.568 Y122.46 E.19728
G1 X98.389 Y122.076
G1 X89.717 Y130.748 E.19914
G1 X89.476 Y130.426
G1 X98.179 Y121.723 E.19985
G1 X97.95 Y121.389
G1 X89.263 Y130.075 E.19948
G1 X89.076 Y129.699
G1 X97.701 Y121.074 E.19806
G1 X97.421 Y120.789
G1 X88.908 Y129.303 E.1955
G1 X88.763 Y128.884
G1 X97.124 Y120.523 E.192
G1 X96.807 Y120.276
G1 X88.648 Y128.436 E.18737
G1 X88.552 Y127.968
G1 X96.467 Y120.053 E.18176
G1 X96.096 Y119.861
G1 X88.475 Y127.481 E.17499
G1 X88.428 Y126.965
G1 X95.698 Y119.695 E.16694
G1 X95.27 Y119.559
G1 X88.402 Y126.428 E.15774
G1 X88.394 Y125.872
G1 X94.81 Y119.456 E.14733
G1 X94.31 Y119.392
G1 X88.411 Y125.291 E.13547
G1 X88.467 Y124.671
G1 X93.767 Y119.371 E.12171
G1 X93.168 Y119.407
G1 X88.569 Y124.006 E.10562
G1 X88.744 Y123.268
G1 X92.481 Y119.53 E.08583
G1 X91.635 Y119.813
G1 X89.091 Y122.356 E.05841
G1 E-.8 F1800
M204 S10000
G1 X90.719 Y129.813 Z2 F30000
G1 X91.197 Y132.003 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0821356
G1 F3600
M204 S1000
G3 X91.084 Y131.917 I.698 J-1.031 E.00035
G1 E-.8 F1800
M204 S10000
G1 X89.566 Y124.437 Z2 F30000
G1 X89.157 Y122.421 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.190936
G1 F3600
M204 S1000
G1 X89.025 Y122.608 E.00158
; LINE_WIDTH: 0.165184
G1 X88.893 Y122.795 E.00134
M204 S10000
G1 X90.914 Y120.221 F30000
; LINE_WIDTH: 0.0892257
G1 F3600
M204 S1000
G1 X90.744 Y120.36 E.00061
; LINE_WIDTH: 0.12225
G1 X90.542 Y120.543 E.00112
; LINE_WIDTH: 0.155917
G2 X89.946 Y121.124 I5.364 J6.107 E.00456
; LINE_WIDTH: 0.14108
G1 X89.753 Y121.34 E.00141
; LINE_WIDTH: 0.107763
G1 X89.561 Y121.556 E.00102
; LINE_WIDTH: 0.080203
G1 X89.487 Y121.649 E.00028
G1 E-.8 F1800
M204 S10000
G1 X95.305 Y126.589 Z2 F30000
G1 X98.661 Y129.439 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0729579
G1 F3600
M204 S1000
G1 X98.64 Y129.473 E.00008
; LINE_WIDTH: 0.0976398
G1 X98.554 Y129.597 E.00047
; LINE_WIDTH: 0.139661
G1 X98.467 Y129.721 E.00073
; LINE_WIDTH: 0.181681
G1 X98.381 Y129.844 E.00098
M204 S10000
G1 X97.865 Y130.805 F30000
; LINE_WIDTH: 0.0866869
G1 F3600
M204 S1000
G3 X97.157 Y131.513 I-7.393 J-6.682 E.00266
G1 E-.8 F1800
M204 S10000
G1 X104.189 Y128.546 Z2 F30000
G1 X117.753 Y122.825 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
G1 X117.753 Y118.935 E.06317
G1 X117.119 Y118.935 E.01028
G1 X115.166 Y122.094 E.06032
G1 X115.796 Y122.087 E.01023
G3 X117.164 Y122.465 I-16.582 J62.767 E.02304
G1 X117.702 Y122.794 E.01023
M204 S10000
G1 X117.354 Y122.117 F30000
G1 F6000
M204 S1000
G1 X117.354 Y119.333 E.04521
G1 X115.878 Y121.7 E.04529
G3 X117.299 Y122.093 I-8.142 J32.215 E.02394
M204 S10000
G1 X116.966 Y121.592 F30000
; LINE_WIDTH: 0.39881
G1 F6000
M204 S1000
G1 X116.966 Y120.678 E.01404
G1 X116.486 Y121.456 E.01406
G1 X116.909 Y121.575 E.00676
G1 E-.8 F1800
M204 S10000
G1 X124.512 Y122.237 Z2 F30000
G1 X132.241 Y122.909 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.51746
G1 F6000
M204 S1000
G2 X132.242 Y123.014 I-.025 J.053 E.00482
G1 E-.8 F1800
M204 S10000
G1 X139.874 Y122.95 Z2 F30000
G1 X141.252 Y122.939 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.62904
G1 F6000
M204 S1000
G2 X141.26 Y123.057 I-.035 J.061 E.00754
G1 E-.8 F1800
M204 S10000
G1 X137.633 Y129.772 Z2 F30000
G1 X137.159 Y130.649 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X136.405 Y131.403 E.0173
G1 X136.255 Y130.99
G1 X137.492 Y129.753 E.0284
G1 X137.825 Y128.856
G1 X136.105 Y130.576 E.0395
G1 X135.954 Y130.163
G1 X138.158 Y127.96 E.0506
G1 X138.49 Y127.063
G1 X135.804 Y129.75 E.0617
G1 X135.653 Y129.337
G1 X138.823 Y126.167 E.07279
G1 X139.156 Y125.27
G1 X135.503 Y128.924 E.08389
G1 X135.353 Y128.51
G1 X139.489 Y124.374 E.09499
G1 X139.608 Y123.691
G1 X135.202 Y128.097 E.10118
G1 X135.052 Y127.684
G1 X139.044 Y123.691 E.09169
G1 X138.481 Y123.691
G1 X134.901 Y127.271 E.0822
G1 X134.751 Y126.858
G1 X137.917 Y123.691 E.07271
G1 X137.354 Y123.691
G1 X134.601 Y126.444 E.06322
G1 X134.45 Y126.031
G1 X136.79 Y123.691 E.05373
G1 X136.226 Y123.691
G1 X134.3 Y125.618 E.04424
G1 X134.149 Y125.205
G1 X135.663 Y123.691 E.03475
G1 X135.099 Y123.691
G1 X133.999 Y124.792 E.02526
G1 X133.849 Y124.378
G1 X134.536 Y123.691 E.01578
G1 E-.8 F1800
M204 S10000
G1 X136.925 Y130.94 Z2 F30000
G1 X136.993 Y131.148 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.321995
G1 F3600
M204 S1000
G1 X136.641 Y131.663 E.00764
; LINE_WIDTH: 0.301815
G1 X136.589 Y131.632 E.00069
; LINE_WIDTH: 0.252939
G1 X136.537 Y131.6 E.00057
; LINE_WIDTH: 0.204064
G1 X136.485 Y131.569 E.00045
; LINE_WIDTH: 0.155188
G1 X136.433 Y131.537 E.00033
G1 E-.8 F1800
M204 S10000
G1 X143.788 Y129.497 Z2 F30000
G1 X156.771 Y125.895 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.53894
G1 F6000
M204 S1000
G2 X156.773 Y126.003 I-.027 J.055 E.0053
G1 E-.8 F1800
M204 S10000
G1 X162.664 Y130.856 Z2 F30000
G1 X164.327 Y132.226 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X166.048 Y130.504 E.03953
G1 X166.141 Y129.847
G1 X163.651 Y132.337 E.05718
G1 X163.06 Y132.365
G1 X166.125 Y129.3 E.07039
G1 X166.031 Y128.83
G1 X162.485 Y132.376 E.08142
G1 X161.916 Y132.381
G1 X165.874 Y128.424 E.09089
G1 X165.663 Y128.072
G1 X161.352 Y132.382 E.09898
G1 X160.788 Y132.382
G1 X165.402 Y127.769 E.10594
G1 X165.092 Y127.515
G1 X160.224 Y132.383 E.11179
G1 X159.66 Y132.383
G1 X164.732 Y127.311 E.11648
G1 X164.32 Y127.16
G1 X159.096 Y132.384 E.11996
G1 X158.532 Y132.385
G1 X163.841 Y127.076 E.12191
G1 X163.328 Y127.024
G1 X157.968 Y132.385 E.1231
G1 X157.946 Y131.842
G1 X162.79 Y126.999 E.11123
G1 X162.245 Y126.98
G1 X157.946 Y131.279 E.09872
G1 X157.946 Y130.715
G1 X161.701 Y126.961 E.08621
G1 X161.138 Y126.96
G1 X157.946 Y130.152 E.07329
G1 X157.946 Y129.588
G1 X160.575 Y126.96 E.06035
G1 X160.012 Y126.959
G1 X157.946 Y129.024 E.04742
G1 X157.946 Y128.461
G1 X159.449 Y126.959 E.03449
G1 X158.885 Y126.958
G1 X157.946 Y127.897 E.02156
G1 X157.946 Y127.334
G1 X158.322 Y126.958 E.00863
G1 E-.8 F1800
M204 S10000
G1 X165.054 Y130.555 Z2 F30000
G1 X165.87 Y130.992 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0864977
G1 F3600
M204 S1000
G1 X165.804 Y131.088 E.00031
; LINE_WIDTH: 0.122904
G1 X165.66 Y131.26 E.00093
; LINE_WIDTH: 0.170171
G3 X165.199 Y131.739 I-2.641 J-2.076 E.00404
; LINE_WIDTH: 0.144186
G1 X165.023 Y131.881 E.00113
; LINE_WIDTH: 0.0949145
G1 X164.846 Y132.023 E.00068
; LINE_WIDTH: 0.0697822
G1 X164.824 Y132.037 E.00005
G1 E-.8 F1800
M204 S10000
G1 X164.903 Y127.422 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0848539
G1 F3600
M204 S1000
G1 X164.779 Y127.33 E.0004
G1 E-.8 F1800
M204 S10000
G1 X169.642 Y133.212 Z2 F30000
G1 X179.035 Y144.571 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X179.571 Y144.035 E.01232
G1 X179.571 Y143.471
G1 X178.471 Y144.571 E.02526
G1 X177.907 Y144.571
G1 X179.571 Y142.907 E.0382
G1 X179.571 Y142.344
G1 X177.344 Y144.571 E.05114
G1 X176.78 Y144.571
G1 X179.571 Y141.78 E.06409
G1 X179.571 Y141.216
G1 X176.216 Y144.571 E.07703
G1 X175.653 Y144.571
G1 X179.571 Y140.653 E.08997
G1 X179.571 Y140.089
G1 X175.089 Y144.571 E.10291
G1 X174.526 Y144.571
G1 X179.571 Y139.526 E.11586
G1 X179.571 Y138.962
G1 X173.962 Y144.571 E.1288
G1 X173.398 Y144.571
G1 X179.571 Y138.398 E.14174
G1 X179.571 Y137.835
G1 X172.835 Y144.571 E.15469
G1 X172.271 Y144.571
G1 X179.571 Y137.271 E.16763
G1 X179.571 Y136.708
G1 X171.708 Y144.571 E.18057
G1 X171.144 Y144.571
G1 X179.145 Y136.57 E.18373
G1 X178.73 Y136.421
G1 X170.58 Y144.571 E.18715
G1 X170.017 Y144.571
G1 X178.73 Y135.858 E.20009
G1 X178.73 Y135.294
G1 X169.453 Y144.571 E.21303
G1 X168.89 Y144.571
G1 X178.73 Y134.73 E.22598
G1 X178.73 Y134.167
G1 X168.326 Y144.571 E.23892
G1 X167.762 Y144.571
G1 X178.73 Y133.603 E.25186
G1 X178.73 Y133.04
G1 X167.57 Y144.2 E.25628
G1 X167.476 Y143.73
G1 X178.73 Y132.476 E.25844
G1 X178.73 Y131.912
G1 X166.912 Y143.73 E.27138
G1 X166.349 Y143.73
G1 X179.571 Y130.508 E.30363
G1 X179.571 Y129.944
G1 X165.785 Y143.73 E.31657
G1 X165.221 Y143.73
G1 X179.571 Y129.381 E.32952
G1 X179.571 Y128.817
G1 X164.658 Y143.73 E.34246
G1 X164.094 Y143.73
G1 X179.571 Y128.254 E.3554
G1 X179.571 Y127.69
G1 X163.531 Y143.73 E.36835
G1 X162.967 Y143.73
G1 X179.571 Y127.126 E.38129
G1 X179.571 Y126.563
G1 X161.563 Y144.571 E.41354
G1 X160.999 Y144.571
G1 X179.571 Y125.999 E.42648
G1 X179.571 Y125.436
G1 X160.435 Y144.571 E.43942
G1 X159.872 Y144.571
G1 X179.571 Y124.872 E.45237
G1 X179.571 Y124.308
G1 X159.308 Y144.571 E.46531
G1 X158.745 Y144.571
G1 X179.571 Y123.745 E.47825
G1 X179.571 Y123.181
G1 X158.181 Y144.571 E.49119
G1 X157.617 Y144.571
G1 X179.571 Y122.617 E.50414
G1 X179.571 Y122.054
G1 X157.054 Y144.571 E.51708
G1 X156.49 Y144.571
G1 X179.491 Y121.57 E.52819
G1 X178.928 Y121.57
G1 X168.698 Y131.8 E.23492
G1 X168.934 Y131
G1 X178.73 Y121.204 E.22495
G1 X178.73 Y120.64
G1 X169.008 Y130.363 E.22326
G1 X169.027 Y129.78
G1 X178.73 Y120.077 E.22282
G1 X178.73 Y119.513
G1 X168.988 Y129.255 E.22371
G1 X168.907 Y128.773
G1 X178.73 Y118.949 E.22559
G1 X178.73 Y118.386
G1 X168.785 Y128.331 E.22837
G1 X168.627 Y127.925
G1 X178.73 Y117.822 E.232
G1 X178.73 Y117.259
G1 X168.435 Y127.553 E.23641
G1 X168.212 Y127.213
G1 X178.73 Y116.695 E.24155
G1 X178.995 Y116.43
G1 X179.571 Y115.854 E.01322
G1 X179.571 Y115.291
G1 X167.959 Y126.903 E.26666
G1 X167.677 Y126.621
G1 X179.571 Y114.727 E.27314
G1 X179.571 Y114.163
G1 X167.365 Y126.369 E.28029
G1 X167.025 Y126.145
G1 X179.571 Y113.6 E.2881
G1 X179.571 Y113.036
G1 X166.658 Y125.949 E.29654
G1 X166.263 Y125.78
G1 X179.571 Y112.473 E.30559
G1 X179.571 Y111.909
G1 X165.844 Y125.636 E.31522
G1 X165.4 Y125.516
G1 X179.571 Y111.345 E.32542
G1 X179.571 Y110.782
G1 X164.948 Y125.405 E.33581
G1 X164.495 Y125.294
G1 X179.571 Y110.218 E.3462
G1 X179.571 Y109.655
G1 X167.264 Y121.962 E.28262
M204 S10000
G1 X168.315 Y120.346 F30000
G1 F2700
M204 S2000
G1 X179.571 Y109.091 E.25847
G1 X179.571 Y108.527
G1 X169.269 Y118.829 E.23657
M204 S10000
G1 X170.104 Y117.43 F30000
G1 F2700
M204 S2000
G1 X179.571 Y107.964 E.21739
G1 X179.542 Y107.429
G1 X169.541 Y117.43 E.22966
G1 X168.977 Y117.43
G1 X178.978 Y107.429 E.22966
G1 X178.415 Y107.429
G1 X168.414 Y117.43 E.22966
G1 X167.85 Y117.43
G1 X177.851 Y107.429 E.22966
M73 P83 R11
G1 X177.287 Y107.429
G1 X167.286 Y117.43 E.22966
G1 E-.8 F1800
M204 S10000
G1 X163.489 Y122.355 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X161.155 Y124.688 E.05358
G1 X160.415 Y124.865
M73 P83 R10
G1 X164.654 Y120.626 E.09734
M204 S10000
G1 X165.819 Y118.898 F30000
G1 F2700
M204 S2000
G1 X159.791 Y124.926 E.13842
G1 X159.211 Y124.942
G1 X176.724 Y107.429 E.40217
G1 X176.16 Y107.429
G1 X158.645 Y124.944 E.40222
G1 X158.081 Y124.944
G1 X175.597 Y107.429 E.40222
G1 X175.033 Y107.429
G1 X157.946 Y124.516 E.39237
G1 X157.946 Y123.952
G1 X174.469 Y107.429 E.37943
G1 X173.906 Y107.429
G1 X157.946 Y123.388 E.36649
G1 X157.946 Y122.825
G1 X173.342 Y107.429 E.35354
G1 X172.778 Y107.429
G1 X157.946 Y122.261 E.3406
G1 X157.946 Y121.698
G1 X172.215 Y107.429 E.32766
G1 X171.651 Y107.429
G1 X157.946 Y121.134 E.31472
G1 X157.946 Y120.57
G1 X171.088 Y107.429 E.30177
G1 X170.524 Y107.429
G1 X157.946 Y120.007 E.28883
G1 X157.946 Y119.443
G1 X169.96 Y107.429 E.27589
G1 X169.397 Y107.429
G1 X157.946 Y118.88 E.26295
G1 X157.946 Y118.316
G1 X168.833 Y107.429 E.25
G1 X168.27 Y107.429
G1 X167.57 Y108.129 E.01607
G1 X167.429 Y108.27
G1 X157.946 Y117.752 E.21775
G1 X157.705 Y117.43
G1 X166.865 Y108.27 E.21035
G1 X166.302 Y108.27
G1 X157.142 Y117.43 E.21035
G1 X156.578 Y117.43
G1 X165.738 Y108.27 E.21035
G1 X165.174 Y108.27
G1 X156.014 Y117.43 E.21035
G1 X155.451 Y117.43
G1 X164.611 Y108.27 E.21035
G1 E-.8 F1800
M204 S10000
G1 X165.127 Y115.885 Z2 F30000
G1 X166.363 Y134.135 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X155.927 Y144.571 E.23965
G1 X155.363 Y144.571
G1 X165.612 Y134.322 E.23535
G1 X164.941 Y134.429
G1 X154.799 Y144.571 E.2329
G1 X154.236 Y144.571
G1 X164.304 Y134.503 E.23121
G1 X163.711 Y134.532
G1 X153.672 Y144.571 E.23054
G1 X153.109 Y144.571
G1 X163.119 Y134.56 E.22988
G1 X162.548 Y134.568
G1 X152.545 Y144.571 E.2297
G1 X151.981 Y144.571
G1 X161.982 Y134.57 E.22966
G1 X161.419 Y134.57
G1 X151.57 Y144.419 E.22617
G1 X151.57 Y143.855
G1 X160.855 Y134.57 E.21322
G1 X160.291 Y134.57
G1 X151.131 Y143.73 E.21035
G1 X150.568 Y143.73
G1 X159.728 Y134.57 E.21035
G1 X159.164 Y134.57
G1 X150.004 Y143.73 E.21035
G1 X149.441 Y143.73
G1 X158.601 Y134.57 E.21035
G1 X158.037 Y134.57
G1 X148.877 Y143.73 E.21035
G1 X148.313 Y143.73
G1 X157.473 Y134.57 E.21035
G1 X156.91 Y134.57
G1 X147.75 Y143.73 E.21035
G1 X147.186 Y143.73
G1 X156.346 Y134.57 E.21035
G1 X155.783 Y134.57
G1 X146.622 Y143.73 E.21035
G1 X146.43 Y143.922
G1 X145.782 Y144.571 E.01489
G1 X145.218 Y144.571
G1 X155.219 Y134.57 E.22966
G1 X155.172 Y134.053
G1 X144.655 Y144.571 E.24153
G1 X144.091 Y144.571
G1 X155.172 Y133.49 E.25447
G1 X155.172 Y132.926
G1 X143.527 Y144.571 E.26741
G1 X142.964 Y144.571
G1 X155.172 Y132.362 E.28036
G1 X155.172 Y131.799
G1 X142.4 Y144.571 E.2933
G1 X141.836 Y144.571
G1 X155.172 Y131.235 E.30624
G1 X155.172 Y130.671
G1 X141.273 Y144.571 E.31918
G1 X140.709 Y144.571
G1 X150.71 Y134.57 E.22966
G1 X150.147 Y134.57
G1 X140.146 Y144.571 E.22966
G1 X139.582 Y144.571
G1 X149.583 Y134.57 E.22966
G1 X149.019 Y134.57
G1 X139.018 Y144.571 E.22966
G1 X138.455 Y144.571
G1 X148.456 Y134.57 E.22966
G1 X148.063 Y134.399
G1 X137.891 Y144.571 E.23359
G1 X137.328 Y144.571
G1 X148.063 Y133.835 E.24653
G1 X148.063 Y133.272
G1 X136.764 Y144.571 E.25947
G1 X136.2 Y144.571
G1 X148.063 Y132.708 E.27241
G1 X148.063 Y132.145
G1 X135.637 Y144.571 E.28536
G1 X135.073 Y144.571
G1 X148.063 Y131.581 E.2983
G1 X148.063 Y131.017
G1 X134.51 Y144.571 E.31124
G1 X133.946 Y144.571
G1 X148.063 Y130.454 E.32418
G1 X148.063 Y129.89
G1 X133.382 Y144.571 E.33713
G1 X132.819 Y144.571
G1 X148.063 Y129.327 E.35007
G1 X148.063 Y128.763
G1 X132.255 Y144.571 E.36301
G1 X131.692 Y144.571
G1 X148.063 Y128.199 E.37596
G1 X148.063 Y127.636
G1 X131.128 Y144.571 E.3889
G1 X130.564 Y144.571
G1 X148.063 Y127.072 E.40184
G1 X148.063 Y126.508
G1 X130.001 Y144.571 E.41478
G1 X129.437 Y144.571
G1 X148.063 Y125.945 E.42773
G1 X148.063 Y125.381
G1 X128.874 Y144.571 E.44067
G1 X128.31 Y144.571
G1 X138.311 Y134.57 E.22966
G1 X137.747 Y134.57
G1 X127.746 Y144.571 E.22966
G1 X127.183 Y144.571
G1 X137.184 Y134.57 E.22966
G1 X136.62 Y134.57
G1 X126.619 Y144.571 E.22966
G1 X126.055 Y144.571
G1 X136.056 Y134.57 E.22966
G1 X135.493 Y134.57
G1 X125.492 Y144.571 E.22966
G1 X124.928 Y144.571
G1 X135.023 Y134.476 E.23181
G1 X134.865 Y134.071
G1 X124.365 Y144.571 E.24113
G1 X123.801 Y144.571
G1 X134.707 Y133.665 E.25044
G1 X134.549 Y133.259
G1 X123.237 Y144.571 E.25976
G1 X122.674 Y144.571
G1 X134.391 Y132.854 E.26907
G1 X134.233 Y132.448
G1 X122.11 Y144.571 E.27839
G1 X121.547 Y144.571
G1 X134.075 Y132.043 E.2877
G1 X133.917 Y131.637
G1 X120.983 Y144.571 E.29701
G1 X120.419 Y144.571
G1 X133.759 Y131.231 E.30633
G1 X133.601 Y130.826
G1 X119.856 Y144.571 E.31564
G1 X119.292 Y144.571
G1 X133.443 Y130.42 E.32496
M73 P84 R10
G1 X133.285 Y130.014
G1 X118.729 Y144.571 E.33427
G1 X118.165 Y144.571
G1 X133.127 Y129.609 E.34359
G1 X132.969 Y129.203
G1 X117.601 Y144.571 E.3529
G1 X117.038 Y144.571
G1 X132.811 Y128.798 E.36222
G1 X132.653 Y128.392
G1 X116.474 Y144.571 E.37153
G1 X115.911 Y144.571
G1 X132.495 Y127.986 E.38085
G1 X132.337 Y127.581
G1 X115.347 Y144.571 E.39016
G1 X114.783 Y144.571
G1 X132.179 Y127.175 E.39948
G1 X132.021 Y126.769
G1 X114.22 Y144.571 E.40879
G1 X113.656 Y144.571
G1 X131.863 Y126.364 E.4181
G1 X131.705 Y125.958
G1 X113.093 Y144.571 E.42742
G1 X112.529 Y144.571
G1 X131.547 Y125.553 E.43673
G1 X131.389 Y125.147
G1 X111.965 Y144.571 E.44605
G1 X111.57 Y144.403
G1 X131.231 Y124.741 E.4515
G1 X131.073 Y124.336
G1 X111.57 Y143.839 E.44787
G1 X111.115 Y143.73
G1 X130.915 Y123.93 E.45469
G1 X130.757 Y123.525
G1 X110.552 Y143.73 E.464
G1 X109.988 Y143.73
G1 X119.148 Y134.57 E.21035
G1 X118.585 Y134.57
G1 X109.424 Y143.73 E.21035
G1 X108.861 Y143.73
G1 X118.021 Y134.57 E.21035
G1 X117.457 Y134.57
G1 X108.297 Y143.73 E.21035
G1 X107.734 Y143.73
G1 X116.894 Y134.57 E.21035
G1 X116.741 Y134.159
G1 X107.17 Y143.73 E.21979
G1 X106.606 Y143.73
G1 X116.741 Y133.595 E.23273
G1 E-.8 F1800
M204 S10000
G1 X119.257 Y134.461 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X130.599 Y123.119 E.26045
G1 X130.441 Y122.713
G1 X119.257 Y133.897 E.25682
G1 X119.257 Y133.333
G1 X130.283 Y122.308 E.2532
G1 X130.125 Y121.902
G1 X119.257 Y132.77 E.24957
G1 X119.257 Y132.206
G1 X129.967 Y121.496 E.24594
G1 X129.809 Y121.091
G1 X119.257 Y131.643 E.24231
G1 X119.257 Y131.079
G1 X129.651 Y120.685 E.23868
G1 X129.493 Y120.28
G1 X119.257 Y130.515 E.23506
G1 X119.257 Y129.952
G1 X129.335 Y119.874 E.23143
G1 X129.177 Y119.468
G1 X119.257 Y129.388 E.2278
G1 X119.257 Y128.825
G1 X129.019 Y119.063 E.22417
G1 X128.861 Y118.657
G1 X119.257 Y128.261 E.22054
G1 X119.257 Y127.697
G1 X128.703 Y118.251 E.21692
G1 X128.545 Y117.846
G1 X119.257 Y127.134 E.21329
G1 X119.257 Y126.57
G1 X128.387 Y117.44 E.20966
G1 E-.8 F1800
M204 S10000
G1 X135.771 Y119.372 Z2 F30000
G1 X140.896 Y120.713 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X140.09 Y121.519 E.01851
G1 X139.526 Y121.519
G1 X141.248 Y119.797 E.03953
G1 X141.6 Y118.882
G1 X138.963 Y121.519 E.06055
G1 X138.399 Y121.519
G1 X141.952 Y117.966 E.08158
G1 E-.8 F1800
M204 S10000
G1 X147.032 Y123.662 Z2 F30000
G1 X148.063 Y124.818 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X138.322 Y134.559 E.2237
G1 X138.698 Y133.619
G1 X148.063 Y124.254 E.21506
G1 X148.063 Y123.69
G1 X139.075 Y132.679 E.20641
G1 X139.451 Y131.739
M73 P84 R9
G1 X148.063 Y123.127 E.19777
G1 X148.063 Y122.563
G1 X139.827 Y130.799 E.18913
G1 X140.204 Y129.859
G1 X148.063 Y122 E.18048
G1 X148.063 Y121.436
G1 X140.58 Y128.919 E.17184
G1 X140.956 Y127.979
G1 X148.063 Y120.872 E.1632
G1 X148.063 Y120.309
G1 X141.333 Y127.039 E.15455
G1 X141.709 Y126.099
G1 X148.063 Y119.745 E.14591
G1 X148.063 Y119.182
G1 X142.086 Y125.159 E.13727
G1 X142.462 Y124.219
G1 X148.063 Y118.618 E.12862
G1 X148.063 Y118.054
G1 X142.838 Y123.279 E.11998
G1 X143.215 Y122.339
G1 X148.063 Y117.491 E.11134
G1 E-.8 F1800
M204 S10000
G1 X151.81 Y124.14 Z2 F30000
G1 X155.172 Y130.108 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X150.837 Y134.443 E.09955
G1 X150.837 Y133.879
G1 X155.172 Y129.544 E.09955
G1 X155.172 Y128.981
G1 X150.837 Y133.316 E.09955
G1 X150.837 Y132.752
G1 X155.172 Y128.417 E.09955
G1 X155.172 Y127.853
G1 X150.837 Y132.188 E.09955
G1 X150.837 Y131.625
G1 X155.172 Y127.29 E.09955
G1 X155.172 Y126.726
G1 X150.837 Y131.061 E.09955
G1 X150.837 Y130.498
G1 X155.172 Y126.163 E.09955
G1 X155.172 Y125.599
G1 X150.837 Y129.934 E.09955
G1 X150.837 Y129.37
G1 X155.172 Y125.035 E.09955
G1 X155.172 Y124.472
G1 X150.837 Y128.807 E.09955
G1 X150.837 Y128.243
G1 X155.172 Y123.908 E.09955
G1 X155.172 Y123.345
G1 X150.837 Y127.679 E.09955
G1 X150.837 Y127.116
G1 X155.172 Y122.781 E.09955
G1 X155.172 Y122.217
G1 X150.837 Y126.552 E.09955
G1 X150.837 Y125.989
G1 X155.172 Y121.654 E.09955
G1 X155.172 Y121.09
G1 X150.837 Y125.425 E.09955
G1 X150.837 Y124.861
G1 X155.172 Y120.527 E.09955
G1 X155.172 Y119.963
G1 X150.837 Y124.298 E.09955
G1 X150.837 Y123.734
G1 X155.172 Y119.399 E.09955
G1 X155.172 Y118.836
G1 X150.837 Y123.171 E.09955
G1 X150.837 Y122.607
G1 X155.172 Y118.272 E.09955
G1 X155.172 Y117.709
G1 X150.837 Y122.043 E.09955
G1 X150.837 Y121.48
G1 X164.047 Y108.27 E.30335
G1 X163.484 Y108.27
G1 X150.837 Y120.916 E.29041
G1 X150.837 Y120.353
G1 X162.92 Y108.27 E.27747
G1 X162.43 Y108.196
G1 X150.837 Y119.789 E.26622
G1 X150.837 Y119.225
G1 X162.43 Y107.633 E.26622
G1 X162.07 Y107.429
G1 X150.837 Y118.662 E.25795
G1 X150.837 Y118.098
M73 P85 R9
G1 X161.506 Y107.429 E.245
G1 X160.943 Y107.429
G1 X150.837 Y117.535 E.23206
G1 X150.378 Y117.43
G1 X160.379 Y107.429 E.22966
G1 X159.816 Y107.429
G1 X149.815 Y117.43 E.22966
G1 X149.251 Y117.43
G1 X159.252 Y107.429 E.22966
G1 X158.688 Y107.429
G1 X148.687 Y117.43 E.22966
G1 X148.124 Y117.43
G1 X158.125 Y107.429 E.22966
G1 X157.561 Y107.429
G1 X143.591 Y121.399 E.32081
G1 X143.967 Y120.459
G1 X156.997 Y107.429 E.29922
G1 X156.434 Y107.429
G1 X144.344 Y119.519 E.27764
G1 X144.72 Y118.579
G1 X155.87 Y107.429 E.25605
G1 X155.307 Y107.429
G1 X145.756 Y116.98 E.21932
G1 X145.753 Y116.983
G1 X145.097 Y117.639 E.01507
G1 X144.742 Y117.43
G1 X154.743 Y107.429 E.22966
G1 X154.179 Y107.429
G1 X144.179 Y117.43 E.22966
G1 X143.615 Y117.43
G1 X153.616 Y107.429 E.22966
G1 X153.052 Y107.429
G1 X143.051 Y117.43 E.22966
G1 X142.488 Y117.43
G1 X152.489 Y107.429 E.22966
G1 E-.8 F1800
M204 S10000
G1 X151.084 Y108.27 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X137.835 Y121.519 E.30424
G1 X137.272 Y121.519
G1 X150.521 Y108.27 E.30425
G1 X149.957 Y108.27
G1 X136.708 Y121.519 E.30424
G1 X136.145 Y121.519
G1 X149.393 Y108.27 E.30425
G1 X148.83 Y108.27
G1 X135.581 Y121.519 E.30425
G1 X135.017 Y121.519
G1 X148.266 Y108.27 E.30425
G1 X147.703 Y108.27
G1 X134.454 Y121.519 E.30425
G1 X133.89 Y121.519
G1 X147.139 Y108.27 E.30425
G1 X146.575 Y108.27
G1 X133.327 Y121.519 E.30425
G1 X132.786 Y121.496
G1 X146.43 Y107.852 E.31332
G1 X146.289 Y107.429
G1 X132.636 Y121.082 E.31353
G1 X132.485 Y120.669
G1 X145.725 Y107.429 E.30404
G1 X145.162 Y107.429
G1 X132.335 Y120.256 E.29455
G1 X132.185 Y119.842
G1 X144.598 Y107.429 E.28505
G1 X144.035 Y107.429
G1 X132.035 Y119.429 E.27556
G1 X131.885 Y119.016
G1 X143.471 Y107.429 E.26607
G1 X142.907 Y107.429
G1 X131.734 Y118.602 E.25657
G1 X131.584 Y118.189
G1 X142.344 Y107.429 E.24708
G1 X141.78 Y107.429
G1 X131.434 Y117.775 E.23759
G1 X131.216 Y117.43
G1 X141.217 Y107.429 E.22966
G1 X140.653 Y107.429
G1 X130.652 Y117.43 E.22966
G1 X130.088 Y117.43
G1 X140.089 Y107.429 E.22966
G1 X139.526 Y107.429
G1 X129.525 Y117.43 E.22966
G1 X128.961 Y117.43
G1 X138.962 Y107.429 E.22966
G1 X138.398 Y107.429
G1 X128.398 Y117.43 E.22966
G1 E-.8 F1800
M204 S10000
G1 X133.636 Y111.879 Z2 F30000
G1 X137.835 Y107.429 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X119.257 Y126.007 E.42661
G1 X119.257 Y125.443
G1 X137.271 Y107.429 E.41367
G1 X136.708 Y107.429
G1 X119.257 Y124.879 E.40072
G1 X119.257 Y124.316
G1 X136.144 Y107.429 E.38778
G1 X135.58 Y107.429
G1 X119.257 Y123.752 E.37484
G1 X119.257 Y123.189
G1 X135.017 Y107.429 E.3619
G1 X134.453 Y107.429
G1 X119.257 Y122.625 E.34895
G1 X119.257 Y122.061
G1 X133.89 Y107.429 E.33601
G1 X133.326 Y107.429
G1 X119.257 Y121.498 E.32307
G1 X119.257 Y120.934
G1 X132.762 Y107.429 E.31013
G1 X132.199 Y107.429
G1 X119.257 Y120.37 E.29718
G1 X119.257 Y119.807
G1 X131.635 Y107.429 E.28424
G1 X131.072 Y107.429
G1 X119.257 Y119.243 E.2713
G1 X119.257 Y118.68
G1 X130.508 Y107.429 E.25836
G1 X129.944 Y107.429
G1 X119.257 Y118.116 E.24541
G1 X119.257 Y117.552
G1 X129.381 Y107.429 E.23247
G1 X128.817 Y107.429
G1 X118.816 Y117.43 E.22966
G1 X118.253 Y117.43
G1 X128.254 Y107.429 E.22966
G1 X127.69 Y107.429
G1 X117.689 Y117.43 E.22966
G1 X117.125 Y117.43
G1 X127.126 Y107.429 E.22966
G1 X126.563 Y107.429
G1 X116.562 Y117.43 E.22966
M204 S10000
G1 X110.35 Y127.024 F30000
G1 F2700
M204 S2000
G1 X109.289 Y128.085 E.02437
G1 X108.85 Y127.96
G1 X111.263 Y125.547 E.0554
M204 S10000
G1 X112.175 Y124.071 F30000
G1 F2700
M204 S2000
G1 X108.411 Y127.835 E.08644
G1 X108.354 Y127.328
G1 X113.088 Y122.595 E.1087
M204 S10000
G1 X114 Y121.119 F30000
G1 F2700
M204 S2000
G1 X108.354 Y126.765 E.12965
G1 X108.354 Y126.201
G1 X114.913 Y119.643 E.15061
M204 S10000
G1 X115.825 Y118.167 F30000
G1 F2700
M204 S2000
G1 X108.354 Y125.638 E.17156
G1 X108.354 Y125.074
G1 X125.999 Y107.429 E.40519
G1 X125.436 Y107.429
G1 X108.354 Y124.51 E.39225
G1 X108.354 Y123.947
G1 X124.872 Y107.429 E.37931
G1 X124.308 Y107.429
G1 X108.354 Y123.383 E.36637
G1 X108.354 Y122.819
G1 X123.745 Y107.429 E.35342
G1 X123.181 Y107.429
G1 X108.354 Y122.256 E.34048
G1 X108.354 Y121.692
G1 X122.617 Y107.429 E.32754
G1 X122.054 Y107.429
G1 X108.354 Y121.129 E.31459
G1 X108.354 Y120.565
G1 X121.49 Y107.429 E.30165
G1 X120.927 Y107.429
G1 X108.354 Y120.001 E.28871
G1 X108.354 Y119.438
G1 X120.363 Y107.429 E.27577
G1 X119.799 Y107.429
G1 X108.354 Y118.874 E.26282
G1 X108.354 Y118.311
G1 X119.236 Y107.429 E.24988
G1 X118.672 Y107.429
G1 X108.354 Y117.747 E.23694
G1 X108.108 Y117.43
G1 X118.109 Y107.429 E.22966
G1 X117.545 Y107.429
G1 X107.544 Y117.43 E.22966
G1 X106.981 Y117.43
G1 X116.981 Y107.429 E.22966
G1 X116.418 Y107.429
G1 X106.417 Y117.43 E.22966
G1 X105.853 Y117.43
G1 X115.854 Y107.429 E.22966
G1 E-.8 F1800
M204 S10000
G1 X113.945 Y114.819 Z2 F30000
G1 X106.43 Y143.906 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X105.766 Y144.571 E.01526
G1 X105.202 Y144.571
G1 X116.741 Y133.032 E.26498
G1 X116.741 Y132.468
G1 X104.638 Y144.571 E.27793
G1 X104.075 Y144.571
G1 X116.741 Y131.905 E.29087
G1 X116.741 Y131.341
G1 X103.511 Y144.571 E.30381
G1 X102.948 Y144.571
G1 X116.741 Y130.777 E.31675
G1 X116.741 Y130.214
G1 X102.384 Y144.571 E.3297
G1 X101.82 Y144.571
G1 X116.741 Y129.65 E.34264
G1 X116.741 Y129.087
G1 X101.257 Y144.571 E.35558
G1 X100.693 Y144.571
G1 X116.741 Y128.523 E.36852
G1 X116.741 Y127.959
G1 X100.13 Y144.571 E.38147
G1 X99.566 Y144.571
G1 X116.741 Y127.396 E.39441
G1 X116.741 Y126.832
G1 X99.002 Y144.571 E.40735
G1 X98.439 Y144.571
G1 X108.44 Y134.57 E.22966
G1 X107.876 Y134.57
G1 X97.875 Y144.571 E.22966
G1 X97.312 Y144.571
G1 X107.312 Y134.57 E.22966
G1 X106.749 Y134.57
G1 X96.748 Y144.571 E.22966
G1 X96.184 Y144.571
G1 X106.185 Y134.57 E.22966
G1 X105.838 Y134.354
G1 X95.621 Y144.571 E.23463
G1 X95.57 Y144.058
G1 X105.838 Y133.79 E.2358
G1 X105.838 Y133.226
G1 X95.334 Y143.73 E.24121
G1 X94.771 Y143.73
G1 X105.838 Y132.663 E.25415
G1 X105.838 Y132.099
G1 X94.207 Y143.73 E.26709
G1 X93.643 Y143.73
G1 X105.838 Y131.536 E.28003
G1 X105.838 Y130.972
G1 X93.08 Y143.73 E.29298
G1 X92.516 Y143.73
G1 X105.838 Y130.408 E.30592
G1 X105.838 Y129.845
G1 X91.953 Y143.73 E.31886
G1 X91.389 Y143.73
G1 X105.838 Y129.281 E.3318
M73 P86 R9
G1 X105.838 Y128.718
G1 X90.825 Y143.73 E.34475
G1 X90.43 Y144.125
G1 X89.985 Y144.571 E.01023
G1 X89.421 Y144.571
G1 X105.838 Y128.154 E.377
G1 X105.838 Y127.59
G1 X88.857 Y144.571 E.38994
G1 X88.294 Y144.571
G1 X105.838 Y127.027 E.40288
G1 X105.838 Y126.463
G1 X100.326 Y131.975 E.12658
M204 S10000
G1 X101.219 Y130.519 F30000
G1 F2700
M204 S2000
G1 X105.838 Y125.9 E.10608
G1 X105.838 Y125.336
G1 X101.575 Y129.598 E.09789
G1 X101.798 Y128.812
G1 X105.838 Y124.772 E.09277
G1 X105.838 Y124.209
G1 X101.936 Y128.111 E.0896
G1 X102.018 Y127.465
M73 P86 R8
G1 X105.838 Y123.645 E.08771
G1 X105.838 Y123.081
G1 X102.074 Y126.845 E.08643
G1 X102.095 Y126.261
G1 X105.838 Y122.518 E.08596
G1 X105.838 Y121.954
G1 X102.095 Y125.697 E.08595
G1 X102.076 Y125.153
G1 X105.838 Y121.391 E.08639
G1 X105.838 Y120.827
G1 X102.039 Y124.626 E.08723
G1 X101.974 Y124.127
G1 X105.838 Y120.263 E.08873
G1 X105.838 Y119.7
G1 X101.899 Y123.638 E.09044
G1 X101.798 Y123.176
G1 X105.838 Y119.136 E.09278
G1 X105.838 Y118.573
G1 X101.687 Y122.723 E.09531
G1 X101.548 Y122.299
G1 X105.838 Y118.009 E.09851
G1 X105.838 Y117.445
G1 X101.403 Y121.881 E.10185
G1 X101.227 Y121.493
G1 X115.291 Y107.429 E.32295
G1 X114.727 Y107.429
G1 X101.048 Y121.108 E.31413
G1 X100.838 Y120.755
G1 X114.163 Y107.429 E.30601
G1 X113.6 Y107.429
G1 X100.625 Y120.404 E.29795
G1 X100.382 Y120.084
G1 X113.036 Y107.429 E.2906
G1 X112.473 Y107.429
G1 X100.137 Y119.765 E.28328
G1 X99.862 Y119.476
G1 X111.068 Y108.27 E.25734
G1 X110.505 Y108.27
G1 X99.586 Y119.189 E.25074
G1 X99.281 Y118.93
G1 X109.941 Y108.27 E.24479
G1 X109.377 Y108.27
G1 X98.975 Y118.673 E.23889
G1 X98.638 Y118.446
G1 X108.814 Y108.27 E.23368
G1 X108.25 Y108.27
G1 X98.299 Y118.221 E.22853
G1 X97.927 Y118.029
G1 X107.687 Y108.27 E.22411
G1 X107.123 Y108.27
G1 X97.551 Y117.842 E.2198
G1 X97.145 Y117.684
G1 X106.559 Y108.27 E.21618
G1 X106.43 Y107.836
G1 X96.729 Y117.537 E.22278
G1 X96.286 Y117.416
G1 X106.273 Y107.429 E.22933
G1 X105.709 Y107.429
G1 X95.825 Y117.313 E.22697
G1 X95.345 Y117.23
G1 X105.146 Y107.429 E.22507
G1 X104.582 Y107.429
G1 X94.834 Y117.177 E.22386
G1 X94.311 Y117.137
G1 X104.018 Y107.429 E.22292
G1 X103.455 Y107.429
G1 X93.752 Y117.132 E.22281
G1 X93.174 Y117.147
G1 X102.891 Y107.429 E.22315
G1 X102.328 Y107.429
G1 X92.561 Y117.196 E.22428
G1 X91.896 Y117.298
G1 X101.764 Y107.429 E.22662
G1 X101.2 Y107.429
G1 X91.168 Y117.462 E.23039
G1 X90.327 Y117.739
G1 X100.637 Y107.429 E.23675
G1 X100.073 Y107.429
G1 X89.235 Y118.268 E.2489
G1 E-.8 F1800
M204 S10000
G1 X93.447 Y124.633 Z2 F30000
G1 X99.11 Y133.191 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X87.73 Y144.571 E.26133
G1 X87.167 Y144.571
G1 X97.648 Y134.09 E.24069
G1 X96.728 Y134.446
G1 X86.603 Y144.571 E.23251
G1 X86.039 Y144.571
G1 X95.962 Y134.648 E.22787
G1 X95.278 Y134.769
G1 X85.476 Y144.571 E.22509
G1 X84.912 Y144.571
G1 X94.64 Y134.843 E.2234
G1 X94.053 Y134.866
G1 X84.349 Y144.571 E.22286
G1 X83.785 Y144.571
G1 X93.491 Y134.865 E.22289
G1 X92.95 Y134.842
G1 X83.221 Y144.571 E.22341
G1 X82.658 Y144.571
G1 X92.437 Y134.792 E.22456
G1 X91.939 Y134.726
G1 X82.094 Y144.571 E.22608
G1 X81.531 Y144.571
G1 X91.464 Y134.638 E.22811
G1 X91.013 Y134.525
G1 X80.967 Y144.571 E.23069
G1 X80.403 Y144.571
G1 X90.582 Y134.392 E.23375
G1 X90.172 Y134.239
G1 X79.84 Y144.571 E.23726
G1 X79.276 Y144.571
G1 X89.785 Y134.062 E.24133
G1 X89.412 Y133.871
G1 X78.945 Y144.338 E.24037
G1 X78.663 Y144.056
G1 X89.065 Y133.655 E.23886
G1 X88.736 Y133.42
G1 X78.382 Y143.775 E.23778
G1 X78.1 Y143.493
G1 X88.418 Y133.174 E.23696
G1 X88.126 Y132.903
G1 X77.818 Y143.211 E.23671
G1 X77.536 Y142.929
G1 X87.839 Y132.626 E.2366
G1 X87.574 Y132.328
G1 X77.254 Y142.647 E.23697
G1 X76.973 Y142.366
G1 X87.317 Y132.021 E.23755
G1 X87.076 Y131.698
G1 X76.691 Y142.084 E.23849
G1 X76.429 Y141.782
G1 X86.851 Y131.36 E.23933
G1 X86.636 Y131.011
G1 X76.429 Y141.218 E.23439
G1 X76.429 Y140.655
G1 X86.445 Y130.639 E.23
G1 X86.262 Y130.258
G1 X76.429 Y140.091 E.22579
G1 X76.429 Y139.527
G1 X86.101 Y129.855 E.22211
G1 X85.962 Y129.431
G1 X76.429 Y138.964 E.21891
G1 X76.429 Y138.4
G1 X85.842 Y128.987 E.21617
G1 X85.741 Y128.524
G1 X76.429 Y137.837 E.21385
G1 X76.429 Y137.273
G1 X77.132 Y136.57 E.01614
G1 X77.27 Y136.432
G1 X85.659 Y128.043 E.19264
G1 X85.594 Y127.545
G1 X77.27 Y135.869 E.19115
G1 X77.27 Y135.305
G1 X85.546 Y127.028 E.19006
G1 X85.517 Y126.495
G1 X77.27 Y134.741 E.18938
G1 X77.27 Y134.178
G1 X85.506 Y125.941 E.18914
G1 X85.524 Y125.36
G1 X77.27 Y133.614 E.18954
G1 X77.27 Y133.051
G1 X85.553 Y124.767 E.19021
G1 X85.623 Y124.133
G1 X77.27 Y132.487 E.19183
G1 X77.27 Y131.923
G1 X85.744 Y123.449 E.1946
G1 X85.921 Y122.708
G1 X77.2 Y131.43 E.20029
G1 X76.636 Y131.43
G1 X86.215 Y121.851 E.21996
G1 X86.752 Y120.751
G1 X76.429 Y131.073 E.23704
G1 X76.429 Y130.51
G1 X99.51 Y107.429 E.53002
G1 X98.946 Y107.429
G1 X76.429 Y129.946 E.51708
G1 X76.429 Y129.382
G1 X98.382 Y107.429 E.50413
G1 X97.819 Y107.429
G1 X76.429 Y128.819 E.49119
G1 X76.429 Y128.255
G1 X97.255 Y107.429 E.47825
G1 X96.692 Y107.429
G1 X76.429 Y127.692 E.46531
G1 X76.429 Y127.128
G1 X95.287 Y108.27 E.43306
G1 X94.724 Y108.27
G1 X76.429 Y126.564 E.42011
G1 X76.429 Y126.001
G1 X94.16 Y108.27 E.40717
G1 X93.596 Y108.27
G1 X76.429 Y125.437 E.39423
G1 X76.429 Y124.874
G1 X93.033 Y108.27 E.38129
G1 X92.469 Y108.27
M73 P87 R8
G1 X76.429 Y124.31 E.36834
G1 X76.429 Y123.746
G1 X91.906 Y108.27 E.3554
G1 X91.342 Y108.27
G1 X76.429 Y123.183 E.34246
G1 X76.429 Y122.619
G1 X90.778 Y108.27 E.32951
G1 X90.43 Y108.055
G1 X77.27 Y121.215 E.30221
G1 X77.27 Y120.651
G1 X90.43 Y107.491 E.30221
G1 X89.928 Y107.429
G1 X77.27 Y120.088 E.29069
G1 X77.27 Y119.524
G1 X89.365 Y107.429 E.27774
G1 X88.801 Y107.429
G1 X77.27 Y118.96 E.2648
G1 X77.27 Y118.397
G1 X88.237 Y107.429 E.25186
G1 X87.674 Y107.429
G1 X77.27 Y117.833 E.23892
G1 X77.27 Y117.27
G1 X87.11 Y107.429 E.22597
G1 X86.547 Y107.429
G1 X77.27 Y116.706 E.21303
G1 X76.982 Y116.43
G1 X85.983 Y107.429 E.2067
G1 X85.419 Y107.429
G1 X76.429 Y116.419 E.20645
G1 X76.429 Y115.856
G1 X84.856 Y107.429 E.19351
G1 X84.292 Y107.429
G1 X76.429 Y115.292 E.18057
G1 X76.429 Y114.729
G1 X83.729 Y107.429 E.16762
G1 X83.165 Y107.429
G1 X76.429 Y114.165 E.15468
G1 X76.429 Y113.601
G1 X82.601 Y107.429 E.14174
G1 X82.038 Y107.429
G1 X76.429 Y113.038 E.1288
G1 X76.429 Y112.474
G1 X81.474 Y107.429 E.11585
G1 X80.911 Y107.429
G1 X76.429 Y111.911 E.10291
G1 X76.429 Y111.347
G1 X80.347 Y107.429 E.08997
G1 X79.783 Y107.429
G1 X76.429 Y110.783 E.07703
G1 X76.429 Y110.22
G1 X79.22 Y107.429 E.06408
G1 X78.656 Y107.429
G1 X76.429 Y109.656 E.05114
G1 X76.429 Y109.093
G1 X78.093 Y107.429 E.0382
G1 X77.529 Y107.429
G1 X76.429 Y108.529 E.02526
G1 X76.429 Y107.965
G1 X76.965 Y107.429 E.01231
G1 E-.8 F1800
M204 S10000
G1 X76.686 Y115.057 Z2 F30000
G1 X76.429 Y122.056 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X76.915 Y121.57 E.01115
G1 E-.8 F1800
M204 S10000
G1 X83.062 Y117.046 Z2 F30000
G1 X96.128 Y107.429 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X95.57 Y107.987 E.01282
G1 E-.8 F1800
M204 S10000
G1 X101.347 Y112.976 Z2 F30000
G1 X116.741 Y126.269 Z2
G1 Z1.6
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X109.12 Y133.889 E.175
M204 S10000
G1 X110.013 Y132.433 F30000
G1 F2700
M204 S2000
G1 X116.741 Y125.705 E.15451
G1 X116.741 Y125.141
G1 X110.905 Y130.977 E.13402
M204 S10000
G1 X111.797 Y129.522 F30000
G1 F2700
M204 S2000
G1 X116.741 Y124.578 E.11353
G1 X116.741 Y124.014
G1 X112.689 Y128.066 E.09304
M204 S10000
G1 X113.582 Y126.61 F30000
G1 F2700
M204 S2000
G1 X116.384 Y123.808 E.06434
G1 X115.944 Y123.684
G1 X114.474 Y125.154 E.03376
G1 E-.8 F1800
M204 S10000
G1 X107.791 Y128.84 Z2 F30000
G1 X79.233 Y144.591 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11094
G1 F3600
M204 S1000
G1 X79.104 Y144.462 E.00067
G1 E-.8 F1800
M204 S10000
G1 X86.736 Y144.441 Z2 F30000
G1 X167.592 Y144.222 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.105098
G1 F3600
M204 S1000
G1 X167.592 Y144.591 E.00126
G1 E-.8 F1800
M204 S10000
G1 X160.041 Y143.476 Z2 F30000
G1 X76.503 Y131.147 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.12793
G1 F3600
M204 S1000
G1 X76.459 Y131.254 E.0005
G1 X76.459 Y131.45 E.00085
G1 E-.8 F1800
M204 S10000
G1 X81.696 Y125.898 Z2 F30000
G1 X87.35 Y119.904 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0751855
G1 F3600
M204 S1000
G1 X87.221 Y120.042 E.00041
; LINE_WIDTH: 0.103719
G1 X87.043 Y120.256 E.00093
; LINE_WIDTH: 0.148563
G1 X86.864 Y120.471 E.00144
; LINE_WIDTH: 0.193406
G1 X86.686 Y120.685 E.00195
M204 S10000
G1 X89.171 Y118.204 F30000
; LINE_WIDTH: 0.199023
G1 F3600
M204 S1000
G1 X88.993 Y118.349 E.00166
; LINE_WIDTH: 0.159552
M73 P87 R7
G1 X88.816 Y118.494 E.00129
; LINE_WIDTH: 0.119707
G1 X88.635 Y118.641 E.00093
; LINE_WIDTH: 0.0844917
G1 X88.371 Y118.882 E.00092
M204 S10000
G1 X90.256 Y117.667 F30000
; LINE_WIDTH: 0.0978984
G1 F3600
M204 S1000
G2 X89.893 Y117.92 I4.256 J6.482 E.00138
G1 E-.8 F1800
M204 S10000
G1 X94.329 Y117.155 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0904763
G1 F3600
M204 S1000
G1 X94.108 Y117.058 E.00068
G1 E-.8 F1800
M204 S10000
G1 X98.023 Y123.61 Z2 F30000
G1 X101.643 Y129.666 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.174097
G1 F3600
M204 S1000
G3 X101.434 Y130.004 I-6.801 J-3.971 E.00247
M204 S10000
G1 X101.284 Y130.584 F30000
; LINE_WIDTH: 0.184236
G1 F3600
M204 S1000
G1 X101.167 Y130.742 E.0013
; LINE_WIDTH: 0.138251
G1 X101.051 Y130.899 E.00093
; LINE_WIDTH: 0.0922664
G1 X100.934 Y131.056 E.00057
M204 S10000
G1 X100.389 Y132.039 F30000
; LINE_WIDTH: 0.206715
G1 F3600
M204 S1000
G3 X99.174 Y133.255 I-12.586 J-11.366 E.01298
M204 S10000
G1 X98.161 Y133.829 F30000
; LINE_WIDTH: 0.0844509
G1 F3600
M204 S1000
G1 X98.057 Y133.909 E.00034
; LINE_WIDTH: 0.115477
G1 X97.948 Y133.993 E.00053
; LINE_WIDTH: 0.14922
G1 X97.83 Y134.074 E.00074
; LINE_WIDTH: 0.184093
G1 X97.713 Y134.155 E.00094
M204 S10000
G1 X94.854 Y134.911 F30000
; LINE_WIDTH: 0.103648
G1 F3600
M204 S1000
G1 X94.625 Y134.827 E.00082
G1 E-.8 F1800
M204 S10000
G1 X101.499 Y131.51 Z2 F30000
G1 X114.538 Y125.218 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X114.385 Y125.412 E.00171
; LINE_WIDTH: 0.142203
G1 X114.232 Y125.607 E.00122
; LINE_WIDTH: 0.0935905
G1 X114.079 Y125.801 E.00073
M204 S10000
G1 X113.646 Y126.674 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X113.493 Y126.868 E.00171
; LINE_WIDTH: 0.142203
G1 X113.34 Y127.063 E.00122
; LINE_WIDTH: 0.0935908
G1 X113.187 Y127.257 E.00073
M204 S10000
G1 X112.754 Y128.13 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X112.601 Y128.324 E.00171
; LINE_WIDTH: 0.142203
G1 X112.448 Y128.518 E.00122
; LINE_WIDTH: 0.0935907
G1 X112.294 Y128.713 E.00073
M204 S10000
G1 X111.861 Y129.586 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X111.708 Y129.78 E.00171
; LINE_WIDTH: 0.142202
G1 X111.555 Y129.974 E.00122
; LINE_WIDTH: 0.0935903
G1 X111.402 Y130.168 E.00073
M204 S10000
G1 X110.969 Y131.042 F30000
; LINE_WIDTH: 0.190803
G1 F3600
M204 S1000
G1 X110.816 Y131.236 E.00171
; LINE_WIDTH: 0.142195
G1 X110.663 Y131.43 E.00122
; LINE_WIDTH: 0.0935881
G1 X110.51 Y131.624 E.00073
M204 S10000
G1 X110.077 Y132.498 F30000
; LINE_WIDTH: 0.190803
G1 F3600
M204 S1000
G1 X109.924 Y132.692 E.00171
; LINE_WIDTH: 0.142195
G1 X109.771 Y132.886 E.00122
; LINE_WIDTH: 0.0935879
G1 X109.618 Y133.08 E.00073
M204 S10000
G1 X109.185 Y133.953 F30000
; LINE_WIDTH: 0.190815
G1 F3600
M204 S1000
G1 X109.032 Y134.148 E.00171
; LINE_WIDTH: 0.142202
G1 X108.878 Y134.342 E.00122
; LINE_WIDTH: 0.0935903
G1 X108.725 Y134.536 E.00073
G1 E-.8 F1800
M204 S10000
G1 X109.841 Y127.844 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0890942
G1 F3600
M204 S1000
G1 X109.706 Y128.015 E.0006
; LINE_WIDTH: 0.128716
G1 X109.571 Y128.186 E.00095
M204 S10000
G1 X110.754 Y126.368 F30000
; LINE_WIDTH: 0.0936576
G1 F3600
M204 S1000
G1 X110.598 Y126.565 E.00074
; LINE_WIDTH: 0.142407
G1 X110.442 Y126.762 E.00124
; LINE_WIDTH: 0.191156
G1 X110.286 Y126.959 E.00174
M204 S10000
G1 X111.666 Y124.892 F30000
; LINE_WIDTH: 0.0936601
G1 F3600
M204 S1000
G1 X111.51 Y125.089 E.00074
; LINE_WIDTH: 0.142414
G1 X111.354 Y125.286 E.00124
; LINE_WIDTH: 0.191168
G1 X111.198 Y125.483 E.00174
M204 S10000
G1 X112.579 Y123.416 F30000
; LINE_WIDTH: 0.09366
G1 F3600
M204 S1000
G1 X112.423 Y123.613 E.00074
; LINE_WIDTH: 0.142414
G1 X112.267 Y123.81 E.00124
; LINE_WIDTH: 0.191168
G1 X112.111 Y124.007 E.00174
M204 S10000
G1 X113.491 Y121.939 F30000
; LINE_WIDTH: 0.0936547
G1 F3600
M204 S1000
G1 X113.335 Y122.137 E.00074
; LINE_WIDTH: 0.1424
G1 X113.179 Y122.334 E.00124
; LINE_WIDTH: 0.191144
G1 X113.023 Y122.531 E.00174
M204 S10000
G1 X114.404 Y120.463 F30000
; LINE_WIDTH: 0.0936598
G1 F3600
M204 S1000
G1 X114.248 Y120.66 E.00074
; LINE_WIDTH: 0.142414
G1 X114.092 Y120.858 E.00124
; LINE_WIDTH: 0.191168
G1 X113.936 Y121.055 E.00174
M204 S10000
G1 X115.317 Y118.987 F30000
; LINE_WIDTH: 0.0936573
G1 F3600
M204 S1000
G1 X115.161 Y119.184 E.00074
; LINE_WIDTH: 0.142407
G1 X115.005 Y119.381 E.00124
; LINE_WIDTH: 0.191156
G1 X114.849 Y119.578 E.00174
M204 S10000
G1 X116.229 Y117.511 F30000
; LINE_WIDTH: 0.0936593
G1 F3600
M204 S1000
G1 X116.073 Y117.708 E.00074
; LINE_WIDTH: 0.142413
G1 X115.917 Y117.905 E.00124
; LINE_WIDTH: 0.191166
G1 X115.761 Y118.102 E.00174
G1 E-.8 F1800
M204 S10000
G1 X115.588 Y123.563 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.241936
G1 F3600
M204 S1000
G1 X115.434 Y123.758 E.00224
; LINE_WIDTH: 0.192607
G1 X115.28 Y123.954 E.00174
; LINE_WIDTH: 0.143278
G1 X115.125 Y124.149 E.00124
; LINE_WIDTH: 0.0939489
G1 X114.971 Y124.345 E.00074
G1 E-.8 F1800
M204 S10000
G1 X122.592 Y123.928 Z2 F30000
G1 X130.742 Y123.482 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0812574
G1 F3600
M204 S1000
G3 X130.709 Y123.345 I.089 J-.094 E.00036
G1 E-.8 F1800
M204 S10000
G1 X137.82 Y120.574 Z2 F30000
G1 X145.168 Y117.711 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.193788
G1 F3600
M204 S1000
G1 X144.917 Y118.035 E.00288
G1 E-.8 F1800
M204 S10000
G1 X147.509 Y125.214 Z2 F30000
G1 X150.843 Y134.449 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.146437
G1 F3600
M204 S1000
G1 X150.879 Y134.584 E.00071
G1 X150.851 Y134.612 E.0002
G1 X150.716 Y134.576 E.00071
G1 E-.8 F1800
M204 S10000
G1 X158.343 Y134.28 Z2 F30000
G1 X166.798 Y133.953 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0791599
G1 F3600
M204 S1000
G1 X166.726 Y134.005 E.00021
; LINE_WIDTH: 0.106661
G1 X166.628 Y134.071 E.00041
; LINE_WIDTH: 0.141241
G1 X166.529 Y134.137 E.00058
; LINE_WIDTH: 0.175821
G1 X166.431 Y134.203 E.00074
G1 E-.8 F1800
M204 S10000
G1 X163.838 Y127.025 Z2 F30000
G1 X162.589 Y123.569 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0876667
G1 F3600
M204 S1000
G3 X161.899 Y124.259 I-6.102 J-5.418 E.00263
M204 S10000
G1 X164.001 Y121.591 F30000
; LINE_WIDTH: 0.0881023
G1 F3600
M204 S1000
G1 X163.857 Y121.766 E.00062
; LINE_WIDTH: 0.125715
G1 X163.713 Y121.941 E.00096
; LINE_WIDTH: 0.163327
G1 X163.569 Y122.116 E.00131
; LINE_WIDTH: 0.200939
G1 X163.425 Y122.291 E.00166
M204 S10000
G1 X165.166 Y119.863 F30000
; LINE_WIDTH: 0.0881019
G1 F3600
M204 S1000
G1 X165.022 Y120.038 E.00062
; LINE_WIDTH: 0.125714
G1 X164.878 Y120.213 E.00096
; LINE_WIDTH: 0.163327
G1 X164.734 Y120.388 E.00131
; LINE_WIDTH: 0.200939
G1 X164.59 Y120.562 E.00166
M204 S10000
G1 X166.331 Y118.134 F30000
; LINE_WIDTH: 0.0881023
G1 F3600
M204 S1000
G1 X166.187 Y118.309 E.00062
; LINE_WIDTH: 0.125715
G1 X166.043 Y118.484 E.00096
; LINE_WIDTH: 0.163327
G1 X165.899 Y118.659 E.00131
; LINE_WIDTH: 0.200939
G1 X165.755 Y118.834 E.00166
G1 E-.8 F1800
M204 S10000
G1 X170.182 Y117.508 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.163652
G1 F3600
M204 S1000
G1 X170.055 Y117.667 E.00118
; LINE_WIDTH: 0.125906
G1 X169.928 Y117.826 E.00087
; LINE_WIDTH: 0.0881605
G1 X169.801 Y117.985 E.00055
M204 S10000
G1 X169.333 Y118.893 F30000
; LINE_WIDTH: 0.19182
G1 F3600
M204 S1000
G1 X169.171 Y119.096 E.0018
; LINE_WIDTH: 0.142807
G1 X169.009 Y119.299 E.00128
; LINE_WIDTH: 0.0937944
G1 X168.847 Y119.502 E.00077
M204 S10000
G1 X168.38 Y120.41 F30000
; LINE_WIDTH: 0.191819
G1 F3600
M204 S1000
G1 X168.218 Y120.613 E.0018
; LINE_WIDTH: 0.142806
G1 X168.056 Y120.816 E.00128
; LINE_WIDTH: 0.0937939
G1 X167.894 Y121.019 E.00077
M204 S10000
G1 X167.251 Y121.949 F30000
; LINE_WIDTH: 0.194983
G1 F3600
M204 S1000
G1 X167.264 Y122.102 E.00109
; LINE_WIDTH: 0.196589
G1 X167.021 Y122.379 E.00262
; LINE_WIDTH: 0.147785
G1 X166.779 Y122.656 E.00189
; LINE_WIDTH: 0.0988521
G1 X166.535 Y122.934 E.00117
; LINE_WIDTH: 0.0718368
G1 X166.46 Y123.014 E.00022
M204 S10000
G1 X165.918 Y123.557 F30000
; LINE_WIDTH: 0.0909024
G1 F3600
M204 S1000
G1 X165.538 Y123.904 E.00146
; LINE_WIDTH: 0.135783
G1 X165.319 Y124.091 E.00134
; LINE_WIDTH: 0.182051
G1 X165.1 Y124.277 E.00188
; LINE_WIDTH: 0.228319
G1 X164.881 Y124.463 E.00242
; LINE_WIDTH: 0.274587
G1 X164.662 Y124.65 E.00297
; LINE_WIDTH: 0.320856
G1 X164.443 Y124.836 E.00351
; LINE_WIDTH: 0.367124
G1 X164.224 Y125.023 E.00405
; LINE_WIDTH: 0.394803
G1 X164.197 Y125.047 E.00054
; LINE_WIDTH: 0.37487
G1 X164.231 Y125.094 E.00084
; LINE_WIDTH: 0.325866
G1 X164.265 Y125.141 E.00072
; LINE_WIDTH: 0.276863
G1 X164.299 Y125.189 E.0006
; LINE_WIDTH: 0.227859
G1 X164.333 Y125.236 E.00049
; LINE_WIDTH: 0.178856
G1 X164.366 Y125.283 E.00037
M204 S10000
G1 X166.218 Y125.762 F30000
; LINE_WIDTH: 0.0774345
G1 F3600
M204 S1000
G2 X166.086 Y125.676 I-2.032 J2.994 E.00036
G1 E-.8 F1800
M204 S10000
G1 X168.766 Y131.868 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.170731
G1 F3600
M204 S1000
G1 X168.677 Y131.998 E.00096
; LINE_WIDTH: 0.152973
G1 X168.613 Y132.087 E.00059
; LINE_WIDTH: 0.119496
G1 X168.549 Y132.176 E.00044
; LINE_WIDTH: 0.086018
G1 X168.486 Y132.265 E.00029
; CHANGE_LAYER
; Z_HEIGHT: 1.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F3600
G1 X168.549 Y132.176 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/25
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
M204 S10000
G17
G3 Z2 I-.681 J-1.009 P1  F30000
G1 X150.508 Y144.357 Z2
G1 X51.016 Y211.534
G1 Z1.7
G1 E.8 F1800
; LAYER_HEIGHT: 0.100000
; FEATURE: Prime tower
; LINE_WIDTH: 0.500000
; WIPE_TOWER_START
M204 S10000
G1  X51.516 Y212.534  
M204 S1000
G3  X49.132 Y214.521   I-4.714 J-3.233 E0.0625 F5400
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
G3  X22.632 Y186.418   I1.716 J-0.865 E0.0504
G1 E-0.8000 F1800
M204 S10000
G1  X24.400 Y184.650   F600
G1 E0.8000 F1800
M204 S1000
G3  X27.142 Y183.018   I2.973 J1.875 E0.0659 F5400
G3  X29.490 Y184.533   I-4.065 J8.876 E0.0558
G2  X31.578 Y185.034   I2.118 J-4.225 E0.0431
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

M620.1 E F399.119 T240
T1
M73 E0
M620.1 E F399.119 T240



M620.11 S0

G92 E0

M83
; FLUSH_START
; always use highest temperature to flush
M400

M109 S240


G1 E23.7 F399.119 ; do not need pulsatile flushing for start part
G1 E0.981131 F50
G1 E11.283 F399.119
G1 E0.981131 F50
G1 E11.283 F399.119
G1 E0.981131 F50
G1 E11.283 F399.119
G1 E0.981131 F50
G1 E11.283 F399.119

; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
; FLUSH_END
G1 E-2 F1800
G1 E2 F300




G91
G1 X3 F12000; move aside to extrude
G90
M83

; FLUSH_START
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
G1 E13.0962 F399.119
G1 E1.45513 F50
; FLUSH_END

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
M106 S255
M106 P2 S178
G1 X58.429 Y205.223 F30000
G1 Z1.7
G1 X58.429 Y197.591 Z2.1
G1 X58.429 Y178.121 Z2.1
G1 X17.103 Y178.121
G1 X17.103 Y185.534

; filament start gcode
M106 P3 S150


G1 X24.516 Y185.534
G1 Z1.7
G1 E2 F1800

G4 S0
; CP_TOOLCHANGE_WIPE CT0 FL0
M204 S1000
G1  X27.516 Y185.534  E0.0597 F1782
G1 E-0.8000 F1800
M204 S10000
G1  X23.016  F600
G1  X27.516  F240
G1 E0.8000 F1800
M204 S1000
G1  X51.016  E0.4675 F1782
G1  Y186.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072 F2025
; LAYER_HEIGHT: 0.100000
G1  Y187.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072 F2473
; LAYER_HEIGHT: 0.100000
G1  Y187.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072 F4725
; LAYER_HEIGHT: 0.100000
M73 P88 R7
G1  Y188.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072 F4775
; LAYER_HEIGHT: 0.100000
G1  Y189.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y190.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y190.784  E0.0149
; LAYER_HEIGHT: 0.200000
M73 P89 R6
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y191.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y192.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y193.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y193.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y194.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y195.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
M73 P90 R6
G1  Y196.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y196.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y197.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y198.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y199.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y199.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y200.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y201.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y202.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
M73 P90 R5
G1  Y202.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y203.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y204.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y205.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
M73 P91 R5
G1  Y205.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y206.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y207.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y208.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y208.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y209.534  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y210.284  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y211.034  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X51.016  E1.0072
; LAYER_HEIGHT: 0.100000
G1  Y211.784  E0.0149
; LAYER_HEIGHT: 0.200000
G1  X24.516  E1.0072
; LAYER_HEIGHT: 0.100000
; WIPE_TOWER_END
M220 R
G1 F30000
G4 S0
G92 E0
; CP TOOLCHANGE END
;------------------



; WIPE_START
G1 F3600
M204 S1000
G1 X26.516 Y211.784 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.1 I1.217 J0 P1  F30000
; OBJECT_ID: 7
M204 S10000
G1 X149.65 Y134.357
G1 X150.625 Y133.744
G1 X155.385 Y130.751
G1 X155.385 Y134.357
G1 X168.551 Y131.593
G1 X164.165 Y125.5
G1 X164.118 Y125.259
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F3600
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.1 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.1 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.1 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.1 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
M73 P92 R5
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.1 F30000
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.1 F30000
G1 X149.689 Y134.357
G1 X149.726 Y133.458
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X149.175 Y133.458 E.01236
G1 X149.175 Y118.542 E.33479
G1 X149.726 Y118.542 E.01236
G1 X149.726 Y118.817 E.00618
G1 X149.726 Y133.398 E.32726
M204 S10000
G1 X150.215 Y133.948 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X148.685 Y133.948 E.02672
G1 X148.685 Y118.052 E.27754
G1 X150.215 Y118.052 E.02672
G1 X150.215 Y118.817 E.01336
G1 X150.215 Y133.888 E.26313
M204 S10000
G1 X150.644 Y134.376 F30000
G1 F6000
M204 S1000
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
M204 S500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
; WIPE_START
M204 S1000
G1 X149.058 Y134.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.058 Y134.357 Z2.1 F30000
G1 X150.625 Y133.595
G1 X155.385 Y130.033
G1 X157.734 Y126.745
G1 X163.885 Y123.673
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54611
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.609 Y125.921 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
G1 X161.79 Y126.75 Z2.1 F30000
G1 X161.696 Y126.748
G1 X161.067 Y126.745
G1 X157.734 Y126.745
G1 X156.835 Y129.365
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
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
M73 P92 R4
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
G1 X157.734 Y126.745 Z2.1 F30000
G1 X161.067 Y126.745
G1 X161.696 Y126.748
G1 X162.267 Y126.759
G1 X162.779 Y126.776
G1 X163.234 Y126.801
G1 X163.632 Y126.834
G1 X163.978 Y126.876
G1 X164.277 Y126.928
G1 X164.541 Y126.999
G1 X164.937 Y127.167
G1 X165.184 Y127.322
G1 X165.612 Y126.637
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.39723
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.924 Y125.642 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X164.648 Y125.146 E-.06283
G1 X165.205 Y125.244 E-.21483
G1 X165.723 Y125.369 E-.20234
G1 X166.202 Y125.52 E-.19106
G1 X166.419 Y125.609 E-.08894
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.253 Y126.006 Z2.1 F30000
G1 X157.734 Y126.745
G1 X157.734 Y132.598
G1 X158.152 Y132.598
G1 X158.152 Y132.949
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X158.198 Y132.073 E-.0932
G1 X158.167 Y131.966 E-.04268
G1 X158.167 Y130.323 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.734 Y130.323 Z2.1 F30000
G1 X157.734 Y132.598
G1 X164.886 Y133.267
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S1000
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
G1 X164.48 Y132.408 Z2.1 F30000
G1 X164.946 Y132.216
G1 X165.364 Y131.95
G1 X165.723 Y131.61
G1 X166.009 Y131.204
G1 X166.21 Y130.746
G1 X166.326 Y130.249
G1 X166.363 Y129.724
G1 X166.335 Y129.251
G1 X166.249 Y128.806
G1 X166.099 Y128.389
G1 X165.885 Y128.008
G1 X165.615 Y127.674
G1 X165.298 Y127.393
G1 X164.937 Y127.167
G1 X164.541 Y126.999
G1 X160.871 Y125.884
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.50098
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.693 Y123.867 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.45052
G1 F6000
M204 S1000
G1 X163.399 Y124.233 E.00821
G1 E-.8 F1800
M204 S10000
G1 X162.849 Y125.419 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5442
G1 F6000
M204 S1000
G2 X162.851 Y125.527 I-.028 J.055 E.00542
G1 E-.8 F1800
M204 S10000
G1 X156.639 Y126.627 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S1000
G1 X156.966 Y126.118 E.00995
G3 X157.163 Y125.951 I.576 J.483 E.00427
G1 X156.968 Y125.788 E.00418
G1 X156.639 Y125.299 E.0097
G1 X156.639 Y126.567 E.02085
M204 S10000
G1 X156.753 Y132.969 F30000
; LINE_WIDTH: 0.57486
G1 F6000
M204 S1000
G2 X156.757 Y133.08 I-.03 J.057 E.00614
; WIPE_START
G1 X156.683 Y133.088 E-.20014
G1 X156.649 Y133.028 E-.18662
G1 X156.683 Y132.969 E-.18663
G1 X156.753 Y132.969 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.385 Y129.793 Z2.1 F30000
G1 X150.625 Y118.74
G1 X150.152 Y117.643
G1 X146.643 Y108.125
G1 X146.21 Y108.49
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.1 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.1 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.1 F30000
G1 X132.531 Y121.417
G1 X131.727 Y121.709
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.51468
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X132.95 Y121.243 E-.05716
G1 X133.088 Y121.299 E-.05637
G1 X134.789 Y121.299 E-.64646
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.789 Y121.732 Z2.1 F30000
G1 X133.295 Y123.479
G1 X135.93 Y130.719
G1 X136.193 Y131.442
G1 X136.166 Y131.725
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X136.457 Y130.9 E-.05928
G1 X135.826 Y129.167 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.42 Y129.317 Z2.1 F30000
G1 X136.193 Y131.442
G1 X137.09 Y131.445
G1 X140.049 Y123.479
G1 X139.14 Y122.605
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S1000
G1 X134.197 Y122.605 E.1007
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00559
G1 E-.8 F1800
M204 S10000
G1 X132.393 Y123.666 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S1000
G1 X132.558 Y123.173 E.0087
G1 X132.709 Y122.949 E.00451
G1 X132.404 Y122.855 E.00533
G1 X131.958 Y122.558 E.00895
G1 X132.371 Y123.61 E.0189
G1 E-.8 F1800
M204 S10000
G1 X139.982 Y123.033 Z2.1 F30000
G1 X140.691 Y122.979 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S1000
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
G1 X137.623 Y130.403 Z2.1 F30000
G1 X137.09 Y131.445 Z2.1
G1 X135.83 Y132.489
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S1000
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
G1 X133.266 Y129.38 Z2.1 F30000
G1 X119.045 Y118.4
G1 X118.064 Y117.643
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y108.161 Z2.1 F30000
G1 X106.643 Y108.068
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.1 F30000
G1 X94.341 Y117.35
G1 X101.856 Y124.962
G1 X96.371 Y134.34
G1 X96.339 Y134.348
G1 X96.146 Y133.568
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.35598
G1 F6000
M204 S1000
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
G1 X94.283 Y134.653 Z2.1 F30000
G1 X97.5 Y131.512
G1 X97.904 Y131.104
G1 X98.269 Y130.639
G1 X98.583 Y130.121
G1 X98.845 Y129.556
G1 X99.056 Y128.945
G1 X99.217 Y128.29
G1 X99.331 Y127.591
G1 X99.398 Y126.849
G1 X99.421 Y126.061
G1 X99.398 Y125.264
G1 X99.329 Y124.512
G1 X98.973 Y120.93
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S1000
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
M204 S1000
G1 X98.886 Y121.702 E.01009
G3 X99.42 Y122.969 I-5.392 J3.018 E.02406
G3 X99.808 Y126.84 I-11.617 J3.118 E.06823
G3 X99.242 Y129.659 I-9.592 J-.461 E.05038
G3 X95.933 Y132.905 I-5.2 J-1.992 E.08346
G3 X92.603 Y133.146 I-2.156 J-6.651 E.05886
G3 X88.742 Y130.416 I.966 J-5.461 E.08529
G3 X87.805 Y126.983 I7.256 J-3.825 E.06265
M73 P93 R4
G3 X88.18 Y122.977 I11.438 J-.949 E.07061
G3 X88.664 Y121.806 I6.495 J2.001 E.02215
G3 X93.769 Y118.749 I5.078 J2.688 E.1092
G3 X97.694 Y120.187 I.123 J5.738 E.07471
G3 X98.529 Y121.138 I-4.2 J4.533 E.02214
G1 X98.549 Y121.162 E.00053
M204 S10000
G1 X98.226 Y121.435 F30000
G1 F6000
M204 S1000
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
M204 S500
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
M204 S1000
G1 X98.173 Y122.137 E-.23878
G1 X98.424 Y122.671 E-.22423
G1 X98.625 Y123.246 E-.23154
G1 X98.667 Y123.413 E-.06546
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.088 Y123.308 Z2.1 F30000
G1 X99.212 Y123.803
G1 X99.329 Y124.512
G1 X99.398 Y125.264
G1 X99.421 Y126.061
G1 X99.398 Y126.849
G1 X99.331 Y127.591
G1 X99.217 Y128.29
G1 X99.056 Y128.945
G1 X98.845 Y129.556
G1 X98.583 Y130.121
G1 X98.269 Y130.639
G1 X97.904 Y131.104
G1 X97.5 Y131.512
G1 X97.064 Y131.866
G1 X96.677 Y132.114
G1 X96.386 Y134.335
G1 X96.263 Y133.926
G1 Z1.7
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X95.634 Y134.946 E-.35398
G1 X94.733 Y135.059 E-.34495
G1 X94.573 Y135.065 E-.06108
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.547 Y134.637 Z2.1 F30000
G1 X86.023 Y128.835
G1 X85.731 Y125.306
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z1.7
G1 E.8 F1800
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.1 F30000
G1 X77.085 Y121.357
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.1 F30000
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.1 F30000
G1 X95.357 Y143.922
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.1 F30000
G1 X115.66 Y122.811
G1 X115.946 Y122.345
G1 X116.009 Y121.65
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X116.065 Y122.979 E-.08506
G1 X115.137 Y124.493 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.768 Y124.267 Z2.1 F30000
G1 X115.946 Y122.345
G1 X117.793 Y121.992
G1 Z1.7
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S1000
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
M204 S1000
G1 X117.395 Y119.293 E.02972
G1 X117.304 Y119.316 E.00153
G1 X116.36 Y120.836 E.02905
G1 X116.918 Y120.906 E.00912
G1 X117.34 Y121.098 E.00754
M204 S10000
G1 X117.031 Y120.488 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S1000
G1 X116.96 Y120.529 E.00125
G1 X117.02 Y120.563 E.00105
G1 E-.8 F1800
M204 S10000
G1 X112.397 Y126.637 Z2.1 F30000
G1 X109.577 Y130.342 Z2.1
G1 Z1.7
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
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
M204 S1000
G1 X108.242 Y130.824 E.00871
G1 X107.704 Y130.597 E.00948
G1 X107.701 Y132.64 E.03317
G1 X108.744 Y130.94 E.03238
M204 S10000
G1 X108.131 Y131.165 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S1000
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
; layer num/total_layer_count: 18/25
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.1 I.911 J.807 P1  F30000
G1 X115.946 Y122.345 Z2.1
G1 X116.954 Y122.63
G1 X119.045 Y128.846
G1 X131.987 Y126.096
G1 X138.173 Y134.357
G1 X142.364 Y123.891
G1 X148.276 Y122.635
G1 X150.625 Y122.136
G1 X155.385 Y121.124
G1 X157.734 Y125.157
G1 X159.116 Y125.157
G1 X159.43 Y125.154
G1 X159.727 Y125.144
G1 X160.007 Y125.127
G1 X160.268 Y125.103
G1 X160.513 Y125.071
G1 X160.741 Y125.03
G1 X160.955 Y124.98
G1 X161.165 Y124.916
G1 X161.521 Y124.762
G1 X161.868 Y124.555
G1 X162.195 Y124.302
G1 X170.292 Y117.357
G1 X169.561 Y118.111
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.2 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.2 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.2 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.2 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.2 F30000
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.2 F30000
G1 X149.689 Y134.357
G1 X149.726 Y133.458
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X149.175 Y133.458 E.01236
G1 X149.175 Y118.542 E.33479
G1 X149.726 Y118.542 E.01236
G1 X149.726 Y118.817 E.00618
G1 X149.726 Y133.398 E.32726
M204 S10000
G1 X150.215 Y133.948 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X148.685 Y133.948 E.02672
G1 X148.685 Y118.052 E.27754
G1 X150.215 Y118.052 E.02672
G1 X150.215 Y118.817 E.01336
G1 X150.215 Y133.888 E.26313
M204 S10000
G1 X150.644 Y134.376 F30000
G1 F6000
M204 S1000
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
M204 S500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
; WIPE_START
M204 S1000
G1 X149.058 Y134.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.058 Y134.357 Z2.2 F30000
G1 X150.625 Y133.595
G1 X155.385 Y130.033
G1 X157.734 Y126.745
G1 X163.885 Y123.673
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54612
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.609 Y125.921 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
G1 X161.79 Y126.75 Z2.2 F30000
G1 X161.697 Y126.748
G1 X161.067 Y126.745
G1 X157.734 Y126.745
G1 X156.835 Y129.364
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
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
G1 X157.734 Y126.745 Z2.2 F30000
G1 X161.067 Y126.745
G1 X161.697 Y126.748
G1 X162.267 Y126.759
G1 X162.779 Y126.776
G1 X163.234 Y126.801
G1 X163.632 Y126.834
G1 X163.977 Y126.876
G1 X164.277 Y126.928
G1 X164.541 Y126.999
G1 X164.937 Y127.167
G1 X165.199 Y127.331
G1 X165.629 Y126.643
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.39724
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.924 Y125.642 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X164.648 Y125.146 E-.06284
G1 X165.205 Y125.244 E-.21482
G1 X165.723 Y125.369 E-.20234
G1 X166.202 Y125.521 E-.19109
G1 X166.419 Y125.609 E-.08891
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.253 Y126.006 Z2.2 F30000
G1 X157.734 Y126.745
G1 X157.734 Y132.598
G1 X158.152 Y132.598
G1 X158.152 Y132.949
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X158.198 Y132.073 E-.0932
G1 X158.167 Y131.966 E-.04268
G1 X158.167 Y130.323 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.734 Y130.323 Z2.2 F30000
G1 X157.734 Y132.598
G1 X164.886 Y133.267
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S1000
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
M73 P93 R3
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
G1 X164.48 Y132.408 Z2.2 F30000
G1 X164.946 Y132.216
G1 X165.364 Y131.95
G1 X165.723 Y131.61
G1 X166.009 Y131.204
G1 X166.21 Y130.746
G1 X166.326 Y130.249
G1 X166.363 Y129.724
G1 X166.335 Y129.251
G1 X166.249 Y128.806
G1 X166.099 Y128.389
G1 X165.885 Y128.008
G1 X165.615 Y127.674
G1 X165.298 Y127.393
G1 X164.937 Y127.167
G1 X164.541 Y126.999
G1 X160.871 Y125.884
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.50096
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.693 Y123.867 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.45056
G1 F6000
M204 S1000
G1 X163.399 Y124.233 E.0082
G1 E-.8 F1800
M204 S10000
G1 X162.849 Y125.419 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.54422
G1 F6000
M204 S1000
G2 X162.851 Y125.527 I-.028 J.055 E.00542
G1 E-.8 F1800
M204 S10000
G1 X156.639 Y126.627 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S1000
G1 X156.966 Y126.118 E.00995
G3 X157.163 Y125.951 I.576 J.483 E.00427
G1 X156.968 Y125.788 E.00418
G1 X156.639 Y125.299 E.0097
G1 X156.639 Y126.567 E.02085
M204 S10000
G1 X156.753 Y132.969 F30000
; LINE_WIDTH: 0.57486
G1 F6000
M204 S1000
G2 X156.757 Y133.08 I-.03 J.057 E.00614
; WIPE_START
G1 X156.683 Y133.088 E-.20014
G1 X156.649 Y133.028 E-.18662
G1 X156.683 Y132.969 E-.18663
G1 X156.753 Y132.969 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.385 Y129.793 Z2.2 F30000
G1 X150.625 Y118.74
G1 X150.152 Y117.643
G1 X146.643 Y108.125
G1 X146.21 Y108.49
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.2 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.2 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.2 F30000
G1 X132.531 Y121.417
G1 X131.727 Y121.709
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.51468
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X132.95 Y121.243 E-.05716
G1 X133.088 Y121.299 E-.05637
G1 X134.789 Y121.299 E-.64646
; WIPE_END
M73 P94 R3
G1 E-.04 F1800
M204 S10000
G1 X134.789 Y121.732 Z2.2 F30000
G1 X133.295 Y123.479
G1 X135.93 Y130.719
G1 X136.193 Y131.442
G1 X136.166 Y131.725
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X136.457 Y130.9 E-.05928
G1 X135.826 Y129.167 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.42 Y129.317 Z2.2 F30000
G1 X136.193 Y131.442
G1 X137.09 Y131.445
G1 X140.049 Y123.479
G1 X139.14 Y122.605
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S1000
G1 X134.197 Y122.605 E.1007
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00559
G1 E-.8 F1800
M204 S10000
G1 X132.393 Y123.666 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S1000
G1 X132.558 Y123.173 E.0087
G1 X132.709 Y122.949 E.00451
G1 X132.404 Y122.855 E.00533
G1 X131.958 Y122.558 E.00895
G1 X132.371 Y123.61 E.0189
G1 E-.8 F1800
M204 S10000
G1 X139.982 Y123.033 Z2.2 F30000
G1 X140.691 Y122.979 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S1000
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
G1 X137.623 Y130.403 Z2.2 F30000
G1 X137.09 Y131.445 Z2.2
G1 X135.83 Y132.489
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S1000
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
G1 X133.266 Y129.38 Z2.2 F30000
G1 X119.045 Y118.4
G1 X118.064 Y117.643
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y108.161 Z2.2 F30000
G1 X106.643 Y108.068
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.2 F30000
G1 X94.34 Y117.348
G1 X101.856 Y124.962
G1 X96.371 Y134.34
G1 X96.339 Y134.348
G1 X96.146 Y133.568
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.35597
G1 F6000
M204 S1000
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
G1 X94.283 Y134.653 Z2.2 F30000
G1 X97.5 Y131.512
G1 X97.904 Y131.104
G1 X98.268 Y130.639
G1 X98.583 Y130.121
G1 X98.845 Y129.556
G1 X99.056 Y128.945
G1 X99.217 Y128.29
G1 X99.331 Y127.591
G1 X99.398 Y126.849
G1 X99.421 Y126.061
G1 X99.398 Y125.264
G1 X99.329 Y124.512
G1 X98.972 Y120.93
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X98.173 Y122.137 E-.23879
G1 X98.424 Y122.671 E-.22423
G1 X98.625 Y123.246 E-.23154
G1 X98.667 Y123.413 E-.06545
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.088 Y123.308 Z2.2 F30000
G1 X99.212 Y123.803
G1 X99.329 Y124.512
G1 X99.398 Y125.264
G1 X99.421 Y126.061
G1 X99.398 Y126.849
G1 X99.331 Y127.591
G1 X99.217 Y128.29
G1 X99.056 Y128.945
G1 X98.845 Y129.556
G1 X98.583 Y130.121
G1 X98.268 Y130.639
G1 X97.904 Y131.104
G1 X97.5 Y131.512
G1 X97.064 Y131.866
G1 X96.677 Y132.114
G1 X96.386 Y134.335
G1 X96.263 Y133.926
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X95.634 Y134.946 E-.35398
G1 X94.733 Y135.059 E-.34495
G1 X94.573 Y135.065 E-.06108
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.547 Y134.637 Z2.2 F30000
G1 X86.023 Y128.835
G1 X85.731 Y125.306
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z1.8
G1 E.8 F1800
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.2 F30000
G1 X77.085 Y121.357
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.2 F30000
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.2 F30000
G1 X95.357 Y143.922
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.2 F30000
G1 X115.66 Y122.811
G1 X115.946 Y122.345
G1 X116.009 Y121.65
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X116.065 Y122.979 E-.08506
G1 X115.137 Y124.493 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.768 Y124.267 Z2.2 F30000
G1 X115.946 Y122.345
G1 X117.793 Y121.992
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S1000
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
M204 S1000
G1 X117.395 Y119.293 E.02972
G1 X117.304 Y119.316 E.00153
G1 X116.36 Y120.836 E.02905
G1 X116.918 Y120.906 E.00912
G1 X117.34 Y121.098 E.00754
M204 S10000
G1 X117.031 Y120.488 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S1000
G1 X116.96 Y120.529 E.00125
G1 X117.02 Y120.563 E.00105
G1 E-.8 F1800
M204 S10000
G1 X112.397 Y126.637 Z2.2 F30000
G1 X109.577 Y130.342 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
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
M204 S1000
G1 X108.242 Y130.824 E.00871
G1 X107.704 Y130.597 E.00948
G1 X107.701 Y132.64 E.03317
G1 X108.744 Y130.94 E.03238
M204 S10000
G1 X108.131 Y131.165 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S1000
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
; layer num/total_layer_count: 19/25
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.2 I.911 J.807 P1  F30000
G1 X115.946 Y122.345 Z2.2
G1 X116.954 Y122.63
G1 X119.045 Y128.846
G1 X131.987 Y126.096
G1 X138.173 Y134.357
G1 X142.364 Y123.891
G1 X148.276 Y122.635
G1 X150.625 Y122.136
G1 X155.385 Y121.124
G1 X157.734 Y125.157
G1 X159.116 Y125.157
G1 X159.43 Y125.154
G1 X159.727 Y125.144
G1 X160.007 Y125.127
G1 X160.268 Y125.103
G1 X160.513 Y125.071
G1 X160.741 Y125.03
G1 X160.955 Y124.98
G1 X161.165 Y124.916
G1 X161.521 Y124.762
G1 X161.868 Y124.555
G1 X162.195 Y124.302
G1 X170.292 Y117.357
G1 X169.561 Y118.111
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F3600
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.3 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.3 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.3 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.3 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.3 F30000
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.3 F30000
G1 X149.689 Y134.357
G1 X149.726 Y133.458
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
G1 X149.175 Y133.458 E.01236
G1 X149.175 Y118.542 E.33479
G1 X149.726 Y118.542 E.01236
G1 X149.726 Y118.817 E.00618
G1 X149.726 Y133.398 E.32726
M204 S10000
G1 X150.215 Y133.948 F30000
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
G1 X148.685 Y133.948 E.02672
G1 X148.685 Y118.052 E.27754
G1 X150.215 Y118.052 E.02672
G1 X150.215 Y118.817 E.01336
G1 X150.215 Y133.888 E.26313
M204 S10000
G1 X150.644 Y134.376 F30000
G1 F6000
M204 S1000
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
M204 S500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
; WIPE_START
M204 S1000
G1 X149.058 Y134.767 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.058 Y134.357 Z2.3 F30000
G1 X150.625 Y133.595
G1 X155.385 Y130.033
G1 X157.734 Y126.745
G1 X163.885 Y123.673
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.54611
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X162.973 Y124.71 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
G1 X164.132 Y125.329 Z2.3 F30000
G1 X157.734 Y125.157
G1 X156.835 Y124.394
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57233
G1 F6000
M204 S1000
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
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.648 Y124.849 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M73 P95 R3
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
M204 S1000
G1 X164.544 Y125.093 E-.08347
G1 X164.648 Y125.146 E-.04422
G1 X165.205 Y125.244 E-.21482
G1 X165.723 Y125.369 E-.20234
G1 X166.202 Y125.521 E-.19109
G1 X166.261 Y125.544 E-.02405
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X166.101 Y125.943 Z2.3 F30000
G1 X157.734 Y126.745
G1 X157.734 Y132.598
G1 X158.152 Y132.598
G1 X158.152 Y132.949
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X158.198 Y132.073 E-.0932
G1 X158.167 Y131.966 E-.04268
G1 X158.167 Y130.323 E-.62412
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X157.734 Y130.323 Z2.3 F30000
G1 X157.734 Y132.598
G1 X164.886 Y133.267
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.67164
G1 F6000
M204 S1000
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
G1 X164.48 Y132.408 Z2.3 F30000
G1 X164.946 Y132.216
G1 X165.364 Y131.95
G1 X165.723 Y131.61
G1 X166.009 Y131.204
G1 X166.21 Y130.746
G1 X166.326 Y130.249
G1 X166.363 Y129.724
G1 X166.335 Y129.251
G1 X166.249 Y128.806
G1 X166.099 Y128.389
G1 X165.885 Y128.008
G1 X165.615 Y127.674
G1 X165.298 Y127.393
G1 X164.937 Y127.167
G1 X164.541 Y126.999
G1 X160.871 Y125.884
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.50096
G1 F6000
M204 S1000
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
G1 E-.8 F1800
M204 S10000
G1 X163.693 Y123.867 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.45054
G1 F6000
M204 S1000
G1 X163.399 Y124.233 E.0082
G1 E-.8 F1800
M204 S10000
G1 X162.849 Y125.419 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5442
G1 F6000
M204 S1000
G2 X162.851 Y125.527 I-.028 J.055 E.00542
G1 E-.8 F1800
M204 S10000
G1 X156.639 Y126.627 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.42516
G1 F6000
M204 S1000
G1 X156.966 Y126.118 E.00995
G3 X157.163 Y125.951 I.576 J.483 E.00427
G1 X156.968 Y125.788 E.00418
G1 X156.639 Y125.299 E.0097
G1 X156.639 Y126.567 E.02085
M204 S10000
G1 X156.753 Y132.969 F30000
; LINE_WIDTH: 0.57486
G1 F6000
M204 S1000
G2 X156.757 Y133.08 I-.03 J.057 E.00614
; WIPE_START
G1 X156.683 Y133.088 E-.20014
G1 X156.649 Y133.028 E-.18662
G1 X156.683 Y132.969 E-.18663
G1 X156.753 Y132.969 E-.18661
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X155.385 Y129.793 Z2.3 F30000
G1 X150.625 Y118.74
G1 X150.152 Y117.643
G1 X146.643 Y108.125
G1 X146.21 Y108.49
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.3 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.3 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.3 F30000
G1 X142.927 Y117.643
G1 X140.732 Y121.732
G1 X132.645 Y121.732
G1 X132.224 Y122.256
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X133.088 Y121.299 E-.07642
G1 X134.887 Y121.299 E-.68358
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.887 Y121.732 Z2.3 F30000
G1 X133.295 Y123.479
G1 X135.93 Y130.719
G1 X136.193 Y131.442
G1 X136.166 Y131.725
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X136.457 Y130.9 E-.05928
G1 X135.826 Y129.167 E-.70072
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.42 Y129.317 Z2.3 F30000
G1 X136.193 Y131.442
G1 X137.09 Y131.445
G1 X140.049 Y123.479
G1 X139.14 Y122.605
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.52158
G1 F6000
M204 S1000
G1 X134.197 Y122.605 E.1007
; LINE_WIDTH: 0.5444
G1 X133.935 Y122.616 E.00559
G1 E-.8 F1800
M204 S10000
G1 X132.393 Y123.666 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43172
G1 F6000
M204 S1000
G1 X132.558 Y123.173 E.0087
G1 X132.709 Y122.949 E.00451
G1 X132.404 Y122.855 E.00533
G1 X131.958 Y122.558 E.00895
G1 X132.371 Y123.61 E.0189
G1 E-.8 F1800
M204 S10000
G1 X139.982 Y123.033 Z2.3 F30000
G1 X140.691 Y122.979 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.48526
G1 F6000
M204 S1000
M73 P95 R2
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
G1 X137.623 Y130.403 Z2.3 F30000
G1 X137.09 Y131.445 Z2.3
G1 X135.83 Y132.489
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.43808
G1 F6000
M204 S1000
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
G1 X133.266 Y129.38 Z2.3 F30000
G1 X119.045 Y118.4
G1 X118.064 Y117.643
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y108.161 Z2.3 F30000
G1 X106.643 Y108.068
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.3 F30000
G1 X94.341 Y117.348
G1 X101.856 Y124.962
G1 X96.371 Y134.34
G1 X96.339 Y134.347
G1 X96.146 Y133.568
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.35597
G1 F6000
M204 S1000
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
G1 X94.283 Y134.653 Z2.3 F30000
G1 X97.5 Y131.512
G1 X97.904 Y131.104
G1 X98.269 Y130.639
G1 X98.583 Y130.121
G1 X98.845 Y129.556
G1 X99.056 Y128.945
G1 X99.217 Y128.29
G1 X99.331 Y127.591
G1 X99.398 Y126.849
G1 X99.421 Y126.061
G1 X99.398 Y125.264
G1 X99.329 Y124.512
G1 X98.972 Y120.93
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.57196
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X98.173 Y122.137 E-.23879
G1 X98.424 Y122.671 E-.22423
G1 X98.625 Y123.246 E-.23154
G1 X98.667 Y123.413 E-.06545
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.088 Y123.308 Z2.3 F30000
G1 X99.212 Y123.803
G1 X99.329 Y124.512
G1 X99.398 Y125.264
G1 X99.421 Y126.061
G1 X99.398 Y126.849
G1 X99.331 Y127.591
G1 X99.217 Y128.29
G1 X99.056 Y128.945
G1 X98.845 Y129.556
G1 X98.583 Y130.121
G1 X98.269 Y130.639
G1 X97.904 Y131.104
G1 X97.5 Y131.512
G1 X97.064 Y131.866
G1 X96.678 Y132.113
G1 X96.386 Y134.335
G1 X96.263 Y133.926
G1 Z1.9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S500
G3 X91.283 Y134.824 I-2.743 J-11.011 E.08522
G1 X90.402 Y134.564 E.01493
G1 X89.379 Y134.11 E.01816
G3 X85.488 Y128.382 I4.112 J-6.98 E.11618
G3 X85.513 Y123.425 I14.135 J-2.407 E.0809
G3 X86.813 Y120.246 I8.552 J1.641 E.05614
G3 X90.696 Y117.362 I6.182 J4.269 E.07997
G3 X93.34 Y116.913 I3.145 J10.506 E.04366
G1 X94.781 Y116.941 E.0234
G3 X98.066 Y117.841 I-.66 J8.855 E.05566
G3 X101.744 Y122.16 I-3.639 J6.824 E.0943
G3 X102.316 Y125.475 I-11.241 J3.648 E.05481
G3 X101.995 Y128.951 I-13.534 J.502 E.05685
G3 X101.012 Y131.376 I-9.292 J-2.357 E.04261
G3 X96.543 Y134.741 I-6.56 J-4.061 E.09296
; WIPE_START
M204 S1000
G1 X95.634 Y134.946 E-.35405
G1 X94.733 Y135.059 E-.34495
G1 X94.573 Y135.065 E-.061
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.547 Y134.637 Z2.3 F30000
G1 X86.023 Y128.835
G1 X85.731 Y125.306
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z1.9
G1 E.8 F1800
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.3 F30000
G1 X77.085 Y121.357
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.3 F30000
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.3 F30000
G1 X95.357 Y143.922
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.3 F30000
G1 X115.66 Y122.811
G1 X115.946 Y122.345
G1 X116.009 Y121.65
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.44999
G1 F6000
M204 S1000
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
M204 S1000
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
M204 S1000
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
M204 S500
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
M204 S1000
G1 X116.065 Y122.979 E-.08506
G1 X115.137 Y124.493 E-.67494
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.768 Y124.267 Z2.3 F30000
G1 X115.946 Y122.345
G1 X117.793 Y121.992
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
G1 F6000
M204 S1000
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
M204 S1000
G1 X117.395 Y119.293 E.02972
G1 X117.304 Y119.316 E.00153
G1 X116.36 Y120.836 E.02905
G1 X116.918 Y120.906 E.00912
G1 X117.34 Y121.098 E.00754
M204 S10000
G1 X117.031 Y120.488 F30000
; LINE_WIDTH: 0.39822
G1 F6000
M204 S1000
G1 X116.96 Y120.529 E.00125
G1 X117.02 Y120.563 E.00105
G1 E-.8 F1800
M204 S10000
G1 X112.397 Y126.637 Z2.3 F30000
G1 X109.577 Y130.342 Z2.3
G1 Z1.9
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6000
M204 S1000
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
M204 S1000
G1 X108.242 Y130.824 E.00871
G1 X107.704 Y130.597 E.00948
G1 X107.701 Y132.64 E.03317
G1 X108.744 Y130.94 E.03238
M204 S10000
G1 X108.131 Y131.165 F30000
; LINE_WIDTH: 0.4281
G1 F6000
M204 S1000
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
; layer num/total_layer_count: 20/25
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.3 I.251 J1.191 P1  F30000
G1 X169.424 Y118.263 Z2.3
G1 X169.542 Y118.124
G1 X169.561 Y118.111
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.4 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.4 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.4 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F6000
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.4 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.4 F30000
M73 P96 R2
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.4 F30000
G1 X151.057 Y134.79
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X147.843 Y134.79 E.05219
G1 X147.843 Y117.21 E.28546
G1 X151.057 Y117.21 E.05219
G1 X151.057 Y118.817 E.0261
G1 X151.057 Y134.73 E.25839
M204 S10000
G1 X150.146 Y134.571 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X150.838 Y133.878 E.0159
G1 X150.838 Y133.315
G1 X149.582 Y134.571 E.02885
G1 X149.018 Y134.571
G1 X150.838 Y132.751 E.04179
G1 X150.838 Y132.187
G1 X148.455 Y134.571 E.05473
G1 X148.062 Y134.4
G1 X150.838 Y131.624 E.06375
G1 X150.838 Y131.06
G1 X148.062 Y133.836 E.06375
G1 X148.062 Y133.273
G1 X150.838 Y130.497 E.06375
G1 X150.838 Y129.933
G1 X148.062 Y132.709 E.06375
G1 X148.062 Y132.145
G1 X150.838 Y129.369 E.06375
G1 X150.838 Y128.806
G1 X148.062 Y131.582 E.06375
G1 X148.062 Y131.018
G1 X150.838 Y128.242 E.06375
G1 X150.838 Y127.679
G1 X148.062 Y130.455 E.06375
G1 X148.062 Y129.891
G1 X150.838 Y127.115 E.06375
G1 X150.838 Y126.551
G1 X148.062 Y129.327 E.06375
G1 X148.062 Y128.764
G1 X150.838 Y125.988 E.06375
G1 X150.838 Y125.424
G1 X148.062 Y128.2 E.06375
G1 X148.062 Y127.637
G1 X150.838 Y124.861 E.06375
G1 X150.838 Y124.297
G1 X148.062 Y127.073 E.06375
G1 X148.062 Y126.509
G1 X150.838 Y123.733 E.06375
G1 X150.838 Y123.17
G1 X148.062 Y125.946 E.06375
G1 X148.062 Y125.382
G1 X150.838 Y122.606 E.06375
G1 X150.838 Y122.043
G1 X148.062 Y124.819 E.06375
G1 X148.062 Y124.255
G1 X150.838 Y121.479 E.06375
G1 X150.838 Y120.915
G1 X148.062 Y123.691 E.06375
G1 X148.062 Y123.128
G1 X150.838 Y120.352 E.06375
G1 X150.838 Y119.788
G1 X148.062 Y122.564 E.06375
G1 X148.062 Y122.001
G1 X150.838 Y119.224 E.06375
G1 X150.838 Y118.661
G1 X148.062 Y121.437 E.06375
G1 X148.062 Y120.873
G1 X150.838 Y118.097 E.06375
G1 X150.838 Y117.534
G1 X148.062 Y120.31 E.06375
G1 X148.062 Y119.746
G1 X150.379 Y117.429 E.05321
G1 X149.816 Y117.429
G1 X148.062 Y119.182 E.04026
G1 X148.062 Y118.619
G1 X149.252 Y117.429 E.02732
G1 X148.688 Y117.429
G1 X148.062 Y118.055 E.01438
G1 E-.8 F1800
M204 S10000
G1 X155.082 Y121.053 Z2.4 F30000
G1 X164.544 Y125.093 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 E-.8 F1800
M204 S10000
G1 X159.534 Y130.812 Z2.4 F30000
G1 X158.366 Y132.165 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S500
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
G1 E-.8 F1800
M204 S10000
G1 X166.054 Y131.902 Z2.4 F30000
G1 X168.686 Y131.811 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X166.367 Y134.13 E.05326
G1 X165.605 Y134.329
G1 X168.92 Y131.014 E.07611
G1 X169.008 Y130.362
G1 X164.934 Y134.436 E.09354
G1 X164.313 Y134.494
G1 X169.021 Y129.786 E.1081
G1 X168.98 Y129.263
G1 X163.702 Y134.541 E.12122
G1 X163.125 Y134.554
G1 X168.896 Y128.784 E.13251
G1 X168.782 Y128.334
G1 X162.549 Y134.567 E.14314
G1 X161.981 Y134.571
G1 X164.328 Y132.224 E.05388
G1 X163.654 Y132.334
G1 X161.418 Y134.571 E.05136
G1 X160.854 Y134.571
G1 X163.061 Y132.364 E.05067
G1 X162.486 Y132.375
G1 X160.291 Y134.571 E.05042
G1 X159.727 Y134.571
G1 X161.917 Y132.381 E.0503
G1 X161.353 Y132.381
G1 X159.163 Y134.571 E.05028
G1 X158.6 Y134.571
G1 X160.789 Y132.382 E.05027
G1 X160.225 Y132.382
G1 X158.036 Y134.571 E.05026
G1 X157.473 Y134.571
G1 X159.661 Y132.383 E.05024
G1 X159.096 Y132.383
G1 X156.909 Y134.571 E.05023
G1 X156.345 Y134.571
G1 X158.532 Y132.384 E.05022
G1 X158.088 Y132.264
G1 X155.782 Y134.571 E.05297
G1 X155.218 Y134.571
G1 X157.947 Y131.842 E.06267
G1 X157.947 Y131.278
G1 X155.171 Y134.054 E.06375
G1 X155.171 Y133.49
G1 X157.947 Y130.714 E.06375
G1 X157.947 Y130.151
G1 X155.171 Y132.927 E.06375
G1 X155.171 Y132.363
G1 X157.947 Y129.587 E.06375
G1 X157.947 Y129.024
G1 X155.171 Y131.8 E.06375
G1 X155.171 Y131.236
G1 X157.947 Y128.46 E.06375
G1 X157.947 Y127.896
G1 X155.171 Y130.672 E.06375
G1 X155.171 Y130.109
G1 X157.958 Y127.322 E.06399
G1 E-.8 F1800
M204 S10000
G1 X165.058 Y130.122 Z2.4 F30000
G1 X166.042 Y130.51 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X168.614 Y127.938 E.05906
G1 X168.434 Y127.555
G1 X166.138 Y129.851 E.05273
G1 X166.124 Y129.301
G1 X168.198 Y127.227 E.04762
G1 X167.958 Y126.904
G1 X166.029 Y128.832 E.04429
G1 X165.873 Y128.425
G1 X167.661 Y126.636 E.04107
G1 X167.364 Y126.37
G1 X165.662 Y128.073 E.03909
G1 X165.401 Y127.77
G1 X167.011 Y126.16 E.03697
G1 X166.655 Y125.952
G1 X165.091 Y127.516 E.03593
G1 X164.722 Y127.322
G1 X166.264 Y125.779 E.03542
G1 X165.845 Y125.635
G1 X164.309 Y127.171 E.03527
G1 X163.836 Y127.08
G1 X165.401 Y125.515 E.03593
G1 X164.934 Y125.418
G1 X163.325 Y127.027 E.03695
G1 X162.797 Y126.992
G1 X164.485 Y125.304 E.03875
G1 X164.271 Y124.954
G1 X162.249 Y126.976 E.04644
G1 X161.7 Y126.962
G1 X168.337 Y120.325 E.15241
G1 E-.8 F1800
M204 S10000
G1 X169.281 Y118.818 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X161.137 Y126.961 E.18702
G1 X160.573 Y126.961
G1 X170.105 Y117.429 E.21889
G1 X169.542 Y117.429
G1 X160.01 Y126.961 E.21888
G1 X159.447 Y126.96
G1 X168.978 Y117.429 E.21888
G1 X168.415 Y117.429
G1 X163.457 Y122.386 E.11384
G1 E-.8 F1800
M204 S10000
G1 X164.68 Y120.6 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X167.851 Y117.429 E.07282
G1 X167.287 Y117.429
G1 X165.829 Y118.888 E.03349
G1 E-.8 F1800
M204 S10000
G1 X161.162 Y124.681 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X158.884 Y126.96 E.05233
G1 X158.317 Y126.963
G1 X160.424 Y124.856 E.0484
G1 X159.794 Y124.922
G1 X155.171 Y129.545 E.10616
G1 X155.171 Y128.982
G1 X159.213 Y124.94 E.0928
G1 X158.648 Y124.941
G1 X155.171 Y128.418 E.07984
G1 X155.171 Y127.854
G1 X158.147 Y124.878 E.06834
G1 X157.947 Y124.515
G1 X155.171 Y127.291 E.06375
G1 X155.171 Y126.727
G1 X157.947 Y123.951 E.06375
G1 X157.947 Y123.387
G1 X155.171 Y126.164 E.06375
G1 X155.171 Y125.6
G1 X157.947 Y122.824 E.06375
G1 X157.947 Y122.26
G1 X155.171 Y125.036 E.06375
G1 X155.171 Y124.473
G1 X157.947 Y121.697 E.06375
G1 X157.947 Y121.133
G1 X155.171 Y123.909 E.06375
G1 X155.171 Y123.346
G1 X157.947 Y120.569 E.06375
G1 X157.947 Y120.006
G1 X155.171 Y122.782 E.06375
G1 X155.171 Y122.218
G1 X157.947 Y119.442 E.06375
G1 X157.947 Y118.879
G1 X155.171 Y121.655 E.06375
G1 X155.171 Y121.091
G1 X157.947 Y118.315 E.06375
G1 X157.947 Y117.751
G1 X155.171 Y120.527 E.06375
G1 X155.171 Y119.964
G1 X157.706 Y117.429 E.05821
G1 X157.142 Y117.429
G1 X155.171 Y119.4 E.04526
G1 X155.171 Y118.837
G1 X156.579 Y117.429 E.03232
G1 X156.015 Y117.429
G1 X155.171 Y118.273 E.01938
G1 E-.8 F1800
M204 S10000
G1 X162.606 Y119.999 Z2.4 F30000
G1 X167.776 Y121.198 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.087496
G1 F3600
M204 S1000
G1 X167.658 Y121.343 E.0005
; LINE_WIDTH: 0.123929
G1 X167.541 Y121.487 E.00078
; LINE_WIDTH: 0.160363
G1 X167.423 Y121.632 E.00105
; LINE_WIDTH: 0.20326
G1 X167.235 Y121.855 E.00216
; LINE_WIDTH: 0.252621
G1 X167.047 Y122.078 E.00275
; LINE_WIDTH: 0.301981
G1 X166.859 Y122.301 E.00334
; LINE_WIDTH: 0.346711
G1 X166.632 Y122.556 E.00453
; LINE_WIDTH: 0.386802
G1 X166.405 Y122.811 E.00508
; LINE_WIDTH: 0.405779
G3 X165.429 Y123.761 I-9.675 J-8.958 E.02133
; LINE_WIDTH: 0.346979
G1 X165.203 Y123.954 E.00394
; LINE_WIDTH: 0.299201
G1 X164.977 Y124.147 E.00336
; LINE_WIDTH: 0.25504
G1 X164.834 Y124.26 E.00174
; LINE_WIDTH: 0.214507
G1 X164.691 Y124.374 E.00144
; LINE_WIDTH: 0.173973
G1 X164.549 Y124.488 E.00113
; LINE_WIDTH: 0.126942
G2 X164.185 Y124.868 I.892 J1.217 E.00227
G1 E-.8 F1800
M204 S10000
G1 X168.754 Y119.656 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0937608
G1 F3600
M204 S1000
G1 X168.594 Y119.858 E.00076
; LINE_WIDTH: 0.142713
G1 X168.433 Y120.059 E.00127
; LINE_WIDTH: 0.191665
G1 X168.273 Y120.261 E.00179
G1 E-.8 F1800
M204 S10000
G1 X169.698 Y118.149 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0937608
G1 F3600
M204 S1000
G1 X169.537 Y118.35 E.00076
; LINE_WIDTH: 0.142713
G1 X169.377 Y118.552 E.00127
; LINE_WIDTH: 0.191665
G1 X169.216 Y118.753 E.00179
G1 E-.8 F1800
M204 S10000
G1 X166.902 Y117.409 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.158689
G1 F3600
M204 S1000
G1 X166.759 Y117.584 E.00126
; LINE_WIDTH: 0.122926
G1 X166.615 Y117.758 E.00093
; LINE_WIDTH: 0.0871628
G1 X166.472 Y117.932 E.0006
G1 E-.8 F1800
M204 S10000
G1 X165.893 Y118.952 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.200741
G1 F3600
M204 S1000
G1 X165.75 Y119.125 E.00164
; LINE_WIDTH: 0.163181
G1 X165.608 Y119.298 E.0013
; LINE_WIDTH: 0.125621
G1 X165.465 Y119.471 E.00095
; LINE_WIDTH: 0.0880617
G1 X165.323 Y119.645 E.00061
G1 E-.8 F1800
M204 S10000
G1 X164.744 Y120.664 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.200753
G1 F3600
M204 S1000
G1 X164.601 Y120.838 E.00164
; LINE_WIDTH: 0.16319
G1 X164.459 Y121.011 E.0013
; LINE_WIDTH: 0.125627
G1 X164.316 Y121.184 E.00095
; LINE_WIDTH: 0.0880636
G1 X164.174 Y121.357 E.00061
G1 E-.8 F1800
M204 S10000
G1 X163.521 Y122.45 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.19716
G1 F3600
M204 S1000
G1 X163.314 Y122.697 E.00231
; LINE_WIDTH: 0.147601
G1 X163.106 Y122.943 E.00166
; LINE_WIDTH: 0.0978925
G1 X162.898 Y123.191 E.00101
; LINE_WIDTH: 0.0711352
G1 X162.856 Y123.237 E.00013
G1 E-.8 F1800
M204 S10000
G1 X161.682 Y124.415 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0922421
G1 F3600
M204 S1000
G1 X161.531 Y124.525 E.00054
; LINE_WIDTH: 0.138176
G1 X161.379 Y124.636 E.00089
; LINE_WIDTH: 0.18411
G1 X161.227 Y124.746 E.00124
G1 E-.8 F1800
M204 S10000
G1 X159.517 Y124.918 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0869748
G1 F3600
M204 S1000
G1 X159.288 Y125.016 E.00066
G1 E-.8 F1800
M204 S10000
G1 X163.775 Y131.19 Z2.4 F30000
G1 X164.562 Y132.272 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.111948
G1 F3600
M204 S1000
G1 X164.316 Y132.212 E.00093
M204 S10000
G1 X163.37 Y132.337 F30000
; LINE_WIDTH: 0.0767985
G1 F3600
M204 S1000
G1 X163.136 Y132.44 E.00058
G1 E-.8 F1800
M204 S10000
G1 X158.25 Y126.896 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.166143
G1 F3600
M204 S1000
G2 X157.93 Y127.182 I.478 J.854 E.00255
G1 X157.958 Y127.323 E.00084
G1 E-.8 F1800
M204 S10000
G1 X165.045 Y130.155 Z2.4 F30000
G1 X166.115 Y130.583 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.150033
G1 F3600
M204 S1000
G1 X166.041 Y130.704 E.00075
; LINE_WIDTH: 0.127671
G1 X165.974 Y130.801 E.00051
; LINE_WIDTH: 0.0887411
G1 X165.908 Y130.899 E.00032
G1 E-.8 F1800
M204 S10000
G1 X168.389 Y132.419 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0890421
G1 F3600
M204 S1000
G1 X168.295 Y132.547 E.00044
; LINE_WIDTH: 0.132297
G1 X168.085 Y132.79 E.00145
; LINE_WIDTH: 0.192141
G3 X167.445 Y133.457 I-4.501 J-3.673 E.00643
; LINE_WIDTH: 0.177113
G1 X167.292 Y133.585 E.00127
; LINE_WIDTH: 0.141032
G1 X167.139 Y133.713 E.00097
; LINE_WIDTH: 0.104951
G1 X166.985 Y133.841 E.00068
; LINE_WIDTH: 0.0780965
G1 X166.924 Y133.883 E.00017
G1 E-.8 F1800
M204 S10000
G1 X162.1 Y127.969 Z2.4 F30000
G1 X146.21 Y108.49 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.4 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.4 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F6000
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.4 F30000
G1 X132.95 Y121.243
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 E-.8 F1800
M204 S10000
G1 X135.551 Y128.357 Z2.4 F30000
G1 X136.518 Y130.987 Z2.4
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S500
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
G1 E-.8 F1800
M204 S10000
G1 X137.746 Y134.571 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X138.7 Y133.617 E.02189
G1 X139.076 Y132.677
G1 X137.183 Y134.571 E.04348
G1 X136.619 Y134.571
G1 X139.452 Y131.737 E.06507
G1 X139.829 Y130.797
G1 X136.055 Y134.571 E.08665
G1 X135.492 Y134.571
G1 X140.205 Y129.857 E.10824
G1 X140.582 Y128.917
G1 X135.022 Y134.477 E.12767
G1 X134.864 Y134.071
G1 X140.958 Y127.977 E.13994
G1 X141.334 Y127.038
G1 X134.706 Y133.666 E.15221
G1 X134.548 Y133.26
G1 X136.567 Y131.242 E.04635
G1 X136.256 Y130.988
G1 X134.39 Y132.854 E.04285
G1 X134.232 Y132.449
G1 X136.105 Y130.576 E.04301
G1 X135.955 Y130.163
G1 X134.074 Y132.043 E.04319
G1 X133.916 Y131.638
G1 X135.805 Y129.749 E.04336
G1 X135.654 Y129.336
G1 X133.758 Y131.232 E.04354
G1 X133.6 Y130.826
G1 X135.504 Y128.923 E.04371
G1 X135.353 Y128.51
G1 X133.442 Y130.421 E.04388
G1 X133.284 Y130.015
G1 X135.203 Y128.097 E.04406
G1 X135.053 Y127.683
G1 X133.126 Y129.609 E.04423
G1 X132.968 Y129.204
G1 X134.902 Y127.27 E.04441
G1 X134.752 Y126.857
G1 X132.81 Y128.798 E.04458
G1 X132.652 Y128.393
G1 X134.601 Y126.444 E.04476
G1 X134.451 Y126.03
G1 X132.494 Y127.987 E.04493
G1 X132.336 Y127.581
G1 X134.301 Y125.617 E.0451
G1 X134.15 Y125.204
G1 X132.178 Y127.176 E.04528
G1 X132.02 Y126.77
G1 X134 Y124.791 E.04545
G1 X133.849 Y124.378
G1 X131.862 Y126.365 E.04563
G1 E-.8 F1800
M204 S10000
G1 X137.157 Y130.651 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X141.711 Y126.098 E.10456
G1 X142.087 Y125.158
G1 X137.49 Y129.754 E.10556
G1 X137.823 Y128.858
G1 X142.464 Y124.218 E.10656
G1 X142.84 Y123.278
G1 X138.156 Y127.961 E.10756
G1 X138.489 Y127.065
G1 X143.216 Y122.338 E.10856
G1 X143.593 Y121.398
G1 X138.822 Y126.168 E.10956
G1 X139.155 Y125.272
G1 X143.969 Y120.458 E.11056
G1 X144.345 Y119.518
G1 X139.488 Y124.375 E.11155
G1 X139.455 Y123.845
G1 X144.722 Y118.578 E.12095
G1 X145.098 Y117.638
G1 X139.044 Y123.692 E.13904
G1 X138.48 Y123.692
G1 X144.743 Y117.429 E.14383
G1 X144.179 Y117.429
G1 X140.894 Y120.714 E.07544
G1 X141.246 Y119.799
G1 X143.616 Y117.429 E.05442
G1 X143.052 Y117.429
G1 X141.598 Y118.883 E.03339
G1 X141.95 Y117.968
G1 X142.489 Y117.429 E.01237
G1 E-.8 F1800
M204 S10000
G1 X140.091 Y121.518 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X137.916 Y123.692 E.04994
G1 X137.353 Y123.692
G1 X139.528 Y121.517 E.04995
G1 X138.965 Y121.517
G1 X136.789 Y123.692 E.04996
G1 X136.226 Y123.692
G1 X138.402 Y121.516 E.04998
G1 X137.839 Y121.515
G1 X135.662 Y123.692 E.04999
G1 X135.098 Y123.692
G1 X137.276 Y121.515 E.05
G1 X136.713 Y121.514
G1 X134.535 Y123.692 E.05001
G1 E-.8 F1800
M204 S10000
G1 X136.15 Y121.514 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X131.704 Y125.959 E.10208
G1 X131.546 Y125.553
G1 X135.587 Y121.513 E.09278
G1 X135.024 Y121.513
G1 X131.388 Y125.148 E.08347
G1 X131.23 Y124.742
G1 X134.46 Y121.512 E.07417
G1 X133.897 Y121.512
G1 X131.073 Y124.336 E.06487
G1 X130.915 Y123.931
G1 X133.334 Y121.511 E.05557
G1 X132.849 Y121.433
G1 X130.757 Y123.525 E.04804
G1 X130.599 Y123.12
G1 X132.636 Y121.082 E.0468
G1 X132.486 Y120.668
G1 X130.441 Y122.714 E.04698
G1 X130.283 Y122.308
G1 X132.336 Y120.255 E.04715
G1 X132.186 Y119.842
G1 X130.125 Y121.903 E.04733
G1 X129.967 Y121.497
G1 X132.036 Y119.428 E.04751
G1 X131.885 Y119.015
G1 X129.809 Y121.091 E.04769
G1 X129.651 Y120.686
G1 X131.735 Y118.601 E.04787
G1 X131.585 Y118.188
G1 X129.493 Y120.28 E.04805
G1 X129.335 Y119.875
G1 X131.435 Y117.775 E.04822
G1 X131.216 Y117.429
G1 X129.177 Y119.469 E.04684
G1 X129.019 Y119.063
G1 X130.653 Y117.429 E.03753
G1 X130.089 Y117.429
G1 X128.861 Y118.658 E.02821
G1 X128.703 Y118.252
G1 X129.526 Y117.429 E.0189
G1 X128.962 Y117.429
G1 X128.545 Y117.847 E.00958
G1 E-.8 F1800
M204 S10000
G1 X132.813 Y124.174 Z2.4 F30000
G1 X137.23 Y130.723 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0928185
G1 F3600
M204 S1000
G3 X136.99 Y131.071 I-7.565 J-4.947 E.00123
M204 S10000
G1 X136.904 Y131.157 F30000
; LINE_WIDTH: 0.0919619
G1 F3600
M204 S1000
G1 X136.765 Y131.259 E.0005
; LINE_WIDTH: 0.13855
G3 X136.64 Y131.315 I-.315 J-.532 E.00065
G1 E-.8 F1800
M204 S10000
G1 X139.348 Y124.179 Z2.4 F30000
G1 X140.363 Y121.503 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0925734
G1 F3600
M204 S1000
G3 X140.17 Y121.597 I-1.102 J-2.039 E.00062
G1 E-.8 F1800
M204 S10000
G1 X145.191 Y117.46 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.128394
G1 F3600
M204 S1000
G1 X144.921 Y117.46 E.00117
G1 X144.817 Y117.503 E.00049
G1 E-.8 F1800
M204 S10000
G1 X137.385 Y115.768 Z2.4 F30000
G1 X106.21 Y108.49 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
M73 P96 R1
G1 F6000
M204 S1000
G1 X111.3 Y108 E.10898
; WIPE_START
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y108.161 Z2.4 F30000
G1 X106.643 Y108.068
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.4 F30000
G1 X98.758 Y118.262
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 E-.8 F1800
M204 S10000
G1 X97.871 Y121.656 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F3600
M204 S500
G3 X98.625 Y123.246 I-4.123 J2.931 E.02873
G3 X98.966 Y126.817 I-10.895 J2.842 E.05849
G3 X98.446 Y129.384 I-8.699 J-.426 E.0427
G3 X95.933 Y132.009 I-4.436 J-1.732 E.06053
G3 X93.259 Y132.386 I-2.133 J-5.453 E.04425
M73 P97 R1
G3 X89.707 Y130.379 I.351 J-4.767 E.06844
G3 X88.809 Y128.172 I5.311 J-3.447 E.03892
G3 X88.626 Y125.475 I10.957 J-2.101 E.044
G3 X89.299 Y122.433 I8.061 J.187 E.05091
G1 X89.723 Y121.684 E.01398
G3 X91.29 Y120.236 I4.366 J3.153 E.03488
G1 X91.74 Y120.006 E.00819
G3 X95.87 Y119.994 I2.079 J4.945 E.06884
G3 X97.835 Y121.607 I-2.122 J4.592 E.04173
G1 E-.8 F1800
M204 S10000
G1 X97.72 Y129.238 Z2.4 F30000
G1 X97.647 Y134.091 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X101.22 Y130.518 E.08204
G1 X101.576 Y129.598
G1 X96.727 Y134.447 E.11135
G1 X95.962 Y134.649
G1 X101.799 Y128.811 E.13404
G1 X101.937 Y128.11
G1 X95.277 Y134.77 E.15294
G1 X94.64 Y134.843
G1 X102.019 Y127.464 E.16946
G1 X102.078 Y126.841
G1 X94.053 Y134.867 E.1843
G1 X93.484 Y134.872
G1 X96.269 Y132.087 E.06395
G1 X95.362 Y132.43
G1 X92.952 Y134.841 E.05536
G1 X92.433 Y134.796
G1 X94.66 Y132.569 E.05115
G1 X94.046 Y132.619
G1 X91.943 Y134.722 E.04831
G1 X91.466 Y134.635
G1 X93.486 Y132.616 E.04638
G1 X92.97 Y132.567
G1 X91.02 Y134.518 E.04479
G1 X90.585 Y134.39
G1 X92.492 Y132.483 E.0438
G1 X92.046 Y132.365
G1 X90.183 Y134.227 E.04278
G1 X89.793 Y134.054
G1 X91.634 Y132.213 E.04226
G1 X91.255 Y132.029
G1 X89.412 Y133.872 E.04232
G1 X89.064 Y133.655
G1 X90.901 Y131.819 E.04217
G1 X90.569 Y131.587
G1 X88.735 Y133.421 E.04211
G1 X88.418 Y133.175
G1 X90.26 Y131.333 E.0423
G1 X89.979 Y131.05
G1 X88.125 Y132.904 E.04258
G1 X87.839 Y132.627
G1 X89.718 Y130.747 E.04316
G1 X89.478 Y130.424
G1 X87.573 Y132.329 E.04374
G1 X87.316 Y132.022
G1 X89.265 Y130.073 E.04475
G1 X89.077 Y129.697
G1 X87.076 Y131.699 E.04597
G1 X86.85 Y131.361
G1 X88.909 Y129.302 E.04728
G1 X88.764 Y128.884
G1 X86.636 Y131.012 E.04887
G1 X86.444 Y130.64
G1 X88.649 Y128.434 E.05064
G1 X88.553 Y127.967
G1 X86.261 Y130.259 E.05264
G1 X86.101 Y129.856
G1 X88.477 Y127.48 E.05456
G1 X88.429 Y126.964
G1 X85.961 Y129.432 E.05667
G1 X85.842 Y128.988
G1 X88.403 Y126.427 E.05881
G1 X88.395 Y125.871
G1 X85.741 Y128.525 E.06096
G1 X85.658 Y128.044
G1 X88.412 Y125.29 E.06325
G1 X88.469 Y124.67
G1 X85.593 Y127.546 E.06604
G1 X85.546 Y127.029
G1 X88.571 Y124.004 E.06947
G1 X88.747 Y123.265
G1 X85.517 Y126.495 E.07417
G1 X85.515 Y125.933
G1 X89.095 Y122.352 E.08222
G1 E-.8 F1800
M204 S10000
G1 X95.03 Y127.151 Z2.4 F30000
G1 X98.444 Y129.912 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X102.101 Y126.255 E.08397
G1 X102.096 Y125.696
G1 X98.82 Y128.973 E.07525
G1 X99.012 Y128.216
G1 X102.078 Y125.15 E.07041
G1 X102.031 Y124.634
G1 X99.12 Y127.545 E.06684
G1 X99.177 Y126.925
G1 X101.977 Y124.124 E.06431
G1 X101.896 Y123.642
G1 X99.199 Y126.339 E.06193
G1 X99.198 Y125.776
G1 X101.803 Y123.171 E.05981
G1 X101.682 Y122.728
G1 X99.18 Y125.231 E.05747
G1 X99.133 Y124.714
G1 X101.554 Y122.293 E.05561
G1 X101.397 Y121.887
G1 X99.063 Y124.22 E.05358
G1 X98.976 Y123.744
G1 X101.234 Y121.486 E.05185
G1 X101.041 Y121.115
G1 X98.864 Y123.292 E.05
G1 X98.725 Y122.868
G1 X100.845 Y120.747 E.04869
G1 X100.618 Y120.411
G1 X98.568 Y122.461 E.04709
G1 X98.389 Y122.077
G1 X100.389 Y120.076 E.04595
G1 X100.13 Y119.772
G1 X98.178 Y121.724 E.04483
G1 X97.948 Y121.391
G1 X99.869 Y119.469 E.04413
G1 X99.58 Y119.195
G1 X97.699 Y121.076 E.0432
G1 X97.42 Y120.79
G1 X99.288 Y118.923 E.04289
G1 X98.968 Y118.68
G1 X97.123 Y120.525 E.04237
G1 X96.805 Y120.278
G1 X98.646 Y118.438 E.04226
G1 X98.291 Y118.229
G1 X96.467 Y120.053 E.04191
G1 X96.095 Y119.862
G1 X97.934 Y118.022 E.04225
G1 X97.546 Y117.847
G1 X95.696 Y119.697 E.04248
G1 X95.268 Y119.561
G1 X97.15 Y117.679 E.04321
G1 X96.726 Y117.539
G1 X94.807 Y119.459 E.04407
G1 X94.309 Y119.393
G1 X96.288 Y117.414 E.04543
G1 X95.827 Y117.312
G1 X93.766 Y119.372 E.04731
G1 X93.166 Y119.409
G1 X95.342 Y117.233 E.04996
G1 X94.841 Y117.17
G1 X92.479 Y119.532 E.05426
G1 X91.632 Y119.815
G1 X94.307 Y117.141 E.06142
G1 X93.757 Y117.127
G1 X85.514 Y125.37 E.18931
G1 X85.558 Y124.763
G1 X93.174 Y117.146 E.17491
G1 X92.562 Y117.195
G1 X85.625 Y124.132 E.15928
G1 X85.729 Y123.465
G1 X91.896 Y117.297 E.14163
G1 X91.168 Y117.461
G1 X85.913 Y122.717 E.12068
G1 X86.2 Y121.866
G1 X90.328 Y117.738 E.09479
G1 X89.236 Y118.266
G1 X86.775 Y120.727 E.0565
G1 E-.8 F1800
M204 S10000
G1 X92.905 Y125.275 Z2.4 F30000
G1 X100.866 Y131.183 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0789438
G1 F3600
M204 S1000
G1 X100.812 Y131.255 E.00021
; LINE_WIDTH: 0.11335
G1 X100.64 Y131.462 E.00101
; LINE_WIDTH: 0.162857
G1 X100.468 Y131.669 E.00155
; LINE_WIDTH: 0.212364
G1 X100.296 Y131.876 E.00209
; LINE_WIDTH: 0.251517
G1 X100.025 Y132.167 E.00374
; LINE_WIDTH: 0.280388
G3 X99.184 Y133.009 I-8.166 J-7.324 E.01256
; LINE_WIDTH: 0.24726
G1 X98.986 Y133.18 E.00241
; LINE_WIDTH: 0.209565
G1 X98.788 Y133.351 E.00201
; LINE_WIDTH: 0.17187
G1 X98.59 Y133.522 E.0016
; LINE_WIDTH: 0.1321
G1 X98.45 Y133.631 E.0008
; LINE_WIDTH: 0.0902259
G1 X98.309 Y133.74 E.0005
G1 E-.8 F1800
M204 S10000
G1 X94.996 Y126.864 Z2.4 F30000
G1 X91.567 Y119.75 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.186307
G1 F3600
M204 S1000
G1 X91.436 Y119.846 E.00109
; LINE_WIDTH: 0.145384
G1 X91.305 Y119.941 E.00082
; LINE_WIDTH: 0.104025
G1 X91.171 Y120.039 E.00056
; LINE_WIDTH: 0.0761929
G1 X91.099 Y120.097 E.00021
G1 E-.8 F1800
M204 S10000
G1 X97.487 Y124.274 Z2.4 F30000
G1 X99.26 Y125.433 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0746229
G1 F3600
M204 S1000
G1 X99.161 Y125.211 E.00053
G1 E-.8 F1800
M204 S10000
G1 X98.433 Y129.901 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.174991
G1 F3600
M204 S1000
G1 X98.455 Y130.053 E.00096
; LINE_WIDTH: 0.182001
G1 X98.337 Y130.205 E.00126
; LINE_WIDTH: 0.136913
G1 X98.218 Y130.357 E.00091
; LINE_WIDTH: 0.0918257
G1 X98.099 Y130.509 E.00055
G1 E-.8 F1800
M204 S10000
G1 X96.874 Y131.733 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0910135
G1 F3600
M204 S1000
G1 X96.704 Y131.87 E.00062
; LINE_WIDTH: 0.135246
G1 X96.529 Y132.012 E.00105
; LINE_WIDTH: 0.181917
G1 X96.334 Y132.152 E.00157
G1 E-.8 F1800
M204 S10000
G1 X92.079 Y125.816 Z2.4 F30000
G1 X89.388 Y121.808 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0831812
G1 F3600
M204 S1000
G1 X89.304 Y121.913 E.00034
; LINE_WIDTH: 0.111575
G1 X89.217 Y122.023 E.00051
; LINE_WIDTH: 0.14591
G1 X89.124 Y122.155 E.00082
; LINE_WIDTH: 0.184753
G1 X89.03 Y122.287 E.00108
G1 E-.8 F1800
M204 S10000
G1 X86.84 Y120.791 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.198999
G1 F3600
M204 S1000
G1 X86.726 Y120.935 E.00133
; LINE_WIDTH: 0.167147
G1 X86.613 Y121.079 E.00109
; LINE_WIDTH: 0.130742
G1 X86.538 Y121.187 E.00058
; LINE_WIDTH: 0.0897689
G1 X86.462 Y121.294 E.00037
G1 E-.8 F1800
M204 S10000
G1 X86.385 Y128.926 Z2.4 F30000
G1 X86.369 Y130.432 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0830177
G1 F3600
M204 S1000
G3 X86.278 Y130.303 I1.56 J-1.203 E.0004
G1 E-.8 F1800
M204 S10000
G1 X93.527 Y132.69 Z2.4 F30000
G1 X97.581 Y134.025 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.179506
G1 F3600
M204 S1000
G1 X97.449 Y134.116 E.00104
; LINE_WIDTH: 0.13542
G1 X97.317 Y134.208 E.00075
; LINE_WIDTH: 0.0913333
G1 X97.184 Y134.299 E.00046
; WIPE_START
G1 X97.317 Y134.208 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.558 Y129.198 Z2.4 F30000
G1 X77.125 Y116.643 Z2.4
G1 X77.125 Y116.643
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.4 F30000
G1 X77.085 Y121.357
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.4 F30000
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.4 F30000
G1 X95.357 Y143.922
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.4 F30000
G1 X116.218 Y122.885
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
G1 E-.8 F1800
M204 S10000
G1 X111.816 Y129.096 Z2.4 F30000
G1 X107.875 Y134.571 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X110.015 Y132.431 E.04915
G1 E-.8 F1800
M204 S10000
G1 X110.908 Y130.975 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X107.312 Y134.571 E.08258
G1 X106.748 Y134.571
G1 X111.8 Y129.519 E.11601
G1 E-.8 F1800
M204 S10000
G1 X112.692 Y128.063 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X106.184 Y134.571 E.14945
G1 X105.837 Y134.355
G1 X113.584 Y126.607 E.17791
G1 E-.8 F1800
M204 S10000
G1 X114.477 Y125.151 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X105.837 Y133.791 E.1984
G1 X105.837 Y133.227
G1 X115.369 Y123.695 E.21889
G1 E-.8 F1800
M204 S10000
G1 X118.088 Y130.827 Z2.4 F30000
G1 X119.258 Y133.896 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X118.584 Y134.571 E.01549
G1 X118.02 Y134.571
G1 X119.258 Y133.333 E.02844
G1 X119.258 Y132.769
G1 X117.456 Y134.571 E.04138
G1 X116.893 Y134.571
G1 X119.258 Y132.205 E.05432
G1 X119.258 Y131.642
G1 X116.74 Y134.16 E.05783
G1 X116.74 Y133.596
G1 X119.258 Y131.078 E.05783
G1 X119.258 Y130.514
G1 X116.74 Y133.033 E.05783
G1 X116.74 Y132.469
G1 X119.258 Y129.951 E.05783
G1 X119.258 Y129.387
G1 X116.74 Y131.905 E.05783
G1 X116.74 Y131.342
G1 X119.258 Y128.824 E.05783
G1 X119.258 Y128.26
G1 X116.74 Y130.778 E.05783
G1 X116.74 Y130.215
G1 X119.258 Y127.696 E.05783
G1 X119.258 Y127.133
G1 X116.74 Y129.651 E.05783
G1 X116.74 Y129.087
G1 X119.258 Y126.569 E.05783
G1 X119.258 Y126.006
G1 X116.74 Y128.524 E.05783
G1 X116.74 Y127.96
G1 X119.258 Y125.442 E.05783
G1 X119.258 Y124.878
G1 X116.74 Y127.397 E.05783
G1 X116.74 Y126.833
G1 X119.258 Y124.315 E.05783
G1 X119.258 Y123.751
G1 X116.74 Y126.269 E.05783
G1 X116.74 Y125.706
G1 X119.258 Y123.188 E.05783
G1 X119.258 Y122.624
G1 X116.74 Y125.142 E.05783
G1 X116.74 Y124.579
G1 X119.258 Y122.06 E.05783
G1 X119.258 Y121.497
G1 X116.74 Y124.015 E.05783
G1 X116.74 Y123.451
G1 X119.258 Y120.933 E.05783
G1 X119.258 Y120.37
G1 X116.696 Y122.932 E.05883
G1 X116.374 Y122.691
G1 X119.258 Y119.806 E.06625
G1 X119.258 Y119.242
G1 X105.837 Y132.664 E.30821
G1 X105.837 Y132.1
G1 X108.886 Y129.051 E.07001
G1 X108.479 Y128.895
G1 X105.837 Y131.536 E.06066
G1 X105.837 Y130.973
G1 X108.355 Y128.455 E.05783
G1 X108.355 Y127.891
G1 X105.837 Y130.409 E.05783
G1 X105.837 Y129.846
G1 X108.355 Y127.327 E.05783
G1 X108.355 Y126.764
G1 X105.837 Y129.282 E.05783
G1 X105.837 Y128.718
G1 X108.355 Y126.2 E.05783
G1 X108.355 Y125.637
G1 X105.837 Y128.155 E.05783
G1 X105.837 Y127.591
G1 X108.355 Y125.073 E.05783
G1 X108.355 Y124.509
G1 X105.837 Y127.028 E.05783
G1 X105.837 Y126.464
G1 X108.355 Y123.946 E.05783
G1 X108.355 Y123.382
G1 X105.837 Y125.9 E.05783
G1 X105.837 Y125.337
G1 X108.355 Y122.819 E.05783
G1 X108.355 Y122.255
G1 X105.837 Y124.773 E.05783
G1 X105.837 Y124.21
G1 X108.355 Y121.691 E.05783
G1 X108.355 Y121.128
G1 X105.837 Y123.646 E.05783
G1 X105.837 Y123.082
G1 X108.355 Y120.564 E.05783
G1 X108.355 Y120.001
G1 X105.837 Y122.519 E.05783
G1 X105.837 Y121.955
G1 X108.355 Y119.437 E.05783
G1 X108.355 Y118.873
G1 X105.837 Y121.392 E.05783
G1 X105.837 Y120.828
G1 X108.355 Y118.31 E.05783
G1 X108.355 Y117.746
G1 X105.837 Y120.264 E.05783
G1 X105.837 Y119.701
G1 X108.109 Y117.429 E.05216
G1 X107.545 Y117.429
G1 X105.837 Y119.137 E.03922
G1 X105.837 Y118.574
G1 X106.981 Y117.429 E.02628
G1 X106.418 Y117.429
G1 X105.837 Y118.01 E.01334
G1 E-.8 F1800
M204 S10000
G1 X108.312 Y125.23 Z2.4 F30000
G1 X109.435 Y128.503 Z2.4
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X119.258 Y118.679 E.22559
G1 X119.258 Y118.115
G1 X110.347 Y127.026 E.20464
G1 E-.8 F1800
M204 S10000
G1 X111.26 Y125.55 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X119.258 Y117.552 E.18368
G1 X118.817 Y117.429
G1 X112.172 Y124.074 E.15259
G1 E-.8 F1800
M204 S10000
G1 X113.085 Y122.598 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X118.254 Y117.429 E.11869
G1 X117.69 Y117.429
G1 X113.997 Y121.122 E.08479
G1 E-.8 F1800
M204 S10000
G1 X114.91 Y119.645 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F2700
M204 S2000
G1 X117.126 Y117.429 E.0509
G1 X116.563 Y117.429
G1 X115.823 Y118.169 E.017
G1 E-.8 F1800
M204 S10000
G1 X111.856 Y124.69 Z2.4 F30000
G1 X109.499 Y128.567 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.198256
G1 F3600
M204 S1000
G1 X109.376 Y128.722 E.00143
; LINE_WIDTH: 0.153739
G3 X108.967 Y129.132 I-1.522 J-1.11 E.00313
G1 E-.8 F1800
M204 S10000
G1 X110.411 Y127.091 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X110.255 Y127.288 E.00174
; LINE_WIDTH: 0.142414
G1 X110.099 Y127.485 E.00124
; LINE_WIDTH: 0.0936598
G1 X109.943 Y127.682 E.00074
G1 E-.8 F1800
M204 S10000
G1 X111.324 Y125.614 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191156
G1 F3600
M204 S1000
G1 X111.168 Y125.812 E.00174
; LINE_WIDTH: 0.142407
G1 X111.012 Y126.009 E.00124
; LINE_WIDTH: 0.093657
G1 X110.856 Y126.206 E.00074
G1 E-.8 F1800
M204 S10000
G1 X112.237 Y124.138 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X112.081 Y124.335 E.00174
; LINE_WIDTH: 0.142414
G1 X111.924 Y124.533 E.00124
; LINE_WIDTH: 0.0936598
G1 X111.768 Y124.73 E.00074
G1 E-.8 F1800
M204 S10000
G1 X113.149 Y122.662 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191156
G1 F3600
M204 S1000
G1 X112.993 Y122.859 E.00174
; LINE_WIDTH: 0.142407
G1 X112.837 Y123.056 E.00124
; LINE_WIDTH: 0.093657
G1 X112.681 Y123.253 E.00074
G1 E-.8 F1800
M204 S10000
G1 X114.062 Y121.186 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191156
G1 F3600
M204 S1000
G1 X113.906 Y121.383 E.00174
; LINE_WIDTH: 0.142407
G1 X113.75 Y121.58 E.00124
; LINE_WIDTH: 0.0936571
G1 X113.594 Y121.777 E.00074
G1 E-.8 F1800
M204 S10000
G1 X114.974 Y119.71 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X114.818 Y119.907 E.00174
; LINE_WIDTH: 0.142414
G1 X114.662 Y120.104 E.00124
; LINE_WIDTH: 0.09366
G1 X114.506 Y120.301 E.00074
G1 E-.8 F1800
M204 S10000
G1 X115.887 Y118.234 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.191168
G1 F3600
M204 S1000
G1 X115.731 Y118.431 E.00174
; LINE_WIDTH: 0.142414
G1 X115.575 Y118.628 E.00124
; LINE_WIDTH: 0.09366
G1 X115.419 Y118.825 E.00074
G1 E-.8 F1800
M204 S10000
G1 X115.764 Y123.049 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0935903
G1 F3600
M204 S1000
G1 X115.611 Y123.243 E.00073
; LINE_WIDTH: 0.142202
G1 X115.458 Y123.437 E.00122
; LINE_WIDTH: 0.190815
G1 X115.305 Y123.631 E.00171
M204 S10000
G1 X114.872 Y124.504 F30000
; LINE_WIDTH: 0.0935903
G1 F3600
M204 S1000
G1 X114.719 Y124.699 E.00073
; LINE_WIDTH: 0.142202
G1 X114.566 Y124.893 E.00122
; LINE_WIDTH: 0.190815
G1 X114.412 Y125.087 E.00171
M204 S10000
G1 X113.98 Y125.96 F30000
; LINE_WIDTH: 0.0935901
G1 F3600
M204 S1000
G1 X113.826 Y126.154 E.00073
; LINE_WIDTH: 0.142202
G1 X113.673 Y126.349 E.00122
; LINE_WIDTH: 0.190815
G1 X113.52 Y126.543 E.00171
M204 S10000
G1 X113.087 Y127.416 F30000
; LINE_WIDTH: 0.0935907
G1 F3600
M204 S1000
G1 X112.934 Y127.61 E.00073
; LINE_WIDTH: 0.142203
G1 X112.781 Y127.805 E.00122
; LINE_WIDTH: 0.190815
G1 X112.628 Y127.999 E.00171
M204 S10000
G1 X112.195 Y128.872 F30000
; LINE_WIDTH: 0.0935903
G1 F3600
M204 S1000
G1 X112.042 Y129.066 E.00073
; LINE_WIDTH: 0.142202
G1 X111.889 Y129.26 E.00122
; LINE_WIDTH: 0.190815
G1 X111.736 Y129.455 E.00171
M204 S10000
G1 X111.303 Y130.328 F30000
; LINE_WIDTH: 0.0935926
G1 F3600
M204 S1000
G1 X111.15 Y130.522 E.00073
; LINE_WIDTH: 0.142209
G1 X110.997 Y130.716 E.00122
; LINE_WIDTH: 0.190826
G1 X110.843 Y130.91 E.00171
M204 S10000
G1 X110.411 Y131.784 F30000
; LINE_WIDTH: 0.0935927
G1 F3600
M204 S1000
G1 X110.257 Y131.978 E.00073
; LINE_WIDTH: 0.14221
G1 X110.104 Y132.172 E.00122
; LINE_WIDTH: 0.190826
G1 X109.951 Y132.366 E.00171
M204 S10000
G1 X109.518 Y133.24 F30000
; LINE_WIDTH: 0.093616
G1 F3600
M204 S1000
G1 X109.366 Y133.433 E.00072
; LINE_WIDTH: 0.142279
G1 X109.214 Y133.626 E.00121
; LINE_WIDTH: 0.190942
G1 X109.062 Y133.819 E.0017
; LINE_WIDTH: 0.239606
G1 X108.91 Y134.012 E.00218
; LINE_WIDTH: 0.288269
G1 X108.757 Y134.205 E.00267
; LINE_WIDTH: 0.336932
G1 X108.605 Y134.398 E.00316
; LINE_WIDTH: 0.385595
G1 X108.453 Y134.591 E.00365
; CHANGE_LAYER
; Z_HEIGHT: 2.1
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F3600
G1 X108.605 Y134.398 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/25
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.4 I.692 J1.001 P1  F30000
G1 X146.643 Y108.125 Z2.4
G1 X146.21 Y108.49
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F2904
M204 S500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.5 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.5 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.5 F30000
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.5 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2904
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.5 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
G1 F3600
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.5 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z2.1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2904
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.5 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.5 F30000
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.5 F30000
G1 X146.643 Y143.97
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.5 F30000
G1 X106.643 Y143.932
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.5 F30000
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
M73 P98 R1
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.5 F30000
G1 X77.072 Y131.643
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.5 F30000
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.5 F30000
G1 X95.357 Y108.078
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2904
M204 S500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2904
M204 S1000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/25
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.5 I-1.217 J0 P1  F30000
G1 X109.3 Y108.161 Z2.5
G1 X111.357 Y108.027
G1 X146.643 Y108.125
G1 X146.21 Y108.49
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.6 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.6 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.6 F30000
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.6 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2903
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.6 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
G1 F3600
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.6 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2903
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.6 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.6 F30000
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.6 F30000
G1 X146.643 Y143.97
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.6 F30000
G1 X106.643 Y143.932
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.6 F30000
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.6 F30000
G1 X77.072 Y131.643
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.6 F30000
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.6 F30000
G1 X95.357 Y108.078
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/25
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.6 I-1.217 J0 P1  F30000
G1 X109.3 Y108.161 Z2.6
G1 X111.357 Y108.027
G1 X146.643 Y108.125
G1 X146.21 Y108.49
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.1
G1 F2903
M204 S500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.7 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.7 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.7 F30000
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.7 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2903
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.7 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
M73 P98 R0
G1 F3600
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.7 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z2.3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2903
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.7 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.7 F30000
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.7 F30000
G1 X146.643 Y143.97
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.7 F30000
G1 X106.643 Y143.932
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.7 F30000
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.7 F30000
G1 X77.072 Y131.643
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.7 F30000
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.7 F30000
G1 X95.357 Y108.078
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/25
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.7 I-1.217 J0 P1  F30000
G1 X109.3 Y108.161 Z2.7
G1 X111.357 Y108.027
G1 X146.643 Y108.125
G1 X146.21 Y108.49
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
M204 S10000
G1 X146.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X151.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y108.161 Z2.8 F30000
G1 X151.357 Y108.055
G1 X167.357 Y108.125
G1 X167.79 Y108.49
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
G1 F3600
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y108.161 Z2.8 F30000
G1 X162.643 Y108.125
G1 X162.643 Y108
G1 X162.7 Y108
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X167.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y108.161 Z2.8 F30000
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
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
M204 S1000
G1 X179.49 Y116.21 E-.3731
G1 X179.49 Y116.7 E-.1862
G1 X179.49 Y117.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y117.228 Z2.8 F30000
G1 X178.875 Y121.357
G1 X179 Y121.357
G1 X179 Y121.3
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2903
M204 S1000
G1 X179 Y116.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y118.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y118.7 Z2.8 F30000
G1 X178.896 Y121.357
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
; WIPE_START
G1 F3600
M204 S1000
G1 X179.49 Y131.21 E-.3731
G1 X179.49 Y131.7 E-.1862
G1 X179.49 Y132.228 E-.2007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y132.228 Z2.8 F30000
G1 X178.875 Y136.357
G1 X179 Y136.357
G1 X179 Y136.3
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.60292
G1 F2903
M204 S1000
G1 X179 Y131.7 E.10898
; WIPE_START
G1 F6000
G1 X179 Y133.7 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.161 Y133.7 Z2.8 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
M204 S10000
G1 X162.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X167.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X165.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.3 Y144.161 Z2.8 F30000
G1 X162.643 Y143.932
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
M204 S10000
G1 X146.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X151.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X149.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X149.3 Y144.161 Z2.8 F30000
G1 X146.643 Y143.97
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
M204 S10000
G1 X106.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X111.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X109.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.3 Y144.161 Z2.8 F30000
G1 X106.643 Y143.932
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
M204 S10000
G1 X90.7 Y144 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X95.3 Y144 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y144 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y144.161 Z2.8 F30000
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77 Y131.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X77 Y136.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y134.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y134.3 Z2.8 F30000
G1 X77.072 Y131.643
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X77 Y116.7 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X77 Y121.3 E.10898
; WIPE_START
G1 F6000
G1 X77 Y119.3 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.161 Y119.3 Z2.8 F30000
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
M204 S10000
G1 X90.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X95.3 Y108 E.10898
; WIPE_START
G1 F6000
G1 X93.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.3 Y108.161 Z2.8 F30000
G1 X95.357 Y108.078
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F2903
M204 S500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
M204 S10000
G1 X106.7 Y108 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.60294
G1 F2903
M204 S1000
G1 X111.3 Y108 E.10898
; CHANGE_LAYER
; Z_HEIGHT: 2.5
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F6000
G1 X109.3 Y108 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/25
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 7
M204 S10000
G17
G3 Z2.8 I-1.217 J-.001 P1  F30000
G1 X109.3 Y108.098 Z2.8
G1 X111.357 Y108.099
G1 X146.643 Y108.125
G1 X146.21 Y108.49
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X146.21 Y107.51 E.01591
G1 X151.79 Y107.51 E.09061
G1 X151.79 Y108 E.00796
G1 X151.79 Y108.49 E.00796
G1 X146.27 Y108.49 E.08963
; WIPE_START
M204 S1000
G1 X146.21 Y107.51 E-.37311
G1 X147.228 Y107.51 E-.38689
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X147.228 Y107.839 Z2.9 F30000
G1 X151.154 Y107.839
G1 X151.154 Y107.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X151.571 Y108.146 E.00957
G1 X151.132 Y108.271
G1 X150.591 Y107.729 E.01244
G1 X150.027 Y107.729
G1 X150.569 Y108.271 E.01244
G1 X150.005 Y108.271
G1 X149.463 Y107.729 E.01244
G1 X148.9 Y107.729
G1 X149.441 Y108.271 E.01244
G1 X148.878 Y108.271
G1 X148.336 Y107.729 E.01244
G1 X147.773 Y107.729
G1 X148.314 Y108.271 E.01244
G1 X147.751 Y108.271
G1 X147.209 Y107.729 E.01244
G1 X146.645 Y107.729
M73 P99 R0
G1 X147.187 Y108.271 E.01244
M204 S10000
G1 X146.465 Y107.709 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132876
G1 F3600
M204 S1000
G1 X146.465 Y108.291 E.00264
; WIPE_START
G1 X146.465 Y107.709 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X146.643 Y107.875 Z2.9 F30000
G1 X151.357 Y107.888
G1 X167.357 Y108.126
G1 X167.79 Y108.49
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X162.21 Y108.49 E.09061
G1 X162.21 Y107.51 E.01591
G1 X167.79 Y107.51 E.09061
G1 X167.79 Y108 E.00796
G1 X167.79 Y108.43 E.00698
; WIPE_START
M204 S1000
G1 X165.79 Y108.452 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X165.79 Y107.902 Z2.9 F30000
G1 X167.192 Y107.839
G1 X166.935 Y107.839
G1 X166.935 Y107.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X167.477 Y108.271 E.01244
G1 X166.913 Y108.271
G1 X166.372 Y107.729 E.01244
G1 X165.808 Y107.729
G1 X166.35 Y108.271 E.01244
G1 X165.786 Y108.271
G1 X165.244 Y107.729 E.01244
G1 X164.681 Y107.729
G1 X165.222 Y108.271 E.01244
G1 X164.659 Y108.271
G1 X164.117 Y107.729 E.01244
G1 X163.554 Y107.729
G1 X164.095 Y108.271 E.01244
G1 X163.532 Y108.271
G1 X162.99 Y107.729 E.01244
G1 X162.429 Y107.732
G1 X162.968 Y108.271 E.01237
; WIPE_START
M204 S1000
G1 X162.429 Y107.732 E-.28954
G1 X162.99 Y107.729 E-.21308
G1 X163.469 Y108.208 E-.25738
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X163.469 Y108.161 Z2.9 F30000
G1 X178.875 Y116.643
G1 X178.51 Y116.21
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
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
M204 S10000
G1 X178.729 Y116.705 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X179.271 Y117.247 E.01244
G1 X179.271 Y117.81
G1 X178.729 Y117.269 E.01244
G1 X178.729 Y117.832
G1 X179.271 Y118.374 E.01244
G1 X179.271 Y118.938
G1 X178.729 Y118.396 E.01244
G1 X178.729 Y118.96
G1 X179.271 Y119.501 E.01244
G1 X179.271 Y120.065
G1 X178.729 Y119.523 E.01244
G1 X178.729 Y120.087
G1 X179.271 Y120.628 E.01244
G1 X179.271 Y121.192
G1 X178.729 Y120.65 E.01244
G1 E-.8 F1800
M204 S10000
G1 X179.291 Y116.5 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.203318
G1 F3600
M204 S1000
G1 X178.806 Y116.5 E.00359
G1 X178.709 Y116.54 E.00078
G1 E-.8 F1800
M204 S10000
G1 X179.291 Y121.243 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.228153
G1 F3600
M204 S1000
G1 X179.225 Y121.352 E.00107
; LINE_WIDTH: 0.264538
G1 X179.16 Y121.46 E.00125
; LINE_WIDTH: 0.303057
G1 X178.709 Y121.393 E.00523
; WIPE_START
G1 X179.16 Y121.46 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X179.125 Y121.357 Z2.9 F30000
G1 X178.875 Y131.643
G1 X178.51 Y131.21
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X179.49 Y131.21 E.01591
G1 X179.49 Y131.7 E.00796
G1 X179.49 Y136.79 E.08265
G1 X178.51 Y136.79 E.01591
G1 X178.51 Y131.27 E.08963
M204 S10000
G1 X179.271 Y131.901 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X178.799 Y131.429 E.01082
G1 X178.729 Y131.923
G1 X179.271 Y132.464 E.01244
G1 X179.271 Y133.028
G1 X178.729 Y132.486 E.01244
G1 X178.729 Y133.05
G1 X179.271 Y133.591 E.01244
G1 X179.271 Y134.155
G1 X178.729 Y133.613 E.01244
G1 X178.729 Y134.177
G1 X179.271 Y134.719 E.01244
G1 X179.271 Y135.282
G1 X178.729 Y134.741 E.01244
G1 X178.729 Y135.304
G1 X179.271 Y135.846 E.01244
G1 X179.271 Y136.409
G1 X178.729 Y135.868 E.01244
; WIPE_START
M204 S1000
G1 X179.271 Y136.409 E-.29107
G1 X179.271 Y135.846 E-.21417
G1 X178.797 Y135.372 E-.25476
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X178.839 Y135.372 Z2.9 F30000
G1 X162.643 Y143.875
G1 X162.21 Y143.51
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X167.79 Y143.51 E.09061
G1 X167.79 Y144 E.00796
G1 X167.79 Y144.49 E.00796
G1 X162.21 Y144.49 E.09061
G1 X162.21 Y143.57 E.01494
; WIPE_START
M204 S1000
G1 X164.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X164.21 Y143.839 Z2.9 F30000
G1 X166.864 Y143.839
G1 X166.864 Y143.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X167.406 Y144.271 E.01244
G1 X166.842 Y144.271
G1 X166.301 Y143.729 E.01244
G1 X165.737 Y143.729
G1 X166.279 Y144.271 E.01244
G1 X165.715 Y144.271
G1 X165.174 Y143.729 E.01244
G1 X164.61 Y143.729
G1 X165.152 Y144.271 E.01244
G1 X164.588 Y144.271
G1 X164.046 Y143.729 E.01244
G1 X163.483 Y143.729
G1 X164.024 Y144.271 E.01244
G1 X163.461 Y144.271
G1 X162.919 Y143.729 E.01244
G1 X162.429 Y143.803
G1 X162.897 Y144.271 E.01075
G1 E-.8 F1800
M204 S10000
G1 X167.565 Y144.291 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0727399
G1 F3600
M204 S1000
G1 X167.565 Y143.709 E.00121
; WIPE_START
G1 X167.565 Y144.291 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X167.357 Y144.126 Z2.9 F30000
G1 X162.643 Y144.111
G1 X146.643 Y143.875
G1 X146.21 Y143.51
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X151.79 Y143.51 E.09061
G1 X151.79 Y144 E.00796
G1 X151.79 Y144.49 E.00796
G1 X146.21 Y144.49 E.09061
G1 X146.21 Y143.57 E.01494
; WIPE_START
M204 S1000
G1 X148.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X148.21 Y143.839 Z2.9 F30000
G1 X151.083 Y143.839
G1 X151.083 Y143.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X151.571 Y144.217 E.01119
G1 X151.061 Y144.271
G1 X150.52 Y143.729 E.01244
G1 X149.956 Y143.729
G1 X150.498 Y144.271 E.01244
G1 X149.934 Y144.271
G1 X149.393 Y143.729 E.01244
G1 X148.829 Y143.729
G1 X149.371 Y144.271 E.01244
G1 X148.807 Y144.271
G1 X148.265 Y143.729 E.01244
G1 X147.702 Y143.729
G1 X148.243 Y144.271 E.01244
G1 X147.68 Y144.271
G1 X147.138 Y143.729 E.01244
G1 X146.575 Y143.729
G1 X147.116 Y144.271 E.01244
; WIPE_START
M204 S1000
G1 X146.575 Y143.729 E-.29108
G1 X147.138 Y143.729 E-.21417
G1 X147.612 Y144.203 E-.25475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X147.612 Y144.161 Z2.9 F30000
G1 X146.781 Y144.155
G1 X110.595 Y143.902
G1 X106.643 Y143.875
G1 X106.21 Y143.51
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X111.79 Y143.51 E.09061
G1 X111.79 Y144 E.00796
G1 X111.79 Y144.49 E.00796
G1 X106.21 Y144.49 E.09061
G1 X106.21 Y143.57 E.01494
; WIPE_START
M204 S1000
G1 X108.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.21 Y143.839 Z2.9 F30000
G1 X111.067 Y143.839
G1 X111.067 Y143.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X111.571 Y144.233 E.01156
G1 X111.045 Y144.271
G1 X110.504 Y143.729 E.01244
G1 X109.94 Y143.729
G1 X110.482 Y144.271 E.01244
G1 X109.918 Y144.271
G1 X109.376 Y143.729 E.01244
G1 X108.813 Y143.729
G1 X109.355 Y144.271 E.01244
G1 X108.791 Y144.271
G1 X108.249 Y143.729 E.01244
G1 X107.686 Y143.729
G1 X108.227 Y144.271 E.01244
G1 X107.664 Y144.271
G1 X107.122 Y143.729 E.01244
G1 X106.558 Y143.729
G1 X107.1 Y144.271 E.01244
; WIPE_START
M204 S1000
G1 X106.558 Y143.729 E-.29108
G1 X107.122 Y143.729 E-.21417
G1 X107.596 Y144.203 E-.25475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.596 Y144.161 Z2.9 F30000
G1 X106.74 Y144.146
G1 X92.278 Y143.902
G1 X90.643 Y143.902
G1 X90.643 Y143.875
G1 X90.21 Y143.51
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X95.79 Y143.51 E.09061
G1 X95.79 Y144 E.00796
G1 X95.79 Y144.49 E.00796
G1 X90.21 Y144.49 E.09061
G1 X90.21 Y143.57 E.01494
; WIPE_START
M204 S1000
G1 X92.21 Y143.548 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X92.21 Y143.839 Z2.9 F30000
G1 X94.723 Y143.839
G1 X94.723 Y143.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X95.264 Y144.271 E.01244
G1 X94.701 Y144.271
G1 X94.159 Y143.729 E.01244
G1 X93.596 Y143.729
G1 X94.137 Y144.271 E.01244
G1 X93.574 Y144.271
G1 X93.032 Y143.729 E.01244
G1 X92.468 Y143.729
G1 X93.01 Y144.271 E.01244
G1 X92.446 Y144.271
G1 X91.905 Y143.729 E.01244
G1 X91.341 Y143.729
G1 X91.883 Y144.271 E.01244
G1 X91.319 Y144.271
G1 X90.777 Y143.729 E.01244
G1 E-.8 F1800
M204 S10000
G1 X95.466 Y143.709 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.2273
G1 F3600
M204 S1000
G1 X95.489 Y144.189 E.00403
G1 X95.27 Y144.291 E.00202
G1 E-.8 F1800
M204 S10000
G1 X90.742 Y143.709 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.233458
G1 F3600
M204 S1000
G1 X90.527 Y143.827 E.00212
; LINE_WIDTH: 0.272336
G1 X90.579 Y144.291 E.00477
; WIPE_START
G1 X90.527 Y143.827 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X90.643 Y143.875 Z2.9 F30000
G1 X77.125 Y131.643
G1 X77.125 Y131.643
G1 X77.125 Y131.643
G1 X77.49 Y131.21
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X77.49 Y131.7 E.00796
G1 X77.49 Y136.79 E.08265
G1 X76.51 Y136.79 E.01591
G1 X76.51 Y131.21 E.09061
G1 X77.43 Y131.21 E.01494
M204 S10000
G1 X77.271 Y131.913 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X76.787 Y131.429 E.01112
G1 X76.729 Y131.935
G1 X77.271 Y132.477 E.01244
G1 X77.271 Y133.041
G1 X76.729 Y132.499 E.01244
G1 X76.729 Y133.063
G1 X77.271 Y133.604 E.01244
G1 X77.271 Y134.168
G1 X76.729 Y133.626 E.01244
G1 X76.729 Y134.19
G1 X77.271 Y134.731 E.01244
G1 X77.271 Y135.295
G1 X76.729 Y134.753 E.01244
G1 X76.729 Y135.317
G1 X77.271 Y135.859 E.01244
G1 X77.271 Y136.422
G1 X76.729 Y135.881 E.01244
; WIPE_START
M204 S1000
G1 X77.271 Y136.422 E-.29108
G1 X77.271 Y135.859 E-.21417
G1 X76.797 Y135.385 E-.25475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.839 Y135.385 Z2.9 F30000
G1 X76.902 Y132.472
G1 X77.125 Y116.643
G1 X77.49 Y116.21
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X77.49 Y116.7 E.00796
G1 X77.49 Y121.79 E.08265
G1 X76.51 Y121.79 E.01591
G1 X76.51 Y116.21 E.09061
G1 X77.43 Y116.21 E.01494
M204 S10000
G1 X76.729 Y116.718 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X77.271 Y117.26 E.01244
G1 X77.271 Y117.823
G1 X76.729 Y117.282 E.01244
G1 X76.729 Y117.845
G1 X77.271 Y118.387 E.01244
G1 X77.271 Y118.95
G1 X76.729 Y118.409 E.01244
G1 X76.729 Y118.972
G1 X77.271 Y119.514 E.01244
G1 X77.271 Y120.078
G1 X76.729 Y119.536 E.01244
G1 X76.729 Y120.1
G1 X77.271 Y120.641 E.01244
G1 X77.271 Y121.205
G1 X76.729 Y120.663 E.01244
G1 E-.8 F1800
M204 S10000
G1 X77.291 Y116.513 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.214669
G1 F3600
M204 S1000
G1 X76.806 Y116.506 E.00382
G1 X76.709 Y116.729 E.00192
G1 E-.8 F1800
M204 S10000
G1 X77.291 Y121.25 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; LINE_WIDTH: 0.22538
G1 F3600
M204 S1000
G1 X77.228 Y121.358 E.00104
; LINE_WIDTH: 0.256219
G1 X77.166 Y121.466 E.00119
; LINE_WIDTH: 0.29006
G1 X76.709 Y121.405 E.00504
; WIPE_START
G1 X77.166 Y121.466 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.125 Y121.357 Z2.9 F30000
G1 X77.125 Y121.357
G1 X90.643 Y108.125
G1 X90.21 Y108.49
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X90.21 Y107.51 E.01591
G1 X95.79 Y107.51 E.09061
G1 X95.79 Y108 E.00796
G1 X95.79 Y108.49 E.00796
G1 X90.27 Y108.49 E.08963
; WIPE_START
M204 S1000
G1 X90.21 Y107.51 E-.3731
G1 X91.228 Y107.51 E-.3869
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.228 Y107.839 Z2.9 F30000
G1 X94.794 Y107.839
G1 X94.794 Y107.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X95.335 Y108.271 E.01244
G1 X94.772 Y108.271
G1 X94.23 Y107.729 E.01244
G1 X93.666 Y107.729
G1 X94.208 Y108.271 E.01244
G1 X93.644 Y108.271
G1 X93.103 Y107.729 E.01244
G1 X92.539 Y107.729
G1 X93.081 Y108.271 E.01244
G1 X92.517 Y108.271
G1 X91.975 Y107.729 E.01244
G1 X91.412 Y107.729
G1 X91.954 Y108.271 E.01244
G1 X91.39 Y108.271
G1 X90.848 Y107.729 E.01244
G1 X90.429 Y107.874
G1 X90.826 Y108.271 E.00912
G1 E-.8 F1800
M204 S10000
G1 X95.477 Y108.291 Z2.9 F30000
G1 Z2.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.158541
G1 F3600
M204 S1000
G1 X95.524 Y108.177 E.00069
G1 X95.524 Y107.709 E.00261
; WIPE_START
G1 X95.524 Y108.177 E-.60208
G1 X95.477 Y108.291 E-.15792
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.357 Y108.125 Z2.9 F30000
G1 X106.643 Y108.125
G1 X106.21 Y108.49
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.41999
G1 F3600
M204 S500
G1 X106.21 Y107.51 E.01591
G1 X111.79 Y107.51 E.09061
G1 X111.79 Y108 E.00796
G1 X111.79 Y108.49 E.00796
G1 X106.27 Y108.49 E.08963
; WIPE_START
M204 S1000
G1 X106.21 Y107.51 E-.3731
G1 X107.228 Y107.51 E-.3869
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.228 Y107.839 Z2.9 F30000
G1 X111.138 Y107.839
G1 X111.138 Y107.729
G1 Z2.5
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2700
M204 S2000
G1 X111.571 Y108.162 E.00994
G1 X111.116 Y108.271
G1 X110.575 Y107.729 E.01244
G1 X110.011 Y107.729
G1 X110.553 Y108.271 E.01244
G1 X109.989 Y108.271
G1 X109.447 Y107.729 E.01244
G1 X108.884 Y107.729
G1 X109.425 Y108.271 E.01244
G1 X108.862 Y108.271
G1 X108.32 Y107.729 E.01244
G1 X107.756 Y107.729
G1 X108.298 Y108.271 E.01244
G1 X107.735 Y108.271
G1 X107.193 Y107.729 E.01244
G1 X106.629 Y107.729
G1 X107.171 Y108.271 E.01244
M204 S10000
G1 X106.456 Y107.709 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.114086
G1 F3600
M204 S1000
G1 X106.456 Y108.291 E.00219
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F3600
G1 X106.456 Y107.709 E-.76
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

