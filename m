Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C84AAD57
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Feb 2022 02:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381496AbiBFBIL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 20:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345823AbiBFBIL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 20:08:11 -0500
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 17:08:09 PST
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B65DDC061348
        for <linux-hyperv@vger.kernel.org>; Sat,  5 Feb 2022 17:08:09 -0800 (PST)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F250E72C905;
        Sun,  6 Feb 2022 04:02:19 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id CADA34A46F0;
        Sun,  6 Feb 2022 04:02:19 +0300 (MSK)
Date:   Sun, 6 Feb 2022 04:02:19 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Fix build on Clang 12 failed by
 DMA_BIT_MASK(64) expansion
Message-ID: <20220206010219.ol6wy7svem644l4g@altlinux.org>
References: <20220204130503.76738-1-vt@altlinux.org>
 <MWHPR21MB15939EB2A75C96B2287B38DFD7299@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220205040552.fnshfhin3fij67t6@altlinux.org>
 <MWHPR21MB1593FEE0DFE66E1669E6994BD72A9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593FEE0DFE66E1669E6994BD72A9@MWHPR21MB1593.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael,

On Sat, Feb 05, 2022 at 02:41:31PM +0000, Michael Kelley (LINUX) wrote:
> From: Vitaly Chikunov <vt@altlinux.org> Sent: Friday, February 4, 2022 8:06 PM
> > 
> > On Fri, Feb 04, 2022 at 04:10:49PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Vitaly Chikunov <vt@altlinux.org> Sent: Friday, February 4, 2022 5:05 AM
> > > >
> > > > Clang 12.0.1 cannot understand that value 64 is excluded from the shift
> > > > at compile time (for use in global context) resulting in build error:
> > > >
> > > >   drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-
> > > > Wshift-count-overflow]
> > > >   static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> > > > 			      ^~~~~~~~~~~~~~~~
> > > >   ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
> > > >   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > > > 						       ^ ~~~
> > > >
> > > > Avoid using DMA_BIT_MASK macro for that corner case.
> > > >
> > > > Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > > > Cc: Michael Kelley <mikelley@microsoft.com>
> > > > Cc: Long Li <longli@microsoft.com>
> > > > Cc: Wei Liu <wei.liu@kernel.org>
> > > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > > ---
> > > >  drivers/hv/vmbus_drv.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > > index 17bf55fe3169..a1306ca15d3f 100644
> > > > --- a/drivers/hv/vmbus_drv.c
> > > > +++ b/drivers/hv/vmbus_drv.c
> > > > @@ -2079,7 +2079,8 @@ struct hv_device *vmbus_device_create(const guid_t *type,
> > > >  	return child_device_obj;
> > > >  }
> > > >
> > > > -static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> > > > +/* Use ~0ULL instead of DMA_BIT_MASK(64) to work around a bug in Clang. */
> > > > +static u64 vmbus_dma_mask = ~0ULL;
> > > >  /*
> > > >   * vmbus_device_register - Register the child device
> > > >   */
> > > > --
> > > > 2.33.0
> > >
> > > Instead of the hack approach, does the following code rearrangement solve
> > > the problem by eliminating the use of DMA_BIT_MASK(64) in a static initializer?
> > > I don't have Clang handy to try it.
> > 
> > Yes this compiles well on Clang.
> > 
> > Vitaly,
> > 
> 
> Do you want to submit a patch with my approach, or should I do it?  I'm
> happy to do it, but I don't want to pre-empt what you have already
> started without your OK.

I'm OK if you send it!

Thanks,

> 
> Michael
> 
> > >
> > > This approach also more closely follows the pattern used in other device types.
> > >
> > > Michael
> > >
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 17bf55f..0d96634 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -2079,7 +2079,6 @@ struct hv_device *vmbus_device_create(const guid_t
> > *type,
> > >  	return child_device_obj;
> > >  }
> > >
> > > -static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> > >  /*
> > >   * vmbus_device_register - Register the child device
> > >   */
> > > @@ -2120,8 +2119,9 @@ int vmbus_device_register(struct hv_device
> > *child_device_obj)
> > >  	}
> > >  	hv_debug_add_dev_dir(child_device_obj);
> > >
> > > -	child_device_obj->device.dma_mask = &vmbus_dma_mask;
> > >  	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> > > +	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
> > > +	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> > >  	return 0;
> > >
> > >  err_kset_unregister:
> > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > > index f565a89..fe2e017 100644
> > > --- a/include/linux/hyperv.h
> > > +++ b/include/linux/hyperv.h
> > > @@ -1262,6 +1262,7 @@ struct hv_device {
> > >  	struct vmbus_channel *channel;
> > >  	struct kset	     *channels_kset;
> > >  	struct device_dma_parameters dma_parms;
> > > +	u64 dma_mask;
> > >
> > >  	/* place holder to keep track of the dir for hv device in debugfs */
> > >  	struct dentry *debug_dir;
