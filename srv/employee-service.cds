using btp.j as bj from '../db/data-mode';

service EmployeeServices {
    entity Employees @(
        Capabilities : {  
            InsertRestrictions : {
                $Type : 'Capabilities.InsertRestrictionsType',
                Insertable,
            },
            UpdateRestrictions : {
                $Type : 'Capabilities.UpdateRestrictionsType',
                Updatable
            },
            DeleteRestrictions : {
                $Type : 'Capabilities.DeleteRestrictionsType',
                Deletable
            },
        },
    )
    as select from bj.EMPLOYEE_REGISTRY;
    annotate Employees with @odata.draft.enabled;


    @readonly entity Department as select from bj.DEPARTMENT;
    annotate Department with @odata.draft.enabled;
}

annotate EmployeeServices.Employees with @(
    UI : {
        // Filter Bar
        SelectionFields  : [
            DEPARTMENT_ID
        ],

        // Table Column
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : EMAIL_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : DEPARTMENT_ID,
            },
        ],

        // Object Page designing
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Employee',
            TypeNamePlural : 'Employees',
        },

        // Facets
        Facets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Default',
                ID   : 'Default',
                Label : 'General',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Admin',
                ID    : 'AdminData',
                Label : 'Administrative Data',
            },
        ],

        // Fieldgroups
        FieldGroup #Default : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : NAME,
                },
                {
                    $Type : 'UI.DataField',
                    Value : EMAIL_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : DEPARTMENT_ID,
                },
            ],
        },

        FieldGroup #Admin : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : createdAt,
                },
                {
                    $Type : 'UI.DataField',
                    Value : createdBy,
                },
                {
                    $Type : 'UI.DataField',
                    Value : modifiedAt,
                },
                {
                    $Type : 'UI.DataField',
                    Value : modifiedBy,
                },
            ],
        },
    }
) {
    NAME        @title : 'Name';
    EMAIL_ID    @title : 'Email ID';
    DEPARTMENT  @( 
        title : 'Department',
        Common : {  
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'Department',
                Label : 'Departments',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : DEPARTMENT_ID,
                        ValueListProperty : 'ID',
                    }
                    // {
                    //     $Type : 'Common.ValueListParameterDisplayOnly',
                    //     ValueListProperty : 'NAME',
                    // },
                ],
            },
            Text : DEPARTMENT.NAME,
            TextArrangement : #TextOnly,
        },
    
    );

}

annotate EmployeeServices.Department {
    ID @(
        Common : {  
            Text : NAME,
            TextArrangement : #TextOnly,
        },
    );
}