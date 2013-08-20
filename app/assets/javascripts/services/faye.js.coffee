App.factory 'Faye', ($window, Auth) ->
  client = new Faye.Client("#{$window.broadcasterHost}/faye")
