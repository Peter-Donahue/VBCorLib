VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cArrayCopyTests"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'
' TestArrayCopy
'
Option Explicit
Implements ICategorizable
Implements ITestCaseSource

Private Sub ICategorizable_Categorize(ByVal Cat As SimplyVBComp.CategoryCollector)
    Cat.ForFixture "System"
End Sub

Private Sub ITestCaseSource_GetTestCases(ByVal Test As SimplyVBComp.TestCaseCollector)
    Dim Objects(0 To 2) As Int32
    Set Objects(0) = New Int32
    Set Objects(1) = New Int32
    Set Objects(2) = New Int32
    
    Select Case Test.MethodName
        Case "Copy_WithValues_CopiesWithConversion"
            Test.Use NewBytes(1, 2, 3), NewBytes(0, 0, 0), NewBytes(1, 2, 3)
            Test.Use NewBytes(1, 2, 3), NewIntegers(0, 0, 0), NewIntegers(1, 2, 3)
            Test.Use NewBytes(1, 2, 3), NewLongs(0, 0, 0), NewLongs(1, 2, 3)
            Test.Use NewBytes(1, 2, 3), NewSingles(0, 0, 0), NewSingles(1, 2, 3)
            Test.Use NewBytes(1, 2, 3), NewDoubles(0, 0, 0), NewDoubles(1, 2, 3)
            Test.Use NewBytes(1, 2, 3), NewCurrencys(0, 0, 0), NewCurrencys(1, 2, 3)
            Test.Use NewBytes(1, 2, 3), NewStrings("", "", ""), NewStrings("1", "2", "3")
            Test.Use NewBytes(1, 2, 3), NewVariants(0, 0, 0), NewVariants(CByte(1), CByte(2), CByte(3))
            
            Test.Use NewIntegers(1, 2, 3), NewIntegers(0, 0, 0), NewIntegers(1, 2, 3)
            Test.Use NewIntegers(1, 2, 3), NewLongs(0, 0, 0), NewLongs(1, 2, 3)
            Test.Use NewIntegers(1, 2, 3), NewSingles(0, 0, 0), NewSingles(1, 2, 3)
            Test.Use NewIntegers(1, 2, 3), NewDoubles(0, 0, 0), NewDoubles(1, 2, 3)
            Test.Use NewIntegers(1, 2, 3), NewCurrencys(0, 0, 0), NewCurrencys(1, 2, 3)
            Test.Use NewIntegers(1, 2, 3), NewStrings("", "", ""), NewStrings("1", "2", "3")
            Test.Use NewIntegers(1, 2, 3), NewVariants(0, 0, 0), NewVariants(1, 2, 3)
            
            Test.Use NewLongs(1, 2, 3), NewLongs(0, 0, 0), NewLongs(1, 2, 3)
            Test.Use NewLongs(1, 2, 3), NewSingles(0, 0, 0), NewSingles(1, 2, 3)
            Test.Use NewLongs(1, 2, 3), NewDoubles(0, 0, 0), NewDoubles(1, 2, 3)
            Test.Use NewLongs(1, 2, 3), NewCurrencys(0, 0, 0), NewCurrencys(1, 2, 3)
            Test.Use NewLongs(1, 2, 3), NewStrings("", "", ""), NewStrings("1", "2", "3")
            Test.Use NewLongs(1, 2, 3), NewVariants(0, 0, 0), NewVariants(1&, 2&, 3&)
            
            Test.Use NewSingles(1, 2, 3), NewSingles(0, 0, 0), NewSingles(1, 2, 3)
            Test.Use NewSingles(1, 2, 3), NewDoubles(0, 0, 0), NewDoubles(1, 2, 3)
            Test.Use NewSingles(1, 2, 3), NewStrings("", "", ""), NewStrings("1", "2", "3")
            Test.Use NewSingles(1, 2, 3), NewVariants(0, 0, 0), NewVariants(1!, 2!, 3!)
            
            Test.Use NewDoubles(1, 2, 3), NewDoubles(0, 0, 0), NewDoubles(1, 2, 3)
            Test.Use NewDoubles(1, 2, 3), NewStrings("", "", ""), NewStrings("1", "2", "3")
            Test.Use NewDoubles(1, 2, 3), NewVariants(0, 0, 0), NewVariants(1#, 2#, 3#)
            
            Test.Use NewCurrencys(1, 2, 3), NewCurrencys(0, 0, 0), NewCurrencys(1, 2, 3)
            Test.Use NewCurrencys(1, 2, 3), NewStrings("", "", ""), NewStrings("1", "2", "3")
            Test.Use NewCurrencys(1, 2, 3), NewVariants(0, 0, 0), NewVariants(1@, 2@, 3@)
            Test.Use NewCurrencys(1, 2, 3), NewDoubles(0, 0, 0), NewDoubles(1, 2, 3)
            
            Test.Use Objects, Array(Nothing, Nothing, Nothing), Objects
            
        Case "CopyEx_WithValues_CopiesWithConversion"
            Test.Use NewLongs(1, 2, 3), NewLongs(0, 0, 0), NewLongs(0, 1, 2)
            Test.Use NewStrings("1", "2", "3"), NewStrings("", "", ""), NewStrings("", "1", "2")
            Test.Use Objects, Objects, Array(Objects(0), Objects(0), Objects(1))
            
            Dim Comparables(0 To 2) As IComparable
            Test.Use Objects, Comparables, Array(Nothing, Objects(0), Objects(1))
            
        Case "Copy_WithIncompatibleTypes_ThrowsArrayTypeMismatchException"
            Test.Use NewLongs(0), NewIntegers(0)
            Test.Use NewDoubles(0), NewLongs(0)
            
            Dim SrcInt32(0) As Int32
            Dim DstInt32F(0) As Int32Formattable
            Set SrcInt32(0) = New Int32
            Set DstInt32F(0) = New Int32Formattable
            Test.Use SrcInt32, DstInt32F
    End Select
End Sub

Public Sub Copy_WithValues_CopiesWithConversion(ByRef Source As Variant, ByRef Destination As Variant, ByRef Expected As Variant)
    cArray.Copy Source, Destination, 3
    
    Assert.That Destination, Iz.EqualTo(Expected).Strict
End Sub

Public Sub Copy_WithIncompatibleTypes_ThrowsArrayTypeMismatchException(ByRef Source As Variant, ByRef Destination As Variant)
    On Error GoTo errTrap
    
    cArray.Copy Source, Destination, 1
    
errTrap:
    AssertArrayTypeMismatchException Err
End Sub

Public Sub CopyEx_WithValues_CopiesWithConversion(ByRef Source As Variant, ByRef Destination As Variant, ByRef Expected As Variant)
    cArray.CopyEx Source, 0, Destination, 1, 2
    
    Assert.That Destination, Iz.EqualTo(Expected).Strict
End Sub

Public Sub Copy_WithUDT_CopiesElements()
    Dim SourceUDTs(0 To 2) As VBCorType.VBGUID
    SourceUDTs(0).Data1 = 1
    SourceUDTs(1).Data1 = 2
    SourceUDTs(2).Data1 = 3
    Dim TargetUDTs(0 To 2) As VBCorType.VBGUID

    cArray.Copy SourceUDTs, TargetUDTs, 3
    
    Assert.That TargetUDTs(0).Data1, Iz.EqualTo(1)
    Assert.That TargetUDTs(1).Data1, Iz.EqualTo(2)
    Assert.That TargetUDTs(2).Data1, Iz.EqualTo(3)
End Sub

Public Sub Copy_WithNegativeLength_Throws()
    On Error GoTo errTrap
    Dim Arr(0) As Long
    
    cArray.Copy Arr, Arr, -1
    
errTrap:
    AssertArgumentOutOfRangeException Err, "Length"
End Sub

Public Sub Copy_WithLengthGreaterThanSourceLength_ThrowsArgumentException()
    On Error GoTo errTrap
    Dim Arr1(0) As Long
    Dim Arr2(2) As Long
    
    cArray.Copy Arr1, Arr2, 2
    
errTrap:
    AssertArgumentException Err
End Sub

Public Sub Copy_WithLengthGreaterThanDestinationLength_ThrowsArgumentException()
    On Error GoTo errTrap
    Dim Arr1(0) As Long
    Dim Arr2(2) As Long
    
    cArray.Copy Arr2, Arr1, 2
    
errTrap:
    AssertArgumentException Err
End Sub

Public Sub CopyEx_WithLengthPlusStartIndexGreaterThanSourceLength_ThrowsArgumentException()
    On Error GoTo errTrap
    Dim Arr1(1) As Long
    Dim Arr2(2) As Long
    
    cArray.CopyEx Arr1, 1, Arr2, 0, 2
    
errTrap:
    AssertArgumentException Err
End Sub

Public Sub CopyEx_WithLengthPlusDestinationIndexGreaterThanDestinationLength_ThrowsArgumentException()
    On Error GoTo errTrap
    Dim Arr1(1) As Long
    Dim Arr2(2) As Long
    
    cArray.CopyEx Arr2, 0, Arr1, 1, 2
    
errTrap:
    AssertArgumentException Err
End Sub

Public Sub CopyEx_WithSourceIndexLessThanLBound_ThrowsArgumentOutOfRangeException()
    On Error GoTo errTrap
    Dim Arr1(1 To 1) As Long
    Dim Arr2(1 To 1) As Long
    
    cArray.CopyEx Arr1, 0, Arr2, 1, 1
    
errTrap:
    AssertArgumentOutOfRangeException Err, "SourceIndex"
End Sub

Public Sub CopyEx_WithDestinationIndexLessThanLBound_ThrowsArgumentOutOfRangeException()
    On Error GoTo errTrap
    Dim Arr1(1 To 1) As Long
    Dim Arr2(1 To 1) As Long
    
    cArray.CopyEx Arr1, 1, Arr2, 0, 1
    
errTrap:
    AssertArgumentOutOfRangeException Err, "DestinationIndex"
End Sub

Public Sub Copy_WithNullSource_ThrowsArgumentNull()
    On Error GoTo errTrap
    Dim NullArray() As Long
    Dim NonNull(0) As Long
    
    cArray.Copy NullArray, NonNull, 1
    
errTrap:
    AssertArgumentNullException Err, "SourceArray"
End Sub

Public Sub Copy_WithNullDestination_ThrowsArgumentNullException()
    On Error GoTo errTrap
    Dim NullArray() As Long
    Dim NonNull(0) As Long
    
    cArray.Copy NonNull, NullArray, 1
    
errTrap:
    AssertArgumentNullException Err, "DestinationArray"
End Sub

Public Sub CopyEx_WithNegativeLength_ThrowsArgumentOutOfRangeException()
    On Error GoTo errTrap
    Dim Arr(0) As Long
    
    cArray.CopyEx Arr, 0, Arr, 0, -1
    
errTrap:
    AssertArgumentOutOfRangeException Err, "Length"
End Sub

Public Sub CopyEx_WithNullSource_ThrowsArgumentNullException()
    On Error GoTo errTrap
    Dim NullArray() As Long
    Dim NonNull(0) As Long
    
    cArray.CopyEx NullArray, 0, NonNull, 0, 1
    
errTrap:
    AssertArgumentNullException Err, "SourceArray"
End Sub

Public Sub CopyEx_WithNullDestination_ThrowsArgumentNullException()
    On Error GoTo errTrap
    Dim NullArray() As Long
    Dim NonNull(0) As Long
    
    cArray.CopyEx NonNull, 0, NullArray, 0, 1
    
errTrap:
    AssertArgumentNullException Err, "DestinationArray"
End Sub

Public Sub Copy_WithLongs_CopiesAllElements()
    Dim Source() As Long
    Dim Target() As Long
    Source = NewLongs(1, 2, 3, 4, 5)
    ReDim Target(0 To 4)
    
    cArray.Copy Source, Target, 5
    
    Assert.That Target, Iz.EqualTo(Source)
End Sub

Public Sub Copy_WithStrings_CopiesAllElements()
    Dim Source() As String
    Dim Target() As String
    Source = NewStrings("1", "2", "3", "4", "5")
    ReDim Target(0 To 4)
    
    cArray.Copy Source, Target, 5
    
    Assert.That Target, Iz.EqualTo(Source)
End Sub

Public Sub Copy_WithCountLessThanArrayLength_CopiesSpecifiedNumberOfElements()
    Dim Source() As Long
    Dim Target() As Long
    Source = NewLongs(1, 2, 3, 4, 5)
    ReDim Target(0 To 4)
    
    cArray.Copy Source, Target, 3
    
    Dim Expected() As Long
    Expected = NewLongs(1, 2, 3, 0, 0)
    Assert.That Target, Iz.EqualTo(Expected)
End Sub

Public Sub Copy_WithUnalignedLBounds_CopiesElements()
    Dim Source() As Long
    Dim Target() As Long
    Source = NewLongs(1, 2, 3, 4, 5)
    ReDim Target(5 To 9)
    
    cArray.Copy Source, Target, 5
    
    Dim Expected(5 To 9) As Long
    Expected(5) = 1
    Expected(6) = 2
    Expected(7) = 3
    Expected(8) = 4
    Expected(9) = 5
    Assert.That Target, Iz.EqualTo(Expected)
End Sub

Public Sub Copy_WithCallback_CopiesElementsUsingCallback()
    Dim Source() As String
    Dim Target() As String
    Source = NewStrings("11", "22", "33")
    ReDim Target(0 To 2)
    
    cArray.Copy Source, Target, 3, AddressOf modTestCallbacks.FirstLetterCopier
    
    Dim Expected() As String
    Expected = NewStrings("1", "2", "3")
    Assert.That Target, Iz.EqualTo(Expected)
End Sub

Public Sub Copy_ToSelfUsingCallback_CopiesElementsUsingCallback()
    Dim Source() As String
    Source = NewStrings("11", "22", "33")
    
    cArray.Copy Source, Source, 3, AddressOf modTestCallbacks.FirstLetterCopier
    
    Dim Expected() As String
    Expected = NewStrings("1", "2", "3")
    Assert.That Source, Iz.EqualTo(Expected)
End Sub

Public Sub Copy_WithMultiDimensionalArrays_CopiesElements()
    Dim Source(0 To 2, 0 To 2) As Long
    Dim Target(0 To 2, 0 To 2) As Long
    Source(0, 0) = 1
    Source(1, 1) = 2
    Source(2, 2) = 3

    cArray.Copy Source, Target, 9

    Assert.That Target, Iz.EqualTo(Source)
End Sub

Public Sub CopyEx_WithLongsSubSet_CopiesSubSet()
    Dim Source() As Long
    Dim Target() As Long
    Source = NewLongs(1, 2, 3, 4, 5, 6, 7, 8)
    Target = NewLongs(0, 0, 0, 0, 0, 0, 0, 0)
    
    cArray.CopyEx Source, 2, Target, 0, 4
    
    Dim Expected() As Long
    Expected = NewLongs(3, 4, 5, 6, 0, 0, 0, 0)
    Assert.That Target, Iz.EqualTo(Expected)
End Sub

Public Sub Copy_WithObjects_CopiesElements()
    Dim Source(1) As Int32
    Dim Target(1) As Int32
    Set Source(0) = New Int32
    Set Source(1) = New Int32
    
    cArray.Copy Source, Target, 2
    
    Assert.That Target, Iz.EqualTo(Source)
End Sub

Public Sub CopyEx_WithObjects_CopiesElements()
    Dim Source(0 To 1) As Int32
    Dim Target(1 To 2) As Int32
    Set Source(0) = New Int32
    Set Source(1) = New Int32
    
    cArray.CopyEx Source, 1, Target, 2, 1
    
    Assert.That Target(1), Iz.Nothing
    Assert.That Target(2), Iz.SameAs(Source(1))
End Sub

Public Sub CopyEx_WithObjectsToSameArray_CopiesElements()
    Dim Item1 As New Int32
    Dim Item2 As New Int32
    Dim Item3 As New Int32
    Dim Actual(0 To 3) As Int32
    Set Actual(0) = Item1
    Set Actual(1) = Item2
    Set Actual(2) = Item3
    Set Actual(3) = New Int32
    
    cArray.CopyEx Actual, 0, Actual, 1, 3
    
    Dim Expected(0 To 3) As Int32
    Set Expected(0) = Item1
    Set Expected(1) = Item1
    Set Expected(2) = Item2
    Set Expected(3) = Item3
    Assert.That Actual, Iz.EqualTo(Expected)
End Sub

Public Sub Copy_WithLongsToStrings_ConvertsElements()
    Dim Source() As Long
    Dim Target() As String
    Source = NewLongs(1, 2, 3)
    ReDim Target(2)
    
    cArray.Copy Source, Target, 3
    
    Dim Expected() As String
    Expected = NewStrings("1", "2", "3")
    Assert.That Target, Iz.EqualTo(Expected)
End Sub

Public Sub Copy_WithVariantsToObjects_ConvertsElements()
    Dim Source As Variant
    Dim Target() As Int32
    Source = Array(New Int32, New Int32, New Int32)
    ReDim Target(2)
    
    cArray.Copy Source, Target, 3
    
    Assert.That Target, Iz.EqualTo(Source)
End Sub

