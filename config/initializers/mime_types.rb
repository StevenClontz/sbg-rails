# Be sure to restart your server when you modify this file.

Mime::Type.register "text/tex", :tex

Mime::Type.register "application/pdf", :pdf, ['text/pdf'], ['pdf']

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
