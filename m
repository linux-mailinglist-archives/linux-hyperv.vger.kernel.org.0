Return-Path: <linux-hyperv+bounces-5459-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276AEAB2E8E
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 06:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA6A1783B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 04:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1160253932;
	Mon, 12 May 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lDAHpWHe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB01AAA2F;
	Mon, 12 May 2025 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747025856; cv=none; b=B+tav0mI7wcwU7TXrn1Dbz/4rDVOvU5dHktjUvpvT/+8WIBzS797uYWojdZleazLQ4PcQSRs37MYUj5cn6i25swL1UPgOMYoHRemDwuLE1mQZxhIHw0ps8Bll+PJL09m+P4WXUfbcTsvDRkLicVCTND0PU+Rc1hBTjNqCnyZDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747025856; c=relaxed/simple;
	bh=Tvl0CMI9gjmLQuy/JYEpr/9vJu6Wx/2hViqI/Cq3NvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFyIyaREeyCMiBRhf437j3SkzxQ5h6NMLtOzMRiOxjoy5kaLxp7N+IIHukh2lnV5/HBDwQSJhDbtHRZ6DNCEPcoI/hsO4Z9yWKfY+0TWdPUBj2wh1ldsSGC+tpVmkfiGJqwFKCPmzWAxxFzvPoWZzRdLfLPq4ghQHVOGowgd0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lDAHpWHe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.86])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57372211D8B9;
	Sun, 11 May 2025 21:57:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57372211D8B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747025854;
	bh=fNcFRLEElIWvORQjG3i14mJRp7cMYbEin9A3CssO8vM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lDAHpWHeSzkDW9Pts7qz8aRJUoJOJmKvYYXEa8PO/ycmdOlJxguWImCHUvwFVMGuX
	 66M8okIoOlktcoOt+Gv7TRCevxCc/mzsP2zcAIof8xuZ5hqdFH8r0R6fuJuQmnnyfx
	 Lp/UNBIPxUPJ879JHpg02F5wh8u0rXwu1BLVQqpU=
Message-ID: <45e292bb-a607-4066-90ed-341443a42459@linux.microsoft.com>
Date: Mon, 12 May 2025 10:27:28 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
 <aBzx8HDwKakGG1tR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <KUZP153MB14447CC188576D3A7376CEAABE8AA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <30fdc85f-5afc-4591-ab43-1c46c435025c@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <30fdc85f-5afc-4591-ab43-1c46c435025c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/9/2025 11:35 PM, Roman Kisel wrote:
> 
> 
> On 5/9/2025 11:02 AM, Saurabh Singh Sengar wrote:
>>
>>
> 
> [...]
> 
>>> Yep. We don't rely on user land software doing sane things to maintain
>>> correctness in kernel, so this needs to be fixed.
>>>
>>> Thanks,
>>> Wei.
>>
>>
>> How about fixing this for normal x86 for now and put a TODO for CVM to 
>> be fixed later, when we bring in CVM support ?
> 
> That seems to strike the right balance ihmo :)
> Thanks for coming up with the suggestion!
> 

Thanks, I'll take care of it in next version.

Regards,
Naman

>>
>> Regards,
>> Saurabh
> 


