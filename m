Return-Path: <linux-hyperv+bounces-2198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC558C9BC1
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 13:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99965280FB3
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BAA4DA09;
	Mon, 20 May 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2N4F5ja"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822C14AA9;
	Mon, 20 May 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202937; cv=none; b=U14XXhs83mYrzZEErI9eVXXpAp7Qiq+mjOlf16rYjSkNnDe7BjwHWwK3osn/8zOPyJVEtNncCVwwGh6hwF/iL3E6EC4sLk5zWv29+pWDuWOnNV+T2zfuYcgHJ3/J91mJZTkMscVWKcbc2gt8PPZ3POEuE9tMZvx0PVdRxDgx370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202937; c=relaxed/simple;
	bh=1Ukz21FCOyFvuXyrhqtkSqqNSZCXa2QKyEzhl885guw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEfM+C01JeGmfNhYpRpccs9MQWbvmSDKe8+fPTUHYM4LY7aRan3CwadvbL+kN39eIbvoI9cKRycH853MQrSl1g7+vDiklMEVu/IMF5CThtOhnIiXJBYcZ5D5NCZhubw5dxHZNCzXA4Kak4zl326M8HEZRpN85/X1c4gaR4kNcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2N4F5ja; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716202936; x=1747738936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Ukz21FCOyFvuXyrhqtkSqqNSZCXa2QKyEzhl885guw=;
  b=F2N4F5ja/LSXnF0UQBtBal4fj66ysdjj1rd/Z+TPZBor1xXchGQjfeUJ
   G7LVG3a38X6IXbucNIEoRgqlDBAwcISLtlV3cj28iYURTMgkBWvyLiW76
   2pGASezRlPbgX3P2hMPJnM9t2/9NquchGcX2vaJAp0cbLbXweU6j/2aLq
   LkY7JOlUYqi66KHB3Pvo5o+77vXC65jJNYcdpbtckw+SBYh49Ci9DVOiF
   BTT9OAhk1x1pU4BpE2AF4SBZ5J7/LV82shJ7IOhED5n3Q6u+MSeYIGAHw
   y2yTYurHCEbKIS4P/4WJik9zh/ooxXejvQIOjsC2CeNjM8pSqokgontOa
   Q==;
X-CSE-ConnectionGUID: UecCH5eTTMq6SjW6Gw6m8A==
X-CSE-MsgGUID: WoEE36v7SuCxKaXJpAoO8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12166588"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12166588"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 04:02:15 -0700
X-CSE-ConnectionGUID: 56OFHfI9S2+J4epdvHTpCA==
X-CSE-MsgGUID: axccaSldRzSG/bBV2SDGQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32358748"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2024 04:02:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5A1242AD; Mon, 20 May 2024 14:02:09 +0300 (EEST)
Date: Mon, 20 May 2024 14:02:09 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 16/20] x86/tdx: Convert VP_INFO tdcall to use new
 TDCALL_5() macro
Message-ID: <4fl6wyclb3kmduupljfqlqfjw64qtexdluwcu7vmumsq6ff4rs@ottpuuold45w>
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
 <20240517141938.4177174-17-kirill.shutemov@linux.intel.com>
 <ca2adcf7-5708-4142-bdd5-8700b98b4a5b@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca2adcf7-5708-4142-bdd5-8700b98b4a5b@intel.com>

On Fri, May 17, 2024 at 08:57:10AM -0700, Dave Hansen wrote:
> On 5/17/24 07:19, Kirill A. Shutemov wrote:
> > -	/*
> > -	 * TDINFO TDX module call is used to get the TD execution environment
> > -	 * information like GPA width, number of available vcpus, debug mode
> > -	 * information, etc. More details about the ABI can be found in TDX
> > -	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
> > -	 * [TDG.VP.INFO].
> > -	 */
> > -	tdcall(TDG_VP_INFO, &args);
> > +	tdg_vp_info(&gpa_width, &td_attr);
> 
> Why is the comment going away?

By mistake. Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

