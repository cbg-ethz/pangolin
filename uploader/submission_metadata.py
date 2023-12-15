cantons = ["BL","ZH","SG","AI","ZG","GE","TG","OW","UR","GL","TI","SO","GR","FR","SZ","BS","JU","AG","AR","VS","NW","NE","VD","LU","BE","SH"]
mandatory_fields = ["species","strain_name","isolation_date","location_general","isolation_source_description","isolation_source_detailed","sequencing_purpose","sequencing_investigation_type","orig_fastq_name_forward","library_preparation_kit","sequencing_platform","assembly_method","reporting_lab_name","collecting_lab_name","reporting_authors"]
kit = {
  "v3": "SARS-CoV-2 ARTIC V3",
  "V3": "SARS-CoV-2 ARTIC V3",
  "v4": "SARS-CoV-2 ARTIC V4",
  "V4": "SARS-CoV-2 ARTIC V4",
  "v41": "SARS-CoV-2 ARTIC V4.1",
  "V41": "SARS-CoV-2 ARTIC V4.1",
  "v4.1": "SARS-CoV-2 ARTIC V4.1",
  "V4.1": "SARS-CoV-2 ARTIC V4.1",
  "v532": "SARS-CoV-2 ARTIC V5.3.2",
  "V532": "SARS-CoV-2 ARTIC V5.3.2",
  "v5.3.2": "SARS-CoV-2 ARTIC V5.3.2",
  "V5.3.2": "SARS-CoV-2 ARTIC V5.3.2",
}  
collecting_lab = {
  "1": "eawag",
  "2": "eawag",
  "3": "eawag",
  "4": "eawag",
  "5": "eawag",
  "6": "eawag",
  "7": "eawag",
  "8": "eawag",
  "9": "eawag",
  "10": "eawag",
  "12": "eawag",
  "11.1": "eawag",
  "11.2": "eawag",
  "13": "eawag",
  "14": "eawag",
  "15": "eawag",
  "16": "eawag",
  "17": "eawag",
  "18": "eawag",
  "19": "eawag",
  "20": "eawag",
  "21": "eawag",
  "22": "eawag",
  "23": "eawag",
  #"24": "eawag",
  "25": "eawag",
  "26": "eawag",
  "32":"eawag",
  "33":"eawag",
  "34":"eawag",
  "35":"eawag",
  "36":"eawag",
  "37":"eawag",
  "99": "eawag",
  "ba": "basel",
  "klzhcov": "kzurich",
  "klzhCov_Promega": "kzurich",
  "558600": "microsynth",
  "624801": "microsynth",
  "680000": "microsynth",
}
population = {
  "1": "27000",
  "2": "30000",
  "3": "12000",
  "4": "15000",
  "5": "124000",
  "6": "25000",
  "7": "54000",
  "8": "14000",
  "9": "51000",
  "10": "471000",
  "12": "248000",
  "11.1": "43000",
  "11.2": "43000",
  "13": "55000",
  "14": "225000",
  "15": "274000",
  "16": "454000",
  "17": "55000",
  "18": "",
  "19": "64000",
  "20": "",
  "21": "",
  "22": "45000",
  "23": "",
  #"24": "",
  "25": "62000",
  "26": "",
  "32":"225000",
  "33":"",
  "34":"646000",
  "35":"254000",
  "36":"32000",
  "37":"33000",
  "ba": "273075",
  "klzhcov": "473361",
  "klzhCov_Promega": "473361",
  "558600": "247824",
  "624801": "32480",
  "680000": "16320",
}
size = {
  "1": "54.00219643288182",
  "2": "",
  "3": "",
  "4": "57.96259543880482",
  "5": "198.70257279974336",
  "6": "118.04924802536674",
  "7": "",
  "8": "391.2999739700438",
  "9": "384.43053891241505",
  "10": "102.34846398120602",
  "12": "88.90982585503468",
  "11.1": "28.89310807274574",
  "11.2": "28.89310807274574",
  "13": "96.68757118163049",
  "14": "105.11106081093753",
  "15": "65.10327564165928",
  "16": "126.19405027126015",
  "17": "211.00560768931132",
  "18": "176.55426928711",
  "19": "104.18141542388327",
  "20": "",
  "21": "39.77221171816035",
  "22": "13.240694396501643",
  "23": "97.20041181629541",
  #"24": "",
  "25": "449.0738556277142",
  "26": "",
  "32":"164.77508882825475",
  "33":"144.5003117634239",
  "34":"50.868649327111015",
  "35":"238.28580403442436",
  "36":"112.93752962464872",
  "37":"87.95865237426803",
  "99": "",
  "ba": "",
  "klzhcov": "",
  "klzhCov_Promega": "",
  "558600": "",
  "624801": "",
  "680000": "",
}
region = {
  "1": "",
  "2": "",
  "3": "",
  "4": "",
  "5": "",
  "6": "",
  "7": "",
  "8": "",
  "9": "",
  "10": "",
  "12": "",
  "11.1": "",
  "11.2": "",
  "13": "",
  "14": "",
  "15": "",
  "16": "",
  "17": "",
  "18": "",
  "19": "",
  "20": "",
  "21": "",
  "22": "",
  "23": "",
  #"24": "",
  "25": "",
  "26": "",
  "32":"",
  "33":"",
  "34":"",
  "35":"",
  "36":"",
  "37":"",
  "99": "",
  "ba": "Basel-Stadt/Switzerland, Basel-Landschaft/Switzerland, Germany, France",
  "klzhcov": "Kanton Zurich",
  "klzhCov_Promega": "Kanton Zurich",
  "558600": "",
  "624801": "",
  "680000": "",
}
collectinglab = {
  "eawag": "Eawag, Swiss Federal Institute of Aquatic Science and Technology",
  "basel": "State Laboratory of Basel-Stadt, Basel, Switzerland; University of Basel, Basel, Switzerland; Division of Infectious Diseases and Hospital Epidemiology, University Hospital Basel, Basel, Switzerland",
  "microsynth": "Microsynth AG",
  "kzurich": "Cantonal laboratory Zurich",
}
## for eawag we have changes in authors depending on date. What we have is eawag_<date> where <date> indicates that any entry oldere than that should have that specific list
authors = {
  "eawag_20000101_20181131": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff",
  "eawag_20181209_20200131": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Elyse Stachler",
  "eawag_20200201_20200229": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler",
  "eawag_20200301_20200831": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler, Carola Bänziger",
  "eawag_20200901_20200930": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler, Carola Bänziger, Anina Kull",
  "eawag_20201001_20201031": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler, Carola Bänziger, Anina Kull, Federica Cariti",
  "eawag_20201101_20210131": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler, Anina Kull, Federica Cariti",
  "eawag_20210201_20210531": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler, Anina Kull, Federica Cariti, Alexander J. Devaux",
  "eawag_20210601_20210831": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler, Anina Kull, Federica Cariti, Alexander J. Devaux, Blanche Wies",
  "eawag_20210901_20210930": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Elyse Stachler, Federica Cariti, Alexander J. Devaux, Charlie Gan",
  "eawag_20211001_20211031": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Xavier Fernandez-Cassi, Federica Cariti, Alexander J. Devaux, Charlie Gan",
  "eawag_20211101_20211231": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Pravin Ganesanandamoorth, Federica Cariti, Alexander J. Devaux, Franziska Böni, Johannes Rusch, Charlie Gan",
  "eawag_20220101_20220229": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Federica Cariti, Alexander J. Devaux, Franziska Böni, Johannes Rusch, Charlie Gan",
  "eawag_20220301_20220430": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Federica Cariti, Alexander J. Devaux, Franziska Böni, Johannes Rusch, Laura Brülisauer, Camila Morales Undurraga, Charlie Gan",
  "eawag_20220501_20220930": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Alexander J. Devaux, Franziska Böni, Johannes Rusch, Laura Brülisauer, Camila Morales Undurraga, Charlie Gan",
  "eawag_20221001_20230131": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Alexander J. Devaux, Franziska Böni, Johannes Rusch, Laura Brülisauer, Aurélie Holschneider, Charlie Gan",
  "eawag_20230201_20230228": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Alexander J. Devaux, Franziska Böni, Laura Brülisauer, Seju Kang, Aurélie Holschneider, Charlie Gan",
  "eawag_20230301_20230331": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Alexander J. Devaux, Seju Kang, Ayazhan Dauletova, Camille Hablützel, Rachel McLeod, Aurélie Holschneider, Charlie Gan",
  "eawag_20230401_25000101": "Christoph Ort, Tamar Kohn, Timothy R. Julian, Lea Caduff, Seju Kang, Ayazhan Dauletova, Camille Hablützel, Rachel McLeod, Daniela Yordanova, Jolinda de Korne, Charlie Gan",
  "basel_20000101_25000101": "Claudia Bagutti, Evelyn Ilg Hampe, Sarah Tschudin Sutter",
  "microsynth_20000101_25000101": "Christoph Gruenig, Maria-Luise Deflorian",
  "kzurich_20000101_25000101": "Nadine Gerber, Natalie Meyer, René Köppel",
  "ethz_20000101_25000101": "Katharina Jahn, Pelin Burcak Icer, David Dreifuss, Ivan Topolsky, Lara Fuhrmann, Kim Philipp Jablonski, Anika John, Matteo Carrara, Franziska Singer, Chaoran Chen, Sarah Nadeau, Niko Beerenwinkel, Tanja Stadler",
  "fgcz_20000101_25000101": "Catharine Aquino, Lennart Opitz, Tim Sykes",
}
seqplatform = "Combination Illumina MiSeq and Illumina NovaSeq 5000/6000"
reportinglab = "Department of Biosystems Science and Engineering, ETH Zurich; Mattenstrasse 26, 4058 Basel"
qafile = "/data/projects/wastewater_automation/workdir/uploader/resources/qa.csv"
seqcenter = {
  "fgcz": "Functional Genomics Center Zurich",
}
centerused = "fgcz"
locations = "/data/projects/wastewater_automation/workdir/uploader/resources/ww_locations.tsv"
basedir = "/data/projects/wastewater_automation/pangolin/uploader"
samplesfolder = "/data/projects/dataset/cluster/project/pangolin/working/samples"
timelinefile = "/data/projects/wastewater_automation/workdir/uploader/resources/timeline.tsv"
assembly = "V-pipe"
embargo = ""
projyears = ["2020", "2021", "2022", "2023"]
submitting = "ETHZ"
