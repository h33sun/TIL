## Introduction to Machine Learning with Python
- OREILLY 의 Introduction to Machine Learning with Python 학습

<img src = 'http://image.yes24.com/goods/74398065/800x0' width = '40%'></img>


- ### 1. 지도학습
   - #### KNN
    - 가장 간단하고 학습이 필요 없는 알고리즘
    - 거리를 재는 방법(기본적으로 유클리디안), 이웃의 수(3-5정도로 적을 때 잘 작동한다) 가 중요하다.
    - #### 장점과 단점
      - 간단하다.
      - 특성 혹은 샘플의 수가 크면 속도가 느려진다.
      - 많은 특성을 가진 데이터와 희소 case를 갖는 데이터셋에서 성능이 떨어진다.

   - #### 선형 모델
      - 회귀 선형 모델은 $\hat{y} = w[0]x[0] + b$의 형식


   - 모델은 feature가 하나일 때는 직선, 둘일 때는 평면, 그 이상은 초 평면이 된다.


   - KNN 회귀와 비교했을 때, 선형 모델은 데이터의 상세 정보를 잃은 것 처럼 보이며 (사실이다)
   
       - Y가 X의 선형 조합이라는 것은 사실 비현실적이고 과한 가정이다.
       
       - 그러나 특성의 개수가 많아질 수록 선형 모델은 훌륭한 성능을 나타내며
           - FEATURE > DATA (부정방정식)의 경우 어떤 Y도 선형 함수로 모델링할 수 있다.
       
       - 1. 최소자승법 (OLS)
          - 실제 Y와 모델의 예측 간의 평균 제곱 오차를 최소화하는 파라미터를 찾는다.
          - 매개 변수가 없는 장점을 갖지만, 모델의 복잡도를 제어할 방법이 없다.
          
      - 2. 라쏘 (Lasso : L1)
         - $w = \text{arg}\min_w \left( \sum_{i=1}^N e_i^2 + \lambda \sum_{j=1}^M | w_j | \right)$
         - 릿지와 달리 계수의 절대값 합을 최소화한다.
         - 즉, 어떤 계수는 정말로 0 이 되기 때문에 feature selection이 자동으로 진행된다고 할 수 있다.
        
      - 3. 릿지 (Ridge : L2)
    
         - $w = \text{arg}\min_w \left( \sum_{i=1}^N e_i^2 + \lambda \sum_{j=1}^M w_j^2 \right)$
         - 제곱합의 최소화를 통해 여러 계수가 점진적으로 0을 향해 줄어든다.
        
      - 4. 엘라스틱넷 (ElasticNet)
    
         - $w = \text{arg}\min_w \left( \sum_{i=1}^N e_i^2 + \lambda_1 \sum_{j=1}^M | w_j | + \lambda_2 \sum_{j=1}^M w_j^2 \right)$ 
         - L1과 L2의 조합으로 최상의 성능을 낸지만 alpha 뿐 아니라 L1 RATIO를 조정해야 한다.
         - 결국 alpha와 L1의 비율을 통해 정규화를 진행함
         - L1은 초기에 W의 계수를 0으로 만드는 경향이 있고 L2는 모든 계수를 서서히 0으로 줄여감
