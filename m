Return-Path: <linux-hyperv+bounces-6355-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E6B0EEF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88441658BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57F285067;
	Wed, 23 Jul 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="du77Rz7C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC15280325;
	Wed, 23 Jul 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264721; cv=none; b=oss6Br+30YhBH7qBhCFRQcDEAl/UOVKEW41GJXARu6ZqddzRbA4QNY75o7XTQCoyq8ZjAkKFwpgmtbJCL84VEIZSAZqMQAlkITyDWXIg9JdhGWghkOT878OCHHJfbEM7SH3V537SXV/ilWAB+hhmN0O7Dd1soy+nMC7/wNsfL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264721; c=relaxed/simple;
	bh=dN0QGtRq00X4czGYlekLehlE7UXrAkuJharj9Zc9JIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8ZQvZ+ihVbg1cFxU1kK5LW9WbWiXx98KnFgT5VzIwlv74LMMCy55+PxC+co4GfzqcMWh5xwDX7FoQDKBfhlg1M2LAcoC9M3zDqxNvRpsc/tsms9vDaEp9kmKgSO361tUkxlIep6iIS/U55NOFL4LJto9VMZH3gzzYMMeMwtfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=du77Rz7C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.232.149] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 77B492126893;
	Wed, 23 Jul 2025 02:58:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77B492126893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753264719;
	bh=FVw2bOb/oYlcoOsK7minTN/cKz/3JJZ05ZWyPir+H6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=du77Rz7C0ECRJJ8ICpO4W75zy7egSP47mg8MsH9e8QQr/ytTM26ecues8nc5vPKxn
	 DOdvNldo/E+yVr0TCwEhyPOWvIsPF/m0rwvSO7gUrtHtoL2ssQxlnYmQNmWyrYfUEM
	 r7k+OK6R96hhFs71T8SsOEoqz1MR/f/GE6iKafdw=
Message-ID: <829f0716-d2f2-449f-8f49-397a46046c69@linux.microsoft.com>
Date: Wed, 23 Jul 2025 15:28:33 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250611072704.83199-1-namjain@linux.microsoft.com>
 <20250611072704.83199-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <42bc5294-219f-4c26-ad05-740f6190aff3@linux.microsoft.com>
 <SN6PR02MB415781ABC3D523B719BDE280D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <5bf4e550-34e1-4b6b-8ee2-137681a72d42@linux.microsoft.com>
 <SN6PR02MB41578D18024EC5339690046CD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41578D18024EC5339690046CD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/2025 10:39 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, July 22, 2025 4:09 AM
>>
>> On 7/18/2025 8:37 PM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 17, 2025 9:36 PM
>>>>
>>>> On 7/9/2025 10:49 PM, Michael Kelley wrote:
>>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, June 11, 2025 12:27 AM
>>>
>>> [snip]
>>>
>>>>
>>>>> Separately, "allow_bitmap" size is 64K bytes, or 512K bits. Is that the
>>>>> correct size?  From looking at mshv_vtl_hvcall_is_allowed(), I think this
>>>>> bitmap is indexed by the HV call code, which is a 16 bit value. So you
>>>>> only need 64K bits, and the size is too big by a factor of 8. In any case,
>>>>> it seems like the size should not be expressed in terms of PAGE_SIZE.
>>>>
>>>> There are HVcall codes which are of type u16. So max(HVcall code) =
>>>> 0xffff.
>>>>
>>>> For every HVcall that needs to be allowed, we are saving HVcall code
>>>> info in a bitmap in below fashion:
>>>> if x = HVCall code and bitmap is an array of u64, of size
>>>> ((0xffff/64=1023) + 1)
>>>>
>>>> bitmap[x / 64] = (u64)1 << (x%64);
>>>>
>>>> Later on in mshv_vtl_hvcall_is_allowed(), we calculate the array index
>>>> by dividing it by 64, and then see if call_code/64 bit is set.
>>>
>>> I didn't add comments in mshv_vtl_hvcall_is_allowed(), but that code
>>> can be simplified by recognizing that the Linux kernel bitmap utilities
>>> can operate on bitmaps that are much larger than just 64 bits. Let's
>>> assume that the allow_bitmap field in struct mshv_vtl_hvcall_fds has
>>> 64K bits, regardless of whether it is declared as an array of u64,
>>> an array of u16, or an array of u8. Then mshv_vtl_hvcall_is_allowed()
>>> can be implemented as a single line:
>>>
>>> 	return test_bit(call_code, fd->allow_bitmap);
>>>
>>> There's no need to figure out which array element contains the bit,
>>> or to construct a mask to select that particular bit in the array element.
>>> And since call_code is a u16, test_bit won't access outside the allocated
>>> 64K bits.
>>>
>>
>> I understood it now. This works and is much better. Will incorporate it
>> in next patch.
>>
>>>>
>>>> Coming to size of allow_bitmap[], it is independent of PAGE_SIZE, and
>>>> can be safely initialized to 1024 (reducing by a factor of 8).
>>>> bitmap_size's maximum value is going to be 1024 in current
>>>> implementation, picking u64 was not mandatory, u16 will also work. Also,
>>>> item_index is also u16, so I should make bitmap_size as u16.
>>>
>>> The key question for me is whether bitmap_size describes the number
>>> of bits in allow_bitmap, or whether it describes the number of array
>>> elements in the declared allow_bitmap array. It's more typical to
>>> describe a bitmap size as the number of bits. Then the value is
>>> independent of the array element size, as the array element size
>>> usually doesn't really matter anyway if using the Linux kernel's
>>> bitmap utilities. The array element size only matters in allocating
>>> the correct amount of space is for whatever number of bits are
>>> needed in the bitmap.
>>>
>>
>> I tried to put your suggestions in code. Please let me know if below
>> works. I tested this and it works. Just that, I am a little hesitant in
>> changing things on Userspace side of it, which passes these parameters
>> in IOCTL. This way, userspace remains the same, the confusion of names
>> may go away, and the code becomes simpler.
> 
> Yes, I suspected there might be constraints due to not wanting
> to disturb existing user space code.
> 
>>
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -332,7 +332,7 @@ struct mshv_vtl_set_poll_file {
>>    };
>>
>>    struct mshv_vtl_hvcall_setup {
>> -       __u64 bitmap_size;
>> +       __u64 bitmap_array_size;
>>           __u64 allow_bitmap_ptr; /* pointer to __u64 */
>>    };
>>
>>
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -52,10 +52,12 @@ static bool has_message;
>>    static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
>>    static DEFINE_MUTEX(flag_lock);
>>    static bool __read_mostly mshv_has_reg_page;
>> -#define MAX_BITMAP_SIZE 1024
>> +
>> +/* hvcall code is of type u16, allocate a bitmap of size (1 << 16) to accomodate it */
> 
> s/accomodate/accommodate/	

Acked.

> 
>> +#define MAX_BITMAP_SIZE (1 << 16)
>>
>>    struct mshv_vtl_hvcall_fd {
>> -       u64 allow_bitmap[MAX_BITMAP_SIZE];
>> +       u64 allow_bitmap[MAX_BITMAP_SIZE / 64];
> 
> OK, this seems like a reasonable approach to get the correct
> number of bits.
> 
>>           bool allow_map_initialized;
>>           /*
>>            * Used to protect hvcall setup in IOCTLs
>>
>> @@ -1204,12 +1207,12 @@ static int mshv_vtl_hvcall_do_setup(struct mshv_vtl_hvcall_fd *fd,
>>                              sizeof(struct mshv_vtl_hvcall_setup))) {
>>                   return -EFAULT;
>>           }
>> -       if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
>> +       if (hvcall_setup.bitmap_array_size > ARRAY_SIZE(fd->allow_bitmap)) {
>>                   return -EINVAL;
>>           }
>>           if (copy_from_user(&fd->allow_bitmap,
>>                              (void __user *)hvcall_setup.allow_bitmap_ptr,
>> -                          hvcall_setup.bitmap_size)) {
>> +                          hvcall_setup.bitmap_array_size)) {
> 
> This still doesn't work. copy_from_user() expects a byte count as its
> 3rd argument. If we have 64K bits in the bitmap, that means 8K bytes,
> and 1K for bitmap_array_size. So the value of the 3rd argument
> here is 1K, and you'll be copying 1K bytes when you want to be
> copying 8K bytes. The 3rd argument needs to be:
> 
> 		hv_call_setup.bitmap_array_size * sizeof(u64)
> 
> It's a bit messy to have to add this multiply, and in the bigger
> picture it might be cleaner to have the bitmap_array be
> declared in units of u8 instead of u64, but that would affect
> user space in a way that you probably want to avoid.
> 
> Have you checked that user space is passing in the correct values
> to the ioctl? If the kernel side code is wrong, user space might be
> wrong as well. And if user space is wrong, then you might have
> the flexibility to change everything to use u8 instead of u64.
> 


This is correct in Userspace:
https://github.com/microsoft/openvmm/blob/main/openhcl/hcl/src/ioctl.rs#L905

This was wrong in kernel code internally from the beginning. This did 
not get caught because we took a large array size (2 * PAGE_SIZE) which 
never failed the check
(hvcall_setup.bitmap_array_size > ARRAY_SIZE(fd->allow_bitmap))
and hvcall_setup.bitmap_size always had number of bytes to copy.

We can make allow_bitmap as an array of u8 here, irrespective of how 
userspace is setting the bits in the bitmap because it is finally doing 
the same thing. I'll make the change.


>>                   return -EFAULT;
>>           }
>>
>> @@ -1221,11 +1224,7 @@ static int mshv_vtl_hvcall_do_setup(struct mshv_vtl_hvcall_fd *fd,
>>
>>    static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, u16 call_code)
>>    {
>> -       u8 bits_per_item = 8 * sizeof(fd->allow_bitmap[0]);
>> -       u16 item_index = call_code / bits_per_item;
>> -       u64 mask = 1ULL << (call_code % bits_per_item);
>> -
>> -       return fd->allow_bitmap[item_index] & mask;
>> +       return test_bit(call_code, (unsigned long *)fd->allow_bitmap);
>>    }
> 
> Yes, the rest of this looks good.
> 
> Michael

For CPU hotplug, I checked internally and we do not support hotplug in
VTL2 for OpenHCL. Hotplugging vCPUs in VTL0 is transparent to VTL2 and
these CPUs remain online in VTL2. VTL2 also won't be hotplugging CPUs
when VTL0 is running.

I am planning to put a comment mentioning this in the two places where 
we check for cpu_online() in the driver. Preventing hotplug from 
happening through hotplug notifiers is a bit overkill for me, as of now, 
but if you feel that should be done, I will work on it.

Since good enough changes are done in this version, I will send the next 
version soon, unless there are follow-up comments here which needs 
something to change. We can then have a fresh look at it and work 
together to enhance it.

Thanks for your time and guidance Michael.

Thanks,
Naman

