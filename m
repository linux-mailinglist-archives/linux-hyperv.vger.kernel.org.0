Return-Path: <linux-hyperv+bounces-2196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A58C9B67
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD10280F5A
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E704E1CE;
	Mon, 20 May 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gx9CISCq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD003E47B;
	Mon, 20 May 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201348; cv=none; b=m2TUa0QUcoLnzYMXMP4XC5bApJmphN5ce255MxY7XYdSmytsHoZ2HXYRFvesBey5xKslwrVnB+V2to/72UU9BJxx+L+5kOZUXYgcklNpX+VTLjAOqecsJH/Gcz3aOmQF5hTwnOUwYZ/8moSykR+Wbl5ruXocsA3vqhjF3MbeIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201348; c=relaxed/simple;
	bh=A/ZtKIOzjGzmus/h85YRhlIv2OaZKnnSRZwq4D30MIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrdpH72rtbvnIcjiSWiyZDcPzhHPrWjCXh4Y5AArcBn7ccXea5NR4dIXCL9YgEuSdCC53L24E8jeoCXXUtiJCQqM5GVu9RbnpbXtW+7ZsUcFsCv1G2n1wO1bhZLQ9COjVO598kFL3QlNjGDQK+xmZGskYJZdybczcPe1ikHVSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gx9CISCq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716201347; x=1747737347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/ZtKIOzjGzmus/h85YRhlIv2OaZKnnSRZwq4D30MIw=;
  b=Gx9CISCq8eNbT5ZnT8fMXP963rgXu/ci2u64x7cuI5qR0EyIm1D6r7rn
   N/evgfK091pLoeTZ1R357taYGUhaf9TqTyDV2GNp0qCMsKZJEkuQNxkcV
   6SjIQWy5Yr3LUdoQJZAApTRlq2C6EGAe98/i9vNfupOJiuQh3cAA44F84
   OGrwF/CwwkQLXGnn4eU6uqZyUS+XkBWlgWcHkuYxPKXcE9NA+hoOt5r5g
   upApOOLCOJOPjJmpdtvYt24gROkXpGOQA4FuTlgCGme7K6Kb9w1kyH4QP
   Av+GWtqWnwPxsoaW1t/1deuWcsc+e4E40ZoGjRHOpF/RLDou2TUJ/NC49
   w==;
X-CSE-ConnectionGUID: mwYH+XVYQPGRjh6jGPiNZw==
X-CSE-MsgGUID: FjGtkcOKTXmwR1uOmcZJ5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="34836330"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="34836330"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:35:46 -0700
X-CSE-ConnectionGUID: MELpyzzDQnWS3eqmSDJPtw==
X-CSE-MsgGUID: 6BfR/RPaSR6mpxmR7CD7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32624271"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 20 May 2024 03:35:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D7E0D2AD; Mon, 20 May 2024 13:35:41 +0300 (EEST)
Date: Mon, 20 May 2024 13:35:41 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 01/20] x86/tdx: Introduce tdvmcall_trampoline()
Message-ID: <d6nrxz2rxguyjj7rmmj7jl7uvtmo5o2kpbqqxtn5wxyqjurfr6@niuyjy3l3jpy>
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
 <20240517141938.4177174-2-kirill.shutemov@linux.intel.com>
 <9cd7f179-673b-4e96-be08-128dc6fb6271@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd7f179-673b-4e96-be08-128dc6fb6271@redhat.com>

On Fri, May 17, 2024 at 07:02:25PM +0200, Paolo Bonzini wrote:
> On 5/17/24 16:19, Kirill A. Shutemov wrote:
> > The function will be used from inline assembly to handle most TDVMCALL
> > cases.
> 
> Perhaps add that the calling convention is designed to allow using the asm
> constraints a/b/c/d/S/D and keep the asm blocks simpler?

Sure.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

