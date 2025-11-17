Return-Path: <linux-hyperv+bounces-7656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BAC66942
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 00:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E569B4EFB83
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 23:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5349319862;
	Mon, 17 Nov 2025 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Kj9ites8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF827F005;
	Mon, 17 Nov 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422955; cv=none; b=Xniut+6Zns6WIQ0+Rqgi7/ThOav0wrAbfhT6V0aLIy/6mqtw87IPSM/8qtdO4rUHCvgqXX1KB7JPG4iG0fvPw0gvvp2LRjgpCdoRVvUBbgp/f8rK0sASERGxcgg0XlGmx5YjLO7n11Vy/tHt/bFpnxZfymkf/MJhn0pY6epc+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422955; c=relaxed/simple;
	bh=TTTtp2W8KQZPRVzuSwv+eAtwGAMd6Gp2B+gFS3J77bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuiNuPbbjqpeSGL/gahKFXSHzY8ArfVwK3Tc6yX0CfzidiVKq24efPAiAfvIFDQUgQwHM1+1OzYEVsnM7ogWNVFzqtHj0MC6OiGz0QdPcbwCjjxfC6x+9SZ4fWotyPbOgwOudiqTF4Nq8AGvPk/CMji5TkV2Oec1XeIup1aJjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Kj9ites8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.192.165] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC772211083D;
	Mon, 17 Nov 2025 15:42:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC772211083D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763422952;
	bh=jsnxaGt48c4zz4+5qQ2SBOm9/4nevYWcEW6BdKHMqtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kj9ites88c+bN23gmWgTya2QyEhwmTZfVxezrisWsVVfqqWBV2cXLXWruF1S2/RL+
	 t8wDvYSs5NQOAFnNJTlP3y/IvoV5aVASZk8+m+gk/Gyny5YBDeX4A7bqAhZ5Obuh4v
	 37SG/+gmf2k9MolArbxTPCkDLsJqpM7rlMHNn4tU=
Message-ID: <d65a1b2d-2fdf-4cd1-bd04-a438205c7a70@linux.microsoft.com>
Date: Mon, 17 Nov 2025 15:42:19 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
To: Wei Liu <wei.liu@kernel.org>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117095207.113502-1-anirudh@anirudhrb.com>
 <36ac7105-3aa7-4e53-b87d-b99438f65295@linux.microsoft.com>
 <20251117191827.GC2380208@liuwe-devbox-debian-v2.local>
 <20251117192402.GA2402579@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251117192402.GA2402579@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/2025 11:24 AM, Wei Liu wrote:
> On Mon, Nov 17, 2025 at 07:18:27PM +0000, Wei Liu wrote:
>> On Mon, Nov 17, 2025 at 10:16:12AM -0800, Nuno Das Neves wrote:
>>> On 11/17/2025 1:52 AM, Anirudh Rayabharam wrote:
>>>> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>>>>
>>>> Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
>>>> execute a passthrough hypercall targeting the root/parent partition
>>>> i.e. HV_PARTITION_ID_SELF.
>>>>
>>>
>>> I think it's worth taking a moment to check and perhaps explain in
>>> the commit message/a comment any security implications of the VMM
>>> process being able to call these hypercalls on the root/parent
>>> partition.
>>>
>>> One implication would be: can the VMM process influence other
>>> processes in the root partition via these hypercalls,
>>> e.g. HVCALL_SET_VP_REGISTERS? I would think that the hypervisor
>>> itself disallows this but we should check. We can ask the
>>> hypervisor team what they think, and check the hypervisor code.
>>>
>>> Specifically we should check on any hypercall that could possibly
>>> influence partition state, i.e.:
>>> HVCALL_SET_PARTITION_PROPERTY
>>> HVCALL_SET_VP_REGISTERS
>>> HVCALL_INSTALL_INTERCEPT
>>> HVCALL_CLEAR_VIRTUAL_INTERRUPT
>>> HVCALL_REGISTER_INTERCEPT_RESULT
>>> HVCALL_ASSERT_VIRTUAL_INTERRUPT
>>> HVCALL_SIGNAL_EVENT_DIRECT
>>> HVCALL_POST_MESSAGE_DIRECT
>>>
>>> If it turns out there is something risky we are enabling here, we can
>>> introduce a new array of hypercalls to restrict which ones can be
>>> called on HV_PARTITION_ID_SELF.
>>>
>>
>> This is a good point. Please check with the hypervisor team.
> 
> I should add: it is always easier to relax restrictions later than to
> add them back in, so if there is any doubt and we want this code in as
> quickly as possible, we can start with a new array and expand it later.
> 

Agreed. I think that's a good approach here, we can just enable
HVCALL_GET_PARTITION_PROPERTY and HVCALL_GET_PARTITION_PROPERTY_EX for 
self-targeted passthru hypercalls.

> Wei


