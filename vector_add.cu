#define N 10000000

__global__ void vector_add(float *out, float *a, float *b, int n) {
    for(int i = 0; i < n; i++){
        out[i] = a[i] + b[i];
    }
}

int main(){
    float *a, *b, *out;
    float *d_a, *d_b;

    a = (float*)malloc(sizeof(float) * N);
    b = (float*)malloc(sizeof(float) * N);

    for(int i = 0; i < N; i++){
        a[i] = 1.0f; b[i] = 2.0f;
    }

    // Allocate device memory for a
    cudaMalloc((void**)&d_a, sizeof(float) * N);
    cudaMalloc((void**)&d_b, sizeof(float) * N);

    // Transfer data from host to device memory
    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);


    vector_add<<<1,1>>>(out, d_a, b, N);


    // Cleanup after kernel execution
    cudaFree(d_a);
    free(a);

    cudaFree(d_b);
    free(b);
}