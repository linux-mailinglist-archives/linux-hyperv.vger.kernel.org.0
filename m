Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A210039E00D
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jun 2021 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGPQ7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Jun 2021 11:16:59 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:33384 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGPQ5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Jun 2021 11:16:57 -0400
Received: by mail-pg1-f173.google.com with SMTP id e20so2100595pgg.0
        for <linux-hyperv@vger.kernel.org>; Mon, 07 Jun 2021 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=w9BByRMZKAQXUpr54dyylHySYfSgHFJl9yDjRVwiTsw=;
        b=Hw7rsDP4LFaD1nBLEus3QVXb8s+vUM3f1hEHhkpWxUra8y7exgf9odvIeuRw0wwZ9o
         92o+J3cL58YRn6j/1ueVQBdbn5shzk516aOo1Dwje7sQ9bv7OuaBKe19uwT0To0VUXY3
         vySJblBMagiO2tpLoFdez9waHNNWHJkhm1wwPbTVDkxF6HsfDMpXtdczVeBe30v90HyQ
         /hx7EaNf7FuIYkjRi5I+x4Eolc0HZRiTkFtHs9+78WlvfZcZRmcimVk5oTND3lwF1pkF
         fgvU5/u7EIOdRdloeE7cWLAlsBPUCYOKsQxRK652EPntPiEBQMbQ4qfBqljoW9dlwvvX
         EWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=w9BByRMZKAQXUpr54dyylHySYfSgHFJl9yDjRVwiTsw=;
        b=Qvea7Ot3hMt9pYd1jKwvnZwh+L3AuJkfWRQpVfeis9p0MxVh3ZM0gkNnrj8JMBqow4
         GX31Tja2cv0noGr1e48vIsZysIrFG9r1YBmYmHp/ZmqbiK/Y+C5e0VOxrOX5zHzcuDmY
         Jdj7IYi9kpk5FawfivTxeBrhD067fGmH17dZ8pzvqDlolr+D3pcPfnbGZIvoeg2NO6Dy
         XVDpcffzWqaGVich+gbypnhsUsQihDtfbTkMBbooE0midjwI5y1WWeGx3OZBkYOynDNP
         bIcZluwgvrKFm7R66Ml/oRnBU6bVJ6+WVWKRb07mZ9twyIQ891CEA6aLtLz5D28eeMgs
         Hq3g==
X-Gm-Message-State: AOAM533P25CvMJ1vPH1aRmYtkGKFWWaZfUlb52eOSPxIBPTEeTbUF7PE
        WyWCGeMuOkB+Qu970BgV+L8=
X-Google-Smtp-Source: ABdhPJzkbqbn00oxDeNgrfeFkk/70y7ClxHMnfhAU+Dl/Y79tmtBMKaBZSM+u6kIDYynt7h+wgD3kw==
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id s4-20020a056a0008c4b02902b48334ed4dmr17286609pfu.36.1623078837577;
        Mon, 07 Jun 2021 08:13:57 -0700 (PDT)
Received: from [192.168.1.8] ([50.47.106.83])
        by smtp.gmail.com with ESMTPSA id j4sm8150430pfj.111.2021.06.07.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:13:57 -0700 (PDT)
Message-ID: <2cb17f7192b93dbcfb7355d6d237c88d8e58053c.camel@gmail.com>
Subject: Re: [PATCH v6 1/3] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Date:   Mon, 07 Jun 2021 08:13:56 -0700
In-Reply-To: <f58a001a-b411-78b0-bcfc-ca853b920a64@suse.de>
References: <20210527112230.1274-1-drawat.floss@gmail.com>
         <f58a001a-b411-78b0-bcfc-ca853b920a64@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On Thu, 2021-05-27 at 15:35 +0200, Thomas Zimmermann wrote:
> Hi
> 
> if no further comments come in, this can be moved in a few days.
> Since 
> you'll be the maintainer, you should request commit access to the 
> drm-misc repository. See
> 
>  
> https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html
> 
> and
> 
>  
> https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html
> 
> Best regards
> Thomas
> 
> 

Hi Thomas,

I have merged the patches to drm-mics-next. Thanks for your help.

Deepak

