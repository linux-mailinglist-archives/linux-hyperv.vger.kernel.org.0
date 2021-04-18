Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834D7363560
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Apr 2021 15:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhDRNFK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Apr 2021 09:05:10 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38476 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhDRNFJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Apr 2021 09:05:09 -0400
Received: by mail-wm1-f41.google.com with SMTP id d200-20020a1c1dd10000b02901384767d4a5so524089wmd.3;
        Sun, 18 Apr 2021 06:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1LrlAqtiFgtoKglNGwZGQnK56yMv94tK8QFQsoakxk=;
        b=SqHRBMk/vV9CW6DD+2rWeztBs804aMOBZ3SUvxGHGgSQwsTTCuUH91vq/XZZ59uH0L
         ufz7rYi3G9eJhS4ElNPAOhgs9fMcg+AhmBMWV+xQBmGjG68+I3A1a/U9rzH/BTSUbSu5
         TAvfVogSaWO7puUVRBJgkImn6epFHkw7kr1g0aH4dcJr6k/V96qIRUhL9ySh8rEZDhIF
         2IITEH9bGboKQpX5Tri9/YsDfN2hTVgfXGCP3KhACAaGo7+kQ5iIM+KwUudTnNrMC0Jh
         iPB+IJDU1oWhM/UKY4AGdY2Wn+4czJVpUU6VmlYuJj77u+2WKh7EhNozpaX4GcTEUCsJ
         KlOw==
X-Gm-Message-State: AOAM5324IaeJpf0ag6FHmIRAcgHVhe132rBGxsXFYSioOQ4fkTF+h+X5
        cO26SFohvnZRDlGQhhXn/As=
X-Google-Smtp-Source: ABdhPJxHmLlltTJgWMnh3nSxBbbPhVc1xXMiRilxIjPHRyOF7zwQU1l4RwZ1KRbQQT8OQ9MGixnwbA==
X-Received: by 2002:a05:600c:2d56:: with SMTP id a22mr17039179wmg.175.1618751078854;
        Sun, 18 Apr 2021 06:04:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t63sm16409115wma.20.2021.04.18.06.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 06:04:38 -0700 (PDT)
Date:   Sun, 18 Apr 2021 13:04:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v3 0/3] Drivers: hv: vmbus: Introduce
 CHANNELMSG_MODIFYCHANNEL_RESPONSE
Message-ID: <20210418130436.pfubar442swyxqoe@liuwe-devbox-debian-v2>
References: <20210416143449.16185-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416143449.16185-1-parri.andrea@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 16, 2021 at 04:34:46PM +0200, Andrea Parri (Microsoft) wrote:
> Changes since v2[1]:
>   - fix VMbus protocol version name
>   - add Reviewed-by: tag
>   - refactor/simplyfy changes in hv_synic_cleanup()
> 
> Changes since v1[2]:
>   - rebase on hyperv-next
>   - split changes into three patches
>   - fix&simplify error handling in send_modifychannel_with_ack()
>   - remove rescind checks in send_modifychannel_with_ack()
>   - remove unneeded test in hv_synic_event_pending()
>   - add/amend inline comments
>   - style changes
> 
> [1] https://lkml.kernel.org/r/20210414150118.2843-1-parri.andrea@gmail.com
> [2] https://lkml.kernel.org/r/20201126191210.13115-1-parri.andrea@gmail.com
> 
> Andrea Parri (Microsoft) (3):
>   Drivers: hv: vmbus: Introduce and negotiate VMBus protocol version 5.3
>   Drivers: hv: vmbus: Drivers: hv: vmbus: Introduce
>     CHANNELMSG_MODIFYCHANNEL_RESPONSE
>   Drivers: hv: vmbus: Check for pending channel interrupts before taking
>     a CPU offline

Applied to hyperv-next. Thanks.

Wei.
