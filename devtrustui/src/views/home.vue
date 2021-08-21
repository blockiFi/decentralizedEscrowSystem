<template>
   <div>
      <section id="section-hero" aria-label="section" class="text-light overflow-hidden" :style="cssProps">
                <div id="particles-js"></div>
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="text_top">
                                <div class="spacer-double"></div>
                                <h1>Dev Trust Escrow</h1>
                                <p class="lead">A decentralized escrow platform for trustless, secure transactions anywhere across the world.</p>
                                <div class="spacer-20"></div>
                               
                                <a href="dark-login.html" class="btn-main btn-pimary">Create A Deal/Contract</a>
                                <div class="spacer-double"></div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                          <div class="row">
                             <div class="col-6 offset-3">
                                 <img src="@/assets/images/background/home1.png" alt="">
                             </div>
                          </div>
                        </div>
                    </div>                    
                </div>
            </section>
            <section id="section-steps" data-bgcolor="#21273e">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="text-center">
                                <h2>How It Works</h2>
                                <div class="small-border bg-color-2"></div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <i class="wow fadeInUp bg-color-2 i-boxed   icon-documents"></i>
                                <div class="text">
                                    <h4 class="wow fadeInUp">Client Proposes A deal</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">The client in this case is a person who requires a service, or a buyer. He proposes a deal by providing a contract document.</p>
                                </div>
                                <i class="wm icon-documents"></i>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <i class="wow fadeInUp bg-color-2 i-boxed icon_wallet"></i>
                                <div class="text">
                                    <h4 class="wow fadeInUp">Contract Value is Locked</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">During deal creation the contract value is also provided which is locked in the escrow contract</p>
                                </div>
                                <i class="wm icon_wallet"></i>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <i class="wow fadeInUp bg-color-2 i-boxed icon_tags_alt"></i>
                                <div class="text">
                                    <h4 class="wow fadeInUp">Service provider Accepts Deal</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">The service provider is invited to the deal, and is expected to accept or reject the deal.</p>
                                </div>
                                <i class="wm icon_tags_alt"></i>
                            </div>
                        </div>

                    
                    </div>
                    <div  class="row mt-2">
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <div class="text">
                                    <h4 class="wow fadeInUp">Service Provider Deliver</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">The timer starts counting as soon as the service provider accepts the deal. And is expected to provide the service with time frame</p>
                                </div>
                                <i class="wm icon-documents"></i>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <div class="text">
                                    <h4 class="wow fadeInUp">Client Confirms Service</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">After delivery of service the client is expected to confirm service delivery within the extension period, provided by client during deal creation.</p>
                                </div>
                                <i class="wm icon_wallet"></i>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <div class="text">
                                    <h4 class="wow fadeInUp">Dispute</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">The client can dispute the service delivered for a number of times he specified during deal creation, in which the service provider is suppose to redo</p>
                                </div>
                                <i class="wm icon_tags_alt"></i>
                            </div>
                        </div>
                    </div>
                    <div  class="row mt-2">
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <div class="text">
                                    <h4 class="wow fadeInUp">Validators </h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">Validators are invloved after a dispute cant be resolved by both parties. Validators are experts in the field of service, who go over the deal and decides through a vote.</p>
                                </div>
                                <i class="wm icon-documents"></i>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <div class="text">
                                    <h4 class="wow fadeInUp">Settlement</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">Depending on the outcome of the deal processes leading to validation funds are released to either the client or  provider depending on the outcome.</p>
                                </div>
                                <i class="wm icon_wallet"></i>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-sm-30">
                            <div class="feature-box f-boxed style-3">
                                <div class="text">
                                    <h4 class="wow fadeInUp">Excalation</h4>
                                    <p class="wow fadeInUp" data-wow-delay=".25s">This is a case where gorvernance gets involved in case validation wasnt successful dependending on various factors.</p>
                                </div>
                                <i class="wm icon_tags_alt"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
              <section id="section-nfts">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="text-center">
                                <h2>Services Ad  Board</h2>
                                <div class="small-border bg-color-2"></div>
                                 <h6>COMING SOON!!!</h6>
                            </div>
                            
                        </div>
                    </div>
                    
                </div>
            </section>
             <section id="section-collections" data-bgcolor="#21273e">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="text-center">
                                <h2>Devs Ads Board</h2>
                                <div class="small-border bg-color-2"></div>
                                <h6>COMING SOON!!!</h6>
                            </div>
                        </div>
                        
                        </div>
                    </div>
              
            </section>
   </div>
</template>
<script>
export default {
   data() {
      return {
      cssProps: {
          backgroundImage: `url(${require('@/assets/images/background/2d.jpg')})`
        }

      }
   }
}
</script>