Return-Path: <linux-hyperv+bounces-6966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F06B8B90E
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Sep 2025 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6881CC43C7
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0182D97AC;
	Fri, 19 Sep 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gU8/m8eP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205162D94B7;
	Fri, 19 Sep 2025 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321900; cv=none; b=JKTGhcQRljoW65/0bmsjlmy/DMdtxKPYk760uE8WJLM5JHRAMCeJ3OiIpMG1ywK9vMPVCAvYtkA56TLcb7qUOCla78ky+tmcLSlDCuZJzsfb+LRpjY9aPzGsEDAAobK4xNuVbLT+C+/SRe4steI90jqnT2GiJI/mDMMfHlxbyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321900; c=relaxed/simple;
	bh=PJwldsfvkWRk+/jymc6dF/H97iqcuzdBcvBDXWoqBL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEmL3MOYUt4LY5ghLlhFjy2aKzlJ1gX0b2nKPU8i8bS/CzR0PmArcZU7M93nzjD8Q2KZ1pXsw8rkVruT9awenZj5Y+FNcvwE7KdzfqJCvCT9S1ZGZ82RXIZvfPRXEfMC09pe0mgGSs4myp0Z2pVokNkuG+QKG0d8QpJ2GnFRN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gU8/m8eP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.193.225] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3594F2018E6A;
	Fri, 19 Sep 2025 15:44:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3594F2018E6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758321898;
	bh=W7ObVF+H+rGR8iIdFsHqoTyyXX+GcheBvXyIRPKXfYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gU8/m8ePc+dA492zyqYzbe1zCZR1PHM8tqiS2SPAvw3ec/MiT93R6gIFrkhvUXIlA
	 oDVxxB35EOeCYo50Cvnf/E42dJNxGF3i0UEsjGOSvo7xtTaz73U0qoQsZNB5ymg1GA
	 ZnBE1R70/MMaDSpKkYhfGn3gjksi0OKOXvppqruI=
Message-ID: <43d27c68-f92f-4236-830d-9f28a1b52931@linux.microsoft.com>
Date: Fri, 19 Sep 2025 15:44:56 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mshv: Introduce new hypercall to map stats page
 for L1VH partitions
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 tiala@microsoft.com, anirudh@anirudhrb.com,
 paekkaladevi@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com,
 Jinank Jain <jinankjain@linux.microsoft.com>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-6-git-send-email-nunodasneves@linux.microsoft.com>
 <aMxjORzTO0DgWq9q@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aMxjORzTO0DgWq9q@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/2025 12:53 PM, Stanislav Kinsburskii wrote:
> On Tue, Sep 16, 2025 at 04:44:22PM -0700, Nuno Das Neves wrote:
>> From: Jinank Jain <jinankjain@linux.microsoft.com>
>>
> 
> <snip>
> 
>> +static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>> +				   const union hv_stats_object_identity *identity,
>> +				   u64 map_location)
>> +{
>> +	unsigned long flags;
>> +	struct hv_input_map_stats_page2 *input;
>> +	u64 status;
>> +	int ret;
>> +
>> +	if (!map_location || !mshv_use_overlay_gpfn())
>> +		return -EINVAL;
>> +
>> +	do {
>> +		local_irq_save(flags);
>> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +
>> +		memset(input, 0, sizeof(*input));
>> +		input->type = type;
>> +		input->identity = *identity;
>> +		input->map_location = map_location;
>> +
>> +		status = hv_do_hypercall(HVCALL_MAP_STATS_PAGE2, input, NULL);
>> +
>> +		local_irq_restore(flags);
>> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>> +			if (hv_result_success(status))
>> +				break;
>> +			hv_status_debug(status, "\n");
> 
> It looks more natural to check for success first and break the loop, and
> only then handle errors.
> Maybe even set ret for both success and error messages and break and
> handle only the unsufficient memory status.
> 

Something like this?

	local_irq_restore(flags);

	ret = hv_result_to_errno(status);

	if (!ret)
		break;

	if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
		hv_status_debug(status, "\n");
		break;
	}

	ret = hv_call_deposit_pages(NUMA_NO_NODE,
				    hv_current_partition_id, 1);

>> @@ -865,6 +931,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>>  	return hv_result_to_errno(status);
>>  }
>>  
>> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
>> +			const union hv_stats_object_identity *identity)
>> +{
> 
> Should this function be type of void?
> 

The return type is consistent with the other hypercall helpers. It's true that
in practice we don't ever check if the unmap succeeded. I think it's fine as-is.

> Thanks,
> Stanislav


