Return-Path: <linux-hyperv+bounces-2938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1596B81C
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2E285D20
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015041CCB24;
	Wed,  4 Sep 2024 10:19:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA01CCB29
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Sep 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445143; cv=none; b=IijFojLVspne4EW+0S31g5tUmDsbIcLoergokCjQ9+SPD2aAkLQ33iQEPyK0xk9lrY3EhhTL5+ybSSNv6GuUaKayM/S0lxkLRpe2T1x10EftcvdLsf8vPA6T2QdCAFf44x6klwFcD5DunWo29yz18K0bLqSq+J19X7BwrzYQdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445143; c=relaxed/simple;
	bh=PrwGL8W62EYyBOaTBtpZ4MlHRh0L65CjUgOacZKef10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fkJOjbVPg4fHh2G6c2PNyXnbySf7u98ygFd8FSb+J+WUP70zBnUCpf8Qar9DPoIF7EnUTqVSqzFfRdBukkGZnBAnr35Nj+ycJZNKM5PE46Lm9Vct+Rqf+nxNj/X1+giY6dCS+Vrsee8OdB0HHZSQt6i7ZTeFlY6bnHUWR6Ekbd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WzJN25FgWzyQwr;
	Wed,  4 Sep 2024 18:17:54 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6422F1800D2;
	Wed,  4 Sep 2024 18:18:52 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 18:18:52 +0800
Message-ID: <c4fb0fb3-a787-4946-952d-841599509341@huawei.com>
Date: Wed, 4 Sep 2024 18:18:51 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] hv: vmbus: Constify struct kobj_type and struct
 attribute_group
To: Naman Jain <namjain@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>
CC: <linux-hyperv@vger.kernel.org>
References: <20240904011553.2010203-1-lihongbo22@huawei.com>
 <690efd2f-c814-40d0-b017-e93089e814b2@linux.microsoft.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <690efd2f-c814-40d0-b017-e93089e814b2@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/4 18:09, Naman Jain wrote:
> 
> 
> On 9/4/2024 6:45 AM, Hongbo Li wrote:
>> The `struct attribute_group` and `struct kobj_type` are not
>> modified, and they are only used in the helpers which take a
>> const type parameter.
>>
>> Constifying these structure and moving them to a read-only section,
>> and this can increase over all security.
>>
>> ```
>> [Before]
>>     text   data    bss    dec    hex    filename
>>    20568   4699     48  25315   62e3    drivers/hv/vmbus_drv.o
>>
>> [After]
>>     text   data    bss    dec    hex    filename
>>    20696   4571     48  25315   62e3    drivers/hv/vmbus_drv.o
>> ```
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   drivers/hv/vmbus_drv.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 7242c4920427..71fd8b97df33 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1831,12 +1831,12 @@ static umode_t 
>> vmbus_chan_attr_is_visible(struct kobject *kobj,
>>       return attr->mode;
>>   }
>> -static struct attribute_group vmbus_chan_group = {
>> +static const struct attribute_group vmbus_chan_group = {
>>       .attrs = vmbus_chan_attrs,
>>       .is_visible = vmbus_chan_attr_is_visible
>>   };
>> -static struct kobj_type vmbus_chan_ktype = {
>> +static const struct kobj_type vmbus_chan_ktype = {
>>       .sysfs_ops = &vmbus_chan_sysfs_ops,
>>       .release = vmbus_chan_release,
>>   };
> 
> 
> Small thing, I hope you included before and after logs in commit msg to
> show that some of the data section moved to text as you made these
> variables constant. If not, please move these after ---.
> 
You mean remove the '```' or move the whole part after --- ?

Thanks,
Hongbo

> 
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> 
> Regards,
> Naman

