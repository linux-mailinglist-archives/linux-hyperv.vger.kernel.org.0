Return-Path: <linux-hyperv+bounces-7059-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE965BB4901
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 18:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0648B2A7D31
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2526F45A;
	Thu,  2 Oct 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SfCeVYSX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998C26B0AE;
	Thu,  2 Oct 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422980; cv=none; b=ujCECSzViAL2yMXfq+ff1j5VjJ3OEYQLLD6SG52oAZfni9XXVOBMPwLt1qwt8G6COIs4VmaZr7Sy8JbtpYWRWxgHS+eYG6ImKEfy31V+ZINrYO4y3uCVRCQ+JWWr6Eh1xtsa3VVjogU2f5pldPngtg3q6caVuxPM1jiFpwHK2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422980; c=relaxed/simple;
	bh=C0pb9+KycBbIQtEUwFaqSHcEUHfrFb9Eljm/KL9DJRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jELw2FFhwujsWgpfyeIeQdtdLewixyO1h71nLrL17NmmpOum3MppKfLZwyMLvgFTVvsryVe3CAhGrUJiNQgfXkG5EclhSCxa1vi+LpttjphWxqCH9eDA3p9gHM/nZDeVfzi2sUOYDCPXVBQISut5E9qsY6vwN/SS1zSPhs+fc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SfCeVYSX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 935A6211AF28;
	Thu,  2 Oct 2025 09:36:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 935A6211AF28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759422978;
	bh=BfLzgvMsBoFeuTFJHMjvCaniW8T0D2QMO9bN885C9JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfCeVYSXjGFnxirqfVo+T4etoScXO8YazF5695IRP142uR1WJ7nJ3LL+wr66rQxnc
	 De4oibyJQZQpMHSoWiwvBY9WNJLZgzikU8gasJkUZMN4+gGZtMuGNhWIkw8sTgkvk8
	 avadTYpLTLIiwMXSJnsmSVYpUQZ3YkeojJfY8CYk=
Date: Thu, 2 Oct 2025 09:36:17 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Introduce movable pages for Hyper-V guests
Message-ID: <aN6qAa5DsesUR2eY@skinsburskii.localdomain>
References: <175916156212.55038.16727147489322393965.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <aNyoK8xfgy2zpKCf@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNyoK8xfgy2zpKCf@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>

On Wed, Oct 01, 2025 at 04:03:55AM +0000, Wei Liu wrote:
> On Mon, Sep 29, 2025 at 04:02:59PM +0000, Stanislav Kinsburskii wrote:
> > From the start, the root-partition driver allocates, pins, and maps all
> > guest memory into the hypervisor at guest creation. This is simple: Linux
> > cannot move the pages, so the guest’s view in Linux and in Microsoft
> > Hypervisor never diverges.
> > 
> > However, this approach has major drawbacks:
> > - NUMA: affinity can’t be changed at runtime, so you can’t migrate guest memory closer to the CPUs running it → performance hit.
> > - Memory management: unused guest memory can’t be swapped out, compacted, or merged.
> > - Provisioning time: upfront allocation/pinning slows guest create/destroy.
> > - Overcommit: no memory overcommit on hosts with pinned-guest memory.
> > 
> > This series adds movable memory pages for Hyper-V child partitions. Guest
> > pages are no longer allocated upfront; they’re allocated and mapped into
> > the hypervisor on demand (i.e., when the guest touches a GFN that isn’t yet
> > backed by a host PFN).
> > When a page is moved, Linux no longer holds it and it is unmapped from the hypervisor.
> > As a result, Hyper-V guests behave like regular Linux processes, enabling standard Linux memory features to apply to guests.
> > 
> > Exceptions (still pinned):
> >   1. Encrypted guests (explicit).
> >   2 Guests with passthrough devices (implicitly pinned by the VFIO framework).
> > 
> > v2:
> > - Split unmap batching into a separate patch.
> > - Fixed commit messages from v1 review.
> > - Renamed a few functions for clarity.
> > 
> > ---
> > 
> > Stanislav Kinsburskii (4):
> >       Drivers: hv: Refactor and rename memory region handling functions
> >       Drivers: hv: Centralize guest memory region destruction
> >       Drivers: hv: Batch GPA unmap operations to improve large region performance
> >       Drivers: hv: Add support for movable memory regions
> > 
> 
> Our internal test discovered an issue which caused a kernel panic. Has
> that been fixed in this series?
> 
> Without fixing that bug or ruling out problems in the code I don't think
> I can merge this. Once this feature goes into other people's systems it
> will be extremely difficult to debug.
> 
> Wei
> 

The issue in fixed in v3.

Thanks,
Stanislav.

> 
> > 
> >  drivers/hv/Kconfig             |    1 
> >  drivers/hv/mshv_root.h         |   10 +
> >  drivers/hv/mshv_root_hv_call.c |    2 
> >  drivers/hv/mshv_root_main.c    |  472 +++++++++++++++++++++++++++++++++-------
> >  4 files changed, 403 insertions(+), 82 deletions(-)
> > 

