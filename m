Return-Path: <linux-hyperv+bounces-5402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15161AADD1A
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 13:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C86C50617D
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87522218EBA;
	Wed,  7 May 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHAfuVv/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8201DF270;
	Wed,  7 May 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616672; cv=none; b=gulhUYtk+5hZqqnEpk4tveOPeJkSdFVmQmBA/BAJP4EwsxjO17PV+dS3HtiB2R+WJv4FP4Afc//ras0nWR3mhoCpGrEj8PpImIVK5iUmoLwNdrk3g0tGa1zg2PY9l9mfgIIfSb3+zx77WOgp9ADaHZ5e/8jK/wMWHF2Li+V9Gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616672; c=relaxed/simple;
	bh=J34de4dIKJGQUh5DHfc+AkSr13+tj6zgvxA8HJxO/yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+FzqVMkeIdfIXsdnqCZLKqQuYPRA3lNRO/X7JwFF9gYRErTBHiZOXXAqgHaRjrJ96Pirshl7v41AhaQPJ6X5qFgmNX7Kue+xlOizBuCQZo+4Z1ztCpqfidMFan3wv1Oaa2axYOY8C5Dp499FKz6DIHEtvfDWrVrBw0uoblaNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHAfuVv/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746616671; x=1778152671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J34de4dIKJGQUh5DHfc+AkSr13+tj6zgvxA8HJxO/yI=;
  b=OHAfuVv/UrFgsbSZ/plnFUpEV3shTu8L4sNK3iJuW0hrCxfmrtlEgA8D
   qdc+yAd2drfN0VusD18OGINNlywvRhXUFCKTguBYhbeN2kySGfe1devRZ
   ZN4Q7vvXLoUPnztAIv2F6cj/GuFhGzOX9DpJuyoo798H2CkPNLLG7u85c
   TL2eiuaUqzMxxEiO8vALZNjP5Ls4GNuUge1baoP8fylAeKJyyLjllITay
   HrR2DIPTquTY8nLGxIhMDdfg+42MKaYhaDGSldRCQ8nso3ujgvjDR8+/o
   fxIU8qxADh8eJ+i9J3jKUqPgXofFsBwSOVnhQloBgtuHycLHN6xRNTaCM
   w==;
X-CSE-ConnectionGUID: EXMfnIN6S3ewdg/eDV3DXQ==
X-CSE-MsgGUID: 5ujAiqrfSn6lMgAQW1INjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48240124"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48240124"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:17:50 -0700
X-CSE-ConnectionGUID: 8Kup3MNdRiGjxFn0ssrQ3Q==
X-CSE-MsgGUID: 0u8g8DD4Smi/vt+aRzhIZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135838264"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:17:49 -0700
Date: Wed, 7 May 2025 04:22:54 -0700
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
Message-ID: <20250507112254.GA27839@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-4-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0h_QcH72COEU-cnHUMfXj2grHv1EoLuBJnxm7_AeRteWw@mail.gmail.com>
 <20250506053726.GF25533@ranerica-svr.sc.intel.com>
 <CAJZ5v0gctkVZUs1SrzQtezmfMuMfbrAJ4+DTLgaQB=pMc8_hvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gctkVZUs1SrzQtezmfMuMfbrAJ4+DTLgaQB=pMc8_hvg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, May 06, 2025 at 07:26:01PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 6, 2025 at 7:32 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Mon, May 05, 2025 at 12:03:13PM +0200, Rafael J. Wysocki wrote:
> > > On Sat, May 3, 2025 at 9:10 PM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > >
> > > > The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware that
> > > > it wants to boot a secondary CPU using a mailbox as described in the
> > > > Multiprocessor Wakeup Structure of the ACPI specification.
> > > >
> > > > The wakeup mailbox does not strictly require support from ACPI.
> > >
> > > Well, except that it is defined by the ACPI specification.
> >
> > That is true.
> >
> > >
> > > > The platform firmware can implement a mailbox compatible in structure and
> > > > operation and enumerate it using other mechanisms such a DeviceTree graph.
> > >
> > > So is there a specification defining this mechanism?
> > >
> > > It is generally not sufficient to put the code and DT bindings
> > > unilaterally into the OS and expect the firmware to follow suit.
> > >
> >
> > This mechanism is described in the section 4.3.5 of the Intel TDX
> > Virtual Firmware Design Guide [1], but it refeers to the ACPI
> > specification for the interface.
> 
> Yes, it does.
> 
> > > > Move the code used to setup and use the mailbox out of the ACPI
> > > > directory to use it when support for ACPI is not available or needed.
> > >
> > > I think that the code implementing interfaces defined by the ACPI
> > > specification is not generic and so it should not be built when the
> > > kernel is configured without ACPI support.
> >
> > Support for ACPI would not be used on systems describing hardware using
> > a DeviceTree graph. My goal is to have a common interface that both
> > DT and ACPI can use. I think what is missing is that common interface.
> 
> I get the general idea. :-)
> 
> > Would it be preferred to have a separate implementation that is
> > functionally equivalent?
> 
> Functionally equivalent on the OS side, that is.
> 
> It would be better, but honestly I'm not sure if this is going to be
> sufficient to eliminate the dependency on the ACPI spec.  It is just
> as you want the firmware to implement this tiny bit of the ACPI spec
> even though it is not implementing the rest of it.

Yes, that is all I need: the address of the mailbox and firmware that
implements the mailbox interface as described in the ACPI Multiprocessor
Structure.

Thanks and BR,
Ricardo
> 

