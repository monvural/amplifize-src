class SharesController < ApplicationController
  before_filter :require_user

  def add    
    share = Share.add(params[:summary], params[:postId], current_user.id)

    respond_to do |format|
      format.js { render :json => share }
    end
  end

  def add_by_link
    share = Share.add_by_link(params[:summary], params[:url], current_user.id)

    respond_to do |format|
      format.js {render :json => share }
    end
  end

  def add_remote
    render :content_type => 'application/javascript'
  end

  def search
    @search = params[:search]
    share_ids = Share.search_for_ids(params[:search])
    @shares = current_user.share_users.select("share_users.*, posts.title AS post_title, users.display_name AS display_name, users.email AS email").joins(:share => [:post, :user]).where(:share_id => share_ids)

    @posts_unread_count = current_user.feeds_unread_count
    @shares_unread_count = current_user.shares_unread_count

    @comment = Comment.new

    render :layout => 'reader_layout'
  end

  def show
    share = Share.find_by_id(params[:id])

    respond_to do |format|
      format.js {render :json => share.to_json(
        :include => {
          :comments => { 
            :include => {
              :user => {:only => [:id, :email, :display_name]} 
             },
          },
          :post => {
            :include => :feed
          },
          :user => {:only => [:id, :email, :display_name] }
        }
      )}
    end
  end
end
