Return-Path: <linux-hyperv+bounces-8363-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9DD39DC5
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 06:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0BFC3004C8C
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 05:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7764022D7B5;
	Mon, 19 Jan 2026 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SIdS7Uxu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3350913A3F7;
	Mon, 19 Jan 2026 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800733; cv=none; b=TfJtvwPg2/+/fHzIHv6+8CtoPVk5JFfzIWu5juZ1T2Gr4Rs8iraXDAxzHNKHntNSexWZVvy/aP+sWC2Ht81Xgc4BU5kcy/QjT+viU96fb/V1BGkAfL6vtlm8EVxFzMVVzAJqSmnjsbtoWbl/MzVVeXAN9Ha0uZAWy/eeRJY4ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800733; c=relaxed/simple;
	bh=vcxZyqhXu4FXcTnseZkbn/69VYu0FkpWyVajg8z1Um0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGUuh2tNn2MysQFZmsVJkrOCV3QgqEbdEM5jPdLHyms9D4RjvX3ya20GoMwAQz7GLgzH/B4d3z9YNdFKwQ5dVXDQ0Xe8SanPGorjjLlPxROUMpGXgFg5VGHeZfBPXEo+foEvqSPkG786aYBYmT7Vj5GWgXWla8YlfjZG9gSx8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SIdS7Uxu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.64.228] (unknown [167.220.238.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A0C520B7165;
	Sun, 18 Jan 2026 21:32:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A0C520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768800726;
	bh=46n0RtNfza/Uxw0tK0YGNA9XabyZQJN2SC83ScqMy2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SIdS7UxuVkgSfH15I9QTkc0U55NgdTo+9hXTl3A8yTLr0HBXVLh+SLKhGtybdVlS4
	 suFEyqZBsUa2otp+anqMFIho3790E8UkJiJMvLZ2Rk9uozGSwJv83BMExKYYXZ2zYR
	 MESmDlyZ4njnybQ2SH1MaxqYPfTYePVgLmXtrRcg=
Message-ID: <e99513ac-a790-424b-9b80-4a91fd87cba2@linux.microsoft.com>
Date: Mon, 19 Jan 2026 11:02:01 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mshv: Fix compiler warning about cast converting
 incompatible function type
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260118170245.160050-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260118170245.160050-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/2026 10:32 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In mshv_vtl_sint_ioctl_pause_msg_stream(), the reference to function
> mshv_vtl_synic_mask_vmbus_sint() is cast to type smp_call_func_t. The
> cast generates a compiler warning because the function signature of
> mshv_vtl_synic_mask_vmbus_sint() doesn't match smp_call_func_t.
> 
> There's no actual bug here because the mis-matched function signatures
> are compatible at runtime. Nonetheless, eliminate the compiler warning
> by changing the function signature of mshv_vtl_synic_mask_vmbus_sint()
> to match what on_each_cpu() expects. Remove the cast because it is then
> no longer necessary.
> 
> No functional change.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601170352.qbh3EKH5-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>   drivers/hv/mshv_vtl_main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 2cebe9de5a5a..7bbbce009732 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -845,9 +845,10 @@ static const struct file_operations mshv_vtl_fops = {
>   	.mmap = mshv_vtl_mmap,
>   };
>   
> -static void mshv_vtl_synic_mask_vmbus_sint(const u8 *mask)
> +static void mshv_vtl_synic_mask_vmbus_sint(void *info)
>   {
>   	union hv_synic_sint sint;
> +	const u8 *mask = info;
>   
>   	sint.as_uint64 = 0;
>   	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> @@ -999,7 +1000,7 @@ static int mshv_vtl_sint_ioctl_pause_msg_stream(struct mshv_sint_mask __user *ar
>   	if (copy_from_user(&mask, arg, sizeof(mask)))
>   		return -EFAULT;
>   	guard(mutex)(&vtl2_vmbus_sint_mask_mutex);
> -	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
> +	on_each_cpu(mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
>   	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask != 0);
>   	if (mask.mask)
>   		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);

Thank you Michael for fixing this.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>


