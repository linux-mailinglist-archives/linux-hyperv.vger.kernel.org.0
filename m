Return-Path: <linux-hyperv+bounces-2255-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD38D3A7B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB431F26702
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20E181B83;
	Wed, 29 May 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PdGuX3Gd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB01802BB;
	Wed, 29 May 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995775; cv=none; b=EqPbeSgzjOkfI60dD+h22TYjsKasJ1pm4q8coNpVuSoYXMuzttzviRiIdWT3CsrplU5WpxXiY1vTUrO2WUPC8IhcJ4TUOnh1AStIupYuotKS/oVggjO1kQdi8G8/sfaC7hDn1YK/v0g/uyhjpkVNc2FtyWqgs7w5h3fqSHTpBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995775; c=relaxed/simple;
	bh=WtwgqPxIEy4rw+nholzssSrglNHugW0jbWtwXs+eqEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7WGhIGbHj+GUhHqKw1aYQXKcLtx3KDv5YL6JZia++3rf93Yc2pp4J+81XkHqatGO+k+jJ1jDIyYHaGMAka65w45uCoB5YULu9lSvTld3mNafxXqAbcPA3FszzCRfRMTwvF35dTGs8L/QhpY8tUZRVevVK/sWaxiGLeHU/xQt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PdGuX3Gd reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 38D7840E01A3;
	Wed, 29 May 2024 15:16:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NoOJQ2BFJLv9; Wed, 29 May 2024 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716995765; bh=JxEAHhbyQDE99cyLseBirGgp8UILWOP5Nko9ahp4ykk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdGuX3GdGiTa0UBwqDbqBBMWaahwz8CoKM8nSbk04nqa1vJJRShBdhSaMbJOBrOMS
	 Q2dU9SKv0i+u0By+NNXxoInoL89E8cB/UwRvQmEsbp0t9yeuptVk2+nMPiTa4YcVLS
	 CjhmDbntRtHeUoH0J/C5Payhj7MEEFDjwF6IvqT1PLULC38ho+iNxbpNPNVzkewdAn
	 psgdhkReuIkiERedkFSLAyGesfzLJ8F26P1AG+zP8BK+UOya9928tQ3UfRu8SjKw2V
	 P7sZOzs1ZlQk+rskHq2y7cEwA5kKlcGSFbIjdLoQXts0wDcNuVsJQm0tN1/dwbdkTe
	 yT8o9AeEw3ief09u3TvxcCEqgfh3D3iiUvUxBHDT+gHUolf0IK7jHToeQCiYz4mE57
	 DXSXJ6LCXNKvr16AW64LSuVZq1PUZLtjsPuJwLw3zb7H7wpkMI2K2/9zQwQEWDdQ0I
	 X0hCShNDcG3nur10QB3v3pIOER7veBEKaDBy1oOm8MK81qL16xr6HE20KLek5ES3DK
	 j2MCIyPKND/pZaSW2T8qfpkFydT2gl/95e+3hc9ThfFPyn0o3J4rbrit+6qSygYqb+
	 rkF9qhe71TCRmtWM4+jNZI1JKSQoJomFiEC6sNSBg4aDPLoLZivG2TqZWEsf0SxkKc
	 HvWFFqhKGF+2G/5xqStlY82I=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73B3740E0177;
	Wed, 29 May 2024 15:15:37 +0000 (UTC)
Date: Wed, 29 May 2024 17:15:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <20240529151531.GDZldGk5cBbyPrOBRP@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
 <55bc0649-c017-49ab-905d-212f140a403f@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55bc0649-c017-49ab-905d-212f140a403f@citrix.com>
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 01:33:35PM +0100, Andrew Cooper wrote:
> Seems I've gained a reputation...

Yes you have. You have this weird interest in very deep uarch details
that I can't share. Not at that detail. :-P

> jmp 1f dates back to ye olde 8086, which started the whole trend of the
> instruction pointer just being a figment of the ISA's imagination[1].
>=20
> Hardware maintains the pointer to the next byte to fetch (the prefetch
> queue was up to 6 bytes), and there was a micro-op to subtract the
> current length of the prefetch queue from the accumulator.
>=20
> In those days, the prefetch queue was not coherent with main memory, an=
d
> jumps (being a discontinuity in the instruction stream) simply flushed
> the prefetch queue.
>=20
> This was necessary after modifying executable code, because otherwise
> you could end up executing stale bytes from the prefetch queue and then
> non-stale bytes thereafter.=C2=A0 (Otherwise known as the way to distin=
guish
> the 8086 from the 8088 because the latter only had a 4 byte prefetch qu=
eue.)

Thanks - that certainly wakes up a long-asleep neuron in the back of my
mind...

> Anyway.=C2=A0 It's how you used to spell "serialising operation" before=
 that
> term ever entered the architecture.=C2=A0 Linux still supports CPUs pri=
or to
> the Pentium, so still needs to care about prefetch queues in the 486.
>=20
> However, this example appears to be in 64bit code and following a write
> to CR4 which will be fully serialising, so it's probably copy&paste fro=
m
> 32bit code where it would be necessary in principle.

Yap, fully agreed. We could try to remove it and see what complains.

Nikolay, wanna do a patch which properly explains the situation?

> https://www.righto.com/2023/01/inside-8086-processors-instruction.html#=
fn:pc
>=20
> In fact, anyone who hasn't should read the entire series on the 8086,
> https://www.righto.com/p/index.html

Oh yeah, already bookmarked.

Thanks Andy!

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

