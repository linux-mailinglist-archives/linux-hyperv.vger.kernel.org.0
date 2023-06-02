Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986BF72076E
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbjFBQWv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 12:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbjFBQWs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 12:22:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836A197;
        Fri,  2 Jun 2023 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685722952; x=1717258952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8SiuwRjOVa0SsobcOzLPmh2lj5ARFE5qrlu9m+PPYpo=;
  b=FFQ7HHjUI2VhRgMYdsHDooBDHU9nWaFGt3ECUCPiVotPsZ9TB/JnMETT
   17gis2LcRA2JrB/yVU8djQJQMkWGcUqRmE4EqLN7P6RRBKVhESUuB2EsP
   /edM87RK+HgF9jkFHagL0Chm7F9WOYBozjD28BeN6LXBB56BghafYHbyd
   9fGTonwu/F53IhPdbgfaA5r2DijuA3cz9A6iSJo8VIW5vLmqfQFYrX1l7
   1HFlpiBIN4qSbxELYuRDJi4EO7Lj2Rm2WJgUlWtYBE4akdJxB+AjV8s1H
   88Z7BXobeIL2Xzm2q6j7HLJEKfLbGm8j7LiT6/5+XKiv7F9IJdTDd68zT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354759133"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="354759133"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832034796"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="832034796"
Received: from pingshi-mobl.amr.corp.intel.com (HELO [10.251.23.169]) ([10.251.23.169])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:21:47 -0700
Message-ID: <67a9a33c-1aa3-34ea-3e78-06301104773d@intel.com>
Date:   Fri, 2 Jun 2023 09:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/hyperv: add noop functions to x86_init mpparse
 functions
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        hpa@zytor.com
References: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
 <442441b3-803e-0c1f-ff1b-5a49ecc2e423@intel.com>
 <ZHoWN1TYicOSGsd3@liuwe-devbox-debian-v2>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZHoWN1TYicOSGsd3@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/2/23 09:17, Wei Liu wrote:
> On Fri, Jun 02, 2023 at 08:33:13AM -0700, Dave Hansen wrote:
>> On 6/2/23 05:41, Saurabh Sengar wrote:
>>> In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE.
>>> When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel will
>>> scan low memory looking for MP tables. Don't allow this, because
>>> low memory is controlled by VTL0 and may contain actual valid
>>> tables for VTL0, which can confuse the VTL2 kernel.
>> Do you folks have a writeup of this VTL* setup anywhere?  I'm struggling
>> to grasp why VTL0 and VTL2 share the same address space and why they
>> would get confused by each other's data structures.
> Dave, here is some public information about Virtual Trust Level.
> 
> https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm#virtual-trust-level-vtl

Yeah, I can google too. ;)

Seriously, though.  I don't need an architecture document.  This is like
me asking how NMIs work in Linux and someone pointing me to the SDM
describing the hardware architecture.

I need to know about the Linux implementation of these VTL's, not the
overall VTL architecture.
