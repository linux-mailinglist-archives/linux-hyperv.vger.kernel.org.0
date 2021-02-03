Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE530D0A6
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 02:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBCBKO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Feb 2021 20:10:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39785 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhBCBKM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Feb 2021 20:10:12 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 22BED5C0316;
        Tue,  2 Feb 2021 20:09:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Feb 2021 20:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JTga8A3fXUhd2V5FjYEJx7XBiur
        aMRi0rfyW5U+JxRQ=; b=EugxoD9fG7gNgeIPUe+JSicOMDmUPa8EK1EpKbGRw1P
        V/ox3lwgdPeOCYxd7tSS43FGSiyXZp6D4/HYiVIFQlEMuZYSZtQFxfw7PHWJ/ThT
        5Vm+yIQPY7mvFYZJG2hSFjwUUOtE/0GI2C/SPU6tmzqOYs2vnoYr6vPB6cPxlOAJ
        PP8b4c0cOscbbGkIvcRh/hMXdIqIIr+br0Fz0atK/Ts0sujfjxjV+IenSqW3keGA
        Yjw8jP4s2PknQqffXCO+TGqjepCKwcfovWYSrne3P8zuy2CvjFJbWYMXLU3iE0bX
        /lQnROe8rQ8fFd1UEj/wfpopm3GRJWhc0Ao87KReRJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JTga8A
        3fXUhd2V5FjYEJx7XBiuraMRi0rfyW5U+JxRQ=; b=Q+vSWopY4adSyqMAOpC3Q5
        jarYUDW7uR1HerDjIIG/8MQv0XXWLu/Z9rCh3LOyDWqN9RUy8nqiSDov5VlE/DbQ
        YVF8CklIML2OQ3QJNYgxkHbsbX/deWVYGXICA31HsyIS/k/dk5q36Z4Ss6EC4YGe
        s8zO+SPtxGSJuIfMu40s9rIL76p2zzxj+tcoNQbi7G0isD6FtCzFJp7w56UXMtbE
        tggHHmKYEi24qNlKK07IQcFmFB1PIPMg0N/G8aiKqx2rSDRBHRQ/FEgNDHTYMZ3c
        vXtL/5CdgmfN5DmH8x0G3//5u5tD5QO6O1I8YJPEwlHOkbgm21zQllEkBqNvSlIQ
        ==
X-ME-Sender: <xms:sfcZYLppnXfJns2vLvTYT2OExHa4lPkfVZBMhiA0Oal5JgHciqi4oA>
    <xme:sfcZYFmh8IbZxCCWdoVU2WvZAbXsVHuZZcl4ELNKPRiswzYANNEtT1sXET1Guu6kH
    78IakoONEomOw596A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepudekhfekleeugeevteehleffffejgeelueduleeffeeutdelffeujeffhfeu
    ffdunecukfhppeeijedrudeitddrvddujedrvdehtdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdgu
    vg
X-ME-Proxy: <xmx:sfcZYFGemzI8oP54vzrBj4haekt1Hwca87W4mRIEFSA7HCcYzNrYiQ>
    <xmx:sfcZYGob1k7PedqN0LHl5OFhu_WCvHV-jCLiKQjRln3sOauvXhi27g>
    <xmx:sfcZYJ7xgS4QDvaHjYBJ3a58G7U4_SMsto4gDbW6Lj-B2KjxOm3Tgw>
    <xmx:svcZYD3mr6XSU2GL0QlmoZvL3QqtMl4TdBbK34xs-hblFeAo1qOTwA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD1E7240064;
        Tue,  2 Feb 2021 20:09:05 -0500 (EST)
Date:   Tue, 2 Feb 2021 17:09:04 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Melanie Plageman <melanieplageman@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org
Subject: Re: [PATCH v1] scsi: storvsc: Parameterize nr_hw_queues
Message-ID: <20210203010904.hywx5xmwik52ccao@alap3.anarazel.de>
References: <CAAKRu_aWxovgFagWgY-UDDYb-24ca7yo=C461LXq_2iGt3XFqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAKRu_aWxovgFagWgY-UDDYb-24ca7yo=C461LXq_2iGt3XFqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

On 2021-02-02 15:19:08 -0500, Melanie Plageman wrote:
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 2e4fa77445fd..d72ab6daf9ae 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
>  static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
>  
>  static int storvsc_vcpus_per_sub_channel = 4;
> +static int storvsc_nr_hw_queues = -1;
>  
>  module_param(storvsc_ringbuffer_size, int, S_IRUGO);
>  MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
>  
> +module_param(storvsc_nr_hw_queues, int, S_IRUGO);
> +MODULE_PARM_DESC(storvsc_nr_hw_queues, "Number of hardware queues");

Would be nice if the parameter could be changed in a running
system. Obviously that's only going to affect devices that'll be
attached in the future (or detached and reattached), but that's still
nicer than not being able to change at all.


> @@ -2155,6 +2163,7 @@ static struct fc_function_template fc_transport_functions = {
>  static int __init storvsc_drv_init(void)
>  {
>  	int ret;
> +	int ncpus = num_present_cpus();
>  
>  	/*
>  	 * Divide the ring buffer data size (which is 1 page less
> @@ -2169,6 +2178,14 @@ static int __init storvsc_drv_init(void)
>  		vmscsi_size_delta,
>  		sizeof(u64)));
>  
> +	if (storvsc_nr_hw_queues > ncpus || storvsc_nr_hw_queues == 0 ||
> +			storvsc_nr_hw_queues < -1) {
> +		printk(KERN_ERR "storvsc: Invalid storvsc_nr_hw_queues value of %d.
> +						Valid values include -1 and 1-%d.\n",
> +				storvsc_nr_hw_queues, ncpus);
> +		return -EINVAL;
> +	}
> +

I have a mild preference for just capping the effective value to
num_present_cpus(), rather than erroring out. Would allow you to
e.g. cap the number of queues to 4, with the same param specified on
smaller and bigger systems.  Perhaps renaming it to max_hw_queues would
make that more obvious?

Greetings,

Andres Freund
