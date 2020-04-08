<!--
 - Created by mryzhkouskaya on 21.06.2019.
 -->

<aura:application description="Ex4_Application" extends="force:slds">

    <aura:attribute name="selectedLookUpRecords" type="sObject[]" default="[]"/>

    <c:Ex4_MultiSelectLookupCmp objectAPIName="contact"
                                 IconName="standard:contact"
                                 lstSelectedRecords="{!v.selectedLookUpRecords}"
                                 label="Contact Name"/>

</aura:application>