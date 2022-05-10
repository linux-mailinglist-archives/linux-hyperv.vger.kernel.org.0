Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C575520B3E
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 04:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiEJCdw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiEJCdf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 22:33:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2DB1C345C;
        Mon,  9 May 2022 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652149778; x=1683685778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VB+S7FbsbedyfQegYcDT9rEqTeQpA5DhiVtlZtTEzpM=;
  b=couAxsUKykYDw9d7hoseJH8jnF0OA7Bi/ohZ20paXcWf/4dGwwwaCHdB
   oq/9YtJlsTXm0faO6dbveKlFEhH0gtJK0fQw48mIgPAnH8zWmEIfpvQFT
   On8Fti8ZzDkO1Yyfq9bXbeklQ6NB+8C8lebuw1U0RECjuA1exwjRKh4+w
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 19:29:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 19:29:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 19:29:21 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 19:29:20 -0700
Message-ID: <8372be1c-5f7d-3a0e-38fb-787b9d38fcd9@quicinc.com>
Date:   Mon, 9 May 2022 20:29:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in
 compose_msi_msg()
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Jake Oshins <jakeo@microsoft.com>,
        David Zhang <dazhan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
 <1652132902-27109-2-git-send-email-quic_jhugo@quicinc.com>
 <BYAPR21MB1270A579B909B31FA271FC08BFC69@BYAPR21MB1270.namprd21.prod.outlook.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <BYAPR21MB1270A579B909B31FA271FC08BFC69@BYAPR21MB1270.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/9/2022 5:13 PM, Dexuan Cui wrote:
>> From: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> Sent: Monday, May 9, 2022 2:48 PM
>> Subject: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in
> 
> s/ITRE/IRTE. I suppose Wei can help fix this without a v2 :-)

Thanks for the review.

I have no problem sending out a V2.  Especially since you pointed out my 
mistakes on both patches.  I'll wait a little bit for any additional 
feedback, and then send out a V2.

> 
>> compose_msi_msg()
>> ...
>> Currently if compose_msi_msg() is called multiple times, it will free any
>> previous ITRE allocation, and generate a new allocation.  While nothing
>> prevents this from occurring, it is extranious when Linux could just reuse
> 
> s/extranious/extraneous
> 
>> the existing allocation and avoid a bunch of overhead.
>>
>> However, when future ITRE allocations operate on blocks of MSIs instead of
> 
> s/ITRE/IRTE
> 
>> a single line, freeing the allocation will impact all of the lines.  This
>> could cause an issue where an allocation of N MSIs occurs, then some of
>> the lines are retargeted, and finally the allocation is freed/reallocated.
>> The freeing of the allocation removes all of the configuration for the
>> entire block, which requires all the lines to be retargeted, which might
>> not happen since some lines might already be unmasked/active.
>>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Dexuan Cui <decui@microsoft.com>

