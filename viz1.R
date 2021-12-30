ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species))+
  labs(title="palmer penguins: body mass vs. flipper length",
       subtitle = "sample of three penguin species",
       caption = "Data collected by Dr . kristen Gorman")+
  annotate("text", x=220, y=3500, label="The gentoos are the largest", color="blue",angle=25,size=3.5,fontface="bold")
  #facet_wrap(~species)

#create variable to store your viz

p<-ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species))+
  labs(title="palmer penguins: body mass vs. flipper length",
       subtitle = "sample of three penguin species",
       caption = "Data collected by Dr . kristen Gorman")


p+annotate("text", x=220, y=3500, label="The gentoos are the largest", color="blue",angle=25,size=3.5,fontface="bold")

ggplot(data = penguins) +
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g, linetype=species))

ggplot(data = penguins) +
  geom_jitter(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data=diamonds) +
  geom_bar(mapping = aes(x = color, fill=cut))+
  facet_wrap(~cut)

ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species))+
  facet_grid(sex~species)

