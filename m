Return-Path: <linux-hyperv+bounces-7042-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9EFBB143B
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Oct 2025 18:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B2624E00CD
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Oct 2025 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DBB2773F3;
	Wed,  1 Oct 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz31NxiM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0791459FA;
	Wed,  1 Oct 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336763; cv=none; b=OqFRgNwfA8xg/PazB0P6ObZfeizWhGji9t9PCK3UIvI7vzk4Wcdw3OnsAsuFEJ7dJV5nH3qXWIi95qDLVmIwYj7P6IVrsQEmtBWwKwLalrJXlNtiNGDq6S52syG7eTXRzggmafKdgvNWNAqT5Y3uhYmJB06wnDb2oTgNOWgnhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336763; c=relaxed/simple;
	bh=fz4j4Nbyj1yHIo+rIFDNGxwIEr2ZuXwyHfkNKuiTq2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSlD40J2OVuYIjuLklD1GU270ZTf7VftEZ3ivDntXI0lJdCBQiG0H3jY8h6Jrr+8Wi/YYtXmHNPy6doay/Ajmfb2uXj+vns100G7zOdLy7nt1ZSsGIKJrwKzymg8yFtbinotqDDkAGQaKRrLcwEpSbenlUoWnshhlxixWQe9A4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz31NxiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8AFC4CEF1;
	Wed,  1 Oct 2025 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759336762;
	bh=fz4j4Nbyj1yHIo+rIFDNGxwIEr2ZuXwyHfkNKuiTq2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz31NxiM8p6KCikaLC6ioXkj7c8yHu+95XqGkQv5s/J+UWV0mAQs1eSZ++tYG+BLM
	 Forv7BI1KDSmZrf8n7U0QXosIUCmnjqaGREf7G9o1NfhdxV94yEM7rBj3adOwwrgOv
	 tXtqpMaahxqwBfKcFBJuF/jPRKdwTLghJTvTALeUzvR6LlexrVt5Mrl2/6b9slp3d8
	 4FmFn/wiB7eSEtKPs2Ht0OGrVGtuUOYWzJtuiYkFmmdfOn0ElE3FgGWBONjaZpMZ6L
	 ikD2B60EFLQpWXxC03dTL/JviRcsPLvIrkwmc5ne1uo6zWD+N5HnGY2C4gVpzK/jK9
	 d5Vz60OWdOLRA==
Date: Wed, 1 Oct 2025 18:39:16 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: Mukesh R <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce movable pages for Hyper-V guests
Message-ID: <aN1ZNNe66f0SA-Cs@kernel.org>
References: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <0ef4d844-a0af-9fa6-2163-b83f80bc74b1@linux.microsoft.com>
 <aNyrlijDzaosdWxa@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNyrlijDzaosdWxa@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>

On Wed, Oct 01, 2025 at 04:18:30AM +0000, Wei Liu wrote:
> +Mike Rapoport, our resident memory management expert.
> 
> On Fri, Sep 26, 2025 at 07:02:02PM -0700, Mukesh R wrote:
> > On 9/24/25 14:30, Stanislav Kinsburskii wrote:
> > >>From the start, the root-partition driver allocates, pins, and maps all
> > > guest memory into the hypervisor at guest creation. This is simple: Linux
> > > cannot move the pages, so the guest?s view in Linux and in Microsoft
> > > Hypervisor never diverges.
> > > 
> > > However, this approach has major drawbacks:
> > > - NUMA: affinity can?t be changed at runtime, so you can?t migrate guest memory closer to the CPUs running it ? performance hit.
> > > - Memory management: unused guest memory can?t be swapped out, compacted, or merged.
> > > - Provisioning time: upfront allocation/pinning slows guest create/destroy.
> > > - Overcommit: no memory overcommit on hosts with pinned-guest memory.
> > > 
> > > This series adds movable memory pages for Hyper-V child partitions. Guest
> > > pages are no longer allocated upfront; they?re allocated and mapped into
> > > the hypervisor on demand (i.e., when the guest touches a GFN that isn?t yet
> > > backed by a host PFN).
> > > When a page is moved, Linux no longer holds it and it is unmapped from the hypervisor.
> > > As a result, Hyper-V guests behave like regular Linux processes, enabling standard Linux memory features to apply to guests.
> > > 
> > > Exceptions (still pinned):
> > >   1. Encrypted guests (explicit).
> > >   2 Guests with passthrough devices (implicitly pinned by the VFIO framework).
> > 
> > 
> > As I had commented internally, I am not fully comfortable about the
> > approach here, specially around use of HMM, and the correctness of
> > locking for shared memory regions, but my knowledge is from 4.15 and
> > maybe outdated, and don't have time right now. So I won't object to it
> > if other hard core mmu developers think there are no issues.
> > 
> 
> Mike, I seem to remember you had a discussion with Stanislav about this?
> Can you confirm that this is a reasonable approach?
>
> Better yet, if you have time to review the code, that would be great.
> Note that there is a v2 on linux-hyperv.  But I would like to close
> Mukesh's question first.

I only had time to skip through the patches and yes, this is a reasonable
approach. I also confirmed privately with HMM maintainer a while ago that
the use of HMM and MMU notifiers is correct.

I don't know enough about mshv to see if there are corner cases that these
patches don't cover, but conceptually they make memory model follow KVM
best practices.
 
> > However, we won't be using this for minkernel, so would like a driver
> > boot option to disable it upon boot that we can just set in minkernel
> > init path. This option can also be used to disable it if problems are
> > observed on the field. Minkernel design is still being worked on, so I
> > cannot provide much details on it yet.

The usual way we do things in the kernel is to add functionality when it
has users, so a boot option can be added later when minkernel design will
be more mature and ready for upstream.

-- 
Sincerely yours,
Mike.

