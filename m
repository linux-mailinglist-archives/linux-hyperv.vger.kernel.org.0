Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E1330EB2
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Mar 2021 13:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCHMwF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Mar 2021 07:52:05 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40037 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHMvp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Mar 2021 07:51:45 -0500
Received: by mail-wr1-f52.google.com with SMTP id l11so7926419wrp.7;
        Mon, 08 Mar 2021 04:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=plD+o+Jxx1PVs4NJ0L7RjHbAAb9kxmaVe9o1W14R6tA=;
        b=LiqONeKCohF2dWqJwPdf4b2xiYU52sl8jaqHEPwXNxGdCq7xr4Hu2WrSUvPMFYUHp/
         9EzoVRrhx+bpNRC2ws03nlEBgp5CSrmoP29ebQu6umwqqR1g0GvmT0ghpHtVR68OAlkq
         cjkWsO5dGrzYXOnXoQ9nG5LMFszY60zms5UWFB8sTJUph5d78GnpZz2sRB3651FLaxqs
         AHn9aP3rBTKteWPmSrBvEV8h0UyjXeB6+g34s6x2RqAI/MJ3UxysIl8GIYcemhY8lpMC
         mzZoFxvFaJiXUUeJ7zXNMhu5yePXaiNRYQbgXAMdPY/z3qIHCm0t4KWfZB8NjAr/duFs
         6TpQ==
X-Gm-Message-State: AOAM532bEwuBXsLh9TIlyw3F9XQPx2EE12tVAHmTv0hI04NxDFgpLb+W
        ZcDAXLvp8uUIWkolCSi3IOI=
X-Google-Smtp-Source: ABdhPJz5Dv2eRBhcZMLXVZdBcKx8ydbnyZaR1yEKMXvNzaOBYxWMy0xXGkuepkVM8aT8zZikpwfNEQ==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr22748855wrq.143.1615207904056;
        Mon, 08 Mar 2021 04:51:44 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f16sm18073439wrt.21.2021.03.08.04.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:51:43 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:51:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vasanth <vasanth3g@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: hv: Fix no spaces issue
Message-ID: <20210308125142.qduin4fwy32rilyw@liuwe-devbox-debian-v2>
References: <20210305160449.22822-1-vasanth3g@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305160449.22822-1-vasanth3g@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Fri, Mar 05, 2021 at 09:34:49PM +0530, Vasanth wrote:
> Fixed code spaces issue.
> 
> Signed-off-by: Vasanth M <vasanth3g@gmail.com>

What do you mean by "Fixed no spaces issue" in the title?

I can see you deleted an empty line and changed some tabs to spaces.
Please be specific in the commit message.

Wei.
