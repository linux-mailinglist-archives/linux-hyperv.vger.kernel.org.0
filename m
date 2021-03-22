Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6C343F43
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 12:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCVLIs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 07:08:48 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34481 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVLIT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 07:08:19 -0400
Received: by mail-wr1-f44.google.com with SMTP id j7so16235383wrd.1;
        Mon, 22 Mar 2021 04:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rfC7CxUBGsu2Z3JQvrV0vKsQI0VkmbDV6Dx6XfuqL38=;
        b=WDkiBLl1OwxDlqe5c3buXbNZ4d1ZnlX8ebF8ZpI6fa6ECs5Etgqpe74GL/kTVV/mjo
         6k7r/IC8XlQrvByIxxpjpHsfh3s8194Hc8MvRivhamqLur3Kquvbm/RWuYOSTR5vrzQ6
         Zgu/6CLWKc4emYNMOue7t5k+vYDywSJH2I8+dBJjDdwkSOskzNxVkqwgzB+NTNxTenJu
         IH1wi7660IQKJyaIp0h1tT+FQNeH9hj0WjTTZZdYSHM3qZLqEorDNBtC25qlvdWwfuyC
         xNgQBpWOUbhQp5lIwPhjnsxgbSdmtO/NHiFewL5AOsWMbLcHf7aupIGgpP0NEciuEC55
         8CrA==
X-Gm-Message-State: AOAM533nxHL44FwtBb9b7dG89pjoEOTdSuOmH3Ml2wclEa0n0iYHJ8i3
        eD8dyzSuB+Bnzwk/qHtITgY=
X-Google-Smtp-Source: ABdhPJzm+nVtptYIBKlaTHL6SWc93UqGNzQtGpyEeIsUq1KTyUWg7jaeSbQykSAmJhNm0A1K/HoXiQ==
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr4780106wrs.415.1616411297639;
        Mon, 22 Mar 2021 04:08:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c2sm16198399wmr.22.2021.03.22.04.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:08:17 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:08:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hyperv: Few mundane typo fixes
Message-ID: <20210322110816.hmept3iizchix43y@liuwe-devbox-debian-v2>
References: <20210321233108.3885240-1-unixbhaskar@gmail.com>
 <97467DD8-0B7A-4555-8334-4C3470909A2B@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97467DD8-0B7A-4555-8334-4C3470909A2B@infradead.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Mar 21, 2021 at 04:41:53PM -0700, Randy Dunlap wrote:
> On March 21, 2021 4:31:08 PM PDT, Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> >
> >s/sructure/structure/
> >s/extention/extension/
> >s/offerred/offered/
> >s/adversley/adversely/
> >
> >Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 

Queued for hyperv-next. Thanks.

Wei.
