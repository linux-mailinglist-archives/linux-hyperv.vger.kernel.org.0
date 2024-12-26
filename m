Return-Path: <linux-hyperv+bounces-3525-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240C99FCDAF
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEDB162D21
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EF1474B7;
	Thu, 26 Dec 2024 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kSDd0O7c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8813C689;
	Thu, 26 Dec 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735245765; cv=none; b=tDm1S5jr04ZzqsRL0CxNn6xPKg0MgwmGqzdDseCog04Zy/t44sdWFbhFGI6XuxN0slvhB/PFmmaIsE2nSKLdgOt8a0/kxeYd4W9+BmmBJF0HvdRVj8Q1uF3qYZ5lczHmitQC3t0eyupxIEgdQ3/4OIRxB2U8cvqpJiMPjUSHH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735245765; c=relaxed/simple;
	bh=rNb8MQUhOfEuJEPqfV2IUeIpwji0HWQ8qPizUuD7VxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eib0v7/Y3pQ9IXYjKb34ePSlgJqA12pN7t3uhh4Qq0XOF4cOBa1i6rfcRgiIepVSR9Ga6ITZgGuaD3+mlwsVDvhYUAv1oduRZ4NGu0o9fYrpAD+pw1G83byEFr5ASQYrmsAKRwUtjzFS1VOpMs1Q8Kilm24uu2XvRuGVoxs5LP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kSDd0O7c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 58EA2203EC21;
	Thu, 26 Dec 2024 12:42:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58EA2203EC21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735245763;
	bh=LtRIFFvRqL1g30a9JMTACtfx5bibE4snxLgPYRDj8D0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kSDd0O7cIkpeH+JlBwLLkrucPFdVIjMTj2o+KmBfEE4bwWtU8Etd4xH7NfMxqOjfn
	 84yjaGPNjNmIQDWk83NsnU/8R9zPsZC7aoiZaTWJX4flRQHZ/vPTO4r3Jotp8uwwHT
	 vwYU5aP8gm62Vd43oFSQYF+LYJXA517ginfmXvns=
Message-ID: <2262a520-5557-45cc-95c0-460ebad30b01@linux.microsoft.com>
Date: Thu, 26 Dec 2024 12:42:43 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hyperv: Do not overlap the input and output hypercall
 areas in get_vtl(void)
To: Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
 <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
 <SN6PR02MB4157DD7CE09E39C524775168D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d8c4613a-33b6-4aa6-a3ae-7c888ab2d727@linux.microsoft.com>
 <BN7PR02MB41482EDAA9CD96EF2ECE6532D4072@BN7PR02MB4148.namprd02.prod.outlook.com>
 <eba74adf-4891-46f8-a3ef-e116000dd566@linux.microsoft.com>
 <SN6PR02MB4157FD829416A7ACA2FF9300D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ff359a3e-a275-4146-8e99-a06fea69b7a9@linux.microsoft.com>
 <SN6PR02MB41570091569D9365185B9F8AD4032@SN6PR02MB4157.namprd02.prod.outlook.com>
 <9c138f4e-9258-4457-b85b-69ae111894fb@linux.microsoft.com>
 <SN6PR02MB4157B98CD34781CC87A9D921D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157B98CD34781CC87A9D921D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/26/2024 12:04 PM, Michael Kelley wrote:
[...]

> 
> As I was looking at how hypercall input and output arguments are
> managed in upstream code and in the OHCL-Linux-Kernel repo,
> I noticed two things:
> 
> 1) There's a bug in mshv_vtl_hvcall_call() in the OHCL-Linux-Kernel
> repo, for which I filed a github issue. [1]
Appreciated very much!

> 
> 2) hv_vtl_apicid_to_vp_id() also has the overlapping hypercall input
> and output spec violation. You might want to fix that occurrence as
> well in this patch set.
Let me do that, thank you!

> 
> Michael
> 
> [1] https://github.com/microsoft/OHCL-Linux-Kernel/issues/33

-- 
Thank you,
Roman


