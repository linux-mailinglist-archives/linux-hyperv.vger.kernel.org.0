Return-Path: <linux-hyperv+bounces-2052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA38B5C01
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C187286FBF
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496A7FBD3;
	Mon, 29 Apr 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZORcMHjz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4F7641B;
	Mon, 29 Apr 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402469; cv=none; b=uVG0JQ2aeArBvxGwHylCGMrNfEmudW7rWjS80WbDLsLVbc0s3KDzFeG5Y4c2ggZSnxkSpqIxAJPoXzYzLqZBJ/0hpeIKULL7OcX0a2jv6DDgsOgrabj6ciQdHObgK1/9hnWOIR8tHAvKZ7XfenArHXT+1m7U+nJ0uc5PUZjeB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402469; c=relaxed/simple;
	bh=d0oc8G80VdSpAwcd1EQtmBVCJEcmiX7YwVY7qsonknc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8MoUqZSc2JaLZhJ3k6VZSIL7WP/4ehg9OBa7gSvIr4/7sfrpl+Ww+Sf5l57NxYmJWP0HTy6t4RtQeKcspnZXMb2RCEwjn8iE/BwabC87dz7aIVgS7nBab2dLs34tMszBQaSlzjJ9ioDLJpXdqdZ5cj826y8k3MfU+QPra1P2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZORcMHjz reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B335D40E016B;
	Mon, 29 Apr 2024 14:54:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3XVfKGstbIKd; Mon, 29 Apr 2024 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714402459; bh=/OGKprZdYSootanFbGT+iAmhKwb8pptaRzuZ0S3c60k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZORcMHjzGCl+zJPL/bWqyORvPswFKKMXZ4Qkxok344k6zGoSeJ/TuomgqjSut4YJI
	 DIEyj9pDjnCXYyAAlMFzaJzF6oHVB1FgzjltTOelnOKErr1lhmPIX3RPq+HDmrz92C
	 bsx6t5hBSDFgHwTp+IOgocsFKkjI81tMH7O0i8i05r7Y9hNZ41kWht7dH5v44RTTLD
	 yLTPPKCR0U3YyB7t2L+UJEzyQ1Sv3KT3h68oFbK1nY55c68Rsv7YH9Nsg8U6QkTyw1
	 Hifqk+Duo66bpVmksfda6WkGhnXW5ZADpc2GiKXcANcig6ywCwGyosZyzCfkofu+KE
	 Fb/Qqq4UuwJLGzc7WhfUnKIJwYOXflUTfINnX1xvYDIt/6z9V3s4LXMassdmY2NjcK
	 ovMt0ygI/bLDesptnxCgsQE7p5zxprV8u7PllMqCK0mV/jTNoJB9esy3TDmBuh+isM
	 sg7pXPEX8WUZBkgfEi6iAjR75YDXHOyru1SUNTZCRCI7gEksg5QmCFkzCaLTz8i5WS
	 DU0c5Re8AhkI7qrte+Ai8CHrbXNxiv60WKxfsbivbH4v9KFzq57xIt7C36+o9sk6i+
	 gDBsb5FeZZhxWbHBmeASqC1QfttFXH08TxxAKehBf7xV5yqRdWYm8rqAImQdGRrXMK
	 g2HO5+ta+4tre3sRqqsGiQtg=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D13D40E00B2;
	Mon, 29 Apr 2024 14:53:52 +0000 (UTC)
Date: Mon, 29 Apr 2024 16:53:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Tao Liu <ltao@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCHv10 06/18] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Message-ID: <20240429145351.GIZi-0fzy7H_UpEJ5w@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
 <20240428172557.GLZi6GpTaSBj-DphCL@fat_crate.local>
 <xoksw5s5tl6wso4xirh4u422xmera4pyulptfmn3zeqtp5lmt2@d3y6ucap37da>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xoksw5s5tl6wso4xirh4u422xmera4pyulptfmn3zeqtp5lmt2@d3y6ucap37da>
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 05:29:23PM +0300, Kirill A. Shutemov wrote:
> Hm. I considered the sentence to be in imperative mood already. I guess=
 I
> don't fully understand what imperative mood is. Will fix.

This:

https://en.wikipedia.org/wiki/Imperative_mood

but basically the sentence is a command.

> You are right, I didn't run get_maintainer.pl this time. I never got it
> integrated properly into my workflow. How do you use it? Is it part of
> 'git send-email' hooks or do you do it manually somehow.

So what I do after the whole set is applied, is:

git diff HEAD~<NUM>.. | ./scripts/get_maintainer.pl

where <NUM> is the number of patches which belong to the series.

IOW, you get a full diff of the set and you run that diff through
get_maintainer.pl.

It'll give you a whole lot of people but you can go through that list
and prune it to the people who are really relevant for the set.

And then you do

git send-email --cc-cmd=3Dcccmd.sh ...

and that script simply echoes a "Cc: <name>" one per line. That is, if
there are a lot of people to Cc. If there are only 1-3ish or so, you can
supply each with the "--cc" option to git-send-email.

Anyway, this is what I do. Someone has probably a lot better flow tho.

> I don't feel I can trust the script to do The Right Thing=E2=84=A2 all =
the time
> to put into my hooks. I expect it to blow up on tree-wide patches for
> instance.

Yeah, not even going there. :-)

HTH.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

