Return-Path: <linux-hyperv+bounces-3224-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F41B9B80D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FF91C21A93
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A011BD027;
	Thu, 31 Oct 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pPvWLvQ6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93AE1BC9ED;
	Thu, 31 Oct 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394362; cv=none; b=a6rhVwR7K953Hck+afkQ6JK2S17SFdyFc16n9RC8t+Iy+xC1+hkW7PIhHZawIF56L1Ni5/DAiGDa+dWJUARxxltYTuD5x2Z1436zafYfRPz4kC6oswcupY0q8Ikc2mqLiiREQ6Ho8CAmFeYDpBhJyBglUIQEgyInpER+ysgHwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394362; c=relaxed/simple;
	bh=oQEwmtZY4mWHkDgKo0RnsqlCcblIyd/ZBgD5waz/hI4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qWdDuIC0gq1OwnGVb9L3P9KXZhkYA9SH9KI1PkIIXecy+Jg8eUdDzTtQKDUD1iUDc0Lxy9ViOb0VsaE/kxXITYDvrWlMWatb5oNbFxpj1CtFGNoYyjOhJ6qk8jNbO8ycLnRMGKQKi71T89NsXAkeAFYCDi771MQ4j/SVCWXgC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pPvWLvQ6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11F112069407;
	Thu, 31 Oct 2024 10:05:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11F112069407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730394359;
	bh=99P+aru9ynYYM7E85nq3XRTiKJJHCxUoaEt0wEOPJ1o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pPvWLvQ6CJNRPi+TfyFT2sj5GpY0nKXL3bhhIemkOay8uF8WzqCgeQma01Qg71iqy
	 gx7Tm7z91MeF5dCn9vqnQgcMwVLaAvryqQkJlBeNeSiUcxhTXDvHVBK6lZtGKGm2Xu
	 msnJHBxVeRDMt+n3DfznriZ+oG0V/KOHqNmhBeR0=
Message-ID: <59a29847-2a3b-4aac-82f4-db9f1e52bb10@linux.microsoft.com>
Date: Thu, 31 Oct 2024 10:05:57 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Michael Kelley <mhklinux@outlook.com>,
 "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: Re: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
To: Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Praveen Kumar <kumarpraveen@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>
References: <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
 <20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com>
 <SA0PR21MB1867075CEEBDFB9D909AFFF2CA552@SA0PR21MB1867.namprd21.prod.outlook.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <SA0PR21MB1867075CEEBDFB9D909AFFF2CA552@SA0PR21MB1867.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/2024 8:54 AM, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Easwar Hariharan <eahariha@linux.microsoft.com>
>> Sent: Wednesday, October 30, 2024 1:48 PM
>> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
>> <decui@microsoft.com>; linux-hyperv@vger.kernel.org; Anna-Maria Behnsen
>> <anna-maria@linutronix.de>; Thomas Gleixner <tglx@linutronix.de>; Geert
>> Uytterhoeven <geert@linux-m68k.org>; Marcel Holtmann
>> <marcel@holtmann.org>; Johan Hedberg <johan.hedberg@gmail.com>; Luiz
>> Augusto von Dentz <luiz.dentz@gmail.com>; linux-
>> bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; Praveen Kumar
>> <kumarpraveen@linux.microsoft.com>; Naman Jain
>> <namjain@linux.microsoft.com>
>> Cc: Michael Kelley <mhklinux@outlook.com>; Easwar Hariharan
>> <eahariha@linux.microsoft.com>; Von Dentz, Luiz
>> <luiz.von.dentz@intel.com>
>> Subject: [PATCH v3 1/2] jiffies: Define secs_to_jiffies()
>>
>> secs_to_jiffies() is defined in hci_event.c and cannot be reused by
>> other call sites. Hoist it into the core code to allow conversion of the
>> ~1150 usages of msecs_to_jiffies() that either:
>> - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
>> - have timeouts that are denominated in seconds (i.e. end in 000)
>>
>> This will also allow conversion of yet more sites that use (sec * HZ)
>> directly, and improve their readability.
>>
>> TO: K. Y. Srinivasan <kys@microsoft.com>
>> TO: Haiyang Zhang <haiyangz@microsoft.com>
>> TO: Wei Liu <wei.liu@kernel.org>
>> TO: Dexuan Cui <decui@microsoft.com>
>> TO: linux-hyperv@vger.kernel.org
>> TO: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> TO: Thomas Gleixner <tglx@linutronix.de>
>> TO: Geert Uytterhoeven <geert@linux-m68k.org>
>> TO: Marcel Holtmann <marcel@holtmann.org>
>> TO: Johan Hedberg <johan.hedberg@gmail.com>
>> TO: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> TO: linux-bluetooth@vger.kernel.org
>> TO: linux-kernel@vger.kernel.org
>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>  include/linux/jiffies.h   | 12 ++++++++++++
>>  net/bluetooth/hci_event.c |  2 --
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>> index
>> 1220f0fbe5bf9fb6c559b4efd603db3e97db9b65..e17c220ed56e587fd55fb9cf4a133a5
>> 3588af940 100644
>> --- a/include/linux/jiffies.h
>> +++ b/include/linux/jiffies.h
>> @@ -526,6 +526,18 @@ static __always_inline unsigned long
>> msecs_to_jiffies(const unsigned int m)
>>  	}
>>  }
>>
>> +/**
>> + * secs_to_jiffies: - convert seconds to jiffies
>> + * @_secs: time in seconds
>> + *
>> + * Conversion is done by simple multiplication with HZ
>> + * secs_to_jiffies() is defined as a macro rather than a static inline
>> + * function due to its potential application in struct initializers.
>> + *
>> + * Return: jiffies value
>> + */
>> +#define secs_to_jiffies(_secs) ((_secs) * HZ)
>> +
>>  extern unsigned long __usecs_to_jiffies(const unsigned int u);
>>  #if !(USEC_PER_SEC % HZ)
>>  static inline unsigned long _usecs_to_jiffies(const unsigned int u)
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index
>> 0bbad90ddd6f87e87c03859bae48a7901d39b634..7b35c58bbbeb79f2b50a02212771fb2
>> 83ba5643d 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -42,8 +42,6 @@
>>  #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
>>  		 "\x00\x00\x00\x00\x00\x00\x00\x00"
>>
>> -#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
>> -
>>  /* Handle HCI Event packets */
>>
>>  static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
>>
>> --
>> 2.34.1
> 
> All looks good.
> But can you consider naming the macro as s2jiffy()? Just
> to be shorter, so after adopting this macro we don't have
> to split some lines for over 80 characters:)
> 
> Thanks,
> - Haiyang
> 

Thanks for the review! The patch introducing the macro has already been
accepted into timers/core in tip[1], so unfortunately I can't make that
change anymore. For readability considerations, I also find it better to
match the remaining APIs in the jiffies family, i.e. msecs_to_jiffies(),
nsecs_to_jiffies(), usecs_to_jiffies().

[1] https://git.kernel.org/tip/b35108a51cf7bab58d7eace1267d7965978bcdb8

Thanks,
Easwar

