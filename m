Return-Path: <linux-hyperv+bounces-5369-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44944AABAD0
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C054E71A7
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9C28DF42;
	Tue,  6 May 2025 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcI8Pe0A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170F28DF47;
	Tue,  6 May 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746509546; cv=none; b=XBlu6nlVSWbngX2bEJGquWwCWryoJo3Bmqk8sfUl5gQ27mg2LQQE0b37sl/dCALXda7oV/vfegRXXITgXyw6j0sc8igLxePMIhG62N6JeD5BiFLDdziOior4D9BU5Wne3mNmiZTnL3mGZb2tPQrtm9nEwEnmQ6tVHE8v9SXpA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746509546; c=relaxed/simple;
	bh=remPqthXLp54OhP3D7Lc9RtMDdogPoIvT5KHNV5kIjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrZRKuvoKEO0T3HNW4pSd+L3UVmG2HIseUxeMO4wC2xSxehzL4VmIOzWSTglk/FHoWjMdfUL1bh8euEo2ceufrq6RMFLuZsQSWlpsrk0eT3JYlcpATfpUoWSWPmYE//jp33RxWyqq6pHynV2iTt5d1AmF1BAEOqEgwZ+nIMYmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcI8Pe0A; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746509544; x=1778045544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=remPqthXLp54OhP3D7Lc9RtMDdogPoIvT5KHNV5kIjM=;
  b=mcI8Pe0AnvS8rvzSFy7mdSSpuuT05Ke55DzTjk4Aj8v79dwvP23Q7Nga
   X8Ogwr3KziOw9bYefTuT4O71wdtkdF1Fn997PoYzaop86vhcSfH07gD8I
   LgmVs9ouBMNVyAy3dpSizJxhwaglvmBaVjJjpXHc86egr0DPJ14vmzYNj
   A+tvmJ26bOp8E9xW+X533TliBFPBu2FHHfP4VD2ylY2Yjv+QxP5Tmfh2b
   Lw09HE3UAjjcIoyGwLfv0KLJsFTAcCSDl19zT9fTfknslHQfZoof1Ieyq
   yS8fHmZLP1Q7bVCRYjeazNinzajcSRVgkErQO38k6LxCmxyjQ8bKP2Kbw
   g==;
X-CSE-ConnectionGUID: EOG2YerGSh2Llr+1WNL3LQ==
X-CSE-MsgGUID: AR7YbiIIRyOkw6bjv8slQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="59544505"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="59544505"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:32:24 -0700
X-CSE-ConnectionGUID: FTuGaNbgRhiyzQpmGqK8LA==
X-CSE-MsgGUID: Tdb3wdcaS5KMnHepMukgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="135389730"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:32:23 -0700
Date: Mon, 5 May 2025 22:37:26 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 03/13] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpboot.c
Message-ID: <20250506053726.GF25533@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-4-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0h_QcH72COEU-cnHUMfXj2grHv1EoLuBJnxm7_AeRteWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h_QcH72COEU-cnHUMfXj2grHv1EoLuBJnxm7_AeRteWw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, May 05, 2025 at 12:03:13PM +0200, Rafael J. Wysocki wrote:
> On Sat, May 3, 2025 at 9:10 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware that
> > it wants to boot a secondary CPU using a mailbox as described in the
> > Multiprocessor Wakeup Structure of the ACPI specification.
> >
> > The wakeup mailbox does not strictly require support from ACPI.
> 
> Well, except that it is defined by the ACPI specification.

That is true.

> 
> > The platform firmware can implement a mailbox compatible in structure and
> > operation and enumerate it using other mechanisms such a DeviceTree graph.
> 
> So is there a specification defining this mechanism?
> 
> It is generally not sufficient to put the code and DT bindings
> unilaterally into the OS and expect the firmware to follow suit.
> 

This mechanism is described in the section 4.3.5 of the Intel TDX
Virtual Firmware Design Guide [1], but it refeers to the ACPI
specification for the interface.

> > Move the code used to setup and use the mailbox out of the ACPI
> > directory to use it when support for ACPI is not available or needed.
> 
> I think that the code implementing interfaces defined by the ACPI
> specification is not generic and so it should not be built when the
> kernel is configured without ACPI support.

Support for ACPI would not be used on systems describing hardware using
a DeviceTree graph. My goal is to have a common interface that both
DT and ACPI can use. I think what is missing is that common interface.

Would it be preferred to have a separate implementation that is
functionally equivalent?

Thanks and BR,
Ricardo


[1]. https://cdrdv2-public.intel.com/733585/tdx-virtual-firmware-design-guide-rev-004-20231206.pdf


