Return-Path: <linux-hyperv+bounces-1156-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2047FEA01
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 08:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC91C208C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97D1F93C;
	Thu, 30 Nov 2023 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NUrLj9xK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082BB10E4;
	Wed, 29 Nov 2023 23:56:35 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9498B40E01AD;
	Thu, 30 Nov 2023 07:56:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CqZrUbaGhUPy; Thu, 30 Nov 2023 07:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1701330989; bh=pty/QeuGUmpYXInNRrtIMj4sinYv5Ho0tbtAiY+I4nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUrLj9xKcbFRU3Z/9polkEDy5s9n7rXwYOmomhXvHmjja9dl0kzWpDhKnNQ4tJjBb
	 S1icYjQ88y7PX6mOzMEG8i0AGKUqe1Z6nuz0BcKWAf3ULjcGayobHoUfxAFT6SrZfm
	 aoZnmaoWe82KA22gBfJEfOq3YC7p+CmdJ/4YCuci2TI2TngGin8wI/EyHVE/ocbutt
	 nxhxhBeNpifUM2xZ4mLHWQiFbvtw6sM66hm9bACOBmqXddwaZOJ9bo8AF94mZtOxkx
	 vPKrzE7iD+X4mk3AO1pxInmnj8CJ9faAigehTqYt31dUFh1dUMBaTk6H3g1hH5mqMH
	 bl8CD7vI3gcrjpu4KO4wPKzGu6+fh4duacgliwp3mwjDi9d89DmvjXJAVRiLLAhYWz
	 Ml0xglzJyo7L1TPqORPplHBtCnTA6jkMBz9mA9OJAWbI+rLGKm605V+E4hGqmN1YGC
	 ZC/AWbSgwL4EfTt4KNtSyPe9RBXa8UYGt03LyW6kk7iuJ6/++NW1b+pprjTvyfFDHz
	 cGzPIyRNNrZ888plGz66YVDPs1+J+k/AuYfpQorua5kZ3fZTnrbuT4DNaXLjTMg2jR
	 ZH+6Hzzo1noZgtbjS1zZShDZA0Vv6YjaYpMbhMLZ6cKPH4n/n4GDctpEOoar97S7v6
	 Os3Q3LyAF6kdVG39hG73YSYY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA13240E025A;
	Thu, 30 Nov 2023 07:56:04 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:55:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"cascardo@canonical.com" <cascardo@canonical.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"Cui, Dexuan" <decui@microsoft.com>
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Message-ID: <20231130075559.GAZWhAD5ScHoxbbTxL@fat_crate.local>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
 <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 07:08:00AM +0000, Reshetova, Elena wrote:
> ...
> 3. Normal TDX 1.0 guest that is unaware that it runs in partitioned
>    environment
> 4. and so on

There's a reason I call it a virt zoo.

> I don=E2=80=99t know if AMD architecture would support all this spectru=
m of
> the guests through.

I hear threats...

> Instead we should have a flexible way for the L2 guest to discover
> the virt environment it runs in (as modelled by L1 VMM) and the
> baseline should not to assume it is a TDX or SEV guest, but assume
> this is some special virt guest (or legacy guest, whatever approach
> is cleaner) and expose additional interfaces to it.

You can do flexible all you want but all that guest zoo is using the
kernel. The same code base which boots on gazillion incarnations of real
hardware. And we have trouble keeping that code base clean already.

Now, all those weird guests come along, they're more or less
"compatible" but not fully. So they have to do an exception here,
disable some feature there which they don't want/support/cannot/bla. Or
they use a paravisor which does *some* of the work for them so that
needs to be accomodated too.

And so they start sprinkling around all those "differences" around the
kernel. And turn it into an unmaintainable mess. We've been here before
- last time it was called "if (XEN)"... and we're already getting there
again only with two L1 encrypted guests technologies. I'm currently
working on trimming down some of the SEV mess we've already added...

So - and I've said this a bunch of times already - whatever guest type
it is, its interaction with the main kernel better be properly designed
and abstracted away so that it doesn't turn into a mess.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

