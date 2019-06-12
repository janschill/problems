module Algebra.NeuralNetwork
(
  NeuralNetwork,
  predict,
  train
) where

import Algebra.Matrix

data NeuralNetwork a =
  NN {
    input_Nodes::Int,
    hidden_Nodes::Int,
    output_Nodes::Int,
    weights_ih::(Matrix a),
    weights_oh::(Matrix a),
    bias_h::(Matrix a),
    bias_o::(Matrix a)
  } deriving Show

iN  = 2
hN  = 2
oN  = 1
wIH = (M 2 2 [[-0.9913, 0.1234], [0.661, -0.012]])
wOH = (M 1 2 [[0.544, -0.41]])
bH  = (M 2 1 [[0.771], [-0.444]])
bO  = (M 1 1 [[0.842]])
inputArray = xorArr1I
targetArray = xorArr1O
nn1 = NN iN hN oN wIH wOH bH bO

xorArr1I = [0.0,0.0]
xorArr1O = [0.0]
xorArr2I = [0.0,1.0]
xorArr2O = [1.0]
xorArr3I = [1.0,0.0]
xorArr3O = [1.0]
xorArr4I = [1.0,1.0]
xorArr4O = [0.0]

sigmoidX::Floating a=>(a->a)
sigmoidX = \x -> 1 / (1 + exp (-x))

sigmoidY::Num a=>(a->a)
sigmoidY = \y -> y * (1 - y)

tanhX::Floating a=>(a->a)
tanhX = \x -> tanh x

tanhY::Num a=>(a->a)
tanhY = \y -> 1 - (y * y)

learningRate::Fractional a => a
learningRate = 0.1

predict :: Num a => NeuralNetwork a -> Matrix a -> Matrix a
predict nn matrix = matrix

train :: (Floating a, Fractional a, Num a) => NeuralNetwork a -> [a] -> [a] -> NeuralNetwork a
train (NN iN hN oN wIH wOH bH bO) inputArray targetArray =
  let
    -- generating hidden outputs
    inputs = fromArray inputArray
    hidden = addMap (multiplyMatrix wIH inputs) bH
    -- generatin output's outputs
    outputs = addMap (multiplyMatrix wOH hidden) bO

    addMap::(Floating a, Fractional a, Num a) => Matrix a -> Matrix a -> Matrix a
    addMap m1 m2 = mapMatrix (addMatrix m1 m2) sigmoidX

    -- array to matrix
    targets = fromArray targetArray
    -- calculate errors ERROR = TARGETS - OUTPUTS
    outputErrors = subtractMatrix targets outputs

    -- GRADIENT = OUTPUTS * (1 - OUTPUTS)
    gradients = multiplyByScalar (multiplyMatrix outputErrors (mapMatrix outputs sigmoidY)) learningRate

    -- calculate deltas
    hiddenT = transpose hidden
    weightHOdeltas = multiplyMatrix gradients hiddenT

    -- adjust weights
    wHO_ = addMatrix wOH weightHOdeltas
    bO_ = addMatrix bO gradients

    who_T = transpose wHO_
    hiddenErrors = multiplyMatrix who_T outputErrors

    hiddenGradient = multiplyByScalar (multiplyMatrix hiddenErrors (mapMatrix hidden sigmoidY)) learningRate

    inputsT = transpose inputs
    weightIHdeltas = multiplyMatrix hiddenGradient inputsT

    wIH_ = addMatrix wIH weightIHdeltas
    bH_ = addMatrix bH hiddenGradient

  in
    NN iN hN oN wIH_ wHO_ bH_ bO_


