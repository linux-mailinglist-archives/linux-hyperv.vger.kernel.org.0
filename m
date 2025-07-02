Return-Path: <linux-hyperv+bounces-6067-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AE7AF0ABC
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 07:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C604A38BB
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D21DD88F;
	Wed,  2 Jul 2025 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LEX2ppwX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5660B8A
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Jul 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434322; cv=none; b=baBeC6gO8WIwKL9dYdSBc0PcLzV+4jUQnAXEs8yPQgyCnLgEUwZSUHtw+h4Y2R15NgUvrbZpwipxNx7R4YOwYhIKuWnqFmbuXd3DuDU2RblCn3OupA+7pK2ZcoskK4wF426KHvQzNYFZLY9V+YFKLSG86uNzF79AGDvdZ0yIIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434322; c=relaxed/simple;
	bh=yKula5frFRirzLC/pJHfQMo3IDC84vG2JEna7K2c5aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAHRrElw4K9TaEpQLnZFsO+IV/8qb23uNL6GnTSOkFbvtTlpY7mvnb4qQUhZd2HmV5nu1PaTDBlEQwqoce9Qrr75EVftKk4KVV7SSjLnI3aLmUBn8h8G1CiiMsWbRhHlAthYnbUut4IrQFW1imLA8LiMvEncDxLaUvpFOrwmj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LEX2ppwX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.65.159] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id D2032211222C;
	Tue,  1 Jul 2025 22:31:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2032211222C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751434313;
	bh=qJUuZirSyjcs1LcZephvU7DqVn3x0j3TY4ooy4ZZHb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LEX2ppwX7cVxezEgiG3E7p/839Sim3QhC5KeJJEL6Ufs9s4nhog5utAlvNMXwLVsB
	 5ykfFEyuBpN/l1da+ItXAaEeMZXajAX8g/WXPeX8I/V0DWJcjdFaCvT80/k/8iWlMB
	 1yLZ+sCA8mdeMDbxmeAWzNxzdVnD6eRHdcnbr0mA=
Message-ID: <630a37bf-7ed5-42fb-ae64-6f6a29161d2e@linux.microsoft.com>
Date: Wed, 2 Jul 2025 11:01:48 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
To: Olaf Hering <olaf@aepfle.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250701104837.3006-1-namjain@linux.microsoft.com>
 <20250701131532.125b960c.olaf@aepfle.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250701131532.125b960c.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/1/2025 4:45 PM, Olaf Hering wrote:
> Tue,  1 Jul 2025 16:18:37 +0530 Naman Jain <namjain@linux.microsoft.com>:
> 
>> +		syslog(LOG_ERR, "Could not determine ring size, using default: %u bytes",
>> +		       HV_RING_SIZE_DEFAULT);
> 
> I think this is not an actionable error.
> Maybe use the default just silently?
> 
> 
> Olaf

So let's suppose a case, where the actual ring buffer size was different
than the default value, and for some reason, we were not able to
determine the ring size from the sysfs entry. This results in wrong size
configured in FCopy daemon. FCopy does not work in that scenario and
silently fails. We would definitely like to inform that to the user.
Default size case is just to provide a best effort way of making it
work.
I am fine to change it to LOG_INFO or keep it the same. Please let me
know your thoughts.

Regards,
Naman

