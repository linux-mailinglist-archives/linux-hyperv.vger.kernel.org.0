Return-Path: <linux-hyperv+bounces-7174-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E238BCAA77
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8473E4E2C80
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Oct 2025 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF125179A;
	Thu,  9 Oct 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F9BoqJmQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7212B9B7;
	Thu,  9 Oct 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037022; cv=none; b=a4Oh2zhJLP/nZIBdz8r3Yge9wyhrDx8JzsR4WSILYXJ9cjaekbV9DJHLlq2el3WnzQLXqOtzawH+y8GNWHZbTSYakKxIUCt3XhQji54Ko3eGV9d75L15RkzNtrEQFjMcFvxvZKFUXS0LnfdFO8kXfiM/jpF5b4DuGipJ7QE9to4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037022; c=relaxed/simple;
	bh=AM5aD2pZjVxsmAj4gWmN+ut721eCMwaUUHWkd7HLPFs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pq/izixYGGwBLskFZfL11MJT+M1hHbl+M3Us7AHNk6+GblqOb2t6LwQ0lBuLrA5T+Xny5yIHWTFCI88p8s7/9HgonDtkoC5SpTUEQr2RMJ3cApODGqxyT4qGXuUZ/m+ZmfC8rKkdONtTjbVDyo688lLdPH2iVp+oYFoosjQtHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F9BoqJmQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5ADAC2116267;
	Thu,  9 Oct 2025 12:10:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ADAC2116267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760037020;
	bh=DDanC2M6vQgtgzF+ERl+0dsirp5iO/ynWiiD415p9Zs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=F9BoqJmQM/lgz1oqKhBBtCS0NXloYI8e24fvs6RUsYEbI7fkh+ehN3Z2dLCZG1dH9
	 bu2W0X/vaayaq+dt3L93so/yikCrfUXAZa+GeGhOd8k04Nv7HrizmBwMTLID02EIVD
	 NUWR2oSMnDeiICmldAhnlDnbR5qojPpSwb9iN9do=
Message-ID: <61be3488-9ea8-42e6-8c2b-35fbfb31e8c6@linux.microsoft.com>
Date: Thu, 9 Oct 2025 12:10:11 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v2] Drivers: hv: Use better errno matches for HV_STATUS
 values
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <20251006230821.275642-1-easwar.hariharan@linux.microsoft.com>
 <2768abf3-6974-49e6-9ea2-5e5e04f533a7@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <2768abf3-6974-49e6-9ea2-5e5e04f533a7@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 11:53 AM, Nuno Das Neves wrote:
> On 10/6/2025 4:08 PM, Easwar Hariharan wrote:
>> Use a better mapping of hypervisor status codes to errno values and
>> disambiguate the catch-all -EIO value. While here, remove the duplicate
>> INVALID_LP_INDEX and INVALID_REGISTER_VALUES hypervisor status entries.
>>
> 
> To be honest, in retrospect the idea of 'translating' the hypercall error
> codes is a bit pointless. hv_result_to_errno() allows the hypercall helper
> functions to be a bit cleaner, but that's about it. When debugging you
> almost always want to know the actual hypercall error code. Translating
> it imperfectly is often useless, and at worst creates a red
> herring/obfuscates the true source of the error.

I feel like you're thinking from the perspective of Microsoft engineers working with
the hypervisor. IMHO, the translation is useful for the rest of the kernel to understand
and possibly handle differently the possible errors. EBUSY for example is
meant to indicate that the operation is already done, or that the target (device/hypervisor)
is busy with something else. Timeouts may be handled by a retry, perhaps with a backoff period.
> 
> With that in mind, updating the errno mappings to be more accurate feels
> like unnecessary churn. It might even be better to remove the errno mappings
> altogether and just translate HV_STATUS_SUCCESS to 0 and any other error
> to -EIO or some other 'signal' error code to make it more obvious that
> a *hypercall* error occurred and not some other Linux error. We'd still
> want to keep the table in some form because it's also used for the error
> strings.

IMHO, an arbitrarily chosen 'signal' error code wouldn't tell support or the rest of the community that
a hypercall error occurred, without a print or trace closest to the hypercall location.

> 
> The cleanup removing the duplicates in the table is welcome.
> 
> Nuno
> 
<snip>

