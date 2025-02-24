Return-Path: <linux-hyperv+bounces-4031-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FD2A428C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ACE189D3A9
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F7263F48;
	Mon, 24 Feb 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Yx2H6DuQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8D25485D;
	Mon, 24 Feb 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416249; cv=none; b=sw5HocFPCrXnSQlE7mMXaketJLG4PLS2MOlaqJh6zNos2kL/jLARJVkTh5qWl4WEAneVVO9oJOE6iJTY/PtBC1V4jgYkJ+zzGxo6heXl7jmIjfsMvSDRfj14+Qxw9aE6HUDNIqrk0Blo6nwtYvNOR78u9UuQ5eTz41iUAWA+9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416249; c=relaxed/simple;
	bh=/HLBSaNuHMDrMKX1M5g+LydJdhY+NRVc0x02raQ46Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fe3EA/L009xx7MV1s1+Ok1khauCF9h3+4C1OJcHeznZoGpVcbPZrE96gAL9JJ954wKAgGL954OO9A73MYJ0h4iji8DWDGRi27xrgld5vUdtThN+opVyTPnnBFCHB0WvhnrN2a5jFrorhNqrPhvXWnfiMNXZRgt46Om77Y9fb9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Yx2H6DuQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3879720376FD;
	Mon, 24 Feb 2025 08:57:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3879720376FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740416247;
	bh=pfJ+RfQRjA9y2usOQFgOg/fZDtpNvwBXGtY0LXo0f74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yx2H6DuQVJ8jwplYihiAKPWkHpHh0x2/54f4W2RcaQ+KAXVMMzTCUHqiqJ/yJE5j7
	 Hy6CwOVeQwBRzN9VxfE8QiALr+HrtpA9zGjhzKvw0+ZH40l5n2nOyqG1DmeTOLvR7S
	 5tHqgqhMcO7I08qlItaamHK4cC3vhqc1Lo+brpZI=
Message-ID: <97010881-4b5e-4fb7-b8b3-b6c9e440e692@linux.microsoft.com>
Date: Mon, 24 Feb 2025 08:57:27 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2 0/2] x86/hyperv: VTL mode reboot fixes
To: Ingo Molnar <mingo@kernel.org>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com, mingo@redhat.com,
 tglx@linutronix.de, wei.liu@kernel.org, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, sunilmut@microsoft.com
References: <20250220202302.2819863-1-romank@linux.microsoft.com>
 <Z7h50PqiXxdfMegl@gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z7h50PqiXxdfMegl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/21/2025 5:04 AM, Ingo Molnar wrote:
> 
> * Roman Kisel <romank@linux.microsoft.com> wrote:
> 
>> Roman Kisel (2):
>>    x86/hyperv: VTL mode emergency restart callback
>>    x86/hyperv: VTL mode callback for restarting the system
> 
> A: These two patch titles verbs.
> ...
> ...
> B: These two patch titles are missing verbs.
> 
> Like me you prefer B too, right? If so, please add back the missing
> verbs to the titles. I suggest "Add"/"Introduce", and "Call". Thank you!

Right :) Thank you for taking the time to help me, much appreciated!

> 
> 	Ingo

-- 
Thank you,
Roman


