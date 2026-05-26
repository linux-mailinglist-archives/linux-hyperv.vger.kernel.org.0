Return-Path: <linux-hyperv+bounces-11200-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO6qLkfMFWq6bwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11200-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:37:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D92F5D9CFA
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321603109277
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5AD280335;
	Tue, 26 May 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L+D303vH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE3B36F411
	for <linux-hyperv@vger.kernel.org>; Tue, 26 May 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810562; cv=none; b=ZwAfCdgls5Hte0L5Eaaa9+4hG/49T52U3o2zRg+quEcUMxzyPPzEUG6++oJ3i72DmSHVgl+oI9o+AfRkN3ykvvge2Sh29iQs6By8do6krhIR+jhfzU2F1WXjvgxPZr4uXF2iPUbC8Cng/y8RJHP9iu4yxrr1GYoOiaZw2L6Bp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810562; c=relaxed/simple;
	bh=mldW+FqN2tuFV/R2Qc2rAw3KO1WlmbGLMRNB+4eMF1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOBd+ti0J2vDD8pVNLhjWgs8jRdaquH35A7ATMS6vbvmWsU9jQuleen2dnTWUPdV203tEJN6aW69+9IW9kWpFLu954lGBulgLMble8553DoR87YJ63UYsfw+kWfrh9pgmdNYg4apzCyB4nJOktke51pTipT8A3uwmAmYTNqi0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L+D303vH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.32.138] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 24C6620B7167;
	Tue, 26 May 2026 08:49:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24C6620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779810550;
	bh=2rsOsO0F2OdpXecHsQuXZNqPYbgmZktFcquH67AKQlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L+D303vHi9O1rm+pQ7WQt0nF6PWV/dvSQgeVjL0zHwm69wPzLqA2qwiTnz6U6sKpn
	 3fI0hHJWlox+WzxN9DHmRHTYzKp4qHSwSK1HGwaq5tkcU+2n/tCDZ3ZKEnZiT7FeT5
	 zs83ksRAcKRYor6je7RY3kvaUs8q1+gtuUnxX7RE=
Message-ID: <90cf179e-3b00-4bf9-8551-ccfb604c2ffd@linux.microsoft.com>
Date: Tue, 26 May 2026 21:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio_hv_generic: Bind to FCopy device by default
To: Michael Kelley <mhklinux@outlook.com>, Ben Hutchings <benh@debian.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <aa420dc1-029c-408b-aef0-f02d6bfa002c@linux.microsoft.com>
 <SN6PR02MB41574FDA377FF59597181B7BD40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41574FDA377FF59597181B7BD40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11200-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,debian.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 5D92F5D9CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/2026 8:45 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, May 26, 2026 3:10 AM
>>
>> On 5/26/2026 1:59 PM, Ben Hutchings wrote:
>>> On Tue, 2026-05-26 at 12:15 +0530, Naman Jain wrote:
>>>>
>>>> On 5/25/2026 5:34 PM, Ben Hutchings wrote:
>>>>> The Hyper-V kernel-mode fcopy driver was removed in 6.10 and the new
>>>>> fcopy daemon requires this uio driver to function.  However, by
>>>>> default the driver does not bind to any devices, and must be
>>>>> configured through the sysfs "new_id" file.
>>>>>
>>>>> Since the FCopy device is now only usable through this driver, add its
>>>>> ID to the driver's ID table so that the daemon will work "out of the
>>>>> box".
>>>>>
>>>>> Signed-off-by: Ben Hutchings <benh@debian.org>
>>>>> Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
>>>>> ---
>>>>> --- a/drivers/uio/uio_hv_generic.c
>>>>> +++ b/drivers/uio/uio_hv_generic.c
>>>>> @@ -395,9 +395,15 @@ hv_uio_remove(struct hv_device *dev)
>>>>>     	vmbus_free_ring(dev->channel);
>>>>>     }
>>>>>
>>>>> +static const struct hv_vmbus_device_id hv_uio_id_table[] = {
>>>>> +	{ HV_FCOPY_GUID },
>>>>> +	{}
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(vmbus, hv_uio_id_table);
>>>>> +
>>>>>     static struct hv_driver hv_uio_drv = {
>>>>>     	.name = "uio_hv_generic",
>>>>> -	.id_table = NULL, /* only dynamic id's */
>>>>> +	.id_table = hv_uio_id_table,
>>>>>     	.probe = hv_uio_probe,
>>>>>     	.remove = hv_uio_remove,
>>>>>     };
>>>>
>>
>> ++ recipients, assuming you mistakenly clicked reply instead of reply all.
> 
> Ben --
> 
> Regarding recipients, please include the full LKML
> (linux-kernel@vger.kernel.org) on the original patch posting, even
> though it is about a narrow Hyper-V issue. I dabble in areas beyond
> just Hyper-V so subscribe to the full LKML instead of the
> linux-hyperv mailing list. I miss patches like this one unless I happen
> to be looking through the lore.kernel.org archives for linux-hyperv.
> 
> Thx,
> 
> Michael
> 
Sashiko also misses out on such patches if linux-kernel@vger.kernel.org 
is not included. I could not find this in https://sashiko.dev/#/.

Regards,
Naman

