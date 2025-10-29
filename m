Return-Path: <linux-hyperv+bounces-7371-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B6C19F44
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA785080EC
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1DF32E125;
	Wed, 29 Oct 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BEuPRpDq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68E32E131;
	Wed, 29 Oct 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736478; cv=none; b=aJ6IgKgp7Bj8IJ/SUW4gUwmZtygMpXQV8kJ5uVkJ47WQdCBSw0b92Za2TQJQHimOPtHnX3uTD1y6K46vUIqKWROnKbQCAzvkKq9j57g2AoWIWbZmZ2V3joHFr+cUi9aEgMcHjFbekiQ4MLTMQEn2vRkE6K3vHMt92RxD/C2m7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736478; c=relaxed/simple;
	bh=EoewAb52MRH1aE94oGSQx6yR9L8ttHqchxyjOpRpAO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+vWiW1YKltEbsmmst+XE7vrZx89T8hig5iAMlANqEcu6shDQGQwt9xBvmxy5YbOJhzTF2UwvinFCwAYo9Jz5nvUOELV0AKjEtIwy3K2LS8U/l8hLtl1h5oEKzk4ELfQWLwTmtt0bk1uN6FvtVDDDV+Hgu+xS1GshLzh+EvVDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BEuPRpDq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 698F240E021D;
	Wed, 29 Oct 2025 11:14:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zvn2uvFF2vbQ; Wed, 29 Oct 2025 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761736467; bh=DQkRFEIwjwPvCcEFWdB8wz1gQTw6XbuZfP49kLOImGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEuPRpDq3zszaDovZGFI8/0iEOp5lkk1+Fb+9sxVcl1e53Fn31OTzn+r1AyMBVypX
	 7ZnkNwWZe181mZF5BJH5dc7nQBvYX+M0liWMCgXg1keznF5+Q+A1g/SxCd6JTbVmog
	 3CXOtwluhQQofNJrzpzn3KBR9md+p4P2RDxIM+mf69M9SJUrC04vxJac/UA3BWPVbX
	 8/LkGkxN6M46IJVen43Nw37Oz20jswQsEzS3MH/VSgDKn7/Z3QVwdNsHpeOWM6JJ/y
	 TyD7GulXBFfJncn1jt6Ldah2zNZdzXTD4kTPl+GfWZsPB9GRbIAkesaK2g/qnFpGSd
	 0srRag33S1naiSj6L20uRFYToC9SksN0F6DnOMF4nY/jKNo6rqJ/7UvyMkpAOgwVHo
	 SiRLemA9m3A6Zs22P6qWL2g3T9tj8tRP/KUqynsF/1yLUCgrm4Jqrl2lyyDkAEVrj2
	 NOuZcdiC5ytCG+8i7SJpTjj0Kdw2HAQ95Z3UmpaBZ/GSBULTmMm4hcVbNOTTXd/Rj8
	 91s2A5XswtBP9uKnQpGsbSQhVJlkYe7rQI5R00Zt2PK4hBR555MrKpy2qzcTisSjXY
	 axj7DVzVxHGOtc8LocTGtMGSO/bI6mmlNBPFlsZCLIe2/v88V+DPs0ClhUZm4HiDbc
	 AIb2zddL+jvs2J+WXuQnxuxA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 54A9E40E021A;
	Wed, 29 Oct 2025 11:14:06 +0000 (UTC)
Date: Wed, 29 Oct 2025 12:13:58 +0100
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
Message-ID: <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
 <20251027205816.GB14161@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027205816.GB14161@ranerica-svr.sc.intel.com>

On Mon, Oct 27, 2025 at 01:58:16PM -0700, Ricardo Neri wrote:
> Right. All the functions in the file start with the acpi_ prefix. It could
> be kept under arch/x86/kernel/acpi/. The Kconfig symbol X86_MAILBOX_WAKEUP
> would have to live in arch/x86/Kconfig as there is no Kconfig file under
> arch/x86/kernel/acpi. ACPI_MADT_WAKEUP is arch/x86/Kconfig.
> 
> Does that sound acceptable?

Right, this looks kinda weird. You have devicetree thing using ACPI code,
you're trying to carve it out but then it is ACPI code anyway. So why even do
that?

You can simply leave ACPI enabled on that configuration. I don't see yet what
the point for the split is - saving memory, or...?

> Thank you for your feedback, Boris,

Sure, np. Trying my best. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

