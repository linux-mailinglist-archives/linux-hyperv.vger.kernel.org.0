Return-Path: <linux-hyperv+bounces-3598-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95475A04A07
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 20:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674D6164701
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 19:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79081F63C3;
	Tue,  7 Jan 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MDu+8J3Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED911F4E22;
	Tue,  7 Jan 2025 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277532; cv=none; b=uTkYkeeWOrfnDoDG5anLYjyxlx16Fzet5t8B+MelucAhpGSmxBOQ80LnT3bIu9S8tU/Gii6Nao4EMME1EqeHVmknfKuUdiJruNOu94lYt7DVJgzGJQvwYnc/OWP0Yz5QzPCTAdPDjhBc2nIR9PYM2Z5WSLzLJq196DboGY8vooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277532; c=relaxed/simple;
	bh=v7CvZmMCauimiMpXl8N9ZLlRUfCB7gqIlFSKBye4F5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMkEwjpzOHiiTMF5RFXfaV13lORNCmnOtiONCl9r63nj7L8ac9HpNIIwV16qyKChx22SZe9fCjYm8rMaDEFUTBzrmhCpk4PKm6jSeHGTWZGPpPfLy/Hmsx11wcS9oo7RADAH6QVtTcHEciwy5T65JGOGeF0WV1/dYXl3CsyOo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MDu+8J3Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [131.107.8.86])
	by linux.microsoft.com (Postfix) with ESMTPSA id 752D8206ADF6;
	Tue,  7 Jan 2025 11:18:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 752D8206ADF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736277530;
	bh=6Pw8ZwGD93e4qMhOSxZRICPJj8I+UzQ5WAoQSrj7mHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDu+8J3YWOLEcxt0M4H57lRt4DmdQuleLG1x6wiRlPtVUeLb08zY4FZEhYZ3t40aI
	 aYFTYHKhL22Ca5I7AtuVCagEI2sa8wPnLwZ3A0kHClHBaebEsyIMpCYCzNj9ViEojl
	 ruivb1v0/JtaFE2hPftSgbOLnq+5WQe+reAq3GqA=
Date: Tue, 7 Jan 2025 11:18:48 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Message-ID: <20250107191848.GA24369@skinsburskii.>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
 <20250106171114.GA18270@skinsburskii.>
 <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>
 <20250106193248.GB18346@skinsburskii.>
 <3c90bc0f-be28-4f10-8057-be5e780c5a24@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c90bc0f-be28-4f10-8057-be5e780c5a24@linux.microsoft.com>

On Mon, Jan 06, 2025 at 01:07:25PM -0800, Roman Kisel wrote:
> 
> 
> On 1/6/2025 11:32 AM, Stanislav Kinsburskii wrote:
> > On Mon, Jan 06, 2025 at 10:11:16AM -0800, Roman Kisel wrote:
> [...]s
> 
> > From my POV a decision between a unified approach and interim solutions
> > in upstream should usually be resolved in favor of the former.
> > Given there are different stake holders in VTL code integration, I'd
> > suggest we step back a bit and think about how to proceed with the
> > overall design.
> I don't see any compelling reason for stalling this fix and think for
> no one knows how long. What is going to be fixed is clear, and it has
> not been demonstrated what is going to be broken when this change is
> merged.
> 
> > 
> > In my opinion, although I undestand why Underhill project decided to
> > come up with the original VTL kernels separation during build time, it's
> > time to reconsider this approach and to come up with a more generic
> > design, supporting booting the same kernel in different VTLs.
> "The same kernel" means supporting ACPI/UEFI for VTL0, VTL1, VTL2 as
> otherwise VTL0 won't boot. But why would VTL>0 even consider relying on
> ACPI or compiling it in? I would fix your broad assertion with adding
> one constraint: share as much Hyper-V code as possible, booting is not
> expected, rather refuse building.
> 
> > 
> > The major reason for this is that LVBS project relies on binary
> > compatibility of the kernels running in different VTLs.
> > The simplest way to provide such a guarantee in both development and
> > deployment is to run the same kernel in both VTLs.
> 
> OpenHCL aka Underhill is the only shipping product relying on
> the code in question (others might be dom0 and LVBS). What the LVBS
> project relies on might change any number of times any day before it
> ships. OpenHCL works for customers and slicing and dicing it ought to
> be well thought through.
> 
> > Not having this ability will require carefull crafting of both the
> > kernels upon build, making kexec servicing of such kernels in production
> > complicated and error prone.
> 
> Too vague, imho. I'd respond that "careful crafting" shouldn't lead to
> being complicated and error prone as long as it's automatic and, well,
> careful.
> 
> It is harder and harder to me to see how enabling the hypercall output
> page is related to where the discussion has drifted. My claims are:
> 
> * enabling the hypercall output page poses no harm (doesn't break hyper-
> next),
> * allows to bring the code to the clear and concise form of getting a VP
> register.
> 
> Can you refute any of that?
> 

My point is that the proposed fix looks more like an Underhill-tailored
bandage and doesn't take the needs of other stake holders into
consideration.

What is the urgency in merging of this particular change?

Thanks,
Stas

