#define BOOST_TEST_MODULE UninitializedTest
#include <boost/test/unit_test.hpp>
#include "Uninitialized.h"
BOOST_AUTO_TEST_CASE(TestTest)
{ 
    BOOST_TEST_MESSAGE(hello());
}
