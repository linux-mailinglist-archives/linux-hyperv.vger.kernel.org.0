Return-Path: <linux-hyperv+bounces-3491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A379F56DC
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C336D1886DF8
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677301F8F0A;
	Tue, 17 Dec 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkrZ4zb0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982D158DD1;
	Tue, 17 Dec 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463635; cv=none; b=nAD1cT/BdKjbRazXW+ZdyQLUmtnMR0SQEXk5mt4uWSEmveSUVmXmIktccCHo15eMLWedvYUC7VbKLY029wpyGnjfy3vp/Atkls6TrgDkPqPNNcEwTmwI/AIUva0o2/aLWt0aUIBRH/kYvYlEfGpgou+lPx5GJZKWuTAyZQUQ6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463635; c=relaxed/simple;
	bh=JBmI31rqlVMLbDvulREys4tYlBYIp0qQtjfXqk8ku1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/USjAsOxD89CFribQFv46+JeO8T9Qh2E0pdvS7gn8Qwu+as/IJ4Q39BKW/jY5mEOpuD6EFtt4CNGZcDGBnsfLJNBrNsEjEcVO/H72Ctyykpk1+8X221G6fjs8vxq7QR7SO8WXlrV5kTv3304X4gunQsHQ6H67VvuQyLLmwSlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkrZ4zb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D230AC4CED3;
	Tue, 17 Dec 2024 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734463635;
	bh=JBmI31rqlVMLbDvulREys4tYlBYIp0qQtjfXqk8ku1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkrZ4zb0RM4hhNA4N6I2S7sbmaLQlC6LZ8mcCWhLcPBdNsaGnhqVg6inYNB/J7l4l
	 P498ZJugyXk5ODut6SlLEH7d4605EflpBMToAsLkdzkZc/MOPvaZRBDIGmsyUbm1vX
	 QLHE2dDja+D5klP1OPJ5ullCIrt4DF8SMuz4NcryWdgwQh024LDekZIKFjBJEJ2xcf
	 blhJ8G9TeHPIIxMxDC/QXDj0xBoklX8fqYrv1hxO312LOFV/Jr5MEMEe2VwcPJHM7H
	 yDGK6R9x91nay20FdhMAFpVvNI6kWAn9i/z5jfG2EBfapBAOIoDbZo02RvRZRy1z14
	 zSlzrktic8kGg==
Date: Tue, 17 Dec 2024 19:27:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v4 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for
 VMBus
Message-ID: <Z2HQkTfB18nvZn8a@liuwe-devbox-debian-v2>
References: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
 <1734409029-10419-2-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734409029-10419-2-git-send-email-ernis@linux.microsoft.com>

On Mon, Dec 16, 2024 at 08:17:07PM -0800, Erni Sri Satya Vennela wrote:
> This change is specific to Hyper-V VM user.
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
> Fixes: 1a06d017fb3f ("Drivers: hv: vmbus: Fix Suspend-to-Idle for Generation-2 VM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>>
> ---
> Changes in v4:
> * No change
> 
> Changes in v3:
> * Add "Cc: stable@vger.kernel.org" in sign-off area.
> 
> Changes in v2:
> * Add "#define vmbus_freeze NULL" when CONFIG_PM_SLEEP is not 
>   enabled.
> ---
>  drivers/hv/vmbus_drv.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6d89d37b069a..4df6b12bf6a1 100644
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

The indentation is off. I can fix it for you if the series gets
sufficient reviews. Please fix it yourself if you end up posting another
round.

Thanks,
Wei.

> +	return -EOPNOTSUPP;
> +}
> +
>  /*
>   * vmbus_suspend - Suspend a vmbus device
>   */
> @@ -938,6 +951,7 @@ static int vmbus_resume(struct device *child_device)
>  	return drv->resume(dev);
>  }
>  #else
> +#define vmbus_freeze NULL
>  #define vmbus_suspend NULL
>  #define vmbus_resume NULL
>  #endif /* CONFIG_PM_SLEEP */
> @@ -969,7 +983,7 @@ static void vmbus_device_release(struct device *device)
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

