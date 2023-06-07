Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F57725D18
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jun 2023 13:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjFGL3w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Jun 2023 07:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbjFGL3o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Jun 2023 07:29:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3331993;
        Wed,  7 Jun 2023 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686137383; x=1717673383;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UwqTTS8un7pHNkC69VKFGHnWNTgBVFRY5wjuGB303Rc=;
  b=dDr0OsfmrLRQvikbhXF64uOfpYsolGxJpkgxhYgWx8nsmbANBhwCeHJf
   KuNnBqGc940JizB5mLWY3ALmh81E73Qp/WVLCqX7fVUOs4Rwa22o7Frrn
   HR5sIBR0lMJ/r+JG86Z9uuxdKWMxy41z+EMrM0v0ke99K3tLklMIxdEaW
   FgahT7s6GwEE4+mv/X1Iejs/T8k2TJeaqcWa+IxdXkIhIMismpS71wybk
   3QWmGkDQ10QZr9ggBsTi8SDxZD+beEVysxyY6r416OBg2SBDfjn6/3GmP
   fPWk4hRgO74oJbaYbS0faHZ+LTyIZdAwDOeVk/VqObK0kIprpu9bfTJxo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385278967"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="385278967"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="742625613"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="742625613"
Received: from vsmyers-mobl2.amr.corp.intel.com (HELO [10.212.146.233]) ([10.212.146.233])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:27:55 -0700
Message-ID: <aa9cd68b-645b-d997-e327-dc8335de913e@intel.com>
Date:   Wed, 7 Jun 2023 04:27:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/hyperv: Trace hv_set_register()
Content-Language: en-US
To:     Nischala Yelchuri <niyelchu@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tyler Hicks <code@tyhicks.com>, boqun.feng@gmail.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nischala Yelchuri <niyelchu@microsoft.com>
References: <1686101757-23985-1-git-send-email-niyelchu@linux.microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1686101757-23985-1-git-send-email-niyelchu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/6/23 18:35, Nischala Yelchuri wrote:
>  void hv_set_register(unsigned int reg, u64 value)
>  {
> +	trace_hyperv_set_register(reg, value);
> +
>  	if (hv_nested)
>  		reg = hv_get_nested_reg(reg);

I can't help but wonder if this is just a patch for people that don't
know how to set kprobes.
