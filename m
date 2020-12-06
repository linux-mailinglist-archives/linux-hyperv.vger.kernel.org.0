Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF2C2D0766
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 22:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLFVd6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 16:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFVd5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 16:33:57 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E41DC0613D2;
        Sun,  6 Dec 2020 13:33:17 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so9933458wmd.0;
        Sun, 06 Dec 2020 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H2ihWmj1xz3YUTUg4hm8Uz+Y+1WdQit3Ko6/J96mYYM=;
        b=ZgOmGcHNvldEzL+8MdfX12VyB0IA1DpU5tTi1qCHjMB+ef3w2sYJDTVXEW5VTdMx6E
         yDWW0xtiP0FkJJMnjiKhsbBpMycG5NcGCnNIYY4Fd8UrPKKerd4e0z4XxlueSdh10zSf
         1XbQRz61a6fvHwPi/oTi+Aqk2HZvjwMfW8rKbESLziMUz1Aj4A1Fkzxuet2jiKXat6Eg
         Vm6W41q4IvToEvcsR5mDVa26gYmceHatpmI1AL1KQ0Cs5nVhpQC5xqHf/agze1QTvFVs
         ma6bjLXRiUmmqWK/6tan3GJC2bQiqXg0swT5mvIE0kGUYktFuPWb8gdyoISQJ115GKr8
         QzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2ihWmj1xz3YUTUg4hm8Uz+Y+1WdQit3Ko6/J96mYYM=;
        b=jHuZ+J2Qc2wqoDOuh4FHvUGoWmLAWriR+smUkmcCY3GsdYqyZJ/BhcQy3Z55qD/+Sr
         AW6+1w6ASDOfa/Ru7QKigCLlPG6geerOA2Xgbui5ymynuIkCiTjuBY0Z0XEc6mWwrFu+
         Fe+jn2wSBL2+7z7/ljN/if8lgUMrKs4Nnsw7JxcaZyIBn/ipsTtqrASKXMCRseAneMDa
         Jj19xCerfp11cXhS2CLRN9KCUecwmrWEdSto9CPczgbm3eKjW6XjRw/sVInZacY1Ze4K
         mnS1kwk2ouM5Wj0s/PfaOF3TArr9LMq1lENnqQ2t7FVr8fvDsHLkGMFVkCA/AAukRCRE
         zzEw==
X-Gm-Message-State: AOAM5321kvvKZD2CMz145soFA5DJMYREWiLaKKZ38eYHgLCVBKsk9zXW
        0nnfdOqPVORdqndLsGWoFMg=
X-Google-Smtp-Source: ABdhPJzGoFoCFZnWM7Z1vjJyt3zJQrJPa+VXNvx7lOngn7QhOuU5SWboVcziZl3fzVJfPmC44+N6Wg==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr15159982wmb.47.1607290396050;
        Sun, 06 Dec 2020 13:33:16 -0800 (PST)
Received: from andrea (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id c4sm13438187wrw.72.2020.12.06.13.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 13:33:15 -0800 (PST)
Date:   Sun, 6 Dec 2020 22:33:08 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH v2 4/7] Drivers: hv: vmbus: Copy the hv_message object in
 vmbus_on_msg_dpc()
Message-ID: <20201206213308.GA11423@andrea>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
 <20201202092214.13520-5-parri.andrea@gmail.com>
 <MW2PR2101MB105225FDDE123AE3A852C665D7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB105225FDDE123AE3A852C665D7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Dec 06, 2020 at 06:39:39PM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, December 2, 2020 1:22 AM
> > 
> > The hv_message object is in memory shared with the host.  To prevent
> > an erroneous or a malicious host from 'corrupting' such object, copy
> > the object into private memory.

[...]

> But if we're going to just make a copy at the start and use the copy for
> everything, then the motivation for the changes in Patches 2 and 3 goes
> away.  The double-fetch problem is solved entirely by Patch 4.  The
> changes in Patches 2 and 3 *are* nice for simplifying the code, but
> that's all.  The code simplification is still useful as prep to reduce the
> number of references to "msg" that have to be changed to "msg_copy",
> but the commit message should be changed to reflect that, rather than
> to eliminate double fetches.

I'm okay with this: I will revisit the commit messages of 2/3, maybe
squash those 'simplifications' into a single patch, and then 'solve'
/guard against the double fetch problem with 4.

Thanks,
  Andrea
