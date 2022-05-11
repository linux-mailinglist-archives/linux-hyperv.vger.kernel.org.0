Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF9523615
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbiEKOr2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244750AbiEKOr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 10:47:27 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DBF13F1E;
        Wed, 11 May 2022 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652280446; x=1683816446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N7APsdlpxz6u79WorIWwR5LZd+w3+vL9fRK/HNG4EQU=;
  b=Sj9Q8flTXilnYFMR5m9urM3Xi1x4FYM5pLP57cfZwlxX4IE30iJzvsYQ
   +OdANbqjx2JoDbWmf27lRjC12XEZUZRYhr+uwqyjXIEXhMkI6r7xza9cL
   dRGmLFsifUSidTBSpslVMszrCl1peGoiCpW9+hfH4T170M1M1gdHD/P0T
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 07:47:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 07:47:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 07:47:24 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 07:47:24 -0700
Message-ID: <a0e60283-a448-650f-808e-a0080ae550f7@quicinc.com>
Date:   Wed, 11 May 2022 08:47:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/2] hyperv compose_msi_msg fixups
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <decui@microsoft.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <jakeo@microsoft.com>,
        <dazhan@microsoft.com>, <linux-hyperv@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
 <20220511144124.rj7inq6zy6bgbii4@liuwe-devbox-debian-v2>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220511144124.rj7inq6zy6bgbii4@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/11/2022 8:41 AM, Wei Liu wrote:
> On Mon, May 09, 2022 at 03:48:20PM -0600, Jeffrey Hugo wrote:
>> While multi-MSI appears to work with pci-hyperv.c, there was a concern about
>> how linux was doing the ITRE allocations.  Patch 2 addresses the concern.
>>
>> However, patch 2 exposed an issue with how compose_msi_msg() was freeing a
>> previous allocation when called for the Nth time.  Imagine a driver using
>> pci_alloc_irq_vectors() to request 32 MSIs.  This would cause compose_msi_msg()
>> to be called 32 times, once for each MSI.  With patch 2, MSI0 would allocate
>> the ITREs needed, and MSI1-31 would use the cached information.  Then the driver
>> uses request_irq() on MSI1-17.  This would call compose_msi_msg() again on those
>> MSIs, which would again use the cached information.  Then unmask() would be
>> called to retarget the MSIs to the right VCPU vectors.  Finally, the driver
>> calls request_irq() on MSI0.  This would call conpose_msi_msg(), which would
>> free the block of 32 MSIs, and allocate a new block.  This would undo the
>> retarget of MSI1-17, and likely leave those MSIs targeting invalid VCPU vectors.
>> This is addressed by patch 1, which is introduced first to prevent a regression.
>>
>> Jeffrey Hugo (2):
>>    PCI: hv: Reuse existing ITRE allocation in compose_msi_msg()
>>    PCI: hv: Fix interrupt mapping for multi-MSI
>>
> 
> Applied to hyperv-next. Thanks.

Huh?  I thought you wanted a V2.  I was intending on sending that out today.

-Jeff
