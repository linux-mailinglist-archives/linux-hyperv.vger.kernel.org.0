Return-Path: <linux-hyperv+bounces-5863-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1956FAD55F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC50616E79D
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506C28312B;
	Wed, 11 Jun 2025 12:52:40 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC12E611B;
	Wed, 11 Jun 2025 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646360; cv=none; b=j38siWr90ntewciwTiNqKWrB92IuhnrKLNTrBaTt/jE0sFNybqa0yO7Vm8ThsNL5CVa0sXlJEBpe4ctLj2SVPVf8pMRx4W4VNoI6pE3v0vGP3HyrwLtdDCAy//oz2XugL8cQ/NbnPgCK1rCltgfvtWPUD99cjPATJkFCteJNO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646360; c=relaxed/simple;
	bh=8Y8aFpQ7P9CqeElr3wG1ncqhXpdcddPA6PvcJhmS7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbapnJoqaP6B2BE/McFLvnpv3GI1c0fgq9cUXR4erA8EfBRmrsCO7uLWeSyVMtvl4BXS6iOMAy1X7zXRmCrN8OmjbqnB9qgTALL22IXlddBO91x0RIdwlUNryEDyZSW4PNXZVki8JjP63lqnOXak+wY4ST+GPd27XB1e2diyrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA7B415A1;
	Wed, 11 Jun 2025 05:52:16 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F2503F59E;
	Wed, 11 Jun 2025 05:52:34 -0700 (PDT)
Date: Wed, 11 Jun 2025 13:52:32 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: anirudh@anirudhrb.com, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	mark.rutland@arm.com
Subject: Re: [PATCH] firmware: smccc: support both conduits for getting hyp
 UUID
Message-ID: <20250611-wandering-juicy-magpie-ed7f46@sudeepholla>
References: <20250605-kickass-cerulean-honeybee-aa0cba@sudeepholla>
 <20250610160656.11984-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610160656.11984-1-romank@linux.microsoft.com>

On Tue, Jun 10, 2025 at 09:06:48AM -0700, Roman Kisel wrote:
> > (sorry for the delay, found the patch in the spam 🙁)
> 
> "b4" shows the the mail server used for the patch submission
> doesn't pass the DKIM check, so finding the patch in the spam seems
> expected :) Thanks for your help!
> 

Thought so looking at the header but I just have very basic knowledge
there, so couldn't comment.

> >
> > On Wed, May 21, 2025 at 09:40:48AM +0000, Anirudh Rayabharam wrote:
> >> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> >>
> >> When Linux is running as the root partition under Microsoft Hypervisor
> >> (MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.
> >>
> >> Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
> >> arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
> >> of supporting only hvc.
> >>
> >> Boot tested on MSHV guest, MSHV root & KVM guest.
> >>
> >
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Are they any dependent patches or series using this ? Do you plan to
> > route it via KVM tree if there are any dependency. Or else I can push
> > it through (arm-)soc tree. Let me know.
> 
> Anirudh had been OOF for some time and would be for another
> week iiuc so I thought I'd reply.
> 
> The patch this depends on is 13423063c7cb
> ("arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID"),
> and this patch has already been pulled into the Linus'es tree.
> 

Had a quick look at the commit to refresh my memory and as you mentioned
it is new feature. I was checking to see if this is a fix.

> As for routing, (arm-)soc should be good it appears as the change
> is contained within the firmware drivers path. Although I'd trust more to your,
> Arnd's or Wei's opinion than mine!
> 

I will queue this once I start collecting patches for v6.17 in 1/2 weeks'
time, so expect silence until then 😄.

-- 
Regards,
Sudeep

