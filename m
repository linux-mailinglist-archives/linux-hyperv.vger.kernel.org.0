Return-Path: <linux-hyperv+bounces-3213-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F69B5524
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 22:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A604628679A
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF16C20400A;
	Tue, 29 Oct 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="My1ryafL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1543520720D;
	Tue, 29 Oct 2024 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237727; cv=none; b=O5qS4OBZj2vBN50sB9qLwUdS5zleHljlHQqhBitcXoI7phiFwSYUAtc9/Ujpys6UPDd6RVSYPzHR3/F/qHjDSXH0KJDR0ky/7y4ECOu51Z9woMKoe0YOyuvG0+A/9KjRjehWjmwBmgCN+rP069Km+xa1eTaYLJSNGUVNJNIlqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237727; c=relaxed/simple;
	bh=hHzo/wbOlevPanZnfhP7yXufFIuHywm932n25rx8H1I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PMZYOl/OeK3SOoiz/FRQf5Q4ZawGmbn57L+72TWz3tTyZq125pikNUmzCsBcO/lfb+p6FEl6FgJflopRIDEOaUGbVlwO9agGrgUcp09o51a4qu06u60rQXrOoeFiNyyAVrKZ+xArdhrM1Rjo9iZICUplZgmOQdxaO5NVKKzQg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=My1ryafL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.218.219] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 193E22054B46;
	Tue, 29 Oct 2024 14:35:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 193E22054B46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730237725;
	bh=GTG3OYIuFDMSahIf0vIvPWDvl1TaKOfpY+MP90a0Sds=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=My1ryafLYk14vWEQB4C6aqSG6uLExvOK4UOzJSE93H+C8Mnag6JjdIr6rntr8BmZw
	 lK71EbHbDIz8jJL3LCfAEHaSgvI5020Eo/5iSv5fz2AHuUua3Fa0M+Ij5tkAV8SGAZ
	 sPfVS7YkdykxaswXatAhH2nAoi0uJInNCLCcGILU=
Message-ID: <5e4f8c05-45e1-4a92-bfc3-ec66657baa9a@linux.microsoft.com>
Date: Tue, 29 Oct 2024 14:35:25 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
To: Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
 <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
 <87wmhq28o6.ffs@tglx>
 <CAMuHMdWFAgfgM0uCrG4uMz77-Y8CFSnpL-YM_VEFuvKTPNKZ5w@mail.gmail.com>
 <87ed3y255a.ffs@tglx>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <87ed3y255a.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/2024 10:25 AM, Thomas Gleixner wrote:
> On Tue, Oct 29 2024 at 17:22, Geert Uytterhoeven wrote:
>> On Tue, Oct 29, 2024 at 5:08 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>> On Mon, Oct 28 2024 at 19:11, Easwar Hariharan wrote:
>>>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>>>> index 1220f0fbe5bf..e5256bb5f851 100644
>>>> --- a/include/linux/jiffies.h
>>>> +++ b/include/linux/jiffies.h
>>>> @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>>>>       }
>>>>  }
>>>>
>>>> +#define secs_to_jiffies(_secs) ((_secs) * HZ)
>>>
>>> Can you please make that a static inline, as there is no need for macro
>>> magic like in the other conversions, and add a kernel doc comment which
>>> documents this?
>>
>> Note that a static inline means it cannot be used in e.g. struct initializers,
>> which are substantial users of  "<value> * HZ".
> 
> Bah. That wants to be mentioned in the change log then.
> 
> Still the macro should be documented.
> 
> Thanks,
> 
>         tglx

Thanks for the review, I'll add a kernel doc in v3 and mention the
limitations of an inline function.

- Easwar

