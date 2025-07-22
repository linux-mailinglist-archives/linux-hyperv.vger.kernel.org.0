Return-Path: <linux-hyperv+bounces-6322-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 676FFB0D7DD
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 13:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB47189EAA6
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC8288524;
	Tue, 22 Jul 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bz5GvyOs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3C38FA6;
	Tue, 22 Jul 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182580; cv=none; b=jj8eu5SHmp7uS6WAOADPsYU0Ug0ArN+2Xk4acUy8FMf4zcNKKDFrEp19fqwK7gmnNlhsRvUZ4PtuLHSEVjj6S3aCEhfGfn8wf9R4NOgkITZ06tLEtNmrg8WF9KFs8uMI8cOQX4a7/jALMM0cCG3QSgJXrTe/KxM+Pxx6jAmVFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182580; c=relaxed/simple;
	bh=CYEuHscZcABKMhg9fyn4rl48So0qm7kln60VrpBEK7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b66t8/+NrX4sJPY7AEm/VYRIO0/LijUMsKiZhtfzqb0J1RNXK3gxXG6/YzgsiIz9B+T/3UoyIDRu/6AQTx5yPSmnRjEFozfw2xSAOKpQLFkkkt/ir6BfUXEBbyDTDe5tbPtYASeP86IfpeLfq8TjaE6oh6AQ4LqOKmb9LERmfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bz5GvyOs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9589A212688F;
	Tue, 22 Jul 2025 04:09:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9589A212688F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753182572;
	bh=lh25vDj5YrwsIUZawZQXQwVqfw4K8J7lH5Gkoly0HGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bz5GvyOsM1hfeOZhVyoL+nKrWJv9t8duTIcqxCDFMt0C4/yDnY2rQR7o5OlCRz1Eh
	 eHguE1836ZWOVddnRfnQsAISHoD5IMQND+nQm6l6Dv4R8BqRtZr7gd4iss4D/Oau4L
	 ItJGH3iSlfrmVBuol8btK2ngf3KC5bFFY+Nn32Eg=
Message-ID: <5bf4e550-34e1-4b6b-8ee2-137681a72d42@linux.microsoft.com>
Date: Tue, 22 Jul 2025 16:39:25 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415781ABC3D523B719BDE280D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/2025 8:37 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 17, 2025 9:36 PM
>>
>> On 7/9/2025 10:49 PM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, June 11, 2025 12:27 AM
> 
> [snip]
> 
>>
>>> Separately, "allow_bitmap" size is 64K bytes, or 512K bits. Is that the
>>> correct size?  From looking at mshv_vtl_hvcall_is_allowed(), I think this
>>> bitmap is indexed by the HV call code, which is a 16 bit value. So you
>>> only need 64K bits, and the size is too big by a factor of 8. In any case,
>>> it seems like the size should not be expressed in terms of PAGE_SIZE.
>>
>> There are HVcall codes which are of type u16. So max(HVcall code) =
>> 0xffff.
>>
>> For every HVcall that needs to be allowed, we are saving HVcall code
>> info in a bitmap in below fashion:
>> if x = HVCall code and bitmap is an array of u64, of size
>> ((0xffff/64=1023) + 1)
>>
>> bitmap[x / 64] = (u64)1 << (x%64);
>>
>> Later on in mshv_vtl_hvcall_is_allowed(), we calculate the array index
>> by dividing it by 64, and then see if call_code/64 bit is set.
> 
> I didn't add comments in mshv_vtl_hvcall_is_allowed(), but that code
> can be simplified by recognizing that the Linux kernel bitmap utilities
> can operate on bitmaps that are much larger than just 64 bits. Let's
> assume that the allow_bitmap field in struct mshv_vtl_hvcall_fds has
> 64K bits, regardless of whether it is declared as an array of u64,
> an array of u16, or an array of u8. Then mshv_vtl_hvcall_is_allowed()
> can be implemented as a single line:
> 
> 	return test_bit(call_code, fd->allow_bitmap);
> 
> There's no need to figure out which array element contains the bit,
> or to construct a mask to select that particular bit in the array element.
> And since call_code is a u16, test_bit won't access outside the allocated
> 64K bits.
> 

I understood it now. This works and is much better. Will incorporate it
in next patch.

>>
>> Coming to size of allow_bitmap[], it is independent of PAGE_SIZE, and
>> can be safely initialized to 1024 (reducing by a factor of 8).
>> bitmap_size's maximum value is going to be 1024 in current
>> implementation, picking u64 was not mandatory, u16 will also work. Also,
>> item_index is also u16, so I should make bitmap_size as u16.
> 
> The key question for me is whether bitmap_size describes the number
> of bits in allow_bitmap, or whether it describes the number of array
> elements in the declared allow_bitmap array. It's more typical to
> describe a bitmap size as the number of bits. Then the value is
> independent of the array element size, as the array element size
> usually doesn't really matter anyway if using the Linux kernel's
> bitmap utilities. The array element size only matters in allocating
> the correct amount of space is for whatever number of bits are
> needed in the bitmap.
> 

I tried to put your suggestions in code. Please let me know if below 
works. I tested this and it works. Just that, I am a little hesitant in 
changing things on Userspace side of it, which passes these parameters 
in IOCTL. This way, userspace remains the same, the confusion of names 
may go away, and the code becomes simpler.

--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -332,7 +332,7 @@ struct mshv_vtl_set_poll_file {
  };

  struct mshv_vtl_hvcall_setup {
-       __u64 bitmap_size;
+       __u64 bitmap_array_size;
         __u64 allow_bitmap_ptr; /* pointer to __u64 */
  };


--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -52,10 +52,12 @@ static bool has_message;
  static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
  static DEFINE_MUTEX(flag_lock);
  static bool __read_mostly mshv_has_reg_page;
-#define MAX_BITMAP_SIZE 1024
+
+/* hvcall code is of type u16, allocate a bitmap of size (1 << 16) to 
accomodate it */
+#define MAX_BITMAP_SIZE (1 << 16)

  struct mshv_vtl_hvcall_fd {
-       u64 allow_bitmap[MAX_BITMAP_SIZE];
+       u64 allow_bitmap[MAX_BITMAP_SIZE / 64];
         bool allow_map_initialized;
         /*
          * Used to protect hvcall setup in IOCTLs

@@ -1204,12 +1207,12 @@ static int mshv_vtl_hvcall_do_setup(struct 
mshv_vtl_hvcall_fd *fd,
                            sizeof(struct mshv_vtl_hvcall_setup))) {
                 return -EFAULT;
         }
-       if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
+       if (hvcall_setup.bitmap_array_size > ARRAY_SIZE(fd->allow_bitmap)) {
                 return -EINVAL;
         }
         if (copy_from_user(&fd->allow_bitmap,
                            (void __user *)hvcall_setup.allow_bitmap_ptr,
-                          hvcall_setup.bitmap_size)) {
+                          hvcall_setup.bitmap_array_size)) {
                 return -EFAULT;
         }

@@ -1221,11 +1224,7 @@ static int mshv_vtl_hvcall_do_setup(struct 
mshv_vtl_hvcall_fd *fd,

  static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, 
u16 call_code)
  {
-       u8 bits_per_item = 8 * sizeof(fd->allow_bitmap[0]);
-       u16 item_index = call_code / bits_per_item;
-       u64 mask = 1ULL << (call_code % bits_per_item);
-
-       return fd->allow_bitmap[item_index] & mask;
+       return test_bit(call_code, (unsigned long *)fd->allow_bitmap);
  }

> [snip]
> 
>>>> +
>>>> +	event_flags = (union hv_synic_event_flags *)per_cpu->synic_event_page +
>>>> +			VTL2_VMBUS_SINT_INDEX;
>>>> +	for (i = 0; i < HV_EVENT_FLAGS_LONG_COUNT; i++) {
>>>> +		if (READ_ONCE(event_flags->flags[i])) {
>>>> +			word = xchg(&event_flags->flags[i], 0);
>>>> +			for_each_set_bit(j, &word, BITS_PER_LONG) {
>>>
>>> Is there a reason for the complexity in finding and resetting bits that are
>>> set in the sync_event_page?  See the code in vmbus_chan_sched() that I
>>> think is doing the same thing, but with simpler code.
>>
>> I am sorry, but I am not sure how this can be written similar to
>> vmbus_chan_sched(). We don't have eventfd signaling mechanism there.
>> Can you please share some more info/code snippet of what you were
>> suggesting?
> 
> See below.
> 
>>
>>
>>>
>>>> +				rcu_read_lock();
>>>> +				eventfd = READ_ONCE(flag_eventfds[i * BITS_PER_LONG + j]);
>>>> +				if (eventfd)
>>>> +					eventfd_signal(eventfd);
>>>> +				rcu_read_unlock();
>>>> +			}
>>>> +		}
>>>> +	}
> 
> Here's what I would suggest. As with the hvcall allow_bitmap, this uses
> the Linux kernel bitmap utilities' ability to operate on large bitmaps, instead
> of going through each ulong in the array, and then going through each bit
> in the ulong.
> 
> event_flags = (union hv_synic_event_flags *)per_cpu->synic_event_page + VTL2_VMBUS_SINT_INDEX;
> 
> for_each_set_bit(i, event_flags->flags, HV_EVENT_FLAGS_COUNT) {
> 	if (!sync_test_and_clear_bit(i, event_flags->flags))
> 		continue;
> 	rcu_read_lock();
> 	eventfd = READ_ONCE(flag_eventfds[i]);
> 	if (eventfd)
> 		eventfd_signal(eventfd);
> 	rcu_read_unlock();
> }
> 
> I haven't even compile tested the above, but hopefully you get the
> idea and can fix any stupid mistakes. Note that HV_EVENT_FLAGS_COUNT
> is a bit count, not a count of ulong's. And with the above code, you don't
> need to add a definition of HV_EVENT_FLAGS_LONG_COUNT.

Thanks for sharing this, it works. Will change it in next patch.

> 
> [snip]
> 
>>>> +	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>>>> +	if (!pgmap)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	pgmap->ranges[0].start = PFN_PHYS(vtl0_mem.start_pfn);
>>>> +	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn) - 1;
>>>
>>> Perhaps this should be
>>>
>>> 	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn + 1) - 1
>>>
>>> otherwise the last page won't be included in the range. Or is excluding the
>>> last page intentional?
>>
>> Excluding the last page is intentional. Hence there is a check for this
>> as well:
>> if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
>>
> 
> OK, this test requires that at least 2 PFNs be provided, because the
> last one will be excluded.
> 
> I'd suggest adding a comment that the last page is intentionally
> excluded, and why it is excluded. Somebody in future looking at this
> code will appreciate the explanation. :-)
> 

Acked.


> [snip]
> 
>>>
>>>> +
>>>> +	if (!cpu_online(input.cpu))
>>>> +		return -EINVAL;
>>>
>>> Having tested that the target CPU is online, does anything ensure that the
>>> CPU stays online during the completion of this function? Usually the
>>> cpus_read_lock() needs to be held to ensure that an online CPU stays
>>> online for the duration of an operation.
>>
>> Added cpus_read_lock() block around per_cpu_ptr operation. In general,
>> CPUs are never hotplugged in kernel from our Usecase POV. I have omitted
>> adding these locks at other places for now. Please let me know your
>> thoughts on this, in case you feel we need to have it.
>>
> 
> My understanding of VTL2 behavior is limited, so let me ask some clarifying
> questions. If a vCPU is running in VTL0, then presumably that vCPU is also
> running in VTL2. If that vCPU is then taken offline in VTL0, does it stay
> online in VTL2? And then if the vCPU is brought back online in VTL0,
> nothing changes in VTL2, correct?
> 
> If that is the correct understanding, and vCPUs never go offline in VTL2,
> it would be more robust to enforce that. For example, in hv_vtl_setup_synic()
> where cpuhp_setup_state() is called, the teardown argument is currently
> NULL. You could provide a teardown function that just returns an error.
> Then any attempts to take a vCPU offline in VTL2 would fail, and the vCPU
> would stay online. However, some additional logic might be needed to
> ensure that normal shutdown and the panic case work correctly -- I'm not
> sure what VTL2 needs to do for these scenarios.
> 
> All that said, if you can be sure that vCPUs don't go offline in VTL2,
> I would be OK with not adding the cpus_read_lock(). Perhaps a comment
> would be helpful in the places where you are not using cpus_read_lock()
> for this reason, assuming there is a reasonable number of such places.

Not to make any assumptions, I am trying to gather more information on
this, I will respond to it soon.

> 
> [snip]
> 
>>>> +
>>>> +struct mshv_vtl_hvcall_setup {
>>>> +	__u64 bitmap_size;
>>>
>>> What are the units of "bitmap_size"?  Bits? Bytes? u64?
>>
>> It would be length of bitmap array.
> 
> To me "length of bitmap array" is still ambiguous. Is it the
> number of elements in the declared array field? Per my
> earlier comments, I think the number of bits in the bitmap
> would be more typical.

does bitmap_array_size work?

> 
>>
>>>
>>>> +	__u64 allow_bitmap_ptr; /* pointer to __u64 */
>>>> +};
> 
> Michael


Regards,
Naman


