Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFBF2D7756
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Dec 2020 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405826AbgLKOCt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Dec 2020 09:02:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41852 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395045AbgLKOCW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Dec 2020 09:02:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id a12so9135176wrv.8;
        Fri, 11 Dec 2020 06:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hvkBnuTRFKVp4hIMELee8T2SRcywd+sthSvyux1z8M=;
        b=hu263V2i2DT2JybAT5Mo8HH01HKuoiJvqQknviwfKGaj7V9drXbrzsL5sWCyzrO0M3
         nxLIwh7IgnsXY9Rh3PL3nK7sbG6cHYAWDJqRy5wELqglUauDbZgj1qAk4x7GI/Y3PjyN
         fXByk/yna+myR1U/wsdePUzG5wlpo/g774OpAtASBKL3eNjpdHDd0T8cTX0qiARUJ/+x
         cXbq7zO7oXXAypcKV2O7HAWmSp0C1QmcC1BU5vSZr8BCyWgAVI3Iysul32+5zGqdhDna
         95z1KwUJhOIgmlT5dm1mLGdk+wZ3LU/nNqLRprJ0xn/FA11Y3gPRflflPZKJkFEO7PKx
         EcIQ==
X-Gm-Message-State: AOAM531u6sSzRsABMknKS8AaiPldI4G1ozgpB5ImXWAuTAN5t8eNc2hM
        gAJd6JX12gB7M7vtWUg+QsaAq9bYLZY=
X-Google-Smtp-Source: ABdhPJy3O58hzjGzqK1POhoqM66qCWhxyO+Cg67sIdwBnZyQQiuOXv0wfTtuDF0ze3XcmxPKs1PIDw==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr6360906wra.138.1607695300661;
        Fri, 11 Dec 2020 06:01:40 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c129sm14736891wma.31.2020.12.11.06.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 06:01:39 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:01:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Revert "scsi: storvsc: Validate length of incoming
 packet in storvsc_on_channel_callback()"
Message-ID: <20201211140137.taqjndaqjjo25srj@liuwe-devbox-debian-v2>
References: <20201211131404.21359-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211131404.21359-1-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Dec 11, 2020 at 02:14:04PM +0100, Andrea Parri (Microsoft) wrote:
> This reverts commit 3b8c72d076c42bf27284cda7b2b2b522810686f8.
> 
> Dexuan reported a regression where StorVSC fails to probe a device (and
> where, consequently, the VM may fail to boot).  The root-cause analysis
> led to a long-standing race condition that is exposed by the validation
> /commit in question.  Let's put the new validation aside until a proper
> solution for that race condition is in place.
> 
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org

Hi Martin

Sorry for the last minute patch. We would very like this goes into 5.10
if possible; otherwise Linux 5.10 is going to be broken on Hyper-V.  :-(

Wei.
