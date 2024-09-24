Return-Path: <linux-hyperv+bounces-3062-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637F3983B8D
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 05:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2D9B220C6
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6D18E1F;
	Tue, 24 Sep 2024 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="AHFqERVb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48D1802B;
	Tue, 24 Sep 2024 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148479; cv=none; b=cG18g5NhgrdaJnGYSw9eHgwunGP+0NQP9VBTQuPnzOQ6IHVxTmpJtzp9d/7UzLXP2ai8zoPmLJhyZDVd86kLtoqv4u4+ZMLUBOvTHxNzlmZcMqPWv5AmjOW5K2C/c3kRK9p9+KpunVO+mkxADNi+zQtMyPhXfeoDG8kaBTfUHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148479; c=relaxed/simple;
	bh=zW0tRfMuxxI2mxbcKV2XDv6SSrdP/H9qU16HtI8aDmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0nR3YLx/9mgx/evNCs/Gv1KN3PmNmMtOO1U/BH+sFGtN1Q2zDPlvnlGoqevSXnNeX/PpbpAMHNum+hba5lcfAL2tN0V1TEYvNCHWiRtPhXSFKKn/OEyFHs/MehU9oqJ8qXrP6AxMnu6hPS/x2miaaRv86SUNOpmjamTO0TEGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=AHFqERVb; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3JBM5zivCqL724qHtwnDsgdI6b7aDB+UMJQuM4TePwc=; t=1727148477; x=1728012477; 
	b=AHFqERVb1tHTIui2UUI810xTIAjL6CjKUQopa6qk3AXaIOt3hAy2qLYr784Ll+mEU7g9fwpjVpM
	+RV3CmHTRSapHjxarMgAgPfbsSyJ7vztlyiVpddXoMMlKv7dNWZjqFfJ1y4yhyXw4cvv+VFs9uwWi
	JVzoH/gjjLuPbfmzYRkPmFYPlJ1MQ496jOPTtnDdFPFi1cxFzcSqo2PQjsHhBE8rG0ayDZFhe9wjI
	jrVipstT++5LLqkAX9z9fKPido5rtmen8Cvj0Sj+WkQ9Z/faEZAVdujdCxHAIpGiHLt3AWWeR4EHb
	YzTNQatB1EV2WIE25fw29SFE9TF/gp9SljNA==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1sswDR-00EsVG-St;
	Mon, 23 Sep 2024 23:27:54 -0400
Date: Tue, 24 Sep 2024 03:27:50 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, Saurabh Sengar <ssengar@linux.microsoft.com>,
	rafael@kernel.org, pavel@ucw.cz, lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Message-ID: <ZvIxtsFmk7iLvF6g@csail.mit.edu>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>

[+linux-pm, Rafael, Len, Pavel]

On Thu, Sep 12, 2024 at 02:27:48PM -0700, Erni Sri Satya Vennela wrote:
> If the Virtual Machine Connection window is focused,
> a Hyper-V VM user can unintentionally touch the keyboard/mouse
> when the VM is hibernating or resuming, and consequently the
> hibernation or resume operation can be aborted unexpectedly.
> Fix the issue by no longer registering the keyboard/mouse as
> wakeup devices (see the other two patches for the
> changes to drivers/input/serio/hyperv-keyboard.c and
> drivers/hid/hid-hyperv.c).
> 
> The keyboard/mouse were registered as wakeup devices because the
> VM needs to be woken up from the Suspend-to-Idle state after
> a user runs "echo freeze > /sys/power/state". It seems like
> the Suspend-to-Idle feature has no real users in practice, so
> let's no longer support that by returning -EOPNOTSUPP if a
> user tries to use that.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 965d2a4efb7e..4efd8856392f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -900,6 +900,19 @@ static void vmbus_shutdown(struct device *child_device)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> +/*
> + * vmbus_freeze - Suspend-to-Idle
> + */
> +static int vmbus_freeze(struct device *child_device)
> +{
> +/*
> + * Do not support Suspend-to-Idle ("echo freeze > /sys/power/state") as
> + * that would require registering the Hyper-V synthetic mouse/keyboard
> + * devices as wakeup devices, which can abort hibernation/resume unexpectedly.
> + */
> +	return -EOPNOTSUPP;
> +}
> +
>  /*
>   * vmbus_suspend - Suspend a vmbus device
>   */
> @@ -969,7 +982,7 @@ static void vmbus_device_release(struct device *device)
>   */
>  
>  static const struct dev_pm_ops vmbus_pm = {
> -	.suspend_noirq	= NULL,
> +	.suspend_noirq  = vmbus_freeze,
>  	.resume_noirq	= NULL,
>  	.freeze_noirq	= vmbus_suspend,
>  	.thaw_noirq	= vmbus_resume,
> -- 
> 2.34.1
> 
> 

