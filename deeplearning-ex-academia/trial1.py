import Algorithmia

input = {
  "image": "data://deeplearning/example_data/lincoln.jpg"
}
client = Algorithmia.client('simOXsdp+sUX4PwQDD1rGddkX7v1')
algo = client.algo('deeplearning/ColorfulImageColorization/1.1.13')
print(algo.pipe(input).result)