Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C2732C6BE
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 02:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbhCDA35 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 19:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1573245AbhCCQ3X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Mar 2021 11:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614788870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCuxtxsw1rPj+RNzJ7/Z5Ov31mHk2dVG6emCURP+SN4=;
        b=YB4EbkzKf2hDMZwT3dEUDso9WNLerDC3uQGQ/QR8lwD8WMv/XBcg90w/Lcu94D4OpAkAtH
        4QG1vt0BrI4ul0Wrbh2JispbnOR7JzixlKRHUM+uQSamG8yux0B52xo7xfUvNb4b+bcMuk
        E2Zj2xogsQ90Y8fqWgmqyyypGd1WIVM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-6kBJOj6GNvKEHlHFFakOFw-1; Wed, 03 Mar 2021 11:27:44 -0500
X-MC-Unique: 6kBJOj6GNvKEHlHFFakOFw-1
Received: by mail-ej1-f71.google.com with SMTP id r26so5132468eja.22
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Mar 2021 08:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JCuxtxsw1rPj+RNzJ7/Z5Ov31mHk2dVG6emCURP+SN4=;
        b=jIlAybVw7EQWgPCFLCqxACPzqrVNrxiN2NoQjN5kGlreKxSD5AsC9OmLUk1uuMwQRF
         xfaCikb6oN0ULJHZGP8us2ozCS9E/T69jPEZ4eUEc7o9KuDTf0bMul9LiY6Wb+bLK/r/
         6wE/QBglH1NG4yatwip36AHn96F36rlV9qCKGjr+mE4Prl+kl2JfZV4Nh/ehK93pE8qD
         wqiz7I5d0nuUASQHITma55kR/MD3Y7TD0UZ31Yth7fPGSQKtUaif/6x8JMMAKMnOww/W
         MoVaiEoSyutSGuuBa2xT/EcP/IuBeLK4ERU3PZkQcmFquIVUXjoFWMUMpD6BOKNwgiln
         BE+A==
X-Gm-Message-State: AOAM533S8+6Rm5sh7EjnD7KsLThwvs+tGtoAXZEHG6xTfiSQLCh4gWWL
        jXvFXJBWAMNlRxdl1qnWRg1+ZUpNmmcROb4fUfSeyPgrhVqu1Pdv5tFf7emoaGLaGCmogXxFdQQ
        xfDLJX87oEy/oW7X+CNJGUdb4
X-Received: by 2002:a17:906:6dd2:: with SMTP id j18mr26823352ejt.480.1614788861066;
        Wed, 03 Mar 2021 08:27:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU3X4nF/e6pb+pVqsZO6n3qD6kQVN2xjF3XcgP9nN+zIAYgTC+4B5qo7yJl1XGun/oISZokA==
X-Received: by 2002:a17:906:6dd2:: with SMTP id j18mr26823237ejt.480.1614788859901;
        Wed, 03 Mar 2021 08:27:39 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gj13sm3019105ejb.118.2021.03.03.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 08:27:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 1/12] x86/Hyper-V: Add visibility parameter for
 vmbus_establish_gpadl()
In-Reply-To: <20210228150315.2552437-2-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
 <20210228150315.2552437-2-ltykernel@gmail.com>
Date:   Wed, 03 Mar 2021 17:27:38 +0100
Message-ID: <87y2f4cidh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Add visibility parameter for vmbus_establish_gpadl() and prepare
> to change host visibility when create gpadl for buffer.
>

"No functional change" as you don't actually use the parameter.

> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Nit: Sunil's SoB looks misleading because the patch is from you,
Co-Developed-by should be sufficient.

> ---
>  arch/x86/include/asm/hyperv-tlfs.h |  9 +++++++++
>  drivers/hv/channel.c               | 20 +++++++++++---------
>  drivers/net/hyperv/netvsc.c        |  8 ++++++--
>  drivers/uio/uio_hv_generic.c       |  7 +++++--
>  include/linux/hyperv.h             |  3 ++-
>  5 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index e6cd3fee562b..fb1893a4c32b 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -236,6 +236,15 @@ enum hv_isolation_type {
>  /* TSC invariant control */
>  #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
>  
> +/* Hyper-V GPA map flags */
> +#define HV_MAP_GPA_PERMISSIONS_NONE		0x0
> +#define HV_MAP_GPA_READABLE			0x1
> +#define HV_MAP_GPA_WRITABLE			0x2
> +
> +#define VMBUS_PAGE_VISIBLE_READ_ONLY HV_MAP_GPA_READABLE
> +#define VMBUS_PAGE_VISIBLE_READ_WRITE (HV_MAP_GPA_READABLE|HV_MAP_GPA_WRITABLE)
> +#define VMBUS_PAGE_NOT_VISIBLE HV_MAP_GPA_PERMISSIONS_NONE
> +

Are these x86-only? If not, then we should probably move these defines
to include/asm-generic/hyperv-tlfs.h. In case they are, we should do
something as we're using them from arch neutral places.

Also, could you please add a comment stating that these flags define
host's visibility of a page and not guest's (this seems to be not
obvious at least to me).

>  /*
>   * Declare the MSR used to setup pages used to communicate with the hypervisor.
>   */
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 0bd202de7960..daa21cc72beb 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -242,7 +242,7 @@ EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
>   */
>  static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
>  			       u32 size, u32 send_offset,
> -			       struct vmbus_channel_msginfo **msginfo)
> +			       struct vmbus_channel_msginfo **msginfo, u32 visibility)
>  {
>  	int i;
>  	int pagecount;
> @@ -391,7 +391,7 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
>  static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  				   enum hv_gpadl_type type, void *kbuffer,
>  				   u32 size, u32 send_offset,
> -				   u32 *gpadl_handle)
> +				   u32 *gpadl_handle, u32 visibility)
>  {
>  	struct vmbus_channel_gpadl_header *gpadlmsg;
>  	struct vmbus_channel_gpadl_body *gpadl_body;
> @@ -405,7 +405,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  	next_gpadl_handle =
>  		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
>  
> -	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
> +	ret = create_gpadl_header(type, kbuffer, size, send_offset,
> +				  &msginfo, visibility);
>  	if (ret)
>  		return ret;
>  
> @@ -496,10 +497,10 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>   * @gpadl_handle: some funky thing
>   */
>  int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
> -			  u32 size, u32 *gpadl_handle)
> +			  u32 size, u32 *gpadl_handle, u32 visibility)
>  {
>  	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer, size,
> -				       0U, gpadl_handle);
> +				       0U, gpadl_handle, visibility);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
>  
> @@ -610,10 +611,11 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	newchannel->ringbuffer_gpadlhandle = 0;
>  
>  	err = __vmbus_establish_gpadl(newchannel, HV_GPADL_RING,
> -				      page_address(newchannel->ringbuffer_page),
> -				      (send_pages + recv_pages) << PAGE_SHIFT,
> -				      newchannel->ringbuffer_send_offset << PAGE_SHIFT,
> -				      &newchannel->ringbuffer_gpadlhandle);
> +			page_address(newchannel->ringbuffer_page),
> +			(send_pages + recv_pages) << PAGE_SHIFT,
> +			newchannel->ringbuffer_send_offset << PAGE_SHIFT,
> +			&newchannel->ringbuffer_gpadlhandle,
> +			VMBUS_PAGE_VISIBLE_READ_WRITE);

Nit: I liked the original alignment more and we can avoid the unneeded
code churn.

>  	if (err)
>  		goto error_clean_ring;
>  
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 2353623259f3..bb72c7578330 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -333,7 +333,8 @@ static int netvsc_init_buf(struct hv_device *device,
>  	 */
>  	ret = vmbus_establish_gpadl(device->channel, net_device->recv_buf,
>  				    buf_size,
> -				    &net_device->recv_buf_gpadl_handle);
> +				    &net_device->recv_buf_gpadl_handle,
> +				    VMBUS_PAGE_VISIBLE_READ_WRITE);
>  	if (ret != 0) {
>  		netdev_err(ndev,
>  			"unable to establish receive buffer's gpadl\n");
> @@ -422,10 +423,13 @@ static int netvsc_init_buf(struct hv_device *device,
>  	/* Establish the gpadl handle for this buffer on this
>  	 * channel.  Note: This call uses the vmbus connection rather
>  	 * than the channel to establish the gpadl handle.
> +	 * Send buffer should theoretically be only marked as "read-only", but
> +	 * the netvsp for some reason needs write capabilities on it.
>  	 */
>  	ret = vmbus_establish_gpadl(device->channel, net_device->send_buf,
>  				    buf_size,
> -				    &net_device->send_buf_gpadl_handle);
> +				    &net_device->send_buf_gpadl_handle,
> +				    VMBUS_PAGE_VISIBLE_READ_WRITE);
>  	if (ret != 0) {
>  		netdev_err(ndev,
>  			   "unable to establish send buffer's gpadl\n");
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 0330ba99730e..813a7bee5139 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -29,6 +29,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/vmalloc.h>
>  #include <linux/slab.h>
> +#include <asm/mshyperv.h>
>  
>  #include "../hv/hyperv_vmbus.h"
>  
> @@ -295,7 +296,8 @@ hv_uio_probe(struct hv_device *dev,
>  	}
>  
>  	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
> -				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> +				    RECV_BUFFER_SIZE, &pdata->recv_gpadl,
> +				    VMBUS_PAGE_VISIBLE_READ_WRITE);
>  	if (ret)
>  		goto fail_close;
>  
> @@ -315,7 +317,8 @@ hv_uio_probe(struct hv_device *dev,
>  	}
>  
>  	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
> -				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> +				    SEND_BUFFER_SIZE, &pdata->send_gpadl,
> +				    VMBUS_PAGE_VISIBLE_READ_ONLY);

Actually, this is the only place where you use 'READ_ONLY' mapping --
which makes me wonder if it's actually worth it or we can hard-code
VMBUS_PAGE_VISIBLE_READ_WRITE for now and avoid this additional
parameter.

>  	if (ret)
>  		goto fail_close;
>  
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index f1d74dcf0353..016fdca20d6e 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1179,7 +1179,8 @@ extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
>  extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
>  				      void *kbuffer,
>  				      u32 size,
> -				      u32 *gpadl_handle);
> +				      u32 *gpadl_handle,
> +				      u32 visibility);
>  
>  extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
>  				     u32 gpadl_handle);

-- 
Vitaly

