# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Rails.application.config.assets.precompile += [/.*\.js/,/.*\.css/]
Rails.application.config.assets.precompile += %w[ *.gif *.jpg *.jpeg *.png ]

Rails.application.config.assets.precompile += %w(
  base.css
  base.js
  /fonts/fontawesome-webfont.eot
  /fonts/fontawesome-webfont.woff
  /fonts/fontawesome-webfont.ttf
  /fonts/fontawesome-webfont.svg
  /fonts/Simple-Line-Icons.eot
  /fonts/Simple-Line-Icons.svg
  /fonts/Simple-Line-Icons.ttf
  /fonts/Simple-Line-Icons.woff
  /fonts/weathericons-regular-webfont.eot
  /fonts/weathericons-regular-webfont.woff
  /fonts/weathericons-regular-webfont.svg
  /fonts/weathericons-regular-webfont.ttf
  /fonts/glyphicons-halflings-regular.svg
  /fonts/glyphicons-halflings-regular.ttf
  /fonts/glyphicons-halflings-regular.woff
  /fonts/summernote.eot
  /fonts/summernote.ttf
  /fonts/summernote.woff
)