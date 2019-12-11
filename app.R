library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
library(tidyverse)
library(plotly)
library(scales)
# Retriving the data
df_stable <- read.csv('most_stable_job.csv', header=TRUE , sep=',')
df_2M_pop <- read.csv('2000_pop_job.csv', header=TRUE , sep=',')


app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

# Selection components

#We can get the years from the dataset to make ticks on the slider

graphDropdown <- dccDropdown(
  id = "question",
  # map/lapply can be used as a shortcut instead of writing the whole list
  # especially useful if you wanted to filter by country!
  options = list(
    list(label = "Top 10 stable job", value = "sd"),
    list(label = "Top 10 popular job", value = "pop")),
  value = 'sd', #Selects all by default
  clearable= FALSE,
  multi = FALSE
)

graphRadio <- dccRadioItems(
  id = 'graph_type',
  options = list(
    list(label = "Bar", value = "bar"),
    list(label = "Bar + Line", value = "both")),
  value = 'bar'
)

##########
wrang_stable <- df_stable %>% filter(year_x == 2000, sex == 'men') %>% arrange(std)
wrang_stable$job <- factor(wrang_stable$job, levels = wrang_stable$job[order(wrang_stable$std)])
options(repr.plot.width = 50, repr.plot.height = 50)
plot_stable_bar <- wrang_stable %>% 
  ggplot(aes(x = job, y = std, fill = job)) + 
  geom_col() +
  ylab("Standard Deviation") + xlab("Job") +
  ggtitle("SD of the Ten Most Stable Jobs from 1850 to 2000") +
  scale_y_continuous(labels = comma) +
  theme_bw()+
  theme(axis.text = element_text(size = 8),
        axis.title = element_text(size = 9),
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.title = element_text(size = 10) ,
        legend.title = element_text(size = 6),
        legend.text = element_text(size = 6)
        #        legend.position = "none"
  ) 

bar_sd <- ggplotly(plot_stable_bar, height= 2000) 

# Popular jobs in 2000 - bar plot
wrang_pop <- df_2M_pop %>% filter(year_x == 2000) %>% arrange(desc(together_y))
wrang_pop$job <- factor(wrang_pop$job, levels = wrang_pop$job[order(desc(wrang_pop$together_y))])

plot_pop_bar <- wrang_pop %>% 
  ggplot(aes(x = job, y = together_y, fill = job)) + 
  geom_col() +
  ylab("Percentage") + xlab("Job") +
  ggtitle("Percentage of the Ten Most Popular Jobs in 2000") +
  scale_y_continuous(labels = percent) +
  theme_bw()+
  theme(axis.text = element_text(size = 8),
        axis.title = element_text(size = 9),
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.title = element_text(size = 10) ,
        legend.title = element_text(size = 6),
        legend.text = element_text(size = 6)
        #        legend.position = "none"
  ) 
bar_pop <- ggplotly(plot_pop_bar, height= 2000) 

wrang_stable2 <- df_stable %>% filter(sex == 'men')
wrang_stable2$job <- factor(wrang_stable2$job) %>% fct_relevel(levels(wrang_stable$job))

plot_stable_line <- wrang_stable2 %>%
  ggplot(aes(x = year_x, y = perc, color = job)) +
  geom_line() +
  geom_point() +
  ylab("Percentage in Total Work Force") + xlab("Year") +
  ggtitle("Populariy of Ten Most Stable Jobs Over Time") +
  scale_y_continuous(labels = percent) +
  theme_bw()+
  theme(axis.text = element_text(size = 8),
        axis.title = element_text(size = 9),
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.title = element_text(size = 10) ,
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8)
  ) 
line_sd <-ggplotly(plot_stable_line, height= 2000) 

# Popular jobs in 2000 - line plot
wrang_pop2 <- df_2M_pop
wrang_pop2$job <- factor(wrang_pop2$job) %>% fct_relevel(levels(wrang_pop$job))
#wrang_pop2$job <- factor(wrang_pop$job)

plot_pop_line <- wrang_pop2 %>% 
  ggplot(aes(x = year_x, y = together_x, color = job)) +
  geom_line() +
  geom_point() +
  ylab("Percentage in Total Work Force") + xlab("Year") +
  ggtitle("Populariy Trend of 2000's Ten Most Popular Jobs") +
  scale_y_continuous(labels = percent) +
  theme_bw()+
  theme(axis.text = element_text(size = 8),
        axis.title = element_text(size = 9),
        axis.text.x = element_text(angle = 30, hjust = 1),
        plot.title = element_text(size = 10) ,
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8)
  ) 
line_pop <-ggplotly(plot_pop_line, height= 2000) 
###########

make_graph <- function(chart_type = 'bar',
                       categ = 'sd'){
  if(chart_type == 'both' && categ == 'sd'){
    return(subplot(bar_sd, line_sd, nrows = 2))
  }else if (chart_type == 'both' && categ == 'pop'){
    return(subplot(bar_pop, line_pop, nrows = 2))
  }else if (chart_type == 'bar' && categ == 'sd'){
    return(bar_sd)
  }else if (chart_type == 'bar' && categ == 'pop'){
    return(bar_pop)
  }
  
  
}

# Now we define the graph as a dash component using generated figure
graph <- dccGraph(
  id = 'graph',
  figure=make_graph() # gets initial data using argument defaults
)



app$layout(
  htmlDiv(
    list(
      htmlH1('Job Tracker'),
      htmlH2("Find the most stable jobs from 1850 to 2000 and most popular job in 2000 "),
      graphDropdown,
      graphRadio,
      htmlIframe(height=80, width=10, style=list(borderWidth = 0)),
      graph
    )
  )
)

# Adding callbacks for interactivity
# We need separate callbacks to update graph and table
# BUT can use multiple inputs for each!
app$callback(
  #update figure of gap-graph
  output=list(id = 'graph', property='figure'),
  #based on values of year, continent, y-axis components
  params=list(input(id = 'graph_type', property='value'),
              input(id = 'question', property='value')),
  #this translates your list of params into function arguments
  function(chart_typ_value, categ_value) {
    make_graph(chart_typ_value, categ_value)
  })



app$run_server()

