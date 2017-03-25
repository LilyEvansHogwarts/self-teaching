data Context = Home | Mobile | Business deriving (Show,Eq)

type Phone = String

albulena = [(Home,"+355-652-55512")]

nils = [(Mobile,"+47-922-55-512"),(Business,"+47-922-12-121"),(Home,"+47-925-55-121"),(Business,"+47-922-25-551")]

twalumba = [(Business,"+260-02-55-5121")]

onePersonalPhone :: [(Context,Phone)] -> Maybe Phone
onePersonalPhone ps = 
   case lookup Home ps of
      Nothing -> lookup Mobile ps
      Just n -> Just n                  

allBusinessPhones ps = map snd numbers
   where numbers = case filter (contextIs Business) ps of
                      [] -> filter (contextIs Mobile) ps
                      ns -> ns

contextIs a (b,_) = a == b


