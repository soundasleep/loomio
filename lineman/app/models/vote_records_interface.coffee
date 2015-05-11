angular.module('loomioApp').factory 'VoteRecordsInterface', (BaseRecordsInterface, VoteModel) ->
  class VoteRecordsInterface extends BaseRecordsInterface
    model: VoteModel

    fetchMyRecentVotes: ->
      @fetchCustomPath 'my_votes', {}, 'myVotes'

    fetchMyVotesByDiscussion: (discussion) ->
      @fetchCustomPath 'my_votes', { discussion_key: discussion.key }, "myVotesFor#{discussion.key}"

    fetchByProposal: (proposal) ->
      @fetch { motion_id: proposal.id }, "votesFor#{proposal.key}"
