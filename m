Return-Path: <linux-hyperv+bounces-4383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F7A5B80E
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 05:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F10188C580
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 04:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF21DFE22;
	Tue, 11 Mar 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kQ4QtEBy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF23135970;
	Tue, 11 Mar 2025 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668334; cv=none; b=LzIKeeXNmDeUjizo87PBYtJcyy4tJ5EGOtJgJhbNVL05fJmQC+ugouzpVPEXic4LE0+SR4C/RxjgreKLkALMVg0Fk/P827bgScvljv9woQi1sibyZ9iBEH0LOqvWsaJoOW1jC8+jcr/HTf80VeVJw3iQuE+ksWp5GKdZ+6Vzn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668334; c=relaxed/simple;
	bh=HwpACx+8Qa3bAieTgPUX6QI3DY3+GFm48Z7lP9qOwAc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=noMnbDfzzdeiehUcJnbruOCqDopV7sLlS8ea7uhVCR+tTCwwiiv+LrdyDB8eK/lIVMOvBIlEQlukIgHkHu6grqYsG7DcOCdjWv9q0S0AFpTxIuVzOhUVysK2kvZI9RkTHxTdPffstNPn7EqldwItrF8k4QueZ+NQuUO+T9KVAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kQ4QtEBy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.217.160] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93DCC2111424;
	Mon, 10 Mar 2025 21:45:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93DCC2111424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741668332;
	bh=YtKPCwUMICgyUqIHUZmbv2IVBI4Rjx4Z+0m0eHcnazo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kQ4QtEBynRb5gm96EM4WvYBuxzRmtVbw5xLV8cGIGYbKbIjdi+Eh+o1AzbHSQzCHW
	 b/lA2yKcJ/sz2nYHLLFyq+i1GYOGlYr7Muf6LNlgIuR3LY4oTsu2VaR4feiMMZ9dS/
	 7wiS6q4WC8sZvpdR42YbRTZlk/OGvW8q2Nbe4RDE=
Message-ID: <a7716784-face-44ff-837d-50f7ca79f0e9@linux.microsoft.com>
Date: Tue, 11 Mar 2025 10:15:25 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer
From: Naman Jain <namjain@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>
References: <20250225052001.2225-1-namjain@linux.microsoft.com>
 <2025022504-diagnosis-outsell-684c@gregkh>
 <9ee65987-4353-42c6-b517-d6f52428f718@linux.microsoft.com>
 <2025022515-lasso-carrot-4e1d@gregkh>
 <541c63d6-8ae6-4a32-8a02-d86eea64827e@linux.microsoft.com>
 <2025022627-deflate-pliable-6da0@gregkh>
 <0a694947-809d-48b2-9138-d3f6175fe09d@linux.microsoft.com>
 <2025022643-predict-hedge-8c77@gregkh>
 <960501c2-5ab2-4c81-86ac-a4477c0f708a@linux.microsoft.com>
 <5709eac1-a828-4ab3-afc2-8f1790d5f61f@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <5709eac1-a828-4ab3-afc2-8f1790d5f61f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/2025 12:36 PM, Naman Jain wrote:
> 
> 
> On 2/27/2025 11:54 AM, Naman Jain wrote:
>>
>>
>> On 2/26/2025 8:03 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Feb 26, 2025 at 05:51:46PM +0530, Naman Jain wrote:
>>>>
>>>>
>>>> On 2/26/2025 3:33 PM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Feb 26, 2025 at 10:43:41AM +0530, Naman Jain wrote:
>>>>>>
>>>>>>
>>>>>> On 2/25/2025 2:09 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Tue, Feb 25, 2025 at 02:04:43PM +0530, Naman Jain wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/25/2025 11:42 AM, Greg Kroah-Hartman wrote:
>>>>>>>>> On Tue, Feb 25, 2025 at 10:50:01AM +0530, Naman Jain wrote:
>>>>>>>>>> On regular bootup, devices get registered to vmbus first, so when
>>>>>>>>>> uio_hv_generic driver for a particular device type is probed,
>>>>>>>>>> the device is already initialized and added, so sysfs creation in
>>>>>>>>>> uio_hv_generic probe works fine. However, when device is removed
>>>>>>>>>> and brought back, the channel rescinds and device again gets
>>>>>>>>>> registered to vmbus. However this time, the uio_hv_generic 
>>>>>>>>>> driver is
>>>>>>>>>> already registered to probe for that device and in this case 
>>>>>>>>>> sysfs
>>>>>>>>>> creation is tried before the device gets initialized completely.
>>>>>>>>>>
>>>>>>>>>> Fix this by moving the core logic of sysfs creation for ring 
>>>>>>>>>> buffer,
>>>>>>>>>> from uio_hv_generic to HyperV's vmbus driver, where rest of 
>>>>>>>>>> the sysfs
>>>>>>>>>> attributes for the channels are defined. While doing that, 
>>>>>>>>>> make use
>>>>>>>>>> of attribute groups and macros, instead of creating sysfs 
>>>>>>>>>> directly,
>>>>>>>>>> to ensure better error handling and code flow.
>>>>
>>>> <snip>
>>>>
>>>>>>>>>> +static int hv_mmap_ring_buffer_wrapper(struct file *filp, 
>>>>>>>>>> struct kobject *kobj,
>>>>>>>>>> +                       const struct bin_attribute *attr,
>>>>>>>>>> +                       struct vm_area_struct *vma)
>>>>>>>>>> +{
>>>>>>>>>> +    struct vmbus_channel *channel = container_of(kobj, struct 
>>>>>>>>>> vmbus_channel, kobj);
>>>>>>>>>> +
>>>>>>>>>> +    if (!channel->mmap_ring_buffer)
>>>>>>>>>> +        return -ENODEV;
>>>>>>>>>> +    return channel->mmap_ring_buffer(channel, vma);
>>>>>>>>>
>>>>>>>>> What is preventing mmap_ring_buffer from being set to NULL 
>>>>>>>>> right after
>>>>>>>>> checking it and then calling it here?  I see no locks here or 
>>>>>>>>> where you
>>>>>>>>> are assigning this variable at all, so what is preventing these 
>>>>>>>>> types of
>>>>>>>>> races?
>>>>>>>>>
>>>>>>>>> thanks,
>>>>>>>>>
>>>>>>>>> greg k-h
>>>>>>>>
>>>>>>>> Thank you so much for reviewing.
>>>>>>>> I spent some time to understand if this race condition can 
>>>>>>>> happen and it
>>>>>>>> seems execution flow is pretty sequential, for a particular 
>>>>>>>> channel of a
>>>>>>>> device.
>>>>>>>>
>>>>>>>> Unless hv_uio_remove (which makes channel->mmap_ring_buffer 
>>>>>>>> NULL) can be
>>>>>>>> called in parallel to hv_uio_probe (which had set
>>>>>>>> channel->mmap_ring_buffer to non NULL), I doubt race can happen 
>>>>>>>> here.
>>>>>>>>
>>>>>>>> Code Flow: (R, W-> Read, Write to channel->mmap_ring_buffer)
>>>>>>>>
>>>>>>>> vmbus_device_register
>>>>>>>>      device_register
>>>>>>>>        hv_uio_probe
>>>>>>>>       hv_create_ring_sysfs (W to non NULL)
>>>>>>>>            sysfs_update_group
>>>>>>>>              vmbus_chan_attr_is_visible (R)
>>>>>>>>      vmbus_add_channel_kobj
>>>>>>>>        sysfs_create_group
>>>>>>>>          vmbus_chan_attr_is_visible  (R)
>>>>>>>>          hv_mmap_ring_buffer_wrapper (critical section)
>>>>>>>>
>>>>>>>> hv_uio_remove
>>>>>>>>      hv_remove_ring_sysfs (W to NULL)
>>>>>>>
>>>>>>> Yes, and right in here someone mmaps the file.
>>>>>>>
>>>>>>> I think you can race here, no locks at all feels wrong.
>>>>>>>
>>>>>>> Messing with sysfs groups and files like this is rough, and 
>>>>>>> almost never
>>>>>>> a good idea, why can't you just do this all at once with the default
>>>>>>> groups, why is this being added/removed out-of-band?
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>>
>>>>>> The decision to avoid creating a "ring" sysfs attribute by default
>>>>>> likely stems from a specific use case where it wasn't needed for 
>>>>>> every
>>>>>> device. By creating it automatically, it keeps the uio_hv_generic
>>>>>> driver simpler and helps prevent potential race conditions. 
>>>>>> However, it
>>>>>> has an added cost of having ring buffer for all the channels, 
>>>>>> where it
>>>>>> is not required. I am trying to find if there are any more 
>>>>>> implications
>>>>>> of it.
>>>>>
>>>>> You do know about the "is_visable" attribute callback, right?  Why not
>>>>> just use that instead of manually mucking around with the
>>>>> adding/removing of sysfs attributes at all?  That is what it was
>>>>> designed for.
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>
>>>> Hi Greg,
>>>> Yes, I am utilizing that in my patch. For differentiating channels of a
>>>> uio_hv_generic device, and for *selectively* creating sysfs, we
>>>> introduced this field in channel struct "channel->mmap_ring_buffer",
>>>> which we were setting only in uio_hv_generic. But, by the time we set
>>>> this in uio_hv_generic driver, the sysfs creation has already gone
>>>> through and sysfs doesn't get updated dynamically. That's where there
>>>> was a need to call sysfs_update_group. I thought the better place to
>>>> keep sysfs_update_group would be in vmbus driver, where we are creating
>>>> the original sysfs entries, hence I had to add the wrapper functions.
>>>> This led us to the race condition we are trying to address now.
>>>>
>>>>
>>>> @@ -1838,6 +1872,10 @@ static umode_t vmbus_chan_attr_is_visible(struct
>>>> kobject *kobj,
>>>>            attr == &chan_attr_monitor_id.attr))
>>>>           return 0;
>>>>
>>>> +    /* Hide ring attribute if channel's mmap_ring_buffer function 
>>>> is not yet
>>>> initialised */
>>>> +    if (attr ==  &chan_attr_ring_buffer.attr && !channel- 
>>>> >mmap_ring_buffer)
>>>> +        return 0;
>>>> +
>>>>       return attr->mode;
>>>
>>> Ok, that's good.  BUT you need to change the detection of this to be
>>> before the device is set up in the driver.  Why can't you do it in the
>>> device creation logic itself instead of after-the-fact when you will
>>> ALWAYS race with userspace?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Sure, will check more on this. Thanks.
>>
>> Regards,
>> Naman
>>
> 
> Hi Greg,
> I understand this is deviating from the discussions that we have had
> till now, but I wanted to kindly request your opinion on the following
> approach, which came up in one of our internal discussions.
> 
> By moving the sysfs creation logic from hv_uio_probe to hv_uio_open, I
> believe we can address this problem. Here are some of the benefits of
> this approach:
> 
> * This approach involves minimal changes and provides a localized
> solution.
> 
> * Since the use-case of ring sysfs is specific to uio_hv_generic and
> DPDK, this will give us the flexibility to modify it based on
> requirements. For example, ring_buffer_bin_attr.size should depend on
> the ring buffer's allocated size, which is easier to manage if the
> current code resides in uio_hv_generic.
> 
> * The use-case of DPDK is such that at any given time, either the
> hv_netvsc kernel driver or the userspace (DPDK) will be controlling this
> HV_NIC device. We do not want to expose the ring buffer to userspace
> when hv_netvsc is using the device. This is where the "awareness" of the
> current user comes into play, and we need a way to control the
> visibility of the "ring" sysfs from uio_hv_generic.
> 
> 
> Alternatively, I could focus on resolving the race condition you
> mentioned and proceed with refining the patch. This approach addresses
> most of the general practice concerns you highlighted.
> 
> Regards,
> Naman

Hello Greg,
Here are the two approaches that we discussed.
Can you please suggest the approach which looks better to you
for next version.

**Approach 1: move sysfs creation to hv_uio_open**
---
  drivers/uio/uio_hv_generic.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 1b19b5647495..fec78c90279e 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -218,6 +218,11 @@ hv_uio_open(struct uio_info *info, struct inode *inode)
  	vmbus_set_chn_rescind_callback(dev->channel, hv_uio_rescind);
  	vmbus_set_sc_create_callback(dev->channel, hv_uio_new_channel);

+	ret = sysfs_create_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
+	if (ret)
+		dev_notice(&dev->device,
+			   "sysfs create ring bin file failed; %d\n", ret);
+
  	ret = vmbus_connect_ring(dev->channel,
  				 hv_uio_channel_cb, dev->channel);
  	if (ret == 0)
@@ -350,11 +355,6 @@ hv_uio_probe(struct hv_device *dev,
  		goto fail_close;
  	}

-	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
-	if (ret)
-		dev_notice(&dev->device,
-			   "sysfs create ring bin file failed; %d\n", ret);
-
  	hv_set_drvdata(dev, pdata);

  	return 0;
-- 

=====================================================================
**Approach 2: Move sysfs creation to hyperv drivers**

---
  drivers/hv/hyperv_vmbus.h    |  6 +++
  drivers/hv/vmbus_drv.c       | 73 +++++++++++++++++++++++++++++++++++-
  drivers/uio/uio_hv_generic.c | 33 ++++++----------
  include/linux/hyperv.h       |  6 +++
  4 files changed, 95 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 29780f3a7478..0b450e53161e 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -477,4 +477,10 @@ static inline int hv_debug_add_dev_dir(struct 
hv_device *dev)

  #endif /* CONFIG_HYPERV_TESTING */

+/* Create and remove sysfs entry for memory mapped ring buffers for a 
channel */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma));
+int hv_remove_ring_sysfs(struct vmbus_channel *channel);
+
  #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 22afebfc28ff..44ecbca83c9e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1802,6 +1802,27 @@ static ssize_t subchannel_id_show(struct 
vmbus_channel *channel,
  }
  static VMBUS_CHAN_ATTR_RO(subchannel_id);

+static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct 
kobject *kobj,
+				       const struct bin_attribute *attr,
+				       struct vm_area_struct *vma)
+{
+	struct vmbus_channel *channel = container_of(kobj, struct 
vmbus_channel, kobj);
+
+	/*
+	 * hv_(create|remove)_ring_sysfs implementation ensures that 
mmap_ring_buffer
+	 * is not NULL.
+	 */
+	return channel->mmap_ring_buffer(channel, vma);
+}
+
+static struct bin_attribute chan_attr_ring_buffer = {
+	.attr = {
+		.name = "ring",
+		.mode = 0600,
+	},
+	.size = 2 * SZ_2M,
+	.mmap = hv_mmap_ring_buffer_wrapper,
+};
  static struct attribute *vmbus_chan_attrs[] = {
  	&chan_attr_out_mask.attr,
  	&chan_attr_in_mask.attr,
@@ -1821,6 +1842,11 @@ static struct attribute *vmbus_chan_attrs[] = {
  	NULL
  };

+static struct bin_attribute *vmbus_chan_bin_attrs[] = {
+	&chan_attr_ring_buffer,
+	NULL
+};
+
  /*
   * Channel-level attribute_group callback function. Returns the 
permission for
   * each attribute, and returns 0 if an attribute is not visible.
@@ -1841,9 +1867,24 @@ static umode_t vmbus_chan_attr_is_visible(struct 
kobject *kobj,
  	return attr->mode;
  }

+static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *attr, int idx)
+{
+	const struct vmbus_channel *channel =
+		container_of(kobj, struct vmbus_channel, kobj);
+
+	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
+	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
+		return 0;
+
+	return attr->attr.mode;
+}
+
  static const struct attribute_group vmbus_chan_group = {
  	.attrs = vmbus_chan_attrs,
-	.is_visible = vmbus_chan_attr_is_visible
+	.bin_attrs = vmbus_chan_bin_attrs,
+	.is_visible = vmbus_chan_attr_is_visible,
+	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
  };

  static const struct kobj_type vmbus_chan_ktype = {
@@ -1851,6 +1892,36 @@ static const struct kobj_type vmbus_chan_ktype = {
  	.release = vmbus_chan_release,
  };

+/*
+ * hv_create_ring_sysfs - create ring sysfs entry corresponding to ring 
buffers for a channel
+ */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma))
+{
+	struct kobject *kobj = &channel->kobj;
+
+	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
+	channel->ring_sysfs_visible = true;
+	return sysfs_update_group(kobj, &vmbus_chan_group);
+}
+EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
+
+/*
+ * hv_remove_ring_sysfs - remove ring sysfs entry corresponding to ring 
buffers for a channel
+ */
+int hv_remove_ring_sysfs(struct vmbus_channel *channel)
+{
+	struct kobject *kobj = &channel->kobj;
+	int ret;
+
+	channel->ring_sysfs_visible = false;
+	ret = sysfs_update_group(kobj, &vmbus_chan_group);
+	channel->mmap_ring_buffer = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_remove_ring_sysfs);
+
  /*
   * vmbus_add_channel_kobj - setup a sub-directory under device/channels
   */
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 1b19b5647495..a398e93ed382 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -131,15 +131,12 @@ static void hv_uio_rescind(struct vmbus_channel 
*channel)
  	vmbus_device_unregister(channel->device_obj);
  }

-/* Sysfs API to allow mmap of the ring buffers
+/* Function used for mmap of ring buffer sysfs interface.
   * The ring buffer is allocated as contiguous memory by vmbus_open
   */
-static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
-			    const struct bin_attribute *attr,
-			    struct vm_area_struct *vma)
+static int
+hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
  {
-	struct vmbus_channel *channel
-		= container_of(kobj, struct vmbus_channel, kobj);
  	void *ring_buffer = page_address(channel->ringbuffer_page);

  	if (channel->state != CHANNEL_OPENED_STATE)
@@ -149,15 +146,6 @@ static int hv_uio_ring_mmap(struct file *filp, 
struct kobject *kobj,
  			       channel->ringbuffer_pagecount << PAGE_SHIFT);
  }

-static const struct bin_attribute ring_buffer_bin_attr = {
-	.attr = {
-		.name = "ring",
-		.mode = 0600,
-	},
-	.size = 2 * SZ_2M,
-	.mmap = hv_uio_ring_mmap,
-};
-
  /* Callback from VMBUS subsystem when new channel created. */
  static void
  hv_uio_new_channel(struct vmbus_channel *new_sc)
@@ -178,8 +166,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
  	/* Disable interrupts on sub channel */
  	new_sc->inbound.ring_buffer->interrupt_mask = 1;
  	set_channel_read_mode(new_sc, HV_CALL_ISR);
-
-	ret = sysfs_create_bin_file(&new_sc->kobj, &ring_buffer_bin_attr);
+	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
  	if (ret) {
  		dev_err(device, "sysfs create ring bin file failed; %d\n", ret);
  		vmbus_close(new_sc);
@@ -350,10 +337,12 @@ hv_uio_probe(struct hv_device *dev,
  		goto fail_close;
  	}

-	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
-	if (ret)
-		dev_notice(&dev->device,
-			   "sysfs create ring bin file failed; %d\n", ret);
+	/*
+	 * This internally calls sysfs_update_group, which returns a non-zero 
value if it executes
+	 * before sysfs_create_group. This is a false alarm from this use case 
point of view and
+	 * thus, no need to check the return value and print warning.
+	 */
+	hv_create_ring_sysfs(channel, hv_uio_ring_mmap);

  	hv_set_drvdata(dev, pdata);

@@ -375,7 +364,7 @@ hv_uio_remove(struct hv_device *dev)
  	if (!pdata)
  		return;

-	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
+	hv_remove_ring_sysfs(dev->channel);
  	uio_unregister_device(&pdata->info);
  	hv_uio_cleanup(dev, pdata);

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 7f4f8d8bdf43..f93e489eca62 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1058,6 +1058,12 @@ struct vmbus_channel {

  	/* The max size of a packet on this channel */
  	u32 max_pkt_size;
+
+	/* function to mmap ring buffer memory to the channel's sysfs ring 
attribute */
+	int (*mmap_ring_buffer)(struct vmbus_channel *channel, struct 
vm_area_struct *vma);
+
+	/* boolean to control visibility of sysfs for ring buffer */
+	bool ring_sysfs_visible;
  };

  #define lock_requestor(channel, flags)					\
-- 


Regards,
Naman


