Return-Path: <linux-hyperv+bounces-7004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6DEBA5608
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Sep 2025 01:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7999B7403FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 23:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7529D28F;
	Fri, 26 Sep 2025 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a1AXYKEf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A71C7013;
	Fri, 26 Sep 2025 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758928368; cv=none; b=VRYIIfAN72r/eZK+p1i0+uMhJnwqDWLE3jKAyXrYvSU4U3L94HMWmJDjyvTqkYWBaUrzgQ2lMPv2u7rcx/XFixSoOzQ88uZrgN5HRgLrvsqxxFn/OSjQAFkecF1gVHuaN+VpO7fkYSgpvCpQdrpX8efYaQ+hXIFNLNacqtzSd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758928368; c=relaxed/simple;
	bh=ExNeg5QFHgdickeS+V3ndkholgHo5Jo3HJErvHCx8jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGHuDrUH3NCVsVNRqI8o8gO4iDdSu1iWO0VoDplRez9x+kdhS0ehkI45fsNEKEUNJ+mlW4ZtCY0sO0mhxY7HoR9qPn6nUJYycURaSp1/pkg3dyYRVBevsM6r2JJ6KpDxb09HP9yLArY/3bU5ug17Yl0omNK4Vo465ONq0eKpgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a1AXYKEf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 875D82012C15;
	Fri, 26 Sep 2025 16:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 875D82012C15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758928365;
	bh=vOluij9pxCgidrm60CpObZ4YYLDnXIHXbDQtIMufU7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1AXYKEf5Lhu7j3RFUxqxf+s0aF88Mtk+vT+DRNHSpRs91/lUsGbnvDmi17bK5ZNK
	 PxNmnI9dbaT5x9eswGE4Vd4tEwBFpvIYnPoQtzroHmy6RBNZikJlv32AG0erazATKV
	 rW24yzJkJm4Dp6v9KfbiIkXP8gQQszt2P0NiicS0=
Date: Fri, 26 Sep 2025 16:12:43 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Subject: Re: [PATCH v4 0/5] mshv: Fixes for stats and vp state page mappings
Message-ID: <aNcd60fpoI1b6LUT@skinsburskii.localdomain>
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Sep 26, 2025 at 09:23:10AM -0700, Nuno Das Neves wrote:
> There are some differences in how L1VH partitions must map stats and vp
> state pages, some of which are due to differences across hypervisor
> versions. Detect and handle these cases.
> 

I'm not sure that support for older and actully broken versions on
hypervisor need to be usptreamed, as these versions will go away sooner
or later and this support will become dead weight.

I think we should upstrem only the changes needed for the new versiong
of hypervisors instead and carry legacy support out of tree until it
becomes obsoleted.

Thanks,
Stanislav


> Patch 1:
> Fix for the logic of when to map the vp stats page for the root scheduler.
> 
> Patch 2-3:
> Add HVCALL_GET_PARTITION_PROPERTY_EX and use it to query "vmm capabilities" on
> module init.
> 
> Patches 4-5:
> Check a feature bit in vmm capabilities, to take a new code path for mapping
> stats and vp state pages. In this case, the stats and vp state pages must be
> allocated by Linux, and a new hypercall HVCALL_MAP_VP_STATS_PAGE2 must be used
> to map the stats page.
> 
> ---
> v4:
> - Fixed some __packed attributes on unions [Stanislav]
> - Cleaned up mshv_init_vmm_caps() [Stanislav]
> - Cleaned up loop in hv_call_map_stats_page2() [Stanislav]
> 
> v3:
> https://lore.kernel.org/linux-hyperv/1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
> - Fix bug in patch 4, in mshv_partition_ioctl_create_vp() cleanup path
>   [kernel test robot]
> - Make hv_unmap_vp_state_page() use struct page to match hv_map_vp_state_page()
> - Remove SELF == PARENT check which doesn't belong in patch 5 [Easwar]
> 
> v2:
> https://lore.kernel.org/linux-hyperv/1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
> - Remove patch falling back to SELF page if PARENT mapping fails [Easwar]
>   (To be included in a future series)
> - Fix formatting of function definitions [Easwar]
>   - Fix some wording in commit messages [Praveen]
>     - Proceed with driver init even if getting vmm capabilities fails [Anirudh]
> 
> v1:
> https://lore.kernel.org/linux-hyperv/1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t
> 
> ---
> Jinank Jain (2):
>   mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
>   mshv: Introduce new hypercall to map stats page for L1VH partitions
> 
> Nuno Das Neves (1):
>   mshv: Only map vp->vp_stats_pages if on root scheduler
> 
> Purna Pavan Chandra Aekkaladevi (2):
>   mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
>   mshv: Get the vmm capabilities offered by the hypervisor
> 
>  drivers/hv/mshv_root.h         |  24 +++--
>  drivers/hv/mshv_root_hv_call.c | 185 +++++++++++++++++++++++++++++++--
>  drivers/hv/mshv_root_main.c    | 127 ++++++++++++----------
>  include/hyperv/hvgdk_mini.h    |   2 +
>  include/hyperv/hvhdk.h         |  40 +++++++
>  include/hyperv/hvhdk_mini.h    |  33 ++++++
>  6 files changed, 337 insertions(+), 74 deletions(-)
> 
> -- 
> 2.34.1

