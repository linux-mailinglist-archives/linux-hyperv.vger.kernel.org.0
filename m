Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEE720444
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjFBOXk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjFBOXg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 10:23:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DFD19A;
        Fri,  2 Jun 2023 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685715815; x=1717251815;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=NZvUiV0qFTexqljv69dCAZ3QmVO7Qx/hzIV8xDB/T78=;
  b=RkeCAqzRdstkjIty56lEVGYw/E/jlAQH3e0j87SpZ7wI/ZqrM2tDkUm1
   tT2OAe/jm0hGucpxe2uXpdw1MR5ZDpzGSyaDTNBnSiHZkh0H/wZcc/A5w
   xwUPCbb3TSQ9I9m4pBZJ75qHHetUe6uxs8yH2zd5cQMBV3+DGTFM5h6Y7
   euwl5mPTwZfcDdCrf0r9K1gfDKVCA89Szs2/2X9LvERIJKRhP3qhAEZ3R
   9oHNfZ1oBbrk/Mgi0FjuHK/iC9/Xeu7hYbdglChFuP+EFIDvCjCes7TIT
   8pgInQ9ZyJiOzp68TKOuhwRItUG6fpeJ0p4xAeDI4Pb038uv38dAGC52j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335492132"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="335492132"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="882091120"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="882091120"
Received: from pingshi-mobl.amr.corp.intel.com (HELO [10.251.23.169]) ([10.251.23.169])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:23:31 -0700
Message-ID: <e5ca0f92-0909-68af-16e0-582f47d8e424@intel.com>
Date:   Fri, 2 Jun 2023 07:23:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE disable for OF
 platforms
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
 <9b88ddaf-c5c5-0244-5be7-12400ee54e11@intel.com>
 <PUZP153MB074959D2F85EAD559ED7B544BE41A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <33d7800b-7870-6755-b057-f734fa7accd6@intel.com>
 <PUZP153MB074988C9F8F891533871173BBE46A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <13922610-b9bc-ab4b-8482-9aae238396c7@intel.com>
 <PUZP153MB07490EDED3B0194F5518B26EBE4EA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <PUZP153MB07490EDED3B0194F5518B26EBE4EA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/2/23 05:22, Saurabh Singh Sengar wrote:
> Furthermore, I would like to learn about the rationale behind disallowing the
> disablement of CONFIG_X86_MPPARSE when MP tables are not in use. Considering
> that we compile out the features we don't support, wouldn't it be acceptable to
> allow users to customize their configurations in this manner? Allowing the
> disablement of CONFIG_X86_MPPARSE would provide greater flexibility and
> efficiency for those who do not utilize MP tables.

If someone sent a patch, I'd certainly look and figure out what
"flexibility" and "efficiency" it would provide.  But, honestly, it
would just just be noise if it doesn't solve an _actual_ problem.

Would anyone care or notice the "flexibility" and "efficiency" it would
provide?
