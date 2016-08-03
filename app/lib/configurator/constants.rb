class Configurator
  # constants

  LABELS = {
    current_limits: "Current",

    l_current_max:      "Motor max",
    l_current_min:      "Motor min (regen)",
    l_in_current_max:   "Batt max",
    l_in_current_min:   "Batt min (regen)",
    l_abs_current_max:  "Absolute max",

    l_max_erpm:          "Max RPM limit (BLDC)",

    l_battery_cut_start: "Battery cutoff start",
    l_battery_cut_end:   "Battery cutoff end",

    sl_min_erpm:                 "Sensorless min RPM",
    sl_min_erpm_cycle_int_limit: "Integrator limit",
    sl_bemf_coupling_k:          "BEMF coupling",
  }

  CORE_CONFIGS = {
    current_motor: %i(
      l_current_max
      l_current_min
    ),
    current_battery: %i(
      l_in_current_max
      l_in_current_min
      l_abs_current_max
    ),
    rpm_limiting: %i(
      l_max_erpm
    ),
    battery: %i(
      l_battery_cut_start
      l_battery_cut_end
    ),
    bldc: %i(
      sl_min_erpm
      sl_min_erpm_cycle_int_limit
      sl_bemf_coupling_k
    ),
  }

end
