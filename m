Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8B72063F
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjFBPdV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbjFBPdT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 11:33:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FFDE40;
        Fri,  2 Jun 2023 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685719994; x=1717255994;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FJbFB7X8TTc27c3o4L4N59l7VLIbURcwFaTm2eNStOg=;
  b=fG3Rhksd/Bs8vQ+BIY6Qzjj6cgHwK9KmkOPdUNFO9r1/MPIQSGOnwBEC
   vw5P9hH7as7sHadxQ2ouMhNfv+X53VHdBpRP2K5IUr7z+TVR5lCSsd7Zm
   rc3ZbXPnae2xtv/mblJJyMIIvA9+QHjOsZrSCkJgGmaJT8cR0CLW22zZi
   rYCa+S/grJtdEV+9Xl0OIKlgtj/M3o3thtKLjSao2Lop/9pfPU72OAnCq
   EWXKerPfy4H2bGLLfBYaMq0Q8jmseaoSUuj3dtiGIWWWH6FS1Bxjheha5
   CRJ3Z3GdqyRybRUHksYefnJyHWwfCohia37V92nVod8giVAB3+JC67T20
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="358326819"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="358326819"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="740864184"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="740864184"
Received: from pingshi-mobl.amr.corp.intel.com (HELO [10.251.23.169]) ([10.251.23.169])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 08:33:13 -0700
Message-ID: <442441b3-803e-0c1f-ff1b-5a49ecc2e423@intel.com>
Date:   Fri, 2 Jun 2023 08:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/hyperv: add noop functions to x86_init mpparse
 functions
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
References: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/2/23 05:41, Saurabh Sengar wrote:
> In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE.
> When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel will
> scan low memory looking for MP tables. Don't allow this, because
> low memory is controlled by VTL0 and may contain actual valid
> tables for VTL0, which can confuse the VTL2 kernel.

Do you folks have a writeup of this VTL* setup anywhere?  I'm struggling
to grasp why VTL0 and VTL2 share the same address space and why they
would get confused by each other's data structures.

$ grep -r VTL[02] Documentation/
$

Either way, this is way better than the #ifdefs.  But the changelog is
kinda just gibberish to me.
