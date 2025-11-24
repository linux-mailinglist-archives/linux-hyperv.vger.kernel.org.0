Return-Path: <linux-hyperv+bounces-7789-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7153AC80FDE
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A4D3A208D
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D9230DEAF;
	Mon, 24 Nov 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PSuvSCTQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651492A1C7;
	Mon, 24 Nov 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994422; cv=none; b=l7fln1wvD/+2vif9k8ysJ++IV3Kf5E5DDquNyB885t83hJHG7Q3+rk2ORk0aiP4QItRiuwk0kAxw+3u6Ndt2EJ475gn1/pQS8xb3gYAdrFtp9+fMPsu/rqzOi9D5dr5jC7i9euYdyGDb7gjC8TsQJwZsY1DSOD/flxSleksx/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994422; c=relaxed/simple;
	bh=4UIPEDUAUfsCUc1xjbcehHrqus8JV1c1pg4GnddHqGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZlljieE2VbBOh+I637+CW5ccULUVOC1/0Za2qpeYhvT4k3p0oRv+4UX5cMoBSss40zJEG6VztdaI8EYIcldE6BzVbcnM9t+EljKJ40ElehiEEs7jo7MHcoadYYMAk8IvCWB6ejh/HgnplL+mak5ZCT441NTu4U8q3wPto6Y1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PSuvSCTQ reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F0B2B40E015B;
	Mon, 24 Nov 2025 14:26:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6hd_SPf9teGA; Mon, 24 Nov 2025 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763994411; bh=K73tGsspNcQNjXp1GDxJaedqiCyrMTjCuAwDj5AV9xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSuvSCTQfki/FSMspTsX0cMA9GJXD7sTek76M8Wwmc3KWHpbfqx0UlPkS4wDDKo3N
	 R627iwOmt/Rq8lnHcBbOup2sF9kyGk/Ft0/Sh/Qes6knQK2EJJDY9flgKZkzH+0WAA
	 o1BTyaYuXffcOHtuFlhtEq+t/nfdgCO323IGpyn4yDsNU8MASjLow4jU9YVvbjq/Qa
	 x3b1t35iN78Od62FRf3PKY7kbNuGVkZU7HINQhBXVnDlDZ3TSKy7l3P/BvX3yDFDh9
	 HzEeFAPhZWk3YTwJbgmz0lyV1OFJox5DVj+uHX274tBrj7HRDDV3LZbXn0H6iUQ0qL
	 I24O1YeKhmcW/pVTn1DTg8KPy5ToVyzf/6FhD8m0DcQ8QRHNYcD1dIKOmKFUiO1wGg
	 Eo+If8ImIJzCrOwQaNulcgK6dYS4/b3FSnrXBOgklacMcQlTdNJ6DvGONFjPaP/71G
	 9s6Wn+RKxqyRlNWwG+qldoaQsNH/RZMxB4xs+KJ2cJ0sqxn2CbIIglgqXLHOu+fLF/
	 wXlUwsTlr6/x6fefNVKq2IeIdXOvfpN3qpo8asYqm9ryZ2jL1LJYTZII/L4y8upkIg
	 Z/YHai85Sp8DD7JdNa55F1/faAJW5EmujlKyyDijIsymtxaexgztuX7WIKQ2cDio5F
	 8XvbZiwJinmT2xvUxk6YpJ3Y=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3E11C40E0219;
	Mon, 24 Nov 2025 14:26:29 +0000 (UTC)
Date: Mon, 24 Nov 2025 15:26:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 01/21] x86/paravirt: Remove not needed includes of
 paravirt.h
Message-ID: <20251124142623.GGaSRrD-N15vnJY0DJ@fat_crate.local>
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-2-jgross@suse.com>
 <20251124133858.GFaSRf8rU6w3Tf3wU_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124133858.GFaSRf8rU6w3Tf3wU_@fat_crate.local>
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 02:38:58PM +0100, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 09:45:46AM +0200, Juergen Gross wrote:
> > In some places asm/paravirt.h is included without really being needed=
.
>=20
> Except they are:
>=20
> $ make allnoconfig
> $ rebuild-kernel.sh
> ...
>=20
> arch/x86/kernel/x86_init.c:90:43: error: =E2=80=98default_banner=E2=80=99=
 undeclared here (not in a function)
>    90 |                 .banner                 =3D default_banner,
>       |                                           ^~~~~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:287: arch/x86/kernel/x86_init.o] E=
rror 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:556: arch/x86/kernel] Error 2
> make[2]: *** [scripts/Makefile.build:556: arch/x86] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/linux/Makefile:2010: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

Before you submit the first 12 next time, please build-test each patch wi=
th:

SMOKE_CONFIGS=3D("allnoconfig" "defconfig" "allmodconfig" "allyesconfig")

and those architectures:

ARCHES=3D('x86_64' 'i386')

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

