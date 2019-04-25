local embedding_dim = 768;
local hidden_dim = 128;

{
  "dataset_reader": {
    "type": "sst_tokens",
    "token_indexers": {
      "bert": {
        "type": "bert-pretrained",
        "pretrained_model": "bert-base-uncased"
        }
      }
  },
  
  "train_data_path": "data/stanfordSentimentTreebank/trees/train.txt",
  "validation_data_path": "data/stanfordSentimentTreebank/trees/dev.txt",

  "model": {
    "type": "lstm_classifier",

    "word_embeddings": {
      "allow_unmatched_keys": true,
      "bert": {
        "type": "bert-pretrained",
        "pretrained_model": "bert-base-uncased",
        "top_layer_only": true
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