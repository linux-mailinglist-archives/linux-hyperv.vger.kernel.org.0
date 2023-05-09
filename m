Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123AE6FCF3B
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 May 2023 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjEIUOo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 May 2023 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEIUOn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 May 2023 16:14:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98348106;
        Tue,  9 May 2023 13:14:42 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E5041EC051E;
        Tue,  9 May 2023 22:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683663281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8FPEI6O6QAK3kRZvBqgdS/NqiP5GyoVTXmMIcWstwBU=;
        b=n6OGzuOgVvJpy46SSxzCzljQXgU88uLFdQj2tc18ANXJPJ/n6DZlbqX2Ya1zBVzJP82imI
        IzJlBM+TdVBQJB0VJYtKy4Jsd+Pjk9LIoJnvGZ5lLIkJansEWD5y7tusJyVZlQ3232xtIz
        IdrfYuxRa58gLxRAKyiKW9shhR18t08=
Date:   Tue, 9 May 2023 22:14:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
Message-ID: <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 02, 2023 at 02:09:15PM +0200, Juergen Gross wrote:
> This series tries to fix the rather special case of PAT being available
> without having MTRRs (either due to CONFIG_MTRR being not set, or
> because the feature has been disabled e.g. by a hypervisor).

More weird stuff. With the series:

[root@vh: ~> cat /proc/mtrr 
cat: /proc/mtrr: Input/output error

before:

[root@vh: ~> cat /proc/mtrr 
reg00: base=0x000000000 (    0MB), size= 2048MB, count=1: write-back
reg01: base=0x080000000 ( 2048MB), size= 1024MB, count=1: write-back
reg02: base=0x0c0000000 ( 3072MB), size=  256MB, count=1: write-back
reg03: base=0x0ff000000 ( 4080MB), size=   16MB, count=1: write-protect

I think it wrongly determines that MTRRs are disabled by BIOS:

MTRRs disabled by BIOS
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT

which is obviously wrong.

But more debugging later.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
