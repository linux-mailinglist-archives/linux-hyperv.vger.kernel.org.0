Return-Path: <linux-hyperv+bounces-3182-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317D79ABDFA
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 07:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E167C2845D3
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 05:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E19146A68;
	Wed, 23 Oct 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ahp2bPpy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444E145323;
	Wed, 23 Oct 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661811; cv=none; b=emGruYJPq3Inf5mN3yTD9XTm27ycdq06V7T6igArbtaJgSc6UsZanSb5Zt4EKfKbv0iPL2eD3cD0OAnu1oKBgqs6/DT3pE6cg/B9QkmXa+wWZwrc9wEDWfDLaUkFjj9HqIg59E7m9xmkhWQjiiqjZE8otz/Wt2s+SX+jWMm19KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661811; c=relaxed/simple;
	bh=nHh8XH49vVlMru+gUFUY4rnlojUb00w0vAvuhjIqWLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMKKyv1WA/pdhL/w09FwwFxrkTY8TIKClR9OQrpSlrzFr/seGupn02RkHxwyaJXdM1X5BFE89qIQt46WmWikfDn9ymXdMWZUah1N0gOQrNPyUpRiQtDOfvW6GgZMIrXqyvbrLAEnn0RhGATgTp89myd0vZj7m3q147UJe2cVR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ahp2bPpy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.200.232] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id A3B562111305;
	Tue, 22 Oct 2024 22:36:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3B562111305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729661809;
	bh=cCR5SgddHSgQhocwCPSPrQbk4OgDv/0VPzM6jDMobS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ahp2bPpy9rCwmd9ypj2JzlqNGEKUCqOLQ9K09uwxUk7mqzHWiZISGuvkZrywKGMbJ
	 XCunhoMK9Oof/V0kAtrmRmf/d0zz0l5rytIBBpbECTNwPiDZfFv1gF17WJIokJvBeM
	 UH2ExUxEh2pSrV/kCBlnYSAz//QMM+WIQ3nwF8rw=
Message-ID: <288243cd-51d9-4c76-8337-298e9bf339d5@linux.microsoft.com>
Date: Wed, 23 Oct 2024 11:06:44 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>, lkp@intel.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>
References: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
 <20241022185353.2080021-2-eahariha@linux.microsoft.com>
Content-Language: en-GB
From: Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <20241022185353.2080021-2-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-10-2024 00:23, Easwar Hariharan wrote:
> We have several places where timeouts are open-coded as N (seconds) * HZ,
> but best practice is to use the utility functions from jiffies.h. Convert
> the timeouts to be compliant. This doesn't fix any bugs, it's a simple code
> improvement.
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

I think this is second version of this patch series?

Please make sure, you update the patch version details and document the changes done in the current version.

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


