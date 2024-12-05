Return-Path: <linux-hyperv+bounces-3397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0989E4C32
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 03:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893CE188192C
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089D716F0E8;
	Thu,  5 Dec 2024 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESPb2ejs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C016C850;
	Thu,  5 Dec 2024 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365071; cv=none; b=blUi9wYWXwq5qTGCW7CJnTTDKJj6B4yCisad7w9BbTg4junwsf6Pe2dFFgFAEhxGnvJIpjvCJHiXm1JZMSLrrhuwfOORLoCsOAPE+UtQofmeIuQqBXYRxUEjeQuJWqmlG8JSDWFwucnB/f4Zm/3ImF/HcPkqgrjpVl70YbKuMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365071; c=relaxed/simple;
	bh=WtPKrNNQAJjoEfyBxkUY1vItOGYUOBen+mTMdZFxwRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oq45gzAYdwSnh7mWCm39mB8vICJkjF+/ZnPB4qGMrWD5appgXZFSa2SgucA6Mcqg3IoHRkndHXTwhdejlLnwfoaAhJOBstT/QmbW6HGDm2QRD436js9zfoky9rfKno0G0YDXGG6aL717xnaOIhO5XeIbUQyo45C8quPFPKP/79I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ESPb2ejs; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B51CYc3031000;
	Thu, 5 Dec 2024 02:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nM+0N2wzN7/4V2S4/RpwR0K03z88Xz0NaVLRZ6t0y/A=; b=
	ESPb2ejsTDVcqxOfb/FAAGfDfv9qSFuEQjHv//t+mwDtCpOiV8eAeTv1Uljxoq1i
	cvieX4hUa+XFOLzhMjdlXQHuRhoqdVaezoJzcYPRjTIYULeJMJM+4S+RequKvrQh
	QO6dbD5/EifL/FyXQXwuqo6216ZgaKWRKYBmWgYgY+vQWZqKxH6iNV702jdsSB2t
	pMOZ6WoU9/9+0EZ80z/7Nb7hb/lCYFImg/9XXOYKN4eWXnA4rBTIzOe1091ymfEA
	vDPHIH3yZwLvRMid6S21l+ctnpz7sMU3yPjrR9POAmMwO07UWDzdxm7kLi6gWNod
	W81xUP/2L8k2aeHsxHdk7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas9ssy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 02:17:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B508Kw7001404;
	Thu, 5 Dec 2024 02:17:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5a8u4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 02:17:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B52HbvK018742;
	Thu, 5 Dec 2024 02:17:37 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 437s5a8u3n-1;
	Thu, 05 Dec 2024 02:17:37 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, jejb@linux.ibm.com, mhklinux@outlook.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Cathy Avery <cavery@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, bhull@redhat.com,
        emilne@redhat.com, loberman@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH v2] scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error
Date: Wed,  4 Dec 2024 21:17:00 -0500
Message-ID: <173336487649.2765947.2176968501123311330.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241127181324.3318443-1-cavery@redhat.com>
References: <20241127181324.3318443-1-cavery@redhat.com>
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
 definitions=2024-12-04_21,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050017
X-Proofpoint-GUID: FKmtx1lRMXwuQWMBEX-LhcJyD712hr4f
X-Proofpoint-ORIG-GUID: FKmtx1lRMXwuQWMBEX-LhcJyD712hr4f

On Wed, 27 Nov 2024 13:13:24 -0500, Cathy Avery wrote:

> This patch partially reverts
> 
> 	commit 812fe6420a6e789db68f18cdb25c5c89f4561334
> 	Author: Michael Kelley <mikelley@microsoft.com>
> 	Date:   Fri Aug 25 10:21:24 2023 -0700
> 
> 	scsi: storvsc: Handle additional SRB status values
> 
> [...]

Applied to 6.13/scsi-fixes, thanks!

[1/1] scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error
      https://git.kernel.org/mkp/scsi/c/b1aee7f03461

-- 
Martin K. Petersen	Oracle Linux Engineering

