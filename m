Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760D9640BD5
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Dec 2022 18:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiLBRKg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Dec 2022 12:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiLBRKa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Dec 2022 12:10:30 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A233AE784E;
        Fri,  2 Dec 2022 09:10:29 -0800 (PST)
Received: from skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3FE5120B83C2;
        Fri,  2 Dec 2022 09:10:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FE5120B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670001029;
        bh=PzyAFJwEuP/xweSAbsHfP9EomYH6/SV16jhJAd1UaIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AsOusUGy80/+sbR5SQuusTgV+kKm+DQ5oY5v78ic6+uNIK/ac0Pvi1MGXPmrQqSK6
         qWL827ZUi115KKqdH+kSbMMaLg1TadMR79DRD86bX3Q6zW2uHGOJvP9cc0hlCDaLiZ
         JAbQqCce17aElq5o4zfVl/Xn3oqTtQZ1HlcaZ3Oc=
Date:   Fri, 2 Dec 2022 17:10:28 +0000
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dexuan Cui <decui@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        x86@kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v3 0/4] hyper-v: Introduce TSC page for root partition
Message-ID: <Y4oxhMoiPGplMbT6@skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <Y3JIk6sW9lZ6UvC7@liuwe-devbox-debian-v2>
 <5f6dac1e-5d17-122c-5e52-1b15bff7630f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f6dac1e-5d17-122c-5e52-1b15bff7630f@linaro.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Dec 02, 2022 at 01:55:35PM +0100, Daniel Lezcano wrote:
> On 14/11/2022 14:54, Wei Liu wrote:
> > On Thu, Nov 03, 2022 at 05:58:43PM +0000, Stanislav Kinsburskii wrote:
> > > 
> > > Stanislav Kinsburskiy (4):
> > >        drivers/clocksource/hyper-v: Introduce a pointer to TSC page
> > >        drivers/clocksource/hyper-v: Introduce TSC PFN getter
> > >        drivers/clocksource/hyper-v: Use TSC PFN getter to map vvar page
> > >        drivers/clocksource/hyper-v: Add TSC page support for root partition
> > 
> > Applied to hyeprv-next. Thanks.
> 
> The series should have go through the clocksource/timer tree or at least
> should have specified the targeted tree for an Acked-by from the clocksource
> maintainers.
> 
> In the future, please follow the process
> 

I will.
Thank you for your feedback and aknowledgement, Daniel.

> That said,
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
