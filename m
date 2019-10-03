Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6260CAD3C
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 19:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbfJCRhU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 13:37:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfJCQDf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 12:03:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id q9so3354385wrm.8;
        Thu, 03 Oct 2019 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=td4245u+5WMfMu8EFRyzo+huDJgbvQAU/NaQvzgX56E=;
        b=WxTR1lavzcTXkB3F0JCQGlSMx9R7RG8Mo5tOrXKixIEnLLJPwyCdLtdpu4i9VUYir1
         jDutWwSI3RsBgERF1i2kAliFxxZdTUDb8kG0y5RdNUzILH1807zN+iRmEvu2aTZ88E98
         YleB3ZcC2OzmDsc7M9KrtgFSsIVvZLdPMJxpwh4Lrrlh4rYa7AikgH6sgmgjvynEa/xy
         UrCB7vpuegDNRMVKAlJ/Ug9h97eAFfb/GhVeBlyHCUXoV/a07Vf9qi1EXhxHzZQa1UgA
         +253fQBAqNM4LSXDYHo4Agd4EspVIO4EB1rBauvMFTkG6+WDj1M+t664j5qg8Wey6hHx
         GLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=td4245u+5WMfMu8EFRyzo+huDJgbvQAU/NaQvzgX56E=;
        b=OQIxiUDSQqJZ7Z9ExLMOUdFyTbOVcsRmWaTscjw9Vp0vlUaLhf23GnL3l0hA73+hfQ
         SQf2xGLsCc39fpSTNNogxUvEEDVRfG5GqdQoGOsSihg+SQUST/73mclX6LJW9UhosCVR
         sPvU7n0vqJErID1jPkvFqqoMGSsg6sA98taWwCXA2z31xnS9zJVJrzOQ1wmLoN+9sfKA
         a7pE4w4wqK1qNdLidQHpoJ7ZNsQjIr97PmE0g2Q4hdSGGqqGWnEM+zyBhYob3jpNlarQ
         5511PGtIeVt/UQYG6EH2NuI/uJqpKLyvuDVQKZgdu8utjvdYz3Axrcq86XHyCHMl+dxd
         eNSg==
X-Gm-Message-State: APjAAAWr/qqrqBfBBBKlkdtkdda0Bsy4hLysm2XRyizH3q+VCAdfKtdo
        pubHfkIurihsXiAvCj6Ad+l9EB7zGtUNytMA
X-Google-Smtp-Source: APXvYqxdGdyWERq67KP37ldw2C5SCEmftU5/nMj5EKEH3J3jjKK221iaaCdmU5w8/PTUv0fIvewEZA==
X-Received: by 2002:adf:db0f:: with SMTP id s15mr7869305wri.120.1570118612657;
        Thu, 03 Oct 2019 09:03:32 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1010:414b:bdc7:a2f9:15b6])
        by smtp.gmail.com with ESMTPSA id s12sm4990484wra.82.2019.10.03.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:03:32 -0700 (PDT)
Date:   Thu, 3 Oct 2019 18:03:26 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
Message-ID: <20191003160326.GA22098@andrea.guest.corp.microsoft.com>
References: <20191003155200.22022-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003155200.22022-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Thu, Oct 03, 2019 at 05:52:00PM +0200, Andrea Parri wrote:
> If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
> HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
> configuration version.  Bit 15 corresponds to the
> AccessTscInvariantControls privilege.  If this privilege bit is set,
> guests can access the HvSyntheticInvariantTscControl MSR: guests can
> set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
> After setting the synthetic MSR, CPUID will enumerate support for
> InvariantTSC.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Subject should have been "[PATCH] ...", i.e., there is no 2/2 planned
(not for this patchset at least).  Please let me know if I should re-
submit with the subject fixed.

Thanks,
  Andrea
