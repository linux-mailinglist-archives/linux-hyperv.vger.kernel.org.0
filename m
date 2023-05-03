Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338626F5EF7
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 May 2023 21:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjECTNF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 May 2023 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjECTNE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 May 2023 15:13:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4179E7AAF;
        Wed,  3 May 2023 12:13:03 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B681A1EC0674;
        Wed,  3 May 2023 21:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683141181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L/8fxhHQV9gUmxp73tGqFoK9bK/rX7AQ4vVPU8ZIH0I=;
        b=KcU0BTLrM12dhsRj+QLZSG0/+RmUKUiYJfiYee8JlzdiNbgVFD/LmgeqgPH66sbzspCphX
        bqQXAAnTIVKkGkWa5UKHtB5PoYSIhviQ5VRtBo8QE52D5xzSpgI5rqz3rUcKRpD07YdiXO
        lnMXaXWkqPpgYFEw1Wfi0/RkoaQnTVI=
Date:   Wed, 3 May 2023 21:12:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     Juergen Gross <jgross@suse.com>, mikelley@microsoft.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
Message-ID: <20230503191256.GGZFKyOLi12JS/HuXD@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <26e6947c-6c56-d8c0-1baf-1ff006258679@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26e6947c-6c56-d8c0-1baf-1ff006258679@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 03, 2023 at 11:14:25AM -0700, Sohil Mehta wrote:
> A Nit -> Documentation/process/maintainer-tip.rst suggests:
> "The condensed patch description in the subject line should start with a
> uppercase letter and ..."

Yeah, good point.

But my patch massaging script does that automatically so no need to
resend.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
