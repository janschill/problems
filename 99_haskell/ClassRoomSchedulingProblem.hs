module ClassRoomSchedulingProblem where

data Event =
  Event {
    startTime::Time,
    endTime::Time,
    desc::String
  }

instance Eq Event where
  (==) (Event st1 et1 desc1) (Event st2 et2 desc2) = (st1 == st2) &&
                                                     (et1 == et2) &&
                                                     (desc1 == desc2)
  (/=) event1 event2 = not (event1 == event2)

instance Show Event where
  show (Event st et desc) = desc ++ ": " ++ (show st) ++ "-" ++ (show et)

data Time =
  Time {
    hour::Int,
    minute::Int
  }

t1 = Time  9 00
t2 = Time  9 30
t3 = Time 10 00
t4 = Time 10 30
t5 = Time 11 00
t6 = Time 11 30
t7 = Time 12 00

e1 = Event t1 t3 "ART"
e2 = Event t2 t4 "ENG"
e3 = Event t3 t5 "MATH"
e4 = Event t4 t6 "CS"
e5 = Event t5 t7 "MUSIC"

times  = [t1,t2,t3,t4,t5]
events = [e1,e2,e3,e4,e5]

instance Show Time where
  show (Time hours minutes) = (show hours) ++ ":" ++ (show minutes)

instance Eq Time where
  (==) (Time h1 m1) (Time h2 m2) = h1 == h2 && m1 == m2
  (/=) time1 time2 = not (time1 == time2)

instance Num Time where
  (+) (Time h1 m1) (Time h2 m2) | (h1+h2) >= 24 && (m1+m2) >= 60 = Time (h1 + h2 - 24 + 1) (m1 + m2 - 60)
                                | (h1+h2) >= 24 && (m1+m2) <  60 = Time (h1 + h2 - 24) (m1 + m2 - 60)
                                | (h1+h2) <  24 && (m1+m2) >= 60 = Time (h1 + h2 + 1) (m1 + m2 - 60)
                                | (h1+h2) <  24 && (m1+m2) <  60 = Time (h1 + h2) (m1 + m2)

instance Ord Time where
  (<)  (Time h1 m1) (Time h2 m2) | h1 < h2 = True
                                 | h1 == h2 && m1 < m2 = True
                                 | otherwise = False
  (<=) time1 time2 = time1 == time2 || time1 < time2
  (>)  time1 time2 = not (time1 == time2) && not (time1 < time2)
  (>=) time1 time2 = (time1 == time2) || not (time1 < time2)

  max time1 time2 | time1 < time2 = time2
                  | time1 > time2 = time1
                  | otherwise = time1

  min time1 time2 | time1 < time2 = time1
                  | time1 > time2 = time2
                  | otherwise = time1

findMinTime::[Time]->Time
findMinTime [] = Time 00 00
findMinTime times = foldr (min) (Time 23 59) times

findMaxTime::[Time]->Time
findMaxTime [] = Time 00 00
findMaxTime times = foldr (max) (Time 00 00) times

findEarliestEndingEvent::[Event]->Event
findEarliestEndingEvent [] = error "No events available"
findEarliestEndingEvent events = foldr (earlierEndingEvent) (Event (Time 23 59) (Time 23 59) "Upper bound") events

earlierEndingEvent::Event->Event->Event
earlierEndingEvent (Event st1 et1 s1) (Event st2 et2 s2) | et1 > et2 = Event st2 et2 s2
                                                         | et1 < et2 = Event st1 et1 s1
                                                         | otherwise = Event st1 et1 s1

findEarliestStartingEvent::[Event]->Event
findEarliestStartingEvent [] = error "No events available"
findEarliestStartingEvent events = foldr (earlierStartingEvent) (Event (Time 23 59) (Time 23 59) "Upper bound") events

earlierStartingEvent::Event->Event->Event
earlierStartingEvent (Event st1 et1 s1) (Event st2 et2 s2) | st1 > st2 = Event st2 et2 s2
                                                           | st1 < st2 = Event st1 et1 s1
                                                           | otherwise = Event st1 et1 s1

findLatestEndingEvent::[Event]->Event
findLatestEndingEvent [] = error "No events available"
findLatestEndingEvent events = foldr (laterEndingEvent) (Event (Time 00 00) (Time 00 00) "Lower bound") events

laterEndingEvent::Event->Event->Event
laterEndingEvent (Event st1 et1 s1) (Event st2 et2 s2) | et1 < et2 = Event st2 et2 s2
                                                       | et1 > et2 = Event st1 et1 s1
                                                       | otherwise = Event st1 et1 s1

findLatestStartingEvent::[Event]->Event
findLatestStartingEvent [] = error "No events available"
findLatestStartingEvent events = foldr (laterStartingEvent) (Event (Time 00 00) (Time 00 00) "Lower bound") events

laterStartingEvent::Event->Event->Event
laterStartingEvent (Event st1 et1 s1) (Event st2 et2 s2) | st1 < st2 = Event st2 et2 s2
                                                         | st1 > st2 = Event st1 et1 s1
                                                         | otherwise = Event st1 et1 s1

isStartingAfter::Event->Event->Bool
isStartingAfter (Event st1 et1 s1) (Event st2 et2 s2) | et1 <= st2 = True
                                                      | otherwise = False

schedule::[Event]->[Event]
schedule [] = []
schedule events = aux events []
  where
    aux::[Event]->[Event]->[Event]
    aux [] []   = []
    aux [] plan = plan
    aux [e] []  = [e]
    aux events plan =
      let
        earliestEvent = findEarliestEndingEvent events
      in
        aux (filter (isStartingAfter earliestEvent) events) (plan ++ [earliestEvent])