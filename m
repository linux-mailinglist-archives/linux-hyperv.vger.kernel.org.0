Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D93244A50
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHNNSo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 09:18:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37097 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgHNNSn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 09:18:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id k8so7911665wma.2;
        Fri, 14 Aug 2020 06:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nW1mtRgL1XPVv74zZPLtcR28WG0ZBkgaQ4n0Ou81IOY=;
        b=AezT62nc5aXV8rczhV5hj1z1i0FEqsyjtlt6P5nstYMy311bEi/GsX1sEXcLS4qbt4
         eEMNxtkG2RAQ/TzDNt4Rx9UhPRHC7v+LQA77eh6CBG0w9xxc5ZOjXHEyABPK9ZiTQKqS
         hq85y/c1z4tOlAK0igXaRUi8lePnmX9lwZNKO0CHvZeKsoOkQ3hbRaPvCn3a/G8B6gdW
         Fb3oYh3m1r4l7kBQ22fKmDQMK0sTc+CrSfbeUX+dz2FlSCUTDzeAAxNGOWjZ+DHK0EUX
         IcCznjGyh3hhEv5RS4BRoY4zprNwf2z51bLBtI0g1Hvl0jQTEfVird/tevbwrXjehPJ/
         UUvA==
X-Gm-Message-State: AOAM532yf2yud27diZyvDdC7yrniejPAM6OY9SSN8kJubB8SdsOt3YCK
        7j67kjYgm+Zose5++AX20VnFqNS/uII=
X-Google-Smtp-Source: ABdhPJzImgQ7+albyhkIntvqwF9TOUH9EivjkXRcHdb+Bd4MUIRqvcFpb4iRh4yCuJ5Wcj2Hn6KPIg==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr2515326wmh.39.1597411121294;
        Fri, 14 Aug 2020 06:18:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n12sm15988512wrq.63.2020.08.14.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:18:40 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:18:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200814131839.u2vy52mtiejtuwcg@liuwe-devbox-debian-v2>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814123856.3880009-2-sashal@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
[...]
> +
> +#include "dxgkrnl.h"
> +
> +int dxgadapter_init(struct dxgadapter *adapter, struct hv_device *hdev)
> +{
> +	int ret = 0;
> +	char s[80];
> +
> +	UNUSED(s);

If s is not used, why not just remove it?

Indeed it is not used anywhere in this function. That saves you 80 bytes
on stack.

> +static int dxgk_destroy_hwcontext(struct dxgprocess *process,
> +					      void *__user inargs)
> +{
> +	/* This is obsolete entry point */
> +	return ENOTTY;
> +}
> +

Other places have been using negative numbers for errors. I guess you
want -ENOTTY here too.

Wei.
