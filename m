Return-Path: <linux-hyperv+bounces-7385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC4C2434A
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 10:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 983494F3B90
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D00330329;
	Fri, 31 Oct 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="bJS1iOl+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54F329E61;
	Fri, 31 Oct 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903427; cv=none; b=AKwmC7/M/EhMmqAOOFC8sbvAZdN08c0f1bT1AtVFLX/dB7LvD3dANLCpoW+THnxoF4qKj+qe/C/qMoROZ2Llak+sPXKPoqbLU5UdwhveFURkOChRwmW71Q5mbhYScYxTcBZmjetYR2HcObHnwYWfSgWTlNxQdvQ+z5AT6WiyKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903427; c=relaxed/simple;
	bh=3gr1UG/m17wdgdAI2Acm1hwv9P3oJIgkKfDDH4C8zi8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tN5gpeLzefHn8cDq2CFSUYVQWrz8fvIctCfXGgPEs6RwmA0EcwGbYqiuPBX0AUiSpepMi1HI6myYWkDgr6s9whG6BROtXqrLG34i3NpDxhB3jFUipIdB5zR1XQ+5vSCh4/16h295WQPCftuO636xfQYtriUbvErK4BC4olqEUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=bJS1iOl+; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=STnG01yfLSK1RKYAI3HkwU0KpYP9Y48pUPKUiedUaew=;
  b=bJS1iOl+8AjcQiOuLUC9S3+y1t8CfwNUf+1jAGCiJvBg698OkgkmKZER
   pfCaz3MNj6pR/dY7Rd33vCGL4KpA4YwdvNBE1Hy4fse6O4caKu1FFHHFX
   iKU+uZ6ec1F+G1dM9iHn0J1m8xle/ry0O1DCHsIySVGT43Ld87dmcHMjX
   M=;
X-CSE-ConnectionGUID: vzxMhzRXQHyCwLAC8vT4WQ==
X-CSE-MsgGUID: EYNeUUBUQPSqX0w0c9G0rw==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,269,1754949600"; 
   d="scan'208";a="129563541"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 10:37:01 +0100
Date: Fri, 31 Oct 2025 10:37:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Naman Jain <namjain@linux.microsoft.com>
cc: Markus Elfring <Markus.Elfring@web.de>, linux-hyperv@vger.kernel.org, 
    x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, Long Li <longli@microsoft.com>, 
    Mukesh Rathor <mrathor@linux.microsoft.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
    Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] x86/hyperv: Use pointer from memcpy() call for assignment
 in hv_crash_setup_trampdata()
In-Reply-To: <cea9d987-0231-4131-82ac-9ba8c852f963@linux.microsoft.com>
Message-ID: <193768a-6914-5217-8815-ab1c75f1c8d@inria.fr>
References: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de> <cea9d987-0231-4131-82ac-9ba8c852f963@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 31 Oct 2025, Naman Jain wrote:

>
>
> On 10/31/2025 2:03 PM, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Fri, 31 Oct 2025 09:24:31 +0100
> >
> > A pointer was assigned to a variable. The same pointer was used for
> > the destination parameter of a memcpy() call.
> > This function is documented in the way that the same value is returned.
> > Thus convert two separate statements into a direct variable assignment for
> > the return value from a memory copy action.
> >
> > The source code was transformed by using the Coccinelle software.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >   arch/x86/hyperv/hv_crash.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> > index c0e22921ace1..745d02066308 100644
> > --- a/arch/x86/hyperv/hv_crash.c
> > +++ b/arch/x86/hyperv/hv_crash.c
> > @@ -464,9 +464,7 @@ static int hv_crash_setup_trampdata(u64 trampoline_va)
> >   		return -1;
> >   	}
> >   -	dest = (void *)trampoline_va;
> > -	memcpy(dest, &hv_crash_asm32, size);
> > -
> > +	dest = memcpy((void *)trampoline_va, &hv_crash_asm32, size);
> >   	dest += size;
> >   	dest = (void *)round_up((ulong)dest, 16);
> >   	tramp = (struct hv_crash_tramp_data *)dest;
>
>
> I tried running spatch Coccinelle checks on this file, but could not get it to
> flag this improvement. Do you mind sharing more details on the issue
> reproduction please.
>
> I am OK with this change, though it may cost code readability a little bit.
> But if this is a result of some known standard rule, added as part of these
> Coccinelle rules, we should be good.

Multiple people have suggested that due to the loos of readability the
change is not a good idea.

It's not done by a standard rule.

julia



