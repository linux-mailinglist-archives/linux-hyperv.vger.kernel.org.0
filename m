Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0543323222D
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jul 2020 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2QK2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jul 2020 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2QK2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jul 2020 12:10:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A0C061794;
        Wed, 29 Jul 2020 09:10:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so14494190pgq.1;
        Wed, 29 Jul 2020 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KszJd66+FR9j6KwsFqF55Ai/n2YjvAK1QdFNRfzzsA=;
        b=slW7M1Gb00VsPVVBQAXgmEOHzjruf7qnHOBgBbHPltSz19hyM7YxDO+dZBz0jAjDny
         PhFchOZBPjFVNqrntXDMshOadjo8arB9xFkXbx+IB+4exq8p/QG5XjZnnPt5/2IRKh34
         Hhe4gKskNtSlICOYctBYdHqH2SuCLtYy1tsPbcyqa2h4Zj4UKRApvrtD7LRkWfLePGgE
         IGSs/3DJzMv6QzqohzZiZur6HmFMCunuICFTjwTcultYjwtGBD6mTFiQ/5QRgYL2OxAP
         WtE8YejzUx0vEInoKNa2SpV+R2HC4ABPK/+SRmNvoWGiqibCgdOdSvQnLbSuqvmNcC10
         GCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KszJd66+FR9j6KwsFqF55Ai/n2YjvAK1QdFNRfzzsA=;
        b=S3mlG2163DEgUOs1dixjz2KxUV4JdJoBXmc5VfS4s8elEn+K4fC10OiitXCLyN6SaR
         6kn5l9Sb4fxSjYhrzexHvBUs4BiL9w9009x4dWRdvj+HGDnBVa5SO9GywtFesgOxMBT5
         UxsZkSOW2HS7kdCAhPuWyUjY71/UHPyHrqXltwf3khIbe41x3Hdf/SuEQrXXyK4gszBp
         OEHNDVtDflKULt949d7EirlDNV0gjm3B0Fwj86GryG0VOJoyI/cc0cHRqL5i+HysimXY
         E3vpg8dCXVrSLtxAez6I67373wEhq3RMVS9ggvnxDtlpCtkOh58pPN1wuag1+ei2EfL9
         RPuQ==
X-Gm-Message-State: AOAM531owTT2NS8qWubxaGkRsWaRcbub3G9n06nMxGNFS7pxm3Wqyi+n
        D7V1ReYpBseGqhCw5VXNEq71ReF1qkFMnqN6x1U=
X-Google-Smtp-Source: ABdhPJxk4Ccq49N7j3ka7r2c7b2liLe9RQp6QwM+jJpcIj4duAtmnA3Vabbse/9sQCu8c3oSvMd5A4YSIn+dfmrIxCg=
X-Received: by 2002:a63:711e:: with SMTP id m30mr8171759pgc.40.1596039027236;
 Wed, 29 Jul 2020 09:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200728204417.23912-1-lkmlabelt@gmail.com> <BN6PR21MB08361CE726C8D3541E657054CC730@BN6PR21MB0836.namprd21.prod.outlook.com>
In-Reply-To: <BN6PR21MB08361CE726C8D3541E657054CC730@BN6PR21MB0836.namprd21.prod.outlook.com>
From:   Andres Beltran <lkmlabelt@gmail.com>
Date:   Wed, 29 Jul 2020 12:10:17 -0400
Message-ID: <CAGpZZ6un6VT2ZVje0tVXbZkvH_HH+pn2Du6WPa5qeJDOz7rUmg@mail.gmail.com>
Subject: Re: [PATCH] hv_utils: Add validation for untrusted Hyper-V values
To:     Stephen Hemminger <sthemmin@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 28, 2020 at 5:04 PM Stephen Hemminger
<sthemmin@microsoft.com> wrote:
>
> You may want to use one of the macros that prints this once only.
> This is a "should never happen" type error, so if something goes wrong it might happens so much that journal/syslog would get overloaded.

Certainly, printing error messages once would be ideal if we were only
dealing with Linux kernel bugs. But under the assumption that Hyper-V
can send bogus values at any time, I think it would be better to print
error messages every time so that we are aware of malicious/erroneous
data sent by the host.
