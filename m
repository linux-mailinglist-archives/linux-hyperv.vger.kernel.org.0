Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B713C296F
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 21:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGITQy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 15:16:54 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43596 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITQx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 15:16:53 -0400
Received: by mail-wr1-f43.google.com with SMTP id a13so13489645wrf.10;
        Fri, 09 Jul 2021 12:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AryLrQENhEruDywcdJFivq5FRvQAdMiZyTqcDdhNHlg=;
        b=q/GV2WW3vm2PhCLuDDcHJIPirqTuLSMAxb+8A2RsTyr04zDmPENwheeNYMcoQK6JM1
         wpZAFNCwMO1CBMtTtK/9a97FOQ511DUxMYKNkeuj6XODhawjvHxy9h89Kmd2eoS9OPLy
         63mg/E2+UDdy/Hi1gEytye7C2ruQIzO9e4DJZwz9Npl3fJdvLFohEo91oC/ZFdH5a0S8
         PucW7EhgxvZtnc39hGfy9h1VZgApqtRU6D+yd6RSyZB12VWA/uNx9ysj+mfRnx762XI2
         LyItnooMiUASbxgV4/PDmp2B6dHs8s8aW0v6q2UeA9kstwDFOgtvKjvTIPsaDj+V7OcK
         2UUg==
X-Gm-Message-State: AOAM530Fk8fozkBiNHXl6Uh2SmrcMmZvTbjUm0VsEeNg8+1RctGqeTZ3
        q1S1Rk8F8yGSnult243yFTo=
X-Google-Smtp-Source: ABdhPJyD+qZgolGbJE2UPX+2Q775g7Yji/rVkVwgVdNIbOt0rCy+hmupvzpwXxSVh7G+FnH5AzYjAA==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr12981882wrp.353.1625858047801;
        Fri, 09 Jul 2021 12:14:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l20sm5664949wmq.3.2021.07.09.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 12:14:07 -0700 (PDT)
Date:   Fri, 9 Jul 2021 19:14:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        Muminul Islam <muislam@microsoft.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
Message-ID: <20210709191405.t3vno3zw7kdlo4ps@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
 <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
 <YOhsIDccgbUCzwqt@casper.infradead.org>
 <20210709162732.hnyzpf3uofzc7xqs@liuwe-devbox-debian-v2>
 <YOh7gO3MIDv5Eo8q@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOh7gO3MIDv5Eo8q@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

specifically On Fri, Jul 09, 2021 at 05:38:24PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 09, 2021 at 04:27:32PM +0000, Wei Liu wrote:
> > > Then don't define your own structure.  Use theirs.
> > 
> > I specifically mentioned in the cover letter I didn't do it because I
> > was not sure if that would be acceptable. I guess I will find out.
> 
> I only got patch 7/8.  You can't blame me for not reading 0/8 if you
> didn't send me 0/8.

To be clear I did not blame you.

You were not CC'ed on this patch, so presumably you got it via one of
the mailing lists. I'm not sure why you only got this one patch. Perhaps
if you wait a bit you will get the rest.

But it is all good. I appreciate the fact that you took the time to go
over this patch and voiced your opinion.

Wei.
