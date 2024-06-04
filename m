Return-Path: <linux-hyperv+bounces-2309-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5908FB772
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4430B1C22119
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E2145FF7;
	Tue,  4 Jun 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqroHQog"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E4143C7A;
	Tue,  4 Jun 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515173; cv=none; b=CMok4ZiNSU3rWH0nNzbbFXGBABR0+POajWfMvfQRhVwxdOYGKS1MUpOQHwTpN3iM7kp5NMMh++SzJpP0U0gMSVPQxgTtnmk+RBsOSu4krTLn7NfrPa6EmwXivbgIodO8XuDZxSD3VxmEuCdXJBrxxMrp+GNpvVIoyDuwzmt5jrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515173; c=relaxed/simple;
	bh=J3T38p4+VBwHGHp1c1CCtvuA9p7YL8sLSDhZFZphLPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwySMybXyoHChhG5/AYyQUg/CX/H/qgkWem+3cYHg3AyfEMZV0XhTe70nuqf0XYjsuv+rggDOU1jSzplxmY54CGcvpAxIV9QLL6Ci8A+dTJhVkGwA0Gei+XwW/Wq7UHVaCUQzEJYT/uGP6LobtGTFfiY+xG9YM8qaL9iHmcCmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqroHQog; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717515172; x=1749051172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3T38p4+VBwHGHp1c1CCtvuA9p7YL8sLSDhZFZphLPY=;
  b=TqroHQogCxTCq7140Jdpjp5IreuOm5ZdctdHVCRk8l4ZnCtuvByILZSw
   AJvzQd430qDX6Xz5c6kSur6T3QY7olPS6oxwK2CBBnV4QWoo6l7rYWmKg
   irzYdxnxAzv9MOtIMEx34H40ieeLea49SalGWByndCRZ0sAIEvF0O6fMo
   7Mp2JPSqNXIhgetwVupOSrolZhBvRrnq+mOSAv8SSYppTXtDnYEXUtfdl
   y1NSwvn5mkFNvmaxfbAl1m2MKLNzj4cXqychlX4xNv07et0whLRDieZM8
   SnlenSrFUJ4Wtvq35+pg+jB2SfwDeHnhAuW0FfpXpHVn7NKnlpz36zUWr
   A==;
X-CSE-ConnectionGUID: 8JPTwi9uRcGhpu407Agx6A==
X-CSE-MsgGUID: 11FHYTSeRhORyGvaG3zciA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13950192"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13950192"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:32:51 -0700
X-CSE-ConnectionGUID: oiWsV40YQ3upwnBy4jBHSA==
X-CSE-MsgGUID: vSlLFQjkSbWE+7x+vrrshQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41715766"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 04 Jun 2024 08:32:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 783202DC; Tue, 04 Jun 2024 18:32:44 +0300 (EEST)
Date: Tue, 4 Jun 2024 18:32:44 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: adrian.hunter@intel.com, ardb@kernel.org, ashish.kalra@amd.com, 
	bhe@redhat.com, dave.hansen@linux.intel.com, elena.reshetova@intel.com, 
	haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com, kai.huang@intel.com, 
	kexec@lists.infradead.org, kys@microsoft.com, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ltao@redhat.com, mingo@redhat.com, peterz@infradead.org, rafael@kernel.org, 
	rick.p.edgecombe@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>

On Mon, Jun 03, 2024 at 10:37:54AM +0200, Borislav Petkov wrote:
> On Sun, Jun 02, 2024 at 05:23:03PM +0300, Kirill A. Shutemov wrote:
> > +			/*
> > +			 * The only thing one can do at this point on failure
> > +			 * is panic. It is reasonable to proceed.
> 
> It makes even less sense now: panic() means "all stops and we die" and
> you say it is reasonable to proceed.
> 
> I'm confused.

Right.

What about the comment below?

			/*
			 * One possible reason for the failure is if kexec raced
			 * with memory conversion. In this case shared bit in
			 * page table got set (or not cleared) during
			 * shared<->private conversion, but the page is actually
			 * private. So this failure is not going to affect the
			 * kexec'ed kernel.
			 *
			 * The only thing one can do at this point on failure
			 * at this point is panic. In absence of better options,
			 * it is reasonable to proceed, hoping the failure is a
			 * benign shared bit mismatch due to the race.
			 *
			 * Also, even if the failure is real and the page cannot
			 * be touched as private, the kdump kernel will boot
			 * fine as it uses pre-reserved memory. What happens
			 * next depends on what the dumping process does and
			 * there's a reasonable chance to produce useful dump
			 * on crash.
			 *
			 * Regardless, the print leaves a trace in the log to
			 * give a clue for debug.
			 */

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

