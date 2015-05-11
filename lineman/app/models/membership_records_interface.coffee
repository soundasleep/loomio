angular.module('loomioApp').factory 'MembershipRecordsInterface', (BaseRecordsInterface, MembershipModel) ->
  class MembershipRecordsInterface extends BaseRecordsInterface
    model: MembershipModel

    fetchMyMemberships: ->
      @fetchCustomPath 'my_memberships', {}, "myMemberships"

    fetchByNameFragment: (fragment, groupKey) ->
      @fetchCustomPath 'autocomplete', { q: fragment, group_key: groupKey } # don't cache this query! ¯\_(ツ)_/¯

    fetchByGroup: (groupKey) ->
      @fetch { group_key: groupKey }, "membershipsFor#{groupKey}"

    makeAdmin: (membership) ->
      @restfulClient.postMember membership.id "make_admin"

    removeAdmin: (membership) ->
      @restfulClient.postMember membership.id "remove_admin"
