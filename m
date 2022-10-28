Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56B611413
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Oct 2022 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiJ1OIq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Oct 2022 10:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiJ1OIp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Oct 2022 10:08:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB51E0447;
        Fri, 28 Oct 2022 07:08:44 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SA7qlQ021510;
        Fri, 28 Oct 2022 14:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KqhrtzFoFsUHKC1+MYXPvOn8E01+NljCX7pRHoj2t7g=;
 b=eaaktgUcQFcJR631ZscROJugxwLyACHEg07Uww1Xq8LFJHMPEmLvzqB4jpwtVv9UtGJN
 +bSf9Dt1xau7JhiIq/d5qzH0eypK7FrDARweGVf2VGABhxZYNFQS+bzi0mGFHRdmZfYz
 vsakb5nsGasWr8AfzcfACDXHaxOBeY/eap8MyQeUqmiQe6HPzwC53Gew0FKJExvZ6Eo0
 u8a3eadvu/yzNZjo9Rskstjb391+2n3VPm3T/pD7PYFyy0ZRDuzqbsNXh2GnOFx1sJ97
 R7RgVpwQNX8B7citxYyjTjUee6iWTjxn+MLGklze+xKGe9o78jqjRJmLwlRfDYCk10kv Vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfyf7jrrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:08:36 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29SE8ZZj018920;
        Fri, 28 Oct 2022 14:08:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kc9kkywga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:08:35 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SE8ZE7018915;
        Fri, 28 Oct 2022 14:08:35 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 29SE8ZBQ018914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 14:08:35 +0000
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 28 Oct
 2022 07:08:33 -0700
Message-ID: <4dafab73-9957-f1df-69fe-3cfa59fb22fb@quicinc.com>
Date:   Fri, 28 Oct 2022 08:08:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] PCI: hv: Fix the definition of vector in
 hv_compose_msi_msg()
Content-Language: en-US
To:     <decui@microsoft.com>, <quic_carlv@quicinc.com>,
        <wei.liu@kernel.org>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <sthemmin@microsoft.com>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mikelley@microsoft.com>,
        <robh@kernel.org>, <kw@linux.com>, <helgaas@kernel.org>,
        <alex.williamson@redhat.com>, <boqun.feng@gmail.com>,
        <Boqun.Feng@microsoft.com>
References: <20221027205256.17678-1-decui@microsoft.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20221027205256.17678-1-decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H1meD1hpeJh7mRmI_g71LuErV_IGpo81
X-Proofpoint-GUID: H1meD1hpeJh7mRmI_g71LuErV_IGpo81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=978 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/27/2022 2:52 PM, Dexuan Cui wrote:
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

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
