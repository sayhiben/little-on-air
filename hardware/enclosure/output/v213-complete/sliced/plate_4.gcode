; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 4m 48s; total estimated time: 13m 25s
; total layer number: 29
; total filament length [mm] : 180.09
; total filament volume [cm^3] : 433.16
; total filament weight [g] : 0.55
; model label id: 8,9,10
; object max height: 2.90,2.80,2.80
; filament_density: 1.25,1.25,1.27
; filament_diameter: 1.75,1.75,1.75
; max_z_height: 2.90
; filament: 3
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
; enable_prime_tower = 0
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
M73 P0 R13
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
M620 S2A   ; switch material if AMS exist
    M109 S255
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T2
    G1 X54 F12000
    G1 Y265
    M400
M621 S2A
M620.1 E F99.7797 T270

M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
M73 P4 R12
G1 E50 F200
M400
M104 S255
G92 E0
M73 P36 R8
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S235 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P38 R8
G1 E-0.5 F300

M73 P40 R7
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
M73 P41 R7
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
M73 P42 R7
G1 X230 Y15 F24000
;===== check scanner clarity end =======================

;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X101.2 Y125.8 I46.95 J4.39906
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



;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S255
G1 Z0.2
G0 E2 F300
G0 X240 E15 F1600
G0 Y11 E0.700 F400
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X231 E0.700 F1600
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

    G0 X48.0 E11.9 F1600
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
    G0 X185.000 E9.35441 F1600
    G0 X187 Z0
    G1 F1500.000 E-0.800
    G0 Z1
    G0 X180 Z0.3 F18000

    M900 L1000.0 M1.0
    M900 K0.040
    G0 X45.000 F30000
    G0 Y8.000 F30000
    G1 F1500.000 E0.800
    G1 X65.000 E1.24726 F400
M73 P43 R7
    G1 X70.000 E0.31181 F400
    G1 X75.000 E0.31181 F1600
    G1 X80.000 E0.31181 F400
    G1 X85.000 E0.31181 F1600
    G1 X90.000 E0.31181 F400
    G1 X95.000 E0.31181 F1600
    G1 X100.000 E0.31181 F400
    G1 X105.000 E0.31181 F1600
    G1 X110.000 E0.31181 F400
    G1 X115.000 E0.31181 F1600
M73 P44 R7
    G1 X120.000 E0.31181 F400
    G1 X125.000 E0.31181 F1600
    G1 X130.000 E0.31181 F400
    G1 X135.000 E0.31181 F1600
    G1 X140.000 E0.31181 F400
    G1 X145.000 E0.31181 F1600
    G1 X150.000 E0.31181 F400
M73 P45 R7
    G1 X155.000 E0.31181 F1600
    G1 X160.000 E0.31181 F400
    G1 X165.000 E0.31181 F1600
    G1 X170.000 E0.31181 F400
    G1 X175.000 E0.31181 F1600
    G1 X180.000 E0.31181 F1600
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
    G1 X65.000 E1.24726 F400
    G1 X70.000 E0.31181 F400
    G1 X75.000 E0.31181 F1600
    G1 X80.000 E0.31181 F400
    G1 X85.000 E0.31181 F1600
    G1 X90.000 E0.31181 F400
    G1 X95.000 E0.31181 F1600
    G1 X100.000 E0.31181 F400
    G1 X105.000 E0.31181 F1600
    G1 X110.000 E0.31181 F400
    G1 X115.000 E0.31181 F1600
M73 P46 R7
    G1 X120.000 E0.31181 F400
    G1 X125.000 E0.31181 F1600
M73 P47 R7
    G1 X130.000 E0.31181 F400
    G1 X135.000 E0.31181 F1600
    G1 X140.000 E0.31181 F400
    G1 X145.000 E0.31181 F1600
    G1 X150.000 E0.31181 F400
    G1 X155.000 E0.31181 F1600
    G1 X160.000 E0.31181 F400
    G1 X165.000 E0.31181 F1600
    G1 X170.000 E0.31181 F400
    G1 X175.000 E0.31181 F1600
    G1 X180.000 E0.31181 F1600
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
M73 P48 R6
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
    G1 X65.000 E1.24726 F400
    G1 X70.000 E0.31181 F400
M73 P49 R6
    G1 X75.000 E0.31181 F1600
    G1 X80.000 E0.31181 F400
    G1 X85.000 E0.31181 F1600
    G1 X90.000 E0.31181 F400
    G1 X95.000 E0.31181 F1600
    G1 X100.000 E0.31181 F400
    G1 X105.000 E0.31181 F1600
    G1 X110.000 E0.31181 F400
M73 P50 R6
    G1 X115.000 E0.31181 F1600
    G1 X120.000 E0.31181 F400
    G1 X125.000 E0.31181 F1600
    G1 X130.000 E0.31181 F400
    G1 X135.000 E0.31181 F1600
    G1 X140.000 E0.31181 F400
    G1 X145.000 E0.31181 F1600
    G1 X150.000 E0.31181 F400
    G1 X155.000 E0.31181 F1600
    G1 X160.000 E0.31181 F400
    G1 X165.000 E0.31181 F1600
    G1 X170.000 E0.31181 F400
    G1 X175.000 E0.31181 F1600
    G1 X180.000 E0.31181 F1600
    G1 F1500.000 E-0.800
    G1 X183 Z0.15 F30000
    G1 X185
M73 P51 R6
    G1 Z1.0
    G0 Y6.000 F30000 ; move y to clear pos
    G1 Z0.3

    G0 X45.000 F30000 ; move to start point

M623 ; end of "draw extrinsic para cali paint"


M1002 judge_flag extrude_cali_flag
M622 J0
    G0 X231 Y1.5 F30000
    G0 X18 E14.3 F1600
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
    M980.3 A70.000 B24.9578 C5.000 D99.831 E5.000 F175.000 H1.000 I0.000 J0.020 K0.040
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
    G1 X65.000 E1.24726 F400
    G1 X70.000 E0.31181 F400
    G1 X75.000 E0.31181 F1600
    G1 X80.000 E0.31181 F400
    G1 X85.000 E0.31181 F1600
    G1 X90.000 E0.31181 F400
    G1 X95.000 E0.31181 F1600
    G1 X100.000 E0.31181 F400
    G1 X105.000 E0.31181 F1600
    G1 X110.000 E0.31181 F400
M73 P52 R6
    G1 X115.000 E0.31181 F1600
    G1 X120.000 E0.31181 F400
    G1 X125.000 E0.31181 F1600
    G1 X130.000 E0.31181 F400
    G1 X135.000 E0.31181 F1600

    ; see if extrude cali success, if not ,use default value
    M1002 judge_last_extrude_cali_success
    M622 J0
        M400
        M900 K0.02 M0.033277
    M623

    G1 X140.000 E0.31181 F400
    G1 X145.000 E0.31181 F1600
    G1 X150.000 E0.31181 F400
    G1 X155.000 E0.31181 F1600
    G1 X160.000 E0.31181 F400
    G1 X165.000 E0.31181 F1600
    G1 X170.000 E0.31181 F400
    G1 X175.000 E0.31181 F1600
    G1 X180.000 E0.31181 F400
    G1 X185.000 E0.31181 F1600
    G1 X190.000 E0.31181 F400
    G1 X195.000 E0.31181 F1600
M73 P53 R6
    G1 X200.000 E0.31181 F400
    G1 X205.000 E0.31181 F1600
    G1 X210.000 E0.31181 F400
    G1 X215.000 E0.31181 F1600
    G1 X220.000 E0.31181 F400
    G1 X225.000 E0.31181 F1600
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
G0 X239 E15 F1600
G0 Y12 E0.7 F400
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S180


;VT2 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.1
; LAYER_HEIGHT: 0.1
G1 E-.8 F1800
; layer num/total_layer_count: 1/29
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
G1 X145.6 Y125.121 F30000
M204 S6000
G1 Z.4
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X147.8 Y125.121 E.04158
; object ids of layer 1 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer1 end: 8,9,10
M625
G1 X147.8 Y127.179 E.03891
G1 X145.6 Y127.179 E.04158
M73 P54 R6
G1 X145.6 Y127.6 E.00795
G1 X145.1 Y127.6 E.00945
G1 X145.1 Y127.179 E.00795
G1 X142.2 Y127.179 E.05481
G1 X142.2 Y125.121 E.03891
G1 X145.1 Y125.121 E.05481
G1 X145.1 Y124.503 E.01167
G1 X145.6 Y124.503 E.00945
G1 X145.6 Y125.061 E.01053
G1 E-.8 F1800
M204 S6000
G1 X147.609 Y125.575 Z.5 F30000
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5957
G1 F900
M204 S500
G1 X142.607 Y125.575 E.11344
G1 X142.607 Y126.15 E.01302
M73 P55 R6
G1 X147.393 Y126.15 E.10856
G1 X147.393 Y126.724 E.01302
G1 X142.391 Y126.724 E.11344
; OBJECT_ID: 9
; WIPE_START
G1 X144.391 Y126.724 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S6000
G1 X144.391 Y126.811 Z.5 F30000
G1 X142.568 Y126.453
G1 X133.516 Y125.145
G1 X133.6 Y125.121
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
M73 P55 R5
G1 F900
M204 S500
G1 X135.8 Y125.121 E.04158
M73 P56 R5
G1 X135.8 Y127.179 E.03891
G1 X133.6 Y127.179 E.04158
G1 X133.6 Y127.6 E.00795
G1 X133.1 Y127.6 E.00945
G1 X133.1 Y127.179 E.00795
G1 X130.2 Y127.179 E.05481
M73 P57 R5
G1 X130.2 Y125.121 E.03891
G1 X133.1 Y125.121 E.05481
G1 X133.1 Y124.503 E.01167
G1 X133.6 Y124.503 E.00945
G1 X133.6 Y125.061 E.01053
G1 E-.8 F1800
M204 S6000
G1 X135.609 Y125.575 Z.5 F30000
M73 P60 R5
G1 Z.1
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5957
G1 F900
M204 S500
G1 X130.607 Y125.575 E.11344
G1 X130.607 Y126.15 E.01302
G1 X135.393 Y126.15 E.10856
G1 X135.393 Y126.724 E.01302
G1 X130.391 Y126.724 E.11344
; OBJECT_ID: 8
; WIPE_START
G1 X132.391 Y126.724 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S6000
G1 X132.391 Y126.811 Z.5 F30000
G1 X130.568 Y126.613
M73 P61 R5
G1 X118.051 Y125.855
G1 X117.996 Y125.821
G1 X115.95 Y125.821
G1 X115.95 Y125.728
G1 Z.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X118.45 Y125.728 E.04725
G1 X118.45 Y126.272 E.01029
G1 X115.95 Y126.272 E.04725
G1 X115.95 Y127.029 E.0143
G1 X110.65 Y127.029 E.10017
G1 X110.65 Y127.751 E.01365
G1 X110.15 Y127.751 E.00945
G1 X110.15 Y127.029 E.01365
G1 X101.55 Y127.029 E.16255
G1 X101.55 Y124.971 E.03888
M73 P62 R5
G1 X110.15 Y124.971 E.16255
G1 X110.15 Y124.249 E.01365
G1 X110.65 Y124.249 E.00945
G1 X110.65 Y124.971 E.01365
G1 X115.95 Y124.971 E.10017
G1 X115.95 Y125.668 E.01316
M204 S6000
G1 X115.759 Y125.426 F30000
; FEATURE: Bottom surface
; LINE_WIDTH: 0.59549
G1 F900
M204 S500
G1 X101.957 Y125.426 E.31292
G1 X101.957 Y126 E.01301
G1 X115.304 Y126 E.30261
G1 X115.304 Y126.451 E.01021
G1 X115.543 Y126.451 E.00542
M73 P62 R4
G1 X115.543 Y126.574 E.0028
G1 X101.741 Y126.574 E.31292
G1 E-.8 F1800
M204 S6000
M73 P63 R4
G1 X109.367 Y126.261 Z.5 F30000
M73 P64 R4
G1 X115.711 Y126 Z.5
G1 Z.1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0873402
G1 F900
M204 S500
G1 X118.211 Y126 E.0065
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F900
G1 X116.211 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 2/29
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.5 I1.217 J0 P1  F30000
G1 X116.211 Y125.839 Z.5
G1 X118.157 Y125.93
G1 X130.493 Y125.486
G1 X134.204 Y125.353
G1 X145.231 Y124.956
G1 X145.432 Y124.766
G1 X145.476 Y124.989
G1 X145.74 Y124.938
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X145.781 Y124.938 E.00065
G1 X147.94 Y124.94 E.03398
; object ids of layer 2 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer2 end: 8,9,10
M625
G1 X147.94 Y127.36 E.0381
G1 X145.781 Y127.362 E.03398
G1 X145.74 Y127.362 E.00065
G1 X145.74 Y127.74 E.00595
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.362 E.00595
G1 X144.919 Y127.362 E.00065
G1 X142.06 Y127.36 E.045
G1 X142.06 Y124.94 E.0381
G1 X144.919 Y124.938 E.045
G1 X144.96 Y124.938 E.00065
G1 X144.96 Y124.333 E.00952
G1 X145.74 Y124.333 E.01228
G1 X145.74 Y124.878 E.00857
M204 S10000
G1 X145.581 Y124.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X145.299 Y124.696 E.00497
G1 X145.299 Y125.143 E.00788
G1 X145.401 Y125.143 E.00181
G1 X145.401 Y125.277 E.00236
G1 X147.601 Y125.277 E.03882
G1 X147.601 Y125.59 E.00553
G1 X142.399 Y125.59 E.09181
G1 X142.399 Y126.037 E.00788
G1 X147.601 Y126.037 E.09181
G1 X147.601 Y126.483 E.00788
G1 X142.399 Y126.483 E.09181
G1 X142.399 Y126.93 E.00788
G1 X147.601 Y126.93 E.09181
G1 X147.601 Y127.023 E.00164
G1 X145.401 Y127.023 E.03882
G1 X145.401 Y127.377 E.00625
G1 X145.119 Y127.377 E.00497
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.377 E-.10711
G1 X145.401 Y127.023 E-.13448
G1 X146.766 Y127.023 E-.51842
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.766 Y126.929 Z.6 F30000
G1 X142.493 Y126.339
G1 X133.476 Y124.989
G1 X133.74 Y124.938
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X133.781 Y124.938 E.00065
G1 X135.94 Y124.94 E.03398
G1 X135.94 Y127.36 E.0381
G1 X133.781 Y127.362 E.03398
G1 X133.74 Y127.362 E.00065
G1 X133.74 Y127.74 E.00595
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.362 E.00595
G1 X132.919 Y127.362 E.00065
G1 X130.06 Y127.36 E.045
M73 P65 R4
G1 X130.06 Y124.94 E.0381
G1 X132.919 Y124.938 E.045
G1 X132.96 Y124.938 E.00065
G1 X132.96 Y124.333 E.00952
G1 X133.74 Y124.333 E.01228
G1 X133.74 Y124.878 E.00857
M204 S10000
G1 X133.581 Y124.696 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46826
G1 F1200
M204 S1000
G1 X133.299 Y124.696 E.00497
G1 X133.299 Y125.143 E.00788
G1 X133.401 Y125.143 E.00181
G1 X133.401 Y125.277 E.00236
G1 X135.601 Y125.277 E.03882
G1 X135.601 Y125.59 E.00553
G1 X130.399 Y125.59 E.09181
G1 X130.399 Y126.037 E.00788
G1 X135.601 Y126.037 E.09181
G1 X135.601 Y126.483 E.00788
G1 X130.399 Y126.483 E.09181
G1 X130.399 Y126.93 E.00788
G1 X135.601 Y126.93 E.09181
G1 X135.601 Y127.023 E.00164
G1 X133.401 Y127.023 E.03882
G1 X133.401 Y127.377 E.00625
G1 X133.119 Y127.377 E.00497
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.377 E-.10711
G1 X133.401 Y127.023 E-.13448
G1 X134.766 Y127.023 E-.51842
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.766 Y126.929 Z.6 F30000
G1 X130.493 Y126.674
G1 X116.131 Y125.839
G1 X116.131 Y125.499
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X118.59 Y125.499 E.03871
G1 X118.59 Y125.547 E.00076
G1 X118.59 Y126.453 E.01427
G1 X118.59 Y126.501 E.00076
G1 X116.131 Y126.501 E.03871
G1 X116.09 Y126.501 E.00065
G1 X116.09 Y127.21 E.01115
G1 X110.831 Y127.211 E.08278
G1 X110.79 Y127.211 E.00065
G1 X110.79 Y127.919 E.01115
G1 X110.01 Y127.919 E.01228
G1 X110.01 Y127.211 E.01115
G1 X109.969 Y127.211 E.00065
G1 X101.41 Y127.21 E.13473
G1 X101.41 Y124.79 E.03808
G1 X109.969 Y124.789 E.13473
G1 X110.01 Y124.789 E.00065
G1 X110.01 Y124.081 E.01115
G1 X110.79 Y124.081 E.01228
G1 X110.79 Y124.789 E.01115
G1 X110.831 Y124.789 E.00065
G1 X116.09 Y124.79 E.08278
G1 X116.09 Y125.48 E.01085
M204 S10000
G1 X115.883 Y126 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.61056
G1 F1200
M204 S1000
G1 X118.383 Y126 E.05817
; WIPE_START
G1 X116.383 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.383 Y125.839 Z.6 F30000
G1 X115.749 Y125.839
G1 X111.321 Y125.221
G1 X110.561 Y125.018
G1 X110.422 Y124.498
G1 X110.629 Y124.443
G1 Z.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P66 R4
G1 F1200
M204 S1000
G1 X110.364 Y124.443 E.00449
G1 X110.364 Y124.888 E.00753
G1 X110.436 Y124.888 E.00123
G1 X110.436 Y125.142 E.00431
G1 X115.736 Y125.142 E.08971
G1 X115.736 Y125.333 E.00322
G1 X101.764 Y125.333 E.2365
G1 X101.764 Y125.778 E.00753
G1 X115.53 Y125.778 E.233
G1 X115.53 Y126.223 E.00753
G1 X101.764 Y126.223 E.233
G1 X101.764 Y126.668 E.00753
G1 X115.736 Y126.668 E.2365
G1 X115.736 Y126.858 E.00322
G1 X110.436 Y126.858 E.08971
G1 X110.436 Y127.112 E.00431
G1 X110.364 Y127.112 E.00123
G1 X110.364 Y127.557 E.00753
G1 X110.629 Y127.557 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 0.3
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y127.557 E-.10083
G1 X110.364 Y127.112 E-.1691
G1 X110.436 Y127.112 E-.02755
G1 X110.436 Y126.858 E-.09684
G1 X111.399 Y126.858 E-.36568
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 3/29
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I1.217 J0 P1  F30000
G1 X111.399 Y126.813 Z.6
G1 X115.67 Y126.615
G1 X130.493 Y125.771
G1 X135.507 Y125.485
G1 X145.229 Y124.932
G1 X145.434 Y124.742
G1 X145.476 Y124.955
G1 X145.74 Y124.903
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.903 E.03463
; object ids of layer 3 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer3 end: 8,9,10
M625
G1 X147.94 Y127.397 E.03926
G1 X145.74 Y127.397 E.03463
G1 X145.74 Y127.74 E.0054
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.397 E.0054
G1 X142.06 Y127.397 E.04565
G1 X142.06 Y124.903 E.03926
G1 X144.96 Y124.903 E.04565
G1 X144.96 Y124.309 E.00935
G1 X145.74 Y124.309 E.01228
G1 X145.74 Y124.843 E.00841
M204 S10000
G1 X145.581 Y124.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X145.299 Y124.674 E.00501
G1 X145.299 Y125.124 E.00801
G1 X145.401 Y125.124 E.00182
G1 X145.401 Y125.242 E.0021
G1 X147.601 Y125.242 E.03913
G1 X147.601 Y125.574 E.00591
G1 X142.399 Y125.574 E.09252
G1 X142.399 Y126.025 E.00801
G1 X147.601 Y126.025 E.09252
G1 X147.601 Y126.475 E.00801
G1 X142.399 Y126.475 E.09252
G1 X142.399 Y126.925 E.00801
G1 X147.601 Y126.925 E.09252
G1 X147.601 Y127.058 E.00237
G1 X145.401 Y127.058 E.03913
G1 X145.401 Y127.375 E.00564
G1 X145.119 Y127.375 E.00501
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.375 E-.10711
G1 X145.401 Y127.058 E-.12052
G1 X146.802 Y127.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.802 Y126.964 Z.7 F30000
G1 X142.493 Y126.347
G1 X133.476 Y124.955
G1 X133.74 Y124.903
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.903 E.03463
G1 X135.94 Y127.397 E.03926
G1 X133.74 Y127.397 E.03463
G1 X133.74 Y127.74 E.0054
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.397 E.0054
G1 X130.06 Y127.397 E.04565
G1 X130.06 Y124.903 E.03926
G1 X132.96 Y124.903 E.04565
G1 X132.96 Y124.309 E.00935
G1 X133.74 Y124.309 E.01228
G1 X133.74 Y124.843 E.00841
M204 S10000
G1 X133.581 Y124.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47174
G1 F1200
M204 S1000
G1 X133.299 Y124.674 E.00501
G1 X133.299 Y125.124 E.00801
G1 X133.401 Y125.124 E.00182
G1 X133.401 Y125.242 E.0021
G1 X135.601 Y125.242 E.03913
G1 X135.601 Y125.574 E.00591
G1 X130.399 Y125.574 E.09252
G1 X130.399 Y126.025 E.00801
G1 X135.601 Y126.025 E.09252
G1 X135.601 Y126.475 E.00801
G1 X130.399 Y126.475 E.09252
G1 X130.399 Y126.925 E.00801
G1 X135.601 Y126.925 E.09252
G1 X135.601 Y127.058 E.00237
M73 P67 R4
G1 X133.401 Y127.058 E.03913
G1 X133.401 Y127.375 E.00564
G1 X133.119 Y127.375 E.00501
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.375 E-.10711
G1 X133.401 Y127.058 E-.12052
G1 X134.802 Y127.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.802 Y126.964 Z.7 F30000
G1 X130.493 Y126.683
G1 X116.131 Y125.839
G1 X116.131 Y125.431
G1 Z.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X118.59 Y125.431 E.03871
G1 X118.59 Y125.458 E.00042
G1 X118.59 Y126.542 E.01707
G1 X118.59 Y126.569 E.00042
G1 X116.131 Y126.569 E.03871
G1 X116.09 Y126.569 E.00065
G1 X116.09 Y127.246 E.01066
G1 X110.79 Y127.246 E.08343
G1 X110.79 Y127.943 E.01097
G1 X110.01 Y127.943 E.01228
G1 X110.01 Y127.246 E.01097
G1 X101.41 Y127.246 E.13537
G1 X101.41 Y124.754 E.03923
G1 X110.01 Y124.754 E.13537
G1 X110.01 Y124.057 E.01097
G1 X110.79 Y124.057 E.01228
G1 X110.79 Y124.754 E.01097
G1 X116.09 Y124.754 E.08343
G1 X116.09 Y125.412 E.01036
; WIPE_START
M204 S1000
G1 X118.09 Y125.427 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.068 Y125.842 Z.7 F30000
G1 X115.682 Y125.839
G1 X111.321 Y125.187
G1 X110.561 Y124.983
G1 X110.425 Y124.476
G1 X110.629 Y124.422
G1 Z.3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y124.422 E.00449
G1 X110.364 Y124.873 E.00763
G1 X110.436 Y124.873 E.00123
G1 X110.436 Y125.108 E.00398
G1 X115.736 Y125.108 E.08971
G1 X115.736 Y125.324 E.00366
G1 X101.764 Y125.324 E.2365
G1 X101.764 Y125.775 E.00763
G1 X118.236 Y125.785 E.27881
G1 X118.236 Y126.215 E.00729
G1 X101.764 Y126.225 E.27881
G1 X101.764 Y126.676 E.00763
G1 X115.736 Y126.676 E.2365
G1 X115.736 Y126.892 E.00366
G1 X110.436 Y126.892 E.08971
G1 X110.436 Y127.127 E.00398
G1 X110.364 Y127.127 E.00123
G1 X110.364 Y127.578 E.00763
G1 X110.629 Y127.578 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y127.578 E-.10083
G1 X110.364 Y127.127 E-.17136
G1 X110.436 Y127.127 E-.02755
G1 X110.436 Y126.892 E-.08929
G1 X111.412 Y126.892 E-.37096
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 4/29
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S76.5
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.7 I1.217 J0 P1  F30000
G1 X111.412 Y126.84 Z.7
G1 X115.657 Y126.643
G1 X130.493 Y125.772
G1 X135.507 Y125.477
G1 X145.229 Y124.906
G1 X145.435 Y124.723
G1 X145.476 Y124.929
G1 X145.74 Y124.876
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.876 E.03463
; object ids of layer 4 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer4 end: 8,9,10
M625
G1 X147.94 Y127.424 E.04011
G1 X145.74 Y127.424 E.03463
G1 X145.74 Y127.74 E.00498
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.424 E.00498
G1 X142.06 Y127.424 E.04565
G1 X142.06 Y124.876 E.04011
G1 X144.96 Y124.876 E.04565
G1 X144.96 Y124.29 E.00923
G1 X145.74 Y124.29 E.01228
G1 X145.74 Y124.816 E.00828
M204 S10000
G1 X145.581 Y124.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X145.299 Y124.656 E.00504
G1 X145.299 Y125.109 E.00811
G1 X145.401 Y125.109 E.00183
G1 X145.401 Y125.215 E.0019
G1 X147.601 Y125.215 E.03937
G1 X147.601 Y125.562 E.00621
G1 X142.399 Y125.562 E.09309
G1 X142.399 Y126.015 E.00811
G1 X147.601 Y126.015 E.09309
G1 X147.601 Y126.468 E.00811
G1 X142.399 Y126.468 E.09309
G1 X142.399 Y126.921 E.00811
G1 X147.601 Y126.921 E.09309
G1 X147.601 Y127.085 E.00294
G1 X145.401 Y127.085 E.03937
G1 X145.401 Y127.374 E.00517
G1 X145.119 Y127.374 E.00504
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.374 E-.10711
M73 P68 R4
G1 X145.401 Y127.085 E-.10977
G1 X146.831 Y127.085 E-.54312
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.831 Y126.991 Z.8 F30000
G1 X142.493 Y126.353
G1 X133.476 Y124.929
G1 X133.74 Y124.876
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.876 E.03463
G1 X135.94 Y127.424 E.04011
G1 X133.74 Y127.424 E.03463
G1 X133.74 Y127.74 E.00498
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.424 E.00498
G1 X130.06 Y127.424 E.04565
G1 X130.06 Y124.876 E.04011
G1 X132.96 Y124.876 E.04565
G1 X132.96 Y124.29 E.00923
G1 X133.74 Y124.29 E.01228
G1 X133.74 Y124.816 E.00828
M204 S10000
G1 X133.581 Y124.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4745
G1 F1200
M204 S1000
G1 X133.299 Y124.656 E.00504
G1 X133.299 Y125.109 E.00811
G1 X133.401 Y125.109 E.00183
G1 X133.401 Y125.215 E.0019
G1 X135.601 Y125.215 E.03937
G1 X135.601 Y125.562 E.00621
G1 X130.399 Y125.562 E.09309
G1 X130.399 Y126.015 E.00811
G1 X135.601 Y126.015 E.09309
G1 X135.601 Y126.468 E.00811
G1 X130.399 Y126.468 E.09309
G1 X130.399 Y126.921 E.00811
G1 X135.601 Y126.921 E.09309
G1 X135.601 Y127.085 E.00294
G1 X133.401 Y127.085 E.03937
G1 X133.401 Y127.374 E.00517
G1 X133.119 Y127.374 E.00504
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.374 E-.10711
G1 X133.401 Y127.085 E-.10977
G1 X134.831 Y127.085 E-.54312
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.831 Y126.991 Z.8 F30000
G1 X130.493 Y126.69
G1 X116.131 Y125.815
G1 X116.131 Y125.382
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X118.59 Y125.382 E.03871
G1 X118.59 Y125.39 E.00013
G1 X118.59 Y126.61 E.01921
G1 X118.59 Y126.618 E.00013
G1 X116.131 Y126.618 E.03871
G1 X116.09 Y126.618 E.00065
G1 X116.09 Y127.273 E.01031
G1 X110.79 Y127.273 E.08343
G1 X110.79 Y127.962 E.01083
G1 X110.01 Y127.962 E.01228
G1 X110.01 Y127.273 E.01083
G1 X101.41 Y127.273 E.13537
G1 X101.41 Y124.727 E.04009
G1 X110.01 Y124.727 E.13537
G1 X110.01 Y124.038 E.01083
G1 X110.79 Y124.038 E.01228
G1 X110.79 Y124.727 E.01083
G1 X116.09 Y124.727 E.08343
G1 X116.09 Y125.363 E.01001
; WIPE_START
M204 S1000
G1 X118.09 Y125.378 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.09 Y125.815 Z.8 F30000
G1 X115.657 Y125.815
G1 X111.321 Y125.16
G1 X110.561 Y124.956
G1 X110.431 Y124.471
G1 X110.431 Y124.471
G1 X110.629 Y124.406
G1 Z.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y124.406 E.00449
G1 X110.364 Y124.861 E.00771
G1 X110.436 Y124.861 E.00123
M73 P69 R4
G1 X110.436 Y125.08 E.00371
G1 X115.736 Y125.08 E.08971
G1 X115.736 Y125.317 E.004
G1 X101.764 Y125.317 E.2365
G1 X101.764 Y125.772 E.00771
G1 X118.236 Y125.772 E.27881
G1 X118.236 Y126.228 E.00771
G1 X101.764 Y126.228 E.27881
G1 X101.764 Y126.683 E.00771
G1 X115.736 Y126.683 E.2365
G1 X115.736 Y126.92 E.004
G1 X110.436 Y126.92 E.08971
G1 X110.436 Y127.139 E.00371
G1 X110.364 Y127.139 E.00123
G1 X110.364 Y127.594 E.00771
G1 X110.629 Y127.594 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 0.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y127.594 E-.10083
G1 X110.364 Y127.139 E-.17309
G1 X110.436 Y127.139 E-.02755
G1 X110.436 Y126.92 E-.08329
G1 X111.424 Y126.92 E-.37523
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 5/29
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.8 I1.217 J0 P1  F30000
G1 X111.424 Y126.861 Z.8
G1 X115.657 Y126.665
G1 X130.493 Y125.773
G1 X135.507 Y125.471
G1 X145.229 Y124.887
G1 X145.435 Y124.708
G1 X145.475 Y124.909
G1 X145.74 Y124.856
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.856 E.03463
; object ids of layer 5 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer5 end: 8,9,10
M625
G1 X147.94 Y127.444 E.04074
G1 X145.74 Y127.444 E.03463
G1 X145.74 Y127.74 E.00466
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.444 E.00466
G1 X142.06 Y127.444 E.04565
G1 X142.06 Y124.856 E.04074
G1 X144.96 Y124.856 E.04565
G1 X144.96 Y124.275 E.00914
G1 X145.74 Y124.275 E.01228
G1 X145.74 Y124.796 E.00819
M204 S10000
G1 X145.581 Y124.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X145.299 Y124.642 E.00507
G1 X145.299 Y125.097 E.00818
G1 X145.401 Y125.097 E.00184
G1 X145.401 Y125.195 E.00175
G1 X147.601 Y125.195 E.03955
G1 X147.601 Y125.553 E.00644
G1 X142.399 Y125.553 E.09352
G1 X142.399 Y126.008 E.00818
G1 X147.601 Y126.008 E.09352
G1 X147.601 Y126.463 E.00818
G1 X142.399 Y126.463 E.09352
G1 X142.399 Y126.918 E.00818
G1 X147.601 Y126.918 E.09352
G1 X147.601 Y127.105 E.00337
G1 X145.401 Y127.105 E.03955
G1 X145.401 Y127.373 E.00481
G1 X145.119 Y127.373 E.00507
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.373 E-.10711
G1 X145.401 Y127.105 E-.10167
G1 X146.852 Y127.105 E-.55122
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.852 Y127.011 Z.9 F30000
G1 X142.493 Y126.358
G1 X133.475 Y124.909
G1 X133.74 Y124.856
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.856 E.03463
G1 X135.94 Y127.444 E.04074
G1 X133.74 Y127.444 E.03463
G1 X133.74 Y127.74 E.00466
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.444 E.00466
G1 X130.06 Y127.444 E.04565
G1 X130.06 Y124.856 E.04074
G1 X132.96 Y124.856 E.04565
G1 X132.96 Y124.275 E.00914
G1 X133.74 Y124.275 E.01228
G1 X133.74 Y124.796 E.00819
M204 S10000
G1 X133.581 Y124.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47657
G1 F1200
M204 S1000
G1 X133.299 Y124.642 E.00507
G1 X133.299 Y125.097 E.00818
G1 X133.401 Y125.097 E.00184
G1 X133.401 Y125.195 E.00175
G1 X135.601 Y125.195 E.03955
G1 X135.601 Y125.553 E.00644
G1 X130.399 Y125.553 E.09352
G1 X130.399 Y126.008 E.00818
G1 X135.601 Y126.008 E.09352
G1 X135.601 Y126.463 E.00818
M73 P70 R4
G1 X130.399 Y126.463 E.09352
G1 X130.399 Y126.918 E.00818
G1 X135.601 Y126.918 E.09352
G1 X135.601 Y127.105 E.00337
G1 X133.401 Y127.105 E.03955
G1 X133.401 Y127.373 E.00481
M73 P70 R3
G1 X133.119 Y127.373 E.00507
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.373 E-.10711
G1 X133.401 Y127.105 E-.10167
G1 X134.852 Y127.105 E-.55122
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.852 Y127.011 Z.9 F30000
G1 X130.493 Y127.001
G1 X116.09 Y126.221
G1 X116.09 Y126.654
G1 Z.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.293 E.01007
G1 X110.79 Y127.293 E.08343
G1 X110.79 Y127.975 E.01073
G1 X110.01 Y127.975 E.01228
G1 X110.01 Y127.293 E.01073
G1 X101.41 Y127.293 E.13537
G1 X101.41 Y124.707 E.04072
G1 X110.01 Y124.707 E.13537
G1 X110.01 Y124.025 E.01073
G1 X110.79 Y124.025 E.01228
G1 X110.79 Y124.707 E.01073
G1 X116.09 Y124.707 E.08343
G1 X116.09 Y125.346 E.01007
G1 X118.59 Y125.346 E.03935
G1 X118.59 Y126.654 E.02059
G1 X116.15 Y126.654 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.293 E-.24405
G1 X114.732 Y127.293 E-.51595
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.732 Y126.861 Z.9 F30000
G1 X111.321 Y126.861
G1 X110.561 Y127.064
G1 X110.433 Y127.542
G1 X110.433 Y127.542
G1 X110.629 Y127.606
G1 Z.5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.606 E.00449
G1 X110.364 Y127.147 E.00777
G1 X110.436 Y127.147 E.00123
G1 X110.436 Y126.94 E.00351
G1 X115.736 Y126.94 E.08971
G1 X115.736 Y126.688 E.00425
G1 X101.764 Y126.688 E.2365
G1 X101.764 Y126.229 E.00777
G1 X118.236 Y126.229 E.27881
G1 X118.236 Y125.771 E.00777
G1 X101.764 Y125.771 E.27881
G1 X101.764 Y125.312 E.00777
G1 X115.736 Y125.312 E.2365
G1 X115.736 Y125.06 E.00426
G1 X110.436 Y125.06 E.08971
G1 X110.436 Y124.853 E.00351
G1 X110.364 Y124.853 E.00123
G1 X110.364 Y124.394 E.00777
G1 X110.629 Y124.394 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y124.394 E-.10083
G1 X110.364 Y124.853 E-.17437
G1 X110.436 Y124.853 E-.02755
G1 X110.436 Y125.06 E-.07882
G1 X111.432 Y125.06 E-.37843
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 6/29
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M106 S73.95
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.9 I-1.217 J0 P1  F30000
G1 X111.432 Y125.126 Z.9
G1 X133.219 Y124.922
G1 X133.48 Y124.92
G1 X145.235 Y124.846
G1 X145.436 Y124.698
G1 X145.475 Y124.896
G1 X145.74 Y124.843
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.843 E.03463
; object ids of layer 6 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer6 end: 8,9,10
M625
G1 X147.94 Y127.457 E.04116
G1 X145.74 Y127.457 E.03463
G1 X145.74 Y127.74 E.00445
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.457 E.00445
G1 X142.06 Y127.457 E.04565
G1 X142.06 Y124.843 E.04116
G1 X144.96 Y124.843 E.04565
G1 X144.96 Y124.265 E.00909
G1 X145.74 Y124.265 E.01228
G1 X145.74 Y124.783 E.00814
M204 S10000
G1 X145.581 Y124.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
M73 P71 R3
G1 X145.299 Y124.605 E.00445
G1 X145.299 Y125.004 E.0063
G1 X145.401 Y125.004 E.00162
G1 X145.401 Y125.181 E.0028
G1 X147.601 Y125.181 E.03471
G1 X147.601 Y125.404 E.0035
G1 X142.399 Y125.404 E.08208
G1 X142.399 Y125.803 E.0063
G1 X147.601 Y125.803 E.08208
G1 X147.601 Y126.202 E.0063
G1 X142.399 Y126.202 E.08208
G1 X142.399 Y126.602 E.0063
G1 X147.601 Y126.602 E.08208
G1 X147.601 Y127.001 E.0063
G1 X142.399 Y127.001 E.08208
G1 X142.399 Y127.119 E.00185
G1 X145.299 Y127.119 E.04575
G1 X145.299 Y127.401 E.00445
G1 X145.581 Y127.401 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X145.299 Y127.401 E-.10711
G1 X145.299 Y127.119 E-.10725
G1 X143.863 Y127.119 E-.54564
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X143.863 Y127.024 Z1 F30000
G1 X142.493 Y126.81
G1 X133.475 Y124.896
G1 X133.74 Y124.843
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.843 E.03463
G1 X135.94 Y127.457 E.04116
G1 X133.74 Y127.457 E.03463
G1 X133.74 Y127.74 E.00445
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.457 E.00445
G1 X130.06 Y127.457 E.04565
G1 X130.06 Y124.843 E.04116
G1 X132.96 Y124.843 E.04565
G1 X132.96 Y124.265 E.00909
G1 X133.74 Y124.265 E.01228
G1 X133.74 Y124.783 E.00814
M204 S10000
G1 X133.581 Y124.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4209
G1 F1200
M204 S1000
G1 X133.299 Y124.605 E.00445
G1 X133.299 Y125.004 E.0063
G1 X133.401 Y125.004 E.00162
G1 X133.401 Y125.181 E.0028
G1 X135.601 Y125.181 E.03471
G1 X135.601 Y125.404 E.0035
G1 X130.399 Y125.404 E.08208
G1 X130.399 Y125.803 E.0063
G1 X135.601 Y125.803 E.08208
G1 X135.601 Y126.202 E.0063
G1 X130.399 Y126.202 E.08208
G1 X130.399 Y126.602 E.0063
G1 X135.601 Y126.602 E.08208
G1 X135.601 Y127.001 E.0063
G1 X130.399 Y127.001 E.08208
G1 X130.399 Y127.119 E.00185
G1 X133.299 Y127.119 E.04575
G1 X133.299 Y127.401 E.00445
G1 X133.581 Y127.401 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X133.299 Y127.401 E-.10711
G1 X133.299 Y127.119 E-.10725
G1 X131.863 Y127.119 E-.54564
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X131.863 Y127.024 Z1 F30000
G1 X130.493 Y126.957
G1 X116.09 Y126.244
G1 X116.09 Y126.677
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.307 E.00991
G1 X110.79 Y127.307 E.08343
G1 X110.79 Y127.984 E.01066
G1 X110.01 Y127.984 E.01228
G1 X110.01 Y127.307 E.01066
G1 X101.41 Y127.307 E.13537
G1 X101.41 Y124.693 E.04114
G1 X110.01 Y124.693 E.13537
G1 X110.01 Y124.016 E.01066
G1 X110.79 Y124.016 E.01228
M73 P72 R3
G1 X110.79 Y124.693 E.01066
G1 X116.09 Y124.693 E.08343
G1 X116.09 Y125.323 E.00991
G1 X118.59 Y125.323 E.03935
G1 X118.59 Y126.677 E.02132
G1 X116.15 Y126.677 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.307 E-.24032
G1 X114.722 Y127.307 E-.51968
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.723 Y126.874 Z1 F30000
G1 X111.321 Y126.874
G1 X110.561 Y127.077
G1 X110.434 Y127.551
G1 X110.434 Y127.551
G1 X110.629 Y127.614
G1 Z.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.614 E.00449
G1 X110.364 Y127.153 E.0078
G1 X110.436 Y127.153 E.00123
G1 X110.436 Y126.953 E.00338
G1 X115.736 Y126.953 E.08971
G1 X115.736 Y126.692 E.00442
G1 X101.764 Y126.692 E.2365
G1 X101.764 Y126.231 E.0078
G1 X118.236 Y126.231 E.27881
G1 X118.236 Y125.769 E.0078
G1 X101.764 Y125.769 E.27881
G1 X101.764 Y125.308 E.0078
G1 X115.736 Y125.308 E.2365
G1 X115.736 Y125.047 E.00442
G1 X110.436 Y125.047 E.08971
G1 X110.436 Y124.847 E.00338
G1 X110.364 Y124.847 E.00123
G1 X110.364 Y124.386 E.0078
G1 X110.629 Y124.386 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 0.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y124.386 E-.10083
G1 X110.364 Y124.847 E-.17523
G1 X110.436 Y124.847 E-.02755
G1 X110.436 Y125.047 E-.07593
G1 X111.437 Y125.047 E-.38046
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 7/29
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1 I-1.217 J0 P1  F30000
G1 X111.437 Y125.12 Z1
G1 X133.22 Y124.913
G1 X133.48 Y124.911
G1 X145.235 Y124.839
G1 X145.436 Y124.694
G1 X145.475 Y124.889
G1 X145.74 Y124.836
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.836 E.03463
; object ids of layer 7 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer7 end: 8,9,10
M625
G1 X147.94 Y127.464 E.04136
G1 X145.74 Y127.464 E.03463
G1 X145.74 Y127.74 E.00435
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.464 E.00435
G1 X142.06 Y127.464 E.04565
G1 X142.06 Y124.836 E.04136
G1 X144.96 Y124.836 E.04565
G1 X144.96 Y124.261 E.00906
G1 X145.74 Y124.261 E.01228
G1 X145.74 Y124.776 E.00811
M204 S10000
G1 X145.581 Y124.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X145.299 Y124.6 E.00445
G1 X145.299 Y125 E.00632
G1 X145.401 Y125 E.00162
G1 X145.401 Y125.175 E.00276
G1 X147.601 Y125.175 E.03476
G1 X147.601 Y125.4 E.00356
G1 X142.399 Y125.4 E.0822
G1 X142.399 Y125.8 E.00632
G1 X147.601 Y125.8 E.0822
G1 X147.601 Y126.2 E.00632
G1 X142.399 Y126.2 E.0822
G1 X142.399 Y126.6 E.00632
G1 X147.601 Y126.6 E.0822
G1 X147.601 Y127 E.00632
G1 X142.399 Y127 E.0822
G1 X142.399 Y127.125 E.00197
G1 X145.299 Y127.125 E.04582
G1 X145.299 Y127.4 E.00435
G1 X145.581 Y127.4 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X145.299 Y127.4 E-.10711
G1 X145.299 Y127.125 E-.10463
G1 X143.856 Y127.125 E-.54826
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X143.856 Y127.031 Z1.1 F30000
G1 X142.493 Y126.817
G1 X133.475 Y124.889
G1 X133.74 Y124.836
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
M73 P73 R3
G1 X135.94 Y124.836 E.03463
G1 X135.94 Y127.464 E.04136
G1 X133.74 Y127.464 E.03463
G1 X133.74 Y127.74 E.00435
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.464 E.00435
G1 X130.06 Y127.464 E.04565
G1 X130.06 Y124.836 E.04136
G1 X132.96 Y124.836 E.04565
G1 X132.96 Y124.261 E.00906
G1 X133.74 Y124.261 E.01228
G1 X133.74 Y124.776 E.00811
M204 S10000
G1 X133.581 Y124.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42148
G1 F1200
M204 S1000
G1 X133.299 Y124.6 E.00445
G1 X133.299 Y125 E.00632
G1 X133.401 Y125 E.00162
G1 X133.401 Y125.175 E.00276
G1 X135.601 Y125.175 E.03476
G1 X135.601 Y125.4 E.00356
G1 X130.399 Y125.4 E.0822
G1 X130.399 Y125.8 E.00632
G1 X135.601 Y125.8 E.0822
G1 X135.601 Y126.2 E.00632
G1 X130.399 Y126.2 E.0822
G1 X130.399 Y126.6 E.00632
G1 X135.601 Y126.6 E.0822
G1 X135.601 Y127 E.00632
G1 X130.399 Y127 E.0822
G1 X130.399 Y127.125 E.00197
G1 X133.299 Y127.125 E.04582
G1 X133.299 Y127.4 E.00435
G1 X133.581 Y127.4 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X133.299 Y127.4 E-.10711
G1 X133.299 Y127.125 E-.10463
G1 X131.856 Y127.125 E-.54826
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X131.856 Y127.031 Z1.1 F30000
G1 X130.493 Y126.964
G1 X116.09 Y126.255
G1 X116.09 Y126.688
G1 Z.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.313 E.00985
G1 X110.79 Y127.313 E.08343
G1 X110.79 Y127.989 E.01063
G1 X110.01 Y127.989 E.01228
G1 X110.01 Y127.313 E.01063
G1 X101.41 Y127.313 E.13537
G1 X101.41 Y124.687 E.04135
G1 X110.01 Y124.687 E.13537
G1 X110.01 Y124.011 E.01063
G1 X110.79 Y124.011 E.01228
G1 X110.79 Y124.687 E.01063
G1 X116.09 Y124.687 E.08343
G1 X116.09 Y125.312 E.00985
G1 X118.59 Y125.312 E.03935
G1 X118.59 Y126.688 E.02165
G1 X116.15 Y126.688 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.313 E-.23878
G1 X114.718 Y127.313 E-.52122
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.718 Y126.88 Z1.1 F30000
G1 X111.321 Y126.88
G1 X110.561 Y127.084
G1 X110.434 Y127.556
G1 X110.434 Y127.556
G1 X110.629 Y127.618
G1 Z.7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.618 E.00449
G1 X110.364 Y127.156 E.00783
G1 X110.436 Y127.156 E.00123
G1 X110.436 Y126.96 E.00332
G1 X115.736 Y126.96 E.08971
G1 X115.736 Y126.694 E.0045
G1 X101.764 Y126.694 E.2365
G1 X101.764 Y126.231 E.00783
G1 X118.236 Y126.231 E.27881
G1 X118.236 Y125.769 E.00783
G1 X101.764 Y125.769 E.27881
G1 X101.764 Y125.307 E.00783
G1 X115.736 Y125.307 E.2365
G1 X115.736 Y125.04 E.0045
M73 P74 R3
G1 X110.436 Y125.04 E.08971
G1 X110.436 Y124.844 E.00332
G1 X110.364 Y124.844 E.00123
G1 X110.364 Y124.382 E.00783
G1 X110.629 Y124.382 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y124.382 E-.10083
G1 X110.364 Y124.844 E-.17568
G1 X110.436 Y124.844 E-.02755
G1 X110.436 Y125.04 E-.07455
G1 X111.44 Y125.04 E-.38138
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 8/29
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.1 I-1.217 J0 P1  F30000
G1 X111.44 Y125.12 Z1.1
G1 X133.22 Y124.911
G1 X133.479 Y124.909
G1 X145.235 Y124.839
G1 X145.436 Y124.694
G1 X145.475 Y124.889
G1 X145.74 Y124.836
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.836 E.03463
; object ids of layer 8 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer8 end: 8,9,10
M625
G1 X147.94 Y127.464 E.04137
G1 X145.74 Y127.464 E.03463
G1 X145.74 Y127.74 E.00435
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.464 E.00435
G1 X142.06 Y127.464 E.04565
G1 X142.06 Y124.836 E.04137
G1 X144.96 Y124.836 E.04565
G1 X144.96 Y124.261 E.00905
G1 X145.74 Y124.261 E.01228
G1 X145.74 Y124.776 E.00811
M204 S10000
G1 X145.581 Y124.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X145.299 Y124.6 E.00445
G1 X145.299 Y125 E.00632
G1 X145.401 Y125 E.00162
G1 X145.401 Y125.175 E.00275
G1 X147.601 Y125.175 E.03476
G1 X147.601 Y125.4 E.00357
G1 X142.399 Y125.4 E.08219
G1 X142.399 Y125.8 E.00632
G1 X147.601 Y125.8 E.08219
G1 X147.601 Y126.2 E.00632
G1 X142.399 Y126.2 E.08219
G1 X142.399 Y126.6 E.00632
G1 X147.601 Y126.6 E.08219
G1 X147.601 Y127 E.00632
G1 X142.399 Y127 E.08219
G1 X142.399 Y127.125 E.00197
G1 X145.299 Y127.125 E.04582
G1 X145.299 Y127.4 E.00435
G1 X145.581 Y127.4 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X145.299 Y127.4 E-.10711
G1 X145.299 Y127.125 E-.10461
G1 X143.856 Y127.125 E-.54828
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X143.856 Y127.031 Z1.2 F30000
G1 X142.493 Y126.817
G1 X133.475 Y124.889
G1 X133.74 Y124.836
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.836 E.03463
G1 X135.94 Y127.464 E.04137
G1 X133.74 Y127.464 E.03463
G1 X133.74 Y127.74 E.00435
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.464 E.00435
G1 X130.06 Y127.464 E.04565
G1 X130.06 Y124.836 E.04137
G1 X132.96 Y124.836 E.04565
G1 X132.96 Y124.261 E.00905
G1 X133.74 Y124.261 E.01228
G1 X133.74 Y124.776 E.00811
M204 S10000
G1 X133.581 Y124.6 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42146
G1 F1200
M204 S1000
G1 X133.299 Y124.6 E.00445
G1 X133.299 Y125 E.00632
G1 X133.401 Y125 E.00162
G1 X133.401 Y125.175 E.00275
G1 X135.601 Y125.175 E.03476
G1 X135.601 Y125.4 E.00357
G1 X130.399 Y125.4 E.08219
G1 X130.399 Y125.8 E.00632
G1 X135.601 Y125.8 E.08219
G1 X135.601 Y126.2 E.00632
G1 X130.399 Y126.2 E.08219
G1 X130.399 Y126.6 E.00632
M73 P75 R3
G1 X135.601 Y126.6 E.08219
G1 X135.601 Y127 E.00632
G1 X130.399 Y127 E.08219
G1 X130.399 Y127.125 E.00197
G1 X133.299 Y127.125 E.04582
G1 X133.299 Y127.4 E.00435
G1 X133.581 Y127.4 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X133.299 Y127.4 E-.10711
G1 X133.299 Y127.125 E-.10461
G1 X131.856 Y127.125 E-.54828
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X131.856 Y127.031 Z1.2 F30000
G1 X130.493 Y126.964
G1 X116.09 Y126.255
G1 X116.09 Y126.688
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.313 E.00985
G1 X110.79 Y127.313 E.08343
G1 X110.79 Y127.989 E.01064
G1 X110.01 Y127.989 E.01228
G1 X110.01 Y127.313 E.01064
G1 X101.41 Y127.313 E.13537
G1 X101.41 Y124.687 E.04135
G1 X110.01 Y124.687 E.13537
G1 X110.01 Y124.011 E.01064
G1 X110.79 Y124.011 E.01228
G1 X110.79 Y124.687 E.01064
G1 X116.09 Y124.687 E.08343
G1 X116.09 Y125.312 E.00985
G1 X118.59 Y125.312 E.03935
G1 X118.59 Y126.688 E.02165
G1 X116.15 Y126.688 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.313 E-.23883
G1 X114.719 Y127.313 E-.52117
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.719 Y126.88 Z1.2 F30000
G1 X111.321 Y126.88
G1 X110.561 Y127.084
G1 X110.434 Y127.556
G1 X110.434 Y127.556
G1 X110.629 Y127.619
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.619 E.00449
G1 X110.364 Y127.156 E.00783
G1 X110.436 Y127.156 E.00123
G1 X110.436 Y126.96 E.00333
G1 X115.736 Y126.96 E.08971
G1 X115.736 Y126.694 E.0045
G1 X101.764 Y126.694 E.2365
G1 X101.764 Y126.231 E.00783
G1 X118.236 Y126.231 E.27881
G1 X118.236 Y125.769 E.00783
G1 X101.764 Y125.769 E.27881
G1 X101.764 Y125.306 E.00783
G1 X115.736 Y125.306 E.2365
G1 X115.736 Y125.04 E.0045
G1 X110.436 Y125.04 E.08971
G1 X110.436 Y124.844 E.00333
G1 X110.364 Y124.844 E.00123
G1 X110.364 Y124.381 E.00783
G1 X110.629 Y124.381 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 0.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y124.381 E-.10083
G1 X110.364 Y124.844 E-.17573
G1 X110.436 Y124.844 E-.02755
G1 X110.436 Y125.04 E-.07467
G1 X111.439 Y125.04 E-.38122
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 9/29
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I-1.217 J0 P1  F30000
G1 X111.439 Y125.126 Z1.2
G1 X133.221 Y124.915
G1 X133.479 Y124.913
G1 X145.235 Y124.846
G1 X145.436 Y124.699
G1 X145.475 Y124.896
G1 X145.74 Y124.843
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.843 E.03463
; object ids of layer 9 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer9 end: 8,9,10
M625
G1 X147.94 Y127.457 E.04115
G1 X145.74 Y127.457 E.03463
G1 X145.74 Y127.74 E.00445
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.457 E.00445
G1 X142.06 Y127.457 E.04565
G1 X142.06 Y124.843 E.04115
G1 X144.96 Y124.843 E.04565
G1 X144.96 Y124.266 E.00908
G1 X145.74 Y124.266 E.01228
G1 X145.74 Y124.783 E.00814
M204 S10000
G1 X145.581 Y124.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X145.299 Y124.605 E.00445
G1 X145.299 Y125.004 E.0063
G1 X145.401 Y125.004 E.00162
M73 P76 R3
G1 X145.401 Y125.181 E.00279
G1 X147.601 Y125.181 E.03471
G1 X147.601 Y125.404 E.00351
G1 X142.399 Y125.404 E.08207
G1 X142.399 Y125.803 E.0063
G1 X147.601 Y125.803 E.08207
G1 X147.601 Y126.203 E.0063
G1 X142.399 Y126.203 E.08207
G1 X142.399 Y126.602 E.0063
G1 X147.601 Y126.602 E.08207
G1 X147.601 Y127.001 E.0063
G1 X142.399 Y127.001 E.08207
G1 X142.399 Y127.118 E.00185
G1 X145.299 Y127.118 E.04575
G1 X145.299 Y127.401 E.00445
G1 X145.581 Y127.401 E.00445
; OBJECT_ID: 9
; WIPE_START
G1 X145.299 Y127.401 E-.10711
G1 X145.299 Y127.118 E-.10728
G1 X143.863 Y127.118 E-.54562
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X143.863 Y127.024 Z1.3 F30000
G1 X142.493 Y126.81
G1 X133.475 Y124.896
G1 X133.74 Y124.843
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.843 E.03463
G1 X135.94 Y127.457 E.04115
G1 X133.74 Y127.457 E.03463
G1 X133.74 Y127.74 E.00445
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.457 E.00445
G1 X130.06 Y127.457 E.04565
G1 X130.06 Y124.843 E.04115
G1 X132.96 Y124.843 E.04565
G1 X132.96 Y124.266 E.00908
G1 X133.74 Y124.266 E.01228
G1 X133.74 Y124.783 E.00814
M204 S10000
G1 X133.581 Y124.605 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42087
G1 F1200
M204 S1000
G1 X133.299 Y124.605 E.00445
G1 X133.299 Y125.004 E.0063
G1 X133.401 Y125.004 E.00162
G1 X133.401 Y125.181 E.00279
G1 X135.601 Y125.181 E.03471
G1 X135.601 Y125.404 E.00351
G1 X130.399 Y125.404 E.08207
G1 X130.399 Y125.803 E.0063
G1 X135.601 Y125.803 E.08207
G1 X135.601 Y126.203 E.0063
G1 X130.399 Y126.203 E.08207
G1 X130.399 Y126.602 E.0063
G1 X135.601 Y126.602 E.08207
G1 X135.601 Y127.001 E.0063
G1 X130.399 Y127.001 E.08207
G1 X130.399 Y127.118 E.00185
G1 X133.299 Y127.118 E.04575
G1 X133.299 Y127.401 E.00445
G1 X133.581 Y127.401 E.00445
; OBJECT_ID: 8
; WIPE_START
G1 X133.299 Y127.401 E-.10711
G1 X133.299 Y127.118 E-.10728
G1 X131.863 Y127.118 E-.54562
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X131.863 Y127.024 Z1.3 F30000
G1 X130.493 Y126.957
G1 X116.09 Y126.244
G1 X116.09 Y126.677
G1 Z.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.307 E.00992
G1 X110.79 Y127.307 E.08343
G1 X110.79 Y127.984 E.01066
G1 X110.01 Y127.984 E.01228
G1 X110.01 Y127.307 E.01066
G1 X101.41 Y127.307 E.13537
G1 X101.41 Y124.693 E.04114
G1 X110.01 Y124.693 E.13537
G1 X110.01 Y124.016 E.01066
G1 X110.79 Y124.016 E.01228
G1 X110.79 Y124.693 E.01066
G1 X116.09 Y124.693 E.08343
G1 X116.09 Y125.323 E.00992
G1 X118.59 Y125.323 E.03935
M73 P77 R3
G1 X118.59 Y126.677 E.02131
G1 X116.15 Y126.677 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.307 E-.24046
G1 X114.723 Y127.307 E-.51954
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.723 Y126.874 Z1.3 F30000
G1 X111.321 Y126.874
G1 X110.561 Y127.077
G1 X110.434 Y127.552
G1 X110.434 Y127.551
G1 X110.629 Y127.614
G1 Z.9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.614 E.00449
G1 X110.364 Y127.153 E.00781
G1 X110.436 Y127.153 E.00123
G1 X110.436 Y126.953 E.00338
G1 X115.736 Y126.953 E.08971
G1 X115.736 Y126.692 E.00442
G1 X101.764 Y126.692 E.2365
G1 X101.764 Y126.231 E.00781
G1 X118.236 Y126.231 E.27881
G1 X118.236 Y125.769 E.00781
G1 X101.764 Y125.769 E.27881
G1 X101.764 Y125.308 E.00781
G1 X115.736 Y125.308 E.2365
G1 X115.736 Y125.047 E.00442
G1 X110.436 Y125.047 E.08971
G1 X110.436 Y124.847 E.00338
G1 X110.364 Y124.847 E.00123
G1 X110.364 Y124.386 E.00781
G1 X110.629 Y124.386 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y124.386 E-.10083
G1 X110.364 Y124.847 E-.17526
G1 X110.436 Y124.847 E-.02755
G1 X110.436 Y125.047 E-.07597
G1 X111.437 Y125.047 E-.38038
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 10/29
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M106 S76.5
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.3 I-1.217 J0 P1  F30000
G1 X111.437 Y125.139 Z1.3
G1 X133.221 Y124.926
G1 X133.478 Y124.924
G1 X145.235 Y124.859
G1 X145.435 Y124.708
G1 X145.475 Y124.909
G1 X145.74 Y124.856
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.856 E.03463
; object ids of layer 10 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer10 end: 8,9,10
M625
G1 X147.94 Y127.444 E.04074
G1 X145.74 Y127.444 E.03463
G1 X145.74 Y127.74 E.00466
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.444 E.00466
G1 X142.06 Y127.444 E.04565
G1 X142.06 Y124.856 E.04074
G1 X144.96 Y124.856 E.04565
G1 X144.96 Y124.275 E.00914
G1 X145.74 Y124.275 E.01228
G1 X145.74 Y124.796 E.0082
M204 S10000
G1 X145.581 Y124.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X145.299 Y124.642 E.00507
G1 X145.299 Y125.097 E.00818
G1 X145.401 Y125.097 E.00184
G1 X145.401 Y125.194 E.00175
G1 X147.601 Y125.194 E.03955
G1 X147.601 Y125.552 E.00643
G1 X142.399 Y125.552 E.09352
G1 X142.399 Y126.008 E.00818
G1 X147.601 Y126.008 E.09352
M73 P77 R2
G1 X147.601 Y126.463 E.00818
G1 X142.399 Y126.463 E.09352
G1 X142.399 Y126.918 E.00818
G1 X147.601 Y126.918 E.09352
G1 X147.601 Y127.105 E.00337
G1 X145.401 Y127.105 E.03955
G1 X145.401 Y127.373 E.00481
G1 X145.119 Y127.373 E.00507
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.373 E-.10711
G1 X145.401 Y127.105 E-.10164
G1 X146.852 Y127.105 E-.55125
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.852 Y127.011 Z1.4 F30000
G1 X142.493 Y126.358
G1 X133.475 Y124.909
G1 X133.74 Y124.856
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.856 E.03463
G1 X135.94 Y127.444 E.04074
G1 X133.74 Y127.444 E.03463
G1 X133.74 Y127.74 E.00466
M73 P78 R2
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.444 E.00466
G1 X130.06 Y127.444 E.04565
G1 X130.06 Y124.856 E.04074
G1 X132.96 Y124.856 E.04565
G1 X132.96 Y124.275 E.00914
G1 X133.74 Y124.275 E.01228
G1 X133.74 Y124.796 E.0082
M204 S10000
G1 X133.581 Y124.642 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47659
G1 F1200
M204 S1000
G1 X133.299 Y124.642 E.00507
G1 X133.299 Y125.097 E.00818
G1 X133.401 Y125.097 E.00184
G1 X133.401 Y125.194 E.00175
G1 X135.601 Y125.194 E.03955
G1 X135.601 Y125.552 E.00643
G1 X130.399 Y125.552 E.09352
G1 X130.399 Y126.008 E.00818
G1 X135.601 Y126.008 E.09352
G1 X135.601 Y126.463 E.00818
G1 X130.399 Y126.463 E.09352
G1 X130.399 Y126.918 E.00818
G1 X135.601 Y126.918 E.09352
G1 X135.601 Y127.105 E.00337
G1 X133.401 Y127.105 E.03955
G1 X133.401 Y127.373 E.00481
G1 X133.119 Y127.373 E.00507
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.373 E-.10711
G1 X133.401 Y127.105 E-.10164
G1 X134.852 Y127.105 E-.55125
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.852 Y127.011 Z1.4 F30000
G1 X130.493 Y127.001
G1 X116.09 Y126.221
G1 X116.09 Y126.654
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.294 E.01007
G1 X110.79 Y127.294 E.08343
G1 X110.79 Y127.975 E.01072
G1 X110.01 Y127.975 E.01228
G1 X110.01 Y127.294 E.01072
G1 X101.41 Y127.294 E.13537
G1 X101.41 Y124.706 E.04073
G1 X110.01 Y124.706 E.13537
G1 X110.01 Y124.025 E.01072
G1 X110.79 Y124.025 E.01228
G1 X110.79 Y124.706 E.01072
G1 X116.09 Y124.706 E.08343
G1 X116.09 Y125.346 E.01007
G1 X118.59 Y125.346 E.03935
G1 X118.59 Y126.654 E.0206
G1 X116.15 Y126.654 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.294 E-.24405
G1 X114.732 Y127.294 E-.51595
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.732 Y126.861 Z1.4 F30000
G1 X111.321 Y126.861
G1 X110.561 Y127.064
G1 X110.433 Y127.542
G1 X110.433 Y127.542
G1 X110.629 Y127.606
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.606 E.00449
G1 X110.364 Y127.147 E.00777
G1 X110.436 Y127.147 E.00123
G1 X110.436 Y126.94 E.00351
G1 X115.736 Y126.94 E.08971
G1 X115.736 Y126.688 E.00426
G1 X101.764 Y126.688 E.2365
G1 X101.764 Y126.229 E.00777
G1 X118.236 Y126.229 E.27881
G1 X118.236 Y125.771 E.00777
G1 X101.764 Y125.771 E.27881
G1 X101.764 Y125.312 E.00777
G1 X115.736 Y125.312 E.2365
G1 X115.736 Y125.06 E.00426
G1 X110.436 Y125.06 E.08971
G1 X110.436 Y124.853 E.00351
G1 X110.364 Y124.853 E.00123
G1 X110.364 Y124.394 E.00777
G1 X110.629 Y124.394 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 1.1
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y124.394 E-.10083
G1 X110.364 Y124.853 E-.17436
G1 X110.436 Y124.853 E-.02755
G1 X110.436 Y125.06 E-.07872
G1 X111.432 Y125.06 E-.37853
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 11/29
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.4 I-1.217 J0 P1  F30000
G1 X111.432 Y125.159 Z1.4
G1 X133.222 Y124.943
G1 X133.478 Y124.942
M73 P79 R2
G1 X145.234 Y124.879
G1 X145.435 Y124.722
G1 X145.476 Y124.929
G1 X145.74 Y124.876
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.876 E.03463
; object ids of layer 11 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer11 end: 8,9,10
M625
G1 X147.94 Y127.424 E.0401
G1 X145.74 Y127.424 E.03463
G1 X145.74 Y127.74 E.00498
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.424 E.00498
G1 X142.06 Y127.424 E.04565
G1 X142.06 Y124.876 E.0401
G1 X144.96 Y124.876 E.04565
G1 X144.96 Y124.289 E.00923
G1 X145.74 Y124.289 E.01228
G1 X145.74 Y124.816 E.00829
M204 S10000
G1 X145.581 Y124.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
G1 F1200
M204 S1000
G1 X145.299 Y124.656 E.00504
G1 X145.299 Y125.109 E.00811
G1 X145.401 Y125.109 E.00183
G1 X145.401 Y125.215 E.0019
G1 X147.601 Y125.215 E.03937
G1 X147.601 Y125.562 E.00621
G1 X142.399 Y125.562 E.0931
G1 X142.399 Y126.015 E.00811
G1 X147.601 Y126.015 E.0931
G1 X147.601 Y126.468 E.00811
G1 X142.399 Y126.468 E.0931
G1 X142.399 Y126.921 E.00811
G1 X147.601 Y126.921 E.0931
G1 X147.601 Y127.085 E.00294
G1 X145.401 Y127.085 E.03937
G1 X145.401 Y127.374 E.00517
G1 X145.119 Y127.374 E.00504
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.374 E-.10711
G1 X145.401 Y127.085 E-.10976
G1 X146.831 Y127.085 E-.54314
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.831 Y126.991 Z1.5 F30000
G1 X142.493 Y126.353
G1 X133.476 Y124.929
G1 X133.74 Y124.876
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.876 E.03463
G1 X135.94 Y127.424 E.0401
G1 X133.74 Y127.424 E.03463
G1 X133.74 Y127.74 E.00498
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.424 E.00498
G1 X130.06 Y127.424 E.04565
G1 X130.06 Y124.876 E.0401
G1 X132.96 Y124.876 E.04565
G1 X132.96 Y124.289 E.00923
G1 X133.74 Y124.289 E.01228
G1 X133.74 Y124.816 E.00829
M204 S10000
G1 X133.581 Y124.656 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47453
G1 F1200
M204 S1000
G1 X133.299 Y124.656 E.00504
G1 X133.299 Y125.109 E.00811
G1 X133.401 Y125.109 E.00183
G1 X133.401 Y125.215 E.0019
G1 X135.601 Y125.215 E.03937
G1 X135.601 Y125.562 E.00621
G1 X130.399 Y125.562 E.0931
G1 X130.399 Y126.015 E.00811
G1 X135.601 Y126.015 E.0931
G1 X135.601 Y126.468 E.00811
G1 X130.399 Y126.468 E.0931
G1 X130.399 Y126.921 E.00811
G1 X135.601 Y126.921 E.0931
G1 X135.601 Y127.085 E.00294
G1 X133.401 Y127.085 E.03937
G1 X133.401 Y127.374 E.00517
G1 X133.119 Y127.374 E.00504
; OBJECT_ID: 8
; WIPE_START
M73 P80 R2
G1 X133.401 Y127.374 E-.10711
G1 X133.401 Y127.085 E-.10976
G1 X134.831 Y127.085 E-.54314
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.831 Y126.991 Z1.5 F30000
G1 X130.493 Y126.977
G1 X116.09 Y126.185
G1 X116.09 Y126.618
G1 Z1.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.274 E.01032
G1 X110.79 Y127.274 E.08343
G1 X110.79 Y127.961 E.01082
G1 X110.01 Y127.961 E.01228
G1 X110.01 Y127.274 E.01082
G1 X101.41 Y127.274 E.13537
G1 X101.41 Y124.726 E.0401
G1 X110.01 Y124.726 E.13537
G1 X110.01 Y124.039 E.01082
G1 X110.79 Y124.039 E.01228
G1 X110.79 Y124.726 E.01082
G1 X116.09 Y124.726 E.08343
G1 X116.09 Y125.382 E.01032
G1 X118.59 Y125.382 E.03935
G1 X118.59 Y126.618 E.01946
G1 X116.15 Y126.618 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.274 E-.25012
G1 X114.748 Y127.274 E-.50988
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.748 Y126.841 Z1.5 F30000
G1 X111.321 Y126.841
G1 X110.561 Y127.044
G1 X110.431 Y127.528
G1 X110.431 Y127.528
G1 X110.629 Y127.594
G1 Z1.1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.594 E.00449
G1 X110.364 Y127.139 E.00771
G1 X110.436 Y127.139 E.00123
G1 X110.436 Y126.92 E.0037
G1 X115.736 Y126.92 E.08971
G1 X115.736 Y126.683 E.00401
G1 X101.764 Y126.683 E.2365
G1 X101.764 Y126.228 E.00771
G1 X118.236 Y126.228 E.27881
G1 X118.236 Y125.772 E.00771
G1 X101.764 Y125.772 E.27881
G1 X101.764 Y125.317 E.00771
G1 X115.736 Y125.317 E.2365
G1 X115.736 Y125.08 E.00401
G1 X110.436 Y125.08 E.08971
G1 X110.436 Y124.862 E.0037
G1 X110.364 Y124.862 E.00123
G1 X110.364 Y124.406 E.00771
G1 X110.629 Y124.406 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y124.406 E-.10083
G1 X110.364 Y124.862 E-.17305
G1 X110.436 Y124.862 E-.02755
G1 X110.436 Y125.08 E-.08304
G1 X111.424 Y125.08 E-.37552
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 12/29
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.5 I-1.217 J0 P1  F30000
G1 X111.424 Y125.186 Z1.5
G1 X133.222 Y124.968
G1 X133.478 Y124.966
G1 X145.234 Y124.906
G1 X145.434 Y124.742
G1 X145.476 Y124.955
G1 X145.74 Y124.903
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.903 E.03463
; object ids of layer 12 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer12 end: 8,9,10
M625
G1 X147.94 Y127.397 E.03926
G1 X145.74 Y127.397 E.03463
G1 X145.74 Y127.74 E.0054
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.397 E.0054
G1 X142.06 Y127.397 E.04565
G1 X142.06 Y124.903 E.03926
G1 X144.96 Y124.903 E.04565
G1 X144.96 Y124.309 E.00935
G1 X145.74 Y124.309 E.01228
G1 X145.74 Y124.843 E.0084
M204 S10000
G1 X145.581 Y124.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X145.299 Y124.674 E.00501
G1 X145.299 Y125.124 E.00801
G1 X145.401 Y125.124 E.00182
G1 X145.401 Y125.242 E.00209
G1 X147.601 Y125.242 E.03912
G1 X147.601 Y125.574 E.00592
G1 X142.399 Y125.574 E.09252
G1 X142.399 Y126.025 E.00801
G1 X147.601 Y126.025 E.09252
G1 X147.601 Y126.475 E.00801
G1 X142.399 Y126.475 E.09252
G1 X142.399 Y126.925 E.00801
G1 X147.601 Y126.925 E.09252
G1 X147.601 Y127.058 E.00237
G1 X145.401 Y127.058 E.03912
G1 X145.401 Y127.375 E.00564
G1 X145.119 Y127.375 E.00501
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.375 E-.10711
G1 X145.401 Y127.058 E-.12052
G1 X146.802 Y127.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.802 Y126.964 Z1.6 F30000
G1 X142.493 Y126.347
G1 X133.476 Y124.955
M73 P81 R2
G1 X133.74 Y124.903
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.903 E.03463
G1 X135.94 Y127.397 E.03926
G1 X133.74 Y127.397 E.03463
G1 X133.74 Y127.74 E.0054
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.397 E.0054
G1 X130.06 Y127.397 E.04565
G1 X130.06 Y124.903 E.03926
G1 X132.96 Y124.903 E.04565
G1 X132.96 Y124.309 E.00935
G1 X133.74 Y124.309 E.01228
G1 X133.74 Y124.843 E.0084
M204 S10000
G1 X133.581 Y124.674 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47173
G1 F1200
M204 S1000
G1 X133.299 Y124.674 E.00501
G1 X133.299 Y125.124 E.00801
G1 X133.401 Y125.124 E.00182
G1 X133.401 Y125.242 E.00209
G1 X135.601 Y125.242 E.03912
G1 X135.601 Y125.574 E.00592
G1 X130.399 Y125.574 E.09252
G1 X130.399 Y126.025 E.00801
G1 X135.601 Y126.025 E.09252
G1 X135.601 Y126.475 E.00801
G1 X130.399 Y126.475 E.09252
G1 X130.399 Y126.925 E.00801
G1 X135.601 Y126.925 E.09252
G1 X135.601 Y127.058 E.00237
G1 X133.401 Y127.058 E.03912
G1 X133.401 Y127.375 E.00564
G1 X133.119 Y127.375 E.00501
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.375 E-.10711
G1 X133.401 Y127.058 E-.12052
G1 X134.802 Y127.058 E-.53237
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.802 Y126.964 Z1.6 F30000
G1 X130.493 Y126.946
G1 X116.09 Y126.161
G1 X116.09 Y126.569
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.247 E.01067
G1 X110.79 Y127.247 E.08343
G1 X110.79 Y127.943 E.01096
G1 X110.01 Y127.943 E.01228
G1 X110.01 Y127.247 E.01096
G1 X101.41 Y127.247 E.13537
G1 X101.41 Y124.753 E.03924
G1 X110.01 Y124.753 E.13537
G1 X110.01 Y124.057 E.01096
G1 X110.79 Y124.057 E.01228
G1 X110.79 Y124.753 E.01096
G1 X116.09 Y124.753 E.08343
G1 X116.09 Y125.431 E.01067
G1 X118.59 Y125.431 E.03935
G1 X118.59 Y126.569 E.01791
G1 X116.15 Y126.569 E.03841
; WIPE_START
M204 S1000
G1 X116.09 Y127.247 E-.25855
G1 X114.77 Y127.247 E-.50145
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.77 Y126.814 Z1.6 F30000
G1 X111.321 Y126.814
G1 X110.561 Y127.017
G1 X110.429 Y127.51
G1 X110.429 Y127.51
G1 X110.629 Y127.578
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y127.578 E.00449
G1 X110.364 Y127.127 E.00763
G1 X110.436 Y127.127 E.00123
G1 X110.436 Y126.893 E.00397
G1 X115.736 Y126.893 E.08971
G1 X115.736 Y126.676 E.00366
G1 X101.764 Y126.676 E.2365
G1 X101.764 Y126.225 E.00763
G1 X118.236 Y126.215 E.27881
G1 X118.236 Y125.785 E.00728
M73 P82 R2
G1 X101.764 Y125.775 E.27881
G1 X101.764 Y125.324 E.00763
G1 X115.736 Y125.324 E.2365
G1 X115.736 Y125.107 E.00367
G1 X110.436 Y125.107 E.08971
G1 X110.436 Y124.873 E.00397
G1 X110.364 Y124.873 E.00123
G1 X110.364 Y124.422 E.00763
G1 X110.629 Y124.422 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 1.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X110.364 Y124.422 E-.10083
G1 X110.364 Y124.873 E-.17132
G1 X110.436 Y124.873 E-.02755
G1 X110.436 Y125.107 E-.08903
G1 X111.413 Y125.107 E-.37127
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 13/29
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.6 I-1.217 J0 P1  F30000
G1 X111.413 Y125.221 Z1.6
G1 X133.222 Y125
G1 X133.478 Y124.998
G1 X145.234 Y124.941
G1 X145.432 Y124.767
G1 X145.476 Y124.989
G1 X145.74 Y124.938
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.938 E.03463
; object ids of layer 13 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer13 end: 8,9,10
M625
G1 X147.94 Y127.362 E.03815
G1 X145.74 Y127.362 E.03463
G1 X145.74 Y127.74 E.00595
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.362 E.00595
G1 X142.06 Y127.362 E.04565
G1 X142.06 Y124.938 E.03815
G1 X144.96 Y124.938 E.04565
G1 X144.96 Y124.334 E.00951
G1 X145.74 Y124.334 E.01228
G1 X145.74 Y124.878 E.00857
M204 S10000
G1 X145.581 Y124.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X145.299 Y124.697 E.00497
G1 X145.299 Y125.143 E.00788
G1 X145.401 Y125.143 E.00181
G1 X145.401 Y125.277 E.00235
G1 X147.601 Y125.277 E.03882
G1 X147.601 Y125.59 E.00553
G1 X142.399 Y125.59 E.0918
G1 X142.399 Y126.037 E.00788
G1 X147.601 Y126.037 E.0918
G1 X147.601 Y126.484 E.00788
G1 X142.399 Y126.484 E.0918
G1 X142.399 Y126.93 E.00788
G1 X147.601 Y126.93 E.0918
G1 X147.601 Y127.023 E.00164
G1 X145.401 Y127.023 E.03882
G1 X145.401 Y127.377 E.00624
G1 X145.119 Y127.377 E.00497
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.377 E-.10711
G1 X145.401 Y127.023 E-.13449
G1 X146.765 Y127.023 E-.51841
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.765 Y126.929 Z1.7 F30000
G1 X142.493 Y126.339
G1 X133.476 Y124.989
G1 X133.74 Y124.938
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.938 E.03463
G1 X135.94 Y127.362 E.03815
G1 X133.74 Y127.362 E.03463
G1 X133.74 Y127.74 E.00595
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.362 E.00595
G1 X130.06 Y127.362 E.04565
G1 X130.06 Y124.938 E.03815
G1 X132.96 Y124.938 E.04565
G1 X132.96 Y124.334 E.00951
G1 X133.74 Y124.334 E.01228
G1 X133.74 Y124.878 E.00857
M204 S10000
G1 X133.581 Y124.697 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46822
G1 F1200
M204 S1000
G1 X133.299 Y124.697 E.00497
G1 X133.299 Y125.143 E.00788
G1 X133.401 Y125.143 E.00181
G1 X133.401 Y125.277 E.00235
G1 X135.601 Y125.277 E.03882
G1 X135.601 Y125.59 E.00553
G1 X130.399 Y125.59 E.0918
G1 X130.399 Y126.037 E.00788
G1 X135.601 Y126.037 E.0918
G1 X135.601 Y126.484 E.00788
G1 X130.399 Y126.484 E.0918
G1 X130.399 Y126.93 E.00788
G1 X135.601 Y126.93 E.0918
M73 P83 R2
G1 X135.601 Y127.023 E.00164
G1 X133.401 Y127.023 E.03882
G1 X133.401 Y127.377 E.00624
G1 X133.119 Y127.377 E.00497
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.377 E-.10711
G1 X133.401 Y127.023 E-.13449
G1 X134.765 Y127.023 E-.51841
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.765 Y126.929 Z1.7 F30000
G1 X130.493 Y126.904
G1 X116.09 Y126.161
G1 X116.09 Y126.501
G1 Z1.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.212 E.01118
G1 X110.79 Y127.212 E.08343
G1 X110.79 Y127.92 E.01115
G1 X110.01 Y127.92 E.01228
G1 X110.01 Y127.212 E.01115
G1 X101.41 Y127.212 E.13537
G1 X101.41 Y124.788 E.03815
G1 X110.01 Y124.788 E.13537
G1 X110.01 Y124.08 E.01115
G1 X110.79 Y124.08 E.01228
G1 X110.79 Y124.788 E.01115
G1 X116.09 Y124.788 E.08343
G1 X116.09 Y125.499 E.01118
G1 X118.59 Y125.499 E.03935
G1 X118.59 Y126.501 E.01579
G1 X116.15 Y126.501 E.03841
M204 S10000
G1 X115.883 Y126 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.6108
G1 F1200
M204 S1000
G1 X118.383 Y126 E.05819
; WIPE_START
G1 X116.383 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.383 Y125.839 Z1.7 F30000
G1 X115.749 Y125.839
G1 X111.321 Y125.221
G1 X110.561 Y125.018
G1 X110.422 Y124.498
G1 X110.629 Y124.442
G1 Z1.3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y124.442 E.00449
G1 X110.364 Y124.887 E.00753
G1 X110.436 Y124.887 E.00123
G1 X110.436 Y125.142 E.00431
G1 X115.736 Y125.142 E.08971
G1 X115.736 Y125.332 E.00322
G1 X101.764 Y125.332 E.2365
G1 X101.764 Y125.777 E.00753
G1 X115.53 Y125.777 E.233
G1 X115.53 Y126.223 E.00753
G1 X101.764 Y126.223 E.233
G1 X101.764 Y126.668 E.00753
G1 X115.736 Y126.668 E.2365
G1 X115.736 Y126.858 E.00322
G1 X110.436 Y126.858 E.08971
G1 X110.436 Y127.113 E.00431
G1 X110.364 Y127.113 E.00123
G1 X110.364 Y127.558 E.00753
G1 X110.629 Y127.558 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y127.558 E-.10083
G1 X110.364 Y127.113 E-.16915
G1 X110.436 Y127.113 E-.02755
G1 X110.436 Y126.858 E-.09682
G1 X111.399 Y126.858 E-.36565
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 14/29
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.7 I1.217 J0 P1  F30000
G1 X111.399 Y126.736 Z1.7
G1 X115.732 Y126.621
G1 X130.493 Y125.814
G1 X135.507 Y125.54
G1 X145.228 Y125.009
G1 X145.431 Y124.796
G1 X145.476 Y125.031
G1 X145.74 Y124.981
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y124.981 E.03463
; object ids of layer 14 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer14 end: 8,9,10
M625
G1 X147.94 Y127.319 E.03681
G1 X145.74 Y127.319 E.03463
G1 X145.74 Y127.74 E.00662
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.319 E.00662
G1 X142.06 Y127.319 E.04565
G1 X142.06 Y124.981 E.03681
G1 X144.96 Y124.981 E.04565
G1 X144.96 Y124.363 E.00972
G1 X145.74 Y124.363 E.01228
G1 X145.74 Y124.921 E.00877
M204 S10000
G1 X145.581 Y124.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X145.299 Y124.724 E.00493
G1 X145.299 Y125.167 E.00774
M73 P84 R2
G1 X145.401 Y125.167 E.00179
G1 X145.401 Y125.319 E.00267
G1 X147.601 Y125.319 E.03845
G1 X147.601 Y125.609 E.00506
G1 X142.399 Y125.609 E.09093
G1 X142.399 Y126.052 E.00774
G1 X147.601 Y126.052 E.09093
G1 X147.601 Y126.494 E.00774
G1 X142.399 Y126.494 E.09093
G1 X142.399 Y126.937 E.00774
G1 X147.601 Y126.937 E.09093
G1 X147.601 Y126.981 E.00077
G1 X145.401 Y126.981 E.03845
G1 X145.401 Y127.379 E.00697
G1 X145.119 Y127.379 E.00493
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.379 E-.10711
G1 X145.401 Y126.981 E-.15151
G1 X146.721 Y126.981 E-.50139
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X146.721 Y126.886 Z1.8 F30000
G1 X142.493 Y126.329
G1 X133.476 Y125.031
G1 X133.74 Y124.981
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y124.981 E.03463
G1 X135.94 Y127.319 E.03681
G1 X133.74 Y127.319 E.03463
G1 X133.74 Y127.74 E.00662
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.319 E.00662
G1 X130.06 Y127.319 E.04565
G1 X130.06 Y124.981 E.03681
G1 X132.96 Y124.981 E.04565
G1 X132.96 Y124.363 E.00972
G1 X133.74 Y124.363 E.01228
G1 X133.74 Y124.921 E.00877
M204 S10000
G1 X133.581 Y124.724 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.464
G1 F1200
M204 S1000
G1 X133.299 Y124.724 E.00493
G1 X133.299 Y125.167 E.00774
G1 X133.401 Y125.167 E.00179
G1 X133.401 Y125.319 E.00267
G1 X135.601 Y125.319 E.03845
G1 X135.601 Y125.609 E.00506
G1 X130.399 Y125.609 E.09093
G1 X130.399 Y126.052 E.00774
G1 X135.601 Y126.052 E.09093
G1 X135.601 Y126.494 E.00774
G1 X130.399 Y126.494 E.09093
G1 X130.399 Y126.937 E.00774
G1 X135.601 Y126.937 E.09093
G1 X135.601 Y126.981 E.00077
G1 X133.401 Y126.981 E.03845
G1 X133.401 Y127.379 E.00697
G1 X133.119 Y127.379 E.00493
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.379 E-.10711
G1 X133.401 Y126.981 E-.15151
G1 X134.721 Y126.981 E-.50139
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X134.721 Y126.886 Z1.8 F30000
G1 X130.493 Y126.852
G1 X116.09 Y126.161
G1 X116.09 Y126.412
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.169 E.01191
G1 X110.79 Y127.169 E.08343
G1 X110.79 Y127.891 E.01137
G1 X110.01 Y127.891 E.01228
G1 X110.01 Y127.169 E.01137
G1 X101.41 Y127.169 E.13537
G1 X101.41 Y124.831 E.0368
G1 X110.01 Y124.831 E.13537
G1 X110.01 Y124.109 E.01137
G1 X110.79 Y124.109 E.01228
G1 X110.79 Y124.831 E.01137
G1 X116.09 Y124.831 E.08343
G1 X116.09 Y125.588 E.01191
G1 X118.59 Y125.588 E.03935
G1 X118.59 Y126.412 E.01298
G1 X116.15 Y126.412 E.03841
M204 S10000
G1 X115.883 Y126 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.43266
G1 F1200
M204 S1000
G1 X118.383 Y126 E.0406
; WIPE_START
G1 X116.383 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.383 Y125.839 Z1.8 F30000
M73 P85 R2
G1 X115.838 Y125.839
G1 X111.321 Y125.264
G1 X110.561 Y125.061
G1 X110.417 Y124.524
G1 X110.629 Y124.467
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.364 Y124.467 E.00449
G1 X110.364 Y124.905 E.00741
G1 X110.436 Y124.905 E.00123
G1 X110.436 Y125.185 E.00474
G1 X115.736 Y125.185 E.08971
G1 X115.736 Y125.343 E.00268
G1 X101.764 Y125.343 E.2365
G1 X101.764 Y125.781 E.00741
G1 X115.53 Y125.781 E.233
G1 X115.53 Y126.219 E.00741
M73 P85 R1
G1 X101.764 Y126.219 E.233
G1 X101.764 Y126.657 E.00741
G1 X115.736 Y126.657 E.2365
G1 X115.736 Y126.815 E.00268
G1 X110.436 Y126.815 E.08971
G1 X110.436 Y127.095 E.00474
G1 X110.364 Y127.095 E.00123
G1 X110.364 Y127.533 E.00741
G1 X110.629 Y127.533 E.00449
; CHANGE_LAYER
; Z_HEIGHT: 1.5
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.364 Y127.533 E-.10083
G1 X110.364 Y127.095 E-.16642
G1 X110.436 Y127.095 E-.02755
G1 X110.436 Y126.815 E-.10632
G1 X111.381 Y126.815 E-.35886
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 15/29
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F30000
G1 X111.381 Y126.684 Z1.8
G1 X115.765 Y126.588
G1 X130.493 Y125.824
G1 X135.507 Y125.563
G1 X145.228 Y125.059
G1 X145.429 Y124.832
G1 X145.477 Y125.082
G1 X145.74 Y125.032
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.032 E.03463
; object ids of layer 15 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer15 end: 8,9,10
M625
G1 X147.94 Y127.267 E.03518
G1 X145.74 Y127.267 E.03463
G1 X145.74 Y127.74 E.00744
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.267 E.00744
G1 X142.06 Y127.267 E.04565
G1 X142.06 Y125.032 E.03518
G1 X144.96 Y125.032 E.04565
G1 X144.96 Y124.399 E.00998
G1 X145.74 Y124.399 E.01228
G1 X145.74 Y124.972 E.00903
M204 S10000
G1 X145.581 Y124.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X145.299 Y124.757 E.00487
G1 X145.299 Y125.194 E.00756
G1 X145.401 Y125.194 E.00177
G1 X145.401 Y125.371 E.00305
G1 X147.601 Y125.371 E.03801
G1 X147.601 Y125.632 E.00451
G1 X142.399 Y125.632 E.08989
G1 X142.399 Y126.069 E.00756
G1 X147.601 Y126.069 E.08989
G1 X147.601 Y126.507 E.00756
G1 X142.399 Y126.507 E.08989
G1 X142.399 Y126.929 E.00729
G1 X145.299 Y126.929 E.05011
G1 X145.299 Y126.944 E.00027
G1 X145.401 Y126.944 E.00177
G1 X145.401 Y127.382 E.00756
G1 X145.119 Y127.382 E.00487
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.382 E-.10711
G1 X145.401 Y126.944 E-.16623
G1 X145.299 Y126.944 E-.03896
G1 X145.299 Y126.929 E-.00591
G1 X144.136 Y126.929 E-.44179
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.136 Y126.835 Z1.9 F30000
G1 X142.493 Y126.629
G1 X133.477 Y125.082
G1 X133.74 Y125.032
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.032 E.03463
G1 X135.94 Y127.267 E.03518
G1 X133.74 Y127.267 E.03463
G1 X133.74 Y127.74 E.00744
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.267 E.00744
G1 X130.06 Y127.267 E.04565
G1 X130.06 Y125.032 E.03518
G1 X132.96 Y125.032 E.04565
G1 X132.96 Y124.399 E.00998
G1 X133.74 Y124.399 E.01228
G1 X133.74 Y124.972 E.00903
M204 S10000
G1 X133.581 Y124.757 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45892
G1 F1200
M204 S1000
G1 X133.299 Y124.757 E.00487
G1 X133.299 Y125.194 E.00756
G1 X133.401 Y125.194 E.00177
G1 X133.401 Y125.371 E.00305
G1 X135.601 Y125.371 E.03801
G1 X135.601 Y125.632 E.00451
G1 X130.399 Y125.632 E.08989
G1 X130.399 Y126.069 E.00756
M73 P86 R1
G1 X135.601 Y126.069 E.08989
G1 X135.601 Y126.507 E.00756
G1 X130.399 Y126.507 E.08989
G1 X130.399 Y126.929 E.00729
G1 X133.299 Y126.929 E.05011
G1 X133.299 Y126.944 E.00027
G1 X133.401 Y126.944 E.00177
G1 X133.401 Y127.382 E.00756
G1 X133.119 Y127.382 E.00487
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.382 E-.10711
G1 X133.401 Y126.944 E-.16623
G1 X133.299 Y126.944 E-.03896
G1 X133.299 Y126.929 E-.00591
G1 X132.136 Y126.929 E-.44179
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.136 Y126.835 Z1.9 F30000
G1 X130.493 Y126.766
G1 X116.09 Y126.161
G1 X116.09 Y126.287
G1 Z1.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.117 E.01306
G1 X110.79 Y127.117 E.08343
G1 X110.79 Y127.857 E.01166
G1 X110.01 Y127.857 E.01228
G1 X110.01 Y127.117 E.01166
G1 X101.41 Y127.117 E.13537
G1 X101.41 Y124.883 E.03516
G1 X110.01 Y124.883 E.13537
G1 X110.01 Y124.143 E.01166
G1 X110.79 Y124.143 E.01228
G1 X110.79 Y124.883 E.01166
G1 X116.09 Y124.883 E.08343
G1 X116.09 Y125.713 E.01306
G1 X118.59 Y125.713 E.03935
G1 X118.59 Y126.287 E.00904
G1 X116.15 Y126.287 E.03841
M204 S10000
G1 X115.883 Y126 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.18244
G1 F1200
M204 S1000
G1 X118.383 Y126 E.01589
; WIPE_START
G1 X116.383 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.383 Y125.839 Z1.9 F30000
G1 X115.963 Y125.839
G1 X115.738 Y125.356
G1 X115.929 Y125.267
G1 Z1.5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X101.764 Y125.267 E.23976
G1 X101.764 Y125.756 E.00827
G1 X115.53 Y125.756 E.233
G1 X115.53 Y126.244 E.00827
G1 X101.764 Y126.244 E.233
G1 X101.764 Y126.733 E.00827
G1 X115.929 Y126.733 E.23976
; WIPE_START
G1 X113.929 Y126.733 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.929 Y126.684 Z1.9 F30000
G1 X111.321 Y126.684
G1 X110.561 Y126.888
G1 X110.546 Y127.425
G1 X110.4 Y127.425
G1 X110.4 Y127.651
G1 Z1.5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y126.91 E.01072
G1 E-.8 F1800
M204 S10000
G1 X110.4 Y125.09 Z1.9 F30000
G1 Z1.5
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X110.4 Y124.349 E.01072
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.4 Y125.09 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 16/29
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.9 I.034 J1.216 P1  F30000
G1 X110.558 Y125.085 Z1.9
G1 X133.251 Y125.093
G1 X133.449 Y125.093
G1 X145.251 Y125.094
G1 X145.511 Y125.324
G1 X145.667 Y125.366
G1 X145.74 Y125.094
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.094 E.03463
; object ids of layer 16 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer16 end: 8,9,10
M625
G1 X147.94 Y127.206 E.03323
G1 X145.74 Y127.206 E.03463
G1 X145.74 Y127.74 E.00841
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.206 E.00841
G1 X142.06 Y127.206 E.04565
G1 X142.06 Y125.094 E.03323
G1 X144.96 Y125.094 E.04565
M73 P87 R1
G1 X144.96 Y124.44 E.0103
G1 X145.74 Y124.44 E.01228
G1 X145.74 Y125.034 E.00935
M204 S10000
G1 X145.581 Y124.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
G1 X145.299 Y124.795 E.0048
G1 X145.299 Y125.227 E.00736
G1 X145.401 Y125.227 E.00175
G1 X145.401 Y125.433 E.00351
G1 X147.601 Y125.433 E.0375
G1 X147.601 Y125.658 E.00384
G1 X142.399 Y125.658 E.08868
G1 X142.399 Y126.09 E.00736
G1 X147.601 Y126.09 E.08868
G1 X147.601 Y126.522 E.00736
G1 X142.399 Y126.522 E.08868
G1 X142.399 Y126.867 E.00589
G1 X145.299 Y126.867 E.04943
G1 X145.299 Y126.953 E.00147
G1 X145.401 Y126.953 E.00175
G1 X145.401 Y127.385 E.00736
G1 X145.119 Y127.385 E.0048
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.385 E-.10711
G1 X145.401 Y126.953 E-.16399
G1 X145.299 Y126.953 E-.03896
G1 X145.299 Y126.867 E-.03277
G1 X144.201 Y126.867 E-.41718
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.201 Y126.773 Z2 F30000
G1 X142.493 Y126.577
G1 X133.667 Y125.366
G1 X133.74 Y125.094
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.094 E.03463
G1 X135.94 Y127.206 E.03323
G1 X133.74 Y127.206 E.03463
G1 X133.74 Y127.74 E.00841
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.206 E.00841
G1 X130.06 Y127.206 E.04565
G1 X130.06 Y125.094 E.03323
G1 X132.96 Y125.094 E.04565
G1 X132.96 Y124.44 E.0103
G1 X133.74 Y124.44 E.01228
G1 X133.74 Y125.034 E.00935
M204 S10000
G1 X133.581 Y124.795 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45301
G1 F1200
M204 S1000
G1 X133.299 Y124.795 E.0048
G1 X133.299 Y125.227 E.00736
G1 X133.401 Y125.227 E.00175
G1 X133.401 Y125.433 E.00351
G1 X135.601 Y125.433 E.0375
G1 X135.601 Y125.658 E.00384
G1 X130.399 Y125.658 E.08868
G1 X130.399 Y126.09 E.00736
G1 X135.601 Y126.09 E.08868
G1 X135.601 Y126.522 E.00736
G1 X130.399 Y126.522 E.08868
G1 X130.399 Y126.867 E.00589
G1 X133.299 Y126.867 E.04943
G1 X133.299 Y126.953 E.00147
G1 X133.401 Y126.953 E.00175
G1 X133.401 Y127.385 E.00736
G1 X133.119 Y127.385 E.0048
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.385 E-.10711
G1 X133.401 Y126.953 E-.16399
G1 X133.299 Y126.953 E-.03896
G1 X133.299 Y126.867 E-.03277
G1 X132.201 Y126.867 E-.41718
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.201 Y126.773 Z2 F30000
G1 X117.67 Y126.161
G1 X116.167 Y126.161
G1 X116.162 Y126.165
G1 X116.09 Y126.084
G1 Z1.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y127.055 E.01529
G1 X110.79 Y127.055 E.08343
G1 X110.79 Y127.818 E.01201
G1 X110.01 Y127.818 E.01228
G1 X110.01 Y127.055 E.01201
G1 X101.41 Y127.055 E.13537
G1 X101.41 Y124.945 E.03322
G1 X110.01 Y124.945 E.13537
G1 X110.01 Y124.182 E.01201
G1 X110.79 Y124.182 E.01228
G1 X110.79 Y124.945 E.01201
G1 X116.09 Y124.945 E.08343
G1 X116.09 Y125.916 E.01529
G1 X118.59 Y125.916 E.03935
G1 X118.59 Y126.084 E.00264
G1 X116.15 Y126.084 E.03841
M204 S10000
G1 X115.929 Y126.687 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P88 R1
G1 F1200
M204 S1000
G1 X101.764 Y126.687 E.23976
G1 X101.764 Y126.229 E.00775
G1 X115.736 Y126.229 E.2365
G1 X115.736 Y125.771 E.00775
G1 X101.764 Y125.771 E.2365
G1 X101.764 Y125.313 E.00775
G1 X115.929 Y125.313 E.23976
; WIPE_START
G1 X113.929 Y125.313 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.929 Y125.378 Z2 F30000
G1 X111.321 Y125.378
G1 X110.561 Y125.174
G1 X110.514 Y124.397
G1 X110.493 Y124.437
G1 X110.4 Y124.389
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y125.152 E.01104
G1 E-.8 F1800
M204 S10000
G1 X110.4 Y126.848 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X110.4 Y127.611 E.01104
; CHANGE_LAYER
; Z_HEIGHT: 1.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.4 Y126.848 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 17/29
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2 I-.034 J1.216 P1  F30000
G1 X110.558 Y126.853 Z2
G1 X130.493 Y125.893
G1 X135.507 Y125.654
G1 X145.244 Y125.191
G1 X145.511 Y125.397
G1 X145.667 Y125.439
G1 X145.74 Y125.167
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.167 E.03463
; object ids of layer 17 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer17 end: 8,9,10
M625
G1 X147.94 Y127.133 E.03093
G1 X145.74 Y127.133 E.03463
G1 X145.74 Y127.74 E.00956
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.133 E.00956
G1 X142.06 Y127.133 E.04565
G1 X142.06 Y125.167 E.03093
G1 X144.96 Y125.167 E.04565
G1 X144.96 Y124.487 E.01071
G1 X145.74 Y124.487 E.01228
G1 X145.74 Y125.107 E.00976
M204 S10000
G1 X145.581 Y124.839 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44628
G1 F1200
M204 S1000
G1 X145.299 Y124.839 E.00473
G1 X145.299 Y125.264 E.00713
G1 X145.401 Y125.264 E.00172
G1 X145.401 Y125.506 E.00406
G1 X147.601 Y125.506 E.03691
G1 X147.601 Y125.689 E.00307
G1 X142.399 Y125.689 E.08729
G1 X142.399 Y126.114 E.00713
G1 X147.601 Y126.114 E.08729
G1 X147.601 Y126.538 E.00713
G1 X142.399 Y126.538 E.08729
G1 X142.399 Y126.794 E.00428
G1 X145.299 Y126.794 E.04866
G1 X145.299 Y126.963 E.00284
G1 X145.401 Y126.963 E.00172
G1 X145.401 Y127.388 E.00713
G1 X145.119 Y127.388 E.00473
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.388 E-.10711
G1 X145.401 Y126.963 E-.16143
G1 X145.299 Y126.963 E-.03896
G1 X145.299 Y126.794 E-.06441
G1 X144.277 Y126.794 E-.38809
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.277 Y126.7 Z2.1 F30000
G1 X142.493 Y126.518
G1 X133.667 Y125.439
G1 X133.74 Y125.167
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.167 E.03463
G1 X135.94 Y127.133 E.03093
G1 X133.74 Y127.133 E.03463
G1 X133.74 Y127.74 E.00956
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.133 E.00956
G1 X130.06 Y127.133 E.04565
G1 X130.06 Y125.167 E.03093
G1 X132.96 Y125.167 E.04565
G1 X132.96 Y124.487 E.01071
G1 X133.74 Y124.487 E.01228
G1 X133.74 Y125.107 E.00976
M204 S10000
G1 X133.581 Y124.839 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44628
G1 F1200
M204 S1000
G1 X133.299 Y124.839 E.00473
G1 X133.299 Y125.264 E.00713
G1 X133.401 Y125.264 E.00172
M73 P89 R1
G1 X133.401 Y125.506 E.00406
G1 X135.601 Y125.506 E.03691
G1 X135.601 Y125.689 E.00307
G1 X130.399 Y125.689 E.08729
G1 X130.399 Y126.114 E.00713
G1 X135.601 Y126.114 E.08729
G1 X135.601 Y126.538 E.00713
G1 X130.399 Y126.538 E.08729
G1 X130.399 Y126.794 E.00428
G1 X133.299 Y126.794 E.04866
G1 X133.299 Y126.963 E.00284
G1 X133.401 Y126.963 E.00172
G1 X133.401 Y127.388 E.00713
G1 X133.119 Y127.388 E.00473
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.388 E-.10711
G1 X133.401 Y126.963 E-.16143
G1 X133.299 Y126.963 E-.03896
G1 X133.299 Y126.794 E-.06441
G1 X132.277 Y126.794 E-.38809
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.278 Y126.7 Z2.1 F30000
G1 X130.493 Y126.684
G1 X115.657 Y126.549
G1 X116.09 Y126.689
G1 Z1.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X116.09 Y126.982 E.00462
G1 X110.79 Y126.982 E.08343
G1 X110.79 Y127.773 E.01246
G1 X110.01 Y127.773 E.01228
G1 X110.01 Y126.982 E.01246
G1 X101.41 Y126.982 E.13537
G1 X101.41 Y125.018 E.03091
G1 X110.01 Y125.018 E.13537
G1 X110.01 Y124.227 E.01246
G1 X110.79 Y124.227 E.01228
G1 X110.79 Y125.018 E.01246
G1 X116.09 Y125.018 E.08343
G1 X116.09 Y126.629 E.02535
; WIPE_START
M204 S1000
G1 X116.09 Y126.982 E-.13425
G1 X114.443 Y126.982 E-.62575
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.443 Y126.549 Z2.1 F30000
G1 X115.657 Y125.451
G1 X115.929 Y125.415
G1 Z1.7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X101.764 Y125.415 E.23976
G1 X101.764 Y125.929 E.0087
G1 X115.736 Y125.929 E.2365
G1 X115.736 Y126.443 E.0087
G1 X101.571 Y126.443 E.23976
; WIPE_START
G1 X103.571 Y126.443 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.571 Y126.549 Z2.1 F30000
G1 X109.479 Y126.549
G1 X110.239 Y126.752
G1 X110.256 Y127.34
G1 X110.4 Y127.34
G1 X110.4 Y127.567
G1 Z1.7
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y126.775 E.01146
G1 E-.8 F1800
M204 S10000
G1 X110.4 Y125.225 Z2.1 F30000
G1 Z1.7
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X110.4 Y124.433 E.01146
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X110.4 Y125.225 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 18/29
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.1 I.034 J1.216 P1  F30000
G1 X110.557 Y125.22 Z2.1
G1 X133.189 Y125.244
G1 X133.447 Y125.244
G1 X145.189 Y125.254
G1 X145.511 Y125.484
G1 X145.667 Y125.526
G1 X145.74 Y125.254
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.254 E.03463
; object ids of layer 18 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer18 end: 8,9,10
M625
G1 X147.94 Y127.046 E.0282
G1 X145.74 Y127.046 E.03463
G1 X145.74 Y127.74 E.01093
G1 X144.96 Y127.74 E.01228
G1 X144.96 Y127.046 E.01093
G1 X142.06 Y127.046 E.04565
G1 X142.06 Y125.254 E.0282
G1 X144.96 Y125.254 E.04565
G1 X144.96 Y124.542 E.01122
G1 X145.74 Y124.542 E.01228
G1 X145.74 Y125.194 E.01027
M204 S10000
G1 X145.581 Y124.89 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4385
G1 F1200
M204 S1000
G1 X145.299 Y124.89 E.00464
G1 X145.299 Y125.307 E.00687
G1 X145.401 Y125.307 E.00169
G1 X145.401 Y125.593 E.00472
G1 X147.601 Y125.593 E.03624
G1 X147.601 Y125.724 E.00215
G1 X142.399 Y125.724 E.08569
G1 X142.399 Y126.141 E.00687
G1 X147.601 Y126.141 E.08569
G1 X147.601 Y126.558 E.00687
G1 X142.399 Y126.558 E.08569
G1 X142.399 Y126.707 E.00245
G1 X145.299 Y126.707 E.04777
G1 X145.299 Y126.975 E.00442
G1 X145.401 Y126.975 E.00169
G1 X145.401 Y127.392 E.00687
G1 X145.119 Y127.392 E.00464
; OBJECT_ID: 9
; WIPE_START
G1 X145.401 Y127.392 E-.10711
G1 X145.401 Y126.975 E-.15848
G1 X145.299 Y126.975 E-.03896
G1 X145.299 Y126.707 E-.10187
G1 X144.368 Y126.707 E-.35359
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.368 Y126.613 Z2.2 F30000
G1 X142.493 Y126.451
G1 X133.667 Y125.526
M73 P90 R1
G1 X133.74 Y125.254
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.254 E.03463
G1 X135.94 Y127.046 E.0282
G1 X133.74 Y127.046 E.03463
G1 X133.74 Y127.74 E.01093
G1 X132.96 Y127.74 E.01228
G1 X132.96 Y127.046 E.01093
G1 X130.06 Y127.046 E.04565
G1 X130.06 Y125.254 E.0282
G1 X132.96 Y125.254 E.04565
G1 X132.96 Y124.542 E.01122
G1 X133.74 Y124.542 E.01228
G1 X133.74 Y125.194 E.01027
M204 S10000
G1 X133.581 Y124.89 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4385
G1 F1200
M204 S1000
G1 X133.299 Y124.89 E.00464
G1 X133.299 Y125.307 E.00687
G1 X133.401 Y125.307 E.00169
G1 X133.401 Y125.593 E.00472
G1 X135.601 Y125.593 E.03624
G1 X135.601 Y125.724 E.00215
G1 X130.399 Y125.724 E.08569
G1 X130.399 Y126.141 E.00687
G1 X135.601 Y126.141 E.08569
G1 X135.601 Y126.558 E.00687
G1 X130.399 Y126.558 E.08569
G1 X130.399 Y126.707 E.00245
G1 X133.299 Y126.707 E.04777
G1 X133.299 Y126.975 E.00442
G1 X133.401 Y126.975 E.00169
G1 X133.401 Y127.392 E.00687
G1 X133.119 Y127.392 E.00464
; OBJECT_ID: 8
; WIPE_START
G1 X133.401 Y127.392 E-.10711
G1 X133.401 Y126.975 E-.15848
G1 X133.299 Y126.975 E-.03896
G1 X133.299 Y126.707 E-.10187
G1 X132.368 Y126.707 E-.35359
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.368 Y126.613 Z2.2 F30000
G1 X110.554 Y126.889
G1 X110.554 Y126.889
G1 X110.79 Y126.895
G1 Z1.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.722 E.01302
G1 X110.01 Y127.722 E.01228
G1 X110.01 Y126.895 E.01302
G1 X101.41 Y126.895 E.13537
G1 X101.41 Y125.105 E.02818
G1 X110.01 Y125.105 E.13537
G1 X110.01 Y124.278 E.01302
G1 X110.79 Y124.278 E.01228
G1 X110.79 Y125.105 E.01302
G1 X116.09 Y125.105 E.08343
G1 X116.09 Y126.895 E.02818
G1 X110.85 Y126.895 E.08248
M204 S10000
G1 X110.4 Y126.689 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y127.516 E.01197
G1 E-.8 F1800
M204 S10000
G1 X110.4 Y125.311 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X110.4 Y124.484 E.01197
; WIPE_START
G1 X110.4 Y125.311 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.929 Y125.496 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X101.764 Y125.496 E.23976
G1 X101.764 Y126 E.00853
G1 X115.736 Y126 E.2365
G1 X115.736 Y126.504 E.00853
G1 X101.571 Y126.504 E.23976
; CHANGE_LAYER
; Z_HEIGHT: 1.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X103.571 Y126.504 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 19/29
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.2 I1.217 J0 P1  F30000
G1 X103.571 Y126.358 Z2.2
G1 X115.657 Y126.176
G1 X132.726 Y125.712
G1 X133.859 Y125.682
G1 X145.189 Y125.374
G1 X145.489 Y124.828
G1 X145.504 Y125.365
G1 X145.74 Y125.359
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.359 E.03463
; object ids of layer 19 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer19 end: 8,9,10
M625
G1 X147.94 Y126.941 E.02491
G1 X145.74 Y126.941 E.03463
G1 X145.74 Y127.697 E.0119
G1 X144.96 Y127.697 E.01228
G1 X144.96 Y126.941 E.0119
G1 X142.06 Y126.941 E.04565
G1 X142.06 Y125.359 E.02491
G1 X144.96 Y125.359 E.04565
M73 P91 R1
G1 X144.96 Y124.603 E.0119
G1 X145.74 Y124.603 E.01228
G1 X145.74 Y125.299 E.01095
M204 S10000
G1 X145.35 Y125.566 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X145.35 Y124.81 E.01094
G1 E-.8 F1800
M204 S10000
G1 X145.35 Y126.734 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X145.35 Y127.49 E.01094
; WIPE_START
G1 X145.35 Y126.734 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X147.781 Y125.716 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45587
G1 F1200
M204 S1000
G1 X145.883 Y125.716 E.03256
G1 X145.883 Y125.904 E.00324
G1 X144.817 Y125.904 E.01828
G1 X144.817 Y125.716 E.00324
G1 X142.399 Y125.716 E.04149
G1 X142.399 Y126.15 E.00745
G1 X147.601 Y126.15 E.08926
G1 X147.601 Y126.584 E.00745
G1 X145.883 Y126.584 E.02948
G1 X145.883 Y126.396 E.00324
G1 X144.817 Y126.396 E.01828
G1 X144.817 Y126.584 E.00324
G1 X142.219 Y126.584 E.04457
; OBJECT_ID: 9
; WIPE_START
G1 X144.219 Y126.584 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.219 Y126.508 Z2.3 F30000
G1 X142.493 Y126.382
G1 X133.504 Y125.365
G1 X133.74 Y125.359
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.359 E.03463
G1 X135.94 Y126.941 E.02491
G1 X133.74 Y126.941 E.03463
G1 X133.74 Y127.697 E.0119
G1 X132.96 Y127.697 E.01228
G1 X132.96 Y126.941 E.0119
G1 X130.06 Y126.941 E.04565
G1 X130.06 Y125.359 E.02491
G1 X132.96 Y125.359 E.04565
G1 X132.96 Y124.603 E.0119
G1 X133.74 Y124.603 E.01228
G1 X133.74 Y125.299 E.01095
M204 S10000
G1 X133.35 Y125.566 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X133.35 Y124.81 E.01094
G1 E-.8 F1800
M204 S10000
G1 X133.35 Y126.734 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X133.35 Y127.49 E.01094
; WIPE_START
G1 X133.35 Y126.734 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.781 Y125.716 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45587
G1 F1200
M204 S1000
G1 X133.883 Y125.716 E.03256
G1 X133.883 Y125.904 E.00324
G1 X132.817 Y125.904 E.01828
G1 X132.817 Y125.716 E.00324
G1 X130.399 Y125.716 E.04149
G1 X130.399 Y126.15 E.00745
G1 X135.601 Y126.15 E.08926
G1 X135.601 Y126.584 E.00745
G1 X133.883 Y126.584 E.02948
G1 X133.883 Y126.396 E.00324
G1 X132.817 Y126.396 E.01828
G1 X132.817 Y126.584 E.00324
G1 X130.219 Y126.584 E.04457
; OBJECT_ID: 8
; WIPE_START
G1 X132.219 Y126.584 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.219 Y126.508 Z2.3 F30000
G1 X110.561 Y126.791
G1 X110.79 Y126.791
G1 Z1.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.665 E.01376
G1 X110.01 Y127.665 E.01228
G1 X110.01 Y126.791 E.01376
G1 X101.41 Y126.791 E.13537
G1 X101.41 Y125.209 E.02489
G1 X110.01 Y125.209 E.13537
G1 X110.01 Y124.335 E.01376
G1 X110.79 Y124.335 E.01228
M73 P92 R1
G1 X110.79 Y125.209 E.01376
G1 X116.09 Y125.209 E.08343
G1 X116.09 Y126.791 E.02489
G1 X110.85 Y126.791 E.08248
M204 S10000
G1 X110.4 Y126.584 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y127.458 E.01265
G1 E-.8 F1800
M204 S10000
G1 X110.4 Y125.416 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X110.4 Y124.542 E.01265
; WIPE_START
G1 X110.4 Y125.416 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.929 Y125.566 Z2.3 F30000
G1 Z1.9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M204 S1000
G1 X110.948 Y125.566 E.08431
G1 X110.948 Y125.77 E.00345
G1 X109.852 Y125.77 E.01854
G1 X109.852 Y125.566 E.00345
G1 X101.764 Y125.566 E.1369
G1 X101.764 Y126 E.00735
G1 X115.736 Y126 E.2365
G1 X115.736 Y126.434 E.00735
G1 X110.948 Y126.434 E.08105
G1 X110.948 Y126.23 E.00345
G1 X109.852 Y126.23 E.01854
G1 X109.852 Y126.434 E.00345
G1 X101.571 Y126.434 E.14017
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X103.571 Y126.434 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 20/29
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.3 I1.217 J0 P1  F30000
G1 X103.571 Y126.229 Z2.3
G1 X115.657 Y126.163
G1 X132.975 Y125.774
G1 X133.667 Y125.758
G1 X145.189 Y125.499
G1 X145.489 Y124.956
G1 X145.504 Y125.494
G1 X145.74 Y125.487
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.487 E.03463
; object ids of layer 20 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer20 end: 8,9,10
M625
G1 X147.94 Y126.813 E.02087
G1 X145.74 Y126.813 E.03463
G1 X145.74 Y127.627 E.01281
G1 X144.96 Y127.627 E.01228
G1 X144.96 Y126.813 E.01281
G1 X142.06 Y126.813 E.04565
G1 X142.06 Y125.487 E.02087
G1 X144.96 Y125.487 E.04565
G1 X144.96 Y124.673 E.01282
G1 X145.74 Y124.673 E.01228
G1 X145.74 Y125.427 E.01187
M204 S10000
G1 X145.35 Y125.694 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38796
G1 F1200
M204 S1000
G1 X145.35 Y124.88 E.01178
G1 E-.8 F1800
M204 S10000
G1 X145.35 Y126.606 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X145.35 Y127.42 E.01178
; WIPE_START
G1 X145.35 Y126.606 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X147.781 Y126.344 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4997
G1 F1200
M204 S1000
G1 X142.399 Y126.344 E.10166
G1 X142.399 Y125.866 E.00903
G1 X147.781 Y125.866 E.10166
; OBJECT_ID: 9
; WIPE_START
G1 X145.781 Y125.866 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X145.8 Y125.794 Z2.4 F30000
G1 X144.752 Y125.833
G1 X133.504 Y125.494
G1 X133.74 Y125.487
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.487 E.03463
G1 X135.94 Y126.813 E.02087
G1 X133.74 Y126.813 E.03463
G1 X133.74 Y127.627 E.01281
G1 X132.96 Y127.627 E.01228
G1 X132.96 Y126.813 E.01281
G1 X130.06 Y126.813 E.04565
M73 P92 R0
G1 X130.06 Y125.487 E.02087
G1 X132.96 Y125.487 E.04565
G1 X132.96 Y124.673 E.01282
G1 X133.74 Y124.673 E.01228
G1 X133.74 Y125.427 E.01187
M204 S10000
G1 X133.35 Y125.694 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38796
G1 F1200
M204 S1000
G1 X133.35 Y124.88 E.01178
G1 E-.8 F1800
M204 S10000
G1 X133.35 Y126.606 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X133.35 Y127.42 E.01178
; WIPE_START
G1 X133.35 Y126.606 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.781 Y126.344 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4997
G1 F1200
M204 S1000
G1 X130.399 Y126.344 E.10166
G1 X130.399 Y125.866 E.00903
G1 X135.781 Y125.866 E.10166
; OBJECT_ID: 8
; WIPE_START
G1 X133.781 Y125.866 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X133.8 Y125.794 Z2.4 F30000
G1 X132.429 Y125.92
G1 X130.493 Y125.98
G1 X110.561 Y126.662
G1 X110.79 Y126.662
M73 P93 R0
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.6 E.01476
G1 X110.01 Y127.6 E.01228
G1 X110.01 Y126.662 E.01476
G1 X101.41 Y126.662 E.13537
G1 X101.41 Y125.338 E.02085
G1 X110.01 Y125.338 E.13537
G1 X110.01 Y124.4 E.01476
G1 X110.79 Y124.4 E.01228
G1 X110.79 Y125.338 E.01476
G1 X116.09 Y125.338 E.08343
G1 X116.09 Y126.662 E.02085
G1 X110.85 Y126.662 E.08248
M204 S10000
G1 X110.4 Y126.456 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y127.393 E.01357
G1 E-.8 F1800
M204 S10000
G1 X110.4 Y125.544 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F1200
M204 S1000
G1 X110.4 Y124.607 E.01357
; WIPE_START
G1 X110.4 Y125.544 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.931 Y125.716 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4997
G1 F1200
M204 S1000
G1 X101.749 Y125.716 E.26788
G1 X101.749 Y126.195 E.00903
G1 X115.931 Y126.195 E.26788
; CHANGE_LAYER
; Z_HEIGHT: 2.1
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X113.931 Y126.195 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 21/29
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F30000
G1 X113.931 Y126.161 Z2.4
G1 X133.189 Y125.866
G1 X133.511 Y125.86
G1 X145.189 Y125.661
G1 X145.511 Y125.185
G1 X145.511 Y125.651
G1 X145.74 Y125.651
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.651 E.03463
; object ids of layer 21 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer21 end: 8,9,10
M625
G1 X147.94 Y126.648 E.01569
G1 X145.74 Y126.648 E.03463
G1 X145.74 Y127.548 E.01417
G1 X144.96 Y127.548 E.01228
G1 X144.96 Y126.648 E.01417
G1 X142.06 Y126.648 E.04565
G1 X142.06 Y125.651 E.01569
G1 X144.96 Y125.651 E.04565
G1 X144.96 Y124.752 E.01416
G1 X145.74 Y124.752 E.01228
G1 X145.74 Y125.591 E.01322
M204 S10000
G1 X145.533 Y126.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.60499
G1 F1200
M204 S1000
G1 X147.733 Y126.15 E.0507
; WIPE_START
G1 X145.733 Y126.15 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X145.35 Y127.342 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.38897
G1 F1200
M204 S1000
G1 X145.35 Y126.4 E.01367
; LINE_WIDTH: 0.457067
G1 X145.35 Y126.358 E.00072
; LINE_WIDTH: 0.503151
G1 X145.35 Y126.317 E.00079
; LINE_WIDTH: 0.549235
G1 X145.35 Y126.275 E.00087
; LINE_WIDTH: 0.59532
G1 X145.35 Y126.233 E.00094
; LINE_WIDTH: 0.641404
G1 X145.35 Y126.192 E.00102
; LINE_WIDTH: 0.687488
G1 X145.35 Y126.15 E.0011
; LINE_WIDTH: 0.692956
G1 X145.411 Y126.15 E.00162
; LINE_WIDTH: 0.657774
G1 X145.472 Y126.15 E.00154
; LINE_WIDTH: 0.622591
G1 X145.533 Y126.15 E.00145
M204 S10000
G1 X145.35 Y126.15 F30000
; LINE_WIDTH: 0.692944
G1 F1200
M204 S1000
G1 X145.289 Y126.15 E.00162
; LINE_WIDTH: 0.657758
G1 X145.228 Y126.15 E.00154
; LINE_WIDTH: 0.605353
G1 X142.267 Y126.15 E.06829
; OBJECT_ID: 9
; WIPE_START
G1 X144.267 Y126.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.267 Y125.989 Z2.5 F30000
G1 X142.493 Y126.066
G1 X133.511 Y125.651
G1 X133.74 Y125.651
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.651 E.03463
G1 X135.94 Y126.648 E.01569
G1 X133.74 Y126.648 E.03463
G1 X133.74 Y127.548 E.01417
G1 X132.96 Y127.548 E.01228
G1 X132.96 Y126.648 E.01417
G1 X130.06 Y126.648 E.04565
G1 X130.06 Y125.651 E.01569
G1 X132.96 Y125.651 E.04565
G1 X132.96 Y124.752 E.01416
G1 X133.74 Y124.752 E.01228
G1 X133.74 Y125.591 E.01322
M204 S10000
G1 X133.533 Y126.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.60499
G1 F1200
M204 S1000
G1 X135.733 Y126.15 E.0507
; WIPE_START
G1 X133.733 Y126.15 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.35 Y127.342 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.38897
M73 P94 R0
G1 F1200
M204 S1000
G1 X133.35 Y126.4 E.01367
; LINE_WIDTH: 0.457067
G1 X133.35 Y126.358 E.00072
; LINE_WIDTH: 0.503151
G1 X133.35 Y126.317 E.00079
; LINE_WIDTH: 0.549235
G1 X133.35 Y126.275 E.00087
; LINE_WIDTH: 0.59532
G1 X133.35 Y126.233 E.00094
; LINE_WIDTH: 0.641404
G1 X133.35 Y126.192 E.00102
; LINE_WIDTH: 0.687488
G1 X133.35 Y126.15 E.0011
; LINE_WIDTH: 0.692956
G1 X133.411 Y126.15 E.00162
; LINE_WIDTH: 0.657774
G1 X133.472 Y126.15 E.00154
; LINE_WIDTH: 0.622591
G1 X133.533 Y126.15 E.00145
M204 S10000
G1 X133.35 Y126.15 F30000
; LINE_WIDTH: 0.692944
G1 F1200
M204 S1000
G1 X133.289 Y126.15 E.00162
; LINE_WIDTH: 0.657758
G1 X133.228 Y126.15 E.00154
; LINE_WIDTH: 0.605353
G1 X130.267 Y126.15 E.06829
; OBJECT_ID: 8
; WIPE_START
G1 X132.267 Y126.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.267 Y125.989 Z2.5 F30000
G1 X130.493 Y126.179
G1 X110.561 Y126.497
G1 X110.79 Y126.497
G1 Z2.1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.527 E.0162
G1 X110.01 Y127.527 E.01228
G1 X110.01 Y126.497 E.0162
G1 X101.41 Y126.497 E.13537
G1 X101.41 Y125.503 E.01566
G1 X110.01 Y125.503 E.13537
G1 X110.01 Y124.473 E.0162
G1 X110.79 Y124.473 E.01228
G1 X110.79 Y125.503 E.0162
G1 X116.09 Y125.503 E.08343
G1 X116.09 Y126.497 E.01566
G1 X110.85 Y126.497 E.08248
M204 S10000
G1 X110.4 Y126.249 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.388828
G1 F1200
M204 S1000
G1 X110.4 Y127.32 E.01554
G1 E-.8 F1800
M204 S10000
G1 X110.4 Y126.249 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.456647
G1 F1200
M204 S1000
G1 X110.4 Y126.208 E.00071
; LINE_WIDTH: 0.502452
G1 X110.4 Y126.166 E.00079
; LINE_WIDTH: 0.548257
G1 X110.4 Y126.125 E.00086
; LINE_WIDTH: 0.594061
G1 X110.4 Y126.083 E.00094
; LINE_WIDTH: 0.639866
G1 X110.4 Y126.042 E.00101
; LINE_WIDTH: 0.685671
G1 X110.4 Y126 E.00109
G1 E-.8 F1800
M204 S10000
G1 X115.883 Y126 Z2.5 F30000
G1 Z2.1
G1 E.8 F1800
; LINE_WIDTH: 0.60268
G1 F1200
M204 S1000
G1 X110.583 Y126 E.12167
; LINE_WIDTH: 0.620329
G1 X110.522 Y126 E.00144
; LINE_WIDTH: 0.655627
G1 X110.461 Y126 E.00153
; LINE_WIDTH: 0.690924
G1 X110.4 Y126 E.00162
G1 X110.339 Y126 E.00162
; LINE_WIDTH: 0.655627
G1 X110.278 Y126 E.00153
; LINE_WIDTH: 0.602805
G1 X101.617 Y126 E.19887
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X103.617 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 22/29
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.5 I1.217 J0 P1  F30000
G1 X103.617 Y125.839 Z2.5
G1 X115.657 Y125.968
G1 X133.075 Y125.922
G1 X133.625 Y125.92
G1 X145.081 Y125.89
G1 X145.639 Y125.989
G1 X145.74 Y125.989
G1 X145.74 Y125.888
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X147.94 Y125.888 E.03463
; object ids of layer 22 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer22 end: 8,9,10
M625
G1 X147.94 Y126.412 E.00825
G1 X145.74 Y126.412 E.03463
G1 X145.74 Y127.459 E.01648
G1 X144.96 Y127.459 E.01228
G1 X144.96 Y126.412 E.01648
G1 X142.06 Y126.412 E.04565
G1 X142.06 Y125.888 E.00825
G1 X144.96 Y125.888 E.04565
G1 X144.96 Y124.841 E.01647
G1 X145.74 Y124.841 E.01228
G1 X145.74 Y125.828 E.01553
M204 S10000
G1 X145.533 Y126.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.154576
G1 F1200
M204 S1000
G1 X145.503 Y126.15 E.00016
; LINE_WIDTH: 0.199968
G1 X145.472 Y126.15 E.00022
; LINE_WIDTH: 0.24536
G1 X145.442 Y126.15 E.00027
; LINE_WIDTH: 0.290753
G1 X145.411 Y126.15 E.00032
; LINE_WIDTH: 0.336145
G1 X145.381 Y126.15 E.00038
; LINE_WIDTH: 0.388174
G1 X145.35 Y126.15 E.00044
G1 X145.35 Y127.252 E.01596
; WIPE_START
G1 X145.35 Y126.15 E-.7395
G1 X145.381 Y126.15 E-.0205
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X147.733 Y126.15 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.13188
G1 F1200
M204 S1000
G1 X145.533 Y126.15 E.00959
G1 E-.8 F1800
M204 S10000
G1 X145.35 Y125.048 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.388358
G1 F1200
M204 S1000
G1 X145.35 Y126.15 E.01597
; LINE_WIDTH: 0.381519
G1 X145.319 Y126.15 E.00043
; LINE_WIDTH: 0.33613
G1 X145.289 Y126.15 E.00038
; LINE_WIDTH: 0.290741
G1 X145.258 Y126.15 E.00032
; LINE_WIDTH: 0.245352
G1 X145.228 Y126.15 E.00027
; LINE_WIDTH: 0.199964
G1 X145.197 Y126.15 E.00022
; LINE_WIDTH: 0.132117
G1 X142.267 Y126.15 E.01281
; OBJECT_ID: 9
; WIPE_START
G1 X144.267 Y126.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.267 Y126.311 Z2.6 F30000
G1 X142.493 Y126.106
G1 X133.74 Y125.989
G1 X133.74 Y125.888
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X135.94 Y125.888 E.03463
G1 X135.94 Y126.412 E.00825
G1 X133.74 Y126.412 E.03463
G1 X133.74 Y127.459 E.01648
G1 X132.96 Y127.459 E.01228
G1 X132.96 Y126.412 E.01648
M73 P95 R0
G1 X130.06 Y126.412 E.04565
G1 X130.06 Y125.888 E.00825
G1 X132.96 Y125.888 E.04565
G1 X132.96 Y124.841 E.01647
G1 X133.74 Y124.841 E.01228
G1 X133.74 Y125.828 E.01553
M204 S10000
G1 X133.533 Y126.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.154576
G1 F1200
M204 S1000
G1 X133.503 Y126.15 E.00016
; LINE_WIDTH: 0.199968
G1 X133.472 Y126.15 E.00022
; LINE_WIDTH: 0.24536
G1 X133.442 Y126.15 E.00027
; LINE_WIDTH: 0.290753
G1 X133.411 Y126.15 E.00032
; LINE_WIDTH: 0.336145
G1 X133.381 Y126.15 E.00038
; LINE_WIDTH: 0.388174
G1 X133.35 Y126.15 E.00044
G1 X133.35 Y127.252 E.01596
; WIPE_START
G1 X133.35 Y126.15 E-.7395
G1 X133.381 Y126.15 E-.0205
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.733 Y126.15 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.13188
G1 F1200
M204 S1000
G1 X133.533 Y126.15 E.00959
G1 E-.8 F1800
M204 S10000
G1 X133.35 Y125.048 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.388358
G1 F1200
M204 S1000
G1 X133.35 Y126.15 E.01597
; LINE_WIDTH: 0.381519
G1 X133.319 Y126.15 E.00043
; LINE_WIDTH: 0.33613
G1 X133.289 Y126.15 E.00038
; LINE_WIDTH: 0.290741
G1 X133.258 Y126.15 E.00032
; LINE_WIDTH: 0.245352
G1 X133.228 Y126.15 E.00027
; LINE_WIDTH: 0.199964
G1 X133.197 Y126.15 E.00022
; LINE_WIDTH: 0.132117
G1 X130.267 Y126.15 E.01281
; OBJECT_ID: 8
; WIPE_START
G1 X132.267 Y126.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.267 Y126.311 Z2.6 F30000
G1 X130.493 Y126.159
G1 X110.79 Y126.161
G1 X110.79 Y126.262
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.444 E.0186
G1 X110.01 Y127.444 E.01228
G1 X110.01 Y126.262 E.0186
G1 X101.41 Y126.262 E.13537
G1 X101.41 Y125.738 E.00825
G1 X110.01 Y125.738 E.13537
G1 X110.01 Y124.556 E.0186
G1 X110.79 Y124.556 E.01228
G1 X110.79 Y125.738 E.0186
G1 X116.09 Y125.738 E.08343
G1 X116.09 Y126.262 E.00825
G1 X110.85 Y126.262 E.08248
M204 S10000
G1 X110.583 Y126 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.154612
G1 F1200
M204 S1000
G1 X110.553 Y126 E.00016
; LINE_WIDTH: 0.199996
G1 X110.522 Y126 E.00022
; LINE_WIDTH: 0.245381
G1 X110.492 Y126 E.00027
; LINE_WIDTH: 0.290765
G1 X110.461 Y126 E.00032
; LINE_WIDTH: 0.336149
G1 X110.431 Y126 E.00038
; LINE_WIDTH: 0.388141
G1 X110.4 Y126 E.00044
G1 X110.4 Y127.237 E.01792
G1 E-.8 F1800
M204 S10000
G1 X110.583 Y126 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.13192
G1 F1200
M204 S1000
G1 X115.883 Y126 E.02312
; WIPE_START
G1 X113.883 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.883 Y125.839 Z2.6 F30000
G1 X110.689 Y125.839
G1 X110.561 Y125.207
G1 X110.561 Y124.989
G1 X110.4 Y124.989
G1 X110.4 Y124.763
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.388304
G1 F1200
M204 S1000
G1 X110.4 Y126 E.01792
; LINE_WIDTH: 0.381533
G1 X110.369 Y126 E.00043
; LINE_WIDTH: 0.336149
G1 X110.339 Y126 E.00038
; LINE_WIDTH: 0.290765
G1 X110.308 Y126 E.00032
; LINE_WIDTH: 0.245381
G1 X110.278 Y126 E.00027
; LINE_WIDTH: 0.199996
G1 X110.247 Y126 E.00022
; LINE_WIDTH: 0.132
G1 X101.617 Y126 E.03768
; CHANGE_LAYER
; Z_HEIGHT: 2.3
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X103.617 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 23/29
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.6 I.031 J1.217 P1  F30000
G1 X110.239 Y125.831 Z2.6
G1 X110.561 Y125.823
G1 X145.244 Y125.376
G1 X144.96 Y124.944
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X145.74 Y124.944 E.01228
; object ids of layer 23 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer23 end: 8,9,10
M625
G1 X145.74 Y127.356 E.03798
G1 X144.96 Y127.356 E.01228
G1 X144.96 Y125.004 E.03703
M204 S10000
G1 X145.35 Y125.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X145.35 Y127.149 E.02894
; OBJECT_ID: 9
; WIPE_START
G1 X145.35 Y125.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X145.35 Y125.376 Z2.7 F30000
G1 X133.457 Y125.376
G1 X133.244 Y125.376
G1 X133.244 Y125.376
G1 X132.96 Y124.944
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X133.74 Y124.944 E.01228
G1 X133.74 Y127.356 E.03798
G1 X132.96 Y127.356 E.01228
G1 X132.96 Y125.004 E.03703
M204 S10000
G1 X133.35 Y125.15 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X133.35 Y127.149 E.02894
; OBJECT_ID: 8
; WIPE_START
G1 X133.35 Y125.15 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X133.35 Y125.376 Z2.7 F30000
G1 X133.242 Y125.38
G1 X110.561 Y126.194
G1 X110.79 Y126.194
G1 Z2.3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.35 E.0182
G1 X110.01 Y127.35 E.01228
G1 X110.01 Y124.65 E.04251
G1 X110.79 Y124.65 E.01228
G1 X110.79 Y126.134 E.02336
; WIPE_START
M204 S1000
G1 X110.79 Y127.35 E-.46225
G1 X110.01 Y127.35 E-.2964
G1 X110.01 Y127.347 E-.00134
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.311 Y126.917 Z2.7 F30000
G1 X110.311 Y126.917
G1 X110.4 Y126.917
G1 X110.4 Y127.144
G1 Z2.3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y124.856 E.0331
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.4 Y126.856 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 24/29
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.7 I1.217 J0 P1  F30000
G1 X110.4 Y126.811 Z2.7
G1 X133.189 Y125.673
G1 X133.508 Y125.656
G1 X145.259 Y125.494
G1 X144.96 Y125.061
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X145.74 Y125.061 E.01228
; object ids of layer 24 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer24 end: 8,9,10
M625
G1 X145.74 Y127.238 E.03427
G1 X144.96 Y127.238 E.01228
G1 X144.96 Y125.121 E.03333
M204 S10000
G1 X145.35 Y125.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X145.35 Y127.032 E.02553
; OBJECT_ID: 9
; WIPE_START
M73 P96 R0
G1 X145.35 Y125.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X145.35 Y125.494 Z2.8 F30000
G1 X133.441 Y125.494
G1 X133.259 Y125.494
G1 X133.259 Y125.494
G1 X132.96 Y125.061
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X133.74 Y125.061 E.01228
G1 X133.74 Y127.238 E.03427
G1 X132.96 Y127.238 E.01228
G1 X132.96 Y125.121 E.03333
M204 S10000
G1 X133.35 Y125.268 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X133.35 Y127.032 E.02553
; OBJECT_ID: 8
; WIPE_START
G1 X133.35 Y125.268 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X133.35 Y125.494 Z2.8 F30000
G1 X133.258 Y125.496
G1 X110.561 Y126.041
G1 X110.79 Y126.041
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.244 E.01894
G1 X110.01 Y127.244 E.01228
G1 X110.01 Y124.756 E.03916
G1 X110.79 Y124.756 E.01228
G1 X110.79 Y125.981 E.01928
; WIPE_START
M204 S1000
G1 X110.79 Y127.244 E-.47993
G1 X110.053 Y127.244 E-.28007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.298 Y126.811 Z2.8 F30000
G1 X110.298 Y125.189
G1 X110.4 Y125.189
G1 X110.4 Y124.963
G1 Z2.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y127.037 E.03002
; CHANGE_LAYER
; Z_HEIGHT: 2.5
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X110.4 Y125.037 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 25/29
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.8 I-1.217 J0 P1  F30000
G1 X110.4 Y125.311 Z2.8
G1 X110.519 Y125.312
G1 X145.237 Y125.633
G1 X144.96 Y125.2
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X145.74 Y125.2 E.01228
; object ids of layer 25 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer25 end: 8,9,10
M625
G1 X145.74 Y127.1 E.02991
G1 X144.96 Y127.1 E.01228
G1 X144.96 Y125.26 E.02897
M204 S10000
G1 X145.35 Y125.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X145.35 Y126.893 E.02152
; OBJECT_ID: 9
; WIPE_START
G1 X145.35 Y125.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X145.35 Y125.633 Z2.9 F30000
G1 X133.463 Y125.632
G1 X133.237 Y125.633
G1 X133.237 Y125.633
G1 X132.96 Y125.2
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X133.74 Y125.2 E.01228
G1 X133.74 Y127.1 E.02991
G1 X132.96 Y127.1 E.01228
G1 X132.96 Y125.26 E.02897
M204 S10000
G1 X133.35 Y125.406 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X133.35 Y126.893 E.02152
; OBJECT_ID: 8
; WIPE_START
G1 X133.35 Y125.406 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X133.35 Y125.633 Z2.9 F30000
G1 X133.236 Y125.634
G1 X110.561 Y125.89
G1 X110.79 Y125.89
G1 Z2.5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y127.122 E.0194
G1 X110.01 Y127.122 E.01228
G1 X110.01 Y124.878 E.03532
G1 X110.79 Y124.878 E.01228
G1 X110.79 Y125.83 E.01498
M204 S10000
G1 X110.4 Y125.085 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X110.4 Y126.915 E.02649
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X110.4 Y125.085 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 26/29
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.9 I-1.217 J0 P1  F30000
G1 X110.4 Y125.453 Z2.9
G1 X110.508 Y125.454
G1 X145.247 Y125.8
G1 X144.96 Y125.367
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X145.74 Y125.367 E.01228
; object ids of layer 26 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer26 end: 8,9,10
M625
G1 X145.74 Y126.933 E.02466
G1 X144.96 Y126.933 E.01228
G1 X144.96 Y125.427 E.02371
M204 S10000
G1 X145.35 Y125.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X145.35 Y126.727 E.01669
; OBJECT_ID: 9
; WIPE_START
G1 X145.35 Y125.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X145.35 Y125.8 Z3 F30000
G1 X133.453 Y125.8
G1 X133.247 Y125.8
G1 X133.247 Y125.8
G1 X132.96 Y125.367
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X133.74 Y125.367 E.01228
G1 X133.74 Y126.933 E.02466
G1 X132.96 Y126.933 E.01228
G1 X132.96 Y125.427 E.02371
M204 S10000
G1 X133.35 Y125.574 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38795
G1 F1200
M204 S1000
G1 X133.35 Y126.727 E.01669
; OBJECT_ID: 8
; WIPE_START
G1 X133.35 Y125.574 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X133.35 Y125.8 Z3 F30000
G1 X110.561 Y125.743
G1 X110.79 Y125.743
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y126.98 E.01947
G1 X110.01 Y126.98 E.01228
G1 X110.01 Y125.02 E.03086
G1 X110.79 Y125.02 E.01228
G1 X110.79 Y125.683 E.01045
M204 S10000
G1 X110.4 Y125.226 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y126.774 E.02239
; CHANGE_LAYER
; Z_HEIGHT: 2.7
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.4 Y125.226 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 27/29
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z3 I-1.217 J0 P1  F30000
G1 X110.4 Y125.626 Z3
G1 X110.499 Y125.627
G1 X145.25 Y126.014
G1 X144.96 Y125.582
G1 Z2.7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X145.74 Y125.582 E.01228
; object ids of layer 27 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer27 end: 8,9,10
M625
G1 X145.74 Y126.719 E.0179
G1 X144.96 Y126.719 E.01228
G1 X144.96 Y125.642 E.01695
; OBJECT_ID: 9
; WIPE_START
M204 S1000
G1 X145.74 Y125.582 E-.29728
G1 X145.74 Y126.719 E-.43211
G1 X145.659 Y126.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X145.45 Y126.286 Z3.1 F30000
G1 X145.248 Y126.281
G1 X133.452 Y126.019
G1 X133.25 Y126.014
G1 X133.25 Y126.014
G1 X132.96 Y125.582
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X133.74 Y125.582 E.01228
G1 X133.74 Y126.719 E.0179
G1 X132.96 Y126.719 E.01228
G1 X132.96 Y125.642 E.01695
; OBJECT_ID: 8
; WIPE_START
M204 S1000
G1 X133.74 Y125.582 E-.29728
G1 X133.74 Y126.719 E-.43211
G1 X133.659 Y126.719 E-.03061
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X133.45 Y126.286 Z3.1 F30000
G1 X133.247 Y126.28
G1 X110.498 Y125.626
G1 X110.498 Y125.626
G1 X110.498 Y125.626
G1 X110.79 Y125.193
G1 Z2.7
G1 E.8 F1800
G1 F1200
M204 S500
G1 X110.79 Y126.807 E.0254
M73 P97 R0
G1 X110.01 Y126.807 E.01228
G1 X110.01 Y125.193 E.0254
G1 X110.73 Y125.193 E.01133
M204 S10000
G1 X110.4 Y125.4 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y126.6 E.01737
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1200
G1 X110.4 Y125.4 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 28/29
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 10
; start printing object, unique label id: 10
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z3.1 I-1.217 J0 P1  F30000
G1 X110.4 Y125.847 Z3.1
G1 X132.75 Y125.727
G1 X133.95 Y125.745
G1 X144.75 Y125.906
G1 X144.96 Y125.906
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X145.74 Y125.906 E.01228
; object ids of layer 28 start: 8,9,10
M624 BwAAAAAAAAA=
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

; object ids of this layer28 end: 8,9,10
M625
G1 X145.74 Y126.395 E.0077
G1 X144.96 Y126.395 E.01228
G1 X144.96 Y125.966 E.00676
M204 S10000
G1 X145.167 Y126.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X145.533 Y126.151 E.0011
; OBJECT_ID: 9
; WIPE_START
G1 X145.167 Y126.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 10
M625
; start printing object, unique label id: 9
M624 AgAAAAAAAAA=
M204 S10000
G1 X144.75 Y126.151 Z3.2 F30000
G1 X133.95 Y125.926
G1 X132.75 Y125.696
G1 X132.75 Y125.906
G1 X132.96 Y125.906
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X133.74 Y125.906 E.01228
G1 X133.74 Y126.395 E.0077
G1 X132.96 Y126.395 E.01228
G1 X132.96 Y125.966 E.00676
M204 S10000
G1 X133.167 Y126.151 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0973802
G1 F1200
M204 S1000
G1 X133.533 Y126.151 E.0011
; OBJECT_ID: 8
; WIPE_START
G1 X133.167 Y126.151 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 9
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X132.75 Y126.151 Z3.2 F30000
G1 X110.495 Y125.847
G1 X110.79 Y125.414
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y126.586 E.01845
G1 X110.01 Y126.586 E.01228
G1 X110.01 Y125.414 E.01845
G1 X110.73 Y125.414 E.01133
M204 S10000
G1 X110.4 Y125.621 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.38794
G1 F1200
M204 S1000
G1 X110.4 Y126.379 E.01098
; CHANGE_LAYER
; Z_HEIGHT: 2.9
; LAYER_HEIGHT: 0.1
; WIPE_START
G1 F1200
G1 X110.4 Y125.621 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 29/29
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S250
M204 S10000
G17
G3 Z3.2 I-.375 J1.158 P1  F30000
G1 X110.79 Y125.747 Z3.2
M204 S10000
G1 Z2.9
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S500
G1 X110.79 Y126.253 E.00796
G1 X110.01 Y126.253 E.01228
G1 X110.01 Y125.747 E.00796
G1 X110.73 Y125.747 E.01133
; object ids of layer 29 start: 8
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

; object ids of this layer29 end: 8
M625
M204 S10000
G1 X110.583 Y126 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.11338
G1 F1200
M204 S1000
G1 X110.217 Y126 E.00133
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1200
G1 X110.583 Y126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.3 I1.217 J0 P1  F30000
; stop printing object, unique label id: 8
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
G1 Z3.4 F900 ; lower z a little
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

    G1 Z102.9 F600
    G1 Z100.9

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

