Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1549E30D7E6
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 11:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhBCKqe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhBCKqd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 05:46:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5ECC0613D6
        for <linux-hyperv@vger.kernel.org>; Wed,  3 Feb 2021 02:45:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id w4so3699884wmi.4
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Feb 2021 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MVpfgjgZPTz6f32gWjv+x7e+FObjpAP1WDjql8LPar0=;
        b=V2XD7YyZGgy5HlcP65y2dQ/8XxOi6wLOTStIdqeQKGwy6VTmaQZaLrmPUXpk7aycx1
         h8GTVbDsP6Nz6ZgnmRYpMJUFOb+4LHZ0+8ZTAAGDNu1QeU6AA40QTwSECU8/hP1RjVpP
         RnjAtqbAozfj2VKad52aG4x74J8kXgluff2mh3Z3f08c3Qkd9+6la6kiepQXdEWHRx26
         6/D/mlYCDoFqiDJw6LbqINE55OclcEC/BtTes01dg3bIDdBdaQwWb3PX5CNMAgH3OJRR
         mcuNkDQvWz/jxkHIhaIetOXGFVafAOLZlddHS8pYzxpHvMQNp61kMmigqH0sOdII1cqv
         5Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MVpfgjgZPTz6f32gWjv+x7e+FObjpAP1WDjql8LPar0=;
        b=K4K36OIwonJNpcRiyABWjcwlkt65+9b2+XhkObVjTA+mD8/7AZ/FSAvljfosIiCZNp
         ErLC6fFJgv9VHjIiJWjxD9cE2mDOHCSFMH8xri6i5QvDo0mIWb/EL/5iy2W1eP1adyKs
         IPms4S9fERh/X4ZbknAP6Z/qbx0HWQtXwbIasaI1ENoUp5ABPIpg7QMkMd3YuWQhaZd4
         2cottyHKiwW8xf9oT9FCsF6556h8jhvEoUKPQ/O69c7SKfhMy7o2U98in3Z1Yz82VfpX
         3Fh6Zcyzwee5vhwgRYQ1GQd6fKUbBQhiZaY0efrY7A9cmcy3t9t7fMPMMtD0SXxyGgFe
         yQlw==
X-Gm-Message-State: AOAM532QjU43Nr43D69xLvr09TNhRctNWrZLpfKn/Oa2FQ9z0McMo3o1
        NwrZsQSDSs1mKeIsaYPPQru1jCpmdGtzPg==
X-Google-Smtp-Source: ABdhPJz5GAWmhgg88fQ0Pt+wPD4H552iEDxel1+WME8CUcoz4MjA2Or/OaaUFUd+PxrgdyXRWebcPA==
X-Received: by 2002:a1c:dd55:: with SMTP id u82mr2221545wmg.135.1612349151813;
        Wed, 03 Feb 2021 02:45:51 -0800 (PST)
Received: from anparri (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id v6sm3147295wrx.32.2021.02.03.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:45:51 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:45:44 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-hyperv@vger.kernel.org
Subject: Re: [bug report] hv_netvsc: Copy packets sent by Hyper-V out of the
 receive buffer
Message-ID: <20210203104544.GA558156@anparri>
References: <YBp2oVIdMe+G/liJ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBp2oVIdMe+G/liJ@mwanda>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Dan,

On Wed, Feb 03, 2021 at 01:10:41PM +0300, Dan Carpenter wrote:
> Hello Andrea Parri (Microsoft),
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 0ba35fe91ce3: "hv_netvsc: Copy packets sent by Hyper-V out
> of the receive buffer" from Jan 26, 2021, leads to the following
> Smatch complaint:
> 
>     drivers/net/hyperv/rndis_filter.c:468 rsc_add_data()
>     error: we previously assumed 'csum_info' could be null (see line 460)
> 
> drivers/net/hyperv/rndis_filter.c
>    459			}
>    460			if (csum_info != NULL) {
>                             ^^^^^^^^^^^^^^^^^
> "csum_info" can be NULL.
> 
>    461				memcpy(&nvchan->rsc.csum_info, csum_info, sizeof(*csum_info));
>    462				nvchan->rsc.ppi_flags |= NVSC_RSC_CSUM_INFO;
>    463			} else {
>    464				nvchan->rsc.ppi_flags &= ~NVSC_RSC_CSUM_INFO;
>    465			}
>    466			nvchan->rsc.pktlen = len;
>    467			if (hash_info != NULL) {
>    468				nvchan->rsc.csum_info = *csum_info;
>                                                         ^^^^^^^^^^^
> Unchecked dereference.  Plus this has "csum_info" on both sides of the
> assignment so maybe it is a copy and paste error?  This is equivalent to
> the "memcpy(&nvchan->rsc.csum_info, csum_info, sizeof(*csum_info));"
> in the ealier if statement but stated as an assignment instead of a
> memcpy().

Right, I did realize about the error and I'm about to send a fix for it.

Thank you for the report,

  Andrea
