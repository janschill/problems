/**
 * Write a function that returns the last element of a list
 */
function last(list) {
  const listLength = list.length;
  if (listLength > 0) {
    return list[listLength-1];
  }
  return null
}
