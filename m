Return-Path: <linux-hyperv+bounces-3009-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B79778E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 08:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7ABC1C24B9A
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 06:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CBD1AD256;
	Fri, 13 Sep 2024 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H+MkYNvV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD41AC884;
	Fri, 13 Sep 2024 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209500; cv=none; b=sOc8GVrgqEL8jZnIy4/NpKPpm55ywCBRdbCWaNjU7s0LrVv6//ogetvVesc1K81u+EhNpcf1XPERMjhRYm+rFSSN3uzXIs4Xbt9gNNwT1+uk6jxZhI2c/Xoknm8+i8DnWR3+M8Ju3gPVF72Dilxmwugp1CSZNWaWA7ZxJp+Sv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209500; c=relaxed/simple;
	bh=4xHYKNWAjvmRzsKWIcW0kbbfOIXUycvAXoyxzueNQcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNQWk29P0CCI9YzEF77kvOE6HHreQ7tnizwgyMJhN5iORhx+Z1jmKDoZBbdqOSfdeRnnSeJN7l1OljzBJTbRFnKpCNpDInTkxJISUB5y5Vsp52gsyEf0Zhe4nV8Zgj7JVEub4ySh6zmWn46OVjwUh7h7/UsVyQF2F97nJoAtXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H+MkYNvV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id E6A5520BE55B; Thu, 12 Sep 2024 23:38:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6A5520BE55B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726209498;
	bh=HC02RBfIp0A+4waF9qafyPOYDr2sSAzrqEirpU+qVKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+MkYNvV6YQ+Tf7napCZM2V9ylDH7E7ybWVpHAEWL3UN5SyU3nPvsB++FOFiXf0lo
	 v9mp4BR91R6QOszIt5D+j2gui6MVGl/HSfEOsVpswIx6s+FkG/6xmpcNjT7L30LMCZ
	 QaB+/UndRMLw62EF6gDLw4DF/iCTtS6yTZlKJs18=
Date: Thu, 12 Sep 2024 23:38:18 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Message-ID: <20240913063818.GA18025@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
User-Agent: Mutt/1.5.21 (2010-09-15)

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

Can we have a fixes tag ?
My vote is to backport this upto this commit atleast:
https://lore.kernel.org/all/1586663435-36243-1-git-send-email-decui@microsoft.com/

- Saurabh

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

