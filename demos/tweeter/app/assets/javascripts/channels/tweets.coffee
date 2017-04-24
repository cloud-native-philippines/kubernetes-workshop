$ ->
  console.log "DOM is ready"
  App.cable.subscriptions.create "TweetsChannel",
    received: (data) ->
      console.log data
