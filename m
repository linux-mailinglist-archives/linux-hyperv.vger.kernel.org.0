Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6E180B7
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 May 2019 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfEHTxF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 May 2019 15:53:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44207 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfEHTxF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 May 2019 15:53:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so14272196qtk.11
        for <linux-hyperv@vger.kernel.org>; Wed, 08 May 2019 12:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HCtX1frjqYU3uAHx2sJHA2OsRYk/uvM/1v6XS0m5Flc=;
        b=ADEmuipNeujkuWApCcflZM53ERZJUNjq7S6erToJGyItqj6wERwk7FFgGWKKBYva7h
         SG/e9pZtCDa50lRurRyHI2bAOfvYZbGmwNZlyoXwxD2kqfBbBeMt9RvVSvlbVVWaNeAY
         GFqTgDPK+Was0DWAJHf+Ow/UgnVAlqAEZ0LkoXUqZ2lwt9cF566vEO/zgIVv9UIf4u1P
         Nc9OSdJrWNdea+Y/fWS75JOrjh+nzAz3tOpb7PmvKRwh3bMhfYOpI11aiqYgT6oQLgHk
         lFLeq3w6H7CZ8T5S2ln6IMpeKOFAKFg0/ohZr7BtXj3yaz4DQ5ycKEGO9hH5X/WZn9lI
         /5fA==
X-Gm-Message-State: APjAAAUoA6wcoxW4vCMaWOZCVug/hiGJ0ahPByup1eBtIntKsPfiS8Ek
        gDQpHs4w/d7CXiF1exfeoPO/6A==
X-Google-Smtp-Source: APXvYqwIq+qQq7KlphUsKHG//ULb8acsh1YzsFVjn3RIncz2/sckcX3cNza0iJjt02Ns8Uoy45TFHg==
X-Received: by 2002:aed:22ad:: with SMTP id p42mr6782261qtc.86.1557345184623;
        Wed, 08 May 2019 12:53:04 -0700 (PDT)
Received: from vitty.brq.redhat.com ([64.251.121.244])
        by smtp.gmail.com with ESMTPSA id g206sm9519349qkb.75.2019.05.08.12.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 12:53:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Stephen Hemminger <sthemmin@microsoft.com>,
        "m.maya.nakamura" <m.maya.nakamura@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with kmem_cache_alloc()
In-Reply-To: <BYAPR21MB1317AC7CA4B242106FCAD698CC320@BYAPR21MB1317.namprd21.prod.outlook.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com> <87wok8it8p.fsf@vitty.brq.redhat.com> <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mukvfynk.fsf@vitty.brq.redhat.com> <20190508064559.GA54416@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mujxro70.fsf@vitty.brq.redhat.com> <BYAPR21MB1317AC7CA4B242106FCAD698CC320@BYAPR21MB1317.namprd21.prod.outlook.com>
Date:   Wed, 08 May 2019 15:53:03 -0400
Message-ID: <87bm0csoyo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Stephen Hemminger <sthemmin@microsoft.com> writes:

> I would worry that kmem_cache_alloc does not currently have same alignment constraints.
> See discussion here:
> https://lwn.net/SubscriberLink/787740/a886fe4ea6681322/

I think it even was me who reported this bug with XFS originally :-) 

Yes, plain kmalloc() doesn't give you alignment guarantees (it is very
easy to prove, e.g. with CONFIG_KASAN), however, kmem_cache_create() (and
dma_pool_create() to that matter) has explicit 'align' parameter and it
is a bug if it is not respected.

-- 
Vitaly
