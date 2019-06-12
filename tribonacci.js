/**
 * Builds a sequence by summing up the previous three numbers to build the next.
 * The function takes two arguments: signature and length of sequence.
 * Signature is a list that describes the first elements of our sequence
 * Eg.: signature = [1,1,1]; l = 8;
 * Result: [1, 1 ,1, 3, 5, 9, 17, 31]
 */
function tribonacci(signature, length) {
  if (length === 0 || signature === []) {
    return [];
  }

  if (length > signature.length) {
    length -= signature.length;
  }

  return helper([...signature], [...signature], length);
}

function helper(signature, currentList, length) {
  if (length === 0) {
    return currentList;
  }
  const nextValue = signature.reduce((acc, cur) => acc + cur, 0);
  currentList.push(nextValue);
  if (signature.length === 3) {
    signature.shift();
  }
  signature.push(nextValue);

  return helper(signature, currentList, length - 1);
}

module.exports = tribonacci;
