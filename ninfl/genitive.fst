%
% FSTs for nominal genitive inflections
%

#include "../symbols.fst"

%%%%%%%%%%%% Noun Inflections %%%%%%%%%%%%%%

ALPHABET = [#Letters##POS##BM##TMP##Lsym#] <genitive> <infl_marker> <pl> <del>

#inflboundary# = #POS##BM##TMP##Lsym#

$genitive-special-cases$ = {ഞാൻ}:{എന്റെ<infl_marker>} | \
    {ഞാൻ}:{എന്നുടെ<infl_marker>} | \
    {നീ}:{നിന്റെ<infl_marker>} | \
    {നീ}:{നിന്നുടെ<infl_marker>} | \
    {താൻ}:{തന്റെ<infl_marker>} | \
    {താൻ}:{തന്നുടെ<infl_marker>} | \
    {നാം}:{നമ്മുടെ<infl_marker>} | \
    {നാം}:{നമ്മളുടെ<infl_marker>} | \
    {അവൻ}:{അവന്റെ<infl_marker>} |\
    {അവൻ}:{അവനുടെ<infl_marker>}

% Genitive inflection rules -ആനയുടെ, കടലിന്റെ, പേരിന്റെ, പൂച്ചയുടെ, മുറ്റത്തിന്റെ
% പൊതുവിൽ ചില്ലിൽ അവസാനിക്കുന്ന വാക്കുകൾക്ക് ഉടെ, ഇന്റെ എന്നീ രണ്ടും വിഭക്തികളും ചേരും. ഉദാഹരണം
% അവൻ = അവനുടെ, അവന്റെ, ആൾ = ആളുടെ, ആളിന്റെ,  വാൾ - വാളിന്റെ, വാളുടെ(?) ,
% കാൽ - കാലിന്റെ, കാലുടെ(?) , അവൾ = അവളുടെ, അവളിന്റെ(?)  അവർ - അവരുടെ, അവരിന്റെ(?)
% ഇതിൽ എല്ലാ രൂപങ്ങൾക്കും പ്രചാരമില്ല. അതുകൊണ്ട് ഏതെപ്പോൾ ചേർക്കണമെന്ന് കണ്ടുപിടിക്കേണ്ടിയിരിക്കുന്നു.

$genitive-exceptions-step1$ = $genitive-special-cases$ ^-> ( __ [#inflboundary#]+ <genitive> )
$remove-genitive-ninfl$ = {<genitive>}:{} ^-> (<infl_marker> [#inflboundary#]+ __ )
$genitive-exceptions$ = $genitive-exceptions-step1$ || $remove-genitive-ninfl$
$genitive$ = $genitive-exceptions$

$genitive-cons-vowels$ = {<genitive>}:{യുടെ} ^-> ([#Consonants##VowelSigns#] [#inflboundary#]+ __)
$genitive$ = $genitive$ || $genitive-cons-vowels$

$genitive-half-cons$ = {<genitive>}:{ഇന്റെ} ^-> ([#Virama#] [#inflboundary#]+ __)
$genitive$ = $genitive$ || $genitive-half-cons$

$genitive-anuswara-step1$ =  {<genitive>}:{<del>ത്തിന്റെ} ^-> ([#Anuswara#] [#inflboundary#]+ __)
$genitive-anuswara-step2$ = {[#Anuswara#]}:{} ^-> (__ [#inflboundary#]+ <del> )
$genitive-anuswara$ = $genitive-anuswara-step1$ || $genitive-anuswara-step2$
$genitive$ = $genitive$ || $genitive-anuswara$

% ന്റെ = ന്+ റെ ആക്കാൻ ഇവിടെ ഒരു മാർക്കർ ഇട്ടുവെച്ച് ചില്ലു നോർമലൈസ് ചെയ്യുമ്പോൾ ഉപയോഗിക്കുന്നു.
$chillu-n-forms$ = {<genitive>}:{<infl_marker>റെ} | {<genitive>}:{ഉടെ}
$chillu-forms$ = {<genitive>}:{ഇന്റെ} | {<genitive>}:{ഉടെ}
$genitive-chillu-n$ = $chillu-n-forms$  ^-> ([ൻ] [#inflboundary#]+ __)
$genitive-chillu-others$ = $chillu-forms$ ^-> ([ർൾൺൿൽ] [#inflboundary#<pl>]+ __)
$genitive$ = $genitive$ || $genitive-chillu-n$ || $genitive-chillu-others$

%$tests$ = മഴ<n><RB><genitive> | മുറ്റം<n><RB><genitive> |  കിളി<n><RB><genitive> | താൻ<n><RB><genitive> | പയർ<n><genitive>
%$tests$ || $genitive$ >> "genitive-test.a"

$genitive$
