using System;


namespace IdentityManagement.Entities.Psychiatry
{
    public class MMA
    {
        public int MMAID { get; set; }
        public DateTime MMADATE { get; set; }
        public string CDCR { get; set; }
        public string DOB { get; set; }
        public string PAROLEOFFICE { get; set; }
        public string PAROLEENAME { get; set; }
        public string PSYCHIATRIST { get; set; }
        public string DIAGNOSIS { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string MEDICATIONSIDEEFFECTS { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string CHIEFCOMPLAINT { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string CURRENTMEDICATIONS { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string DISCONTINUEDMEDICATIONS { get; set; }
        //StringLength(2000), Column(TypeName = "nvarchar")]
        public string MEDICATIONCHANGES { get; set; }
        //[StringLength(5), Column(TypeName = "nvarchar")]
        public string PREVPSYCHIATRICADMISSIONS { get; set; }
        //[StringLength(5), Column(TypeName = "nvarchar")]
        public string PREVSUICIDEATTEMPTS { get; set; }
        //[StringLength(5), Column(TypeName = "nvarchar")]
        public string OUTPATIENTPSYCHIATRICCAREYEARS { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string PREVIOUSDIAGNOSIS { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string PREVIOUSPSYCHIATRICMEDICATIONS { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string PREVDRUGDEPENDENCE { get; set; }
        //StringLength(2000), Column(TypeName = "nvarchar")]
        public string CURRENTDRUGDEPENDENCE { get; set; }
        public DateTime? DATEOFLASTDRUGUSE { get; set; }
        //[StringLength(5), Column(TypeName = "nvarchar")]
        public string YEARSOFDRUGUSE { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string MEDICATIONALLERGIES { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string HOSPITALIZATIONS { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string SURGERIES { get; set; }
        public bool HISTORYHEADTRAUMAYES { get; set; }
        public bool HISTORYHEADTRAUMADENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HISTORYHEADTRAUMANOTE { get; set; }
        public bool HISTORYSTROKEYES { get; set; }
        public bool HISTORYSTROKEDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HISTORYSTROKENOTE { get; set; }
        public bool HISTORYLOSSCONSCIOUSNESSYES { get; set; }
        public bool HISTORYLOSSCONSCIOUSNESSDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HISTORYLOSSCONSCIOUSNESSNOTE { get; set; }
        public bool SPINALCORDINJURIESYES { get; set; }
        public bool SPINALCORDINJURIESDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string SPINALCORDINJURIESNOTE { get; set; }
        public bool SKELETALFRACTURESBRAKESYES { get; set; }
        public bool SKELETALFRACTURESBRAKESDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string SKELETALFRACTURESBRAKESNOTE { get; set; }
        public bool MVAYES { get; set; }
        public bool MVADENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string MVANOTE { get; set; }
        public bool GUNSHOTWOUNDSYES { get; set; }
        public bool GUNSHOTWOUNDSDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string GUNSHOTWOUNDSNOTE { get; set; }
        public bool HISTORYOFSEIZURESYES { get; set; }
        public bool HISTORYOFSEIZURESDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HISTORYOFSEIZURESNOTE { get; set; }
        public bool HISTORYMIGRAINEHAYES { get; set; }
        public bool HISTORYMIGRAINEHADENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HISTORYMIGRAINEHANOTE { get; set; }
        public bool HEARTDISEASEYES { get; set; }
        public bool HEARTDISEASEDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HEARTDISEASENOTE { get; set; }
        public bool ASTHMAYES { get; set; }
        public bool ASTHMADENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string ASTHMANOTE { get; set; }
        public bool COPDYES { get; set; }
        public bool COPDDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string COPDNOTE { get; set; }
        public bool DIABETESYES { get; set; }
        public bool DIABETESDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string DIABETESNOTE { get; set; }
        public bool HYPERLIPIDEMIAYES { get; set; }
        public bool HYPERLIPIDEMIADENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HYPERLIPIDEMIANOTE { get; set; }
        public bool HYPERTENSIONYES { get; set; }
        public bool HYPERTENSIONDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HYPERTENSIONNOTE { get; set; }
        public bool HEPATITISYES { get; set; }
        public bool HEPATITISDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HEPATITISNOTE { get; set; }
        public bool VDHIVYES { get; set; }
        public bool VDHIVDENIED { get; set; }
        //StringLength(100), Column(TypeName = "nvarchar")]
        public string VDHIVNOTE { get; set; }
        public bool ANEMIAYES { get; set; }
        public bool ANEMIADENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string ANEMIANOTE { get; set; }
        public bool THYROIDABNORMALITIESYES { get; set; }
        public bool THYROIDABNORMALITIESDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string THYROIDABNORMALITIESNOTE { get; set; }
        public bool GLAUCOMAYES { get; set; }
        public bool GLAUCOMADENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string GLAUCOMANOTE { get; set; }
        public bool ABNORMALLABRESULTSYES { get; set; }
        public bool ABNORMALLABRESULTSDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string ABNORMALLABRESULTSNOTE { get; set; }
        public bool ABNORMALEKGYES { get; set; }
        public bool ABNORMALEKGDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string ABNORMALEKGNOTE { get; set; }
        public bool CURRENTPREGNANCYDENIED { get; set; }
        public bool CURRENTPREGNANCYYES { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string CURRENTPREGNANCYNOTE { get; set; }
        public bool HISTORYPRIAPISMYES { get; set; }
        public bool HISTORYPRIAPISMDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HISTORYPRIAPISMNOTE { get; set; }
        public bool OTHERCHRONICMEDICALILLNESSYES { get; set; }
        public bool OTHERCHRONICMEDICALILLNESSDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string OTHERCHRONICMEDICALILLNESSNOTE { get; set; }
        public int NUMBERPREGNANCIES { get; set; }
        public int NUMBERDELIVERIES { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string CURRENTHOUSING { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string SUPPORTIVERELATIONSHIPS { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string CURRENTEMPLOYMENT { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string LASTEMPLOYED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HIGHESTGRADECOMPLETED { get; set; }
        public bool IDENTIFIEDLEARNINGDISABILITY { get; set; }
        public bool INTELLECTUALIMPAIRMENTDENIED { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string INTELLECTUALIMPAIRMENT { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string IDENTIFIEDLEARNINGDISABILITYNOTE { get; set; }
        public bool SEXPREFERENCEMALE { get; set; }
        public bool SEXPREFERENCEFEMALE { get; set; }
        public string WEIGHT { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string HISOTRYINCARCERATION { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string SEXPREFERENCENOTE { get; set; }
        public bool APPEARANCEDISHEVELED { get; set; }
        public bool APPEARANCEGROOMED { get; set; }
        public bool APPEARANCENOURISHED { get; set; }
        public bool APPEARANCEOBESE { get; set; }
        public bool ABNORMALINVOLUNTARYMOVEMENTABSENT { get; set; }
        public bool ABNORMALINVOLUNTARYMOVEMENTPRESENT { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string DISTRACTIBILITY { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string IMPULSIVITY { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string CONCENTRATION { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string MEMORYREGISTRATION { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string ANXIETYLEVEL { get; set; }
        public bool CHILDHOODMEMORIESPRESENT { get; set; }
        public bool CHILDHOODMEMORIESABSENT { get; set; }
        public bool ADULTMEMORIESPREVTRAUMATICEVENTABSENT { get; set; }
        public bool ADULTMEMORIESPREVTRAUMATICEVENTPRESENT { get; set; }
        public bool RPTINTENSEPSYREACTTRAUMEMOPRESENT { get; set; }
        public bool RPTINTENSEPSYREACTTRAUMEMOABSENT { get; set; }
        public bool RPTAVOIDSTIMULIABSENT { get; set; }
        public bool RPTAVOIDSTIMULIPRESENT { get; set; }
        public bool RPTFLASHBACKSTRAUMATICMEMPRESENT { get; set; }
        public bool RPTFLASHBACKSTRAUMATICMEMABSENT { get; set; }
        public bool RPTRECURRDISTRESSNMTRAUPRESENT { get; set; }
        public bool RPTRECURRDISTRESSNMTRAUABSENT { get; set; }
        public bool OBSESSIONSCOMPULSIONSYES { get; set; }
        public bool OBSESSIONSCOMPULSIONSDENIED { get; set; }
        public bool ANHEDONIAPRESENT { get; set; }
        public bool ANHEDONIAABSENT { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string MOOD { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string EUPHORIA { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string DEMEANOR { get; set; }
        public bool SLEEPINSOMINA { get; set; }
        public bool SLEEPINTERRUPED { get; set; }
        public bool SLEEPNORMAL { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string PERIODSTIMETOOENERGIZEDTOSLEEP { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string APPETITE { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string ENERGYLEVEL { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string LIBIDO { get; set; }
        public bool IRRITABILITYPRESENT { get; set; }
        public bool IRRITABILITYABSENT { get; set; }
        public bool RANGEAFFECTFULL { get; set; }
        public bool RANGEAFFECTCONSTRICTED { get; set; }
        public bool RANGEAFFECTFLAT { get; set; }
        public bool APPROPRIATECONTENTSPEECHYES { get; set; }
        public bool APPROPRIATECONTENTSPEECHNO { get; set; }
        public bool MOODCONGRUENTYES { get; set; }
        public bool MOODCONGRUENTNO { get; set; }
        public bool HOMICIDALIDEATIONPLANUNTENTPRESENT { get; set; }
        public bool HOMICIDALIDEATIONPLANUNTENTABSENT { get; set; }
        public bool SUICIDALIDEATIONPRESENT { get; set; }
        public bool SUICIDALIDEATIONABSENT { get; set; }
        public bool SUICIDALPLANPRESENT { get; set; }
        public bool SUICIDALPLANABSENT { get; set; }
        public bool SUICIDALINTENTPRESENT { get; set; }
        public bool SUICIDALINTENTABSENT { get; set; }
        public bool ARTICULATIONNORMAL { get; set; }
        public bool ARTICULATIONABNORMAL { get; set; }
        public bool RATENORMAL { get; set; }
        public bool RATEPRESSURED { get; set; }
        public bool RHYTHMNORMAL { get; set; }
        public bool RHYTHMPRESSURED { get; set; }
        public bool VISUALHALLUCINATIONSPRESENT { get; set; }
        public bool VISUALHALLUCINATIONSABSENT { get; set; }
        public bool AUDITORYHALLUCINATIONSPRESENT { get; set; }
        public bool AUDITORYHALLUCINATIONSABSENT { get; set; }
        public bool APPEARSRESPONDINTERNALSTIMULUSYES { get; set; }
        public bool APPEARSRESPONDINTERNALSTIMULUSNO { get; set; }
        public bool THOUGHTPROCESSESLAGD { get; set; }
        public bool THOUGHTPROCESSESDISORGANIZED { get; set; }
        public bool THOUGHTPROCESSESCIRCUMSTANTIAL { get; set; }
        public bool THOUGHTPROCESSESTANGENTIAL { get; set; }
        public bool RACINGTHOUGHTSPRESENT { get; set; }
        public bool RACINGTHOUGHTSABSENT { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string DELUSIONS { get; set; }
        public bool GUARDEDSUSPICIOUSYES { get; set; }
        public bool GUARDEDSUSPICIOUSNO { get; set; }
        public bool HYPERVIGILANTYES { get; set; }
        public bool HYPERVIGILANTNO { get; set; }
        public bool PREOCCUPATIONSYES { get; set; }
        public bool PREOCCUPATIONSDENIED { get; set; }
        public bool INSIGHTGOOD { get; set; }
        public bool INSIGHTPOOR { get; set; }
        //[StringLength(2000), Column(TypeName = "nvarchar")]
        public string JUDGEMENT { get; set; }
        public bool APPEARSEXAGGERATEPSYSYMPTOMSNO { get; set; }
        public bool APPEARSEXAGGERATEPSYSYMPTOMSYES { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS1 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS2 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS3 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS4 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS5 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS6 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS7 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS8 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS9 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS10 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS11 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS12 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS13 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS14 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS15 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS16 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS17 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS18 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS19 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS20 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS21 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS22 { get; set; }
        public bool FUNCIMPAIRMENT1 { get; set; }
        public bool FUNCIMPAIRMENT2 { get; set; }
        public bool FUNCIMPAIRMENT3 { get; set; }
        public bool FUNCIMPAIRMENT4 { get; set; }
        public bool FUNCIMPAIRMENT5 { get; set; }
        public bool FUNCIMPAIRMENT6 { get; set; }
        public bool FUNCIMPAIRMENT7 { get; set; }
        public bool FUNCIMPAIRMENT8 { get; set; }
        public bool FUNCIMPAIRMENT9 { get; set; }
        public bool FUNCIMPAIRMENT10 { get; set; }
        public bool FUNCIMPAIRMENT11 { get; set; }
        public bool FUNCIMPAIRMENT12 { get; set; }
        public bool RECOMMENDATIONS1 { get; set; }
        public bool RECOMMENDATIONS2 { get; set; }
        public bool RECOMMENDATIONS3 { get; set; }
        public bool RECOMMENDATIONS4 { get; set; }
        public bool LABSREQUESTEDCBC { get; set; }
        public bool LABSREQUESTEDCHEM { get; set; }
        public bool LABSREQUESTEDA1C { get; set; }
        public bool LABSREQUESTEDSTUDY { get; set; }
        public bool DISCUSSEDPLAN { get; set; }
        public bool DISCUSSEDSIDE { get; set; }
        public bool DISCUSSEDFOLLOW { get; set; }
        public bool DISCUSSEDDIET { get; set; }
        public bool RTC1MONTH { get; set; }
        public bool RTC2MONTH { get; set; }
        public bool RTC3MONTH { get; set; }
        public bool RTCWEEKS { get; set; }
        public int RTCAMOUNTWEEKS { get; set; }
        public bool LABSREQUESTEDOTHER { get; set; }
        //[StringLength(100), Column(TypeName = "nvarchar")]
        public string LABSREQUESTEDOTHERNOTE { get; set; }
        public bool PSYCHOMOTORACTIVITYABNORMAL { get; set; }
        public bool PSYCHOMOTORACTIVITYWNL { get; set; }
        public bool ISLatestMMA { get; set; }
        public DateTime PrintDate { get; set; }
    }
    public class ASMT
    {
        public int AMSTID { get; set; }
        public DateTime MMADATE { get; set; }
        public string CDCR { get; set; }
        public string DOB { get; set; }
        public string PAROLEOFFICE { get; set; }
        public string PAROLEENAME { get; set; }
        public string PSYCHIATRIST { get; set; }
        public string DIAGNOSIS { get; set; }
        public string MEDICATIONSIDEEFFECTS { get; set; }
        public string CHIEFCOMPLAINT { get; set; }
        public string CURRENTMEDICATIONS { get; set; }
        public string DISCONTINUEDMEDICATIONS { get; set; }
        public string MEDICATIONCHANGES { get; set; }
        public string PREVPSYCHIATRICADMISSIONS { get; set; }
        public string PREVSUICIDEATTEMPTS { get; set; }
        public string OUTPATIENTPSYCHIATRICCAREYEARS { get; set; }
        public string PREVIOUSDIAGNOSIS { get; set; }
        public string PREVIOUSPSYCHIATRICMEDICATIONS { get; set; }
        public string PREVDRUGDEPENDENCE { get; set; }
        public string CURRENTDRUGDEPENDENCE { get; set; }
        public DateTime? DATEOFLASTDRUGUSE { get; set; }
        public string YEARSOFDRUGUSE { get; set; }
        public string MEDICATIONALLERGIES { get; set; }
        public string HOSPITALIZATIONS { get; set; }
        public string SURGERIES { get; set; }
        public bool HISTORYHEADTRAUMAYES { get; set; }
        public bool HISTORYHEADTRAUMADENIED { get; set; }
        public string HISTORYHEADTRAUMANOTE { get; set; }
        public bool HISTORYSTROKEYES { get; set; }
        public bool HISTORYSTROKEDENIED { get; set; }
        public string HISTORYSTROKENOTE { get; set; }
        public bool HISTORYLOSSCONSCIOUSNESSYES { get; set; }
        public bool HISTORYLOSSCONSCIOUSNESSDENIED { get; set; }
        public string HISTORYLOSSCONSCIOUSNESSNOTE { get; set; }
        public bool SPINALCORDINJURIESYES { get; set; }
        public bool SPINALCORDINJURIESDENIED { get; set; }
        public string SPINALCORDINJURIESNOTE { get; set; }
        public bool SKELETALFRACTURESBRAKESYES { get; set; }
        public bool SKELETALFRACTURESBRAKESDENIED { get; set; }
        public string SKELETALFRACTURESBRAKESNOTE { get; set; }
        public bool MVAYES { get; set; }
        public bool MVADENIED { get; set; }
        public string MVANOTE { get; set; }
        public bool GUNSHOTWOUNDSYES { get; set; }
        public bool GUNSHOTWOUNDSDENIED { get; set; }
        public string GUNSHOTWOUNDSNOTE { get; set; }
        public bool HISTORYOFSEIZURESYES { get; set; }
        public bool HISTORYOFSEIZURESDENIED { get; set; }
        public string HISTORYOFSEIZURESNOTE { get; set; }
        public bool HISTORYMIGRAINEHAYES { get; set; }
        public bool HISTORYMIGRAINEHADENIED { get; set; }
        public string HISTORYMIGRAINEHANOTE { get; set; }
        public bool HEARTDISEASEYES { get; set; }
        public bool HEARTDISEASEDENIED { get; set; }
        public string HEARTDISEASENOTE { get; set; }
        public bool ASTHMAYES { get; set; }
        public bool ASTHMADENIED { get; set; }
        public string ASTHMANOTE { get; set; }
        public bool COPDYES { get; set; }
        public bool COPDDENIED { get; set; }
        public string COPDNOTE { get; set; }
        public bool DIABETESYES { get; set; }
        public bool DIABETESDENIED { get; set; }
        public string DIABETESNOTE { get; set; }
        public bool HYPERLIPIDEMIAYES { get; set; }
        public bool HYPERLIPIDEMIADENIED { get; set; }
        public string HYPERLIPIDEMIANOTE { get; set; }
        public bool HYPERTENSIONYES { get; set; }
        public bool HYPERTENSIONDENIED { get; set; }
        public string HYPERTENSIONNOTE { get; set; }
        public bool HEPATITISYES { get; set; }
        public bool HEPATITISDENIED { get; set; }
        public string HEPATITISNOTE { get; set; }
        public bool VDHIVYES { get; set; }
        public bool VDHIVDENIED { get; set; }
        public string VDHIVNOTE { get; set; }
        public bool ANEMIAYES { get; set; }
        public bool ANEMIADENIED { get; set; }
        public string ANEMIANOTE { get; set; }
        public bool THYROIDABNORMALITIESYES { get; set; }
        public bool THYROIDABNORMALITIESDENIED { get; set; }
        public string THYROIDABNORMALITIESNOTE { get; set; }
        public bool GLAUCOMAYES { get; set; }
        public bool GLAUCOMADENIED { get; set; }
        public string GLAUCOMANOTE { get; set; }
        public bool ABNORMALLABRESULTSYES { get; set; }
        public bool ABNORMALLABRESULTSDENIED { get; set; }
        public string ABNORMALLABRESULTSNOTE { get; set; }
        public bool ABNORMALEKGYES { get; set; }
        public bool ABNORMALEKGDENIED { get; set; }
        public string ABNORMALEKGNOTE { get; set; }
        public bool CURRENTPREGNANCYDENIED { get; set; }
        public bool CURRENTPREGNANCYYES { get; set; }
        public string CURRENTPREGNANCYNOTE { get; set; }
        public bool HISTORYPRIAPISMYES { get; set; }
        public bool HISTORYPRIAPISMDENIED { get; set; }
        public string HISTORYPRIAPISMNOTE { get; set; }
        public bool OTHERCHRONICMEDICALILLNESSYES { get; set; }
        public bool OTHERCHRONICMEDICALILLNESSDENIED { get; set; }
        public string OTHERCHRONICMEDICALILLNESSNOTE { get; set; }
        public int NUMBERPREGNANCIES { get; set; }
        public int NUMBERDELIVERIES { get; set; }
        public string CURRENTHOUSING { get; set; }
        public string SUPPORTIVERELATIONSHIPS { get; set; }
        public string CURRENTEMPLOYMENT { get; set; }
        public string LASTEMPLOYED { get; set; }
        public string HIGHESTGRADECOMPLETED { get; set; }
        public bool IDENTIFIEDLEARNINGDISABILITY { get; set; }
        public bool INTELLECTUALIMPAIRMENTDENIED { get; set; }
        public string INTELLECTUALIMPAIRMENT { get; set; }
        public string IDENTIFIEDLEARNINGDISABILITYNOTE { get; set; }
        public bool SEXPREFERENCEMALE { get; set; }
        public bool SEXPREFERENCEFEMALE { get; set; }
        public string WEIGHT { get; set; }
        public string HISOTRYINCARCERATION { get; set; }
        public string SEXPREFERENCENOTE { get; set; }
        public bool APPEARANCEDISHEVELED { get; set; }
        public bool APPEARANCEGROOMED { get; set; }
        public bool APPEARANCENOURISHED { get; set; }
        public bool APPEARANCEOBESE { get; set; }
        public bool ABNORMALINVOLUNTARYMOVEMENTABSENT { get; set; }
        public bool ABNORMALINVOLUNTARYMOVEMENTPRESENT { get; set; }
        public string DISTRACTIBILITY { get; set; }
        public string IMPULSIVITY { get; set; }
        public string CONCENTRATION { get; set; }
        public string MEMORYREGISTRATION { get; set; }
        public string ANXIETYLEVEL { get; set; }
        public bool CHILDHOODMEMORIESPRESENT { get; set; }
        public bool CHILDHOODMEMORIESABSENT { get; set; }
        public bool ADULTMEMORIESPREVTRAUMATICEVENTABSENT { get; set; }
        public bool ADULTMEMORIESPREVTRAUMATICEVENTPRESENT { get; set; }
        public bool RPTINTENSEPSYREACTTRAUMEMOPRESENT { get; set; }
        public bool RPTINTENSEPSYREACTTRAUMEMOABSENT { get; set; }
        public bool RPTAVOIDSTIMULIABSENT { get; set; }
        public bool RPTAVOIDSTIMULIPRESENT { get; set; }
        public bool RPTFLASHBACKSTRAUMATICMEMPRESENT { get; set; }
        public bool RPTFLASHBACKSTRAUMATICMEMABSENT { get; set; }
        public bool RPTRECURRDISTRESSNMTRAUPRESENT { get; set; }
        public bool RPTRECURRDISTRESSNMTRAUABSENT { get; set; }
        public bool OBSESSIONSCOMPULSIONSYES { get; set; }
        public bool OBSESSIONSCOMPULSIONSDENIED { get; set; }
        public bool ANHEDONIAPRESENT { get; set; }
        public bool ANHEDONIAABSENT { get; set; }
        public string MOOD { get; set; }
        public string EUPHORIA { get; set; }
        public string DEMEANOR { get; set; }
        public bool SLEEPINSOMINA { get; set; }
        public bool SLEEPINTERRUPED { get; set; }
        public bool SLEEPNORMAL { get; set; }
        public string PERIODSTIMETOOENERGIZEDTOSLEEP { get; set; }
        public string APPETITE { get; set; }
        public string ENERGYLEVEL { get; set; }
        public string LIBIDO { get; set; }
        public bool IRRITABILITYPRESENT { get; set; }
        public bool IRRITABILITYABSENT { get; set; }
        public bool RANGEAFFECTFULL { get; set; }
        public bool RANGEAFFECTCONSTRICTED { get; set; }
        public bool RANGEAFFECTFLAT { get; set; }
        public bool APPROPRIATECONTENTSPEECHYES { get; set; }
        public bool APPROPRIATECONTENTSPEECHNO { get; set; }
        public bool MOODCONGRUENTYES { get; set; }
        public bool MOODCONGRUENTNO { get; set; }
        public bool HOMICIDALIDEATIONPLANUNTENTPRESENT { get; set; }
        public bool HOMICIDALIDEATIONPLANUNTENTABSENT { get; set; }
        public bool SUICIDALIDEATIONPRESENT { get; set; }
        public bool SUICIDALIDEATIONABSENT { get; set; }
        public bool SUICIDALPLANPRESENT { get; set; }
        public bool SUICIDALPLANABSENT { get; set; }
        public bool SUICIDALINTENTPRESENT { get; set; }
        public bool SUICIDALINTENTABSENT { get; set; }
        public bool ARTICULATIONNORMAL { get; set; }
        public bool ARTICULATIONABNORMAL { get; set; }
        public bool RATENORMAL { get; set; }
        public bool RATEPRESSURED { get; set; }
        public bool RHYTHMNORMAL { get; set; }
        public bool RHYTHMPRESSURED { get; set; }
        public bool VISUALHALLUCINATIONSPRESENT { get; set; }
        public bool VISUALHALLUCINATIONSABSENT { get; set; }
        public bool AUDITORYHALLUCINATIONSPRESENT { get; set; }
        public bool AUDITORYHALLUCINATIONSABSENT { get; set; }
        public bool APPEARSRESPONDINTERNALSTIMULUSYES { get; set; }
        public bool APPEARSRESPONDINTERNALSTIMULUSNO { get; set; }
        public bool THOUGHTPROCESSESLAGD { get; set; }
        public bool THOUGHTPROCESSESDISORGANIZED { get; set; }
        public bool THOUGHTPROCESSESCIRCUMSTANTIAL { get; set; }
        public bool THOUGHTPROCESSESTANGENTIAL { get; set; }
        public bool RACINGTHOUGHTSPRESENT { get; set; }
        public bool RACINGTHOUGHTSABSENT { get; set; }
        public string DELUSIONS { get; set; }
        public bool GUARDEDSUSPICIOUSYES { get; set; }
        public bool GUARDEDSUSPICIOUSNO { get; set; }
        public bool HYPERVIGILANTYES { get; set; }
        public bool HYPERVIGILANTNO { get; set; }
        public bool PREOCCUPATIONSYES { get; set; }
        public bool PREOCCUPATIONSDENIED { get; set; }
        public bool INSIGHTGOOD { get; set; }
        public bool INSIGHTPOOR { get; set; }
        public string JUDGEMENT { get; set; }
        public bool APPEARSEXAGGERATEPSYSYMPTOMSNO { get; set; }
        public bool APPEARSEXAGGERATEPSYSYMPTOMSYES { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS1 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS2 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS3 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS4 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS5 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS6 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS7 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS8 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS9 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS10 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS11 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS12 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS13 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS14 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS15 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS16 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS17 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS18 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS19 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS20 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS21 { get; set; }
        public bool MEDICATIONTARGETSYMPTOMS22 { get; set; }
        public bool FUNCIMPAIRMENT1 { get; set; }
        public bool FUNCIMPAIRMENT2 { get; set; }
        public bool FUNCIMPAIRMENT3 { get; set; }
        public bool FUNCIMPAIRMENT4 { get; set; }
        public bool FUNCIMPAIRMENT5 { get; set; }
        public bool FUNCIMPAIRMENT6 { get; set; }
        public bool FUNCIMPAIRMENT7 { get; set; }
        public bool FUNCIMPAIRMENT8 { get; set; }
        public bool FUNCIMPAIRMENT9 { get; set; }
        public bool FUNCIMPAIRMENT10 { get; set; }
        public bool FUNCIMPAIRMENT11 { get; set; }
        public bool FUNCIMPAIRMENT12 { get; set; }
        public bool RECOMMENDATIONS1 { get; set; }
        public bool RECOMMENDATIONS2 { get; set; }
        public bool RECOMMENDATIONS3 { get; set; }
        public bool RECOMMENDATIONS4 { get; set; }
        public bool LABSREQUESTEDCBC { get; set; }
        public bool LABSREQUESTEDCHEM { get; set; }
        public bool LABSREQUESTEDA1C { get; set; }
        public bool LABSREQUESTEDSTUDY { get; set; }
        public bool DISCUSSEDPLAN { get; set; }
        public bool DISCUSSEDSIDE { get; set; }
        public bool DISCUSSEDFOLLOW { get; set; }
        public bool DISCUSSEDDIET { get; set; }
        public bool RTC1MONTH { get; set; }
        public bool RTC2MONTH { get; set; }
        public bool RTC3MONTH { get; set; }
        public bool RTCWEEKS { get; set; }
        public int RTCAMOUNTWEEKS { get; set; }
        public bool LABSREQUESTEDOTHER { get; set; }
        public string LABSREQUESTEDOTHERNOTE { get; set; }
        public bool PSYCHOMOTORACTIVITYABNORMAL { get; set; }
        public bool PSYCHOMOTORACTIVITYWNL { get; set; }
        public DateTime PrintDate { get; set; }
    }
    public class MMADates
    {
        public int MMAID { get; set; }
        public string MMADate { get; set; }
    }

}
