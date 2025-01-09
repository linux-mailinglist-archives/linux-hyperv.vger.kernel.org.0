Return-Path: <linux-hyperv+bounces-3653-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D002A082AE
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5A63A7476
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5C204689;
	Thu,  9 Jan 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K9dmIeYS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78612F43;
	Thu,  9 Jan 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461157; cv=none; b=n6V9pdHLq4a38mc/RgMoB0q00S/kCMBpf6uGWxXbTbu/65KOu41sFbu0NpdzU3pNF34DgKBx/G3DQFNVg6QxHm/2uRFs3IbQO7VbTGyTnF/iltw6Oq8EWIQVfNwtdpQiN9/mCapZmqfb3dd/+/0Q63+YlMb0wGGTCXOADcjJFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461157; c=relaxed/simple;
	bh=6ojVxxJPeSMyNVSWEcMDl+B3MCTGjMkDjupMWGyK0pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Re10Pq69dCSjRT5QqU29JSJAEGvJXE6pE8mkYthBR7AXmgeYgBaZIhMcBkGzThyB+HdmEoZIVkTfo9HVzC7x8wvRySJ+0TRzc+R89IfFKFn6tQXOWv2hbayZCA5W44TuNmjyGhaSRCead1Yv62aLFo5NpL/mbsvK1fNWDyX4iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K9dmIeYS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 309A6203E39C;
	Thu,  9 Jan 2025 14:19:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 309A6203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736461155;
	bh=y0Y7f26yw14WtXNaL130PfN8EDBX0GgnM1StZRSdBxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K9dmIeYSf00osUdI4/nA4JNzNG+daIcjejC5seJ1TlDLMazPhg0OfDz0bfLCaUk9/
	 jVeOxh+ccN2nxmeddYLLW2TYr42xG885fo7QRHTAx2S9ssExPQxy66MHldfCM/9uYi
	 W1fwPhlcCXfaqFHjI0nduXK/xKDiASKSxEMOK/9g=
Message-ID: <5321ee37-369f-42d4-b813-fa7fbcb284a2@linux.microsoft.com>
Date: Thu, 9 Jan 2025 14:19:15 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
To: Wei Liu <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, nunodasneves@linux.microsoft.com, tglx@linutronix.de,
 tiala@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <Z4Au-chfvfXCt-zq@liuwe-devbox-debian-v2>
 <dead87fe-c765-4bcc-a097-fc247ee1adf2@linux.microsoft.com>
 <Z4BGI-yoptUPbF3v@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z4BGI-yoptUPbF3v@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/2025 1:56 PM, Wei Liu wrote:
> On Thu, Jan 09, 2025 at 01:40:34PM -0800, Roman Kisel wrote:

[...]

>>
>> needs to have the `u32 exception_type;` field:
>>
>> ```c
>> union hv_arm64_pending_synthetic_exception_event {
>> 	u64 as_uint64[2];
>> 	struct {
>> 		u8 event_pending : 1;
>> 		u8 event_type : 3;
>> 		u8 reserved : 4;
>> 		u8 rsvd[3];
>> 		u32 exception_type;
>> 		u64 context;
>> 	} __packed;
>> };
>> ```
>> as otherwise the struct won't cover the array.
>> Testing the VMs currently with the latest hyperv-next.
> 
> Fixed. I c&p'ed the code then deleted the right version of the struct.
> Thanks for checking.

Happy to help :D

Validated with the VMs, and with the latest hyperv-next, the issue is
fixed!! Appreciate your help and guidance; thank you, Easwar, Michael,
Nuno, Stanislav, Tianyu and Wei for the suggestions that have let make 
this patchset so much better :)

Borislav, I apologize for sending the patchset versions too often. I'm
sorry for causing you trouble due to that. I have read up the kernel
documentation, and will be a better citizen of the LKML.

> 
> Wei.

-- 
Thank you,
Roman


