Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3A343ECF
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 12:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCVLFA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 07:05:00 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40623 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCVLEk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 07:04:40 -0400
Received: by mail-wr1-f41.google.com with SMTP id v11so16180455wro.7;
        Mon, 22 Mar 2021 04:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PWWnDHWb0f6VWpKB3JAHyffSxPdrHA0WVJJCPyw/usc=;
        b=QS2i0VBc4msizGZn7kO+qmqW9uznZiSbxTvFXR+hQgYUksI7r8WIOqOXsthwm0mx4m
         qWEsTdOZWsliU28pBheKpSr5bVyCcWhmWOIcyeel+ac+2LXeyQuaBLFVm1f7Ku1/5VNx
         fQQZJ09n8pC/D2J1PKgEdtO2R8U1h3GULwa7OWM/S/JIuJ/YhMQguyoU9CDnzCZODW9M
         pbRkqkIvsmXIDpaI+JkrJ6MjwzOe9xSrZRyWuyP8VKm6gLp4zRIeLG3wlyR+lTCHmN7Z
         D+YIjRhN8Zg6uMowv9s2Vd4FRt8Q5K631ITelNrf6U8DxUVaWuHMHWOitic0fftuP7tp
         r7Yg==
X-Gm-Message-State: AOAM533CO2nDLsleGyalQOzaRuepH/DI56bd1bRROA+16DZvD7G/d1pW
        KmLlL9WG8vr/U/Heeo86zp0=
X-Google-Smtp-Source: ABdhPJzKfjNAAKkmny4+JhoyXbchQN4iBJ4d38/Ts+iZPYS2nOZ6TZ1yCyjmRv54v+IbOzZa76na4Q==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr17733482wru.214.1616411078811;
        Mon, 22 Mar 2021 04:04:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s83sm16562582wms.16.2021.03.22.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:04:38 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:04:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com, heying24@huawei.com,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Message-ID: <20210322110437.ei3vfove4xqky3h5@liuwe-devbox-debian-v2>
References: <20210322031713.23853-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322031713.23853-1-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 22, 2021 at 11:17:13AM +0800, Xu Yihang wrote:
> Fixes the following W=1 kernel build warning(s):
> arch/x86/hyperv/hv_spinlock.c:28:16: warning: variable ‘msr_val’ set but not used [-Wunused-but-set-variable]
>   unsigned long msr_val;
> 
> As Hypervisor Top-Level Functional Specification states in chapter 7.5 Virtual Processor Idle Sleep State, "A partition which possesses the AccessGuestIdleMsr privilege (refer to section 4.2.2) may trigger entry into the virtual processor idle sleep state through a read to the hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE". That means only a read is necessary, msr_val is not uesed, so __maybe_unused should be added.
> 
> Reference:
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>

I modified the commit message a bit and queued this up for hyperv-next.
Thanks.

Wei.
