/**
 * @description Find functions that are longer than 10 lines
 * @kind problem
 * @id javascript/functions-longer-than-10-lines
 * @problem.severity recommendation
 */
import javascript



/**
* Holds if `caller` has more than 10 lines
*/
predicate overTenLines(Function caller) {
  caller.getNumLines() > 10
}

from Function caller
where overTenLines(caller)
select caller, "function with over 10 lines"
