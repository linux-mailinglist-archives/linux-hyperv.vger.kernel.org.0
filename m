Return-Path: <linux-hyperv+bounces-6379-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15BB10EFE
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E337E7A5EBD
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91982271462;
	Thu, 24 Jul 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WpcGsrgq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363731CEACB;
	Thu, 24 Jul 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371907; cv=none; b=kWEo2YgMf/fh2KI+ImEneMsiPJhFOD7xPdkwKUFEuHezUQajDzbAlzDmjlM6PUmniXNOJu7CM3n6JfI61C68MVG49Fxw+pw0XUHe7eGs2YgsK2JMiUxcz0mxLIC0OTvibHmBYO3Z/TmN22PKh6dQnhcg8RXrxPvOWHJG9HOIRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371907; c=relaxed/simple;
	bh=Sut9AK6eBSBo5Xf359xq0POPeBFo3x/4OxeinLlZrF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACTfvfYVodBY0yzIM+BWB/mwDQ7ZdRu+uWVRFRWxLkvEfc8pnCoieaKHMpRdiqF9lvsGGnAz9dKM5b9raynEr4dD+X3xz5GCzGYH9ou1puZclDORlR1Xc5pgsGZUe6U/ZTOK9dqWzu3tDjr/KR+y7/gPYTQrrvS18+hRpfytqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WpcGsrgq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.160.255] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 394F92021893;
	Thu, 24 Jul 2025 08:45:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 394F92021893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753371905;
	bh=6GmVVQeJlIU2XQdswsleagO9eH3yur/FrYwVVfEmvsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WpcGsrgqBsvogPoY75H9g+7p2Mnicn4prnXfHM77HUX912RmqSUex/r8XgA992vNm
	 /xxWVMBdoLbmP8r2/NIfu0eAZ1FIPiCplvekzFFzyGbXUQS7BzuOMyfHxuJNx8y4HD
	 1FRmWydbpOVY1UD+wTnJs/9uu88avu9qy8t+VbeA=
Message-ID: <5160e0ab-f588-481c-9585-98b6f2944407@linux.microsoft.com>
Date: Thu, 24 Jul 2025 21:14:59 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Drivers: hv: Introduce new driver - mshv_vtl
To: Markus Elfring <Markus.Elfring@web.de>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 linux-hyperv@vger.kernel.org
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <fe2487c2-1af1-49e2-985e-a5b724b00e88@web.de>
 <558412b1-d90a-486a-8af4-f5c906c04cca@linux.microsoft.com>
 <8cfe5678-b8c0-471c-8ad2-2c232c4bbc24@web.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <8cfe5678-b8c0-471c-8ad2-2c232c4bbc24@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/2025 4:56 PM, Markus Elfring wrote:
> …
> 
>>> Do you see opportunities to extend guard applications for further data structures?
> …
> 
>> So I actually extended using guard to all the other places where I was
>> using manual mutex lock/unlock. I had to reorganize the code a bit,
>> which made the overall flow simpler and more robust. If I am missing
>> something, please let me know.
> 
> Can you imagine that similar adjustments will become helpful at further
> source code places also according to other pairs of function/macro calls?
> https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/rcupdate.h#L1155-L1167
> 
> How do you think about to fiddle any more with “constructors” and “destructors”?
> 
> Regards,
> Markus

I have one other usage of rcu_read_lock/unlock in the code, which I feel 
is fine in its current form.

Thanks,
Naman Jain

