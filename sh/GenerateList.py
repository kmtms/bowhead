import pandas as pd

ds_suffix = "ds2x"

df = pd.read_csv("full.csv")

# full dataset
for col in ["id", "pop", "bam", "bam_path"]:
    df.to_csv("full_"+col+".txt", columns=[col], index=False, header=False)

# exclude samples with low coverage or strange
df = df[df["id"] != "24323"]
df = df[df["id"] != "24325"]
df = df[df["id"] != "Bowhead_published"]

# exclude samples with high relatedness
df = df[df["id"] != "24313"]
df = df[df["id"] != "CGG_1_024482"]

df = df.reset_index(drop=True)

# current list excluded above samples
for col in ["id", "pop", "bam", "bam_path"]:
    df.to_csv("list_"+col+".txt", columns=[col], index=False, header=False)
# then manually: paste list_id.txt list_pop.txt -d "_" > list_id_w_pop.txt

# list per population
for pop in ["EGSB", "ECWG", "BCB", "OKH"]:
    temp_df = df[df["pop"] == pop]
    for col in ["bam_path"]:
        temp_df.to_csv("pop"+pop+"_"+col+".txt", columns=[col], index=False, header=False)
        if(pop == "EGSB"): # downsampled samples
            temp_df.to_csv("pop"+pop+ds_suffix+"_"+col+".txt", columns=[ds_suffix+"_"+col], index=False, header=False)
            temp_df = temp_df[ds_suffix+"_"+col]
            # print(temp_df)
            temp_df = temp_df.append(df[df["pop"] != "EGSB"][col], ignore_index=True)
            # print(temp_df)
            temp_df.to_csv("list_"+ds_suffix+"_"+col+".txt", index=False, header=False)

# print(df)
