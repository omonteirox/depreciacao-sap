sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'assy.gm.baixadepreciacao.baixaitensdepreciados',
            componentId: 'AssetRetireList',
            contextPath: '/AssetRetire'
        },
        CustomPageDefinitions
    );
});