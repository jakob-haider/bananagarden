App.grid = App.cable.subscriptions.create "GridChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

    # Called when there's incoming data on the websocket for this channel
  received: (data) ->
#    console.log data.content
    console.log data.content