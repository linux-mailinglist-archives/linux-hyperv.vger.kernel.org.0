Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B51E1ECB
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2020 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbgEZJiy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 May 2020 05:38:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38137 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388460AbgEZJiy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 May 2020 05:38:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1so19724897wrt.5;
        Tue, 26 May 2020 02:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ok53FF3ob85NQ3kaOmkDOVfvfrQyMjF4yDCUjHtVYOU=;
        b=MVqw4cpdBpWPt3uLAFe87iH4rvDwliMVgA9OKx1x3+ZIuOWXY5rK3X99Mv5Mz/xfBG
         mC9Sk2axRxKKQb1O85Voc2bT5wZhaSLE0GdXdAlOe+BGgvoPjMlC9H6TWUjy2ZQbgu18
         9cmEMHc+DxyVcwHjfbOx4ANhanT3AxspWAej9jikvP2tw1QZW0j4yhqnXLX4DIlvZQf2
         1uvnUyQJnSW6z6YHhdZpQQOm4dpWN6t8ged0/W/yGJUwvXCZL7HiDq6B11AvRiowLYdi
         1+Im300UugfQn1tjU254KEnT9HnLxiK0noVYDaum589hOKKGIvzNxBoiy2FWXl7pWRGI
         uTeg==
X-Gm-Message-State: AOAM530HXBN+o/klPkoqZ0xwDzMytwX4cuyPPJQH9Fmys5Frn9EpexQU
        ER8PLuAe/EUa9M6+35N2QAjAqqEg
X-Google-Smtp-Source: ABdhPJyx1bwlQiUXpBhsXKw9pC/WSAdrM9iOef2uVPf7AY+mlydpS0OKd3PhkTqLeC/FiDOn0YvykA==
X-Received: by 2002:adf:a396:: with SMTP id l22mr18769444wrb.76.1590485932051;
        Tue, 26 May 2020 02:38:52 -0700 (PDT)
Received: from debian (82.149.115.87.dyn.plus.net. [87.115.149.82])
        by smtp.gmail.com with ESMTPSA id w15sm142131wmk.30.2020.05.26.02.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:38:51 -0700 (PDT)
Date:   Tue, 26 May 2020 10:38:49 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PCI: hv: Use struct_size() helper
Message-ID: <20200526093849.keva4hp775m4dzuo@debian>
References: <20200525164319.GA13596@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525164319.GA13596@embeddedor>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 25, 2020 at 11:43:19AM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct hv_dr_state {
> 	...
>         struct hv_pcidev_description func[];
> };
> 
> struct pci_bus_relations {
> 	...
>         struct pci_function_description func[];
> } __packed;
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following forms:
> 
> offsetof(struct hv_dr_state, func) +
> 	(sizeof(struct hv_pcidev_description) *
> 	(relations->device_count))
> 
> offsetof(struct pci_bus_relations, func) +
> 	(sizeof(struct pci_function_description) *
> 	(bus_rel->device_count))
> 
> with:
> 
> struct_size(dr, func, relations->device_count)
> 
> and
> 
> struct_size(bus_rel, func, bus_rel->device_count)
> 
> respectively.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

FAOD I expect this patch to go through pci tree.
