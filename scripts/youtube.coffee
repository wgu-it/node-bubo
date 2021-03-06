# Description:
#   Messing around with the YouTube API.
#
# Commands:
#   hubot youtube me (-) <query> - Searches YouTube for the query and returns the video embed link.

module.exports = (robot) ->
  robot.respond /(video|vid)( me)?( -)? (.*)/i, (msg) ->
    if msg.message.room == 'C0Z77BT4M' or msg.message.room == 'C0Z77BT8V' or msg.message.room == 'Shell'
      norandom = msg.match[3]?
      query = msg.match[4]
      robot.http("https://www.googleapis.com/youtube/v3/search")
        .query({
          key: process.env.HUBOT_YOUTUBE_KEY
          part: "id"
          type: "video"
          order: "relevance"
          maxResults: 15
          q: query
        })
        .get() (err, res, body) ->
          result = JSON.parse(body)
          videos = result.items

          unless videos?
            msg.send "No video results for \"#{query.substr(0,30)}\""
            return

          video = if norandom then videos[0] else msg.random videos
          msg.send "https://youtu.be/" + video.id.videoId
