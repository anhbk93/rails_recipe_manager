module ApplicationHelper
  def gravatar_for(chef, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(chef.email.downcase)
    size = options[:size]
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: chef.chefname, class: "gravatar")
  end

  # returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "My Recipe App - AnhNV";
    if  page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
