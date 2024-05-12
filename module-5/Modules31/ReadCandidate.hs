module Modules31.ReadCandidate where

import Modules31.Candidate

readId :: IO Int
readId = getLine >>= (pure . read)

readGrade :: IO Grade
readGrade = getLine >>= (pure . read)

readDegree :: IO Degree
readDegree = getLine >>= (pure . read)

readCandidate :: IO Candidate
readCandidate = do
  print "Enter id"
  candidateId <- readId
  print "Enter code review grade"
  codeReview <- readGrade
  print "Enter compliance with corporate culture grade"
  cultureFir <- readGrade
  print "Enter education"
  education <- readDegree
  pure $
    Candidate
      candidateId
      codeReview
      cultureFir
      education