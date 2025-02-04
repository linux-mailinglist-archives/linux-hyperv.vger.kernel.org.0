Return-Path: <linux-hyperv+bounces-3830-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66005A26AB3
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Feb 2025 04:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0FB16802F
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Feb 2025 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FD15853B;
	Tue,  4 Feb 2025 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cc8wLrgd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD44156F3C;
	Tue,  4 Feb 2025 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738640113; cv=none; b=cCV2R+8iPPmw7qz5Bmws5asLAw0CLAGbISHRmv1UBJB6Z8K3SMHtc+cUL/SsV329Lk9wp0X/huHT2x4QV62rStNZcN1k0b2iSkyMwGRaBKVkZdImXAwnYZnEUFKVcLTvUKDGOux5oHsmjg/uC4uvh7bMkP74e5xaA7iNEP7xg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738640113; c=relaxed/simple;
	bh=qxIPkeWf/pea4HnHsuYjrpQiLs0+V+J3FwwMGncD2Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbUDnLk+/B6qDi0tGfyFeq6v539h7aubKshZSAd10N/XGYukXr960KzUy2914K1N0hmzk6SWzqCTK2Z88wwaSqGY9LfHkT3+x0ML3F8lNr0zJ0BFrAhwTnsnjUYEz31vW9bjlW2UVwJI1RdQLljZ1iAvNR/Ry8FXTBdFNIbh8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cc8wLrgd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141NAUk018902;
	Tue, 4 Feb 2025 03:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wihzaoziYI3Z7TGQVN/bOKuaOiFtZKEycMPNQDPPHJ0=; b=
	Cc8wLrgdoS3pmkcHTB9KDLI52gVIDzdhT6wH3oG5qpLg7wbGOdRgezwpLkJ85shT
	qjAjsN5JnO31QJ1hXsEqtm3rpDbVnQGABAQMl2n8kovvjk7+72o8sgjxnEQxfFJc
	5/TnUTODqNnVOI4gKEVAF7RiTBj8iuRYlko2cAixwaKE5l2zbg4obYA49EuXG+vm
	5BKefulCiEcxO3f8G/C6bKvbwM4efagLCYPIqrzHeyoePf6RRSChhp6r1b2Mn+F5
	7L6lbbiM9vi47NRpP2KHJPQn6K33IdUWFk6BcWol8/bjs9yrbEqQAqhu+LrecNJN
	p6QgdfK+m4fzLrxiGAHnnQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hh73kufs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 03:34:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5140M8e6038975;
	Tue, 4 Feb 2025 03:33:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e76f14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 03:33:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5143Xs6q015172;
	Tue, 4 Feb 2025 03:33:58 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44j8e76ex2-4;
	Tue, 04 Feb 2025 03:33:58 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        James Bottomley <JBottomley@Odin.com>, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Kisel <romank@linux.microsoft.com>,
        Michael Kelley <mhklinux@outlook.com>, longli@linuxonhyperv.com
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>, stable@kernel.org
Subject: Re: [PATCH v2] scsi: storvsc: Set correct data length for sending SCSI command without payload
Date: Mon,  3 Feb 2025 22:33:07 -0500
Message-ID: <173863996289.4118719.8857069927274668489.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1737601642-7759-1-git-send-email-longli@linuxonhyperv.com>
References: <1737601642-7759-1-git-send-email-longli@linuxonhyperv.com>
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
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=575
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502040026
X-Proofpoint-ORIG-GUID: EIAOo9MPQ9f0k6X-xtmte1ScVbfTUsOY
X-Proofpoint-GUID: EIAOo9MPQ9f0k6X-xtmte1ScVbfTUsOY

On Wed, 22 Jan 2025 19:07:22 -0800, longli@linuxonhyperv.com wrote:

> In StorVSC, payload->range.len is used to indicate if this SCSI command
> carries payload. This data is allocated as part of the private driver
> data by the upper layer and may get passed to lower driver uninitialized.
> 
> For example, the SCSI error handling mid layer may send TEST_UNIT_READY
> or REQUEST_SENSE while reusing the buffer from a failed command. The
> private data section may have stale data from the previous command.
> 
> [...]

Applied to 6.14/scsi-fixes, thanks!

[1/1] scsi: storvsc: Set correct data length for sending SCSI command without payload
      https://git.kernel.org/mkp/scsi/c/87c4b5e8a6b6

-- 
Martin K. Petersen	Oracle Linux Engineering

