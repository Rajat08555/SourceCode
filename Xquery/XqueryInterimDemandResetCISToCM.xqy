xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../Schema/HESCMDemandReset.xsd" ::)
declare namespace ns1="http://services.NSPI.com/File/schema/CISInterimDemandReset/v1";
(:: import schema at "../Schema/CISInterimDemandReset.xsd" ::)

declare variable $Input as element() (:: schema-element(ns1:DemandReset) ::) external;

declare function local:func($Input as element() (:: schema-element(ns1:DemandReset) ::)) as element() (:: schema-element(ContingencyReadByEndpoints) ::) {
    <ContingencyReadByEndpoints>
        <request>
            <EndpointCollectionRequest>
                <ElectronicSerialNumbers>
                    
                    {
                    for $Record in $Input/ns1:Record
                    let $meterNbrVar := fn-bea:execute-sql('jdbc/nspi_fmw', xs:QName('ESN'), fn:concat('select ESN from AMI_ASN_FILE WHERE EID=', '&apos;', fn:data($Record/ns1:MeterNumber), '&apos;'))
                    return <string>{fn:data($meterNbrVar)}</string>
                    }

                </ElectronicSerialNumbers>
                <StatusChangedService></StatusChangedService>
            </EndpointCollectionRequest>
            <Parameters>
            <ReadingStartTime>{fn:data(fn:current-dateTime())}</ReadingStartTime>
            <ReadingEndTime>{fn:data(fn:current-dateTime())}</ReadingEndTime>
            <PerformDemandReset>true</PerformDemandReset>
            <RetrieveHomeNetworkData>false</RetrieveHomeNetworkData>
            <RetrieveInstantaneousData>true</RetrieveInstantaneousData>
            <RetrieveLastDemandReset>true</RetrieveLastDemandReset>
            <RetrieveLoadProfileData>false</RetrieveLoadProfileData>
            <RetrieveLogEvents>false</RetrieveLogEvents>
            <RetrieveNetworkStatistics>false</RetrieveNetworkStatistics>
            <RetrievePriorSelfRead>false</RetrievePriorSelfRead>
            <RetrieveRecentRegisters>false</RetrieveRecentRegisters>
            <RetrieveVoltageMonitorData>false</RetrieveVoltageMonitorData>
            <ReportSelfReadOption>None</ReportSelfReadOption>
            <RetrieveExtendedCurrentData>false</RetrieveExtendedCurrentData>
            <RetrievePriorExtendedSelfReadData>false</RetrievePriorExtendedSelfReadData>
            <RetrieveInstrumentationProfileData>false</RetrieveInstrumentationProfileData>
            <RetrieveExtendedLoadProfileData>false</RetrieveExtendedLoadProfileData>
            <RetrieveToolboxData>false</RetrieveToolboxData>
            <RetrieveAgentOutcomeData>false</RetrieveAgentOutcomeData>
            <RetrieveAgentDirectorData>false</RetrieveAgentDirectorData>
            <RetrieveTemperatureMonitoringData>false</RetrieveTemperatureMonitoringData>
            </Parameters>
        </request>
    </ContingencyReadByEndpoints>
};

local:func($Input)