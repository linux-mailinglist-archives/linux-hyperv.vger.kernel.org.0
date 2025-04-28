Return-Path: <linux-hyperv+bounces-5191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9FA9EB7A
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BB9189554F
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C019255233;
	Mon, 28 Apr 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qCnlABXX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4619C54B;
	Mon, 28 Apr 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745831248; cv=none; b=HJYO32/+J82hmjTJRvX+zKfLBPLc863w2juD71bEzPzvRvsONyo5untAfWeSIKnKZN8xiDeQo5GxgjGn+xSiPg0vBCRWs0C1EURjEPsFoTlVuh62qCMvOk2Df3FdEHroDeFx1grk+EBqNE3MtT7Q98xbIp25cx3lu2D+FzLI9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745831248; c=relaxed/simple;
	bh=yRVAPAAZndLJ1UH7zj0G8F+LglBBr19xipI83x+4VV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSHaKiaGPkIUQZVPB4ja+nzUmz0N8drPzg4TKDJCdioyvw243UQsvKiuWWNIPHDHTs18m9FS7jyVnVoxQF3g0yLKn2RCGQaOIOp+YYbFV3q+YYvIYEH4QX9/OIrcP9PANd9vXoCbsQhVkt4xwexA7d1cdw0t4NoypLMmEMT9eDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qCnlABXX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14036204E7CE;
	Mon, 28 Apr 2025 02:07:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14036204E7CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745831246;
	bh=5UtZ1Z4W6v48GiXx23x6Kspz0f+QWcBoQc3srB0Rl44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qCnlABXXsCvuBb5bZV67XHvF1mvkJoUgunNdhUJ+SRZ91DnddXMLJymOChQVRsKAx
	 wCNt/wDD7I9x8gTR63Gys/AK/9UYrQB8Aq6nyx6khFprUyE06loslCec51igclY3y4
	 eikdHdKvHdxbsHxrKub6OZdk8RyTVqwlnYv67Dew=
Message-ID: <752c5b1c-ef67-4644-95d4-712cdba6ad2b@linux.microsoft.com>
Date: Mon, 28 Apr 2025 14:37:22 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250424053524.1631-1-namjain@linux.microsoft.com>
 <2025042501-accuracy-uncombed-cb99@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025042501-accuracy-uncombed-cb99@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/2025 7:30 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 24, 2025 at 11:05:22AM +0530, Naman Jain wrote:
>> Hi,
>> This patch series aims to address the sysfs creation issue for the ring
>> buffer by reorganizing the code. Additionally, it updates the ring sysfs
>> size to accurately reflect the actual ring buffer size, rather than a
>> fixed static value.
>>
>> PFB change logs:
>>
>> Changes since v5:
>> https://lore.kernel.org/all/20250415164452.170239-1-namjain@linux.microsoft.com/
>> * Added Reviewed-By tags from Dexuan. Also, addressed minor comments in
>>    commit msg of both patches.
>> * Missed to remove check for "primary_channel->device_obj->channels_kset" in
>>    hv_create_ring_sysfs in earlier patch, as suggested by Michael. Did it
>>    now.
>> * Changed type for declaring bin_attrs due to changes introduced by
>>    commit 9bec944506fa ("sysfs: constify attribute_group::bin_attrs") which
>>    merged recently. Did not use bin_attrs_new since another change is in
>>    the queue to change usage of bin_attrs_new to bin_attrs
>>    (sysfs: finalize the constification of 'struct bin_attribute').
> 
> Please fix up to apply cleanly without build warnings:
> 
> drivers/hv/vmbus_drv.c:1893:15: error: initializing 'struct bin_attribute **' with an expression of type 'const struct bin_attribute *const[2]' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>   1893 |         .bin_attrs = vmbus_chan_bin_attrs,
>        |                      ^~~~~~~~~~~~~~~~~~~~
> 1 error generated.

Hi Greg,
I tried reproducing this error but could not see it. Should I rebase the 
change to some other tree or use some specific config option, gcc 
version, compilation flag etc.?

I tried the following:
* Rebased to latest linux-next tip with below base commit:
393d0c54cae31317deaa9043320c5fd9454deabc
* Regular compilation with gcc: make -j8
* extra flags:
   make -j8  EXTRA_CFLAGS="-Wall -O2"
   make -j8 
EXTRA_CFLAGS="-Wincompatible-pointer-types-discards-qualifiers -Werror"
* Tried gcc 11.4, 13.3
* Tried clang/LLVM with version 18.1.3 : make LLVM=1



BTW I had to edit the type for bin_attrs as this change got merged recently:
9bec944506fa ("sysfs: constify attribute_group::bin_attrs")

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 576b8b3c60af..f418aae4f113 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -107,7 +107,7 @@ struct attribute_group {
                                             int);
         struct attribute        **attrs;
         union {
-               struct bin_attribute            **bin_attrs;
+               const struct bin_attribute      *const *bin_attrs;
                 const struct bin_attribute      *const *bin_attrs_new;
         };
  };


Regards,
Naman

