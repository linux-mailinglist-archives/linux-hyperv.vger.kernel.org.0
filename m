Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0637791CF
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjHKO1W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 10:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjHKO1W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 10:27:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D41994;
        Fri, 11 Aug 2023 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691764042; x=1723300042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2vCwTTridOG7VbkPm4ww+fJhBWS9BaJG7T7rFExZ18=;
  b=C6BcD/l9PI33ajobCUELCxu5W5wKLLAqUAsliU9gKznIy5rp0etjbgJK
   oTNkz9IdlRLcM17jMpMuyy+lKwD5yX/eZE6TGuZAu0mqgFk+0IiZ5Ma+j
   LmrclXZ6zvzPFGYIizb/OuhDRyVNIvh3qc9UTXQEfIGF0/6Qwkp03RqMa
   UDUZ+Sfnx8/n0DG/PbBzVxAkMfF04YLEPT3HT1GjOgeRwSJqdftUutKUo
   phupKzxIEgCtj33veX5VGgPX9dvxmki5dXzdapweZZZ/bI7qscgFdwYiI
   s9AV9ryFbYYKhaBG1Xg0dofydwH5ZXnhMmlv1HTeK90qLm9Fp7F1g5khQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="458059684"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="458059684"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="798057992"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="798057992"
Received: from swetabs-mobl2.amr.corp.intel.com (HELO [10.212.220.8]) ([10.212.220.8])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:27:19 -0700
Message-ID: <f6d6cd65-011d-0f94-5db0-de4b2d35207e@intel.com>
Date:   Fri, 11 Aug 2023 07:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when
 needed
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
 <20230811021246.821-2-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230811021246.821-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/10/23 19:12, Dexuan Cui wrote:
> GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
> error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
> operation for the pages in the region starting at the GPA specified
> in R11.
> 
> When a fully enlightened TDX guest runs on Hyper-V, Hyper-V can return
> the retry error when set_memory_decrypted() is called to decrypt up to
> 1GB of swiotlb bounce buffers.

This changelog is not great.  It gives zero background and wastes bytes
on telling me which register the error code is in (I don't care in a
changelog) and then using marketing fluff words like "fully enlightened".

Let's stick to the facts, give some background, and also avoid
regurgitating the GHCI, eh?

How's this?

x86/tdx: Retry partially-completed page conversion hypercalls

TDX guest memory is private by default and the VMM may not access it.
However, in cases where the guest needs to share data with the VMM,
the guest and the VMM can coordinate to make memory shared between
them.

The guest side of this protocol includes the "MapGPA" hypercall.  This
call takes a guest physical address range.  The hypercall spec (aka.
the GHCI) says that the MapGPA call is allowed to return partial
progress in mapping this range and indicate that fact with a special
error code.  A guest that sees such partial progress is expected to
retry the operation for the portion of the address range that was not
completed.

Hyper-V does this partial completion dance when set_memory_decrypted()
is called to "decrypt" swiotlb bounce buffers that can be up to 1GB
in size.  It is evidently the only VMM that does this, which is why
nobody noticed this until now.


