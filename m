Return-Path: <linux-hyperv+bounces-3420-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB479E7EC9
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C1A188646C
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04150823DE;
	Sat,  7 Dec 2024 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg0tlZl1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E522C6E3;
	Sat,  7 Dec 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557952; cv=none; b=JhSiEzlfNmbQLz7HCK4JH30QBVAUGTGfYgRlcXvgAPW3yFW+Ac1j/xeTweFbeM8uE3I5i0WuMcVUU33OnUGgkiCZFuaGgqxJ3OcAaVhFk0dVTOzMvXEJpbHMDpxw/gMc5JBzDVnnR8ND6b8uwjRVlOdxKC8PfgaD7qvyJNvyGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557952; c=relaxed/simple;
	bh=YfxPJKrlKjxpGhLML/BwqO5aO9pBwxt7Vy89lcbLLhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcEm09Vi6QVtxW5KOGHekHlCxoyrLevOjOULi9F7WMV1i5rMkQjW+OZXw5Z4zXzHCUy6wZe14ZWLboj8UUHsaRu5ropM7X/X4C0rmss9Lkol5PamOGdK4l8r5T+qwn5SYYq3MMK+45bkIY8511K/Rg9WMYTEPvZfuqCc6Mf2N84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg0tlZl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2A8C4CECD;
	Sat,  7 Dec 2024 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733557951;
	bh=YfxPJKrlKjxpGhLML/BwqO5aO9pBwxt7Vy89lcbLLhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg0tlZl1iOlF20EbDe13f0yeZR6zU/rII6L/KKnuhSDZ9YmaWDrh5HdbNly5oTgor
	 qieYU41VWk+V+3dg9gAmk5Uun4kaCc8tvZlK38U9Njxdai1ai1wOB2SbG/ajhTh8WZ
	 9insBzqqR1HxAGNR+9PMhzr0rkGa5jjVJXt9v7/PjKeNOo4WYuZVC+T9+0XQfQAldk
	 qQm5ke39uCG/DNS+bVHilbvrQh+tlT0i+R49/e8P4RcmO7pNZbKbe2BeWs2k8ty/8k
	 aqmO3ZGeBOdgY/T8NULK04ARbIbJMnwnn9abw0D0e4Cbk8wB8JAXvgSOF6ZixY82q5
	 fWodvHxaN0yzw==
Date: Sat, 7 Dec 2024 07:52:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Praveen Kumar <kumarpraveen@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
Message-ID: <Z1P-vf-5_Ai51QTA@liuwe-devbox-debian-v2>
References: <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
 <20241030-open-coded-timeouts-v3-2-9ba123facf88@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-open-coded-timeouts-v3-2-9ba123facf88@linux.microsoft.com>

On Wed, Oct 30, 2024 at 05:47:36PM +0000, Easwar Hariharan wrote:
> We have several places where timeouts are open-coded as N (seconds) * HZ,
> but best practice is to use the utility functions from jiffies.h. Convert
> the timeouts to be compliant. This doesn't fix any bugs, it's a simple code
> improvement.
> 
> TO: "K. Y. Srinivasan" <kys@microsoft.com>
> TO: Haiyang Zhang <haiyangz@microsoft.com>
> TO: Wei Liu <wei.liu@kernel.org>
> TO: Dexuan Cui <decui@microsoft.com>
> TO: linux-hyperv@vger.kernel.org
> TO: Anna-Maria Behnsen <anna-maria@linutronix.de>
> TO: Thomas Gleixner <tglx@linutronix.de>
> TO: Geert Uytterhoeven <geert@linux-m68k.org>
> TO: Marcel Holtmann <marcel@holtmann.org>
> TO: Johan Hedberg <johan.hedberg@gmail.com>
> TO: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> TO: linux-bluetooth@vger.kernel.org
> TO: linux-kernel@vger.kernel.org
> CC: Michael Kelley <mhklinux@outlook.com>

In the future you can put these items after the --- line, so that they
are stripped when the patch is applied.

> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

The first patch is already in.

I applied this patch to hyperv-fixes. Thanks.

> ---
>  drivers/hv/hv_balloon.c  | 9 +++++----
>  drivers/hv/hv_kvp.c      | 4 ++--
>  drivers/hv/hv_snapshot.c | 3 ++-
>  drivers/hv/vmbus_drv.c   | 2 +-
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index c38dcdfcb914dcc3515be100cba0beb4a3f9b975..a99112e6f0b8534cf5c8c963e343019061bd34f6 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -756,7 +756,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  		 * adding succeeded, it is ok to proceed even if the memory was
>  		 * not onlined in time.
>  		 */
> -		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
> +		wait_for_completion_timeout(&dm_device.ol_waitevent, secs_to_jiffies(5));
>  		post_status(&dm_device);
>  	}
>  }
> @@ -1373,7 +1373,8 @@ static int dm_thread_func(void *dm_dev)
>  	struct hv_dynmem_device *dm = dm_dev;
>  
>  	while (!kthread_should_stop()) {
> -		wait_for_completion_interruptible_timeout(&dm_device.config_event, 1 * HZ);
> +		wait_for_completion_interruptible_timeout(&dm_device.config_event,
> +								secs_to_jiffies(1));
>  		/*
>  		 * The host expects us to post information on the memory
>  		 * pressure every second.
> @@ -1748,7 +1749,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
>  	if (ret)
>  		goto out;
>  
> -	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
> +	t = wait_for_completion_timeout(&dm_device.host_event, secs_to_jiffies(5));
>  	if (t == 0) {
>  		ret = -ETIMEDOUT;
>  		goto out;
> @@ -1806,7 +1807,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
>  	if (ret)
>  		goto out;
>  
> -	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
> +	t = wait_for_completion_timeout(&dm_device.host_event, secs_to_jiffies(5));
>  	if (t == 0) {
>  		ret = -ETIMEDOUT;
>  		goto out;
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index d35b60c0611486c8c909d2f8f7c730ff913df30d..29e01247a0870fdb9eebd92bdd16fd371450240c 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -655,7 +655,7 @@ void hv_kvp_onchannelcallback(void *context)
>  		if (host_negotiatied == NEGO_NOT_STARTED) {
>  			host_negotiatied = NEGO_IN_PROGRESS;
>  			schedule_delayed_work(&kvp_host_handshake_work,
> -				      HV_UTIL_NEGO_TIMEOUT * HZ);
> +						secs_to_jiffies(HV_UTIL_NEGO_TIMEOUT));
>  		}
>  		return;
>  	}
> @@ -724,7 +724,7 @@ void hv_kvp_onchannelcallback(void *context)
>  		 */
>  		schedule_work(&kvp_sendkey_work);
>  		schedule_delayed_work(&kvp_timeout_work,
> -					HV_UTIL_TIMEOUT * HZ);
> +				      secs_to_jiffies(HV_UTIL_TIMEOUT));
>  
>  		return;
>  
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 0d2184be16912559a8cfa784c762e6418ebd3279..86d87486ed40b3ca9f6674650e5a86a7184e2fa6 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -193,7 +193,8 @@ static void vss_send_op(void)
>  	vss_transaction.state = HVUTIL_USERSPACE_REQ;
>  
>  	schedule_delayed_work(&vss_timeout_work, op == VSS_OP_FREEZE ?
> -			VSS_FREEZE_TIMEOUT * HZ : HV_UTIL_TIMEOUT * HZ);
> +				secs_to_jiffies(VSS_FREEZE_TIMEOUT) :
> +				secs_to_jiffies(HV_UTIL_TIMEOUT));
>  
>  	rc = hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
>  	if (rc) {
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 9b15f7daf5059750e17ea3607b52dee967c1c059..7db30881e83ad4b406413641413d68329fc663e2 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2507,7 +2507,7 @@ static int vmbus_bus_resume(struct device *dev)
>  	vmbus_request_offers();
>  
>  	if (wait_for_completion_timeout(
> -		&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
> +		&vmbus_connection.ready_for_resume_event, secs_to_jiffies(10)) == 0)
>  		pr_err("Some vmbus device is missing after suspending?\n");
>  
>  	/* Reset the event for the next suspend. */
> 
> -- 
> 2.34.1
> 

