Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092641BA0F9
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2020 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD0KVO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Apr 2020 06:21:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgD0KVI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Apr 2020 06:21:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id x18so19850266wrq.2;
        Mon, 27 Apr 2020 03:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+7bVFLWrQIX8JTal4r0/ZmJRvVDeqQomfNKtoU2FS3E=;
        b=YrOZ5zWfKd0CqAbguZCn6y5ydA+zHJLYxasCh2WrTaN6p8FMRM4tF1XAhAwEKjKQPY
         1EgIbCl+bXYRH5zPkiANzNypaEuziI2qyMdvHNRc7Mv5RHnK2j9JmatnGuBq024h7WQS
         BzqBduNksbl5stgXNCuBF+wyC+uOu0vNvZKoMuP0Jy/V+jtkLeTsfudnAzw2Y+PunBOF
         nYnkGkPzwDMDrYrwMcs8ii37VpXCpH2ZUvJ3m0azAaKngd3bj0VbzbPtWsEfoWDhTBLA
         cJL7DxdEQRD44Se0nBZaSJk9JiGovgzwmzXEr08djo7Qgr458foAbT3ETRBM3IH/ZvSe
         UK/Q==
X-Gm-Message-State: AGi0PuZUytQDm6ACPnZDzzaTmpeYwUwisbf6vTlvMMzRmjhjpIS+4ZZX
        DfnXC8Vd4SPJMUMsL+Zc/mFOLRZP
X-Google-Smtp-Source: APiQypKFmkXpGVvRzHZGFEZVOY9BybBoS1EtcBDc2CSoMzoH9YHRDKgDok7WTYAp0c8U/f9qn30bcQ==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr27795565wrs.90.1587982865429;
        Mon, 27 Apr 2020 03:21:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b82sm15832648wmh.1.2020.04.27.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 03:21:04 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:21:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Subject: Re: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Message-ID: <20200427102102.lar6d4w3rqz3d3j4@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200426132430.1756-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426132430.1756-1-weh@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Apr 26, 2020 at 09:24:30PM +0800, Wei Hu wrote:
> In the case of kdump, the PCI device was not cleanly shut down
> before the kdump kernel starts. This causes the initial
> attempt of entering D0 state in the kdump kernel to fail with
> invalid device state 0xC0000184 returned from Hyper-V host.
> When this happens, explicitly call PCI bus exit and retry to
> enter the D0 state.
> 
> Also fix the PCI probe failure path to release the PCI device
> resource properly.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 34 ++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index e15022ff63e3..eb4781fa058d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2736,6 +2736,10 @@ static void hv_free_config_window(struct hv_pcibus_device *hbus)
>  	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
>  }
>  
> +#define STATUS_INVALID_DEVICE_STATE		0xC0000184
> +

Can you please move this along side STATUS_REVISION_MISMATCH?

Wei.
