Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C485FE9A0
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Oct 2022 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJNHeS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Oct 2022 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJNHeS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Oct 2022 03:34:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC601B8650;
        Fri, 14 Oct 2022 00:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3794B82213;
        Fri, 14 Oct 2022 07:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F174C433C1;
        Fri, 14 Oct 2022 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665732854;
        bh=hW/vy/6le5CL8VPvE21jCFO4r6/XDqR0GmB30kY5ijM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KV15aovS/GlF3Ex8GFpdy4ZFr6ryKjQu5j2aZKXGZHGf360jwe8XNWr3dhl+PJUkX
         6oiwv3geIuVxv6nt5Pc3NhJ6zb1rkM+nb0gkJslKgJqMVuA2eePvcTe5/2QaxtBzku
         0WTnFgSqSoDpAYyWxZGvmVN9xJUutUN3nf2g9DTA=
Date:   Fri, 14 Oct 2022 09:34:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Message-ID: <Y0kRIcXG+wNbcGx0@kroah.com>
References: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 13, 2022 at 11:29:14AM -0700, Saurabh Sengar wrote:
> Hyper-V is adding some "specialty" synthetic devices.

What devices are those specifically?

> Instead of writing new kernel-level VMBus drivers for these devices,
> the devices will be presented to user space via this existing Hyper-V
> generic UIO driver, so that a user space driver can handle the device.
> Since these new synthetic devices are low speed devices, they don't
> support monitor bits and we must use vmbus_setevent() to enable
> interrupts from the host.

That is not what the UIO interface is for.  Please write real drivers so
that they tie into the specific user/kernel apis for those device types.

Without a specific list of what these devices are, I can not recommend
that anyone use the UIO api for them as that's probably not a good idea.

Also, if you do do this, you need to list where the source for that
userspace code is so that users can get it and have their distros
package it up for them.  I do not see that here at all.


> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index c08a6cfd119f..8e5aa4a1247f 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -84,6 +84,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
>  	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
>  	virt_mb();
>  
> +	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> +		vmbus_setevent(dev->channel);
> +
>  	return 0;
>  }
>  
> @@ -239,12 +242,6 @@ hv_uio_probe(struct hv_device *dev,
>  	void *ring_buffer;
>  	int ret;
>  
> -	/* Communicating with host has to be via shared memory not hypercall */
> -	if (!channel->offermsg.monitor_allocated) {
> -		dev_err(&dev->device, "vmbus channel requires hypercall\n");

I do not understand, why is this check not made anymore here?  Why
constantly make the call above in the irq handler instead?  Isn't that
going to be massively slow?

thanks,

greg k-h
