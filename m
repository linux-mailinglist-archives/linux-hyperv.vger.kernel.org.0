Return-Path: <linux-hyperv+bounces-10146-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG9xLk2k3Wl8hAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10146-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 04:19:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A22D3F4F6F
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E3583010639
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804BC3164D8;
	Tue, 14 Apr 2026 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VIcZE44g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379782D8391;
	Tue, 14 Apr 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133181; cv=none; b=h/uPIYIQBBeAMFbXoDC+3tVrKT8cIAn+Ez7SD93ou+1f9/6O4ZYeOEpPQQAum7tjKzzwuWOcIyfugePcLBHZ0TrmoyNIfPnIh2EgWVZcZTNvqFnyk+CzFdPi/6nfNtUa9ceyXzy4PG9bwiITLF9WVkd4Us8eeCCA0b78Y3WwqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133181; c=relaxed/simple;
	bh=ctYxeHeCXx0MmjSPKTDBbXUkgF0WOywVtMxtE82nmx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfIqp4os6T6FDGcruYomuZKpRPJO0sDUy3XCJRI0dyYZG6dcmnIH1aZUQACXM/uIBWOCJsaL4BrQjxsvPGEmm3cWZtFkoLz/QLBKmIRN3Z5yU6Qi46En4L/KHCrGvIXIrBswbkb3Qk24hMEkyWDxrRjI3wHIeu1tXQ+seNkY5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VIcZE44g; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLBSCf3230114;
	Tue, 14 Apr 2026 02:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B5bbZER/wFLjYOM4UoRPVtRCv9VUypQx/xXXnUGqY6E=; b=
	VIcZE44gAIoAM0+PHExdVKfNz9w1sVtnGD1wfZh1wKkGTM4AzrA7NXyqm8OCJlVV
	5eS5il1WrVbl2PzyDyTQbGmzTYSlHi0gcHYa6kcJMnicfkWhQhWQNeCGE9bFHGHa
	zdq2rgPhNLRkEznAmaV+aQ2jhJLPs6exSrZKPsy0vzVpXNAcJ9zZuvxo5GbJR0gf
	MFwlRVDwIrpCnmeMceQdcNxASq8AIPJXULjymseQWX+/Zcje+JquL07fkBxCTMpu
	zwrfizuaIjH/M7epZzWTW2+uBvvXn7wOgiuGHV9jdMdRfNQ9TBRV91U1XmZSi8YP
	fPRpb/dGHZptHa3K5/5aVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh8678amb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 02:19:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63E2EK1u023605;
	Tue, 14 Apr 2026 02:19:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nj0nu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 02:19:33 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63E2JTjj036955;
	Tue, 14 Apr 2026 02:19:33 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nj0nr0-5;
	Tue, 14 Apr 2026 02:19:32 +0000 (GMT)
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-scsi@vger.kernel.org, Li Tian <litian@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: Handle PERSISTENT_RESERVE_IN truncation for Hyper-V vFC
Date: Mon, 13 Apr 2026 22:19:19 -0400
Message-ID: <177595422515.3963380.12816099064749411625.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406015344.12566-1-litian@redhat.com>
References: <20260406015344.12566-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=928 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604140019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAyMCBTYWx0ZWRfX9WwuEAygOX6j
 iWqDd7mg51mj9UsJ2USb/WAwN/OegaRpk7RHBwLHAlm3JOb+QSGB121gr07o0nsZ5QhlEn0nuH6
 5LtkmBGmthvFFVtae64XgKpMg+UtVsigPvcd9RyDC0t6sNeKP6tx06bMmxrJ0RGm72RY0/UxrnP
 wcFOu+FP7ZOX1GxjTdNUl24VKNZJ2TZrGy0O0G1XWBPfGnkYB2ce1FcGQx5bVG3LReddr21OE2/
 j2X834DaVpfW0/SAVHelB7o8BRBO7nicDkzGIoZOpwovqB9m5MFhyH6zPEtDSf+zN4P9HO+jWbG
 qQhQ38muJfdTgL++C+giB6I/0VOma1RLRWNG6AO+mh1LXRWwSEyN3nC1oFgkNXEmAuAtG8b5lmV
 iByV+hPlw3tK7b8kb/gdLa3d+YRhsyQoM37CoxeklTARQGURldYLguxGxPEioGV9/tZiRz+HQaP
 LHDOFF7wqeuXL9bWh3A==
X-Authority-Analysis: v=2.4 cv=cbjiaHDM c=1 sm=1 tr=0 ts=69dda436 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=MGqCHUhnxNDYM6HRG4EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5vKsTLy64ks2V8VtUbr4s3SrWj_1O6WB
X-Proofpoint-ORIG-GUID: 5vKsTLy64ks2V8VtUbr4s3SrWj_1O6WB
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10146-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9A22D3F4F6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026 09:53:44 +0800, Li Tian wrote:

> The storvsc driver has become stricter in handling
> SRB status codes returned by the Hyper-V host. When using Virtual
> Fibre Channel (vFC) passthrough, the host may return
> SRB_STATUS_DATA_OVERRUN for PERSISTENT_RESERVE_IN commands if the
> allocation length in the CDB does not match the host's expected
> response size.
> 
> [...]

Applied to 7.1/scsi-queue, thanks!

[1/1] scsi: storvsc: Handle PERSISTENT_RESERVE_IN truncation for Hyper-V vFC
      https://git.kernel.org/mkp/scsi/c/9cf351b289fb

-- 
Martin K. Petersen

