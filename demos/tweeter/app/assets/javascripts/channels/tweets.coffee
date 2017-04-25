$ ->
  console.log "DOM is ready"

  $("table#tweets tbody").on "click", "tr.tweet-row[data-tweet-id]", (e) ->
    console.log("clicked", e.currentTarget.attributes["data-tweet-id"].value)
    window.location.href = e.currentTarget.attributes["data-href"].value

  App.cable.subscriptions.create "TweetsChannel",
    received: (data) ->
      console.log data
      $("table#tweets tbody").prepend("<tr></tr>")

