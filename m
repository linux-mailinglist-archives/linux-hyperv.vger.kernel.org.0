Return-Path: <linux-hyperv+bounces-3509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669E9F85C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 21:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DBB188FD75
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784FB1B6CEC;
	Thu, 19 Dec 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NPCo8cts"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E11A0B0C;
	Thu, 19 Dec 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639521; cv=none; b=GmxrgThZGKr3QwV+viI+k01Iy3Em4rnshkwFFkwyXtv6PHvqAF6X+Sw1T2/aFX60cYsr9qhNrVVRsNW9dcZlLJTc6CU0APAjw+0ypEzhbnTsAvWq+3S8UCWfR7ADvHMtqX9EUD4qV3mBy4RcOsUE9hn4PyS6lBFTcnM6irO5LS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639521; c=relaxed/simple;
	bh=X3Ye81AZMuOdcf3iHjGhFctr2QyCSelEhR2IDRS2sk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyeemq6vBMnUGC0koEnVMjLmyc3p+0J+d1/4CTySj6Y0I6GJ1uHJ7Sq+NbQAd1FQYP0VHZURB0DuRJSELRzPRiNQOMyMyJJ7w6fBRhyIIPTdBUbAtc5Y90GngIv42bYNpQxa6zcWpR6qXB87wr3v4czg/qUZB35pQKKow9lXk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NPCo8cts; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C7C7203FC95;
	Thu, 19 Dec 2024 12:18:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C7C7203FC95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734639519;
	bh=Fi2FMKkI70+CXgeHDt7tSMr775ND/g9Upz3w10DUDnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NPCo8ctsLQCOcZ2h6jKdVKvALd/qWbgudKcUvJi2g5mgHhFsZ+3KFdX9fzdGOyMOE
	 y7pt1YgZ7BsMCtnk2sDfATAP5xOPK0nUNvz1SYnt9tbVJ1jkL30Yn7MhJ8Tzb58q5T
	 MQKKGLec4sStUwcrDoylepEmvG/JTQycqd/cUSIc=
Message-ID: <f14172b1-849f-41b6-ab06-799c8b51222b@linux.microsoft.com>
Date: Thu, 19 Dec 2024 12:18:38 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, tglx@linutronix.de, tiala@microsoft.com,
 wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-2-romank@linux.microsoft.com>
 <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
 <48d3a3e0-8e2f-4eb8-b725-b6eed37c290c@linux.microsoft.com>
 <07820167-b415-40b0-9858-d25325c348ba@linux.microsoft.com>
 <4716c74c-d798-4c34-8c64-a8de4d0a6b45@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <4716c74c-d798-4c34-8c64-a8de4d0a6b45@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/2024 12:04 PM, Easwar Hariharan wrote:

[snip]

>>
>>>
>>> This could be accompanied with migration of hv_get_vpreg128 in arm64/
>>> and removal of struct hv_get_registers_output, or that could be deferred
>>> to a later patch.

[snip]

> 
> To clarify, I didn't mean to include implementing extended fast
> hypercalls with the XMM registers, or an implementation of
> hv_get_vpreg128() for x64 in my suggestion.
> 
> Just to fix up the existing hv_get_vpreg128 in arch/arm64 to use
> hv_register_value (or its Linux-specific helper as Nuno suggested).
Oooh, I see, thanks! I'll try that, looks like that should be pretty
straightforward, and hopefully, it will :)

> 
> Thanks,
> Easwar

-- 
Thank you,
Roman


