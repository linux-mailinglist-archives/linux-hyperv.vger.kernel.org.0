Return-Path: <linux-hyperv+bounces-10913-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMs7D8woB2ppsQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10913-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:08:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0285551032
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D9C300CE57
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32297481FB4;
	Fri, 15 May 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TyhRuKs2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055436894F;
	Fri, 15 May 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853493; cv=none; b=kP6rQH169VU+GN1HkGOPO/LsbBadM9OcWzKLLwTQmFJqFxnwxRJFgj3f/iP9tdX1jATvpWeGZlpRpcBeNRMUlaBS8ovaYlrD2DFb+SVXVF2r09V0xAym2kuPrrNaSenWyYiMMp67oYCwBDYx65bSl9298Ab24WwEosmJSXOgd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853493; c=relaxed/simple;
	bh=UJQG3VSzgoXmokXHk6pR6tDGZixiDw3OBDMxk+jt3Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6liXNxx5zZfQSIZcanJ9Y9GmJLoOAqrklEoZsNaUHBRYxvBbt6biV3Ea+P84dXqydHtsXBgMqYa3ikvl47scn7BJMt+Tpb1j0hL8PGH2cHtZ137dNbhs/R9H1B/1IoW+SZLdZD3ID19kN7mpD41/yUnOGO5TlRHkaU1LnMQhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TyhRuKs2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BC4E20B7166;
	Fri, 15 May 2026 06:58:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BC4E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778853486;
	bh=d1lGfXM5z8FUpJ6yBgaa5Pzq5ONXbZDPl9if6NBwHLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyhRuKs23rya7RRQP5pT3RlKmAk8JcVGEHJM38meAmcZpOrdcO/odd51nDNZm7xPj
	 AY2hbgxB//Ctudw4ebfc9FTV9Mol9AynhFT74ouFunsO5KMZ2BI+MnNG+j8Q2QKsg4
	 GlcS1b19jhEdpq20CM6+si9kZvGS0W+G4MwxKGys=
Date: Fri, 15 May 2026 21:58:08 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Mukesh R <mrathor@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "robh@kernel.org" <robh@kernel.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "muislam@microsoft.com" <muislam@microsoft.com>, 
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>, 
	"magnuskulke@linux.microsoft.com" <magnuskulke@linux.microsoft.com>, "anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH V3 01/11] iommu/hyperv: Rename hyperv-iommu.c to
 hyperv-irq.c
Message-ID: <s4askzopk7hrst52m2pjaba677qwr6qgipgu57mjlaaqw7sn2n@44r43drjlmoz>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-2-mrathor@linux.microsoft.com>
 <20260512164623.0000273f@linux.microsoft.com>
 <SN6PR02MB4157371A1A3931F582F9A2E9D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157371A1A3931F582F9A2E9D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: A0285551032
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10913-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:15:52AM +0000, Michael Kelley wrote:
> From: Jacob Pan <jacob.pan@linux.microsoft.com> Sent: Tuesday, May 12, 2026 4:46 PM
> > 
> > Hi Mukesh,
> > 
> > On Mon, 11 May 2026 19:02:49 -0700
> > Mukesh R <mrathor@linux.microsoft.com> wrote:
> > 
> > > This file actually implements irq remapping, so rename to more
> > > appropriate hyperv-irq.c. A new file to implement hyperv iommu will
> > > be introduced later.  Also, it should not be tied to HYPERV_IOMMU,
> > > but to CONFIG_HYPERV and IRQ_REMAP. The file already has #ifdef
> > > CONFIG_IRQ_REMAP.
> > >
> > > Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> > > ---
> > >  MAINTAINERS                                    | 2 +-
> > >  drivers/iommu/Makefile                         | 2 +-
> > >  drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} | 6 +++---
> >
> > Given that we have multiple Hyper-V IOMMU-related files — this renamed
> > hyperv-irq.c, the existing hyperv-iommu code, iommu-root (this
> > series) and the recently posted guest pvIOMMU driver — should we create
> > a drivers/iommu/hyperv/ directory to consolidate them?
> 
> Patch 1/4 in the guest pvIOMMU driver [1] that was recently posted by
> Yu Zhang does as you suggest.
> 
> Michael
> 
> [1] https://lore.kernel.org/linux-hyperv/20260511162408.1180069-1-zhangyu1@linux.microsoft.com/
> 

Maybe we can send a standalone patch and get it merged
first (move it to drivers/iommu/hyperv/irq_remapping.c)?

The rename itself is a meaningful cleanup regardless of
either series, and in the future, both Mukesh and I can
can then build on top of it without conflicts. :)

B.R.
Yu

