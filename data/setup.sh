if [ -d ./data/corenlp_plot_summaries ] && [ 42306 -eq "$(ls -1 data/corenlp_plot_summaries | wc -l)" ];
then
    echo "Data is ready"
else
    if [ ! -f ./data/corenlp_plot_summaries.tar ];
    then
        echo "Downloading CoreNLP plot summaries..."
        wget -O ./data/corenlp_plot_summaries.tar http://www.cs.cmu.edu/~ark/personas/data/corenlp_plot_summaries.tar
    fi
    echo "6d444c7fb998f7c9fb65ae3fb9bcf9c808047d3b  ./data/corenlp_plot_summaries.tar" | shasum -c
    if [ $? -eq 0 ];
    then
        echo "Extracting CoreNLP plot summaries..."
        tar -xzf data/corenlp_plot_summaries.tar --directory=data
        echo "Done"
    else
        echo "Data is corrupted. Please try again."
        rm ./data/corenlp_plot_summaries.tar
    fi 
fi
