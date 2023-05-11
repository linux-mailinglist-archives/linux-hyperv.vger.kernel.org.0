Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C536FF767
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 May 2023 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjEKQc6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 May 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjEKQc5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 May 2023 12:32:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0A9017;
        Thu, 11 May 2023 09:32:20 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9DC31EC041F;
        Thu, 11 May 2023 18:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683822731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dygT3SQ1Awb918Yj04yvCpz0F75Gt7jJXYbHPMQO368=;
        b=R5T5ei9aRn2WmdaOiQI0b3lTEpke8mwH+YA13JUw69yB2L7ZadnZ0U2BTvfGyaOHt4JfRC
        3Aoy+LxV7mQkAih2yejm5Zzwfnof6sebecZ/7cyw7rLXxwO+GHLihccOrl0u8gG8MDSzAm
        XmteUQ7nficYxQuDo4lTodt4dy/cl80=
Date:   Thu, 11 May 2023 18:32:08 +0200
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
Message-ID: <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 10, 2023 at 05:53:15PM +0200, Juergen Gross wrote:
> Urgh, yes, there is something missing:
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index 031f7ea8e72b..9544e7d13bb3 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -521,8 +521,12 @@ u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
>         for (i = 0; i < cache_map_n && start < end; i++) {
>                 if (start >= cache_map[i].end)
>                         continue;

So the loop will go through the map until...

> -               if (start < cache_map[i].start)
> +               if (start < cache_map[i].start) {

... it reaches the first entry where that is true.

>                         type = type_merge(type, mtrr_state.def_type, uniform);

the @type argument is MTRR_TYPE_INVALID, def_type is WRBACK so what
this'll do is simply get you the default WRBACK type:

type_merge:
        if (type == MTRR_TYPE_INVALID)
                return new_type;

> +                       start = cache_map[i].start;
> +                       if (end <= start)
> +                               break;

Now you break here because end <= start. Why?

You can just as well do:

	if (start < cache_map[i].start) {
		/* region non-overlapping with the region in the map */
		if (end <= cache_map[i].start)
			return type_merge(type, mtrr_state.def_type, uniform);

		... rest of the processing ...

In general, I get it that your code is slick but I want it to be
maintainable - not slick. I'd like for when people look at this, not
have to  add a bunch of debugging output in order to swap the whole
thing back into their brains.

So mtrr_type_lookup() definitely needs comments explaining what goes
where.

You can send it as a diff ontop - I'll merge it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
