class UrlsController < ::Api::V1::UrlsController

  def show
    @url = ShortenUrl::ShortUrl.find_by(short_url: fix_missing_tld)
  end
  
  def new; end

  def originate_url; end

  private
  def fix_missing_tld
    return params[:short_url] if params[:short_url].end_with?('.try')

    params[:short_url] + '.try'
  end
end
