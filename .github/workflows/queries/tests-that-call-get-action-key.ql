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
predicate callsGetActionKey(Function caller, Function callee) {
  exists(DataFlow::CallNode call |
    call.getEnclosingFunction() = caller and
    call.getACallee() = callee and
    callee.getName() = "pressActionKey"
  )
}

from Function test, Function callee
where isTest(test) and
      callsGetActionKey(test, callee)
select test, "calls getActionKey"
