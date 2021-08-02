Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91DB3DD602
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Aug 2021 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhHBMvq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Aug 2021 08:51:46 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40589 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhHBMvq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Aug 2021 08:51:46 -0400
Received: by mail-wr1-f45.google.com with SMTP id p5so21378697wro.7;
        Mon, 02 Aug 2021 05:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ln/22gR449DmeS8tOKA79D6nZ+VWBZEOwVh5p0o76H0=;
        b=D9vt68gY8VjQzZGEiZPAkYQLWNanLArUIu+zYG+5/j9A04mhWF74oXjNE6wXJodK/u
         A3A2wrShFxnf3ULZT1FOIKKMF8y9GTaHJOoJX9yK43/ALqCviFW1DU9Qca9axEKKxfzN
         6tg5sTeplUtr/yNwEk4QnJxMhafjlqyPgQzU0Qs8SzvgDxijlAI5wBSJ0iJTzEmcRkje
         aUHcLN9jTlSu6JnKX8gYIJfE3wifPxJQi7u8tEjJWWSZUtDiFqcK6SiXsERAlvJTNkbI
         G6LsOKnOSrOI1AAdMTZgIn2CG2MBtvTdGzB2vueYrC5zAGZ5xzlZiv5AteUXZEcuS0UI
         Q9iQ==
X-Gm-Message-State: AOAM530QAaUJUVLjnKUjLdJFHJJCWpoNCm9l5HcGhemASEIYz9bS8JsY
        SvPa9LSSKeepeeSVFguiEck=
X-Google-Smtp-Source: ABdhPJyNS+4/t2DKARRNJrSlQ5J2nJHe2AuwGN68ZGGBSmDdTA8yO8H7ZgrE00WYaC+rP4pzIB7Gig==
X-Received: by 2002:adf:e101:: with SMTP id t1mr17476003wrz.215.1627908695958;
        Mon, 02 Aug 2021 05:51:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x9sm10345292wmj.41.2021.08.02.05.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:51:35 -0700 (PDT)
Date:   Mon, 2 Aug 2021 12:51:33 +0000
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
Message-ID: <20210802125133.ci2jlg32mdfd5xds@liuwe-devbox-debian-v2>
References: <20210731120519.17154-1-kumarpraveen@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731120519.17154-1-kumarpraveen@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jul 31, 2021 at 05:35:19PM +0530, Praveen Kumar wrote:
> For Root partition the VP assist pages are pre-determined by the
> hypervisor. The Root kernel is not allowed to change them to
> different locations. And thus, we are getting below stack as in
> current implementation Root is trying to perform write to specific
> MSR.
> 
> [ 2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to
> write 0x0000000145ac5001) at rIP: 0xffffffff810c1084
> (native_write_msr+0x4/0x30)
> [ 2.784867] Call Trace:
> [ 2.791507] hv_cpu_init+0xf1/0x1c0
> [ 2.798144] ? hyperv_report_panic+0xd0/0xd0
> [ 2.804806] cpuhp_invoke_callback+0x11a/0x440
> [ 2.811465] ? hv_resume+0x90/0x90
> [ 2.818137] cpuhp_issue_call+0x126/0x130
> [ 2.824782] __cpuhp_setup_state_cpuslocked+0x102/0x2b0
> [ 2.831427] ? hyperv_report_panic+0xd0/0xd0
> [ 2.838075] ? hyperv_report_panic+0xd0/0xd0
> [ 2.844723] ? hv_resume+0x90/0x90
> [ 2.851375] __cpuhp_setup_state+0x3d/0x90
> [ 2.858030] hyperv_init+0x14e/0x410
> [ 2.864689] ? enable_IR_x2apic+0x190/0x1a0
> [ 2.871349] apic_intr_mode_init+0x8b/0x100
> [ 2.878017] x86_late_time_init+0x20/0x30
> [ 2.884675] start_kernel+0x459/0x4fb
> [ 2.891329] secondary_startup_64_no_verify+0xb0/0xbb
> 
> Since, the hypervisor already provides the VP assist page for root
> partition, we need to memremap the memory from hypervisor for root
> kernel to use. The mapping is done in hv_cpu_init during bringup and
> is unmaped in hv_cpu_die during teardown.
> 
> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>

Looks good. I can fix a few styling issues in code and comments when I
commit this patch.

Wei.
