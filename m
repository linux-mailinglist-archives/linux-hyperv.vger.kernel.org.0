Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF9520801
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 00:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiEIWwl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiEIWwl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 18:52:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB9A2C4F44;
        Mon,  9 May 2022 15:48:43 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCDE41EC0505;
        Tue, 10 May 2022 00:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652136517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=slKbUtc69p2KeempozzbAIxM3x91fFs20DNMuiQjL9s=;
        b=FctVuGuw8dO9M2UMZWidY63HaTAL/Z6Wy2R/7wNB5j9cM7zG6mYf5CpKm17/Rg03+1ciJc
        ZfYk9YuM4qiOnENAKLJO73T3++amOiUAkxx3NGpQIXPm6QcQoVL90KViNeWNSgOXS4TdXN
        kJntPd637mwrgChYDiF8X7W8vIgibuk=
Date:   Tue, 10 May 2022 00:48:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, brijesh.singh@amd.com, venu.busireddy@oracle.com,
        michael.roth@amd.com, Tianyu.Lan@microsoft.com,
        thomas.lendacky@amd.com, jroedel@suse.de,
        michael.h.kelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        parri.andrea@gmail.com
Subject: Re: [PATCH] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Message-ID: <YnmaSB2WCJwqaZae@zn.tnic>
References: <20220505131502.402259-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220505131502.402259-1-ltykernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 05, 2022 at 09:15:02AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V Isolation VM code uses sev_es_ghcb_hv_call() to read/write MSR
> via GHCB page. The SEV-ES guest should negotiate GHCB version before
> reading/writing MSR via GHCB page.

Why is that?

> Expose sev_es_negotiate_protocol() and sev_es_terminate() from AMD SEV
> code

Yeah, you keep wanting to expose random SEV-specific code and when we
go and change it in the future, you'll come complaining that we broke
hyperv.

I think it might be a lot better if you implement your own functions:
for example, looking at sev_es_negotiate_protocol() - it uses only
primitives which you can use because, well, VMGEXIT() is simply a
wrapper around the asm insn and sev_es_wr_ghcb_msr() is simply writing
into the MSR.

Ditto for sev_es_terminate().

And sev_es_ghcb_hv_call() too, for that matter. You can define your own.

IOW, you're much better off using those primitives and creating your own
functions than picking out random SEV-functions and then us breaking
your isolation VM stuff.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
