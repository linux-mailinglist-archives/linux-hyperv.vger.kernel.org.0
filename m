Return-Path: <linux-hyperv+bounces-7788-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C1C80CFC
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 14:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2713B4E197B
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A8307AC0;
	Mon, 24 Nov 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ifXA1bY3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00244306D5E;
	Mon, 24 Nov 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991572; cv=none; b=M/ZSYsA+99U7SpIw8l1WXakiu/6ML5Y+mpDwnMQn/CdwtK0qmurqUWbNsxR42ySSMMiCd6PfJlYR/kMEPdEGZKBpVrCQ82UBotmRcqspo2sRbuWGq1iXLOivrXwaAHeD49BJFb4+l7Ofey2Cw2NzufQiE0gwWouAlhET792emJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991572; c=relaxed/simple;
	bh=UWohL7EuY2gQ//kBRbT7Z0ufXg3Oaz+dCgIlTlPdQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etkjK/Ktj1QW8KJE6Cbccf74/zTLxbtagOEQ9i2YTMLGAI8Xd1Fy6OWQYnrfQtE+OX16dYjTDSMkEySB5/aNIqNBu3PJPxluW8s0qwedgKpGI6sY0FwME74+jEIO7oaHhWxHgLN+L5UE7z38KtERdWAupd33RaoZ06BFWKL5QMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ifXA1bY3 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33F8C40E016C;
	Mon, 24 Nov 2025 13:39:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dUX_2TyVOwvg; Mon, 24 Nov 2025 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763991561; bh=xMHHbvFeagw1OXMRREZidPFJD/S6z/TheDKCK1dG36Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifXA1bY3AIdKdV1RAnJe9hR1HoTJK2HQxoKq4XpkqyoEZF0P+j1J+7ZcN7rBWUDcm
	 oYIJpyHEwvEgbBhN4SUbwy9M3rPtz8mZ9KIHA+4XWKlZM9sJg4Netd7by8HO/WfwU+
	 izUQ49pOfE2WCVKQEme59LDaN1qKCPhLWMfPc9dqBXeYjNNbtk4PEeDe4UKe8r3jcX
	 cGgQWdXyE14McksoYKJh8aEd3dTE+0KDYzV2heqjB5matuLT2+0zE2pfxQlwvNiTjo
	 /IEVNfKmQgtVmArwa//GOT0te7zCWkVDbmmzyyFyrHqtrPyJNxOw485KFnaoXcBoHR
	 VXZDdCWu7U72JPGhB3GL4+0WjVSu5w57ooBqcfE6Y0VkGE1VlprxFjxUH5acKEERbH
	 VfQSlXVSFmv6+ISkviWPAt+y481hRdqsTVQxNnzVyAQthZpHMmlvDjFGUeDrY5OeUh
	 xgGDNbXeLdQBp+FbNXuYLrpUp9WEv6YKuJec/ShIgGMUZrIFh/N/cV3lLIrV3Kq7TW
	 2LeL5VLaje2ETKAQfBeqVSK6ALMPmXJr4dKdD/ORNUCXoOtytmAO8sJb2/JPTs9BuI
	 kYDPV8yWq0yD6+ZWREKiz8EOBe8+QAIHM8A+OVhvh+bLylBPTIo1lBQIKyu0MJXEcM
	 vakOICMeaSVGLRtHz7pTfGAY=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4C08F40E015B;
	Mon, 24 Nov 2025 13:38:59 +0000 (UTC)
Date: Mon, 24 Nov 2025 14:38:58 +0100
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
Message-ID: <20251124133858.GFaSRf8rU6w3Tf3wU_@fat_crate.local>
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006074606.1266-2-jgross@suse.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 09:45:46AM +0200, Juergen Gross wrote:
> In some places asm/paravirt.h is included without really being needed.

Except they are:

$ make allnoconfig
$ rebuild-kernel.sh
...

arch/x86/kernel/x86_init.c:90:43: error: =E2=80=98default_banner=E2=80=99=
 undeclared here (not in a function)
   90 |                 .banner                 =3D default_banner,
      |                                           ^~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:287: arch/x86/kernel/x86_init.o] Err=
or 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:556: arch/x86/kernel] Error 2
make[2]: *** [scripts/Makefile.build:556: arch/x86] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/linux/Makefile:2010: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

