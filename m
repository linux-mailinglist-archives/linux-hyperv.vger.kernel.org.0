Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD142C2CA3
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbgKXQTD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 11:19:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55466 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388568AbgKXQTD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 11:19:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id x22so2897224wmc.5;
        Tue, 24 Nov 2020 08:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PfnCueAGA03Kq3WrXMnEVjCnHQIAB19s6jaLxFSkI8U=;
        b=HJWBt+y8VYy2pWH3bGZtfRXr7JsfvT0+cCYVAOCe6dbfvyw1vB1SObucQlH+2bJ7dg
         /w63++/rEN7l5iLYZHQBuSJhplOK3MpaFEn4jYgbLGb8AV3z0rhHahwcwGYnr2PsHkyc
         MD9EGu9y8PrMj8GJyC1GA9gGWyjGxvVlGolV03PX4Yy7Y9qR+jSsVx2NMlapwRGwOLLy
         CiZsw+mzYCxsWiUeUYCyXkDjH817/F7NYHZQr4lZQpRiA9RPrxts7Zu2cxFWixYb0E06
         3nN9+Jvu+/B81EErEZqd6f+7okbEtOFOTw9T7jbfQ3/uP7Y4h3pwcOjtgUc02Sb3peUW
         5QmA==
X-Gm-Message-State: AOAM531NJy0zRoRoqwIDiyVv99Dmwf/tiqmwI8VjK96E/m7qn8q9gjQt
        OhKqBFEQEuog4KM4NNlhXs+xUHf5/s8=
X-Google-Smtp-Source: ABdhPJygHdrleMo3Y0Zv6r/FmRX24xQJF2ZCmzCbI5JqJyjkpZSb90YC/aNoCYrYkE+0jrys+Twlpg==
X-Received: by 2002:a1c:2b03:: with SMTP id r3mr5152591wmr.184.1606234741424;
        Tue, 24 Nov 2020 08:19:01 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h98sm23680174wrh.69.2020.11.24.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 08:19:00 -0800 (PST)
Date:   Tue, 24 Nov 2020 16:18:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 00/18] Microsoft Hypervisor root partition ioctl
 interface
Message-ID: <20201124161859.wkbyppzirf7nwggt@liuwe-devbox-debian-v2>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 20, 2020 at 04:30:19PM -0800, Nuno Das Neves wrote:
> This patch series provides a userspace interface for creating and running guest
> virtual machines while running on the Microsoft Hypervisor [0].
> 
> Since managing guest machines can only be done when Linux is the root partition,
> this series depends on the RFC already posted by Wei Liu:
> https://lore.kernel.org/linux-hyperv/20201105165814.29233-1-wei.liu@kernel.org/T/#t
> 
> The first two patches provide some helpers for converting hypervisor status
> codes to linux error codes, and easily printing hypervisor status codes to dmesg
> for debugging.
> 
> Hyper-V related headers asm-generic/hyperv-tlfs.h and x86/asm/hyperv-tlfs.h are
> split into uapi and non-uapi. The uapi versions contain structures used in both
> the ioctl interface and the kernel.
> 
> The mshv API is introduced in virt/mshv/mshv_main.c. As each interface is

Given this new file is placed under an arch-agnostic directory, please
make sure it doesn't break builds for other architecture. We can start
with running ARM builds for this series.

Wei.
