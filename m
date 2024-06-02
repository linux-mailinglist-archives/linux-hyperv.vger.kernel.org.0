Return-Path: <linux-hyperv+bounces-2273-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842238D7568
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jun 2024 14:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F5D1F2200F
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jun 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC903A267;
	Sun,  2 Jun 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLrH8tx1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8873BBCB;
	Sun,  2 Jun 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717332142; cv=none; b=TNuQC3+BN7S3FEYuV4iHXY3czp9CNAjNu1VxuTSe7yi6gYnmODlwHHuqV156mPVNI2/gNA8xK97Mnx8oIrbHTlLgcXBhx+VfclCjb850PiQe0EO8QkhNPr5zKaspsmzMBWn1PT4jmejBMApsB8YA10UenZpuqvqMgtB4h3g9bm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717332142; c=relaxed/simple;
	bh=bd0Ky3nJOVfEJZnsWoWRij0lx/SkCJKPs7DSSagkBwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfjo14PwUKXcZikuYAvs2ow65qa0Qb1BUiJTu0cOddHzKIXTiRLeZhK82vmWHeLIJkGXuWV9WIZS5v7SqYLduR60Yd9jtfwjFwqaH+ymAxP8CYECJ9RlrGJ5IULwZ1yVu76IDn/yAecJnGHJItFMwGfMLrFPyGrTxa6MyCfe5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLrH8tx1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717332141; x=1748868141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bd0Ky3nJOVfEJZnsWoWRij0lx/SkCJKPs7DSSagkBwQ=;
  b=dLrH8tx1LrlU1+a27Fu+4JcFCgWrBI/gQwogceJ0De8g1J1Atn45pEcW
   btz/hHCOmMKgWy5wF+zwrtn4CkDW96cKaQ/LmWDAsMdpskx/D35L+vNCV
   DOePUJ/Y7sAeOr+44WA1yVaNfYq8/2EotiCyBCH/ygq+bc8a1HyWYWzKm
   /O0GPNHFgSJhvTofPnr28M2bMWa3w6XVehrWukqfTOBWRyyFWV+akRC4O
   u7KnNalAlWwLGWGPsm54WuaZeTWKp4R7F3wZSxrcZgkH4iNmBSuDzpQlt
   bzy9rjldD4f0WEo8fqb4rRZZRVYf2Mu25a/VRFLFMROFO6tqUa5LI0/sd
   g==;
X-CSE-ConnectionGUID: 0BgjrO1pTau1aw2ebZLXbQ==
X-CSE-MsgGUID: MDxnFEZDTselJmk3EHxa3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17624416"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="17624416"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 05:42:21 -0700
X-CSE-ConnectionGUID: tX8LoOEsRrWCzt7Ls4ZcdQ==
X-CSE-MsgGUID: UuebdpjSSvGjZhnGNfe2DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="41061427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 02 Jun 2024 05:42:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9CA1A1CB; Sun, 02 Jun 2024 15:42:13 +0300 (EEST)
Date: Sun, 2 Jun 2024 15:42:13 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: bp@alien8.de
Cc: adrian.hunter@intel.com, ardb@kernel.org, ashish.kalra@amd.com, 
	bhe@redhat.com, dave.hansen@linux.intel.com, elena.reshetova@intel.com, 
	haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com, kai.huang@intel.com, 
	kexec@lists.infradead.org, kys@microsoft.com, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ltao@redhat.com, mingo@redhat.com, nik.borisov@suse.com, peterz@infradead.org, 
	rafael@kernel.org, rick.p.edgecombe@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org
Subject: Re: [PATCHv11.1 10/19] x86/mm: Add callbacks to prepare encrypted
 memory for kexec
Message-ID: <wu34snwuytiwqp3scpxl7c7jw47jiywjlvommoenpsmbrp6c5k@con7h3pomdst>
References: <20240529104257.GIZlcGsTkJHVBblkrY@fat_crate.local>
 <20240602123903.2121883-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602123903.2121883-1-kirill.shutemov@linux.intel.com>

Please disregard this. I failed to fold changes :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

