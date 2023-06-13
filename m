Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AA72E9F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jun 2023 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbjFMRda (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jun 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbjFMRdO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jun 2023 13:33:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17051BFD;
        Tue, 13 Jun 2023 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686677589; x=1718213589;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kaaQfVZjsi6nPisz9n/bF0zoS0o4mv4awPemaC1m2E0=;
  b=MuATKvqiQtQoZmZf9Y7WLfLFLYrl98KQ2rxe+13Q9EfGDXXw2p0VIf7A
   5Vb6p+d6HnxUObFK59twU0r2JvlZO094UW7ck08X1iys3V1L335iUN+ZZ
   PlXw7SJAH3AbomCaUWHQrs+MqTcgiwCR/Na8TxS7FZeJhYZtXy8qFBqRD
   DG+ZM+0hXVjL0AYdIphTMptRtTzWGhyOkc0EK1Bqqd4Z8CYK90K2ai+JW
   miJBlW7Mz9jFC+GXC4Tkj64R2SQiWZ0tyjgObNhq0JerGgC122yn1FzbT
   Auuz1oqqeIt8IWSMhYiOgKjYg5Dc5BegKkVNpjkLKttQBy2J86iGNMhGS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="358405660"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="358405660"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 10:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="776917221"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="776917221"
Received: from clin147-mobl.amr.corp.intel.com (HELO [10.212.134.227]) ([10.212.134.227])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 10:33:08 -0700
Message-ID: <23749756-022a-5574-af4d-a4a03d9542e1@intel.com>
Date:   Tue, 13 Jun 2023 10:33:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/hyperv: add noop functions to x86_init mpparse
 functions
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
References: <1686640391-13001-1-git-send-email-ssengar@linux.microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1686640391-13001-1-git-send-email-ssengar@linux.microsoft.com>
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

On 6/13/23 00:13, Saurabh Sengar wrote:
> In certain configurations, VTL0 and VTL2 can share the same VM
> partition and hence share the same memory address space. In such
> systems VTL2 has visibility of all of the VTL0 memory space.

FWIW, this is pretty much gibberish to me.  The way I suggest avoiding
producing gibberish is avoiding acronyms:

	Hyper-V can run VMs at different privilege "levels".  Sometimes,
	it chooses to run two different VMs at different levels but
	they share some of their address space.  This <insert reason
	that someone might want to do this>.

That's not gibberish.

> When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel performs
> a scan of low memory to search for MP tables. However, in systems
> where VTL0 controls the low memory and may contain valid tables
> specific to VTL0, this scanning process can lead to confusion
> within the VTL2 kernel.

What is the end-user-visible effect of this "confusion"?  A crash?  A
warning?  An error message?  What is the impact on end users?

This information will help the maintainers decide how to disposition
your patch.  Should we send it upstream immediately because it's
impacting millions of users?  Or can we do it in a bit more leisurely
fashion because nobody cares?

> In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE
> hence add the noop function instead.

This makes zero sense to me.

Like I told you before, we don't compile things out just because they
don't work on one weirdo system.  If we did that, we'd have a billion
incompatible x86 kernel images that can't boot across systems.


