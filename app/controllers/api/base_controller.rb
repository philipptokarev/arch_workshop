class Api::BaseController < ApplicationController
  private

  def render_json(json, opts = {})
    if opts[:serializer]
      render(json: { result: opts[:serializer].new(json) })
    else
      render(json: { result: json })
    end
  end

  def page
    params[:page].to_i > 0 ? params[:page].to_i : 1
  end
end
