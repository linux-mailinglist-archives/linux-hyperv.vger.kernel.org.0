Return-Path: <linux-hyperv+bounces-1735-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E87387976A
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 16:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A260F1F21B65
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240D47C0AD;
	Tue, 12 Mar 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOcCkFbf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C787C0A3;
	Tue, 12 Mar 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256930; cv=none; b=Xa6L33daDuFmpS0pDrBckUq6xIsuCqp2igkyw65DfEm0X5ex+b9IPeE98MUQjV5BcDIMz9DULvYPkT9Y1iX2DuJgv0m9f/r/AefOp0TAaNLIjo8OcHK9V3EokgTeLx2ipP3nwPkAEw47EmocIqTpydl6cjbRpsUbW/oGh1/pQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256930; c=relaxed/simple;
	bh=/Ijo8rHPf1fyrPquGh0hCXAuvhCZNBSsRG3Zru7uFyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3OSDvbkUvozDCvppX3oZSyogi9EOCftmDXxTNJTDA2qzAyHakEqfBRyl1YVlQN5auM+FUpuITZfYAgbV2eJbVorHVVPMYeLj1K4IDL8fdxmSwnqOAiMSF6RyqbOznMC58KRjWMKAa5ph+6X1kDE/OH089sRSRZnhnnGxcjEvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOcCkFbf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710256929; x=1741792929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Ijo8rHPf1fyrPquGh0hCXAuvhCZNBSsRG3Zru7uFyM=;
  b=jOcCkFbf2yBifM4x9VufuOXdMSquzzrPwWj9IdpdpZIEjIVabCAL6jLT
   sxWw+Yot+XIFoTi1nSv6s0SbqJgpIHHvDuEHnZDXi76FU8T9ReuSgWzIX
   osjqigxiseo09n3i4DvUH6OIaLlw2NOcA2VW1cC7QOJV47ZHkd/JhWMzg
   bibAcK8EHQKjzxEXTEpHRxfrsWqJJ5/wqFbzWSuv7dOGtUPRIeIXUWZij
   WkaOWMRzgGYdYgjte74mEL7PNc+HlfQqgsap9UuJoLLoSkPeAwuKFC/Ji
   ZXmt79oMWx1EkK7HndYxkfStV+F1OubYasL61tqxMaiWw7wz+DK0mKKGL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5103847"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5103847"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11534111"
Received: from hhutton-mobl1.amr.corp.intel.com (HELO [10.209.25.241]) ([10.209.25.241])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:22:07 -0700
Message-ID: <4e6627b2-30cd-4c50-bf2f-24cf845cd4bc@linux.intel.com>
Date: Tue, 12 Mar 2024 08:22:06 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Cc: "elena.reshetova@intel.com" <elena.reshetova@intel.com>
References: <20240311161558.1310-1-mhklinux@outlook.com>
 <20240311161558.1310-3-mhklinux@outlook.com>
 <13581af9-e5f0-41ca-939f-33948b2133e7@linux.intel.com>
 <SN6PR02MB415742AEEE7F1389D80B6E51D42B2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <SN6PR02MB415742AEEE7F1389D80B6E51D42B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/11/24 11:07 PM, Michael Kelley wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> On 3/11/24 9:15 AM, mhkelley58@gmail.com wrote:
>>> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>>
>>> In CoCo VMs it is possible for the untrusted host to cause
>>> set_memory_encrypted() or set_memory_decrypted() to fail such that an
>>> error is returned and the resulting memory is shared. Callers need to
>>> take care to handle these errors to avoid returning decrypted (shared)
>>> memory to the page allocator, which could lead to functional or security
>>> issues.
>>>
>>> In order to make sure callers of vmbus_establish_gpadl() and
>>> vmbus_teardown_gpadl() don't return decrypted/shared pages to
>>> allocators, add a field in struct vmbus_gpadl to keep track of the
>>> decryption status of the buffers. This will allow the callers to
>>> know if they should free or leak the pages.
>>>
>>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>> ---
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>  drivers/hv/channel.c   | 25 +++++++++++++++++++++----
>>>  include/linux/hyperv.h |  1 +
>>>  2 files changed, 22 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
>>> index 56f7e06c673e..bb5abdcda18f 100644
>>> --- a/drivers/hv/channel.c
>>> +++ b/drivers/hv/channel.c
>>> @@ -472,9 +472,18 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>>>  		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
>>>
>>>  	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		gpadl->decrypted = false;
>> Why not set it by default at the beginning of the function?
> I considered doing that.  But it's an extra step to execute in the normal
> path, because a couple of lines below it is always set to "true".  But
> I don't have a strong preference either way.
>

Got it. I am fine either way.

>>>  		return ret;
>>> +	}
>>>
>>> +	/*
>>> +	 * Set the "decrypted" flag to true for the set_memory_decrypted()
>>> +	 * success case. In the failure case, the encryption state of the
>>> +	 * memory is unknown. Leave "decrypted" as true to ensure the
>>> +	 * memory will be leaked instead of going back on the free list.
>>> +	 */
>>> +	gpadl->decrypted = true;
>>>  	ret = set_memory_decrypted((unsigned long)kbuffer,
>>>  				   PFN_UP(size));
>>>  	if (ret) {
>>> @@ -563,9 +572,15 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>>>
>>>  	kfree(msginfo);
>>>
>>> -	if (ret)
>>> -		set_memory_encrypted((unsigned long)kbuffer,
>>> -				     PFN_UP(size));
>>> +	if (ret) {
>>> +		/*
>>> +		 * If set_memory_encrypted() fails, the decrypted flag is
>>> +		 * left as true so the memory is leaked instead of being
>>> +		 * put back on the free list.
>>> +		 */
>>> +		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
>>> +			gpadl->decrypted = false;
>>> +	}
>>>
>>>  	return ret;
>>>  }
>>> @@ -886,6 +901,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
>>>  	if (ret)
>>>  		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
>> Will this be called only if vmbus_establish_gpad() is successful? If not, you
>> might want to skip set_memory_encrypted() call for decrypted = false case.
> It's only called if vmbus_establish_gpadl() is successful.  I agree
> we don't want to call set_memory_encrypted() if the
> set_memory_decrypted() wasn't executed or it failed.  But 
> vmbus_teardown_gpadl() is never called with decrypted = false.

Since you rely on  vmbus_teardown_gpadl() callers, personally I think it
is better to add that check. It is up to you.

>>> +	gpadl->decrypted = ret;
>>> +
>> IMO, you can set it to false by default. Any way with non zero return, user
>> know about the decryption failure.
> I don’t agree, but feel free to explain further if my thinking is
> flawed.
>
> If set_memory_encrypted() fails, we want gpadl->decrypted = true.
> Yes, the caller can see that vmbus_teardown_gpadl() failed,
> but there's also a memory allocation failure, so the caller
> would have to distinguish error codes.  And the caller isn't
> necessarily where the memory is freed (or leaked).  We
> want the decrypted flag to be correct so the code that
> eventually frees the memory can decide to leak instead of
> freeing.

I agree. I understood this part after looking at the rest of the series.

>
> Michael
>
>>>  	return ret;
>>>  }
>>>  EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
>>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>>> index 2b00faf98017..5bac136c268c 100644
>>> --- a/include/linux/hyperv.h
>>> +++ b/include/linux/hyperv.h
>>> @@ -812,6 +812,7 @@ struct vmbus_gpadl {
>>>  	u32 gpadl_handle;
>>>  	u32 size;
>>>  	void *buffer;
>>> +	bool decrypted;
>>>  };
>>>
>>>  struct vmbus_channel {
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


