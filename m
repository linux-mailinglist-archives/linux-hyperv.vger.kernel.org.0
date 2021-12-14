Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59999474D43
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Dec 2021 22:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhLNVhM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Dec 2021 16:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhLNVhM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Dec 2021 16:37:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B724AC061574
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Dec 2021 13:37:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so66861773edb.8
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Dec 2021 13:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9UTAK0b5L3KaubCL/oV4wrRC8fixbiMSCS/6uVmjtHo=;
        b=PhrXjkuoAM3dy70a2g+o9KOpM5toJ5WKKg332iwP4AVhrSsPo/oX4aH9XBRXCWVzGP
         /1Hw8PU+Dz67St7OzLpx6GAHC7Q5C0ke/yK4udPtTsPntsmHc1xMWhSq1LafRdEcBb7M
         s+kda2QWwAWBVtJcXytzdW+z+XAA9vAaq9cHRPH8XQyCGXsuoH2rCTjLBkhytEQihPnd
         bsQ8aFRielBwdEzJVklbOfscj5tsI1cxf2T/01BDHg77iv25jDKJ+T0KxiB4bJo/UzDL
         Don5PUNwgSNUyWoh6XJRG9cMF8geAtnMa6ZHUUhQd5kCgVES96SxduTn3iHL1fQmWrdB
         J1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9UTAK0b5L3KaubCL/oV4wrRC8fixbiMSCS/6uVmjtHo=;
        b=YCBp2HfRGt4evYOI2waRC3+tKo74tRcoMdYD8RVJnKA0KGWbg14H0BHeeLvx0oPui6
         NHuDgWuT6nS8HU0/yi+aUuWLf4xj38HRi74B2PcujkxdvpKWaVdxg8gm6VBCCufV2/Ff
         n7Uj67tIGjpWoOSOe2g5ePKp13vJKpf8RpmnVuufPorqRe+RFmHh3056eTVgNQzdPh3s
         jjvB4kgYBeuE+LAxpPAPLiNl/b1UMD28ssvlPi3DMNl6bpc8n98uaX74O5Ha+e1W7iq9
         IMVpZn6UIv7E832ANwWuJG5fZESUWq4kD1uxoC//Uu75dQspsyyWm9mDkAqziOA784S4
         ukoQ==
X-Gm-Message-State: AOAM532MfsMGiTuY66LXfi6rNV3+dTnqsdBkF32tEExbOhA3gsJh32Vk
        EszdD4W+ehPx32cuMbV3oqcu25bQKQw=
X-Google-Smtp-Source: ABdhPJxxCjQsv+yKbqJCBJgSzRrk1RYPayFa8mZSDOG3wz5f/uBRUdsOTGEoEhjUmEiOv7scAuVqtg==
X-Received: by 2002:a17:906:4fc8:: with SMTP id i8mr8642058ejw.427.1639517830211;
        Tue, 14 Dec 2021 13:37:10 -0800 (PST)
Received: from anparri (host-79-23-180-143.retail.telecomitalia.it. [79.23.180.143])
        by smtp.gmail.com with ESMTPSA id cy26sm17703edb.7.2021.12.14.13.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 13:37:09 -0800 (PST)
Date:   Tue, 14 Dec 2021 22:36:59 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Yanming Liu <yanminglr@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] hv: account for packet descriptor in maximum packet size
Message-ID: <20211214213659.GA2550@anparri>
References: <20211212121326.215377-1-yanminglr@gmail.com>
 <20211213014709.GA2316@anparri>
 <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
 <20211214020658.GA439610@anparri>
 <20211214042804.GA1934@anparri>
 <CAH+BkoE51_zAtgOo5ZGJk+32cycQ+OetL_U8hyO8oNMJaymAGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+BkoE51_zAtgOo5ZGJk+32cycQ+OetL_U8hyO8oNMJaymAGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Thank you for your very detailed reply! I'm going to send a V2 which
> should address all your comments.

Appreciated.  (Well, it might be worth to give other people/reviewers
some more time to process v1 and this discussion...  ;) )


> Provided that there are indeed drivers (hv_storvsc and hv_netvsc)
> which explicitly account for vmpacket_descriptor header, changing
> max_pkt_size for individual drivers makes more sense.
> However in this case I'm not sure about our reasoning of 'pkt_offset'
> above. In drivers/scsi/storvsc_drv.c:
> 
> #define STORVSC_MAX_PKT_SIZE (sizeof(struct vmpacket_descriptor) +\
>                               sizeof(struct vstor_packet))
> 
> Should I also change this 'sizeof(struct vmpacket_descriptor)' to
> VMBUS_MAX_PKT_DESCR_SIZE? Otherwise this would not match the check in
> hv_pkt_iter_first.

AFAICT, the above #define is fine, i.e., it represents an upper bound
on pkt_len as used in hv_pkt_iter_first() (this is all is required on
max_pkt_size, cf. the memcpy() in hv_pkt_iter_first()).

The same consideration, AFAICT, holds for NETVSC_MAX_PKT_SIZE.

The remarks about pkt_offset targetted the cases, such as hv_balloon,
where we can somehow upper bound

	(pkt_len - pkt_offset)

(the "packet payload"), since then an upper bound on pkt_offset would
give us an upper bound on pkt_len "for free" (associativity):

	ptk_len = (pkt_len - pkt_offset) + pkt_offset

  Andrea
