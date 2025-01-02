Return-Path: <linux-hyperv+bounces-3569-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9AA00148
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 23:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0898F1883EE0
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 22:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8784D1B982C;
	Thu,  2 Jan 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SDNGaaw3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EF1B6D0F;
	Thu,  2 Jan 2025 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735858062; cv=none; b=XNLQu//UgqjsccuwR1qboTY6Nx8WpV81a4IQNmFBQRLVKPLJoYZoAPiAKYih9MgjUjG/5HAfTehy8D6Z8HrtBs1gIvMDg0alxCC9An9RFrd9ezYkGpARYe/SCnJuucCmjM78ZM4V/Mdx6KYuvVx/AZXwodGrOoHN3UHElJP3dlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735858062; c=relaxed/simple;
	bh=DSsgKLf1vbtZiKK9KqlWW0egQ9/9VEQqsppWlI2aGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAMsdOwYE7XJov1ief47hh/twqDEAOziMHB2EiemldzLZ4wNFo7aQQH8V51LFlQTl2WTdD2Qn0Izoqv5CoXuXnuXPFF+DN1uX/XtMVP/uZ7CldUokMwy2GYBgSobxzLpE4+AA1dIjEUX0neHuPCUcbQC6EcbHpbYdYU67bd1w+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SDNGaaw3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502KfuJ3015265;
	Thu, 2 Jan 2025 22:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=U7tnL0OGsltMWpN+/Pzxk8lgQVrxvWRSVUe9cvOe/ig=; b=
	SDNGaaw3XbUj1S6QFvLVC5139scD7TWpEhyd5yis3wIKVV6VSOVbHlNrcbCU66nl
	NVdhDYFwYbqv6NS8bkpwAdaWyyh3tOIF8bz+UkBWocmCmuLpmxfbG2TIOeUWP7Fm
	c0Mr8tuTzNrtw2S8YuCEO6OKQ7bn/zWvrMUEOfeJZvZBQn5bhslrSBXfLkFbFRgH
	3ZGgYVRJoa3WOTDSDSQp5gklzoOx67mGwJvrTZWdw0xTcyS0le6eFMWLDsNP7fbH
	slppSPpJ40jmikDZS+DjCfLcNOHahqZEymWZn0Ds0I5cEeEtVBlV00WHVXLQ+9DR
	0X2p9LQ1ZP8OY3huRPh0sg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a7d86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 22:47:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502LaiUr008778;
	Thu, 2 Jan 2025 22:47:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s93nwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 22:47:13 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 502MlAtf004461;
	Thu, 2 Jan 2025 22:47:12 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43t7s93nuq-2;
	Thu, 02 Jan 2025 22:47:12 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, James.Bottomley@HansenPartnership.com,
        mhkelley58@gmail.com
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Date: Thu,  2 Jan 2025 17:46:38 -0500
Message-ID: <173583977795.171606.8906239465384373872.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=983 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020199
X-Proofpoint-GUID: e6Ywwye_omB8U1gOZ8hmAB14_FT6wkJA
X-Proofpoint-ORIG-GUID: e6Ywwye_omB8U1gOZ8hmAB14_FT6wkJA

On Wed, 02 Oct 2024 20:53:28 -0700, mhkelley58@gmail.com wrote:

> Code specific to Hyper-V guests currently assumes the cpu_possible_mask
> is "dense" -- i.e., all bit positions 0 thru (nr_cpu_ids - 1) are set,
> with no "holes". Therefore, num_possible_cpus() is assumed to be equal
> to nr_cpu_ids.
> 
> Per a separate discussion[1], this assumption is not valid in the
> general case. For example, the function setup_nr_cpu_ids() in
> kernel/smp.c is coded to assume cpu_possible_mask may be sparse,
> and other patches have been made in the past to correctly handle
> the sparseness. See bc75e99983df1efd ("rcu: Correctly handle sparse
> possible cpu") as noted by Mark Rutland.
> 
> [...]

Applied to 6.14/scsi-queue, thanks!

[4/5] scsi: storvsc: Don't assume cpu_possible_mask is dense
      https://git.kernel.org/mkp/scsi/c/6cb7063feb2e

-- 
Martin K. Petersen	Oracle Linux Engineering

