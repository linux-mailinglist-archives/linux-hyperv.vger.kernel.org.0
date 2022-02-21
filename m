Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261394BDD7A
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 18:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiBUMFx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 07:05:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357241AbiBUMFs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 07:05:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D00201A7;
        Mon, 21 Feb 2022 04:05:25 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9FD41EC01A9;
        Mon, 21 Feb 2022 13:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645445119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G8yP8d3UkjcXD9ochKrIpwMp/vR+RVz3kP09JYxfJtE=;
        b=UQtOjBpObJD/bt7L3zvjvwkh0kLrD6l+caudCh4+dNXI2/g+LicZs+AJ4DbKLLTJYlqibY
        kkoTuMYT+u94uOIxxjkSQeo8fYov429fwf3aFvQtraA8WRz4Es1ZwN+PZYwVNStlHv/q+S
        gBpXi/WYdHPMxkbih3ICruVP/1h1OCs=
Date:   Mon, 21 Feb 2022 13:05:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCHv3.1 2/32] x86/coco: Explicitly declare type of
 confidential computing platform
Message-ID: <YhOAB1X+D82eEagt@zn.tnic>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <YhNyY5ErqQHZ961+@zn.tnic>
 <20220221114451.mljggcmadgvrrxbv@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221114451.mljggcmadgvrrxbv@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 21, 2022 at 02:44:51PM +0300, Kirill A. Shutemov wrote:
> Hm. Isn't 'vendor' too generic? It may lead to name conflict in the
> future.

It's a static variable visible only in this unit.

> What is wrong with cc_vendor here? I noticed that you don't like name of
> a variable to match type name. Why?

Because when I look at the name I don't know whether it is the type or a
variable of that type. Sure, sure, it depends on the context but let's
make it as non-ambiguous as possible.

> Currently cc_platform_has() relies on hv_is_isolation_supported() which
> checks for !HV_ISOLATION_TYPE_NONE. This is direct transfer to the new
> scheme. It might be wrong, but it is not regression.

I didn't say it is a regression - I'm just wondering why.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
