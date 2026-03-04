sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'assy.gm.baixadepreciacao.baixaitensdepreciados',
            componentId: 'AssetRetireObjectPage',
            contextPath: '/AssetRetire'
        },
        CustomPageDefinitions
    );
});