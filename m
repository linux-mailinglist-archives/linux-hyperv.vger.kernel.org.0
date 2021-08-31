Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3C3FC7FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Aug 2021 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhHaNRG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Aug 2021 09:17:06 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40564 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhHaNRF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Aug 2021 09:17:05 -0400
Received: by mail-wm1-f42.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso2061819wmc.5;
        Tue, 31 Aug 2021 06:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O04+J9gSxbpkBztP2ggNCNH2CejHjsWY1TH+VQQ2tR4=;
        b=Z1QpaNb6lwYgwghFPERz6ASgsUyRcU5/9NACCK5mmoSJoqgBeMtg1h8SnlnNoLQZv4
         RepI5FBDTKXeMnvf7CDxLls3bIfF3ZN0VmBEtfiOWAGxlBtlEyN8Rb8af74Mp1YahZsM
         wdnIKVUBz5XiPi5hLwv5b3kXu+urf814NVXzrr6FQ7HLlFKp5936abvsKBvGPfJUj2bo
         mmyKC1V7hJ9+ByBOzHRDLwzCfPMWHs54xLEYhRwTHLJE/HPGE0r/vhtU24GLP0BRsOBw
         kUcPUrXm3oMSIavHEmJHxX+NYqjwNTVpnxrta6ho4k3wBVVOJXY0OiDYEfSIAsugJYvk
         sCxw==
X-Gm-Message-State: AOAM533ZYDFcYrm2qAg02aD2BiWYLrvGYvYUTotHwaUcgNi6kuY/DLY6
        QDgnz7pp/uVLcT7awX/psMA=
X-Google-Smtp-Source: ABdhPJwpoDBQpL9HH7X3Hred4ImIlOsoaD0JdkXw1ZnRsGtGL4rbmQERxwBqSVjC+kmODA3gr95k3Q==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr4161917wmh.99.1630415769653;
        Tue, 31 Aug 2021 06:16:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c15sm2442150wmr.8.2021.08.31.06.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:16:09 -0700 (PDT)
Date:   Tue, 31 Aug 2021 13:16:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [Patch v2] PCI: hv: Fix sleep while in non-sleep context when
 removing child devices from the bus
Message-ID: <20210831131607.vsjvmr43eei4dsie@liuwe-devbox-debian-v2>
References: <1630365207-20616-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1630365207-20616-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 30, 2021 at 04:13:27PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> In hv_pci_bus_exit, the code is holding a spinlock while calling
> pci_destroy_slot(), which takes a mutex.
> 
> This is not safe for spinlock. Fix this by moving the children to be
> deleted to a list on the stack, and removing them after spinlock is
> released.
> 
> Fixes: 94d22763207a ("PCI: hv: Fix a race condition when removing the device")
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lore.kernel.org/linux-hyperv/20210823152130.GA21501@kili/
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
