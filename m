Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5268181668
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 12:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgCKLAb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 07:00:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34200 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgCKLAb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 07:00:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so2029360wrl.1;
        Wed, 11 Mar 2020 04:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b25sp8qI66/j49iyqNBdtNtMfSxMP1oLNv9A/qaCM54=;
        b=disRR8YWcUkAL22/v3IPpnne5qf+vopN6WJn5QPn9LcqNKLiCTnNimqLAxrafFhSyc
         yCofedNu9NI3oPMZ2GyZmSOovKmj2SQJvalIGl/FAFsNckHsXLN3gxQQBlffbR85Z08M
         IvVfqHPw3G22q3rbxa89FtEmJkUwZurh4UiGXmKsea7czs5HpmE/AoOoVd9FDIZyAMNy
         6GPUP8OYe7q21aMOE22nPlz2WSekOfgCKn3WoeBuNETDgWeW2LGbC3PibvYXfXomcBoo
         hz4rLq+cIE+8/tOAGU3/s6n3zRN3DV3g4be9+5bnVETBtz+u47I2IJB7X30oPRqBdrJR
         c2Yw==
X-Gm-Message-State: ANhLgQ3J2uCNBoeCtIeFf4yo6xGiYEyTFudZeUFNKYyELCvoRTwypOF7
        GfF17rkDJjNkBGhkXdhXdWM=
X-Google-Smtp-Source: ADFU+vvNZicSP57FUXBCc+PbAP0dQa6QnWWOb5Ff7mqH6aO33TLcIKh9t9fDtFxYFTEo8QnHyZAzlw==
X-Received: by 2002:adf:e485:: with SMTP id i5mr4104528wrm.81.1583924428712;
        Wed, 11 Mar 2020 04:00:28 -0700 (PDT)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id z19sm8187551wma.41.2020.03.11.04.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:00:27 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:00:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH -next 019/491] Hyper-V CORE AND DRIVERS: Use fallthrough;
Message-ID: <20200311110025.lycn35o7zvvmohvu@debian>
References: <cover.1583896344.git.joe@perches.com>
 <84677022b8ec4ad14bddab57d871dcbfc0b4a1bf.1583896348.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84677022b8ec4ad14bddab57d871dcbfc0b4a1bf.1583896348.git.joe@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 10, 2020 at 09:51:33PM -0700, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
