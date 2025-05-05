Return-Path: <linux-hyperv+bounces-5348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A72AA9B25
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 20:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC17B3A591B
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F126B956;
	Mon,  5 May 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g64+Z5rx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0C2580F1;
	Mon,  5 May 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468090; cv=none; b=foLqJ3V6ZOTGfE1nixygKrxxIW6pMqa9ty4w4lnQIMiMtNWJIPdTdTZRtq6gM/rtWJc3Gfaw/m8nR1VzqyuHSLrNC7xxfkwhyycwnKnVUR+wkk+HXYCsgCs/YEzCoBAsNQQ+/fLdHQ9ahKG1eXkOfec+bmakxbLapiOLxGCbjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468090; c=relaxed/simple;
	bh=3MDlRXQE9cdOsif4zioLiCuqYDFy6zBFGDLRzxGLLCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ5dP322kO4fJk1/eXkYO0snm+KZIwIDoqg1yrn4l034po6bsKG9xcCTzqO358UX5/qPqq4S1t9V9bR0Sv/DSoh2XpU38el/TsDsKLqGv4X7+hu8e6htxmWl4N4GFz2B1fqUMA38iN5geDWtFcnezNnsZCNZy37GV6g/Um0AoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g64+Z5rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C187CC4CEE4;
	Mon,  5 May 2025 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746468089;
	bh=3MDlRXQE9cdOsif4zioLiCuqYDFy6zBFGDLRzxGLLCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g64+Z5rx2YDTX/WfqHAUNh1Ms5hXAFmr7zL1TXlg8BLeOPD+mFNU2rou1i+w9jyau
	 SZdBKlIaQ+bGais7za/Nzklb4AldtkLbgVewpEVTsVzXGhsbzF+cYLN3RJreRTBDv9
	 hdS1NptRDyj/0FYoXfTUwI8XoNugoSfiqHR4Zip68SHGFEAp14L5/P+LY6r/0lLJlf
	 Us2E/uFJuiNgroXBIYFR9i8KvlC6pPv8KQkeAl+A9OryRMbvcdLM5PzOlpeYFrdN+V
	 k9jHuw288SH/OmDkD/QPSmMxkfpws0GuLYPk81HkE90wfKqC77bO/xoACpk2SxsSyG
	 6/8eQ9RulIZkw==
Date: Mon, 5 May 2025 18:01:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, ardb@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	dimitri.sivanich@hpe.com, haiyangz@microsoft.com, hpa@zytor.com,
	imran.f.khan@oracle.com, jacob.jun.pan@linux.intel.com,
	jgross@suse.com, justin.ernst@hpe.com, kprateek.nayak@amd.com,
	kyle.meyer@hpe.com, kys@microsoft.com, lenb@kernel.org,
	mingo@redhat.com, nikunj@amd.com, papaluri@amd.com,
	perry.yuan@amd.com, peterz@infradead.org, rafael@kernel.org,
	russ.anderson@hpe.com, steve.wahl@hpe.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, tim.c.chen@linux.intel.com,
	tony.luck@intel.com, xin@zytor.com, yuehaibing@huawei.com,
	linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Message-ID: <aBj895aOnhgsIiwO@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
 <aBUByjvfjLsPU_5f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <41778d44-19dc-4212-a981-d5a82eaf9577@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41778d44-19dc-4212-a981-d5a82eaf9577@linux.microsoft.com>

On Mon, May 05, 2025 at 10:22:47AM -0700, Roman Kisel wrote:
> 
> 
> On 5/2/2025 10:32 AM, Wei Liu wrote:
> > On Wed, Apr 30, 2025 at 01:47:20PM -0700, Roman Kisel wrote:
> 
> [...]
> 
> > >   arch/x86/coco/sev/core.c           | 13 ++-----------
> > >   arch/x86/hyperv/hv_vtl.c           | 12 ++----------
> > >   arch/x86/hyperv/ivm.c              |  2 +-
> > >   arch/x86/include/asm/apic.h        |  8 ++++----
> > >   arch/x86/include/asm/mshyperv.h    |  5 +++--
> > >   arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
> > >   arch/x86/kernel/apic/apic_noop.c   |  8 +++++++-
> > >   arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
> > >   arch/x86/kernel/smpboot.c          | 10 +++++-----
> > 
> > Since this is tagged as a hyperv-next patch, I'm happy to pick this up.
> > 
> 
> Thank you very much, Wei!
> 
> > Some changes should be acked by x86 maintainers.
> 
> Tom and Thomas reviewed the patch, and the `scripts/get_maintainer.pl`
> prints them as x86 maintainers. If I understand correctly what you're
> saying, someone who sends patches from the x86 tree to Linus should add
> Acked-by to the patch. Likely I should just wait until such person gets
> to this patch.
> 
> If I'm misunderstanding, I'd appreciate a quick note to help me navigate
> this :)
> 

$ ./scripts/get_maintainer.pl -f arch/x86/kernel
Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),commit_signer:89/608=15%)
Ingo Molnar <mingo@redhat.com> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),commit_signer:180/608=30%)
Borislav Petkov <bp@alien8.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),commit_signer:245/608=40%)
Dave Hansen <dave.hansen@linux.intel.com> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),commit_signer:70/608=12%)
x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
"H. Peter Anvin" <hpa@zytor.com> (reviewer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Reinette Chatre <reinette.chatre@intel.com> (commit_signer:65/608=11%)
Tony Luck <tony.luck@intel.com> (authored:31/608=5%)
James Morse <james.morse@arm.com> (authored:31/608=5%)
linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))

I'm looking for acks / reviews from Thomas, Ingo, Borislav, or Dave.

If Thomas had given an ack or a review before, you should've added that
to the patch here.

You don't need to do that for this patch. Please point me to Thomas'
reply to the previous version and I can add the missing tag to patch
while I queue it.

Thanks,
Wei.

