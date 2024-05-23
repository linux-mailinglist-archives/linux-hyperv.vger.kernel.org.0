Return-Path: <linux-hyperv+bounces-2209-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE098CD5AB
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5003F1C21049
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C49D14B96C;
	Thu, 23 May 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDJPZLBD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC7146D79;
	Thu, 23 May 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474353; cv=none; b=RLlprAyP92ZAHl9xXT8prc2vNpdnnYfY7x/41P19qYZm7maORFcLkhna3lFfPUdnw5POw0fE7B4O1agLkDrigsMeuom//l9iG+pVHhkA7PSAFNxZiG6JUtaq3K+wtSO/ThzpJQ4qLsDmUCBKZiFyQhgixeDPhBDLLC/72sbqvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474353; c=relaxed/simple;
	bh=zqqqHoQN0IOy0urmSwgIR3OnMNrFGWquOW/a9tJziPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MobrvW6u890TGuYY76p27+IbduG15DgiyOMB0jGh4zC+ZR902eM+RC9rq5VqG9AT5vqWABSgRYk52pCJ3TW1H1sldzzaB4sn0JLZ3gg9/szT/KQvLzZhhSVduRFyFOIIda/kooB4pFcgRW1rPhl7yCKwVQUqTRlUh+mRidk0lw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDJPZLBD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716474351; x=1748010351;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zqqqHoQN0IOy0urmSwgIR3OnMNrFGWquOW/a9tJziPc=;
  b=GDJPZLBDt4dMaJpHfaOtdlw10CT+1DhJxSKFrPp8oJ+XgNzK5UbG1IIE
   7SvQb+7RtUYaJAqXIoFEiRPVWNsQK5K1fnKe4V5JO+v2iFYcL/VauLPHc
   9iUJl9BLsVBsFuA5bo2pMESXlL1CoTcEqnXsOou0XVROjxXZH95kzIpqb
   OP8zRNR0q4Q83bd96uxAq+UylVpbpwtbGs8UhyG4TYGyDzmJ16KtX+hKw
   74vD4PCjkmpixzyAEo9TzQtazphJQDYL8ED0Pi4FGNsDfHzZgV+IOHJnz
   c3l9YQc7usf4buGDt7+dZO7pNfCjA7IAJEiKp+G/4cjt7l/OOmt27vTmW
   w==;
X-CSE-ConnectionGUID: xZBI2lwHTDOltwLQ4uisDw==
X-CSE-MsgGUID: tkQeHVZmSv2qMpB/lKQqXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12645870"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12645870"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 07:25:50 -0700
X-CSE-ConnectionGUID: upTax8BhR1OmoZGEpAmUug==
X-CSE-MsgGUID: 3GrZC31vRBSSUieTtNvOqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33746896"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 07:25:48 -0700
Message-ID: <299a83e8-cb13-4599-9737-adb3bb922169@intel.com>
Date: Thu, 23 May 2024 07:25:47 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
To: Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 haiyangz@microsoft.com, hpa@zytor.com, kirill.shutemov@linux.intel.com,
 kys@microsoft.com, luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
 wei.liu@kernel.org, Jason@zx2c4.com, mhklinux@outlook.com,
 thomas.lendacky@amd.com, tytso@mit.edu, ardb@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tianyu.Lan@microsoft.com
References: <20240523022441.20879-1-decui@microsoft.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240523022441.20879-1-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/24 19:24, Dexuan Cui wrote:
...
> +static bool noinstr intel_cc_platform_td_l2(enum cc_attr attr)
> +{
> +	switch (attr) {
> +	case CC_ATTR_GUEST_MEM_ENCRYPT:
> +	case CC_ATTR_MEM_ENCRYPT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static bool noinstr intel_cc_platform_has(enum cc_attr attr)
>  {
> +	if (tdx_partitioned_td_l2)
> +		return intel_cc_platform_td_l2(attr);
> +
>  	switch (attr) {
>  	case CC_ATTR_GUEST_UNROLL_STRING_IO:
>  	case CC_ATTR_HOTPLUG_DISABLED:

On its face, this _looks_ rather troubling.  It just hijacks all of the
attributes.  It totally bifurcates the code.  Anything that gets added
to intel_cc_platform_has() now needs to be considered for addition to
intel_cc_platform_td_l2().

> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
...
> @@ -529,7 +530,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>  	 * CC_ATTR_MEM_ENCRYPT, aren't necessarily equivalent in a Hyper-V VM
>  	 * using vTOM, where sme_me_mask is always zero.
>  	 */
> -	if (sme_me_mask) {
> +	if (sme_me_mask || (cc_vendor == CC_VENDOR_INTEL && !tdx_partitioned_td_l2)) {
>  		r = set_memory_encrypted(vaddr, npages);
>  		if (r) {
>  			pr_warn("failed to free unused decrypted pages\n");

If _ever_ there were a place for a new CC_ attribute, this would be it.
It's also a bit concerning that now we've got a (cc_vendor ==
CC_VENDOR_INTEL) check in an amd.c file.

So all of that on top of Kirill's "why do we need this in the first
place" questions leave me really scratching my head on this one.

