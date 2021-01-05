Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7B2EAB8F
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 14:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbhAENJ5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 08:09:57 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55862 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbhAENJ4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 08:09:56 -0500
Received: by mail-wm1-f46.google.com with SMTP id c124so2951554wma.5;
        Tue, 05 Jan 2021 05:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yTwqt0s6atEKcOdu0KqPbMrHQRcOeEABN/38L/zVNEU=;
        b=JIfKzq/Fu2Rvj+zjEZ7sFNMey+7UeYrQOIRr9WwqrpmfxSoN857rAKooVeHRK5kD6X
         kJTshhv9tbiM2fP0wrom6SXDqUjoMNNTEzLn7U/mtsax4HhdvnFV7hUpE1Wu7QnLWFpS
         lvVIiR1qKlpBQjmE3weRlbUokGhelDTmhv08ppvKuPzG8r6GT7wF2KWWbajGRDDZfaV9
         owpH8lSrJSUQ82AY4gBWDgGXmGpnneUhIpDNkvctiqv9jr9t7/QeZhFEbd/W3IhVDlYb
         NB1DdIvlZ5lfdK1jvE0NHMlbuHLq+1WIGtalaq6RaNeugoWtP6w4LGyL2UeguTuCbpJX
         eqqQ==
X-Gm-Message-State: AOAM5331b+/Y9PYSQVuri77Z82lBbyr3Rm1wmHSOM3Od9Pth5X/81K7A
        whFWYaSnO1pPzG97Qvb3o7f8/9D0trA=
X-Google-Smtp-Source: ABdhPJz8Phfz5SkXKY076rDKA8XYpeJVesSkgU55+xUsIGX7dO76mQ53zcsaKwHLHJF4W9GW1QKUsw==
X-Received: by 2002:a7b:c259:: with SMTP id b25mr3525319wmj.40.1609852154982;
        Tue, 05 Jan 2021 05:09:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i18sm98311640wrp.74.2021.01.05.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:09:14 -0800 (PST)
Date:   Tue, 5 Jan 2021 13:09:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: Re: [PATCH v4] hv_utils: Add validation for untrusted Hyper-V values
Message-ID: <20210105130912.5o6vtuotf4c6vwcg@liuwe-devbox-debian-v2>
References: <20201109100704.9152-1-parri.andrea@gmail.com>
 <MW2PR2101MB105203EB0E4889F2C716CE83D7C89@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB105203EB0E4889F2C716CE83D7C89@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Dec 13, 2020 at 10:07:06PM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, November 9, 2020 2:07 AM
> > 
> > For additional robustness in the face of Hyper-V errors or malicious
> > behavior, validate all values that originate from packets that Hyper-V
> > has sent to the guest in the host-to-guest ring buffer. Ensure that
> > invalid values cannot cause indexing off the end of the icversion_data
> > array in vmbus_prep_negotiate_resp().
> > 
> > Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> > Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> > Changes in v3:
> > 	- Add size check for icframe_vercnt and icmsg_vercnt
> > 
> > Changes in v2:
> > 	- Use ratelimited form of kernel logging to print error messages
> > 
> >  drivers/hv/channel_mgmt.c |  24 ++++-
> >  drivers/hv/hv_fcopy.c     |  36 +++++--
> >  drivers/hv/hv_kvp.c       | 122 ++++++++++++---------
> >  drivers/hv/hv_snapshot.c  |  89 ++++++++-------
> >  drivers/hv/hv_util.c      | 222 +++++++++++++++++++++++---------------
> >  include/linux/hyperv.h    |   9 +-
> >  6 files changed, 314 insertions(+), 188 deletions(-)
> > 
> 
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next.
