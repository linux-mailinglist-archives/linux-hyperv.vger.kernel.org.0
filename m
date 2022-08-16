Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4899F595FC8
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 18:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiHPQEl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Aug 2022 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiHPQEP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 12:04:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4436A33417;
        Tue, 16 Aug 2022 09:01:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GFcNhU021419;
        Tue, 16 Aug 2022 16:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5Yof2e/M6mXS9yDypZqKKDax++PSsoGl+R33p9/hIr0=;
 b=mahMIrxlaibb4LnPpnULJ/yz6jm21qsQnW30g5TfdmA4bBpcB+Le25Scam0feEbDng7e
 2MhhxUR5eVlBfJqioh61bfSlUpAHwFvT6CABnt6GkBp5jA3aHAM9pxxsvTItQvjGF6vf
 yAHGFYFJK6Vi88vMYMa9Iw4WSkC95ENMh7DsfDVwJ2V80cxh1hZ5hBUN2Nqad1cge6KW
 YI0nEYpbPx9ptKOw0+sCeenAyQL8rnWmULG81egERTAt+aisKEg1w3SJBvDRcQbijW/v
 Mr+VhFKf2ajWXiYQ/gP89WYqplTT+kqZsYg50I/JPotxnccWCUIchfrMxlZ98/khPQtK Xw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j08rs97dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 16:01:31 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27GFpiTj013998;
        Tue, 16 Aug 2022 16:01:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 3j0bu4hccd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 16:01:30 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27GG1UPs031872;
        Tue, 16 Aug 2022 16:01:30 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 27GG1UtO031824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 16:01:30 +0000
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 09:01:30 -0700
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 09:01:28 -0700
Message-ID: <5e4258b6-d253-c8bc-f697-c21d7eff63a5@quicinc.com>
Date:   Tue, 16 Aug 2022 10:01:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
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
References: <20220815185505.7626-1-decui@microsoft.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220815185505.7626-1-decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wJ3k5Q8zfNpYCQ4n01YM9RGz6Ou7No2A
X-Proofpoint-GUID: wJ3k5Q8zfNpYCQ4n01YM9RGz6Ou7No2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208160060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/15/2022 12:55 PM, Dexuan Cui wrote:
> The local variable 'vector' must be u32 rather than u8: see the
> struct hv_msi_desc3.
> 
> 'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
> hv_msi_desc2 and hv_msi_desc3.
> 
> Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> ---
> 
> The patch should be appplied after the earlier patch:
>      [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
>      https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui%40microsoft.com/
> 
>   drivers/pci/controller/pci-hyperv.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 65d0dab25deb..53580899c859 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1614,7 +1614,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
>   
>   static u32 hv_compose_msi_req_v1(
>   	struct pci_create_interrupt *int_pkt, struct cpumask *affinity,
> -	u32 slot, u8 vector, u8 vector_count)
> +	u32 slot, u8 vector, u16 vector_count)
>   {
>   	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
>   	int_pkt->wslot.slot = slot;
> @@ -1642,7 +1642,7 @@ static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
>   
>   static u32 hv_compose_msi_req_v2(
>   	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
> -	u32 slot, u8 vector, u8 vector_count)
> +	u32 slot, u8 vector, u16 vector_count)
>   {
>   	int cpu;
>   
> @@ -1661,7 +1661,7 @@ static u32 hv_compose_msi_req_v2(
>   
>   static u32 hv_compose_msi_req_v3(
>   	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
> -	u32 slot, u32 vector, u8 vector_count)
> +	u32 slot, u32 vector, u16 vector_count)
>   {
>   	int cpu;
>   
> @@ -1702,7 +1702,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>   	struct tran_int_desc *int_desc;
>   	struct msi_desc *msi_desc;
>   	bool multi_msi;
> -	u8 vector, vector_count;
> +	u32 vector; /* Must be u32: see the struct hv_msi_desc3 */

Don't you need to cast this down to a u8 for v1 and v2?
Feels like this should be generating a compiler warning...
