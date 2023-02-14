Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B28C69718F
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Feb 2023 00:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBNXH1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Feb 2023 18:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjBNXH0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Feb 2023 18:07:26 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C52F789;
        Tue, 14 Feb 2023 15:07:04 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id z13so12121727wmp.2;
        Tue, 14 Feb 2023 15:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFnuXHt5BQHl+dl25WeGhSRF34xm7oP5SZbo8VSJ+Ws=;
        b=PG0kZ/+AUbeayfiCWOFSY9WUto3WCWzXClKgPgrncLDx/f81/7SAU9xRVEQVAqKOF8
         suGRHKYrkkCa/MiB0kROVL57DXGIwNWLqh6JpR2TlRtTjzlEuJ/5AENFJcYDL2a917S1
         TDpbWf4EV1YFt15wQhF/8RAofUASuf1uSkUSNxL4Y/XcO4X0rPyHN+4QVAm3h5/Gyz5E
         ajpqDbnpygGIYF+fIVxAyhMFPFz32SU+CZ/iC3wfnvgO2Kt16JB+7Jqs1T22O99Zb/oQ
         bdfMa0TmcWdB682u3LjigSUONBYVI0C9jDfGMwWDFpellWX12nClVawO8co35lI1HEGg
         15xA==
X-Gm-Message-State: AO0yUKW5kKR8WJlhKwKfQ+JRCQ9aDf3pZZBlw+2kwJk41N0JSt4jUuB2
        ZQXM235fiHcG1IjwIRN4h8A=
X-Google-Smtp-Source: AK7set8NeemUKLkEtHvCUxeaLbiku2+64NE6dhd8JSuhljEWgonizKhFZdNHHZWDFDJ1BjDakp3utQ==
X-Received: by 2002:a05:600c:180a:b0:3e1:f8b3:6333 with SMTP id n10-20020a05600c180a00b003e1f8b36333mr366196wmp.27.1676415988378;
        Tue, 14 Feb 2023 15:06:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c440100b003e0238d9101sm189411wmn.31.2023.02.14.15.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:05:55 -0800 (PST)
Date:   Tue, 14 Feb 2023 23:05:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        jinankjain@linux.microsoft.com, mikelley@microsoft.com,
        kys@microsoft.com, Tianyu.Lan@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH] x86/hyperv: Fix hv_get/set_register for nested bringup
Message-ID: <Y+wTrlz8nlk4h11/@liuwe-devbox-debian-v2>
References: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
 <8d0b36c0-dfca-6d4b-076d-033f9ccda4c7@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0b36c0-dfca-6d4b-076d-033f9ccda4c7@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 14, 2023 at 02:17:52PM -0800, Nuno Das Neves wrote:
> On 2/13/2023 6:28 AM, Wei Liu wrote:
> > A few comments on style.
> > 
> > On Thu, Feb 09, 2023 at 02:02:52PM -0800, Nuno Das Neves wrote:
> >> hv_get_nested_reg only translates SINT0, resulting in the wrong sint
> >> being registered by nested vmbus.
> > 
> > Please put a blank line between paragraphs.
> > 
> 
> Ok
> 
> >> Fix the issue with new utility function hv_is_sint_reg.
> >> While at it, improve clarity of hv_set_non_nested_register and hv_is_synic_reg.
> >>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> ---
> >>  arch/x86/include/asm/mshyperv.h | 11 +++++++----
> >>  arch/x86/kernel/cpu/mshyperv.c  |  8 ++++----
> >>  2 files changed, 11 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> >> index 9ae1a344536b..684c547c1cca 100644
> >> --- a/arch/x86/include/asm/mshyperv.h
> >> +++ b/arch/x86/include/asm/mshyperv.h
> >> @@ -225,10 +225,13 @@ extern bool hv_isolation_type_snp(void);
> >>  
> >>  static inline bool hv_is_synic_reg(unsigned int reg)
> >>  {
> >> -	if ((reg >= HV_REGISTER_SCONTROL) &&
> >> -	    (reg <= HV_REGISTER_SINT15))
> >> -		return true;
> >> -	return false;
> >> +	return (reg >= HV_REGISTER_SCONTROL) &&
> >> +	       (reg <= HV_REGISTER_SINT15);
> >> +}
> > 
> > Please put a new line here.
> > 
> 
> Ok
> 
> > I can fix these issues too if you don't end up sending a new version due
> > to other issues.
> > 
> > Jinank, please take a look. The code looks sensible to me, but I would
> > like you to have a look too.
> > 
> 
> I'll wait for Jinank to take a look before posting another version...
> 

If Jinank is happy with the change, I can just fix things up for you
before I commit this patch.

Wei.
