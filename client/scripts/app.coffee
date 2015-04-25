'use strict';

angular.module('app', [
    # Angular modules
    'ngRoute'
    'ngAnimate'
    'ngResource'

    # 3rd Party Modules
    'ui.bootstrap'
    'easypiechart'
    'mgo-angular-wizard'
    'textAngular'
    'ui.tree'
    'ngTagsInput'
    'restangular'
    'rt.encodeuri'
    'ui.ace'
    'ng-context-menu'
    'xeditable'

    # Custom modules
    'app.ui.ctrls'
    'app.ui.directives'
    'app.ui.services'
    'app.controllers'
    'app.services'
    'app.directives'
    'app.form.validation'
    'app.ui.form.ctrls'
    'app.ui.form.directives'
    'app.tables'
    'app.task'
    'app.localization'
    'app.chart.ctrls'
    'app.chart.directives'
    'app.page.ctrls'
    'app.applications.ctrls'
    'app.applications.services'
    'app.endpoints.ctrls'
    'app.endpoints.services'
    'app.content.ctrls'
    'app.content.services'
    'app.directory.ctrls'
    'app.directory.services'
    'app.users.ctrls'
    'app.users.services'
    'angularFileUpload'
    'emguo.poller'
])
    
.config([
    '$routeProvider','$httpProvider' ,'RestangularProvider', 'pollerConfig'
    ($routeProvider, $httpProvider, RestangularProvider, pollerConfig) ->

        $.get( "/api/auth/authenticateduser", ( user ) ->
            if(!user.isAuthenticated)
                window.location.href='/login.html'
        )

        pollerConfig.stopOnStateChange = true
        pollerConfig.stopOnRouteChange = true

        Ladda.bind( 'button[type=submit]' );
        # toastr setting.  this is the ui error notification framework
        toastr.options =
            "closeButton": true
            "positionClass": "toast-bottom-right"
            "timeOut": "3000"

        RestangularProvider.setBaseUrl('/api/');
        #RestangularProvider.setDefaultHttpFields({cache: true});
        RestangularProvider.setErrorInterceptor((response) ->
            if (response.status == 401)
                console.log("Login required... ")
                window.location.href='/login.html'
            else if (response.status == 400)
                
                msg = "An error occurred while processing your request"
                
                if(response.data && response.data.message)
                    msg = response.data.message;
                
                console.log("Bad Request: " + msg);
                toastr["error"](msg);
            
            else
                console.log("Response received with HTTP error code: " + response.status);
                if (response.data && response.data.message)
                    msg = response.data.message;
                else
                    msg = "An error occurred while processing your request";
                
                toastr["error"](msg);
                return true;
            
        );



        $routeProvider
            # dashboard
            .when(
                '/'
                redirectTo: '/home'
            )
            .when(
                '/home'
                templateUrl: 'views/dashboard.html'
            )
            # applications
            .when('/applications', {templateUrl: 'views/applications/list.html'})
            .when('/applications/:Id/edit', {templateUrl: 'views/applications/edit.html'})
            .when('/applications/new', {templateUrl: 'views/applications/new.html'})
            # routes
            .when('/applications/:Id/routes', {templateUrl: 'views/routes/list.html'})
            .when('/applications/:Id/routes/:routeId/edit', {templateUrl: 'views/routes/edit.html'})
            .when('/applications/:Id/routes/new', {templateUrl: 'views/routes/new.html'})
            # content
            .when('/contents', {templateUrl: 'views/contents/list.html'})
            .when('/contents/:Id/edit', {templateUrl: 'views/contents/edit.html'})
            .when('/contents/:Id/view', {templateUrl: 'views/contents/view.html'})
            .when('/contents/new', {templateUrl: 'views/contents/new.html'})
            .when('/contents/newlayout', {templateUrl: 'views/contents/newlayout.html'})
            .when('/contents/upload', {templateUrl: 'views/contents/upload.html'})
            .when('/contents/newfiles', {templateUrl: 'views/contents/newfiles.html'})
            .when('/cms', {templateUrl: 'views/contents/cmshome.html'})
            .when('/cms/items', {templateUrl: 'views/contents/cmslist.html'})
            .when('/cms/types', {templateUrl: 'views/contents/cmstypes.html'})
            .when('/cms/workflows', {templateUrl: 'views/contents/cmsworkflows.html'})
            .when('/cms/audit', {templateUrl: 'views/contents/cmsaudit.html'})
            .when('/cms/new', {templateUrl: 'views/contents/cmsnew.html'})
            # users
            .when('/users', {templateUrl: 'views/users/list.html'})
            .when('/users/:Id/edit', {templateUrl: 'views/users/edit.html'})
            .when('/users/new', {templateUrl: 'views/users/new.html'})
            # UI Kit
            .when(
                '/ui/typography'
                templateUrl: 'views/ui/typography.html'
            )
            .when(
                '/ui/buttons'
                templateUrl: 'views/ui/buttons.html'
            )
            .when(
                '/ui/icons'
                templateUrl: 'views/ui/icons.html'
            )
            .when(
                '/ui/grids'
                templateUrl: 'views/ui/grids.html'
            )
            .when(
                '/ui/widgets'
                templateUrl: 'views/ui/widgets.html'
            )
            .when(
                '/ui/components'
                templateUrl: 'views/ui/components.html'
            )
            .when(
                '/ui/timeline'
                templateUrl: 'views/ui/timeline.html'
            )
            .when(
                '/ui/nested-lists'
                templateUrl: 'views/ui/nested-lists.html'
            )
            .when(
                '/ui/pricing-tables'
                templateUrl: 'views/ui/pricing-tables.html'
            )

            # Forms
            .when(
                '/forms/elements'
                templateUrl: 'views/forms/elements.html'
            )
            .when(
                '/forms/layouts'
                templateUrl: 'views/forms/layouts.html'
            )
            .when(
                '/forms/validation'
                templateUrl: 'views/forms/validation.html'
            )
            .when(
                '/forms/wizard'
                templateUrl: 'views/forms/wizard.html'
            )

            # Maps
            .when(
                '/maps/gmap'
                templateUrl: 'views/maps/gmap.html'
            )
            .when(
                '/maps/jqvmap'
                templateUrl: 'views/maps/jqvmap.html'
            )

            # Tables
            .when(
                '/tables/static'
                templateUrl: 'views/tables/static.html'
            )
            .when(
                '/tables/responsive'
                templateUrl: 'views/tables/responsive.html'
            )
            .when(
                '/tables/dynamic'
                templateUrl: 'views/tables/dynamic.html'
            )

            # Charts
            .when(
                '/charts/others'
                templateUrl: 'views/charts/charts.html'
            )
            .when(
                '/charts/morris'
                templateUrl: 'views/charts/morris.html'
            )
            .when(
                '/charts/flot'
                templateUrl: 'views/charts/flot.html'
            )

            # Mail
             .when(
                '/mail/inbox'
                templateUrl: 'views/mail/inbox.html'
            )
             .when(
                '/mail/compose'
                templateUrl: 'views/mail/compose.html'
            )
             .when(
                '/mail/single'
                templateUrl: 'views/mail/single.html'
            )

            # Pages
            .when(
                '/pages/features'
                templateUrl: 'views/pages/features.html'
            )
            .when(
                '/pages/signin'
                templateUrl: 'views/pages/signin.html'
            )
            .when(
                '/pages/signout'
                templateUrl: 'views/pages/signout.html'
            )
            .when(
                '/pages/signup'
                templateUrl: 'views/pages/signup.html'
            )
            .when(
                '/pages/forgot'
                templateUrl: 'views/pages/forgot-password.html'
            )
            .when(
                '/pages/lock-screen'
                templateUrl: 'views/pages/lock-screen.html'
            )
            .when(
                '/pages/profile'
                templateUrl: 'views/pages/profile.html'
            )
            .when(
                '/404'
                templateUrl: 'views/pages/404.html'
            )
            .when(
                '/pages/500'
                templateUrl: 'views/pages/500.html'
            )
            .when(
                '/pages/blank'
                templateUrl: 'views/pages/blank.html'
            )
            .when(
                '/pages/invoice'
                templateUrl: 'views/pages/invoice.html'
            )
            .when(
                '/pages/services'
                templateUrl: 'views/pages/services.html'
            )
            .when(
                '/pages/about'
                templateUrl: 'views/pages/about.html'
            )
            .when(
                '/pages/contact'
                templateUrl: 'views/pages/contact.html'
            )

            # Account Settings
            .when(
                '/pages/settings'
                templateUrl: 'views/pages/settings.html'
            )
            .otherwise(
                redirectTo: '/404'
            )
])
.run([
    '$rootScope', 'Restangular'
    ($rootScope, Restangular) ->

        Restangular.addRequestInterceptor((element) -> 
            $rootScope.loading = true;
            return element;
        );
        Restangular.addResponseInterceptor((data) -> 
            $rootScope.loading = false;
            return data;
        );
])
