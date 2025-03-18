Return-Path: <linux-hyperv+bounces-4567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F56EA66447
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 01:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28537A7E58
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B280BEC;
	Tue, 18 Mar 2025 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="doNQcO2P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455757E105;
	Tue, 18 Mar 2025 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259328; cv=none; b=J3z9t3dSP/a2rH4mR3WVPjNHBbwi1Ch++zMn5/aYp5Z9/5R5E3w0I80p6q0H0P0XMlVW9GJXJPtcYvMYVRwdSFiIXbUA103yu+w6hyK42UOVndXt1a6L4A0D2TvbGKY+XmcobrebHsCi0MHuypNkWHjafRDsIsTlVbGHSRoDGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259328; c=relaxed/simple;
	bh=OAqDGAI9JxTntixy6eS79VwMCD3BiKNJ7ik50uzMkms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqEgekEJZNV1CtoSiipx63mSOHZ6/JeD97Yh8r93nuhyVbx4Ki8u68+mWnDacS8pyCAw7FLlXHXlbi8D4Vtj8T7+boXYCO+97b/h8hp3aJEiqLNpBnYnUFYBjdALVSt8R+jT7ShbrWk5XKdEXdoxuct/Vuv8xyAXkZDtwv4RvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=doNQcO2P; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HLtrIt005451;
	Tue, 18 Mar 2025 00:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H7UJFzxG6iNksMi0TEBuscXeAQfnwj2bjb4Xbc0z6uc=; b=
	doNQcO2PzZX5KRn4iPa5I9prnRasZ2UB0Du7iJ7M4iywAHwaUGq6WB8NbakqsePk
	QwUdkr+OfxoSqIURrD7JomW7n2B04iJeWW5ylwRhMb8M583fOuuT4ancxvFTvKe5
	lmfxTfbvYF8Q/fPBFYixLyFLS9IW/XtbG2we5gH0evfRza3KFls7lhPSIYjzvmIp
	WxragAo/csUVETyC7y2B8UMYuJOPH1frrrjHaDnQ5NRIUyk/+/BnejkY3eQfHquh
	BzJQnmlwgZiCqWIZFuBH/nvrtd0mDk+fsuFTaKeKVANG6VErdIxPq7LNaxbe8J6G
	BwiWlA65B6P7f4THlTmQnw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kb47et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 00:55:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HNoFBx023554;
	Tue, 18 Mar 2025 00:55:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxeen375-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 00:55:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52I0tCZG013983;
	Tue, 18 Mar 2025 00:55:17 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45dxeen34c-5;
	Tue, 18 Mar 2025 00:55:17 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: eahariha@linux.microsoft.com, mhklinux@outlook.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        James.Bottomley@HansenPartnership.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Kisel <romank@linux.microsoft.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, apais@microsoft.com,
        benhill@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v2 0/1] scsi: storvsc: Don't report the host packet status as the hv status
Date: Mon, 17 Mar 2025 20:54:45 -0400
Message-ID: <174225924963.1094535.9687125064400338318.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304000940.9557-1-romank@linux.microsoft.com>
References: <20250304000940.9557-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180004
X-Proofpoint-GUID: DL36Iojav4BjGWoSB9FrWuZtoO-Q3Zog
X-Proofpoint-ORIG-GUID: DL36Iojav4BjGWoSB9FrWuZtoO-Q3Zog

On Mon, 03 Mar 2025 16:09:39 -0800, Roman Kisel wrote:

> The patch includes fixes for the log statements that are ambigious as
> to what they are logging.
> 
> Michael Kelley provided a great insight into the history of the code
> (** Thank you, Michael! **) and tagged the V1 patch with "Reviewed-by".
> I am not keeping the tag as a I added one more change to convert the
> status code to hex in addition to what was approved.
> 
> [...]

Applied to 6.15/scsi-queue, thanks!

[1/1] scsi: storvsc: Don't report the host packet status as the hv status
      https://git.kernel.org/mkp/scsi/c/7dcbda8a1d9e

-- 
Martin K. Petersen	Oracle Linux Engineering

