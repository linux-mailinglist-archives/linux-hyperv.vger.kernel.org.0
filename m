Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10C2D4310
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgLINSM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 08:18:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34882 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbgLINSD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 08:18:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id r3so1721399wrt.2;
        Wed, 09 Dec 2020 05:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDEwH2poPEgF9/H6H1mvb3OMGZ5ivX5NVZHxhkZl44A=;
        b=paXBdYjGsAIcZgC7vXuDD9jsq3p0Xx7oCMYp0wwtS+5K3dMR5+zBbs7avzxffDSP0Q
         iQyvQUAdDVvNqXuymQLCXYPOPJyWhQi6Y51CMsemDk0Uh4O+7m0YyWUHsZj21LpCN5g5
         VRf71c3cESKm6WqSGv36udH5DAzuuEIH/zWX8WrWiZfcEZ/TprOeV6quMZkz0INZMWra
         eRG2mewAKeYvlSCVCOICLV6i/DybH1zjXSHAGUotKT24lV+gb8K+8qru6+VW+etlA9ha
         FFaiInEq4binK4di1uuiRYQYNl0cJgE2+nJ6YDGvUwyRxTGb+t4mue1EEuuF14gBgRDI
         13jg==
X-Gm-Message-State: AOAM531OxxeHEPwdXcC0szegMNpHkticOI0l1Pp6Ebiez66DUf+7JDZT
        kwQCCBOB2yfkV27Il5AjZ88=
X-Google-Smtp-Source: ABdhPJw33StJvMdidRu+qGNHmFFP3Io5tSs4/JVbX7jTwY5Y9fCczKb/T0AhPTVoAS16SpTzS8ICKQ==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr2726692wrt.114.1607519841005;
        Wed, 09 Dec 2020 05:17:21 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b14sm3439908wrx.77.2020.12.09.05.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:17:20 -0800 (PST)
Date:   Wed, 9 Dec 2020 13:17:18 +0000
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
Message-ID: <20201209131718.aqy6uddgqivgiglj@liuwe-devbox-debian-v2>
References: <20201202161245.2406143-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202161245.2406143-1-vkuznets@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 02, 2020 at 05:12:43PM +0100, Vitaly Kuznetsov wrote:
> It was noticed that 'free' information on a Hyper-V guest reports ballooned
> out memory in 'total' and this contradicts what other ballooning drivers 
> (e.g. virtio-balloon/virtio-mem/xen balloon) do.
> 
> Vitaly Kuznetsov (2):
>   hv_balloon: simplify math in alloc_balloon_pages()
>   hv_balloon: do adjust_managed_page_count() when
>     ballooning/un-ballooning

LGTM.

I will wait for a few more days before applying this series to
hyperv-next.

Wei.
