Return-Path: <linux-hyperv+bounces-8933-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBsBHm2wmGm3KwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8933-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 20:05:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76316A3ED
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 20:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ECB13004F12
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 19:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701723570C8;
	Fri, 20 Feb 2026 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EBhKB4kj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378EC86353;
	Fri, 20 Feb 2026 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614315; cv=none; b=aPBlHOkA8KW2ILiyGbMqbSrgC0YdoWvMGE/GgKassm1POrGIQNTTbu+MWJ+s9jBWV7YDilOky7jnnnz4m8Utqq0E2N/qE7u/xEn7n27STLgeBmrebWWzYhkmcaDj3D+bjcq25TPjHxtuJSN+6IbpcNvjMycsKYsje+ie4lhMKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614315; c=relaxed/simple;
	bh=NmbpSPS5c+mR01/JELmz/BYpgUblNSYPQdT3Cfqw3Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVTDBFx8Wji/Fd4GevzSTOmN0RNNURKl21AleUfa6Fejk/wogqJJAA+/g/q0oQ6ShssmVM0EyxeURXKi2psBHHN7y+2LFzHzlScsVOXTt3L+XINctVx0bg6YKeQf3HCPkWb6S24QyXR0nqd5c2rxwY/l2xHYKdsEp1JsPI/Clos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EBhKB4kj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A493320B6F00;
	Fri, 20 Feb 2026 11:05:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A493320B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771614312;
	bh=n1eR/TSb6lDeEHiLM9p8iqsFMQxKEMu2G3DyBK3A2VY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EBhKB4kjgiwprMsOypoS//btwJQzuUkYgP79dJcLjQlLVp/QPEKwJcdGnTsDQct4l
	 NxjvA6jAyhTfnq5gDAXaMN2wI1EQnbwgptU9sXq4+TeR0CcvlJdkxpJ503EmrAM5Tl
	 STNOOZR/5jycPmbpPCFqP0BPCXjjIQm3HpkIKx8U=
Message-ID: <8d868dc5-f7af-eff9-0405-bbaccbac7771@linux.microsoft.com>
Date: Fri, 20 Feb 2026 11:05:11 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: Replace fixed memory deposit with status driven
 helper
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415705AA10C44D52CFFC0D31D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415705AA10C44D52CFFC0D31D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8933-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com,microsoft.com,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 1A76316A3ED
X-Rspamd-Action: no action

On 2/20/26 09:05, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, February 19, 2026 2:10 PM
>>
>> Replace hardcoded HV_MAP_GPA_DEPOSIT_PAGES usage with
>> hv_deposit_memory() which derives the deposit size from
>> the hypercall status, and remove the now-unused constant.
>>
>> The previous code always deposited a fixed 256 pages on
>> insufficient memory, ignoring the actual demand reported
>> by the hypervisor.
> 
> Does the hypervisor report a specific page count demand? I haven't
> seen that anywhere. It seems like the deposit memory operation is
> always something of a guess.
> 
>> hv_deposit_memory() handles different
>> deposit statuses, aligning map-GPA retries with the rest
>> of the codebase.
>>
>> This approach may require more allocation and deposit
>> hypercall iterations, but avoids over-depositing large
>> fixed chunks when fewer pages would suffice. Until any
>> performance impact is measured, the more frugal and
>> consistent behavior is preferred.
>>
>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
>  From a purely functional standpoint, this change addresses the
> concern that I raised. But I don?t have any intuition on the performance
> impact of having to iterate. hv_deposit_memory() adds only a single

Indeed, it is not insignificant. Some discussions with hyp team while
ago had resulted in suggestions around depositing larger sizes, but then
there are many places where single page suffices. This is just lateral
change. But as this thing bakes, heuristics will evolve and we'll do
some optimizations aroud it... my 2 cents...

Thanks,
-Mukesh



> page for some of the statuses, so if there really is a large memory need,
> the new code would iterate 256 times to achieve what the existing code
> does.
> 
> Any idea where the 256 came from the first place?  Was that
> empirically determined like some of the other memory deposit counts?
> 
> In addition to a potential performance impact, I know the hypervisor tries
> to detect denial-of-service attempts that make "too many" calls to the
> hypervisor in a short period of time. In such a case, the hypervisor
> suspends scheduling the VM for a few seconds before allowing it to resume.
> Just need to make sure the hypervisor doesn't think the iterating is a
> denial-of-service attack. Or maybe that denial-of-service detection
> doesn't apply to the root partition VM.
> 
> But from a functional standpoint,
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
>> ---
>>   drivers/hv/mshv_root_hv_call.c |    4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index 7f91096f95a8..317191462b63 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -16,7 +16,6 @@
>>
>>   /* Determined empirically */
>>   #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>> -#define HV_MAP_GPA_DEPOSIT_PAGES	256
>>   #define HV_UMAP_GPA_PAGES		512
>>
>>   #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
>> @@ -239,8 +238,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64
>> page_struct_count,
>>   		completed = hv_repcomp(status);
>>
>>   		if (hv_result_needs_memory(status)) {
>> -			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
>> -						    HV_MAP_GPA_DEPOSIT_PAGES);
>> +			ret = hv_deposit_memory(partition_id, status);
>>   			if (ret)
>>   				break;
>>
>>
>>
> 


