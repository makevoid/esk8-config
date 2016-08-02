DEFAULT_CONFIG = '
{"pwm_mode":"1","comm_mode":"0","motor_type":"0","sensor_mode":"0","l_current_max":"70","l_current_min":"-70","l_in_current_max":"40","l_in_current_min":"-30","l_abs_current_max":"130","l_min_erpm":"-100000","l_max_erpm":"100000","l_max_erpm_fbrake":"300","l_max_erpm_fbrake_cc":"1500","l_min_vin":"8","l_max_vin":"57","l_battery_cut_start":"28","l_battery_cut_end":"26.4","l_slow_abs_current":"1","l_rpm_lim_neg_torque":"1","l_temp_fet_start":"80","l_temp_fet_end":"100","l_temp_motor_start":"80","l_temp_motor_end":"100","l_min_duty":"0.005","l_max_duty":"0.95","sl_min_erpm":"150","sl_min_erpm_cycle_int_limit":"1100","sl_max_fullbreak_current_dir_change":"10","sl_cycle_int_limit":"105","sl_cycle_int_limit_high_fac":"0.8","sl_cycle_int_rpm_br":"80000","sl_bemf_coupling_k":"600","hall_table_0":"-1","hall_table_1":"1","hall_table_2":"3","hall_table_3":"2","hall_table_4":"5","hall_table_5":"6","hall_table_6":"4","hall_table_7":"-1","hall_sl_erpm":"2000","foc_current_kp":"0.03","foc_current_ki":"50","foc_f_sw":"20000","foc_dt_us":"0.08","foc_encoder_inverted":"0","foc_encoder_offset":"180","foc_encoder_ratio":"7","foc_sensor_mode":"0","foc_pll_kp":"2000","foc_pll_ki":"20000","foc_motor_l":"7e-06","foc_motor_r":"0.015","foc_motor_flux_linkage":"0.00245","foc_observer_gain":"9e+07","foc_duty_dowmramp_kp":"10","foc_duty_dowmramp_ki":"200","foc_openloop_rpm":"1200","foc_sl_openloop_hyst":"0.5","foc_sl_openloop_time":"0.5","foc_sl_d_current_duty":"0","foc_sl_d_current_factor":"0","foc_hall_table_0":"255","foc_hall_table_1":"255","foc_hall_table_2":"255","foc_hall_table_3":"255","foc_hall_table_4":"255","foc_hall_table_5":"255","foc_hall_table_6":"255","foc_hall_table_7":"255","foc_sl_erpm":"2500","s_pid_kp":"0.0001","s_pid_ki":"0.015","s_pid_kd":"0","s_pid_min_rpm":"900","p_pid_kp":"0.03","p_pid_ki":"0","p_pid_kd":"0.0004","p_pid_ang_div":"1","cc_startup_boost_duty":"0.01","cc_min_current":"1","cc_gain":"0.0046","cc_ramp_step_max":"0.4","m_fault_stop_time_ms":"3000","m_duty_ramp_step":"0.02","m_duty_ramp_step_rpm_lim":"0.0005","m_current_backoff_gain":"0.5","m_encoder_counts":"8192","m_sensor_port_mode":"0"}
'

class Store
  include Inesita::Store

  def initialize
    @configurator = Configurator.new DEFAULT_CONFIG, type: :json
    @store = @configurator.config

    store = @store.to_n
    if `localStorage.esk8_config`
      #   @store = Hash.new `localStorage.esk8_config_store`
      @store.each do |key, _|
        val = `localStorage["esk8_config_"+key]`
        set key, val.to_i
      end
    end
  end

  def set(key, value)
    @store[key] = value
  end

  def get(key)
    @store[key]
  end

  def save!
    @store.each do |key, val|
      `localStorage["esk8_config_"+key] = val`
    end
    `localStorage.esk8_config = true`
  end
end
