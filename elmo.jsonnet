local embedding_dim = 256;
local hidden_dim = 128;

{
  "dataset_reader": {
    "type": "sst_tokens",
    "token_indexers": {
      "tokens": {
        "type": "elmo_characters"
      }
    }
  },
  "train_data_path": "data/stanfordSentimentTreebank/trees/train.txt",
  "validation_data_path": "data/stanfordSentimentTreebank/trees/dev.txt",

  "model": {
    "type": "lstm_classifier",

    "word_embeddings": {
      "tokens": {
        "type": "elmo_token_embedder",
        "options_file": "https://s3-us-west-2.amazonaws.com/allennlp/models/elmo/2x1024_128_2048cnn_1xhighway/elmo_2x1024_128_2048cnn_1xhighway_options.json",
        "weight_file": "https://s3-us-west-2.amazonaws.com/allennlp/models/elmo/2x1024_128_2048cnn_1xhighway/elmo_2x1024_128_2048cnn_1xhighway_weights.hdf5",
        "do_layer_norm": false,
        "dropout": 0.5
      }
    },

    "encoder": {
      "type": "lstm",
      "input_size": embedding_dim,
      "hidden_size": hidden_dim
    }
  },
  "iterator": {
    "type": "bucket",
    "batch_size": 32,
    "sorting_keys": [["tokens", "num_tokens"]]
  },
  "trainer": {
    "optimizer": "adam",
    "num_epochs": 20,
    "patience": 5
  }
}