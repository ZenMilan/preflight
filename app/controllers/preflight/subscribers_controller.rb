module Preflight
  class SubscribersController < ApplicationController
    respond_to :html
    before_action :check_subscription

    def new
      @subscriber = Subscriber.new
    end

    def create
      opt_in = Preflight::OptIn.new(
        subscriber_params,
        campaign,
        request,
        cookies)

      opt_in.save
      @subscriber = opt_in.subscriber
      redir_path = root_path
      if sub = opt_in.subscription
        redir_path = sharing_center_path
      end

      respond_with(@subscriber, location: redir_path)
    end

    protected
    def check_subscription
      if cookies.signed[Preflight.subscription_cookie_key]
        redirect_to sharing_center_path
      end
    end

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end

    def campaign
      if params[:campaign_id]
        @campaign ||= Campaign.find_using_slug!(params[:campaign_id])
      else
        @campaign ||= Campaign.active.first
      end
    end
  end
end
