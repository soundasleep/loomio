angular.module('loomioApp').factory 'GroupRecordsInterface', (BaseRecordsInterface, GroupModel) ->
  class GroupRecordsInterface extends BaseRecordsInterface
    model: GroupModel

    fetchByParent: (parentGroup) ->
      @fetchCustomPath "#{parentGroup.id}/subgroups", {}, "subgroupsFor#{parentGroup.key}"
