Return-Path: <linux-hyperv+bounces-5878-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CCAD5DAB
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 20:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A7D174223
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D99258CDC;
	Wed, 11 Jun 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HktHWfx3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D91244678;
	Wed, 11 Jun 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664812; cv=none; b=gZm+YsYO2k08NZqkJHlYkO770Hg1x0F/lxNiIC5t6E9BhOdV7s0cNynGWobpaA+IGL34kUFqkTVqV7fWgVnqpF+MQ7VlIeTqxVUYItbm3l6yWkUgPOfciksC4fjbjQCTYUtHNynJDNocMUuPQp4UvCFKXHcIP3mFJOEEOM98p9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664812; c=relaxed/simple;
	bh=KlnMCl+JWTR4vag+rTUNR+POorFEvuqAqbk1bhUtLk8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QWKPfJgUWvbeQeNIoaIc9E9FHFi3Qx+iEskc6YCHUUlKEescbEuUX9wmtds845SUrF7IEwF7IGStmbQ4bUJ4kfcNX46en8Ocnw/JksfcQdhuBlOc2W/MNF0xQ2BxMaFjD53COWWX/N7YGIUZpR1oDse6zoHQFKJcGWsO2Xe1sOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HktHWfx3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.225.229] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id C660C21151A2;
	Wed, 11 Jun 2025 11:00:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C660C21151A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749664811;
	bh=dbrvDIIvFK57NZQv781wDufNFlpQT1k9keSoeqSk8OU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HktHWfx3nn4nLvQkFUEDVbFAWkz8jpDFYsSm9WzHht9i9jiwwCi+9lO2kg5FEBff1
	 yXAqDbH1odWJUFdwQ4Krfg+iKt3I2Agn7yMg+LBpvTcfqON4QvLpaJgtaPDKcxLj7g
	 6n4tx+1ycDVaF6DQtzWVmnyX4AOKrJPy/EO9x6tg=
Message-ID: <6be766a4-c983-4316-a07b-fd96238191e4@linux.microsoft.com>
Date: Wed, 11 Jun 2025 11:00:11 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, eahariha@linux.microsoft.com,
 Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <20250611072704.83199-1-namjain@linux.microsoft.com>
 <20250611072704.83199-3-namjain@linux.microsoft.com>
 <2f2a252f-c2cb-40ee-a416-c07fd120dd49@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <2f2a252f-c2cb-40ee-a416-c07fd120dd49@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/2025 9:46 AM, Nuno Das Neves wrote:
> On 6/11/2025 12:27 AM, Naman Jain wrote:
>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>> Expose devices and support IOCTLs for features like VTL creation,
>> VTL0 memory management, context switch, making hypercalls,
>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>> messages and channel events in VTL2 etc.
>>
>> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
>> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>  drivers/hv/Kconfig          |   23 +
>>  drivers/hv/Makefile         |    7 +-
>>  drivers/hv/mshv_vtl.h       |   52 +
>>  drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
>>  include/hyperv/hvgdk_mini.h |   81 ++
>>  include/hyperv/hvhdk.h      |    1 +
>>  include/uapi/linux/mshv.h   |   82 ++
>>  7 files changed, 2028 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/hv/mshv_vtl.h
>>  create mode 100644 drivers/hv/mshv_vtl_main.c
>>

<snip>

> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Hi Nuno,

In the future, please trim unnecessary context, example above, following 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

"Similarly, please trim all unneeded quotations that aren’t relevant to your reply.
This makes responses easier to find, and saves time and space. For more details see:
 http://daringfireball.net/2007/07/on_top"

Thanks,
Easwar (he/him)

