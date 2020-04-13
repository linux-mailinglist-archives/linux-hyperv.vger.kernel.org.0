Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3E1A6CED
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2020 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbgDMUDL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Apr 2020 16:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388201AbgDMUDK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Apr 2020 16:03:10 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25576C008769
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Apr 2020 13:03:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c63so10865286qke.2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Apr 2020 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OEtNtfUfCfknsSkfuodbs8GxJYII1GNua8MgFwL7K04=;
        b=juG10l2QIUDc0d5n1SeOUdB0siwuJQOGCU6pnQRUaf/usairEJnMWI4NCHxVUL2frR
         HT8Dj0G2KFCEAuDZkPEiGVv3NLV5ooo7kJcA7V4T4xV81925vc++8cQ5KHVSBI1+By+5
         +/+66XSDZZW/XkKLCzanTlv78m+KRuVYwmVlKC0N09gqxCMtKrGm1srU2i7+Kw1dkX5x
         DPoyq7kDqoEsqgMu8qGEr3vtIBlmiQWaBKBOz/tbp3ah+kvBa7aU6x3A1gaLlMlwJUeg
         hUM97swfra3YIkYNCDFX0ZcS8Au+7KacD3c88l4X9gBMGqiNfPjeT92Va5NYJ5lvz0rD
         aygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OEtNtfUfCfknsSkfuodbs8GxJYII1GNua8MgFwL7K04=;
        b=DhHtTSQod+cQVbv/fkAunMc5f1CbGQ4jNGCbyI4hpDBR5yTxb6hBoyaUJg/MNIv+/Z
         jAkv5L/kPr3doHnEXRG9wRiNxBeIO7+LDsWdCyqeaUdrJK9qCTrUb9Dzo6QE5od34I5T
         WqdvTUXTAIT0XmcdZ8NLyrqvAJ6mHEyTo5hzzZfVW+3McmEj4XDBwYj1jQYGS9tDD1Ax
         JKzljM/EpzXYkxOXPIoKAHB9A7govvkzSdepSeOXERCcP/GQtDRe2LCDOT17gz8gU68E
         f8BskZZBJvj8YorRHICKAA5Vj91ENUTLkM6/rZA1PQOabkJP+3QXfMyNI+1W2gT6qirr
         NxZA==
X-Gm-Message-State: AGi0PuaKKUly7D0jjfMb8cQgnRwrG5AdKplvvgXeL5045zKSwP0UTPgD
        xnhOIytDicFf2MKWJnSf3BclWw==
X-Google-Smtp-Source: APiQypJVwvSR1oEkK4bhCoeIIw8batoCJN92/jh4PNjnx+deBvO5XKiPj+RRAmN7IK2twvZnNWUNMA==
X-Received: by 2002:a37:d93:: with SMTP id 141mr7293908qkn.32.1586808188246;
        Mon, 13 Apr 2020 13:03:08 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x66sm9119423qka.121.2020.04.13.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 13:03:07 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:03:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 25/28] mm: remove vmalloc_user_node_flags
Message-ID: <20200413200306.GC99267@cmpxchg.org>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-26-hch@lst.de>
 <CAEf4BzZOC2tLrqt_Km=WQb=9xiya2e31i6K3oJuzgYQt6wp1LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZOC2tLrqt_Km=WQb=9xiya2e31i6K3oJuzgYQt6wp1LQ@mail.gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 09, 2020 at 03:25:03PM -0700, Andrii Nakryiko wrote:
> cc Johannes who suggested this API call originally

I forgot why we did it this way - probably just cruft begetting more
cruft. Either way, Christoph's cleanup makes this look a lot better.

> On Wed, Apr 8, 2020 at 5:03 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Open code it in __bpf_map_area_alloc, which is the only caller.  Also
> > clean up __bpf_map_area_alloc to have a single vmalloc call with
> > slightly different flags instead of the current two different calls.
> >
> > For this to compile for the nommu case add a __vmalloc_node_range stub
> > to nommu.c.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
