Return-Path: <linux-hyperv+bounces-4919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2EA8A3BC
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 18:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3558744399E
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E6203710;
	Tue, 15 Apr 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="axPtlhy/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05BE571;
	Tue, 15 Apr 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733519; cv=none; b=iNfOaEhyj0Mz/VDcyDwXdmQ9R53LtRo4sC43i0RpLaQ09kW09iTYoKSCdzuWSGHi2ZsBDdRVEzyC2EkDHyBXiwlLTlGo818Lw+5rORySTu2qis4HGJMXWA+5lKPc0bJvsQYLs7IBvU9SLGdtVZD7v/ZNtDJvzzXhvu7PIQ9EzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733519; c=relaxed/simple;
	bh=8A1G9OPw4Pet+Vp2FCp9VI/Zj4szJwWJjH7k9d9V6sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntuNTbWFs3RR/oe/e+2inCKAz6Z2dYPlxXd2Wd06q3aIthLq2mncoRC+quUGCrwViioFyuRVT7Hfwc2rXV+n9kGgLmNdD6wL7EwtHLLCdisP8Gop4K3NVmSu78UBn4xNsWx6naSRJvcdXFe7r1U6BTA/IPsQ2eYsCWkwltHL6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=axPtlhy/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.96.170] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 44D89210C446;
	Tue, 15 Apr 2025 09:11:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44D89210C446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744733517;
	bh=Mgi4vDnP6Y4O2FUhjNmAIlMySt38MscHkht0lI4fvKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=axPtlhy/XtRSrsbz7zOPVR+5scASZYezU92U61jKm6HE74YG2WBMlgdp84U7R0U1w
	 BbiNJbVk0GdGNkWbMuddIs/inATo+qGMv4/HEiKngNLimHZYMf3cI/P/Wfnvt0CucC
	 hiQGVLiJGK9d23qFDa9SbaPiO9Rwn1yD/gvbcGo8=
Message-ID: <46572a83-2ed0-47a4-8f28-211f56a48a16@linux.microsoft.com>
Date: Tue, 15 Apr 2025 21:41:50 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@kernel.org" <stable@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250410060847.82407-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157D5A900435AD1663BC720D4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D5A900435AD1663BC720D4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/2025 9:38 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, April 9, 2025 11:09 PM
>>
>> Hi,
>> This patch series aims to address the sysfs creation issue for the ring
>> buffer by reorganizing the code. Additionally, it updates the ring sysfs
>> size to accurately reflect the actual ring buffer size, rather than a
>> fixed static value.
>>
>> PFB change logs:
>>
>> Changes since v3:
>> https://lore.kernel.org/all/20250328052745.1417-1-namjain@linux.microsoft.com/
>> * Addressed Michael's comments regarding handling of return value of
>> sysfs_update_group in uio_hv_generic.
>>
>> Changes since v2:
>> https://lore.kernel.org/all/20250318061558.3294-1-namjain@linux.microsoft.com/
>> Addressed Greg's comments:
>> * Split the original patch into two.
>> * Updated the commit message to explain the problem scenario.
>> * Added comments for new APIs in the kerneldoc format.
>> * Highlighted potential race conditions and explained why sysfs should not be created in
>> the
>>    driver probe.
>>
>> * Made minor changes to how the sysfs_update_group return value is handled.
>>
>> Changes since v1:
>> https://lore.kernel.org/all/20250225052001.2225-1-namjain@linux.microsoft.com/
>> * Fixed race condition in setting channel->mmap_ring_buffer by
>>    introducing a new variable for visibility of sysfs (addressed Greg's
>>    comments)
>> * Used binary attribute fields instead of regular ones for initializing attribute_group.
>> * Make size of ring sysfs dynamic based on actual ring buffer's size.
>> * Preferred to keep mmap function in uio_hv_generic to give more control over ring's
>>    mmap functionality, since this is specific to uio_hv_generic driver.
>> * Remove spurious warning during sysfs creation in uio_hv_generic probe.
>> * Added comments in a couple of places.
>>
>> Changes since RFC patch:
>> https://lore.kernel.org/all/20250214064351.8994-1-namjain@linux.microsoft.com/
>> * Different approach to solve the problem is proposed (credits to
>>    Michael Kelley).
>> * Core logic for sysfs creation moved out of uio_hv_generic, to VMBus
>>    drivers where rest of the sysfs attributes for a VMBus channel
>>    are defined. (addressed Greg's comments)
>> * Used attribute groups instead of sysfs_create* functions, and bundled
>>    ring attribute with other attributes for the channel sysfs.
>>
>> Error logs:
>>
>> [   35.574120] ------------[ cut here ]------------
>> [   35.574122] WARNING: CPU: 0 PID: 10 at fs/sysfs/file.c:591 sysfs_create_bin_file+0x81/0x90
>> [   35.574168] Workqueue: hv_pri_chan vmbus_add_channel_work
>> [   35.574172] RIP: 0010:sysfs_create_bin_file+0x81/0x90
>> [   35.574197] Call Trace:
>> [   35.574199]  <TASK>
>> [   35.574200]  ? show_regs+0x69/0x80
>> [   35.574217]  ? __warn+0x8d/0x130
>> [   35.574220]  ? sysfs_create_bin_file+0x81/0x90
>> [   35.574222]  ? report_bug+0x182/0x190
>> [   35.574225]  ? handle_bug+0x5b/0x90
>> [   35.574244]  ? exc_invalid_op+0x19/0x70
>> [   35.574247]  ? asm_exc_invalid_op+0x1b/0x20
>> [   35.574252]  ? sysfs_create_bin_file+0x81/0x90
>> [   35.574255]  hv_uio_probe+0x1e7/0x410 [uio_hv_generic]
>> [   35.574271]  vmbus_probe+0x3b/0x90
>> [   35.574275]  really_probe+0xf4/0x3b0
>> [   35.574279]  __driver_probe_device+0x8a/0x170
>> [   35.574282]  driver_probe_device+0x23/0xc0
>> [   35.574285]  __device_attach_driver+0xb5/0x140
>> [   35.574288]  ? __pfx___device_attach_driver+0x10/0x10
>> [   35.574291]  bus_for_each_drv+0x86/0xe0
>> [   35.574294]  __device_attach+0xc1/0x200
>> [   35.574297]  device_initial_probe+0x13/0x20
>> [   35.574315]  bus_probe_device+0x99/0xa0
>> [   35.574318]  device_add+0x647/0x870
>> [   35.574320]  ? hrtimer_init+0x28/0x70
>> [   35.574323]  device_register+0x1b/0x30
>> [   35.574326]  vmbus_device_register+0x83/0x130
>> [   35.574328]  vmbus_add_channel_work+0x135/0x1a0
>> [   35.574331]  process_one_work+0x177/0x340
>> [   35.574348]  worker_thread+0x2b2/0x3c0
>> [   35.574350]  kthread+0xe3/0x1f0
>> [   35.574353]  ? __pfx_worker_thread+0x10/0x10
>> [   35.574356]  ? __pfx_kthread+0x10/0x10
>>
>> Regards,
>> Naman
>>
>> Naman Jain (2):
>>    uio_hv_generic: Fix sysfs creation path for ring buffer
>>    Drivers: hv: Make the sysfs node size for the ring buffer dynamic
>>
>>   drivers/hv/hyperv_vmbus.h    |   6 ++
>>   drivers/hv/vmbus_drv.c       | 119 ++++++++++++++++++++++++++++++++++-
>>   drivers/uio/uio_hv_generic.c |  39 +++++-------
>>   include/linux/hyperv.h       |   6 ++
>>   4 files changed, 147 insertions(+), 23 deletions(-)
>>
> 
> I've tested this series with linux-next20250411. Did the basics of binding the
> uio_hv_generic driver to the FCOPY device. The "ring" sysfs attribute shows up
> correctly, and with the expected size of 32 KiB. Did the same with a synthetic
> networking device, and the "ring" attribute has the expected size of 4 MiB. In both
> cases opened and mmap'ed the "ring" attribute, then read from the ring to
> verify accessibility.  Did not do any ring operations or create any subchannels.
> 
> Did some test hackery to create the conditions where hv_create_ring_sysfs()
> could fail because the subdirectory under "channels" had not yet been created.
> hv_uio_probe() correctly ignores the error. When the subdirectory under
> "channels" is created later in vmbus_device_register(), the "ring" attribute
> appears with the correct size.
> 
> Just saw Greg KH's comment about running checkpatch.pl.  I did not see any
> errors from checkpatch.pl.  Maybe that comment should have been directed
> to a different patch?
> 
> For the series:
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>

Thank you so much Michael for reviewing and testing this thoroughly.
Really appreciate it.

Regards,
Naman


