Return-Path: <linux-hyperv+bounces-6450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED095B17412
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Jul 2025 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC11C26729
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Jul 2025 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92301C5F06;
	Thu, 31 Jul 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GVVs9BMK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA2D515;
	Thu, 31 Jul 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976620; cv=none; b=ktdBImoD8yRxr9KSGYgYtIIVAdaS7jKjdeZ+LzlK9rbSImgKThQhIxMQsDsuvV92EC+i/72s21uxPnEZXvHom94DtEDWodRcgCdL9JaDZaruQaeBvoLAMShrKQushw0de7KEwDjJxJ0UYvaV84Vf0DjjytqOjDh1G02DW9k9HL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976620; c=relaxed/simple;
	bh=pXDN5BVQvE+Lf+U4XpfBddw3aUhzamvB5vMx6LuxteE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgckIvYvEkZ186UC8DW5Evf6EHESev4ypAUO+/MEY2cXst1IvHIFpGhIYXISTuSUxK0+ZPjtwT6eFSXXo+gqBQy/P1yawB5vWr0rEI5M9UuCKt1GpMcE7wxagJvUv2Y17wqo6sCLGr1MeD+D45edvgTP/Yx575enb0QPV5x/grk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GVVs9BMK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.64.80] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FF432117669;
	Thu, 31 Jul 2025 08:43:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF432117669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753976612;
	bh=Q5WATQ/rql3wsSDIyfkwGauwnqHAuGg6FZHUhagfDbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GVVs9BMKe16JeC7NuOagTIy+oxap9EhwgxZI1d7J0wh1OVF2XP8v9+xYdp4n8DiDc
	 MhicKJpoFwqTj96B+NeWxvDTGeYkzllsLyW/MrGBjQKeBZVI6EhAS41ubF245puZcY
	 /QJU7XJBCsaEG2hLq9FfL24+IiRiRzXDd8mxujaQ=
Message-ID: <4abf15ac-de18-48d4-9420-19d40f26fdd2@linux.microsoft.com>
Date: Thu, 31 Jul 2025 21:13:27 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
To: Michael Kelley <mhklinux@outlook.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Long Li <longli@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250723070200.2775-1-namjain@linux.microsoft.com>
 <SN6PR02MB41579080792040E166B5EB69D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e1d394bd-93a6-4d8f-b7f9-fc01449df98a@t-8ch.de>
 <SN6PR02MB415792B00B021D4DB76A6014D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415792B00B021D4DB76A6014D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/30/2025 1:15 AM, Michael Kelley wrote:
> From: Thomas Weißschuh <linux@weissschuh.net> Sent: Tuesday, July 29, 2025 11:47 AM
>>
>> On 2025-07-29 18:39:45+0000, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, July 23, 2025 12:02 AM
>>>>
>>>> The ring buffer size varies across VMBus channels. The size of sysfs
>>>> node for the ring buffer is currently hardcoded to 4 MB. Userspace
>>>> clients either use fstat() or hardcode this size for doing mmap().
>>>> To address this, make the sysfs node size dynamic to reflect the
>>>> actual ring buffer size for each channel. This will ensure that
>>>> fstat() on ring sysfs node always returns the correct size of
>>>> ring buffer.
>>>>
>>>> This is a backport of the upstream commit
>>>> 65995e97a1ca ("Drivers: hv: Make the sysfs node size for the ring buffer dynamic")
>>>> with modifications, as the original patch has missing dependencies on
>>>> kernel v6.12.x. The structure "struct attribute_group" does not have
>>>> bin_size field in v6.12.x kernel so the logic of configuring size of
>>>> sysfs node for ring buffer has been moved to
>>>> vmbus_chan_bin_attr_is_visible().
>>>>
>>>> Original change was not a fix, but it needs to be backported to fix size
>>>> related discrepancy caused by the commit mentioned in Fixes tag.
>>>>
>>>> Fixes: bf1299797c3c ("uio_hv_generic: Align ring size to system page")
>>>> Cc: <stable@vger.kernel.org> # 6.12.x
>>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>>> ---
>>>>
>>>> This change won't apply on older kernels currently due to missing
>>>> dependencies. I will take care of them after this goes in.
>>>>
>>>> I did not retain any Reviewed-by or Tested-by tags, since the code has
>>>> changed completely, while the functionality remains same.
>>>> Requesting Michael, Dexuan, Wei to please review again.
>>>>
>>>> ---
>>>>   drivers/hv/vmbus_drv.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>>> index 1f519e925f06..616e63fb2f15 100644
>>>> --- a/drivers/hv/vmbus_drv.c
>>>> +++ b/drivers/hv/vmbus_drv.c
>>>> @@ -1810,7 +1810,6 @@ static struct bin_attribute chan_attr_ring_buffer = {
>>>>   		.name = "ring",
>>>>   		.mode = 0600,
>>>>   	},
>>>> -	.size = 2 * SZ_2M,
>>>>   	.mmap = hv_mmap_ring_buffer_wrapper,
>>>>   };
>>>>   static struct attribute *vmbus_chan_attrs[] = {
>>>> @@ -1866,6 +1865,7 @@ static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
>>>>   	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
>>>>   	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
>>>>   		return 0;
>>>> +	attr->size = channel->ringbuffer_pagecount << PAGE_SHIFT;
>>>
>>> Suppose a VM has two devices using UIO, such as DPDK network device with
>>> a 2MiB ring buffer, and an fcopy device with a 16KiB ring buffer. Both devices
>>> will be referencing the same static instance of chan_attr_ring_buffer, and the
>>> .size field it contains. The above statement will change that .size field
>>> between 2MiB and 16KiB as the /sys entries are initially populated, and as
>>> the visibility is changed if the devices are removed and re-instantiated (which
>>> is much more likely for fcopy than for netvsc). That changing of the .size
>>> value will probably work most of the time, but it's racy if two devices with
>>> different ring buffer sizes get instantiated or re-instantiated at the same time.
>>
>> IIRC it works out in practice. While the global attribute instance is indeed
>> modified back-and-forth the size from it will be *copied* into kernfs
>> after each recalculation. So each attribute should get its own correct size.
> 
> The race I see is in fs/sysfs/group.c in the create_files() function. It calls the
> is_bin_visible() function, which this patch uses to set the .size field of the static
> attribute. Then creates_files() calls sysfs_add_bin_file_mode_ns(), which reads
> the .size field and uses it to create the sysfs entry. But if create_files() is called
> in parallel on two different kobjs of the same type, but with different values
> for the .size field, the second create_files() could overwrite the static .size
> field after the first create_files() has set it, but before it has used it. I don't
> see any global lock that would prevent such, though maybe I'm missing
> something.
> 
>>
>>> Unfortunately, I don't see a fix, short of backporting support for the
>>> .bin_size function, as this is exactly the problem that function solves.
>>
>> It should work out in practice. (I introduced the .bin_size function)
> 
> The race I describe is unlikely, particularly if attribute groups are created
> once and then not disturbed. But note that the Hyper-V fcopy group can
> get updated in a running VM via update_sysfs_group(), which also calls
> create_files(). Such an update might marginally increase the potential for
> the race and for getting the wrong size. Still, I agree it should work out
> in practice.
> 
> Michael
> 
>>
>> Thomas


hi Thomas,
Would it be possible to port your changes on 6.12 kernel, to avoid such
race conditions? Or if it has a lot of dependencies, or if you have a
follow-up advice, please let us us know.

Thanks,
Naman


