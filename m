Return-Path: <linux-hyperv+bounces-918-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65E7EA9E0
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Nov 2023 05:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF921C20A00
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Nov 2023 04:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B14BA56;
	Tue, 14 Nov 2023 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P4U9JNsZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C60BA31;
	Tue, 14 Nov 2023 04:58:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC8F123;
	Mon, 13 Nov 2023 20:58:12 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE4dQxp015496;
	Tue, 14 Nov 2023 04:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ut+LP/oQgS6AHmq27TArlkMKu8wbNEjr6zcLsTELHGU=;
 b=P4U9JNsZ9twinkAM6crKSroq7yTQNIGWmkH2jnosKDAz9K5IrD0KC+OFma4jfeDqxQq+
 Jios5YHkR/P1oDpeARKJM2+nQJAHIoy/AU39G733GUA7X/t+IfSA/Um81F8A6iCtQL26
 XG4dtUswJSuAwmlGjkGcZuNFHb330V24H5OqAeBwm6fW/02agttPnGwa8mYMhC8YNPDL
 TSKl5hj7Y9fOX8//4nAwpHHKR4ae/Pebp5Zv8rijSDAyEzEk9K9W2+AIslRM+tKCuR55
 lfIA8BS+uF4K4AD8r57Ipm+m83CMrPvY4hiFvL9PLI1Y49qIQrtqpSe+/TUS76UcnzFQ vA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubuswrmww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 04:57:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AE4v2nN010730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 04:57:02 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 20:56:53 -0800
Message-ID: <ee647939-3f47-4b82-b1e4-a0c9414a1e8e@quicinc.com>
Date: Tue, 14 Nov 2023 12:56:43 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/17] Solve iommu probe races around iommu_fwspec
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, <acpica-devel@lists.linuxfoundation.org>,
        Alyssa Rosenzweig
	<alyssa@rosenzweig.io>,
        Albert Ou <aou@eecs.berkeley.edu>, <asahi@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Dexuan Cui <decui@microsoft.com>, <devicetree@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Frank
 Rowand <frowand.list@gmail.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Haiyang
 Zhang <haiyangz@microsoft.com>,
        Christoph Hellwig <hch@lst.de>, <iommu@lists.linux.dev>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        "K.
 Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-hyperv@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-snps-arc@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo
 Pieralisi <lpieralisi@kernel.org>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Hector Martin <marcan@marcan.st>, Palmer Dabbelt
	<palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Rob
 Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sudeep
 Holla <sudeep.holla@arm.com>,
        Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>,
        Sven Peter <sven@svenpeter.dev>,
        Thierry
 Reding <thierry.reding@gmail.com>,
        Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>,
        Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta
	<vgupta@kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Wei Liu
	<wei.liu@kernel.org>, Will Deacon <will@kernel.org>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W9mLspwTBqhYvV5ajR8gt_t_BuX4RknD
X-Proofpoint-ORIG-GUID: W9mLspwTBqhYvV5ajR8gt_t_BuX4RknD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1011 mlxlogscore=917
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140037

Thanks Jason.

On 2023/11/4 0:44, Jason Gunthorpe wrote:
> This is a more complete solution that the first attempt here:
> https://lore.kernel.org/r/1698825902-10685-1-git-send-email-quic_zhenhuah@quicinc.com
> 
> I haven't been able to test this on any HW that touches these paths, so if
> some people with HW can help get it in shape it can become non-RFC.

Thank you for addressing it quickly with a thorough way. I have 
backported it to Android common kernel 6.1 and tested basic sanity well.
I will share these to OEMs and see if they can reproduce further, thanks.

Thanks,
Zhenhua

