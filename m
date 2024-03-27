Return-Path: <linux-hyperv+bounces-1850-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6372E88EBB5
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 17:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E41F2BEBC
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E914D285;
	Wed, 27 Mar 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9UtOMh9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E239130A6F;
	Wed, 27 Mar 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558536; cv=none; b=uOGHYnicUHW6rF39U/IyJbaEv0EObOUXFregTx9c5mlOgUqa5Hr4K0gx+cO0xA5DYQZFdpkyPh9iD13KjV2Mxm+lrEWKMuIlGaVkFjITMpw0jz1UTbnYGRGY35nXB9sN/0TpqZpABfyC4jI2f60upJnmYbxjTxtHiMM65xyDooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558536; c=relaxed/simple;
	bh=vpDkfUBtWL+UxBwjuUm5gYeL/cEacWfXEPKG81vcE0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVUCvvyh7H5EYkD1QI3uGSyjr4ez9q64CAjIvv58Baou9v6c4H+DRBtMU1+t5xKscrj6q0dEEdqG5fjCxIeFviFZahdLj00I9hOxqMFMN6Y1gB0sX0/h7PyL8QGDLextS2sgjSoKJBleZY9ULG6mJfeeYJ+DgWKUMqBvNcJ9lpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9UtOMh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABDBC433C7;
	Wed, 27 Mar 2024 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711558535;
	bh=vpDkfUBtWL+UxBwjuUm5gYeL/cEacWfXEPKG81vcE0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9UtOMh9NhK8uq0mZiMXt2LKgdT1qaV4eqkqQ4OpNjzEIBfNH8AxnSa5LKMbuNnuj
	 139SwlhRdsUzFtHFa7nm692D1Q6Maoi8Dc8aCzxaDG36oyEKDDYttLwvcqzFnSbA0P
	 DJD28wQMsDmrT4Kh7AowzV2l5JSL5uf6ZAH6m6jc=
Date: Wed, 27 Mar 2024 17:55:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
	vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev,
	florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, paul@crapouillou.net,
	Eugeniy.Paltsev@synopsys.com, manivannan.sadhasivam@linaro.org,
	vireshk@kernel.org, Frank.Li@nxp.com, leoyang.li@nxp.com,
	zw@zh-kernel.org, wangzhou1@hisilicon.com, haijie1@huawei.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	afaerber@suse.de, logang@deltatee.com, daniel@zonque.org,
	haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
	andersson@kernel.org, konrad.dybcio@linaro.org, orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
	patrice.chotard@foss.st.com, linus.walleij@linaro.org,
	wens@csie.org, jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jassisinghbrar@gmail.com, mchehab@kernel.org,
	maintainers@bluecherrydvr.com, aubin.constans@microchip.com,
	ulf.hansson@linaro.org, manuel.lauss@gmail.com,
	mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com, oakad@yahoo.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu,
	duncan.sands@free.fr, stern@rowland.harvard.edu, oneukum@suse.com,
	openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/9] USB: Convert from tasklet to BH workqueue
Message-ID: <2024032753-probable-blatancy-80bf@gregkh>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-5-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327160314.9982-5-apais@linux.microsoft.com>

On Wed, Mar 27, 2024 at 04:03:09PM +0000, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.

No it does not, I think your changelog is wrong :(

> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/usb/atm/usbatm.c            | 55 +++++++++++++++--------------
>  drivers/usb/atm/usbatm.h            |  3 +-
>  drivers/usb/core/hcd.c              | 22 ++++++------
>  drivers/usb/gadget/udc/fsl_qe_udc.c | 21 +++++------
>  drivers/usb/gadget/udc/fsl_qe_udc.h |  4 +--
>  drivers/usb/host/ehci-sched.c       |  2 +-
>  drivers/usb/host/fhci-hcd.c         |  3 +-
>  drivers/usb/host/fhci-sched.c       | 10 +++---
>  drivers/usb/host/fhci.h             |  5 +--
>  drivers/usb/host/xhci-dbgcap.h      |  3 +-
>  drivers/usb/host/xhci-dbgtty.c      | 15 ++++----
>  include/linux/usb/cdc_ncm.h         |  2 +-
>  include/linux/usb/usbnet.h          |  2 +-
>  13 files changed, 76 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> index 2da6615fbb6f..74849f24e52e 100644
> --- a/drivers/usb/atm/usbatm.c
> +++ b/drivers/usb/atm/usbatm.c
> @@ -17,7 +17,7 @@
>   *  		- Removed the limit on the number of devices
>   *  		- Module now autoloads on device plugin
>   *  		- Merged relevant parts of sarlib
> - *  		- Replaced the kernel thread with a tasklet
> + *  		- Replaced the kernel thread with a work

a "work"?

>   *  		- New packet transmission code
>   *  		- Changed proc file contents
>   *  		- Fixed all known SMP races
> @@ -68,6 +68,7 @@
>  #include <linux/wait.h>
>  #include <linux/kthread.h>
>  #include <linux/ratelimit.h>
> +#include <linux/workqueue.h>
>  
>  #ifdef VERBOSE_DEBUG
>  static int usbatm_print_packet(struct usbatm_data *instance, const unsigned char *data, int len);
> @@ -249,7 +250,7 @@ static void usbatm_complete(struct urb *urb)
>  	/* vdbg("%s: urb 0x%p, status %d, actual_length %d",
>  	     __func__, urb, status, urb->actual_length); */
>  
> -	/* Can be invoked from task context, protect against interrupts */
> +	/* Can be invoked from work context, protect against interrupts */

"workqueue"?  This too seems wrong.

Same for other comment changes in this patch.

thanks,

greg k-h

