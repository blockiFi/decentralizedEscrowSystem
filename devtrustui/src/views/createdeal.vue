<template>
    <div>
        <section aria-label="section">
                <div class="container">
                      
                    <div class="row wow fadeIn">
                         <div class="col-md-12 text-center">
									<h1>Create A Deal</h1>
                        </div>
                        <div class="col-lg-10 offset-lg-1">
                            <form id="form-create-item" class="form-border" method="post" action="https://www.designesia.com/themes/gigaland/email.php">
                                <div class="field-set">
                                    <h5>Upload file Contract Document</h5>

                                    <div class="d-create-file">
                                        <p id="file_name">PNG, JPG, Pdf.</p>
                                        <input type="button" id="get_file" class="btn-main" value="Browse">
                                        <input type="file" id="upload_file">
                                    </div>

                                    <div class="spacer-single"></div>

                                    <div class="form-group row">
                                        <label class="col-sm-3 col-form-label">Category</label>
                                        <div class="col-sm-9">
                                          <select class="form-control">
                                            <option style="color:black">Category1</option>
                                            <option style="color:black">Category2</option>
                                            <option style="color:black">Category3</option>
                                            <option style="color:black">Category4</option>
                                          </select>
                                        </div>
                                    </div>
                                    <div class="spacer-10"></div>
                                    
                                    <div class="spacer-10"></div>

                                    <h5>Deal Amount (ETH) </h5>
                                    <input type="text" name="item_price" id="item_price" class="form-control" placeholder="Deal Amount (ETH)" />

                                    <div class="spacer-10"></div>

                                    <h5>Deal Time(in Hours)</h5>
                                    <input type="text" name="item_price" id="item_price" class="form-control" placeholder="enter deal time in hours" />

                                    <div class="spacer-10"></div>

                                    <h5>Deal Extension Time</h5>
                                    <input type="text" name="item_price" id="item_price" class="form-control" placeholder="enter deal time in hours" />

                                    <div class="spacer-10"></div>
                                    <h5>Max Extention Count</h5>
                                    <input type="text" name="item_royalties" id="item_royalties" class="form-control" placeholder="Max number of times a deal can be extended" />

                                    <div class="spacer-10"></div>
                                    <h5>Dev/service Provider Address</h5>
                                    <input type="text" name="item_royalties" id="item_royalties" class="form-control" placeholder="Dev/service Provider Address" />

                                    <div class="row"><div class="col-4 offset-4"><input type="button" id="submit" class="btn-main float-right" value="Create Deal"></div></div>
                                </div>
                            </form>
                        </div>
                                      
                    </div>
                </div>
            </section>
    </div>
</template>