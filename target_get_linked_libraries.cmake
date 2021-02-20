function(list_add_if_not_present list elem)
    list(FIND "${list}" "${elem}" exists)
    if(exists EQUAL -1)
        list(APPEND "${list}" "${elem}")
        set("${list}" "${${list}}" PARENT_SCOPE)
     endif()
endfunction()

macro(_target_get_linked_libraries_in _target _outlist)
    list_add_if_not_present("${_outlist}" "${_target}")

    # get libraries
    get_target_property(target_type "${_target}" TYPE)
    if (${target_type} STREQUAL "INTERFACE_LIBRARY")
        get_target_property(libs "${_target}" INTERFACE_LINK_LIBRARIES)
    else()
        get_target_property(libs "${_target}" LINK_LIBRARIES)
    endif()

    foreach(lib IN LISTS libs)
        if(NOT TARGET "${lib}")
            continue()
        endif()
        
        list(FIND "${_outlist}" "${lib}" exists)
        if(NOT exists EQUAL -1)
            continue()
        endif()
        
        _target_get_linked_libraries_in("${lib}" "${_outlist}")
        
    endforeach()
endmacro()

function(target_get_linked_libraries _target _outlist)
    set(${_outlist} "${_target}")
    _target_get_linked_libraries_in(${_target} ${_outlist})
    set(${_outlist} ${${_outlist}} PARENT_SCOPE) 
endfunction()