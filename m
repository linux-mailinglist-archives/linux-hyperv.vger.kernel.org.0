Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60517E9271
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2019 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfJ2V7S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Oct 2019 17:59:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34353 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJ2V7R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Oct 2019 17:59:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so8365726pll.1
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Oct 2019 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DpN5YTXrp9hp71uxbnpmiOwzB6GTFkwG/3T4Kj5BrEM=;
        b=qgkV77A9tGs/sOv5qzKPxPbYxXbujKalYxznr/KJcAe6aHZXkpz2sB7b0GwaCBdIk5
         3AwShV2aLjyJtqCJZqgIrvfLUdOfsdTOAyEBfQVvUPGmwf7VXSg3zyiZ+pVn2P1rBoOm
         6nvgQ1Bcrgd79MPUNP7FKGx5ZYxjvd7ZEWwpK6R7K2HHKzpWhgCf2T11tuSaV8QLDB7o
         Xt2ksQZgxh1ThsQ6ZZmzq8HgpVWKu0jwtyGXC9xc+Sngf75prU0+zt7cuJgjTOpdXglL
         Ku52vyE+ow5Vwet0EDpMTyWeX7GSlMnL8UK9bxhJR2CvrlVSy0cbXnvz+bKysuAUrCUH
         dL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DpN5YTXrp9hp71uxbnpmiOwzB6GTFkwG/3T4Kj5BrEM=;
        b=CTwdFDPDopcWYQt5utuH2+X7hf7Z8VTEDskFql1RbrgUmVY7vF+sFWeARu4Zy9A9Q1
         UHRqQ+PSqh2+dVaPGmBG0oN/mcEONufvgab3iEugeAYc7eggTv3dN6IKOM23T5Xixteb
         DJhF7DaaR7s7WMmkJtB8b5UzdqFsRHrQIHtzg5TAn1R6JXQII1Gz016NEtfC7fpx5LNf
         IM4JSzG6nZ6CpBnCrAeAUwI5BzxuqouhNDZoNtS0qDkN/qozKnGL/zbMoRPKmJfbGnRj
         x3W6b8BzyubPHLtqTHyyFCGuqD54Sk7X3XKijfJsrnICTBjXiHz1xEwpi46P/ZoSVi28
         ceGg==
X-Gm-Message-State: APjAAAUFXRZQ9AqNIROtQMYBv5QPIYImChHtLWuN22CnkhghLnomrWZJ
        2zuat0kdURN3398KzD1blX+HGg==
X-Google-Smtp-Source: APXvYqwNwn6ag5YudPb6b9eKtM6k1ulB0HqZ/o7WfnbelP889IRTVFDRbkId8DAH5pLmscTc97rObA==
X-Received: by 2002:a17:902:988d:: with SMTP id s13mr915958plp.335.1572386354831;
        Tue, 29 Oct 2019 14:59:14 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id j10sm85753pfn.128.2019.10.29.14.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:59:14 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:59:05 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next, 3/4] hv_netvsc: Add XDP support
Message-ID: <20191029145905.414f86c3@hermes.lan>
In-Reply-To: <DM6PR21MB1337547067BE5E52DFE05E20CA610@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1572296801-4789-1-git-send-email-haiyangz@microsoft.com>
        <1572296801-4789-4-git-send-email-haiyangz@microsoft.com>
        <20191028143322.45d81da4@cakuba.hsd1.ca.comcast.net>
        <DM6PR21MB1337547067BE5E52DFE05E20CA610@DM6PR21MB1337.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 29 Oct 2019 19:17:25 +0000
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> > -----Original Message-----
> > From: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Sent: Monday, October 28, 2019 5:33 PM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: sashal@kernel.org; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets
> > <vkuznets@redhat.com>; davem@davemloft.net; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next, 3/4] hv_netvsc: Add XDP support
> > 
> > On Mon, 28 Oct 2019 21:07:04 +0000, Haiyang Zhang wrote:  
> > > This patch adds support of XDP in native mode for hv_netvsc driver, and
> > > transparently sets the XDP program on the associated VF NIC as well.
> > >
> > > XDP program cannot run with LRO (RSC) enabled, so you need to disable  
> > LRO  
> > > before running XDP:
> > >         ethtool -K eth0 lro off
> > >
> > > XDP actions not yet supported:
> > >         XDP_TX, XDP_REDIRECT  
> > 
> > I don't think we want to merge support without at least XDP_TX these
> > days..  
> Thanks for your detailed comments --
> I'm working on the XDP_TX...
> 
> > 
> > And without the ability to prepend headers this may be the least
> > complete initial XDP implementation we've seen :(  
> The RNDIS packet buffer received by netvsc doesn't have a head room, but I'm
> considering copy the packets to the page buffer, with a head room space 
> reserved for XDP.


There is a small amount of headroom available by reusing the RNDIS
header and packet space. Looks like 40 bytes or so.
