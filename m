Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32E13D21FD
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhGVJgd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 05:36:33 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:44670 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhGVJg1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 05:36:27 -0400
Received: by mail-wm1-f52.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so2645353wmq.3;
        Thu, 22 Jul 2021 03:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4DmojrWABcQVlY2JAEMHeaPpJ9rs1JXLkJFRYF2rXo=;
        b=kavAuKZcL/46j82GlOFpNRwwjUadXguzOpFleDi+gGJ0XRSEd7wHQyjMFPaaGJJfAD
         L3kFQjceA2MQEHx4BBxBwIiYxC4yj1WDxK51zNCzVNjolqHKScoqdTUigg2Im6b1M8Ik
         cGkEueT9xew13CfTlChgJ/EjAQsTpPW2h8RYyFpZqKRpLdAo/ETLybj3uV4a/14kOBvS
         c2/jAxU7MdnuWJEE3ecRLN54RDQBT3gBn96rhMG8BgBQHyjKAT0hVSUwL7RugO+lA215
         0aIOdwb+bKk6f2RoTu4nlzCs789CXcC5q7w6I80fkhgIloi9bPlPOBnDyoyrHltEc527
         wNyw==
X-Gm-Message-State: AOAM530xhtpvawnrmR1si2ybDN7q+YSjIpCKGRbquIkTecObjJzFESHu
        cGkrFDY4WnYawadJ1i2p7sA=
X-Google-Smtp-Source: ABdhPJzEAoS6ZQjniKPuI/IoxhV5bV1uA76RP29UhY6FdZSjZAr1l5i3LzlhgZR0P4QDmqLyO9RLkw==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr8373288wmk.102.1626949020422;
        Thu, 22 Jul 2021 03:17:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z6sm2895600wmp.1.2021.07.22.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:17:00 -0700 (PDT)
Date:   Thu, 22 Jul 2021 10:16:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Sonia Sharma <sosha@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sonia Sharma <Sonia.Sharma@microsoft.com>
Subject: Re: [PATCH] hv: Remove unused inline functions in hyperv.h
Message-ID: <20210722101658.tqimz3jmr7seelqz@liuwe-devbox-debian-v2>
References: <1626903663-23615-1-git-send-email-sosha@linux.microsoft.com>
 <MWHPR21MB1593804BE63C6813D66F6BC5D7E49@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593804BE63C6813D66F6BC5D7E49@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 22, 2021 at 05:35:31AM +0000, Michael Kelley wrote:
> From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Wednesday, July 21, 2021 2:41 PM
> > 
> > There are some unused inline functions in hyperv header file.
> > Remove those unused functions.
> > 
> > Signed-off-by: Sonia Sharma <sonia.sharma@microsoft.com>
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next with minor adjustments to commit message.

Wei.
