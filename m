Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374544A96DD
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 10:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiBDJdj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 04:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232946AbiBDJdi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 04:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643967217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psHFPoCRmxPpHk1RPd76nF9dwzX3QFCwIVC0ZYt+sM4=;
        b=NqlHvGNpMAxZqhKixIwBqy/6m2jHP3+8Ms/PI05ji6+67WpB23bNJnJv9HFIi3NkesMfG3
        lmdTNvLGuSXi1Gfpv1nL36IimSR0blfGjnRmcBoOA4jHeuxbOVQswVLFVGs5OAyHPUvwy/
        xy8drwnuCz/aE6LOWe3FcBHqT0lRgMk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-bl0LTbRlMMidvR8D-OjeUQ-1; Fri, 04 Feb 2022 04:33:36 -0500
X-MC-Unique: bl0LTbRlMMidvR8D-OjeUQ-1
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2143154wmj.5
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Feb 2022 01:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=psHFPoCRmxPpHk1RPd76nF9dwzX3QFCwIVC0ZYt+sM4=;
        b=kpd7NINTu1rmZ7zIlNF0XgUkYmnI/Nq3pLFBF0dn4e5MpUtbk0HmevUo9i4mH9MQXI
         37Bq+FaUHez/wV1+NHnXGfaLVthPmgk6Nl3LjUNMpPW1VAdj2BhzzNQ3VCkVvTdfyTS1
         zBsxeuDEtgW7/BpZ6RUtypnnD4GgF8emRbqZr4FZspE5GTBVu8jJWjQV91Deq+e0Ja8Y
         48uOXT+0EM9kbTaLFQ6jPaL+U3dTq2KMEiR1zEaZ3kcKgwSVyVWBDNaXZkSQcsA/LubO
         1uJh/aJGL0ah/zyhPngbg1uqCViTHeyaSsiaxoTUz21pBypAGj91+XctxPd4oin9Flec
         QZog==
X-Gm-Message-State: AOAM5335W9cXWEw8ixyMw1PZ3ZGmCZpF8GCGfsQf19e8dP9LYRFpmjfn
        mgp7Axn2rRpcYORs+vaxJ0tc+8HGCwfqQgxPoJWjHPxzq49PP0V6LCvY8M8PNhV59iDXLCmbCYr
        Q7JO9dWu8Ub/4dtIps6ULdhAD
X-Received: by 2002:a5d:438a:: with SMTP id i10mr1657366wrq.295.1643967215429;
        Fri, 04 Feb 2022 01:33:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVtO488vewvsDODPN7TJXImSFQxST2bZkSAO/pC+Af0K50QlfGrFTjbRDEJWGrfanM0xA3Bg==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr1657352wrq.295.1643967215242;
        Fri, 04 Feb 2022 01:33:35 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r8sm1366700wrx.2.2022.02.04.01.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:33:34 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-hyperv@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: hv: drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width
 of type
In-Reply-To: <20220203235828.hcsj6najsl7yxmxa@altlinux.org>
References: <20220203235828.hcsj6najsl7yxmxa@altlinux.org>
Date:   Fri, 04 Feb 2022 10:33:33 +0100
Message-ID: <874k5fascy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> writes:

> Hi,
>
> There is new compilation error (for a second week for drm-tip[1] kernel):
>
>      CC [M]  drivers/hv/vmbus_drv.o
>    drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>    static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> 			       ^~~~~~~~~~~~~~~~
>    ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
>    #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> 							^ ~~~
>    1 error generated.
>
> I understand this looks like possible GCC (11.2.1) bug, but still it prevents
> building kernel with CONFIG_HYPERV.

It seems DMA_BIT_MASK(64) is very common:

$ git grep DMA_BIT_MASK\(64\) | wc -l
230

Is Hyper-V vmbus_drv the only victim? What happens if you replace
'DMA_BIT_MASK(64)' with '~0ULL', does the rest of the drivers compile
normally?

-- 
Vitaly

