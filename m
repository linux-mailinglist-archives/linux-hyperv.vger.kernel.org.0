Return-Path: <linux-hyperv+bounces-3651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87DA08252
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 22:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8347F3A4C36
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19CC2040B7;
	Thu,  9 Jan 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rnhwn/lr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F7B1ACEAE;
	Thu,  9 Jan 2025 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736458836; cv=none; b=hvKc2LYbkORzshe2XmggYCVVOf/KV1InCLo7WXfwGTlLxFVWplujlCjJ5nClg3ThMeC3MmR8CWH7N132l6MrcOD1Xz2cg3WJ6tmv/3wckbr7SwpWKUOu9ocZsqhif7SSY9v1/3BQAAVEFDHRBetJRz6ZvBQZo3Z5oqo189hCT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736458836; c=relaxed/simple;
	bh=Zkqk41xPDxERpvVMWGvDXp7nwHSju7efNBa+GUb1nLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8cVE2mzymaKtwY3KeQTRbikO4jP+SPOBTj136uwJg5g+UIN1n1lPKZO6x8kwo/uLDNbHb2BtEDqQLgp5YQwD5TNbqgrFOEtog6Vvo7FdMwIDWFvihdoqn2pCwjong4zraKvbv5Rsy3yC/VysSeZuaodxZIU7lq1sy9vvDB77gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rnhwn/lr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8610203E3A0;
	Thu,  9 Jan 2025 13:40:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8610203E3A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736458835;
	bh=Co1tt9svYfoYU/a2BojPr7bpE/2cs50rnVRNjX/AAbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rnhwn/lrlnVk1XQCNPr95gtpQJu9gWZQM0KXcSNPKdwrc/OH/qOAxv/VJ/a31nbEq
	 qVrYujrrJgq+7egXyYMVeVfT15agRg+h3LtVU030sH7zmxC6jLrOaLLRnPAI3Epr2i
	 Tnno9NiqLQohw38RIwYgQgAMjW1JanW6dswpx210=
Message-ID: <dead87fe-c765-4bcc-a097-fc247ee1adf2@linux.microsoft.com>
Date: Thu, 9 Jan 2025 13:40:34 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
To: Wei Liu <wei.liu@kernel.org>
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z4Au-chfvfXCt-zq@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/2025 12:18 PM, Wei Liu wrote:
> On Wed, Jan 08, 2025 at 02:21:33PM -0800, Roman Kisel wrote:
> [...]
>> Roman Kisel (5):
>>    hyperv: Define struct hv_output_get_vp_registers
>>    hyperv: Fix pointer type in get_vtl(void)
>>    hyperv: Enable the hypercall output page for the VTL mode
>>    hyperv: Do not overlap the hvcall IO areas in get_vtl()
>>    hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
> 
> The patches have been pushed to hyperv-next. Roman and Nuno, please
> check the tree for correctness.

This

```c
union hv_arm64_pending_synthetic_exception_event {
	u64 as_uint64[2];
	struct {
		u8 event_pending : 1;
		u8 event_type : 3;
		u8 reserved : 4;
		u8 rsvd[3];
		u64 context;
	} __packed;
};
```

needs to have the `u32 exception_type;` field:

```c
union hv_arm64_pending_synthetic_exception_event {
	u64 as_uint64[2];
	struct {
		u8 event_pending : 1;
		u8 event_type : 3;
		u8 reserved : 4;
		u8 rsvd[3];
		u32 exception_type;
		u64 context;
	} __packed;
};
```
as otherwise the struct won't cover the array.
Testing the VMs currently with the latest hyperv-next.

> 
> Thanks,
> Wei.

-- 
Thank you,
Roman


