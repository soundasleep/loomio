class API::DiscussionsController < API::RestfulController
  load_and_authorize_resource only: [:show, :mark_as_read, :set_volume]
  load_resource only: [:create, :update]

  def discussions_for_dashboard
    instantiate_collection { |collection| discussions_for_preview(collection) }
    respond_with_discussions
  end

  def discussions_for_inbox
    instantiate_collection(page: false) { |collection| discussions_for_preview(collection, :show_unread) }
    respond_with_discussions
  end

  def index
    instantiate_collection
    respond_with_discussions
  end

  def show
    respond_with_discussion
  end

  private

  def respond_with_discussion
    if resource.errors.empty?
      render json: DiscussionWrapper.new(discussion: resource, discussion_reader: discussion_reader),
             serializer: DiscussionWrapperSerializer,
             root: 'discussion_wrappers'
    else
      respond_with_errors
    end
  end

  def respond_with_discussions
    render json: DiscussionWrapper.new_collection(user: current_user, discussions: @discussions),
           each_serializer: DiscussionWrapperSerializer,
           root: 'discussion_wrappers'
  end

  def discussion_params
    params.require(:discussion).permit([:title,
                                        :description,
                                        :uses_markdown,
                                        :group_id,
                                        :private,
                                        :iframe_src])
  end

  def visible_records
    Queries::VisibleDiscussions.new(user: current_user, groups: current_user.groups)
  end

  private

  def discussions_for_preview(collection, filter = params[:filter])
    case filter
    when 'show_proposals'     then collection.not_muted.with_active_motions
    when 'show_participating' then collection.not_muted.participating
    when 'show_muted'         then collection.muted
    when 'show_unread'        then collection.not_muted.unread
    else                           collection.not_muted
    end
  end

  def discussion_reader
    @dr ||= DiscussionReader.for(user: current_user, discussion: @discussion)
  end
end
