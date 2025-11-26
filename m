Return-Path: <linux-hyperv+bounces-7833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F37C87CAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 03:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E32214E4EBE
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3C308F0A;
	Wed, 26 Nov 2025 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuwSWtCg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC713081A2;
	Wed, 26 Nov 2025 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764123196; cv=none; b=ad45G3dMywH9bX5BvM0uvxwM2lhID8ttsTbTJVWhgZ1JWNig3R+AkZc4JuKhSntw+8/IOOJl3mNDC0pg31SPL0CeGGvdRfRb2KwKQbHFtyrEfFLCMpsCbCiUGdHv0JS0+FDmnBxxt9mCh/p0apTrr0SvGhCXR9ERCK2/mZe8DP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764123196; c=relaxed/simple;
	bh=l33CIgyhKLpLw98GU9xdxzTlqqZv4JzOJGO4WqkP2vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmk2cIL6D0U3QuyV7aMAxZTe4FM5kRhj1n7YYW2MFtFkhE4HwqcT8S2cjLKVgsxEqw/DYbxuwQ+5HHQviOeA4S09KfLLs04llVOeDQVFheSetFbcxAsqbAXd59+vaCjof7EG2rTnffYv7+qQ0rcJupfnd7aQIxm/XaLKM3qMiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuwSWtCg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764123194; x=1795659194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l33CIgyhKLpLw98GU9xdxzTlqqZv4JzOJGO4WqkP2vM=;
  b=WuwSWtCgDY4S6LS1DeETc2In1PEyqtIzUB1S4HlbYGjTS6cqkcY/aLty
   kIS7ugCKX1LhpyA1e52RNYC37/seFHWynOzLvsYPZRUkPcwaTJxaounzY
   SlsPUtVLw9YVecfz7fw7I+JZ6P6lk7ylUBpt1YS+87BgdqjG6kKYu8vlP
   /7S//gofj9N/L55Xmi4PanuzpHn0vksb1du8G0IfFoVznH+NTy9shx+bl
   713BdYUGsnbSJGe65iHzJ6wPh8m6Tovt6gEGEIDE00D8A6xeqmcKSiktV
   e3KruyD1P6c2AFTW96D4jNCr8XEpPmD8RFzlZngN7IN0f8CNUaB47ALaC
   w==;
X-CSE-ConnectionGUID: GTcJl0stTR6Sa5d0yNlsNg==
X-CSE-MsgGUID: xFhHPKt8TQmnhyhpUe/hMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66040343"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="66040343"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 18:13:13 -0800
X-CSE-ConnectionGUID: 3F08XkzjQ22fv3h6BukwKg==
X-CSE-MsgGUID: 9txGjdGPR22BjCj9if3Etw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192696992"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 18:13:13 -0800
Date: Tue, 25 Nov 2025 18:20:10 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v7 1/9] x86/acpi: Add functions to setup and access the
 wakeup mailbox
Message-ID: <20251126022010.GA27627@ranerica-svr.sc.intel.com>
References: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
 <20251117-rneri-wakeup-mailbox-v7-1-4a8b82ab7c2c@linux.intel.com>
 <CAJZ5v0gd_6b6s4aEpSvdfb4-+AULTWkqQqM3OE1eg5XzYaxQFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gd_6b6s4aEpSvdfb4-+AULTWkqQqM3OE1eg5XzYaxQFQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Nov 24, 2025 at 05:01:11PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 17, 2025 at 6:04 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Systems that describe hardware using DeviceTree graphs may enumerate and
> > implement the wakeup mailbox as defined in the ACPI specification but do
> > not otherwise depend on ACPI. Expose functions to setup and access the
> > location of the wakeup mailbox from outside ACPI code.
> >
> > The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
> > the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
> >
> > The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
> > mailbox.
> >
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Thanks Rafael!

