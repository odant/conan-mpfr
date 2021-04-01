find_path(mpfr_INCLUDE_DIR
    NAMES mpfr.h
    PATHS ${CONAN_INCLUDE_DIRS_MPFR}
    NO_DEFAULT_PATH
)

find_library(mpfr_LIBRARY
    NAMES mpfr
    PATHS ${CONAN_LIB_DIRS_MPFR}
    NO_DEFAULT_PATH
)

if(mpfr_INCLUDE_DIR)

    file(STRINGS ${mpfr_INCLUDE_DIR}/mpfr.h DEFINE_mpfr_MAJOR REGEX "^#define MPFR_VERSION_MAJOR")
    string(REGEX REPLACE "^.*MPFR_VERSION_MAJOR +([0-9]+).*$" "\\1" mpfr_VERSION_MAJOR "${DEFINE_mpfr_MAJOR}")

    file(STRINGS ${mpfr_INCLUDE_DIR}/mpfr.h DEFINE_mpfr_MINOR REGEX "^#define MPFR_VERSION_MINOR")
    string(REGEX REPLACE "^.*MPFR_VERSION_MINOR +([0-9]+).*$" "\\1" mpfr_VERSION_MINOR "${DEFINE_mpfr_MINOR}")

    file(STRINGS ${mpfr_INCLUDE_DIR}/mpfr.h DEFINE_mpfr_PATCHLEVEL REGEX "^#define MPFR_VERSION_PATCHLEVEL")
    string(REGEX REPLACE "^.*MPFR_VERSION_PATCHLEVEL +([0-9]+).*$" "\\1" mpfr_VERSION_PATCHLEVEL "${DEFINE_mpfr_PATCHLEVEL}")

    set(mpfr_VERSION_STRING "${mpfr_VERSION_MAJOR}.${mpfr_VERSION_MINOR}.${mpfr_VERSION_PATCHLEVEL}")
    set(mpfr_VERSION ${mpfr_VERSION_STRING})
    set(mpfr_VERSION_COUNT 3)

endif()


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(mpfr
    REQUIRED_VARS mpfr_INCLUDE_DIR mpfr_LIBRARY
    VERSION_VAR mpfr_VERSION
)


if(mpfr_FOUND AND NOT TARGET mpfr::mpfr)
    add_library(mpfr::mpfr UNKNOWN IMPORTED)

    set_target_properties(mpfr::mpfr PROPERTIES
        IMPORTED_LOCATION "${mpfr_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${mpfr_INCLUDE_DIR}"
        INTERFACE_COMPILE_DEFINITIONS "${CONAN_COMPILE_DEFINITIONS_MPFR}"
        IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
    )

    mark_as_advanced(mpfr_INCLUDE_DIR mpfr_LIBRARY)

    set(mpfr_INCLUDE_DIRS ${mpfr_INCLUDE_DIR})
    set(mpfr_LIBRARIES ${mpfr_LIBRARY})
    set(mpfr_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_MPFR})

endif()

