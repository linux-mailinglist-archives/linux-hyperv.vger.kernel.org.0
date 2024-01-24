Return-Path: <linux-hyperv+bounces-1466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB33839FD4
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 04:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07091F2BA49
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 03:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFD46123;
	Wed, 24 Jan 2024 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/Qezq09"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FB6105;
	Wed, 24 Jan 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065266; cv=none; b=NrZPueAHefzBCJizZqM2jKES68rsxNyewzH5MwAYS17ScQKdxVqbtQjXXTdxTU9ygjsgpk4J6Q+oKqNmDTHzDJhvkoA6fTrjYUHomCQqDyXfq4D0bzS2fI6wwsjgXZlutCzcYgryFdw9XZpH37/0buYgDJ/MzCeH3k4pDSgM1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065266; c=relaxed/simple;
	bh=jpttwKn0WE/dCDrLSVB1q4DtvmtjrDz7OA1oWnWVZ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMASHr4vqlfRDv/V8Q9wlk/y+zWqhPMSUGxcFcetxtWKT2rL5JyNQGDuU8bo0V/bfm5mLoty6J4SHlaEVZRAW4FMzFaLIkFG2kIYCcbCyWcbK6Lv7Qed7S9xTNsneGIuNDQkJ+AIKpwK3k97MgQpRaBnYbp2m3mjsJyWdTPa078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F/Qezq09; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O2xTFS018021;
	Wed, 24 Jan 2024 03:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=4UbNeOfbfl3MG8nSF1LqnyRnaVfgigwOC+AsCYPZ+QE=;
 b=F/Qezq09BxPS77h7XlSUHhQVJxto/9g/ZhOQTmvb5egvMnLmbMEKryrp4Z9ferd+acBL
 /CsBXHaoejTmY01eXDk3oNc7RusPcxx8hokNQHu2t5JGN/d3y5FcrLFqasflpMqjJpLz
 FhgtdpcAQu8Zzhx15JATS5ftU/+o1y2HJghN+xZ2hibf2SJeWZ0ekjalrBb9JK7sCqZ1
 XP8KuYqeZxDW+Sfdi+orVGzakqgfUtYxn50/WjXVrDLtYX3F1VJ1Phg9LWSK47qMeWlB
 fcDSsB6upRG1rS8ZeGPxvlg7IHMGhLkfLxlu29JzvwjWZ47DxxhgkaogJmdIvUibwtVJ SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anqxhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 03:00:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O16JZd040785;
	Wed, 24 Jan 2024 03:00:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3168jks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 03:00:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40O30rRu012869;
	Wed, 24 Jan 2024 03:00:54 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vs3168jht-2;
	Wed, 24 Jan 2024 03:00:54 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        mhkelley58@gmail.com
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] scsi: storvsc: Fix ring buffer size calculation
Date: Tue, 23 Jan 2024 22:00:43 -0500
Message-ID: <170606516777.594851.3500343804163840490.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240122170956.496436-1-mhklinux@outlook.com>
References: <20240122170956.496436-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=823 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240021
X-Proofpoint-GUID: rlJhMIxorxUyBSG_xJbRGYVcRwLhc2uL
X-Proofpoint-ORIG-GUID: rlJhMIxorxUyBSG_xJbRGYVcRwLhc2uL

On Mon, 22 Jan 2024 09:09:56 -0800, mhkelley58@gmail.com wrote:

> Current code uses the specified ring buffer size (either the default of
> 128 Kbytes or a module parameter specified value) to encompass the one page
> ring buffer header plus the actual ring itself.  When the page size is
> 4K, carving off one page for the header isn't significant.  But when the
> page size is 64K on ARM64, only half of the default 128 Kbytes is left
> for the actual ring.  While this doesn't break anything, the smaller
> ring size could be a performance bottleneck.
> 
> [...]

Applied to 6.8/scsi-fixes, thanks!

[1/1] scsi: storvsc: Fix ring buffer size calculation
      https://git.kernel.org/mkp/scsi/c/f4469f385835

-- 
Martin K. Petersen	Oracle Linux Engineering

