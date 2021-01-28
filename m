Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D630307773
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Jan 2021 14:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhA1Nvy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jan 2021 08:51:54 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37936 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhA1Nvy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jan 2021 08:51:54 -0500
Received: by mail-wr1-f44.google.com with SMTP id s7so2480788wru.5;
        Thu, 28 Jan 2021 05:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4iEdjsINNCN9xHQ/bPSSlSE4qPnRqOgYhiFEfNZAgT8=;
        b=qbcbswTm6BzZwotO7NDQs6usNXG1po4TxC6ZPScESWJfIeq+8LfRtd3phn1EXF3mLv
         rPsVcBu2HKtXS1qS3WvmfWuD1H+DVdzGui/hGN7iSfDVpuXRxeIIkJoeqK4VtXdRGWon
         2ME7NQVP4fyFhtF5547MEP08sjJ66IPQxczjb3h6JMUJi6yLzyREHK+kFWsrMLRmKdzE
         tYR0vQAgpiPPYSLmv7fnHdh7Uu2nrLDJldKGGQAoTmVWGd1xyMEIEnFfCNcSEJCeAhMA
         isnQw0dVigWoaZSVL2ahutIjO/InFg0RVefJuXSCESKI/0bMYaIcJPjhFXK6loy80U/+
         afNQ==
X-Gm-Message-State: AOAM532F+C9rLsuj+lXMQEaDA0jQHOu3ZVDMSDrPrBlFKgRpSeIT3Bsy
        pzp0lKrnt67kzBAloYql12Q=
X-Google-Smtp-Source: ABdhPJwdzM9UQYwe3e17Mcko1vj1A7/Gtb6ol8sF+TJwt/HaeF4adnESAzsCB5yrTISTZfuxnA+1/w==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr16677435wrn.345.1611841872546;
        Thu, 28 Jan 2021 05:51:12 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v126sm6269778wma.22.2021.01.28.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 05:51:11 -0800 (PST)
Date:   Thu, 28 Jan 2021 13:51:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hv_utils: Fix spelling mistake "Hearbeat" ->
 "Heartbeat"
Message-ID: <20210128135110.h74cq7j2iavmz2pt@liuwe-devbox-debian-v2>
References: <20210127233136.623465-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127233136.623465-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 27, 2021 at 11:31:36PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to hyperv-next. Thanks.

Wei.
