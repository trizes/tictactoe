class Api::V1::GamesSerializer < Panko::Serializer
  attributes :id, :board, :status
end
