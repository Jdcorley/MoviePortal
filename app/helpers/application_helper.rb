module ApplicationHelper
  def copyright_generator
    CorleyViewTool::Renderer.copyright 'John Corley', "All Rights Reserved."
  end
end
