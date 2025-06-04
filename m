Return-Path: <linux-hyperv+bounces-5764-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E18ACDCCB
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 13:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93965176A22
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A501628ECCE;
	Wed,  4 Jun 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa7IBXXJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20E28D8ED;
	Wed,  4 Jun 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037194; cv=none; b=hTx+vHI0vPhE27r8U9n8BR3HYjy8HydhKk4RkSy0M6/677matXiZtMQNQItxfRMTmAngmSrbfXulshvGZ9rzG80fMor6HNI7oKYiup4k0Rfg9l6eyr2WP3FddamFf5JNgTAytQ3krEZFc+w/Os+Rzl+MgcYvWS4VKgPy+Vd+/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037194; c=relaxed/simple;
	bh=ufZGYSMjuWeE0gmaN3weztdJUrBUeABeoB5cfpDXF9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbElBr7Bg4gFZL6O2i0OMyFqbxZg6pC90oCCXBttOmMmPbTxqLjj2UPhdAtBYunUqWjPkOZYPRXRGkBcl8/+ylmiQusOGtPZBwyY3RjUHIzhST7QiZGjXiaGQQoD2Q3Bcsk1oiyyvirpU9Kt9PqWoEp1ZT7lXBjMhSrrczGmXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa7IBXXJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749037192; x=1780573192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ufZGYSMjuWeE0gmaN3weztdJUrBUeABeoB5cfpDXF9c=;
  b=Qa7IBXXJ1MzG4ZhQY2/jh9zRWDTnD/QSKCwuYzGs2wg0D0+RqksM+zjy
   3RXMhEarpMTAs2n/qe6RHuUpragMW0DRW7cDyksQKaYcqCdYI4d+sbLFz
   PsA/HI76RnhvuwZ8456LdNEavQNvJMmS6PkkGNXkMXOD6zewhmvSxbCIu
   a2BD7XL3ujEy69atTcDaAtxuDn+6JMDv0fKQhly1J8ktfZ9x3egcGQ7vO
   8UNINKoZLrwVozt3jkMrF9gSWigNtmoYe7NS8ag9qVRZziQRWgo1s2J8E
   +Rbj+t7+kqQTTkFXtZZQg6JQlMehiKRB3H0HMvQxFesRvcI3EDl2phqKG
   w==;
X-CSE-ConnectionGUID: ZvTCTuzCTMOniRW/Xc8S1g==
X-CSE-MsgGUID: 7zyYtGSXT1qgggdyvJo0DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54776197"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="54776197"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 04:39:52 -0700
X-CSE-ConnectionGUID: 4gH2R/qmRh+J8XxmpdEsLA==
X-CSE-MsgGUID: f0YM29GmS/uxrFTQImlS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="149950623"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 04:39:52 -0700
Date: Wed, 4 Jun 2025 04:44:59 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v4 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Message-ID: <20250604114459.GA29325@ranerica-svr.sc.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
 <20250603-rneri-wakeup-mailbox-v4-2-d533272b7232@linux.intel.com>
 <CAJZ5v0geZAnLRkeunW06JKE1gyDcd15EGzqJ_A-cZHO_koJVAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0geZAnLRkeunW06JKE1gyDcd15EGzqJ_A-cZHO_koJVAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jun 04, 2025 at 11:12:53AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 4, 2025 at 2:18 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware that
> > it wants to boot a secondary CPU using a mailbox as described in the
> > Multiprocessor Wakeup Structure of the ACPI specification.
> >
> > The platform firmware may implement the mailbox as described in the ACPI
> > specification but enumerate it using a DeviceTree graph. An example of
> > this is OpenHCL paravisor.
> >
> > Move the code used to setup and use the mailbox for CPU wakeup out of the
> > ACPI directory into a new smpwakeup.c file that both ACPI and DeviceTree
> > can use.
> >
> > No functional changes are intended.
> >
> > Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v3:
> >  - Create a new file smpwakeup.c instead of relocating it to smpboot.c.
> >    (Rafael)
> >
> > Changes since v2:
> >  - Only move to smpboot.c the portions of the code that configure and
> >    use the mailbox. This also resolved the compile warnings about unused
> >    functions that Michael Kelley reported.
> >  - Edited the commit message for clarity.
> >
> > Changes since v1:
> >  - None.
> > ---
> >  arch/x86/Kconfig                   |  7 ++++
> >  arch/x86/kernel/Makefile           |  1 +
> >  arch/x86/kernel/acpi/madt_wakeup.c | 76 ----------------------------------
> >  arch/x86/kernel/smpwakeup.c        | 83 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 91 insertions(+), 76 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index cb0f4af31789..82147edb355a 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1113,6 +1113,13 @@ config X86_LOCAL_APIC
> >         depends on X86_64 || SMP || X86_UP_APIC || PCI_MSI
> >         select IRQ_DOMAIN_HIERARCHY
> >
> > +config X86_MAILBOX_WAKEUP
> > +       def_bool y
> > +       depends on OF || ACPI_MADT_WAKEUP
> 
> At this point the dependency on OF is premature.  IMV it should be
> added in a later patch.

I see your point. Sure, I will the dependency in a later patch.

