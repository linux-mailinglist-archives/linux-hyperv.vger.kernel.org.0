Return-Path: <linux-hyperv+bounces-7487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF68C491F9
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAFD1881384
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B433A037;
	Mon, 10 Nov 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HA/SzYiw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58133893A;
	Mon, 10 Nov 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804034; cv=none; b=UX3g409shlRYAwsHmIsqm9yLQN9VlA9/4vFtn4b8COFTaT/1Kq6Ecm4z4cCRNFpRyOgMM8B0oNPuumoKC3NJWw3JjrhFjs7cv3ln2z7qQgxVqneqls2a5cuK7HQFov99BbpPjdBPLi+44IWK3X9i8YuCpvwq0IuRgUZS0hu4lhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804034; c=relaxed/simple;
	bh=KmjZ78nsrWv/j02vBIwvkqlGwBD+gAzgU0BeTi2yxzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjvDVvgKET9cOEaAANiWVYHhs1LcEHzHSMTFUZ7iaspDbFqUQL7ns50T2Ug5vXbxwgDCi0EjFfcFyMzIRmQuPzyk76ZuwUcaE4Nb8gnJSQRHtPHs9VZ74YqIxugwJLE5bub2gg+dQ2pFi06aFSXA/ST0fXWzc38LKERhq/mQROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HA/SzYiw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C299140E01CD;
	Mon, 10 Nov 2025 19:47:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BnmZnxbjy42f; Mon, 10 Nov 2025 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762804025; bh=DKhR+niWCN3Dqf0WyDVm9n+ik8sZQsAGWmtpC3hq0y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HA/SzYiw59J2DZ9NvjiTwgx2NerneQWVCKWzRJzpkzbOnbZbZYK2f7v6ti3sU+z/w
	 +jWYXc4YiEVEJcgoyo6mavdrGLADxkB2hq6ir8VWZVmBh+DjlYDdCNLGT/eLB822FZ
	 XGely4hbN05A+YNSDDAxhZnoxe5kqv0dl5hS1S1U9hW50mDwIB4ULyTxRYfcRy/VK8
	 TXVd/MZ5eSrfyamMgnoUESGfZFGN22ZgMQtRqgI9E1O4Ul0/lZqRB5jc1XsdetmrxY
	 QDFClkowRyjw57D7w7c6CI6ajLAdLCiEdtbUFj6jEyP1USefINRDKFuMso+5BBtqjI
	 qLOvkSnCLNvGit5V4TX1m1CHL4jBHaIqDldmVwOW2XYSnlpwCI+TasmurM2WLVUOsr
	 ntf0ztYaoVeHIfwpFpPKZgUHtYy7RaBsV6LwnMVKhOmnEl4BzUsv7Y2MiKWBeFFGxW
	 NB6ztOMbk6CyLHRZXiiuGFoocs80hG42zUIEaPPaFmZR42se95zM8ZS831L8JAWrjX
	 LbXMlwL//WPaB+yPrts1PgsuWBHEXLhKFc2bhJQM9H2N0sW4qB1Bsr92rqZwdp7iZ+
	 1n4rXhnhV2cJTf72yHJGHdQgFl24Ifx58HRbWqc1pNvxQBFIJbeuJb2EO0edlRpNQV
	 ms/s19Fv7BlPDufhuMBnaJks=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 415EF40E019F;
	Mon, 10 Nov 2025 19:46:44 +0000 (UTC)
Date: Mon, 10 Nov 2025 20:46:38 +0100
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
Message-ID: <20251110194638.GCaRJBHrJgwjRY5aQr@fat_crate.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
 <20251027205816.GB14161@ranerica-svr.sc.intel.com>
 <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local>
 <20251030054350.GA17477@ranerica-svr.sc.intel.com>
 <20251103134037.GOaQiw1Y6Iu_ENu6ww@fat_crate.local>
 <20251110174938.GA26690@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110174938.GA26690@ranerica-svr.sc.intel.com>

On Mon, Nov 10, 2025 at 09:49:38AM -0800, Ricardo Neri wrote:
> I apologize for my late reply. Also, I am sorry I was not clear. I needed to
> consult with a few stakeholders whether they could live with the increase in
> size resulting from having CONFIG_ACPI=y. They can.
> 
> If it is OK with Rafael, I plan to post a new version that drops this patch and
> adds the necessary function stubs for the !CONFIG_ACPI case.

Sounds good to me.

It is the simplest thing to do. If the size increase bothers someone, we can
always do the more involved refactoring later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

