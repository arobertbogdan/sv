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

  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="30" height="30" />)
      else
        match
      end
    end.html_safe if content.present?
  end

end
