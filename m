Return-Path: <linux-hyperv+bounces-3158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE59A49C3
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Oct 2024 00:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF87283D8C
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 22:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1CC187876;
	Fri, 18 Oct 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D2Uli782"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B318BBAE;
	Fri, 18 Oct 2024 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729291797; cv=none; b=nx8chE5M6aUq1Cxmb67vFQZkEtKlvghp/xwU7nDL+ocr6L4hEi+s8zAHwpuzhcNbIStjpEVrbIY/dG+2L0hoo+ka0//xfjbxxkKHC0mZkeiTyMhlV2lqd02zbnXcUGuV9VIz8d6DlpJD8P3ixomaVaQa5J72wnkHRA/jkTErRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729291797; c=relaxed/simple;
	bh=yswW2c6GdfQLJtXOehlbZhSmsyxo8a1eHpYcHeo39mE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=npLjlrgAuhXuuohGJZfeQHq5mcoN1iGveQEViMthPkJaXzJ4vCVaUi9LUtaO21XYX29zXkAla/E2xT+PtD6zzX1PDEPCSGzuUQglDUdHtk4Spbu0HyVxV746K6GbdN8Ow9SAI1099PQw6uuzEjbxFH81w95KObEW7E2B116XVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D2Uli782; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id E846720FFCA7;
	Fri, 18 Oct 2024 15:49:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E846720FFCA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729291795;
	bh=hjhI0X2i1TjwEjLXSNHJqjjYYC3Kby7dVbm9bxkEE7Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=D2Uli782OWo95apRDRmgdDEfIf5IeVpkSx9YmuXVx9VORW7oqdqqzDZtqucGMDJd8
	 zTSDT4U0H9FaXz7eNCHk56EPuHdxAI3J3y9DvjiD+LObfkdBNlrmi6yrHrI5eFUGqa
	 DT7EipqWIF2qn/I1SuKOxVxI1jAWh5L73eqDv7Ls=
Message-ID: <2dff61bd-55d8-430f-9d92-6cbfe1bf6326@linux.microsoft.com>
Date: Fri, 18 Oct 2024 15:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>
Subject: Re: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
To: Praveen Kumar <kumarpraveen@linux.microsoft.com>, lkp@intel.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241016223730.531861-1-eahariha@linux.microsoft.com>
 <9f4baf14-8182-451d-9849-4326a783d5c1@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <9f4baf14-8182-451d-9849-4326a783d5c1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/2024 12:54 AM, Praveen Kumar wrote:
> On 17-10-2024 04:07, Easwar Hariharan wrote:
>> We have several places where timeouts are open-coded as N (seconds) * HZ,
>> but best practice is to use msecs_to_jiffies(). Convert the timeouts to
>> make them HZ invariant.
>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>  drivers/hv/hv_balloon.c  | 9 +++++----
>>  drivers/hv/hv_kvp.c      | 4 ++--
>>  drivers/hv/hv_snapshot.c | 6 ++++--
>>  drivers/hv/vmbus_drv.c   | 2 +-
>>  4 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index c38dcdfcb914d..3017d41f12681 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -756,7 +756,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>>  		 * adding succeeded, it is ok to proceed even if the memory was
>>  		 * not onlined in time.
>>  		 */
>> -		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
>> +		wait_for_completion_timeout(&dm_device.ol_waitevent, msecs_to_jiffies(5 * 1000));
> 
> Is it correct to convert HZ to 1000 ?
> Also, how are you testing these changes ?
> 

It's a conversion of milliseconds to seconds, rather than HZ to 1000. :)
msecs_to_jiffies() handles the conversion to jiffies with HZ. As Naman
mentioned, this could be equivalently written as 5 * MSECS_PER_SEC, and
would probably be more readable. On testing, this is only
compile-tested, and that's part of the reason why it's an RFC, since I'm
not 100% sure every one of these timeouts is measured in seconds. Hoping
for folks more familiar with the code to take a look.

Thanks,
Easwar

