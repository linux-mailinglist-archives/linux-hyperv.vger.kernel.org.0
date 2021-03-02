Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8A32B763
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Mar 2021 12:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbhCCLCS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 06:02:18 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:54529 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835431AbhCBTG6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 14:06:58 -0500
Received: by mail-wm1-f48.google.com with SMTP id u187so3130200wmg.4;
        Tue, 02 Mar 2021 11:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CXSbakREkjEKIUt0gXCzvVRz5Oo5BC6nh69U+dOoN8=;
        b=GpLj1EfnygJX+QOBbXvhgvYbdXpWvlIhRyvgbU446pHHKsDXxo82EXhxJtxlAw7uJd
         q2V8+e2ElwvFLJq3ob5F9KybUL63zI/rU3r4N+P3AGJSyU8ByfT2dwyq1+hC0w981Djx
         bNg1RN5Pa8S53PESpVu4P8zse8288dd4Y+WWWnUS2hj3XjoGGiv7rRvxhhM8/Ij2KlS2
         5cw6F6HFlKSZh42kGxeQA0N0ycV0VrGoPhtvtYtovDN30Ab7ZWzfjKhiInBaovo1KuhI
         bQk9kAROTs2RgnQdTFmxIJz4M3lWrW9nQTKBDENTpCTQpA8JN8EdKx+sgNBZUPs5MALf
         jd8g==
X-Gm-Message-State: AOAM530+FaMUWzxrNuBRALzrPjrEYvoB+wJBpUF2v1RFrcMoafe5XZfA
        c+y1txrRb6wAUmyJY+WGFM0=
X-Google-Smtp-Source: ABdhPJylwkHAiSD7eMwwkNbrFndVemsfu+NRZ2Hvsaz3+sPetMMNpz6rhXOn+Bqtl3RfytZb4AtlYQ==
X-Received: by 2002:a1c:1dd5:: with SMTP id d204mr5313354wmd.127.1614711976034;
        Tue, 02 Mar 2021 11:06:16 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i1sm3138283wmq.12.2021.03.02.11.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 11:06:15 -0800 (PST)
Date:   Tue, 2 Mar 2021 19:06:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Vasanth <vasanth3g@gmail.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drivers: hv: Fix whitespace errors
Message-ID: <20210302190614.bzcic6czaiutzwvv@liuwe-devbox-debian-v2>
References: <20210219171311.421961-1-vasanth3g@gmail.com>
 <MWHPR21MB1593D140BF3619028762324AD7849@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593D140BF3619028762324AD7849@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 19, 2021 at 05:30:36PM +0000, Michael Kelley wrote:
> From: Vasanth <vasanth3g@gmail.com> Sent: Friday, February 19, 2021 9:13 AM
> > To: KY Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> > <sthemmin@microsoft.com>; wei.liu@kernel.org; linux-hyperv@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Vasanth <vasanth3g@gmail.com>
> > Subject: [PATCH v3] drivers: hv: Fix whitespace errors
> > 
> > Fixed checkpatch warning and errors on hv driver.
> > 
> > Signed-off-by: Vasanth <vasanth3g@gmail.com>

Vasanth, normally people put their full name in the SoB. Do you want to
do that too?

There is no need to resend. Just let me know what you think.


> > ---
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks Michael.

I will pick up this patch within this week.

Wei.
