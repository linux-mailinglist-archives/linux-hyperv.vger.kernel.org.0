Return-Path: <linux-hyperv+bounces-2946-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E627196CC21
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 03:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4044281754
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B008F66;
	Thu,  5 Sep 2024 01:15:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB698F40
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Sep 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498902; cv=none; b=gsXKWX/925sQJYYGP6SyIug+2p2n+ct/kod6qQbY7u+HidbRyJrEdS9upCQY7Yo4Obw7yPl1BKsSuKmkRikwxl8wem932i5Qbp1iLlqLApiE+MeEd6k9COYCkkKX/JfAvAP/qf4pgb7oxrP53Ri72sQjcD6Wehs8MORJvWuE9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498902; c=relaxed/simple;
	bh=sOTIxRvOCs1Ijt8PAYcD4XG4thsD5EAQ+1TVOTbWsq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uol+pucH0oq8RnkM0wsFtXoI5thEhaqAk7LPN5UNWuO9Y9xTmjUqMLivNK2GEXcMmF+V6bgeobqyMeA8AXYaKoAbb6Gw6uohks8x9gvhhPeK8WiMCPevpUD+iwgJRdinEXsXD+ftRvu9e4md9RPm7mO42Y1mDqi1ZyXutepwIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wzh9M6Y47z20nLG;
	Thu,  5 Sep 2024 09:09:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A3A951400FD;
	Thu,  5 Sep 2024 09:14:57 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 09:14:57 +0800
Message-ID: <4ff906fd-406e-4b7f-bdbb-e35c04e95c59@huawei.com>
Date: Thu, 5 Sep 2024 09:14:56 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] hv: vmbus: Constify struct kobj_type and struct
 attribute_group
Content-Language: en-US
To: Naman Jain <namjain@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>
CC: <linux-hyperv@vger.kernel.org>
References: <20240904011553.2010203-1-lihongbo22@huawei.com>
 <690efd2f-c814-40d0-b017-e93089e814b2@linux.microsoft.com>
 <c4fb0fb3-a787-4946-952d-841599509341@huawei.com>
 <fec0bb67-7fc3-4f67-818e-a0439a9822a9@linux.microsoft.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <fec0bb67-7fc3-4f67-818e-a0439a9822a9@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/4 19:10, Naman Jain wrote:
> 
> 
> On 9/4/2024 3:48 PM, Hongbo Li wrote:
>>
>>
>> On 2024/9/4 18:09, Naman Jain wrote:
>>>
>>>
>>> On 9/4/2024 6:45 AM, Hongbo Li wrote:
>>>> The `struct attribute_group` and `struct kobj_type` are not
>>>> modified, and they are only used in the helpers which take a
>>>> const type parameter.
>>>>
>>>> Constifying these structure and moving them to a read-only section,
>>>> and this can increase over all security.
>>>>
>>>> ```
>>>> [Before]
>>>>     text   data    bss    dec    hex    filename
>>>>    20568   4699     48  25315   62e3    drivers/hv/vmbus_drv.o
>>>>
>>>> [After]
>>>>     text   data    bss    dec    hex    filename
>>>>    20696   4571     48  25315   62e3    drivers/hv/vmbus_drv.o
>>>> ```
>>>>
> 
> ...
> 
>>>
>>> Small thing, I hope you included before and after logs in commit msg to
>>> show that some of the data section moved to text as you made these
>>> variables constant. If not, please move these after ---.
>>>
>> You mean remove the '```' or move the whole part after --- ?
> 
> Never mind. IMO, mentioning these stats was really optional since we are 
> not saving any memory here. This could have been moved to the section 
> after --- so that it does not get captured in git log.
Thank you, I got it and have learned something.

Thanks,
Hongbo

  However there's
> no harm in keeping it where it is. So your call.
> 
> 
> Regards,
> Naman
> 
>>
>> Thanks,
>> Hongbo
>>
>>>
>>> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
>>>
>>> Regards,
>>> Naman
> 

