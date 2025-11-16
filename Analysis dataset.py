#!/usr/bin/env python
# coding: utf-8

# In[3]:


import pandas as pd
import numpy as np


# In[4]:


import pandas as pd
df = pd.read_csv('super store2.csv')


# In[4]:


print(df)


# In[4]:


print(df.shape)


# In[5]:


print(df.isnull().sum())


# In[6]:


print(df['Invoice ID'].duplicated().sum())


# In[5]:


print(df.head())
print(df.info())
print(df.describe())


# In[8]:


print(df['Unit price']. multiply(df['Quantity']).sum())


# In[9]:


df['total_revenue'] = df['Unit price'] * df['Quantity']
grouped_revenue = df.groupby('Product line')['total_revenue'].sum()
print(df)


# In[10]:


df['total_revenue'] = df['Unit price'] * df['Quantity']
print(df)


# In[11]:


city_revenue = df.groupby('City')['total_revenue'].sum().reset_index()
print(city_revenue)


# In[12]:


print(df['Customer type'].value_counts())


# In[13]:


df['total revenue'] = df['Unit price'] * df['Quantity']
print(df)


# In[14]:


customer_revenue = df.groupby('Customer type')['total revenue'].sum().reset_index()
print(customer_revenue)


# In[15]:


print(df['Product line'].value_counts())


# In[16]:


print(df.groupby('Product line')['Unit price'].mean())


# In[17]:


print(df['gross income'].sum())


# In[18]:


print(df.groupby('Product line')['gross income'].sum())


# In[1]:


import pandas as pd
import matplotlib.pyplot as plt


# In[13]:


df['Unit price'] = pd.to_numeric(df['Unit price'], errors='coerce')
df['Quantity'] = pd.to_numeric(df['Quantity'], errors='coerce')


# In[8]:


df['total revenue'] = df['Unit price'] * df['Quantity']
print(df)


# In[9]:


df['Date'] = pd.to_datetime(df['Date'])
daily_revenue = df.groupby('Date')['total revenue'].sum().reset_index()
print(daily_revenue)


# In[16]:


plt.figure(figsize=(10,6))
plt.plot(daily_revenue['Date'], daily_revenue['total revenue'])
plt.title('Daily total revenue')
plt.xlabel('Date')
plt.ylabel('total revenue')
plt.xticks(rotation=45)
plt.show()


# In[ ]:




