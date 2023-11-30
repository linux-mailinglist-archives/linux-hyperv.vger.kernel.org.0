Return-Path: <linux-hyperv+bounces-1158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0F77FEBC2
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497DA2820B8
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51436AF5;
	Thu, 30 Nov 2023 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y7vTyJUK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0A9D;
	Thu, 30 Nov 2023 01:21:54 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2243F40E0239;
	Thu, 30 Nov 2023 09:21:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4ubGk9wQ3yGk; Thu, 30 Nov 2023 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1701336108; bh=GBEhqV+mubDB6FPJ/dMhpSO9uCBniobBE/30dBfoP1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7vTyJUKfO/m/6Q05oNE0nB9e+JeuSZtvDdd4VcuQS6H/Dovit7G6zOnY0OAZUuYO
	 AwHaDeBel8ETDgg7GkEjHZHm2z8oFtIrDy4fX6mGCMzPxPLixzAo2VDzeKQrvvGDdZ
	 ujdIiH2ZJ9JAcOOHdrH7MSGf00cBDqAdy9SuyHho3ieqJx4YeW7HmEYtmTSJMVrj9m
	 K4xrUrdS0itJGa+3M7P+LplIYYdJ8m6HcrT4sWEOdVDhm7DQ/K8yojEXFNS1+ga2Gg
	 0QGB5elyo2cl7GuJA1lAUR/BjSSKXYzfGAVARKZVpy7nsRE1aTiWMC1OJH4Hjk5Tso
	 RjpP5SX/03k1s4ugVQHC1w0F8kGSXBVrUmALO2WQtcOWDXoQCIAdQVKYWoY9z8UNvJ
	 gbQkdhpqt1L7NwCLW6PHSNv22ZZpn6d/hgLJtDhcF/7TDXCPKXdeoZI0JoyHC5ZKsg
	 qyPYoYMPrgKFp5Z500gSyfldAiDY1Jjrffk9TLBveLCgXCl0aKtCGkYCsNtQjStGye
	 j9DVPpRk7oMAfkpSTTlpoQI9Z3i3rZBzxrkhGtQ629bfNs48IeoiPyzP+epNJroBGa
	 PY3haMimJnzmwwhByWMLzvGDO+24grp0cmw3cOU5rn+/apnyobYq2VoL6HtG3MQ5Ls
	 Vj3xyTFGSswpzlHhKquVYydo=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0394240E0030;
	Thu, 30 Nov 2023 09:21:23 +0000 (UTC)
Date: Thu, 30 Nov 2023 10:21:19 +0100
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
Message-ID: <20231130092119.GBZWhUD6LscxYOpxNl@fat_crate.local>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
 <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20231130075559.GAZWhAD5ScHoxbbTxL@fat_crate.local>
 <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 08:31:03AM +0000, Reshetova, Elena wrote:
> No threats whatsoever,

I don't mean you - others. :-)

> I just truly don=E2=80=99t know details of SEV architecture on this and=
 how it
> envisioned to operate under this nesting scenario.  I raised this
> point to see if we can build the common understanding on this. My
> personal understanding (please correct me) was that SEV would also
> allow different types of L2 guests, so I think we should be aligning
> on this.

Yes, makes sense. The only L2 thing I've heard of is some Azure setup.

> Yes, agree, so what are our options and overall strategy on this?  We
> can try to push as much as possible complexity into L1 VMM in this
> scenario to keep the guest kernel almost free from these sprinkling
> differences.

I like that angle. :)

> Afterall the L1 VMM can emulate whatever it wants for the guest.
> We can also see if there is a true need to add another virtualization
> abstraction here, i.e. "nested encrypted guest".

Yes, that too. I'm sceptical but there are use cases with that paravisor
thing and being able to run an unmodified guest, i.e., something like
a very old OS which no one develops anymore but customers simply can't
part ways with it for raisins.

> Any other options we should be considering as overall strategy?

The less the kernel knows about guests, the better, I'd say.

The other thing I'm missing most of the time is, people come with those
patches enabling this and that but nowhere does it say: "we would love
to have this because of this great idea we had" or "brings so much more
performance" or "amazing code quality imrpovement" or, or other great
reason.

Rather, it is "yeah, we do this and you should support it". Well, nope.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

