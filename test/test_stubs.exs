defmodule TestStubs do

  def session_request_valid do
    %{
      type: "transaction",
      id: "1",
      attributes: %{
        transactionDate: "2021/02/24 08:54:10",
        consumerId: "CPF",
        accessToken: "12121211",
        clientIp: "127.0.0.1",
        clientId: "CPF"
      }
    }
  end


end