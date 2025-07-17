Return-Path: <linux-hyperv+bounces-6278-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53890B09199
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0EB3B44E0
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CF52FC3D9;
	Thu, 17 Jul 2025 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SzA3lFda"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED562FC3AE;
	Thu, 17 Jul 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769314; cv=none; b=p0TBJDclnsUnQ/ABYANXmGGt/JqTzaauFy5JLPYgDZyxsrcGQk1Ead30UiXfsOJGRrulh9RdR2Kz5LBJn8RECeBolgnOBWBRGS5/CzCkeYmFE4OccVniJkMMTURUvtyV47oX25SIC6MRzcCrGnZdOO2JmOQRIjrq1F/TsPpriHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769314; c=relaxed/simple;
	bh=2pmx4VHDOfW7yUHLn0E6vYG5Rq+jiNJpfmJJNIOrGEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyPNEDlqBiZmYV/BrWyXWNH0NUP0DWvP5DImJBUVQNOF1b537kQi5OJ2kVhocwRHgZL6hMQARvvcFuVoxp3zhiJ0NyO7oOTR/lb8mS7qugtJOCJwHoTE459xE1qoVXlhxK/JNa1foKvirWeUAl4lxYyKc9uyXTO7txs45E0f01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SzA3lFda; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.225.6] (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 398AE211426B;
	Thu, 17 Jul 2025 09:21:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 398AE211426B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752769312;
	bh=7K0UPEjUxHWApQG9NiExsOn4DGOruZ9qlwBae9uaRRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SzA3lFda7i8ZDz++gtdU8oCWjkeUmebzAW85NcfPXgGg9V1tobU3mmv7GSG/GltBg
	 YKA0d8Y/633t0rndP/lnnadLSVU17ShO3OgTr/ZkHE6XUWV6TCHmVXguLvl4u6o9it
	 OABs4Lg/d8kUzRrUioRJexoggIA/3gEF8k2C4qRA=
Message-ID: <68143eb0-e6a7-4579-bedb-4c2ec5aaef6b@linux.microsoft.com>
Date: Thu, 17 Jul 2025 09:21:51 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250611072704.83199-1-namjain@linux.microsoft.com>
 <20250611072704.83199-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/2025 10:19 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, June 11, 2025 12:27 AM
>> +
>> +union mshv_synic_overlay_page_msr {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enabled: 1;
>> +		u64 reserved: 11;
>> +		u64 pfn: 52;
>> +	};
> 
> Since this appear to be a Hyper-V synthetic MSR, add __packed?
> 
>> +};
>> +
>> +union hv_register_vsm_capabilities {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 dr6_shared: 1;
>> +		u64 mbec_vtl_mask: 16;
>> +		u64 deny_lower_vtl_startup: 1;
>> +		u64 supervisor_shadow_stack: 1;
>> +		u64 hardware_hvpt_available: 1;
>> +		u64 software_hvpt_available: 1;
>> +		u64 hardware_hvpt_range_bits: 6;
>> +		u64 intercept_page_available: 1;
>> +		u64 return_action_available: 1;
>> +		u64 reserved: 35;
>> +	} __packed;
>> +};
>> +
>> +union hv_register_vsm_page_offsets {
>> +	struct {
>> +		u64 vtl_call_offset : 12;
>> +		u64 vtl_return_offset : 12;
>> +		u64 reserved_mbz : 40;
>> +	};
>> +	u64 as_uint64;
>> +} __packed;
> 
> We've usually put the __packed on the struct definition.  Consistency .... :-)
> 
> Don't these three register definitions belong somewhere in the
> hvhdk or hvgdk include files?
> 

I agree, hv_register_vsm_capabilities and hv_register_vsm_page_offsets
can be moved to the appropriate include/hyperv/ header/s.

Regarding mshv_synic_overlay_page_msr, it is a generic structure that
appears to be used for several overlay page MSRs (SIMP, SIEF, etc).

But, the type doesn't appear in the hv*dk headers explicitly; it's just
used internally by the hypervisor.

I think it should be renamed with a hv_ prefix to indicate it's part of
the hypervisor ABI, and a brief comment with the provenance:

/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
union hv_synic_overlay_page_msr {
	/* <snip> */
};

And I'm fine with it staying in this file since it's only used here right
now, and doesn't really come from the one of the hyperv headers.

Nuno

