Return-Path: <linux-hyperv+bounces-5989-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD1AE3464
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 06:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BFC188C93C
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 04:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C641A00F0;
	Mon, 23 Jun 2025 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RyFMQ1au"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F32581;
	Mon, 23 Jun 2025 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654303; cv=none; b=L5it2SXWjsxwuXwO5zsq/qx0P7zh79DqFv5YT4wRX/vi/xh17icgI8+gtQ+ZHkWOnr1kQwcZDQ+cyZMXl6b3t8gfMs8bzQ7tv8J9CA6qbpYjGUN6N/sidCa0sr1sAYCRcUpvqf++htOxkLa+M890fIMpyZsk2um4fwvaEWdbqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654303; c=relaxed/simple;
	bh=UBExyjH7aS5T3zWk6+Xz4bHJcVuQVr0GYaR5ydUXHJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahFWTsXMOh6tuUqWkIkznXaNHZUVo4b3RBMq8UzO6qo496J9fA/ASuODTtAdblCMu3CG94ZU8Ck5weS7JZqv+DTC2j4KOtRdvC0vrEmoyunzLlSj7MvZ22YgPFqCFvQX/uB7J6DM9KOp3MyOJ9ezs0yCsggMZIzh16mTMQ8osXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RyFMQ1au; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 364052115800;
	Sun, 22 Jun 2025 21:51:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 364052115800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750654295;
	bh=NWYMyCpVO5cJwW1IpTuR2mZID1lZOhFA7i+jl1U5KRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RyFMQ1auY5iSbCkbHizNN3MmHgYaeZAXiyS+/5YlhF7fqdyFvF1kuNLhe5xhfziC6
	 s0LxYtSDF2bRxVIQlprPurPRLRKHZbvqqWBbo1zwWI8gfRNdFdOKnxpsWB4DGAxedc
	 mlQagpENnxhMQmbkbyQRigzepxsZHd5pdZmxfbsQ=
Message-ID: <2e0f1538-bae5-4a58-92fd-1c534fc8c7df@linux.microsoft.com>
Date: Mon, 23 Jun 2025 10:21:30 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250620070618.3097-1-namjain@linux.microsoft.com>
 <SN6PR02MB41574C54FFDE0D3F3B7A5649D47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41574C54FFDE0D3F3B7A5649D47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/20/2025 9:35 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, June 20, 2025 12:06 AM
>>
>> Size of ring buffer, as defined in uio_hv_generic driver, is no longer
>> fixed to 16 KB. This creates a problem in fcopy, since this size was
>> hardcoded. With the change in place to make ring sysfs node actually
>> reflect the size of underlying ring buffer, it is safe to get the size
>> of ring sysfs file and use it for ring buffer size in fcopy daemon.
>> Fix the issue of disparity in ring buffer size, by making it dynamic
>> in fcopy uio daemon.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   tools/hv/hv_fcopy_uio_daemon.c | 65 ++++++++++++++++++++++++++++++----
>>   1 file changed, 58 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
>> index 0198321d14a2..da2b27d6af0e 100644
>> --- a/tools/hv/hv_fcopy_uio_daemon.c
>> +++ b/tools/hv/hv_fcopy_uio_daemon.c
>> @@ -36,6 +36,7 @@
>>   #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
>>
>>   #define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
>> +#define FCOPY_CHANNELS_PATH	"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels"
>>
>>   #define FCOPY_VER_COUNT		1
>>   static const int fcopy_versions[] = {
>> @@ -47,9 +48,51 @@ static const int fw_versions[] = {
>>   	UTIL_FW_VERSION
>>   };
>>
>> -#define HV_RING_SIZE		0x4000 /* 16KB ring buffer size */
>> +#define HV_RING_SIZE_DEFAULT	0x4000 /* 16KB ring buffer size default */
>>
>> -static unsigned char desc[HV_RING_SIZE];
>> +static uint32_t get_ring_buffer_size(void)
>> +{
>> +	char ring_path[PATH_MAX];
>> +	DIR *dir;
>> +	struct dirent *entry;
>> +	struct stat st;
>> +	uint32_t ring_size = 0;
>> +
>> +	/* Find the channel directory */
>> +	dir = opendir(FCOPY_CHANNELS_PATH);
>> +	if (!dir) {
>> +		syslog(LOG_ERR, "Failed to open channels directory, using default ring size");
> 
> This is where the previous long discussion about racing with user space
> comes into play. While highly unlikely, it's possible that the "opendir" could fail
> because of racing with the kernel thread that creates the "channels" directory.
> The right thing to do would be to sleep for some period of time, then try
> again. Sleeping for 1 second would be a very generous -- could also go with
> something like 100 milliseconds.

Makes sense, will add that logic.

> 
>> +		return HV_RING_SIZE_DEFAULT;
>> +	}
>> +
>> +	while ((entry = readdir(dir)) != NULL) {
>> +		if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") != 0 &&
>> +		    strcmp(entry->d_name, "..") != 0) {
>> +			snprintf(ring_path, sizeof(ring_path), "%s/%s/ring",
>> +				 FCOPY_CHANNELS_PATH, entry->d_name);
>> +
>> +			if (stat(ring_path, &st) == 0) {
>> +				/* stat returns size of Tx, Rx rings combined, so take half of it */
>> +				ring_size = (uint32_t)st.st_size / 2;
>> +				syslog(LOG_INFO, "Ring buffer size from %s: %u bytes",
>> +				       ring_path, ring_size);
>> +				break;
>> +			}
>> +		}
>> +	}
> 
> The same race problem could happen with this loop. The "channels" directory
> might have been created, but the entry for the numbered channel might not.
> The loop could exit having found only "." and "..". Again, if no numbered
> channel is found, sleep for a short period of time and try again.

Will cover this too.

> 
>> +
>> +	closedir(dir);
>> +
>> +	if (!ring_size) {
>> +		ring_size = HV_RING_SIZE_DEFAULT;
>> +		syslog(LOG_ERR, "Could not determine ring size, using default: %u bytes",
>> +		       HV_RING_SIZE_DEFAULT);
>> +	}
>> +
>> +	return ring_size;
>> +}
>> +
>> +static unsigned char *desc;
>>
>>   static int target_fd;
>>   static char target_fname[PATH_MAX];
>> @@ -406,7 +449,8 @@ int main(int argc, char *argv[])
>>   	int daemonize = 1, long_index = 0, opt, ret = -EINVAL;
>>   	struct vmbus_br txbr, rxbr;
>>   	void *ring;
>> -	uint32_t len = HV_RING_SIZE;
>> +	uint32_t ring_size = get_ring_buffer_size();
> 
> Getting the ring buffer size before even the command line options
> are parsed could produce unexpected results. For example, if someone
> just wanted to see the usage (the -h option), they might get
> an error about not being able to get the ring size. I'd suggest doing
> this later, after the /dev/uio<N> entry is successfully opened.

Thanks for pointing this out, I'll take care of it in next version.

Regards,
Naman

> 
>> +	uint32_t len = ring_size;
>>   	char uio_name[NAME_MAX] = {0};
>>   	char uio_dev_path[PATH_MAX] = {0};
>>
>> @@ -416,6 +460,13 @@ int main(int argc, char *argv[])
>>   		{0,		0,		   0,  0   }
>>   	};
>>
>> +	desc = (unsigned char *)malloc(ring_size * sizeof(unsigned char));
>> +	if (!desc) {
>> +		syslog(LOG_ERR, "malloc failed for desc buffer");
>> +		ret = -ENOMEM;
>> +		goto exit;
>> +	}
>> +
>>   	while ((opt = getopt_long(argc, argv, "hn", long_options,
>>   				  &long_index)) != -1) {
>>   		switch (opt) {
>> @@ -448,14 +499,14 @@ int main(int argc, char *argv[])
>>   		goto exit;
>>   	}
>>
>> -	ring = vmbus_uio_map(&fcopy_fd, HV_RING_SIZE);
>> +	ring = vmbus_uio_map(&fcopy_fd, ring_size);
>>   	if (!ring) {
>>   		ret = errno;
>>   		syslog(LOG_ERR, "mmap ringbuffer failed; error: %d %s", ret, strerror(ret));
>>   		goto close;
>>   	}
>> -	vmbus_br_setup(&txbr, ring, HV_RING_SIZE);
>> -	vmbus_br_setup(&rxbr, (char *)ring + HV_RING_SIZE, HV_RING_SIZE);
>> +	vmbus_br_setup(&txbr, ring, ring_size);
>> +	vmbus_br_setup(&rxbr, (char *)ring + ring_size, ring_size);
>>
>>   	rxbr.vbr->imask = 0;
>>
>> @@ -472,7 +523,7 @@ int main(int argc, char *argv[])
>>   			goto close;
>>   		}
>>
>> -		len = HV_RING_SIZE;
>> +		len = ring_size;
>>   		ret = rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
>>   		if (unlikely(ret <= 0)) {
>>   			/* This indicates a failure to communicate (or worse) */
>>
>> base-commit: bc6e0ba6c9bafa6241b05524b9829808056ac4ad
>> --
>> 2.34.1



