Return-Path: <linux-hyperv+bounces-7338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006BBC0E5D6
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 15:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083F819A413D
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B5306B0C;
	Mon, 27 Oct 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MinPh+nt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB71E32D6;
	Mon, 27 Oct 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574754; cv=none; b=HltYHuItWI00nUPBkoqpR0kt0/VdTHnclInI5vKMI6xbwxNSnTKxaFmUOa/J/Wk+KcQAJE9EHVyc5fesid15nqh04j5Ma1fWULl9TzcdTGhBFzDHkL2rVD+6W0K6BlLl/2ZEtgAMBzot3XeeB0zapHGMrVnnjh3H9NaO18ttpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574754; c=relaxed/simple;
	bh=KGV8A/JCSSOTOZFkMZ5uzromsjhOAcelyumUEsQmSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og4JYH7pcUyfl/ms3aceLs4hUfEhjxscm1GXYfUWTWJmtkbIxE9MpbcCZVJfMh9H6lIRp2uk0s7NZKpdYPLVdivEq+Ovj3YzcuVMd8dJvmeOcMi9zrgYDIT1XiAlGYJayLkWXthFlzWe6i0z3WRP+0zuYIPH95T37Sx89Ipzle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MinPh+nt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 43ABD40E016D;
	Mon, 27 Oct 2025 14:19:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BxvgYnhae1Ln; Mon, 27 Oct 2025 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761574745; bh=DQars1sRNCHU+Qzf29zNsvutQcWRASEJY+QHOK2h+BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MinPh+ntuFLuxYRMzSt/D/BtHHxtsHnyVmxIE75KdBNqwVcgvP5oplNEN8UEXT93B
	 0Na5xAR4ZCp58zDJmUnoxykVlYxZ6QVFWzvrbVJ3fiW8jgjsMVzuRSRyjYe/7wTWB+
	 V8/Zw413jLHJhu7bGpbTottQ0/fq5T8lwlUFPlwN26z9iauJcdaFycjkg3xAvG7Tva
	 FfFWg/VDPmw3VXXG8PyFbg+yXSDosPm4X2e76g01AWJwRMCTmJ8qs15ksswbtTbTI5
	 hob+DLJO7AL05a4CZuoGWndWTJ8Do6QRB95bnvQWQfMZcyYgiY9K3GSfsS0mUsTg1R
	 1eKneWYXOGpfNoEjFm4Rc534tUTB0TfulbY2Zfi1Q1GYxVZbiagn7SV8AQnknQmtje
	 LkWr3Mbo507Rstdh8gLshlvRNo6/g6Hlytfk0BV8fgQq1MmB0frEhhPYSrhroEv9lF
	 scOhorWO/n7xot4n4tgBqCI9gG/EHsjou4fQAaj1+2dTLrD2Yf0cR4toXTi4EFgibQ
	 vGAPqTLgOHdEhtclYqJGEsDcx6DTAcr03YttdD9iMg1Y0f3SNk5ibTWSHiB4zfSZAu
	 m328/xbn60Y4Ir5zGgrHeD8nohSyo5WHxI4NJydy6TVWn/rRtQS4kLl9gFLBBzymgS
	 dKBp2ROJvxjBaBbHOZZ7wAjg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B014740E019F;
	Mon, 27 Oct 2025 14:18:43 +0000 (UTC)
Date: Mon, 27 Oct 2025 15:18:35 +0100
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
Message-ID: <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>

On Thu, Oct 16, 2025 at 07:57:24PM -0700, Ricardo Neri wrote:
>  arch/x86/kernel/acpi/madt_wakeup.c | 76 ----------------------------------
>  arch/x86/kernel/smpwakeup.c        | 83 ++++++++++++++++++++++++++++++++++++++

How does ACPI-related code belong in the arch/x86/kernel/ hierarchy?

Not to mention that arch/x86/kernel/ is a dumping ground for everything *and*
the kitchen sink so we should not put more crap in there...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

