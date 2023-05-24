Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D181A70FD64
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 May 2023 20:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjEXSCY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 May 2023 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjEXSCX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 May 2023 14:02:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51712E;
        Wed, 24 May 2023 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684951342; x=1716487342;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0Qgjez3azYWXKRDMwPKOvjl8Rsxp+siO8MztZ6+bs+8=;
  b=h0Wx38qxd+MzDl8NBP8JGw167yG6420HqOQFM2SHWy3RWbYLQGOA5qwA
   HJtThYI+kKgEQV/uacFKz6Xyu9Mrvo1SPiNE8LKhqNhmgmVASBuzLjQK5
   Iky63oQfGZ21Lq30ltC/2MVb7gB1djSjMAI+BqYOIglys0KSRpvW8008Q
   3QwS022M2WjNwOf6rUcN8ukfKcnfHIClRxudmObioM3tzKFWPo0Gqrbv8
   nK7snQf72rZLmI93qK1bgGceYwJhsf1AIIMl4UWa9G6+ud+hjw00cZteW
   4kwnci/tA4/80m+29FD8duBgJ7PtF1mBONn+geOGimFQqj5Z0+PvySUO7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440006148"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="440006148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 11:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="737407519"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="737407519"
Received: from kknopp-mobl1.amr.corp.intel.com (HELO [10.212.186.147]) ([10.212.186.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 11:02:11 -0700
Message-ID: <33d7800b-7870-6755-b057-f734fa7accd6@intel.com>
Date:   Wed, 24 May 2023 11:02:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <PUZP153MB074959D2F85EAD559ED7B544BE41A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/24/23 09:23, Saurabh Singh Sengar wrote:
>> Could you please rephrase this to be less confusing?
> 
> Thanks for your review. Currently, in the absence of ACPI, it is impossible to
> disable X86_MPPARSE. In the case of ACPI being enabled, one has the
> option to either enable or disable X86_MPARSE. My intention is to permit
> X86_MPPARSE=n for OF platforms where ACPI=n. To describe the capability
> of choosing any desired value for MPPARSE, I used the term 'selectable.'
> Perhaps 'configurable' would be a more appropriate word in this context?
> I can fix this and include it in V2.

OK, so this particular Hyper-V setup doesn't run normal normal distro
kernels?  It requires a very specialized kernel?  Or it's just _better_
that the kernel is configured this way?

>> This is also one of those patches where I wonder: Why do _you_ care about
>> this?  Are you just trying to be nice?  Is this intended as some kind of cleanup?
> 
> It solves an issue for Hyper-V VBS setup, please refer to the 2/2 of this patch
> series.

Heh, that changelog is even more confusing than _this_ one.  It doesn't
say that there's a problem, only that it removes "not required" code.

I'm still confused by this whole thing.
