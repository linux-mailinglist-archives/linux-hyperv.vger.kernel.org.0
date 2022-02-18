Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05794BB9D8
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Feb 2022 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiBRNKl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Feb 2022 08:10:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiBRNKi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Feb 2022 08:10:38 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4903253BDE;
        Fri, 18 Feb 2022 05:10:20 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id u2so13374172wrw.1;
        Fri, 18 Feb 2022 05:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AQkiJ8sW1OP2y4RdGzYTJIbJ9pKacy4Yi3FStIGv35A=;
        b=oF4b87HmK163jWyYfRYRtGCoPDdJB5kZwYxJBUMDwRf8LMKh+SHOAOWpEEDAJK72fF
         G81gdtdZ6Q5kPXmteqPQglbhJI50iK6S3iDd4+/OqFlSsOXBhhBaL0Utzk1BeeAUJrqP
         zsGEOojdDTP1mNmyOe7A0V1MYunn3TrzSA2urFdctiAHlDSDwg6HUudb7xYV77yhgxVn
         UFPK7eXIFMugiBn520AXy/V3PLPbr4bazVNbwgj9zVNZWvhF3J2LmGfaN7/tNWWypPsb
         NHzOfc1jRPcWV0Aj6bI5+Q8LjfZQc3JLBHfomL3gT+/a69AeARR8C0iMpte2eB/hDv5N
         D/gQ==
X-Gm-Message-State: AOAM532cbDqS8+L4D7Q8Ugfw3FODWRGlUTPYlVPZV0EiBtVI5YAIQzx8
        DmyHP88/2Dxnq1VRoQv+HCQ=
X-Google-Smtp-Source: ABdhPJwXA/gJEI4kjedj5s+d7rWYoQff1MaSADKEA4Iyjn4IZAV0cwVD0g6T7JIHYZt5s6I3ruoS+Q==
X-Received: by 2002:a5d:584f:0:b0:1e8:5697:e979 with SMTP id i15-20020a5d584f000000b001e85697e979mr6002036wrf.167.1645189819011;
        Fri, 18 Feb 2022 05:10:19 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z10sm4110316wmi.31.2022.02.18.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:10:18 -0800 (PST)
Date:   Fri, 18 Feb 2022 13:10:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: hv: log when enabling crash_kexec_post_notifiers
Message-ID: <20220218131017.cmzirxxo2msppgy4@liuwe-devbox-debian-v2>
References: <20220215013735.358327-1-stephen.s.brennan@oracle.com>
 <MWHPR21MB1593EAD0167AA9EC4139042AD7369@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593EAD0167AA9EC4139042AD7369@MWHPR21MB1593.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 17, 2022 at 04:44:13PM +0000, Michael Kelley (LINUX) wrote:
> From: Stephen Brennan <stephen.s.brennan@oracle.com> Sent: Monday, February 14, 2022 5:38 PM
> > 
> > Recently I went down a rabbit hole looking at a race condition in
> > panic() on a Hyper-V guest. I assumed, since it was missing from the
> > command line, that crash_kexec_post_notifiers was disabled. Only after
> > a rather long reproduction and analysis process did I learn that Hyper-V
> > actually enables this setting unconditionally.
> > 
> > Users and debuggers alike would like to know when these things happen. I
> > think it would be good to print a message to the kernel log when this
> > happens, so that a grep for "crash_kexec_post_notifiers" shows relevant
> > results.
> 
> I'm OK with adding this output line.  However, you have probably
> seen the two other LKML threads [1] and [2] about reorganizing the
> panic notifiers to clearly distinguish between notifiers that always run
> vs. those controlled by "crash_kexec_post_notifiers".  If the changes
> proposed in those threads are submitted and accepted, it is likely that
> the kernel log message in this patch would become unnecessary.
> But since we don't know when those proposed changes might come
> to fruition, adding the message for now makes sense.
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
