Return-Path: <linux-hyperv+bounces-7644-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE884C65AEA
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 19:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A429C23F5C
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A63112BD;
	Mon, 17 Nov 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kMlCDQsy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB70B31064E;
	Mon, 17 Nov 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403389; cv=none; b=AgafSNbc7DVH6/jXPRL7zz35eY2ZFgDmj7nkKHPLuqIAObNAHrYxgXfLpvbEDIoUpWPZcRW1wkHaSdvcf7/AKdmJnUvz485sACB/0ffZnLjQZ7gN5jd35bCdxB1vgfTmmbG0xa+fDY+gpu5fHGM0jCr99gkQZF37ZdQS+Co0m5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403389; c=relaxed/simple;
	bh=kWfdHP6m2E51H1saTfbxLEY+fI8WDnJy6dCu59NfIW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyrb/jNSGK6U/QR06yMnW5BXGs4iW/8+duyjyBEVX/ihRsJpT6/JHCSEi9eXUbbANMsHG13uAMq2gHVAgRVz2HkamxW4Kb3VZPtJg6vD+moaPy3bPftfnagrdPlnoAUuJwg3LD0X5+laf5C0SgRyYMDF73UL3xlnpVFNVH5tF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kMlCDQsy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.192.165] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E4885207F5BC;
	Mon, 17 Nov 2025 10:16:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4885207F5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763403386;
	bh=0UxGJU6+ymXu5Y2E6kPRodFlaHcL8ZpimKgud6kelVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kMlCDQsyF7saqakIuMFz9GVWdjL1Gy0hk9QEl2c2Soc3qQeHWghxDyoN9dxRDkEh7
	 Vf5h/vEfQEm4Wq5aGStO9UPSChwubg+ovLIxTbsoXb2rE43vARNR3NYBFpLW0T+5K+
	 1Gut2UqxJ24wJFGBd8817mDATQ+uvq6YsWWezots=
Message-ID: <36ac7105-3aa7-4e53-b87d-b99438f65295@linux.microsoft.com>
Date: Mon, 17 Nov 2025 10:16:12 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
To: Anirudh Rayabharam <anirudh@anirudhrb.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117095207.113502-1-anirudh@anirudhrb.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251117095207.113502-1-anirudh@anirudhrb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/2025 1:52 AM, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> execute a passthrough hypercall targeting the root/parent partition
> i.e. HV_PARTITION_ID_SELF.
> 

I think it's worth taking a moment to check and perhaps explain in
the commit message/a comment any security implications of the VMM
process being able to call these hypercalls on the root/parent
partition.

One implication would be: can the VMM process influence other
processes in the root partition via these hypercalls,
e.g. HVCALL_SET_VP_REGISTERS? I would think that the hypervisor
itself disallows this but we should check. We can ask the
hypervisor team what they think, and check the hypervisor code.

Specifically we should check on any hypercall that could possibly
influence partition state, i.e.:
HVCALL_SET_PARTITION_PROPERTY
HVCALL_SET_VP_REGISTERS
HVCALL_INSTALL_INTERCEPT
HVCALL_CLEAR_VIRTUAL_INTERRUPT
HVCALL_REGISTER_INTERCEPT_RESULT
HVCALL_ASSERT_VIRTUAL_INTERRUPT
HVCALL_SIGNAL_EVENT_DIRECT
HVCALL_POST_MESSAGE_DIRECT

If it turns out there is something risky we are enabling here, we can
introduce a new array of hypercalls to restrict which ones can be
called on HV_PARTITION_ID_SELF.

> This will be useful for the VMM to query things like supported
> synthetic processor features, supported VMM capabiliites etc.
> 
> While at it, add HVCALL_GET_PARTITION_PROPERTY_EX to the allowed list of
> passthrough hypercalls.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
> 
> v2: rebased on latest hyperv-next
> 
> ---
>  drivers/hv/mshv_root_main.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 45c7a5fea1cf..671c4d18520a 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -122,6 +122,7 @@ static struct miscdevice mshv_dev = {
>   */
>  static u16 mshv_passthru_hvcalls[] = {
>  	HVCALL_GET_PARTITION_PROPERTY,
> +	HVCALL_GET_PARTITION_PROPERTY_EX,
>  	HVCALL_SET_PARTITION_PROPERTY,
>  	HVCALL_INSTALL_INTERCEPT,
>  	HVCALL_GET_VP_REGISTERS,
> @@ -160,6 +161,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  	void *input_pg = NULL;
>  	void *output_pg = NULL;
>  	u16 reps_completed;
> +	u64 pt_id = partition ? partition->pt_id : HV_PARTITION_ID_SELF;
>  
>  	if (copy_from_user(&args, user_args, sizeof(args)))
>  		return -EFAULT;
> @@ -181,7 +183,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  	is_async = mshv_hvcall_is_async(args.code);
>  	if (is_async) {
>  		/* async hypercalls can only be called from partition fd */
> -		if (!partition_locked)
> +		if (!partition || !partition_locked)
>  			return -EINVAL;
>  		ret = mshv_init_async_handler(partition);
>  		if (ret)
> @@ -209,7 +211,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  	 * NOTE: This only works because all the allowed hypercalls' input
>  	 * structs begin with a u64 partition_id field.
>  	 */
> -	*(u64 *)input_pg = partition->pt_id;
> +	*(u64 *)input_pg = pt_id;
>  
>  	reps_completed = 0;
>  	do {
> @@ -238,7 +240,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  			ret = hv_result_to_errno(status);
>  		else
>  			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> -						    partition->pt_id, 1);
> +						    pt_id, 1);

nit: Can these arguments just all go on a single line now?

>  	} while (!ret);
>  
>  	args.status = hv_result(status);
> @@ -2050,6 +2052,9 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
>  	case MSHV_CREATE_PARTITION:
>  		return mshv_ioctl_create_partition((void __user *)arg,
>  						misc->this_device);
> +	case MSHV_ROOT_HVCALL:
> +		return mshv_ioctl_passthru_hvcall(NULL, false,
> +					(void __user *)arg);
>  	}
>  
>  	return -ENOTTY;
> 
> base-commit: db7df69995ffbe806d60ad46d5fb9d959da9e549


