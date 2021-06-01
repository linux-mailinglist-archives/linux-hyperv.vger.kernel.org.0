Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265B7397CEA
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhFAXPb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Jun 2021 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhFAXPb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Jun 2021 19:15:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD60C061574;
        Tue,  1 Jun 2021 16:13:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l1so939676ejb.6;
        Tue, 01 Jun 2021 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zh1+/6WfqdVuCg7ID+TQV9ppVnJ4x/cqO6OMVZxi09Q=;
        b=ovTam58e4mYWAmOtX8O9o9KMOV3qEYdvXzOTKSuqXqvtnbYh63J5II9hnT/u/13ODS
         SRX9mMyD7BdpIGRRxgZz6jdZFfv47vOM42jTscBuBlGkr9G+4kJWMSb0+AGDchOxQRYr
         8WDaYTIaofSKBBgNNRRQScDTtWwllbH4DTcC/5+KYQ5Cie47fSA0nnp99dhYCpTVWD78
         BQpKD5Xv6pBVHhCfmRkhr8Jt4yEGlD8VItQChC6WfLn+tF6SaRo25RWGcACAGN8CaJ9z
         MZ3JT1rdZsMt28zGCaiYte/8w/BO/mYd3TXh/E44OqtWP+ROcqu/rb9kd9uEFVazsjAv
         1A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zh1+/6WfqdVuCg7ID+TQV9ppVnJ4x/cqO6OMVZxi09Q=;
        b=H1XKGjRMvk3G/+ySrvX6u0KGiwnN6HYY84AIsdF//27sqT7/Df69vPy626eGsvNp3G
         As3wywuwYb0pucpv4DFjkoLjQW164ulCbeIEHbPTI4SDjHA8TeUJvvOhN08WuSGFLXNX
         WMrHBmsBwsi+3S/DNOc5Al+DZ8bLPRPqeEj5L5og/ezDASvAmZTAGPJStuzlai/B2D8v
         npscZxsil4S9GAxl3NgC9gigK2wzYjt4QTFI235Jmilwt7G+d7GT1lH5lTKd1vaGXHP9
         qnBjLxR04PX4OuKbu+OA+Kwi0TxbFn4er4GSGGKUDqnk9IFqiY0mQOWoAS20AubUceQs
         7Fbw==
X-Gm-Message-State: AOAM533EuWPwjyQbg1r116he+vgtisOmYFZm25YixYSc3W8yc14wL/+9
        4qis4uKXdHVQeOgASqEaeRI=
X-Google-Smtp-Source: ABdhPJyJZZiHu8zdJIZVwUwAJhA75O5Pcldzt4kz1cEG7CswolwKOoxougSP2vOlPjwCEKx5+Qk10w==
X-Received: by 2002:a17:906:2ec6:: with SMTP id s6mr30948371eji.65.1622589226849;
        Tue, 01 Jun 2021 16:13:46 -0700 (PDT)
Received: from anparri (host-95-246-186-31.retail.telecomitalia.it. [95.246.186.31])
        by smtp.gmail.com with ESMTPSA id m16sm236824edq.56.2021.06.01.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:13:46 -0700 (PDT)
Date:   Wed, 2 Jun 2021 01:13:39 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Long Li <longli@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Parri <Andrea.Parri@microsoft.com>
Subject: Re: [PATCH] PCI: hv: Move completion variable from stack to heap in
 hv_compose_msi_msg()
Message-ID: <20210601231339.GA1391@anparri>
References: <1620806824-31151-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15931F1698FD128C76219F7DD7249@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB150673A34B431F9311E6FDC5CE3E9@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB150673A34B431F9311E6FDC5CE3E9@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> I agree if the intent is to deal with a untrusted host, I can follow the same principle to add this support to all requests to VSP. But this is a different problem to what this patch intends to address. I can see they may share the same design principle and common code. My question on a untrusted host is: If a host is untrusted and is misbehaving on purpose, what's the point of keep the VM running and not crashing the PCI driver?

I think the principle can be summarized with "keep the VM _running, if you can
handle the misbehaviour (possibly, warning on "something wrong/unexpected just
happened"); crash, otherwise".

Of course, this is just a principle: the exact meaning of that 'handle' should
be leverage case by case (which I admittedly haven't here); I'm thinking, e.g.,
at corresponding complexity/performance impacts and risks of 'mis-assessments'.

Thanks,
  Andrea
