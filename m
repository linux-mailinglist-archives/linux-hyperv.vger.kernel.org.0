Return-Path: <linux-hyperv+bounces-2940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67D96B9B0
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628881C213E6
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FB1CEEAB;
	Wed,  4 Sep 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j6nZpmC+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D3126C01
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Sep 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448210; cv=none; b=Ivc67zuL2LpZ/khZ8FtUL3bQCYSlbvD330D8St3sxiMaFUHcaERY0EsOL63MWxnN1Sct7P9KxMyvrJthZSlqnb6UNVClJ19GTH/V9+EmLGK4o5COVus2UcfXR2LQEwdFw2Ykn5XAvEOH0vi3UA2EeMJns6EHP4uEuC4K7psNLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448210; c=relaxed/simple;
	bh=teecDeEOBARj1Cq+zXv+frcsnRqibjT8FN3Fm011TQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM31/nK8ipKHm9hhxsQ0SipWZfP5JYCCCr76JrE0mtaXEV7iM2/5XAP+Mpb6BJIwodmFIWXbronptFX5X8LOHJR1RcdHp5sTvpVbxm3whMNUY6lTMrXq6Ol06nRdX6IMHAwuDFWESpU/jPxZbNIwClhfr1Cfcn59jJ9YplBMv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j6nZpmC+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.4] (unknown [223.230.33.15])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD34F20B7165;
	Wed,  4 Sep 2024 04:10:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD34F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725448208;
	bh=OpFPRQjdu5nQC09LSb4FVvTexUVY7ZvIp2Fk1SLcnTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j6nZpmC+6trJtX72+X0jT6h0yRADWNLuvdvol0+u/NCBd31J8yqbTso9zN5rR/qS4
	 yyp+Yqgc4109+0gwXMwonNEe0NnemFs+YDjK+X6AigK4QGDPpqQ9Snsc2SY8sLIOTj
	 ITdBMOvnMkukY5Ydk3cu2s9Ti6JlUhU3QqRKjiio=
Message-ID: <fec0bb67-7fc3-4f67-818e-a0439a9822a9@linux.microsoft.com>
Date: Wed, 4 Sep 2024 16:40:04 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] hv: vmbus: Constify struct kobj_type and struct
 attribute_group
To: Hongbo Li <lihongbo22@huawei.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org
References: <20240904011553.2010203-1-lihongbo22@huawei.com>
 <690efd2f-c814-40d0-b017-e93089e814b2@linux.microsoft.com>
 <c4fb0fb3-a787-4946-952d-841599509341@huawei.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <c4fb0fb3-a787-4946-952d-841599509341@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/4/2024 3:48 PM, Hongbo Li wrote:
> 
> 
> On 2024/9/4 18:09, Naman Jain wrote:
>>
>>
>> On 9/4/2024 6:45 AM, Hongbo Li wrote:
>>> The `struct attribute_group` and `struct kobj_type` are not
>>> modified, and they are only used in the helpers which take a
>>> const type parameter.
>>>
>>> Constifying these structure and moving them to a read-only section,
>>> and this can increase over all security.
>>>
>>> ```
>>> [Before]
>>>     text   data    bss    dec    hex    filename
>>>    20568   4699     48  25315   62e3    drivers/hv/vmbus_drv.o
>>>
>>> [After]
>>>     text   data    bss    dec    hex    filename
>>>    20696   4571     48  25315   62e3    drivers/hv/vmbus_drv.o
>>> ```
>>>

...

>>
>> Small thing, I hope you included before and after logs in commit msg to
>> show that some of the data section moved to text as you made these
>> variables constant. If not, please move these after ---.
>>
> You mean remove the '```' or move the whole part after --- ?

Never mind. IMO, mentioning these stats was really optional since we are 
not saving any memory here. This could have been moved to the section 
after --- so that it does not get captured in git log. However there's 
no harm in keeping it where it is. So your call.


Regards,
Naman

> 
> Thanks,
> Hongbo
> 
>>
>> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
>>
>> Regards,
>> Naman


