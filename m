Return-Path: <linux-hyperv+bounces-5641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0FAC1FB4
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78369A407EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340F224256;
	Fri, 23 May 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="laIigKlB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105B1A0731;
	Fri, 23 May 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992339; cv=none; b=dxzIrwOm2qi8JJfoNRJAcop5vdyi4ID8HILYrCSy83Fp6T4r4b25nCAxMPD5T2zfCOPNNm7aOB5KbFM1fuKQ2B07Uf8BDLiG47FSuNFBG6jRO+HsV3xrpJ3aARhSNb8izFgNOtynIwwb1gCTd7lMwcGWq+8Cx+36kF2uS0oD5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992339; c=relaxed/simple;
	bh=wuEDD/o3pMGpC2xsm2b9jW9ERwYXEy7VE2p+6CEMS70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z245puvM0aDtcEezmEwAdNbKGGdFvdMrvsuWxXCMlMEXfCfzyfIFX5HYKquJ+2jCNAedK1G4XwU7yQhYQlm+t1ieNA0J/UBx4OmfQtlKAit2SheS7ViFMpX3r1HyqprXPtGxGr6D45hMSjYqZJJ5v6FwNoBEEMo31Gs1WL7uAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=laIigKlB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.97.162] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id B53AC20277DC;
	Fri, 23 May 2025 02:25:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B53AC20277DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747992336;
	bh=FI6Rb5O+Dr8fAzJRvb3pITqXlzwhR6WJ25aFkzCiHz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=laIigKlBtUpR+Va9NsXvLqeXHOmlnApPpOTSQKC42KzDRF2C38ULGuBtov2C+1xc2
	 AqpueV1V/Ov/jY2tGJZEEG92yyDmbRNePZQr8lvgDVgm+S+fMShnB8/fuwXj66XGlT
	 6hTMgQzU9Ntui13VEil5+kpx+pi02CtM/hkd0tw4=
Message-ID: <e7763e8c-5f3a-4a37-a696-1b8492d92662@linux.microsoft.com>
Date: Fri, 23 May 2025 14:55:32 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20250519045642.50609-1-namjain@linux.microsoft.com>
 <20250519045642.50609-3-namjain@linux.microsoft.com>
 <aCzQMuwQZ1Lkk7eH@skinsburskii.>
 <80853cdb-fd34-4a5e-99a0-1a71b8ce8226@linux.microsoft.com>
 <aC9oeJPFynyYg9pU@skinsburskii.>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aC9oeJPFynyYg9pU@skinsburskii.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/2025 11:40 PM, Stanislav Kinsburskii wrote:
> On Wed, May 21, 2025 at 11:33:29AM +0530, Naman Jain wrote:
>>
>>
>> On 5/21/2025 12:25 AM, Stanislav Kinsburskii wrote:
>>> On Mon, May 19, 2025 at 10:26:42AM +0530, Naman Jain wrote:
>>>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>>>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>>>> Expose devices and support IOCTLs for features like VTL creation,
>>>> VTL0 memory management, context switch, making hypercalls,
>>>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>>>> messages and channel events in VTL2 etc.
>>>>
>>>> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
>>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>>> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>>>> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>>>> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
>>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>>> ---
>>>>    drivers/hv/Kconfig          |   20 +
>>>>    drivers/hv/Makefile         |    7 +-
>>>>    drivers/hv/mshv_vtl.h       |   52 +
>>>>    drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
>>>>    include/hyperv/hvgdk_mini.h |   81 ++
>>>>    include/hyperv/hvhdk.h      |    1 +
>>>>    include/uapi/linux/mshv.h   |   82 ++
>>>>    7 files changed, 2025 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/hv/mshv_vtl.h
>>>>    create mode 100644 drivers/hv/mshv_vtl_main.c
>>>>
>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>>> index eefa0b559b73..21cee5564d70 100644
>>>> --- a/drivers/hv/Kconfig
>>>> +++ b/drivers/hv/Kconfig
>>>> @@ -72,4 +72,24 @@ config MSHV_ROOT
>>>>    	  If unsure, say N.
>>>> +config MSHV_VTL
>>>> +	tristate "Microsoft Hyper-V VTL driver"
>>>> +	depends on HYPERV && X86_64
>>>> +	depends on TRANSPARENT_HUGEPAGE
>>>
>>> Why does it depend on TRANSPARENT_HUGEPAGE?
>>>
>>
> 
> Let me rephrase: can this driver work without transparent huge pages?
> If yes, then it shouldn't depend on the option and rather select it.
> If not, then it should be either fixed to be able to or have an
> expalanation why this dependecy was introduced.

No, it won't work. Reason being - we are adding support to map VTL0 
address space to a user-mode process in VTL2. VTL2 for OpenHCL makes use 
of Huge pages to improve performance on VMs having large memory 
requirements. Thus, we need TRANSPARENT_HUGEPAGE.

I will add this as a comment in Kconfig.

> 
>>>> +
>>>> +/* vtl device */
>>>> +#define MSHV_CREATE_VTL			_IOR(MSHV_IOCTL, 0x1D, char)
>>>> +#define MSHV_VTL_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
>>>> +#define MSHV_VTL_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
>>>> +#define MSHV_VTL_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
>>>> +#define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
>>>> +#define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
>>>> +
>>>> +/* VMBus device IOCTLs */
>>>> +#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl_signal_event)
>>>> +#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl_sint_post_msg)
>>>> +#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl_set_eventfd)
>>>> +#define MSHV_SINT_PAUSE_MESSAGE_STREAM     _IOW(MSHV_IOCTL, 0x25, struct mshv_sint_mask)
>>>> +
>>>> +/* hv_hvcall device */
>>>> +#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
>>>> +#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
>>>
>>> How many of these ioctls are actually used by the mshv root driver?
>>> Should those which are VTl-specific be named as such (like MSHV_VTL_SET_POLL_FILE)?
>>> Another option would be to keep all the names generic.
>>>
>>> Thanks,
>>> Stanislav
>>
>> None of the IOCTLs in mshv_vtl section, introduced in this patch is used
>> by mshv_root driver. Since IOCTLs of mshv_root does not have MSHV_ROOT
>> prefix, I am OK with removing MSHV_VTL_* prefix from these IOCTL names.
>> You can let me know if you want me to prefix them with MSHV_VTL.
>>
>> Thanks again for reviewing.
>>
>> Regards,
>> Naman
>>
> 
> As these ioctls share the same "namespace" (MSHV_IOCTL), removal os the
> VTL suffix looks a better optio to me.
> 
> Thanks,
> Stanislav.


Will make the changes in next patch. Thanks.

Regards,
Naman


