Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8691E8BAE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2019 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfHMN4z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 09:56:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35938 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbfHMN4z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 09:56:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so1542298wme.1
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Aug 2019 06:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9SWKHAYzBe41Ol9gswyfxjexOkRqsX5G/TdknhMFVq8=;
        b=EmaXdOSC8zGzm0KgjO8PtB2xteUjXZ7dZuaz/QX/Il1CA9JhrT4gr739v7yKrzvm3u
         61qj0B7axTQ4O2AYpxZHD/Hjozn2VXAebOPoDgPALOqEwtmvxdEuKkzR9oSVJBOC7T3l
         RgOTv3cZtW6A+JCIa6EX/XszRcL4pIrqt2dw2/D8tVELclZRoYF2sLYVaDsA6Gw3OL7j
         gkIlP3Cm1xoTDJqtvWMnBaRmJHNkliEN3bK43oLHHVfsL1pmn5vysgJC+LynWd0WXtK3
         E7I+OGtEnubSi8GeY9LT8mUFIubEBOW/XL+m3i3465MPhc3Pnv+jIK6Sla4WpxWqip4P
         5Ztg==
X-Gm-Message-State: APjAAAWwD7LiTfD0/IogImlQEs51Uhgq6vRytDS16B7e2ac7K4zSlc80
        FU5Fq53+7YX2jSeqVyF0QHtaIQ==
X-Google-Smtp-Source: APXvYqzkcyUcteVlgxvQGBrtOPqeRLtcHQb+IMNCpUQGwbWcEyBW+FrNU3lnylGez+r6EeY7H5WxyA==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr2969799wmj.37.1565704613440;
        Tue, 13 Aug 2019 06:56:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m23sm2203685wml.41.2019.08.13.06.56.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:56:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v1] Tools: hv: move to tools buildsystem
In-Reply-To: <20190812182716.GS30120@smile.fi.intel.com>
References: <20190628170542.28481-1-andriy.shevchenko@linux.intel.com> <20190812182716.GS30120@smile.fi.intel.com>
Date:   Tue, 13 Aug 2019 15:56:49 +0200
Message-ID: <87lfvx9nj2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Jun 28, 2019 at 08:05:42PM +0300, Andy Shevchenko wrote:
>> There is a nice buildsystem dedicated for userspace tools in Linux kernel tree.
>> Switch gpio target to be built by it.
>> 
>
> Any comments on this?
>

Minor nit: "gpio target" in the commit message should be replaced with
"Hyper-V daemons".

-- 
Vitaly
