Return-Path: <linux-hyperv+bounces-3010-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B34977968
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 09:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B5F2847BA
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C481B9B3E;
	Fri, 13 Sep 2024 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="imibRC3f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6731B9822;
	Fri, 13 Sep 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211975; cv=none; b=bzcoeg/Wzw3ECLzXnsSmAjvjFMp+bY9BZdFVL2moh8j6PgAzoI5pIvBVC302IwsZkQYJJ688+hofWb+xUUY8fKnGNtDuImuUPNTxSNEUu2/g/wKFd/xINt1fvowkoztCxmYAkmrFzndbaTDdhsS+Ct7U2yQNEJi/jdSwPxBjjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211975; c=relaxed/simple;
	bh=Fqm5j5PqqykRHz2N46Qm0vMp5IoVJm/4hc1kAcp4CnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpOA5w0QMcqdI3RxEiBjOL0k4G4oDLeNKwu0iAQNDo8yrHWt6nSFzBc8xoo7yBdwgF5/ahZzMzV+0qQGwb3mGS0UazPZMgyR66/0b/u5HPlJg0rghsaVmWUyyuTDZ0yA6OF8HR7sZG1tI6qanZy/KMqV1hnk1o6eiUj9SmWYLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=imibRC3f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.224.211] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id A8C8020BE570;
	Fri, 13 Sep 2024 00:19:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8C8020BE570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726211973;
	bh=FCp9C1OMLBEJyfEFicP99zjs2mgecvyy+xP/KU9OG8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=imibRC3frCTJ9zv/vE1JZvnbjZKWo+rZq52QVyLqrUgly/fraCylcM0EDt7wnVN8j
	 pLFai2TO6psw+pKbNeCJhW8JB29eoO5grWJ1chy8laysKzIgdq7NnngWiF5edljDb+
	 fgf4xdxcB19IfO+bkcCXPfFzcgMLAH3/DmeNNb6Y=
Message-ID: <b480a355-dbfa-4422-ad3c-65ec931a3ba0@linux.microsoft.com>
Date: Fri, 13 Sep 2024 12:49:27 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com, Saurabh Sengar <ssengar@linux.microsoft.com>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/2024 2:57 AM, Erni Sri Satya Vennela wrote:
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

Maybe it would be good to capture here the kind of VMs that this is
going to be not supported - HyperV based VMs. You mentioned it in cover
letter, but it would be good to add it here as well, as cover letter
does not go to git log.

Also, the subject suggests that we are disabling suspend-to-idle for
vmbus specifically, but from commit description, it suggests that
"suspend to idle" feature itself is no longer supported on these
particular VMs. Please rephrase it based on what exactly we are trying
to do here. IIUC, we are now returning an error (EOPNOTSUPP) in vmbus
driver callback, which insures that we don't support Suspend-to-Idle in
these VMs.

> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>   drivers/hv/vmbus_drv.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 965d2a4efb7e..4efd8856392f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -900,6 +900,19 @@ static void vmbus_shutdown(struct device *child_device)
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
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
>   /*
>    * vmbus_suspend - Suspend a vmbus device
>    */
> @@ -969,7 +982,7 @@ static void vmbus_device_release(struct device *device)
>    */
>   
>   static const struct dev_pm_ops vmbus_pm = {
> -	.suspend_noirq	= NULL,
> +	.suspend_noirq  = vmbus_freeze,
>   	.resume_noirq	= NULL,
>   	.freeze_noirq	= vmbus_suspend,

I am not sure if this is OK or how it works, but this naming scheme
seems a bit confusing to me -
*suspend* -> vmbus_*freeze*
*freeze* -> vmbus_*suspend*
and we are removing support for "freeze" by returning EOPNOTSUPP in
suspend callback.

I'll try to understand more on this, but just see if its OK.

>   	.thaw_noirq	= vmbus_resume,

Regards,
Naman

