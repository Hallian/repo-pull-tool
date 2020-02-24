Describe "curl utils"
  Include lib/curl-utils.sh

  Describe "getBody()"
    It "should work with line feed"
      When call getBody "$(echo -e "Headers\n\nBody data\nMore body data")"
      The output should eq "Body data
More body data"
    End

    It "should work with CRLF"
      When call getBody "$(echo -e "Headers\r\n\r\nBody data\r\nMore body data")"
      The output should eq "Body data
More body data"
    End
  End

  Describe "getHeaders()"
    It "should work with line feed"
      When call getHeaders "$(echo -e "Header data\nOther header\n\nBody data\nMore body data")"
      The output should eq "Header data
Other header"
    End

    It "should work with CRLF"
      When call getHeaders "$(echo -e "Header data\r\nOther header\r\n\r\nBody data\r\nMore body data")"
      The output should eq "Header data
Other header"
    End
  End
End
