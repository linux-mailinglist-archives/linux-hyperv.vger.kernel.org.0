Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC771792B9
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2020 15:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCDOtE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Mar 2020 09:49:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44212 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOtD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Mar 2020 09:49:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id n7so2703209wrt.11;
        Wed, 04 Mar 2020 06:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ahY/ktb/Tn6dne+Gv/s9FpNDYukQ7zmj9C6Dhcf5KwI=;
        b=pnw0vb8Neu/VV2Uh6Kp0+J8K7lx2KjGDD0eKfbj5H75lQGWGQGkfTZSj34z4XNCuXa
         rxOA0cu1SO+VGCahWQ0cV1/ZeSL6V2cHsbh3DedzClmZVwUSTFM+7Vw1PUCSlzlRcafu
         j82wk2vhSq8a8ZKA5KNL/t7SyXwSK/MOID6SL/aNqBgIh1uhfaD/vVoar9094sKb/2Zg
         L9UGl48T71vK3mGOIqVC0V8dq1W7elRF8KETlDNS6bofGnW7O9XVchb/DH/VYIRNWHoD
         bwhXOgqDEMC46BTtHycOoGnmuWmhGvSbeboi9twYSfNrx+JMpnSYMMKY8KghIjOUiDP/
         tlnw==
X-Gm-Message-State: ANhLgQ1Z3u39Y57/8jTDu+NltTvgo1dzaaLnb1d3nPSDeeU0/EPeiGAM
        9IKVTGBfDkgTcu1qZXzH3EM=
X-Google-Smtp-Source: ADFU+vtWTzfJYdWlQ8luVZD6y6cDm7sEDV5/bdS4EZV7rh1uOrQaH6mvrGnueAEamGKgKQwpL8CJ6g==
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr4317475wre.369.1583333341820;
        Wed, 04 Mar 2020 06:49:01 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id b18sm40168570wrm.86.2020.03.04.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:49:01 -0800 (PST)
Date:   Wed, 4 Mar 2020 14:48:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Lucas Tanure <tanure@linux.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-hyperv@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
Message-ID: <20200304144858.xc6ekcvbzrhbggsc@debian>
References: <20200229173007.61838-1-tanure@linux.com>
 <CAO-hwJJDv=LnOQDbgWwg2sOccM9Tt-h=082Coi0aYdwG-CG-Kg@mail.gmail.com>
 <20200302120951.fhdafzl5xtnmjrls@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302120951.fhdafzl5xtnmjrls@debian>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 02, 2020 at 12:09:51PM +0000, Wei Liu wrote:
> Hi Benjamin
> 
> On Mon, Mar 02, 2020 at 11:16:30AM +0100, Benjamin Tissoires wrote:
> > On Sat, Feb 29, 2020 at 6:30 PM Lucas Tanure <tanure@linux.com> wrote:
> > >
> > > Fix below warnings reported by coccicheck:
> > > drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing functions is not needed.
> > > drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing functions is not needed.
> > >
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > ---
> > 
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > Sasha, do you prefer taking this through your tree or through the HID
> > one. I don't think we have much scheduled for hyperv, so it's up to
> > you.
> 
> Sasha stepped down as a hyperv maintainer a few days back. I will be
> taking over maintenance of the hyperv tree.
> 
> The problem is at the moment I haven't got write access to the
> repository hosted on git.kernel.org. That's something I will need to
> sort out as soon as possible.
> 
> In the meantime, it would be great if you can pick up this patch so that
> it doesn't get lost while I sort out access on my side.

Hi Benjamin

I got access to the Hyper-V tree. I will be picking this patch up since
I haven't got a confirmation from your side.

Wei.

> 
> Thanks,
> Wei.
