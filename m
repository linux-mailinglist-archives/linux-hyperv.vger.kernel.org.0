Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8737D626596
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 00:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiKKXeU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 18:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKKXeS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 18:34:18 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A873637A;
        Fri, 11 Nov 2022 15:34:17 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id d9so3547416wrm.13;
        Fri, 11 Nov 2022 15:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPi4/OjhulQ2RlxnIb6UfK/qoaOGc7Q1LZBhlSfJ7hw=;
        b=X0KwEThBHBd0IQX24Qvx42E1PKJpkRYYccuiz17sW9e+JxnoPBvDVf7+2JZvISuOWU
         852RHAzogF/s3pvbuBKA7Pn5gnKgir3iIxVCmyvCema5j6+Wuic6qXSqbbIFx2/lKtc7
         aIRL++saHgAXQbcfTJsgSMZyDPnkYURuXu+0Nv8nBVBynYW5MPj5z6SW7VipVXsaJMlH
         nNlZAdkjxipg85xiAGMjFYxu3yvzI46znSHLAhLQOk9vc3EOj2SfNf05sVht+XmESPQx
         IrfZ9C9zHWPb1MobkfoQhHMRLkgPlbG8BFlXbkv+Ouei+pz9efrpP4cctNjTRBGhwHx9
         8Pmw==
X-Gm-Message-State: ANoB5plQkZAsA/DsELrFTmJgEZd9mDcoahSS53jzjftresD2RtmW3sM8
        lP7S4MSfSrNT17cgQBBjlIE=
X-Google-Smtp-Source: AA0mqf5zWcENFzucsVAtD3mR370hnSAAOVEnr49/HkHLGu9DycMM1HkY1gBljNZAcsThsw+kPskaLg==
X-Received: by 2002:adf:f386:0:b0:234:e918:6ba2 with SMTP id m6-20020adff386000000b00234e9186ba2mr2363402wro.23.1668209656017;
        Fri, 11 Nov 2022 15:34:16 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w9-20020adfee49000000b00228cd9f6349sm2920884wro.106.2022.11.11.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:34:15 -0800 (PST)
Date:   Fri, 11 Nov 2022 23:34:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/hyperv: Restore VP assist page after cpu
 offlining/onlining
Message-ID: <Y27b9aD0ga9hJ1HI@liuwe-devbox-debian-v2>
References: <20221103190601.399343-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103190601.399343-1-vkuznets@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 03, 2022 at 08:06:01PM +0100, Vitaly Kuznetsov wrote:
> Commit e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing
> to VP assist page MSR") moved 'wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE)' under
> 'if (*hvp)' condition. This works for root partition as hv_cpu_die()
> does memunmap() and sets 'hv_vp_assist_page[cpu]' to NULL but breaks
> non-root partitions as hv_cpu_die() doesn't free 'hv_vp_assist_page[cpu]'
> for them. This causes VP assist page to remain unset after CPU
> offline/online cycle:
> 
> $ rdmsr -p 24 0x40000073
>   10212f001
> $ echo 0 > /sys/devices/system/cpu/cpu24/online
> $ echo 1 > /sys/devices/system/cpu/cpu24/online
> $ rdmsr -p 24 0x40000073
>   0
> 
> Fix the issue by always writing to HV_X64_MSR_VP_ASSIST_PAGE in
> hv_cpu_init(). Note, checking 'if (!*hvp)', for root partition is
> pointless as hv_cpu_die() always sets 'hv_vp_assist_page[cpu]' to
> NULL (and it's also NULL initially).
> 
> Note: the fact that 'hv_vp_assist_page[cpu]' is reset to NULL may
> present a (potential) issue for KVM. While Hyper-V uses
> CPUHP_AP_ONLINE_DYN stage in CPU hotplug, KVM uses CPUHP_AP_KVM_STARTING
> which comes earlier in CPU teardown sequence. It is theoretically
> possible that Enlightened VMCS is still in use. It is unclear if the
> issue is real and if using KVM with Hyper-V root partition is even
> possible.
> 
> While on it, drop the unneeded smp_processor_id() call from hv_cpu_init().
> 
> Fixes: e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing to VP assist page MSR")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to hyperv-fixes. Thanks.
