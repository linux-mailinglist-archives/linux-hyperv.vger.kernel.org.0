Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF15372A77
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 May 2021 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEDM42 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 May 2021 08:56:28 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42748 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhEDM42 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 May 2021 08:56:28 -0400
Received: by mail-wr1-f51.google.com with SMTP id l2so9295687wrm.9;
        Tue, 04 May 2021 05:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bwlozJ2enkuBnE/lgtCwhaK3slFs1dgtbHZW66LEkrY=;
        b=pMb4c9FvCjrN1pECEoqlyF1pqTPToFEEA6ybgMrIERsXmhiXNsukDKbfxQrMmVu8pO
         n3zgID7bMQn44G82KW/7srMbRasd2eOsRu5KPoUY8tbOy6gFSxtflbZK6ySjOukNLX26
         PWmRgxjUgl0KkwXECY80lT8ALJngHIbZcLR88m2kJKYyFHhpMDiPZ7KRDYS4M0f4Q0KF
         0lNorUmZ9rUSEIukLpFNNd1zE48p1UgGcb365r9qTJTWh+iraT9TxTjw0hfE6QDuQrqf
         URlAztJN3CQWVPJovgC4tTF6Xa/mC2/1+imP3I5zLloMdJR+vV8m7UQR98pqyy9a5WCA
         60SQ==
X-Gm-Message-State: AOAM530wKhk8NzYm/00LBLT2hu5y8Ksae4EDItMdRETWbwrfZaglvF85
        z6gzlPjgcP5udzeeXE2aBiw=
X-Google-Smtp-Source: ABdhPJzmtR94dpyO0/fahVStHgJMAVGUncFVi0jMizg+Hi723TtuYsDTQP8uGI59lc+d5PKUCSSDoQ==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr31866402wrw.166.1620132931494;
        Tue, 04 May 2021 05:55:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e38sm2247810wmp.21.2021.05.04.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:55:31 -0700 (PDT)
Date:   Tue, 4 May 2021 12:55:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nigel Christian <nigel.l.christian@gmail.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] hv_balloon: remove redundant assignment
Message-ID: <20210504125529.jxgok6nyuq4b56o6@liuwe-devbox-debian-v2>
References: <YI7QsN9cY/Z9NgW4@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI7QsN9cY/Z9NgW4@fedora>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, May 02, 2021 at 11:17:52AM -0500, Nigel Christian wrote:
> The variable region_start is being assigned a value that is
> not read. Remove it.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>

This is fixed by a patch posted earlier, but thanks anyway.

Wei.
