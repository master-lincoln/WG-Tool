Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'ad04e1df4ddcc311e765', '45257b03f836b6c770f896049eac024c021718f1'
end
