Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC136FDE8F
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 May 2023 15:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjEJNac (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 May 2023 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbjEJNab (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 May 2023 09:30:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206561B2;
        Wed, 10 May 2023 06:30:29 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C15A1EC066E;
        Wed, 10 May 2023 15:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683725428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Oc3RW44mGf8OYw/mNzGyRLjYbfWEFY3fZ/ETgZKmRPc=;
        b=jV4B4Iueyphgm33/i6nlFz+SYXoKsBUzU8Ri7y4TYU68qN7/dmfMJlbK1MNpXw1TR90Kpl
        d1/rbYqm0aRl90Tzw/hOuuMoNnSYbkigi+LV1eHzl3IeCJdrbGH/onF7EABu+OV28GcY+p
        ZJ+8upyZumiT7YyvTUED0tVtgBdB47U=
Date:   Wed, 10 May 2023 15:30:24 +0200
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
Message-ID: <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 10, 2023 at 01:36:41AM +0200, Borislav Petkov wrote:
> More staring at this tomorrow, on a clear head.

Yeah, I'm going to leave it as is. Tried doing a union with bitfields
but doesn't get any prettier.

Next crapola:

The Intel box says now:

[    8.138683] sgx: EPC section 0x80200000-0x85ffffff
[    8.204838] pmd_set_huge: Cannot satisfy [mem 0x80200000-0x80400000] with a huge-page mapping due to MTRR override, uniform: 0

(I've extended the debug output).

and that happens because

[    8.174229] mtrr_type_lookup: mtrr_state_set: 1
[    8.178909] mtrr_type_lookup: start: 0x80200000, cache_map[3].start: 0x88800000

that's

	 if (start < cache_map[i].start) {

in mtrr_type_lookup(). I fail to see how that check would work for the
range 0x80200000-0x80400000 and the MTRR map is:

[    0.000587] MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variable MTRRs
[    0.000588]   0: 0000000000000000-000000000009ffff write-back
[    0.000589]   1: 00000000000a0000-00000000000bffff uncachable
[    0.000590]   2: 00000000000c0000-00000000000fffff write-protect
[    0.000591]   3: 0000000088800000-00000000ffffffff uncachable

so the UC range comes after this one we request.

[    8.186372] mtrr_type_lookup: type: 0x6, cache_map[3].type: 0x0

now the next type merging happens and the 3rd region's type is UC, ofc.

[    8.192433] type_merge: type: 0x6, new_type: 0x0, effective_type: 0x0, clear uniform

we clear uniform and we fail:

[    8.200331] mtrr_type_lookup: ret, uniform: 0

So this map lookup thing is wrong in this case.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
