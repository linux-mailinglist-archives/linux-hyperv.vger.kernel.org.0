Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE5589D6A
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiHDOWa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Aug 2022 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiHDOW2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Aug 2022 10:22:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F11F2E7;
        Thu,  4 Aug 2022 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659622947; x=1691158947;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XGxaOPSSf/dYHdHGXWUvW+HF+yIBOA1VfLwIE2nD8Nw=;
  b=TxlR0P9K9BWavG85g5buFpteRzp600Z7rxgNg8zTp/wnxR1Zka2Xi3oI
   TYZargKqLFCIzR08I0RokdZxbNKb3eaVcEm/83P4ihN1Z0cS6fceUwjO8
   KO5RJEFyFwWXWTAiV3sQXM0+QABSICb1Gn+wGh1z92d/Rq1gC79Vta+OX
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Aug 2022 07:22:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 07:22:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 4 Aug 2022 07:22:26 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 4 Aug 2022
 07:22:25 -0700
Message-ID: <0f19cc67-ccb1-7cd1-5475-d2ec0e1abfc0@quicinc.com>
Date:   Thu, 4 Aug 2022 08:22:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Content-Language: en-US
To:     <decui@microsoft.com>, <wei.liu@kernel.org>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <sthemmin@microsoft.com>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mikelley@microsoft.com>,
        <robh@kernel.org>, <kw@linux.com>, <helgaas@kernel.org>,
        <alex.williamson@redhat.com>, <boqun.feng@gmail.com>,
        <Boqun.Feng@microsoft.com>
CC:     Carl Vanderlip <quic_carlv@quicinc.com>
References: <20220804025104.15673-1-decui@microsoft.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220804025104.15673-1-decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/3/2022 8:51 PM, Dexuan Cui wrote:
> Jeffrey's 4 recent patches added Multi-MSI support to the pci-hyperv driver.
> Unluckily, one of the patches, i.e., b4b77778ecc5, causes a regression to a
> fio test for the Azure VM SKU Standard L64s v2 (64 AMD vCPUs, 8 NVMe drives):
> 
> when fio runs against all the 8 NVMe drives, it runs fine with a low io-depth
> (e.g., 2 or 4); when fio runs with a high io-depth (e.g., 256), somehow
> queue-29 of each NVMe drive suddenly no longer receives any interrupts, and
> the NVMe core code has to abort the queue after a timeout of 30 seconds, and
> then queue-29 starts to receive interrupts again for several seconds, and
> later queue-29 no longer receives interrupts again, and this pattern repeats:
> 
> [  223.891249] nvme nvme2: I/O 320 QID 29 timeout, aborting
> [  223.896231] nvme nvme0: I/O 320 QID 29 timeout, aborting
> [  223.898340] nvme nvme4: I/O 832 QID 29 timeout, aborting
> [  259.471309] nvme nvme2: I/O 320 QID 29 timeout, aborting
> [  259.476493] nvme nvme0: I/O 321 QID 29 timeout, aborting
> [  259.482967] nvme nvme0: I/O 322 QID 29 timeout, aborting
> 
> Some other symptoms are: the throughput of the NVMe drives drops due to
> commit b4b77778ecc5. When the fio test is running, the kernel prints some
> soft lock-up messages from time to time.
> 
> Commit b4b77778ecc5 itself looks good, and at the moment it's unclear where
> the issue is. While the issue is being investigated, restore the old behavior
> in hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
> single-MSI and MSI-X. This is a stopgap for the above NVMe issue.
> 
> Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> ---

I'm sorry a regression has been discovered.  Right now, the issue 
doesn't make sense to me.  I'd love to know what you find out.

This stopgap solution appears reasonable to me.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
