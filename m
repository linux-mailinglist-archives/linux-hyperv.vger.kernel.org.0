Return-Path: <linux-hyperv+bounces-7030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D5BAEB64
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Oct 2025 00:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB519272BC
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACF1EC018;
	Tue, 30 Sep 2025 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6knKIma"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3092110E;
	Tue, 30 Sep 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759272509; cv=none; b=OO3Hl7LKsdU7PT+Vr4PzJmDdIfHhrCWb5imVCry/Pji4+N//1TN24Yuroj1smVti4i35wv1c5QvJmngtboRTMCakjvaBwtZv7sm5t5swwo0oYr/gJyVl5gUyN+hUR0sFnEGmF+sJabyrIeemhEnrj3TYq7tN/EK+H4UkALUwbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759272509; c=relaxed/simple;
	bh=MUg9eJm8Qj5U08RO8QZ4V77rjK9viGHDBOarlVK4FSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd02UazK3T9On6Kb7cVWJ8K/+2XGFCMPu/DYHA6GKp1o9CzAzbw4n0jQHNHyTylavXZSjpl0CpbqsY+ZsLLmScGWa4YJsmEceSoYiZIrE4McePXJQ1c22LH503m/uXpXdLkFhAeJEBRGMiFCoWihzekju1xe6UdZqS6PmXQADHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6knKIma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822E2C4CEF0;
	Tue, 30 Sep 2025 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759272508;
	bh=MUg9eJm8Qj5U08RO8QZ4V77rjK9viGHDBOarlVK4FSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6knKIma0L0DFc71cojfuzNX93QWHzgPey9HbXrOm+Ck4MwX/yVO4hs36grs6H8+R
	 BDK1FFlR9bGklz3V48nFbwdsQIpWVrmSVA3rrtwDFjK+Sl0M5O62tnpKgnZP2BQ5z2
	 vljAgbRH0NdjHasgTSw9rd4gRXFbpZOYEb3B7lp03cM5cKdtM+kaErY3v2IvM8hZji
	 x2WpoRU5HkqpW54Zx4vF44v0kUZqbpSzRpJxebGp0XSrj1rze0UKfnPmK/TOlTxlUg
	 b8qfBZZ11rzmARVEERLPrk93hbQl87iOilbsx/GA/EPRTLWZZMPf3sRVA+sGo6QJbl
	 13g2uhXhNw4vQ==
Date: Tue, 30 Sep 2025 22:48:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>, Li Tian <litian@redhat.com>,
	Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
Message-ID: <aNxeO8wfvY6MvOos@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250828091618.884950-1-vkuznets@redhat.com>
 <aLoeQXAo5PMDA5hn@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <87frd1figp.fsf@redhat.com>
 <SN6PR02MB4157B42CCDC571AA07A34E82D403A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157B42CCDC571AA07A34E82D403A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Sep 05, 2025 at 03:57:03PM +0000, Michael Kelley wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, September 5, 2025 12:48 AM
> > 
> > Wei Liu <wei.liu@kernel.org> writes:
> > 
> > > On Thu, Aug 28, 2025 at 12:16:18PM +0300, Vitaly Kuznetsov wrote:
> > >> Azure CVM instance types featuring a paravisor hang upon kdump. The
> > >> investigation shows that makedumpfile causes a hang when it steps on a page
> > >> which was previously share with the host
> > >> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
> > >> knowledge of these 'special' regions (which are Vmbus connection pages,
> > >> GPADL buffers, ...). There are several ways to approach the issue:
> > >> - Convey the knowledge about these regions to the new kernel somehow.
> > >> - Unshare these regions before accessing in the new kernel (it is unclear
> > >> if there's a way to query the status for a given GPA range).
> > >> - Unshare these regions before jumping to the new kernel (which this patch
> > >> implements).
> > >>
> > >> To make the procedure as robust as possible, store PFN ranges of shared
> > >> regions in a linked list instead of storing GVAs and re-using
> > >> hv_vtom_set_host_visibility(). This also allows to avoid memory allocation
> > >> on the kdump/kexec path.
> > >>
> > >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > >
> > > No fixes tag for this one?
> > >
> > 
> > Personally, I don't see this as a 'bug', it's rather a missing
> > feature. In theory, we can add something like
> > 
> > Fixes: 810a52126502 ("x86/hyperv: Add new hvcall guest address host visibility
> > support")
> > 
> > but I'm on the fence whether this is accurate or not.
> > 
> > > Should it be marked as a stable backport?
> > 
> > I think it may make sense even without an explicit 'Fixes:': kdump is the
> > user's last resort when it comes to kernel crashes and doubly so on
> > CVMs. Pure kexec may also come handy.
> > 
> 
> I agree -- think of this as adding a feature instead of fixing a bug. Prior
> to now, there hasn't been any attempt to make kexec/kdump work
> for Azure CVMs.
> 
> Instead of using the word "Fix", maybe the patch "Subject:" should be
> changed to "x86/hyperv: Add kexec/kdump support on Azure CVMs".

I have fixed that in the hyperv-next tree. Thanks for the discussion.

Wei

> 
> Michael

