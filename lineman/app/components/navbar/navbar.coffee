angular.module('loomioApp').directive 'navbar', ->
  scope: {}
  restrict: 'E'
  templateUrl: 'generated/components/navbar/navbar.html'
  replace: true
  controller: ($scope, Records, ThreadQueryService) ->
    $scope.$on 'currentComponent', (el, component) ->
      $scope.selected = component

    $scope.unreadThreadCount = ->
      ThreadQueryService.unreadQuery().length()

    if !$scope.inboxLoaded
      Records.discussions.fetchDashboard(
        filter: 'show_unread'
        from: 0
        per: 100
        since: moment().subtract(3, 'month').toDate()
        timeframe_for: 'last_activity_at').then ->
        $scope.inboxLoaded = true
