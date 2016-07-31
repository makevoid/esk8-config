# VESC Config Web Tool

### [config.esk8.it](http://config.esk8.it)



Enjoy!

---

### Prerequisites

Ruby 1.9+ installed


### Setup and start

```sh
$ gem i bundle

$ bundle install
$ bundle exec inesita server
```

Go to [http://localhost:9292/](http://localhost:9292/)


---


###




```hson
# current.hson


{


# motor current

l_current_max:      70
l_current_min:      70
l_in_current_max:   35
l_in_current_min:   20
l_abs_current_max: 130


# RPM limit

l_max_erpm:        100000


# Battery (8S Lipo)

l_battery_cut_start:   28
l_battery_cut_end:   26.4


# BLDC
sl_min_erpm:                  150
sl_min_erpm_cycle_int_limit:  1100
sl_bemf_coupling_k:           600


}
```
