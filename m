Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7441DC20
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Sep 2021 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351848AbhI3OTV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Sep 2021 10:19:21 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:45840 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351847AbhI3OTU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Sep 2021 10:19:20 -0400
Received: by mail-wm1-f47.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so4464712wmb.4;
        Thu, 30 Sep 2021 07:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOE2ZXv6/ohdVEYBDOXN3bsh02Jm0EECQwgT7jaeZq8=;
        b=mv7yDykKHq5NjtBZI9rol85LK+cJ4dvSbF+K9yzm36lhcW2fCuKuTmmlnTjCMxOy3/
         VnHqxZZDXiuI3+hZw02u9No5vRBINOx+mxguuG3H0x9tyZsQMBy+NuDRRA7eBvN/3VG1
         +iiL/1ZT6lRE+jlJPLXXPlrq7/MjDAlf1884DzrNk7EJDpSzX4ynkUhyAKBQK66NvkTo
         vDL6G2J9jHC0qIEBDwH6Aod80kpGq1dMJEkPQZtYGujK5rYOQ9jc7nU/pPmwtN+3iU47
         VquywVywCN6xicc1yc4eJ5J/DfJebhPO+f4x5hMpTHsgFS8BUA67rk7gaTBDJkNFo4KS
         iXgQ==
X-Gm-Message-State: AOAM531bZUvVYiIx8sO3WrvOtzbDXQ181PHZGIuYWnQ/enk+Cl5lGub7
        WbKhLd+00XSAKAG5xTy/Cgs=
X-Google-Smtp-Source: ABdhPJxlBkzKS/yqhsfa80B9ui+ui+TkEaLfkkBFrpGRpvpX5Z2TTYWXbY3MDyhndwBhylit9aLy3Q==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr1457552wmi.112.1633011457263;
        Thu, 30 Sep 2021 07:17:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 61sm3046467wrl.94.2021.09.30.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:17:36 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:17:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: Re: [PATCH v3 08/19] drivers/hv: map and unmap guest memory
Message-ID: <20210930141734.gx2th6sz6dbnyr6m@liuwe-devbox-debian-v2>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1632853875-20261-9-git-send-email-nunodasneves@linux.microsoft.com>
 <20210928232702.700ef605.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928232702.700ef605.olaf@aepfle.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 28, 2021 at 11:27:02PM +0200, Olaf Hering wrote:
> Am Tue, 28 Sep 2021 11:31:04 -0700
> schrieb Nuno Das Neves <nunodasneves@linux.microsoft.com>:
> 
> > +++ b/include/asm-generic/hyperv-tlfs.h
> > -#define HV_HYP_PAGE_SHIFT      12
> > +#define HV_HYP_PAGE_SHIFT		12
> 
> I think in case this change is really required, it should be in a separate patch.

I don't think this hunk should be in this patch. It is just changing
whitespaces.

Wei.

> 
> 
> Olaf


