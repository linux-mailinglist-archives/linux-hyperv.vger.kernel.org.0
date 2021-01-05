Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450C92EAB7E
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 14:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbhAENFH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 08:05:07 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35238 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbhAENFG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 08:05:06 -0500
Received: by mail-wr1-f51.google.com with SMTP id r3so36138853wrt.2;
        Tue, 05 Jan 2021 05:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2a70v1CRlz5jGi+NyBGwYogijZjvjrwtQZGv4GAwSCM=;
        b=DIvE9rKwJg0BhJKRfSPNevyEZuiMt2x3R8OKCLb2WBwDaHiJDlf0EjCVgzzid2SObd
         nd93c2ORHvVHr+EgCpYwoD59AuS2Drapyd6H9lgWNW08dJoJda89L4XEevpizUVIH0Yw
         XJKbLO3pypNdu0X47mmced840ZalEjqgCmBkOPJ3Bs9hPwUSpyInzA56h9Sr9UlF+8gg
         5XkcchvEYbm89uL4E4cdoHKYJXwANYLkkFv8Ru63B0Itnx3itei06uRXrODmR/71NDmr
         S4OoT+XZGjWJ9GL8fH/gpM5Lx9vBnOOZlz7ELTCtHXd7KtOnoPXHBGIj28FBAtz56VTS
         5J7Q==
X-Gm-Message-State: AOAM532midRTWL9BrgWuMV7BBY7PezPO+XwWeajZ8f92xnsYiIpJcSe2
        DQRIk88GJon8hBV3Jy8tIX4=
X-Google-Smtp-Source: ABdhPJylito1I3/9s4izujRHhJFeAzKUTu5cEdHXRWu9RDZ+H84YBiQqtPjE6BwO+t+9ExSYnbZQfw==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr86376822wrp.340.1609851864953;
        Tue, 05 Jan 2021 05:04:24 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s13sm4041967wmj.28.2021.01.05.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:04:24 -0800 (PST)
Date:   Tue, 5 Jan 2021 13:04:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com, wei.liu@kernel.org, vkuznets@redhat.com,
        jwiesner@suse.com, ohering@suse.com, linux-kernel@vger.kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com
Subject: Re: [PATCH v2] x86/hyperv: Fix kexec panic/hang issues
Message-ID: <20210105130423.nvxpsdvgn5zier4v@liuwe-devbox-debian-v2>
References: <20201222065541.24312-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222065541.24312-1-decui@microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 21, 2020 at 10:55:41PM -0800, Dexuan Cui wrote:
> Currently the kexec kernel can panic or hang due to 2 causes:
> 
> 1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts the
> old VP Assist Pages when the kexec kernel runs. The same issue is fixed
> for hibernation in commit 421f090c819d ("x86/hyperv: Suspend/resume the
> VP assist page for hibernation"). Now fix it for kexec.
> 
> 2) hyperv_cleanup() is called too early. In the kexec path, the other CPUs
> are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
> between hv_kexec_handler() and native_machine_shutdown(), the other CPUs
> can still try to access the hypercall page and cause panic. The workaround
> "hv_hypercall_pg = NULL;" in hyperv_cleanup() is unreliabe. Move
> hyperv_cleanup() to a better place.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

The code looks a bit intrusive. On the other hand, this does sound like
something needs backporting for older stable kernels.

On a more practical note, I need to decide whether to take it via
hyperv-fixes or hyperv-next. What do you think?

Wei.
