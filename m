Return-Path: <linux-hyperv+bounces-5447-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8672AB1BF8
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 20:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C2E1C07E9A
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC52235341;
	Fri,  9 May 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sXFSSZfu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F341366;
	Fri,  9 May 2025 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813917; cv=none; b=Ok+UtGBZXybNdZSxIxCHUyn2X0F20yB0pkAiy3pT7Em2uvbpNyfA9+ZFFrc7j2OpT9keKElUqkEg4PsgfOCkpctA8VFtxmlafhWb/vtoqFgXW5mjFJaDSVsSZiTTw9Miels+YUmM0NK/2IYuPIRYWJ7PyGrefd0iILvgn6Nxd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813917; c=relaxed/simple;
	bh=FD2ltmqz6UpEB5QluQuj7xhJcNrbblkV+YuOhTLH20M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns+lgyI0YXczuZu6ttGiAaFVBdIW6A3d1iSFyTaVHzwUfKJCSXCMQEEDdzvjJwz8MdGdzFFHeX7qw4ghQzcbVbGyJUP9JDvt97I2AOAZ3uCQGfAgE3SP6M6AlWgSQ6kMQKDp32KAxfq6j+NLya4R94LKLiKk7QmwLPv3sDPflJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sXFSSZfu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 36E2F2115DA9;
	Fri,  9 May 2025 11:05:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36E2F2115DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746813910;
	bh=3yOV6BOvMKw3ti/gZ68xUptMLORu1abg5DNjIGVosb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXFSSZfukWMf5tU1ljKtlxf5AMt+3EF7A8g587CX3J+xjcKOQNDINH2UVYzsB0PrS
	 Me7pNTUhMqs/rqcapQD0idcSCxjsQ6PHQZQZ/byD1pVfOh9yxRD9KYutpHFbNIQv5g
	 YP5Q5KAYy2rz5/Fv7KRRqTOmc0YmC/80oQpN35+Q=
Message-ID: <30fdc85f-5afc-4591-ab43-1c46c435025c@linux.microsoft.com>
Date: Fri, 9 May 2025 11:05:10 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Saurabh Singh Sengar <ssengar@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <KUZP153MB14447CC188576D3A7376CEAABE8AA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/9/2025 11:02 AM, Saurabh Singh Sengar wrote:
> 
> 

[...]

>> Yep. We don't rely on user land software doing sane things to maintain
>> correctness in kernel, so this needs to be fixed.
>>
>> Thanks,
>> Wei.
> 
> 
> How about fixing this for normal x86 for now and put a TODO for CVM to be fixed later, when we bring in CVM support ?

That seems to strike the right balance ihmo :)
Thanks for coming up with the suggestion!

> 
> Regards,
> Saurabh

-- 
Thank you,
Roman


