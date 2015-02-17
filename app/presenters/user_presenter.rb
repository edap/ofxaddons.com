class UserPresenter < Presenter

  def avatar
    if avatar?
      h.image_tag(nil, class:"userIcon lazy", data:{ src:"#{ object.avatar_url }&amp;s=16" }, width: "16px", height: "16px")
    else
      h.image_tag("default-gravatar-small.png", class: "userIcon", width: "16px", height: "16px")
    end
  end

  # TODO: delete me when owner is normalized
  def avatar?
    !object.avatar_url.blank?
  end

  # HTML escape this string since we don't control it
  # def login
  #   h.html_escape(object.login)
  # end

  def repo_count
    if object.attributes["repo_count"]
      object.attributes["repo_count"]
    else
      # we could fall back to a DB query, but I'll put this here instead to avoid the n extra queries
      raise "you need to roll up repo_count into a synthetic attr (see User.with_repo_counts)"
    end
  end

  def to_s
    h.link_to(h.contributor_path(object)) do
      "#{ avatar } #{ login }".html_safe
    end
  end

end