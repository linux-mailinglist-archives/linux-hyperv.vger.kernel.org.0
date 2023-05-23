Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C470E430
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjEWRxE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbjEWRxD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 13:53:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ED5BF;
        Tue, 23 May 2023 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684864383; x=1716400383;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=veXRV4fQJWwFomW+ZJt0gDZ9pkEtp2yXdbdqWI62QME=;
  b=JJEfrzaiAuzZtEsLNZ69zcxqacL/J1qfEpZrFTklaFLjPQa9XVCbSgul
   6qB5K6YRy54stEiYFfdFRrvyLGARA8+07Y8ztUTEQbnNwF3FMboCvqHjZ
   Gc/1Q1kSL1N1DI9YNXCixaadIO7QtvfEk7wp51hht/Yh+WntuWf4hXnJd
   Cz4l8GKRmmar7vDcldW6+49ZGDSQ8DzLbEw8q/bHGpLS9xOobOskVVmci
   O7AtHGyPKIc2cjIhvJKhNfpMt61OQrnXIBtwY9aAZo8vPSnzcwxF1TZNy
   bpEA7xEt0ro33wmQAQe5meTrs3LgKzBMRC+C0XpzbYnwFiTkU/pQGm2VL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416775829"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="416775829"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 10:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="703991278"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="703991278"
Received: from kroconn-mobl2.amr.corp.intel.com (HELO [10.251.1.84]) ([10.251.1.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 10:52:48 -0700
Message-ID: <9b88ddaf-c5c5-0244-5be7-12400ee54e11@intel.com>
Date:   Tue, 23 May 2023 10:52:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE disable for OF
 platforms
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     ssengar@microsoft.com
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
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

On 5/11/23 07:54, Saurabh Sengar wrote:
> X86_MPPARSE is only selectable when ACPI is enabled. However,
> on Devicetree platforms where ACPI is disabled, it is always
> enabled. Allow X86_MPPARSE to be selected by OF platforms as
> well.

I'm finding this changelog really hard to read.

In Kconfig, you can "select FOO".  But in this changelog, it means
something different.  I think "selectable" here means that there's a
user prompt for the option.

Could you please rephrase this to be less confusing?

This is also one of those patches where I wonder: Why do _you_ care
about this?  Are you just trying to be nice?  Is this intended as some
kind of cleanup?
