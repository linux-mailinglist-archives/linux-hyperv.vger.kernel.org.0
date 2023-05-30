Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309297166FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 May 2023 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjE3P2i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 May 2023 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjE3P2h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 May 2023 11:28:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FBDC5;
        Tue, 30 May 2023 08:28:32 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17E8F1EC0411;
        Tue, 30 May 2023 17:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685460510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7wMkihUDACMyxG5NoWweKMDlr/7la1a8uhQ7N10j4Jg=;
        b=mRke7Bdnd6HC68Ll3Z22g/XU5cqrYW9/4I7rc9xVly+dj2IbILa2Ojd4dlSH6Zmjq1e4U2
        rGgnl547wL6ZH1lBB62dbox0EFY8N1L6Wos2avbZxDKD28UgfJetes2/b3kFH8PkvJev6U
        D8v8dNzkW0mu3Ye1MfrTXEUa4/CHPgE=
Date:   Tue, 30 May 2023 17:28:25 +0200
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
Message-ID: <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 22, 2023 at 04:17:50PM +0200, Juergen Gross wrote:
> The attached diff is for patch 13.

Merged and pushed out into same branch.

Next issue. Diffing /proc/mtrr shows:

--- proc-mtrr.6.3	2023-05-30 17:00:13.215999483 +0200
+++ proc-mtrr.after	2023-05-30 16:01:38.281997816 +0200
@@ -1,8 +1,8 @@
 reg00: base=0x000000000 (    0MB), size= 2048MB, count=1: write-back
-reg01: base=0x080000000 ( 2048MB), size=  512MB, count=1: write-back
+reg01: base=0x080000000 ( 2048MB), size= 1024MB, count=1: write-back
 reg02: base=0x0a0000000 ( 2560MB), size=  256MB, count=1: write-back
 reg03: base=0x0ae000000 ( 2784MB), size=   32MB, count=1: uncachable
-reg04: base=0x100000000 ( 4096MB), size= 4096MB, count=1: write-back
+reg04: base=0x100000000 ( 4096MB), size=  256MB, count=1: write-back
 reg05: base=0x200000000 ( 8192MB), size= 8192MB, count=1: write-back
 reg06: base=0x400000000 (16384MB), size= 1024MB, count=1: write-back
 reg07: base=0x440000000 (17408MB), size=  256MB, count=1: write-back

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
