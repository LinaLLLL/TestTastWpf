   M S B A M L   `   `   `  ���� C  ?TestTask, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:TestTaskTestTask  9!clr-namespace:TestTask.ViewModelsTestTask.ViewModels      TestTask.MainWindow   W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     (localclr-namespace:TestTask     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     8
viewmodels!clr-namespace:TestTask.ViewModels       � Title$  Image Downloader��$	��520��$	��800��
����ح� � DataContext '   !TestTask.ViewModels.MainViewModel   � 	Resources     BooleanToVisibilityConverter��%   &	        �� .��� $��10q� � RowDefinitions �� $
��Auto ��� $��* ��� $
��Auto �.+���  �� Orientation$ 
Horizontal=�$��Center=�$��0��$��0,0,0,10q�.+��� $��Загрузить все��$	��120��$��5q����� *StartAllCommand+�� $!��Остановить все��$	��120��$��5q����� *StopAllCommand+�� $��1������ *
ImageSlots+���� .R��� $ 
Horizontal=�$��Center=�����  �� DataType,   &TestTask.ViewModels.ImageSlotViewModel"  .R��� 
�������$��1q� �� Padding$ 10q�$��5q�$	��230��._��� .+��� $	��200��$	��150��$��Uniform=�$2��,0,0,0,10                                    q����� *Image+�� $��Введите URL��
�������$��5,2,0,5q� J� IsHitTestVisible$ False��y��� *Text.IsEmpty+ �� RelativeSource �� 	 �� Mode$	 FindAncestor=�
 �� AncestorType
 TextBox �� 	Converter# [  �� $	��200��$��0,0,0,20q����� *Url+ �� UpdateSourceTrigger$ PropertyChanged=��� $'��!Прогресс загрузки��
�������$��5,2,0,5q�$ False��y��� *Text.IsEmpty+ �� $	 FindAncestor=�
 TextBox# [  �  � Minimum$ 0Q� � Maximum$	 100Q�$��20��$��0,0,0,20q� � Value �� *
Progress+�� $ 
Horizontal=�$��Center=�.+��� $��
Старт��$��70��$��5q����� *StartCommand+�� $��Стоп��$��70��$��5q����� *StopCommand+�� $��2��$��0,10,0,0q�.+��� $2��,Общий прогресс загрузки��$
��Bold"�$��14(�
���OO/�$��Center=�$��0,0,0,5q�� $��2��$ 0Q�$	 100Q�$��25��$��0,10,0,0q� �� *OverallProgress+