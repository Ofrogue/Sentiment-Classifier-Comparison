local embedding_dim = 128;
local hidden_dim = 128;
local num_epochs = 20;
local patience = 5;
local batch_size = 32;
local learning_rate = 1e-4;
local weight_decay = 1e-5;

{
    "train_data_path": 'data/stanfordSentimentTreebank/trees/train.txt',
    "validation_data_path": 'data/stanfordSentimentTreebank/trees/dev.txt',
    "dataset_reader": {
        "type": "sst_tokens"
    },
    "model": {
        "type": "lstm_classifier",
        "word_embeddings": {
            // Technically you could put a "type": "basic" here,
            // but that's the default TextFieldEmbedder, so doing so
            // is optional.
            "token_embedders": {
                "tokens": {
                    "type": "embedding",
                    "embedding_dim": embedding_dim
                }
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
        "batch_size": batch_size,
        "sorting_keys": [["tokens", "num_tokens"]]
    },
    "trainer": {
        "num_epochs": num_epochs,
        "optimizer": {
            "type": "adam",
            "lr": learning_rate,
            "weight_decay":  weight_decay
        },
        "patience": patience
    }
}