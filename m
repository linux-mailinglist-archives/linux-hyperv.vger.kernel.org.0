Return-Path: <linux-hyperv+bounces-7039-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C673BAF142
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Oct 2025 06:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9106192415A
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Oct 2025 04:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EBC27B34A;
	Wed,  1 Oct 2025 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnUYVT41"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D386347;
	Wed,  1 Oct 2025 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759292312; cv=none; b=WmVKBDvvfZk0wtfxLvoLidPId3c5K9QX3ehBzPN4dS9IvRTzcMPNU4LmPlK0le2J5SCztBgCjBqxTXqxLVCIP0o1bwpiPblPdy2Cdij5zRyvETkw7gby9a/oQ35VbPVybQ3w4ezQs/rgdUfyjNTjFMnYvARrrLOaSgj30j+ml+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759292312; c=relaxed/simple;
	bh=IoMm439F476AZ6YQyyrHTHvvjYtDemnZxDTAjFrgqFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4zbWVQ7dn+gmXG/6MQBxuhFCk0AluRdYxU9xMVCQF/YIkhXL3q8QyMQZOHp2zQJk69bEqdb4lmaavlXDLKxj8o0Ggd0n2YB5CyjWyto+Gr74P0xbEZy3KnUpVcJmn9oisl+4kUhMDstAmId8rYstxkXrmJmCMY2bJPZteE1ZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnUYVT41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9999C4CEF4;
	Wed,  1 Oct 2025 04:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759292311;
	bh=IoMm439F476AZ6YQyyrHTHvvjYtDemnZxDTAjFrgqFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnUYVT41S15vf5pEanLiVaB5/XaPQ8ppGc5U8SPAbZJkuQ/Ip/lkAZ80oArvnAi85
	 wjzhBsJsx6tj7mBAZg+G916E35nOcI4gIQk3zx7cWwXGVtI1sWv/58AjErMcnQllM5
	 mwpjN9sAQ1T1zw99uj9ghmnSexYZJaYwEc09fREM4lt7oQxPC4Biy0j7vo/YsGo6Rr
	 EPCngqxqLgIvGtBknNDm/8M1oe2EHA3xZH7ibYFx+VGKF0wF3CUh01pNQvaAzbHcvm
	 yXBVpJPFV95lXEDwVgSonzix0WO7bSymLCkPew7XbDMbaddHHCqupHWWsjRro22/oQ
	 IPJYbyMaFKLGg==
Date: Wed, 1 Oct 2025 04:18:30 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>, Mike Rapoport <rppt@kernel.org>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce movable pages for Hyper-V guests
Message-ID: <aNyrlijDzaosdWxa@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <0ef4d844-a0af-9fa6-2163-b83f80bc74b1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef4d844-a0af-9fa6-2163-b83f80bc74b1@linux.microsoft.com>

+Mike Rapoport, our resident memory management expert.

On Fri, Sep 26, 2025 at 07:02:02PM -0700, Mukesh R wrote:
> On 9/24/25 14:30, Stanislav Kinsburskii wrote:
> >>From the start, the root-partition driver allocates, pins, and maps all
> > guest memory into the hypervisor at guest creation. This is simple: Linux
> > cannot move the pages, so the guest?s view in Linux and in Microsoft
> > Hypervisor never diverges.
> > 
> > However, this approach has major drawbacks:
> > - NUMA: affinity can?t be changed at runtime, so you can?t migrate guest memory closer to the CPUs running it ? performance hit.
> > - Memory management: unused guest memory can?t be swapped out, compacted, or merged.
> > - Provisioning time: upfront allocation/pinning slows guest create/destroy.
> > - Overcommit: no memory overcommit on hosts with pinned-guest memory.
> > 
> > This series adds movable memory pages for Hyper-V child partitions. Guest
> > pages are no longer allocated upfront; they?re allocated and mapped into
> > the hypervisor on demand (i.e., when the guest touches a GFN that isn?t yet
> > backed by a host PFN).
> > When a page is moved, Linux no longer holds it and it is unmapped from the hypervisor.
> > As a result, Hyper-V guests behave like regular Linux processes, enabling standard Linux memory features to apply to guests.
> > 
> > Exceptions (still pinned):
> >   1. Encrypted guests (explicit).
> >   2 Guests with passthrough devices (implicitly pinned by the VFIO framework).
> 
> 
> As I had commented internally, I am not fully comfortable about the
> approach here, specially around use of HMM, and the correctness of
> locking for shared memory regions, but my knowledge is from 4.15 and
> maybe outdated, and don't have time right now. So I won't object to it
> if other hard core mmu developers think there are no issues.
> 

Mike, I seem to remember you had a discussion with Stanislav about this?
Can you confirm that this is a reasonable approach?

Better yet, if you have time to review the code, that would be great.
Note that there is a v2 on linux-hyperv.  But I would like to close
Mukesh's question first.

Thanks,
Wei

> However, we won't be using this for minkernel, so would like a driver
> boot option to disable it upon boot that we can just set in minkernel
> init path. This option can also be used to disable it if problems are
> observed on the field. Minkernel design is still being worked on, so I
> cannot provide much details on it yet.
> 
> Thanks,
> -Mukesh
> 
> 
> > ---
> > 
> > Stanislav Kinsburskii (3):
> >       Drivers: hv: Rename a few memory region related functions for clarity
> >       Drivers: hv: Centralize guest memory region destruction in helper
> >       Drivers: hv: Add support for movable memory regions
> > 
> > 
> >  drivers/hv/Kconfig          |    1 
> >  drivers/hv/mshv_root.h      |    8 +
> >  drivers/hv/mshv_root_main.c |  448 +++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 397 insertions(+), 60 deletions(-)
> > 
> 

