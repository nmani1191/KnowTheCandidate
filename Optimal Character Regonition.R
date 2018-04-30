
################################## METHOD A - Using R Tesseract Pcakage ##########################

library(tesseract)
eng <- tesseract("eng")
text <- tesseract::ocr("http://jeroen.github.io/images/testocr.png", engine = eng)
cat(text)

# ocr_data() function returns all words in the image along with a bounding box and confidence rate.
results <- tesseract::ocr_data("http://jeroen.github.io/images/testocr.png", engine = eng)
print(results, n = 20)

#to list the languages that you currently have installed.
tesseract_info()

#By default the R package only includes English training data. 
#Windows and Mac users can install additional training data using  tesseract_download()
tesseract_download("tam")

# Read Tamil Text
tamil <- tesseract("tam")
text <- tesseract::ocr("https://i.pinimg.com/originals/57/cf/5d/57cf5d6fcf37be2d8e26ee01eda77941.jpg", engine = tamil)
cat(text)
text1 <- tesseract::ocr("https://i.pinimg.com/originals/87/81/61/8781613c7477ec5e2c85fc0a0b298d68.jpg",engine = tamil)
cat(text1)


#----------------------------------------------------------------------------#

library(magick)

input <- image_read("https://jeroen.github.io/images/bowers.jpg")

text <- tesseract::ocr(input)
cat(text)


text <- input %>%
  image_resize("2000x") %>%
  image_convert(type = 'Grayscale') %>%
  image_trim(fuzz = 40) %>%
  image_write(format = 'png', density = '300x300') %>%
  tesseract::ocr() 

cat(text)

#----------------------------------------------------------------------------#

#Read from PDF files
pngfile <- pdftools::pdf_convert('https://jeroen.github.io/images/ocrscan.pdf', dpi = 600)
text <- tesseract::ocr(pngfile)
cat(text)

pngfile <- pdftools::pdf_convert('U07-Puducherry-4--May-2016 ( GEN )-3-S.V. SUGUMARAN.PDF', dpi = 600)

input <- image_read(pngfile[2])

text <- input %>%
  image_resize("2000x") %>%
  image_convert(type = 'Grayscale') %>%
  image_trim(fuzz = 40) %>%
  image_write(format = 'png', density = '300x300') %>%
  tesseract::ocr(engine = tamil)

cat(text)

###########################################################################################################


################################## METHOD B - Using Google Drive package ################

library(googledrive)

drive_auth()

drive_find(n_max = 10)

drive_upload("U07-Puducherry-4--May-2016 ( GEN )-3-S.V. SUGUMARAN.PDF",type = "document")

flist <- drive_find(n_max = 10)
drive_download(as_id("1M3bF7DH7cxaRI4m_ugfKaO8xv0aIJ8Fxmv3MCaFmOeM"))

drive_download(as_id("1M3bF7DH7cxaRI4m_ugfKaO8xv0aIJ8Fxmv3MCaFmOeM"),type = "text")


##########################################################################################################