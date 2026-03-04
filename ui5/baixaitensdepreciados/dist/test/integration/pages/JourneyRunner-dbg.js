sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assy/gm/baixadepreciacao/baixaitensdepreciados/test/integration/pages/AssetRetireList",
	"assy/gm/baixadepreciacao/baixaitensdepreciados/test/integration/pages/AssetRetireObjectPage"
], function (JourneyRunner, AssetRetireList, AssetRetireObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assy/gm/baixadepreciacao/baixaitensdepreciados') + '/test/flp.html#app-preview',
        pages: {
			onTheAssetRetireList: AssetRetireList,
			onTheAssetRetireObjectPage: AssetRetireObjectPage
        },
        async: true
    });

    return runner;
});

