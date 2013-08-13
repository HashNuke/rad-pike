#= require angular
#= require angular-resource
#= require ../init
#= require ../config
#= require_tree ../resolvers
#= require_tree ../../templates

class window.RadPikeSupportWidget
  templateCache: {}
 
  constructor: (options={})->

    options.unique_user_id = ""
    options.agent_id       = ""

    iframeStyle = """
      position: absolute;
      bottom: 0; right: 0;
      height: 20em;
      width: 20em;
      border: 1px solid #CCC;
      box-shadow: 0px 0px 3px 1px #CCC
    """

    template = """<iframe seamless='seamless' src='http://radpike.dev:3000/widgets/support'
      style='#{iframeStyle}'></iframe>
    """
    document.write(template)


  #TODO note required. Maybe delete
  # tmpl: (str, data)->
  #   # Figure out if we're getting a template, or if we need to
  #   # load the template - and be sure to cache the result.
  #   fn = if !/\W/.test(str)
  #     @templateCache[str] = @templateCache[str] || @tmpl(document.getElementById(str).innerHTML)
  #   else @parser()

  #   # Provide some basic currying to the user
  #   if data then fn(data) else fn


  # parser: ->
  #   # Generates a reusable function that will serve as a template
  #   # generator (and which will be cached).
  #   new Function("obj",
  #     "var p=[],print=function(){p.push.apply(p,arguments);};" +
     
  #     # Introduce the data as local variables using with(){}
  #     "with(obj){p.push('" +

  #     # Convert the template into pure JavaScript
  #     str
  #       .replace(/[\r\t\n]/g, " ")
  #       .split("<\%").join("\t")
  #       .replace(/((^|%>)[^\t]*)'/g, "$1\r")
  #       .replace(/\t=(.*?)%>/g, "',$1,'")
  #       .split("\t").join("');")
  #       .split("%>").join("p.push('")
  #       .split("\r").join("\\'")
  #   + "');}return p.join('');")
