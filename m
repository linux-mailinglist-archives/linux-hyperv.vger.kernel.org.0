Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2468E3E0104
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Aug 2021 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhHDMVK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Aug 2021 08:21:10 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:45634 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbhHDMVK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Aug 2021 08:21:10 -0400
Received: by mail-wm1-f51.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so1330702wmg.4;
        Wed, 04 Aug 2021 05:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3YHHdNQhQUPqpOyWucLW8OhP5ZvpbmVO6o/+w7Bn+c=;
        b=Rc+bYEA5OGyBlpKPYJaLaXQqxcwcgjBdpImuyuJtmzILo3wWb4sDDOB18JR3sLaZ9C
         R6780TiqBjVWXJVmm4ecOXgY7AKkyM54X3cb2CgeuSqF6ekc0R47XYcLS7HvM3wI3XRf
         +0TiJFls4UPGPgsN3uo+JW6ZfZJxpinb9ApDyEt+XVpvgkaLx1mUgLhslSfMfQEIWJQ9
         vVD5371078JWqiUKdkcWH1IwM1AdjqA1/jpkrvNMpGsMtWr2AChLy1S/mgMQWfB2FBCo
         1W5RfjEnK9dgj7Ed+An08NPh+6SroFPH4KxQTxYYBd+c0NlFLTL5nNDac2r+42yoMT7Z
         D4kQ==
X-Gm-Message-State: AOAM530l27GogIOsvtTiIeMmoRskjbkxhRZbG/aJcmMPEIJyQ/K+2uCn
        IQD0wEzKEUB831IrKtwM/g8=
X-Google-Smtp-Source: ABdhPJwh3Tcjxxk0Mbg8rzgTpAGMkjevBEK6fsJzBKd6twg603sG5kquxgYAABLzo2dw3hzs+xEZ9A==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr27416713wmb.162.1628079656210;
        Wed, 04 Aug 2021 05:20:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j36sm5385370wms.16.2021.08.04.05.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:20:55 -0700 (PDT)
Date:   Wed, 4 Aug 2021 12:20:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v5] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Message-ID: <20210804122054.2iqcdukdx6a3x54t@liuwe-devbox-debian-v2>
References: <20210731120519.17154-1-kumarpraveen@linux.microsoft.com>
 <20210802125133.ci2jlg32mdfd5xds@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802125133.ci2jlg32mdfd5xds@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 02, 2021 at 12:51:33PM +0000, Wei Liu wrote:
> On Sat, Jul 31, 2021 at 05:35:19PM +0530, Praveen Kumar wrote:
> > For Root partition the VP assist pages are pre-determined by the
> > hypervisor. The Root kernel is not allowed to change them to
> > different locations. And thus, we are getting below stack as in
> > current implementation Root is trying to perform write to specific
> > MSR.
> > 
> > [ 2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to
> > write 0x0000000145ac5001) at rIP: 0xffffffff810c1084
> > (native_write_msr+0x4/0x30)
> > [ 2.784867] Call Trace:
> > [ 2.791507] hv_cpu_init+0xf1/0x1c0
> > [ 2.798144] ? hyperv_report_panic+0xd0/0xd0
> > [ 2.804806] cpuhp_invoke_callback+0x11a/0x440
> > [ 2.811465] ? hv_resume+0x90/0x90
> > [ 2.818137] cpuhp_issue_call+0x126/0x130
> > [ 2.824782] __cpuhp_setup_state_cpuslocked+0x102/0x2b0
> > [ 2.831427] ? hyperv_report_panic+0xd0/0xd0
> > [ 2.838075] ? hyperv_report_panic+0xd0/0xd0
> > [ 2.844723] ? hv_resume+0x90/0x90
> > [ 2.851375] __cpuhp_setup_state+0x3d/0x90
> > [ 2.858030] hyperv_init+0x14e/0x410
> > [ 2.864689] ? enable_IR_x2apic+0x190/0x1a0
> > [ 2.871349] apic_intr_mode_init+0x8b/0x100
> > [ 2.878017] x86_late_time_init+0x20/0x30
> > [ 2.884675] start_kernel+0x459/0x4fb
> > [ 2.891329] secondary_startup_64_no_verify+0xb0/0xbb
> > 
> > Since, the hypervisor already provides the VP assist page for root
> > partition, we need to memremap the memory from hypervisor for root
> > kernel to use. The mapping is done in hv_cpu_init during bringup and
> > is unmaped in hv_cpu_die during teardown.
> > 
> > Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
> 
> Looks good. I can fix a few styling issues in code and comments when I
> commit this patch.

Applied to hyperv-next. Thanks.

Wei.

> 
> Wei.
