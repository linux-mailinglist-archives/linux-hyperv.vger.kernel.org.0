Return-Path: <linux-hyperv+bounces-3563-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128659FE9C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 19:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071087A1B3C
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016FE1ACEC4;
	Mon, 30 Dec 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DQvO2yfd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4611B0F2C;
	Mon, 30 Dec 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582636; cv=none; b=EXJnFh5BSHlSiADhx0rNvfEfdXA61uNAHWhZeoBBjnDIsPg/mRmmXzdz7uim7Tev6GZug5WOJsOwJ/9aIkpr4NmrJY6jZWKCWeiBYEDVVXgBPPRr25cbWQtssuzqTWNAGV1g8+01IhcYA5ZY9qMHb1UZ2L2Ds5ylSAs767pjQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582636; c=relaxed/simple;
	bh=8kF+AI1kwqIhDygiTQEjAzd8vPjhv9kVBITQcgU2Pg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWQ8qkbMhVg6UwuW48Nm7ZGV2ORU+xIrBM1Av/PEXWbdaWVPXg6+cNaDaXuZ55FEe3qsfmU8BSmNAFSYeXKFHkhk06OPYdZSKrzYjNQ3G/CYBwFfos1TeQmrjCL9cFkV1Ikt2K+/sVupcdmoB9hLvut/6IYIIJCteuZQmlg916k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DQvO2yfd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DEAF940E0289;
	Mon, 30 Dec 2024 18:17:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QB5JWtoONOLR; Mon, 30 Dec 2024 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735582627; bh=61zVf3D0dvB6CWLnBwcfVhHxTqTvzy9Ru9CA7mopn1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQvO2yfdLpBCk/0UwWVyBFylQhdVEmcJbT15zNyMKvVz39GR2X3V2mzEijk/pd3ua
	 pOHknotuO7fk8zGgefWOvATK2lImNJm+xtGIO76lRsI8RXEXsbF99FTNfaQOcwwGVc
	 r3IW/hmjc376zGqFx3EcoaBsiBdcXtbVHgzAdNRRBw9ODkHnct/syf/fZE5FZ2n5TT
	 eOKDeLnxzIoTO/HpiBdQfYS0plV2J1RxSQsdIyYPjkbyOjkRsN+ZfGOZD7gaVfYNNw
	 eruX4oLArEhXsawNOXsKyFXswzxcUdINaQzQh5r4uxXe7jbHx+Oou57FDiw2lDmPqw
	 BkpvZZwelsOW6H8Ifb2BZP6whrKB7oBWg0eJNMyE4FpthcVVRk9myZHHh9ikkyUsVF
	 LgL0hlobQdkoD2B4CkOh2YlJGjaRWM3XtB2PGvtKHkyAwYD8eFg2nsKtbjkpufLBv7
	 oXTr1dlP42Lm4CFyJBOU9sLAZuG+a3RyXknB6TeTA6RmMyk2JLPsiXGXMlTM2EbLvM
	 WkUMyoxYMqDS+KBRFcJ/3sy22+1qeBc8n6hSpmboKDNNz1MSwnUoJyLEPDAklTG3p/
	 x0aRCatDHX4Kc0d7zhqynb5QjzFFa+SareCCGTPbNPGl/YRCge9kVTDLpM0D4OD78d
	 OPhF7mneUg4FoRPG2uSsP3fc=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 932E940E0266;
	Mon, 30 Dec 2024 18:16:46 +0000 (UTC)
Date: Mon, 30 Dec 2024 19:16:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, eahariha@linux.microsoft.com,
	haiyangz@microsoft.com, mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
Message-ID: <20241230181639.GFZ3LjhzlsXSygalx-@fat_crate.local>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230180941.244418-1-romank@linux.microsoft.com>

On Mon, Dec 30, 2024 at 10:09:36AM -0800, Roman Kisel wrote:
> [v5]
>   - In the first patch, removed some arch-specific #ifdef guards to fix the
>     arm64 build and stick to the direction chosen for the Hyper-V header files.
>     I could not remove all of them as some interrupt state structures
>     are defined differently for x64 and arm64 and are found in the same
>     enclosing `union hv_register_value`.
> 
>     No changes to other patches (approved in v4).

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
one week before resubmitting or pinging reviewers - possibly longer during
busy times like merge windows.

T Dec 18     Roman Kisel ( :8.6K|) [PATCH 0/2] hyperv: Fixes for get_vtl(void)
T Dec 26     Roman Kisel ( :8.1K|) [PATCH v2 0/3] hyperv: Fixes for get_vtl(void)
T Dec 26     Roman Kisel ( :8.6K|) [PATCH v3 0/5] hyperv: Fixes for get_vtl(), hv_vtl_apicid_to_vp_id()
T Dec 27     Roman Kisel ( :8.8K|) [PATCH v4 0/5] hyperv: Fixes for get_vtl(), hv_vtl_apicid_to_vp_id()
T Dec 30     Roman Kisel ( :  84|) [PATCH v5 0/5] hyperv: Fixes for get_vtl(), hv_vtl_apicid_to_vp_id()

This patchset gets sent almost every day. How about you slow-down and read the
docs while waiting?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

