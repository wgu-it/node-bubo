# Description:
#   Pulls gifs from rightgif.com
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   gif [me] <search term> - Get the right gif for the search term
#
# Author:
#   fuadsaud

module.exports = (robot) ->

  robot.hear /!(?:gif|animate)( me)? (.*)/i, (msg) ->
    if msg.message.room == 'C0Z77BT4M' or msg.message.room == 'C0Z77BT8V' or msg.message.room == 'Shell'
      rightGif msg, msg.match[2], (url) ->
        msg.send url

rightGif = (msg, query, cb) ->
  url = 'https://rightgif.com/search/web'
  data = JSON.stringify(text: query)

  msg.http(url)
    .header('Content-Type', 'application/json')
    .post(data) (err, res, body) ->
      if err or res.statusCode isnt 200
        msg.send 'I got an error from rightgif :('
        return

      msg.send JSON.parse(body).url
