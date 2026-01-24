Return-Path: <linux-hyperv+bounces-8514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFueBB4udGl92wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8514-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 03:27:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 694107C387
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 03:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E9103019920
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 02:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577720B7ED;
	Sat, 24 Jan 2026 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mm3uS6ln"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4D2AE8D;
	Sat, 24 Jan 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769221657; cv=none; b=SlaorXOii+z91GnC+2GEAIpT6B6C5btcMtDQnuardEP9iLfLsirugVcCfB7+VfWbU34wGKR83nD2jbQJFdYfdn4NW/PMlBY1HHUfyfDZxd1NkPUXuAWsP1o3WMTPuP4WHYTKy7vFTqVn3vAyLtZPu98gSBKFiKpNXkOg1Divyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769221657; c=relaxed/simple;
	bh=6QoxWTLvgZMqmlC876KlJ3u6SCCBvsx0O80CrSJNRg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilrYMZOaWomTnjrtrJ5AEg+QHsZVYERmPDQSItpRFgtY1AFneltJWURfzjhRck2/CkAn9Wg2n/SjTrKyjWcD5v1rONQ2IqRLLP9OFWGLxx6v0iTj0iKOgwO5yrT1HoLtxO/FmAoPPJ5ZCAL45SNroj8Wid7wy74dMsezR4N2YX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mm3uS6ln; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 238F120B7167;
	Fri, 23 Jan 2026 18:27:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 238F120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769221655;
	bh=kCVqDvHy5B6w0DimA3jf1nqis+n/ymqDPTFfWJQ9xCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mm3uS6lnYTE7qJBLr9zU/W/yLV8ymPsdbCUmrntTDqIEQnaCgtahGfq6XhrFvBXLb
	 NdvnxrCtd4vngwf37xU01YelLuRbT3RZ7JhQvpfoZueaI4h3cScWInpsmJZbzOoNE7
	 1ryZR0dNAUUaomPkj6zTA1NLy2Korhz2Ht/j9OCI=
Message-ID: <8300a3b5-873c-4911-689f-cd3ab2d9d7e4@linux.microsoft.com>
Date: Fri, 23 Jan 2026 18:27:34 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 00/15] PCI passthru on Hyper-V (Part I)
Content-Language: en-US
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120134933.00004f2a@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260120134933.00004f2a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8514-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 694107C387
X-Rspamd-Action: no action

On 1/20/26 13:50, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Mon, 19 Jan 2026 22:42:15 -0800
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>
>> Implement passthru of PCI devices to unprivileged virtual machines
>> (VMs) when Linux is running as a privileged VM on Microsoft Hyper-V
>> hypervisor. This support is made to fit within the workings of VFIO
>> framework, and any VMM needing to use it must use the VFIO subsystem.
>> This supports both full device passthru and SR-IOV based VFs.
>>
>> There are 3 cases where Linux can run as a privileged VM (aka MSHV):
>>    Baremetal root (meaning Hyper-V+Linux), L1VH, and Nested.
>>
> I think some introduction/background to L1VH would help.

Ok, i can add something, but l1vh was very well introduced if you
search the mshv commits for "l1vh".

>> At a high level, the hypervisor supports traditional mapped iommu
>> domains that use explicit map and unmap hypercalls for mapping and
>> unmapping guest RAM into the iommu subsystem.
> It may be clearer to state that the hypervisor supports Linux IOMMU
> paging domains through map/unmap hypercalls, mapping GPAs to HPAs using
> stage?2 I/O page tables.

sure.

>> Hyper-V also has a
>> concept of direct attach devices whereby the iommu subsystem simply
>> uses the guest HW page table (ept/npt/..). This series adds support
>> for both, and both are made to work in VFIO type1 subsystem.
>>
> This may warrant introducing a new IOMMU domain feature flag, as it
> performs mappings but does not support map/unmap semantics in the same
> way as a paging domain.

Yeah, I was hoping we can get by for now without it. At least in case of
the cloud hypervisor, entire guest ram is mapped anyways. We can document
it and work on enhancements which are much easier once we have a baseline.
For now, it's a paging domain will all pages pinned.. :).

>> While this Part I focuses on memory mappings, upcoming Part II
>> will focus on irq bypass along with some minor irq remapping
>> updates.
>>
>> This patch series was tested using Cloud Hypervisor verion 48. Qemu
>> support of MSHV is in the works, and that will be extended to include
>> PCI passthru and SR-IOV support also in near future.
>>
>> Based on: 8f0b4cce4481 (origin/hyperv-next)
>>
>> Thanks,
>> -Mukesh
>>
>> Mukesh Rathor (15):
>>    iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
>>    x86/hyperv: cosmetic changes in irqdomain.c for readability
>>    x86/hyperv: add insufficient memory support in irqdomain.c
>>    mshv: Provide a way to get partition id if running in a VMM process
>>    mshv: Declarations and definitions for VFIO-MSHV bridge device
>>    mshv: Implement mshv bridge device for VFIO
>>    mshv: Add ioctl support for MSHV-VFIO bridge device
>>    PCI: hv: rename hv_compose_msi_msg to hv_vmbus_compose_msi_msg
>>    mshv: Import data structs around device domains and irq remapping
>>    PCI: hv: Build device id for a VMBus device
>>    x86/hyperv: Build logical device ids for PCI passthru hcalls
>>    x86/hyperv: Implement hyperv virtual iommu
>>    x86/hyperv: Basic interrupt support for direct attached devices
>>    mshv: Remove mapping of mmio space during map user ioctl
>>    mshv: Populate mmio mappings for PCI passthru
>>
>>   MAINTAINERS                         |    1 +
>>   arch/arm64/include/asm/mshyperv.h   |   15 +
>>   arch/x86/hyperv/irqdomain.c         |  314 ++++++---
>>   arch/x86/include/asm/mshyperv.h     |   21 +
>>   arch/x86/kernel/pci-dma.c           |    2 +
>>   drivers/hv/Makefile                 |    3 +-
>>   drivers/hv/mshv_root.h              |   24 +
>>   drivers/hv/mshv_root_main.c         |  296 +++++++-
>>   drivers/hv/mshv_vfio.c              |  210 ++++++
>>   drivers/iommu/Kconfig               |    1 +
>>   drivers/iommu/Makefile              |    2 +-
>>   drivers/iommu/hyperv-iommu.c        | 1004
>> +++++++++++++++++++++------ drivers/iommu/hyperv-irq.c          |
>> 330 +++++++++ drivers/pci/controller/pci-hyperv.c |  207 ++++--
>>   include/asm-generic/mshyperv.h      |    1 +
>>   include/hyperv/hvgdk_mini.h         |   11 +
>>   include/hyperv/hvhdk_mini.h         |  112 +++
>>   include/linux/hyperv.h              |    6 +
>>   include/uapi/linux/mshv.h           |   31 +
>>   19 files changed, 2182 insertions(+), 409 deletions(-)
>>   create mode 100644 drivers/hv/mshv_vfio.c
>>   create mode 100644 drivers/iommu/hyperv-irq.c
>>


