Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3077D49F662
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbiA1Jb6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 04:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347619AbiA1Jb6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 04:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643362317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5A/C5kiEp1/LBNi9MRAUlEKU1cKas7e8kxGW0FiZoQ=;
        b=e3n7m06fy3/DQUrlNm5UtoAnXKOcDrs6sEjINzgiO4DYY09a4jOFgUtAl+mvTPtaulm8ss
        Qdhn1ewzUP535+kBMBQmVmKRYnpMKfKXkt+AZqdcmTAeaZmWR1Imz2Nx1cdLtnNQiOT80l
        TZFOX6ChP+jVMJyFzsRFcNSvev2CEBg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-kks9nqpONAGG-EjvQrGlrw-1; Fri, 28 Jan 2022 04:31:55 -0500
X-MC-Unique: kks9nqpONAGG-EjvQrGlrw-1
Received: by mail-ed1-f72.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so2768303edt.15
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jan 2022 01:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f5A/C5kiEp1/LBNi9MRAUlEKU1cKas7e8kxGW0FiZoQ=;
        b=Vz9hvi06P44Glgg6W7M5+HsZ8NajF1MvIx3qywXbZlh0tD1Q76fU5AGCHzmBztTl0U
         6Z8k3XFf0n3iGWqVGv8x9tZaWLhdGhssEvPKs8oXgj9ZnITCaNmjM3MVEreA0AOtYc1+
         pSY2nZpTzMG7zi7G29MMt36717Vdo4abPeC2ISZ7R9TB/RcoHx08qNkugMd1l6jxAult
         muryK4JkuwrCBm6xQj5kOI/lE1KewKrn5tBYr7ICWAojF+IlvHbmOWaXx3eegSkeCPTM
         nRL8GmIQqbu7MLt1pT8eiEc/jByOpFGFp4E1sNU4QffE9xT9Si7HVM3DG0bSEffdIzU/
         GvOw==
X-Gm-Message-State: AOAM532zTpznKZfz6Jn7xiGB2cBwaLwDi7DaEw73wrhpAcBZMTB9ayDg
        4IsH0X4OyChWLMExC5ceILPK9dgJyDCMOz3u2taOXnx7LzW2wiHVpUpH7m9H0ZSO1zQ1t03nmKj
        nYHDD4K+zAEJDAY894Co9Fryl
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr7239622edd.355.1643362314425;
        Fri, 28 Jan 2022 01:31:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzq2XcKLD8u9nkhxIX+xxB2DKFLZ7ljDiXbsciOfiq2sHMfns2CyXpaKzoSo2qM4CjQVOz+oA==
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr7239607edd.355.1643362314230;
        Fri, 28 Jan 2022 01:31:54 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x12sm11516164edv.57.2022.01.28.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 01:31:53 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: RE: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
In-Reply-To: <MWHPR21MB1593C8511E18E4539CECAEC5D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-44-yury.norov@gmail.com>
 <87sftdij76.fsf@redhat.com>
 <MWHPR21MB1593C8511E18E4539CECAEC5D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Fri, 28 Jan 2022 10:31:52 +0100
Message-ID: <8735l8gq9j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, January 24, 2022 1:20 AM
>> 
>> Yury Norov <yury.norov@gmail.com> writes:
>> 
...
>> >
>> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> > index 60375879612f..7420a5fd47b5 100644
>> > --- a/drivers/hv/channel_mgmt.c
>> > +++ b/drivers/hv/channel_mgmt.c
>> > @@ -762,8 +762,8 @@ static void init_vp_index(struct vmbus_channel *channel)
>> >  		}
>> >  		alloced_mask = &hv_context.hv_numa_map[numa_node];
>> >
>> > -		if (cpumask_weight(alloced_mask) ==
>> > -		    cpumask_weight(cpumask_of_node(numa_node))) {
>> > +		if (cpumask_weight_eq(alloced_mask,
>> > +			    cpumask_weight(cpumask_of_node(numa_node)))) {
>> 
>> This code is not performace critical and I prefer the old version:
>> 
>>  	cpumask_weight() == cpumask_weight()
>> 
>>  looks better than
>> 
>> 	cpumask_weight_eq(..., cpumask_weight())
>> 
>> (let alone the inner cpumask_of_node()) to me.
>> 
>> >  			/*
>> >  			 * We have cycled through all the CPUs in the node;
>> >  			 * reset the alloced map.
>> 
> I agree with Vitaly in preferring the old version, and indeed performance
> here is a shrug.  But actually, I think the old version is a poorly coded way
> to determine if the two cpumasks are equal. The following would correctly
> capture the intent:
>
> 	if (cpumask_equal(alloced_mask, cpumask_of_node(numa_node))
>

Indeed. While it seems that only CPUs from 'cpumask_of_node(numa_node)'
can be set in 'alloced_mask' (and thus the comparison is valid), there's
no real need to weigh anything. I'll send a patch.

-- 
Vitaly

