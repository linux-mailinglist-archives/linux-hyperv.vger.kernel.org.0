Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8709E3F4042
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Aug 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhHVPZU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 22 Aug 2021 11:25:20 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34435 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhHVPZU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 22 Aug 2021 11:25:20 -0400
Received: by mail-wr1-f54.google.com with SMTP id h13so22238759wrp.1;
        Sun, 22 Aug 2021 08:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ycR/CJI7goQaNET4z0DNOlWT7fSGq/2jsD35VNFXxwA=;
        b=CFFkEAuHDyCgWpGKert74P/yQ6fmuPJYGX1KpMtwcMe4ZPNNWiH+6XS+GRcxzKbszS
         Zo/P9XVLN4EWBob9WXOopVDrPSBs5hX38EPHd/JUVE1kpgUotoXKk/iQrVKvuO2KWcLO
         N5D6oipuoVJiIoJOKOaHBwyUuK/1mVXoi00Gtfx2LYEOs9JyiPu498qBETnY9oeQXVMk
         jDQpK9ouJb2OZKP6d9n0IeBnE8uFFDLRwI1KyTUeXufO+s6qi7lc6P2RTgpDeqOhW2GU
         KFfp2LvmVYv3rea9cbOhvmrdjBtFcs61Si61s3Sl6j8nebbqw4e1jSx321yMVo8KU2Kl
         NOmQ==
X-Gm-Message-State: AOAM533nTwC4S89waZ8vL2bTI8Gd4jE8KuJdoonOHBPWIzYYutF3MXBY
        HxRAVLK25M3BZQJr5FFdxoo=
X-Google-Smtp-Source: ABdhPJzqmwjmYbmC+4MM8mtBv0ninfKqdadjTLEkZ3HFtdj0A/4QDieaPBeOn5dcAR59y2Za+Ca2BQ==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr1612541wrb.329.1629645878418;
        Sun, 22 Aug 2021 08:24:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n15sm4906580wmq.7.2021.08.22.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 08:24:37 -0700 (PDT)
Date:   Sun, 22 Aug 2021 15:24:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Mozes <david.mozes@silk.us>
Cc:     David Moses <mosesster@gmail.com>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        =?utf-8?B?16rXldee16gg15DXkdeV15jXkdeV15w=?= 
        <tomer432100@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Message-ID: <20210822152436.mqfwv3xbqfxy33os@liuwe-devbox-debian-v2>
References: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <FD8265E6-895E-45CF-9AE3-787FAD669FC8@gmail.com>
 <VI1PR0401MB2415E89B6E3D01B446FD1DACF1FE9@VI1PR0401MB2415.eurprd04.prod.outlook.com>
 <20210817112954.ufjd77ujq5nhmmew@liuwe-devbox-debian-v2>
 <CA+qYZY1U04SkyHo7X+rDeE=nUy_X5nxLfShyuLJFzXnFp2A6uw@mail.gmail.com>
 <VI1PR0401MB24153DEC767B0126B1030E07F1C09@VI1PR0401MB2415.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB24153DEC767B0126B1030E07F1C09@VI1PR0401MB2415.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 19, 2021 at 07:55:06AM +0000, David Mozes wrote:
> Hi Wei ,
> I move the print cpumask to other two places after the treatment on the empty mask see below
> And I got the folwing:
> 
> 
> Aug 19 02:01:51 c-node05 kernel: [25936.562674] Hyper-V: ERROR_HYPERV2: cpu_last=
> Aug 19 02:01:51 c-node05 kernel: [25936.562686] WARNING: CPU: 11 PID: 56432 at arch/x86/include/asm/mshyperv.h:301 hyperv_flush_tlb_others+0x23f/0x7b0
> 
> So we got empty on different place on the code .
> Let me know if you need further information from us.
> How you sagest to handle this situation?
> 

Please find a way to reproduce this issue with upstream kernels.

Thanks,
Wei.
