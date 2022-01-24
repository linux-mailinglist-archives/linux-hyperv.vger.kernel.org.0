Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B425049819F
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jan 2022 15:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiAXOCc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Jan 2022 09:02:32 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:47051 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiAXOCc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Jan 2022 09:02:32 -0500
Received: by mail-wm1-f50.google.com with SMTP id a203-20020a1c98d4000000b0034d2956eb04so1372444wme.5;
        Mon, 24 Jan 2022 06:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THU4jK8TMCvPkYwnRlwAVctd3mj6SQNDR24XQxhu4+0=;
        b=KsDoKjUv2QSX1vscJ+xxbvD4woDY3dO6pOOnt3O/9ycWd45HP4DGP2WqqQYKtqNGRh
         pyXklvYL+/I3QgaqVlbRhV+7CRLRnnj8YsU1JMhJNaEbfXS9exdU07xzCH5zO2OLTX/h
         zzYuwWwNgkLhcirf4r4S/io4l7cQVOidDR0fmHXfpYtdB2I6rchIBRHxH2fvRrTayrHy
         OiY5mNyOH8VxT6As3yZ+BUmGb/zdiKJo8+JGifhgC65R14BrSj3xzNEdddu9M2h2QcA3
         hEOJhMGVDkz8i/QddZkoMy47HVqY+oz0/t3oruYayT0iI8dQOAioWo0sy8lSfe/p73eD
         gCoQ==
X-Gm-Message-State: AOAM531c4paxanHTtNGAern1xXyTLzEcEIyEKNNA1grE2P1ESzHSi4DN
        wIsfNw2V0fsazmeHxQalijk=
X-Google-Smtp-Source: ABdhPJww5yfltt0+zq2PHbn2mD/HvnB+5pJIrqjhflb5W4S5NoJLdhhqq8/MabUEsqvCVzoBXrIvIA==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr1961082wmb.29.1643032950560;
        Mon, 24 Jan 2022 06:02:30 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b15sm13677648wrs.93.2022.01.24.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 06:02:30 -0800 (PST)
Date:   Mon, 24 Jan 2022 14:02:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Hu <weh@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
        "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
        hhei <hhei@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] video: hyperv_fb: Fix validation of screen resolution
Message-ID: <20220124140228.ywtxgrx3jqngmbqt@liuwe-devbox-debian-v2>
References: <1642360711-2335-1-git-send-email-mikelley@microsoft.com>
 <MN2PR21MB1295CE3BD15D4EB257A158DCCA569@MN2PR21MB1295.namprd21.prod.outlook.com>
 <20220123215606.fzycryooluavtar4@liuwe-devbox-debian-v2>
 <MWHPR21MB1593ED650DA82BC3009F66CED75D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220123223030.ijdzrunduww76jiq@liuwe-devbox-debian-v2>
 <e396a22d-7e0e-73a4-d831-f69dc854bfa8@gmx.de>
 <20220124133119.3yxfr7ypmmdotm6h@liuwe-devbox-debian-v2>
 <cb4323b6-99f0-c813-502a-2fbe107353ee@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4323b6-99f0-c813-502a-2fbe107353ee@gmx.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:57PM +0100, Helge Deller wrote:
> On 1/24/22 14:31, Wei Liu wrote:
[...]
> >>
> >> Linus hasn't pulled my tree yet, and he will probably not before the
> >> next merge window. So, if this is an urgent bugfix for you, I can offer
> >> to drop it from the fbdev tree and that you take it through the hyperv-fixes tree.
> >> In that case you may add an Acked-by: Helge Deller <deller@gmx.de>.
> >> Just let me know what you prefer.
> >
> > Hi Helge
> >
> > Yes, I would like to upstream it as soon as possible so that it can
> > propagate to stable trees and be backported by downstream vendors.
> >
> > I will pick it up in hyperv-fixes. Please drop it from your for-next
> > tree.
> 
> Dropped now from fbdev tree.

Thanks! I added your ack and pushed the patch to hyperv-fixes.

Wei.

> 
> Thanks!
> Helge
