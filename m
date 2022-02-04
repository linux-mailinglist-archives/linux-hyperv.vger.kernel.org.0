Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7C4A98DE
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiBDMF2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 07:05:28 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35563 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbiBDMF2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 07:05:28 -0500
Received: by mail-wr1-f45.google.com with SMTP id j25so10194084wrb.2
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Feb 2022 04:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/eHJdzElxNofFWLDu3KyHOqxJIT6W5olRLkROpVwH8=;
        b=CxF52OBKDxa3T6L2Sh1rGI+T725B/Xn2NFgO3Aix7LLTNGbiWRSGFVl/XwFDestZMV
         ACZWKWNh5/xKM5Yfxv0arVSsf+o5BELLQyvq3aIKZm5BZ434apLgWIcUc+rh5v6jmQVA
         krEksGsaY8hwAbZpMbsDCAEjh3bRZ7KM+hZLkRzvmyu+eeugtrBbmwJn0XCfTqv3YZ84
         HzX6p1VvGpBku1+jcJQSxnRHd/6NsgjfO2re2hA060WobtufN5XHpk4sf75gK7qb+eBk
         vRuyoQccvTsGT7C8VMYBBwae2lZYgaEDegYsk9BCZChVAhITqowq0jULqqahSWPxyiag
         qtrg==
X-Gm-Message-State: AOAM533Yye81kExLDZquVub6KdWzu1WnBsF5XZq4aUfXbo+8wTwg+i7M
        w1FPZAHd3fOtWp6dfemcrGQ=
X-Google-Smtp-Source: ABdhPJyDJVMMx1E69+wATvJq++T/oqidGE/0Hvm0Dt1HBkStVbjsFSDT/TGNowchFJcNfEwglh9Zug==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr2264468wrn.105.1643976326945;
        Fri, 04 Feb 2022 04:05:26 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 11sm2008371wry.68.2022.02.04.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:05:26 -0800 (PST)
Date:   Fri, 4 Feb 2022 12:05:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
Message-ID: <20220204120524.bhnbmfzcgpsrlezv@liuwe-devbox-debian-v2>
References: <20220204022627.4183515-1-vt@altlinux.org>
 <871r0jas2l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r0jas2l.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 10:39:46AM +0100, Vitaly Kuznetsov wrote:
> Vitaly Chikunov <vt@altlinux.org> writes:
> 
> > Clang 12.0.1 cannot understand that value 64 is excluded from the shift
> > at compile time (for use in global context) resulting in build error[1]:
> >
> >   drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >   static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> > 			      ^~~~~~~~~~~~~~~~
> >   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
> >   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > 						       ^ ~~~
> >
> > Avoid using DMA_BIT_MASK macro for that corner case.
> 
> Was this reported to Clang already? It looks like a clear bug on their side.

This is already known.

I dealt with a similar report before. At the time I decided nothing's
wrong with the code.

https://lore.kernel.org/linux-kernel/YcC1CobR%2Fn0tJhdV@archlinux-ax161/
https://github.com/ClangBuiltLinux/linux/issues/92

I can certainly live with a workaround like this.

> 
> >
> > Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > Cc: Michael Kelley <mikelley@microsoft.com>
> > Cc: Long Li <longli@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Link: https://lore.kernel.org/linux-hyperv/20220203235828.hcsj6najsl7yxmxa@altlinux.org/
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> > Changes since v1:
> > - Patch description updated, s/GCC 11/Clang 12/.
> >
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 17bf55fe3169..2376ee484362 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2079,7 +2079,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
> >  	return child_device_obj;
> >  }
> >  
> > -static u64 vmbus_dma_mask = DMA_BIT_MASK(64);

Please add a comment here

  // Use ~0ULL instead of DMA_BIT_MASK(64) to work around a bug in Clang.

> > +static u64 vmbus_dma_mask = ~0ULL;
> >  /*
> >   * vmbus_device_register - Register the child device
> >   */
> 
> -- 
> Vitaly
> 
