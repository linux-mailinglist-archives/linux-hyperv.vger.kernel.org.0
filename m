Return-Path: <linux-hyperv+bounces-6964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F691B8B78D
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Sep 2025 00:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154E85A7A9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CE227EB9;
	Fri, 19 Sep 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lq+H0tHS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049BF72614;
	Fri, 19 Sep 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321043; cv=none; b=mR610CMaFVkZK/SNmG8Yzpo0Ha9acYWORl85p8dpfFlCCpP5kahQJM33hWPcDCe1g0V65HvMgzEW4RCfyUD/jjVnJbszyD7zhoeOT15SV/dN1dL/zUHPkA6G7xJJG+8ztr9mH0DSoRstAchHyrK4wZCMEFkmeiVnOZXs3/n28w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321043; c=relaxed/simple;
	bh=sawOJ1zTO4aII3OzWWer4DF1EuV3/VGv01emBZK6NGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5fCdRn6qIshwr+L+LxUzsB8q3gyxxAjMjb37ngLVO4UKKjSztaLkzOrLUGRA9kxAJV7lmU5ipti886OMRODD8C9+pp1k11/4T3SCNJnN+evfD6c3/I/tZzpb4A3qE7nlVO5CSd+x2tpBMykYBemUb99lpCTEJqQAcWo7dmNyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lq+H0tHS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.193.225] (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id B7F11211AF15;
	Fri, 19 Sep 2025 15:30:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7F11211AF15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758321041;
	bh=uik2M006grDdgUEFgCvLWE5tQ/yxvwycaM/c9wks33I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lq+H0tHSRQGlvICepUqYKjKfK5hSWBFBOytIy+6EIYn/x0u0mibyQ4MmBYersJjiz
	 WkOuUVOPsOX1XoHzHNGQ9q7qup0EU0EzT2iarIeCcnVp/zeclpevLbbTk923GwNL/P
	 QShW5XBkrk45r17DKmy+KAkmHDey5R2RcKziJNbI=
Message-ID: <350e4429-46e5-4011-89c5-85de442e8ddb@linux.microsoft.com>
Date: Fri, 19 Sep 2025 15:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 tiala@microsoft.com, anirudh@anirudhrb.com,
 paekkaladevi@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-3-git-send-email-nunodasneves@linux.microsoft.com>
 <aMxS7Wh67SuF4LV2@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aMxS7Wh67SuF4LV2@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/2025 11:43 AM, Stanislav Kinsburskii wrote:
> On Tue, Sep 16, 2025 at 04:44:19PM -0700, Nuno Das Neves wrote:
> 
> <snip>
> 
>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>> index b4067ada02cf..b91358b9c929 100644
>> --- a/include/hyperv/hvhdk.h
>> +++ b/include/hyperv/hvhdk.h
>> @@ -376,6 +376,46 @@ struct hv_input_set_partition_property {
>>  	u64 property_value;
>>  } __packed;
>>  
>> +union hv_partition_property_arg {
>> +	u64 as_uint64;
>> +	struct {
>> +		union {
>> +			u32 arg;
>> +			u32 vp_index;
>> +		};
>> +		u16 reserved0;
>> +		u8 reserved1;
>> +		u8 object_type;
>> +	};
>> +} __packed;
> 
> Shouldn't the struct be "packed" instead?
> 
Indeed, I'll fix it, thanks.

>> +
>> +struct hv_input_get_partition_property_ex {
>> +	u64 partition_id;
>> +	u32 property_code; /* enum hv_partition_property_code */
>> +	u32 padding;
>> +	union {
>> +		union hv_partition_property_arg arg_data;
>> +		u64 arg;
>> +	};
>> +} __packed;
>> +
>> +/*
>> + * NOTE: Should use hv_input_set_partition_property_ex_header to compute this
>> + * size, but hv_input_get_partition_property_ex is identical so it suffices
>> + */
>> +#define HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE \
>> +	(HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_partition_property_ex))
>> +
>> +union hv_partition_property_ex {
>> +	u8 buffer[HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE];
>> +	struct hv_partition_property_vmm_capabilities vmm_capabilities;
>> +	/* More fields to be filled in when needed */
>> +} __packed;
> 
> Packing a union is redundant.
> 
> Thanks,
> Stanislav


