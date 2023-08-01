Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDA76BF88
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjHAVwo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 17:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAVwn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 17:52:43 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA4103;
        Tue,  1 Aug 2023 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690926762; x=1722462762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5sHOU4Cn8TkmWYf2IYukgzv5xFMwg7J56eVFkkNFJLY=;
  b=bNT7mqYUMRmpD7x2+Bo0ORyT6yY0IP4jwEG5jJlBjeRfJd926RdzVC7R
   s+GbyNNoUnAxsYDwwjvIqp5V79obOTyVd1l6xmIvJ3L1BiggDG391ChgE
   ONLleFk8lvnmoeKjF+nKulo5h03lIr6JIpWr0fvMFMop9yLfRUVQ6Rh4a
   Qw6wEH9CfrqQe/udkHu4+t6+yFJh5/5kYR6gJGC9QHWXU+yC09uOZFa9J
   u8irEt8s3csqKKIuGWYDxMK/jhMCu4ZXBvv/rkqgiUMZ11c3prwA1ofkN
   996xkzdoQ8AI1hU+yubuQi1kupffVRuqUc8aFgD8M235N7vYtSIrQPMQf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349724999"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="349724999"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 14:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732141568"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="732141568"
Received: from csegura-mobl1.amr.corp.intel.com (HELO [10.255.229.110]) ([10.255.229.110])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 14:52:29 -0700
Message-ID: <1b97ea8f-84fe-ac3c-7492-4d1675f7f074@intel.com>
Date:   Tue, 1 Aug 2023 14:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v3] x86/hyperv: add noop functions to
 x86_init mpparse functions
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com>
 <ZJx02GzzoQ9E1TH9@liuwe-devbox-debian-v2>
 <PUZP153MB06357202BB90D434C909DE8CBE3FA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <PUZP153MB06357202BB90D434C909DE8CBE3FA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/21/23 05:58, Saurabh Singh Sengar wrote:
>> On Fri, Jun 23, 2023 at 09:28:08AM -0700, Saurabh Sengar wrote:
>>> Hyper-V can run VMs at different privilege "levels" known as Virtual
>>> Trust Levels (VTL). Sometimes, it chooses to run two different VMs at
>>> different levels but they share some of their address space. In such
>>> setups VTL2 (higher level VM) has visibility of all of the
>>> VTL0 (level 0) memory space.
>>>
>>> When the CONFIG_X86_MPPARSE is enabled for VTL2, the VTL2 kernel
>>> performs a search within the low memory to locate MP tables. However,
>>> in systems where VTL0 manages the low memory and may contain valid
>>> tables, this scanning can result in incorrect MP table information
>>> being provided to the VTL2 kernel, mistakenly considering VTL0's MP
>>> table as its own
>>>
>>> Add noop functions to avoid MP parse scan by VTL2.
>>>
>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Hi Dave, are you happy with the commit message?
> HI Dave,
> 
> If there is no concern, can I get your ack

Looks sane:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Although, if you muck with this any more having actual facts on what the
"incorrect MP table information" causes would be nice too.
