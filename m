Return-Path: <linux-hyperv+bounces-7016-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4271BAA45F
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A681E1C35BC
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E1222A7E9;
	Mon, 29 Sep 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FwGnsfQs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721915855E;
	Mon, 29 Sep 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169996; cv=none; b=EXamF5oam1utpvkvV+T5Jt8hORnqL8yAySTxNgu/lAl6ZwvK0OVMYUjC3TWg3mRfKN4qmV20rlWXSaSrEqs/12k+PB+R0ViK61Gtne72yG0rpRzB/mwHb1HOJ9ok79Kr2tCQqqKcyjtECk/bJBTyuKvyU9ZHSICn+c/wxN2qKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169996; c=relaxed/simple;
	bh=ttpDsbGS5ksIxZymbfUiVHuHK55OkNnafxAHPDpRKDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klMP3qS8RzQWeqOGkSDLckrEMsTAgsrL9kmGb5Y71Jb0cRTAsBTQ1rXR5WrbphLLXBwni53VVccK5O8eENLlnKS+JNsPqBm62s6eOO2Ri8rozH9WCVQQswYDP7Yqsx6GAbzOMldLB7S+PqMtJpJkFib2GYB7sMMdNRVfoRpGxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FwGnsfQs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [IPV6:2607:fb91:1ec7:cd1:303d:40a1:4bbf:f2ba] (unknown [172.56.203.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id B365F2127311;
	Mon, 29 Sep 2025 11:19:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B365F2127311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759169993;
	bh=RC48fRHVCDacHh0fR1OhbOmQc9zmlSZh/DErJhB+dzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FwGnsfQsvVzzvopwRSvDdZC22h8L3688myXxLGCx107VPulGLJlsfqq/XQaNTeClA
	 UROotnX08FAzr6XffSkHfBs0YkU0vbzYxQvdOQPD4Gus9pwVcGu55MuL/UOxsBIT6t
	 prNWl4krzgrIIegntxfngPKJH0Hd0wi1+HTqriEw=
Message-ID: <96009fb8-0ad6-4e5b-8656-af78874a5605@linux.microsoft.com>
Date: Mon, 29 Sep 2025 11:19:51 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] mshv: Fixes for stats and vp state page mappings
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 tiala@microsoft.com, anirudh@anirudhrb.com,
 paekkaladevi@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <aNcd60fpoI1b6LUT@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aNcd60fpoI1b6LUT@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/2025 4:12 PM, Stanislav Kinsburskii wrote:
> On Fri, Sep 26, 2025 at 09:23:10AM -0700, Nuno Das Neves wrote:
>> There are some differences in how L1VH partitions must map stats and vp
>> state pages, some of which are due to differences across hypervisor
>> versions. Detect and handle these cases.
>>
> 
> I'm not sure that support for older and actully broken versions on
> hypervisor need to be usptreamed, as these versions will go away sooner
> or later and this support will become dead weight.
> 
As far as I know, these changes are relevant for shipped versions of the
hypervisor - they are not 'broken' except in some very specific cases
(live migration on L1VH, I think?)

The hypervisor team added a feature bit for these changes so that both old
and new versions of these APIs can be supported.

> I think we should upstrem only the changes needed for the new versiong
> of hypervisors instead and carry legacy support out of tree until it
> becomes obsoleted.
> 
Which version do you suggest to be the cutoff?

I'd prefer to support as many versions of the hypervisor as we can, as
long as they are at all relevant. We can remove the support later.
Removing prematurely just creates friction. Inevitably some users will
find themselves running on an older hypervisor and then it just fails
with a cryptic error. This includes myself, since I test L1VH on Azure
which typically has older hypervisor versions.

Nuno

> Thanks,
> Stanislav
> 
> 
>> Patch 1:
>> Fix for the logic of when to map the vp stats page for the root scheduler.
>>
>> Patch 2-3:
>> Add HVCALL_GET_PARTITION_PROPERTY_EX and use it to query "vmm capabilities" on
>> module init.
>>
>> Patches 4-5:
>> Check a feature bit in vmm capabilities, to take a new code path for mapping
>> stats and vp state pages. In this case, the stats and vp state pages must be
>> allocated by Linux, and a new hypercall HVCALL_MAP_VP_STATS_PAGE2 must be used
>> to map the stats page.
>>
>> ---
>> v4:
>> - Fixed some __packed attributes on unions [Stanislav]
>> - Cleaned up mshv_init_vmm_caps() [Stanislav]
>> - Cleaned up loop in hv_call_map_stats_page2() [Stanislav]
>>
>> v3:
>> https://lore.kernel.org/linux-hyperv/1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
>> - Fix bug in patch 4, in mshv_partition_ioctl_create_vp() cleanup path
>>   [kernel test robot]
>> - Make hv_unmap_vp_state_page() use struct page to match hv_map_vp_state_page()
>> - Remove SELF == PARENT check which doesn't belong in patch 5 [Easwar]
>>
>> v2:
>> https://lore.kernel.org/linux-hyperv/1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
>> - Remove patch falling back to SELF page if PARENT mapping fails [Easwar]
>>   (To be included in a future series)
>> - Fix formatting of function definitions [Easwar]
>>   - Fix some wording in commit messages [Praveen]
>>     - Proceed with driver init even if getting vmm capabilities fails [Anirudh]
>>
>> v1:
>> https://lore.kernel.org/linux-hyperv/1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
>>
>> ---
>> Jinank Jain (2):
>>   mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
>>   mshv: Introduce new hypercall to map stats page for L1VH partitions
>>
>> Nuno Das Neves (1):
>>   mshv: Only map vp->vp_stats_pages if on root scheduler
>>
>> Purna Pavan Chandra Aekkaladevi (2):
>>   mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
>>   mshv: Get the vmm capabilities offered by the hypervisor
>>
>>  drivers/hv/mshv_root.h         |  24 +++--
>>  drivers/hv/mshv_root_hv_call.c | 185 +++++++++++++++++++++++++++++++--
>>  drivers/hv/mshv_root_main.c    | 127 ++++++++++++----------
>>  include/hyperv/hvgdk_mini.h    |   2 +
>>  include/hyperv/hvhdk.h         |  40 +++++++
>>  include/hyperv/hvhdk_mini.h    |  33 ++++++
>>  6 files changed, 337 insertions(+), 74 deletions(-)
>>
>> -- 
>> 2.34.1


