/**
 * Created by mryzhkouskaya on 08.07.2019.
 */

public with sharing class Ex5_FieldSetMemberWrapper {

    public Boolean isRequired 						 { get; set; }
    public String fieldType 						 { get; set; }
    public String fieldLabel 						 { get; set; }
    public String fieldAPIName 					     { get; set; }
    public String relationShipNameForLookup 		 { get; set; }

    public List<Schema.PicklistEntry> pickListValues { get; set; }

    public String nameControllerField 	             { get; set; }
    public String  nameNextPicklist                  { get; set; }


   
}