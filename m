Return-Path: <linux-hyperv+bounces-5040-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D5A96E55
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A9F7A89A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4482857C7;
	Tue, 22 Apr 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="niBXZbIe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0FA285411;
	Tue, 22 Apr 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331951; cv=none; b=NrLvZsYF7hZf/Xv35hWXA2/tkQgkZp+9QyloNPH9VtlkNSXHOzBjlCFPW2HY1oFrBGo1yMPIf3kaMaK38/zgCMl7Wzp87i7kD6Gsn+O3ENjZsxOGE8uUxaRi8f+hn4QbXJaRPcY8jw1HLjJt40SSLPdiFe4KhvHhGFzF2ubNH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331951; c=relaxed/simple;
	bh=NdNX0/c69fqedzWEBG6s7uaqJPkkH7/TqpYU4kSDHcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVPFQ8hyRVlJARaNMIs5wtNVy9D3scPQYMnjQh0iCwLl2xuC8uvtjb3U2Nv5R5hFl1BvvNRD4WFU65URIEC1J1F76RqilIaJFVAbq8y/nSST0/BWyICDunPkIABue943BYyDz+88W2uMgoWm9r92ApguurOF7QobPym9F887jWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=niBXZbIe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.233.161] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEB6D203B870;
	Tue, 22 Apr 2025 07:25:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEB6D203B870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745331949;
	bh=LANKuzBhzhY2EF0Ndcxjqh9MZSKem70Fh4CxaCYBZSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=niBXZbIep6vCLnivoxVIzyPj7KO8Wzp6EPsS9DGeBlrJ+vUxGYJPaWozsmhAu9jUO
	 TcjzR0DC+o0rsvdAmz3PjdPKcwTlvQfCnqa3P+rl8rLQ6Chv16xr1CZYDZJY91ktmL
	 aUF/SHnDlv6PE63E/+qCSQzlTeZq9qCWMqHK5yQw=
Message-ID: <54905359-035b-4974-bdae-3e60e903adbd@linux.microsoft.com>
Date: Tue, 22 Apr 2025 19:55:45 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@kernel.org" <stable@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250415164452.170239-1-namjain@linux.microsoft.com>
 <20250415164452.170239-2-namjain@linux.microsoft.com>
 <BL4PR21MB4627D99C78C22A8C3355059CBFBF2@BL4PR21MB4627.namprd21.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <BL4PR21MB4627D99C78C22A8C3355059CBFBF2@BL4PR21MB4627.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/2025 6:39 AM, Dexuan Cui wrote:
>> From: Naman Jain <namjain@linux.microsoft.com>
>> Sent: Tuesday, April 15, 2025 9:45 AM
>> Subject: [PATCH v5 1/2] uio_hv_generic: Fix sysfs creation path for ring buffer
>>
>> On regular bootup, devices get registered to VMBus first, so when
>> uio_hv_generic driver for a particular device type is probed,
>> the device is already initialized and added, so sysfs creation in
>> uio_hv_generic probe works fine. However, when device is removed
> 
> Sorry, I'd like to nitpick :-) I guess the maintainer(s) can fix these for you
> so v6 might not be necessary, if there is no comment from others.
> 
> s/uio_hv_generic probe/hv_uio_probe()/
> s/device/the device/
> 
>> and brought back, the channel rescinds and device again gets
> s/rescinds and device/gets rescinded and the device/
> 
>> registered to VMBus. However this time, the uio_hv_generic driver is
>> already registered to probe for that device and in this case sysfs
>> creation is tried before the device's kobject gets initialized
>> completely.
>>
>> Fix this by moving the core logic of sysfs creation for ring buffer,
> s/for/of/
> 
>> from uio_hv_generic to HyperV's VMBus driver, where rest of the sysfs
> s/rest/the rest/
> 
>> attributes for the channels are defined. While doing that, make use
>> of attribute groups and macros, instead of creating sysfs directly,
>> to ensure better error handling and code flow.
>>
>> Problem path:
> s/Problem/Problematic/
> 
>> vmbus_process_offer (new offer comes for the VMBus device)
> s/new/A new/
> 
>>    vmbus_add_channel_work
>>      vmbus_device_register
>>        |-> device_register
>>        |     |...
>>        |     |-> hv_uio_probe
>>        |           |...
>>        |           |-> sysfs_create_bin_file (leads to a warning as
>>        |                 primary channel's kobject, which is used to
> s/primary/the primary/
> 
>>        |                 create sysfs is not yet initialized)
> s/sysfs/the sysfs file, /
> 
>>        |-> kset_create_and_add
>>        |-> vmbus_add_channel_kobj (initialization of primary channel's
> s/primary/the primary/
> 
>>                                    kobject happens later)
>>
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>


Thanks Dexuan. I'll make the required changes and send next patch.

Regards,
Naman


