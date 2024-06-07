local M = {}

M.testAttributes = { "Fact", "Theory", "BddfyTheory", "BddfyFact" }

M.isTestFileQuery = [[
    (method_declaration
        (attribute_list
            (attribute name: (identifier) @test.type
                (#any-of? @test.type ]] .. table.concat(M.testAttributes, " ") .. [[))
            )
        name: (identifier) @test.name
    ) @test.definition
]]

M.testDetectionQueries = { [[
    (method_declaration
        (attribute_list
            (attribute name: (identifier) @test.type (#any-of? @test.type "Fact" "BddfyFact"))
        )
        name: (identifier) @test.name
    ) @test.definition
    ]],
    [[
    (method_declaration
        (attribute_list
            (attribute name: (identifier) @test.type (#any-of? @test.type "Theory" "BddfyTheory"))
        )
        name: (identifier) @namespace.name
    ) @namespace.definition
    ]],
    [[
    (method_declaration
        (attribute_list
            (attribute name: (identifier) @test.type (#any-of? @test.type "Theory" "BddfyTheory"))
        )
        (attribute_list
            (attribute
                name: (identifier) @data_attribute (#eq? @data_attribute "InlineData")
                (attribute_argument_list) @test.name
            ) @test.definition
        )
        name: (identifier) @method.name
    )
]] }

function M.wrapInNamespace(query)
    return [[
    ;; Matches namespace with a '.' in the name
    (namespace_declaration name: (qualified_name) @namespace.identifier body: (declaration_list
        (class_declaration name: (identifier) @class.name body: (declaration_list
            ]] .. query .. [[
        ))
    ))

    ;; Matches namespace with a single identifier (no '.')
    (namespace_declaration name: (identifier) @namespace.identifier body: (declaration_list
        (class_declaration name: (identifier) @class.name body: (declaration_list
            ]] .. query .. [[
        ))
    ))

    ;; Matches file-scoped namespaces (qualified and unqualified respectively)
    (file_scoped_namespace_declaration name: (qualified_name) @namespace.identifier
        (class_declaration name: (identifier) @class.name body: (declaration_list
            ]] .. query .. [[
        ))
    )

    (file_scoped_namespace_declaration name: (identifier) @namespace.identifier
        (class_declaration name: (identifier) @class.name body: (declaration_list
            ]] .. query .. [[
        ))
    )
]]
end

function M.buildDetectionQuery()
    local query = ""
    for _, v in ipairs(M.testDetectionQueries) do
        query = query .. M.wrapInNamespace(v)
    end

    return query
end

return M
