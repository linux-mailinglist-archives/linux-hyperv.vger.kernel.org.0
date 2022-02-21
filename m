Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62D64BEBBA
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 21:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiBUUUw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 15:20:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiBUUUu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 15:20:50 -0500
X-Greylist: delayed 33190 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 12:20:27 PST
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3581A399;
        Mon, 21 Feb 2022 12:20:27 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90EE41EC0528;
        Mon, 21 Feb 2022 21:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645474821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zDIc3xVfWbo5IjAWvE1tHZ9pOiAa0b5qEOmvm2R1bzY=;
        b=qzH19tZ0NaCE5i1oWt38rEc81Idc+VMM/750Es4yLy3SK/SHSi10wRAG+kJs7qTHc5aRhj
        /6+oKt7MKDLC3ZpOS5+dQLKjnUSakPnTc/UaemiU8w33yFvvc8A57gf3DSyjSh/hD4svLt
        bdTx4EgrJK0lf/Hlgzqep8+noDYY34Y=
Date:   Mon, 21 Feb 2022 21:20:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv3.1 2/32] x86/coco: Explicitly declare type of
 confidential computing platform
Message-ID: <YhP0CY0Gdepgnz4f@zn.tnic>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <YhNyY5ErqQHZ961+@zn.tnic>
 <20220221135258.4qcpt6i2zaou7ygm@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221135258.4qcpt6i2zaou7ygm@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 21, 2022 at 01:52:58PM +0000, Wei Liu wrote:
> Hi Boris and Kirill, I only see VBS mentioned here so I don't have much
> context, but VBS likely means virtualization-based security. There is a
> public document for it.
> 
> https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-vbs
> 
> Whether it needs a new isolation type or not, I am not sure. Perhaps
> Tianyu can provide more context.

Right, this came in with

  c789b90a6904 ("x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()")

which says

    Hyper-V provides Isolation VM for confidential computing support and
    guest memory is encrypted in it. Places checking cc_platform_has()
    with GUEST_MEM_ENCRYPT attr should return "True" in Isolation VM.

I'm guessing this was done because you "need to adjust the SWIOTLB size
just like SEV guests."

So my question is, does this VBS thing do guest memory encryption or
does it only use hw virt features?

Because you guys have HV_ISOLATION_TYPE_SNP already. And so, the check

	 hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;

includes VBS because VBS is only interested in the SWIOTLB buffer size
adjustment and not the rest of the cc_* stuff. Or?

But let's see what Tianyu says.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
