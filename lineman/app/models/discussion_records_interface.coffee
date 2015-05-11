angular.module('loomioApp').factory 'DiscussionRecordsInterface', (BaseRecordsInterface, DiscussionModel) ->
  class DiscussionRecordsInterface extends BaseRecordsInterface
    model: DiscussionModel

    fetchByGroup: (options = {}) ->
      @restfulClient.getCollection
        group_id: options['group_id']
        from:     options['from']
        per:      options['per']

    fetchDashboard: (options = {}) ->
      @restfulClient.get 'dashboard', options
