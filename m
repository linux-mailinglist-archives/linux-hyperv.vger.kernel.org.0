Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0908710DB0
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 May 2023 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbjEYN4P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 May 2023 09:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbjEYN4O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 May 2023 09:56:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6AD186;
        Thu, 25 May 2023 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685022972; x=1716558972;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gUhiFPchgWyeHeR6vpngEYZDAoF6lLu30ZSMdDh296U=;
  b=n7fW2eBhgenDdGRE85iz41FCRbWQWWU8w43UddOMPEAQ6mzmPUlG5wMi
   9ce1YHwdbcajzTXtc7012ZUfcBab9oUYbNspAUMqwi7YV+IiVKMdwzQ8v
   HhwE8dRHDuaMNPfnajm4CiHMJtczF7pPlOLcULkA2A+kRCn7unV73Mfle
   oYgJMfL1sTl9AZ9ubEXrmtYQPZJ4Ua8d5qAZEstXCzAcwiKBdFGkRAtn5
   tJJW1vsnQ+tVfiRTKqUI39UoHhwHia7nrex8XUva/dA8z6mCDCV96p04G
   1fl/KG/UBl4thGx9llLCjjlMkGNHDbM2WzTs8nDbiHaal0KvQ+9gqKpOu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="440245113"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="440245113"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 06:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="794687234"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="794687234"
Received: from shuklaas-mobl1.amr.corp.intel.com (HELO [10.212.186.148]) ([10.212.186.148])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 06:56:11 -0700
Message-ID: <13922610-b9bc-ab4b-8482-9aae238396c7@intel.com>
Date:   Thu, 25 May 2023 06:56:10 -0700
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
 <33d7800b-7870-6755-b057-f734fa7accd6@intel.com>
 <PUZP153MB074988C9F8F891533871173BBE46A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <PUZP153MB074988C9F8F891533871173BBE46A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/25/23 00:06, Saurabh Singh Sengar wrote:
> When CONFIG_X86_MPPARSE is enabled, the kernel will scan low memory,
> looking for MP tables. In Hyper-V VBS setup, lower memory is assigned to VTL0.
> This lower memory may contain the actual MPPARSE table for VTL0,
> which can confuse the VTLx kernel and cause issues. (x > 0)

This still just seems wrong.

If an action crashes the kernel because of changes, we don't just
compile it out and move on.  We add enumeration for the new feature
that's causing it and turn off the action at runtime.


