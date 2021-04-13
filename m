Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACDF35DD72
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbhDMLKP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 07:10:15 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37778 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345295AbhDMLJc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 07:09:32 -0400
Received: by mail-wr1-f49.google.com with SMTP id j5so15042601wrn.4;
        Tue, 13 Apr 2021 04:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3TewBmGXdgtkv54qxfxiBx7mOKZlZK5eRltyB8fduM=;
        b=FzgxESxr6n/bIo/CMaKR1zntOhSTt/bnJjzkY21564fy//ruK9S+HkQb/0rMMYibFX
         j8bBLRav9EgsKLpds7N73rI4H2wSxroLrmvTphQbyr4XAwvV10kn9f1ciHpgG9x7Rj5h
         Hw9Jj2nRC/2HSBO4EMqJk657XqiHkPKcUvCVdG2AFVTQQ13EouLQRPERxGXubzkax1pC
         avnJRV6FvADM6/vVn3ump7e7R7RFECci5LxvKU5OF+oWeNe0yOiAmBpbWR2bONaKvyG/
         thU73twrs7VFkflx1tiXW3gzEThMUnaPNgpHJE2e6n0UdeX33b2pPAd23sgCptrAsoTC
         nVig==
X-Gm-Message-State: AOAM530UyVkXwgA9cF6DOv8/fTNtFYY77p5s6xxfA5Qa9/ts039rj256
        vGVy8lfJEtC3wUGzNLfykFLZenr09AA=
X-Google-Smtp-Source: ABdhPJzGotePmavs2zmOyjWJSPIDjQxDgq4kl84fOK2KC3FTQB0D9yEk29kZqZzuxmJ9ltUaWrKA3w==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr36779739wrw.292.1618312151689;
        Tue, 13 Apr 2021 04:09:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n9sm2102942wmo.27.2021.04.13.04.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:09:11 -0700 (PDT)
Date:   Tue, 13 Apr 2021 11:09:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: remove unused including
 <linux/version.h>
Message-ID: <20210413110909.jtv7vmo7lo3fqv54@liuwe-devbox-debian-v2>
References: <1618307358-74492-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618307358-74492-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 13, 2021 at 05:49:18PM +0800, Yang Li wrote:
> Fix the following versioncheck warning:
> ./drivers/hv/hv.c: 16 linux/version.h not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for the patch. This has also been reported by Huawei's kernel bot
and fixed in hyperv-next.

Wei.
