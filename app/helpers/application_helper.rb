module ApplicationHelper
  def signed_in?
    !current_user.nil?
  end

  def button_status(story)
    links = case story.status
              when Story::STATUS_UNSTARTED
                [{status: 'Started',
                  col: 'default'
                 }]
              when Story::STATUS_STARTED
                [{status: 'Finished',
                  col: 'primary'
                 }]
              when Story::STATUS_FINISHED
                [{status: 'Delivered',
                  col: 'warning'
                 }]
              when Story::STATUS_DELIVERED
                [{status: 'Accepted',
                  col: 'success'
                 },
                 {status: 'Rejected',
                  col: 'danger'
                 }]
              when Story::STATUS_REJECTED
                [{status: 'Unstarted',
                  col: 'default'
                 }]
            end
    links.each_with_object([]) do |link, obj|
      obj << link_to(link[:status], project_story_path(story.project, story, story: {status: link[:status]}), method: "put", :class => "btn btn-#{link[:col]}")

    end.join("").html_safe

  end



  def sortable(column, title )
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}
  end


  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
