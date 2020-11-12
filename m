Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB52B03CB
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKLLYo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 06:24:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33631 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLLYm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 06:24:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id p19so5962582wmg.0;
        Thu, 12 Nov 2020 03:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZ5qGZHSgIjwkaDJ8p8YP7dQhAIcyyCjHjwZ8A7ti1g=;
        b=VOpVAe4g470PXJq6G4AlUwyk9aBrncBf2KtHo8dn0YpiXotGLpyF0gcU+j+HP9ayJD
         0DViuqESedB5Xv2xFJYFDi8ocgPPLFWM3zgsvAsQDxjHpOT3yh+MuX65M2e4JgjRgvib
         QHkJnbidU+2euWy/vtGRUL91beUOFLlpKYvMk98TULSdSJuXVvnsOxAhJ7VQ9hS6e1G3
         DUP44bbJBvsfNCrNd5XiR8Psmcy+0N5t+w33JGsmACZz25PzAW9njXb0VCGVw7RovgLH
         yX7BlJezYfFvMP/ARi2L4uhv0DkKOkoaVLXf17pENHwld9+ihhyasGXA2sxEFVm6tBxZ
         mKtQ==
X-Gm-Message-State: AOAM532PKF0agpIMV/l0ASJvOYBDQwo2lp+nfiRu7GdPL7Wgn01pLufL
        E7TiM3T/yOcB11QcAlBM7N0=
X-Google-Smtp-Source: ABdhPJzznTh5VjKbLDAHt3xTgAw03O5uYFfXGg/Igyib5PwA378/95uYyIA+Xgq0NiqWbzJ37R+rOw==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr9017268wml.31.1605180279306;
        Thu, 12 Nov 2020 03:24:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d3sm6455313wre.91.2020.11.12.03.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:24:38 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:24:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
Message-ID: <20201112112437.lt3g5bhpjym3evu5@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
 <3527e98a-faab-2360-f521-aa04bbe92edf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3527e98a-faab-2360-f521-aa04bbe92edf@linaro.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 10:56:17AM +0100, Daniel Lezcano wrote:
> On 05/11/2020 17:58, Wei Liu wrote:
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> 
> I would like to apply this patch but the changelog is too short (one line).
> 
> Please add a small paragraph (no need to resend just answer here, I will
> amend the log myself.

Please don't apply this to your tree. It is dependent on a previous
patch. I expect this series to go through the hyperv tree.

I will add in this small paragraph in a later version:

    When Linux runs as the root partition, the setup required for TSC page
    is different. Luckily Linux also has access to the MSR based
    clocksource. We can just disable the TSC page clocksource if Linux is
    the root partition.

If you're happy with the description, I would love to have an ack from
you. I will funnel the patch via the hyperv tree.

Wei.
