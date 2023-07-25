Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8007620DD
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jul 2023 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGYSCL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjGYSB7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 14:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A9A10F7
        for <linux-hyperv@vger.kernel.org>; Tue, 25 Jul 2023 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690308071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBbADqs+v1wKci/ZBXowdEAl6AvZzPcdCEegqxDdVtQ=;
        b=X9Yc7Kdy0dLazHuWhObM0oucrtNBDvqrBOXlSx/xkF5lAISB3j2wWmhwV+F4Z8wkEoykAm
        JjFQEnqWjLrxNCA/x8LpXgwl8w8DAvqZ7X1p3yQMDR+TobeShvNe6PqC7IJUpg6YBbRpXt
        0ifJ3dghuvudxBN562KvjuzM3az5tDo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-uFs-7afNMau_FjdqTAbFQg-1; Tue, 25 Jul 2023 14:01:10 -0400
X-MC-Unique: uFs-7afNMau_FjdqTAbFQg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51bee352ffcso4423491a12.1
        for <linux-hyperv@vger.kernel.org>; Tue, 25 Jul 2023 11:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308065; x=1690912865;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBbADqs+v1wKci/ZBXowdEAl6AvZzPcdCEegqxDdVtQ=;
        b=UTyiOSzByDTubQrjDFV/JHw8syj6YhTtJx3UTkE2nMcKnl+/VcfUZk+fgQ7dtWcotN
         S6HCN0tXAnQZT9kfmmrVHx8Bx4Wcx9lvB9KkmD9ZlTNprM1bjNu0Rs4VsaPuIaDW6b6A
         xmySx9BjspI7HDC7P6TxjPXl6zilNlQnKuDkda5aVvV/jyfYqvdA5BXZAykyzL2/Rdbm
         011oKWXoMTQK8FWLGTNDD4wA0fUItsyDzKrzN4RFl2LG/RDUikhER7qZmXyvbUtB0WtM
         cTjv5FRCtxoarply+zYRVQIfKe4AN8AZeful27oek0tpiHFlgUxMP1la7v1/ojjoaWTR
         y6JQ==
X-Gm-Message-State: ABy/qLYJuoH7Z+6pm7q3OMysuiynVmn1Ix1NUmtwsMYvtSPctPSSVtCM
        /MOiMR/hGcInF2pvYeEGUy2TKDEguxbPQp7mkULuXYGUz2OcGlSDpC3ZOGgWvYi4A2cG9p4JrKR
        tvtEFQe8KvOyfMKqIrr/TYGNk
X-Received: by 2002:aa7:c6da:0:b0:522:2aee:a2c9 with SMTP id b26-20020aa7c6da000000b005222aeea2c9mr6710250eds.5.1690308065634;
        Tue, 25 Jul 2023 11:01:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHizmB181reThRO6/ASk1i7c69OaRWpmGynXIDW5VJ7Fjh9jnBGY5twnl6WJ5sBLy4NT1Nk6w==
X-Received: by 2002:aa7:c6da:0:b0:522:2aee:a2c9 with SMTP id b26-20020aa7c6da000000b005222aeea2c9mr6710228eds.5.1690308065265;
        Tue, 25 Jul 2023 11:01:05 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id l25-20020aa7c3d9000000b0051873c201a0sm7798293edr.26.2023.07.25.11.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 11:01:04 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <729b360c-4d79-1025-f5be-384b17f132d3@redhat.com>
Date:   Tue, 25 Jul 2023 20:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Paul Rosswurm <paulros@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Long Li <longli@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
 <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <PH7PR21MB311675E57B81B49577ADE98FCA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB311675E57B81B49577ADE98FCA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 24/07/2023 20.35, Haiyang Zhang wrote:
> 
[...]
>>> On 21/07/2023 21.05, Haiyang Zhang wrote:
>>>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>>>> usage.
>>>>
>>>> The standard page pool API is used.
>>>>
>>>> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>>>> ---
>>>> V3:
>>>> Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
>>>> V2:
>>>> Use the standard page pool API as suggested by Jesper Dangaard Brouer
>>>>
>>>> ---
>>>>    drivers/net/ethernet/microsoft/mana/mana_en.c | 91 +++++++++++++++--
>> --
>>>>    include/net/mana/mana.h                       |  3 +
>>>>    2 files changed, 78 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
>>> b/drivers/net/ethernet/microsoft/mana/mana_en.c
>>>> index a499e460594b..4307f25f8c7a 100644
>>>> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
>>>> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>>> [...]
>>>> @@ -1659,6 +1679,8 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
>>>>
>>>>    	if (rxq->xdp_flush)
>>>>    		xdp_do_flush();
>>>> +
>>>> +	page_pool_nid_changed(rxq->page_pool, numa_mem_id());
>>>
>>> I don't think this page_pool_nid_changed() called is needed, if you do
>>> as I suggest below (nid = NUMA_NO_NODE).
>>>
>>>
>>>>    }
>>>>
>>>>    static int mana_cq_handler(void *context, struct gdma_queue
>>> *gdma_queue)
>>> [...]
>>>
>>>> @@ -2008,6 +2041,25 @@ static int mana_push_wqe(struct mana_rxq
>> *rxq)
>>>>    	return 0;
>>>>    }
>>>>
>>>> +static int mana_create_page_pool(struct mana_rxq *rxq)
>>>> +{
>>>> +	struct page_pool_params pprm = {};
>>>
>>> You are implicitly assigning NUMA node id zero.
>>>
>>>> +	int ret;
>>>> +
>>>> +	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
>>>> +	pprm.napi = &rxq->rx_cq.napi;
>>>
>>> You likely want to assign pprm.nid to NUMA_NO_NODE
>>>
>>>    pprm.nid = NUMA_NO_NODE;
>>>
>>> For most drivers it is recommended to assign ``NUMA_NO_NODE`` (value -1)
>>> as the NUMA ID to ``pp_params.nid``. When ``CONFIG_NUMA`` is enabled
>>> this setting will automatically select the (preferred) NUMA node (via
>>> ``numa_mem_id()``) based on where NAPI RX-processing is currently
>>> running. The effect is that page_pool will only use recycled memory when
>>> NUMA node match running CPU. This assumes CPU refilling driver RX-ring
>>> will also run RX-NAPI.
>>>
>>> If a driver want more control over the NUMA node memory selection,
>>> drivers can assign (``pp_params.nid``) something else than
>>> `NUMA_NO_NODE`` and runtime adjust via function
>>> ``page_pool_nid_changed()``.
>>
>> Our driver is using NUMA 0 by default, so I implicitly assign NUMA node id
>> to zero during pool init.
>>
>> And, if the IRQ/CPU affinity is changed, the page_pool_nid_changed()
>> will update the nid for the pool. Does this sound good?
>>
> 
> Also, since our driver is getting the default node from here:
> 	gc->numa_node = dev_to_node(&pdev->dev);
> I will update this patch to set the default node as above, instead of implicitly
> assigning it to 0.
> 

In that case, I agree that it make sense to use dev_to_node(&pdev->dev), 
like:
	pprm.nid = dev_to_node(&pdev->dev);

Driver must have a reason for assigning gc->numa_node for this hardware,
which is okay. That is why page_pool API allows driver to control this.

But then I don't think you should call page_pool_nid_changed() like

	page_pool_nid_changed(rxq->page_pool, numa_mem_id());

Because then you will (at first packet processing event) revert the
dev_to_node() setting to use numa_mem_id() of processing/running CPU.
(In effect this will be the same as setting NUMA_NO_NODE).

I know, mlx5 do call page_pool_nid_changed(), but they showed benchmark
numbers that this was preferred action, even-when sysadm had
"misconfigured" the default smp_affinity RX-processing to happen on a
remote NUMA node.  AFAIK mlx5 keeps the descriptor rings on the
originally configured NUMA node that corresponds to the NIC PCIe slot.

--Jesper

