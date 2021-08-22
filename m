Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF63F40AF
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Aug 2021 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhHVRdL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 22 Aug 2021 13:33:11 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44849 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHVRdK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 22 Aug 2021 13:33:10 -0400
Received: by mail-wr1-f52.google.com with SMTP id x12so22509007wrr.11;
        Sun, 22 Aug 2021 10:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U2ZYkA40pDQvD6v7BP8S/vsuoCt3e+GjmDpibd/R/f8=;
        b=ThgeZafg6mNcqu03QFrCL01Qler5MUTKEMlTpmZbJ3Z97UJlNa0X5bUvJVr00m+hXe
         nmqrwLSVDlzr8BQ4/hPKHMgnJrg90WrhJ5y93IF+HQ2kPEiNNds6vYQZ9U2QQ8JLCrPV
         kbx/Y77aMwW7Wikbmv0PI66wpjpppSv2hjbO7zoGkCAt0WER0XP8pxuQDI45I7kHlijg
         ifFv5rj0aG+mfr05YHX6t3GJk32nJ/+ECCf94gE049PYx6gx4ZygbT6yTIQ/HKbspAqM
         xC92sUYnizuLJaUPborDwCFS/ZkLPgoNp1yv6QTJq/SbXQsKARffpbOIaXD2hshFL+ws
         BMHQ==
X-Gm-Message-State: AOAM531ms/QOHRU75zo0gKQOQd51qlxm9hKK4OvlOhQkNQTcAGxPUvs5
        zWMAnTqxKry+T0TmOnWi4G4=
X-Google-Smtp-Source: ABdhPJzlGK6Y3owIPvbStEKoAfSEQVttekbv7KJXierO5W07/bXgh7iA6GkXZ+rRuDftdpDpZKGtiA==
X-Received: by 2002:adf:cd91:: with SMTP id q17mr9671938wrj.122.1629653548502;
        Sun, 22 Aug 2021 10:32:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n14sm2252576wrx.10.2021.08.22.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 10:32:28 -0700 (PDT)
Date:   Sun, 22 Aug 2021 17:32:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Mozes <david.mozes@silk.us>
Cc:     Wei Liu <wei.liu@kernel.org>, David Moses <mosesster@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        =?utf-8?B?16rXldee16gg15DXkdeV15jXkdeV15w=?= 
        <tomer432100@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Message-ID: <20210822173226.ddekpq7jrjwhsguj@liuwe-devbox-debian-v2>
References: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <FD8265E6-895E-45CF-9AE3-787FAD669FC8@gmail.com>
 <VI1PR0401MB2415E89B6E3D01B446FD1DACF1FE9@VI1PR0401MB2415.eurprd04.prod.outlook.com>
 <20210817112954.ufjd77ujq5nhmmew@liuwe-devbox-debian-v2>
 <CA+qYZY1U04SkyHo7X+rDeE=nUy_X5nxLfShyuLJFzXnFp2A6uw@mail.gmail.com>
 <VI1PR0401MB24153DEC767B0126B1030E07F1C09@VI1PR0401MB2415.eurprd04.prod.outlook.com>
 <20210822152436.mqfwv3xbqfxy33os@liuwe-devbox-debian-v2>
 <VI1PR0401MB2415F41E0D6B43411779911AF1C39@VI1PR0401MB2415.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0401MB2415F41E0D6B43411779911AF1C39@VI1PR0401MB2415.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Aug 22, 2021 at 04:25:19PM +0000, David Mozes wrote:
> This is not visible since we need a very high load to reproduce. 
> We have tried a lot but can't achieve the desired load 
> On our kernel with less load, it is not reproducible as well.

There isn't much upstream can do if there is no way to reproduce the
issue with an upstream kernel.

You can check all the code paths which may modify cpumask and analyze
them. KCSAN may be useful too, but that's only available in 5.8 and
later.

Thanks,
Wei.

> 
> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org> 
> Sent: Sunday, August 22, 2021 6:25 PM
> To: David Mozes <david.mozes@silk.us>
> Cc: David Moses <mosesster@gmail.com>; Wei Liu <wei.liu@kernel.org>; Michael Kelley <mikelley@microsoft.com>; תומר אבוטבול <tomer432100@gmail.com>; linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_flush_tlb_others()
> 
> On Thu, Aug 19, 2021 at 07:55:06AM +0000, David Mozes wrote:
> > Hi Wei ,
> > I move the print cpumask to other two places after the treatment on the empty mask see below
> > And I got the folwing:
> > 
> > 
> > Aug 19 02:01:51 c-node05 kernel: [25936.562674] Hyper-V: ERROR_HYPERV2: cpu_last=
> > Aug 19 02:01:51 c-node05 kernel: [25936.562686] WARNING: CPU: 11 PID: 56432 at arch/x86/include/asm/mshyperv.h:301 hyperv_flush_tlb_others+0x23f/0x7b0
> > 
> > So we got empty on different place on the code .
> > Let me know if you need further information from us.
> > How you sagest to handle this situation?
> > 
> 
> Please find a way to reproduce this issue with upstream kernels.
> 
> Thanks,
> Wei.
