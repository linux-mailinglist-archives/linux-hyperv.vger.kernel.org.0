Return-Path: <linux-hyperv+bounces-7017-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD3BAB07E
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 04:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1661C6276
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 02:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEDF204F99;
	Tue, 30 Sep 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="blA5Hi0I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14431922FD;
	Tue, 30 Sep 2025 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199860; cv=none; b=Fx7lxvJw+KSXMhlQK4V6fk8dII1azfS3gOJbdCAsJA/pXE9QxZNf0T7Sat7NmA6kJTYjk4ZSndX9Xk5c+iDkh9K/hZ+kfh5vDW8B8gxUDVRDZk3zo2+mT2cGjRMmm+NHNygBJWuXKoQL+dVFEw1ibsFOnNNzaJLT3Tg9hqswoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199860; c=relaxed/simple;
	bh=PF7/ahiKlaPtO5VmXKx0j9xBl4IKiUdw2yWy84MCxuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB3NHbOXDa5OUEmwlYrArpIyqsPJ4lm/7gyG+dya+ZCyDytEyYfsyq/FUcGHnElPZOWXzavANarPi+gfpZeFAM5ecJJrymqPrr+EDSqKyVbWh3mB/HKKV9ltqvxh000Xd0x0ptY/dnzhAzq5/74IVM6FjrWmsej56iAoFH3ZPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=blA5Hi0I; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U2PF88003362;
	Tue, 30 Sep 2025 02:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8WJEenrLjrpgIxp3I+vSM3MZEzLNxxBKZJoSGfcW0Qc=; b=
	blA5Hi0ItOw9oL7er/WIKT4MGuSw3IYkYy2QmOtf+KFJvJt3FoZAgzj3wJTLkfvd
	wayyBuMB+QdGHt1s7BHdmJGsQoQ4aru3U3pZ9Ao1wxz45n23WEl9iDeFIWuNB223
	+bOtMvpCfz3cQ+lM0w9U0MIgkwVKdSWrlv9W1T9QTeaIZ1NWmYURbA1Rsa9qEYUa
	Sd2Mbt8W5aFmiwNLONk5KJ9fuFL1XMeHi4lU76QdCODHbCBJbSAIH3ZDdoeRCXvp
	zHTaRW6pWh+ft8ClFI6ueKIur1eLaQfYIIV6Y5fx0vaIvIFdJAcKhbWcNWmXIWSo
	giEd1pk+zahWl4v/h7UXnQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49g6d1g0ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 02:37:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58U0Nxed007709;
	Tue, 30 Sep 2025 02:37:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c86ew2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 02:37:02 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58U2awVD004400;
	Tue, 30 Sep 2025 02:37:01 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49e6c86eur-3;
	Tue, 30 Sep 2025 02:37:01 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Khalid Aziz <khalid@gonehiking.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Prateek Singh Rathore <prateek.singh.rathore@gmail.com>,
        Geoff Levand <geoff@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Fourier <fourier.thomas@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/6] scsi: Remove redundant ternary operators
Date: Mon, 29 Sep 2025 22:36:49 -0400
Message-ID: <175917739968.3755404.663662648964334597.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902132359.83059-1-liaoyuanhong@vivo.com>
References: <20250902132359.83059-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=945 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300021
X-Proofpoint-GUID: sSjL5A1MzCFdAC5aqC5Re2Xc406P5tVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAxOSBTYWx0ZWRfX+k3Pm42FEVT1
 xtrIt/5fFfjsw26kwENeeXUk3vBfhabbNWEti0TrzjC87tNbRiI0fGCZE3XjOJYZ6VhQoH5vYLJ
 /1wtmhzqypdk4YT+yB+P0gJRZw2m1hZ1C9cz1MBtDEfw6YJasxVQlHp9YJjHwNg+ydGYvfocd9h
 w7q9mVmmXD7DnnntIMXbM9qy2PQfIWO/9u8EL09qWJ9tIkedXYlD66HY/twsZDWyJqUjA9l+ajw
 V7oVeUG8b4z2NMV/ZsqjrAXAc4DLyFj/jtmkHb7yyhgpGAJ89k03FZ/GtEZH3FnE6CmMJ3EBoZK
 UlKmfdvMHvduqeM3V1K+fOWUcZSLB08nnDtTtQkaQowd746WvA8pe3W+qwIUjPDg5+Vtt0EJ3eF
 oCyITCD5pgNnWyj/WbDBYBQ0zbsbQA==
X-Proofpoint-ORIG-GUID: sSjL5A1MzCFdAC5aqC5Re2Xc406P5tVF
X-Authority-Analysis: v=2.4 cv=ZOnaWH7b c=1 sm=1 tr=0 ts=68db424f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=TLlWb1-QvcHgbv-9-S0A:9
 a=QEXdDO2ut3YA:10

On Tue, 02 Sep 2025 21:23:40 +0800, Liao Yuanhong wrote:

> For ternary operators in the form of "a ? true : false" or
> "a ? false : true", if 'a' itself returns a boolean result, the ternary
> operator can be omitted. Remove redundant ternary operators to clean up the
> code.
> 
> Liao Yuanhong (6):
>   scsi: arcmsr: Remove redundant ternary operators
>   scsi: csiostor: Remove redundant ternary operators
>   scsi: isci: Remove redundant ternary operators
>   scsi: megaraid_sas: Remove redundant ternary operators
>   scsi: scsi_transport_fc: Remove redundant ternary operators
>   scsi: storvsc: Remove redundant ternary operators
> 
> [...]

Applied to 6.18/scsi-queue, thanks!

[6/6] scsi: storvsc: Remove redundant ternary operators
      https://git.kernel.org/mkp/scsi/c/15968590f07c

-- 
Martin K. Petersen

