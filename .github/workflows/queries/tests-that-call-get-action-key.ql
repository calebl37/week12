/**
 * @description Find functions directly called by tests
 * @kind problem
 * @id javascript/functions-directly-called-by-tests
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function is a test.
 */
predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

/**
* Holds if `caller` contains a call to `pressActionKey`
*/
predicate callsGetActionKey(Function caller) {
  exists(DataFlow::CallNode call |
    call.getEnclosingFunction() = caller and
    call.getCalleeName() = "pressActionKey"
  )
}

from Function test
where isTest(test) and
      callsGetActionKey(test)
select test, "calls getActionKey"
