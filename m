Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A592217086C
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2020 20:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBZTGQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Feb 2020 14:06:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42854 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTGP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Feb 2020 14:06:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id p18so56248wre.9;
        Wed, 26 Feb 2020 11:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O58Y6eMhCTeYYKg0wLMHVfmrO/6IeMX67+E8DJ8At90=;
        b=n0dlQOu/k/fhlPYP4EKnrLcIW5WLLy4f4boAXrnqUHAI87vrglf0rYOGSgyqUju8F/
         hteJ6N6eOohH7yWrOvckMg+pPOAkGcluMOtjTXAkzUCvFfZMfRl6ny64pA6jzum0tpiq
         gjPt+LzRmoTysUfXGI2iwiPBVA4KTq46ZDvKghmFnzqI/kMovO8WeKgLfA+a05mln17s
         5GkztnjSmjkMpcnxlcPx75XTN1hhELl/XoX2tW9Ew5eoI3gR01xfkqnSlmkx3ZXx9myQ
         EvZSa7u8ytzhMH4yWvoHihYCo+4cOyJ9IyJNTK7xnL1o3i1qyVzi1+iLRkLmeV2qrbx5
         CcBA==
X-Gm-Message-State: APjAAAXHOgS3m3Mwbl0P5UUKtVRwjSmqM1kIcEKhvf0/zie2+7YA0XYr
        8JsrPaPAapU/5YCCNo3xiNs=
X-Google-Smtp-Source: APXvYqyiEsA3W3DtRh+2yfgthnx0t8CkECLK98sS2uCO2vCXzkZ/HER8MMOOFsVcmhJR7+kFUAzpFA==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr90373wrq.43.1582743973445;
        Wed, 26 Feb 2020 11:06:13 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id j16sm4492866wru.68.2020.02.26.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 11:06:12 -0800 (PST)
Date:   Wed, 26 Feb 2020 19:06:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Hyper-V: add myself as a maintainer
Message-ID: <20200226190611.ef6p4mt2m4ltzqec@debian>
References: <20200226180102.16976-1-wei.liu@kernel.org>
 <MN2PR21MB1437C4BAAA6E38200C92F5DDCAEA0@MN2PR21MB1437.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR21MB1437C4BAAA6E38200C92F5DDCAEA0@MN2PR21MB1437.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 26, 2020 at 06:57:24PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Wei Liu <wei.liu@kernel.org>
> > Sent: Wednesday, February 26, 2020 1:01 PM
> > To: linux-hyperv@vger.kernel.org
> > Cc: Wei Liu <wei.liu@kernel.org>; linux-kernel@vger.kernel.org; KY Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; Michael Kelley
> > <mikelley@microsoft.com>
> > Subject: [PATCH] Hyper-V: add myself as a maintainer
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > Cc: linux-kernel@vger.kernel.org
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: Michael Kelley <mikelley@microsoft.com>
> > 
> > Sasha's entry hasn't been dropped from the Hyper-V tree yet, but that's easy to
> > resolve.
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8f27f40d22bb..ed943f205215 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7739,6 +7739,7 @@ M:	"K. Y. Srinivasan" <kys@microsoft.com>
> >  M:	Haiyang Zhang <haiyangz@microsoft.com>
> >  M:	Stephen Hemminger <sthemmin@microsoft.com>
> >  M:	Sasha Levin <sashal@kernel.org>
> > +M:	Wei Liu <wei.liu@kernel.org>
> 
> Thanks for being a new maintainer for Hyper-V!
> Sasha submitted a patch (attached) on 2/05 to remove himself from the 
> Hyper-V maintainer list. But his patch wasn't applied yet.

Yes I'm aware of his patch.

> 
> You may either re-submit his patch together with yours. Or just replace 
> his name / email with yours in one patch.

My plan is to apply his patch first and then apply this one once I get access
to hyperv tree. It is rather easy to resolve.

Wei.
