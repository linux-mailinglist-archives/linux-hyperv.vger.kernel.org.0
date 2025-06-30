Return-Path: <linux-hyperv+bounces-6060-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF3AEEA97
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 00:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA371BC3B81
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 22:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB8226D11;
	Mon, 30 Jun 2025 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DN+y17LC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922D4A0F;
	Mon, 30 Jun 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323547; cv=none; b=EufWFcNViV25c87E4DjeO2ROh7EYWQsffwdnvgEWldV5fkNXQ24oLxCkxAdnJ41xpt3o1ONcv64/gD8EO+pE9ubHgWPzho2wTHWLDyg/rGQQQxoP4ndVMSUv0ZUGLqa8WVPHI1fSxJBHP3sCC03zyOu9/igF26eSJ/jtjNlB2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323547; c=relaxed/simple;
	bh=Cfj5WSreGQsw3227MrakCwF7ZLW0BlXUEIMzeuyYw6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhXOwub+ydajz1WqmPI8N65Sr4QjmGrI+PrpxRd9w/O8HS1r9mnM0EV7ndcUhWkdq76Kje7Q71WpxMCAKdpVYpq6Fi6XcMwpoB3YALuGCWVribIuunPZqGIVkF/cm1KaaMzuQ++Kcg6FzlObS4FPL27L5TdMdfVQy5erhBQRUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DN+y17LC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751323546; x=1782859546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cfj5WSreGQsw3227MrakCwF7ZLW0BlXUEIMzeuyYw6w=;
  b=DN+y17LCXZVd96wilsfFvzNkJseJDZg6GZ63FbzoWolBVs+dXCZinPZj
   nQbkFYTuOvWcq6UTkOCK0PG7nefRSNTDuBSPe0j9pGBFaG2HymwQ6ZnOL
   eV9tRSDZpNNPAG27e5+9QSiTqanpg3OQk0BkCzBycys8hfBkZTFdUZR6F
   ycS0Ds5gBgavLYlr8o6hZqdVnc61b+YD1yS8e8Xv18/AGanfxWFsHvdlr
   jch22K9ovBwbzJxIuw7O1V6HGmZNJJYrpylpgkmcCTWbXJTg79pTK7tmg
   Q2FIABQ8ETH5reA1j40n0lz66dLswKGeT0M0WHAprTX9D3y8bOsGd9BSs
   w==;
X-CSE-ConnectionGUID: 4WjxRnoMTj+h8tG/8yGE6A==
X-CSE-MsgGUID: rGK6j75qRo6Z++I4sAK6eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="65010827"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="65010827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 15:45:45 -0700
X-CSE-ConnectionGUID: p/i6hdoVQ5iKbuHy0pypiA==
X-CSE-MsgGUID: l2dPfkHOTmC98iA36F7JTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="159299158"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 15:45:45 -0700
Date: Mon, 30 Jun 2025 15:51:44 -0700
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
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v5 01/10] x86/acpi: Add a helper functions to setup and
 access the wakeup mailbox
Message-ID: <20250630225144.GC3072@ranerica-svr.sc.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-1-df547b1d196e@linux.intel.com>
 <CAJZ5v0i+EOthnNexMs7hm1iX+PY0rCNCHjRgB5r5pJ3tz2aw+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i+EOthnNexMs7hm1iX+PY0rCNCHjRgB5r5pJ3tz2aw+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jun 30, 2025 at 08:55:25PM +0200, Rafael J. Wysocki wrote:
> s/a helper/helper/ in the subject.

Ugh! I missed this since v3. I corrected it. Thanks for noticing.

> 
> On Sat, Jun 28, 2025 at 5:35 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > In preparation to move the functionality to wake secondary CPUs up out of
> > the ACPI code, add two helper functions.
> >
> > The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
> > the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
> >
> > There is a slight change in behavior: now the APIC callback is updated
> > before configuring CPU hotplug offline behavior. This is fine as the APIC
> > callback continues to be updated unconditionally, regardless of the
> > restriction on CPU offlining.
> >
> > The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
> > mailbox. Use this helper function only in the portions of the code for
> > which the variable acpi_mp_wake_mailbox will be out of scope once it is
> > relocated out of the ACPI directory.
> >
> > The wakeup mailbox is only supported for CONFIG_X86_64 and needed only with
> > CONFIG_SMP=y.
> >
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> With the above nit addressed
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you!

