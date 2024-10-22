Return-Path: <linux-hyperv+bounces-3179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4F59AB9BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 00:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBD2B22D07
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CCA1CDFDC;
	Tue, 22 Oct 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nzIskZBU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B51CDA16;
	Tue, 22 Oct 2024 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637893; cv=none; b=SiFMqYPcixHLZDDMBKZXiJ2k1tY3oCgvn8dkWqKw6uUAkaKIw3MxDB8wCfTzeBB/lSo3eURh45MmL+zNaG9F9ZcyXrC2O3U6UHotplgHrbzGwLn+QkOIu7bWwo/JfQwJFPjUlduP2DN72LvrVNDS1XNc1SkTU9b+N+itjJ+ux6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637893; c=relaxed/simple;
	bh=RjEJk2oa1fZBfOmIg47sxpgtVrqeY9azPMrxyyatXLQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OoYpO0CiX0NuwLVo/IXkKja+4Z9Vk73OTsJn0vye7t31+n49a2zOe0cHL97Uq6peWAkb0jsDGUveoKp6v9b0FlUBvyphtpnHWRdk6Lt3tKhyZZbl5bzrt1RbB9Bs+3TSSVPq46lmUp3ANLXZFLP7yy1edWtJNWdmC+vwRC6e49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nzIskZBU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.66.184] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA5A921112FB;
	Tue, 22 Oct 2024 15:58:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA5A921112FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729637891;
	bh=xYGQ40vmThJnX2ha30vWEW9paOxlmvOgxdDY6ngri1M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nzIskZBUa8r0DFv0dKwn4D6E0TxbOsLBT3iYSIOanvrS05amAy4922d272C1o9tmW
	 uTeNQ7F6IckvHsJHpAHe6Nl4b1LdQw/25+K/y8AI7jHJ7XWx6wxOo2s3VBgkiAGcW4
	 d8TI4D1Ck6deYTfELPuTAUvzhYMEoACxoNOJQDcQ=
Message-ID: <24981b4e-8ccb-4312-b738-e4b611739060@linux.microsoft.com>
Date: Tue, 22 Oct 2024 15:58:11 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
To: lkp@intel.com, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Linux-HyperV <linux-hyperv@vger.kernel.org>
References: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
 <20241022185353.2080021-2-eahariha@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241022185353.2080021-2-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/2024 11:53 AM, Easwar Hariharan wrote:
> We have several places where timeouts are open-coded as N (seconds) * HZ,
> but best practice is to use the utility functions from jiffies.h. Convert
> the timeouts to be compliant. This doesn't fix any bugs, it's a simple code
> improvement.
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/hv/hv_balloon.c  | 8 ++++----
>  drivers/hv/hv_kvp.c      | 4 ++--
>  drivers/hv/hv_snapshot.c | 3 ++-
>  drivers/hv/vmbus_drv.c   | 2 +-
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index c38dcdfcb914..79a72e68f427 100644
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
> @@ -1373,7 +1373,7 @@ static int dm_thread_func(void *dm_dev)
>  	struct hv_dynmem_device *dm = dm_dev;
>  
>  	while (!kthread_should_stop()) {
> -		wait_for_completion_interruptible_timeout(&dm_device.config_event, 1 * HZ);
> +		wait_for_completion_interruptible_timeout(&dm_device.config_event, secs_to_jiffies(1));
>  		/*
>  		 * The host expects us to post information on the memory
>  		 * pressure every second.
> @@ -1748,7 +1748,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
>  	if (ret)
>  		goto out;
>  
> -	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
> +	t = wait_for_completion_timeout(&dm_device.host_event, secs_to_jiffies(5));
>  	if (t == 0) {
>  		ret = -ETIMEDOUT;
>  		goto out;
> @@ -1806,7 +1806,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
>  	if (ret)
>  		goto out;
>  
> -	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
> +	t = wait_for_completion_timeout(&dm_device.host_event, secs_to_jiffies(5));
>  	if (t == 0) {
>  		ret = -ETIMEDOUT;
>  		goto out;
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index d35b60c06114..29e01247a087 100644
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
> index 0d2184be1691..86d87486ed40 100644
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
> index 9b15f7daf505..7db30881e83a 100644
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

Sorry, I should have combined distribution lists for the two patches, so
everyone received both patches. Combining the lists with this email.

Here's the lore link for the series:
https://lore.kernel.org/all/20241022185353.2080021-1-eahariha@linux.microsoft.com/

Thanks,
Easwar

