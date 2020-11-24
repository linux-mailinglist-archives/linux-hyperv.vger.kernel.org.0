Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E6B2C22EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 11:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgKXK2l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 05:28:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55457 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgKXK2l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 05:28:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id x22so1926634wmc.5;
        Tue, 24 Nov 2020 02:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RwUy1fNeibgQmYo6Awy3BlHbLwEGW2ZCC3VGxsMlMyE=;
        b=uiKy1o/ppMy2F4XlyyMvTh3JYpAmZBfbYyx2X+dmJR/SCS+q7cu7EXvC/M+eBYaN9/
         BSpFZ0X3pJMUwOg0fKRuafeRgD772gHXximfJ3VN+ZlZwc6zSqV7+JNirVKtA18nQ6Z/
         NMjAaUkfFbzzyADxGr/KFVD+MhnOqubv3MBD42dUCEpypHETZy1swqn5FnMfgkyOSwoU
         2bw9UIGTL7yMS34IklqSz8y3uHvAiorrrp5llBS0d0YTM+unKxecF904M4U47xFRGajg
         vI7YNX4H1F8RQXX9VexsGFISvJZQYxNbVcYkMwKdtWO6Hx0563hX5Oljf6ChJnLHno3K
         KKVg==
X-Gm-Message-State: AOAM5315vezSmBpT4WKnYbeN4alNFmzLm5wL7JmhjWZknVz4Z4vkRgSa
        aseMDEf4NKC0xDtModDyV2g=
X-Google-Smtp-Source: ABdhPJwOmd9u4DoGyLUfSdgBmDUzqvUTJdpLbXxoHCerpn4QKmHOaWn0OsP6MgihJk58FlDoGEKEyw==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr3656173wmb.175.1606213719208;
        Tue, 24 Nov 2020 02:28:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 36sm25404427wrf.94.2020.11.24.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:28:38 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:28:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH] video: hyperv_fb: Directly use the MMIO VRAM
Message-ID: <20201124102837.ap7puuqtvyeusbjl@liuwe-devbox-debian-v2>
References: <20201121014547.54890-1-decui@microsoft.com>
 <20201121145411.GG3025@boqun-archlinux>
 <MW2PR2101MB1801841901E659E60502EB86BFFB0@MW2PR2101MB1801.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1801841901E659E60502EB86BFFB0@MW2PR2101MB1801.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 24, 2020 at 08:33:32AM +0000, Dexuan Cui wrote:
> Hi Wei Liu,
> Please do not pick up this patch, because actually MMIO VRAM can not work
> with fb_deferred_io.
> 

No problem. Thanks for the heads-up.

Wei.
