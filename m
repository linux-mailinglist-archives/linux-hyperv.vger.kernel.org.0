Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE4416F09
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Sep 2021 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbhIXJhT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Sep 2021 05:37:19 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37793 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhIXJhS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Sep 2021 05:37:18 -0400
Received: by mail-wr1-f54.google.com with SMTP id t8so25513133wrq.4;
        Fri, 24 Sep 2021 02:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KRYfypNkuIY9emLZqiqldN/0eSszJL/L7hkS9k8gfkA=;
        b=m5D0Vh0cSXUgya5uLyJUhldGjVydqzfU3oy3qz7rf+XJnpR7JiA9dEWUESA6BXNVJE
         2UpENO7SBZnyDHF8+W+I2i2iiZxzhrw5c+tEjSZri+gk5i52myIffmCc6KSGCPxiXn4u
         v+WF0H4BYk8lAPNgCfnyPP1NdI5iJXLgdueS3MVNX89OANwge56ixJiLvXRQGw9I5Yxj
         nw+dOfBRPR19Gn0fMZ/HuU9c1QT1RYRumJxoXMgvizzBpeTg11d0jGQpiVfcr/Yckr6t
         0gYmCqc0jqcF0LXyug1beOzx9dpIzjtbK4Erlp0eeEKQIdqivRrfCZZc4O7vt7ezKvLR
         oNQA==
X-Gm-Message-State: AOAM530IzVGQ3xjtA6qr4xPQsPQJlqI4oZswI4r8Qh1ABSd3M1SNRPri
        +EbCIyRkM2IW5KXqTZbgA28=
X-Google-Smtp-Source: ABdhPJxZFbl9E73RZActKtG/s6A/AvgOlwsJt9fpLYANe1VVnKWPpjD/wU6IN4dT5t+LO4BrDjlYjA==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr1002172wma.183.1632476144529;
        Fri, 24 Sep 2021 02:35:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j21sm7505008wrd.48.2021.09.24.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:35:44 -0700 (PDT)
Date:   Fri, 24 Sep 2021 09:35:42 +0000
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
Message-ID: <20210924093542.dac76ugni4cqtsum@liuwe-devbox-debian-v2>
References: <1630365207-20616-1-git-send-email-longli@linuxonhyperv.com>
 <20210831131607.vsjvmr43eei4dsie@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210831131607.vsjvmr43eei4dsie@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 31, 2021 at 01:16:07PM +0000, Wei Liu wrote:
> On Mon, Aug 30, 2021 at 04:13:27PM -0700, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> > 
> > In hv_pci_bus_exit, the code is holding a spinlock while calling
> > pci_destroy_slot(), which takes a mutex.
> > 
> > This is not safe for spinlock. Fix this by moving the children to be
> > deleted to a list on the stack, and removing them after spinlock is
> > released.
> > 
> > Fixes: 94d22763207a ("PCI: hv: Fix a race condition when removing the device")
> > 
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Michael Kelley <mikelley@microsoft.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Link: https://lore.kernel.org/linux-hyperv/20210823152130.GA21501@kili/
> > Signed-off-by: Long Li <longli@microsoft.com>
> 
> Reviewed-by: Wei Liu <wei.liu@kernel.org>

Applied to hyperv-fixes.
