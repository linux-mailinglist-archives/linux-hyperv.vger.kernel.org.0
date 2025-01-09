Return-Path: <linux-hyperv+bounces-3649-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE3A0815E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DB03A81AF
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833451F75B3;
	Thu,  9 Jan 2025 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="amTkTYhD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0897A1B0403;
	Thu,  9 Jan 2025 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736454526; cv=none; b=SB7L7miPXTn34cGJcHJMGw0x7+1xq2h1udqxuQHc7h7f25zm4wWBhY3XGvIGf2wkVAUPbJmT+of9xnkxaV+J3st9nSWe2uz2OPMtbtIUmewX+9F6pkJ+T9WYrMB/7ESWkjIY4C1J29UQDPtip7GpEbbcjmgMxeOaSbh6P53aDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736454526; c=relaxed/simple;
	bh=wMeKH+1QlMaP1g4d95eucbYnXKm99saEufMnggL2frw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bv1vxhsw3nqzdVvG9oZbvossQ03YMwrhJa/TEex5o0v2A1hlyDQe4eXjzttuSTtZT/27HJcRVLseW7XnOLsKurfJfY9UmGLj26g3ommlOn8me165bdwb1vZjcZh8fu5rJH1JqOwpXfFGPuIRp9KjPFRxNjpEwk1rqvvtANFQPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=amTkTYhD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.116] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id E592E203E3A3;
	Thu,  9 Jan 2025 12:28:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E592E203E3A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736454523;
	bh=K615ALhMYejPOGDcy+6JIrUXZzlNBKSNYVK570/6Ut0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=amTkTYhD7D/V3ig35yNIXDj+oLNFhP2jQmb5Ag7uQEapJHh2UwidQDGlA0TS9dTav
	 zA0H0psLVyabGIFMpdBC1ifX7rJ+qyuRXJ4qbldNmrpRYjmEoNqEER0ob6PCBndXl3
	 PTRRwvJiQJ5gAgHjTnKjHHgrdUzM/wk32Yl4wRps=
Message-ID: <ffef8f33-4d12-43d1-bd56-fd67978e2d8c@linux.microsoft.com>
Date: Thu, 9 Jan 2025 12:28:39 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
To: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, tglx@linutronix.de, tiala@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <Z4Au-chfvfXCt-zq@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <Z4Au-chfvfXCt-zq@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2025 12:18 PM, Wei Liu wrote:
> On Wed, Jan 08, 2025 at 02:21:33PM -0800, Roman Kisel wrote:
> [...]
>> Roman Kisel (5):
>>   hyperv: Define struct hv_output_get_vp_registers
>>   hyperv: Fix pointer type in get_vtl(void)
>>   hyperv: Enable the hypercall output page for the VTL mode
>>   hyperv: Do not overlap the hvcall IO areas in get_vtl()
>>   hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
> 
> The patches have been pushed to hyperv-next. Roman and Nuno, please
> check the tree for correctness.
> 
> Thanks,
> Wei.

I checked, looks like the first two patches of the series are missing?

Nuno

