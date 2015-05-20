module ApplicationHelper
  def self.time_diff time
    t = (Time.now - time).to_i.abs
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    if mm == 0 && hh == 0 && dd == 0
      mm = 1
    end
    get_time_unit(dd,"day") + get_time_unit(hh,"hour") + get_time_unit(mm,"minute")
  end

  private

  def self.get_time_unit value, type
    value != 0 ? value.to_s + " " + pluralize(value, type) + " " : ""
  end

  def self.pluralize value, type
    value == 1 ? type : type + "s"
  end


end
