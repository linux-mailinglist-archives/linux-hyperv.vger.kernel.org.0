Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E765A77916A
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 16:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHKOJn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKOJn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 10:09:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F5EA;
        Fri, 11 Aug 2023 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691762982; x=1723298982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gcX2U+aKm/ntgbNmPwXB5cQkjSeRqXXyRXtp93z+H2c=;
  b=M4rj8asZGG+XS2AHSjtCEkl8DReiHfnjRgSly5eyKptanJqf+IggpNxz
   Hhw0UOmM6s1hweWZ0bP96F8jSVxlI1NwRgVqGaarJQ+fD4lp19iUliCQU
   Rqd9CAfOmnBjq26uRaOBLl0PTSY+pPc7e2gSmyvT/OBbYs/1DpEIH9w+8
   8CoAD4sT4t62MgVW8823vmthNYn9SJna+dJShKKWSB/jnwVGktfUBZCI6
   iZW3iiE7YegggoKfLaSDBBsfhw7wiUN+ceHEUDclzgLZ4IUjAO/tLk20g
   YD40VqFKVTw1u/PNczG2Doo+H2ZJuI3TrwaCP0p6i8jYK3O2nNFNRYW4l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351285707"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351285707"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="762207995"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="762207995"
Received: from swetabs-mobl2.amr.corp.intel.com (HELO [10.212.220.8]) ([10.212.220.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:09:41 -0700
Message-ID: <69b46bf3-40ab-c379-03d5-efd537ed44c7@intel.com>
Date:   Fri, 11 Aug 2023 07:09:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v9 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
        ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu.Lan@microsoft.com, rick.p.edgecombe@intel.com,
        andavis@redhat.com, mheslin@redhat.com, vkuznets@redhat.com,
        xiaoyao.li@intel.com
References: <20230811021246.821-1-decui@microsoft.com>
 <20230811021246.821-3-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230811021246.821-3-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/10/23 19:12, Dexuan Cui wrote:
> +	if (!is_vmalloc_addr((void *)start))
> +		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);
> +
> +	while (start < end) {
> +		phys_addr_t start_pa = slow_virt_to_phys((void *)start);
> +		phys_addr_t end_pa = start_pa + PAGE_SIZE;
> +
> +		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
> +			return false;
> +
> +		start += PAGE_SIZE;
> +	}

This creates two different paths for vmalloc() and the direct map.
There are two different ways to do va=>pa conversion, for instance.
Here's a single loop that works for both cases:

	unsigned long step = end - start;
	unsigned long addr;

	/* Step through page-by-page for vmalloc() mappings: */
	if (is_vmalloc_addr((void *)vaddr))
		step = PAGE_SIZE;

	for (addr = start; addr < end; addr += step) {
		phys_addr_t start_pa = slow_virt_to_phys(addr);
		phys_addr_t end_pa   = start_pa + step;

		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
			return false;
	}

Note that this also doesn't abuse 'start' by making it a loop variable.
It also, uh, uses a for() loop.

The only downside is that it costs a page table walk for direct map
virt=>phys conversion.  I can live with that.
