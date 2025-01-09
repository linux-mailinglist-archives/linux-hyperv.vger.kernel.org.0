Return-Path: <linux-hyperv+bounces-3637-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C734FA06F24
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 08:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9FC160BB3
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF615E97;
	Thu,  9 Jan 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HTxR7A85"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1308F5E;
	Thu,  9 Jan 2025 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408152; cv=none; b=k/gdBdXsykuKOouGjwV/hj4UkymYPIFAR7jdjC6zWGC5YzQPRX/h2wLzDunbI4FZncQfSnDWyQgfEBcDYMJLtxMg1w58n/ajEWNEjXu1C1e3iL7iAbsOZTi9I5Wyg4EZsTgBk9q/N9xFAN2ASrOHvlrnAyQ+NpjW41qoHWRSnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408152; c=relaxed/simple;
	bh=NNJczAoJ6iMg4JSVikEpcILuAdnfMOMa+TvC5vWjn08=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L2BTyrkHlMEOg74shbBP8uVodG8rvRo86BfL81JHgjPdhjmet/2Ok6/I7qDG/kGff6E9wPFJ+W5vVaX8dAytiFG+BNi1HugdKjATz+Sjv+0lkJ+KuqL3iUZxBAkJRxqQ9zuQlwrhjnPGaXY61cqlUZUpS83VHg4uTkG2XtkPmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HTxR7A85; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.125] (c-73-225-18-138.hsd1.wa.comcast.net [73.225.18.138])
	by linux.microsoft.com (Postfix) with ESMTPSA id 03F58203E3B3;
	Wed,  8 Jan 2025 23:35:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 03F58203E3B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736408150;
	bh=NmGS8xaQZ/+ESHibo7dWgg6NDOT91PqmdmxXxmqTP1U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HTxR7A85N8xIDeb8UUYLUReQjewdwQ4C6BcJKyt6LS6fO+sJzr4ryOuAGpypVjiMe
	 X9ct4M2ChMlwW+PizYrDE1EYocWpbsI5TP0dwjUhhvuYgcEcQsqWAkZ7ZgnDKbYyFt
	 fwcuQJkls0FnJ6MBTNbpgdEDe6dEFFlD4TCZ8YsQ=
Message-ID: <ca5dfdbc-4d55-4f5e-921d-452e152454cc@linux.microsoft.com>
Date: Wed, 8 Jan 2025 23:35:48 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Allow single instance of hv_util devices
To: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Sonia Sharma <sosha@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sonia Sharma <Sonia.Sharma@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <1734738938-21274-1-git-send-email-sosha@linux.microsoft.com>
 <SN6PR02MB41579A7AA47BC6751F57EC72D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z3yK0Ee3eFLocJDW@liuwe-devbox-debian-v2>
 <CH4PR21MB4613241E591ED702A508C35491112@CH4PR21MB4613.namprd21.prod.outlook.com>
Content-Language: en-US
From: Sonia Sharma <sosha@linux.microsoft.com>
In-Reply-To: <CH4PR21MB4613241E591ED702A508C35491112@CH4PR21MB4613.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jan 7, 2025 at 02:00:48PM +0000, Wei Liu wrote:
>   
> On Sun, Dec 29, 2024 at 06:02:34PM +0000, Michael Kelley wrote:
>> From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Friday, December 20, 2024 3:56 PM
>> > 
>> 
>> Please include the "linux-hyperv@vger.kernel.org" mailing list
>> when submitting patches related to Hyper-V.
>> 
>> > Harden hv_util type device drivers to allow single
>> > instance of the device be configured at given time.
>> >
> 
> Why is this needed? What's the problem that this patch is trying to
> solve?
> 
>> 
>> I think the reason for this patch needs more explanation. For several
>> VMBus devices, a well-behaved Hyper-V is expected to offer only one
>> instance of the device in a given VM. Linux guests originally assumed
>> that the Hyper-V host is well-behaved, so the device drivers for many
>> of these devices were written assuming only a single instance. But
>> with the introduction of Confidential Computing (CoCo) VMs, Hyper-V
>> is no longer assumed to be well-behaved. If a compromised & malicious
>> Hyper-V were to offer multiple instances of such a device, the device
>> driver assumption about a single instance would be false, and
>> memory corruption could occur, which has the potential to lead to
>> compromise of the CoCo VM. The intent is to prevent such a scenario.
>> 
>> Note that this problem extends beyond just "util" devices. Hyper-V
>> is expected to offer only a single instance of keyboard, mouse, frame
>> buffer, and balloon devices as well. So this patch should be extended
>> to include them as well (and your new function names containing
>> "hv_util" should be adjusted). Interestingly, the Hyper-V keyboard driver
>> does not assume a single instance, so it should be safe regardless. But
>> the mouse, frame buffer, and balloon drivers are not safe.
>> 
>> With this understanding, there are two ways to approach the problem:
>> 
>> 1) Enforce the expectation that a well-behaved Hyper-V only offers a
>> single instance of these VMBus devices. That's the approach that this
>> patch takes.
>> 
>> 2) Update the device drivers to remove the assumption of a single
>> instance. With this approach, if a compromised & malicious Hyper-V
>> were to offer multiple instances, the extra devices might be bogus, 
>> but memory corruption would not occur and the integrity of the
>> CoCo VM should not be compromised. As mentioned above, such
>> is already the case with the keyboard driver.
>> 
>> I've thought about the tradeoffs for the two approaches, and don't
>> really have a strong opinion either way. In some sense, #2 is the
>> more correct approach as ideally device drivers shouldn't make
>> single instance assumptions. But #1 is an easier fix, and perhaps
>> more robust. Other reviewers might have other reasons to prefer
>> one over the other, and have a stronger viewpoint on the tradeoffs.
>> I would be interested in any such comments. But I'm OK with
>> approach #1 unless someone points out a good reason to
>> prefer #2.
> 
> #2 is preferred. It is frowned upon to make assumptions that only one
> instance of a device will be present.
> 
> It perhaps takes more work to check and enforce the invariant (as this
> patch demonstrates) than to just let the device framework handle
> multiple instances.
> 
> Thanks,
> Wei.

Thanks Michael and Wei for the review.

The intent of the patch is correctly described by Michael. With that, it seems the consensus is to go with approach #2, so I would then work on a new patch series fixing the assumption of singleton driver wherever needed.

Thank you,
Sonia

