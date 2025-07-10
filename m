Return-Path: <linux-hyperv+bounces-6177-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE862AFFD77
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549631C424DC
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250CA28DF02;
	Thu, 10 Jul 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qOGDr0C/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C7D28C2B8;
	Thu, 10 Jul 2025 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138077; cv=none; b=PV4j1UZobSHc4+842VeyAVcFWKBFTKuuWNz8UVc/9SOtuJQzNN030ePio55sp7ZOxji9m+tTD9ndKLVmA561q0hY017RKGZUxJ30ZQSH2oVRl7i/o27f72DIWGABpH6BSthcWFrmKVHcWDp7pBDg3EMhXYVLCNFruDTHv7v81GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138077; c=relaxed/simple;
	bh=1ZgjcPt9CkUrby8Vad2FszjM+h8Ujoln/ehX/EZ4vA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3bWNmT2IuX7CtYbNThD8Jh/62Cxu4B2GsrxdG67AtpsIxfGyqo7gupCMxpA+z76S3VLhYJ/bw6r6PeatuJQLZD5Bn787461YudlCMJSzyZ8ajDy9ECAQ1GYc+UsgafHEJRfZroXUsmEGgXVBMDexVTO8Ve7m9a5zA3eaVW0XvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qOGDr0C/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.160.22] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id C54BA2116DB2;
	Thu, 10 Jul 2025 02:01:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C54BA2116DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752138075;
	bh=HL7ROpKz+NyMfjU8c9SiXfT1Nmhu0bdk21Sb4PNKtro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qOGDr0C/RQuFWOMsayOvarWWZB4ieNgyq6s5bTKooxJMQvXQh3lRIjupZyQLWBe5C
	 a1eHJ7afyGm6i9mbrY5wTHnmfCE3B7PTB8lR833ut/D4jNnPwDLcHRDPE2bbN21Gj7
	 7YcodfDxLYji9kl7SWSo/tURzMw8JUi9vtmELi7I=
Message-ID: <45958272-1127-465d-a56e-65d7f0bff1bf@linux.microsoft.com>
Date: Thu, 10 Jul 2025 14:31:08 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/9/2025 10:49 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, June 11, 2025 12:27 AM
>>
>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>> Expose devices and support IOCTLs for features like VTL creation,
>> VTL0 memory management, context switch, making hypercalls,
>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>> messages and channel events in VTL2 etc.
>>
> 
> I know it has been 4 weeks since you posted this patch, but I'm just
> now getting around to reviewing it. :-(
> 
> I've reviewed most of it reasonably carefully, but there are some
> parts, such as entering/exiting VTLs that I don't know the details of,
> and so just glossed over.
> 

Thanks Michael for your review comments. ARM64, sev-SNP support, along
with other features are in pipeline, and will be taken up once we have a
working driver in, for x86. I'll address your comments and make the
required changes in coming days.

Regards,
Naman

<snip>

