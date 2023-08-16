Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3E77E9C5
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 21:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbjHPTiD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbjHPThh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 15:37:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393611FE1;
        Wed, 16 Aug 2023 12:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692214656; x=1723750656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e78L0+6Q02AMApoSzmAbj75FvmXVPcNEt8S1vbncVXo=;
  b=Bibx8xDyZ81NvK5aU+3LcGLp+Q3k7F/YGgdiBXuR1aaefa6wv71bXes7
   eZphGaP9hce/qDidH6rFF85hV0Ra8SGeiQ0+QyBqxSDnbnY+cq7SGLu+I
   ZupdL6hfKfwuV6EC2vR9dU7+kjsJDFuzeSBsW+xbMU+oD7jDEFs9oS1j1
   584Kf5yyxfCGGNitC7anfTeR87UwvUUr9tR83SX/rQx23d1F0VIbHp2Oh
   NTUVoIkbGU0ikN006b2cYvqhVH/pDy4QKLJiC1GgA5qDe1gj4HtARrCog
   6enjuvVdeCTrKuWfoCRf6OQFdOa9d3bPvd3nB6jV0qJugy4FCbcMePGbA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403598291"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="403598291"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 12:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824344977"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="824344977"
Received: from pnukala-mobl1.amr.corp.intel.com (HELO [10.209.74.99]) ([10.209.74.99])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 12:37:35 -0700
Message-ID: <d24f4ee9-798b-44e2-bafc-67808e38e72a@linux.intel.com>
Date:   Wed, 16 Aug 2023 12:37:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kw@linux.com" <kw@linux.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230816175939.21566-1-decui@microsoft.com>
 <402a0ea4-7944-4f00-a06d-a14578859384@linux.intel.com>
 <SA1PR21MB13352A1D7C4575CB83CE47A1BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <SA1PR21MB13352A1D7C4575CB83CE47A1BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 8/16/2023 12:30 PM, Dexuan Cui wrote:
>> From: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Sent: Wednesday, August 16, 2023 11:12 AM
>> [...]
>> On 8/16/2023 10:59 AM, Dexuan Cui wrote:
>>> When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
>>> device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
>>> device yet), doing a VM hibernation triggers a panic in
>>> hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
>>> pdev->dev.msi.data is still NULL.
>>>
>>> Avoid the panic by checking if MSI-X/MSI is enabled.
>>>
>>> Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
>>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>> ---
>>>
>>> Changes in v2:
>>>       Replaced the test "if (!pdev->dev.msi.data)" with
>>> 		      "if (!pdev->msi_enabled && !pdev->msix_enabled)".
>>>         Thanks Michael!
>>>       Updated the changelog accordingly.
>>>
>>>    drivers/pci/controller/pci-hyperv.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-
>> hyperv.c
>>> index 2d93d0c4f10d..bed3cefdaf19 100644
>>> --- a/drivers/pci/controller/pci-hyperv.c
>>> +++ b/drivers/pci/controller/pci-hyperv.c
>>> @@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct pci_dev
>> *pdev, void *arg)
>>>    	struct msi_desc *entry;
>>>    	int ret = 0;
>>>
>>> +	if (!pdev->msi_enabled && !pdev->msix_enabled)
>>> +		return 0;
>> Isn't this is a error condition? Don't you want to return error here?
> This is not an error.  If a PCI device driver is not loaded or not installed,
> MSI-X/MSI is not enabled on the device, so pdev->msi_enabled is 0
> and pdev->msix_enabled is 0. In this case, it's still legit for a user to request
> the system (i.e. here it's a Linux VM running on Hyper-V) to hibernate -- in
> this case, we should not try to save/restore the MSI/MSI-X state, and we
> should not let the hibernation fail; here we should just ignore the device
> by returning a success ("return 0;").

Got it. Looks good to me.

Reviewed-by: sathyanarayanan.kuppuswamy@linux.intel.com

>
>>> +
>>>    	msi_lock_descs(&pdev->dev);
>>>    	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
>>>    		irq_data = irq_get_irq_data(entry->irq);
