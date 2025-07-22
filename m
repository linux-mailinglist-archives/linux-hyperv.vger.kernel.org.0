Return-Path: <linux-hyperv+bounces-6321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94377B0D5A2
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4901216F6A9
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC72DCBE0;
	Tue, 22 Jul 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lxwv97uz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F172D8784;
	Tue, 22 Jul 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175812; cv=none; b=G+oNA9g71Qhmt8ihfReF3riWdOdJbzjgqoVxMaxJIUkUAafB0LrUExciz54q75WAmWr6qdLdN9DF7r238lRlfNtsfJw90JPR/tetvfqfanbHhDZ8YKM83dem4AYL8Kd1koglgKTFPLjlpaIY/zwD1oqtH2QC/fJnxOablDmgo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175812; c=relaxed/simple;
	bh=AKKR2nhGT74/5KBJ8HpjjiMYY/nLAehDtHvNEsmzrXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsHrltFDvS+ZPMFczPiFcRrSoaI3OzQ5bighb/wWL/jHIS/gjfuIXpX2I4hOfvl2TVgCem788x09OUr3YT2eK3/Xr4IoL1lz1+bGEsrqLzBsErsPjjkFvBBQphI0rdph966ouNbAjEi3dmfBINo1jcCXqV3PqX4wWZNBmUbl1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lxwv97uz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F74F2117659;
	Tue, 22 Jul 2025 02:16:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F74F2117659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753175810;
	bh=rb1j+cJyXgExNMxi6vnnslq4paR3vV0/fOhrrbzDsu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lxwv97uz04ZKlOoHFuWnO4Wf+ovpZRC1Gat/SiKEs0A0ed/JHm1Ox3oicvY/8y5r0
	 +5muPfC2+D5vk0ztXM9YLZDj1aLT8fzKxgRh9zEfe6JV7J3mNUfFQRsMuVZTI3o7LA
	 ENFnwOBAYI+fWZCHrl2osfLQNTGBmtjV4HsCW/CM=
Message-ID: <cf2ec1ca-c65b-4e32-8aaf-75b77d294092@linux.microsoft.com>
Date: Tue, 22 Jul 2025 14:46:43 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Markus Elfring <Markus.Elfring@web.de>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
References: <20250611072704.83199-3-namjain@linux.microsoft.com>
 <68120ea5-d3ba-4077-a605-50a0b5188761@web.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <68120ea5-d3ba-4077-a605-50a0b5188761@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/20/2025 12:00 AM, Markus Elfring wrote:
> …
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -0,0 +1,1783 @@
> …
>> +static int mshv_vtl_sint_ioctl_set_eventfd(struct mshv_vtl_set_eventfd __user *arg)
>> +{
> …
>> +	mutex_lock(&flag_lock);
>> +	old_eventfd = flag_eventfds[set_eventfd.flag];
>> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
>> +	mutex_unlock(&flag_lock);
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&flag_lock);”?
> https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L225
> 
> Regards,
> Markus

I didn't know about it, TBH. I will use it in this driver in all places.
I have tested the same in my setup.

Thanks.

Regards,
Naman

