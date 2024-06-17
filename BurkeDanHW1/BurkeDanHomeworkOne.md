# **Homework One**
**Dan Burke**
**August 5, 2023**

# Import Libraries


```python
import pandas as pd
import csv
import numpy as np
```

# Bespoke Code to Read Data from File
**List of Dictionaries, or some combination of lists, dictionaries and NumPy Arrays**

Below, are two methods created to read a CSV file, then create a list of dictionaries (key = column name | value = list of column values), then transform the list of dictionaries into a pandas dataframe.

This is perhaps the road less travelled as it is much less effort to only utilize the pandas library to read in a csv to a dataframe, however in the spirit of this course, both approaches are applied.

Read in the data from file (Doner Data CSV)


```python
# Method to read a csv file from a local directory,
# then transform that data into a list of dictionaries
def ReadCSVGetListOfDictByColumn(csv_path):
  with open(csv_path) as f:
    colnames = []
    rowData = []
    index = 0
    for row in f:
      if index == 0:
        colnames = row.split(',')
      if index != 0:
        rowsData = row.split(',')
        rowData.append(rowsData)
      index = index + 1;

    #Create the List of Dictionaries
    listOfDicts = {}
    for i in range(0,len(colnames)):
      colStr = colnames[i]
      colDataList = []
      for y in range(0,len(rowData)):
        colDataList.append(rowData[y][i])
      listOfDicts[colStr] = colDataList

    return listOfDicts

# Method to return a dataframe, this leverages the above method
# then iterates over each dictionary and appeand an empty dataframe
def GetDataFrameFromCSV(path):
      dataDicts = ReadCSVGetListOfDictByColumn(path)
      keyNames = dataDicts.keys()
      df = pd.DataFrame()
      for colName in keyNames:
        df[colName] = dataDicts[colName]
        df[colName] = df[colName].astype(float)
      return df

# Implementation of both methods
dataDicts = ReadCSVGetListOfDictByColumn('/content/donors_data.csv')
df = GetDataFrameFromCSV('/content/donors_data.csv')

#Viewing the frist 6 rows of the dataframe to provide a sanity check
# comparable against the following use of the pandas library
df.head()
df.columns

```




    Index(['Row Id', 'Row Id.', 'zipconvert_2', 'zipconvert_3', 'zipconvert_4',
           'zipconvert_5', 'homeowner dummy', 'NUMCHLD', 'INCOME', 'gender dummy',
           'WEALTH', 'HV', 'Icmed', 'Icavg', 'IC15', 'NUMPROM', 'RAMNTALL',
           'MAXRAMNT', 'LASTGIFT', 'totalmonths', 'TIMELAG', 'AVGGIFT', 'TARGET_B',
           'TARGET_D\n'],
          dtype='object')




```python
donerData = pd.read_csv('/content/donors_data.csv')
donerData.head()
```






  <div id="df-afd2453a-a733-4add-9c14-452dadf9707f">
    <div class="colab-df-container">
      <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Row Id</th>
      <th>Row Id.</th>
      <th>zipconvert_2</th>
      <th>zipconvert_3</th>
      <th>zipconvert_4</th>
      <th>zipconvert_5</th>
      <th>homeowner dummy</th>
      <th>NUMCHLD</th>
      <th>INCOME</th>
      <th>gender dummy</th>
      <th>...</th>
      <th>IC15</th>
      <th>NUMPROM</th>
      <th>RAMNTALL</th>
      <th>MAXRAMNT</th>
      <th>LASTGIFT</th>
      <th>totalmonths</th>
      <th>TIMELAG</th>
      <th>AVGGIFT</th>
      <th>TARGET_B</th>
      <th>TARGET_D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>17</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>5</td>
      <td>1</td>
      <td>...</td>
      <td>1</td>
      <td>74</td>
      <td>102.0</td>
      <td>6.0</td>
      <td>5.0</td>
      <td>29</td>
      <td>3</td>
      <td>4.857143</td>
      <td>1</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>25</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>...</td>
      <td>4</td>
      <td>46</td>
      <td>94.0</td>
      <td>12.0</td>
      <td>12.0</td>
      <td>34</td>
      <td>6</td>
      <td>9.400000</td>
      <td>1</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>29</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>2</td>
      <td>5</td>
      <td>1</td>
      <td>...</td>
      <td>13</td>
      <td>32</td>
      <td>30.0</td>
      <td>10.0</td>
      <td>5.0</td>
      <td>29</td>
      <td>7</td>
      <td>4.285714</td>
      <td>1</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>38</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>3</td>
      <td>0</td>
      <td>...</td>
      <td>4</td>
      <td>94</td>
      <td>177.0</td>
      <td>10.0</td>
      <td>8.0</td>
      <td>30</td>
      <td>3</td>
      <td>7.080000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>40</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>4</td>
      <td>0</td>
      <td>...</td>
      <td>7</td>
      <td>20</td>
      <td>23.0</td>
      <td>11.0</td>
      <td>11.0</td>
      <td>30</td>
      <td>6</td>
      <td>7.666667</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 24 columns</p>
</div>
      <button class="colab-df-convert" onclick="convertToInteractive('df-afd2453a-a733-4add-9c14-452dadf9707f')"
              title="Convert this dataframe to an interactive table."
              style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
       width="24px">
    <path d="M0 0h24v24H0V0z" fill="none"/>
    <path d="M18.56 5.44l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94zm-11 1L8.5 8.5l.94-2.06 2.06-.94-2.06-.94L8.5 2.5l-.94 2.06-2.06.94zm10 10l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94z"/><path d="M17.41 7.96l-1.37-1.37c-.4-.4-.92-.59-1.43-.59-.52 0-1.04.2-1.43.59L10.3 9.45l-7.72 7.72c-.78.78-.78 2.05 0 2.83L4 21.41c.39.39.9.59 1.41.59.51 0 1.02-.2 1.41-.59l7.78-7.78 2.81-2.81c.8-.78.8-2.07 0-2.86zM5.41 20L4 18.59l7.72-7.72 1.47 1.35L5.41 20z"/>
  </svg>
      </button>



    <div id="df-f82aa2fd-8628-4608-8856-b9d4109aec53">
      <button class="colab-df-quickchart" onclick="quickchart('df-f82aa2fd-8628-4608-8856-b9d4109aec53')"
              title="Suggest charts."
              style="display:none;">

<svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
     width="24px">
    <g>
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
    </g>
</svg>
      </button>
    </div>

<style>
  .colab-df-quickchart {
    background-color: #E8F0FE;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: none;
    fill: #1967D2;
    height: 32px;
    padding: 0 0 0 0;
    width: 32px;
  }

  .colab-df-quickchart:hover {
    background-color: #E2EBFA;
    box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
    fill: #174EA6;
  }

  [theme=dark] .colab-df-quickchart {
    background-color: #3B4455;
    fill: #D2E3FC;
  }

  [theme=dark] .colab-df-quickchart:hover {
    background-color: #434B5C;
    box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
    filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
    fill: #FFFFFF;
  }
</style>

    <script>
      async function quickchart(key) {
        const containerElement = document.querySelector('#' + key);
        const charts = await google.colab.kernel.invokeFunction(
            'suggestCharts', [key], {});
      }
    </script>

      <script>

function displayQuickchartButton(domScope) {
  let quickchartButtonEl =
    domScope.querySelector('#df-f82aa2fd-8628-4608-8856-b9d4109aec53 button.colab-df-quickchart');
  quickchartButtonEl.style.display =
    google.colab.kernel.accessAllowed ? 'block' : 'none';
}

        displayQuickchartButton(document);
      </script>
      <style>
    .colab-df-container {
      display:flex;
      flex-wrap:wrap;
      gap: 12px;
    }

    .colab-df-convert {
      background-color: #E8F0FE;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: none;
      fill: #1967D2;
      height: 32px;
      padding: 0 0 0 0;
      width: 32px;
    }

    .colab-df-convert:hover {
      background-color: #E2EBFA;
      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
      fill: #174EA6;
    }

    [theme=dark] .colab-df-convert {
      background-color: #3B4455;
      fill: #D2E3FC;
    }

    [theme=dark] .colab-df-convert:hover {
      background-color: #434B5C;
      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
      fill: #FFFFFF;
    }
  </style>

      <script>
        const buttonEl =
          document.querySelector('#df-afd2453a-a733-4add-9c14-452dadf9707f button.colab-df-convert');
        buttonEl.style.display =
          google.colab.kernel.accessAllowed ? 'block' : 'none';

        async function convertToInteractive(key) {
          const element = document.querySelector('#df-afd2453a-a733-4add-9c14-452dadf9707f');
          const dataTable =
            await google.colab.kernel.invokeFunction('convertToInteractive',
                                                     [key], {});
          if (!dataTable) return;

          const docLinkHtml = 'Like what you see? Visit the ' +
            '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
            + ' to learn more about interactive tables.';
          element.innerHTML = '';
          dataTable['output_type'] = 'display_data';
          await google.colab.output.renderOutput(dataTable, element);
          const docLink = document.createElement('div');
          docLink.innerHTML = docLinkHtml;
          element.appendChild(docLink);
        }
      </script>
    </div>
  </div>




# Data Exploration

**For each wealth type, what is the average home value of all the donors of that type?**



```python
wealthTypes = donerData['WEALTH'].unique()
wealthHomeVal = []
for x in wealthTypes:
  meanHV = donerData.loc[donerData['WEALTH'] == x, 'HV'].mean()
  wealthHomeVal = meanHV


meanHomeValDf = pd.DataFrame()
meanHomeValDf['wealthType'] = wealthTypes
meanHomeValDf['meanHv'] = wealthHomeVal

meanHomeValDf
```






  <div id="df-e9a78c46-5e92-4962-8bcc-32a2b465bd0a">
    <div class="colab-df-container">
      <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>wealthType</th>
      <th>meanHv</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>9</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>1</th>
      <td>7</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>2</th>
      <td>8</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>6</th>
      <td>2</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>8</th>
      <td>1</td>
      <td>817.709877</td>
    </tr>
    <tr>
      <th>9</th>
      <td>3</td>
      <td>817.709877</td>
    </tr>
  </tbody>
</table>
</div>
      <button class="colab-df-convert" onclick="convertToInteractive('df-e9a78c46-5e92-4962-8bcc-32a2b465bd0a')"
              title="Convert this dataframe to an interactive table."
              style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
       width="24px">
    <path d="M0 0h24v24H0V0z" fill="none"/>
    <path d="M18.56 5.44l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94zm-11 1L8.5 8.5l.94-2.06 2.06-.94-2.06-.94L8.5 2.5l-.94 2.06-2.06.94zm10 10l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94z"/><path d="M17.41 7.96l-1.37-1.37c-.4-.4-.92-.59-1.43-.59-.52 0-1.04.2-1.43.59L10.3 9.45l-7.72 7.72c-.78.78-.78 2.05 0 2.83L4 21.41c.39.39.9.59 1.41.59.51 0 1.02-.2 1.41-.59l7.78-7.78 2.81-2.81c.8-.78.8-2.07 0-2.86zM5.41 20L4 18.59l7.72-7.72 1.47 1.35L5.41 20z"/>
  </svg>
      </button>



    <div id="df-4b93d825-9d51-410f-a047-7a9afef074ba">
      <button class="colab-df-quickchart" onclick="quickchart('df-4b93d825-9d51-410f-a047-7a9afef074ba')"
              title="Suggest charts."
              style="display:none;">

<svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
     width="24px">
    <g>
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
    </g>
</svg>
      </button>
    </div>

<style>
  .colab-df-quickchart {
    background-color: #E8F0FE;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: none;
    fill: #1967D2;
    height: 32px;
    padding: 0 0 0 0;
    width: 32px;
  }

  .colab-df-quickchart:hover {
    background-color: #E2EBFA;
    box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
    fill: #174EA6;
  }

  [theme=dark] .colab-df-quickchart {
    background-color: #3B4455;
    fill: #D2E3FC;
  }

  [theme=dark] .colab-df-quickchart:hover {
    background-color: #434B5C;
    box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
    filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
    fill: #FFFFFF;
  }
</style>

    <script>
      async function quickchart(key) {
        const containerElement = document.querySelector('#' + key);
        const charts = await google.colab.kernel.invokeFunction(
            'suggestCharts', [key], {});
      }
    </script>

      <script>

function displayQuickchartButton(domScope) {
  let quickchartButtonEl =
    domScope.querySelector('#df-4b93d825-9d51-410f-a047-7a9afef074ba button.colab-df-quickchart');
  quickchartButtonEl.style.display =
    google.colab.kernel.accessAllowed ? 'block' : 'none';
}

        displayQuickchartButton(document);
      </script>
      <style>
    .colab-df-container {
      display:flex;
      flex-wrap:wrap;
      gap: 12px;
    }

    .colab-df-convert {
      background-color: #E8F0FE;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: none;
      fill: #1967D2;
      height: 32px;
      padding: 0 0 0 0;
      width: 32px;
    }

    .colab-df-convert:hover {
      background-color: #E2EBFA;
      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
      fill: #174EA6;
    }

    [theme=dark] .colab-df-convert {
      background-color: #3B4455;
      fill: #D2E3FC;
    }

    [theme=dark] .colab-df-convert:hover {
      background-color: #434B5C;
      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
      fill: #FFFFFF;
    }
  </style>

      <script>
        const buttonEl =
          document.querySelector('#df-e9a78c46-5e92-4962-8bcc-32a2b465bd0a button.colab-df-convert');
        buttonEl.style.display =
          google.colab.kernel.accessAllowed ? 'block' : 'none';

        async function convertToInteractive(key) {
          const element = document.querySelector('#df-e9a78c46-5e92-4962-8bcc-32a2b465bd0a');
          const dataTable =
            await google.colab.kernel.invokeFunction('convertToInteractive',
                                                     [key], {});
          if (!dataTable) return;

          const docLinkHtml = 'Like what you see? Visit the ' +
            '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
            + ' to learn more about interactive tables.';
          element.innerHTML = '';
          dataTable['output_type'] = 'display_data';
          await google.colab.output.renderOutput(dataTable, element);
          const docLink = document.createElement('div');
          docLink.innerHTML = docLinkHtml;
          element.appendChild(docLink);
        }
      </script>
    </div>
  </div>





```python
#Write to CSV file in local directory
meanHomeValDf.to_csv("meanHvByWealthType.csv", sep=',', encoding='utf-8')
```

# Further Data Inquiry
**Inquiry:**

How does home value correlate to gender?

How does Income correlate to last gift?

How does each zip code correlate to average and last gift and then income correlate to each zip code?


```python
donerData = pd.read_csv('/content/donors_data.csv')

# Method to return the correlation of two columns within the donerData dataframe
def getCorrOf(col1, col2):
  corr = donerData[col1].corr(donerData[col2])
  print("Correlation between ", col1, " and ", col2, "is: ", round(corr, 2))

getCorrOf("HV", "gender dummy")
getCorrOf("gender dummy", "homeowner dummy")
getCorrOf("INCOME", "LASTGIFT")
getCorrOf("INCOME", "AVGGIFT")

getCorrOf("zipconvert_2", "AVGGIFT")
getCorrOf("zipconvert_3", "AVGGIFT")
getCorrOf("zipconvert_4", "AVGGIFT")
getCorrOf("zipconvert_5", "AVGGIFT")

getCorrOf("zipconvert_2", "LASTGIFT")
getCorrOf("zipconvert_3", "LASTGIFT")
getCorrOf("zipconvert_4", "LASTGIFT")
getCorrOf("zipconvert_5", "LASTGIFT")

getCorrOf("zipconvert_2", "LASTGIFT")
getCorrOf("zipconvert_3", "LASTGIFT")
getCorrOf("zipconvert_4", "LASTGIFT")
getCorrOf("zipconvert_5", "LASTGIFT")

getCorrOf("zipconvert_2", "INCOME")
getCorrOf("zipconvert_3", "INCOME")
getCorrOf("zipconvert_4", "INCOME")
getCorrOf("zipconvert_5", "INCOME")
```

    Correlation between  HV  and  gender dummy is:  -0.02
    Correlation between  gender dummy  and  homeowner dummy is:  0.0
    Correlation between  INCOME  and  LASTGIFT is:  0.11
    Correlation between  INCOME  and  AVGGIFT is:  0.13
    Correlation between  zipconvert_2  and  AVGGIFT is:  -0.01
    Correlation between  zipconvert_3  and  AVGGIFT is:  -0.06
    Correlation between  zipconvert_4  and  AVGGIFT is:  -0.03
    Correlation between  zipconvert_5  and  AVGGIFT is:  0.08
    Correlation between  zipconvert_2  and  LASTGIFT is:  -0.0
    Correlation between  zipconvert_3  and  LASTGIFT is:  -0.05
    Correlation between  zipconvert_4  and  LASTGIFT is:  -0.03
    Correlation between  zipconvert_5  and  LASTGIFT is:  0.07
    Correlation between  zipconvert_2  and  LASTGIFT is:  -0.0
    Correlation between  zipconvert_3  and  LASTGIFT is:  -0.05
    Correlation between  zipconvert_4  and  LASTGIFT is:  -0.03
    Correlation between  zipconvert_5  and  LASTGIFT is:  0.07
    Correlation between  zipconvert_2  and  INCOME is:  -0.01
    Correlation between  zipconvert_3  and  INCOME is:  -0.09
    Correlation between  zipconvert_4  and  INCOME is:  -0.02
    Correlation between  zipconvert_5  and  INCOME is:  0.09


# Correlation Findings and Conclusion

Generating the correlation between zip codes, income, last and average gift yields interesting results; specifically for "zipconvert_5". This particular zip code was **positivly correlated** for all three adjacent columns. In addition to this zip code having a higher correlation with average and last gift it was also found that last and average gift is positivly correlated with income.

In conlcusion, the higher the income for a particular area of interest (zip code in this analysis) the higher the correlation with average and last gift. "zipconvert_5" is congruent with these findings.

Given the above findings it is recommended to further analyize this data within the context/lens of income and geographic region.

# Further Data Exploration via Grouping

To further explore the data and begin to forumlate questions about this data, it may be advantageous to examine the data via grouping (below).


```python
donerData = pd.read_csv('/content/donors_data.csv')

donerData = donerData.drop(['zipconvert_2','zipconvert_3','zipconvert_4','zipconvert_5'], axis = 1)

gk = donerData.groupby(['NUMCHLD','INCOME'])
```


```python
gk.first()

```






  <div id="df-c4867919-3aa4-40e5-84e1-62384ae495b4">
    <div class="colab-df-container">
      <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>Row Id</th>
      <th>Row Id.</th>
      <th>homeowner dummy</th>
      <th>gender dummy</th>
      <th>WEALTH</th>
      <th>HV</th>
      <th>Icmed</th>
      <th>Icavg</th>
      <th>IC15</th>
      <th>NUMPROM</th>
      <th>RAMNTALL</th>
      <th>MAXRAMNT</th>
      <th>LASTGIFT</th>
      <th>totalmonths</th>
      <th>TIMELAG</th>
      <th>AVGGIFT</th>
      <th>TARGET_B</th>
      <th>TARGET_D</th>
    </tr>
    <tr>
      <th>NUMCHLD</th>
      <th>INCOME</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="7" valign="top">1</th>
      <th>1</th>
      <td>2</td>
      <td>25</td>
      <td>1</td>
      <td>0</td>
      <td>7</td>
      <td>698</td>
      <td>422</td>
      <td>463</td>
      <td>4</td>
      <td>46</td>
      <td>94.00</td>
      <td>12.0</td>
      <td>12.0</td>
      <td>34</td>
      <td>6</td>
      <td>9.400000</td>
      <td>1</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>15</td>
      <td>149</td>
      <td>0</td>
      <td>0</td>
      <td>8</td>
      <td>1052</td>
      <td>337</td>
      <td>402</td>
      <td>5</td>
      <td>27</td>
      <td>50.00</td>
      <td>20.0</td>
      <td>20.0</td>
      <td>37</td>
      <td>7</td>
      <td>16.666667</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>38</td>
      <td>1</td>
      <td>0</td>
      <td>4</td>
      <td>1471</td>
      <td>484</td>
      <td>546</td>
      <td>4</td>
      <td>94</td>
      <td>177.00</td>
      <td>10.0</td>
      <td>8.0</td>
      <td>30</td>
      <td>3</td>
      <td>7.080000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>40</td>
      <td>1</td>
      <td>0</td>
      <td>8</td>
      <td>547</td>
      <td>386</td>
      <td>432</td>
      <td>7</td>
      <td>20</td>
      <td>23.00</td>
      <td>11.0</td>
      <td>11.0</td>
      <td>30</td>
      <td>6</td>
      <td>7.666667</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1</td>
      <td>17</td>
      <td>1</td>
      <td>1</td>
      <td>9</td>
      <td>1399</td>
      <td>637</td>
      <td>703</td>
      <td>1</td>
      <td>74</td>
      <td>102.00</td>
      <td>6.0</td>
      <td>5.0</td>
      <td>29</td>
      <td>3</td>
      <td>4.857143</td>
      <td>1</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>20</td>
      <td>182</td>
      <td>0</td>
      <td>1</td>
      <td>7</td>
      <td>995</td>
      <td>372</td>
      <td>407</td>
      <td>10</td>
      <td>83</td>
      <td>476.00</td>
      <td>25.0</td>
      <td>10.0</td>
      <td>28</td>
      <td>6</td>
      <td>13.600000</td>
      <td>1</td>
      <td>23.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>21</td>
      <td>186</td>
      <td>1</td>
      <td>0</td>
      <td>7</td>
      <td>936</td>
      <td>521</td>
      <td>590</td>
      <td>11</td>
      <td>69</td>
      <td>98.00</td>
      <td>6.0</td>
      <td>5.0</td>
      <td>31</td>
      <td>2</td>
      <td>3.629630</td>
      <td>1</td>
      <td>4.0</td>
    </tr>
    <tr>
      <th rowspan="7" valign="top">2</th>
      <th>1</th>
      <td>1408</td>
      <td>10572</td>
      <td>0</td>
      <td>1</td>
      <td>8</td>
      <td>551</td>
      <td>284</td>
      <td>320</td>
      <td>21</td>
      <td>37</td>
      <td>108.00</td>
      <td>20.0</td>
      <td>15.0</td>
      <td>31</td>
      <td>2</td>
      <td>13.500000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>128</td>
      <td>930</td>
      <td>0</td>
      <td>1</td>
      <td>8</td>
      <td>623</td>
      <td>379</td>
      <td>388</td>
      <td>6</td>
      <td>43</td>
      <td>37.00</td>
      <td>9.0</td>
      <td>5.0</td>
      <td>29</td>
      <td>3</td>
      <td>3.700000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>194</td>
      <td>1450</td>
      <td>0</td>
      <td>1</td>
      <td>8</td>
      <td>841</td>
      <td>464</td>
      <td>498</td>
      <td>4</td>
      <td>29</td>
      <td>64.00</td>
      <td>10.0</td>
      <td>7.0</td>
      <td>29</td>
      <td>1</td>
      <td>8.000000</td>
      <td>1</td>
      <td>8.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>163</td>
      <td>1213</td>
      <td>0</td>
      <td>0</td>
      <td>3</td>
      <td>931</td>
      <td>435</td>
      <td>477</td>
      <td>5</td>
      <td>43</td>
      <td>109.00</td>
      <td>10.0</td>
      <td>9.0</td>
      <td>31</td>
      <td>8</td>
      <td>6.411765</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>3</td>
      <td>29</td>
      <td>0</td>
      <td>1</td>
      <td>8</td>
      <td>828</td>
      <td>358</td>
      <td>376</td>
      <td>13</td>
      <td>32</td>
      <td>30.00</td>
      <td>10.0</td>
      <td>5.0</td>
      <td>29</td>
      <td>7</td>
      <td>4.285714</td>
      <td>1</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>831</td>
      <td>6212</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>672</td>
      <td>192</td>
      <td>221</td>
      <td>34</td>
      <td>72</td>
      <td>188.00</td>
      <td>25.0</td>
      <td>20.0</td>
      <td>33</td>
      <td>15</td>
      <td>12.533333</td>
      <td>1</td>
      <td>20.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>196</td>
      <td>1462</td>
      <td>1</td>
      <td>1</td>
      <td>8</td>
      <td>1198</td>
      <td>556</td>
      <td>590</td>
      <td>6</td>
      <td>60</td>
      <td>101.00</td>
      <td>10.0</td>
      <td>10.0</td>
      <td>34</td>
      <td>6</td>
      <td>6.312500</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th rowspan="6" valign="top">3</th>
      <th>2</th>
      <td>2009</td>
      <td>14942</td>
      <td>0</td>
      <td>1</td>
      <td>8</td>
      <td>888</td>
      <td>233</td>
      <td>335</td>
      <td>33</td>
      <td>24</td>
      <td>42.00</td>
      <td>10.0</td>
      <td>10.0</td>
      <td>28</td>
      <td>2</td>
      <td>7.000000</td>
      <td>1</td>
      <td>7.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>579</td>
      <td>4244</td>
      <td>1</td>
      <td>0</td>
      <td>2</td>
      <td>556</td>
      <td>269</td>
      <td>290</td>
      <td>26</td>
      <td>44</td>
      <td>60.00</td>
      <td>25.0</td>
      <td>25.0</td>
      <td>31</td>
      <td>14</td>
      <td>10.000000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>294</td>
      <td>2114</td>
      <td>1</td>
      <td>0</td>
      <td>8</td>
      <td>345</td>
      <td>220</td>
      <td>269</td>
      <td>29</td>
      <td>27</td>
      <td>40.00</td>
      <td>10.0</td>
      <td>10.0</td>
      <td>29</td>
      <td>5</td>
      <td>10.000000</td>
      <td>1</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>408</td>
      <td>2964</td>
      <td>1</td>
      <td>1</td>
      <td>8</td>
      <td>687</td>
      <td>393</td>
      <td>459</td>
      <td>9</td>
      <td>29</td>
      <td>36.00</td>
      <td>7.0</td>
      <td>3.0</td>
      <td>17</td>
      <td>4</td>
      <td>5.142857</td>
      <td>1</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>110</td>
      <td>785</td>
      <td>1</td>
      <td>1</td>
      <td>8</td>
      <td>2968</td>
      <td>590</td>
      <td>631</td>
      <td>2</td>
      <td>74</td>
      <td>161.25</td>
      <td>15.0</td>
      <td>15.0</td>
      <td>19</td>
      <td>11</td>
      <td>5.201613</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>600</td>
      <td>4374</td>
      <td>1</td>
      <td>0</td>
      <td>9</td>
      <td>3423</td>
      <td>689</td>
      <td>722</td>
      <td>5</td>
      <td>47</td>
      <td>106.00</td>
      <td>25.0</td>
      <td>20.0</td>
      <td>31</td>
      <td>7</td>
      <td>17.666667</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th rowspan="6" valign="top">4</th>
      <th>1</th>
      <td>1120</td>
      <td>8306</td>
      <td>0</td>
      <td>1</td>
      <td>8</td>
      <td>711</td>
      <td>323</td>
      <td>371</td>
      <td>14</td>
      <td>22</td>
      <td>46.00</td>
      <td>20.0</td>
      <td>10.0</td>
      <td>30</td>
      <td>3</td>
      <td>11.500000</td>
      <td>1</td>
      <td>20.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>943</td>
      <td>7104</td>
      <td>0</td>
      <td>0</td>
      <td>8</td>
      <td>1122</td>
      <td>296</td>
      <td>380</td>
      <td>20</td>
      <td>18</td>
      <td>25.00</td>
      <td>25.0</td>
      <td>25.0</td>
      <td>37</td>
      <td>5</td>
      <td>25.000000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>274</td>
      <td>1973</td>
      <td>1</td>
      <td>0</td>
      <td>8</td>
      <td>329</td>
      <td>243</td>
      <td>289</td>
      <td>10</td>
      <td>34</td>
      <td>80.00</td>
      <td>10.0</td>
      <td>10.0</td>
      <td>31</td>
      <td>5</td>
      <td>8.000000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>503</td>
      <td>3718</td>
      <td>1</td>
      <td>0</td>
      <td>8</td>
      <td>1050</td>
      <td>538</td>
      <td>618</td>
      <td>2</td>
      <td>21</td>
      <td>30.00</td>
      <td>20.0</td>
      <td>20.0</td>
      <td>34</td>
      <td>2</td>
      <td>15.000000</td>
      <td>1</td>
      <td>20.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1038</td>
      <td>7762</td>
      <td>1</td>
      <td>0</td>
      <td>8</td>
      <td>1714</td>
      <td>955</td>
      <td>944</td>
      <td>0</td>
      <td>25</td>
      <td>29.00</td>
      <td>10.0</td>
      <td>10.0</td>
      <td>31</td>
      <td>1</td>
      <td>7.250000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>1537</td>
      <td>11512</td>
      <td>1</td>
      <td>0</td>
      <td>5</td>
      <td>2014</td>
      <td>526</td>
      <td>566</td>
      <td>3</td>
      <td>50</td>
      <td>79.00</td>
      <td>7.0</td>
      <td>3.0</td>
      <td>32</td>
      <td>5</td>
      <td>5.266667</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>5</th>
      <th>7</th>
      <td>1686</td>
      <td>12698</td>
      <td>1</td>
      <td>0</td>
      <td>8</td>
      <td>930</td>
      <td>592</td>
      <td>632</td>
      <td>2</td>
      <td>26</td>
      <td>33.00</td>
      <td>10.0</td>
      <td>7.0</td>
      <td>31</td>
      <td>3</td>
      <td>6.600000</td>
      <td>0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>
      <button class="colab-df-convert" onclick="convertToInteractive('df-c4867919-3aa4-40e5-84e1-62384ae495b4')"
              title="Convert this dataframe to an interactive table."
              style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
       width="24px">
    <path d="M0 0h24v24H0V0z" fill="none"/>
    <path d="M18.56 5.44l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94zm-11 1L8.5 8.5l.94-2.06 2.06-.94-2.06-.94L8.5 2.5l-.94 2.06-2.06.94zm10 10l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94z"/><path d="M17.41 7.96l-1.37-1.37c-.4-.4-.92-.59-1.43-.59-.52 0-1.04.2-1.43.59L10.3 9.45l-7.72 7.72c-.78.78-.78 2.05 0 2.83L4 21.41c.39.39.9.59 1.41.59.51 0 1.02-.2 1.41-.59l7.78-7.78 2.81-2.81c.8-.78.8-2.07 0-2.86zM5.41 20L4 18.59l7.72-7.72 1.47 1.35L5.41 20z"/>
  </svg>
      </button>



    <div id="df-8f0e2346-39eb-40b6-a7b2-f4741318d748">
      <button class="colab-df-quickchart" onclick="quickchart('df-8f0e2346-39eb-40b6-a7b2-f4741318d748')"
              title="Suggest charts."
              style="display:none;">

<svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
     width="24px">
    <g>
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
    </g>
</svg>
      </button>
    </div>

<style>
  .colab-df-quickchart {
    background-color: #E8F0FE;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: none;
    fill: #1967D2;
    height: 32px;
    padding: 0 0 0 0;
    width: 32px;
  }

  .colab-df-quickchart:hover {
    background-color: #E2EBFA;
    box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
    fill: #174EA6;
  }

  [theme=dark] .colab-df-quickchart {
    background-color: #3B4455;
    fill: #D2E3FC;
  }

  [theme=dark] .colab-df-quickchart:hover {
    background-color: #434B5C;
    box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
    filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
    fill: #FFFFFF;
  }
</style>

    <script>
      async function quickchart(key) {
        const containerElement = document.querySelector('#' + key);
        const charts = await google.colab.kernel.invokeFunction(
            'suggestCharts', [key], {});
      }
    </script>

      <script>

function displayQuickchartButton(domScope) {
  let quickchartButtonEl =
    domScope.querySelector('#df-8f0e2346-39eb-40b6-a7b2-f4741318d748 button.colab-df-quickchart');
  quickchartButtonEl.style.display =
    google.colab.kernel.accessAllowed ? 'block' : 'none';
}

        displayQuickchartButton(document);
      </script>
      <style>
    .colab-df-container {
      display:flex;
      flex-wrap:wrap;
      gap: 12px;
    }

    .colab-df-convert {
      background-color: #E8F0FE;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: none;
      fill: #1967D2;
      height: 32px;
      padding: 0 0 0 0;
      width: 32px;
    }

    .colab-df-convert:hover {
      background-color: #E2EBFA;
      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
      fill: #174EA6;
    }

    [theme=dark] .colab-df-convert {
      background-color: #3B4455;
      fill: #D2E3FC;
    }

    [theme=dark] .colab-df-convert:hover {
      background-color: #434B5C;
      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
      fill: #FFFFFF;
    }
  </style>

      <script>
        const buttonEl =
          document.querySelector('#df-c4867919-3aa4-40e5-84e1-62384ae495b4 button.colab-df-convert');
        buttonEl.style.display =
          google.colab.kernel.accessAllowed ? 'block' : 'none';

        async function convertToInteractive(key) {
          const element = document.querySelector('#df-c4867919-3aa4-40e5-84e1-62384ae495b4');
          const dataTable =
            await google.colab.kernel.invokeFunction('convertToInteractive',
                                                     [key], {});
          if (!dataTable) return;

          const docLinkHtml = 'Like what you see? Visit the ' +
            '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
            + ' to learn more about interactive tables.';
          element.innerHTML = '';
          dataTable['output_type'] = 'display_data';
          await google.colab.output.renderOutput(dataTable, element);
          const docLink = document.createElement('div');
          docLink.innerHTML = docLinkHtml;
          element.appendChild(docLink);
        }
      </script>
    </div>
  </div>





```python
!jupyter nbconvert --to markdown BurkeDanLab3.ipynb
```

    [NbConvertApp] WARNING | pattern 'BurkeDanLab3.ipynb' matched no files
    This application is used to convert notebook files (*.ipynb)
            to various other formats.
    
            WARNING: THE COMMANDLINE INTERFACE MAY CHANGE IN FUTURE RELEASES.
    
    Options
    =======
    The options below are convenience aliases to configurable class-options,
    as listed in the "Equivalent to" description-line of the aliases.
    To see all configurable class-options for some <cmd>, use:
        <cmd> --help-all
    
    --debug
        set log level to logging.DEBUG (maximize logging output)
        Equivalent to: [--Application.log_level=10]
    --show-config
        Show the application's configuration (human-readable format)
        Equivalent to: [--Application.show_config=True]
    --show-config-json
        Show the application's configuration (json format)
        Equivalent to: [--Application.show_config_json=True]
    --generate-config
        generate default config file
        Equivalent to: [--JupyterApp.generate_config=True]
    -y
        Answer yes to any questions instead of prompting.
        Equivalent to: [--JupyterApp.answer_yes=True]
    --execute
        Execute the notebook prior to export.
        Equivalent to: [--ExecutePreprocessor.enabled=True]
    --allow-errors
        Continue notebook execution even if one of the cells throws an error and include the error message in the cell output (the default behaviour is to abort conversion). This flag is only relevant if '--execute' was specified, too.
        Equivalent to: [--ExecutePreprocessor.allow_errors=True]
    --stdin
        read a single notebook file from stdin. Write the resulting notebook with default basename 'notebook.*'
        Equivalent to: [--NbConvertApp.from_stdin=True]
    --stdout
        Write notebook output to stdout instead of files.
        Equivalent to: [--NbConvertApp.writer_class=StdoutWriter]
    --inplace
        Run nbconvert in place, overwriting the existing notebook (only
                relevant when converting to notebook format)
        Equivalent to: [--NbConvertApp.use_output_suffix=False --NbConvertApp.export_format=notebook --FilesWriter.build_directory=]
    --clear-output
        Clear output of current file and save in place,
                overwriting the existing notebook.
        Equivalent to: [--NbConvertApp.use_output_suffix=False --NbConvertApp.export_format=notebook --FilesWriter.build_directory= --ClearOutputPreprocessor.enabled=True]
    --no-prompt
        Exclude input and output prompts from converted document.
        Equivalent to: [--TemplateExporter.exclude_input_prompt=True --TemplateExporter.exclude_output_prompt=True]
    --no-input
        Exclude input cells and output prompts from converted document.
                This mode is ideal for generating code-free reports.
        Equivalent to: [--TemplateExporter.exclude_output_prompt=True --TemplateExporter.exclude_input=True --TemplateExporter.exclude_input_prompt=True]
    --allow-chromium-download
        Whether to allow downloading chromium if no suitable version is found on the system.
        Equivalent to: [--WebPDFExporter.allow_chromium_download=True]
    --disable-chromium-sandbox
        Disable chromium security sandbox when converting to PDF..
        Equivalent to: [--WebPDFExporter.disable_sandbox=True]
    --show-input
        Shows code input. This flag is only useful for dejavu users.
        Equivalent to: [--TemplateExporter.exclude_input=False]
    --embed-images
        Embed the images as base64 dataurls in the output. This flag is only useful for the HTML/WebPDF/Slides exports.
        Equivalent to: [--HTMLExporter.embed_images=True]
    --sanitize-html
        Whether the HTML in Markdown cells and cell outputs should be sanitized..
        Equivalent to: [--HTMLExporter.sanitize_html=True]
    --log-level=<Enum>
        Set the log level by value or name.
        Choices: any of [0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL']
        Default: 30
        Equivalent to: [--Application.log_level]
    --config=<Unicode>
        Full path of a config file.
        Default: ''
        Equivalent to: [--JupyterApp.config_file]
    --to=<Unicode>
        The export format to be used, either one of the built-in formats
                ['asciidoc', 'custom', 'html', 'latex', 'markdown', 'notebook', 'pdf', 'python', 'rst', 'script', 'slides', 'webpdf']
                or a dotted object name that represents the import path for an
                ``Exporter`` class
        Default: ''
        Equivalent to: [--NbConvertApp.export_format]
    --template=<Unicode>
        Name of the template to use
        Default: ''
        Equivalent to: [--TemplateExporter.template_name]
    --template-file=<Unicode>
        Name of the template file to use
        Default: None
        Equivalent to: [--TemplateExporter.template_file]
    --theme=<Unicode>
        Template specific theme(e.g. the name of a JupyterLab CSS theme distributed
        as prebuilt extension for the lab template)
        Default: 'light'
        Equivalent to: [--HTMLExporter.theme]
    --sanitize_html=<Bool>
        Whether the HTML in Markdown cells and cell outputs should be sanitized.This
        should be set to True by nbviewer or similar tools.
        Default: False
        Equivalent to: [--HTMLExporter.sanitize_html]
    --writer=<DottedObjectName>
        Writer class used to write the
                                            results of the conversion
        Default: 'FilesWriter'
        Equivalent to: [--NbConvertApp.writer_class]
    --post=<DottedOrNone>
        PostProcessor class used to write the
                                            results of the conversion
        Default: ''
        Equivalent to: [--NbConvertApp.postprocessor_class]
    --output=<Unicode>
        overwrite base name use for output files.
                    can only be used when converting one notebook at a time.
        Default: ''
        Equivalent to: [--NbConvertApp.output_base]
    --output-dir=<Unicode>
        Directory to write output(s) to. Defaults
                                      to output to the directory of each notebook. To recover
                                      previous default behaviour (outputting to the current
                                      working directory) use . as the flag value.
        Default: ''
        Equivalent to: [--FilesWriter.build_directory]
    --reveal-prefix=<Unicode>
        The URL prefix for reveal.js (version 3.x).
                This defaults to the reveal CDN, but can be any url pointing to a copy
                of reveal.js.
                For speaker notes to work, this must be a relative path to a local
                copy of reveal.js: e.g., "reveal.js".
                If a relative path is given, it must be a subdirectory of the
                current directory (from which the server is run).
                See the usage documentation
                (https://nbconvert.readthedocs.io/en/latest/usage.html#reveal-js-html-slideshow)
                for more details.
        Default: ''
        Equivalent to: [--SlidesExporter.reveal_url_prefix]
    --nbformat=<Enum>
        The nbformat version to write.
                Use this to downgrade notebooks.
        Choices: any of [1, 2, 3, 4]
        Default: 4
        Equivalent to: [--NotebookExporter.nbformat_version]
    
    Examples
    --------
    
        The simplest way to use nbconvert is
    
                > jupyter nbconvert mynotebook.ipynb --to html
    
                Options include ['asciidoc', 'custom', 'html', 'latex', 'markdown', 'notebook', 'pdf', 'python', 'rst', 'script', 'slides', 'webpdf'].
    
                > jupyter nbconvert --to latex mynotebook.ipynb
    
                Both HTML and LaTeX support multiple output templates. LaTeX includes
                'base', 'article' and 'report'.  HTML includes 'basic', 'lab' and
                'classic'. You can specify the flavor of the format used.
    
                > jupyter nbconvert --to html --template lab mynotebook.ipynb
    
                You can also pipe the output to stdout, rather than a file
    
                > jupyter nbconvert mynotebook.ipynb --stdout
    
                PDF is generated via latex
    
                > jupyter nbconvert mynotebook.ipynb --to pdf
    
                You can get (and serve) a Reveal.js-powered slideshow
    
                > jupyter nbconvert myslides.ipynb --to slides --post serve
    
                Multiple notebooks can be given at the command line in a couple of
                different ways:
    
                > jupyter nbconvert notebook*.ipynb
                > jupyter nbconvert notebook1.ipynb notebook2.ipynb
    
                or you can specify the notebooks list in a config file, containing::
    
                    c.NbConvertApp.notebooks = ["my_notebook.ipynb"]
    
                > jupyter nbconvert --config mycfg.py
    
    To see all available configurables, use `--help-all`.
    

