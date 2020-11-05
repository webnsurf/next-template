import React, { FC } from 'react';
import { Helmet } from 'react-helmet';

const Home: FC = () => (
  <div className="home">
    <Helmet>
      <title>Verslas juda. Darni patirtis – Idėjų mugė verslui</title>
      <link rel="shortcut icon" href="icon-round-small.png" type="image/x-icon" />
    </Helmet>
    Home
  </div>
);

export default Home;
