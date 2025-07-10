Return-Path: <linux-hyperv+bounces-6176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A0CAFF9CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 08:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2351C85568
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E163287265;
	Thu, 10 Jul 2025 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n+t7K+9K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC343287258;
	Thu, 10 Jul 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128665; cv=none; b=cAkSXO2h0dJpL6K7fIx7iJ54pVk8dWX0gBQAJkeuhJXUTLAHGESndC2mvx6CQus/OJilGd8D5TDdCLzMrQIuVbLgINgZnvf32ond4AIB6hDlVbjS24/coGD4Oe9X0BAdR121CLBWHqIYX+KdHE3zJ5Y0B3I2XfjnZZAa5h1yoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128665; c=relaxed/simple;
	bh=ymwPWNJJsgZ6RW0m+vOuRlvr+kPdRXWSpovz0vsAdyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snTswT29047aS/hWTc7Uhmg5B6hwrnME0/ndfmo4IBT8boIa2f9PCfBnkiN9LQktgGVzXVAY/xT/XpHTT+kkO9DROkB/kvVXXlQY31fH1KcwhIEXNaowNI5mnREkkhj4URy0ghtH6D6ZIbmTws+Qpvsge26v+VBZvL6gKvPUmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n+t7K+9K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.160.22] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAE0A21130B9;
	Wed,  9 Jul 2025 23:24:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAE0A21130B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752128663;
	bh=EHJa5emz5zqIQxcHSm5z73ZxuksS20iqAv6kSHAYKU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n+t7K+9Kjr0jsWiUvRXMXizL3IjcMh9QXCOnccJhsWxWv31LVuiwhM9CRlvxDXXg1
	 9bcm8tzX3bjWCZt655btka10Wr/w6Z6p+VlWwwKBklCqCHaMURsTWUagyBn4rLU4na
	 fCeBrXKex+Od8ZjzdGzueaVbkS2vQktpO9UYA39Y=
Message-ID: <89ff0e52-377c-4c9f-a61e-f73639304767@linux.microsoft.com>
Date: Thu, 10 Jul 2025 11:54:16 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Olaf Hering <olaf@aepfle.de>
References: <20250708080319.3904-1-namjain@linux.microsoft.com>
 <20250709112201.GA26241@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250709112201.GA26241@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/9/2025 4:52 PM, Saurabh Singh Sengar wrote:
> On Tue, Jul 08, 2025 at 01:33:19PM +0530, Naman Jain wrote:
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
>>   tools/hv/hv_fcopy_uio_daemon.c | 82 +++++++++++++++++++++++++++++++---
>>   1 file changed, 75 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
>> index 0198321d14a2..5388ee1ebf4d 100644
>> --- a/tools/hv/hv_fcopy_uio_daemon.c
>> +++ b/tools/hv/hv_fcopy_uio_daemon.c
>> @@ -36,6 +36,7 @@
>>   #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
>>   
>>   #define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
>> +#define FCOPY_CHANNELS_PATH	"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels"
> 
> We can use a single path up to the device ID and then append either 'uio' or 'channels' using
> two separate variables.

I am planning to use it like this, please let me know if it is OK.

+#define FCOPY_DEVICE_PATH(subdir) 
"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/"#subdir
+#define FCOPY_UIO_PATH          FCOPY_DEVICE_PATH(uio)
+#define FCOPY_CHANNELS_PATH     FCOPY_DEVICE_PATH(channels)

> 
>>   
>>   #define FCOPY_VER_COUNT		1
>>   static const int fcopy_versions[] = {
>> @@ -47,9 +48,62 @@ static const int fw_versions[] = {
>>   	UTIL_FW_VERSION
>>   };
>>   
>> -#define HV_RING_SIZE		0x4000 /* 16KB ring buffer size */
>> +static uint32_t get_ring_buffer_size(void)
>> +{
>> +	char ring_path[PATH_MAX];
>> +	DIR *dir;
>> +	struct dirent *entry;
>> +	struct stat st;
>> +	uint32_t ring_size = 0;
>> +	int retry_count = 0;
>>   
>> -static unsigned char desc[HV_RING_SIZE];
>> +	/* Find the channel directory */
>> +	dir = opendir(FCOPY_CHANNELS_PATH);
>> +	if (!dir) {
>> +		usleep(100 * 1000); /* Avoid race with kernel, wait 100ms and retry once */
>> +		dir = opendir(FCOPY_CHANNELS_PATH);
>> +		if (!dir) {
>> +			syslog(LOG_ERR, "Failed to open channels directory: %s", strerror(errno));
>> +			return 0;
>> +		}
>> +	}
>> +
>> +retry_once:
>> +	while ((entry = readdir(dir)) != NULL) {
>> +		if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") != 0 &&
>> +		    strcmp(entry->d_name, "..") != 0) {
>> +			snprintf(ring_path, sizeof(ring_path), "%s/%s/ring",
>> +				 FCOPY_CHANNELS_PATH, entry->d_name);
>> +
>> +			if (stat(ring_path, &st) == 0) {
>> +				/*
>> +				 * stat returns size of Tx, Rx rings combined,
>> +				 * so take half of it for individual ring size.
>> +				 */
>> +				ring_size = (uint32_t)st.st_size / 2;
>> +				syslog(LOG_INFO, "Ring buffer size from %s: %u bytes",
>> +				       ring_path, ring_size);
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (!ring_size && retry_count == 0) {
>> +		retry_count = 1;
>> +		rewinddir(dir);
>> +		usleep(100 * 1000); /* Wait 100ms and retry once */
>> +		goto retry_once;
> 
> 		Is this retry solving any real problem ?

Yes, these two retry mechanism are added to avoid race conditions with 
creation of channels dir, numbered channels inside channels directory.
More in patch 1 comment by Michael.
https://lore.kernel.org/all/SN6PR02MB41574C54FFDE0D3F3B7A5649D47CA@SN6PR02MB4157.namprd02.prod.outlook.com/

> 
>> +	}
>> +
>> +	closedir(dir);
>> +
>> +	if (!ring_size)
>> +		syslog(LOG_ERR, "Could not determine ring size");
>> +
>> +	return ring_size;
>> +}
>> +
>> +static unsigned char *desc;
>>   
>>   static int target_fd;
>>   static char target_fname[PATH_MAX];
>> @@ -406,7 +460,7 @@ int main(int argc, char *argv[])
>>   	int daemonize = 1, long_index = 0, opt, ret = -EINVAL;
>>   	struct vmbus_br txbr, rxbr;
>>   	void *ring;
>> -	uint32_t len = HV_RING_SIZE;
>> +	uint32_t ring_size, len;
>>   	char uio_name[NAME_MAX] = {0};
>>   	char uio_dev_path[PATH_MAX] = {0};
>>   
>> @@ -437,6 +491,20 @@ int main(int argc, char *argv[])
>>   	openlog("HV_UIO_FCOPY", 0, LOG_USER);
>>   	syslog(LOG_INFO, "starting; pid is:%d", getpid());
>>   
>> +	ring_size = get_ring_buffer_size();
>> +	if (!ring_size) {
>> +		ret = -ENODEV;
>> +		goto exit;
>> +	}
>> +
>> +	len = ring_size;
> 
> 	Do we need this ?

Yes, because len is being used as a temporary variable for storing
ring_size, and it is modified when we pass it with reference in
rte_vmbus_chan_recv_raw. In order to avoid calculating ring sizes again,
we need to keep ring_size separate.

> 
>> +	desc = malloc(ring_size * sizeof(unsigned char));
>> +	if (!desc) {
>> +		syslog(LOG_ERR, "malloc failed for desc buffer");
>> +		ret = -ENOMEM;
>> +		goto exit;
>> +	}
> 
> 	This memory is not being freed anywhere. While I agree that freeing memory at
> 	program exit may not have much practical value, we can easily address
> 	this by adding a goto label for cleanup, this will keep all the static code
> 	analyzers happy.
> 

Sure. Will add it.

>> +
>>   	fcopy_get_first_folder(FCOPY_UIO, uio_name);
>>   	snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
>>   	fcopy_fd = open(uio_dev_path, O_RDWR);
>> @@ -448,14 +516,14 @@ int main(int argc, char *argv[])
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
>> @@ -472,7 +540,7 @@ int main(int argc, char *argv[])
>>   			goto close;
>>   		}
>>   
>> -		len = HV_RING_SIZE;
>> +		len = ring_size;
>>   		ret = rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
>>   		if (unlikely(ret <= 0)) {
>>   			/* This indicates a failure to communicate (or worse) */
>>
>> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
>> -- 
>> 2.34.1

Regards,
Naman

