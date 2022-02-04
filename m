Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF64A9224
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 02:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348061AbiBDBy7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 20:54:59 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:34912 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiBDBy7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 20:54:59 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3F4D672C905;
        Fri,  4 Feb 2022 04:54:58 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 1C3514A46F0;
        Fri,  4 Feb 2022 04:54:58 +0300 (MSK)
Date:   Fri, 4 Feb 2022 04:54:57 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] drivers: hv: vmbus: Fix build on GCC 11 failed by
 DMA_BIT_MASK(64) expansion
Message-ID: <20220204015457.gmawzzp46hrjsk2y@altlinux.org>
References: <20220204005736.3891190-1-vt@altlinux.org>
 <MWHPR21MB15936A0F46747D81D3CBCC12D7299@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15936A0F46747D81D3CBCC12D7299@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael,

On Fri, Feb 04, 2022 at 01:48:32AM +0000, Michael Kelley (LINUX) wrote:
> From: Vitaly Chikunov <vt@altlinux.org>   Sent: Thursday, February 3, 2022 4:58 PM
> > 
> > GCC 11.2.1 cannot understand that value 64 is excluded from the shift
> > at compile time resulting in build error[1]:
> > 
> >   drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-
> > Wshift-count-overflow]
> >   static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> >                               ^~~~~~~~~~~~~~~~
> >   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
> >   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> >                                                        ^ ~~~
> > 
> > Avoid using DMA_BIT_MASK macro for that corner case.
> 
> If we need a temporary hack to solve the build problem, I can live with
> that.  But I see 230 other places in kernel code where DMA_BIT_MASK(64)
> is used, so I'm wondering if this particular hack is effective.  We need a
> more comprehensive solution that fixes the definition of
> DMA_BIT_MASK() so it will work with a constant '64' as the parameter.

All other places seems to be inside of functions which, perhaps,
triggers different GCC logic. And only vmbus use is in global and static
context.

There is nothing to fix in DMA_BIT_MASK definition, because it's valid.
At least, I don't see other solutions.

Thanks,

> 
> Michael
> 
> > 
> > Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > Cc: Michael Kelley <mikelley@microsoft.com>
> > Cc: Long Li <longli@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Link: https://lore.kernel.org/linux-hyperv/20220203235828.hcsj6najsl7yxmxa@altlinux.org/
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 17bf55fe3169..2376ee484362 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2079,7 +2079,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
> >         return child_device_obj;
> >  }
> > 
> > -static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> > +static u64 vmbus_dma_mask = ~0ULL;
> >  /*
> >   * vmbus_device_register - Register the child device
> >   */
> > --
> > 2.33.0
