Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC19347782
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Mar 2021 12:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhCXLhD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Mar 2021 07:37:03 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37794 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhCXLgW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Mar 2021 07:36:22 -0400
Received: by mail-wr1-f46.google.com with SMTP id x16so24078774wrn.4;
        Wed, 24 Mar 2021 04:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E3zu3hgn6dTzJYeSkiy41tbdRXf2yBGvrgXEBWgvbao=;
        b=DseNVkfQcyWK+Q6nvs9HKBKcyZnEw5q1jEmyyrHk8CnWgfmUWUxcC/ZKwRlBtVkgXO
         S9BoH+8i7EStYPFC2W/Yf6Lz1d3zojBwwFkhN+umN2E0NHake9K9k3d7cNZ9oG+T6DRF
         xdTUffv1L0dCO2XDOzZLcFGPo6kvERLOGTGGR3ZdwrcKJTBAdm0dO5F0TicwYXB09m/d
         eJvq9LJ2LJ+aGas9QUAG4EBEIlsr1weiH+qAsvnRsEdJNvX1gB20GcMCrzP+pbSMhrgY
         USnB9kA5htDYjAItSIJj9KkZnBxi0DpDQ2IKi21KUJdSwzRA6ZCWdaWhLAdLczj9Hw6t
         Z3gQ==
X-Gm-Message-State: AOAM532AjilDclPAqizrfS+YmjQs2XVLzTtvSM5BeBPpPvp5g0A4J5ck
        O6TyojQiRzPa+6MpfGrz2LU=
X-Google-Smtp-Source: ABdhPJwVwcCws/QINC9NTPGGfg0/PzjoO607FicEXelC7jumTvWZTgtOUVNTbFWwOW2jKlohQRCF4Q==
X-Received: by 2002:a5d:6312:: with SMTP id i18mr3030212wru.149.1616585764783;
        Wed, 24 Mar 2021 04:36:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d204sm2190354wmc.17.2021.03.24.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 04:36:04 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:36:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v5] x86/Hyper-V: Support for free page reporting
Message-ID: <20210324113603.rtvczlrvdp6vhl7e@liuwe-devbox-debian-v2>
References: <SN4PR2101MB0880121FA4E2FEC67F35C1DCC0649@SN4PR2101MB0880.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB0880121FA4E2FEC67F35C1DCC0649@SN4PR2101MB0880.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 23, 2021 at 06:47:16PM +0000, Sunil Muthuswamy wrote:
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Tested-by: Matheus Castello <matheus@castello.eng.br>

Applied to hyperv-next. Thanks.
