%Developed by Group members:
%Christopher Cross...ID:1406887
%Dwayn Beckett...ID:1307617
%Micheal Asphall...ID1302550:
%Nicole Pinnock....ID:1205010
%University of Technology Jamaica
%Artificial Intelligence, CMP4011
%Semester 2, Year of project: 2017

:-dynamic (riskcountry/1).
%:-dynamic(patients/1).
:-dynamic(sumvalue/1).

%please read through all the comment for testing instruction. thank you
% very important notice these are symptoms that were used on the user
% interface in the same order.
%
%symptoms(coughing). symptoms(rash). symptoms(tbreathing).
% symptoms(vomitting). symptoms(diarrhea). symptoms(bodyache).
% symptoms(flu_feeling). symptoms(weight_lost). symptoms(sore_throat).
% symptoms(faint).


riskcountry(coastarica).
riskcountry(china).
riskcountry(japan).
riskcountry(mexico).
riskcountry(africa).
riskcountry(argentina).
riskcountry(ecuador).
riskcountry(usa).
riskcountry(sweden).
riskcountry(italy).
riskcountry(uk).

%symptoms(coughing).
%symptoms(rash).
%symptoms(tbreathing).
%symptoms(vomitting).
%symptoms(bodyache).
%%symtoms(diarrhea).
%symptoms(flu_feeling).
%symptoms(weight_lost).
%symptoms(sore_throat).
%symptoms(faint).


patients(john,male,22).

check_list(Name,Gender,Age,Patientresult):-
         (
            (Patientresult==h1n1)->
                 asserta(patients(Name,Gender,Age)),
                 findall(X,patients(X,G,A),L),length(L,N),
                  write(G),write(A),
    new(D,dialog('Statistics')),

    new(L1,label(text,"Total persons infected")),
     new(L2,label(text,N)),
       send(D,append,L1),
       send(D,append,L2),
    %Epidemic
     ((N>5)-> new(Le,label(text,"There is an Epidemic out break")),
       send(D,append,Le);

      (N<5)-> new(Le,label(text,"Not major out break")),
       send(D,append,Le)
     ),

          new(BUTTONclose, button('Close',message(D,destroy))),
           send(D,append,BUTTONclose),
       send(D,open);
     new(D,dialog('Statistics')),

    new(L1,label(text,"Total persons infected")),
     new(L2,label(text,N)),
       send(D,append,L1),
       send(D,append,L2),

    %Epidemic
      ((N>5)-> new(Le,label(text,"There is an Epidemic out break")),
       send(D,append,Le);

      (N<5)-> new(Le,label(text,"Not major out break")),
       send(D,append,Le)
     ),
          new(BUTTONclose, button('Close',message(D,destroy))),
           send(D,append,BUTTONclose),
       send(D,open)

          )
         .

treatmentTime(id(300),short).
treatmentTime(id(301),long).
treatmentTime(id(302),safe).


resolve(id(300),fluids).
resolve(id(300),acetaminophen).
resolve(id(300),'cough medicines').
resolve(id(300),rest).
resolve(id(301),'antiviral treatment').
resolve(id(301),'admittind at hospital').
resolve(id(302),"YOU SEEM TO BE OK PLEASE KEEP SAFE!!!").


hypothesis(1,flu).
hypothesis(2,h1n1).
hypothesis(4,"YOU SEEM TO BE OK PLEASE KEEP SAFE!!!").
hypothesis(female,"Possibilites you could be pregnant").
hypothesis(3,'common cold').

flu(Sum,Result,Resolve,Patientresult):-write(Patientresult),write(Length),Sum>0,Result>0,treatmentFor(300,Length,Resolve).

pregnancy(Sum,Gender,Resolve,Patientresult):- write(Length),Gender=='female',(Sum<60, Sum > 15 -> Sum is Sum),hypothesis(Gender,Patientresult),treatmentFor(300,Length,Resolve).

treatmentFor(Id,Length,Resolve):-treatmentTime(id(Id),Length),resolve(id(Id),Resolve).

h1n1(Sum,Result,Rcountry,Resolve,Patientresult):-write(Length),write(Patientresult),Sum>=70,riskcountry(Rcountry),Result>39->treatmentFor(301,Length,Resolve).

% safelevel(Sum,Result,Rcountry,Resolve,Patientresult):-Sum<50,riskcountry(Rcountry),Result>39->treatmentFor(302,Length,Resolve),writ%e(Patientresult,Length).
%
%

test(Sum,Result,Gender,Rcountry,Resolve,Patientresult):-
pregnancy(Sum,Gender,Resolve,Patientresult),hypothesis(Gender,Patientresult);
h1n1(Sum,Result,Rcountry,Resolve,Patientresult),hypothesis(2,Patientresult);
flu(Sum,Result,Resolve,Patientresult),hypothesis(1,Patientresult).
%safelevel(Sum,Result,Resolve,Patientresult),hypothesis(4,Patientresult)


%file function
writeTO(File,Text):-
 open(File, append,Stream),nl,
 write(Stream, Text),nl,
 close(Stream).

  readTo(File):-
  open(File,read,Stream),
  get_char(Stream,Char1),
  process_stream(Char1,Stream),
  close(Stream).

  process_stream(end_of_file, _):-!.
  process_stream(Char,Stream):-
  write(Char),
  get_char(Stream,Char2),
  process_stream(Char2, Stream).





:-new(D,dialog('Registeration')),

    %This ia a drop down menu with information on this project please explore menu
  send(D, append,new(Menu,menu_bar)),
   send(Menu,append,new(Con,popup(click_this_Menu_here))),
    send_list(Con,append,[menu_item(about,message(@prolog,popup_menu)),
        menu_item(author,message(@display, inform,'Group:\nChristopher Cross...ID:1406887\nDwayn Beckett...ID:130617\n Micheal Asphall...ID:1302550\nNicole Pinnock....ID:1205010')),
        menu_item(close,and(message(D,destroy),message(D,free)))
                       ]),
        new(L1,label),
        send(D,append,L1),

        new(WC,label(text,"WELCOME TO THE EXPERT SYSTEM")),
        send(D,append,WC),

      new(Tname,text_item('Enter your full name')),
      new(Age,text_item('whats is your age?')),
       new(L,label),
        send(D,append,L),

        new(Gender,menu("Select your gender")),
        send_list(Gender,append,[male,female]),
        send(D,append,Gender),

         new(BTNm,button('Submit',(message(@prolog,sick_filter,Gender?selection,Age?selection,Tname?selection,L)))),
         new(BUTTONclose, button('Close',message(D,destroy))),

           send(D,append,Tname),
           send(D,append,Age),
           send(D,append,BTNm),
           send(D,append,BUTTONclose),

           new(LB,label),
           send(D,append,LB),

           new(Foot,label(text,"Developed by Utech Students. click menu on top of the page for information")),
           send(D,append,Foot),

            new(D5,label(text,"Copyright(C) University Of Technology Jamaica All Right Reserved")),
            send(D,append,D5),

       send(D,open).


% this block of code if to check for age and gender for group to review
%  and then dispose if not needed.
sick_filter(Gender,Age,Name,L):-send(L,selection,Age),
    check_if_ill(Gender,Age,Name).
   % (atom_number(Age,Result),Result>17)->
     % (check_if_ill_adult(Gender,Age,Name));
   % (atom_number(Age,Result),Result<18)->
    %  (check_if_ill_child);
   % (atom_number(Age,Result),Result<55)->
    %   (check_if_ill_senior).


% this is the main diagnostic function that process information on
% patient. This uses radio, textfield and button to input and recieve
% data. Data is then pass to other function for processing facts and
% rules on informaton enterd.
% when testing the system do not use any uppercase letters.
% if temperature is above 39 and below 30 the system will bring up a
% menu for high or low temperature. also when testing if tempertaure in
% between 30 and 39 it will not genrate temperature dialog box base on
% testing the system.
check_if_ill(Gender,Age,Name):- new(Dd,dialog('Expert System diagnose')),

    %radio button for selection symptoms
     new(Lbl,label(text,'All possible Symptoms for H1N1 Virus')),
      send(Dd,append,Lbl),
     new(Lbl2,label(text,'Please select "y" or "n" to state any symptoms that you have here:')),
      send(Dd,append,Lbl2),
     new(L1,menu("Have you been Coughing?")),
      send_list(L1,append,[yes,no]),
     new(L2,menu("Do you have any Rash?")),
      send_list(L2,append,[yes,no]),
     new(L3,menu("Do you have Trouble Breathing?")),
      send_list(L3,append,[yes,no]),
     new(L4,menu("Have you been vomitting?")),
      send_list(L4,append,[yes,no]),
     new(L5,menu("Do your Body ache?")),
      send_list(L5,append,[yes,no]),
     new(L6,menu("Have you had any Diarrhea?")),
      send_list(L6,append,[yes,no]),
     new(L7,menu("Do you have Flu Like Feeling?")),
      send_list(L7,append,[yes,no]),
     new(L8,menu("Have you Loss Weight?")),
      send_list(L8,append,[yes,no]),
     new(L9,menu("Any Sore Throat?")),
      send_list(L9,append,[yes,no]),
     new(L10,menu("Have you Fainted lately?")),
       send_list(L10,append,[yes,no]),
     new(Txt_temp,text_item('Please State your temperature:')),

      (new(Lbl5, label)),
        send(Dd,append,Lbl5),

            (new(Lblresult, label)),
            (new(Lblsty1, label(text,"============Displayed Results============"))),
            (new(Lblsty2, label(text,"========================================"))),

   send(Dd,append,L1),
     send(Dd,append,L2),
      send(Dd,append,L3),
       send(Dd,append,L4),
        send(Dd,append,L5),
         send(Dd,append,L6),
          send(Dd,append,L7),
           send(Dd,append,L8),
            send(Dd,append,L9),
             send(Dd,append,L10),
              send(Dd,append,Txt_temp),


           (new(Lbl7, label)),
           send(Dd,append,Lbl7),

     new(Lbl3,label(text,'Additional information needed along with the symptoms for the country you visited recently ')),
       send(Dd,append,Lbl3),

     new(Txt_country,text_item('State the country you recently visited:')),

     new(Lblcountry1,label(text,"Africa, Argentina, Australia,Ecuador,USA,Italy, Sweden ")),
     new(Lblcountry2,label(text,"CostaRics, Mexico, China, Japan, Thailand, germany, UK ")),


     new(BTN,button('Submit',(message(@prolog,result_if_ill,
        L1?selection, L2?selection, L3?selection, L4?selection,
         L5?selection, L6?selection, L7?selection, L8?selection,
         L9?selection, L10?selection,
        Txt_temp?selection,Txt_country?selection,Gender,Age,Name,Lblresult)))),

      new(BUTTONclose, button('Close',message(Dd,destroy))),

         send(Dd,append,Lblcountry1),
          send(Dd,append,Lblcountry2),

         send(Dd,append,Txt_country),
         send(Dd,append,BTN),
         send(Dd,append,BUTTONclose),
         send(Dd,append,Lblsty1),
         send(Dd,append,Lblresult),
         send(Dd,append,Lblsty2),

    send(Dd,open).


 result_if_ill(Coughing,Rash,Tbreathing,Vomitting,Bodyache,
               Diarrhea,Flu_feeling,Weight_lost,Sore_throat,Faint,
               Temp,Rcountry,Gender,Age,Name,Lbl):-

                % value from radio buttons on the user interface. these results have a value assigned for the symptoms
              ((Coughing==yes)-> A is 1;(Coughing==no)-> A is 0),
              ((Rash==yes)-> B is 2;(Rash==no)-> B is 0),
              ((Tbreathing==yes)-> C is 3;(Tbreathing==no)-> C is 0),
              ((Vomitting==yes)-> D is 4;(Vomitting==no)-> D is 0),
              ((Bodyache==yes)-> E is 5;(Bodyache==no)-> E is 0),
              ((Diarrhea==yes)-> F is 6;(Diarrhea==no)-> F is 0),
              ((Flu_feeling==yes)-> G is 7;(Flu_feeling==no)-> G is 0),
              ((Weight_lost==yes)-> H is 8;(Weight_lost==no)-> H is 0),
              ((Sore_throat==yes)-> I is 9;(Sore_throat==no)-> I is 0),
              ((Faint==yes)-> J is 10; (Faint==no)-> J is 0),

              %this statement calculates the result in percentage for the probability of H1N1
              Sum is ((A+B+C+D+E+F+G+H+I+J)/55)*100,

          %determines if a person temperature is too high or low which also suggest solution for temperature
   (
        atom_number(Temp,Result),
        test(Sum,Result,Gender,Rcountry,Resolve,Patientresult),
            % please try concatenate variable X with string

           send(Lbl,selection,Patientresult),
           helptips(Resolve,Gender,Age,Name,Sum,Rcountry),
            Presult=Patientresult,                                                                                 check_list(Name,Gender,Age,Presult),
           writeTO('Patient.txt',(Name,Age,Gender,Rcountry,Patientresult))

                                                                                                        ).

%Gui for the dialog box with help tips on temperature control
helptips(Resolve,Gender,Age,Name,Sum,Rcountry):-


     treatmentFor(Id,Length,Resolve),
    new(D,dialog("Help tips")),

     new(Lgender,label(text,(Gender))),
            new(ID,label(text,(Id))),
             new(Lage,label(text,(Age))),
             new(Lname,label(text,(Name))),
             new(Ltext,label(text,("Your your probability of H1N1 is: "))),
             new(Lstat,label(text,(Sum))),
             send(D,append,ID),
     send_list(D,append,[Lgender,Lage,Lname]),
              send(D,append,Ltext),
              send(D,append,Lstat),

    new(Country,label(text,"It is observed that you last visited")),
    new(L1,label(text,Rcountry)),
      send(D,append,Country),
      send(D,append,L1),

   %long term treatment
   new(L2a,label(text,"It is best base on your condition that a long term treatment is require")),
   new(Info1,label(text,"This is what is advice of you to do")),
   new(L3,label(text,"Aquire antiviral treatment")),
   new(L4,label(text,"Advance to a hospital immediately")),
   new(L7,label(text,"Please use mosquito repelant as possible")),
   new(L8,label(text,"Please eat lots of fruits and take vitamins")),


  %short term treatment
   new(L2b,label(text,"It is best base on your condition that a short term treatment is require")),
   new(L5,label(text,"Please cover mouth or noise when sneeze or cough")),
   new(L6,label(text,"Please wash hands propely")),

    %case for treament
    (     ( Length==long)->
              send(D,append,L2a),
              send(D,append,Info1),
              send(D,append,L3),
              send(D,append,L4),
              send(D,append,L7),
              send(D,append,L8)
    ;
         ( Length==short)->
             send(D,append,L2b),
             send(D,append,Info1),
             send(D,append,L5),
             send(D,append,L6),
             send(D,append,L7),
             send(D,append,L8)
    ) ,

    new(BUTTONclose, button('Close',message(D,destroy))),
    send(D,append,BUTTONclose),

         send(D,open).


%popup menu Gui for project information
   popup_menu:- new(D,dialog("About")),
new(Lpop,label(text,"About our Expert system")),

    new(L1,label(text,"Utech group project")),
     new(L2,label(text,"")),
      new(L3,label(text,"")),
       new(L4,label(text,"")),
        new(L5,label(text,"")),
         new(L6,label(text,"")),
send(D,append,Lpop),

   send(D,append,L1),
     send(D,append,L2),
      send(D,append,L3),
       send(D,append,L4),
        send(D,append,L5),
         send(D,append,L6),

    new(BUTTONclose, button('Close',message(D,destroy))),
    send(D,append,BUTTONclose),
    send(D,open).
