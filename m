Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7A304CD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 23:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbhAZW4d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 17:56:33 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54769 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbhAZRMi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 12:12:38 -0500
Received: by mail-wm1-f54.google.com with SMTP id u14so3095602wml.4;
        Tue, 26 Jan 2021 09:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLTk04HLYEc0gHiobpBa2Rf8M0brcNpNc92sIr4mWa4=;
        b=HzFN6h7VgYDJ0GrnNgJi+1OZOJvWq8H9Kfxp9YPDRGfeCSsEtzdczhImKVlpiXFhb7
         gw+Y/TXap4Ysli5lNZTPUn10whpDmUpKkxEKvBbh5k5rv6FYRqFVrCF4T7Si4T8XN5/1
         ZNKOVzrKiiopU3o3h3lylou2s8pl12nk0ScnVNJQUx1s9yGsFZ9O9sXgsW4WO+ChP3hK
         5R+RoWEgz2vJRRnEH6XC6FFgWPmAPAkhjh5A4NC7B80BRNMWuXB6bWOwg2KYyajB/B9D
         K3c91bifbUOqoBNIPCjl58PdNVvDvYlscyKvzMIW4HzGSnFDvsSM/TXNlco3zvbql11A
         R7hg==
X-Gm-Message-State: AOAM5327gUrvF1t1UeH/+4EunTdgig/+E/MFyqm2ZulPbn9ZLVk+Ded2
        hnOUAGMnQ6gRCQUM0gAvDJo=
X-Google-Smtp-Source: ABdhPJzP4kThibk+kuyUve55nZxz6LRnRBwXuMSrFxaQQubIzNi5ZEPZmsIsGMymKQHOtSz5yUZz/w==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr623588wmi.15.1611681083373;
        Tue, 26 Jan 2021 09:11:23 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q7sm29859745wrx.18.2021.01.26.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 09:11:22 -0800 (PST)
Date:   Tue, 26 Jan 2021 17:11:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/Hyper-V: Support for free page reporting
Message-ID: <20210126171121.ujxojhmkjhuilry6@liuwe-devbox-debian-v2>
References: <SN4PR2101MB0880CA1C933184498DF1F595C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB0880CA1C933184498DF1F595C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 06, 2021 at 11:20:33PM +0000, Sunil Muthuswamy wrote:
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Tested-by: Matheus Castello <matheus@castello.eng.br>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
