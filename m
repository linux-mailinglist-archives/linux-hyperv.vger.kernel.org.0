Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC43D4241EC
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 17:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhJFP5z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 11:57:55 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38567 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbhJFP5x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 11:57:53 -0400
Received: by mail-wr1-f49.google.com with SMTP id u18so10307449wrg.5;
        Wed, 06 Oct 2021 08:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bpt8m9y+pHZcIYeK8rGYZ0fR9mcjj/LQBVzey4UcZjw=;
        b=dwdlbfOTkzfnVGLxBtgQQ+kc3sfiT51/4FMwgeP1Ad3+p0lXIr9/eLsxxd9XZkkLaA
         0JCBM5W7r6s0WB2Mp51My05kIWEkVDcn+pICjinTdPgPxBlFj7Dg9wty/XbNanCtufQI
         rV3pSaFe9azwCFove4zC9KFkpntVrB4Rxv3+2AtBp4gGn/e7OSDHjPE30uj8tryjMbmE
         cpT+F93jKo17H0qYjZVlMfjW9381q1Vs5P/nbFNV4EiPfxiCDnMF1qnh4njSTn8cXQck
         PYBH/UqDtiOXokpyqfqLKeYtdBvz/rn610CsWco/baEz9ghJmuSznWHT2UUDxb4sVL2O
         BQGw==
X-Gm-Message-State: AOAM533RnzF59SpU6lhjJh37Ah1HBrRD6Nwt93HnoPifaGdr5bakcv8f
        Eu7wPwH1nQ6hhxd9gX+MN/I=
X-Google-Smtp-Source: ABdhPJxp8chtBaw8vO0GDD9hXcBlZ/77IqOcnluineWrUtD//uQr4xlyuhPfL5rCYIZXy8XjE1POig==
X-Received: by 2002:a05:6000:168d:: with SMTP id y13mr29229149wrd.45.1633535760713;
        Wed, 06 Oct 2021 08:56:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z79sm5801028wmc.17.2021.10.06.08.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:56:00 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:55:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: Avoid erroneously sending IPI to 'self'
Message-ID: <20211006155558.e4zie7kp3blcnpzh@liuwe-devbox-debian-v2>
References: <20211006125016.941616-1-vkuznets@redhat.com>
 <MWHPR21MB1593E25D205903BC583C395AD7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593E25D205903BC583C395AD7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 06, 2021 at 03:15:22PM +0000, Michael Kelley wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, October 6, 2021 5:50 AM
[...]
> > --
> > 2.31.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

LGTM.

Applied to hyperv-fixes. Thanks.

Wei.

> 
