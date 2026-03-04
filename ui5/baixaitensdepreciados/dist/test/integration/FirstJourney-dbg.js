sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheAssetRetireList.iSeeThisPage();
            Then.onTheAssetRetireList.onTable().iCheckColumns(5, {"CompanyCode":{"header":"Company Code"},"MasterFixedAsset":{"header":"Asset"},"FixedAsset":{"header":"Subnumber"},"AssetDescription":{"header":"AssetDescription"},"AssetClass":{"header":"AssetClass"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheAssetRetireList.onFilterBar().iExecuteSearch();
            
            Then.onTheAssetRetireList.onTable().iCheckRows();

            When.onTheAssetRetireList.onTable().iPressRow(0);
            Then.onTheAssetRetireObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});