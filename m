Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7685077E865
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjHPSMQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbjHPSME (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 14:12:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC25E4C;
        Wed, 16 Aug 2023 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692209523; x=1723745523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W1Z9/8uHetpktSbdkYvJ/MSVXwG6SiarpQeMufwFmCA=;
  b=j7uEMHOt2Js1sO8Pwa/tRPNk+J6Nzk6v3xBa0F17SkqEiNcVRAhVZoX3
   +VYSGYD0uEdS7N7SH5BU3RS3Z35zJ/H3nzkR/GTUxkUiWHBOO1QVT2Y76
   ULPIzerPqRNbnVjSEK810RVjM/FYhBOtGigwvHnA+y42iMe/uN5pdkIxv
   QmT+kqYj0S8b0bn0JLRJ4s61hU1EAN+uM3KyTAUqkApl5q0S6W9WxxrP2
   C2y9YTJc4s7y9PkjU2+FH82dgzJuwz8O9GKYbSA54oxKBO2KeItVk4FPG
   iCNXqqnElN4QxV2JuBVMRlZg2MHAOnwHWP9o4f0NDX4avLdMpWr6/4Kzv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352190998"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352190998"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737379091"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="737379091"
Received: from pnukala-mobl1.amr.corp.intel.com (HELO [10.209.74.99]) ([10.209.74.99])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:12:02 -0700
Message-ID: <402a0ea4-7944-4f00-a06d-a14578859384@linux.intel.com>
Date:   Wed, 16 Aug 2023 11:12:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, tglx@linutronix.de, jgg@ziepe.ca,
        bhelgaas@google.com, haiyangz@microsoft.com, kw@linux.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        mikelley@microsoft.com, robh@kernel.org, wei.liu@kernel.org,
        helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230816175939.21566-1-decui@microsoft.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230816175939.21566-1-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 8/16/2023 10:59 AM, Dexuan Cui wrote:
> When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
> device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
> device yet), doing a VM hibernation triggers a panic in
> hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
> pdev->dev.msi.data is still NULL.
>
> Avoid the panic by checking if MSI-X/MSI is enabled.
>
> Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>
> Changes in v2:
>      Replaced the test "if (!pdev->dev.msi.data)" with
> 		      "if (!pdev->msi_enabled && !pdev->msix_enabled)".
>        Thanks Michael!
>      Updated the changelog accordingly.
>
>   drivers/pci/controller/pci-hyperv.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 2d93d0c4f10d..bed3cefdaf19 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
>   	struct msi_desc *entry;
>   	int ret = 0;
>   
> +	if (!pdev->msi_enabled && !pdev->msix_enabled)
> +		return 0;
Isn't this is a error condition? Don't you want to return error here?
> +
>   	msi_lock_descs(&pdev->dev);
>   	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
>   		irq_data = irq_get_irq_data(entry->irq);
