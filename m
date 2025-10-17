Return-Path: <linux-hyperv+bounces-7247-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815D6BEB100
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A3F3A5B65
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8D30498F;
	Fri, 17 Oct 2025 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JDs6UBPa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6312874F6;
	Fri, 17 Oct 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721942; cv=none; b=DBIUx4VyN2m2vNs/g4dIkH0K28QbTQC6Pd4d1lZuL1JdTFD/uY/wSf3eIP7VzWdEpBa6/DrpOvhVTnY3OK24Wvucah8pLv7sBq+1SMrLqRD3CclugC7fTbUxV3HqqH/qqHlhjR/mwIN+jOCWPagubO83UwG81w+Ucazr255YEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721942; c=relaxed/simple;
	bh=gz67lVUU0hjFYaasZgCQWH4O/hT/4DosqAavCeCKTUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3BBm9ofQ70jQQ/imRgB/n3aT3RIFRrg7f6+VlvkVPdwyCmdukddshuWhPC5bjIiu1Hhdcgjlnz3JMeKEHc71T2IcsqiUCOngaEYdM7/CtigHLhSjzEgh/eu5txWwcxFg+7xvDGTw+SvQuM2diYCm8qXvHQhj9JIrEEOWsfUtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JDs6UBPa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.65.40] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 17F422017268;
	Fri, 17 Oct 2025 10:25:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17F422017268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760721940;
	bh=PMb5Y7BfOY+/Qx//pfh9da9WjevbUCU/iRoalCjzV1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JDs6UBPaDZZtO7ZLltKF5QSsdaX4iBPeaWECyIvnAkDjUII+u6bdbVartw3V+kMeQ
	 UMFl6PXSSZfIPl4gTWyONOaww3JHJ+3qneEqZgBge23hq7OS61zVSPOcC34HNeLKHw
	 WyyPH2vXcSjbFsA4sbb3zAI8HF/mWqlfsTwzzJ3s=
Message-ID: <a0090bbf-08b4-4b36-8cf2-18687a83ee8f@linux.microsoft.com>
Date: Fri, 17 Oct 2025 10:25:39 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "mrathor@linux.microsoft.com"
 <mrathor@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
References: <1760644436-19937-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E6D02773A9D7A4B9E85BD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E6D02773A9D7A4B9E85BD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2025 6:12 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, October 16, 2025 12:54 PM
>>
>> When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
>> HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
>> -EAGAIN to userspace.
>>
>> However, it's much easier and efficient if the driver simply deposits
>> memory on demand and immediately retries the hypercall as is done with
>> all the other hypercall helper functions.
>>
>> But unlike those, in MSHV_ROOT_HVCALL the input is opaque to the
>> kernel. This is problematic for rep hypercalls, because the next part
>> of the input list can't be copied on each loop after depositing pages
>> (this was the original reason for returning -EAGAIN in this case).
>>
>> Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
>> parameter. This solves the issue, allowing the deposit loop in
>> MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
>> partway through.
> 
>>From reading the above, I'm pretty sure this code change is an
> optimization that lets user space avoid having to deal with the
> -EAGAIN result by resubmitting the ioctl with a different
> starting point for a rep hypercall. As such, I'd suggest the patch
> title should be "Improve deposit memory ...." (or something similar).
> The word "Fix" makes it sound like a bug fix.
> 
> Or is user space code currently faulty in its handling of -EAGAIN, and
> this really is an indirect bug fix to make things work? If so, do you
> want a Fixes: tag so the change is backported?
> 

It's the latter case, userspace doesn't handle it correctly, so I
consider it a fix more than just an improvement.

I'll add a Fixes: tag pointing back to the original /dev/mshv patch.

>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root_main.c    | 52 ++++++++++++++++++++--------------
>>  include/asm-generic/mshyperv.h | 14 +++++++--
>>  2 files changed, 42 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 9ae67c6e9f60..731ec8cbbd63 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -159,6 +159,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>>  	unsigned int pages_order;
>>  	void *input_pg = NULL;
>>  	void *output_pg = NULL;
>> +	u16 reps_completed;
>>
>>  	if (copy_from_user(&args, user_args, sizeof(args)))
>>  		return -EFAULT;
>> @@ -210,28 +211,35 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>>  	 */
>>  	*(u64 *)input_pg = partition->pt_id;
>>
>> -	if (args.reps)
>> -		status = hv_do_rep_hypercall(args.code, args.reps, 0,
>> -					     input_pg, output_pg);
>> -	else
>> -		status = hv_do_hypercall(args.code, input_pg, output_pg);
>> -
>> -	if (hv_result(status) == HV_STATUS_CALL_PENDING) {
>> -		if (is_async) {
>> -			mshv_async_hvcall_handler(partition, &status);
>> -		} else { /* Paranoia check. This shouldn't happen! */
>> -			ret = -EBADFD;
>> -			goto free_pages_out;
>> +	reps_completed = 0;
>> +	do {
>> +		if (args.reps) {
>> +			status = hv_do_rep_hypercall_ex(args.code, args.reps,
>> +							0, reps_completed,
>> +							input_pg, output_pg);
>> +			reps_completed = hv_repcomp(status);
>> +		} else {
>> +			status = hv_do_hypercall(args.code, input_pg, output_pg);
>>  		}
>> -	}
>>
>> -	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
>> -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
>> -		if (!ret)
>> -			ret = -EAGAIN;
>> -	} else if (!hv_result_success(status)) {
>> -		ret = hv_result_to_errno(status);
>> -	}
>> +		if (hv_result(status) == HV_STATUS_CALL_PENDING) {
>> +			if (is_async) {
>> +				mshv_async_hvcall_handler(partition, &status);
>> +			} else { /* Paranoia check. This shouldn't happen! */
>> +				ret = -EBADFD;
>> +				goto free_pages_out;
>> +			}
>> +		}
>> +
>> +		if (hv_result_success(status))
>> +			break;
>> +
>> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
>> +			ret = hv_result_to_errno(status);
>> +		else
>> +			ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> +						    partition->pt_id, 1);
>> +	} while (!ret);
>>
>>  	/*
>>  	 * Always return the status and output data regardless of result.
> 
> This comment about always returning the output data is now incorrect.
> 

Thanks, I'll fix it

>> @@ -240,11 +248,11 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>>  	 * succeeded.
>>  	 */
>>  	args.status = hv_result(status);
>> -	args.reps = args.reps ? hv_repcomp(status) : 0;
>> +	args.reps = reps_completed;
>>  	if (copy_to_user(user_args, &args, sizeof(args)))
>>  		ret = -EFAULT;
>>
>> -	if (output_pg &&
>> +	if (!ret && output_pg &&
>>  	    copy_to_user((void __user *)args.out_ptr, output_pg, args.out_sz))
>>  		ret = -EFAULT;
>>
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index ebf458dbcf84..31a209f0e18f 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -128,8 +128,9 @@ static inline unsigned int hv_repcomp(u64 status)
>>   * Rep hypercalls. Callers of this functions are supposed to ensure that
>>   * rep_count and varhead_size comply with Hyper-V hypercall definition.
> 
> Nit: This comment could be updated to include the new "rep_start"
> parameter.
> 

Thanks, will add

>>   */
>> -static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>> -				      void *input, void *output)
>> +static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
>> +					 u16 varhead_size, u16 rep_start,
>> +					 void *input, void *output)
>>  {
>>  	u64 control = code;
>>  	u64 status;
>> @@ -137,6 +138,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>>
>>  	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
>>  	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
>> +	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
>>
>>  	do {
>>  		status = hv_do_hypercall(control, input, output);
>> @@ -154,6 +156,14 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>>  	return status;
>>  }
>>
>> +/* For the typical case where rep_start is 0 */
>> +static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>> +				      void *input, void *output)
>> +{
>> +	return hv_do_rep_hypercall_ex(code, rep_count, varhead_size, 0,
>> +				      input, output);
>> +}
>> +
>>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
>>  static inline u64 hv_generate_guest_id(u64 kernel_version)
>>  {
> 
> Overall, this looks good to me. I don't see any issues with the code.
> 
> Michael


