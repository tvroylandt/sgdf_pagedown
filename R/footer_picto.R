# ------------------------- #
# - Créer un footer picto - #
# ------------------------- #

library(tidyverse)
library(magick)

# On sample 20 pictos dans la liste
liste_pictos <-
  list.files(
    "elements_graphiques/picto/01_COMMUNS/PNG BLANC/",
    pattern = ".png",
    full.names = TRUE
  ) %>%
  sample(20)

# On sample 20 couleurs dans une liste
liste_couleurs <- rep(c(
  "#ff8300",
  "#0077b3",
  "#d03f15",
  "#007254",
  "#65bc99",
  "#6e74aa",
  rep("#003a5d", 4)
),
50) %>%
  sample(20)

# Fonction qui lit et colorie les images
image_read_color <- function(chemin, couleur) {
  image_read(chemin) %>%
    image_colorize(opacity = 100, color = couleur)
}

# On applique
liste_images <- map2(.x = liste_pictos,
                     .y = liste_couleurs,
                     . = image_read_color)

# Construction du footer
# On prend 10 images, 
# on laisse l'équivalent de 2 images en place : 710 * 355
# Et on reprend 10 images
footer_picto <- image_append(c(image_join(liste_images[1:10]),
             image_blank(width = 755, height = 355),
             image_join(liste_images[11:20])))

# Export
image_write(footer_picto, paste0("elements_creation/footer_picto_", Sys.time(), ".png"))
