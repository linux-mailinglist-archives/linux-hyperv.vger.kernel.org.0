Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCFB2D8E21
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Dec 2020 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgLMPIR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Dec 2020 10:08:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36700 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgLMPIR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Dec 2020 10:08:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id y23so12972961wmi.1;
        Sun, 13 Dec 2020 07:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1MJojJpKvAPud9O3M00FZKCTLaLbASeTmO/BwG1kiQ=;
        b=BJ6etC/vpBtIoMn3wgykGdcS952U9ZXZ4AvMmW/zk1cdmrfX+O67zJ7DTUfSZ7ancM
         oHBeXSjbVhN+IABTX7h2YSKo4VcaG+KuLIXtzy/fSDmfJdwiOwHhvN5qBK15I7SyEq9t
         oX6lrS64UJFKQxWae3m7FgEW3Thr0oXQhQVmipdUCjln5kziXfYCZcwxTb1PD18of0d3
         KkRUfKtGCYgHpVCkr2iU5ELW73DTXZbbUhuDajrZq1uD77MMhzDuhN/DsenOE27dPKPx
         SG4mKXwYGPiLgug4b/4effoLVICyrvfshVIQpdEvOEODSBdJsauVWdH112bK6MJWZDo1
         Ubjw==
X-Gm-Message-State: AOAM532K6V8rF4CidxkPpBMDqsOdjkHPjU4pNnMgmOLeSFaEP1Ehh/E+
        jfZVSCqrM+bX7guauMxOEHudzUQKVGk=
X-Google-Smtp-Source: ABdhPJzvAmgajiU8zHEIQ/T0wezLuBDWvTYiB8Suv0Vzwv5VmcyDhVLx2w6q90BoHThm3xzNi3HLNg==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr23624478wmb.131.1607872055089;
        Sun, 13 Dec 2020 07:07:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m11sm11021421wmi.16.2020.12.13.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 07:07:34 -0800 (PST)
Date:   Sun, 13 Dec 2020 15:07:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] hv_balloon: hide ballooned out memory in stats
Message-ID: <20201213150732.f7tmjaybztqxyfz7@liuwe-devbox-debian-v2>
References: <20201202161245.2406143-1-vkuznets@redhat.com>
 <20201209131718.aqy6uddgqivgiglj@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209131718.aqy6uddgqivgiglj@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 09, 2020 at 01:17:18PM +0000, Wei Liu wrote:
> On Wed, Dec 02, 2020 at 05:12:43PM +0100, Vitaly Kuznetsov wrote:
> > It was noticed that 'free' information on a Hyper-V guest reports ballooned
> > out memory in 'total' and this contradicts what other ballooning drivers 
> > (e.g. virtio-balloon/virtio-mem/xen balloon) do.
> > 
> > Vitaly Kuznetsov (2):
> >   hv_balloon: simplify math in alloc_balloon_pages()
> >   hv_balloon: do adjust_managed_page_count() when
> >     ballooning/un-ballooning
> 
> LGTM.
> 
> I will wait for a few more days before applying this series to
> hyperv-next.

Applied to hyperv-next.

Wei.
