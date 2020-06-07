Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC871F0C78
	for <lists+linux-hyperv@lfdr.de>; Sun,  7 Jun 2020 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgFGPnO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 7 Jun 2020 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgFGPnN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 7 Jun 2020 11:43:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DDCC08C5C3;
        Sun,  7 Jun 2020 08:43:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gl26so15464778ejb.11;
        Sun, 07 Jun 2020 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QCe7MTPBluIQ+Z4ZBffv4cvKmqrkB70PcCAPj5Z/6/M=;
        b=PURl8DuPm18P85nvRkNFBSVL56dyuzstSURexfOKdBK8mcAm3gyieRPV3BlgVa3SSE
         N0wW8j4f11D+ttsY+i3qVNHBnXa39L8BSI62z7AM6JWKDZE+/gQzBa5Z6CHtV9xpgxV7
         YkTVmcgCjU5DylWKrmJycRLfWKDJKvzUlt/Ul9DK/Q73l8RjJ8oWNTrbRqhifmZinZYM
         jyMRBvVpbieP7ndnOv/6WHW9S3AZtGWDaH7O2U7ldJ/u97UESY9HZrWYYQYjOtV620+3
         Lot10ftS5416syWttEH5NflrM0/vix58FQefD1dNP3lUa3aeRpDscZwAdI7GCmt5v4KS
         2Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QCe7MTPBluIQ+Z4ZBffv4cvKmqrkB70PcCAPj5Z/6/M=;
        b=EFFdoPEPLa5yuS2RbUMXsq0tq7HV1UPMf4IMuGznoy3nRJRAlZKulB/1bJh0QglsVW
         KPRyFtnP1CZPsrE+FsPmOD5Ov7K/5QKYT7xJF6wKD2wXLAMmZlQ0wmdvTEk2WQcdLHSc
         FQwgoRhCDVdSB+2sJ7XXYlsx4nyzatyZxYBdBQTOz8K5r3KG+HD3d4KBJ0aIvNZxV8j4
         M869kppJWRJ7DqzfwoOpiKQCTto91giuU6XTvBRZIGnNXQHGclSoDnRyVjT3l25ZX74A
         ry/kr9ipIS8k04FU93oU56wPzfNX8ocUMXNWe+rjRbxN98H/8SJDyInRurvGpORxJww6
         1qnA==
X-Gm-Message-State: AOAM530alrlj7rd7xqXoOZnU2ff9xT97jjgZpsXr2TbbVwZRGPhuTrKU
        mChn7f0FIsAczIsW1oZklMEDo16cs6wGIw==
X-Google-Smtp-Source: ABdhPJxNQ9+nxJwOsJeEozyjH/xmSciV4dHlbIHLKHmqctmbT0MNAgwDY4ybECcF32Vz8qtYUYKbKw==
X-Received: by 2002:a17:907:20e5:: with SMTP id rh5mr17929162ejb.80.1591544591522;
        Sun, 07 Jun 2020 08:43:11 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id ce16sm8638425ejb.76.2020.06.07.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 08:43:10 -0700 (PDT)
Date:   Sun, 7 Jun 2020 17:42:59 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Nuno Das Neves <nuno.das@microsoft.com>
Subject: Re: [RFC PATCH 0/2] VMBus channel interrupts re-balancing
Message-ID: <20200607154259.GA10780@andrea>
References: <20200526223218.184057-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526223218.184057-1-parri.andrea@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> These changes originated from (and address /try to resolve) two known
> limitations of the current interrupts-to-CPUs mapping scheme, that is,
> (1) the "static" nature of this mapping scheme (that, e.g., can end up
> preventing the hot removal of certain CPUs) and (2) the lack of global
> visibility in such scheme (where devices/channels are mapped only "one
> at a time"/as they are offered, with the end result that globally the
> various interrupts are not always evenly spread across CPUs).

One thing I didn't mention here is that, well, we probably don't want
any of this when CONFIG_SMP=n:  clearly, I didn't pay much attention
to (optimize) this config in this RFC (FWIW, neither seems to do the
current mapping scheme) but I'll look into this if there is interest
on this regard (once back from vacation of course  ;-) and, probably,
at the cost of adding some #ifdeffery to this RFC).

Thanks,
  Andrea
