Return-Path: <linux-hyperv+bounces-5817-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B4AD2BC3
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 04:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066003AD3E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 02:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48817C21E;
	Tue, 10 Jun 2025 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iusrr9xo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97A1624E5;
	Tue, 10 Jun 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521319; cv=none; b=UAMx6Y4nukDY/BaI3FQtN8TPbxpYR1kAMIpRTHuPIouBFfD8CJQryfvJsVL6Tqdb978eKvwv5jjNTI6sUd0QbkBIRgfjCwwWSb1eH3ZrKS6+vOYDiB5vcxQ8bQzgmvMogjIRj5srMLpjIf3pVywmz//z19yDlhRmugIYsREzylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521319; c=relaxed/simple;
	bh=pFK1rxrVlId8RG7xg4WdxocrCGY9gGEthLO82ScbDnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EF0hCDeTgV+0MVANVgSgFllrIciREzoXGkvytOMXFQolxnO31V/Xm5Kfii8RqLEGIyDAM/UogLHcWyu+yLfL64WQr+OcQarQHwifUIAb4lwy8y78dKSVO4T8kAw/Vmy+cATG7puYHdvs6rfO3PLIT0bIzznflgD+BtJMx7rgWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iusrr9xo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FYbDj006885;
	Tue, 10 Jun 2025 02:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JUyqZBAzWYlfXy6XMTgQSIQERQpzKbL5PVmI8AzaYes=; b=
	Iusrr9xotH1Jpv/0t0rRODvIcKicZZLjDLTWe1TibUIEaabPkzg0jfArOZyE5Xl5
	g2mZWfn1BWu9U79I9tzO45SMhP1XQDOm9XDuUOyuv49Y1OYlBCphORxkHtKSq9dG
	2/jSm6n5V9mpB75jqMVVaiO7kvDOT5WVq8YHnHn5xmu8vThuSI7uIZPacRuzaFhJ
	Kcfh5F2Yil6HI0eZ2kfWEqVT1ix2cfym+V6QtMI+T1yuOzOLVi/aO43nEf8Flp1V
	I4sVxZpNsrRscgdiRWSevbNeuAvyM4cwRK50tk7XfcxM3tF30xMk2oU9t5ymCYfF
	ioakGx3R0teJ8QR2fEaD4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjtm6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 02:08:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55A1pR37007367;
	Tue, 10 Jun 2025 02:08:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7vr06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 02:08:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55A26ugc001728;
	Tue, 10 Jun 2025 02:08:31 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv7vquh-1;
	Tue, 10 Jun 2025 02:08:31 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, longli@microsoft.com,
        linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, stable@kernel.org
Subject: Re: [PATCH] scsi: storvsc: Increase the timeouts to storvsc_timeout
Date: Mon,  9 Jun 2025 22:07:36 -0400
Message-ID: <174952124901.1235337.4567244349908648438.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1749243459-10419-1-git-send-email-decui@microsoft.com>
References: <1749243459-10419-1-git-send-email-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_01,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100015
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684793a2 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=2I0cK5IvEajveI9R3G8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDAxNSBTYWx0ZWRfX3JqJ9GFINucp vOpy9yvleIRhmfZfGxfT2nUq1Bbjzj4YXmDArdOzZpmXI9KN8nEQx4/4h83H8+nkE1Oz9+kjrOm 720PjzMu1qolOqxZFB1lia1IBuWoH05/LYbU2JI7kp8makJL/TkvLnrrKdU0fsaTIm8yZYu/PNQ
 wSSVrJxrTAWW1jHk4q1cmuIiqghadwEbBLhYSoprMX3ECs7OFDcp0OZud05oNVix/UcKvTdftDC VUFQa7s2shTd5uYMzkQLipZwNvGhmDzXfh57o1s7NF5QYTlsHCbq3RkcLL51DU6ZQwFFh1e4RWC o/uTAenq81fyxOosVQPGMlOd9xXKfFWnaFhLLQP61A+4PL/GfAJdHdXzqmBQSO1cQLDPf+3GayQ
 wyjKfMT/nmYlsoYCgGit1k9OHM0AJeU+OOJnugdXg8W+Dxwuj4nHd2ZO0dxU4tVy4kt5HLAV
X-Proofpoint-ORIG-GUID: jHFpknroR-ITkKir1hua2EKvow3vubfC
X-Proofpoint-GUID: jHFpknroR-ITkKir1hua2EKvow3vubfC

On Fri, 06 Jun 2025 13:57:39 -0700, Dexuan Cui wrote:

> Currently storvsc_timeout is only used in storvsc_sdev_configure(), and
> 5s and 10s are used elsewhere. It turns out that rarely the 5s is not
> enough on Azure, so let's use storvsc_timeout everywhere.
> 
> In case a timeout happens and storvsc_channel_init() returns an error,
> close the VMBus channel so that any host-to-guest messages in the
> channel's ringbuffer, which might come late, can be safely ignored.
> 
> [...]

Applied to 6.16/scsi-fixes, thanks!

[1/1] scsi: storvsc: Increase the timeouts to storvsc_timeout
      https://git.kernel.org/mkp/scsi/c/b2f966568faa

-- 
Martin K. Petersen	Oracle Linux Engineering

