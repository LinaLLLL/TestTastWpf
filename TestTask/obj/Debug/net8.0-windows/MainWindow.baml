   M S B A M L   `   `   `  ����C  ?TestTask, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:TestTaskTestTask  5   	   9!clr-namespace:TestTask.ViewModelsTestTask.ViewModels  5   	       TestTask.MainWindow   5   	   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   (localclr-namespace:TestTask     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   8
viewmodels!clr-namespace:TestTask.ViewModels     5   	     � Title$  Image Downloader��5   	   $	��520��6"   $	��800��6/   
����ح� � DataContext 5      '   !TestTask.ViewModels.MainViewModel  5   
    � 	Resources 5          BooleanToVisibilityConverter��%   &	        �� 5   
   6'   5      .��5      � $��10q�6    � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $��* �6   �� 5      $
��Auto �6   .+�5   
   ��  �� Orientation$ 
Horizontal=�6   $��Center=�6.   $��0��6K   $��0,0,0,10q�6X   .+�5      �� $��Загрузить все��6   $	��120��6Q   $��5q�6]   ��6-   �� *StartAllCommand+6]   �� 5      $!��Остановить все��6   $	��120��6Q   $��5q�6]   ��6.   �� *StopAllCommand+6]   5      �� 5    
   $��1��6:   ��6   �� *
ImageSlots+��5!      �� 5"      .R�5#      �� $ 
Horizontal=�6!   $��Center=�6:   5$      ��5&      �� 5'       �� DataType,   &TestTask.ViewModels.ImageSlotViewModel"  6   .R�5(      �� 
�������$��1q�60    �� Padding$ 10q�6D   $��5q�6Q   $	��230��6\   ._�5)      �� .+�5*      �� $	��200��6=   $	��150��6I   $��Uniform=�6V   $2��,0,0,0,10                                    q�6h   ��6$   �� *Image+6h   �� 5,      $��Введите URL��6(   
�������$��5,2,0,5q�6M    J� IsHitTestVisible$ False��6^   y�5-   (   �� *Text.IsEmpty+ �� RelativeSource �� 	 �� Mode$	 FindAncestor=�
 �� AncestorType
 TextBox �� 	Converter# [  �� 51      $	��200��52   !   $��0,0,0,20q�6-   ��51   &   �� *Url+ �� UpdateSourceTrigger$ PropertyChanged=�52   -   �� 54      $'��!Прогресс загрузки��6(   
�������$��5,2,0,5q�6S   $ False��6d   y�55   (   �� *Text.IsEmpty+ �� $	 FindAncestor=�
 TextBox# [  � 59       � Minimum$ 0Q�6*    � Maximum$	 100Q�66   $��20��6_   $��0,0,0,20q�6k    � Value 6D   �� *
Progress+6k   �� 5;      $ 
Horizontal=�6)   $��Center=�6B   .+�5<   "   �� $��
Старт��6)   $��70��6Z   $��5q�6e   ��69   �� *StartCommand+6e   �� 5=   "   $��Стоп��6)   $��70��6X   $��5q�6c   ��68   �� *StopCommand+6c   5>      5?      5@      5A      5C      �� 5D   
   $��2��6   $��0,10,0,0q�6"   .+�5E      �� $2��,Общий прогресс загрузки��6   $
��Bold"�67   $��14(�6I   
���OO/�$��Center=�5F      $��0,0,0,5q�65   � 5G      $��2��6   $ 0Q�6'   $	 100Q�63   $��25��6c   $��0,10,0,0q�6o    6A   �� *OverallProgress+6o   5H      5I      5J      