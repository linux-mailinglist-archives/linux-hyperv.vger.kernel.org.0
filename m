Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFDA40C5
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 01:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfH3XGA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Aug 2019 19:06:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43373 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfH3XF7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Aug 2019 19:05:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so57753pgb.10
        for <linux-hyperv@vger.kernel.org>; Fri, 30 Aug 2019 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vQ0RQyeBGvlKMouk4X7nITJZVdjq0EWkMY4a5NZ/dZQ=;
        b=xQRCv0mi0eqGRYV/ApW2A3oDEZUa1JFHMJTj+zkFkf66OWCAFlrAkvdcmOExCKzJp/
         8d0lJBfUjEAhih8i9BG0EXJVvpJZWbBbaywySUXCV3N9UZcW4SBLFn2cxICiXyjzMdev
         ODyPR1MUXBohpro70eUuwg03iB5iVzUq84iTGwcTK1afHHJ82QZbgGCodDkdVbhMDlz+
         gnxzBHlYewWJrM1rEY7SuBEgSPQjN5ZmeCeXCzSgiErCGZiilfRAiR0MgcSv+b3q+jK9
         DYU+Pbpsxpz05Eqq8GODoDR98sC6ZaTakqg4XmHEfaJaRbYCYLevZFVCS60Yq5GaPWhN
         NQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vQ0RQyeBGvlKMouk4X7nITJZVdjq0EWkMY4a5NZ/dZQ=;
        b=ceRLixWyKhhNQLRbMs7i5CFiE+vaCTmwlddJB8VzPcx+p4nBCAV2stzrP1XcHtwux1
         GNjX1DX97F2JFwi18oi5Aogg6V/+myzP9ZIknWAPHumTRvCfDaxRyEDSZeENAs7ZyOAq
         Zzh4EA43dKk5YIjvIfKWJStUP8GzIP/wv8vRRIc3HUz5edBM7fOG0zI2bgEPtqbPcCyx
         Cwr5bNSkcYpN1WNpgeVznGCBoW9kdV50+AUw+W2sc5mUuoj3e2ZJcwyZ3aLkkVqRXmrr
         nPUm39TQ7ZS7kXtjMMdt9TBLahvOGmi/dmoF9FxvClnGseHBVf98qBHGfYsyMbvMrOLO
         acxw==
X-Gm-Message-State: APjAAAWnJQkAFaSTrUttAcjAPUPoVou0IXw+v516kf/I2CGakzCuurX3
        Cvygt4/UPZqe8g2PQitPxutQ2g==
X-Google-Smtp-Source: APXvYqy4SP+CeDdQB323fXjcyLOvixFSIEIvkWq/VTDq2eiaZ/PI0TTeUDqlL1VjeoU5O8Dnut/1iQ==
X-Received: by 2002:a63:7d05:: with SMTP id y5mr14993115pgc.425.1567206359284;
        Fri, 30 Aug 2019 16:05:59 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 2sm7101550pjh.13.2019.08.30.16.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:05:59 -0700 (PDT)
Date:   Fri, 30 Aug 2019 16:05:36 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next, 1/2] hv_netvsc: Allow scatter-gather feature
 to be tunable
Message-ID: <20190830160536.0da5fdf2@cakuba.netronome.com>
In-Reply-To: <1567136656-49288-2-git-send-email-haiyangz@microsoft.com>
References: <1567136656-49288-1-git-send-email-haiyangz@microsoft.com>
        <1567136656-49288-2-git-send-email-haiyangz@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 30 Aug 2019 03:45:24 +0000, Haiyang Zhang wrote:
> In a previous patch, the NETIF_F_SG was missing after the code changes.
> That caused the SG feature to be "fixed". This patch includes it into
> hw_features, so it is tunable again.
> 
> Fixes: 	23312a3be999 ("netvsc: negotiate checksum and segmentation parameters")
         ^
Looks like a tab sneaked in there.

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
