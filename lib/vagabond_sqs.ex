defmodule VagabondSqs do

  def process do
    queue = Application.get_env(:vagabond_sqs, :test_queue)

    get_payload(queue)
    |> get_payload_body
    |> get_message
  end

  def get_payload(queue) do
    queue
    |> ExAws.SQS.receive_message
    |> ExAws.request!
  end

  def get_payload_body(%{body: %{messages: [message]}}) do
    Poison.decode!(message.body)
  end

  def get_message(%{"Message" => message}) do
    Poison.decode!(message)
  end

end
