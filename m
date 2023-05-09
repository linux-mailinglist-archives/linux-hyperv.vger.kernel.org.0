Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992086FD30D
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 May 2023 01:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjEIXgt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 May 2023 19:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEIXgs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 May 2023 19:36:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4FF0;
        Tue,  9 May 2023 16:36:47 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BA1D1EC0338;
        Wed, 10 May 2023 01:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683675405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5lxz18Yo5hMImpwUjevLsHYDBAq+H3HMlQ4JsgvZNfQ=;
        b=ViBwKc/E9IwalgWRG3DAMDt1hENvVWCAvfGWo6kvQLcZaCN/W2U+PshsC+Sx7GbxRQ37Ra
        jHwik+DHKo+xHqa20cn0nYZe9SzXWFt4Kl9kgOWriVsLyd3kk0m9fU0QJL5+ZgYsnH7c4M
        Pq3h+M+VcNVK8HRaDnJtcn8Stpmew8s=
Date:   Wed, 10 May 2023 01:36:41 +0200
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
Message-ID: <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 09, 2023 at 10:14:37PM +0200, Borislav Petkov wrote:
> On Tue, May 02, 2023 at 02:09:15PM +0200, Juergen Gross wrote:
> > This series tries to fix the rather special case of PAT being available
> > without having MTRRs (either due to CONFIG_MTRR being not set, or
> > because the feature has been disabled e.g. by a hypervisor).
> 
> More weird stuff. With the series:

Yah, that was me.

That ->enabled thing is *two* bits. FFS.

More staring at this tomorrow, on a clear head.

diff --git a/arch/x86/include/uapi/asm/mtrr.h b/arch/x86/include/uapi/asm/mtrr.h
index a28e6bbd8f21..f476a1355182 100644
--- a/arch/x86/include/uapi/asm/mtrr.h
+++ b/arch/x86/include/uapi/asm/mtrr.h
@@ -84,7 +84,7 @@ typedef __u8 mtrr_type;
 struct mtrr_state_type {
 	struct mtrr_var_range var_ranges[MTRR_MAX_VAR_RANGES];
 	mtrr_type fixed_ranges[MTRR_NUM_FIXED_RANGES];
-	bool enabled;
+	unsigned char enabled;
 	bool have_fixed;
 	mtrr_type def_type;
 };

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
