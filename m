Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCACD76FF04
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Aug 2023 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHDKwu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Aug 2023 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHDKw1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Aug 2023 06:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907184ECA;
        Fri,  4 Aug 2023 03:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149C661FAE;
        Fri,  4 Aug 2023 10:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5677BC433C8;
        Fri,  4 Aug 2023 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691146184;
        bh=6wEAhsdKD605Kpg3pmFf+yAduxBEJdnh1zQ9VC2lH+Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=HWD3/zqYL2D+G4Je/OVGF4ZX0qepzRs8cAalGTgD/1M3gd1oON28OHJ+cEk2gjdmR
         d5pl63TF1E4YPNAhLXq58AJL4ZUsKdmoJhLMDnXA+p2G+I9Gf6+R5B6EQszD9XA9/1
         b+cwGTNyrcoSkrLmKllZoF+ThD0t2sO4gtkecfF63NTCeVKKpOdjixNjbAsZnlWo5p
         b9f00O44jqmbczxwg6818cY+ZG9a4ixjGXwazv2gZ8ArbYcHUgSEyAD9kuwLHtO66A
         r7yzjcp9sE6yoaXGzfehBQl712NJVBCgRKkM7LFDLDekMkU1/ur6AUmMItCQdsUuuT
         Gw+sHFTOuKQ+w==
Message-ID: <7d159ee4-7361-c04a-681e-1afc74765c5b@kernel.org>
Date:   Fri, 4 Aug 2023 12:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
        ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
        hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH V5,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
References: <1690999650-9557-1-git-send-email-haiyangz@microsoft.com>
 <e1093991-6f54-2c8d-c713-babac0d216d4@intel.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <e1093991-6f54-2c8d-c713-babac0d216d4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 03/08/2023 03.44, Jesse Brandeburg wrote:
> On 8/2/2023 11:07 AM, Haiyang Zhang wrote:
>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>> usage.
>>

Can you add some info on the performance improvement this patch gives?

Your previous post mentioned:
 > With iperf and 128 threads test, this patch improved the throughput 
by 12-15%, and decreased the IRQ associated CPU's usage from 99-100% to 
10-50%.


>> The standard page pool API is used.
>>
>> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>> ---
>> V5:
>> In err path, set page_pool_put_full_page(..., false) as suggested by
>> Jakub Kicinski
>> V4:
>> Add nid setting, remove page_pool_nid_changed(), as suggested by
>> Jesper Dangaard Brouer
>> V3:
>> Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
>> V2:
>> Use the standard page pool API as suggested by Jesper Dangaard Brouer
>> ---
> 
>> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
>> index 024ad8ddb27e..b12859511839 100644
>> --- a/include/net/mana/mana.h
>> +++ b/include/net/mana/mana.h
>> @@ -280,6 +280,7 @@ struct mana_recv_buf_oob {
>>   	struct gdma_wqe_request wqe_req;
>>   
>>   	void *buf_va;
>> +	bool from_pool; /* allocated from a page pool */
> 
> suggest you use flags and not bools, as bools waste 7 bits each, plus
> your packing of this struct will be full of holes, made worse by this
> patch. (see pahole tool)
> 

Agreed.

> 
>>   
>>   	/* SGL of the buffer going to be sent has part of the work request. */
>>   	u32 num_sge;
>> @@ -330,6 +331,8 @@ struct mana_rxq {
>>   	bool xdp_flush;
>>   	int xdp_rc; /* XDP redirect return code */
>>   
>> +	struct page_pool *page_pool;
>> +
>>   	/* MUST BE THE LAST MEMBER:
>>   	 * Each receive buffer has an associated mana_recv_buf_oob.
>>   	 */
> 
> 
> The rest of the patch looks ok and is remarkably compact for a
> conversion to page pool. I'd prefer someone with more page pool exposure
> review this for correctness, but FWIW
 >

Both Jakub and I have reviewed the page_pool parts, and I think we are
in a good place.

Looking at the driver, I wonder why you are keeping the driver local
memory cache (when PP is also contains a memory cache) ?
(I assume there is a good reason, so this is not blocking patch)

> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Thanks for taking your time to review.

I'm ready to ACK once the description is improved a bit :-)

--Jesper
pw-bot: cr
