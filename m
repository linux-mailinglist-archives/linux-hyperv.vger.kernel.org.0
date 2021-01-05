Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85B2EB1D3
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 18:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAERyC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 12:54:02 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36242 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAERyB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 12:54:01 -0500
Received: by mail-wm1-f49.google.com with SMTP id y23so360022wmi.1;
        Tue, 05 Jan 2021 09:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cb/eKs9gfJ+4Q5QjFJ08GTvJMZDgfPltkPQD+Pfflgg=;
        b=froojAol5AVIKEo/bjq4JHDK3MLBQw2EtKygDps5+H6rk+2pyprBd/DcyXvjyxhpTF
         nRbrPaPJ8KLCTOF2l0I2BuwsdaRBx/9YncQ6aSikGvDtWqmwx2BiP9Kl4w+Jb6HknD8X
         cQcUXSqme7mZHWlK9R1XSNusBC9TmfrQoqtZO9JUnBK/KcBcf2/zoN2T8HiB/qh7uGn9
         vtCvs9KEhwbvz608YVMLmf7/ytsK92fAK/cp0Yq6PoKuuWdvf+Hdrg0ueLGDp5i8srQY
         iqDruMgSpH0XIcNnyK/tY9c/IfhD6PtygPKRNX14jIyPnF3iZts9jWHY2grcOVLWNfJs
         /amA==
X-Gm-Message-State: AOAM532+aEQDeCumX5MXjJE/GRkUpzoIaKdXEku/Fx6dodkEqV6j4biq
        ZziW2drwzy21OsBaF6aotYpxF52Hhjw=
X-Google-Smtp-Source: ABdhPJz2FyiDzdDhqETzfGGu3wXSv4L1DGEBitiil9tgo1wkkOWPNeQv6MV+N0pTm8Bu1w69PbHdtQ==
X-Received: by 2002:a1c:c254:: with SMTP id s81mr288618wmf.132.1609869199718;
        Tue, 05 Jan 2021 09:53:19 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b127sm309665wmc.45.2021.01.05.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:53:19 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:53:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "jwiesner@suse.com" <jwiesner@suse.com>,
        "ohering@suse.com" <ohering@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH v2] x86/hyperv: Fix kexec panic/hang issues
Message-ID: <20210105175317.73njunfp3go5iy3c@liuwe-devbox-debian-v2>
References: <20201222065541.24312-1-decui@microsoft.com>
 <20210105130423.nvxpsdvgn5zier4v@liuwe-devbox-debian-v2>
 <MWHPR21MB1593C7460B98B88BDA63CB50D7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593C7460B98B88BDA63CB50D7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 05, 2021 at 04:39:38PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, January 5, 2021 5:04 AM
> > 
> > On Mon, Dec 21, 2020 at 10:55:41PM -0800, Dexuan Cui wrote:
> > > Currently the kexec kernel can panic or hang due to 2 causes:
> > >
> > > 1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts the
> > > old VP Assist Pages when the kexec kernel runs. The same issue is fixed
> > > for hibernation in commit 421f090c819d ("x86/hyperv: Suspend/resume the
> > > VP assist page for hibernation"). Now fix it for kexec.
> > >
> > > 2) hyperv_cleanup() is called too early. In the kexec path, the other CPUs
> > > are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
> > > between hv_kexec_handler() and native_machine_shutdown(), the other CPUs
> > > can still try to access the hypercall page and cause panic. The workaround
> > > "hv_hypercall_pg = NULL;" in hyperv_cleanup() is unreliabe. Move
> > > hyperv_cleanup() to a better place.
> > >
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > 
> > The code looks a bit intrusive. On the other hand, this does sound like
> > something needs backporting for older stable kernels.
> > 
> > On a more practical note, I need to decide whether to take it via
> > hyperv-fixes or hyperv-next. What do you think?
> > 
> 
> I'd like to see this in hyperv-fixes and backported to older stable kernels.
> In its current form, the kexec path in a Hyper-V guest has multiple problems
> that make it unreliable, so the downside risk of taking these fixes is minimal
> while the upside benefit is considerable.

Applied to hyperv-fixes.

Wei.
