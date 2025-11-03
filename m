Return-Path: <linux-hyperv+bounces-7401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD8C2C296
	for <lists+linux-hyperv@lfdr.de>; Mon, 03 Nov 2025 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAB188F88D
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Nov 2025 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF22FBE08;
	Mon,  3 Nov 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HOGlu+YF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391C2DA77E;
	Mon,  3 Nov 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177275; cv=none; b=csOEPTe7c/l73OMtZ3SeZ8+F5R14wWRdjiklG967PYFA4IdLwxARTTcASyZONlleAqPCvR2PPvcN6mkduuuHPWoJ2wSHw012uQkbigpcdOCnsAmgH0Fk/NyAG9Poy7ETIJg/bhf3QRZs9YEC3UECfoovjGK3wMUu3sM/qzdftW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177275; c=relaxed/simple;
	bh=xNvAHzc/ZbWwIrRbPnxFzUiYiwh87HyVAdIpXGZfoLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgy9gd/E1BiEC27zGmlhwE2y79Ct4A54YvBj4To47ZQiieuWjrsBX5Tmxlw2mQ/dvUV3GTn8M+z3xrxQglD/QVasH+BTT6rBlRbAzqupfou8iZ5OT5hB0X4okGCiY0vRL2kwHJNsZmIGty0+k5u78qUqDZ4HPciIXYhGbUtzQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HOGlu+YF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF52940E01CD;
	Mon,  3 Nov 2025 13:41:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M-5mD1RyBWtB; Mon,  3 Nov 2025 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762177264; bh=GbYczoBSYFJ2a7y6WVUbqvm56JGqfF/fxI6kZKdT9Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOGlu+YF+9++OK+K5VXjZejvirvdFdjbI4VXdONk40BPvl42X9WLtG8ajTCr/4v5w
	 kGo8hd6hbZE+wSgxx9K/ynxQg3O6XT9Q7luFyLpppI0XYo+mgdziqUB93kb7hXfBy8
	 Qeisd1m8mP+KXUEAuhDO07FJ1PWaxX9oBPDjfnCNDUTteEJ7PJ+3z6+vWybvhAWtju
	 Ayq8QtXLWzBDvGoIFXXOtZioR7/7l0ZpesEGusEL0zRshdAS5RRsA/MuBWzCisXrdh
	 X++plqE37zhumIheUdDtlODh0VBYj6lWfZnr/T9YeyP6xuq7yaIyGsWrPHlHiaTcPR
	 tVJsXz4ma3QcINfN20fh6YI03CO0UO807ycccShKoDAw5P+sM/weYZU6TD0NuA+U6I
	 EAAaEjNyoC6hByFbhUYyf+sIUchGNaI3rlt9/V+F5ZXKbbFpbY3xT37NOGCBmm94nY
	 zOgg1+26fdTA/V+BGLlEOIE2lTWMiOoTei6BcUN3/NE87mY8Jf73zuWoNySNjEnjMG
	 UGQrWjOJMnzkE3dY2EX/sAhsP4RtC0W22hyjRNyzsA4PtfzUdnVWkb+jgPOA7E0aBY
	 Rtgn3biQCd1zycSdkMaESnwGVrGlsjtF686NN4jCDzOmAjUNUaYd+kFsgGaTV8mCmx
	 lzp2v9F1fAdE2eRTMtNaOdCo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7937D40E01FA;
	Mon,  3 Nov 2025 13:40:43 +0000 (UTC)
Date: Mon, 3 Nov 2025 14:40:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v6 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Message-ID: <20251103134037.GOaQiw1Y6Iu_ENu6ww@fat_crate.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
 <20251027205816.GB14161@ranerica-svr.sc.intel.com>
 <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local>
 <20251030054350.GA17477@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030054350.GA17477@ranerica-svr.sc.intel.com>

On Wed, Oct 29, 2025 at 10:43:50PM -0700, Ricardo Neri wrote:
> I did not want to enable the whole of ACPI code as I need a tiny portion of it.
> Then yes, saving memory and having a smaller binary were considerations.
> 
> The only dependency that ACPI_MADT_WAKEUP has on ACPI is the code to read and
> parse the ACPI table that enumerates the mailbox. (There are a couple of
> declarations for CPU offlining that need tweaking if I want ACPI_MADT_WAKEUP to
> not depend on ACPI at all).
> 
> The DeviceTree firmware only needs the code to wake CPUs up. That is the code
> I am carving out.
> 
> Having said that, vmlinux and bzImage increase by 4% if I enable ACPI.

So, is it a concern or not? I cannot understand from the above whether you
care about 4% or not.

If you do, I guess you can make a piece of ACPI code available through another
Kconfig option but keep it in the ACPI hierarchy.

Because no matter how you look at it, it is ACPI code which is trying to be
generic and failing at that.

Unless you scrub it completely and make it a generic thing which is used by
ACPI too.

Which would be a separate patchset.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

