Return-Path: <linux-hyperv+bounces-3650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1619A08236
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 22:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CE8188CC75
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC3204096;
	Thu,  9 Jan 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DYR3A681"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A344A1A;
	Thu,  9 Jan 2025 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736458115; cv=none; b=tAhH0bM965bZ4VBP0B5arJ8KydJ+MsZPaQhudagLfVP/rzX8Ezan+kJDnTYukWeWHUZjhGwi/NTKPl1h+Qkd9ZHVMV+/ZA3XH/Foo7AxH24e28S6dp6Jnrajmz8ZUa4hHmOd1SL7CqiqgNpjNsoj/EqJdZQYVYV72Rq5EFWQP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736458115; c=relaxed/simple;
	bh=Sa+TanbLcPQlosBYuH2TjHhMwWcxst6GNXMIbtsoiB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+pPj89HTiHzlSipI5qE1x4fkM2Bv7jFXR6YztDBnfWeM6v1NZbtSdfVk1BXjQNjWY0Pcm4O36A687yGT1vLppk/aBcF84UZDB+j2aZqUVplK0lzKhiVxc4yr80azqfN56BGdqeErWsrMgkMeRsJc33t9xTLZPnSLSF84d0sR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DYR3A681; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 89F75203E39C;
	Thu,  9 Jan 2025 13:28:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89F75203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736458113;
	bh=Y34WScxsiZ+BGxYt9+myxwdrqG7zPqMdGKoCowMWJZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DYR3A681PPEIR8DvOrYuK75gHwyXKBkRyeGdgrSH2DDLpXbSaQjCd50hYUT9sy9Tu
	 EcK0s//YpJbf+YW7xMenVaM4RcBqWjieWYOdY3Gh8/YrvVVghr2H7exNhfVMesBxrc
	 FhXZZqTPG2mMzjwAgCsbPUohPukaEpg4aFjGpuTQ=
Message-ID: <46c514c1-7ab5-47ca-b665-ab5ad418494a@linux.microsoft.com>
Date: Thu, 9 Jan 2025 13:28:33 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, tglx@linutronix.de, tiala@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <Z4Au-chfvfXCt-zq@liuwe-devbox-debian-v2>
 <ffef8f33-4d12-43d1-bd56-fd67978e2d8c@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <ffef8f33-4d12-43d1-bd56-fd67978e2d8c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/2025 12:28 PM, Nuno Das Neves wrote:
> On 1/9/2025 12:18 PM, Wei Liu wrote:
>> On Wed, Jan 08, 2025 at 02:21:33PM -0800, Roman Kisel wrote:
>> [...]
>>> Roman Kisel (5):
>>>    hyperv: Define struct hv_output_get_vp_registers
>>>    hyperv: Fix pointer type in get_vtl(void)
>>>    hyperv: Enable the hypercall output page for the VTL mode
>>>    hyperv: Do not overlap the hvcall IO areas in get_vtl()
>>>    hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
>>
>> The patches have been pushed to hyperv-next. Roman and Nuno, please
>> check the tree for correctness.
>>
>> Thanks,
>> Wei.
> 
> I checked, looks like the first two patches of the series are missing?
IIUC, they were to be rolled up into your earlier patches

> 
> Nuno

-- 
Thank you,
Roman


